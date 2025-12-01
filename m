Return-Path: <linux-spi+bounces-11685-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36448C97ACC
	for <lists+linux-spi@lfdr.de>; Mon, 01 Dec 2025 14:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A22D3A2228
	for <lists+linux-spi@lfdr.de>; Mon,  1 Dec 2025 13:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC4B316197;
	Mon,  1 Dec 2025 13:43:49 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9511230DEA2;
	Mon,  1 Dec 2025 13:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764596629; cv=none; b=ufCrZHcShyvPLzB0Ld2iNaNAzVrOtmMuxaquaiSrrkYiSdnUBzl2jJhMTD2ctzMc+Qc02/rb2jJPBYPzEZnfdBofjC1Z8VAb8cltoyZPMO5ywGQcUQZKg1CTO+JOoBxXLb2lZklLeD6DZbZrenEGrE1W1PcFCpE9ZN5BK0pTB/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764596629; c=relaxed/simple;
	bh=HjyliHx7RRVHCDwLyI4GM+IRbi/UU7/RayCPv4NHBtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jj3x+WAYiqfvW6wXMwni6yeBhmlE5JBsNqSBwTeybMpejLkxPnzhc0DINGbAeqSN5k9/Ka1QD3XxqCS21Um6no5jehhRPeNAplKvW2mMjv4WpVagQX/55OwlO+7jfNHT7tZ+FKmPtbGj9/khTXi4DRWa1fZ+drOGOdLxNwScjuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: k+wmOS5LTui3CTrKODrU/g==
X-CSE-MsgGUID: h7mK7av0Trud7Mzf3aDdDA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Dec 2025 22:43:44 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.83])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 51D9E4215A52;
	Mon,  1 Dec 2025 22:43:40 +0900 (JST)
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
Subject: [PATCH 05/13] spi: rzv2h-rspi: store RX interrupt in state
Date: Mon,  1 Dec 2025 15:42:21 +0200
Message-ID: <20251201134229.600817-6-cosmin-gabriel.tanislav.xa@renesas.com>
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

In preparation for implementing DMA support, store the RX interrupt
number in the private state, to allow disabling it during DMA.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index 6163ada3ccbb..50fd7ddef58d 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -100,6 +100,7 @@ struct rzv2h_rspi_priv {
 	struct clk *pclk;
 	wait_queue_head_t wait;
 	unsigned int bytes_per_word;
+	int irq_rx;
 	u32 last_speed_hz;
 	u32 freq;
 	u16 status;
@@ -534,8 +535,8 @@ static int rzv2h_rspi_probe(struct platform_device *pdev)
 	struct rzv2h_rspi_priv *rspi;
 	struct reset_control *reset;
 	struct clk_bulk_data *clks;
-	int irq_rx, ret, i;
 	long tclk_rate;
+	int ret, i;
 
 	controller = devm_spi_alloc_host(dev, sizeof(*rspi));
 	if (!controller)
@@ -580,13 +581,13 @@ static int rzv2h_rspi_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(reset),
 				     "cannot get tresetn reset\n");
 
-	irq_rx = platform_get_irq_byname(pdev, "rx");
-	if (irq_rx < 0)
-		return dev_err_probe(dev, irq_rx, "cannot get IRQ 'rx'\n");
+	rspi->irq_rx = platform_get_irq_byname(pdev, "rx");
+	if (rspi->irq_rx < 0)
+		return dev_err_probe(dev, rspi->irq_rx, "cannot get IRQ 'rx'\n");
 
 	init_waitqueue_head(&rspi->wait);
 
-	ret = devm_request_irq(dev, irq_rx, rzv2h_rx_irq_handler, 0,
+	ret = devm_request_irq(dev, rspi->irq_rx, rzv2h_rx_irq_handler, 0,
 			       dev_name(dev), rspi);
 	if (ret) {
 		dev_err(dev, "cannot request `rx` IRQ\n");
-- 
2.52.0


