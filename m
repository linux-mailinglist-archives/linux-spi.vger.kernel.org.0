Return-Path: <linux-spi+bounces-6366-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0D3A13F30
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2025 17:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD0BC16972D
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2025 16:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D790722D4EB;
	Thu, 16 Jan 2025 16:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dcSbaN+U"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004E422CF3B;
	Thu, 16 Jan 2025 16:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737044475; cv=none; b=VV4ZYDSVlkTnAMuEe2TPbsNG7UQSWB3gipH5ApBFLdF1fjMyXmU+4gaIcPK82t40O6WR/TLHghVaZb6UrB/FIMt9c2bnj8gGDC8qGClIs9snCyE0xFGK4eU9cS3XpwHofJ/wpcoli5hSGTlmwGH7FmDPeQlKUXo1uaFBiCpgEnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737044475; c=relaxed/simple;
	bh=2on8qZ4VjcAt0taSdQR59mTjZSUShqi/XYwJ4lDPBWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PqRzQYgJz2r/trQdW0m5VYEkJQZfp3+xCM5WBAyrio0txVt7s0/oOsPXOR5rpzm7qpRb8tUDSg2+z2bFhXgKdK5GRzHzMCLtenGoVlEaypKSuMM07aoF2qFJOJ5JlgPOoI5EB45rRJiUWn7wG9nsg7w1qXF0OI8daUP1uq5wZlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dcSbaN+U; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737044474; x=1768580474;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2on8qZ4VjcAt0taSdQR59mTjZSUShqi/XYwJ4lDPBWY=;
  b=dcSbaN+UeqSyYD5mRaVUctFpUmON0f4NLFkbcm9F3ywZALnIUHMLpJ9Z
   /Y6FZbvXrIlEurm7F7D9qZc9ygWEe7GKB0dJlUgIwiKs7mSje53jjmjvW
   AQqU7IRyOTVxypK71z+fZ/Vup7shDBiR4xJ+/q8GPsJ5rWjdnJYRrBMQh
   b65e7QuYpUyQWROeRGf2GokaQG3gAPlZk4f18BWY9oOhpEusiPVOu5EHl
   Ex9WrHiJaAlhGUsjsIIqeF2zL62kDTis8CBaLhmHsWzAhh1+O3KME6JPD
   YpkIIqEIfenSmtzkTR8F4hUT8kI1OvhSS4zkl6xcSYr+OYFidxYwi9p3g
   w==;
X-CSE-ConnectionGUID: cbJNhh4SQECZ/lG/I86YXw==
X-CSE-MsgGUID: L6xwPxY+RB6+ml3Ig6+F9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="48030972"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="48030972"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 08:21:13 -0800
X-CSE-ConnectionGUID: 1H0zFeM9TMK7M/oHeAhUaA==
X-CSE-MsgGUID: C4jbOm2SRpy8YOUom+Ib/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110164712"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 16 Jan 2025 08:21:11 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2DFAD39C; Thu, 16 Jan 2025 18:21:10 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v1 1/1] spi: pxa2xx: Introduce __lpss_ssp_update_priv() helper
Date: Thu, 16 Jan 2025 18:21:09 +0200
Message-ID: <20250116162109.263081-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a few places we repeat RMW IO operations on LPSS private
registers. Let's introduce a helper to make the code better
to read and maintain.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 88 ++++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 48 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 903d76145272..5f9cac41baff 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -73,8 +73,9 @@ struct chip_data {
 #define LPSS_CAPS_CS_EN_MASK			(0xf << LPSS_CAPS_CS_EN_SHIFT)
 
 #define LPSS_PRIV_CLOCK_GATE 0x38
-#define LPSS_PRIV_CLOCK_GATE_CLK_CTL_MASK 0x3
-#define LPSS_PRIV_CLOCK_GATE_CLK_CTL_FORCE_ON 0x3
+#define LPSS_PRIV_CLOCK_GATE_CLK_CTL_MASK	0x3
+#define LPSS_PRIV_CLOCK_GATE_CLK_CTL_FORCE_ON	0x3
+#define LPSS_PRIV_CLOCK_GATE_CLK_CTL_FORCE_OFF	0x0
 
 struct lpss_config {
 	/* LPSS offset from drv_data->ioaddr */
@@ -321,6 +322,20 @@ static void __lpss_ssp_write_priv(struct driver_data *drv_data,
 	writel(value, drv_data->lpss_base + offset);
 }
 
+static bool __lpss_ssp_update_priv(struct driver_data *drv_data, unsigned int offset,
+				   u32 mask, u32 value)
+{
+	u32 new, curr;
+
+	curr = __lpss_ssp_read_priv(drv_data, offset);
+	new = (curr & ~mask) | (value & mask);
+	if (new == curr)
+		return false;
+
+	__lpss_ssp_write_priv(drv_data, offset, new);
+	return true;
+}
+
 /*
  * lpss_ssp_setup - perform LPSS SSP specific setup
  * @drv_data: pointer to the driver private data
@@ -337,21 +352,16 @@ static void lpss_ssp_setup(struct driver_data *drv_data)
 	drv_data->lpss_base = drv_data->ssp->mmio_base + config->offset;
 
 	/* Enable software chip select control */
-	value = __lpss_ssp_read_priv(drv_data, config->reg_cs_ctrl);
-	value &= ~(LPSS_CS_CONTROL_SW_MODE | LPSS_CS_CONTROL_CS_HIGH);
-	value |= LPSS_CS_CONTROL_SW_MODE | LPSS_CS_CONTROL_CS_HIGH;
-	__lpss_ssp_write_priv(drv_data, config->reg_cs_ctrl, value);
+	value = LPSS_CS_CONTROL_SW_MODE | LPSS_CS_CONTROL_CS_HIGH;
+	__lpss_ssp_update_priv(drv_data, config->reg_cs_ctrl, value, value);
 
 	/* Enable multiblock DMA transfers */
 	if (drv_data->controller_info->enable_dma) {
-		__lpss_ssp_write_priv(drv_data, config->reg_ssp, 1);
+		__lpss_ssp_update_priv(drv_data, config->reg_ssp, BIT(0), BIT(0));
 
 		if (config->reg_general >= 0) {
-			value = __lpss_ssp_read_priv(drv_data,
-						     config->reg_general);
-			value |= LPSS_GENERAL_REG_RXTO_HOLDOFF_DISABLE;
-			__lpss_ssp_write_priv(drv_data,
-					      config->reg_general, value);
+			value = LPSS_GENERAL_REG_RXTO_HOLDOFF_DISABLE;
+			__lpss_ssp_update_priv(drv_data, config->reg_general, value, value);
 		}
 	}
 }
@@ -361,30 +371,19 @@ static void lpss_ssp_select_cs(struct spi_device *spi,
 {
 	struct driver_data *drv_data =
 		spi_controller_get_devdata(spi->controller);
-	u32 value, cs;
+	u32 cs;
 
-	if (!config->cs_sel_mask)
+	cs = spi_get_chipselect(spi, 0) << config->cs_sel_shift;
+	if (!__lpss_ssp_update_priv(drv_data, config->reg_cs_ctrl, config->cs_sel_mask, cs))
 		return;
 
-	value = __lpss_ssp_read_priv(drv_data, config->reg_cs_ctrl);
-
-	cs = spi_get_chipselect(spi, 0);
-	cs <<= config->cs_sel_shift;
-	if (cs != (value & config->cs_sel_mask)) {
-		/*
-		 * When switching another chip select output active the
-		 * output must be selected first and wait 2 ssp_clk cycles
-		 * before changing state to active. Otherwise a short
-		 * glitch will occur on the previous chip select since
-		 * output select is latched but state control is not.
-		 */
-		value &= ~config->cs_sel_mask;
-		value |= cs;
-		__lpss_ssp_write_priv(drv_data,
-				      config->reg_cs_ctrl, value);
-		ndelay(1000000000 /
-		       (drv_data->controller->max_speed_hz / 2));
-	}
+	/*
+	 * When switching another chip select output active the output must be
+	 * selected first and wait 2 ssp_clk cycles before changing state to
+	 * active. Otherwise a short glitch will occur on the previous chip
+	 * select since output select is latched but state control is not.
+	 */
+	ndelay(1000000000 / (drv_data->controller->max_speed_hz / 2));
 }
 
 static void lpss_ssp_cs_control(struct spi_device *spi, bool enable)
@@ -392,34 +391,27 @@ static void lpss_ssp_cs_control(struct spi_device *spi, bool enable)
 	struct driver_data *drv_data =
 		spi_controller_get_devdata(spi->controller);
 	const struct lpss_config *config;
-	u32 value;
+	u32 mask;
 
 	config = lpss_get_config(drv_data);
 
 	if (enable)
 		lpss_ssp_select_cs(spi, config);
 
-	value = __lpss_ssp_read_priv(drv_data, config->reg_cs_ctrl);
-	if (enable)
-		value &= ~LPSS_CS_CONTROL_CS_HIGH;
-	else
-		value |= LPSS_CS_CONTROL_CS_HIGH;
-	__lpss_ssp_write_priv(drv_data, config->reg_cs_ctrl, value);
+	mask = LPSS_CS_CONTROL_CS_HIGH;
+	__lpss_ssp_update_priv(drv_data, config->reg_cs_ctrl, mask, enable ? mask : 0);
 	if (config->cs_clk_stays_gated) {
-		u32 clkgate;
-
 		/*
 		 * Changing CS alone when dynamic clock gating is on won't
 		 * actually flip CS at that time. This ruins SPI transfers
 		 * that specify delays, or have no data. Toggle the clock mode
 		 * to force on briefly to poke the CS pin to move.
 		 */
-		clkgate = __lpss_ssp_read_priv(drv_data, LPSS_PRIV_CLOCK_GATE);
-		value = (clkgate & ~LPSS_PRIV_CLOCK_GATE_CLK_CTL_MASK) |
-			LPSS_PRIV_CLOCK_GATE_CLK_CTL_FORCE_ON;
-
-		__lpss_ssp_write_priv(drv_data, LPSS_PRIV_CLOCK_GATE, value);
-		__lpss_ssp_write_priv(drv_data, LPSS_PRIV_CLOCK_GATE, clkgate);
+		mask = LPSS_PRIV_CLOCK_GATE_CLK_CTL_MASK;
+		if (__lpss_ssp_update_priv(drv_data, LPSS_PRIV_CLOCK_GATE, mask,
+					   LPSS_PRIV_CLOCK_GATE_CLK_CTL_FORCE_ON))
+			__lpss_ssp_update_priv(drv_data, LPSS_PRIV_CLOCK_GATE, mask,
+					       LPSS_PRIV_CLOCK_GATE_CLK_CTL_FORCE_OFF);
 	}
 }
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


