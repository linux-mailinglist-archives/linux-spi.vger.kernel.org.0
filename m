Return-Path: <linux-spi+bounces-8581-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D09ADAFCB
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 14:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F836188454B
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 12:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732D22E424A;
	Mon, 16 Jun 2025 12:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+eWInOZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387362E426E;
	Mon, 16 Jun 2025 12:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750075567; cv=none; b=fl6X4xrCgUO0DmM4MTQfAbvluXgxXgMMKy5Jjeo0nd+oubg6IZVCi0EMfo2xpOVZ+Hr3d0eZrnr+UBTCMLat/EAExZ4zE6HM2rYkwS4agg3vw/Qao9K+PHDGbXV4Dwlq9Qm+VhbVycSFDN8EDey55KWlfCQfE/Nbj9w1bfDhBQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750075567; c=relaxed/simple;
	bh=81KHwSljmnJTPeKJj2v4TDvROMlMHB1LsZuqXD9yw+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvui4VhHok32iLQsZT1xI0pO1poLB0LPH8bED//7gZ/qksCN3tyZJxw/Vu4755D43bz/mWTX9M5eLTD5xBteVX0r9XPeUsDUf1w9H9zYD26W8NLG6OEtvHFFZ1AkK/89pUDsyf9xvU7oVrsy4ERAmD3TzS+AvmMfLogyMmRh9OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+eWInOZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA7BC4CEEF;
	Mon, 16 Jun 2025 12:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750075566;
	bh=81KHwSljmnJTPeKJj2v4TDvROMlMHB1LsZuqXD9yw+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S+eWInOZdvCl4lZ2CWY38xdR5eYCTJcNKTAnyS3GFOAPfHu5KcLyPfAfFt9E1Z/iM
	 zL4kNwxq5CGlYbQgJTngT7eFRMmCqjUbq98xK84hR4QhycXQy9+UMrB4xEtQ1fOGGI
	 FTR70AG1J76Oa3yS6t4+6L8Kt2fZKTE4aiwUFewv8MyZD44moVINTOJWiUQSlm5e6e
	 eSJhjEtTifLRpcoNETlrkJeC630FnG7oCX1lHVbzK7J3jwqmc+w94/AHBYyWdiXmYq
	 uS34HK6gnBciniIiuXgSGXZwZEuuvmxj7kKrkiXnHZ/pIr7aOJ9Hl9xnM1q4Zhbfu1
	 FcxKTAZY428Dg==
Date: Mon, 16 Jun 2025 13:06:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: James Clark <james.clark@linaro.org>, olteanv@gmail.com,
	oe-kbuild-all@lists.linux.dev, arnd@arndb.de,
	larisa.grigore@nxp.com, Frank.li@nxp.com, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Subject: Re: [PATCH] dma-mapping: Stub out dma_{alloc,free,map}_pages() API
Message-ID: <5f1ca0ac-b66c-4b92-8f69-027c2468b117@sirena.org.uk>
References: <202506160036.t9VDxF6p-lkp@intel.com>
 <20250616111749.316413-1-james.clark@linaro.org>
 <20250616112927.GA21689@lst.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yQrkc45Aa466PEFE"
Content-Disposition: inline
In-Reply-To: <20250616112927.GA21689@lst.de>
X-Cookie: Keep out of the sunlight.


--yQrkc45Aa466PEFE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 16, 2025 at 01:29:27PM +0200, Christoph Hellwig wrote:
> On Mon, Jun 16, 2025 at 12:17:49PM +0100, James Clark wrote:

> > The implementations are in mapping.c which requires HAS_DMA so stub them
> > out if not present. This is required for some drivers to pass randconfig
> > builds.

> No.  Just add the proper IS_ENABLED checks in the callers.  While these
> kinds of stubs used to be popular they are really nasty in that the
> calls unexpectedly just fail without the right depends.

The issue with HAS_DMA is that essentially all platforms have and rely
on DMA.  This ends up just being painful noise from the buildbots when
they do randconfigs rather than something useful.

--yQrkc45Aa466PEFE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhQCKcACgkQJNaLcl1U
h9D0eQf/ePoOXoqCP5feLeTghxn9bOAHGZSj2dGtDODfvqyZChR5qZwlk59nXu4y
HSyVPkGL7MobX4QBk7cBPljYfeJ6Lpk3hiuEKtnZY5WvFjy2FvZ21tA2fTwIxpNL
kKW8oPUtgyOLBKcWdDz2B4NN9aXYjpddRfAOWAKZPtydxp/baZEg8y/N4IDsi+Q/
P2L0LeP+zoaAW0IKPYSXWi4ORETJv3xB85enYrY/wqvF3LCLWdJcuWUMSwDqUfdW
Mc2+X9wZ3XR2coA27TcOcM0ac37VQgwKR8rSt9a5o8UED8Dk5CUwSQoOhFRpgoLn
66xG5r35MfMl2roIb0Uc8iasLxamDw==
=OEz+
-----END PGP SIGNATURE-----

--yQrkc45Aa466PEFE--

