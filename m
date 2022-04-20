Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92552508D3D
	for <lists+linux-spi@lfdr.de>; Wed, 20 Apr 2022 18:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380551AbiDTQaA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Apr 2022 12:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380552AbiDTQ37 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Apr 2022 12:29:59 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99323ED17;
        Wed, 20 Apr 2022 09:27:10 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id r4-20020a05600c35c400b0039295dc1fc3so1591041wmq.3;
        Wed, 20 Apr 2022 09:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=YuoLu4qqTNwUsnLh7FVwMbSxnFqCd0u7cHyaNxa6tZ8=;
        b=VeajzzdqMwBU20EgOqUCmqUjlkWSfHCU+wgHjLjfPn4Ofqc5b3sxbLfrLEIKRwOsie
         TAKz3t8iV8ElPRIAHLJFUz6fvOOz11/hIyw/mKX2BbbWVtzhqmZrG2I7SEMD8xeF9AJC
         0vTNh33go4ByJi0GzeVyF8p/07od1enKvKjR4gOzMzwF4j10+aj3CjR6DwAmJirImxrr
         lccnoby7O4Z7lmzm8Z08g8bbLfJLxfprfN8ifUmbSZNjTtOMsG7Hgo1axWwva161oxvu
         O3QTEkpQpWac4aBMpYbmBZdkphmV4Jy7Tc9PEDYm+lX5GC5FZ8lzxZ2G0u6fAluvXGPF
         TAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=YuoLu4qqTNwUsnLh7FVwMbSxnFqCd0u7cHyaNxa6tZ8=;
        b=y0mKMXhNWrWeRcuJOEffoGfRxAA53UtglHphOZnnhEjmOnai5d2qxQipCAp9DVDuAq
         K0I2HEmKGbAufBAdfg/DhIu38NLOzDFqrTbJoiC8oMxgzgS9eY6Xl938kikmfatN+Hhl
         w8q5wQLJUtY+4cwoq/86syZPvW8uv8vdyEMRix5Jcrav2Cv4A0L8xbDjoPo33SHlHg7l
         GoZ83vpvQuTqRuQStHIqzbNrbyb011kfv8FyjdofIMWjxbvx9rxfzzNVungSh1Wpy19a
         qDG6fHdESdeIMbLx4ZOwGBT9twbJqTyObMPZCtOgEcDVPAD1/RG5vn2G5KqkrAzwAAWq
         zEow==
X-Gm-Message-State: AOAM530xELQETdB6Bz5QQ1KxTrWXof/uVfAplKwtE0VZtYNZ+LADg7kN
        Hfkv3mBPFeVP4UzFV0UY71ntnTLEy2g=
X-Google-Smtp-Source: ABdhPJyu8kZNJZukKtBcSgYEM/L2bR1iN6NWspjlmcOCdNPXn2wqr27FWAbxq+y6xw13D7eS1Oiy3w==
X-Received: by 2002:a05:600c:3d06:b0:38e:d74d:ac4c with SMTP id bh6-20020a05600c3d0600b0038ed74dac4cmr4616638wmb.42.1650472029040;
        Wed, 20 Apr 2022 09:27:09 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c184:a600:e563:f5ff:504a:6c0d? (dynamic-2a01-0c23-c184-a600-e563-f5ff-504a-6c0d.c23.pool.telefonica.de. [2a01:c23:c184:a600:e563:f5ff:504a:6c0d])
        by smtp.googlemail.com with ESMTPSA id m8-20020a056000008800b00207b3fa7fc0sm255073wrx.108.2022.04.20.09.27.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 09:27:08 -0700 (PDT)
Message-ID: <378325a3-0b2b-149f-c336-54f0e63f4134@gmail.com>
Date:   Wed, 20 Apr 2022 18:27:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
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
 <5fde764f-4caf-8017-3cbd-3918f3390b6a@gmail.com>
 <586f6f11-fb29-7f76-200a-d73a653f9889@arm.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v5 2/6] dt-bindings: auxdisplay: Add Titan Micro
 Electronics TM1628
In-Reply-To: <586f6f11-fb29-7f76-200a-d73a653f9889@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 20.04.2022 01:04, Robin Murphy wrote:
> On 2022-03-30 06:54, Heiner Kallweit wrote:
>> On 23.03.2022 21:33, Heiner Kallweit wrote:
>>> On 21.03.2022 09:34, Krzysztof Kozlowski wrote:
>>>> On 18/03/2022 21:50, Robin Murphy wrote:
>>>>> On 2022-02-25 21:13, Heiner Kallweit wrote:
>>>>>> Add a YAML schema binding for TM1628 auxdisplay
>>>>>> (7/11-segment LED) controller.
>>>>>>
>>>>>> This patch is partially based on previous work from
>>>>>> Andreas Färber <afaerber@suse.de>.
>>>>>>
>>>>>> Co-developed-by: Andreas Färber <afaerber@suse.de>
>>>>>> Signed-off-by: Andreas Färber <afaerber@suse.de>
>>>>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>>>>> ---
>>>>>> v5:
>>>>>> - add vendor prefix to driver-specific properties
>>>>>> ---
>>>>>>    .../bindings/auxdisplay/titanmec,tm1628.yaml  | 92 +++++++++++++++++++
>>>>>>    1 file changed, 92 insertions(+)
>>>>>>    create mode 100644 Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml b/Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml
>>>>>> new file mode 100644
>>>>>> index 000000000..2a1ef692c
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml
>>>>>> @@ -0,0 +1,92 @@
>>>>>> +# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
>>>>>> +%YAML 1.2
>>>>>> +---
>>>>>> +$id: http://devicetree.org/schemas/auxdisplay/titanmec,tm1628.yaml#
>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>> +
>>>>>> +title: Titan Micro Electronics TM1628 LED controller
>>>>>> +
>>>>>> +maintainers:
>>>>>> +  - Andreas Färber <afaerber@suse.de>
>>>>>> +  - Heiner Kallweit <hkallweit1@gmail.com>
>>>>>> +
>>>>>> +allOf:
>>>>>> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
>>>>>> +
>>>>>> +properties:
>>>>>> +  compatible:
>>>>>> +    const: titanmec,tm1628
>>>>>> +
>>>>>> +  reg:
>>>>>> +    maxItems: 1
>>>>>> +
>>>>>> +  titanmec,grid:
>>>>>> +    description:
>>>>>> +      Mapping of display digit position to grid number.
>>>>>> +      This implicitly defines the display size.
>>>>>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>>>>>> +    minItems: 1
>>>>>> +    maxItems: 7
>>>>>> +
>>>>>> +  titanmec,segment-mapping:
>>>>>> +    description:
>>>>>> +      Mapping of 7 segment display segments A-G to bit numbers 1-12.
>>>>>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>>>>>> +    minItems: 7
>>>>>> +    maxItems: 7
>>>>>> +
>>>>>> +  "#address-cells":
>>>>>> +    const: 2
>>>>>> +
>>>>>> +  "#size-cells":
>>>>>> +    const: 0
>>>>>> +
>>>>>> +required:
>>>>>> +  - compatible
>>>>>> +  - reg
>>>>>
>>>>> Would it be fair to say that "spi-lsb-first" and "spi-3wire" are also
>>>>> required? The chips aren't configurable so won't exactly be usable any
>>>>> other way. Furthermore I believe the transmission format actually works
>>>>> out equivalent to SPI mode 3, so should warrant "spi-cpha" and
>>>>> "spi-cpol" as well.
>>>>>
>>>>>> +
>>>>>> +patternProperties:
>>>>>> +  "^.*@[1-7],([1-9]|1[0-6])$":
>>>>>> +    type: object
>>>>>> +    $ref: /schemas/leds/common.yaml#
>>>>>> +    unevaluatedProperties: false
>>>>>> +    description: |
>>>>>> +      Properties for a single LED.
>>>>>> +
>>>>>> +    properties:
>>>>>> +      reg:
>>>>>> +        description: |
>>>>>> +          1-based grid number, followed by 1-based segment bit number.
>>>>>> +        maxItems: 1
>>>>>> +
>>>>>> +    required:
>>>>>> +      - reg
>>>>>
>>>>> I'm concerned that this leaves us no room to support the additional
>>>>> keypad functionality in future. Having now double-checked a datasheet,
>>>>> the inputs are also a two-dimensional mux (sharing the segment lines),
>>>>> so the device effectively has two distinct but numerically-overlapping
>>>>> child address spaces - one addressed by (grid,segment) and the other by
>>>>> (segment,key).
>>>>>
>>>>> Rob, Krysztof, any thoughts on the best DT idiom to leave accommodation
>>>>> for that? I'm thinking either require an intermediate node to contain
>>>>> each notional address space, or perhaps add another leading address cell
>>>>> to select between them? I don't believe any of these things have further
>>>>> functionality beyond that.
>>>>
>>>> I think intermediate nodes - leds, keys - are more appropriate, because
>>>> it is self-describing. Additional address space number would require
>>>> decoding this "0" or "1" into LED/key. For complex devices - like PMICs
>>>> with regulators, RTC and clocks - we already have such patterns.
>>>>
>>> Then it's just the question who can implement such an intermediate node
>>> based on what has been done so far.
>>>
>> As it is now it seems we end up with empty hands again and have to wait
>> further two years for the next one to make an attempt.
>> That's a pity because for most users the relevant use cases are supported.
> 
> Or, y'know, we could just reach a productive conclusion rather than doom-and-gloom catastrophising. I apologise for not having much time for non-work-related kernel hacking at the moment, but it didn't seem particularly urgent to follow up on this in the middle of a merge window anyway. In the course of helpfully being left to address my own review feedback, I did eventually get round to implementing the intermediate "leds" node[1] last weekend, but having now stumbled across the matrix-keymap helpers and common "linux,keymap" property, I'm personally inclined to think that that's even cleaner than a "keys" node with children that we'd have to write more parsing code for, and thus may well make the whole intermediate node notion moot anyway. If only anyone had pointed it out sooner...
> 
Thanks for following up on the recent discussion. Good to see that the parrot
is not dead but was just resting. My reaction was based on a number of discussions 
I witnessed that ended in nowhere. One example that comes to my mind is
LED subsystem support for network devices with hardware-triggered LEDs.

> Thanks,
> Robin.

Heiner 

> [1] https://gitlab.arm.com/linux-arm/linux-rm/-/commits/tm1628

