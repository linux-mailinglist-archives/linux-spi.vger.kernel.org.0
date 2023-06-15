Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B70731196
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jun 2023 09:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239132AbjFOH7J (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Jun 2023 03:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239248AbjFOH7F (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 15 Jun 2023 03:59:05 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131B61709;
        Thu, 15 Jun 2023 00:59:02 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35F6C7WZ016397;
        Thu, 15 Jun 2023 09:58:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=h4BKIL1e9bnW0s1IYBnDkWGil7s+SMC0Tu1DnQV+DKQ=;
 b=jEF5ZZp09RAhKYMcDTy6G++dWiTVzSfCMnH09QS7lNcraAUezNjTxo/UgksbdYOvgpn9
 VWK5xE+XE33xpfYUy3Qb7xxI7/QQP9fVEFKJOJpabbCuBSS0ZT6MQS5kyoELQg9ZQeNG
 Izt0zTiPIbsnqRmea0FkDTo7qKuyE6gVxcjBC5K0siKiw22AKJ6k6ddjIyKfPXk0RUV7
 Ove9D0EYZG1UXtUuTZ3q6xRFC7JBgDMs5b4u0XhwPnGUC66lQVP2uzE+UmWdSLET6Yt+
 tEqbWCgAFzRXMiuEULeSNRfbs8uCMF1H+wNXg7/ZK2GF+oR9oqkcqQwQizOYxQIUvAun Cg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3r795qyq4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 09:58:51 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 37C9810002A;
        Thu, 15 Jun 2023 09:58:51 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2EEE62115F0;
        Thu, 15 Jun 2023 09:58:51 +0200 (CEST)
Received: from localhost (10.252.8.64) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 15 Jun
 2023 09:58:50 +0200
From:   Valentin Caron <valentin.caron@foss.st.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Valentin Caron <valentin.caron@foss.st.com>
Subject: [PATCH v3 4/4] spi: stm32: introduction of stm32h7 SPI device mode support
Date:   Thu, 15 Jun 2023 09:58:15 +0200
Message-ID: <20230615075815.310261-5-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230615075815.310261-1-valentin.caron@foss.st.com>
References: <20230615075815.310261-1-valentin.caron@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.8.64]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-15_04,2023-06-14_02,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add support for stm32h7 to use SPI controller in device role.
In such case, the spi instance should have the spi-slave property
defined.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 drivers/spi/Kconfig     |   1 +
 drivers/spi/spi-stm32.c | 112 ++++++++++++++++++++++++++++------------
 2 files changed, 79 insertions(+), 34 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 3de2ebe8294a..14810d24733b 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -936,6 +936,7 @@ config SPI_SPRD_ADI
 config SPI_STM32
 	tristate "STMicroelectronics STM32 SPI controller"
 	depends on ARCH_STM32 || COMPILE_TEST
+	select SPI_SLAVE
 	help
 	  SPI driver for STMicroelectronics STM32 SoCs.
 
diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 82fbd20e8a96..6d10fa4ab783 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -117,6 +117,7 @@
 #define STM32H7_SPI_CFG2_CPHA		BIT(24)
 #define STM32H7_SPI_CFG2_CPOL		BIT(25)
 #define STM32H7_SPI_CFG2_SSM		BIT(26)
+#define STM32H7_SPI_CFG2_SSIOP		BIT(28)
 #define STM32H7_SPI_CFG2_AFCNTR		BIT(31)
 
 /* STM32H7_SPI_IER bit fields */
@@ -170,6 +171,10 @@
  */
 #define SPI_DMA_MIN_BYTES	16
 
+/* STM32 SPI driver helpers */
+#define STM32_SPI_MASTER_MODE(stm32_spi) (!(stm32_spi)->device_mode)
+#define STM32_SPI_DEVICE_MODE(stm32_spi) ((stm32_spi)->device_mode)
+
 /**
  * struct stm32_spi_reg - stm32 SPI register & bitfield desc
  * @reg:		register offset
@@ -190,6 +195,7 @@ struct stm32_spi_reg {
  * @cpol: clock polarity register and polarity bit
  * @cpha: clock phase register and phase bit
  * @lsb_first: LSB transmitted first register and bit
+ * @cs_high: chips select active value
  * @br: baud rate register and bitfields
  * @rx: SPI RX data register
  * @tx: SPI TX data register
@@ -201,6 +207,7 @@ struct stm32_spi_regspec {
 	const struct stm32_spi_reg cpol;
 	const struct stm32_spi_reg cpha;
 	const struct stm32_spi_reg lsb_first;
+	const struct stm32_spi_reg cs_high;
 	const struct stm32_spi_reg br;
 	const struct stm32_spi_reg rx;
 	const struct stm32_spi_reg tx;
@@ -280,6 +287,7 @@ struct stm32_spi_cfg {
  * @dma_tx: dma channel for TX transfer
  * @dma_rx: dma channel for RX transfer
  * @phys_addr: SPI registers physical base address
+ * @device_mode: the controller is configured as SPI device
  */
 struct stm32_spi {
 	struct device *dev;
@@ -307,6 +315,8 @@ struct stm32_spi {
 	struct dma_chan *dma_tx;
 	struct dma_chan *dma_rx;
 	dma_addr_t phys_addr;
+
+	bool device_mode;
 };
 
 static const struct stm32_spi_regspec stm32f4_spi_regspec = {
@@ -318,6 +328,7 @@ static const struct stm32_spi_regspec stm32f4_spi_regspec = {
 	.cpol = { STM32F4_SPI_CR1, STM32F4_SPI_CR1_CPOL },
 	.cpha = { STM32F4_SPI_CR1, STM32F4_SPI_CR1_CPHA },
 	.lsb_first = { STM32F4_SPI_CR1, STM32F4_SPI_CR1_LSBFRST },
+	.cs_high = {},
 	.br = { STM32F4_SPI_CR1, STM32F4_SPI_CR1_BR, STM32F4_SPI_CR1_BR_SHIFT },
 
 	.rx = { STM32F4_SPI_DR },
@@ -336,6 +347,7 @@ static const struct stm32_spi_regspec stm32h7_spi_regspec = {
 	.cpol = { STM32H7_SPI_CFG2, STM32H7_SPI_CFG2_CPOL },
 	.cpha = { STM32H7_SPI_CFG2, STM32H7_SPI_CFG2_CPHA },
 	.lsb_first = { STM32H7_SPI_CFG2, STM32H7_SPI_CFG2_LSBFRST },
+	.cs_high = { STM32H7_SPI_CFG2, STM32H7_SPI_CFG2_SSIOP },
 	.br = { STM32H7_SPI_CFG1, STM32H7_SPI_CFG1_MBR,
 		STM32H7_SPI_CFG1_MBR_SHIFT },
 
@@ -971,6 +983,11 @@ static int stm32_spi_prepare_msg(struct spi_controller *ctrl,
 	else
 		clrb |= spi->cfg->regs->lsb_first.mask;
 
+	if (STM32_SPI_DEVICE_MODE(spi) && spi_dev->mode & SPI_CS_HIGH)
+		setb |= spi->cfg->regs->cs_high.mask;
+	else
+		clrb |= spi->cfg->regs->cs_high.mask;
+
 	dev_dbg(spi->dev, "cpol=%d cpha=%d lsb_first=%d cs_high=%d\n",
 		!!(spi_dev->mode & SPI_CPOL),
 		!!(spi_dev->mode & SPI_CPHA),
@@ -1161,7 +1178,8 @@ static int stm32h7_spi_transfer_one_irq(struct stm32_spi *spi)
 	if (spi->tx_buf)
 		stm32h7_spi_write_txfifo(spi);
 
-	stm32_spi_set_bits(spi, STM32H7_SPI_CR1, STM32H7_SPI_CR1_CSTART);
+	if (STM32_SPI_MASTER_MODE(spi))
+		stm32_spi_set_bits(spi, STM32H7_SPI_CR1, STM32H7_SPI_CR1_CSTART);
 
 	writel_relaxed(ier, spi->base + STM32H7_SPI_IER);
 
@@ -1208,7 +1226,8 @@ static void stm32h7_spi_transfer_one_dma_start(struct stm32_spi *spi)
 
 	stm32_spi_enable(spi);
 
-	stm32_spi_set_bits(spi, STM32H7_SPI_CR1, STM32H7_SPI_CR1_CSTART);
+	if (STM32_SPI_MASTER_MODE(spi))
+		stm32_spi_set_bits(spi, STM32H7_SPI_CR1, STM32H7_SPI_CR1_CSTART);
 }
 
 /**
@@ -1536,16 +1555,18 @@ static int stm32_spi_transfer_one_setup(struct stm32_spi *spi,
 	spi->cfg->set_bpw(spi);
 
 	/* Update spi->cur_speed with real clock speed */
-	mbr = stm32_spi_prepare_mbr(spi, transfer->speed_hz,
-				    spi->cfg->baud_rate_div_min,
-				    spi->cfg->baud_rate_div_max);
-	if (mbr < 0) {
-		ret = mbr;
-		goto out;
-	}
+	if (STM32_SPI_MASTER_MODE(spi)) {
+		mbr = stm32_spi_prepare_mbr(spi, transfer->speed_hz,
+					    spi->cfg->baud_rate_div_min,
+					    spi->cfg->baud_rate_div_max);
+		if (mbr < 0) {
+			ret = mbr;
+			goto out;
+		}
 
-	transfer->speed_hz = spi->cur_speed;
-	stm32_spi_set_mbr(spi, mbr);
+		transfer->speed_hz = spi->cur_speed;
+		stm32_spi_set_mbr(spi, mbr);
+	}
 
 	comm_type = stm32_spi_communication_type(spi_dev, transfer);
 	ret = spi->cfg->set_mode(spi, comm_type);
@@ -1554,7 +1575,7 @@ static int stm32_spi_transfer_one_setup(struct stm32_spi *spi,
 
 	spi->cur_comm = comm_type;
 
-	if (spi->cfg->set_data_idleness)
+	if (STM32_SPI_MASTER_MODE(spi) && spi->cfg->set_data_idleness)
 		spi->cfg->set_data_idleness(spi, transfer->len);
 
 	if (spi->cur_bpw <= 8)
@@ -1575,7 +1596,8 @@ static int stm32_spi_transfer_one_setup(struct stm32_spi *spi,
 	dev_dbg(spi->dev,
 		"data frame of %d-bit, data packet of %d data frames\n",
 		spi->cur_bpw, spi->cur_fthlv);
-	dev_dbg(spi->dev, "speed set to %dHz\n", spi->cur_speed);
+	if (STM32_SPI_MASTER_MODE(spi))
+		dev_dbg(spi->dev, "speed set to %dHz\n", spi->cur_speed);
 	dev_dbg(spi->dev, "transfer of %d bytes (%d data frames)\n",
 		spi->cur_xferlen, nb_words);
 	dev_dbg(spi->dev, "dma %s\n",
@@ -1670,12 +1692,13 @@ static int stm32f4_spi_config(struct stm32_spi *spi)
 }
 
 /**
- * stm32h7_spi_config - Configure SPI controller as SPI master
+ * stm32h7_spi_config - Configure SPI controller
  * @spi: pointer to the spi controller data structure
  */
 static int stm32h7_spi_config(struct stm32_spi *spi)
 {
 	unsigned long flags;
+	u32 cr1 = 0, cfg2 = 0;
 
 	spin_lock_irqsave(&spi->lock, flags);
 
@@ -1683,24 +1706,28 @@ static int stm32h7_spi_config(struct stm32_spi *spi)
 	stm32_spi_clr_bits(spi, STM32H7_SPI_I2SCFGR,
 			   STM32H7_SPI_I2SCFGR_I2SMOD);
 
-	/*
-	 * - SS input value high
-	 * - transmitter half duplex direction
-	 * - automatic communication suspend when RX-Fifo is full
-	 */
-	stm32_spi_set_bits(spi, STM32H7_SPI_CR1, STM32H7_SPI_CR1_SSI |
-						 STM32H7_SPI_CR1_HDDIR |
-						 STM32H7_SPI_CR1_MASRX);
+	if (STM32_SPI_DEVICE_MODE(spi)) {
+		/* Use native device select */
+		cfg2 &= ~STM32H7_SPI_CFG2_SSM;
+	} else {
+		/*
+		 * - Transmitter half duplex direction
+		 * - Automatic communication suspend when RX-Fifo is full
+		 * - SS input value high
+		 */
+		cr1 |= STM32H7_SPI_CR1_HDDIR | STM32H7_SPI_CR1_MASRX | STM32H7_SPI_CR1_SSI;
 
-	/*
-	 * - Set the master mode (default Motorola mode)
-	 * - Consider 1 master/n slaves configuration and
-	 *   SS input value is determined by the SSI bit
-	 * - keep control of all associated GPIOs
-	 */
-	stm32_spi_set_bits(spi, STM32H7_SPI_CFG2, STM32H7_SPI_CFG2_MASTER |
-						  STM32H7_SPI_CFG2_SSM |
-						  STM32H7_SPI_CFG2_AFCNTR);
+		/*
+		 * - Set the master mode (default Motorola mode)
+		 * - Consider 1 master/n devices configuration and
+		 *   SS input value is determined by the SSI bit
+		 * - keep control of all associated GPIOs
+		 */
+		cfg2 |= STM32H7_SPI_CFG2_MASTER | STM32H7_SPI_CFG2_SSM | STM32H7_SPI_CFG2_AFCNTR;
+	}
+
+	stm32_spi_set_bits(spi, STM32H7_SPI_CR1, cr1);
+	stm32_spi_set_bits(spi, STM32H7_SPI_CFG2, cfg2);
 
 	spin_unlock_irqrestore(&spi->lock, flags);
 
@@ -1756,17 +1783,30 @@ static const struct of_device_id stm32_spi_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, stm32_spi_of_match);
 
+static int stm32h7_spi_device_abort(struct spi_controller *ctrl)
+{
+	spi_finalize_current_transfer(ctrl);
+	return 0;
+}
+
 static int stm32_spi_probe(struct platform_device *pdev)
 {
 	struct spi_controller *ctrl;
 	struct stm32_spi *spi;
 	struct resource *res;
 	struct reset_control *rst;
+	struct device_node *np = pdev->dev.of_node;
+	bool device_mode;
 	int ret;
 
-	ctrl = devm_spi_alloc_master(&pdev->dev, sizeof(struct stm32_spi));
+	device_mode = of_property_read_bool(np, "spi-slave");
+
+	if (device_mode)
+		ctrl = devm_spi_alloc_slave(&pdev->dev, sizeof(struct stm32_spi));
+	else
+		ctrl = devm_spi_alloc_master(&pdev->dev, sizeof(struct stm32_spi));
 	if (!ctrl) {
-		dev_err(&pdev->dev, "spi master allocation failed\n");
+		dev_err(&pdev->dev, "spi controller allocation failed\n");
 		return -ENOMEM;
 	}
 	platform_set_drvdata(pdev, ctrl);
@@ -1774,6 +1814,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	spi = spi_controller_get_devdata(ctrl);
 	spi->dev = &pdev->dev;
 	spi->ctrl = ctrl;
+	spi->device_mode = device_mode;
 	spin_lock_init(&spi->lock);
 
 	spi->cfg = (const struct stm32_spi_cfg *)
@@ -1856,6 +1897,8 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	ctrl->transfer_one = stm32_spi_transfer_one;
 	ctrl->unprepare_message = stm32_spi_unprepare_msg;
 	ctrl->flags = spi->cfg->flags;
+	if (STM32_SPI_DEVICE_MODE(spi))
+		ctrl->slave_abort = stm32h7_spi_device_abort;
 
 	spi->dma_tx = dma_request_chan(spi->dev, "tx");
 	if (IS_ERR(spi->dma_tx)) {
@@ -1901,7 +1944,8 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
 
-	dev_info(&pdev->dev, "driver initialized\n");
+	dev_info(&pdev->dev, "driver initialized (%s mode)\n",
+		 STM32_SPI_MASTER_MODE(spi) ? "master" : "device");
 
 	return 0;
 
-- 
2.25.1

