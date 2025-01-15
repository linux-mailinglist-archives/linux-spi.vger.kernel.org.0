Return-Path: <linux-spi+bounces-6364-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B46A12C1E
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jan 2025 20:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83BD4166702
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jan 2025 19:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6CF1D88D0;
	Wed, 15 Jan 2025 19:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAtY86il"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9038A1D6DBB;
	Wed, 15 Jan 2025 19:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736971093; cv=none; b=st3EIttFDBktpVnw2GmU03Xye2QbKUN8J83A5AErTW8jbzH1KeIbICuOfmeuNiwRxCTp8/Urbg87RYYnMrhAhJIero3uDXtnC3owkFcgaOHwPcfDP0e2gUGzoH2YvZnflV07gMXxdQNXHcFsMw9jZXwBKdObox0JJHAaNCT0qIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736971093; c=relaxed/simple;
	bh=b1zwF1BGXQlXm1R3cl13d2s0ww/jUj2cHk8qqDqXlLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvGnT+tRHmF5BFAvmwKPUXhPivto+vx4ZoYHlnQ1wYOsOS09CK4jwXZqWbtsn2WSXVanfqbl48eDurAc2ov1/01u9FtTAtpZ67pGmp+5G0lUvjxLFJik6/T2kHYuj5YBG7/lZZu9/GMwQgBTXH/VT+nt1MyOyWW0fsk9gOgnqJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAtY86il; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E10C4CED1;
	Wed, 15 Jan 2025 19:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736971093;
	bh=b1zwF1BGXQlXm1R3cl13d2s0ww/jUj2cHk8qqDqXlLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OAtY86ilFjTPdTtwFEuuiGc9ORgUMgPSr8wCse3pCwHXuhVH3MEeTFsoAnwm7zwVu
	 hfU79zCuwxK5vB17Ctl9HMlFW9xpqAOdpDbLx3Fr7PmQaNFkfPUfOilXuo1GUi7pi9
	 nhsCf0UyG+vRZ8SroIaVB15FFl1LPD+xxWah6S44d+NIFtub3nK/7ce7ZWeG3aQ4vM
	 wEm9ixrUWBmM5tXrxa5Ng0C6uxiBkus2V4gJ5YKzjcyLz+ShBzq6tOCwCfOtXVrUW0
	 B2ho5pClOVqxZ72z5y2sjJrUXcZyyuwZVIY8G1+jX8Jdw+A39aCuaWwB51QbP/usNd
	 Q4/8Eb8rpBdiw==
Date: Wed, 15 Jan 2025 19:58:08 +0000
From: Mark Brown <broonie@kernel.org>
To: Bence =?iso-8859-1?B?Q3Pza+Fz?= <csokas.bence@prolan.hu>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH 3/4] spi: atmel-quadspi: Use `devm_dma_request_chan()`
Message-ID: <c0bf43cf-895c-4a0e-b771-39481b6bc024@sirena.org.uk>
References: <20250115160244.1102881-1-csokas.bence@prolan.hu>
 <20250115160244.1102881-3-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5/C570SxBCbhJhqK"
Content-Disposition: inline
In-Reply-To: <20250115160244.1102881-3-csokas.bence@prolan.hu>
X-Cookie: Phasers locked on target, Captain.


--5/C570SxBCbhJhqK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 05:02:40PM +0100, Bence Cs=F3k=E1s wrote:
> Leave releasing of DMA channels up to the devm
> facilities. This way we can eliminate the rest
> of the "goto ladder".

You've not copied me on the rest of the series so I don't know what's
going on with dependencies.  When sending a patch series it is important
to ensure that all the various maintainers understand what the
relationship between the patches as the expecation is that there will be
interdependencies.  Either copy everyone on the whole series or at least
copy them on the cover letter and explain what's going on.  If there are
no strong interdependencies then it's generally simplest to just send
the patches separately to avoid any possible confusion.

--5/C570SxBCbhJhqK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeIE1AACgkQJNaLcl1U
h9AnNgf8DMYZf6zzg9U9DWtNPVoUCGrIyhEwHEBrEAdgZyNU40ajjEYnLbiovUF5
XVNT5K838kI/G8zJqNJbJQSbYz5Jf/Q/telyqxtCBFvi1txRaqcIqg2nf5Lixb4n
U5ITEToURnue9vGDlMR5awGYXJHfp3Ys7tA3mdxJJh2Gl3l7LdClTtB4QPp+A2MS
QdwR/YW/uC9ck+sDXecUryZgQCqkzG0U4DnAnjl9TLniqx9F2DeLC+im0/heDRx6
mMXct18YUQQuj96j9FA+OJmywhPMYH5m9EBilJkQHQHy8fPU+ySqq51oqF/92XHx
uz5zl9EdYpFrw9/vQtegyT2doIMQwA==
=VR/j
-----END PGP SIGNATURE-----

--5/C570SxBCbhJhqK--

