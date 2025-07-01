Return-Path: <linux-spi+bounces-8943-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 298EEAEFCBC
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 16:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 171E47A2C84
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 14:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6655B27603A;
	Tue,  1 Jul 2025 14:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dk3Arslw"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A3A275B10;
	Tue,  1 Jul 2025 14:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751380587; cv=none; b=UcLrFhjH3e6MWF0QolyonTOA+OKO2nSJN3jpJ4Xn6r5xaPAOmdCbcqbvwfGSK1MNU9XtSQlXCJ1E/oANLk33ZEQ8Sxny8ZKHbHtFG/1rXQQLq+y77MuSc71AaJzKBSUW+FHBLFQQ5cH9fwf7FQTUcUDq3YAX5itFqBQGY4gmaAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751380587; c=relaxed/simple;
	bh=knAEIJ1EdW+gJR4GF/o6jjsjDFjRhovxO/cp/ga8z50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgGh/zoKkBWX6zoXRtuQ7zgr9GvDlTFvNApWbXjeN8LgLt4y86qcxyjfw8ntBqcnpNaekhslsHgkjO8jzITgGnmFXqsrllhvikFjkMKg5qMMaIOcv7czP0LZdvpDhtvTE3gAo7Y2CXZnYfnq2zB+u/Yc1boe/tgPeATPKBLO4hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dk3Arslw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57B0C4CEEB;
	Tue,  1 Jul 2025 14:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751380586;
	bh=knAEIJ1EdW+gJR4GF/o6jjsjDFjRhovxO/cp/ga8z50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dk3ArslwgCTJqYLms5PVFOva7jSixaKKq1KGvJAVJJMjcnbVxoAHChUhaTd2+J0tm
	 wk2JFTd+73p/1Rdy63TYN3cCbNdIrrjfvy9Ozzv9tdB7QKZUTRJLuineHlvOhiiSxG
	 g+/J3fCtk3RFYYEBGM4iifeo5H1ukvZt9N+HhW79WeDHl/jZwzq+MzgstG7uLifes7
	 wSGEhkz7FsdIyAomgCMwt3JvFF/VjCXi0nbJfY19Kd9cRd2d7f57qbzJb6TV6XLIXx
	 1RnUm7W/zZoezyG6MHIZaUMcbZGb1C7prgUGWwrwS+RkvqAmA0VKi9hkdQTiju8+L3
	 5P2DEa+l8UxvA==
Date: Tue, 1 Jul 2025 15:36:21 +0100
From: Mark Brown <broonie@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: James Clark <james.clark@linaro.org>,
	Vladimir Oltean <olteanv@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Frank Li <Frank.li@nxp.com>, Christoph Hellwig <hch@lst.de>,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] spi: spi-fsl-dspi: Target mode improvements
Message-ID: <3c3c912c-1f33-4f63-9a37-fe4db5d23527@sirena.org.uk>
References: <20250627-james-nxp-spi-dma-v4-0-178dba20c120@linaro.org>
 <20250630152612.npdobwbcezl5nlym@skbuf>
 <c9bf945b-9fc6-4829-addf-2fb7a7d4eb36@linaro.org>
 <20250701135747.mns6emamtmxwgpyu@skbuf>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pB5bWIeihD2yWORs"
Content-Disposition: inline
In-Reply-To: <20250701135747.mns6emamtmxwgpyu@skbuf>
X-Cookie: No shirt, no shoes, no service.


--pB5bWIeihD2yWORs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 01, 2025 at 04:57:47PM +0300, Vladimir Oltean wrote:

> Here, the synchronization offsets in DMA mode are an order of magnitude
> worse, so yeah, initial enthusiasm definitely curbed now.

> For me, what matters is not the latency itself, but the ability to
> cross-timestamp one byte within the SPI transfer with high granularity,
> and for the uncertainty of that timestamp to be as small and constant as
> possible.

This is sounding like a copybreak type situation with the mode selected
depending on how big the transfer is, that's a very common pattern.
I've not looked how easy it is to flip this hardware between modes
though.

--pB5bWIeihD2yWORs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhj8mUACgkQJNaLcl1U
h9Dsrgf8DDdJVCD+apYpWWERyI2gIDN7hQ/G1PHciKDWW9shSoYckXawcPyTf+ON
aUic2yaxhlo4XEADeuppzmZPzUeInBsJYmT1UAjRxsjURR8bHRWQ4Q4sfupTPFCh
VWqY77QvVJiaNEk3SfqHnuRUEKoErx67R/M6iHJsWwVjYOMvCqdkwA1RBfs/bp2t
91evPhxK3AIhRsX2RnsWcvhdHTzMI//F+L4aHOidShHlPTLtXVON+oga2YPJe39k
8J+Ityf0aj8lbL1xKxVFFNCX0kUtDh1zxa4bZ2JubBeMlei1BwxGziedWAfcid+I
LTmj58WZ6YssnOt8RZ5oLvbw56AXzw==
=EMMl
-----END PGP SIGNATURE-----

--pB5bWIeihD2yWORs--

