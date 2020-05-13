Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6471D16CC
	for <lists+linux-spi@lfdr.de>; Wed, 13 May 2020 16:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388857AbgEMOBP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 May 2020 10:01:15 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:62384 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388827AbgEMOBB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 May 2020 10:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589378461; x=1620914461;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h6UFiTnJ9Oy1iMZ7I4rcTXbTcxTZni/KOI6fPLd+AIw=;
  b=17H8mw1AbM2U91zCQfqqLRcSdF8AOmxqMk/+5PUZJtIO14GgyBQsuMPr
   yEsbtYB4KVhCu09nonN/ukwQ3/gCaq1owMGHWRZ+72GW3pHkq2LsgzuOi
   mAGgUmKbBGa4UKixQgWmux9z+fvGF0+E/JaEa2i/KBdXBdwWCfnU/YyWN
   3mYk6LP03Di/v9/sIi+9uB2KYww1hHcZBPzFV98WNiNFELdSbEw4EgPCP
   Ch1CKP2DFwCMF5Awj5iuqdIk40GsTf8cv8IoqEjnoEBLfGot+l9MA7/fj
   dxee79VYAPkSYB+VgZWIr+dokyvSzz+0JU2Up3LXiK6a2IBlBi36yI45x
   Q==;
IronPort-SDR: HlVp/bUx3COZt5b24MB17cfUBlsg6OMd4kyzmGGBsHpcfAfTtdUWijiQPq4u+fV1GkIjiW8QgC
 2CAEzYO40CJIywFrL7DLUUaFH+QQUjXeGUs88+XDZg53jCGuWx/NU+t/a30jA4CUEUFD+YzblD
 7bm67KgFkoyd2FWPqQfoC5R7eiX/LdturQ9Zz+7xrjZAfhvOseiv20nVQt/lwIG6IKYlYBWOb2
 zHSXeRfLaDP4x4eJ70UgXsHXgk9rdsahLpuTXvPUlwLQPa+tKC+TYiSu3jEioLYlruhfoVyxlx
 X0w=
X-IronPort-AV: E=Sophos;i="5.73,388,1583218800"; 
   d="scan'208";a="75774926"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2020 07:01:00 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 May 2020 07:01:02 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Wed, 13 May 2020 07:00:57 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Mark Brown <broonie@kernel.org>, SoC Team <soc@kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 08/10] arm64: dts: sparx5: Add SPI controller
Date:   Wed, 13 May 2020 16:00:29 +0200
Message-ID: <20200513140031.25633-9-lars.povlsen@microchip.com>
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

This adds a SPI controller to the Microchip Sparx5 SoC

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 arch/arm64/boot/dts/microchip/sparx5.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
index b5f2d088af30e..daa216978887d 100644
--- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
@@ -14,6 +14,7 @@ / {
 	#size-cells = <1>;

 	aliases {
+		spi0 = &spi0;
 		serial0 = &uart0;
 		serial1 = &uart1;
 	};
@@ -144,6 +145,21 @@ uart1: serial@600102000 {
 			status = "disabled";
 		};

+		spi0: spi@600104000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "microchip,sparx5-spi";
+			reg = <0x6 0x00104000 0x40>, <0 0 0>,
+			      <0x3 0x0 0x4000000>;
+			num-cs = <16>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			clocks = <&ahb_clk>;
+			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+
+			status = "disabled";
+		};
+
 		timer1: timer@600105000 {
 			compatible = "snps,dw-apb-timer";
 			reg = <0x6 0x00105000 0x1000>;
--
2.26.2
