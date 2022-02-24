Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6A74C3740
	for <lists+linux-spi@lfdr.de>; Thu, 24 Feb 2022 21:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbiBXU4c (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Feb 2022 15:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbiBXU4b (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Feb 2022 15:56:31 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250AE1D0360;
        Thu, 24 Feb 2022 12:56:01 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id z22so4645469edd.1;
        Thu, 24 Feb 2022 12:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=K1S+dkGXla6DPwP9+HUMJY7KzgDw3fLye//5M521t5Y=;
        b=iT+vDVItk7xh9Vt/m+bemAMLNeNxiQxvamy17piq4IiAKAYGY0C/CBfYpSIUbilLZC
         VEkhHXspz+obbGO9E+YeoU15zgAnhKfjjahCdM09HNtf6RHCehOWIVON8rPpA8U6Ez0w
         P4OOND3dnwIEW1PxAY0IqRcST42FDQzaNCN5mVoNvZJ3A6rlSJ740JGYm5Nq4mK+UW7r
         aNjWQFgJr1rFAEj2UWpgBuBsx8hDEOYlhTzYylCNk6yZTHtoz4OTi/y2jrcSrRqN6go4
         1b11T30RZKpDd0MG0Ix+3hSGznq8QSWsgnMQdZUtc6FDw2BheWCBV2hQ+/wOATIAM96a
         /2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=K1S+dkGXla6DPwP9+HUMJY7KzgDw3fLye//5M521t5Y=;
        b=AjlrCeeCCm2NFLdFnW55MrNlzgTTk7sDhEmbQzhsxVHyPLQITTE8PbZEyViZny/ILi
         7x8rkY93M/V2jQBf1xfCZ5Wq0vCj+D0q3jxfWBqu+RSpDbbdcB3YBIQ0jBMcP0ldP3CT
         FZbPWkYUYl00Azm04DZjZg7P64KnM4zZJbtNa1ePIyhM/PM1gZipiqJXSxAEAbNSOmnK
         4+u/DdUriaoAdyzP5Cz4L7KEryvg02uwTgHJ+NU6a3JjfRmnlw2mShdQf3UJ9/qQoGty
         1bF5ITLzR60TvDEwBXV83wPncjrZYm7TyVTtfE43Bjt+DgCGXxcspeu+4Ech892tcKUD
         9P3Q==
X-Gm-Message-State: AOAM5330vH3d2CFL3cwSLImfuAYbwdEnUEo28RT8UPEwUB/LPuXNWFoo
        1teRjXwkYwsO+wmrf85MKtE=
X-Google-Smtp-Source: ABdhPJyrnO/rfnaKxFhFPI5qjYojw1jBjGlfYgPUDqUpas/l5AM5e4QdIGXdZc27ocNn3rIKBUkunQ==
X-Received: by 2002:aa7:cad3:0:b0:410:b188:a49a with SMTP id l19-20020aa7cad3000000b00410b188a49amr4078432edt.416.1645736159628;
        Thu, 24 Feb 2022 12:55:59 -0800 (PST)
Received: from ?IPV6:2003:ea:8f4d:2b00:70ad:e6bd:1cea:7edd? (p200300ea8f4d2b0070ade6bd1cea7edd.dip0.t-ipconnect.de. [2003:ea:8f4d:2b00:70ad:e6bd:1cea:7edd])
        by smtp.googlemail.com with ESMTPSA id g2-20020aa7c842000000b0041314b98872sm298873edt.22.2022.02.24.12.55.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 12:55:59 -0800 (PST)
Message-ID: <29fcdfe3-1b8e-f466-6e20-919c6ab2a7ae@gmail.com>
Date:   Thu, 24 Feb 2022 21:55:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
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
References: <4eb7b036-a9b9-3bd2-4e84-f56ba4b1a740@gmail.com>
 <2b7f0011-8872-70fa-b9b7-50b7817e7084@gmail.com>
 <YhfpD9qfcuAlC+wp@robh.at.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v3 2/5] dt-bindings: auxdisplay: Add Titan Micro
 Electronics TM1628
In-Reply-To: <YhfpD9qfcuAlC+wp@robh.at.kernel.org>
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

On 24.02.2022 21:22, Rob Herring wrote:
> On Wed, Feb 23, 2022 at 06:59:31PM +0100, Heiner Kallweit wrote:
>> Add a YAML schema binding for TM1628 auxdisplay
>> (7/11-segment LED) controller.
>>
>> This patch is partially based on previous work from
>> Andreas Färber <afaerber@suse.de>.
>>
>> Co-Developed-by: Andreas Färber <afaerber@suse.de>
>> Signed-off-by: Andreas Färber <afaerber@suse.de>
>> Co-Developed-by: Heiner Kallweit <hkallweit1@gmail.com>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>> v3:
>> - fix remaining YAML issues
>> - use Co-Developed-by
>> ---
>>  .../bindings/auxdisplay/titanmec,tm1628.yaml  | 92 +++++++++++++++++++
>>  1 file changed, 92 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml
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
> 
>> +  grid:
>> +    description:
>> +      Mapping of display digit position to grid number.
>> +      This implicitly defines the display size.
>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>> +    minItems: 1
>> +    maxItems: 7
>> +
>> +  segment-mapping:
>> +    description:
>> +      Mapping of 7 segment display segments A-G to bit numbers 1-12.
>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>> +    minItems: 7
>> +    maxItems: 7
> 
> Are these properties useful for any 7 segment display or specific to 
> this controller?
> 
Both are controller-specific. E.g. the functionally similar driver
ht16k33 uses different properties.

> The commit msg mentions 11 segment display. Does this need to be?:
> 
> oneOf:
>   - minItems: 7
>     maxItems: 7
>   - minItems: 11
>     maxItems: 11
> 
The controller would be able to drive 11 segments, but the driver
supports 7 segments only (at least for now). Therefore a 11 segment
display can be used, but only the 7 segment part will be active.
All devices with this controller I've seen and heard of have
7 segment displays.

> 
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
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/leds/common.h>
>> +
>> +    spi {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        led-controller@0 {
>> +            compatible = "titanmec,tm1628";
>> +            reg = <0>;
>> +            spi-3-wire;
>> +            spi-lsb-first;
>> +            spi-max-frequency = <500000>;
>> +            grid = /bits/ 8 <4 3 2 1>;
>> +            segment-mapping = /bits/ 8 <4 5 6 1 2 3 7>;
>> +            #address-cells = <2>;
>> +            #size-cells = <0>;
>> +
>> +            alarmn@5,4 {
>> +                reg = <5 4>;
>> +                function = LED_FUNCTION_ALARM;
>> +            };
>> +        };
>> +    };
>> +...
>> -- 
>> 2.35.1
>>
>>
>>

