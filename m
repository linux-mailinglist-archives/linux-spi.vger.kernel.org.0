Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CABBE39B351
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jun 2021 08:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhFDG5X (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Jun 2021 02:57:23 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:4467 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbhFDG5X (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 4 Jun 2021 02:57:23 -0400
Received: from dggeme758-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FxD3j2nhFzZcjq;
        Fri,  4 Jun 2021 14:52:49 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggeme758-chm.china.huawei.com (10.3.19.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 4 Jun 2021 14:55:35 +0800
From:   Jay Fang <f.fangjian@huawei.com>
To:     <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC:     <huangdaode@huawei.com>
Subject: [PATCH] spi: hisi-kunpeng: Add debugfs support
Date:   Fri, 4 Jun 2021 14:55:18 +0800
Message-ID: <1622789718-13977-1-git-send-email-f.fangjian@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch uses debugfs_regset32 interface to create the registers dump
file. Use it instead of creating a generic debugfs file with manually
written read callback function.

With these entries, users can check all the SPI controller registers
during run time.

Signed-off-by: Jay Fang <f.fangjian@huawei.com>
---
 drivers/spi/spi-hisi-kunpeng.c | 51 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-hisi-kunpeng.c b/drivers/spi/spi-hisi-kunpeng.c
index 3f986ba..58b823a 100644
--- a/drivers/spi/spi-hisi-kunpeng.c
+++ b/drivers/spi/spi-hisi-kunpeng.c
@@ -9,6 +9,7 @@
 
 #include <linux/acpi.h>
 #include <linux/bitfield.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
@@ -126,6 +127,7 @@ struct hisi_spi {
 	void __iomem		*regs;
 	int			irq;
 	u32			fifo_len; /* depth of the FIFO buffer */
+	u16			bus_num;
 
 	/* Current message transfer state info */
 	const void		*tx;
@@ -133,8 +135,49 @@ struct hisi_spi {
 	void			*rx;
 	unsigned int		rx_len;
 	u8			n_bytes; /* current is a 1/2/4 bytes op */
+
+	struct dentry *debugfs;
+	struct debugfs_regset32 regset;
+};
+
+#define HISI_SPI_DBGFS_REG(_name, _off)	\
+{					\
+	.name = _name,			\
+	.offset = _off,			\
+}
+
+static const struct debugfs_reg32 hisi_spi_regs[] = {
+	HISI_SPI_DBGFS_REG("CSCR", HISI_SPI_CSCR),
+	HISI_SPI_DBGFS_REG("CR", HISI_SPI_CR),
+	HISI_SPI_DBGFS_REG("ENR", HISI_SPI_ENR),
+	HISI_SPI_DBGFS_REG("FIFOC", HISI_SPI_FIFOC),
+	HISI_SPI_DBGFS_REG("IMR", HISI_SPI_IMR),
+	HISI_SPI_DBGFS_REG("DIN", HISI_SPI_DIN),
+	HISI_SPI_DBGFS_REG("DOUT", HISI_SPI_DOUT),
+	HISI_SPI_DBGFS_REG("SR", HISI_SPI_SR),
+	HISI_SPI_DBGFS_REG("RISR", HISI_SPI_RISR),
+	HISI_SPI_DBGFS_REG("ISR", HISI_SPI_ISR),
+	HISI_SPI_DBGFS_REG("ICR", HISI_SPI_ICR),
+	HISI_SPI_DBGFS_REG("VERSION", HISI_SPI_VERSION),
 };
 
+static int hisi_spi_debugfs_init(struct hisi_spi *hs)
+{
+	char name[32];
+
+	snprintf(name, 32, "hisi_spi%d", hs->bus_num);
+	hs->debugfs = debugfs_create_dir(name, NULL);
+	if (!hs->debugfs)
+		return -ENOMEM;
+
+	hs->regset.regs = hisi_spi_regs;
+	hs->regset.nregs = ARRAY_SIZE(hisi_spi_regs);
+	hs->regset.base = hs->regs;
+	debugfs_create_regset32("registers", 0400, hs->debugfs, &hs->regset);
+
+	return 0;
+}
+
 static u32 hisi_spi_busy(struct hisi_spi *hs)
 {
 	return readl(hs->regs + HISI_SPI_SR) & SR_BUSY;
@@ -424,6 +467,7 @@ static int hisi_spi_probe(struct platform_device *pdev)
 	hs = spi_controller_get_devdata(master);
 	hs->dev = dev;
 	hs->irq = irq;
+	hs->bus_num = pdev->id;
 
 	hs->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(hs->regs))
@@ -446,7 +490,7 @@ static int hisi_spi_probe(struct platform_device *pdev)
 	master->use_gpio_descriptors = true;
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LOOP;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
-	master->bus_num = pdev->id;
+	master->bus_num = hs->bus_num;
 	master->setup = hisi_spi_setup;
 	master->cleanup = hisi_spi_cleanup;
 	master->transfer_one = hisi_spi_transfer_one;
@@ -462,6 +506,9 @@ static int hisi_spi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	if (hisi_spi_debugfs_init(hs))
+		dev_info(dev, "failed to create debugfs dir\n");
+
 	ret = spi_register_controller(master);
 	if (ret) {
 		dev_err(dev, "failed to register spi master, ret=%d\n", ret);
@@ -478,7 +525,9 @@ static int hisi_spi_probe(struct platform_device *pdev)
 static int hisi_spi_remove(struct platform_device *pdev)
 {
 	struct spi_controller *master = platform_get_drvdata(pdev);
+	struct hisi_spi *hs = spi_controller_get_devdata(master);
 
+	debugfs_remove_recursive(hs->debugfs);
 	spi_unregister_controller(master);
 
 	return 0;
-- 
2.7.4

