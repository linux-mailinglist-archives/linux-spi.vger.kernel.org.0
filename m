Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045BD2AA3B6
	for <lists+linux-spi@lfdr.de>; Sat,  7 Nov 2020 09:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgKGIPg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Nov 2020 03:15:36 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57208 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgKGIPg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 Nov 2020 03:15:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604736935; x=1636272935;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R6ojcjfpOV1mQTShcVKl24jzRG2DzI4ILkhh1fxkrVo=;
  b=fb3oXHC6aUwRST9LZNaU/4uyfHIlkdN9hMqwE8wZ3xMwA6tZATMzWq/B
   092vQlVUBP8g0mki3ORjk61DRsa0jOyfSDeBWVVxd1O07K7QzdUB6DHwI
   AF8VyVy40VBFKfEYN+FEHp4elYHqGVvai5n79QvTIlgwGEPeD8BEa4dyU
   zK59usoz0/1WAKQofrUo0U8HoMFXSGd7/D1vOAcXJmhaQUq/u53e77kpS
   iBkQJux2jKIslAGy3L2A082xrlfHXAFr+PrFl+TnSpVpHLRSc5sUcHQGz
   1XKw6cYWmLJeP9fciu+Fy6GO5o0j81Wd/LsM610xaqfU3aHqzPUmvIjWy
   Q==;
IronPort-SDR: i1tUvOnLH97xQSflAWOSTLMzVCqwZTdeZLd3RnENWhmfUavxRx/zDWp3Vn/5SPs6hwQSVvjRkN
 JDouJL7ty7/hvjnvFeqVVh/hB9TjwW1an+sWVlZKTYom8ZOACfprB7Qpy41sZYYjZ9MqcQ2Gv/
 G/qT/4XsCGYTBZnE/O6NWrvzaGgEM0uTwUigrOrs9NvPSIwhVY80wjgtWNGKlh173Co3fswe7I
 sfkECBpQuuDUFQlzzgF8bN7PWZ8G2sPiTm1RIYmdAh0ixoKQ1u1KoBwwTuYdu+8Th3bCVlatpF
 rcU=
X-IronPort-AV: E=Sophos;i="5.77,459,1596470400"; 
   d="scan'208";a="156564433"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2020 16:15:35 +0800
IronPort-SDR: 11r3r9yrywNL3nI9bn0a52Nh9J9OnQLMXfQB9in4CkS1J0WoKSNHxveavwaASa4PYpUC/LSXsM
 HjK/vCvwLBN+JcVCvQSY2IDloIaGjXQOqsK8RrSGmdKUEnDate059U8vVqpbqqLZbGJncCEn55
 ryvhPq2uTmBkd9L+cCu5vY5+g5TfQEvnEWUxLuBDXFtjVwiSQYHm0ply9WOWADl6C63qH/LxLs
 4YL+Oj+5Dd6bXhJPe2Og90u65xAsUg2n45vMZvRq6fgs5u38ckTremPsKBJV30iz2motp6DK7L
 FpJ7Nopj/apksimyn9nKS+0j
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2020 00:00:26 -0800
IronPort-SDR: wm66Qy/0HChucDX9w7hQOkrgUfMD8sdsv9JyXig2wbzGofnzoKmJIXIyPg8/eli6D5dkanBxYf
 bD7VpSATO851A/BzXhEw2iTnQjpuOOxrm9ci6Ipqoi8Rs7lc83cAzHhesV0MZqpNJ80dXvM/O+
 MAOvOPbQR6VrfDEq2qGT89g3zKgHQpmbd4nazHPE6n793KPZGHKblkLcmuYKmZ81EQlXFEBUL4
 gXgxBvRN49eBK4yiMnyMrJqHKoX+lPlbViXHhvGc6S4ppbxVaIqnRXo79Wpebe8F3vgq3FUR4Y
 HcM=
WDCIronportException: Internal
Received: from hdrdzf2.ad.shared (HELO twashi.fujisawa.hgst.com) ([10.84.71.85])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Nov 2020 00:15:33 -0800
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
Subject: [PATCH 27/32] riscv: Add SiPeed MAIX BiT board device tree
Date:   Sat,  7 Nov 2020 17:14:15 +0900
Message-Id: <20201107081420.60325-28-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201107081420.60325-1-damien.lemoal@wdc.com>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add a device tree for the SiPeed MAIX BiT and MAIX BiTm boards. This
device tree enables LEDs, gpio, i2c and spi/mmc SD card devices.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 .../riscv/boot/dts/kendryte/k210_maix_bit.dts | 226 ++++++++++++++++++
 1 file changed, 226 insertions(+)
 create mode 100644 arch/riscv/boot/dts/kendryte/k210_maix_bit.dts

diff --git a/arch/riscv/boot/dts/kendryte/k210_maix_bit.dts b/arch/riscv/boot/dts/kendryte/k210_maix_bit.dts
new file mode 100644
index 000000000000..fc814f7c1173
--- /dev/null
+++ b/arch/riscv/boot/dts/kendryte/k210_maix_bit.dts
@@ -0,0 +1,226 @@
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
+	model = "SiPeed MAIX BiT";
+	compatible = "sipeed,maix-bitm", "sipeed,maix-bit",
+		     "kendryte,k210";
+
+	chosen {
+		bootargs = "earlycon console=ttySIF0";
+		stdout-path = "serial0:115200n8";
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+
+		green {
+			gpios = <&gpio1_0 4 GPIO_ACTIVE_LOW>;
+		};
+
+		red {
+			gpios = <&gpio1_0 5 GPIO_ACTIVE_LOW>;
+		};
+
+		blue {
+			gpios = <&gpio1_0 6 GPIO_ACTIVE_LOW>;
+		};
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
+	fpioa_gpio: gpio {
+		pinmux = <K210_FPIOA(8, K210_PCF_GPIO0)>,
+			 <K210_FPIOA(9, K210_PCF_GPIO1)>,
+			 <K210_FPIOA(10, K210_PCF_GPIO2)>,
+			 <K210_FPIOA(11, K210_PCF_GPIO3)>,
+			 <K210_FPIOA(12, K210_PCF_GPIO4)>,
+			 <K210_FPIOA(13, K210_PCF_GPIO5)>,
+			 <K210_FPIOA(14, K210_PCF_GPIO6)>,
+			 <K210_FPIOA(15, K210_PCF_GPIO7)>;
+	};
+
+	fpioa_gpiohs: gpiohs {
+		pinmux = <K210_FPIOA(16, K210_PCF_GPIOHS0)>,
+			 <K210_FPIOA(17, K210_PCF_GPIOHS1)>,
+			 <K210_FPIOA(21, K210_PCF_GPIOHS5)>,
+			 <K210_FPIOA(22, K210_PCF_GPIOHS6)>,
+			 <K210_FPIOA(23, K210_PCF_GPIOHS7)>,
+			 <K210_FPIOA(24, K210_PCF_GPIOHS8)>,
+			 <K210_FPIOA(25, K210_PCF_GPIOHS9)>,
+			 <K210_FPIOA(32, K210_PCF_GPIOHS16)>,
+			 <K210_FPIOA(33, K210_PCF_GPIOHS17)>,
+			 <K210_FPIOA(34, K210_PCF_GPIOHS18)>,
+			 <K210_FPIOA(35, K210_PCF_GPIOHS19)>;
+	};
+
+	fpioa_i2s0: i2s0 {
+		pinmux = <K210_FPIOA(18, K210_PCF_I2S0_SCLK)>,
+			 <K210_FPIOA(19, K210_PCF_I2S0_WS)>,
+			 <K210_FPIOA(20, K210_PCF_I2S0_IN_D0)>;
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
+
+	fpioa_spi0: spi0 {
+		pinmux = <K210_FPIOA(36, K210_PCF_GPIOHS20)>,  /* cs */
+			 <K210_FPIOA(37, K210_PCF_GPIOHS21)>,  /* rst */
+			 <K210_FPIOA(38, K210_PCF_GPIOHS22)>,  /* dc */
+			 <K210_FPIOA(39, K210_PCF_SPI0_SCLK)>; /* wr */
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
+		pinmux = <K210_FPIOA(30, K210_PCF_I2C1_SCLK)>,
+			 <K210_FPIOA(31, K210_PCF_I2C1_SDA)>;
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

