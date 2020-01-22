Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9CE61459A9
	for <lists+linux-spi@lfdr.de>; Wed, 22 Jan 2020 17:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgAVQWf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Jan 2020 11:22:35 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40068 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgAVQWf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 Jan 2020 11:22:35 -0500
Received: by mail-ot1-f67.google.com with SMTP id w21so6777873otj.7;
        Wed, 22 Jan 2020 08:22:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kCImsWAHMcGM6HDHp7yvU7LkrfEZdThKNA79YO2XD8k=;
        b=j4I4WP0kerQ7rFQnwxsiuak0ET2dltfc0Y1cUhU5YSgonPKu+XXAqruJCZ5zCHjq3z
         1znwSpLvEcBwaGxPJP7CEeW7xHgVWrn23v6Xw7+WOteVuxEurQrKAoIeGmCaiwwxX4Rl
         4nG2y0MDTPochn+K8g8QwfFeSflWDe+KMOAl24/51XCm9DmTqtp5n13u0Fcs7FXjYjIE
         7A96VNlEFg7hvfjnweQdQ+efP70tQ4nbdb3AB2vlHBZyrYkRs1jtdJOPm/8RfFcINYBW
         CglY2GQhaWE+f4H6clGOhnpLzmdAbuD3Tmke5ysjH2ymtdrteGhO8OdpxuFrW+OVLKgr
         5Fog==
X-Gm-Message-State: APjAAAXP4EslxqFgG7oM+lzZnn8JAL4OOby6Lf1RdGqU6fofaEo1untg
        Bgp1EoNJ5Q07pWjq/kX6Gw==
X-Google-Smtp-Source: APXvYqypAA6oJ0DOOT8a9frxpYaRQG8hl5oIGKgJuuLCYr3sTnOr4oj3gAVs+JtwnzyGIFIPmkTsYw==
X-Received: by 2002:a05:6830:149a:: with SMTP id s26mr8107304otq.55.1579710153583;
        Wed, 22 Jan 2020 08:22:33 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q13sm14848058otc.5.2020.01.22.08.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 08:22:33 -0800 (PST)
Received: (nullmailer pid 6697 invoked by uid 1000);
        Wed, 22 Jan 2020 16:22:32 -0000
Date:   Wed, 22 Jan 2020 10:22:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     broonie@kernel.org, mark.rutland@arm.com, heiko@sntech.de,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/3] dt-bindings: spi: convert rockchip spi
 bindings to yaml
Message-ID: <20200122162232.GA29674@bogus>
References: <20200118230848.15326-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200118230848.15326-1-jbx6244@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, Jan 19, 2020 at 12:08:46AM +0100, Johan Jonker wrote:
> Current dts files with 'spi' nodes are manually verified.
> In order to automate this process spi-rockchip.txt
> has to be converted to yaml. In the new setup
> spi-rockchip.yaml will inherit properties from
> spi-controller.yaml.
> 
> Add document to MAINTAINERS.
> 
> Also rk3188.dtsi, rk3288.dtsi, rk3368.dtsi and rk3399.dtsi
> use an extra fallback string, so change this in the documentation.
> 
> Changed:
> "rockchip,rk3188-spi", "rockchip,rk3066-spi"
> "rockchip,rk3288-spi", "rockchip,rk3066-spi"
> "rockchip,rk3368-spi", "rockchip,rk3066-spi"
> "rockchip,rk3399-spi", "rockchip,rk3066-spi"
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../devicetree/bindings/spi/spi-rockchip.txt       |  58 -----------
>  .../devicetree/bindings/spi/spi-rockchip.yaml      | 111 +++++++++++++++++++++
>  MAINTAINERS                                        |   1 +
>  3 files changed, 112 insertions(+), 58 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-rockchip.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-rockchip.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.txt b/Documentation/devicetree/bindings/spi/spi-rockchip.txt
> deleted file mode 100644
> index a0edac12d..000000000
> --- a/Documentation/devicetree/bindings/spi/spi-rockchip.txt
> +++ /dev/null
> @@ -1,58 +0,0 @@
> -* Rockchip SPI Controller
> -
> -The Rockchip SPI controller is used to interface with various devices such as flash
> -and display controllers using the SPI communication interface.
> -
> -Required Properties:
> -
> -- compatible: should be one of the following.
> -    "rockchip,rv1108-spi" for rv1108 SoCs.
> -    "rockchip,px30-spi", "rockchip,rk3066-spi" for px30 SoCs.
> -    "rockchip,rk3036-spi" for rk3036 SoCS.
> -    "rockchip,rk3066-spi" for rk3066 SoCs.
> -    "rockchip,rk3188-spi" for rk3188 SoCs.
> -    "rockchip,rk3228-spi" for rk3228 SoCS.
> -    "rockchip,rk3288-spi" for rk3288 SoCs.
> -    "rockchip,rk3368-spi" for rk3368 SoCs.
> -    "rockchip,rk3399-spi" for rk3399 SoCs.
> -- reg: physical base address of the controller and length of memory mapped
> -       region.
> -- interrupts: The interrupt number to the cpu. The interrupt specifier format
> -              depends on the interrupt controller.
> -- clocks: Must contain an entry for each entry in clock-names.
> -- clock-names: Shall be "spiclk" for the transfer-clock, and "apb_pclk" for
> -			   the peripheral clock.
> -- #address-cells: should be 1.
> -- #size-cells: should be 0.
> -
> -Optional Properties:
> -
> -- dmas: DMA specifiers for tx and rx dma. See the DMA client binding,
> -		Documentation/devicetree/bindings/dma/dma.txt
> -- dma-names: DMA request names should include "tx" and "rx" if present.
> -- rx-sample-delay-ns: nanoseconds to delay after the SCLK edge before sampling
> -		Rx data (may need to be fine tuned for high capacitance lines).
> -		No delay (0) by default.
> -- pinctrl-names: Names for the pin configuration(s); may be "default" or
> -		"sleep", where the "sleep" configuration may describe the state
> -		the pins should be in during system suspend. See also
> -		pinctrl/pinctrl-bindings.txt.
> -
> -
> -Example:
> -
> -	spi0: spi@ff110000 {
> -		compatible = "rockchip,rk3066-spi";
> -		reg = <0xff110000 0x1000>;
> -		dmas = <&pdma1 11>, <&pdma1 12>;
> -		dma-names = "tx", "rx";
> -		rx-sample-delay-ns = <10>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&cru SCLK_SPI0>, <&cru PCLK_SPI0>;
> -		clock-names = "spiclk", "apb_pclk";
> -		pinctrl-0 = <&spi1_pins>;
> -		pinctrl-1 = <&spi1_sleep>;
> -		pinctrl-names = "default", "sleep";
> -	};
> diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
> new file mode 100644
> index 000000000..80c56c583
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
> @@ -0,0 +1,111 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/spi-rockchip.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip SPI Controller
> +
> +description:
> +  The Rockchip SPI controller is used to interface with various devices such
> +  as flash and display controllers using the SPI communication interface.
> +
> +allOf:
> +  - $ref: "spi-controller.yaml#"
> +
> +maintainers:
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +# Everything else is described in the common file
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: rockchip,rk3036-spi #for rk3036 SoCS.
> +      - const: rockchip,rk3066-spi #for rk3066 SoCs.
> +      - const: rockchip,rk3228-spi #for rk3228 SoCS.
> +      - const: rockchip,rv1108-spi #for rv1108 SoCs.
> +      - items:
> +          - enum:
> +            - rockchip,px30-spi    #for px30 SoCs.
> +            - rockchip,rk3188-spi  #for rk3188 SoCs.
> +            - rockchip,rk3288-spi  #for rk3288 SoCs.
> +            - rockchip,rk3368-spi  #for rk3368 SoCs.
> +            - rockchip,rk3399-spi  #for rk3399 SoCs.
> +          - const: rockchip,rk3066-spi
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 2
> +    maxItems: 2
> +    description:
> +      Must contain an entry for each entry in clock-names.

That's *every* clocks entry. Drop this.
> +
> +  clock-names:
> +    items:
> +      - const: spiclk
> +      - const: apb_pclk
> +    description:
> +      Shall be "spiclk" for the transfer-clock
> +      and "apb_pclk" for the peripheral clock.

Basically just repeating what the schema says. If you want more of a 
description of each clock, do what you've done for 'dmas' with 'clocks'.

> +
> +  dmas:
> +    items:
> +      - description: TX DMA Channel
> +      - description: RX DMA Channel
> +
> +  dma-names:
> +    items:
> +      - const: tx
> +      - const: rx
> +
> +  rx-sample-delay-ns:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32

Don't need to define the type for properties with standard unit 
suffixes.

> +    default: 0
> +    description:
> +      Nano seconds to delay after the SCLK edge before sampling Rx data
> +      (may need to be fine tuned for high capacitance lines).
> +      If not specified 0 will be used.
> +
> +  pinctrl-names:
> +    minItems: 1
> +    items:
> +      - const: default
> +      - const: sleep
> +    description:
> +      Names for the pin configuration(s); may be "default" or "sleep",
> +      where the "sleep" configuration may describe the state
> +      the pins should be in during system suspend.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/rk3188-cru-common.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi0: spi@ff110000 {
> +      compatible = "rockchip,rk3066-spi";
> +      reg = <0xff110000 0x1000>;
> +      interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
> +      clocks = <&cru SCLK_SPI0>, <&cru PCLK_SPI0>;
> +      clock-names = "spiclk", "apb_pclk";
> +      dmas = <&pdma1 11>, <&pdma1 12>;
> +      dma-names = "tx", "rx";
> +      pinctrl-0 = <&spi1_pins>;
> +      pinctrl-1 = <&spi1_sleep>;
> +      pinctrl-names = "default", "sleep";
> +      rx-sample-delay-ns = <10>;
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d6ad01d71..096c324f9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2240,6 +2240,7 @@ L:	linux-rockchip@lists.infradead.org
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
> +F:	Documentation/devicetree/bindings/spi/spi-rockchip.yaml
>  F:	arch/arm/boot/dts/rk3*
>  F:	arch/arm/boot/dts/rv1108*
>  F:	arch/arm/mach-rockchip/
> -- 
> 2.11.0
> 
