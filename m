Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92A61D9FC6
	for <lists+linux-spi@lfdr.de>; Tue, 19 May 2020 20:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgESSoT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 May 2020 14:44:19 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33351 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgESSoS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 19 May 2020 14:44:18 -0400
Received: by mail-io1-f67.google.com with SMTP id k18so325628ion.0;
        Tue, 19 May 2020 11:44:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oKuBz8CT4YNMj4ZnHpQjCUGYGAJGXHvYzlhr9H8ejRA=;
        b=VvKApy1g052cmGUkI8jjuHcNVTEiReCnlEQBMOlbxZk3x5ShNDMWJJJ+GLSYd6ixMB
         JkCwv0buwn4q6rek2ia2urmDVlmTwZ1Wd9YiHXl+RBxf4/v7VfEr+nMg9KdV7OpX5IMJ
         TsoJi/Txm53DQd4Ab1s/FciAgPMS6AIxccFeqWusfea6Lwz2VoiKD68wNHo+v4fshnFA
         ixG9t20OODD6so9N4byYE9+Canj3pTQd1tF/Ci2Qv6xn6hNhsfVfjC/meC7SQQGdEQDz
         lTQQO19D94kz5bCEVhZDsbRmyG4ESg9Do07+GFMG7lNzv/b2aJe2DV4EUb2rkPCFFj0C
         rujQ==
X-Gm-Message-State: AOAM533yQl4vCTbOX6aVJPZ4WPHDepnwW8nc2gbJwhCex0TMCau3wtwm
        E2PAU8/ZbFBxOvhEExnsgQ==
X-Google-Smtp-Source: ABdhPJw2lGHq+eIu05e783dq35VMFsu2OhQXKoEWACYt2JqvIlpVB8GFIMm53lfTjTenTunwatMR+A==
X-Received: by 2002:a05:6638:44e:: with SMTP id r14mr1046656jap.53.1589913857137;
        Tue, 19 May 2020 11:44:17 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id k16sm182001iog.14.2020.05.19.11.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 11:44:16 -0700 (PDT)
Received: (nullmailer pid 452653 invoked by uid 1000);
        Tue, 19 May 2020 18:44:15 -0000
Date:   Tue, 19 May 2020 12:44:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        vigneshr@ti.com, broonie@kernel.org, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
Subject: Re: [PATCH v1] dt-bindings: spi: Add schema for Cadence QSPI
 Controller driver
Message-ID: <20200519184415.GA441457@bogus>
References: <20200512004919.40685-1-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512004919.40685-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, May 12, 2020 at 08:49:19AM +0800, Ramuthevar,Vadivel MuruganX wrote:
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
> index 000000000000..28112b38e6a9
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

Need to define what each entry is.

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

...FIFO in words.

> +    allOf:
> +      - $ref: "/schemas/types.yaml#/definitions/uint32"
> +      - enum: [ 128, 256 ]
> +      - default: 128
> +
> +  cdns,fifo-width:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      4 byte bus width of the data FIFO in bytes.

Constraints? Perhaps:

multipleOf: 4

if an enum doesn't work here.

> +
> +  cdns,trigger-address:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      32-bit indirect AHB trigger address.
> +
> +  cdns,rclk-en:
> +    type: boolean
> +    description: |
> +      Flag to indicate that QSPI return clock is used to latch the read data
> +      rather than the QSPI clock. Make sure that QSPI return clock is populated
> +      on the board before using this property.
> +
> +# subnode's properties
> +patternProperties:
> +  "^.*@[0-9a-fa-f]+$":

'a-f' is twice. What's the max number of chip selects? If less than 10, 
then '@[0-9]$' is enough. '^.*' can be dropped too.

> +    type: object
> +    description:
> +      flash device uses the subnodes below defined properties.
> +
> +  cdns,read-delay:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Delay for read capture logic, in clock cycles.
> +
> +  cdns,tshsl-ns:
> +    description: |
> +      Delay in nanoseconds for the length that the master mode chip select
> +      outputs are de-asserted between transactions.
> +
> +  cdns,tsd2d-ns:
> +    description: |
> +      Delay in nanoseconds between one chip select being de-activated
> +      and the activation of another.
> +
> +  cdns,tchsh-ns:
> +    description: |
> +      Delay in nanoseconds between last bit of current transaction and
> +      deasserting the device chip select (qspi_n_ss_out).
> +
> +  cdns,tslch-ns:
> +    description: |
> +      Delay in nanoseconds between setting qspi_n_ss_out low and
> +      first bit transfer.
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
> +    spi@ff705000 {
> +          compatible = "cdns,qspi-nor";
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +          reg = <0xff705000 0x1000>,
> +                <0xffa00000 0x1000>;

Seems kind of small for a data area if this is like most SPI flash 
controllers.

> +          interrupts = <0 151 4>;
> +          clocks = <&qspi_clk>;
> +          cdns,fifo-depth = <128>;
> +          cdns,fifo-width = <4>;
> +          cdns,trigger-address = <0x00000000>;
> +
> +          flash@0 {
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
