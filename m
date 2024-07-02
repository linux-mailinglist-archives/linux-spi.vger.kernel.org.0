Return-Path: <linux-spi+bounces-3723-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8690192420D
	for <lists+linux-spi@lfdr.de>; Tue,  2 Jul 2024 17:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 430F928773D
	for <lists+linux-spi@lfdr.de>; Tue,  2 Jul 2024 15:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C65F1BBBF2;
	Tue,  2 Jul 2024 15:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="z8n7hzcd"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA03A1BB6A9
	for <linux-spi@vger.kernel.org>; Tue,  2 Jul 2024 15:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719933278; cv=none; b=rLmZuGQHyhtmsd0OPZFlTpinmpmAGLNausUVkskChPnZuRc0+0lYrZpHvjI2SbsKF1NBlGmrTIl4aILQN2Q1SCCuvPDxsEj+un9ejZRE4oEkEe9WH37w+qvID9UrI01uBam9CR8omNN4mw6JIuCk69oqSfJ2Rpkfm2hFnksVMJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719933278; c=relaxed/simple;
	bh=lAKxpi+yfnASAw2FOzTRlbGNS3WZuUFb3JJr/dxhgX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T8EIqVpAaCWxGh/RV0YWlExbDb/E8NlVtAxUrKyREP0vV9El9Vq5PfrNt4h8aAZQVmNThOhmbmH73LH1UzDUgF81rdFUX/BiS6p/WoHYZBnxNcGwjwypt2tPwVp0w0nu+mjGVtchq/EBN873zDucak1KZcgSPIYHAxmLx0SwRcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=z8n7hzcd; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70811f7ab8eso213409b3a.1
        for <linux-spi@vger.kernel.org>; Tue, 02 Jul 2024 08:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1719933275; x=1720538075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=40y+5BRfzL+FmyMl+NaBXpaqof6Uf0lBwHh7rgKeu84=;
        b=z8n7hzcdgRewvWCmfvyySqBrO59Sp2/tKJgMZ8HaRvsxpfGnqrBx/YRC5CmAhjEsei
         ACKdb6YSgn0aY90bBb870ijFDrlt4Sl/ENN327Z9oKTkOOU6RgA2Qu8+BgYG44TTVQ7J
         VfGl3QbqD1oW0Fl27Gx8/Tp3rJ9NoGOllSAQ4ocWUdLjQZpgqgZ6AfpG2kO45HrxZGJP
         PBUSWJ7RsWhCxf7kMe11WI7Adnd4ae+GE0W2klpMouUSfgUrIe+AhPS0mRg/vr/Vtmpm
         DASSB0F4RLVfudsRRijVrDlLGMSJARfEl/S63X5XJGWTGPvFpn9SFgj2jLHcloBt1irc
         yS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719933275; x=1720538075;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=40y+5BRfzL+FmyMl+NaBXpaqof6Uf0lBwHh7rgKeu84=;
        b=TiFdXplyBVdlaSkKy8tfuLTqFs7BxHMonqAL38fNOyQeCuPhzTfsXCjQAv5pC5ZIk3
         JsdE9f2t/nt/k9lEnc08j3m9rEBPcOuTQ2J3wXw3od4eJGm7BJbOu/CJCplKcplhaemn
         XxT834GttAcs4URn7W7InpeX/5RYlCleHppaxseHVC7IN+ukf5rgBLoIIV9TNVZIcMp+
         IRKVAl3fRAlmrRbPPgLDzI07/pmP4YdDzvzEss55oAEogu0kgwDylWDWGYy2rXTABtiw
         nPenVQJ4ZwhIUa4fPqqdV0X4SxqpoTCiQGel05r6NdkQW2uI8Xa8uUlG5Pqd4Gk3Dpfl
         yAyg==
X-Forwarded-Encrypted: i=1; AJvYcCWRVS2vCGIpUq2MVXMQ/sCoXVS4gQDEEximTlPmDME/H2olA5Yhg0NbeYOrBZOCbjDuvrLD4JHUdkMAamnq3NxANZwQjKxrj5QX
X-Gm-Message-State: AOJu0YyKQP4I9V56xtiOQH7sC065BUIYVZhuNwgF8zKHrS4pzotm2Vam
	AquUTGNLRdx97nbx7rE7jsIkC7W3X+CkZriLihselIqs6tSXoBGKGrzMNLd3Vw==
X-Google-Smtp-Source: AGHT+IGfkdugJ7YGFtiPng9vy9soC8SqEosCYrLRvR+3ezTFRsZrIFvas0chO/NoRq0eP50UvRjOeQ==
X-Received: by 2002:a05:6a20:748e:b0:1be:dfe8:1311 with SMTP id adf61e73a8af0-1bef62987demr11534315637.6.1719933273589;
        Tue, 02 Jul 2024 08:14:33 -0700 (PDT)
Received: from ?IPV6:2401:4900:1f3e:250a:7d55:4ad6:87a3:5c5c? ([2401:4900:1f3e:250a:7d55:4ad6:87a3:5c5c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080256916dsm8620152b3a.57.2024.07.02.08.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 08:14:33 -0700 (PDT)
Message-ID: <61649bee-f7dc-452c-beb5-cc8ee2179b99@beagleboard.org>
Date: Tue, 2 Jul 2024 20:44:26 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] dt-bindings: connector: Add mikrobus-connector
To: Rob Herring <robh@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Vaishnav M A <vaishnav@beagleboard.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Derek Kiernan <derek.kiernan@amd.com>,
 Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Michael Walle <mwalle@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 jkridner@beagleboard.org, robertcnelson@beagleboard.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240627-mikrobus-scratch-spi-v5-0-9e6c148bf5f0@beagleboard.org>
 <20240627-mikrobus-scratch-spi-v5-1-9e6c148bf5f0@beagleboard.org>
 <20240628162847.GB3143032-robh@kernel.org>
Content-Language: en-US
From: Ayush Singh <ayush@beagleboard.org>
In-Reply-To: <20240628162847.GB3143032-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/28/24 21:58, Rob Herring wrote:

> On Thu, Jun 27, 2024 at 09:56:11PM +0530, Ayush Singh wrote:
>> Add DT bindings for mikroBUS interface. MikroBUS is an open standard
>> developed by MikroElektronika for connecting add-on boards to
>> microcontrollers or microprocessors.
>>
>> mikroBUS is a connector and does not have a controller. Instead the
>> software is responsible for identification of board and setting up uart,
>> spi, i2c, pwm and other buses. Additionally, some new mikroBUS boards
>> contain 1-wire EEPROM that contains a manifest to describe the addon
>> board to provide plug and play capabilities.
>>
>> A mikroBUS addon board is free to leave some of the pins unused which
>> are marked as NC or Not Connected.
>>
>> Some of the pins might need to be configured as GPIOs deviating from their
>> reserved purposes Eg: SHT15 Click where the SCL and SDA Pins need to be
>> configured as GPIOs for the driver (drivers/hwmon/sht15.c) to work.
>>
>> For some add-on boards the driver may not take care of some additional
>> signals like reset/wake-up/other. Eg: ENC28J60 click where the reset line
>> (RST pin on the mikrobus port) needs to be pulled high.
>>
>> Some SPI addon boards use other pins like RST, AN etc as chipselect (eg.
>> SPI Extend Click). Thus, `spi-cs` and `spi-cs-names` property is added
>> to allow mikroBUS addon board to specify chipselect by name.
>>
>> Here's the list of pins in mikroBUS connector:
>> AN - Analog
>> RST - Reset
>> CS - SPI Chip Select
>> SCK - SPI Clock
>> MISO - SPI Master Input Slave Output
>> MOSI - SPI Master Output Slave Input
>> +3.3V - VCC-3.3V power
>> GND - Reference Ground
>> PWM - PWM output
>> INT - Hardware Interrupt
>> RX - UART Receive
>> TX - UART Transmit
>> SCL - I2C Clock
>> SDA - I2C Data
>> +5V - VCC-5V power
>> GND - Reference Ground
>>
>> Link: https://www.mikroe.com/mikrobus
>> Link:
>> https://download.mikroe.com/documents/standards/mikrobus/mikrobus-standard-specification-v200.pdf
>> mikroBUS specification
>> Link: https://www.mikroe.com/sht1x-click SHT15 Click
>> Link: https://www.mikroe.com/eth-click ENC28J60 Click
>> Link: https://www.mikroe.com/spi-extend-click SPI Extend Click
>>
>> Co-developed-by: Vaishnav M A <vaishnav@beagleboard.org>
>> Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
>> Signed-off-by: Ayush Singh <ayush@beagleboard.org>
>> ---
>>   .../bindings/connector/mikrobus-connector.yaml     | 107 +++++++++++++++++++++
>>   MAINTAINERS                                        |   6 ++
>>   2 files changed, 113 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/connector/mikrobus-connector.yaml b/Documentation/devicetree/bindings/connector/mikrobus-connector.yaml
>> new file mode 100644
>> index 000000000000..033479f8604f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/connector/mikrobus-connector.yaml
>> @@ -0,0 +1,107 @@
>> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/connector/mikrobus-connector.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: mikroBUS add-on board connector
>> +
>> +maintainers:
>> +  - Ayush Singh <ayush@beagleboard.org>
>> +
>> +properties:
>> +  compatible:
>> +    const: mikrobus-connector
>> +
>> +  pinctrl-0: true
>> +  pinctrl-1: true
>> +  pinctrl-2: true
>> +  pinctrl-3: true
>> +  pinctrl-4: true
>> +  pinctrl-5: true
>> +  pinctrl-6: true
>> +  pinctrl-7: true
>> +  pinctrl-8: true
>> +
>> +  pinctrl-names:
>> +    minItems: 1
>> +    maxItems: 9
>> +    items:
>> +      enum: [default, pwm_default, pwm_gpio, uart_default, uart_gpio, i2c_default, i2c_gpio, spi_default,
>> +             spi_gpio]
> Generally, each pinctrl-N is mutually exclusive. It looks like here you
> want multiple states active at one time. Does this work?

I see. In mikrobus case, these pinctrl are not mutually exclusive. The 
ones that are mutually exclusive are as follows:

- pwm_default and pwm_gpio

- uart_default and uart_gpio

- i2c_default and i2c_gpio

- spi_default and spi_gpio


It still does lead to 16 combinations so not sure if it is the best 
approach.

>> +
>> +  spi-controller:
>> +    description: spi-controller of mikroBUS SPI pins along with cs pins.
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +
>> +  spi-cs:
>> +    description: spi chip-select corresponding to the chip-selects on the mikrobus socket.
> Wrap lines at 80 char.
>
> The array index is the chip-select number on the connector and the
> value is the host SPI controller CS numbers? Or the other way around?
> This needs a better description.
>
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> Maximum number of entries?
>
>> +
>> +  spi-cs-names:
>> +    minItems: 1
>> +    maxItems: 12
>> +    items:
>> +      enum: [default, pwm, int, rx, tx, scl, sda, an, rst, sck, cipo, copi]
>> +
>> +  i2c-controller:
>> +    description: i2c controller attached to the mikrobus socket.
>> +    $ref: /schemas/types.yaml#/definitions/phandle
> i2c-bus is the somewhat standard property for this.
>
> Really, I'd expect connectors to look something like this:
>
> connector {
>    i2c-0 {
>      i2c-bus = <&i2c3>;
>      #address-cells = <1>;
>      #size-cells = <0>;
>      device@12 {
>        compatible = "some-i2c-device";
>      };
>    };
> };
>
> That form allows for multiple buses (of the same type or different) on
> the connector.
>
>> +
>> +  uart-controller:
>> +    description: uart controller attached to the mikrobus socket
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +
>> +  pwms:
>> +    description: the pwm-controller corresponding to the mikroBUS PWM pin.
>> +    maxItems: 1
>> +
>> +  mikrobus-gpios:
>> +    minItems: 1
>> +    maxItems: 12
>> +
>> +  mikrobus-gpio-names:
> The GPIO binding does not work this way as the name is in the property.
> Either drop if you want to keep the array or you have to do something
> like this:
>
> pwm-gpios
> int-gpios
> rx-gpios
>
> Really, the intention was for connectors to use gpio-map property to
> renumber GPIOs relative to the connector.

Can you point me to what you mean by gpio-map property?

>> +    minItems: 1
>> +    maxItems: 12
>> +    items:
>> +      enum: [pwm, int, rx, tx, scl, sda, an, rst, cs, sck, cipo, copi]
>> +
>> +  board:
>> +    description: board attached to mikrobus connector
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> What is this for?
>
>> +
>> +required:
>> +  - compatible
>> +  - pinctrl-0
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +    mikrobus {
>> +      compatible = "mikrobus-connector";
>> +      pinctrl-names = "default", "pwm_default", "pwm_gpio","uart_default", "uart_gpio", "i2c_default",
>> +                      "i2c_gpio", "spi_default", "spi_gpio";
>> +      pinctrl-0 = <&P2_03_gpio_input_pin &P1_04_gpio_pin &P1_02_gpio_pin>;
>> +      pinctrl-1 = <&P2_01_pwm_pin>;
>> +      pinctrl-2 = <&P2_01_gpio_pin>;
>> +      pinctrl-3 = <&P2_05_uart_pin &P2_07_uart_pin>;
>> +      pinctrl-4 = <&P2_05_gpio_pin &P2_07_gpio_pin>;
>> +      pinctrl-5 = <&P2_09_i2c_pin &P2_11_i2c_pin>;
>> +      pinctrl-6 = <&P2_09_gpio_pin &P2_11_gpio_pin>;
>> +      pinctrl-7 = <&P1_12_spi_pin &P1_10_spi_pin &P1_08_spi_sclk_pin &P1_06_spi_cs_pin>;
>> +      pinctrl-8 = <&P1_12_gpio_pin &P1_10_gpio_pin &P1_08_gpio_pin &P1_06_gpio_pin>;
>> +      pwms = <&ehrpwm1 0 500000 0>;
>> +      i2c-controller = <&i2c1>;
>> +      uart-controller = <&uart1>;
>> +      spi-controller = <&spi1>;
>> +      spi-cs = <0 1>;
>> +      spi-cs-names = "default", "rst";
>> +      mikrobus-gpios = <&gpio1 18 GPIO_ACTIVE_HIGH>, <&gpio0 23 GPIO_ACTIVE_HIGH>,
>> +                       <&gpio0 30 GPIO_ACTIVE_HIGH>, <&gpio0 31 GPIO_ACTIVE_HIGH>,
>> +                       <&gpio0 15 GPIO_ACTIVE_HIGH>, <&gpio0 14 GPIO_ACTIVE_HIGH>,
>> +                       <&gpio0 4 GPIO_ACTIVE_HIGH>, <&gpio0 3 GPIO_ACTIVE_HIGH>,
>> +                       <&gpio0 2 GPIO_ACTIVE_HIGH>, <&gpio0 5 GPIO_ACTIVE_HIGH>,
>> +                       <&gpio2 25 GPIO_ACTIVE_HIGH>, <&gpio2 3 GPIO_ACTIVE_HIGH>;
>> +    };
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 807feae089c4..8e4115e93aeb 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -15108,6 +15108,12 @@ M:	Oliver Neukum <oliver@neukum.org>
>>   S:	Maintained
>>   F:	drivers/usb/image/microtek.*
>>   
>> +MIKROBUS
>> +M:	Ayush Singh <ayush@beagleboard.org>
>> +M:	Vaishnav M A <vaishnav@beagleboard.org>
>> +S:	Maintained
>> +F:	Documentation/devicetree/bindings/connector/mikrobus-connector.yaml
>> +
>>   MIKROTIK CRS3XX 98DX3236 BOARD SUPPORT
>>   M:	Luka Kovacic <luka.kovacic@sartura.hr>
>>   M:	Luka Perkov <luka.perkov@sartura.hr>
>>
>> -- 
>> 2.45.2
>>

I am switching to child-node based structure from the next patch since I 
was able to replicate applying board overlay on a generic connector with 
child node.


Ayush Singh


