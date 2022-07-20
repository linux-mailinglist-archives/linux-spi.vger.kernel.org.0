Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D977F57BF0C
	for <lists+linux-spi@lfdr.de>; Wed, 20 Jul 2022 22:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiGTULT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Jul 2022 16:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiGTULR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Jul 2022 16:11:17 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D9D47BBE;
        Wed, 20 Jul 2022 13:11:16 -0700 (PDT)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26KGu8Ul006095;
        Wed, 20 Jul 2022 20:10:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pps0720;
 bh=3N0i72YYWAPBQUk8voQ6gwqm/0/jRTpLeRVSmcfEKpg=;
 b=Ardy5J+mAekODCiRwnby3CABKqKf+7P7hCq970OsbalW1lGvT9zyVnAIz3HWTMd8vleH
 umc3353meUHIRlAJOTu5cWQLHDIZ4t97vqj0iKhBtABmCp/F3ybMAM9t/YGgLQi80vfm
 91B62LjYuYIIHOvgI0q/MPbtnx78JBZDGkndO1jMf9eyh+p+anoIn0k4wFag3CZ61b6h
 iIcR9Cc+YBQhptu26Dmd+ahLVE9vO19tULw8WUW+rEw7TC8xXx1g81+h1o6MEeHjuLFX
 pLtyfXqAjNGjVARbm2i8oa12iTwEo24Fz+q5wSx74e0RPauBs23kgT2LC+tTDl46uMxi jw== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3hejq2ucba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 20:10:49 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 7B21A8001A0;
        Wed, 20 Jul 2022 20:10:48 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id E676B808C08;
        Wed, 20 Jul 2022 20:10:47 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     nick.hawkins@hpe.com
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, verdun@hpe.com,
        linux@armlinux.org.uk, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de, joel@jms.id.au
Subject: [PATCH v1 1/5] spi: spi-gxp: Add support for HPE GXP SoCs
Date:   Wed, 20 Jul 2022 15:11:54 -0500
Message-Id: <20220720201158.78068-2-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220720201158.78068-1-nick.hawkins@hpe.com>
References: <20220720201158.78068-1-nick.hawkins@hpe.com>
X-Proofpoint-ORIG-GUID: 858ViOqnmaYq9Ru3mDQTIviFLB9Xv0bD
X-Proofpoint-GUID: 858ViOqnmaYq9Ru3mDQTIviFLB9Xv0bD
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_12,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 bulkscore=0 spamscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200081
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

The GXP supports 3 separate SPI interfaces to accommodate the system
flash, core flash, and other functions. The SPI engine supports variable
clock frequency, selectable 3-byte or 4-byte addressing and a
configurable x1, x2, and x4 command/address/data modes. The memory
buffer for reading and writing ranges between 256 bytes and 8KB. This
driver supports access to the core flash and bios part.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
---
 drivers/spi/Kconfig   |   7 +
 drivers/spi/Makefile  |   1 +
 drivers/spi/spi-gxp.c | 355 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 363 insertions(+)
 create mode 100644 drivers/spi/spi-gxp.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 3b1044ebc400..543e4a5b5ffa 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -371,6 +371,13 @@ config SPI_FSL_QUADSPI
 	  This controller does not support generic SPI messages. It only
 	  supports the high-level SPI memory interface.
 
+config SPI_GXP
+	tristate "GXP SPI driver"
+	depends on ARCH_HPE || COMPILE_TEST
+	help
+	 This enables support for the driver for GXP bus attached SPI
+	 controllers.
+
 config SPI_HISI_KUNPENG
 	tristate "HiSilicon SPI Controller for Kunpeng SoCs"
 	depends on (ARM64 && ACPI) || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 0f44eb6083a5..ca5f204017ee 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -57,6 +57,7 @@ obj-$(CONFIG_SPI_FSL_LPSPI)		+= spi-fsl-lpspi.o
 obj-$(CONFIG_SPI_FSL_QUADSPI)		+= spi-fsl-qspi.o
 obj-$(CONFIG_SPI_FSL_SPI)		+= spi-fsl-spi.o
 obj-$(CONFIG_SPI_GPIO)			+= spi-gpio.o
+obj-$(CONFIG_SPI_GXP)			+= spi-gxp.o
 obj-$(CONFIG_SPI_HISI_KUNPENG)		+= spi-hisi-kunpeng.o
 obj-$(CONFIG_SPI_HISI_SFC_V3XX)		+= spi-hisi-sfc-v3xx.o
 obj-$(CONFIG_SPI_IMG_SPFI)		+= spi-img-spfi.o
diff --git a/drivers/spi/spi-gxp.c b/drivers/spi/spi-gxp.c
new file mode 100644
index 000000000000..85e800718d8a
--- /dev/null
+++ b/drivers/spi/spi-gxp.c
@@ -0,0 +1,355 @@
+// SPDX-License-Identifier: GPL-2.0=or-later
+/* Copyright (C) 2022 Hewlett-Packard Development Company, L.P. */
+
+#include <linux/iopoll.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi-mem.h>
+
+#define GXP_SPI0_MAX_CHIPSELECT		2
+#define GXP_SPI_SLEEP_TIME 1
+#define GXP_SPI_TIMEOUT (130 * 1000000 / GXP_SPI_SLEEP_TIME)
+
+#define MANUAL_MODE		0
+#define DIRECT_MODE		1
+#define SPILDAT_LEN		256
+
+#define OFFSET_SPIMCFG		0x0
+#define OFFSET_SPIMCTRL		0x4
+#define OFFSET_SPICMD		0x5
+#define OFFSET_SPIDCNT		0x6
+#define OFFSET_SPIADDR		0x8
+#define OFFSET_SPIINTSTS	0xc
+
+#define SPIMCTRL_START		0x01
+#define SPIMCTRL_BUSY		0x02
+#define SPIMCTRL_DIR		0x08
+
+struct gxp_spi;
+
+struct gxp_spi_chip {
+	struct gxp_spi *spifi;
+	u32 cs;
+};
+
+struct gxp_spi_data {
+	u32 max_cs;
+	u32 mode_bits;
+};
+
+struct gxp_spi {
+	const struct gxp_spi_data *data;
+	void __iomem *reg_base;
+	void __iomem *dat_base;
+	void __iomem *dir_base;
+	struct device *dev;
+	struct gxp_spi_chip chips[GXP_SPI0_MAX_CHIPSELECT];
+};
+
+static void gxp_spi_set_mode(struct gxp_spi *spifi, int mode)
+{
+	u8 value;
+	void __iomem *reg_base = spifi->reg_base;
+
+	value = readb(reg_base + OFFSET_SPIMCTRL);
+
+	if (mode == MANUAL_MODE) {
+		writeb(0x55, reg_base + OFFSET_SPICMD);
+		writeb(0xaa, reg_base + OFFSET_SPICMD);
+		value &= ~0x30;
+	} else {
+		value |= 0x30;
+	}
+	writeb(value, reg_base + OFFSET_SPIMCTRL);
+}
+
+static int gxp_spi_read_reg(struct gxp_spi_chip *chip, const struct spi_mem_op *op)
+{
+	int ret = 0;
+	struct gxp_spi *spifi = chip->spifi;
+	void __iomem *reg_base = spifi->reg_base;
+	u32 value;
+	int cs;
+
+	cs = chip->cs;
+
+	value = readl(reg_base + OFFSET_SPIMCFG);
+	value &= ~(1 << 24);
+	value |= (cs << 24);
+	value &= ~(0x07 << 16);
+	value &= ~(0x1f << 19);
+	writel(value, reg_base + OFFSET_SPIMCFG);
+
+	writel(0, reg_base + OFFSET_SPIADDR);
+
+	writeb(op->cmd.opcode, reg_base + OFFSET_SPICMD);
+
+	writew(op->data.nbytes, reg_base + OFFSET_SPIDCNT);
+
+	value = readb(reg_base + OFFSET_SPIMCTRL);
+	value &= ~SPIMCTRL_DIR;
+	value |= SPIMCTRL_START;
+
+	writeb(value, reg_base + OFFSET_SPIMCTRL);
+
+	ret = readb_poll_timeout(reg_base + OFFSET_SPIMCTRL, value,
+				 !(value & SPIMCTRL_BUSY),
+				 GXP_SPI_SLEEP_TIME, GXP_SPI_TIMEOUT);
+	if (ret) {
+		dev_warn(spifi->dev, "read reg busy time out\n");
+		return ret;
+	}
+
+	memcpy_fromio(op->data.buf.in, spifi->dat_base, op->data.nbytes);
+	return ret;
+}
+
+static int gxp_spi_write_reg(struct gxp_spi_chip *chip, const struct spi_mem_op *op)
+{
+	int ret = 0;
+	struct gxp_spi *spifi = chip->spifi;
+	void __iomem *reg_base = spifi->reg_base;
+	u32 value;
+	int cs;
+
+	cs = chip->cs;
+
+	value = readl(reg_base + OFFSET_SPIMCFG);
+	value &= ~(1 << 24);
+	value |= (cs << 24);
+	value &= ~(0x07 << 16);
+	value &= ~(0x1f << 19);
+	writel(value, reg_base + OFFSET_SPIMCFG);
+
+	writel(0, reg_base + OFFSET_SPIADDR);
+
+	writeb(op->cmd.opcode, reg_base + OFFSET_SPICMD);
+
+	memcpy_toio(spifi->dat_base, op->data.buf.in, op->data.nbytes);
+
+	writew(op->data.nbytes, reg_base + OFFSET_SPIDCNT);
+
+	value = readb(reg_base + OFFSET_SPIMCTRL);
+	value |= SPIMCTRL_DIR;
+	value |= SPIMCTRL_START;
+
+	writeb(value, reg_base + OFFSET_SPIMCTRL);
+
+	ret = readb_poll_timeout(reg_base + OFFSET_SPIMCTRL, value,
+				 !(value & SPIMCTRL_BUSY),
+				 GXP_SPI_SLEEP_TIME, GXP_SPI_TIMEOUT);
+	if (ret)
+		dev_warn(spifi->dev, "write reg busy time out\n");
+
+	return ret;
+}
+
+static ssize_t gxp_spi_read(struct gxp_spi_chip *chip, const struct spi_mem_op *op)
+{
+	int cs;
+	struct gxp_spi *spifi = chip->spifi;
+	u32 offset = op->addr.val;
+
+	cs = chip->cs;
+
+	if (cs == 0)
+		offset += 0x4000000;
+
+	memcpy_fromio(op->data.buf.in, spifi->dir_base + offset, op->data.nbytes);
+
+	return 0;
+}
+
+static ssize_t gxp_spi_write(struct gxp_spi_chip *chip, const struct spi_mem_op *op)
+{
+	struct gxp_spi *spifi = chip->spifi;
+	void __iomem *reg_base = spifi->reg_base;
+	u32 write_len;
+	u32 value;
+	int cs;
+	int ret = 0;
+
+	cs = chip->cs;
+
+	write_len = op->data.nbytes;
+	if (write_len > SPILDAT_LEN)
+		write_len = SPILDAT_LEN;
+
+	value = readl(reg_base + OFFSET_SPIMCFG);
+	value &= ~(1 << 24);
+	value |= (cs << 24);
+	value &= ~(0x07 << 16);
+	value |= (op->addr.nbytes << 16);
+	value &= ~(0x1f << 19);
+	writel(value, reg_base + OFFSET_SPIMCFG);
+
+	writel(op->addr.val, reg_base + OFFSET_SPIADDR);
+
+	writeb(op->cmd.opcode, reg_base + OFFSET_SPICMD);
+
+	writew(write_len, reg_base + OFFSET_SPIDCNT);
+
+	memcpy_toio(spifi->dat_base, op->data.buf.in, write_len);
+
+	value = readb(reg_base + OFFSET_SPIMCTRL);
+	value |= SPIMCTRL_DIR;
+	value |= SPIMCTRL_START;
+
+	writeb(value, reg_base + OFFSET_SPIMCTRL);
+
+	ret = readb_poll_timeout(reg_base + OFFSET_SPIMCTRL, value,
+				 !(value & SPIMCTRL_BUSY),
+				 GXP_SPI_SLEEP_TIME, GXP_SPI_TIMEOUT);
+	if (ret) {
+		dev_warn(spifi->dev, "write busy time out\n");
+		return ret;
+	}
+
+	return write_len;
+}
+
+static int do_gxp_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
+{
+	struct gxp_spi *spifi = spi_controller_get_devdata(mem->spi->master);
+	struct gxp_spi_chip *chip = &spifi->chips[mem->spi->chip_select];
+
+	int ret = 0;
+
+	if (op->data.dir == SPI_MEM_DATA_IN) {
+		if (!op->addr.nbytes)
+			ret = gxp_spi_read_reg(chip, op);
+		else
+			ret = gxp_spi_read(chip, op);
+	} else {
+		if (!op->addr.nbytes)
+			ret = gxp_spi_write_reg(chip, op);
+		else
+			ret = gxp_spi_write(chip, op);
+	}
+
+	return ret;
+}
+
+static int gxp_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
+{
+	int ret;
+
+	ret = do_gxp_exec_mem_op(mem, op);
+	if (ret)
+		dev_err(&mem->spi->dev, "operation failed: %d", ret);
+
+	return ret;
+}
+
+static const struct spi_controller_mem_ops gxp_spi_mem_ops = {
+	.exec_op = gxp_exec_mem_op,
+};
+
+static int gxp_spi_setup(struct spi_device *spi)
+{
+	struct gxp_spi *spifi = spi_controller_get_devdata(spi->master);
+	unsigned int cs = spi->chip_select;
+	struct gxp_spi_chip *chip = &spifi->chips[cs];
+
+	chip->spifi = spifi;
+	chip->cs = cs;
+
+	gxp_spi_set_mode(spifi, MANUAL_MODE);
+
+	return 0;
+}
+
+static int gxp_spifi_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct gxp_spi_data *data;
+	struct spi_controller *ctlr;
+	struct gxp_spi *spifi;
+	struct resource *res;
+	int ret;
+
+	data = of_device_get_match_data(&pdev->dev);
+	if (!data) {
+		dev_err(&pdev->dev, "of_dev_get_match_data failed\n");
+		return -ENOMEM;
+	}
+
+	ctlr = devm_spi_alloc_master(dev, sizeof(*spifi));
+	if (!ctlr) {
+		dev_err(&pdev->dev, "spi_alloc_master failed\n");
+		return -ENOMEM;
+	}
+
+	spifi = spi_controller_get_devdata(ctlr);
+	if (!spifi) {
+		dev_err(&pdev->dev, "spi_controller_get_data failed\n");
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(pdev, spifi);
+	spifi->data = data;
+	spifi->dev = dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	spifi->reg_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(spifi->reg_base))
+		return PTR_ERR(spifi->reg_base);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	spifi->dat_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(spifi->dat_base))
+		return PTR_ERR(spifi->dat_base);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+	spifi->dir_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(spifi->dir_base))
+		return PTR_ERR(spifi->dir_base);
+
+	ctlr->mode_bits = data->mode_bits;
+	ctlr->bus_num = pdev->id;
+	ctlr->mem_ops = &gxp_spi_mem_ops;
+	ctlr->setup = gxp_spi_setup;
+	ctlr->num_chipselect = data->max_cs;
+	ctlr->dev.of_node = dev->of_node;
+
+	ret = devm_spi_register_controller(dev, ctlr);
+	if (ret) {
+		dev_err(&pdev->dev, "spi_register_controller failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int gxp_spifi_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static const struct gxp_spi_data gxp_spifi_data = {
+	.max_cs	= 2,
+	.mode_bits = 0,
+};
+
+static const struct of_device_id gxp_spifi_match[] = {
+	{.compatible = "hpe,gxp-spifi", .data = &gxp_spifi_data },
+	{ /* null */ }
+};
+MODULE_DEVICE_TABLE(of, gxp_spifi_match);
+
+static struct platform_driver gxp_spifi_driver = {
+	.probe = gxp_spifi_probe,
+	.remove = gxp_spifi_remove,
+	.driver = {
+		.name = "gxp-spifi",
+		.of_match_table = gxp_spifi_match,
+	},
+};
+module_platform_driver(gxp_spifi_driver);
+
+MODULE_DESCRIPTION("HPE GXP SPI Flash Interface driver");
+MODULE_AUTHOR("Nick Hawkins <nick.hawkins@hpe.com>");
+MODULE_LICENSE("GPL");
-- 
2.17.1

