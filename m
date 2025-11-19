Return-Path: <linux-spi+bounces-11337-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8234DC70370
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 17:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7DDDC4F768D
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 16:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FE4341058;
	Wed, 19 Nov 2025 16:15:39 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D9834104C;
	Wed, 19 Nov 2025 16:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763568939; cv=none; b=PKjQObZ3CtDd9kza3cfY5PPdjHxjdvzpVChjZnbtQwhf240+883e0/gl9zWdidJuzFslI1qKQEveyu9xrarsHhimbHOsl7bswR8SUH+vm/ruGopBHL7BUOYzNBOQHgkyyaEHP91KncFJqmvJ5eDOYvNrfbnuenXxE53IfouTQsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763568939; c=relaxed/simple;
	bh=tHlEVG8WG/LHcT9GxWsx1dYOk5lxR9LGd4fbJpSMyks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ik7TdL2Q3pkaQ4j7OOige217Cum9Up01GCelVRnq+F0XI/9pr+8CEGzVd5IjOPD9vlrtWki95XNylsJwyscsE9mDYCSNAeXxvK03W/gfhJnKVoE6m4yO2hIkH8ZZihTGTkvkyo5jVshwlgbRvFnaILbKIlMJB+Ol4WEWZwZAKbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: 1wy06Y8BQFq51pVdkgru+A==
X-CSE-MsgGUID: Zx19uR3aQDeA/ackjwwHbA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 20 Nov 2025 01:15:35 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.87])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id AEE4D406C477;
	Thu, 20 Nov 2025 01:15:31 +0900 (JST)
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
Subject: [PATCH v4 03/13] spi: rzv2h-rspi: make clocks chip-specific
Date: Wed, 19 Nov 2025 18:14:24 +0200
Message-ID: <20251119161434.595677-4-cosmin-gabriel.tanislav.xa@renesas.com>
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

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have
different clocks compared to RZ/V2H. Set the number of clocks and the
name of the transfer clock in the chip-specific structure to prepare for
adding support for them.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V4:
 * no changes

V3:
 * no changes

V2:
 * no changes

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
2.52.0

