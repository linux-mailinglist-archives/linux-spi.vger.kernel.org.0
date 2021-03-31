Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63D03505C9
	for <lists+linux-spi@lfdr.de>; Wed, 31 Mar 2021 19:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbhCaRvt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 31 Mar 2021 13:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbhCaRvf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 31 Mar 2021 13:51:35 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FD8C061574;
        Wed, 31 Mar 2021 10:51:34 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id a1so24897938ljp.2;
        Wed, 31 Mar 2021 10:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jy8+yk4COu5KYVcbot6lUvv0FWz0DrljN+3nZuynnL8=;
        b=r9gi7qNl8Ob4gfvqPiq9CrcGfAmN2FLBnRQfkdEceGTZWJd8AKERMvnxrRZhzaZHx9
         GT0mHRHNUPpe/ALh1cLgDN84zLlC/KX3YkkaIuilxn8xbXuwFdgSFWkaWgZ7iS49p4jh
         kYkIkEjt1/73/2DD13uVFzdFV8jHbINJiPkbvCsI3vT7+4TfFu6oWfGm7O8y5N0PqtXj
         bsm1SH3Hh16l47Ln41Osoce4gK/8ZoXmvLNsDwg0O8qsPoMmxhPFLBvBR7rtQ038gNar
         N/UAiq3vHxUhqEGLBgrn1nEAWES2i0ZzaOwgcdJxgUaukED8YlWCdvhDjJvrz9m/UUCF
         k6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jy8+yk4COu5KYVcbot6lUvv0FWz0DrljN+3nZuynnL8=;
        b=OKGako8f+a7VM1QwzeD1rWUgxN30xLe1SqW5T16EAXrrEEOxA2ck3d+xELIQY0FdlV
         ZafrziTttM4TcSSbe9XXCIoN9CGujE9vrCh7j2MUU1QI4qXeCYtlFy80uPDp3MfxCz1I
         dogozDbVhmgulpqtSjdr+6m5kAh0x3OC9NWTvwOMey0vz8qN9ZVcm2WEB6ex9ctipGso
         DQ+0N9MvanZ01X3uQGbVcgAfftZNIIhn8T8YqsguO5mpalHW/jE28vwE2dPQCurA91AD
         pvXKGAfQO+bQH72PrA0HGa306Ly2YYrdmmou738o4zFSqHbxPHNeqHlgvBrKtjlPVZ8H
         lcNQ==
X-Gm-Message-State: AOAM531f9u9MzTBZj8t+W6LvQyzgRo+TZnABuOt6t6Df180by0C9uCCb
        XDQvD4judZefncw2DOimDwU=
X-Google-Smtp-Source: ABdhPJzDYExd5bOk2MwEY8mGTthA40RcnWTL9MmgZaFFfi6mscyUaxQfugkAlm2Y7DI11nzDidcPPg==
X-Received: by 2002:a2e:3913:: with SMTP id g19mr2813570lja.294.1617213093378;
        Wed, 31 Mar 2021 10:51:33 -0700 (PDT)
Received: from mobilestation ([95.79.127.110])
        by smtp.gmail.com with ESMTPSA id q14sm293772lfr.12.2021.03.31.10.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 10:51:32 -0700 (PDT)
Date:   Wed, 31 Mar 2021 20:51:30 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Brad Larson <brad@pensando.io>, Rob Herring <robh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, olof@lixom.net, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/13] arm64: dts: Add Pensando Elba SoC support
Message-ID: <20210331175130.mhub5yxc3szfsl5q@mobilestation>
References: <20210329015938.20316-1-brad@pensando.io>
 <20210329015938.20316-8-brad@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329015938.20316-8-brad@pensando.io>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Rob,
Could you give your opinion on my comment regarding the nodes
layout in this dts-file. I was told to fix a similar problem in one of
patches submitted by me some time ago. Please see my last comment in
this message.

On Sun, Mar 28, 2021 at 06:59:32PM -0700, Brad Larson wrote:
> Add Pensando common and Elba SoC specific device nodes
> 
> Signed-off-by: Brad Larson <brad@pensando.io>
> ---
>  arch/arm64/boot/dts/Makefile                  |   1 +
>  arch/arm64/boot/dts/pensando/Makefile         |   6 +
>  arch/arm64/boot/dts/pensando/elba-16core.dtsi | 170 ++++++++++
>  .../boot/dts/pensando/elba-asic-common.dtsi   | 112 +++++++
>  arch/arm64/boot/dts/pensando/elba-asic.dts    |   7 +
>  .../boot/dts/pensando/elba-flash-parts.dtsi   |  78 +++++
>  arch/arm64/boot/dts/pensando/elba.dtsi        | 310 ++++++++++++++++++
>  7 files changed, 684 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/pensando/Makefile
>  create mode 100644 arch/arm64/boot/dts/pensando/elba-16core.dtsi
>  create mode 100644 arch/arm64/boot/dts/pensando/elba-asic-common.dtsi
>  create mode 100644 arch/arm64/boot/dts/pensando/elba-asic.dts
>  create mode 100644 arch/arm64/boot/dts/pensando/elba-flash-parts.dtsi
>  create mode 100644 arch/arm64/boot/dts/pensando/elba.dtsi
> 
> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
> index f1173cd93594..c85db0a097fe 100644
> --- a/arch/arm64/boot/dts/Makefile
> +++ b/arch/arm64/boot/dts/Makefile
> @@ -19,6 +19,7 @@ subdir-y += marvell
>  subdir-y += mediatek
>  subdir-y += microchip
>  subdir-y += nvidia
> +subdir-y += pensando
>  subdir-y += qcom
>  subdir-y += realtek
>  subdir-y += renesas
> diff --git a/arch/arm64/boot/dts/pensando/Makefile b/arch/arm64/boot/dts/pensando/Makefile
> new file mode 100644
> index 000000000000..0c2c0961e64a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/pensando/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_ARCH_PENSANDO_ELBA_SOC) += elba-asic.dtb
> +
> +always-y	:= $(dtb-y)
> +subdir-y	:= $(dts-dirs)
> +clean-files	:= *.dtb
> diff --git a/arch/arm64/boot/dts/pensando/elba-16core.dtsi b/arch/arm64/boot/dts/pensando/elba-16core.dtsi
> new file mode 100644
> index 000000000000..a6c47899b69a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/pensando/elba-16core.dtsi
> @@ -0,0 +1,170 @@
> +
> +/ {
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 { cpu = <&cpu0>; };
> +				core1 { cpu = <&cpu1>; };
> +				core2 { cpu = <&cpu2>; };
> +				core3 { cpu = <&cpu3>; };
> +			};
> +			cluster1 {
> +				core0 { cpu = <&cpu4>; };
> +				core1 { cpu = <&cpu5>; };
> +				core2 { cpu = <&cpu6>; };
> +				core3 { cpu = <&cpu7>; };
> +			};
> +			cluster2 {
> +				core0 { cpu = <&cpu8>; };
> +				core1 { cpu = <&cpu9>; };
> +				core2 { cpu = <&cpu10>; };
> +				core3 { cpu = <&cpu11>; };
> +			};
> +			cluster3 {
> +				core0 { cpu = <&cpu12>; };
> +				core1 { cpu = <&cpu13>; };
> +				core2 { cpu = <&cpu14>; };
> +				core3 { cpu = <&cpu15>; };
> +			};
> +		};
> +

> +		// CLUSTER 0

What does chackpatch.pl tell you about C++ comment?

> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72", "arm,armv8";
> +			reg = <0 0x0>;
> +			enable-method = "spin-table";
> +			next-level-cache = <&l2_0>;
> +		};
> +		cpu1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72", "arm,armv8";
> +			reg = <0 0x1>;
> +			enable-method = "spin-table";
> +			next-level-cache = <&l2_0>;
> +		};
> +		cpu2: cpu@2 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72", "arm,armv8";
> +			reg = <0 0x2>;
> +			enable-method = "spin-table";
> +			next-level-cache = <&l2_0>;
> +		};
> +		cpu3: cpu@3 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72", "arm,armv8";
> +			reg = <0 0x3>;
> +			enable-method = "spin-table";
> +			next-level-cache = <&l2_0>;
> +		};
> +
> +		l2_0: l2-cache0 {
> +			compatible = "cache";
> +		};
> +

> +		// CLUSTER 1

ditto

> +		cpu4: cpu@100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72", "arm,armv8";
> +			reg = <0 0x100>;
> +			enable-method = "spin-table";
> +			next-level-cache = <&l2_1>;
> +		};
> +		cpu5: cpu@101 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72", "arm,armv8";
> +			reg = <0 0x101>;
> +			enable-method = "spin-table";
> +			next-level-cache = <&l2_1>;
> +		};
> +		cpu6: cpu@102 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72", "arm,armv8";
> +			reg = <0 0x102>;
> +			enable-method = "spin-table";
> +			next-level-cache = <&l2_1>;
> +		};
> +		cpu7: cpu@103 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72", "arm,armv8";
> +			reg = <0 0x103>;
> +			enable-method = "spin-table";
> +			next-level-cache = <&l2_1>;
> +		};
> +
> +		l2_1: l2-cache1 {
> +			compatible = "cache";
> +		};
> +

> +		// CLUSTER 2

ditto

> +		cpu8: cpu@200 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72", "arm,armv8";
> +			reg = <0 0x200>;
> +			enable-method = "spin-table";
> +			next-level-cache = <&l2_2>;
> +		};
> +		cpu9: cpu@201 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72", "arm,armv8";
> +			reg = <0 0x201>;
> +			enable-method = "spin-table";
> +			next-level-cache = <&l2_2>;
> +		};
> +		cpu10: cpu@202 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72", "arm,armv8";
> +			reg = <0 0x202>;
> +			enable-method = "spin-table";
> +			next-level-cache = <&l2_2>;
> +		};
> +		cpu11: cpu@203 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72", "arm,armv8";
> +			reg = <0 0x203>;
> +			enable-method = "spin-table";
> +			next-level-cache = <&l2_2>;
> +		};
> +
> +		l2_2: l2-cache2 {
> +			compatible = "cache";
> +		};
> +

> +		// CLUSTER 3

ditto

> +		cpu12: cpu@300 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72", "arm,armv8";
> +			reg = <0 0x300>;
> +			enable-method = "spin-table";
> +			next-level-cache = <&l2_3>;
> +		};
> +		cpu13: cpu@301 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72", "arm,armv8";
> +			reg = <0 0x301>;
> +			enable-method = "spin-table";
> +			next-level-cache = <&l2_3>;
> +		};
> +		cpu14: cpu@302 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72", "arm,armv8";
> +			reg = <0 0x302>;
> +			enable-method = "spin-table";
> +			next-level-cache = <&l2_3>;
> +		};
> +		cpu15: cpu@303 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72", "arm,armv8";
> +			reg = <0 0x303>;
> +			enable-method = "spin-table";
> +			next-level-cache = <&l2_3>;
> +		};
> +
> +		l2_3: l2-cache3 {
> +			compatible = "cache";
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/pensando/elba-asic-common.dtsi b/arch/arm64/boot/dts/pensando/elba-asic-common.dtsi
> new file mode 100644
> index 000000000000..7de2c35e7fcc
> --- /dev/null
> +++ b/arch/arm64/boot/dts/pensando/elba-asic-common.dtsi
> @@ -0,0 +1,112 @@
> +
> +/ {
> +	model = "Elba ASIC Board";
> +
> +	aliases {

> +		serial0 = &uart0;
> +                spi0 = &spi0;
> +                spi1 = &qspi;

Brad, if you checkpatch.pl'ed this patch, that would have told you
regarding leading spaces here.

> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:19200n8";
> +	};
> +};
> +
> +&ahb_clk {
> +	clock-frequency = <400000000>;
> +};
> +
> +&emmc_clk {
> +	clock-frequency = <200000000>;
> +};
> +
> +&flash_clk {
> +	clock-frequency = <400000000>;
> +};
> +
> +&ref_clk {
> +	clock-frequency = <156250000>;
> +};
> +
> +&qspi {
> +	status = "okay";
> +	flash0: mt25q@0 {
> +		compatible = "jdec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <40000000>;
> +		spi-rx-bus-width = <2>;
> +		m25p,fast-read;
> +		cdns,read-delay = <0>;
> +		cdns,tshsl-ns = <0>;
> +		cdns,tsd2d-ns = <0>;
> +		cdns,tchsh-ns = <0>;
> +		cdns,tslch-ns = <0>;
> +	};
> +};
> +
> +&gpio0 {
> +	status = "ok";
> +};
> +
> +&emmc {
> +	bus-width = <8>;
> +	status = "ok";
> +};
> +
> +&wdt0 {
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	clock-frequency = <100000>;
> +	status = "okay";
> +	tmp451@4c {
> +		compatible = "ti,tmp451";
> +		reg = <0x4c>;
> +	};
> +	tps53659@62 {
> +		compatible = "ti,tps53659";
> +		reg = <0x62>;
> +	};
> +	pcf85263@51 {
> +		compatible = "nxp,pcf85263";
> +		reg = <0x51>;
> +	};
> +};
> +
> +&spi0 {
> +	num-cs = <4>;
> +	cs-gpios = <&spics 0 0>, <&spics 1 0>, <&porta 1 0>, <&porta 7 0>;
> +	status = "okay";
> +	spi@0 {
> +		compatible = "pensando,cpld";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		spi-max-frequency = <12000000>;
> +		reg = <0>;
> +	};
> +	spi@1 {
> +		compatible = "pensando,cpld";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		spi-max-frequency = <12000000>;
> +		reg = <1>;
> +	};
> +	spi@2 {
> +		compatible = "pensando,cpld-rd1173";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		spi-max-frequency = <12000000>;
> +		reg = <2>;
> +		interrupt-parent = <&porta>;
> +		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +	spi@3 {
> +		compatible = "pensando,cpld";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		spi-max-frequency = <12000000>;
> +		reg = <3>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/pensando/elba-asic.dts b/arch/arm64/boot/dts/pensando/elba-asic.dts
> new file mode 100644
> index 000000000000..d074b1f1574a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/pensando/elba-asic.dts
> @@ -0,0 +1,7 @@
> +
> +/dts-v1/;
> +
> +#include "elba.dtsi"
> +#include "elba-16core.dtsi"
> +#include "elba-asic-common.dtsi"
> +#include "elba-flash-parts.dtsi"
> diff --git a/arch/arm64/boot/dts/pensando/elba-flash-parts.dtsi b/arch/arm64/boot/dts/pensando/elba-flash-parts.dtsi
> new file mode 100644
> index 000000000000..7fff1d653592
> --- /dev/null
> +++ b/arch/arm64/boot/dts/pensando/elba-flash-parts.dtsi
> @@ -0,0 +1,78 @@
> +&flash0 {
> +	partitions {
> +		compatible = "fixed-partitions";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		partition@0 {
> +			label = "flash";
> +			reg = <0x00010000 0x0fff0000>;
> +		};
> +		partition@f0000 {
> +			label = "golduenv";
> +			reg = <0x000f0000 0x00010000>;
> +		};
> +		partition@100000 {
> +			label = "boot0";
> +			reg = <0x00100000 0x00080000>;
> +		};
> +		partition@180000 {
> +			label = "golduboot";
> +			reg = <0x00180000 0x00200000>;
> +		};
> +		partition@400000 {
> +			label = "goldfw";
> +			reg = <0x00400000 0x03c00000>;
> +		};
> +		partition@4010000 {
> +			label = "fwmap";
> +			reg = <0x04010000 0x00020000>;
> +		};
> +		partition@4030000 {
> +			label = "fwsel";
> +			reg = <0x04030000 0x00020000>;
> +		};
> +		partition@4090000 {
> +			label = "bootlog";
> +			reg = <0x04090000 0x00020000>;
> +		};
> +		partition@40b0000 {
> +			label = "panicbuf";
> +			reg = <0x040b0000 0x00020000>;
> +		};
> +		partition@40d0000 {
> +			label = "uservars";
> +			reg = <0x040d0000 0x00020000>;
> +		};
> +		partition@4200000 {
> +			label = "uboota";
> +			reg = <0x04200000 0x00400000>;
> +		};
> +		partition@4600000 {
> +			label = "ubootb";
> +			reg = <0x04600000 0x00400000>;
> +		};
> +		partition@4a00000 {
> +			label = "mainfwa";
> +			reg = <0x04a00000 0x01000000>;
> +		};
> +		partition@5a00000 {
> +			label = "mainfwb";
> +			reg = <0x05a00000 0x01000000>;
> +		};
> +		partition@8000000 {
> +			label = "diagfw";
> +			reg = <0x08000000 0x07fe0000>;
> +		};
> +		partition@ffe0000 {
> +			label = "ubootenv";
> +			reg = <0x0ffe0000 0x00010000>;
> +		};
> +	};
> +};
> +
> +&soc {
> +	panicdump@740b0000 {
> +		compatible = "pensando,capri-crash";
> +		reg = <0x0 0x740b0000 0x0 0x00020000>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/pensando/elba.dtsi b/arch/arm64/boot/dts/pensando/elba.dtsi
> new file mode 100644
> index 000000000000..6f6cfab2b502
> --- /dev/null
> +++ b/arch/arm64/boot/dts/pensando/elba.dtsi
> @@ -0,0 +1,310 @@
> +
> +/*
> + * Copyright (c) 2019, Pensando Systems Inc.
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include "dt-bindings/interrupt-controller/arm-gic.h"
> +
> +/ {
> +	compatible = "pensando,elba";
> +
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	clocks {
> +		ahb_clk: oscillator0 {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +		};
> +		emmc_clk: oscillator2 {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +		};
> +		flash_clk: oscillator3 {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +		};
> +		ref_clk: oscillator4 {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +		};
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) |
> +					IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) |
> +					IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) |
> +					IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) |
> +					IRQ_TYPE_LEVEL_LOW)>;
> +	};
> +
> +	pmu {
> +		compatible = "arm,cortex-a72-pmu";
> +		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(1) |
> +				IRQ_TYPE_LEVEL_LOW)>;
> +	};
> +
> +	/* Common UIO device for MSI drivers */
> +	uio_penmsi {
> +		compatible = "pensando,uio_penmsi";
> +		name = "uio_penmsi";
> +	};
> +
> +
> +	soc: soc {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		gic: interrupt-controller@800000 {
> +			compatible = "arm,gic-v3";
> +			#interrupt-cells = <3>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +			interrupt-controller;
> +			reg = <0x0 0x800000 0x0 0x200000>,	// GICD
> +			      <0x0 0xa00000 0x0 0x200000>;	// GICR
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			its: interrupt-controller@820000 {
> +				compatible = "arm,gic-v3-its";
> +				msi-controller;
> +				#msi-cells = <1>;
> +				reg = <0x0 0x820000 0x0 0x10000>;
> +				socionext,synquacer-pre-its =
> +							<0xc00000 0x1000000>;
> +			};
> +		};
> +
> +		/*
> +		 * Until we  know the interrupt domain following this, we
> +		 * are forced to use this is the place where interrupts from
> +		 * PCI converge. In the ideal case, we use one domain higher,
> +		 * where the PCI-ness has been shed.
> +		 */
> +		pxc0_intr: intc@20102200 {
> +			compatible = "pensando,soc-ictlr-csrintr";
> +			interrupt-controller;

> +			reg = <0x0 0x20102200 0x0 0x4>;

Rob, please note the reg-space size here.

> +			#interrupt-cells = <3>;
> +			interrupt-parent = <&gic>;
> +			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "pxc0_intr";
> +		};
> +
> +		uart0: serial@4800 {
> +			device_type = "serial";
> +			compatible = "ns16550a";
> +			reg = <0x0 0x4800 0x0 0x100>;
> +			clocks = <&ref_clk>;
> +			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +		};
> +
> +		qspi: spi@2400 {
> +			compatible = "pensando,cdns-qspi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x0 0x2400 0x0 0x400>,
> +			      <0x0 0x7fff0000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&flash_clk>;
> +			cdns,fifo-depth = <1024>;
> +			cdns,fifo-width = <4>;
> +			cdns,trigger-address = <0x7fff0000>;
> +			status = "disabled";
> +		};
> +
> +		gpio0: gpio@4000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "snps,dw-apb-gpio";


> +			reg = <0x0 0x4000 0x0 0x78>;

Brad, are you sure the reg-space is just 0x78 bytes in this DW GPIO
module? Normally the system bus blocks are aligned to something
no less than 1KB...

> +			status = "disabled";
> +

> +			porta: gpio-controller@0 {

Brad, I'd prefer to name the sub-nodes as "gpio-port" for DW APB GPIO
because hardware considers each of them as dedicated port of the
GPIO controller. I know the bindings file permits using "-controller"
suffix, but that is allowed only because the bindings file was submitted
much later than the driver was. So I didn't want to have the dtbs_check
printing errors for already available dts-files.

> +				compatible = "snps,dw-apb-gpio-port";
> +				reg = <0>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				ngpios = <8>;
> +				interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
> +				interrupt-controller;
> +				interrupt-parent = <&gic>;
> +				#interrupt-cells = <2>;
> +			};
> +			portb: gpio-controller@1 {
> +				compatible = "snps,dw-apb-gpio-port";
> +				reg = <1>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				ngpios = <8>;
> +			};
> +		};
> +
> +		i2c0: i2c@400 {
> +			compatible = "snps,designware-i2c";
> +			reg = <0x0 0x400 0x0 0x100>;
> +			clocks = <&ahb_clk>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			i2c-sda-hold-time-ns = <480>;
> +			snps,sda-timeout-ms = <750>;
> +			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
> +		/* UIO device using interrupt line PCIEMAC */
> +		pciemac@20102200 {
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			#interrupt-cells = <3>;
> +
> +			compatible = "pensando,uio_pciemac";
> +			register-type = "csr-interrupt";
> +			interrupt-parent = <&pxc0_intr>;
> +			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
> +			reg = <0x0 0x20102200 0x0 0x10>; /* pxc0_intr */
> +
> +			enable_csr_paddr = <0x0 0x20102200 0x0 0x10>;
> +			enable_mask = <(1 << 0)>;
> +		};
> +
> +		/* MSI UIO device 1 */
> +		uio_penmsi1@520000 {
> +			compatible = "pensando,uio_penmsi1";
> +			reg = <0x0 0x520000 0x0 0x10000>;
> +			msi-parent = <&its 0xa>;
> +			num-interrupts = <16>;  /* # MSI interrupts to get */
> +		};
> +
> +		spics: spics@307c2468 {
> +			compatible = "pensando,elba-spics";

> +			reg = <0x0 0x307c2468 0x0 0x4>;

Rob, please note the reg-space base address and size here.

> +			gpio-controller;
> +			#gpio-cells = <2>;
> +		};
> +
> +		spi0: spi@2800 {
> +			compatible = "pensando,elba-spi";
> +			reg = <0x0 0x2800 0x0 0x100>;
> +			clocks = <&ahb_clk>;
> +			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			num-cs = <2>;
> +			status = "disabled";
> +		};
> +
> +		wdt0: watchdog@1400 {
> +			compatible = "snps,dw-wdt";
> +			reg = <0x0 0x1400 0x0 0x100>;
> +			clocks = <&ahb_clk>;
> +			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +		wdt1: watchdog@1800 {
> +			compatible = "snps,dw-wdt";
> +			reg = <0x0 0x1800 0x0 0x100>;
> +			clocks = <&ahb_clk>;
> +			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +		wdt2: watchdog@1c00 {
> +			compatible = "snps,dw-wdt";
> +			reg = <0x0 0x1c00 0x0 0x100>;
> +			clocks = <&ahb_clk>;
> +			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +		wdt3: watchdog@2000 {
> +			compatible = "snps,dw-wdt";
> +			reg = <0x0 0x2000 0x0 0x100>;
> +			clocks = <&ahb_clk>;
> +			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
> +		emmc: mmc@30440000 {
> +			compatible = "pensando,elba-emmc", "cdns,sd4hc";
> +			clocks = <&emmc_clk>;
> +			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> +			reg = <0x0 0x30440000 0x0 0x10000

> +			       0x0 0x30480044 0x0 0x4>;

Rob, please also note the reg-space base address and size here.
Brad just writes some magic numbers to this register in the MMC drive.
The field is named as "ctl_addr" in the driver.

> +			cdns,phy-input-delay-sd-highspeed = <0x4>;
> +			cdns,phy-input-delay-legacy = <0x4>;
> +			cdns,phy-input-delay-sd-uhs-sdr50 = <0x6>;
> +			cdns,phy-input-delay-sd-uhs-ddr50 = <0x16>;
> +			cdns,mmc-ddr-1_8v;
> +			status = "disabled";
> +		} ;
> +
> +		pcie@307c2480 {
> +			compatible = "pensando,pcie";

> +			reg = <0x0 0x307c2480 0x0 0x4   /* MS CFG_WDT */

Rob, please note the reg-space base address and size here.

> +			       0x0 0x00001400 0x0 0x10  /* WDT0 */
> +			       0x0 0x20000000 0x0 0x00380000>; /* PXB Base */
> +		};
> +
> +		panic: panicdump@0 {
> +			compatible = "pensando,pen-crash";
> +			status = "disabled";
> +		};
> +
> +		bsm@307c2080 {
> +			compatible = "pensando,bsm";

> +			reg = <0x0 0x307c2080 0x0 0x4>;

Rob, please see here having a small sized reg-space one more time.
Having so many small-sized registers scattered around the dts file
makes me thinking that most of them likely belong to some bigger
block like "System Controller". If so then there must be a main node
compatible with "syscon" device, which phandle would be referenced in
the particular device nodes. Like this:

\ {
	soc {
		syscon: syscon@307c0000 {
			compatible = "pensando,elba-sys-con", "syscon", "simple-mfd";
			reg = <0x0 0x307c0000 0x0 0x10000>;

			spics: spics@307c2468 {
				compatible = "pensando,elba-spics";
				gpio-controller;
				#gpio-cells = <2>;
			};
		};

		pcie@307c2480 {
			compatible = "pensando,pcie";
			reg = <0x0 0x20000000 0x0 0x00380000>; /* PXB Base */

			syscon = <&syscon>;
		};

		/* etc */
	};
};

Rob, what do you think about that? Correct me if I am wrong.

Brad, it's not about "To us it was more understandable" like you
responded to my comment in v1, but about having the DTS correctly
describing the hardware. Splitting the system controller registers up
isn't good in that regard even if you think it makes the driver code
more "understandable" and so on.

Also Brad, don't hurry with re-sending the patchset before finishing
all the discussions. I'd understand you doing so if noone would have
given you any comment in a long time, but you've got tons of them
nearly within one-two days after the v1 patchset submission. So you
should have answered to the comments first, settled all the issues,
then respined the series. Otherwise it seems as if you just disregard
all the work the reviewers did giving you the comments.

-Sergey

> +		};
> +	};
> +	mnet0: mnet0 {
> +		compatible = "pensando,mnet";
> +		msi-parent = <&its 0x0>;
> +	};
> +	mnet1: mnet1 {
> +		compatible = "pensando,mnet";
> +		msi-parent = <&its 0x1>;
> +	};
> +	mnet2: mnet2 {
> +		compatible = "pensando,mnet";
> +		msi-parent = <&its 0x2>;
> +	};
> +	mnet3: mnet3 {
> +		compatible = "pensando,mnet";
> +		msi-parent = <&its 0x3>;
> +	};
> +	mnet4: mnet4 {
> +		compatible = "pensando,mnet";
> +		msi-parent = <&its 0x4>;
> +	};
> +	mnet5: mnet5 {
> +		compatible = "pensando,mnet";
> +		msi-parent = <&its 0x5>;
> +	};
> +	mnet6: mnet6 {
> +		compatible = "pensando,mnet";
> +		msi-parent = <&its 0x6>;
> +	};
> +	mnet7: mnet7 {
> +		compatible = "pensando,mnet";
> +		msi-parent = <&its 0x7>;
> +	};
> +	mnet8: mnet8 {
> +		compatible = "pensando,mnet";
> +		msi-parent = <&its 0x8>;
> +	};
> +	mnet9: mnet9 {
> +		compatible = "pensando,mnet";
> +		msi-parent = <&its 0x9>;
> +	};
> +};
> -- 
> 2.17.1
> 
