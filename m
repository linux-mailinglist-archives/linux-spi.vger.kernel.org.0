Return-Path: <linux-spi+bounces-11033-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B7464C352D1
	for <lists+linux-spi@lfdr.de>; Wed, 05 Nov 2025 11:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 62C2334E749
	for <lists+linux-spi@lfdr.de>; Wed,  5 Nov 2025 10:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575CC30C372;
	Wed,  5 Nov 2025 10:44:14 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF562E719C;
	Wed,  5 Nov 2025 10:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762339454; cv=none; b=WpcwoWISGgQBgsAXXSt93Tc72unR4n0HAryyuD3zrsASCBRDpoWnOi75deyySyF4ttqYIbBq7Gj42MwOy+0HAAGA3fUgB6fdWs2ZpCg+HunSEaTbN2Mtek/762sg+YMW++wi/KbHlrFgciR0BWe2fZgYX2oNffA8n0jXcq42Jco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762339454; c=relaxed/simple;
	bh=tBjA49CSDouU1uDonXijZN6NFUB98dzsK+ZrAwUJl5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IcbJ8xt3fka8eF9/Bn8BXN2+TRfjGcG2ua8sVW+bPEfev7oaS7kXrDCyb6GBa7weRIp7Tlh+xrnIFGcytb6zeAgXpTws8Wz8xnbfBC/e0RxEHVZhwbEjEJToaouIOPnmSuEwA6WtVyPW5EBG6uokr/6Bq+QVqkZgUhN0ojWt6XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: 3GH/2N99QFKOzi5fiZRfqw==
X-CSE-MsgGUID: cpopKykpQoCNvfV9Lm4pzQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 05 Nov 2025 19:44:10 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.82])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id EE0CB4001DCB;
	Wed,  5 Nov 2025 19:44:05 +0900 (JST)
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
Subject: [PATCH v3 13/14] arm64: dts: renesas: r9a09g077: Add SPIs support
Date: Wed,  5 Nov 2025 12:41:50 +0200
Message-ID: <20251105104151.1489281-14-cosmin-gabriel.tanislav.xa@renesas.com>
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

Add support for the four SPI peripherals on the Renesas RZ/T2H Soc.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi | 72 ++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
index 42ee9f299837..4f0315235050 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
@@ -188,6 +188,78 @@ sci5: serial@81005000 {
 			status = "disabled";
 		};
 
+		rspi0: spi@80007000 {
+			compatible = "renesas,r9a09g077-rspi";
+			reg = <0x0 0x80007000 0x0 0x400>;
+			interrupts = <GIC_SPI 636 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 637 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 638 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 634 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 635 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "idle", "error", "end", "rx", "tx";
+			clocks = <&cpg CPG_CORE R9A09G077_CLK_PCLKM>,
+				 <&cpg CPG_MOD 104>;
+			clock-names = "pclk", "pclkspi";
+			power-domains = <&cpg>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		rspi1: spi@80007400 {
+			compatible = "renesas,r9a09g077-rspi";
+			reg = <0x0 0x80007400 0x0 0x400>;
+			interrupts = <GIC_SPI 641 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 642 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 643 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 639 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 640 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "idle", "error", "end", "rx", "tx";
+			clocks = <&cpg CPG_CORE R9A09G077_CLK_PCLKM>,
+				 <&cpg CPG_MOD 105>;
+			clock-names = "pclk", "pclkspi";
+			power-domains = <&cpg>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		rspi2: spi@80007800 {
+			compatible = "renesas,r9a09g077-rspi";
+			reg = <0x0 0x80007800 0x0 0x400>;
+			interrupts = <GIC_SPI 646 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 647 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 648 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 644 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 645 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "idle", "error", "end", "rx", "tx";
+			clocks = <&cpg CPG_CORE R9A09G077_CLK_PCLKM>,
+				 <&cpg CPG_MOD 106>;
+			clock-names = "pclk", "pclkspi";
+			power-domains = <&cpg>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		rspi3: spi@81007000 {
+			compatible = "renesas,r9a09g077-rspi";
+			reg = <0x0 0x81007000 0x0 0x400>;
+			interrupts = <GIC_SPI 651 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 652 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 653 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 649 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 650 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "idle", "error", "end", "rx", "tx";
+			clocks = <&cpg CPG_CORE R9A09G077_CLK_PCLKM>,
+				 <&cpg CPG_MOD 602>;
+			clock-names = "pclk", "pclkspi";
+			power-domains = <&cpg>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		wdt0: watchdog@80082000 {
 			compatible = "renesas,r9a09g077-wdt";
 			reg = <0 0x80082000 0 0x400>,
-- 
2.51.2


