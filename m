Return-Path: <linux-spi+bounces-11539-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32038C86FCF
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 21:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43DCE3AFEAA
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 20:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B7433CEA4;
	Tue, 25 Nov 2025 20:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hKOFPxSQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB98933BBA7;
	Tue, 25 Nov 2025 20:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764101829; cv=none; b=nsJM9IsP4+DscyzM/l6z3JqUqLY5VRZcayW88QjZGXLRD3yD02NRXsqKnX2/MMfKrK5Qe+pDyXU/frCE9SF9izLYz+vZg3RVL9msGNKIb2hENTBd5MG8CGaUzzoxX6j3Zlk869m6tm7KVaCXRoxk7i4N6TTa4QX9PgUjsbljTLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764101829; c=relaxed/simple;
	bh=d4PsKh6CfSpqCwuGvqiqnLvYump1yPnP29Hq84e6xbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxfcj50WMgRsDwX4ogbvl95pyA7frHbX4djnky6S3rKPTiZZhjA38LqCXlGnylL40+iy/tzhjadk8hkOdQDU6sT/cNtLibaIMC4W8Xaziyi5Kkh5k5sSXFRl+Qwkh59qmN//2jIjL7FMBSKmhWCsPWHgtHv0Iq0TQueySqY3FOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hKOFPxSQ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764101828; x=1795637828;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d4PsKh6CfSpqCwuGvqiqnLvYump1yPnP29Hq84e6xbw=;
  b=hKOFPxSQECO9nC0ArxNIDEmFFIN5nWSeKG+Ic8oSs9GtVs+DMOlMKJqj
   GLnW7pF4bwPHMitG3naYa/SDu5fkYI/UgjqBQ5GJdtAnNrZMnIU0RGo0H
   Cetx8VFPFE/B3vyl86VbOcQEGKyRhGEekze4KARjHa5NJB/OweJfksSo8
   YfyYkKYlN+LV20gdH9q4VIZuXWqPqBCsNHtRKgvyXXByItIozYGdOqqBW
   /9jA9+b0xeZNDu373V8xwRKFsI+m5cjHQgQKx2JevYzEuhuJpV/qzGQZ9
   IWveZ9ANNk5Ss/CpFUKO6k8KjqQw+DdxjNclwC6eHAacQKyiDIP0YX3ed
   w==;
X-CSE-ConnectionGUID: Ry3swFX7Qh2/vpJxASdDZQ==
X-CSE-MsgGUID: OxJw/Vc+R5yHqqnQfQwLtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="53699533"
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="53699533"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 12:17:07 -0800
X-CSE-ConnectionGUID: JvFPd3MgSBywod2MiG1YfA==
X-CSE-MsgGUID: gYvEP7leTEmX8NuU7DKh0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="192836181"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 25 Nov 2025 12:17:05 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 5751BA5; Tue, 25 Nov 2025 21:17:02 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 5/7] spi: microchip-core: Utilise temporary variable for struct device
Date: Tue, 25 Nov 2025 21:15:35 +0100
Message-ID: <20251125201700.1901959-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251125201700.1901959-1-andriy.shevchenko@linux.intel.com>
References: <20251125201700.1901959-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have a temporary variable to keep a pointer to struct device.
Utilise it where it makes sense.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-microchip-core-spi.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-microchip-core-spi.c b/drivers/spi/spi-microchip-core-spi.c
index dbbfb395c272..68b136157fac 100644
--- a/drivers/spi/spi-microchip-core-spi.c
+++ b/drivers/spi/spi-microchip-core-spi.c
@@ -293,7 +293,7 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 	bool assert_ssel;
 	int ret = 0;
 
-	host = devm_spi_alloc_host(&pdev->dev, sizeof(*spi));
+	host = devm_spi_alloc_host(dev, sizeof(*spi));
 	if (!host)
 		return -ENOMEM;
 
@@ -322,7 +322,7 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 	if (ret)
 		mode = MCHP_CORESPI_DEFAULT_MOTOROLA_MODE;
 	else if (mode > 3)
-		return dev_err_probe(&pdev->dev, -EINVAL,
+		return dev_err_probe(dev, -EINVAL,
 				     "invalid 'microchip,motorola-mode' value %u\n", mode);
 
 	/*
@@ -332,7 +332,7 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 	 */
 	ret = device_property_read_u32(dev, "microchip,frame-size", &frame_size);
 	if (!ret && frame_size != 8)
-		return dev_err_probe(&pdev->dev, -EINVAL,
+		return dev_err_probe(dev, -EINVAL,
 				     "CoreSPI: frame size %u not supported by this driver\n",
 				     frame_size);
 
@@ -344,7 +344,7 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 	 */
 	assert_ssel = device_property_read_bool(dev, "microchip,ssel-active");
 	if (!assert_ssel)
-		return dev_err_probe(&pdev->dev, -EINVAL,
+		return dev_err_probe(dev, -EINVAL,
 				     "hardware must enable 'microchip,ssel-active' to keep CS asserted for the SPI transfer\n");
 
 	spi = spi_controller_get_devdata(host);
@@ -371,24 +371,21 @@ static int mchp_corespi_probe(struct platform_device *pdev)
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


