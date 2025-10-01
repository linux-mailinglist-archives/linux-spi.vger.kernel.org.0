Return-Path: <linux-spi+bounces-10384-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF317BB0231
	for <lists+linux-spi@lfdr.de>; Wed, 01 Oct 2025 13:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C21377A9364
	for <lists+linux-spi@lfdr.de>; Wed,  1 Oct 2025 11:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05312D0C64;
	Wed,  1 Oct 2025 11:26:17 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4D92C3761;
	Wed,  1 Oct 2025 11:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759317977; cv=none; b=jQBg+JVzy6Px4NrL8QuhEYnl0+i3xhh5VN0YaRoqeNZrNNd1MVSNgW02Qwu2tqzQ+hB6vEoyHg0MS/2g3EDH9MwwNQIDcDnRBoL/vU/lextKfALGHJuZE0JF0P/UCxPkUXNAehpeUyPROavTqJ1IH2QGsWlJA5FTGRgCnoVeedk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759317977; c=relaxed/simple;
	bh=8+Ifldp/lAzDztipYv0RQaC10Vs5kNnCVwdiPdjpfI8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=inNetZ476rN/bm0tQ8cCPGBnt3u4SBqXWuLmW0yIM8ZeLQY2PIint7Z1o65hyWkJUnXGZO+NUeuDI6usj8+GxQzSpYgrh8QvEFJqrhfniNrRtUQXqmnoDtQPQ4Zm5jQdkZYUU39S5nWehLdTUidYRXaY5uKKKyA7ajGQrTuVu18=
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
Subject: [PATCH 1/6] spi: aspeed: Update clock selection strategy
Date: Wed, 1 Oct 2025 19:26:00 +0800
Message-ID: <20251001112605.1130723-2-chin-ting_kuo@aspeedtech.com>
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

This patch updates the SPI clock selection logic for cases where
timing calibration is not performed or the results are failed.

Timing calibration process is skipped in the two scenarios below.
- Low-entropy data in the calibration region:
  The driver skips timing calibration if the data read from the
  SPI flash contains mostly 0x00 or 0xFF. Originally, the driver
  used a low-frequency clock to read this region as golden data.
  However, due to variations in host characteristics and image
  layout, we cannot assume sufficient entropy in this region to
  ensure reliable calibration.

- Low-speed configurations (< 40MHz):
  The ASPEED SPI controller does not support timing calibration when
  the max_speed_hz of the SPI device is below 40MHz.

In both cases, the SPI clock frequency specified in the device tree
should be used directly. When timing calibration is skipped, it is
the board vendor's responsibility to ensure that the SPI flash
SI (Signal Integrity) is sufficient for reliable operation at the
configured frequency.

When timing calibration processes is execued and all potential clock
frequencies are performed, but are all failed, the lower clock frequency
should be adopted to ensure the overall system can boot up successfully.

Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
---
 drivers/spi/spi-aspeed-smc.c | 177 +++++++++++++++++++++++++++++++----
 1 file changed, 159 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index 62a11142bd63..9c54c05da3cc 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -82,6 +82,7 @@ struct aspeed_spi_data {
 	u32 (*segment_start)(struct aspeed_spi *aspi, u32 reg);
 	u32 (*segment_end)(struct aspeed_spi *aspi, u32 reg);
 	u32 (*segment_reg)(struct aspeed_spi *aspi, u32 start, u32 end);
+	u32 (*get_clk_div)(struct aspeed_spi_chip *chip, u32 hz);
 	int (*calibrate)(struct aspeed_spi_chip *chip, u32 hdiv,
 			 const u8 *golden_buf, u8 *test_buf);
 };
@@ -942,26 +943,149 @@ static bool aspeed_spi_check_calib_data(const u8 *test_buf, u32 size)
 }
 
 static const u32 aspeed_spi_hclk_divs[] = {
-	0xf, /* HCLK */
-	0x7, /* HCLK/2 */
-	0xe, /* HCLK/3 */
-	0x6, /* HCLK/4 */
-	0xd, /* HCLK/5 */
+	/* HCLK, HCLK/2, HCLK/3, HCLK/4, HCLK/5, ..., HCLK/16 */
+	0xf, 0x7, 0xe, 0x6, 0xd,
+	0x5, 0xc, 0x4, 0xb, 0x3,
+	0xa, 0x2, 0x9, 0x1, 0x8,
+	0x0
 };
 
 #define ASPEED_SPI_HCLK_DIV(i) \
 	(aspeed_spi_hclk_divs[(i) - 1] << CTRL_FREQ_SEL_SHIFT)
 
+/* Transfer maximum clock frequency to register setting */
+static u32 aspeed_get_clk_div_ast2400(struct aspeed_spi_chip *chip,
+				      u32 max_hz)
+{
+	struct device *dev = chip->aspi->dev;
+	u32 hclk_clk = chip->aspi->clk_freq;
+	u32 div_ctl = 0;
+	u32 i;
+	bool found = false;
+
+	/* FMC/SPIR10[11:8] */
+	for (i = 1; i <= ARRAY_SIZE(aspeed_spi_hclk_divs); i++) {
+		if (hclk_clk / i <= max_hz) {
+			found = true;
+			break;
+		}
+	}
+
+	if (found) {
+		div_ctl = ASPEED_SPI_HCLK_DIV(i);
+		chip->clk_freq = hclk_clk / i;
+	}
+
+	dev_dbg(dev, "found: %s, hclk: %d, max_clk: %d\n",
+		found ? "yes" : "no", hclk_clk, max_hz);
+
+	if (found) {
+		dev_dbg(dev, "h_div: 0x%08x, speed: %d\n",
+			div_ctl, chip->clk_freq);
+	}
+
+	return div_ctl;
+}
+
+static u32 aspeed_get_clk_div_ast2500(struct aspeed_spi_chip *chip,
+				      u32 max_hz)
+{
+	struct device *dev = chip->aspi->dev;
+	u32 hclk_clk = chip->aspi->clk_freq;
+	u32 div_ctl = 0;
+	u32 i;
+	bool found = false;
+
+	/* FMC/SPIR10[11:8] */
+	for (i = 1; i <= ARRAY_SIZE(aspeed_spi_hclk_divs); i++) {
+		if (hclk_clk / i <= max_hz) {
+			found = true;
+			chip->clk_freq = hclk_clk / i;
+			break;
+		}
+	}
+
+	if (found) {
+		div_ctl = ASPEED_SPI_HCLK_DIV(i);
+		goto end;
+	}
+
+	for (i = 1; i <= ARRAY_SIZE(aspeed_spi_hclk_divs); i++) {
+		if (hclk_clk / (i * 4) <= max_hz) {
+			found = true;
+			chip->clk_freq = hclk_clk / (i * 4);
+			break;
+		}
+	}
+
+	if (found)
+		div_ctl = BIT(13) | ASPEED_SPI_HCLK_DIV(i);
+
+end:
+	dev_dbg(dev, "found: %s, hclk: %d, max_clk: %d\n",
+		found ? "yes" : "no", hclk_clk, max_hz);
+
+	if (found) {
+		dev_dbg(dev, "h_div: 0x%08x, speed: %d\n",
+			div_ctl, chip->clk_freq);
+	}
+
+	return div_ctl;
+}
+
+static u32 aspeed_get_clk_div_ast2600(struct aspeed_spi_chip *chip,
+				      u32 max_hz)
+{
+	struct device *dev = chip->aspi->dev;
+	u32 hclk_clk = chip->aspi->clk_freq;
+	u32 div_ctl = 0;
+	u32 i, j;
+	bool found = false;
+
+	/* FMC/SPIR10[27:24] */
+	for (j = 0; j < 16; j++) {
+		/* FMC/SPIR10[11:8] */
+		for (i = 1; i <= ARRAY_SIZE(aspeed_spi_hclk_divs); i++) {
+			if (j == 0 && i == 1)
+				continue;
+
+			if (hclk_clk / (j * 16 + i) <= max_hz) {
+				found = true;
+				break;
+			}
+		}
+
+		if (found) {
+			div_ctl = ((j << 24) | ASPEED_SPI_HCLK_DIV(i));
+			chip->clk_freq = hclk_clk / (j * 16 + i);
+			break;
+		}
+	}
+
+	dev_dbg(dev, "found: %s, hclk: %d, max_clk: %d\n",
+		found ? "yes" : "no", hclk_clk, max_hz);
+
+	if (found) {
+		dev_dbg(dev, "h_div: 0x%08x, speed: %d\n",
+			div_ctl, chip->clk_freq);
+	}
+
+	return div_ctl;
+}
+
 static int aspeed_spi_do_calibration(struct aspeed_spi_chip *chip)
 {
 	struct aspeed_spi *aspi = chip->aspi;
 	const struct aspeed_spi_data *data = aspi->data;
 	u32 ahb_freq = aspi->clk_freq;
 	u32 max_freq = chip->clk_freq;
+	bool exec_calib = false;
+	u32 best_freq = 0;
 	u32 ctl_val;
 	u8 *golden_buf = NULL;
 	u8 *test_buf = NULL;
-	int i, rc, best_div = -1;
+	int i, rc;
+	u32 div_ctl;
 
 	dev_dbg(aspi->dev, "calculate timing compensation - AHB freq: %d MHz",
 		ahb_freq / 1000000);
@@ -982,7 +1106,7 @@ static int aspeed_spi_do_calibration(struct aspeed_spi_chip *chip)
 	memcpy_fromio(golden_buf, chip->ahb_base, CALIBRATE_BUF_SIZE);
 	if (!aspeed_spi_check_calib_data(golden_buf, CALIBRATE_BUF_SIZE)) {
 		dev_info(aspi->dev, "Calibration area too uniform, using low speed");
-		goto no_calib;
+		goto end_calib;
 	}
 
 #if defined(VERBOSE_DEBUG)
@@ -991,7 +1115,7 @@ static int aspeed_spi_do_calibration(struct aspeed_spi_chip *chip)
 #endif
 
 	/* Now we iterate the HCLK dividers until we find our breaking point */
-	for (i = ARRAY_SIZE(aspeed_spi_hclk_divs); i > data->hdiv_max - 1; i--) {
+	for (i = 5; i > data->hdiv_max - 1; i--) {
 		u32 tv, freq;
 
 		freq = ahb_freq / i;
@@ -1004,22 +1128,33 @@ static int aspeed_spi_do_calibration(struct aspeed_spi_chip *chip)
 		dev_dbg(aspi->dev, "Trying HCLK/%d [%08x] ...", i, tv);
 		rc = data->calibrate(chip, i, golden_buf, test_buf);
 		if (rc == 0)
-			best_div = i;
+			best_freq = freq;
+
+		exec_calib = true;
 	}
 
-	/* Nothing found ? */
-	if (best_div < 0) {
-		dev_warn(aspi->dev, "No good frequency, using dumb slow");
+end_calib:
+	if (!exec_calib) {
+		/* calibration process is not executed */
+		dev_warn(aspi->dev, "Force to dts configuration %dkHz.\n",
+			 max_freq / 1000);
+		div_ctl = data->get_clk_div(chip, max_freq);
+	} else if (best_freq == 0) {
+		/* calibration process is executed, but no good frequency */
+		dev_warn(aspi->dev, "No good frequency, using dumb slow\n");
+		div_ctl = 0;
 	} else {
-		dev_dbg(aspi->dev, "Found good read timings at HCLK/%d", best_div);
+		dev_dbg(aspi->dev, "Found good read timings at %dMHz.\n",
+			best_freq / 1000000);
+		div_ctl = data->get_clk_div(chip, best_freq);
+	}
 
-		/* Record the freq */
-		for (i = 0; i < ASPEED_SPI_MAX; i++)
-			chip->ctl_val[i] = (chip->ctl_val[i] & data->hclk_mask) |
-				ASPEED_SPI_HCLK_DIV(best_div);
+	/* Record the freq */
+	for (i = 0; i < ASPEED_SPI_MAX; i++) {
+		chip->ctl_val[i] = (chip->ctl_val[i] & data->hclk_mask) |
+				   div_ctl;
 	}
 
-no_calib:
 	writel(chip->ctl_val[ASPEED_SPI_READ], chip->ctl);
 	kfree(test_buf);
 	return 0;
@@ -1096,6 +1231,7 @@ static const struct aspeed_spi_data ast2400_fmc_data = {
 	.hclk_mask     = 0xfffff0ff,
 	.hdiv_max      = 1,
 	.calibrate     = aspeed_spi_calibrate,
+	.get_clk_div   = aspeed_get_clk_div_ast2400,
 	.segment_start = aspeed_spi_segment_start,
 	.segment_end   = aspeed_spi_segment_end,
 	.segment_reg   = aspeed_spi_segment_reg,
@@ -1109,6 +1245,7 @@ static const struct aspeed_spi_data ast2400_spi_data = {
 	.timing	       = 0x14,
 	.hclk_mask     = 0xfffff0ff,
 	.hdiv_max      = 1,
+	.get_clk_div   = aspeed_get_clk_div_ast2400,
 	.calibrate     = aspeed_spi_calibrate,
 	/* No segment registers */
 };
@@ -1121,6 +1258,7 @@ static const struct aspeed_spi_data ast2500_fmc_data = {
 	.timing	       = CE0_TIMING_COMPENSATION_REG,
 	.hclk_mask     = 0xffffd0ff,
 	.hdiv_max      = 1,
+	.get_clk_div   = aspeed_get_clk_div_ast2500,
 	.calibrate     = aspeed_spi_calibrate,
 	.segment_start = aspeed_spi_segment_start,
 	.segment_end   = aspeed_spi_segment_end,
@@ -1135,6 +1273,7 @@ static const struct aspeed_spi_data ast2500_spi_data = {
 	.timing	       = CE0_TIMING_COMPENSATION_REG,
 	.hclk_mask     = 0xffffd0ff,
 	.hdiv_max      = 1,
+	.get_clk_div   = aspeed_get_clk_div_ast2500,
 	.calibrate     = aspeed_spi_calibrate,
 	.segment_start = aspeed_spi_segment_start,
 	.segment_end   = aspeed_spi_segment_end,
@@ -1150,6 +1289,7 @@ static const struct aspeed_spi_data ast2600_fmc_data = {
 	.timing	       = CE0_TIMING_COMPENSATION_REG,
 	.hclk_mask     = 0xf0fff0ff,
 	.hdiv_max      = 2,
+	.get_clk_div   = aspeed_get_clk_div_ast2600,
 	.calibrate     = aspeed_spi_ast2600_calibrate,
 	.segment_start = aspeed_spi_segment_ast2600_start,
 	.segment_end   = aspeed_spi_segment_ast2600_end,
@@ -1165,6 +1305,7 @@ static const struct aspeed_spi_data ast2600_spi_data = {
 	.timing	       = CE0_TIMING_COMPENSATION_REG,
 	.hclk_mask     = 0xf0fff0ff,
 	.hdiv_max      = 2,
+	.get_clk_div   = aspeed_get_clk_div_ast2600,
 	.calibrate     = aspeed_spi_ast2600_calibrate,
 	.segment_start = aspeed_spi_segment_ast2600_start,
 	.segment_end   = aspeed_spi_segment_ast2600_end,
-- 
2.34.1


