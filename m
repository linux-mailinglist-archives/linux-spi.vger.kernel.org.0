Return-Path: <linux-spi+bounces-8583-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B75B8ADAFED
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 14:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D41A6188C22D
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 12:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BD22E4264;
	Mon, 16 Jun 2025 12:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1GcQ3wi"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822082E425E;
	Mon, 16 Jun 2025 12:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750075914; cv=none; b=t7zQDwb5odldCqNrQhDe0ObHNQwUVURw0+3+r2wRlrQk6DLV/w1jrBP8FbBgJ2A5oX6teLale6jS3+c9WaGkDjZOu5l3JGLKCuhBzEx2u8XdO+UhIyGy7mNmjOmEmFHN1WWuKn+eQqnIxnmUooUPR/3p09k58Vq4zAOFhiZzjA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750075914; c=relaxed/simple;
	bh=NulkWwgHGXOnq08qhXHY/HmPzuozRGy8aUpDqj/mkBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tg2TLxS9PEOvmVr8+I1uTfcXwQ4AUqs/SbzKJtO2IcpkFQ2Ir9gC9UhegsSy8pS2Rneq9+6n9Iw2JI3zBCURxSi2m7MUj4XCfalqjqsLO/dPOoTQ5ckF5rpey8cqPmI8TzXcmbeb7AUnhP0XE+TxmsW7zHFOieK5yozErGVrgYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1GcQ3wi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70A5C4CEEA;
	Mon, 16 Jun 2025 12:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750075914;
	bh=NulkWwgHGXOnq08qhXHY/HmPzuozRGy8aUpDqj/mkBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V1GcQ3wigDUV/HWekPms4xjO98nW7aPTGXwZDuTOWQVJzh4peLErKicKnRSWQmvST
	 R0W56WKsIvJVw+kXEJceLf3z1bH3ATKv71+0SHllDroEOo0EUSrBknkyBtt1eU5HLN
	 qd4GzCkWfMmM6ox6h/vPUw+Y8N99kct5jMJtmhR7olmAWyibz9AoR4+AakPq6Lmloo
	 cxfhUhbtN0AxrTwnHT/qZWoBU/aMOPBYTkzGUfO+FShOwKZoz3VBf0DJtaEd+WxP14
	 4+P6o+jdUIEL5u/3SJ2yKGiGJ7OyrXIMVdf3h5TKzxK7aRuzRde1RRZqT+eXcEchGD
	 kvcIx7tI//e0w==
Date: Mon, 16 Jun 2025 13:11:49 +0100
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
Message-ID: <2d62254e-5cbe-4174-95d8-e80cae4f4543@sirena.org.uk>
References: <202506160036.t9VDxF6p-lkp@intel.com>
 <20250616111749.316413-1-james.clark@linaro.org>
 <20250616112927.GA21689@lst.de>
 <5f1ca0ac-b66c-4b92-8f69-027c2468b117@sirena.org.uk>
 <20250616120832.GA24959@lst.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iB2AcStVmZ9w9Wlz"
Content-Disposition: inline
In-Reply-To: <20250616120832.GA24959@lst.de>
X-Cookie: Keep out of the sunlight.


--iB2AcStVmZ9w9Wlz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 16, 2025 at 02:08:32PM +0200, Christoph Hellwig wrote:
> On Mon, Jun 16, 2025 at 01:06:00PM +0100, Mark Brown wrote:

> > The issue with HAS_DMA is that essentially all platforms have and rely
> > on DMA.  This ends up just being painful noise from the buildbots when
> > they do randconfigs rather than something useful.

> In most case the driver really does depend on DMA to work, so just
> depend on HAS_DMA.  If it can work without DMA, you can use IS_ENABLED.

Right, so you just end up with essentially every driver that isn't
already tied to a platform that needs DMA needing to add the dependency
which nobody is going to notice without doing build testing for
randconfigs or similar non-useful configs - it's not a productive use of
time.

--iB2AcStVmZ9w9Wlz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhQCgQACgkQJNaLcl1U
h9CXZAf/UO97erw4yiPfUqWXgUUm5yfanPbD5lTwMFBlO3NTvWCTqhkoAKq6xngK
4Yt65qQKcXnOYIjwzmE+d8jk/ztZzicvvb408TUOivC1gvgWCjaDNaL9WrGxxgGw
nrCveVKvZ9VK/hFGMl3iqBpLaUErhIgQMmsvBH3If0s5oL6bPb2d9ghjFK/Z6lJa
TmFneXpZKgYLdX61Xlyy49ITcfNXnoK2x9tIkncSTePn4+xTMVqwCm6LR6lAkMzd
bT0opZxa2KA46Z1DYFmBMlLWIXuYHsRj6cPpM6b0XdIq09zYYpBkODSCor2AgG3S
1aowQM2iaWB2TTUiMPUofR7aKCFWoA==
=B5+p
-----END PGP SIGNATURE-----

--iB2AcStVmZ9w9Wlz--

