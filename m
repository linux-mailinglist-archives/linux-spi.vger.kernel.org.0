Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B9663A3E0
	for <lists+linux-spi@lfdr.de>; Mon, 28 Nov 2022 10:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiK1JAT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 28 Nov 2022 04:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiK1JAS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 28 Nov 2022 04:00:18 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CE517AB9
        for <linux-spi@vger.kernel.org>; Mon, 28 Nov 2022 01:00:16 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id j4so16330924lfk.0
        for <linux-spi@vger.kernel.org>; Mon, 28 Nov 2022 01:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uxQ4Op4wJkfy+E4USfATcQwka4uMnYgoKUlk7fhdGSE=;
        b=vYdb5XXPSaGwuCoLSVoXRdQxnPaAziy9sgNBD8ranp2ceRSNgedYCPqR4S0vLEMnU5
         P7HmMByv0VoBFVxh3uq65mFCK6MQA3c0f560kARTzEWaiHCOOyVKCJTkHV4l3S0g0eq6
         vyrw/O9/ZX1QkVXD18yE6C+NWMpaloiZ48EArn/TOG2veHbj9d1Vcemour9Z1xigBKa3
         RpQk3CTgz6qadxdn6IuvgcjwozjTQ3KcPOCBhwr3enogTDQR0PzTks2bn9+1k7OhHpBq
         tbyLx/EFDgvPrd35WmKItzN43WvkclKutLtUhhSEvey4QSfvY342K6flzqPRcf5xJC5F
         updg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uxQ4Op4wJkfy+E4USfATcQwka4uMnYgoKUlk7fhdGSE=;
        b=sArP+vk8IqFdr41GlHFs7UIqqsKynDkt4TkpzIqb6zzkcLje35KOPahkwr81bA3Ja2
         AcQj65nidXcLt7LumFkDcz8uzZX80aJNjxygmHNlf07Saei1nKAm1rew9CrQUZS3P4IY
         x9+ODWCLi04+UV5FyPrZ1AZ6wliAQ9YpH/6RMnEP+mxRCQs06LGIv6TJrGlB6axua1Mg
         9WpzY9bTsjl/EM0QqV5QzbcZEgLz2xzDUhQnTs2CJCD0F4Dr3vYZlwqBF0F/GI8dMzAC
         gvHxoyJrMOIoCIXI5ZXksbTiUyfIxz6x94/6arArTakqm7Rvdyc5n7/5lhpiSTqPOiRK
         CoAQ==
X-Gm-Message-State: ANoB5pmP9OHnvLqfAx4hIju+UxPTvSTiccUaGPP5xOqQ0t85IldOlEI0
        vsRtiaxJ2AcxG+BNu/Nvpsjc9g==
X-Google-Smtp-Source: AA0mqf4yCrmsZoHkLNUdgjrfnhNmrW+jAyoF8Yth5MPBnrKTzOxQXVV9S2/fv4YTu9XRNKVY+0RP+Q==
X-Received: by 2002:ac2:52aa:0:b0:4b1:fc9:429f with SMTP id r10-20020ac252aa000000b004b10fc9429fmr17759584lfm.84.1669626015128;
        Mon, 28 Nov 2022 01:00:15 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v28-20020a05651203bc00b0048a757d1303sm1655307lfp.217.2022.11.28.01.00.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 01:00:14 -0800 (PST)
Message-ID: <8b8e4b23-a3bc-7e3d-199a-e8f591d05d71@linaro.org>
Date:   Mon, 28 Nov 2022 10:00:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 5/9] dt-bindings: spi: mtk-snfi: add mt7986 IC snfi
 bindings
Content-Language: en-US
To:     Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, benliang.zhao@mediatek.com,
        bin.zhang@mediatek.com
References: <20221128020613.14821-1-xiangsheng.hou@mediatek.com>
 <20221128020613.14821-6-xiangsheng.hou@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221128020613.14821-6-xiangsheng.hou@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 28/11/2022 03:06, Xiangsheng Hou wrote:
> 1. add mt7986 IC bindings

Subject: drop second, redundant "bindings".

> 2. add optional nfi_hclk property which needed for mt7986
> 
> Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
> ---
>  .../devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml      | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml
> index 6e6e02c91780..ee20075cd0e7 100644
> --- a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml
> +++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml
> @@ -26,6 +26,7 @@ properties:
>      enum:
>        - mediatek,mt7622-snand
>        - mediatek,mt7629-snand
> +      - mediatek,mt7986-snand
>  
>    reg:
>      items:
> @@ -36,14 +37,19 @@ properties:
>        - description: NFI interrupt
>  
>    clocks:
> +    minItems: 2
>      items:
>        - description: clock used for the controller
>        - description: clock used for the SPI bus
> +      - description: clock used for the AHB bus dma bus, this depends on
> +                     hardware design, so this is optional.

Optional for which variants? For all of them?

>  
>    clock-names:
> +    minItems: 2
>      items:
>        - const: nfi_clk
>        - const: pad_clk
> +      - const: nfi_hclk



Best regards,
Krzysztof

