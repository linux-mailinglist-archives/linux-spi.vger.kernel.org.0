Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDD72FDA9C
	for <lists+linux-spi@lfdr.de>; Wed, 20 Jan 2021 21:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732129AbhATUQz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Jan 2021 15:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733262AbhATOA5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Jan 2021 09:00:57 -0500
Received: from yawp.biot.com (yawp.biot.com [IPv6:2a01:4f8:10a:8e::fce2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86D1C061795
        for <linux-spi@vger.kernel.org>; Wed, 20 Jan 2021 05:59:49 -0800 (PST)
Received: from debian-spamd by yawp.biot.com with sa-checked (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1l2E1T-00EO6h-Uj
        for linux-spi@vger.kernel.org; Wed, 20 Jan 2021 14:59:48 +0100
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on yawp
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.4
Received: from [2a02:578:460c:1:ae1f:6bff:fed1:9ca8] (helo=sumner.biot.com)
        by yawp.biot.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1l2E1K-00EO5B-O1; Wed, 20 Jan 2021 14:59:38 +0100
Received: from bert by sumner.biot.com with local (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1l2E1K-00121j-A9; Wed, 20 Jan 2021 14:59:38 +0100
From:   Bert Vermeulen <bert@biot.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Birger Koblitz <mail@birger-koblitz.de>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bert Vermeulen <bert@biot.com>
Subject: [PATCH v5 2/2] spi: realtek-rtl: Add support for Realtek RTL838x/RTL839x SPI controllers
Date:   Wed, 20 Jan 2021 14:59:28 +0100
Message-Id: <20210120135928.246054-3-bert@biot.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210120135928.246054-1-bert@biot.com>
References: <20210120135928.246054-1-bert@biot.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This driver likely also supports earlier (RTL8196) and later (RTL93xx)
SoCs.

The SPI hardware in these SoCs is specifically intended for connecting NOR
bootflash chips, and only used for that in dozens of examined devices.
However boiled down to basics, it's really just a half-duplex SPI
controller.

The hardware appears to have a vestigial second chip-select control, but
it hasn't been seen in the wild and is thus not supported.

Signed-off-by: Bert Vermeulen <bert@biot.com>
---
 drivers/spi/Makefile          |   1 +
 drivers/spi/spi-realtek-rtl.c | 209 ++++++++++++++++++++++++++++++++++
 2 files changed, 210 insertions(+)
 create mode 100644 drivers/spi/spi-realtek-rtl.c

diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 6fea5821662e..182adef17013 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -94,6 +94,7 @@ obj-$(CONFIG_SPI_QCOM_QSPI)		+= spi-qcom-qspi.o
 obj-$(CONFIG_SPI_QUP)			+= spi-qup.o
 obj-$(CONFIG_SPI_ROCKCHIP)		+= spi-rockchip.o
 obj-$(CONFIG_SPI_RB4XX)			+= spi-rb4xx.o
+obj-$(CONFIG_MACH_REALTEK_RTL)		+= spi-realtek-rtl.o
 obj-$(CONFIG_SPI_RPCIF)			+= spi-rpc-if.o
 obj-$(CONFIG_SPI_RSPI)			+= spi-rspi.o
 obj-$(CONFIG_SPI_S3C24XX)		+= spi-s3c24xx-hw.o
diff --git a/drivers/spi/spi-realtek-rtl.c b/drivers/spi/spi-realtek-rtl.c
new file mode 100644
index 000000000000..866b0477dbd7
--- /dev/null
+++ b/drivers/spi/spi-realtek-rtl.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/spi/spi.h>
+
+struct rtspi {
+	void __iomem *base;
+};
+
+/* SPI Flash Configuration Register */
+#define RTL_SPI_SFCR			0x00
+#define RTL_SPI_SFCR_RBO		BIT(28)
+#define RTL_SPI_SFCR_WBO		BIT(27)
+
+/* SPI Flash Control and Status Register */
+#define RTL_SPI_SFCSR			0x08
+#define RTL_SPI_SFCSR_CSB0		BIT(31)
+#define RTL_SPI_SFCSR_CSB1		BIT(30)
+#define RTL_SPI_SFCSR_RDY		BIT(27)
+#define RTL_SPI_SFCSR_CS		BIT(24)
+#define RTL_SPI_SFCSR_LEN_MASK		~(0x03 << 28)
+#define RTL_SPI_SFCSR_LEN1		(0x00 << 28)
+#define RTL_SPI_SFCSR_LEN4		(0x03 << 28)
+
+/* SPI Flash Data Register */
+#define RTL_SPI_SFDR			0x0c
+
+#define REG(x)		(rtspi->base + x)
+
+
+static void rt_set_cs(struct spi_device *spi, bool active)
+{
+	struct rtspi *rtspi = spi_controller_get_devdata(spi->controller);
+	u32 value;
+
+	/* CS0 bit is active low */
+	value = readl(REG(RTL_SPI_SFCSR));
+	if (active)
+		value |= RTL_SPI_SFCSR_CSB0;
+	else
+		value &= ~RTL_SPI_SFCSR_CSB0;
+	writel(value, REG(RTL_SPI_SFCSR));
+}
+
+static void set_size(struct rtspi *rtspi, int size)
+{
+	u32 value;
+
+	value = readl(REG(RTL_SPI_SFCSR));
+	value &= RTL_SPI_SFCSR_LEN_MASK;
+	if (size == 4)
+		value |= RTL_SPI_SFCSR_LEN4;
+	else if (size == 1)
+		value |= RTL_SPI_SFCSR_LEN1;
+	writel(value, REG(RTL_SPI_SFCSR));
+}
+
+static inline void wait_ready(struct rtspi *rtspi)
+{
+	while (!(readl(REG(RTL_SPI_SFCSR)) & RTL_SPI_SFCSR_RDY))
+		cpu_relax();
+}
+static void send4(struct rtspi *rtspi, const u32 *buf)
+{
+	wait_ready(rtspi);
+	set_size(rtspi, 4);
+	writel(*buf, REG(RTL_SPI_SFDR));
+}
+
+static void send1(struct rtspi *rtspi, const u8 *buf)
+{
+	wait_ready(rtspi);
+	set_size(rtspi, 1);
+	writel(buf[0] << 24, REG(RTL_SPI_SFDR));
+}
+
+static void rcv4(struct rtspi *rtspi, u32 *buf)
+{
+	wait_ready(rtspi);
+	set_size(rtspi, 4);
+	*buf = readl(REG(RTL_SPI_SFDR));
+}
+
+static void rcv1(struct rtspi *rtspi, u8 *buf)
+{
+	wait_ready(rtspi);
+	set_size(rtspi, 1);
+	*buf = readl(REG(RTL_SPI_SFDR)) >> 24;
+}
+
+static int transfer_one(struct spi_controller *ctrl, struct spi_device *spi,
+			struct spi_transfer *xfer)
+{
+	struct rtspi *rtspi = spi_controller_get_devdata(ctrl);
+	void *rx_buf;
+	const void *tx_buf;
+	int cnt;
+
+	tx_buf = xfer->tx_buf;
+	rx_buf = xfer->rx_buf;
+	cnt = xfer->len;
+	if (tx_buf) {
+		while (cnt >= 4) {
+			send4(rtspi, tx_buf);
+			tx_buf += 4;
+			cnt -= 4;
+		}
+		while (cnt) {
+			send1(rtspi, tx_buf);
+			tx_buf++;
+			cnt--;
+		}
+	} else if (rx_buf) {
+		while (cnt >= 4) {
+			rcv4(rtspi, rx_buf);
+			rx_buf += 4;
+			cnt -= 4;
+		}
+		while (cnt) {
+			rcv1(rtspi, rx_buf);
+			rx_buf++;
+			cnt--;
+		}
+	}
+
+	spi_finalize_current_transfer(ctrl);
+
+	return 0;
+}
+
+static void init_hw(struct rtspi *rtspi)
+{
+	u32 value;
+
+	/* Turn on big-endian byte ordering */
+	value = readl(REG(RTL_SPI_SFCR));
+	value |= RTL_SPI_SFCR_RBO | RTL_SPI_SFCR_WBO;
+	writel(value, REG(RTL_SPI_SFCR));
+
+	value = readl(REG(RTL_SPI_SFCSR));
+	/* Permanently disable CS1, since it's never used */
+	value |= RTL_SPI_SFCSR_CSB1;
+	/* Select CS0 for use */
+	value &= RTL_SPI_SFCSR_CS;
+	writel(value, REG(RTL_SPI_SFCSR));
+}
+
+static int realtek_rtl_spi_probe(struct platform_device *pdev)
+{
+	struct spi_controller *ctrl;
+	struct rtspi *rtspi;
+	int err;
+
+	ctrl = devm_spi_alloc_master(&pdev->dev, sizeof(*rtspi));
+	if (!ctrl) {
+		dev_err(&pdev->dev, "Error allocating SPI controller\n");
+		return -ENOMEM;
+	}
+	platform_set_drvdata(pdev, ctrl);
+	rtspi = spi_controller_get_devdata(ctrl);
+
+	rtspi->base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
+	if (IS_ERR(rtspi->base)) {
+		dev_err(&pdev->dev, "Could not map SPI register address");
+		return -ENOMEM;
+	}
+
+	init_hw(rtspi);
+
+	ctrl->dev.of_node = pdev->dev.of_node;
+	ctrl->flags = SPI_CONTROLLER_HALF_DUPLEX;
+	ctrl->set_cs = rt_set_cs;
+	ctrl->transfer_one = transfer_one;
+
+	err = devm_spi_register_controller(&pdev->dev, ctrl);
+	if (err) {
+		dev_err(&pdev->dev, "Could not register SPI controller\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+
+static const struct of_device_id realtek_rtl_spi_of_ids[] = {
+	{ .compatible = "realtek,rtl8380-spi" },
+	{ .compatible = "realtek,rtl8382-spi" },
+	{ .compatible = "realtek,rtl8391-spi" },
+	{ .compatible = "realtek,rtl8392-spi" },
+	{ .compatible = "realtek,rtl8393-spi" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, realtek_rtl_spi_of_ids);
+
+static struct platform_driver realtek_rtl_spi_driver = {
+	.probe = realtek_rtl_spi_probe,
+	.driver = {
+		.name = "realtek-rtl-spi",
+		.of_match_table = realtek_rtl_spi_of_ids,
+	},
+};
+
+module_platform_driver(realtek_rtl_spi_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Bert Vermeulen <bert@biot.com>");
+MODULE_DESCRIPTION("Realtek RTL SPI driver");
-- 
2.25.1

