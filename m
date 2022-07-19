Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C20457949D
	for <lists+linux-spi@lfdr.de>; Tue, 19 Jul 2022 09:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbiGSHzV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 Jul 2022 03:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiGSHzU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 19 Jul 2022 03:55:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFB76472
        for <linux-spi@vger.kernel.org>; Tue, 19 Jul 2022 00:55:19 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oDi4a-0002QG-VK; Tue, 19 Jul 2022 09:55:17 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id AEB7DB3D14;
        Tue, 19 Jul 2022 07:55:15 +0000 (UTC)
Date:   Tue, 19 Jul 2022 09:55:15 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        kernel@pengutronix.de, Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jens Lindahl <jensctl@gmail.com>
Subject: Re: [PATCH] spi: bcm2835: bcm2835_spi_handle_err(): fix NULL pointer
 deref for non DMA transfers
Message-ID: <20220719075515.x2usfgiolzx4xkt5@pengutronix.de>
References: <20220719072234.2782764-1-mkl@pengutronix.de>
 <20220719074701.GA26268@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="th2oj34vrwbrgymm"
Content-Disposition: inline
In-Reply-To: <20220719074701.GA26268@wunner.de>
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


--th2oj34vrwbrgymm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 19.07.2022 09:47:01, Lukas Wunner wrote:
> [+cc Jens, Florian, Stefan, Mark]
>=20
> On Tue, Jul 19, 2022 at 09:22:35AM +0200, Marc Kleine-Budde wrote:
> > In case a IRQ based transfer times out the bcm2835_spi_handle_err()
> > function is called. Since commit 1513ceee70f2 ("spi: bcm2835: Drop
> > dma_pending flag") the TX and RX DMA transfers are unconditionally
> > canceled, leading to NULL pointer derefs if ctlr->dma_tx or
> > ctlr->dma_rx are not set.
> >=20
> > Fix the NULL pointer deref by checking that ctlr->dma_tx and
> > ctlr->dma_rx are valid pointers before accessing them.
> >=20
> > Fixes: 1513ceee70f2 ("spi: bcm2835: Drop dma_pending flag")
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>=20
> Link: https://lore.kernel.org/linux-spi/20220603142340.42271-1-jensctl@gm=
ail.com/

Thanks.

The difference is (Jens Lindahl):

+	if (bs->tx_dma_active) {
+		dmaengine_terminate_sync(ctlr->dma_tx);
+		bs->tx_dma_active =3D false;
+	}

vs. (me):

+	if (ctlr->dma_tx) {
+		dmaengine_terminate_sync(ctlr->dma_tx);
+		bs->tx_dma_active =3D false;
+	}

Which one is preferred?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--th2oj34vrwbrgymm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLWY2AACgkQrX5LkNig
013YNwf/WhMn4ClC45SI2qwXnPblnvw8f9OSSQGGqhBjnBi1SvKLkLr+eW8gjirA
gf6ED9R4c126FD5Te6KrrCOTXZzORoa35Ebl4vVX4okjCFJr5jAvHxJD7Mf1ta0h
W5J9UBPowEKln/ALwuZhA+K1+C0Ob2AWcchkOjcnEqahilD57isyMEw1Tzp9I8ab
dffpqz5mKlu7g6pTHrsRQyN3UbXqOh7I9M500jZ/28t7AM9NYQyBw5szGJlbqGqr
fKO+iHu/ew8yckECLm64d793d5nMaIgru1osHGeEBH3GIuUbAiX6a+txXUKxgWgD
Vlx6P7rXxrerSGimAXU3gTuf9TzeZw==
=MPA1
-----END PGP SIGNATURE-----

--th2oj34vrwbrgymm--
