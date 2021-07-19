Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA3F23CCFAF
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jul 2021 11:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235705AbhGSITP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Jul 2021 04:19:15 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47861 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235286AbhGSITM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 19 Jul 2021 04:19:12 -0400
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m5OVc-0008U8-OD; Mon, 19 Jul 2021 10:20:16 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m5OVb-0001mx-WD; Mon, 19 Jul 2021 10:20:16 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m5OVb-0007XW-V1; Mon, 19 Jul 2021 10:20:15 +0200
Date:   Mon, 19 Jul 2021 10:20:15 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: imx: mx51-ecspi: Fix low-speed CONFIGREG delay
 calculation
Message-ID: <20210719082015.ud43iwg5rfdomlqi@pengutronix.de>
References: <20210718211143.143557-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zpchixjek4djffbp"
Content-Disposition: inline
In-Reply-To: <20210718211143.143557-1-marex@denx.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--zpchixjek4djffbp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 18, 2021 at 11:11:43PM +0200, Marek Vasut wrote:
> The spi_imx->spi_bus_clk may be uninitialized and thus also zero in
> mx51_ecspi_prepare_message(), which would lead to division by zero
> in kernel. Since bitbang .setup_transfer callback which initializes
> the spi_imx->spi_bus_clk is called after bitbang prepare_message
> callback, iterate over all the transfers in spi_message, find the
> one with lowest bus frequency, and use that bus frequency for the
> delay calculation.
>=20
> Note that it is not possible to move this CONFIGREG delay back into
> the .setup_transfer callback, because that is invoked too late, after
> the GPIO chipselects were already configured.
>=20
> Fixes: 135cbd378eab ("spi: imx: mx51-ecspi: Reinstate low-speed CONFIGREG=
 delay")
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Cc: Mark Brown <broonie@kernel.org>
> ---
> Sigh ...
> ---
>  drivers/spi/spi-imx.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 4aee3db6d6df..e18338fc3108 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -505,7 +505,9 @@ static int mx51_ecspi_prepare_message(struct spi_imx_=
data *spi_imx,
>  				      struct spi_message *msg)
>  {
>  	struct spi_device *spi =3D msg->spi;
> +	struct spi_transfer *xfer;
>  	u32 ctrl =3D MX51_ECSPI_CTRL_ENABLE;
> +	u32 min_speed_hz =3D ~0U;
>  	u32 testreg, delay;
>  	u32 cfg =3D readl(spi_imx->base + MX51_ECSPI_CONFIG);
> =20
> @@ -578,7 +580,13 @@ static int mx51_ecspi_prepare_message(struct spi_imx=
_data *spi_imx,
>  	 * the SPI communication as the device on the other end would consider
>  	 * the change of SCLK polarity as a clock tick already.
>  	 */
> -	delay =3D (2 * 1000000) / spi_imx->spi_bus_clk;
> +	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
> +		if (!xfer->speed_hz)
> +			continue;
> +		min_speed_hz =3D min(xfer->speed_hz, min_speed_hz);
> +	}

Can it happen that all transfer's spped_hz are zero?

> +
> +	delay =3D (2 * 1000000) / min_speed_hz;

Orthogonal to your change: I wonder if we need to round up the division
here.

>  	if (likely(delay < 10))	/* SCLK is faster than 100 kHz */
>  		udelay(delay);
>  	else			/* SCLK is _very_ slow */

Also the comments are wrong here. Is SCLK is 150 kHz we have
min_speed_hz =3D 150000, right? Then delay becomes 13 and the slow freq
path is entered. The right comment (when keeping delay =3D (2 * 1000000) /
min_speed_hz) would be

	if (likely(delay < 10)) /* SCLK is faster than 181.818 kHz */

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zpchixjek4djffbp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmD1NbwACgkQwfwUeK3K
7AlJOgf+PVkTxSAnKDBnXbOhYjjhUgcRWwrMBBpwNeUjN7BW3HazhiPVYdWWmfdi
1Dk4l3cWcKjxHp2dBOaCZO2vR8uqXEKZgsDopQQwh68hzA8P8CAJqxLBF1MeE9lE
lXWYoOK9QA9BobhK6tPtxu969LRNeVLY54H6JHd7hnrxqMI9wxEGLu7sWpFWrXok
WPckoeV2OQlOvWgCwblRQ0cUlxkXdRIEmsYWtivYnzieFlE0ZuxrGDa0plDLbIuo
w0LKX4C00ZiMst0MQIjxSP36T7MNXYgf+rNh3RWaasFT5+9EjICHGUQhzbfgTiq3
y0LyCXmppLEomh4lRaOD0v9OjtcW8w==
=SrzY
-----END PGP SIGNATURE-----

--zpchixjek4djffbp--
