Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09BEF1C5652
	for <lists+linux-spi@lfdr.de>; Tue,  5 May 2020 15:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbgEENH3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 May 2020 09:07:29 -0400
Received: from mga02.intel.com ([134.134.136.20]:12710 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728268AbgEENH3 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 5 May 2020 09:07:29 -0400
IronPort-SDR: sIEbm9s2xiJ+ZgakjmNL0cyHx8+lNTAH8ipx14ufWV5xG8QZ48JIgHEt9FX3JP2XDLXKjnDsfb
 19qDbhWS9QIg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 06:07:28 -0700
IronPort-SDR: QL8Xgt6N1bIWHZ/DGKCHTjs3JIXl0XiRKoadiPAvZF/WOOCF9ZpcVMeoZA/kReWEFSiD6kEJwl
 Lsc+yFrBQDeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,355,1583222400"; 
   d="scan'208";a="277868833"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by orsmga002.jf.intel.com with ESMTP; 05 May 2020 06:07:27 -0700
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     broonie@kernel.org, robh+dt@kernel.org
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH v5 1/7] spi: dw: Fix typo in few registers name
Date:   Tue,  5 May 2020 21:06:12 +0800
Message-Id: <20200505130618.554-2-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200505130618.554-1-wan.ahmad.zainie.wan.mohamad@intel.com>
References: <20200505130618.554-1-wan.ahmad.zainie.wan.mohamad@intel.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch will fix typo in the register name used in the source code,
to be consistent with the register name used in the databook.

Databook: DW_apb_ssi_databook.pdf version 4.01a

Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-dw.c | 18 +++++++++---------
 drivers/spi/spi-dw.h |  8 ++++----
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 2b79c5a983c0..72a1c99ce9e6 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -47,9 +47,9 @@ static ssize_t dw_spi_show_regs(struct file *file, char __user *user_buf,
 	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
 			"=================================\n");
 	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
-			"CTRL0: \t\t0x%08x\n", dw_readl(dws, DW_SPI_CTRL0));
+			"CTRLR0: \t0x%08x\n", dw_readl(dws, DW_SPI_CTRLR0));
 	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
-			"CTRL1: \t\t0x%08x\n", dw_readl(dws, DW_SPI_CTRL1));
+			"CTRLR1: \t0x%08x\n", dw_readl(dws, DW_SPI_CTRLR1));
 	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
 			"SSIENR: \t0x%08x\n", dw_readl(dws, DW_SPI_SSIENR));
 	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
@@ -57,9 +57,9 @@ static ssize_t dw_spi_show_regs(struct file *file, char __user *user_buf,
 	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
 			"BAUDR: \t\t0x%08x\n", dw_readl(dws, DW_SPI_BAUDR));
 	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
-			"TXFTLR: \t0x%08x\n", dw_readl(dws, DW_SPI_TXFLTR));
+			"TXFTLR: \t0x%08x\n", dw_readl(dws, DW_SPI_TXFTLR));
 	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
-			"RXFTLR: \t0x%08x\n", dw_readl(dws, DW_SPI_RXFLTR));
+			"RXFTLR: \t0x%08x\n", dw_readl(dws, DW_SPI_RXFTLR));
 	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
 			"TXFLR: \t\t0x%08x\n", dw_readl(dws, DW_SPI_TXFLR));
 	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
@@ -304,7 +304,7 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 			(((spi->mode & SPI_LOOP) ? 1 : 0) << SPI_SRL_OFFSET))
 		| (chip->tmode << SPI_TMOD_OFFSET);
 
-	dw_writel(dws, DW_SPI_CTRL0, cr0);
+	dw_writel(dws, DW_SPI_CTRLR0, cr0);
 
 	/* Check if current transfer is a DMA transaction */
 	if (master->can_dma && master->can_dma(master, spi, transfer))
@@ -325,7 +325,7 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 		}
 	} else {
 		txlevel = min_t(u16, dws->fifo_len / 2, dws->len / dws->n_bytes);
-		dw_writel(dws, DW_SPI_TXFLTR, txlevel);
+		dw_writel(dws, DW_SPI_TXFTLR, txlevel);
 
 		/* Set the interrupt mask */
 		imask |= SPI_INT_TXEI | SPI_INT_TXOI |
@@ -397,11 +397,11 @@ static void spi_hw_init(struct device *dev, struct dw_spi *dws)
 		u32 fifo;
 
 		for (fifo = 1; fifo < 256; fifo++) {
-			dw_writel(dws, DW_SPI_TXFLTR, fifo);
-			if (fifo != dw_readl(dws, DW_SPI_TXFLTR))
+			dw_writel(dws, DW_SPI_TXFTLR, fifo);
+			if (fifo != dw_readl(dws, DW_SPI_TXFTLR))
 				break;
 		}
-		dw_writel(dws, DW_SPI_TXFLTR, 0);
+		dw_writel(dws, DW_SPI_TXFTLR, 0);
 
 		dws->fifo_len = (fifo == 1) ? 0 : fifo;
 		dev_dbg(dev, "Detected FIFO size: %u bytes\n", dws->fifo_len);
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 44ef18187c15..6c34720b1b1d 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -6,14 +6,14 @@
 #include <linux/scatterlist.h>
 
 /* Register offsets */
-#define DW_SPI_CTRL0			0x00
-#define DW_SPI_CTRL1			0x04
+#define DW_SPI_CTRLR0			0x00
+#define DW_SPI_CTRLR1			0x04
 #define DW_SPI_SSIENR			0x08
 #define DW_SPI_MWCR			0x0c
 #define DW_SPI_SER			0x10
 #define DW_SPI_BAUDR			0x14
-#define DW_SPI_TXFLTR			0x18
-#define DW_SPI_RXFLTR			0x1c
+#define DW_SPI_TXFTLR			0x18
+#define DW_SPI_RXFTLR			0x1c
 #define DW_SPI_TXFLR			0x20
 #define DW_SPI_RXFLR			0x24
 #define DW_SPI_SR			0x28
-- 
2.17.1

