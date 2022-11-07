Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9625561EC96
	for <lists+linux-spi@lfdr.de>; Mon,  7 Nov 2022 09:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbiKGIJV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Nov 2022 03:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiKGIJU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Nov 2022 03:09:20 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766DD13F2A
        for <linux-spi@vger.kernel.org>; Mon,  7 Nov 2022 00:09:19 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id k19so15005959lji.2
        for <linux-spi@vger.kernel.org>; Mon, 07 Nov 2022 00:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I/1C2eJ0mQS9HScu7or8tU8miNli5M+Crwcb5WX+lzs=;
        b=vPtIjrGwdX18Hu7NEl5SK8N6LLWQ673WfxlhcQWAqu4lCg5QD+vCxVNVPzlkFNt6pv
         FEWoPfVYA5Mh3+C5w8e4YH9E5471fXSWCTW5siWNZIp/1POWa9l+ow9kXdV89VoLAoN5
         i920jkmHQfUYLrZRX8KXpbCs9AMO7cv+JGZlQpuh0JK+lgAqPCZlZaVdkc4KczZ0j0c+
         2bOPOhjJA3JQS83k9HsmfzLUN0mDS8BBXpl7I6mr4DpCPQA0+ahEiMvYxTi5FHrS41Ab
         EOCFJUcECyyj+naL37gVb8tlbyFpZij1Py0235de2Ft8lfWxkGhLFZE76p8oXNK/Krlv
         tR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I/1C2eJ0mQS9HScu7or8tU8miNli5M+Crwcb5WX+lzs=;
        b=wR8UqWDJ2xhtA3cbkWbp0ZOeXmkbFdlVh+oFpuzHRvZU9Qu6kWBu/c/oKjk5X28gxr
         HxYG3PPyLRkXUDrFbdC4joKFVJdYbjksN+tmFd439vG2Qy/0hbCsD7x0ycu8QnChX1FQ
         o72UYG5g8qcmuSN/csboMOQNy4lpiJNA3PHc6o9w9iEd89uq0+6ZZTFpvHgHBOOFcz7X
         OORVVXZStg78qKR1qqzmdfEYjY0Jqc3rmcqUv8SzqWNcbdKKjjfXWIvFq8Yj0vkKJ7wg
         Rlzu2kM7kzmVpbalUhBEahYxxRTU+a6x5a6LgHFlQkAV1/TTGiP8Ta8VJvpGOS2cxWs3
         FB1A==
X-Gm-Message-State: ACrzQf3loBoODeLc65FjsURVYls4zBKM9dAR5mGdYvt+Kv4IgpRB6tIW
        pDeRkowxkgGjVTaGKuC57ar1WQ==
X-Google-Smtp-Source: AMsMyM4X9owA9AnNEuYVbK1IhD5sMvkwhQN4JUedQjJGTT1YOIZXpChyG96lkTdqFVER6gdVauAd/A==
X-Received: by 2002:a2e:b6c6:0:b0:277:a45:5a38 with SMTP id m6-20020a2eb6c6000000b002770a455a38mr5404022ljo.377.1667808557798;
        Mon, 07 Nov 2022 00:09:17 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id j29-20020a056512029d00b004a03fd4476esm1103200lfp.287.2022.11.07.00.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 00:09:16 -0800 (PST)
Message-ID: <2400e167-073e-65fa-7fe6-b64a34bce256@linaro.org>
Date:   Mon, 7 Nov 2022 09:09:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/8] dt-bindings: spi: Add Nuvoton WPCM450 Flash Interface
 Unit (FIU)
Content-Language: en-US
To:     =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-spi@vger.kernel.org, openbmc@lists.ozlabs.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <20221105185911.1547847-1-j.neuschaefer@gmx.net>
 <20221105185911.1547847-4-j.neuschaefer@gmx.net>
 <066919b1-c43d-f8ed-0191-cce8c575ee37@linaro.org> <Y2fIjSKAGleEtjHe@probook>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y2fIjSKAGleEtjHe@probook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 06/11/2022 15:45, Jonathan Neuschäfer wrote:
> On Sun, Nov 06, 2022 at 10:38:45AM +0100, Krzysztof Kozlowski wrote:
>> On 05/11/2022 19:59, Jonathan Neuschäfer wrote:
>>> The Flash Interface Unit (FIU) is the SPI flash controller in the
>>> Nuvoton WPCM450 BMC SoC. It supports four chip selects, and direct
>>> (memory-mapped) access to 16 MiB per chip. Larger flash chips can be
>>> accessed by software-defined SPI transfers.
>>>
>>> The FIU in newer NPCM7xx SoCs is not compatible with the WPCM450 FIU.
>>>
>>> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
>>> ---
> [...]
>>> +allOf:
>>> +  - $ref: "/schemas/spi/spi-controller.yaml#"
>>
>> Drop the quotes.
> 
> Will do.
> 
> 
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: nuvoton,wpcm450-fiu
>>> +
>>> +  reg:
>>> +    items:
>>> +      - description: FIU registers
>>> +      - description: Memory-mapped flash contents
>>> +
>>> +  reg-names:
>>> +    items:
>>> +      - const: control
>>> +      - const: memory
>>> +    minItems: 1
>>
>> This does not match your 'reg'. Two items are required there.
> 
> My intention was rather to make the second reg item actually optional,
> i.e. add minItems: 1 for reg as well.  (But, further discussion below.)
> 
> 
>>> +    spi@c8000000 {
>>> +      compatible = "nuvoton,wpcm450-fiu";
>>> +      #address-cells = <1>;
>>> +      #size-cells = <0>;
>>> +      reg = <0xc8000000 0x1000>, <0xc0000000 0x4000000>;
>>
>> reg is the second property.
> 
> Ok, I'll move it up.
> 
>>
>>> +      reg-names = "control", "memory";
>>> +      clocks = <&clk WPCM450_CLK_FIU>;
>>> +      nuvoton,shm = <&shm>;
>>> +
>>> +      flash@0 {
>>> +        compatible = "jedec,spi-nor";
>>> +      };
>>> +    };
>>> +
>>> +    shm: syscon@c8001000 {
>>> +      compatible = "nuvoton,wpcm450-shm", "syscon";
>>> +      reg = <0xc8001000 0x1000>;
>>> +    };
>>> +
>>> +  - |
>>> +    #include <dt-bindings/clock/nuvoton,wpcm450-clk.h>
>>> +    spi@c8000000 {
>>> +      compatible = "nuvoton,wpcm450-fiu";
>>> +      // the "memory" resource may be omitted
>>
>> This is rather obvious, so what you should comment is WHY or WHEN second
>> resource can be omitted.
> 
> Ok, I'll add more reasoning, which is basically: The "memory" mapping is
> only an optimization for faster access, knowledge of it is not necessary
> for full operation of the device.
> 
>> Not every instance on the hardware has it?
> 
> AFAIK every instance has it, and there's unlikely to be any variation on
> this fact anymore, because newer Nuvoton SoCs replaced the FIU with a
> redesigned and incompatible version.
> 
> I admit that the value of making the "memory" mapping optional is rather
> theoretical, and I'm open to making this reg item mandatory to simplify
> the binding.

If every instance has it, then regardless whether it is actually used or
not, just require second address?

Best regards,
Krzysztof

