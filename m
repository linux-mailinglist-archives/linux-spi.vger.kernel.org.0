Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23504273EAF
	for <lists+linux-spi@lfdr.de>; Tue, 22 Sep 2020 11:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgIVJju (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Sep 2020 05:39:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:49794 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgIVJju (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 22 Sep 2020 05:39:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A4A4EAC4F;
        Tue, 22 Sep 2020 09:40:25 +0000 (UTC)
Message-ID: <270b94fd1e546d0c17a735c1f55500e58522da04.camel@suse.de>
Subject: Re: [PATCH 3/6] spi: bcm2835: Use devm_spi_register_controller()
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Sascha Hauer <s.hauer@pengutronix.de>, linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Daniel Mack <daniel@zonque.org>, kernel@pengutronix.de
Date:   Tue, 22 Sep 2020 11:39:47 +0200
In-Reply-To: <20200922093228.24917-4-s.hauer@pengutronix.de>
References: <20200922093228.24917-1-s.hauer@pengutronix.de>
         <20200922093228.24917-4-s.hauer@pengutronix.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-VCD8u1R2vOIg7SzxG860"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--=-VCD8u1R2vOIg7SzxG860
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-09-22 at 11:32 +0200, Sascha Hauer wrote:
> Calling spi_unregister_controller() during driver remove results in
> freeing the SPI controller and the associated driver data. Using it
> later in bcm2835_spi_remove() is a use-after-free bug. Register the
> controller with devm_spi_register_controller() instead which makes
> calling spi_unregister_controller() unnecessary.
>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---

Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

>  drivers/spi/spi-bcm2835.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
> index c45d76c848c8..d22103f7beeb 100644
> --- a/drivers/spi/spi-bcm2835.c
> +++ b/drivers/spi/spi-bcm2835.c
> @@ -1350,7 +1350,7 @@ static int bcm2835_spi_probe(struct platform_device=
 *pdev)
>  		goto out_dma_release;
>  	}
> =20
> -	err =3D spi_register_controller(ctlr);
> +	err =3D devm_spi_register_controller(&pdev->dev, ctlr);
>  	if (err) {
>  		dev_err(&pdev->dev, "could not register SPI controller: %d\n",
>  			err);
> @@ -1377,8 +1377,6 @@ static int bcm2835_spi_remove(struct platform_devic=
e *pdev)
> =20
>  	bcm2835_debugfs_remove(bs);
> =20
> -	spi_unregister_controller(ctlr);
> -
>  	bcm2835_dma_release(ctlr, bs);
> =20
>  	/* Clear FIFOs, and disable the HW block */


--=-VCD8u1R2vOIg7SzxG860
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl9pxmMACgkQlfZmHno8
x/7ETAf/V5cUTCMr9wzC5TDwoJIDecjF/sQL70N8kiiyMHd/hiFyHuWmrQfgYvug
SO/NT1MtwdMJDFCedUca3k1TQlqsPkH/WyYnevDDSNATMCWQjWp7I3KLYLErX4aE
2wig/Gy6PIYQP/NOCUVwPL+Uh8L4mjkuibJnwButTaQJG2Pm8oZv+Ah4t1t8MYhm
+qS75iZ04uVMqhTyvdEY9IyBi0C33LGnvIiGpyE/pM3GxI0K7TkTrg65k0zViXkE
7koTX0QCt0+qybxOo9xsvI554eRVJtwFSINwc/FHR/gBkj1AeP/qmX8xc1/SC7fq
nxrcJvAiz8fbhtkD5s36kBO8+FShgA==
=yebQ
-----END PGP SIGNATURE-----

--=-VCD8u1R2vOIg7SzxG860--

