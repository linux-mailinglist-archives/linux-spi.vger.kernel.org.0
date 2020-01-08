Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE9EA133EF5
	for <lists+linux-spi@lfdr.de>; Wed,  8 Jan 2020 11:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgAHKKa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Jan 2020 05:10:30 -0500
Received: from foss.arm.com ([217.140.110.172]:41730 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgAHKKa (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 8 Jan 2020 05:10:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7A8F328;
        Wed,  8 Jan 2020 02:10:29 -0800 (PST)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.44])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6EF6F3F6C4;
        Wed,  8 Jan 2020 02:10:28 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.xyz>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 2/2] arm64: dts: allwinner: h6: Pine H64: Add SPI flash node
Date:   Wed,  8 Jan 2020 10:10:06 +0000
Message-Id: <20200108101006.150706-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200108101006.150706-1-andre.przywara@arm.com>
References: <20200108101006.150706-1-andre.przywara@arm.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The Pine H64 board comes with SPI flash soldered on the board, connected
to the SPI0 pins (so it can also boot from there).

Add the required DT node to make the flash accessible from Linux.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index d1c2aa5b3a20..a72f605a3a64 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -14,6 +14,7 @@
 	aliases {
 		ethernet0 = &emac;
 		serial0 = &uart0;
+		spi0 = &spi0;
 	};
 
 	chosen {
@@ -278,6 +279,18 @@
 	vcc-pm-supply = <&reg_aldo1>;
 };
 
+&spi0 {
+	pinctrl-0 = <&spi0_pins>, <&spi0_cs_pin>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	flash@0 {
+		compatible = "winbond,w25q128", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <4000000>;
+	};
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_ph_pins>;
-- 
2.17.1

