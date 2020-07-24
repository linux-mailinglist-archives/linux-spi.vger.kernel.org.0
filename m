Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1882C22C42E
	for <lists+linux-spi@lfdr.de>; Fri, 24 Jul 2020 13:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgGXLOw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Jul 2020 07:14:52 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:23503 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgGXLOw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 24 Jul 2020 07:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595589291; x=1627125291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=waqXZnk28E7CDrTE7Pdur3L9Lz9pzClbHiza62G0WAM=;
  b=f0tuoDhVFP69LlvAgT/HphRGHkvHXjtkXfd0EiGiCXaPFfqOMbabBSlh
   jWDmy15kk4m3+kHZGSkrKRPgGxOBRrTC1y0M8vEl7PfUVIynvk8CqVC7h
   irrmbYhsv8BB4kSyqy3z204lTJqpN/iwFRa5LIBZv6aRykp6YN4FGAjeO
   eDg8giTiBGsAmqSlfgt8KlJU6O0io8G03oBfLTxdsx9kP9VOB5xU0di0q
   Kh1HLeVDcLuxbHBcZlbJrOrStnGikNvqi4t6kPbNYTmKOWx4DldsDEqnp
   ePDsuuve8g11kPTou5gLOk1kEjW/zJj9XYGiBv9N0XBvEmeRRyWRrSz+Q
   w==;
IronPort-SDR: WAbbgNE1hKhldkGByJhpWpklO9SSHN044DLMhy8EFTHX5n2VBtoZ6cgSsGMLOomMNw6//JKEWu
 Ujy7bRY681V7zVUPMUrCgzymcXVSO//q47THxAThhUnPBR2dPSlZT4KwSfInc7LrVUlAouvLHt
 uWqvg/dV91yyg0A03xe0IIcMF/UO4B2k5NlkLIZs/WZmpo/0+CDh7sWCWhrjIcva8B404d9FMs
 sv36Ij11KmAqrgpWRc0PxZZw1WYAMIQfeRV/jN7Nt078rH3IxLUte3vE3Wz+qaMHtno2535Q5X
 lAQ=
X-IronPort-AV: E=Sophos;i="5.75,390,1589266800"; 
   d="scan'208";a="85239387"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Jul 2020 04:14:51 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 24 Jul 2020 04:14:50 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 24 Jul 2020 04:14:08 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: [PATCH v4 5/6] arm64: dts: sparx5: Add spi-nor support
Date:   Fri, 24 Jul 2020 13:14:03 +0200
Message-ID: <20200724111404.13293-6-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200724111404.13293-1-lars.povlsen@microchip.com>
References: <20200724111404.13293-1-lars.povlsen@microchip.com>
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
index 573309fe45823..c1eb1d661174d 100644
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
index 18a535a043686..35984785d611c 100644
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
index d71f11a10b3d2..7de66806b14b3 100644
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

