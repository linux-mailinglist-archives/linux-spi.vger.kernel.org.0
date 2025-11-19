Return-Path: <linux-spi+bounces-11323-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7CAC6F71F
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 15:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id A02A02F97A
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 14:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAC335BDAF;
	Wed, 19 Nov 2025 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ij76wMoh"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8869927AC57
	for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763563549; cv=none; b=IZ/4Cf/ZfaFXnRh7wHxNOT7tNe9BErQnYTbvRJBLSjHatTfTXWj6ZIHC8Bhrj4D6bJjgOrTTpmnWviBf9vHSmHKoYyOr/pllc6ZZDA5Ld9/Ws8Dvm3hHeqJjrVCgJqrjZQbRiCSzUwjYe8H5TCfs0Cz3yjM13QhLcu4dmtie4M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763563549; c=relaxed/simple;
	bh=FpgOAbIYhuYfiHny/yTXdpx2tP9GMeonyI6HAzCnoR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B/8RzODGlVYu0sIHFINX1dRl+LzY4y0bN8tCjP4kgIm2A9o03VKEJcDp4/CdWAjaIbetUh2qAUmqVfdPOp4IeO0vY/OWs6Mg365OaKKaaZRloNIi0QA2HlG6bBeB4pDQP3ewQnX2PqC4kBplQW5b4XaFVwDNz+ra5k8su2+50zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ij76wMoh; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-450ac3ed719so2113546b6e.0
        for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 06:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763563544; x=1764168344; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=65Ns16gxTh3NW+vKmsGtUFPKjw4kyOUeoeH+pasPpPo=;
        b=ij76wMohszUBXAvHRcWAy+ztoR5AmKX2VibM3qCs8or2AlxNIvE5UoyjX7GyT1CNmy
         yFPKqrjzsTTiRfOifvX67RJp+3AQsLlcTyslqoKF+JTo+8l4MvlDal9gCB/9IRMLlFjz
         +VtcyB0ga+VXdcwht4rwDOYl1Fxz3oDQKy5VZzQ47yPvCKhrw8LQ6XoRHpUaMXQKIqiC
         X8QofHaCfP6hDf7ngWFn5mJVzhwNcDOmGnIhhC1A20j695ER45n4kP9J8U+NjiCxiLyb
         ycwyaNifPt3CDFDbtkpM+Rg7fBy/VmR/OctJLw9Oszg7aHJL5QSE+sgg2LSPoa852Zgg
         4khA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763563544; x=1764168344;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=65Ns16gxTh3NW+vKmsGtUFPKjw4kyOUeoeH+pasPpPo=;
        b=K/5tL35KTurcRjsBozx0LVVP35aVcO2gMQvIdw3bWc/wbirEPVEK8xy4G5dyrRkM2S
         3k+HeBn8I1HVLYksVU2YBEP/fBn+uZcurBcQxucfq6kHtG2CYuUR4BzDypa9xi6/zJ/Z
         RSswPdqJPWG8Q1RTa7SaiabatTGtgcEo8aBWEWzpj5kMlMjb1BB242lvClV4Fvu6SakX
         XBPiSGv8NnNv4vlfAUGc8HOGfdgWMyxMGpry5dNlNjLnGGBVUeEhN2vYuoOMieD6atq/
         WV8A6paL7Scle4d1nP/tNGLMbTzc7CHy7Sl7W3qH4rXi13AVXtov+ccLbxBJ63jtcNCH
         Ug4A==
X-Forwarded-Encrypted: i=1; AJvYcCVEUxDjWBUZ7G+DDcO8YngueTua4nqheHrmF3vyBTHMTkU2u+qw/TI04nIVZpABJX9zkSvpcXcTeoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXx92iAzPAc3i7MgQST8pOeecivJBUfKBXid9MIxKNS/4DjWeo
	iwLOWfH2RZP4B7GRWP++tMMKcnlrcB9aNSLz0mB7c+/2ToKsw2/hLXLdKZCQzXdqM89QynXRa+k
	dr4x0
X-Gm-Gg: ASbGncuzfzPFhucb34GwK5IaK9STbTBre/9mTzkP9SGrGwos98llFEOt+BlENGKl+ZC
	7LSXk+2u0hrQi/n2+QdUK2gFydk4N9LUeRkOetqxVYLKfLeUdSlJ7FWxIX4LFkI3ET0cQGMbpIX
	w6K4uM8FxtqGLjMbildu/RmF7i2rl1IfK5ckCUJ9e3pWeeYVD7FZkIQJb7DpgZ8Hoobn9B75eEc
	01p2q85msYxd6GO+VbJwQ5NIAiDGSwDsnIAGx0Db181zVQENo39Q76Lt9DdCo4mbY3Dcfsix6WC
	9xFvKWJaXC/6zjHsWIS0XiU5O/wcZ2+fWQ4Qnqimh9FemL6YhEk9NNtkHXuX0z4mBjGjWRZnbbE
	egbOAquhK1Xv0wjujwndknmwzID0I9c81KY+XMtR1HpBmp7RNW/rgnT6lyxo9162rHbYM5wM2lN
	MEgbJotULXwwVmkil6B75Lw51/IMM89CJhcOlrEwFoMzSX/qrfaj8SWBjiuCXj
X-Google-Smtp-Source: AGHT+IGAT38Ks4Qoob8CXFhi3Zr9y4b0BYvNCj7qmWn7rmgJYD09bg+QwprfnFA3SZGLWLjrYnkusQ==
X-Received: by 2002:a05:6808:1302:b0:44d:a6a8:1b6a with SMTP id 5614622812f47-4509755d5d2mr9071196b6e.50.1763563544459;
        Wed, 19 Nov 2025 06:45:44 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:f327:6b3c:8989:a18d? ([2600:8803:e7e4:500:f327:6b3c:8989:a18d])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3e8834111c5sm5421311fac.13.2025.11.19.06.45.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 06:45:43 -0800 (PST)
Message-ID: <f2ac13fc-8f47-465e-8cef-e2e34bf41818@baylibre.com>
Date: Wed, 19 Nov 2025 08:45:42 -0600
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] dt-bindings: iio: adc: adi,ad7380: add spi-buses
 property
To: Rob Herring <robh@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20251107-spi-add-multi-bus-support-v2-0-8a92693314d9@baylibre.com>
 <20251107-spi-add-multi-bus-support-v2-5-8a92693314d9@baylibre.com>
 <20251118155905.GB3236324-robh@kernel.org>
 <97c6b55d-9505-4091-8f0b-317dcbd70838@baylibre.com>
 <CAL_Jsq+ZZE0g424jE75xeCt2KY1ThPLqmbmOs0o_ddaJ8fOf3w@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAL_Jsq+ZZE0g424jE75xeCt2KY1ThPLqmbmOs0o_ddaJ8fOf3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/19/25 7:18 AM, Rob Herring wrote:
> On Tue, Nov 18, 2025 at 11:46 AM David Lechner <dlechner@baylibre.com> wrote:
>>
>> On 11/18/25 9:59 AM, Rob Herring wrote:
>>> On Fri, Nov 07, 2025 at 02:52:51PM -0600, David Lechner wrote:
>>>> Add spi-buses property to describe how many SDO lines are wired up on
>>>> the ADC. These chips are simultaneous sampling ADCs and have one SDO
>>>> line per channel, either 2 or 4 total depending on the part number.
>>>>
>>>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>>>> ---
>>>>  .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 22 ++++++++++++++++++++++
>>>>  1 file changed, 22 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
>>>> index b91bfb16ed6bc6c605880f81050250d1ed9c307a..9ef46cdb047d45d088e0fbc345f58c5b09083385 100644
>>>> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
>>>> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
>>>> @@ -62,6 +62,10 @@ properties:
>>>>    spi-cpol: true
>>>>    spi-cpha: true
>>>>
>>>> +  spi-data-buses:
>>>> +    minItems: 1
>>>> +    maxItems: 4
>>>> +
>>>
>>> As the property is not required, what's the default?
>>
>> spi-perepheral-props.yaml defines:
>>
>>         default: [0]
>>
>> Do I need to repeat that here?
> 
> No. So that means you only use one channel and the others are not connected?

Correct.

> 
>>
>>>
>>>>    vcc-supply:
>>>>      description: A 3V to 3.6V supply that powers the chip.
>>>>
>>>> @@ -245,6 +249,22 @@ allOf:
>>>>        patternProperties:
>>>>          "^channel@[0-3]$": false
>>>>
>>>> +  # 2-channel chip can only have up to 2 buses
>>>> +  - if:
>>>> +      properties:
>>>> +        compatible:
>>>> +          enum:
>>>> +            - adi,ad7380
>>>> +            - adi,ad7381
>>>> +            - adi,ad7386
>>>> +            - adi,ad7387
>>>> +            - adi,ad7388
>>>> +            - adi,ad7389
>>>> +    then:
>>>> +      properties:
>>>> +        spi-data-buses:
>>>> +          maxItems: 2
>>>> +
>>>>  examples:
>>>>    - |
>>>>      #include <dt-bindings/interrupt-controller/irq.h>
>>>> @@ -260,6 +280,7 @@ examples:
>>>>              spi-cpol;
>>>>              spi-cpha;
>>>>              spi-max-frequency = <80000000>;
>>>> +            spi-data-buses = <0>, <1>;
>>>>
>>>>              interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
>>>>              interrupt-parent = <&gpio0>;
>>>> @@ -284,6 +305,7 @@ examples:
>>>>              spi-cpol;
>>>>              spi-cpha;
>>>>              spi-max-frequency = <80000000>;
>>>> +            spi-data-buses = <0>, <1>, <2>, <3>;
>>>
>>> An example that doesn't look like a 1 to 1 mapping would be better.
>>> Otherwise, it still looks to me like you could just define the bus
>>> width.
>>
>> I'm not sure we could do that on this chip since it doesn't have
>> the possibility of more than one line per channel.
> 
> That's a property of the SPI controller though, right?
> 
> If the above controller had 4 lines per channel/serializer, then you could have:
> 
> spi-data-buses = <0>, <4>, <8>, <12>;

Ah, I get what you mean now. The intention here though was that the
index numbers correspond to the data lane (channel/serializer), not
to individual lines. So the example you gave would mean that the chip
has at least 13 data lanes (rather than what I think your intention was
of saying it has at least 16 data wires). I did it that way because all
of the hardware I looked at didn't allow assigning arbitrary data lines
to arbitrary lanes/channels so it keeps things simpler and easier to match
to the actual hardware docs.

I intend to change the property name to data-lanes so I will use that
below instead of spi-data-buses.

For this ADC, I would still write:

	data-lanes: <0>, <1>, <2>, <3>;

to mean:

+--------------+    +----------+
| SPI          |    | AD7380-4 |
| Controller   |    | ADC      |
|              |    |          |   
|        SDIA0 |<---| SDOA     |
|        SDIA1 |x   |          |
|        SDIA2 |x   |          |
|        SDIA3 |x   |          |
|              |    |          |
|        SDIB0 |<---| SDOB     |
|        SDIB1 |x   |          |
|        SDIB2 |x   |          |
|        SDIB3 |x   |          |
|              |    |          |
|        SDIC0 |<---| SDOC     |
|        SDIC1 |x   |          |
|        SDIC2 |x   |          |
|        SDIC3 |x   |          |
|              |    |          |
|        SDID0 |<---| SDOD     |
|        SDID1 |x   |          |
|        SDID2 |x   |          |
|        SDID3 |x   |          |
|              |    |          |
+--------------+     +---------+

I.e. lanes <0>=A, <1>=B, <2>=C, <3>=D and there is an implied default
spi-rx-bus-width = <1>;


For another chip we are working on, we could have:

	spi-rx-bus-width = <4>;
	data-lanes: <0>, <1>;

Meaning:

+--------------+    +----------+
| SPI          |    | AD4630   |
| Controller   |    | ADC      |
|              |    |          |   
|        SDIA0 |<---| SDOA0    |
|        SDIA1 |<---| SDOA1    |
|        SDIA2 |<---| SDOA2    |
|        SDIA3 |<---| SDOA3    |
|              |    |          |
|        SDIB0 |<---| SDOB0    |
|        SDIB1 |<---| SDOB1    |
|        SDIB2 |<---| SDOB2    |
|        SDIB3 |<---| SDOB3    |
|              |    |          |
|        SDIC0 |x   |          |
|        SDIC1 |x   |          |
|        SDIC2 |x   |          |
|        SDIC3 |x   |          |
|              |    |          |
|        SDID0 |x   |          |
|        SDID1 |x   |          |
|        SDID2 |x   |          |
|        SDID3 |x   |          |
|              |    |          |
+--------------+     +---------+

> 
> Rob


