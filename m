Return-Path: <linux-spi+bounces-10879-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F05C14E55
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 14:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05C343B287B
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 13:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672E63314C1;
	Tue, 28 Oct 2025 13:32:55 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4287421A444;
	Tue, 28 Oct 2025 13:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761658375; cv=none; b=Smy0eES1BiVIIxi/wipUr2UXejaMGW3BdoBFT3TBtqGTArc63DvoRKaxAA+3/xG1OxF+qiXY9bi7HXRCn5jr7y4aSM+TJh/137+7ZuQdbmrEgCGPs46yH6Br5NXDujOGbAkJStMTmyEmWr8fhSOgCZVc29bLW5pHIM59Hin8PJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761658375; c=relaxed/simple;
	bh=JxuZMMLycjvZiMgMi6hZsoTDhEKLY6jLBkbmnnISYtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/GXRA1YE2XMhY98qYvSqvgM5fXqTdjCdcGn/JFtSxM/knHiLB4m6VDwGqJY/Wg5MsCtl7S7Y1PALh9DFK8bgh6Y2u5nwju9ndOZhzKRBl7A898xKjq0fPKCEKxUCvxO/jrYTIIz6Yq0EtUzVqb3ZOHBqNZaFu1sam32DHtNOMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: n5i7MZjyTCWdAlKZ3xhqYQ==
X-CSE-MsgGUID: MlYX72qOSBSxbGTNMAGHeA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 28 Oct 2025 22:32:51 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.5])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6857C41B5F49;
	Tue, 28 Oct 2025 22:32:46 +0900 (JST)
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
Subject: [PATCH 04/14] spi: rzv2h-rspi: make clocks chip-specific
Date: Tue, 28 Oct 2025 15:31:35 +0200
Message-ID: <20251028133151.1487327-5-cosmin-gabriel.tanislav.xa@renesas.com>
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

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have
different clocks compared to RZ/V2H. Set the number of clocks and the
name of the transfer clock in the chip-specific structure to prepare for
adding support for them.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
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
2.51.1


