Return-Path: <linux-spi+bounces-11034-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A55B3C35376
	for <lists+linux-spi@lfdr.de>; Wed, 05 Nov 2025 11:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87D966201BA
	for <lists+linux-spi@lfdr.de>; Wed,  5 Nov 2025 10:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F0130C603;
	Wed,  5 Nov 2025 10:44:19 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E21D309DA5;
	Wed,  5 Nov 2025 10:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762339459; cv=none; b=NFDCaYKc6PyaMWObaP9cveqj3ZkDkzxr4YTv4NEFwf8VGdY3XOIGmhDtGVaqgJfbmZRLRLvfY/+z3KUbFX31Z0PusFzpRIe6srjim352sHmuJ5y+dHdxxCDTpJ1Sz9kAPcrA/RNzVqg+1/XbpUnC5SzI1SvD4ZdTHpMq7D/74xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762339459; c=relaxed/simple;
	bh=NV+kxczdklyaqUqzxTzGJ5qDBsNZChgauWrrrIEhPwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uvwg9Z2M6WiL33QVjTovXVFX2fFCjZX0X7NNsMwj/kgLeF9sNB6cNL5+YgOsQCtFbibyzzGr9VzzsosiFRs4oqYy/q7VisAa1+qkmBFWh3CNEgPwSMVZdS5cba94/uIvB0QWLHEgXWraIm3HjGzxPnt4xRWcwoGggNe6OBih2n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: S6j4jrq4Q/C3x58KVLsbWQ==
X-CSE-MsgGUID: RAbtu4jCTvaI0IxR15qZbg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 05 Nov 2025 19:44:16 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.82])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0375A4001DCB;
	Wed,  5 Nov 2025 19:44:11 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-spi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v3 14/14] arm64: dts: renesas: r9a09g087: Add SPIs support
Date: Wed,  5 Nov 2025 12:41:51 +0200
Message-ID: <20251105104151.1489281-15-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251105104151.1489281-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251105104151.1489281-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the four SPI peripherals on the Renesas RZ/N2H Soc.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
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
2.51.2


