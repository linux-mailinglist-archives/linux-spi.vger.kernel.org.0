Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA0B6A9DEE
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjCCRqR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjCCRqR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:46:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5A0211E6
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:46:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7917617B4
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 17:46:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD29C433EF;
        Fri,  3 Mar 2023 17:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677865575;
        bh=MbXnQWJrgabQ7xrZZxnWxuZFeO/RGxBxyJ6Le1YAXTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mQ4IXYSrgP/31fCn+Cpk5Rk9dgoUoN0FR+/9oiLIggayWkzmCltCxusWtkQYFzImV
         i+OQGbxy5madmr3qmnv0EzN3mY3eGXVaOty1WtoT4oprMAMrAXZC+qWzkylORA39mc
         Ask93QeXuNUr80s0Mb0plyjn96shqKc8k/A/gKCMxu1e9NKgcewhAdOSDGvFI9yIs/
         cc4IV6dDOJEnx53iEg50RshHrJ6e9jEh0pHacNFfitUt2z0kG/G6VS+bqRkS3uE60k
         tVjLfKs7DvrYatxbn24ORKYvoXcKuVLsFBWcCi1wgqGv+A8U3JHrCv9oJYIMBXqKuD
         nFy+08YKWf+Rg==
Date:   Fri, 3 Mar 2023 17:46:11 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-spi@vger.kernel.org, linux-riscv@lists.infradead.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 67/87] spi: sifive: Convert to platform remove callback
 returning void
Message-ID: <1f3f97a1-f335-45c0-980b-b0847cd8ad90@spud>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
 <20230303172041.2103336-68-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uHONYmu2di5L89hc"
Content-Disposition: inline
In-Reply-To: <20230303172041.2103336-68-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--uHONYmu2di5L89hc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 03, 2023 at 06:20:21PM +0100, Uwe Kleine-K=F6nig wrote:
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

This one landed in my mailbox too, so:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  drivers/spi/spi-sifive.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/spi/spi-sifive.c b/drivers/spi/spi-sifive.c
> index e29e85cee88a..055de44e0d22 100644
> --- a/drivers/spi/spi-sifive.c
> +++ b/drivers/spi/spi-sifive.c
> @@ -415,7 +415,7 @@ static int sifive_spi_probe(struct platform_device *p=
dev)
>  	return ret;
>  }
> =20
> -static int sifive_spi_remove(struct platform_device *pdev)
> +static void sifive_spi_remove(struct platform_device *pdev)
>  {
>  	struct spi_master *master =3D platform_get_drvdata(pdev);
>  	struct sifive_spi *spi =3D spi_master_get_devdata(master);
> @@ -423,8 +423,6 @@ static int sifive_spi_remove(struct platform_device *=
pdev)
>  	/* Disable all the interrupts just in case */
>  	sifive_spi_write(spi, SIFIVE_SPI_REG_IE, 0);
>  	clk_disable_unprepare(spi->clk);
> -
> -	return 0;
>  }
> =20
>  static int sifive_spi_suspend(struct device *dev)
> @@ -473,7 +471,7 @@ MODULE_DEVICE_TABLE(of, sifive_spi_of_match);
> =20
>  static struct platform_driver sifive_spi_driver =3D {
>  	.probe =3D sifive_spi_probe,
> -	.remove =3D sifive_spi_remove,
> +	.remove_new =3D sifive_spi_remove,
>  	.driver =3D {
>  		.name =3D SIFIVE_SPI_DRIVER_NAME,
>  		.pm =3D &sifive_spi_pm_ops,
> --=20
> 2.39.1
>=20

--uHONYmu2di5L89hc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZAIyYwAKCRB4tDGHoIJi
0uIkAP4kBmoKZhSq2On5nc3o6E9J+Hl4JZEqZ0Ah4NAF0Rp7IwEAyv1URNiBV8Ig
+/8h9wi8+fy7DY1Gx7E7lLaHvvkQkgQ=
=Cx8Z
-----END PGP SIGNATURE-----

--uHONYmu2di5L89hc--
