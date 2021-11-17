Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279524546B7
	for <lists+linux-spi@lfdr.de>; Wed, 17 Nov 2021 13:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235743AbhKQM6S (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 17 Nov 2021 07:58:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:58436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235135AbhKQM6S (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 17 Nov 2021 07:58:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7575861B7D;
        Wed, 17 Nov 2021 12:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637153719;
        bh=8JLZmI9VYjUjkTwlKzaUB2jGVugQsQHRSvVyCU0a5gw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RxmGFuA1QFLoIvddFpnX7yipA/mGAdKzmsjvyEiKjXm9AlhP4Jm40fSsDB+C58J0f
         JSpE3v1vBgdfgxtHUCajhN+2uejc0wKibHMeQ+lTiuC0l11SrnZZ8BKyMFMifU9Xw2
         2T9z9eYkgX7r1uBoZz3vGLdqjOMZ8ZIrFdl7BuG8jyow1HHIwPrjJRsMJ3un3FGmJt
         IsWaY5AkeCZAhOyaKAtSTsOjDfonpHAHi9/yOTRhX/rAcNPs3D0vgrH3nlD1SUUEor
         3n4hTvksnXK6NwvrJQM+KrXq6CrFzZrzhzvGu00g5XTr/m5xMF2FNX2gA+2PXYoZGE
         rEGQM9dmkvJqA==
Date:   Wed, 17 Nov 2021 12:55:14 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-spi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 1/3] dt-bindings: spi: renesas,rspi: Document RZ/G2L SoC
Message-ID: <YZT7suWucdD+FU6k@sirena.org.uk>
References: <20211117010527.27365-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211117010527.27365-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dTY+a439r+UjD8cz"
Content-Disposition: inline
In-Reply-To: <20211117010527.27365-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Cookie: One Bell System - it sometimes works.
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--dTY+a439r+UjD8cz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 17, 2021 at 01:05:25AM +0000, Lad Prabhakar wrote:
> Add RSPI binding documentation for Renesas RZ/G2L SoC.
>=20
> RSPI block is identical to one found on RZ/A, so no driver changes are
> required the fallback compatible string "renesas,rspi-rz" will be used
> on RZ/G2L

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--dTY+a439r+UjD8cz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGU+7EACgkQJNaLcl1U
h9BdtAf/VmkMMGhu3XIzeaXgRoqE0g29SY/hGvaybxu0nXF+m0MZrbbpS83fNEe6
EffVbR0u5hsbdNCQtvOE4mf/saXqtnKMNetoxmYYZZMB5Lc1aPkk/pT2I1GtMd1Y
P2qI2S9PxpJfHQhe22ziN9N14ZBONPWoX50YojMVbOGpbxUTjctDZca6h++8hNcZ
xe2Z55pKMTWGalEMeoXpVLPIXxh+53wnr1r/bgFxtO2xPwYMPv9QhZIz9XPSLdHV
kmq/QavqBPe+baiwog+QzaFx44hf8Kgz2ynAA7km6aMwXXtxsE6xWwObNdVz+gTx
eKPdt55LNZaxQDJhWsSVyq3uUNQx1g==
=IzaT
-----END PGP SIGNATURE-----

--dTY+a439r+UjD8cz--
