Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFE877DD99
	for <lists+linux-spi@lfdr.de>; Wed, 16 Aug 2023 11:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243456AbjHPJnl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Aug 2023 05:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243459AbjHPJnb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Aug 2023 05:43:31 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB4413E
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 02:43:30 -0700 (PDT)
Received: from dggpemm500013.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RQjlq2ZWVztS3B;
        Wed, 16 Aug 2023 17:39:51 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 16 Aug 2023 17:43:27 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 16 Aug
 2023 17:43:27 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 18/24] spi: sc18is602: switch to use modern name
Date:   Wed, 16 Aug 2023 17:40:07 +0800
Message-ID: <20230816094013.1275068-19-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816094013.1275068-1-yangyingliang@huawei.com>
References: <20230816094013.1275068-1-yangyingliang@huawei.com>
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

Change legacy name master to modern name host or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-sc18is602.c | 50 ++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-sc18is602.c b/drivers/spi/spi-sc18is602.c
index 9f98bf350697..eecf9ea95ae3 100644
--- a/drivers/spi/spi-sc18is602.c
+++ b/drivers/spi/spi-sc18is602.c
@@ -30,7 +30,7 @@ enum chips { sc18is602, sc18is602b, sc18is603 };
 #define SC18IS602_MODE_CLOCK_DIV_128	0x3
 
 struct sc18is602 {
-	struct spi_master	*master;
+	struct spi_controller	*host;
 	struct device		*dev;
 	u8			ctrl;
 	u32			freq;
@@ -179,10 +179,10 @@ static int sc18is602_check_transfer(struct spi_device *spi,
 	return 0;
 }
 
-static int sc18is602_transfer_one(struct spi_master *master,
+static int sc18is602_transfer_one(struct spi_controller *host,
 				  struct spi_message *m)
 {
-	struct sc18is602 *hw = spi_master_get_devdata(master);
+	struct sc18is602 *hw = spi_controller_get_devdata(host);
 	struct spi_device *spi = m->spi;
 	struct spi_transfer *t;
 	int status = 0;
@@ -213,7 +213,7 @@ static int sc18is602_transfer_one(struct spi_master *master,
 		spi_transfer_delay_exec(t);
 	}
 	m->status = status;
-	spi_finalize_current_message(master);
+	spi_finalize_current_message(host);
 
 	return status;
 }
@@ -225,7 +225,7 @@ static size_t sc18is602_max_transfer_size(struct spi_device *spi)
 
 static int sc18is602_setup(struct spi_device *spi)
 {
-	struct sc18is602 *hw = spi_master_get_devdata(spi->master);
+	struct sc18is602 *hw = spi_controller_get_devdata(spi->controller);
 
 	/* SC18IS602 does not support CS2 */
 	if (hw->id == sc18is602 && (spi_get_chipselect(spi, 0) == 2))
@@ -241,17 +241,17 @@ static int sc18is602_probe(struct i2c_client *client)
 	struct device_node *np = dev->of_node;
 	struct sc18is602_platform_data *pdata = dev_get_platdata(dev);
 	struct sc18is602 *hw;
-	struct spi_master *master;
+	struct spi_controller *host;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C |
 				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA))
 		return -EINVAL;
 
-	master = devm_spi_alloc_master(dev, sizeof(struct sc18is602));
-	if (!master)
+	host = devm_spi_alloc_host(dev, sizeof(struct sc18is602));
+	if (!host)
 		return -ENOMEM;
 
-	hw = spi_master_get_devdata(master);
+	hw = spi_controller_get_devdata(host);
 	i2c_set_clientdata(client, hw);
 
 	/* assert reset and then release */
@@ -260,7 +260,7 @@ static int sc18is602_probe(struct i2c_client *client)
 		return PTR_ERR(hw->reset);
 	gpiod_set_value_cansleep(hw->reset, 0);
 
-	hw->master = master;
+	hw->host = host;
 	hw->client = client;
 	hw->dev = dev;
 	hw->ctrl = 0xff;
@@ -273,11 +273,11 @@ static int sc18is602_probe(struct i2c_client *client)
 	switch (hw->id) {
 	case sc18is602:
 	case sc18is602b:
-		master->num_chipselect = 4;
+		host->num_chipselect = 4;
 		hw->freq = SC18IS602_CLOCK;
 		break;
 	case sc18is603:
-		master->num_chipselect = 2;
+		host->num_chipselect = 2;
 		if (pdata) {
 			hw->freq = pdata->clock_frequency;
 		} else {
@@ -292,18 +292,18 @@ static int sc18is602_probe(struct i2c_client *client)
 			hw->freq = SC18IS602_CLOCK;
 		break;
 	}
-	master->bus_num = np ? -1 : client->adapter->nr;
-	master->mode_bits = SPI_CPHA | SPI_CPOL | SPI_LSB_FIRST;
-	master->bits_per_word_mask = SPI_BPW_MASK(8);
-	master->setup = sc18is602_setup;
-	master->transfer_one_message = sc18is602_transfer_one;
-	master->max_transfer_size = sc18is602_max_transfer_size;
-	master->max_message_size = sc18is602_max_transfer_size;
-	master->dev.of_node = np;
-	master->min_speed_hz = hw->freq / 128;
-	master->max_speed_hz = hw->freq / 4;
-
-	return devm_spi_register_master(dev, master);
+	host->bus_num = np ? -1 : client->adapter->nr;
+	host->mode_bits = SPI_CPHA | SPI_CPOL | SPI_LSB_FIRST;
+	host->bits_per_word_mask = SPI_BPW_MASK(8);
+	host->setup = sc18is602_setup;
+	host->transfer_one_message = sc18is602_transfer_one;
+	host->max_transfer_size = sc18is602_max_transfer_size;
+	host->max_message_size = sc18is602_max_transfer_size;
+	host->dev.of_node = np;
+	host->min_speed_hz = hw->freq / 128;
+	host->max_speed_hz = hw->freq / 4;
+
+	return devm_spi_register_controller(dev, host);
 }
 
 static const struct i2c_device_id sc18is602_id[] = {
@@ -342,6 +342,6 @@ static struct i2c_driver sc18is602_driver = {
 
 module_i2c_driver(sc18is602_driver);
 
-MODULE_DESCRIPTION("SC18IS602/603 SPI Master Driver");
+MODULE_DESCRIPTION("SC18IS602/603 SPI Host Driver");
 MODULE_AUTHOR("Guenter Roeck");
 MODULE_LICENSE("GPL");
-- 
2.25.1

