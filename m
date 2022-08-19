Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36C2599833
	for <lists+linux-spi@lfdr.de>; Fri, 19 Aug 2022 11:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348019AbiHSJFn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 19 Aug 2022 05:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347991AbiHSJFg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 19 Aug 2022 05:05:36 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757FEF23E6
        for <linux-spi@vger.kernel.org>; Fri, 19 Aug 2022 02:05:34 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id a9so5293256lfm.12
        for <linux-spi@vger.kernel.org>; Fri, 19 Aug 2022 02:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Lv2fWdRF99e7CpwgYLWA5Mtojc32Wbh8AA81DkMthw4=;
        b=OSGiqt9yFp/YqXKBx4gm2F8C5JxtKpDRqyj2mKp7sWIlRwe+Fh+hasNwc2qRl47Ppw
         I0GTNSWETzMrFZXfvSCKi1k7ttl2x1/FWvPrs9VFF3u/xg315gfvjd/F9cJD87Gf0oKB
         rxgEjSMEqcjJVSCcgdApLk2/LNjbnpM4Kfe7rrX5rKBWTHdqsxxnq0ZTHVxbZrQG7Uj9
         nfTf1I2n/ZqUJGTygLPCTFUNTYVj8sQ/5abcrw1zkK7h0TfvD3lLulpQuZUQET/vl5ix
         Ve2DVwY0zoVo1krsxTiSN73f0SID8KNQRh6jdUDmLbhoQ+vT6JaFFDHUM8/jBfke43WQ
         6L5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Lv2fWdRF99e7CpwgYLWA5Mtojc32Wbh8AA81DkMthw4=;
        b=RYdCciduEkklXaO29RmG8FE9Tu6RUO2aILJaz105kLsPBHoM0gmbKRVcAWlW7ZpaDs
         g2mR5ZlYi0InGZEuy1wzoBn/blxx1pJTxlzM0cEmSXaz/neFrynxKXYDxHYQZblp0IGf
         Eudm6m47FgEJqB1oI7/4W2yn4qMz/vhjH8bxHeunvVEExtzRfyhF0imp/5MJHLSgy9tG
         YC1iIPrpNc4SWWaCMkgujctWUK67CtGlwZuyZQ6/vKmshE1cAuzk73Hb5CQUq77XSyvR
         CGHgB4sUKG/HRz1O2mmCnO3ONe5kXQunSntlXyfKRU5PUyAVJeiNbice6H576ABfP0CN
         6TNQ==
X-Gm-Message-State: ACgBeo3SF04R+NKD+b0E6k4WGGDfUL19gMKbcUUbSeOhF9Qeu402FUdG
        TSx46ZWOdrgX/OQRM3+7rWKqqg==
X-Google-Smtp-Source: AA6agR4BD6cmbcbpC+BCZcvzn3RJP06MHPv/v/nVtuxaILQVOTEbitSObHN+inl836TTz+WCde6f7A==
X-Received: by 2002:a05:6512:1686:b0:491:3199:d407 with SMTP id bu6-20020a056512168600b004913199d407mr2203181lfb.476.1660899932670;
        Fri, 19 Aug 2022 02:05:32 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5? (d1xw6v77xrs23np8r6z-4.rev.dnainternet.fi. [2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5])
        by smtp.gmail.com with ESMTPSA id x7-20020a056512078700b00492c627cab5sm321401lfr.254.2022.08.19.02.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 02:05:32 -0700 (PDT)
Message-ID: <0aba8906-ed30-786e-cff4-6cb70d6e73c5@linaro.org>
Date:   Fri, 19 Aug 2022 12:05:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/5] dt-bindings: mfd: atmel,at91-usart: convert to
 json-schema
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
 <942accc5-70aa-3bb2-63dd-306a39ee5ea4@linaro.org>
 <d1aad8ea-3852-f36b-366b-7aa67d2dd9d5@microchip.com>
 <ec86420c-a210-facd-ab3a-5baf84a736f3@linaro.org>
In-Reply-To: <ec86420c-a210-facd-ab3a-5baf84a736f3@linaro.org>
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

On 19/08/2022 11:47, Krzysztof Kozlowski wrote:
> On 19/08/2022 11:38, Sergiu.Moga@microchip.com wrote:
>> On 18.08.2022 11:39, Krzysztof Kozlowski wrote:
>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>
>>> On 17/08/2022 10:55, Sergiu Moga wrote:
>>>> Convert at91 USART DT Binding for Atmel/Microchip SoCs to
>>>> json-schema format.
>>>>
>>>> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
>>>> ---
>>>>   .../bindings/mfd/atmel,at91-usart.yaml        | 190 ++++++++++++++++++
>>>>   .../devicetree/bindings/mfd/atmel-usart.txt   |  98 ---------
>>>>   2 files changed, 190 insertions(+), 98 deletions(-)
>>>>   create mode 100644 Documentation/devicetree/bindings/mfd/atmel,at91-usart.yaml
>>>>   delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-usart.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mfd/atmel,at91-usart.yaml b/Documentation/devicetree/bindings/mfd/atmel,at91-usart.yaml
>>>> new file mode 100644
>>>> index 000000000000..cf15d73fa1e8
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/mfd/atmel,at91-usart.yaml
>>> One more thing - I think this should be in serial directory, not mfd,
>>> even though it includes SPI. MFD is just a Linux naming/wrapper device.
>>>
>>> Best regards,
>>> Krzysztof
>>
>> I would rather keep it in this directory, since its corresponding driver 
>> is also in the mfd directory.
> 
> Sorry, but that's poor argument. Driver subsystems match Linux
> convention, not necessarily hardware type/naming. Bindings directories
> match hardware. MFD bindings are only for MFD wrapper drivers and this
> is a serial interface. Not a MFD. You even do not add MFD devices in the
> driver but add *always one* device depending on serial feature you want.
> This is not even MFD device but regular platform device with children.
> 
> You put it in SoC, though, because all other SoCs store it there...

The last one should be:

You could put it in SoC, though, because all other SoCs store it there...

Best regards,
Krzysztof
