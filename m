Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7538F53A0A9
	for <lists+linux-spi@lfdr.de>; Wed,  1 Jun 2022 11:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351315AbiFAJgt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 Jun 2022 05:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351283AbiFAJgl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 1 Jun 2022 05:36:41 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AD39EB41
        for <linux-spi@vger.kernel.org>; Wed,  1 Jun 2022 02:36:35 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id gi33so2553335ejc.3
        for <linux-spi@vger.kernel.org>; Wed, 01 Jun 2022 02:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SXy2jxkQQlSv6Zx0OkI1k2j7NF0aEo6KqD+T9sPY7WM=;
        b=OdjBPtg23WUxhKUm9hU2NUXHqwMlxMRYyzulQr63FTEhuJ5jj1zz5lOlc37ZWJDHx1
         yBhSh0WzM7/4DEHCvoa6AK6vkRMAI1J0tLHVOSHX/9b1IGLPHsOtweDVsk/MZajf+cXT
         8Et9FDg8ZIst859pqWHpcvZmU9M3p5yefD+06N0IwXhF9bXrgnSdfuFiyHhHPzdrsz8/
         Meq3v3nRKuI+9gdizaNXVVyWj5YJorA5MYEZQNkWpT10S6gKi7Dy4KckdtGAIdDn+Ix6
         iJA5aaf1/tkVvNhO5A06NtSALO1K/Qgd9Anjuo4M2n15L5wGPW2I1dqtQglKf4EcZ5fR
         X0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SXy2jxkQQlSv6Zx0OkI1k2j7NF0aEo6KqD+T9sPY7WM=;
        b=MNUl9XQnjxXU8yenLCLP+CGru5nAtxx/7FoCHb83j4YgOvSbsH8aEz+j3q73EtiUFp
         4dtmKVx1dZtOICUhNQLySaGhQLU0GHKVkteqhqaldkuBgAO2riY/uOSkdXlj4QpU39SK
         WM7D+THfTU5hgYXs6ml/Ae0yYIaAbv0T3RjP7dlzVO8gyQD/DXBudkNv8/yQzoUmyFmI
         weEt7xXHWpudTouYdjsFjRbDpJjQypn5ip1NsvzaXwGRa0fZAMtw/ZvMPMLjJaaBX0vB
         2IoKvlbHMTFrJmTnE3kDThY6fKmjhIIAfFzMMMNofpmJEkiLrV8Uj2zujehQ5tqzp6Z6
         txLA==
X-Gm-Message-State: AOAM531nugiukuWd0swrRV4uQ7DiQ71/uGWuTTMFUk7drrshO+YQh10T
        0emUXOflc5hBHy+jRatqazomCA==
X-Google-Smtp-Source: ABdhPJwjWC7FIS5LNCO1EphF1UnMztgGaShcktFcPPwtjGiwFhZCxmDcyHE8hBBzwAedsIdemtVCQw==
X-Received: by 2002:a17:907:8688:b0:707:926e:ea44 with SMTP id qa8-20020a170907868800b00707926eea44mr1377732ejc.547.1654076193885;
        Wed, 01 Jun 2022 02:36:33 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id w12-20020a1709064a0c00b007066283fdfesm474720eju.111.2022.06.01.02.36.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 02:36:33 -0700 (PDT)
Message-ID: <8f695677-a45c-7117-6659-c2778cbc221a@linaro.org>
Date:   Wed, 1 Jun 2022 11:36:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 04/17] dt-bindings: arm: mediatek: Add binding for
 mt8365-evk board
Content-Language: en-US
To:     Fabien Parent <fparent@baylibre.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        qii.wang@mediatek.com, matthias.bgg@gmail.com, jic23@kernel.org,
        chaotian.jing@mediatek.com, ulf.hansson@linaro.org,
        srinivas.kandagatla@linaro.org, chunfeng.yun@mediatek.com,
        broonie@kernel.org, wim@linux-watchdog.org, linux@roeck-us.net,
        Sean Wang <sean.wang@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20220531135026.238475-1-fparent@baylibre.com>
 <20220531135026.238475-5-fparent@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220531135026.238475-5-fparent@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 31/05/2022 15:50, Fabien Parent wrote:
> Add binding documentation for the MT8365-EVK board. The MT8365 EVK board
> has the following IOs:
> * DPI <-> HDMI bridge and HDMI connector.
> * 2 audio jack
> * 1 USB Type-A Host port
> * 2 UART to USB port
> * 1 battery connector
> * 1 eMMC
> * 1 SD card
> * 2 camera connectors
> * 1 M.2 slot for connectivity
> * 1 DSI connector + touchscreen connector
> * RPI compatible header
> * 1 Ethernet port
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
> index 4a2bd9759c47..a4b1288fa837 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -216,6 +216,10 @@ properties:
>            - enum:
>                - mediatek,mt8516-pumpkin
>            - const: mediatek,mt8516

Blank line here

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

> +      - items:
> +          - enum:
> +              - mediatek,mt8365-evk
> +          - const: mediatek,mt8365
>  
>  additionalProperties: true
>  


Best regards,
Krzysztof
