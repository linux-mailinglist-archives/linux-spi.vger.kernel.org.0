Return-Path: <linux-spi+bounces-10026-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A81FAB5837F
	for <lists+linux-spi@lfdr.de>; Mon, 15 Sep 2025 19:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCC607A28D4
	for <lists+linux-spi@lfdr.de>; Mon, 15 Sep 2025 17:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0005B298CD7;
	Mon, 15 Sep 2025 17:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEqbEYBw"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5D01F1315;
	Mon, 15 Sep 2025 17:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757956969; cv=none; b=GK9lodANjyMKFbzn/XL64Ij7f44Bmd6KE6PVX1whGfFnPKP7RPAsdNYTBbV/YlVUZ2s4tB8fGMXbGrIc7HNS+73U6RMUubk58OiMbEIMN8dKT20W3BJnAdYsnAoOL2sNgs22Ld5yCvVK26GO5MT/V6wQ15gFmXabtvlzkmuy/3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757956969; c=relaxed/simple;
	bh=nm4Sl6r+yzhJ34p1St5LokAobcG1hPH0o7AU2Hb2xkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKCz+r53NLJ4ypzKxY80vfeSuNrBI3izAfM5bJ1WEsi6PrMjERxPET/4wmA8p56xeg2GTkNX16tSTTZYzzMS7XFYxvkISpgD980gTTM7VVZItZ/PYSTQ3jhAKTWynpLSxgwvkG9ggHJmDz8p0Z+pyutTonpSKE62CoCBoRH1NXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEqbEYBw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297C5C4CEF7;
	Mon, 15 Sep 2025 17:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757956969;
	bh=nm4Sl6r+yzhJ34p1St5LokAobcG1hPH0o7AU2Hb2xkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lEqbEYBwcw9ZvxDf5lw0qwk55kbrOXrm80DPU6vbJyy3cTj8jvzeeoEXbv86e0I1k
	 ndxJBf9Ivn+TtMj2w4pAXpFaXkrqlcUe2Yr+iY99GLBgyGd7oXzuhc6YYUrlEONSSO
	 EzGlSQbhWyequ2oLDT+NNpq2rwficwnzLZaoirR3liL3rydrKxEyUrkBbIpG4NprPq
	 /G8J7MU8ks2m4P4zE/jMb78j7ViIZy50uQbiIry9ja64+AJrKnzKBfJvCo4TBi8/S7
	 cG4okr2podH32Lo0Hrx3tVM8wupbvkEDFWh9mO6npcWAQqR+yN/Q/dTCSL91kAlvHW
	 Q6Nm4uKrAfE1w==
Date: Mon, 15 Sep 2025 18:22:45 +0100
From: Conor Dooley <conor@kernel.org>
To: Vladimir Moravcevic <vmoravcevic@axiado.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>,
	Tzu-Hao Wei <twei@axiado.com>,
	Axiado Reviewers <linux-maintainer@axiado.com>,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: spi: axiado,ax3000-spi: Add binding for
 Axiado SPI DB controller
Message-ID: <20250915-activate-camera-a07ee5ee36ca@spud>
References: <20250915-axiado-ax3000-soc-spi-db-controller-driver-v1-0-814a1fa2a83e@axiado.com>
 <20250915-axiado-ax3000-soc-spi-db-controller-driver-v1-1-814a1fa2a83e@axiado.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PK1mfa0NSt68Ndnw"
Content-Disposition: inline
In-Reply-To: <20250915-axiado-ax3000-soc-spi-db-controller-driver-v1-1-814a1fa2a83e@axiado.com>


--PK1mfa0NSt68Ndnw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 06:11:55AM -0700, Vladimir Moravcevic wrote:
> Add documentation for Axiado Digital Block SPI controller.
>=20
> Signed-off-by: Vladimir Moravcevic <vmoravcevic@axiado.com>
> ---
>  .../devicetree/bindings/spi/axiado,ax3000-spi.yaml | 62 ++++++++++++++++=
++++++
>  1 file changed, 62 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/axiado,ax3000-spi.yaml=
 b/Documentation/devicetree/bindings/spi/axiado,ax3000-spi.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..18e4b002ac99ecdd70d724680=
e24f2867c82dd42
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/axiado,ax3000-spi.yaml
> @@ -0,0 +1,62 @@
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
> +      - const: ref_clk

Just call this clock "ref", the _clk is redundant.

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
> +         compatible =3D "axiado,ax3000-spi";
> +         reg =3D <0x00 0x80510000 0x00 0x1000>;
> +         clock-names =3D "ref_clk", "pclk";
> +         clocks =3D <&spi_clk &spi_clk>;

Why are these both the same? Additionally, please style this as "<&foo>, <&=
bar>"
with each clock in its own <>.

Cheers,
Conor.

> +         interrupt-parent =3D <&gic500>;
> +         interrupts =3D <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
> +         num-cs =3D <1>;
> +      };
> +   };
> +...
>=20
> --=20
> 2.25.1
>=20

--PK1mfa0NSt68Ndnw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMhLZAAKCRB4tDGHoIJi
0hm9AP9ZegxgxYzYrxayotLJSwJcS4Dyr32uy5ADaTb5lj/gjgEAy1nWR1tV4v6p
aHmB9hPcVs20AlkkhnBRQkBKhbSrOQ0=
=//eG
-----END PGP SIGNATURE-----

--PK1mfa0NSt68Ndnw--

