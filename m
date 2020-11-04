Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 496D82A7026
	for <lists+linux-spi@lfdr.de>; Wed,  4 Nov 2020 23:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732014AbgKDWEo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Nov 2020 17:04:44 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43053 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732110AbgKDWDZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 4 Nov 2020 17:03:25 -0500
Received: by mail-oi1-f196.google.com with SMTP id t143so12278628oif.10;
        Wed, 04 Nov 2020 14:03:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Knkmf1pn76q7POoN8JLHqHxaxRu+hTlPg8l5hbRom2E=;
        b=sY68VUvGqq694Uvn3AERtyExqC9BTdVMqLlaNwcxWwJGUFxyNEKbjK3l+Xdwuy/+UI
         ur2S8p+hnAEjpZZ3ytb62JwaVANh9NiksTX0oQ+2fGKsbALuHecDfKbVj0qt/aRWgx2D
         BRe9hhuinUAej02OzDHWMXqPWKfDMTo16FhhbSA8jVWToSoBRVhaOHKHoG0xa0czOJEy
         /0H3kHCyv8L+yNk5dkS9Z5SkUAMvdK28gz5GNZd2ZwgGvDfHsqHF+WmLIU6u+PFEJ45i
         M6ZinELsl/6NRyP0OhQQiV5pvYfFQ1DR6STIbW7G10D1dTYBdMd75NYVdEW1NlEJ7bge
         X5vQ==
X-Gm-Message-State: AOAM530/Z7Ayj2f8Kk8tRpgIBd8Q3YatUjO45kCcISWTNDzePOdCCS8m
        lIW+RvfLXxxrYAEpdD9Z7Q==
X-Google-Smtp-Source: ABdhPJxPJUR5Qq9oOIdh4sOQR58BFrqT9yjM3rRgi2ZnEd7hrTA4TIDSEkT6esmjgZxsBD07z28ulg==
X-Received: by 2002:aca:4dd3:: with SMTP id a202mr3714817oib.118.1604527403166;
        Wed, 04 Nov 2020 14:03:23 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 15sm830017ooy.36.2020.11.04.14.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 14:03:22 -0800 (PST)
Received: (nullmailer pid 6789 invoked by uid 1000);
        Wed, 04 Nov 2020 22:03:21 -0000
Date:   Wed, 4 Nov 2020 16:03:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     broonie@kernel.org, vigneshr@ti.com, tudor.ambarus@microchip.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, miquel.raynal@bootlin.com,
        simon.k.r.goldschmidt@gmail.com, dinguyen@kernel.org,
        richard@nod.at, cheol.yong.kim@intel.com, qi-ming.wu@intel.com
Subject: Re: [PATCH v6 6/6] dt-bindings: spi: Add compatible for Intel LGM SoC
Message-ID: <20201104220321.GB4192737@bogus>
References: <20201030053153.5319-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201030053153.5319-7-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030053153.5319-7-vadivel.muruganx.ramuthevar@linux.intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Oct 30, 2020 at 01:31:53PM +0800, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Add compatible for Intel LGM SoC.
> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> ---
>  Documentation/devicetree/bindings/spi/cadence-quadspi.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml b/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml
> index ec22b040d804..58ecdab939df 100644
> --- a/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml
> @@ -19,6 +19,7 @@ properties:
>            - enum:
>                - ti,k2g-qspi
>                - ti,am654-ospi
> +              - intel,lgm-qspi

As this change shows, you don't need 'oneOf' for Intel...

>            - const: cdns,qspi-nor
>  
>    reg:
> -- 
> 2.11.0
> 
