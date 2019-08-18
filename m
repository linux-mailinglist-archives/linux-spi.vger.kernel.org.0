Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70EB29189A
	for <lists+linux-spi@lfdr.de>; Sun, 18 Aug 2019 20:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfHRSBc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 18 Aug 2019 14:01:32 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35697 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfHRSBb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 18 Aug 2019 14:01:31 -0400
Received: by mail-wm1-f66.google.com with SMTP id l2so1071947wmg.0
        for <linux-spi@vger.kernel.org>; Sun, 18 Aug 2019 11:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=odOQzQlETtiXgH1tSJoyUlBRBYLm7TqRLzdkge6Imas=;
        b=MIhDlKRl8fOFyEyU37tkSRllnXb0KCxTEX2dLYlmRBYDG2WhjfaIqDBK+p6uH4gYkz
         gYPazZKRzwCok4EVhASlVqUCm8Z33fgjYnKG1Jm6BO85mS892AL4ipf3SUvF7XCOkMsC
         pllF4LS6CH2mBxk/pbpxOu1E5lLk5lBxyvWU3DOCMt6L8DREYydiCxDRqsmm1dki+n+j
         y+bX1pJDdOXHKzI4NrIcEOYky0x0lKYhDf0TwRvZ8FEIOZRdBb76CqWOMEVa0VKwgCoB
         WYJ3xABBWkp4gFZAXYvvoO7Ne83xbuGXleWQxAgczecRZACGXMuASU6C0f4RpzPQrbZV
         tI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=odOQzQlETtiXgH1tSJoyUlBRBYLm7TqRLzdkge6Imas=;
        b=cV7zr3cF5FnUnKVttobiUMB2yKMTYfrQStoWSMNUpYDwgEo2Dy82uTYSXkU5ArRlzG
         6bWSdOsp76LqAz2zA/hCkKykFkvpZwsvsTh7c8i7ayyN2W/oSFS21cMKObgDwaw890oV
         zBlov9EIKrNcgymEMvruXPZx5IAngJ6vnqQBp3uZMO9c81gmb1Pkd0Ror2MMhua4kyL8
         x2uVLkt5MhDOoH/1krpvQyV57tDDxc57UvTs9OSDQPKFlDDUOotJg0OhKTefsUAQPIHj
         6xLoI1OnRYeKzI8dKd2RMZ26uXs8vZ0/0v6w7JoKOpCYRgYh02vHtPn2tU38NicDVksT
         g0ww==
X-Gm-Message-State: APjAAAV82IHWQz6TwPcCaYcPtI3zJCftW2xsoZ9lzxV4gI7HdG4cctVl
        WONcjCc367xd4l84u99i1fg=
X-Google-Smtp-Source: APXvYqyyhmghaZ/UVkqth3X9TkJiOwqJFL3U5OYWrdo7r5bEQG2MZzlCHS+XDbtiWFd+EtxPyd8u1g==
X-Received: by 2002:a1c:a9ce:: with SMTP id s197mr16070458wme.35.1566151288491;
        Sun, 18 Aug 2019 11:01:28 -0700 (PDT)
Received: from localhost.localdomain ([188.25.91.80])
        by smtp.gmail.com with ESMTPSA id x6sm9372246wmf.6.2019.08.18.11.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 11:01:28 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH spi for-5.4 09/14] spi: spi-fsl-dspi: Replace legacy spi_master names with spi_controller
Date:   Sun, 18 Aug 2019 21:01:10 +0300
Message-Id: <20190818180115.31114-10-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190818180115.31114-1-olteanv@gmail.com>
References: <20190818180115.31114-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This adapts the spi-fsl-dspi driver to the API changes introduced in
commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"").

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
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
2.17.1

