Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1998539426E
	for <lists+linux-spi@lfdr.de>; Fri, 28 May 2021 14:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236474AbhE1MU5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 May 2021 08:20:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:49004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236267AbhE1MU4 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 28 May 2021 08:20:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5ADFB60FF3;
        Fri, 28 May 2021 12:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622204350;
        bh=fR278QD1iF89zk1iRlrF0Qgx6DyVjgzUYr2Q3YdusZ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZLr2RXKZVoTE6VJxO0RbjLIAW+lIVZhmmS7XsTPELq0eRTq+QuEJ3dwDwRxElwZq3
         4N8eU6GQlBsi3PDlOd1qo6O9ZppJwkMMiZdn1vC9waaxZq4jxAOuBpDPP09WqhkduF
         BNYEO9qkCjgeKZ06ZPjOsiWIF/I8fKFPIDuB43ik=
Date:   Fri, 28 May 2021 14:19:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Ian Ray <ian.ray@ge.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv3 5/5] misc: gehc-achc: new driver
Message-ID: <YLDfvD1nLgWqEavS@kroah.com>
References: <20210528113346.37137-1-sebastian.reichel@collabora.com>
 <20210528113346.37137-6-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528113346.37137-6-sebastian.reichel@collabora.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 28, 2021 at 01:33:47PM +0200, Sebastian Reichel wrote:
> General Electric Healthcare's PPD has a secondary processor from
> NXP's Kinetis K20 series. That device has two SPI chip selects:
> 
> The main interface's behaviour depends on the loaded firmware
> and is exposed to userspace (as before).
> 
> The secondary interface can be used to update the firmware using
> EzPort protocol. This is implemented by this driver using the
> kernel's firmware API. It's not done during probe time, since
> the device has non-volatile memory and flashing lasts almost 3
> minutes.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/misc/Kconfig                     |  15 +
>  drivers/misc/Makefile                    |   2 +
>  drivers/misc/gehc-achc.c                 | 160 ++++++++
>  drivers/misc/nxp-ezport.c                | 476 +++++++++++++++++++++++
>  drivers/spi/spidev.c                     |   7 +-
>  include/linux/platform_data/nxp-ezport.h |   9 +
>  include/linux/spi/spi.h                  |   5 +
>  7 files changed, 671 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/misc/gehc-achc.c
>  create mode 100644 drivers/misc/nxp-ezport.c
>  create mode 100644 include/linux/platform_data/nxp-ezport.h
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index f4fb5c52b863..f058b551a7b1 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -208,6 +208,21 @@ config CS5535_CLOCK_EVENT_SRC
>  	  MFGPTs have a better resolution and max interval than the
>  	  generic PIT, and are suitable for use as high-res timers.
>  
> +config NXP_EZPORT
> +	tristate
> +
> +config GEHC_ACHC
> +	tristate "GEHC ACHC support"
> +	depends on SPI && SYSFS && SPI_SPIDEV
> +	select FW_LOADER
> +	select NXP_EZPORT
> +	help
> +	  Support for GE ACHC microcontroller, that is part of the GE
> +	  CS One device.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called gehc-achc.
> +
>  config HP_ILO
>  	tristate "Channel interface driver for the HP iLO processor"
>  	depends on PCI
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index e92a56d4442f..b7bad5a16c8f 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -24,6 +24,8 @@ obj-$(CONFIG_KGDB_TESTS)	+= kgdbts.o
>  obj-$(CONFIG_SGI_XP)		+= sgi-xp/
>  obj-$(CONFIG_SGI_GRU)		+= sgi-gru/
>  obj-$(CONFIG_CS5535_MFGPT)	+= cs5535-mfgpt.o
> +obj-$(CONFIG_NXP_EZPORT)	+= nxp-ezport.o
> +obj-$(CONFIG_GEHC_ACHC)		+= gehc-achc.o
>  obj-$(CONFIG_HP_ILO)		+= hpilo.o
>  obj-$(CONFIG_APDS9802ALS)	+= apds9802als.o
>  obj-$(CONFIG_ISL29003)		+= isl29003.o
> diff --git a/drivers/misc/gehc-achc.c b/drivers/misc/gehc-achc.c
> new file mode 100644
> index 000000000000..7856dd70a80c
> --- /dev/null
> +++ b/drivers/misc/gehc-achc.c
> @@ -0,0 +1,160 @@
> +// SPDX-License-Identifier: GPL-2.0+

Are you _sure_ you mean "+"?  I have to ask :)

> +/*
> + * datasheet: https://www.nxp.com/docs/en/data-sheet/K20P144M120SF3.pdf
> + *
> + * Copyright (C) 2018-2021 Collabora
> + * Copyright (C) 2018-2021 GE Healthcare
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +#include <linux/of.h>
> +#include <linux/platform_data/nxp-ezport.h>
> +
> +#define ACHC_MAX_FREQ 300000
> +
> +struct achc_data {
> +	struct spi_device *main;
> +	struct spi_device *ezport;
> +	struct gpio_desc *reset;
> +
> +	struct mutex device_lock; /* avoid concurrent device access */
> +};
> +
> +static ssize_t update_firmware_store(struct device *dev, struct device_attribute *attr,
> +				     const char *buf, size_t count)
> +{
> +	struct achc_data *achc = dev_get_drvdata(dev);
> +	int ret;
> +
> +	if (!count)
> +		return -EINVAL;
> +
> +	mutex_lock(&achc->device_lock);
> +	ret = ezport_flash(achc->ezport, achc->reset, "achc.bin");
> +	mutex_unlock(&achc->device_lock);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	return count;
> +}
> +static DEVICE_ATTR_WO(update_firmware);

You add new sysfs files, yet forget to document them in
Documentation/ABI/  Please fix up for your next submission.

> +
> +static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
> +			   const char *buf, size_t count)
> +{
> +	struct achc_data *achc = dev_get_drvdata(dev);
> +
> +	if (!count)
> +		return -EINVAL;
> +
> +	mutex_lock(&achc->device_lock);
> +	ezport_reset(achc->reset);
> +	mutex_unlock(&achc->device_lock);
> +
> +	return count;
> +}
> +static DEVICE_ATTR_WO(reset);
> +
> +static struct attribute *gehc_achc_attrs[] = {
> +	&dev_attr_update_firmware.attr,
> +	&dev_attr_reset.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group gehc_achc_attr_group = {
> +	.attrs = gehc_achc_attrs,
> +};
> +
> +static void unregister_ezport(void *data)
> +{
> +	struct spi_device *ezport = data;
> +
> +	spi_unregister_device(ezport);
> +}
> +
> +static int gehc_achc_probe(struct spi_device *spi)
> +{
> +	struct achc_data *achc;
> +	int ezport_reg, ret;
> +
> +	spi->max_speed_hz = ACHC_MAX_FREQ;
> +	spi->bits_per_word = 8;
> +	spi->mode = SPI_MODE_0;
> +
> +	achc = devm_kzalloc(&spi->dev, sizeof(*achc), GFP_KERNEL);
> +	if (!achc)
> +		return -ENOMEM;
> +	achc->main = spi;
> +
> +	mutex_init(&achc->device_lock);
> +
> +	ret = of_property_read_u32_index(spi->dev.of_node, "reg", 1, &ezport_reg);
> +	if (ret)
> +		return dev_err_probe(&spi->dev, ret, "missing second reg entry!\n");
> +
> +	achc->ezport = spi_new_ancillary_device(spi, ezport_reg);
> +	if (IS_ERR(achc->ezport))
> +		return PTR_ERR(achc->ezport);
> +
> +	ret = devm_add_action_or_reset(&spi->dev, unregister_ezport, achc->ezport);
> +	if (ret)
> +		return ret;
> +
> +	achc->reset = devm_gpiod_get(&spi->dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(achc->reset))
> +		return dev_err_probe(&spi->dev, PTR_ERR(achc->reset), "Could not get reset gpio\n");
> +
> +	/*
> +	 * The sysfs properties are bound to the dummy device, since the main device already
> +	 * uses drvdata assigned by the spidev driver.
> +	 */
> +	spi_set_drvdata(achc->ezport, achc);
> +	ret = devm_device_add_group(&achc->ezport->dev, &gehc_achc_attr_group);

You just raced and lost.  Please use the default groups attribute for
your driver instead of this.  Or properly attach it to the device some
other way, but what you have done here does not work, sorry.


And you should probably break this up into at least 2 patches, one for
each "driver" you are adding.

thanks,

greg k-h
