Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5186AB6BF
	for <lists+linux-spi@lfdr.de>; Mon,  6 Mar 2023 08:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjCFHEm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Mar 2023 02:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjCFHEl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Mar 2023 02:04:41 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95634D307
        for <linux-spi@vger.kernel.org>; Sun,  5 Mar 2023 23:04:40 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ4tc-0004yx-T4; Mon, 06 Mar 2023 08:04:32 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ4ta-002Bv3-Q5; Mon, 06 Mar 2023 08:04:30 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ4tZ-002aAw-R7; Mon, 06 Mar 2023 08:04:29 +0100
Date:   Mon, 6 Mar 2023 08:04:26 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     kernel@pengutronix.de,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 09/87] spi: bcm2835: Convert to platform remove callback
 returning void
Message-ID: <20230306070426.v47fvxf6qncwekyv@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
 <20230303172041.2103336-10-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kmbfjcqmxbvc6y7g"
Content-Disposition: inline
In-Reply-To: <20230303172041.2103336-10-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--kmbfjcqmxbvc6y7g
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 03, 2023 at 06:19:23PM +0100, Uwe Kleine-K=F6nig wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
>=20
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/spi/spi-bcm2835.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
> index 747e03228c48..be6050b513a9 100644
> --- a/drivers/spi/spi-bcm2835.c
> +++ b/drivers/spi/spi-bcm2835.c
> @@ -1398,7 +1398,7 @@ static int bcm2835_spi_probe(struct platform_device=
 *pdev)
>  	return err;
>  }
> =20
> -static int bcm2835_spi_remove(struct platform_device *pdev)
> +static void bcm2835_spi_remove(struct platform_device *pdev)
>  {
>  	struct spi_controller *ctlr =3D platform_get_drvdata(pdev);
>  	struct bcm2835_spi *bs =3D spi_controller_get_devdata(ctlr);
> @@ -1414,17 +1414,11 @@ static int bcm2835_spi_remove(struct platform_dev=
ice *pdev)
>  		   BCM2835_SPI_CS_CLEAR_RX | BCM2835_SPI_CS_CLEAR_TX);
> =20
>  	clk_disable_unprepare(bs->clk);
> -
> -	return 0;
>  }
> =20
>  static void bcm2835_spi_shutdown(struct platform_device *pdev)
>  {
> -	int ret;
> -
> -	ret =3D bcm2835_spi_remove(pdev);
> -	if (ret)
> -		dev_err(&pdev->dev, "failed to shutdown\n");
> +	rbcm2835_spi_remove(pdev);

The kernel build bot found an issue here. There is an 'r' too
much. i.e. we need:

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index be6050b513a9..29445641fff0 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -1418,7 +1418,7 @@ static void bcm2835_spi_remove(struct platform_device=
 *pdev)
=20
 static void bcm2835_spi_shutdown(struct platform_device *pdev)
 {
-	rbcm2835_spi_remove(pdev);
+	bcm2835_spi_remove(pdev);
 }
=20
 static const struct of_device_id bcm2835_spi_match[] =3D {

squashed into the original commit. (I had that uncommitted in my tree
while doing my build tests :-\)

@broonie: how should we proceed here? Is your tree already public and
you need a proper patch to fix this?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--kmbfjcqmxbvc6y7g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmQFkHcACgkQwfwUeK3K
7AlbFAf+KBeZUZ4/GtLojOez7MKNoPiaY8t+ctI9HoVux+foPoOo0yDt2fcF5efQ
yyS/mD+qfDXtHVXXiI7uH5/kx3nGdWWgkKts5PmKWidgVzjJT/f+28M3ce03+V3Z
voW0xbBpDKGrR/xVmK0uMYrdppp6cmMmsZPTboTxc8voxpV2bkXNCDVED3IlnzhB
SJTKdjhqbvOEwrTHm3pOLblNFx6QomfisdFD7uSSY87b0cecJUJy1pJlTp6+OZBg
jDY3ZKKqQS4x+sIBZ0uQbAJCks+Oi0hD2C1yZP3v6kKWiy1nwQTk7wWbOJ4ChW18
kYEQUhVHIq5gCg81JsyGp3dYsqp6yw==
=UlaP
-----END PGP SIGNATURE-----

--kmbfjcqmxbvc6y7g--
