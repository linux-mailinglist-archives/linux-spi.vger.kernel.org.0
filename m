Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF9B1C3ACD
	for <lists+linux-spi@lfdr.de>; Mon,  4 May 2020 15:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgEDNEg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 May 2020 09:04:36 -0400
Received: from mga05.intel.com ([192.55.52.43]:6156 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbgEDNEg (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 4 May 2020 09:04:36 -0400
IronPort-SDR: x08WHTwRg2dAEVK7+R20U8PT2giy7sJ9MBhJRKETdYVMFmBmdW45NIoluv2A+7W6c9GdFzYQUl
 cEkDX/aMIJzA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 06:03:56 -0700
IronPort-SDR: 4uEX6RVUPKH98FOpWi8oehV2U2DvOAE1QrAA1rsvyRBEnd+MgfnfJYtpCyP21PKo6Wmx0YRiBR
 psqFAofI2fLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,352,1583222400"; 
   d="scan'208";a="249169066"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by fmsmga007.fm.intel.com with ESMTP; 04 May 2020 06:03:53 -0700
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     broonie@kernel.org, robh+dt@kernel.org
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH v4 1/7] spi: dw: Fix typo in few registers name
Date:   Mon,  4 May 2020 21:02:40 +0800
Message-Id: <20200504130246.5135-2-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200504130246.5135-1-wan.ahmad.zainie.wan.mohamad@intel.com>
References: <20200504130246.5135-1-wan.ahmad.zainie.wan.mohamad@intel.com>
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
index 31e3f866d11a..fbbafb099571 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -50,9 +50,9 @@ static ssize_t dw_spi_show_regs(struct file *file, char __user *user_buf,
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
@@ -60,9 +60,9 @@ static ssize_t dw_spi_show_regs(struct file *file, char __user *user_buf,
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
@@ -340,7 +340,7 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 		cr0 |= (chip->tmode << SPI_TMOD_OFFSET);
 	}
 
-	dw_writel(dws, DW_SPI_CTRL0, cr0);
+	dw_writel(dws, DW_SPI_CTRLR0, cr0);
 
 	/* Check if current transfer is a DMA transaction */
 	if (master->can_dma && master->can_dma(master, spi, transfer))
@@ -361,7 +361,7 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 		}
 	} else if (!chip->poll_mode) {
 		txlevel = min_t(u16, dws->fifo_len / 2, dws->len / dws->n_bytes);
-		dw_writel(dws, DW_SPI_TXFLTR, txlevel);
+		dw_writel(dws, DW_SPI_TXFTLR, txlevel);
 
 		/* Set the interrupt mask */
 		imask |= SPI_INT_TXEI | SPI_INT_TXOI |
@@ -452,11 +452,11 @@ static void spi_hw_init(struct device *dev, struct dw_spi *dws)
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
index 1bf5713e047d..445362c23fde 100644
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

