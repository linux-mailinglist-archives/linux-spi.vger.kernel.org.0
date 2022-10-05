Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A607A5F50A9
	for <lists+linux-spi@lfdr.de>; Wed,  5 Oct 2022 10:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiJEIOT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Oct 2022 04:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiJEIOR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 Oct 2022 04:14:17 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EFC72853
        for <linux-spi@vger.kernel.org>; Wed,  5 Oct 2022 01:14:14 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id d6so10356806lfs.10
        for <linux-spi@vger.kernel.org>; Wed, 05 Oct 2022 01:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Y0uHbn035tWwWO1RtVHpJOVJwEZiCVXw2pgVenq9fnw=;
        b=Xn/CjIA/NowDCL3dCSGCkqk0O2+030/EAsGXX/lTaALu9eI3v3CFG/SO7ED4xUlqAN
         N31qdCJHbTdPefleT2DVAgFt+rNYlXodKuw+POSA3Sp1TpURdVbbIVzPgtdi4CMduil6
         8Enj6zNwfEHEIu52i/KBgKsGfFNXJez8OokYjqfekYe3t+1SRb4VPH75kSGFKeYgXAGX
         4BB7c+BSd8WmhWm3Yw7g2MKnp7mmMb+7GSXjZWqj3O8Ce3T5XNC2PXlzZ0/sHh6coZDa
         wDpSfNla/jFPJS+GdqJMb7pUrfkf2JwJrw5P3pNndHjWt9rx/qGzjC6WEHgnhwfGIfme
         jPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Y0uHbn035tWwWO1RtVHpJOVJwEZiCVXw2pgVenq9fnw=;
        b=8LqxU8bt+Esd8NyZ5R769H9FhxCuPog7hW9tVubKZmpvgdoQdM5Ml7tFo1pLCPgG4T
         C9M7tlpM/2ECMAkz2tAtovkOvWQJ/iHHmUfPn/LvgX/EWgQ1daDAeo15GszsoH8pcX8J
         A+kRWr3uz13XKjW8je2x8jkuouVLBkTUADw/qJZWvEYD0HugS4LYhhqcN90vGkFfgCXO
         Tw7Ikaf+3BoDCC8mtPjNQgiiDcnoBNGVj89aovAwPnM4sft/ocrZaLAEhUBXq33Xckrj
         pMqw12y6baTYEyNDz5xHbNI81xpubt/4/iJiMFqcMPkI+ac9+8e4UZSpjT3v7oZ8w7Pb
         ea/g==
X-Gm-Message-State: ACrzQf3KIKZ0kEiwYw0A9Ju6/QXo+K30DMoWPpaAMezYdRRgHJOgAfLg
        NPwF2RWFdmW67imsqnXR9pWASuXjPzAAiA==
X-Google-Smtp-Source: AMsMyM6Wxvb70JmOJdSPcYnIs7XcdHOlzpt4207AZkXQMEhldb8cdP9iXuuVbyoxjqnO1qX2Y98o0g==
X-Received: by 2002:a05:6512:1084:b0:4a2:eb2:9d9e with SMTP id j4-20020a056512108400b004a20eb29d9emr10128640lfg.553.1664957653264;
        Wed, 05 Oct 2022 01:14:13 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g22-20020a05651222d600b0048b143c09c2sm2252172lfu.259.2022.10.05.01.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 01:14:12 -0700 (PDT)
Message-ID: <d2ce98d7-1025-9c6e-e207-00e91942077a@linaro.org>
Date:   Wed, 5 Oct 2022 10:14:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 1/2] spi: dt-bindings: amlogic, meson-gx-spicc: Add
 pinctrl names for SPI signal states
Content-Language: en-US
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Da Xue <da@libre.computer>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20221004-up-aml-fix-spi-v2-0-3e8ae91a1925@baylibre.com>
 <20221004-up-aml-fix-spi-v2-1-3e8ae91a1925@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221004-up-aml-fix-spi-v2-1-3e8ae91a1925@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 04/10/2022 13:10, Amjad Ouled-Ameur wrote:
> SPI pins of the SPICC Controller in Meson-GX needs to be controlled by
> pin biais when idle. Therefore define three pinctrl names:
> - default: SPI pins are controlled by spi function.
> - idle-high: SCLK pin is pulled-up, but MOSI/MISO are still controlled
> by spi function.
> - idle-low: SCLK pin is pulled-down, but MOSI/MISO are still controlled
> by spi function.
> 
> Reported-by: Da Xue <da@libre.computer>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> ---
>  .../devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml   | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
> index 0c10f7678178..53013e27f507 100644
> --- a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
> +++ b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
> @@ -43,6 +43,14 @@ properties:
>      minItems: 1
>      maxItems: 2
>  
> +  pinctrl-0:
> +    minItems: 1

maxItems?

> +
> +  pinctrl-1:
> +    maxItems: 1
> +
> +  pinctrl-names: true

Why do you need all these in the bindings?

> +
>  if:
>    properties:
>      compatible:
> @@ -69,6 +77,13 @@ else:
>        items:
>          - const: core
>  
> +    pinctrl-names:
> +      minItems: 1
> +      items:
> +        - const: default
> +        - const: idle-high
> +        - const: idle-low

This does not match what you wrote in the bindings - you mentioned only
two set of pin controls.


Best regards,
Krzysztof

