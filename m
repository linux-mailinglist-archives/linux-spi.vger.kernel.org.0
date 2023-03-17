Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E7B6BED4F
	for <lists+linux-spi@lfdr.de>; Fri, 17 Mar 2023 16:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjCQPvY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Mar 2023 11:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjCQPvW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Mar 2023 11:51:22 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279EBAD02F
        for <linux-spi@vger.kernel.org>; Fri, 17 Mar 2023 08:51:21 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id w9so22228047edc.3
        for <linux-spi@vger.kernel.org>; Fri, 17 Mar 2023 08:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679068279;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VgbCEwBBaMJgjzTFKLCTgfUkZg+a1TMJ6pPEoqV63Hc=;
        b=LwuCElSXbXOCVZGj7kYeemZnW62++O0ppaxM7gnXTHJSYAyJpXJoVkQ6DwBOhLNaMJ
         Kf4s1x9Cc69FYIaJywiJMkt86sBWGheEfqggTlkg3v9Qs5LctnwnQfXKWmbQDk3Yuh9r
         g+tDtl8BlfPDL8GXvh6KyA5aggB1LpL2rV2UcjyA/qytvb7zxpgXFIc7eutHCtx14aze
         Y3byhgJcqb5+9UzImhKpn/GG+qN+lbe4sQLDvqmeBBegMst5k512i+IlC6pkBjt0sob4
         LaGs8Ob+BCPvmVjLrMR3UT2NUe4h9u7+3b91+l88eUdb624n8f9Od8Re/7TIJK49RGpT
         roCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679068279;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VgbCEwBBaMJgjzTFKLCTgfUkZg+a1TMJ6pPEoqV63Hc=;
        b=fZjTf3/06z9RlersvBQvOdyFMCUqLg+KmH5SvaUe99utwJC2cpYkFjcQXxu0Mh7GO0
         MEbWNQgOYaeZ7hjo/s6JGtWjQt4PYZvRVdPTdg0vvQyIrYkA3zfhQIhdRS5x8YyxYW2A
         Rt4PRMTcOqNOSNP51/wWD891IsYLyzoNUJiJdnnw+nxSSCxAQYMB2AY4vqklI01h02SE
         OKlf++ntMa9K3bsdhuK/qL94YhsWudvqAF/0ON+zNDDuTUMJ+dccIFO9JAluMrJtaOc9
         maDm5J+GydAC714vIZQDA35Gkypgzy356S8V5ObZ+7IGvCMnqpfmrUwaTyBS65E73+8t
         5t8w==
X-Gm-Message-State: AO0yUKUa1feQnlaXpjZ+/CDvtWdN29+CkEXnBNZOKohnNSkNb9ZAz+EI
        KMRNGpPaJcvK07H+Gapvw/6AIQ==
X-Google-Smtp-Source: AK7set+le+sP+6r2wPX7W1qxTD9Ck//nvh8FN3PUI0b+9ZyihWQUg3l+YvlQhJ034uCNeDK4yazy9w==
X-Received: by 2002:aa7:db97:0:b0:4fb:fd22:29b6 with SMTP id u23-20020aa7db97000000b004fbfd2229b6mr3165846edt.40.1679068279633;
        Fri, 17 Mar 2023 08:51:19 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d013:3eeb:7658:cec? ([2a02:810d:15c0:828:d013:3eeb:7658:cec])
        by smtp.gmail.com with ESMTPSA id k12-20020a50ce4c000000b004af70c546dasm1226755edj.87.2023.03.17.08.51.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 08:51:19 -0700 (PDT)
Message-ID: <7469290a-0671-7d2f-b0ce-cdde2a9e66cc@linaro.org>
Date:   Fri, 17 Mar 2023 16:51:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: add loongson spi
Content-Language: en-US
To:     zhuyinbo <zhuyinbo@loongson.cn>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
References: <20230317082950.12738-1-zhuyinbo@loongson.cn>
 <20230317082950.12738-2-zhuyinbo@loongson.cn>
 <a736c6db-466a-12e4-8e22-c8dc900978d4@linaro.org>
 <e944732b-9a2d-b6ff-8336-7363788809b9@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e944732b-9a2d-b6ff-8336-7363788809b9@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 17/03/2023 11:00, zhuyinbo wrote:
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - loongson,ls2k-spi
>>> +      - loongson,ls7a-spi
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    minItems: 1
>> I don't understand why did you change it. I did not ask for it.
>>
>> Best regards,
>> Krzysztof
> Add clocks "minItems: 1" description is for fix yaml file compile issue.

minItems: 1 is not correct, so you cannot use incorrect code to suppress
some warning. This should be list the clocks or use maxItems: 1, if you
have only one clock.

Best regards,
Krzysztof

