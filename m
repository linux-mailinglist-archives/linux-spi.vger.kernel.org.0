Return-Path: <linux-spi+bounces-3646-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D173691AEDE
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 20:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F22401C20A79
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 18:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E93614C5AE;
	Thu, 27 Jun 2024 18:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="p7VzlnAF"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8615413F441
	for <linux-spi@vger.kernel.org>; Thu, 27 Jun 2024 18:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719512203; cv=none; b=l1Rmyx5Lf2HpbLMMy7aGHcT5k/NhGU1cP19iLA+ArZ7r1GOmA/51RUaQXbDBbfT0LKv9bH6j090b4jbue3zMpaDgE3GOUMpMKNyhIAr3kp16ZMCSO4kluNJcMjQPvK+2ep8vZIuollFVoU3iuYveZiGFGMhyAtD6fPk/0wIpei8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719512203; c=relaxed/simple;
	bh=Rjbub/7SbWzz3x2O07QzwXxLjt5+VzgYUZpnj9b6HcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t6I87kikjfOgdCEKmcXBcmhSOqIdD1kydzgBT/j7GhVCLSUXLCePQMXBIrv5OdUVloP2p6Y0yJh3Pd9KO4s4yQEFPpnn2EGQwwt6vvKraixvu/WuLShY22WZQBG9nCLGnrKA/dpZpZiOydA4PXRVkRrpa+evgPNrctC2B/lM9Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=p7VzlnAF; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7eedf4ae265so28129739f.3
        for <linux-spi@vger.kernel.org>; Thu, 27 Jun 2024 11:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1719512200; x=1720117000; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eLDikSdk/1sOE2P/qXbu74mkWY2cTfnLGql7zUD9KQQ=;
        b=p7VzlnAFsvyQdQuJSE9vxbTTuBziWC2DV58rmSn0qq2gUN2sQH82kY8luBE2nL3Odv
         MTNfbYPankb9YfZ+Yzu0Nnuqngk8JWRYc4NWWFaknUXDfcDP9UzH7JoMr24vbP/75W8i
         Hw89pS/3gTVpXB4Ci/AJXtDn+wI6nItrknpRNu6TgSwf+1RCIFHwlswQ4UcW6b9N/K8C
         dOu1OMVm6bTgL/raC88IzOhVfuIQDl/NQp/rs2RpCSXov3NmimrarenCuIytclm/k/Q3
         2zA+7QkMtau6wcp/RPIrCKI5XND1bUgF4cWcoemiUxHVX6Scw9dI8sZ/rokClxboItXT
         7g7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719512200; x=1720117000;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eLDikSdk/1sOE2P/qXbu74mkWY2cTfnLGql7zUD9KQQ=;
        b=SbprOhVNL+OYPlb1zCJPdmGgHGXdxD8AbLyrs07rO4cKxpwazOFbtk4+2Pfvxe14mu
         8FnNlmkHbvTFspSWuaPm4uko+MQoZdX6SePKZ/bPViOdAArtEHqraoY1cgDre/JvQ6JW
         nhA3K18CopdIjk+MtqM0z5ulHmDBM9XjjfnlKcm+DgT8EEr/60arpP39zS0zIrubo+VN
         C6K1wz9IXt5sv+5zBehwxF9cz5jH5eboZSH7a9m2aLU/05EdSumnTnu7vNck9IB8Drjy
         GZFtWUrqGQrj4tm5XrB05Fd5pEAFfARe3DKuFMXZ9NPCXuT1M95E9+7NaG8heWubNWyU
         gtFQ==
X-Gm-Message-State: AOJu0YwduV12ODAyKUquutQUcFx4RIdzJ68bN3ywkqUGaASm2gaSECS9
	r2zZu4XvGhg8F4bxCbF3VHFJza6P825oJBmi6GdIlzIBBjBWyeeM0d4PLr9R6Q==
X-Google-Smtp-Source: AGHT+IHavFLzL5XbWg1BfGQFlomVOvXihRfVsBBzcOPdhahsJHdov+JEipjG1MSyp7mxPv2g+nDSCQ==
X-Received: by 2002:a05:6e02:4b2:b0:379:2b4d:d5de with SMTP id e9e14a558f8ab-3792b4dd9cdmr39861015ab.2.1719512200604;
        Thu, 27 Jun 2024 11:16:40 -0700 (PDT)
Received: from ?IPV6:2401:4900:1f3e:18b0:f314:9f76:9f94:eb43? ([2401:4900:1f3e:18b0:f314:9f76:9f94:eb43])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6c7f72a7sm17867a12.63.2024.06.27.11.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 11:16:40 -0700 (PDT)
Message-ID: <93cdd5c5-d54c-46c2-9055-5cd9cc79e2da@beagleboard.org>
Date: Thu, 27 Jun 2024 23:46:31 +0530
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
 <cef08d49-a462-4167-8b9d-bf09e8aac92f@beagleboard.org>
 <70f28343-6738-47f2-97b5-6afa96f1fbcc@ti.com>
From: Ayush Singh <ayush@beagleboard.org>
In-Reply-To: <70f28343-6738-47f2-97b5-6afa96f1fbcc@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 6/27/24 23:20, Andrew Davis wrote:
> On 6/27/24 12:16 PM, Ayush Singh wrote:
>>
>> On 6/27/24 22:37, Andrew Davis wrote:
>>> On 6/27/24 11:26 AM, Ayush Singh wrote:
>>>> DONOTMERGE
>>>>
>>>> Add mikroBUS connector and some mikroBUS boards support for 
>>>> Beagleplay.
>>>> The mikroBUS boards node should probably be moved to a more 
>>>> appropriate
>>>> location but I am not quite sure where it should go since it is not
>>>> dependent on specific arch.
>>>>
>>>> Signed-off-by: Ayush Singh <ayush@beagleboard.org>
>>>> ---
>>>>   arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts | 94 
>>>> +++++++++++++++++++++++---
>>>>   1 file changed, 86 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts 
>>>> b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
>>>> index 70de288d728e..3f3cd70345c4 100644
>>>> --- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
>>>> +++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
>>>> @@ -38,6 +38,7 @@ aliases {
>>>>           serial2 = &main_uart0;
>>>>           usb0 = &usb0;
>>>>           usb1 = &usb1;
>>>> +        mikrobus0 = &mikrobus0;
>>>>       };
>>>>         chosen {
>>>> @@ -227,6 +228,56 @@ simple-audio-card,codec {
>>>>           };
>>>>       };
>>>>   +    mikrobus0: mikrobus-connector {
>>>> +        compatible = "mikrobus-connector";
>>>> +        pinctrl-names = "default", "pwm_default", "pwm_gpio",
>>>> +                "uart_default", "uart_gpio", "i2c_default",
>>>> +                "i2c_gpio", "spi_default", "spi_gpio";
>>>> +        pinctrl-0 = <&mikrobus_gpio_pins_default>;
>>>> +        pinctrl-1 = <&mikrobus_pwm_pins_default>;
>>>> +        pinctrl-2 = <&mikrobus_pwm_pins_gpio>;
>>>> +        pinctrl-3 = <&mikrobus_uart_pins_default>;
>>>> +        pinctrl-4 = <&mikrobus_uart_pins_gpio>;
>>>> +        pinctrl-5 = <&mikrobus_i2c_pins_default>;
>>>> +        pinctrl-6 = <&mikrobus_i2c_pins_gpio>;
>>>> +        pinctrl-7 = <&mikrobus_spi_pins_default>;
>>>> +        pinctrl-8 = <&mikrobus_spi_pins_gpio>;
>>>> +
>>>> +        mikrobus-gpio-names = "pwm", "int", "rx", "tx", "scl", "sda",
>>>> +                      "mosi", "miso", "sck", "cs", "rst", "an";
>>>> +        mikrobus-gpios = <&main_gpio1 11 GPIO_ACTIVE_HIGH>,
>>>> +                 <&main_gpio1 9 GPIO_ACTIVE_HIGH>,
>>>> +                 <&main_gpio1 24 GPIO_ACTIVE_HIGH>,
>>>> +                 <&main_gpio1 25 GPIO_ACTIVE_HIGH>,
>>>> +                 <&main_gpio1 22 GPIO_ACTIVE_HIGH>,
>>>> +                 <&main_gpio1 23 GPIO_ACTIVE_HIGH>,
>>>> +                 <&main_gpio1 7 GPIO_ACTIVE_HIGH>,
>>>> +                 <&main_gpio1 8 GPIO_ACTIVE_HIGH>,
>>>> +                 <&main_gpio1 14 GPIO_ACTIVE_HIGH>,
>>>> +                 <&main_gpio1 13 GPIO_ACTIVE_HIGH>,
>>>> +                 <&main_gpio1 12 GPIO_ACTIVE_HIGH>,
>>>> +                 <&main_gpio1 10 GPIO_ACTIVE_HIGH>;
>>>> +
>>>> +        spi-controller = <&main_spi2>;
>>>> +        spi-cs = <0>;
>>>> +        spi-cs-names = "default";
>>>> +
>>>> +        board = <&lsm6dsl_click>;
>>>> +    };
>>>> +
>>>> +    mikrobus_boards {
>>>> +        thermo_click: thermo-click {
>>>> +            compatible = "maxim,max31855k", "mikrobus-spi";
>>>
>>> I might be missing something, but your solution cannot possibly be
>>> to list every click board that could be connected (all 1500+ of them)
>>> to every mikroBUS connector on every device's DT file..
>>
>>
>> I think you missed something. `mikrobus-boards` is not a child node 
>> of `mikrobus0`. See the `board` property in `mikrobus0`. That is what 
>> selects the board attached to the connector.
>>
>
> That seems even worse.. That means the board file needs to know about the
> attached board, which is not how DT works. It describes hardware in a
> hierarchical/acyclic graph. For instance, take an I2C device, its node
> is a child of the I2C bus, and has phandle pointers to the IRQ it uses
> (or whatever else provider it needs). What you have here is like the
> I2C bus node phandle pointing to the connected child devices.
>
>> The `mikcrobus-boards` node itself should be moved to some 
>> independent location and included from a system that wants to support 
>> mikrobus boards. The connector will only have a phandle to the board 
>> (or boards in case a single mikroBUS board has 1 i2c and 1 spi sensor 
>> or some combination).
>>
>
> How about providing the full/final example then (this series should be 
> marked
> as RFC as it is now has missing parts). Move the click board node into 
> a DTSO
> file and put that in a common location (click boards are common to all 
> boards
> right, so lets say in drivers/of/click for now just for the RFC).
>
>>
>>>
>>> Each click board should have a single DTSO overlay file to describe the
>>> click board, one per click board total. And then that overlay should
>>> apply cleanly to any device that has a mikroBUS interface.
>>
>>
>> Yes, that is the goal.
>>
>>
>>>
>>> Which means you have not completely solved the fundamental problem of
>>> abstracting the mikroBUS connector in DT. Each of these click device 
>>> child
>>> nodes has to be under the parent connector node. Which means a phandle
>>> to the parent node, which is not generically named. For instance
>>> if my board has 2 connectors, I would have mikrobus0 and mikrobus1,
>>> the click board's overlay would look like this:
>>>
>>> /dts-v1/;
>>> /plugin/;
>>>
>>> &mikrobus0 {
>>>     status = "okay";
>>>
>>>     mikrobus_board {
>>>         thermo-click {
>>>             compatible = "maxim,max31855k", "mikrobus-spi";
>>>             spi-max-frequency = <1000000>;
>>>             pinctrl-apply = "spi_default";
>>>         };
>>>     };
>>> };
>>
>>
>> No, it will look as follows:
>>
>> ```
>>
>> &mikrobus0 {
>
>           ^^^
> So same issue, what if I want to attach this click board
> to the second mikrobus connector on my board (i.e. mikrobus1),
> I'd have to modify the overlay.. Or have an overlay for every
> possible connector instance number.


The plan is to have a sysfs `new_device` and `delete_device` entry like 
I2C has where the board name is passed. The driver can then create a dt 
changeset apply to live tree. In the current dt, the changeset is to add 
a `board` property with the phandle of a board (if found).

Can you suggest how something similar will be possible if the board node 
is a child of the connector node? Maybe it is possible to take a generic 
dt overlay and change the name of parent node on it or something?


>
>>      status = "okay";
>>
>>      board = <&thermo-click>;
>>
>> };
>>
>>
>> &mikrobus_board {
>>          thermo-click {
>>              compatible = "maxim,max31855k", "mikrobus-spi";
>>              spi-max-frequency = <1000000>;
>>              pinctrl-apply = "spi_default";
>>          };
>>    };
>>
>> ```
>>
>>
>>>
>>> I think this solution is almost there, but once you solve the above
>>> issue, we could just apply the right overlay for our attached click
>>> board ahead of time and not need the mikroBUS bus driver at all.
>>
>>
>> Well, the driver is still needed because some things cannot be done 
>> generically in dt. Eg:
>>
>> 1. SPI chipselect. Each connector will have different chipselect 
>> number mapped to CS pin. In fact a mikrobus board might use other 
>> pins like RST as chipselect as well.
>>
>> 2. Using pins other than their intended purpose like GPIO.
>>
>
> Then these are two things you'll need to solve. We can add
> these functions to the base DT/OF support if they are generic
> problems (which they are, other connectors/daughterboards have
> this same issue, RPi header, Seeed Grove connector, Sparkfun QWIIC
> headers, etc..).
>
> Andrew
>
>>
>>>
>>> Andrew
>>>
>>>> +            spi-max-frequency = <1000000>;
>>>> +            pinctrl-apply = "spi_default";
>>>> +        };
>>>> +
>>>> +        lsm6dsl_click: lsm6dsl-click {
>>>> +            compatible = "st,lsm6ds3", "mikrobus-spi";
>>>> +            spi-max-frequency = <1000000>;
>>>> +            pinctrl-apply = "spi_default";
>>>> +        };
>>>> +    };
>>>>   };
>>>>     &main_pmx0 {
>>>> @@ -387,6 +438,18 @@ AM62X_IOPAD(0x01f0, PIN_OUTPUT, 5) /* (A18) 
>>>> EXT_REFCLK1.CLKOUT0 */
>>>>           >;
>>>>       };
>>>>   +    mikrobus_pwm_pins_default: mikrobus-pwm-default-pins {
>>>> +        pinctrl-single,pins = <
>>>> +            AM62X_IOPAD(0x01a4, PIN_INPUT, 2) /* (B20) 
>>>> MCASP0_ACLKX.ECAP2_IN_APWM_OUT */
>>>> +        >;
>>>> +    };
>>>> +
>>>> +    mikrobus_pwm_pins_gpio: mikrobus-pwm-gpio-pins {
>>>> +        pinctrl-single,pins = <
>>>> +            AM62X_IOPAD(0x01a4, PIN_INPUT, 7) /* (B20) 
>>>> MCASP0_ACLKX.GPIO1_11 */
>>>> +        >;
>>>> +    };
>>>> +
>>>>       mikrobus_i2c_pins_default: mikrobus-i2c-default-pins {
>>>>           pinctrl-single,pins = <
>>>>               AM62X_IOPAD(0x01d0, PIN_INPUT_PULLUP, 2) /* (A15) 
>>>> UART0_CTSn.I2C3_SCL */
>>>> @@ -394,6 +457,13 @@ AM62X_IOPAD(0x01d4, PIN_INPUT_PULLUP, 2) /* 
>>>> (B15) UART0_RTSn.I2C3_SDA */
>>>>           >;
>>>>       };
>>>>   +    mikrobus_i2c_pins_gpio: mikrobus-i2c-gpio-pins {
>>>> +        pinctrl-single,pins = <
>>>> +            AM62X_IOPAD(0x01d0, PIN_INPUT, 7) /* (A15) 
>>>> UART0_CTSn.GPIO1_22 */
>>>> +            AM62X_IOPAD(0x01d4, PIN_INPUT, 7) /* (B15) 
>>>> UART0_RTSn.GPIO1_23 */
>>>> +        >;
>>>> +    };
>>>> +
>>>>       mikrobus_uart_pins_default: mikrobus-uart-default-pins {
>>>>           pinctrl-single,pins = <
>>>>               AM62X_IOPAD(0x01d8, PIN_INPUT, 1) /* (C15) 
>>>> MCAN0_TX.UART5_RXD */
>>>> @@ -401,6 +471,13 @@ AM62X_IOPAD(0x01dc, PIN_OUTPUT, 1) /* (E15) 
>>>> MCAN0_RX.UART5_TXD */
>>>>           >;
>>>>       };
>>>>   +    mikrobus_uart_pins_gpio: mikrobus-uart-gpio-pins {
>>>> +        pinctrl-single,pins = <
>>>> +            AM62X_IOPAD(0x01d8, PIN_INPUT, 7) /* (C15) 
>>>> MCAN0_TX.GPIO1_24 */
>>>> +            AM62X_IOPAD(0x01dc, PIN_INPUT, 7) /* (E15) 
>>>> MCAN0_RX.GPIO1_25 */
>>>> +        >;
>>>> +    };
>>>> +
>>>>       mikrobus_spi_pins_default: mikrobus-spi-default-pins {
>>>>           pinctrl-single,pins = <
>>>>               AM62X_IOPAD(0x01b0, PIN_INPUT, 1) /* (A20) 
>>>> MCASP0_ACLKR.SPI2_CLK */
>>>> @@ -410,6 +487,15 @@ AM62X_IOPAD(0x0198, PIN_INPUT, 1) /* (A19) 
>>>> MCASP0_AXR2.SPI2_D1 */
>>>>           >;
>>>>       };
>>>>   +    mikrobus_spi_pins_gpio: mikrobus-spi-gpio-pins {
>>>> +        pinctrl-single,pins = <
>>>> +            AM62X_IOPAD(0x0194, PIN_INPUT, 7) /* (B19) 
>>>> MCASP0_AXR3.GPIO1_7 */
>>>> +            AM62X_IOPAD(0x0198, PIN_INPUT, 7) /* (A19) 
>>>> MCASP0_AXR2.GPIO1_8 */
>>>> +            AM62X_IOPAD(0x01ac, PIN_INPUT, 7) /* (E19) 
>>>> MCASP0_AFSR.GPIO1_13 */
>>>> +            AM62X_IOPAD(0x01b0, PIN_INPUT, 7) /* (A20) 
>>>> MCASP0_ACLKR.GPIO1_14 */
>>>> +        >;
>>>> +    };
>>>> +
>>>>       mikrobus_gpio_pins_default: mikrobus-gpio-default-pins {
>>>>           bootph-all;
>>>>           pinctrl-single,pins = <
>>>> @@ -630,8 +716,6 @@ &main_gpio0 {
>>>>     &main_gpio1 {
>>>>       bootph-all;
>>>> -    pinctrl-names = "default";
>>>> -    pinctrl-0 = <&mikrobus_gpio_pins_default>;
>>>>       gpio-line-names = "", "", "", "", "",            /* 0-4 */
>>>>           "SPE_RSTN", "SPE_INTN", "MIKROBUS_GPIO1_7",    /* 5-7 */
>>>>           "MIKROBUS_GPIO1_8", "MIKROBUS_GPIO1_9",        /* 8-9 */
>>>> @@ -804,15 +888,11 @@ it66121_out: endpoint {
>>>>   };
>>>>     &main_i2c3 {
>>>> -    pinctrl-names = "default";
>>>> -    pinctrl-0 = <&mikrobus_i2c_pins_default>;
>>>>       clock-frequency = <400000>;
>>>>       status = "okay";
>>>>   };
>>>>     &main_spi2 {
>>>> -    pinctrl-names = "default";
>>>> -    pinctrl-0 = <&mikrobus_spi_pins_default>;
>>>>       status = "okay";
>>>>   };
>>>>   @@ -876,8 +956,6 @@ &main_uart1 {
>>>>   };
>>>>     &main_uart5 {
>>>> -    pinctrl-names = "default";
>>>> -    pinctrl-0 = <&mikrobus_uart_pins_default>;
>>>>       status = "okay";
>>>>   };
>>>>
>>
>> Ayush Singh
>>

