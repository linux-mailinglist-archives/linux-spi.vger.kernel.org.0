Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E16456B0E
	for <lists+linux-spi@lfdr.de>; Fri, 19 Nov 2021 08:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbhKSHsj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 19 Nov 2021 02:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbhKSHsj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 19 Nov 2021 02:48:39 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6625C061574
        for <linux-spi@vger.kernel.org>; Thu, 18 Nov 2021 23:45:37 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mnyaS-0000Qv-94; Fri, 19 Nov 2021 08:45:32 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mnyaR-000Qqq-7r; Fri, 19 Nov 2021 08:45:30 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mnyaQ-0004cr-1S; Fri, 19 Nov 2021 08:45:30 +0100
Date:   Fri, 19 Nov 2021 08:45:29 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-spi@vger.kernel.org, Ralph Siemsen <ralph.siemsen@linaro.org>
Subject: Re: [PATCH] spi: docs: improve the SPI userspace API documentation
Message-ID: <20211119074529.cvi5zldkuofl4nl5@pengutronix.de>
References: <20211118213143.2345041-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="deyep7z4ekkvfmlh"
Content-Disposition: inline
In-Reply-To: <20211118213143.2345041-1-javierm@redhat.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--deyep7z4ekkvfmlh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 18, 2021 at 10:31:43PM +0100, Javier Martinez Canillas wrote:
> This doc is fairly outdated and only uses legacy device instantiation
> terminology. Let us update it and also mention the OF and ACPI device
> tables, to make easier for users to figure out how should be defined.
>=20
> Also, mention that devices bind could be done in user-space now using
> the "driver_override" sysfs entry.
>=20
> Suggested-by: Ralph Siemsen <ralph.siemsen@linaro.org>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>=20
>  Documentation/spi/spidev.rst | 34 +++++++++++++++++++++++++++++-----
>  1 file changed, 29 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/spi/spidev.rst b/Documentation/spi/spidev.rst
> index f05dbc5ccdbc..ec0986ae6170 100644
> --- a/Documentation/spi/spidev.rst
> +++ b/Documentation/spi/spidev.rst
> @@ -29,15 +29,39 @@ of the driver stack) that are not accessible to users=
pace.
> =20
>  DEVICE CREATION, DRIVER BINDING
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> -The simplest way to arrange to use this driver is to just list it in the
> -spi_board_info for a device as the driver it should use:  the "modalias"
> -entry is "spidev", matching the name of the driver exposing this API.
> +
> +The spidev driver contains lists of SPI devices that are supported for
> +the different hardware topology representations.
> +
> +The following are the SPI device tables supported by the spidev driver:
> +
> +    - struct spi_device_id spidev_spi_ids[]: list of devices that can be
> +      bound when these are defined using a struct spi_board_info with a
> +      .modalias field matching one of the entries in the table.
> +
> +    - struct of_device_id spidev_dt_ids[]: list of devices that can be
> +      bound when these are defined using a Device Tree node that has a
> +      compatible string matching one of the entries in the table.
> +
> +    - struct acpi_device_id spidev_acpi_ids[]: list of devices that can
> +      be bound when these are defined using a ACPI device object with a
> +      _HID matching one of the entries in the table.
> +
> +NOTE: it used to be supported to define an SPI device using the "spidev"
> +      name.  For example as .modalias =3D "spidev" or compatible =3D "sp=
idev".
> +      But this is no longer supported by the Linux kernel and instead a
> +      real SPI device name as listed in one of the tables should be used.
> +
>  Set up the other device characteristics (bits per word, SPI clocking,
>  chipselect polarity, etc) as usual, so you won't always need to override
>  them later.
> =20
> -(Sysfs also supports userspace driven binding/unbinding of drivers to
> -devices.  That mechanism might be supported here in the future.)
> +Sysfs also supports userspace driven binding/unbinding of drivers to
> +devices.  The mechanism works by writing to the device "driver_overrride"
> +entry.  For example:

I'd write here:

	Sysfs also supports userspace driven binding/unbinding of
	drivers to devices that don't bind automatically using one of
	the tables above. To make the spidev driver bind to such a
	device, use:

> +
> +    echo spidev > /sys/bus/spi/devices/spiX.Y/driver_override
> +    echo spiB.C > /sys/bus/spi/drivers/spidev/bind
> =20
>  When you do that, the sysfs node for the SPI device will include a child
>  device node with a "dev" attribute that will be understood by udev or md=
ev.

What is "that" here? (Maybe this refers to "Set up the other device
characteristics [...] as usual"? Is the effect still accurate?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--deyep7z4ekkvfmlh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGXVhcACgkQwfwUeK3K
7Anytgf7Bz4gByZdX3Ket1iLFvyR857aWGo6UcIKLwloxvlvbt+rLs8wXYu8s1mb
AlolduBZsm0XH2XTvGgnXZdWKwBEVtZfw/K0ljq01KtQ1nQajcAZMv5/aaKoDc1r
gM8MBmzu6DpLFmhIzQIFPYhqw8CWmmC3zbZF1XhOYdExpUUoSaS8Wa3+Zu9SV3XG
W985dwebxZeU7xJ6SoAoxSTiLzis5r6iIXvQgLK55g1CEeMPLme6QZslbLFMfv5n
+KRL1uAqnuTDruzJb/29UYxcJNuibuMedClczzA4tWI6xBDdZqkfqjdgXI0joIRq
WHWvz6AN1UPwMpqRgdzph+4LpChD9w==
=di6v
-----END PGP SIGNATURE-----

--deyep7z4ekkvfmlh--
