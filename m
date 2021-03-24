Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEC13482D5
	for <lists+linux-spi@lfdr.de>; Wed, 24 Mar 2021 21:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238106AbhCXUXR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 24 Mar 2021 16:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238077AbhCXUXD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 24 Mar 2021 16:23:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6CAC061763
        for <linux-spi@vger.kernel.org>; Wed, 24 Mar 2021 13:23:03 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lPA1q-00024w-Ra; Wed, 24 Mar 2021 21:22:58 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lPA1q-0001th-Hu; Wed, 24 Mar 2021 21:22:58 +0100
Date:   Wed, 24 Mar 2021 21:22:58 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-clk@vger.kernel.org, kernel@pengutronix.de,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: davinci: Simplify using devm_clk_get_prepared()
Message-ID: <20210324202258.bossedmrhj35nyvc@pengutronix.de>
References: <20210301135053.1462168-1-u.kleine-koenig@pengutronix.de>
 <20210324201723.76299-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h2ekt5s5ojowan2a"
Content-Disposition: inline
In-Reply-To: <20210324201723.76299-1-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--h2ekt5s5ojowan2a
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 24, 2021 at 09:17:23PM +0100, Uwe Kleine-K=F6nig wrote:
> devm_clk_get_prepared returns the clk already prepared and the
> automatically called cleanup cares for unpreparing. So simplify .probe
> and .remove accordingly.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>=20
> this simplification depends on a patch set that introduces
> devm_clk_get_prepared() and friends.
>=20
> The most recent version of this patch set can be found at
>=20
> 	https://lore.kernel.org/r/20210301135053.1462168-1-u.kleine-koenig@pengu=
tronix.de
>=20
> Unfortunately I didn't get any feedback at all from the clk maintainers
> on it, so I try to make other maintainers aware of it in the expectation
> that the simplifications are welcome and so lure the clk maintainers to
> share their thoughts.
>=20
> Best regards
> Uwe
>=20
>  drivers/spi/spi-davinci.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
> index 7453a1dbbc06..c170bccf9710 100644
> --- a/drivers/spi/spi-davinci.c
> +++ b/drivers/spi/spi-davinci.c
> @@ -936,14 +936,11 @@ static int davinci_spi_probe(struct platform_device=
 *pdev)
> =20
>  	dspi->bitbang.master =3D master;
> =20
> -	dspi->clk =3D devm_clk_get(&pdev->dev, NULL);
> +	dspi->clk =3D devm_clk_get_prepared(&pdev->dev, NULL);

oops, I got that wrong, this must be devm_clk_get_enabled, not
devm_clk_get_prepared. So if the clk patches go in, please let me resend
a fixed patch (or adapt yourself, whatever you prefer).

Best regards
Uwe

>  	if (IS_ERR(dspi->clk)) {
>  		ret =3D -ENODEV;
>  		goto free_master;
>  	}
> -	ret =3D clk_prepare_enable(dspi->clk);
> -	if (ret)
> -		goto free_master;

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--h2ekt5s5ojowan2a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBbn58ACgkQwfwUeK3K
7An0Kwf9Gb6Gap7dLohuhBIvvIaava8POgNLy14HJ9c7+b12IkeLadFXClal9etN
1hyF0idewSJvQ4M2jfRUG6L26/Gml8vgKS+std15q98TzC35i/21cwS7H9fbfKBF
qbqsZR+k+7uV7rV9guBJshVVX03sIs2O9DpfndQsoxFpEqWHuHiFLE+loGwKXMp/
3i1+fa3Ngb9y5k3RfA4kvXWMDC0FJirUgfmOWNvZJnmxw8FB8tdPjKjc2M3bq44j
NIazz/rxRGGkCsjEBPT3Rnr11S2jGZGAig4L10RXpMAveiorKD3TRVrJqEG6g616
PaN2hZgqLteBl9lcj5nSWcUs2WzVKQ==
=9DaC
-----END PGP SIGNATURE-----

--h2ekt5s5ojowan2a--
