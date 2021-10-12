Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1EED42AD4C
	for <lists+linux-spi@lfdr.de>; Tue, 12 Oct 2021 21:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbhJLTcO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Oct 2021 15:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbhJLTcM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Oct 2021 15:32:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0F6C061570
        for <linux-spi@vger.kernel.org>; Tue, 12 Oct 2021 12:30:10 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maNTU-0008Gn-Ai; Tue, 12 Oct 2021 21:30:08 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maNTR-0004qT-No; Tue, 12 Oct 2021 21:30:05 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maNTR-000545-KZ; Tue, 12 Oct 2021 21:30:05 +0200
Date:   Tue, 12 Oct 2021 21:30:05 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-spi@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@intel.com>
Subject: Re: Deadlock in spi_add_device() -- device core problem
Message-ID: <20211012193005.lxqzbsdeh4k7nxe2@pengutronix.de>
References: <20211007160524.qhjtcwtto2ftsmhe@pengutronix.de>
 <YV8eIoxIxQLC5x5N@kroah.com>
 <20211007165214.r5h7x3evdqbwxmma@pengutronix.de>
 <YWBITX2Wbfx/QHCE@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uhajcyzcuy4uhus2"
Content-Disposition: inline
In-Reply-To: <YWBITX2Wbfx/QHCE@sirena.org.uk>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--uhajcyzcuy4uhus2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Fri, Oct 08, 2021 at 02:31:57PM +0100, Mark Brown wrote:
> On Thu, Oct 07, 2021 at 06:52:14PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Thu, Oct 07, 2021 at 06:19:46PM +0200, Greg Kroah-Hartman wrote:
> > > On Thu, Oct 07, 2021 at 06:05:24PM +0200, Uwe Kleine-K=F6nig wrote:
>=20
> > > Drivers for a bus bind to the bus, they should not be creating new
> > > devices for that same bus, as that does not seem correct.
>=20
> > That's not the culprit here. We have a spi-device (spi-mux) that is a
> > bus device on the SoC's bus and a bus master for it's own bus. And
> > spi_add_device for the spi-mux device triggers the probe function for
> > the spi-mux driver which creates a new bus controller which triggers
> > spi_add_device() for the devices on the inner bus.
>=20
> I think we need to be arranging for spi_add_lock to be per bus
> rather than global - putting it into the controller ought to do
> the trick.

Yeah, that's what I consider the second best option that I already
mentioned in the initial mail of this thread.

@Greg: Would you expect that it should be possible (and benificial) to
rework the code to not hold a lock at all during device_add()?

This would then need something like:

	lock() # either per controller or global
	if bus already has a device for the same chipselect:
	    error out;
	register chipselect as busy
	unlock();

	ret =3D device_add(...)

	if ret:
	    lock()
	    unregister chipselect
	    unlock()

Is this worth the effort?

Anyhow, will try the suggested patch next.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--uhajcyzcuy4uhus2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFl4joACgkQwfwUeK3K
7Amr7ggAmv3EAWA7U5pSeEB2W8H6tMwNNw36IYt9cm2kCNsTvxKf2chT/ke3wOIu
2mP1AEE1eaRfBXcjw3tPfLMdrK0mJxVPGhYqSgbc4BI9/Rzt0QSDZ8vRsMBwmvue
NkbQmqROGbpsG14T5XUs3NZwJu7t+X/KEKkR61k9jGthw7BMLk6NRjxM3ggWU6W2
0w6c3toOveOV6tXnZY4YB9USMD+HEe/P2vlVFCtf1nJiTyHLxI+Qqf2Fh0ByiNCh
pOL07xUTwGbfblISCQvZVdqU8hLu6jOWmaJ1amufKqg+Qs+Rq33CSitin2eEvaeZ
kXTsYCcFiRbvyqYJodjNAd11oQBR9A==
=PT5L
-----END PGP SIGNATURE-----

--uhajcyzcuy4uhus2--
