Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0312A73568B
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jun 2023 14:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjFSMSF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Jun 2023 08:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjFSMSE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 19 Jun 2023 08:18:04 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E883111D
        for <linux-spi@vger.kernel.org>; Mon, 19 Jun 2023 05:18:02 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-986d871a9beso437159366b.1
        for <linux-spi@vger.kernel.org>; Mon, 19 Jun 2023 05:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687177081; x=1689769081;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f3JGorfIUhRBEEat5SkdMS+cAsBErGeh9mcIh09Qj5Y=;
        b=ftxfXuW39arEC753qySrvJyMUiTqn6xXH5WaTT1BEErA00SpJLIGp9w1kBUhU5vEJv
         f6anxtOmKpET56EN48/cEnd0SwK+yj51n1MEtBCTPp7el9yUoItaJ6F/hFGj4gShuteI
         BaQ1LQa6nXrDN0P5PelotjCKHziaLP6gEuIS0sK3MPkvSK5q14sHaTbIdMqqeWK4KuUP
         Fc7Kk3JX16pEdBOl1xbceR7RizKgfzdt849uuItHQfnmyhTplWRPVWhgxectJ2aAwkrY
         NSApPi7LL9fZJGS3slUXFwI/emASv9VZqaYzA9/0RB6ZswwB0K2OAXTimSVDYDMgSXhI
         /C8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687177081; x=1689769081;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f3JGorfIUhRBEEat5SkdMS+cAsBErGeh9mcIh09Qj5Y=;
        b=f6rJ27dhzAXf4UZ2lizeQpLpS1qoiQ9EgtEWLdSmPXT159+ELlz9g9Tgj1ciwmdNlf
         p5flEZa8mqqvWiP5sroIMjaE8szXIbyDmA5lxbv+2Zr35EvMxv/E2Ng47twN3k2q5Xy0
         V/AaXncxSQo/accv1GFUzlcwibGBPlXZhvH9PPvfVIp1GvAXRTZURfINEkzS90rLQQyG
         /ObeVWLHe9ETue2kghCEJy3j3CBTgR+loR5IkZ/3qFHL4OsJJy0kvCg4kM7bMTxdHTBn
         fnsbUJ1/xsBeOfjMwoEzNuKuf7Z9H14R9+sq6iXmIG2POWryK6Yhrc9JaDKnsf7y3Qsk
         RibA==
X-Gm-Message-State: AC+VfDz+f6gQu5A6c9SGR1oRqNXdxoPznXzBo/fR38m5t8Vu/Kqq/lFC
        NABIo2Phh1Lp2RlJbVBKwOZ2QQ==
X-Google-Smtp-Source: ACHHUZ5dSNOSmu50TYQOnRntKgNAkfQOjYhYtzl3XEVqerIDIPhndh1rJ+XHu5SZ33ZICY6HRcEyeA==
X-Received: by 2002:a17:907:e8b:b0:988:9b29:5647 with SMTP id ho11-20020a1709070e8b00b009889b295647mr2506074ejc.77.1687177081353;
        Mon, 19 Jun 2023 05:18:01 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id qw19-20020a170906fcb300b00988c3e96294sm1029432ejb.30.2023.06.19.05.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 05:18:00 -0700 (PDT)
Message-ID: <4937f9c4-a0e0-fd37-d71b-e7488b2a1062@linaro.org>
Date:   Mon, 19 Jun 2023 14:17:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/3] dt-bindings: qspi: cdns,qspi-nor: Add clocks for
 StarFive JH7110 SoC
Content-Language: en-US
To:     William Qiu <william.qiu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ziv Xu <ziv.xu@starfivetech.com>
References: <20230619083517.415597-1-william.qiu@starfivetech.com>
 <20230619083517.415597-2-william.qiu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230619083517.415597-2-william.qiu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 19/06/2023 10:35, William Qiu wrote:
> The QSPI controller needs three clock items to work properly on StarFive
> JH7110 SoC, so there is need to change the maxItems's value to 3. Other
> platforms do not have this constraint.
> 
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/spi/cdns,qspi-nor.yaml           | 20 ++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> index b310069762dd..1b83cbb9a086 100644
> --- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> +++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> @@ -26,6 +26,15 @@ allOf:
>              const: starfive,jh7110-qspi
>      then:
>        properties:
> +        clocks:
> +          maxItems: 3
> +
> +        clock-names:
> +          items:
> +            - const: ref
> +            - const: ahb
> +            - const: apb

You are duplicating top-level property. Define the items only in one
place. If this list is applicable to everything, then in top-level property.

> +
>          resets:
>            minItems: 2
>            maxItems: 3
> @@ -38,6 +47,9 @@ allOf:
>  
>      else:
>        properties:
> +        clocks:
> +          maxItems: 1

clock-names is missing. They must be in sync with clocks. What is the
first clock?

> +
>          resets:
>            maxItems: 2
>  
> @@ -70,7 +82,13 @@ properties:
>      maxItems: 1
>  
>    clocks:
> -    maxItems: 1
> +    maxItems: 3


You did not test it before sending. minItems is missing.

> +
> +  clock-names:
> +    items:
> +      - const: ref
> +      - const: ahb
> +      - const: apb


>  
>    cdns,fifo-depth:
>      description:

Best regards,
Krzysztof

