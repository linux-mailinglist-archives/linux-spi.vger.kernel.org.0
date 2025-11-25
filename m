Return-Path: <linux-spi+bounces-11548-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D8270C87739
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 00:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 852E9353C3B
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 23:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308932F0665;
	Tue, 25 Nov 2025 23:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JljpBZr6"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0952B2EFDB4;
	Tue, 25 Nov 2025 23:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764112767; cv=none; b=SkcqSKP1YW3IlCTg47kAIQgnTzs1Jrii2kRwSYj0gULkd+/BKK4hWib5LsjXHwnF/Ez+REz4rcSLfXpKu0rtC+7xY2fyd4e8m+VSjg5bg+CTQOFUflB/wQfGxUrUklD1+reLC32Q9zZd0gQD/lcuILM+8/kYFWvI1QskFnn4+SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764112767; c=relaxed/simple;
	bh=OxfYkYNljymlaCuWOHJ7AAZBmRxpnN2cpV5PGV6DTdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFlNQ9hi+bUI+dha9G/QRc8je0cyaScpEHcVcuLbb2UdcRcThAaq0ukjOs/U2xSlZACWmPuAWiHnITu82ovMHUjReINqQ0bJ+ghxXb10cktcmhSzKfTw7B+cDtrmc8wKh73RkGH1eZ0XnPhYDtebt4EdrHomlkOSU5sKIDa7lsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JljpBZr6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A36C4CEF1;
	Tue, 25 Nov 2025 23:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764112766;
	bh=OxfYkYNljymlaCuWOHJ7AAZBmRxpnN2cpV5PGV6DTdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JljpBZr6l3wvOdOkB8hRJ3f51JFc7o/tuNh+jueYi8Giz5BUvSIipruySQXdpOEUf
	 amDZ4fZdIQSZRwzNTrtJpSwYDvBQ/ehaCvDG7LTYepJah8DjUTlmeazrSur6N1SyWU
	 8gFE5X7LxSpBfKWQtF4mIiQj8THTtt2KWGwrnEl2EdEI4Tyv00UiOv/3v/QL3Sqsv9
	 3cw4hPWCblhGBDPfVC7HDR5c0Vl87xvmsOn61YLZlDpF+uiv9/ERnf5qNA6+v34i9K
	 EOQXV/I/1VbjQPnqeJrt5gQHXT9l7izudSza51e6TuiWR5Kh5ktx/0Rw1P337cb0or
	 bpkLwu0xe+raA==
Date: Tue, 25 Nov 2025 23:19:22 +0000
From: Mark Brown <broonie@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/7] spi: microchip-core: Make use of device properties
Message-ID: <c9248874-7380-47ae-8b1c-33037b7beeaa@sirena.org.uk>
References: <20251125201700.1901959-1-andriy.shevchenko@linux.intel.com>
 <20251125201700.1901959-3-andriy.shevchenko@linux.intel.com>
 <8d4c9c21-63ea-4217-9579-c8a3bbb58946@sirena.org.uk>
 <20251125-cricket-disregard-581e5b722d91@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UKBx3tSI4BrkSWLT"
Content-Disposition: inline
In-Reply-To: <20251125-cricket-disregard-581e5b722d91@spud>
X-Cookie: Too ripped.  Gotta go.


--UKBx3tSI4BrkSWLT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 25, 2025 at 11:00:48PM +0000, Conor Dooley wrote:
> On Tue, Nov 25, 2025 at 10:42:12PM +0000, Mark Brown wrote:
> > On Tue, Nov 25, 2025 at 09:15:32PM +0100, Andy Shevchenko wrote:
> > > Convert the module to be property provider agnostic and allow
> > > it to be used on non-OF platforms.

> > Are we sure that these properties are tasteful and sensible on an ACPI
> > system?

> If you're on an ACPI platform, you're probably not using this IP. It's
> really old and in need of an update (like what the "hard" version of
> it got), we just happened to have some customers that wanted more SPI
> controllers on the FPGA. I dunno if using these provider agnostic APIs
> is something we should be doing where possible as good practise, but if
> it's to make the IP more broadly usable I'd say that that's mostly
> wasted effort.

I really don't think it's a good idea to just do it as a thoughtless
default given that there are cases where we actively want a different
interface on ACPI or don't want to see a device used at all.

--UKBx3tSI4BrkSWLT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkmOXoACgkQJNaLcl1U
h9DcWQf9GJKbTN+cDIla9oIUA97cK5ODSAwQFe0sl9cBvQBGS275EF7ctwuOt+X9
eX1Ab0kyl0ftN36qJ945bsSkSGfx9n3wkaB3/GXJMozrTLXeg4uiwXWHzV0CM/Zf
ohVTaEpMAtiAm/HZotrE3PDSk3vfTVtCVxT0PIt36WyGanqlKnShSazQaTtMKUPn
wBcRZtuaJw3ErI5Eam8MwWsf8PJwBxBxhhUrBRCQ8ayH4wFkVZdrWJjMzqV3wNZS
dYSvsSCEMLeZHS/DDOxwoFk9R8o1rAOXZ3Jycq0uNlrFdhQgp9uoPCVpoL61WD5O
EABR1elnY0ReKWn2On6yq3IZoyPXZw==
=Hi8K
-----END PGP SIGNATURE-----

--UKBx3tSI4BrkSWLT--

