Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F941B7241
	for <lists+linux-spi@lfdr.de>; Fri, 24 Apr 2020 12:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgDXKnh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Apr 2020 06:43:37 -0400
Received: from mga14.intel.com ([192.55.52.115]:54501 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726815AbgDXKnh (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 24 Apr 2020 06:43:37 -0400
IronPort-SDR: ELsXngcPa2/SwgNaqp3dIyC9irzB2D6PI4AjNGkH4YQ1Bi2GIBo4mTroQxPmro6ELlC3Qd18Gq
 /b9pBqRefhrQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 03:43:36 -0700
IronPort-SDR: MZht+JuIYucJM8e6D2WVRiOSaPTpLaSBhs/V+wfIsz3ipgZzsKVDYwbRO4HIuwSXSVKRUkU2nY
 gZsXoo6ptpkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,311,1583222400"; 
   d="scan'208";a="403261185"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga004.jf.intel.com with ESMTP; 24 Apr 2020 03:43:33 -0700
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     broonie@kernel.org, robh@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, daniel.schwierzeck@gmail.com,
        hauke@hauke-m.de, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH 2/4] spi: lantiq: Dynamic configuration of interrupts and FIFO size
Date:   Fri, 24 Apr 2020 18:42:31 +0800
Message-Id: <a6ed352ad16583340a567bef3a49118cad85aab2.1587702428.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1587702428.git.eswara.kota@linux.intel.com>
References: <cover.1587702428.git.eswara.kota@linux.intel.com>
In-Reply-To: <cover.1587702428.git.eswara.kota@linux.intel.com>
References: <cover.1587702428.git.eswara.kota@linux.intel.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Newer chipsets are having larger transfer FIFOs and lesser interrupt lines.
So, add the interrupt configuration operation and FIFO size mask to the SoC
specific data structure.

On the existing chipsets, interrupt controller acknowledges the triggered
interrupts automatically. Whereas in the newer chipsests like Lightning
Mountain interrupt status register should be cleared for the acknowledgment
of triggered interrupts. So, add a flag in the SoC specific data structure
to specify driver to clear the interrupt status register.

Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
---
 drivers/spi/spi-lantiq-ssc.c | 97 ++++++++++++++++++++++++++------------------
 1 file changed, 57 insertions(+), 40 deletions(-)

diff --git a/drivers/spi/spi-lantiq-ssc.c b/drivers/spi/spi-lantiq-ssc.c
index b67f5925bcb0..74a5d36c5048 100644
--- a/drivers/spi/spi-lantiq-ssc.c
+++ b/drivers/spi/spi-lantiq-ssc.c
@@ -61,9 +61,7 @@
 #define LTQ_SPI_CLC_DISR	BIT(0)	/* Disable request bit */
 
 #define LTQ_SPI_ID_TXFS_S	24	/* Implemented TX FIFO size */
-#define LTQ_SPI_ID_TXFS_M	(0x3F << LTQ_SPI_ID_TXFS_S)
 #define LTQ_SPI_ID_RXFS_S	16	/* Implemented RX FIFO size */
-#define LTQ_SPI_ID_RXFS_M	(0x3F << LTQ_SPI_ID_RXFS_S)
 #define LTQ_SPI_ID_MOD_S	8	/* Module ID */
 #define LTQ_SPI_ID_MOD_M	(0xff << LTQ_SPI_ID_MOD_S)
 #define LTQ_SPI_ID_CFG_S	5	/* DMA interface support */
@@ -126,19 +124,15 @@
 					 LTQ_SPI_WHBSTATE_CLRTUE)
 
 #define LTQ_SPI_RXFCON_RXFITL_S	8	/* FIFO interrupt trigger level */
-#define LTQ_SPI_RXFCON_RXFITL_M	(0x3F << LTQ_SPI_RXFCON_RXFITL_S)
 #define LTQ_SPI_RXFCON_RXFLU	BIT(1)	/* FIFO flush */
 #define LTQ_SPI_RXFCON_RXFEN	BIT(0)	/* FIFO enable */
 
 #define LTQ_SPI_TXFCON_TXFITL_S	8	/* FIFO interrupt trigger level */
-#define LTQ_SPI_TXFCON_TXFITL_M	(0x3F << LTQ_SPI_TXFCON_TXFITL_S)
 #define LTQ_SPI_TXFCON_TXFLU	BIT(1)	/* FIFO flush */
 #define LTQ_SPI_TXFCON_TXFEN	BIT(0)	/* FIFO enable */
 
 #define LTQ_SPI_FSTAT_RXFFL_S	0
-#define LTQ_SPI_FSTAT_RXFFL_M	(0x3f << LTQ_SPI_FSTAT_RXFFL_S)
 #define LTQ_SPI_FSTAT_TXFFL_S	8
-#define LTQ_SPI_FSTAT_TXFFL_M	(0x3f << LTQ_SPI_FSTAT_TXFFL_S)
 
 #define LTQ_SPI_GPOCON_ISCSBN_S	8
 #define LTQ_SPI_GPOCON_INVOUTN_S	0
@@ -158,9 +152,14 @@
 #define LTQ_SPI_IRNEN_T_XRX	BIT(0)	/* Receive end interrupt request */
 #define LTQ_SPI_IRNEN_ALL	0x1F
 
+struct lantiq_ssc_spi;
+
 struct lantiq_ssc_hwcfg {
+	int (*cfg_irq)(struct platform_device *pdev, struct lantiq_ssc_spi *spi);
+	u32 fifo_size_mask;
 	unsigned int irnen_r;
 	unsigned int irnen_t;
+	bool irq_ack;
 };
 
 struct lantiq_ssc_spi {
@@ -209,16 +208,18 @@ static void lantiq_ssc_maskl(const struct lantiq_ssc_spi *spi, u32 clr,
 
 static unsigned int tx_fifo_level(const struct lantiq_ssc_spi *spi)
 {
+	const struct lantiq_ssc_hwcfg *hwcfg = spi->hwcfg;
 	u32 fstat = lantiq_ssc_readl(spi, LTQ_SPI_FSTAT);
 
-	return (fstat & LTQ_SPI_FSTAT_TXFFL_M) >> LTQ_SPI_FSTAT_TXFFL_S;
+	return (fstat >> LTQ_SPI_FSTAT_TXFFL_S) & hwcfg->fifo_size_mask;
 }
 
 static unsigned int rx_fifo_level(const struct lantiq_ssc_spi *spi)
 {
+	const struct lantiq_ssc_hwcfg *hwcfg = spi->hwcfg;
 	u32 fstat = lantiq_ssc_readl(spi, LTQ_SPI_FSTAT);
 
-	return fstat & LTQ_SPI_FSTAT_RXFFL_M;
+	return (fstat >> LTQ_SPI_FSTAT_RXFFL_S) & hwcfg->fifo_size_mask;
 }
 
 static unsigned int tx_fifo_free(const struct lantiq_ssc_spi *spi)
@@ -678,6 +679,8 @@ static irqreturn_t lantiq_ssc_isr(int irq, void *data)
 	mutex_lock(&spi->lock);
 	val = lantiq_ssc_readl(spi, LTQ_SPI_IRNCR);
 	lantiq_ssc_maskl(spi, val, 0, LTQ_SPI_IRNEN);
+	if (hwcfg->irq_ack)
+		lantiq_ssc_writel(spi, val, LTQ_SPI_IRNCR);
 
 	if (val & LTQ_SPI_IRNEN_E)
 		ret = lantiq_ssc_err_interrupt(spi);
@@ -786,14 +789,52 @@ static int lantiq_ssc_transfer_one(struct spi_master *master,
 	return transfer_start(spi, spidev, t);
 }
 
+static int lantiq_cfg_irq(struct platform_device *pdev, struct lantiq_ssc_spi *spi)
+{
+	int irq, err;
+
+	irq = platform_get_irq_byname(pdev, LTQ_SPI_RX_IRQ_NAME);
+	if (irq < 0)
+		return irq;
+
+	err = devm_request_threaded_irq(&pdev->dev, irq, NULL, lantiq_ssc_isr,
+					IRQF_ONESHOT, LTQ_SPI_RX_IRQ_NAME, spi);
+	if (err)
+		return err;
+
+	irq = platform_get_irq_byname(pdev, LTQ_SPI_TX_IRQ_NAME);
+	if (irq < 0)
+		return irq;
+
+	err = devm_request_threaded_irq(&pdev->dev, irq, NULL, lantiq_ssc_isr,
+					IRQF_ONESHOT, LTQ_SPI_TX_IRQ_NAME, spi);
+	if (err)
+		return err;
+
+	irq = platform_get_irq_byname(pdev, LTQ_SPI_ERR_IRQ_NAME);
+	if (irq < 0)
+		return irq;
+
+	err = devm_request_threaded_irq(&pdev->dev, irq, NULL, lantiq_ssc_isr,
+					IRQF_ONESHOT, LTQ_SPI_ERR_IRQ_NAME, spi);
+
+	return err;
+}
+
 static const struct lantiq_ssc_hwcfg lantiq_ssc_xway = {
-	.irnen_r = LTQ_SPI_IRNEN_R_XWAY,
-	.irnen_t = LTQ_SPI_IRNEN_T_XWAY,
+	.irnen_r	= LTQ_SPI_IRNEN_R_XWAY,
+	.irnen_t	= LTQ_SPI_IRNEN_T_XWAY,
+	.fifo_size_mask	= GENMASK(5, 0),
+	.cfg_irq	= lantiq_cfg_irq,
+	.irq_ack	= false,
 };
 
 static const struct lantiq_ssc_hwcfg lantiq_ssc_xrx = {
-	.irnen_r = LTQ_SPI_IRNEN_R_XRX,
-	.irnen_t = LTQ_SPI_IRNEN_T_XRX,
+	.irnen_r	= LTQ_SPI_IRNEN_R_XRX,
+	.irnen_t	= LTQ_SPI_IRNEN_T_XRX,
+	.fifo_size_mask	= GENMASK(5, 0),
+	.cfg_irq	= lantiq_cfg_irq,
+	.irq_ack	= false,
 };
 
 static const struct of_device_id lantiq_ssc_match[] = {
@@ -811,9 +852,9 @@ static int lantiq_ssc_probe(struct platform_device *pdev)
 	struct lantiq_ssc_spi *spi;
 	const struct lantiq_ssc_hwcfg *hwcfg;
 	const struct of_device_id *match;
-	int err, rx_irq, tx_irq, err_irq;
 	u32 id, supports_dma, revision;
 	unsigned int num_cs;
+	int err;
 
 	match = of_match_device(lantiq_ssc_match, dev);
 	if (!match) {
@@ -821,19 +862,6 @@ static int lantiq_ssc_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 	hwcfg = match->data;
-
-	rx_irq = platform_get_irq_byname(pdev, LTQ_SPI_RX_IRQ_NAME);
-	if (rx_irq < 0)
-		return -ENXIO;
-
-	tx_irq = platform_get_irq_byname(pdev, LTQ_SPI_TX_IRQ_NAME);
-	if (tx_irq < 0)
-		return -ENXIO;
-
-	err_irq = platform_get_irq_byname(pdev, LTQ_SPI_ERR_IRQ_NAME);
-	if (err_irq < 0)
-		return -ENXIO;
-
 	master = spi_alloc_master(dev, sizeof(struct lantiq_ssc_spi));
 	if (!master)
 		return -ENOMEM;
@@ -849,18 +877,7 @@ static int lantiq_ssc_probe(struct platform_device *pdev)
 		goto err_master_put;
 	}
 
-	err = devm_request_threaded_irq(dev, rx_irq, NULL, lantiq_ssc_isr,
-					IRQF_ONESHOT, LTQ_SPI_RX_IRQ_NAME, spi);
-	if (err)
-		goto err_master_put;
-
-	err = devm_request_threaded_irq(dev, tx_irq, NULL, lantiq_ssc_isr,
-					IRQF_ONESHOT, LTQ_SPI_TX_IRQ_NAME, spi);
-	if (err)
-		goto err_master_put;
-
-	err = devm_request_threaded_irq(dev, err_irq, NULL, lantiq_ssc_isr,
-					IRQF_ONESHOT, LTQ_SPI_ERR_IRQ_NAME, spi);
+	err = hwcfg->cfg_irq(pdev, spi);
 	if (err)
 		goto err_master_put;
 
@@ -911,8 +928,8 @@ static int lantiq_ssc_probe(struct platform_device *pdev)
 				     SPI_BPW_MASK(16) | SPI_BPW_MASK(32);
 
 	id = lantiq_ssc_readl(spi, LTQ_SPI_ID);
-	spi->tx_fifo_size = (id & LTQ_SPI_ID_TXFS_M) >> LTQ_SPI_ID_TXFS_S;
-	spi->rx_fifo_size = (id & LTQ_SPI_ID_RXFS_M) >> LTQ_SPI_ID_RXFS_S;
+	spi->tx_fifo_size = (id >> LTQ_SPI_ID_TXFS_S) & hwcfg->fifo_size_mask;
+	spi->rx_fifo_size = (id >> LTQ_SPI_ID_RXFS_S) & hwcfg->fifo_size_mask;
 	supports_dma = (id & LTQ_SPI_ID_CFG_M) >> LTQ_SPI_ID_CFG_S;
 	revision = id & LTQ_SPI_ID_REV_M;
 
-- 
2.11.0

