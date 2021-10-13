Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4CDB42B929
	for <lists+linux-spi@lfdr.de>; Wed, 13 Oct 2021 09:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbhJMHf4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Oct 2021 03:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238405AbhJMHfz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 Oct 2021 03:35:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76F4C061714
        for <linux-spi@vger.kernel.org>; Wed, 13 Oct 2021 00:33:52 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maYlq-0005PA-QU; Wed, 13 Oct 2021 09:33:50 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maYlo-0005GT-0p; Wed, 13 Oct 2021 09:33:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maYln-0006mV-Vm; Wed, 13 Oct 2021 09:33:47 +0200
Date:   Wed, 13 Oct 2021 09:33:45 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@intel.com>
Subject: Re: Deadlock in spi_add_device() -- device core problem
Message-ID: <20211013073345.tineupm3unuyjzxk@pengutronix.de>
References: <20211007160524.qhjtcwtto2ftsmhe@pengutronix.de>
 <YV8eIoxIxQLC5x5N@kroah.com>
 <20211007165214.r5h7x3evdqbwxmma@pengutronix.de>
 <YWBITX2Wbfx/QHCE@sirena.org.uk>
 <20211012193005.lxqzbsdeh4k7nxe2@pengutronix.de>
 <YWaCMwt+2QVRfCKY@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kmrcrxhpjwp2yhq5"
Content-Disposition: inline
In-Reply-To: <YWaCMwt+2QVRfCKY@kroah.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--kmrcrxhpjwp2yhq5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 13, 2021 at 08:52:35AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Oct 12, 2021 at 09:30:05PM +0200, Uwe Kleine-K=F6nig wrote:
> > Hi Mark,
> >=20
> > On Fri, Oct 08, 2021 at 02:31:57PM +0100, Mark Brown wrote:
> > > On Thu, Oct 07, 2021 at 06:52:14PM +0200, Uwe Kleine-K=F6nig wrote:
> > > > On Thu, Oct 07, 2021 at 06:19:46PM +0200, Greg Kroah-Hartman wrote:
> > > > > On Thu, Oct 07, 2021 at 06:05:24PM +0200, Uwe Kleine-K=F6nig wrot=
e:
> > >=20
> > > > > Drivers for a bus bind to the bus, they should not be creating new
> > > > > devices for that same bus, as that does not seem correct.
> > >=20
> > > > That's not the culprit here. We have a spi-device (spi-mux) that is=
 a
> > > > bus device on the SoC's bus and a bus master for it's own bus. And
> > > > spi_add_device for the spi-mux device triggers the probe function f=
or
> > > > the spi-mux driver which creates a new bus controller which triggers
> > > > spi_add_device() for the devices on the inner bus.
> > >=20
> > > I think we need to be arranging for spi_add_lock to be per bus
> > > rather than global - putting it into the controller ought to do
> > > the trick.
> >=20
> > Yeah, that's what I consider the second best option that I already
> > mentioned in the initial mail of this thread.

I tested that a bit, I'll have to address an lockdep splat for it
(because the lock is used in a nested way), otherwise it at least fixes
the deadlock.

> > @Greg: Would you expect that it should be possible (and benificial) to
> > rework the code to not hold a lock at all during device_add()?
>=20
> rework the driver core or the spi code?
>=20
> /me is confused...

I expect the driver core to be fine. I meant the spi core. i.e. is it
bad enough that the spi core holds a lock during device_add() to
justify some effort to fix that; and is such a fix even possible?

> > This would then need something like:
> >=20
> > 	lock() # either per controller or global
> > 	if bus already has a device for the same chipselect:
> > 	    error out;
> > 	register chipselect as busy
> > 	unlock();
> >=20
> > 	ret =3D device_add(...)
> >=20
> > 	if ret:
> > 	    lock()
> > 	    unregister chipselect
> > 	    unlock()
> >=20
> > Is this worth the effort?
>=20
> Watch out that you do not have probe() calls racing each other, we have
> guaranteed that they will be called serially in the past.

That won't happen because if there are really two devices to be
registered on the same CS line, only for one of them device_add() is
called. Ah, there is an ambiguity in my pseudo code, I guess this one is
better:

 	lock() # either per controller or global
 	if bus already has the CS marked as busy:
 	    error out;
 	mark chipselect as busy
 	unlock();
=20
 	ret =3D device_add(...)
=20
 	if ret:
 	    lock()
 	    mark chipselect as free
 	    unlock()

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--kmrcrxhpjwp2yhq5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFmi9YACgkQwfwUeK3K
7AlM8wgAluKaTeOwjdu+d2QQPSQSvWmgFJLw9yCiLRBXO4fSF6SI4enOUy9QD2sx
rSyBP810UHavBm7HeFTbTehVb2t+IvY/0es7/a+UebLjwELueTsrxCGitxV1SRaH
gSMfpk+LNvsMfoeLXb8rOocuAFCAXla+OLa1KqApYYdkEcfsAOadxzKh7etuvJj8
NPBM1E6acGC4T9J7EmBpp9BbNO+pXChkUkhbISVnL94Fgc1gl0rt4J2NG5sO8pbf
jL2NKu20eirfQl+L5iUmMl5IagGrkIotqlCpPwlp5qGpUliQqlSifBGkfNNDnsms
BB38/p7b1BpFpbYlqDNNhs6PXc8QAg==
=BI0f
-----END PGP SIGNATURE-----

--kmrcrxhpjwp2yhq5--
