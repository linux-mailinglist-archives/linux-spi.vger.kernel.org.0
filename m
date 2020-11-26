Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D840B2C4D06
	for <lists+linux-spi@lfdr.de>; Thu, 26 Nov 2020 03:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732292AbgKZCAz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Nov 2020 21:00:55 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:17440 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730060AbgKZCAy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 25 Nov 2020 21:00:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606356053; x=1637892053;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1pckFZ688v263y5IgA3KAvJLkpwAwKYxGDqKgEvfEzM=;
  b=fGyRhPT9cwJgzIr4OcvdoKr4AY0WGvGGR4QskNdD85Zt2zYxjb2VCuVd
   +Vy1VEbUEIsb0IE4nO2leYmHMr52ynf3ZWEjXGEMry9a9wrZe4IwdVVVq
   sBnUgfYe1RUa8TIe6/6QYi7RETgPlWZIPqkbInExrDCGexp+4zJ8kO92f
   kLDmex469gutBZ7imhsk3fPvyEFey7kAgzWrw3yvXbgPD2mfvg+4pNX9o
   WEQYtuXBtAJdAgAcZxudLcHZXvxWYh1+LCrlRQDHBz3Es4F9GMI9ugH/6
   jIoEuDgxYEat3ylqWR9UkP95XfsuqvPHgSChMICYu1Bhyeg55U6YE6P0J
   g==;
IronPort-SDR: KLG3gOYJ4jOQ9oN2DuUYTBNRTd11yaK0fxP4sUvqO2uTKdquszeUie9sWFxjOxMkR31KbP2KbO
 9EdR+TgOWF/1hYIQupcEsZLJSb+dpsdWS37iZcnUaWRJ/Qbq9N/uzDz+1ssSPrkGfUIKPGnzXT
 EByB64+ldWxpW/JPBiihYoTBJFc0Pxz2DAoV+/HIxKgJ7XvEZEsEr3n8ecfsGKRdLRaqixXLz9
 /ZUXgRn1whmEx8Vbr5MNQXIq/nHBdZhStP3AS9u5icZuH6MjQnp0NWwg8RAEYZVeBmwx+sbo3J
 R7g=
X-IronPort-AV: E=Sophos;i="5.78,370,1599494400"; 
   d="scan'208";a="157980295"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2020 10:00:53 +0800
IronPort-SDR: GgBX61nyp+fEIRTSRvos8ioJrkUO03Y8uctWUI0iypYxw//f+PhSzzL8r+yQAJ0yRs6p3wFT6/
 l05grSnBha6JtfHlSePp4KoI3nocwpmuk=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 17:46:35 -0800
IronPort-SDR: xnwFgkekrHXi2hgiV7kXkkzoSlYIFxhSMUS9IxJuEUUWAB+B9QJpUW15e5PWVq/HAEBy1J+/5o
 6sGQ6RqGkDdQ==
WDCIronportException: Internal
Received: from 57m2vf2.ad.shared (HELO twashi.fujisawa.hgst.com) ([10.84.71.135])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Nov 2020 18:00:51 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 1/3] spi: dw: Add support for 32-bits max xfer size
Date:   Thu, 26 Nov 2020 11:00:47 +0900
Message-Id: <20201126020049.35712-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201126020049.35712-1-damien.lemoal@wdc.com>
References: <20201126020049.35712-1-damien.lemoal@wdc.com>
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
---
 drivers/spi/spi-dw-core.c | 44 ++++++++++++++++++++++++++++++++-------
 drivers/spi/spi-dw.h      |  5 +++++
 2 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 0b2236ade412..54166fcb2e5b 100644
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
 
+	if (!(dws->caps & DW_SPI_CAP_DWC_SSI)) {
+		u32 cr0, tmp = dw_readl(dws, DW_SPI_CTRLR0);
+
+		/*
+		 * Detect APB SSI CTRLR0 DFS offset by looking at the data
+		 * frame size field: for 32-bits data frame size, bits [3..0]
+		 * (SPI_DFS_MASK) are ignored.
+		 */
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

