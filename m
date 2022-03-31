Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5B24EDE50
	for <lists+linux-spi@lfdr.de>; Thu, 31 Mar 2022 18:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239556AbiCaQFw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 31 Mar 2022 12:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239580AbiCaQFv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 31 Mar 2022 12:05:51 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBF94E3AB
        for <linux-spi@vger.kernel.org>; Thu, 31 Mar 2022 09:04:03 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id o10so359362ejd.1
        for <linux-spi@vger.kernel.org>; Thu, 31 Mar 2022 09:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=i8exGV0bEfz7fockPDZIKH4DGjNDQmL1A2DdSanaA7k=;
        b=IhU2wwo68dPixujjFS6hH/gAYbuctadDiy/If18pSZUCMCNprATz0oYCXVL5pSvVAG
         bhDMnPn5qkBHVe8jw2TCF2PXVjYKf+ieCgLJFAK6XGGN2nQFld+ECzvY/SIPJYcK9gar
         LISOK+NThskRi1GE4JJnYnqto41X30GBteiG5ZwKxGoXY8/tim9YCiR3yi5dQhOOL/M5
         95UR5fxHjsJ1VVqVnffDD40i8cbp2LyeElS1YoxqN1KS5PdwyUb/8vJ+OQMuuSSRixW3
         EZUrjFuKmD2ALNe0zmGdJdq/2/wIlD0BaWp7f89F18JUF4/hWybszVCMB3SaCCqcNn8x
         iJhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=i8exGV0bEfz7fockPDZIKH4DGjNDQmL1A2DdSanaA7k=;
        b=m1L047dof/cudW1XwddDHOSeN8+ACSgP8xEyfQrePYDBOpQF+w1CEz1HPpmitfZm5Y
         i6FxOOiUvb60g2mLAOTezQDZHCQqi7t4W+bNthQQmGSCWQ+kuRLqvP/2Vk6U8bc4AV5Y
         xPDhOD6x7ecyCT6bqC6Tvvtm/81NZpMkaI+qHThyMiamhz1AbYB2o/az+I2XLosHdtOl
         w9fQME/myXpwHyNLD99UIXy1VDzvxmQuvG3qr6OAVTIhr5MDs9+ZUNq1gW6rOkoFo/c4
         BV0at2xa8rHlPXmIg/jRWAZTG2V7YQW97f5zG3oOxG4dHp0VbmmD6KTugW2fW2Ovhq0T
         05Uw==
X-Gm-Message-State: AOAM5324Ec9PtcfgBGSAcB6Baag4dahaOTEu2GA5vXgxlj8GNSEBq7W1
        5AZpEY2kQ1cyqmkODUYnWAkVKA==
X-Google-Smtp-Source: ABdhPJy69ag8KVOrx4BRxgGGK2T7r/5GAGO/MSehpQqn+sTUWTGcI/9ZWNOTYQpCVeKhWbd54mQOjw==
X-Received: by 2002:a17:907:1b07:b0:6e4:b202:db8f with SMTP id mp7-20020a1709071b0700b006e4b202db8fmr2701516ejc.76.1648742641536;
        Thu, 31 Mar 2022 09:04:01 -0700 (PDT)
Received: from [192.168.0.167] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id b25-20020a056402139900b0041904036ab1sm11452823edv.5.2022.03.31.09.04.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 09:04:01 -0700 (PDT)
Message-ID: <1e2a48f8-e6b5-abf9-0996-3b8d2d97b4de@linaro.org>
Date:   Thu, 31 Mar 2022 18:04:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 0/4] spi: dt-bindings: qcom: convert qcom,spi-qup to DT
 schema
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Cc:     Kuldeep Singh <singh.kuldeep87k@gmail.com>
References: <20220331155320.714754-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220331155320.714754-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 31/03/2022 17:53, Krzysztof Kozlowski wrote:
> Hi,
> 
> Changes since v1
> ================
> 1. Fix path in com/qcom,gsbi.txt.
> 2. Merge clock-names in example, correct $ref path (Kuldeep).
> 
> Merging
> =======
> The DTS patches are independent and silence warnings pointed
> out by schema.
> 
> Best regards,
> Krzysztof
> 
> Cc: Kuldeep Singh <singh.kuldeep87k@gmail.com>
> 

I forgot to add the ack from Kuldeep:

Acked-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>


Best regards,
Krzysztof
