Return-Path: <linux-spi+bounces-4080-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A82C8940F8D
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 12:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D3481F27B1A
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 10:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E0D19F499;
	Tue, 30 Jul 2024 10:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLhHxEVH"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF59C19F478;
	Tue, 30 Jul 2024 10:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335550; cv=none; b=RZTyHwPmfJ+4Owg/c4pEH+Uge5dTm/brK4klXnMhbg9JAioI2wyEYsv4a2I97vy7E8LQe5eut8SpL98+6Wv7EpQeIqf2Go6IqUBwKTO06w85acJ+TsW8DKzqbLU1Di7lNyRZyOTKtrqqCLr2BqbZI5KIbSWiWsRYrFUnccY6irM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335550; c=relaxed/simple;
	bh=txn1s3bgzVIuXJu0cYM+vvtxHF7FjobSOmpL3UqHN+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ig87jiTJaNFEnkm5YI0b39wYgmt+jCahgbeZrpJi+MkIeVPm2k5LWVcNFAAHN0Q5r55RawYah3FaXn24PTxpn1Hb9ErYrcud6zKl7eoCeF715xGGw6NtMxZ3ZhRZ8tQ8vkjAny/X0GsFkWbgeFC2S0ey3LNOohiVMJYVPcvME6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLhHxEVH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5DCC4AF09;
	Tue, 30 Jul 2024 10:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722335549;
	bh=txn1s3bgzVIuXJu0cYM+vvtxHF7FjobSOmpL3UqHN+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jLhHxEVHYtrrei05iTxVuu9BeWNwTGiWIpOXmZ1nfGP4uE03r0LdqgzkXn4gkMJHO
	 88QJCGaNW4TeCSGkQmjL9S0n3Gh/3daOCj9YeAurYxHlCfKI5RvndcPpbJGDvf6wSU
	 ccOUwjJMjSbbm/9Fzz34a0wteycBHTLBlMMH2JNDyqofcwL4bD3v3nTrIT0cBKKMX2
	 rBEYTrzRIiFBv58NdOfsuo1BthUU9WWVd7EDGDHzD+UolsuqwH+zie2fHnkPpe+8y4
	 sF/xxRN4ChiiGQhR9cf/VEBlqQZfkBFq8FAheSw8n2fJR7tGpuZPmHJiT+o7OuS5zB
	 VvYH4Z8l8A/NQ==
Date: Tue, 30 Jul 2024 11:32:24 +0100
From: Mark Brown <broonie@kernel.org>
To: Witold Sadowski <wsadowski@marvell.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"pthombar@cadence.com" <pthombar@cadence.com>
Subject: Re: [EXTERNAL] Re: [PATCH v11 4/9] spi: cadence: Add Marvell SDMA
 operations
Message-ID: <7d8151b9-ab9b-4a9b-9503-e2be89ac6dff@sirena.org.uk>
References: <20240724154739.582367-1-wsadowski@marvell.com>
 <20240724154739.582367-5-wsadowski@marvell.com>
 <CAMuHMdWnd8BOLVXpAy8CoFqKzYhp+vj6un=w7Umpo6OQ=Nxqng@mail.gmail.com>
 <CO6PR18MB4098B578E6DED1FF39C3ECF1B0B02@CO6PR18MB4098.namprd18.prod.outlook.com>
 <CAMuHMdUbTm++Vcf8f-wAnHgXF4wgJydE3dAn2hO0oAiTtMkouQ@mail.gmail.com>
 <CO6PR18MB409801B2DCFEAD204F784711B0B02@CO6PR18MB4098.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EZuf7eho9kDeFV8O"
Content-Disposition: inline
In-Reply-To: <CO6PR18MB409801B2DCFEAD204F784711B0B02@CO6PR18MB4098.namprd18.prod.outlook.com>
X-Cookie: Don't SANFORIZE me!!


--EZuf7eho9kDeFV8O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 30, 2024 at 10:17:43AM +0000, Witold Sadowski wrote:

> > drivers/spi/Kconfig, config SPI_CADENCE_XSPI:

> >   -depends on OF && HAS_IOMEM
> >   +depends on OF && HAS_IOMEM && 64BIT

> Can that be send as separate patch, or whole patch series should be updated?

Please respin the series.

--EZuf7eho9kDeFV8O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaowTcACgkQJNaLcl1U
h9CXpgf/YYlbnEym1msKwwvSsTAWiDTG3hj6LrCulsGBQjB5H73wHBJQMHdsG1Yn
k9G1Px0CP7LNlXe1DKrbv9xrGBLOBoX6+ItJ5z5anm4IgWgOjnfkf+7knyOBknqn
4DGgRdeWlv6n0It4oSLTDt3aTSIYZWukDKRfa6gPI1crOnRBX0H7Yh0LrbhNO9Js
DoqhKGZdZUdikeVZNITQjoqHRWydviokfoZoQ+dYthX97HdpQVoHAt8CpSmhq/KK
YKi5agSAVjFxdVwIC1ajhRXiGHda24qAhC+YfGAqcPRcwuVNDSdWjh/9GB7HL+0g
RxkG5h6iZmdwlqaDtbZL/8g/x11KKQ==
=nRWV
-----END PGP SIGNATURE-----

--EZuf7eho9kDeFV8O--

