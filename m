Return-Path: <linux-spi+bounces-11027-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287B3C35301
	for <lists+linux-spi@lfdr.de>; Wed, 05 Nov 2025 11:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0731565CB0
	for <lists+linux-spi@lfdr.de>; Wed,  5 Nov 2025 10:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E70F309DBD;
	Wed,  5 Nov 2025 10:43:36 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B01307AE3;
	Wed,  5 Nov 2025 10:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762339415; cv=none; b=Zk66h7KRLVXPG2uNmVkuMiTrr/DofbK1MU+KHj+tsczek9t77JgyLX9cGihM7az8hX7p7vpbOYKgn+RBAp22bxL/ySictUYwB72OUZejBg3terJrG/hODDfCMRk1SKB5eaWwoLPlyqfAlWPTbMYZZssoKyQo4MEP1/8CQ5Pe8uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762339415; c=relaxed/simple;
	bh=tGxHwADi5ufjYK4AqVUI1K6k1hsgUmIJgmE9xlatDSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bC1z6sAg6WfydKznMZHGfmfVS9cZEgZ0qmoWKjLw1EDMOBOW+KBhk803FWY6iMEhQv/mO6flASGmRdhqUBoW+fvS3YV1fgnckzkpF55grnATqjrt3++jHe9SPSucI4X4qrBEamJL9w3qcqXv7frJkvkXn2CLfyZiAK+m/Lt+4uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: XeCu1/GCRPqy5abtrZwxlQ==
X-CSE-MsgGUID: 7PMRG9SSTseuKuAGAwuNkw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 05 Nov 2025 19:43:32 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.82])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id EBDF64001DCB;
	Wed,  5 Nov 2025 19:43:27 +0900 (JST)
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
Subject: [PATCH v3 07/14] spi: rzv2h-rspi: make transfer clock rate finding chip-specific
Date: Wed,  5 Nov 2025 12:41:44 +0200
Message-ID: <20251105104151.1489281-8-cosmin-gabriel.tanislav.xa@renesas.com>
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

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have a more
complicated clocking setup for the SPI transfer clock than RZ/V2H, as
the clock from which it is generated supports multiple dividers.

To prepare for adding support for these SoCs, split out the logic for
finding the SPR and BRDV for a fixed clock into
rzv2h_rspi_find_rate_fixed(), and add and use a .find_tclk_rate()
callback into the chip-specific structure.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 62 ++++++++++++++++++++++++++++++------
 1 file changed, 53 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index d7719f3c7b13..f59bcadf5e38 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -67,7 +67,18 @@
 
 #define RSPI_RESET_NUM		2
 
+struct rzv2h_rspi_best_clock {
+	struct clk *clk;
+	unsigned long clk_rate;
+	unsigned long error;
+	u32 actual_hz;
+	u8 brdv;
+	u8 spr;
+};
+
 struct rzv2h_rspi_info {
+	void (*find_tclk_rate)(struct clk *clk, u32 hz, u8 spr_min, u8 spr_max,
+			       struct rzv2h_rspi_best_clock *best_clk);
 	const char *tclk_name;
 	unsigned int fifo_size;
 	unsigned int num_clks;
@@ -240,9 +251,13 @@ static inline u32 rzv2h_rspi_calc_bitrate(unsigned long tclk_rate, u8 spr,
 	return DIV_ROUND_UP(tclk_rate, (2 * (spr + 1) * (1 << brdv)));
 }
 
-static u32 rzv2h_rspi_setup_clock(struct rzv2h_rspi_priv *rspi, u32 hz)
+static void rzv2h_rspi_find_rate_fixed(struct clk *clk, u32 hz,
+				       u8 spr_min, u8 spr_max,
+				       struct rzv2h_rspi_best_clock *best)
 {
-	unsigned long tclk_rate;
+	unsigned long clk_rate;
+	unsigned long error;
+	u32 actual_hz;
 	int spr;
 	u8 brdv;
 
@@ -255,21 +270,49 @@ static u32 rzv2h_rspi_setup_clock(struct rzv2h_rspi_priv *rspi, u32 hz)
 	 * * n = SPR - is RSPI_SPBR.SPR (from 0 to 255)
 	 * * N = BRDV - is RSPI_SPCMD.BRDV (from 0 to 3)
 	 */
-	tclk_rate = clk_get_rate(rspi->tclk);
+	clk_rate = clk_get_rate(clk);
 	for (brdv = RSPI_SPCMD_BRDV_MIN; brdv <= RSPI_SPCMD_BRDV_MAX; brdv++) {
-		spr = DIV_ROUND_UP(tclk_rate, hz * (1 << (brdv + 1)));
+		spr = DIV_ROUND_UP(clk_rate, hz * (1 << (brdv + 1)));
 		spr--;
-		if (spr >= RSPI_SPBR_SPR_MIN && spr <= RSPI_SPBR_SPR_MAX)
+		if (spr >= spr_min && spr <= spr_max)
 			goto clock_found;
 	}
 
-	return 0;
+	return;
 
 clock_found:
-	rspi->spr = spr;
-	rspi->brdv = brdv;
+	actual_hz = rzv2h_rspi_calc_bitrate(clk_rate, spr, brdv);
+	error = abs((long)hz - (long)actual_hz);
 
-	return rzv2h_rspi_calc_bitrate(tclk_rate, spr, brdv);
+	if (error >= best->error)
+		return;
+
+	*best = (struct rzv2h_rspi_best_clock) {
+		.clk = clk,
+		.clk_rate = clk_rate,
+		.error = error,
+		.actual_hz = actual_hz,
+		.brdv = brdv,
+		.spr = spr,
+	};
+}
+
+static u32 rzv2h_rspi_setup_clock(struct rzv2h_rspi_priv *rspi, u32 hz)
+{
+	struct rzv2h_rspi_best_clock best_clock = {
+		.error = ULONG_MAX,
+	};
+
+	rspi->info->find_tclk_rate(rspi->tclk, hz, RSPI_SPBR_SPR_MIN,
+				   RSPI_SPBR_SPR_MAX, &best_clock);
+
+	if (!best_clock.clk_rate)
+		return -EINVAL;
+
+	rspi->spr = best_clock.spr;
+	rspi->brdv = best_clock.brdv;
+
+	return best_clock.actual_hz;
 }
 
 static int rzv2h_rspi_prepare_message(struct spi_controller *ctlr,
@@ -463,6 +506,7 @@ static void rzv2h_rspi_remove(struct platform_device *pdev)
 }
 
 static const struct rzv2h_rspi_info rzv2h_info = {
+	.find_tclk_rate = rzv2h_rspi_find_rate_fixed,
 	.tclk_name = "tclk",
 	.fifo_size = 16,
 	.num_clks = 3,
-- 
2.51.2


