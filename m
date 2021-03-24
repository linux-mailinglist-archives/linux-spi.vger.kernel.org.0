Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89DDF348046
	for <lists+linux-spi@lfdr.de>; Wed, 24 Mar 2021 19:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237446AbhCXSSz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 24 Mar 2021 14:18:55 -0400
Received: from mail-il1-f182.google.com ([209.85.166.182]:35813 "EHLO
        mail-il1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237456AbhCXSSp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 24 Mar 2021 14:18:45 -0400
Received: by mail-il1-f182.google.com with SMTP id 19so22228585ilj.2;
        Wed, 24 Mar 2021 11:18:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rKUadOrtBgPOs7+EnFLiQnqY4jsqDvWEP/7Y75D3wns=;
        b=OEdC6m7Cv9YuBD/wQVjQayPZvyJYm1kqdNiKeF2RCJsomYTtPByzH4yC+pPs5bbTxB
         SCFGsH8Zae4DIiwqCuROUB7o4J1VJZnfmjhZyWGYKsBfJmuvR3fjZ1keMvfEGQ+gew5i
         CHL9ZoPe9+aYt4CNbu5KW5BLxMIYcm4A/WGFyhnrKYY0HcPXU4jfzKhFt1iMGG5JjE4f
         Frk0NY5KAZYS9/jVyc5MBNSi1rBgN+w5oX4wMyb6TbXE0ybpa6BK9zIB98btWk5X5Pii
         xXteyUw2Tv7Sh6vIZXYpDgEInsAUU3gQyO4j3x+PRviqH5MoGuKyKobTAQFeZNac+C97
         3c0g==
X-Gm-Message-State: AOAM531IdYUG7jzzhsBpzpKNfD2aUl2ed+vzoyxIUIYqx8x+Q74ABf0f
        lYVql5QDPE4XWOuQ28uJ+DhYaopOmc2/
X-Google-Smtp-Source: ABdhPJx7Wm1lTR6di5yw5RkPdMyvttI64Ts/EvFHUdK1JLog1grId4vjYzL7z9OQHedp/ywTKsyaHg==
X-Received: by 2002:a05:6e02:802:: with SMTP id u2mr3515144ilm.298.1616609925226;
        Wed, 24 Mar 2021 11:18:45 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id n16sm1422104ilq.71.2021.03.24.11.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 11:18:44 -0700 (PDT)
Received: (nullmailer pid 3368128 invoked by uid 1000);
        Wed, 24 Mar 2021 18:18:43 -0000
Date:   Wed, 24 Mar 2021 12:18:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kuldeep Singh <kuldeep.singh@nxp.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH] dt-bindings: spi: Convert Freescale DSPI to json schema
Message-ID: <20210324181843.GD3320002@robh.at.kernel.org>
References: <20210315121518.3710171-1-kuldeep.singh@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315121518.3710171-1-kuldeep.singh@nxp.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Mar 15, 2021 at 05:45:18PM +0530, Kuldeep Singh wrote:
> Convert the Freescale DSPI binding to DT schema format using json-schema.
> 
> Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
> ---
> Hi Rob,
> This patch is checked with following commands with no warnings observed.
> make distclean; make allmodconfig;
> make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi.yaml;
> make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi.yaml
> 
>  .../bindings/spi/fsl,spi-fsl-dspi.yaml        | 131 ++++++++++++++++++
>  .../devicetree/bindings/spi/spi-fsl-dspi.txt  |  65 ---------
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 132 insertions(+), 66 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi.yaml b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi.yaml
> new file mode 100644
> index 000000000000..15ffc83bdba6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi.yaml
> @@ -0,0 +1,131 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/fsl,spi-fsl-dspi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale DSPI Controller
> +
> +maintainers:
> +  - Vladimir Oltean <olteanv@gmail.com>
> +
> +allOf:
> +  - $ref: "spi-controller.yaml#"
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - fsl,vf610-dspi
> +          - fsl,ls1021a-v1.0-dspi
> +          - fsl,ls1028a-dspi
> +          - fsl,ls2085a-dspi
> +          - fsl,lx2160a-dspi
> +      - items:
> +          - enum:
> +              - fsl,ls1012a-dspi
> +              - fsl,ls1028a-dspi
> +              - fsl,ls1043a-dspi
> +              - fsl,ls1046a-dspi
> +              - fsl,ls1088a-dspi
> +          - const: fsl,ls1021a-v1.0-dspi
> +      - items:
> +          - enum:
> +              - fsl,ls2080a-dspi
> +              - fsl,lx2160a-dspi
> +          - const: fsl,ls2085a-dspi
> +
> +  reg:
> +    maxItems: 1
> +    description: Offset and length of registers
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: SoC dspi clock
> +
> +  clock-names:
> +    items:
> +      - const: dspi
> +
> +  pinctrl-names:
> +    minItems: 1

Implied by the length of 'items'.

> +    items:
> +      - const: default
> +    description:
> +      Names for the pin configuration must be "default"

Just repeating what the schema says. Drop.

> +
> +  dmas:
> +    maxItems: 2
> +
> +  dma-names:
> +    items:
> +      - const: tx
> +      - const: rx
> +
> +  spi-num-chipselects:
> +    maxItems: 1

An array?

This needs a type ref.

> +    description: Number of the chipselect signals
> +
> +  bus-num:
> +    items:
> +      - description: Slave chip chipselect signal number

An array?

Also needs a type ref.

> +
> +patternProperties:
> +  "@[0-9a-f]+":
> +    type: object
> +
> +    properties:
> +      fsl,spi-cs-sck-delay:
> +        description:
> +          Delay in nanoseconds between activating chip select and the start of
> +          clock signal, at the start of a transfer.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +
> +      fsl,spi-sck-cs-delay:
> +        description:
> +          Delay in nanoseconds between stopping the clock signal and
> +          deactivating chip select, at the end of a transfer.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - spi-num-chipselects
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/fsl,qoriq-clockgen.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        spi@2100000 {
> +            compatible = "fsl,ls1028a-dspi", "fsl,ls1021a-v1.0-dspi";
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            reg = <0x0 0x2100000 0x0 0x10000>;
> +            interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> +            clock-names = "dspi";
> +            clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL QORIQ_CLK_PLL_DIV(2)>;
> +            dmas = <&edma0 0 62>, <&edma0 0 60>;
> +            dma-names = "tx", "rx";
> +            spi-num-chipselects = <4>;
> +            little-endian;
> +
> +            flash@0 {
> +                compatible = "jedec,spi-nor";
> +                spi-max-frequency = <10000000>;
> +                reg = <0>;
> +            };
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
> deleted file mode 100644
> index 30a79da9c039..000000000000
> --- a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
> +++ /dev/null
> @@ -1,65 +0,0 @@
> -ARM Freescale DSPI controller
> -
> -Required properties:
> -- compatible : must be one of:
> -	"fsl,vf610-dspi",
> -	"fsl,ls1021a-v1.0-dspi",
> -	"fsl,ls1012a-dspi" (optionally followed by "fsl,ls1021a-v1.0-dspi"),
> -	"fsl,ls1028a-dspi",
> -	"fsl,ls1043a-dspi" (optionally followed by "fsl,ls1021a-v1.0-dspi"),
> -	"fsl,ls1046a-dspi" (optionally followed by "fsl,ls1021a-v1.0-dspi"),
> -	"fsl,ls1088a-dspi" (optionally followed by "fsl,ls1021a-v1.0-dspi"),
> -	"fsl,ls2080a-dspi" (optionally followed by "fsl,ls2085a-dspi"),
> -	"fsl,ls2085a-dspi",
> -	"fsl,lx2160a-dspi",
> -- reg : Offset and length of the register set for the device
> -- interrupts : Should contain SPI controller interrupt
> -- clocks: from common clock binding: handle to dspi clock.
> -- clock-names: from common clock binding: Shall be "dspi".
> -- pinctrl-0: pin control group to be used for this controller.
> -- pinctrl-names: must contain a "default" entry.
> -- spi-num-chipselects : the number of the chipselect signals.
> -
> -Optional property:
> -- big-endian: If present the dspi device's registers are implemented
> -  in big endian mode.
> -- bus-num : the slave chip chipselect signal number.
> -
> -Optional SPI slave node properties:
> -- fsl,spi-cs-sck-delay: a delay in nanoseconds between activating chip
> -  select and the start of clock signal, at the start of a transfer.
> -- fsl,spi-sck-cs-delay: a delay in nanoseconds between stopping the clock
> -  signal and deactivating chip select, at the end of a transfer.
> -
> -Example:
> -
> -dspi0@4002c000 {
> -	#address-cells = <1>;
> -	#size-cells = <0>;
> -	compatible = "fsl,vf610-dspi";
> -	reg = <0x4002c000 0x1000>;
> -	interrupts = <0 67 0x04>;
> -	clocks = <&clks VF610_CLK_DSPI0>;
> -	clock-names = "dspi";
> -	spi-num-chipselects = <5>;
> -	bus-num = <0>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_dspi0_1>;
> -	big-endian;
> -
> -	sflash: at26df081a@0 {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		compatible = "atmel,at26df081a";
> -		spi-max-frequency = <16000000>;
> -		spi-cpol;
> -		spi-cpha;
> -		reg = <0>;
> -		linux,modalias = "m25p80";
> -		modal = "at26df081a";
> -		fsl,spi-cs-sck-delay = <100>;
> -		fsl,spi-sck-cs-delay = <50>;
> -	};
> -};
> -
> -
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d92f85ca831d..e2c5b7367db9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7060,7 +7060,7 @@ FREESCALE DSPI DRIVER
>  M:	Vladimir Oltean <olteanv@gmail.com>
>  L:	linux-spi@vger.kernel.org
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
> +F:	Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi.yaml
>  F:	drivers/spi/spi-fsl-dspi.c
>  F:	include/linux/spi/spi-fsl-dspi.h
>  
> -- 
> 2.17.1
> 
