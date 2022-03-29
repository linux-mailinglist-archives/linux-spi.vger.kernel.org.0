Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2283C4EAC74
	for <lists+linux-spi@lfdr.de>; Tue, 29 Mar 2022 13:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbiC2Lke (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Mar 2022 07:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiC2Lkd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 29 Mar 2022 07:40:33 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8086022BE1
        for <linux-spi@vger.kernel.org>; Tue, 29 Mar 2022 04:38:50 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id c10so16110636ejs.13
        for <linux-spi@vger.kernel.org>; Tue, 29 Mar 2022 04:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zq7C4iKRvGebllBAZvWIf+7v5FAFoQ2UwNc++oi/Xyk=;
        b=fQrU6QtWl2BlvbvHbYiCFBDjiB5efV4HULcyfbCoE3DWWFazC6Po7Tbxaougb/ju4n
         YrEfnbVA1Cz95GiJGigQZE9PxLsnILqrr1Lz7kaAPXWmNa3m80YCuDqUecx4h8z7U0Fg
         WG3M8H+J9ZZDLYZR1cat2kr/vfprHjmWvAKgv5acLY9K1MQ5a9bsqSrtJFy3FLh9UFS7
         Xki1BQf8g4TrKyGDubNB0a3+nfQ/VRwmMo2ntrl/sy92x6WuWuXx+n/BYKC8jfnEyAGb
         K9qZH17zwFilagAutbdCK36WKie4tx5/Au93FlARoSjiQFn7b1tPyVIwlyERsWWWanCJ
         0Xaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zq7C4iKRvGebllBAZvWIf+7v5FAFoQ2UwNc++oi/Xyk=;
        b=pTaQzNmKUlfdwUqe8RgM10aNfiZ5DdcLHWPPcCLFBzJYlV3n5ITTYiVoEjg2ttzrrn
         08/ZbeUI8ivPa5T8ZNTS0DkpaO3vITdxslp9aGyeJyxMHWDY34aW38lAUpq0kX23k5zT
         GCUpawa6SGxLUoVrLr36MUcA44HqdpgcvO7K9quB7s6oZOxKqx4GKBUilZLrnGHXaXwb
         yNCb5NcObPbB3hgbuw5JJLPlMRCT3jWBcDgeDBL8OPkybjmNgXKOeAg+aeaGAzixY7Y7
         +9E/lK58sumMCZiK/fdon131IRaebbLdq9+VmWjBp2jheg7s7fsPfmmw5pWuuqchhU2l
         0UjQ==
X-Gm-Message-State: AOAM533Toy//Quox9aCawyWTJPgqxUELgYgXXLlZZO49oKqduDQoCzFB
        nCAcyMSBxIp8mFo4k1x5t8/s3Q==
X-Google-Smtp-Source: ABdhPJwm2Fi3ujst5BqI4idBxlwsi1QPSj+C52k/wNTafoARGRJny3jh/mBSuUURm9rD8YsQh9roHg==
X-Received: by 2002:a17:907:6d19:b0:6db:89c8:52e3 with SMTP id sa25-20020a1709076d1900b006db89c852e3mr34739534ejc.754.1648553929117;
        Tue, 29 Mar 2022 04:38:49 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id dt6-20020a170907728600b006dff778258csm7065347ejc.32.2022.03.29.04.38.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 04:38:48 -0700 (PDT)
Message-ID: <42f07e63-107a-f8f5-1a44-9a93705516ba@linaro.org>
Date:   Tue, 29 Mar 2022 13:38:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/4] spi: dt-bindings: qcom,spi-qup: convert to dtschema
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220329112902.252937-1-krzysztof.kozlowski@linaro.org>
 <20220329112902.252937-5-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220329112902.252937-5-krzysztof.kozlowski@linaro.org>
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

On 29/03/2022 13:29, Krzysztof Kozlowski wrote:
> Convert the Qualcomm Universal Peripheral (QUP) Serial Peripheral
> Interface (SPI) bindings to DT Schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/spi/qcom,spi-qup.txt  | 103 ------------------
>  .../devicetree/bindings/spi/qcom,spi-qup.yaml |  82 ++++++++++++++
>  2 files changed, 82 insertions(+), 103 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qup.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qup.yaml

I forgot to update the path in
Documentation/devicetree/bindings/soc/qcom/qcom,gsbi.txt

I will send a v2 ~tomorrow.

Best regards,
Krzysztof
