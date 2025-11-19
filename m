Return-Path: <linux-spi+bounces-11345-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A434C7025C
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 17:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB3A74FB17C
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 16:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79806349B0F;
	Wed, 19 Nov 2025 16:16:22 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC71369226;
	Wed, 19 Nov 2025 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763568982; cv=none; b=RcvIGQokh5uH9tkjdx8QkuA0n7PcQbfnvw6DwHfnekjt/UrHJQFrdcwjW2ZMAo2LgGVViaY4rusbshdaSb+S3ek1o0Oc5MTWoJdYD6Lm4DYgD28fQOQQh/j69DhuA1xQnHFG0fAHX0RUvAZ8fGfCAl5q1gTaVXuKzg8eVgt5fck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763568982; c=relaxed/simple;
	bh=+bkI7gC2xjmvT/FtpJndpZjYhsrSMOwIhsBIzupWDUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGpIjiN4CkA8roiRUmYDx0bbcR3YQc96ef5TlajMThNRID+UoNpNF6pw6cCL3QtXDboMPZWpT8uNzAc89tpclmp5nhvEjZ8dpePQYXdI9RY0LWXnI6Zfm+0js5u6Mb1YOaQZuq8wAH0OWfw63Gi8Kj3ggh+7w/0LzPYhO6MUEy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: dZ7DDuMSQ9yNO0/oKebrtA==
X-CSE-MsgGUID: ccz9+VicRvGcoWn+fuom3Q==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 20 Nov 2025 01:16:19 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.87])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 008FC406C471;
	Thu, 20 Nov 2025 01:16:14 +0900 (JST)
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
Subject: [PATCH v4 11/13] spi: rzv2h-rspi: add support for RZ/T2H and RZ/N2H
Date: Wed, 19 Nov 2025 18:14:32 +0200
Message-ID: <20251119161434.595677-12-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251119161434.595677-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251119161434.595677-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compared to the previously supported RZ/V2H, the Renesas RZ/T2H
(R9A09G077) and RZ/N2H (R9A09G087) SoCs have a smaller FIFO, no resets,
and only two clocks: PCLKSPIn and PCLK. PCLKSPIn, being the clock from
which the SPI transfer clock is generated, is the equivalent of the TCLK
clock from RZ/V2H. They also support generating the SPI transfer clock
from PCLK.

PCLKSPIn supports multiple dividers, generating multiple possible
frequencies from its parent. To handle this, do the following changes.

Use the minimum frequency of SPI clock to calculate the SPI controller's
min_speed_hz, and the maximum frequency to calculate max_speed_hz.

Add a new function, rzv2h_rspi_find_rate_variable(), which is used for
the .find_tclk_rate() callback, and which supports handling clocks with
a variable rate, with the following overall logic.

Iterate through all possible BRDV values.

For each BRDV, calculate two different SPRs, one for the clock's minimum
frequency, and one for the maxmimum, and iterate through each SPR
between them.

If the minimum SPR is higher than the upper SPR limit, the minimum rate
is too high to achieve the requested SPI frequency, skip to the next
BRDV.

For each SPR, calculate a rate and let the clock framework round it to
the closest supported rate of the clock.

The rate and SPR that generate a transfer frequency closest to the
requested SPI transfer frequency will be picked.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V4:
 * no changes

V3:
 * no changes

V2:
 * no changes

 drivers/spi/spi-rzv2h-rspi.c | 108 +++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index da110efba971..1db7e4e5d64e 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -261,6 +261,105 @@ static inline u32 rzv2h_rspi_calc_bitrate(unsigned long tclk_rate, u8 spr,
 	return DIV_ROUND_UP(tclk_rate, (2 * (spr + 1) * (1 << brdv)));
 }
 
+static void rzv2h_rspi_find_rate_variable(struct clk *clk, u32 hz,
+					  u8 spr_min, u8 spr_max,
+					  struct rzv2h_rspi_best_clock *best)
+{
+	long clk_rate, clk_min_rate, clk_max_rate;
+	int min_rate_spr, max_rate_spr;
+	unsigned long error;
+	u32 actual_hz;
+	u8 brdv;
+	int spr;
+
+	/*
+	 * On T2H / N2H, the source for the SPI clock is PCLKSPIn, which is a
+	 * 1/32, 1/30, 1/25 or 1/24 divider of PLL4, which is 2400MHz,
+	 * resulting in either 75MHz, 80MHz, 96MHz or 100MHz.
+	 */
+	clk_min_rate = clk_round_rate(clk, 0);
+	if (clk_min_rate < 0)
+		return;
+
+	clk_max_rate = clk_round_rate(clk, ULONG_MAX);
+	if (clk_max_rate < 0)
+		return;
+
+	/*
+	 * From the manual:
+	 * Bit rate = f(PCLKSPIn) / (2 * (n + 1) * 2^N)
+	 *
+	 * If we adapt it to the current context, we get the following:
+	 * hz = rate / ((spr + 1) * (1 << (brdv + 1)))
+	 *
+	 * This can be written in multiple forms depending on what we want to
+	 * determine.
+	 *
+	 * To find the rate, having hz, spr and brdv:
+	 * rate = hz * (spr + 1) * (1 << (brdv + 1)
+	 *
+	 * To find the spr, having rate, hz, and spr:
+	 * spr = rate / (hz * (1 << (brdv + 1)) - 1
+	 */
+
+	for (brdv = RSPI_SPCMD_BRDV_MIN; brdv <= RSPI_SPCMD_BRDV_MAX; brdv++) {
+		/* Calculate the divisor needed to find the SPR from a rate. */
+		u32 rate_div = hz * (1 << (brdv + 1));
+
+		/*
+		 * If the SPR for the minimum rate is greater than the maximum
+		 * allowed value skip this BRDV. The divisor increases with each
+		 * BRDV iteration, so the following BRDV might result in a
+		 * minimum SPR that is in the valid range.
+		 */
+		min_rate_spr = DIV_ROUND_CLOSEST(clk_min_rate, rate_div) - 1;
+		if (min_rate_spr > spr_max)
+			continue;
+
+		/*
+		 * If the SPR for the maximum rate is less than the minimum
+		 * allowed value, exit. The divisor only increases with each
+		 * BRDV iteration, so the following BRDV cannot result in a
+		 * maximum SPR that is in the valid range.
+		 */
+		max_rate_spr = DIV_ROUND_CLOSEST(clk_max_rate, rate_div) - 1;
+		if (max_rate_spr < spr_min)
+			break;
+
+		if (min_rate_spr < spr_min)
+			min_rate_spr = spr_min;
+
+		if (max_rate_spr > spr_max)
+			max_rate_spr = spr_max;
+
+		for (spr = min_rate_spr; spr <= max_rate_spr; spr++) {
+			clk_rate = (spr + 1) * rate_div;
+
+			clk_rate = clk_round_rate(clk, clk_rate);
+			if (clk_rate <= 0)
+				continue;
+
+			actual_hz = rzv2h_rspi_calc_bitrate(clk_rate, spr, brdv);
+			error = abs((long)hz - (long)actual_hz);
+
+			if (error >= best->error)
+				continue;
+
+			*best = (struct rzv2h_rspi_best_clock) {
+				.clk = clk,
+				.clk_rate = clk_rate,
+				.error = error,
+				.actual_hz = actual_hz,
+				.brdv = brdv,
+				.spr = spr,
+			};
+
+			if (!error)
+				return;
+		}
+	}
+}
+
 static void rzv2h_rspi_find_rate_fixed(struct clk *clk, u32 hz,
 				       u8 spr_min, u8 spr_max,
 				       struct rzv2h_rspi_best_clock *best)
@@ -558,8 +657,17 @@ static const struct rzv2h_rspi_info rzv2h_info = {
 	.num_clks = 3,
 };
 
+static const struct rzv2h_rspi_info rzt2h_info = {
+	.find_tclk_rate = rzv2h_rspi_find_rate_variable,
+	.find_pclk_rate = rzv2h_rspi_find_rate_fixed,
+	.tclk_name = "pclkspi",
+	.fifo_size = 4,
+	.num_clks = 2,
+};
+
 static const struct of_device_id rzv2h_rspi_match[] = {
 	{ .compatible = "renesas,r9a09g057-rspi", &rzv2h_info },
+	{ .compatible = "renesas,r9a09g077-rspi", &rzt2h_info },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rzv2h_rspi_match);
-- 
2.52.0

