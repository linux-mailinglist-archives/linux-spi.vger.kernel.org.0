Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B920B2120CA
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jul 2020 12:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgGBKOT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Jul 2020 06:14:19 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:29106 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbgGBKOP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 2 Jul 2020 06:14:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1593684854; x=1625220854;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b2ugvk1PicikjR6ydZwpp/7jv6no2O2VLW8Gbo1OcRQ=;
  b=FJA2kGe6JCBWAgP2DFkF6eYLRFDXmE/9NFizK7iXYRK2ijlfuTHl57XK
   Kw1tCoHMmhn34PwXKaNkbIL6qJ9kUWQL5GguPJNo7/k+qQ8u+BhPUlQ3k
   xvKaaR2MLS3F0dXvNvjxHpGf2+d7+fOEzwayFtGT93LNDObq6kwtTHngf
   QaBZe1IjV1MbWhWxhYQhNw3ldheFy/9na2jZNMD9FHIcbll/W36bWur6M
   XbjnQFpoWbPYd4EVJIuvJmLjVeMuwM0WFzZjSy2JyNf/PDQTOl+sNgEsJ
   1M5XMUSgQtMGNv4l6FB6XkEPHrinQXHQZyIE7c6zEQ8a8HS9qMrD6ammU
   A==;
IronPort-SDR: d2V5dIa7z2Erui3Yniq+zNX2vG7Ee3Arao2iGg1o7kqaXM7+Rhqa5rg72q8msIOcNC+DwFx8Nr
 d46HN7alaVlUnIesuS5kVPYK1ddn2qHu7IA1curO4QyuENWhcDUJRfYgOOunHAgjL3x5SPpVr/
 0kzsIWQS8Bvh59gv+NFbNCBWS7BAkhykB9PWJi9wiOa08ykG0g13F2l3GM+uKQsbxCOzlo+Hoq
 ccuv9EI5GkLERvzKvYIfchT564MGV/Xj9y4uG2Dohisy/vGOKpksAkFqLfW+rMpyzA+P7GZ0sA
 axg=
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="78545355"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Jul 2020 03:14:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 2 Jul 2020 03:14:13 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 2 Jul 2020 03:13:51 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: [PATCH v3 2/8] arm64: dts: sparx5: Add SPI controller and SPI mux
Date:   Thu, 2 Jul 2020 12:13:25 +0200
Message-ID: <20200702101331.26375-3-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702101331.26375-1-lars.povlsen@microchip.com>
References: <20200702101331.26375-1-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This adds a SPI controller to the Microchip Sparx5 SoC, as well as the
SPI bus interface mux, which may optionally be needed for selecting
between alternate SPI bus segments (SPI/SPI2).

Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 arch/arm64/boot/dts/microchip/sparx5.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
index 7e811e24f0e99..2831935a489e1 100644
--- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
@@ -14,6 +14,8 @@ / {
 	#size-cells = <1>;
 
 	aliases {
+		mux = &mux;
+		spi0 = &spi0;
 		serial0 = &uart0;
 		serial1 = &uart1;
 	};
@@ -155,6 +157,27 @@ uart1: serial@600102000 {
 			status = "disabled";
 		};
 
+		mux: mux-controller {
+			compatible = "microchip,sparx5-spi-mux";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#mux-control-cells = <0>;
+		};
+
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
+			mux-controls = <&mux>;
+			status = "disabled";
+		};
+
 		timer1: timer@600105000 {
 			compatible = "snps,dw-apb-timer";
 			reg = <0x6 0x00105000 0x1000>;
-- 
2.27.0

