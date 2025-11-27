Return-Path: <linux-spi+bounces-11641-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B22FC90106
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 20:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 54B824E1EC1
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 19:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C204B306D57;
	Thu, 27 Nov 2025 19:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RB7RX52C"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C91D306D3F;
	Thu, 27 Nov 2025 19:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764273099; cv=none; b=U880TOABRYg2SaTib1yA54jTfXcUbcd6N0BcgBxxY2QV80+WypfqL18gK2P4Ap4tcvF/ig2zySn7lrnyzSjKuaBi3GdqqwhGk4sMYYAjjzWW37BZN1HtKbAkr2aG56W5q0zsPmRWnWETlNfHHEDpV6kdcANfiqhfB9PHzSOuffE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764273099; c=relaxed/simple;
	bh=qgP7x8MJ0SpokdvBI4OSJ/JKazgSw57rAVlB0itHY7o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RgttiWJl6UX4BFX234dQqlw+KVCbo6t9tSumg4z0N+WIvWKnjPu/1JCdwJrAn4zOg0vC6D6D22V6nSEn5A7qssymOYJZ83LHKb2PLxQ/JPi78pJyW9waDKI53BRGBLivBzEjAISaNmpsFm3ctY+WThOrX6z6JiAW+HSIvnapVas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RB7RX52C; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764273097; x=1795809097;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qgP7x8MJ0SpokdvBI4OSJ/JKazgSw57rAVlB0itHY7o=;
  b=RB7RX52CT09U/udO7sZmVPiGOAzbHpyvt9K+Xb9iLZLKm+8sc1ymKnUV
   h6jFwa56FRGoyoMQX1SEPrkQ66DCqbSx/P/JuO50YBwkZK48MlVS25tzZ
   Y25vwPMpcvA/7OWKm6VfQqldfJh7E2QGoDQUhn1MnJl3XWFfp20IR7tYR
   cjD7nt7IupzBJHQUqkcJ2CkUq31ukx0BG3vXrW92PJEJOwH3ZGQec1dup
   /oQO9O29PhHAktlQL3MZSVGD2YyWwcTf6Rtx4tgE7ekQ2I4QDUVlirM4+
   uaO0kLYOAWmE7Brw1nN/TdJAyK1/pzn+5eJj7+nuAZbE2SL6NFbGcvfhW
   g==;
X-CSE-ConnectionGUID: M54GG8SITc+khfUeamZ6Gg==
X-CSE-MsgGUID: sT19sPblSn+DKjvZdiArTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="70185532"
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="70185532"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 11:51:37 -0800
X-CSE-ConnectionGUID: uLLGXYjPRJmva2qDBhadEw==
X-CSE-MsgGUID: aAaLJvkwTkmIDcoQtAmchg==
X-Ironport-Invalid-End-Of-Message: True
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="224000185"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP; 27 Nov 2025 11:51:36 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id B17159F; Thu, 27 Nov 2025 20:51:34 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] spi: Simplify devm_spi_*_controller()
Date: Thu, 27 Nov 2025 20:51:33 +0100
Message-ID: <20251127195133.3046173-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_add_action_or_reset() instead of devres_alloc() and
devres_add(), which works the same. This will simplify the
code. There is no functional changes.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c | 47 ++++++++++++++++++-----------------------------
 1 file changed, 18 insertions(+), 29 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 071f7d754931..0850734e6d50 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3058,9 +3058,9 @@ struct spi_controller *__spi_alloc_controller(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(__spi_alloc_controller);
 
-static void devm_spi_release_controller(struct device *dev, void *ctlr)
+static void devm_spi_release_controller(void *ctlr)
 {
-	spi_controller_put(*(struct spi_controller **)ctlr);
+	spi_controller_put(ctlr);
 }
 
 /**
@@ -3082,21 +3082,18 @@ struct spi_controller *__devm_spi_alloc_controller(struct device *dev,
 						   unsigned int size,
 						   bool target)
 {
-	struct spi_controller **ptr, *ctlr;
-
-	ptr = devres_alloc(devm_spi_release_controller, sizeof(*ptr),
-			   GFP_KERNEL);
-	if (!ptr)
-		return NULL;
+	struct spi_controller *ctlr;
+	int ret;
 
 	ctlr = __spi_alloc_controller(dev, size, target);
-	if (ctlr) {
-		ctlr->devm_allocated = true;
-		*ptr = ctlr;
-		devres_add(dev, ptr);
-	} else {
-		devres_free(ptr);
-	}
+	if (!ctlr)
+		return NULL;
+
+	ret = devm_add_action_or_reset(dev, devm_spi_release_controller, ctlr);
+	if (ret)
+		return NULL;
+
+	ctlr->devm_allocated = true;
 
 	return ctlr;
 }
@@ -3357,9 +3354,9 @@ int spi_register_controller(struct spi_controller *ctlr)
 }
 EXPORT_SYMBOL_GPL(spi_register_controller);
 
-static void devm_spi_unregister(struct device *dev, void *res)
+static void devm_spi_unregister_controller(void *ctlr)
 {
-	spi_unregister_controller(*(struct spi_controller **)res);
+	spi_unregister_controller(ctlr);
 }
 
 /**
@@ -3377,22 +3374,14 @@ static void devm_spi_unregister(struct device *dev, void *res)
 int devm_spi_register_controller(struct device *dev,
 				 struct spi_controller *ctlr)
 {
-	struct spi_controller **ptr;
 	int ret;
 
-	ptr = devres_alloc(devm_spi_unregister, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return -ENOMEM;
-
 	ret = spi_register_controller(ctlr);
-	if (!ret) {
-		*ptr = ctlr;
-		devres_add(dev, ptr);
-	} else {
-		devres_free(ptr);
-	}
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, devm_spi_unregister_controller, ctlr);
 
-	return ret;
 }
 EXPORT_SYMBOL_GPL(devm_spi_register_controller);
 
-- 
2.50.1


