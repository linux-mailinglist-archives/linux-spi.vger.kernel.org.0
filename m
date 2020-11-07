Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D082AA5BE
	for <lists+linux-spi@lfdr.de>; Sat,  7 Nov 2020 15:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgKGOI0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Nov 2020 09:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgKGOI0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 Nov 2020 09:08:26 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA53C0613CF;
        Sat,  7 Nov 2020 06:08:26 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id u4so1083409qkk.10;
        Sat, 07 Nov 2020 06:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WG+muzJbP0N3XdTsrETDIu8IGQMsG1gmly9lOsm4JcM=;
        b=Fe6bdBnho3sAJwQ1/aQ6Wl9wQko9fu74RTpBMfft71Ar+EinPf1Up7ubiOloQs21HF
         u3CRlaDFYoJ6PIQUALKlEoMGduxEi8w731zUX5mJnzbiuqjAib835m78F++HUtrvd6Yk
         iv3vSD1ZumoWRy0Jqn5n6UXZpDmRi3jR9oWBkGXEuX9agfUyhpI0AHk8b4C6UjCxGCZi
         WaIHtC/F+JlCRGqn54URVi3/msLzTw35XWPaxx3vbbHXtcE109LqIt0STDlO7JWdyewv
         KIhX0Ez+foHspsr0bLm/a7tBkMiJ+4u/yb/EAUKzdJuCFe+x+LaygY8/LC5aSlzYb+2X
         Rb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WG+muzJbP0N3XdTsrETDIu8IGQMsG1gmly9lOsm4JcM=;
        b=OKtR5g59/aJ5dU4FdyasqkkGY8NVDvw/xPCpsQ2NwEeHTMs5+DBqx/H9p9y499AwI5
         e3UGs38QPRBJpZmJISy7pTEycc1cZDG+SNV54jH2vvxq+4/oW6s68lSJEb+BPpM/sIKF
         OZSjpZaQ2qon7PndhhSfUR/Juo6eVinn+2mnhwbZkd0la5YnDqB9lfHTmp1Lw8TQIR6K
         IfqmHBdDSVf6kRRwxb2U1MxpyPgnjQ1WIn4KUbVXLO0+MwantrWeTnyn10ZZX8DUvSiM
         wN0uG7kDO8FZ08rko78iICf1aAal2xIlUp185SAfeF4wEqefh/lMAP44+9gsYDZWikLt
         hD4A==
X-Gm-Message-State: AOAM531zaNJeARFCfgbSg6wtkgObfK/EQXvSiby2DfVOg5raTaw27tTE
        C2Y6HYNdmcGDT5h+hQk9LtI=
X-Google-Smtp-Source: ABdhPJxvHFzVYMpguyUGnvBMXkdnWolU7hkJFGBGvKT5i2+Lc7ODWE0zo2x803GjynPJRrzixk6NCA==
X-Received: by 2002:a37:a5d5:: with SMTP id o204mr4425474qke.112.1604758105298;
        Sat, 07 Nov 2020 06:08:25 -0800 (PST)
Received: from [192.168.1.201] (pool-108-51-35-162.washdc.fios.verizon.net. [108.51.35.162])
        by smtp.googlemail.com with ESMTPSA id s17sm2548147qkg.67.2020.11.07.06.08.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Nov 2020 06:08:24 -0800 (PST)
Subject: Re: [PATCH 26/32] riscv: Update Kendryte K210 device tree
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
 <20201107081420.60325-27-damien.lemoal@wdc.com>
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
Message-ID: <7563c77e-a7ab-521c-009b-bdd45a0d6207@gmail.com>
Date:   Sat, 7 Nov 2020 09:08:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201107081420.60325-27-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 11/7/20 3:14 AM, Damien Le Moal wrote:
> Update the Kendryte K210 base device tree k210.dtsi to define all
> peripherals of the SoC, their clocks and reset lines. The device tree
> file k210.dts is renamed to k210_generic.dts and becomes the default
> dwivalue selection of the SOC_KENDRYTE_K210_DTB_BUILTIN_SOURCE
> configuration option. No device beside the serial console is defined by
> this device tree. This makes it suitable for all known K210 boards using
> a builtin initramfs.
> 
> Most updates to the k210.dtsi file come from Sean Anderson's work on
> U-Boot support for the Kendryte K210.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  arch/riscv/Kconfig.socs                       |   2 +-
>  arch/riscv/boot/dts/kendryte/k210.dts         |  23 -
>  arch/riscv/boot/dts/kendryte/k210.dtsi        | 564 +++++++++++++++++-
>  arch/riscv/boot/dts/kendryte/k210_generic.dts |  46 ++
>  4 files changed, 583 insertions(+), 52 deletions(-)
>  delete mode 100644 arch/riscv/boot/dts/kendryte/k210.dts
>  create mode 100644 arch/riscv/boot/dts/kendryte/k210_generic.dts
> 
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index 56ba82a64e18..9230af7fb763 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -59,7 +59,7 @@ config SOC_KENDRYTE_K210_DTB_SOURCE
>  	string "Source file for the Kendryte K210 builtin DTB"
>  	depends on SOC_KENDRYTE
>  	depends on SOC_KENDRYTE_K210_DTB_BUILTIN
> -	default "k210"
> +	default "k210_generic"
>  	help
>  	  Base name (without suffix, relative to arch/riscv/boot/dts/kendryte)
>  	  for the DTS file that will be used to produce the DTB linked into the
> diff --git a/arch/riscv/boot/dts/kendryte/k210.dts b/arch/riscv/boot/dts/kendryte/k210.dts
> deleted file mode 100644
> index 0d1f28fce6b2..000000000000
> --- a/arch/riscv/boot/dts/kendryte/k210.dts
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * Copyright (C) 2020 Western Digital Corporation or its affiliates.
> - */
> -
> -/dts-v1/;
> -
> -#include "k210.dtsi"
> -
> -/ {
> -	model = "Kendryte K210 generic";
> -	compatible = "kendryte,k210";
> -
> -	chosen {
> -		bootargs = "earlycon console=ttySIF0";
> -		stdout-path = "serial0";
> -	};
> -};
> -
> -&uarths0 {
> -	status = "okay";
> -};
> -
> diff --git a/arch/riscv/boot/dts/kendryte/k210.dtsi b/arch/riscv/boot/dts/kendryte/k210.dtsi
> index d2d0ff645632..b8706fe78b21 100644
> --- a/arch/riscv/boot/dts/kendryte/k210.dtsi
> +++ b/arch/riscv/boot/dts/kendryte/k210.dtsi
> @@ -1,9 +1,12 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Copyright (C) 2019 Sean Anderson <seanga2@gmail.com>
> + * Copyright (C) 2019-20 Sean Anderson <seanga2@gmail.com>
>   * Copyright (C) 2020 Western Digital Corporation or its affiliates.
>   */
>  #include <dt-bindings/clock/k210-clk.h>
> +#include <dt-bindings/mfd/k210-sysctl.h>
> +#include <dt-bindings/pinctrl/k210-pinctrl.h>
> +#include <dt-bindings/reset/k210-rst.h>
>  
>  / {
>  	/*
> @@ -15,7 +18,26 @@ / {
>  	compatible = "kendryte,k210";
>  
>  	aliases {
> +		cpu0 = &cpu0;
> +		cpu1 = &cpu1;
> +		dma0 = &dmac0;
> +		gpio0 = &gpio0;
> +		gpio1 = &gpio1_0;
> +		i2c0 = &i2c0;
> +		i2c1 = &i2c1;
> +		i2c2 = &i2c2;
> +		pinctrl0 = &fpioa;
>  		serial0 = &uarths0;
> +		serial1 = &uart1;
> +		serial2 = &uart2;
> +		serial3 = &uart3;
> +		spi0 = &spi0;
> +		spi1 = &spi1;
> +		spi2 = &spi2;
> +		spi3 = &spi3;
> +		timer0 = &timer0;
> +		timer1 = &timer1;
> +		timer2 = &timer2;
>  	};
>  
>  	/*
> @@ -30,16 +52,15 @@ cpus {
>  		timebase-frequency = <7800000>;
>  		cpu0: cpu@0 {
>  			device_type = "cpu";
> -			reg = <0>;
>  			compatible = "kendryte,k210", "sifive,rocket0", "riscv";
> -			riscv,isa = "rv64imafdc";
> +			reg = <0>;
> +			riscv,isa = "rv64imafdgc";
>  			mmu-type = "none";
> -			i-cache-size = <0x8000>;
>  			i-cache-block-size = <64>;
> -			d-cache-size = <0x8000>;
> +			i-cache-size = <0x8000>;
>  			d-cache-block-size = <64>;
> -			clocks = <&sysctl K210_CLK_CPU>;
> -			clock-frequency = <390000000>;
> +			d-cache-size = <0x8000>;
> +			clocks = <&sysclk K210_CLK_CPU>;
>  			cpu0_intc: interrupt-controller {
>  				#interrupt-cells = <1>;
>  				interrupt-controller;
> @@ -48,16 +69,15 @@ cpu0_intc: interrupt-controller {
>  		};
>  		cpu1: cpu@1 {
>  			device_type = "cpu";
> -			reg = <1>;
>  			compatible = "kendryte,k210", "sifive,rocket0", "riscv";
> -			riscv,isa = "rv64imafdc";
> +			reg = <1>;
> +			riscv,isa = "rv64imafdgc";
>  			mmu-type = "none";
> -			i-cache-size = <0x8000>;
>  			i-cache-block-size = <64>;
> -			d-cache-size = <0x8000>;
> +			i-cache-size = <0x8000>;
>  			d-cache-block-size = <64>;
> -			clocks = <&sysctl K210_CLK_CPU>;
> -			clock-frequency = <390000000>;
> +			d-cache-size = <0x8000>;
> +			clocks = <&sysclk K210_CLK_CPU>;
>  			cpu1_intc: interrupt-controller {
>  				#interrupt-cells = <1>;
>  				interrupt-controller;
> @@ -68,14 +88,19 @@ cpu1_intc: interrupt-controller {
>  
>  	sram: memory@80000000 {
>  		device_type = "memory";
> +		compatible = "kendryte,k210-sram";
>  		reg = <0x80000000 0x400000>,
>  		      <0x80400000 0x200000>,
>  		      <0x80600000 0x200000>;
>  		reg-names = "sram0", "sram1", "aisram";
> +		clocks = <&sysclk K210_CLK_SRAM0>,
> +			 <&sysclk K210_CLK_SRAM1>,
> +			 <&sysclk K210_CLK_AI>;
> +		clock-names = "sram0", "sram1", "aisram";
>  	};
>  
>  	clocks {
> -		in0: oscillator {
> +		in0: osc {
>  			compatible = "fixed-clock";
>  			#clock-cells = <0>;
>  			clock-frequency = <26000000>;
> @@ -89,28 +114,34 @@ soc {
>  		ranges;
>  		interrupt-parent = <&plic0>;
>  
> -		sysctl: sysctl@50440000 {
> -			compatible = "kendryte,k210-sysctl", "simple-mfd";
> -			reg = <0x50440000 0x1000>;
> -			#clock-cells = <1>;
> +		debug0: debug@0 {
> +			compatible = "kendryte,k210-debug", "riscv,debug";
> +			reg = <0x0 0x1000>;
> +			status = "disabled";
> +		};
> +
> +		rom0: nvmem@1000 {
> +			reg = <0x1000 0x1000>;
> +			read-only;
> +			status = "disabled";
>  		};
>  
>  		clint0: clint@2000000 {
>  			#interrupt-cells = <1>;
> -			compatible = "riscv,clint0";
> +			compatible = "kendryte,k210-clint", "riscv,clint0";
>  			reg = <0x2000000 0xC000>;
> -			interrupts-extended =  <&cpu0_intc 3 &cpu0_intc 7
> -						&cpu1_intc 3 &cpu1_intc 7>;
> -			clocks = <&sysctl K210_CLK_ACLK>;
> +			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>,
> +					      <&cpu1_intc 3>, <&cpu1_intc 7>;
> +			clocks = <&sysclk K210_CLK_CLINT>;
>  		};
>  
> -		plic0: interrupt-controller@c000000 {
> +		plic0: interrupt-controller@C000000 {
>  			#interrupt-cells = <1>;
> -			interrupt-controller;
> -			compatible = "kendryte,k210-plic0", "riscv,plic0";
> +			compatible = "kendryte,k210-plic", "riscv,plic0";
>  			reg = <0xC000000 0x4000000>;
> -			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 0xffffffff>,
> -					      <&cpu1_intc 11>, <&cpu1_intc 0xffffffff>;
> +			interrupt-controller;
> +			interrupts-extended = <&cpu0_intc 11>,
> +					      <&cpu1_intc 11>;
>  			riscv,ndev = <65>;
>  			riscv,max-priority = <7>;
>  		};
> @@ -119,7 +150,484 @@ uarths0: serial@38000000 {
>  			compatible = "kendryte,k210-uarths", "sifive,uart0";
>  			reg = <0x38000000 0x1000>;
>  			interrupts = <33>;
> -			clocks = <&sysctl K210_CLK_CPU>;
> +			clocks = <&sysclk K210_CLK_CPU>;
> +			status = "disabled";
> +		};
> +
> +		gpio0: gpio-controller@38001000 {
> +			#interrupt-cells = <2>;
> +			#gpio-cells = <2>;
> +			compatible = "kendryte,k210-gpiohs", "sifive,gpio0";
> +			reg = <0x38001000 0x1000>;
> +			interrupt-controller;
> +			interrupts = <34 35 36 37 38 39 40 41
> +				      42 43 44 45 46 47 48 49
> +				      50 51 52 53 54 55 56 57
> +				      58 59 60 61 62 63 64 65>;
> +			gpio-controller;
> +			ngpios = <32>;
> +			status = "disabled";
> +		};
> +
> +		kpu0: kpu@40800000 {
> +			compatible = "kendryte,k210-kpu";
> +			reg = <0x40800000 0xc00000>;
> +			interrupts = <25>;
> +			clocks = <&sysclk K210_CLK_AI>;
> +			status = "disabled";
> +		};
> +
> +		fft0: fft@42000000 {
> +			compatible = "kendryte,k210-fft";
> +			reg = <0x42000000 0x400000>;
> +			interrupts = <26>;
> +			clocks = <&sysclk K210_CLK_FFT>;
> +			resets = <&sysrst K210_RST_FFT>;
> +			status = "disabled";
> +		};
> +
> +		dmac0: dma-controller@50000000 {
> +			compatible = "kendryte,k210-dmac", "snps,axi-dma-1.01a";
> +			reg = <0x50000000 0x1000>;
> +			interrupts = <27 28 29 30 31 32>;
> +			clocks = <&sysclk K210_CLK_DMA>, <&sysclk K210_CLK_DMA>;
> +			clock-names = "core-clk", "cfgr-clk";
> +			resets = <&sysrst K210_RST_DMA>;
> +			dma-channels = <6>;
> +			snps,dma-masters = <2>;
> +			snps,priority = <0 1 2 3 4 5>;
> +			snps,data-width = <5>;
> +			snps,block-size = <0x200000 0x200000 0x200000
> +					   0x200000 0x200000 0x200000>;
> +			snps,axi-max-burst-len = <256>;
> +			status = "disabled";
> +		};
> +
> +		apb0: bus@50200000 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "kendryte,k210-apb", "simple-pm-bus";
> +			ranges;
> +			clocks = <&sysclk K210_CLK_APB0>;
> +
> +			gpio1: gpio-controller@50200000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "kendryte,k210-gpio",
> +					     "snps,dw-apb-gpio";
> +				reg = <0x50200000 0x80>;
> +				clocks = <&sysclk K210_CLK_APB0>,
> +					 <&sysclk K210_CLK_GPIO>;
> +				clock-names = "bus", "db";
> +				resets = <&sysrst K210_RST_GPIO>;
> +				status = "disabled";
> +
> +				gpio1_0: gpio1@0 {
> +					#gpio-cells = <2>;
> +					#interrupt-cells = <2>;
> +					compatible = "snps,dw-apb-gpio-port";
> +					reg = <0>;
> +					interrupt-controller;
> +					interrupts = <23>;
> +					gpio-controller;
> +					snps,nr-gpios = <8>;
> +				};
> +			};
> +
> +			uart1: serial@50210000 {
> +				compatible = "kendryte,k210-uart",
> +					     "snps,dw-apb-uart";
> +				reg = <0x50210000 0x100>;
> +				interrupts = <11>;
> +				clocks = <&sysclk K210_CLK_UART1>,
> +					 <&sysclk K210_CLK_APB0>;
> +				clock-names = "baudclk", "apb_pclk";
> +				resets = <&sysrst K210_RST_UART1>;
> +				reg-io-width = <4>;
> +				reg-shift = <2>;
> +				dcd-override;
> +				dsr-override;
> +				cts-override;
> +				ri-override;
> +				status = "disabled";
> +			};
> +
> +			uart2: serial@50220000 {
> +				compatible = "kendryte,k210-uart",
> +					     "snps,dw-apb-uart";
> +				reg = <0x50220000 0x100>;
> +				interrupts = <12>;
> +				clocks = <&sysclk K210_CLK_UART2>,
> +					 <&sysclk K210_CLK_APB0>;
> +				clock-names = "baudclk", "apb_pclk";
> +				resets = <&sysrst K210_RST_UART2>;
> +				reg-io-width = <4>;
> +				reg-shift = <2>;
> +				dcd-override;
> +				dsr-override;
> +				cts-override;
> +				ri-override;
> +				status = "disabled";
> +			};
> +
> +			uart3: serial@50230000 {
> +				compatible = "kendryte,k210-uart",
> +					     "snps,dw-apb-uart";
> +				reg = <0x50230000 0x100>;
> +				interrupts = <13>;
> +				clocks = <&sysclk K210_CLK_UART3>,
> +					 <&sysclk K210_CLK_APB0>;
> +				clock-names = "baudclk", "apb_pclk";
> +				resets = <&sysrst K210_RST_UART3>;
> +				reg-io-width = <4>;
> +				reg-shift = <2>;
> +				dcd-override;
> +				dsr-override;
> +				cts-override;
> +				ri-override;
> +				status = "disabled";
> +			};
> +
> +			spi2: spi@50240000 {
> +				compatible = "canaan,kendryte-k210-spi",
> +					     "snps,dw-apb-ssi-4.01",
> +					     "snps,dw-apb-ssi";
> +				spi-slave;
> +				reg = <0x50240000 0x100>;
> +				interrupts = <3>;
> +				clocks = <&sysclk K210_CLK_SPI2>,
> +					 <&sysclk K210_CLK_APB0>;
> +				clock-names = "ssi_clk", "pclk";
> +				resets = <&sysrst K210_RST_SPI2>;
> +				spi-max-frequency = <25000000>;
> +				status = "disabled";
> +			};
> +
> +			i2s0: i2s@50250000 {
> +				compatible = "kendryte,k210-i2s",
> +					     "snps,designware-i2s";
> +				reg = <0x50250000 0x200>;
> +				interrupts = <5>;
> +				clocks = <&sysclk K210_CLK_I2S0>;
> +				clock-names = "i2sclk";
> +				resets = <&sysrst K210_RST_I2S0>;
> +				status = "disabled";
> +			};
> +
> +			apu0: sound@520250200 {
> +				compatible = "kendryte,k210-apu";
> +				reg = <0x50250200 0x200>;
> +				status = "disabled";
> +			};
> +
> +			i2s1: i2s@50260000 {
> +				compatible = "kendryte,k210-i2s",
> +					     "snps,designware-i2s";
> +				reg = <0x50260000 0x200>;
> +				interrupts = <6>;
> +				clocks = <&sysclk K210_CLK_I2S1>;
> +				clock-names = "i2sclk";
> +				resets = <&sysrst K210_RST_I2S1>;
> +				status = "disabled";
> +			};
> +
> +			i2s2: i2s@50270000 {
> +				compatible = "kendryte,k210-i2s",
> +					     "snps,designware-i2s";
> +				reg = <0x50270000 0x200>;
> +				interrupts = <7>;
> +				clocks = <&sysclk K210_CLK_I2S2>;
> +				clock-names = "i2sclk";
> +				resets = <&sysrst K210_RST_I2S2>;
> +				status = "disabled";
> +			};
> +
> +			i2c0: i2c@50280000 {
> +				compatible = "kendryte,k210-i2c",
> +					     "snps,designware-i2c";
> +				reg = <0x50280000 0x100>;
> +				interrupts = <8>;
> +				clocks = <&sysclk K210_CLK_I2C0>,
> +					 <&sysclk K210_CLK_APB0>;
> +				clock-names = "ref", "pclk";
> +				resets = <&sysrst K210_RST_I2C0>;
> +				status = "disabled";
> +			};
> +
> +			i2c1: i2c@50290000 {
> +				compatible = "kendryte,k210-i2c",
> +					     "snps,designware-i2c";
> +				reg = <0x50290000 0x100>;
> +				interrupts = <9>;
> +				clocks = <&sysclk K210_CLK_I2C1>,
> +					 <&sysclk K210_CLK_APB0>;
> +				clock-names = "ref", "pclk";
> +				resets = <&sysrst K210_RST_I2C1>;
> +				status = "disabled";
> +			};
> +
> +			i2c2: i2c@502A0000 {
> +				compatible = "kendryte,k210-i2c",
> +					     "snps,designware-i2c";
> +				reg = <0x502A0000 0x100>;
> +				interrupts = <10>;
> +				clocks = <&sysclk K210_CLK_I2C2>,
> +					 <&sysclk K210_CLK_APB0>;
> +				clock-names = "ref", "pclk";
> +				resets = <&sysrst K210_RST_I2C2>;
> +				status = "disabled";
> +			};
> +
> +			fpioa: pinmux@502B0000 {
> +				compatible = "kendryte,k210-fpioa";
> +				reg = <0x502B0000 0x100>;
> +				clocks = <&sysclk K210_CLK_FPIOA>,
> +					 <&sysclk K210_CLK_APB0>;
> +				clock-names = "ref", "pclk";
> +				resets = <&sysrst K210_RST_FPIOA>;
> +				kendryte,sysctl = <&sysctl>;
> +				kendryte,power-offset = <K210_SYSCTL_POWER_SEL>;
> +				status = "disabled";
> +			};
> +
> +			sha256: sha256@502C0000 {
> +				compatible = "kendryte,k210-sha256";
> +				reg = <0x502C0000 0x100>;
> +				clocks = <&sysclk K210_CLK_SHA>;
> +				resets = <&sysrst K210_RST_SHA>;
> +				status = "disabled";
> +			};
> +
> +			timer0: timer@502D0000 {
> +				compatible = "kendryte,k210-timer",
> +					     "snps,dw-apb-timer";
> +				reg = <0x502D0000 0x100>;
> +				interrupts = <14 15>;
> +				clocks = <&sysclk K210_CLK_TIMER0>,
> +					 <&sysclk K210_CLK_APB0>;
> +				clock-names = "timer", "pclk";
> +				resets = <&sysrst K210_RST_TIMER0>;
> +				status = "disabled";
> +			};
> +
> +			timer1: timer@502E0000 {
> +				compatible = "kendryte,k210-timer",
> +					     "snps,dw-apb-timer";
> +				reg = <0x502E0000 0x100>;
> +				interrupts = <16 17>;
> +				clocks = <&sysclk K210_CLK_TIMER1>,
> +					 <&sysclk K210_CLK_APB0>;
> +				clock-names = "timer", "pclk";
> +				resets = <&sysrst K210_RST_TIMER1>;
> +				status = "disabled";
> +			};
> +
> +			timer2: timer@502F0000 {
> +				compatible = "kendryte,k210-timer",
> +					     "snps,dw-apb-timer";
> +				reg = <0x502F0000 0x100>;
> +				interrupts = <18 19>;
> +				clocks = <&sysclk K210_CLK_TIMER2>,
> +					 <&sysclk K210_CLK_APB0>;
> +				clock-names = "timer", "pclk";
> +				resets = <&sysrst K210_RST_TIMER2>;
> +				status = "disabled";
> +			};
> +		};
> +
> +		apb1: bus@50400000 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "kendryte,k210-apb", "simple-pm-bus";
> +			ranges;
> +			clocks = <&sysclk K210_CLK_APB1>;
> +
> +			wdt0: watchdog@50400000 {
> +				compatible = "kendryte,k210-wdt", "snps,dw-wdt";
> +				reg = <0x50400000 0x100>;
> +				interrupts = <21>;
> +				clocks = <&sysclk K210_CLK_WDT0>,
> +					 <&sysclk K210_CLK_APB1>;
> +				clock-names = "tclk", "pclk";
> +				resets = <&sysrst K210_RST_WDT0>;
> +				status = "disabled";
> +			};
> +
> +			wdt1: watchdog@50410000 {
> +				compatible = "kendryte,k210-wdt", "snps,dw-wdt";
> +				reg = <0x50410000 0x100>;
> +				interrupts = <22>;
> +				clocks = <&sysclk K210_CLK_WDT1>,
> +					 <&sysclk K210_CLK_APB1>;
> +				clock-names = "tclk", "pclk";
> +				resets = <&sysrst K210_RST_WDT1>;
> +				status = "disabled";
> +			};
> +
> +			otp0: nvmem@50420000 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				compatible = "kendryte,k210-otp";
> +				reg = <0x50420000 0x100>,
> +				      <0x88000000 0x20000>;
> +				reg-names = "reg", "mem";
> +				clocks = <&sysclk K210_CLK_ROM>;
> +				resets = <&sysrst K210_RST_ROM>;
> +				read-only;
> +				status = "disabled";
> +
> +				/* Bootloader */
> +				firmware@00000 {
> +					reg = <0x00000 0xC200>;
> +				};
> +
> +				/*
> +				 * config string as described in RISC-V
> +				 * privileged spec 1.9
> +				 */
> +				config-1-9@1c000 {
> +					reg = <0x1C000 0x1000>;
> +				};
> +
> +				/*
> +				 * Device tree containing only registers,
> +				 * interrupts, and cpus
> +				 */
> +				fdt@1d000 {
> +					reg = <0x1D000 0x2000>;
> +				};
> +
> +				/* CPU/ROM credits */
> +				credits@1f000 {
> +					reg = <0x1F000 0x1000>;
> +				};
> +			};
> +
> +			dvp0: camera@50430000 {
> +				compatible = "kendryte,k210-dvp";
> +				reg = <0x50430000 0x100>;
> +				interrupts = <24>;
> +				clocks = <&sysclk K210_CLK_DVP>;
> +				resets = <&sysrst K210_RST_DVP>;
> +				kendryte,sysctl = <&sysctl>;
> +				kendryte,misc-offset = <K210_SYSCTL_MISC>;
> +				status = "disabled";
> +			};
> +
> +			sysctl: syscon@50440000 {
> +				compatible = "kendryte,k210-sysctl",
> +					     "syscon", "simple-mfd";
> +				reg = <0x50440000 0x100>;
> +				reg-io-width = <4>;
> +				clocks = <&sysclk K210_CLK_APB1>;
> +				clock-names = "pclk";
> +
> +				sysclk: clock-controller {
> +					#clock-cells = <1>;
> +					compatible = "kendryte,k210-clk";
> +					clocks = <&in0>;
> +				};
> +
> +				sysrst: reset-controller {
> +					compatible = "kendryte,k210-rst",
> +						     "syscon-reset";
> +					#reset-cells = <1>;
> +					regmap = <&sysctl>;
> +					offset = <K210_SYSCTL_PERI_RESET>;
> +					mask = <0x27FFFFFF>;
> +					assert-high = <1>;
> +				};
> +
> +				reboot {
> +					compatible = "syscon-reboot";
> +					regmap = <&sysctl>;
> +					offset = <K210_SYSCTL_SOFT_RESET>;
> +					mask = <1>;
> +					value = <1>;
> +				};
> +			};
> +
> +			aes0: aes@50450000 {
> +				compatible = "kendryte,k210-aes";
> +				reg = <0x50450000 0x100>;
> +				clocks = <&sysclk K210_CLK_AES>;
> +				resets = <&sysrst K210_RST_AES>;
> +				status = "disabled";
> +			};
> +
> +			rtc: rtc@50460000 {
> +				compatible = "kendryte,k210-rtc";
> +				reg = <0x50460000 0x100>;
> +				clocks = <&in0>;
> +				resets = <&sysrst K210_RST_RTC>;
> +				interrupts = <20>;
> +				status = "disabled";
> +			};
> +		};
> +
> +		apb2: bus@52000000 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "kendryte,k210-apb", "simple-pm-bus";
> +			ranges;
> +			clocks = <&sysclk K210_CLK_APB2>;
> +
> +			spi0: spi@52000000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "canaan,kendryte-k210-spi",
> +					     "snps,dw-apb-ssi-4.01",
> +					     "snps,dw-apb-ssi";
> +				reg = <0x52000000 0x100>;
> +				interrupts = <1>;
> +				clocks = <&sysclk K210_CLK_SPI0>,
> +					 <&sysclk K210_CLK_APB2>;
> +				clock-names = "ssi_clk", "pclk";
> +				resets = <&sysrst K210_RST_SPI0>;
> +				reset-names = "spi";
> +				spi-max-frequency = <25000000>;
> +				num-cs = <4>;
> +				reg-io-width = <4>;
> +				status = "disabled";
> +			};
> +
> +			spi1: spi@53000000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "canaan,kendryte-k210-spi",
> +					     "snps,dw-apb-ssi-4.01",
> +					     "snps,dw-apb-ssi";
> +				reg = <0x53000000 0x100>;
> +				interrupts = <2>;
> +				clocks = <&sysclk K210_CLK_SPI1>,
> +					 <&sysclk K210_CLK_APB2>;
> +				clock-names = "ssi_clk", "pclk";
> +				resets = <&sysrst K210_RST_SPI1>;
> +				reset-names = "spi";
> +				spi-max-frequency = <25000000>;
> +				num-cs = <4>;
> +				reg-io-width = <4>;
> +				status = "disabled";
> +			};
> +
> +			spi3: spi@54000000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "canaan,kendryte-k210-ssi",
> +					     "snps,dwc-ssi-1.01a";
> +				reg = <0x54000000 0x200>;
> +				interrupts = <4>;
> +				clocks = <&sysclk K210_CLK_SPI3>,
> +					 <&sysclk K210_CLK_APB2>;
> +				clock-names = "ssi_clk", "pclk";
> +				resets = <&sysrst K210_RST_SPI3>;
> +				reset-names = "spi";
> +				/* Could possibly go up to 200 MHz */
> +				spi-max-frequency = <100000000>;
> +				num-cs = <4>;
> +				reg-io-width = <4>;
> +				status = "disabled";
> +			};
>  		};
>  	};
>  };
> diff --git a/arch/riscv/boot/dts/kendryte/k210_generic.dts b/arch/riscv/boot/dts/kendryte/k210_generic.dts
> new file mode 100644
> index 000000000000..f336f60dc15d
> --- /dev/null
> +++ b/arch/riscv/boot/dts/kendryte/k210_generic.dts
> @@ -0,0 +1,46 @@
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
> +	model = "Kendryte K210 generic";
> +	compatible = "kendryte,k210";
> +
> +	chosen {
> +		bootargs = "earlycon console=ttySIF0";
> +		stdout-path = "serial0:115200n8";
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
> +};
> +
> +&uarths0 {
> +	pinctrl-0 = <&fpioa_uarths>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> 

Reviewed-by: Sean Anderson <seanga2@gmail.com>
