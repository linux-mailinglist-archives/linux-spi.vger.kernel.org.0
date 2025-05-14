Return-Path: <linux-spi+bounces-8122-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B08AB7742
	for <lists+linux-spi@lfdr.de>; Wed, 14 May 2025 22:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59183867310
	for <lists+linux-spi@lfdr.de>; Wed, 14 May 2025 20:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C440629673B;
	Wed, 14 May 2025 20:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgX7UJ0O"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957421D7E4A;
	Wed, 14 May 2025 20:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747255321; cv=none; b=HRDIEAY50E4kZ9dU28/8/Ut2fXwUzEocDZVxTX6/8kxlqqIzrpLBI6HsJ8SSvutSXZYjrsFxbRUfFprsoDTndF1p4abEok3JT4GoXFGOm38jYvbQQRuUrBb49HAn95CY2FsLzXRbLm0s08Ndh63ai3eUaLCFzi9NyP5hzMkyQ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747255321; c=relaxed/simple;
	bh=1nE6gDM710mArLvk8E1p58a4DYvORFAG2fv7jv7gJYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=li56WdVennGJbGJ8m2tfPjIovZqOgVNa6dnV/31SQf/11y28mxRb9mb+3vdBVsqKKvk7FesfKoRdp6Avq8URUxbioD+4kOtuaCQOHoLx80EHSJBFjS8Aqk1Iwilr9goHWzH+4A9GdQo3AUiZJiflUpWXDjW4kvTa02azN6C4vsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgX7UJ0O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF31FC4CEE3;
	Wed, 14 May 2025 20:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747255321;
	bh=1nE6gDM710mArLvk8E1p58a4DYvORFAG2fv7jv7gJYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TgX7UJ0ORV80PdKWdTiVaSKiLqiJu8KEgd1oOECl94udYTE+vNMVKO5p1LwC6znmp
	 l+NzChA2KQUGy394FcGExuTm+J19Kh7o2NS7gFbsUIkrFpSXCXjswnBagsNxWF+M3r
	 k9QwzPaOs46gYBBpUsJozyfWY/nAnBr6rWhUIJXhV5Jz290HA1ZaTaPHZFQztZ7AhP
	 9Py47ERmQVc3xHHs/2UCqhcpytDcjoosUJc7u6cqRE+h5JACDZVCq8B+vexn7ppDf8
	 LYRlWkjcZmM12lV+GYRYjZHs4jGHm2ewRANAofA9ZQNLFSFFomlBCeptXiCDBBEB5e
	 cXu+FW0R+FoAA==
Date: Wed, 14 May 2025 15:41:59 -0500
From: Rob Herring <robh@kernel.org>
To: Alexey Charkov <alchark@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: spi: Add VIA/WonderMedia serial flash
 controller
Message-ID: <20250514204159.GA2988411-robh@kernel.org>
References: <20250510-wmt-sflash-v1-0-02a1ac6adf12@gmail.com>
 <20250510-wmt-sflash-v1-1-02a1ac6adf12@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250510-wmt-sflash-v1-1-02a1ac6adf12@gmail.com>

On Sat, May 10, 2025 at 11:42:21PM +0400, Alexey Charkov wrote:
> Add a binding for the serial flash controller found on VIA/WonderMedia
> SoCs, which provides semi-transparent access to SPI NOR chips by
> mapping their contents to the physical CPU address space.
> 
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> ---
>  .../devicetree/bindings/spi/via,vt8500-sflash.yaml | 122 +++++++++++++++++++++
>  MAINTAINERS                                        |   1 +
>  2 files changed, 123 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/via,vt8500-sflash.yaml b/Documentation/devicetree/bindings/spi/via,vt8500-sflash.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..d2ea0dacdd56118c0cb5a1cb510ceb7591e1e5ca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/via,vt8500-sflash.yaml
> @@ -0,0 +1,122 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/via,vt8500-sflash.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: VIA/WonderMedia serial flash controller
> +
> +description:
> +  This controller is used on VIA/WonderMedia SoCs such as VIA VT8500,
> +  WonderMedia WM8850 and similar. It provides a semi-transparent interface
> +  for reading and writing SPI NOR chip contents via a physical memory map,
> +  abstracting away all SPI communication, while also providing a direct
> +  mechanism for issuing "programmable commands" to the underlying SPI chip
> +
> +maintainers:
> +  - Alexey Charkov <alchark@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - via,vt8500-sflash
> +      - wm,wm8505-sflash
> +      - wm,wm8650-sflash
> +      - wm,wm8750-sflash
> +      - wm,wm8850-sflash
> +
> +  reg:
> +    items:
> +      - description: MMIO registers region of the controller
> +      - description:
> +          Physical memory region within which the controller will map the
> +          flash contents of chip 0 for reading and writing. If the flash
> +          size is smaller than this region, it will be mapped at its end.
> +          Note that if this chip is used as the boot device (as is most
> +          often the case), the boot ROM maps it at the very end of the
> +          CPU address space (i.e. ending at 0xffffffff)

Period needed on the end.

> +      - description:
> +          Physical memory region within which the controller will map the
> +          flash contents of chip 1 for reading and writing. If the flash
> +          size is smaller than this region, it will be mapped at its end

Period needed on the end.

> +
> +  reg-names:
> +    items:
> +      - const: io
> +      - const: chip0-mmap
> +      - const: chip1-mmap
> +
> +  clocks:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0

This follows the SPI binding, right? Drop these 2 and add a $ref to 
spi-controller.yaml.

> +
> +patternProperties:
> +  "^flash@[0-1]$":
> +    type: object
> +    additionalProperties: true
> +
> +    properties:
> +      reg:
> +        minimum: 0
> +        maximum: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    sflash: spi-nor-controller@d8002000 {

spi@...

> +        compatible = "wm,wm8850-sflash";
> +        reg = <0xd8002000 0x400>,
> +              <0xff800000 0x800000>,
> +              <0xef800000 0x800000>;
> +        reg-names = "io", "chip0-mmap", "chip1-mmap";
> +        clocks = <&clksf>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        flash@0 {
> +            compatible = "jedec,spi-nor";
> +            reg = <0>;
> +
> +            partitions {
> +                compatible = "fixed-partitions";
> +                #address-cells = <1>;
> +                #size-cells = <1>;
> +
> +                partition@0 {
> +                    label = "U-boot";

The somewhat standard value here is 'u-boot'.

> +                    reg = <0 0x50000>;
> +                    read-only;
> +                };
> +
> +                partition@1 {
> +                    label = "U-boot environment 1";

u-boot-env

> +                    reg = <0x50000 0x10000>;
> +                };
> +
> +                partition@2 {
> +                    label = "U-boot environment 2";

alt-u-boot-env or u-boot-env-backup?

> +                    reg = <0x60000 0x10000>;
> +                };
> +
> +                partition@3 {
> +                    label = "W-load";
> +                    reg = <0x70000 0x10000>;
> +                    read-only;
> +                };
> +            };
> +        };
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6dbdf02d6b0c9357ad1da520a0f6c16b7f38f879..f09c457bbfc5ef71a3f8379c111bac52b767cbbc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3475,6 +3475,7 @@ F:	Documentation/devicetree/bindings/hwinfo/via,vt8500-scc-id.yaml
>  F:	Documentation/devicetree/bindings/i2c/wm,wm8505-i2c.yaml
>  F:	Documentation/devicetree/bindings/interrupt-controller/via,vt8500-intc.yaml
>  F:	Documentation/devicetree/bindings/pwm/via,vt8500-pwm.yaml
> +F:	Documentation/devicetree/bindings/spi/via,vt8500-sflash.yaml
>  F:	arch/arm/boot/dts/vt8500/
>  F:	arch/arm/mach-vt8500/
>  F:	drivers/clocksource/timer-vt8500.c
> 
> -- 
> 2.49.0
> 

