Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588F054C8E6
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jun 2022 14:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348511AbiFOMrz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jun 2022 08:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348537AbiFOMrs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jun 2022 08:47:48 -0400
Received: from smtp16.bhosted.nl (smtp16.bhosted.nl [IPv6:2a02:9e0:8000::27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829A1E01C
        for <linux-spi@vger.kernel.org>; Wed, 15 Jun 2022 05:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
         subject:cc:to:from:from;
        bh=jg6S3PjeI5qTEyeBZrsTnAtoxgxaUwKcgRhBM8dhK4U=;
        b=rHTeOE4tzt7ZLcoRW1pRINDmnDeVvcgsgC0c7jYVjEfw55H9fGrmr1ZZDQag4GWIa3dd32PhnTEoy
         5l5D1uvwp/9W3Zp/lReZOWruG+7UBgk0yBBLN3HcgrJEhrkpwR3F/C2t3Wf2C0bia0U515jyHOvBy+
         IKwHqzJMx69zCPXpYRTbo6RSDmZBnAxOnbKWftErPpQSGihTkDaRgq8eB8nr0SJqiWCmInp5StUrXC
         YmgKrm+ahbWO9qBDCLmawvFls69qU3VP+HnyZusms/B0lLB4Uks8ZPxl2kHVAWRElDMBjW/02qAKUa
         bI5as1XXqVWUJ9Ee4J9ft7d3nK5fPpA==
X-MSG-ID: 53d59342-eca9-11ec-9051-0050569d2c73
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>, David Jander <david@protonic.nl>
Subject: [RFC] [PATCH v2 11/11] spi: opportunistically skip ctlr->cur_msg_completion
Date:   Wed, 15 Jun 2022 14:46:34 +0200
Message-Id: <20220615124634.3302867-12-david@protonic.nl>
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

There are only a few drivers that do not call
spi_finalize_current_message() in the context of transfer_one_message(),
and even for those cases the completion ctlr->cur_msg_completion is not
needed always. The calls to complete() and wait_for_completion() each
take a spin-lock, which is costly. This patch makes it possible to avoid
those calls in the big majority of cases, by introducing two flags that
with the help of ordering via barriers can avoid using the completion
safely. In case of a race with the context calling
spi_finalize_current_message(), the scheme errs on the safe side and takes
the completion.
The impact of this patch is worth the effort: On a i.MX8MM SoC, the time
the SPI bus is idle between two consecutive calls to spi_sync(), is
reduced from 19.6us to 16.8us... roughly 15%.

Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/spi/spi.c       | 27 +++++++++++++++++++++++++--
 include/linux/spi/spi.h |  8 ++++++++
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index db08cb868652..ef37f043fd17 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1613,14 +1613,34 @@ static int __spi_pump_transfer_message(struct spi_controller *ctlr,
 		}
 	}
 
+	/*
+	 * Drivers implementation of transfer_one_message() must arrange for
+	 * spi_finalize_current_message() to get called. Most drivers will do
+	 * this in the calling context, but some don't. For those cases, a
+	 * completion is used to guarantee that this function does not return
+	 * until spi_finalize_current_message() is done accessing
+	 * ctlr->cur_msg.
+	 * Use of the following two flags enable to opportunistically skip the
+	 * use of the completion since its use involves expensive spin locks.
+	 * In case of a race with the context that calls
+	 * spi_finalize_current_message() the completion will always be used,
+	 * due to strict ordering of these flags using barriers.
+	 */
+	WRITE_ONCE(ctlr->cur_msg_incomplete, true);
+	WRITE_ONCE(ctlr->cur_msg_need_completion, false);
 	reinit_completion(&ctlr->cur_msg_completion);
+	smp_wmb(); /* make these available to spi_finalize_current_message */
+
 	ret = ctlr->transfer_one_message(ctlr, msg);
 	if (ret) {
 		dev_err(&ctlr->dev,
 			"failed to transfer one message from queue\n");
 		return ret;
 	} else {
-		wait_for_completion(&ctlr->cur_msg_completion);
+		WRITE_ONCE(ctlr->cur_msg_need_completion, true);
+		smp_mb(); /* see spi_finalize_current_message()... */
+		if (READ_ONCE(ctlr->cur_msg_incomplete))
+			wait_for_completion(&ctlr->cur_msg_completion);
 	}
 
 	return 0;
@@ -1942,7 +1962,10 @@ void spi_finalize_current_message(struct spi_controller *ctlr)
 
 	mesg->prepared = false;
 
-	complete(&ctlr->cur_msg_completion);
+	WRITE_ONCE(ctlr->cur_msg_incomplete, false);
+	smp_mb(); /* See __spi_pump_transfer_message()... */
+	if (READ_ONCE(ctlr->cur_msg_need_completion))
+		complete(&ctlr->cur_msg_completion);
 
 	trace_spi_message_done(mesg);
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index c56e0d240a58..eb0d316e3c36 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -385,6 +385,12 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  * @queue: message queue
  * @cur_msg: the currently in-flight message
  * @cur_msg_completion: a completion for the current in-flight message
+ * @cur_msg_incomplete: Flag used internally to opportunistically skip
+ *	the @cur_msg_completion. This flag is used to check if the driver has
+ *	already called spi_finalize_current_message().
+ * @cur_msg_need_completion: Flag used internally to opportunistically skip
+ *	the @cur_msg_completion. This flag is used to signal the context that
+ *	is running spi_finalize_current_message() that it needs to complete()
  * @cur_msg_mapped: message has been mapped for DMA
  * @last_cs: the last chip_select that is recorded by set_cs, -1 on non chip
  *           selected
@@ -617,6 +623,8 @@ struct spi_controller {
 	struct list_head		queue;
 	struct spi_message		*cur_msg;
 	struct completion               cur_msg_completion;
+	bool				cur_msg_incomplete;
+	bool				cur_msg_need_completion;
 	bool				busy;
 	bool				running;
 	bool				rt;
-- 
2.32.0

