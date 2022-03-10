Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D34C4D542B
	for <lists+linux-spi@lfdr.de>; Thu, 10 Mar 2022 23:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243632AbiCJWJs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Mar 2022 17:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbiCJWJq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Mar 2022 17:09:46 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0C25FF0B;
        Thu, 10 Mar 2022 14:08:44 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id i5so7467876oih.1;
        Thu, 10 Mar 2022 14:08:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GztXpK6SPTIyxzIRwB00EenGjs45KWX35sMuyhlmPpU=;
        b=GZ75RRYfoVt+a2ZrusJwWltreHe5l+V6aVFQl9kog+uJyH6SamfT2u2zBusSZ2kLQ5
         iYA8ki1IG/OCjaoo1dsgzvDYD6cReUFwTQaMYFpjTm0d2rQ9++7ePRulwJks+WK2ZuSP
         ilMOKCwOGxfWZlYjEewxwBYI6rvSTZPAsVkKr5anMno+yGwz4NGzLvFUSmIcdj0FVx0N
         2YVBfl3aGxwYvcUZL9gI6RadbLWnDU0P2sIYYJiqWJOd2aUHDRT4ZJenNpwwZg2yYAhD
         N0hwURvUZTvAHk6O3jGCntHvCmZYADvqkYB2xzZAb+CMmqqAOQWE7nTGK5PNIu+amrG3
         3YZg==
X-Gm-Message-State: AOAM532bl+OKbBX/PoGe+YMRY0WxX9g8yrvmPLxYSjn13wlBfVcmt+JM
        xLSjLoOqdtXoEU2+0TeORA==
X-Google-Smtp-Source: ABdhPJwgQc+zfIEQEAib3LEcQDo2r5x+1lCXfEqstYLiqQlMBshBEb5XHipt1XA35c6g6Y5b5JH66w==
X-Received: by 2002:a05:6808:1205:b0:2d4:6eed:edd1 with SMTP id a5-20020a056808120500b002d46eededd1mr4493480oil.154.1646950123843;
        Thu, 10 Mar 2022 14:08:43 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a27-20020a4ae93b000000b0031be7c7d2d3sm3050672ooe.0.2022.03.10.14.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 14:08:43 -0800 (PST)
Received: (nullmailer pid 2169492 invoked by uid 1000);
        Thu, 10 Mar 2022 22:08:42 -0000
Date:   Thu, 10 Mar 2022 16:08:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: spi: Update clock-names property for
 ARM pl022
Message-ID: <Yip26uBIHgt42PDf@robh.at.kernel.org>
References: <20220308072125.38381-1-singh.kuldeep87k@gmail.com>
 <20220308072125.38381-2-singh.kuldeep87k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308072125.38381-2-singh.kuldeep87k@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Mar 08, 2022 at 12:51:25PM +0530, Kuldeep Singh wrote:
> Pl022 clock-names can be one of following:
> ['apb_pclk'] or ['sspclk', 'apb_pclk']
> 
> The current schema refers to second case only. Make necessary changes to
> incorporate both the cases and resolve below dtc warning:
> clock-names: 'apb_pclk' is not one of ['sspclk']
> 
> Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
> ---
> v2:
> - Reword commit message
> - Drop SSPCLK
> 
>  Documentation/devicetree/bindings/spi/spi-pl022.yaml | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-pl022.yaml b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
> index 7d36e15db5b3..6cfab948624e 100644
> --- a/Documentation/devicetree/bindings/spi/spi-pl022.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
> @@ -38,11 +38,13 @@ properties:
>      maxItems: 2
>  
>    clock-names:
> -    items:
> +    oneOf:
>        - enum:
> -          - SSPCLK
> -          - sspclk
> -      - const: apb_pclk
> +          - apb_pclk

Are you going to make the driver work with no SPI clock? Because this 
change is saying that it is valid to have the APB bus clock and no SPI 
clock.

Rob

> +      - items:
> +          - enum:
> +              - sspclk
> +          - const: apb_pclk
>  
>    pl022,autosuspend-delay:
>      description: delay in ms following transfer completion before the
> -- 
> 2.25.1
> 
> 
