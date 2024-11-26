Return-Path: <linux-spi+bounces-5845-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A11B39D98EB
	for <lists+linux-spi@lfdr.de>; Tue, 26 Nov 2024 14:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DE98285AAF
	for <lists+linux-spi@lfdr.de>; Tue, 26 Nov 2024 13:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CD11D515E;
	Tue, 26 Nov 2024 13:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvTU8Dtq"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBDA1D4613;
	Tue, 26 Nov 2024 13:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732629386; cv=none; b=LCxTVXeeL6+hyWhP7WhS7F4ohcThiOijXC0ihpVpH7/cW/j1Q0cVzMpfagdbclbRzXWz95rPUb/m3+n7WNVnR66JqiDu60U/ae778AUD+zjH2Qwhz3HPLwbjKvZJc/i0VxYmHijcnJqA9srN7Gcow4bY3wkIwGQpAgWn4jxT6OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732629386; c=relaxed/simple;
	bh=C9NMuo+SvuNaXmn9OIOSkE3ItSsS1LiS+HH4lO+wEeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Am47g2W7q+n5T3sGD8eWuUP7M2BACLorx0AH1FY7Hj9kyNFmKj1FdBQBYZHu3rLRLWE52MVulegdllhINga52qmB/+X9mxf2qt8vuFfeGmIw6WnHz8B5ZQE40cWmyUJEIQ9+gY2p5Yl9atZBKjsHmzkv0oqSq7xaOmLplkH8Zv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvTU8Dtq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50C0C4CED0;
	Tue, 26 Nov 2024 13:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732629385;
	bh=C9NMuo+SvuNaXmn9OIOSkE3ItSsS1LiS+HH4lO+wEeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KvTU8DtqMtBuDqsRKmNuSiWVC9Agza7lm0PrMQCug3dy9u39kT29bfjj8qOrvD7hx
	 BY1nN/S4RBd0b8lbkipTxJ21a9bIIGA/vpFjn3At3t545NbswG6GXTFgJoSE7TIvaQ
	 5MnrKcx52XRK7lNpYesUq1/B1E09+DbAcHDiTRj7gcIeZF9JVco9JqzAnTphoqYQ+m
	 rAFkDwew5FiNe/7fc0I0+r12VAk5s5HGkBvQXcNb0kocD8EIrRowC13f/pM6iXmDqP
	 ElRRUaNxb19eRrHn6KzAouIWPDsN0/4lpdw1OjaZmFUmdh37ZPFTeRN75ByNTImsvQ
	 281Q8YZC3RRqQ==
Date: Tue, 26 Nov 2024 13:56:20 +0000
From: Mark Brown <broonie@kernel.org>
To: Vishwaroop A <va@nvidia.com>
Cc: robh@kernel.org, jonathanh@nvidia.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, thierry.reding@gmail.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: spi: Add DT schema for Tegra SPIDEV
 controller
Message-ID: <a1278046-038e-4825-b029-1b478f28cb7c@sirena.org.uk>
References: <20241126134529.936451-1-va@nvidia.com>
 <20241126134529.936451-3-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5zPrq4ac1/5/O6cB"
Content-Disposition: inline
In-Reply-To: <20241126134529.936451-3-va@nvidia.com>
X-Cookie: Have a taco.


--5zPrq4ac1/5/O6cB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 26, 2024 at 01:45:28PM +0000, Vishwaroop A wrote:

> +            # NVIDIA Tegra SPIDEV Controller device
> +          - nvidia,tegra-spidev

All the issues with having spidev nodes directly in the DT also apply if
you add a prefix onto it.  Whatever is attached to the SPI controller
needs to be described, not just a placeholder like this.

--5zPrq4ac1/5/O6cB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdF04QACgkQJNaLcl1U
h9DH0QgAhFw9HsOEMjXknGj8jIozaFPshlKWOQeoD4XHd7Qq0nzGFhQU7v2UsGli
tq0hQ4N/V5sSXAXu+dCaIDLgdXBOiQ5uKWKhtY8dbmuagY5x97NdQ0QNTPiVunDO
FYPknnKD8ge3I0A53eJ0CiWiFC59re4TjgkaUa3A0v7ortkzcEjbk8TpN7qmClUw
lYRalFMj6kEmDCrWFTWOvf+IYBOxFJbOWC2sK1+suogXEI4JuAnswTZN8XKX5SnS
LoKdhTOG1wLdYzTaj7e8efVqQ8ZxcCC+IE/6cbxwVrWMu9/8coFaVeuJ84vsarrM
buJ6d9B8N5t/lqAcnq26wmzLR/atsg==
=kDYG
-----END PGP SIGNATURE-----

--5zPrq4ac1/5/O6cB--

