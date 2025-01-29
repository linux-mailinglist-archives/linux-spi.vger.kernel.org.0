Return-Path: <linux-spi+bounces-6557-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 127C3A2184E
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jan 2025 08:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 053863A3DC8
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jan 2025 07:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A97191F84;
	Wed, 29 Jan 2025 07:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXKEsbR/"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113BA15B54C;
	Wed, 29 Jan 2025 07:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738137153; cv=none; b=IPZeR6Zf5pOuoynRXhzjh1nHRr2N6jyLPgp/trPC4AMXKHFuGXQO0WEDbv2uW3rHOVc7uLg1JLW5RKimZ+SL4eq47+RzqKef14Fp4kf2rMTwwxamAG5YIAPZBgGn7Ob0FwUX/xiZYNFImwmJ/Qdn/Aj0/FksOuylp4EO0NKLbB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738137153; c=relaxed/simple;
	bh=AoeffIw3Nz9eylEG8U+KY4L6HWrpPGbI3A9MidQQ4KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G97s098Z9CLI9AVMTL9NZ6C0T/15sO3XGy/mR+m6AKsFvAycfbGqOd4Bxudatkbnh3eMAFy53F+Z3FCdjG8mENvTKE/lyDH28F3HXBa2Q1d1nRi67mDD+HZSkJwl1kTxP9+TqsrtTnp00wa59rR2uvI4WR0bGDhkic6mpMbQFMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXKEsbR/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5407C4CED3;
	Wed, 29 Jan 2025 07:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738137152;
	bh=AoeffIw3Nz9eylEG8U+KY4L6HWrpPGbI3A9MidQQ4KA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RXKEsbR/CmnIwiJ0DmeDT92ebn1xGGok6hL2scYegnn9ypeujve8yDw/GsvI1lZhC
	 ypE8AB0sc+pBfGGcMxnpompoAbsV6DAsF4VTanKZZ6w8cExHr3Gf8NOAbXY7MnR35I
	 8FdEmV2sg5dxRiYlTopsxdingXqzhYVvlaoMLkboy8UY8jYEH5GkvXbRfdjuMbuMSi
	 HCDbRzVjDxCf3lERmp05J+r8T19ydqvwVE0r1FZNgLC4/+nSjbTQ1cJw8qMNUYkaes
	 d8YPVB+VYm9j0zj0XeIopsYB88zvUldsuqiEIUuKawM7pfl+vu1+PDjhjvJaCgRjkq
	 1pOeJfNYpnScQ==
Date: Wed, 29 Jan 2025 08:52:29 +0100
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
Subject: Re: [PATCH v2 3/9] dt-bindings: memory-controllers: Add STM32 Octo
 Memory Manager controller
Message-ID: <20250129-hilarious-glittering-mustang-fb5471@krzk-bin>
References: <20250128081731.2284457-1-patrice.chotard@foss.st.com>
 <20250128081731.2284457-4-patrice.chotard@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250128081731.2284457-4-patrice.chotard@foss.st.com>

On Tue, Jan 28, 2025 at 09:17:25AM +0100, patrice.chotard@foss.st.com wrote:
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
>  .../memory-controllers/st,stm32-omm.yaml      | 190 ++++++++++++++++++
>  1 file changed, 190 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/st,stm32-omm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/st,stm32-omm.yaml b/Documentation/devicetree/bindings/memory-controllers/st,stm32-omm.yaml
> new file mode 100644
> index 000000000000..7e0b150e0005
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/st,stm32-omm.yaml


Filename as compatible, so st,stm32mp25-omm.yaml

You already received this comment.

> @@ -0,0 +1,190 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-controllers/st,stm32-omm.yaml#
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

Do you always have two children? If so, this should have maxItems.

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
> +    description: Phandle to node describing memory-map region to used.
> +    minItems: 1
> +    maxItems: 2

List the items with description instead with optional minItems. Why is
this flexible in number of items?

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
> +      Format is phandle to syscfg / register offset within syscfg / memory split
> +      bitmask.

Don't repeat constraints in free form text.

> +      The memory split bitmask description is:
> +        - 000: OCTOSPI1 (256 Mbytes), OCTOSPI2 unmapped
> +        - 001: OCTOSPI1 (192 Mbytes), OCTOSPI2 (64 Mbytes)
> +        - 010: OCTOSPI1 (128 Mbytes), OCTOSPI2 (128 Mbytes)
> +        - 011: OCTOSPI1 (64 Mbytes), OCTOSPI2 (192 Mbytes)
> +        - 1xx: OCTOSPI1 unmapped, OCTOSPI2 (256 Mbytes)
> +    items:
> +      minItems: 3
> +      maxItems: 3

You do not have there three phandles, but one. Look how other bindings
encode this.

> +
> +  st,omm-req2ack-ns:
> +    description: |
> +      In multiplexed mode (MUXEN = 1), this field defines the time in
> +      nanoseconds between two transactions.
> +
> +  st,omm-cssel-ovr:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Configure the chip select selector override for the 2 OCTOSPIs.
> +      The 2 bits mask muxing description is:

bit mask of size? 1? Then just enum string, no?

> +        -bit 0: Chip select selector override setting for OCTOSPI1
> +          0x0: the chip select signal from OCTOSPI1 is sent to NCS1
> +          0x1: the chip select signal from OCTOSPI1 is sent to NCS2
> +        -bit 1: Chip select selector override setting for OCTOSPI2
> +          0x0: the chip select signal from OCTOSPI2 is sent to NCS1
> +          0x1: the chip select signal from OCTOSPI2 is sent to NCS2

I don't understand why this is so complicated. First, can you even send
chip select OCTOSPI1 to NCS2 and use 0x1 as mux? or 0x3 as mux?

Second, your bitmask value of "0x0" means OCTOSPI1 and OCTOSPI2 are sent
to NCS1 (whateveer NCS is). This sounds wrong, but your binding says is
perfectly correct. Is that true? Is that correct binding?


> +
> +  st,omm-mux:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Configure the muxing between the 2 OCTOSPIs busses and the 2 output ports.
> +      The muxing 2 bits mask description is:
> +        - 0x0: direct mode, default
> +        - 0x1: mux OCTOSPI1 and OCTOSPI2 to port 1
> +        - 0x2: swapped mode
> +        - 0x3: mux OCTOSPI1 and OCTOSPI2 to port 2

So these are just 1-3, not hex, not bitmasks. Missing constraints or
enum.




> +
> +  power-domains:
> +    maxItems: 1
> +
> +patternProperties:
> +  ^spi@[a-f0-9]+$:
> +    type: object
> +    $ref: "/schemas/spi/st,stm32mp25-ospi.yaml#"

Not much improved. I think you got here comment to drop quotes. That's
the second comment you ignored.

> +    description: Required spi child node
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +  - clocks
> +  - st,syscfg-amcr
> +  - ranges
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/st,stm32mp25-rcc.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/reset/st,stm32mp25-rcc.h>
> +    ommanager@40500000 {
> +      compatible = "st,stm32mp25-omm";
> +      reg = <0x40500000 0x400>, <0x60000000 0x10000000>;
> +      reg-names = "regs", "memory_map";
> +      memory-region = <&mm_ospi1>, <&mm_ospi2>;
> +      pinctrl-names = "default", "sleep";

pinctrl-names after pinctrl-1

> +      pinctrl-0 = <&ospi_port1_clk_pins_a
> +                   &ospi_port1_io03_pins_a
> +                   &ospi_port1_cs0_pins_a>;
> +      pinctrl-1 = <&ospi_port1_clk_sleep_pins_a
> +                   &ospi_port1_io03_sleep_pins_a
> +                   &ospi_port1_cs0_sleep_pins_a>;
> +      clocks = <&rcc CK_BUS_OSPIIOM>;
> +      resets = <&rcc OSPIIOM_R>;
> +      st,syscfg-amcr = <&syscfg 0x2c00 0x7>;
> +      st,omm-req2ack-ns = <0x0>;

Time is never expressed in hex, we do not follow 0x18h clock in
continental Europe.

> +      st,omm-mux = <0x0>;
> +      st,omm-cssel-ovr = <0x0>;
> +      access-controllers = <&rifsc 111>;
> +      power-domains = <&CLUSTER_PD>;
> +
> +      #address-cells = <2>;
> +      #size-cells = <1>;
> +
> +      ranges = <0 0 0x40430000 0x400>,
> +               <1 0 0x40440000 0x400>;

ranges always go after reg/reg-names.

> +
> +      spi@40430000 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        compatible = "st,stm32mp25-ospi";

Please follow DTS coding style in ordering your properties.



Best regards,
Krzysztof


