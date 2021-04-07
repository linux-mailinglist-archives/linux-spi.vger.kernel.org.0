Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1756535652C
	for <lists+linux-spi@lfdr.de>; Wed,  7 Apr 2021 09:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349427AbhDGHYz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 7 Apr 2021 03:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238957AbhDGHYz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 7 Apr 2021 03:24:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D667C061756
        for <linux-spi@vger.kernel.org>; Wed,  7 Apr 2021 00:24:46 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lU2YK-00056i-DB; Wed, 07 Apr 2021 09:24:40 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lU2YJ-0008B6-QN; Wed, 07 Apr 2021 09:24:39 +0200
Date:   Wed, 7 Apr 2021 09:24:39 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        linux-clk <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v4 6/6] spi: davinci: Simplify using
 devm_clk_get_enabled()
Message-ID: <20210407072439.niicbbvdzuegkagf@pengutronix.de>
References: <20210330181755.204339-1-u.kleine-koenig@pengutronix.de>
 <20210330181755.204339-7-u.kleine-koenig@pengutronix.de>
 <20210331120212.GB4758@sirena.org.uk>
 <20210406065727.i7wbve2ihdblq24p@pengutronix.de>
 <CAMuHMdXD3UgbLWD2pEc-Y=OstdYn0riuBaXFZvwZMQ0Xem6soA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="po3m4xovm6fxqdn6"
Content-Disposition: inline
In-Reply-To: <CAMuHMdXD3UgbLWD2pEc-Y=OstdYn0riuBaXFZvwZMQ0Xem6soA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--po3m4xovm6fxqdn6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 07, 2021 at 09:00:33AM +0200, Geert Uytterhoeven wrote:
> Hi Uwe,
>=20
> I'm not Mark, but I'd like to share my 2=E2=82=ACc.
>=20
> On Tue, Apr 6, 2021 at 3:43 PM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Wed, Mar 31, 2021 at 01:02:12PM +0100, Mark Brown wrote:
> > > On Tue, Mar 30, 2021 at 08:17:55PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > > devm_clk_get_enabled() returns the clk already (prepared and) enabl=
ed
> > > > and the automatically called cleanup cares for disabling (and
> > > > unpreparing). So simplify .probe() and .remove() accordingly.
> > >
> > > Acked-by: Mark Brown <broonie@kernel.org>
> >
> > Thanks. I wonder what you think about this series. Is it more "Well, ok,
> > if you must, the change you did to this spi driver looks correct." or
> > "This is a good simplification and a similar change for nearly all other
> > spi drivers that make use of a clk is possible, too. Dear clk
> > maintainers, please go forward and apply this useful series."?
>=20
> While this simplifies drivers, this makes it harder to add power
> management by controlling the clocks through Runtime PM later, as that
> will require reverting the s/devm_clk_get/devm_clk_get_enabled/ again.

Hmm, if you start with a driver that uses devm_clk_get_enabled() you
have to do:

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 63ee918ecdb0..07855f89290e 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -936,7 +936,7 @@ static int davinci_spi_probe(struct platform_device *pd=
ev)
=20
 	dspi->bitbang.master =3D master;
=20
-	dspi->clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
+	dspi->clk =3D devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(dspi->clk)) {
 		ret =3D -ENODEV;
 		goto free_master;

(+ adding runtime PM of course). When you start with the previous state
of the driver you have to do:

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 7453a1dbbc06..07855f89290e 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -941,9 +941,6 @@ static int davinci_spi_probe(struct platform_device *pd=
ev)
 		ret =3D -ENODEV;
 		goto free_master;
 	}
-	ret =3D clk_prepare_enable(dspi->clk);
-	if (ret)
-		goto free_master;
=20
 	master->use_gpio_descriptors =3D true;
 	master->dev.of_node =3D pdev->dev.of_node;
@@ -968,7 +965,7 @@ static int davinci_spi_probe(struct platform_device *pd=
ev)
=20
 	ret =3D davinci_spi_request_dma(dspi);
 	if (ret =3D=3D -EPROBE_DEFER) {
-		goto free_clk;
+		goto free_master;
 	} else if (ret) {
 		dev_info(&pdev->dev, "DMA is not supported (%d)\n", ret);
 		dspi->dma_rx =3D NULL;
@@ -1012,8 +1009,6 @@ static int davinci_spi_probe(struct platform_device *=
pdev)
 		dma_release_channel(dspi->dma_rx);
 		dma_release_channel(dspi->dma_tx);
 	}
-free_clk:
-	clk_disable_unprepare(dspi->clk);
 free_master:
 	spi_master_put(master);
 err:
@@ -1039,8 +1034,6 @@ static int davinci_spi_remove(struct platform_device =
*pdev)
=20
 	spi_bitbang_stop(&dspi->bitbang);
=20
-	clk_disable_unprepare(dspi->clk);
-
 	if (dspi->dma_rx) {
 		dma_release_channel(dspi->dma_rx);
 		dma_release_channel(dspi->dma_tx);

(+ again adding runtime PM of course). Do you really think the latter is
the easier approach? Or what am I missing?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--po3m4xovm6fxqdn6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBtXjQACgkQwfwUeK3K
7AkD8wf9Fi9020AeaOFzrLUuf+rXxbiQk3LyA26ozpXIKcW34B2wswDxLu/NWz+l
NdU5rOm0oW40wAU5V2yfVg6w34N0Wt2PzWlKdWpUR3/reOxbmrxqD5baE7LyJUYN
Z4H8pXPSl1TtqflKOC+MKF643mHLk7VyO+5QUFo7w9qfuKXV/3OWmJfTMVMeziSQ
PHy10q1vup2gFe1w+TPmHuoj1/jPqtW7ziaNKrvKcIOPfDkYcPWP8frLorhx5/FP
18X5bKpxDYnxaXZn5+/zXVJZdTV1lco1mMQaR2pGBl0wBPTcSGn886+KrjuLM3uv
3Qy3jfrxldrf7skMOFiYMb1dQS6C5w==
=DHcI
-----END PGP SIGNATURE-----

--po3m4xovm6fxqdn6--
