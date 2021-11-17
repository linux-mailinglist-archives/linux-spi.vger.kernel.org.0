Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE73B453DAF
	for <lists+linux-spi@lfdr.de>; Wed, 17 Nov 2021 02:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhKQB0h (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Nov 2021 20:26:37 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:14755 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbhKQB0g (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Nov 2021 20:26:36 -0500
Received: from dggeme758-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Hv4rV32zJzZd1J;
        Wed, 17 Nov 2021 09:21:14 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggeme758-chm.china.huawei.com (10.3.19.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Wed, 17 Nov 2021 09:23:37 +0800
From:   Jay Fang <f.fangjian@huawei.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <huangdaode@huawei.com>
Subject: [PATCH] spi: hisi-kunpeng: Fix the debugfs directory name incorrect
Date:   Wed, 17 Nov 2021 09:21:19 +0800
Message-ID: <20211117012119.55558-1-f.fangjian@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: oujiefeng <oujiefeng@huawei.com>

Change the debugfs directory name from hisi_spi65535 to hisi_spi0.

Fixes: 2b2142f247eb ("spi: hisi-kunpeng: Add debugfs support")
Signed-off-by: oujiefeng <oujiefeng@huawei.com>
Signed-off-by: Jay Fang <f.fangjian@huawei.com>
---
 drivers/spi/spi-hisi-kunpeng.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-hisi-kunpeng.c b/drivers/spi/spi-hisi-kunpeng.c
index 58b823a16fc4..525cc0143a30 100644
--- a/drivers/spi/spi-hisi-kunpeng.c
+++ b/drivers/spi/spi-hisi-kunpeng.c
@@ -127,7 +127,6 @@ struct hisi_spi {
 	void __iomem		*regs;
 	int			irq;
 	u32			fifo_len; /* depth of the FIFO buffer */
-	u16			bus_num;
 
 	/* Current message transfer state info */
 	const void		*tx;
@@ -165,7 +164,10 @@ static int hisi_spi_debugfs_init(struct hisi_spi *hs)
 {
 	char name[32];
 
-	snprintf(name, 32, "hisi_spi%d", hs->bus_num);
+	struct spi_controller *master;
+
+	master = container_of(hs->dev, struct spi_controller, dev);
+	snprintf(name, 32, "hisi_spi%d", master->bus_num);
 	hs->debugfs = debugfs_create_dir(name, NULL);
 	if (!hs->debugfs)
 		return -ENOMEM;
@@ -467,7 +469,6 @@ static int hisi_spi_probe(struct platform_device *pdev)
 	hs = spi_controller_get_devdata(master);
 	hs->dev = dev;
 	hs->irq = irq;
-	hs->bus_num = pdev->id;
 
 	hs->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(hs->regs))
@@ -490,7 +491,7 @@ static int hisi_spi_probe(struct platform_device *pdev)
 	master->use_gpio_descriptors = true;
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LOOP;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
-	master->bus_num = hs->bus_num;
+	master->bus_num = pdev->id;
 	master->setup = hisi_spi_setup;
 	master->cleanup = hisi_spi_cleanup;
 	master->transfer_one = hisi_spi_transfer_one;
@@ -506,15 +507,15 @@ static int hisi_spi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (hisi_spi_debugfs_init(hs))
-		dev_info(dev, "failed to create debugfs dir\n");
-
 	ret = spi_register_controller(master);
 	if (ret) {
 		dev_err(dev, "failed to register spi master, ret=%d\n", ret);
 		return ret;
 	}
 
+	if (hisi_spi_debugfs_init(hs))
+		dev_info(dev, "failed to create debugfs dir\n");
+
 	dev_info(dev, "hw version:0x%x max-freq:%u kHz\n",
 		readl(hs->regs + HISI_SPI_VERSION),
 		master->max_speed_hz / 1000);
-- 
2.33.0

