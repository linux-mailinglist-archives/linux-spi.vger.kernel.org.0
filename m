Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBE34C50A5
	for <lists+linux-spi@lfdr.de>; Fri, 25 Feb 2022 22:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238716AbiBYVYg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 25 Feb 2022 16:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238563AbiBYVY1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 25 Feb 2022 16:24:27 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EDB192E3A;
        Fri, 25 Feb 2022 13:23:52 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id s24so9147327edr.5;
        Fri, 25 Feb 2022 13:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=zB0IQwhpSo0cJZN1tV91D8ol1+twM69HpJzwRaIzseo=;
        b=VLqwuiKdqRj1gs6Ceugkk1+FYDAxeNCBkwtCR0B/dBGeKHKUFdCYnmmtYX3fDKeEQ4
         l8AjMrAqK283f0zn8VCZTAGorRxWZ3dMTRAJQ1sLVs5snRIA2StZYuMiX82+pOZgDXmM
         zMMpI/qqqMxhHTZGs+Af1QiQUOPgzr3KO1Sp8kxPEd9FdGaFCLR9NrFoIroYSCgfDuqj
         lTEAAhPNxmCYJXnZ9u//I55xRW6Wyx13vFT50+LGFxrPg5wLHMtJ7DsO4mRSXiTs7PjZ
         GsEZlSvOdwPY8jbXYRZTYuow8+UDL/Y4MEwr28icibrLbKu2kQoZ7c95uA/MK2PMWB6Z
         OeSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=zB0IQwhpSo0cJZN1tV91D8ol1+twM69HpJzwRaIzseo=;
        b=D6O/zz1KmUdLMhDRcFAsnTDsMtPhlaZUbthBMVez33Z5MV0oe8DomumkDuSMycjG03
         +koMjtmuqZcfTg5YKzdGLcQggTn6X4GcBWaGjLWRjOwk5UpPOUjy6yhDUMS9qE+8f0H9
         p08G23bIA527MtuqjTxlUDO/b7n9FVunyt5GaxyVoiTkuztluw3E5yABmQKkylOUo7YF
         egcgQuRg3f5ga2s9txf5gaoNVPbo+ey0ERePJ3Z1yUCg599SJgPP83zgAfMOhvEj3HJh
         Nw91gflLpPtKyI6AuLuyoxxGNnP2qxgVIop3OqjvfE6M94tzCT5xmI0EwY8s04UrKGBT
         8lTQ==
X-Gm-Message-State: AOAM532rEXO34qfwx5fiapyt4NBEUUuEN2+vwHqJ+YvWSRNzXziPYh82
        nBjZvZIEEbCBlhNWBnlID98=
X-Google-Smtp-Source: ABdhPJwx5cXGnvVwiw2ht5bb96nMciSKHq6LCDUl0pZjw8s1gsU3c+WFayK9PF2VG3FsOHJb0O8jww==
X-Received: by 2002:a05:6402:510a:b0:413:1a1a:6f5c with SMTP id m10-20020a056402510a00b004131a1a6f5cmr8755201edd.430.1645824231337;
        Fri, 25 Feb 2022 13:23:51 -0800 (PST)
Received: from ?IPV6:2a01:c22:7326:e100:c9d3:3c62:2c99:d44b? (dynamic-2a01-0c22-7326-e100-c9d3-3c62-2c99-d44b.c22.pool.telefonica.de. [2a01:c22:7326:e100:c9d3:3c62:2c99:d44b])
        by smtp.googlemail.com with ESMTPSA id bm24-20020a0564020b1800b004129263ff24sm1869261edb.68.2022.02.25.13.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 13:23:50 -0800 (PST)
Message-ID: <4d06e187-3edc-565a-c1ce-a4f2d16f0179@gmail.com>
Date:   Fri, 25 Feb 2022 22:20:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: [PATCH v5 4/6] auxdisplay: add support for Titanmec TM1628 7 segment
 display controller
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <90668779-b53d-b3e7-5327-af11ff4a1d18@gmail.com>
In-Reply-To: <90668779-b53d-b3e7-5327-af11ff4a1d18@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch adds support for the Titanmec TM1628 7 segment display
controller. It's based on previous RFC work from Andreas Färber.
The RFC version placed the driver in the LED subsystem, but this was
NAK'ed by the LED maintainer. Therefore I moved the driver to
/drivers/auxdisplay what seems most reasonable to me.

Further changes to the RFC version:
- Driver can be built also w/o LED class support, for displays that
  don't have any symbols to be exposed as LED's.
- Simplified the code and rewrote a lot of it.
- Driver is now kind of a MVP, but functionality should be sufficient
  for most use cases.
- Use the existing 7 segment support in uapi/linux/map_to_7segment.h
  as suggested by Geert Uytterhoeven.

Note: There's a number of chips from other manufacturers that are
      almost identical, e.g. FD628, SM1628. Only difference I saw so
      far is that they partially support other display modes.
      TM1628: 6x12, 7x11
      SM1628C: 4x13, 5x12, 6x11, 7x10
      For typical displays on devices using these chips this
      difference shouldn't matter.

Successfully tested on a TX3 Mini TV box that has an SM1628C and a
display with 4 digits and 7 symbols.

Co-developed-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v3:
- use Co-Developed-by
v4:
- switch to Co-developed-by
- style fixes
- fix potential write beyond end in display_text_store()
v5:
- add vendor prefix to controller-specific properties
---
 drivers/auxdisplay/Kconfig  |  11 ++
 drivers/auxdisplay/Makefile |   1 +
 drivers/auxdisplay/tm1628.c | 376 ++++++++++++++++++++++++++++++++++++
 3 files changed, 388 insertions(+)
 create mode 100644 drivers/auxdisplay/tm1628.c

diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
index 64012cda4..2764afc5c 100644
--- a/drivers/auxdisplay/Kconfig
+++ b/drivers/auxdisplay/Kconfig
@@ -203,6 +203,17 @@ config ARM_CHARLCD
 	  line and the Linux version on the second line, but that's
 	  still useful.
 
+config TM1628
+	tristate "TM1628 driver for LED 7/11 segment displays"
+	depends on SPI
+	depends on OF || COMPILE_TEST
+	help
+	  Say Y to enable support for Titan Micro Electronics TM1628
+	  LED controller.
+
+	  It's a 3-wire SPI device controlling a two-dimensional grid of
+	  LEDs. Dimming is applied to all outputs through an internal PWM.
+
 menuconfig PARPORT_PANEL
 	tristate "Parallel port LCD/Keypad Panel support"
 	depends on PARPORT
diff --git a/drivers/auxdisplay/Makefile b/drivers/auxdisplay/Makefile
index 6968ed4d3..7728e17e1 100644
--- a/drivers/auxdisplay/Makefile
+++ b/drivers/auxdisplay/Makefile
@@ -14,3 +14,4 @@ obj-$(CONFIG_HT16K33)		+= ht16k33.o
 obj-$(CONFIG_PARPORT_PANEL)	+= panel.o
 obj-$(CONFIG_LCD2S)		+= lcd2s.o
 obj-$(CONFIG_LINEDISP)		+= line-display.o
+obj-$(CONFIG_TM1628)		+= tm1628.o
diff --git a/drivers/auxdisplay/tm1628.c b/drivers/auxdisplay/tm1628.c
new file mode 100644
index 000000000..43d6f2626
--- /dev/null
+++ b/drivers/auxdisplay/tm1628.c
@@ -0,0 +1,376 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Titan Micro Electronics TM1628 LED controller
+ *
+ * Copyright (c) 2019 Andreas Färber
+ * Copyright (c) 2022 Heiner Kallweit
+ */
+
+#include <linux/ctype.h>
+#include <linux/delay.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/spi/spi.h>
+#include <uapi/linux/map_to_7segment.h>
+
+#define TM1628_CMD_DISPLAY_MODE		(0 << 6)
+#define TM1628_DISPLAY_MODE_6_12	0x02
+#define TM1628_DISPLAY_MODE_7_11	0x03
+
+#define TM1628_CMD_DATA			(1 << 6)
+#define TM1628_DATA_TEST_MODE		BIT(3)
+#define TM1628_DATA_FIXED_ADDR		BIT(2)
+#define TM1628_DATA_WRITE_DATA		0x00
+#define TM1628_DATA_READ_DATA		0x02
+
+#define TM1628_CMD_DISPLAY_CTRL		(2 << 6)
+#define TM1628_DISPLAY_CTRL_DISPLAY_ON	BIT(3)
+
+#define TM1628_CMD_SET_ADDRESS		(3 << 6)
+
+#define TM1628_BRIGHTNESS_MAX		7
+#define NUM_LED_SEGS			7
+
+/* Physical limits, depending on the mode the chip may support less */
+#define MAX_GRID_SIZE			7
+#define MAX_SEGMENT_NUM			16
+
+struct tm1628_led {
+	struct led_classdev	leddev;
+	struct tm1628		*ctrl;
+	u32			grid;
+	u32			seg;
+};
+
+struct tm1628 {
+	struct spi_device		*spi;
+	__le16				data[MAX_GRID_SIZE];
+	struct mutex			disp_lock;
+	char				text[MAX_GRID_SIZE + 1];
+	u8				segment_mapping[NUM_LED_SEGS];
+	u8				grid[MAX_GRID_SIZE];
+	int				grid_size;
+	struct tm1628_led		leds[];
+};
+
+/* Command 1: Display Mode Setting */
+static int tm1628_set_display_mode(struct spi_device *spi, u8 grid_mode)
+{
+	const u8 cmd = TM1628_CMD_DISPLAY_MODE | grid_mode;
+
+	return spi_write(spi, &cmd, 1);
+}
+
+/* Command 3: Address Setting */
+static int tm1628_set_address(struct spi_device *spi, u8 offset)
+{
+	const u8 cmd = TM1628_CMD_SET_ADDRESS | (offset * sizeof(__le16));
+
+	return spi_write(spi, &cmd, 1);
+}
+
+/* Command 2: Data Setting */
+static int tm1628_write_data(struct spi_device *spi, unsigned int offset,
+			     unsigned int len)
+{
+	struct tm1628 *s = spi_get_drvdata(spi);
+	const u8 cmd = TM1628_CMD_DATA | TM1628_DATA_WRITE_DATA;
+	struct spi_transfer xfers[] = {
+		{
+			.tx_buf = &cmd,
+			.len = 1,
+		},
+		{
+			.tx_buf = (__force void *)(s->data + offset),
+			.len = len * sizeof(__le16),
+		},
+	};
+
+	if (offset + len > MAX_GRID_SIZE) {
+		dev_err(&spi->dev, "Invalid data address offset %u len %u\n",
+			offset, len);
+		return -EINVAL;
+	}
+
+	tm1628_set_address(spi, offset);
+
+	return spi_sync_transfer(spi, xfers, ARRAY_SIZE(xfers));
+}
+
+/* Command 4: Display Control */
+static int tm1628_set_display_ctrl(struct spi_device *spi, bool on)
+{
+	u8 cmd = TM1628_CMD_DISPLAY_CTRL | TM1628_BRIGHTNESS_MAX;
+
+	if (on)
+		cmd |= TM1628_DISPLAY_CTRL_DISPLAY_ON;
+
+	return spi_write(spi, &cmd, 1);
+}
+
+static int tm1628_show_text(struct tm1628 *s)
+{
+	static SEG7_CONVERSION_MAP(map_seg7, MAP_ASCII7SEG_ALPHANUM);
+	int msg_len, i, ret;
+
+	msg_len = strlen(s->text);
+
+	mutex_lock(&s->disp_lock);
+
+	for (i = 0; i < s->grid_size; i++) {
+		int pos = s->grid[i] - 1;
+		int j, char7_raw, char7;
+
+		if (i >= msg_len) {
+			s->data[pos] = 0;
+			continue;
+		}
+
+		char7_raw = map_to_seg7(&map_seg7, s->text[i]);
+
+		for (j = 0, char7 = 0; j < NUM_LED_SEGS; j++) {
+			if (char7_raw & BIT(j))
+				char7 |= BIT(s->segment_mapping[j] - 1);
+		}
+
+		s->data[pos] = cpu_to_le16(char7);
+	}
+
+	ret = tm1628_write_data(s->spi, 0, s->grid_size);
+
+	mutex_unlock(&s->disp_lock);
+
+	return ret;
+}
+
+static int tm1628_led_set_brightness(struct led_classdev *led_cdev,
+				     enum led_brightness brightness)
+{
+	struct tm1628_led *led = container_of(led_cdev, struct tm1628_led, leddev);
+	struct tm1628 *s = led->ctrl;
+	int ret, offset = led->grid - 1;
+	__le16 bit = cpu_to_le16(BIT(led->seg - 1));
+
+	mutex_lock(&s->disp_lock);
+
+	if (brightness == LED_OFF)
+		s->data[offset] &= ~bit;
+	else
+		s->data[offset] |= bit;
+
+	ret = tm1628_write_data(s->spi, offset, 1);
+
+	mutex_unlock(&s->disp_lock);
+
+	return ret;
+}
+
+static enum led_brightness tm1628_led_get_brightness(struct led_classdev *led_cdev)
+{
+	struct tm1628_led *led = container_of(led_cdev, struct tm1628_led, leddev);
+	struct tm1628 *s = led->ctrl;
+	int offset = led->grid - 1;
+	__le16 bit = cpu_to_le16(BIT(led->seg - 1));
+	bool on;
+
+	mutex_lock(&s->disp_lock);
+	on = s->data[offset] & bit;
+	mutex_unlock(&s->disp_lock);
+
+	return on ? LED_ON : LED_OFF;
+}
+
+static int tm1628_register_led(struct tm1628 *s, struct fwnode_handle *node,
+			       u32 grid, u32 seg, struct tm1628_led *led)
+{
+	struct device *dev = &s->spi->dev;
+	struct led_init_data init_data = { .fwnode = node };
+
+	led->ctrl = s;
+	led->grid = grid;
+	led->seg  = seg;
+	led->leddev.max_brightness = LED_ON;
+	led->leddev.brightness_set_blocking = tm1628_led_set_brightness;
+	led->leddev.brightness_get = tm1628_led_get_brightness;
+
+	return devm_led_classdev_register_ext(dev, &led->leddev, &init_data);
+}
+
+static ssize_t display_text_show(struct device *dev, struct device_attribute *attr,
+				 char *buf)
+{
+	struct tm1628 *s = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%s\n", s->text);
+}
+
+static ssize_t display_text_store(struct device *dev, struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct tm1628 *s = dev_get_drvdata(dev);
+	int ret, i;
+
+	for (i = 0; i < count && i < s->grid_size && isprint(buf[i]); i++)
+		s->text[i] = buf[i];
+
+	s->text[i] = '\0';
+
+	ret = tm1628_show_text(s);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static const DEVICE_ATTR_RW(display_text);
+
+static int tm1628_spi_probe(struct spi_device *spi)
+{
+	struct fwnode_handle *child;
+	unsigned int num_leds;
+	struct tm1628 *s;
+	int ret, i;
+
+	num_leds = device_get_child_node_count(&spi->dev);
+
+	s = devm_kzalloc(&spi->dev, struct_size(s, leds, num_leds), GFP_KERNEL);
+	if (!s)
+		return -ENOMEM;
+
+	s->spi = spi;
+	spi_set_drvdata(spi, s);
+
+	mutex_init(&s->disp_lock);
+
+	/* According to TM1628 datasheet */
+	msleep(200);
+
+	/* Clear screen */
+	ret = tm1628_write_data(spi, 0, MAX_GRID_SIZE);
+	if (ret)
+		return ret;
+
+	/* For now we support 6x12 mode only. This should be sufficient for most use cases */
+	ret = tm1628_set_display_mode(spi, TM1628_DISPLAY_MODE_6_12);
+	if (ret)
+		return ret;
+
+	ret = tm1628_set_display_ctrl(spi, true);
+	if (ret)
+		return ret;
+
+	num_leds = 0;
+
+	if (!IS_REACHABLE(CONFIG_LEDS_CLASS))
+		goto no_leds;
+
+	device_for_each_child_node(&spi->dev, child) {
+		u32 reg[2];
+
+		ret = fwnode_property_read_u32_array(child, "reg", reg, 2);
+		if (ret) {
+			dev_err(&spi->dev, "Reading %s reg property failed (%d)\n",
+				fwnode_get_name(child), ret);
+			continue;
+		}
+
+		if (reg[0] == 0 || reg[0] > MAX_GRID_SIZE) {
+			dev_err(&spi->dev, "Invalid grid %u at %s\n",
+				reg[0], fwnode_get_name(child));
+			continue;
+		}
+
+		if (reg[1] == 0 || reg[1] > MAX_SEGMENT_NUM) {
+			dev_err(&spi->dev, "Invalid segment %u at %s\n",
+				reg[1], fwnode_get_name(child));
+			continue;
+		}
+
+		ret = tm1628_register_led(s, child, reg[0], reg[1], s->leds + num_leds);
+		if (ret) {
+			dev_err(&spi->dev, "Failed to register LED %s (%d)\n",
+				fwnode_get_name(child), ret);
+			continue;
+		}
+		num_leds++;
+	}
+
+no_leds:
+	ret = device_property_count_u8(&spi->dev, "titanmec,grid");
+	if (ret < 1 || ret > MAX_GRID_SIZE) {
+		dev_err(&spi->dev, "Invalid display length (%d)\n", ret);
+		return -EINVAL;
+	}
+
+	s->grid_size = ret;
+
+	ret = device_property_read_u8_array(&spi->dev, "titanmec,grid", s->grid, s->grid_size);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < s->grid_size; i++) {
+		if (s->grid[i] < 1 || s->grid[i] > s->grid_size)
+			return -EINVAL;
+	}
+
+	ret = device_property_read_u8_array(&spi->dev, "titanmec,segment-mapping",
+					    s->segment_mapping, NUM_LED_SEGS);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < NUM_LED_SEGS; i++) {
+		if (s->segment_mapping[i] < 1 || s->segment_mapping[i] > MAX_SEGMENT_NUM)
+			return -EINVAL;
+	}
+
+	ret = device_create_file(&spi->dev, &dev_attr_display_text);
+	if (ret)
+		return ret;
+
+	dev_info(&spi->dev, "Configured display with %u digits and %u symbols\n",
+		 s->grid_size, num_leds);
+
+	return 0;
+}
+
+static void tm1628_spi_remove(struct spi_device *spi)
+{
+	device_remove_file(&spi->dev, &dev_attr_display_text);
+	tm1628_set_display_ctrl(spi, false);
+}
+
+static void tm1628_spi_shutdown(struct spi_device *spi)
+{
+	tm1628_set_display_ctrl(spi, false);
+}
+
+static const struct of_device_id tm1628_spi_of_matches[] = {
+	{ .compatible = "titanmec,tm1628" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, tm1628_spi_of_matches);
+
+static const struct spi_device_id tm1628_spi_id_table[] = {
+	{ "tm1628" },
+	{},
+};
+MODULE_DEVICE_TABLE(spi, tm1628_spi_id_table);
+
+static struct spi_driver tm1628_spi_driver = {
+	.probe = tm1628_spi_probe,
+	.remove = tm1628_spi_remove,
+	.shutdown = tm1628_spi_shutdown,
+	.id_table = tm1628_spi_id_table,
+
+	.driver = {
+		.name = "tm1628",
+		.of_match_table = tm1628_spi_of_matches,
+	},
+};
+module_spi_driver(tm1628_spi_driver);
+
+MODULE_DESCRIPTION("TM1628 LED controller driver");
+MODULE_AUTHOR("Andreas Färber <afaerber@suse.de>");
+MODULE_AUTHOR("Heiner Kallweit <hkallweit1@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.35.1


