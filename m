Return-Path: <linux-spi+bounces-11160-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78481C4EF0A
	for <lists+linux-spi@lfdr.de>; Tue, 11 Nov 2025 17:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E9584E0F86
	for <lists+linux-spi@lfdr.de>; Tue, 11 Nov 2025 16:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E57D36B062;
	Tue, 11 Nov 2025 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SW5TQsbQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2F736A038;
	Tue, 11 Nov 2025 16:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762877398; cv=none; b=fiby/Wat2ck8+uqTzdgp+ICybCCXlrzWzfT5UUuYfc1hIkw/47+olta2ql0MhB2FIyvpOE6y5l+Oznh8Fda7JuEidecgoPjtOjkuldK4TPb8peb5QEhUh7S90ZEjAi0Ew37PGUDc+iRGzNjvxs9UkChFEhp/UTDBMZXgF3MFIo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762877398; c=relaxed/simple;
	bh=w7m9fQPsRzVUQAZ7PhcDg7Tv89qmbszaI78Tk9mzzc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLQJBurrRw7oJjbMkNBZpbS1dQRlxpeMyTqq4yBB4l6w3eCxyq1V5jWnzNSRaXncXsarJOUoy3cL311tBM4ekGRDqJbDa2J+LQGUy2QP7KleXfUrnwMqs5xte3yZrH5CVEKc40m9ZFItPV5tsJ3vTfIr4tPz5QdRM+zWeBpMxcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SW5TQsbQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166D3C4CEFB;
	Tue, 11 Nov 2025 16:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762877397;
	bh=w7m9fQPsRzVUQAZ7PhcDg7Tv89qmbszaI78Tk9mzzc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SW5TQsbQtfMKY4XWxjSyCLUQfUjcMtjn3aO4O7WLhB7AwHiTpucQCXm7eh7sgOCzq
	 xRYLTVGwqzVWuRYzCPdHboBj6idLl3o6MKT+T7o2qmt0+4lqh4ECukWEBEBKhyOjAz
	 pxDahFWRunF245xsPY9kXyc/8BY/lPK22HdtA/XCLZlJgogx6OjxJsgMmPM/GO53mL
	 DrCib4Ttn9TfV3spnJOCJRaSN5TuFDtAHEdOXei95mDuK5Z/ppfyyFa+jRCQt1an4O
	 OHdXn+hhWvhmIZuIUDU6HbT+hwHIv0N25u7zvNIWWYr8T8mAMJ0wB7SbTZm7EJp/Li
	 RTQVM3bB4OFVg==
Date: Tue, 11 Nov 2025 10:14:08 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Riccardo Mereu <r.mereu.kernel@arduino.cc>
Cc: konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, broonie@kernel.org, linux@roeck-us.net, 
	Jonathan.Cameron@huawei.com, wenswang@yeah.net, naresh.solanki@9elements.com, 
	michal.simek@amd.com, nuno.sa@analog.com, chou.cosmo@gmail.com, 
	grantpeltier93@gmail.com, eajames@linux.ibm.com, farouk.bouabid@cherry.de, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, mm.facchin@arduino.cc, Riccardo Mereu <r.mereu@arduino.cc>
Subject: Re: [PATCH 5/5] arm64: dts: qcom: unoq: add dts for arduino unoq
Message-ID: <bcybkiecgydjp7w6vumxkobcvgvljiv46wcr7llvuubzix5r4v@xi2miltknfmw>
References: <20251106153119.266840-1-r.mereu@arduino.cc>
 <20251106153119.266840-6-r.mereu@arduino.cc>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251106153119.266840-6-r.mereu@arduino.cc>

On Thu, Nov 06, 2025 at 04:31:19PM +0100, Riccardo Mereu wrote:
> From: Riccardo Mereu <r.mereu.kernel@arduino.cc>

Please make the subject:

"arm64: dts: qcom: qrb2210: Add Arduino UnoQ board"

> 
> Arduino UnoQ is a single-board computer combining Qualcomm
> Dragonwing™ QRB2210 microprocessor with STMicroelectronics STM32U585
> microcontroller.
> Support to a simply boot to shell environment includes:
> - UART, I2C, SPI
> - onboard LEDS
> - eMMC
> - WLAN and BT
> 

Nice, some small things to improve below (and above).

> Signed-off-by: Riccardo Mereu <r.mereu@arduino.cc>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../boot/dts/qcom/qrb2210-arduino-imola.dts   | 456 ++++++++++++++++++
>  2 files changed, 457 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 6f34d5ed331c..9f98a7f2cbb4 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -143,6 +143,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= qcs8550-aim300-aiot.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs9100-ride.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs9100-ride-r3.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qdu1000-idp.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= qrb2210-arduino-imola.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qrb2210-rb1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qrb4210-rb2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5.dtb
> diff --git a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
> new file mode 100644
> index 000000000000..83e7f3e9da76
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
> @@ -0,0 +1,456 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * Copyright (c) 2025, Arduino SA
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/leds/common.h>
> +#include "agatti.dtsi"
> +#include "pm4125.dtsi"
> +
> +/delete-node/ &cont_splash_memory;
> +
> +/ {
> +        model = "Arduino UnoQ";
> +        compatible = "arduino,imola", "qcom,qrb2210", "qcom,qcm2290";

chassis-type = "embedded";

> +
> +        aliases {
> +                serial0 = &uart4;
> +                serial1 = &uart2;
> +                serial2 = &uart3;
> +                sdhc1 = &sdhc_1;
> +        };
> +
> +        chosen {
> +                stdout-path = "serial0:115200n8";
> +        };
> +
> +        gpio-keys {
> +                compatible = "gpio-keys";
> +                label = "gpio-keys";
> +
> +                pinctrl-0 = <&key_volp_n>, <&key_vold_n>;
> +                pinctrl-names = "default";
> +
> +                key-volume-up {
> +                        label = "Volume Up";
> +                        linux,code = <KEY_VOLUMEUP>;
> +                        gpios = <&tlmm 96 GPIO_ACTIVE_LOW>;
> +                        debounce-interval = <15>;
> +                        linux,can-disable;
> +                        wakeup-source;
> +                };
> +
> +                key-volume-down {
> +                        label = "Volume Down";
> +                        linux,code = <KEY_VOLUMEDOWN>;
> +                        gpios = <&tlmm 36 GPIO_ACTIVE_LOW>;
> +                        debounce-interval = <15>;
> +                        linux,can-disable;
> +                        wakeup-source;
> +                };
> +        };
> +
> +        leds: leds {
> +                compatible = "gpio-leds";
> +
> +                ledpanic: led-panic {
> +                        label = "red:panic";
> +                        function = LED_FUNCTION_INDICATOR;
> +                        color = <LED_COLOR_ID_RED>;
> +                        gpios = <&tlmm 39 GPIO_ACTIVE_HIGH>;
> +                        linux,default-trigger = "none";
> +                        default-state = "off";
> +                        panic-indicator;
> +                };
> +
> +                ledwlan: led-wlan {
> +                        label = "green:wlan";
> +                        function = LED_FUNCTION_WLAN;
> +                        color = <LED_COLOR_ID_GREEN>;
> +                        gpios = <&tlmm 40 GPIO_ACTIVE_HIGH>;
> +                        linux,default-trigger = "phy0tx";
> +                        default-state = "off";
> +                };
> +
> +                ledbt: led-bt {
> +                        label = "blue:bt";
> +                        function = LED_FUNCTION_BLUETOOTH;
> +                        color = <LED_COLOR_ID_BLUE>;
> +                        gpios = <&tlmm 47 GPIO_ACTIVE_HIGH>;
> +                        linux,default-trigger = "bluetooth-power";
> +                        default-state = "off";
> +                };
> +
> +                ledr: led-user-red {
> +                        gpios = <&tlmm 41 GPIO_ACTIVE_HIGH>;
> +                        color = <LED_COLOR_ID_RED>;
> +                };
> +
> +                ledg: led-user-green {
> +                        gpios = <&tlmm 42 GPIO_ACTIVE_HIGH>;
> +                        color = <LED_COLOR_ID_GREEN>;
> +                };
> +
> +                ledb: led-user-blue {
> +                        gpios = <&tlmm 60 GPIO_ACTIVE_HIGH>;
> +                        color = <LED_COLOR_ID_BLUE>;
> +                };
> +        };
> +
> +        multi-led {
> +                compatible = "leds-group-multicolor";
> +                color = <LED_COLOR_ID_RGB>;
> +                function = LED_FUNCTION_INDICATOR;
> +                leds = <&ledr>, <&ledg>, <&ledb>;
> +        };
> +
> +        /* PM4125 charger out, supplied by VBAT */
> +        vph_pwr: regulator-vph-pwr {
> +                compatible = "regulator-fixed";
> +                regulator-name = "vph_pwr";
> +                regulator-min-microvolt = <3700000>;
> +                regulator-max-microvolt = <3700000>;
> +                regulator-always-on;
> +                regulator-boot-on;
> +        };
> +};
> +
> +&gpi_dma0 {
> +        status = "okay";
> +};
> +
> +&gpu {
> +        status = "okay";
> +};
> +
> +&gpu_zap_shader {
> +        firmware-name = "qcom/qcm2290/a702_zap.mbn";
> +};
> +
> +&pm4125_vbus {
> +        regulator-min-microamp = <500000>;
> +        regulator-max-microamp = <500000>;
> +
> +        status = "okay";
> +};
> +
> +&qupv3_id_0 {
> +        status = "okay";
> +};
> +
> +&remoteproc_adsp {
> +        firmware-name = "qcom/qcm2290/adsp.mbn";
> +
> +        status = "okay";
> +};
> +
> +&remoteproc_mpss {
> +        firmware-name = "qcom/qcm2290/modem.mbn";
> +
> +        status = "okay";
> +};
> +
> +&rpm_requests {
> +        regulators {
> +                compatible = "qcom,rpm-pm2250-regulators";
> +                vdd_s3-supply = <&vph_pwr>;
> +                vdd_s4-supply = <&vph_pwr>;
> +                vdd_l1_l2_l3_l5_l6_l7_l8_l9_l10_l11_l12-supply = <&pm4125_s3>;
> +                vdd_l4_l17_l18_l19_l20_l21_l22-supply = <&vph_pwr>;
> +                vdd_l13_l14_l15_l16-supply = <&pm4125_s4>;
> +
> +                pm4125_s3: s3 {
> +                        /* 0.4V-1.6625V -> 1.3V (Power tree requirements) */
> +                        regulator-min-microvolt = <1352000>;
> +                        regulator-max-microvolt = <1352000>;
> +                        regulator-boot-on;
> +                };
> +
> +                pm4125_s4: s4 {
> +                        /* 1.2V-2.35V -> 2.05V (Power tree requirements) */
> +                        regulator-min-microvolt = <2072000>;
> +                        regulator-max-microvolt = <2072000>;
> +                        regulator-boot-on;
> +                };
> +
> +                pm4125_l2: l2 {
> +                        /* LPDDR4X VDD2 */
> +                        regulator-min-microvolt = <1136000>;
> +                        regulator-max-microvolt = <1136000>;
> +                        regulator-always-on;
> +                        regulator-boot-on;
> +                };
> +
> +                pm4125_l3: l3 {
> +                        /* LPDDR4X VDDQ */
> +                        regulator-min-microvolt = <616000>;
> +                        regulator-max-microvolt = <616000>;
> +                        regulator-always-on;
> +                        regulator-boot-on;
> +                };
> +
> +                pm4125_l4: l4 {
> +                        /* max = 3.05V -> max = 2.7 to disable 3V signaling (SDHCI2) */
> +                        regulator-min-microvolt = <1800000>;
> +                        regulator-max-microvolt = <2700000>;
> +                        regulator-allow-set-load;
> +                };
> +
> +                pm4125_l5: l5 {
> +                        /* CSI/DSI */
> +                        regulator-min-microvolt = <1232000>;
> +                        regulator-max-microvolt = <1232000>;
> +                        regulator-allow-set-load;
> +                        regulator-boot-on;
> +                };
> +
> +                pm4125_l6: l6 {
> +                        /* DRAM PLL */
> +                        regulator-min-microvolt = <928000>;
> +                        regulator-max-microvolt = <928000>;
> +                        regulator-always-on;
> +                        regulator-boot-on;
> +                };
> +
> +                pm4125_l7: l7 {
> +                        /* Wi-Fi CX */
> +                        regulator-min-microvolt = <664000>;
> +                        regulator-max-microvolt = <664000>;
> +                };
> +
> +                pm4125_l10: l10 {
> +                        /* Wi-Fi RFA */
> +                        regulator-min-microvolt = <1304000>;
> +                        regulator-max-microvolt = <1304000>;
> +                };
> +
> +                pm4125_l11: l11 {
> +                        /* ANX7625 DVDD1P0V/AVDD1P0V */
> +                        regulator-min-microvolt = <1000000>;
> +                        regulator-max-microvolt = <1000000>;
> +                        regulator-boot-on;
> +                        regulator-always-on;
> +                };
> +
> +                pm4125_l12: l12 {
> +                        /* USB PHYs */
> +                        regulator-min-microvolt = <928000>;
> +                        regulator-max-microvolt = <928000>;
> +                        regulator-allow-set-load;
> +                        regulator-boot-on;
> +                };
> +
> +                pm4125_l13: l13 {
> +                        /* USB/QFPROM/PLLs */
> +                        regulator-min-microvolt = <1800000>;
> +                        regulator-max-microvolt = <1800000>;
> +                        regulator-allow-set-load;
> +                        regulator-boot-on;
> +                };
> +
> +                pm4125_l14: l14 {
> +                        /* SDHCI1 EMMC VCCQ */
> +                        regulator-min-microvolt = <1800000>;
> +                        regulator-max-microvolt = <1800000>;
> +                        regulator-allow-set-load;
> +                        /* Broken hardware, never turn it off! */
> +                        regulator-always-on;
> +                };
> +
> +                pm4125_l15: l15 {
> +                        /* VDDIO */
> +                        regulator-min-microvolt = <1800000>;
> +                        regulator-max-microvolt = <1800000>;
> +                        regulator-allow-set-load;
> +                        regulator-always-on;
> +                        regulator-boot-on;
> +                };
> +
> +                pm4125_l20: l20 {
> +                        /* SDHCI1 EMMC */
> +                        regulator-min-microvolt = <2400000>;
> +                        regulator-max-microvolt = <3600000>;
> +                        regulator-allow-set-load;
> +                };
> +
> +                pm4125_l21: l21 {
> +                        /* USB HS */
> +                        regulator-min-microvolt = <2960000>;
> +                        regulator-max-microvolt = <3300000>;
> +                        regulator-allow-set-load;
> +                        regulator-boot-on;
> +                };
> +
> +                pm4125_l22: l22 {
> +                        /* Wi-Fi VDD */
> +                        regulator-min-microvolt = <3312000>;
> +                        regulator-max-microvolt = <3312000>;
> +                };
> +        };
> +};
> +
> +&sdhc_1 {
> +        vmmc-supply = <&pm4125_l20>;
> +        vqmmc-supply = <&pm4125_l14>;
> +        pinctrl-0 = <&sdc1_state_on>;
> +        pinctrl-1 = <&sdc1_state_off>;
> +        pinctrl-names = "default", "sleep";
> +        mmc-hs400-1_8v;
> +        mmc-hs200-1_8v;
> +        non-removable;
> +        supports-cqe;
> +        no-sdio;
> +        no-sd;
> +
> +        status = "okay";
> +};
> +
> +&tlmm {
> +        spidev_cs: spidev-cs-state {
> +                pins = "gpio17";
> +                function = "gpio";
> +                drive-strength = <16>;
> +        };
> +
> +        jmisc_gpio18: jmisc-gpio18-state {
> +                pins = "gpio18";
> +                function = "gpio";
> +                drive-strength = <2>;
> +                bias-pull-down;
> +        };
> +
> +        jmisc_gpio28: jmisc-gpio28-state {
> +                pins = "gpio28";
> +                function = "gpio";
> +                drive-strength = <2>;
> +                bias-pull-down;
> +        };
> +
> +        key_vold_n: key-vold-n-state {
> +                pins = "gpio36";
> +                function = "gpio";
> +                bias-pull-up;
> +                output-disable;
> +        };
> +
> +        key_volp_n: key-volp-n-state {
> +                pins = "gpio96";
> +                function = "gpio";
> +                bias-pull-up;
> +                output-disable;
> +        };
> +
> +        jmisc_gpio98: jmisc-gpio98-state {
> +                pins = "gpio98";
> +                function = "gpio";
> +                drive-strength = <2>;
> +                bias-pull-down;
> +        };
> +
> +        jmisc_gpio99: jmisc-gpio99-state {
> +                pins = "gpio99";
> +                function = "gpio";
> +                drive-strength = <2>;
> +                bias-pull-down;
> +        };
> +
> +        jmisc_gpio100: jmisc-gpio100-state {
> +                pins = "gpio100";
> +                function = "gpio";
> +                drive-strength = <2>;
> +                bias-pull-down;
> +        };
> +
> +        jmisc_gpio101: jmisc-gpio101-state {
> +                pins = "gpio101";
> +                function = "gpio";
> +                drive-strength = <2>;
> +                bias-pull-down;
> +        };
> +};
> +
> +&i2c0 {

Please see the "ordering of Nodes" section in
Documentation/devicetree/bindings/dts-coding-style.rst

Regards,
Bjorn

> +        clock-frequency = <100000>;
> +
> +        status = "okay";
> +};
> +
> +&i2c1 {
> +        clock-frequency = <100000>;
> +
> +        status = "okay";
> +};
> +
> +&uart2 {
> +        status = "okay";
> +};
> +
> +/* UART connected to Bluetooth */
> +&uart3 {
> +        status = "okay";
> +
> +        bluetooth {
> +                compatible = "qcom,wcn3988-bt";
> +
> +                vddio-supply = <&pm4125_l15>;
> +                vddxo-supply = <&pm4125_l13>;
> +                vddrf-supply = <&pm4125_l10>;
> +                vddch0-supply = <&pm4125_l22>;
> +                enable-gpios = <&tlmm 87 GPIO_ACTIVE_HIGH>;
> +                max-speed = <3000000>;
> +        };
> +};
> +
> +/* UART connected to JCTL */
> +&uart4 {
> +        compatible = "qcom,geni-debug-uart";
> +
> +        status = "okay";
> +};
> +
> +&spi5 {
> +        status = "okay";
> +
> +        spidev@0 {
> +                reg = <0>;
> +                compatible = "arduino,mcu";
> +                pinctrl-0 = <&spidev_cs>;
> +                pinctrl-names = "default";
> +        };
> +};
> +
> +&usb {
> +        status = "okay";
> +};
> +
> +&usb_hsphy {
> +        vdd-supply = <&pm4125_l12>;
> +        vdda-pll-supply = <&pm4125_l13>;
> +        vdda-phy-dpdm-supply = <&pm4125_l21>;
> +
> +        status = "okay";
> +};
> +
> +&usb_qmpphy {
> +        vdda-phy-supply = <&pm4125_l12>;
> +        vdda-pll-supply = <&pm4125_l13>;
> +
> +        status = "okay";
> +};
> +
> +&wifi {
> +        vdd-0.8-cx-mx-supply = <&pm4125_l7>;
> +        vdd-1.8-xo-supply = <&pm4125_l13>;
> +        vdd-1.3-rfa-supply = <&pm4125_l10>;
> +        vdd-3.3-ch0-supply = <&pm4125_l22>;
> +        qcom,ath10k-calibration-variant = "Arduino_UnoQ";
> +        firmware-name = "qcm2290";
> +
> +        status = "okay";
> +};
> +
> +&xo_board {
> +        clock-frequency = <38400000>;
> +};
> -- 
> 2.51.2
> 

