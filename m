Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D444A32E725
	for <lists+linux-spi@lfdr.de>; Fri,  5 Mar 2021 12:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhCELXL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 5 Mar 2021 06:23:11 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51825 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhCELWt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 5 Mar 2021 06:22:49 -0500
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lI8Xf-0002t6-Sn
        for linux-spi@vger.kernel.org; Fri, 05 Mar 2021 11:22:47 +0000
Received: by mail-wr1-f71.google.com with SMTP id l10so919968wry.16
        for <linux-spi@vger.kernel.org>; Fri, 05 Mar 2021 03:22:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7TyJ6IjNy8g0MfrqFYU5L/dy9iXB/V2HbHxuQNoaGSw=;
        b=Y2PVWo9PldCLCAO8YkCj3nfJu0EY/fxm7cfkd3d2UzkP7qJZnnI8PMXmoHzWifCap3
         bT5Kh1kuRxA2F59TH70xvauxe+4JnwjV6ug94FrB1OF5NYiz5lxu64C0oWzF0ltjSOg4
         GTb6PTzcgwY6bA1qp7V3n8IXrU9VKUfUPPyWdnREll3S5xJqizGUe2uM0Qj/wMNQv/uq
         5uq3fmxgMyTyrlKlQpwlCPQQf54Xm4tmTQECk1O00BS+GU7NosipSGzA4KsFxPQ0g7oe
         Zy0mg/SLpBrsfCY13D8lTtQE2NjY1VM48sTO647hrLC2vl2EKMXPJtwry+D7IqHba6u4
         NK5Q==
X-Gm-Message-State: AOAM533SojnvBbzOF9g0dBciiC7RrKE3zsL0H8bhiCu7kJe8ZGn+c8kU
        sRcHCkOaruuG9njuyuG3VlvXPImOd8QKnhydb6fmxNn0EcIA492OEXQabp0lQkjKnYdKohl+m1w
        8HmfTx/BFBMV7YSTlBRypnKk/LbiL9GWydV+tyg==
X-Received: by 2002:a5d:50c7:: with SMTP id f7mr9118760wrt.18.1614943367488;
        Fri, 05 Mar 2021 03:22:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx0ihPC1O9pt1NeK7JGmc6KizqYcFdq32cgLLe5WSjtFEuUQTLS2BhQhwjZ+lLojZJV7DBrww==
X-Received: by 2002:a5d:50c7:: with SMTP id f7mr9118734wrt.18.1614943367274;
        Fri, 05 Mar 2021 03:22:47 -0800 (PST)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id f14sm3791172wmf.7.2021.03.05.03.22.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 03:22:46 -0800 (PST)
Subject: Re: [PATCH 7/8] arm64: dts: Add Pensando Elba SoC support
To:     Brad Larson <brad@pensando.io>,
        linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210304034141.7062-1-brad@pensando.io>
 <20210304034141.7062-8-brad@pensando.io>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <41b76da0-1f2a-ae2a-79fc-4ff1c79062f7@canonical.com>
Date:   Fri, 5 Mar 2021 12:22:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210304034141.7062-8-brad@pensando.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 04/03/2021 04:41, Brad Larson wrote:
> Add Pensando common and Elba SoC specific device nodes
> and corresponding binding documentation.
> 
> Signed-off-by: Brad Larson <brad@pensando.io>
> ---
>  .../bindings/gpio/pensando,elba-spics.txt     |  24 ++
>  .../devicetree/bindings/mmc/cdns,sdhci.yaml   |   2 +-
>  .../bindings/spi/cadence-quadspi.txt          |   1 +
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +

Hi,

dt-bindings go always to separate patches, at beginning of patchset.

>  arch/arm64/boot/dts/Makefile                  |   1 +
>  arch/arm64/boot/dts/pensando/Makefile         |   6 +
>  arch/arm64/boot/dts/pensando/elba-16core.dtsi | 171 ++++++++++
>  .../boot/dts/pensando/elba-asic-common.dtsi   | 113 +++++++
>  arch/arm64/boot/dts/pensando/elba-asic.dts    |   8 +
>  .../boot/dts/pensando/elba-flash-parts.dtsi   |  80 +++++
>  arch/arm64/boot/dts/pensando/elba.dtsi        | 310 ++++++++++++++++++

You need the board/vendor YAML file. See:
Documentation/devicetree/bindings/arm/

>  11 files changed, 717 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/gpio/pensando,elba-spics.txt
>  create mode 100644 arch/arm64/boot/dts/pensando/Makefile
>  create mode 100644 arch/arm64/boot/dts/pensando/elba-16core.dtsi
>  create mode 100644 arch/arm64/boot/dts/pensando/elba-asic-common.dtsi
>  create mode 100644 arch/arm64/boot/dts/pensando/elba-asic.dts
>  create mode 100644 arch/arm64/boot/dts/pensando/elba-flash-parts.dtsi
>  create mode 100644 arch/arm64/boot/dts/pensando/elba.dtsi
> 
> diff --git a/Documentation/devicetree/bindings/gpio/pensando,elba-spics.txt b/Documentation/devicetree/bindings/gpio/pensando,elba-spics.txt
> new file mode 100644
> index 000000000000..30f5f3275238
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/pensando,elba-spics.txt
> @@ -0,0 +1,24 @@
> +Pensando Elba SPI Chip Select Driver
> +
> +The Pensando Elba ASIC provides four SPI bus chip selects
> +
> +Required properties:
> +- compatible: Should be "pensando,elba-spics"
> +- reg: Address range of spics controller
> +- gpio-controller: Marks the device node as gpio controller
> +- #gpio-cells: Must be 2
> +
> +Example:
> +-------
> +spics: spics@307c2468 {
> +        compatible = "pensando,elba-spics";
> +        reg = <0x0 0x307c2468 0x0 0x4>;
> +        gpio-controller;
> +        #gpio-cells = <2>;
> +};
> +
> +&spi0 {
> +        num-cs = <4>;
> +        cs-gpios = <&spics 0 0>, <&spics 1 0>, <&porta 1 0>, <&porta 7 0>;
> +	...
> +}
> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> index af7442f73881..645ae696ba24 100644
> --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> @@ -122,7 +122,7 @@ unevaluatedProperties: false
>  examples:
>    - |
>      emmc: mmc@5a000000 {
> -        compatible = "socionext,uniphier-sd4hc", "cdns,sd4hc";
> +        compatible = "socionext,uniphier-sd4hc", "cdns,sd4hc", "pensando,elba-emmc";

Why are you doing this?

>          reg = <0x5a000000 0x400>;
>          interrupts = <0 78 4>;
>          clocks = <&clk 4>;
> diff --git a/Documentation/devicetree/bindings/spi/cadence-quadspi.txt b/Documentation/devicetree/bindings/spi/cadence-quadspi.txt
> index 8ace832a2d80..dbb346b2b1d7 100644
> --- a/Documentation/devicetree/bindings/spi/cadence-quadspi.txt
> +++ b/Documentation/devicetree/bindings/spi/cadence-quadspi.txt
> @@ -6,6 +6,7 @@ Required properties:
>  	For TI 66AK2G SoC - "ti,k2g-qspi", "cdns,qspi-nor".
>  	For TI AM654 SoC  - "ti,am654-ospi", "cdns,qspi-nor".
>  	For Intel LGM SoC - "intel,lgm-qspi", "cdns,qspi-nor".
> +	For Pensando SoC - "pensando,cdns-qspi".
>  - reg : Contains two entries, each of which is a tuple consisting of a
>  	physical address and length. The first entry is the address and
>  	length of the controller register set. The second entry is the
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index f6064d84a424..9a21d780c5e1 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -850,6 +850,8 @@ patternProperties:
>      description: Parallax Inc.
>    "^pda,.*":
>      description: Precision Design Associates, Inc.
> +  "^pensando,.*":
> +    description: Pensando Systems Inc.
>    "^pericom,.*":
>      description: Pericom Technology Inc.
>    "^pervasive,.*":
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
> index 000000000000..b0386864cfec
> --- /dev/null
> +++ b/arch/arm64/boot/dts/pensando/elba-16core.dtsi
> @@ -0,0 +1,171 @@
> +// SPDX-License-Identifier: GPL-2.0
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

Run the dtbs_check and build dtbs with W=1 - no warnings are usually
expected.

> +	};
> +};
> diff --git a/arch/arm64/boot/dts/pensando/elba-asic-common.dtsi b/arch/arm64/boot/dts/pensando/elba-asic-common.dtsi
> new file mode 100644
> index 000000000000..9623df208131
> --- /dev/null
> +++ b/arch/arm64/boot/dts/pensando/elba-asic-common.dtsi
> @@ -0,0 +1,113 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/ {
> +	model = "Elba ASIC Board";
> +
> +	aliases {
> +		serial0 = &uart0;
> +                spi0 = &spi0;
> +                spi1 = &qspi;
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

Generic node name needed, like in devicetree spec.

> +		compatible = "ti,tmp451";
> +		reg = <0x4c>;
> +	};

Here and everywhere else - line break between each node.

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
> index 000000000000..411c48457006
> --- /dev/null
> +++ b/arch/arm64/boot/dts/pensando/elba-asic.dts
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/dts-v1/;
> +
> +#include "elba.dtsi"
> +#include "elba-16core.dtsi"
> +#include "elba-asic-common.dtsi"
> +#include "elba-flash-parts.dtsi"
> diff --git a/arch/arm64/boot/dts/pensando/elba-flash-parts.dtsi b/arch/arm64/boot/dts/pensando/elba-flash-parts.dtsi
> new file mode 100644
> index 000000000000..1983de1a8403
> --- /dev/null
> +++ b/arch/arm64/boot/dts/pensando/elba-flash-parts.dtsi
> @@ -0,0 +1,80 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
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

No leading 0 in address and size.

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
> index 000000000000..72245e279483
> --- /dev/null
> +++ b/arch/arm64/boot/dts/pensando/elba.dtsi
> @@ -0,0 +1,310 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019-2021, Pensando Systems Inc.
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.

You have SPDX header. No boiler plate.

OK, I stopped...

Best regards,
Krzysztof
