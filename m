Return-Path: <linux-spi+bounces-6527-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C60A21071
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jan 2025 19:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A553F188A636
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jan 2025 18:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161A41E32D5;
	Tue, 28 Jan 2025 18:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMuWqg4R"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7EF1DE88C;
	Tue, 28 Jan 2025 18:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738087355; cv=none; b=hRwUWQfJ7YE5s2S+JH9TXyNUeMlcidZiexojy3JIWcC5fq3LNh3RQ5KCLiFyCLY3PKfHDrP3vSVrLfynChCRU3F9ZrwWyD5fIGlMw8DBb7iEAJW/bgXrB05qvaq+/PjcNROpNdSNcRmnp5E98NUlMAoTIdlffFTthobP+nXUKNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738087355; c=relaxed/simple;
	bh=17sm+X5zyYge664zgijjG3INLik8MXrleSdffgx7+sM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EshAgZitaJLeuoQDZBlgLNeNg00Fkxh3PPuZztpS9UnkjUPyzGgnxn9p1b5p48Pc18RyJHzn53ubOzm0jFuVYfDvAZpLKay6LsLnHaCyZFwci+gIiTp/hJcpBsFy1IxvB92wdTszvKezkBx2iZSIib4eoR2q/0I2x6BRiIGBRwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMuWqg4R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1C5C4CED3;
	Tue, 28 Jan 2025 18:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738087353;
	bh=17sm+X5zyYge664zgijjG3INLik8MXrleSdffgx7+sM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XMuWqg4RYnrqYMaIA/ZcIhJErUloNcadylvAlyJ4i9jsnhEmcRFaEO2o7xl8Ja3iy
	 tBWkCZAQ5y5NziPO2hZOgxCC3JFFI/rJxezpT8UBtHs3SIVOszdw4j6Sa7qhAa7qn/
	 WiYbmsI7ax4600FToUWN2gu2ivn4HCCaenBf2WxpCFKyUr437gEGFDggU65b6vkxgd
	 LK4Xy3n2XBXGHn2gbCBBvyMU+WFdhFU4j09xNsRVjagaGFRX92Nk8jQywRUleI6Skk
	 L/wXxLWnMaElYz1nZoTyWrAaUPRu9tMWIyIYrzcQHeFu+hwDWquzTQmYp/FyRyZ09e
	 nbXueTytgVkCA==
Date: Tue, 28 Jan 2025 18:02:27 +0000
From: Conor Dooley <conor@kernel.org>
To: patrice.chotard@foss.st.com
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	christophe.kerello@foss.st.com
Subject: Re: [PATCH v2 1/9] dt-bindings: spi: Add STM32 OSPI controller
Message-ID: <20250128-panama-manly-a753d91c297c@spud>
References: <20250128081731.2284457-1-patrice.chotard@foss.st.com>
 <20250128081731.2284457-2-patrice.chotard@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xfUYpCROzbnYgVkv"
Content-Disposition: inline
In-Reply-To: <20250128081731.2284457-2-patrice.chotard@foss.st.com>


--xfUYpCROzbnYgVkv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 09:17:23AM +0100, patrice.chotard@foss.st.com wrote:
> From: Patrice Chotard <patrice.chotard@foss.st.com>
>=20
> Add device tree bindings for the STM32 OSPI controller.
>=20
> Main features of the Octo-SPI controller :
>   - support sNOR / sNAND / HyperRAM=E2=84=A2 and HyperFlash=E2=84=A2 devi=
ces.
>   - Three functional modes: indirect, automatic-status polling,
>     memory-mapped.
>   - Up to 4 Gbytes of external memory can be addressed in indirect
>     mode (per physical port and per CS), and up to 256 Mbytes in
>     memory-mapped mode (combined for both physical ports and per CS).
>   - Single-, dual-, quad-, and octal-SPI communication.
>   - Dual-quad communication.
>   - Single data rate (SDR) and double transfer rate (DTR).
>   - Maximum target frequency is 133 MHz for SDR and 133 MHz for DTR.
>   - Data strobe support.
>   - DMA channel for indirect mode.
>   - Double CS mapping that allows two external flash devices to be
>     addressed with a single OCTOSPI controller mapped on a single
>     OCTOSPI port.
>=20
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>  .../bindings/spi/st,stm32mp25-ospi.yaml       | 102 ++++++++++++++++++
>  1 file changed, 102 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/st,stm32mp25-os=
pi.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/spi/st,stm32mp25-ospi.yaml=
 b/Documentation/devicetree/bindings/spi/st,stm32mp25-ospi.yaml
> new file mode 100644
> index 000000000000..f1d539444673
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/st,stm32mp25-ospi.yaml
> @@ -0,0 +1,102 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/st,stm32mp25-ospi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectronics STM32 Octal Serial Peripheral Interface (OSPI)
> +
> +maintainers:
> +  - Patrice Chotard <patrice.chotard@foss.st.com>
> +
> +allOf:
> +  - $ref: spi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: st,stm32mp25-ospi
> +
> +  reg:
> +    maxItems: 1
> +
> +  memory-region:
> +    maxItems: 1

Whatever about not having descriptions for clocks or reg when there's
only one, I think a memory region should be explained.

> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  resets:
> +    items:
> +      - description: phandle to OSPI block reset
> +      - description: phandle to delay block reset
> +
> +  dmas:
> +    maxItems: 2
> +
> +  dma-names:
> +    items:
> +      - const: tx
> +      - const: rx
> +
> +  st,syscfg-dlyb:
> +    description: phandle to syscon block
> +      Use to set the OSPI delay block within syscon to
> +      tune the phase of the RX sampling clock (or DQS) in order
> +      to sample the data in their valid window and to
> +      tune the phase of the TX launch clock in order to meet setup
> +      and hold constraints of TX signals versus the memory clock.
> +    $ref: /schemas/types.yaml#/definitions/phandle-array

Why do you need a phandle here? I assume looking up by compatible ain't
possible because you have multiple controllers on the SoC? Also, I don't
think your copy-paste "phandle to" stuff here is accurate:
      st,syscfg-dlyb =3D <&syscfg 0x1000>;
There's an offset here that you don't mention in your description.

> +    items:
> +      maxItems: 1
> +
> +  access-controllers:
> +    description: phandle to the rifsc device to check access right
> +      and in some cases, an additional phandle to the rcc device for
> +      secure clock control

This should be described using items rather than a free-form list.

> +    minItems: 1
> +    maxItems: 2
> +
> +  power-domains:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - interrupts
> +  - st,syscfg-dlyb
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/st,stm32mp25-rcc.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/reset/st,stm32mp25-rcc.h>
> +    spi@40430000 {

nit: you missing a blank line here.

> +      compatible =3D "st,stm32mp25-ospi";
> +      reg =3D <0x40430000 0x400>;
> +      memory-region =3D <&mm_ospi1>;
> +      interrupts =3D <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
> +      dmas =3D <&hpdma 2 0x62 0x00003121 0x0>,
> +             <&hpdma 2 0x42 0x00003112 0x0>;
> +      dma-names =3D "tx", "rx";
> +      clocks =3D <&scmi_clk CK_SCMI_OSPI1>;
> +      resets =3D <&scmi_reset RST_SCMI_OSPI1>, <&scmi_reset RST_SCMI_OSP=
I1DLL>;
> +      access-controllers =3D <&rifsc 74>;
> +      power-domains =3D <&CLUSTER_PD>;
> +      st,syscfg-dlyb =3D <&syscfg 0x1000>;
> +
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      flash@0 {
> +        compatible =3D "jedec,spi-nor";
> +        reg =3D <0>;
> +        spi-rx-bus-width =3D <4>;
> +        spi-max-frequency =3D <108000000>;
> +      };
> +    };
> --=20
> 2.25.1
>=20

--xfUYpCROzbnYgVkv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ5kbswAKCRB4tDGHoIJi
0lcIAQDU7HTXvB+po6yvcl9praNiHvh+3GS9lcFqfp1k7eAIrwD/Vghbo+R30BML
AU87FB9nIF3rIe0J6yZGyW+mcijJaws=
=Sliy
-----END PGP SIGNATURE-----

--xfUYpCROzbnYgVkv--

