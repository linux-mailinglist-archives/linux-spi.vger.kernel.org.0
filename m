Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2D6772729
	for <lists+linux-spi@lfdr.de>; Mon,  7 Aug 2023 16:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbjHGOKY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Aug 2023 10:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbjHGOKU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Aug 2023 10:10:20 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD65FE79
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 07:10:18 -0700 (PDT)
Received: from dggpemm100006.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RKJ5y34rJzNmbs;
        Mon,  7 Aug 2023 22:06:46 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100006.china.huawei.com (7.185.36.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 22:10:14 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 22:10:13 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next v2 10/21] spi: cadence-quadspi: switch to use modern name
Date:   Mon, 7 Aug 2023 22:07:06 +0800
Message-ID: <20230807140717.3484180-11-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230807140717.3484180-1-yangyingliang@huawei.com>
References: <20230807140717.3484180-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 6064b8e0319e..b50db71ac4cc 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -67,7 +67,7 @@ struct cqspi_flash_pdata {
 
 struct cqspi_st {
 	struct platform_device	*pdev;
-	struct spi_master	*master;
+	struct spi_controller	*host;
 	struct clk		*clk;
 	struct clk		*clks[CLK_QSPI_NUM];
 	unsigned int		sclk;
@@ -1379,7 +1379,7 @@ static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
 
 static int cqspi_mem_process(struct spi_mem *mem, const struct spi_mem_op *op)
 {
-	struct cqspi_st *cqspi = spi_master_get_devdata(mem->spi->master);
+	struct cqspi_st *cqspi = spi_controller_get_devdata(mem->spi->controller);
 	struct cqspi_flash_pdata *f_pdata;
 
 	f_pdata = &cqspi->f_pdata[spi_get_chipselect(mem->spi, 0)];
@@ -1585,7 +1585,7 @@ static int cqspi_request_mmap_dma(struct cqspi_st *cqspi)
 
 static const char *cqspi_get_name(struct spi_mem *mem)
 {
-	struct cqspi_st *cqspi = spi_master_get_devdata(mem->spi->master);
+	struct cqspi_st *cqspi = spi_controller_get_devdata(mem->spi->controller);
 	struct device *dev = &cqspi->pdev->dev;
 
 	return devm_kasprintf(dev, GFP_KERNEL, "%s.%d", dev_name(dev),
@@ -1690,26 +1690,26 @@ static int cqspi_probe(struct platform_device *pdev)
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
 	cqspi->is_jh7110 = false;
 	platform_set_drvdata(pdev, cqspi);
 
@@ -1797,7 +1797,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	reset_control_deassert(rstc_ocp);
 
 	cqspi->master_ref_clk_hz = clk_get_rate(cqspi->clk);
-	master->max_speed_hz = cqspi->master_ref_clk_hz;
+	host->max_speed_hz = cqspi->master_ref_clk_hz;
 
 	/* write completion is supported by default */
 	cqspi->wr_completion = true;
@@ -1808,7 +1808,7 @@ static int cqspi_probe(struct platform_device *pdev)
 			cqspi->wr_delay = 50 * DIV_ROUND_UP(NSEC_PER_SEC,
 						cqspi->master_ref_clk_hz);
 		if (ddata->hwcaps_mask & CQSPI_SUPPORTS_OCTAL)
-			master->mode_bits |= SPI_RX_OCTAL | SPI_TX_OCTAL;
+			host->mode_bits |= SPI_RX_OCTAL | SPI_TX_OCTAL;
 		if (!(ddata->quirks & CQSPI_DISABLE_DAC_MODE)) {
 			cqspi->use_direct_mode = true;
 			cqspi->use_direct_mode_wr = true;
@@ -1848,7 +1848,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	cqspi->current_cs = -1;
 	cqspi->sclk = 0;
 
-	master->num_chipselect = cqspi->num_chipselect;
+	host->num_chipselect = cqspi->num_chipselect;
 
 	ret = cqspi_setup_flash(cqspi);
 	if (ret) {
@@ -1862,7 +1862,7 @@ static int cqspi_probe(struct platform_device *pdev)
 			goto probe_setup_failed;
 	}
 
-	ret = spi_register_master(master);
+	ret = spi_register_controller(host);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register SPI ctlr %d\n", ret);
 		goto probe_setup_failed;
@@ -1884,7 +1884,7 @@ static void cqspi_remove(struct platform_device *pdev)
 {
 	struct cqspi_st *cqspi = platform_get_drvdata(pdev);
 
-	spi_unregister_master(cqspi->master);
+	spi_unregister_controller(cqspi->host);
 	cqspi_controller_enable(cqspi, 0);
 
 	if (cqspi->rx_chan)
@@ -1902,10 +1902,10 @@ static void cqspi_remove(struct platform_device *pdev)
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
@@ -1916,7 +1916,7 @@ static int cqspi_suspend(struct device *dev)
 static int cqspi_resume(struct device *dev)
 {
 	struct cqspi_st *cqspi = dev_get_drvdata(dev);
-	struct spi_master *master = dev_get_drvdata(dev);
+	struct spi_controller *host = dev_get_drvdata(dev);
 
 	clk_prepare_enable(cqspi->clk);
 	cqspi_wait_idle(cqspi);
@@ -1925,7 +1925,7 @@ static int cqspi_resume(struct device *dev)
 	cqspi->current_cs = -1;
 	cqspi->sclk = 0;
 
-	return spi_master_resume(master);
+	return spi_controller_resume(host);
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(cqspi_dev_pm_ops, cqspi_suspend, cqspi_resume);
-- 
2.25.1

