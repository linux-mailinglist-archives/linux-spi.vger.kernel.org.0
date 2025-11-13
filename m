Return-Path: <linux-spi+bounces-11186-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5D6C56759
	for <lists+linux-spi@lfdr.de>; Thu, 13 Nov 2025 10:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D2C64357D3B
	for <lists+linux-spi@lfdr.de>; Thu, 13 Nov 2025 08:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81B433B6CB;
	Thu, 13 Nov 2025 08:53:46 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7C133AD9B;
	Thu, 13 Nov 2025 08:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763024026; cv=none; b=iUjePX9Noz4b532xOiJlgUOXaWxIu5lZVwuO/028J3da5kYeFvrBe4YbGYPWvLapGLq0FImmyIsHXiDwRezkRwOLJ7Q6QJsi2D/yLX13RY3kHUgPIUGCjPBuYDmzaDP20naF64c9dvkUmaH8hnfZmaW0ntjLsDLG+JJi9kK4J5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763024026; c=relaxed/simple;
	bh=5bzOt057KZZjQZzpwJKi5mVUZc8SdPBEz5J7qEOwi/o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p3fklT3nkLMvr7Y5KHZgdyxhfp/V1yt69cuMBoynw3i/OAv/ZhlckwsoBd1jsvrA+hZRVF8CLYorbvwqMKLTTBa736pG7rDWEVPxK7pQCKVRBpGWZVjJRuovMM0SchpLd+17teERyvQP/WDbtbS6/+G3+9N6fnzCM11uU97q6vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 13 Nov
 2025 16:53:33 +0800
Received: from aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 13 Nov 2025 16:53:33 +0800
From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>, <clg@kaod.org>,
	<clg@redhat.com>, <broonie@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>,
	<linux-spi@vger.kernel.org>, <BMC-SW@aspeedtech.com>
Subject: [PATCH 4/4] spi: aspeed: Add support for the AST2700 SPI controller
Date: Thu, 13 Nov 2025 16:53:32 +0800
Message-ID: <20251113085332.89688-5-chin-ting_kuo@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113085332.89688-1-chin-ting_kuo@aspeedtech.com>
References: <20251113085332.89688-1-chin-ting_kuo@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Extend the driver to support the AST2700 SPI controller. Compared to
AST2600, AST2700 has the following characteristics:
 - A 64-bit memory address space.
 - A 64KB address decoding unit.
 - Segment registers now use (start <= range < end) semantics,
   which differs slightly from (start <= range <= end) in AST2600.
 - Known issues related to address decoding range registers have been
   resolved, and the decoding range is now 1GB, which is sufficient.
   Therefore, the adjust_window callback is no longer required on AST2700
   for range adjustment and bug fixes.
 - The SPI clock divider method and timing calibration logic remain
   unchanged from AST2600.

Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
---
 drivers/spi/spi-aspeed-smc.c | 71 ++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index d1a8bdf6d540..db3e096f2eb0 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -985,6 +985,41 @@ static u32 aspeed_spi_segment_ast2600_reg(struct aspeed_spi *aspi,
 		((end - 1) & AST2600_SEG_ADDR_MASK);
 }
 
+/* The Segment Registers of the AST2700 use a 64KB unit. */
+#define AST2700_SEG_ADDR_MASK 0x7fff0000
+
+static phys_addr_t aspeed_spi_segment_ast2700_start(struct aspeed_spi *aspi,
+						    u32 reg)
+{
+	u64 start_offset = (reg << 16) & AST2700_SEG_ADDR_MASK;
+
+	if (!start_offset)
+		return aspi->ahb_base_phy;
+
+	return aspi->ahb_base_phy + start_offset;
+}
+
+static phys_addr_t aspeed_spi_segment_ast2700_end(struct aspeed_spi *aspi,
+						  u32 reg)
+{
+	u64 end_offset = reg & AST2700_SEG_ADDR_MASK;
+
+	if (!end_offset)
+		return aspi->ahb_base_phy;
+
+	return aspi->ahb_base_phy + end_offset;
+}
+
+static u32 aspeed_spi_segment_ast2700_reg(struct aspeed_spi *aspi,
+					  phys_addr_t start, phys_addr_t end)
+{
+	if (start == end)
+		return 0;
+
+	return (u32)(((start & AST2700_SEG_ADDR_MASK) >> 16) |
+		     (end & AST2700_SEG_ADDR_MASK));
+}
+
 /*
  * Read timing compensation sequences
  */
@@ -1511,6 +1546,40 @@ static const struct aspeed_spi_data ast2600_spi_data = {
 	.adjust_window = aspeed_adjust_window_ast2600,
 };
 
+static const struct aspeed_spi_data ast2700_fmc_data = {
+	.max_cs	       = 3,
+	.hastype       = false,
+	.mode_bits     = SPI_RX_QUAD | SPI_TX_QUAD,
+	.we0	       = 16,
+	.ctl0	       = CE0_CTRL_REG,
+	.timing	       = CE0_TIMING_COMPENSATION_REG,
+	.hclk_mask     = 0xf0fff0ff,
+	.hdiv_max      = 2,
+	.min_window_size = 0x10000,
+	.get_clk_div   = aspeed_get_clk_div_ast2600,
+	.calibrate     = aspeed_spi_ast2600_calibrate,
+	.segment_start = aspeed_spi_segment_ast2700_start,
+	.segment_end   = aspeed_spi_segment_ast2700_end,
+	.segment_reg   = aspeed_spi_segment_ast2700_reg,
+};
+
+static const struct aspeed_spi_data ast2700_spi_data = {
+	.max_cs	       = 2,
+	.hastype       = false,
+	.mode_bits     = SPI_RX_QUAD | SPI_TX_QUAD,
+	.we0	       = 16,
+	.ctl0	       = CE0_CTRL_REG,
+	.timing	       = CE0_TIMING_COMPENSATION_REG,
+	.hclk_mask     = 0xf0fff0ff,
+	.hdiv_max      = 2,
+	.min_window_size = 0x10000,
+	.get_clk_div   = aspeed_get_clk_div_ast2600,
+	.calibrate     = aspeed_spi_ast2600_calibrate,
+	.segment_start = aspeed_spi_segment_ast2700_start,
+	.segment_end   = aspeed_spi_segment_ast2700_end,
+	.segment_reg   = aspeed_spi_segment_ast2700_reg,
+};
+
 static const struct of_device_id aspeed_spi_matches[] = {
 	{ .compatible = "aspeed,ast2400-fmc", .data = &ast2400_fmc_data },
 	{ .compatible = "aspeed,ast2400-spi", .data = &ast2400_spi_data },
@@ -1518,6 +1587,8 @@ static const struct of_device_id aspeed_spi_matches[] = {
 	{ .compatible = "aspeed,ast2500-spi", .data = &ast2500_spi_data },
 	{ .compatible = "aspeed,ast2600-fmc", .data = &ast2600_fmc_data },
 	{ .compatible = "aspeed,ast2600-spi", .data = &ast2600_spi_data },
+	{ .compatible = "aspeed,ast2700-fmc", .data = &ast2700_fmc_data },
+	{ .compatible = "aspeed,ast2700-spi", .data = &ast2700_spi_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, aspeed_spi_matches);
-- 
2.34.1


