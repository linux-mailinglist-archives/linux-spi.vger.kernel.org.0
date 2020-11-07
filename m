Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282572AA3BF
	for <lists+linux-spi@lfdr.de>; Sat,  7 Nov 2020 09:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgKGIPo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Nov 2020 03:15:44 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57208 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgKGIPn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 Nov 2020 03:15:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604736943; x=1636272943;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mpZe81LRQ3UMdKf0/NVqeXymuUe5qfQYIBE6oymulrY=;
  b=V7ZtBhHfeYAHXnWb4lMNt+FiBuU3qnQ5pnXjiUwip1G5oCZ81xhp/tVq
   C1IsymXTFxjX57C+XrPpzqKwI2UBbcJWpu1R4cKooszca531jdXVIA/I7
   43P0DJ1w+GxDulanGj1l582Wx2TSzp68gXjiPBsGSVIEOElLqwoAd3t+3
   aXyjtmiKPn+zrXlI0EoNZQLxZtJM9zXn0e8TSJiNBFEKDpzEyroq+wLZA
   42ysRvUeW2Vzhiigu7/WfiI0KU0Z3hy5sXuz1kMVY5zsqX2nrFMVe7Hkt
   PL2AoQv0bkekyNGXy31b+t3FLnXmsMV8oiNi/8+/l2VVqt+RmvA7o/tmn
   Q==;
IronPort-SDR: CSn7EodnBC0Z95D0e2GoAm7GKjy4BJxfTPh+KoxG0l/wMuBGWXkM03HMLDEqKCwtuCghxS0AvF
 v0pNYlkaIzVB8fh+iEgqS9BeG+N/m/XHveygOg+EecutvEDOJqZ1yTBzuEunreS8aAJBKvowED
 pBHVj1Vu1jwHRwGXC48EgTQ6fECKJVLs6yQC23q2d7Q2lHK93npD2CBcxFinyys9pV05rbD9Cn
 Es0f7d94PiSzKCOlCBdXKsTMJfqYIchZnjSzdVHkrivWyiSVwk6UKn3F46EDxjDgjI8eUJ8vpf
 6RA=
X-IronPort-AV: E=Sophos;i="5.77,459,1596470400"; 
   d="scan'208";a="156564444"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2020 16:15:42 +0800
IronPort-SDR: FaLBOhuAiDQtt/VhCJDRlxcCJTwRVOk3BJDoWbV5bdwGIv+kf12BRzwgnr1FyNOp/Ui9Ed0i4O
 o3BY8OipJbyzBBu17KAwz1Ia0b++JLFnXlbXm7RRwqqHxHv0iGMDPxT4Xch16xlVQLykZEv7J3
 Wm3Umx51lbylbPrFKD6OS1rH54hijIAG0diSsUFjZNK2QhY2mE7NwBx0jjA/DNHcXVVRRpVuIs
 NbqhA3GjhMVXsdpmdxkhoGuAFyPRiVean6sD9DpZShNCWKWdGGVUTZai2kCxyh8UlUQjwb4g8A
 GfKIb6zNwfNti7k+mH6p8OV+
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2020 00:00:34 -0800
IronPort-SDR: 8bVSfo5HMd0qf0dwK5d4k2No6GNG/G+0XTossZQ1bZ2/g/jb4AIdK+c4/aNgFEpBv85e4HpS0v
 yMigZybGad6iqKmgtWPdYk+ygK7UPOD7ezWTLZOV/XewloNu+dWFl2lzzDbqP09lQC/Howd4Fy
 yrBCKAf5MgwwaDhwX2AhmtoTdz3TXHcsMHb3XOn0HWx+SnAh4oGTNRH+88eWpeXbq3D5isSADc
 cJKYh4FsNSi+UaBFfMwmlEGNEX/OL0kaZtZXsdwxcmulAfDOK9hFD0Rc6NyY/c+QSG6oUBpceD
 qh4=
WDCIronportException: Internal
Received: from hdrdzf2.ad.shared (HELO twashi.fujisawa.hgst.com) ([10.84.71.85])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Nov 2020 00:15:41 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 30/32] riscv: Add SiPeed MAIXDUINO board device tree
Date:   Sat,  7 Nov 2020 17:14:18 +0900
Message-Id: <20201107081420.60325-31-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201107081420.60325-1-damien.lemoal@wdc.com>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add a device tree for the SiPeed MAIXDUINO board. This device tree
enables LEDs and spi/mmc SD card device. Additionally, gpios and i2c
are also enabled and mapped to the board header pins as indicated on
the board itself.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 .../boot/dts/kendryte/k210_maixduino.dts      | 203 ++++++++++++++++++
 1 file changed, 203 insertions(+)
 create mode 100644 arch/riscv/boot/dts/kendryte/k210_maixduino.dts

diff --git a/arch/riscv/boot/dts/kendryte/k210_maixduino.dts b/arch/riscv/boot/dts/kendryte/k210_maixduino.dts
new file mode 100644
index 000000000000..78a37cf9df97
--- /dev/null
+++ b/arch/riscv/boot/dts/kendryte/k210_maixduino.dts
@@ -0,0 +1,203 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2019-20 Sean Anderson <seanga2@gmail.com>
+ * Copyright (C) 2020 Western Digital Corporation or its affiliates.
+ */
+
+/dts-v1/;
+
+#include "k210.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "SiPeed MAIXDUINO";
+	compatible = "sipeed,maixduino", "kendryte,k210";
+
+	chosen {
+		bootargs = "earlycon console=ttySIF0";
+		stdout-path = "serial0:115200n8";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		boot {
+			label = "BOOT";
+			linux,code = <BTN_0>;
+			gpios = <&gpio0 0 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		status = "disabled";
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s0 0>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&mic>;
+		};
+	};
+
+	mic: mic {
+		#sound-dai-cells = <0>;
+		compatible = "memsensing,msm261s4030h0";
+		status = "disabled";
+	};
+};
+
+&fpioa {
+	status = "okay";
+
+	fpioa_uarths: uarths {
+		pinmux = <K210_FPIOA(4, K210_PCF_UARTHS_RX)>, /* Header "0" */
+			 <K210_FPIOA(5, K210_PCF_UARTHS_TX)>; /* Header "1" */
+	};
+
+	fpioa_gpio: gpio {
+		pinmux = <K210_FPIOA(8, K210_PCF_GPIO0)>,
+			 <K210_FPIOA(9, K210_PCF_GPIO1)>;
+	};
+
+	fpioa_gpiohs: gpiohs {
+		pinmux = <K210_FPIOA(16, K210_PCF_GPIOHS0)>,  /* BOOT */
+			 <K210_FPIOA(17, K210_PCF_GPIOHS1)>,
+			 <K210_FPIOA(21, K210_PCF_GPIOHS2)>,  /* Header "2" */
+			 <K210_FPIOA(22, K210_PCF_GPIOHS3)>,  /* Header "3" */
+			 <K210_FPIOA(23, K210_PCF_GPIOHS4)>,  /* Header "4" */
+			 <K210_FPIOA(24, K210_PCF_GPIOHS5)>,  /* Header "5" */
+			 <K210_FPIOA(32, K210_PCF_GPIOHS6)>,  /* Header "6" */
+			 <K210_FPIOA(15, K210_PCF_GPIOHS7)>,  /* Header "7" */
+			 <K210_FPIOA(14, K210_PCF_GPIOHS8)>,  /* Header "8" */
+			 <K210_FPIOA(13, K210_PCF_GPIOHS9)>,  /* Header "9" */
+			 <K210_FPIOA(12, K210_PCF_GPIOHS10)>, /* Header "10" */
+			 <K210_FPIOA(11, K210_PCF_GPIOHS11)>, /* Header "11" */
+			 <K210_FPIOA(10, K210_PCF_GPIOHS12)>, /* Header "12" */
+			 <K210_FPIOA(3,  K210_PCF_GPIOHS13)>, /* Header "13" */
+			 <K210_FPIOA(25, K210_PCF_GPIOHS14)>;
+	};
+
+	fpioa_i2s0: i2s0 {
+		pinmux = <K210_FPIOA(18, K210_PCF_I2S0_SCLK)>,
+			 <K210_FPIOA(19, K210_PCF_I2S0_WS)>,
+			 <K210_FPIOA(20, K210_PCF_I2S0_IN_D0)>;
+	};
+
+	fpioa_spi1: spi1 {
+		pinmux = <K210_FPIOA(26, K210_PCF_SPI1_D1)>,
+			 <K210_FPIOA(27, K210_PCF_SPI1_SCLK)>,
+			 <K210_FPIOA(28, K210_PCF_SPI1_D0)>,
+			 <K210_FPIOA(29, K210_PCF_SPI1_SS0)>; /* cs */
+	};
+
+	fpioa_i2c1: i2c1 {
+		pinmux = <K210_FPIOA(30, K210_PCF_I2C1_SCLK)>, /* Header "scl" */
+			 <K210_FPIOA(31, K210_PCF_I2C1_SDA)>;  /* Header "sda" */
+	};
+
+	fpioa_i2s1: i2s1 {
+		pinmux = <K210_FPIOA(33, K210_PCF_I2S1_WS)>,
+			 <K210_FPIOA(34, K210_PCF_I2S1_IN_D0)>,
+			 <K210_FPIOA(35, K210_PCF_I2S1_SCLK)>;
+	};
+
+	fpioa_spi0: spi0 {
+		pinmux = <K210_FPIOA(36, K210_PCF_GPIOHS20)>,  /* cs */
+			 <K210_FPIOA(37, K210_PCF_GPIOHS21)>,  /* rst */
+			 <K210_FPIOA(38, K210_PCF_GPIOHS22)>,  /* dc */
+			 <K210_FPIOA(39, K210_PCF_SPI0_SCLK)>; /* wr */
+	};
+
+	fpioa_dvp: dvp {
+		pinmux = <K210_FPIOA(40, K210_PCF_SCCB_SDA)>,
+			 <K210_FPIOA(41, K210_PCF_SCCB_SCLK)>,
+			 <K210_FPIOA(42, K210_PCF_DVP_RST)>,
+			 <K210_FPIOA(43, K210_PCF_DVP_VSYNC)>,
+			 <K210_FPIOA(44, K210_PCF_DVP_PWDN)>,
+			 <K210_FPIOA(45, K210_PCF_DVP_HSYNC)>,
+			 <K210_FPIOA(46, K210_PCF_DVP_XCLK)>,
+			 <K210_FPIOA(47, K210_PCF_DVP_PCLK)>;
+	};
+};
+
+&uarths0 {
+	pinctrl-0 = <&fpioa_uarths>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&gpio0 {
+	pinctrl-0 = <&fpioa_gpiohs>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&gpio1 {
+	pinctrl-0 = <&fpioa_gpio>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&i2s0 {
+	#sound-dai-cells = <1>;
+	pinctrl-0 = <&fpioa_i2s0>;
+	pinctrl-names = "default";
+};
+
+&i2c1 {
+	pinctrl-0 = <&fpioa_i2c1>;
+	pinctrl-names = "default";
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&dvp0 {
+	pinctrl-0 = <&fpioa_dvp>;
+	pinctrl-names = "default";
+};
+
+&spi0 {
+	pinctrl-0 = <&fpioa_spi0>;
+	pinctrl-names = "default";
+	num-cs = <1>;
+	cs-gpios = <&gpio0 20 0>;
+
+	panel@0 {
+		compatible = "sitronix,st7789v";
+		reg = <0>;
+		reset-gpios = <&gpio0 21 GPIO_ACTIVE_LOW>;
+		dc-gpios = <&gpio0 22 0>;
+		spi-max-frequency = <15000000>;
+	};
+};
+
+&spi1 {
+	pinctrl-0 = <&fpioa_spi1>;
+	pinctrl-names = "default";
+	num-cs = <1>;
+	polling;
+	status = "okay";
+
+	slot@0 {
+		compatible = "mmc-spi-slot";
+		reg = <0>;
+		voltage-ranges = <3300 3300>;
+		spi-max-frequency = <4000000>;
+		broken-cd;
+	};
+};
+
+&spi3 {
+	spi-flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <50000000>;
+		m25p,fast-read;
+		broken-flash-reset;
+	};
+};
-- 
2.28.0

