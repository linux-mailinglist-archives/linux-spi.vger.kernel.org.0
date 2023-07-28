Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839DB766C14
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jul 2023 13:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbjG1LvD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Jul 2023 07:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbjG1LvC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Jul 2023 07:51:02 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BDC3AB4
        for <linux-spi@vger.kernel.org>; Fri, 28 Jul 2023 04:51:01 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-98e011f45ffso274482066b.3
        for <linux-spi@vger.kernel.org>; Fri, 28 Jul 2023 04:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690545060; x=1691149860;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D/uELZJizv4is37kGWOvFpksJ1ez4XLF6M0hB83T1R8=;
        b=qOvJXNyWTsmIF8kFtSbkK/0IwC48UpaN7brf9S6BzEBaLix+T04aMi9q5OtIiTwczF
         srisU/bOzSu35V2CAJlcc9lbPW7WwjIBzWn+ejDoY/pB6IDBJVEzf4tzsWl8xU75jtZE
         G66RDOegqDxp4Nt43TZCD/YfW7J8wFbdLGrLkLq6MyDap9Z4GFbTM7iVEl9ZpD9GZXUa
         iRvHqeUb/v9Hp4fcU214e0POEUvrdMyAt3xJ01w7Ma7vCq2F3UmpMWfU8QpkeXyYvkwi
         HafI1GWsTQqLK7w5ACYXAjKYVVTd68PehxtqtrLSN8ABOOjmMktALpBej21vvjpqBISo
         NGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690545060; x=1691149860;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D/uELZJizv4is37kGWOvFpksJ1ez4XLF6M0hB83T1R8=;
        b=i8+Pc3kJuRzeatT7hSd3lTmpIaN4xaB2RQc71aXmGq5JltnhkDla6oO4ksS7HJQhTc
         5Zxh/Zms7JsANvbTS3VSz0+Q/2eDtglN/QCkoARsjPKYlFAP9LgxqrJDv57zK3hQYAct
         GO/j+zfNH65byxVlcPc+JM8j2WS6ZuLILG7bZ5SduruiNiKDMPD8PoVuVtffXDKF1WnA
         Ai+s0KtzdhlTyaDNaQDPfbeC+n3Zni4BbWfXna5QVUmaiugPBakMGjxzdq6oulbVQ/sY
         DD1BBre+TdPZAIb9K3/xnE3SHCEP3QG7aJrgcc7FBB1I5M93wIsStJZLNalCSD7GS+IF
         gTaA==
X-Gm-Message-State: ABy/qLZ+JnuZUcGSG0KXI+ybhfjeeXxQli2T6CQxO9QWtva08NpyxjyV
        s+3PmFjiATdrn0ujAgcsO1aIsA==
X-Google-Smtp-Source: APBJJlGS++d0sRT2c3rAtoKA2jdF+oCpok6IprmNdlsUIan8A1ZsbG0hxgjlds4XaW0pt6cSO9Ipkg==
X-Received: by 2002:a17:907:2cc9:b0:993:d536:3cb8 with SMTP id hg9-20020a1709072cc900b00993d5363cb8mr1744265ejc.2.1690545060152;
        Fri, 28 Jul 2023 04:51:00 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id b14-20020a1709062b4e00b00992acab8c45sm2002125ejg.12.2023.07.28.04.50.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 04:50:59 -0700 (PDT)
Message-ID: <181e2a7c-4299-ed90-e069-9838847d4049@linaro.org>
Date:   Fri, 28 Jul 2023 13:50:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 30/50] spi: dt-bindings: atmel,at91rm9200-spi: remove
 9x60 compatible from list
Content-Language: en-US
To:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, tudor.ambarus@linaro.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230728102819.266809-1-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230728102819.266809-1-varshini.rajendran@microchip.com>
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

On 28/07/2023 12:28, Varshini Rajendran wrote:
> Remove microchip,sam9x60-spi compatible from the list as the fallback is
> really atmel,at91rm9200-spi.

Sorry, this explanation tells me nothing. The fallback is really
microchip,sam9x60-spi... You need to explain in commit msg why sam9x60
is incorrect as fallback.

> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml b/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
> index 58367587bfbc..32e7c14033c2 100644
> --- a/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
> +++ b/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
> @@ -22,7 +22,6 @@ properties:
>            - const: atmel,at91rm9200-spi
>        - items:
>            - const: microchip,sam9x7-spi
> -          - const: microchip,sam9x60-spi

If that's true, then it should be part of previous enum.

>            - const: atmel,at91rm9200-spi
>  
>    reg:

Best regards,
Krzysztof

