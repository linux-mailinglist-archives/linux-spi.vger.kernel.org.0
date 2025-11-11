Return-Path: <linux-spi+bounces-11153-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CBFC4C35A
	for <lists+linux-spi@lfdr.de>; Tue, 11 Nov 2025 08:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFBAE1885E0E
	for <lists+linux-spi@lfdr.de>; Tue, 11 Nov 2025 07:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40292BE059;
	Tue, 11 Nov 2025 07:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evobaaN3"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A652D5930;
	Tue, 11 Nov 2025 07:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762847804; cv=none; b=Jv/yR366jLmZVIv9H4YcaPR+BZbvYfC0+HIwTKNKsyilDZwu+l5/nr3+0QgJx20rUreUY7/3Q27EjNXNpfmff5ba9RSdxrtrWd9FfjIF50435z6p7g3C/Rt+WL4WJkkngTD5e+tZCXRFh5Gdks9zA1N03a9+JX0Tt4gRPr8/7U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762847804; c=relaxed/simple;
	bh=oF1keJKwYhxvaP6NJqrA6M6U0gmqXpD9wpQKVAj8/Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwfaFLtKx3egg23xx+U9F4nHr0AOi2wTRQh78iQkADC1njDB9X1nO0SF5vatEGlJuUkvMlHNu4yDJlJz6BoyW5/5OUijq8QRwoP755dwr3ho4yY6uRvoUqtBAFjTZyqoPW1qZnZP20TkbewXGCe8qiFLKvgtz0YTfubjYr3RNiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evobaaN3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80079C116B1;
	Tue, 11 Nov 2025 07:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762847803;
	bh=oF1keJKwYhxvaP6NJqrA6M6U0gmqXpD9wpQKVAj8/Ww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=evobaaN3/pr/xTyRkmYEEXDtrMENl8k/Br+y8LvTdXX0jV4r9Od10ACdXFboqHx4F
	 73a0zmoeV7nnlzpvy04lDwNf9Iha4eNANDeIt3N8MJidzY5ZjvvVJyrdkx+D5HD1pW
	 4dN+wwkJhfjNAaHFPtLdysLATbpyT80cIKZtq1RlZvc0PiTVYlXCiGEOo3aFkqUXwH
	 YLqENrDxNSRslZ50kGGTpPlt3ABavQF/f7oWFL/76qtWsyl1eMUa5iS9Fh8xz/Y6rD
	 BbU0ixMvr8vNo4SCDWW2oVfoG5RtaWJ0mYrNfqDa/5RWGVG3P1Ru7vSphlHVlu5CyT
	 NrcFQ4uIKcVFg==
Date: Tue, 11 Nov 2025 08:56:41 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	broonie@kernel.org, avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au, 
	venture@google.com, yuenn@google.com, benjaminfair@google.com, 
	andrew@codeconstruct.com.au, openbmc@lists.ozlabs.org, devicetree@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: spi: Convert nuvoton,npcm-pspi to DT
 schema
Message-ID: <20251111-bouncy-mahogany-skylark-c4ba1d@kuoka>
References: <20251110081457.1008316-1-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251110081457.1008316-1-tmaimon77@gmail.com>

On Mon, Nov 10, 2025 at 10:14:57AM +0200, Tomer Maimon wrote:
> Convert the Nuvoton NPCM PSPI binding to DT schema format.
> Remove the clock-name property since it is not used.

clock-name or clock-names? I clearly see the clock-names used in DTS, so
your commit msg is not correct.

Please use subject prefixes matching the subsystem. You can get them for
example with 'git log --oneline -- DIRECTORY_OR_FILE' on the directory
your patch is touching. For bindings, the preferred subjects are
explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters

> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../bindings/spi/nuvoton,npcm-pspi.txt        | 36 ----------
>  .../bindings/spi/nuvoton,npcm-pspi.yaml       | 65 +++++++++++++++++++
>  2 files changed, 65 insertions(+), 36 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt b/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt
> deleted file mode 100644
> index a4e72e52af59..000000000000
> --- a/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt
> +++ /dev/null
> @@ -1,36 +0,0 @@
> -Nuvoton NPCM Peripheral Serial Peripheral Interface(PSPI) controller driver
> -
> -Nuvoton NPCM7xx SOC support two PSPI channels.
> -
> -Required properties:
> - - compatible : "nuvoton,npcm750-pspi" for Poleg NPCM7XX.
> -				"nuvoton,npcm845-pspi" for Arbel NPCM8XX.
> - - #address-cells : should be 1. see spi-bus.txt
> - - #size-cells : should be 0. see spi-bus.txt
> - - specifies physical base address and size of the register.
> - - interrupts : contain PSPI interrupt.
> - - clocks : phandle of PSPI reference clock.
> - - clock-names: Should be "clk_apb5".
> - - pinctrl-names : a pinctrl state named "default" must be defined.
> - - pinctrl-0 : phandle referencing pin configuration of the device.
> - - resets : phandle to the reset control for this device.
> - - cs-gpios: Specifies the gpio pins to be used for chipselects.
> -            See: Documentation/devicetree/bindings/spi/spi-bus.txt
> -
> -Optional properties:
> -- clock-frequency : Input clock frequency to the PSPI block in Hz.
> -		    Default is 25000000 Hz.

You dropped this property. Every change done in the conversion needs to
be documented in the commit msg with explanation WHY.

> -
> -spi0: spi@f0200000 {
> -	compatible = "nuvoton,npcm750-pspi";
> -	reg = <0xf0200000 0x1000>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pspi1_pins>;
> -	#address-cells = <1>;
> -	#size-cells = <0>;
> -	interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> -	clocks = <&clk NPCM7XX_CLK_APB5>;
> -	clock-names = "clk_apb5";
> -	resets = <&rstc NPCM7XX_RESET_IPSRST2 NPCM7XX_RESET_PSPI1>
> -	cs-gpios = <&gpio6 11 GPIO_ACTIVE_LOW>;
> -};
> diff --git a/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.yaml b/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.yaml
> new file mode 100644
> index 000000000000..65ad40292408
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/nuvoton,npcm-pspi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton NPCM Peripheral SPI (PSPI) Controller
> +
> +maintainers:
> +  - Tomer Maimon <tmaimon77@gmail.com>
> +
> +allOf:
> +  - $ref: spi-controller.yaml#
> +
> +description:
> +  Nuvoton NPCM Peripheral Serial Peripheral Interface (PSPI) controller.
> +  Nuvoton NPCM7xx SOC supports two PSPI channels.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nuvoton,npcm750-pspi # Poleg NPCM7XX
> +      - nuvoton,npcm845-pspi # Arbel NPCM8XX
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description: PSPI reference clock.
> +
> +  resets:
> +    maxItems: 1
> +    description: PSPI module reset.

Drop description.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - resets
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/nuvoton,npcm7xx-clock.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/reset/nuvoton,npcm7xx-reset.h>
> +    spi0: spi@f0200000 {
> +        compatible = "nuvoton,npcm750-pspi";
> +        reg = <0xf0200000 0x1000>;
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&pspi1_pins>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&clk NPCM7XX_CLK_APB5>;
> +        resets = <&rstc NPCM7XX_RESET_IPSRST2 NPCM7XX_RESET_PSPI1>;
> +        cs-gpios = <&gpio6 11 0x1>;

Use proper GPIO defines for flags.

Best regards,
Krzysztof


