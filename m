Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450CB1E5D10
	for <lists+linux-spi@lfdr.de>; Thu, 28 May 2020 12:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387866AbgE1KYC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 May 2020 06:24:02 -0400
Received: from mga17.intel.com ([192.55.52.151]:64683 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387809AbgE1KX5 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 28 May 2020 06:23:57 -0400
IronPort-SDR: J7zbEC+/tX7SyZSsiNezgY24LQMqZGzSCqhI2ODwTiFcJit2+YQFbPVxwT6PKEXZVMQ3et68Ty
 /nHH4sbItLXA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 03:23:14 -0700
IronPort-SDR: pnv75b7kshvgiu5zJtVWb39dvaZnaSj74XGj9SBSiSq0P8oQMWzHYImbTWARQGjRfc0MHvjJYt
 5/4juJZeO4+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,444,1583222400"; 
   d="scan'208";a="256117613"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 28 May 2020 03:23:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 949F3101; Thu, 28 May 2020 13:23:11 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] spi: dw: Refactor mid_spi_dma_setup() to separate DMA and IRQ config
Date:   Thu, 28 May 2020 13:23:11 +0300
Message-Id: <20200528102311.79948-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528102311.79948-1-andriy.shevchenko@linux.intel.com>
References: <20200528102311.79948-1-andriy.shevchenko@linux.intel.com>
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
 drivers/spi/spi-dw-mid.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index 0fd7543dc91a..20c07f7760ef 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -245,17 +245,17 @@ static int mid_spi_dma_setup(struct dw_spi *dws, struct spi_transfer *xfer)
 	dw_writel(dws, DW_SPI_DMARDLR, 0xf);
 	dw_writel(dws, DW_SPI_DMATDLR, 0x10);
 
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
 
 	dws->transfer_handler = dma_transfer;
-- 
2.26.2

