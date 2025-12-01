Return-Path: <linux-spi+bounces-11693-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC0EC97B4F
	for <lists+linux-spi@lfdr.de>; Mon, 01 Dec 2025 14:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D7A3C34728D
	for <lists+linux-spi@lfdr.de>; Mon,  1 Dec 2025 13:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBD331ED68;
	Mon,  1 Dec 2025 13:44:32 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA7C31CA7F;
	Mon,  1 Dec 2025 13:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764596671; cv=none; b=QqRAzT8q/vGrb4kH+q6ngvflg5fXY1YkXmsytqPmaHVITwc3onPlvtq7+wpihh1CaLXxONcl+zny5ojlEPIBJZnxK1PmcXyoPUIWP2V3nvFsPcKA0pKuY2hTu6i7Y6Yb1AuDLnlkfSK1XnKwbUF8Vwz5EmjXf14IbUj2M77bqtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764596671; c=relaxed/simple;
	bh=K+8Imq08PBFg0FzfxwvlVR/iIDNvODdGNxCaD6X3rLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j8k3Xwhdo2WLs5/POXAJdRV6GyZDKBWDH0948Q6m6d/Ps4bPzx618IISUG8KDVid/wbm+HBCoukJVOFaHSef0Br5wRnHzk+XdcZxSe2AmMIgJQt+POQyXVAKU6uMvHPkAqt3EFx5Jyg3qxirEavqlDe4xiFY7aa2u8gpEDmdXTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: P8X0AJUbSj6a33fC+MQIuw==
X-CSE-MsgGUID: iMQSsI9HS7ij2WRf2z0UOw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Dec 2025 22:44:28 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.83])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A71544215A56;
	Mon,  1 Dec 2025 22:44:24 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-spi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH 13/13] arm64: dts: renesas: r9a09g087: wire up DMA support for SPI
Date: Mon,  1 Dec 2025 15:42:29 +0200
Message-ID: <20251201134229.600817-14-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251201134229.600817-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251201134229.600817-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RZ/N2H (R9A09G087) has three DMA controllers that can be used by
peripherals like SPI to offload data transfers from the CPU.

Wire up the DMA channels for the SPI peripherals.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
index 7b1f2c1c9e85..61c1b3713b43 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
@@ -200,6 +200,8 @@ rspi0: spi@80007000 {
 			clocks = <&cpg CPG_CORE R9A09G087_CLK_PCLKM>,
 				 <&cpg CPG_MOD 104>;
 			clock-names = "pclk", "pclkspi";
+			dmas = <&dmac0 0x267a>, <&dmac0 0x267b>;
+			dma-names = "rx", "tx";
 			power-domains = <&cpg>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -218,6 +220,8 @@ rspi1: spi@80007400 {
 			clocks = <&cpg CPG_CORE R9A09G087_CLK_PCLKM>,
 				 <&cpg CPG_MOD 105>;
 			clock-names = "pclk", "pclkspi";
+			dmas = <&dmac0 0x267f>, <&dmac0 0x2680>;
+			dma-names = "rx", "tx";
 			power-domains = <&cpg>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -236,6 +240,8 @@ rspi2: spi@80007800 {
 			clocks = <&cpg CPG_CORE R9A09G087_CLK_PCLKM>,
 				 <&cpg CPG_MOD 106>;
 			clock-names = "pclk", "pclkspi";
+			dmas = <&dmac0 0x2684>, <&dmac0 0x2685>;
+			dma-names = "rx", "tx";
 			power-domains = <&cpg>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -254,6 +260,8 @@ rspi3: spi@81007000 {
 			clocks = <&cpg CPG_CORE R9A09G087_CLK_PCLKM>,
 				 <&cpg CPG_MOD 602>;
 			clock-names = "pclk", "pclkspi";
+			dmas = <&dmac0 0x2689>, <&dmac0 0x268a>;
+			dma-names = "rx", "tx";
 			power-domains = <&cpg>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.52.0


