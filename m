Return-Path: <linux-spi+bounces-11547-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E074FC87694
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 00:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6BF62353AFA
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 23:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C84721FF4D;
	Tue, 25 Nov 2025 23:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H11cWShK"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4081B21D5B0;
	Tue, 25 Nov 2025 23:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764111652; cv=none; b=YP5xVE2iEDaJ2j2ngnEd4e8+wFClqHpAxPMGlXC7GnanwdbARDj2ZVWz/lWhXuE2BqCUn9xjyExHaP1BhTR4XY+8GxODYyMAnOd1YcZJtXPcDY6NoQICwJdMCLAH0xpzbxgayiE+ucH4SGwU1yZRFkVe3wjePXbY4XookLvjS5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764111652; c=relaxed/simple;
	bh=a2YP86i1UU3uRVIKb5J9I3kWxaXVO0OUNmNfRYPsYpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esAKxItvx4ek6G5upwvd4qSacTItLA7w3wnSlTmzv2fRTDD7+VmlINRu7SNeg9l6Q7RgdeY0v0k+qaRVD2dlSnh+ee59a3bRGa9CjZZ2kC2hWoIdJevqhfzOqn0QJzIkelS+xoWv+w17yvUVBSVqc6SRvnmSyf4hbgzU0pB0S1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H11cWShK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6E4C4CEF1;
	Tue, 25 Nov 2025 23:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764111651;
	bh=a2YP86i1UU3uRVIKb5J9I3kWxaXVO0OUNmNfRYPsYpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H11cWShKldcQD5f7jq8Lhnisbwb+slnK1L6a79AAC4vSRsqvT2//tZxeIjpnVyi5A
	 n5utD0cid4e5RyIhSnr7s6RXBecDyGlXAl7sGde7VHRguoBXu4Dgz0gZubSl9FSplV
	 D5I2qstkpKsD5d/pDAbTIxLlvJujZNUbbLXH4c57XBE9yTU0zPeoldKkT761D2XTcD
	 EiS+52dDpXnyb9py6ddVOvXG3+KO9T6GHkO7Hk1xlT/2yHjAweXueUxJ/Ika3RZnB4
	 6QNU6nG1M9sGMk5CNSaWBGtUcphJimfnyYJgcOqHcO2GS6MwHkIhu+w0MqNkvgkT/b
	 NjT+puvJCLo1Q==
Date: Tue, 25 Nov 2025 23:00:48 +0000
From: Conor Dooley <conor@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/7] spi: microchip-core: Make use of device properties
Message-ID: <20251125-cricket-disregard-581e5b722d91@spud>
References: <20251125201700.1901959-1-andriy.shevchenko@linux.intel.com>
 <20251125201700.1901959-3-andriy.shevchenko@linux.intel.com>
 <8d4c9c21-63ea-4217-9579-c8a3bbb58946@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="C5ComF2UR5R5c29j"
Content-Disposition: inline
In-Reply-To: <8d4c9c21-63ea-4217-9579-c8a3bbb58946@sirena.org.uk>


--C5ComF2UR5R5c29j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 10:42:12PM +0000, Mark Brown wrote:
> On Tue, Nov 25, 2025 at 09:15:32PM +0100, Andy Shevchenko wrote:
> > Convert the module to be property provider agnostic and allow
> > it to be used on non-OF platforms.
>=20
> Are we sure that these properties are tasteful and sensible on an ACPI
> system?

If you're on an ACPI platform, you're probably not using this IP. It's
really old and in need of an update (like what the "hard" version of
it got), we just happened to have some customers that wanted more SPI
controllers on the FPGA. I dunno if using these provider agnostic APIs
is something we should be doing where possible as good practise, but if
it's to make the IP more broadly usable I'd say that that's mostly
wasted effort.

--C5ComF2UR5R5c29j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaSY1IAAKCRB4tDGHoIJi
0kmPAQCpJFTeKBWddEUURd5/db1F6tYTiaHfeI2ZLxh5ba1shgEAzE2B0LjgZFQp
MargT/FpW+araWcOHXoHhvMtqsuBEg0=
=LbVO
-----END PGP SIGNATURE-----

--C5ComF2UR5R5c29j--

