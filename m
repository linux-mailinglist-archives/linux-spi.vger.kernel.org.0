Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C3F39C2D5
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jun 2021 23:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhFDVr5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Jun 2021 17:47:57 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:46774 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbhFDVr5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 4 Jun 2021 17:47:57 -0400
Received: by mail-oi1-f178.google.com with SMTP id c13so5607693oib.13;
        Fri, 04 Jun 2021 14:46:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MxgELyl9ZDNqb+JhNnsjnlPROT2DhakY1WRv9qMjO0o=;
        b=pIVFPAcNLGFK7gX4I5Cjh2uDm7W3lDO/R544953UPhjgfWvvL/qAa8X7n2tXCjizoi
         2Obeuy8OhSsiXB5t69dkqfm1yIKI4OvPr8fR+V3eaT2kADFFm73/jrjOp3w0GF3yFOvl
         A2xOY2cUvo1x0CHJryEjte/Ocmb5hQjBbNJwz3QJOsa2Z5WjcIodqtQfUpuBiH9UlJo2
         9fKrGghfwG+EHZ53Q4+tUua5Zhab6NsqtgF6X0PPxNFKBUiUVYfamtxFAwhCwpqdVcH5
         +RCgyVqB7xdo6GyFA1xbYJxg9WsKHZaNpHOO3iN6bZOeVfj+3RgsIFP8X/YvnfP1Ww0B
         97nQ==
X-Gm-Message-State: AOAM530/XaH+ZFoCdRAyWSzBTEDNK4ju4l8HagC1YhGaVZv8wHLVLYtW
        PjxG10l+aPNWrAFdD7wtwA==
X-Google-Smtp-Source: ABdhPJybUqJWZvBq74kjHndi571LzDfY6PMchE2P6H5ykzbgzu5zwjVbZ/u+xwihB6VH2rMS6e1ZHA==
X-Received: by 2002:aca:670d:: with SMTP id z13mr12405152oix.24.1622843170228;
        Fri, 04 Jun 2021 14:46:10 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s15sm117977oih.15.2021.06.04.14.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 14:46:09 -0700 (PDT)
Received: (nullmailer pid 3979057 invoked by uid 1000);
        Fri, 04 Jun 2021 21:46:08 -0000
Date:   Fri, 4 Jun 2021 16:46:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Harini Katakam <harinik@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: spi: convert Cadence SPI bindings to YAML
Message-ID: <20210604214608.GA3974358@robh.at.kernel.org>
References: <20210531141538.721613-1-iwamatsu@nigauri.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531141538.721613-1-iwamatsu@nigauri.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, May 31, 2021 at 11:15:38PM +0900, Nobuhiro Iwamatsu wrote:
> Convert spi for Cadence SPI bindings documentation to YAML.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> ---
>  .../devicetree/bindings/spi/spi-cadence.txt   | 30 ---------
>  .../devicetree/bindings/spi/spi-cadence.yaml  | 63 +++++++++++++++++++
>  2 files changed, 63 insertions(+), 30 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-cadence.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-cadence.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-cadence.txt b/Documentation/devicetree/bindings/spi/spi-cadence.txt
> deleted file mode 100644
> index 05a2ef945664be..00000000000000
> --- a/Documentation/devicetree/bindings/spi/spi-cadence.txt
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -Cadence SPI controller Device Tree Bindings
> --------------------------------------------
> -
> -Required properties:
> -- compatible		: Should be "cdns,spi-r1p6" or "xlnx,zynq-spi-r1p6".
> -- reg			: Physical base address and size of SPI registers map.
> -- interrupts		: Property with a value describing the interrupt
> -			  number.
> -- clock-names		: List of input clock names - "ref_clk", "pclk"
> -			  (See clock bindings for details).
> -- clocks		: Clock phandles (see clock bindings for details).
> -
> -Optional properties:
> -- num-cs		: Number of chip selects used.
> -			  If a decoder is used, this will be the number of
> -			  chip selects after the decoder.
> -- is-decoded-cs		: Flag to indicate whether decoder is used or not.
> -
> -Example:
> -
> -	spi@e0007000 {
> -		compatible = "xlnx,zynq-spi-r1p6";
> -		clock-names = "ref_clk", "pclk";
> -		clocks = <&clkc 26>, <&clkc 35>;
> -		interrupt-parent = <&intc>;
> -		interrupts = <0 49 4>;
> -		num-cs = <4>;
> -		is-decoded-cs = <0>;
> -		reg = <0xe0007000 0x1000>;
> -	} ;
> diff --git a/Documentation/devicetree/bindings/spi/spi-cadence.yaml b/Documentation/devicetree/bindings/spi/spi-cadence.yaml
> new file mode 100644
> index 00000000000000..27a7121ed0f9ae
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-cadence.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/spi-cadence.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cadence SPI controller Device Tree Bindings
> +
> +maintainers:
> +  - Michal Simek <michal.simek@xilinx.com>
> +
> +allOf:
> +  - $ref: "spi-controller.yaml#"
> +
> +properties:
> +  compatible:
> +    enum:
> +      - cdns,spi-r1p6
> +      - xlnx,zynq-spi-r1p6
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: ref_clk
> +      - const: pclk
> +
> +  clocks:
> +    maxItems: 2
> +
> +  num-cs:
> +    description: |
> +      Number of chip selects used. If a decoder is used,
> +      this will be the number of chip selects after the
> +      decoder.
> +    minimum: 1
> +    maximum: 4
> +    default: 4
> +
> +  is-decoded-cs:

Needs a type ref. Despite being called a 'flag' looks like it's an 
uint32. Presumably, it also needs:

enum: [ 0, 1 ]

> +    description: |
> +      Flag to indicate whether decoder is used or not.
> +    default: 0
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi@e0007000 {
> +      compatible = "xlnx,zynq-spi-r1p6";
> +      clock-names = "ref_clk", "pclk";
> +      clocks = <&clkc 26>, <&clkc 35>;
> +      interrupt-parent = <&intc>;
> +      interrupts = <0 49 4>;
> +      num-cs = <4>;
> +      is-decoded-cs = <0>;
> +      reg = <0xe0007000 0x1000>;
> +    };
> +...
> -- 
> 2.30.0
