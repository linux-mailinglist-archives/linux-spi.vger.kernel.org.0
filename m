Return-Path: <linux-spi+bounces-10356-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 467D1BAA63C
	for <lists+linux-spi@lfdr.de>; Mon, 29 Sep 2025 20:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA07E3C60E6
	for <lists+linux-spi@lfdr.de>; Mon, 29 Sep 2025 18:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7650023D7D4;
	Mon, 29 Sep 2025 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckgdZBaE"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B78217736;
	Mon, 29 Sep 2025 18:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759172002; cv=none; b=TnqwjJa3/xv3dWv0D4ott+oHOo5/6m/7wRZY3NYjZlRvYibOUhlC03Allr06fkaOPM+tCkIKiH+tMo7np6JnXzUNYWID8OfF+W9faIe4LtKh+617RYN7a3VVw6UE1T4wUupc4XDYutz3GcQ4aUv7Yv1VqZQ33I7ideYQNODh+zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759172002; c=relaxed/simple;
	bh=cNk2Xp9aKC1/fZzbSc81/LUDAhZMCewvH/hYBAA+o1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuGdCNzPiU+b+M2z+U252o2eH0vqXhcVWYNwwC4QdJa7Kr/RyzQ3DUMiatwX4pvUmijlcqrB7Wuugh9J6dHjz00AQi3Q+W44UyXtBHOpeCX30z1MOidSgejKbzE28CZ17onwzZlU/2KGg7kV4j/6QsmT59TpZWJjZIA+ryAJUQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckgdZBaE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B1F8C4CEF4;
	Mon, 29 Sep 2025 18:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759171999;
	bh=cNk2Xp9aKC1/fZzbSc81/LUDAhZMCewvH/hYBAA+o1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ckgdZBaEIwOILj4u0uIaJ76wpSm6QAYXTvfxzG71UvaGM118Gzsz1OzSIR4VKBijB
	 o/ZiAUVwGkgTJZrQunJJaR8eWJOc/O8qO6Cv0+SAZ9PzzPXRVz6GpFiL7CBs+i7cJ/
	 F1LZR7vPl9+1lArEBYr2E1vBLp/BETX7/OYcm7j/EZQl808xN2LuUugY4PmfTXAPN3
	 fXdTaMHog3i4RlNGU0OOqs3esvC5cyfYjM2kpTdnWpvBVlKJxf2KXoJgtQI09+9EEc
	 hnaPhcKTZ/+5qPhpj8o0OJvYoygAipHD+ZSVXhMFEkp/WcNQ354rrB0DrIKym6tvv7
	 iNxhkTM5NqOag==
Date: Mon, 29 Sep 2025 19:53:14 +0100
From: Conor Dooley <conor@kernel.org>
To: Vladimir Moravcevic <vmoravcevic@axiado.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>,
	Tzu-Hao Wei <twei@axiado.com>,
	Axiado Reviewers <linux-maintainer@axiado.com>,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Prasad Bolisetty <pbolisetty@axiado.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: spi: axiado,ax3000-spi: Add binding
 for Axiado SPI DB controller
Message-ID: <20250929-flammable-immunity-6bc48621dba3@spud>
References: <20250929-axiado-ax3000-soc-spi-db-controller-driver-v2-0-b0c089c3ba81@axiado.com>
 <20250929-axiado-ax3000-soc-spi-db-controller-driver-v2-1-b0c089c3ba81@axiado.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TTzfIpOXBJv0hnVG"
Content-Disposition: inline
In-Reply-To: <20250929-axiado-ax3000-soc-spi-db-controller-driver-v2-1-b0c089c3ba81@axiado.com>


--TTzfIpOXBJv0hnVG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 01:58:01AM -0700, Vladimir Moravcevic wrote:
> Add documentation for Axiado Digital Block SPI controller.
>=20
> Signed-off-by: Vladimir Moravcevic <vmoravcevic@axiado.com>
> Signed-off-by: Prasad Bolisetty <pbolisetty@axiado.com>

What did Prasad do here? Are you missing a Co-developed-by tag?

> ---
>  .../devicetree/bindings/spi/axiado,ax3000-spi.yaml | 63 ++++++++++++++++=
++++++
>  1 file changed, 63 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/axiado,ax3000-spi.yaml=
 b/Documentation/devicetree/bindings/spi/axiado,ax3000-spi.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..34fa96778dfdec89bc1478226=
5ec23c0bc455a20
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/axiado,ax3000-spi.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/axiado,ax3000-spi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Axiado AX3000 SoC SPI controller
> +
> +maintainers:
> +  - Vladimir Moravcevic <vmoravcevic@axiado.com>
> +  - Tzu-Hao Wei <twei@axiado.com>
> +
> +allOf:
> +  - $ref: spi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - axiado,ax3000-spi
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: ref
> +      - const: pclk
> +
> +  clocks:
> +    maxItems: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clock-names
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +   #include <dt-bindings/interrupt-controller/irq.h>
> +   #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +   soc {
> +      #address-cells =3D <2>;
> +      #size-cells =3D <2>;
> +
> +      spi0: spi@80510000 {

The "spi0" label here is unused and should be removed.

> +         compatible =3D "axiado,ax3000-spi";
> +         reg =3D <0x00 0x80510000 0x00 0x1000>;
> +         clock-names =3D "ref", "pclk";
> +         clocks =3D <&spi_clk>, <&apb_pclk>;
> +         interrupt-parent =3D <&gic500>;
> +         interrupts =3D <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
> +         num-cs =3D <1>;

num-cs isn't required by your binding and you have not specified a
default. Your driver assumes a default of 4. You should include that,
along with any maximum value, in the binding. See spi-cadence.yaml for
an example.

> +      };
> +   };
> +...
>=20
> --=20
> 2.25.1
>=20

--TTzfIpOXBJv0hnVG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNrVmgAKCRB4tDGHoIJi
0vqIAQDaoK3ID+wCoVxoZ2C0zZHMOI7RwcFAW3vjlsoV+4pezQD+OLkSm7QI3424
6TS2iP1Yc76+IilZ0IUf25FCuYukdA8=
=sQhy
-----END PGP SIGNATURE-----

--TTzfIpOXBJv0hnVG--

