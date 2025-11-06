Return-Path: <linux-spi+bounces-11093-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F75C3C15A
	for <lists+linux-spi@lfdr.de>; Thu, 06 Nov 2025 16:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CFC81B21C83
	for <lists+linux-spi@lfdr.de>; Thu,  6 Nov 2025 15:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901B232E12D;
	Thu,  6 Nov 2025 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arduino.cc header.i=@arduino.cc header.b="ImI6Ojoi"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F0B2C0303
	for <linux-spi@vger.kernel.org>; Thu,  6 Nov 2025 15:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762443094; cv=none; b=f3Aich8FCVyMBJu5iFnad8Vvivuc9hXhbBMYZYRI3SD1OvSyuMb801BoIPq4SgmZaGUIz3abbokBK6VirOvd3NmRluE9l2NrlWiQQP7sU2/uvzvpm6skPox3Z3cHZJpG5yprhW5QLcHBClYLJQ1dj04fTtfvSGpwtvrAwqphxO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762443094; c=relaxed/simple;
	bh=5B4Xn6KMT6bnOoj0Luy4yJVa/EzHk5+WSMQt3P7uD9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fE3PtujzDkvGaVNpEujbDL9+iQfCXEx9hYiV+Isil4HXtDJU+rQ1UhOSCsLtD+GUst4BLMSZXK0hBTNDqf9fKxK0uTr6KYqp1rhC8xhSztbBbhAQcc5d8aLaVaQIA7fTv3yOwed4zV2InXePjSC6X8Bb93Y/unoH12nK5UlC25A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arduino.cc; spf=pass smtp.mailfrom=arduino.cc; dkim=pass (1024-bit key) header.d=arduino.cc header.i=@arduino.cc header.b=ImI6Ojoi; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arduino.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arduino.cc
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso1278861f8f.1
        for <linux-spi@vger.kernel.org>; Thu, 06 Nov 2025 07:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arduino.cc; s=google; t=1762443088; x=1763047888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ey5X+0gIhe5Z/c55scS15gTtf6rdR80+WTGhiV8lPvw=;
        b=ImI6OjoinurSa7SSRGZt5++zOnM8B8emgxFr4IfiNHWDjCxRoYIkyVReapxAV/E92l
         dxjJkgQ790SLyri9Y9LVWYWFlUtVlq+GYgD5n435os84LMMVxkdQhzfI/rYdwTA+hv0p
         l8umQZh1DIQDM+OaLUjOyA/ShGR+D5Qgnu6Ug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762443088; x=1763047888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ey5X+0gIhe5Z/c55scS15gTtf6rdR80+WTGhiV8lPvw=;
        b=m2mgcK9vZJf8eSCh43z25nwWfQCfmgfIh5vTEcMOzAyS2EnQDfAqoYFajtni9+8JBw
         f/dAcqLUTpaV9BkicKTtrW5XOR9bDhYIp8J1jptpK9bqsvDAEhzk0hT2lp+ZQB4oArCv
         IE+Ou8uB+2HsSRqB4wICxcZwC9Sq/qIvssggwPG9Mid/wHDG8rapy2EjXlpkz82WAEfo
         YWFNhPy9sX/HZ4TJJki296OQE9YTTOGnlfs28L1wYSQnNyOBLdVrhobSM+PPnQwCnw3b
         VZrD0AG2an5tqmrq1L91w30GCm44G3JwWyWc8gDr+lTFzrjv0VbFIxf/GZ01CMYThFZd
         LxbA==
X-Forwarded-Encrypted: i=1; AJvYcCVoxBE9JmH9V08av7mA+n7gz5FH7+SrW5MaV0gpADZBU43XfVONoAc2HqFaFLwkjWue+2teIb4afI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIQRkV2K/cLXOvki9vMjYeW6x2P7t2POlK4Ni63/wOWKwVk39u
	z/ixxZ2gIaYw1wst03H/65/c8THSehZoPHAdPVM7KgQb1b78zHYMRO3HU3gQFxvzdW0=
X-Gm-Gg: ASbGncufOcUo7U6L9jUB/I8sCKbXUK83ypa1O+pLDeKbv+M0sJYUH9ivaw+Rhsfokbi
	zv5mga7olydkr2NZ+uCzsEgBT/j7Q0M5Z+52MAZV5MAAH2US/k/masV7QMbaGQ5Y+L2paJH2DhG
	reZMQMl/T02cPee6NWyDcvPY/unQbEf1ySnoRBjc9EopIQexHK3/eP4epYychIcPr2/WcZidNj0
	7ZFEhdO8POBK/I9BNQPQPkCsF8qmqiXLYkid5LRuyHqNIPqc0+iZ9nfDkuKMxsCrPUQfyxfEF5L
	tOCJFXYMael7Pu3JJaFkS41WJWOA/tu5X5wFzflFalX5Pup566hKciyKXhuGXU0m4JVbcXIBCZ6
	07Nu+ZBdm+wMazyRC44s3exq4/ngB8qDhEZfGTh17M2soKebAhz3LS4+XRU/1ELbbKjWmF3QnUU
	iltQibkiniqkByp2BoG5grOsSxar0dg3clmnY=
X-Google-Smtp-Source: AGHT+IFDtaikcG7OtQDnbnolkjzqwvJpTJE8dT4I0+3TeQn2A4bXFRy6GwuqhOuS6LckO5djP+ZKOw==
X-Received: by 2002:a05:6000:430e:b0:429:e99a:5891 with SMTP id ffacd0b85a97d-429eb17328bmr3369739f8f.18.1762443088362;
        Thu, 06 Nov 2025 07:31:28 -0800 (PST)
Received: from riccardo-work (public.toolboxoffice.it. [213.215.163.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb49a079sm5966719f8f.32.2025.11.06.07.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 07:31:27 -0800 (PST)
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
	mm.facchin@arduino.cc,
	Riccardo Mereu <r.mereu.kernel@arduino.cc>,
	Riccardo Mereu <r.mereu@arduino.cc>
Subject: [PATCH 5/5] arm64: dts: qcom: unoq: add dts for arduino unoq
Date: Thu,  6 Nov 2025 16:31:19 +0100
Message-ID: <20251106153119.266840-6-r.mereu@arduino.cc>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251106153119.266840-1-r.mereu@arduino.cc>
References: <20251106153119.266840-1-r.mereu@arduino.cc>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Riccardo Mereu <r.mereu.kernel@arduino.cc>

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
index 000000000000..83e7f3e9da76
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
@@ -0,0 +1,456 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (c) 2025, Arduino SA
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
+        model = "Arduino UnoQ";
+        compatible = "arduino,imola", "qcom,qrb2210", "qcom,qcm2290";
+
+        aliases {
+                serial0 = &uart4;
+                serial1 = &uart2;
+                serial2 = &uart3;
+                sdhc1 = &sdhc_1;
+        };
+
+        chosen {
+                stdout-path = "serial0:115200n8";
+        };
+
+        gpio-keys {
+                compatible = "gpio-keys";
+                label = "gpio-keys";
+
+                pinctrl-0 = <&key_volp_n>, <&key_vold_n>;
+                pinctrl-names = "default";
+
+                key-volume-up {
+                        label = "Volume Up";
+                        linux,code = <KEY_VOLUMEUP>;
+                        gpios = <&tlmm 96 GPIO_ACTIVE_LOW>;
+                        debounce-interval = <15>;
+                        linux,can-disable;
+                        wakeup-source;
+                };
+
+                key-volume-down {
+                        label = "Volume Down";
+                        linux,code = <KEY_VOLUMEDOWN>;
+                        gpios = <&tlmm 36 GPIO_ACTIVE_LOW>;
+                        debounce-interval = <15>;
+                        linux,can-disable;
+                        wakeup-source;
+                };
+        };
+
+        leds: leds {
+                compatible = "gpio-leds";
+
+                ledpanic: led-panic {
+                        label = "red:panic";
+                        function = LED_FUNCTION_INDICATOR;
+                        color = <LED_COLOR_ID_RED>;
+                        gpios = <&tlmm 39 GPIO_ACTIVE_HIGH>;
+                        linux,default-trigger = "none";
+                        default-state = "off";
+                        panic-indicator;
+                };
+
+                ledwlan: led-wlan {
+                        label = "green:wlan";
+                        function = LED_FUNCTION_WLAN;
+                        color = <LED_COLOR_ID_GREEN>;
+                        gpios = <&tlmm 40 GPIO_ACTIVE_HIGH>;
+                        linux,default-trigger = "phy0tx";
+                        default-state = "off";
+                };
+
+                ledbt: led-bt {
+                        label = "blue:bt";
+                        function = LED_FUNCTION_BLUETOOTH;
+                        color = <LED_COLOR_ID_BLUE>;
+                        gpios = <&tlmm 47 GPIO_ACTIVE_HIGH>;
+                        linux,default-trigger = "bluetooth-power";
+                        default-state = "off";
+                };
+
+                ledr: led-user-red {
+                        gpios = <&tlmm 41 GPIO_ACTIVE_HIGH>;
+                        color = <LED_COLOR_ID_RED>;
+                };
+
+                ledg: led-user-green {
+                        gpios = <&tlmm 42 GPIO_ACTIVE_HIGH>;
+                        color = <LED_COLOR_ID_GREEN>;
+                };
+
+                ledb: led-user-blue {
+                        gpios = <&tlmm 60 GPIO_ACTIVE_HIGH>;
+                        color = <LED_COLOR_ID_BLUE>;
+                };
+        };
+
+        multi-led {
+                compatible = "leds-group-multicolor";
+                color = <LED_COLOR_ID_RGB>;
+                function = LED_FUNCTION_INDICATOR;
+                leds = <&ledr>, <&ledg>, <&ledb>;
+        };
+
+        /* PM4125 charger out, supplied by VBAT */
+        vph_pwr: regulator-vph-pwr {
+                compatible = "regulator-fixed";
+                regulator-name = "vph_pwr";
+                regulator-min-microvolt = <3700000>;
+                regulator-max-microvolt = <3700000>;
+                regulator-always-on;
+                regulator-boot-on;
+        };
+};
+
+&gpi_dma0 {
+        status = "okay";
+};
+
+&gpu {
+        status = "okay";
+};
+
+&gpu_zap_shader {
+        firmware-name = "qcom/qcm2290/a702_zap.mbn";
+};
+
+&pm4125_vbus {
+        regulator-min-microamp = <500000>;
+        regulator-max-microamp = <500000>;
+
+        status = "okay";
+};
+
+&qupv3_id_0 {
+        status = "okay";
+};
+
+&remoteproc_adsp {
+        firmware-name = "qcom/qcm2290/adsp.mbn";
+
+        status = "okay";
+};
+
+&remoteproc_mpss {
+        firmware-name = "qcom/qcm2290/modem.mbn";
+
+        status = "okay";
+};
+
+&rpm_requests {
+        regulators {
+                compatible = "qcom,rpm-pm2250-regulators";
+                vdd_s3-supply = <&vph_pwr>;
+                vdd_s4-supply = <&vph_pwr>;
+                vdd_l1_l2_l3_l5_l6_l7_l8_l9_l10_l11_l12-supply = <&pm4125_s3>;
+                vdd_l4_l17_l18_l19_l20_l21_l22-supply = <&vph_pwr>;
+                vdd_l13_l14_l15_l16-supply = <&pm4125_s4>;
+
+                pm4125_s3: s3 {
+                        /* 0.4V-1.6625V -> 1.3V (Power tree requirements) */
+                        regulator-min-microvolt = <1352000>;
+                        regulator-max-microvolt = <1352000>;
+                        regulator-boot-on;
+                };
+
+                pm4125_s4: s4 {
+                        /* 1.2V-2.35V -> 2.05V (Power tree requirements) */
+                        regulator-min-microvolt = <2072000>;
+                        regulator-max-microvolt = <2072000>;
+                        regulator-boot-on;
+                };
+
+                pm4125_l2: l2 {
+                        /* LPDDR4X VDD2 */
+                        regulator-min-microvolt = <1136000>;
+                        regulator-max-microvolt = <1136000>;
+                        regulator-always-on;
+                        regulator-boot-on;
+                };
+
+                pm4125_l3: l3 {
+                        /* LPDDR4X VDDQ */
+                        regulator-min-microvolt = <616000>;
+                        regulator-max-microvolt = <616000>;
+                        regulator-always-on;
+                        regulator-boot-on;
+                };
+
+                pm4125_l4: l4 {
+                        /* max = 3.05V -> max = 2.7 to disable 3V signaling (SDHCI2) */
+                        regulator-min-microvolt = <1800000>;
+                        regulator-max-microvolt = <2700000>;
+                        regulator-allow-set-load;
+                };
+
+                pm4125_l5: l5 {
+                        /* CSI/DSI */
+                        regulator-min-microvolt = <1232000>;
+                        regulator-max-microvolt = <1232000>;
+                        regulator-allow-set-load;
+                        regulator-boot-on;
+                };
+
+                pm4125_l6: l6 {
+                        /* DRAM PLL */
+                        regulator-min-microvolt = <928000>;
+                        regulator-max-microvolt = <928000>;
+                        regulator-always-on;
+                        regulator-boot-on;
+                };
+
+                pm4125_l7: l7 {
+                        /* Wi-Fi CX */
+                        regulator-min-microvolt = <664000>;
+                        regulator-max-microvolt = <664000>;
+                };
+
+                pm4125_l10: l10 {
+                        /* Wi-Fi RFA */
+                        regulator-min-microvolt = <1304000>;
+                        regulator-max-microvolt = <1304000>;
+                };
+
+                pm4125_l11: l11 {
+                        /* ANX7625 DVDD1P0V/AVDD1P0V */
+                        regulator-min-microvolt = <1000000>;
+                        regulator-max-microvolt = <1000000>;
+                        regulator-boot-on;
+                        regulator-always-on;
+                };
+
+                pm4125_l12: l12 {
+                        /* USB PHYs */
+                        regulator-min-microvolt = <928000>;
+                        regulator-max-microvolt = <928000>;
+                        regulator-allow-set-load;
+                        regulator-boot-on;
+                };
+
+                pm4125_l13: l13 {
+                        /* USB/QFPROM/PLLs */
+                        regulator-min-microvolt = <1800000>;
+                        regulator-max-microvolt = <1800000>;
+                        regulator-allow-set-load;
+                        regulator-boot-on;
+                };
+
+                pm4125_l14: l14 {
+                        /* SDHCI1 EMMC VCCQ */
+                        regulator-min-microvolt = <1800000>;
+                        regulator-max-microvolt = <1800000>;
+                        regulator-allow-set-load;
+                        /* Broken hardware, never turn it off! */
+                        regulator-always-on;
+                };
+
+                pm4125_l15: l15 {
+                        /* VDDIO */
+                        regulator-min-microvolt = <1800000>;
+                        regulator-max-microvolt = <1800000>;
+                        regulator-allow-set-load;
+                        regulator-always-on;
+                        regulator-boot-on;
+                };
+
+                pm4125_l20: l20 {
+                        /* SDHCI1 EMMC */
+                        regulator-min-microvolt = <2400000>;
+                        regulator-max-microvolt = <3600000>;
+                        regulator-allow-set-load;
+                };
+
+                pm4125_l21: l21 {
+                        /* USB HS */
+                        regulator-min-microvolt = <2960000>;
+                        regulator-max-microvolt = <3300000>;
+                        regulator-allow-set-load;
+                        regulator-boot-on;
+                };
+
+                pm4125_l22: l22 {
+                        /* Wi-Fi VDD */
+                        regulator-min-microvolt = <3312000>;
+                        regulator-max-microvolt = <3312000>;
+                };
+        };
+};
+
+&sdhc_1 {
+        vmmc-supply = <&pm4125_l20>;
+        vqmmc-supply = <&pm4125_l14>;
+        pinctrl-0 = <&sdc1_state_on>;
+        pinctrl-1 = <&sdc1_state_off>;
+        pinctrl-names = "default", "sleep";
+        mmc-hs400-1_8v;
+        mmc-hs200-1_8v;
+        non-removable;
+        supports-cqe;
+        no-sdio;
+        no-sd;
+
+        status = "okay";
+};
+
+&tlmm {
+        spidev_cs: spidev-cs-state {
+                pins = "gpio17";
+                function = "gpio";
+                drive-strength = <16>;
+        };
+
+        jmisc_gpio18: jmisc-gpio18-state {
+                pins = "gpio18";
+                function = "gpio";
+                drive-strength = <2>;
+                bias-pull-down;
+        };
+
+        jmisc_gpio28: jmisc-gpio28-state {
+                pins = "gpio28";
+                function = "gpio";
+                drive-strength = <2>;
+                bias-pull-down;
+        };
+
+        key_vold_n: key-vold-n-state {
+                pins = "gpio36";
+                function = "gpio";
+                bias-pull-up;
+                output-disable;
+        };
+
+        key_volp_n: key-volp-n-state {
+                pins = "gpio96";
+                function = "gpio";
+                bias-pull-up;
+                output-disable;
+        };
+
+        jmisc_gpio98: jmisc-gpio98-state {
+                pins = "gpio98";
+                function = "gpio";
+                drive-strength = <2>;
+                bias-pull-down;
+        };
+
+        jmisc_gpio99: jmisc-gpio99-state {
+                pins = "gpio99";
+                function = "gpio";
+                drive-strength = <2>;
+                bias-pull-down;
+        };
+
+        jmisc_gpio100: jmisc-gpio100-state {
+                pins = "gpio100";
+                function = "gpio";
+                drive-strength = <2>;
+                bias-pull-down;
+        };
+
+        jmisc_gpio101: jmisc-gpio101-state {
+                pins = "gpio101";
+                function = "gpio";
+                drive-strength = <2>;
+                bias-pull-down;
+        };
+};
+
+&i2c0 {
+        clock-frequency = <100000>;
+
+        status = "okay";
+};
+
+&i2c1 {
+        clock-frequency = <100000>;
+
+        status = "okay";
+};
+
+&uart2 {
+        status = "okay";
+};
+
+/* UART connected to Bluetooth */
+&uart3 {
+        status = "okay";
+
+        bluetooth {
+                compatible = "qcom,wcn3988-bt";
+
+                vddio-supply = <&pm4125_l15>;
+                vddxo-supply = <&pm4125_l13>;
+                vddrf-supply = <&pm4125_l10>;
+                vddch0-supply = <&pm4125_l22>;
+                enable-gpios = <&tlmm 87 GPIO_ACTIVE_HIGH>;
+                max-speed = <3000000>;
+        };
+};
+
+/* UART connected to JCTL */
+&uart4 {
+        compatible = "qcom,geni-debug-uart";
+
+        status = "okay";
+};
+
+&spi5 {
+        status = "okay";
+
+        spidev@0 {
+                reg = <0>;
+                compatible = "arduino,mcu";
+                pinctrl-0 = <&spidev_cs>;
+                pinctrl-names = "default";
+        };
+};
+
+&usb {
+        status = "okay";
+};
+
+&usb_hsphy {
+        vdd-supply = <&pm4125_l12>;
+        vdda-pll-supply = <&pm4125_l13>;
+        vdda-phy-dpdm-supply = <&pm4125_l21>;
+
+        status = "okay";
+};
+
+&usb_qmpphy {
+        vdda-phy-supply = <&pm4125_l12>;
+        vdda-pll-supply = <&pm4125_l13>;
+
+        status = "okay";
+};
+
+&wifi {
+        vdd-0.8-cx-mx-supply = <&pm4125_l7>;
+        vdd-1.8-xo-supply = <&pm4125_l13>;
+        vdd-1.3-rfa-supply = <&pm4125_l10>;
+        vdd-3.3-ch0-supply = <&pm4125_l22>;
+        qcom,ath10k-calibration-variant = "Arduino_UnoQ";
+        firmware-name = "qcm2290";
+
+        status = "okay";
+};
+
+&xo_board {
+        clock-frequency = <38400000>;
+};
-- 
2.51.2


