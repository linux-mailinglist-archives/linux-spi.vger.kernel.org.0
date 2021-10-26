Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD4943B914
	for <lists+linux-spi@lfdr.de>; Tue, 26 Oct 2021 20:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236588AbhJZSNW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 Oct 2021 14:13:22 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:40503 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235040AbhJZSNW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 26 Oct 2021 14:13:22 -0400
Received: by mail-oi1-f178.google.com with SMTP id n63so21836213oif.7;
        Tue, 26 Oct 2021 11:10:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LwN+X4PEi3Ouq9X6OKykFlJGA9GO8zaZsDpJ3nIh2IU=;
        b=Qi/2+Pr5/cT8G69/r6fgXaQN/XXtP1TrdIN6IQGPhoSsiS2aUmlAOuR6BQbvIueYNY
         IXFpVqC0HZhbJJis2BO3gj2H9aZNVhD/OckUuuGQQlpDrWvdhuZjVwaClt/UgOayoAee
         8gVA7HTI2OnDgG7BOXyAvb2/oucX9caWAgAJAroS+RYYs7AnEABzgYTbyQ0/LE1ou72y
         Y/d1XElEPyTXbCDxBKau0Pbnk10zFVRSRfFylAzQqNsss8JjiqIx2pqzYbyCkouA0ezp
         wRgrn27qpW4lYLFEcNL1RUN+v99v8LeGQEa6uVv6HmbEFwEOqqEgwz+QFxAI/bIiY0hp
         4DDg==
X-Gm-Message-State: AOAM533lapW0SyullYYVKPtb5hgsczF2oMRMpLI0ES1L+zNxuX4pSy8Z
        cKMYxgXzcTkNDAJ5CwIvvg==
X-Google-Smtp-Source: ABdhPJxO0G7gdDH3/w0eJlvozSh7pEFCagRG5POucla9GUeZ9R93VkMIf59HbJp1MZLXLSpbSBydTQ==
X-Received: by 2002:aca:240e:: with SMTP id n14mr239723oic.52.1635271857578;
        Tue, 26 Oct 2021 11:10:57 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bk8sm5045827oib.57.2021.10.26.11.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 11:10:56 -0700 (PDT)
Received: (nullmailer pid 2952060 invoked by uid 1000);
        Tue, 26 Oct 2021 18:10:54 -0000
Date:   Tue, 26 Oct 2021 13:10:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Brad Larson <brad@pensando.io>
Cc:     linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/11] dt-bindings: mmc: Add Pensando Elba SoC binding
Message-ID: <YXhErvvSfKIBvHae@robh.at.kernel.org>
References: <20211025015156.33133-1-brad@pensando.io>
 <20211025015156.33133-4-brad@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025015156.33133-4-brad@pensando.io>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, Oct 24, 2021 at 06:51:48PM -0700, Brad Larson wrote:
> Pensando Elba ARM 64-bit SoC is integrated with this IP and
> explicitly controls byte-lane enables resulting in an additional
> reg property resource.
> 
> Signed-off-by: Brad Larson <brad@pensando.io>
> ---
>  .../devicetree/bindings/mmc/cdns,sdhci.yaml         | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> index af7442f73881..6c68b7b5abec 100644
> --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> @@ -15,13 +15,16 @@ allOf:
>  
>  properties:
>    compatible:
> -    items:
> -      - enum:
> -          - socionext,uniphier-sd4hc
> -      - const: cdns,sd4hc
> +    oneOf:
> +      - items:
> +        - enum:
> +            - socionext,uniphier-sd4hc
> +            - pensando,elba-emmc
> +        - const: cdns,sd4hc
>  
>    reg:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2

If there is more than 1, then you need to describe what each entry is.

>  
>    interrupts:
>      maxItems: 1
> -- 
> 2.17.1
> 
> 
