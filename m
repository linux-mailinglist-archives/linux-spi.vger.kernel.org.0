Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E3F3D89DD
	for <lists+linux-spi@lfdr.de>; Wed, 28 Jul 2021 10:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbhG1Ihd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 28 Jul 2021 04:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbhG1Ihc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 28 Jul 2021 04:37:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D72C061757
        for <linux-spi@vger.kernel.org>; Wed, 28 Jul 2021 01:37:31 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m8f4D-0006Xu-Nc; Wed, 28 Jul 2021 10:37:29 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m8f4D-0008M7-6H; Wed, 28 Jul 2021 10:37:29 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m8f4D-0007q6-5Y; Wed, 28 Jul 2021 10:37:29 +0200
Date:   Wed, 28 Jul 2021 10:37:29 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2] spi: imx: mx51-ecspi: Fix CONFIGREG delay comment
Message-ID: <20210728083729.uadiamed6rhszedd@pengutronix.de>
References: <20210727160428.7673-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w7e5e2qpbmwyq3rh"
Content-Disposition: inline
In-Reply-To: <20210727160428.7673-1-marex@denx.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--w7e5e2qpbmwyq3rh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 27, 2021 at 06:04:28PM +0200, Marek Vasut wrote:
> For (2 * 1000000) / min_speed_hz < 10 to be true in naturals with zero,
> the min_speed_hz must be above 200000 (i.e. 200001 rounds down to 9, so
> the condition triggers). Update the comment. No functional change.
>=20
> Fixes: 6fd8b8503a0dc ("spi: spi-imx: Fix out-of-order CS/SCLK operation a=
t low speeds")
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Cc: Mark Brown <broonie@kernel.org>
> ---
> V2: It is not 100 kHz, 181 kHz, 222 kHz, it is 200 kHz. Make it so.

:-)

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks for addressing my comments.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--w7e5e2qpbmwyq3rh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmEBF0YACgkQwfwUeK3K
7AlUWwgAnQ5uGPwm+LYP8Z674Ht7JFRsnM+qjixDWPE3Xloh4GniS2i8PjBZEWAL
S8nzM8QvfUsCbM4Mk4mVFeiVdi/+SII4QdU+Cj8FxONsVAmoLtSIOIoXrlOQC5Fp
kMwPh4y1Fd5Scvwtqd9VOPI5dB9/I4SV6285YpKjNOcV2/mFD5bjtoUXKDsQzgeo
wWz/j3mUHbg8XNQXAgCUbfVEantfJz6fy5OYOStO3m5mOp92Uo8pFVpxITDnm/UL
x8rFdR/36iY6dHPcAyrTvqDht7OcJYqIJCxrw0x7AKhZhNKTIV+UMlUTGpAs+ebW
SWFBO+uPz6ZCfyEHtqwRfUNyuC/mwg==
=8/Ym
-----END PGP SIGNATURE-----

--w7e5e2qpbmwyq3rh--
