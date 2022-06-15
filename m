Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C4554C8E1
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jun 2022 14:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347168AbiFOMrx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jun 2022 08:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348480AbiFOMrs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jun 2022 08:47:48 -0400
Received: from smtp16.bhosted.nl (smtp16.bhosted.nl [IPv6:2a02:9e0:8000::27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82558DFF2
        for <linux-spi@vger.kernel.org>; Wed, 15 Jun 2022 05:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
         subject:cc:to:from:from;
        bh=x60HFrKjnppGazO22bsYW+VPDYInuEcfatYuqW3ZS/Y=;
        b=NTW9a7sJj1dd4YCYMvQLTmgCDSo1kO4qnCeu5xsA37ROYr3My/4VAgMU3hnblKQjvI/7/hUzgBGQN
         3LXQCooZ9cAxmkou7u9AIgClzT4Clzxcb/aE42JoNSsRC6pOSLvevhwY32zQk+DWQD9dJ3YHuYYdaF
         C0CyRiM9qJCFUtZMfyySSCcErgI1uF5mUeOklQCsP6ENa+GCF5vpF09uX4wj+vNSh2Jf9Z+2kKaPMJ
         GyUZ1APeHHFL/BJ5NWy7IqqDW7OvfGYJUj5fdEpbsqhs65jRNQDeqFolGvFzlHKKDOqLl9cK/WLtCS
         JUjhUHgNVieiT+huxIZDAFUqafyqCyg==
X-MSG-ID: 533add73-eca9-11ec-9051-0050569d2c73
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>, David Jander <david@protonic.nl>
Subject: [RFC] [PATCH v2 04/11] spi: __spi_pump_messages: Consolidate spin_unlocks to goto target
Date:   Wed, 15 Jun 2022 14:46:27 +0200
Message-Id: <20220615124634.3302867-5-david@protonic.nl>
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

