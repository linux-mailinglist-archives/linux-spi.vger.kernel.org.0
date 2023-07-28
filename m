Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CD57668FF
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jul 2023 11:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbjG1JfV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Jul 2023 05:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235476AbjG1JfP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Jul 2023 05:35:15 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0846E173F
        for <linux-spi@vger.kernel.org>; Fri, 28 Jul 2023 02:35:14 -0700 (PDT)
Received: from dggpemm500008.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RC2WM35jCzVjsd;
        Fri, 28 Jul 2023 17:33:35 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500008.china.huawei.com (7.185.36.136) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 17:35:08 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 17:35:08 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 10/21] spi: cadence-quadspi: switch to use modern name
Date:   Fri, 28 Jul 2023 17:32:10 +0800
Message-ID: <20230728093221.3312026-11-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230728093221.3312026-1-yangyingliang@huawei.com>
References: <20230728093221.3312026-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Change legacy name master to modern name host or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-cadence-quadspi.c | 44 +++++++++++++++----------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index e1a8cf08ef66..1c28f02042b0 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -61,7 +61,7 @@ struct cqspi_flash_pdata {
 
 struct cqspi_st {
 	struct platform_device	*pdev;
-	struct spi_master	*master;
+	struct spi_controller	*host;
 	struct clk		*clk;
 	unsigned int		sclk;
 
@@ -1368,7 +1368,7 @@ static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
 
 static int cqspi_mem_process(struct spi_mem *mem, const struct spi_mem_op *op)
 {
-	struct cqspi_st *cqspi = spi_master_get_devdata(mem->spi->master);
+	struct cqspi_st *cqspi = spi_controller_get_devdata(mem->spi->controller);
 	struct cqspi_flash_pdata *f_pdata;
 
 	f_pdata = &cqspi->f_pdata[spi_get_chipselect(mem->spi, 0)];
@@ -1574,7 +1574,7 @@ static int cqspi_request_mmap_dma(struct cqspi_st *cqspi)
 
 static const char *cqspi_get_name(struct spi_mem *mem)
 {
-	struct cqspi_st *cqspi = spi_master_get_devdata(mem->spi->master);
+	struct cqspi_st *cqspi = spi_controller_get_devdata(mem->spi->controller);
 	struct device *dev = &cqspi->pdev->dev;
 
 	return devm_kasprintf(dev, GFP_KERNEL, "%s.%d", dev_name(dev),
@@ -1634,26 +1634,26 @@ static int cqspi_probe(struct platform_device *pdev)
 	const struct cqspi_driver_platdata *ddata;
 	struct reset_control *rstc, *rstc_ocp, *rstc_ref;
 	struct device *dev = &pdev->dev;
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct resource *res_ahb;
 	struct cqspi_st *cqspi;
 	int ret;
 	int irq;
 
-	master = devm_spi_alloc_master(&pdev->dev, sizeof(*cqspi));
-	if (!master) {
-		dev_err(&pdev->dev, "spi_alloc_master failed\n");
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(*cqspi));
+	if (!host) {
+		dev_err(&pdev->dev, "devm_spi_alloc_host failed\n");
 		return -ENOMEM;
 	}
-	master->mode_bits = SPI_RX_QUAD | SPI_RX_DUAL;
-	master->mem_ops = &cqspi_mem_ops;
-	master->mem_caps = &cqspi_mem_caps;
-	master->dev.of_node = pdev->dev.of_node;
+	host->mode_bits = SPI_RX_QUAD | SPI_RX_DUAL;
+	host->mem_ops = &cqspi_mem_ops;
+	host->mem_caps = &cqspi_mem_caps;
+	host->dev.of_node = pdev->dev.of_node;
 
-	cqspi = spi_master_get_devdata(master);
+	cqspi = spi_controller_get_devdata(host);
 
 	cqspi->pdev = pdev;
-	cqspi->master = master;
+	cqspi->host = host;
 	platform_set_drvdata(pdev, cqspi);
 
 	/* Obtain configuration from OF. */
@@ -1740,7 +1740,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	reset_control_deassert(rstc_ocp);
 
 	cqspi->master_ref_clk_hz = clk_get_rate(cqspi->clk);
-	master->max_speed_hz = cqspi->master_ref_clk_hz;
+	host->max_speed_hz = cqspi->master_ref_clk_hz;
 
 	/* write completion is supported by default */
 	cqspi->wr_completion = true;
@@ -1751,7 +1751,7 @@ static int cqspi_probe(struct platform_device *pdev)
 			cqspi->wr_delay = 50 * DIV_ROUND_UP(NSEC_PER_SEC,
 						cqspi->master_ref_clk_hz);
 		if (ddata->hwcaps_mask & CQSPI_SUPPORTS_OCTAL)
-			master->mode_bits |= SPI_RX_OCTAL | SPI_TX_OCTAL;
+			host->mode_bits |= SPI_RX_OCTAL | SPI_TX_OCTAL;
 		if (!(ddata->quirks & CQSPI_DISABLE_DAC_MODE)) {
 			cqspi->use_direct_mode = true;
 			cqspi->use_direct_mode_wr = true;
@@ -1785,7 +1785,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	cqspi->current_cs = -1;
 	cqspi->sclk = 0;
 
-	master->num_chipselect = cqspi->num_chipselect;
+	host->num_chipselect = cqspi->num_chipselect;
 
 	ret = cqspi_setup_flash(cqspi);
 	if (ret) {
@@ -1799,7 +1799,7 @@ static int cqspi_probe(struct platform_device *pdev)
 			goto probe_setup_failed;
 	}
 
-	ret = spi_register_master(master);
+	ret = spi_register_controller(host);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register SPI ctlr %d\n", ret);
 		goto probe_setup_failed;
@@ -1821,7 +1821,7 @@ static void cqspi_remove(struct platform_device *pdev)
 {
 	struct cqspi_st *cqspi = platform_get_drvdata(pdev);
 
-	spi_unregister_master(cqspi->master);
+	spi_unregister_controller(cqspi->host);
 	cqspi_controller_enable(cqspi, 0);
 
 	if (cqspi->rx_chan)
@@ -1836,10 +1836,10 @@ static void cqspi_remove(struct platform_device *pdev)
 static int cqspi_suspend(struct device *dev)
 {
 	struct cqspi_st *cqspi = dev_get_drvdata(dev);
-	struct spi_master *master = dev_get_drvdata(dev);
+	struct spi_controller *host = dev_get_drvdata(dev);
 	int ret;
 
-	ret = spi_master_suspend(master);
+	ret = spi_controller_suspend(host);
 	cqspi_controller_enable(cqspi, 0);
 
 	clk_disable_unprepare(cqspi->clk);
@@ -1850,7 +1850,7 @@ static int cqspi_suspend(struct device *dev)
 static int cqspi_resume(struct device *dev)
 {
 	struct cqspi_st *cqspi = dev_get_drvdata(dev);
-	struct spi_master *master = dev_get_drvdata(dev);
+	struct spi_controller *host = dev_get_drvdata(dev);
 
 	clk_prepare_enable(cqspi->clk);
 	cqspi_wait_idle(cqspi);
@@ -1859,7 +1859,7 @@ static int cqspi_resume(struct device *dev)
 	cqspi->current_cs = -1;
 	cqspi->sclk = 0;
 
-	return spi_master_resume(master);
+	return spi_controller_resume(host);
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(cqspi_dev_pm_ops, cqspi_suspend, cqspi_resume);
-- 
2.25.1

