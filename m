Return-Path: <linux-spi+bounces-3635-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F4791AD6D
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 19:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FC25B2626D
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 17:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8991B19AA46;
	Thu, 27 Jun 2024 17:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="u4FcjLQB"
X-Original-To: linux-spi@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573241993B6;
	Thu, 27 Jun 2024 17:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719508054; cv=none; b=blyWsPfuyvJ6H97U3VeFoOL1PMK/ICJO4NLkbUsvtfgqtt3hV8ccsaFVvnbBPwEaUhC4J5/ZmYVKSc6QnOiVToqE+oY0kdX8B0L+va6GmLffPhyWGoccZX1OeY9WbTGbHabdo8ZFxiccOOaPqb4tH3ImDydI0KxSosA+M2AcioA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719508054; c=relaxed/simple;
	bh=Z/c+lxJwd7UIuARllGjxVL6q+N2isc3AH0/Vo8Ni5H0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MGwZuQDaEbZ1VaY2kt8Y3vx6Ia6vtS1sxDPXcyxJAYucxLoKRQ12P9ywl08gkh0ABleKtQZO1azSbYofXSmhRirn7/Iz/I2xPubtS/ZT90vip64seyvY+mMn8yxNotDSkOJ/uyJNY/vDS89SPAwyvrToNk7PpictQAOI5B9w+5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=u4FcjLQB; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45RH7AWp063539;
	Thu, 27 Jun 2024 12:07:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719508030;
	bh=BcQL+NqV6utnh+IZGZTuEzll45Xa3ROniFOcHtO7a0s=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=u4FcjLQBTFvh17RASYvDE3PrENT7vP4PqD+ooJJuBeq1FOwEZurxyNgaweGQYF1uP
	 WZtf5SODIau9Azb05maWB2ohUa9h6n1lUkII0hhNvP9T4ohoQ9g8BA+mfOYNFvAFyk
	 pGCrKzJERNH61uGpwc3esLSP58qG1FrE/vOkO50A=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45RH7A7Q018299
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 27 Jun 2024 12:07:10 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Jun 2024 12:07:10 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Jun 2024 12:07:10 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45RH79hX030213;
	Thu, 27 Jun 2024 12:07:09 -0500
Message-ID: <4e23ec81-b278-4f2b-815d-64ed9390ca55@ti.com>
Date: Thu, 27 Jun 2024 12:07:09 -0500
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
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240627-mikrobus-scratch-spi-v5-7-9e6c148bf5f0@beagleboard.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 6/27/24 11:26 AM, Ayush Singh wrote:
> DONOTMERGE
> 
> Add mikroBUS connector and some mikroBUS boards support for Beagleplay.
> The mikroBUS boards node should probably be moved to a more appropriate
> location but I am not quite sure where it should go since it is not
> dependent on specific arch.
> 
> Signed-off-by: Ayush Singh <ayush@beagleboard.org>
> ---
>   arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts | 94 +++++++++++++++++++++++---
>   1 file changed, 86 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
> index 70de288d728e..3f3cd70345c4 100644
> --- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
> @@ -38,6 +38,7 @@ aliases {
>   		serial2 = &main_uart0;
>   		usb0 = &usb0;
>   		usb1 = &usb1;
> +		mikrobus0 = &mikrobus0;
>   	};
>   
>   	chosen {
> @@ -227,6 +228,56 @@ simple-audio-card,codec {
>   		};
>   	};
>   
> +	mikrobus0: mikrobus-connector {
> +		compatible = "mikrobus-connector";
> +		pinctrl-names = "default", "pwm_default", "pwm_gpio",
> +				"uart_default", "uart_gpio", "i2c_default",
> +				"i2c_gpio", "spi_default", "spi_gpio";
> +		pinctrl-0 = <&mikrobus_gpio_pins_default>;
> +		pinctrl-1 = <&mikrobus_pwm_pins_default>;
> +		pinctrl-2 = <&mikrobus_pwm_pins_gpio>;
> +		pinctrl-3 = <&mikrobus_uart_pins_default>;
> +		pinctrl-4 = <&mikrobus_uart_pins_gpio>;
> +		pinctrl-5 = <&mikrobus_i2c_pins_default>;
> +		pinctrl-6 = <&mikrobus_i2c_pins_gpio>;
> +		pinctrl-7 = <&mikrobus_spi_pins_default>;
> +		pinctrl-8 = <&mikrobus_spi_pins_gpio>;
> +
> +		mikrobus-gpio-names = "pwm", "int", "rx", "tx", "scl", "sda",
> +				      "mosi", "miso", "sck", "cs", "rst", "an";
> +		mikrobus-gpios = <&main_gpio1 11 GPIO_ACTIVE_HIGH>,
> +				 <&main_gpio1 9 GPIO_ACTIVE_HIGH>,
> +				 <&main_gpio1 24 GPIO_ACTIVE_HIGH>,
> +				 <&main_gpio1 25 GPIO_ACTIVE_HIGH>,
> +				 <&main_gpio1 22 GPIO_ACTIVE_HIGH>,
> +				 <&main_gpio1 23 GPIO_ACTIVE_HIGH>,
> +				 <&main_gpio1 7 GPIO_ACTIVE_HIGH>,
> +				 <&main_gpio1 8 GPIO_ACTIVE_HIGH>,
> +				 <&main_gpio1 14 GPIO_ACTIVE_HIGH>,
> +				 <&main_gpio1 13 GPIO_ACTIVE_HIGH>,
> +				 <&main_gpio1 12 GPIO_ACTIVE_HIGH>,
> +				 <&main_gpio1 10 GPIO_ACTIVE_HIGH>;
> +
> +		spi-controller = <&main_spi2>;
> +		spi-cs = <0>;
> +		spi-cs-names = "default";
> +
> +		board = <&lsm6dsl_click>;
> +	};
> +
> +	mikrobus_boards {
> +		thermo_click: thermo-click {
> +			compatible = "maxim,max31855k", "mikrobus-spi";

I might be missing something, but your solution cannot possibly be
to list every click board that could be connected (all 1500+ of them)
to every mikroBUS connector on every device's DT file..

Each click board should have a single DTSO overlay file to describe the
click board, one per click board total. And then that overlay should
apply cleanly to any device that has a mikroBUS interface.

Which means you have not completely solved the fundamental problem of
abstracting the mikroBUS connector in DT. Each of these click device child
nodes has to be under the parent connector node. Which means a phandle
to the parent node, which is not generically named. For instance
if my board has 2 connectors, I would have mikrobus0 and mikrobus1,
the click board's overlay would look like this:

/dts-v1/;
/plugin/;

&mikrobus0 {
	status = "okay";

	mikrobus_board {
		thermo-click {
			compatible = "maxim,max31855k", "mikrobus-spi";
			spi-max-frequency = <1000000>;
			pinctrl-apply = "spi_default";
		};
	};
};

I think this solution is almost there, but once you solve the above
issue, we could just apply the right overlay for our attached click
board ahead of time and not need the mikroBUS bus driver at all.

Andrew

> +			spi-max-frequency = <1000000>;
> +			pinctrl-apply = "spi_default";
> +		};
> +
> +		lsm6dsl_click: lsm6dsl-click {
> +			compatible = "st,lsm6ds3", "mikrobus-spi";
> +			spi-max-frequency = <1000000>;
> +			pinctrl-apply = "spi_default";
> +		};
> +	};
>   };
>   
>   &main_pmx0 {
> @@ -387,6 +438,18 @@ AM62X_IOPAD(0x01f0, PIN_OUTPUT, 5) /* (A18) EXT_REFCLK1.CLKOUT0 */
>   		>;
>   	};
>   
> +	mikrobus_pwm_pins_default: mikrobus-pwm-default-pins {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x01a4, PIN_INPUT, 2) /* (B20) MCASP0_ACLKX.ECAP2_IN_APWM_OUT */
> +		>;
> +	};
> +
> +	mikrobus_pwm_pins_gpio: mikrobus-pwm-gpio-pins {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x01a4, PIN_INPUT, 7) /* (B20) MCASP0_ACLKX.GPIO1_11 */
> +		>;
> +	};
> +
>   	mikrobus_i2c_pins_default: mikrobus-i2c-default-pins {
>   		pinctrl-single,pins = <
>   			AM62X_IOPAD(0x01d0, PIN_INPUT_PULLUP, 2) /* (A15) UART0_CTSn.I2C3_SCL */
> @@ -394,6 +457,13 @@ AM62X_IOPAD(0x01d4, PIN_INPUT_PULLUP, 2) /* (B15) UART0_RTSn.I2C3_SDA */
>   		>;
>   	};
>   
> +	mikrobus_i2c_pins_gpio: mikrobus-i2c-gpio-pins {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x01d0, PIN_INPUT, 7) /* (A15) UART0_CTSn.GPIO1_22 */
> +			AM62X_IOPAD(0x01d4, PIN_INPUT, 7) /* (B15) UART0_RTSn.GPIO1_23 */
> +		>;
> +	};
> +
>   	mikrobus_uart_pins_default: mikrobus-uart-default-pins {
>   		pinctrl-single,pins = <
>   			AM62X_IOPAD(0x01d8, PIN_INPUT, 1) /* (C15) MCAN0_TX.UART5_RXD */
> @@ -401,6 +471,13 @@ AM62X_IOPAD(0x01dc, PIN_OUTPUT, 1) /* (E15) MCAN0_RX.UART5_TXD */
>   		>;
>   	};
>   
> +	mikrobus_uart_pins_gpio: mikrobus-uart-gpio-pins {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x01d8, PIN_INPUT, 7) /* (C15) MCAN0_TX.GPIO1_24 */
> +			AM62X_IOPAD(0x01dc, PIN_INPUT, 7) /* (E15) MCAN0_RX.GPIO1_25 */
> +		>;
> +	};
> +
>   	mikrobus_spi_pins_default: mikrobus-spi-default-pins {
>   		pinctrl-single,pins = <
>   			AM62X_IOPAD(0x01b0, PIN_INPUT, 1) /* (A20) MCASP0_ACLKR.SPI2_CLK */
> @@ -410,6 +487,15 @@ AM62X_IOPAD(0x0198, PIN_INPUT, 1) /* (A19) MCASP0_AXR2.SPI2_D1 */
>   		>;
>   	};
>   
> +	mikrobus_spi_pins_gpio: mikrobus-spi-gpio-pins {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x0194, PIN_INPUT, 7) /* (B19) MCASP0_AXR3.GPIO1_7 */
> +			AM62X_IOPAD(0x0198, PIN_INPUT, 7) /* (A19) MCASP0_AXR2.GPIO1_8 */
> +			AM62X_IOPAD(0x01ac, PIN_INPUT, 7) /* (E19) MCASP0_AFSR.GPIO1_13 */
> +			AM62X_IOPAD(0x01b0, PIN_INPUT, 7) /* (A20) MCASP0_ACLKR.GPIO1_14 */
> +		>;
> +	};
> +
>   	mikrobus_gpio_pins_default: mikrobus-gpio-default-pins {
>   		bootph-all;
>   		pinctrl-single,pins = <
> @@ -630,8 +716,6 @@ &main_gpio0 {
>   
>   &main_gpio1 {
>   	bootph-all;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&mikrobus_gpio_pins_default>;
>   	gpio-line-names = "", "", "", "", "",			/* 0-4 */
>   		"SPE_RSTN", "SPE_INTN", "MIKROBUS_GPIO1_7",	/* 5-7 */
>   		"MIKROBUS_GPIO1_8", "MIKROBUS_GPIO1_9",		/* 8-9 */
> @@ -804,15 +888,11 @@ it66121_out: endpoint {
>   };
>   
>   &main_i2c3 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&mikrobus_i2c_pins_default>;
>   	clock-frequency = <400000>;
>   	status = "okay";
>   };
>   
>   &main_spi2 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&mikrobus_spi_pins_default>;
>   	status = "okay";
>   };
>   
> @@ -876,8 +956,6 @@ &main_uart1 {
>   };
>   
>   &main_uart5 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&mikrobus_uart_pins_default>;
>   	status = "okay";
>   };
>   
> 

