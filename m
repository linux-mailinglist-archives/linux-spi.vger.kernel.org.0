Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686C7242BD7
	for <lists+linux-spi@lfdr.de>; Wed, 12 Aug 2020 17:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgHLPCa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 12 Aug 2020 11:02:30 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:41770 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726488AbgHLPC3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 12 Aug 2020 11:02:29 -0400
X-IronPort-AV: E=Sophos;i="5.76,304,1592838000"; 
   d="scan'208";a="54233369"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 13 Aug 2020 00:02:28 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id AD201400492E;
        Thu, 13 Aug 2020 00:02:25 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>
Subject: [PATCH 2/2] ARM: dts: r8a7742: Add QSPI support
Date:   Wed, 12 Aug 2020 16:00:48 +0100
Message-Id: <20200812150048.27721-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200812150048.27721-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20200812150048.27721-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add QSPI DT node to R8A7742 SoC dtsi.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
---
 arch/arm/boot/dts/r8a7742.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7742.dtsi b/arch/arm/boot/dts/r8a7742.dtsi
index 5070e2a87231..009827708bf4 100644
--- a/arch/arm/boot/dts/r8a7742.dtsi
+++ b/arch/arm/boot/dts/r8a7742.dtsi
@@ -701,6 +701,22 @@
 			status = "disabled";
 		};
 
+		qspi: spi@e6b10000 {
+			compatible = "renesas,qspi-r8a7742", "renesas,qspi";
+			reg = <0 0xe6b10000 0 0x2c>;
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 917>;
+			dmas = <&dmac0 0x17>, <&dmac0 0x18>,
+			       <&dmac1 0x17>, <&dmac1 0x18>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7742_PD_ALWAYS_ON>;
+			resets = <&cpg 917>;
+			num-cs = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		scifa0: serial@e6c40000 {
 			compatible = "renesas,scifa-r8a7742",
 				     "renesas,rcar-gen2-scifa", "renesas,scifa";
-- 
2.17.1

