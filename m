Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7595344C5F2
	for <lists+linux-spi@lfdr.de>; Wed, 10 Nov 2021 18:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbhKJRcN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Nov 2021 12:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhKJRcN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 10 Nov 2021 12:32:13 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE80C061764
        for <linux-spi@vger.kernel.org>; Wed, 10 Nov 2021 09:29:25 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mkrPY-0007kx-0L; Wed, 10 Nov 2021 18:29:24 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mkrPX-0003Je-5O; Wed, 10 Nov 2021 18:29:22 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mkrPV-00010t-UG; Wed, 10 Nov 2021 18:29:21 +0100
Date:   Wed, 10 Nov 2021 18:28:47 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [RFC PATCH] spi: fix use-after-free of the add_lock mutex
Message-ID: <20211110172847.4wbi5k57zs3zn3vq@pengutronix.de>
References: <20211110160836.3304104-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x75mmyzinzb2pknf"
Content-Disposition: inline
In-Reply-To: <20211110160836.3304104-1-michael@walle.cc>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--x75mmyzinzb2pknf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Nov 10, 2021 at 05:08:36PM +0100, Michael Walle wrote:
> Commit 6098475d4cb4 ("spi: Fix deadlock when adding SPI controllers on
> SPI buses") introduced a per-controller mutex. But mutex_unlock() of
> said lock is called after the controller is already freed:
>=20
>   spi_unregister_controller(ctlr)
>    -> put_device(&ctlr->dev)
>     -> spi_controller_release(dev)
>   mutex_unlock(&ctrl->add_lock)

This is indented in a misleading way. mutex_unlock() has to be on the
same level as put_device().

> Move the put_device() after the mutex_unlock().
>=20
> Fixes: 6098475d4cb4 ("spi: Fix deadlock when adding SPI controllers on SP=
I buses")
> Signed-off-by: Michael Walle <michael@walle.cc>

I first thought this was wrong, and the put_device must be dropped
altogether, but after some code reading I agree this is the right fix.

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

> ---
> I'm not sure if this is the correct fix. I don't know if the put_device()
> will have to be protected by the add_lock (remember before, the add_lock
> was a global lock).

No, put_device doesn't need to be protected by this lock.

Best regards and thanks for the report and diagnosis,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--x75mmyzinzb2pknf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGMAUUACgkQwfwUeK3K
7An/JAf/QD3dP2/+T7j4TVgz5FpwOMq4zDRjuMCkLrEKbHHOwFtMy52mlKcsQUN8
shMwOBofc9MWYrAxbEzp9k74g2mheDwUsOZCbLXEHAifMkHbc7csL0s09Cgg27Vi
xYdqbgpO5dogFgRFNHtazUJOKZLrr4UENE4QiB8YoNC67m5GH+xiNT6n3elbIP9C
eJqp2Z3GoRlimpbr0JdKsWsQDAtd/oOr+/+G19Ecu6js7TSq2LQ/qeiDjCLxHed/
w1lgE7Cu13JoThNYB7wtPBKXFMPWM7EVb6PhcQXMnEgVe2+YHZg6avDLkcWEGBbb
Nre+ah1h9gkofYkNcfVOd/yF7n90vg==
=5jyf
-----END PGP SIGNATURE-----

--x75mmyzinzb2pknf--
