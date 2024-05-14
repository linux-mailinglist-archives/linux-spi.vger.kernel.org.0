Return-Path: <linux-spi+bounces-2847-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 054568C5A92
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2024 19:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E6811F21C00
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2024 17:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E7E1802AA;
	Tue, 14 May 2024 17:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBSn7cCs"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797682AD1C;
	Tue, 14 May 2024 17:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715709166; cv=none; b=OUz46lMHrsOkgV/cFKapYTmPJ4YckLJAB91y/cFE+NmQdFVCWdTP+WAFoTbBkayLgdXb495Xgb8rOghIprWJN6BGZpLyCbIaj+K7/l/uZAmPyHy9aiUMIXsTdSb3V5l+gm0pisZICvyCzh2wZ3syAuROf8qWrDfZdt152xDnoIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715709166; c=relaxed/simple;
	bh=qNjfAu4NG8Akw8mfYF0kzZEJKjB5jWGN4i5QOPlFrB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNlcULcK7uYlBPVGK8mdmUeBI50Vmt6jz5Dc92EiycdEj3jIrVfMyRjjmKm8yKaPo+Itxm59D4/NlGIGE1dkLrN2C2gmAN0mtdmw0zEBz1vfGt0L07+5z3vy+0aXljL0P8Jf15aPCbTZ5j7NcUzM1CiLodu/V/CR76P2Mp9r1j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBSn7cCs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 162D2C2BD10;
	Tue, 14 May 2024 17:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715709166;
	bh=qNjfAu4NG8Akw8mfYF0kzZEJKjB5jWGN4i5QOPlFrB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cBSn7cCsiYFVHEcWWUE6cMnbPTvP4BFaM+w3KWH/7v//xyStDoT5EBv7cudLYy8Df
	 GS3oSxPvx+AIHWGPD8rj7FXwF1CEquWs9hT99rG2N1LiJE+M7bQs34COp8B5FBiU3j
	 72GxDJ/PYklcDkTyeA9oAYpOUepbHXsVoI/oKAE28SHZAhfnSnmbeSpU1UyZLBLeP4
	 AQcdwsjGzh6P/aRKS6vta/ZCh1FTzUwNxrWoaeW1nmJQ26Y9YP2AdidzldlVngz0Ha
	 tUUkpYrBtEzlMWYbMsOFKJOaYkP/f7OFVo/hJnFTLVWHVtH46pjKPmdKRgc8Ev54UZ
	 eez/SBZ6fYYqQ==
Date: Tue, 14 May 2024 18:52:42 +0100
From: Conor Dooley <conor@kernel.org>
To: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	valentina.fernandezalanis@microchip.com
Subject: Re: [PATCH v2 1/3] spi: dt-bindings: Add num-cs property for mpfs-spi
Message-ID: <20240514-parmesan-enslave-444763e785ff@spud>
References: <20240514104508.938448-1-prajna.rajendrakumar@microchip.com>
 <20240514104508.938448-2-prajna.rajendrakumar@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="l5DifMLtxko3ajhl"
Content-Disposition: inline
In-Reply-To: <20240514104508.938448-2-prajna.rajendrakumar@microchip.com>


--l5DifMLtxko3ajhl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 11:45:06AM +0100, Prajna Rajendra Kumar wrote:
> The PolarFire SoC SPI "hard" controller supports eight CS lines, out of
> which only one CS line is physically wired. The default value of
> 'num-cs' was never set and it did not didn't impose a maximum value.
>=20
> To reflect this hardware limitation in the device tree, the binding
> enforces that the 'num-cs' property cannot exceed 1 unless additional
> CS lines are explicitly defined using GPIO descriptors.
>=20
> Fixes: 2da187304e55 ("spi: add bindings for microchip mpfs spi")
> Signed-off-by: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
> ---
>  .../bindings/spi/microchip,mpfs-spi.yaml      | 29 +++++++++++++++++--
>  1 file changed, 26 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yam=
l b/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
> index 74a817cc7d94..ffa8d1b48f8b 100644
> --- a/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
> +++ b/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
> @@ -13,9 +13,6 @@ description:
>  maintainers:
>    - Conor Dooley <conor.dooley@microchip.com>

I provided the conditions below, so it's maybe a little disingenuous for
me to provide a review from a dt-bindings correctness point of view, but
then again I am the one listed as a maintainer for this particular
binding and what's being done here does match the hardware, so:

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.


> =20
> -allOf:
> -  - $ref: spi-controller.yaml#
> -
>  properties:
>    compatible:
>      oneOf:
> @@ -43,6 +40,32 @@ required:
>    - interrupts
>    - clocks
> =20
> +allOf:
> +  - $ref: spi-controller.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: microchip,mpfs-spi
> +    then:
> +      properties:
> +        num-cs:
> +          default: 1
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: microchip,mpfs-spi
> +      not:
> +        required:
> +          - cs-gpios
> +    then:
> +      properties:
> +        num-cs:
> +          maximum: 1
> +
>  unevaluatedProperties: false
> =20
>  examples:
> --=20
> 2.25.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--l5DifMLtxko3ajhl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkOk6QAKCRB4tDGHoIJi
0uJUAP4wXa6qR/dXqw/b2iphEzu9Bm1hdToleARl0CE/hfXq0gD+L6NBEDBLxgCv
w/3GtTtJfnjoa2V5Ll1nAKLqgilP+w4=
=MaCe
-----END PGP SIGNATURE-----

--l5DifMLtxko3ajhl--

