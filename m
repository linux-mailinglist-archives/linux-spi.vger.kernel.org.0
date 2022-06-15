Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BBD54C8E3
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jun 2022 14:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348448AbiFOMry (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jun 2022 08:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348456AbiFOMrs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jun 2022 08:47:48 -0400
Received: from smtp16.bhosted.nl (smtp16.bhosted.nl [IPv6:2a02:9e0:8000::27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82657DFF3
        for <linux-spi@vger.kernel.org>; Wed, 15 Jun 2022 05:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
         subject:cc:to:from:from;
        bh=SgpqjMAEVJLKSwqAw6RLOsp1PydTE3FJ3MKPVMhSyRY=;
        b=PaWG1q6o7veSJZn09dKW7JxVRiPta/ZUxWnMIRdO5zbyFjBIho8a6Z+VTCb2UoTXEtoRwp79YGUGO
         cxPrxQpXdLbpOWh0ctzQvRQukhXr9NkqdEXwvB10pPxUqHVhiV2gS9ll/UFMgWxXFp5blDpMjnlhTA
         zaF8P6WaZFlgzRqCL5JJSA9S6h7nUqrdaKN1iNJhJZjYyEIX7Uf7r83czFdNVsHfLDnIYpoTJZKEpQ
         ZUb0D2DYeUf6xltLQqykvmo0GmdD2zw0zp/NMVYHeN+HR2XjTMhUQs643pIOursHq+ESHiuTiQ8y1g
         +t6uwvAZnG9mVs9hsUrJzyOEY6Qi8tg==
X-MSG-ID: 53a6bb85-eca9-11ec-9051-0050569d2c73
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>, David Jander <david@protonic.nl>
Subject: [RFC] [PATCH v2 07/11] spi: Remove the now unused ctlr->idling flag
Date:   Wed, 15 Jun 2022 14:46:30 +0200
Message-Id: <20220615124634.3302867-8-david@protonic.nl>
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

The ctlr->idling flag is never checked now, so we don't need to set it
either.

Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/spi/spi.c       | 2 --
 include/linux/spi/spi.h | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 71b767a9ad77..52736e339645 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1674,7 +1674,6 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 		}
 
 		ctlr->busy = false;
-		ctlr->idling = true;
 		spin_unlock_irqrestore(&ctlr->queue_lock, flags);
 
 		kfree(ctlr->dummy_rx);
@@ -1689,7 +1688,6 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 		trace_spi_controller_idle(ctlr);
 
 		spin_lock_irqsave(&ctlr->queue_lock, flags);
-		ctlr->idling = false;
 		ctlr->queue_empty = true;
 		goto out_unlock;
 	}
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 74261a83b5fa..c58f46be762f 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -383,7 +383,6 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  * @pump_messages: work struct for scheduling work to the message pump
  * @queue_lock: spinlock to syncronise access to message queue
  * @queue: message queue
- * @idling: the device is entering idle state
  * @cur_msg: the currently in-flight message
  * @cur_msg_mapped: message has been mapped for DMA
  * @last_cs: the last chip_select that is recorded by set_cs, -1 on non chip
@@ -616,7 +615,6 @@ struct spi_controller {
 	spinlock_t			queue_lock;
 	struct list_head		queue;
 	struct spi_message		*cur_msg;
-	bool				idling;
 	bool				busy;
 	bool				running;
 	bool				rt;
-- 
2.32.0

