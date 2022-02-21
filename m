Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8474BEBD0
	for <lists+linux-spi@lfdr.de>; Mon, 21 Feb 2022 21:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbiBUU12 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Feb 2022 15:27:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbiBUU1W (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Feb 2022 15:27:22 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8911D237CA;
        Mon, 21 Feb 2022 12:26:58 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id s24so25330150edr.5;
        Mon, 21 Feb 2022 12:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=f54s1QNFfJCjG5iDYvLw8C940im9nMlBHjJVOUqHXNc=;
        b=fvZOp6+H9iTtbujgBKUPDoxhljH2zNj4zT+xFwml+WCOQkj9OXc5aRIMCYF0s25J0V
         jdEGI5CYpLOLLlXYCihYVM/AZVN88u+HRPyQAaAnsz748Msoc5t3uQ3ojmHjZVGK1m9F
         8sHpWvG5bGpRFTGuRIWaMTlLSgJ3qrva8ZPazKzYdwRCHj125GvRfSaDxu9/29ycggnS
         BcAXAC6FBVcPDbRVv7lkCrJV4KNoqqhwxa14/wbM+Pl/jGNXbcROL0UuRgPI1HYk7xY+
         nWML1VOE61jQt1lLCW/G20mzuznJwyyoaf4va9Jb8nWyGQJl1iAcUPUvv1LccSbl4qlT
         /p9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=f54s1QNFfJCjG5iDYvLw8C940im9nMlBHjJVOUqHXNc=;
        b=72wxP/Zb29fo7RulNE8dPM0jjsJ8CkNfvyCXCpy3WIhLfFDFA9xDmLbn3dvAYfg26I
         0nPtVgjr0LOM/iusM6s0nkV+vjajMD3O1fZqQDazrz5xKMhkdRZBx33cMoA5Y3aAJYD0
         qKDSxUvW9YmzvUvtjnDiwOHUErVw6dGOYoO5MjVSrxbnYr20CFFHwXIoztcP19lpWs3Z
         W3VCrh/lEb0BFOme/IWd5EWzGImIZpMTvezry9/uHJ+54xJdqTVXvIqQaaiFKNPejLaF
         3lavOt8sR/pnZViA1v7gA7AiTf01dkun8lI2YgIH5tUXAF0psqDM5PfLoLf97vhvx8EP
         wQtA==
X-Gm-Message-State: AOAM532omOP5ByLFClu8nXRpP0UywnFbioB+J0T+dmz/OumJnq2nMSGD
        L+AwmvmcfFG54vsa13x7MaQ=
X-Google-Smtp-Source: ABdhPJyGimAPuKCSRTEHAVrEE59NMqIp9PLTnGsJ602mqHGEDhc4wpic8DIHDnBwnUwF7ELwXKxYQQ==
X-Received: by 2002:a05:6402:5242:b0:40f:6a4f:ff33 with SMTP id t2-20020a056402524200b0040f6a4fff33mr23582938edd.30.1645475217030;
        Mon, 21 Feb 2022 12:26:57 -0800 (PST)
Received: from ?IPV6:2003:ea:8f4d:2b00:b141:a0d:4aad:2a06? (p200300ea8f4d2b00b1410a0d4aad2a06.dip0.t-ipconnect.de. [2003:ea:8f4d:2b00:b141:a0d:4aad:2a06])
        by smtp.googlemail.com with ESMTPSA id p19sm5562744ejc.42.2022.02.21.12.26.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 12:26:56 -0800 (PST)
Message-ID: <3facc242-0ce6-9170-1fee-a5ec0a66660a@gmail.com>
Date:   Mon, 21 Feb 2022 21:25:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: [PATCH v2 5/6] auxdisplay: add support for Titanmec TM1628 7 segment
 display controller
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
References: <1f39432b-84e2-e6dc-a6b8-c48ad5cf2210@gmail.com>
In-Reply-To: <1f39432b-84e2-e6dc-a6b8-c48ad5cf2210@gmail.com>
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

Tested-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- include ctype.h explicitly
- add info message in probe()
- (re-)add Andreas' SoB
---
 drivers/auxdisplay/Kconfig  |  10 +
 drivers/auxdisplay/Makefile |   1 +
 drivers/auxdisplay/tm1628.c | 376 ++++++++++++++++++++++++++++++++++++
 3 files changed, 387 insertions(+)
 create mode 100644 drivers/auxdisplay/tm1628.c

diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
index 64012cda4..25ef2e452 100644
--- a/drivers/auxdisplay/Kconfig
+++ b/drivers/auxdisplay/Kconfig
@@ -203,6 +203,16 @@ config ARM_CHARLCD
 	  line and the Linux version on the second line, but that's
 	  still useful.
 
+config TM1628
+	tristate "TM1628 driver for LED 7/11 segment displays"
+	depends on SPI
+	depends on OF || COMPILE_TEST
+	help
+	  Say Y to enable support for Titan Micro Electronics TM1628
+	  LED controller.
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
index 000000000..b802b5c30
--- /dev/null
+++ b/drivers/auxdisplay/tm1628.c
@@ -0,0 +1,376 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Titan Micro Electronics TM1628 LED controller
+ *
+ * Copyright (c) 2019 Andreas Färber
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
+	u8				segment_mapping[7];
+	u8				grid[MAX_GRID_SIZE];
+	int				grid_size;
+	struct tm1628_led		leds[];
+};
+
+/* Command 1: Display Mode Setting */
+static int tm1628_set_display_mode(struct spi_device *spi, u8 grid_mode)
+{
+	u8 cmd = TM1628_CMD_DISPLAY_MODE | grid_mode;
+
+	return spi_write(spi, &cmd, 1);
+}
+
+/* Command 3: Address Setting */
+static int tm1628_set_address(struct spi_device *spi, u8 offset)
+{
+	u8 cmd = TM1628_CMD_SET_ADDRESS | (offset * sizeof(__le16));
+
+	return spi_write(spi, &cmd, 1);
+}
+
+/* Command 2: Data Setting */
+static int tm1628_write_data(struct spi_device *spi, unsigned int offset,
+			     unsigned int len)
+{
+	struct tm1628 *s = spi_get_drvdata(spi);
+	u8 cmd = TM1628_CMD_DATA | TM1628_DATA_WRITE_DATA;
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
+	int i, ret;
+
+	int msg_len = strlen(s->text);
+
+	mutex_lock(&s->disp_lock);
+
+	for (i = 0; i < s->grid_size; i++) {
+		int pos = s->grid[i] - 1;
+
+		if (i < msg_len) {
+			int char7_raw = map_to_seg7(&map_seg7, s->text[i]);
+			int j, char7;
+
+			for (j = 0, char7 = 0; j < 7; j++) {
+				if (char7_raw & BIT(j))
+					char7 |= BIT(s->segment_mapping[j] - 1);
+			}
+
+			s->data[pos] = cpu_to_le16(char7);
+		} else {
+			s->data[pos] = 0;
+		}
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
+	int offset, ret;
+	__le16 bit;
+
+	offset = led->grid - 1;
+	bit = cpu_to_le16(BIT(led->seg - 1));
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
+	int offset;
+	__le16 bit;
+	bool on;
+
+	offset = led->grid - 1;
+	bit = cpu_to_le16(BIT(led->seg - 1));
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
+	if (count > s->grid_size + 1) /* consider trailing newline */
+		return -E2BIG;
+
+	for (i = 0; i < count && isprint(buf[i]); i++)
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
+	msleep(200); /* according to TM1628 datasheet */
+
+	/* clear screen */
+	ret = tm1628_write_data(spi, 0, MAX_GRID_SIZE);
+	if (ret)
+		return ret;
+	/* Assume that subsequent SPI transfers will be ok if first was ok */
+
+	/* For now we support 6x12 mode only. This should be sufficient for most use cases */
+	tm1628_set_display_mode(spi, TM1628_DISPLAY_MODE_6_12);
+
+	tm1628_set_display_ctrl(spi, true);
+
+	if (!IS_REACHABLE(CONFIG_LEDS_CLASS))
+		goto no_leds;
+
+	num_leds = 0;
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
+	ret = device_property_count_u8(&spi->dev, "grid");
+	if (ret < 1 || ret > MAX_GRID_SIZE) {
+		dev_err(&spi->dev, "Invalid display length (%d)\n", ret);
+		return -EINVAL;
+	}
+
+	s->grid_size = ret;
+
+	ret = device_property_read_u8_array(&spi->dev, "grid", s->grid, s->grid_size);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < s->grid_size; i++) {
+		if (s->grid[i] < 1 || s->grid[i] > s->grid_size)
+			return -EINVAL;
+	}
+
+	ret = device_property_read_u8_array(&spi->dev, "segment-mapping", s->segment_mapping, 7);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < 7; i++) {
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
+MODULE_AUTHOR("Andreas Färber");
+MODULE_LICENSE("GPL");
-- 
2.35.1


