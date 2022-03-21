Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B9D4E224B
	for <lists+linux-spi@lfdr.de>; Mon, 21 Mar 2022 09:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345319AbiCUIgE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Mar 2022 04:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345321AbiCUIgC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Mar 2022 04:36:02 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F27C55486;
        Mon, 21 Mar 2022 01:34:37 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id yy13so28314524ejb.2;
        Mon, 21 Mar 2022 01:34:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WKB7432viqtAA43yhCKLQso3FafKoMqrO0twMiULF00=;
        b=3+3HJpWxmdh6iERr7ky5kXY6WvfH8EG2AWpGuqT/Q+Y/XrIVY+C7WKTsUNhaZFi5XW
         VS1ioDauTIH6dlykCLF7CN5wkA4Cr9QnRPmgQP9DTlrYnPg2JbDMu0b/8PdW4GTTDitW
         l2ul2wt8uxehNpO0Onmh6bRKZuhPM/56gv1J9cPi9mVUTT2XIpQyWoiTr4OLfwI8eUOU
         8VbxTs3e/6BbQvupair7E/RQWdIz2ZPJswcsXABrH5P1uVLbphLfTRBFaavo7020D6SW
         py81MSIZq5ATp2Co0x0yZ31CVfal7Iff68V7/2c1ge1DhnSziEKfzHTzLpTBWNtFRZhY
         zcug==
X-Gm-Message-State: AOAM532RQceo5xbURYwDO2xZl9RE9iQxZYhtcYPg+gfjY5/gJPTSzw3g
        XZv6Xckhj+MGNlBmnGivgxU=
X-Google-Smtp-Source: ABdhPJy5vP3fVx572rAjjMQUjnDlowieOOjQSE5TgMjj/0D5UCRS0lP0lT8J0nUQdAZGDMKyrNAqgA==
X-Received: by 2002:a17:907:3e94:b0:6d1:d64e:3141 with SMTP id hs20-20020a1709073e9400b006d1d64e3141mr19018004ejc.213.1647851675791;
        Mon, 21 Mar 2022 01:34:35 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id 20-20020a17090601d400b006caff964e30sm6772407ejj.19.2022.03.21.01.34.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 01:34:34 -0700 (PDT)
Message-ID: <9e2fc38a-a51e-7635-970c-64948fc6eae4@kernel.org>
Date:   Mon, 21 Mar 2022 09:34:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 2/6] dt-bindings: auxdisplay: Add Titan Micro
 Electronics TM1628
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
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
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <3bf14cf0-f00d-f718-30ea-e63272f3ce72@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 18/03/2022 21:50, Robin Murphy wrote:
> On 2022-02-25 21:13, Heiner Kallweit wrote:
>> Add a YAML schema binding for TM1628 auxdisplay
>> (7/11-segment LED) controller.
>>
>> This patch is partially based on previous work from
>> Andreas Färber <afaerber@suse.de>.
>>
>> Co-developed-by: Andreas Färber <afaerber@suse.de>
>> Signed-off-by: Andreas Färber <afaerber@suse.de>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>> v5:
>> - add vendor prefix to driver-specific properties
>> ---
>>   .../bindings/auxdisplay/titanmec,tm1628.yaml  | 92 +++++++++++++++++++
>>   1 file changed, 92 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml b/Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml
>> new file mode 100644
>> index 000000000..2a1ef692c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml
>> @@ -0,0 +1,92 @@
>> +# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/auxdisplay/titanmec,tm1628.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Titan Micro Electronics TM1628 LED controller
>> +
>> +maintainers:
>> +  - Andreas Färber <afaerber@suse.de>
>> +  - Heiner Kallweit <hkallweit1@gmail.com>
>> +
>> +allOf:
>> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: titanmec,tm1628
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  titanmec,grid:
>> +    description:
>> +      Mapping of display digit position to grid number.
>> +      This implicitly defines the display size.
>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>> +    minItems: 1
>> +    maxItems: 7
>> +
>> +  titanmec,segment-mapping:
>> +    description:
>> +      Mapping of 7 segment display segments A-G to bit numbers 1-12.
>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>> +    minItems: 7
>> +    maxItems: 7
>> +
>> +  "#address-cells":
>> +    const: 2
>> +
>> +  "#size-cells":
>> +    const: 0
>> +
>> +required:
>> +  - compatible
>> +  - reg
> 
> Would it be fair to say that "spi-lsb-first" and "spi-3wire" are also 
> required? The chips aren't configurable so won't exactly be usable any 
> other way. Furthermore I believe the transmission format actually works 
> out equivalent to SPI mode 3, so should warrant "spi-cpha" and 
> "spi-cpol" as well.
> 
>> +
>> +patternProperties:
>> +  "^.*@[1-7],([1-9]|1[0-6])$":
>> +    type: object
>> +    $ref: /schemas/leds/common.yaml#
>> +    unevaluatedProperties: false
>> +    description: |
>> +      Properties for a single LED.
>> +
>> +    properties:
>> +      reg:
>> +        description: |
>> +          1-based grid number, followed by 1-based segment bit number.
>> +        maxItems: 1
>> +
>> +    required:
>> +      - reg
> 
> I'm concerned that this leaves us no room to support the additional 
> keypad functionality in future. Having now double-checked a datasheet, 
> the inputs are also a two-dimensional mux (sharing the segment lines), 
> so the device effectively has two distinct but numerically-overlapping 
> child address spaces - one addressed by (grid,segment) and the other by 
> (segment,key).
> 
> Rob, Krysztof, any thoughts on the best DT idiom to leave accommodation 
> for that? I'm thinking either require an intermediate node to contain 
> each notional address space, or perhaps add another leading address cell 
> to select between them? I don't believe any of these things have further 
> functionality beyond that.

I think intermediate nodes - leds, keys - are more appropriate, because
it is self-describing. Additional address space number would require
decoding this "0" or "1" into LED/key. For complex devices - like PMICs
with regulators, RTC and clocks - we already have such patterns.

Best regards,
Best regards,
Krzysztof
