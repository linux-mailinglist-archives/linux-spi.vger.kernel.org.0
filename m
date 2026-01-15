Return-Path: <linux-spi+bounces-12408-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D4836D244A6
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 12:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8A83B30413D6
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 11:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4425E37C102;
	Thu, 15 Jan 2026 11:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="udSyQTo3"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C308137C110
	for <linux-spi@vger.kernel.org>; Thu, 15 Jan 2026 11:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477330; cv=none; b=jebJHVKzdGQDPddwVgfmDJqVvcg0DXpSIuca/87PoUbbuPNWoPQHJ7i5J+7EgY30hZHKAtEriRylYmGifFSu3kMPulb3YrBkas1LtZt0gNvLDUMMI65iMJSrH/HOg+Ddm5YJchcOsL4O6gmUSOB5O2spR0UcYRDObERxTfFqzxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477330; c=relaxed/simple;
	bh=U0+PHKIvqTVDY4K0Yq2i4ZsxOmyqyTbj2P5Lu27iLlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Irx76zitkPI1sZt14rS6vpfgkDGvZi2Cyss0/Kmnv9MhwpnrNIK8fW/kiCcg2NQ6EW2ll9ONtMpTHG7lUJbW7/RNuooJU45dhElioAWy4c4ZkKXuux1z2114ELcEQhPZT+p/rd2la6MNtFTC+34XabqQNIk6et1KfTcpHH0K/AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=udSyQTo3; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1233702afd3so945134c88.0
        for <linux-spi@vger.kernel.org>; Thu, 15 Jan 2026 03:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1768477326; x=1769082126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dM8414ALqYsfLftVAIf8PW75+RiKdKguD3y9NiH42iE=;
        b=udSyQTo3RNJXcETrAdVw8xyzJS4ZqD0ffYlXFcIgFE1RwZp4h9bNv9reCYTgNY1E9H
         DGwQwUMHZVHKsH2L/JDEKFgCmA5rmTL5P4JmDNyqyor6B3jxTKw/HEaar2VdoWSCaFal
         +IVLSX8M/1KyDIikgOk5OHmgBQRlfsQa2azP0s7Ccn4tiqcRuT4544vs6nRSmy3F88bj
         llzx0Zcwn12o4xsoobVqJCOxeiib/20LYpkY1Vn7nxz9b3bBDheJtrn2UXmUkKm6yya6
         4G/l2ajsvhHqxtoL1gRrOyp8In0TJUg1uVuloOLhKswZ5NclaHvxKt1SNQ45ovRkajEz
         9khA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768477326; x=1769082126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dM8414ALqYsfLftVAIf8PW75+RiKdKguD3y9NiH42iE=;
        b=AHJBJm9aFTBxz48QUp0R+3C1wWs2BZdfop1OvLlX/i1UsLBjN5hDUUP6Nbqw/t6Lzk
         zJNeRV3K95Yy/KsU9kdKeXqwCul2SkYDUB9NyJ0fwh7yWWCTjR0kxTqu5L9O1RNAcWg/
         RmAlyaMWR2PT8aorQRPsea6XUkmiziiU5rnFFDXAM9ZQSG+tJX0vso4AptF9TNwI7Ly/
         iWXXF91NL2hLtNawl2wDyVL3AGC74K2xJYtAO8Qh9/0GwCthQS0MueYUpdy2f0ODmk7D
         CqMRTG5gBUkYFhp9mgUKNru08EYlUKBhwqnZnJvHLnafsgy7RTOj6j9O/aJO02FEPmv2
         Doyg==
X-Forwarded-Encrypted: i=1; AJvYcCU8sV+3W+UU2Q1gQNpdNNubIhJ8lrtjN4CR0Fs5Oz1cAeksHoZwjeDZAdg12XK1qj/Hhpb8Wh+LNas=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5pk9TRQmM+ig70A36JnDDyy83L8kqc4TtPoC98XA3X206+xlB
	hEKA9pFhl7xluixcZ1coHfWLaIWtbc6hBzsQ/BOH7b7QVrZkPeHdvQKtLO9ij1hRfQ4=
X-Gm-Gg: AY/fxX5YumDzAHvMHi9AdFvk7DwBBOBV6WD3REjQbC9EgN1JeTR3gjzviwZpYOOuFko
	MEPVoxwxgw+b/B90HvzBsrFQSDYs2AbeyjtC3X7USDaOL3C4lb/E5x/ILQqqrWeDrdj/M1asJVp
	wMXLXP7bfyGpwNQKlRHG1PCxddcF9Ia2W8qmR2Ki2g9N8DWLtOmm4Y1YvrUTMGvBZDmcMqOO+oj
	QQqd87CvBNwm3ofbMOyQiaHPvYUkhQ6uswsLeOecSy4ce8VOiTEQF6RJk8x1wAou//mBj8Aocax
	ncqOEHzwERVLL5LMy7g1JrHX9q2H7Qc0eYEJ+fv+uFo3cICh6g22DyxA1Fc2W+Yb2kXH/HcwWFc
	AwyJVbLNvFiVnkoDgALTzZAV8BGYveHBlsPnR3q4ywE8bxBWKaED9H2f4QtTW6SVISmiG7fpnUD
	JyV73XYPDPuTWAR1KOm03CE/kZthXPNrhU0GrtDWPuwEj5+9ZGqJON9wfo4ZkFlznM46TjE7LWD
	auPd887
X-Received: by 2002:a05:7023:d07:b0:11e:528:4185 with SMTP id a92af1059eb24-12336a975f2mr7391613c88.38.1768477325683;
        Thu, 15 Jan 2026 03:42:05 -0800 (PST)
Received: from fedora (dh207-14-52.xnet.hr. [88.207.14.52])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-123370a051esm4875347c88.15.2026.01.15.03.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:42:05 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	lee@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	linusw@kernel.org,
	olivia@selenic.com,
	richard.genoud@bootlin.com,
	radu_nicolae.pirea@upb.ro,
	gregkh@linuxfoundation.org,
	richardcochran@gmail.com,
	horatiu.vultur@microchip.com,
	Ryan.Wanner@microchip.com,
	tudor.ambarus@linaro.org,
	kavyasree.kotagiri@microchip.com,
	lars.povlsen@microchip.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v5 11/11] arm64: dts: microchip: add EV23X71A board
Date: Thu, 15 Jan 2026 12:37:36 +0100
Message-ID: <20260115114021.111324-12-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115114021.111324-1-robert.marko@sartura.hr>
References: <20260115114021.111324-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Microchip EV23X71A is an LAN9696 based evaluation board.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v5:
* Remove phys property from port 29
* Alphanumericaly sort pin nodes

Changes in v2:
* Split from SoC DTSI commit
* Apply DTS coding style
* Enclose array in i2c-mux
* Alphanumericaly sort nodes
* Change management port mode to RGMII-ID 

 arch/arm64/boot/dts/microchip/Makefile        |   1 +
 .../boot/dts/microchip/lan9696-ev23x71a.dts   | 756 ++++++++++++++++++
 2 files changed, 757 insertions(+)
 create mode 100644 arch/arm64/boot/dts/microchip/lan9696-ev23x71a.dts

diff --git a/arch/arm64/boot/dts/microchip/Makefile b/arch/arm64/boot/dts/microchip/Makefile
index c6e0313eea0f..09d16fc1ce9a 100644
--- a/arch/arm64/boot/dts/microchip/Makefile
+++ b/arch/arm64/boot/dts/microchip/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_LAN969X) += lan9696-ev23x71a.dtb
 dtb-$(CONFIG_ARCH_SPARX5) += sparx5_pcb125.dtb
 dtb-$(CONFIG_ARCH_SPARX5) += sparx5_pcb134.dtb sparx5_pcb134_emmc.dtb
 dtb-$(CONFIG_ARCH_SPARX5) += sparx5_pcb135.dtb sparx5_pcb135_emmc.dtb
diff --git a/arch/arm64/boot/dts/microchip/lan9696-ev23x71a.dts b/arch/arm64/boot/dts/microchip/lan9696-ev23x71a.dts
new file mode 100644
index 000000000000..4012ea7d07bb
--- /dev/null
+++ b/arch/arm64/boot/dts/microchip/lan9696-ev23x71a.dts
@@ -0,0 +1,756 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright (c) 2025 Microchip Technology Inc. and its subsidiaries.
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+#include "lan9691.dtsi"
+
+/ {
+	model = "Microchip EV23X71A";
+	compatible = "microchip,ev23x71a", "microchip,lan9696", "microchip,lan9691";
+
+	aliases {
+		serial0 = &usart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	gpio-restart {
+		compatible = "gpio-restart";
+		gpios = <&gpio 60 GPIO_ACTIVE_LOW>;
+		open-source;
+		priority = <200>;
+	};
+
+	i2c-mux {
+		compatible = "i2c-mux-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-parent = <&i2c3>;
+		idle-state = <0x8>;
+		mux-gpios = <&sgpio_out 0 1 GPIO_ACTIVE_HIGH>,
+			    <&sgpio_out 0 2 GPIO_ACTIVE_HIGH>,
+			    <&sgpio_out 0 3 GPIO_ACTIVE_HIGH>;
+		settle-time-us = <100>;
+
+		i2c_sfp0: i2c@0 {
+			reg = <0x0>;
+		};
+
+		i2c_sfp1: i2c@1 {
+			reg = <0x1>;
+		};
+
+		i2c_sfp2: i2c@2 {
+			reg = <0x2>;
+		};
+
+		i2c_sfp3: i2c@3 {
+			reg = <0x3>;
+		};
+
+		i2c_poe: i2c@7 {
+			reg = <0x7>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-status {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_STATUS;
+			gpios = <&gpio 61 GPIO_ACTIVE_LOW>;
+		};
+
+		led-sfp1-green {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_LAN;
+			function-enumerator = <0>;
+			gpios = <&sgpio_out 6 0 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		led-sfp1-yellow {
+			color = <LED_COLOR_ID_YELLOW>;
+			function = LED_FUNCTION_LAN;
+			function-enumerator = <0>;
+			gpios = <&sgpio_out 6 1 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		led-sfp2-green {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_LAN;
+			function-enumerator = <1>;
+			gpios = <&sgpio_out 7 0 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		led-sfp2-yellow {
+			color = <LED_COLOR_ID_YELLOW>;
+			function = LED_FUNCTION_LAN;
+			function-enumerator = <1>;
+			gpios = <&sgpio_out 7 1 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		led-sfp3-green {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_LAN;
+			function-enumerator = <2>;
+			gpios = <&sgpio_out 8 0 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		led-sfp3-yellow {
+			color = <LED_COLOR_ID_YELLOW>;
+			function = LED_FUNCTION_LAN;
+			function-enumerator = <2>;
+			gpios = <&sgpio_out 8 1 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		led-sfp4-green {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_LAN;
+			function-enumerator = <3>;
+			gpios = <&sgpio_out 9 0 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		led-sfp4-yellow {
+			color = <LED_COLOR_ID_YELLOW>;
+			function = LED_FUNCTION_LAN;
+			function-enumerator = <3>;
+			gpios = <&sgpio_out 9 1 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+	};
+
+	mux-controller {
+		compatible = "gpio-mux";
+		#mux-control-cells = <0>;
+		mux-gpios = <&sgpio_out 1 2 GPIO_ACTIVE_LOW>,
+			    <&sgpio_out 1 3 GPIO_ACTIVE_LOW>;
+	};
+
+	sfp0: sfp0 {
+		compatible = "sff,sfp";
+		i2c-bus = <&i2c_sfp0>;
+		tx-disable-gpios = <&sgpio_out 6 2 GPIO_ACTIVE_HIGH>;
+		los-gpios = <&sgpio_in 6 0 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpios = <&sgpio_in 6 1 GPIO_ACTIVE_LOW>;
+		tx-fault-gpios = <&sgpio_in 6 2 GPIO_ACTIVE_HIGH>;
+	};
+
+	sfp1: sfp1 {
+		compatible = "sff,sfp";
+		i2c-bus = <&i2c_sfp1>;
+		tx-disable-gpios = <&sgpio_out 7 2 GPIO_ACTIVE_HIGH>;
+		los-gpios = <&sgpio_in 7 0 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpios = <&sgpio_in 7 1 GPIO_ACTIVE_LOW>;
+		tx-fault-gpios = <&sgpio_in 7 2 GPIO_ACTIVE_HIGH>;
+	};
+
+	sfp2: sfp2 {
+		compatible = "sff,sfp";
+		i2c-bus = <&i2c_sfp2>;
+		tx-disable-gpios = <&sgpio_out 8 2 GPIO_ACTIVE_HIGH>;
+		los-gpios = <&sgpio_in 8 0 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpios = <&sgpio_in 8 1 GPIO_ACTIVE_LOW>;
+		tx-fault-gpios = <&sgpio_in 8 2 GPIO_ACTIVE_HIGH>;
+	};
+
+	sfp3: sfp3 {
+		compatible = "sff,sfp";
+		i2c-bus = <&i2c_sfp3>;
+		tx-disable-gpios = <&sgpio_out 9 2 GPIO_ACTIVE_HIGH>;
+		los-gpios = <&sgpio_in 9 0 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpios = <&sgpio_in 9 1 GPIO_ACTIVE_LOW>;
+		tx-fault-gpios = <&sgpio_in 9 2 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&gpio {
+	emmc_sd_pins: emmc-sd-pins {
+		/* eMMC_SD - CMD, CLK, D0, D1, D2, D3, D4, D5, D6, D7, RSTN */
+		pins = "GPIO_14", "GPIO_15", "GPIO_16", "GPIO_17",
+		       "GPIO_18", "GPIO_19", "GPIO_20", "GPIO_21",
+		       "GPIO_22", "GPIO_23", "GPIO_24";
+		function = "emmc_sd";
+	};
+
+	fan_pins: fan-pins {
+		pins = "GPIO_25", "GPIO_26";
+		function = "fan";
+	};
+
+	fc0_pins: fc0-pins {
+		pins = "GPIO_3", "GPIO_4";
+		function = "fc";
+	};
+
+	fc2_pins: fc2-pins {
+		pins = "GPIO_64", "GPIO_65", "GPIO_66";
+		function = "fc";
+	};
+
+	fc3_pins: fc3-pins {
+		pins = "GPIO_55", "GPIO_56";
+		function = "fc";
+	};
+
+	mdio_irq_pins: mdio-irq-pins {
+		pins = "GPIO_11";
+		function = "miim_irq";
+	};
+
+	mdio_pins: mdio-pins {
+		pins = "GPIO_9", "GPIO_10";
+		function = "miim";
+	};
+
+	ptp_ext_pins: ptp-ext-pins {
+		pins = "GPIO_59";
+		function = "ptpsync_5";
+	};
+
+	ptp_out_pins: ptp-out-pins {
+		pins = "GPIO_58";
+		function = "ptpsync_4";
+	};
+
+	sgpio_pins: sgpio-pins {
+		/* SCK, D0, D1, LD */
+		pins = "GPIO_5", "GPIO_6", "GPIO_7", "GPIO_8";
+		function = "sgpio_a";
+	};
+
+	usb_over_pins: usb-over-pins {
+		pins = "GPIO_13";
+		function = "usb_over_detect";
+	};
+
+	usb_power_pins: usb-power-pins {
+		pins = "GPIO_1";
+		function = "usb_power";
+	};
+
+	usb_rst_pins: usb-rst-pins {
+		pins = "GPIO_12";
+		function = "usb2phy_rst";
+	};
+
+	usb_ulpi_pins: usb-ulpi-pins {
+		pins = "GPIO_30", "GPIO_31", "GPIO_32", "GPIO_33",
+		       "GPIO_34", "GPIO_35", "GPIO_36", "GPIO_37",
+		       "GPIO_38", "GPIO_39", "GPIO_40", "GPIO_41";
+		function = "usb_ulpi";
+	};
+};
+
+&flx0 {
+	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_USART>;
+	status = "okay";
+};
+
+&flx2 {
+	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_SPI>;
+	status = "okay";
+};
+
+&flx3 {
+	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_TWI>;
+	status = "okay";
+};
+
+&i2c3 {
+	pinctrl-0 = <&fc3_pins>;
+	pinctrl-names = "default";
+	i2c-analog-filter;
+	i2c-digital-filter;
+	i2c-digital-filter-width-ns = <35>;
+	i2c-sda-hold-time-ns = <1500>;
+	status = "okay";
+};
+
+&mdio0 {
+	pinctrl-0 = <&mdio_pins>, <&mdio_irq_pins>;
+	pinctrl-names = "default";
+	reset-gpios = <&gpio 62 GPIO_ACTIVE_LOW>;
+	status = "okay";
+
+	phy3: phy@3 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <3>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio>;
+	};
+
+	phy4: phy@4 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <4>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio>;
+	};
+
+	phy5: phy@5 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <5>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio>;
+	};
+
+	phy6: phy@6 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <6>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio>;
+	};
+
+	phy7: phy@7 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <7>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio>;
+	};
+
+	phy8: phy@8 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <8>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio>;
+	};
+
+	phy9: phy@9 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <9>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio>;
+	};
+
+	phy10: phy@10 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <10>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio>;
+	};
+
+	phy11: phy@11 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <11>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio>;
+	};
+
+	phy12: phy@12 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <12>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio>;
+	};
+
+	phy13: phy@13 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <13>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio>;
+	};
+
+	phy14: phy@14 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <14>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio>;
+	};
+
+	phy15: phy@15 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <15>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio>;
+	};
+
+	phy16: phy@16 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <16>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio>;
+	};
+
+	phy17: phy@17 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <17>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio>;
+	};
+
+	phy18: phy@18 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <18>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio>;
+	};
+
+	phy19: phy@19 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <19>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio>;
+	};
+
+	phy20: phy@20 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <20>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio>;
+	};
+
+	phy21: phy@21 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <21>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio>;
+	};
+
+	phy22: phy@22 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <22>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio>;
+	};
+
+	phy23: phy@23 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <23>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio>;
+	};
+
+	phy24: phy@24 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <24>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio>;
+	};
+
+	phy25: phy@25 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <25>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio>;
+	};
+
+	phy26: phy@26 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <26>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio>;
+	};
+
+	phy27: phy@27 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <27>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio>;
+	};
+};
+
+&serdes {
+	status = "okay";
+};
+
+&sgpio {
+	pinctrl-0 = <&sgpio_pins>;
+	pinctrl-names = "default";
+	microchip,sgpio-port-ranges = <0 1>, <6 9>;
+	status = "okay";
+
+	gpio@0 {
+		ngpios = <128>;
+	};
+	gpio@1 {
+		ngpios = <128>;
+	};
+};
+
+&spi2 {
+	pinctrl-0 = <&fc2_pins>;
+	pinctrl-names = "default";
+	cs-gpios = <&gpio 63 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&switch {
+	pinctrl-0 = <&ptp_out_pins>, <&ptp_ext_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	ethernet-ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port0: port@0 {
+			reg = <0>;
+			phy-handle = <&phy4>;
+			phy-mode = "qsgmii";
+			phys = <&serdes 0>;
+			microchip,bandwidth = <1000>;
+		};
+
+		port1: port@1 {
+			reg = <1>;
+			phy-handle = <&phy5>;
+			phy-mode = "qsgmii";
+			phys = <&serdes 0>;
+			microchip,bandwidth = <1000>;
+		};
+
+		port2: port@2 {
+			reg = <2>;
+			phy-handle = <&phy6>;
+			phy-mode = "qsgmii";
+			phys = <&serdes 0>;
+			microchip,bandwidth = <1000>;
+		};
+
+		port3: port@3 {
+			reg = <3>;
+			phy-handle = <&phy7>;
+			phy-mode = "qsgmii";
+			phys = <&serdes 0>;
+			microchip,bandwidth = <1000>;
+		};
+
+		port4: port@4 {
+			reg = <4>;
+			phy-handle = <&phy8>;
+			phy-mode = "qsgmii";
+			phys = <&serdes 1>;
+			microchip,bandwidth = <1000>;
+		};
+
+		port5: port@5 {
+			reg = <5>;
+			phy-handle = <&phy9>;
+			phy-mode = "qsgmii";
+			phys = <&serdes 1>;
+			microchip,bandwidth = <1000>;
+		};
+
+		port6: port@6 {
+			reg = <6>;
+			phy-handle = <&phy10>;
+			phy-mode = "qsgmii";
+			phys = <&serdes 1>;
+			microchip,bandwidth = <1000>;
+		};
+
+		port7: port@7 {
+			reg = <7>;
+			phy-handle = <&phy11>;
+			phy-mode = "qsgmii";
+			phys = <&serdes 1>;
+			microchip,bandwidth = <1000>;
+		};
+
+		port8: port@8 {
+			reg = <8>;
+			phy-handle = <&phy12>;
+			phy-mode = "qsgmii";
+			phys = <&serdes 2>;
+			microchip,bandwidth = <1000>;
+		};
+
+		port9: port@9 {
+			reg = <9>;
+			phy-handle = <&phy13>;
+			phy-mode = "qsgmii";
+			phys = <&serdes 2>;
+			microchip,bandwidth = <1000>;
+		};
+
+		port10: port@10 {
+			reg = <10>;
+			phy-handle = <&phy14>;
+			phy-mode = "qsgmii";
+			phys = <&serdes 2>;
+			microchip,bandwidth = <1000>;
+		};
+
+		port11: port@11 {
+			reg = <11>;
+			phy-handle = <&phy15>;
+			phy-mode = "qsgmii";
+			phys = <&serdes 2>;
+			microchip,bandwidth = <1000>;
+		};
+
+		port12: port@12 {
+			reg = <12>;
+			phy-handle = <&phy16>;
+			phy-mode = "qsgmii";
+			phys = <&serdes 3>;
+			microchip,bandwidth = <1000>;
+		};
+
+		port13: port@13 {
+			reg = <13>;
+			phy-handle = <&phy17>;
+			phy-mode = "qsgmii";
+			phys = <&serdes 3>;
+			microchip,bandwidth = <1000>;
+		};
+
+		port14: port@14 {
+			reg = <14>;
+			phy-handle = <&phy18>;
+			phy-mode = "qsgmii";
+			phys = <&serdes 3>;
+			microchip,bandwidth = <1000>;
+		};
+
+		port15: port@15 {
+			reg = <15>;
+			phy-handle = <&phy19>;
+			phy-mode = "qsgmii";
+			phys = <&serdes 3>;
+			microchip,bandwidth = <1000>;
+		};
+
+		port16: port@16 {
+			reg = <16>;
+			phy-handle = <&phy20>;
+			phy-mode = "qsgmii";
+			phys = <&serdes 4>;
+			microchip,bandwidth = <1000>;
+		};
+
+		port17: port@17 {
+			reg = <17>;
+			phy-handle = <&phy21>;
+			phy-mode = "qsgmii";
+			phys = <&serdes 4>;
+			microchip,bandwidth = <1000>;
+		};
+
+		port18: port@18 {
+			reg = <18>;
+			phy-handle = <&phy22>;
+			phy-mode = "qsgmii";
+			phys = <&serdes 4>;
+			microchip,bandwidth = <1000>;
+		};
+
+		port19: port@19 {
+			reg = <19>;
+			phy-handle = <&phy23>;
+			phy-mode = "qsgmii";
+			phys = <&serdes 4>;
+			microchip,bandwidth = <1000>;
+		};
+
+		port20: port@20 {
+			reg = <20>;
+			phy-handle = <&phy24>;
+			phy-mode = "qsgmii";
+			phys = <&serdes 5>;
+			microchip,bandwidth = <1000>;
+		};
+
+		port21: port@21 {
+			reg = <21>;
+			phy-handle = <&phy25>;
+			phy-mode = "qsgmii";
+			phys = <&serdes 5>;
+			microchip,bandwidth = <1000>;
+		};
+
+		port22: port@22 {
+			reg = <22>;
+			phy-handle = <&phy26>;
+			phy-mode = "qsgmii";
+			phys = <&serdes 5>;
+			microchip,bandwidth = <1000>;
+		};
+
+		port23: port@23 {
+			reg = <23>;
+			phy-handle = <&phy27>;
+			phy-mode = "qsgmii";
+			phys = <&serdes 5>;
+			microchip,bandwidth = <1000>;
+		};
+
+		port24: port@24 {
+			reg = <24>;
+			phys = <&serdes 6>;
+			phy-mode = "10gbase-r";
+			sfp = <&sfp0>;
+			managed = "in-band-status";
+			microchip,bandwidth = <10000>;
+			microchip,sd-sgpio = <24>;
+		};
+
+		port25: port@25 {
+			reg = <25>;
+			phys = <&serdes 7>;
+			phy-mode = "10gbase-r";
+			sfp = <&sfp1>;
+			managed = "in-band-status";
+			microchip,bandwidth = <10000>;
+			microchip,sd-sgpio = <28>;
+		};
+
+		port26: port@26 {
+			reg = <26>;
+			phys = <&serdes 8>;
+			phy-mode = "10gbase-r";
+			sfp = <&sfp2>;
+			managed = "in-band-status";
+			microchip,bandwidth = <10000>;
+			microchip,sd-sgpio = <32>;
+		};
+
+		port27: port@27 {
+			reg = <27>;
+			phys = <&serdes 9>;
+			phy-mode = "10gbase-r";
+			sfp = <&sfp3>;
+			managed = "in-band-status";
+			microchip,bandwidth = <10000>;
+			microchip,sd-sgpio = <36>;
+		};
+
+		port29: port@29 {
+			reg = <29>;
+			phy-handle = <&phy3>;
+			phy-mode = "rgmii-id";
+			microchip,bandwidth = <1000>;
+		};
+	};
+};
+
+&tmon {
+	pinctrl-0 = <&fan_pins>;
+	pinctrl-names = "default";
+};
+
+&usart0 {
+	pinctrl-0 = <&fc0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&usb {
+	pinctrl-0 = <&usb_ulpi_pins>, <&usb_rst_pins>, <&usb_over_pins>, <&usb_power_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
-- 
2.52.0


