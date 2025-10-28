Return-Path: <linux-spi+bounces-10884-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F030C14E5E
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 14:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D03A563557
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 13:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E25233509F;
	Tue, 28 Oct 2025 13:33:28 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674FF334370;
	Tue, 28 Oct 2025 13:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761658408; cv=none; b=bRlgR9iHVmjwbsKsdGdFG/nBYNgbA9WnAeu9RctHVcsEg3cfL/clYIuiT8hajm8UZlfuXjregumPKjdkj8ApIud0feyO8Gm+ROhf+bCUoqDR8umPQcZs840cEc3TfTMsqrJfPmfKNrWr9f9+uWyYJtuxpQdD+j7wJeBLT2Tt89s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761658408; c=relaxed/simple;
	bh=VDK05HhJ2ZP31CgM9vNYjYO+MR9aGv3w0ZiMr8zKYUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hdnOquXXtknDatkMfv79zOfoRztVKp+6qKYDF1R23XiQWx7WxE8W1w8ifOLnGoUYA9Ukmyxf2Oy8eAAt/eA1c2HRwX0s/2wkTZsO/HIZcxtF5r/6+RlowWXdQAODkcxLXIj+MKxVDopGKMzuezA0UfjlH7dW+EAe1/LebKMq0yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: 0W8tuBdVQ3OWOucuPLDXgw==
X-CSE-MsgGUID: WcPodb6EQWigMTtI8XdrDw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 28 Oct 2025 22:33:26 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.5])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1B2B441B6443;
	Tue, 28 Oct 2025 22:33:20 +0900 (JST)
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
Subject: [PATCH 09/14] spi: rzv2h-rspi: add support for variable transfer clock
Date: Tue, 28 Oct 2025 15:31:40 +0200
Message-ID: <20251028133151.1487327-10-cosmin-gabriel.tanislav.xa@renesas.com>
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

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have a more
complicated clocking setup for the SPI transfer clock than RZ/V2H, as
the clock from which it is generated supports multiple dividers.

To prepare for adding support for these SoCs, do the following changes.

Use the minimum frequency of SPI clock to calculate the SPI
controller's min_speed_hz, and the maximum frequency to calculate
max_speed_hz.

Apply the clock rate found by the .find_tclk_rate() to the found clock.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index e9d8ee919261..9bd350e1f1fa 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -308,6 +308,7 @@ static u32 rzv2h_rspi_setup_clock(struct rzv2h_rspi_priv *rspi, u32 hz)
 	struct rzv2h_rspi_best_clock best_clock = {
 		.error = ULONG_MAX,
 	};
+	int ret;
 
 	rspi->info->find_tclk_rate(rspi->tclk, hz, RSPI_SPBR_SPR_MIN,
 				   RSPI_SPBR_SPR_MAX, &best_clock);
@@ -323,6 +324,10 @@ static u32 rzv2h_rspi_setup_clock(struct rzv2h_rspi_priv *rspi, u32 hz)
 	if (!best_clock.clk_rate)
 		return -EINVAL;
 
+	ret = clk_set_rate(best_clock.clk, best_clock.clk_rate);
+	if (ret)
+		return 0;
+
 	rspi->use_pclk = best_clock.clk == rspi->pclk;
 	rspi->spr = best_clock.spr;
 	rspi->brdv = best_clock.brdv;
@@ -426,8 +431,8 @@ static int rzv2h_rspi_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct rzv2h_rspi_priv *rspi;
 	struct clk_bulk_data *clks;
-	unsigned long tclk_rate;
 	int irq_rx, ret, i;
+	long tclk_rate;
 
 	controller = devm_spi_alloc_host(dev, sizeof(*rspi));
 	if (!controller)
@@ -460,8 +465,6 @@ static int rzv2h_rspi_probe(struct platform_device *pdev)
 	if (!rspi->tclk)
 		return dev_err_probe(dev, -EINVAL, "Failed to get tclk\n");
 
-	tclk_rate = clk_get_rate(rspi->tclk);
-
 	rspi->resets[0].id = "presetn";
 	rspi->resets[1].id = "tresetn";
 	ret = devm_reset_control_bulk_get_optional_exclusive(dev, RSPI_RESET_NUM,
@@ -493,9 +496,19 @@ static int rzv2h_rspi_probe(struct platform_device *pdev)
 	controller->unprepare_message = rzv2h_rspi_unprepare_message;
 	controller->num_chipselect = 4;
 	controller->transfer_one = rzv2h_rspi_transfer_one;
+
+	tclk_rate = clk_round_rate(rspi->tclk, 0);
+	if (tclk_rate < 0)
+		return tclk_rate;
+
 	controller->min_speed_hz = rzv2h_rspi_calc_bitrate(tclk_rate,
 							   RSPI_SPBR_SPR_MAX,
 							   RSPI_SPCMD_BRDV_MAX);
+
+	tclk_rate = clk_round_rate(rspi->tclk, ULONG_MAX);
+	if (tclk_rate < 0)
+		return tclk_rate;
+
 	controller->max_speed_hz = rzv2h_rspi_calc_bitrate(tclk_rate,
 							   RSPI_SPBR_SPR_MIN,
 							   RSPI_SPCMD_BRDV_MIN);
-- 
2.51.1


