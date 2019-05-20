Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF6423B33
	for <lists+linux-spi@lfdr.de>; Mon, 20 May 2019 16:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387855AbfETOvD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 May 2019 10:51:03 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:57851 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732937AbfETOvD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 May 2019 10:51:03 -0400
Received: from localhost (aaubervilliers-681-1-80-185.w90-88.abo.wanadoo.fr [90.88.22.185])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id A2A3C10000A;
        Mon, 20 May 2019 14:50:59 +0000 (UTC)
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH v3 4/4] ARM: dts: sun6i: Add default address and size cells for SPI
Date:   Mon, 20 May 2019 16:50:36 +0200
Message-Id: <622e3d2ece14e5b84a7975026bb1a981228ee3ab.1558363790.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <f53ee257855c6499fd783dc8665558f7670312f6.1558363790.git-series.maxime.ripard@bootlin.com>
References: <f53ee257855c6499fd783dc8665558f7670312f6.1558363790.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The SPI controller bindings require an address cell size of 1, and a size
cell size of 0. Let's put it at the DTSI level to make sure that's properly
enforced.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index c04efad81bbc..a57cbf33c12f 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -987,6 +987,8 @@
 			dma-names = "rx", "tx";
 			resets = <&ccu RST_AHB1_SPI0>;
 			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		spi1: spi@1c69000 {
@@ -999,6 +1001,8 @@
 			dma-names = "rx", "tx";
 			resets = <&ccu RST_AHB1_SPI1>;
 			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		spi2: spi@1c6a000 {
@@ -1011,6 +1015,8 @@
 			dma-names = "rx", "tx";
 			resets = <&ccu RST_AHB1_SPI2>;
 			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		spi3: spi@1c6b000 {
@@ -1023,6 +1029,8 @@
 			dma-names = "rx", "tx";
 			resets = <&ccu RST_AHB1_SPI3>;
 			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		gic: interrupt-controller@1c81000 {
-- 
git-series 0.9.1
