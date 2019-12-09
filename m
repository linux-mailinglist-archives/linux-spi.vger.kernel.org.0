Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC0A1167E7
	for <lists+linux-spi@lfdr.de>; Mon,  9 Dec 2019 09:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfLIIDa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Dec 2019 03:03:30 -0500
Received: from mga03.intel.com ([134.134.136.65]:36446 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbfLIIDa (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Dec 2019 03:03:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2019 00:03:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,294,1571727600"; 
   d="scan'208";a="210037611"
Received: from wwanmoha-ilbpg1.png.intel.com ([10.88.227.84])
  by fmsmga008.fm.intel.com with ESMTP; 09 Dec 2019 00:03:28 -0800
From:   wan.ahmad.zainie.wan.mohamad@intel.com
To:     linux-spi@vger.kernel.org
Cc:     wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH 4/6] spi: dw: Fix typo in few registers name
Date:   Tue, 10 Dec 2019 00:04:01 +0800
Message-Id: <1575907443-26377-5-git-send-email-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1575907443-26377-1-git-send-email-wan.ahmad.zainie.wan.mohamad@intel.com>
References: <1575907443-26377-1-git-send-email-wan.ahmad.zainie.wan.mohamad@intel.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>

This patch will fix typo in the register name used in the source code,
to be consistent with the register name used in the databook.

Databook: DW_apb_ssi_databook.pdf version 4.01a

Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
---
 drivers/spi/spi-dw.c | 18 +++++++++---------
 drivers/spi/spi-dw.h |  8 ++++----
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index a92aa5cd4fbe..7f59be34cbf5 100644
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
@@ -328,7 +328,7 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 		cr0 |= (chip->tmode << SPI_TMOD_OFFSET);
 	}
 
-	dw_writel(dws, DW_SPI_CTRL0, cr0);
+	dw_writel(dws, DW_SPI_CTRLR0, cr0);
 
 	/* Check if current transfer is a DMA transaction */
 	if (master->can_dma && master->can_dma(master, spi, transfer))
@@ -349,7 +349,7 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 		}
 	} else if (!chip->poll_mode) {
 		txlevel = min_t(u16, dws->fifo_len / 2, dws->len / dws->n_bytes);
-		dw_writel(dws, DW_SPI_TXFLTR, txlevel);
+		dw_writel(dws, DW_SPI_TXFTLR, txlevel);
 
 		/* Set the interrupt mask */
 		imask |= SPI_INT_TXEI | SPI_INT_TXOI |
@@ -440,11 +440,11 @@ static void spi_hw_init(struct device *dev, struct dw_spi *dws)
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
index 38c7de1f0aa9..e2df96dbc796 100644
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
1.9.1

