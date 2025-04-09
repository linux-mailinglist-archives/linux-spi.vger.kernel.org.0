Return-Path: <linux-spi+bounces-7474-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 566E4A81D27
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 08:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28E044631A4
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 06:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686EB1D618E;
	Wed,  9 Apr 2025 06:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpsxwpFB"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBC88F5B;
	Wed,  9 Apr 2025 06:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744180629; cv=none; b=fGifEJO3vX2Txxga1JEbjA9jxjN5Rvaxr5Nvk643ktL6K6DUPpDN/kDqh7JH3WOFPr2vB1m1ANuXVNyvmPIE65m32sdCUg/UL8gVh78tHRp7sxo2DtMlhi2t9+/QvjdE4Phv30IoxfsXFRFwDaa50a9J7TrY76OrpYcHYYJnp2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744180629; c=relaxed/simple;
	bh=ssZQLtPFOGYfzs6D9lipnWv8s9TxH2insoaGQ0AhVEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JSAjmpUjvHaCNeGMiyFvxoy8/PuZTXy5rwSxRZufGFE6G3OGL/jz6NvhngaGsTc7+xAQHuSV/3cbg9lRDSPBoGQoBoGVMuIStEdcC2OD94oqA8SehAp/kKl9pqeZYj098HRaWxVa9KzCB4BrII+sPpSGL7sNWRR//Ge36JnpKrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpsxwpFB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE19C4CEE3;
	Wed,  9 Apr 2025 06:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744180628;
	bh=ssZQLtPFOGYfzs6D9lipnWv8s9TxH2insoaGQ0AhVEo=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=VpsxwpFBmnUywW8RENY6FUNgiy7FPrdH6g7mATYs5fabujACyEHcCzMIbP4jewZeN
	 t/g/6Bdcc4sNmOvdCze2ngMUMF6qbAu9I0xKPcZeqcZjXY81BYAg4+8wcwac+isd5H
	 doeqXL4zI+qeA0WQLAGJtiWEa6EhnuqzKJnJ82AF7dtSe6rlKmQyqFtzjy1IKGAN+2
	 KzoHZlXN46qhxOSCgs1A8BW8Spw8DFFz0FjqEAUTNJ5caQfpeKa/cFcg2I1eRy3mxM
	 FszxBQWEMfURN4SjLUJjLQieqlLifFTpIoDYOYx8SLKOPX3Yi3QcUDBUqHHawZvSSs
	 4utnMnmGv7x9A==
Message-ID: <bd15c145-c175-468d-a1ac-1ad157358aea@kernel.org>
Date: Wed, 9 Apr 2025 08:37:03 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] ASoC: renesas: add MSIOF sound Documentation
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Jaroslav Kysela <perex@perex.cz>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
References: <875xjeb0wu.wl-kuninori.morimoto.gx@renesas.com>
 <87y0wa9mb2.wl-kuninori.morimoto.gx@renesas.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <87y0wa9mb2.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/04/2025 03:05, Kuninori Morimoto wrote:
> Renesas MSIOF (Clock-Synchronized Serial Interface with FIFO) can work as
> both SPI and I2S. MSIOF-I2S will use Audio Graph Card/Card2 driver which
> uses Of-Graph in DT.
> 

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching. For bindings, the preferred subjects are
explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters

A nit, subject: drop second/last, redundant "Documentation". The
"dt-bindings" prefix is already stating that these are documentation.
See also:
https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18


> MSIOF-SPI/I2S are using same DT compatible properties.
> MSIOF-I2S         uses Of-Graph for Audio-Graph-Card/Card2,
> MSIOF-SPI doesn't use  Of-Graph.
> 
> Adds MSIOF-I2S documentation for Sound.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  .../bindings/sound/renesas,msiof.yaml         | 112 ++++++++++++++++++
>  1 file changed, 112 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/renesas,msiof.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/renesas,msiof.yaml b/Documentation/devicetree/bindings/sound/renesas,msiof.yaml
> new file mode 100644
> index 000000000000..5173e80698fb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/renesas,msiof.yaml
> @@ -0,0 +1,112 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/renesas,msiof.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas MSIOF I2S controller
> +
> +maintainers:
> +  - Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> +
> +# sharing with MSIOF SPI
> +# see
> +# ${LINUX}/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        pattern: "renesas,.*-msiof"
> +  required:
> +    - compatible
> +    - port

Drop entire select.

> +
> +properties:
> +  compatible:
> +    items:
> +      - const: renesas,msiof-r8a779g0   # R-Car V4H


Use expected format of all soc compatibles. It has been always: SoC-module.

> +      - const: renesas,rcar-gen4-msiof  # generic R-Car Gen4

If you have duplicated compatibles then:
1. It rarely makes sense because you claim that two different devices
are using the same compatible. Different device, different compatible.
2. Or if this is really same device, then only one schema.

> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2

Drop these two.

> +    oneOf:

Why is this flexible?

> +      - items:
> +          - description: CPU and DMA engine registers
> +      - items:
> +          - description: CPU registers
> +          - description: DMA engine registers
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  dmas:
> +    minItems: 2
> +    maxItems: 4

Why flexible?

> +
> +  dma-names:
> +    minItems: 2
> +    maxItems: 4
> +    items:
> +      enum: [ tx, rx ]

How would that work? tx rx tx rx? And then driver requests 'tx' (by
name) and what is supposed to be returned?

> +
> +  port:
> +    $ref: audio-graph-port.yaml#/definitions/port-base
> +    unevaluatedProperties: false
> +    patternProperties:
> +      "^endpoint(@[0-9a-f]+)?":
> +        $ref: audio-graph-port.yaml#/definitions/endpoint-base
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - power-domains
> +  - port
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/r8a779g0-cpg-mssr.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/power/r8a779g0-sysc.h>
> +
> +    dummy-codec {
> +      compatible = "test-codec";
> +
> +      port {
> +        codec_ep: endpoint {
> +          remote-endpoint = <&msiof1_snd_ep>;
> +        };
> +      };
> +    };

Drop, not related to the binding.

> +
> +    msiof1: serial@e6ea0000 {

serial means UART controller. You need name matching the class of the
device.
Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +      compatible = "renesas,msiof-r8a779g0",
> +                   "renesas,rcar-gen4-msiof";
> +      reg = <0 0xe6ea0000 0 0x0064>;
> +      interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>;
> +      clocks = <&cpg CPG_MOD 619>;
> +      dmas = <&dmac0 0x43>, <&dmac0 0x42>,
> +             <&dmac1 0x43>, <&dmac1 0x42>;
> +      dma-names = "tx", "rx", "tx", "rx";

So test it now - get DMA by name 'tx'. What do you get?

Also schema should fail here.

> +      power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
> +      resets = <&cpg 619>;
> +
> +      port {
> +        msiof1_snd_ep: endpoint {
> +          remote-endpoint = <&codec_ep>;
> +        };
> +      };
> +    };


Best regards,
Krzysztof

