Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751194E59EE
	for <lists+linux-spi@lfdr.de>; Wed, 23 Mar 2022 21:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243931AbiCWUgK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Mar 2022 16:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344809AbiCWUft (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 23 Mar 2022 16:35:49 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C099027C;
        Wed, 23 Mar 2022 13:33:27 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id o10so5233311ejd.1;
        Wed, 23 Mar 2022 13:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8w53GL3MnLADST4E9DcwHIxh+z2VdgIPaNKFHog2SHc=;
        b=Nmp4i2IKn+57oTHm39eJaqGtLbPBR9bF0QWZqkMTvyicg/ojKJw81a5ZUfz4qe0zZM
         UClxD/I/o11G0mQN42pVYkVYiIIfHQM8DSC89JyBjzPOJ9KvQLXmc3LqMVLFrFejUb/X
         8tuc2GAHel4ujRN3JaalPC9uv97sx2Y747CxEeQgkin9AFtEwERAopiSIQG20/jpEKz2
         kWLuw7m5n2V8lk+EfO+1hwryPsSJd/ZThiFcxFVb/oI8AdNWffI6SmItzjmBWvmICxYG
         s1KMm9Luf6OdmEQO6VF8JFnhJI2//Hc9nT6litKo5atkZHGWSKD+FNsZD/eE1lyHWQCs
         ndZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8w53GL3MnLADST4E9DcwHIxh+z2VdgIPaNKFHog2SHc=;
        b=riPHKVl3S2SjO10++jP0ES80E9dMEriWnVbdO3bRbNoJm2yhsSKjkEn0JhcyDC2HlP
         x1ST98AxbIdcOoXGvEb+a6oSeJXgwkSgY+4wkoEEW9J0pvf/rZVhyo3q2Ki+m1gx4bAU
         RCazZatrJPuiVn8TyiAB+Z94rj3IEze/k3k5q9pslH+Ni0IG3brULc/w/Iz13Lde/1AN
         Ygi7PwxH1a73x9yaokGrkvuZbDYImP8UhiYc3RrIu0UhFC6VG7K39J7mQo/7ZxdCXZjw
         WSDruqo2SEWX6r9cIHLFzpXuqoFf7Z9REyg4LsmvxAN7BmKF+F2bqErNT/pvUw9yKW8O
         cNZg==
X-Gm-Message-State: AOAM531U2vM1b1qcti++iejJSe5A5i+E2GbjC7w1jeZ7h0bjdJcDvUdG
        GkbqEMMI35jVtCbU5N5Ix0Y=
X-Google-Smtp-Source: ABdhPJy35M7x98Gg8G1hQ6cDhzEMbFWY8nuotieRdsHkGjwSKkzFwncXI0Jp56IPyp3CyPe6EKkFKQ==
X-Received: by 2002:a17:907:6296:b0:6da:745b:7b40 with SMTP id nd22-20020a170907629600b006da745b7b40mr2076068ejc.750.1648067605870;
        Wed, 23 Mar 2022 13:33:25 -0700 (PDT)
Received: from ?IPV6:2a01:c22:73b2:3800:a873:f3b8:ab68:ccbd? (dynamic-2a01-0c22-73b2-3800-a873-f3b8-ab68-ccbd.c22.pool.telefonica.de. [2a01:c22:73b2:3800:a873:f3b8:ab68:ccbd])
        by smtp.googlemail.com with ESMTPSA id z6-20020a056402274600b004194fc1b7casm427134edd.48.2022.03.23.13.33.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 13:33:25 -0700 (PDT)
Message-ID: <80937566-6455-b1bf-0a5d-a7b54dd3adc5@gmail.com>
Date:   Wed, 23 Mar 2022 21:33:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 2/6] dt-bindings: auxdisplay: Add Titan Micro
 Electronics TM1628
Content-Language: en-US
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
From:   Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <9e2fc38a-a51e-7635-970c-64948fc6eae4@kernel.org>
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

On 21.03.2022 09:34, Krzysztof Kozlowski wrote:
> On 18/03/2022 21:50, Robin Murphy wrote:
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
>>> ---
>>> v5:
>>> - add vendor prefix to driver-specific properties
>>> ---
>>>   .../bindings/auxdisplay/titanmec,tm1628.yaml  | 92 +++++++++++++++++++
>>>   1 file changed, 92 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml b/Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml
>>> new file mode 100644
>>> index 000000000..2a1ef692c
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml
>>> @@ -0,0 +1,92 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/auxdisplay/titanmec,tm1628.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Titan Micro Electronics TM1628 LED controller
>>> +
>>> +maintainers:
>>> +  - Andreas Färber <afaerber@suse.de>
>>> +  - Heiner Kallweit <hkallweit1@gmail.com>
>>> +
>>> +allOf:
>>> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: titanmec,tm1628
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  titanmec,grid:
>>> +    description:
>>> +      Mapping of display digit position to grid number.
>>> +      This implicitly defines the display size.
>>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>>> +    minItems: 1
>>> +    maxItems: 7
>>> +
>>> +  titanmec,segment-mapping:
>>> +    description:
>>> +      Mapping of 7 segment display segments A-G to bit numbers 1-12.
>>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>>> +    minItems: 7
>>> +    maxItems: 7
>>> +
>>> +  "#address-cells":
>>> +    const: 2
>>> +
>>> +  "#size-cells":
>>> +    const: 0
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>
>> Would it be fair to say that "spi-lsb-first" and "spi-3wire" are also 
>> required? The chips aren't configurable so won't exactly be usable any 
>> other way. Furthermore I believe the transmission format actually works 
>> out equivalent to SPI mode 3, so should warrant "spi-cpha" and 
>> "spi-cpol" as well.
>>
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
>>
>> Rob, Krysztof, any thoughts on the best DT idiom to leave accommodation 
>> for that? I'm thinking either require an intermediate node to contain 
>> each notional address space, or perhaps add another leading address cell 
>> to select between them? I don't believe any of these things have further 
>> functionality beyond that.
> 
> I think intermediate nodes - leds, keys - are more appropriate, because
> it is self-describing. Additional address space number would require
> decoding this "0" or "1" into LED/key. For complex devices - like PMICs
> with regulators, RTC and clocks - we already have such patterns.
> 
Then it's just the question who can implement such an intermediate node
based on what has been done so far.

> Best regards,
> Best regards,
> Krzysztof

