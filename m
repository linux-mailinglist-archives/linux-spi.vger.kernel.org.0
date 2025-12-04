Return-Path: <linux-spi+bounces-11765-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D4BCA434A
	for <lists+linux-spi@lfdr.de>; Thu, 04 Dec 2025 16:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A3B92302C36C
	for <lists+linux-spi@lfdr.de>; Thu,  4 Dec 2025 15:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3835F2E1C63;
	Thu,  4 Dec 2025 15:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWrktubN"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056A72DE6EF;
	Thu,  4 Dec 2025 15:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764861087; cv=none; b=RTUDQOXnvlH1PtKthIpLndo2MzvEYPOSH9xowXLSgHRt4gKfZynRDAyGCUESEl52iQZmRTGTlBVB/mt1gc+Ryw58IyGWWPYboeXxw92PATOwTmD42kIJ3Xgnzf+MdROfkPSQ4bx7i4dUKjeJX+OGv52knUf7UE66zOt+DzwmPWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764861087; c=relaxed/simple;
	bh=s8RwynxFSobSHFiYg6apsiIzFrd9hwGiYn1dp7L7tiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cIL/BYwMQDG7xRk3xQn3XSvx2Ml8NaWUR87n80qe6CTZ+g+JareorNEK5a+v5TH3w5vFQgRLJktn9qsAub96oQ5ipxWz4H1InrPwC/c/jZ87C0QP9e42G0dOGP82ZCg7zH3qChT1+dfmC+RGnCHv+l8Tbn/gXqwa/Qhbs/p/akg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWrktubN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC0FC4CEFB;
	Thu,  4 Dec 2025 15:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764861086;
	bh=s8RwynxFSobSHFiYg6apsiIzFrd9hwGiYn1dp7L7tiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AWrktubNcNgYiCf093EJiWNLLDny7SZD9Lk++GZ0QXgt6aTDgZOt/VAyW6wwLxVcf
	 I4dU421pgedMmWPLHfS79AEdhg73obtZhHl6oh0Bax6YAX6pFDXSZCm1Go+Nx3fXTt
	 WCcdtY4IoM4YmpZBY5EGYZO/OiysHzRo5L2tazZCWHUtMFX5tj0YoPrwYU1yi/fxnl
	 eSwJzBx2+/dQj675DVnzHeZUl8gwmCOLGJ93LPBB8yq7ihtFljlIyT79dXfqLcir7g
	 h7MPPU7uRY9h/YI3z5RcQeUsJJ1Dt1EeO3GF3K542CDmdF3oet1sFAl5MdW+MRDcdM
	 JOvX7qCwJHwzA==
Date: Thu, 4 Dec 2025 15:11:22 +0000
From: Mark Brown <broonie@kernel.org>
To: Nishanth Menon <nm@ti.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Anurag Dutta <a-dutta@ti.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] spi: cadence-quadspi: Fix clock enable underflows due to
 runtime PM
Message-ID: <4d6b857e-4bfe-45ef-a428-6e92f218f0c5@sirena.org.uk>
References: <20251202-spi-cadence-qspi-runtime-pm-imbalance-v1-1-aee8c7fa21f2@kernel.org>
 <aTFQv157O-wJjVrZ@gaggiata.pivistrello.it>
 <555e9f6b-b8b6-4cc5-900b-63aaff8b4e6c@sirena.org.uk>
 <20251204140530.xax5didvuc7auzcd@problem>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t9U0UkLkOfzEnkeG"
Content-Disposition: inline
In-Reply-To: <20251204140530.xax5didvuc7auzcd@problem>
X-Cookie: volcano, n.:


--t9U0UkLkOfzEnkeG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 04, 2025 at 08:05:30AM -0600, Nishanth Menon wrote:

> The clock is already turned off by the runtime-PM suspend callback, so an
> extra clk_disable*_unprepare() is only correct when runtime-PM support is
> not in use.

Right, I'm pretty sure that's where the extra disable is coming from.
The pm_runtime_set_active() further up the function is looking rather
suspect here.

> -	clk_disable_unprepare(cqspi->clk);
> +	/* Runtime-PM suspend already disables the core clock. */
> +	if (ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))
> +		clk_disable_unprepare(cqspi->clk);

This will leak the reference if runtime PM isn't enabled unfortunately,
no runtime PM operations will get called.  Life would be vastly simpler
were that mandatory :(

--t9U0UkLkOfzEnkeG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkxpJkACgkQJNaLcl1U
h9C28Af+OMR9uVsQM4j51CaK4qIVO/f+4Cf60EexZIetalNBr4M7Yv9ra9WACfDe
muQD5LEGSN1C+EnsNv9ie7J3Llx+rMDzcMqpYyXGddeTKeneNdoKSR4zNPGgf4Nf
ImkbQZ7CiKK3OPh0gu6PgZekIxdNiUHPJB2X5WjbGWp7BWNLZDTJKYUTXxzpJHtw
AVKQqqpgC4GgOSvbb9CwgZXbj7LGGo/E5WCkDkriQb6D0DUTPN5YShvU0yg5uu0o
KkA23VfIwQcbyCL6dG0HU1nzuXZhhG4aImuuU3bcBZl8pCPTBbFPEHtWtVl9HQfP
MiCYLcqqTAFpQmmB0k9LMIHEVbmPeg==
=6bCa
-----END PGP SIGNATURE-----

--t9U0UkLkOfzEnkeG--

