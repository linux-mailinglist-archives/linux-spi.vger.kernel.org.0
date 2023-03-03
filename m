Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958986A9DEC
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjCCRpO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjCCRpO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:45:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0A713516
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:45:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBE99617B4
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 17:45:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2081C433EF;
        Fri,  3 Mar 2023 17:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677865512;
        bh=YEsOAGjW3wJ37nuzTUD4sEHtd/rS1uMDhbqFEzFllKE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X8LaqiNwqZkZpRfb6NhoC5VG/47ZqUKMTAYGJlWDrLgQIgnsoam/K+k9E5aHUhl/f
         3CIM1+0p94nWeKCWApYvP15m2JxE7+kJk+qSu2zbsM8nCDJCMuacw05gyvTacN76vG
         TE40bT+t1WZpVCfQVLDycbKV0T1kgtr4TNOJ+BYGGlc6Wy8B0cgi4bW7po9JFpX4Zm
         GXRe7JbQILUWpWOrJtPN0P5qmxrKWXPkEr8GG9J1BruQXPi/VhF8kg3eFGW7KRaEbS
         +eZeBouRXgwYwkWhYDDeFUXxJdjdyxUTHV1sro85qkF/36ZDmRvlw0QqaxdWu1fDQx
         Q9GqO93aJXEOA==
Date:   Fri, 3 Mar 2023 17:45:08 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 36/87] spi: microchip-core-qspi: Convert to platform
 remove callback returning void
Message-ID: <5a1747b5-ad3f-41c9-bc1b-0319ee88de76@spud>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
 <20230303172041.2103336-37-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SnlvmsQuXmNAf7KZ"
Content-Disposition: inline
In-Reply-To: <20230303172041.2103336-37-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--SnlvmsQuXmNAf7KZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 03, 2023 at 06:19:50PM +0100, Uwe Kleine-K=F6nig wrote:
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
>  drivers/spi/spi-microchip-core-qspi.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/spi/spi-microchip-core-qspi.c b/drivers/spi/spi-micr=
ochip-core-qspi.c
> index 19a6a46829f6..4f76ddf97b10 100644
> --- a/drivers/spi/spi-microchip-core-qspi.c
> +++ b/drivers/spi/spi-microchip-core-qspi.c
> @@ -566,7 +566,7 @@ static int mchp_coreqspi_probe(struct platform_device=
 *pdev)
>  	return ret;
>  }
> =20
> -static int mchp_coreqspi_remove(struct platform_device *pdev)
> +static void mchp_coreqspi_remove(struct platform_device *pdev)
>  {
>  	struct mchp_coreqspi *qspi =3D platform_get_drvdata(pdev);
>  	u32 control =3D readl_relaxed(qspi->regs + REG_CONTROL);
> @@ -575,8 +575,6 @@ static int mchp_coreqspi_remove(struct platform_devic=
e *pdev)
>  	control &=3D ~CONTROL_ENABLE;
>  	writel_relaxed(control, qspi->regs + REG_CONTROL);
>  	clk_disable_unprepare(qspi->clk);
> -
> -	return 0;
>  }
> =20
>  static const struct of_device_id mchp_coreqspi_of_match[] =3D {
> @@ -591,7 +589,7 @@ static struct platform_driver mchp_coreqspi_driver =
=3D {
>  		.name =3D "microchip,coreqspi",
>  		.of_match_table =3D mchp_coreqspi_of_match,
>  	},
> -	.remove =3D mchp_coreqspi_remove,
> +	.remove_new =3D mchp_coreqspi_remove,
>  };
>  module_platform_driver(mchp_coreqspi_driver);
> =20
> --=20
> 2.39.1
>=20

--SnlvmsQuXmNAf7KZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZAIyJAAKCRB4tDGHoIJi
0gaIAQD67FENv5CFm3XI2rGFd91cNd5KQi6z2ITLjp6N5BPwoQD9Ghd5ncasQ/Y2
IwdvWr6QB32McNURMyELW7tbReeEbAg=
=PldB
-----END PGP SIGNATURE-----

--SnlvmsQuXmNAf7KZ--
