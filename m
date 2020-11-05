Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F182A8A01
	for <lists+linux-spi@lfdr.de>; Thu,  5 Nov 2020 23:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731965AbgKEWjx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Nov 2020 17:39:53 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:43680 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731694AbgKEWjx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 5 Nov 2020 17:39:53 -0500
Received: by mail-ot1-f42.google.com with SMTP id y22so2975695oti.10;
        Thu, 05 Nov 2020 14:39:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l33mjh6Y58sdX7p0bIXXnh8X4f5mWO8LY9kaS0QVJ4A=;
        b=HAIAXnYDTRlzC4F32MR8xWnVa3x5nLYSwbhJiDHTlWHaw7UOn2Sxj3TrbGxFKSS1pQ
         lFjeLzbm8TADlbO3LtTdDqoLa17tnhtF3ehuUsWEb2lIjef7vqaB2015gdXtZZzlwpj4
         U/Kp4XDSB4I1fwcBUWc/8VGXvHFSZjsn/Rd4XGGfCYdlR6lELzep21dXRjr7IeuhmDCX
         5ooAot2uBShQBQZY55Ol5xNV4faVx0M8Q935SyXwv+Xqxchl7NOCjL1QgRI9KsBRvGVY
         unx9mzh/JuEPpPQ8+PhxwetSEdXwu2Bf8uShkcjbF3eiunb18HsjJXHizOcA8D5THE8c
         ot8w==
X-Gm-Message-State: AOAM530fRtDJssuEB6x8N6RS0XuYuy3l9VOohPXUayxLLs2tefQwEGNj
        3XBdnVSxdRFvLvwz7SxWoRx1ANaJ1CM7
X-Google-Smtp-Source: ABdhPJzDd/toUHUVegfNxYe5pmvS84hMCVzJYSgsN1/BIcuceQS9+OMgPmZABerM5vzQWRnLkG768w==
X-Received: by 2002:a9d:17c5:: with SMTP id j63mr3430400otj.9.1604615992062;
        Thu, 05 Nov 2020 14:39:52 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x190sm693150oia.35.2020.11.05.14.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 14:39:50 -0800 (PST)
Received: (nullmailer pid 1931122 invoked by uid 1000);
        Thu, 05 Nov 2020 22:39:49 -0000
Date:   Thu, 5 Nov 2020 16:39:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Cc:     broonie@kernel.org, joel@jms.id.au, andrew@aj.id.au, clg@kaod.org,
        bbrezillon@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-spi@vger.kernel.org, BMC-SW@aspeedtech.com
Subject: Re: [v3 1/4] dt-bindings: spi: Add binding file for ASPEED FMC/SPI
 memory controller
Message-ID: <20201105223949.GA1927504@bogus>
References: <20201105120331.9853-1-chin-ting_kuo@aspeedtech.com>
 <20201105120331.9853-2-chin-ting_kuo@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105120331.9853-2-chin-ting_kuo@aspeedtech.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Nov 05, 2020 at 08:03:28PM +0800, Chin-Ting Kuo wrote:
> Create binding file with YAML syntax for ASPEED FMC/SPI memory controller.
> 
> Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> ---
>  .../bindings/spi/aspeed,spi-aspeed.yaml       | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/aspeed,spi-aspeed.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/aspeed,spi-aspeed.yaml b/Documentation/devicetree/bindings/spi/aspeed,spi-aspeed.yaml
> new file mode 100644
> index 000000000000..41b9692c7226
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/aspeed,spi-aspeed.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/aspeed,spi-aspeed.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SPI memory controller for ASPEED SoCs
> +
> +maintainers:
> +  - Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> +
> +description: |
> +  There are three SPI memory controllers embedded in a ASPEED SoC.
> +  They are usually connected to SPI NOR flashes. Each of them has
> +  more than a chip select. They also support SPI single, dual and
> +  quad IO modes for SPI NOR flash.
> +
> +allOf:
> +  - $ref: /spi/spi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:

You can drop oneOf (there's only 1) and items.

> +          - enum:
> +              - aspeed,ast2600-fmc
> +              - aspeed,ast2600-spi
> +
> +  reg:
> +    items:
> +      - description: the control register location and length
> +      - description: the flash memory mapping address and length
> +
> +  clocks:
> +    description: AHB bus clock which will be converted to SPI bus clock

maxItems: 1

Constraints on num-cs values? Or up to 2^32 is good?

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - num-cs
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/ast2600-clock.h>
> +    spi1: spi@1e630000 {
> +      compatible = "aspeed,ast2600-spi";
> +      reg = <0x1e630000 0xc4>, <0x30000000 0x10000000>;
> +      reg-names = "spi_ctrl_reg", "spi_mmap";
> +      clocks = <&syscon ASPEED_CLK_AHB>;
> +      num-cs = <2>;
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      flash@0 {
> +        compatible = "jedec,spi-nor";
> +        reg = <0>;
> +        spi-max-frequency = <50000000>;
> +      };
> +      flash@1 {
> +        compatible = "jedec,spi-nor";
> +        reg = <1>;
> +        spi-max-frequency = <50000000>;
> +      };
> +    };
> -- 
> 2.17.1
> 
