Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56FD3C5EB9
	for <lists+linux-spi@lfdr.de>; Mon, 12 Jul 2021 17:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235316AbhGLPFg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 12 Jul 2021 11:05:36 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54202 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235295AbhGLPFg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 12 Jul 2021 11:05:36 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 78C2B1F425BF
Received: by jupiter.universe (Postfix, from userid 1000)
        id 4A77F4800DC; Mon, 12 Jul 2021 17:02:44 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Ian Ray <ian.ray@ge.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv6 3/3] misc: gehc-achc: new driver
Date:   Mon, 12 Jul 2021 17:02:42 +0200
Message-Id: <20210712150242.146545-4-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210712150242.146545-1-sebastian.reichel@collabora.com>
References: <20210712150242.146545-1-sebastian.reichel@collabora.com>
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
 .../ABI/testing/sysfs-driver-ge-achc          |  14 +
 drivers/misc/Kconfig                          |  11 +
 drivers/misc/Makefile                         |   2 +
 drivers/misc/gehc-achc.c                      | 136 +++++
 drivers/misc/nxp-ezport.c                     | 468 ++++++++++++++++++
 drivers/misc/nxp-ezport.h                     |   9 +
 drivers/spi/spidev.c                          |   1 -
 7 files changed, 640 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-ge-achc
 create mode 100644 drivers/misc/gehc-achc.c
 create mode 100644 drivers/misc/nxp-ezport.c
 create mode 100644 drivers/misc/nxp-ezport.h

diff --git a/Documentation/ABI/testing/sysfs-driver-ge-achc b/Documentation/ABI/testing/sysfs-driver-ge-achc
new file mode 100644
index 000000000000..f02812731082
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-ge-achc
@@ -0,0 +1,14 @@
+What:		/sys/bus/spi/<dev>/update_firmware
+Date:		Jul 2021
+Contact:	sebastian.reichel@collabora.com
+Description:	Write 1 to this file to update the ACHC microcontroller
+		firmware via the EzPort interface. For this the kernel
+		will load "achc.bin" via the firmware API (so usually
+		from /lib/firmware). The write will block until the FW
+		has either been flashed successfully or an error occured.
+
+What:		/sys/bus/spi/<dev>/reset
+Date:		Jul 2021
+Contact:	sebastian.reichel@collabora.com
+Description:	Write 1 to this file to reset the microcontroller via the
+		reset GPIO. The write will block until the reset completes.
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index f4fb5c52b863..1ebf7000671d 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -208,6 +208,17 @@ config CS5535_CLOCK_EVENT_SRC
 	  MFGPTs have a better resolution and max interval than the
 	  generic PIT, and are suitable for use as high-res timers.
 
+config GEHC_ACHC
+	tristate "GEHC ACHC support"
+	depends on SPI && SYSFS
+	select FW_LOADER
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
index e92a56d4442f..b50180796931 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -24,6 +24,8 @@ obj-$(CONFIG_KGDB_TESTS)	+= kgdbts.o
 obj-$(CONFIG_SGI_XP)		+= sgi-xp/
 obj-$(CONFIG_SGI_GRU)		+= sgi-gru/
 obj-$(CONFIG_CS5535_MFGPT)	+= cs5535-mfgpt.o
+obj-$(CONFIG_GEHC_ACHC)		+= gehc-achc-mod.o
+gehc-achc-mod-objs		:= gehc-achc.o nxp-ezport.o
 obj-$(CONFIG_HP_ILO)		+= hpilo.o
 obj-$(CONFIG_APDS9802ALS)	+= apds9802als.o
 obj-$(CONFIG_ISL29003)		+= isl29003.o
diff --git a/drivers/misc/gehc-achc.c b/drivers/misc/gehc-achc.c
new file mode 100644
index 000000000000..893940e7ca4e
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
+#include "nxp-ezport.h"
+
+#define ACHC_MAX_FREQ_HZ 300000
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
+	if (count != 1 || buf[0] != '1')
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
+	if (count != 1 || buf[0] != '1')
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
+	spi->max_speed_hz = ACHC_MAX_FREQ_HZ;
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
diff --git a/drivers/misc/nxp-ezport.c b/drivers/misc/nxp-ezport.c
new file mode 100644
index 000000000000..1096af5690c8
--- /dev/null
+++ b/drivers/misc/nxp-ezport.c
@@ -0,0 +1,468 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * This library implements NXP's EzPort protocol used to
+ * flash the firmware of Kinetis microcontrollers, such
+ * as https://www.nxp.com/part/MK20FN1M0VMD12 and is
+ * intended to be used as ancillary SPI device.
+ *
+ * Copyright (C) 2018-2021 Collabora
+ * Copyright (C) 2018-2021 GE Healthcare
+ */
+
+#include <linux/delay.h>
+#include <linux/firmware.h>
+#include <linux/kernel.h>
+#include <linux/gpio/consumer.h>
+#include <linux/spi/spi.h>
+#include "nxp-ezport.h"
+
+#define EZPORT_RESET_DELAY_MS	100
+#define EZPORT_STARTUP_DELAY_MS	200
+#define EZPORT_WRITE_WAIT_MS	10
+#define EZPORT_TRANSFER_SIZE	2048
+
+#define EZPORT_CMD_SP		0x02 /* flash section program */
+#define EZPORT_CMD_RDSR		0x05 /* read status register */
+#define EZPORT_CMD_WREN		0x06 /* write enable */
+#define EZPORT_CMD_FAST_READ	0x0b /* flash read data at high speed */
+#define EZPORT_CMD_RESET	0xb9 /* reset chip */
+#define EZPORT_CMD_BE		0xc7 /* bulk erase */
+#define EZPORT_CMD_SE		0xd8 /* sector erase */
+
+#define EZPORT_SECTOR_SIZE	4096
+#define EZPORT_SECTOR_MASK	(EZPORT_SECTOR_SIZE - 1)
+
+#define EZPORT_STATUS_WIP	BIT(0) /* write in progress */
+#define EZPORT_STATUS_WEN	BIT(1) /* write enable */
+#define EZPORT_STATUS_BEDIS	BIT(2) /* bulk erase disable */
+#define EZPORT_STATUS_FLEXRAM	BIT(3) /* FlexRAM mode */
+#define EZPORT_STATUS_WEF	BIT(6) /* write error flag */
+#define EZPORT_STATUS_FS	BIT(7) /* flash security */
+
+/**
+ * ezport_reset - reset ezport device
+ * @reset: the gpio connected to the device reset pin
+ *
+ * Context: can sleep
+ */
+void ezport_reset(struct gpio_desc *reset)
+{
+	gpiod_set_value(reset, 1);
+	msleep(EZPORT_RESET_DELAY_MS);
+	gpiod_set_value(reset, 0);
+	msleep(EZPORT_STARTUP_DELAY_MS);
+}
+
+static int ezport_start_programming(struct spi_device *spi, struct gpio_desc *reset)
+{
+	struct spi_message msg;
+	struct spi_transfer assert_cs = {
+		.cs_change   = 1,
+	};
+	struct spi_transfer release_cs = { };
+	int ret;
+
+	spi_bus_lock(spi->master);
+
+	/* assert chip select */
+	spi_message_init(&msg);
+	spi_message_add_tail(&assert_cs, &msg);
+	ret = spi_sync_locked(spi, &msg);
+	if (ret)
+		goto fail;
+
+	msleep(EZPORT_STARTUP_DELAY_MS);
+
+	/* reset with asserted chip select to switch into programming mode */
+	ezport_reset(reset);
+
+	/* release chip select */
+	spi_message_init(&msg);
+	spi_message_add_tail(&release_cs, &msg);
+	ret = spi_sync_locked(spi, &msg);
+
+fail:
+	spi_bus_unlock(spi->master);
+	return ret;
+}
+
+static void ezport_stop_programming(struct spi_device *spi, struct gpio_desc *reset)
+{
+	/* reset without asserted chip select to return into normal mode */
+	spi_bus_lock(spi->master);
+	ezport_reset(reset);
+	spi_bus_unlock(spi->master);
+}
+
+static int ezport_get_status_register(struct spi_device *spi)
+{
+	int ret;
+
+	ret = spi_w8r8(spi, EZPORT_CMD_RDSR);
+	if (ret < 0)
+		return ret;
+	if (ret == 0xff) {
+		dev_err(&spi->dev, "Invalid EzPort status, EzPort is not functional!\n");
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int ezport_soft_reset(struct spi_device *spi)
+{
+	u8 cmd = EZPORT_CMD_RESET;
+	int ret;
+
+	ret = spi_write(spi, &cmd, 1);
+	if (ret < 0)
+		return ret;
+
+	msleep(EZPORT_STARTUP_DELAY_MS);
+
+	return 0;
+}
+
+static int ezport_send_simple(struct spi_device *spi, u8 cmd)
+{
+	int ret;
+
+	ret = spi_write(spi, &cmd, 1);
+	if (ret < 0)
+		return ret;
+
+	return ezport_get_status_register(spi);
+}
+
+static int ezport_wait_write(struct spi_device *spi, u32 retries)
+{
+	int ret;
+	u32 i;
+
+	for (i = 0; i < retries; i++) {
+		ret = ezport_get_status_register(spi);
+		if (ret > 0 && !(ret & EZPORT_STATUS_WIP))
+			break;
+		msleep(EZPORT_WRITE_WAIT_MS);
+	}
+
+	return ret;
+}
+
+static int ezport_write_enable(struct spi_device *spi)
+{
+	int ret = 0, retries = 3;
+
+	for (retries = 0; retries < 3; retries++) {
+		ret = ezport_send_simple(spi, EZPORT_CMD_WREN);
+		if (ret > 0 && ret & EZPORT_STATUS_WEN)
+			break;
+	}
+
+	if (!(ret & EZPORT_STATUS_WEN)) {
+		dev_err(&spi->dev, "EzPort write enable timed out\n");
+		return -ETIMEDOUT;
+	}
+	return 0;
+}
+
+static int ezport_bulk_erase(struct spi_device *spi)
+{
+	int ret;
+	static const u8 cmd = EZPORT_CMD_BE;
+
+	dev_dbg(&spi->dev, "EzPort bulk erase...\n");
+
+	ret = ezport_write_enable(spi);
+	if (ret < 0)
+		return ret;
+
+	ret = spi_write(spi, &cmd, 1);
+	if (ret < 0)
+		return ret;
+
+	ret = ezport_wait_write(spi, 1000);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int ezport_section_erase(struct spi_device *spi, u32 address)
+{
+	u8 query[] = {EZPORT_CMD_SE, (address >> 16) & 0xff, (address >> 8) & 0xff, address & 0xff};
+	int ret;
+
+	dev_dbg(&spi->dev, "Ezport section erase @ 0x%06x...\n", address);
+
+	if (address & EZPORT_SECTOR_MASK)
+		return -EINVAL;
+
+	ret = ezport_write_enable(spi);
+	if (ret < 0)
+		return ret;
+
+	ret = spi_write(spi, query, sizeof(query));
+	if (ret < 0)
+		return ret;
+
+	return ezport_wait_write(spi, 200);
+}
+
+static int ezport_flash_transfer(struct spi_device *spi, u32 address,
+				 const u8 *payload, size_t payload_size)
+{
+	struct spi_transfer xfers[2] = {};
+	u8 *command;
+	int ret;
+
+	dev_dbg(&spi->dev, "EzPort write %zu bytes @ 0x%06x...\n", payload_size, address);
+
+	command = kmalloc(4, GFP_KERNEL | GFP_DMA);
+	if (!command)
+		return -ENOMEM;
+
+	command[0] = EZPORT_CMD_SP;
+	command[1] = address >> 16;
+	command[2] = address >> 8;
+	command[3] = address >> 0;
+
+	xfers[0].tx_buf = command;
+	xfers[0].len = 4;
+
+	xfers[1].tx_buf = payload;
+	xfers[1].len = payload_size;
+
+	ret = spi_sync_transfer(spi, xfers, 2);
+	kfree(command);
+	if (ret < 0)
+		return ret;
+
+	return ezport_wait_write(spi, 40);
+}
+
+static int ezport_flash_compare(struct spi_device *spi, u32 address,
+				const u8 *payload, size_t payload_size)
+{
+	struct spi_transfer xfers[2] = {};
+	u8 *buffer;
+	int ret;
+
+	buffer = kmalloc(payload_size + 4, GFP_KERNEL | GFP_DMA);
+	if (!buffer)
+		return -ENOMEM;
+
+	buffer[0] = EZPORT_CMD_FAST_READ;
+	buffer[1] = address >> 16;
+	buffer[2] = address >> 8;
+	buffer[3] = address >> 0;
+
+	xfers[0].tx_buf = buffer;
+	xfers[0].len = 4;
+
+	xfers[1].rx_buf = buffer + 4;
+	xfers[1].len = payload_size;
+
+	ret = spi_sync_transfer(spi, xfers, 2);
+	if (ret)
+		goto err;
+
+	ret = memcmp(payload, buffer + 4, payload_size);
+	if (ret) {
+		ret = -EBADMSG;
+		dev_dbg(&spi->dev, "Verfication failure @ %06x", address);
+		print_hex_dump_bytes("fw:  ", DUMP_PREFIX_OFFSET, payload, payload_size);
+		print_hex_dump_bytes("dev: ", DUMP_PREFIX_OFFSET, buffer + 4, payload_size);
+	}
+
+err:
+	kfree(buffer);
+	return ret;
+}
+
+static int ezport_firmware_compare_data(struct spi_device *spi,
+					const u8 *data, size_t size)
+{
+	int ret;
+	u32 address = 0;
+	u32 transfer_size;
+
+	dev_dbg(&spi->dev, "EzPort compare data with %zu bytes...\n", size);
+
+	ret = ezport_get_status_register(spi);
+	if (ret < 0)
+		return ret;
+
+	if (ret & EZPORT_STATUS_FS) {
+		dev_info(&spi->dev, "Device is in secure mode (status=0x%02x)!\n", ret);
+		dev_info(&spi->dev, "FW verification is not possible\n");
+		return -EACCES;
+	}
+
+	while (size - address > 0) {
+		transfer_size = min((u32) EZPORT_TRANSFER_SIZE, size - address);
+
+		ret = ezport_flash_compare(spi, address, data+address, transfer_size);
+		if (ret)
+			return ret;
+
+		address += transfer_size;
+	}
+
+	return 0;
+}
+
+static int ezport_firmware_flash_data(struct spi_device *spi,
+				      const u8 *data, size_t size)
+{
+	int ret;
+	u32 address = 0;
+	u32 transfer_size;
+
+	dev_dbg(&spi->dev, "EzPort flash data with %zu bytes...\n", size);
+
+	ret = ezport_get_status_register(spi);
+	if (ret < 0)
+		return ret;
+
+	if (ret & EZPORT_STATUS_FS) {
+		ret = ezport_bulk_erase(spi);
+		if (ret < 0)
+			return ret;
+		if (ret & EZPORT_STATUS_FS)
+			return -EINVAL;
+	}
+
+	while (size - address > 0) {
+		if (!(address & EZPORT_SECTOR_MASK)) {
+			ret = ezport_section_erase(spi, address);
+			if (ret < 0)
+				return ret;
+			if (ret & EZPORT_STATUS_WIP || ret & EZPORT_STATUS_WEF)
+				return -EIO;
+		}
+
+		transfer_size = min((u32) EZPORT_TRANSFER_SIZE, size - address);
+
+		ret = ezport_flash_transfer(spi, address,
+					    data+address, transfer_size);
+		if (ret < 0)
+			return ret;
+		else if (ret & EZPORT_STATUS_WIP)
+			return -ETIMEDOUT;
+		else if (ret & EZPORT_STATUS_WEF)
+			return -EIO;
+
+		address += transfer_size;
+	}
+
+	ret = ezport_soft_reset(spi);
+	if (ret < 0)
+		dev_warn(&spi->dev, "EzPort reset failed!\n");
+
+	dev_dbg(&spi->dev, "EzPort verify flashed data...\n");
+	ret = ezport_firmware_compare_data(spi, data, size);
+
+	/* allow missing FW verfication in secure mode */
+	if (ret == -EACCES)
+		ret = 0;
+
+	if (ret < 0)
+		dev_err(&spi->dev, "Failed to verify flashed data: %d\n", ret);
+
+	return ret;
+}
+
+static int ezport_firmware_load(struct spi_device *spi, const char *fwname)
+{
+	const struct firmware *fw;
+	int ret;
+
+	ret = request_firmware(&fw, fwname, &spi->dev);
+	if (ret) {
+		dev_err(&spi->dev, "Could not get firmware: %d\n", ret);
+		return ret;
+	}
+
+	ret = ezport_firmware_flash_data(spi, fw->data, fw->size);
+
+	release_firmware(fw);
+
+	return ret;
+}
+
+static int ezport_firmware_verify(struct spi_device *spi, const char *fwname)
+{
+	const struct firmware *fw;
+	int ret;
+
+	ret = request_firmware(&fw, fwname, &spi->dev);
+	if (ret) {
+		dev_err(&spi->dev, "Could not get firmware: %d\n", ret);
+		return ret;
+	}
+
+	ret = ezport_firmware_compare_data(spi, fw->data, fw->size);
+
+	release_firmware(fw);
+
+	return ret;
+}
+
+/**
+ * ezport_flash - flash device firmware
+ * @spi: SPI device for NXP EzPort interface
+ * @reset: the gpio connected to the device reset pin
+ * @fwname: filename of the firmware that should be flashed
+ *
+ * Context: can sleep
+ *
+ * Return: 0 on success; negative errno on failure
+ */
+int ezport_flash(struct spi_device *spi, struct gpio_desc *reset, const char *fwname)
+{
+	int ret;
+
+	ret = ezport_start_programming(spi, reset);
+	if (ret)
+		return ret;
+
+	ret = ezport_firmware_load(spi, fwname);
+
+	ezport_stop_programming(spi, reset);
+
+	if (ret)
+		dev_err(&spi->dev, "Failed to flash firmware: %d\n", ret);
+	else
+		dev_dbg(&spi->dev, "Finished FW flashing!\n");
+
+	return ret;
+}
+
+/**
+ * ezport_verify - verify device firmware
+ * @spi: SPI device for NXP EzPort interface
+ * @reset: the gpio connected to the device reset pin
+ * @fwname: filename of the firmware that should be compared
+ *
+ * Context: can sleep
+ *
+ * Return: 0 on success; negative errno on failure
+ */
+int ezport_verify(struct spi_device *spi, struct gpio_desc *reset, const char *fwname)
+{
+	int ret;
+
+	ret = ezport_start_programming(spi, reset);
+	if (ret)
+		return ret;
+
+	ret = ezport_firmware_verify(spi, fwname);
+
+	ezport_stop_programming(spi, reset);
+
+	if (ret)
+		dev_err(&spi->dev, "Failed to verify firmware: %d\n", ret);
+
+	return ret;
+}
diff --git a/drivers/misc/nxp-ezport.h b/drivers/misc/nxp-ezport.h
new file mode 100644
index 000000000000..fc48af82409b
--- /dev/null
+++ b/drivers/misc/nxp-ezport.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __NXP_EZPORT_H
+#define __NXP_EZPORT_H
+
+void ezport_reset(struct gpio_desc *reset);
+int ezport_flash(struct spi_device *spi, struct gpio_desc *reset, const char *fwname);
+int ezport_verify(struct spi_device *spi, struct gpio_desc *reset, const char *fwname);
+
+#endif
diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 24e9469ea35b..6dc29ce3b4bf 100644
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

