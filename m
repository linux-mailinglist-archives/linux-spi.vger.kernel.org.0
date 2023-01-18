Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E8C671687
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jan 2023 09:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjARIvm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 Jan 2023 03:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjARIvR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 18 Jan 2023 03:51:17 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D6495776
        for <linux-spi@vger.kernel.org>; Wed, 18 Jan 2023 00:03:37 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id t5so28624561wrq.1
        for <linux-spi@vger.kernel.org>; Wed, 18 Jan 2023 00:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fLNM9ft32zFXXfqtL17IA3aBUBoKO11Uoqk9r9Qxwxk=;
        b=TGLD0SbJq/4zsdHf0dT29VEd5JyE4lIP2crA5/0zBsk4mN4raFztSH6OQLcPdEGSGj
         /VCftlZyAVPCL23s3lxBG0DQZ77uMjfQlPBKs7tYu30rYliLIFIekLbP9I6IejMjrfnh
         VchoJ6fAzAy1j+qPwFyB1174mGlr+Jx5AtdKFauQhQ63ezraUgi3/8HJdy0g/X68SMzm
         UgXx/BsF/LWrlZ1Piujj9Cpx3ia3DcUMbOuCWh5ttt5SX94+71yP1WDa2TKmXWSdTE8l
         /L5yqVB4FQLuS05/7TQn5rn8UelQBlm68oQjcrM0lIO/yDaXrLhVl7Avrr/eG+sCv4e6
         +IRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fLNM9ft32zFXXfqtL17IA3aBUBoKO11Uoqk9r9Qxwxk=;
        b=4306OcAGvA+b4ZnF71N2ewgJV8s5df4uSJSpnNQ5H+yP/OCBim7xb9KrFgicgNyeoW
         D8aGGMYwFObKPjnOEjkSoly7IwMyM3GLXIEigmyP6h97FZOPVoQ8S2Vg6N+Uwl/wqEV3
         ib2veXsUdtABCrbS17UtvxM4UeNBEKYjmlFlD5kVldK8176GZrx5y8xfWs1s4gvy+nRY
         2fXsYBcJ9UgLaCxSSmjWQ8VGOSi2rHVtnQNLH/twm4BhCscBBgd3TzvZaedVFNhaHK/V
         5bs7HAD4GVAqiJe5JRhQMAGyFKC8BUR3n1117qXdACWzNDP9pJTbUrRSUebzj5pdVmhQ
         VxRA==
X-Gm-Message-State: AFqh2koS3P3ER7MJqMqaMKSvfvyi2U7jIIF3j3mWXBcYQ3eQbsPZszuk
        XaV1J2mGyByL5xqC8Vv4JFZ/qA==
X-Google-Smtp-Source: AMrXdXsAiQGCUW9JSEcjIZv6uYmDqncwiSSzh0o3FJWQMsNwfTwUMQxPpw9MCkHAAl9wMUPVxInnJw==
X-Received: by 2002:adf:f8c4:0:b0:2be:34f:4fc4 with SMTP id f4-20020adff8c4000000b002be034f4fc4mr5487556wrq.13.1674029015746;
        Wed, 18 Jan 2023 00:03:35 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id u24-20020adfa198000000b002bc84c55758sm27206974wru.63.2023.01.18.00.03.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 00:03:34 -0800 (PST)
Message-ID: <2a684f19-6749-ddb0-6e32-4ffe35269cb3@linaro.org>
Date:   Wed, 18 Jan 2023 09:03:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] spi: dt-bindings: spi-fsl-qspi: add optional
 sampling-delay
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>, han.xu@nxp.com
Cc:     broonie@kernel.org, dev@kicherer.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-spi@vger.kernel.org,
        robh@kernel.org
References: <20230117210500.oimf4yjkkqh3o4hi@umbrella>
 <20230118080159.112295-1-michael@walle.cc>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230118080159.112295-1-michael@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 18/01/2023 09:01, Michael Walle wrote:
> From: "han.xu" <han.xu@nxp.com>
> 
> Hi,
> 
>>>> unfortunately, the rx-sample-delay-ns property does not fit here, as we 
>>>> can only delay
>>>> the sampling point between zero and three "half cycles" (or edges), not 
>>>> by an arbitrary
>>>> number of nanoseconds.
>>>
>>> Why this is a problem for FSL but not for other platforms having exactly
>>> the same constraints/property?
>>
>> Please use the common delay in DT and calculate to half cycle in driver, we have
>> the similar discussion before for fspi controller delay settings.
> 
> Do you mean [1]? There my suggestion was to use a -degrees property (because
> it doesn't depend on the frequency). There wasn't any follow-up, or did I miss
> something?
> 
> -michael
> 
> [1] https://lore.kernel.org/linux-spi/62f113a0cdb0d58bf04ab0b274912eb7@walle.cc/

I think the patch using existing ns property (and calculating cycles or
phase shift or whatever was needed) was merged. In such case please go
the same way.

Best regards,
Krzysztof

