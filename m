Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100C354C8E5
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jun 2022 14:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348480AbiFOMry (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jun 2022 08:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348534AbiFOMrs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jun 2022 08:47:48 -0400
Received: from smtp15.bhosted.nl (smtp15.bhosted.nl [IPv6:2a02:9e0:8000::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828CFE017
        for <linux-spi@vger.kernel.org>; Wed, 15 Jun 2022 05:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
         subject:cc:to:from:from;
        bh=pCfD1n1XsGzmFuTRiNWt50/YhUvtppaL5IsTk3NIMGc=;
        b=OhlSdw9M5XbBTBbMQSXmidsemFLeYTPxSZk9LFO0K+/rmvTeNpCmiqXpv2+Q7rZYH8ZT6RKO9k8if
         XeZTCRRclSYREVHvyCp0xjoRQcmS1gGnQr3bXFYzpdn1shldbOdLtcSgUnpBkULce/P9sMv+FyPr6l
         loSwTuXfbauhFMZSmOrgrC+4iGCF7jG72Bbg6+PzIcbtXNwcSoYIHSp4aC3I+duh8WdSgw3kxWrINk
         zmfBOkCaAK/1phVdyEzs1w3emBXaJw9rklXX1mDg6mSsGvkCHPJyVAw+pWhg9cWrjp7A5f/pgz8TeZ
         h1379tgA7CaTMYkYpNu+oq5cmWW7pmQ==
X-MSG-ID: 530efc0b-eca9-11ec-ba03-0050569d3a82
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>, David Jander <david@protonic.nl>
Subject: [RFC] [PATCH v2 01/11] spi: Move ctlr->cur_msg_prepared to struct spi_message
Date:   Wed, 15 Jun 2022 14:46:24 +0200
Message-Id: <20220615124634.3302867-2-david@protonic.nl>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220615124634.3302867-1-david@protonic.nl>
References: <20220615124634.3302867-1-david@protonic.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This enables the possibility to transfer a message that is not at the
current tip of the async message queue.
This is in preparation of the next patch(es) which enable spi_sync messages
to skip the queue altogether.

Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/spi/spi.c       | 7 ++++---
 include/linux/spi/spi.h | 7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index c78d1ceeaa42..eb6360153fa1 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1684,7 +1684,7 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 			spi_finalize_current_message(ctlr);
 			goto out;
 		}
-		ctlr->cur_msg_prepared = true;
+		msg->prepared = true;
 	}
 
 	ret = spi_map_msg(ctlr, msg);
@@ -1926,7 +1926,7 @@ void spi_finalize_current_message(struct spi_controller *ctlr)
 	 */
 	spi_res_release(ctlr, mesg);
 
-	if (ctlr->cur_msg_prepared && ctlr->unprepare_message) {
+	if (mesg->prepared && ctlr->unprepare_message) {
 		ret = ctlr->unprepare_message(ctlr, mesg);
 		if (ret) {
 			dev_err(&ctlr->dev, "failed to unprepare message: %d\n",
@@ -1934,9 +1934,10 @@ void spi_finalize_current_message(struct spi_controller *ctlr)
 		}
 	}
 
+	mesg->prepared = false;
+
 	spin_lock_irqsave(&ctlr->queue_lock, flags);
 	ctlr->cur_msg = NULL;
-	ctlr->cur_msg_prepared = false;
 	ctlr->fallback = false;
 	kthread_queue_work(ctlr->kworker, &ctlr->pump_messages);
 	spin_unlock_irqrestore(&ctlr->queue_lock, flags);
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index c96f526d9a20..1a75c26742f2 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -385,8 +385,6 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  * @queue: message queue
  * @idling: the device is entering idle state
  * @cur_msg: the currently in-flight message
- * @cur_msg_prepared: spi_prepare_message was called for the currently
- *                    in-flight message
  * @cur_msg_mapped: message has been mapped for DMA
  * @last_cs: the last chip_select that is recorded by set_cs, -1 on non chip
  *           selected
@@ -621,7 +619,6 @@ struct spi_controller {
 	bool				running;
 	bool				rt;
 	bool				auto_runtime_pm;
-	bool                            cur_msg_prepared;
 	bool				cur_msg_mapped;
 	char				last_cs;
 	bool				last_cs_mode_high;
@@ -988,6 +985,7 @@ struct spi_transfer {
  * @queue: for use by whichever driver currently owns the message
  * @state: for use by whichever driver currently owns the message
  * @resources: for resource management when the spi message is processed
+ * @prepared: spi_prepare_message was called for the this message
  *
  * A @spi_message is used to execute an atomic sequence of data transfers,
  * each represented by a struct spi_transfer.  The sequence is "atomic"
@@ -1037,6 +1035,9 @@ struct spi_message {
 
 	/* list of spi_res reources when the spi message is processed */
 	struct list_head        resources;
+
+	/* spi_prepare_message was called for this message */
+	bool                    prepared;
 };
 
 static inline void spi_message_init_no_memset(struct spi_message *m)
-- 
2.32.0

