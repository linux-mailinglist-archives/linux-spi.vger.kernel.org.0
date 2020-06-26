Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B99D20AC01
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jun 2020 07:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbgFZF70 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Jun 2020 01:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgFZF7Z (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 Jun 2020 01:59:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E88C08C5C1
        for <linux-spi@vger.kernel.org>; Thu, 25 Jun 2020 22:59:25 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1johOT-0007vN-74; Fri, 26 Jun 2020 07:59:21 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1johOR-0008J8-Rw; Fri, 26 Jun 2020 07:59:19 +0200
Date:   Fri, 26 Jun 2020 07:59:19 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Robin Gong <yibin.gong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Trent Piepho <tpiepho@impinj.com>
Subject: Re: [PATCH] spi: imx/fsl-lpspi: Convert to GPIO descriptors
Message-ID: <20200626055919.bthsyx7ey7gpxkno@taurus.defre.kleine-koenig.org>
References: <20200625200252.207614-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="64tfpdfgzzinjn63"
Content-Disposition: inline
In-Reply-To: <20200625200252.207614-1-linus.walleij@linaro.org>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--64tfpdfgzzinjn63
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2020 at 10:02:52PM +0200, Linus Walleij wrote:
> This converts the two Freescale i.MX SPI drivers
> Freescale i.MX (CONFIG_SPI_IMX) and Freescale i.MX LPSPI
> (CONFIG_SPI_FSL_LPSPI) to use GPIO descriptors handled in
> the SPI core for GPIO chip selects whether defined in
> the device tree or a board file.
>=20
> The reason why both are converted at the same time is
> that they were both using the same platform data and
> platform device population helpers when using
> board files intertwining the code so this gives a cleaner
> cut.
>=20
> The platform device creation was passing a platform data
> container from each boardfile down to the driver using
> struct spi_imx_master from <linux/platform_data/spi-imx.h>,
> but this was only conveying the number of chipselects and
> an int * array of the chipselect GPIO numbers.
>=20
> The imx27 and imx31 platforms had code passing the
> now-unused platform data when creating the platform devices,
> this has been repurposed to pass around GPIO descriptor
> tables. The platform data struct that was just passing an
> array of integers and number of chip selects for the GPIO
> lines has been removed.
>=20
> The number of chipselects used to be passed from the board
> file, because this number also limits the number of native
> chipselects that the platform can use. To deal with this we
> just augment the i.MX (CONFIG_SPI_IMX) driver to support 3
> chipselects if the platform does not define "num-cs" as a
> device property (such as from the device tree). This covers
> all the legacy boards as these use <=3D 3 native chip selects
> (or GPIO lines, and in that case the number of chip selects
> is determined by the core from the number of available
> GPIO lines). Any new boards should use device tree, so
> this is a reasonable simplification to cover all old
> boards.
>=20
> The LPSPI driver never assigned the number of chipselects
> and thus always fall back to the core default of 1 chip
> select if no GPIOs are defined in the device tree.
>=20
> The Freescale i.MX driver was already partly utilizing
> the SPI core to obtain the GPIO numbers from the device tree,
> so this completes the transtion to let the core handle all
> of it.
>=20
> All board files and the core i.MX boardfile registration
> code is augmented to account for these changes.
>=20
> This has been compile-tested with the imx_v4_v5_defconfig
> and the imx_v6_v7_defconfig.
>=20
> Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Cc: Robin Gong <yibin.gong@nxp.com>
> Cc: Trent Piepho <tpiepho@impinj.com>
> Cc: Clark Wang <xiaoning.wang@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/mach-imx/devices-imx27.h            | 10 +--
>  arch/arm/mach-imx/devices-imx31.h            | 10 +--
>  arch/arm/mach-imx/devices/devices-common.h   |  5 +-
>  arch/arm/mach-imx/devices/platform-spi_imx.c |  9 +-
>  arch/arm/mach-imx/mach-mx27_3ds.c            | 40 ++++++---
>  arch/arm/mach-imx/mach-mx31_3ds.c            | 13 +--
>  arch/arm/mach-imx/mach-mx31lilly.c           | 14 +--
>  arch/arm/mach-imx/mach-mx31lite.c            | 19 +---
>  arch/arm/mach-imx/mach-mx31moboard.c         | 12 +--
>  arch/arm/mach-imx/mach-pca100.c              | 21 +++--
>  arch/arm/mach-imx/mach-pcm037_eet.c          |  7 +-

I'm not sure I'd bother with these. I didn't see board files in use any
more since quite some time. I suggest to delete them instead. (Or break
them by doing the spi driver conversion without adapting them?)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--64tfpdfgzzinjn63
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl71jrQACgkQwfwUeK3K
7AnjiQf9FdpcNR98RfrDEsf9vsWJ0oR28T3HTxGgKOia9+0ZbkG/sUvr057QpHV7
rGOTqjSETj1dr+g9SQjjHZEYm1K8IWmCsU+xo3rahxOTpMYkilK2zmI964g4nAE3
eYF4yqtXKsvss1micbqd9FiUH815Fkko5v/wScmDT8zBJQ+CnyLdIapmXNhkAv2k
x9n4RBHp8bQNQDJeju4jgKq/GMeTZ9hRd83UO25Wi5Jo4XEg5rTk1NZ6Wv77ATS9
asrlTB+5blRLDLWAi+Lxo9pPSk2d/pUnYuguYgw62Lk/8FdpL5vehz1XEPSqrnSH
DbmA9YdrDXoZmmnWCB8acO13LbPmbA==
=hCe4
-----END PGP SIGNATURE-----

--64tfpdfgzzinjn63--
