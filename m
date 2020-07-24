Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD46022C426
	for <lists+linux-spi@lfdr.de>; Fri, 24 Jul 2020 13:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgGXLOi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Jul 2020 07:14:38 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:42608 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgGXLOh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 24 Jul 2020 07:14:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595589277; x=1627125277;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PhVb16dlb4qmPmqLOrMxx9+Ich2tP3QYypUEzEv+cvQ=;
  b=pQs+c+eD7WgZUFjeg+RuBl1kVOEn7NOC2blXKJ+gNJ3wCS8PUweT+xUc
   DCC5b5jGtjZt8SuBLgJRH/xT/47tuEKuiizdyVh+/YzaIAaIG6tn1ptw1
   72m7BkoghwWHHVWaWxGPwKI/8taoAGALWn3jV+S/LQd2An84YT9u0A6gu
   M3JZ/IP/1cGtERxiTFlH20MrfyQj9N+vMBDqPNtgH33MMeEfa2RYLxKM7
   GjgwToYvoKgyf1syN9fgHf8dNhE62CgAroZUvBcUGviQS1Az56ytOgN9/
   pbsGAmVCER5K06utgiGK7DH+iD64wXF6PifQc23xD8sUbpJ3mvi0wl5z7
   Q==;
IronPort-SDR: CSQ/tMQMJG1ZWwntCnRa77eZS07q+zvgBaEZLja5CnczAfWrEt48x27ZbRHs37FFQbMAnljBkL
 zuuyWY0tL0qAScPj4IAepHCNXT+I8oLhUMAhBmy7kgJYbWS+YLjnj0r3pro1Oe5bEi8rVHBa7J
 mSg0/DLFRehoQZb+8znB/xBgkYPQezgfJJLcUU8NsnkvoqhkxM/4WGrdTHgXwJqQcIn7jKaorL
 YeAX/y1FoAPQdpjCp8J/2iqdY4U4oLZHOhbvWcMR8bfm7xjIOBAK10xTa5edBwC1d4ZyosR+vS
 iMY=
X-IronPort-AV: E=Sophos;i="5.75,390,1589266800"; 
   d="scan'208";a="84468734"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Jul 2020 04:14:37 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 24 Jul 2020 04:13:53 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 24 Jul 2020 04:13:54 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: [PATCH v4 3/6] arm64: dts: sparx5: Add SPI controller and associated mmio-mux
Date:   Fri, 24 Jul 2020 13:14:01 +0200
Message-ID: <20200724111404.13293-4-lars.povlsen@microchip.com>
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

This adds a SPI controller to the Microchip Sparx5 SoC, as well as the
mmio-mux that is required to select the right SPI interface for a
given SPI device.

Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 arch/arm64/boot/dts/microchip/sparx5.dtsi | 27 ++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
index 7e811e24f0e99..2169746703dfb 100644
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

