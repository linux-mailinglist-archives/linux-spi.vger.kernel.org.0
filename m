Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A63E5B21A9
	for <lists+linux-spi@lfdr.de>; Thu,  8 Sep 2022 17:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbiIHPKZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 8 Sep 2022 11:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiIHPKY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 8 Sep 2022 11:10:24 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821F0C7424
        for <linux-spi@vger.kernel.org>; Thu,  8 Sep 2022 08:10:21 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id a8so6650812lff.13
        for <linux-spi@vger.kernel.org>; Thu, 08 Sep 2022 08:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=5nfFIngu44pae0WCPcM9HQdcNod8T/OMsQbWWVXDqBo=;
        b=LpM3YfC1fmIAQHVaXCX9t/gf9W/yDctvTi9sGXLM0KZtsTeRFtfSYa0I+lVOn77RZG
         gfzpsFmshBRPGemal9JP8/hOz9uhDZK7PZbPVmfkyMH6ujA4/HPnp4dyVPodGiK17X7n
         /OgBw/FsLG5qhSW7iffykKunHEEWz+owJsX6aT7Bu7a+g7DFx1K3mRGRJfSV+l8Vs4A3
         MmWXafVDRzF/+E0ntAcuuaRVZ0BF4OPx032SZfLnno9qPKtWXjRHdda2FlHPyCRVqjxb
         f/m+QK5eXftPOazJbg8mmMjnxKysa5jz7BNvgAjm/tkGj8LtMDWqOxZwUPUGMLMWQUa2
         wpyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=5nfFIngu44pae0WCPcM9HQdcNod8T/OMsQbWWVXDqBo=;
        b=mqcQIa/h924l0XuRWRjm6P3QLh/+ntdB0U9YZHyHPIkP3M1PFiqrYKaoS4tZ5z2b3j
         Hm1VPKSw+MX1rG6/cmFvk47mLpYEk6v7K4u7EB2SrEjDB4+DLH653a4BDuHt18gIwjDz
         UtnANdJ/IxdQbfnqmP4uDaknLS4XeBRhxyzclgx12QvQOpcmad8wmC15QEqr0dK19KHQ
         Qg6uGfZN057iy2JtHOFPNvcwnQD7HVmCpEgpuLevFck3boHEvjctmni30V2HBK5h7aOe
         QoVlrYghw5Or+E8ChPvoNhoZy/MgnwqDQL8On4ySm0nlhyjY4H+QOYKBJKcfCVPxsTXY
         Nrcg==
X-Gm-Message-State: ACgBeo1NxMErE5SEraPM9/zI6CqmIJC4kMUB1/2nv5N1A4komEXZRQua
        48iqzgpBXoH4xWsjryH6LmXvCg==
X-Google-Smtp-Source: AA6agR7mH7tBvCONHwd5zeSS7p8UBOMCrjw3/bIV+uQT7ic1vLgbCVloBrxwXFxi0Pxd+glXTXPrRg==
X-Received: by 2002:a19:2d5c:0:b0:498:3e16:b3fc with SMTP id t28-20020a192d5c000000b004983e16b3fcmr1346131lft.498.1662649819860;
        Thu, 08 Sep 2022 08:10:19 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id f11-20020a056512092b00b00497b198987bsm546555lft.26.2022.09.08.08.10.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 08:10:19 -0700 (PDT)
Message-ID: <1d3904d9-7fec-2e61-f999-61b89c4becb6@linaro.org>
Date:   Thu, 8 Sep 2022 17:10:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 05/13] dt-bindings: serial: atmel,at91-usart: convert
 to json-schema
Content-Language: en-US
To:     Sergiu.Moga@microchip.com, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, Claudiu.Beznea@microchip.com,
        richard.genoud@gmail.com, radu_nicolae.pirea@upb.ro,
        gregkh@linuxfoundation.org, broonie@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, jirislaby@kernel.org,
        admin@hifiphile.com, Kavyasree.Kotagiri@microchip.com,
        Tudor.Ambarus@microchip.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-clk@vger.kernel.org
References: <20220906135511.144725-1-sergiu.moga@microchip.com>
 <20220906135511.144725-6-sergiu.moga@microchip.com>
 <e799ca9e-acb0-1bea-1c1a-b2ab79089381@linaro.org>
 <fde16d80-28b4-aae6-363f-ad9dcf87a5e1@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <fde16d80-28b4-aae6-363f-ad9dcf87a5e1@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 08/09/2022 17:06, Sergiu.Moga@microchip.com wrote:
> On 08.09.2022 15:29, Krzysztof Kozlowski wrote:

>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - interrupts
>>> +  - clock-names
>>> +  - clocks
>>> +
>>> +allOf:
>>> +  - if:
>>> +      properties:
>>> +        $nodename:
>>> +          pattern: "^serial@[0-9a-f]+$"
>>
>> You should rather check value of atmel,usart-mode, because now you won't
>> properly match device nodes called "foobar". Since usart-mode has only
>> two possible values, this will nicely simplify you if-else.
>>
>>
> 
> 
> I did think of that but the previous binding specifies that 
> atmel,usart-mode is required only for the SPI mode and it is optional 
> for the USART mode. That is why I went for the node's regex since I 
> thought it is something that both nodes would have.

I think it should be explicit - you configure node either to this or
that, so the property should be always present. The node name should not
be responsible for it, even though we want node names to match certain
patterns.

> 
> 
>>> +    then:
>>> +      allOf:
>>> +        - $ref: /schemas/serial/serial.yaml#
>>> +        - $ref: /schemas/serial/rs485.yaml#
>>> +
>>> +      properties:
>>> +        atmel,use-dma-rx:
>>> +          type: boolean
>>> +          description: use of PDC or DMA for receiving data
>>> +
>>> +        atmel,use-dma-tx:
>>> +          type: boolean
>>> +          description: use of PDC or DMA for transmitting data
>>> +
>>> +        atmel,fifo-size:
>>> +          $ref: /schemas/types.yaml#/definitions/uint32
>>> +          description:
>>> +            Maximum number of data the RX and TX FIFOs can store for FIFO
>>> +            capable USARTS.
>>> +          enum: [ 16, 32 ]
>>
>> I did not mention it last time, but I think it should follow generic
>> practice, so define all properties top-level and disallow them for other
>> type. This allows you to simply use additionalProperties:false at the end.
>>
> 
> 
> What would be a good example binding in this case?

The example binding.

https://elixir.bootlin.com/linux/v5.19/source/Documentation/devicetree/bindings/example-schema.yaml#L212

> 
> 
>>> +
>>> +    else:
>>> +      if:
>>> +        properties:
>>> +          $nodename:
>>> +            pattern: "^spi@[0-9a-f]+$"
>>> +      then:
>>> +        allOf:
>>> +          - $ref: /schemas/spi/spi-controller.yaml#
>>> +
>>> +        properties:
>>> +          atmel,usart-mode:
>>> +            const: 1
>>> +
>>> +          "#size-cells":
>>> +            const: 0
>>> +
>>> +          "#address-cells":
>>> +            const: 1
>>
>> The same - top level and disallow them for uart.
>>
> 
> 
> These values of #size-cells and #address-cells are only meant for the 
> SPI so I guess I would still have to specify their mandatory const 
> values here.

Sure, ok.

> 
> 
>>> +
>>> +        required:
>>> +          - atmel,usart-mode
>>> +          - "#size-cells"
>>> +          - "#address-cells"
>>
>> End else in this branch is what?
>>
> 
> 
> You are right, I will remove the useless if: after else:

Best regards,
Krzysztof
