Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9C0629E01
	for <lists+linux-spi@lfdr.de>; Tue, 15 Nov 2022 16:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiKOPrs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 15 Nov 2022 10:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238390AbiKOPr2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 15 Nov 2022 10:47:28 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDB12ED53
        for <linux-spi@vger.kernel.org>; Tue, 15 Nov 2022 07:47:14 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ouy9Q-0007BD-UO; Tue, 15 Nov 2022 16:47:04 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:6ac2:39cd:4970:9b29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id D220E11F5E0;
        Tue, 15 Nov 2022 15:47:03 +0000 (UTC)
Date:   Tue, 15 Nov 2022 16:46:55 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Frieder Schrempf <frieder.schrempf@kontron.de>
Cc:     Mark Brown <broonie@kernel.org>, David Jander <david@protonic.nl>,
        Fabio Estevam <festevam@gmail.com>, linux-spi@vger.kernel.org,
        stable@kernel.org
Subject: Re: [PATCH] spi: spi-imx: Revert "spi: spi-imx: add PIO polling
 support"
Message-ID: <20221115154655.sdvjczlivt33kezp@pengutronix.de>
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
        protocol="application/pgp-signature"; boundary="mgp2grebx7g7bc4d"
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


--mgp2grebx7g7bc4d
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 15.11.2022 15:46:28, Frieder Schrempf wrote:
> Hi Marc,
>=20
> On 15.11.22 13:55, Marc Kleine-Budde wrote:
> > On 15.11.2022 11:51:53, Frieder Schrempf wrote:
> >> On 14.11.22 12:29, Mark Brown wrote:
> >>> On Mon, Nov 14, 2022 at 09:30:26AM +0100, Frieder Schrempf wrote:
> >>>
> >>>> As far as I know Fabio also discovered that disabling SDMA also fixes
> >>>> the problem.
> >>>
> >>>> I guess I will try to repeat some tests on latest master and see if
> >>>> there is anything that makes things work again without reducing the
> >>>> clock. If anyone has some more ideas of how to fix this properly, pl=
ease
> >>>> let me know. If nothing else helps we could also reduce the SPI cloc=
k.
> >>>
> >>> It sounds like the commit can stay and that everyone is happy
> >>> that the issue is that the the commit made things run faster and
> >>> exposed some other misconfiguration for these systems?
> >>
> >> Honestly I'm not really sure how to proceed.
> >>
> >> My first impression was to keep the PIO polling support with its
> >> benefits if there's just this single issue with the SPI NOR on our boa=
rd
> >> and assuming that the performance improvements uncovered a bug somewhe=
re
> >> else. But at the moment I'm not quite sure this is really the case.
> >>
> >> I did another test on v6.1-rc5 and disabling either PIO polling
> >> (spi-imx.polling_limit_us=3D0) or DMA (spi-imx.use_dma=3D0), or both o=
f them
> >> makes reading the SPI NOR work again.
> >=20
> > That was a good hint, I think I've found something.
> >=20
> > Can you check if this fixes your problem? Just a quick hack to, a proper
> > solution needs some more love.
> >=20
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
>=20
> In my case on i.MX8MM the SPI is fed by a 50 MHz peripheral clock.
> Requesting 80 MHz for the SPI NOR triggers the fspi > fin condition in
> mx51_ecspi_clkdiv() [1] which in turn leaves *fres uninitialized causing
> spi_imx->spi_bus_clk to be set to an arbitrary/random value in
> mx51_ecspi_prepare_transfer() [2].
>=20
> This in turn messes up the calculation for the PIO polling byte limit.
> In my case the limit was usually somewhere around 8000 bytes, so the
> 4096 byte SPI NOR messages get transferred via PIO polling.
>=20
> Having large and inefficient polling transfers shouldn't be a problem
> and lead to corrupted data, but I suspect that it doesn't work because
> the transfer size exceeds the FIFO size in this case.

no - exceeding the FIFO size it not a problem. If you limit polling to
FIFO size you effectively disable it for your use case.

> If my conclusions are correct there are two fixes required (though for
> my use case each one of the alone is enough to make things work):
>=20
> 1. Make sure spi_bus_clk is correct even if the requested bus clock
> exceeds the input clock.

With a proper clock rate, and the default 30=C2=B5s limit results in no
polling for you.

> 2. Limit byte_limit for PIO polling calculation to a maximum of
> fifo_size, so we don't try to poll for transfers that don't fit into the
> FIFO.

One of the performance benefits of polling is that you don't get all the
IRQs needed for refilling the FIFO, please keep this as is.

> Both fixes are quite simple (see diff below) and if you agree I will
> send them as formal patches.

Please just the first one. But let's fix polling support, too. I'll send
a patch.

>=20
> Thanks
> Frieder
>=20
> [1]
> https://elixir.bootlin.com/linux/latest/source/drivers/spi/spi-imx.c#L447
> [2]
> https://elixir.bootlin.com/linux/latest/source/drivers/spi/spi-imx.c#L650
>=20
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -445,7 +445,7 @@ static unsigned int mx51_ecspi_clkdiv(struct
> spi_imx_data *spi_imx,
>         unsigned int fin =3D spi_imx->spi_clk;
>=20
>         if (unlikely(fspi > fin))
> -               return 0;
> +               fspi =3D fin;

This should equal:
fspi =3D min(fspi, fin);

Good catch! Please make this a separate patch and send it upstream!

Can you enable debugging and post the output of the dev_dbg() in that
function.

>=20
>         post =3D fls(fin) - fls(fspi);
>         if (fin > fspi << post)
> @@ -1613,6 +1613,7 @@ static int spi_imx_transfer_one(struct
> spi_controller *controller,
>          */
>         hz_per_byte =3D polling_limit_us ? ((8 + 4) * USEC_PER_SEC) /
> polling_limit_us : 0;
>         byte_limit =3D hz_per_byte ? transfer->effective_speed_hz /
> hz_per_byte : 1;
> +       byte_limit =3D min(byte_limit, spi_imx->devtype_data->fifo_size);
>=20
>         /* run in polling mode for short transfers */
>         if (transfer->len < byte_limit)
>=20

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--mgp2grebx7g7bc4d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmNztGwACgkQrX5LkNig
011SVgf+MS5n7ttOhHUlOp+aEbBeWOZdY7OVF3ItZJaDkJM25Oe8l+h3KaMtya5d
dj0wPOVunPd5g09bWhM8VIT+BEF9xgfAuQWfD8BjnSwYfUesXFlCwJYUlDAuKrm/
myCOeRD7JhIrOy5xbXkbNuXMGQx55l8Hk9fDo8h1/n0muAr12AZAEaV0Tqeql3xc
y8zMc4k+vAK7JxlVAp9tMAmStIAsRqKJBkI0u13jBr5pahY2pP1arF1q+cKGLkJw
uxVx2U6/oiSMtg1LTSztLbVkDjiar/FfgWTMlLg2xTa4GY/LlDedTg3rI06Kc9V5
p5bGFgT1eckIk56c+NLE2K0Kmu5JWA==
=ZgfL
-----END PGP SIGNATURE-----

--mgp2grebx7g7bc4d--
