Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664E654C8DF
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jun 2022 14:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347058AbiFOMrw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jun 2022 08:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240141AbiFOMrs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jun 2022 08:47:48 -0400
Received: from smtp28.bhosted.nl (smtp28.bhosted.nl [IPv6:2a02:9e0:8000::40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF133CE3F
        for <linux-spi@vger.kernel.org>; Wed, 15 Jun 2022 05:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
         subject:cc:to:from:from;
        bh=H4ti9M99B6lVzGb3ljKte2Ib95Nd6XVISFe9+7VW/Zk=;
        b=csPsaBko5bqW0jnrIaHfKi3+Z5DJAZ8WbhODSg9hG9pCzfdJ01wrdO4sQDT2lCNvq8654L0m+CZbv
         4UEULy56FxWQjBKwaX/K7dNKeaoEPE6qyDT0NOgmTd/54a4hVQytsBU4V0G6Yxsb7+6ORUU9pCgKJU
         5Vhn38fiEJxz4fAYjzMi1mHlTeuYLQGBAQbPi6PQh+7JrrRPX5rwaRcMmaeSM8VIK/eNP41OKuIa34
         gsNQPstMugQVhWdVMXlYcUgPQW/tXaBViJjudEL+E+gKt5AKjxNfHOVube2HNaI9i44A0812h7yjkK
         yEvcQRd/c1OymRWNYHpf90V23Fz2Qcw==
X-MSG-ID: 532cb81f-eca9-11ec-8a45-0050569d11ae
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>, David Jander <david@protonic.nl>
Subject: [RFC] [PATCH v2 03/11] spi: Lock controller idling transition inside the io_mutex
Date:   Wed, 15 Jun 2022 14:46:26 +0200
Message-Id: <20220615124634.3302867-4-david@protonic.nl>
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

