Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E4A2AA5DE
	for <lists+linux-spi@lfdr.de>; Sat,  7 Nov 2020 15:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgKGON7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Nov 2020 09:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbgKGON7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 Nov 2020 09:13:59 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1575AC0613CF;
        Sat,  7 Nov 2020 06:13:59 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id i21so3812765qka.12;
        Sat, 07 Nov 2020 06:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NzYy1LtL05J+f3k4sc0Q/1hCUu7hluh0CcBU+0F4FaY=;
        b=Bma4JUnI3BnPsW2CBKW85yW9qxBF8unj29jVGCE6ADKEf4l4VmlY+n2MIxMbjstSDL
         UG8NOWbebGHK3LLKEjLFa1bXOqIshF0Yz4PfsM/zbMfy/JDXmyynRh9RR/rLF0j3CtQt
         XDE3Q3jHtdhyMOrU8Mh4VPfLj5dB7OuxAj9KWxfwH3iSqG0NMLZgJlmi+HJt0eMKy4kq
         P+F/zuhKNKNS+RW4BHLXPwpLf+YzgLGfYsTUt4IMeEx6H0IuPYn+Nxel719SQiOSOq22
         FI8BFPR/CGb7y5MQBRak/igTYmFvFUfzDPCR3xTVWHOZ/GvnYlkvpimE/jGSLD81u2Dl
         ejgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NzYy1LtL05J+f3k4sc0Q/1hCUu7hluh0CcBU+0F4FaY=;
        b=jEFwRMp2DnRV5Uh3VzEfot9Mx/VMFL/hQHC6vIWGdX2/ZoGaYJmjFBCQyxZasM0jvd
         kCkCFSbqjiG6NVcxs+aOsqtpWBjsBu1qcBokLKWRRY7Qg4QgR5bnthoKNUI3Gp62gsnU
         wW129iQE6DWP9E2UTtnkFqGP8vpafD/N/J9Slrty+TXOPPuqQGjuJyh+tgiNfk2o/cad
         DAEvRK48NC/ziJT7w/GV+Kuc7vGQvJAdX7yKkyjwv/hPx1cYN001j8nyfZfLXIOKobbr
         LslVomSnACMz4/5z1iIud2ITuRfQFr6FOLAYFY7nOuDahaa1N/vNU8VVgIInzNn28D1S
         /w2A==
X-Gm-Message-State: AOAM532gYqm87CuTfQsWFdMA2N/qgVsrtR+tYJk90E9gF+k3IgWF2wpX
        hxDisbIZW6JAgyezq1sRkQM=
X-Google-Smtp-Source: ABdhPJz+AedJ/98xlqSZ/v9w1xXSwYQXbW9OPgE1XUqILz6+TSYlOxij0s13ylUHsqUbhO+RJq4woA==
X-Received: by 2002:a37:4692:: with SMTP id t140mr6363203qka.275.1604758438054;
        Sat, 07 Nov 2020 06:13:58 -0800 (PST)
Received: from [192.168.1.201] (pool-108-51-35-162.washdc.fios.verizon.net. [108.51.35.162])
        by smtp.googlemail.com with ESMTPSA id x4sm2527358qtm.48.2020.11.07.06.13.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Nov 2020 06:13:57 -0800 (PST)
Subject: Re: [PATCH 27/32] riscv: Add SiPeed MAIX BiT board device tree
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-28-damien.lemoal@wdc.com>
From:   Sean Anderson <seanga2@gmail.com>
Autocrypt: addr=seanga2@gmail.com; prefer-encrypt=mutual; keydata=
 mQENBFe74PkBCACoLC5Zq2gwrDcCkr+EPGsT14bsxrW07GiYzQhLCgwnPdEpgU95pXltbFhw
 46GfyffABWxHKO2x+3L1S6ZxC5AiKbYXo7lpnTBYjamPWYouz+VJEVjUx9aaSEByBah5kX6a
 lKFZWNbXLAJh+dE1HFaMi3TQXXaInaREc+aO1F7fCa2zNE75ja+6ah8L4TPRFZ2HKQzve0/Y
 GXtoRw97qmnm3U36vKWT/m2AiLF619F4T1mHvlfjyd9hrVwjH5h/2rFyroXVXBZHGA9Aj8eN
 F2si35dWSZlIwXkNu9bXp0/pIu6FD0bI+BEkD5S7aH1G1iAcMFi5Qq2RNa041DfQSDDHABEB
 AAG0K1NlYW4gR2FsbGFnaGVyIEFuZGVyc29uIDxzZWFuZ2EyQGdtYWlsLmNvbT6JAVcEEwEK
 AEECGwMFCwkIBwIGFQgJCgsCBBYCAwECHgECF4ACGQEWIQSQYR1bzo1I0gPoYCg+6I/stKEQ
 bgUCXT+S2AUJB2TlXwAKCRA+6I/stKEQbhNOB/9ooea0hU9Sgh7PBloU6CgaC5mlqPLB7NTp
 +JkB+nh3Fqhk+qLZwzEynnuDLl6ESpVHIc0Ym1lyF4gT3DsrlGT1h0Gzw7vUwd1+ZfN0CuIx
 Rn861U/dAUjvbtN5kMBqOI4/5ea+0r7MACcIVnKF/wMXBD8eypHsorT2sJTzwZ6DRCNP70C5
 N1ahpqqNmXe0uLdP0pu55JCqhrGw2SinkRMdWyhSxT56uNwIVHGhLTqH7Q4t1N6G1EH626qa
 SvIJsWlNpll6Y3AYLDw2/Spw/hqieS2PQ/Ky3rPZnvJt7/aSNYsKoFGX0yjkH67Uq8Lx0k1L
 w8jpXnbEPQN3A2ZJCbeM
Message-ID: <a516b391-9cb9-8ab9-7735-d39faa94882f@gmail.com>
Date:   Sat, 7 Nov 2020 09:13:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201107081420.60325-28-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 11/7/20 3:14 AM, Damien Le Moal wrote:
> Add a device tree for the SiPeed MAIX BiT and MAIX BiTm boards. This
> device tree enables LEDs, gpio, i2c and spi/mmc SD card devices.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  .../riscv/boot/dts/kendryte/k210_maix_bit.dts | 226 ++++++++++++++++++
>  1 file changed, 226 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/kendryte/k210_maix_bit.dts
> 
> diff --git a/arch/riscv/boot/dts/kendryte/k210_maix_bit.dts b/arch/riscv/boot/dts/kendryte/k210_maix_bit.dts
> new file mode 100644
> index 000000000000..fc814f7c1173
> --- /dev/null
> +++ b/arch/riscv/boot/dts/kendryte/k210_maix_bit.dts
> @@ -0,0 +1,226 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2019-20 Sean Anderson <seanga2@gmail.com>
> + * Copyright (C) 2020 Western Digital Corporation or its affiliates.
> + */
> +
> +/dts-v1/;
> +
> +#include "k210.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +
> +/ {
> +	model = "SiPeed MAIX BiT";
> +	compatible = "sipeed,maix-bitm", "sipeed,maix-bit",
> +		     "kendryte,k210";
> +
> +	chosen {
> +		bootargs = "earlycon console=ttySIF0";
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	gpio-leds {
> +		compatible = "gpio-leds";
> +
> +		green {
> +			gpios = <&gpio1_0 4 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		red {
> +			gpios = <&gpio1_0 5 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		blue {
> +			gpios = <&gpio1_0 6 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		boot {
> +			label = "BOOT";
> +			linux,code = <BTN_0>;
> +			gpios = <&gpio0 0 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,format = "i2s";
> +		status = "disabled";
> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&i2s0 0>;
> +		};
> +
> +		simple-audio-card,codec {
> +			sound-dai = <&mic>;
> +		};
> +	};
> +
> +	mic: mic {
> +		#sound-dai-cells = <0>;
> +		compatible = "memsensing,msm261s4030h0";
> +		status = "disabled";
> +	};
> +};
> +
> +&fpioa {
> +	pinctrl-0 = <&fpioa_jtag>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	fpioa_jtag: jtag {
> +		pinmux = <K210_FPIOA(0, K210_PCF_JTAG_TCLK)>,
> +			 <K210_FPIOA(1, K210_PCF_JTAG_TDI)>,
> +			 <K210_FPIOA(2, K210_PCF_JTAG_TMS)>,
> +			 <K210_FPIOA(3, K210_PCF_JTAG_TDO)>;
> +	};
> +
> +	fpioa_uarths: uarths {
> +		pinmux = <K210_FPIOA(4, K210_PCF_UARTHS_RX)>,
> +			 <K210_FPIOA(5, K210_PCF_UARTHS_TX)>;
> +	};
> +
> +	fpioa_gpio: gpio {
> +		pinmux = <K210_FPIOA(8, K210_PCF_GPIO0)>,
> +			 <K210_FPIOA(9, K210_PCF_GPIO1)>,
> +			 <K210_FPIOA(10, K210_PCF_GPIO2)>,
> +			 <K210_FPIOA(11, K210_PCF_GPIO3)>,
> +			 <K210_FPIOA(12, K210_PCF_GPIO4)>,
> +			 <K210_FPIOA(13, K210_PCF_GPIO5)>,
> +			 <K210_FPIOA(14, K210_PCF_GPIO6)>,
> +			 <K210_FPIOA(15, K210_PCF_GPIO7)>;
> +	};
> +
> +	fpioa_gpiohs: gpiohs {
> +		pinmux = <K210_FPIOA(16, K210_PCF_GPIOHS0)>,
> +			 <K210_FPIOA(17, K210_PCF_GPIOHS1)>,
> +			 <K210_FPIOA(21, K210_PCF_GPIOHS5)>,
> +			 <K210_FPIOA(22, K210_PCF_GPIOHS6)>,
> +			 <K210_FPIOA(23, K210_PCF_GPIOHS7)>,
> +			 <K210_FPIOA(24, K210_PCF_GPIOHS8)>,
> +			 <K210_FPIOA(25, K210_PCF_GPIOHS9)>,
> +			 <K210_FPIOA(32, K210_PCF_GPIOHS16)>,
> +			 <K210_FPIOA(33, K210_PCF_GPIOHS17)>,
> +			 <K210_FPIOA(34, K210_PCF_GPIOHS18)>,
> +			 <K210_FPIOA(35, K210_PCF_GPIOHS19)>;
> +	};
> +
> +	fpioa_i2s0: i2s0 {
> +		pinmux = <K210_FPIOA(18, K210_PCF_I2S0_SCLK)>,
> +			 <K210_FPIOA(19, K210_PCF_I2S0_WS)>,
> +			 <K210_FPIOA(20, K210_PCF_I2S0_IN_D0)>;
> +	};
> +
> +	fpioa_dvp: dvp {
> +		pinmux = <K210_FPIOA(40, K210_PCF_SCCB_SDA)>,
> +			 <K210_FPIOA(41, K210_PCF_SCCB_SCLK)>,
> +			 <K210_FPIOA(42, K210_PCF_DVP_RST)>,
> +			 <K210_FPIOA(43, K210_PCF_DVP_VSYNC)>,
> +			 <K210_FPIOA(44, K210_PCF_DVP_PWDN)>,
> +			 <K210_FPIOA(45, K210_PCF_DVP_HSYNC)>,
> +			 <K210_FPIOA(46, K210_PCF_DVP_XCLK)>,
> +			 <K210_FPIOA(47, K210_PCF_DVP_PCLK)>;
> +	};
> +
> +	fpioa_spi0: spi0 {
> +		pinmux = <K210_FPIOA(36, K210_PCF_GPIOHS20)>,  /* cs */
> +			 <K210_FPIOA(37, K210_PCF_GPIOHS21)>,  /* rst */
> +			 <K210_FPIOA(38, K210_PCF_GPIOHS22)>,  /* dc */
> +			 <K210_FPIOA(39, K210_PCF_SPI0_SCLK)>; /* wr */
> +	};
> +
> +	fpioa_spi1: spi1 {
> +		pinmux = <K210_FPIOA(26, K210_PCF_SPI1_D1)>,
> +			 <K210_FPIOA(27, K210_PCF_SPI1_SCLK)>,
> +			 <K210_FPIOA(28, K210_PCF_SPI1_D0)>,
> +			 <K210_FPIOA(29, K210_PCF_SPI1_SS0)>; /* cs */
> +	};
> +
> +	fpioa_i2c1: i2c1 {
> +		pinmux = <K210_FPIOA(30, K210_PCF_I2C1_SCLK)>,
> +			 <K210_FPIOA(31, K210_PCF_I2C1_SDA)>;
> +	};
> +};
> +
> +&uarths0 {
> +	pinctrl-0 = <&fpioa_uarths>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&gpio0 {
> +	pinctrl-0 = <&fpioa_gpiohs>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&gpio1 {
> +	pinctrl-0 = <&fpioa_gpio>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&i2s0 {
> +	#sound-dai-cells = <1>;
> +	pinctrl-0 = <&fpioa_i2s0>;
> +	pinctrl-names = "default";
> +};
> +
> +&i2c1 {
> +	pinctrl-0 = <&fpioa_i2c1>;
> +	pinctrl-names = "default";
> +	clock-frequency = <400000>;
> +	status = "okay";
> +};
> +
> +&dvp0 {
> +	pinctrl-0 = <&fpioa_dvp>;
> +	pinctrl-names = "default";
> +};
> +
> +&spi0 {
> +	pinctrl-0 = <&fpioa_spi0>;
> +	pinctrl-names = "default";
> +	num-cs = <1>;
> +	cs-gpios = <&gpio0 20 0>;
> +
> +	panel@0 {
> +		compatible = "sitronix,st7789v";
> +		reg = <0>;
> +		reset-gpios = <&gpio0 21 GPIO_ACTIVE_LOW>;
> +		dc-gpios = <&gpio0 22 0>;
> +		spi-max-frequency = <15000000>;
> +		status = "disabled";
> +	};
> +};
> +
> +&spi1 {
> +	pinctrl-0 = <&fpioa_spi1>;
> +	pinctrl-names = "default";
> +	num-cs = <1>;
> +	polling;
> +	status = "okay";
> +
> +	slot@0 {
> +		compatible = "mmc-spi-slot";
> +		reg = <0>;
> +		voltage-ranges = <3300 3300>;
> +		spi-max-frequency = <4000000>;
> +		broken-cd;
> +	};
> +};
> +
> +&spi3 {
> +	spi-flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <50000000>;
> +		m25p,fast-read;
> +		broken-flash-reset;
> +	};
> +};
> 

Reviewed-by: Sean Anderson <seanga2@gmail.com>
