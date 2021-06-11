Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB483A3E82
	for <lists+linux-spi@lfdr.de>; Fri, 11 Jun 2021 11:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhFKJFP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Jun 2021 05:05:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:32770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230460AbhFKJFO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 11 Jun 2021 05:05:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B0F961181;
        Fri, 11 Jun 2021 09:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623402182;
        bh=TsVXPLwnrlWET7PO8tQP/ey0ws/jRNpWg0MSbcEBVbk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f5xGFCpEwkaMul78gNStpklEFUzweU2WqSRXUcJeplNbZPfnBVMTdfXeIpKaHCyJ8
         x1Ez1odI7Fj5ULmET1YYFwb8ET3yEg25hjbE5CoQoSQmQlhQQfGqE7b8xuL4G9906X
         bvSLO4ZQ658ngjAxelgGRle+MIqJUjti0cEywyQk=
Date:   Fri, 11 Jun 2021 11:02:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Ian Ray <ian.ray@ge.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv4 6/6] misc: gehc-achc: new driver
Message-ID: <YMMmw11wOzMZejkS@kroah.com>
References: <20210609151235.48964-1-sebastian.reichel@collabora.com>
 <20210609151235.48964-7-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609151235.48964-7-sebastian.reichel@collabora.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Jun 09, 2021 at 05:12:35PM +0200, Sebastian Reichel wrote:
> General Electric Healthcare's PPD has a secondary processor from
> NXP's Kinetis K20 series. That device has two SPI chip selects:
> 
> The main interface's behaviour depends on the loaded firmware
> and is currently unused.
> 
> The secondary interface can be used to update the firmware using
> EzPort protocol. This is implemented by this driver using the
> kernel's firmware API. It's not done during probe time, since
> the device has non-volatile memory and flashing lasts almost 3
> minutes.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../ABI/testing/sysfs-driver-ge-achc          |   9 ++
>  drivers/misc/Kconfig                          |  12 ++
>  drivers/misc/Makefile                         |   1 +
>  drivers/misc/gehc-achc.c                      | 136 ++++++++++++++++++
>  drivers/spi/spidev.c                          |   1 -
>  5 files changed, 158 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-ge-achc
>  create mode 100644 drivers/misc/gehc-achc.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-ge-achc b/Documentation/ABI/testing/sysfs-driver-ge-achc
> new file mode 100644
> index 000000000000..3ca71a1b4836
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-ge-achc
> @@ -0,0 +1,9 @@
> +What:		/sys/bus/spi/drivers/gehc-achc/<dev>/update_firmware

Shouldn't the path be through the bus and not through the driver portion
of sysfs?

> +Date:		June 2021
> +Contact:	linux-kernel@vger.kernel.org

If you are not willing to put your name on this, I'm not willing to take
this :(

> +Description:	Write 1 to this file to trigger a firmware update.

What exactly does this mean?  What will be "triggered" and what will
happen?

And it is not what the kernel code does, it will take any write to this
file, not just "1" so something is wrong here.

> +
> +What:		/sys/bus/spi/drivers/gehc-achc/<dev>/reset
> +Date:		June 2021
> +Contact:	linux-kernel@vger.kernel.org

Again, real name for a contact for obvious reasons.

> +Description:	Write 1 to this file to trigger a device reset.

Also does not match the code :(


> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 392c091891a1..a286f0775f2e 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -211,6 +211,18 @@ config CS5535_CLOCK_EVENT_SRC
>  config NXP_EZPORT
>  	tristate
>  
> +config GEHC_ACHC
> +	tristate "GEHC ACHC support"
> +	depends on SPI && SYSFS && SPI_SPIDEV
> +	select FW_LOADER
> +	select NXP_EZPORT
> +	help
> +	  Support for GE ACHC microcontroller, that is part of the GE
> +	  PPD device.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called gehc-achc.
> +
>  config HP_ILO
>  	tristate "Channel interface driver for the HP iLO processor"
>  	depends on PCI
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index a85e763b9b33..b7bad5a16c8f 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -25,6 +25,7 @@ obj-$(CONFIG_SGI_XP)		+= sgi-xp/
>  obj-$(CONFIG_SGI_GRU)		+= sgi-gru/
>  obj-$(CONFIG_CS5535_MFGPT)	+= cs5535-mfgpt.o
>  obj-$(CONFIG_NXP_EZPORT)	+= nxp-ezport.o
> +obj-$(CONFIG_GEHC_ACHC)		+= gehc-achc.o
>  obj-$(CONFIG_HP_ILO)		+= hpilo.o
>  obj-$(CONFIG_APDS9802ALS)	+= apds9802als.o
>  obj-$(CONFIG_ISL29003)		+= isl29003.o
> diff --git a/drivers/misc/gehc-achc.c b/drivers/misc/gehc-achc.c
> new file mode 100644
> index 000000000000..5868ac99a3f6
> --- /dev/null
> +++ b/drivers/misc/gehc-achc.c
> @@ -0,0 +1,136 @@
> +// SPDX-License-Identifier: GPL-2.0-only
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

What is the units here?

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

So just a non-empty string works?  As said above, that's not what you
documented :(

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
> +
> +static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
> +			   const char *buf, size_t count)
> +{
> +	struct achc_data *achc = dev_get_drvdata(dev);
> +
> +	if (!count)
> +		return -EINVAL;

Same here as above.


thanks,

greg k-h
