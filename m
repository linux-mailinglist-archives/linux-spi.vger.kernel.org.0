Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED00607756
	for <lists+linux-spi@lfdr.de>; Fri, 21 Oct 2022 14:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiJUMyR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 Oct 2022 08:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiJUMyQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 21 Oct 2022 08:54:16 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C183326909F
        for <linux-spi@vger.kernel.org>; Fri, 21 Oct 2022 05:54:13 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id bh7-20020a05600c3d0700b003c6fb3b2052so1913380wmb.2
        for <linux-spi@vger.kernel.org>; Fri, 21 Oct 2022 05:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dcJ0BXzywjnrhti2p9MqhHIKm9sRkuR/9GbeUPAwfiI=;
        b=wX+jp2ux54182Z8x2Qwm/qwDyhMnic5dnmOdyq4OJf4qq+urYKyfHlPxL/in0oa5oF
         4qLB2JlpciF4ApNRMDcWA7A4cyvRRbOdo0Lc3VCE9MEJ5VvAeQgBhrh7agYl9OS1dIef
         aj7xwk1SLPArT/0Nw7IMxsWhui2uWtgEl5krn5a38S3qeA4MPuGW1HrdF6BfPOJPQXgT
         sl3UZgW1GejlPA1sde8euEY8rnngkUHgXYVI88BzrsfK71/jJZq0c7XYMmlfQAwuadSM
         MalxMQBacmlBQDSQ7Y+5HuKVWIEb0gGqAUYGfWT0CM27tWmu1lMpCo53wxLxx3AQ0iEk
         fwQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dcJ0BXzywjnrhti2p9MqhHIKm9sRkuR/9GbeUPAwfiI=;
        b=xuPL3L3QODGOYsxWVmdXbrWM0LBFTYOgyygAFZRsUSe8oaTAg5g66y+k1MbVkkR3G3
         K5Rved/JDllx/CvdfcThAoxoZ9eeXAQA3ZAezkue/NhH5TETwELa/8aq0vsbvZw09WYL
         vve/MHPIyM6KwEngGF3HH6UjzCkxsL/lSbvinXRC6fh4Y7xy1GcC5uAlYdnJ6wUYUrQr
         xII9tTpMULWxl8njwlzkcRjcu52J/267NOWjFItYk8qZXLGy1zFWg/z/pYU6nUDHJqQs
         QCKXsrCMPjwLau92Z3W0VfMFz5lkwHQAx3m553YxqNmorYL7/+FJ1R6A3Ns87sr+2rCc
         k4vg==
X-Gm-Message-State: ACrzQf2JJCcljphLNqDJui4bTzL4ezK35/E/In9A6AUsE5IqP7AQdm8X
        Ds+H4RShzkKzWbIZvT6jv6cMgg==
X-Google-Smtp-Source: AMsMyM6kt3xg2Xdg1CINtQr1rmLE0ZAUwFgzhyCyK+jU6LLz4X4K28erCFd4qZOffTf1L/Q7a3BJYw==
X-Received: by 2002:a05:600c:198d:b0:3b4:a62c:a085 with SMTP id t13-20020a05600c198d00b003b4a62ca085mr32345777wmq.140.1666356852156;
        Fri, 21 Oct 2022 05:54:12 -0700 (PDT)
Received: from [192.168.0.20] (210.145.15.109.rev.sfr.net. [109.15.145.210])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c750a000000b003b4868eb6bbsm3033961wmc.23.2022.10.21.05.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 05:54:11 -0700 (PDT)
Message-ID: <df1895c8-aec6-cada-e208-ccda8042860d@baylibre.com>
Date:   Fri, 21 Oct 2022 14:54:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v3 1/2] spi: dt-bindings: amlogic, meson-gx-spicc: Add
 pinctrl names for SPI signal states
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        neil.armstrong@linaro.org, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Da Xue <da@libre.computer>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221004-up-aml-fix-spi-v3-0-89de126fd163@baylibre.com>
 <20221004-up-aml-fix-spi-v3-1-89de126fd163@baylibre.com>
 <d355ee40-5905-4d10-8300-81e9a63117ee@linaro.org>
 <dc918114-8b89-441b-5ba1-aaf3ae084860@linaro.org>
 <20c115e0-0acf-dac2-2a30-0f394fa513ab@linaro.org>
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
In-Reply-To: <20c115e0-0acf-dac2-2a30-0f394fa513ab@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi

On 10/20/22 14:49, Krzysztof Kozlowski wrote:
>>>> +      properties:
>>>> +        pinctrl-names:
>>>> +          minItems: 1
>>>> +          items:
>>>> +            - const: default
>>>> +            - const: idle-high
>>>> +            - const: idle-low
>>> You should also define in such case pinctrl-0 and others.
>> Ok I thought it would be covered by the pinctrl-consumer.yaml
>> but yeah we should allow pinctrl-1 and pinctrl-2 here aswell by adding:
>>
>>               pinctrl-1: true
>>               pinctrl-2: true
>>
>>
In such case, should I define pinctrl- as part of the if statement, as shown below,

or before allOf ?

[...]

   - if:
       properties:
         compatible:
           contains:
             enum:
               - amlogic,meson-gx-spicc

     then:
       properties:
         pinctrl-0: true
         pinctrl-1: true
         pinctrl-2: true

         pinctrl-names:
           minItems: 1
           items:
             - const: default
             - const: idle-high
             - const: idle-low

[...]

Regards

Amjad

> Yes.
>
> Best regards,
> Krzysztof
>
