Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F4155456B03
	for <lists+linux-spi@lfdr.de>; Fri, 19 Nov 2021 08:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbhKSHnX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 19 Nov 2021 02:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbhKSHnX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 19 Nov 2021 02:43:23 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BB6C061574
        for <linux-spi@vger.kernel.org>; Thu, 18 Nov 2021 23:40:21 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mnyVN-0008G7-B4; Fri, 19 Nov 2021 08:40:17 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mnyVM-000QqF-TV; Fri, 19 Nov 2021 08:40:16 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mnyVL-0004bf-R5; Fri, 19 Nov 2021 08:40:15 +0100
Date:   Fri, 19 Nov 2021 08:40:15 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spidev: Make probe to fail early if a spidev compatible
 is used
Message-ID: <20211119074015.kji2hzarevxgfl5l@pengutronix.de>
References: <20211109225920.1158920-1-javierm@redhat.com>
 <20211110074247.g7eaq2z27bwdt4m5@pengutronix.de>
 <YZaZpx7cudaAEGIP@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i6lcaidjqepiuwke"
Content-Disposition: inline
In-Reply-To: <YZaZpx7cudaAEGIP@sirena.org.uk>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--i6lcaidjqepiuwke
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 18, 2021 at 06:21:27PM +0000, Mark Brown wrote:
> On Wed, Nov 10, 2021 at 08:42:47AM +0100, Uwe Kleine-K=F6nig wrote:
>=20
> > Up to 6840615f85f6 the choices you had to use the spidev driver were
> > (assuing a dt machine):
>=20
> >  a) Use compatible =3D "spidev" and ignore the warning
> >  b) Use compatible =3D $chipname and add $chipname to the list of
> >     supported devices for the spidev driver. (e.g. "rohm,dh2228fv")
> >  c) Use compatible =3D $chipname and force binding the spidev driver us=
ing
> >=20
> >    	echo spidev > /sys/bus/spi/devices/spiX.Y/driver_override
> > 	echo spiX.Y > /sys/bus/spi/drivers/spidev/bind
>=20
> > Commit 6840615f85f6 changed that in situation a) you had to switch to c)
> > (well, or b) adding "spidev" to the spi id list).
>=20
> > With the change introduced by this patch, you make it impossible to bind
> > the spidev driver to such a device (without kernel source changes) even
> > using approach c). I wonder if this is too harsh given that changing the
> > dtb is difficult on some machines.
>=20
> Following up from discussion on IRC: it's not clear to me how option c
> is affected?  The change only causes an error if of_device_is_compatible()
> is true and driver_override works with spi_device_id not compatibles (I
> didn't actually test, in the middle of some other stuff right now).

It affects c) only if the device tree has a device with compatible =3D
"spidev". For such a device the history is:

  - Before 956b200a846e ("spi: spidev: Warn loudly if instantiated from
    DT as "spidev"") in v4.1-rc1:
    Just bound silently

  - After 956b200a846e up to 6840615f85f6 ("spi: spidev: Add SPI ID
    table") in v5.15-rc6:
    The device was automatically bound with a warning

  - After 6840615f85f6:
    The device doesn't bind automatically, when using driver_override
    you get a warning.

  - With the proposed patch:
    The device cannot be bound even using driver_override

Not this affects also devices that use

	compatible =3D "myvender,devicename", "spidev";

=2E

Best regards
Uwe




--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--i6lcaidjqepiuwke
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGXVNsACgkQwfwUeK3K
7Al4vQf/ZXk+F0vl3KPL2XIcQv4fz7LHzx+yHfaExJZkVMrTqBlCRkJ2vkwvLKb6
sRR1GSVc45N6ABPmvagTxfrpj0SMO/ZMedaDmLHkVMobNvld/MpoKyj34IH+V+BP
px6rxgxiev7keWE1bpDiRjl5q2Go8KqsexisqItvpZ34R1UYd1fhIUjCq4Tyh4VP
Y9RGeKgEMdi45kCzwGyVYPJ0/oAnmHnfrlvqHKd1FuucjUimbbWpoeZMh3EGa9fq
9uligrgiYiZz00areB65OguPOXe4CdEypCMW0bq0bERipeKo1lXULuwd2TPSXazQ
co2/mEL5lVlzOWrpaqBWJrmDdluc4g==
=sVbv
-----END PGP SIGNATURE-----

--i6lcaidjqepiuwke--
