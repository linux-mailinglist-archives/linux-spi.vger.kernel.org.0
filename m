Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E33533F2F
	for <lists+linux-spi@lfdr.de>; Wed, 25 May 2022 16:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbiEYO3t (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 May 2022 10:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240842AbiEYO3p (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 25 May 2022 10:29:45 -0400
Received: from smtp28.bhosted.nl (smtp28.bhosted.nl [IPv6:2a02:9e0:8000::40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36891146B
        for <linux-spi@vger.kernel.org>; Wed, 25 May 2022 07:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
         subject:cc:to:from:from;
        bh=QrKJWjqs9NsVEooyu9XYJGYXXQZawkLyNMYW0wNmM6o=;
        b=Q09woUoZSsJdorLRL91DsXcA7A1UIa8CL3phjkvCqOutoYthv5XBc+coUhz+SqLVzZy5DIT71WU1/
         o3NaSMdYqQ1Z31dpXznNRTZMQs+xILNfY2rtrkG2Y9uAbN/jSo+ibE5/s2/KI1fZw9KYtY8vK4fnpl
         UZyb0n8LPizgUgt1o8vHy98zCsb2cao6EBvW/0bbnVCtyywpf4Vl8jbmEc0QVnnzcWBOXrJus29QIt
         1GOxQSUztuQmmTtK8AzSIFTc9gWUgDtPdbaIFsB3F79gqEaJReS6VgCdFiXqLo2u0DElyHZ5M6JElV
         c8prO3HQR4ACCEzjMjzymn63M66LGjQ==
X-MSG-ID: 1c6dd2a9-dc37-11ec-a2aa-0050569d11ae
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: [RFC] [PATCH 2/3] drivers: spi: spi.c: Move ctlr->cur_msg_prepared to struct spi_message
Date:   Wed, 25 May 2022 16:29:27 +0200
Message-Id: <20220525142928.2335378-3-david@protonic.nl>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220525142928.2335378-1-david@protonic.nl>
References: <20220525142928.2335378-1-david@protonic.nl>
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
index 89c7d507f38f..1d50051f3d57 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1694,7 +1694,7 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 			spi_finalize_message(msg);
 			goto out;
 		}
-		ctlr->cur_msg_prepared = true;
+		msg->prepared = true;
 	}
 
 	ret = spi_map_msg(ctlr, msg);
@@ -1931,7 +1931,7 @@ void spi_finalize_message(struct spi_message *mesg)
 	 */
 	spi_res_release(ctlr, mesg);
 
-	if (ctlr->cur_msg_prepared && ctlr->unprepare_message) {
+	if (mesg->prepared && ctlr->unprepare_message) {
 		ret = ctlr->unprepare_message(ctlr, mesg);
 		if (ret) {
 			dev_err(&ctlr->dev, "failed to unprepare message: %d\n",
@@ -1939,9 +1939,10 @@ void spi_finalize_message(struct spi_message *mesg)
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
index 58fc2ed03758..43ec1e262913 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -374,8 +374,6 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  * @queue: message queue
  * @idling: the device is entering idle state
  * @cur_msg: the currently in-flight message
- * @cur_msg_prepared: spi_prepare_message was called for the currently
- *                    in-flight message
  * @cur_msg_mapped: message has been mapped for DMA
  * @last_cs: the last chip_select that is recorded by set_cs, -1 on non chip
  *           selected
@@ -609,7 +607,6 @@ struct spi_controller {
 	bool				running;
 	bool				rt;
 	bool				auto_runtime_pm;
-	bool                            cur_msg_prepared;
 	bool				cur_msg_mapped;
 	char				last_cs;
 	bool				last_cs_mode_high;
@@ -976,6 +973,7 @@ struct spi_transfer {
  * @queue: for use by whichever driver currently owns the message
  * @state: for use by whichever driver currently owns the message
  * @resources: for resource management when the spi message is processed
+ * @prepared: spi_prepare_message was called for the this message
  *
  * A @spi_message is used to execute an atomic sequence of data transfers,
  * each represented by a struct spi_transfer.  The sequence is "atomic"
@@ -1025,6 +1023,9 @@ struct spi_message {
 
 	/* list of spi_res reources when the spi message is processed */
 	struct list_head        resources;
+
+	/* spi_prepare_message was called for this message */
+	bool                    prepared;
 };
 
 static inline void spi_message_init_no_memset(struct spi_message *m)
-- 
2.32.0

