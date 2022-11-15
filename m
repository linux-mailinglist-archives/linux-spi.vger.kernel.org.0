Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC2C629F9C
	for <lists+linux-spi@lfdr.de>; Tue, 15 Nov 2022 17:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbiKOQwf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 15 Nov 2022 11:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiKOQwe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 15 Nov 2022 11:52:34 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5537360C1
        for <linux-spi@vger.kernel.org>; Tue, 15 Nov 2022 08:52:33 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ouzAe-0007fe-7S; Tue, 15 Nov 2022 17:52:24 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:6ac2:39cd:4970:9b29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 5A64811F6D1;
        Tue, 15 Nov 2022 16:52:23 +0000 (UTC)
Date:   Tue, 15 Nov 2022 17:52:14 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Frieder Schrempf <frieder.schrempf@kontron.de>
Cc:     Mark Brown <broonie@kernel.org>, David Jander <david@protonic.nl>,
        Fabio Estevam <festevam@gmail.com>, linux-spi@vger.kernel.org,
        stable@kernel.org
Subject: Re: [PATCH] spi: spi-imx: Revert "spi: spi-imx: add PIO polling
 support"
Message-ID: <20221115165214.p35rfdczz7pmjepe@pengutronix.de>
References: <20221111003032.82371-1-festevam@gmail.com>
 <20221111105028.7d605632@erd992>
 <CAOMZO5CH9S_RYpLNZbRxChzSVkkZTAd+qpxz1Ycj2UUPROTXpw@mail.gmail.com>
 <20221111135919.63daed2d@erd992>
 <1c70bfd1-38f6-3a30-9e36-a0f780f82571@kontron.de>
 <Y3ImhoSzY1PYMp+9@sirena.org.uk>
 <46dc7280-545d-6b8c-ff7f-4bad13486292@kontron.de>
 <20221115125549.iih75abpy7cppiss@pengutronix.de>
 <ff8c3ba5-fef6-cb9f-cccb-95e300892eba@kontron.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tsdcbadvdwhtg7vl"
Content-Disposition: inline
In-Reply-To: <ff8c3ba5-fef6-cb9f-cccb-95e300892eba@kontron.de>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--tsdcbadvdwhtg7vl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 15.11.2022 15:46:28, Frieder Schrempf wrote:
> > diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> > index 30d82cc7300b..76021b9bb445 100644
> > --- a/drivers/spi/spi-imx.c
> > +++ b/drivers/spi/spi-imx.c
> > @@ -1270,9 +1270,22 @@ static int spi_imx_setupxfer(struct spi_device *=
spi,
> >                 spi_imx->dynamic_burst =3D 0;
> >         }
> > =20
> > -       if (spi_imx_can_dma(spi_imx->controller, spi, t))
> > -               spi_imx->usedma =3D true;
> > -       else
> > +       if (spi_imx_can_dma(spi_imx->controller, spi, t)) {
> > +               unsigned long hz_per_byte, byte_limit;
> > +
> > +               /*
> > +                * Calculate the estimated time in us the transfer runs=
=2E Find
> > +                * the number of Hz per byte per polling limit.
> > +                */
> > +               hz_per_byte =3D polling_limit_us ? ((8 + 4) * USEC_PER_=
SEC) / polling_limit_us : 0;
> > +               byte_limit =3D hz_per_byte ? t->effective_speed_hz / hz=
_per_byte : 1;
> > +
> > +               /* run in polling mode for short transfers */
> > +               if (t->len < byte_limit)
> > +                       spi_imx->usedma =3D false;
> > +               else
> > +                       spi_imx->usedma =3D true;
> > +       } else
> >                 spi_imx->usedma =3D false;
> > =20
> >         spi_imx->rx_only =3D ((t->tx_buf =3D=3D NULL)
> > @@ -1597,8 +1610,8 @@ static int spi_imx_transfer_one(struct spi_contro=
ller *controller,
> >         struct spi_imx_data *spi_imx =3D spi_controller_get_devdata(spi=
->controller);
> >         unsigned long hz_per_byte, byte_limit;
> > =20
> > -       spi_imx_setupxfer(spi, transfer);
> >         transfer->effective_speed_hz =3D spi_imx->spi_bus_clk;
> > +       spi_imx_setupxfer(spi, transfer);
> > =20
> >         /* flush rxfifo before transfer */
> >         while (spi_imx->devtype_data->rx_available(spi_imx))
> >=20
>=20
> Thanks for the patch, but unfortunately this doesn't help. I did some
> more debugging and it looks like there are two problems.

Can you try this one?

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 30d82cc7300b..d45da1d0ac1d 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1607,6 +1607,13 @@ static int spi_imx_transfer_one(struct spi_controlle=
r *controller,
        if (spi_imx->slave_mode)
                return spi_imx_pio_transfer_slave(spi, transfer);
=20
+       /*
+        * If we decided in spi_imx_can_dma() that we want to do a DMA
+        * transfer, the message has already been mapped, so we have
+        * to do the DMA transfer now.
+        */
+       if (spi_imx->usedma)
+               return spi_imx_dma_transfer(spi_imx, transfer);
        /*
         * Calculate the estimated time in us the transfer runs. Find
         * the number of Hz per byte per polling limit.
@@ -1618,9 +1625,6 @@ static int spi_imx_transfer_one(struct spi_controller=
 *controller,
        if (transfer->len < byte_limit)
                return spi_imx_poll_transfer(spi, transfer);
=20
-       if (spi_imx->usedma)
-               return spi_imx_dma_transfer(spi_imx, transfer);
-
        return spi_imx_pio_transfer(spi, transfer);
 }

The problem is: we decide on DMA in spi_imx_can_dma() the SPI frameworks
maps the message, and then calls spi_imx_transfer_one(). We cannot
operate with the CPU in the memory mapped to the DMA engine.

This should fix the problem without any additional patches.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--tsdcbadvdwhtg7vl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmNzw7sACgkQrX5LkNig
0137SQgAnlQ4dKceeD4SFI2qbZ9nMY8VP6RTdhm9vd/KmIwf1NSOs6zu0Erg6PFA
0xqDwylPBA8ZDvHvW/RVDcm/R4kR4u5M+ioVRvh8uaAju27M0yycfo9eqD5NZIwD
11P1SoOKtWGUjjtlSAP7Yasoz2h0B55EPiQDJkQQKFjQvYQMQieULUeABs2u4s6y
+u9unOLEq7pIgsfp8ffTaJVh9skmxuIbV1HTNkklBDWXBo3Tp3cNlQmenzUi8/Jn
QZkoJKzBEWtyT+SNrJt8SEOXhC3ReaIzo22KDKvVoxkfTdDR24XJKUIpyv+RpnZX
EyRLt1gQdUtVBMh47fvKSJgpYjYrHQ==
=nQBj
-----END PGP SIGNATURE-----

--tsdcbadvdwhtg7vl--
