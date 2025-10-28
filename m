Return-Path: <linux-spi+bounces-10883-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CE8C14E19
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 14:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF6491C20158
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 13:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E27334687;
	Tue, 28 Oct 2025 13:33:23 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BDF333734;
	Tue, 28 Oct 2025 13:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761658403; cv=none; b=mIbV2L/bNHv42BMgiHHxCLUjAnW6fgS0snEJuMhxDlXZzUqUp/AsDZx0YfBsGjgmKFSmOJWXoLF51/H1qiUdeS6Cffp9VhJQirKbxKW5NVVn6/dZ3MPi4ZgqH2oqCEMKpmr7Xx8M04bGoxpy1Nwmd+ht9hET773yVB3gHE2Vw7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761658403; c=relaxed/simple;
	bh=NSS4sa0XjBwW8Aibwr78AzxvBbMqOSYtnHyTAB8RWKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fknx522thcz4Gjuzwmv9QoaDj/U4SBPMpX8G06QjyuI83igHwl3dV/oXxx/RwrLLYnbtB+nsJuVXw03lijV6HwU62vI2/nnE0aUhc1jvrr1D52RgNiDjaFABJRDb/LOcD1gu+dg7ZdX1faR//vgPgo8VX2xXt9KNk61yErqPn18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: 7emXW3Y5RLi5rdxmRO8X2Q==
X-CSE-MsgGUID: hcIv0xCVTn+LQHeBKyoBBA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 28 Oct 2025 22:33:19 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.5])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id B936941B6428;
	Tue, 28 Oct 2025 22:33:14 +0900 (JST)
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
Subject: [PATCH 08/14] spi: rzv2h-rspi: add support for using PCLK for transfer clock
Date: Tue, 28 Oct 2025 15:31:39 +0200
Message-ID: <20251028133151.1487327-9-cosmin-gabriel.tanislav.xa@renesas.com>
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

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs support
generating the SPI transfer clock from PCLK, with the quirk that SPR 0
is not supported, causing the highest achievable SPI transfer frequency
to be 31.25MHz.

Add support for generating the SPI transfer clock from PCLK.

Renesas RZ/V2H (R9A09G057) also has the BPEN bit used to enable this
option in the datasheet, but it is not explicitly documented and there's
no details about its limitations as there are on RZ/T2H.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index f59bcadf5e38..e9d8ee919261 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -34,6 +34,7 @@
 #define RSPI_SPFCR		0x6c
 
 /* Register SPCR */
+#define RSPI_SPCR_BPEN		BIT(31)
 #define RSPI_SPCR_MSTR		BIT(30)
 #define RSPI_SPCR_SPRIE		BIT(17)
 #define RSPI_SPCR_SCKASE	BIT(12)
@@ -41,6 +42,7 @@
 
 /* Register SPBR */
 #define RSPI_SPBR_SPR_MIN	0
+#define RSPI_SPBR_SPR_PCLK_MIN	1
 #define RSPI_SPBR_SPR_MAX	255
 
 /* Register SPCMD */
@@ -79,6 +81,8 @@ struct rzv2h_rspi_best_clock {
 struct rzv2h_rspi_info {
 	void (*find_tclk_rate)(struct clk *clk, u32 hz, u8 spr_min, u8 spr_max,
 			       struct rzv2h_rspi_best_clock *best_clk);
+	void (*find_pclk_rate)(struct clk *clk, u32 hz, u8 spr_low, u8 spr_high,
+			       struct rzv2h_rspi_best_clock *best_clk);
 	const char *tclk_name;
 	unsigned int fifo_size;
 	unsigned int num_clks;
@@ -90,6 +94,7 @@ struct rzv2h_rspi_priv {
 	const struct rzv2h_rspi_info *info;
 	void __iomem *base;
 	struct clk *tclk;
+	struct clk *pclk;
 	wait_queue_head_t wait;
 	unsigned int bytes_per_word;
 	u32 last_speed_hz;
@@ -97,6 +102,7 @@ struct rzv2h_rspi_priv {
 	u16 status;
 	u8 spr;
 	u8 brdv;
+	bool use_pclk;
 };
 
 #define RZV2H_RSPI_TX(func, type)					\
@@ -306,9 +312,18 @@ static u32 rzv2h_rspi_setup_clock(struct rzv2h_rspi_priv *rspi, u32 hz)
 	rspi->info->find_tclk_rate(rspi->tclk, hz, RSPI_SPBR_SPR_MIN,
 				   RSPI_SPBR_SPR_MAX, &best_clock);
 
+	/*
+	 * T2H and N2H can also use PCLK as a source, which is 125MHz, but not
+	 * when both SPR and BRDV are 0.
+	 */
+	if (best_clock.error && rspi->info->find_pclk_rate)
+		rspi->info->find_pclk_rate(rspi->pclk, hz, RSPI_SPBR_SPR_PCLK_MIN,
+					   RSPI_SPBR_SPR_MAX, &best_clock);
+
 	if (!best_clock.clk_rate)
 		return -EINVAL;
 
+	rspi->use_pclk = best_clock.clk == rspi->pclk;
 	rspi->spr = best_clock.spr;
 	rspi->brdv = best_clock.brdv;
 
@@ -361,6 +376,9 @@ static int rzv2h_rspi_prepare_message(struct spi_controller *ctlr,
 	/* SPI receive buffer full interrupt enable */
 	conf32 |= RSPI_SPCR_SPRIE;
 
+	/* Bypass synchronization circuit */
+	conf32 |= FIELD_PREP(RSPI_SPCR_BPEN, rspi->use_pclk);
+
 	writel(conf32, rspi->base + RSPI_SPCR);
 
 	/* Use SPCMD0 only */
@@ -433,7 +451,9 @@ static int rzv2h_rspi_probe(struct platform_device *pdev)
 	for (i = 0; i < rspi->info->num_clks; i++) {
 		if (!strcmp(clks[i].id, rspi->info->tclk_name)) {
 			rspi->tclk = clks[i].clk;
-			break;
+		} else if (rspi->info->find_pclk_rate &&
+			   !strcmp(clks[i].id, "pclk")) {
+			rspi->pclk = clks[i].clk;
 		}
 	}
 
-- 
2.51.1


