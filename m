Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20EDF2007D6
	for <lists+linux-spi@lfdr.de>; Fri, 19 Jun 2020 13:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731775AbgFSLcB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 19 Jun 2020 07:32:01 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:55746 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728430AbgFSLbt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 19 Jun 2020 07:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1592566308; x=1624102308;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6bWMVQyiZhkbxaK4Gike1YVVJfzi1Pv5G9DM+U2OgNg=;
  b=BM47cSba9DcegoB46YVykkmTRiYxQalXEtb/MUyVX6Q5BLxa1icsUPYX
   zmEGo+6rla2kWQlCC223R8vzZxzxnBS4KZsEFgK4kxbRD2ZQoF352+tb3
   Wqp0fjxzPkuONcZVeX8wDVp5OLS3enduaR/D1vL4GXPJPTk9mn6HGuu8i
   ENHSyWlg2luLq3uey+3ZTH1yxvTS5qgThLpB59FsYzC4HX0du5rOn0vxW
   SreoGuZmjyX8eaIxAILFJvS9Y2nKaDKY3L8vw7BbKZeOVdF57ejv/3rQE
   y0DQxFXH5S4TS0Voxo1eKAl2E0X5zRcQ+jerf5BRU3sVSwtVu64c3rqU6
   g==;
IronPort-SDR: B6Q/1J4o6f/kMH+pKLOZp3P7PIczT9Q7OpYp8zBmP02/QvdiRcPB1Ll7xGkPBIZ4fOLRzdk6jQ
 lbKfDyopOht4pH855xIAlsM6bGS7IgL+q+NzkN5ZBIDucqFz99WMaSLJoR6A7wOJBoBISEbJiR
 P7+Cfk8Gb5hlq7xgyjS1vRwMJXUXpinjAG++UWVT4P1LhoVmB+25MaguGRI6nkVrVXNW4coZcc
 92Zm4Wb6212yCHbs0HVbybmmQRKHvi3yBU0Nxn5VbB05X7mOH20WwjatUfDbY0xUOu7IYpXKkr
 OjE=
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="77162032"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jun 2020 04:31:47 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 19 Jun 2020 04:31:40 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 19 Jun 2020 04:31:38 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Mark Brown <broonie@kernel.org>, SoC Team <soc@kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: [PATCH v2 6/6] arm64: dts: sparx5: Add spi-nand devices
Date:   Fri, 19 Jun 2020 13:31:21 +0200
Message-ID: <20200619113121.9984-7-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619113121.9984-1-lars.povlsen@microchip.com>
References: <20200619113121.9984-1-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch add spi-nand DT nodes to the applicable Sparx5 boards.

Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 arch/arm64/boot/dts/microchip/sparx5.dtsi     | 20 ++++++++++++++++
 .../boot/dts/microchip/sparx5_pcb125.dts      |  7 ++++++
 .../boot/dts/microchip/sparx5_pcb134.dts      | 22 ++++++++++++++++++
 .../boot/dts/microchip/sparx5_pcb135.dts      | 23 +++++++++++++++++++
 4 files changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
index 2404bcc08b89d..dd666d185e466 100644
--- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
@@ -201,6 +201,26 @@ gpio: pinctrl@6110101e0 {
 			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 			#interrupt-cells = <2>;
 
+			cs1_pins: cs1-pins {
+				pins = "GPIO_16";
+				function = "si";
+			};
+
+			cs2_pins: cs2-pins {
+				pins = "GPIO_17";
+				function = "si";
+			};
+
+			cs3_pins: cs3-pins {
+				pins = "GPIO_18";
+				function = "si";
+			};
+
+			si2_pins: si2-pins {
+				pins = "GPIO_39", "GPIO_40", "GPIO_41";
+				function = "si2";
+			};
+
 			uart_pins: uart-pins {
 				pins = "GPIO_10", "GPIO_11";
 				function = "uart";
diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb125.dts b/arch/arm64/boot/dts/microchip/sparx5_pcb125.dts
index d8b5d23abfab0..94c4c3fd5a786 100644
--- a/arch/arm64/boot/dts/microchip/sparx5_pcb125.dts
+++ b/arch/arm64/boot/dts/microchip/sparx5_pcb125.dts
@@ -46,6 +46,13 @@ spi-flash@0 {
 		spi-max-frequency = <8000000>; /* input clock */
 		reg = <0>; /* CS0 */
 	};
+	spi-flash@1 {
+		compatible = "spi-nand";
+		pinctrl-0 = <&cs1_pins>;
+		pinctrl-names = "default";
+		spi-max-frequency = <8000000>;
+		reg = <1>; /* CS1 */
+	};
 };
 
 &i2c1 {
diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb134.dts b/arch/arm64/boot/dts/microchip/sparx5_pcb134.dts
index feee4e99ff57c..7aee0548e44cb 100644
--- a/arch/arm64/boot/dts/microchip/sparx5_pcb134.dts
+++ b/arch/arm64/boot/dts/microchip/sparx5_pcb134.dts
@@ -15,3 +15,25 @@ memory@0 {
 		reg = <0x00000000 0x00000000 0x10000000>;
 	};
 };
+
+&gpio {
+	cs14_pins: cs14-pins {
+		pins = "GPIO_44";
+		function = "si";
+	};
+};
+
+&spi0 {
+	pinctrl-0 = <&si2_pins>;
+	pinctrl-names = "default";
+	/* Dedicated SPI2 interface */
+	spi-flash@e {
+		compatible = "spi-nand";
+		pinctrl-0 = <&cs14_pins>;
+		pinctrl-names = "default";
+		spi-max-frequency = <42000000>;
+		reg = <14>;
+		microchip,spi-interface2;	/* SPI2 */
+		snps,rx-sample-delay-ns = <7>;  /* Tune for speed */
+	};
+};
diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb135.dts b/arch/arm64/boot/dts/microchip/sparx5_pcb135.dts
index 20e409a9be196..8f2329ce02030 100644
--- a/arch/arm64/boot/dts/microchip/sparx5_pcb135.dts
+++ b/arch/arm64/boot/dts/microchip/sparx5_pcb135.dts
@@ -15,3 +15,26 @@ memory@0 {
 		reg = <0x00000000 0x00000000 0x10000000>;
 	};
 };
+
+&gpio {
+	cs14_pins: cs14-pins {
+		pins = "GPIO_44";
+		function = "si";
+	};
+};
+
+&spi0 {
+	status = "okay";
+	pinctrl-0 = <&si2_pins>;
+	pinctrl-names = "default";
+	/* Dedicated SPI2 interface */
+	spi-flash@e {
+		compatible = "spi-nand";
+		pinctrl-0 = <&cs14_pins>;
+		pinctrl-names = "default";
+		spi-max-frequency = <42000000>;
+		reg = <14>;
+		microchip,spi-interface2;	/* SPI2 */
+		snps,rx-sample-delay-ns = <7>;  /* Tune for speed */
+	};
+};
-- 
2.27.0

