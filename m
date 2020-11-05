Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5102A8634
	for <lists+linux-spi@lfdr.de>; Thu,  5 Nov 2020 19:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgKESkj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Nov 2020 13:40:39 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:35305 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgKESkj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 5 Nov 2020 13:40:39 -0500
Received: by mail-ot1-f45.google.com with SMTP id n11so2381258ota.2;
        Thu, 05 Nov 2020 10:40:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ROW7gLPvsixXdOUBku/rceehiE2QxPW3Gr2HLN1Tahs=;
        b=mSt/L5p0O8x1DGOmS5hS78Sl6QNnnDB0f2bUIrwhjbDvO3TV6i6spCSDainhHUBdwA
         1WUj4fVYQ9B2Vu9hi5QsWM/Wynxofzw0m7J24I+IOoZ2tKD9HjbtMCER3nbCsjD/VhMe
         drhiZJzQDBu9fGD4qa6+UaERCp52JEx5BJD0xYRn00ozxTO8PtV90emKXcl29CNVuiEc
         g3Rf6rhR/nZ0MwfqghelqnT3NBCasj74k8mIvYguazqu4/u+7TlVQ4il6u1TCZ/al1Qt
         h5/pEHYqa1+JYf6CAbE/oeMVxrOdcmYKgttr3uor438kSvwnQh6v2ussxmVPyyYE7kjk
         8QhQ==
X-Gm-Message-State: AOAM530jLUKLJNYVMdoX5EFUtwNwUDax2+Yd3Mgm1RpK4GT53dZUEFQS
        +ndUtytzfGGUjnhKl4nPXO4M6gJEZsBA
X-Google-Smtp-Source: ABdhPJwG1vUWe+mtCQWNMutnJxx2eoLNJArHfDOqxJL78DdzeDgv3gng8hQNHFIW5vfeIqU7slQlcQ==
X-Received: by 2002:a9d:7d87:: with SMTP id j7mr2645271otn.356.1604601638458;
        Thu, 05 Nov 2020 10:40:38 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s26sm530580ood.38.2020.11.05.10.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 10:40:37 -0800 (PST)
Received: (nullmailer pid 1609469 invoked by uid 1000);
        Thu, 05 Nov 2020 18:40:36 -0000
Date:   Thu, 5 Nov 2020 12:40:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Cc:     broonie@kernel.org, joel@jms.id.au, andrew@aj.id.au, clg@kaod.org,
        bbrezillon@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-spi@vger.kernel.org, BMC-SW@aspeedtech.com
Subject: Re: [v2 1/4] dt-bindings: spi: Add binding file for ASPEED FMC/SPI
 memory controller
Message-ID: <20201105184036.GA1607865@bogus>
References: <20201103072202.24705-1-chin-ting_kuo@aspeedtech.com>
 <20201103072202.24705-2-chin-ting_kuo@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103072202.24705-2-chin-ting_kuo@aspeedtech.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Nov 03, 2020 at 03:21:59PM +0800, Chin-Ting Kuo wrote:
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

Need to define how many clocks (maxItems: 1).

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
