Return-Path: <linux-spi+bounces-11210-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B24EC5D1B5
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 13:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 313C234E5D1
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 12:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D213246E6;
	Fri, 14 Nov 2025 12:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arduino.cc header.i=@arduino.cc header.b="R+DX+RHw"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD0231BC8D
	for <linux-spi@vger.kernel.org>; Fri, 14 Nov 2025 12:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763122757; cv=none; b=P4+e4Q8qkGqtG5pON5rAxnNKd09nJZDmNZH6I/kGP2xaWayLP22+FNVFGrqTtRNLjHYxyEplB9j/FpIQ/It3sEa5CdMscPga9F5ks+aUjOsufBpavgdmX1MX4K+0Tl2An8CADy5Ooy2I4NBj9AsEZJ2iySrue0p3xBw5pov32RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763122757; c=relaxed/simple;
	bh=eZESFWp4FVLOlj3+50fUX2v+L6Nz1IVV5h5kxPPjBVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PkaMcY9YzM7RTq3gt1VnzVNJS4/PBdLqXfujVlEpQpjj0uKKBKoJjGT+N/gZDGB4QuaGoR2M48Q82P5RL9LW0NxrL/XSbeEn1vXu5QxN+6HsJFA27LYSqaMQYNei/Q30W9uz+7elTHcO52geNFPbTaOa5s/EfqGno5Bwbvl8DsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arduino.cc; spf=pass smtp.mailfrom=arduino.cc; dkim=pass (1024-bit key) header.d=arduino.cc header.i=@arduino.cc header.b=R+DX+RHw; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arduino.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arduino.cc
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b73301e6ab5so253913066b.1
        for <linux-spi@vger.kernel.org>; Fri, 14 Nov 2025 04:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arduino.cc; s=google; t=1763122752; x=1763727552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0QIAPlcD+WNdHd40HL90XQ4jGkgCkS8OpeRgafZ8To=;
        b=R+DX+RHwlQ8CXG8Hu6KrB/3gD9iiHpYFsANO3UTlK1ian3F80JsnI8ZXKWbySgnmpO
         USMWCRdRKVow3665dXeI13g03OksVmj+nyooNPNO08sJw34y1N5yoaqvFP+b1+9OwNvf
         kKXlnezYnS1eA4exAZ3G6QL4vumi2qQ+B0+nI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763122752; x=1763727552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s0QIAPlcD+WNdHd40HL90XQ4jGkgCkS8OpeRgafZ8To=;
        b=AhPo1jfj9aZRMaBm82txPQzC9XNpBpuJbd9h/57ICeIcEYok8nRUHFZFXnEMBdKb4B
         Vb/1Xtqz+AxstorOKDz21KnFE/H8ZugvGz0pHo1QRMXtHitB13dQvdhU8ZiT+hGpMlb+
         l0/550s9m+cjwX0Wsi6l4L9RF7UUOicCLMR0dnkekibos5cTYYbKOYhSoIRx/KJ5v0PW
         itdW3OoNh9iNGCTebeLWsqQFnb+xz8jlY1rBVdeuv05A7b95KF6jkdzyFWNLyjHod+jk
         IjqGAB5ih18Cu/4twj6MuR7q0NDtQ2+f9tsC6VI9EQLjKEnQ42bIdeRdujb7nYTG8jUM
         F4gQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuaWtZCn9+kpYtGci5vvM0/M+Fr74lmvkVNmqkAQQALfelS2n+ceDWWFuuHEdLolVllODBygryNPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsFDydGxNwfFJxETEVdMrucJXlUMCTDu2rGyysfD9OxtiD9nwr
	I1Akfg8v29VcSiq4nEvohaPYd01FlOQMOnpjq6+6jmsOq1gKtBAPb2V+zOSf4l8THPQ=
X-Gm-Gg: ASbGncuZOkUu6oqn0O/S4qLqAGe4OYdeAV9lVSlPo51SAGUimqiVSQW0QtaBlTtbG66
	WSkI/flMRMSCjb6lpsgbkT5EQcmwMnbiTGl47bjppJExNmKjuniaKTAksAST17x65U6KocLbmbk
	GZ4xdQdgxkPxKYalkAnZkn1IgEDe+N105D+zyayoFH4CcbIrJf+tP54SGkCp5GiY2XINYFLc8YU
	C9PF/R5VFKiJYs1kJ9tj17zcs9ESSCrVrHC/l1ImHHrsp23o5FGSoC/WboV2p9UEuXSfqQBoUGP
	8rkSaSFlG7CN+IDXGOhXuJd5s1CqGrCQOM8vx6cUBOPR6CxQ1NSh8COVOoUNtPiFFYedzFKANCY
	S4pQ3D+hESDzMa1laAaWxo+ndJCdiOs3GRJ0bqhGgqcPIHboY5G1qWIUYH3RJZIiDOlznkvfJWh
	hIDa6YrsDGSVPy34q4k0ySPYFurt261pPvxz0m9CPKwfPDZDby5cJoWnFMEkWo8RcxKyTs7Q==
X-Google-Smtp-Source: AGHT+IHrd10LZ5t8g76QL1v7w4NtADCH/dW9OWc4jp/MknTRXDi4LURkNpFtmnIY6t7mZJert6RUXw==
X-Received: by 2002:a17:907:7e93:b0:b70:4757:eb01 with SMTP id a640c23a62f3a-b73678f47c5mr286472366b.32.1763122752252;
        Fri, 14 Nov 2025 04:19:12 -0800 (PST)
Received: from riccardo-work.fritz.box (host-82-52-164-74.retail.telecomitalia.it. [82.52.164.74])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fed6315sm375295666b.64.2025.11.14.04.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 04:19:12 -0800 (PST)
From: Riccardo Mereu <r.mereu.kernel@arduino.cc>
X-Google-Original-From: Riccardo Mereu <r.mereu@arduino.cc>
To: andersson@kernel.org,
	konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	broonie@kernel.org
Cc: linux@roeck-us.net,
	Jonathan.Cameron@huawei.com,
	wenswang@yeah.net,
	naresh.solanki@9elements.com,
	michal.simek@amd.com,
	nuno.sa@analog.com,
	chou.cosmo@gmail.com,
	grantpeltier93@gmail.com,
	eajames@linux.ibm.com,
	farouk.bouabid@cherry.de,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	m.facchin@arduino.cc,
	Riccardo Mereu <r.mereu@arduino.cc>
Subject: [PATCH v2 6/6] arm64: dts: qcom: qrb2210: add dts for Arduino unoq
Date: Fri, 14 Nov 2025 13:18:53 +0100
Message-ID: <20251114121853.16472-7-r.mereu@arduino.cc>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251114121853.16472-1-r.mereu@arduino.cc>
References: <20251114121853.16472-1-r.mereu@arduino.cc>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Arduino UnoQ is a single-board computer combining Qualcomm
Dragonwing™ QRB2210 microprocessor with STMicroelectronics STM32U585
microcontroller.
Support to a simply boot to shell environment includes:
- UART, I2C, SPI
- onboard LEDS
- eMMC
- WLAN and BT

Signed-off-by: Riccardo Mereu <r.mereu@arduino.cc>
---
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/qrb2210-arduino-imola.dts   | 456 ++++++++++++++++++
 2 files changed, 457 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 6f34d5ed331c..9f98a7f2cbb4 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -143,6 +143,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= qcs8550-aim300-aiot.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs9100-ride.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs9100-ride-r3.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qdu1000-idp.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= qrb2210-arduino-imola.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qrb2210-rb1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qrb4210-rb2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5.dtb
diff --git a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
new file mode 100644
index 000000000000..8de355a1bf6d
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
@@ -0,0 +1,456 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (c) 2025, Arduino SRL
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/leds/common.h>
+#include "agatti.dtsi"
+#include "pm4125.dtsi"
+
+/delete-node/ &cont_splash_memory;
+
+/ {
+	model = "Arduino UnoQ";
+	compatible = "arduino,imola", "qcom,qrb2210", "qcom,qcm2290";
+	chassis-type = "embedded";
+
+	aliases {
+		serial0 = &uart4;
+		serial1 = &uart2;
+		serial2 = &uart3;
+		sdhc1 = &sdhc_1;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		label = "gpio-keys";
+		pinctrl-0 = <&key_volp_n>, <&key_vold_n>;
+		pinctrl-names = "default";
+
+		key-volume-up {
+			label = "Volume Up";
+			linux,code = <KEY_VOLUMEUP>;
+			gpios = <&tlmm 96 GPIO_ACTIVE_LOW>;
+			debounce-interval = <15>;
+			linux,can-disable;
+			wakeup-source;
+		};
+
+		key-volume-down {
+			label = "Volume Down";
+			linux,code = <KEY_VOLUMEDOWN>;
+			gpios = <&tlmm 36 GPIO_ACTIVE_LOW>;
+			debounce-interval = <15>;
+			linux,can-disable;
+			wakeup-source;
+		};
+	};
+
+	leds: leds {
+		compatible = "gpio-leds";
+
+		led-bt {
+			label = "blue:bt";
+			function = LED_FUNCTION_BLUETOOTH;
+			color = <LED_COLOR_ID_BLUE>;
+			gpios = <&tlmm 47 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "bluetooth-power";
+			default-state = "off";
+		};
+
+		led-panic {
+			label = "red:panic";
+			function = LED_FUNCTION_INDICATOR;
+			color = <LED_COLOR_ID_RED>;
+			gpios = <&tlmm 39 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "none";
+			default-state = "off";
+			panic-indicator;
+		};
+
+		led-wlan {
+			label = "green:wlan";
+			function = LED_FUNCTION_WLAN;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&tlmm 40 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "phy0tx";
+			default-state = "off";
+		};
+
+		ledb: led-user-blue {
+			gpios = <&tlmm 60 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_BLUE>;
+		};
+
+		ledg: led-user-green {
+			gpios = <&tlmm 42 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_GREEN>;
+		};
+
+		ledr: led-user-red {
+			gpios = <&tlmm 41 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_RED>;
+		};
+	};
+
+	multi-led {
+		compatible = "leds-group-multicolor";
+		color = <LED_COLOR_ID_RGB>;
+		function = LED_FUNCTION_INDICATOR;
+		leds = <&ledr>, <&ledg>, <&ledb>;
+	};
+
+	/* PM4125 charger out, supplied by VBAT */
+	vph_pwr: regulator-vph-pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&gpi_dma0 {
+	status = "okay";
+};
+
+&gpu {
+	status = "okay";
+};
+
+&gpu_zap_shader {
+	firmware-name = "qcom/qcm2290/a702_zap.mbn";
+};
+
+&i2c0 {
+	clock-frequency = <100000>;
+
+	status = "okay";
+};
+
+&i2c1 {
+	clock-frequency = <100000>;
+
+	status = "okay";
+};
+
+&pm4125_vbus {
+	regulator-min-microamp = <500000>;
+	regulator-max-microamp = <500000>;
+
+	status = "okay";
+};
+
+&qupv3_id_0 {
+	status = "okay";
+};
+
+&remoteproc_adsp {
+	firmware-name = "qcom/qcm2290/adsp.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_mpss {
+	firmware-name = "qcom/qcm2290/modem.mbn";
+
+	status = "okay";
+};
+
+&rpm_requests {
+	regulators {
+		compatible = "qcom,rpm-pm2250-regulators";
+		vdd_s3-supply = <&vph_pwr>;
+		vdd_s4-supply = <&vph_pwr>;
+		vdd_l1_l2_l3_l5_l6_l7_l8_l9_l10_l11_l12-supply = <&pm4125_s3>;
+		vdd_l4_l17_l18_l19_l20_l21_l22-supply = <&vph_pwr>;
+		vdd_l13_l14_l15_l16-supply = <&pm4125_s4>;
+
+		pm4125_s3: s3 {
+			/* 0.4V-1.6625V -> 1.3V (Power tree requirements) */
+			regulator-min-microvolt = <1352000>;
+			regulator-max-microvolt = <1352000>;
+			regulator-boot-on;
+		};
+
+		pm4125_s4: s4 {
+			/* 1.2V-2.35V -> 2.05V (Power tree requirements) */
+			regulator-min-microvolt = <2072000>;
+			regulator-max-microvolt = <2072000>;
+			regulator-boot-on;
+		};
+
+		pm4125_l2: l2 {
+			/* LPDDR4X VDD2 */
+			regulator-min-microvolt = <1136000>;
+			regulator-max-microvolt = <1136000>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		pm4125_l3: l3 {
+			/* LPDDR4X VDDQ */
+			regulator-min-microvolt = <616000>;
+			regulator-max-microvolt = <616000>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		pm4125_l4: l4 {
+			/* max = 3.05V -> max = 2.7 to disable 3V signaling (SDHCI2) */
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2700000>;
+			regulator-allow-set-load;
+		};
+
+		pm4125_l5: l5 {
+			/* CSI/DSI */
+			regulator-min-microvolt = <1232000>;
+			regulator-max-microvolt = <1232000>;
+			regulator-allow-set-load;
+			regulator-boot-on;
+		};
+
+		pm4125_l6: l6 {
+			/* DRAM PLL */
+			regulator-min-microvolt = <928000>;
+			regulator-max-microvolt = <928000>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		pm4125_l7: l7 {
+			/* Wi-Fi CX */
+			regulator-min-microvolt = <664000>;
+			regulator-max-microvolt = <664000>;
+		};
+
+		pm4125_l10: l10 {
+			/* Wi-Fi RFA */
+			regulator-min-microvolt = <1304000>;
+			regulator-max-microvolt = <1304000>;
+		};
+
+		pm4125_l11: l11 {
+			/* ANX7625 DVDD1P0V/AVDD1P0V */
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1000000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		pm4125_l12: l12 {
+			/* USB PHYs */
+			regulator-min-microvolt = <928000>;
+			regulator-max-microvolt = <928000>;
+			regulator-allow-set-load;
+			regulator-boot-on;
+		};
+
+		pm4125_l13: l13 {
+			/* USB/QFPROM/PLLs */
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-allow-set-load;
+			regulator-boot-on;
+		};
+
+		pm4125_l14: l14 {
+			/* SDHCI1 EMMC VCCQ */
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-allow-set-load;
+			/* Broken hardware, never turn it off! */
+			regulator-always-on;
+		};
+
+		pm4125_l15: l15 {
+			/* VDDIO */
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-allow-set-load;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		pm4125_l20: l20 {
+			/* SDHCI1 EMMC */
+			regulator-min-microvolt = <2400000>;
+			regulator-max-microvolt = <3600000>;
+			regulator-allow-set-load;
+		};
+
+		pm4125_l21: l21 {
+			/* USB HS */
+			regulator-min-microvolt = <2960000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-allow-set-load;
+			regulator-boot-on;
+		};
+
+		pm4125_l22: l22 {
+			/* Wi-Fi VDD */
+			regulator-min-microvolt = <3312000>;
+			regulator-max-microvolt = <3312000>;
+		};
+	};
+};
+
+&sdhc_1 {
+	vmmc-supply = <&pm4125_l20>;
+	vqmmc-supply = <&pm4125_l14>;
+	pinctrl-0 = <&sdc1_state_on>;
+	pinctrl-1 = <&sdc1_state_off>;
+	pinctrl-names = "default", "sleep";
+	mmc-hs400-1_8v;
+	mmc-hs200-1_8v;
+	non-removable;
+	supports-cqe;
+	no-sdio;
+	no-sd;
+
+	status = "okay";
+};
+
+&spi5 {
+	status = "okay";
+
+	spidev@0 {
+		reg = <0>;
+		compatible = "arduino,unoq-mcu";
+		pinctrl-0 = <&spidev_cs>;
+		pinctrl-names = "default";
+	};
+};
+
+&tlmm {
+	spidev_cs: spidev-cs-state {
+		pins = "gpio17";
+		function = "gpio";
+		drive-strength = <16>;
+	};
+
+	jmisc_gpio18: jmisc-gpio18-state {
+		pins = "gpio18";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	jmisc_gpio28: jmisc-gpio28-state {
+		pins = "gpio28";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	key_vold_n: key-vold-n-state {
+		pins = "gpio36";
+		function = "gpio";
+		bias-pull-up;
+		output-disable;
+	};
+
+	key_volp_n: key-volp-n-state {
+		pins = "gpio96";
+		function = "gpio";
+		bias-pull-up;
+		output-disable;
+	};
+
+	jmisc_gpio98: jmisc-gpio98-state {
+		pins = "gpio98";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	jmisc_gpio99: jmisc-gpio99-state {
+		pins = "gpio99";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	jmisc_gpio100: jmisc-gpio100-state {
+		pins = "gpio100";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	jmisc_gpio101: jmisc-gpio101-state {
+		pins = "gpio101";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+};
+
+&uart2 {
+	status = "okay";
+};
+
+/* UART connected to Bluetooth */
+&uart3 {
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,wcn3988-bt";
+
+		vddio-supply = <&pm4125_l15>;
+		vddxo-supply = <&pm4125_l13>;
+		vddrf-supply = <&pm4125_l10>;
+		vddch0-supply = <&pm4125_l22>;
+		enable-gpios = <&tlmm 87 GPIO_ACTIVE_HIGH>;
+		max-speed = <3000000>;
+	};
+};
+
+/* UART exposed in JCTL */
+&uart4 {
+	compatible = "qcom,geni-debug-uart";
+
+	status = "okay";
+};
+
+&usb {
+	status = "okay";
+};
+
+&usb_hsphy {
+	vdd-supply = <&pm4125_l12>;
+	vdda-pll-supply = <&pm4125_l13>;
+	vdda-phy-dpdm-supply = <&pm4125_l21>;
+
+	status = "okay";
+};
+
+&usb_qmpphy {
+	vdda-phy-supply = <&pm4125_l12>;
+	vdda-pll-supply = <&pm4125_l13>;
+
+	status = "okay";
+};
+
+&wifi {
+	vdd-0.8-cx-mx-supply = <&pm4125_l7>;
+	vdd-1.8-xo-supply = <&pm4125_l13>;
+	vdd-1.3-rfa-supply = <&pm4125_l10>;
+	vdd-3.3-ch0-supply = <&pm4125_l22>;
+	qcom,ath10k-calibration-variant = "Arduino_UnoQ";
+	firmware-name = "qcm2290";
+
+	status = "okay";
+};
+
+&xo_board {
+	clock-frequency = <38400000>;
+};
-- 
2.51.2


