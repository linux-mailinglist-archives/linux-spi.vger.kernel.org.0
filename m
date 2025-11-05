Return-Path: <linux-spi+bounces-11024-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 055ADC352BF
	for <lists+linux-spi@lfdr.de>; Wed, 05 Nov 2025 11:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEB6B564BE7
	for <lists+linux-spi@lfdr.de>; Wed,  5 Nov 2025 10:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC73A2FB098;
	Wed,  5 Nov 2025 10:43:18 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A329306B3F;
	Wed,  5 Nov 2025 10:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762339398; cv=none; b=qlpdY5PKWSlfum2SiRBrij/ep52OzjDISSigQgcGc3WDtYYKRhW1yNufrIr+x6TkXV1fkCnObXLBlmQDBRjWsjXG3tr1dz7K+NGjjBXwSbxYou7GXaU6sDkTXv1i4mJBt1K/w42mtI0f2PLTU3gt9dMdeK4ChvmoJkEEgkyIlAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762339398; c=relaxed/simple;
	bh=sieYt+3F9Zw/H+8sIMltSZBuydLmcz7sTPKXYOu6a5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dyNP6ugwgimI4WcuxKHsF4XSCreCVeByOl4fJG430GE/Oj3eC8qGvd1qP1uYPdW0JMltSspxpB1tJr1nC3vM6SKGEmQ0r/NTdyOSS4vr1PniPkvvBxCA7sL/r3MfWcZn5Wtm46jHwQP4FVmLLSt8Ol9DuXEQM0e60Tgr9h2nmRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: yGj6+ghOR/6Trj4ZPuLKHg==
X-CSE-MsgGUID: OFkjXPAoS5ikduJbKejN3Q==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 05 Nov 2025 19:43:15 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.82])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3A4E64001DCB;
	Wed,  5 Nov 2025 19:43:09 +0900 (JST)
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
Subject: [PATCH v3 04/14] spi: rzv2h-rspi: make clocks chip-specific
Date: Wed,  5 Nov 2025 12:41:41 +0200
Message-ID: <20251105104151.1489281-5-cosmin-gabriel.tanislav.xa@renesas.com>
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

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have
different clocks compared to RZ/V2H. Set the number of clocks and the
name of the transfer clock in the chip-specific structure to prepare for
adding support for them.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index 7a7a576c17dd..a1f17ec8727b 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -66,10 +66,11 @@
 #define RSPI_SPSRC_CLEAR	0xfd80
 
 #define RSPI_RESET_NUM		2
-#define RSPI_CLK_NUM		3
 
 struct rzv2h_rspi_info {
+	const char *tclk_name;
 	unsigned int fifo_size;
+	unsigned int num_clks;
 };
 
 struct rzv2h_rspi_priv {
@@ -373,11 +374,11 @@ static int rzv2h_rspi_probe(struct platform_device *pdev)
 		return PTR_ERR(rspi->base);
 
 	ret = devm_clk_bulk_get_all_enabled(dev, &clks);
-	if (ret != RSPI_CLK_NUM)
+	if (ret != rspi->info->num_clks)
 		return dev_err_probe(dev, ret >= 0 ? -EINVAL : ret,
 				     "cannot get clocks\n");
-	for (i = 0; i < RSPI_CLK_NUM; i++) {
-		if (!strcmp(clks[i].id, "tclk")) {
+	for (i = 0; i < rspi->info->num_clks; i++) {
+		if (!strcmp(clks[i].id, rspi->info->tclk_name)) {
 			rspi->tclk = clks[i].clk;
 			break;
 		}
@@ -452,7 +453,9 @@ static void rzv2h_rspi_remove(struct platform_device *pdev)
 }
 
 static const struct rzv2h_rspi_info rzv2h_info = {
+	.tclk_name = "tclk",
 	.fifo_size = 16,
+	.num_clks = 3,
 };
 
 static const struct of_device_id rzv2h_rspi_match[] = {
-- 
2.51.2


