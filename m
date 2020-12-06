Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2182D0012
	for <lists+linux-spi@lfdr.de>; Sun,  6 Dec 2020 02:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgLFBUe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 5 Dec 2020 20:20:34 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:4736 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgLFBUd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 5 Dec 2020 20:20:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607218796; x=1638754796;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vG/A0zFrdpj+CCVOe98LHj7PBknAVZVpqI/ZrZRgmYc=;
  b=U0jWaFy1i58tQhWHc3KsJTRwMWr3TVznzJ54/D6E+c7AxQGkDNVt/TEM
   o3+c0Q7xApQwYwWtf2TLl1H0WgVhs6XCw7oLcGbOh7xOvva3cEtVTfA1v
   Fbo/8wlftROas9yIuBGwy0/mvmrNFH4CjG/MtRQxZu7Pwe7J9t1e28QXO
   jqCFHEyLpB3eFDKw3mxBuJ0AFdHtqOzwHhzYIrH7EA95YyrDiZm/QAuIb
   mAM8Hx+vbOQ+NKAwOQs2t0QRwhcc+G7/49PAkq8gJ/QjC3oGHQP2OGvby
   m9PxvOqPMBvY+lZ7OD37JDTVfa96nYpxl0e+ZamBq+AzfBTadaYmGt75+
   A==;
IronPort-SDR: dCEidGWVxrsijsz03dkP+KO+42N7zgjkZEOx5L5dpW5l/rZcQYs3g5vv/mm4GTQbTBJbpTjh67
 +f4w/VVW6brmWZ1hUgdtXrbla5Sh2A1CiegK4IOqEJLLmPMEsJLhk5oPk2CMFukWh+kb59JJai
 045rWEZ6kG2gcJVsc8FP6Lm+KK0GJoIXEJ+/+CyJdQEKPhG2K9GXJTd7AAToOZ9EYx/62ZuOwD
 TDie4WsNBl5xyMVMWZJ5NC5ilhQoftQVo6zvnWoa/+uOxDkxJiBWrtD9hGnnlxvMg495+6RUiD
 dE0=
X-IronPort-AV: E=Sophos;i="5.78,396,1599494400"; 
   d="scan'208";a="258231903"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2020 09:36:42 +0800
IronPort-SDR: 1QqOH88dxBDHK/0xhCPuAJ0zBDrsTYd6fVbA/30it+RHMhxMkqWO8DH1Uqeg2FabJzUXiXOSel
 qqRT5CQQCIaO64T217akLMGQ5GpgGNVuM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2020 17:02:28 -0800
IronPort-SDR: GVJjr/XO7KZ2n7w4nAwq5Yy4dpwjva5Zx+whwDQDJjV0M5rxNY9UFAuLNCLXvh6d7gbeALk5HV
 hs0Zmn1DeOcw==
WDCIronportException: Internal
Received: from cnf005296.ad.shared (HELO twashi.fujisawa.hgst.com) ([10.84.71.167])
  by uls-op-cesaip02.wdc.com with ESMTP; 05 Dec 2020 17:18:23 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v3 2/3] spi: dw: Add support for 32-bits max xfer size
Date:   Sun,  6 Dec 2020 10:18:16 +0900
Message-Id: <20201206011817.11700-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201206011817.11700-1-damien.lemoal@wdc.com>
References: <20201206011817.11700-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The Synopsis DesignWare DW_apb_ssi specifications version 3.23 onward
define a 32-bits maximum transfer size synthesis parameter
(SSI_MAX_XFER_SIZE=32) in addition to the legacy 16-bits configuration
(SSI_MAX_XFER_SIZE=16) for SPI controllers. When SSI_MAX_XFER_SIZE=32,
the layout of the ctrlr0 register changes, moving the data frame format
field from bits [3..0] to bits [16..20], and the RX/TX FIFO word size
can be up to 32-bits.

To support this new format, introduce the DW SPI capability flag
DW_SPI_CAP_DFS32 to indicate that a controller is configured with
SSI_MAX_XFER_SIZE=32. Since SSI_MAX_XFER_SIZE is a controller synthesis
parameter not accessible through a register, the detection of this
parameter value is done in spi_hw_init() by writing and reading the
ctrlr0 register and testing the value of bits [3..0]. These bits are
ignored (unchanged) for SSI_MAX_XFER_SIZE=16, allowing the detection.
If a DFS32 capable SPI controller is detected, the new field dfs_offset
in struct dw_spi is set to SPI_DFS32_OFFSET (16).

dw_spi_update_config() is modified to set the data frame size field at
the correct position is the CTRLR0 register, as indicated by the
dfs_offset field of the dw_spi structure.

The DW_SPI_CAP_DFS32 flag is also unconditionally set for SPI slave
controllers, e.g. controllers that have the DW_SPI_CAP_DWC_SSI
capability flag set. However, for these ssi controllers, the dfs_offset
field is set to 0 as before (as per specifications).

Finally, for any controller with the DW_SPI_CAP_DFS32 capability flag
set, dw_spi_add_host() extends the value of bits_per_word_mask from
16-bits to 32-bits. dw_reader() and dw_writer() are also modified to
handle 32-bits iTX/RX FIFO words.

Suggested-by: Sean Anderson <seanga2@gmail.com>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Acked-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/spi/spi-dw-core.c | 44 ++++++++++++++++++++++++++++++++-------
 drivers/spi/spi-dw.h      |  5 +++++
 2 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index c33866f747db..a305074c482e 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -137,14 +137,16 @@ static inline u32 rx_max(struct dw_spi *dws)
 static void dw_writer(struct dw_spi *dws)
 {
 	u32 max = tx_max(dws);
-	u16 txw = 0;
+	u32 txw = 0;
 
 	while (max--) {
 		if (dws->tx) {
 			if (dws->n_bytes == 1)
 				txw = *(u8 *)(dws->tx);
-			else
+			else if (dws->n_bytes == 2)
 				txw = *(u16 *)(dws->tx);
+			else
+				txw = *(u32 *)(dws->tx);
 
 			dws->tx += dws->n_bytes;
 		}
@@ -156,15 +158,17 @@ static void dw_writer(struct dw_spi *dws)
 static void dw_reader(struct dw_spi *dws)
 {
 	u32 max = rx_max(dws);
-	u16 rxw;
+	u32 rxw;
 
 	while (max--) {
 		rxw = dw_read_io_reg(dws, DW_SPI_DR);
 		if (dws->rx) {
 			if (dws->n_bytes == 1)
 				*(u8 *)(dws->rx) = rxw;
-			else
+			else if (dws->n_bytes == 2)
 				*(u16 *)(dws->rx) = rxw;
+			else
+				*(u32 *)(dws->rx) = rxw;
 
 			dws->rx += dws->n_bytes;
 		}
@@ -311,8 +315,8 @@ void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
 	u32 speed_hz;
 	u16 clk_div;
 
-	/* CTRLR0[ 4/3: 0] Data Frame Size */
-	cr0 |= (cfg->dfs - 1);
+	/* CTRLR0[ 4/3: 0] or CTRLR0[ 20: 16] Data Frame Size */
+	cr0 |= (cfg->dfs - 1) << dws->dfs_offset;
 
 	if (!(dws->caps & DW_SPI_CAP_DWC_SSI))
 		/* CTRLR0[ 9:8] Transfer Mode */
@@ -828,6 +832,29 @@ static void spi_hw_init(struct device *dev, struct dw_spi *dws)
 		dev_dbg(dev, "Detected FIFO size: %u bytes\n", dws->fifo_len);
 	}
 
+	/*
+	 * Detect CTRLR0.DFS field size and offset by testing the lowest bits
+	 * writability. Note DWC SSI controller also has the extended DFS, but
+	 * with zero offset.
+	 */
+	if (!(dws->caps & DW_SPI_CAP_DWC_SSI)) {
+		u32 cr0, tmp = dw_readl(dws, DW_SPI_CTRLR0);
+
+		spi_enable_chip(dws, 0);
+		dw_writel(dws, DW_SPI_CTRLR0, 0xffffffff);
+		cr0 = dw_readl(dws, DW_SPI_CTRLR0);
+		dw_writel(dws, DW_SPI_CTRLR0, tmp);
+		spi_enable_chip(dws, 1);
+
+		if (!(cr0 & SPI_DFS_MASK)) {
+			dws->caps |= DW_SPI_CAP_DFS32;
+			dws->dfs_offset = SPI_DFS32_OFFSET;
+			dev_dbg(dev, "Detected 32-bits max data frame size\n");
+		}
+	} else {
+		dws->caps |= DW_SPI_CAP_DFS32;
+	}
+
 	/* enable HW fixup for explicit CS deselect for Amazon's alpine chip */
 	if (dws->caps & DW_SPI_CAP_CS_OVERRIDE)
 		dw_writel(dws, DW_SPI_CS_OVERRIDE, 0xF);
@@ -864,7 +891,10 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 
 	master->use_gpio_descriptors = true;
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP;
-	master->bits_per_word_mask =  SPI_BPW_RANGE_MASK(4, 16);
+	if (dws->caps & DW_SPI_CAP_DFS32)
+		master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
+	else
+		master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 16);
 	master->bus_num = dws->bus_num;
 	master->num_chipselect = dws->num_cs;
 	master->setup = dw_spi_setup;
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index faf40cb66498..b665e040862c 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -9,6 +9,7 @@
 #include <linux/io.h>
 #include <linux/scatterlist.h>
 #include <linux/spi/spi-mem.h>
+#include <linux/bitfield.h>
 
 /* Register offsets */
 #define DW_SPI_CTRLR0			0x00
@@ -41,6 +42,8 @@
 
 /* Bit fields in CTRLR0 */
 #define SPI_DFS_OFFSET			0
+#define SPI_DFS_MASK			GENMASK(3, 0)
+#define SPI_DFS32_OFFSET		16
 
 #define SPI_FRF_OFFSET			4
 #define SPI_FRF_SPI			0x0
@@ -121,6 +124,7 @@ enum dw_ssi_type {
 #define DW_SPI_CAP_CS_OVERRIDE		BIT(0)
 #define DW_SPI_CAP_KEEMBAY_MST		BIT(1)
 #define DW_SPI_CAP_DWC_SSI		BIT(2)
+#define DW_SPI_CAP_DFS32		BIT(3)
 
 /* Slave spi_transfer/spi_mem_op related */
 struct dw_spi_cfg {
@@ -148,6 +152,7 @@ struct dw_spi {
 	unsigned long		paddr;
 	int			irq;
 	u32			fifo_len;	/* depth of the FIFO buffer */
+	unsigned int		dfs_offset;     /* CTRLR0 DFS field offset */
 	u32			max_mem_freq;	/* max mem-ops bus freq */
 	u32			max_freq;	/* max bus freq supported */
 
-- 
2.28.0

