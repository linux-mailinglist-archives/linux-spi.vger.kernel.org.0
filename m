Return-Path: <linux-spi+bounces-2925-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2647F8C8CEC
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 21:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D630628543E
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 19:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C18D1411E9;
	Fri, 17 May 2024 19:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hi4beZuA"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D887140374;
	Fri, 17 May 2024 19:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715974974; cv=none; b=jeOqM8n+WZ/oa6U/Ey6tax47X2N+ahwVlPiPqO3BEkIllyiP7lTNa1mrEop6/+aoWdzmJiNvLPWpNTJwkpSjgo/NnFk/oobzUFuI5UVUXgwYIZzfPxhf/K1QwJpWKzXvsuUWAzjS3GzbVrvlb4H3tWwVl36qTayqX52H9WlHlZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715974974; c=relaxed/simple;
	bh=mNrq6bM6WjtCihUhoILAJJMc4Q5aBcdCL+ohBoGOtxs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gTwvUiJXuDMYaoH1VtFgPDe73r2NBVLVChOi+YjqEIx2R1QQhFHK78N4xd3ySQy4ABRyE/+ZGGd6LWB4Br7OpNg0m/9VBCnNw1NM/tcsvs3UE/J4maV+walx7wSgdvqiTgt/QfTWx0AUe19Jg3/D8xfDs2P7cueWzF7HjHWHkxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hi4beZuA; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715974972; x=1747510972;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=mNrq6bM6WjtCihUhoILAJJMc4Q5aBcdCL+ohBoGOtxs=;
  b=hi4beZuA69WWXjslrbHgLKwB5Sbd0TTF4hiO320rcJm1FHO9H2FcvXLu
   8GKLEoYzXMP2G+9lFESDMmJaFfiW1uuGzUWB2NaoMWPHmom8tJKnykxQT
   Y911dwYIIxznnRCihT2nnFaj+IlrH34+2cpezGdGl88tih44xINa7A+os
   lZFputwfnl8AnUXVQNZAQXzmnCTGHpNDEqnmZ58TjvFCPVhDGmpY8pxxf
   kA9C5vf/1HRLHXUl/OscQutiLeqe/0hqDgGpZK81uybPPUcDnkJvidmGS
   FU37iAH1IDhreg03KwPHoQwO6PqHQ2+y3+VsTIBFYVcFFiryYzqajlr9t
   g==;
X-CSE-ConnectionGUID: 13AMwrsLTcam47HMQEQE5w==
X-CSE-MsgGUID: u+y5xakwRYyAFSKpXhQ3Ag==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="12284441"
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="12284441"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 12:42:50 -0700
X-CSE-ConnectionGUID: 1zXn1NLrRSSi4cIybbQj7Q==
X-CSE-MsgGUID: LFC95adQRt+5hFgJRvo9XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="31877129"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 17 May 2024 12:42:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 59707118; Fri, 17 May 2024 22:42:47 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] spi: gpio: Make use of device properties
Date: Fri, 17 May 2024 22:42:01 +0300
Message-ID: <20240517194246.747427-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240517194246.747427-1-andriy.shevchenko@linux.intel.com>
References: <20240517194246.747427-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the module to be property provider agnostic and allow
it to be used on non-OF platforms.

Include mod_devicetable.h explicitly to replace the dropped of.h
which included mod_devicetable.h indirectly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-gpio.c | 51 +++++++++++++++---------------------------
 1 file changed, 18 insertions(+), 33 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 909cce109bba..abf426711c22 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -5,17 +5,17 @@
  * Copyright (C) 2006,2008 David Brownell
  * Copyright (C) 2017 Linus Walleij
  */
+#include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/gpio/consumer.h>
-#include <linux/of.h>
+#include <linux/property.h>
 
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
 #include <linux/spi/spi_gpio.h>
 
-
 /*
  * This bitbanging SPI host driver should help make systems usable
  * when a native hardware SPI engine is not available, perhaps because
@@ -326,29 +326,6 @@ static int spi_gpio_request(struct device *dev, struct spi_gpio *spi_gpio)
 	return PTR_ERR_OR_ZERO(spi_gpio->sck);
 }
 
-#ifdef CONFIG_OF
-static const struct of_device_id spi_gpio_dt_ids[] = {
-	{ .compatible = "spi-gpio" },
-	{}
-};
-MODULE_DEVICE_TABLE(of, spi_gpio_dt_ids);
-
-static int spi_gpio_probe_dt(struct platform_device *pdev,
-			     struct spi_controller *host)
-{
-	host->dev.of_node = pdev->dev.of_node;
-	host->use_gpio_descriptors = true;
-
-	return 0;
-}
-#else
-static inline int spi_gpio_probe_dt(struct platform_device *pdev,
-				    struct spi_controller *host)
-{
-	return 0;
-}
-#endif
-
 static int spi_gpio_probe_pdata(struct platform_device *pdev,
 				struct spi_controller *host)
 {
@@ -389,19 +366,21 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	struct spi_controller		*host;
 	struct spi_gpio			*spi_gpio;
 	struct device			*dev = &pdev->dev;
+	struct fwnode_handle		*fwnode = dev_fwnode(dev);
 	struct spi_bitbang		*bb;
 
 	host = devm_spi_alloc_host(dev, sizeof(*spi_gpio));
 	if (!host)
 		return -ENOMEM;
 
-	if (pdev->dev.of_node)
-		status = spi_gpio_probe_dt(pdev, host);
-	else
+	if (fwnode) {
+		device_set_node(&host->dev, fwnode);
+		host->use_gpio_descriptors = true;
+	} else {
 		status = spi_gpio_probe_pdata(pdev, host);
-
-	if (status)
-		return status;
+		if (status)
+			return status;
+	}
 
 	spi_gpio = spi_controller_get_devdata(host);
 
@@ -459,10 +438,16 @@ static int spi_gpio_probe(struct platform_device *pdev)
 
 MODULE_ALIAS("platform:" DRIVER_NAME);
 
+static const struct of_device_id spi_gpio_dt_ids[] = {
+	{ .compatible = "spi-gpio" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, spi_gpio_dt_ids);
+
 static struct platform_driver spi_gpio_driver = {
 	.driver = {
 		.name	= DRIVER_NAME,
-		.of_match_table = of_match_ptr(spi_gpio_dt_ids),
+		.of_match_table = spi_gpio_dt_ids,
 	},
 	.probe		= spi_gpio_probe,
 };
-- 
2.43.0.rc1.1336.g36b5255a03ac


