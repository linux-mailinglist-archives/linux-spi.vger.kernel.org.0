Return-Path: <linux-spi+bounces-12226-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 446D8D059E3
	for <lists+linux-spi@lfdr.de>; Thu, 08 Jan 2026 19:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FD0331E9464
	for <lists+linux-spi@lfdr.de>; Thu,  8 Jan 2026 17:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D792DA749;
	Thu,  8 Jan 2026 17:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="elX20ZvZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A612E7162;
	Thu,  8 Jan 2026 17:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767894710; cv=none; b=S2w1QrCLsF4GFaocvPQSNBWrxEPvZ2ggwQNS/I4eJ7Vud2Gv9Z9ZubIp9bqqf55g0L5Iqq+88rFzM+m0kT+qCqPx74+iutdG+jq7CcLVcCA5RoCy2+mj+PiaEfBNU4QCHA1MePy/iiHEDYbr554XzM3SflvUHzwxali0Ytd6HEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767894710; c=relaxed/simple;
	bh=dd3ZBq2OVguG4XFVW2uRS6OyEGZlhCbcSVu2+ITX7ZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FSIhyD2MN7IjjJvMaYdWpyV1K8i19at+7XzE5EzSY8bpemzwUN2revfPYwHfXhATJJiprXpr9Bp3wWCy80ivGhkvXIICTdljpW8OVvHFPzu7/3LKAFPQYSxUoF15o//N0K9oQsUjUq/jSe414Vue9fM5K7jstMLJTkZXdH+bBLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=elX20ZvZ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767894709; x=1799430709;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dd3ZBq2OVguG4XFVW2uRS6OyEGZlhCbcSVu2+ITX7ZY=;
  b=elX20ZvZ2wEXUDZJbzeDoJb2UzV8uonsGVd+PjCCMS/T0U+BER6SDr7c
   YeA5xxtbgzJI/dhAikjymlyxRdQ22qYGmDG2waMhE7rudlJC1z8NEnis7
   RNBmyfbp7qx6CPu0QdR2vkrJ4nVCZAFnjNYWgUrBLQyDEY2LS0w3kT5hW
   FBWTIqJOTlRBTeY68+8IHnxfRPRxJC6oCXgeD4ynKptjBOl+wTV6FKQjj
   sp/vYxO/IjaFxIxKxeNBT9kogTjG9esUBqIhmHd9AOLlmiYpkMB01Oaq2
   Uw8lpaTokjrplAJ8wGdwvjtsGj5qEd4ROD6AkuU6F0vwI0GagnDDvVhhb
   Q==;
X-CSE-ConnectionGUID: kF6U7Vg3RaiUmR+oK420bA==
X-CSE-MsgGUID: ZV2QsDYwRk699fmD/m99HA==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="69190626"
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="69190626"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 09:51:48 -0800
X-CSE-ConnectionGUID: 5GkaJbKqQTyM1htMmAawvA==
X-CSE-MsgGUID: tbIPsMFGS1Smp4XSPSMM5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="208320395"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 08 Jan 2026 09:51:47 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 218C798; Thu, 08 Jan 2026 18:51:46 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] spi: Simplify devm_spi_*_controller()
Date: Thu,  8 Jan 2026 18:51:45 +0100
Message-ID: <20260108175145.3535441-1-andriy.shevchenko@linux.intel.com>
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
index e25df9990f82..f077ea74e299 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3079,9 +3079,9 @@ struct spi_controller *__spi_alloc_controller(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(__spi_alloc_controller);
 
-static void devm_spi_release_controller(struct device *dev, void *ctlr)
+static void devm_spi_release_controller(void *ctlr)
 {
-	spi_controller_put(*(struct spi_controller **)ctlr);
+	spi_controller_put(ctlr);
 }
 
 /**
@@ -3103,21 +3103,18 @@ struct spi_controller *__devm_spi_alloc_controller(struct device *dev,
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
@@ -3378,9 +3375,9 @@ int spi_register_controller(struct spi_controller *ctlr)
 }
 EXPORT_SYMBOL_GPL(spi_register_controller);
 
-static void devm_spi_unregister(struct device *dev, void *res)
+static void devm_spi_unregister_controller(void *ctlr)
 {
-	spi_unregister_controller(*(struct spi_controller **)res);
+	spi_unregister_controller(ctlr);
 }
 
 /**
@@ -3398,22 +3395,14 @@ static void devm_spi_unregister(struct device *dev, void *res)
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


