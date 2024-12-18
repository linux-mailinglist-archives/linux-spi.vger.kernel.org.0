Return-Path: <linux-spi+bounces-6109-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5629F6BCA
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2024 18:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 163351898374
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2024 17:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AD11F9433;
	Wed, 18 Dec 2024 17:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aj/llndd"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA251F2396;
	Wed, 18 Dec 2024 17:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734541273; cv=none; b=pm/6Fq5LF4JayEt8wZMWbyz0G2pPOnQpA6PbNk5h5ued6JKvVbpIr1VFhBzZO8mmTxaOQHWvBQlPmnV1/T/hvxQPNLtvo+T4K/Y4L7GI5/NhfC8Ni6qt5ohmXLhtDfb+5nUYQaszvqvEPIjFGp5LNgEUqyQ4tYqhRz1NhRlH/FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734541273; c=relaxed/simple;
	bh=dIoAmISD+LGTSjgUefMBAt54g8E6jPkZUaVcIHrtops=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQFAcL2OhRoSCKGnPfEguV9orolXW8lR6ibDTCGo+QF2bFj43sizzcz876D+YLOPcDbB9uwE663zEB10VA4oV5ZUkSrfu+Y3h6mB1ttj8WnbUgHqyn3vib++lBKLQ1GG9dcCeTJwYAwocESVxqttmQZuBZfZYP7DWoyvNzQoSrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aj/llndd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D5FC4CECD;
	Wed, 18 Dec 2024 17:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734541273;
	bh=dIoAmISD+LGTSjgUefMBAt54g8E6jPkZUaVcIHrtops=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Aj/llndd2ZmVLFQSXarr4gUktdrIr8pIuZckY0Rqm+vmecnxFm81FT3U7AsI+2jcb
	 eU8N+B/NPvsUaTkcgD4qax21MPkPdAOJgv9ERzza+rD4yzacwA6O7sXmzfEikd40bQ
	 jyQZmh6JWqsPKR9/Ctkz1EiBpG8pt4YPFhAFnkisLhn+BEHUH0VtfrpE2RrjUpWd70
	 bLX3rNXB/1bqGyjK2Ha1zOpxc/AXHW42KZsmw6M1XSEbd1H7Fp/T8lJABp6R9NJqX2
	 Cxpz+v7X9eoFGpEoZAsCiRX/y/epr/EyaSAf4vCc9Zxq37r5JdO/twG8W5EPcU+2mj
	 L22qvN7r9CXTg==
Date: Wed, 18 Dec 2024 17:01:06 +0000
From: Mark Brown <broonie@kernel.org>
To: Bence =?iso-8859-1?B?Q3Pza+Fz?= <csokas.bence@prolan.hu>
Cc: Piotr Bugalski <bugalski.piotr@gmail.com>, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Hari.PrasathGE@microchip.com, Mahesh.Abotula@microchip.com,
	Marco.Cardellini@microchip.com, stable@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH] spi: atmel-qspi: Memory barriers after memory-mapped I/O
Message-ID: <b1661e3f-cc62-489b-a4f8-9964ccf65fae@sirena.org.uk>
References: <20241218165850.378909-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kbtZHrGcJjW7ZlA7"
Content-Disposition: inline
In-Reply-To: <20241218165850.378909-1-csokas.bence@prolan.hu>
X-Cookie: The heart is wiser than the intellect.


--kbtZHrGcJjW7ZlA7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 05:58:49PM +0100, Bence Cs=F3k=E1s wrote:

> However, the current documentation makes no mention to
> synchronization requirements in the other direction, i.e.
> after the last data written via AHB, and before the first
> register access on APB.
>=20
> ---
>=20
> Fixes: d5433def3153 ("mtd: spi-nor: atmel-quadspi: Add spi-mem support to=
 atmel-quadspi")
> Cc: Hari.PrasathGE@microchip.com
> Cc: Mahesh.Abotula@microchip.com
> Cc: Marco.Cardellini@microchip.com
> Cc: <stable@vger.kernel.org> # c0a0203cf579: ("spi: atmel-quadspi: Create=
 `atmel_qspi_ops`"...)
> Cc: <stable@vger.kernel.org> # 6.x.y
> Signed-off-by: Bence Cs=F3k=E1s <csokas.bence@prolan.hu>
> ---

Your signoffs and whatnot need to go before the --- so they don't get
cut off by tools, any any ancilliary stuff should go after.

--kbtZHrGcJjW7ZlA7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdi/9IACgkQJNaLcl1U
h9CYfgf/V/U13+rRVSu+GsmapnXKorn00ftr4fZkBkxVvAi0n9R0tR97gr1MkZmD
xcqCJt3JIgdMSqtj+qtQb2cdbO6G9pw3We+45yY6o6fRWAFxfKpdra8t+LLv18gS
vsW+kulFtedaAY6YRJL2qKjAZBcZjLQNYO35Jj+ue+ZAnBHR7YJt0SJiBgQuP2do
itVOU15JepuzUA5o3h1Toic4II58r5ubftYsABQGezXCrLW6yxz/RYkrxIvaK7xN
bm2nAn20u5hHL9YmXTELemq7ltXGvgQDjAbMjgpmBVRqtvZ5l3HOlSOoEAAMSSDh
kx/EvTk2AXN1/A2lBH/7Jpjvvguotg==
=8ijY
-----END PGP SIGNATURE-----

--kbtZHrGcJjW7ZlA7--

