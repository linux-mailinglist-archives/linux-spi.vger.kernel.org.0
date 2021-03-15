Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D4B33C5B0
	for <lists+linux-spi@lfdr.de>; Mon, 15 Mar 2021 19:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhCOSbU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Mar 2021 14:31:20 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40868 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbhCOSbE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Mar 2021 14:31:04 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12FIUr9L064091;
        Mon, 15 Mar 2021 13:30:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615833053;
        bh=qhtin/MvC2vlgohcTw+Zu4C+yVZD1Fpb/7+1ZrE+U0Q=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=empUyjxQ6xGRmHEippJDyLO5Rn+L5VyZNF8sdHxsZNpi7hWrzFc/UxD1OyF7paW3u
         Vru2FklzE2k4esSPtOc/7hejHJcVnpZzY+cg9zydO9EvOG/9POTlx7n008cAaVNcV+
         KCjI5PKCxtljLi855dq/O/F/xUibWtT0h9nJt7iY=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12FIUrGh075840
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 Mar 2021 13:30:53 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 15
 Mar 2021 13:30:53 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 15 Mar 2021 13:30:53 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12FIUqiB114948;
        Mon, 15 Mar 2021 13:30:53 -0500
Date:   Tue, 16 Mar 2021 00:00:52 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Kuldeep Singh <kuldeep.singh@nxp.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>,
        <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH] dt-bindings: spi: Convert Freescale DSPI to json schema
Message-ID: <20210315183051.ugvmz4zqrvuo6iqq@ti.com>
References: <20210315121518.3710171-1-kuldeep.singh@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210315121518.3710171-1-kuldeep.singh@nxp.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

+Cc mtd list

Hi,

On 15/03/21 05:45PM, Kuldeep Singh wrote:
> Convert the Freescale DSPI binding to DT schema format using json-schema.
> 
> Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
> ---
> Hi Rob,
> This patch is checked with following commands with no warnings observed.
> make distclean; make allmodconfig;
> make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi.yaml;
> make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi.yaml

When I add the "fsl,spi-cs-sck-delay" property under the flash@0 node in 
the example and run dt_binding_check, I see the below error:

  /home/pratyush/src/linux/Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi.example.dt.yaml: flash@0: 'fsl,spi-cs-sck-delay' does not match any of the regexes: '^partition@', 'pinctrl-[0-9]+'
     From schema: /home/pratyush/src/lin/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml

I am trying to solve a similar problem for the Cadence QSPI controller 
binding and I wonder what the best solution for this is. The obvious one 
would be to add these properties to jedec,spi-nor.yaml. I haven't 
managed to come up with any other solution to this problem.

Rob, all, any suggestions on how to best model this?

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
> +    items:
> +      - const: default
> +    description:
> +      Names for the pin configuration must be "default"
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
> +    description: Number of the chipselect signals
> +
> +  bus-num:
> +    items:
> +      - description: Slave chip chipselect signal number
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

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
