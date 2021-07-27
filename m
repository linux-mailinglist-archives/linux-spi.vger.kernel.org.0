Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073C13D6F72
	for <lists+linux-spi@lfdr.de>; Tue, 27 Jul 2021 08:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235323AbhG0G2y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Jul 2021 02:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234349AbhG0G2x (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 27 Jul 2021 02:28:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4E4C061757
        for <linux-spi@vger.kernel.org>; Mon, 26 Jul 2021 23:28:54 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m8GaC-0003jy-QX; Tue, 27 Jul 2021 08:28:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m8GaC-0005jb-3M; Tue, 27 Jul 2021 08:28:52 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m8GaC-0003vF-2V; Tue, 27 Jul 2021 08:28:52 +0200
Date:   Tue, 27 Jul 2021 08:28:51 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2] spi: imx: mx51-ecspi: Fix low-speed CONFIGREG delay
 calculation
Message-ID: <20210727062851.qnczgbypjestjhlj@pengutronix.de>
References: <20210726100102.5188-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oinyx5u53gaxkubt"
Content-Disposition: inline
In-Reply-To: <20210726100102.5188-1-marex@denx.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--oinyx5u53gaxkubt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Jul 26, 2021 at 12:01:02PM +0200, Marek Vasut wrote:
>  drivers/spi/spi-imx.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 593b63be73de8..cb9f7261c4385 100644
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
> @@ -577,8 +579,20 @@ static int mx51_ecspi_prepare_message(struct spi_imx=
_data *spi_imx,
>  	 * be asserted before the SCLK polarity changes, which would disrupt
>  	 * the SPI communication as the device on the other end would consider
>  	 * the change of SCLK polarity as a clock tick already.
> +	 *
> +	 * Because spi_imx->spi_bus_clk is only set in bitbang prepare_message
> +	 * callback, iterate over all the transfers in spi_message, find the
> +	 * one with lowest bus frequency, and use that bus frequency for the
> +	 * delay calculation. In case all transfers have speed_hz =3D=3D 0, then
> +	 * min_speed_hz is ~0 and the resulting delay is zero.
>  	 */
> -	delay =3D (2 * 1000000) / spi_imx->spi_bus_clk;
> +	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
> +		if (!xfer->speed_hz)
> +			continue;
> +		min_speed_hz =3D min(xfer->speed_hz, min_speed_hz);
> +	}
> +
> +	delay =3D (2 * 1000000) / min_speed_hz;

It might already be too late as Mark already send out his applied mail,
but still:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--oinyx5u53gaxkubt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmD/p6EACgkQwfwUeK3K
7AlBWQgAmDPhlKctDJIvYJbO0i7nnI/OakSm0tumTyt323NakTnEvJwEGqvyu2kg
/xg6mlURRyfAyOBucA8hzqAkfBrM5bMLWgkz9o7WkVskFRHBeWXUZ4KxceLevrQG
FBRGb0CyeAvIrSLG0OzNFyuZ1pcpxSopP6HlpbSIZggxjMPnaY6D6/n9I0nmPrPv
IOkLdvsZaq38PogZW6fHkw3b4BoWvCbbQzw2+WqWo0b4L5slTeFp6rfoitmlbFMY
0sjBTNhJDb4NBiWAaVvjc0IpdC8ZYmR5aoNdDrwvBWqKiYNqkkn2kg2+qYRUkRno
8y8U2Xeao/+NWTGpidmXMsvn8tG/aQ==
=Lg4T
-----END PGP SIGNATURE-----

--oinyx5u53gaxkubt--
