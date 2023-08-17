Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A61F77F011
	for <lists+linux-spi@lfdr.de>; Thu, 17 Aug 2023 07:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348071AbjHQFHy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Aug 2023 01:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348072AbjHQFHd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Aug 2023 01:07:33 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3107F268D
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 22:07:32 -0700 (PDT)
Received: from dggpemm100007.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RRCdW6Hp9zrSc2;
        Thu, 17 Aug 2023 13:06:07 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100007.china.huawei.com (7.185.36.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 17 Aug 2023 13:07:29 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 17 Aug
 2023 13:07:29 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next v2 07/23] spi: pxa2xx: switch to use modern name
Date:   Thu, 17 Aug 2023 13:03:16 +0800
Message-ID: <20230817050332.1274751-8-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230817050332.1274751-1-yangyingliang@huawei.com>
References: <20230817050332.1274751-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Change legacy name master/slave to modern name host/target or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-pxa2xx.c       | 24 ++++++++++++------------
 include/linux/spi/pxa2xx_spi.h |  4 ++--
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 21f156587669..f2a856f6a99e 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1102,7 +1102,7 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *controller,
 		}
 	}
 
-	if (spi_controller_is_slave(controller)) {
+	if (spi_controller_is_target(controller)) {
 		while (drv_data->write(drv_data))
 			;
 		if (drv_data->gpiod_ready) {
@@ -1121,7 +1121,7 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *controller,
 	return 1;
 }
 
-static int pxa2xx_spi_slave_abort(struct spi_controller *controller)
+static int pxa2xx_spi_target_abort(struct spi_controller *controller)
 {
 	struct driver_data *drv_data = spi_controller_get_devdata(controller);
 
@@ -1199,7 +1199,7 @@ static int setup(struct spi_device *spi)
 		break;
 	default:
 		tx_hi_thres = 0;
-		if (spi_controller_is_slave(drv_data->controller)) {
+		if (spi_controller_is_target(drv_data->controller)) {
 			tx_thres = 1;
 			rx_thres = 2;
 		} else {
@@ -1248,7 +1248,7 @@ static int setup(struct spi_device *spi)
 	}
 
 	chip->cr1 = 0;
-	if (spi_controller_is_slave(drv_data->controller)) {
+	if (spi_controller_is_target(drv_data->controller)) {
 		chip->cr1 |= SSCR1_SCFR;
 		chip->cr1 |= SSCR1_SCLKDIR;
 		chip->cr1 |= SSCR1_SFRMDIR;
@@ -1395,7 +1395,7 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	else
 		ssp->port_id = uid;
 
-	pdata->is_slave = device_property_read_bool(dev, "spi-slave");
+	pdata->is_target = device_property_read_bool(dev, "spi-slave");
 	pdata->num_chipselect = 1;
 	pdata->enable_dma = true;
 	pdata->dma_burst_size = 1;
@@ -1461,10 +1461,10 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	if (platform_info->is_slave)
-		controller = devm_spi_alloc_slave(dev, sizeof(*drv_data));
+	if (platform_info->is_target)
+		controller = devm_spi_alloc_target(dev, sizeof(*drv_data));
 	else
-		controller = devm_spi_alloc_master(dev, sizeof(*drv_data));
+		controller = devm_spi_alloc_host(dev, sizeof(*drv_data));
 
 	if (!controller) {
 		dev_err(&pdev->dev, "cannot alloc spi_controller\n");
@@ -1487,7 +1487,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	controller->setup = setup;
 	controller->set_cs = pxa2xx_spi_set_cs;
 	controller->transfer_one = pxa2xx_spi_transfer_one;
-	controller->slave_abort = pxa2xx_spi_slave_abort;
+	controller->target_abort = pxa2xx_spi_target_abort;
 	controller->handle_err = pxa2xx_spi_handle_err;
 	controller->unprepare_transfer_hardware = pxa2xx_spi_unprepare_transfer;
 	controller->fw_translate_cs = pxa2xx_spi_fw_translate_cs;
@@ -1579,7 +1579,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 		break;
 	default:
 
-		if (spi_controller_is_slave(controller)) {
+		if (spi_controller_is_target(controller)) {
 			tmp = SSCR1_SCFR |
 			      SSCR1_SCLKDIR |
 			      SSCR1_SFRMDIR |
@@ -1592,7 +1592,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 		}
 		pxa2xx_spi_write(drv_data, SSCR1, tmp);
 		tmp = SSCR0_Motorola | SSCR0_DataSize(8);
-		if (!spi_controller_is_slave(controller))
+		if (!spi_controller_is_target(controller))
 			tmp |= SSCR0_SCR(2);
 		pxa2xx_spi_write(drv_data, SSCR0, tmp);
 		break;
@@ -1620,7 +1620,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	controller->num_chipselect = platform_info->num_chipselect;
 	controller->use_gpio_descriptors = true;
 
-	if (platform_info->is_slave) {
+	if (platform_info->is_target) {
 		drv_data->gpiod_ready = devm_gpiod_get_optional(dev,
 						"ready", GPIOD_OUT_LOW);
 		if (IS_ERR(drv_data->gpiod_ready)) {
diff --git a/include/linux/spi/pxa2xx_spi.h b/include/linux/spi/pxa2xx_spi.h
index 4658e7801b42..0916cb9bcb0a 100644
--- a/include/linux/spi/pxa2xx_spi.h
+++ b/include/linux/spi/pxa2xx_spi.h
@@ -19,7 +19,7 @@ struct pxa2xx_spi_controller {
 	u16 num_chipselect;
 	u8 enable_dma;
 	u8 dma_burst_size;
-	bool is_slave;
+	bool is_target;
 
 	/* DMA engine specific config */
 	bool (*dma_filter)(struct dma_chan *chan, void *param);
@@ -31,7 +31,7 @@ struct pxa2xx_spi_controller {
 };
 
 /*
- * The controller specific data for SPI slave devices
+ * The controller specific data for SPI target devices
  * (resides in spi_board_info.controller_data),
  * copied to spi_device.platform_data ... mostly for
  * DMA tuning.
-- 
2.25.1

