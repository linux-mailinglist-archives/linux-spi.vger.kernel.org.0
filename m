Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBD218BF91
	for <lists+linux-spi@lfdr.de>; Thu, 19 Mar 2020 19:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbgCSSoy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Mar 2020 14:44:54 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:33588 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgCSSoy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 19 Mar 2020 14:44:54 -0400
Received: by mail-il1-f195.google.com with SMTP id k29so3288039ilg.0;
        Thu, 19 Mar 2020 11:44:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bVPAncL4ha8NzXJXnSG+TdF+CX13q8qFXUMxFUpVobg=;
        b=H7xIHM+Ak0f/wWrmPCNoeDqlX+W6MNpcmbCbDKBJehYJwq77ItAB6IcfNzxTLOAR7y
         kNz57vNR/I0O5+3bpiwGGuZ6Av/SbAJgp4bsEmTtP/ajmJ7FtsAoHH493ABR/ejlR7RP
         NvKAyK2ZQZ2oiZpJ8sJnV0RVonZaIGmM0aD3x/wFhcyoKsByBZKlHYVBgJC4/hG36ySN
         NW8nYY1cKffkleadeyNUXTb0I8/9rDUWKLs2fCAdxAqoyCgCSO0vJyqqLngwtQZdizhI
         lS9/JmuvihM+5j7rfQyMtCqFby5SeLO00NcsZvtEY06BL2DOYPzMXI9SXg4nvgGeNXVv
         VjiA==
X-Gm-Message-State: ANhLgQ37oi/gKFInZlfSBinymvuahp2WCpkQ7ZMZseuQASCdIydGCc5G
        7K4Vb7RkG3a/VEzMypVVUmhR/SU=
X-Google-Smtp-Source: ADFU+vvu4Vv92C+H/lSWRi/W8dPRz5KT9K9C6qwdOT/iLO8CZnHanXV9AtW71HUA3ivLh8Qpd7lmPQ==
X-Received: by 2002:a92:b61d:: with SMTP id s29mr4542370ili.66.1584643492422;
        Thu, 19 Mar 2020 11:44:52 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id s69sm1150358ill.73.2020.03.19.11.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 11:44:51 -0700 (PDT)
Received: (nullmailer pid 10183 invoked by uid 1000);
        Thu, 19 Mar 2020 18:44:48 -0000
Date:   Thu, 19 Mar 2020 12:44:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        broonie@kernel.org, vigneshr@ti.com, devicetree@vger.kernel.org,
        boris.brezillon@free-electrons.com,
        simon.k.r.goldschmidt@gmail.com, dinguyen@kernel.org,
        tien.fong.chee@intel.com, marex@denx.de,
        linux-mtd@lists.infradead.org, dwmw2@infradead.org, richard@nod.at,
        computersforpeace@gmail.com, cyrille.pitchen@atmel.com,
        david.oberhollenzer@sigma-star.at, miquel.raynal@bootlin.com,
        tudor.ambarus@gmail.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
Subject: Re: [PATCH v12 1/4] dt-bindings: spi: Add schema for Cadence QSPI
 Controller driver
Message-ID: <20200319184448.GA25121@bogus>
References: <20200310015213.1734-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200310015213.1734-2-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310015213.1734-2-vadivel.muruganx.ramuthevar@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Mar 10, 2020 at 09:52:10AM +0800, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Add dt-bindings documentation for Cadence-QSPI controller to support
> spi based flash memories.
> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> ---
>  .../devicetree/bindings/mtd/cadence-quadspi.txt    |  67 -----------
>  .../devicetree/bindings/spi/cdns,qspi-nor.yaml     | 127 +++++++++++++++++++++
>  2 files changed, 127 insertions(+), 67 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt b/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
> deleted file mode 100644
> index 945be7d5b236..000000000000
> --- a/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
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
> diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> new file mode 100644
> index 000000000000..d21f80604af4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> @@ -0,0 +1,127 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/spi/cdns,qspi-nor.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Cadence QSPI Flash Controller support
> +
> +maintainers:
> +  - Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> +
> +allOf:
> +  - $ref: "spi-controller.yaml#"
> +
> +description: |
> +  Binding Documentation for Cadence QSPI controller,This controller is
> +  present in the Intel LGM, Altera SoCFPGA and TI SoCs and this driver
> +  has been tested On Intel's LGM SoC.
> +
> +properties:
> +  compatible:
> +     enum:
> +       - cdns,qspi-nor
> +       - ti,k2g-qspi
> +       - ti,am654-ospi
> +       - intel,lgm-qspi
> +
> +  reg:
> +    maxItems: 2
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  cdns,fifo-depth:
> +    description:
> +     Depth of hardware FIFOs.
> +    allOf:
> +      - $ref: "/schemas/types.yaml#/definitions/uint32"
> +      - enum: [ 128, 256 ]
> +      - default: 128
> +
> +  cdns,fifo-width:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      4 byte bus width of the data FIFO in bytes.
> +
> +  cdns,trigger-address:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      32-bit indirect AHB trigger address.
> +
> +  cdns,rclk-en:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Flag to indicate that QSPI return clock is used to latch the read data
> +      rather than the QSPI clock. Make sure that QSPI return clock is populated
> +      on the board before using this property.

Sounds like a boolean rather than a uint32? If not, then constraints on 
the values?

> +# subnode's properties
> +patternProperties:
> +  "^.*@[0-9a-fA-F]+$":

How many chip selects do you support? The unit-address can be limited as 
I'd guess it's less than 16. Also, should be lowercase hex.

> +    type: object
> +    description:
> +      flash device uses the subnodes below defined properties.
> +
> +  cdns,read-delay:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Delay in 4 microseconds, read capture logic, in clock cycles.

4us or clock cycles?

> +
> +  cdns,tshsl-ns:
> +    description: |
> +      Delay in 50 nanoseconds, for the length that the master mode chip select
> +      outputs are de-asserted between transactions.

Sounds like you can add:

multipleOf: 50

> +
> +  cdns,tsd2d-ns:
> +    description: |
> +      Delay in 50 nanoseconds, between one chip select being de-activated
> +      and the activation of another.

Same here

> +
> +  cdns,tchsh-ns:
> +    description: |
> +      Delay in 4 nanoseconds, between last bit of current transaction and
> +      deasserting the device chip select (qspi_n_ss_out).

multipleOf: 4

> +
> +  cdns,tslch-ns:
> +    description: |
> +      Delay in 4 nanoseconds, between setting qspi_n_ss_out low and
> +      first bit transfer.

multipleOf: 4

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - cdns,fifo-depth
> +  - cdns,fifo-width
> +  - cdns,trigger-address
> +
> +examples:
> +  - |
> +    qspi: spi@ff705000 {

Drop the label.

> +          compatible = "cdns,qspi-nor";
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +          reg = <0xff705000 0x1000>,
> +                <0xffa00000 0x1000>;
> +          interrupts = <0 151 4>;
> +          clocks = <&qspi_clk>;
> +          cdns,fifo-depth = <128>;
> +          cdns,fifo-width = <4>;
> +          cdns,trigger-address = <0x00000000>;
> +
> +          flash0: n25q00@0 {

flash@0

> +              compatible = "jedec,spi-nor";
> +              reg = <0x0>;
> +              cdns,read-delay = <4>;
> +              cdns,tshsl-ns = <50>;
> +              cdns,tsd2d-ns = <50>;
> +              cdns,tchsh-ns = <4>;
> +              cdns,tslch-ns = <4>;
> +          };
> +    };
> +
> -- 
> 2.11.0
> 
