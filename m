Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED7B1CB873
	for <lists+linux-spi@lfdr.de>; Fri,  8 May 2020 21:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgEHTjg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 May 2020 15:39:36 -0400
Received: from mga02.intel.com ([134.134.136.20]:53954 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbgEHTjg (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 8 May 2020 15:39:36 -0400
IronPort-SDR: 8OUODMB9SguA/uSBHM+yF9dbuB/8VJ/2Es39dRKoFCdIGu46mYn0ShyoHi5LZKllkcpi5LIktA
 QF+iEhweIEOg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 12:39:35 -0700
IronPort-SDR: rgqw0xeLyZwep6MX+HiLcdt6ztnkRAc6YQ574nWmOBGEnXAupAKLKXZksR8iTw7nvFJOlzw4X6
 +IhTpczIXxYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,368,1583222400"; 
   d="scan'208";a="264492012"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 08 May 2020 12:39:31 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jX8qM-005TDe-Gz; Fri, 08 May 2020 22:39:34 +0300
Date:   Fri, 8 May 2020 22:39:34 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-mips@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/17] dt-bindings: spi: Convert DW SPI binding to DT
 schema
Message-ID: <20200508193934.GY185537@smile.fi.intel.com>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200508132943.9826-2-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508132943.9826-2-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 08, 2020 at 04:29:26PM +0300, Serge Semin wrote:
> Modern device tree bindings are supposed to be created as YAML-files
> in accordance with dt-schema. This commit replaces two DW SPI legacy
> bare text bindings with YAML file. As before the bindings file states
> that the corresponding dts node is supposed to be compatible either
> with generic DW APB SSI controller or with Microsemi/Amazon/Renesas
> vendors-specific controllers, to have registers, interrupts and clocks
> properties. Though in case of Microsemi version of the controller
> there must be two registers resources specified. Properties like
> clock-names, reg-io-width, cs-gpio, num-cs and SPI-specific sub-nodes
> are optional.

Can you incorporate work done here or agree with Wan how to proceed?

https://lore.kernel.org/linux-spi/20200505191910.GA2970@bogus/T/#md626b5f6f2294b0ebd70995d5ed0e67a360e000b

> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
> Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Allison Randal <allison@lohutok.net>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Gareth Williams <gareth.williams.jx@renesas.com>
> Cc: linux-mips@vger.kernel.org
> ---
>  .../bindings/spi/snps,dw-apb-ssi.txt          |  41 -------
>  .../bindings/spi/snps,dw-apb-ssi.yaml         | 113 ++++++++++++++++++
>  .../devicetree/bindings/spi/spi-dw.txt        |  24 ----
>  3 files changed, 113 insertions(+), 65 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-dw.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
> deleted file mode 100644
> index 3ed08ee9feba..000000000000
> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
> +++ /dev/null
> @@ -1,41 +0,0 @@
> -Synopsys DesignWare AMBA 2.0 Synchronous Serial Interface.
> -
> -Required properties:
> -- compatible : "snps,dw-apb-ssi" or "mscc,<soc>-spi", where soc is "ocelot" or
> -  "jaguar2", or "amazon,alpine-dw-apb-ssi"
> -- reg : The register base for the controller. For "mscc,<soc>-spi", a second
> -  register set is required (named ICPU_CFG:SPI_MST)
> -- interrupts : One interrupt, used by the controller.
> -- #address-cells : <1>, as required by generic SPI binding.
> -- #size-cells : <0>, also as required by generic SPI binding.
> -- clocks : phandles for the clocks, see the description of clock-names below.
> -   The phandle for the "ssi_clk" is required. The phandle for the "pclk" clock
> -   is optional. If a single clock is specified but no clock-name, it is the
> -   "ssi_clk" clock. If both clocks are listed, the "ssi_clk" must be first.
> -
> -Optional properties:
> -- clock-names : Contains the names of the clocks:
> -    "ssi_clk", for the core clock used to generate the external SPI clock.
> -    "pclk", the interface clock, required for register access. If a clock domain
> -     used to enable this clock then it should be named "pclk_clkdomain".
> -- cs-gpios : Specifies the gpio pins to be used for chipselects.
> -- num-cs : The number of chipselects. If omitted, this will default to 4.
> -- reg-io-width : The I/O register width (in bytes) implemented by this
> -  device.  Supported values are 2 or 4 (the default).
> -
> -Child nodes as per the generic SPI binding.
> -
> -Example:
> -
> -	spi@fff00000 {
> -		compatible = "snps,dw-apb-ssi";
> -		reg = <0xfff00000 0x1000>;
> -		interrupts = <0 154 4>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		clocks = <&spi_m_clk>;
> -		num-cs = <2>;
> -		cs-gpios = <&gpio0 13 0>,
> -			   <&gpio0 14 0>;
> -	};
> -
> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> new file mode 100644
> index 000000000000..e2f6d8aa6181
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> @@ -0,0 +1,113 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/snps,dw-apb-ssi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synopsys DesignWare AMBA 2.0 Synchronous Serial Interface
> +
> +maintainers:
> +  - Mark Brown <broonie@kernel.org>
> +
> +allOf:
> +  - $ref: "spi-controller.yaml#"
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mscc,ocelot-spi
> +              - mscc,jaguar2-spi
> +    then:
> +      properties:
> +        reg:
> +          minItems: 2
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - description: Generic DW SPI controller
> +        const: snps,dw-apb-ssi
> +      - description: Microsemi Ocelot/Jaguar2 SoC SPI controller
> +        items:
> +          - enum:
> +              - mscc,ocelot-spi
> +              - mscc,jaguar2-spi
> +          - const: snps,dw-apb-ssi
> +      - description: Amazon Alpine SPI controller
> +        const: amazon,alpine-dw-apb-ssi
> +      - description: Renesas RZ/N1 SPI controlle.
> +        items:
> +          - const: renesas,rzn1-spi
> +          - const: snps,dw-apb-ssi
> +
> +  reg:
> +    minItems: 1
> +    items:
> +      - description: DW APB SSI controller memory mapped registers
> +      - description: SPI MST region map
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +    items:
> +      - description: SPI Controller reference clock source
> +      - description: APB interface clock source
> +
> +  clock-names:
> +    minItems: 1
> +    items:
> +      - const: ssi_clk
> +      - const: pclk
> +
> +  reg-io-width:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: I/O register width (in bytes) implemented by this device
> +    default: 4
> +    enum: [ 2, 4 ]
> +
> +  num-cs:
> +    default: 4
> +    minimum: 1
> +    maximum: 4
> +
> +patternProperties:
> +  "^.*@[0-9a-f]+$":
> +    type: object
> +    properties:
> +      reg:
> +        minimum: 0
> +        maximum: 3
> +
> +      spi-rx-bus-width:
> +        const: 1
> +
> +      spi-tx-bus-width:
> +        const: 1
> +
> +unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +  - interrupts
> +  - clocks
> +
> +examples:
> +  - |
> +    spi@fff00000 {
> +      compatible = "snps,dw-apb-ssi";
> +      reg = <0xfff00000 0x1000>;
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      interrupts = <0 154 4>;
> +      clocks = <&spi_m_clk>;
> +      num-cs = <2>;
> +      cs-gpios = <&gpio0 13 0>,
> +                 <&gpio0 14 0>;
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/spi/spi-dw.txt b/Documentation/devicetree/bindings/spi/spi-dw.txt
> deleted file mode 100644
> index 7b63ed601990..000000000000
> --- a/Documentation/devicetree/bindings/spi/spi-dw.txt
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -Synopsys DesignWare SPI master
> -
> -Required properties:
> -- compatible: should be "snps,designware-spi"
> -- #address-cells: see spi-bus.txt
> -- #size-cells: see spi-bus.txt
> -- reg: address and length of the spi master registers
> -- interrupts: should contain one interrupt
> -- clocks: spi clock phandle
> -- num-cs: see spi-bus.txt
> -
> -Optional properties:
> -- cs-gpios: see spi-bus.txt
> -
> -Example:
> -
> -spi: spi@4020a000 {
> -	compatible = "snps,designware-spi";
> -	interrupts = <11 1>;
> -	reg = <0x4020a000 0x1000>;
> -	clocks = <&pclk>;
> -	num-cs = <2>;
> -	cs-gpios = <&banka 0 0>;
> -};
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


