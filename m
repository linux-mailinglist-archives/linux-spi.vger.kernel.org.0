Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F13A2B9200
	for <lists+linux-spi@lfdr.de>; Thu, 19 Nov 2020 13:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgKSMC7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Nov 2020 07:02:59 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:54227 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgKSMC7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 19 Nov 2020 07:02:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605788064; x=1637324064;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LgKs7lCWEEqwsj+BdxHYh1dSqoHXLMm4UKtatOqbzTE=;
  b=jcOdId08MoZVfq70qjU4IEwMyLCnFhGFnUvLdBd8PpbhGFSKBgX3HwFI
   XKX1lLez6lInx3kgeVZXjqISt/aVEXf+Zl0AuaUqvqHNcuBFRszygKvc0
   53EVlS6RZeEfisQLlqie/L03UqKhpFZ4h5zC4fC3v3alUJLK9NPrQ9dtv
   Yzw3Ne8D3hEsvJVcqM80+sBitW6Y6OwkF3Ec7fZecwbyYC+J9I8UfhPoZ
   N76KvocA93QWhPChsxNJUZ7pszhkX/TXmJqKVY360eBW/Bb5nfBAIex90
   Fdr2vtsE4NEdCYCoJh/ldYdRiJtbt1Y373zLqgY1cWHOs71Epko0yGxkV
   A==;
IronPort-SDR: oO4FFZC9Thll+HxHPwV/EL9HNvX1aQiWpgp9NqLM49upnX8A8ybasm1oxipjx/HFevsiS5PRaG
 zXRkxH/g6CfK4J8cYm9+grbAzZUj0wuW+CGShPEfZokpmfLJk1WYnggUbZQtjkmvwnXdP1rJpz
 bNJq0kDr8jvPtpIyfi/1xTB/Mep2G7eenfjst8Kv6koJDcOgmDYr2p8VxfO8WoN+Gzbf2yw+4A
 vNE/yIMLjWsXN6UbtHrEbgw/jhzi3IefiPbU9+IO2yVknF5cngRADoA/u58/3eP+eELHR3tw2s
 ILU=
X-IronPort-AV: E=Sophos;i="5.77,490,1596470400"; 
   d="scan'208";a="256574390"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Nov 2020 20:14:24 +0800
IronPort-SDR: +ry5Q4+8+NQX7I4KoZetPRQGd7U7XjzcKw7lonDe4qvTMWmpZiXZ/pNfRqI08t55FZUimH8qKY
 lzoEI/R8yz/JFXWCSTn4mX2yMvpC5Ik/Qy2OGJvDhpvQtTen+ThihuiW+Yq+HnEUn9X01t3A4f
 VviyXCzkKuy1X0peh9YitIfFpCVghRVguB5kn3iHgoYpKQ46tF/4REtr48tznn48fmPVBgjzs5
 4KQ7wn8uO9jalvmERdDy5RfSVISzgnMC7T5Q2ntqKI+mvqrCzZKtsi2maYCpK69UFDiIPmZxN5
 NUdlKaKjt+YqxGzMxl7nVVwM
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 03:48:48 -0800
IronPort-SDR: NI8emcWW7L6Ai8gonYwhFZ6N5A/6SRJkEDP9qfqWjY1Oksn5Wo+Ftl/aJqQPgcUGIQFaWSrJ9u
 uGtL0/8CImi+XKf65FYO8ZEHOfrAxBa9X6KuOLfRfJmOiN1lDJqrELCO3EGanWQvNONxbw/Z3J
 nQ9ibGGcVyVbmJLbv0Kcp4rCqjl4RR3GfRYoVIxeFB6F9fknPmgtSuI0/4GNncmsA4feeRMJMu
 /ycqbUZlVVRZJLpS+ZF+KX+rNxCWw1lB44Prv1D7uq56cjpANF4uMjPLqo9OJzfb5hqEOLmzdx
 Lfo=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO twashi.fujisawa.hgst.com) ([10.84.71.107])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Nov 2020 04:02:57 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 1/3] spi: dw: Add support for 32-bits max xfer size
Date:   Thu, 19 Nov 2020 21:02:51 +0900
Message-Id: <20201119120253.390883-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201119120253.390883-1-damien.lemoal@wdc.com>
References: <20201119120253.390883-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Synopsis DesignWare DW_apb_ssi version 3.23 onward defines a 32-bits
maximum transfer size synthesis parameter (SSI_MAX_XFER_SIZE=32) in
addition to the legacy 16-bits configuration (SSI_MAX_XFER_SIZE=16) for
SPI controllers.  When SSI_MAX_XFER_SIZE=32, the layout of the ctrlr0
register changes and RX/TX FIFO words can be up to 32-bits.

The layout of ctrlr0 change for the 32-bits configuration moves the
data frame format field to bits 16..20 instead of bits 3..0
when the controller is configured with SSI_MAX_XFER_SIZE=16.

Introduce the DW SPI capability flag DW_SPI_CAP_DWC_APB_XFER32 to
indicate in that the controller is configured with SSI_MAX_XFER_SIZE=32.
Since the SSI_MAX_XFER_SIZE parameter is a controller synthesis
parameter not accessible through a register, the detection of this
parameter value is done in spi_hw_init() by writing and reading the
ctrlr0 register and testing the value of bits 20..16.

The DW_SPI_CAP_DWC_APB_XFER32 flag is used in dw_spi_update_config() to
set the data frame size field at the correct position and in
dw_spi_add_host() to extend bits_per_word_mask to 32-bits.
dw_reader() and dw_writer() are also modified to handle 32-bits FIFO
words.

Suggested-by: Sean Anderson <seanga2@gmail.com>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/spi/spi-dw-core.c | 40 ++++++++++++++++++++++++++++++++-------
 drivers/spi/spi-dw.h      |  8 ++++++++
 2 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 2e50cc0a9291..4c16832b16fd 100644
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
@@ -311,8 +315,12 @@ void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
 	u32 speed_hz;
 	u16 clk_div;
 
-	/* CTRLR0[ 4/3: 0] Data Frame Size */
-	cr0 |= (cfg->dfs - 1);
+	if (!(dws->caps & DW_SPI_CAP_DWC_APB_XFER32))
+		/* CTRLR0[ 4/3: 0] Data Frame Size */
+		cr0 |= (cfg->dfs - 1);
+	else
+		/* CTRLR0[20: 16] Data Frame Size */
+		cr0 |= FIELD_PREP(DWC_APB_CTRLR0_DFS32_MASK, cfg->dfs - 1);
 
 	if (!(dws->caps & DW_SPI_CAP_DWC_SSI))
 		/* CTRLR0[ 9:8] Transfer Mode */
@@ -828,6 +836,21 @@ static void spi_hw_init(struct device *dev, struct dw_spi *dws)
 		dev_dbg(dev, "Detected FIFO size: %u bytes\n", dws->fifo_len);
 	}
 
+	if (!(dws->caps & DW_SPI_CAP_DWC_SSI)) {
+		u32 cr0;
+
+		/*
+		 * Detect APB SSI CTRLR0 size by looking at the data
+		 * frame size field.
+		 */
+		dw_writel(dws, DW_SPI_CTRLR0, 0xffffffff);
+		cr0 = dw_readl(dws, DW_SPI_CTRLR0);
+		if (FIELD_GET(DWC_APB_CTRLR0_DFS32_MASK, cr0)) {
+			dev_dbg(dev, "Detected 32-bits max data frame size\n");
+			dws->caps |= DW_SPI_CAP_DWC_APB_XFER32;
+		}
+	}
+
 	/* enable HW fixup for explicit CS deselect for Amazon's alpine chip */
 	if (dws->caps & DW_SPI_CAP_CS_OVERRIDE)
 		dw_writel(dws, DW_SPI_CS_OVERRIDE, 0xF);
@@ -864,7 +887,10 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 
 	master->use_gpio_descriptors = true;
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP;
-	master->bits_per_word_mask =  SPI_BPW_RANGE_MASK(4, 16);
+	if (dws->caps & DW_SPI_CAP_DWC_APB_XFER32)
+		master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
+	else
+		master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 16);
 	master->bus_num = dws->bus_num;
 	master->num_chipselect = dws->num_cs;
 	master->setup = dw_spi_setup;
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index faf40cb66498..cba5c1f8c456 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -9,6 +9,7 @@
 #include <linux/io.h>
 #include <linux/scatterlist.h>
 #include <linux/spi/spi-mem.h>
+#include <linux/bitfield.h>
 
 /* Register offsets */
 #define DW_SPI_CTRLR0			0x00
@@ -72,6 +73,12 @@
 #define DWC_SSI_CTRLR0_FRF_OFFSET	6
 #define DWC_SSI_CTRLR0_DFS_OFFSET	0
 
+/*
+ * Data frame size bits mask in CTRLR0 for DWC_apb_ssi v4 when the
+ * controller capability supports DW_SPI_CAP_DWC_APB_XFER32.
+ */
+#define DWC_APB_CTRLR0_DFS32_MASK	GENMASK(20, 16)
+
 /*
  * For Keem Bay, CTRLR0[31] is used to select controller mode.
  * 0: SSI is slave
@@ -121,6 +128,7 @@ enum dw_ssi_type {
 #define DW_SPI_CAP_CS_OVERRIDE		BIT(0)
 #define DW_SPI_CAP_KEEMBAY_MST		BIT(1)
 #define DW_SPI_CAP_DWC_SSI		BIT(2)
+#define DW_SPI_CAP_DWC_APB_XFER32	BIT(3)
 
 /* Slave spi_transfer/spi_mem_op related */
 struct dw_spi_cfg {
-- 
2.28.0

