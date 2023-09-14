Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E9D79F6A0
	for <lists+linux-spi@lfdr.de>; Thu, 14 Sep 2023 03:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233989AbjINBzb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Sep 2023 21:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbjINBzW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 Sep 2023 21:55:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0035E1FC6;
        Wed, 13 Sep 2023 18:55:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388DFC433CB;
        Thu, 14 Sep 2023 01:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694656515;
        bh=9oR9SSQECGCAQx8w80FvFbcmcZq+svGXSbNFMRRATfQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PyLUmkmy/VGuw7tlaB2ZXto75cXTNGEoH55zSHFzNj23RnFuVCr9+WUhRQtHQ/a+o
         gI59gvoQ6tC++6aVv5rS/x5cMEMnKSCqYXATROToif0nvlgE9UGXqovhfNoI1tKH78
         8Pe9tPhpfjJYugDbeXnxu8j81KVb8xxtGjG2C3BltBcVkQ0qLbHqfGlK6jU0W5qMHn
         LYmjYKn7pNFeh6LXLNAmP6ybuRmR6GyXU8TaQJoROfxAWKDEVayaJ+1K62aXHfsf/G
         Pw+racipnJzqGqcyySEVESuVm/mZRzr7kHc6GRJ5m9fWTVX2XESlYhcdOmeSJXUdGJ
         ODSoDRlU1Qs4g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tobias Schramm <t.schramm@manjaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH AUTOSEL 6.5 7/7] spi: sun6i: fix race between DMA RX transfer completion and RX FIFO drain
Date:   Wed, 13 Sep 2023 21:54:51 -0400
Message-Id: <20230914015459.51740-7-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914015459.51740-1-sashal@kernel.org>
References: <20230914015459.51740-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.3
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Tobias Schramm <t.schramm@manjaro.org>

[ Upstream commit 1f11f4202caf5710204d334fe63392052783876d ]

Previously the transfer complete IRQ immediately drained to RX FIFO to
read any data remaining in FIFO to the RX buffer. This behaviour is
correct when dealing with SPI in interrupt mode. However in DMA mode the
transfer complete interrupt still fires as soon as all bytes to be
transferred have been stored in the FIFO. At that point data in the FIFO
still needs to be picked up by the DMA engine. Thus the drain procedure
and DMA engine end up racing to read from RX FIFO, corrupting any data
read. Additionally the RX buffer pointer is never adjusted according to
DMA progress in DMA mode, thus calling the RX FIFO drain procedure in DMA
mode is a bug.
Fix corruptions in DMA RX mode by draining RX FIFO only in interrupt mode.
Also wait for completion of RX DMA when in DMA mode before returning to
ensure all data has been copied to the supplied memory buffer.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
Link: https://lore.kernel.org/r/20230827152558.5368-3-t.schramm@manjaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-sun6i.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 8fcb2696ec099..57c828e73c446 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -102,6 +102,7 @@ struct sun6i_spi {
 	struct reset_control	*rstc;
 
 	struct completion	done;
+	struct completion	dma_rx_done;
 
 	const u8		*tx_buf;
 	u8			*rx_buf;
@@ -196,6 +197,13 @@ static size_t sun6i_spi_max_transfer_size(struct spi_device *spi)
 	return SUN6I_MAX_XFER_SIZE - 1;
 }
 
+static void sun6i_spi_dma_rx_cb(void *param)
+{
+	struct sun6i_spi *sspi = param;
+
+	complete(&sspi->dma_rx_done);
+}
+
 static int sun6i_spi_prepare_dma(struct sun6i_spi *sspi,
 				 struct spi_transfer *tfr)
 {
@@ -220,6 +228,8 @@ static int sun6i_spi_prepare_dma(struct sun6i_spi *sspi,
 						 DMA_PREP_INTERRUPT);
 		if (!rxdesc)
 			return -EINVAL;
+		rxdesc->callback_param = sspi;
+		rxdesc->callback = sun6i_spi_dma_rx_cb;
 	}
 
 	txdesc = NULL;
@@ -275,6 +285,7 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 		return -EINVAL;
 
 	reinit_completion(&sspi->done);
+	reinit_completion(&sspi->dma_rx_done);
 	sspi->tx_buf = tfr->tx_buf;
 	sspi->rx_buf = tfr->rx_buf;
 	sspi->len = tfr->len;
@@ -459,6 +470,22 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	start = jiffies;
 	timeout = wait_for_completion_timeout(&sspi->done,
 					      msecs_to_jiffies(tx_time));
+
+	if (!use_dma) {
+		sun6i_spi_drain_fifo(sspi);
+	} else {
+		if (timeout && rx_len) {
+			/*
+			 * Even though RX on the peripheral side has finished
+			 * RX DMA might still be in flight
+			 */
+			timeout = wait_for_completion_timeout(&sspi->dma_rx_done,
+							      timeout);
+			if (!timeout)
+				dev_warn(&master->dev, "RX DMA timeout\n");
+		}
+	}
+
 	end = jiffies;
 	if (!timeout) {
 		dev_warn(&master->dev,
@@ -486,7 +513,6 @@ static irqreturn_t sun6i_spi_handler(int irq, void *dev_id)
 	/* Transfer complete */
 	if (status & SUN6I_INT_CTL_TC) {
 		sun6i_spi_write(sspi, SUN6I_INT_STA_REG, SUN6I_INT_CTL_TC);
-		sun6i_spi_drain_fifo(sspi);
 		complete(&sspi->done);
 		return IRQ_HANDLED;
 	}
@@ -644,6 +670,7 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 	}
 
 	init_completion(&sspi->done);
+	init_completion(&sspi->dma_rx_done);
 
 	sspi->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 	if (IS_ERR(sspi->rstc)) {
-- 
2.40.1

