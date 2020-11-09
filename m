Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4FA2ABFEC
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 16:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbgKIPg2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 10:36:28 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35091 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgKIPg2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Nov 2020 10:36:28 -0500
Received: by mail-ot1-f67.google.com with SMTP id n11so9314497ota.2;
        Mon, 09 Nov 2020 07:36:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SQjVmuqZMbhgGoRanGDNbmuAYzqzxVPrj4Zn4x0esuw=;
        b=ApyPCVZ8Lee3+xUL3/1TVLoDm7bdpiFX615hXRmWzkScUqjP0284++VpcLF6KAeRJZ
         Fqsgt72OAOr3ZwtmQGvwFoJMh45zcn9meUPRlutcistbUcmoUBaAfvqkjUtB6EO4erNj
         rMFmBw5qHwMJZUSkstHJzUBvFkEdOevaopBRYq/MbL+RBXViO0mWPOB+lWAXwHkYQzK6
         BKZAb2nSy1qUEAsWTVpYfMjJj2Q7Iep8oAvHn2k819imGf/dh1W/lIYziS8RlagvhZwO
         voa1aUa8xUA0fspmp+nstxgFXdfZBb9RGlvJPBPL3Q/mpAP7zpE3z7eU0lEKREvOIdlt
         RRww==
X-Gm-Message-State: AOAM531C0JqsdWcT/bMRG+mS9xLvoUrhfZaq7xevdlmVnDfIhNnjFz/m
        yRaFz+L5GBFH1FkdwUXB8wTeeTy95w==
X-Google-Smtp-Source: ABdhPJxG1AyzsSxmwoQK4EuOrEbQSq+zby2rybDTeCp2clGuek5+YBiOKuVOn0QvG/RG+K1PlOPQ4Q==
X-Received: by 2002:a9d:62c9:: with SMTP id z9mr11030709otk.18.1604936187448;
        Mon, 09 Nov 2020 07:36:27 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l8sm1085447oof.2.2020.11.09.07.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 07:36:26 -0800 (PST)
Received: (nullmailer pid 1334806 invoked by uid 1000);
        Mon, 09 Nov 2020 15:36:25 -0000
Date:   Mon, 9 Nov 2020 09:36:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH 24/32] dt-bindings: Document kendryte,k210-fpioa bindings
Message-ID: <20201109153625.GB1330401@bogus>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-25-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201107081420.60325-25-damien.lemoal@wdc.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, Nov 07, 2020 at 05:14:12PM +0900, Damien Le Moal wrote:
> Document the device tree bindings for the Kendryte K210 SoC Fully
> Programmable IO Array (FPIOA) pinctrl driver in
> Documentation/devicetree/bindings/pinctrl/kendryte,k210-fpioa.yaml
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  .../bindings/pinctrl/kendryte,k210-fpioa.yaml | 106 ++++++++++++++++++
>  1 file changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/kendryte,k210-fpioa.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/kendryte,k210-fpioa.yaml b/Documentation/devicetree/bindings/pinctrl/kendryte,k210-fpioa.yaml
> new file mode 100644
> index 000000000000..8730add88ee0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/kendryte,k210-fpioa.yaml
> @@ -0,0 +1,106 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/kendryte,k210-fpioa.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Kendryte K210 FPIOA (Fully Programmable IO Array) Device Tree Bindings
> +
> +maintainers:
> +  - Damien Le Moal <damien.lemoal@wdc.com>
> +
> +description:
> +  The Kendryte K210 SoC Fully Programmable IO Array controller allows assiging
> +  any of 256 possible functions to any of 48 IO pins. Pin function configuration
> +  is performed on a per-pin basis.
> +
> +properties:
> +  compatible:
> +    const: kendryte,k210-fpioa
> +
> +  reg:
> +    description: FPIOA controller register space base address and size
> +
> +  clocks:
> +    minItems: 2
> +    maxItems: 2

Can drop these. Implied by 'items' length.

> +    items:
> +      - description: Controller reference clock source
> +      - description: APB interface clock source
> +
> +  clock-names:
> +    minItems: 2
> +    maxItems: 2
> +    items:
> +      - const: ref
> +      - const: pclk
> +
> +  resets:
> +    maxItems: 1
> +
> +  kendryte,sysctl:
> +    minItems: 1
> +    maxItems: 1
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: |
> +      phandle to the system controller node
> +
> +  kendryte,power-offset:
> +    minItems: 1
> +    maxItems: 1
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Offset of the power domain control register of the system controller.

Sounds like you should be using power-domains binding.

> +      The value should be the macro K210_SYSCTL_POWER_SEL defined in
> +      dt-bindings/mfd/k210-sysctl.h.
> +
> +patternProperties:
> +  '^.*$':
> +    if:
> +      type: object
> +    then:

This is a hack for existing bindings. Use '-pins$' for the node names.

> +      patternProperties:
> +        "^pinmux$":

Not really a pattern.

> +          $ref: /schemas/pinctrl/pincfg-node.yaml

This is at the wrong level. Goes up 1 level.

> +          description:
> +            An array of IO pins alternate functions. The values for each
> +            IO pin is a combination of an IO pin number (0 to 47) with the
> +            desired function for the IO pin. Functions are defined as macros in
> +            dt-bindings/pinctrl/k210-pinctrl.h. The K210_FPIOA(IO pin, function)
> +            is provided to facilitate the combination of IO pin numbers and
> +            functions.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - resets
> +  - kendryte,sysctl
> +  - kendryte,power-offset
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/pinctrl/k210-pinctrl.h>
> +    #include <dt-bindings/mfd/k210-sysctl.h>
> +    #include <dt-bindings/clock/k210-sysctl.h>
> +    #include <dt-bindings/reset/k210-sysctl.h>
> +
> +    fpioa: pinmux@502B0000 {
> +      compatible = "kendryte,k210-fpioa";
> +      reg = <0x502B0000 0x100>;
> +      clocks = <&sysclk K210_CLK_FPIOA>;
> +      resets = <&sysrst K210_RST_FPIOA>;
> +      kendryte,sysctl = <&sysctl>;
> +      kendryte,power-offset = <K210_SYSCTL_POWER_SEL>;
> +      pinctrl-0 = <&fpioa_jtag>;
> +      pinctrl-names = "default";
> +
> +      fpioa_jtag: jtag {
> +        pinmux = <K210_FPIOA(0, K210_PCF_JTAG_TCLK)>,
> +                 <K210_FPIOA(1, K210_PCF_JTAG_TDI)>,
> +                 <K210_FPIOA(2, K210_PCF_JTAG_TMS)>,
> +                 <K210_FPIOA(3, K210_PCF_JTAG_TDO)>;
> +      };
> +    };
> -- 
> 2.28.0
> 
