Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B341A13FCC2
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2020 00:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388115AbgAPXMK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Jan 2020 18:12:10 -0500
Received: from foss.arm.com ([217.140.110.172]:34060 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729336AbgAPXMK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 16 Jan 2020 18:12:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3F4D11D4;
        Thu, 16 Jan 2020 15:12:09 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2723C3F68E;
        Thu, 16 Jan 2020 15:12:08 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        devicetree@vger.kernel.org
Subject: [PATCH v3 2/3] arm64: dts: allwinner: h6: Pine H64: Add SPI flash node
Date:   Thu, 16 Jan 2020 23:11:47 +0000
Message-Id: <20200116231148.1490-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20200116231148.1490-1-andre.przywara@arm.com>
References: <20200116231148.1490-1-andre.przywara@arm.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The Pine H64 board comes with SPI flash soldered on the board, connected
to the SPI0 pins (so it can also boot from there).

Add the required SPI flash DT node to describe this.

Unfortunately the SPI CS0 pin collides with the eMMC CMD pin, so we can't
use both eMMC and SPI flash at the same time (the first to claim the pin
would win, the other's probe routine would then fail).

To avoid losing the more useful eMMC device by chance, mark the SPI
device as "disabled" for now. A user or some U-Boot code could fix this
up if needed, for instance if no eMMC has been detected (it's socketed).

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index d1c2aa5b3a20..3c9dd0d69754 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -14,6 +14,7 @@
 	aliases {
 		ethernet0 = &emac;
 		serial0 = &uart0;
+		spi0 = &spi0;
 	};
 
 	chosen {
@@ -278,6 +279,24 @@
 	vcc-pm-supply = <&reg_aldo1>;
 };
 
+/*
+ * The CS pin is shared with the MMC2 CMD pin, so we cannot have the SPI
+ * flash and eMMC at the same time, as one of them would fail probing.
+ * Disable SPI0 in here, to prefer the more useful eMMC. U-Boot can
+ * fix this up in no eMMC is connected.
+ */
+&spi0 {
+	pinctrl-0 = <&spi0_pins>, <&spi0_cs_pin>;
+	pinctrl-names = "default";
+	status = "disabled";
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
2.14.5

