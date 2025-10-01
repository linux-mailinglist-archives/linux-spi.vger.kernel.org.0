Return-Path: <linux-spi+bounces-10389-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C63BB0276
	for <lists+linux-spi@lfdr.de>; Wed, 01 Oct 2025 13:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 156732A29A2
	for <lists+linux-spi@lfdr.de>; Wed,  1 Oct 2025 11:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341252DE1E6;
	Wed,  1 Oct 2025 11:26:28 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AC42DCBEB;
	Wed,  1 Oct 2025 11:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759317988; cv=none; b=Of+Nt/UG3sKi+zQEXCF3RkRQG+Yn8lEWkxduBVUXHu1iHvwBDCFhp0RVmyx94pt6pBLNZS+wxoAQEPSiarO0ofuZdN6blXFvp4fLozqZh/xgVGHTkWJFdfy96Bjf8ksaijLxoSU8Tx3+LRXf3MFkYWuy4Gv+sLSYpoFQPFKUawA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759317988; c=relaxed/simple;
	bh=vKwBowoTaymQ8jmDwD4h32a8cDe97YdUoEzA8j+qWz4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ed2GUgUnA8F+EWtq6zsjkmwFkAk6I+JhSOoYuFiWDUOriCVZaXU6ZbA8BMcKhyLSNIfpSkdONqadNtqYGuxOiMg7XFnhmfnQanE0boevzHeHBbHicM9bdD6g2QRs5Ihdz3ETgoBx6ySEUfxyZFXknvtdXyvM58KmdNCzC5oO8k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 1 Oct
 2025 19:26:05 +0800
Received: from aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 1 Oct 2025 19:26:05 +0800
From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>, <clg@kaod.org>,
	<broonie@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>,
	<linux-spi@vger.kernel.org>, <BMC-SW@aspeedtech.com>
Subject: [PATCH 6/6] spi: aspeed: Only map necessary address window region
Date: Wed, 1 Oct 2025 19:26:05 +0800
Message-ID: <20251001112605.1130723-7-chin-ting_kuo@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001112605.1130723-1-chin-ting_kuo@aspeedtech.com>
References: <20251001112605.1130723-1-chin-ting_kuo@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Previously, the driver mapped the entire SPI address decoding region during
probe. On systems with small flash or limited memory, this could lead to
excessive memory usage or allocation failures.

This patch changes the strategy to initially map a small address window
for SPI flash device probing. After determining each chip select's flash
size, the driver unmaps the temporary region and remaps only the required
address window accordingly.

Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
---
 drivers/spi/spi-aspeed-smc.c | 39 +++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index 4f6ae48dd904..0c3de371fd39 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
@@ -96,7 +97,6 @@ struct aspeed_spi {
 	const struct aspeed_spi_data	*data;
 
 	void __iomem		*regs;
-	void __iomem		*ahb_base;
 	u32			 ahb_base_phy;
 	u32			 ahb_window_size;
 	u32			 num_cs;
@@ -394,6 +394,13 @@ static int aspeed_spi_set_window(struct aspeed_spi *aspi)
 	u32 cs;
 	size_t window_size;
 
+	for (cs = 0; cs < aspi->data->max_cs; cs++) {
+		if (aspi->chips[cs].ahb_base) {
+			iounmap(aspi->chips[cs].ahb_base);
+			aspi->chips[cs].ahb_base = NULL;
+		}
+	}
+
 	for (cs = 0; cs < aspi->data->max_cs; cs++) {
 		seg_reg = seg_reg_base + cs * 4;
 		seg_val_backup = readl(seg_reg);
@@ -425,13 +432,29 @@ static int aspeed_spi_set_window(struct aspeed_spi *aspi)
 		else
 			dev_dbg(dev, "CE%d window closed\n", cs);
 
-		aspi->chips[cs].ahb_base = aspi->ahb_base + offset;
 		offset += window_size;
 		if (offset > aspi->ahb_window_size) {
 			dev_err(dev, "CE%d offset value 0x%llx is too large.\n",
 				cs, (u64)offset);
 			return -ENOSPC;
 		}
+
+		/*
+		 * No need to map the address deocding range when
+		 * - window size is 0.
+		 * - the CS is unused.
+		 */
+		if (window_size == 0 || cs >= aspi->num_cs)
+			continue;
+
+		aspi->chips[cs].ahb_base =
+			devm_ioremap(aspi->dev, start, window_size);
+		if (!aspi->chips[cs].ahb_base) {
+			dev_err(aspi->dev,
+				"Fail to remap window [0x%.9llx - 0x%.9llx]\n",
+				(u64)start, (u64)end - 1);
+			return -ENOMEM;
+		}
 	}
 
 	return 0;
@@ -447,7 +470,9 @@ static int aspeed_spi_chip_set_default_window(struct aspeed_spi *aspi)
 
 	/* No segment registers for the AST2400 SPI controller */
 	if (aspi->data == &ast2400_spi_data) {
-		aspi->chips[0].ahb_base = aspi->ahb_base;
+		aspi->chips[0].ahb_base = devm_ioremap(aspi->dev,
+						       aspi->ahb_base_phy,
+						       aspi->ahb_window_size);
 		aspi->chips[0].ahb_window_size = aspi->ahb_window_size;
 		return 0;
 	}
@@ -839,10 +864,10 @@ static int aspeed_spi_probe(struct platform_device *pdev)
 	if (IS_ERR(aspi->regs))
 		return PTR_ERR(aspi->regs);
 
-	aspi->ahb_base = devm_platform_get_and_ioremap_resource(pdev, 1, &res);
-	if (IS_ERR(aspi->ahb_base)) {
-		dev_err(dev, "missing AHB mapping window\n");
-		return PTR_ERR(aspi->ahb_base);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (IS_ERR(res)) {
+		dev_err(dev, "missing AHB memory\n");
+		return PTR_ERR(res);
 	}
 
 	aspi->ahb_window_size = resource_size(res);
-- 
2.34.1


