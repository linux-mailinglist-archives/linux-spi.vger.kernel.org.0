Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B017818896
	for <lists+linux-spi@lfdr.de>; Thu,  9 May 2019 12:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfEIKz6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 May 2019 06:55:58 -0400
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]:36350
        "EHLO cgate.sperl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfEIKz6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 May 2019 06:55:58 -0400
Received: from hc1.intern.sperl.org (account martin@sperl.org [10.10.10.59] verified)
  by sperl.org (CommuniGate Pro SMTP 6.2.1 _community_)
  with ESMTPSA id 7764484; Thu, 09 May 2019 10:55:46 +0000
From:   kernel@martin.sperl.org
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Meghana Madhyastha <meghana.madhyastha@gmail.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Mark Brown <broonie@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-spi@vger.kernel.org
Cc:     Martin Sperl <kernel@martin.sperl.org>
Subject: [PATCH V1 3/3] spi: core: make unprepare_message part of spi_message.resource process
Date:   Thu,  9 May 2019 10:55:33 +0000
Message-Id: <20190509105533.24275-4-kernel@martin.sperl.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190509105533.24275-1-kernel@martin.sperl.org>
References: <20190509105533.24275-1-kernel@martin.sperl.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Martin Sperl <kernel@martin.sperl.org>

Move unprepare_message to use the spi_message.resource cleanup process
for invocation with consistent sequence of execution.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/spi/spi.c | 52 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 78fe46bf6f41..24a4e605448a 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1201,6 +1201,23 @@ void spi_finalize_current_transfer(struct spi_controller *ctlr)
 EXPORT_SYMBOL_GPL(spi_finalize_current_transfer);

 /**
+ * __spi_res_unprepare_message - resource management function which
+ * calls unprepare_message
+ * @ctlr: controller for
+ * @msg: the message to unprepare
+ * @res: extra data - ignored
+ */
+static void __spi_res_unprepare_message(struct spi_controller *ctlr,
+					struct spi_message *msg,
+					void *res)
+{
+	int ret = ctlr->unprepare_message(ctlr, msg);
+
+	if (ret)
+		dev_err(&ctlr->dev, "failed to unprepare message: %d\n", ret);
+}
+
+/**
  * __spi_pump_messages - function which processes spi message queue
  * @ctlr: controller to process queue for
  * @in_kthread: true if we are in the context of the message pump thread
@@ -1318,6 +1335,19 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)

 	if (ctlr->prepare_message) {
 		struct list_head *tail = ctlr->cur_msg->resources.prev;
+		void *res = NULL;
+
+		if (ctlr->unprepare_message) {
+			res = spi_res_alloc(ctlr->cur_msg->spi,
+					    __spi_res_unprepare_message, 0,
+					    GFP_KERNEL);
+			if (!res) {
+				ret = -ENOMEM;
+				ctlr->cur_msg->status = ret;
+				spi_finalize_current_message(ctlr);
+				goto out;
+			}
+		}
 		ret = ctlr->prepare_message(ctlr, ctlr->cur_msg);
 		if (ret) {
 			dev_err(&ctlr->dev, "failed to prepare message: %d\n",
@@ -1331,6 +1361,10 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 		    tail != ctlr->cur_msg->resources.prev)
 			dev_warn_once(&ctlr->dev,
 				      "spi_message.resource is modified and unprepare_message is defined - this can give unexpected results during finalize\n");
+		/* we only add the resource late to keep the expected order */
+		if (res)
+			spi_res_add(ctlr->cur_msg, res);
+
 		ctlr->cur_msg_prepared = true;
 	}

@@ -1436,29 +1470,12 @@ void spi_finalize_current_message(struct spi_controller *ctlr)
 {
 	struct spi_message *mesg;
 	unsigned long flags;
-	int ret;

 	spin_lock_irqsave(&ctlr->queue_lock, flags);
 	mesg = ctlr->cur_msg;
 	spin_unlock_irqrestore(&ctlr->queue_lock, flags);

 	spi_unmap_msg(ctlr, mesg);
-
-	if (ctlr->cur_msg_prepared && ctlr->unprepare_message) {
-		ret = ctlr->unprepare_message(ctlr, mesg);
-		if (ret) {
-			dev_err(&ctlr->dev, "failed to unprepare message: %d\n",
-				ret);
-		}
-	}
-
-	/* where to put the release is a slight nightmare because
-	 * ctlr->prepare_message may add to resources as well.
-	 * so the question is: call it before unprepare or after?
-	 * for now leave it after - the asumption here is that
-	 * if prepare_message is using spi_res for callbacks,
-	 * then no unprepare_message is used
-	 */
 	spi_res_release(ctlr, mesg);

 	spin_lock_irqsave(&ctlr->queue_lock, flags);
@@ -3770,4 +3787,3 @@ static int __init spi_init(void)
  * include needing to have boardinfo data structures be much more public.
  */
 postcore_initcall(spi_init);
-
--
2.11.0
