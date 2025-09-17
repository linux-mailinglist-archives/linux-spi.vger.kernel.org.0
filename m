Return-Path: <linux-spi+bounces-10093-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F111B823F5
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 01:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5E041C22506
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 23:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3AA3112D1;
	Wed, 17 Sep 2025 23:15:28 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BBE2EAD0A;
	Wed, 17 Sep 2025 23:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758150928; cv=none; b=QNV/9PJCOtvKz4e3BbechByGB3RMxWmeI4s5l1J+rUL80426XwFNASWXgRgwhXjbivTxDQaibuWTLb08phuABNRJqEWyCBL4FxmIsT5vR4Y7ITEv0qLs62PlBanDSQo3c9y1ECLBgObwFLMJlIf7+fTXEWJIZa9kyjsyn/quiT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758150928; c=relaxed/simple;
	bh=2WP/iCz2b/TLcOlSPc8/Sf8CUlw58R0/e/0mPN/asFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSjzuqPyWozqjh42sRK4c2Fz2B8QOI15LhoDFhTrXUW0bmtFZkPgQW+UiWdb9W8JQYWPzrWWHTaW27PvpgwWir39bunDfycAe8sbI3QYkihaEvWQmi0CAz5iEyDOggYnsgiQ2E6efTOARvWNSIc6R0+/gi80lX8HE1ll/f+uUyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [180.158.240.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 34C21341EBA;
	Wed, 17 Sep 2025 23:15:24 +0000 (UTC)
Date: Thu, 18 Sep 2025 07:15:20 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Alex Elder <elder@riscstar.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	p.zabel@pengutronix.de, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: spi: add SpacemiT K1 SPI support
Message-ID: <20250917231520-GYA1269891@gentoo.org>
References: <20250917220724.288127-1-elder@riscstar.com>
 <20250917220724.288127-2-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917220724.288127-2-elder@riscstar.com>

Hi Alex,

On 17:07 Wed 17 Sep     , Alex Elder wrote:
> Add support for the SPI controller implemented by the SpacemiT K1 SoC.
> 
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
>  .../bindings/spi/spacemit,k1-spi.yaml         | 94 +++++++++++++++++++
>  1 file changed, 94 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml b/Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
> new file mode 100644
> index 0000000000000..5abd4fe268da9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
> @@ -0,0 +1,94 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/spacemit,k1-spi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SpacemiT K1 SoC Serial Peripheral Interface (SPI)
> +
> +maintainers:
> +  - Alex Elder <elder@kernel.org>
> +
> +description:
> +  The SpacemiT K1 SoC implements a SPI controller that has two 32-entry
> +  FIFOs, for transmit and receive.  Details are currently available in
> +  section 18.2.1 of the K1 User Manual, found in the SpacemiT Keystone
> +  K1 Documentation[1].  The controller transfers words using PIO.  DMA
> +  transfers are supported as well, if both TX and RX DMA channels are
> +  specified,
> +
> +  [1] https://developer.spacemit.com/documentation
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - spacemit,k1-spi
one enum is effectively equal to const..
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Core clock
> +      - description: Bus clock
> +
> +  clock-names:
> +    items:
> +      - const: core
> +      - const: bus
> +
> +  resets:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  dmas:
> +    items:
> +      - description: RX DMA channel
> +      - description: TX DMA channel
> +
> +  dma-names:
> +    items:
> +      - const: rx
> +      - const: tx
> +
> +  spacemit,k1-ssp-id:
> +    description: SPI controller number
> +    $ref: /schemas/types.yaml#/definitions/uint32
could you explain a little bit why this vendor specific property should
be introduced? I took a look at the code, and didn't get the reason
behind.. or what's the problem of simply using "pdev->id"?

we should really be careful to introduce vendor specific property..

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - resets
> +  - interrupts
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +
> +    #include <dt-bindings/clock/spacemit,k1-syscon.h>
> +    spi3: spi@d401c000 {
label not needed for DT example
> +        compatible = "spacemit,k1-spi";
> +        reg = <0xd401c000 0x30>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        clocks = <&syscon_apbc CLK_SSP3>,
> +                 <&syscon_apbc CLK_SSP3_BUS>;
> +        clock-names = "core",
> +                      "bus";
> +        resets = <&syscon_apbc RESET_SSP3>;
> +        interrupts-extended = <&plic 55>;
> +        spacemit,k1-ssp-id = <3>;
> +        dmas = <&pdma 20>,
> +               <&pdma 19>;
> +        dma-names = "rx",
> +                    "tx";
..
> +        status = "disabled";
ditto, drop it
> +    };
> -- 
> 2.48.1
> 

-- 
Yixun Lan (dlan)

