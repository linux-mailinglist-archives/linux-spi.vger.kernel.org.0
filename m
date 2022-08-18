Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D227F59801E
	for <lists+linux-spi@lfdr.de>; Thu, 18 Aug 2022 10:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237786AbiHRIbr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Aug 2022 04:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240778AbiHRIbn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 18 Aug 2022 04:31:43 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E524AFAD6
        for <linux-spi@vger.kernel.org>; Thu, 18 Aug 2022 01:31:41 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id u1so1222809lfq.4
        for <linux-spi@vger.kernel.org>; Thu, 18 Aug 2022 01:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=+AYPEavLhHjc8NjLvs2dPmTNTkd/CClCaa85BTp1bjY=;
        b=STFobP21Yf2PS4rMrkrrI1sUpvSs479ohgcZAloOUX2+29lmRpHvnoKRozLgY8Ad4Q
         aiWmAQbPCyFB18jyBhZs/wvxpouI7EfXvY9QWLqMilE33HTFMFEwmvjMWS5dEj2Veu8T
         PhCSZVEijtHF0t3bMsBPGBmMbm5631aFxu+Kov7KCEo5LCI39jgo9Nsw6jOWCqAYCZVR
         140b0tmSgLrB1BClwsCeVREqpChu1a883q80Fg+91UPcYTDbtGqW7bf03ANXbtgFl1vV
         hc8EPuYMOCVWmyJObWXiqaWZyI+ObhZXSk5L7bf2EVy4hptRFSCq8NmvJDrZ6vqi6jOh
         qoXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=+AYPEavLhHjc8NjLvs2dPmTNTkd/CClCaa85BTp1bjY=;
        b=Q5INI9mITLV5+QUFjQPmYYrAqGd+5O7YuyeVFZuO50UNJp5itywR5/QSiopeBHTPw6
         ITsvx1x9wBSikJfKEq3wjIclpr5FZMALN76PtYjwSz1Go0BCJ3ruGeUuobXMxrnw60rl
         qKuFlsKrAi+d6XLGvfCRuzk7pPdQQvTdQo9ibJtthkokqEAuNy9dYKEx9tAzwqQNFvNG
         MDWBK/yYwdyoEZS7dWrIhR/iAv10YK8FsAMDL1WhX9Oct+TpB02FdZcgyRV1yISFS9rc
         eqc0G9gp2vmmKOxJSE1Kw44Ey91/jF1LAJWA/Gn+a/4j+ARWtKSopGCnh/Mt4K9Ce5Fm
         DcxA==
X-Gm-Message-State: ACgBeo1ICu0L3G4CgCalYToFoHrQex0Bom/8lBg7ZFeeoWyjj0B0YsrB
        o6YX2/VN8hZjknMJJ0hqb7mtsw==
X-Google-Smtp-Source: AA6agR5X7kpcMjGLMeLZIEZPXs6j4sMZGb7uMlfWVX7VavZBdDerNtf9zWUanDu7lBUtNOuVQzN/iA==
X-Received: by 2002:a05:6512:118a:b0:492:a32d:3678 with SMTP id g10-20020a056512118a00b00492a32d3678mr575248lfr.259.1660811499593;
        Thu, 18 Aug 2022 01:31:39 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:53ab:2635:d4f2:d6d5? (d15l54z9nf469l8226z-4.rev.dnainternet.fi. [2001:14bb:ae:539c:53ab:2635:d4f2:d6d5])
        by smtp.gmail.com with ESMTPSA id e24-20020a2e9e18000000b0025e48907929sm134615ljk.23.2022.08.18.01.31.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 01:31:39 -0700 (PDT)
Message-ID: <6741e694-1400-bf76-b0f2-67a42c43edd0@linaro.org>
Date:   Thu, 18 Aug 2022 11:31:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/5] dt-bindings: mfd: atmel,sama5d2-flexcom: Add SPI
 child node ref binding
Content-Language: en-US
To:     Sergiu Moga <sergiu.moga@microchip.com>, lee@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, radu_nicolae.pirea@upb.ro,
        richard.genoud@gmail.com, mturquette@baylibre.com,
        sboyd@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org,
        admin@hifiphile.com, kavyasree.kotagiri@microchip.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org
References: <20220817075517.49575-1-sergiu.moga@microchip.com>
 <20220817075517.49575-2-sergiu.moga@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220817075517.49575-2-sergiu.moga@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 17/08/2022 10:55, Sergiu Moga wrote:
> Another functionality of FLEXCOM is that of SPI. In order for
> the proper validation of the SPI children nodes through the binding
> to occur, the proper binding for SPI must be referenced.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> ---
>  .../devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml       | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
> index 568da7cb630c..e158af47c326 100644
> --- a/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
> +++ b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
> @@ -78,10 +78,9 @@ patternProperties:
>        of USART bindings.
>  
>    "^spi@[0-9a-f]+$":
> -    type: object
> +    $ref: ../spi/atmel,at91rm9200-spi.yaml

Full schemas path, so:

/schemas/spi/atmel....


Best regards,
Krzysztof
