Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59605552AD0
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jun 2022 08:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345601AbiFUGMo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Jun 2022 02:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiFUGMo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Jun 2022 02:12:44 -0400
Received: from smtp15.bhosted.nl (smtp15.bhosted.nl [IPv6:2a02:9e0:8000::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BA61C121
        for <linux-spi@vger.kernel.org>; Mon, 20 Jun 2022 23:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
         subject:cc:to:from:from;
        bh=H4ti9M99B6lVzGb3ljKte2Ib95Nd6XVISFe9+7VW/Zk=;
        b=M4TFpv0RZ6bPiodd9R3E8itFA9cBmaWzOlKV0aei9OM8riITdIFMDtzG+YtDZ46NlUnabnrr/H+NR
         7wHVmDQQGOERdAF44592ky2Jl2WUXzHCNXVGOFBz7ZnhTSWbFC8VlEPNN2xBT7VOXKNI5DEf7DdgeC
         FT3HqNzw0f4Y3+E8neRBk1ID8SwX9lLGc6/7PgzbbhYxlGxTDOxiyNw0fGHTBDUg0pxvjIEdIkbWEO
         OsMR0gH47LVcMOTGjgoOGqPtz+eMNO5ChUEdpcQAEYFUvmiL/7/5iHdPYfh5AlBaLdXU7vED/egQoa
         iX3zV4WqRA7RnZJ4UDCucpgLuG0haEQ==
X-MSG-ID: 2603acfa-f129-11ec-ba03-0050569d3a82
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>, David Jander <david@protonic.nl>
Subject: [PATCH v3 03/11] spi: Lock controller idling transition inside the io_mutex
Date:   Tue, 21 Jun 2022 08:12:26 +0200
Message-Id: <20220621061234.3626638-4-david@protonic.nl>
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

This way, the spi sync path does not need to deal with the idling
transition.

Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/spi/spi.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 2d057d03c4f7..cfff2ff96fa0 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1643,27 +1643,30 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 	unsigned long flags;
 	int ret;
 
+	/* Take the IO mutex */
+	mutex_lock(&ctlr->io_mutex);
+
 	/* Lock queue */
 	spin_lock_irqsave(&ctlr->queue_lock, flags);
 
 	/* Make sure we are not already running a message */
 	if (ctlr->cur_msg) {
 		spin_unlock_irqrestore(&ctlr->queue_lock, flags);
-		return;
+		goto out_unlock;
 	}
 
 	/* If another context is idling the device then defer */
 	if (ctlr->idling) {
 		kthread_queue_work(ctlr->kworker, &ctlr->pump_messages);
 		spin_unlock_irqrestore(&ctlr->queue_lock, flags);
-		return;
+		goto out_unlock;
 	}
 
 	/* Check if the queue is idle */
 	if (list_empty(&ctlr->queue) || !ctlr->running) {
 		if (!ctlr->busy) {
 			spin_unlock_irqrestore(&ctlr->queue_lock, flags);
-			return;
+			goto out_unlock;
 		}
 
 		/* Defer any non-atomic teardown to the thread */
@@ -1679,7 +1682,7 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 						   &ctlr->pump_messages);
 			}
 			spin_unlock_irqrestore(&ctlr->queue_lock, flags);
-			return;
+			goto out_unlock;
 		}
 
 		ctlr->busy = false;
@@ -1701,7 +1704,7 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 		ctlr->idling = false;
 		ctlr->queue_empty = true;
 		spin_unlock_irqrestore(&ctlr->queue_lock, flags);
-		return;
+		goto out_unlock;
 	}
 
 	/* Extract head of queue */
@@ -1715,13 +1718,16 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 		ctlr->busy = true;
 	spin_unlock_irqrestore(&ctlr->queue_lock, flags);
 
-	mutex_lock(&ctlr->io_mutex);
 	ret = __spi_pump_transfer_message(ctlr, msg, was_busy);
 	mutex_unlock(&ctlr->io_mutex);
 
 	/* Prod the scheduler in case transfer_one() was busy waiting */
 	if (!ret)
 		cond_resched();
+	return;
+
+out_unlock:
+	mutex_unlock(&ctlr->io_mutex);
 }
 
 /**
-- 
2.32.0

