Return-Path: <linux-spi+bounces-11179-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 169E4C540C8
	for <lists+linux-spi@lfdr.de>; Wed, 12 Nov 2025 20:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B6BC3345CA8
	for <lists+linux-spi@lfdr.de>; Wed, 12 Nov 2025 19:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A1C34A77D;
	Wed, 12 Nov 2025 19:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwBqUvx9"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C32E34A773;
	Wed, 12 Nov 2025 19:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762974181; cv=none; b=Oj1gK/b1DjZ12zh5hQX6fhPeRuRKTBTysEvRf2hcwvBwzosNBUzIX2V2XVUlMqsyct/b4eWJb1mLMUeeAFLVX94u5TANiPGv4AOmq0H9bgiblkjaR4pVPGn8eSaP4RnxedsKJE9vEPc9/9w+V09p8g9HYLzodKsBYBDFu515unw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762974181; c=relaxed/simple;
	bh=1Hnaxo29Dy7cVIVxRydEj2hiQd0dJIsbq/8zl5Hej/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oykuKLD6eOQWBKSz3FffTgnOCUDWY61wiDZiW+VE1ZSrurE2UBFgC26EdssX0t4aRhmeR3g0S0Aj5mfDV+yIJKDXjHJEpJ/PUAoNM8eZfaVEhZKhrGESLuEkvLmvDlHOZ4/uAksraixIehNB6QAo32jKO945nZ+Gk4dZLxRlrpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwBqUvx9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B9CC16AAE;
	Wed, 12 Nov 2025 19:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762974180;
	bh=1Hnaxo29Dy7cVIVxRydEj2hiQd0dJIsbq/8zl5Hej/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uwBqUvx9n+tcFB9dxupwaf6Vq2VTmB3OugWBqw8vhoUUlJcjNHYrADdGWs0LOXt4y
	 K6SDqq458mtrA02JkufMw4LwiIj9OAtjHA0rhbhTRX8ExWNBSS3I9RqLGKBflJpXEq
	 4IHMlc/Ek8Ewc9ZZoLpWZn3nGlXIfBZS2vzJ30t1n6ZQDXcqXtIOfg6/iQGQ6367b4
	 qfpm3mwkykRlewUArBGtO7ROXC3oSQUOW77sN0cVXhrTuRnKurUBShuqmsWvUhQaVK
	 se3C/radIZdvDN4ZqGYDvdPVdfOElH3ClmD1Q4Z7Jq7qtfuQWQctn2BrpIMMIQQhqc
	 QKGRHfgtTTGdA==
Date: Wed, 12 Nov 2025 19:02:56 +0000
From: Conor Dooley <conor@kernel.org>
To: CL Wang <cl634@andestech.com>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, tim609@andestech.com
Subject: Re: [PATCH 1/2] dt-bindings: spi: Add support for ATCSPI200 SPI
 controller
Message-ID: <20251112-reoccur-quill-2144810ce062@spud>
References: <20251112034724.1977630-1-cl634@andestech.com>
 <20251112034724.1977630-2-cl634@andestech.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xzPhLzXmE0GbsSLU"
Content-Disposition: inline
In-Reply-To: <20251112034724.1977630-2-cl634@andestech.com>


--xzPhLzXmE0GbsSLU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 11:47:23AM +0800, CL Wang wrote:
> Document devicetree bindings for Andes ATCSPI200 SPI controller.
>=20
> Signed-off-by: CL Wang <cl634@andestech.com>
> ---
>  .../bindings/spi/andestech,qilai-spi.yaml     | 84 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/andestech,qilai=
-spi.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/spi/andestech,qilai-spi.ya=
ml b/Documentation/devicetree/bindings/spi/andestech,qilai-spi.yaml
> new file mode 100644
> index 000000000000..db065062a2af
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/andestech,qilai-spi.yaml
> @@ -0,0 +1,84 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/andestech,qilai-spi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Andes ATCSPI200 SPI controller

Is this a spi controller or a qspi controller?

> +
> +maintainers:
> +  - CL Wang <cl634@andestech.com>
> +
> +properties:
> +  compatible:
> +    const: andestech,qilai-spi
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  num-cs:
> +    description: Number of chip selects supported
> +    maxItems: 1
> +
> +  dmas:
> +    items:
> +      - description: Transmit FIFO DMA channel
> +      - description: Receive FIFO DMA channel
> +
> +  dma-names:
> +    items:
> +      - const: spi_tx
> +      - const: spi_rx

Drop the "spi_", since it's obvious that it belongs to this controller.

> +
> +patternProperties:
> +  "@[0-9a-f]+$":
> +    type: object
> +    additionalProperties: true
> +
> +    properties:
> +      spi-rx-bus-width:
> +        enum: [1, 4]
> +
> +      spi-tx-bus-width:
> +        enum: [1, 4]
> +
> +allOf:
> +  - $ref: spi-controller.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - dmas
> +  - dma-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    soc {
> +      #address-cells =3D <2>;
> +      #size-cells =3D <2>;
> +
> +      spi@f0b00000 {
> +        compatible =3D "andestech,qilai-spi";
> +        reg =3D <0x0 0xf0b00000 0x0 0x1000>;
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +        clocks =3D <&clk_spi>;
> +        dmas =3D <&dma0 0>, <&dma0 1>;
> +        dma-names =3D "spi_tx", "spi_rx";
> +
> +        flash@0 {
> +          compatible =3D "jedec,spi-nor";
> +          reg =3D <0x0>;
> +          spi-tx-bus-width =3D <0x4>;
> +          spi-rx-bus-width =3D <0x4>;
> +          spi-cpol;
> +          spi-cpha;
> +        };
> +      };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dd99c073a369..55e31996df03 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1803,6 +1803,12 @@ S:	Supported
>  F:	drivers/clk/analogbits/*
>  F:	include/linux/clk/analogbits*
> =20
> +ANDES ATCSPI200 SPI DRIVER
> +M:	CL Wang <cl634@andestech.com>
> +S:	Supported
> +F:	Documentation/devicetree/bindings/spi/andestech,qilai-spi.yaml

> +F:	drivers/spi/spi-atcspi200.c

This driver does not exist at this point, so you shouldn't be adding it
here.
Cheers,
Conor.

pw-bot: changes-requested

--xzPhLzXmE0GbsSLU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRTZ4AAKCRB4tDGHoIJi
0mflAP45qBJuvC80YTD6TaMmeF1EldcTaijV8NjDdZO69/NZJgEAqK7EY4VTCmC5
nyvWFeTNANBXPfsSi0OVqnqqlpov3Qs=
=hAZh
-----END PGP SIGNATURE-----

--xzPhLzXmE0GbsSLU--

