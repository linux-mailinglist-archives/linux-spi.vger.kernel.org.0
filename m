Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11237276A25
	for <lists+linux-spi@lfdr.de>; Thu, 24 Sep 2020 09:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbgIXHLb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Sep 2020 03:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbgIXHLa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Sep 2020 03:11:30 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F3DC0613D6
        for <linux-spi@vger.kernel.org>; Thu, 24 Sep 2020 00:11:29 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id m6so2600475wrn.0
        for <linux-spi@vger.kernel.org>; Thu, 24 Sep 2020 00:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sjMK3vVhLCwOSxqkodRqn9liJA2bLSV2e3nazLfmu+E=;
        b=DCg0C44PJgqFdzEfY6LEA4FIOKl3ORmmVx57N4vvvtKGw1BKqcmhZpum8C+X/pahsT
         dn+yrsMHAPSQFTl/cA9nbH91nBJSdrkreLjDeDDdBtD9zfuPAp4Hqdu3k+Ih/okK9ViX
         6aGlp/9MRCFsZ0TBRoxx80d3olum8C6zD0h9kBPaT5NmsBPJ54cqf3CT/+3Y0Mjdd+0p
         k8QISkMSxgnBGFHzU/8te2mDWLSi+siiNkHifWMfhpu85WaKa3P8phlrsucvtR+x1zlj
         pPBhYEJ0d8c2HAyXgEEKQu6isaoD6gV6+crlkYet6pu8ERn8Xj3iNlrDctd3T7d+mNgZ
         hMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=sjMK3vVhLCwOSxqkodRqn9liJA2bLSV2e3nazLfmu+E=;
        b=CEq225g0ymbpsYkUsW6uiYl8lQ63kFLbN6fHvPbjBywSsxPKQsfiU3pJic2odEoEz+
         fbueHpEToBNFY3L9KzumluM+XkWWEwdqJdjAk+CL4xgJ9mtCrJ0AdINV0Gbupacs2gKQ
         HBab8j6tp1a42o0Y6jn8xSwPe9AamurRh9iMkzdIrCXqt5Mx0pM/KQC8pdKM1Zoe7NRf
         CtIAxbgyipdRCMYhBNGo/sZ/N0MmY2tM32ixSgbL02nYO/qxSDVmiP3Ii1+BIbxrpD3d
         vPc8PgopysZs62tVK1ADWu05hSfxUmDC6zQfrNXM8eRAYv+p9Qo27Lu+hFKI2mq76MRg
         4khg==
X-Gm-Message-State: AOAM530X4yAIhXbakaVfGs1xg1jB/wxJH2CPWPmHEeIPMbSMLl1uX9n3
        Nx6ULPyAzpWdOal/KlT0lk2gQQ==
X-Google-Smtp-Source: ABdhPJy6O74dujy5OXmUEjuBZHw4xAndIqfU1XP1ny00nRCv9QkHEkWU6q5zorapX5ra+5OZRMU3Eg==
X-Received: by 2002:a5d:67c2:: with SMTP id n2mr3298373wrw.4.1600931488199;
        Thu, 24 Sep 2020 00:11:28 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id p3sm2150104wmm.40.2020.09.24.00.11.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Sep 2020 00:11:27 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     broonie@kernel.org
Cc:     amit.kumar-mahapatra@xilinx.com, linux-kernel@vger.kernel.org,
        monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RESEND v2 PATCH 2/3] spi: spi-zynqmp-gqspi: Update driver to use spi-mem framework
Date:   Thu, 24 Sep 2020 09:11:18 +0200
Message-Id: <490a7642a975f4d3dd9618304e9e45f7e2414661.1600931476.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1600931476.git.michal.simek@xilinx.com>
References: <cover.1600931476.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>

Updated Zynqmp qspi controller driver to use spi-mem framework.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/spi/spi-zynqmp-gqspi.c | 645 +++++++++++++++++++--------------
 1 file changed, 369 insertions(+), 276 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index b479b9c3d1e6..7f57923f76ea 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -21,6 +21,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
+#include <linux/spi/spi-mem.h>
 
 /* Generic QSPI register offsets */
 #define GQSPI_CONFIG_OFST		0x00000100
@@ -153,6 +154,7 @@ enum mode_type {GQSPI_MODE_IO, GQSPI_MODE_DMA};
  * @dma_addr:		DMA address after mapping the kernel buffer
  * @genfifoentry:	Used for storing the genfifoentry instruction.
  * @mode:		Defines the mode in which QSPI is operating
+ * @data_completion:	completion structure
  */
 struct zynqmp_qspi {
 	void __iomem *regs;
@@ -170,6 +172,7 @@ struct zynqmp_qspi {
 	dma_addr_t dma_addr;
 	u32 genfifoentry;
 	enum mode_type mode;
+	struct completion data_completion;
 };
 
 /**
@@ -344,40 +347,6 @@ static void zynqmp_qspi_copy_read_data(struct zynqmp_qspi *xqspi,
 	xqspi->bytes_to_receive -= size;
 }
 
-/**
- * zynqmp_prepare_transfer_hardware - Prepares hardware for transfer.
- * @master:	Pointer to the spi_master structure which provides
- *		information about the controller.
- *
- * This function enables SPI master controller.
- *
- * Return:	0 on success; error value otherwise
- */
-static int zynqmp_prepare_transfer_hardware(struct spi_master *master)
-{
-	struct zynqmp_qspi *xqspi = spi_master_get_devdata(master);
-
-	zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, GQSPI_EN_MASK);
-	return 0;
-}
-
-/**
- * zynqmp_unprepare_transfer_hardware - Relaxes hardware after transfer
- * @master:	Pointer to the spi_master structure which provides
- *		information about the controller.
- *
- * This function disables the SPI master controller.
- *
- * Return:	Always 0
- */
-static int zynqmp_unprepare_transfer_hardware(struct spi_master *master)
-{
-	struct zynqmp_qspi *xqspi = spi_master_get_devdata(master);
-
-	zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, 0x0);
-	return 0;
-}
-
 /**
  * zynqmp_qspi_chipselect - Select or deselect the chip select line
  * @qspi:	Pointer to the spi_device structure
@@ -387,12 +356,14 @@ static void zynqmp_qspi_chipselect(struct spi_device *qspi, bool is_high)
 {
 	struct zynqmp_qspi *xqspi = spi_master_get_devdata(qspi->master);
 	ulong timeout;
-	u32 genfifoentry = 0x0, statusreg;
+	u32 genfifoentry = 0, statusreg;
 
 	genfifoentry |= GQSPI_GENFIFO_MODE_SPI;
-	genfifoentry |= xqspi->genfifobus;
 
 	if (!is_high) {
+		xqspi->genfifobus = GQSPI_GENFIFO_BUS_LOWER;
+		xqspi->genfifocs = GQSPI_GENFIFO_CS_LOWER;
+		genfifoentry |= xqspi->genfifobus;
 		genfifoentry |= xqspi->genfifocs;
 		genfifoentry |= GQSPI_GENFIFO_CS_SETUP;
 	} else {
@@ -424,11 +395,38 @@ static void zynqmp_qspi_chipselect(struct spi_device *qspi, bool is_high)
 }
 
 /**
- * zynqmp_qspi_setup_transfer - Configure QSPI controller for specified
+ * zynqmp_qspi_selectspimode - Selects SPI mode - x1 or x2 or x4.
+ * @xqspi:	xqspi is a pointer to the GQSPI instance
+ * @spimode:	spimode - SPI or DUAL or QUAD.
+ * Return:	Mask to set desired SPI mode in GENFIFO entry.
+ */
+static inline u32 zynqmp_qspi_selectspimode(struct zynqmp_qspi *xqspi,
+					    u8 spimode)
+{
+	u32 mask = 0;
+
+	switch (spimode) {
+	case GQSPI_SELECT_MODE_DUALSPI:
+		mask = GQSPI_GENFIFO_MODE_DUALSPI;
+		break;
+	case GQSPI_SELECT_MODE_QUADSPI:
+		mask = GQSPI_GENFIFO_MODE_QUADSPI;
+		break;
+	case GQSPI_SELECT_MODE_SPI:
+		mask = GQSPI_GENFIFO_MODE_SPI;
+		break;
+	default:
+		dev_warn(xqspi->dev, "Invalid SPI mode\n");
+	}
+
+	return mask;
+}
+
+/**
+ * zynqmp_qspi_config_op - Configure QSPI controller for specified
  *				transfer
+ * @xqspi:	Pointer to the zynqmp_qspi structure
  * @qspi:	Pointer to the spi_device structure
- * @transfer:	Pointer to the spi_transfer structure which provides
- *		information about next transfer setup parameters
  *
  * Sets the operational mode of QSPI controller for the next QSPI transfer and
  * sets the requested clock frequency.
@@ -445,17 +443,11 @@ static void zynqmp_qspi_chipselect(struct spi_device *qspi, bool is_high)
  *	by the QSPI controller the driver will set the highest or lowest
  *	frequency supported by controller.
  */
-static int zynqmp_qspi_setup_transfer(struct spi_device *qspi,
-				      struct spi_transfer *transfer)
+static int zynqmp_qspi_config_op(struct zynqmp_qspi *xqspi,
+				 struct spi_device *qspi)
 {
-	struct zynqmp_qspi *xqspi = spi_master_get_devdata(qspi->master);
 	ulong clk_rate;
-	u32 config_reg, req_hz, baud_rate_val = 0;
-
-	if (transfer)
-		req_hz = transfer->speed_hz;
-	else
-		req_hz = qspi->max_speed_hz;
+	u32 config_reg, baud_rate_val = 0;
 
 	/* Set the clock frequency */
 	/* If req_hz == 0, default to lowest speed */
@@ -463,7 +455,7 @@ static int zynqmp_qspi_setup_transfer(struct spi_device *qspi,
 
 	while ((baud_rate_val < GQSPI_BAUD_DIV_MAX) &&
 	       (clk_rate /
-		(GQSPI_BAUD_DIV_SHIFT << baud_rate_val)) > req_hz)
+		(GQSPI_BAUD_DIV_SHIFT << baud_rate_val)) > qspi->max_speed_hz)
 		baud_rate_val++;
 
 	config_reg = zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST);
@@ -483,7 +475,7 @@ static int zynqmp_qspi_setup_transfer(struct spi_device *qspi,
 }
 
 /**
- * zynqmp_qspi_setup - Configure the QSPI controller
+ * zynqmp_qspi_setup_op - Configure the QSPI controller
  * @qspi:	Pointer to the spi_device structure
  *
  * Sets the operational mode of QSPI controller for the next QSPI transfer,
@@ -491,10 +483,30 @@ static int zynqmp_qspi_setup_transfer(struct spi_device *qspi,
  *
  * Return:	0 on success; error value otherwise.
  */
-static int zynqmp_qspi_setup(struct spi_device *qspi)
+static int zynqmp_qspi_setup_op(struct spi_device *qspi)
 {
-	if (qspi->master->busy)
+	struct spi_controller *ctlr = qspi->master;
+	struct zynqmp_qspi *xqspi = spi_controller_get_devdata(ctlr);
+	struct device *dev = &ctlr->dev;
+	int ret;
+
+	if (ctlr->busy)
 		return -EBUSY;
+
+	ret = clk_enable(xqspi->refclk);
+	if (ret) {
+		dev_err(dev, "Cannot enable device clock.\n");
+		return ret;
+	}
+
+	ret = clk_enable(xqspi->pclk);
+	if (ret) {
+		dev_err(dev, "Cannot enable APB clock.\n");
+		clk_disable(xqspi->refclk);
+		return ret;
+	}
+	zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, GQSPI_EN_MASK);
+
 	return 0;
 }
 
@@ -552,6 +564,75 @@ static void zynqmp_qspi_readrxfifo(struct zynqmp_qspi *xqspi, u32 size)
 	}
 }
 
+/**
+ * zynqmp_qspi_fillgenfifo - Fills the GENFIFO.
+ * @xqspi:	Pointer to the zynqmp_qspi structure
+ * @nbits:	Transfer/Receive buswidth.
+ * @genfifoentry:       Variable in which GENFIFO mask is saved
+ */
+static void zynqmp_qspi_fillgenfifo(struct zynqmp_qspi *xqspi, u8 nbits,
+				    u32 genfifoentry)
+{
+	u32 transfer_len = 0;
+
+	if (xqspi->txbuf) {
+		genfifoentry &= ~GQSPI_GENFIFO_RX;
+		genfifoentry |= GQSPI_GENFIFO_DATA_XFER;
+		genfifoentry |= GQSPI_GENFIFO_TX;
+		transfer_len = xqspi->bytes_to_transfer;
+	} else {
+		genfifoentry &= ~GQSPI_GENFIFO_TX;
+		genfifoentry |= GQSPI_GENFIFO_DATA_XFER;
+		genfifoentry |= GQSPI_GENFIFO_RX;
+		if (xqspi->mode == GQSPI_MODE_DMA)
+			transfer_len = xqspi->dma_rx_bytes;
+		else
+			transfer_len = xqspi->bytes_to_receive;
+	}
+	genfifoentry |= zynqmp_qspi_selectspimode(xqspi, nbits);
+	xqspi->genfifoentry = genfifoentry;
+
+	if ((transfer_len) < GQSPI_GENFIFO_IMM_DATA_MASK) {
+		genfifoentry &= ~GQSPI_GENFIFO_IMM_DATA_MASK;
+		genfifoentry |= transfer_len;
+		zynqmp_gqspi_write(xqspi, GQSPI_GEN_FIFO_OFST, genfifoentry);
+	} else {
+		int tempcount = transfer_len;
+		u32 exponent = 8;	/* 2^8 = 256 */
+		u8 imm_data = tempcount & 0xFF;
+
+		tempcount &= ~(tempcount & 0xFF);
+		/* Immediate entry */
+		if (tempcount != 0) {
+			/* Exponent entries */
+			genfifoentry |= GQSPI_GENFIFO_EXP;
+			while (tempcount != 0) {
+				if (tempcount & GQSPI_GENFIFO_EXP_START) {
+					genfifoentry &=
+						~GQSPI_GENFIFO_IMM_DATA_MASK;
+					genfifoentry |= exponent;
+					zynqmp_gqspi_write(xqspi,
+							   GQSPI_GEN_FIFO_OFST,
+							   genfifoentry);
+				}
+				tempcount = tempcount >> 1;
+				exponent++;
+			}
+		}
+		if (imm_data != 0) {
+			genfifoentry &= ~GQSPI_GENFIFO_EXP;
+			genfifoentry &= ~GQSPI_GENFIFO_IMM_DATA_MASK;
+			genfifoentry |= (u8)(imm_data & 0xFF);
+			zynqmp_gqspi_write(xqspi, GQSPI_GEN_FIFO_OFST,
+					   genfifoentry);
+		}
+	}
+	if (xqspi->mode == GQSPI_MODE_IO && xqspi->rxbuf) {
+		/* Dummy generic FIFO entry */
+		zynqmp_gqspi_write(xqspi, GQSPI_GEN_FIFO_OFST, 0x0);
+	}
+}
+
 /**
  * zynqmp_process_dma_irq - Handler for DMA done interrupt of QSPI
  *				controller
@@ -614,9 +695,8 @@ static void zynqmp_process_dma_irq(struct zynqmp_qspi *xqspi)
  */
 static irqreturn_t zynqmp_qspi_irq(int irq, void *dev_id)
 {
-	struct spi_master *master = dev_id;
-	struct zynqmp_qspi *xqspi = spi_master_get_devdata(master);
-	int ret = IRQ_NONE;
+	struct zynqmp_qspi *xqspi = (struct zynqmp_qspi *)dev_id;
+	irqreturn_t ret = IRQ_NONE;
 	u32 status, mask, dma_status = 0;
 
 	status = zynqmp_gqspi_read(xqspi, GQSPI_ISR_OFST);
@@ -648,45 +728,17 @@ static irqreturn_t zynqmp_qspi_irq(int irq, void *dev_id)
 	if ((xqspi->bytes_to_receive == 0) && (xqspi->bytes_to_transfer == 0)
 			&& ((status & GQSPI_IRQ_MASK) == GQSPI_IRQ_MASK)) {
 		zynqmp_gqspi_write(xqspi, GQSPI_IDR_OFST, GQSPI_ISR_IDR_MASK);
-		spi_finalize_current_transfer(master);
+		complete(&xqspi->data_completion);
 		ret = IRQ_HANDLED;
 	}
 	return ret;
 }
 
 /**
- * zynqmp_qspi_selectspimode - Selects SPI mode - x1 or x2 or x4.
- * @xqspi:	xqspi is a pointer to the GQSPI instance
- * @spimode:	spimode - SPI or DUAL or QUAD.
- * Return:	Mask to set desired SPI mode in GENFIFO entry.
- */
-static inline u32 zynqmp_qspi_selectspimode(struct zynqmp_qspi *xqspi,
-						u8 spimode)
-{
-	u32 mask = 0;
-
-	switch (spimode) {
-	case GQSPI_SELECT_MODE_DUALSPI:
-		mask = GQSPI_GENFIFO_MODE_DUALSPI;
-		break;
-	case GQSPI_SELECT_MODE_QUADSPI:
-		mask = GQSPI_GENFIFO_MODE_QUADSPI;
-		break;
-	case GQSPI_SELECT_MODE_SPI:
-		mask = GQSPI_GENFIFO_MODE_SPI;
-		break;
-	default:
-		dev_warn(xqspi->dev, "Invalid SPI mode\n");
-	}
-
-	return mask;
-}
-
-/**
- * zynq_qspi_setuprxdma - This function sets up the RX DMA operation
+ * zynqmp_qspi_setuprxdma - This function sets up the RX DMA operation
  * @xqspi:	xqspi is a pointer to the GQSPI instance.
  */
-static void zynq_qspi_setuprxdma(struct zynqmp_qspi *xqspi)
+static void zynqmp_qspi_setuprxdma(struct zynqmp_qspi *xqspi)
 {
 	u32 rx_bytes, rx_rem, config_reg;
 	dma_addr_t addr;
@@ -733,162 +785,44 @@ static void zynq_qspi_setuprxdma(struct zynqmp_qspi *xqspi)
 }
 
 /**
- * zynqmp_qspi_txrxsetup - This function checks the TX/RX buffers in
- *				the transfer and sets up the GENFIFO entries,
- *				TX FIFO as required.
- * @xqspi:	xqspi is a pointer to the GQSPI instance.
- * @transfer:	It is a pointer to the structure containing transfer data.
- * @genfifoentry:	genfifoentry is pointer to the variable in which
- *			GENFIFO	mask is returned to calling function
+ * zynqmp_qspi_write_op - This function sets up the GENFIFO entries,
+ *			TX FIFO, and fills the TX FIFO with as many
+ *			bytes as possible.
+ * @xqspi:	Pointer to the GQSPI instance.
+ * @tx_nbits:	Transfer buswidth.
+ * @genfifoentry:	Variable in which GENFIFO mask is returned
+ *			to calling function
  */
-static void zynqmp_qspi_txrxsetup(struct zynqmp_qspi *xqspi,
-				  struct spi_transfer *transfer,
-				  u32 *genfifoentry)
+static void zynqmp_qspi_write_op(struct zynqmp_qspi *xqspi, u8 tx_nbits,
+				 u32 genfifoentry)
 {
 	u32 config_reg;
 
-	/* Transmit */
-	if ((xqspi->txbuf != NULL) && (xqspi->rxbuf == NULL)) {
-		/* Setup data to be TXed */
-		*genfifoentry &= ~GQSPI_GENFIFO_RX;
-		*genfifoentry |= GQSPI_GENFIFO_DATA_XFER;
-		*genfifoentry |= GQSPI_GENFIFO_TX;
-		*genfifoentry |=
-			zynqmp_qspi_selectspimode(xqspi, transfer->tx_nbits);
-		xqspi->bytes_to_transfer = transfer->len;
-		if (xqspi->mode == GQSPI_MODE_DMA) {
-			config_reg = zynqmp_gqspi_read(xqspi,
-							GQSPI_CONFIG_OFST);
-			config_reg &= ~GQSPI_CFG_MODE_EN_MASK;
-			zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST,
-								config_reg);
-			xqspi->mode = GQSPI_MODE_IO;
-		}
-		zynqmp_qspi_filltxfifo(xqspi, GQSPI_TXD_DEPTH);
-		/* Discard RX data */
-		xqspi->bytes_to_receive = 0;
-	} else if ((xqspi->txbuf == NULL) && (xqspi->rxbuf != NULL)) {
-		/* Receive */
-
-		/* TX auto fill */
-		*genfifoentry &= ~GQSPI_GENFIFO_TX;
-		/* Setup RX */
-		*genfifoentry |= GQSPI_GENFIFO_DATA_XFER;
-		*genfifoentry |= GQSPI_GENFIFO_RX;
-		*genfifoentry |=
-			zynqmp_qspi_selectspimode(xqspi, transfer->rx_nbits);
-		xqspi->bytes_to_transfer = 0;
-		xqspi->bytes_to_receive = transfer->len;
-		zynq_qspi_setuprxdma(xqspi);
+	zynqmp_qspi_fillgenfifo(xqspi, tx_nbits, genfifoentry);
+	zynqmp_qspi_filltxfifo(xqspi, GQSPI_TXD_DEPTH);
+	if (xqspi->mode == GQSPI_MODE_DMA) {
+		config_reg = zynqmp_gqspi_read(xqspi,
+					       GQSPI_CONFIG_OFST);
+		config_reg &= ~GQSPI_CFG_MODE_EN_MASK;
+		zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST,
+				   config_reg);
+		xqspi->mode = GQSPI_MODE_IO;
 	}
 }
 
 /**
- * zynqmp_qspi_start_transfer - Initiates the QSPI transfer
- * @master:	Pointer to the spi_master structure which provides
- *		information about the controller.
- * @qspi:	Pointer to the spi_device structure
- * @transfer:	Pointer to the spi_transfer structure which provide information
- *		about next transfer parameters
- *
- * This function fills the TX FIFO, starts the QSPI transfer, and waits for the
- * transfer to be completed.
- *
- * Return:	Number of bytes transferred in the last transfer
+ * zynqmp_qspi_read_op - This function sets up the GENFIFO entries and
+ *				RX DMA operation.
+ * @xqspi:	xqspi is a pointer to the GQSPI instance.
+ * @rx_nbits:	Receive buswidth.
+ * @genfifoentry:	genfifoentry is pointer to the variable in which
+ *			GENFIFO	mask is returned to calling function
  */
-static int zynqmp_qspi_start_transfer(struct spi_master *master,
-				      struct spi_device *qspi,
-				      struct spi_transfer *transfer)
+static void zynqmp_qspi_read_op(struct zynqmp_qspi *xqspi, u8 rx_nbits,
+				u32 genfifoentry)
 {
-	struct zynqmp_qspi *xqspi = spi_master_get_devdata(master);
-	u32 genfifoentry = 0x0, transfer_len;
-
-	xqspi->txbuf = transfer->tx_buf;
-	xqspi->rxbuf = transfer->rx_buf;
-
-	zynqmp_qspi_setup_transfer(qspi, transfer);
-
-	genfifoentry |= xqspi->genfifocs;
-	genfifoentry |= xqspi->genfifobus;
-
-	zynqmp_qspi_txrxsetup(xqspi, transfer, &genfifoentry);
-
-	if (xqspi->mode == GQSPI_MODE_DMA)
-		transfer_len = xqspi->dma_rx_bytes;
-	else
-		transfer_len = transfer->len;
-
-	xqspi->genfifoentry = genfifoentry;
-	if ((transfer_len) < GQSPI_GENFIFO_IMM_DATA_MASK) {
-		genfifoentry &= ~GQSPI_GENFIFO_IMM_DATA_MASK;
-		genfifoentry |= transfer_len;
-		zynqmp_gqspi_write(xqspi, GQSPI_GEN_FIFO_OFST, genfifoentry);
-	} else {
-		int tempcount = transfer_len;
-		u32 exponent = 8;	/* 2^8 = 256 */
-		u8 imm_data = tempcount & 0xFF;
-
-		tempcount &= ~(tempcount & 0xFF);
-		/* Immediate entry */
-		if (tempcount != 0) {
-			/* Exponent entries */
-			genfifoentry |= GQSPI_GENFIFO_EXP;
-			while (tempcount != 0) {
-				if (tempcount & GQSPI_GENFIFO_EXP_START) {
-					genfifoentry &=
-					    ~GQSPI_GENFIFO_IMM_DATA_MASK;
-					genfifoentry |= exponent;
-					zynqmp_gqspi_write(xqspi,
-							   GQSPI_GEN_FIFO_OFST,
-							   genfifoentry);
-				}
-				tempcount = tempcount >> 1;
-				exponent++;
-			}
-		}
-		if (imm_data != 0) {
-			genfifoentry &= ~GQSPI_GENFIFO_EXP;
-			genfifoentry &= ~GQSPI_GENFIFO_IMM_DATA_MASK;
-			genfifoentry |= (u8) (imm_data & 0xFF);
-			zynqmp_gqspi_write(xqspi,
-					   GQSPI_GEN_FIFO_OFST, genfifoentry);
-		}
-	}
-
-	if ((xqspi->mode == GQSPI_MODE_IO) &&
-			(xqspi->rxbuf != NULL)) {
-		/* Dummy generic FIFO entry */
-		zynqmp_gqspi_write(xqspi, GQSPI_GEN_FIFO_OFST, 0x0);
-	}
-
-	/* Since we are using manual mode */
-	zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST,
-			   zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST) |
-			   GQSPI_CFG_START_GEN_FIFO_MASK);
-
-	if (xqspi->txbuf != NULL)
-		/* Enable interrupts for TX */
-		zynqmp_gqspi_write(xqspi, GQSPI_IER_OFST,
-				   GQSPI_IER_TXEMPTY_MASK |
-					GQSPI_IER_GENFIFOEMPTY_MASK |
-					GQSPI_IER_TXNOT_FULL_MASK);
-
-	if (xqspi->rxbuf != NULL) {
-		/* Enable interrupts for RX */
-		if (xqspi->mode == GQSPI_MODE_DMA) {
-			/* Enable DMA interrupts */
-			zynqmp_gqspi_write(xqspi,
-					GQSPI_QSPIDMA_DST_I_EN_OFST,
-					GQSPI_QSPIDMA_DST_I_EN_DONE_MASK);
-		} else {
-			zynqmp_gqspi_write(xqspi, GQSPI_IER_OFST,
-					GQSPI_IER_GENFIFOEMPTY_MASK |
-					GQSPI_IER_RXNEMPTY_MASK |
-					GQSPI_IER_RXEMPTY_MASK);
-		}
-	}
-
-	return transfer->len;
+	zynqmp_qspi_fillgenfifo(xqspi, rx_nbits, genfifoentry);
+	zynqmp_qspi_setuprxdma(xqspi);
 }
 
 /**
@@ -901,11 +835,12 @@ static int zynqmp_qspi_start_transfer(struct spi_master *master,
  */
 static int __maybe_unused zynqmp_qspi_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
+	struct spi_controller *ctlr = dev_get_drvdata(dev);
+	struct zynqmp_qspi *xqspi = spi_controller_get_devdata(ctlr);
 
-	spi_master_suspend(master);
+	spi_controller_suspend(ctlr);
 
-	zynqmp_unprepare_transfer_hardware(master);
+	zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, 0x0);
 
 	return 0;
 }
@@ -921,8 +856,8 @@ static int __maybe_unused zynqmp_qspi_suspend(struct device *dev)
  */
 static int __maybe_unused zynqmp_qspi_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct zynqmp_qspi *xqspi = spi_master_get_devdata(master);
+	struct spi_controller *ctlr = dev_get_drvdata(dev);
+	struct zynqmp_qspi *xqspi = spi_controller_get_devdata(ctlr);
 	int ret = 0;
 
 	ret = clk_enable(xqspi->pclk);
@@ -938,7 +873,7 @@ static int __maybe_unused zynqmp_qspi_resume(struct device *dev)
 		return ret;
 	}
 
-	spi_master_resume(master);
+	spi_controller_resume(ctlr);
 
 	clk_disable(xqspi->refclk);
 	clk_disable(xqspi->pclk);
@@ -955,8 +890,7 @@ static int __maybe_unused zynqmp_qspi_resume(struct device *dev)
  */
 static int __maybe_unused zynqmp_runtime_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct zynqmp_qspi *xqspi = spi_master_get_devdata(master);
+	struct zynqmp_qspi *xqspi = (struct zynqmp_qspi *)dev_get_drvdata(dev);
 
 	clk_disable(xqspi->refclk);
 	clk_disable(xqspi->pclk);
@@ -974,8 +908,7 @@ static int __maybe_unused zynqmp_runtime_suspend(struct device *dev)
  */
 static int __maybe_unused zynqmp_runtime_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct zynqmp_qspi *xqspi = spi_master_get_devdata(master);
+	struct zynqmp_qspi *xqspi = (struct zynqmp_qspi *)dev_get_drvdata(dev);
 	int ret;
 
 	ret = clk_enable(xqspi->pclk);
@@ -994,12 +927,177 @@ static int __maybe_unused zynqmp_runtime_resume(struct device *dev)
 	return 0;
 }
 
+/**
+ * zynqmp_qspi_exec_op() - Initiates the QSPI transfer
+ * @mem: The SPI memory
+ * @op: The memory operation to execute
+ *
+ * Executes a memory operation.
+ *
+ * This function first selects the chip and starts the memory operation.
+ *
+ * Return: 0 in case of success, a negative error code otherwise.
+ */
+static int zynqmp_qspi_exec_op(struct spi_mem *mem,
+			       const struct spi_mem_op *op)
+{
+	struct zynqmp_qspi *xqspi = spi_controller_get_devdata
+				    (mem->spi->master);
+	int err = 0, i;
+	u8 *tmpbuf;
+	u32 genfifoentry = 0;
+
+	dev_dbg(xqspi->dev, "cmd:%#x mode:%d.%d.%d.%d\n",
+		op->cmd.opcode, op->cmd.buswidth, op->addr.buswidth,
+		op->dummy.buswidth, op->data.buswidth);
+
+	zynqmp_qspi_config_op(xqspi, mem->spi);
+	zynqmp_qspi_chipselect(mem->spi, false);
+	genfifoentry |= xqspi->genfifocs;
+	genfifoentry |= xqspi->genfifobus;
+
+	if (op->cmd.opcode) {
+		tmpbuf = kzalloc(op->cmd.nbytes, GFP_KERNEL | GFP_DMA);
+		if (!tmpbuf)
+			return -ENOMEM;
+		tmpbuf[0] = op->cmd.opcode;
+		reinit_completion(&xqspi->data_completion);
+		xqspi->txbuf = tmpbuf;
+		xqspi->rxbuf = NULL;
+		xqspi->bytes_to_transfer = op->cmd.nbytes;
+		xqspi->bytes_to_receive = 0;
+		zynqmp_qspi_write_op(xqspi, op->cmd.buswidth, genfifoentry);
+		zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST,
+				   zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST) |
+				   GQSPI_CFG_START_GEN_FIFO_MASK);
+		zynqmp_gqspi_write(xqspi, GQSPI_IER_OFST,
+				   GQSPI_IER_GENFIFOEMPTY_MASK |
+				   GQSPI_IER_TXNOT_FULL_MASK);
+		if (!wait_for_completion_interruptible_timeout
+		    (&xqspi->data_completion, msecs_to_jiffies(1000))) {
+			err = -ETIMEDOUT;
+			kfree(tmpbuf);
+			goto return_err;
+		}
+		kfree(tmpbuf);
+	}
+
+	if (op->addr.nbytes) {
+		for (i = 0; i < op->addr.nbytes; i++) {
+			*(((u8 *)xqspi->txbuf) + i) = op->addr.val >>
+					(8 * (op->addr.nbytes - i - 1));
+		}
+
+		reinit_completion(&xqspi->data_completion);
+		xqspi->rxbuf = NULL;
+		xqspi->bytes_to_transfer = op->addr.nbytes;
+		xqspi->bytes_to_receive = 0;
+		zynqmp_qspi_write_op(xqspi, op->addr.buswidth, genfifoentry);
+		zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST,
+				   zynqmp_gqspi_read(xqspi,
+						     GQSPI_CONFIG_OFST) |
+				   GQSPI_CFG_START_GEN_FIFO_MASK);
+		zynqmp_gqspi_write(xqspi, GQSPI_IER_OFST,
+				   GQSPI_IER_TXEMPTY_MASK |
+				   GQSPI_IER_GENFIFOEMPTY_MASK |
+				   GQSPI_IER_TXNOT_FULL_MASK);
+		if (!wait_for_completion_interruptible_timeout
+		    (&xqspi->data_completion, msecs_to_jiffies(1000))) {
+			err = -ETIMEDOUT;
+			goto return_err;
+		}
+	}
+
+	if (op->dummy.nbytes) {
+		tmpbuf = kzalloc(op->dummy.nbytes, GFP_KERNEL | GFP_DMA);
+		if (!tmpbuf)
+			return -ENOMEM;
+		memset(tmpbuf, 0xff, op->dummy.nbytes);
+		reinit_completion(&xqspi->data_completion);
+		xqspi->txbuf = tmpbuf;
+		xqspi->rxbuf = NULL;
+		xqspi->bytes_to_transfer = op->dummy.nbytes;
+		xqspi->bytes_to_receive = 0;
+		zynqmp_qspi_write_op(xqspi, op->dummy.buswidth,
+				     genfifoentry);
+		zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST,
+				   zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST) |
+				   GQSPI_CFG_START_GEN_FIFO_MASK);
+		zynqmp_gqspi_write(xqspi, GQSPI_IER_OFST,
+				   GQSPI_IER_TXEMPTY_MASK |
+				   GQSPI_IER_GENFIFOEMPTY_MASK |
+				   GQSPI_IER_TXNOT_FULL_MASK);
+		if (!wait_for_completion_interruptible_timeout
+		    (&xqspi->data_completion, msecs_to_jiffies(1000))) {
+			err = -ETIMEDOUT;
+			kfree(tmpbuf);
+			goto return_err;
+		}
+
+		kfree(tmpbuf);
+	}
+
+	if (op->data.nbytes) {
+		reinit_completion(&xqspi->data_completion);
+		if (op->data.dir == SPI_MEM_DATA_OUT) {
+			xqspi->txbuf = (u8 *)op->data.buf.out;
+			xqspi->rxbuf = NULL;
+			xqspi->bytes_to_transfer = op->data.nbytes;
+			xqspi->bytes_to_receive = 0;
+			zynqmp_qspi_write_op(xqspi, op->data.buswidth,
+					     genfifoentry);
+			zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST,
+					   zynqmp_gqspi_read
+					   (xqspi, GQSPI_CONFIG_OFST) |
+					   GQSPI_CFG_START_GEN_FIFO_MASK);
+			zynqmp_gqspi_write(xqspi, GQSPI_IER_OFST,
+					   GQSPI_IER_TXEMPTY_MASK |
+					   GQSPI_IER_GENFIFOEMPTY_MASK |
+					   GQSPI_IER_TXNOT_FULL_MASK);
+		} else {
+			xqspi->txbuf = NULL;
+			xqspi->rxbuf = (u8 *)op->data.buf.in;
+			xqspi->bytes_to_receive = op->data.nbytes;
+			xqspi->bytes_to_transfer = 0;
+			zynqmp_qspi_read_op(xqspi, op->data.buswidth,
+					    genfifoentry);
+			zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST,
+					   zynqmp_gqspi_read
+					   (xqspi, GQSPI_CONFIG_OFST) |
+					   GQSPI_CFG_START_GEN_FIFO_MASK);
+			if (xqspi->mode == GQSPI_MODE_DMA) {
+				zynqmp_gqspi_write
+					(xqspi, GQSPI_QSPIDMA_DST_I_EN_OFST,
+					 GQSPI_QSPIDMA_DST_I_EN_DONE_MASK);
+			} else {
+				zynqmp_gqspi_write(xqspi, GQSPI_IER_OFST,
+						   GQSPI_IER_GENFIFOEMPTY_MASK |
+						   GQSPI_IER_RXNEMPTY_MASK |
+						   GQSPI_IER_RXEMPTY_MASK);
+			}
+		}
+		if (!wait_for_completion_interruptible_timeout
+		    (&xqspi->data_completion, msecs_to_jiffies(1000)))
+			err = -ETIMEDOUT;
+	}
+
+return_err:
+
+	zynqmp_qspi_chipselect(mem->spi, true);
+
+	return err;
+}
+
 static const struct dev_pm_ops zynqmp_qspi_dev_pm_ops = {
 	SET_RUNTIME_PM_OPS(zynqmp_runtime_suspend,
 			   zynqmp_runtime_resume, NULL)
 	SET_SYSTEM_SLEEP_PM_OPS(zynqmp_qspi_suspend, zynqmp_qspi_resume)
 };
 
+static const struct spi_controller_mem_ops zynqmp_qspi_mem_ops = {
+	.exec_op = zynqmp_qspi_exec_op,
+};
+
 /**
  * zynqmp_qspi_probe - Probe method for the QSPI driver
  * @pdev:	Pointer to the platform_device structure
@@ -1011,17 +1109,18 @@ static const struct dev_pm_ops zynqmp_qspi_dev_pm_ops = {
 static int zynqmp_qspi_probe(struct platform_device *pdev)
 {
 	int ret = 0;
-	struct spi_master *master;
+	struct spi_controller *ctlr;
 	struct zynqmp_qspi *xqspi;
 	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*xqspi));
-	if (!master)
+	ctlr = spi_alloc_master(&pdev->dev, sizeof(*xqspi));
+	if (!ctlr)
 		return -ENOMEM;
 
-	xqspi = spi_master_get_devdata(master);
-	master->dev.of_node = pdev->dev.of_node;
-	platform_set_drvdata(pdev, master);
+	xqspi = spi_controller_get_devdata(ctlr);
+	xqspi->dev = dev;
+	platform_set_drvdata(pdev, xqspi);
 
 	xqspi->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(xqspi->regs)) {
@@ -1029,7 +1128,6 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 		goto remove_master;
 	}
 
-	xqspi->dev = dev;
 	xqspi->pclk = devm_clk_get(&pdev->dev, "pclk");
 	if (IS_ERR(xqspi->pclk)) {
 		dev_err(dev, "pclk clock not found.\n");
@@ -1037,11 +1135,7 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 		goto remove_master;
 	}
 
-	ret = clk_prepare_enable(xqspi->pclk);
-	if (ret) {
-		dev_err(dev, "Unable to enable APB clock.\n");
-		goto remove_master;
-	}
+	init_completion(&xqspi->data_completion);
 
 	xqspi->refclk = devm_clk_get(&pdev->dev, "ref_clk");
 	if (IS_ERR(xqspi->refclk)) {
@@ -1050,6 +1144,12 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 		goto clk_dis_pclk;
 	}
 
+	ret = clk_prepare_enable(xqspi->pclk);
+	if (ret) {
+		dev_err(dev, "Unable to enable APB clock.\n");
+		goto remove_master;
+	}
+
 	ret = clk_prepare_enable(xqspi->refclk);
 	if (ret) {
 		dev_err(dev, "Unable to enable device clock.\n");
@@ -1071,32 +1171,28 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 		goto clk_dis_all;
 	}
 	ret = devm_request_irq(&pdev->dev, xqspi->irq, zynqmp_qspi_irq,
-			       0, pdev->name, master);
+			       0, pdev->name, xqspi);
 	if (ret != 0) {
 		ret = -ENXIO;
 		dev_err(dev, "request_irq failed\n");
 		goto clk_dis_all;
 	}
 
-	master->num_chipselect = GQSPI_DEFAULT_NUM_CS;
-
-	master->setup = zynqmp_qspi_setup;
-	master->set_cs = zynqmp_qspi_chipselect;
-	master->transfer_one = zynqmp_qspi_start_transfer;
-	master->prepare_transfer_hardware = zynqmp_prepare_transfer_hardware;
-	master->unprepare_transfer_hardware =
-					zynqmp_unprepare_transfer_hardware;
-	master->max_speed_hz = clk_get_rate(xqspi->refclk) / 2;
-	master->bits_per_word_mask = SPI_BPW_MASK(8);
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QUAD |
+	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
+	ctlr->num_chipselect = GQSPI_DEFAULT_NUM_CS;
+	ctlr->mem_ops = &zynqmp_qspi_mem_ops;
+	ctlr->setup = zynqmp_qspi_setup_op;
+	ctlr->max_speed_hz = clk_get_rate(xqspi->refclk) / 2;
+	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
+	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QUAD |
 			    SPI_TX_DUAL | SPI_TX_QUAD;
+	ctlr->dev.of_node = np;
 
-	if (master->dev.parent == NULL)
-		master->dev.parent = &master->dev;
-
-	ret = spi_register_master(master);
-	if (ret)
+	ret = devm_spi_register_controller(&pdev->dev, ctlr);
+	if (ret) {
+		dev_err(&pdev->dev, "spi_register_controller failed\n");
 		goto clk_dis_all;
+	}
 
 	return 0;
 
@@ -1107,7 +1203,7 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 clk_dis_pclk:
 	clk_disable_unprepare(xqspi->pclk);
 remove_master:
-	spi_master_put(master);
+	spi_controller_put(ctlr);
 
 	return ret;
 }
@@ -1124,8 +1220,7 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
  */
 static int zynqmp_qspi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct zynqmp_qspi *xqspi = spi_master_get_devdata(master);
+	struct zynqmp_qspi *xqspi = platform_get_drvdata(pdev);
 
 	zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, 0x0);
 	clk_disable_unprepare(xqspi->refclk);
@@ -1133,8 +1228,6 @@ static int zynqmp_qspi_remove(struct platform_device *pdev)
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-	spi_unregister_master(master);
-
 	return 0;
 }
 
-- 
2.28.0

