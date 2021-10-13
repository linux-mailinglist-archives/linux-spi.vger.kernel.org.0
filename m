Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9129E42C22C
	for <lists+linux-spi@lfdr.de>; Wed, 13 Oct 2021 16:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbhJMOKu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Oct 2021 10:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbhJMOKt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 Oct 2021 10:10:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971D8C061570
        for <linux-spi@vger.kernel.org>; Wed, 13 Oct 2021 07:08:46 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maevt-0005KE-Ls; Wed, 13 Oct 2021 16:08:37 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maevr-0005ch-Ur; Wed, 13 Oct 2021 16:08:35 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maevr-0007hN-T5; Wed, 13 Oct 2021 16:08:35 +0200
Date:   Wed, 13 Oct 2021 16:08:35 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Richard Weinberger <richard@nod.at>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v2 13/20] mtd: dataflash: Warn about failure to
 unregister mtd device
Message-ID: <20211013140835.olo2dxdno6zlom7n@pengutronix.de>
References: <20211012153945.2651412-1-u.kleine-koenig@pengutronix.de>
 <20211012153945.2651412-14-u.kleine-koenig@pengutronix.de>
 <20211013144429.65b294e5@xps13>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4oiamhcwsch7pebo"
Content-Disposition: inline
In-Reply-To: <20211013144429.65b294e5@xps13>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--4oiamhcwsch7pebo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 13, 2021 at 02:44:29PM +0200, Miquel Raynal wrote:
> Hi Uwe,
>=20
> u.kleine-koenig@pengutronix.de wrote on Tue, 12 Oct 2021 17:39:38 +0200:
>=20
> > When an spi driver's remove function returns a non-zero error code
>=20
> Should we s/an spi/a SPI/?

My (German) knowledge about the English Grammar claims that independent
of how you spell SPI, it must be "an" because when I say it, it's
[=C9=9Bspi:a=C9=AA] (unless you call it [spa=C9=AA]?)

In my eyes "spi" is right, because SPI is the protocol and "spi" is the
kernel framework. But I don't feel strong here and you're already the
second who suggests something similar.
=20
> > nothing happens apart from emitting a generic error message. Make this
> > error message more device specific and return zero instead.
> >=20
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/mtd/devices/mtd_dataflash.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/mtd/devices/mtd_dataflash.c b/drivers/mtd/devices/=
mtd_dataflash.c
> > index 9802e265fca8..2691b6b79df8 100644
> > --- a/drivers/mtd/devices/mtd_dataflash.c
> > +++ b/drivers/mtd/devices/mtd_dataflash.c
> > @@ -919,7 +919,10 @@ static int dataflash_remove(struct spi_device *spi)
> >  	status =3D mtd_device_unregister(&flash->mtd);
> >  	if (status =3D=3D 0)
> >  		kfree(flash);
> > -	return status;
> > +	else
> > +		dev_warn(&spi->dev, "Failed to unregister mtd device (%pe)\n",
> > +			 ERR_PTR(status));
> > +	return 0;
>=20
> As part of a recent NAND cleanup series we ended up adding WARN_ON() [1]
> to make it very clear that if this happens, it's not expected at all (it
> was Boris' advice).
>=20
> I don't think there is only one good solution but perhaps its best to
> keep it sync'ed with the other drivers in MTD?

Well, if WARN_ON or dev_warn is the right thing is subjective. Your
subjective counts more as you're an MTD maintainer. Can rework
accordingly for v3.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--4oiamhcwsch7pebo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFm6GAACgkQwfwUeK3K
7AlUtQf+IHBiQyXezi4wzKiSkQvRhNa/hJarXpJUkdBSTDEf0TTYy8LuUwsaogqp
+5oSqdLjzgHTFVqFzEXXQ9+jKsKHGfjwbM3Ns8cbRYM3m97LVdYO5WhiiauSWcap
yzg0zF9T19dSg6DJtYhVoFb88bzq2kmpu9pUmD9lwUUpcbC+cABHQnEF4tBU53XE
4ZvilTboIB8y465QA7w0fRF7K8/Y/8/qix7JVbeg30qfbPHkuqC1RJIgC/c/S7W/
sSirILxk3snigVHrwkUsy95JRE6k2puxrIDpI7YYHHMeCtBGxOCtBWRV1EXgmvaZ
UuxUTrxUSUbODJAtCy3fAZ5w/O55Ow==
=jrzI
-----END PGP SIGNATURE-----

--4oiamhcwsch7pebo--
