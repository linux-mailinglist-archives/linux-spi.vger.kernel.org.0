Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4CA644BC40
	for <lists+linux-spi@lfdr.de>; Wed, 10 Nov 2021 08:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhKJHpq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Nov 2021 02:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhKJHpp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 10 Nov 2021 02:45:45 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C614C061764
        for <linux-spi@vger.kernel.org>; Tue,  9 Nov 2021 23:42:58 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mkiFu-0000hs-Sn; Wed, 10 Nov 2021 08:42:50 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mkiFu-0002yq-3a; Wed, 10 Nov 2021 08:42:50 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mkiFu-0006di-2T; Wed, 10 Nov 2021 08:42:50 +0100
Date:   Wed, 10 Nov 2021 08:42:47 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] spidev: Make probe to fail early if a spidev compatible
 is used
Message-ID: <20211110074247.g7eaq2z27bwdt4m5@pengutronix.de>
References: <20211109225920.1158920-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nfoclihioau7m6h4"
Content-Disposition: inline
In-Reply-To: <20211109225920.1158920-1-javierm@redhat.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--nfoclihioau7m6h4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Nov 09, 2021 at 11:59:20PM +0100, Javier Martinez Canillas wrote:
> Some Device Trees don't use a real device name in the compatible string
> for SPI devices nodes, abusing the fact that the spidev driver name is
> used to match as a fallback when a SPI device ID table is not defined.
>=20
> But since commit 6840615f85f6 ("spi: spidev: Add SPI ID table") a table
> for SPI device IDs was added to the driver breaking the assumption that
> these DTs were relying on.
>=20
> There has been a warning message for some time since commit 956b200a846e
> ("spi: spidev: Warn loudly if instantiated from DT as "spidev""), making
> quite clear that this case is not really supported by the spidev driver.
>=20
> Since these devices won't match anyways after the mentioned commit, there
> is no point to continue if an spidev compatible is used. Let's just make
> the driver probe to fail early.
>=20
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Up to 6840615f85f6 the choices you had to use the spidev driver were
(assuing a dt machine):

 a) Use compatible =3D "spidev" and ignore the warning
 b) Use compatible =3D $chipname and add $chipname to the list of
    supported devices for the spidev driver. (e.g. "rohm,dh2228fv")
 c) Use compatible =3D $chipname and force binding the spidev driver using

   	echo spidev > /sys/bus/spi/devices/spiX.Y/driver_override
	echo spiX.Y > /sys/bus/spi/drivers/spidev/bind

Commit 6840615f85f6 changed that in situation a) you had to switch to c)
(well, or b) adding "spidev" to the spi id list).

With the change introduced by this patch, you make it impossible to bind
the spidev driver to such a device (without kernel source changes) even
using approach c). I wonder if this is too harsh given that changing the
dtb is difficult on some machines.

I think I prefer the status quo that people who use plain "spidev" as
compatible now have to do c) and get the warning. Maybe they notice that
they could switch to using the right chipname now to improve their
situation where the procedure to use the device is identical but the
warning is gone.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--nfoclihioau7m6h4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGLd/QACgkQwfwUeK3K
7AlEGQf8CNgJMktFMSslif/NhnSXuAWoD9SF0cBHqIoolZM4jX3mYpWnpNUquAI4
ByYQmOkj5UaG2v11h0Z9aW1qlcOg8GBXH1j8R2Y43hgYOIbfT3M4NDoLgQUFSzzD
XElKRM/eHLrElcFLyrDKYDyE5oaMXvZ4Z1ZRgbQZoxA/WJz2pdyT8dlMZVNcD/K7
rlwprDAd/OiP8jEnOEj331obx+EHhIo5P8mOZVNKe5H0+vnK3tVLd4R3wobYnUib
dbwGLmSaxuwDkRMiganEZuP+CANH/VTG/OWQyojwD9v9/dw+VjIPr911+Q2dFjhZ
VHJkoYDMe1b3KoT2ic4hQ67oxdcf4g==
=F0mH
-----END PGP SIGNATURE-----

--nfoclihioau7m6h4--
