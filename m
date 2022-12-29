Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3291C658BDB
	for <lists+linux-spi@lfdr.de>; Thu, 29 Dec 2022 11:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiL2Kma (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 29 Dec 2022 05:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbiL2KmO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 29 Dec 2022 05:42:14 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821081263C
        for <linux-spi@vger.kernel.org>; Thu, 29 Dec 2022 02:42:12 -0800 (PST)
Received: from dggpemm500007.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NjQ0N4hlJz16LtT;
        Thu, 29 Dec 2022 18:40:52 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 29 Dec
 2022 18:41:39 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 2/3] spi: spi-altera-dfl: switch to use modern name
Date:   Thu, 29 Dec 2022 18:38:36 +0800
Message-ID: <20221229103837.4192759-3-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221229103837.4192759-1-yangyingliang@huawei.com>
References: <20221229103837.4192759-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
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
 drivers/spi/spi-altera-dfl.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-altera-dfl.c b/drivers/spi/spi-altera-dfl.c
index 0b3302a29989..5d6e08c12dff 100644
--- a/drivers/spi/spi-altera-dfl.c
+++ b/drivers/spi/spi-altera-dfl.c
@@ -104,20 +104,20 @@ static const struct regmap_config indirect_regbus_cfg = {
 	.reg_read = indirect_bus_reg_read,
 };
 
-static void config_spi_master(void __iomem *base, struct spi_master *master)
+static void config_spi_host(void __iomem *base, struct spi_controller *host)
 {
 	u64 v;
 
 	v = readq(base + SPI_CORE_PARAMETER);
 
-	master->mode_bits = SPI_CS_HIGH;
+	host->mode_bits = SPI_CS_HIGH;
 	if (FIELD_GET(CLK_POLARITY, v))
-		master->mode_bits |= SPI_CPOL;
+		host->mode_bits |= SPI_CPOL;
 	if (FIELD_GET(CLK_PHASE, v))
-		master->mode_bits |= SPI_CPHA;
+		host->mode_bits |= SPI_CPHA;
 
-	master->num_chipselect = FIELD_GET(NUM_CHIPSELECT, v);
-	master->bits_per_word_mask =
+	host->num_chipselect = FIELD_GET(NUM_CHIPSELECT, v);
+	host->bits_per_word_mask =
 		SPI_BPW_RANGE_MASK(1, FIELD_GET(DATA_WIDTH, v));
 }
 
@@ -125,18 +125,18 @@ static int dfl_spi_altera_probe(struct dfl_device *dfl_dev)
 {
 	struct spi_board_info board_info = { 0 };
 	struct device *dev = &dfl_dev->dev;
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct altera_spi *hw;
 	void __iomem *base;
 	int err;
 
-	master = devm_spi_alloc_master(dev, sizeof(struct altera_spi));
-	if (!master)
+	host = devm_spi_alloc_host(dev, sizeof(struct altera_spi));
+	if (!host)
 		return -ENOMEM;
 
-	master->bus_num = -1;
+	host->bus_num = -1;
 
-	hw = spi_master_get_devdata(master);
+	hw = spi_controller_get_devdata(host);
 
 	hw->dev = dev;
 
@@ -145,10 +145,10 @@ static int dfl_spi_altera_probe(struct dfl_device *dfl_dev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	config_spi_master(base, master);
+	config_spi_host(base, host);
 	dev_dbg(dev, "%s cs %u bpm 0x%x mode 0x%x\n", __func__,
-		master->num_chipselect, master->bits_per_word_mask,
-		master->mode_bits);
+		host->num_chipselect, host->bits_per_word_mask,
+		host->mode_bits);
 
 	hw->regmap = devm_regmap_init(dev, NULL, base, &indirect_regbus_cfg);
 	if (IS_ERR(hw->regmap))
@@ -156,11 +156,11 @@ static int dfl_spi_altera_probe(struct dfl_device *dfl_dev)
 
 	hw->irq = -EINVAL;
 
-	altera_spi_init_host(master);
+	altera_spi_init_host(host);
 
-	err = devm_spi_register_master(dev, master);
+	err = devm_spi_register_controller(dev, host);
 	if (err)
-		return dev_err_probe(dev, err, "%s failed to register spi master\n",
+		return dev_err_probe(dev, err, "%s failed to register spi host\n",
 				     __func__);
 
 	if (dfl_dev->revision == FME_FEATURE_REV_MAX10_SPI_N5010)
@@ -172,7 +172,7 @@ static int dfl_spi_altera_probe(struct dfl_device *dfl_dev)
 	board_info.bus_num = 0;
 	board_info.chip_select = 0;
 
-	if (!spi_new_device(master, &board_info)) {
+	if (!spi_new_device(host, &board_info)) {
 		dev_err(dev, "%s failed to create SPI device: %s\n",
 			__func__, board_info.modalias);
 	}
-- 
2.25.1

