Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589AB2B9651
	for <lists+linux-spi@lfdr.de>; Thu, 19 Nov 2020 16:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgKSPfq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Nov 2020 10:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbgKSPfp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 19 Nov 2020 10:35:45 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812E6C0613CF
        for <linux-spi@vger.kernel.org>; Thu, 19 Nov 2020 07:35:45 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kflyI-0006tK-6H; Thu, 19 Nov 2020 16:35:42 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kflyH-0001XM-RO; Thu, 19 Nov 2020 16:35:41 +0100
Date:   Thu, 19 Nov 2020 16:35:40 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH 1/3] spi: fix resource leak for drivers without .remove
 callback
Message-ID: <20201119153540.zehj2ppdt433xrsv@pengutronix.de>
References: <20201119152059.2631650-1-u.kleine-koenig@pengutronix.de>
 <20201119152416.GB5554@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ev7jq65coei6csnm"
Content-Disposition: inline
In-Reply-To: <20201119152416.GB5554@sirena.org.uk>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--ev7jq65coei6csnm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2020 at 03:24:16PM +0000, Mark Brown wrote:
> On Thu, Nov 19, 2020 at 04:20:57PM +0100, Uwe Kleine-K=F6nig wrote:
> > Consider an spi driver with a .probe but without a .remove callback (e.=
g.
> > rtc-ds1347). The function spi_drv_probe() is called to bind a device and
> > so some init routines like dev_pm_domain_attach() are used. As there is
> > no remove callback spi_drv_remove() isn't called at unbind time however
> > and so calling dev_pm_domain_detach() is missed and the pm domain keeps
> > active.
>=20
> > To fix this always use either both or none of the functions and make
> > them handle the callback not being set.
>=20
> Why would we want to tie configuring PM domains to either of these
> functions?  We certainly don't want to force drivers to have empty
> remove functions to trigger cleanup of domains, this would be
> counterintuitive and this stuff should be transparent to the driver.

Yes, I thought that this is not the final fix. I just sent the minimal
change to prevent the imbalance. So if I understand correctly, I will
have to respin with the following squashed into patch 1:

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 5bdc66f08ee1..5becf6c2c409 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -445,10 +445,8 @@ int __spi_register_driver(struct module *owner, struct=
 spi_driver *sdrv)
 {
 	sdrv->driver.owner =3D owner;
 	sdrv->driver.bus =3D &spi_bus_type;
-	if (sdrv->probe || sdrv->remove) {
-		sdrv->driver.probe =3D spi_drv_probe;
-		sdrv->driver.remove =3D spi_drv_remove;
-	}
+	sdrv->driver.probe =3D spi_drv_probe;
+	sdrv->driver.remove =3D spi_drv_remove;
 	if (sdrv->shutdown)
 		sdrv->driver.shutdown =3D spi_drv_shutdown;
 	return driver_register(&sdrv->driver);

(Not sure this makes a difference in real life, are there drivers
without a .probe callback?)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ev7jq65coei6csnm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+2kMkACgkQwfwUeK3K
7AmXmwf/UyRSqsFWoMBus73AI58aiRUQfApNamfXrp9bz7bBqPr4vLzdJBdbwktZ
LqzsuN1NJb+pkV0Gi/l27p516Xi13hnESsmBAIN2rx6n49j6JXShLPgFyyiMQ+OY
YyCqO61elba5kXqif1OdvI08/XrtlheU4XcIgRXioXTeBOGEjZDG6DDV+MNhrj6D
y6Qecwybgf6ms/wwj5YzZbd76rywrrOxZhZqF89wM7FCe+op3LjbmkZ/wDSJsfaP
Dgj609wr1rEl/3wCqGlPW9KOVemNSifE2zkDPM6mAR+ci2DiXtNeYdUDVF95H0o8
z3JfaYqdhE6BkSNbySWPC5y0YM/BEg==
=mc/u
-----END PGP SIGNATURE-----

--ev7jq65coei6csnm--
