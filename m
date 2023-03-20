Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC836C1B12
	for <lists+linux-spi@lfdr.de>; Mon, 20 Mar 2023 17:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjCTQQM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Mar 2023 12:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjCTQPr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Mar 2023 12:15:47 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3912BEEF;
        Mon, 20 Mar 2023 09:05:24 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id m20-20020a9d6094000000b0069caf591747so7002710otj.2;
        Mon, 20 Mar 2023 09:05:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679328322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMy/XUwZdz1opl6uF+cUXlOpU4U5F/wKGlLbUO4FxC8=;
        b=cYSOy2VidldSHZI31QRJ4Rz8SOFTZoWGMai4INJtD2y9iQZ+GfjLJF45JeB81lIXaL
         Eup9WOhLHdj8ogWExMHs+HjjgSizwNlK/r1njI1yhvDoaQfxi94xmnUHyYdTE03mLpKD
         nnl828i2ngOfPS8yvMMGOWMRX8kTDNKzYCwZZpCeiijDuuPK7j3805lsc3pVscwPS5E9
         4wXTYDB62bcbvCUYzKt9fXrh6oD7jgjKzH/pvW5pkFCmPQDa8sIgn0auFK65K7om6FY3
         tbl6DjpKrgNWHXG3tXn4hIVW0T2cx8EzOjupq+YlKBUzDjsafnZ7SPbu4Sbrk18O0IzQ
         DlDw==
X-Gm-Message-State: AO0yUKW3JfCVCVR5rahn+ZW+vqve/4ksLgMMWJt24/iZmXbCYkQEWIKW
        PWdYkUuClArOqUmo1sF+Eg==
X-Google-Smtp-Source: AK7set9PuVuQ7ZP4TdzOFsM+8Y3IhncWSBadOo5fQTAJHd734GfGDGag/kuUsYlsOqbiHu1TfLfNlw==
X-Received: by 2002:a05:6830:1bc1:b0:69e:cb8:afa2 with SMTP id v1-20020a0568301bc100b0069e0cb8afa2mr110841ota.18.1679328322633;
        Mon, 20 Mar 2023 09:05:22 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w23-20020a056830111700b0068664355604sm4162542otq.22.2023.03.20.09.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 09:05:22 -0700 (PDT)
Received: (nullmailer pid 1785496 invoked by uid 1000);
        Mon, 20 Mar 2023 16:05:21 -0000
Date:   Mon, 20 Mar 2023 11:05:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: spi: renesas,sh-msiof: Miscellaneous
 improvements
Message-ID: <20230320160521.GA1771933-robh@kernel.org>
References: <052af97ecbaa9ba6e0d406883dd3389fa397579a.1678891999.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <052af97ecbaa9ba6e0d406883dd3389fa397579a.1678891999.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Mar 15, 2023 at 03:54:07PM +0100, Geert Uytterhoeven wrote:
> Make "clocks" and "power-domains" required everywhere.
> Make "resets" required on R-Car Gen2 and newer (i.e. all but SH-Mobile).

Breaking the ABI is fine because ???

> 
> Update the example to match reality:
>   - Use interrupt binding definitions instead of hardcoded numbers,
>   - Convert to new-style CPG/MSSR bindings,
>   - Add missing "power-domains" and "resets" properties.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  .../bindings/spi/renesas,sh-msiof.yaml        | 23 +++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml b/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
> index 491a695a2deb3b83..00acbbb0f65dcf57 100644
> --- a/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
> +++ b/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
> @@ -149,23 +149,38 @@ required:
>    - compatible
>    - reg
>    - interrupts
> +  - clocks
> +  - power-domains
>    - '#address-cells'
>    - '#size-cells'
>  
> +if:
> +  not:
> +    properties:
> +      compatible:
> +        contains:
> +          const: renesas,sh-mobile-msiof
> +then:
> +  required:
> +    - resets
> +
>  unevaluatedProperties: false
>  
>  examples:
>    - |
> -    #include <dt-bindings/clock/r8a7791-clock.h>
> -    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/clock/r8a7791-cpg-mssr.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/power/r8a7791-sysc.h>
>  
>      msiof0: spi@e6e20000 {
>          compatible = "renesas,msiof-r8a7791", "renesas,rcar-gen2-msiof";
>          reg = <0xe6e20000 0x0064>;
> -        interrupts = <0 156 IRQ_TYPE_LEVEL_HIGH>;
> -        clocks = <&mstp0_clks R8A7791_CLK_MSIOF0>;
> +        interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&cpg CPG_MOD 000>;
>          dmas = <&dmac0 0x51>, <&dmac0 0x52>;
>          dma-names = "tx", "rx";
> +        power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
> +        resets = <&cpg 0>;
>          #address-cells = <1>;
>          #size-cells = <0>;
>      };
> -- 
> 2.34.1
> 
