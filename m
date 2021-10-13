Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1477742C26B
	for <lists+linux-spi@lfdr.de>; Wed, 13 Oct 2021 16:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbhJMOMI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Oct 2021 10:12:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230298AbhJMOMI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 13 Oct 2021 10:12:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BBE2F60F94;
        Wed, 13 Oct 2021 14:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634134205;
        bh=IR0xXHOu/uBLCWDMUu8wGnb9A3dW9XN2mVdc//Pd5hk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oU8HGAQsJsS4jMar+W7UobG/3t8m2WCpStM5WaO004poNQrvvM5Z7Frghxitzm5rA
         MQfgRbnhGfY8oyruQ3M96SuRXOq9tqIqAiYsuF4bE3J134/N+k76hqd3WlobTne93e
         hlT4D6nlarraeFcxOyKriYE1wT0Ywn59VRmR5wBz8heEuM6Hnvz3Ft1wkgRzksoAsI
         0Jv9KUpAgfyzDZL2aLeowrdF2ioyf+OVb0cU33w5HSPpJeuv2w62n7Vf5aqUB6J7Nx
         dpGn96iCwK4AmdKFoocqxThBCqIdVLnzbMhM63fcu/LZRUxdW88cmezszkn94Fncgp
         E/njRdQMwLzeg==
Date:   Wed, 13 Oct 2021 15:10:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: Fix deadlock when adding SPI controllers on SPI
 buses
Message-ID: <YWbousC9QAXrPxwb@sirena.org.uk>
References: <20211013122628.1369702-1-broonie@kernel.org>
 <20211013130005.shbj4cupoumse2vc@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="umY2YIOl04A4D6UL"
Content-Disposition: inline
In-Reply-To: <20211013130005.shbj4cupoumse2vc@pengutronix.de>
X-Cookie: Where do you think you're going today?
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--umY2YIOl04A4D6UL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 13, 2021 at 03:00:05PM +0200, Uwe Kleine-K=F6nig wrote:

> > -	mutex_lock(&spi_add_lock);
> > +	/* We need to make sure there's no other device with this
> > +	 * chipselect **BEFORE** we call setup(), else we'll trash
> > +	 * its configuration.  Lock against concurrent add() calls.
> > +	 */

> This comment is already there, it seems you duplicated it with your
> patch? Maybe a merge issue with
> 6bfb15f34dd8c8a073e03a31c485ef5774b127df?

It's not there in -next which is what this is against but it looks like
a mistake to remove it.  It'll actually get applied on the fixes branch
where that'll rebase out anyway.

--umY2YIOl04A4D6UL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFm6LkACgkQJNaLcl1U
h9DeQgf/ZTUJEfVChsY4QiMxu9KfhLzCI97R3NBzXA2K55NmqqaBrTuJiIiCcmYr
jk4rYI5dLB39SbZXhxKoFIVIPowglzL+QkmpDyMNo7BrZdzSVlDbU6T6WxH14UBD
hM0WREPMeKYA9Ip11MfoBEdB3KMQAaSpQuqryYT1NaJhDwfvx8XBFNXtTUNCiDG2
1PKnvuSlfa71ise6HgxmZpiep6i9ru1qH2d7FC015SrzWH1oW/Frwp0uciG5eIKo
qJgHH8LJK1uxspQO9XJTU5+mQuEX1D+Rk3mrGXQU5cKgoBkkyHWEdTmuZflPt8zO
5mBNLCD1ljDMieXANRLKlkGtkEzcPg==
=wTKu
-----END PGP SIGNATURE-----

--umY2YIOl04A4D6UL--
