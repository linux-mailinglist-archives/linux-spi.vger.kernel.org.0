Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2DA507C8D
	for <lists+linux-spi@lfdr.de>; Wed, 20 Apr 2022 00:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244692AbiDSWep (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 Apr 2022 18:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239995AbiDSWen (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 19 Apr 2022 18:34:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 15D4228986;
        Tue, 19 Apr 2022 15:31:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B68D21477;
        Tue, 19 Apr 2022 15:31:58 -0700 (PDT)
Received: from [10.57.41.251] (unknown [10.57.41.251])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DAB03F5A1;
        Tue, 19 Apr 2022 15:31:56 -0700 (PDT)
Message-ID: <543820f8-5e93-eedb-e409-0cb13d092f07@arm.com>
Date:   Tue, 19 Apr 2022 23:31:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v5 2/6] dt-bindings: auxdisplay: Add Titan Micro
 Electronics TM1628
Content-Language: en-GB
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Miguel Ojeda <ojeda@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
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
 <CAMuHMdV8iy4vMASuUgeQmjHdAMNzvCikwheyQO1-AQH0yYk0RQ@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAMuHMdV8iy4vMASuUgeQmjHdAMNzvCikwheyQO1-AQH0yYk0RQ@mail.gmail.com>
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

On 2022-03-21 08:12, Geert Uytterhoeven wrote:
> Hi Robin,
> 
> On Fri, Mar 18, 2022 at 9:50 PM Robin Murphy <robin.murphy@arm.com> wrote:
>> On 2022-02-25 21:13, Heiner Kallweit wrote:
>>> Add a YAML schema binding for TM1628 auxdisplay
>>> (7/11-segment LED) controller.
>>>
>>> This patch is partially based on previous work from
>>> Andreas Färber <afaerber@suse.de>.
>>>
>>> Co-developed-by: Andreas Färber <afaerber@suse.de>
>>> Signed-off-by: Andreas Färber <afaerber@suse.de>
>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml
> 
>>> +
>>> +patternProperties:
>>> +  "^.*@[1-7],([1-9]|1[0-6])$":
>>> +    type: object
>>> +    $ref: /schemas/leds/common.yaml#
>>> +    unevaluatedProperties: false
>>> +    description: |
>>> +      Properties for a single LED.
>>> +
>>> +    properties:
>>> +      reg:
>>> +        description: |
>>> +          1-based grid number, followed by 1-based segment bit number.
>>> +        maxItems: 1
>>> +
>>> +    required:
>>> +      - reg
>>
>> I'm concerned that this leaves us no room to support the additional
>> keypad functionality in future. Having now double-checked a datasheet,
>> the inputs are also a two-dimensional mux (sharing the segment lines),
>> so the device effectively has two distinct but numerically-overlapping
>> child address spaces - one addressed by (grid,segment) and the other by
>> (segment,key).
> 
> Sounds similar to HT16K33?

/me searches up a datasheet...

Keypad-wise, it appears so, however the display side of this 
1618/1628/1638 family is very much tuned for 7-segment displays rather 
than arbitrary dot-matrix ones.

I do recall when I was digging a few years ago, turning up an old Holtek 
VFD driver which looked suspiciously like it might be the origin of the 
particular 3-wire protocol and command set (including weird non-linear 
brightness scale) which all these LED driver clones seem to borrow from, 
but I can't now remember the part number :(

>> Rob, Krysztof, any thoughts on the best DT idiom to leave accommodation
>> for that? I'm thinking either require an intermediate node to contain
>> each notional address space, or perhaps add another leading address cell
>> to select between them? I don't believe any of these things have further
>> functionality beyond that.
> 
> The problem with these devices is that there are thousands of different
> ways to wire them, and coming up with a generic wiring description in
> DT and writing code to handle that can be very hard.
> 
> For HT16K33 non-dot-matrix wirings, I just added extra compatible
> values matching the wiring of a few known devices[1].  That way the
> driver can handle them efficiently.
> It does have the disadvantage that adding support for new devices
> means introducing more compatible values, and adding more code.
> 
> Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml

I think the display side of Heiner's binding is fine for what these 
chips can do - I've finally had a bit more time to play with this 
series, and (with minor driver hacks) it works just fine to describe my 
TM1638 breakout board with an 8-digit display, where segments 8 and 9 of 
each grid are respectively a decimal point and a discrete indicator LED, 
managed as separate LED nodes.

However, I think you've indirectly addressed my outstanding concern 
there - I wasn't aware of the "linux,keymap" property, but since that 
brings its own implicit (row,column) addresses distinct from the DT 
address space, it looks like that might be sufficient as a neat standard 
way to extend this binding in future *without* any other changes.

Thanks,
Robin.
