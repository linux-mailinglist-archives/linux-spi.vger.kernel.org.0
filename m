Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912B062A0FC
	for <lists+linux-spi@lfdr.de>; Tue, 15 Nov 2022 19:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiKOSBx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 15 Nov 2022 13:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiKOSB2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 15 Nov 2022 13:01:28 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EBA25F
        for <linux-spi@vger.kernel.org>; Tue, 15 Nov 2022 10:01:27 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ov0FM-0007mz-OY; Tue, 15 Nov 2022 19:01:20 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:6ac2:39cd:4970:9b29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 19BA511F787;
        Tue, 15 Nov 2022 18:01:20 +0000 (UTC)
Date:   Tue, 15 Nov 2022 19:01:11 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Frieder Schrempf <frieder.schrempf@kontron.de>
Cc:     Mark Brown <broonie@kernel.org>, David Jander <david@protonic.nl>,
        Fabio Estevam <festevam@gmail.com>, linux-spi@vger.kernel.org,
        stable@kernel.org
Subject: Re: [PATCH] spi: spi-imx: Revert "spi: spi-imx: add PIO polling
 support"
Message-ID: <20221115180111.qlhbfbmt5zy5ex2e@pengutronix.de>
References: <20221111105028.7d605632@erd992>
 <CAOMZO5CH9S_RYpLNZbRxChzSVkkZTAd+qpxz1Ycj2UUPROTXpw@mail.gmail.com>
 <20221111135919.63daed2d@erd992>
 <1c70bfd1-38f6-3a30-9e36-a0f780f82571@kontron.de>
 <Y3ImhoSzY1PYMp+9@sirena.org.uk>
 <46dc7280-545d-6b8c-ff7f-4bad13486292@kontron.de>
 <20221115125549.iih75abpy7cppiss@pengutronix.de>
 <ff8c3ba5-fef6-cb9f-cccb-95e300892eba@kontron.de>
 <20221115165214.p35rfdczz7pmjepe@pengutronix.de>
 <9d21f364-9e6b-1502-f34a-ef486da91af6@kontron.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ksfs7ytdhmzpsf7g"
Content-Disposition: inline
In-Reply-To: <9d21f364-9e6b-1502-f34a-ef486da91af6@kontron.de>
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


--ksfs7ytdhmzpsf7g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 15.11.2022 18:11:07, Frieder Schrempf wrote:
> On 15.11.22 17:52, Marc Kleine-Budde wrote:
> > On 15.11.2022 15:46:28, Frieder Schrempf wrote:
> >>> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> >>> index 30d82cc7300b..76021b9bb445 100644
> >>> --- a/drivers/spi/spi-imx.c
> >>> +++ b/drivers/spi/spi-imx.c
> >>> @@ -1270,9 +1270,22 @@ static int spi_imx_setupxfer(struct spi_device=
 *spi,
> >>>                 spi_imx->dynamic_burst =3D 0;
> >>>         }
> >>> =20
> >>> -       if (spi_imx_can_dma(spi_imx->controller, spi, t))
> >>> -               spi_imx->usedma =3D true;
> >>> -       else
> >>> +       if (spi_imx_can_dma(spi_imx->controller, spi, t)) {
> >>> +               unsigned long hz_per_byte, byte_limit;
> >>> +
> >>> +               /*
> >>> +                * Calculate the estimated time in us the transfer ru=
ns. Find
> >>> +                * the number of Hz per byte per polling limit.
> >>> +                */
> >>> +               hz_per_byte =3D polling_limit_us ? ((8 + 4) * USEC_PE=
R_SEC) / polling_limit_us : 0;
> >>> +               byte_limit =3D hz_per_byte ? t->effective_speed_hz / =
hz_per_byte : 1;
> >>> +
> >>> +               /* run in polling mode for short transfers */
> >>> +               if (t->len < byte_limit)
> >>> +                       spi_imx->usedma =3D false;
> >>> +               else
> >>> +                       spi_imx->usedma =3D true;
> >>> +       } else
> >>>                 spi_imx->usedma =3D false;
> >>> =20
> >>>         spi_imx->rx_only =3D ((t->tx_buf =3D=3D NULL)
> >>> @@ -1597,8 +1610,8 @@ static int spi_imx_transfer_one(struct spi_cont=
roller *controller,
> >>>         struct spi_imx_data *spi_imx =3D spi_controller_get_devdata(s=
pi->controller);
> >>>         unsigned long hz_per_byte, byte_limit;
> >>> =20
> >>> -       spi_imx_setupxfer(spi, transfer);
> >>>         transfer->effective_speed_hz =3D spi_imx->spi_bus_clk;
> >>> +       spi_imx_setupxfer(spi, transfer);
> >>> =20
> >>>         /* flush rxfifo before transfer */
> >>>         while (spi_imx->devtype_data->rx_available(spi_imx))
> >>>
> >>
> >> Thanks for the patch, but unfortunately this doesn't help. I did some
> >> more debugging and it looks like there are two problems.
> >=20
> > Can you try this one?
> >=20
> > diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> > index 30d82cc7300b..d45da1d0ac1d 100644
> > --- a/drivers/spi/spi-imx.c
> > +++ b/drivers/spi/spi-imx.c
> > @@ -1607,6 +1607,13 @@ static int spi_imx_transfer_one(struct spi_contr=
oller *controller,
> >         if (spi_imx->slave_mode)
> >                 return spi_imx_pio_transfer_slave(spi, transfer);
> > =20
> > +       /*
> > +        * If we decided in spi_imx_can_dma() that we want to do a DMA
> > +        * transfer, the message has already been mapped, so we have
> > +        * to do the DMA transfer now.
> > +        */
> > +       if (spi_imx->usedma)
> > +               return spi_imx_dma_transfer(spi_imx, transfer);
> >         /*
> >          * Calculate the estimated time in us the transfer runs. Find
> >          * the number of Hz per byte per polling limit.
> > @@ -1618,9 +1625,6 @@ static int spi_imx_transfer_one(struct spi_contro=
ller *controller,
> >         if (transfer->len < byte_limit)
> >                 return spi_imx_poll_transfer(spi, transfer);
> > =20
> > -       if (spi_imx->usedma)
> > -               return spi_imx_dma_transfer(spi_imx, transfer);
> > -
> >         return spi_imx_pio_transfer(spi, transfer);
> >  }
> >=20
> > The problem is: we decide on DMA in spi_imx_can_dma() the SPI frameworks
> > maps the message, and then calls spi_imx_transfer_one(). We cannot
> > operate with the CPU in the memory mapped to the DMA engine.
> >=20
> > This should fix the problem without any additional patches.
>=20
> This does fix the issue.

\o/

> My previous patch had the same result, as
> spi_imx_can_dma() returns false if transfer size is below fifo_size. But
> of course this is the correct fix with the correct explanation.

Ok, but I don't want to limit polling on <=3D FIFO sized transfers :)

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ksfs7ytdhmzpsf7g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmNz0+QACgkQrX5LkNig
0136/wf+NZMRfkhjnE/rQomSNjARJjztLGtBF3eGfkQL2QimCtM+Wk0gIwfCTzHo
c/uZ/TafDj2Grlh3DqJ4cOJv/LkDk1opCLnOreMi+oQKMA/4KEN35bHTmgbiy8UX
Z2OapHnLt/pxW39JuKCR7KVwl3UkITCh1nJOKuHMY8vcJF2gCn93qnbnBlvYKQ5y
9CjxaWwE99uFtmEeFtk82gsrhCkzxzMMNJO/KW0O/pWCn8ts233igQ54DgeTD62H
UtU+gR5+uu5kOjyVHItBrRPfjZyeG4z2Du2onxaVItz7QhcyPPt+4Q0b6HBitUWn
n59iy3k36/v0OgyXiNswTRzeGk+FHA==
=oUX4
-----END PGP SIGNATURE-----

--ksfs7ytdhmzpsf7g--
