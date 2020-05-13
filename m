Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0DB1D16CE
	for <lists+linux-spi@lfdr.de>; Wed, 13 May 2020 16:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388855AbgEMOBP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 May 2020 10:01:15 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:15552 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388829AbgEMOBD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 May 2020 10:01:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589378462; x=1620914462;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iauAWz+CB287sxl5gww1bSL60uZ1IZfFjbf+2bfJDKU=;
  b=CEdDcoDiZefM0Pbp2a9TPfYPRvlFbH3TIhXrDIcwhbUZB7q4RJqY5y3M
   0wDMhOdj0I55X/Okd+da3sE+HCRyhyST0B9FSzPlNQVliGBM6lG4JtkIg
   Iozv+DZUtSnyERbVydlZU5xfmkkwoiMfBCBLY68OdrGU34nJMEISqTost
   gbHXAW7Jlc80viWo0Rm+BBNMA0YM47e7CMipYOsso+smS4pn60ZmLAWO2
   T83nm0IsSv4MfV+N9ky/JFX+wplnyP69Vwvmb3/u53jNzLFFbSrg+QpYq
   /8RQNtHerApTYJHK11JSTL9QOQGM88DBG/px7atD7AqT9WAV4VK1KqtVG
   w==;
IronPort-SDR: rJGSY8q8PbCBR7XcB8/siK/Ft2wQh8SFJgTIYblb9ci/I5wfzXdWBC78Jm/Ve7XQKMhDlIbST9
 PD7KOxcdgKauy9aexCg2LsfVU5x6IQA8pvNlIzcHBFDY39UQitL9AMbrHfagYhu8MzJWKtoRcq
 SsVJTwAy13eWseriiCmCbYjFl5SHrWYlKKIiIXhtq35zn6kF9zF9XX3lQZ5J8FDKchWx2UiXur
 IeFUqBeNMTvYXKvBBeeLIoyLc4qomECTkTOVpg2xL03Ya+WaZH8ONXc2xAgLFcikFQNIvHnfCh
 wNA=
X-IronPort-AV: E=Sophos;i="5.73,388,1583218800"; 
   d="scan'208";a="73314076"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2020 07:01:02 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 May 2020 07:01:01 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Wed, 13 May 2020 07:00:59 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Mark Brown <broonie@kernel.org>, SoC Team <soc@kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 09/10] arm64: dts: sparx5: Add spi-nor support
Date:   Wed, 13 May 2020 16:00:30 +0200
Message-ID: <20200513140031.25633-10-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513140031.25633-1-lars.povlsen@microchip.com>
References: <20200513140031.25633-1-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This add spi-nor device nodes to the Sparx5 reference boards.

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 arch/arm64/boot/dts/microchip/sparx5.dtsi              | 5 +++--
 arch/arm64/boot/dts/microchip/sparx5_pcb125.dts        | 9 +++++++++
 arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi | 9 +++++++++
 arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi | 9 +++++++++
 4 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
index daa216978887d..330fd8b096d4c 100644
--- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
@@ -155,8 +155,9 @@ spi0: spi@600104000 {
 			reg-io-width = <4>;
 			reg-shift = <2>;
 			clocks = <&ahb_clk>;
-			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
-
+			/* NB: Polled mode - next line commented out
+			 * interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+			 */
 			status = "disabled";
 		};

diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb125.dts b/arch/arm64/boot/dts/microchip/sparx5_pcb125.dts
index 573309fe45823..d8b5d23abfab0 100644
--- a/arch/arm64/boot/dts/microchip/sparx5_pcb125.dts
+++ b/arch/arm64/boot/dts/microchip/sparx5_pcb125.dts
@@ -39,6 +39,15 @@ &sdhci0 {
 	microchip,clock-delay = <10>;
 };

+&spi0 {
+	status = "okay";
+	spi-flash@0 {
+		compatible = "jedec,spi-nor";
+		spi-max-frequency = <8000000>; /* input clock */
+		reg = <0>; /* CS0 */
+	};
+};
+
 &i2c1 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi b/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
index 18a535a043686..628a05d3f57ce 100644
--- a/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
@@ -38,6 +38,15 @@ gpio-restart {
 	};
 };

+&spi0 {
+	status = "okay";
+	spi-flash@0 {
+		compatible = "jedec,spi-nor";
+		spi-max-frequency = <8000000>;
+		reg = <0>;
+	};
+};
+
 &gpio {
 	i2cmux_pins_i: i2cmux-pins-i {
 	       pins = "GPIO_16", "GPIO_17", "GPIO_18", "GPIO_19",
diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi b/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
index d71f11a10b3d2..fb0bc3b241204 100644
--- a/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
@@ -51,6 +51,15 @@ i2cmux_s32: i2cmux-3 {
 	};
 };

+&spi0 {
+	status = "okay";
+	spi-flash@0 {
+		compatible = "jedec,spi-nor";
+		spi-max-frequency = <8000000>;
+		reg = <0>;
+	};
+};
+
 &axi {
 	i2c0_imux: i2c0-imux@0 {
 		compatible = "i2c-mux-pinctrl";
--
2.26.2
