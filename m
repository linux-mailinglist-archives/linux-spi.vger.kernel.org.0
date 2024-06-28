Return-Path: <linux-spi+bounces-3671-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 379F791C3B8
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jun 2024 18:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C3A21C212C3
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jun 2024 16:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C1F1C9EB1;
	Fri, 28 Jun 2024 16:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsENvp9g"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CB31C6895;
	Fri, 28 Jun 2024 16:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719592129; cv=none; b=ALHXz+t/vBZEgMibQDRMdcN4Fg4SGamkGexrQ+g3Weq9lmXd0m4UgeCgiO6EaKFBulhhhwoAlEMmpE2GT2XwqAhkar+KLAKXtmm8yz+gHSarKxMZByKcB6WkWTLjKqQJ/wYMehdJO+Z13fMFeuqfAswuHLFMX5zvPq3M3y7iHc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719592129; c=relaxed/simple;
	bh=7vECTHfgeCEAWexnrrbGDmKKQAj38//6iVmI7aX727k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzZWg74DjUkX88hLDz3wRfZoibIOvCk42T9Qzz9BuRj8Cx0kfZzqookJ8Li9QB5d7jFLrteMuIC6hvsAjWfa3vGEgrWpIpE1gDHUQoAAqSMbtTKH8Drwwjb8O8FRLNL+z4DZrKIYFHQY0dQS0WYh2mzevXqly2adUa0gB+tqF1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsENvp9g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6513C116B1;
	Fri, 28 Jun 2024 16:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719592129;
	bh=7vECTHfgeCEAWexnrrbGDmKKQAj38//6iVmI7aX727k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WsENvp9g4AVpEH3ObIr3mnX5XmJgybRNO+U/vQgSrSSpIIiCOWCuTTdb6Z/dN4vNp
	 babGkHdiTjh5RWugOThE4CQfxH369QlRPwt6ggF0cFGsvb1ihGMXFOXAmbYe2G7Yac
	 1SNycbL5UoD4kmoycuFBO8qpAzSPJ19MlTe4J8tehDv46gt9Ss1M1RJC7HOUEaltD2
	 wBj8Oo/9Sc0lxzZ67D2qKyTEv4DLG2bZxIvNiwjJeESF+eizDyifW+0LIkzMazAHJa
	 loXJ1W91pEy+itggIfADVe88AvqCzM3XXNk+Oef23vXRo99pCezhIWvGZpYFrC4x91
	 eiN92hhxBKeWA==
Date: Fri, 28 Jun 2024 10:28:47 -0600
From: Rob Herring <robh@kernel.org>
To: Ayush Singh <ayush@beagleboard.org>
Cc: Mark Brown <broonie@kernel.org>,
	Vaishnav M A <vaishnav@beagleboard.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Michael Walle <mwalle@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>, jkridner@beagleboard.org,
	robertcnelson@beagleboard.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 1/7] dt-bindings: connector: Add mikrobus-connector
Message-ID: <20240628162847.GB3143032-robh@kernel.org>
References: <20240627-mikrobus-scratch-spi-v5-0-9e6c148bf5f0@beagleboard.org>
 <20240627-mikrobus-scratch-spi-v5-1-9e6c148bf5f0@beagleboard.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627-mikrobus-scratch-spi-v5-1-9e6c148bf5f0@beagleboard.org>

On Thu, Jun 27, 2024 at 09:56:11PM +0530, Ayush Singh wrote:
> Add DT bindings for mikroBUS interface. MikroBUS is an open standard
> developed by MikroElektronika for connecting add-on boards to
> microcontrollers or microprocessors.
> 
> mikroBUS is a connector and does not have a controller. Instead the
> software is responsible for identification of board and setting up uart,
> spi, i2c, pwm and other buses. Additionally, some new mikroBUS boards
> contain 1-wire EEPROM that contains a manifest to describe the addon
> board to provide plug and play capabilities.
> 
> A mikroBUS addon board is free to leave some of the pins unused which
> are marked as NC or Not Connected.
> 
> Some of the pins might need to be configured as GPIOs deviating from their
> reserved purposes Eg: SHT15 Click where the SCL and SDA Pins need to be
> configured as GPIOs for the driver (drivers/hwmon/sht15.c) to work.
> 
> For some add-on boards the driver may not take care of some additional
> signals like reset/wake-up/other. Eg: ENC28J60 click where the reset line
> (RST pin on the mikrobus port) needs to be pulled high.
> 
> Some SPI addon boards use other pins like RST, AN etc as chipselect (eg.
> SPI Extend Click). Thus, `spi-cs` and `spi-cs-names` property is added
> to allow mikroBUS addon board to specify chipselect by name.
> 
> Here's the list of pins in mikroBUS connector:
> AN - Analog
> RST - Reset
> CS - SPI Chip Select
> SCK - SPI Clock
> MISO - SPI Master Input Slave Output
> MOSI - SPI Master Output Slave Input
> +3.3V - VCC-3.3V power
> GND - Reference Ground
> PWM - PWM output
> INT - Hardware Interrupt
> RX - UART Receive
> TX - UART Transmit
> SCL - I2C Clock
> SDA - I2C Data
> +5V - VCC-5V power
> GND - Reference Ground
> 
> Link: https://www.mikroe.com/mikrobus
> Link:
> https://download.mikroe.com/documents/standards/mikrobus/mikrobus-standard-specification-v200.pdf
> mikroBUS specification
> Link: https://www.mikroe.com/sht1x-click SHT15 Click
> Link: https://www.mikroe.com/eth-click ENC28J60 Click
> Link: https://www.mikroe.com/spi-extend-click SPI Extend Click
> 
> Co-developed-by: Vaishnav M A <vaishnav@beagleboard.org>
> Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
> Signed-off-by: Ayush Singh <ayush@beagleboard.org>
> ---
>  .../bindings/connector/mikrobus-connector.yaml     | 107 +++++++++++++++++++++
>  MAINTAINERS                                        |   6 ++
>  2 files changed, 113 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/connector/mikrobus-connector.yaml b/Documentation/devicetree/bindings/connector/mikrobus-connector.yaml
> new file mode 100644
> index 000000000000..033479f8604f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/connector/mikrobus-connector.yaml
> @@ -0,0 +1,107 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/connector/mikrobus-connector.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: mikroBUS add-on board connector
> +
> +maintainers:
> +  - Ayush Singh <ayush@beagleboard.org>
> +
> +properties:
> +  compatible:
> +    const: mikrobus-connector
> +
> +  pinctrl-0: true
> +  pinctrl-1: true
> +  pinctrl-2: true
> +  pinctrl-3: true
> +  pinctrl-4: true
> +  pinctrl-5: true
> +  pinctrl-6: true
> +  pinctrl-7: true
> +  pinctrl-8: true
> +
> +  pinctrl-names:
> +    minItems: 1
> +    maxItems: 9
> +    items:
> +      enum: [default, pwm_default, pwm_gpio, uart_default, uart_gpio, i2c_default, i2c_gpio, spi_default,
> +             spi_gpio]

Generally, each pinctrl-N is mutually exclusive. It looks like here you 
want multiple states active at one time. Does this work?

> +
> +  spi-controller:
> +    description: spi-controller of mikroBUS SPI pins along with cs pins.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  spi-cs:
> +    description: spi chip-select corresponding to the chip-selects on the mikrobus socket.

Wrap lines at 80 char.

The array index is the chip-select number on the connector and the 
value is the host SPI controller CS numbers? Or the other way around? 
This needs a better description.

> +    $ref: /schemas/types.yaml#/definitions/uint32-array

Maximum number of entries? 

> +
> +  spi-cs-names:
> +    minItems: 1
> +    maxItems: 12
> +    items:
> +      enum: [default, pwm, int, rx, tx, scl, sda, an, rst, sck, cipo, copi]
> +
> +  i2c-controller:
> +    description: i2c controller attached to the mikrobus socket.
> +    $ref: /schemas/types.yaml#/definitions/phandle

i2c-bus is the somewhat standard property for this.

Really, I'd expect connectors to look something like this:

connector {
  i2c-0 {
    i2c-bus = <&i2c3>;
    #address-cells = <1>;
    #size-cells = <0>;
    device@12 {
      compatible = "some-i2c-device";
    };
  };
};

That form allows for multiple buses (of the same type or different) on 
the connector.

> +
> +  uart-controller:
> +    description: uart controller attached to the mikrobus socket
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  pwms:
> +    description: the pwm-controller corresponding to the mikroBUS PWM pin.
> +    maxItems: 1
> +
> +  mikrobus-gpios:
> +    minItems: 1
> +    maxItems: 12
> +
> +  mikrobus-gpio-names:

The GPIO binding does not work this way as the name is in the property. 
Either drop if you want to keep the array or you have to do something 
like this:

pwm-gpios
int-gpios
rx-gpios

Really, the intention was for connectors to use gpio-map property to 
renumber GPIOs relative to the connector.

> +    minItems: 1
> +    maxItems: 12
> +    items:
> +      enum: [pwm, int, rx, tx, scl, sda, an, rst, cs, sck, cipo, copi]
> +
> +  board:
> +    description: board attached to mikrobus connector
> +    $ref: /schemas/types.yaml#/definitions/phandle-array

What is this for?

> +
> +required:
> +  - compatible
> +  - pinctrl-0
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    mikrobus {
> +      compatible = "mikrobus-connector";
> +      pinctrl-names = "default", "pwm_default", "pwm_gpio","uart_default", "uart_gpio", "i2c_default",
> +                      "i2c_gpio", "spi_default", "spi_gpio";
> +      pinctrl-0 = <&P2_03_gpio_input_pin &P1_04_gpio_pin &P1_02_gpio_pin>;
> +      pinctrl-1 = <&P2_01_pwm_pin>;
> +      pinctrl-2 = <&P2_01_gpio_pin>;
> +      pinctrl-3 = <&P2_05_uart_pin &P2_07_uart_pin>;
> +      pinctrl-4 = <&P2_05_gpio_pin &P2_07_gpio_pin>;
> +      pinctrl-5 = <&P2_09_i2c_pin &P2_11_i2c_pin>;
> +      pinctrl-6 = <&P2_09_gpio_pin &P2_11_gpio_pin>;
> +      pinctrl-7 = <&P1_12_spi_pin &P1_10_spi_pin &P1_08_spi_sclk_pin &P1_06_spi_cs_pin>;
> +      pinctrl-8 = <&P1_12_gpio_pin &P1_10_gpio_pin &P1_08_gpio_pin &P1_06_gpio_pin>;
> +      pwms = <&ehrpwm1 0 500000 0>;
> +      i2c-controller = <&i2c1>;
> +      uart-controller = <&uart1>;
> +      spi-controller = <&spi1>;
> +      spi-cs = <0 1>;
> +      spi-cs-names = "default", "rst";
> +      mikrobus-gpios = <&gpio1 18 GPIO_ACTIVE_HIGH>, <&gpio0 23 GPIO_ACTIVE_HIGH>,
> +                       <&gpio0 30 GPIO_ACTIVE_HIGH>, <&gpio0 31 GPIO_ACTIVE_HIGH>,
> +                       <&gpio0 15 GPIO_ACTIVE_HIGH>, <&gpio0 14 GPIO_ACTIVE_HIGH>,
> +                       <&gpio0 4 GPIO_ACTIVE_HIGH>, <&gpio0 3 GPIO_ACTIVE_HIGH>,
> +                       <&gpio0 2 GPIO_ACTIVE_HIGH>, <&gpio0 5 GPIO_ACTIVE_HIGH>,
> +                       <&gpio2 25 GPIO_ACTIVE_HIGH>, <&gpio2 3 GPIO_ACTIVE_HIGH>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 807feae089c4..8e4115e93aeb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15108,6 +15108,12 @@ M:	Oliver Neukum <oliver@neukum.org>
>  S:	Maintained
>  F:	drivers/usb/image/microtek.*
>  
> +MIKROBUS
> +M:	Ayush Singh <ayush@beagleboard.org>
> +M:	Vaishnav M A <vaishnav@beagleboard.org>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/connector/mikrobus-connector.yaml
> +
>  MIKROTIK CRS3XX 98DX3236 BOARD SUPPORT
>  M:	Luka Kovacic <luka.kovacic@sartura.hr>
>  M:	Luka Perkov <luka.perkov@sartura.hr>
> 
> -- 
> 2.45.2
> 

