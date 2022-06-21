Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0656552AD2
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jun 2022 08:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiFUGMp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Jun 2022 02:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiFUGMo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Jun 2022 02:12:44 -0400
Received: from smtp28.bhosted.nl (smtp28.bhosted.nl [IPv6:2a02:9e0:8000::40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567391A82A
        for <linux-spi@vger.kernel.org>; Mon, 20 Jun 2022 23:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
         subject:cc:to:from:from;
        bh=x60HFrKjnppGazO22bsYW+VPDYInuEcfatYuqW3ZS/Y=;
        b=Bw0D7KtLDm9OgDvWanwZc3s8isC6PZX/dcRq2q7Fa5kuE11hWRQwZIj7FzLkJR8j6VoR7m39sDhAa
         G2pYDMDnqIWAT8njuGIL2ZU83FqjymiJAIMC9yN8YodYonxTW07ReAAIRVz0sN0FzIsv5EFHXXNhvA
         hHl1MHoxfExcxRJblk0tgm/Fwpps6/E/A7SitU+OKlazN7NJyP8yuPMN9Yi7Mhrnu6vsMGkdaLPRJB
         9hxp1FJQ8pmeCBMwi06AEYjQzcMjPpxCrzVeUc7iQeeWuR+XVtNK3CT30Ymapt3Wn0Alg8yQxIJWEV
         klJuyb05+y3iDbThfEmXj3W2OEsowNA==
X-MSG-ID: 26102f44-f129-11ec-8a45-0050569d11ae
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>, David Jander <david@protonic.nl>
Subject: [PATCH v3 04/11] spi: __spi_pump_messages: Consolidate spin_unlocks to goto target
Date:   Tue, 21 Jun 2022 08:12:27 +0200
Message-Id: <20220621061234.3626638-5-david@protonic.nl>
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

Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/spi/spi.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index cfff2ff96fa0..fa2d091d2854 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1650,10 +1650,8 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 	spin_lock_irqsave(&ctlr->queue_lock, flags);
 
 	/* Make sure we are not already running a message */
-	if (ctlr->cur_msg) {
-		spin_unlock_irqrestore(&ctlr->queue_lock, flags);
+	if (ctlr->cur_msg)
 		goto out_unlock;
-	}
 
 	/* If another context is idling the device then defer */
 	if (ctlr->idling) {
@@ -1664,10 +1662,8 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 
 	/* Check if the queue is idle */
 	if (list_empty(&ctlr->queue) || !ctlr->running) {
-		if (!ctlr->busy) {
-			spin_unlock_irqrestore(&ctlr->queue_lock, flags);
+		if (!ctlr->busy)
 			goto out_unlock;
-		}
 
 		/* Defer any non-atomic teardown to the thread */
 		if (!in_kthread) {
@@ -1681,7 +1677,6 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 				kthread_queue_work(ctlr->kworker,
 						   &ctlr->pump_messages);
 			}
-			spin_unlock_irqrestore(&ctlr->queue_lock, flags);
 			goto out_unlock;
 		}
 
@@ -1703,7 +1698,6 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 		spin_lock_irqsave(&ctlr->queue_lock, flags);
 		ctlr->idling = false;
 		ctlr->queue_empty = true;
-		spin_unlock_irqrestore(&ctlr->queue_lock, flags);
 		goto out_unlock;
 	}
 
@@ -1727,6 +1721,7 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 	return;
 
 out_unlock:
+	spin_unlock_irqrestore(&ctlr->queue_lock, flags);
 	mutex_unlock(&ctlr->io_mutex);
 }
 
-- 
2.32.0

