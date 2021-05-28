Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221993943C4
	for <lists+linux-spi@lfdr.de>; Fri, 28 May 2021 16:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbhE1OIf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 May 2021 10:08:35 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37778 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbhE1OIc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 May 2021 10:08:32 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 57A3A1F442FD
Received: by earth.universe (Postfix, from userid 1000)
        id 2B4B13C0C95; Fri, 28 May 2021 16:06:54 +0200 (CEST)
Date:   Fri, 28 May 2021 16:06:54 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Ian Ray <ian.ray@ge.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv3 5/5] misc: gehc-achc: new driver
Message-ID: <20210528140654.ffhetiikhde6seuo@earth.universe>
References: <20210528113346.37137-1-sebastian.reichel@collabora.com>
 <20210528113346.37137-6-sebastian.reichel@collabora.com>
 <YLDfvD1nLgWqEavS@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gjeq6anmyxvcim3l"
Content-Disposition: inline
In-Reply-To: <YLDfvD1nLgWqEavS@kroah.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--gjeq6anmyxvcim3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Fri, May 28, 2021 at 02:19:08PM +0200, Greg Kroah-Hartman wrote:
> On Fri, May 28, 2021 at 01:33:47PM +0200, Sebastian Reichel wrote:
> > General Electric Healthcare's PPD has a secondary processor from
> > NXP's Kinetis K20 series. That device has two SPI chip selects:
> >=20
> > The main interface's behaviour depends on the loaded firmware
> > and is exposed to userspace (as before).
> >=20
> > The secondary interface can be used to update the firmware using
> > EzPort protocol. This is implemented by this driver using the
> > kernel's firmware API. It's not done during probe time, since
> > the device has non-volatile memory and flashing lasts almost 3
> > minutes.
> >=20
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> >  drivers/misc/Kconfig                     |  15 +
> >  drivers/misc/Makefile                    |   2 +
> >  drivers/misc/gehc-achc.c                 | 160 ++++++++
> >  drivers/misc/nxp-ezport.c                | 476 +++++++++++++++++++++++
> >  drivers/spi/spidev.c                     |   7 +-
> >  include/linux/platform_data/nxp-ezport.h |   9 +
> >  include/linux/spi/spi.h                  |   5 +
> >  7 files changed, 671 insertions(+), 3 deletions(-)
> >  create mode 100644 drivers/misc/gehc-achc.c
> >  create mode 100644 drivers/misc/nxp-ezport.c
> >  create mode 100644 include/linux/platform_data/nxp-ezport.h
> >=20
> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > index f4fb5c52b863..f058b551a7b1 100644
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -208,6 +208,21 @@ config CS5535_CLOCK_EVENT_SRC
> >  	  MFGPTs have a better resolution and max interval than the
> >  	  generic PIT, and are suitable for use as high-res timers.
> > =20
> > +config NXP_EZPORT
> > +	tristate
> > +
> > +config GEHC_ACHC
> > +	tristate "GEHC ACHC support"
> > +	depends on SPI && SYSFS && SPI_SPIDEV
> > +	select FW_LOADER
> > +	select NXP_EZPORT
> > +	help
> > +	  Support for GE ACHC microcontroller, that is part of the GE
> > +	  CS One device.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called gehc-achc.
> > +
> >  config HP_ILO
> >  	tristate "Channel interface driver for the HP iLO processor"
> >  	depends on PCI
> > diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> > index e92a56d4442f..b7bad5a16c8f 100644
> > --- a/drivers/misc/Makefile
> > +++ b/drivers/misc/Makefile
> > @@ -24,6 +24,8 @@ obj-$(CONFIG_KGDB_TESTS)	+=3D kgdbts.o
> >  obj-$(CONFIG_SGI_XP)		+=3D sgi-xp/
> >  obj-$(CONFIG_SGI_GRU)		+=3D sgi-gru/
> >  obj-$(CONFIG_CS5535_MFGPT)	+=3D cs5535-mfgpt.o
> > +obj-$(CONFIG_NXP_EZPORT)	+=3D nxp-ezport.o
> > +obj-$(CONFIG_GEHC_ACHC)		+=3D gehc-achc.o
> >  obj-$(CONFIG_HP_ILO)		+=3D hpilo.o
> >  obj-$(CONFIG_APDS9802ALS)	+=3D apds9802als.o
> >  obj-$(CONFIG_ISL29003)		+=3D isl29003.o
> > diff --git a/drivers/misc/gehc-achc.c b/drivers/misc/gehc-achc.c
> > new file mode 100644
> > index 000000000000..7856dd70a80c
> > --- /dev/null
> > +++ b/drivers/misc/gehc-achc.c
> > @@ -0,0 +1,160 @@
> > +// SPDX-License-Identifier: GPL-2.0+
>=20
> Are you _sure_ you mean "+"?  I have to ask :)

Yes, but I'm also fine with GPL-2.0-only.

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
> > +#include <linux/platform_data/nxp-ezport.h>
> > +
> > +#define ACHC_MAX_FREQ 300000
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
> > +	if (!count)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&achc->device_lock);
> > +	ret =3D ezport_flash(achc->ezport, achc->reset, "achc.bin");
> > +	mutex_unlock(&achc->device_lock);
> > +
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return count;
> > +}
> > +static DEVICE_ATTR_WO(update_firmware);
>=20
> You add new sysfs files, yet forget to document them in
> Documentation/ABI/  Please fix up for your next submission.

Ack.

> > +
> > +static ssize_t reset_store(struct device *dev, struct device_attribute=
 *attr,
> > +			   const char *buf, size_t count)
> > +{
> > +	struct achc_data *achc =3D dev_get_drvdata(dev);
> > +
> > +	if (!count)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&achc->device_lock);
> > +	ezport_reset(achc->reset);
> > +	mutex_unlock(&achc->device_lock);
> > +
> > +	return count;
> > +}
> > +static DEVICE_ATTR_WO(reset);
> > +
> > +static struct attribute *gehc_achc_attrs[] =3D {
> > +	&dev_attr_update_firmware.attr,
> > +	&dev_attr_reset.attr,
> > +	NULL,
> > +};
> > +
> > +static const struct attribute_group gehc_achc_attr_group =3D {
> > +	.attrs =3D gehc_achc_attrs,
> > +};
> > +
> > +static void unregister_ezport(void *data)
> > +{
> > +	struct spi_device *ezport =3D data;
> > +
> > +	spi_unregister_device(ezport);
> > +}
> > +
> > +static int gehc_achc_probe(struct spi_device *spi)
> > +{
> > +	struct achc_data *achc;
> > +	int ezport_reg, ret;
> > +
> > +	spi->max_speed_hz =3D ACHC_MAX_FREQ;
> > +	spi->bits_per_word =3D 8;
> > +	spi->mode =3D SPI_MODE_0;
> > +
> > +	achc =3D devm_kzalloc(&spi->dev, sizeof(*achc), GFP_KERNEL);
> > +	if (!achc)
> > +		return -ENOMEM;
> > +	achc->main =3D spi;
> > +
> > +	mutex_init(&achc->device_lock);
> > +
> > +	ret =3D of_property_read_u32_index(spi->dev.of_node, "reg", 1, &ezpor=
t_reg);
> > +	if (ret)
> > +		return dev_err_probe(&spi->dev, ret, "missing second reg entry!\n");
> > +
> > +	achc->ezport =3D spi_new_ancillary_device(spi, ezport_reg);
> > +	if (IS_ERR(achc->ezport))
> > +		return PTR_ERR(achc->ezport);
> > +
> > +	ret =3D devm_add_action_or_reset(&spi->dev, unregister_ezport, achc->=
ezport);
> > +	if (ret)
> > +		return ret;
> > +
> > +	achc->reset =3D devm_gpiod_get(&spi->dev, "reset", GPIOD_OUT_LOW);
> > +	if (IS_ERR(achc->reset))
> > +		return dev_err_probe(&spi->dev, PTR_ERR(achc->reset), "Could not get=
 reset gpio\n");
> > +
> > +	/*
> > +	 * The sysfs properties are bound to the dummy device, since the main=
 device already
> > +	 * uses drvdata assigned by the spidev driver.
> > +	 */
> > +	spi_set_drvdata(achc->ezport, achc);
> > +	ret =3D devm_device_add_group(&achc->ezport->dev, &gehc_achc_attr_gro=
up);
>=20
> You just raced and lost. Please use the default groups attribute for
> your driver instead of this. Or properly attach it to the device some
> other way, but what you have done here does not work, sorry.

I've been told the race got fixed from kernel POV?

https://lore.kernel.org/linux-input/20200521055400.GX89269@dtor-ws/

If this is still an issue, I think most (all?) existing instances of
devm_device_add_group() are a problem and it makes sense to have a
checkpatch warning for it.

> And you should probably break this up into at least 2 patches, one for
> each "driver" you are adding.

I expect, that Mark wants this to be restructured anyways. If
it stays in its current form I will split this into three patches

1) export spidev probe/remove
2) add ezport support module
3) add gehc-achc driver gluing both together

Thanks for the review.

-- Sebastian

--gjeq6anmyxvcim3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmCw+PUACgkQ2O7X88g7
+poPzg/6A0Itm3aISLiBRiPzuF2eoQLYjCAxnhnJywruWwzbAUc1t2lhtc2KUr8B
itgIiAI/AxVQsEYPHymJMMV064TYCkfyJSmJD/8SAU+XOKunCs7LGJ4Sd0bxxM9R
uLRQisLvEUV5NZAuC+QLwdo27RRu0rc40smPK3QT4IXqPfbf6ED7htebZFbM9DUA
AbhbB8+c7UV1CGBhi7t4Frvfr356bXW9V7X9zyNYaK2JdiJ6Lkz091yd7bcIDIKA
dgXzhOKKeVsdH8zxwuRreiAC9+tS8Tays9YO2kUyzO3hbXJ6s0oyk9SdJ+jCbjbI
YGBQpLv7NRbLmEoP8CZA1l160Z58PRtO60DVvGrOP3zqIIV6sxcA0RKY4/QIyfbd
g2HU++d7MjBwbFlrkm0EH7QoyyhN5K8wvPKWrEsb5npCeXJeOgiupoqSeU+PPgLD
zT8bWMi9NQealoQ/KZ2ib+z0GPgvZW68XFzKdxp9/xZSlpSdJG0v6+oSdYxKDcz4
rG2kg/FTwWzncbd/7GhhIrQIEn5wks6BnFpsTWO4XNO/7u59SwqPEb3BNgVH9HdJ
GCkgwfyhrqaLsixdawRaTxiaHhnyKsh14xVstNPyUGIbLt16WJ8R9cwUgV4aapsd
/JP4ANqlKVSjRzIU+Xwc5yPeKhdvICP5CSefE9XJQTkw0CbvFNM=
=1Y2T
-----END PGP SIGNATURE-----

--gjeq6anmyxvcim3l--
