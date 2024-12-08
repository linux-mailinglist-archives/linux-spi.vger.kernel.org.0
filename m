Return-Path: <linux-spi+bounces-5968-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E869E9E8795
	for <lists+linux-spi@lfdr.de>; Sun,  8 Dec 2024 20:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10C7F1644D7
	for <lists+linux-spi@lfdr.de>; Sun,  8 Dec 2024 19:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B505F19340D;
	Sun,  8 Dec 2024 19:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jxfk+hO9"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19BD18A93E;
	Sun,  8 Dec 2024 19:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733687803; cv=none; b=gqtYw2xBBD4U0S8rxFh9D+VUNiL2PqtVrsp/7p/IW8OXLx1VUcMuarUAUpo5Akh9BisLq5Mhr0m1dIxd11gmqpVxflugwgdvPw48Yq2Tda94K+vKXQ5BrOzTolzL1ZAXhmEpuNSWyOFoQojOcChNis6SvszfUQ6ycitwkyFDLKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733687803; c=relaxed/simple;
	bh=0V3kjDeuaXyCGAiMZk3GYRd80BPU7mnH1p0Q8+H9N2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZivtWDNuGE1+HYR5jUE8DGUd7pndSooSVzEHuMkCHsngE5FZa3Reoc1h3MbQn0mkrFQdNM2/Qrm2vpUIZVOVS6LmMgtDbHK9g9YXI/lYfQHf1cQ6BhXRmgbJ3eCaCtL+RETHwJu9dsX18XTx9nixaG861+xYJspHGqRPG98WLPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jxfk+hO9; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733687802; x=1765223802;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0V3kjDeuaXyCGAiMZk3GYRd80BPU7mnH1p0Q8+H9N2c=;
  b=Jxfk+hO9u5XNOhai83cRGwkT6831ojCHAp+o8ydK4WzsmebdyG7yxJ/R
   HZT+auL6Kjwj8LxDUSLad2MzGWH+17ydU4FNdpp1esUZyFchRcW6HEGWN
   LGkYaxE5WhKvKQvGzIex5RWGcGSD8g1WxJns3ZKZQl5SWuFt6uyAuVOBR
   3HTiRZI9B/I5cNwfo6OGeIFF87zdgclxcQX45AWhnClmwftnx/cy/ofN+
   a81vixibKnLAb2nnAV1Z+iCK98zGhMCKJeeBAx4IkGi7s5ZDu7ZLQcXpd
   e3PPkN5oPKA/1pJqglHvxTnPTwhU/EL17vHzWu9c+y7Oin3WTtrKuEJOQ
   A==;
X-CSE-ConnectionGUID: POFPQiV1RVS8nnoRRj5Pbw==
X-CSE-MsgGUID: uln0Rc1lTkyv94A5+Es8gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="45384105"
X-IronPort-AV: E=Sophos;i="6.12,217,1728975600"; 
   d="scan'208";a="45384105"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 11:56:39 -0800
X-CSE-ConnectionGUID: 87hDcPG2TqChVpnn3QPeQg==
X-CSE-MsgGUID: so+Pf/F6QvK8g5HE5byVOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,217,1728975600"; 
   d="scan'208";a="99332654"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 08 Dec 2024 11:56:38 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 0BA6393; Sun, 08 Dec 2024 21:56:36 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] spi: Unify firmware node type checks
Date: Sun,  8 Dec 2024 18:03:16 +0200
Message-ID: <20241208195635.1271656-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241208195635.1271656-1-andriy.shevchenko@linux.intel.com>
References: <20241208195635.1271656-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The few functions are using different approaches on how to check for
the type of firmware node. Unify them to use a modern way of it.

With that in place it becomes obvious that no need to have independent
conditionals when they are dependent and hence the code generation can
be improved a little bit (clang-18, x86_64):

  add/remove: 0/0 grow/shrink: 2/2 up/down: 16/-46 (-30)
  Total: Before=49801, After=49771, chg -0.06%

Meanwhile no functional changes intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ff1add2ecb91..88f785b9e6ec 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -410,24 +410,21 @@ static int spi_probe(struct device *dev)
 {
 	const struct spi_driver		*sdrv = to_spi_driver(dev->driver);
 	struct spi_device		*spi = to_spi_device(dev);
+	struct fwnode_handle		*fwnode = dev_fwnode(dev);
 	int ret;
 
 	ret = of_clk_set_defaults(dev->of_node, false);
 	if (ret)
 		return ret;
 
-	if (dev->of_node) {
+	if (is_of_node(fwnode)) {
 		spi->irq = of_irq_get(dev->of_node, 0);
 		if (spi->irq == -EPROBE_DEFER)
 			return dev_err_probe(dev, -EPROBE_DEFER, "Failed to get irq\n");
 		if (spi->irq < 0)
 			spi->irq = 0;
-	}
-
-	if (has_acpi_companion(dev) && spi->irq < 0) {
-		struct acpi_device *adev = to_acpi_device_node(dev->fwnode);
-
-		spi->irq = acpi_dev_gpio_irq_get(adev, 0);
+	} else if (is_acpi_device_node(fwnode) && spi->irq < 0) {
+		spi->irq = acpi_dev_gpio_irq_get(to_acpi_device_node(fwnode), 0);
 		if (spi->irq == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
 		if (spi->irq < 0)
@@ -874,15 +871,18 @@ EXPORT_SYMBOL_GPL(spi_new_device);
  */
 void spi_unregister_device(struct spi_device *spi)
 {
+	struct fwnode_handle *fwnode;
+
 	if (!spi)
 		return;
 
-	if (spi->dev.of_node) {
-		of_node_clear_flag(spi->dev.of_node, OF_POPULATED);
-		of_node_put(spi->dev.of_node);
+	fwnode = dev_fwnode(&spi->dev);
+	if (is_of_node(fwnode)) {
+		of_node_clear_flag(to_of_node(fwnode), OF_POPULATED);
+		of_node_put(to_of_node(fwnode));
+	} else if (is_acpi_device_node(fwnode)) {
+		acpi_device_clear_enumerated(to_acpi_device_node(fwnode));
 	}
-	if (ACPI_COMPANION(&spi->dev))
-		acpi_device_clear_enumerated(ACPI_COMPANION(&spi->dev));
 	device_remove_software_node(&spi->dev);
 	device_del(&spi->dev);
 	spi_cleanup(spi);
@@ -1059,7 +1059,7 @@ static void spi_toggle_csgpiod(struct spi_device *spi, u8 idx, bool enable, bool
 	 * ambiguity. That's why we use enable, that takes SPI_CS_HIGH
 	 * into account.
 	 */
-	if (has_acpi_companion(&spi->dev))
+	if (is_acpi_device_node(dev_fwnode(&spi->dev)))
 		gpiod_set_value_cansleep(spi_get_csgpiod(spi, idx), !enable);
 	else
 		/* Polarity handled by GPIO library */
@@ -4841,7 +4841,7 @@ extern struct notifier_block spi_of_notifier;
 #if IS_ENABLED(CONFIG_ACPI)
 static int spi_acpi_controller_match(struct device *dev, const void *data)
 {
-	return ACPI_COMPANION(dev->parent) == data;
+	return device_match_acpi_dev(dev->parent, data);
 }
 
 struct spi_controller *acpi_spi_find_controller_by_adev(struct acpi_device *adev)
-- 
2.43.0.rc1.1336.g36b5255a03ac


