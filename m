Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8BF3AD3D2
	for <lists+linux-spi@lfdr.de>; Fri, 18 Jun 2021 22:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbhFRUrU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Jun 2021 16:47:20 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:38719 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbhFRUrT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Jun 2021 16:47:19 -0400
Received: by mail-ot1-f41.google.com with SMTP id j11-20020a9d738b0000b02903ea3c02ded8so10959910otk.5;
        Fri, 18 Jun 2021 13:45:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GBg+2tBxlhWic7DcvvdmpLqu1gfkvjlqsdo6snxskmY=;
        b=f1NiMc6oix/uKHuLmFM89/ceKjdMzTp3zyKH8SUzsaglq2bHev4qSME80OWtbsb1Nd
         W26fyPmM1ivEcc+7+cAaET3U63ckr/mYqtXJ1Xd7cGN9dAnopjGxu9IYt+KduwdPqOIc
         n8aATmzMwIW1/Ro8LqsDJOadsAXz77pS4Zo8w62dAg5kzE7BWKqoCW0K0Og/zeH5keJe
         xrL7ne7whuiP/qNtf3zWpVx6MRrd/iKSFn41wfGjQi7IJpKPKjJ0EPPlmh4U5aX7Gcut
         xVO7CvyfaafPS+e++eZuaLr4734yQ/tfbaDOFeFwXxloFvEe+J07pnrcIh4aiS7ejXy+
         VIoA==
X-Gm-Message-State: AOAM532+uhD8r8ZSubax3vWx50iymkolhGryebMGsl6xrLt2Xygwd+J8
        EUYkLfSgLEfmQTWxQS5jbQ==
X-Google-Smtp-Source: ABdhPJxzlfAyJn3z8Oxr35MJyBzPhmoAsKjTDdtsFputSBlYV4c2XziBbvlX1+4IIhiRIxbeYHBE+A==
X-Received: by 2002:a05:6830:1d6f:: with SMTP id l15mr1892448oti.358.1624049109025;
        Fri, 18 Jun 2021 13:45:09 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id p9sm2181081otl.64.2021.06.18.13.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 13:45:08 -0700 (PDT)
Received: (nullmailer pid 2844812 invoked by uid 1000);
        Fri, 18 Jun 2021 20:45:05 -0000
Date:   Fri, 18 Jun 2021 14:45:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Lokesh Vutla <lokeshvutla@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: spi: omap-spi: Convert to json-schema
Message-ID: <20210618204505.GA2835349@robh.at.kernel.org>
References: <20210608052010.15656-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608052010.15656-1-a-govindraju@ti.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Jun 08, 2021 at 10:50:09AM +0530, Aswath Govindraju wrote:
> Convert omap-spi dt-binding documentation from txt to yaml format.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
> 
> changes since v1:
> - split the series according to their respective trees
> 
> link to v1:
> https://lore.kernel.org/patchwork/project/lkml/list/?series=502255
> 
>  .../devicetree/bindings/spi/omap-spi.txt      |  48 -------
>  .../devicetree/bindings/spi/omap-spi.yaml     | 126 ++++++++++++++++++
>  2 files changed, 126 insertions(+), 48 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/omap-spi.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/omap-spi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/omap-spi.txt b/Documentation/devicetree/bindings/spi/omap-spi.txt
> deleted file mode 100644
> index 487208c256c0..000000000000
> --- a/Documentation/devicetree/bindings/spi/omap-spi.txt
> +++ /dev/null
> @@ -1,48 +0,0 @@
> -OMAP2+ McSPI device
> -
> -Required properties:
> -- compatible :
> -  - "ti,am654-mcspi" for AM654.
> -  - "ti,omap2-mcspi" for OMAP2 & OMAP3.
> -  - "ti,omap4-mcspi" for OMAP4+.
> -- ti,spi-num-cs : Number of chipselect supported  by the instance.
> -- ti,hwmods: Name of the hwmod associated to the McSPI
> -- ti,pindir-d0-out-d1-in: Select the D0 pin as output and D1 as
> -			  input. The default is D0 as input and
> -			  D1 as output.
> -
> -Optional properties:
> -- dmas: List of DMA specifiers with the controller specific format
> -	as described in the generic DMA client binding. A tx and rx
> -	specifier is required for each chip select.
> -- dma-names: List of DMA request names. These strings correspond
> -	1:1 with the DMA specifiers listed in dmas. The string naming
> -	is to be "rxN" and "txN" for RX and TX requests,
> -	respectively, where N equals the chip select number.
> -
> -Examples:
> -
> -[hwmod populated DMA resources]
> -
> -mcspi1: mcspi@1 {
> -    #address-cells = <1>;
> -    #size-cells = <0>;
> -    compatible = "ti,omap4-mcspi";
> -    ti,hwmods = "mcspi1";
> -    ti,spi-num-cs = <4>;
> -};
> -
> -[generic DMA request binding]
> -
> -mcspi1: mcspi@1 {
> -    #address-cells = <1>;
> -    #size-cells = <0>;
> -    compatible = "ti,omap4-mcspi";
> -    ti,hwmods = "mcspi1";
> -    ti,spi-num-cs = <2>;
> -    dmas = <&edma 42
> -	    &edma 43
> -	    &edma 44
> -	    &edma 45>;
> -    dma-names = "tx0", "rx0", "tx1", "rx1";
> -};
> diff --git a/Documentation/devicetree/bindings/spi/omap-spi.yaml b/Documentation/devicetree/bindings/spi/omap-spi.yaml
> new file mode 100644
> index 000000000000..cd20704f2edc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/omap-spi.yaml
> @@ -0,0 +1,126 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/omap-spi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SPI controller bindings for OMAP and K3 SoCs
> +
> +maintainers:
> +  - Mark Brown <broonie@kernel.org>

A TI person here please.

You need a ref to spi-controller.yaml

> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - ti,am654-mcspi
> +              - ti,am4372-mcspi
> +          - const: ti,omap4-mcspi
> +      - items:
> +          - enum:
> +              - ti,omap2-mcspi
> +              - ti,omap4-mcspi
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +

> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0

Don't need these, covered by spi-controller.yaml.

> +
> +  power-domains:
> +    maxItems: 1
> +
> +  ti,spi-num-cs:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Number of chipselect supported  by the instance.
> +    minimum: 1
> +    maximum: 4
> +
> +  ti,hwmods:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description:
> +      Must be "mcspi<n>", n being the instance number (1-based).
> +      This property is applicable only on legacy platforms mainly omap2/3
> +      and ti81xx and should not be used on other platforms.
> +    deprecated: true
> +
> +  ti,pindir-d0-out-d1-in:
> +    description:
> +      Select the D0 pin as output and D1 as input. The default is D0
> +      as input and D1 as output.
> +    type: boolean
> +
> +  dmas:
> +    description:
> +      List of DMA specifiers with the controller specific format as
> +      described in the generic DMA client binding. A tx and rx
> +      specifier is required for each chip select.
> +    minItems: 1
> +    maxItems: 8
> +
> +  dma-names:
> +    description:
> +      List of DMA request names. These strings correspond 1:1 with
> +      the DMA sepecifiers listed in dmas. The string names is to be
> +      "rxN" and "txN" for RX and TX requests, respectively. Where N
> +      is the chip select number.
> +    minItems: 1
> +    maxItems: 8
> +
> +patternProperties:
> +  "@[0-9a-f]+$":
> +    type: object
> +    description:
> +      Flash devices are defined as a sub-node of the spi controller

Covered by spi-controller.yaml.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +if:
> +  properties:
> +    compatible:
> +      oneOf:
> +        - const: ti,omap2-mcspi
> +        - const: ti,omap4-mcspi
> +
> +then:
> +  properties:
> +    ti,hwmods:
> +      items:
> +        - pattern: "^mcspi([1-9])$"
> +
> +else:
> +  properties:
> +    ti,hwmods: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
> +
> +    main_spi0: spi@2100000 {

Drop unused labels.

> +      compatible = "ti,am654-mcspi","ti,omap4-mcspi";
> +      reg = <0x2100000 0x400>;
> +      interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
> +      clocks = <&k3_clks 137 1>;
> +      power-domains = <&k3_pds 137 TI_SCI_PD_EXCLUSIVE>;
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      dmas = <&main_udmap 0xc500>, <&main_udmap 0x4500>;
> +      dma-names = "tx0", "rx0";
> +    };
> -- 
> 2.17.1
> 
> 
