Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3DD3A18D3
	for <lists+linux-spi@lfdr.de>; Wed,  9 Jun 2021 17:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238967AbhFIPOs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Jun 2021 11:14:48 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42592 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbhFIPOr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Jun 2021 11:14:47 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 49C501F436A1
Received: by jupiter.universe (Postfix, from userid 1000)
        id C8AAF4800DE; Wed,  9 Jun 2021 17:12:46 +0200 (CEST)
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
Subject: [PATCHv4 5/6] misc: nxp-ezport: introduce EzPort support
Date:   Wed,  9 Jun 2021 17:12:34 +0200
Message-Id: <20210609151235.48964-6-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210609151235.48964-1-sebastian.reichel@collabora.com>
References: <20210609151235.48964-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add new EzPort support code, which can be used to do
firmware updates of Kinetis coprocessors. The driver
is not usable on its own and thus not user selectable.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/misc/Kconfig                     |   3 +
 drivers/misc/Makefile                    |   1 +
 drivers/misc/nxp-ezport.c                | 476 +++++++++++++++++++++++
 include/linux/platform_data/nxp-ezport.h |   9 +
 4 files changed, 489 insertions(+)
 create mode 100644 drivers/misc/nxp-ezport.c
 create mode 100644 include/linux/platform_data/nxp-ezport.h

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index f4fb5c52b863..392c091891a1 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -208,6 +208,9 @@ config CS5535_CLOCK_EVENT_SRC
 	  MFGPTs have a better resolution and max interval than the
 	  generic PIT, and are suitable for use as high-res timers.
 
+config NXP_EZPORT
+	tristate
+
 config HP_ILO
 	tristate "Channel interface driver for the HP iLO processor"
 	depends on PCI
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index e92a56d4442f..a85e763b9b33 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_KGDB_TESTS)	+= kgdbts.o
 obj-$(CONFIG_SGI_XP)		+= sgi-xp/
 obj-$(CONFIG_SGI_GRU)		+= sgi-gru/
 obj-$(CONFIG_CS5535_MFGPT)	+= cs5535-mfgpt.o
+obj-$(CONFIG_NXP_EZPORT)	+= nxp-ezport.o
 obj-$(CONFIG_HP_ILO)		+= hpilo.o
 obj-$(CONFIG_APDS9802ALS)	+= apds9802als.o
 obj-$(CONFIG_ISL29003)		+= isl29003.o
diff --git a/drivers/misc/nxp-ezport.c b/drivers/misc/nxp-ezport.c
new file mode 100644
index 000000000000..2fcdf135387b
--- /dev/null
+++ b/drivers/misc/nxp-ezport.c
@@ -0,0 +1,476 @@
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
+#include <linux/module.h>
+#include <linux/gpio/consumer.h>
+#include <linux/spi/spi.h>
+#include <linux/platform_data/nxp-ezport.h>
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
+EXPORT_SYMBOL_GPL(ezport_reset);
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
+EXPORT_SYMBOL_GPL(ezport_flash);
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
+EXPORT_SYMBOL_GPL(ezport_verify);
+
+MODULE_DESCRIPTION("NXP EzPort protocol support");
+MODULE_AUTHOR("Sebastian Reichel <sebastian.reichel@collabora.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/platform_data/nxp-ezport.h b/include/linux/platform_data/nxp-ezport.h
new file mode 100644
index 000000000000..b0a2af9c1285
--- /dev/null
+++ b/include/linux/platform_data/nxp-ezport.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+#ifndef __NXP_EZPORT_H
+#define __NXP_EZPORT_H
+
+extern void ezport_reset(struct gpio_desc *reset);
+extern int ezport_flash(struct spi_device *spi, struct gpio_desc *reset, const char *fwname);
+extern int ezport_verify(struct spi_device *spi, struct gpio_desc *reset, const char *fwname);
+
+#endif
-- 
2.30.2

