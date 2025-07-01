Return-Path: <linux-spi+bounces-8949-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9953AEFDF0
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 17:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8810C1883848
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 15:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7AA27817F;
	Tue,  1 Jul 2025 15:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXj0SgLS"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF031D618E;
	Tue,  1 Jul 2025 15:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751383016; cv=none; b=E1EzkAIl1yKomWqacUfqmTjabPuRVNyXUsN42gD/duuYUMsPEZIBqL3AS/0Yk+QtBHmGr/2dGC1B5CqvziegNIz2BPZmd/CRzXu8L8pj6p8uKrsk8OmC+lpqGHbLCHpsamKUvOo3T9XHMU4AuC/8FWulbNtt/HgJEYx7pjNs1d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751383016; c=relaxed/simple;
	bh=MAes9zTzD3fZkamDg/e+Ks2e1KbzfjfRLfGGiOW+rkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1q0RVjb/fBbR5EgoRnFcnteF4neE4lFCLOe02e+JVijosDm3PLmV8X3KI6VVc+nrukypDkBcqNx1Chq8hkw0KnpjoZM9xL+dnH8+DeIyKmdU+egQwt8oJbkIzf2186m8h6Gw41irYC/F9h/Gm9Ou2HkcK8bnK5p6oOTsOVfn3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXj0SgLS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37FDEC4CEEB;
	Tue,  1 Jul 2025 15:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751383015;
	bh=MAes9zTzD3fZkamDg/e+Ks2e1KbzfjfRLfGGiOW+rkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZXj0SgLSCMq40IvgEppwfYQODgiXq4YoohseeQf/ncQsJB8PiQdn7rNXim6YTVke6
	 AsJhYW2cgpquZ37KFuSb84GwidLs0wGWjZpKVbT4nEs1rgwMJXRY48jDyBelhS3JC7
	 NLNIxVgUvWHKeqzOltM6tgMhripNWw2ca30q/Gvh4DXyjBHWRHCWxIaAp8MVChbC8h
	 3sf9UAzkDviXRWegPq9MxD3pfOL8VopZJZ9mfJ4vX7YjeMxl97fqzAbRZ3VHTsY0MD
	 0ttWbUxl/ovqXbOXJ99dnUZzsNcIDq2n28lImXycAj/z7M221BWvwTeiqQ/vm1fb86
	 qoLR2AOxH1+kw==
Date: Tue, 1 Jul 2025 16:16:50 +0100
From: Mark Brown <broonie@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: James Clark <james.clark@linaro.org>,
	Vladimir Oltean <olteanv@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Frank Li <Frank.li@nxp.com>, Christoph Hellwig <hch@lst.de>,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] spi: spi-fsl-dspi: Target mode improvements
Message-ID: <dd41f014-79e8-4567-9617-754b93e2c12d@sirena.org.uk>
References: <20250627-james-nxp-spi-dma-v4-0-178dba20c120@linaro.org>
 <20250630152612.npdobwbcezl5nlym@skbuf>
 <c9bf945b-9fc6-4829-addf-2fb7a7d4eb36@linaro.org>
 <20250701135747.mns6emamtmxwgpyu@skbuf>
 <3c3c912c-1f33-4f63-9a37-fe4db5d23527@sirena.org.uk>
 <20250701145312.zx56ji4vvaoxwzkc@skbuf>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HTk5TJFuRBiKHd0E"
Content-Disposition: inline
In-Reply-To: <20250701145312.zx56ji4vvaoxwzkc@skbuf>
X-Cookie: No shirt, no shoes, no service.


--HTk5TJFuRBiKHd0E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 01, 2025 at 05:53:12PM +0300, Vladimir Oltean wrote:

> I suppose one could try using FIFO mode for transfers which request
> timestamping and DMA for transfers which don't. I don't have an insight
> into what impact that will have on the driver, but I suspect at the very
> least one will have to transform "DSPI_DMA_MODE" into "dspi->dma_available"
> and "dspi->dma_in_use", and reconfigure the SPI_RSER register (interrupt
> routing, to DMA engine or to CPUs) at every transfer rather than at dspi_init().

> The question is whether you would be willing to see and maintain such
> complexity increase, when AFAIK, the LS1028A FIFO mode passes its
> requirements.

Switching between modes is incredibly common, usually between PIO (for
very short transfers) and DMA, that's no problem.  Factoring in
timestamping seems like a reasonable signal I guess, might trip someone
who was trying to benchmark things up but probably not normal users.

--HTk5TJFuRBiKHd0E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhj++EACgkQJNaLcl1U
h9DIpQf/XKcdORpCSsNHp7hKf9q+kGBdf2QdQKdyEe4lwPspaEH5SWXjzwnMA0F+
UyKz1ZhiaMkbMOHRRfI6DFX4D7U4fOvEuHUhCDl/CF1Mp62PrLXRren1hJT8nmuS
svbsNU5fOeQNuRnFzpmUqCPGPw6XfVpQcLKn49bnsxPXEe89bT9641fp2Lfg4+GI
35cySaiHteOmVDYWvDyUdtZc0bYyM9CAcog097zcKI0ydVq0a8715gliaTRh1qVr
qpmtBJ96ariNmJUGaFmubFsSu41nw6lHYPpB8KLiOMJlEazGSeQvjZNFwC33eh/t
H5r1RkjvLfrf6X+0X1ek8ybVLOiBqA==
=hsW8
-----END PGP SIGNATURE-----

--HTk5TJFuRBiKHd0E--

