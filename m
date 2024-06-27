Return-Path: <linux-spi+bounces-3638-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2125891ADC4
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 19:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 994E41F22F88
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 17:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19265199E83;
	Thu, 27 Jun 2024 17:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="eQ6oK3v7"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563BB1C6A1
	for <linux-spi@vger.kernel.org>; Thu, 27 Jun 2024 17:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719508588; cv=none; b=J0dIi1YB3Ze9twuwwH1zTZ5LGSp9hrYh/CT3qH25KiCwOmBVtd9r8rLgUCJTG/j9xLQZJMO8kjk9cR77easRzppNWunhY/5zUpwokyP9TPIPtW1fvOCNwH9pZ3O5413D/ELxeMZwUu1lLyPqrNcr3yRbrFku128uGgsIztgj0YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719508588; c=relaxed/simple;
	bh=cC4Ky9SpAj63i7Mc/O4NG3zXjaYl7QcGAp4iWMLCcbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gF/kkN8DLMKYBaPfT1G4MUH46VCqoJnN3hdg+MmFLSbOTl58FMrR7fuz54rnKnUsgwufn6GD0pnj1IGI/0EZpIvglWj4QCVf8ElX1g3WupWkCqdlNdcphrQXw/wXWdGYO30caOFqEsvQnOh7QJlzRfgn0v/VpNUJElB4Xzsg8Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=eQ6oK3v7; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fa94d0ba3dso1928605ad.2
        for <linux-spi@vger.kernel.org>; Thu, 27 Jun 2024 10:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1719508585; x=1720113385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z7foaEoqWBYAVfICkiWLM0lOscLmLoi1AUMgb9qBaJs=;
        b=eQ6oK3v7PmCv+kMS2mDb0CobWIEvuIRMkeXx1I8Ifu+Opz+NSgHD+Ni9nAxSCCEEn9
         3jUwgzeSQTVkm3jIEwKMBFQbOR0rLSv/vkUZiyQmP8U1reZyv79RPxw7CGMIlHe2VJ9Q
         9nHNXnAWM8Pu68UgJzrn6wrOmcHamHg2kyDo5brLEYtPEWkzBcvZdgGWGWZG4noDShKj
         AiEYi/wI/eTOAnVVIBD2Bmgc4AWPolIp4gEWEkS0LTeXzeCNNaGCL5FZjh9vybA3kPnu
         S6fTeK0V5sWGFR89NrXRz46iFROwT7eoWrssdzZdz74Y1W/8OubcUL0vgi062ho9mKni
         3Ufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719508585; x=1720113385;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z7foaEoqWBYAVfICkiWLM0lOscLmLoi1AUMgb9qBaJs=;
        b=tFR9dQjgyJH9TOYgrY6w9/Q4fRr2fSTMc6xjFUI/B4lXa+ouGVFnse7wOq4V8AuE4z
         /TUxHEZs5vVOMbcYKhQDINszmcls4NN9u30aGZ0Tjy2sTGuETQ73zuqkILd5pIBoyMZg
         /ydhtoxgPtlAKZVHXQhAe8v9WM5Y/XpoMZ6W6kq6p34jjOtd9+May4AKdJxJuL/ePgaS
         buV9qDrhw0od/cV3kPgyknyOFydr+XUXnfczNt6WV7xG/XuzJ6iyKBozQUJK2mZj7TJf
         SZeixc+5hIHkejA17hzwFiy5hlzTOB9cLjUkOuelEHJw3zwkDDKCdTENmR9p7NUSq6zk
         F3qw==
X-Gm-Message-State: AOJu0Yw8aSMN6vZLiSguyx3vGcXueXDFIqZsMaRQ6yr4ygoZZ05YVvzA
	+t1Ctf1AdGNcy9dhnrxZ7HbC3+1+NI5A9HEM3758M6oWIqwdmUayPByLo+qm1w==
X-Google-Smtp-Source: AGHT+IHocJw3g7IpJwxKwOC/B8eIwHeYixMRJQpnA/X78oiJ15427+UGqnMhiNsCyVfkiUfhChbEhQ==
X-Received: by 2002:a05:6a20:9794:b0:1bc:ecc1:6f7f with SMTP id adf61e73a8af0-1bcecc1709emr14438688637.1.1719508584653;
        Thu, 27 Jun 2024 10:16:24 -0700 (PDT)
Received: from ?IPV6:2401:4900:1f3e:18b0:f314:9f76:9f94:eb43? ([2401:4900:1f3e:18b0:f314:9f76:9f94:eb43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706b4a35418sm1656485b3a.177.2024.06.27.10.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 10:16:24 -0700 (PDT)
Message-ID: <cef08d49-a462-4167-8b9d-bf09e8aac92f@beagleboard.org>
Date: Thu, 27 Jun 2024 22:46:15 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] dts: ti: k3-am625-beagleplay: Add mikroBUS
Content-Language: en-US
To: Andrew Davis <afd@ti.com>, Mark Brown <broonie@kernel.org>,
 Vaishnav M A <vaishnav@beagleboard.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Derek Kiernan <derek.kiernan@amd.com>,
 Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Michael Walle <mwalle@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 jkridner@beagleboard.org, robertcnelson@beagleboard.org
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240627-mikrobus-scratch-spi-v5-0-9e6c148bf5f0@beagleboard.org>
 <20240627-mikrobus-scratch-spi-v5-7-9e6c148bf5f0@beagleboard.org>
 <4e23ec81-b278-4f2b-815d-64ed9390ca55@ti.com>
From: Ayush Singh <ayush@beagleboard.org>
In-Reply-To: <4e23ec81-b278-4f2b-815d-64ed9390ca55@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 6/27/24 22:37, Andrew Davis wrote:
> On 6/27/24 11:26 AM, Ayush Singh wrote:
>> DONOTMERGE
>>
>> Add mikroBUS connector and some mikroBUS boards support for Beagleplay.
>> The mikroBUS boards node should probably be moved to a more appropriate
>> location but I am not quite sure where it should go since it is not
>> dependent on specific arch.
>>
>> Signed-off-by: Ayush Singh <ayush@beagleboard.org>
>> ---
>>   arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts | 94 
>> +++++++++++++++++++++++---
>>   1 file changed, 86 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts 
>> b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
>> index 70de288d728e..3f3cd70345c4 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
>> @@ -38,6 +38,7 @@ aliases {
>>           serial2 = &main_uart0;
>>           usb0 = &usb0;
>>           usb1 = &usb1;
>> +        mikrobus0 = &mikrobus0;
>>       };
>>         chosen {
>> @@ -227,6 +228,56 @@ simple-audio-card,codec {
>>           };
>>       };
>>   +    mikrobus0: mikrobus-connector {
>> +        compatible = "mikrobus-connector";
>> +        pinctrl-names = "default", "pwm_default", "pwm_gpio",
>> +                "uart_default", "uart_gpio", "i2c_default",
>> +                "i2c_gpio", "spi_default", "spi_gpio";
>> +        pinctrl-0 = <&mikrobus_gpio_pins_default>;
>> +        pinctrl-1 = <&mikrobus_pwm_pins_default>;
>> +        pinctrl-2 = <&mikrobus_pwm_pins_gpio>;
>> +        pinctrl-3 = <&mikrobus_uart_pins_default>;
>> +        pinctrl-4 = <&mikrobus_uart_pins_gpio>;
>> +        pinctrl-5 = <&mikrobus_i2c_pins_default>;
>> +        pinctrl-6 = <&mikrobus_i2c_pins_gpio>;
>> +        pinctrl-7 = <&mikrobus_spi_pins_default>;
>> +        pinctrl-8 = <&mikrobus_spi_pins_gpio>;
>> +
>> +        mikrobus-gpio-names = "pwm", "int", "rx", "tx", "scl", "sda",
>> +                      "mosi", "miso", "sck", "cs", "rst", "an";
>> +        mikrobus-gpios = <&main_gpio1 11 GPIO_ACTIVE_HIGH>,
>> +                 <&main_gpio1 9 GPIO_ACTIVE_HIGH>,
>> +                 <&main_gpio1 24 GPIO_ACTIVE_HIGH>,
>> +                 <&main_gpio1 25 GPIO_ACTIVE_HIGH>,
>> +                 <&main_gpio1 22 GPIO_ACTIVE_HIGH>,
>> +                 <&main_gpio1 23 GPIO_ACTIVE_HIGH>,
>> +                 <&main_gpio1 7 GPIO_ACTIVE_HIGH>,
>> +                 <&main_gpio1 8 GPIO_ACTIVE_HIGH>,
>> +                 <&main_gpio1 14 GPIO_ACTIVE_HIGH>,
>> +                 <&main_gpio1 13 GPIO_ACTIVE_HIGH>,
>> +                 <&main_gpio1 12 GPIO_ACTIVE_HIGH>,
>> +                 <&main_gpio1 10 GPIO_ACTIVE_HIGH>;
>> +
>> +        spi-controller = <&main_spi2>;
>> +        spi-cs = <0>;
>> +        spi-cs-names = "default";
>> +
>> +        board = <&lsm6dsl_click>;
>> +    };
>> +
>> +    mikrobus_boards {
>> +        thermo_click: thermo-click {
>> +            compatible = "maxim,max31855k", "mikrobus-spi";
>
> I might be missing something, but your solution cannot possibly be
> to list every click board that could be connected (all 1500+ of them)
> to every mikroBUS connector on every device's DT file..


I think you missed something. `mikrobus-boards` is not a child node of 
`mikrobus0`. See the `board` property in `mikrobus0`. That is what 
selects the board attached to the connector.

The `mikcrobus-boards` node itself should be moved to some independent 
location and included from a system that wants to support mikrobus 
boards. The connector will only have a phandle to the board (or boards 
in case a single mikroBUS board has 1 i2c and 1 spi sensor or some 
combination).


>
> Each click board should have a single DTSO overlay file to describe the
> click board, one per click board total. And then that overlay should
> apply cleanly to any device that has a mikroBUS interface.


Yes, that is the goal.


>
> Which means you have not completely solved the fundamental problem of
> abstracting the mikroBUS connector in DT. Each of these click device 
> child
> nodes has to be under the parent connector node. Which means a phandle
> to the parent node, which is not generically named. For instance
> if my board has 2 connectors, I would have mikrobus0 and mikrobus1,
> the click board's overlay would look like this:
>
> /dts-v1/;
> /plugin/;
>
> &mikrobus0 {
>     status = "okay";
>
>     mikrobus_board {
>         thermo-click {
>             compatible = "maxim,max31855k", "mikrobus-spi";
>             spi-max-frequency = <1000000>;
>             pinctrl-apply = "spi_default";
>         };
>     };
> };


No, it will look as follows:

```

&mikrobus0 {
     status = "okay";

     board = <&thermo-click>;

};


&mikrobus_board {
         thermo-click {
             compatible = "maxim,max31855k", "mikrobus-spi";
             spi-max-frequency = <1000000>;
             pinctrl-apply = "spi_default";
         };
   };

```


>
> I think this solution is almost there, but once you solve the above
> issue, we could just apply the right overlay for our attached click
> board ahead of time and not need the mikroBUS bus driver at all.


Well, the driver is still needed because some things cannot be done 
generically in dt. Eg:

1. SPI chipselect. Each connector will have different chipselect number 
mapped to CS pin. In fact a mikrobus board might use other pins like RST 
as chipselect as well.

2. Using pins other than their intended purpose like GPIO.


>
> Andrew
>
>> +            spi-max-frequency = <1000000>;
>> +            pinctrl-apply = "spi_default";
>> +        };
>> +
>> +        lsm6dsl_click: lsm6dsl-click {
>> +            compatible = "st,lsm6ds3", "mikrobus-spi";
>> +            spi-max-frequency = <1000000>;
>> +            pinctrl-apply = "spi_default";
>> +        };
>> +    };
>>   };
>>     &main_pmx0 {
>> @@ -387,6 +438,18 @@ AM62X_IOPAD(0x01f0, PIN_OUTPUT, 5) /* (A18) 
>> EXT_REFCLK1.CLKOUT0 */
>>           >;
>>       };
>>   +    mikrobus_pwm_pins_default: mikrobus-pwm-default-pins {
>> +        pinctrl-single,pins = <
>> +            AM62X_IOPAD(0x01a4, PIN_INPUT, 2) /* (B20) 
>> MCASP0_ACLKX.ECAP2_IN_APWM_OUT */
>> +        >;
>> +    };
>> +
>> +    mikrobus_pwm_pins_gpio: mikrobus-pwm-gpio-pins {
>> +        pinctrl-single,pins = <
>> +            AM62X_IOPAD(0x01a4, PIN_INPUT, 7) /* (B20) 
>> MCASP0_ACLKX.GPIO1_11 */
>> +        >;
>> +    };
>> +
>>       mikrobus_i2c_pins_default: mikrobus-i2c-default-pins {
>>           pinctrl-single,pins = <
>>               AM62X_IOPAD(0x01d0, PIN_INPUT_PULLUP, 2) /* (A15) 
>> UART0_CTSn.I2C3_SCL */
>> @@ -394,6 +457,13 @@ AM62X_IOPAD(0x01d4, PIN_INPUT_PULLUP, 2) /* 
>> (B15) UART0_RTSn.I2C3_SDA */
>>           >;
>>       };
>>   +    mikrobus_i2c_pins_gpio: mikrobus-i2c-gpio-pins {
>> +        pinctrl-single,pins = <
>> +            AM62X_IOPAD(0x01d0, PIN_INPUT, 7) /* (A15) 
>> UART0_CTSn.GPIO1_22 */
>> +            AM62X_IOPAD(0x01d4, PIN_INPUT, 7) /* (B15) 
>> UART0_RTSn.GPIO1_23 */
>> +        >;
>> +    };
>> +
>>       mikrobus_uart_pins_default: mikrobus-uart-default-pins {
>>           pinctrl-single,pins = <
>>               AM62X_IOPAD(0x01d8, PIN_INPUT, 1) /* (C15) 
>> MCAN0_TX.UART5_RXD */
>> @@ -401,6 +471,13 @@ AM62X_IOPAD(0x01dc, PIN_OUTPUT, 1) /* (E15) 
>> MCAN0_RX.UART5_TXD */
>>           >;
>>       };
>>   +    mikrobus_uart_pins_gpio: mikrobus-uart-gpio-pins {
>> +        pinctrl-single,pins = <
>> +            AM62X_IOPAD(0x01d8, PIN_INPUT, 7) /* (C15) 
>> MCAN0_TX.GPIO1_24 */
>> +            AM62X_IOPAD(0x01dc, PIN_INPUT, 7) /* (E15) 
>> MCAN0_RX.GPIO1_25 */
>> +        >;
>> +    };
>> +
>>       mikrobus_spi_pins_default: mikrobus-spi-default-pins {
>>           pinctrl-single,pins = <
>>               AM62X_IOPAD(0x01b0, PIN_INPUT, 1) /* (A20) 
>> MCASP0_ACLKR.SPI2_CLK */
>> @@ -410,6 +487,15 @@ AM62X_IOPAD(0x0198, PIN_INPUT, 1) /* (A19) 
>> MCASP0_AXR2.SPI2_D1 */
>>           >;
>>       };
>>   +    mikrobus_spi_pins_gpio: mikrobus-spi-gpio-pins {
>> +        pinctrl-single,pins = <
>> +            AM62X_IOPAD(0x0194, PIN_INPUT, 7) /* (B19) 
>> MCASP0_AXR3.GPIO1_7 */
>> +            AM62X_IOPAD(0x0198, PIN_INPUT, 7) /* (A19) 
>> MCASP0_AXR2.GPIO1_8 */
>> +            AM62X_IOPAD(0x01ac, PIN_INPUT, 7) /* (E19) 
>> MCASP0_AFSR.GPIO1_13 */
>> +            AM62X_IOPAD(0x01b0, PIN_INPUT, 7) /* (A20) 
>> MCASP0_ACLKR.GPIO1_14 */
>> +        >;
>> +    };
>> +
>>       mikrobus_gpio_pins_default: mikrobus-gpio-default-pins {
>>           bootph-all;
>>           pinctrl-single,pins = <
>> @@ -630,8 +716,6 @@ &main_gpio0 {
>>     &main_gpio1 {
>>       bootph-all;
>> -    pinctrl-names = "default";
>> -    pinctrl-0 = <&mikrobus_gpio_pins_default>;
>>       gpio-line-names = "", "", "", "", "",            /* 0-4 */
>>           "SPE_RSTN", "SPE_INTN", "MIKROBUS_GPIO1_7",    /* 5-7 */
>>           "MIKROBUS_GPIO1_8", "MIKROBUS_GPIO1_9",        /* 8-9 */
>> @@ -804,15 +888,11 @@ it66121_out: endpoint {
>>   };
>>     &main_i2c3 {
>> -    pinctrl-names = "default";
>> -    pinctrl-0 = <&mikrobus_i2c_pins_default>;
>>       clock-frequency = <400000>;
>>       status = "okay";
>>   };
>>     &main_spi2 {
>> -    pinctrl-names = "default";
>> -    pinctrl-0 = <&mikrobus_spi_pins_default>;
>>       status = "okay";
>>   };
>>   @@ -876,8 +956,6 @@ &main_uart1 {
>>   };
>>     &main_uart5 {
>> -    pinctrl-names = "default";
>> -    pinctrl-0 = <&mikrobus_uart_pins_default>;
>>       status = "okay";
>>   };
>>

Ayush Singh


