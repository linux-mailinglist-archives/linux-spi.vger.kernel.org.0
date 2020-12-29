Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5D92E7537
	for <lists+linux-spi@lfdr.de>; Wed, 30 Dec 2020 00:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgL2XY4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Dec 2020 18:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgL2XY4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 29 Dec 2020 18:24:56 -0500
X-Greylist: delayed 299 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 29 Dec 2020 15:24:16 PST
Received: from yawp.biot.com (yawp.biot.com [IPv6:2a01:4f8:10a:8e::fce2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D24C061799
        for <linux-spi@vger.kernel.org>; Tue, 29 Dec 2020 15:24:16 -0800 (PST)
Received: from debian-spamd by yawp.biot.com with sa-checked (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1kuOGp-00Aceo-R5
        for linux-spi@vger.kernel.org; Wed, 30 Dec 2020 00:19:16 +0100
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on yawp
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.4
Received: from [2a02:578:460c:1:ae1f:6bff:fed1:9ca8] (helo=sumner.biot.com)
        by yawp.biot.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1kuOGg-00Acds-Qy; Wed, 30 Dec 2020 00:19:06 +0100
Received: from bert by sumner.biot.com with local (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1kuOGg-00Ajhq-Be; Wed, 30 Dec 2020 00:19:06 +0100
From:   Bert Vermeulen <bert@biot.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Birger Koblitz <mail@birger-koblitz.de>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bert Vermeulen <bert@biot.com>
Subject: [PATCH RESEND v2 2/2] Add support for Realtek RTL838x/RTL839x SoC SPI controllers
Date:   Wed, 30 Dec 2020 00:19:04 +0100
Message-Id: <20201229231904.2558916-2-bert@biot.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201229231904.2558916-1-bert@biot.com>
References: <20201229231904.2558916-1-bert@biot.com>
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
(resent due to mail trouble)
Notes:
    v2: rewrote from spi-nor driver to regular spi driver, implementing only
        set_cs() and transfer_one() (Thanks Chuanhong Guo!)

 MAINTAINERS               |   6 ++
 drivers/spi/Kconfig       |   7 ++
 drivers/spi/Makefile      |   1 +
 drivers/spi/spi-realtek.c | 215 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 229 insertions(+)
 create mode 100644 drivers/spi/spi-realtek.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ad0e34bf8453..311e5413b1dd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15048,6 +15048,12 @@ F:	Documentation/devicetree/bindings/net/dsa/realtek-smi.txt
 F:	drivers/net/dsa/realtek-smi*
 F:	drivers/net/dsa/rtl83*
 
+REALTEK RTL83XX SPI DRIVER
+M:	Bert Vermeulen <bert@biot.com>
+M:	Birger Koblitz <mail@birger-koblitz.de>
+S:	Maintained
+F:	drivers/spi/spi-realtek.c
+
 REALTEK WIRELESS DRIVER (rtlwifi family)
 M:	Ping-Ke Shih <pkshih@realtek.com>
 L:	linux-wireless@vger.kernel.org
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index aadaea052f51..058ed1b19bc6 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -646,6 +646,13 @@ config SPI_RB4XX
 	help
 	  SPI controller driver for the Mikrotik RB4xx series boards.
 
+config SPI_REALTEK
+	bool "Realtek SPI controller"
+	depends on MACH_REALTEK
+	help
+	  This driver supports the SPI controller used for the bootflash
+	  in the Realtek RTL83xx series SoCs.
+
 config SPI_RPCIF
 	tristate "Renesas RPC-IF SPI driver"
 	depends on RENESAS_RPCIF
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 6fea5821662e..6e9612b70555 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -94,6 +94,7 @@ obj-$(CONFIG_SPI_QCOM_QSPI)		+= spi-qcom-qspi.o
 obj-$(CONFIG_SPI_QUP)			+= spi-qup.o
 obj-$(CONFIG_SPI_ROCKCHIP)		+= spi-rockchip.o
 obj-$(CONFIG_SPI_RB4XX)			+= spi-rb4xx.o
+obj-$(CONFIG_SPI_REALTEK)		+= spi-realtek.o
 obj-$(CONFIG_SPI_RPCIF)			+= spi-rpc-if.o
 obj-$(CONFIG_SPI_RSPI)			+= spi-rspi.o
 obj-$(CONFIG_SPI_S3C24XX)		+= spi-s3c24xx-hw.o
diff --git a/drivers/spi/spi-realtek.c b/drivers/spi/spi-realtek.c
new file mode 100644
index 000000000000..d425d36f022f
--- /dev/null
+++ b/drivers/spi/spi-realtek.c
@@ -0,0 +1,215 @@
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
+#define RTL8380_SPI_SFCR		0x00
+#define RTL8380_SPI_SFCR_RBO		BIT(28)
+#define RTL8380_SPI_SFCR_WBO		BIT(27)
+
+/* SPI Flash Control and Status Register */
+#define RTL8380_SPI_SFCSR		0x08
+#define RTL8380_SPI_SFCSR_CSB0		BIT(31)
+#define RTL8380_SPI_SFCSR_CSB1		BIT(30)
+#define RTL8380_SPI_SFCSR_RDY		BIT(27)
+#define RTL8380_SPI_SFCSR_CS		BIT(24)
+#define RTL8380_SPI_SFCSR_LEN_MASK	~(0x03 << 28)
+#define RTL8380_SPI_SFCSR_LEN1		(0x00 << 28)
+#define RTL8380_SPI_SFCSR_LEN4		(0x03 << 28)
+
+/* SPI Flash Data Registers */
+#define RTL8380_SPI_SFDR		0x0c
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
+	value = readl(REG(RTL8380_SPI_SFCSR));
+	if (active)
+		value |= RTL8380_SPI_SFCSR_CSB0;
+	else
+		value &= ~RTL8380_SPI_SFCSR_CSB0;
+	writel(value, REG(RTL8380_SPI_SFCSR));
+}
+
+static void set_size(struct rtspi *rtspi, int size)
+{
+	u32 value;
+
+	value = readl(REG(RTL8380_SPI_SFCSR));
+	value &= RTL8380_SPI_SFCSR_LEN_MASK;
+	if (size == 4)
+		value |= RTL8380_SPI_SFCSR_LEN4;
+	else if (size == 1)
+		value |= RTL8380_SPI_SFCSR_LEN1;
+	writel(value, REG(RTL8380_SPI_SFCSR));
+}
+
+static inline void wait_ready(struct rtspi *rtspi)
+{
+	while (!(readl(REG(RTL8380_SPI_SFCSR)) & RTL8380_SPI_SFCSR_RDY))
+		;
+}
+static void send4(struct rtspi *rtspi, const u32 *buf)
+{
+	wait_ready(rtspi);
+	set_size(rtspi, 4);
+	writel(*buf, REG(RTL8380_SPI_SFDR));
+}
+
+static void send1(struct rtspi *rtspi, const u8 *buf)
+{
+	wait_ready(rtspi);
+	set_size(rtspi, 1);
+	writel(buf[0] << 24, REG(RTL8380_SPI_SFDR));
+}
+
+static void rcv4(struct rtspi *rtspi, u32 *buf)
+{
+	wait_ready(rtspi);
+	set_size(rtspi, 4);
+	*buf = readl(REG(RTL8380_SPI_SFDR));
+}
+
+static void rcv1(struct rtspi *rtspi, u8 *buf)
+{
+	wait_ready(rtspi);
+	set_size(rtspi, 1);
+	*buf = readl(REG(RTL8380_SPI_SFDR)) >> 24;
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
+	value = readl(REG(RTL8380_SPI_SFCR));
+	value |= RTL8380_SPI_SFCR_RBO | RTL8380_SPI_SFCR_WBO;
+	writel(value, REG(RTL8380_SPI_SFCR));
+
+	value = readl(REG(RTL8380_SPI_SFCSR));
+	/* Permanently disable CS1, since it's never used */
+	value |= RTL8380_SPI_SFCSR_CSB1;
+	/* Select CS0 for use */
+	value &= RTL8380_SPI_SFCSR_CS;
+	writel(value, REG(RTL8380_SPI_SFCSR));
+}
+
+static int realtek_spi_probe(struct platform_device *pdev)
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
+static int realtek_spi_remove(struct platform_device *pdev)
+{
+	struct spi_controller *ctrl = platform_get_drvdata(pdev);
+
+	spi_unregister_controller(ctrl);
+
+	return 0;
+}
+
+
+static const struct of_device_id realtek_spi_of_ids[] = {
+	{ .compatible = "realtek,spi" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, realtek_spi_of_ids);
+
+static struct platform_driver realtek_spi_driver = {
+	.probe = realtek_spi_probe,
+	.remove = realtek_spi_remove,
+	.driver = {
+		.name = "spi-realtek",
+		.of_match_table = realtek_spi_of_ids,
+	},
+};
+
+module_platform_driver(realtek_spi_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Bert Vermeulen <bert@biot.com>");
+MODULE_DESCRIPTION("Realtek SPI driver");
-- 
2.25.1

