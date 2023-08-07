Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E90772488
	for <lists+linux-spi@lfdr.de>; Mon,  7 Aug 2023 14:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbjHGMod (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Aug 2023 08:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjHGMo0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Aug 2023 08:44:26 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0211735
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 05:44:15 -0700 (PDT)
Received: from dggpemm100008.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RKGBh0trWztS13;
        Mon,  7 Aug 2023 20:40:44 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100008.china.huawei.com (7.185.36.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 20:44:11 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 20:44:10 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 11/20] spi: gpio: switch to use modern name
Date:   Mon, 7 Aug 2023 20:40:56 +0800
Message-ID: <20230807124105.3429709-12-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230807124105.3429709-1-yangyingliang@huawei.com>
References: <20230807124105.3429709-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
 drivers/spi/spi-gpio.c | 72 +++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 8aa905e407a8..d8db4564b406 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * SPI master driver using generic bitbanged GPIO
+ * SPI host driver using generic bitbanged GPIO
  *
  * Copyright (C) 2006,2008 David Brownell
  * Copyright (C) 2017 Linus Walleij
@@ -17,7 +17,7 @@
 
 
 /*
- * This bitbanging SPI master driver should help make systems usable
+ * This bitbanging SPI host driver should help make systems usable
  * when a native hardware SPI engine is not available, perhaps because
  * its driver isn't yet working or because the I/O pins it requires
  * are used for other purposes.
@@ -26,7 +26,7 @@
  *
  * spi->controller_state ... reserved for bitbang framework code
  *
- * spi->master->dev.driver_data ... points to spi_gpio->bitbang
+ * spi->controller->dev.driver_data ... points to spi_gpio->bitbang
  */
 
 struct spi_gpio {
@@ -77,7 +77,7 @@ spi_to_spi_gpio(const struct spi_device *spi)
 	const struct spi_bitbang	*bang;
 	struct spi_gpio			*spi_gpio;
 
-	bang = spi_master_get_devdata(spi->master);
+	bang = spi_controller_get_devdata(spi->controller);
 	spi_gpio = container_of(bang, struct spi_gpio, bitbang);
 	return spi_gpio;
 }
@@ -180,7 +180,7 @@ static u32 spi_gpio_txrx_word_mode3(struct spi_device *spi,
 static u32 spi_gpio_spec_txrx_word_mode0(struct spi_device *spi,
 		unsigned nsecs, u32 word, u8 bits, unsigned flags)
 {
-	flags = spi->master->flags;
+	flags = spi->controller->flags;
 	if (unlikely(spi->mode & SPI_LSB_FIRST))
 		return bitbang_txrx_le_cpha0(spi, nsecs, 0, flags, word, bits);
 	else
@@ -190,7 +190,7 @@ static u32 spi_gpio_spec_txrx_word_mode0(struct spi_device *spi,
 static u32 spi_gpio_spec_txrx_word_mode1(struct spi_device *spi,
 		unsigned nsecs, u32 word, u8 bits, unsigned flags)
 {
-	flags = spi->master->flags;
+	flags = spi->controller->flags;
 	if (unlikely(spi->mode & SPI_LSB_FIRST))
 		return bitbang_txrx_le_cpha1(spi, nsecs, 0, flags, word, bits);
 	else
@@ -200,7 +200,7 @@ static u32 spi_gpio_spec_txrx_word_mode1(struct spi_device *spi,
 static u32 spi_gpio_spec_txrx_word_mode2(struct spi_device *spi,
 		unsigned nsecs, u32 word, u8 bits, unsigned flags)
 {
-	flags = spi->master->flags;
+	flags = spi->controller->flags;
 	if (unlikely(spi->mode & SPI_LSB_FIRST))
 		return bitbang_txrx_le_cpha0(spi, nsecs, 1, flags, word, bits);
 	else
@@ -210,7 +210,7 @@ static u32 spi_gpio_spec_txrx_word_mode2(struct spi_device *spi,
 static u32 spi_gpio_spec_txrx_word_mode3(struct spi_device *spi,
 		unsigned nsecs, u32 word, u8 bits, unsigned flags)
 {
-	flags = spi->master->flags;
+	flags = spi->controller->flags;
 	if (unlikely(spi->mode & SPI_LSB_FIRST))
 		return bitbang_txrx_le_cpha1(spi, nsecs, 1, flags, word, bits);
 	else
@@ -310,7 +310,7 @@ static void spi_gpio_cleanup(struct spi_device *spi)
  * On platforms which can do so, configure MISO with a weak pullup unless
  * there's an external pullup on that signal.  That saves power by avoiding
  * floating signals.  (A weak pulldown would save power too, but many
- * drivers expect to see all-ones data as the no slave "response".)
+ * drivers expect to see all-ones data as the no target "response".)
  */
 static int spi_gpio_request(struct device *dev, struct spi_gpio *spi_gpio)
 {
@@ -334,27 +334,27 @@ static const struct of_device_id spi_gpio_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, spi_gpio_dt_ids);
 
 static int spi_gpio_probe_dt(struct platform_device *pdev,
-			     struct spi_master *master)
+			     struct spi_controller *host)
 {
-	master->dev.of_node = pdev->dev.of_node;
-	master->use_gpio_descriptors = true;
+	host->dev.of_node = pdev->dev.of_node;
+	host->use_gpio_descriptors = true;
 
 	return 0;
 }
 #else
 static inline int spi_gpio_probe_dt(struct platform_device *pdev,
-				    struct spi_master *master)
+				    struct spi_controller *host)
 {
 	return 0;
 }
 #endif
 
 static int spi_gpio_probe_pdata(struct platform_device *pdev,
-				struct spi_master *master)
+				struct spi_controller *host)
 {
 	struct device *dev = &pdev->dev;
 	struct spi_gpio_platform_data *pdata = dev_get_platdata(dev);
-	struct spi_gpio *spi_gpio = spi_master_get_devdata(master);
+	struct spi_gpio *spi_gpio = spi_controller_get_devdata(host);
 	int i;
 
 #ifdef GENERIC_BITBANG
@@ -362,18 +362,18 @@ static int spi_gpio_probe_pdata(struct platform_device *pdev,
 		return -ENODEV;
 #endif
 	/*
-	 * The master needs to think there is a chipselect even if not
+	 * The host needs to think there is a chipselect even if not
 	 * connected
 	 */
-	master->num_chipselect = pdata->num_chipselect ?: 1;
+	host->num_chipselect = pdata->num_chipselect ?: 1;
 
-	spi_gpio->cs_gpios = devm_kcalloc(dev, master->num_chipselect,
+	spi_gpio->cs_gpios = devm_kcalloc(dev, host->num_chipselect,
 					  sizeof(*spi_gpio->cs_gpios),
 					  GFP_KERNEL);
 	if (!spi_gpio->cs_gpios)
 		return -ENOMEM;
 
-	for (i = 0; i < master->num_chipselect; i++) {
+	for (i = 0; i < host->num_chipselect; i++) {
 		spi_gpio->cs_gpios[i] = devm_gpiod_get_index(dev, "cs", i,
 							     GPIOD_OUT_HIGH);
 		if (IS_ERR(spi_gpio->cs_gpios[i]))
@@ -386,31 +386,31 @@ static int spi_gpio_probe_pdata(struct platform_device *pdev,
 static int spi_gpio_probe(struct platform_device *pdev)
 {
 	int				status;
-	struct spi_master		*master;
+	struct spi_controller		*host;
 	struct spi_gpio			*spi_gpio;
 	struct device			*dev = &pdev->dev;
 	struct spi_bitbang		*bb;
 
-	master = devm_spi_alloc_master(dev, sizeof(*spi_gpio));
-	if (!master)
+	host = devm_spi_alloc_host(dev, sizeof(*spi_gpio));
+	if (!host)
 		return -ENOMEM;
 
 	if (pdev->dev.of_node)
-		status = spi_gpio_probe_dt(pdev, master);
+		status = spi_gpio_probe_dt(pdev, host);
 	else
-		status = spi_gpio_probe_pdata(pdev, master);
+		status = spi_gpio_probe_pdata(pdev, host);
 
 	if (status)
 		return status;
 
-	spi_gpio = spi_master_get_devdata(master);
+	spi_gpio = spi_controller_get_devdata(host);
 
 	status = spi_gpio_request(dev, spi_gpio);
 	if (status)
 		return status;
 
-	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
-	master->mode_bits = SPI_3WIRE | SPI_3WIRE_HIZ | SPI_CPHA | SPI_CPOL |
+	host->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
+	host->mode_bits = SPI_3WIRE | SPI_3WIRE_HIZ | SPI_CPHA | SPI_CPOL |
 			    SPI_CS_HIGH | SPI_LSB_FIRST;
 	if (!spi_gpio->mosi) {
 		/* HW configuration without MOSI pin
@@ -419,25 +419,25 @@ static int spi_gpio_probe(struct platform_device *pdev)
 		 * a MOSI pin connected the host can still do RX by
 		 * changing the direction of the line.
 		 */
-		master->flags = SPI_CONTROLLER_NO_TX;
+		host->flags = SPI_CONTROLLER_NO_TX;
 	}
 
-	master->bus_num = pdev->id;
-	master->setup = spi_gpio_setup;
-	master->cleanup = spi_gpio_cleanup;
+	host->bus_num = pdev->id;
+	host->setup = spi_gpio_setup;
+	host->cleanup = spi_gpio_cleanup;
 
 	bb = &spi_gpio->bitbang;
-	bb->master = master;
+	bb->master = host;
 	/*
 	 * There is some additional business, apart from driving the CS GPIO
 	 * line, that we need to do on selection. This makes the local
 	 * callback for chipselect always get called.
 	 */
-	master->flags |= SPI_CONTROLLER_GPIO_SS;
+	host->flags |= SPI_CONTROLLER_GPIO_SS;
 	bb->chipselect = spi_gpio_chipselect;
 	bb->set_line_direction = spi_gpio_set_direction;
 
-	if (master->flags & SPI_CONTROLLER_NO_TX) {
+	if (host->flags & SPI_CONTROLLER_NO_TX) {
 		bb->txrx_word[SPI_MODE_0] = spi_gpio_spec_txrx_word_mode0;
 		bb->txrx_word[SPI_MODE_1] = spi_gpio_spec_txrx_word_mode1;
 		bb->txrx_word[SPI_MODE_2] = spi_gpio_spec_txrx_word_mode2;
@@ -454,7 +454,7 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	if (status)
 		return status;
 
-	return devm_spi_register_master(&pdev->dev, master);
+	return devm_spi_register_controller(&pdev->dev, host);
 }
 
 MODULE_ALIAS("platform:" DRIVER_NAME);
@@ -468,6 +468,6 @@ static struct platform_driver spi_gpio_driver = {
 };
 module_platform_driver(spi_gpio_driver);
 
-MODULE_DESCRIPTION("SPI master driver using generic bitbanged GPIO ");
+MODULE_DESCRIPTION("SPI host driver using generic bitbanged GPIO ");
 MODULE_AUTHOR("David Brownell");
 MODULE_LICENSE("GPL");
-- 
2.25.1

