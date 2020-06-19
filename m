Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158841FFFE2
	for <lists+linux-spi@lfdr.de>; Fri, 19 Jun 2020 03:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730741AbgFSBsN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Jun 2020 21:48:13 -0400
Received: from mga06.intel.com ([134.134.136.31]:64012 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730797AbgFSBsJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 18 Jun 2020 21:48:09 -0400
IronPort-SDR: xedQirwFkK9649mf1VdVAkI8FzWo0m+JR3HpTBvKH5dJKOuzsO2sO3CEYbLCgqcnG305gZrx44
 zguCOJcrWYVA==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="204278281"
X-IronPort-AV: E=Sophos;i="5.75,253,1589266800"; 
   d="scan'208";a="204278281"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 18:47:59 -0700
IronPort-SDR: KpZpnspTDJ7oCtB7qC18r5vj5K9dtyNzANC4rts4oTsg/POLp6/igY3FPIQaPfDzw66s+W1Fna
 VAcbYJ6mNGQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,253,1589266800"; 
   d="scan'208";a="263746043"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga008.fm.intel.com with ESMTP; 18 Jun 2020 18:47:57 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com
Subject: [RESEND PATCH v2 1/3] spi: altera: use regmap-mmio instead of direct mmio register access
Date:   Fri, 19 Jun 2020 09:43:39 +0800
Message-Id: <1592531021-11412-2-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592531021-11412-1-git-send-email-yilun.xu@intel.com>
References: <1592531021-11412-1-git-send-email-yilun.xu@intel.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch adds support for regmap. It makes preparation for supporting
different ways to access the registers.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by : Tom Rix <trix@redhat.com>
---
 drivers/spi/Kconfig      |  1 +
 drivers/spi/spi-altera.c | 91 ++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 73 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 8f1f8fc..6d79fc7 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -59,6 +59,7 @@ comment "SPI Master Controller Drivers"
 
 config SPI_ALTERA
 	tristate "Altera SPI Controller"
+	select REGMAP_MMIO
 	help
 	  This is the driver for the Altera SPI Controller.
 
diff --git a/drivers/spi/spi-altera.c b/drivers/spi/spi-altera.c
index aa9d1a2..b215bdf 100644
--- a/drivers/spi/spi-altera.c
+++ b/drivers/spi/spi-altera.c
@@ -44,7 +44,6 @@
 #define ALTERA_SPI_MAX_CS		32
 
 struct altera_spi {
-	void __iomem *base;
 	int irq;
 	int len;
 	int count;
@@ -54,8 +53,43 @@ struct altera_spi {
 	/* data buffers */
 	const unsigned char *tx;
 	unsigned char *rx;
+
+	struct regmap *regmap;
+	struct device *dev;
+};
+
+static const struct regmap_config spi_altera_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.fast_io = true,
 };
 
+static int altr_spi_writel(struct altera_spi *hw, unsigned int reg,
+			   unsigned int val)
+{
+	int ret;
+
+	ret = regmap_write(hw->regmap, reg, val);
+	if (ret)
+		dev_err(hw->dev, "fail to write reg 0x%x val 0x%x: %d\n",
+			reg, val, ret);
+
+	return ret;
+}
+
+static int altr_spi_readl(struct altera_spi *hw, unsigned int reg,
+			  unsigned int *val)
+{
+	int ret;
+
+	ret = regmap_read(hw->regmap, reg, val);
+	if (ret)
+		dev_err(hw->dev, "fail to read reg 0x%x: %d\n", reg, ret);
+
+	return ret;
+}
+
 static inline struct altera_spi *altera_spi_to_hw(struct spi_device *sdev)
 {
 	return spi_master_get_devdata(sdev->master);
@@ -67,12 +101,13 @@ static void altera_spi_set_cs(struct spi_device *spi, bool is_high)
 
 	if (is_high) {
 		hw->imr &= ~ALTERA_SPI_CONTROL_SSO_MSK;
-		writel(hw->imr, hw->base + ALTERA_SPI_CONTROL);
-		writel(0, hw->base + ALTERA_SPI_SLAVE_SEL);
+		altr_spi_writel(hw, ALTERA_SPI_CONTROL, hw->imr);
+		altr_spi_writel(hw, ALTERA_SPI_SLAVE_SEL, 0);
 	} else {
-		writel(BIT(spi->chip_select), hw->base + ALTERA_SPI_SLAVE_SEL);
+		altr_spi_writel(hw, ALTERA_SPI_SLAVE_SEL,
+				BIT(spi->chip_select));
 		hw->imr |= ALTERA_SPI_CONTROL_SSO_MSK;
-		writel(hw->imr, hw->base + ALTERA_SPI_CONTROL);
+		altr_spi_writel(hw, ALTERA_SPI_CONTROL, hw->imr);
 	}
 }
 
@@ -99,14 +134,14 @@ static void altera_spi_tx_word(struct altera_spi *hw)
 		}
 	}
 
-	writel(txd, hw->base + ALTERA_SPI_TXDATA);
+	altr_spi_writel(hw, ALTERA_SPI_TXDATA, txd);
 }
 
 static void altera_spi_rx_word(struct altera_spi *hw)
 {
 	unsigned int rxd;
 
-	rxd = readl(hw->base + ALTERA_SPI_RXDATA);
+	altr_spi_readl(hw, ALTERA_SPI_RXDATA, &rxd);
 	if (hw->rx) {
 		switch (hw->bytes_per_word) {
 		case 1:
@@ -133,6 +168,7 @@ static int altera_spi_txrx(struct spi_master *master,
 	struct spi_device *spi, struct spi_transfer *t)
 {
 	struct altera_spi *hw = spi_master_get_devdata(master);
+	u32 val;
 
 	hw->tx = t->tx_buf;
 	hw->rx = t->rx_buf;
@@ -143,7 +179,7 @@ static int altera_spi_txrx(struct spi_master *master,
 	if (hw->irq >= 0) {
 		/* enable receive interrupt */
 		hw->imr |= ALTERA_SPI_CONTROL_IRRDY_MSK;
-		writel(hw->imr, hw->base + ALTERA_SPI_CONTROL);
+		altr_spi_writel(hw, ALTERA_SPI_CONTROL, hw->imr);
 
 		/* send the first byte */
 		altera_spi_tx_word(hw);
@@ -151,9 +187,13 @@ static int altera_spi_txrx(struct spi_master *master,
 		while (hw->count < hw->len) {
 			altera_spi_tx_word(hw);
 
-			while (!(readl(hw->base + ALTERA_SPI_STATUS) &
-				 ALTERA_SPI_STATUS_RRDY_MSK))
+			for (;;) {
+				altr_spi_readl(hw, ALTERA_SPI_STATUS, &val);
+				if (val & ALTERA_SPI_STATUS_RRDY_MSK)
+					break;
+
 				cpu_relax();
+			}
 
 			altera_spi_rx_word(hw);
 		}
@@ -175,7 +215,7 @@ static irqreturn_t altera_spi_irq(int irq, void *dev)
 	} else {
 		/* disable receive interrupt */
 		hw->imr &= ~ALTERA_SPI_CONTROL_IRRDY_MSK;
-		writel(hw->imr, hw->base + ALTERA_SPI_CONTROL);
+		altr_spi_writel(hw, ALTERA_SPI_CONTROL, hw->imr);
 
 		spi_finalize_current_transfer(master);
 	}
@@ -188,7 +228,9 @@ static int altera_spi_probe(struct platform_device *pdev)
 	struct altera_spi_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct altera_spi *hw;
 	struct spi_master *master;
+	void __iomem *res;
 	int err = -ENODEV;
+	u32 val;
 	u16 i;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(struct altera_spi));
@@ -220,19 +262,30 @@ static int altera_spi_probe(struct platform_device *pdev)
 	master->set_cs = altera_spi_set_cs;
 
 	hw = spi_master_get_devdata(master);
+	hw->dev = &pdev->dev;
 
 	/* find and map our resources */
-	hw->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(hw->base)) {
-		err = PTR_ERR(hw->base);
+	res = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(res)) {
+		err = PTR_ERR(res);
 		goto exit;
 	}
+
+	hw->regmap = devm_regmap_init_mmio(&pdev->dev, res,
+					   &spi_altera_config);
+	if (IS_ERR(hw->regmap)) {
+		dev_err(&pdev->dev, "regmap mmio init failed\n");
+		err = PTR_ERR(hw->regmap);
+		goto exit;
+	}
+
 	/* program defaults into the registers */
 	hw->imr = 0;		/* disable spi interrupts */
-	writel(hw->imr, hw->base + ALTERA_SPI_CONTROL);
-	writel(0, hw->base + ALTERA_SPI_STATUS);	/* clear status reg */
-	if (readl(hw->base + ALTERA_SPI_STATUS) & ALTERA_SPI_STATUS_RRDY_MSK)
-		readl(hw->base + ALTERA_SPI_RXDATA);	/* flush rxdata */
+	altr_spi_writel(hw, ALTERA_SPI_CONTROL, hw->imr);
+	altr_spi_writel(hw, ALTERA_SPI_STATUS, 0);	/* clear status reg */
+	altr_spi_readl(hw, ALTERA_SPI_STATUS, &val);
+	if (val & ALTERA_SPI_STATUS_RRDY_MSK)
+		altr_spi_readl(hw, ALTERA_SPI_RXDATA, &val); /* flush rxdata */
 	/* irq is optional */
 	hw->irq = platform_get_irq(pdev, 0);
 	if (hw->irq >= 0) {
@@ -255,7 +308,7 @@ static int altera_spi_probe(struct platform_device *pdev)
 		}
 	}
 
-	dev_info(&pdev->dev, "base %p, irq %d\n", hw->base, hw->irq);
+	dev_info(&pdev->dev, "base %p, irq %d\n", res, hw->irq);
 
 	return 0;
 exit:
-- 
2.7.4

