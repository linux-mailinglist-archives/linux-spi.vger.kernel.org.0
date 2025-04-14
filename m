Return-Path: <linux-spi+bounces-7574-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C2EA88562
	for <lists+linux-spi@lfdr.de>; Mon, 14 Apr 2025 16:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 587871904735
	for <lists+linux-spi@lfdr.de>; Mon, 14 Apr 2025 14:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788BD2749F0;
	Mon, 14 Apr 2025 14:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsE1fqnY"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A37E19539F;
	Mon, 14 Apr 2025 14:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744639833; cv=none; b=DRNitMs4b+/KJ0CrMIiF/qPRf0tCRWGpmSq3MacLSrezkqOU6k96pcySSEbGVCeAKVa0Y6x0XvR/WCt/R4nVMG7Ox4Jp836PSEmtD0YbNubr3ftLD53nCdIfxf95AHpTW6chZTve/+D0faVmdcyr2h4BYRxyY4U3QXMjjgMoivo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744639833; c=relaxed/simple;
	bh=UAdCAcDDcbUAFaQhhiPijezFVFrbVIScJZbGC9BYzaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BygdRO6AmEo4Nl+RhRXCD/kB/b6H0/xhP7iXX+o6/+uOSVIsetrg7QyFZxr/rJDvBP1DwXwPVnNhDkXsrrFHFhFKMnobMOtpF3LlxoR+m1x8iu/uAvIUkEIf8U4jyY4A3TMsVMQ8BVeg5kFyfph+mJgx2zcU2nEan5e7c0IG1MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RsE1fqnY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEAEAC4CEE2;
	Mon, 14 Apr 2025 14:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744639833;
	bh=UAdCAcDDcbUAFaQhhiPijezFVFrbVIScJZbGC9BYzaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RsE1fqnYQ0D/umEGmNaSWaZcYYZlpe8oJ4M9bNmQUXNC47OUyTTQ7DB18P+L6ECfU
	 BUOknsLyEtUAUxoXGJ8P/TLemQCIiv7oKKaL7iPzY3CrBKbeA/VaAUOTSQOnLviFpH
	 Z/1mOoDTt3raVyS/XYhqxZBV5YbWFQpPnBReB/ykzLWof49KucUxQCJ4tD5/dfiWkI
	 Wvqm1qlxJwJnHY5kRdOgzC9m2nEm6ThmVtaNH7tkkIPxgWfFZ59yHNhwe8jiGYfbmY
	 jrrMTJPPkCNVGmSDXakfvukg/6IL18z5IwrDVgDp6vHgvx+YVoswa+iJJC1RfYw/91
	 SVNFl3op8CVzw==
Date: Mon, 14 Apr 2025 15:10:27 +0100
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Varshini Rajendran <varshini.rajendran@microchip.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alexander Dahl <ada@thorsis.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Pavel Machek <pavel@kernel.org>
Subject: Re: [PATCH v6 1/2] pm: runtime: Add new devm functions
Message-ID: <58e37046-f9fd-41cf-a5f5-f7cbb1eb97ab@sirena.org.uk>
References: <20250327195928.680771-2-csokas.bence@prolan.hu>
 <20250327195928.680771-3-csokas.bence@prolan.hu>
 <CAJZ5v0jmuzvo-xzGBDhGVBbY7svbrqEdi-SeJrx5BG=qtN6ZiQ@mail.gmail.com>
 <832eb5e3-7e2d-4ed2-8571-eca9fe129013@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nb4I0smoCForxcgo"
Content-Disposition: inline
In-Reply-To: <832eb5e3-7e2d-4ed2-8571-eca9fe129013@prolan.hu>
X-Cookie: Good day to avoid cops.  Crawl to work.


--nb4I0smoCForxcgo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 03:56:47PM +0200, Cs=F3k=E1s Bence wrote:
> On 2025. 04. 09. 19:43, Rafael J. Wysocki wrote:

> > I can apply this one alone if you want me to do that, but I could also
> > apply the other patch in the series if it got an ACK from the driver
> > maintainer.

> I think you can apply it and then Mark can apply the SPI part to his tree.
> @broonie what do you think?

Please don't add random characters to my name.

I'd need a tag since the driver change isn't going to build without the
new API.

--nb4I0smoCForxcgo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmf9F1IACgkQJNaLcl1U
h9CVyQf+OoBLAj4WQr+H7BEg9lObLdNL4KRPrtCilkLER2n2jv1LKxR5AOVaM5s0
a5jKczyVXb543ZHBu2u2Mr3F2ofULa7INlrO88vcmVjI0QQgaKweqTO0Z6bL8atX
D0gRFG0/QKfQ/EscdGHTVDza0RH5LNDwzz7Jw3guBzw5lu1d7raDhXCmorKVzMAc
H1yoyUGhmLGv71cpmm3Y4vO3hvQZP4O50+8f83Ntf7A/TpByOrxd8RI6wtFndpJU
FJalHnIvuMSv1djWNklF0r2E41AheaCGCxGO3SlLffqjXbGh98QS7a3mG8yjMOCA
TR41WG7xTs+F7TjDT4E1tYyh/vdRjg==
=mnIx
-----END PGP SIGNATURE-----

--nb4I0smoCForxcgo--

