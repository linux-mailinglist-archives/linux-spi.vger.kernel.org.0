Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089C73C66E1
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jul 2021 01:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhGLXXK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 12 Jul 2021 19:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhGLXXK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 12 Jul 2021 19:23:10 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FADC0613DD;
        Mon, 12 Jul 2021 16:20:21 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 781B91F41D93
Received: by earth.universe (Postfix, from userid 1000)
        id F045B3C0C97; Tue, 13 Jul 2021 01:20:16 +0200 (CEST)
Date:   Tue, 13 Jul 2021 01:20:16 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Ian Ray <ian.ray@ge.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv6 3/3] misc: gehc-achc: new driver
Message-ID: <20210712232016.feixz7mqingdc7ck@earth.universe>
References: <20210712150242.146545-1-sebastian.reichel@collabora.com>
 <20210712150242.146545-4-sebastian.reichel@collabora.com>
 <YOx/3YaIg24Tx+OQ@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ce7pbsyzdswp6lbh"
Content-Disposition: inline
In-Reply-To: <YOx/3YaIg24Tx+OQ@kroah.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--ce7pbsyzdswp6lbh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Mon, Jul 12, 2021 at 07:46:05PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jul 12, 2021 at 05:02:42PM +0200, Sebastian Reichel wrote:
> > General Electric Healthcare's PPD has a secondary processor from
> > NXP's Kinetis K20 series. That device has two SPI chip selects:
> >=20
> > The main interface's behaviour depends on the loaded firmware
> > and is currently unused.
> >=20
> > The secondary interface can be used to update the firmware using
> > EzPort protocol. This is implemented by this driver using the
> > kernel's firmware API. It's not done during probe time, since
> > the device has non-volatile memory and flashing lasts almost 3
> > minutes.
>=20
> In thinking about this some more, why does it matter?  Spin up a
> workqueue when probing and do the firmware loading then. That way you
> do not end up creating yet another custom user/kernel api just to do
> something as trivial as loading the firmware for a device.
>=20
> And I think the firmware loader even handles async loading, or at least
> it used to, maybe not anymore, it's a complex api, I recommend reading
> the docs...

Flashing the firmware during boot instead of on-demand is not
a good idea for two reasons:

1. This will wear the flash memory of the microcontroller for no
   good reason.

2. Even if the flashing happens in the background, the microcontroller
   will not be usable while it is being programmed. Thus the system
   boot takes 3 minutes instead of 30 seconds.

Note, that this is not the first device with this kind of problem.
I've seen this before for e.g. atmel touchscreen [0] basically does
the same via (undocumented) mxt_update_fw_store().

[0] drivers/input/touchscreen/atmel_mxt_ts.c

> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> >  .../ABI/testing/sysfs-driver-ge-achc          |  14 +
> >  drivers/misc/Kconfig                          |  11 +
> >  drivers/misc/Makefile                         |   2 +
> >  drivers/misc/gehc-achc.c                      | 136 +++++
> >  drivers/misc/nxp-ezport.c                     | 468 ++++++++++++++++++
> >  drivers/misc/nxp-ezport.h                     |   9 +
>=20
> Why is there two different modules here for the same piece of hardware?

It's only one module, but I put all the generic ezport code into its
own file for easy code reuse. I can put it all into gehc-achc and
thus reduce the chance of code reuse if somebody else needs to do
ezport flashing. Since both files are built into the same module
the size savings of merging both files are minimal.

> >  drivers/spi/spidev.c                          |   1 -
> >  7 files changed, 640 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-driver-ge-achc
> >  create mode 100644 drivers/misc/gehc-achc.c
> >  create mode 100644 drivers/misc/nxp-ezport.c
> >  create mode 100644 drivers/misc/nxp-ezport.h
> >=20
> > diff --git a/Documentation/ABI/testing/sysfs-driver-ge-achc b/Documenta=
tion/ABI/testing/sysfs-driver-ge-achc
> > new file mode 100644
> > index 000000000000..f02812731082
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-driver-ge-achc
> > @@ -0,0 +1,14 @@
> > +What:		/sys/bus/spi/<dev>/update_firmware
> > +Date:		Jul 2021
> > +Contact:	sebastian.reichel@collabora.com
> > +Description:	Write 1 to this file to update the ACHC microcontroller
> > +		firmware via the EzPort interface. For this the kernel
> > +		will load "achc.bin" via the firmware API (so usually
> > +		from /lib/firmware). The write will block until the FW
> > +		has either been flashed successfully or an error occured.
> > +
> > +What:		/sys/bus/spi/<dev>/reset
> > +Date:		Jul 2021
> > +Contact:	sebastian.reichel@collabora.com
> > +Description:	Write 1 to this file to reset the microcontroller via the
> > +		reset GPIO. The write will block until the reset completes.
> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > index f4fb5c52b863..1ebf7000671d 100644
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -208,6 +208,17 @@ config CS5535_CLOCK_EVENT_SRC
> >  	  MFGPTs have a better resolution and max interval than the
> >  	  generic PIT, and are suitable for use as high-res timers.
> > =20
> > +config GEHC_ACHC
> > +	tristate "GEHC ACHC support"
> > +	depends on SPI && SYSFS
> > +	select FW_LOADER
> > +	help
> > +	  Support for GE ACHC microcontroller, that is part of the GE
> > +	  PPD device.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called gehc-achc.
> > +
> >  config HP_ILO
> >  	tristate "Channel interface driver for the HP iLO processor"
> >  	depends on PCI
> > diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> > index e92a56d4442f..b50180796931 100644
> > --- a/drivers/misc/Makefile
> > +++ b/drivers/misc/Makefile
> > @@ -24,6 +24,8 @@ obj-$(CONFIG_KGDB_TESTS)	+=3D kgdbts.o
> >  obj-$(CONFIG_SGI_XP)		+=3D sgi-xp/
> >  obj-$(CONFIG_SGI_GRU)		+=3D sgi-gru/
> >  obj-$(CONFIG_CS5535_MFGPT)	+=3D cs5535-mfgpt.o
> > +obj-$(CONFIG_GEHC_ACHC)		+=3D gehc-achc-mod.o
> > +gehc-achc-mod-objs		:=3D gehc-achc.o nxp-ezport.o
>=20
> Yeah, you are creating 2 modules for one Kconfig option, why not put
> these together into 1?  Makes the code smaller.

Actually the above builds both C files into objects and then both
objects into 1 module. It's a common pattern in some parts of the
kernel, e.g. drm.

> >  obj-$(CONFIG_HP_ILO)		+=3D hpilo.o
> >  obj-$(CONFIG_APDS9802ALS)	+=3D apds9802als.o
> >  obj-$(CONFIG_ISL29003)		+=3D isl29003.o
> > diff --git a/drivers/misc/gehc-achc.c b/drivers/misc/gehc-achc.c
> > new file mode 100644
> > index 000000000000..893940e7ca4e
> > --- /dev/null
> > +++ b/drivers/misc/gehc-achc.c
> > @@ -0,0 +1,136 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * datasheet: https://www.nxp.com/docs/en/data-sheet/K20P144M120SF3.pdf
> > + *
> > + * Copyright (C) 2018-2021 Collabora
> > + * Copyright (C) 2018-2021 GE Healthcare
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/spi/spi.h>
> > +#include <linux/of.h>
> > +#include "nxp-ezport.h"
> > +
> > +#define ACHC_MAX_FREQ_HZ 300000
> > +
> > +struct achc_data {
> > +	struct spi_device *main;
> > +	struct spi_device *ezport;
> > +	struct gpio_desc *reset;
> > +
> > +	struct mutex device_lock; /* avoid concurrent device access */
> > +};
> > +
> > +static ssize_t update_firmware_store(struct device *dev, struct device=
_attribute *attr,
> > +				     const char *buf, size_t count)
> > +{
> > +	struct achc_data *achc =3D dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	if (count !=3D 1 || buf[0] !=3D '1')
> > +		return -EINVAL;
>=20
> There a core kernel call to see if the data written to a sysfs file is
> "true/false" I would recommend, if you stick with this, to use that
> instead.

I have problems understanding that sentence, it seems to be missing
a word.

As far as I can tell -EINVAL is usually used when the user supplied
data is not formatted correctly for sysfs store routines, e.g. lot's
of them are returning -EINVAL like this:

rc =3D kstrtoul(buf, 0, &value);
if (rc)
    return rc;

Did I miss something?

Thanks,

-- Sebastian

--ce7pbsyzdswp6lbh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmDszi0ACgkQ2O7X88g7
+poeFg//StHq0M7k7IGVEJic+kZZetqsu5vGljq1wY9+y8rXPa/0PMlemqQnp38p
V1gnnsYhLixwI2q8ETalaoERbJnD3BQp8anbB0VrUPKvEiVR86qA4kNh9V+wXWNm
8d19NtkVcTIMQGEBXt7hLjvD7F26KDq4T41kefju+S7ivZo8zbypStnTmV7p2YWj
yici5xyJthLO9rvdeF/oGWMAKw0A3CXtuv3D81WoSgfPGUbeWjolK9Q7ta85/gpV
3A4mMLRJGlxYC5y3oANr8ikYNCp33/ZpE/1LNwIYaYe84SOFX1JdzWaH/FJVVRx0
z4WQwtoC/DhWwA0tB645bZ5pMfxLB9NIQ8BfxG/Fu0AqcN6n/uhSw52XsfL3hIaW
/yvZQYD8Os10BeXNTgPKHngbSu0bHerf00b90CEzYAt27dcTP6DKgtup7uASHTac
Xa5rA+IR+7P3LV6vqGYDFOvulVEFDQ2TN69gdTeO84Zl4mgJLQaZo1qrikMBviwb
suajxKlZrm+xiWK5gszKQ5Ua5Cf06SavluyVGD2Uep6bGg/JRRbL2dV8cV9BM9Rw
vxMWVR2k+AvZSuLrbvUYuWh9qjxU+CvBrDFMrRUb3AkIcb9daWxldsRoAZZ78Vqw
4UGN/c3zVhh659opkzL4KJYle6KGy72m26dAxvKbq3NtP7+yPPo=
=kKCz
-----END PGP SIGNATURE-----

--ce7pbsyzdswp6lbh--
