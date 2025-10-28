Return-Path: <linux-spi+bounces-10889-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA295C14F06
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 14:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 687C84F82FB
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 13:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4B133A037;
	Tue, 28 Oct 2025 13:34:01 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE0133B945;
	Tue, 28 Oct 2025 13:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761658441; cv=none; b=AlN8j4aNk/EXi30QSWH8xHUKcuXNXlC3mZ90cYk7pQycnT/WvxU4fS6S3PzLbHMhzRcCcr6SJEiFPLF6OpsgZ3UjTleDPStvxhYjO81m7MghJ+dtodxAq6C3SCV0rz98s4juun5/DsLHPMPCDZIs1s6ZBQU7vmEbyYPrHLIHhRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761658441; c=relaxed/simple;
	bh=46kurnI7CCGMHD/kJRlqWTL8CfwS/5tIFegT3nkN8C0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jxktXRO+F17mW+DenQ+ki1WoPzY1Gnv1MN8E97PSRHNYDzENNwnOLbci3ifd20/pSNOzBVWx1j+FCLboFHj3NuGsJeLo23CEtyXoGApi9lHg02kuFEowk7vPNfzKJLznRxIXQCa9KESldmIqtmtPkbVZ5SlAE9NcV1xIUCIKRYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: i+04+UgQRFSEl7VOiztTIw==
X-CSE-MsgGUID: +MwJcM6HSr+ReBNZDTp0cA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 28 Oct 2025 22:33:57 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.5])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id EF08841B5F49;
	Tue, 28 Oct 2025 22:33:52 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: 
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-spi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH 14/14] arm64: dts: renesas: r9a09g087: Add SPIs support
Date: Tue, 28 Oct 2025 15:31:45 +0200
Message-ID: <20251028133151.1487327-15-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251028133151.1487327-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251028133151.1487327-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the four SPI peripherals on the Renesas RZ/N2H Soc.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi | 72 ++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
index db117b6f75a1..a19349dc8e53 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
@@ -188,6 +188,78 @@ sci5: serial@81005000 {
 			status = "disabled";
 		};
 
+		rspi0: spi@80007000 {
+			compatible = "renesas,r9a09g087-rspi", "renesas,r9a09g077-rspi";
+			reg = <0x0 0x80007000 0x0 0x400>;
+			interrupts = <GIC_SPI 636 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 637 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 638 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 634 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 635 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "idle", "error", "end", "rx", "tx";
+			clocks = <&cpg CPG_CORE R9A09G087_CLK_PCLKM>,
+				 <&cpg CPG_MOD 104>;
+			clock-names = "pclk", "pclkspi";
+			power-domains = <&cpg>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		rspi1: spi@80007400 {
+			compatible = "renesas,r9a09g087-rspi", "renesas,r9a09g077-rspi";
+			reg = <0x0 0x80007400 0x0 0x400>;
+			interrupts = <GIC_SPI 641 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 642 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 643 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 639 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 640 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "idle", "error", "end", "rx", "tx";
+			clocks = <&cpg CPG_CORE R9A09G087_CLK_PCLKM>,
+				 <&cpg CPG_MOD 105>;
+			clock-names = "pclk", "pclkspi";
+			power-domains = <&cpg>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		rspi2: spi@80007800 {
+			compatible = "renesas,r9a09g087-rspi", "renesas,r9a09g077-rspi";
+			reg = <0x0 0x80007800 0x0 0x400>;
+			interrupts = <GIC_SPI 646 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 647 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 648 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 644 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 645 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "idle", "error", "end", "rx", "tx";
+			clocks = <&cpg CPG_CORE R9A09G087_CLK_PCLKM>,
+				 <&cpg CPG_MOD 106>;
+			clock-names = "pclk", "pclkspi";
+			power-domains = <&cpg>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		rspi3: spi@81007000 {
+			compatible = "renesas,r9a09g087-rspi", "renesas,r9a09g077-rspi";
+			reg = <0x0 0x81007000 0x0 0x400>;
+			interrupts = <GIC_SPI 651 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 652 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 653 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 649 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 650 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "idle", "error", "end", "rx", "tx";
+			clocks = <&cpg CPG_CORE R9A09G087_CLK_PCLKM>,
+				 <&cpg CPG_MOD 602>;
+			clock-names = "pclk", "pclkspi";
+			power-domains = <&cpg>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		wdt0: watchdog@80082000 {
 			compatible = "renesas,r9a09g087-wdt", "renesas,r9a09g077-wdt";
 			reg = <0 0x80082000 0 0x400>,
-- 
2.51.1


