Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7754629966
	for <lists+linux-spi@lfdr.de>; Tue, 15 Nov 2022 13:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbiKOM4J (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 15 Nov 2022 07:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237917AbiKOM4H (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 15 Nov 2022 07:56:07 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6798B34
        for <linux-spi@vger.kernel.org>; Tue, 15 Nov 2022 04:56:06 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ouvTq-0005hp-LD; Tue, 15 Nov 2022 13:55:58 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:6ac2:39cd:4970:9b29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 9622711F37C;
        Tue, 15 Nov 2022 12:55:57 +0000 (UTC)
Date:   Tue, 15 Nov 2022 13:55:49 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Frieder Schrempf <frieder.schrempf@kontron.de>
Cc:     Mark Brown <broonie@kernel.org>, David Jander <david@protonic.nl>,
        Fabio Estevam <festevam@gmail.com>, linux-spi@vger.kernel.org,
        stable@kernel.org
Subject: Re: [PATCH] spi: spi-imx: Revert "spi: spi-imx: add PIO polling
 support"
Message-ID: <20221115125549.iih75abpy7cppiss@pengutronix.de>
References: <20221111003032.82371-1-festevam@gmail.com>
 <20221111105028.7d605632@erd992>
 <CAOMZO5CH9S_RYpLNZbRxChzSVkkZTAd+qpxz1Ycj2UUPROTXpw@mail.gmail.com>
 <20221111135919.63daed2d@erd992>
 <1c70bfd1-38f6-3a30-9e36-a0f780f82571@kontron.de>
 <Y3ImhoSzY1PYMp+9@sirena.org.uk>
 <46dc7280-545d-6b8c-ff7f-4bad13486292@kontron.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eta6aaptgmkvwvcm"
Content-Disposition: inline
In-Reply-To: <46dc7280-545d-6b8c-ff7f-4bad13486292@kontron.de>
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


--eta6aaptgmkvwvcm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 15.11.2022 11:51:53, Frieder Schrempf wrote:
> On 14.11.22 12:29, Mark Brown wrote:
> > On Mon, Nov 14, 2022 at 09:30:26AM +0100, Frieder Schrempf wrote:
> >=20
> >> As far as I know Fabio also discovered that disabling SDMA also fixes
> >> the problem.
> >=20
> >> I guess I will try to repeat some tests on latest master and see if
> >> there is anything that makes things work again without reducing the
> >> clock. If anyone has some more ideas of how to fix this properly, plea=
se
> >> let me know. If nothing else helps we could also reduce the SPI clock.
> >=20
> > It sounds like the commit can stay and that everyone is happy
> > that the issue is that the the commit made things run faster and
> > exposed some other misconfiguration for these systems?
>=20
> Honestly I'm not really sure how to proceed.
>=20
> My first impression was to keep the PIO polling support with its
> benefits if there's just this single issue with the SPI NOR on our board
> and assuming that the performance improvements uncovered a bug somewhere
> else. But at the moment I'm not quite sure this is really the case.
>=20
> I did another test on v6.1-rc5 and disabling either PIO polling
> (spi-imx.polling_limit_us=3D0) or DMA (spi-imx.use_dma=3D0), or both of t=
hem
> makes reading the SPI NOR work again.

That was a good hint, I think I've found something.

Can you check if this fixes your problem? Just a quick hack to, a proper
solution needs some more love.

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 30d82cc7300b..76021b9bb445 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1270,9 +1270,22 @@ static int spi_imx_setupxfer(struct spi_device *spi,
                spi_imx->dynamic_burst =3D 0;
        }
=20
-       if (spi_imx_can_dma(spi_imx->controller, spi, t))
-               spi_imx->usedma =3D true;
-       else
+       if (spi_imx_can_dma(spi_imx->controller, spi, t)) {
+               unsigned long hz_per_byte, byte_limit;
+
+               /*
+                * Calculate the estimated time in us the transfer runs. Fi=
nd
+                * the number of Hz per byte per polling limit.
+                */
+               hz_per_byte =3D polling_limit_us ? ((8 + 4) * USEC_PER_SEC)=
 / polling_limit_us : 0;
+               byte_limit =3D hz_per_byte ? t->effective_speed_hz / hz_per=
_byte : 1;
+
+               /* run in polling mode for short transfers */
+               if (t->len < byte_limit)
+                       spi_imx->usedma =3D false;
+               else
+                       spi_imx->usedma =3D true;
+       } else
                spi_imx->usedma =3D false;
=20
        spi_imx->rx_only =3D ((t->tx_buf =3D=3D NULL)
@@ -1597,8 +1610,8 @@ static int spi_imx_transfer_one(struct spi_controller=
 *controller,
        struct spi_imx_data *spi_imx =3D spi_controller_get_devdata(spi->co=
ntroller);
        unsigned long hz_per_byte, byte_limit;
=20
-       spi_imx_setupxfer(spi, transfer);
        transfer->effective_speed_hz =3D spi_imx->spi_bus_clk;
+       spi_imx_setupxfer(spi, transfer);
=20
        /* flush rxfifo before transfer */
        while (spi_imx->devtype_data->rx_available(spi_imx))

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--eta6aaptgmkvwvcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmNzjFIACgkQrX5LkNig
0133xgf/YzhLoK1IP2MxbvNSd94OIoFOI9AUWcGSV4ZNEZqgLNWs4SiP1TD30uCV
b6clj3i9Z2MKphxwj+e6GP/ozgiUVjiCGV99bAhY67pUXNy3ccjdOIuNTngy+0Nl
qcBl03eZNrQ/uHoMZvgIiv2N1Q0jpkS+xUhWgro22Z79kZaMbhO2fuJCgwerxdb9
aorRF2ZHTM50FLrN1bmX6G0RfpIO7jck6UbuOEW7nl1hkej2gSoWpEIVNFCysmGt
tpjTYFPgdnvc+OHyvrajH4l9W/AuxM4O0JPL3KAQGU6bvtDQ+k+bBr0EDgPlXBT2
EpK2Pu2LCSw5w6d/Ia0+A8/znKbAOQ==
=nSqw
-----END PGP SIGNATURE-----

--eta6aaptgmkvwvcm--
