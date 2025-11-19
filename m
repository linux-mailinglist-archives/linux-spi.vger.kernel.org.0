Return-Path: <linux-spi+bounces-11336-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CE282C70391
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 17:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A03674FB690
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 16:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04323546EA;
	Wed, 19 Nov 2025 16:15:32 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE66533A713;
	Wed, 19 Nov 2025 16:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763568932; cv=none; b=BQ2Gshb2DJ3485evQDeOE42qhYRhzuoT4e80Ycx91juddkApYhr7php54BI5bp3kGwBja3/kIs3lfiuSWlqZ6D57prRhe8mcfx0V2iq4VD9t4GyOXrbaECrcWLLrXBpcH87MzCFXmxJGJ1rrcfInRqvhInKOVS10TbJRDNrwY7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763568932; c=relaxed/simple;
	bh=UNQVsNhqwn7bdshWOOoxAAaUMdX7V4IkeWG2bSTQjAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nuyS7pIXk9MjI2nS0+VCzFXhdE5FTq9AsYzaXcPXhwV62l+t8Zw3VWTA/AGJOKzNT5eFhLfp+CcJZQZ6OWKyZ2o1oap1YLx9NMfaHcslJKI2oZTLTEJn/oZ48ebcnntillQtF41J5GrljwQdOChg1db2svqOGyy3u+VIMxuMPx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: 2qx7oNq/SvyOUsF84oK2kw==
X-CSE-MsgGUID: LqgJ2G8OT1axCgrtfabGkA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 20 Nov 2025 01:15:30 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.87])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5418D406C476;
	Thu, 20 Nov 2025 01:15:26 +0900 (JST)
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
Subject: [PATCH v4 02/13] spi: rzv2h-rspi: make FIFO size chip-specific
Date: Wed, 19 Nov 2025 18:14:23 +0200
Message-ID: <20251119161434.595677-3-cosmin-gabriel.tanislav.xa@renesas.com>
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

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have a
different FIFO size compared to RZ/V2H. Add a chip-specific structure,
and set the FIFO size inside it, to prepare for adding support for them.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V4:
 * no changes

V3:
 * no changes

V2:
 * no changes

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
2.52.0

