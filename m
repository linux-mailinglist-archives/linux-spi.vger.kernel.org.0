Return-Path: <linux-spi+bounces-9413-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE44B26572
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 14:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD5A79E860A
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 12:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB3F212569;
	Thu, 14 Aug 2025 12:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lejqI9kt"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2296C17B50A;
	Thu, 14 Aug 2025 12:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755174884; cv=none; b=mPnTZZ8mW+3PIWi3nWiigOZ59496R9NhtzAl7aREFRXT2Xm1iiFoHlLUay2j2EGzpwAcGv6HZVB77mOWGMNq+ZMNk7QWex0Sr1E2UbbirjrfD75PKcqdkm/CPJPdv+5Lbb6kRv2kth0l/bFFHoRNRUPSkHSbyfGFupTqJ+KuyFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755174884; c=relaxed/simple;
	bh=0VrAhuKLaVyb61WaZNhMiNNuBwVKngCyRJ/V5YN1iC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIFk+pjn5z4wxYjFYgYIPNIoolre70Z+wlgEW5ppcVl+BZhvLKnC240m0vBeIg2fXFhby16jWzW6AIYdFFgAFXS4XiGYIDhR50hhbvHQbtC+G+8gqpEt3FkztQNKXEyZn+eID+AdGZMYJbm2UQ7L/7vip1e/Pvo/d5Bw5HKnPCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lejqI9kt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3BAC4CEED;
	Thu, 14 Aug 2025 12:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755174883;
	bh=0VrAhuKLaVyb61WaZNhMiNNuBwVKngCyRJ/V5YN1iC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lejqI9kt2PAkvbRwc5AaugS5uDQA2HkPjMWYuMxXxEtFScLJzoUrTAQiqwJuBngFF
	 lLVzwCltFh5qjf9/KX4a0w+Sd+CXsOL3dY2pq8juPi2E6gQCSO/IITqhxc4bDcm+lH
	 8QgRcYEOPQh+19yrMj/gVX86hJADE2bn2LEjQyWQ6nat4FwWDtgEC+ImWeOeg0RIOv
	 xTMKM0VOPQ/0ZiGH9lMcnz8b3Pkkhx77rG4nglx2PjjBfXqhZlyDrPZM0Jf/jg0+TB
	 OJVeXwcsSpUAbZV42yDHMIFVThhRELGqvDhNvndpfzRPfYp23OfRcFlHVyDeB0ZrXs
	 Nt2ds8u/ocxAA==
Date: Thu, 14 Aug 2025 13:34:38 +0100
From: Mark Brown <broonie@kernel.org>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	tudor.ambarus@linaro.org, pratyush@kernel.org, mwalle@kernel.org,
	p-mantena@ti.com, linux-spi@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	a-dutta@ti.com, u-kumar1@ti.com, praneeth@ti.com
Subject: Re: [RFC PATCH 01/10] spi: spi-mem: Introduce support for tuning
 controller
Message-ID: <2f051eae-61c7-4bff-9f85-cf37b02a7ea3@sirena.org.uk>
References: <20250811193219.731851-1-s-k6@ti.com>
 <20250811193219.731851-2-s-k6@ti.com>
 <6c35baad-a332-4b0a-96ca-1cdb3840ad94@sirena.org.uk>
 <20487e7f-33dd-4b65-b1a8-5bb8a06ef859@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hsVsvyCGymldcnqG"
Content-Disposition: inline
In-Reply-To: <20487e7f-33dd-4b65-b1a8-5bb8a06ef859@ti.com>
X-Cookie: This sentence no verb.


--hsVsvyCGymldcnqG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 14, 2025 at 05:04:33PM +0530, Santhosh Kumar K wrote:
> On 14/08/25 01:56, Mark Brown wrote:

> > Should we have something that blocks these tuning required modes without
> > the appropriate tuning, and/or allows discovery of which modes require
> > this tuning?  This all feels very landmineish - client drivers just have
> > to know when tuning is required.

> The flash's maximum operating frequency determines whether PHY tuning is
> required, as we need tuning in case of Cadence controller for frequencies
> over 50 MHz.

That's entirely specific to the Candence controller from the sounds of
it, that makes it hard to write a client driver if you need to know
exactly what the controller you're dealing with is and what it's
requirements are.

> And we do check for this condition - see Patch 07/10,
> cqspi_phy_op_eligible_sdr(), which currently verifies the flash frequency
> against 166 MHz. This logic can be improved by implementing both min and max
> frequency checks, will update in the following version.

I can't actually tell how that verifies if the tuning has been done
appropriately TBH, at least not without more effort than I'd care to
(and the tuning only gets added in patch 10?).

--hsVsvyCGymldcnqG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmid190ACgkQJNaLcl1U
h9BuIAf9HOg6LtPbsCspgF6wLQokIeC1xc/j87GykKnreWyld/ZIRyHTDhWa+kJl
KxWpWUNF/Nu1JT9nAnx03BTvx7fTOt+WKScIJg1kZFnWRHoULMQ0tEoYxEGMPUVG
TnXuBDDrb+AfwJdR5w112Z0ixw8yTVk8cNFnAEfCAUoxkpxXnesWYjoTV3GhztRQ
LTWxBj+EWthPRgIz0SnZFC0o54u+iJ9n5hkb7YiAVJ2A+O/XvcYogdXmulGWlvLl
g5Ec19gMjIo0LwIc6h9MDc/fFNnUDkSHSvd2t9g6DhjCMf+/Y+phV3v3AHYRlKhC
GYTzuHHYpdWrQbl/1JO/bw31IFhtcA==
=1D0X
-----END PGP SIGNATURE-----

--hsVsvyCGymldcnqG--

