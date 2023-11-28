Return-Path: <linux-spi+bounces-76-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBEF7FB5BD
	for <lists+linux-spi@lfdr.de>; Tue, 28 Nov 2023 10:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8E19B218E6
	for <lists+linux-spi@lfdr.de>; Tue, 28 Nov 2023 09:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0D749F6A;
	Tue, 28 Nov 2023 09:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0731B8
	for <linux-spi@vger.kernel.org>; Tue, 28 Nov 2023 01:26:29 -0800 (PST)
Received: from dggpemm500019.china.huawei.com (unknown [172.30.72.56])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SfcSC1smcz1P8r5;
	Tue, 28 Nov 2023 17:22:51 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500019.china.huawei.com (7.185.36.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 28 Nov 2023 17:26:27 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 Nov
 2023 17:26:27 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <linux-spi@vger.kernel.org>
CC: <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
	<yangyingliang@huawei.com>
Subject: [PATCH -next 22/26] spi: xtensa-xtfpga: switch to use modern name
Date: Tue, 28 Nov 2023 17:30:27 +0800
Message-ID: <20231128093031.3707034-23-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231128093031.3707034-1-yangyingliang@huawei.com>
References: <20231128093031.3707034-1-yangyingliang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected

Change legacy name master to modern name host or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-xtensa-xtfpga.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-xtensa-xtfpga.c b/drivers/spi/spi-xtensa-xtfpga.c
index dbd85d7a1526..3c7721894376 100644
--- a/drivers/spi/spi-xtensa-xtfpga.c
+++ b/drivers/spi/spi-xtensa-xtfpga.c
@@ -53,7 +53,7 @@ static inline void xtfpga_spi_wait_busy(struct xtfpga_spi *xspi)
 static u32 xtfpga_spi_txrx_word(struct spi_device *spi, unsigned nsecs,
 				u32 v, u8 bits, unsigned flags)
 {
-	struct xtfpga_spi *xspi = spi_master_get_devdata(spi->master);
+	struct xtfpga_spi *xspi = spi_controller_get_devdata(spi->controller);
 
 	xspi->data = (xspi->data << bits) | (v & GENMASK(bits - 1, 0));
 	xspi->data_sz += bits;
@@ -71,7 +71,7 @@ static u32 xtfpga_spi_txrx_word(struct spi_device *spi, unsigned nsecs,
 
 static void xtfpga_spi_chipselect(struct spi_device *spi, int is_on)
 {
-	struct xtfpga_spi *xspi = spi_master_get_devdata(spi->master);
+	struct xtfpga_spi *xspi = spi_controller_get_devdata(spi->controller);
 
 	WARN_ON(xspi->data_sz != 0);
 	xspi->data_sz = 0;
@@ -81,19 +81,19 @@ static int xtfpga_spi_probe(struct platform_device *pdev)
 {
 	struct xtfpga_spi *xspi;
 	int ret;
-	struct spi_master *master;
+	struct spi_controller *host;
 
-	master = devm_spi_alloc_master(&pdev->dev, sizeof(struct xtfpga_spi));
-	if (!master)
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(struct xtfpga_spi));
+	if (!host)
 		return -ENOMEM;
 
-	master->flags = SPI_CONTROLLER_NO_RX;
-	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 16);
-	master->bus_num = pdev->dev.id;
-	master->dev.of_node = pdev->dev.of_node;
+	host->flags = SPI_CONTROLLER_NO_RX;
+	host->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 16);
+	host->bus_num = pdev->dev.id;
+	host->dev.of_node = pdev->dev.of_node;
 
-	xspi = spi_master_get_devdata(master);
-	xspi->bitbang.master = master;
+	xspi = spi_controller_get_devdata(host);
+	xspi->bitbang.master = host;
 	xspi->bitbang.chipselect = xtfpga_spi_chipselect;
 	xspi->bitbang.txrx_word[SPI_MODE_0] = xtfpga_spi_txrx_word;
 	xspi->regs = devm_platform_ioremap_resource(pdev, 0);
@@ -113,17 +113,17 @@ static int xtfpga_spi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	platform_set_drvdata(pdev, master);
+	platform_set_drvdata(pdev, host);
 	return 0;
 }
 
 static void xtfpga_spi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct xtfpga_spi *xspi = spi_master_get_devdata(master);
+	struct spi_controller *host = platform_get_drvdata(pdev);
+	struct xtfpga_spi *xspi = spi_controller_get_devdata(host);
 
 	spi_bitbang_stop(&xspi->bitbang);
-	spi_master_put(master);
+	spi_controller_put(host);
 }
 
 MODULE_ALIAS("platform:" XTFPGA_SPI_NAME);
-- 
2.25.1


