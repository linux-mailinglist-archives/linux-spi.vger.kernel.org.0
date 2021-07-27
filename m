Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62FC93D757D
	for <lists+linux-spi@lfdr.de>; Tue, 27 Jul 2021 15:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbhG0NBP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Jul 2021 09:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbhG0NBP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 27 Jul 2021 09:01:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BB1C061757
        for <linux-spi@vger.kernel.org>; Tue, 27 Jul 2021 06:01:15 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m8Mht-0008Rc-LF; Tue, 27 Jul 2021 15:01:13 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m8Mht-0006SG-3x; Tue, 27 Jul 2021 15:01:13 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m8Mht-0004z5-36; Tue, 27 Jul 2021 15:01:13 +0200
Date:   Tue, 27 Jul 2021 15:01:10 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: imx: mx51-ecspi: Fix CONFIGREG delay comment
Message-ID: <20210727130110.dm5wa6hwrrftwt6g@pengutronix.de>
References: <20210726101502.6803-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2bzarcffkzblifzl"
Content-Disposition: inline
In-Reply-To: <20210726101502.6803-1-marex@denx.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--2bzarcffkzblifzl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 26, 2021 at 12:15:02PM +0200, Marek Vasut wrote:
> For (2 * 1000000) / min_speed_hz < 10 to be true in naturals with zero,
> the min_speed_hz must above 222222. Update the comment. No functional
> change.

With integer division delay is < 10 if min_speed_hz >=3D 200001.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--2bzarcffkzblifzl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmEAA5MACgkQwfwUeK3K
7AmqnAf9HSiuepKOxe8iNSn28tR971fpfFSil947fbBTnLwhgtbPmHFzO9TVfVd2
JHhJE3oKJSYwWSC39ANUBJuX5qviEgKuUf0VSZjqPM5L6zRqlbE1Q5W/Qw3RVZb7
tKtOh0/7x68x8iZlvX/C41WTPUCfQOJPO+o9PTgtnZGDITMcfS8lOkJ3W8vDtdsR
yi5vP91oiAgU+tjFg+2n3ki3mCbmjiaosE/Lpmj/KYcB7fdLQSydjurWaVSwBSUA
fBNwrrvvDxUQvsOeyff/ZaBNLCyDCEt31g5Cp6mI0t+kac6f2WdT9kn0cDbU8iPW
VXypBPdXhJxLHGifNTcw1A+omVq2LQ==
=q55Z
-----END PGP SIGNATURE-----

--2bzarcffkzblifzl--
