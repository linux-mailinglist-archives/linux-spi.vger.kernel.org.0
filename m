Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247E342C5E8
	for <lists+linux-spi@lfdr.de>; Wed, 13 Oct 2021 18:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236325AbhJMQMk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Oct 2021 12:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235949AbhJMQMj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 Oct 2021 12:12:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64D2C061570
        for <linux-spi@vger.kernel.org>; Wed, 13 Oct 2021 09:10:35 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1magpu-00049p-2B; Wed, 13 Oct 2021 18:10:34 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1magpt-0005fE-Gh; Wed, 13 Oct 2021 18:10:33 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1magpt-0008Hc-Fo; Wed, 13 Oct 2021 18:10:33 +0200
Date:   Wed, 13 Oct 2021 18:10:33 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     kernel@pengutronix.de, linux-spi@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: Make spi_add_lock a per-controller lock
Message-ID: <20211013161033.yrquwcgwzqxwfszo@pengutronix.de>
References: <20211013133710.2679703-1-u.kleine-koenig@pengutronix.de>
 <YWb5gUxgdiczqV5Q@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2lbbwamcbup3dnyl"
Content-Disposition: inline
In-Reply-To: <YWb5gUxgdiczqV5Q@sirena.org.uk>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--2lbbwamcbup3dnyl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Mark,

On Wed, Oct 13, 2021 at 04:21:37PM +0100, Mark Brown wrote:
> On Wed, Oct 13, 2021 at 03:37:09PM +0200, Uwe Kleine-K=F6nig wrote:
> > The spi_add_lock that is removed with this change was held when
> > spi_add_device() called device_add() (via __spi_add_device()).
> >=20
> > In the case where the added device is an spi-mux calling device_add()
> > might result in calling the spi-mux's probe function which adds another
> > controller and for that spi_add_device() might be called. This results
> > in a dead-lock.
> >=20
> > To circumvent this deadlock replace the global spi_add_lock with a lock
> > per controller.
> >=20
> > The biggest part of this patch was authored by Mark Brown.
>=20
> I'll go ahead with my copy of this (partly as I've already got it
> ready queued).

That's what I expected, I just sent it that the base for patch 2 is
properly available e.g. for the autobuilders. Did you modify your patch
since you sent it? If you resend or apply to your tree I can rebase
patch 2 on top of it.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--2lbbwamcbup3dnyl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFnBPYACgkQwfwUeK3K
7AnN1gf/VhuboxH8g700ExzHTeut5IZ0CxTHe7+HZlnxDqPiO0nhRpu4LIRSiahH
94tO06bkhDg4ZfRUBx/e/Z0bywKIlB1wEWTQTiqZOgsenLl8P/nrokuWGFw+u+KR
PLITYWiowOirCSMLjTFur7ny5O+g+v05M/Qv2u9gwBqqddiH079FLyGTln/V3RzK
rnq9uH2OfGFmQUYSU3izyQFa97rcXE2MJo/IvSxXqoFC02phxM3+JeZbIDZ1rEGh
JCzK62yL3MHftj8oXJO8V6Rk2LICfpzHmGcv0AozUeDM8f7drDhMlQgMoab4I8H8
kTuQplEx3SMJVPdHZ3FR38j90SXIAw==
=g35D
-----END PGP SIGNATURE-----

--2lbbwamcbup3dnyl--
