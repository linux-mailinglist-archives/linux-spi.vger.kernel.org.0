Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916673C6226
	for <lists+linux-spi@lfdr.de>; Mon, 12 Jul 2021 19:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbhGLRs5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 12 Jul 2021 13:48:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:34366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232979AbhGLRs4 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 12 Jul 2021 13:48:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 834636120A;
        Mon, 12 Jul 2021 17:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626111968;
        bh=L61h2k2oAGTx75ubJ5kFKZdwVu8/ushydQdlQZU8N9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rNy211GMX4+vx/p65l03JNPm9LStEdW6nmZuVRmio/2HVeSGV/SBVN2tZIi8xsjN6
         orJk/1hYVp1bO+Y4AbV687CLkqdgYeq7SHHhgf/e/j31XAKnYrh8QHXuW0qVK998Yb
         qiHcr04Irpx1zx57IhXu2j4NTtxHrKxSDh0PHm/I=
Date:   Mon, 12 Jul 2021 19:46:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Ian Ray <ian.ray@ge.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv6 3/3] misc: gehc-achc: new driver
Message-ID: <YOx/3YaIg24Tx+OQ@kroah.com>
References: <20210712150242.146545-1-sebastian.reichel@collabora.com>
 <20210712150242.146545-4-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712150242.146545-4-sebastian.reichel@collabora.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Jul 12, 2021 at 05:02:42PM +0200, Sebastian Reichel wrote:
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

In thinking about this some more, why does it matter?  Spin up a
workqueue when probing and do the firmware loading then.  That way you
do not end up creating yet another custom user/kernel api just to do
something as trivial as loading the firmware for a device.

And I think the firmware loader even handles async loading, or at least
it used to, maybe not anymore, it's a complex api, I recommend reading
the docs...



> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../ABI/testing/sysfs-driver-ge-achc          |  14 +
>  drivers/misc/Kconfig                          |  11 +
>  drivers/misc/Makefile                         |   2 +
>  drivers/misc/gehc-achc.c                      | 136 +++++
>  drivers/misc/nxp-ezport.c                     | 468 ++++++++++++++++++
>  drivers/misc/nxp-ezport.h                     |   9 +

Why is there two different modules here for the same piece of hardware?


>  drivers/spi/spidev.c                          |   1 -
>  7 files changed, 640 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-ge-achc
>  create mode 100644 drivers/misc/gehc-achc.c
>  create mode 100644 drivers/misc/nxp-ezport.c
>  create mode 100644 drivers/misc/nxp-ezport.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-ge-achc b/Documentation/ABI/testing/sysfs-driver-ge-achc
> new file mode 100644
> index 000000000000..f02812731082
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-ge-achc
> @@ -0,0 +1,14 @@
> +What:		/sys/bus/spi/<dev>/update_firmware
> +Date:		Jul 2021
> +Contact:	sebastian.reichel@collabora.com
> +Description:	Write 1 to this file to update the ACHC microcontroller
> +		firmware via the EzPort interface. For this the kernel
> +		will load "achc.bin" via the firmware API (so usually
> +		from /lib/firmware). The write will block until the FW
> +		has either been flashed successfully or an error occured.
> +
> +What:		/sys/bus/spi/<dev>/reset
> +Date:		Jul 2021
> +Contact:	sebastian.reichel@collabora.com
> +Description:	Write 1 to this file to reset the microcontroller via the
> +		reset GPIO. The write will block until the reset completes.
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index f4fb5c52b863..1ebf7000671d 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -208,6 +208,17 @@ config CS5535_CLOCK_EVENT_SRC
>  	  MFGPTs have a better resolution and max interval than the
>  	  generic PIT, and are suitable for use as high-res timers.
>  
> +config GEHC_ACHC
> +	tristate "GEHC ACHC support"
> +	depends on SPI && SYSFS
> +	select FW_LOADER
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
> index e92a56d4442f..b50180796931 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -24,6 +24,8 @@ obj-$(CONFIG_KGDB_TESTS)	+= kgdbts.o
>  obj-$(CONFIG_SGI_XP)		+= sgi-xp/
>  obj-$(CONFIG_SGI_GRU)		+= sgi-gru/
>  obj-$(CONFIG_CS5535_MFGPT)	+= cs5535-mfgpt.o
> +obj-$(CONFIG_GEHC_ACHC)		+= gehc-achc-mod.o
> +gehc-achc-mod-objs		:= gehc-achc.o nxp-ezport.o

Yeah, you are creating 2 modules for one Kconfig option, why not put
these together into 1?  Makes the code smaller.




>  obj-$(CONFIG_HP_ILO)		+= hpilo.o
>  obj-$(CONFIG_APDS9802ALS)	+= apds9802als.o
>  obj-$(CONFIG_ISL29003)		+= isl29003.o
> diff --git a/drivers/misc/gehc-achc.c b/drivers/misc/gehc-achc.c
> new file mode 100644
> index 000000000000..893940e7ca4e
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
> +#include "nxp-ezport.h"
> +
> +#define ACHC_MAX_FREQ_HZ 300000
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
> +	if (count != 1 || buf[0] != '1')
> +		return -EINVAL;

There a core kernel call to see if the data written to a sysfs file is
"true/false" I would recommend, if you stick with this, to use that
instead.

thanks,

greg k-h
