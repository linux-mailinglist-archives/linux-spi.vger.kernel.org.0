Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1933CBB97
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jul 2021 20:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbhGPSFw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Jul 2021 14:05:52 -0400
Received: from mail-io1-f43.google.com ([209.85.166.43]:43602 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbhGPSFv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 16 Jul 2021 14:05:51 -0400
Received: by mail-io1-f43.google.com with SMTP id k16so11584314ios.10;
        Fri, 16 Jul 2021 11:02:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o8ZKFwDkRHkveLaudUDVhxvrMvahOTC+Q27T5GsqDWc=;
        b=AHYxJL5iPqVs2dwYwP7G3iMWZoJFF7chUZeFJveV39g/ZsXnNhEAmu0UiO8gDk/maA
         /G6clO+Td98dcoB7G0JJMPaaSS2b+elidsYQVI0rgq3NR8+6eq8DjbW2Mgi9BwDcsICI
         /XzhXpdo/VKmgQWb2MkEWCiiBwHk7fhLyHAuHNDlCXU6OpPYqHd+GJTIKWihqnuaPk9r
         x5xofzZO5wXDQQ/gFnVp2yFJxK2C9hVXTTheHOgsgbG9ZEOHUXRG+fdR/gRh6ldTfjyR
         PlQ8XVABkdmBJ/ggvrsgakUqJvRybyWtYxlRKsabxX5NYtkSjyAEmJve79JcYzOe5/cy
         sYYA==
X-Gm-Message-State: AOAM531py0ExmivzH84WIM6SZ7G8Vw7zj3aYyXgSD2/rRlTo8XMj5o+r
        0EtCEfmJ2VYh0vGmEDvysw==
X-Google-Smtp-Source: ABdhPJxh7jTPpNQyp+Byi/egf6lVzgVhWXlz6KVf1X2/P0wH39CqS6+wkKXzdyM7NVt0sfMNR6fLKA==
X-Received: by 2002:a02:c9c2:: with SMTP id c2mr9890706jap.98.1626458576094;
        Fri, 16 Jul 2021 11:02:56 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id o12sm5104314ilg.10.2021.07.16.11.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 11:02:55 -0700 (PDT)
Received: (nullmailer pid 3687147 invoked by uid 1000);
        Fri, 16 Jul 2021 18:02:53 -0000
Date:   Fri, 16 Jul 2021 12:02:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: memory: renesas,rpc-if: Miscellaneous
 improvements
Message-ID: <20210716180253.GA3684196@robh.at.kernel.org>
References: <d430f9c06d6691fe8a98f923cdb7ca13772834b1.1626262043.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d430f9c06d6691fe8a98f923cdb7ca13772834b1.1626262043.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Jul 14, 2021 at 01:30:13PM +0200, Geert Uytterhoeven wrote:
>   - Add missing "#{address,size}-cells",
>   - Fix rejection of legitimate flash subnodes containing multiple
>     compatible values,
>   - Add missing list of required properties.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  .../memory-controllers/renesas,rpc-if.yaml    | 23 ++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml b/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
> index 990489fdd2ac33fe..c0d899a2305361b1 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
> @@ -56,17 +56,34 @@ properties:
>    resets:
>      maxItems: 1
>  
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +

spi-controller.yaml already defines this.

>  patternProperties:
>    "flash@[0-9a-f]+$":
>      type: object
>      properties:
>        compatible:
> -        enum:
> -          - cfi-flash
> -          - jedec,spi-nor
> +        contains:
> +          enum:
> +            - cfi-flash
> +            - jedec,spi-nor
>  
>  unevaluatedProperties: false
>  
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - power-domains
> +  - resets
> +  - '#address-cells'
> +  - '#size-cells'
> +
>  examples:
>    - |
>      #include <dt-bindings/clock/renesas-cpg-mssr.h>
> -- 
> 2.25.1
> 
> 
