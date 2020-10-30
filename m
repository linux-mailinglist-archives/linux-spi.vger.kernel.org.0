Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63A32A09BE
	for <lists+linux-spi@lfdr.de>; Fri, 30 Oct 2020 16:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgJ3P0x (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 30 Oct 2020 11:26:53 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:32790 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbgJ3P0w (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 30 Oct 2020 11:26:52 -0400
Received: by mail-oi1-f193.google.com with SMTP id s21so7060797oij.0;
        Fri, 30 Oct 2020 08:26:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IWy+P3aKBbRZHPdpo7UhZCYAWAA7vOrQ687V0Kfj+d4=;
        b=rYOOoSBkqstcMNH/nv3ldtrCItPKoNhoxaMHwoao9E5ShWq2swu3aaacaOAvYHB5tw
         GQkjbKAdvQUmlXSiaTmUW1B1ov18/dcP91FrzYbq3zdunFw9F8tQHy7NeZHFadrt/gsR
         9kUfuFWPp600gaglSrnr9Pyi/Bz95EvsV027Rga5vSq0Rex6lFLI2qrvPPWH5mDcvg/M
         7bEIp4/3M32gq3UEKaI2DR9vTwIq9vIhOmzAbL8lZbapf4fZv3M844rVfCKwE/DCd3sm
         vG/Ki0NgFX3jTGAQFSMrXajDMsxI4DclNQTigEN/k9Gmm18Z9yiVy5r4KEWYMa353KhO
         ZRWQ==
X-Gm-Message-State: AOAM533h997EFeBDtUVMfVSpBod5TsW7T5UjjUNOuJZkEGe+WF1nOn3v
        Ei+YmSJ/dwBeAI9R5QAq7xfnXrnlDw==
X-Google-Smtp-Source: ABdhPJxny1b0UA2smGz0Vnx/UGlxYxru7MMA1VE6f82QrLATUrGdH2e+mclwmwC7hlceadibHYd78Q==
X-Received: by 2002:aca:ea42:: with SMTP id i63mr1902640oih.130.1604071119098;
        Fri, 30 Oct 2020 08:18:39 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h7sm1409124oop.40.2020.10.30.08.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 08:18:38 -0700 (PDT)
Received: (nullmailer pid 3862951 invoked by uid 1000);
        Fri, 30 Oct 2020 15:18:37 -0000
Date:   Fri, 30 Oct 2020 10:18:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     broonie@kernel.org, vigneshr@ti.com, tudor.ambarus@microchip.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, miquel.raynal@bootlin.com,
        simon.k.r.goldschmidt@gmail.com, dinguyen@kernel.org,
        richard@nod.at, cheol.yong.kim@intel.com, qi-ming.wu@intel.com
Subject: Re: [PATCH v6 5/6] dt-bindings: spi: Convert cadence-quadspi.txt to
 cadence-quadspi.yaml
Message-ID: <20201030151837.GA3854035@bogus>
References: <20201030053153.5319-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201030053153.5319-6-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030053153.5319-6-vadivel.muruganx.ramuthevar@linux.intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Oct 30, 2020 at 01:31:52PM +0800, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Convert the cadence-quadspi.txt documentation to cadence-quadspi.yaml
> remove the cadence-quadspi.txt from Documentation/devicetree/bindings/spi/
> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> ---
>  .../devicetree/bindings/spi/cadence-quadspi.txt    |  67 ---------
>  .../devicetree/bindings/spi/cadence-quadspi.yaml   | 149 +++++++++++++++++++++
>  2 files changed, 149 insertions(+), 67 deletions(-)
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
> index 000000000000..ec22b040d804
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml
> @@ -0,0 +1,149 @@
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

You don't need 'oneOf' if there is only one entry...

So you've dropped 'cdns,qspi-nor' alone being valid. Granted, the txt 
file was fuzzy as to whether or not that was valid. So you have to look 
at all the dts files and see. I prefer we don't allow that and require a 
more specific compatible, but if there's a bunch then we should allow 
for it. The commit message should summarize what you decide.

> +          - enum:
> +              - ti,k2g-qspi
> +              - ti,am654-ospi
> +          - const: cdns,qspi-nor

> +examples:
> +  - |
> +    qspi: spi@ff705000 {
> +      compatible = "cadence,qspi","cdns,qpsi-nor";

And you missed fixing this.

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
