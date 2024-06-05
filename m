Return-Path: <linux-spi+bounces-3270-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D5D8FD857
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jun 2024 23:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DD641F210F2
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jun 2024 21:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074CD15F41D;
	Wed,  5 Jun 2024 21:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fv6rVAAq"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D436B15F418;
	Wed,  5 Jun 2024 21:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717622537; cv=none; b=kFxJisMD5Mwzy3Oqw8MOj3UTafN3f12nwlDxKaWIm4yyqMn9FQgwP1up5R4jRLQTb8677/Av+qJWX0HCmxmrF7MxKSAZkKEPXuUQAkRG2GhgCQJPFsrrLdC3kKRCZ9L0qTPKVLT6IEiANboH464p8yQSmZ8nHjxB/Uuw7ILob8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717622537; c=relaxed/simple;
	bh=3GMJykvY6Qbl/kX1fJnvOrtZkr9wNdc+KmSjvJ/eZw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uu7rstHMADFmTiEAx+ZQfg+uujt3zw1rSyfXUMc4OwghUGeJ7mqq7qzdSdxeWSOzmDmkezMCH59k1UKHttB8a0WPjL/u+I/e20WGR384LMHEL96uJIxLdk4A+HHjIZ4OzUdSzC3wa9mVKBN8Y0xKBfJlTGHxT6OZsuzJ7NaeY+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fv6rVAAq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88676C32782;
	Wed,  5 Jun 2024 21:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717622537;
	bh=3GMJykvY6Qbl/kX1fJnvOrtZkr9wNdc+KmSjvJ/eZw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fv6rVAAq5S7CCo3Bq5FuNG73jj9DTBx6LKjjdlM7biZIpZe6rS1PSaD7wYBXXNRor
	 6edyN2zsSegbaAk+d2V9IBaLTxmfJT1zyBuv9mUJsS0uW5oM6NnIAdrYOBx/7MlHkm
	 iS+envfS5ctNxQW20p/YH5F/efHJBQbUUY57XsgfqBY4We0SuC6TPWH4Vx1pbmDkZG
	 56PALS/o0WzRc6YPd0q+Y1X4P5diki2uJk+rWRututSOeii9FAz2JnVDBwPcpwPfQ4
	 TvC2R42Wk6BnbAGlTSz2G94omYGJ/BkZuBLpNAQEKaa+IlkrHN2pqn2PMVWJeAtazn
	 GUsjLoOgWjVNA==
Date: Wed, 5 Jun 2024 22:22:13 +0100
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] spi: Replace custom code with
 device_match_acpi_handle()
Message-ID: <251030bd-f0ef-4417-962a-b7d9abd768e5@sirena.org.uk>
References: <20240510204952.2582093-1-andriy.shevchenko@linux.intel.com>
 <ZmDT03c_rcPfzMUh@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JEUZqhSYDnvybeu1"
Content-Disposition: inline
In-Reply-To: <ZmDT03c_rcPfzMUh@smile.fi.intel.com>
X-Cookie: Simulated picture.


--JEUZqhSYDnvybeu1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2024 at 12:08:35AM +0300, Andy Shevchenko wrote:
> On Fri, May 10, 2024 at 11:49:52PM +0300, Andy Shevchenko wrote:
> > Since driver core provides a generic device_match_acpi_handle()
> > we may replace the custom code with it.

> Hmm... Other more recent patches went through, is this lost in cracks?

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--JEUZqhSYDnvybeu1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZg1wUACgkQJNaLcl1U
h9Cg/Af/egpG8KyVTDtZVsKIWq3GIf2e8ltsSBpgZLI+xTev6aCV1XQuc9/uXFHk
+m1mlBxbWhUrSfV7x4a75UUyQupxWtp9CST99KQxW3CzMm4vuCthcE8qCu50/qr0
voMZf37FWdh+9NCiFYfjpWu/46hiJYq9j+MKL4xv6YCg6bNCdwMs/UrXm7wgUsfw
U1MJR/UCuNBJYYN43DfgO7jdCjSstifCyE51ID1OKrkUW36y8/w7hwA8YXZ2PB96
d24zRuoEu1AqF8SGiRFxzsl1ygiubbosFYsHJtNm9GxNFPn9qV1NYnwvVgdHATrD
xQ/JGIAb+StOeu7tGKE/GYZboIq8kg==
=sFsr
-----END PGP SIGNATURE-----

--JEUZqhSYDnvybeu1--

