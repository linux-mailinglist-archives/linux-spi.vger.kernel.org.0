Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB192AA3C4
	for <lists+linux-spi@lfdr.de>; Sat,  7 Nov 2020 09:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgKGIPq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Nov 2020 03:15:46 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57208 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgKGIPq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 Nov 2020 03:15:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604736945; x=1636272945;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GmhwMX9pbWxmfz+QRdKTLzObv1YycYb4GELhGYcECjA=;
  b=r1AQ55MPVsIXAR64nQLhC/adrvo+4teHJsyDjnP6ceBOqzN9wOecYxvx
   SwGONCSurftg8xPts1bY/GNYYLG9xMqf8RXYZEsxqCVwbYbz9/jzslb7f
   T0aVZSjTDNuEunWBcjF9q17rrestSGQAd5fkzNMuG1VvNAYVr6i/TY9XD
   FV/+8T8IPLCWmDsglFiG14Z6fUzDdR6pkanTA3GTQnHrxV635wCsBXf5Y
   MPAgwM67F1seUXEZzHwONSNqpVpC5r3G+ZsKq01pxIio+tlOAGY7zfrz2
   G2mhAB+3s1AN0lcGNQiXAp25CY3eFOPcJgwDE3RHm26Rmq2MeDfWfSnUz
   w==;
IronPort-SDR: +a225qV5Quc1/tlSeup0J977zac5/aBay2J9J52W687J3LbesVrRo52D0/fn9PdhSwSRhlv/ZN
 /627Or025fvO4nz5Eng2kMcvXpdDAztJ8qCn4YTK7hz5Grs12woaixJ/qAKfkaWslYw68iYS2/
 9YrslnF54mLGnsQ9+fwG66qRLeSH0JkhLEWVYV/4m9xZD4bHa5IpdDklbAgiocuxJmLnhpLxyv
 spU+F+F8TQx7pB/1d5AtrxF8eH0rh0+MngrMZbdaIfPXuRdr46rLwxQlPtOxiXp/n2ksalRGqb
 PHo=
X-IronPort-AV: E=Sophos;i="5.77,459,1596470400"; 
   d="scan'208";a="156564445"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2020 16:15:45 +0800
IronPort-SDR: 41hywgjos2tj0aVvPfy3M1PPpFYFxCXiAQ/z6JlxYAWebqkefad8sa+04z8d9sBgf/NM0kF6P1
 Lv49B9Gv+OlyA8Bml/BNVxK9yXO8CaCaHriAVCjHhHnSFi3GpHxkttwlI349F1kIzWja17IT+f
 Ut75mW0DP9Muj4mUjB250qbI6Is8X+COblrJWIAGjKYqsGIGaRu2NmJsuQjArA5GbyzvCeUzdT
 hb6EjDCD5wmOsnGQtHaHb9dqQU3e4PUfwlSMRDe5VqYLPhlYU7JmCvQcOX9Szaf4Zq2jHRWobi
 9H7u/N652TNqr6sXPRW6SOAY
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2020 00:00:36 -0800
IronPort-SDR: xCg9hHScmcPMA7NrAzIOkRS1P0z5qRbJmWI70ya+rahrx3zb4jN2f3iPZh5CfHQF/8DP8yHJLL
 d46dF2QbfVTcuFr+1osT9UEquiqjtVzaPTWRssWDn8R1i5h8Sl1gGaijKF4zPIgh6ZooP5VwAU
 v2G7Ka+DHfnDDZzn/8q1RrY98li5TRVgLfWWBBFWXaboiLozCGil5d8zJRvPvma88LytSa4MR8
 rjxx32RTlLd/LBco2Kjdleg8CZPaTR9MW75R5KAZG5xyYBhQmITQsGtO0gH5yUzim/8iuAUvNS
 2Jk=
WDCIronportException: Internal
Received: from hdrdzf2.ad.shared (HELO twashi.fujisawa.hgst.com) ([10.84.71.85])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Nov 2020 00:15:43 -0800
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
Subject: [PATCH 31/32] riscv: Add Kendryte KD233 board device tree
Date:   Sat,  7 Nov 2020 17:14:19 +0900
Message-Id: <20201107081420.60325-32-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201107081420.60325-1-damien.lemoal@wdc.com>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add a device tree for the Kendryte KD233 board (K210 test board).
This device tree enables LEDs, some gpios and spi/mmc SD card device.
The WS2812B RGB LED and the 10 position rotary dip switch present on the
board are left undefined.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 arch/riscv/boot/dts/kendryte/k210_kd233.dts | 177 ++++++++++++++++++++
 1 file changed, 177 insertions(+)
 create mode 100644 arch/riscv/boot/dts/kendryte/k210_kd233.dts

diff --git a/arch/riscv/boot/dts/kendryte/k210_kd233.dts b/arch/riscv/boot/dts/kendryte/k210_kd233.dts
new file mode 100644
index 000000000000..b4e721a31000
--- /dev/null
+++ b/arch/riscv/boot/dts/kendryte/k210_kd233.dts
@@ -0,0 +1,177 @@
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
+	model = "Kendryte KD233";
+	compatible = "kendryte,kd233", "kendryte,k210";
+
+	chosen {
+		bootargs = "earlycon console=ttySIF0";
+		stdout-path = "serial0:115200n8";
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+
+		led0 {
+			gpios = <&gpio0 8 GPIO_ACTIVE_LOW>;
+		};
+
+		led1 {
+			gpios = <&gpio0 9 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		key0 {
+			label = "KEY0";
+			linux,code = <BTN_0>;
+			gpios = <&gpio0 10 GPIO_ACTIVE_LOW>;
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
+	pinctrl-0 = <&fpioa_jtag>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	fpioa_jtag: jtag {
+		pinmux = <K210_FPIOA(0, K210_PCF_JTAG_TCLK)>,
+			 <K210_FPIOA(1, K210_PCF_JTAG_TDI)>,
+			 <K210_FPIOA(2, K210_PCF_JTAG_TMS)>,
+			 <K210_FPIOA(3, K210_PCF_JTAG_TDO)>;
+	};
+
+	fpioa_uarths: uarths {
+		pinmux = <K210_FPIOA(4, K210_PCF_UARTHS_RX)>,
+			 <K210_FPIOA(5, K210_PCF_UARTHS_TX)>;
+	};
+
+	fpioa_spi0: spi0 {
+		pinmux = <K210_FPIOA(6, K210_PCF_GPIOHS20)>,  /* cs */
+			 <K210_FPIOA(7, K210_PCF_SPI0_SCLK)>, /* wr */
+			 <K210_FPIOA(8, K210_PCF_GPIOHS21)>;  /* dc */
+	};
+
+	fpioa_dvp: dvp {
+		pinmux = <K210_FPIOA(9, K210_PCF_SCCB_SCLK)>,
+			 <K210_FPIOA(10, K210_PCF_SCCB_SDA)>,
+			 <K210_FPIOA(11, K210_PCF_DVP_RST)>,
+			 <K210_FPIOA(12, K210_PCF_DVP_VSYNC)>,
+			 <K210_FPIOA(13, K210_PCF_DVP_PWDN)>,
+			 <K210_FPIOA(14, K210_PCF_DVP_XCLK)>,
+			 <K210_FPIOA(15, K210_PCF_DVP_PCLK)>,
+			 <K210_FPIOA(17, K210_PCF_DVP_HSYNC)>;
+	};
+
+	fpioa_gpiohs: gpiohs {
+		pinmux = <K210_FPIOA(16, K210_PCF_GPIOHS0)>,
+			 <K210_FPIOA(20, K210_PCF_GPIOHS4)>, /* Rot. dip sw line 8 */
+			 <K210_FPIOA(21, K210_PCF_GPIOHS5)>, /* Rot. dip sw line 4 */
+			 <K210_FPIOA(22, K210_PCF_GPIOHS6)>, /* Rot. dip sw line 2 */
+			 <K210_FPIOA(23, K210_PCF_GPIOHS7)>, /* Rot. dip sw line 1 */
+			 <K210_FPIOA(24, K210_PCF_GPIOHS8)>,
+			 <K210_FPIOA(25, K210_PCF_GPIOHS9)>,
+			 <K210_FPIOA(26, K210_PCF_GPIOHS10)>;
+	};
+
+	fpioa_spi1: spi1 {
+		pinmux = <K210_FPIOA(29, K210_PCF_SPI1_SCLK)>,
+			 <K210_FPIOA(30, K210_PCF_SPI1_D0)>,
+			 <K210_FPIOA(31, K210_PCF_SPI1_D1)>,
+			 <K210_FPIOA(32, K210_PCF_SPI1_SS0)>; /* cs */
+	};
+
+	fpioa_i2s0: i2s0 {
+		pinmux = <K210_FPIOA(33, K210_PCF_I2S0_IN_D0)>,
+			 <K210_FPIOA(34, K210_PCF_I2S0_WS)>,
+			 <K210_FPIOA(35, K210_PCF_I2S0_SCLK)>;
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
+&i2s0 {
+	#sound-dai-cells = <1>;
+	pinctrl-0 = <&fpioa_i2s0>;
+	pinctrl-names = "default";
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
+		compatible = "ilitek,ili9341";
+		reg = <0>;
+		dc-gpios = <&gpio0 21 GPIO_ACTIVE_HIGH>;
+		spi-max-frequency = <15000000>;
+		status = "disabled";
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
-- 
2.28.0

