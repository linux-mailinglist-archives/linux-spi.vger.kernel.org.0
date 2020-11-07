Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB17D2AA393
	for <lists+linux-spi@lfdr.de>; Sat,  7 Nov 2020 09:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgKGIPP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Nov 2020 03:15:15 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57208 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727896AbgKGIPP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 Nov 2020 03:15:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604736914; x=1636272914;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SUp3hrIaYTtH1qT6cOT38t7FswfwYA+WqgQCJBqAiMI=;
  b=Jcw7g+e2xvveSaPJKVHxCfFdXx7g21LCawYelaZQEGuuMJ9thnZE3jc9
   +DTB117+CP+B+NtVAglUSkQ9d9TX+fejPJnsO9o5bzYX6cRYD6Ar9z5AV
   LsoTZgswUivcjdgDZSbZbJw96Th3LDzZuB/XjoOyhE8TQEVraTY0t3tJV
   z+p6bAvXSiov2PeID8yJoHbwKVSEnRWSza9+AKfSjuLXg2HlbjCBkjOM9
   hgHc2rl1ScSM6kUWXh0e1VGdCGCMUXpYviv9SVkOGbUskdyzs/daO8SJl
   nCqrDlLwhxjqXwXN8hVg0i08uMH9WjYCYyUiOvmXg/GyYwzgzWYKJN/y1
   Q==;
IronPort-SDR: nV1JUffHd/0CNOb70lA/ZXDtZIJ4NvcYbe0U2gNnsm9BG8KoVVgcRM/PCunxhK+Fke8nBXSsZT
 uP/O+MIvzuVzK1S+cndmcj5HDGQIoLqt3VxMxsb1Dns6JvWhf/ohEEhlY3HD14O6s3HA1UBFz5
 L9BbCGBQU4pywHZiKfVACpauhEMVyWnuQORsRVwmJBzBDq0h27yOFLngO5nsNDryQjr0N860Kr
 C67igXpu+LNaYQnm/RjN7Ee+6hRQxCzQ7MLWwXkFE8XQlPIbgy6ooaq+szd9fjqB/t3N8kRfE7
 uqU=
X-IronPort-AV: E=Sophos;i="5.77,459,1596470400"; 
   d="scan'208";a="156564407"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2020 16:15:14 +0800
IronPort-SDR: 6elAszZyP8FpFDX1xg+oJE18MDif54flIfosvdl6gb2aS7zEe5oXTKo+loDT1QJUWFspKUcFYZ
 QIJ2yr5nQW+1K6Efr42VtHkpCuZm5rTjpBc1oBQe0atd9HYye7t7O/uGPC4xNr6mIMX1Ep1sVm
 L5qt4NwgNrYB+oNTjk2fYBMmRd59zntPGa55mF/ZgpiK0tlExxxSuJKmXxYy9YoC4xIn26Ge5r
 ObYdYmeW/b5XHvhEDPKnepaHN7dLqfRrtlL8/EkDXb7ygDyDkMIttw9QQoo5iP6dfB5qlaeq1r
 mLrSRj16X4HLtxhQu2GXjdLO
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2020 00:00:05 -0800
IronPort-SDR: cq//chzutH4wXylm4H8jmtnMe1aNpH0Uu4Whn6FkmWJy6febas7+Y3rO0Zc90N9BsNIrZx3kH+
 v0gyxR4aAqacsoAftph7QwdLBEw5g7puc3sMfZIwrUqLoOxw+FCfCHSfQn1Y6ZoX5QEeuT0frw
 OqacY0epJSaqMfB0cOwlkjduc04QBxwAUoNYVXLY1GFPqLeBMqRMMO7gLHiiaCKFC0KhcF27cg
 5JWPtHYiThqG/mY+GP6D55fS00eOvc5QNPI5tFFF7HbsnDjggeQvLLge1PS0lf+dd3/VF5MbSA
 e5k=
WDCIronportException: Internal
Received: from hdrdzf2.ad.shared (HELO twashi.fujisawa.hgst.com) ([10.84.71.85])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Nov 2020 00:15:12 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 19/32] riscv: Add Kendryte K210 SoC reset controller
Date:   Sat,  7 Nov 2020 17:14:07 +0900
Message-Id: <20201107081420.60325-20-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201107081420.60325-1-damien.lemoal@wdc.com>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add a reset controller driver for the Kendryte K210 SoC. This driver
relies on its syscon compatible parent node for its register mapping.
Automatically select this driver for compilation when the SOC_KENDRYTE
option is selected.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 arch/riscv/Kconfig.socs    |   3 +
 drivers/reset/Kconfig      |   9 ++
 drivers/reset/Makefile     |   1 +
 drivers/reset/reset-k210.c | 186 +++++++++++++++++++++++++++++++++++++
 4 files changed, 199 insertions(+)
 create mode 100644 drivers/reset/reset-k210.c

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index a4c851ffc6b0..4d8e66d0556a 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -31,6 +31,9 @@ config SOC_KENDRYTE
 	select SIFIVE_PLIC
 	select SOC_K210
 	select CLK_K210
+	select ARCH_HAS_RESET_CONTROLLER
+	select RESET_CONTROLLER
+	select RESET_K210
 	help
 	  This enables support for Kendryte K210 SoC platform hardware.
 
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 07d162b179fc..c943051b5fc8 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -245,6 +245,15 @@ config RESET_ZYNQ
 	help
 	  This enables the reset controller driver for Xilinx Zynq SoCs.
 
+config RESET_K210
+	bool "Reset controller driver for Kendryte K210 SoC"
+	depends on RISCV && SOC_KENDRYTE
+	depends on OF && MFD_SYSCON
+	help
+	  Support for the Kendryte K210 RISC-V SoC reset controller. If
+          Say Y if you want to control reset signals provided by this
+	  controller.
+
 source "drivers/reset/sti/Kconfig"
 source "drivers/reset/hisilicon/Kconfig"
 source "drivers/reset/tegra/Kconfig"
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 16947610cc3b..1730a31e6871 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -33,4 +33,5 @@ obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
 obj-$(CONFIG_RESET_UNIPHIER_GLUE) += reset-uniphier-glue.o
 obj-$(CONFIG_RESET_ZYNQ) += reset-zynq.o
 obj-$(CONFIG_ARCH_ZYNQMP) += reset-zynqmp.o
+obj-$(CONFIG_RESET_K210) += reset-k210.o
 
diff --git a/drivers/reset/reset-k210.c b/drivers/reset/reset-k210.c
new file mode 100644
index 000000000000..b6401aef2923
--- /dev/null
+++ b/drivers/reset/reset-k210.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Western Digital Corporation or its affiliates.
+ */
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+#include <linux/delay.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/mfd/k210-sysctl.h>
+#include <dt-bindings/reset/k210-rst.h>
+
+struct k210_rst {
+	struct regmap *map;
+	u32 offset;
+	u32 mask;
+	u32 assert_high;
+	struct reset_controller_dev rcdev;
+};
+
+static inline struct k210_rst *
+to_k210_rst(struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct k210_rst, rcdev);
+}
+
+static inline int k210_rst_assert(struct reset_controller_dev *rcdev,
+				  unsigned long id)
+{
+	struct k210_rst *ksr = to_k210_rst(rcdev);
+	u32 bit = BIT(id);
+
+	if (!(bit & ksr->mask)) {
+		dev_err(rcdev->dev, "Invalid assert id %lu\n", id);
+		return -EINVAL;
+	}
+
+	dev_dbg(rcdev->dev, "assert %s %lu\n",
+		ksr->assert_high ? "high" : "low", id);
+
+	regmap_update_bits(ksr->map, ksr->offset, bit,
+			   ksr->assert_high ? bit : 0);
+
+	return 0;
+}
+
+static inline int k210_rst_deassert(struct reset_controller_dev *rcdev,
+				    unsigned long id)
+{
+	struct k210_rst *ksr = to_k210_rst(rcdev);
+	u32 bit = BIT(id);
+
+	if (!(bit & ksr->mask)) {
+		dev_err(rcdev->dev, "Invalid deassert id %lu\n", id);
+		return -EINVAL;
+	}
+
+	dev_dbg(rcdev->dev, "deassert %s %lu\n",
+		ksr->assert_high ? "high" : "low", id);
+
+	regmap_update_bits(ksr->map, ksr->offset, bit,
+			   ksr->assert_high ? 0 : bit);
+
+	return 0;
+}
+
+static int k210_rst_reset(struct reset_controller_dev *rcdev,
+			  unsigned long id)
+{
+	struct k210_rst *ksr = to_k210_rst(rcdev);
+	int ret;
+
+	dev_dbg(rcdev->dev, "reset %s %lu\n",
+		ksr->assert_high ? "high" : "low", id);
+
+	ret = k210_rst_assert(rcdev, id);
+	if (ret == 0) {
+		udelay(10);
+		ret = k210_rst_deassert(rcdev, id);
+	}
+
+	return ret;
+}
+
+static int k210_rst_status(struct reset_controller_dev *rcdev,
+			   unsigned long id)
+{
+	struct k210_rst *ksr = to_k210_rst(rcdev);
+	u32 reg, bit = BIT(id);
+	int ret;
+
+	if (!(bit & ksr->mask)) {
+		dev_err(rcdev->dev, "Invalid reset %lx\n", id);
+		return -EINVAL;
+	}
+
+	ret = regmap_read(ksr->map, ksr->offset, &reg);
+	if (ret)
+		return ret;
+
+	if (ksr->assert_high)
+		return ret & bit;
+
+	return !(ret & bit);
+}
+
+static const struct reset_control_ops k210_rst_ops = {
+	.assert		= k210_rst_assert,
+	.deassert	= k210_rst_deassert,
+	.reset		= k210_rst_reset,
+	.status		= k210_rst_status,
+};
+
+static int __init k210_rst_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct k210_rst *ksr;
+	int ret, nr_resets;
+
+	dev_info(dev, "K210 reset controller\n");
+
+	ksr = devm_kzalloc(dev, sizeof(*ksr), GFP_KERNEL);
+	if (!ksr)
+		return -ENOMEM;
+
+	ksr->map = syscon_regmap_lookup_by_phandle(dev->of_node, "regmap");
+	if (IS_ERR(ksr->map)) {
+		ksr->map = syscon_node_to_regmap(dev->parent->of_node);
+		if (IS_ERR(ksr->map)) {
+			dev_err(dev, "get register map failed\n");
+			return PTR_ERR(ksr->map);
+		}
+	}
+
+	ret = of_property_read_u32(dev->of_node, "offset", &ksr->offset);
+	ret = of_property_read_u32(dev->of_node, "assert-high",
+				   &ksr->assert_high);
+	if (ret) {
+		dev_err(dev, "unable to read 'offset' and 'assert-high'\n");
+		return -EINVAL;
+	}
+
+	ret = of_property_read_u32(dev->of_node, "mask", &ksr->mask);
+	if (ret) {
+		/* Use default mask */
+		ksr->mask = 0x27FFFFFF;
+	}
+	nr_resets = fls(ksr->mask);
+	if (!nr_resets) {
+		dev_err(dev, "Invalid mask 0x%08x\n", ksr->mask);
+		return -EINVAL;
+	}
+
+	ksr->rcdev.owner = THIS_MODULE;
+	ksr->rcdev.dev = dev;
+	ksr->rcdev.of_node = dev->of_node;
+	ksr->rcdev.nr_resets = nr_resets;
+	ksr->rcdev.ops = &k210_rst_ops;
+
+	return devm_reset_controller_register(dev, &ksr->rcdev);
+}
+
+static const struct of_device_id k210_rst_dt_ids[] = {
+	{ .compatible = "kendryte,k210-rst" },
+};
+
+static struct platform_driver k210_rst_driver = {
+	.probe	= k210_rst_probe,
+	.driver = {
+		.name		= "k210-rst",
+		.of_match_table	= k210_rst_dt_ids,
+	},
+};
+
+/*
+ * Most devices on the K210 SoC need reset as part of their initialization.
+ * So initialize this driver early as part of the post core initialization.
+ */
+static int __init k210_rst_init(void)
+{
+	return platform_driver_register(&k210_rst_driver);
+}
+postcore_initcall(k210_rst_init);
-- 
2.28.0

