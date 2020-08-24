Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90810250A0B
	for <lists+linux-spi@lfdr.de>; Mon, 24 Aug 2020 22:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgHXUbn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Aug 2020 16:31:43 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:50492 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgHXUbm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Aug 2020 16:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1598301101; x=1629837101;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=01xDScPadyK256GFpsKDGIb3rTo/JpOGDyEVOQKEGJM=;
  b=WAnVh/aJKfc/z2V6o673vUlJvuX22wONtVWuRyMVpUQsJhrgU8jOC7w2
   iIDDA1bo6Z0SmPxmqqe+HDITcBaEhtF8s/Zt8R3G0paNUo7jQIXL30ERk
   wPNrwj79eeMgABWZtOQtBxVWSqpciQidFt7dtk5cs6BKe70h3BBlatwfA
   T+zib4UqnxwYuBx85VkREhaBjspH3WWtkicJbrB7bCUAAcy6bnte5dUrk
   pIIBX2T39/j8aRt6hAb2zwWCCUf4FysxLgir0e19es+CMHkHpEy1jmNXd
   KALXyKMzQSrrbzagP6zjy+6Y8+hUUiAItUS+hBdfb8vJlJqyJP4aMguzz
   A==;
IronPort-SDR: 3E/2A5oFEjN2VH7X2CBQzEf55XFNlvPE5odv0Kfrmuzb89shq/arlYxLDYoMtcP1jVDD26E9QO
 /N2T+v5OX2QIipNXNuGrKnSdGu0RbP49WpgG3FzIW+Zz8Oi1H77XPw+t/BsUnywgpBU/2m3Hwz
 ov+zl4wZxbdiYR8G6KzSSW+FIGtE6nxQK90qqqFpiGkfMD4+/lQgW5xAwS7Eld2ibNgbuAZmz6
 vTR2r40QIM5D0D6PNTFPjPdiC6cTG1AckhhFHvUYlPOHH5jRlpKnWfbscOwtJTKUuWsLmlGtG1
 8g4=
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; 
   d="scan'208";a="86744159"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2020 13:31:41 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 24 Aug 2020 13:31:35 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 24 Aug 2020 13:31:01 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: [PATCH v5 5/6] arm64: dts: sparx5: Add spi-nor support
Date:   Mon, 24 Aug 2020 22:30:09 +0200
Message-ID: <20200824203010.2033-6-lars.povlsen@microchip.com>
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

This add spi-nor device nodes to the Sparx5 reference boards.

Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 arch/arm64/boot/dts/microchip/sparx5_pcb125.dts  | 16 ++++++++++++++++
 .../boot/dts/microchip/sparx5_pcb134_board.dtsi  | 16 ++++++++++++++++
 .../boot/dts/microchip/sparx5_pcb135_board.dtsi  | 16 ++++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb125.dts b/arch/arm64/boot/dts/microchip/sparx5_pcb125.dts
index 573309fe4582..c1eb1d661174 100644
--- a/arch/arm64/boot/dts/microchip/sparx5_pcb125.dts
+++ b/arch/arm64/boot/dts/microchip/sparx5_pcb125.dts
@@ -39,6 +39,22 @@ &sdhci0 {
 	microchip,clock-delay = <10>;
 };
 
+&spi0 {
+	status = "okay";
+	spi@0 {
+		compatible = "spi-mux";
+		mux-controls = <&mux>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0>;	/* CS0 */
+		spi-flash@9 {
+			compatible = "jedec,spi-nor";
+			spi-max-frequency = <8000000>;
+			reg = <0x9>;	/* SPI */
+		};
+	};
+};
+
 &i2c1 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi b/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
index 18a535a04368..35984785d611 100644
--- a/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
@@ -38,6 +38,22 @@ gpio-restart {
 	};
 };
 
+&spi0 {
+	status = "okay";
+	spi@0 {
+		compatible = "spi-mux";
+		mux-controls = <&mux>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0>;	/* CS0 */
+		spi-flash@9 {
+			compatible = "jedec,spi-nor";
+			spi-max-frequency = <8000000>;
+			reg = <0x9>;	/* SPI */
+		};
+	};
+};
+
 &gpio {
 	i2cmux_pins_i: i2cmux-pins-i {
 	       pins = "GPIO_16", "GPIO_17", "GPIO_18", "GPIO_19",
diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi b/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
index d71f11a10b3d..7de66806b14b 100644
--- a/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
@@ -51,6 +51,22 @@ i2cmux_s32: i2cmux-3 {
 	};
 };
 
+&spi0 {
+	status = "okay";
+	spi@0 {
+		compatible = "spi-mux";
+		mux-controls = <&mux>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0>; /* CS0 */
+		spi-flash@9 {
+			compatible = "jedec,spi-nor";
+			spi-max-frequency = <8000000>;
+			reg = <0x9>; /* SPI */
+		};
+	};
+};
+
 &axi {
 	i2c0_imux: i2c0-imux@0 {
 		compatible = "i2c-mux-pinctrl";
-- 
2.27.0

