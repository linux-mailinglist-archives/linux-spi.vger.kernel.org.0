Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C6C2120C7
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jul 2020 12:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgGBKPZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Jul 2020 06:15:25 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:55450 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728320AbgGBKO4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 2 Jul 2020 06:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1593684895; x=1625220895;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yDoDZ8DYA1T1BTptNVBI6RCIZ5mnmw6dAD6Z4C4BIDY=;
  b=SUZxIus9E3VrgmqgzwjuvZa8297WIORcfP3re1KN7Vps5ZQNblyo6xs9
   lJJoICo5jbuTg9tku03NpBgg6Ef6YmagfLYdtVvs3aMZhuNq8nP4uy4e+
   2kZxJfoejg4Qn3qOCPVn7Xi9SZ7ue3gX7x3yEnARZmu6RqZS5Q4dpQm2T
   Xtive6xPMx2sFae+4uZdsr8AirgWL2mXIwRIkkUDgijZtWyKlUg7/LHam
   MgNappg5SoCiapC21mDqfqzzbyDCzB7mwdbHkUDoVCvECSf9SAflZrhs9
   mZiE95PlcjnCrkdIGXj6zODiRp03uWXF5Ygl6DFT1S/BHdTftvboCfOrU
   g==;
IronPort-SDR: jEhWsPE+LDqDVAmyQIpuCdTd4oDnF77M08tpqeObMABRJ/eP49yEeEbG8eyZxUb0Wn7U5zt0bt
 5CRI/A/znJINmkNoeoXn4lkBhBYUXRZzHfI+E/p4qfLlkXDIqWO6D7vlZZc86N7PuOU8xkGY4a
 +lg8HCM7j98dsgoQ2jbNeo71bBY04L5r2lRe245/p74LBIlDxEX3hL270lxgW8e2Oc8zQqaSgT
 WeEjCjer9E//rZnMXRPxnCEc1J0j32hzpzxSKg4xxxH/O2yIxGQujy3noaxyj2O+ZB/ZBZ585x
 CCM=
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="85979797"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Jul 2020 03:14:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 2 Jul 2020 03:14:54 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 2 Jul 2020 03:14:31 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: [PATCH v3 8/8] arm64: dts: sparx5: Add spi-nand devices
Date:   Thu, 2 Jul 2020 12:13:31 +0200
Message-ID: <20200702101331.26375-9-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702101331.26375-1-lars.povlsen@microchip.com>
References: <20200702101331.26375-1-lars.povlsen@microchip.com>
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
 arch/arm64/boot/dts/microchip/sparx5.dtsi     | 20 ++++++++++++
 .../arm64/boot/dts/microchip/sparx5_nand.dtsi | 32 +++++++++++++++++++
 .../boot/dts/microchip/sparx5_pcb125.dts      |  7 ++++
 .../boot/dts/microchip/sparx5_pcb134.dts      |  1 +
 .../boot/dts/microchip/sparx5_pcb135.dts      |  1 +
 5 files changed, 61 insertions(+)
 create mode 100644 arch/arm64/boot/dts/microchip/sparx5_nand.dtsi

diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
index 2831935a489e1..21a85359d3492 100644
--- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
@@ -210,6 +210,26 @@ gpio: pinctrl@6110101e0 {
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
diff --git a/arch/arm64/boot/dts/microchip/sparx5_nand.dtsi b/arch/arm64/boot/dts/microchip/sparx5_nand.dtsi
new file mode 100644
index 0000000000000..fd9523d9efbe3
--- /dev/null
+++ b/arch/arm64/boot/dts/microchip/sparx5_nand.dtsi
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2020 Microchip Technology Inc. and its subsidiaries.
+ */
+
+&gpio {
+	cs14_pins: cs14-pins {
+		pins = "GPIO_44";
+		function = "si";
+	};
+};
+
+&mux {
+	/* CS14 (NAND) is on SPI2 */
+	mux@e {
+		reg = <14>;
+		microchip,bus-interface = <1>;
+	};
+};
+
+&spi0 {
+	pinctrl-0 = <&si2_pins>;
+	pinctrl-names = "default";
+	spi-flash@e {
+		compatible = "spi-nand";
+		pinctrl-0 = <&cs14_pins>;
+		pinctrl-names = "default";
+		spi-max-frequency = <42000000>;
+		reg = <14>;
+		snps,rx-sample-delay-ns = <7>;  /* Tune for speed */
+	};
+};
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
index feee4e99ff57c..45ca1af7e8500 100644
--- a/arch/arm64/boot/dts/microchip/sparx5_pcb134.dts
+++ b/arch/arm64/boot/dts/microchip/sparx5_pcb134.dts
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 #include "sparx5_pcb134_board.dtsi"
+#include "sparx5_nand.dtsi"
 
 / {
 	model = "Sparx5 PCB134 Reference Board (NAND)";
diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb135.dts b/arch/arm64/boot/dts/microchip/sparx5_pcb135.dts
index 20e409a9be196..647cdb38b1130 100644
--- a/arch/arm64/boot/dts/microchip/sparx5_pcb135.dts
+++ b/arch/arm64/boot/dts/microchip/sparx5_pcb135.dts
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 #include "sparx5_pcb135_board.dtsi"
+#include "sparx5_nand.dtsi"
 
 / {
 	model = "Sparx5 PCB135 Reference Board (NAND)";
-- 
2.27.0

