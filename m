Return-Path: <linux-spi+bounces-8585-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 706DAADB110
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 15:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E50DE188986E
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 13:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D19292B50;
	Mon, 16 Jun 2025 13:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOL6S8Ou"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707C5285CB8;
	Mon, 16 Jun 2025 13:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750079128; cv=none; b=mRMeqe/nEqaYKhkJtvCV75CiCYY/v84hz5uCIskPOMwwzmglmKoJ+xcHZgG6L9W3FQ9MxKDFRV5DLOGCOnkEQl9XaRS+BFuUtfX0ECP6TsqJqKMOfqPJ3K1FIktpGMQjJceeSwKb7iWKLBfcNXj1noMXwlyQonB8OJ3DNqxJ+E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750079128; c=relaxed/simple;
	bh=hlXoLqIubEHuZDtkWfEeyo3ISIxZabXewxqNrV7WhWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPlXOCyUE2EJ8Q7f3ZqldiebZ/8eCQrIyBduC1J8HzPgs5KSnL6zQpr/LinqL4JGtX6n9sYKeq5dCYJZSaewGUxMffMqkxtXoY1sm3e5C4/TY+xEKqORE1pDEHikqZU+4cJDqkzyhuudJaA+OTow9GLbQ5w4dO9/G9v4VEITo1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOL6S8Ou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC56C4CEEA;
	Mon, 16 Jun 2025 13:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750079128;
	bh=hlXoLqIubEHuZDtkWfEeyo3ISIxZabXewxqNrV7WhWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fOL6S8OunfMzUd2zYLxAwgeta518GX7IkolJTcswwYEOb5AzVx3O5OYAn5YtG30kU
	 1mOov0QUE5f+L5zsOnevBC9SItzNoPQb3xiVJiTR/mtroR9RQNMl1PHJ5VlWEBpKai
	 YZcdcgKPn2KzwcO3hO9Ur/5fH4oXzKtwHO0oLukEeSvZbSyh2/w4Pt3WiLEol2Ff85
	 2e4qBQ0MLZgvNTHFCxxHv3x01gKU2M6N7lPWredcXNtS6k4v2pOZC+AahMeuiMQP7L
	 uxD/GYrdhXdxv4Oa2NQfPE8a1lrSse68kf3DJpReOEuqzW3HRCBPwnPJQ7uc7Vh+Kg
	 sD4/84xmnRndA==
Date: Mon, 16 Jun 2025 14:05:22 +0100
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
Message-ID: <e4aa4d6d-0e84-42a8-bf63-f8d132619432@sirena.org.uk>
References: <202506160036.t9VDxF6p-lkp@intel.com>
 <20250616111749.316413-1-james.clark@linaro.org>
 <20250616112927.GA21689@lst.de>
 <5f1ca0ac-b66c-4b92-8f69-027c2468b117@sirena.org.uk>
 <20250616120832.GA24959@lst.de>
 <2d62254e-5cbe-4174-95d8-e80cae4f4543@sirena.org.uk>
 <20250616121444.GA25443@lst.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HzW9hrF3tGvJKQdx"
Content-Disposition: inline
In-Reply-To: <20250616121444.GA25443@lst.de>
X-Cookie: Keep out of the sunlight.


--HzW9hrF3tGvJKQdx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 16, 2025 at 02:14:44PM +0200, Christoph Hellwig wrote:
> On Mon, Jun 16, 2025 at 01:11:49PM +0100, Mark Brown wrote:
> > already tied to a platform that needs DMA needing to add the dependency
> > which nobody is going to notice without doing build testing for
> > randconfigs or similar non-useful configs - it's not a productive use of
> > time.

> Stop your unproductive whining and just fix your dependencies.

That is not a constructive way to talk to people, especially not when
misdirected.

--HzW9hrF3tGvJKQdx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhQFpIACgkQJNaLcl1U
h9CF1gf/aUf6tghdUHlSErF6ZxtSN/tICNpSXbRPkh89hWQnclV5NEy1MYNlIBrs
W8uJO5scYd79vCrwfH6Fl74v8nlCBCsVw9zfWl+aOG4SeofRFdOfzZeVVN/tk7bJ
VhnXnqorAEMTVvBHf1ByLhstPFbON0o0XcWXSU/kIqN5NAUjVOOOVC7dLoBZo2ps
kAL8jV4pC11dD47Zwz89Ke/7rUqlT0bTSKwb0uDgCoEbWwFq4JHU+7Ju/z2lPd/S
lBZQryv/5QuRzE67BlUjzTh6VwOSci9yJHocjJGjFeFUdtJjPgln1wOjOxNEbIV3
G5chNOTNrNth/XOvrg0ARyC63M58AA==
=GOim
-----END PGP SIGNATURE-----

--HzW9hrF3tGvJKQdx--

