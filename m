Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE9A727A80
	for <lists+linux-spi@lfdr.de>; Thu,  8 Jun 2023 10:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbjFHIxp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 8 Jun 2023 04:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbjFHIxo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 8 Jun 2023 04:53:44 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451D69E
        for <linux-spi@vger.kernel.org>; Thu,  8 Jun 2023 01:53:43 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-974638ed5c5so82928166b.1
        for <linux-spi@vger.kernel.org>; Thu, 08 Jun 2023 01:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686214422; x=1688806422;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AxDnfIeGDEgjasab2xKCt2UI0vyBkLC9/9iWa3HZ5tY=;
        b=R4G6uV1oPJlGhXrHkHDxx5b6w78932R2vqY4HcD9F6age09jph14lshZeGu7tcC23b
         3hCfI/UwGcxwAaDmrAnlI3nK2SsqAv9+3WDRI7/AzhxMlm1uBNsseKl4zwfmBqXlLS2t
         1Pe+T0jaFHR/1kHXwyGIy6xyRmHw5vFLmdM3fHI+Zgg2zfKFUS2QO5ZdqhguucjdLz7B
         VYi2GUBeHprA8enq8KtoGj0N5h4onepaxo4bIXTchaG8R55FPgDbo1KxRt1vffkcJRoY
         d3s8O4riIj/XjqSmvRTi+9mKH++AEORXbDwyNEogbr3ZL1y/U53kYVo5DIEuW/hleFUf
         8J6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686214422; x=1688806422;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AxDnfIeGDEgjasab2xKCt2UI0vyBkLC9/9iWa3HZ5tY=;
        b=eIX944vU7yao+IBIj/cLyMOSHBFHg6KIpd2hJU3bnLJYb/fNmaVNIbY7wi6kozCaOh
         i5aVNIJTeTV5rKknQ92tHGZM9SaWeIAwaB4G8i46vlqGkaCE/dX6bFnjI+oDi40v8Zg2
         rz+vecxMntiI45KOcNQBGq5CkQv3eU4FZZoC/DGQOOmcu9647d8IxHrhGQOLHskNmgxX
         keBiGk7x2dMXZRdEDwhqcJwhsNaHodrlEHf7z2n6g4aMaQC2qHNi/MVaV3jWTfBjhhwx
         OWFki3OcSVn+DAj9OD8w2vFTcgiBwGjiN8re4LJVjWQ5zgTB3Y9ixnrsMCOLkCgxAs85
         h2Og==
X-Gm-Message-State: AC+VfDz74njXtulx4JxUklA70XM3Rc4fpHR50dUcny54vycl3absfLN2
        TZ6nLkLMaciR6fl9g5gsAvkWYg==
X-Google-Smtp-Source: ACHHUZ6i1hcbV1Jj4VkqrWiOWrWz7QhzUl+9EviEgTci4V/Qbd9pvKDui7qf7SKn2NPoZaK5mkX1LA==
X-Received: by 2002:a17:907:6d85:b0:978:9235:d450 with SMTP id sb5-20020a1709076d8500b009789235d450mr1601734ejc.9.1686214421801;
        Thu, 08 Jun 2023 01:53:41 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id cf20-20020a170906b2d400b00977d14d89fesm411822ejb.34.2023.06.08.01.53.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 01:53:41 -0700 (PDT)
Message-ID: <6bfc2a22-6901-0858-7b90-bc4c52c66810@linaro.org>
Date:   Thu, 8 Jun 2023 10:53:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v12 1/2] spi: add loongson spi bindings
Content-Language: en-US
To:     zhuyinbo <zhuyinbo@loongson.cn>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
References: <20230608072819.25930-1-zhuyinbo@loongson.cn>
 <20230608072819.25930-2-zhuyinbo@loongson.cn>
 <6ebed84c-2b42-c981-7b3f-e71cc88e4c2c@linaro.org>
 <4bf747c4-b767-b20c-e00f-724b50f44edb@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4bf747c4-b767-b20c-e00f-724b50f44edb@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 08/06/2023 10:39, zhuyinbo wrote:
>>>
>>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>   .../bindings/spi/loongson,ls2k-spi.yaml       | 41 +++++++++++++++++++
>>>   MAINTAINERS                                   |  6 +++
>>>   2 files changed, 47 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml b/Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
>>> new file mode 100644
>>> index 000000000000..423ee851edd5
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
>>
>> Filename based on compatible.
> 
> 
> There will be more ls2k series SoC spi device in the future thus I still
> use "loongson,ls2k-spi.yaml" for cover it.

Add them now.

> 
>>
>>> @@ -0,0 +1,41 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/spi/loongson,ls2k-spi.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Loongson SPI controller
>>> +
>>> +maintainers:
>>> +  - Yinbo Zhu <zhuyinbo@loongson.cn>
>>> +
>>> +allOf:
>>> +  - $ref: /schemas/spi/spi-controller.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - loongson,ls2k1000-spi
>>
>> No compatibles for other devices? Didn't we have big discussion about this?
>>
>> https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L42
> 
> 
> There are other ls2k SPI devices compatible, such as,
> "loongson,ls2k0500-spi", "loongson,ls2k2000-spi" but currently I plan to
> add ls2k1000 spi device first, Other ls2k SoC spi device adaptation may
> require some additional work and I will add it later.

Previously you claimed this serves entire family, so I don't understand
why you need to fix something. Why previously it was working for entire
family but now it does not?

Best regards,
Krzysztof

