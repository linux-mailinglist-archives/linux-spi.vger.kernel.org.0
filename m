Return-Path: <linux-spi+bounces-7121-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FFAA5F8A2
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 15:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06EC01884149
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 14:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FCC267B1D;
	Thu, 13 Mar 2025 14:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNE3B9Tz"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F2D22612;
	Thu, 13 Mar 2025 14:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876772; cv=none; b=Q0Vy06Ia4pue1bAhs+zcD6Z4TLMjj5HjlawmPY2zfJYUwt5tZjBLnSFX68pYquQt2a4sRIsx6Sv4wwCWAm0EojsqeFBvDYe6aLaKWzZm+7WGNk/XKgYWK5p2sYv3rbKtQwiYKRTCSlFYV2IAiHvD3Rv9Kz477bICe7d9c5kzIE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876772; c=relaxed/simple;
	bh=MUgokbLQXVwrjubKZoMCX9GPPfkVn6vt/U2RaFfyvUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsG5lh8f+nMrQvwjWaun0VkFzIonpw8GUkuoE+HpCUl9jjNtWGOHI/cBYnCfxXOUuaP/8KtljA9Vfa0eMOFNMwBoO9wQlnhMoz9EtcKhGK3H1g1TlprYSOmh9PXd/Mm2X+QiJC+I+4sI0cEqjG/hfAJInQxFYND98dCVemsfZdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNE3B9Tz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D42C4CEEA;
	Thu, 13 Mar 2025 14:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741876772;
	bh=MUgokbLQXVwrjubKZoMCX9GPPfkVn6vt/U2RaFfyvUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iNE3B9TzqqCriHM+C3XTJXWg6i9B88Vj9eDoRgdP8Z9eGiIvrIlEjdpwIM+9GmmyT
	 hHy7t7bLQ5z2wAUqED7XqJs9MDVej3Z+5rtO0PUhVM74l80gq+OwI5PzmRbVjDlXaV
	 WEM07GqqmLYaWVgnvlGX0kxOjhPd70hTIwTfogmUCAIQ6ndbHKKEIj2k1hxHTykPPw
	 BZ9HGXLc1FpgGdZqGDUnRGwNOnBpeYFkiG1qaLPmDPO3s+BZuA6W8k4GOesKKPy/Cf
	 lEW8lT9hLRLCbd+ksTXbToEQtP7x5+CJ9NdfP+nzo+tfFe3ID5G6gQWESQ8q8l+Uc+
	 ldVt0XeQqBPeA==
Date: Thu, 13 Mar 2025 14:39:27 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH v1 1/1] spi: Use inclusive language
Message-ID: <dc17b87b-29c1-4b66-9353-c934a68b929a@sirena.org.uk>
References: <20250313111442.322850-1-andriy.shevchenko@linux.intel.com>
 <1c49edb2-2ffc-419e-be5e-7e15669a7839@sirena.org.uk>
 <Z9LlTflb1HQMyEv2@smile.fi.intel.com>
 <e329812d-90a5-456e-9a00-abb5c2c8d25d@sirena.org.uk>
 <Z9LqyWr4GH4RX6Nj@smile.fi.intel.com>
 <Z9Ls-zhryd7mJv-b@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FBNcT1LVjMOpystl"
Content-Disposition: inline
In-Reply-To: <Z9Ls-zhryd7mJv-b@smile.fi.intel.com>
X-Cookie: A beer delayed is a beer denied.


--FBNcT1LVjMOpystl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 13, 2025 at 04:34:35PM +0200, Andy Shevchenko wrote:
> On Thu, Mar 13, 2025 at 04:25:13PM +0200, Andy Shevchenko wrote:

> > Yes, the base where it was merged to is eds-acpi branch of my public GH [1],
> > which has no SPI stuff in there.

> $ git checkout -b test-spi-mrg spi/for-next
> $ git cherry-pick -1 87a228960033
> [test-spi-mrg 8a11d1063109] spi: Use inclusive language
> Date: Fri Dec 8 19:02:54 2023 +0200
> 2 files changed, 64 insertions(+), 66 deletions(-)

> In any case there is a v2, please try that one.

That one does apply.

--FBNcT1LVjMOpystl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfS7h4ACgkQJNaLcl1U
h9DQZAf/eERa8ly5YiZRIBreTJqXGAWex0ryWJYXkdSj9ol4ISYlBg/6U/nDq6/x
UZys6FWmMoeCEtClsQTxw0FLLBXcE2YDUhQ7H99VXUWzmZAHIxxMWW09jlL6YOKr
R4NSqOb4xvjPomzVmk+LRdEK+fhY+pzSMs473CQnihWY6eV0c72nbnmm7UcexAwk
PM3PFW9sEdiqY48I2gWVTccUAAbqG2gWBEHH4RX1+2XlE6d9SqsbN9D+UTfMhgcD
6IJ/mXvJY144tYPYzx763/8p2vS7V3Pb2xCQel6UwZrJTmWYIi9luxiwmf4Gycro
aBsEbSfyt4F/gv9etaBKDsbm/d2Jsw==
=cf78
-----END PGP SIGNATURE-----

--FBNcT1LVjMOpystl--

