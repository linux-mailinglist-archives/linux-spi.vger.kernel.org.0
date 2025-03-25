Return-Path: <linux-spi+bounces-7297-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B42A3A70335
	for <lists+linux-spi@lfdr.de>; Tue, 25 Mar 2025 15:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F85B3A48F4
	for <lists+linux-spi@lfdr.de>; Tue, 25 Mar 2025 13:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AD5257AD1;
	Tue, 25 Mar 2025 13:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdWnqM4j"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2572566EE;
	Tue, 25 Mar 2025 13:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742911070; cv=none; b=Pu9pFIGpPb0S00xyRqTdWOoYOzpfXykb7XPKWpe9D2avQuoRlqoMq0k/Av7HW7csmx2s6PJOLpN+c9+Lnkv2Pl0gdQjYAQmE8/1EIjdY35uOIZ11HnwH3s3K4q2PlsryYCJjZ0VQpA/M3LDMBDizP1lDTH6Ckp1d8vYbyzwzy1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742911070; c=relaxed/simple;
	bh=AmXHKKWLlSTvmrFOL6CAXtXybfj1pETdgzSNegqSC3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xt9rQknZDftnu9vILj70BdtoGyPR5DWj8Vd4S4sPZ3OMiHikxRyMvvkpRA6vVlpoHtZ2e5gGjpzsIMg911QjDy2xtBUTGEi41OvOfftbFTZgnbZ55/RsfO0LdZVj1QWDJ62Bs9Vr3jt6ftxfIv0uLJf2AGefhIRHBCL2SdKOfhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdWnqM4j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A500AC4CEE4;
	Tue, 25 Mar 2025 13:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742911069;
	bh=AmXHKKWLlSTvmrFOL6CAXtXybfj1pETdgzSNegqSC3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HdWnqM4jnyQ3a41EtqC+7GuUqgUGSkjfUVk9po5AAGAHFE6xXls31ZkALCV8PBKYG
	 4nY0oQAxKCAlY8/e4qlUkXhlrZe+pOT0zVcylWnKMjXyrM+bW34/ZS7YIYxC7e/CW/
	 283z+v5gOD7zqj5whFOkSrQwbg/OhFiN5Qyw2ErEk5pt3zBMEEeT/YwxSpIthIhIuA
	 z5QhWG6g7gVXzgOI1iPNjisAjJB5/DPgvADIrmr+ctdAM10yS8YvQ8jAC26msxxf3L
	 F9eePRc7ji60eN4GyUIr5PbWiUwGWQ0Lm0wMzbomWkMKsikAWMsI0LO5c6Jw5Wznb1
	 rXtTj/a/wiVXA==
Date: Tue, 25 Mar 2025 13:57:43 +0000
From: Mark Brown <broonie@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jon Hunter <jonathanh@nvidia.com>, Vishwaroop A <va@nvidia.com>,
	krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: spi: Add DT schema for Tegra SPIDEV
 controller
Message-ID: <fe03cadf-6f3e-4a26-82ce-8027e90bbdec@sirena.org.uk>
References: <20241126134529.936451-1-va@nvidia.com>
 <20241126134529.936451-3-va@nvidia.com>
 <a1278046-038e-4825-b029-1b478f28cb7c@sirena.org.uk>
 <e95f870f-1309-4ac3-a16f-ce58b02dc817@nvidia.com>
 <59ec100f-1915-447b-98fb-3cbe2ca53a1f@sirena.org.uk>
 <925fe847-68b4-4689-832c-08f8de3dfeb1@nvidia.com>
 <48f9c8c0-5cac-4812-8d06-501193be731b@sirena.org.uk>
 <909f0c92-d110-4253-903e-5c81e21e12c9@nvidia.com>
 <48248165-c800-484f-be62-7c48b3c6829b@sirena.org.uk>
 <4zic633abvwj377kfqem42zmc2yruflbwfmmqrpvjjgr6jae6h@jthoycb3vzzz>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d8dIwMNJoe65WgNW"
Content-Disposition: inline
In-Reply-To: <4zic633abvwj377kfqem42zmc2yruflbwfmmqrpvjjgr6jae6h@jthoycb3vzzz>
X-Cookie: Visit beautiful Vergas, Minnesota.


--d8dIwMNJoe65WgNW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 25, 2025 at 01:45:26PM +0100, Thierry Reding wrote:
> On Tue, Mar 25, 2025 at 12:10:19PM +0000, Mark Brown wrote:
> > On Tue, Mar 25, 2025 at 10:36:29AM +0000, Jon Hunter wrote:

> > > We finally got back to this. Looks like just having 'spidev' as the
> > > compatible does not work. Apparently, it use to work and yes you would get
> > > the warning, but that no longer seems to be the case. I see a few others
> > > have been doing similar things and hacking their device-trees in different
> > > ways [0].

> > Huh, OK.  I don't recall any deliberate SPI change for that.

> People in the discussion that Jon linked to indicated that it was this
> patch that caused the "regression":

...

> If you say that the regression wasn't deliberate, maybe we should look
> at fixing this so that people don't have to work around stuff?

I mean, we don't want people to be doing this which is why it generates
the warning - it's more tolerated than supported.  I don't super mind
keeping it so long as it's not getting in the way of all the fragility
with the enumeration stuff.

--d8dIwMNJoe65WgNW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfitlYACgkQJNaLcl1U
h9Cqxwf9HGDETMR3l+ZctfP4/5wQOUIr76yOGVEM6eshTh4dCLsO+IsCGmwCTgNF
hoMxt2MD7EC2LB/PXaGNExhtX5rAmvriXYLguIcnYnwH9jhgL+hXchyRtvGIFXfc
esKdvGkz6jwtD5WUCN3CDlEg/iAl7Uf1fUnFalkcMHxbTEssYPOSsLth8SYtk3Ys
UJazWvvoszbo9sEeoQWmzn5zgM3k3WHEpNg7mzEbp4lxwX+7DQoo/w8QYkB3x6LT
8+LWf2mfZWASS71UGfUqDAKG53MGO7ZcDhNmBiKcnkbi1KuY0th7PHWpeHjByaa6
+P/OXa+1axbIZOjdJN5C6z2OXLcMlw==
=PXbo
-----END PGP SIGNATURE-----

--d8dIwMNJoe65WgNW--

