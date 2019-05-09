Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA1418895
	for <lists+linux-spi@lfdr.de>; Thu,  9 May 2019 12:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfEIKz4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 May 2019 06:55:56 -0400
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]:36350
        "EHLO cgate.sperl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfEIKz4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 May 2019 06:55:56 -0400
Received: from hc1.intern.sperl.org (account martin@sperl.org [10.10.10.59] verified)
  by sperl.org (CommuniGate Pro SMTP 6.2.1 _community_)
  with ESMTPSA id 7764483; Thu, 09 May 2019 10:55:46 +0000
From:   kernel@martin.sperl.org
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Meghana Madhyastha <meghana.madhyastha@gmail.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Mark Brown <broonie@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-spi@vger.kernel.org
Cc:     Martin Sperl <kernel@martin.sperl.org>
Subject: [PATCH V1 2/3] spi: core: add a warning when prepare_message uses spi_res and unprepare_message
Date:   Thu,  9 May 2019 10:55:32 +0000
Message-Id: <20190509105533.24275-3-kernel@martin.sperl.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190509105533.24275-1-kernel@martin.sperl.org>
References: <20190509105533.24275-1-kernel@martin.sperl.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Martin Sperl <kernel@martin.sperl.org>

Add a warning about a potential cleanup inconsistency when both
prepare_message and unprepare_message are defined by the bus driver
and prepare_message is using spi_res_add.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/spi/spi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 1dfb19140bbe..78fe46bf6f41 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1317,6 +1317,7 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 	trace_spi_message_start(ctlr->cur_msg);

 	if (ctlr->prepare_message) {
+		struct list_head *tail = ctlr->cur_msg->resources.prev;
 		ret = ctlr->prepare_message(ctlr, ctlr->cur_msg);
 		if (ret) {
 			dev_err(&ctlr->dev, "failed to prepare message: %d\n",
@@ -1325,6 +1326,11 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 			spi_finalize_current_message(ctlr);
 			goto out;
 		}
+		/* warn about possible issues on finalize */
+		if (ctlr->unprepare_message &&
+		    tail != ctlr->cur_msg->resources.prev)
+			dev_warn_once(&ctlr->dev,
+				      "spi_message.resource is modified and unprepare_message is defined - this can give unexpected results during finalize\n");
 		ctlr->cur_msg_prepared = true;
 	}

--
2.11.0
