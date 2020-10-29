Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4AA929F0AB
	for <lists+linux-spi@lfdr.de>; Thu, 29 Oct 2020 17:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgJ2QAF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 29 Oct 2020 12:00:05 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36263 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbgJ2QAE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 29 Oct 2020 12:00:04 -0400
Received: by mail-ot1-f65.google.com with SMTP id 32so2753069otm.3;
        Thu, 29 Oct 2020 09:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K2lwetM4NgmLlQ96LgzCtMy+9I/haCjrOmpYHTUHSuM=;
        b=S1zVmajU6gUOCf7YoCzbw2HyIl8gxfy3gw5DFduBTlzWm2hTKDKZUyl9ardhRzOUST
         oW9xttQbZMAp0aMY5e9ljAgeTOBGwgWfDWC6jocubLIIqCQHVZloiqnJHL5GqycG0NZG
         p/SRo1FTqXW23KW/7+cEugYsQ7cXVjvx1kZLBX1HwNJQBToQ4hfOiaEu9DSvHy3oThNx
         PupQz/CIYEG1FDgCEC4Z0HXzIF5cb0F6lmzTjKaEqDlmmktStkzydLHLmyYyZlibf2Pl
         i3Hksbk6PZZcsEt9p/VuqLds325S0AGnwb9zqxUvjqbP0X5g1nXaSH3WavgKnrz72w5r
         bJuA==
X-Gm-Message-State: AOAM533fKXwuMRYwM90tVdpx/pAGM4c/0sCVQPlGhP7H/xyiqf8BHR4B
        karrgrGsKGCE00v6CeVVRg==
X-Google-Smtp-Source: ABdhPJx25d5u57V18WqjUuHQOf9Rw8hj6gDCi7uS2e1g1FMHjRXolTXCvboo7jmFnYyBKwZ4aEFk6Q==
X-Received: by 2002:a9d:6c11:: with SMTP id f17mr3732268otq.208.1603987198310;
        Thu, 29 Oct 2020 08:59:58 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t4sm678677oov.15.2020.10.29.08.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 08:59:57 -0700 (PDT)
Received: (nullmailer pid 1949491 invoked by uid 1000);
        Thu, 29 Oct 2020 15:59:56 -0000
Date:   Thu, 29 Oct 2020 10:59:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     broonie@kernel.org, vigneshr@ti.com, tudor.ambarus@microchip.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, miquel.raynal@bootlin.com,
        simon.k.r.goldschmidt@gmail.com, dinguyen@kernel.org,
        richard@nod.at, cheol.yong.kim@intel.com, qi-ming.wu@intel.com
Subject: Re: [PATCH v5 5/6] dt-bindings: spi: Convert cadence-quadspi.txt to
 cadence-quadspi.yaml
Message-ID: <20201029155956.GA1937946@bogus>
References: <20201029062014.27620-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201029062014.27620-6-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029062014.27620-6-vadivel.muruganx.ramuthevar@linux.intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Oct 29, 2020 at 02:20:13PM +0800, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Convert the cadence-quadspi.txt documentation to cadence-quadspi.yaml
> remove the cadence-quadspi.txt from Documentation/devicetree/bindings/spi/
> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> ---
>  .../devicetree/bindings/spi/cadence-quadspi.txt    |  67 ---------
>  .../devicetree/bindings/spi/cadence-quadspi.yaml   | 150 +++++++++++++++++++++
>  2 files changed, 150 insertions(+), 67 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/cadence-quadspi.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/cadence-quadspi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/cadence-quadspi.txt b/Documentation/devicetree/bindings/spi/cadence-quadspi.txt
> deleted file mode 100644
> index 945be7d5b236..000000000000
> --- a/Documentation/devicetree/bindings/spi/cadence-quadspi.txt
> +++ /dev/null
> @@ -1,67 +0,0 @@
> -* Cadence Quad SPI controller
> -
> -Required properties:
> -- compatible : should be one of the following:
> -	Generic default - "cdns,qspi-nor".
> -	For TI 66AK2G SoC - "ti,k2g-qspi", "cdns,qspi-nor".
> -	For TI AM654 SoC  - "ti,am654-ospi", "cdns,qspi-nor".
> -- reg : Contains two entries, each of which is a tuple consisting of a
> -	physical address and length. The first entry is the address and
> -	length of the controller register set. The second entry is the
> -	address and length of the QSPI Controller data area.
> -- interrupts : Unit interrupt specifier for the controller interrupt.
> -- clocks : phandle to the Quad SPI clock.
> -- cdns,fifo-depth : Size of the data FIFO in words.
> -- cdns,fifo-width : Bus width of the data FIFO in bytes.
> -- cdns,trigger-address : 32-bit indirect AHB trigger address.
> -
> -Optional properties:
> -- cdns,is-decoded-cs : Flag to indicate whether decoder is used or not.
> -- cdns,rclk-en : Flag to indicate that QSPI return clock is used to latch
> -  the read data rather than the QSPI clock. Make sure that QSPI return
> -  clock is populated on the board before using this property.
> -
> -Optional subnodes:
> -Subnodes of the Cadence Quad SPI controller are spi slave nodes with additional
> -custom properties:
> -- cdns,read-delay : Delay for read capture logic, in clock cycles
> -- cdns,tshsl-ns : Delay in nanoseconds for the length that the master
> -                  mode chip select outputs are de-asserted between
> -		  transactions.
> -- cdns,tsd2d-ns : Delay in nanoseconds between one chip select being
> -                  de-activated and the activation of another.
> -- cdns,tchsh-ns : Delay in nanoseconds between last bit of current
> -                  transaction and deasserting the device chip select
> -		  (qspi_n_ss_out).
> -- cdns,tslch-ns : Delay in nanoseconds between setting qspi_n_ss_out low
> -                  and first bit transfer.
> -- resets	: Must contain an entry for each entry in reset-names.
> -		  See ../reset/reset.txt for details.
> -- reset-names	: Must include either "qspi" and/or "qspi-ocp".
> -
> -Example:
> -
> -	qspi: spi@ff705000 {
> -		compatible = "cdns,qspi-nor";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		reg = <0xff705000 0x1000>,
> -		      <0xffa00000 0x1000>;
> -		interrupts = <0 151 4>;
> -		clocks = <&qspi_clk>;
> -		cdns,is-decoded-cs;
> -		cdns,fifo-depth = <128>;
> -		cdns,fifo-width = <4>;
> -		cdns,trigger-address = <0x00000000>;
> -		resets = <&rst QSPI_RESET>, <&rst QSPI_OCP_RESET>;
> -		reset-names = "qspi", "qspi-ocp";
> -
> -		flash0: n25q00@0 {
> -			...
> -			cdns,read-delay = <4>;
> -			cdns,tshsl-ns = <50>;
> -			cdns,tsd2d-ns = <50>;
> -			cdns,tchsh-ns = <4>;
> -			cdns,tslch-ns = <4>;
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml b/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml
> new file mode 100644
> index 000000000000..daf891ade577
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml
> @@ -0,0 +1,150 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/cadence-quadspi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cadence Quad SPI controller
> +
> +maintainers:
> +  - Vadivel Murugan <vadivel.muruganx.ramuthevar@intel.com>
> +
> +allOf:
> +  - $ref: "spi-controller.yaml#"
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +         - const: cdns,qspi-nor
> +         - const: ti,k2g-qspi
> +         - const: ti,am654-ospi
> +         - const: ti,k2g-qspi
> +         - const: ti,am654-ospi

Nope, still wrong. This says compatible must be:

compatible = "cdns,qspi-nor", "ti,k2g-qspi", "ti,am654-ospi", "ti,k2g-qspi", "ti,am654-ospi";

I give up on you looking at the 1000+ examples we have to figure this out:

oneOf:
  - items:
      - enum:
          - ti,k2g-qspi
          - ti,am654-ospi
      - const: cdns,qspi-nor
  - const: cdns,qspi-nor

> +
> +  reg:
> +    items:
> +      - description: the controller register set
> +      - description: the controller data area
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  cdns,fifo-depth:
> +    description:
> +      Size of the data FIFO in words.
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    enum: [ 128, 256 ]
> +    default: 128
> +
> +  cdns,fifo-width:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Bus width of the data FIFO in bytes.
> +    default: 4
> +
> +  cdns,trigger-address:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      32-bit indirect AHB trigger address.
> +
> +  cdns,is-decoded-cs:
> +    type: boolean
> +    description:
> +      Flag to indicate whether decoder is used or not.
> +
> +  cdns,rclk-en:
> +    type: boolean
> +    description:
> +      Flag to indicate that QSPI return clock is used to latch the read
> +      data rather than the QSPI clock. Make sure that QSPI return clock
> +      is populated on the board before using this property.
> +
> +  resets:
> +    maxItems : 2
> +
> +  reset-names:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      enum: [ qspi, qspi-ocp ]
> +
> +# subnode's properties
> +patternProperties:
> +  "@[0-9a-f]+$":
> +    type: object
> +    description:
> +      flash device uses the subnodes below defined properties.
> +    properties:
> +      cdns,read-delay:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Delay for read capture logic, in clock cycles.
> +
> +      cdns,tshsl-ns:
> +        description:
> +          Delay in nanoseconds for the length that the master mode chip select
> +          outputs are de-asserted between transactions.
> +
> +      cdns,tsd2d-ns:
> +        description:
> +          Delay in nanoseconds between one chip select being de-activated
> +          and the activation of another.
> +
> +      cdns,tchsh-ns:
> +        description:
> +          Delay in nanoseconds between last bit of current transaction and
> +          deasserting the device chip select (qspi_n_ss_out).
> +
> +      cdns,tslch-ns:
> +        description:
> +          Delay in nanoseconds between setting qspi_n_ss_out low and
> +          first bit transfer.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - cdns,fifo-depth
> +  - cdns,fifo-width
> +  - cdns,trigger-address
> +  - cdns,is-decoded-cs
> +  - cdns,rclk-en
> +  - resets
> +  - reset-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    qspi: spi@ff705000 {
> +      compatible = "cadence,qspi","cdns,qpsi-nor";

And since the compatible strings here are both wrong, this schema is 
never applied to the example. :(

> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      reg = <0xff705000 0x1000>,
> +            <0xffa00000 0x1000>;
> +      interrupts = <0 151 4>;
> +      clocks = <&qspi_clk>;
> +      cdns,fifo-depth = <128>;
> +      cdns,fifo-width = <4>;
> +      cdns,trigger-address = <0x00000000>;
> +      resets = <&rst 0x1>, <&rst 0x2>;
> +      reset-names = "qspi", "qspi-ocp";
> +
> +      flash@0 {
> +              compatible = "jedec,spi-nor";
> +              reg = <0x0>;
> +              cdns,read-delay = <4>;
> +              cdns,tshsl-ns = <50>;
> +              cdns,tsd2d-ns = <50>;
> +              cdns,tchsh-ns = <4>;
> +              cdns,tslch-ns = <4>;
> +     };
> +
> +    };
> +
> +...
> -- 
> 2.11.0
> 
