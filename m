Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13BB1FFFE0
	for <lists+linux-spi@lfdr.de>; Fri, 19 Jun 2020 03:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730753AbgFSBsO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Jun 2020 21:48:14 -0400
Received: from mga06.intel.com ([134.134.136.31]:64021 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727853AbgFSBsJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 18 Jun 2020 21:48:09 -0400
IronPort-SDR: DHnxHRxFDv/mZohp4AW1/E0u/tVr4VIQ7GAXLOeWr/qcPAL4kyb5Xc+VpeJN9gKNRSNsXdbRn4
 KVrIkiGMux7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="204278283"
X-IronPort-AV: E=Sophos;i="5.75,253,1589266800"; 
   d="scan'208";a="204278283"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 18:48:08 -0700
IronPort-SDR: lcr/lrYanhgsrbvVRcd0eo0VGSY8sHHwAOkWRQpE+XmouSG5vPyrU+paT9zavhgEKGf2dxoPzS
 8NryKGx8OLBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,253,1589266800"; 
   d="scan'208";a="263746062"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga008.fm.intel.com with ESMTP; 18 Jun 2020 18:48:00 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com
Subject: [RESEND PATCH v2 2/3] spi: altera: support indirect access to the registers
Date:   Fri, 19 Jun 2020 09:43:40 +0800
Message-Id: <1592531021-11412-3-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592531021-11412-1-git-send-email-yilun.xu@intel.com>
References: <1592531021-11412-1-git-send-email-yilun.xu@intel.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch adds support for indirect access to the registers via parent
regmap.

The use case is, the spi master is a sub device of a Multifunction
device, which is connected to host by some indirect bus. To support this
device type, a new platform_device_id is introduced, and the driver tries
to get parent regmap for register accessing like many MFD sub device
drivers do.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by : Tom Rix <trix@redhat.com>
---
 drivers/spi/spi-altera.c | 62 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 47 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-altera.c b/drivers/spi/spi-altera.c
index b215bdf..4f7717f 100644
--- a/drivers/spi/spi-altera.c
+++ b/drivers/spi/spi-altera.c
@@ -43,6 +43,11 @@
 
 #define ALTERA_SPI_MAX_CS		32
 
+enum altera_spi_type {
+	ALTERA_SPI_TYPE_UNKNOWN,
+	ALTERA_SPI_TYPE_SUBDEV,
+};
+
 struct altera_spi {
 	int irq;
 	int len;
@@ -55,6 +60,7 @@ struct altera_spi {
 	unsigned char *rx;
 
 	struct regmap *regmap;
+	u32 regoff;
 	struct device *dev;
 };
 
@@ -70,7 +76,7 @@ static int altr_spi_writel(struct altera_spi *hw, unsigned int reg,
 {
 	int ret;
 
-	ret = regmap_write(hw->regmap, reg, val);
+	ret = regmap_write(hw->regmap, hw->regoff + reg, val);
 	if (ret)
 		dev_err(hw->dev, "fail to write reg 0x%x val 0x%x: %d\n",
 			reg, val, ret);
@@ -83,7 +89,7 @@ static int altr_spi_readl(struct altera_spi *hw, unsigned int reg,
 {
 	int ret;
 
-	ret = regmap_read(hw->regmap, reg, val);
+	ret = regmap_read(hw->regmap, hw->regoff + reg, val);
 	if (ret)
 		dev_err(hw->dev, "fail to read reg 0x%x: %d\n", reg, ret);
 
@@ -225,10 +231,11 @@ static irqreturn_t altera_spi_irq(int irq, void *dev)
 
 static int altera_spi_probe(struct platform_device *pdev)
 {
+	const struct platform_device_id *platid = platform_get_device_id(pdev);
 	struct altera_spi_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	enum altera_spi_type type = ALTERA_SPI_TYPE_UNKNOWN;
 	struct altera_spi *hw;
 	struct spi_master *master;
-	void __iomem *res;
 	int err = -ENODEV;
 	u32 val;
 	u16 i;
@@ -264,19 +271,38 @@ static int altera_spi_probe(struct platform_device *pdev)
 	hw = spi_master_get_devdata(master);
 	hw->dev = &pdev->dev;
 
+	if (platid)
+		type = platid->driver_data;
+
 	/* find and map our resources */
-	res = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(res)) {
-		err = PTR_ERR(res);
-		goto exit;
-	}
+	if (type == ALTERA_SPI_TYPE_SUBDEV) {
+		struct resource *regoff;
 
-	hw->regmap = devm_regmap_init_mmio(&pdev->dev, res,
-					   &spi_altera_config);
-	if (IS_ERR(hw->regmap)) {
-		dev_err(&pdev->dev, "regmap mmio init failed\n");
-		err = PTR_ERR(hw->regmap);
-		goto exit;
+		hw->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+		if (!hw->regmap) {
+			dev_err(&pdev->dev, "get regmap failed\n");
+			goto exit;
+		}
+
+		regoff = platform_get_resource(pdev, IORESOURCE_REG, 0);
+		if (regoff)
+			hw->regoff = regoff->start;
+	} else {
+		void __iomem *res;
+
+		res = devm_platform_ioremap_resource(pdev, 0);
+		if (IS_ERR(res)) {
+			err = PTR_ERR(res);
+			goto exit;
+		}
+
+		hw->regmap = devm_regmap_init_mmio(&pdev->dev, res,
+						   &spi_altera_config);
+		if (IS_ERR(hw->regmap)) {
+			dev_err(&pdev->dev, "regmap mmio init failed\n");
+			err = PTR_ERR(hw->regmap);
+			goto exit;
+		}
 	}
 
 	/* program defaults into the registers */
@@ -308,7 +334,7 @@ static int altera_spi_probe(struct platform_device *pdev)
 		}
 	}
 
-	dev_info(&pdev->dev, "base %p, irq %d\n", res, hw->irq);
+	dev_info(&pdev->dev, "regoff %u, irq %d\n", hw->regoff, hw->irq);
 
 	return 0;
 exit:
@@ -325,6 +351,11 @@ static const struct of_device_id altera_spi_match[] = {
 MODULE_DEVICE_TABLE(of, altera_spi_match);
 #endif /* CONFIG_OF */
 
+static const struct platform_device_id altera_spi_ids[] = {
+	{ "subdev_spi_altera", ALTERA_SPI_TYPE_SUBDEV },
+	{ }
+};
+
 static struct platform_driver altera_spi_driver = {
 	.probe = altera_spi_probe,
 	.driver = {
@@ -332,6 +363,7 @@ static struct platform_driver altera_spi_driver = {
 		.pm = NULL,
 		.of_match_table = of_match_ptr(altera_spi_match),
 	},
+	.id_table	= altera_spi_ids,
 };
 module_platform_driver(altera_spi_driver);
 
-- 
2.7.4

