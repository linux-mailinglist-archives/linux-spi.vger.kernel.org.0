Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEADB288195
	for <lists+linux-spi@lfdr.de>; Fri,  9 Oct 2020 07:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgJIFC2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 9 Oct 2020 01:02:28 -0400
Received: from mailout11.rmx.de ([94.199.88.76]:38086 "EHLO mailout11.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbgJIFC2 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 9 Oct 2020 01:02:28 -0400
X-Greylist: delayed 2041 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Oct 2020 01:02:26 EDT
Received: from kdin01.retarus.com (kdin01.dmz1.retloc [172.19.17.48])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout11.rmx.de (Postfix) with ESMTPS id 4C6w6r6QzJz3yRN;
        Fri,  9 Oct 2020 06:28:20 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin01.retarus.com (Postfix) with ESMTPS id 4C6w6D0wv2z2xFb;
        Fri,  9 Oct 2020 06:27:48 +0200 (CEST)
Received: from N95HX1G2.wgnetz.xx (192.168.54.16) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 9 Oct
 2020 06:27:47 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>
CC:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Christian Eggers <ceggers@arri.de>
Subject: [PATCH] spi: imx: Revert "spi: imx: enable runtime pm support"
Date:   Fri, 9 Oct 2020 06:27:38 +0200
Message-ID: <20201009042738.26602-1-ceggers@arri.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.54.16]
X-RMX-ID: 20201009-062748-4C6w6D0wv2z2xFb-0@kdin01
X-RMX-SOURCE: 217.111.95.66
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This reverts commit 525c9e5a32bd7951eae3f06d9d077fea51718a6c.

If CONFIG_PM is disabled, the system completely freezes on probe as
nothing enables the clock of the SPI peripheral.

Signed-off-by: Christian Eggers <ceggers@arri.de>
---
 drivers/spi/spi-imx.c | 121 ++++++++++++------------------------------
 1 file changed, 33 insertions(+), 88 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 38a5f1304cec..fdc25f549378 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -13,9 +13,7 @@
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
-#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
@@ -32,8 +30,6 @@ static bool use_dma = true;
 module_param(use_dma, bool, 0644);
 MODULE_PARM_DESC(use_dma, "Enable usage of DMA when available (default)");
 
-#define MXC_RPM_TIMEOUT		2000 /* 2000ms */
-
 #define MXC_CSPIRXDATA		0x00
 #define MXC_CSPITXDATA		0x04
 #define MXC_CSPICTRL		0x08
@@ -1534,16 +1530,20 @@ spi_imx_prepare_message(struct spi_master *master, struct spi_message *msg)
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
 	int ret;
 
-	ret = pm_runtime_get_sync(spi_imx->dev);
-	if (ret < 0) {
-		dev_err(spi_imx->dev, "failed to enable clock\n");
+	ret = clk_enable(spi_imx->clk_per);
+	if (ret)
+		return ret;
+
+	ret = clk_enable(spi_imx->clk_ipg);
+	if (ret) {
+		clk_disable(spi_imx->clk_per);
 		return ret;
 	}
 
 	ret = spi_imx->devtype_data->prepare_message(spi_imx, msg);
 	if (ret) {
-		pm_runtime_mark_last_busy(spi_imx->dev);
-		pm_runtime_put_autosuspend(spi_imx->dev);
+		clk_disable(spi_imx->clk_ipg);
+		clk_disable(spi_imx->clk_per);
 	}
 
 	return ret;
@@ -1554,8 +1554,8 @@ spi_imx_unprepare_message(struct spi_master *master, struct spi_message *msg)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
 
-	pm_runtime_mark_last_busy(spi_imx->dev);
-	pm_runtime_put_autosuspend(spi_imx->dev);
+	clk_disable(spi_imx->clk_ipg);
+	clk_disable(spi_imx->clk_per);
 	return 0;
 }
 
@@ -1674,15 +1674,13 @@ static int spi_imx_probe(struct platform_device *pdev)
 		goto out_master_put;
 	}
 
-	pm_runtime_enable(spi_imx->dev);
-	pm_runtime_set_autosuspend_delay(spi_imx->dev, MXC_RPM_TIMEOUT);
-	pm_runtime_use_autosuspend(spi_imx->dev);
+	ret = clk_prepare_enable(spi_imx->clk_per);
+	if (ret)
+		goto out_master_put;
 
-	ret = pm_runtime_get_sync(spi_imx->dev);
-	if (ret < 0) {
-		dev_err(spi_imx->dev, "failed to enable clock\n");
-		goto out_runtime_pm_put;
-	}
+	ret = clk_prepare_enable(spi_imx->clk_ipg);
+	if (ret)
+		goto out_put_per;
 
 	spi_imx->spi_clk = clk_get_rate(spi_imx->clk_per);
 	/*
@@ -1692,7 +1690,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 	if (spi_imx->devtype_data->has_dmamode) {
 		ret = spi_imx_sdma_init(&pdev->dev, spi_imx, master);
 		if (ret == -EPROBE_DEFER)
-			goto out_runtime_pm_put;
+			goto out_clk_put;
 
 		if (ret < 0)
 			dev_err(&pdev->dev, "dma setup error %d, use pio\n",
@@ -1707,20 +1705,19 @@ static int spi_imx_probe(struct platform_device *pdev)
 	ret = spi_bitbang_start(&spi_imx->bitbang);
 	if (ret) {
 		dev_err(&pdev->dev, "bitbang start failed with %d\n", ret);
-		goto out_runtime_pm_put;
+		goto out_clk_put;
 	}
 
 	dev_info(&pdev->dev, "probed\n");
 
-	pm_runtime_mark_last_busy(spi_imx->dev);
-	pm_runtime_put_autosuspend(spi_imx->dev);
-
+	clk_disable(spi_imx->clk_ipg);
+	clk_disable(spi_imx->clk_per);
 	return ret;
 
-out_runtime_pm_put:
-	pm_runtime_dont_use_autosuspend(spi_imx->dev);
-	pm_runtime_put_sync(spi_imx->dev);
-	pm_runtime_disable(spi_imx->dev);
+out_clk_put:
+	clk_disable_unprepare(spi_imx->clk_ipg);
+out_put_per:
+	clk_disable_unprepare(spi_imx->clk_per);
 out_master_put:
 	spi_master_put(master);
 
@@ -1735,82 +1732,30 @@ static int spi_imx_remove(struct platform_device *pdev)
 
 	spi_bitbang_stop(&spi_imx->bitbang);
 
-	ret = pm_runtime_get_sync(spi_imx->dev);
-	if (ret < 0) {
-		dev_err(spi_imx->dev, "failed to enable clock\n");
-		return ret;
-	}
-
-	writel(0, spi_imx->base + MXC_CSPICTRL);
-
-	pm_runtime_dont_use_autosuspend(spi_imx->dev);
-	pm_runtime_put_sync(spi_imx->dev);
-	pm_runtime_disable(spi_imx->dev);
-
-	spi_imx_sdma_exit(spi_imx);
-	spi_master_put(master);
-
-	return 0;
-}
-
-static int __maybe_unused spi_imx_runtime_resume(struct device *dev)
-{
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct spi_imx_data *spi_imx;
-	int ret;
-
-	spi_imx = spi_master_get_devdata(master);
-
-	ret = clk_prepare_enable(spi_imx->clk_per);
+	ret = clk_enable(spi_imx->clk_per);
 	if (ret)
 		return ret;
 
-	ret = clk_prepare_enable(spi_imx->clk_ipg);
+	ret = clk_enable(spi_imx->clk_ipg);
 	if (ret) {
-		clk_disable_unprepare(spi_imx->clk_per);
+		clk_disable(spi_imx->clk_per);
 		return ret;
 	}
 
-	return 0;
-}
-
-static int __maybe_unused spi_imx_runtime_suspend(struct device *dev)
-{
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct spi_imx_data *spi_imx;
-
-	spi_imx = spi_master_get_devdata(master);
-
-	clk_disable_unprepare(spi_imx->clk_per);
+	writel(0, spi_imx->base + MXC_CSPICTRL);
 	clk_disable_unprepare(spi_imx->clk_ipg);
+	clk_disable_unprepare(spi_imx->clk_per);
+	spi_imx_sdma_exit(spi_imx);
+	spi_master_put(master);
 
 	return 0;
 }
 
-static int __maybe_unused spi_imx_suspend(struct device *dev)
-{
-	pinctrl_pm_select_sleep_state(dev);
-	return 0;
-}
-
-static int __maybe_unused spi_imx_resume(struct device *dev)
-{
-	pinctrl_pm_select_default_state(dev);
-	return 0;
-}
-
-static const struct dev_pm_ops imx_spi_pm = {
-	SET_RUNTIME_PM_OPS(spi_imx_runtime_suspend,
-				spi_imx_runtime_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(spi_imx_suspend, spi_imx_resume)
-};
-
 static struct platform_driver spi_imx_driver = {
 	.driver = {
 		   .name = DRIVER_NAME,
 		   .of_match_table = spi_imx_dt_ids,
-		   .pm = &imx_spi_pm,
-	},
+		   },
 	.id_table = spi_imx_devtype,
 	.probe = spi_imx_probe,
 	.remove = spi_imx_remove,
-- 
Christian Eggers
Embedded software developer

Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
Sitz: Muenchen - Registergericht: Amtsgericht Muenchen - Handelsregisternummer: HRA 57918
Persoenlich haftender Gesellschafter: Arnold & Richter Cine Technik GmbH
Sitz: Muenchen - Registergericht: Amtsgericht Muenchen - Handelsregisternummer: HRB 54477
Geschaeftsfuehrer: Dr. Michael Neuhaeuser; Stephan Schenk; Walter Trauninger; Markus Zeiler

