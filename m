Return-Path: <linux-spi+bounces-8095-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B25EBAB3E0C
	for <lists+linux-spi@lfdr.de>; Mon, 12 May 2025 18:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C066188E317
	for <lists+linux-spi@lfdr.de>; Mon, 12 May 2025 16:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A5E25335E;
	Mon, 12 May 2025 16:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJny5x2q"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A051C84DE;
	Mon, 12 May 2025 16:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747068575; cv=none; b=Uy3B23i5m7/Er15/0sZUlhWqPp/XRfoBAkT9XINXyB2Pncm2AITLSGKqicpvnhEH0ALyMTW6jv6GOpBrxSWSZIRhFSXdqf6IvAzR8SagNoW5baI6dLJ/JFoWGky6Hqse49RVuQBOkXcDfGHfGSc0qc/lX9ojYIdzFTlc0bSNE3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747068575; c=relaxed/simple;
	bh=/yvw1nnqbyiVtf/uj+S0pMN9yyaV6992GcjalVXEwT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utt2Rj1e7PPGcQQ7o3C6M6PsDszAl3jNM/btye0a157KvO14HnXGOAas3wHdn7x4kriQ4yM8DrOiqm+iQ9v9pai5y+s3lE1/KTJ/rPYDvcW8B3ku6JW7Z0sCe74ri7xSetBVU/HrvaPT/saMNR4M2Y+0/7PUQIMFDleBdNLchJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJny5x2q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91D2C4CEE7;
	Mon, 12 May 2025 16:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747068574;
	bh=/yvw1nnqbyiVtf/uj+S0pMN9yyaV6992GcjalVXEwT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vJny5x2q4gf3xJGNPgU7Nodhe9m8fzdkqw1uAIgor8FXemN3ONwapqcMFXU6eg9TB
	 oi7xEmSdK3lZmS198wi6IcnsyuAjpL3everT/F5Jr/aCrZIv5FA+HPC/4gJA1ZSYi1
	 WO+VY0tI/K1XOZCEKOiQLYjoPLBEQG0mYUXWtG/4IWfDo9kUi4RuwW2nWam7yatAu/
	 KPw0Uy76pKNWj28mdBAs0VxE30hHwxm1+2j0QxxCN7KI1hYsEYNmbbTq2fWzsxqF6y
	 30dVyAr1lloZ2irFv5PaLcLE7hwbNitqbDc4rcEwpk1b1TS1bc/+54UDmTtk9GGs4V
	 ONXt0r+xl2iNg==
Date: Mon, 12 May 2025 17:49:29 +0100
From: Conor Dooley <conor@kernel.org>
To: Vishwaroop A <va@nvidia.com>
Cc: krzk@kernel.org, broonie@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, thierry.reding@gmail.com,
	jonathanh@nvidia.com, skomatineni@nvidia.com, ldewangan@nvidia.com,
	kyarlagadda@nvidia.com, smangipudi@nvidia.com, bgriffis@nvidia.com,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 RESEND 1/2] dt-bindings: spi: tegra: Document IOMMU
 property for Tegra234 QSPI
Message-ID: <20250512-observant-rental-21927c85c709@spud>
References: <20250509165409.311912-1-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="b7v6v0TWl91jPaKU"
Content-Disposition: inline
In-Reply-To: <20250509165409.311912-1-va@nvidia.com>


--b7v6v0TWl91jPaKU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 09, 2025 at 04:54:08PM +0000, Vishwaroop A wrote:
> Add the 'iommus' property to the Tegra QSPI device tree binding.
> The property is needed for Tegra234 when using the internal DMA
> controller, and is not supported on other Tegra chips, as DMA is
> handled by an external controller.
>=20
> Signed-off-by: Vishwaroop A <va@nvidia.com>
> ---
>  .../bindings/spi/nvidia,tegra210-quad.yaml    | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>=20
> Changes since v2:
> - Fixed version number to match the actual version
> - Added proper changelog section
> - No functional changes from v2
>=20
> Changes since v1:
> - Fixed subject prefix to match subsystem (dt-bindings: spi: tegra)
> - Improved commit message formatting to follow Linux coding style
> - Clarified that IOMMU is only required for Tegra234 platform
> - Added explicit disallow for IOMMU on other platforms
> - Removed redundant explanations of what the patch does
> - Fixed commit message to use imperative mood
>=20
> Initial Version:
> - Initial implementation of IOMMU property documentation
> - Added iommus property to device tree binding
> - Added support for Tegra234 platform
> - Added explanation of DMA and IOMMU requirements
>=20
> diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.y=
aml b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
> index 48e97e240265..04d3b1a47392 100644
> --- a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
> +++ b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
> @@ -10,9 +10,6 @@ maintainers:
>    - Thierry Reding <thierry.reding@gmail.com>
>    - Jonathan Hunter <jonathanh@nvidia.com>
> =20
> -allOf:
> -  - $ref: spi-controller.yaml#
> -
>  properties:
>    compatible:
>      enum:
> @@ -47,6 +44,9 @@ properties:
>        - const: rx
>        - const: tx
> =20
> +  iommus:
> +    maxItems: 1
> +
>  patternProperties:
>    "@[0-9a-f]+$":
>      type: object
> @@ -69,6 +69,19 @@ required:
> =20
>  unevaluatedProperties: false
> =20
> +allOf:
> +  - $ref: spi-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          const: nvidia,tegra234-qspi

> +    then:
> +      properties:
> +        iommus: true

This is a NOP, no?
Just invert the case above and drop a clause.

> +    else:
> +      properties:
> +        iommus: false
> +
>  examples:
>    - |
>      #include <dt-bindings/clock/tegra210-car.h>
> --=20
> 2.17.1
>=20

--b7v6v0TWl91jPaKU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaCImmQAKCRB4tDGHoIJi
0nCdAP0SwhcOv3w78KUp3q+/132CGvA5hXO8+nprMYHRBeAVJwD/Z4Jiu2d4tJ6/
Q3o7E6/SGMTjBqGnVwJK9M/+r8H+XwQ=
=qS0d
-----END PGP SIGNATURE-----

--b7v6v0TWl91jPaKU--

