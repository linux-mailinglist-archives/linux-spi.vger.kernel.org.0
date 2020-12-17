Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E3A2DD210
	for <lists+linux-spi@lfdr.de>; Thu, 17 Dec 2020 14:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbgLQNYD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Dec 2020 08:24:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:50390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbgLQNYC (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 17 Dec 2020 08:24:02 -0500
Date:   Thu, 17 Dec 2020 13:23:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608211402;
        bh=XKt5tAFhcwxz/AevpgL/ezHmwTRd7kyChxf2m5JWcR4=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=ooObIG7rsS6uT9uVgiqmWc+825xQ0YMoXSZt402Z+/CT3siIvKFzOeDX9Oj1wbh0Y
         HWmQJ32nDy2LpbxWRSwVG/Aqo8lOBKysPy2ee5hnpFKEUJMqI3P1DIqtHpCtxWcW80
         hX1R3EvOw+FLwfk0VC1yflDRGMMTfxixmvq4AL3wuVvF6i0kmdte7EqGMrvnizotVN
         mnVFZfK//BJIrFATtDnG1pfAxeftFL9evZLbiVDDt2u0VaqXXvQVTOX/uXKhsrnxom
         SdkLK6WM5bGInOcKkjnHgW46M2H0gYyP0fKGgcLuROPm0gIWpvfCrqx8gfeTye48ZZ
         45b/WBhKCN9cg==
From:   Mark Brown <broonie@kernel.org>
To:     kostap@marvell.com
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mw@semihalf.com, jaz@semihalf.com,
        nadavh@marvell.com, bpeled@marvell.com, stefanc@marvell.com
Subject: Re: [PATCH 1/3] spi: orion: enable clocks before spi_setup
Message-ID: <20201217132309.GB4708@sirena.org.uk>
References: <20201217112708.3473-1-kostap@marvell.com>
 <20201217112708.3473-2-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Content-Disposition: inline
In-Reply-To: <20201217112708.3473-2-kostap@marvell.com>
X-Cookie: I'll eat ANYTHING that's BRIGHT BLUE!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 17, 2020 at 01:27:06PM +0200, kostap@marvell.com wrote:
> each time the spi_setup() is called.
>=20
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> Reviewed-by: Stefan Chulski <Stefan.Chulski@cavium.com>
> ---

You've not provided a Signed-off-by for this so I can't do anything with
it, please see Documentation/process/submitting-patches.rst for details
on what this is and why it's important.

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/bW7wACgkQJNaLcl1U
h9BdIgf9EoRi2/0nOKirOSgKAzy+MpJjHev4pAf9fSRmTJRexEQVIFOL3zLHg5p3
cAcjsswL2kpI0ail4XbtFDf9UBY5TddMNkWNtADlC6nNKIrR2AM9bxIrIy2nItg4
xDn5jdfMZz7QNJ6wmqu8yOuo05rKBVTi5YGeSsXGUKmP1DYJoIJMVme9Y0U3fNlb
fzbLIBL4nS7YIOQAzTgMiR0CVZ1Sp1fxylNxQXe7995sn85Q+Gp54m5q934hHAL6
Fu1dnuKKCPPIco6UavinX3m+ysvWRI6d8doRzKxHgdrsqtNHBJ5xQ1eupcICmIoe
X09zdnC+QwXxvD30hhPoPSgsN/LfBQ==
=8XRn
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--
