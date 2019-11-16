Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF595FF02F
	for <lists+linux-spi@lfdr.de>; Sat, 16 Nov 2019 17:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730873AbfKPPv5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 16 Nov 2019 10:51:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:60780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729101AbfKPPv4 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 16 Nov 2019 10:51:56 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DC8520871;
        Sat, 16 Nov 2019 15:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919515;
        bh=s2LUJTlH2b8bor8yGbp1D5PinA4o68e3evDwW893gJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k4fIYSS2LGN9lB/bKn68vu8um7Buxq66UqQN8jscgnUo2Ud1HJusZUsSzuAEpku7O
         W7N22BbCBmh5GoqSsmjO9dcYBVlUkuWz8RHxQRDPaiIRJVioCOutlbaJJ8wHEYNttv
         e4f6IP8GH6EyBg/YLzCLmQZVEJ592LN65/OTrT8A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vignesh R <vigneshr@ti.com>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 37/99] spi: omap2-mcspi: Set FIFO DMA trigger level to word length
Date:   Sat, 16 Nov 2019 10:50:00 -0500
Message-Id: <20191116155103.10971-37-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116155103.10971-1-sashal@kernel.org>
References: <20191116155103.10971-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vignesh R <vigneshr@ti.com>

[ Upstream commit b682cffa3ac6d9d9e16e9b413c45caee3b391fab ]

McSPI has 32 byte FIFO in Transmit-Receive mode. Current code tries to
configuration FIFO watermark level for DMA trigger to be GCD of transfer
length and max FIFO size which would mean trigger level may be set to 32
for transmit-receive mode if length is aligned. This does not work in
case of SPI slave mode where FIFO always needs to have data ready
whenever master starts the clock. With DMA trigger size of 32 there will
be a small window during slave TX where DMA is still putting data into
FIFO but master would have started clock for next byte, resulting in
shifting out of stale data. Similarly, on Slave RX side there may be RX
FIFO overflow
Fix this by setting FIFO watermark for DMA trigger to word
length. This means DMA is triggered as soon as FIFO has space for word
length bytes and DMA would make sure FIFO is almost always full
therefore improving FIFO occupancy in both master and slave mode.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-omap2-mcspi.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index a47cf638460a6..bc136fe3a2829 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -298,7 +298,7 @@ static void omap2_mcspi_set_fifo(const struct spi_device *spi,
 	struct omap2_mcspi_cs *cs = spi->controller_state;
 	struct omap2_mcspi *mcspi;
 	unsigned int wcnt;
-	int max_fifo_depth, fifo_depth, bytes_per_word;
+	int max_fifo_depth, bytes_per_word;
 	u32 chconf, xferlevel;
 
 	mcspi = spi_master_get_devdata(master);
@@ -314,10 +314,6 @@ static void omap2_mcspi_set_fifo(const struct spi_device *spi,
 		else
 			max_fifo_depth = OMAP2_MCSPI_MAX_FIFODEPTH;
 
-		fifo_depth = gcd(t->len, max_fifo_depth);
-		if (fifo_depth < 2 || fifo_depth % bytes_per_word != 0)
-			goto disable_fifo;
-
 		wcnt = t->len / bytes_per_word;
 		if (wcnt > OMAP2_MCSPI_MAX_FIFOWCNT)
 			goto disable_fifo;
@@ -325,16 +321,17 @@ static void omap2_mcspi_set_fifo(const struct spi_device *spi,
 		xferlevel = wcnt << 16;
 		if (t->rx_buf != NULL) {
 			chconf |= OMAP2_MCSPI_CHCONF_FFER;
-			xferlevel |= (fifo_depth - 1) << 8;
+			xferlevel |= (bytes_per_word - 1) << 8;
 		}
+
 		if (t->tx_buf != NULL) {
 			chconf |= OMAP2_MCSPI_CHCONF_FFET;
-			xferlevel |= fifo_depth - 1;
+			xferlevel |= bytes_per_word - 1;
 		}
 
 		mcspi_write_reg(master, OMAP2_MCSPI_XFERLEVEL, xferlevel);
 		mcspi_write_chconf0(spi, chconf);
-		mcspi->fifo_depth = fifo_depth;
+		mcspi->fifo_depth = max_fifo_depth;
 
 		return;
 	}
@@ -601,7 +598,6 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 	struct dma_slave_config	cfg;
 	enum dma_slave_buswidth width;
 	unsigned es;
-	u32			burst;
 	void __iomem		*chstat_reg;
 	void __iomem            *irqstat_reg;
 	int			wait_res;
@@ -623,22 +619,14 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 	}
 
 	count = xfer->len;
-	burst = 1;
-
-	if (mcspi->fifo_depth > 0) {
-		if (count > mcspi->fifo_depth)
-			burst = mcspi->fifo_depth / es;
-		else
-			burst = count / es;
-	}
 
 	memset(&cfg, 0, sizeof(cfg));
 	cfg.src_addr = cs->phys + OMAP2_MCSPI_RX0;
 	cfg.dst_addr = cs->phys + OMAP2_MCSPI_TX0;
 	cfg.src_addr_width = width;
 	cfg.dst_addr_width = width;
-	cfg.src_maxburst = burst;
-	cfg.dst_maxburst = burst;
+	cfg.src_maxburst = es;
+	cfg.dst_maxburst = es;
 
 	rx = xfer->rx_buf;
 	tx = xfer->tx_buf;
-- 
2.20.1

