Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C259B3A18D1
	for <lists+linux-spi@lfdr.de>; Wed,  9 Jun 2021 17:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238959AbhFIPOs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Jun 2021 11:14:48 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42582 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbhFIPOq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Jun 2021 11:14:46 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 49C161F43699
Received: by jupiter.universe (Postfix, from userid 1000)
        id CC5AF4800DF; Wed,  9 Jun 2021 17:12:46 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Ian Ray <ian.ray@ge.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv4 6/6] misc: gehc-achc: new driver
Date:   Wed,  9 Jun 2021 17:12:35 +0200
Message-Id: <20210609151235.48964-7-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210609151235.48964-1-sebastian.reichel@collabora.com>
References: <20210609151235.48964-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

General Electric Healthcare's PPD has a secondary processor from
NXP's Kinetis K20 series. That device has two SPI chip selects:

The main interface's behaviour depends on the loaded firmware
and is currently unused.

The secondary interface can be used to update the firmware using
EzPort protocol. This is implemented by this driver using the
kernel's firmware API. It's not done during probe time, since
the device has non-volatile memory and flashing lasts almost 3
minutes.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../ABI/testing/sysfs-driver-ge-achc          |   9 ++
 drivers/misc/Kconfig                          |  12 ++
 drivers/misc/Makefile                         |   1 +
 drivers/misc/gehc-achc.c                      | 136 ++++++++++++++++++
 drivers/spi/spidev.c                          |   1 -
 5 files changed, 158 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-ge-achc
 create mode 100644 drivers/misc/gehc-achc.c

diff --git a/Documentation/ABI/testing/sysfs-driver-ge-achc b/Documentation/ABI/testing/sysfs-driver-ge-achc
new file mode 100644
index 000000000000..3ca71a1b4836
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-ge-achc
@@ -0,0 +1,9 @@
+What:		/sys/bus/spi/drivers/gehc-achc/<dev>/update_firmware
+Date:		June 2021
+Contact:	linux-kernel@vger.kernel.org
+Description:	Write 1 to this file to trigger a firmware update.
+
+What:		/sys/bus/spi/drivers/gehc-achc/<dev>/reset
+Date:		June 2021
+Contact:	linux-kernel@vger.kernel.org
+Description:	Write 1 to this file to trigger a device reset.
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 392c091891a1..a286f0775f2e 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -211,6 +211,18 @@ config CS5535_CLOCK_EVENT_SRC
 config NXP_EZPORT
 	tristate
 
+config GEHC_ACHC
+	tristate "GEHC ACHC support"
+	depends on SPI && SYSFS && SPI_SPIDEV
+	select FW_LOADER
+	select NXP_EZPORT
+	help
+	  Support for GE ACHC microcontroller, that is part of the GE
+	  PPD device.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called gehc-achc.
+
 config HP_ILO
 	tristate "Channel interface driver for the HP iLO processor"
 	depends on PCI
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index a85e763b9b33..b7bad5a16c8f 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_SGI_XP)		+= sgi-xp/
 obj-$(CONFIG_SGI_GRU)		+= sgi-gru/
 obj-$(CONFIG_CS5535_MFGPT)	+= cs5535-mfgpt.o
 obj-$(CONFIG_NXP_EZPORT)	+= nxp-ezport.o
+obj-$(CONFIG_GEHC_ACHC)		+= gehc-achc.o
 obj-$(CONFIG_HP_ILO)		+= hpilo.o
 obj-$(CONFIG_APDS9802ALS)	+= apds9802als.o
 obj-$(CONFIG_ISL29003)		+= isl29003.o
diff --git a/drivers/misc/gehc-achc.c b/drivers/misc/gehc-achc.c
new file mode 100644
index 000000000000..5868ac99a3f6
--- /dev/null
+++ b/drivers/misc/gehc-achc.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * datasheet: https://www.nxp.com/docs/en/data-sheet/K20P144M120SF3.pdf
+ *
+ * Copyright (C) 2018-2021 Collabora
+ * Copyright (C) 2018-2021 GE Healthcare
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <linux/of.h>
+#include <linux/platform_data/nxp-ezport.h>
+
+#define ACHC_MAX_FREQ 300000
+
+struct achc_data {
+	struct spi_device *main;
+	struct spi_device *ezport;
+	struct gpio_desc *reset;
+
+	struct mutex device_lock; /* avoid concurrent device access */
+};
+
+static ssize_t update_firmware_store(struct device *dev, struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct achc_data *achc = dev_get_drvdata(dev);
+	int ret;
+
+	if (!count)
+		return -EINVAL;
+
+	mutex_lock(&achc->device_lock);
+	ret = ezport_flash(achc->ezport, achc->reset, "achc.bin");
+	mutex_unlock(&achc->device_lock);
+
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+static DEVICE_ATTR_WO(update_firmware);
+
+static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	struct achc_data *achc = dev_get_drvdata(dev);
+
+	if (!count)
+		return -EINVAL;
+
+	mutex_lock(&achc->device_lock);
+	ezport_reset(achc->reset);
+	mutex_unlock(&achc->device_lock);
+
+	return count;
+}
+static DEVICE_ATTR_WO(reset);
+
+static struct attribute *gehc_achc_attrs[] = {
+	&dev_attr_update_firmware.attr,
+	&dev_attr_reset.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(gehc_achc);
+
+static void unregister_ezport(void *data)
+{
+	struct spi_device *ezport = data;
+
+	spi_unregister_device(ezport);
+}
+
+static int gehc_achc_probe(struct spi_device *spi)
+{
+	struct achc_data *achc;
+	int ezport_reg, ret;
+
+	spi->max_speed_hz = ACHC_MAX_FREQ;
+	spi->bits_per_word = 8;
+	spi->mode = SPI_MODE_0;
+
+	achc = devm_kzalloc(&spi->dev, sizeof(*achc), GFP_KERNEL);
+	if (!achc)
+		return -ENOMEM;
+	spi_set_drvdata(spi, achc);
+	achc->main = spi;
+
+	mutex_init(&achc->device_lock);
+
+	ret = of_property_read_u32_index(spi->dev.of_node, "reg", 1, &ezport_reg);
+	if (ret)
+		return dev_err_probe(&spi->dev, ret, "missing second reg entry!\n");
+
+	achc->ezport = spi_new_ancillary_device(spi, ezport_reg);
+	if (IS_ERR(achc->ezport))
+		return PTR_ERR(achc->ezport);
+
+	ret = devm_add_action_or_reset(&spi->dev, unregister_ezport, achc->ezport);
+	if (ret)
+		return ret;
+
+	achc->reset = devm_gpiod_get(&spi->dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(achc->reset))
+		return dev_err_probe(&spi->dev, PTR_ERR(achc->reset), "Could not get reset gpio\n");
+
+	return 0;
+}
+
+static const struct spi_device_id gehc_achc_id[] = {
+	{ "ge,achc", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, gehc_achc_id);
+
+static const struct of_device_id gehc_achc_of_match[] = {
+	{ .compatible = "ge,achc" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, gehc_achc_of_match);
+
+static struct spi_driver gehc_achc_spi_driver = {
+	.driver = {
+		.name	= "gehc-achc",
+		.of_match_table = gehc_achc_of_match,
+		.dev_groups = gehc_achc_groups,
+	},
+	.probe		= gehc_achc_probe,
+	.id_table	= gehc_achc_id,
+};
+module_spi_driver(gehc_achc_spi_driver);
+
+MODULE_DESCRIPTION("GEHC ACHC driver");
+MODULE_AUTHOR("Sebastian Reichel <sebastian.reichel@collabora.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index f56e0e975a46..d0d9dbbbdec1 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -677,7 +677,6 @@ static struct class *spidev_class;
 static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "rohm,dh2228fv" },
 	{ .compatible = "lineartechnology,ltc2488" },
-	{ .compatible = "ge,achc" },
 	{ .compatible = "semtech,sx1301" },
 	{ .compatible = "lwn,bk4" },
 	{ .compatible = "dh,dhcom-board" },
-- 
2.30.2

