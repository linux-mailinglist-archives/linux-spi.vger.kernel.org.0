Return-Path: <linux-spi+bounces-10385-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17478BB023F
	for <lists+linux-spi@lfdr.de>; Wed, 01 Oct 2025 13:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FC0E7AC699
	for <lists+linux-spi@lfdr.de>; Wed,  1 Oct 2025 11:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DB52D9499;
	Wed,  1 Oct 2025 11:26:19 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020EB2D12EF;
	Wed,  1 Oct 2025 11:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759317979; cv=none; b=tcfk7GZEO6tAH99UA7AGDtN8GR6izQhehHeB8aj/XxU7RuCL2nSPy8sn/kRr9XNxgD0bdnDwdfpZ9kTR9fzNDMMrEjVkxPQhA+ZNnPG9y1iHr5tYl4zltz0B4TjD1n5u6Ppvkbg4ZG6sKhS/ucF0AYSQk6/45XjOUqNamhxpkjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759317979; c=relaxed/simple;
	bh=+JQlGOi82GStO5BpCxC0o9ag/xFIx8Vvi+EBjRTSKrM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NjrXY3cciWCty0ZZMD9GIrjHfaQnv9hFE/zbzv+ktLoq9QJxDxz3lDC+gKHMXpm9gIY4q+Y0VpqjoRdtkOldRg6hxSqI30S2S0LbYQnKWYfwyL8VEa4KIJvEYwfFlarIn/FCdNcJFi0Mku19IRzNMZVmJF4lv/RcArG7CTkwyoA=
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
Subject: [PATCH 2/6] spi: aspeed: Improve timing calibration algorithm for AST2600 platform
Date: Wed, 1 Oct 2025 19:26:01 +0800
Message-ID: <20251001112605.1130723-3-chin-ting_kuo@aspeedtech.com>
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

Starting with the AST2600 platform, most platfom manufacturers have
adopted more complex board designs and signal routing, making SPI
timing calibration increasingly sensitive and critical. Previously,
the driver selected the first "PASS" timing point during calibration,
which may not yield the most stable result.

This patch introduces a more robust calibration method:
- It evaluates all combinations of HCLK sample point delay and DI input
  delay. The results are stored in a 2D buffer for further comparison.
- Because the timing delay behavior is non-linear across HCLK sample
  points, the optimal timing point is selected as the center of the
  longest consecutive "PASS" interval within a single HCLK sample
  point row.

This approach ensures better stability and precision in SPI read timing,
especially under complex signal integrity conditions.

Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
---
 drivers/spi/spi-aspeed-smc.c | 70 +++++++++++++++++++++++++++++-------
 1 file changed, 58 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index 9c54c05da3cc..d2d9e13e9bda 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -1162,21 +1162,57 @@ static int aspeed_spi_do_calibration(struct aspeed_spi_chip *chip)
 
 #define TIMING_DELAY_DI		BIT(3)
 #define TIMING_DELAY_HCYCLE_MAX	5
+#define TIMING_DELAY_INPUT_MAX	16
 #define TIMING_REG_AST2600(chip)				\
 	((chip)->aspi->regs + (chip)->aspi->data->timing +	\
 	 (chip)->cs * 4)
 
+/*
+ * This function returns the center point of the longest
+ * continuous "pass" interval within the buffer. The interval
+ * must contains the highest number of consecutive "pass"
+ * results and not span across multiple rows.
+ */
+static u32 aspeed_spi_ast2600_optimized_timing(u32 rows, u32 cols,
+					       u8 buf[rows][cols])
+{
+	int r = 0, c = 0;
+	int max = 0;
+	int i, j;
+
+	for (i = 0; i < rows; i++) {
+		for (j = 0; j < cols;) {
+			int k = j;
+
+			while (k < cols && buf[i][k])
+				k++;
+
+			if (k - j > max) {
+				max = k - j;
+				r = i;
+				c = j + (k - j) / 2;
+			}
+
+			j = k + 1;
+		}
+	}
+
+	return max > 4 ? r * cols + c : 0;
+}
+
 static int aspeed_spi_ast2600_calibrate(struct aspeed_spi_chip *chip, u32 hdiv,
 					const u8 *golden_buf, u8 *test_buf)
 {
 	struct aspeed_spi *aspi = chip->aspi;
 	int hcycle;
+	int delay_ns;
 	u32 shift = (hdiv - 2) << 3;
-	u32 mask = ~(0xfu << shift);
+	u32 mask = ~(0xffu << shift);
 	u32 fread_timing_val = 0;
+	u8 calib_res[6][17] = {0};
+	u32 calib_point;
 
 	for (hcycle = 0; hcycle <= TIMING_DELAY_HCYCLE_MAX; hcycle++) {
-		int delay_ns;
 		bool pass = false;
 
 		fread_timing_val &= mask;
@@ -1189,14 +1225,14 @@ static int aspeed_spi_ast2600_calibrate(struct aspeed_spi_chip *chip, u32 hdiv,
 			"  * [%08x] %d HCLK delay, DI delay none : %s",
 			fread_timing_val, hcycle, pass ? "PASS" : "FAIL");
 		if (pass)
-			return 0;
+			calib_res[hcycle][0] = 1;
 
 		/* Add DI input delays  */
 		fread_timing_val &= mask;
 		fread_timing_val |= (TIMING_DELAY_DI | hcycle) << shift;
 
-		for (delay_ns = 0; delay_ns < 0x10; delay_ns++) {
-			fread_timing_val &= ~(0xf << (4 + shift));
+		for (delay_ns = 0; delay_ns < TIMING_DELAY_INPUT_MAX; delay_ns++) {
+			fread_timing_val &= ~(0xfu << (4 + shift));
 			fread_timing_val |= delay_ns << (4 + shift);
 
 			writel(fread_timing_val, TIMING_REG_AST2600(chip));
@@ -1205,18 +1241,28 @@ static int aspeed_spi_ast2600_calibrate(struct aspeed_spi_chip *chip, u32 hdiv,
 				"  * [%08x] %d HCLK delay, DI delay %d.%dns : %s",
 				fread_timing_val, hcycle, (delay_ns + 1) / 2,
 				(delay_ns + 1) & 1 ? 5 : 5, pass ? "PASS" : "FAIL");
-			/*
-			 * TODO: This is optimistic. We should look
-			 * for a working interval and save the middle
-			 * value in the read timing register.
-			 */
+
 			if (pass)
-				return 0;
+				calib_res[hcycle][delay_ns + 1] = 1;
 		}
 	}
 
+	calib_point = aspeed_spi_ast2600_optimized_timing(6, 17, calib_res);
 	/* No good setting for this frequency */
-	return -1;
+	if (calib_point == 0)
+		return -1;
+
+	hcycle = calib_point / 17;
+	delay_ns = calib_point % 17;
+
+	fread_timing_val = (TIMING_DELAY_DI | hcycle | (delay_ns << 4)) << shift;
+
+	dev_dbg(aspi->dev, "timing val: %08x, final hcycle: %d, delay_ns: %d\n",
+		fread_timing_val, hcycle, delay_ns);
+
+	writel(fread_timing_val, TIMING_REG_AST2600(chip));
+
+	return 0;
 }
 
 /*
-- 
2.34.1


