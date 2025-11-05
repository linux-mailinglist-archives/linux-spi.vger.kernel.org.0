Return-Path: <linux-spi+bounces-11023-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6A3C352AA
	for <lists+linux-spi@lfdr.de>; Wed, 05 Nov 2025 11:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A51856475B
	for <lists+linux-spi@lfdr.de>; Wed,  5 Nov 2025 10:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99670306B39;
	Wed,  5 Nov 2025 10:43:13 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597BA306497;
	Wed,  5 Nov 2025 10:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762339393; cv=none; b=iXd26UfARfLPppTHnkM4VKWfozq8D2Nb7Ou1jRxmXruKrBIzsTCv7MWNB3WGXuGO2gTBXvTVKVvLh611A+JnfupBg/QolyfiLflvw9n+n8JHuToaQGzdLvI+Ebm5PmzJtsTmmsTHX8peFJBP9++n0DQ0juHF7qdvVB6IlG7KO0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762339393; c=relaxed/simple;
	bh=1u4fEjtbPiVf/1eUodFOVHHRdMyGMiZUk1LvcM7ZKL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MCFTTzZIfRz9OHMVBeuobTVouD6Kr0acOimTtTq0rIZ2yd+HnKxTyhjoX28lD+x6TKnfHqFuMEG53xQ5yJmqn85A5u6A23Q+9t68hkIHTAwyMLR0XnCwaNQ33YEq82c+0rc0zUfrXjNs6ozA/11BB6+gZoo//M/DoEcyO6gaUlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: 8flgLxuGRJeN9/zw57vsCA==
X-CSE-MsgGUID: MdL4wZ+DSK6md+ajUPZi8Q==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 05 Nov 2025 19:43:09 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.82])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3D8814001DCB;
	Wed,  5 Nov 2025 19:43:03 +0900 (JST)
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
Subject: [PATCH v3 03/14] spi: rzv2h-rspi: make FIFO size chip-specific
Date: Wed,  5 Nov 2025 12:41:40 +0200
Message-ID: <20251105104151.1489281-4-cosmin-gabriel.tanislav.xa@renesas.com>
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


