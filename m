Return-Path: <linux-spi+bounces-11187-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3085FC57251
	for <lists+linux-spi@lfdr.de>; Thu, 13 Nov 2025 12:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B4580343C6B
	for <lists+linux-spi@lfdr.de>; Thu, 13 Nov 2025 11:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E890233343F;
	Thu, 13 Nov 2025 11:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdZSjTkW"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B967821B9F1;
	Thu, 13 Nov 2025 11:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763032858; cv=none; b=LJ6TBv28wrbW431n8pGatF/nBBFztG7j55LX+A7NxgKnXYNCepkH9zO8pwQ4Ad5sSh1xcBXZJSOGtbVcgRpL/aQyxzUFPef1bg3wG/960jYp4exyNUQzNrIlFoeyS3xKN5H/USbQul8iXRAl/HHfYBfw6imOcshPSumlF7Guvz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763032858; c=relaxed/simple;
	bh=vtBK544FRyKS1BOwji0xiD0d+JWv6PGkNg7wpRHpRxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wr9E2I+Kw57EpZBLGRqgMYXEJguHefcmrbWs7GaV7amurNQQ1Hvdn4revhMgvW2jEs4b3J8Gt4bzsbSqgjHJPdCcMrqjOoCI65iat5spCtC0zWNVAAvH8Px9Z9jMk1EF7SHH0RyIVGF/PPzmRW6Txe4/r81fydodUzPZqHpOkQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdZSjTkW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A567C19423;
	Thu, 13 Nov 2025 11:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763032858;
	bh=vtBK544FRyKS1BOwji0xiD0d+JWv6PGkNg7wpRHpRxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SdZSjTkWNvwUE1+1q/Y6z8HApEWYFKsQV8J/3ylVYTDbNqnvBz7bG0SCIRZKkbdjI
	 Z55GKxjAUlXxLEhLhEJ8tNLn7z5utLBkz0NJdjszJlRHqklQG6oUDMtnH4jAr9v3kp
	 PF1ae0rWtMcdERLd9X/i7FUmM/8RUPh0AwTIv4rW0MAGZdVO9LBL25cqmCM//0NvyO
	 /GoQ/Fvi4ERBN1bRVCbVcr2Wfx7iOlOax9b20NI152XAseZyyRRqcICufQqoKmTqbV
	 Q8gpRLUCvhnbbqUM95+tU+M8TGVgTZcahtMAmsV5zM+BF7xQN+j3Xn+Giv3iQmpiM9
	 /fIFBV//4KDQg==
Date: Thu, 13 Nov 2025 11:20:52 +0000
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Tomer Maimon <tmaimon77@gmail.com>, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, avifishman70@gmail.com, tali.perry1@gmail.com,
	joel@jms.id.au, venture@google.com, yuenn@google.com,
	benjaminfair@google.com, andrew@codeconstruct.com.au,
	openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] spi: dt-bindings: nuvoton,npcm-fiu: Convert to DT
 schema
Message-ID: <9a175890-bfb9-43d7-bf19-5e2f5ca00f41@sirena.org.uk>
References: <20251112173314.1751671-1-tmaimon77@gmail.com>
 <20251113-loose-seahorse-of-endeavor-5d216e@kuoka>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c70ftPtkFe0Y8++O"
Content-Disposition: inline
In-Reply-To: <20251113-loose-seahorse-of-endeavor-5d216e@kuoka>
X-Cookie: An idle mind is worth two in the bush.


--c70ftPtkFe0Y8++O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 13, 2025 at 09:51:47AM +0100, Krzysztof Kozlowski wrote:

> Anyway, address space is rarely optional, so I have doubts you would
> have proper justification for this change.

IIRC I have seen some of the controllers with memory mapped flash
support where the address range for the memory mapping was optional
since it could be configured out of the IP when wiring it into the
platform.  No idea if that's what's going on here.

--c70ftPtkFe0Y8++O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkVvw0ACgkQJNaLcl1U
h9Ac1wf+LU21wucZkPrUikGhqSauz0L9PAoNweBaHggildDs6G+y/dxG67+ucIZb
qNKB2x26bwrysd0AM9nenCcdSd72zNrsb5/lxYxLIYkRbHwTqGDshxn8CEjHYU8u
0tF9panGf6fGeS0cWP2vDNk2288cIGEJ3oSFbPjJaWJIleja2O8vhT3WYzDXF6h/
vNkYKl3kmStqr69F10KTad5IyExU5QhsvzYrhRcKWim9uSc5E+4Ip4Uqz5fwEnWC
oz1/qp2ZZiMWYsUi8gnY8qKtzocJ5muMbXyS80uZQlF8mYE2JJIPMgY4OrpdSypL
+dwe6cAI15iM2MiNhjv2BFinMda4Og==
=OfFS
-----END PGP SIGNATURE-----

--c70ftPtkFe0Y8++O--

