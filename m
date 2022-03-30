Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23334EBA7E
	for <lists+linux-spi@lfdr.de>; Wed, 30 Mar 2022 07:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbiC3F40 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Mar 2022 01:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243110AbiC3F4W (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 30 Mar 2022 01:56:22 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705381AF17;
        Tue, 29 Mar 2022 22:54:36 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bq8so25351124ejb.10;
        Tue, 29 Mar 2022 22:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from:to:cc
         :references:subject:in-reply-to:content-transfer-encoding;
        bh=DHKF29KIzeu21L0gO/jkIT7rciW0MBMKRGkMqwSkDA0=;
        b=Ka5X1JVLEP0R3joHzsWSElvFQxffajrDIUQlqK5XvxpfUlxsa/PJ1rLYEgsbwAb8j+
         kA2zZhTIX1Er0ykvpGGsYJo4SUPRQza1ZQFAzmt17/YV2TvWv4l/x11EwZOAOmgcGYzG
         pa8JHsF4hM8wgXzOAW58vPT1IpVo4W0MSbGLSyWQXLlN4BupFCA6HK45ufqT3DK11peL
         WCjxB7iJ2Sq3r7KDCUWvz5IxOX2OjsDitHMmXJINZM1euPE1bAj1xDIx7ucVEKRoIM5/
         d+lMZH5rT/Gm/LtgsG9nqYZuED1t9yF0f6MKQX/FFgC0la3Ndji7Pmkv8syMMd6Rb2WQ
         Jmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:to:cc:references:subject:in-reply-to
         :content-transfer-encoding;
        bh=DHKF29KIzeu21L0gO/jkIT7rciW0MBMKRGkMqwSkDA0=;
        b=n738cmEanF0tJLaiT3Cqpbx5g+iH0xuXigMCWh6r1ErS8fDHg1fhH3m1xhYNXqG1lb
         j9FiY5gCGbZPuc9XJk/BkeydV7KQpJ9g8s4buXaI+9EDQVuF3KuYQ7CND546K2EU68A6
         TL6Gi4kyl+Pf4yf34p71o7mFB3vmog0ACinBzBgEgWy/yLzQm2RmKKmYtQEjbPuYvqYg
         l5mN2RmypFzmIcVn1vrW8FRLNp6eRej2OXOM5nGah4DfLDJwJwEea5ynFSyk3N0EiKQL
         quugdge7eMYElrp1v7V3Ek706HO2lMfe1SirJdDT1BIlJyBeG9+8qx9W+MEgGEy2mtxO
         u/iA==
X-Gm-Message-State: AOAM530eO/7RR8v6p7YlH3vC4AbZZJfwIftF4O9hjDs1eODJR1geifuE
        wgVdro06q64un5BCnSjZjO8=
X-Google-Smtp-Source: ABdhPJx3zKca4J+605kYrlBKsx3Agjbdbik/tUx18mN6k4hHx3s9efeCcz7wXHpt280FBFx5m/EQ3w==
X-Received: by 2002:a17:907:6093:b0:6e0:dabf:1a9f with SMTP id ht19-20020a170907609300b006e0dabf1a9fmr23497528ejc.424.1648619674852;
        Tue, 29 Mar 2022 22:54:34 -0700 (PDT)
Received: from ?IPV6:2a01:c22:7297:6000:c4c:6238:939a:937? (dynamic-2a01-0c22-7297-6000-0c4c-6238-939a-0937.c22.pool.telefonica.de. [2a01:c22:7297:6000:c4c:6238:939a:937])
        by smtp.googlemail.com with ESMTPSA id hq15-20020a1709073f0f00b006dfc0fe42b1sm8009085ejc.177.2022.03.29.22.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 22:54:33 -0700 (PDT)
Message-ID: <5fde764f-4caf-8017-3cbd-3918f3390b6a@gmail.com>
Date:   Wed, 30 Mar 2022 07:54:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <90668779-b53d-b3e7-5327-af11ff4a1d18@gmail.com>
 <2671e6e3-8f18-8b70-244b-9e1415bfdf8f@gmail.com>
 <3bf14cf0-f00d-f718-30ea-e63272f3ce72@arm.com>
 <9e2fc38a-a51e-7635-970c-64948fc6eae4@kernel.org>
 <80937566-6455-b1bf-0a5d-a7b54dd3adc5@gmail.com>
Subject: Re: [PATCH v5 2/6] dt-bindings: auxdisplay: Add Titan Micro
 Electronics TM1628
In-Reply-To: <80937566-6455-b1bf-0a5d-a7b54dd3adc5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 23.03.2022 21:33, Heiner Kallweit wrote:
> On 21.03.2022 09:34, Krzysztof Kozlowski wrote:
>> On 18/03/2022 21:50, Robin Murphy wrote:
>>> On 2022-02-25 21:13, Heiner Kallweit wrote:
>>>> Add a YAML schema binding for TM1628 auxdisplay
>>>> (7/11-segment LED) controller.
>>>>
>>>> This patch is partially based on previous work from
>>>> Andreas Färber <afaerber@suse.de>.
>>>>
>>>> Co-developed-by: Andreas Färber <afaerber@suse.de>
>>>> Signed-off-by: Andreas Färber <afaerber@suse.de>
>>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>>> ---
>>>> v5:
>>>> - add vendor prefix to driver-specific properties
>>>> ---
>>>>   .../bindings/auxdisplay/titanmec,tm1628.yaml  | 92 +++++++++++++++++++
>>>>   1 file changed, 92 insertions(+)
>>>>   create mode 100644 Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml b/Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml
>>>> new file mode 100644
>>>> index 000000000..2a1ef692c
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml
>>>> @@ -0,0 +1,92 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/auxdisplay/titanmec,tm1628.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Titan Micro Electronics TM1628 LED controller
>>>> +
>>>> +maintainers:
>>>> +  - Andreas Färber <afaerber@suse.de>
>>>> +  - Heiner Kallweit <hkallweit1@gmail.com>
>>>> +
>>>> +allOf:
>>>> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: titanmec,tm1628
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  titanmec,grid:
>>>> +    description:
>>>> +      Mapping of display digit position to grid number.
>>>> +      This implicitly defines the display size.
>>>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>>>> +    minItems: 1
>>>> +    maxItems: 7
>>>> +
>>>> +  titanmec,segment-mapping:
>>>> +    description:
>>>> +      Mapping of 7 segment display segments A-G to bit numbers 1-12.
>>>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>>>> +    minItems: 7
>>>> +    maxItems: 7
>>>> +
>>>> +  "#address-cells":
>>>> +    const: 2
>>>> +
>>>> +  "#size-cells":
>>>> +    const: 0
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +  - reg
>>>
>>> Would it be fair to say that "spi-lsb-first" and "spi-3wire" are also 
>>> required? The chips aren't configurable so won't exactly be usable any 
>>> other way. Furthermore I believe the transmission format actually works 
>>> out equivalent to SPI mode 3, so should warrant "spi-cpha" and 
>>> "spi-cpol" as well.
>>>
>>>> +
>>>> +patternProperties:
>>>> +  "^.*@[1-7],([1-9]|1[0-6])$":
>>>> +    type: object
>>>> +    $ref: /schemas/leds/common.yaml#
>>>> +    unevaluatedProperties: false
>>>> +    description: |
>>>> +      Properties for a single LED.
>>>> +
>>>> +    properties:
>>>> +      reg:
>>>> +        description: |
>>>> +          1-based grid number, followed by 1-based segment bit number.
>>>> +        maxItems: 1
>>>> +
>>>> +    required:
>>>> +      - reg
>>>
>>> I'm concerned that this leaves us no room to support the additional 
>>> keypad functionality in future. Having now double-checked a datasheet, 
>>> the inputs are also a two-dimensional mux (sharing the segment lines), 
>>> so the device effectively has two distinct but numerically-overlapping 
>>> child address spaces - one addressed by (grid,segment) and the other by 
>>> (segment,key).
>>>
>>> Rob, Krysztof, any thoughts on the best DT idiom to leave accommodation 
>>> for that? I'm thinking either require an intermediate node to contain 
>>> each notional address space, or perhaps add another leading address cell 
>>> to select between them? I don't believe any of these things have further 
>>> functionality beyond that.
>>
>> I think intermediate nodes - leds, keys - are more appropriate, because
>> it is self-describing. Additional address space number would require
>> decoding this "0" or "1" into LED/key. For complex devices - like PMICs
>> with regulators, RTC and clocks - we already have such patterns.
>>
> Then it's just the question who can implement such an intermediate node
> based on what has been done so far.
> 
As it is now it seems we end up with empty hands again and have to wait
further two years for the next one to make an attempt.
That's a pity because for most users the relevant use cases are supported.

>> Best regards,
>> Best regards,
>> Krzysztof
> 

