Return-Path: <linux-spi+bounces-11608-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 779E9C8B338
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 18:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 23C2B3587DD
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 17:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3352BE05F;
	Wed, 26 Nov 2025 17:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rK6OBluZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7173E219A81;
	Wed, 26 Nov 2025 17:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764178165; cv=none; b=dF8qpv9w+fvBsrIsrgbZUil+qdjliViU3Iso+IwxqQjPBAC4Cpkb6K5Yc5aSJMJrR5rb9A0f8ew4GTNfxZxXtxZSZm4zd40X0poBkf0Li+XU3XOx3EymD8pg4E4qnHa+ETN/dzgRimdrboZGbwjrcsKDnu2+4FDzhLalmWCsIh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764178165; c=relaxed/simple;
	bh=ATQ2Iho2rIyElw7NaDXkW+e9m6d4q2rHl/MsrNsgls8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzUorWau4pbNOG8vR5Rakk0NvJmNDBda5sCoXZTH/k1CYn1oYxvgDvLmaZqZPr3nCr/BW1V3/m2vPOyMcfsfZ03lVSk7ZTnT0TNCu+Nw5DueRR2JDSFqa79gY6l2i5aC0k6aQqdGixzwZ5b9Or5cY+vodpEF51qCfTx6IyuOIRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rK6OBluZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8CFC4CEF7;
	Wed, 26 Nov 2025 17:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764178164;
	bh=ATQ2Iho2rIyElw7NaDXkW+e9m6d4q2rHl/MsrNsgls8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rK6OBluZF0tEhQZCuJwMWt6+BbHo3opK1B0hL2iRQJu+/GUe/7aWD3G8EXNopgQT0
	 J55Rdcpv+PXX5Hh2dCJX4k1FseD0uVinUBmOkSTaWl/CCBbUm0htTTCS1Ru3tKwkQu
	 hpLA/mztUnf1vfkEW9m7v57DCJ1f8Pu4IqJQ4+dfb5WeP1JeaiVfMZQYxS8tD2n9HL
	 RUDPTMvWgjIqLM+jxt6dpVN+96lqlxZbTg3ERFPD3edfWe/oum10uvGT9WOB7v9fdz
	 XDYccswiiQKG9YucG6BiWhvFNmrphQNUtaR0soaoJLw77Ce5xChzhFocM2TjcDM79w
	 ml6m6RQS42F9g==
Date: Wed, 26 Nov 2025 17:29:20 +0000
From: Conor Dooley <conor@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/7] spi: microchip-core: Make use of device properties
Message-ID: <20251126-stagnate-uncut-6d01fdb2f9bf@spud>
References: <20251125201700.1901959-1-andriy.shevchenko@linux.intel.com>
 <20251125201700.1901959-3-andriy.shevchenko@linux.intel.com>
 <8d4c9c21-63ea-4217-9579-c8a3bbb58946@sirena.org.uk>
 <20251125-cricket-disregard-581e5b722d91@spud>
 <c9248874-7380-47ae-8b1c-33037b7beeaa@sirena.org.uk>
 <aSafnlEbZt-yFzbv@smile.fi.intel.com>
 <72130514-d9a6-4cbe-ae7e-7e23abc95286@sirena.org.uk>
 <aScqY4s5EFgvw_5g@smile.fi.intel.com>
 <31ef355a-9b72-4c78-aac2-b632f5e22c07@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="B+ZBytZo/7P4+IH7"
Content-Disposition: inline
In-Reply-To: <31ef355a-9b72-4c78-aac2-b632f5e22c07@sirena.org.uk>


--B+ZBytZo/7P4+IH7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 05:24:49PM +0000, Mark Brown wrote:
> On Wed, Nov 26, 2025 at 06:27:15PM +0200, Andy Shevchenko wrote:
> > On Wed, Nov 26, 2025 at 12:03:40PM +0000, Mark Brown wrote:
>=20
> > > It'd seem better to make the OF APIs better if
> > > there's some big win there.
>=20
> > I dropped it in v2. Can that be applied instead?
>=20
> The microchip people do usually review stuff.

I mentioned v1 to Prajna this morning, she was definitely intending
providing review, so I'd expect that you hear from her on v2 soon
enough.


--B+ZBytZo/7P4+IH7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaSc47AAKCRB4tDGHoIJi
0m9wAQC/lxdp/7Mkb/xMk1e0kIHTG3iEKGYKxPcvewhjWmogwwEA1d0Bfy4sXdNC
tEqDrKe9Z9+Dt+PtbsUbd5F/isu/mwA=
=oonH
-----END PGP SIGNATURE-----

--B+ZBytZo/7P4+IH7--

