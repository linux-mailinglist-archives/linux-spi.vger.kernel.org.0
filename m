Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701A439C280
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jun 2021 23:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhFDVfQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Jun 2021 17:35:16 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:38624 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbhFDVfP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 4 Jun 2021 17:35:15 -0400
Received: by mail-oi1-f169.google.com with SMTP id z3so11122344oib.5;
        Fri, 04 Jun 2021 14:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yl1E+/xnYu7Cfj8L3sXh+2OycadFjPBoqVGF2DbUphQ=;
        b=uYRZfVZ11AA+PGf9/9Rgwk6bCPmHa0fObUNFU8CAwbLvr2OGDMZkdthQEYfucuOxar
         ITy1A1TqZYFqiGQp+Cx8vXbX0oPtQgt/owO8MwW2s4S2THMvUaf7Fta8oF2EIHMsahge
         g1wgMrPsYrRZu3IexhgJhSxyOyHXBsHk0rBBXh8ib0DbdzOqQjkcfUunAtbC0g9qQs1Q
         3iNkaXTrsRaqupNpJRIHbylwQJGHzJlHVYS2d5yg2osrcrngo2SqgPIcBXK/uh4bV0UC
         H8y1YchVOlzr6s3KekMbb0BI2WZuOH3Ip/PkQ2B9qfJSLGyE/4Y82pq8jT48A/sK54+r
         tJzg==
X-Gm-Message-State: AOAM531USpZbJqrxIftYW6625oo6JOIy3KT7QBuFzt9m/TnL2paa6E+L
        yvGLgqCOgKLYPt48JNCGSA==
X-Google-Smtp-Source: ABdhPJzT4hhLaDtnWMfnUW/Sd3qDYSN5G+BsQqA2RfpT8A8PmgMlxP5SXEXFQoRxBNK0horm5fdLUg==
X-Received: by 2002:a05:6808:1492:: with SMTP id e18mr4465809oiw.114.1622842408297;
        Fri, 04 Jun 2021 14:33:28 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y17sm717993oih.54.2021.06.04.14.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 14:33:27 -0700 (PDT)
Received: (nullmailer pid 3959202 invoked by uid 1000);
        Fri, 04 Jun 2021 21:33:26 -0000
Date:   Fri, 4 Jun 2021 16:33:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: spi: xilinx: convert to yaml
Message-ID: <20210604213326.GA3957165@robh.at.kernel.org>
References: <20210531052142.695430-1-iwamatsu@nigauri.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531052142.695430-1-iwamatsu@nigauri.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, May 31, 2021 at 02:21:42PM +0900, Nobuhiro Iwamatsu wrote:
> Convert SPI for Xilinx bindings documentation to YAML schemas.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> ---
>  .../devicetree/bindings/spi/spi-xilinx.txt    | 23 ---------
>  .../devicetree/bindings/spi/spi-xilinx.yaml   | 51 +++++++++++++++++++
>  2 files changed, 51 insertions(+), 23 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-xilinx.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-xilinx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-xilinx.txt b/Documentation/devicetree/bindings/spi/spi-xilinx.txt
> deleted file mode 100644
> index 5f4ed3e5c9942c..00000000000000
> --- a/Documentation/devicetree/bindings/spi/spi-xilinx.txt
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -Xilinx SPI controller Device Tree Bindings
> --------------------------------------------------
> -
> -Required properties:
> -- compatible		: Should be "xlnx,xps-spi-2.00.a", "xlnx,xps-spi-2.00.b" or "xlnx,axi-quad-spi-1.00.a"
> -- reg			: Physical base address and size of SPI registers map.
> -- interrupts		: Property with a value describing the interrupt
> -			  number.
> -
> -Optional properties:
> -- xlnx,num-ss-bits	 : Number of chip selects used.
> -- xlnx,num-transfer-bits : Number of bits per transfer. This will be 8 if not specified
> -
> -Example:
> -	axi_quad_spi@41e00000 {
> -			compatible = "xlnx,xps-spi-2.00.a";
> -			interrupt-parent = <&intc>;
> -			interrupts = <0 31 1>;
> -			reg = <0x41e00000 0x10000>;
> -			xlnx,num-ss-bits = <0x1>;
> -			xlnx,num-transfer-bits = <32>;
> -	};
> -
> diff --git a/Documentation/devicetree/bindings/spi/spi-xilinx.yaml b/Documentation/devicetree/bindings/spi/spi-xilinx.yaml
> new file mode 100644
> index 00000000000000..17463151b36a02
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-xilinx.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/spi-xilinx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx SPI controller Device Tree Bindings
> +
> +maintainers:
> +  - Michal Simek <michal.simek@xilinx.com>
> +
> +allOf:
> +  - $ref: "spi-controller.yaml#"
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: xlnx,xps-spi-2.00.a
> +      - const: xlnx,xps-spi-2.00.b
> +      - const: xlnx,axi-quad-spi-1.00.a

Use enum instead of oneOf+const.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  xlnx,num-ss-bits:
> +    description: Number of chip selects used.

Constraints? 0-2^32 is good?

> +
> +  xlnx,num-transfer-bits:
> +    description: Number of bits per transfer. This will be 8 if not specified.

Constraints?

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi0: spi@41e00000 {
> +      compatible = "xlnx,xps-spi-2.00.a";
> +      interrupt-parent = <&intc>;
> +      interrupts = <0 31 1>;
> +      reg = <0x41e00000 0x10000>;
> +      xlnx,num-ss-bits = <0x1>;
> +      xlnx,num-transfer-bits = <32>;
> +    };
> +...
> -- 
> 2.30.0
