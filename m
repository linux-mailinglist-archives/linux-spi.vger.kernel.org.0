Return-Path: <linux-spi+bounces-6805-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCEAA3396F
	for <lists+linux-spi@lfdr.de>; Thu, 13 Feb 2025 09:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38B243A4EEF
	for <lists+linux-spi@lfdr.de>; Thu, 13 Feb 2025 08:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D307A20B1FA;
	Thu, 13 Feb 2025 08:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOLQeRwy"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94C6204C1E;
	Thu, 13 Feb 2025 08:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739433629; cv=none; b=KLDpfo5IwPKkImUTNxPw8d42j4hm1dL2ihRHIqeEMEPHoYPZjOjlPVIEGq50LwLkydg6FTyRRZB0D9uLUrub7I9jFfdgTv77URrSCQolV54oCCeiAw+GAhg8+oZ/5qzcohLYqdwktGIbpAigk+UFy5KlgVqzN6mbBAn+evlITao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739433629; c=relaxed/simple;
	bh=ofm3GeRHfD0mhMeYGLNiNgASQ8oj8xT5klGiVvoPLAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfrGmfeJtGhw1kBx0YYaoJ3d6YO967TWMtucQxfCE9HBJr7+dR8jPltVJEF5J2r1bCSgtFkZqi+3FHxOy3kQKSn/O1SbVZQJ0Et81B0lySmJFKw3LPNEfOcfBv8BH7IfY+nCXqamNwk02cT9W16DsmwM0I9r+r9qKaK9EwgL4Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sOLQeRwy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 437BCC4CED1;
	Thu, 13 Feb 2025 08:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739433629;
	bh=ofm3GeRHfD0mhMeYGLNiNgASQ8oj8xT5klGiVvoPLAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sOLQeRwy+EiETM1vmVNilnA2npGC1wqQlVLtBVuB1ubAX2qac3lKEuz9B56CHnscO
	 YGK//9mviI6btp+oVzTfFVdPkTJG8Ts8b+SSM0DsDb0VKVcgsvvLPvltWuMI7jgp0p
	 d/mSN3Jy9Q/I1ivh7ajKOem54W6jPBEMZGPQkBT7GGbKy5Lw9NA9B4xIMVgVVKE8YA
	 Oc1GFc5lEPSBNDEr0lkTou/wdaQ+agF3fC9o1WaxvGpISXQEMYBTI5B3IUNss7Nq2o
	 s/n0pJXyMKCfJJdEXuyKZnukhMO6iy4EUZ6GND6amsCc6Iw2j46z6HUhrBC7nGwgWC
	 Iq+g+XO256fXA==
Date: Thu, 13 Feb 2025 09:00:25 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: patrice.chotard@foss.st.com
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, christophe.kerello@foss.st.com
Subject: Re: [PATCH v3 3/8] dt-bindings: memory-controllers: Add STM32 Octo
 Memory Manager controller
Message-ID: <20250213-adorable-conscious-pogona-4114cf@krzk-bin>
References: <20250210131826.220318-1-patrice.chotard@foss.st.com>
 <20250210131826.220318-4-patrice.chotard@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250210131826.220318-4-patrice.chotard@foss.st.com>

On Mon, Feb 10, 2025 at 02:18:21PM +0100, patrice.chotard@foss.st.com wrote:
> From: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Add bindings for STM32 Octo Memory Manager (OMM) controller.
> 
> OMM manages:
>   - the muxing between 2 OSPI busses and 2 output ports.
>     There are 4 possible muxing configurations:
>       - direct mode (no multiplexing): OSPI1 output is on port 1 and OSPI2
>         output is on port 2
>       - OSPI1 and OSPI2 are multiplexed over the same output port 1
>       - swapped mode (no multiplexing), OSPI1 output is on port 2,
>         OSPI2 output is on port 1
>       - OSPI1 and OSPI2 are multiplexed over the same output port 2
>   - the split of the memory area shared between the 2 OSPI instances.
>   - chip select selection override.
>   - the time between 2 transactions in multiplexed mode.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>  .../memory-controllers/st,stm32mp25-omm.yaml  | 201 ++++++++++++++++++
>  1 file changed, 201 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/st,stm32mp25-omm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/st,stm32mp25-omm.yaml b/Documentation/devicetree/bindings/memory-controllers/st,stm32mp25-omm.yaml
> new file mode 100644
> index 000000000000..c897e6bf490d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/st,stm32mp25-omm.yaml
> @@ -0,0 +1,201 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-controllers/st,stm32mp25-omm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STM32 Octo Memory Manager (OMM)
> +
> +maintainers:
> +  - Patrice Chotard <patrice.chotard@foss.st.com>
> +
> +description: |
> +  The STM32 Octo Memory Manager is a low-level interface that enables an
> +  efficient OCTOSPI pin assignment with a full I/O matrix (before alternate
> +  function map) and multiplex of single/dual/quad/octal SPI interfaces over
> +  the same bus. It Supports up to:
> +    - Two single/dual/quad/octal SPI interfaces
> +    - Two ports for pin assignment
> +
> +properties:
> +  compatible:
> +    const: st,stm32mp25-omm
> +
> +  "#address-cells":
> +    const: 2
> +
> +  "#size-cells":
> +    const: 1
> +
> +  ranges:
> +    description: |
> +      Reflects the memory layout with four integer values per OSPI instance.
> +      Format:
> +      <chip-select> 0 <registers base address> <size>
> +    minItems: 2
> +    maxItems: 2
> +
> +  reg:
> +    items:
> +      - description: OMM registers
> +      - description: OMM memory map area
> +
> +  reg-names:
> +    items:
> +      - const: regs
> +      - const: memory_map
> +
> +  memory-region:
> +    description: |
> +      Memory region shared between the 2 OCTOSPI instance.
> +      One or two phandle to a node describing a memory mapped region
> +      depending of child number.
> +    minItems: 1
> +    maxItems: 2
> +
> +  memory-region-names:
> +    description: |
> +      OCTOSPI instance's name to which memory region is associated
> +    items:
> +      enum: [ospi1, ospi2]
> +    minItems: 1
> +    maxItems: 2
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  access-controllers:
> +    maxItems: 1
> +
> +  st,syscfg-amcr:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: |
> +      The Address Mapping Control Register (AMCR) is used to split the 256MB
> +      memory map area shared between the 2 OSPI instance. The Octo Memory
> +      Manager sets the AMCR depending of the memory-region configuration.
> +      The memory split bitmask description is:
> +        - 000: OCTOSPI1 (256 Mbytes), OCTOSPI2 unmapped
> +        - 001: OCTOSPI1 (192 Mbytes), OCTOSPI2 (64 Mbytes)
> +        - 010: OCTOSPI1 (128 Mbytes), OCTOSPI2 (128 Mbytes)
> +        - 011: OCTOSPI1 (64 Mbytes), OCTOSPI2 (192 Mbytes)
> +        - 1xx: OCTOSPI1 unmapped, OCTOSPI2 (256 Mbytes)
> +    items:
> +      - description: phandle to syscfg
> +      - description: register offset within syscfg
> +      - description: register bitmask for memory split
> +
> +  st,omm-req2ack-ns:
> +    description: |
> +      In multiplexed mode (MUXEN = 1), this field defines the time in
> +      nanoseconds between two transactions.

default: ?

> +
> +  st,omm-cssel-ovr:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Configure the chip select selector override for the 2 OCTOSPIs.
> +      - 0: OCTOSPI1 chip select send to NCS1 OCTOSPI2 chip select send to NCS1
> +      - 1: OCTOSPI1 chip select send to NCS2 OCTOSPI2 chip select send to NCS1
> +      - 2: OCTOSPI1 chip select send to NCS1 OCTOSPI2 chip select send to NCS2
> +      - 3: OCTOSPI1 chip select send to NCS2 OCTOSPI2 chip select send to NCS2
> +    minimum: 0
> +    maximum: 3

default: ?

> +
> +  st,omm-mux:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Configure the muxing between the 2 OCTOSPIs busses and the 2 output ports.
> +      - 0: direct mode, default

Don't repeat constraints in free form text.

> +      - 1: mux OCTOSPI1 and OCTOSPI2 to port 1
> +      - 2: swapped mode
> +      - 3: mux OCTOSPI1 and OCTOSPI2 to port 2
> +    minimum: 0
> +    maximum: 3

default: ?

None of them are required, so usually we expect defaults.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


