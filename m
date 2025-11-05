Return-Path: <linux-spi+bounces-11005-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4DFC34C96
	for <lists+linux-spi@lfdr.de>; Wed, 05 Nov 2025 10:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BBC9D4FE8F3
	for <lists+linux-spi@lfdr.de>; Wed,  5 Nov 2025 09:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB4E3016E8;
	Wed,  5 Nov 2025 09:15:05 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640832FC011;
	Wed,  5 Nov 2025 09:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334105; cv=none; b=fTyVStHBV4iwhKkCptiNz2AcqaxDOeAtNOW1Q5tpArnyDUX2d/7IqJDYvxOsaB6GfVzuOLWJIBYRp0NNxcGyxRMBNxQu0zWhzqkjx8jRLDio5I5qDj1o3d6kR0UBu/fkCZo42+NGm93pvH4uUV7VlEDS0KfVuPS81A7GzY6Y5kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334105; c=relaxed/simple;
	bh=1u4fEjtbPiVf/1eUodFOVHHRdMyGMiZUk1LvcM7ZKL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n3fiibJirgpVzynlX4qxk5fFrQ+wci82MVCkRubJE16NICFyPKHP+ex5wSABpl6n1ZERH19rk6vu73SEqXiH2SVIi9YHWvSDnla4QOaJsAfnhdJQId6NGvIUHSzdSD/qO3mlLNexjcDw9kANoTRVjQQ3OaptfcgHMDcU2y1rK0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: A7vG/YnGSeaPnyoDgVBw6A==
X-CSE-MsgGUID: rXP+BmGsTZmceECSRri/QA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 05 Nov 2025 18:15:01 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.38])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8AA054175ED8;
	Wed,  5 Nov 2025 18:14:56 +0900 (JST)
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
Subject: [PATCH 03/14] spi: rzv2h-rspi: make FIFO size chip-specific
Date: Wed,  5 Nov 2025 11:13:47 +0200
Message-ID: <20251105091401.1462985-4-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251105091401.1462985-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251105091401.1462985-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have a
different FIFO size compared to RZ/V2H. Add a chip-specific structure,
and set the FIFO size inside it, to prepare for adding support for them.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index 09b9362e9b1f..7a7a576c17dd 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -58,7 +58,6 @@
 /* Register SPDCR2 */
 #define RSPI_SPDCR2_TTRG	GENMASK(11, 8)
 #define RSPI_SPDCR2_RTRG	GENMASK(3, 0)
-#define RSPI_FIFO_SIZE		16
 
 /* Register SPSR */
 #define RSPI_SPSR_SPRF		BIT(15)
@@ -69,9 +68,14 @@
 #define RSPI_RESET_NUM		2
 #define RSPI_CLK_NUM		3
 
+struct rzv2h_rspi_info {
+	unsigned int fifo_size;
+};
+
 struct rzv2h_rspi_priv {
 	struct reset_control_bulk_data resets[RSPI_RESET_NUM];
 	struct spi_controller *controller;
+	const struct rzv2h_rspi_info *info;
 	void __iomem *base;
 	struct clk *tclk;
 	wait_queue_head_t wait;
@@ -305,7 +309,7 @@ static int rzv2h_rspi_prepare_message(struct spi_controller *ctlr,
 		writeb(0, rspi->base + RSPI_SSLP);
 
 	/* Setup FIFO thresholds */
-	conf16 = FIELD_PREP(RSPI_SPDCR2_TTRG, RSPI_FIFO_SIZE - 1);
+	conf16 = FIELD_PREP(RSPI_SPDCR2_TTRG, rspi->info->fifo_size - 1);
 	conf16 |= FIELD_PREP(RSPI_SPDCR2_RTRG, 0);
 	writew(conf16, rspi->base + RSPI_SPDCR2);
 
@@ -362,6 +366,8 @@ static int rzv2h_rspi_probe(struct platform_device *pdev)
 
 	rspi->controller = controller;
 
+	rspi->info = device_get_match_data(dev);
+
 	rspi->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(rspi->base))
 		return PTR_ERR(rspi->base);
@@ -445,8 +451,12 @@ static void rzv2h_rspi_remove(struct platform_device *pdev)
 	reset_control_bulk_assert(RSPI_RESET_NUM, rspi->resets);
 }
 
+static const struct rzv2h_rspi_info rzv2h_info = {
+	.fifo_size = 16,
+};
+
 static const struct of_device_id rzv2h_rspi_match[] = {
-	{ .compatible = "renesas,r9a09g057-rspi" },
+	{ .compatible = "renesas,r9a09g057-rspi", &rzv2h_info },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rzv2h_rspi_match);
-- 
2.51.2


