Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71746B39DC
	for <lists+linux-spi@lfdr.de>; Fri, 10 Mar 2023 10:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjCJJO1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Mar 2023 04:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjCJJN3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 Mar 2023 04:13:29 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4402C9C98E
        for <linux-spi@vger.kernel.org>; Fri, 10 Mar 2023 01:09:00 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id a25so17884848edb.0
        for <linux-spi@vger.kernel.org>; Fri, 10 Mar 2023 01:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678439339;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7t4Gsp5fEyU3cGgDAsUw1LlTJmjbxkDp1dgVC0JmGDk=;
        b=t3gjit1KSTDr4K8KJgmHrSlghQp8ovONGCEv8qI1C5oQK6u4P5XeSgG/lqz+d/iU+1
         CqoZcpYb5QUZZ+vza+RcBDqsYxc5HEka4Y9wt+F3suIfIvkdC5h3N72xuomEUuPYZgPg
         AWPPABTNVdCeeAGohnAtdCzQp/wzupkC/HcsnzDk1xzIX4EUc9LsSHB5JUMQh9WJmIkb
         q78KH3MUXNnziD3dwU50DaQ5b5cSF6P21XaQD1rXzcXK31kR/0aGjCPyA2jsa5vehz4p
         jfV9jsirlIQgtZ6wPebXO5oIdmlXI4aAVVGbKE2O7RLoUOx9nRN1Hg7hYE2A4eGoyiJ1
         Aa/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678439339;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7t4Gsp5fEyU3cGgDAsUw1LlTJmjbxkDp1dgVC0JmGDk=;
        b=A9bNy4DfrcWAGxQ2yCra1m41ipr/eje2l4Bup5MmgJ1LCVQ+aQV7HzciTj6sgsv+zR
         1Q3XsDOlmZ0XE2BrZSzxF5YJaL88lnhxmlyo8botsXFMh7+a4FtYh1g8QPwVChIsseSt
         5pT9rvcynvYp9wj33nuFWBHUuqier+87cRWX0fZRtLlaqhY45wBmc3NY5n8K1CBHztkq
         v8e8wJb8mJTulnSSl8BArdTCSKKIHREw3b0nWbfDz/4bC9yAcQrPLuMkdIbg+eAanUkF
         EImQ5KzIgph3xsv+rlWrxA3LWDRuJySFK1AMUPAAsYPRciYmn111hY82KohnuEYS5yTT
         PruA==
X-Gm-Message-State: AO0yUKUZngYk41yTvfMDf7fQUsQiTPxciVNZ+Aq5AzCUoDZPnbSyij89
        rR2ou/wMYSIgqibRZokDVkqHzA==
X-Google-Smtp-Source: AK7set/Ez8sA1fjZrr1cSy5vJ3kZkxjks0tyBEScgJbXlFVJ7r5cx0k7UBK+VXlTalft+13c+Zwl5Q==
X-Received: by 2002:a17:907:8a1e:b0:8b1:264d:6187 with SMTP id sc30-20020a1709078a1e00b008b1264d6187mr30332830ejc.46.1678439338805;
        Fri, 10 Mar 2023 01:08:58 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:2a59:841a:ebc:7974? ([2a02:810d:15c0:828:2a59:841a:ebc:7974])
        by smtp.gmail.com with ESMTPSA id kz5-20020a17090777c500b008b7a9ff7dfdsm695777ejc.162.2023.03.10.01.08.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 01:08:58 -0800 (PST)
Message-ID: <c254b2f1-2086-498f-35c6-c87d838bcb2d@linaro.org>
Date:   Fri, 10 Mar 2023 10:08:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 1/2] dt-bindings: spi: add loongson spi
Content-Language: en-US
To:     zhuyinbo <zhuyinbo@loongson.cn>, Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liu Peibao <liupeibao@loongson.cn>, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn, Mark Brown <broonie@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Rob Herring <robh+dt@kernel.org>, wanghongliang@loongson.cn
References: <20230308025908.21491-1-zhuyinbo@loongson.cn>
 <20230308025908.21491-2-zhuyinbo@loongson.cn>
 <167828359942.2612999.3798783623764270312.robh@kernel.org>
 <1f14658a-5dc3-fc48-5291-28e14f88abaa@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1f14658a-5dc3-fc48-5291-28e14f88abaa@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 10/03/2023 03:31, zhuyinbo wrote:
> 
> 在 2023/3/8 下午10:06, Rob Herring 写道:
>> On Wed, 08 Mar 2023 10:59:07 +0800, Yinbo Zhu wrote:
>>> Add the Loongson platform spi binding with DT schema format using
>>> json-schema.
>>>
>>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>>> ---
>>>   .../bindings/spi/loongson,ls-spi.yaml         | 47 +++++++++++++++++++
>>>   MAINTAINERS                                   |  6 +++
>>>   2 files changed, 53 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/spi/loongson,ls-spi.yaml
>>>
>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>
>> yamllint warnings/errors:
>>
>> dtschema/dtc warnings/errors:
>> Error: Documentation/devicetree/bindings/spi/loongson,ls-spi.example.dts:22.28-29 syntax error
>> FATAL ERROR: Unable to parse input tree
>> make[1]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/spi/loongson,ls-spi.example.dtb] Error 1
>> make[1]: *** Waiting for unfinished jobs....
>> make: *** [Makefile:1512: dt_binding_check] Error 2
>>
>> doc reference errors (make refcheckdocs):
> 
> This yaml patch need depend on
> 
> https://lore.kernel.org/all/20230307115022.12846-1-zhuyinbo@loongson.cn/
> 
> , then yaml  compile will be successfull.

Nothing in the patch changelog (where it is preferred), not even cover
letter, mention dependencies.

Best regards,
Krzysztof

