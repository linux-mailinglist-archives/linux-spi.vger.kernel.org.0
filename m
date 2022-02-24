Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A29B4C3864
	for <lists+linux-spi@lfdr.de>; Thu, 24 Feb 2022 23:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbiBXWIF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Feb 2022 17:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235206AbiBXWID (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Feb 2022 17:08:03 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0331B3A75;
        Thu, 24 Feb 2022 14:07:32 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id bq11so4849784edb.2;
        Thu, 24 Feb 2022 14:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Um1yRfMDWXUuFfQXYDQ7mGRJt1MWUpTswbY6Fanwzx4=;
        b=J3Y6HcyfV2w4WTEu/48kbdR/GH8u5Nn+CiUCxsIucbIjTgPIMRWbSehfPmC7K+QUCt
         ZoFF/pg615+tM7r/uuVu+aCQFESZtjOwo3hCqqhpO41gfo4i9MdkvFSryU63zpPZHfDj
         Fhm11iiVl2u+rm9wEHZpKp1m0usji4+hPKixgQcOj5GKaAeDB3WTAz8FOypvdlFK8tOu
         5Mjmq9tPLfRZRW1ixdGGjFzh++E123s6IepiqhVn/RxupWdk/+jHmnzOjljdIglYmhfE
         5PrA4xTTONVcBv4MKEIs7OXr1X6LROB6mtrxlvQo9F3Nm8mj54N4AFRZwa4qgi8fATwO
         /4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Um1yRfMDWXUuFfQXYDQ7mGRJt1MWUpTswbY6Fanwzx4=;
        b=0jeT3+lKrhkeA/QiM3CxlwHNCwZNzkmhmY5NZV2qXU8KduXSdL9Xxp2L65GRSrqOqE
         7xUL0U9CBgwNnNunwmOTdZXX2/YOFuIOOcdsUdn8DXSejR0evJwTOYfGikUxyMlqqdhT
         eEz7FwuT+SEnjj1b+9Jl/FCigiJ2EBYJJVrEe+9Kuci3syNJhardpvOcfzkrezB4Wdvb
         SMD6tchetlPm2uWqsOYhb8jGdd/Gw9MIS7+nvx16NWLjTeqbWVweuX1HKZr7UrjYiN1+
         Ps3cK//RMgraE2eI6YXL+QowjCzc69qxkbTKbaHB3CZTTpmxbSA4+JHopxn+sZJtxRFw
         N9zg==
X-Gm-Message-State: AOAM5320XEdYl5/+IJoVZG2dhHERaYu46ZBjlphHSdTqx+t9eTqIgM0/
        pqm90wN/8nbBZNCRj7GKLvfe39inxtU=
X-Google-Smtp-Source: ABdhPJz1LPKIUx1LCybG9WCyGLvIak/xf78F7LgkyGZ0/KcFOpP/HB3xWDJuFSUl1yvkESDm0u/sOQ==
X-Received: by 2002:aa7:c983:0:b0:410:d314:6451 with SMTP id c3-20020aa7c983000000b00410d3146451mr4215887edt.56.1645740450708;
        Thu, 24 Feb 2022 14:07:30 -0800 (PST)
Received: from ?IPV6:2003:ea:8f4d:2b00:70ad:e6bd:1cea:7edd? (p200300ea8f4d2b0070ade6bd1cea7edd.dip0.t-ipconnect.de. [2003:ea:8f4d:2b00:70ad:e6bd:1cea:7edd])
        by smtp.googlemail.com with ESMTPSA id ey10-20020a1709070b8a00b006d1cb2eb221sm219172ejc.170.2022.02.24.14.07.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 14:07:30 -0800 (PST)
Message-ID: <c7a32a58-a38a-8c77-4124-5954899ef373@gmail.com>
Date:   Thu, 24 Feb 2022 23:07:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 2/5] dt-bindings: auxdisplay: Add Titan Micro
 Electronics TM1628
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
 <29fcdfe3-1b8e-f466-6e20-919c6ab2a7ae@gmail.com>
 <CAL_JsqL-yFJkq9Uj9XAzfcN=yD9AGUQEGk7f-h81P7MNj7p==A@mail.gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <CAL_JsqL-yFJkq9Uj9XAzfcN=yD9AGUQEGk7f-h81P7MNj7p==A@mail.gmail.com>
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

On 24.02.2022 22:30, Rob Herring wrote:
> On Thu, Feb 24, 2022 at 2:56 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> On 24.02.2022 21:22, Rob Herring wrote:
>>> On Wed, Feb 23, 2022 at 06:59:31PM +0100, Heiner Kallweit wrote:
>>>> Add a YAML schema binding for TM1628 auxdisplay
>>>> (7/11-segment LED) controller.
>>>>
>>>> This patch is partially based on previous work from
>>>> Andreas Färber <afaerber@suse.de>.
>>>>
>>>> Co-Developed-by: Andreas Färber <afaerber@suse.de>
>>>> Signed-off-by: Andreas Färber <afaerber@suse.de>
>>>> Co-Developed-by: Heiner Kallweit <hkallweit1@gmail.com>
>>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>>> ---
>>>> v3:
>>>> - fix remaining YAML issues
>>>> - use Co-Developed-by
>>>> ---
>>>>  .../bindings/auxdisplay/titanmec,tm1628.yaml  | 92 +++++++++++++++++++
>>>>  1 file changed, 92 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml
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
>>>
>>>> +  grid:
>>>> +    description:
>>>> +      Mapping of display digit position to grid number.
>>>> +      This implicitly defines the display size.
>>>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>>>> +    minItems: 1
>>>> +    maxItems: 7
>>>> +
>>>> +  segment-mapping:
>>>> +    description:
>>>> +      Mapping of 7 segment display segments A-G to bit numbers 1-12.
>>>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>>>> +    minItems: 7
>>>> +    maxItems: 7
>>>
>>> Are these properties useful for any 7 segment display or specific to
>>> this controller?
>>>
>> Both are controller-specific. E.g. the functionally similar driver
>> ht16k33 uses different properties.
> 
> Then they both need a vendor prefix.
> 
OK, will add the prefix. Thanks for the hint.

>>> The commit msg mentions 11 segment display. Does this need to be?:
>>>
>>> oneOf:
>>>   - minItems: 7
>>>     maxItems: 7
>>>   - minItems: 11
>>>     maxItems: 11
>>>
>> The controller would be able to drive 11 segments, but the driver
>> supports 7 segments only (at least for now). Therefore a 11 segment
>> display can be used, but only the 7 segment part will be active.
>> All devices with this controller I've seen and heard of have
>> 7 segment displays.
> 
> Bindings should be complete, not just what a particular version of a
> driver supports. However, if all known h/w is just 7 seg, then it is
> fine.
> 
> Rob

