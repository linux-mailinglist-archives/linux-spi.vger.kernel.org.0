Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFAF3164EA
	for <lists+linux-spi@lfdr.de>; Tue,  7 May 2019 15:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfEGNs1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 May 2019 09:48:27 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:41559 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfEGNs0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 May 2019 09:48:26 -0400
X-Originating-IP: 90.88.28.253
Received: from localhost (aaubervilliers-681-1-86-253.w90-88.abo.wanadoo.fr [90.88.28.253])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 2D759C0009;
        Tue,  7 May 2019 13:48:24 +0000 (UTC)
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH 4/4] ARM: dts: sun6i: Add default address and size cells for SPI
Date:   Tue,  7 May 2019 15:48:16 +0200
Message-Id: <ee26c07fa953422fdaeb27c00ddfe98cc82d4017.1557236840.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <b7a6095a5c900fa23cc54d1ccd8e8ef0ccf6e788.1557236840.git-series.maxime.ripard@bootlin.com>
References: <b7a6095a5c900fa23cc54d1ccd8e8ef0ccf6e788.1557236840.git-series.maxime.ripard@bootlin.com>
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
