Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF327772FA
	for <lists+linux-spi@lfdr.de>; Thu, 10 Aug 2023 10:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbjHJIdO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Aug 2023 04:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbjHJIdM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Aug 2023 04:33:12 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E5BE40
        for <linux-spi@vger.kernel.org>; Thu, 10 Aug 2023 01:33:11 -0700 (PDT)
Received: from dggpemm500012.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RM0WN5WbLzTmWv;
        Thu, 10 Aug 2023 16:31:12 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500012.china.huawei.com (7.185.36.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 16:33:09 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 16:33:08 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 11/21] spi: mt7621: switch to use modern name
Date:   Thu, 10 Aug 2023 16:29:54 +0800
Message-ID: <20230810083004.3988597-12-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230810083004.3988597-1-yangyingliang@huawei.com>
References: <20230810083004.3988597-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

Change legacy name master/slave to modern name host/target or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-mt7621.c | 70 ++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/spi/spi-mt7621.c b/drivers/spi/spi-mt7621.c
index 91600e5c22e4..099d5e119f0a 100644
--- a/drivers/spi/spi-mt7621.c
+++ b/drivers/spi/spi-mt7621.c
@@ -37,12 +37,12 @@
 #define SPI_CTL_TX_RX_CNT_MASK	0xff
 #define SPI_CTL_START		BIT(8)
 
-#define MT7621_SPI_MASTER	0x28
-#define MASTER_MORE_BUFMODE	BIT(2)
-#define MASTER_FULL_DUPLEX	BIT(10)
-#define MASTER_RS_CLK_SEL	GENMASK(27, 16)
-#define MASTER_RS_CLK_SEL_SHIFT	16
-#define MASTER_RS_SLAVE_SEL	GENMASK(31, 29)
+#define MT7621_SPI_HOST	0x28
+#define HOST_MORE_BUFMODE	BIT(2)
+#define HOST_FULL_DUPLEX	BIT(10)
+#define HOST_RS_CLK_SEL	GENMASK(27, 16)
+#define HOST_RS_CLK_SEL_SHIFT	16
+#define HOST_RS_TARGET_SEL	GENMASK(31, 29)
 
 #define MT7621_SPI_MOREBUF	0x2c
 #define MT7621_SPI_POLAR	0x38
@@ -53,7 +53,7 @@
 #define MT7621_LSB_FIRST	BIT(3)
 
 struct mt7621_spi {
-	struct spi_controller	*master;
+	struct spi_controller	*host;
 	void __iomem		*base;
 	unsigned int		sys_freq;
 	unsigned int		speed;
@@ -62,7 +62,7 @@ struct mt7621_spi {
 
 static inline struct mt7621_spi *spidev_to_mt7621_spi(struct spi_device *spi)
 {
-	return spi_controller_get_devdata(spi->master);
+	return spi_controller_get_devdata(spi->controller);
 }
 
 static inline u32 mt7621_spi_read(struct mt7621_spi *rs, u32 reg)
@@ -80,17 +80,17 @@ static void mt7621_spi_set_cs(struct spi_device *spi, int enable)
 	struct mt7621_spi *rs = spidev_to_mt7621_spi(spi);
 	int cs = spi_get_chipselect(spi, 0);
 	u32 polar = 0;
-	u32 master;
+	u32 host;
 
 	/*
 	 * Select SPI device 7, enable "more buffer mode" and disable
 	 * full-duplex (only half-duplex really works on this chip
 	 * reliably)
 	 */
-	master = mt7621_spi_read(rs, MT7621_SPI_MASTER);
-	master |= MASTER_RS_SLAVE_SEL | MASTER_MORE_BUFMODE;
-	master &= ~MASTER_FULL_DUPLEX;
-	mt7621_spi_write(rs, MT7621_SPI_MASTER, master);
+	host = mt7621_spi_read(rs, MT7621_SPI_HOST);
+	host |= HOST_RS_TARGET_SEL | HOST_MORE_BUFMODE;
+	host &= ~HOST_FULL_DUPLEX;
+	mt7621_spi_write(rs, MT7621_SPI_HOST, host);
 
 	rs->pending_write = 0;
 
@@ -116,9 +116,9 @@ static int mt7621_spi_prepare(struct spi_device *spi, unsigned int speed)
 	if (rate < 2)
 		rate = 2;
 
-	reg = mt7621_spi_read(rs, MT7621_SPI_MASTER);
-	reg &= ~MASTER_RS_CLK_SEL;
-	reg |= (rate - 2) << MASTER_RS_CLK_SEL_SHIFT;
+	reg = mt7621_spi_read(rs, MT7621_SPI_HOST);
+	reg &= ~HOST_RS_CLK_SEL;
+	reg |= (rate - 2) << HOST_RS_CLK_SEL_SHIFT;
 	rs->speed = speed;
 
 	reg &= ~MT7621_LSB_FIRST;
@@ -132,7 +132,7 @@ static int mt7621_spi_prepare(struct spi_device *spi, unsigned int speed)
 	 */
 	reg &= ~(MT7621_CPHA | MT7621_CPOL);
 
-	mt7621_spi_write(rs, MT7621_SPI_MASTER, reg);
+	mt7621_spi_write(rs, MT7621_SPI_HOST, reg);
 
 	return 0;
 }
@@ -245,10 +245,10 @@ static void mt7621_spi_write_half_duplex(struct mt7621_spi *rs,
 	rs->pending_write = len;
 }
 
-static int mt7621_spi_transfer_one_message(struct spi_controller *master,
+static int mt7621_spi_transfer_one_message(struct spi_controller *host,
 					   struct spi_message *m)
 {
-	struct mt7621_spi *rs = spi_controller_get_devdata(master);
+	struct mt7621_spi *rs = spi_controller_get_devdata(host);
 	struct spi_device *spi = m->spi;
 	unsigned int speed = spi->max_speed_hz;
 	struct spi_transfer *t = NULL;
@@ -294,7 +294,7 @@ static int mt7621_spi_transfer_one_message(struct spi_controller *master,
 
 msg_done:
 	m->status = status;
-	spi_finalize_current_message(master);
+	spi_finalize_current_message(host);
 
 	return 0;
 }
@@ -325,7 +325,7 @@ MODULE_DEVICE_TABLE(of, mt7621_spi_match);
 static int mt7621_spi_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
-	struct spi_controller *master;
+	struct spi_controller *host;
 	struct mt7621_spi *rs;
 	void __iomem *base;
 	struct clk *clk;
@@ -344,25 +344,25 @@ static int mt7621_spi_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(clk),
 				     "unable to get SYS clock\n");
 
-	master = devm_spi_alloc_master(&pdev->dev, sizeof(*rs));
-	if (!master) {
-		dev_info(&pdev->dev, "master allocation failed\n");
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(*rs));
+	if (!host) {
+		dev_info(&pdev->dev, "host allocation failed\n");
 		return -ENOMEM;
 	}
 
-	master->mode_bits = SPI_LSB_FIRST;
-	master->flags = SPI_CONTROLLER_HALF_DUPLEX;
-	master->setup = mt7621_spi_setup;
-	master->transfer_one_message = mt7621_spi_transfer_one_message;
-	master->bits_per_word_mask = SPI_BPW_MASK(8);
-	master->dev.of_node = pdev->dev.of_node;
-	master->num_chipselect = 2;
+	host->mode_bits = SPI_LSB_FIRST;
+	host->flags = SPI_CONTROLLER_HALF_DUPLEX;
+	host->setup = mt7621_spi_setup;
+	host->transfer_one_message = mt7621_spi_transfer_one_message;
+	host->bits_per_word_mask = SPI_BPW_MASK(8);
+	host->dev.of_node = pdev->dev.of_node;
+	host->num_chipselect = 2;
 
-	dev_set_drvdata(&pdev->dev, master);
+	dev_set_drvdata(&pdev->dev, host);
 
-	rs = spi_controller_get_devdata(master);
+	rs = spi_controller_get_devdata(host);
 	rs->base = base;
-	rs->master = master;
+	rs->host = host;
 	rs->sys_freq = clk_get_rate(clk);
 	rs->pending_write = 0;
 	dev_info(&pdev->dev, "sys_freq: %u\n", rs->sys_freq);
@@ -373,7 +373,7 @@ static int mt7621_spi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	return devm_spi_register_controller(&pdev->dev, master);
+	return devm_spi_register_controller(&pdev->dev, host);
 }
 
 MODULE_ALIAS("platform:" DRIVER_NAME);
-- 
2.25.1

