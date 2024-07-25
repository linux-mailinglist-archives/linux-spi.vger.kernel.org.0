Return-Path: <linux-spi+bounces-3998-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DE293C39E
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jul 2024 16:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 477DE283B17
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jul 2024 14:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A8D173347;
	Thu, 25 Jul 2024 14:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jJy4y2tK"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DCC19D060
	for <linux-spi@vger.kernel.org>; Thu, 25 Jul 2024 14:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721916360; cv=none; b=bRPXLCv6gnk7GZ4TPOcN+Gmut/E15iCcAKVR8gmuzoOAEnXctA2PrszMQNqpEGfTZZ43pto5brHVyPbBb0lur6YEtwEK8GX84E6KmksxzYKIgfp2HKNJ+WrOOmRh4cYJXvN8XWPVvUN6v6GwNfLHofNO63vWgUzGcqTlZJzHkTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721916360; c=relaxed/simple;
	bh=11QOs8u+bUy7eaSFVBIk7XtmbUWxd8eyYN7UZ5kbeYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PGv+RHPz0zVulpJhyk6K7MlV0xfgQ0eBDWBcFPVME6SKfwUn/wHWpqwsLRVjO0yeRoQTQeV7loedmE3XpTx57Szjo0pk/Txtjjgjg3K+1zefAguwhJdlCZxda0DRcnk4AES00Bu9vRlbt9IbBrZhIv6/geElGBWY7f+NolBTcsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jJy4y2tK; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721916359; x=1753452359;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=11QOs8u+bUy7eaSFVBIk7XtmbUWxd8eyYN7UZ5kbeYM=;
  b=jJy4y2tK6t3swi8lFtPEq0qx/p6//1/Y7f/Z/mf+ZdddYms3zz1coXni
   mwF0+B0HWn69boZ8mLhYGMS3LSwJ57bB6ZU0rCGoDDEKj5DIF55KmM/Ni
   zGGLSLWnN8T6l2lBYjRPdHc22oxszK5R5BLNf1ITltsUlYSm9V9PG0vy8
   HS0bhDjK6GsmShg6BI3jG1EC+Kwko7Y7siF7fClxUchTx1iJQ00clyp3a
   9sjgBiZzzAIJG3QibmMzzx8sHN90sgMxcrKjyBV/AmA+i7Ycvx43KCnZA
   hqFi/Dm/D3w1GhdUbmIeospuy4QuAViNd78t5Sul9JnSCyTF/Xg0c9Xvp
   w==;
X-CSE-ConnectionGUID: OP/snGmdTMW16uT/7NEm2A==
X-CSE-MsgGUID: EqBZQWPCTTqa2QmpHDIu+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="19504870"
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="19504870"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 07:05:59 -0700
X-CSE-ConnectionGUID: Hwj0QsGWSBCtx69WboHL0g==
X-CSE-MsgGUID: 4Q6mLiMNSnu/RX/MiYcHMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="53007779"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 07:05:52 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
To: Mark Brown <broonie@kernel.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Tomas Winkler <tomas.winkler@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Vitaly Lubart <vitaly.lubart@intel.com>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-spi@vger.kernel.org,
	intel-gfx@lists.freedesktop.org
Subject: [PATCH v3 07/12] spi: intel-dg: wake card on operations
Date: Thu, 25 Jul 2024 16:56:52 +0300
Message-Id: <20240725135657.1061836-8-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240725135657.1061836-1-alexander.usyskin@intel.com>
References: <20240725135657.1061836-1-alexander.usyskin@intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable runtime PM in spi driver to notify graphics driver that
whole card should be kept awake while spi operations are
performed through this driver.

CC: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/spi/spi-intel-dg.c | 44 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/spi/spi-intel-dg.c b/drivers/spi/spi-intel-dg.c
index 534e99cb336d..9671c4ec01a9 100644
--- a/drivers/spi/spi-intel-dg.c
+++ b/drivers/spi/spi-intel-dg.c
@@ -12,11 +12,14 @@
 #include <linux/module.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
+#include <linux/pm_runtime.h>
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/sizes.h>
 #include <linux/types.h>
 
+#define INTEL_DG_SPI_RPM_TIMEOUT 500
+
 struct intel_dg_spi {
 	struct kref refcnt;
 	struct mtd_info mtd;
@@ -471,6 +474,12 @@ static int intel_dg_spi_erase(struct mtd_info *mtd, struct erase_info *info)
 	total_len = info->len;
 	addr = info->addr;
 
+	ret = pm_runtime_resume_and_get(mtd->dev.parent);
+	if (ret < 0) {
+		dev_err(&mtd->dev, "rpm: get failed %d\n", ret);
+		return ret;
+	}
+
 	mutex_lock(&spi->lock);
 
 	while (total_len > 0) {
@@ -512,6 +521,8 @@ static int intel_dg_spi_erase(struct mtd_info *mtd, struct erase_info *info)
 
 out:
 	mutex_unlock(&spi->lock);
+	pm_runtime_mark_last_busy(mtd->dev.parent);
+	pm_runtime_put_autosuspend(mtd->dev.parent);
 	return ret;
 }
 
@@ -545,6 +556,12 @@ static int intel_dg_spi_read(struct mtd_info *mtd, loff_t from, size_t len,
 	if (len > spi->regions[idx].size - from)
 		len = spi->regions[idx].size - from;
 
+	ret = pm_runtime_resume_and_get(mtd->dev.parent);
+	if (ret < 0) {
+		dev_err(&mtd->dev, "rpm: get failed %zd\n", ret);
+		return ret;
+	}
+
 	mutex_lock(&spi->lock);
 
 	ret = spi_read(spi, region, from, len, buf);
@@ -557,6 +574,8 @@ static int intel_dg_spi_read(struct mtd_info *mtd, loff_t from, size_t len,
 	*retlen = ret;
 
 	mutex_unlock(&spi->lock);
+	pm_runtime_mark_last_busy(mtd->dev.parent);
+	pm_runtime_put_autosuspend(mtd->dev.parent);
 	return 0;
 }
 
@@ -590,6 +609,12 @@ static int intel_dg_spi_write(struct mtd_info *mtd, loff_t to, size_t len,
 	if (len > spi->regions[idx].size - to)
 		len = spi->regions[idx].size - to;
 
+	ret = pm_runtime_resume_and_get(mtd->dev.parent);
+	if (ret < 0) {
+		dev_err(&mtd->dev, "rpm: get failed %zd\n", ret);
+		return ret;
+	}
+
 	mutex_lock(&spi->lock);
 
 	ret = spi_write(spi, region, to, len, buf);
@@ -602,6 +627,8 @@ static int intel_dg_spi_write(struct mtd_info *mtd, loff_t to, size_t len,
 	*retlen = ret;
 
 	mutex_unlock(&spi->lock);
+	pm_runtime_mark_last_busy(mtd->dev.parent);
+	pm_runtime_put_autosuspend(mtd->dev.parent);
 	return 0;
 }
 
@@ -747,6 +774,17 @@ static int intel_dg_spi_probe(struct auxiliary_device *aux_dev,
 		}
 	}
 
+	pm_runtime_enable(device);
+
+	pm_runtime_set_autosuspend_delay(device, INTEL_DG_SPI_RPM_TIMEOUT);
+	pm_runtime_use_autosuspend(device);
+
+	ret = pm_runtime_resume_and_get(device);
+	if (ret < 0) {
+		dev_err(device, "rpm: get failed %d\n", ret);
+		goto err_norpm;
+	}
+
 	spi->base = devm_ioremap_resource(device, &ispi->bar);
 	if (IS_ERR(spi->base)) {
 		dev_err(device, "mmio not mapped\n");
@@ -769,9 +807,13 @@ static int intel_dg_spi_probe(struct auxiliary_device *aux_dev,
 
 	dev_set_drvdata(&aux_dev->dev, spi);
 
+	pm_runtime_put(device);
 	return 0;
 
 err:
+	pm_runtime_put(device);
+err_norpm:
+	pm_runtime_disable(device);
 	kref_put(&spi->refcnt, intel_dg_spi_release);
 	return ret;
 }
@@ -783,6 +825,8 @@ static void intel_dg_spi_remove(struct auxiliary_device *aux_dev)
 	if (!spi)
 		return;
 
+	pm_runtime_disable(&aux_dev->dev);
+
 	mtd_device_unregister(&spi->mtd);
 
 	dev_set_drvdata(&aux_dev->dev, NULL);
-- 
2.34.1


