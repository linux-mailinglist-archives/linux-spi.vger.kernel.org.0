Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4269B7F5E9
	for <lists+linux-spi@lfdr.de>; Fri,  2 Aug 2019 13:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392352AbfHBLWO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 2 Aug 2019 07:22:14 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:32914 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392339AbfHBLWO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 2 Aug 2019 07:22:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=aWPc5XtWVNNXmLNilGJewpe81/uyOte57cCOHtfXltA=; b=pc1ZxXBKhO84
        ri4OlZXonaK/Wscxwl8Qn3oC/wbI9Qe4yg1c6IPQufXgNL0dbqp8VSAi1w/CxrbGbYktJEeqsCso9
        6ZZVmqrvbuXydZsWS6vJOUuiiRejhaL87rQOvtARlKcwqqgcFLrIc8DqKjQXleTZnmW1BtnXaNbEN
        I7Qik=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1htVdR-0007S6-If; Fri, 02 Aug 2019 11:22:09 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 1395B2742E3A; Fri,  2 Aug 2019 12:22:08 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: Remove dev_err() usage after platform_get_irq()" to the spi tree
In-Reply-To: <20190730181557.90391-42-swboyd@chromium.org>
X-Patchwork-Hint: ignore
Message-Id: <20190802112209.1395B2742E3A@ypsilon.sirena.org.uk>
Date:   Fri,  2 Aug 2019 12:22:08 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: Remove dev_err() usage after platform_get_irq()

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.4

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 6b8ac10e0dd4b49eda513c1aa5045b3b1660d350 Mon Sep 17 00:00:00 2001
From: Stephen Boyd <swboyd@chromium.org>
Date: Tue, 30 Jul 2019 11:15:41 -0700
Subject: [PATCH] spi: Remove dev_err() usage after platform_get_irq()

We don't need dev_err() messages when platform_get_irq() fails now that
platform_get_irq() prints an error message itself when something goes
wrong. Let's remove these prints with a simple semantic patch.

// <smpl>
@@
expression ret;
struct platform_device *E;
@@

ret =
(
platform_get_irq(E, ...)
|
platform_get_irq_byname(E, ...)
);

if ( \( ret < 0 \| ret <= 0 \) )
{
(
-if (ret != -EPROBE_DEFER)
-{ ...
-dev_err(...);
-... }
|
...
-dev_err(...);
)
...
}
// </smpl>

While we're here, remove braces on if statements that only have one
statement (manually).

Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Link: https://lore.kernel.org/r/20190730181557.90391-42-swboyd@chromium.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/atmel-quadspi.c     |  1 -
 drivers/spi/spi-armada-3700.c   |  1 -
 drivers/spi/spi-bcm2835.c       |  1 -
 drivers/spi/spi-bcm2835aux.c    |  1 -
 drivers/spi/spi-bcm63xx-hsspi.c |  4 +---
 drivers/spi/spi-bcm63xx.c       |  4 +---
 drivers/spi/spi-cadence.c       |  1 -
 drivers/spi/spi-dw-mmio.c       |  4 +---
 drivers/spi/spi-efm32.c         |  4 +---
 drivers/spi/spi-ep93xx.c        |  4 +---
 drivers/spi/spi-fsl-dspi.c      |  1 -
 drivers/spi/spi-fsl-qspi.c      |  4 +---
 drivers/spi/spi-geni-qcom.c     |  4 +---
 drivers/spi/spi-lantiq-ssc.c    | 12 +++---------
 drivers/spi/spi-mt65xx.c        |  1 -
 drivers/spi/spi-npcm-pspi.c     |  1 -
 drivers/spi/spi-nuc900.c        |  1 -
 drivers/spi/spi-nxp-fspi.c      |  4 +---
 drivers/spi/spi-pic32-sqi.c     |  1 -
 drivers/spi/spi-pic32.c         | 12 +++---------
 drivers/spi/spi-qcom-qspi.c     |  4 +---
 drivers/spi/spi-s3c24xx.c       |  1 -
 drivers/spi/spi-sh-msiof.c      |  1 -
 drivers/spi/spi-sh.c            |  4 +---
 drivers/spi/spi-sifive.c        |  1 -
 drivers/spi/spi-slave-mt27xx.c  |  1 -
 drivers/spi/spi-sprd.c          |  4 +---
 drivers/spi/spi-stm32-qspi.c    |  5 +----
 drivers/spi/spi-sun4i.c         |  1 -
 drivers/spi/spi-sun6i.c         |  1 -
 drivers/spi/spi-synquacer.c     |  2 --
 drivers/spi/spi-ti-qspi.c       |  1 -
 drivers/spi/spi-uniphier.c      |  1 -
 drivers/spi/spi-xlp.c           |  4 +---
 drivers/spi/spi-zynq-qspi.c     |  1 -
 drivers/spi/spi-zynqmp-gqspi.c  |  1 -
 36 files changed, 19 insertions(+), 80 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 6a7d7b553d95..fd8007ebb145 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -526,7 +526,6 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 	/* Request the IRQ */
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "missing IRQ\n");
 		err = irq;
 		goto disable_qspick;
 	}
diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index 032888344822..119ae87cc26e 100644
--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -864,7 +864,6 @@ static int a3700_spi_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "could not get irq: %d\n", irq);
 		ret = -ENXIO;
 		goto error;
 	}
diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 6f243a90c844..c96797844688 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -1015,7 +1015,6 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 
 	bs->irq = platform_get_irq(pdev, 0);
 	if (bs->irq <= 0) {
-		dev_err(&pdev->dev, "could not get IRQ: %d\n", bs->irq);
 		err = bs->irq ? bs->irq : -ENODEV;
 		goto out_controller_put;
 	}
diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index bb57035c5770..b18ce69c0375 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -540,7 +540,6 @@ static int bcm2835aux_spi_probe(struct platform_device *pdev)
 
 	bs->irq = platform_get_irq(pdev, 0);
 	if (bs->irq <= 0) {
-		dev_err(&pdev->dev, "could not get IRQ: %d\n", bs->irq);
 		err = bs->irq ? bs->irq : -ENODEV;
 		goto out_master_put;
 	}
diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 9a06ffdb73b8..373cb53579e0 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -338,10 +338,8 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 	u32 reg, rate, num_cs = HSSPI_SPI_MAX_CS;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "no irq: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	regs = devm_ioremap_resource(dev, res_mem);
diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index df1c94a131e6..fdd7eaa0b8ed 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -520,10 +520,8 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "no irq: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	clk = devm_clk_get(dev, "spi");
 	if (IS_ERR(clk)) {
diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 7c41e4e82849..1c35eaaac838 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -540,7 +540,6 @@ static int cdns_spi_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
 		ret = -ENXIO;
-		dev_err(&pdev->dev, "irq number is invalid\n");
 		goto clk_dis_all;
 	}
 
diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 4fa7e7a52ebd..edb3cf6be201 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -156,10 +156,8 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 	}
 
 	dws->irq = platform_get_irq(pdev, 0);
-	if (dws->irq < 0) {
-		dev_err(&pdev->dev, "no irq resource?\n");
+	if (dws->irq < 0)
 		return dws->irq; /* -ENXIO */
-	}
 
 	dwsmmio->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(dwsmmio->clk))
diff --git a/drivers/spi/spi-efm32.c b/drivers/spi/spi-efm32.c
index eb1f2142a335..64d4c441b641 100644
--- a/drivers/spi/spi-efm32.c
+++ b/drivers/spi/spi-efm32.c
@@ -400,10 +400,8 @@ static int efm32_spi_probe(struct platform_device *pdev)
 	}
 
 	ret = platform_get_irq(pdev, 0);
-	if (ret <= 0) {
-		dev_err(&pdev->dev, "failed to get rx irq (%d)\n", ret);
+	if (ret <= 0)
 		goto err;
-	}
 
 	ddata->rxirq = ret;
 
diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index 4034e3ec0ba2..4e1ccd4e52b6 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -656,10 +656,8 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get irq resources\n");
+	if (irq < 0)
 		return -EBUSY;
-	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 53335ccc98f6..96eacbe6ae27 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1105,7 +1105,6 @@ static int dspi_probe(struct platform_device *pdev)
 	dspi_init(dspi);
 	dspi->irq = platform_get_irq(pdev, 0);
 	if (dspi->irq < 0) {
-		dev_err(&pdev->dev, "can't get platform irq\n");
 		ret = dspi->irq;
 		goto out_clk_put;
 	}
diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 41a49b93ca60..443d4c1196c2 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -860,10 +860,8 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 
 	/* find the irq */
 	ret = platform_get_irq(pdev, 0);
-	if (ret < 0) {
-		dev_err(dev, "failed to get the irq: %d\n", ret);
+	if (ret < 0)
 		goto err_disable_clk;
-	}
 
 	ret = devm_request_irq(dev, ret,
 			fsl_qspi_irq_handler, 0, pdev->name, q);
diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 5f0b0d5bfef4..242b6c86cf12 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -539,10 +539,8 @@ static int spi_geni_probe(struct platform_device *pdev)
 	struct clk *clk;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "Err getting IRQ %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, res);
diff --git a/drivers/spi/spi-lantiq-ssc.c b/drivers/spi/spi-lantiq-ssc.c
index 8f01858c0ae6..9dfe8b04e688 100644
--- a/drivers/spi/spi-lantiq-ssc.c
+++ b/drivers/spi/spi-lantiq-ssc.c
@@ -819,22 +819,16 @@ static int lantiq_ssc_probe(struct platform_device *pdev)
 	}
 
 	rx_irq = platform_get_irq_byname(pdev, LTQ_SPI_RX_IRQ_NAME);
-	if (rx_irq < 0) {
-		dev_err(dev, "failed to get %s\n", LTQ_SPI_RX_IRQ_NAME);
+	if (rx_irq < 0)
 		return -ENXIO;
-	}
 
 	tx_irq = platform_get_irq_byname(pdev, LTQ_SPI_TX_IRQ_NAME);
-	if (tx_irq < 0) {
-		dev_err(dev, "failed to get %s\n", LTQ_SPI_TX_IRQ_NAME);
+	if (tx_irq < 0)
 		return -ENXIO;
-	}
 
 	err_irq = platform_get_irq_byname(pdev, LTQ_SPI_ERR_IRQ_NAME);
-	if (err_irq < 0) {
-		dev_err(dev, "failed to get %s\n", LTQ_SPI_ERR_IRQ_NAME);
+	if (err_irq < 0)
 		return -ENXIO;
-	}
 
 	master = spi_alloc_master(dev, sizeof(struct lantiq_ssc_spi));
 	if (!master)
diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 45d8a7048b6c..1f5f716016a2 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -664,7 +664,6 @@ static int mtk_spi_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get irq (%d)\n", irq);
 		ret = irq;
 		goto err_put_master;
 	}
diff --git a/drivers/spi/spi-npcm-pspi.c b/drivers/spi/spi-npcm-pspi.c
index 734a2b956959..5c56caea04f0 100644
--- a/drivers/spi/spi-npcm-pspi.c
+++ b/drivers/spi/spi-npcm-pspi.c
@@ -388,7 +388,6 @@ static int npcm_pspi_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ\n");
 		ret = irq;
 		goto out_disable_clk;
 	}
diff --git a/drivers/spi/spi-nuc900.c b/drivers/spi/spi-nuc900.c
index 37e2034ad4d5..f65a029e3fe9 100644
--- a/drivers/spi/spi-nuc900.c
+++ b/drivers/spi/spi-nuc900.c
@@ -367,7 +367,6 @@ static int nuc900_spi_probe(struct platform_device *pdev)
 
 	hw->irq = platform_get_irq(pdev, 0);
 	if (hw->irq < 0) {
-		dev_err(&pdev->dev, "No IRQ specified\n");
 		err = -ENOENT;
 		goto err_pdata;
 	}
diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 8894f98cc99c..501b923f2c27 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -1007,10 +1007,8 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 
 	/* find the irq */
 	ret = platform_get_irq(pdev, 0);
-	if (ret < 0) {
-		dev_err(dev, "failed to get the irq: %d\n", ret);
+	if (ret < 0)
 		goto err_disable_clk;
-	}
 
 	ret = devm_request_irq(dev, ret,
 			nxp_fspi_irq_handler, 0, pdev->name, f);
diff --git a/drivers/spi/spi-pic32-sqi.c b/drivers/spi/spi-pic32-sqi.c
index b635526ad414..11b692923fd7 100644
--- a/drivers/spi/spi-pic32-sqi.c
+++ b/drivers/spi/spi-pic32-sqi.c
@@ -590,7 +590,6 @@ static int pic32_sqi_probe(struct platform_device *pdev)
 	/* irq */
 	sqi->irq = platform_get_irq(pdev, 0);
 	if (sqi->irq < 0) {
-		dev_err(&pdev->dev, "no irq found\n");
 		ret = sqi->irq;
 		goto err_free_master;
 	}
diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
index 10cebeaa1e6b..69f517ec59c6 100644
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -711,22 +711,16 @@ static int pic32_spi_hw_probe(struct platform_device *pdev,
 
 	/* get irq resources: err-irq, rx-irq, tx-irq */
 	pic32s->fault_irq = platform_get_irq_byname(pdev, "fault");
-	if (pic32s->fault_irq < 0) {
-		dev_err(&pdev->dev, "fault-irq not found\n");
+	if (pic32s->fault_irq < 0)
 		return pic32s->fault_irq;
-	}
 
 	pic32s->rx_irq = platform_get_irq_byname(pdev, "rx");
-	if (pic32s->rx_irq < 0) {
-		dev_err(&pdev->dev, "rx-irq not found\n");
+	if (pic32s->rx_irq < 0)
 		return pic32s->rx_irq;
-	}
 
 	pic32s->tx_irq = platform_get_irq_byname(pdev, "tx");
-	if (pic32s->tx_irq < 0) {
-		dev_err(&pdev->dev, "tx-irq not found\n");
+	if (pic32s->tx_irq < 0)
 		return pic32s->tx_irq;
-	}
 
 	/* get clock */
 	pic32s->clk = devm_clk_get(&pdev->dev, "mck0");
diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index e0f061139c8f..a0ad73f1cc01 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -454,10 +454,8 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 		goto exit_probe_master_put;
 
 	ret = platform_get_irq(pdev, 0);
-	if (ret < 0) {
-		dev_err(dev, "Failed to get irq %d\n", ret);
+	if (ret < 0)
 		goto exit_probe_master_put;
-	}
 	ret = devm_request_irq(dev, ret, qcom_qspi_irq,
 			IRQF_TRIGGER_HIGH, dev_name(dev), ctrl);
 	if (ret) {
diff --git a/drivers/spi/spi-s3c24xx.c b/drivers/spi/spi-s3c24xx.c
index 48d8dff05a3a..aea8fd98a31f 100644
--- a/drivers/spi/spi-s3c24xx.c
+++ b/drivers/spi/spi-s3c24xx.c
@@ -545,7 +545,6 @@ static int s3c24xx_spi_probe(struct platform_device *pdev)
 
 	hw->irq = platform_get_irq(pdev, 0);
 	if (hw->irq < 0) {
-		dev_err(&pdev->dev, "No IRQ specified\n");
 		err = -ENOENT;
 		goto err_no_pdata;
 	}
diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index b50bdbc27e58..f73f811c9ba7 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1346,7 +1346,6 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 
 	i = platform_get_irq(pdev, 0);
 	if (i < 0) {
-		dev_err(&pdev->dev, "cannot get IRQ\n");
 		ret = i;
 		goto err1;
 	}
diff --git a/drivers/spi/spi-sh.c b/drivers/spi/spi-sh.c
index f1ee58208216..20bdae5fdf3b 100644
--- a/drivers/spi/spi-sh.c
+++ b/drivers/spi/spi-sh.c
@@ -437,10 +437,8 @@ static int spi_sh_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "platform_get_irq error: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	master = spi_alloc_master(&pdev->dev, sizeof(struct spi_sh_data));
 	if (master == NULL) {
diff --git a/drivers/spi/spi-sifive.c b/drivers/spi/spi-sifive.c
index 93ec2c6cdbfd..5bf2b57e6929 100644
--- a/drivers/spi/spi-sifive.c
+++ b/drivers/spi/spi-sifive.c
@@ -323,7 +323,6 @@ static int sifive_spi_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "Unable to find interrupt\n");
 		ret = irq;
 		goto put_master;
 	}
diff --git a/drivers/spi/spi-slave-mt27xx.c b/drivers/spi/spi-slave-mt27xx.c
index d1075433f6a6..61bc43b0fe57 100644
--- a/drivers/spi/spi-slave-mt27xx.c
+++ b/drivers/spi/spi-slave-mt27xx.c
@@ -410,7 +410,6 @@ static int mtk_spi_slave_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get irq (%d)\n", irq);
 		ret = irq;
 		goto err_put_ctlr;
 	}
diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index 1b7eebb72c07..8c9021b7f7a9 100644
--- a/drivers/spi/spi-sprd.c
+++ b/drivers/spi/spi-sprd.c
@@ -843,10 +843,8 @@ static int sprd_spi_irq_init(struct platform_device *pdev, struct sprd_spi *ss)
 	int ret;
 
 	ss->irq = platform_get_irq(pdev, 0);
-	if (ss->irq < 0) {
-		dev_err(&pdev->dev, "failed to get irq resource\n");
+	if (ss->irq < 0)
 		return ss->irq;
-	}
 
 	ret = devm_request_irq(&pdev->dev, ss->irq, sprd_spi_handle_irq,
 				0, pdev->name, ss);
diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 655e4afbfb2a..9ac6f9fe13cf 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -570,11 +570,8 @@ static int stm32_qspi_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		if (irq != -EPROBE_DEFER)
-			dev_err(dev, "IRQ error missing or invalid\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(dev, irq, stm32_qspi_irq, 0,
 			       dev_name(dev), qspi);
diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index 5194bc07fd60..92e5c667b6a1 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -449,7 +449,6 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "No spi IRQ specified\n");
 		ret = -ENXIO;
 		goto err_free_master;
 	}
diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index ee2bdaf5b856..1cf3051bba5e 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -456,7 +456,6 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "No spi IRQ specified\n");
 		ret = -ENXIO;
 		goto err_free_master;
 	}
diff --git a/drivers/spi/spi-synquacer.c b/drivers/spi/spi-synquacer.c
index f99abd85c50a..ae17c99cce03 100644
--- a/drivers/spi/spi-synquacer.c
+++ b/drivers/spi/spi-synquacer.c
@@ -670,7 +670,6 @@ static int synquacer_spi_probe(struct platform_device *pdev)
 
 	rx_irq = platform_get_irq(pdev, 0);
 	if (rx_irq <= 0) {
-		dev_err(&pdev->dev, "get rx_irq failed (%d)\n", rx_irq);
 		ret = rx_irq;
 		goto put_spi;
 	}
@@ -685,7 +684,6 @@ static int synquacer_spi_probe(struct platform_device *pdev)
 
 	tx_irq = platform_get_irq(pdev, 1);
 	if (tx_irq <= 0) {
-		dev_err(&pdev->dev, "get tx_irq failed (%d)\n", tx_irq);
 		ret = tx_irq;
 		goto put_spi;
 	}
diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 6ca600702470..3cb65371ae3b 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -717,7 +717,6 @@ static int ti_qspi_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq resource?\n");
 		ret = irq;
 		goto free_master;
 	}
diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index b32c77df5d49..c1e6f3245557 100644
--- a/drivers/spi/spi-uniphier.c
+++ b/drivers/spi/spi-uniphier.c
@@ -454,7 +454,6 @@ static int uniphier_spi_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ\n");
 		ret = irq;
 		goto out_disable_clk;
 	}
diff --git a/drivers/spi/spi-xlp.c b/drivers/spi/spi-xlp.c
index 1dc479fab98c..4eb5bc9250fc 100644
--- a/drivers/spi/spi-xlp.c
+++ b/drivers/spi/spi-xlp.c
@@ -384,10 +384,8 @@ static int xlp_spi_probe(struct platform_device *pdev)
 		return PTR_ERR(xspi->base);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "no IRQ resource found: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 	err = devm_request_irq(&pdev->dev, irq, xlp_spi_interrupt, 0,
 			pdev->name, xspi);
 	if (err) {
diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index c6bee67decb5..3155e2cabb1e 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -671,7 +671,6 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 	xqspi->irq = platform_get_irq(pdev, 0);
 	if (xqspi->irq <= 0) {
 		ret = -ENXIO;
-		dev_err(&pdev->dev, "irq resource not found\n");
 		goto remove_master;
 	}
 	ret = devm_request_irq(&pdev->dev, xqspi->irq, zynq_qspi_irq,
diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 07a83ca164c2..5e9ea8a38163 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1077,7 +1077,6 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	xqspi->irq = platform_get_irq(pdev, 0);
 	if (xqspi->irq <= 0) {
 		ret = -ENXIO;
-		dev_err(dev, "irq resource not found\n");
 		goto clk_dis_all;
 	}
 	ret = devm_request_irq(&pdev->dev, xqspi->irq, zynqmp_qspi_irq,
-- 
2.20.1

