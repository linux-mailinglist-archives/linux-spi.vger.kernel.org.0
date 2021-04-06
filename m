Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7297C354D29
	for <lists+linux-spi@lfdr.de>; Tue,  6 Apr 2021 08:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbhDFG5k (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 6 Apr 2021 02:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244099AbhDFG5j (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 6 Apr 2021 02:57:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C85C06174A
        for <linux-spi@vger.kernel.org>; Mon,  5 Apr 2021 23:57:32 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lTfeS-0003hH-53; Tue, 06 Apr 2021 08:57:28 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lTfeR-000771-IE; Tue, 06 Apr 2021 08:57:27 +0200
Date:   Tue, 6 Apr 2021 08:57:27 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, kernel@pengutronix.de,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v4 6/6] spi: davinci: Simplify using
 devm_clk_get_enabled()
Message-ID: <20210406065727.i7wbve2ihdblq24p@pengutronix.de>
References: <20210330181755.204339-1-u.kleine-koenig@pengutronix.de>
 <20210330181755.204339-7-u.kleine-koenig@pengutronix.de>
 <20210331120212.GB4758@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b3oia2ax5tjtswo5"
Content-Disposition: inline
In-Reply-To: <20210331120212.GB4758@sirena.org.uk>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--b3oia2ax5tjtswo5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Mark,

On Wed, Mar 31, 2021 at 01:02:12PM +0100, Mark Brown wrote:
> On Tue, Mar 30, 2021 at 08:17:55PM +0200, Uwe Kleine-K=F6nig wrote:
> > devm_clk_get_enabled() returns the clk already (prepared and) enabled
> > and the automatically called cleanup cares for disabling (and
> > unpreparing). So simplify .probe() and .remove() accordingly.
>=20
> Acked-by: Mark Brown <broonie@kernel.org>

Thanks. I wonder what you think about this series. Is it more "Well, ok,
if you must, the change you did to this spi driver looks correct." or
"This is a good simplification and a similar change for nearly all other
spi drivers that make use of a clk is possible, too. Dear clk
maintainers, please go forward and apply this useful series."?

Best regards
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--b3oia2ax5tjtswo5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBsBlMACgkQwfwUeK3K
7Al2zAf9HnFqMN1hf7hIPT7XC6aTNTUdmRm/FAyZkZ7j+UFHeRkY95S4vP7WWVii
3h+wmaalGPhvS3hpJnTPqpzZMySvsAe4/SdgTNCPJzDgrgA4NXtcWA/BKikJNzCy
AtheLoSQUvuo6gM8Slz1CyzsJbm5HQgRWOCDMFeOv4uX6vwHfF4IGRXivOJEbv7J
lbmLpT03mqEQyFJ+9OCEPDgYdBlVvFgrJrk1czbKlY+0L3iQ9dzKP6y4lOexWrjR
xiSfLRNXWrhbj9ibTZvS+buHhoz4JDKClHgflJzoXzW8HlxNo1n3Bfn//zCzvsk1
a5YpWJjRTaJ2PPwwDm0XU0Dr/r3Kjw==
=eRkg
-----END PGP SIGNATURE-----

--b3oia2ax5tjtswo5--
