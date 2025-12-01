Return-Path: <linux-spi+bounces-11692-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C3EC97B25
	for <lists+linux-spi@lfdr.de>; Mon, 01 Dec 2025 14:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF08F3A5248
	for <lists+linux-spi@lfdr.de>; Mon,  1 Dec 2025 13:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FA131CA68;
	Mon,  1 Dec 2025 13:44:29 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402D73148A0;
	Mon,  1 Dec 2025 13:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764596668; cv=none; b=TIHU3MsLZ8NyK/OLplstxBQ/o/BnhamGhc1F4vw0dt2N/CJ2RY8OLDmTVK7AjXUTT2hPUbQmRKxXkx2RmGLY3tQ75CoDIe9ijdYShi9sVpUvEjENKBCwi9/fiClHsEkRXVOyBlUzprmu7n+yqZDzlJbZDXajQ1oJz7PL8r1uf5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764596668; c=relaxed/simple;
	bh=964hwEdCFr/GEQ6EzREk+fNU7494aZepv8A03AsYutk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LaXwYiKyblfVLTVwpNf1gpiE61O3o69fdjKbU2qHvcoCkXVpeqNI3TwMavh3w9WI4SELfxlic75kU74FI6aOvMHLSwDTS700/wGzN8BgTAx39r1YtSKQcjdWZdtQwhvJRtounudCvNv4b8itHQMDtpAHxOFVyzC0x3zFUNWBqO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: K73JxEYxSTiKIOeiyRbcQw==
X-CSE-MsgGUID: 4A8qX2/oRGmW2ax0ORGO5Q==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Dec 2025 22:44:23 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.83])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 815CE4215A4E;
	Mon,  1 Dec 2025 22:44:19 +0900 (JST)
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
Subject: [PATCH 12/13] arm64: dts: renesas: r9a09g077: wire up DMA support for SPI
Date: Mon,  1 Dec 2025 15:42:28 +0200
Message-ID: <20251201134229.600817-13-cosmin-gabriel.tanislav.xa@renesas.com>
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

RZ/T2H (R9A09G077) has three DMA controllers that can be used by
peripherals like SPI to offload data transfers from the CPU.

Wire up the DMA channels for the SPI peripherals.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
index ee11efb68638..34f5a4d26f29 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
@@ -200,6 +200,8 @@ rspi0: spi@80007000 {
 			clocks = <&cpg CPG_CORE R9A09G077_CLK_PCLKM>,
 				 <&cpg CPG_MOD 104>;
 			clock-names = "pclk", "pclkspi";
+			dmas = <&dmac0 0x267a>, <&dmac0 0x267b>;
+			dma-names = "rx", "tx";
 			power-domains = <&cpg>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -218,6 +220,8 @@ rspi1: spi@80007400 {
 			clocks = <&cpg CPG_CORE R9A09G077_CLK_PCLKM>,
 				 <&cpg CPG_MOD 105>;
 			clock-names = "pclk", "pclkspi";
+			dmas = <&dmac0 0x267f>, <&dmac0 0x2680>;
+			dma-names = "rx", "tx";
 			power-domains = <&cpg>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -236,6 +240,8 @@ rspi2: spi@80007800 {
 			clocks = <&cpg CPG_CORE R9A09G077_CLK_PCLKM>,
 				 <&cpg CPG_MOD 106>;
 			clock-names = "pclk", "pclkspi";
+			dmas = <&dmac0 0x2684>, <&dmac0 0x2685>;
+			dma-names = "rx", "tx";
 			power-domains = <&cpg>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -254,6 +260,8 @@ rspi3: spi@81007000 {
 			clocks = <&cpg CPG_CORE R9A09G077_CLK_PCLKM>,
 				 <&cpg CPG_MOD 602>;
 			clock-names = "pclk", "pclkspi";
+			dmas = <&dmac0 0x2689>, <&dmac0 0x268a>;
+			dma-names = "rx", "tx";
 			power-domains = <&cpg>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.52.0


