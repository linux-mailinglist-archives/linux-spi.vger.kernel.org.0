Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3E1250A0C
	for <lists+linux-spi@lfdr.de>; Mon, 24 Aug 2020 22:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgHXUbt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Aug 2020 16:31:49 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:1288 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHXUbs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Aug 2020 16:31:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1598301107; x=1629837107;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JBnEMbT5FhJVwwYFZbXH52iXqnOAu6i1Ex45YVcTT8o=;
  b=CuPuQpJrE0ftwfqhLRtBYfmboiDwyCoMVdPa4qZ7B0IZlmkKnJKIR7Si
   ZVUwtRof1M9QM9FE+dCHskFzXLliZKke11rCdaZpytUB+EAwof2ilztZT
   O0AYW04uYog0aqneuN3b4I2WPSCk9jnNHzkZvCdopcXSToOJzCbui5P+5
   j7DvQseVBnfZLtptJBG8pZpbee2kNvuhR+/BOXIuy5IEgBLQKXHoeCd5P
   HsvcDaL7ilDTAB8VDLcMeTVvHpAd+g8fHuGAeWCFa80iIsDwfPkpRTGlz
   pmWC76lCjrxF4bNswNWpYcmxrPaxJY5iJ6ms2nKOKWK92bWFYrvSJHglw
   w==;
IronPort-SDR: fAUwfbuTMGpqP63Em6B2c+nnH4nnfcVsAnZoXX6j9rmnQgWvNdZ2UNrCQlaPgXTQwOy2NNJTZa
 pvslxkuTGUw+ECcCE6k1pOfCD5l3WEedoRhMsGEKobqrk/tiJP0/JGwIqg0xXzyJ6EtGjQRUen
 UEGLMvlzIyY+eibXoIjhb21xVnY+IKH17kHpBCFKdHYJ1Fi96eqj05Fuk60ABVZBpKlxXhq4i8
 vscEarpntRkZho5vBqtJM33+ZpLS9rzqfncrinwV1JnWXNRB33GUlSoGA9tQKrZd2CNDKQn/Cd
 qdo=
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; 
   d="scan'208";a="92962023"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2020 13:31:47 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 24 Aug 2020 13:31:41 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 24 Aug 2020 13:31:07 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: [PATCH v5 6/6] arm64: dts: sparx5: Add spi-nand devices
Date:   Mon, 24 Aug 2020 22:30:10 +0200
Message-ID: <20200824203010.2033-7-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200824203010.2033-1-lars.povlsen@microchip.com>
References: <20200824203010.2033-1-lars.povlsen@microchip.com>
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
 .../arm64/boot/dts/microchip/sparx5_nand.dtsi | 31 +++++++++++++++++++
 .../boot/dts/microchip/sparx5_pcb125.dts      | 14 +++++++++
 .../boot/dts/microchip/sparx5_pcb134.dts      |  1 +
 .../boot/dts/microchip/sparx5_pcb135.dts      |  1 +
 5 files changed, 67 insertions(+)
 create mode 100644 arch/arm64/boot/dts/microchip/sparx5_nand.dtsi

diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
index 89ac1a710216..f7ddfad3c318 100644
--- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
@@ -212,6 +212,26 @@ gpio: pinctrl@6110101e0 {
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
index 000000000000..03f107e427d7
--- /dev/null
+++ b/arch/arm64/boot/dts/microchip/sparx5_nand.dtsi
@@ -0,0 +1,31 @@
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
+&spi0 {
+	pinctrl-0 = <&si2_pins>;
+	pinctrl-names = "default";
+	spi@e {
+		compatible = "spi-mux";
+		mux-controls = <&mux>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <14>; /* CS14 */
+		spi-flash@6 {
+			compatible = "spi-nand";
+			pinctrl-0 = <&cs14_pins>;
+			pinctrl-names = "default";
+			reg = <0x6>; /* SPI2 */
+			spi-max-frequency = <42000000>;
+			rx-sample-delay-ns = <7>;  /* Tune for speed */
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb125.dts b/arch/arm64/boot/dts/microchip/sparx5_pcb125.dts
index c1eb1d661174..6b2da7c7520c 100644
--- a/arch/arm64/boot/dts/microchip/sparx5_pcb125.dts
+++ b/arch/arm64/boot/dts/microchip/sparx5_pcb125.dts
@@ -53,6 +53,20 @@ spi-flash@9 {
 			reg = <0x9>;	/* SPI */
 		};
 	};
+	spi@1 {
+		compatible = "spi-mux";
+		mux-controls = <&mux 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <1>; /* CS1 */
+		spi-flash@9 {
+			compatible = "spi-nand";
+			pinctrl-0 = <&cs1_pins>;
+			pinctrl-names = "default";
+			spi-max-frequency = <8000000>;
+			reg = <0x9>;	/* SPI */
+		};
+	};
 };
 
 &i2c1 {
diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb134.dts b/arch/arm64/boot/dts/microchip/sparx5_pcb134.dts
index feee4e99ff57..45ca1af7e850 100644
--- a/arch/arm64/boot/dts/microchip/sparx5_pcb134.dts
+++ b/arch/arm64/boot/dts/microchip/sparx5_pcb134.dts
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 #include "sparx5_pcb134_board.dtsi"
+#include "sparx5_nand.dtsi"
 
 / {
 	model = "Sparx5 PCB134 Reference Board (NAND)";
diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb135.dts b/arch/arm64/boot/dts/microchip/sparx5_pcb135.dts
index 20e409a9be19..647cdb38b113 100644
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

