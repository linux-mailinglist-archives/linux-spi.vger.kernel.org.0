Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C70150068A
	for <lists+linux-spi@lfdr.de>; Thu, 14 Apr 2022 09:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbiDNHHK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 Apr 2022 03:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbiDNHHJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 14 Apr 2022 03:07:09 -0400
X-Greylist: delayed 153743 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Apr 2022 00:04:43 PDT
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D903120BF6
        for <linux-spi@vger.kernel.org>; Thu, 14 Apr 2022 00:04:43 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5A72140069;
        Thu, 14 Apr 2022 07:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649919882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4osRvhg/Q2Dqthg5btrEhCfXnnegl4yeE7z5l1OlBJ0=;
        b=OyK5DYqvdHMsIjMUoWhj29titvNd/gzexcT1K1BRqs+o6uEeJSX4GH07DyxgKQyvlU1Gsf
        Wd5a40XkeCLWdgVA4s6fgvo7Ghj35ta1eAceDrQZTx11LQhaYG8WulNJO33rlTorIvPKbC
        tITM63lFCfnUZzvGiVrLsCu6OPLSjDJpNb6+eBAXAQhSedXu+gJViRpWXmADATG2zY9HMD
        xswr9n5dQ4NOrVebeD+HBEKv+17M3PVCgLHenm+Au2miJWFYEPnZCbsXTicyYkDDprMqxe
        xGpOlWHS2g5ilnlkKtkGZgAOoB5M1oclWrGESTCfhSakOHZ0aUGqyJWHJbBhCw==
Date:   Thu, 14 Apr 2022 09:04:41 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-spi@vger.kernel.org
Subject: Re: [bug report] spi: core: Only check bits_per_word validity when
 explicitly provided
Message-ID: <YlfHidrhxMvUYHmH@aptenodytes>
References: <20220414064948.GA9873@kili>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IyAhQJWL8hnI/SbR"
Content-Disposition: inline
In-Reply-To: <20220414064948.GA9873@kili>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--IyAhQJWL8hnI/SbR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dan,

On Thu 14 Apr 22, 09:49, Dan Carpenter wrote:
> Hello Paul Kocialkowski,
>=20
> The patch b3fe2e516741: "spi: core: Only check bits_per_word validity
> when explicitly provided" from Apr 12, 2022, leads to the following
> Smatch static checker warning:
>=20
> 	drivers/spi/spi.c:3583 spi_setup()
> 	error: uninitialized symbol 'status'.
>=20
> drivers/spi/spi.c
>   3475        int spi_setup(struct spi_device *spi)
>   3476        {
>   3477                unsigned        bad_bits, ugly_bits;
>   3478                int                status;
>   3479
>   3480                /*
>   3481                 * Check mode to prevent that any two of DUAL, QUAD=
 and NO_MOSI/MISO
>   3482                 * are set at the same time.
>   3483                 */
>   3484                if ((hweight_long(spi->mode &
>   3485                        (SPI_TX_DUAL | SPI_TX_QUAD | SPI_NO_TX)) > =
1) ||
>   3486                    (hweight_long(spi->mode &
>   3487                        (SPI_RX_DUAL | SPI_RX_QUAD | SPI_NO_RX)) > =
1)) {
>   3488                        dev_err(&spi->dev,
>   3489                        "setup: can not select any two of dual, qua=
d and no-rx/tx at the same time\n");
>   3490                        return -EINVAL;
>   3491                }
>   3492                /* If it is SPI_3WIRE mode, DUAL and QUAD should be=
 forbidden */
>   3493                if ((spi->mode & SPI_3WIRE) && (spi->mode &
>   3494                        (SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL |
>   3495                         SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL)))
>   3496                        return -EINVAL;
>   3497                /*
>   3498                 * Help drivers fail *cleanly* when they need optio=
ns
>   3499                 * that aren't supported with their current control=
ler.
>   3500                 * SPI_CS_WORD has a fallback software implementati=
on,
>   3501                 * so it is ignored here.
>   3502                 */
>   3503                bad_bits =3D spi->mode & ~(spi->controller->mode_bi=
ts | SPI_CS_WORD |
>   3504                                         SPI_NO_TX | SPI_NO_RX);
>   3505                ugly_bits =3D bad_bits &
>   3506                            (SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCT=
AL |
>   3507                             SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCT=
AL);
>   3508                if (ugly_bits) {
>   3509                        dev_warn(&spi->dev,
>   3510                                 "setup: ignoring unsupported mode =
bits %x\n",
>   3511                                 ugly_bits);
>   3512                        spi->mode &=3D ~ugly_bits;
>   3513                        bad_bits &=3D ~ugly_bits;
>   3514                }
>   3515                if (bad_bits) {
>   3516                        dev_err(&spi->dev, "setup: unsupported mode=
 bits %x\n",
>   3517                                bad_bits);
>   3518                        return -EINVAL;
>   3519                }
>   3520
>   3521                if (!spi->bits_per_word) {
>   3522                        spi->bits_per_word =3D 8;
>=20
> "status" used to be set here, for sure.  You would have to be pretty
> unlucky to get through this function without setting status at all.

Oh I didn't realize that status was returned at the end. Yeah there are
definitely cases where that will happen.

Sending a fix to initialize status =3D 0 soon.

Thanks for the catch & report!

Paul

>   3523                } else {
>   3524                        /*
>   3525                         * Some controllers may not support the def=
ault 8 bits-per-word
>   3526                         * so only perform the check when this is e=
xplicitly provided.
>   3527                         */
>   3528                        status =3D __spi_validate_bits_per_word(spi=
->controller,
>   3529                                                              spi->=
bits_per_word);
>   3530                        if (status)
>   3531                                return status;
>   3532                }
>   3533
>   3534                if (spi->controller->max_speed_hz &&
>   3535                    (!spi->max_speed_hz ||
>   3536                     spi->max_speed_hz > spi->controller->max_speed=
_hz))
>   3537                        spi->max_speed_hz =3D spi->controller->max_=
speed_hz;
>   3538
>   3539                mutex_lock(&spi->controller->io_mutex);
>   3540
>   3541                if (spi->controller->setup) {
>   3542                        status =3D spi->controller->setup(spi);
>   3543                        if (status) {
>   3544                                mutex_unlock(&spi->controller->io_m=
utex);
>   3545                                dev_err(&spi->controller->dev, "Fai=
led to setup device: %d\n",
>   3546                                        status);
>   3547                                return status;
>   3548                        }
>   3549                }
>   3550
>   3551                if (spi->controller->auto_runtime_pm && spi->contro=
ller->set_cs) {
>   3552                        status =3D pm_runtime_get_sync(spi->control=
ler->dev.parent);
>   3553                        if (status < 0) {
>   3554                                mutex_unlock(&spi->controller->io_m=
utex);
>   3555                                pm_runtime_put_noidle(spi->controll=
er->dev.parent);
>   3556                                dev_err(&spi->controller->dev, "Fai=
led to power device: %d\n",
>   3557                                        status);
>   3558                                return status;
>   3559                        }
>   3560
>   3561                        /*
>   3562                         * We do not want to return positive value =
=66rom pm_runtime_get,
>   3563                         * there are many instances of devices call=
ing spi_setup() and
>   3564                         * checking for a non-zero return value ins=
tead of a negative
>   3565                         * return value.
>   3566                         */
>   3567                        status =3D 0;
>   3568
>   3569                        spi_set_cs(spi, false, true);
>   3570                        pm_runtime_mark_last_busy(spi->controller->=
dev.parent);
>   3571                        pm_runtime_put_autosuspend(spi->controller-=
>dev.parent);
>   3572                } else {
>   3573                        spi_set_cs(spi, false, true);
>   3574                }
>   3575
>   3576                mutex_unlock(&spi->controller->io_mutex);
>   3577
>   3578                if (spi->rt && !spi->controller->rt) {
>   3579                        spi->controller->rt =3D true;
>   3580                        spi_set_thread_rt(spi->controller);
>   3581                }
>   3582
>   3583                trace_spi_setup(spi, status);
>   3584
>   3585                dev_dbg(&spi->dev, "setup mode %lu, %s%s%s%s%u bits=
/w, %u Hz max --> %d\n",
>   3586                                spi->mode & SPI_MODE_X_MASK,
>   3587                                (spi->mode & SPI_CS_HIGH) ? "cs_hig=
h, " : "",
>   3588                                (spi->mode & SPI_LSB_FIRST) ? "lsb,=
 " : "",
>   3589                                (spi->mode & SPI_3WIRE) ? "3wire, "=
 : "",
>   3590                                (spi->mode & SPI_LOOP) ? "loopback,=
 " : "",
>   3591                                spi->bits_per_word, spi->max_speed_=
hz,
>   3592                                status);
>   3593
>   3594                return status;
>   3595        }
>=20
> regards,
> dan carpenter

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--IyAhQJWL8hnI/SbR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmJXx4kACgkQ3cLmz3+f
v9FmHggAoV8UeIN3M6U55ha+KqnvAtFnoH1WBSoKR0j389c+eHd2ysDWf14s+nAX
eUiVrmuXSB896AsASoVBamsMMvizv7EUkDmdpaEVqWBDukgswAOt9u/iMfvNYpKE
EZhPd8+Vnhurlh0LIL4ogtLZXmxwonIWUDS//wNRLO1ZZUH54QgiLzMiBN3ytim3
4sSRfkNmf2yIgMIR9HM5N/az05xUfTiT9o5qrShkN4lU9wqONTd4k98crz955mNj
kROO8mHysKR8rwchsMx0gcqXw/uWopdi6nRaSZGSmQWwztc57jOnoMqRrIFCahNT
F3sez+pE7WMr2/BO+RLvVHB0ytvSvQ==
=P4qy
-----END PGP SIGNATURE-----

--IyAhQJWL8hnI/SbR--
