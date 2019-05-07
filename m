Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0048416608
	for <lists+linux-spi@lfdr.de>; Tue,  7 May 2019 16:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfEGOwB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 May 2019 10:52:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:42648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbfEGOwB (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 7 May 2019 10:52:01 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E937C21019;
        Tue,  7 May 2019 14:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557240719;
        bh=gWUxo89d44SUn3J2Zc928qElLW2XT8oWIyto8ecrjIY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YUtgkGToiqE6/WiAbanqadOhny/GrUBQ7hVL+t9ZAGA2iEdyxQtd38ixlsU4zL3y8
         w+xWAtKkx73pRR7L41YbY9B5/OtTMHhgAsIhu49ZJsJnAEFqRaj8NF3OLQDefAIJOT
         kgi1vgjg5tXIIEE+/VLjaVz39OGKHTGmPR61RfXw=
Received: by mail-qt1-f176.google.com with SMTP id i31so19291016qti.13;
        Tue, 07 May 2019 07:51:58 -0700 (PDT)
X-Gm-Message-State: APjAAAXmaFWY69FBJT2S3EwGJp+DTxa8DD95Rdygy0m9n2nhh4gJpd5q
        Xv7412jJ/iQ1TZgLxgIk+6SQl8ySqdaWTZepEA==
X-Google-Smtp-Source: APXvYqzxIefvVeNFRFHHncOA0m/a9ZI1n2OxWxSSZe8gViWqPJVgQkyi4KCb2IcqBYcRyd+wlZBqTVovXgTwYP7ETyw=
X-Received: by 2002:aed:2471:: with SMTP id s46mr6594381qtc.144.1557240718119;
 Tue, 07 May 2019 07:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <b7a6095a5c900fa23cc54d1ccd8e8ef0ccf6e788.1557236840.git-series.maxime.ripard@bootlin.com>
 <e39713deed69735e5c02c4273bf84572aa589736.1557236840.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <e39713deed69735e5c02c4273bf84572aa589736.1557236840.git-series.maxime.ripard@bootlin.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 7 May 2019 09:51:46 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLJ+aeG8zakZokv2qfwiLBiJ-49ByGuQ_-YuTUyGXtNnQ@mail.gmail.com>
Message-ID: <CAL_JsqLJ+aeG8zakZokv2qfwiLBiJ-49ByGuQ_-YuTUyGXtNnQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] dt-bindings: spi: sun6i: Add YAML schemas
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, May 7, 2019 at 8:48 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Switch the DT binding to a YAML schema to enable the DT validation.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml | 106 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  Documentation/devicetree/bindings/spi/spi-sun6i.txt                |  44 +------------------------------
>  2 files changed, 106 insertions(+), 44 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-sun6i.txt
>
> diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
> new file mode 100644
> index 000000000000..0cd7244653a8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
> @@ -0,0 +1,106 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/allwinner,sun6i-a31-spi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Allwinner A31 SPI Controller Device Tree Bindings
> +
> +allOf:
> +  - $ref: "spi-controller.yaml"
> +
> +maintainers:
> +  - Chen-Yu Tsai <wens@csie.org>
> +  - Maxime Ripard <maxime.ripard@bootlin.com>
> +
> +properties:
> +  "#address-cells": true
> +  "#size-cells": true
> +
> +  compatible:
> +    enum:
> +      - allwinner,sun6i-a31-spi
> +      - allwinner,sun8i-h3-spi
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Bus Clock
> +      - description: Module Clock
> +
> +  clock-names:
> +    items:
> +      - const: ahb
> +      - const: mod
> +
> +  resets:
> +    maxItems: 1
> +
> +  dmas:
> +    items:
> +      - description: RX DMA Channel
> +      - description: TX DMA Channel
> +
> +  dma-names:
> +    items:
> +      - const: rx
> +      - const: tx
> +
> +  num-cs: true
> +
> +patternProperties:
> +  "^[a-z]+@[0-9]+$":

Same issues here as patch 1.

> +    properties:
> +      reg:
> +        items:
> +          minimum: 0
> +          maximum: 4
> +
> +      spi-rx-bus-width:
> +        const: 1
> +
> +      spi-tx-bus-width:
> +        const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi1: spi@1c69000 {
> +        compatible = "allwinner,sun6i-a31-spi";
> +        reg = <0x01c69000 0x1000>;
> +        interrupts = <0 66 4>;
> +        clocks = <&ahb1_gates 21>, <&spi1_clk>;
> +        clock-names = "ahb", "mod";
> +        resets = <&ahb1_rst 21>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +    };
> +
> +  - |
> +    spi0: spi@1c68000 {
> +        compatible = "allwinner,sun8i-h3-spi";
> +        reg = <0x01c68000 0x1000>;
> +        interrupts = <0 65 4>;
> +        clocks = <&ccu 30>, <&ccu 82>;
> +        clock-names = "ahb", "mod";
> +        dmas = <&dma 23>, <&dma 23>;
> +        dma-names = "rx", "tx";
> +        resets = <&ccu 15>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/spi/spi-sun6i.txt b/Documentation/devicetree/bindings/spi/spi-sun6i.txt
> deleted file mode 100644
> index 435a8e0731ac..000000000000
> --- a/Documentation/devicetree/bindings/spi/spi-sun6i.txt
> +++ /dev/null
> @@ -1,44 +0,0 @@
> -Allwinner A31/H3 SPI controller
> -
> -Required properties:
> -- compatible: Should be "allwinner,sun6i-a31-spi" or "allwinner,sun8i-h3-spi".
> -- reg: Should contain register location and length.
> -- interrupts: Should contain interrupt.
> -- clocks: phandle to the clocks feeding the SPI controller. Two are
> -          needed:
> -  - "ahb": the gated AHB parent clock
> -  - "mod": the parent module clock
> -- clock-names: Must contain the clock names described just above
> -- resets: phandle to the reset controller asserting this device in
> -          reset
> -
> -Optional properties:
> -- dmas: DMA specifiers for rx and tx dma. See the DMA client binding,
> -       Documentation/devicetree/bindings/dma/dma.txt
> -- dma-names: DMA request names should include "rx" and "tx" if present.
> -
> -Example:
> -
> -spi1: spi@1c69000 {
> -       compatible = "allwinner,sun6i-a31-spi";
> -       reg = <0x01c69000 0x1000>;
> -       interrupts = <0 66 4>;
> -       clocks = <&ahb1_gates 21>, <&spi1_clk>;
> -       clock-names = "ahb", "mod";
> -       resets = <&ahb1_rst 21>;
> -};
> -
> -spi0: spi@1c68000 {
> -       compatible = "allwinner,sun8i-h3-spi";
> -       reg = <0x01c68000 0x1000>;
> -       interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
> -       clocks = <&ccu CLK_BUS_SPI0>, <&ccu CLK_SPI0>;
> -       clock-names = "ahb", "mod";
> -       dmas = <&dma 23>, <&dma 23>;
> -       dma-names = "rx", "tx";
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&spi0_pins>;
> -       resets = <&ccu RST_BUS_SPI0>;
> -       #address-cells = <1>;
> -       #size-cells = <0>;
> -};
> --
> git-series 0.9.1
