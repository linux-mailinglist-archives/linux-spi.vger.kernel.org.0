Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9F5507D10
	for <lists+linux-spi@lfdr.de>; Wed, 20 Apr 2022 01:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241999AbiDSXGz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 Apr 2022 19:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbiDSXGy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 19 Apr 2022 19:06:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E16D427167;
        Tue, 19 Apr 2022 16:04:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94FFC1FB;
        Tue, 19 Apr 2022 16:04:09 -0700 (PDT)
Received: from [10.57.41.251] (unknown [10.57.41.251])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5405C3F5A1;
        Tue, 19 Apr 2022 16:04:07 -0700 (PDT)
Message-ID: <586f6f11-fb29-7f76-200a-d73a653f9889@arm.com>
Date:   Wed, 20 Apr 2022 00:04:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v5 2/6] dt-bindings: auxdisplay: Add Titan Micro
 Electronics TM1628
Content-Language: en-GB
To:     Heiner Kallweit <hkallweit1@gmail.com>,
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
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <5fde764f-4caf-8017-3cbd-3918f3390b6a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2022-03-30 06:54, Heiner Kallweit wrote:
> On 23.03.2022 21:33, Heiner Kallweit wrote:
>> On 21.03.2022 09:34, Krzysztof Kozlowski wrote:
>>> On 18/03/2022 21:50, Robin Murphy wrote:
>>>> On 2022-02-25 21:13, Heiner Kallweit wrote:
>>>>> Add a YAML schema binding for TM1628 auxdisplay
>>>>> (7/11-segment LED) controller.
>>>>>
>>>>> This patch is partially based on previous work from
>>>>> Andreas Färber <afaerber@suse.de>.
>>>>>
>>>>> Co-developed-by: Andreas Färber <afaerber@suse.de>
>>>>> Signed-off-by: Andreas Färber <afaerber@suse.de>
>>>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>>>> ---
>>>>> v5:
>>>>> - add vendor prefix to driver-specific properties
>>>>> ---
>>>>>    .../bindings/auxdisplay/titanmec,tm1628.yaml  | 92 +++++++++++++++++++
>>>>>    1 file changed, 92 insertions(+)
>>>>>    create mode 100644 Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml b/Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml
>>>>> new file mode 100644
>>>>> index 000000000..2a1ef692c
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml
>>>>> @@ -0,0 +1,92 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/auxdisplay/titanmec,tm1628.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: Titan Micro Electronics TM1628 LED controller
>>>>> +
>>>>> +maintainers:
>>>>> +  - Andreas Färber <afaerber@suse.de>
>>>>> +  - Heiner Kallweit <hkallweit1@gmail.com>
>>>>> +
>>>>> +allOf:
>>>>> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    const: titanmec,tm1628
>>>>> +
>>>>> +  reg:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  titanmec,grid:
>>>>> +    description:
>>>>> +      Mapping of display digit position to grid number.
>>>>> +      This implicitly defines the display size.
>>>>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>>>>> +    minItems: 1
>>>>> +    maxItems: 7
>>>>> +
>>>>> +  titanmec,segment-mapping:
>>>>> +    description:
>>>>> +      Mapping of 7 segment display segments A-G to bit numbers 1-12.
>>>>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>>>>> +    minItems: 7
>>>>> +    maxItems: 7
>>>>> +
>>>>> +  "#address-cells":
>>>>> +    const: 2
>>>>> +
>>>>> +  "#size-cells":
>>>>> +    const: 0
>>>>> +
>>>>> +required:
>>>>> +  - compatible
>>>>> +  - reg
>>>>
>>>> Would it be fair to say that "spi-lsb-first" and "spi-3wire" are also
>>>> required? The chips aren't configurable so won't exactly be usable any
>>>> other way. Furthermore I believe the transmission format actually works
>>>> out equivalent to SPI mode 3, so should warrant "spi-cpha" and
>>>> "spi-cpol" as well.
>>>>
>>>>> +
>>>>> +patternProperties:
>>>>> +  "^.*@[1-7],([1-9]|1[0-6])$":
>>>>> +    type: object
>>>>> +    $ref: /schemas/leds/common.yaml#
>>>>> +    unevaluatedProperties: false
>>>>> +    description: |
>>>>> +      Properties for a single LED.
>>>>> +
>>>>> +    properties:
>>>>> +      reg:
>>>>> +        description: |
>>>>> +          1-based grid number, followed by 1-based segment bit number.
>>>>> +        maxItems: 1
>>>>> +
>>>>> +    required:
>>>>> +      - reg
>>>>
>>>> I'm concerned that this leaves us no room to support the additional
>>>> keypad functionality in future. Having now double-checked a datasheet,
>>>> the inputs are also a two-dimensional mux (sharing the segment lines),
>>>> so the device effectively has two distinct but numerically-overlapping
>>>> child address spaces - one addressed by (grid,segment) and the other by
>>>> (segment,key).
>>>>
>>>> Rob, Krysztof, any thoughts on the best DT idiom to leave accommodation
>>>> for that? I'm thinking either require an intermediate node to contain
>>>> each notional address space, or perhaps add another leading address cell
>>>> to select between them? I don't believe any of these things have further
>>>> functionality beyond that.
>>>
>>> I think intermediate nodes - leds, keys - are more appropriate, because
>>> it is self-describing. Additional address space number would require
>>> decoding this "0" or "1" into LED/key. For complex devices - like PMICs
>>> with regulators, RTC and clocks - we already have such patterns.
>>>
>> Then it's just the question who can implement such an intermediate node
>> based on what has been done so far.
>>
> As it is now it seems we end up with empty hands again and have to wait
> further two years for the next one to make an attempt.
> That's a pity because for most users the relevant use cases are supported.

Or, y'know, we could just reach a productive conclusion rather than 
doom-and-gloom catastrophising. I apologise for not having much time for 
non-work-related kernel hacking at the moment, but it didn't seem 
particularly urgent to follow up on this in the middle of a merge window 
anyway. In the course of helpfully being left to address my own review 
feedback, I did eventually get round to implementing the intermediate 
"leds" node[1] last weekend, but having now stumbled across the 
matrix-keymap helpers and common "linux,keymap" property, I'm personally 
inclined to think that that's even cleaner than a "keys" node with 
children that we'd have to write more parsing code for, and thus may 
well make the whole intermediate node notion moot anyway. If only anyone 
had pointed it out sooner...

Thanks,
Robin.

[1] https://gitlab.arm.com/linux-arm/linux-rm/-/commits/tm1628
