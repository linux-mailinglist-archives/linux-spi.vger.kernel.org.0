Return-Path: <linux-spi+bounces-23-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FF67F454E
	for <lists+linux-spi@lfdr.de>; Wed, 22 Nov 2023 13:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EC951C208BB
	for <lists+linux-spi@lfdr.de>; Wed, 22 Nov 2023 12:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2234AF72;
	Wed, 22 Nov 2023 12:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxMWHIyc"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7054206D;
	Wed, 22 Nov 2023 12:03:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58005C433C8;
	Wed, 22 Nov 2023 12:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700654592;
	bh=tQRmNFQp+zLdjBmW/eVL1FEGW0CXiLk2EixjzUH4pNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MxMWHIycMWTui/Rwt3MmNhNZtUMkeQbkxyYgw5S4cjCw7nGTxTVgP2ipGGI2Ehnj/
	 uVSJBcBKBsrpUbaX5euqfZjLoBXQu1DTM56idERNxfpniYNSc6mGPyiVLMXLylnf4j
	 75ge8YQgjhLGABjHvth3sSjZjmJ3Jp4U+AIrdvgw3BnctqIMvgZ9v6hnrvTX2ZMCxu
	 AFwDg2ztQc9OX6Yz2zTV8kwBUZuJX8qHVbPO7lO9ZBQg+2jNajwjQY7vqixlZDhOpf
	 VcjSGOVMmIKanVg/t3Cbnx3HvIrWY65Pf5bJYRT9j25Wjw9pamp6E4rmPn0+YAtSCO
	 zHu68XeUVqwWw==
Date: Wed, 22 Nov 2023 12:03:07 +0000
From: Mark Brown <broonie@kernel.org>
To: nikita.shubin@maquefel.me
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 14/39] dt-bindings: spi: Add Cirrus EP93xx
Message-ID: <ZV3t+5gVKfFJwHs8@finisterre.sirena.org.uk>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
 <20231122-ep93xx-v5-14-d59a76d5df29@maquefel.me>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bM1oHkrl3jZxfR3+"
Content-Disposition: inline
In-Reply-To: <20231122-ep93xx-v5-14-d59a76d5df29@maquefel.me>
X-Cookie: Slow day.  Practice crawling.


--bM1oHkrl3jZxfR3+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 11:59:52AM +0300, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
>=20
> Add YAML bindings for ep93xx SoC SPI.

Reviewed-by: Mark Brown <broonie@kernel.org>

--bM1oHkrl3jZxfR3+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVd7foACgkQJNaLcl1U
h9CRQwf+JSN6jCrGLgTa4U7VdvV78brmnmtxIdrFoe2zth5HeiTRoBt4NnHr1ff1
k4v1DtKUEiKq3I4Wwc0qSfSL6tTWVhLwJ244qlqgyfzmJG/Lps65PAL0KMDh61qe
1TINDt0LX3K1zzzPTkpir+es/oyU6gW3vOdh472g8WphXkSIN685wyT0FZFu3Y3C
H6AIBq1oDcFtsiFwxhmCl4Xe+LhgTF0D0Y8dYJsjCLQFa4XBaD4UYIJl27qySJEY
7KN1ACbZZXEHsFPmHp4Q45jzoE4Nk6FYQ8fNH9u6mdzfUzZTXWMwC1pKO2rXTU3n
yhGpJfKSbQ/SJgFeajBv7GYyq5efVg==
=45OJ
-----END PGP SIGNATURE-----

--bM1oHkrl3jZxfR3+--

