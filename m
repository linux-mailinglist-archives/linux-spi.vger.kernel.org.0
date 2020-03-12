Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC8C182F38
	for <lists+linux-spi@lfdr.de>; Thu, 12 Mar 2020 12:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725268AbgCLLbt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Mar 2020 07:31:49 -0400
Received: from mga09.intel.com ([134.134.136.24]:28073 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbgCLLbs (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 12 Mar 2020 07:31:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 04:31:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,544,1574150400"; 
   d="scan'208";a="389575839"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by orsmga004.jf.intel.com with ESMTP; 12 Mar 2020 04:31:46 -0700
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH 1/7] spi: dw: Fix typo in few registers name
Date:   Thu, 12 Mar 2020 19:31:23 +0800
Message-Id: <20200312113129.8198-2-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200312113129.8198-1-wan.ahmad.zainie.wan.mohamad@intel.com>
References: <20200312113129.8198-1-wan.ahmad.zainie.wan.mohamad@intel.com>
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

