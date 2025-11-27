Return-Path: <linux-spi+bounces-11638-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D89E9C8FF71
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 20:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8AF0E4E5F40
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 19:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3383043B0;
	Thu, 27 Nov 2025 19:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q3EuHD39"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C1A2EC08C;
	Thu, 27 Nov 2025 19:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764270039; cv=none; b=nAewaKr5Vzf0TZL5izQbQmgsYZz+RLyPA6NDBlk7+bpcgFX8l8tchfxHWSEEZxrjn7QEmR2PQsn1BHz3Yvz2H/OQ094vmuLsEbL9Xa5uM2SGvN/xw+hULRS73jshnIaCdcEn39N+HVNPNqHSJkT1WqYdxA8eaw3ahsD1bwTwVKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764270039; c=relaxed/simple;
	bh=F6dY4g5b095vmulQz6TtHxeicjOX2tjh0n6p49QTNSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kteZmdAeqvya/rM2FAPFLaWZayPWn/tUx+gv2k7tI6MSURhWXOymTXhnZV2UnaiiVdQmV9du88Wlp38jSMP3xV/AFr7LzBXofhDi+2vvgXO36SH3Ivqgy9QtERW3gnLGeKm223+yw4znDhpCPvpKWStmWujEDxTqlKufXoDRBD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q3EuHD39; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764270037; x=1795806037;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F6dY4g5b095vmulQz6TtHxeicjOX2tjh0n6p49QTNSo=;
  b=Q3EuHD39D3aCavt5x5Pgi3N6R1Yo1M4BTSNQn++fUBPS/S+svRcv/KjR
   2k2wF9qw34K8Ep8Bihv6WE23W7fodhoTJW+BR4z9A449dQCufwn9hzgjO
   WokRObhK2NW3YjxrKiQC73MXTN56JCQ7eid+4g0/7boG4iLDDiIDFQHF/
   vRWjPjsoSeqQlMwmfGZOeVs0TbR7i1gE6jdrO7+FOeRfpGd6Hk4o9BrtG
   h8//uxY1p0HHPBRSjIO37hWnAjuMBblebLQjdcu6yycyRlLcnUY0SfsoW
   fyt/cZfKxK2HPOIvf2vClgWYPGH9o6f4R+bNwwYKyD6GstNnwUg/z+Gzo
   w==;
X-CSE-ConnectionGUID: fCMtGKNNRoKZvZj03XyKqA==
X-CSE-MsgGUID: cMOZZ+QsSMysi2hlRWNr/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="66480307"
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="66480307"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 11:00:35 -0800
X-CSE-ConnectionGUID: gKzQ6W2hQAObozTdva2saA==
X-CSE-MsgGUID: blVabnGbSs+WCNQYfb//lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="193312319"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 27 Nov 2025 11:00:33 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 45B83A3; Thu, 27 Nov 2025 20:00:32 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 4/6] spi: microchip-core: Utilise temporary variable for struct device
Date: Thu, 27 Nov 2025 19:59:01 +0100
Message-ID: <20251127190031.2998705-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251127190031.2998705-1-andriy.shevchenko@linux.intel.com>
References: <20251127190031.2998705-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a temporary variable to keep a pointer to struct device.
Utilise it where it makes sense.

Reviewed-by: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-microchip-core-spi.c | 44 +++++++++++++---------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-microchip-core-spi.c b/drivers/spi/spi-microchip-core-spi.c
index fa6fb2d3f7d0..0ece51460ee0 100644
--- a/drivers/spi/spi-microchip-core-spi.c
+++ b/drivers/spi/spi-microchip-core-spi.c
@@ -289,6 +289,7 @@ static int mchp_corespi_transfer_one(struct spi_controller *host,
 static int mchp_corespi_probe(struct platform_device *pdev)
 {
 	const char *protocol = "motorola";
+	struct device *dev = &pdev->dev;
 	struct spi_controller *host;
 	struct mchp_corespi *spi;
 	struct resource *res;
@@ -296,13 +297,13 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 	bool assert_ssel;
 	int ret = 0;
 
-	host = devm_spi_alloc_host(&pdev->dev, sizeof(*spi));
+	host = devm_spi_alloc_host(dev, sizeof(*spi));
 	if (!host)
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, host);
 
-	if (of_property_read_u32(pdev->dev.of_node, "num-cs", &num_cs))
+	if (of_property_read_u32(dev->of_node, "num-cs", &num_cs))
 		num_cs = MCHP_CORESPI_MAX_CS;
 
 	/*
@@ -310,12 +311,12 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 	 * CoreSPI can be configured for Motorola, TI or NSC.
 	 * The current driver supports only Motorola mode.
 	 */
-	ret = of_property_read_string(pdev->dev.of_node, "microchip,protocol-configuration",
+	ret = of_property_read_string(dev->of_node, "microchip,protocol-configuration",
 				      &protocol);
 	if (ret && ret != -EINVAL)
-		return dev_err_probe(&pdev->dev, ret, "Error reading protocol-configuration\n");
+		return dev_err_probe(dev, ret, "Error reading protocol-configuration\n");
 	if (strcmp(protocol, "motorola") != 0)
-		return dev_err_probe(&pdev->dev, -EINVAL,
+		return dev_err_probe(dev, -EINVAL,
 				     "CoreSPI: protocol '%s' not supported by this driver\n",
 				      protocol);
 
@@ -323,11 +324,11 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 	 * Motorola mode (0-3): CFG_MOT_MODE
 	 * Mode is fixed in the IP configurator.
 	 */
-	ret = of_property_read_u32(pdev->dev.of_node, "microchip,motorola-mode", &mode);
+	ret = of_property_read_u32(dev->of_node, "microchip,motorola-mode", &mode);
 	if (ret)
 		mode = MCHP_CORESPI_DEFAULT_MOTOROLA_MODE;
 	else if (mode > 3)
-		return dev_err_probe(&pdev->dev, -EINVAL,
+		return dev_err_probe(dev, -EINVAL,
 				     "invalid 'microchip,motorola-mode' value %u\n", mode);
 
 	/*
@@ -335,9 +336,9 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 	 * The hardware allows frame sizes <= APB data width.
 	 * However, this driver currently only supports 8-bit frames.
 	 */
-	ret = of_property_read_u32(pdev->dev.of_node, "microchip,frame-size", &frame_size);
+	ret = of_property_read_u32(dev->of_node, "microchip,frame-size", &frame_size);
 	if (!ret && frame_size != 8)
-		return dev_err_probe(&pdev->dev, -EINVAL,
+		return dev_err_probe(dev, -EINVAL,
 				     "CoreSPI: frame size %u not supported by this driver\n",
 				     frame_size);
 
@@ -347,9 +348,9 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 	 * To prevent CS deassertion when TX FIFO drains, the ssel-active property
 	 * keeps CS asserted for the full SPI transfer.
 	 */
-	assert_ssel = of_property_read_bool(pdev->dev.of_node, "microchip,ssel-active");
+	assert_ssel = of_property_read_bool(dev->of_node, "microchip,ssel-active");
 	if (!assert_ssel)
-		return dev_err_probe(&pdev->dev, -EINVAL,
+		return dev_err_probe(dev, -EINVAL,
 				     "hardware must enable 'microchip,ssel-active' to keep CS asserted for the SPI transfer\n");
 
 	spi = spi_controller_get_devdata(host);
@@ -361,9 +362,9 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 	host->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
 	host->transfer_one = mchp_corespi_transfer_one;
 	host->set_cs = mchp_corespi_set_cs;
-	host->dev.of_node = pdev->dev.of_node;
+	host->dev.of_node = dev->of_node;
 
-	ret = of_property_read_u32(pdev->dev.of_node, "fifo-depth", &spi->fifo_depth);
+	ret = of_property_read_u32(dev->of_node, "fifo-depth", &spi->fifo_depth);
 	if (ret)
 		spi->fifo_depth = MCHP_CORESPI_DEFAULT_FIFO_DEPTH;
 
@@ -375,24 +376,21 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 	if (spi->irq < 0)
 		return spi->irq;
 
-	ret = devm_request_irq(&pdev->dev, spi->irq, mchp_corespi_interrupt,
-			       IRQF_SHARED, dev_name(&pdev->dev), host);
+	ret = devm_request_irq(dev, spi->irq, mchp_corespi_interrupt, IRQF_SHARED,
+			       dev_name(dev), host);
 	if (ret)
-		return dev_err_probe(&pdev->dev, ret,
-				     "could not request irq\n");
+		return dev_err_probe(dev, ret, "could not request irq\n");
 
-	spi->clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	spi->clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(spi->clk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(spi->clk),
-				     "could not get clk\n");
+		return dev_err_probe(dev, PTR_ERR(spi->clk), "could not get clk\n");
 
 	mchp_corespi_init(host, spi);
 
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = devm_spi_register_controller(dev, host);
 	if (ret) {
 		mchp_corespi_disable(spi);
-		return dev_err_probe(&pdev->dev, ret,
-				     "unable to register host for CoreSPI controller\n");
+		return dev_err_probe(dev, ret, "unable to register host for CoreSPI controller\n");
 	}
 
 	return 0;
-- 
2.50.1


