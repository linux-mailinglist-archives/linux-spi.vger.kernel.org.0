Return-Path: <linux-spi+bounces-3645-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C34C91AE7D
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 19:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6464E1C210D0
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 17:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2785619AA62;
	Thu, 27 Jun 2024 17:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BsnHw6/v"
X-Original-To: linux-spi@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E7619AA52;
	Thu, 27 Jun 2024 17:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719510650; cv=none; b=R+ucf0T0YctZP639Al76uK06P6eKjXd9EnRXP3in6+OQJetLhnXP8+JJQv31Nwd8isNr3nKMiy0y8VLkJid72hIpesdlMRiL9JERySRs6n2qkbPMkoQ1ag4uSqVKarAi8t7xCc7K5Co4gAUgYM3X5QKXFts76byzjxiSWjq3RRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719510650; c=relaxed/simple;
	bh=5+DYVdc1jwyKqj2FJNNQADhhJwSaLk7vzyjnNgeWhY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GlpYk5HcYpvPaMgwDgZDDB8vDaCsjPT4/wN8AGrvwyZ0VUTGTB6UWOSsYF1xG2/nfITdaIu0p1WgAw4FPbveKR7tmjZ+eMQV9DkhOcltOsmEYg0hy/s3ps5wC5vPxzQpLC3ClUPQ0QAVAkLwdG8+c9BLnuV5j4cV8BqiNohXZ2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BsnHw6/v; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45RHoP3c053304;
	Thu, 27 Jun 2024 12:50:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719510625;
	bh=W1+JEi//MuEReo+QxPN/FdpGCgmHxWEwWDiERGYqcxA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=BsnHw6/v62uADZitRC9WivEcPx+Y84in/FvbRxu5EJLI2N0XiOzHXaefV0D+NOIYS
	 vXYvKgGIMP9lFDlf9/Sw97396Rx35v+0VJ6xJnGrbFvlb9Pp0CL14cXQJjUhOEY4Sa
	 cUvOKExs868L2pyHCVrKZ2QxcEf4HKHS1oLRRnnU=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45RHoPtN011217
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 27 Jun 2024 12:50:25 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Jun 2024 12:50:25 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Jun 2024 12:50:25 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45RHoOGn094898;
	Thu, 27 Jun 2024 12:50:24 -0500
Message-ID: <70f28343-6738-47f2-97b5-6afa96f1fbcc@ti.com>
Date: Thu, 27 Jun 2024 12:50:24 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] dts: ti: k3-am625-beagleplay: Add mikroBUS
To: Ayush Singh <ayush@beagleboard.org>, Mark Brown <broonie@kernel.org>,
        Vaishnav M A <vaishnav@beagleboard.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Michael Walle
	<mwalle@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, <jkridner@beagleboard.org>,
        <robertcnelson@beagleboard.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20240627-mikrobus-scratch-spi-v5-0-9e6c148bf5f0@beagleboard.org>
 <20240627-mikrobus-scratch-spi-v5-7-9e6c148bf5f0@beagleboard.org>
 <4e23ec81-b278-4f2b-815d-64ed9390ca55@ti.com>
 <cef08d49-a462-4167-8b9d-bf09e8aac92f@beagleboard.org>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <cef08d49-a462-4167-8b9d-bf09e8aac92f@beagleboard.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 6/27/24 12:16 PM, Ayush Singh wrote:
> 
> On 6/27/24 22:37, Andrew Davis wrote:
>> On 6/27/24 11:26 AM, Ayush Singh wrote:
>>> DONOTMERGE
>>>
>>> Add mikroBUS connector and some mikroBUS boards support for Beagleplay.
>>> The mikroBUS boards node should probably be moved to a more appropriate
>>> location but I am not quite sure where it should go since it is not
>>> dependent on specific arch.
>>>
>>> Signed-off-by: Ayush Singh <ayush@beagleboard.org>
>>> ---
>>>   arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts | 94 +++++++++++++++++++++++---
>>>   1 file changed, 86 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
>>> index 70de288d728e..3f3cd70345c4 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
>>> +++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
>>> @@ -38,6 +38,7 @@ aliases {
>>>           serial2 = &main_uart0;
>>>           usb0 = &usb0;
>>>           usb1 = &usb1;
>>> +        mikrobus0 = &mikrobus0;
>>>       };
>>>         chosen {
>>> @@ -227,6 +228,56 @@ simple-audio-card,codec {
>>>           };
>>>       };
>>>   +    mikrobus0: mikrobus-connector {
>>> +        compatible = "mikrobus-connector";
>>> +        pinctrl-names = "default", "pwm_default", "pwm_gpio",
>>> +                "uart_default", "uart_gpio", "i2c_default",
>>> +                "i2c_gpio", "spi_default", "spi_gpio";
>>> +        pinctrl-0 = <&mikrobus_gpio_pins_default>;
>>> +        pinctrl-1 = <&mikrobus_pwm_pins_default>;
>>> +        pinctrl-2 = <&mikrobus_pwm_pins_gpio>;
>>> +        pinctrl-3 = <&mikrobus_uart_pins_default>;
>>> +        pinctrl-4 = <&mikrobus_uart_pins_gpio>;
>>> +        pinctrl-5 = <&mikrobus_i2c_pins_default>;
>>> +        pinctrl-6 = <&mikrobus_i2c_pins_gpio>;
>>> +        pinctrl-7 = <&mikrobus_spi_pins_default>;
>>> +        pinctrl-8 = <&mikrobus_spi_pins_gpio>;
>>> +
>>> +        mikrobus-gpio-names = "pwm", "int", "rx", "tx", "scl", "sda",
>>> +                      "mosi", "miso", "sck", "cs", "rst", "an";
>>> +        mikrobus-gpios = <&main_gpio1 11 GPIO_ACTIVE_HIGH>,
>>> +                 <&main_gpio1 9 GPIO_ACTIVE_HIGH>,
>>> +                 <&main_gpio1 24 GPIO_ACTIVE_HIGH>,
>>> +                 <&main_gpio1 25 GPIO_ACTIVE_HIGH>,
>>> +                 <&main_gpio1 22 GPIO_ACTIVE_HIGH>,
>>> +                 <&main_gpio1 23 GPIO_ACTIVE_HIGH>,
>>> +                 <&main_gpio1 7 GPIO_ACTIVE_HIGH>,
>>> +                 <&main_gpio1 8 GPIO_ACTIVE_HIGH>,
>>> +                 <&main_gpio1 14 GPIO_ACTIVE_HIGH>,
>>> +                 <&main_gpio1 13 GPIO_ACTIVE_HIGH>,
>>> +                 <&main_gpio1 12 GPIO_ACTIVE_HIGH>,
>>> +                 <&main_gpio1 10 GPIO_ACTIVE_HIGH>;
>>> +
>>> +        spi-controller = <&main_spi2>;
>>> +        spi-cs = <0>;
>>> +        spi-cs-names = "default";
>>> +
>>> +        board = <&lsm6dsl_click>;
>>> +    };
>>> +
>>> +    mikrobus_boards {
>>> +        thermo_click: thermo-click {
>>> +            compatible = "maxim,max31855k", "mikrobus-spi";
>>
>> I might be missing something, but your solution cannot possibly be
>> to list every click board that could be connected (all 1500+ of them)
>> to every mikroBUS connector on every device's DT file..
> 
> 
> I think you missed something. `mikrobus-boards` is not a child node of `mikrobus0`. See the `board` property in `mikrobus0`. That is what selects the board attached to the connector.
> 

That seems even worse.. That means the board file needs to know about the
attached board, which is not how DT works. It describes hardware in a
hierarchical/acyclic graph. For instance, take an I2C device, its node
is a child of the I2C bus, and has phandle pointers to the IRQ it uses
(or whatever else provider it needs). What you have here is like the
I2C bus node phandle pointing to the connected child devices.

> The `mikcrobus-boards` node itself should be moved to some independent location and included from a system that wants to support mikrobus boards. The connector will only have a phandle to the board (or boards in case a single mikroBUS board has 1 i2c and 1 spi sensor or some combination).
> 

How about providing the full/final example then (this series should be marked
as RFC as it is now has missing parts). Move the click board node into a DTSO
file and put that in a common location (click boards are common to all boards
right, so lets say in drivers/of/click for now just for the RFC).

> 
>>
>> Each click board should have a single DTSO overlay file to describe the
>> click board, one per click board total. And then that overlay should
>> apply cleanly to any device that has a mikroBUS interface.
> 
> 
> Yes, that is the goal.
> 
> 
>>
>> Which means you have not completely solved the fundamental problem of
>> abstracting the mikroBUS connector in DT. Each of these click device child
>> nodes has to be under the parent connector node. Which means a phandle
>> to the parent node, which is not generically named. For instance
>> if my board has 2 connectors, I would have mikrobus0 and mikrobus1,
>> the click board's overlay would look like this:
>>
>> /dts-v1/;
>> /plugin/;
>>
>> &mikrobus0 {
>>     status = "okay";
>>
>>     mikrobus_board {
>>         thermo-click {
>>             compatible = "maxim,max31855k", "mikrobus-spi";
>>             spi-max-frequency = <1000000>;
>>             pinctrl-apply = "spi_default";
>>         };
>>     };
>> };
> 
> 
> No, it will look as follows:
> 
> ```
> 
> &mikrobus0 {

           ^^^
So same issue, what if I want to attach this click board
to the second mikrobus connector on my board (i.e. mikrobus1),
I'd have to modify the overlay.. Or have an overlay for every
possible connector instance number.

>      status = "okay";
> 
>      board = <&thermo-click>;
> 
> };
> 
> 
> &mikrobus_board {
>          thermo-click {
>              compatible = "maxim,max31855k", "mikrobus-spi";
>              spi-max-frequency = <1000000>;
>              pinctrl-apply = "spi_default";
>          };
>    };
> 
> ```
> 
> 
>>
>> I think this solution is almost there, but once you solve the above
>> issue, we could just apply the right overlay for our attached click
>> board ahead of time and not need the mikroBUS bus driver at all.
> 
> 
> Well, the driver is still needed because some things cannot be done generically in dt. Eg:
> 
> 1. SPI chipselect. Each connector will have different chipselect number mapped to CS pin. In fact a mikrobus board might use other pins like RST as chipselect as well.
> 
> 2. Using pins other than their intended purpose like GPIO.
> 

Then these are two things you'll need to solve. We can add
these functions to the base DT/OF support if they are generic
problems (which they are, other connectors/daughterboards have
this same issue, RPi header, Seeed Grove connector, Sparkfun QWIIC
headers, etc..).

Andrew

> 
>>
>> Andrew
>>
>>> +            spi-max-frequency = <1000000>;
>>> +            pinctrl-apply = "spi_default";
>>> +        };
>>> +
>>> +        lsm6dsl_click: lsm6dsl-click {
>>> +            compatible = "st,lsm6ds3", "mikrobus-spi";
>>> +            spi-max-frequency = <1000000>;
>>> +            pinctrl-apply = "spi_default";
>>> +        };
>>> +    };
>>>   };
>>>     &main_pmx0 {
>>> @@ -387,6 +438,18 @@ AM62X_IOPAD(0x01f0, PIN_OUTPUT, 5) /* (A18) EXT_REFCLK1.CLKOUT0 */
>>>           >;
>>>       };
>>>   +    mikrobus_pwm_pins_default: mikrobus-pwm-default-pins {
>>> +        pinctrl-single,pins = <
>>> +            AM62X_IOPAD(0x01a4, PIN_INPUT, 2) /* (B20) MCASP0_ACLKX.ECAP2_IN_APWM_OUT */
>>> +        >;
>>> +    };
>>> +
>>> +    mikrobus_pwm_pins_gpio: mikrobus-pwm-gpio-pins {
>>> +        pinctrl-single,pins = <
>>> +            AM62X_IOPAD(0x01a4, PIN_INPUT, 7) /* (B20) MCASP0_ACLKX.GPIO1_11 */
>>> +        >;
>>> +    };
>>> +
>>>       mikrobus_i2c_pins_default: mikrobus-i2c-default-pins {
>>>           pinctrl-single,pins = <
>>>               AM62X_IOPAD(0x01d0, PIN_INPUT_PULLUP, 2) /* (A15) UART0_CTSn.I2C3_SCL */
>>> @@ -394,6 +457,13 @@ AM62X_IOPAD(0x01d4, PIN_INPUT_PULLUP, 2) /* (B15) UART0_RTSn.I2C3_SDA */
>>>           >;
>>>       };
>>>   +    mikrobus_i2c_pins_gpio: mikrobus-i2c-gpio-pins {
>>> +        pinctrl-single,pins = <
>>> +            AM62X_IOPAD(0x01d0, PIN_INPUT, 7) /* (A15) UART0_CTSn.GPIO1_22 */
>>> +            AM62X_IOPAD(0x01d4, PIN_INPUT, 7) /* (B15) UART0_RTSn.GPIO1_23 */
>>> +        >;
>>> +    };
>>> +
>>>       mikrobus_uart_pins_default: mikrobus-uart-default-pins {
>>>           pinctrl-single,pins = <
>>>               AM62X_IOPAD(0x01d8, PIN_INPUT, 1) /* (C15) MCAN0_TX.UART5_RXD */
>>> @@ -401,6 +471,13 @@ AM62X_IOPAD(0x01dc, PIN_OUTPUT, 1) /* (E15) MCAN0_RX.UART5_TXD */
>>>           >;
>>>       };
>>>   +    mikrobus_uart_pins_gpio: mikrobus-uart-gpio-pins {
>>> +        pinctrl-single,pins = <
>>> +            AM62X_IOPAD(0x01d8, PIN_INPUT, 7) /* (C15) MCAN0_TX.GPIO1_24 */
>>> +            AM62X_IOPAD(0x01dc, PIN_INPUT, 7) /* (E15) MCAN0_RX.GPIO1_25 */
>>> +        >;
>>> +    };
>>> +
>>>       mikrobus_spi_pins_default: mikrobus-spi-default-pins {
>>>           pinctrl-single,pins = <
>>>               AM62X_IOPAD(0x01b0, PIN_INPUT, 1) /* (A20) MCASP0_ACLKR.SPI2_CLK */
>>> @@ -410,6 +487,15 @@ AM62X_IOPAD(0x0198, PIN_INPUT, 1) /* (A19) MCASP0_AXR2.SPI2_D1 */
>>>           >;
>>>       };
>>>   +    mikrobus_spi_pins_gpio: mikrobus-spi-gpio-pins {
>>> +        pinctrl-single,pins = <
>>> +            AM62X_IOPAD(0x0194, PIN_INPUT, 7) /* (B19) MCASP0_AXR3.GPIO1_7 */
>>> +            AM62X_IOPAD(0x0198, PIN_INPUT, 7) /* (A19) MCASP0_AXR2.GPIO1_8 */
>>> +            AM62X_IOPAD(0x01ac, PIN_INPUT, 7) /* (E19) MCASP0_AFSR.GPIO1_13 */
>>> +            AM62X_IOPAD(0x01b0, PIN_INPUT, 7) /* (A20) MCASP0_ACLKR.GPIO1_14 */
>>> +        >;
>>> +    };
>>> +
>>>       mikrobus_gpio_pins_default: mikrobus-gpio-default-pins {
>>>           bootph-all;
>>>           pinctrl-single,pins = <
>>> @@ -630,8 +716,6 @@ &main_gpio0 {
>>>     &main_gpio1 {
>>>       bootph-all;
>>> -    pinctrl-names = "default";
>>> -    pinctrl-0 = <&mikrobus_gpio_pins_default>;
>>>       gpio-line-names = "", "", "", "", "",            /* 0-4 */
>>>           "SPE_RSTN", "SPE_INTN", "MIKROBUS_GPIO1_7",    /* 5-7 */
>>>           "MIKROBUS_GPIO1_8", "MIKROBUS_GPIO1_9",        /* 8-9 */
>>> @@ -804,15 +888,11 @@ it66121_out: endpoint {
>>>   };
>>>     &main_i2c3 {
>>> -    pinctrl-names = "default";
>>> -    pinctrl-0 = <&mikrobus_i2c_pins_default>;
>>>       clock-frequency = <400000>;
>>>       status = "okay";
>>>   };
>>>     &main_spi2 {
>>> -    pinctrl-names = "default";
>>> -    pinctrl-0 = <&mikrobus_spi_pins_default>;
>>>       status = "okay";
>>>   };
>>>   @@ -876,8 +956,6 @@ &main_uart1 {
>>>   };
>>>     &main_uart5 {
>>> -    pinctrl-names = "default";
>>> -    pinctrl-0 = <&mikrobus_uart_pins_default>;
>>>       status = "okay";
>>>   };
>>>
> 
> Ayush Singh
> 

