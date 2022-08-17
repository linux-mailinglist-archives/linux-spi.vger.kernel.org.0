Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A95D596E51
	for <lists+linux-spi@lfdr.de>; Wed, 17 Aug 2022 14:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbiHQMVQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 17 Aug 2022 08:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiHQMVP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 17 Aug 2022 08:21:15 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6756E883CF
        for <linux-spi@vger.kernel.org>; Wed, 17 Aug 2022 05:21:14 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r16so6790866wrm.6
        for <linux-spi@vger.kernel.org>; Wed, 17 Aug 2022 05:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=m1ESsIqQK33mkc2gES2cmv+jNqxpWrAFNggOv3RLRRM=;
        b=pPcIdlQQUO1qWmqM0DAIg+k4LibZFLWCKC3A7EAiYQU9IkycD05kLglZo2lWWVcmB+
         eZkPJ4QrUl2IGp49BFinu5/UIRRE6dVC+jZITg475fvXiK088tDtWt3TwNO8uc6m0zA6
         +6FrYF/VT7FRZJgaCFvqwJ1ezcdXT95oZb9C6h+2KHemooT+4rt6NkvlZZrY4pnt+dRI
         ncfbRneUqN2mWDFMK9iD3M0ARzQ+yz5UM5zaOhGdRm251xuoN44cfqJp421zpzHjOoKC
         rjNDnmrxKXfWIFZgxroW6DieRro9FyqbvvbM+cXQFzM31wlvW1Iubd3BNItVA/s2G1Jg
         mwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=m1ESsIqQK33mkc2gES2cmv+jNqxpWrAFNggOv3RLRRM=;
        b=L5pyn2tkRn2vWcKgBo0bySnUsF9hmi6i366D9LzXf23IL9XvEhljrMdPM+KiIt7gju
         Pbwem7u8QUBQysTICxeOKxpYwHHJOl7n8Vf7BqDPOtFLB9EF9sd+m35TE0P8ksQh+eVp
         cw0XfheL49xhsiQ3N08qli3M5CG68vuG9EgQWNTQ7jgYBkATtVpBBCeMExQsI8mOHImM
         +vuzD+udZxCDMUCL6crtnBt2HohHDIsyy3572jhjbsCwYL3AQe3ghI15+bRl4Otc8m1u
         nE+6gGkMr2fIakqhI/WgYYo2BAFRLJ8HJ4NJWvZWl1QFs/bHSc4bxkqcUsJFkLeNghhf
         IWlg==
X-Gm-Message-State: ACgBeo3tAj88L5HN0+wdSZ9JgDG9h49fxmrPttmePlEX0i7BpiVrSD+S
        LclnrNsUim5iOLV2Zo75n+pElQ==
X-Google-Smtp-Source: AA6agR7OTnrPt5oIdtzE4QzF/PJAdntMdqijnhGLRs56Qj2uoOh/3Y5DHlKEkqQTRTTSmgxemiqazQ==
X-Received: by 2002:a5d:6f05:0:b0:223:8bfc:dd0f with SMTP id ay5-20020a5d6f05000000b002238bfcdd0fmr13949143wrb.547.1660738872993;
        Wed, 17 Aug 2022 05:21:12 -0700 (PDT)
Received: from [192.168.86.238] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id az36-20020a05600c602400b003a5fa79007fsm2180552wmb.7.2022.08.17.05.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 05:21:12 -0700 (PDT)
Message-ID: <8ab34dd4-ca5a-2824-ccbf-867996ac6536@linaro.org>
Date:   Wed, 17 Aug 2022 13:21:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/3] dt-bindings: nvmem: mediatek: efuse: Add support for
 MT8188
Content-Language: en-US
To:     Johnson Wang <johnson.wang@mediatek.com>, broonie@kernel.org,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220715120114.4243-1-johnson.wang@mediatek.com>
 <20220715120114.4243-3-johnson.wang@mediatek.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220715120114.4243-3-johnson.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 15/07/2022 13:01, Johnson Wang wrote:
> Add compatible for MT8188 SoC.
> 
> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> ---
> This patch is based on "linux-next"[1].
> [1]https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> ---

Applied thanks,

--srini
>   Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> index b5a1109f2ee1..75e0a516e59a 100644
> --- a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> @@ -30,6 +30,7 @@ properties:
>                 - mediatek,mt8173-efuse
>                 - mediatek,mt8183-efuse
>                 - mediatek,mt8186-efuse
> +              - mediatek,mt8188-efuse
>                 - mediatek,mt8192-efuse
>                 - mediatek,mt8195-efuse
>                 - mediatek,mt8516-efuse
