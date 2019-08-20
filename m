Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6FDC95FA7
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2019 15:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbfHTNOd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Aug 2019 09:14:33 -0400
Received: from mail-ed1-f97.google.com ([209.85.208.97]:34722 "EHLO
        mail-ed1-f97.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729961AbfHTNO3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Aug 2019 09:14:29 -0400
Received: by mail-ed1-f97.google.com with SMTP id s49so6290006edb.1
        for <linux-spi@vger.kernel.org>; Tue, 20 Aug 2019 06:14:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=iMeyrOR20rCEGyFnabyjLtTTlZkQTko83Vy8Uq8ZxeM=;
        b=INiIzxTWgvOfiH3vmlRQBadiXbBHDxU5LtPL5V/s+dMxjZJTrWveXIdEA/spHSpFP1
         m/uNzKGJ4jceBMaxfN658xFKVhGzUblJjvo3zntZE874rE29aGBrGnlTH6DLvFS8tL8H
         O5Sgyuqv75ktM6SAOU+B+/eeoaqh5D5aTnTFAk4ZQ0ahFpZF/9B2te7Lj2xKurCw9Jfi
         gfv7Hcs/96vkJjdEJ5hIdGOgzdxwVUDaZeqtUBpYMMJGPyk3MZqSzh/wyo3bFU5SsXE0
         EbcT17EuQhMdaxSl1lTiTG0+7zNDGH8WbiN8180410uVELpZJdjElUIFgGPrFhzN+ooV
         cziw==
X-Gm-Message-State: APjAAAV+Ztzpz/6gpvCfTitxraTgzXe4EJbwCFmHW/wYkNb+8R6cTWlM
        EVmEvNZ6tMrqiqL9IvSYLvH6I/t7nie8EN9ZPCl91krE71T4OOG09rhGtVcLyMrlkg==
X-Google-Smtp-Source: APXvYqzh22jI0TvsUBAnCT8AqGFlRiDTrpWG8fornikbXAy8NFWCKH9VUNs1ivRgMkJg+8VI9pyjcXAAlWOO
X-Received: by 2002:a17:906:30d1:: with SMTP id b17mr19216765ejb.9.1566306867663;
        Tue, 20 Aug 2019 06:14:27 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id y42sm308231edd.29.2019.08.20.06.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 06:14:27 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i03xz-0002Ll-6t; Tue, 20 Aug 2019 13:14:27 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id AAC8C274314F; Tue, 20 Aug 2019 14:14:26 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-fsl-dspi: Replace legacy spi_master names with spi_controller" to the spi tree
In-Reply-To: <20190818180115.31114-10-olteanv@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190820131426.AAC8C274314F@ypsilon.sirena.org.uk>
Date:   Tue, 20 Aug 2019 14:14:26 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spi-fsl-dspi: Replace legacy spi_master names with spi_controller

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

From 3a11ea664be6ff16387759d57aed3a015f6339a1 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <olteanv@gmail.com>
Date: Sun, 18 Aug 2019 21:01:10 +0300
Subject: [PATCH] spi: spi-fsl-dspi: Replace legacy spi_master names with
 spi_controller

This adapts the spi-fsl-dspi driver to the API changes introduced in
commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"").

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Link: https://lore.kernel.org/r/20190818180115.31114-10-olteanv@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 100 ++++++++++++++++++-------------------
 1 file changed, 50 insertions(+), 50 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 753584c4065c..a9bcbc458172 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -171,7 +171,7 @@ struct fsl_dspi_dma {
 };
 
 struct fsl_dspi {
-	struct spi_master			*master;
+	struct spi_controller			*ctlr;
 	struct platform_device			*pdev;
 
 	struct regmap				*regmap;
@@ -219,7 +219,7 @@ static u32 dspi_pop_tx_pushr(struct fsl_dspi *dspi)
 {
 	u16 cmd = dspi->tx_cmd, data = dspi_pop_tx(dspi);
 
-	if (spi_controller_is_slave(dspi->master))
+	if (spi_controller_is_slave(dspi->ctlr))
 		return data;
 
 	if (dspi->len > 0)
@@ -318,7 +318,7 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 	dma_async_issue_pending(dma->chan_rx);
 	dma_async_issue_pending(dma->chan_tx);
 
-	if (spi_controller_is_slave(dspi->master)) {
+	if (spi_controller_is_slave(dspi->ctlr)) {
 		wait_for_completion_interruptible(&dspi->dma->cmd_rx_complete);
 		return 0;
 	}
@@ -647,10 +647,10 @@ static void dspi_eoq_read(struct fsl_dspi *dspi)
 		dspi_push_rx(dspi, fifo_read(dspi));
 }
 
-static int dspi_transfer_one_message(struct spi_master *master,
+static int dspi_transfer_one_message(struct spi_controller *ctlr,
 				     struct spi_message *message)
 {
-	struct fsl_dspi *dspi = spi_master_get_devdata(master);
+	struct fsl_dspi *dspi = spi_controller_get_devdata(ctlr);
 	struct spi_device *spi = message->spi;
 	struct spi_transfer *transfer;
 	int status = 0;
@@ -745,7 +745,7 @@ static int dspi_transfer_one_message(struct spi_master *master,
 
 out:
 	message->status = status;
-	spi_finalize_current_message(master);
+	spi_finalize_current_message(ctlr);
 
 	return status;
 }
@@ -753,7 +753,7 @@ static int dspi_transfer_one_message(struct spi_master *master,
 static int dspi_setup(struct spi_device *spi)
 {
 	struct chip_data *chip;
-	struct fsl_dspi *dspi = spi_master_get_devdata(spi->master);
+	struct fsl_dspi *dspi = spi_controller_get_devdata(spi->controller);
 	struct fsl_dspi_platform_data *pdata;
 	u32 cs_sck_delay = 0, sck_cs_delay = 0;
 	unsigned char br = 0, pbr = 0, pcssck = 0, cssck = 0;
@@ -798,7 +798,7 @@ static int dspi_setup(struct spi_device *spi)
 	if (spi->mode & SPI_CPHA)
 		chip->ctar_val |= SPI_CTAR_CPHA;
 
-	if (!spi_controller_is_slave(dspi->master)) {
+	if (!spi_controller_is_slave(dspi->ctlr)) {
 		chip->ctar_val |= SPI_CTAR_PCSSCK(pcssck) |
 				  SPI_CTAR_CSSCK(cssck) |
 				  SPI_CTAR_PASC(pasc) |
@@ -820,7 +820,7 @@ static void dspi_cleanup(struct spi_device *spi)
 	struct chip_data *chip = spi_get_ctldata((struct spi_device *)spi);
 
 	dev_dbg(&spi->dev, "spi_device %u.%u cleanup\n",
-		spi->master->bus_num, spi->chip_select);
+		spi->controller->bus_num, spi->chip_select);
 
 	kfree(chip);
 }
@@ -893,10 +893,10 @@ MODULE_DEVICE_TABLE(of, fsl_dspi_dt_ids);
 #ifdef CONFIG_PM_SLEEP
 static int dspi_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct fsl_dspi *dspi = spi_master_get_devdata(master);
+	struct spi_controller *ctlr = dev_get_drvdata(dev);
+	struct fsl_dspi *dspi = spi_controller_get_devdata(ctlr);
 
-	spi_master_suspend(master);
+	spi_controller_suspend(ctlr);
 	clk_disable_unprepare(dspi->clk);
 
 	pinctrl_pm_select_sleep_state(dev);
@@ -906,8 +906,8 @@ static int dspi_suspend(struct device *dev)
 
 static int dspi_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct fsl_dspi *dspi = spi_master_get_devdata(master);
+	struct spi_controller *ctlr = dev_get_drvdata(dev);
+	struct fsl_dspi *dspi = spi_controller_get_devdata(ctlr);
 	int ret;
 
 	pinctrl_pm_select_default_state(dev);
@@ -915,7 +915,7 @@ static int dspi_resume(struct device *dev)
 	ret = clk_prepare_enable(dspi->clk);
 	if (ret)
 		return ret;
-	spi_master_resume(master);
+	spi_controller_resume(ctlr);
 
 	return 0;
 }
@@ -977,7 +977,7 @@ static void dspi_init(struct fsl_dspi *dspi)
 
 	if (dspi->devtype_data->xspi_mode)
 		mcr |= SPI_MCR_XSPI;
-	if (!spi_controller_is_slave(dspi->master))
+	if (!spi_controller_is_slave(dspi->ctlr))
 		mcr |= SPI_MCR_MASTER;
 
 	regmap_write(dspi->regmap, SPI_MCR, mcr);
@@ -990,7 +990,7 @@ static void dspi_init(struct fsl_dspi *dspi)
 static int dspi_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct spi_master *master;
+	struct spi_controller *ctlr;
 	struct fsl_dspi *dspi;
 	struct resource *res;
 	const struct regmap_config *regmap_config;
@@ -998,25 +998,25 @@ static int dspi_probe(struct platform_device *pdev)
 	struct fsl_dspi_platform_data *pdata;
 	int ret, cs_num, bus_num;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(struct fsl_dspi));
-	if (!master)
+	ctlr = spi_alloc_master(&pdev->dev, sizeof(struct fsl_dspi));
+	if (!ctlr)
 		return -ENOMEM;
 
-	dspi = spi_master_get_devdata(master);
+	dspi = spi_controller_get_devdata(ctlr);
 	dspi->pdev = pdev;
-	dspi->master = master;
+	dspi->ctlr = ctlr;
 
-	master->setup = dspi_setup;
-	master->transfer_one_message = dspi_transfer_one_message;
-	master->dev.of_node = pdev->dev.of_node;
+	ctlr->setup = dspi_setup;
+	ctlr->transfer_one_message = dspi_transfer_one_message;
+	ctlr->dev.of_node = pdev->dev.of_node;
 
-	master->cleanup = dspi_cleanup;
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST;
+	ctlr->cleanup = dspi_cleanup;
+	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST;
 
 	pdata = dev_get_platdata(&pdev->dev);
 	if (pdata) {
-		master->num_chipselect = pdata->cs_num;
-		master->bus_num = pdata->bus_num;
+		ctlr->num_chipselect = pdata->cs_num;
+		ctlr->bus_num = pdata->bus_num;
 
 		dspi->devtype_data = &coldfire_data;
 	} else {
@@ -1024,38 +1024,38 @@ static int dspi_probe(struct platform_device *pdev)
 		ret = of_property_read_u32(np, "spi-num-chipselects", &cs_num);
 		if (ret < 0) {
 			dev_err(&pdev->dev, "can't get spi-num-chipselects\n");
-			goto out_master_put;
+			goto out_ctlr_put;
 		}
-		master->num_chipselect = cs_num;
+		ctlr->num_chipselect = cs_num;
 
 		ret = of_property_read_u32(np, "bus-num", &bus_num);
 		if (ret < 0) {
 			dev_err(&pdev->dev, "can't get bus-num\n");
-			goto out_master_put;
+			goto out_ctlr_put;
 		}
-		master->bus_num = bus_num;
+		ctlr->bus_num = bus_num;
 
 		if (of_property_read_bool(np, "spi-slave"))
-			master->slave = true;
+			ctlr->slave = true;
 
 		dspi->devtype_data = of_device_get_match_data(&pdev->dev);
 		if (!dspi->devtype_data) {
 			dev_err(&pdev->dev, "can't get devtype_data\n");
 			ret = -EFAULT;
-			goto out_master_put;
+			goto out_ctlr_put;
 		}
 	}
 
 	if (dspi->devtype_data->xspi_mode)
-		master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
+		ctlr->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
 	else
-		master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 16);
+		ctlr->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 16);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(base)) {
 		ret = PTR_ERR(base);
-		goto out_master_put;
+		goto out_ctlr_put;
 	}
 
 	if (dspi->devtype_data->xspi_mode)
@@ -1067,7 +1067,7 @@ static int dspi_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to init regmap: %ld\n",
 				PTR_ERR(dspi->regmap));
 		ret = PTR_ERR(dspi->regmap);
-		goto out_master_put;
+		goto out_ctlr_put;
 	}
 
 	if (dspi->devtype_data->xspi_mode) {
@@ -1079,7 +1079,7 @@ static int dspi_probe(struct platform_device *pdev)
 				"failed to init pushr regmap: %ld\n",
 				PTR_ERR(dspi->regmap_pushr));
 			ret = PTR_ERR(dspi->regmap_pushr);
-			goto out_master_put;
+			goto out_ctlr_put;
 		}
 	}
 
@@ -1087,11 +1087,11 @@ static int dspi_probe(struct platform_device *pdev)
 	if (IS_ERR(dspi->clk)) {
 		ret = PTR_ERR(dspi->clk);
 		dev_err(&pdev->dev, "unable to get clock\n");
-		goto out_master_put;
+		goto out_ctlr_put;
 	}
 	ret = clk_prepare_enable(dspi->clk);
 	if (ret)
-		goto out_master_put;
+		goto out_ctlr_put;
 
 	dspi_init(dspi);
 	dspi->irq = platform_get_irq(pdev, 0);
@@ -1115,15 +1115,15 @@ static int dspi_probe(struct platform_device *pdev)
 		}
 	}
 
-	master->max_speed_hz =
+	ctlr->max_speed_hz =
 		clk_get_rate(dspi->clk) / dspi->devtype_data->max_clock_factor;
 
 	init_waitqueue_head(&dspi->waitq);
-	platform_set_drvdata(pdev, master);
+	platform_set_drvdata(pdev, ctlr);
 
-	ret = spi_register_master(master);
+	ret = spi_register_controller(ctlr);
 	if (ret != 0) {
-		dev_err(&pdev->dev, "Problem registering DSPI master\n");
+		dev_err(&pdev->dev, "Problem registering DSPI ctlr\n");
 		goto out_clk_put;
 	}
 
@@ -1131,21 +1131,21 @@ static int dspi_probe(struct platform_device *pdev)
 
 out_clk_put:
 	clk_disable_unprepare(dspi->clk);
-out_master_put:
-	spi_master_put(master);
+out_ctlr_put:
+	spi_controller_put(ctlr);
 
 	return ret;
 }
 
 static int dspi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct fsl_dspi *dspi = spi_master_get_devdata(master);
+	struct spi_controller *ctlr = platform_get_drvdata(pdev);
+	struct fsl_dspi *dspi = spi_controller_get_devdata(ctlr);
 
 	/* Disconnect from the SPI framework */
 	dspi_release_dma(dspi);
 	clk_disable_unprepare(dspi->clk);
-	spi_unregister_master(dspi->master);
+	spi_unregister_controller(dspi->ctlr);
 
 	return 0;
 }
-- 
2.20.1

