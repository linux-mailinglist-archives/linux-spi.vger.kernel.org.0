Return-Path: <linux-spi+bounces-5850-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF949DAC76
	for <lists+linux-spi@lfdr.de>; Wed, 27 Nov 2024 18:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF51916711C
	for <lists+linux-spi@lfdr.de>; Wed, 27 Nov 2024 17:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7845482D66;
	Wed, 27 Nov 2024 17:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nleGZZJh"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4096BA41;
	Wed, 27 Nov 2024 17:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732728697; cv=none; b=Tr/8ocGX0a8AsMdIrNClwXfMWDVi1yhtYdN8yda4HNVnJZ9pMi96kSVTAYKHcTcZdOhSLGlMBgu1ajIzUPNsjvVIDVb5R733FJ65cvKORzAuPzG3JCdvnlSXsvNLboN8RST2gKWuEPnjazdPFCNRAnhAWaecp4V5DdF2OafGN7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732728697; c=relaxed/simple;
	bh=LfXrssLl1K5C5+1Lr9sZjQhFSsdyhL7juvo3sKzUbyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZ55yAtaiysu99QZq1P+O1P4K4jZJ+WtvGnns0JLvm9cfM1r/xaYjHp/rs949xIl4WuBJVGL4zH67rfPYMDbzSz5saLbC9+nQLUD/eOL1gKVC03tKWv90NHcq8D7NBvrEBynqOfdGWWlFPzM2fW9e4S65I/Kb2nK9b3EjYHXkII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nleGZZJh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0BBC4CECC;
	Wed, 27 Nov 2024 17:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732728696;
	bh=LfXrssLl1K5C5+1Lr9sZjQhFSsdyhL7juvo3sKzUbyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nleGZZJhKjPuvp+eVNdK1ql3FYKbZ9zqzQkgaOXTqVfBNPQBILpq2o5re9sw9o3mF
	 665GCrIFQx7+U8w3cLhUCQuWDw8br10g/US2OFDxtgxL61i3tLq5gQ2a72zikRSIVE
	 PrpFLKIQGxXl4p3dJlhXVNXkHnYLbcY3WvlsXjjsM8aRaOkjUIWZJ+V/b0z6UHh3pR
	 WbOQz+/uvB+eGjjAztw1wjbXvfoJKSO2owUW5021bJAZnsYRbN6zldLVyr/aZhOMTo
	 scqqzpuuG3CBmAEo/hDUtgZI1obNjSqhsQFRAsyrTa4oBmXNWgDKexGnwE5yp85M2X
	 Z4aZxAF3YfGpg==
Date: Wed, 27 Nov 2024 17:31:31 +0000
From: Mark Brown <broonie@kernel.org>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Vishwaroop A <va@nvidia.com>, krzk+dt@kernel.org, robh@kernel.org,
	conor+dt@kernel.org, thierry.reding@gmail.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: spi: Add DT schema for Tegra SPIDEV
 controller
Message-ID: <48f9c8c0-5cac-4812-8d06-501193be731b@sirena.org.uk>
References: <20241126134529.936451-1-va@nvidia.com>
 <20241126134529.936451-3-va@nvidia.com>
 <a1278046-038e-4825-b029-1b478f28cb7c@sirena.org.uk>
 <e95f870f-1309-4ac3-a16f-ce58b02dc817@nvidia.com>
 <59ec100f-1915-447b-98fb-3cbe2ca53a1f@sirena.org.uk>
 <925fe847-68b4-4689-832c-08f8de3dfeb1@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1JUZLYFyoBZ+UnKq"
Content-Disposition: inline
In-Reply-To: <925fe847-68b4-4689-832c-08f8de3dfeb1@nvidia.com>
X-Cookie: Every path has its puddle.


--1JUZLYFyoBZ+UnKq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 27, 2024 at 05:24:01PM +0000, Jon Hunter wrote:
> On 27/11/2024 16:09, Mark Brown wrote:

> > I understand what he's trying to accomplish, it's the same thing as
> > what everyone who wants to put a raw spidev compatible in their DT is
> > trying to do.  The way to do this would be something like a DT overlay
> > that describes whatever is actually connected, or just customise the DT
> > locally.

> We could certainly use an overlay, but how do we handle the kernel side? My
> understanding is that per patch 3/3 we need to reference a compatible string
> the kernel is aware of. I guess we could use an existing one, but feels like
> a massive hack. It would be nice if there is something generic we can use
> for this like 'linux,spidev'.

> I see that ACPI has something and it does print a warning that this should
> not be used in production systems.

You can put 'spidev' in as the compatible and get the warning, we don't
require specific compatibles if the Linux device ID is good enough.  If
you genuinely just have bare wires you're probably able to cope with the
warning.  If something is actually connected you should use the
compatible for whatever that is, if spidev makes sense for it then
that'd be OK to add to spidev.

--1JUZLYFyoBZ+UnKq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdHV3MACgkQJNaLcl1U
h9CkhAf/Sd+cdQQ9AQTt/DP1h6dK/EpNAfJlhvCVKSSlIQjLBcY3AG/2OjxesmoU
YmLesR1KdO72iGZtpyZuZ0CgY5T+1A6F2sGCYmholsjs1tt3zItscYNyI3GvB+va
IEtrkQ+6fXsQ32ITKp9PzMIHOUvN1AKHKTj0A1oTSeTdJ3k1YoMc/mqYt5MTYV/G
DU2MKC13LFzkjA4cjpQ/LXMhlQTynI/axSCwBCuZXlvXzJqxfjyw+oCLmhsNaiaW
uQOmMbfHr27eQ/jLsVvU9fwok1b8ucPvKZ+kDy7mraEJv/tZApzmmFJwK8ZWVQGO
qojI8Uiz/uEw+a9SRocKOVjKxM5jng==
=18Mw
-----END PGP SIGNATURE-----

--1JUZLYFyoBZ+UnKq--

