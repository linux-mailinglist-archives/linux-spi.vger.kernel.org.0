Return-Path: <linux-spi+bounces-10052-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27371B59C24
	for <lists+linux-spi@lfdr.de>; Tue, 16 Sep 2025 17:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FFE37B2083
	for <lists+linux-spi@lfdr.de>; Tue, 16 Sep 2025 15:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE2935E4F5;
	Tue, 16 Sep 2025 15:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3XGxX1I"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39041341AD5;
	Tue, 16 Sep 2025 15:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758036858; cv=none; b=CNREy3j85QDILnY440PAHa+7bxPHspx2PSDlDyd+JjtgmqPmGrU6fbVmVYMV0F4BVKC7nviYM70jvbS0gg+HcYhBXXY4Qxf7mG5aSarPCPXDaN+Ka67P+rPYveisZQZHI4l10U2xr2546ufQpt7Nm7MwbPdYe+AUKV0ysSS22RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758036858; c=relaxed/simple;
	bh=CSBkUjub67efmm+dZ0+ev+/aVhyibKtn93MDK16vM+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5rZc3AKQX0j77WYeM5yK1jV3alXGiuXGK6WgWh9haya15IayhDgro5GUeRiORZ4FFk6yIetqUnSl6QzqcDGA1U5mQM8iEToZLv8DqMt6BLDJydWHh8Qc41fINFRyQ5R59CXB81sui5lfOUAK/z2mnY9/Iaul2UmJLG4/OEZcoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3XGxX1I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41357C4CEFF;
	Tue, 16 Sep 2025 15:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758036857;
	bh=CSBkUjub67efmm+dZ0+ev+/aVhyibKtn93MDK16vM+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r3XGxX1IoUtmLul746VfMmI0op1MaRxXBr8lvNoX/zSqWdflKzw6W9j0COxrCulGJ
	 FGGPOzpZC66bV3t3grj+0mafM3Jjw3MJ5oRH+rioYk8vkKAH2Hlwqy7cxCz95FBQnj
	 PD7LjzlDBNHNmacUU0wk4HmLwHhKvYDVc3UaPMaenw0VDunRSky02JGzIhPdj28lOG
	 fr+VzFdTFCBt2zRDzrmOHr14dO7d0K/81xaVggphbf9oYesb6SH6+DmYW4c/9JPja5
	 C6auoj9EzCkDbIssYi8imbBWlFGmaz4sUAo/pDqbEH4YtbnI2Js/FsMC65EQpuhWZi
	 L9txz+BK5h3jw==
Date: Tue, 16 Sep 2025 16:34:12 +0100
From: Lee Jones <lee@kernel.org>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Pavel Machek <pavel@ucw.cz>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Steffen Trumtrar <kernel@pengutronix.de>,
	Pavel Machek <pavel@kernel.org>, Mark Brown <broonie@kernel.org>,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] leds: add support for TI LP5860 LED driver chip
Message-ID: <20250916153412.GA3837873@google.com>
References: <20250911-v6-14-topic-ti-lp5860-v3-0-390738ef9d71@pengutronix.de>
 <20250911-v6-14-topic-ti-lp5860-v3-2-390738ef9d71@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250911-v6-14-topic-ti-lp5860-v3-2-390738ef9d71@pengutronix.de>

On Thu, 11 Sep 2025, Steffen Trumtrar wrote:

> Add support for the Texas Instruments LP5860 LED driver chip
> via SPI interfaces.
> 
> The LP5860 is an LED matrix driver for up to 196 LEDs, which supports
> short and open detection of the individual channel select lines.
> 
> It can be connected to SPI or I2C bus. For now add support for SPI only.
> 
> The original driver is from an unknown author at Texas Instruments. Only
> the cryptic handle 'zlzx' is known.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  drivers/leds/Kconfig                      |  28 +++
>  drivers/leds/Makefile                     |   2 +
>  drivers/leds/leds-lp5860-core.c           | 222 ++++++++++++++++++++++
>  drivers/leds/leds-lp5860-spi.c            |  90 +++++++++
>  include/linux/platform_data/leds-lp5860.h | 305 ++++++++++++++++++++++++++++++
>  5 files changed, 647 insertions(+)
> 
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index 6e3dce7e35a490df050cb4cd8e98611028c8dce1..6e1dd25e46c7b541b7d640026293b71d5c0e86ff 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -490,6 +490,34 @@ config LEDS_LP5569
>  	  Driver provides direct control via LED class and interface for
>  	  programming the engines.
>  
> +config LEDS_LP5860_CORE
> +	tristate "Core Driver for TI LP5860"
> +	depends on LEDS_CLASS
> +	depends on LEDS_CLASS_MULTICOLOR

Should this be in drivers/leds/rgb?

> +	depends on OF
> +	select FW_LOADER
> +	select FW_LOADER_USER_HELPER
> +	select REGMAP
> +	help
> +	  This option supports common operations for LP5860 devices.
> +	  The lp5860 is a LED matrix driver with 18 constant current

"LP5860"

> +	  sinks and 11 scan switches for 198 LED dots. Each dot can be
> +	  controlled individually and supports 8/16-bit PWM dimming.
> +	  The chip supports individual LED open and short detection.
> +
> +	  The device can be used with SPI or I2C bus.
> +
> +config LEDS_LP5860_SPI
> +	tristate "LED Support for TI LP5860 SPI LED driver chip"
> +	depends on SPI
> +	depends on LEDS_LP5860_CORE
> +	help
> +	  If you say yes here you get support for the Texas Instruments
> +	  LP5860 LED driver for SPI bus connections.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called lp5860_spi.
> +
>  config LEDS_LP8501
>  	tristate "LED Support for TI LP8501 LED driver chip"
>  	depends on LEDS_CLASS && I2C
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index 9a0333ec1a861e4f543e7525a4a6d519b2e2a1e8..6323efeb54804710b8801e32c81e9dd08263cbc7 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -55,6 +55,8 @@ obj-$(CONFIG_LEDS_LP5523)		+= leds-lp5523.o
>  obj-$(CONFIG_LEDS_LP5562)		+= leds-lp5562.o
>  obj-$(CONFIG_LEDS_LP5569)		+= leds-lp5569.o
>  obj-$(CONFIG_LEDS_LP55XX_COMMON)	+= leds-lp55xx-common.o
> +obj-$(CONFIG_LEDS_LP5860_CORE)		+= leds-lp5860-core.o
> +obj-$(CONFIG_LEDS_LP5860_SPI)		+= leds-lp5860-spi.o
>  obj-$(CONFIG_LEDS_LP8501)		+= leds-lp8501.o
>  obj-$(CONFIG_LEDS_LP8788)		+= leds-lp8788.o
>  obj-$(CONFIG_LEDS_LP8860)		+= leds-lp8860.o
> diff --git a/drivers/leds/leds-lp5860-core.c b/drivers/leds/leds-lp5860-core.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..37418859b033ceaa6e26e2723c0e365f3a9a766e
> --- /dev/null
> +++ b/drivers/leds/leds-lp5860-core.c
> @@ -0,0 +1,222 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2025 Pengutronix
> + *
> + * Author: Steffen Trumtrar <kernel@pengutronix.de

Malformed.

> + */
> +
> +#include <linux/gpio.h>
> +#include <linux/led-class-multicolor.h>
> +#include <linux/module.h>
> +#include <linux/of_gpio.h>
> +#include <linux/of_platform.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/platform_data/leds-lp5860.h>
> +
> +static struct lp5860_led *mcled_cdev_to_led(struct led_classdev_mc *mc_cdev)
> +{
> +	return container_of(mc_cdev, struct lp5860_led, mc_cdev);
> +}
> +
> +LP5860_SHOW_MODE(r_global_brightness_set, LP5860_REG_R_CURRENT_SET, LP5860_CC_GROUP_MASK, 0)
> +LP5860_STORE_MODE(r_global_brightness_set, LP5860_REG_R_CURRENT_SET, LP5860_CC_GROUP_MASK, 0)
> +DEVICE_ATTR_RW(r_global_brightness_set);

How is this different to /sys/class/leds/<led>/multi_intensity?

# echo 43 226 138 > /sys/class/leds/multicolor:status/multi_intensity
red -
    intensity = 138
    max_brightness = 255
green -
    intensity = 43
    max_brightness = 255
blue -
    intensity = 226
    max_brightness = 255

> +LP5860_SHOW_MODE(g_global_brightness_set, LP5860_REG_G_CURRENT_SET, LP5860_CC_GROUP_MASK, 0)
> +LP5860_STORE_MODE(g_global_brightness_set, LP5860_REG_G_CURRENT_SET, LP5860_CC_GROUP_MASK, 0)
> +DEVICE_ATTR_RW(g_global_brightness_set);
> +
> +LP5860_SHOW_MODE(b_global_brightness_set, LP5860_REG_B_CURRENT_SET, LP5860_CC_GROUP_MASK, 0)
> +LP5860_STORE_MODE(b_global_brightness_set, LP5860_REG_B_CURRENT_SET, LP5860_CC_GROUP_MASK, 0)
> +DEVICE_ATTR_RW(b_global_brightness_set);
> +
> +static struct attribute *lp5860_attributes[] = {
> +	&dev_attr_r_global_brightness_set.attr,
> +	&dev_attr_g_global_brightness_set.attr,
> +	&dev_attr_b_global_brightness_set.attr,
> +	NULL,
> +};


> +static const struct attribute_group lp5860_group = {
> +	.attrs = lp5860_attributes,
> +};

ATTRIBUTE_GROUPS()?

> +static int lp5860_set_dotonoff(struct lp5860_led *led, unsigned int dot, bool enable)
> +{
> +	unsigned int offset = dot / LP5860_MAX_DOT_ONOFF_GROUP_NUM;
> +	unsigned int mask = BIT(dot % LP5860_MAX_DOT_ONOFF_GROUP_NUM);
> +
> +	if (dot > LP5860_REG_DOT_ONOFF_MAX)
> +		return -EINVAL;
> +
> +	return regmap_update_bits(led->priv->regmap,
> +				  LP5860_REG_DOT_ONOFF_START + offset, mask,
> +				  enable ? 0xff : 0);

What does 0xff mean in this context?  #define?

> +}
> +
> +static int lp5860_set_mc_brightness(struct led_classdev *cdev,
> +				    enum led_brightness brightness)
> +{
> +	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(cdev);
> +	struct lp5860_led *led = mcled_cdev_to_led(mc_cdev);
> +	int i;
> +
> +	led_mc_calc_color_components(mc_cdev, brightness);
> +
> +	for (i = 0; i < led->mc_cdev.num_colors; i++) {
> +		unsigned int channel = mc_cdev->subled_info[i].channel;
> +		unsigned int led_brightness = mc_cdev->subled_info[i].brightness;
> +		int ret;
> +
> +		ret = lp5860_set_dotonoff(led, channel, led_brightness);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_write(led->priv->regmap,
> +				   LP5860_REG_PWM_BRI_START + channel,
> +				   led_brightness);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int lp5860_enable_toggle(struct lp5860 *led, int enable)
> +{
> +	return regmap_write(led->regmap, LP5860_REG_CHIP_EN, enable);
> +}
> +
> +static int lp5860_led_init_default_state(struct lp5860_led *led,
> +					 unsigned int channel)
> +{
> +	unsigned int brightness;
> +	int ret;
> +
> +	ret = regmap_read(led->priv->regmap, LP5860_REG_PWM_BRI_START + channel,
> +			  &brightness);

Use up to 100-chars.

> +
> +	switch (led->default_state) {
> +	case LEDS_DEFSTATE_ON:
> +		led->brightness = LP5860_MAX_BRIGHTNESS;
> +		break;
> +	case LEDS_DEFSTATE_KEEP:
> +		led->brightness = min(brightness, LP5860_MAX_BRIGHTNESS);
> +		break;
> +	default:
> +		led->brightness = 0;
> +		break;
> +	}
> +
> +	return lp5860_set_mc_brightness(&led->mc_cdev.led_cdev, led->brightness);
> +}
> +
> +static int lp5860_init_dt(struct lp5860 *lp)
> +{
> +	struct led_init_data init_data = {};
> +	struct led_classdev *led_cdev;
> +	struct mc_subled *mc_led_info;
> +	struct lp5860_led *led;
> +	int chan;
> +	int i = 0;
> +	int ret;
> +
> +	device_for_each_child_node_scoped(lp->dev, multi_led) {
> +		struct fwnode_handle *led_node = NULL;
> +
> +		led = &lp->leds[i];
> +
> +		init_data.fwnode = multi_led;
> +
> +		/* count the number of channels in this multi_led */

Sentences start with uppercase chars.

This and all other comments.

> +		chan = fwnode_get_child_node_count(multi_led);
> +		if (!chan || chan > LP5860_MAX_LED_CHANNELS)
> +			return -EINVAL;
> +
> +		led->mc_cdev.num_colors = chan;
> +
> +		mc_led_info = devm_kcalloc(lp->dev, chan, sizeof(*mc_led_info),
> +					   GFP_KERNEL);

Unwrap this - and all similar lines.

> +		if (!mc_led_info)
> +			return -ENOMEM;
> +
> +		led->priv = lp;
> +		led->mc_cdev.subled_info = mc_led_info;
> +		led->default_state = led_init_default_state_get(init_data.fwnode);
> +		led_cdev = &led->mc_cdev.led_cdev;
> +		led_cdev->max_brightness = LP5860_MAX_BRIGHTNESS;
> +		led_cdev->brightness_set_blocking = lp5860_set_mc_brightness;
> +
> +		chan = 0;
> +		/* initialize all channels of this multi_led */
> +		fwnode_for_each_child_node(multi_led, led_node) {
> +			u32 channel;
> +			u32 color_index;
> +
> +			ret = fwnode_property_read_u32(led_node, "color",
> +						       &color_index);
> +			if (ret) {
> +				fwnode_handle_put(led_node);
> +				dev_err(lp->dev, "Cannot read 'color'\n");

... property.

> +				return ret;
> +			}
> +
> +			ret = fwnode_property_read_u32(led_node, "reg",
> +						       &channel);
> +			if (ret < 0) {
> +				dev_err(lp->dev, "'reg' property is invalid\n");

Is it?  Or is it missing?

> +				return ret;
> +			}
> +
> +			mc_led_info[chan].color_index = color_index;
> +			mc_led_info[chan].channel = channel;
> +			lp5860_led_init_default_state(led, chan);
> +
> +			chan++;
> +		}
> +
> +		ret = devm_led_classdev_multicolor_register_ext(lp->dev, &led->mc_cdev,
> +								&init_data);
> +		if (ret) {
> +			dev_err(lp->dev, "LED register err: %d\n", ret);

In English please.  "Failed to register Multi-Colour LEDs".

> +			return ret;
> +		}
> +		i++;
> +	}
> +
> +	return 0;
> +}
> +
> +int lp5860_device_init(struct lp5860 *lp)

lp?  Suggest 'ddata' or pass through 'dev' and pull this out using dev_get_drvdata().

> +{
> +	int ret;
> +
> +	ret = lp5860_enable_toggle(lp, LP5860_CHIP_ENABLE);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(lp->regmap, LP5860_REG_DEV_INITIAL,
> +				 LP5860_MODE_MASK,
> +				 LP5860_MODE_1 << LP5860_MODE_OFFSET);

If what you're doing isn't obvious by the nomenclature, please add a comment.

> +	if (ret < 0)
> +		return ret;
> +
> +	ret = sysfs_create_group(&lp->dev->kobj, &lp5860_group);
> +	if (ret)
> +		return ret;
> +
> +	return lp5860_init_dt(lp);
> +}
> +
> +void lp5860_device_remove(struct device *dev)
> +{
> +	struct lp5860 *lp = dev_get_drvdata(dev);
> +	int err;
> +
> +	err = lp5860_enable_toggle(lp, LP5860_CHIP_DISABLE);
> +	if (err)
> +		dev_err(lp->dev, "Failed to disable chip\n");

... during remove.

> +
> +	sysfs_remove_group(&dev->kobj, &lp5860_group);
> +}
> diff --git a/drivers/leds/leds-lp5860-spi.c b/drivers/leds/leds-lp5860-spi.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..5c8618ba11db1b541edfcbb1d156e52c7e76e35e
> --- /dev/null
> +++ b/drivers/leds/leds-lp5860-spi.c
> @@ -0,0 +1,90 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2025 Pengutronix
> + *
> + * Author: Steffen Trumtrar <kernel@pengutronix.de
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +
> +#include <linux/platform_data/leds-lp5860.h>
> +
> +#define LP5860_SPI_WRITE_FLAG BIT(5)
> +
> +static const struct regmap_config lp5860_regmap_config = {
> +	.name = "lp5860-spi",
> +	.reg_bits = 10,
> +	.pad_bits = 6,
> +	.val_bits = 8,
> +	.write_flag_mask = (__force unsigned long)cpu_to_be16(LP5860_SPI_WRITE_FLAG),
> +	.reg_format_endian = REGMAP_ENDIAN_BIG,
> +	.max_register = LP5860_MAX_REG,
> +};
> +
> +static int lp5860_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct lp5860 *lp5860;
> +	unsigned int multi_leds;
> +
> +	multi_leds = device_get_child_node_count(dev);
> +	if (!multi_leds) {
> +		dev_err(dev, "LEDs are not defined in device tree!");

Device Tree.

> +		return -ENODEV;
> +	}
> +
> +	if (multi_leds > LP5860_MAX_LED) {
> +		dev_err(dev, "too many LEDs specified\n");

Consistency - to upper-case or not to upper-case?

> +		return -EINVAL;
> +	}
> +
> +	lp5860 = devm_kzalloc(dev, struct_size(lp5860, leds, multi_leds),
> +			      GFP_KERNEL);
> +	if (!lp5860)
> +		return -ENOMEM;
> +
> +	lp5860->leds_count = multi_leds;
> +
> +	spi_set_drvdata(spi, lp5860);

Doing this half-way through population feels odd.  Do it last.

> +	lp5860->regmap = devm_regmap_init_spi(spi, &lp5860_regmap_config);
> +	if (IS_ERR(lp5860->regmap)) {
> +		dev_err(&spi->dev, "regmap init failed.\n");

"Failed to initialise Regmap"

> +		return PTR_ERR(lp5860->regmap);
> +	}
> +
> +	lp5860->dev = dev;
> +
> +	return lp5860_device_init(lp5860);
> +}
> +
> +static void lp5860_remove(struct spi_device *spi)
> +{
> +	lp5860_device_remove(&spi->dev);
> +}
> +
> +static const struct of_device_id lp5860_of_match[] = {
> +	{ .compatible = "ti,lp5860" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, lp5860_of_match);
> +
> +static struct spi_driver lp5860_driver = {
> +	.driver = {
> +		.name = "lp5860",

"-spi" here too?

> +		.of_match_table = lp5860_of_match,
> +	},
> +	.probe	= lp5860_probe,
> +	.remove = lp5860_remove,
> +};
> +

Remove this line.

> +module_spi_driver(lp5860_driver);
> +
> +MODULE_AUTHOR("Steffen Trumtrar <kernel@pengutronix.de>");
> +MODULE_DESCRIPTION("TI LP5860 RGB LED driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/platform_data/leds-lp5860.h b/include/linux/platform_data/leds-lp5860.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..3e0c26b31360824d4aaf8d48c2c5ecaec51e3627
> --- /dev/null
> +++ b/include/linux/platform_data/leds-lp5860.h
> @@ -0,0 +1,305 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2025 Pengutronix
> + *
> + * Author: Steffen Trumtrar <kernel@pengutronix.de
> + */
> +
> +#ifndef _LEDS_LP5860_COMMON_H
> +#define _LEDS_LP5860_COMMON_H
> +
> +#include <linux/regmap.h>
> +#include <linux/led-class-multicolor.h>
> +
> +#define LP5860_REG_CHIP_EN		0x00
> +#define LP5860_REG_DEV_INITIAL		0x01
> +#define LP5860_REG_DEV_CONFIG1		0x02
> +#define LP5860_REG_DEV_CONFIG2		0x03
> +#define LP5860_REG_DEV_CONFIG3		0x04
> +#define LP5860_REG_GLOBAL_BRI		0x05
> +#define LP5860_REG_GROUP0_BRI		0x06
> +#define LP5860_REG_GROUP1_BRI		0x07
> +#define LP5860_REG_GROUP2_BRI		0x08
> +#define LP5860_REG_R_CURRENT_SET	0x09
> +#define LP5860_REG_G_CURRENT_SET	0x0A
> +#define LP5860_REG_B_CURRENT_SET	0x0B
> +#define LP5860_REG_GRP_SEL_START	0x0C
> +#define LP5860_REG_DOT_ONOFF_START	0x43
> +#define LP5860_REG_DOT_ONOFF_MAX	0x63
> +#define LP5860_REG_FAULT_STATE		0x64
> +#define LP5860_REG_DOT_LOD_START	0x65
> +#define LP5860_REG_DOT_LSD_START	0x86
> +#define LP5860_REG_LOD_CLEAR		0xA7
> +#define LP5860_REG_LSD_CLEAR		0xA8
> +#define LP5860_REG_RESET		0xA9
> +#define LP5860_REG_DC_START		0x0100
> +#define LP5860_REG_PWM_BRI_START	0x0200
> +#define LP5860_MAX_REG			0x038B
> +
> +/* Register chip_enable Value */
> +#define LP5860_CHIP_OFFSET		0
> +#define LP5860_CHIP_MASK		BIT(0)
> +#define LP5860_CHIP_DISABLE		0x00
> +#define LP5860_CHIP_ENABLE		0x01
> +
> +/* Register Dev_initial Value */
> +#define LP5860_MAX_LINE_OFFSET		3
> +#define LP5860_MAX_LINE_MASK		GENMASK(6, 3)
> +#define LP5860_MAX_LINE_11		0x0B
> +#define LP5860_MAX_LINE_10		0x0A
> +#define LP5860_MAX_LINE_9		0x09
> +#define LP5860_MAX_LINE_8		0x08
> +#define LP5860_MAX_LINE_7		0x07
> +#define LP5860_MAX_LINE_6		0x06
> +#define LP5860_MAX_LINE_5		0x05
> +#define LP5860_MAX_LINE_4		0x04
> +#define LP5860_MAX_LINE_3		0x03
> +#define LP5860_MAX_LINE_2		0x02
> +#define LP5860_MAX_LINE_1		0x01
> +
> +#define LP5860_MODE_OFFSET		1
> +#define LP5860_MODE_MASK		GENMASK(2, 1)
> +#define LP5860_MODE_3_1			0x03
> +#define LP5860_MODE_3			0x02
> +#define LP5860_MODE_2			0x01
> +#define LP5860_MODE_1			0x00
> +
> +#define LP5860_PWM_FREQUENCY_OFFSET	0
> +#define LP5860_PWM_FREQUENCY_MASK	BIT(0)
> +#define LP5860_PWM_FREQUENCY_62_5K	0x01
> +#define LP5860_PWM_FREQUENCY_125K	0x00
> +
> +/* *Register Dev_config1 Valu */
> +#define LP5860_SW_BLK_OFFSET		3
> +#define LP5860_SW_BLK_MASK		BIT(3)
> +#define LP5860_SW_BLK_05US		0x01
> +#define LP5860_SW_BLK_1US		0x00
> +
> +#define LP5860_PWM_SCALE_MODE_OFFSET	2
> +#define LP5860_PWM_SCALE_MODE_MASK	BIT(2)
> +#define LP5860_PWM_SCALE_EXPONENTIAL	0x01
> +#define LP5860_PWM_SCALE_LINEAR		0x00
> +
> +#define LP5860_PWM_PHASESHIFT_OFFSET	1
> +#define LP5860_PWM_PHASESHIFT_MASK	BIT(1)
> +#define LP5860_PWM_PHASESHIFT_ON	0x01
> +#define LP5860_PWM_PHASESHIFT_OFF	0x00
> +
> +#define LP5860_CS_ON_SHIFT_OFFSET	0
> +#define LP5860_CS_ON_SHIFT_MASK		BIT(0)
> +#define LP5860_CS_DELAY_ON		0x01
> +#define LP5860_CS_DELAY_OFF		0x00
> +
> +/* Register Dev_config2 Value */
> +#define LP5860_COMP_GROUP3_OFFSET	6
> +#define LP5860_COMP_GROUP3_MASK		GENMASK(7, 6)
> +#define LP5860_COMP_GROUP3_3CLOCK	0x03
> +#define LP5860_COMP_GROUP3_2CLOCK	0x02
> +#define LP5860_COMP_GROUP3_1CLOCK	0x01
> +#define LP5860_COMP_GROUP3_OFF		0x00
> +
> +#define LP5860_COMP_GROUP2_OFFSET	4
> +#define LP5860_COMP_GROUP2_MASK		GENMASK(5, 4)
> +#define LP5860_COMP_GROUP2_3CLOCK	0x03
> +#define LP5860_COMP_GROUP2_2CLOCK	0x02
> +#define LP5860_COMP_GROUP2_1CLOCK	0x01
> +#define LP5860_COMP_GROUP2_OFF		0x00
> +
> +#define LP5860_COMP_GROUP1_OFFSET	2
> +#define LP5860_COMP_GROUP1_MASK		GENMASK(3, 2)
> +#define LP5860_COMP_GROUP1_3CLOCK	0x03
> +#define LP5860_COMP_GROUP1_2CLOCK	0x02
> +#define LP5860_COMP_GROUP1_1CLOCK	0x01
> +#define LP5860_COMP_GROUP1_OFF		0x00
> +
> +#define LP5860_LOD_REMOVAL_OFFSET	1
> +#define LP5860_LOD_REMOVAL_MASK		BIT(1)
> +#define LP5860_LOD_REMOVAL_EN		0x01
> +#define LP5860_LOD_REMOVAL_OFF		0x00
> +
> +#define LP5860_LSD_REMOVAL_OFFSET	0
> +#define LP5860_LSD_REMOVAL_MASK		BIT(0)
> +#define LP5860_LSD_REMOVAL_EN		0x01
> +#define LP5860_LSD_REMOVAL_OFF		0x00
> +
> +/* Register Dev_config3 Value */
> +#define LP5860_DOWN_DEGHOST_OFFSET	6
> +#define LP5860_DOWN_DEGHOST_MASK	GENMASK(7, 6)
> +#define LP5860_DOWN_DEGHOST_STRONG	0x03
> +#define LP5860_DOWN_DEGHOST_MEDIUM	0x02
> +#define LP5860_DOWN_DEGHOST_WEAK	0x01
> +#define LP5860_DOWN_DEGHOST_OFF		0x00
> +
> +#define LP5860_UP_DEGHOST_OFFSET	4
> +#define LP5860_UP_DEGHOST_MASK		GENMASK(5, 4)
> +#define LP5860_UP_DEGHOST_GND		0x03
> +#define LP5860_UP_DEGHOST_3		0x02
> +#define LP5860_UP_DEGHOST_2_5		0x01
> +#define LP5860_UP_DEGHOST_2		0x00
> +
> +#define LP5860_MAXIMUM_CURRENT_OFFSET	1
> +#define LP5860_MAXIMUM_CURRENT_MASK	GENMASK(3, 1)
> +#define LP5860_MAXIMUM_CURRENT_50	0x07
> +#define LP5860_MAXIMUM_CURRENT_40	0x06
> +#define LP5860_MAXIMUM_CURRENT_30	0x05
> +#define LP5860_MAXIMUM_CURRENT_20	0x04
> +#define LP5860_MAXIMUM_CURRENT_15	0x03
> +#define LP5860_MAXIMUM_CURRENT_10	0x02
> +#define LP5860_MAXIMUM_CURRENT_5	0x01
> +#define LP5860_MAXIMUM_CURRENT_3	0x00
> +
> +#define LP5860_UP_DEGHOST_ENABLE_OFFSET	0
> +#define LP5860_UP_DEGHOST_ENABLE_MASK	BIT(0)
> +#define LP5860_UP_DEGHOST_ENABLE_EN	0x01
> +#define LP5860_UP_DEGHOST_ENABLE_OFF	0x00
> +
> +/* Register PWM */
> +#define LP5860_PWM_GLOBAL_MAX		0xff
> +#define LP5860_PWM_GROUP_MAX		0xff
> +
> +/* Register CC GROUP select */
> +#define LP5860_CC_GROUP_MASK		GENMASK(7, 0)
> +#define LP5860_CC_GROUP_MAX		0x7F
> +
> +/* Register dot group select */
> +#define LP5860_DOT_0_OFFSET		0
> +#define LP5860_DOT_1_OFFSET		2
> +#define LP5860_DOT_2_OFFSET		4
> +#define LP5860_DOT_3_OFFSET		6
> +
> +#define LP5860_DOT_GROUP3		0x03
> +#define LP5860_DOT_GROUP2		0x02
> +#define LP5860_DOT_GROUP1		0x01
> +#define LP5860_DOT_GROUP_NONE		0x00
> +
> +#define LP5860_PWM_DOT_MAX		0xff
> +/* dot onoff Value */
> +#define LP5860_DOT_CS0_OFFSET		0
> +#define LP5860_DOT_CS1_OFFSET		1
> +#define LP5860_DOT_CS2_OFFSET		2
> +#define LP5860_DOT_CS3_OFFSET		3
> +#define LP5860_DOT_CS4_OFFSET		4
> +#define LP5860_DOT_CS5_OFFSET		5
> +#define LP5860_DOT_CS6_OFFSET		6
> +#define LP5860_DOT_CS7_OFFSET		7
> +
> +#define LP5860_DOT_CS_ON		0x01
> +#define LP5860_DOT_CS_OFF		0x00
> +
> +/* dot lod Value */
> +#define LP5860_DOT_LOD0_OFFSET		0
> +#define LP5860_DOT_LOD1_OFFSET		1
> +#define LP5860_DOT_LOD2_OFFSET		2
> +#define LP5860_DOT_LOD3_OFFSET		3
> +#define LP5860_DOT_LOD4_OFFSET		4
> +#define LP5860_DOT_LOD5_OFFSET		5
> +#define LP5860_DOT_LOD6_OFFSET		6
> +#define LP5860_DOT_LOD7_OFFSET		7
> +
> +#define LP5860_DOT_LOD_ON		0x01
> +#define LP5860_DOT_LOD_OFF		0x00
> +
> +/* dot lsd Value */
> +#define LP5860_DOT_LSD0_OFFSET		0
> +#define LP5860_DOT_LSD1_OFFSET		1
> +#define LP5860_DOT_LSD2_OFFSET		2
> +#define LP5860_DOT_LSD3_OFFSET		3
> +#define LP5860_DOT_LSD4_OFFSET		4
> +#define LP5860_DOT_LSD5_OFFSET		5
> +#define LP5860_DOT_LSD6_OFFSET		6
> +#define LP5860_DOT_LSD7_OFFSET		7
> +
> +#define LP5860_DOT_LSD_ON		0x01
> +#define LP5860_DOT_LSD_OFF		0x00
> +
> +/* REG FAULT_STATE */
> +#define LP5860_GLOBAL_LOD_OFFSET	1
> +#define LP5860_GLOBAL_LOD_STATE		BIT(1)
> +#define LP5860_GLOBAL_LSD_OFFSET	0
> +#define LP5860_GLOBAL_LSD_STATE		BIT(0)
> +
> +#define LP5860_FAULT_STATE_ON		0x01
> +#define LP5860_FAULT_STATE_OFF		0x00
> +
> +/* REG FAULT_STATE */
> +#define LP5860_GLOBAL_LOD_CELAR		0x00
> +#define LP5860_GLOBAL_LSD_CELAR		0x00
> +
> +
> +#define LP5860_LOD_CLEAR_EN		0xff
> +#define LP5860_LSD_CLEAR_EN		0xff
> +#define LP5860_RESET_EN			0xff
> +
> +#define LP5860_MAX_BRIGHTNESS		255
> +#define LP5860_REG_R_PWM		0x0
> +#define LP5860_REG_G_PWM		0x1
> +#define LP5860_REG_B_PWM		0x2
> +
> +#define LP5860_MAX_LED_CONSTANT		18
> +#define LP5860_MAX_LED_SCAN		11
> +#define LP5860_MAX_LED			(LP5860_MAX_LED_CONSTANT * LP5860_MAX_LED_SCAN)
> +
> +#define LP5860_MAX_DOT_ONOFF_GROUP_NUM	8
> +
> +/*
> + * Theoretically, there is no max channel per LED,
> + * limit this to a reasonable value for RGBW LEDs
> + */
> +#define LP5860_MAX_LED_CHANNELS		4
> +
> +#define LP5860_DEV_ATTR_RW(name)	\
> +	DEVICE_ATTR(name, 0644, lp5860_##name##_show, lp5860_##name##_store)
> +
> +#define LP5860_SHOW_MODE(nr, reg, mask, offset)				\
> +	static ssize_t nr##_show(struct device *dev,			\
> +				 struct device_attribute *attr,		\
> +				 char *buf)				\
> +	{								\
> +		struct lp5860 *led = dev_get_drvdata(dev);		\
> +		unsigned int value = 0;					\
> +		int ret;						\
> +									\
> +		ret = regmap_read(led->regmap, reg, &value);		\
> +		if (ret)						\
> +			return ret;					\
> +		return sysfs_emit(buf, "%d\n", (value & (int)mask) >> (int)offset);\
> +	}
> +
> +#define LP5860_STORE_MODE(nr, reg, mask, offset)			\
> +	static ssize_t nr##_store(struct device *dev,			\
> +				  struct device_attribute *attr,	\
> +				  const char *buf, size_t len) 		\
> +	{								\
> +		struct lp5860 *led = dev_get_drvdata(dev);		\
> +		unsigned int value = 0;					\
> +		int ret;						\
> +									\
> +		if (kstrtoint(buf, 0, &value))				\
> +			return -EINVAL;					\
> +		ret = regmap_update_bits(led->regmap, reg, (int)mask,	\
> +					 value << (int)offset);		\
> +		if (ret < 0)						\
> +			return ret;					\
> +		return len;						\
> +	}
> +
> +struct lp5860_led {
> +	struct lp5860 *priv;

Now it's called 'priv'?  Suggest you stick with ddata.

> +	struct led_classdev_mc mc_cdev;
> +	u8 led_current;

What other current could it be?

We're not saying led_brightness below.  What's the difference?

> +	u8 brightness;
> +	enum led_default_state default_state;
> +};
> +
> +struct lp5860 {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	unsigned int leds_count;
> +
> +	DECLARE_FLEX_ARRAY(struct lp5860_led, leds);
> +};
> +
> +int lp5860_device_init(struct lp5860 *lp5860);

Make this 'dev' as well and be done with it.

> +void lp5860_device_remove(struct device *dev);
> +
> +#endif /* _LEDS_LP5860_H */
> 
> -- 
> 2.49.0
> 
> 

-- 
Lee Jones [李琼斯]

