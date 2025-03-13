Return-Path: <linux-spi+bounces-7114-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DBCA5F4D8
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 13:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C5119C2508
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 12:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D4E2673A1;
	Thu, 13 Mar 2025 12:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkAHsgh6"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DA9267710;
	Thu, 13 Mar 2025 12:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741870056; cv=none; b=fQP8FzcplOz4EtrDwq20DDc9532YiU+I2n7zTncb0Ti5eROBFTSlGQedp2TseDJWYBtF8gvhOg5Q31PIfxu0kfpYhVfp0zkBh9W0/z7SI7hSxiS94XZFfikFI/X+JDxV4MGeuGhrU1CEXLa9KgDUrx1X17l5s3JuT09mM2sU0cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741870056; c=relaxed/simple;
	bh=oP+rCPfNiKnrKk85Jq6C+JjzXLFdQho9igaD+bca+vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hE3na95fogOwQTpBdctcBx4NnKcz48mkOMLJploaK2YyP8OSWjYCStuLSmVw2fyeKZ0bsjZoYnPBn1DzJJ19VTLYmmOkZ4ELCZXvJzWNlVOSjV1wyi4a44UgzS/7wxKFTXUIG8JE+aMbTQzkGaUHoStrMo7lCVskmRMjnodDPsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkAHsgh6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11904C4CEE5;
	Thu, 13 Mar 2025 12:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741870056;
	bh=oP+rCPfNiKnrKk85Jq6C+JjzXLFdQho9igaD+bca+vk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fkAHsgh6Ibk7JlDS5K6qVD8anQQvj/AQMf3sOg5mWmqrMZb1PxZP4F8FFuccrlSQ6
	 NSHz+EqdP9fngEMUygXV7FbcYxEtMnDEpSXzjcJJLsb7myqnZqkq4Xmx3nDfGoJrsl
	 hlsxF8XofqcH8UTdTxoNLPD3xJOoeOHWPRk6607nQ0Sly6ohv2gcMN5wNrqE7iCiRk
	 UZjSFLeqJrOArUY1IkSQKLWB2rPpxwADyxCLRwE/O1e9eahwmhPeRFcVbDT51WJTAa
	 1sO8WIugoZSCpJH/ne0GnAShd4DS8sBNYXc/LciTrEHb6ouUJQVHXv6QdJSFUjelXQ
	 gtJB3kV57En5Q==
Date: Thu, 13 Mar 2025 12:47:32 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH v1 1/1] spi: Use inclusive language
Message-ID: <1c49edb2-2ffc-419e-be5e-7e15669a7839@sirena.org.uk>
References: <20250313111442.322850-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PdMZGyGqk6B7/MNF"
Content-Disposition: inline
In-Reply-To: <20250313111442.322850-1-andriy.shevchenko@linux.intel.com>
X-Cookie: Gravity brings me down.


--PdMZGyGqk6B7/MNF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 13, 2025 at 01:14:42PM +0200, Andy Shevchenko wrote:
> Replace "master" by "[host] controller" in the SPI core code and comments.
> All the similar to the "slave" by "target [device]" changes.

This doesn't apply against current code, please check and resend.

--PdMZGyGqk6B7/MNF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfS0+MACgkQJNaLcl1U
h9Cixgf/aIAxJ+wJ1Q/uSKPhqLD1V67CpGK6VZdTNBmVx+DhocdcASznzYJKAxLP
Nd6h9Q8vbOh5iDa1LgpLV1milo7+shb6vajrFV6wZZyJSNxTJ/GkXSJULzE6tJVx
7g3bMlSDJ0aQwMve3wP1NbPqVoCvfLI1biZJYbryhW+yTEFO1d0hOwA9EhbmdsZf
yAe9LlTPygcfPPaPCIRakxNre4JFeBC5Cy3Ly/zI4NTeDqS480JfCOS/3SFz51F/
izGixkffP952ANAMgyUe1oqcrKvNEpu1/jm11vNDm71HhmLPYM7SMVXzZ0tfh+oS
lSUUCZysEDrT56Di++/HADSl5wtzDA==
=9e+e
-----END PGP SIGNATURE-----

--PdMZGyGqk6B7/MNF--

