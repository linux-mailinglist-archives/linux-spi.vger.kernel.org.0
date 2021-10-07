Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647DF425876
	for <lists+linux-spi@lfdr.de>; Thu,  7 Oct 2021 18:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhJGQyN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Oct 2021 12:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhJGQyM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 7 Oct 2021 12:54:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC57C061570
        for <linux-spi@vger.kernel.org>; Thu,  7 Oct 2021 09:52:18 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mYWcy-0006YG-Qo; Thu, 07 Oct 2021 18:52:16 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mYWcw-0006J4-Py; Thu, 07 Oct 2021 18:52:14 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mYWcw-0007bI-OK; Thu, 07 Oct 2021 18:52:14 +0200
Date:   Thu, 7 Oct 2021 18:52:14 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@intel.com>
Subject: Re: Deadlock in spi_add_device() -- device core problem
Message-ID: <20211007165214.r5h7x3evdqbwxmma@pengutronix.de>
References: <20211007160524.qhjtcwtto2ftsmhe@pengutronix.de>
 <YV8eIoxIxQLC5x5N@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nf6oy76gyvmiqlf3"
Content-Disposition: inline
In-Reply-To: <YV8eIoxIxQLC5x5N@kroah.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--nf6oy76gyvmiqlf3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 07, 2021 at 06:19:46PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Oct 07, 2021 at 06:05:24PM +0200, Uwe Kleine-K=F6nig wrote:
> > On an ARM board with an spi-mux I observe a deadlock during boot. This
> > happens because spi_add_device() (in drivers/spi/spi.c) for the spi-mux
> > device calls device_add() while holding &spi_add_lock. The spi-mux
> > driver's probe routine than creates another controller and for the
> > devices on that bus spi_add_device() is called again, trying to grab
> > &spi_add_lock again.
> >=20
> > The easy workaround would be to replace &spi_add_lock with a
> > per-controller lock, but I have the expectation that it should be
> > possible to not hold a lock while calling device_add().
>=20
> No, busses should not be adding new devices to the same bus from within
> a probe function.
>=20
> Drivers for a bus bind to the bus, they should not be creating new
> devices for that same bus, as that does not seem correct.

That's not the culprit here. We have a spi-device (spi-mux) that is a
bus device on the SoC's bus and a bus master for it's own bus. And
spi_add_device for the spi-mux device triggers the probe function for
the spi-mux driver which creates a new bus controller which triggers
spi_add_device() for the devices on the inner bus.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--nf6oy76gyvmiqlf3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFfJbYACgkQwfwUeK3K
7AnLLwf/evU/hSuDWDD1dvmhul5a1DqLO/8qnHcwW9coepd+qIWzkM8LGVSQGzQb
w6VaxVEmS4leMJlpu4njMXHlw6y+XNf4NkELFso/JWjQANOW61/Yt0af8qU8PhWV
6P1SCCEyB5G1/FELAVxdrjw3TifyBITuGrHd4KtJVtJ6YlT4rJHFGS9mfOdXXvX4
L7oiqahvMZbcT/nNZKopAgxmbJ9prbhUI0302QTXz4uPOS+oEe0OrS5UU2aa4whg
UAJDoyo/6fkA8IBdVhCmgFjwKpal1uWNKUrI4JCenMgJlT8EqnoiywGjrRp6f+XA
PSNWJjMNbQtbrmsJMqYNARj/cfTZuQ==
=VwwO
-----END PGP SIGNATURE-----

--nf6oy76gyvmiqlf3--
