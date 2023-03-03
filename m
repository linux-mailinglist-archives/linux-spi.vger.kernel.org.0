Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5496A9DEB
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjCCRo5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjCCRox (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:44:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D98B13516
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:44:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B880B8191E
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 17:44:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6517CC433EF;
        Fri,  3 Mar 2023 17:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677865490;
        bh=xud2gjW8VOUUIuL3oEVZaetezfIAxATDZm0MEYpXJ04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QkI9UA1D+NMSFv2UV4A7tlAYDYtfXBKmL2vzeX+TSNht1hgVo/7uekqpsvLYIfdCr
         Gm3IIdc4s46pt1ZxFe0ujEsfZ0RCAsdNHpz/InR1tV5kkeg8KiU5M/AZtYiQog4TkJ
         b9YOH1/S6jnsAO//qcNfpCD8R76OlFLBR71BAWfukVCF9UkAPdG/vS50c13SVYYmct
         QxQeHZBX1XR5FEoFMCZnRratoeE/F2Ecud+zRfzKp+mSlwHwzAcDH6h8i1fgrz9mlB
         i2lK9E2edvRYvsa2moTadXj/EYVs27VSRnNQ3xmOLpnwUcfLHZn6IU0iiqO29l3T8G
         lNMvsKDTXJHFw==
Date:   Fri, 3 Mar 2023 17:44:45 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 37/87] spi: microchip-core: Convert to platform remove
 callback returning void
Message-ID: <7aee8e72-d7f5-4f13-8b8b-81feaf394ce7@spud>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
 <20230303172041.2103336-38-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iAZQem5ygUBbukJK"
Content-Disposition: inline
In-Reply-To: <20230303172041.2103336-38-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--iAZQem5ygUBbukJK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 03, 2023 at 06:19:51PM +0100, Uwe Kleine-K=F6nig wrote:
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

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  drivers/spi/spi-microchip-core.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/spi/spi-microchip-core.c b/drivers/spi/spi-microchip=
-core.c
> index aeaa1da88f39..e6cf6ff08061 100644
> --- a/drivers/spi/spi-microchip-core.c
> +++ b/drivers/spi/spi-microchip-core.c
> @@ -566,7 +566,7 @@ static int mchp_corespi_probe(struct platform_device =
*pdev)
>  	return 0;
>  }
> =20
> -static int mchp_corespi_remove(struct platform_device *pdev)
> +static void mchp_corespi_remove(struct platform_device *pdev)
>  {
>  	struct spi_master *master  =3D platform_get_drvdata(pdev);
>  	struct mchp_corespi *spi =3D spi_master_get_devdata(master);
> @@ -574,8 +574,6 @@ static int mchp_corespi_remove(struct platform_device=
 *pdev)
>  	mchp_corespi_disable_ints(spi);
>  	clk_disable_unprepare(spi->clk);
>  	mchp_corespi_disable(spi);
> -
> -	return 0;
>  }
> =20
>  #define MICROCHIP_SPI_PM_OPS (NULL)
> @@ -599,7 +597,7 @@ static struct platform_driver mchp_corespi_driver =3D=
 {
>  		.pm =3D MICROCHIP_SPI_PM_OPS,
>  		.of_match_table =3D of_match_ptr(mchp_corespi_dt_ids),
>  	},
> -	.remove =3D mchp_corespi_remove,
> +	.remove_new =3D mchp_corespi_remove,
>  };
>  module_platform_driver(mchp_corespi_driver);
>  MODULE_DESCRIPTION("Microchip coreSPI SPI controller driver");
> --=20
> 2.39.1
>=20

--iAZQem5ygUBbukJK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZAIyDQAKCRB4tDGHoIJi
0gjEAP4iTpLd9NzvzdbUUnK7BPLTDps60QAtbMaVC690u8EhgwEAzXhkz29RTq/J
uXXQX+BftEtLzsAEQ+xwTcJo//Xe2Ag=
=dG4f
-----END PGP SIGNATURE-----

--iAZQem5ygUBbukJK--
