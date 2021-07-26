Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0253D531E
	for <lists+linux-spi@lfdr.de>; Mon, 26 Jul 2021 08:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbhGZFoo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 26 Jul 2021 01:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhGZFom (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 26 Jul 2021 01:44:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EDEC061757
        for <linux-spi@vger.kernel.org>; Sun, 25 Jul 2021 23:25:10 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m7u32-00086h-2r; Mon, 26 Jul 2021 08:25:08 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m7u31-0003Bw-HK; Mon, 26 Jul 2021 08:25:07 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m7u31-0000QZ-GX; Mon, 26 Jul 2021 08:25:07 +0200
Date:   Mon, 26 Jul 2021 08:25:04 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Marek Vasut <marex@denx.de>, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: imx: mx51-ecspi: Fix low-speed CONFIGREG delay
 calculation
Message-ID: <20210726062504.4353stzjqrqhsqwy@pengutronix.de>
References: <20210718211143.143557-1-marex@denx.de>
 <20210719082015.ud43iwg5rfdomlqi@pengutronix.de>
 <17bf62a4-af57-1706-f20a-35f9d6cbf9d0@denx.de>
 <20210719211221.GA35544@sirena.org.uk>
 <37b0f7eb-39fd-9e15-20e3-becfcfd4b5f4@denx.de>
 <20210726014606.GB4670@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hp26ifqb3wb42qug"
Content-Disposition: inline
In-Reply-To: <20210726014606.GB4670@sirena.org.uk>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--hp26ifqb3wb42qug
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 26, 2021 at 02:46:06AM +0100, Mark Brown wrote:
> On Wed, Jul 21, 2021 at 10:18:35PM +0200, Marek Vasut wrote:
>=20
> > So, should I send a V2 here with any changes or is this one OK as-is ?
>=20
> It wasn't clear that Uwe was OK with the current version, I don't mind.

My concerns were mostly orthogonal to Marek's patch. The only (little
critical) thing is: Can it happen that all transfer's speed_hz are zero?
What happens with the code change is ok, when reading the code this
looks this is by chance howver. So I would have added a comment
describing that.

But all in all I'm convinced that the change is an improvement, so no
further concerns from my side.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--hp26ifqb3wb42qug
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmD+VT4ACgkQwfwUeK3K
7AlGiAf+LE3N5hOgpdMb8mRcm9Ii9kYIurIZASUWmQdLRL28ReRko3D6BUwwGEG7
EEh9x7JeMQZu1K+5ErqRW4BR4KZd4x4x9/gDsVWZu7QHpG/NEA5pJ3pLpRL370KV
k+lpxJDScOBH+TYcROCqgfSsxrQxsngfgE9dUMZ16xBvRIDE/OAnSpchkdsde++T
xsNE6eLxJG2Z/FjNT3HdozTqi3C6AeCNsDcLr0LecwI8usesXBKctkH4gCKxT7Wq
S7pBoswHLjPrRDxwYnmjo77dM0Gq1QerptSv1nGZ/ozCmRMveVHUttEo1D3lKYT4
5vz0Cx9ZLnLARvmBNe0QSVdud1n2mw==
=HCHA
-----END PGP SIGNATURE-----

--hp26ifqb3wb42qug--
