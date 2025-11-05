Return-Path: <linux-spi+bounces-11021-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A541C35268
	for <lists+linux-spi@lfdr.de>; Wed, 05 Nov 2025 11:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC8004E6895
	for <lists+linux-spi@lfdr.de>; Wed,  5 Nov 2025 10:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A423064AC;
	Wed,  5 Nov 2025 10:43:01 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7CF30597D;
	Wed,  5 Nov 2025 10:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762339381; cv=none; b=H7NkyTB3liIjT3Z3/v9YkODhMFpdDdtgLAb/mAjFvE5ORrX3tqEcgKY67GljEM/YRpcXkFHoV8m8x3APCqV7rX3DCWfPh64TESfY+UKmlfiQQSav/Q/NvSqafjQu3Kq8/11yeRRXC1ANejV0eFNVaCjPav3rPNmmq8hI9L+V5Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762339381; c=relaxed/simple;
	bh=Jfax/xSrCc7T5z8buenJ8u4hsU/I9vhXGH9wG/pBm2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BN0u6kQjaQREsn8qmvATMFwoWSJMgIht73Z2GVQnZc7E+8yrbBYZzUyqyIVCyzcxWPR606G8EeT0MPRDqgtXZgwem5SqtxQPEO0zaOi5XAB9ZBccYZ6lS+t/F7REh7eKNzDElqW0fVfzkyGkX9rfFzFN3fPauWqRxYBx08oeIlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: XBYYd2WoTOCsxgE7n0+fTg==
X-CSE-MsgGUID: jzPzJ1ruRdea9F3ONBaXTA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 05 Nov 2025 19:42:57 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.82])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 6356E4009BF6;
	Wed,  5 Nov 2025 19:42:52 +0900 (JST)
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
Subject: [PATCH v3 01/14] clk: renesas: r9a09g077: add SPI module clocks
Date: Wed,  5 Nov 2025 12:41:38 +0200
Message-ID: <20251105104151.1489281-2-cosmin-gabriel.tanislav.xa@renesas.com>
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

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have four SPI
peripherals, each with their own clock divider, which divides PLL4 by
either 24, 25, 30 or 32, similar to the SCI peripheral.

The dividers feed into the usual module clocks.

Add them all.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/clk/renesas/r9a09g077-cpg.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g077-cpg.c b/drivers/clk/renesas/r9a09g077-cpg.c
index 79083165537c..0f61e0f09697 100644
--- a/drivers/clk/renesas/r9a09g077-cpg.c
+++ b/drivers/clk/renesas/r9a09g077-cpg.c
@@ -54,6 +54,11 @@
 #define DIVSCI3ASYNC	CONF_PACK(SCKCR3, 12, 2)
 #define DIVSCI4ASYNC	CONF_PACK(SCKCR3, 14, 2)
 
+#define DIVSPI0ASYNC	CONF_PACK(SCKCR3, 0, 2)
+#define DIVSPI1ASYNC	CONF_PACK(SCKCR3, 2, 2)
+#define DIVSPI2ASYNC	CONF_PACK(SCKCR3, 4, 2)
+#define DIVSPI3ASYNC	CONF_PACK(SCKCR2, 16, 2)
+
 #define SEL_PLL		CONF_PACK(SCKCR, 22, 1)
 
 
@@ -94,6 +99,10 @@ enum clk_ids {
 	CLK_SCI3ASYNC,
 	CLK_SCI4ASYNC,
 	CLK_SCI5ASYNC,
+	CLK_SPI0ASYNC,
+	CLK_SPI1ASYNC,
+	CLK_SPI2ASYNC,
+	CLK_SPI3ASYNC,
 
 	/* Module Clocks */
 	MOD_CLK_BASE,
@@ -154,6 +163,15 @@ static const struct cpg_core_clk r9a09g077_core_clks[] __initconst = {
 	DEF_DIV(".sci5async", CLK_SCI5ASYNC, CLK_PLL4D1, DIVSCI5ASYNC,
 		dtable_24_25_30_32),
 
+	DEF_DIV(".spi0async", CLK_SPI0ASYNC, CLK_PLL4D1, DIVSPI0ASYNC,
+		dtable_24_25_30_32),
+	DEF_DIV(".spi1async", CLK_SPI1ASYNC, CLK_PLL4D1, DIVSPI1ASYNC,
+		dtable_24_25_30_32),
+	DEF_DIV(".spi2async", CLK_SPI2ASYNC, CLK_PLL4D1, DIVSPI2ASYNC,
+		dtable_24_25_30_32),
+	DEF_DIV(".spi3async", CLK_SPI3ASYNC, CLK_PLL4D1, DIVSPI3ASYNC,
+		dtable_24_25_30_32),
+
 	/* Core output clk */
 	DEF_DIV("CA55C0", R9A09G077_CLK_CA55C0, CLK_SEL_CLK_PLL0, DIVCA55C0,
 		dtable_1_2),
@@ -192,6 +210,9 @@ static const struct mssr_mod_clk r9a09g077_mod_clks[] __initconst = {
 	DEF_MOD("sci4fck", 12, CLK_SCI4ASYNC),
 	DEF_MOD("iic0", 100, R9A09G077_CLK_PCLKL),
 	DEF_MOD("iic1", 101, R9A09G077_CLK_PCLKL),
+	DEF_MOD("spi0", 104, CLK_SPI0ASYNC),
+	DEF_MOD("spi1", 105, CLK_SPI1ASYNC),
+	DEF_MOD("spi2", 106, CLK_SPI2ASYNC),
 	DEF_MOD("adc0", 206, R9A09G077_CLK_PCLKH),
 	DEF_MOD("adc1", 207, R9A09G077_CLK_PCLKH),
 	DEF_MOD("adc2", 225, R9A09G077_CLK_PCLKM),
@@ -204,6 +225,7 @@ static const struct mssr_mod_clk r9a09g077_mod_clks[] __initconst = {
 	DEF_MOD("gmac2", 417, R9A09G077_CLK_PCLKAM),
 	DEF_MOD("sci5fck", 600, CLK_SCI5ASYNC),
 	DEF_MOD("iic2", 601, R9A09G077_CLK_PCLKL),
+	DEF_MOD("spi3", 602, CLK_SPI3ASYNC),
 	DEF_MOD("sdhi0", 1212, R9A09G077_CLK_PCLKAM),
 	DEF_MOD("sdhi1", 1213, R9A09G077_CLK_PCLKAM),
 };
-- 
2.51.2


