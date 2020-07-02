Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248412120BD
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jul 2020 12:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbgGBKO3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Jul 2020 06:14:29 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:55396 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728386AbgGBKO0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 2 Jul 2020 06:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1593684866; x=1625220866;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iPE5gEvbzPv714t49rjzo5uuNCL/Z830NpCtgF5Y0Vk=;
  b=KfANyhUPZkkV0Pnz7CIlusbmV57SVn7I07tV8KZo3LVttK4PGknqLmxh
   UAHQBXULD/vWehaJuZWwx/lRNXCnmKagOUqWzO3rRsl3aR0dIE5rfcXtv
   v3y1LpFL6iRQI+OGQt5jrlT77MuHBOaEUV/E0HkgC5PfmyNzipF3aqpqk
   tkuKAv9Fnz6ntjr4wj10B1WHPFyQ11h1AuotydhIKBq4zu3Rv8JQUmi8j
   cyS0wosZjAz46MHwCRqWXg+CZ1HCj23+fz+8RioT5a1zqnTrW8OGXZQLx
   LGmn7X0N21v9Rusoxc9sP3e6wmiUEgww3ohw2RuEZbXZBXqlSQxZbn+Ne
   A==;
IronPort-SDR: kuiPHNzBGqDhZofOtv5X5EisqPYVQadNGxuClk6vTdO/3rA+A5zdPgW2JGVei++na7Toal7Cm2
 gLn8X/1tdIk7hdKoeZ1jq17NVM1XvlTNA8M6xXXu6AF8b/njzPcJOwE10bXd1kSwCZpUtha/GM
 RfvCyk645cFwZcPjam5PSA48a7Os0R02HNE01oosgczEotItuq/BT/mljditAnrNi/udTrxH87
 MffuoSst67BaVFTboq+g5uC27mPwQ2qnTlvJBcGCTXcYlvrIEZRAMB2NACS9BF/8shY4oKklhp
 slk=
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="85979752"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Jul 2020 03:14:24 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 2 Jul 2020 03:14:24 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 2 Jul 2020 03:14:02 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: [PATCH v3 4/8] mux: sparx5: Add Sparx5 SPI mux driver
Date:   Thu, 2 Jul 2020 12:13:27 +0200
Message-ID: <20200702101331.26375-5-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702101331.26375-1-lars.povlsen@microchip.com>
References: <20200702101331.26375-1-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The Sparx5 mux driver may be used to control selecting between two
alternate SPI bus segments connected to the SPI controller
(spi-dw-mmio).

Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 drivers/mux/Makefile     |   2 +
 drivers/mux/sparx5-spi.c | 138 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 140 insertions(+)
 create mode 100644 drivers/mux/sparx5-spi.c

diff --git a/drivers/mux/Makefile b/drivers/mux/Makefile
index 6e9fa47daf566..18c3ae3582ece 100644
--- a/drivers/mux/Makefile
+++ b/drivers/mux/Makefile
@@ -8,9 +8,11 @@ mux-adg792a-objs		:= adg792a.o
 mux-adgs1408-objs		:= adgs1408.o
 mux-gpio-objs			:= gpio.o
 mux-mmio-objs			:= mmio.o
+mux-sparx5-objs			:= sparx5-spi.o
 
 obj-$(CONFIG_MULTIPLEXER)	+= mux-core.o
 obj-$(CONFIG_MUX_ADG792A)	+= mux-adg792a.o
 obj-$(CONFIG_MUX_ADGS1408)	+= mux-adgs1408.o
 obj-$(CONFIG_MUX_GPIO)		+= mux-gpio.o
 obj-$(CONFIG_MUX_MMIO)		+= mux-mmio.o
+obj-$(CONFIG_SPI_DW_MMIO)	+= mux-sparx5.o
diff --git a/drivers/mux/sparx5-spi.c b/drivers/mux/sparx5-spi.c
new file mode 100644
index 0000000000000..5fe9025b96a5e
--- /dev/null
+++ b/drivers/mux/sparx5-spi.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Sparx5 SPI MUX driver
+ *
+ * Copyright (c) 2019 Microsemi Corporation
+ *
+ * Author: Lars Povlsen <lars.povlsen@microchip.com>
+ */
+
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/mux/driver.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/mux/driver.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+#include <linux/bitfield.h>
+
+#define MSCC_IF_SI_OWNER_SISL			0
+#define MSCC_IF_SI_OWNER_SIBM			1
+#define MSCC_IF_SI_OWNER_SIMC			2
+
+#define SPARX5_CPU_SYSTEM_CTRL_GENERAL_CTRL	0x88
+#define SPARX5_IF_SI_OWNER			GENMASK(7, 6)
+#define SPARX5_IF_SI2_OWNER			GENMASK(5, 4)
+
+#define SPARX5_MAX_CS	16
+
+struct mux_sparx5 {
+	struct regmap *syscon;
+	u8 bus[SPARX5_MAX_CS];
+	int cur_bus;
+};
+
+/*
+ * Set the owner of the SPI interfaces
+ */
+static void mux_sparx5_set_owner(struct regmap *syscon,
+				 u8 owner, u8 owner2)
+{
+	u32 val, msk;
+
+	val = FIELD_PREP(SPARX5_IF_SI_OWNER, owner) |
+		FIELD_PREP(SPARX5_IF_SI2_OWNER, owner2);
+	msk = SPARX5_IF_SI_OWNER | SPARX5_IF_SI2_OWNER;
+	regmap_update_bits(syscon,
+			   SPARX5_CPU_SYSTEM_CTRL_GENERAL_CTRL,
+			   msk, val);
+}
+
+static void mux_sparx5_set_cs_owner(struct mux_sparx5 *mux_sparx5,
+				    u8 cs, u8 owner)
+{
+	u8 other = (owner == MSCC_IF_SI_OWNER_SIBM ?
+		    MSCC_IF_SI_OWNER_SIMC : MSCC_IF_SI_OWNER_SIBM);
+	if (mux_sparx5->bus[cs])
+		/* SPI2 */
+		mux_sparx5_set_owner(mux_sparx5->syscon, other, owner);
+	else
+		/* SPI1 */
+		mux_sparx5_set_owner(mux_sparx5->syscon, owner, other);
+}
+
+static int mux_sparx5_set(struct mux_control *mux, int state)
+{
+	struct mux_sparx5 *mux_sparx5 = mux_chip_priv(mux->chip);
+
+	mux_sparx5_set_cs_owner(mux_sparx5, state, MSCC_IF_SI_OWNER_SIMC);
+
+	return 0;
+}
+
+static const struct mux_control_ops mux_sparx5_ops = {
+	.set = mux_sparx5_set,
+};
+
+static const struct of_device_id mux_sparx5_dt_ids[] = {
+	{ .compatible = "microchip,sparx5-spi-mux", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mux_sparx5_dt_ids);
+
+static int mux_sparx5_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mux_chip *mux_chip;
+	struct mux_sparx5 *mux_sparx5;
+	struct device_node *nc;
+	const char *syscon_name = "microchip,sparx5-cpu-syscon";
+	int ret;
+
+	mux_chip = devm_mux_chip_alloc(dev, 1, sizeof(*mux_sparx5));
+	if (IS_ERR(mux_chip))
+		return PTR_ERR(mux_chip);
+
+	mux_sparx5 = mux_chip_priv(mux_chip);
+	mux_chip->ops = &mux_sparx5_ops;
+
+	mux_sparx5->syscon =
+		syscon_regmap_lookup_by_compatible(syscon_name);
+	if (IS_ERR(mux_sparx5->syscon)) {
+		dev_err(dev, "No syscon map %s\n", syscon_name);
+		return PTR_ERR(mux_sparx5->syscon);
+	}
+
+	/* Get bus interface mapping */
+	for_each_available_child_of_node(dev->of_node, nc) {
+		u32 cs, bus;
+
+		if (of_property_read_u32(nc, "reg", &cs) == 0 &&
+		    cs < SPARX5_MAX_CS &&
+		    of_property_read_u32(nc, "microchip,bus-interface",
+					 &bus) == 0)
+			mux_sparx5->bus[cs] = bus;
+	}
+
+	mux_chip->mux->states = SPARX5_MAX_CS;
+
+	ret = devm_mux_chip_register(dev, mux_chip);
+	if (ret < 0)
+		return ret;
+
+	dev_info(dev, "%u-way mux-controller registered\n",
+		 mux_chip->mux->states);
+
+	return 0;
+}
+
+static struct platform_driver mux_sparx5_driver = {
+	.driver = {
+		.name = "sparx5-mux",
+		.of_match_table	= of_match_ptr(mux_sparx5_dt_ids),
+	},
+	.probe = mux_sparx5_probe,
+};
+module_platform_driver(mux_sparx5_driver);
-- 
2.27.0

