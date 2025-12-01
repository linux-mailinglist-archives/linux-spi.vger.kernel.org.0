Return-Path: <linux-spi+bounces-11684-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2010AC97ABA
	for <lists+linux-spi@lfdr.de>; Mon, 01 Dec 2025 14:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 15B354E188C
	for <lists+linux-spi@lfdr.de>; Mon,  1 Dec 2025 13:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC2F3161B5;
	Mon,  1 Dec 2025 13:43:46 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD98314A6E;
	Mon,  1 Dec 2025 13:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764596625; cv=none; b=iqr12z9lDfphmF8PnO3C0oQN4Kzgh7+7YWPqQivasNnwYEUAy60s2zwFUmX8OWXzV1zo7lYwwJJTKnUoAKL0YSMIcxG6Lb2H6Qmspa356Bd9cwTsURenq+tGY9JoOXsWnAPxKrmRlc38kzY+YeJgADjALmyub/cY/Z7NO4Rm7VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764596625; c=relaxed/simple;
	bh=29H8bdk1J/fakW8c7X2KWoLqSSTdQ/hUZGjKsn7jzPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tcx7j3PNNP5q/uRidYymtCsZtL2FeaYjw5QX3duPbYziRvBVmX8gQx+QDLolAAdP4w8t7XhhzepVlcKNoSJWlqRer6n5/Zy+Hoi6r+F8MYl6VPuDsUTLoXkfBtgrAJWZy8qAgvtqOyPxCNXqsYe/qYkFfhTcQaM8YqtEYFb40jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: /BUEYugWTsCEydQ0TlQ1tQ==
X-CSE-MsgGUID: Aoc6ZfOwQ0WqR7fskW1y+A==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Dec 2025 22:43:38 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.83])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 884E34215A52;
	Mon,  1 Dec 2025 22:43:34 +0900 (JST)
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
Subject: [PATCH 04/13] spi: rzv2h-rspi: use device-managed APIs
Date: Mon,  1 Dec 2025 15:42:20 +0200
Message-ID: <20251201134229.600817-5-cosmin-gabriel.tanislav.xa@renesas.com>
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

Non-device-managed APIs were initially used here to avoid the buggy
interaction between PM domains and device-managed actions.

Commit f99508074e78 ("PM: domains: Detach on device_unbind_cleanup()")
fixed the interaction between PM domains and device-managed actions.

Simplify the code by using device-managed actions to unregister the SPI
controller and to assert and release the resets.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 58 ++++++++++++------------------------
 1 file changed, 19 insertions(+), 39 deletions(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index 02424d4e722a..6163ada3ccbb 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -93,7 +93,6 @@ struct rzv2h_rspi_info {
 };
 
 struct rzv2h_rspi_priv {
-	struct reset_control_bulk_data resets[RSPI_RESET_NUM];
 	struct spi_controller *controller;
 	const struct rzv2h_rspi_info *info;
 	void __iomem *base;
@@ -533,6 +532,7 @@ static int rzv2h_rspi_probe(struct platform_device *pdev)
 	struct spi_controller *controller;
 	struct device *dev = &pdev->dev;
 	struct rzv2h_rspi_priv *rspi;
+	struct reset_control *reset;
 	struct clk_bulk_data *clks;
 	int irq_rx, ret, i;
 	long tclk_rate;
@@ -568,28 +568,29 @@ static int rzv2h_rspi_probe(struct platform_device *pdev)
 	if (!rspi->tclk)
 		return dev_err_probe(dev, -EINVAL, "Failed to get tclk\n");
 
-	rspi->resets[0].id = "presetn";
-	rspi->resets[1].id = "tresetn";
-	ret = devm_reset_control_bulk_get_optional_exclusive(dev, RSPI_RESET_NUM,
-							     rspi->resets);
-	if (ret)
-		return dev_err_probe(dev, ret, "cannot get resets\n");
+	reset = devm_reset_control_get_optional_exclusive_deasserted(&pdev->dev,
+								     "presetn");
+	if (IS_ERR(reset))
+		return dev_err_probe(&pdev->dev, PTR_ERR(reset),
+				     "cannot get presetn reset\n");
+
+	reset = devm_reset_control_get_optional_exclusive_deasserted(&pdev->dev,
+								     "tresetn");
+	if (IS_ERR(reset))
+		return dev_err_probe(&pdev->dev, PTR_ERR(reset),
+				     "cannot get tresetn reset\n");
 
 	irq_rx = platform_get_irq_byname(pdev, "rx");
 	if (irq_rx < 0)
 		return dev_err_probe(dev, irq_rx, "cannot get IRQ 'rx'\n");
 
-	ret = reset_control_bulk_deassert(RSPI_RESET_NUM, rspi->resets);
-	if (ret)
-		return dev_err_probe(dev, ret, "failed to deassert resets\n");
-
 	init_waitqueue_head(&rspi->wait);
 
 	ret = devm_request_irq(dev, irq_rx, rzv2h_rx_irq_handler, 0,
 			       dev_name(dev), rspi);
 	if (ret) {
 		dev_err(dev, "cannot request `rx` IRQ\n");
-		goto quit_resets;
+		return ret;
 	}
 
 	controller->mode_bits = SPI_CPHA | SPI_CPOL | SPI_CS_HIGH |
@@ -601,20 +602,16 @@ static int rzv2h_rspi_probe(struct platform_device *pdev)
 	controller->transfer_one = rzv2h_rspi_transfer_one;
 
 	tclk_rate = clk_round_rate(rspi->tclk, 0);
-	if (tclk_rate < 0) {
-		ret = tclk_rate;
-		goto quit_resets;
-	}
+	if (tclk_rate < 0)
+		return tclk_rate;
 
 	controller->min_speed_hz = rzv2h_rspi_calc_bitrate(tclk_rate,
 							   RSPI_SPBR_SPR_MAX,
 							   RSPI_SPCMD_BRDV_MAX);
 
 	tclk_rate = clk_round_rate(rspi->tclk, ULONG_MAX);
-	if (tclk_rate < 0) {
-		ret = tclk_rate;
-		goto quit_resets;
-	}
+	if (tclk_rate < 0)
+		return tclk_rate;
 
 	controller->max_speed_hz = rzv2h_rspi_calc_bitrate(tclk_rate,
 							   RSPI_SPBR_SPR_MIN,
@@ -622,29 +619,13 @@ static int rzv2h_rspi_probe(struct platform_device *pdev)
 
 	device_set_node(&controller->dev, dev_fwnode(dev));
 
-	ret = spi_register_controller(controller);
-	if (ret) {
+	ret = devm_spi_register_controller(dev, controller);
+	if (ret)
 		dev_err(dev, "register controller failed\n");
-		goto quit_resets;
-	}
-
-	return 0;
-
-quit_resets:
-	reset_control_bulk_assert(RSPI_RESET_NUM, rspi->resets);
 
 	return ret;
 }
 
-static void rzv2h_rspi_remove(struct platform_device *pdev)
-{
-	struct rzv2h_rspi_priv *rspi = platform_get_drvdata(pdev);
-
-	spi_unregister_controller(rspi->controller);
-
-	reset_control_bulk_assert(RSPI_RESET_NUM, rspi->resets);
-}
-
 static const struct rzv2h_rspi_info rzv2h_info = {
 	.find_tclk_rate = rzv2h_rspi_find_rate_fixed,
 	.tclk_name = "tclk",
@@ -669,7 +650,6 @@ MODULE_DEVICE_TABLE(of, rzv2h_rspi_match);
 
 static struct platform_driver rzv2h_rspi_drv = {
 	.probe = rzv2h_rspi_probe,
-	.remove = rzv2h_rspi_remove,
 	.driver = {
 		.name = "rzv2h_rspi",
 		.of_match_table = rzv2h_rspi_match,
-- 
2.52.0


