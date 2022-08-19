Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CBC599B9C
	for <lists+linux-spi@lfdr.de>; Fri, 19 Aug 2022 14:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348887AbiHSMGb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 19 Aug 2022 08:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348710AbiHSMG3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 19 Aug 2022 08:06:29 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EA710096B
        for <linux-spi@vger.kernel.org>; Fri, 19 Aug 2022 05:06:26 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id o2so5875798lfb.1
        for <linux-spi@vger.kernel.org>; Fri, 19 Aug 2022 05:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=/Sb3w6Y1BeOgZMrIBk6x8kpTOxRss537p36tvRmvnAg=;
        b=dH9RyMR3lKC/qZOXxXjEafcK7XBKChilHFvq0LsT4iA780RiPQKoXew3aujRndsSfM
         9WHc33SEm49OFB78kb/hStFA6mKaEQmQlBw0XJ04mfvWdymVok5fsh1xOFJEHLgvgLPm
         Yp3uOpwElmcoTR2sh6KeSZ/zf/HMZ3YG2IFsWbexZPGa4OtUlAXXQ2uLt+pJ5vFNB9zm
         bbB9S8SzHl9EIDkvMetWJVwb4LexM/85N+ZGrEXtUv1PipNEw7aTnQEAwi6PSREWjHh6
         w99N2AtiTCixlxSc8KvbnhCDiUEtlgSqXHjRkqz0qbINVJgGwrblkZwfXu/5VAqYwKFy
         JmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=/Sb3w6Y1BeOgZMrIBk6x8kpTOxRss537p36tvRmvnAg=;
        b=5eXv5WVrOBlue3IcZZ9hAjH2NE3KMyMSZMuVB9/Fcxxxan3cCJp5dOTCiYNlBCeKMh
         iOVBG28UrlXlIRm2sGkIrqt+YA7QGXOlThv430MokZDYDG4rzi/s0QxR8dwEw1cSRhrH
         I3QtOplLt1pYz/FllNZNjamWZldG2CU88V4rMa3oyXmfgg/ZcKpoGhy3/TfPsltsZ/x3
         QLslp50i4zSlnSyVjnPBX7FFWrF0c3n6bA1N7Xjnsd7riSMt9kHDd6ty+q0UTevpI8qJ
         L4QY4yy9vBrjfhgqzvGXYOprTbXC2dYLb4AHy9xK9PG4V7atStSqPSHndaPT/JQ/Az89
         RCwA==
X-Gm-Message-State: ACgBeo2CHAx15o0aHKcxhf9Yye5J3GkgUgPBV4gBN35GyPgsSJa8AVDL
        jdWSklGl1wkhmCt399alXf8oCA==
X-Google-Smtp-Source: AA6agR4UDDM3tfvRJzYG1IzCN1p3rR1zz78x4mZxht+ZjrTuTapl3U/WvyNHyNKsLsCkmdOM4E5jTg==
X-Received: by 2002:a05:6512:358d:b0:48b:37f:dce2 with SMTP id m13-20020a056512358d00b0048b037fdce2mr2131532lfr.267.1660910784888;
        Fri, 19 Aug 2022 05:06:24 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5? (d1xw6v77xrs23np8r6z-4.rev.dnainternet.fi. [2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5])
        by smtp.gmail.com with ESMTPSA id u24-20020ac258d8000000b00492cebbeefbsm115021lfo.59.2022.08.19.05.06.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 05:06:24 -0700 (PDT)
Message-ID: <0871f3af-cb37-e490-f0b3-88703652b089@linaro.org>
Date:   Fri, 19 Aug 2022 15:06:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/5] dt-bindings: mfd: atmel,at91-usart: convert to
 json-schema
Content-Language: en-US
To:     Sergiu.Moga@microchip.com, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, Claudiu.Beznea@microchip.com,
        radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        admin@hifiphile.com, Kavyasree.Kotagiri@microchip.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org
References: <20220817075517.49575-1-sergiu.moga@microchip.com>
 <20220817075517.49575-3-sergiu.moga@microchip.com>
 <c1a98a3e-609e-7783-b1b7-3bb39caa8c65@linaro.org>
 <ddd8ca9a-1fc1-7d37-07e8-f6f7f4617eef@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ddd8ca9a-1fc1-7d37-07e8-f6f7f4617eef@microchip.com>
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

On 19/08/2022 12:25, Sergiu.Moga@microchip.com wrote:
> On 18.08.2022 11:38, Krzysztof Kozlowski wrote:
>> On 17/08/2022 10:55, Sergiu Moga wrote:
>>> Convert at91 USART DT Binding for Atmel/Microchip SoCs to
>>> json-schema format.
>>>
>>> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
>>> ---
>>>   .../bindings/mfd/atmel,at91-usart.yaml        | 190 ++++++++++++++++++
>>>   .../devicetree/bindings/mfd/atmel-usart.txt   |  98 ---------
>>>   2 files changed, 190 insertions(+), 98 deletions(-)
>>>   create mode 100644 Documentation/devicetree/bindings/mfd/atmel,at91-usart.yaml
>>>   delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-usart.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/atmel,at91-usart.yaml b/Documentation/devicetree/bindings/mfd/atmel,at91-usart.yaml
>>> new file mode 100644
>>> index 000000000000..cf15d73fa1e8
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mfd/atmel,at91-usart.yaml
>>> @@ -0,0 +1,190 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +# Copyright (C) 2022 Microchip Technology, Inc. and its subsidiaries
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/mfd/atmel,at91-usart.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Atmel Universal Synchronous Asynchronous Receiver/Transmitter (USART)
>>> +
>>> +maintainers:
>>> +  - Richard Genoud <richard.genoud@gmail.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    oneOf:
>> This looks quite different than bindings and you commit msg is saying it
>> is only a conversion. Mention any changes against original bindings.
>>
>>> +      - const: atmel,at91rm9200-usart
>>> +      - const: atmel,at91sam9260-usart
>>> +      - const: microchip,sam9x60-usart
>> That's an enum
>>
>>> +      - items:
>>> +          - const: atmel,at91rm9200-dbgu
>>> +          - const: atmel,at91rm9200-usart
>>> +      - items:
>>> +          - const: atmel,at91sam9260-dbgu
>>> +          - const: atmel,at91sam9260-usart
>>> +      - items:
>>> +          - const: microchip,sam9x60-dbgu
>>> +          - const: microchip,sam9x60-usart
>>> +      - items:
>>> +          - const: microchip,sam9x60-usart
>>> +          - const: atmel,at91sam9260-usart
>> This is not correct - contradicts earlier one.
>>
>>> +      - items:
>>> +          - const: microchip,sam9x60-dbgu
>>> +          - const: microchip,sam9x60-usart
>>> +          - const: atmel,at91sam9260-dbgu
>>> +          - const: atmel,at91sam9260-usart
>> What? You wrote above that microchip,sam9x60-dbgu is compatible only
>> with microchip,sam9x60-usart. Now you write it is also compatible with
>> other ones?
>>
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  clock-names:
>>> +    contains:
>>> +      const: usart
>> No, this has to be specific/fixed list.
>>
>>> +
>>> +  clocks:
>>> +    minItems: 1
>>> +    maxItems: 2
>> Not really - define the items. One item could be optional, though.
>>
>>> +
>>> +  dmas:
>>> +    items:
>>> +      - description: TX DMA Channel
>>> +      - description: RX DMA Channel
>>> +
>>> +  dma-names:
>>> +    items:
>>> +      - const: tx
>>> +      - const: rx
>>> +
>>> +  atmel,usart-mode:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description: |
>> No need for |
>>
>>> +      Must be either 1 for SPI or 0 for USART.
>> Mention the header.
>>
>>> +    enum: [ 0, 1 ]
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - interrupts
>>> +  - clock-names
>>> +  - clocks
>>> +
>>> +if:
>> Put it under allOf.
> 
> 
> I missed this in the first read, but what do you mean by under allOf? 
> The only allOf's in this file are under the then:'s.
> 

It means that "if:" is preferred to be under allOf, just like example
schema is showing:
https://elixir.bootlin.com/linux/v5.19/source/Documentation/devicetree/bindings/example-schema.yaml

Not some other allOf, which could be many in your bindings. The one
allOf in top-level, just like example schema.


Best regards,
Krzysztof
