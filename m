Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3793C5EBE
	for <lists+linux-spi@lfdr.de>; Mon, 12 Jul 2021 17:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbhGLPFh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 12 Jul 2021 11:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235313AbhGLPFg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 12 Jul 2021 11:05:36 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E248C0613E8;
        Mon, 12 Jul 2021 08:02:48 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 6FA151F425BB
Received: by jupiter.universe (Postfix, from userid 1000)
        id 46AD44800C8; Mon, 12 Jul 2021 17:02:44 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Ian Ray <ian.ray@ge.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv6 2/3] ARM: dts: imx53-ppd: Fix ACHC entry
Date:   Mon, 12 Jul 2021 17:02:41 +0200
Message-Id: <20210712150242.146545-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210712150242.146545-1-sebastian.reichel@collabora.com>
References: <20210712150242.146545-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

PPD has only one ACHC device, which effectively is a Kinetis
microcontroller. It has one SPI interface used for normal
communication. Additionally it's possible to flash the device
firmware using NXP's EzPort protocol by correctly driving a
second chip select pin and the device reset pin.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm/boot/dts/imx53-ppd.dts | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-ppd.dts b/arch/arm/boot/dts/imx53-ppd.dts
index 5a5fa6190a52..37d0cffea99c 100644
--- a/arch/arm/boot/dts/imx53-ppd.dts
+++ b/arch/arm/boot/dts/imx53-ppd.dts
@@ -70,6 +70,12 @@ cko2_11M: sgtl-clock-cko2 {
 		clock-frequency = <11289600>;
 	};
 
+	achc_24M: achc-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+	};
+
 	sgtlsound: sound {
 		compatible = "fsl,imx53-cpuvo-sgtl5000",
 			     "fsl,imx-audio-sgtl5000";
@@ -314,16 +320,13 @@ &gpio4 11 GPIO_ACTIVE_LOW
 		    &gpio4 12 GPIO_ACTIVE_LOW>;
 	status = "okay";
 
-	spidev0: spi@0 {
-		compatible = "ge,achc";
-		reg = <0>;
-		spi-max-frequency = <1000000>;
-	};
-
-	spidev1: spi@1 {
-		compatible = "ge,achc";
-		reg = <1>;
-		spi-max-frequency = <1000000>;
+	spidev0: spi@1 {
+		compatible = "ge,achc", "nxp,kinetis-k20";
+		reg = <1>, <0>;
+		vdd-supply = <&reg_3v3>;
+		vdda-supply = <&reg_3v3>;
+		clocks = <&achc_24M>;
+		reset-gpios = <&gpio3 6 GPIO_ACTIVE_LOW>;
 	};
 
 	gpioxra0: gpio@2 {
-- 
2.30.2

