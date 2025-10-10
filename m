Return-Path: <linux-spi+bounces-10522-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 923CCBCD853
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 16:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8CC7B54040B
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 14:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B132F5339;
	Fri, 10 Oct 2025 14:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSVFSg2v"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625EF2F3C32;
	Fri, 10 Oct 2025 14:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760106300; cv=none; b=RIWIhB+vTN3hTxmFEdYDCoFgeQ+OHOx4DQJnxnkViFOqjGN66vqxF8frSQ2r93Nn6mlBC0R1VPCoK7QPtUw3O87MfsZgR7N6FB8rXJxuthR8ABUZqco6rBq/s22KYuwLLzJBMhCbyM1K/bBI9awF87tuqKnShxjEywDVH0+E8Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760106300; c=relaxed/simple;
	bh=J8sWNiOYxowlMW18nKVK3dVuYCRC461LwDkFzez3QWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XsTaOzOAhB3nwFDsgaMJN7dHvhQsTzT3O1NN9JMXp7if9i6urshk5oUDqgrjA0eGjbxKTCxBDPECJMDGgdaNiZxn2wDc9GZiLUIZ5IrTcNnEzmv4GtT+zcTdAQruuHmMCMEfyyeTvH0jm6Zi61YbmQ+7WDqWgYpiTqlIrNTzq/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSVFSg2v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B95C4CEF1;
	Fri, 10 Oct 2025 14:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760106299;
	bh=J8sWNiOYxowlMW18nKVK3dVuYCRC461LwDkFzez3QWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MSVFSg2vVo6Qro2rAkelTcna3fSOk/InqEC682lBjaO6aUxpCzYZZ1GTMHsKmvPrt
	 Gxu0ZeJRfQ8KLnq6ESiLJ3SlKg0b2WASUYp61rSAdcvnJhFqHYuemfCY1gb68l0AK0
	 i7g5ImLxeGk7dHBJSikwNtgcif6LaIKdFNtBzW/TCtUv378L5CNDX3e7k4d0GdU9Yh
	 Lvh+9k9UVdOjfZ12gqGNDpAy2rx53lH0HKV3h6EBIzHpAKldoXMOZGHrbyK9vDjFOY
	 BQ4AwZxZBGkD5Kczt5wuQ4EutZ6+ogs5NjPFnMkl0vV2xpC6MgfbC7WvDh6cTumw8r
	 5yRKtyaI22KbQ==
Date: Fri, 10 Oct 2025 15:24:54 +0100
From: Conor Dooley <conor@kernel.org>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: Re: [PATCH v7 16/17] dt-bindings: spi: airoha: add compatible for
 EN7523
Message-ID: <20251010-landscape-cavity-88a963e45a6b@spud>
References: <20251010033136.1475673-1-mikhail.kshevetskiy@iopsys.eu>
 <20251010033136.1475673-17-mikhail.kshevetskiy@iopsys.eu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rOjyNSm5a3C66cVt"
Content-Disposition: inline
In-Reply-To: <20251010033136.1475673-17-mikhail.kshevetskiy@iopsys.eu>


--rOjyNSm5a3C66cVt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 06:31:35AM +0300, Mikhail Kshevetskiy wrote:
> Add dt-bindings documentation of SPI NAND controller
> for Airoha EN7523 SoC platform.
>=20
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

Please explain in the commit message why these two devices are not
compatible.

> ---
>  .../devicetree/bindings/spi/airoha,en7581-snand.yaml         | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/airoha,en7581-snand.ya=
ml b/Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml
> index b820c5613dcc..fdc5b0f920cc 100644
> --- a/Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml
> +++ b/Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml
> @@ -14,7 +14,10 @@ allOf:
> =20
>  properties:
>    compatible:
> -    const: airoha,en7581-snand
> +    enum:
> +      - airoha,en7523-snand
> +      - airoha,en7581-snand
> +
> =20
>    reg:
>      items:
> --=20
> 2.51.0
>=20

--rOjyNSm5a3C66cVt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaOkXNgAKCRB4tDGHoIJi
0ty4AP9HhsDk0a5+c83mF5LeHVZq0iCJQOUqAv/6o87d7uhvoAD/acsmShTBVTC4
ViX0nbl+U2XzHK+Yzxtl3YDx7XD8Owo=
=kctn
-----END PGP SIGNATURE-----

--rOjyNSm5a3C66cVt--

