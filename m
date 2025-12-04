Return-Path: <linux-spi+bounces-11762-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F601CA3E73
	for <lists+linux-spi@lfdr.de>; Thu, 04 Dec 2025 14:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8245302F692
	for <lists+linux-spi@lfdr.de>; Thu,  4 Dec 2025 13:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108DB3451CA;
	Thu,  4 Dec 2025 13:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouzZrBsc"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7253431F8;
	Thu,  4 Dec 2025 13:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764855888; cv=none; b=KS6mrWvwI7i5XOxdVPeZhZPUEzyWyYTejfJ5RV9uH07P67h4Li93OrcfuYDnrfr860UHqlhxFYZOYNz8gZmlzV5toowUHI+IhzcdDR4MbHRntDEwhZYnH9NPZb6FyehUcIGVYwIQvqWj2aPjMVBaKkTmw5/tdzZ8O0sy8vBxg6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764855888; c=relaxed/simple;
	bh=tbqLmUwodPJEVURPT1ocoZ5j3L68dUBXFjTtWeWA6eM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kq1bnuyM5y8tBsI8td5wIVl2iUkvNBzw9u0zvnqCM5K+6JTVhTudzqVPhCRrc55LiYw/BUvy78YhtuSj59UdXAsSG5RKYes/ANpXeng09KWhaLJVDeJOZtAhOPncLvQTm4iK7dd1gI3hcuGUVBqXD4qJPHBVm/OxLKFIfXXIyNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouzZrBsc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B662C4CEFB;
	Thu,  4 Dec 2025 13:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764855888;
	bh=tbqLmUwodPJEVURPT1ocoZ5j3L68dUBXFjTtWeWA6eM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ouzZrBsc08OLp+PFWnoBGw2xrsv5ma4Ug1kVNUqiEt4f74SHj1Q2LyJobR0wrhIzc
	 +jem3Ks8X5VcKg8hsal8fuALS37jGj+ls82TZCU1U7KD7cYM3I2r52lQ9L26xtjXNS
	 Ae+HHDsXFig85vh0h6WChSlQtJrCczl+fzwX1lKdT7NeEGfnar2gsOGkItWfYvyNOV
	 X2bAPHdCAVdTZsxPfY9LR7H1PDyXpqQZtHG0XOVFX2bTHAN1JfchR6vo4yg7FVYEea
	 VPkB3/F/DlsTwS0/xac9K6TuR82V+aTlKihLgD1F/zNh68g8FwcysIiXcO9u3Iu0DD
	 lPaN4OYRpv4kw==
Date: Thu, 4 Dec 2025 13:44:44 +0000
From: Mark Brown <broonie@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, Anurag Dutta <a-dutta@ti.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] spi: cadence-quadspi: Fix clock enable underflows due to
 runtime PM
Message-ID: <8c6b5d14-ffc9-41e6-94ff-431f381a39cd@sirena.org.uk>
References: <20251202-spi-cadence-qspi-runtime-pm-imbalance-v1-1-aee8c7fa21f2@kernel.org>
 <aTFQv157O-wJjVrZ@gaggiata.pivistrello.it>
 <555e9f6b-b8b6-4cc5-900b-63aaff8b4e6c@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="igA9GEpDYmAcrB0O"
Content-Disposition: inline
In-Reply-To: <555e9f6b-b8b6-4cc5-900b-63aaff8b4e6c@sirena.org.uk>
X-Cookie: volcano, n.:


--igA9GEpDYmAcrB0O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 04, 2025 at 01:28:05PM +0000, Mark Brown wrote:

> issue and test directly rather than working blind, I've also noticed
> that we're getting

> [   15.430306] cadence-qspi 13010000.spi: Runtime PM usage count underflow!

> even in normal operation (on that system anyway) so the runtime PM
> handling is definitely unhappy.

Ah, I applied a patch the other day fixing that one.

--igA9GEpDYmAcrB0O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkxkEsACgkQJNaLcl1U
h9DPsgf/Z1MsE7NuwgfNjzwYJ2Bpwd9QJ00FtVhPX4LUUopdopsQFx0oGJD6xweM
SP1SZ3fSe6gp1bhIgHsaJFdRAxLiV16fLNHsO0MmVoroMkRXEAim1WLLJwHzo68C
oQp/79o4+FQVDyvOUiM1AUxelgqrCL1vLylbOOb3V4p+7O9wzo81Ha5OWRbPfKPN
WCkpvdYzdVEdgSXlx3RXplQXUMQO9lq8kbnIT+02qqGPaOjqV5+/kr4NaxUer1dz
B6rcOzxrEMpx1/ahgFtwslKjQojdlxycXvd54j+yb1MkXC1mdrYLsd2/2uanydWs
DERnvsMOiWKVat0L8On/bXgo/4ZoXA==
=s5qt
-----END PGP SIGNATURE-----

--igA9GEpDYmAcrB0O--

