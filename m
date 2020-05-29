Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B88371E86AC
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 20:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgE2Sby (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 14:31:54 -0400
Received: from mga17.intel.com ([192.55.52.151]:22855 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgE2Sbx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 29 May 2020 14:31:53 -0400
IronPort-SDR: IoDk/JadKMhjszpK7ldj2+OqIlt7fm1aNL3F9+a53ZYcOirEMBoDAbPCnFmrubpOGP7YN95b9o
 T0BW7mVncaRg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2020 11:31:53 -0700
IronPort-SDR: mEuiev5i/jQz8KlYqyT6KV/BgDXAt6MOBx+yN+qw0dv+XrDDId8vMkcX4nSF4RT9K1ZEs30FDV
 1+aEhayg1ODA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,449,1583222400"; 
   d="scan'208";a="376783664"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 29 May 2020 11:31:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3D72D101; Fri, 29 May 2020 21:31:51 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/2] spi: dw: Refactor mid_spi_dma_setup() to separate DMA and IRQ config
Date:   Fri, 29 May 2020 21:31:50 +0300
Message-Id: <20200529183150.44149-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200529183150.44149-1-andriy.shevchenko@linux.intel.com>
References: <20200529183150.44149-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

It's better to understand what bits are set for DMA and for IRQ handling
in mid_spi_dma_setup() if they are grouped accordingly. Thus,
refactor mid_spi_dma_setup() to separate DMA and IRQ configuration.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: rebased against latest spi/for-next

 drivers/spi/spi-dw-dma.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index 53d5257662e8..5986c520b196 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -375,17 +375,17 @@ static int dw_spi_dma_setup(struct dw_spi *dws, struct spi_transfer *xfer)
 	dw_writel(dws, DW_SPI_DMARDLR, dws->rxburst - 1);
 	dw_writel(dws, DW_SPI_DMATDLR, dws->fifo_len - dws->txburst);
 
-	if (xfer->tx_buf) {
+	if (xfer->tx_buf)
 		dma_ctrl |= SPI_DMA_TDMAE;
-		imr |= SPI_INT_TXOI;
-	}
-	if (xfer->rx_buf) {
+	if (xfer->rx_buf)
 		dma_ctrl |= SPI_DMA_RDMAE;
-		imr |= SPI_INT_RXUI | SPI_INT_RXOI;
-	}
 	dw_writel(dws, DW_SPI_DMACR, dma_ctrl);
 
 	/* Set the interrupt mask */
+	if (xfer->tx_buf)
+		imr |= SPI_INT_TXOI;
+	if (xfer->rx_buf)
+		imr |= SPI_INT_RXUI | SPI_INT_RXOI;
 	spi_umask_intr(dws, imr);
 
 	reinit_completion(&dws->dma_completion);
-- 
2.26.2

