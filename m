Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94FC496514
	for <lists+linux-spi@lfdr.de>; Fri, 21 Jan 2022 19:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351626AbiAUSd0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 Jan 2022 13:33:26 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:56382
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351193AbiAUSdZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 21 Jan 2022 13:33:25 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1961240024
        for <linux-spi@vger.kernel.org>; Fri, 21 Jan 2022 18:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642790000;
        bh=mXZlfPhqAVSv8NPi2Pl5gmTb003b75PhYIJqXglSUqA=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=GrlC+bsO3PpBBz5/hC/A2rUc8ddY4WaDneRwHWooQK8pIe+fIpVprSPC1lMhJS3W9
         JLuVIZR/hqYW5grJzELvrcfgIXaYgd3vumMaG7ggfpCclGG6O7LPTjNiVsGzZL9MvA
         AGxrC/0JEb/jtKTru4fXHCpS2FST/rRxK9IZZbX7AWihK/Ziz37mpm2H1PxHXGThPz
         cGvn//5pZDo4QbgetO9JqVWPvaXw+X+0YrOhtKxKNcrEFbf9ClOtr5QonP25Htil5m
         Lp1lRjqb5r/2YYCFWREVZjstDwcpoIoh1T/9ccsz68GTGlGy4gUp0IU92X+z9UdXYV
         sCTzBkwSqeUqQ==
Received: by mail-ed1-f70.google.com with SMTP id i9-20020a05640242c900b003fe97faab62so9397504edc.9
        for <linux-spi@vger.kernel.org>; Fri, 21 Jan 2022 10:33:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mXZlfPhqAVSv8NPi2Pl5gmTb003b75PhYIJqXglSUqA=;
        b=xi2JY5e8i+jjC9IisBho5u9De/qv9d9dEDRGVAWVT0PagbuVsE60s42AuAyoQf8diO
         YiAyU13vxyZkoKyfnQEd+DFNu6fP0aVPTy/IsvOq+POAyMlURDDV1I/OmrpXO8jER4B7
         BbzYprvZZhJZmAl5gjp8VO30jyDkya1mv479FmyArchEUCF34LEzBIAJQMjSMdcwXcmm
         V+vLY8xUc9xksqTcU5tW0wBn9G8/gbZ9RhMIUwaj255jL7fM1K1r6Lr5bTQRxCo/lWPU
         vukFfEqd4jT6K8jf+kcRyHHMaKLdPCUlvEdoXGin68nQiuX3naHaFIXsJTZviOvD1m6o
         L3tQ==
X-Gm-Message-State: AOAM532QGGb3qwVSPH7esF+wJI9//Z2WfKswjEmATTq4zoeMjwBJOHSd
        baNvDkMN/UXClDuQDdpF/aHUbC0sLTnTy4QyA4B7RTgcHVKniEgT1qPN5qDS1xD6B18tX/0jyQw
        +xkL48pL1Tav2IY9qjSNzJgdNmuXvyG9kRgjnCg==
X-Received: by 2002:a17:907:7858:: with SMTP id lb24mr4306534ejc.629.1642789997372;
        Fri, 21 Jan 2022 10:33:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzOKjPuqYPtjHGgNKA+6097tyEbgBqQY22vvlACKfaO33upCODhf6sV7Otiz0IHhhh/a2hzSQ==
X-Received: by 2002:a17:907:7858:: with SMTP id lb24mr4306522ejc.629.1642789997159;
        Fri, 21 Jan 2022 10:33:17 -0800 (PST)
Received: from [192.168.0.51] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id e11sm2268231ejd.188.2022.01.21.10.33.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jan 2022 10:33:16 -0800 (PST)
Message-ID: <aa172f14-2328-fc7c-0063-5c0033970d1d@canonical.com>
Date:   Fri, 21 Jan 2022 19:33:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 1/3] spi: dt-bindings: samsung: Add fsd spi compatible
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, broonie@kernel.org, andi@etezian.org,
        linux-spi@vger.kernel.org, linux-fsd@tesla.com,
        Adithya K V <adithya.kv@samsung.com>
References: <20220120192438.25555-1-alim.akhtar@samsung.com>
 <CGME20220120193613epcas5p238851849d212e01d7d830d78ca7d6379@epcas5p2.samsung.com>
 <20220120192438.25555-2-alim.akhtar@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220120192438.25555-2-alim.akhtar@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 20/01/2022 20:24, Alim Akhtar wrote:
> Adds spi controller dt-binding compatible information for
> Tesla Full Self-Driving (FSD) SoC.
> 
> Cc: linux-fsd@tesla.com
> Signed-off-by: Adithya K V <adithya.kv@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  Documentation/devicetree/bindings/spi/samsung,spi.yaml | 1 +
>  1 file changed, 1 insertion(+)

I think you forgot to mention - in cover letter - that this depends on
my Samsung SPI bindings conversion to dtschema.

I'll be sending v6 of it after merge window, with minor changes.

> 
> diff --git a/Documentation/devicetree/bindings/spi/samsung,spi.yaml b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
> index 61c77088e8ee..bf9a76d931d2 100644
> --- a/Documentation/devicetree/bindings/spi/samsung,spi.yaml
> +++ b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
> @@ -21,6 +21,7 @@ properties:
>            - samsung,s3c6410-spi
>            - samsung,s5pv210-spi # for S5PV210 and S5PC110
>            - samsung,exynos5433-spi
> +          - tesla,fsd-spi
>        - const: samsung,exynos7-spi
>          deprecated: true
>  
> 


Best regards,
Krzysztof
