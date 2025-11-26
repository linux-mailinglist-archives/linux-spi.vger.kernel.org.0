Return-Path: <linux-spi+bounces-11561-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A8DC8885C
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 08:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A23B3B4CD3
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 07:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C329E2E5429;
	Wed, 26 Nov 2025 07:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mHqGpUNj"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3E028DB71;
	Wed, 26 Nov 2025 07:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764143766; cv=none; b=KJzlTZosDy6Rg33pxvk/w+KLwknaaxJKnM0Q4VqEu4Sq+RbKk7Sq+rZdLjTmdMJepUzTAz1vz7l7r3S3pCp53SrJRE1IzKJL7VdlP8/SoIAqPyP0pKFAog6/RGDGDSFf0Rm4L17Vy3QIyE7HvIEGFuWfExP81P9+R3tYJ8Yw7SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764143766; c=relaxed/simple;
	bh=VU63BbmLmgOChGLd4KlK5mlVcUccPkxsI1Udw+sJqGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cGekvlYIIblth7dWR7YYSBPW+nB0kHPzF5l//3y3f7lIUoO985m+oIKp9FYS76cZb8wtQ/4IkKCd02i0dgh8rGWQ7tEtt/Ue4/n0WDbz0W6MwLjyQwyMY0q7inPY5UxcHhxURA1DuDTQNDKrc9RwUPbf3buoHZz8c3e79DmfByg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mHqGpUNj; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764143765; x=1795679765;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VU63BbmLmgOChGLd4KlK5mlVcUccPkxsI1Udw+sJqGA=;
  b=mHqGpUNjyGxqVdBPcSJoS4umLDdOuDv2QTjaOLfnr0csDRwT5vNPvZTk
   PSi7by1oiUvhiJnmMq9SBCg3GGwUlCSVa/oM9xDBSuMo/XpqTSyrjbxBp
   kiOdAGe0PlWMHDDrjZYTrRRgkL/nmLOtT3rRqsW0T/Uf7ZVk2dhcncoTi
   iPMnGMFQnrL8Ga73LREfl2KQqkw+kUKT8dsE588KsDiyhwiH2p63nLTyd
   qzoyn+iQlpriip9SrkVaR2GkW7bMYovCaTQbObeMx2v/mLtytJhZ94E56
   AUh9eX/s/6U5Aw5yUnEBPbSJHUsOLGxORXVmhW4/UeGKgsKf0dZ6Hxfq1
   Q==;
X-CSE-ConnectionGUID: /gabddMlS2eXtZwmRHLesg==
X-CSE-MsgGUID: fGqy2y/RQsmLLh51r/kfpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="65360565"
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="scan'208";a="65360565"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 23:56:02 -0800
X-CSE-ConnectionGUID: nlaN5+TrTCiUEt7QQSpLpA==
X-CSE-MsgGUID: mQEBwfZMQuWML/B3RnNwmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="scan'208";a="192006618"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 25 Nov 2025 23:56:02 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 28818A4; Wed, 26 Nov 2025 08:56:00 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 4/6] spi: microchip-core: Utilise temporary variable for struct device
Date: Wed, 26 Nov 2025 08:54:42 +0100
Message-ID: <20251126075558.2035012-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251126075558.2035012-1-andriy.shevchenko@linux.intel.com>
References: <20251126075558.2035012-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a temporary variable to keep a pointer to struct device.
Utilise it where it makes sense.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-microchip-core-spi.c | 44 +++++++++++++---------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-microchip-core-spi.c b/drivers/spi/spi-microchip-core-spi.c
index 8ea382c6fee7..0dca46dcdc2f 100644
--- a/drivers/spi/spi-microchip-core-spi.c
+++ b/drivers/spi/spi-microchip-core-spi.c
@@ -284,6 +284,7 @@ static int mchp_corespi_transfer_one(struct spi_controller *host,
 static int mchp_corespi_probe(struct platform_device *pdev)
 {
 	const char *protocol = "motorola";
+	struct device *dev = &pdev->dev;
 	struct spi_controller *host;
 	struct mchp_corespi *spi;
 	struct resource *res;
@@ -291,13 +292,13 @@ static int mchp_corespi_probe(struct platform_device *pdev)
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
@@ -305,12 +306,12 @@ static int mchp_corespi_probe(struct platform_device *pdev)
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
 
@@ -318,11 +319,11 @@ static int mchp_corespi_probe(struct platform_device *pdev)
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
@@ -330,9 +331,9 @@ static int mchp_corespi_probe(struct platform_device *pdev)
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
 
@@ -342,9 +343,9 @@ static int mchp_corespi_probe(struct platform_device *pdev)
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
@@ -356,9 +357,9 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 	host->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
 	host->transfer_one = mchp_corespi_transfer_one;
 	host->set_cs = mchp_corespi_set_cs;
-	host->dev.of_node = pdev->dev.of_node;
+	host->dev.of_node = dev->of_node;
 
-	ret = of_property_read_u32(pdev->dev.of_node, "fifo-depth", &spi->fifo_depth);
+	ret = of_property_read_u32(dev->of_node, "fifo-depth", &spi->fifo_depth);
 	if (ret)
 		spi->fifo_depth = MCHP_CORESPI_DEFAULT_FIFO_DEPTH;
 
@@ -370,24 +371,21 @@ static int mchp_corespi_probe(struct platform_device *pdev)
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


