Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE8113597F
	for <lists+linux-spi@lfdr.de>; Thu,  9 Jan 2020 13:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgAIMxJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Jan 2020 07:53:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:44292 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbgAIMxJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 9 Jan 2020 07:53:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A79A5B236B;
        Thu,  9 Jan 2020 12:52:56 +0000 (UTC)
Message-ID: <b0f26f7f4c265dc9b14fba1cb4b0d4546da1f45a.camel@suse.de>
Subject: Re: [PATCH] spi: bcm2835: Raise maximum number of slaves to 4
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Lukas Wunner <lukas@wunner.de>, Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Date:   Thu, 09 Jan 2020 13:52:54 +0100
In-Reply-To: <01453fd062de2d49bd74a847e13a0781cbf8143d.1578572268.git.lukas@wunner.de>
References: <01453fd062de2d49bd74a847e13a0781cbf8143d.1578572268.git.lukas@wunner.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-dIc7VbFbXRwHFM7LWXk+"
User-Agent: Evolution 3.34.2 
MIME-Version: 1.0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--=-dIc7VbFbXRwHFM7LWXk+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-01-09 at 13:23 +0100, Lukas Wunner wrote:
> The "RevPi Connect Flat" PLC offered by KUNBUS has 4 slaves attached
> to the BCM2835 SPI master.  Raise the maximum number of slaves in the
> driver accordingly.
>=20
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---

Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Thanks!

>  drivers/spi/spi-bcm2835.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
> index b784c9fdf9ec..11c235879bb7 100644
> --- a/drivers/spi/spi-bcm2835.c
> +++ b/drivers/spi/spi-bcm2835.c
> @@ -68,7 +68,7 @@
>  #define BCM2835_SPI_FIFO_SIZE		64
>  #define BCM2835_SPI_FIFO_SIZE_3_4	48
>  #define BCM2835_SPI_DMA_MIN_LENGTH	96
> -#define BCM2835_SPI_NUM_CS		3   /* raise as necessary */
> +#define BCM2835_SPI_NUM_CS		4   /* raise as necessary */
>  #define BCM2835_SPI_MODE_BITS	(SPI_CPOL | SPI_CPHA | SPI_CS_HIGH \
>  				| SPI_NO_CS | SPI_3WIRE)
> =20


--=-dIc7VbFbXRwHFM7LWXk+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl4XIiYACgkQlfZmHno8
x/53xAgAhpR+IrNKIWkC+R2shaCd4Yj99SBmS3YeSC0RCOwUUDvuXeVsqsIhZ1eT
GFY11ghFtnI1JoRLEoXl+M5G+8d1CQpERaIDWwBkkbZ3IENfieGiqY0a5qRetXIs
w5fWpUkPfZYa44uAwcsXLQ2E8b9dQTopGJlWUk1waFq3H1b0A4AFUD9TqVpg5t+e
QsLTEeYrRNd7HoKy2m9tSF++hpscCGWwYxZYQIBFO0OazrTx73H7x9+Cn+kqjpNd
DFKqhEM+N+TWryl5KcEomerNRlXMT+4UB3xTY9FGWW6PFyIP3/Dq9udiUHHFD7En
GwLzxT78n05uEF0l/QsYdAQ2hlX3OQ==
=gJlq
-----END PGP SIGNATURE-----

--=-dIc7VbFbXRwHFM7LWXk+--

