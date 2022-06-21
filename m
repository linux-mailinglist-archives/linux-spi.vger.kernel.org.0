Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E719552AD6
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jun 2022 08:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345600AbiFUGMs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Jun 2022 02:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345614AbiFUGMp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Jun 2022 02:12:45 -0400
Received: from smtp16.bhosted.nl (smtp16.bhosted.nl [IPv6:2a02:9e0:8000::27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A541A3A8
        for <linux-spi@vger.kernel.org>; Mon, 20 Jun 2022 23:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
         subject:cc:to:from:from;
        bh=jg6S3PjeI5qTEyeBZrsTnAtoxgxaUwKcgRhBM8dhK4U=;
        b=PO5QPFnEEWImRVVx3mont9gJX77xeNkcWaXl59NTLRltmdDnUggYXxE4D45jJMqn5g2SkQJ4hQsMx
         vmi5BSqvmtWAgA5qtgLm8JBiXtRNwfBU7dpOCQgXAexinFDeF+qJWNb2DzGcYX/A5yxqI6xhKtalS0
         kWgjwfbPtiJLzmo8tY3PMe/tKkxkpdC3mUKprfF9ejyd97N7J+lYLHSrrRs7JzWucjm3ZI/+PKdaWd
         ms1KPf4pJG6mdrgpIVcnHLXRjF9Aw1S2aDmYSmahWLXtwOzGgmf443iEhTST2xzx6q8GJRvuz/kvGx
         yg6oSpRQPvIRqDCEkL7hnkRCc1VyEMw==
X-MSG-ID: 26c95a0c-f129-11ec-9051-0050569d2c73
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>, David Jander <david@protonic.nl>
Subject: [PATCH v3 11/11] spi: opportunistically skip ctlr->cur_msg_completion
Date:   Tue, 21 Jun 2022 08:12:34 +0200
Message-Id: <20220621061234.3626638-12-david@protonic.nl>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220621061234.3626638-1-david@protonic.nl>
References: <20220621061234.3626638-1-david@protonic.nl>
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

