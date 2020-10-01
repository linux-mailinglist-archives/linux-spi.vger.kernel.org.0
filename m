Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C00F280A38
	for <lists+linux-spi@lfdr.de>; Fri,  2 Oct 2020 00:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733192AbgJAW2z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Oct 2020 18:28:55 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:48116 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733166AbgJAW2y (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Oct 2020 18:28:54 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id A8FAF803202A;
        Thu,  1 Oct 2020 22:28:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AbhrmywZxkgU; Fri,  2 Oct 2020 01:28:48 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        "wuxu . wu" <wuxu.wu@huawei.com>, Feng Tang <feng.tang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 07/21] spi: dw: Add DW SPI controller config structure
Date:   Fri, 2 Oct 2020 01:28:15 +0300
Message-ID: <20201001222829.15977-8-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20201001222829.15977-1-Sergey.Semin@baikalelectronics.ru>
References: <20201001222829.15977-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

DW APB SSI controller can be used by the two SPI core interfaces:
traditional SPI transfers and SPI memory operations. The controller needs
to be accordingly configured at runtime when the corresponding operations
are executed. In order to do that for the both interfaces from a single
function we introduce a new data wrapper for the transfer mode, data
width, number of data frames (for the automatic data transfer) and the bus
frequency. It will be used by the update_config() method to tune the DW
APB SSI up.

The update_config() method is made exported to be used not only by the DW
SPI core driver, but by the glue layer drivers too. This will be required
in a coming further commit.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/spi/spi-dw-core.c | 29 +++++++++++++++++------------
 drivers/spi/spi-dw.h      | 10 ++++++++++
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 87c8f0028a23..92c26b02269b 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -20,10 +20,8 @@
 #include <linux/debugfs.h>
 #endif
 
-/* Slave spi_dev related */
+/* Slave spi_device related */
 struct chip_data {
-	u8 tmode;		/* TR/TO/RO/EEPROM */
-
 	u32 cr0;
 	u32 rx_sample_dly;	/* RX sample delay */
 };
@@ -266,8 +264,8 @@ static u32 dw_spi_get_cr0(struct dw_spi *dws, struct spi_device *spi)
 	return cr0;
 }
 
-static void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
-				 struct spi_transfer *transfer)
+void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
+			  struct dw_spi_cfg *cfg)
 {
 	struct chip_data *chip = spi_get_ctldata(spi);
 	u32 cr0 = chip->cr0;
@@ -275,19 +273,22 @@ static void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
 	u16 clk_div;
 
 	/* CTRLR0[ 4/3: 0] Data Frame Size */
-	cr0 |= (transfer->bits_per_word - 1);
+	cr0 |= (cfg->dfs - 1);
 
 	if (!(dws->caps & DW_SPI_CAP_DWC_SSI))
 		/* CTRLR0[ 9:8] Transfer Mode */
-		cr0 |= chip->tmode << SPI_TMOD_OFFSET;
+		cr0 |= cfg->tmode << SPI_TMOD_OFFSET;
 	else
 		/* CTRLR0[11:10] Transfer Mode */
-		cr0 |= chip->tmode << DWC_SSI_CTRLR0_TMOD_OFFSET;
+		cr0 |= cfg->tmode << DWC_SSI_CTRLR0_TMOD_OFFSET;
 
 	dw_writel(dws, DW_SPI_CTRLR0, cr0);
 
+	if (cfg->tmode == SPI_TMOD_EPROMREAD || cfg->tmode == SPI_TMOD_RO)
+		dw_writel(dws, DW_SPI_CTRLR1, cfg->ndf ? cfg->ndf - 1 : 0);
+
 	/* Note DW APB SSI clock divider doesn't support odd numbers */
-	clk_div = (DIV_ROUND_UP(dws->max_freq, transfer->speed_hz) + 1) & 0xfffe;
+	clk_div = (DIV_ROUND_UP(dws->max_freq, cfg->freq) + 1) & 0xfffe;
 	speed_hz = dws->max_freq / clk_div;
 
 	if (dws->current_freq != speed_hz) {
@@ -301,11 +302,17 @@ static void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
 		dws->cur_rx_sample_dly = chip->rx_sample_dly;
 	}
 }
+EXPORT_SYMBOL_GPL(dw_spi_update_config);
 
 static int dw_spi_transfer_one(struct spi_controller *master,
 		struct spi_device *spi, struct spi_transfer *transfer)
 {
 	struct dw_spi *dws = spi_controller_get_devdata(master);
+	struct dw_spi_cfg cfg = {
+		.tmode = SPI_TMOD_TR,
+		.dfs = transfer->bits_per_word,
+		.freq = transfer->speed_hz,
+	};
 	u8 imask = 0;
 	u16 txlevel = 0;
 	int ret;
@@ -323,7 +330,7 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 
 	spi_enable_chip(dws, 0);
 
-	dw_spi_update_config(dws, spi, transfer);
+	dw_spi_update_config(dws, spi, &cfg);
 
 	transfer->effective_speed_hz = dws->current_freq;
 
@@ -409,8 +416,6 @@ static int dw_spi_setup(struct spi_device *spi)
 	 */
 	chip->cr0 = dw_spi_get_cr0(dws, spi);
 
-	chip->tmode = SPI_TMOD_TR;
-
 	return 0;
 }
 
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index c02351cf2f99..2a2346438564 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -111,6 +111,14 @@ enum dw_ssi_type {
 #define DW_SPI_CAP_KEEMBAY_MST		BIT(1)
 #define DW_SPI_CAP_DWC_SSI		BIT(2)
 
+/* Slave spi_transfer/spi_mem_op related */
+struct dw_spi_cfg {
+	u8 tmode;
+	u8 dfs;
+	u32 ndf;
+	u32 freq;
+};
+
 struct dw_spi;
 struct dw_spi_dma_ops {
 	int (*dma_init)(struct device *dev, struct dw_spi *dws);
@@ -249,6 +257,8 @@ static inline void spi_shutdown_chip(struct dw_spi *dws)
 }
 
 extern void dw_spi_set_cs(struct spi_device *spi, bool enable);
+extern void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
+				 struct dw_spi_cfg *cfg);
 extern int dw_spi_add_host(struct device *dev, struct dw_spi *dws);
 extern void dw_spi_remove_host(struct dw_spi *dws);
 extern int dw_spi_suspend_host(struct dw_spi *dws);
-- 
2.27.0

