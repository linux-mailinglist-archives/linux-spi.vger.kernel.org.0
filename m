Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1973242C0D9
	for <lists+linux-spi@lfdr.de>; Wed, 13 Oct 2021 15:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbhJMNCL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Oct 2021 09:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbhJMNCK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 Oct 2021 09:02:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CACC061570
        for <linux-spi@vger.kernel.org>; Wed, 13 Oct 2021 06:00:07 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1madra-0004lV-7R; Wed, 13 Oct 2021 15:00:06 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1madrZ-0005bR-MH; Wed, 13 Oct 2021 15:00:05 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1madrZ-0007Yh-Lb; Wed, 13 Oct 2021 15:00:05 +0200
Date:   Wed, 13 Oct 2021 15:00:05 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: Fix deadlock when adding SPI controllers on SPI
 buses
Message-ID: <20211013130005.shbj4cupoumse2vc@pengutronix.de>
References: <20211013122628.1369702-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jm2w7mdf3xllugfr"
Content-Disposition: inline
In-Reply-To: <20211013122628.1369702-1-broonie@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--jm2w7mdf3xllugfr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 13, 2021 at 01:26:28PM +0100, Mark Brown wrote:
> Currently we have a global spi_add_lock which we take when adding new
> devices so that we can check that we're not trying to reuse a chip
> select that's already controlled.  This means that if the SPI device is
> itself a SPI controller and triggers the instantiation of further SPI
> devices we trigger a deadlock as we try to register and instantiate
> those devices while in the process of doing so for the parent controller
> and hence already holding the global spi_add_lock.  Since we only care
> about concurrency within a single SPI bus move the lock to be per
> controller, avoiding the deadlock.
>=20
> This can be easily triggered in the case of spi-mux.
>=20
> Reported-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/spi/spi.c       | 21 ++++++++++-----------
>  include/linux/spi/spi.h |  3 +++
>  2 files changed, 13 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 401f62f6f5b5..71d061132ada 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -518,12 +518,6 @@ static LIST_HEAD(spi_controller_list);
>   */
>  static DEFINE_MUTEX(board_lock);
> =20
> -/*
> - * Prevents addition of devices with same chip select and
> - * addition of devices below an unregistering controller.
> - */
> -static DEFINE_MUTEX(spi_add_lock);
> -
>  /**
>   * spi_alloc_device - Allocate a new SPI device
>   * @ctlr: Controller to which device is connected
> @@ -676,9 +670,13 @@ static int spi_add_device(struct spi_device *spi)
>  	/* Set the bus ID string */
>  	spi_dev_set_name(spi);
> =20
> -	mutex_lock(&spi_add_lock);
> +	/* We need to make sure there's no other device with this
> +	 * chipselect **BEFORE** we call setup(), else we'll trash
> +	 * its configuration.  Lock against concurrent add() calls.
> +	 */

This comment is already there, it seems you duplicated it with your
patch? Maybe a merge issue with
6bfb15f34dd8c8a073e03a31c485ef5774b127df?

> +	mutex_lock(&ctlr->add_lock);
>  	status =3D __spi_add_device(spi);
> -	mutex_unlock(&spi_add_lock);
> +	mutex_unlock(&ctlr->add_lock);
>  	return status;
>  }
> =20
> @@ -697,7 +695,7 @@ static int spi_add_device_locked(struct spi_device *s=
pi)
>  	/* Set the bus ID string */
>  	spi_dev_set_name(spi);
> =20
> -	WARN_ON(!mutex_is_locked(&spi_add_lock));
> +	WARN_ON(!mutex_is_locked(&ctlr->add_lock));
>  	return __spi_add_device(spi);
>  }
> =20
> @@ -2950,6 +2948,7 @@ int spi_register_controller(struct spi_controller *=
ctlr)
>  	spin_lock_init(&ctlr->bus_lock_spinlock);
>  	mutex_init(&ctlr->bus_lock_mutex);
>  	mutex_init(&ctlr->io_mutex);
> +	mutex_init(&ctlr->add_lock);
>  	ctlr->bus_lock_flag =3D 0;
>  	init_completion(&ctlr->xfer_completion);
>  	if (!ctlr->max_dma_len)
> @@ -3086,7 +3085,7 @@ void spi_unregister_controller(struct spi_controlle=
r *ctlr)
> =20
>  	/* Prevent addition of new devices, unregister existing ones */
>  	if (IS_ENABLED(CONFIG_SPI_DYNAMIC))
> -		mutex_lock(&spi_add_lock);
> +		mutex_lock(&ctlr->add_lock);
> =20
>  	device_for_each_child(&ctlr->dev, NULL, __unregister);
> =20
> @@ -3117,7 +3116,7 @@ void spi_unregister_controller(struct spi_controlle=
r *ctlr)
>  	mutex_unlock(&board_lock);
> =20
>  	if (IS_ENABLED(CONFIG_SPI_DYNAMIC))
> -		mutex_unlock(&spi_add_lock);
> +		mutex_unlock(&ctlr->add_lock);
>  }
>  EXPORT_SYMBOL_GPL(spi_unregister_controller);
> =20
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 29e21d49aafc..eb7ac8a1e03c 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -527,6 +527,9 @@ struct spi_controller {
>  	/* I/O mutex */
>  	struct mutex		io_mutex;
> =20
> +	/* Used to avoid adding the same CS twice */
> +	struct mutex		add_lock;
> +

Kernel-doc is missing for that one.

(In the local patch I have for testing here, I wrote:

	* @add_lock: mutex to avoid adding two devices on the same CS

=2E)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jm2w7mdf3xllugfr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFm2FIACgkQwfwUeK3K
7Aktrgf9Eia44haJLYxBdIUQHBgaZEUuv1eMN79qjtG7gpTi62hPO/QuMtybcR45
bvF/cL5hAOhQSLIiaaKgQZ0fEV9wTDtyZTLdRyJG0YjxU1VM6gq/4q77p2Pxe+Nw
NDQ87irZncfyZIahk7yaVMS+aDiAEcJOPdAbHBa6o5qZMsH96/lO1+GGSw5O9rKQ
S9pUF6wzdfKCJgvQm4kj7mjIXSJkqIRUb+NeGBOkLHBQgS7Y28uNsCsRGzb7kRCH
TvkJhSVBGUNzOVTc/8uBRf00eU0V+8wQi7HECJ5NBXzZD4oqNllyDa9PgovJ1PKo
mifrbwsITFJo3lpCwXm9eWyHC4TuPQ==
=FgvX
-----END PGP SIGNATURE-----

--jm2w7mdf3xllugfr--
