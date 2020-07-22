Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0078B229663
	for <lists+linux-spi@lfdr.de>; Wed, 22 Jul 2020 12:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgGVKjh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Jul 2020 06:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgGVKjh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 Jul 2020 06:39:37 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC204C0619DC;
        Wed, 22 Jul 2020 03:39:36 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a14so1406724wra.5;
        Wed, 22 Jul 2020 03:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TV4ergjkftjaZomx8AqjCOlT/l5mho+qoW7fAiO7DwA=;
        b=MZ8x8EX7EI5Gki/n02pEYgl/ub5LEHKa8Kws1JGFicYu6gEKCb48xFnQso4xw5WDi0
         4vZ/2dgM4g907i/tzKZ0xo0hx8P5UsH46ib2vUDwpXBrO49OiKoBjlSvt6AzLFeDst3c
         CTMARSgJMmxdrMkBfdL3GKnO/UZ3MLqyu2rF55tJ1+8eJgfd3uI1cAKoAM7+lcc8CBHQ
         qPN2Plu/Hf89BTllLBuF9IS/Mw6g2oscSLlAymf8C2NFheG9oLneYJdoHD9yytjJbVGz
         LPLXxDft/uf7v4H05+THcmyNsAwohkImDEntoRi7PVAhKdk95Xj4xBV53WHhiRWFQcfr
         lkUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TV4ergjkftjaZomx8AqjCOlT/l5mho+qoW7fAiO7DwA=;
        b=eczrUHlZOGpQw8q0gR0m8ZuLRgnoytmJ5NQILdTt8IutADYGDGR2Ii4ydg+La44Hn4
         K1ISBbR7Kt3iF3ZfCXTXKcz45XmU1U9mdwh+LL6Hj5RD0GhML/H0naOanQxH+XFm/PiI
         fc3RPGYI2bUvx0ReuAIgjBhdp3cn4vQPoXI32ET3WF0YUCYWvPR6nJxNujG7m+IAMCiB
         e7kCfyyhkfgX9iUkvs89KIFw2/loSSaJIInpXPguRuU9RPgeOaegGWtxBn2RAkCaLcFk
         iRCCf9SdXYZdzhoYkvyHLbxw607tiBTGSGD+zfxbRuLkVbSFni2CIiUTaqdlNQFFP7d9
         LB4w==
X-Gm-Message-State: AOAM533Cj9UqStd0Pj8EHDCWRWDMKdeoKCyIZnpp3KbOeVG3Ix9FUXEv
        rQZMIZMi8rEyhKdUofR2ipU=
X-Google-Smtp-Source: ABdhPJzccNJ8vHlvkA5XruDkm8csHTXrgtgDkPe3q+BBmvVK0PQT9d6D36+7jU8Cpg/rLDybhlBmjg==
X-Received: by 2002:adf:ded0:: with SMTP id i16mr15608967wrn.389.1595414375595;
        Wed, 22 Jul 2020 03:39:35 -0700 (PDT)
Received: from ziggy.stardust ([213.195.122.158])
        by smtp.gmail.com with ESMTPSA id p8sm29564205wrq.9.2020.07.22.03.39.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 03:39:35 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: update bindings for MT8192 SoC
To:     Leilk Liu <leilk.liu@mediatek.com>, Mark Brown <broonie@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20200721122436.31544-1-leilk.liu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <97bcb048-81f2-0147-4c62-9172c27fff71@gmail.com>
Date:   Wed, 22 Jul 2020 12:39:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200721122436.31544-1-leilk.liu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 21/07/2020 14:24, Leilk Liu wrote:
> From: "leilk.liu" <leilk.liu@mediatek.com>
> 
> Add a DT binding documentation for the MT8192 soc.
> 
> Signed-off-by: leilk.liu <leilk.liu@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   Documentation/devicetree/bindings/spi/spi-mt65xx.txt | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> index 3a8079eb18c8..9e43721fa7d6 100644
> --- a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> @@ -11,6 +11,7 @@ Required properties:
>       - mediatek,mt8135-spi: for mt8135 platforms
>       - mediatek,mt8173-spi: for mt8173 platforms
>       - mediatek,mt8183-spi: for mt8183 platforms
> +    - "mediatek,mt8192-spi", "mediatek,mt6765-spi": for mt8192 platforms
>       - "mediatek,mt8516-spi", "mediatek,mt2712-spi": for mt8516 platforms
>   
>   - #address-cells: should be 1.
> 
