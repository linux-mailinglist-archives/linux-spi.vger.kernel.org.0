Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56F83188D2
	for <lists+linux-spi@lfdr.de>; Thu,  9 May 2019 13:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfEILR0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 May 2019 07:17:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:41362 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725869AbfEILRZ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 9 May 2019 07:17:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CA480AC58;
        Thu,  9 May 2019 11:17:23 +0000 (UTC)
Message-ID: <1529b7b21c9e8cfe096873ed8155af34941aed62.camel@suse.de>
Subject: Re: [PATCH V1 1/3] spi: core: resource: fix memory leak on error
 and place in "correct" sequence
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     kernel@martin.sperl.org,
        Meghana Madhyastha <meghana.madhyastha@gmail.com>,
        Noralf =?ISO-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Mark Brown <broonie@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-spi@vger.kernel.org
Date:   Thu, 09 May 2019 13:17:21 +0200
In-Reply-To: <20190509105533.24275-2-kernel@martin.sperl.org>
References: <20190509105533.24275-1-kernel@martin.sperl.org>
         <20190509105533.24275-2-kernel@martin.sperl.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-GTmPYLNCIfZAc6quO6nR"
User-Agent: Evolution 3.32.1 
MIME-Version: 1.0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--=-GTmPYLNCIfZAc6quO6nR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-05-09 at 10:55 +0000, kernel@martin.sperl.org wrote:
> From: Martin Sperl <kernel@martin.sperl.org>
>=20
> When an error occurs in ctlr->prepare_message or spi_map_msg
> then spi_resources is not cleared leaving unexpected entries and
> memory.
>=20
> Also there is an ordering issue:
> On ititialization:
> * prepare_message
> * spi_map_msg
>=20
> and when releasing:
> * spi_res_release (outside of finalize)
>   -> this restores the spi structures
> * spi_unmap_msg
> * unprepare_message
>=20
> So the ordering is wrong in the case that prepare_message is
> modifying the spi_message and spi_message.resources.
>=20
> Especially the dma unmapping of all the translations are not done.
>=20
> There is still an ambiguity where is the "best" place where to place
> spi_res_release - it definitely has to be after spi_unmap_msg,
> but if it should be before or after unprepare message is not well
> defined.
>=20
> Ideally this dma unmap and unprepare_message would be executed
> by spi_res_release and thus in the guaranteed order they were applied.
>=20
> This incidently implements a better way for the reverted
> commit c9ba7a16d0f1 ("spi: Release spi_res after finalizing message")
>=20
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> ---
>  drivers/spi/spi.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 8eb7460dd744..1dfb19140bbe 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1181,8 +1181,6 @@ static int spi_transfer_one_message(struct
> spi_controller *ctlr,
>  	if (msg->status && ctlr->handle_err)
>  		ctlr->handle_err(ctlr, msg);
>=20
> -	spi_res_release(ctlr, msg);
> -
>  	spi_finalize_current_message(ctlr);
>=20
>  	return ret;
> @@ -1448,6 +1446,15 @@ void spi_finalize_current_message(struct spi_contr=
oller
> *ctlr)
>  		}
>  	}
>=20
> +	/* where to put the release is a slight nightmare because
> +	 * ctlr->prepare_message may add to resources as well.
> +	 * so the question is: call it before unprepare or after?
> +	 * for now leave it after - the asumption here is that
> +	 * if prepare_message is using spi_res for callbacks,
> +	 * then no unprepare_message is used
> +	 */
> +	spi_res_release(ctlr, mesg);
> +
>  	spin_lock_irqsave(&ctlr->queue_lock, flags);
>  	ctlr->cur_msg =3D NULL;
>  	ctlr->cur_msg_prepared =3D false;
> --
> 2.11.0

Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>


--=-GTmPYLNCIfZAc6quO6nR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlzUDEEACgkQlfZmHno8
x/7NjQf8C4v4Tdej7CKwHWbmYDwU725t1CmH9VUbAobuclqOC4jQVSdDa6ZbgYYt
iKP4UCTUwxkjJuMDyksBp85eNMMEA9M8myjAxZBa5zazKTTKxZ6YOjNZh0pBEZ1d
jHfyfbTqDFqKUzm4FOW4G7tPGR9Zx39886ViKtqUgm7XCR6Ji6aRBr+pUOOCTGeN
BjqXJxlLOzQ+Z8YlqN1EhlMVULnu3YicmxTqwre4h5E/VXpt9t4dY+iAUIWRtbjH
dfq0Dwa9y1T1zQJYEsZfqy0JNopL1/1pn8tsMo+qPrTMLlUgKmHDII8FTnNuVovx
9zJ9wz8AwYy2cL3ZUuqu3aWVc62TDg==
=0zwW
-----END PGP SIGNATURE-----

--=-GTmPYLNCIfZAc6quO6nR--

