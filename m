Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667723A47D2
	for <lists+linux-spi@lfdr.de>; Fri, 11 Jun 2021 19:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbhFKRYM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Jun 2021 13:24:12 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45210 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbhFKRYM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 11 Jun 2021 13:24:12 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 3C1411F448DB
Received: by earth.universe (Postfix, from userid 1000)
        id D9AF13C0C95; Fri, 11 Jun 2021 19:22:09 +0200 (CEST)
Date:   Fri, 11 Jun 2021 19:22:09 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Ian Ray <ian.ray@ge.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv4 1/6] spi: add ancillary device support
Message-ID: <20210611172209.acbrpwxg75k4v4je@earth.universe>
References: <20210609151235.48964-1-sebastian.reichel@collabora.com>
 <20210609151235.48964-2-sebastian.reichel@collabora.com>
 <YMMnrYbuwe4z/s3h@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fnv2zapnday6i2fd"
Content-Disposition: inline
In-Reply-To: <YMMnrYbuwe4z/s3h@kroah.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--fnv2zapnday6i2fd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Fri, Jun 11, 2021 at 11:06:53AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jun 09, 2021 at 05:12:30PM +0200, Sebastian Reichel wrote:
> > Introduce support for ancillary devices, similar to existing
> > implementation for I2C. This is useful for devices having
> > multiple chip-selects, for example some microcontrollers
> > provide a normal SPI interface and a flashing SPI interface.
> >=20
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> > [...]
> > +static int spi_add_device_locked(struct spi_device *spi)
> > +{
> > +	struct spi_controller *ctlr =3D spi->controller;
> > +	struct device *dev =3D ctlr->dev.parent;
> > +
> > +	/* Chipselects are numbered 0..max; validate. */
> > +	if (spi->chip_select >=3D ctlr->num_chipselect) {
> > +		dev_err(dev, "cs%d >=3D max %d\n", spi->chip_select,
> > +			ctlr->num_chipselect);
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* Set the bus ID string */
> > +	spi_dev_set_name(spi);
> > +
> > +	WARN_ON(!mutex_is_locked(&spi_add_lock));
>=20
> So you just rebooted a machine that has panic-on-warn set.  Not
> nice.
>=20
> If this really can happen, test for it and recover, do not reboot
> devices.
>=20
> If this really can never happen, why are you testing for it?

This is reached when ancillary device is not registered in
the main SPI device's probe routine, which would be a driver
bug. The gehc-achc driver calls it in the right place, so
this is not reached with this patchset, but the function to
register ancillary devices is generic and is expected to be
also used by others.

-- Sebastian

--fnv2zapnday6i2fd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmDDm7QACgkQ2O7X88g7
+ppAohAApS/cMcm/00V3Nzdui7yis1bX7vbxTlR5vE+ZV5EJ6Fbnvdi6F+efeR4P
Q3T7jxOgx1Dn5F8NKH1yWgaVi6m9jb8ysBCx54OoEm4hnO2RBr6hb9nB2FEzFS72
nGqoA/f4TaZe+m+z9PGNNLTDKSX9WDzl5UqBbpSLo2sSHXhBNAe9KqokVd/ss9NA
biY4pWC/Mn3Lr05/UEPs6Vj8FPB6XWXUD3lLAIb9N/ejzb3CUPFHbjJkH4CcsBnl
TW30NjK0EzXaimuDmHnLIA/D1caJyK4YzESHyV2x9cuLb2Yz4SYm/1IB2LFZJbW+
DkmQhBHQpW75MozrzNOxuR81auzenORSDkbxffXdszTRW6kVewXjwlH6ZvtIN1Cd
NdScWV5jLX1aqt3rSBpA7Mmd5ku3FeYtCS5AdpqPbfD4NVqziwxavwDrrhicC/k6
o40b0VZ9xVWCZPGEMj/Jpxny3HcJaN76AEVV3joKUyUlbvAi9JZ3jIDOoI9kD12A
DJNI7Uj/RmQlx+LXpPLFb9pVZpe1xlwl+LL3l/gkMIGb8UcsxVAJm6mWR4B4NZaV
LrlLZNNmWPyh+m1cQ01niFYDrtC+XoXHRLF4awtjLS59fiPlaNGBQPzLQHdGh/iR
E6UNo7sKSYr2jkRLqoRpooCA5yK/w99t8w+IA77mb/3M3Wjo0Nw=
=ZPku
-----END PGP SIGNATURE-----

--fnv2zapnday6i2fd--
