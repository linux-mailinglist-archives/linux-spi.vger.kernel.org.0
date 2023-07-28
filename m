Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CFB766D66
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jul 2023 14:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbjG1MlC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Jul 2023 08:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbjG1Mk5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Jul 2023 08:40:57 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A23D187
        for <linux-spi@vger.kernel.org>; Fri, 28 Jul 2023 05:40:56 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b703a0453fso31916281fa.3
        for <linux-spi@vger.kernel.org>; Fri, 28 Jul 2023 05:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690548054; x=1691152854;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gJAbChdwEnaX4075gfvAjceOveWGD3xv1p7BNW+xLfs=;
        b=AeO0Nm5AlEr6JtkVGWx/Mp8p0mFrHYEwSDU01zXmdQ1sedvXookJ73F2gr4z1oRW/g
         ohEg/PWb4mMYGrkRW9VFyJEC5xRK02bnG2MMwcJetSvoY7vQKKN6syZvvUxi45nYVYm1
         1KZx4FNTa3QjrJuTELR+2Lcx+Gy+v/5nVkLLm5q0ZBidCuOF0b+s9QYJdp/gEjTrsqaj
         6LEBODfC0FBp4DSGneYKpV4RTkEppj8gNmnmvJ82lzPCmC3EVsZRUxabO9L6wF/tlDwK
         eoBs5Q4VwYtNdnsuefA+n8PrjPbYr3zOaFTxYPf7iLSeonE+Jcg0EIwWVOvttbSZJta6
         y8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690548054; x=1691152854;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gJAbChdwEnaX4075gfvAjceOveWGD3xv1p7BNW+xLfs=;
        b=K2+j6zhunBA3gcOOaxVPTH78hMAfmqqAbyZvYXeea8AtDtKNL4S1qhsQjR+fkmnafB
         CxhLrxO9SHZwaO3DWVEv5Sz4pJvhs5BPfTogClP0VMqs9POgJ1gJu0TysPBscs141t45
         xioJcrttTMhO4XoQXtoKIPGj4+KbVG5if9xFAnNsjNlynOtdIo5GWqkX6nxazXGqOj+C
         JmzC2ph5t13wE6Xx4qW+0epilVi5dIHvPWz6R5YTqjxc4FLaMn8nRMIHuX1obtgV3ueI
         cxYlPLMKvYizgDhFUEvpPCAf4cBYDr8fHf0w6qJTKqHkayfJERMuW+JHdBPkg49aeTuD
         ErOQ==
X-Gm-Message-State: ABy/qLZV/JqJ5cOMWSU9LQ+No8sOfYG8xNGcySs9bAuRU+sBZ4HGHrgK
        LFVD3O0K9D3O1w/NMckDMznmeQ==
X-Google-Smtp-Source: APBJJlEq0Rw/NnLRZZgd3ztR3SuOqbUJpQJQmypwHoBr+L1lfMhxhkOYbh5SJNY5WyXUsz9YAeSV3Q==
X-Received: by 2002:a05:651c:cd:b0:2b7:4169:fcf5 with SMTP id 13-20020a05651c00cd00b002b74169fcf5mr1624747ljr.37.1690548054329;
        Fri, 28 Jul 2023 05:40:54 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id n12-20020a170906688c00b00992c92af6f4sm2050367ejr.144.2023.07.28.05.40.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 05:40:53 -0700 (PDT)
Message-ID: <b322f163-1ed1-a5c7-e1e0-3093903fa054@linaro.org>
Date:   Fri, 28 Jul 2023 14:40:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 25/50] dt-bindings: serial: atmel,at91-usart: add
 compatible for sam9x7
Content-Language: en-US
To:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        richard.genoud@gmail.com, radu_nicolae.pirea@upb.ro,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230728102730.266557-1-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230728102730.266557-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 28/07/2023 12:27, Varshini Rajendran wrote:
> Add sam9x7 compatible to DT bindings documentation.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  .../devicetree/bindings/serial/atmel,at91-usart.yaml     | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
> index 30b2131b5860..42644d0f1104 100644
> --- a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
> +++ b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
> @@ -17,6 +17,7 @@ properties:
>            - atmel,at91rm9200-usart
>            - atmel,at91sam9260-usart
>            - microchip,sam9x60-usart
> +          - microchip,sam9x7-usart

This looks wrong. Conflicts with further entry.

>        - items:
>            - const: atmel,at91rm9200-dbgu
>            - const: atmel,at91rm9200-usart
> @@ -28,6 +29,14 @@ properties:
>            - const: microchip,sam9x60-usart
>            - const: atmel,at91sam9260-dbgu
>            - const: atmel,at91sam9260-usart
> +      - items:
> +          - const: microchip,sam9x7-usart
> +          - const: atmel,at91sam9260-usart

So is it or is it not compatible with at91sam9260?



Best regards,
Krzysztof

