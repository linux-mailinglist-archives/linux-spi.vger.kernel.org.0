Return-Path: <linux-spi+bounces-3380-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E250F90506A
	for <lists+linux-spi@lfdr.de>; Wed, 12 Jun 2024 12:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3A361C20E7A
	for <lists+linux-spi@lfdr.de>; Wed, 12 Jun 2024 10:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B101155307;
	Wed, 12 Jun 2024 10:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjtPeTTE"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507A21C6AE;
	Wed, 12 Jun 2024 10:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718188310; cv=none; b=KbuAzhvUwJTw1/cZpWj6EM4phOxGQGMeXb3N6wOKIrlkd1K2SSciZGLHF7gJIjwHRQZDYpE1GUA9V5LBHycvUGenzsnIPA8zOaUrgNQiqy0LKpkOvpjY467E09P5wjTlashE1/48l5nXNU41K9XnX4zthrMCSSegvR7YSLRMJ4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718188310; c=relaxed/simple;
	bh=IKnzRWbZIW0uMBjg3hPVKLFJtN6YgQCWwnKZsfQ2BtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbwjYF3RplOmyvxgF2U/9ZhsHBjqxDn0Vgf8fY8f4WDNgfVMVrKwXr+PwRk5XuvBrIM3CfpWPe1vrgvmRcgLjf2hERfk5/NsnNCpLLMtdey6j+ynj8RgsfJWB54hYTIr/A/z+E+du4Ep1EOsEHYzluHWYm3sf0k9OvH/HDF5Ios=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjtPeTTE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14164C4AF1A;
	Wed, 12 Jun 2024 10:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718188309;
	bh=IKnzRWbZIW0uMBjg3hPVKLFJtN6YgQCWwnKZsfQ2BtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OjtPeTTE8aznrDm5OVgGIHxoLsNXOnhepszN2pDUXVV88OtMRWHojv2jAz+k3SZbw
	 PkgzY75Hbt3qPZLNkk1uqYXmh0JdUQSb1aNTAeODYhe7j6Nns6+2yb1CaS4m+whVit
	 I6c4U8w9n3P6Zt3fkCZe97sUVYmrnXI2fUFWRp4wgAmarSyCWGo/nmrsZ5WCp1YkB7
	 vNDnRKgWZbJWxnoAje5gTmCHnXVM5Y4MlSiZXGYH17RF9yQSvlYR47+/X0KAqAAIXi
	 Sn5RePqW7rEpIQH9UYst+ndPNDm/28+HHQ8jVJh+vngAp+3kTrIUx8Jw1UrQwqSCkC
	 VUXM3MwYigrFA==
Date: Wed, 12 Jun 2024 11:31:40 +0100
From: Mark Brown <broonie@kernel.org>
To: Witold Sadowski <wsadowski@marvell.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"pthombar@cadence.com" <pthombar@cadence.com>
Subject: Re: [EXTERNAL] Re: [PATCH v8 2/4] spi: cadence: Add Marvell xSPI IP
 overlay changes
Message-ID: <Zml5DD5s7OZopVkU@finisterre.sirena.org.uk>
References: <20240607151831.3858304-1-wsadowski@marvell.com>
 <20240607151831.3858304-3-wsadowski@marvell.com>
 <Zmcj3fZ4DF8r_qf0@finisterre.sirena.org.uk>
 <CO6PR18MB4098E3DEF64621FB147BC345B0C72@CO6PR18MB4098.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xvH9bqAg6EKL9q/g"
Content-Disposition: inline
In-Reply-To: <CO6PR18MB4098E3DEF64621FB147BC345B0C72@CO6PR18MB4098.namprd18.prod.outlook.com>
X-Cookie: Your love life will be... interesting.


--xvH9bqAg6EKL9q/g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 11, 2024 at 09:51:58PM +0000, Witold Sadowski wrote:
> > On Fri, Jun 07, 2024 at 08:18:29AM -0700, Witold Sadowski wrote:

> > > features included are:
> > >     - Clock configuration
> > >     - PHY configuration
> > >     - Interrupt configuration (enabling)

> > This feels like it could usefully be split up so these three bits are
> > separate, and there appear to be other changes buried in here as well.
> > I can't tell what changes either the PHY or interrupt configuration might
> > be referencing.

> That changes are in single commit as, using not all of them will result in
> total xSPI failure. Configuring PHY makes no sense if clock is not enabled.
> But I can try to split that into 3 separate commits.

They won't actually do anything until we detect the Marvell IP.

> > > +static void mrvl_ioreadq(void __iomem  *addr, void *buf, int len) {
> > > +	int i = 0;
> > > +	int rcount = len / 8;
> > > +	int rcount_nf = len % 8;
> > > +	uint64_t tmp;
> > > +	uint64_t *buf64 = (uint64_t *)buf;

> > Any need to cast away from void * indicates a problem.

> I will check that, but code is checking alignment of that pointer.

A cast won't do anything to fix alignment issues.

> > >  	case CDNS_XSPI_SDMA_DIR_READ:
> > > -		ioread8_rep(cdns_xspi->sdmabase,
> > > -			    cdns_xspi->in_buffer, sdma_size);
> > > +		cdns_xspi_sdma_memread(cdns_xspi, sdma_size);
> > >  		break;

> > It's feeling like it might make sense to have an ops structure rather than
> > sprinkling checks for the Marvell overlay everywhere.

> Won't it cause big code duplication? There are some differences, but whole
> Part of SPI stig mode configuration is the same.

No more than having a bunch of functions which are called a single time
with checks in them will?

--xvH9bqAg6EKL9q/g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZpeQsACgkQJNaLcl1U
h9ADNAf/WTR0H0Qn2OWdd/BymBjuQCwA8E904iCChNKnS4OQO/0+hIrOvaP17XKx
CC+pD4RcnGfxAo7ZaSt+e/4x+FSwvCrvehnKyf/SyDsdGM9L7xiSA1DkaTUB17nn
2i4VK0aHKc1Dsl6/FBpX557xiWLY0/2Cvp7pSFvrKkserLjBXZQOK/bAKe+91DTg
W1Khh+gxUR2WExITICPU9oK2mPMQLICmv2OESHgG5KORduKk89GtcS0UNHngP+Zt
Rk1R8BwlDkdx9iGZSghCSZxMF+0Uce2z7xDL9iJiR6lCXvFKk2i2jTbX9vxy8v5/
D7z6idrOqBxEOijFsYLWngShvjw+NQ==
=oof7
-----END PGP SIGNATURE-----

--xvH9bqAg6EKL9q/g--

