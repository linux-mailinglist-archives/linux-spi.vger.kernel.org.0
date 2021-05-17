Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38930382E49
	for <lists+linux-spi@lfdr.de>; Mon, 17 May 2021 16:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237631AbhEQOFr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 May 2021 10:05:47 -0400
Received: from mga11.intel.com ([192.55.52.93]:59397 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230507AbhEQOFM (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 17 May 2021 10:05:12 -0400
IronPort-SDR: yQ8Nimf/kEUk+F2p8BlOq82LMyk2sV9T/mcct9TRfu7PLHYaSGVrFz5arvP7uFrVqkN+PuRzKG
 I9U9PfY9SkBg==
X-IronPort-AV: E=McAfee;i="6200,9189,9986"; a="197388032"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="197388032"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 07:03:39 -0700
IronPort-SDR: zLGWyIJxR0aSU+/M3lQL7/7CIfncNBvwd5go4896vUY/IjAgBFS2pEFvz136+CdCoj+ebj3mWa
 VLYjx62loOuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="404107019"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 17 May 2021 07:03:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5D1108AD; Mon, 17 May 2021 17:03:55 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v1 7/9] spi: pxa2xx: Fix style of and typos in the comments and messages
Date:   Mon, 17 May 2021 17:03:49 +0300
Message-Id: <20210517140351.901-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210517140351.901-1-andriy.shevchenko@linux.intel.com>
References: <20210517140351.901-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fix style of the comments and messages along with typos in them.

While at it, update Intel Copyright year.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx-dma.c   |  4 +-
 drivers/spi/spi-pxa2xx-pci.c   |  5 ++-
 drivers/spi/spi-pxa2xx.c       | 71 ++++++++++++++++++----------------
 drivers/spi/spi-pxa2xx.h       |  2 +-
 include/linux/pxa2xx_ssp.h     |  9 +++--
 include/linux/spi/pxa2xx_spi.h | 12 ++++--
 6 files changed, 58 insertions(+), 45 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-dma.c b/drivers/spi/spi-pxa2xx-dma.c
index f022d82dcb1b..be563f0dd03a 100644
--- a/drivers/spi/spi-pxa2xx-dma.c
+++ b/drivers/spi/spi-pxa2xx-dma.c
@@ -2,7 +2,7 @@
 /*
  * PXA2xx SPI DMA engine support.
  *
- * Copyright (C) 2013, Intel Corporation
+ * Copyright (C) 2013, 2021 Intel Corporation
  * Author: Mika Westerberg <mika.westerberg@linux.intel.com>
  */
 
@@ -26,7 +26,7 @@ static void pxa2xx_spi_dma_transfer_complete(struct driver_data *drv_data,
 	 * It is possible that one CPU is handling ROR interrupt and other
 	 * just gets DMA completion. Calling pump_transfers() twice for the
 	 * same transfer leads to problems thus we prevent concurrent calls
-	 * by using ->dma_running.
+	 * by using dma_running.
 	 */
 	if (atomic_dec_and_test(&drv_data->dma_running)) {
 		/*
diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index dce9ade9a4df..9c9992d4f547 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * CE4100's SPI device is more or less the same one as found on PXA
+ * PCI glue driver for SPI PXA2xx compatible controllers.
+ * CE4100's SPI device is more or less the same one as found on PXA.
  *
- * Copyright (C) 2016, Intel Corporation
+ * Copyright (C) 2016, 2021 Intel Corporation
  */
 #include <linux/clk-provider.h>
 #include <linux/module.h>
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index f8264771b360..94b1585de203 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2005 Stephen Street / StreetFire Sound Labs
- * Copyright (C) 2013, Intel Corporation
+ * Copyright (C) 2013, 2021 Intel Corporation
  */
 
 #include <linux/acpi.h>
@@ -40,11 +40,11 @@ MODULE_ALIAS("platform:pxa2xx-spi");
 #define TIMOUT_DFLT		1000
 
 /*
- * for testing SSCR1 changes that require SSP restart, basically
- * everything except the service and interrupt enables, the pxa270 developer
+ * For testing SSCR1 changes that require SSP restart, basically
+ * everything except the service and interrupt enables, the PXA270 developer
  * manual says only SSCR1_SCFR, SSCR1_SPH, SSCR1_SPO need to be in this
- * list, but the PXA255 dev man says all bits without really meaning the
- * service and interrupt enables
+ * list, but the PXA255 developer manual says all bits without really meaning
+ * the service and interrupt enables.
  */
 #define SSCR1_CHANGE_MASK (SSCR1_TTELP | SSCR1_TTE | SSCR1_SCFR \
 				| SSCR1_ECRA | SSCR1_ECRB | SSCR1_SCLKDIR \
@@ -653,12 +653,12 @@ static irqreturn_t interrupt_transfer(struct driver_data *drv_data)
 		irq_status &= ~SSSR_TFS;
 
 	if (irq_status & SSSR_ROR) {
-		int_error_stop(drv_data, "interrupt_transfer: fifo overrun", -EIO);
+		int_error_stop(drv_data, "interrupt_transfer: FIFO overrun", -EIO);
 		return IRQ_HANDLED;
 	}
 
 	if (irq_status & SSSR_TUR) {
-		int_error_stop(drv_data, "interrupt_transfer: fifo underrun", -EIO);
+		int_error_stop(drv_data, "interrupt_transfer: FIFO underrun", -EIO);
 		return IRQ_HANDLED;
 	}
 
@@ -670,7 +670,7 @@ static irqreturn_t interrupt_transfer(struct driver_data *drv_data)
 		}
 	}
 
-	/* Drain rx fifo, Fill tx fifo and prevent overruns */
+	/* Drain Rx FIFO, Fill Tx FIFO and prevent overruns */
 	do {
 		if (drv_data->read(drv_data)) {
 			int_transfer_complete(drv_data);
@@ -691,8 +691,8 @@ static irqreturn_t interrupt_transfer(struct driver_data *drv_data)
 		sccr1_reg &= ~SSCR1_TIE;
 
 		/*
-		 * PXA25x_SSP has no timeout, set up rx threshould for the
-		 * remaining RX bytes.
+		 * PXA25x_SSP has no timeout, set up Rx threshold for
+		 * the remaining Rx bytes.
 		 */
 		if (pxa25x_ssp_comp(drv_data)) {
 			u32 rx_thre;
@@ -914,7 +914,7 @@ static unsigned int ssp_get_clk_div(struct driver_data *drv_data, int rate)
 
 	/*
 	 * Calculate the divisor for the SCR (Serial Clock Rate), avoiding
-	 * that the SSP transmission rate can be greater than the device rate
+	 * that the SSP transmission rate can be greater than the device rate.
 	 */
 	if (ssp->type == PXA25x_SSP || ssp->type == CE4100_SSP)
 		return (DIV_ROUND_UP(ssp_clk, 2 * rate) - 1) & 0xff;
@@ -972,7 +972,7 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *controller,
 	/* Check if we can DMA this transfer */
 	if (transfer->len > MAX_DMA_LEN && chip->enable_dma) {
 
-		/* reject already-mapped transfers; PIO won't always work */
+		/* Reject already-mapped transfers; PIO won't always work */
 		if (message->is_dma_mapped
 				|| transfer->rx_dma || transfer->tx_dma) {
 			dev_err(&spi->dev,
@@ -981,7 +981,7 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *controller,
 			return -EINVAL;
 		}
 
-		/* warn ... we force this to PIO mode */
+		/* Warn ... we force this to PIO mode */
 		dev_warn_ratelimited(&spi->dev,
 				     "DMA disabled for transfer length %u greater than %d\n",
 				     transfer->len, MAX_DMA_LEN);
@@ -1026,8 +1026,8 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *controller,
 					u32_writer : null_writer;
 	}
 	/*
-	 * if bits/word is changed in dma mode, then must check the
-	 * thresholds and burst also
+	 * If bits per word is changed in DMA mode, then must check
+	 * the thresholds and burst also.
 	 */
 	if (chip->enable_dma) {
 		if (pxa2xx_spi_set_dma_burst_and_threshold(chip,
@@ -1101,10 +1101,10 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *controller,
 	if (!pxa25x_ssp_comp(drv_data))
 		pxa2xx_spi_write(drv_data, SSTO, chip->timeout);
 
-	/* first set CR1 without interrupt and service enables */
+	/* First set CR1 without interrupt and service enables */
 	pxa2xx_spi_update(drv_data, SSCR1, change_mask, cr1);
 
-	/* see if we need to reload the config registers */
+	/* See if we need to reload the configuration registers */
 	pxa2xx_spi_update(drv_data, SSCR0, GENMASK(31, 0), cr0);
 
 	/* Restart the SSP */
@@ -1114,7 +1114,7 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *controller,
 		u8 tx_level = read_SSSR_bits(drv_data, SSSR_TFL_MASK) >> 8;
 
 		if (tx_level) {
-			/* On MMP2, flipping SSE doesn't to empty TXFIFO. */
+			/* On MMP2, flipping SSE doesn't to empty Tx FIFO. */
 			dev_warn(&spi->dev, "%u bytes of garbage in Tx FIFO!\n", tx_level);
 			if (tx_level > transfer->len)
 				tx_level = transfer->len;
@@ -1134,7 +1134,7 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *controller,
 
 	/*
 	 * Release the data by enabling service requests and interrupts,
-	 * without changing any mode bits
+	 * without changing any mode bits.
 	 */
 	pxa2xx_spi_write(drv_data, SSCR1, cr1);
 
@@ -1207,12 +1207,13 @@ static int setup_cs(struct spi_device *spi, struct chip_data *chip,
 	if (drv_data->ssp_type == CE4100_SSP)
 		return 0;
 
-	/* NOTE: setup() can be called multiple times, possibly with
-	 * different chip_info, release previously requested GPIO
+	/*
+	 * NOTE: setup() can be called multiple times, possibly with
+	 * different chip_info, release previously requested GPIO.
 	 */
 	cleanup_cs(spi);
 
-	/* If (*cs_control) is provided, ignore GPIO chip select */
+	/* If ->cs_control() is provided, ignore GPIO chip select */
 	if (chip_info->cs_control) {
 		chip->cs_control = chip_info->cs_control;
 		return 0;
@@ -1288,7 +1289,7 @@ static int setup(struct spi_device *spi)
 		break;
 	}
 
-	/* Only alloc on first setup */
+	/* Only allocate on the first setup */
 	chip = spi_get_ctldata(spi);
 	if (!chip) {
 		chip = kzalloc(sizeof(struct chip_data), GFP_KERNEL);
@@ -1307,8 +1308,10 @@ static int setup(struct spi_device *spi)
 		chip->timeout = TIMOUT_DFLT;
 	}
 
-	/* protocol drivers may change the chip settings, so...
-	 * if chip_info exists, use it */
+	/*
+	 * Protocol drivers may change the chip settings, so...
+	 * if chip_info exists, use it.
+	 */
 	chip_info = spi->controller_data;
 
 	/* chip_info isn't always needed */
@@ -1344,11 +1347,13 @@ static int setup(struct spi_device *spi)
 		chip->lpss_tx_threshold = tx_thres;
 	}
 
-	/* set dma burst and threshold outside of chip_info path so that if
-	 * chip_info goes away after setting chip->enable_dma, the
-	 * burst and threshold can still respond to changes in bits_per_word */
+	/*
+	 * Set DMA burst and threshold outside of chip_info path so that if
+	 * chip_info goes away after setting chip->enable_dma, the burst and
+	 * threshold can still respond to changes in bits_per_word.
+	 */
 	if (chip->enable_dma) {
-		/* set up legal burst and threshold for dma */
+		/* Set up legal burst and threshold for DMA */
 		if (pxa2xx_spi_set_dma_burst_and_threshold(chip, spi,
 						spi->bits_per_word,
 						&chip->dma_burst_size,
@@ -1677,7 +1682,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 		ssp = &platform_info->ssp;
 
 	if (!ssp->mmio_base) {
-		dev_err(&pdev->dev, "failed to get ssp\n");
+		dev_err(&pdev->dev, "failed to get SSP\n");
 		return -ENODEV;
 	}
 
@@ -1699,7 +1704,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	controller->dev.of_node = dev->of_node;
 	controller->dev.fwnode = dev->fwnode;
 
-	/* the spi->mode bits understood by this driver: */
+	/* The spi->mode bits understood by this driver: */
 	controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LOOP;
 
 	controller->bus_num = ssp->port_id;
@@ -1787,7 +1792,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 		      QUARK_X1000_SSCR1_TxTresh(TX_THRESH_QUARK_X1000_DFLT);
 		pxa2xx_spi_write(drv_data, SSCR1, tmp);
 
-		/* using the Motorola SPI protocol and use 8 bit frame */
+		/* Using the Motorola SPI protocol and use 8 bit frame */
 		tmp = QUARK_X1000_SSCR0_Motorola | QUARK_X1000_SSCR0_DataSize(8);
 		pxa2xx_spi_write(drv_data, SSCR0, tmp);
 		break;
@@ -1859,7 +1864,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, drv_data);
 	status = spi_register_controller(controller);
 	if (status) {
-		dev_err(&pdev->dev, "problem registering spi controller\n");
+		dev_err(&pdev->dev, "problem registering SPI controller\n");
 		goto out_error_pm_runtime_enabled;
 	}
 
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index db9de46110ad..9a20fb88e50f 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Copyright (C) 2005 Stephen Street / StreetFire Sound Labs
- * Copyright (C) 2013, Intel Corporation
+ * Copyright (C) 2013, 2021 Intel Corporation
  */
 
 #ifndef SPI_PXA2XX_H
diff --git a/include/linux/pxa2xx_ssp.h b/include/linux/pxa2xx_ssp.h
index 2b21bc1f3c73..a3fec2de512f 100644
--- a/include/linux/pxa2xx_ssp.h
+++ b/include/linux/pxa2xx_ssp.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- *  Copyright (C) 2003 Russell King, All Rights Reserved.
+ * Copyright (C) 2003 Russell King, All Rights Reserved.
  *
  * This driver supports the following PXA CPU/SSP ports:-
  *
@@ -59,7 +59,7 @@ struct device_node;
 /* PXA27x, PXA3xx */
 #define SSCR0_EDSS	BIT(20)		/* Extended data size select */
 #define SSCR0_NCS	BIT(21)		/* Network clock select */
-#define SSCR0_RIM	BIT(22)		/* Receive FIFO overrrun interrupt mask */
+#define SSCR0_RIM	BIT(22)		/* Receive FIFO overrun interrupt mask */
 #define SSCR0_TUM	BIT(23)		/* Transmit FIFO underrun interrupt mask */
 #define SSCR0_FRDC	GENMASK(26, 24)	/* Frame rate divider control (mask) */
 #define SSCR0_SlotsPerFrm(x) (((x) - 1) << 24)	/* Time slots per frame [1..8] */
@@ -126,7 +126,7 @@ struct device_node;
 #define QUARK_X1000_SSCR1_EFWR	BIT(16)		/* Enable FIFO Write/Read */
 #define QUARK_X1000_SSCR1_STRF	BIT(17)		/* Select FIFO or EFWR */
 
-/* extra bits in PXA255, PXA26x and PXA27x SSP ports */
+/* Extra bits in PXA255, PXA26x and PXA27x SSP ports */
 #define SSCR0_TISSP		(1 << 4)	/* TI Sync Serial Protocol */
 #define SSCR0_PSP		(3 << 4)	/* PSP - Programmable Serial Protocol */
 
@@ -222,7 +222,8 @@ enum pxa_ssp_type {
 	CE4100_SSP,
 	MRFLD_SSP,
 	QUARK_X1000_SSP,
-	LPSS_LPT_SSP, /* Keep LPSS types sorted with lpss_platforms[] */
+	/* Keep LPSS types sorted with lpss_platforms[] */
+	LPSS_LPT_SSP,
 	LPSS_BYT_SSP,
 	LPSS_BSW_SSP,
 	LPSS_SPT_SSP,
diff --git a/include/linux/spi/pxa2xx_spi.h b/include/linux/spi/pxa2xx_spi.h
index 12ef04d0896d..eaab121ee575 100644
--- a/include/linux/spi/pxa2xx_spi.h
+++ b/include/linux/spi/pxa2xx_spi.h
@@ -14,7 +14,10 @@
 
 struct dma_chan;
 
-/* device.platform_data for SSP controller devices */
+/*
+ * The platform data for SSP controller devices
+ * (resides in device.platform_data).
+ */
 struct pxa2xx_spi_controller {
 	u16 num_chipselect;
 	u8 enable_dma;
@@ -30,8 +33,11 @@ struct pxa2xx_spi_controller {
 	struct ssp_device ssp;
 };
 
-/* spi_board_info.controller_data for SPI slave devices,
- * copied to spi_device.platform_data ... mostly for dma tuning
+/*
+ * The controller specific data for SPI slave devices
+ * (resides in spi_board_info.controller_data),
+ * copied to spi_device.platform_data ... mostly for
+ * DMA tuning.
  */
 struct pxa2xx_spi_chip {
 	u8 tx_threshold;
-- 
2.30.2

