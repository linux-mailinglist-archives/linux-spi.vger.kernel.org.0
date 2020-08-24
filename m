Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE353250A02
	for <lists+linux-spi@lfdr.de>; Mon, 24 Aug 2020 22:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgHXUbI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Aug 2020 16:31:08 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:1208 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgHXUbH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Aug 2020 16:31:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1598301066; x=1629837066;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=atyoAk5TR54YesZOuzk8VVCLqt7LgBNZMxC4e62bE6Q=;
  b=YxLRWP4WwQEqSECOOf0kg8/fd9xWiuKlD+u+xadpD76kV6KIcd0KCiur
   oB1MjIux0gRCVLgQHbWLBOvJvp5E+rjxkGFxlfSItGn8qS4nUeabVj7E3
   bPsHJlxQsWr7SvKoNNqyvXxetHFpyTavkN6zjpZOruXxCCPojAoY1lTxa
   9VpQl3/b1BvUa2AMarQmftXqG/EvBsixNZX4Rc9w5fuHET3ngRF3PbBx5
   lzD+c90LsAjtkgdZs9ZkpVZHWTnvvGiKUUZk/19Jf0H0Auy6qsq4mQTTy
   hqYmb67/zGkMIWJp0L0p1YQfpu+OXKSgnRxf/WD2/o2yPxXRSD0QfM15R
   g==;
IronPort-SDR: NkfTYEu8UHHgle0qdxOgo2mI4e/2jjboJU1tcd3s1sQx5jKHCX3CisFVwsAsoMQnN+oFr6V37O
 2ZHWMd0M4h6ALVGCsw2vRMFzpgey5TLkXM8wqWtbwRZ47VkPZrjLPPcwg6V/0yu/EkVP9LXsJY
 VaQ6NMm2PcvIWQG4y8VonP+5p7TPrDhx6zsT12BT4/aKMy6grmf6SGT6cpQuUQpK3KaXhgbtPK
 6pMuIGAuJ4Wxa6F3uEgFJSGUXe7+uTrIT4DUCTKnjRltwhuX6eVx0BHcaPKNPCiVKgphFFsMhN
 c3k=
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; 
   d="scan'208";a="92961945"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2020 13:31:05 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 24 Aug 2020 13:31:00 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 24 Aug 2020 13:30:26 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: [PATCH v5 3/6] arm64: dts: sparx5: Add SPI controller and associated mmio-mux
Date:   Mon, 24 Aug 2020 22:30:07 +0200
Message-ID: <20200824203010.2033-4-lars.povlsen@microchip.com>
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

This adds a SPI controller to the Microchip Sparx5 SoC, as well as the
mmio-mux that is required to select the right SPI interface for a
given SPI device.

Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 arch/arm64/boot/dts/microchip/sparx5.dtsi | 27 ++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
index c9dbd1a8b22b..89ac1a710216 100644
--- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
@@ -14,6 +14,7 @@ / {
 	#size-cells = <1>;
 
 	aliases {
+		spi0 = &spi0;
 		serial0 = &uart0;
 		serial1 = &uart1;
 	};
@@ -119,8 +120,19 @@ gic: interrupt-controller@600300000 {
 		};
 
 		cpu_ctrl: syscon@600000000 {
-			compatible = "microchip,sparx5-cpu-syscon", "syscon";
+			compatible = "microchip,sparx5-cpu-syscon", "syscon",
+				     "simple-mfd";
 			reg = <0x6 0x00000000 0xd0>;
+			mux: mux-controller {
+				compatible = "mmio-mux";
+				#mux-control-cells = <0>;
+				/*
+				 * SI_OWNER and SI2_OWNER in GENERAL_CTRL
+				 * SPI:  value 9 - (SIMC,SIBM) = 0b1001
+				 * SPI2: value 6 - (SIBM,SIMC) = 0b0110
+				 */
+				mux-reg-masks = <0x88 0xf0>;
+			};
 		};
 
 		reset@611010008 {
@@ -155,6 +167,19 @@ uart1: serial@600102000 {
 			status = "disabled";
 		};
 
+		spi0: spi@600104000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "microchip,sparx5-spi";
+			reg = <0x6 0x00104000 0x40>;
+			num-cs = <16>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			clocks = <&ahb_clk>;
+			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
 		timer1: timer@600105000 {
 			compatible = "snps,dw-apb-timer";
 			reg = <0x6 0x00105000 0x1000>;
-- 
2.27.0

