Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B84F2B9753
	for <lists+linux-spi@lfdr.de>; Thu, 19 Nov 2020 17:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgKSQEU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Nov 2020 11:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbgKSQET (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 19 Nov 2020 11:04:19 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EE2C0613CF
        for <linux-spi@vger.kernel.org>; Thu, 19 Nov 2020 08:04:19 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kfmPu-0002YN-HH; Thu, 19 Nov 2020 17:04:14 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kfmPu-0002Tc-2N; Thu, 19 Nov 2020 17:04:14 +0100
Date:   Thu, 19 Nov 2020 17:04:12 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH 1/3] spi: fix resource leak for drivers without .remove
 callback
Message-ID: <20201119160412.nhu2rmwygyh6yg6e@pengutronix.de>
References: <20201119152059.2631650-1-u.kleine-koenig@pengutronix.de>
 <20201119152416.GB5554@sirena.org.uk>
 <20201119153540.zehj2ppdt433xrsv@pengutronix.de>
 <20201119154139.GC5554@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rmqir3z3i5d6ibg2"
Content-Disposition: inline
In-Reply-To: <20201119154139.GC5554@sirena.org.uk>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--rmqir3z3i5d6ibg2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Mark,

On Thu, Nov 19, 2020 at 03:41:39PM +0000, Mark Brown wrote:
> On Thu, Nov 19, 2020 at 04:35:40PM +0100, Uwe Kleine-K=F6nig wrote:
>=20
> > Yes, I thought that this is not the final fix. I just sent the minimal
> > change to prevent the imbalance. So if I understand correctly, I will
> > have to respin with the following squashed into patch 1:
>=20
> > -	if (sdrv->probe || sdrv->remove) {
> > -		sdrv->driver.probe =3D spi_drv_probe;
> > -		sdrv->driver.remove =3D spi_drv_remove;
> > -	}
> > +	sdrv->driver.probe =3D spi_drv_probe;
> > +	sdrv->driver.remove =3D spi_drv_remove;
> >  	if (sdrv->shutdown)
> >  		sdrv->driver.shutdown =3D spi_drv_shutdown;
> >  	return driver_register(&sdrv->driver);
>=20
> I think so, I'd need to see the full patch to check of course.

ok.
=20
> > (Not sure this makes a difference in real life, are there drivers
> > without a .probe callback?)
>=20
> Your changelog seemed to say that it would make remove mandatory.

No, that's not what the patch did. It made unconditional use of
spi_drv_remove(), but an spi_driver without .remove() was still ok. I
will reword to make this clearer.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rmqir3z3i5d6ibg2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+2l3gACgkQwfwUeK3K
7AnCAAf+IRPrMX+u6PY9dY3FiFrasPt1waNBHafpoJuBF2t9bgI8Os2Kd7bfrLVI
Ug+o+5GaTgm1n6DZPjdwuOwLtUKlzYuJ4HJKpbY7Ao2Fp+ebE8Dy4aBenP9ZTkdZ
P8ugGoji132gp5jGqkCxPlCYyBOClfmnK4IZ5L8luqetRK3ziVdbLTWU2CT+qVzk
RG2jorydutq55DJLV6C1ZEFFD6AdY5hTyKuTRIOz7/H4/bQ1PYLK1+kTagFLdF/7
DifptE7/3b0xY/FsHJDuJnURcyIhE4yANUy5ANaksNWXWdUefD2e+MuaySPoEaIF
rdjpK1BGtKAannQ5xUYrHSb/jp8XxA==
=UFeg
-----END PGP SIGNATURE-----

--rmqir3z3i5d6ibg2--
