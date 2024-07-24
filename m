Return-Path: <linux-spi+bounces-3976-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B670E93B262
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jul 2024 16:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B40B282145
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jul 2024 14:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92433DDC5;
	Wed, 24 Jul 2024 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nnbilA2U"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3AAEEAB
	for <linux-spi@vger.kernel.org>; Wed, 24 Jul 2024 14:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721830187; cv=none; b=snVNHYPpxcU1ggbc+mpkweMxloFGF9YpPg2K5OpVqDzETFck3GRh0HZNGDXIcvkJ6Cpaz7oVvikIposwoYCT2r+qkGpRC+2lGW30DhHHHlo3GiR4hLUn7ZuPfCApg1kGiWQtkZ8s734b2ZzqTC33+5q7y22LiAjvaPhPIHkRs8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721830187; c=relaxed/simple;
	bh=toFn/lljtSKhDgC3VdyIaHY5ZKP1iLDgCoxmZOU3Dds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S6LKOvAu1quWg+DVa/NjIyWWCVOCAvP+2z+UdxmOTYbEjJykUPV8LEd5wGS0vF26QhbMlhy4VPQY8vJ4OqZVUWQnd25FLVXqqxLihH7XojRFIq16FY3szC7Ctq6o6o4eqKonkNC3ujNVyPdZd5RsVBkhzWPQc6cILST+8TCNT/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nnbilA2U; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721830186; x=1753366186;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=toFn/lljtSKhDgC3VdyIaHY5ZKP1iLDgCoxmZOU3Dds=;
  b=nnbilA2UxygZTMpq4JQzsGnewV8+mCWcw8hz/X5BwjtXsTgMETGKVt50
   bxzOKYXu/jQXKmU445OyZip8NbCEaiaWHATY0xY86iAFZGyne3zqUpo+h
   SVdcTC6yWjVQplO4pwX+TBdb4jxBFrpiWojOXOuRcg851+uZjC/TzYuFl
   mqhoMLJYWMvXwffSvt0McldVf+CbQohDlU/MKDQkQUdxGKiQe85sN5ggK
   dJJNXildIfzHI9N3dEeW1Eq3Ae/mSoFbtSBkGQ5iOS9IbZ9hryk8iKjMc
   xz2FanzrYa4CQziOBnXGq0gjOJZBXmdJYaCputupdVTsRi07TPcdC8M1w
   w==;
X-CSE-ConnectionGUID: lDzaDAWZTEqn2hQXB4Daaw==
X-CSE-MsgGUID: Oyc76zFGRW+LcMQTPiATOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="30173879"
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="30173879"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 07:09:46 -0700
X-CSE-ConnectionGUID: vMRayiSPTduEdlGyTgIc1A==
X-CSE-MsgGUID: GlKCXV81QkermhrP4Cxg0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="83211593"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 07:09:41 -0700
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
Subject: [PATCH v2 12/12] drm/xe/spi: add support for access mode
Date: Wed, 24 Jul 2024 17:00:14 +0300
Message-Id: <20240724140014.428991-13-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724140014.428991-1-alexander.usyskin@intel.com>
References: <20240724140014.428991-1-alexander.usyskin@intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check SPI access mode from GSC FW status registers
and overwrite access status read from SPI descriptor, if needed.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/gpu/drm/xe/regs/xe_gsc_regs.h |  5 ++++
 drivers/gpu/drm/xe/xe_heci_gsc.c      |  5 +---
 drivers/gpu/drm/xe/xe_spi.c           | 33 ++++++++++++++++++++++++++-
 3 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/xe/regs/xe_gsc_regs.h b/drivers/gpu/drm/xe/regs/xe_gsc_regs.h
index e2a925be137c..28c049e60e66 100644
--- a/drivers/gpu/drm/xe/regs/xe_gsc_regs.h
+++ b/drivers/gpu/drm/xe/regs/xe_gsc_regs.h
@@ -16,6 +16,11 @@
 #define MTL_GSC_HECI1_BASE	0x00116000
 #define MTL_GSC_HECI2_BASE	0x00117000
 
+#define DG1_GSC_HECI2_BASE	0x00259000
+#define PVC_GSC_HECI2_BASE	0x00285000
+#define DG2_GSC_HECI2_BASE	0x00374000
+
+
 #define HECI_H_CSR(base)	XE_REG((base) + 0x4)
 #define   HECI_H_CSR_IE		REG_BIT(0)
 #define   HECI_H_CSR_IS		REG_BIT(1)
diff --git a/drivers/gpu/drm/xe/xe_heci_gsc.c b/drivers/gpu/drm/xe/xe_heci_gsc.c
index 1c9d38b6f5f1..d3ff3ba678f0 100644
--- a/drivers/gpu/drm/xe/xe_heci_gsc.c
+++ b/drivers/gpu/drm/xe/xe_heci_gsc.c
@@ -11,14 +11,11 @@
 #include "xe_device_types.h"
 #include "xe_drv.h"
 #include "xe_heci_gsc.h"
+#include "regs/xe_gsc_regs.h"
 #include "xe_platform_types.h"
 
 #define GSC_BAR_LENGTH  0x00000FFC
 
-#define DG1_GSC_HECI2_BASE			0x259000
-#define PVC_GSC_HECI2_BASE			0x285000
-#define DG2_GSC_HECI2_BASE			0x374000
-
 static void heci_gsc_irq_mask(struct irq_data *d)
 {
 	/* generic irq handling */
diff --git a/drivers/gpu/drm/xe/xe_spi.c b/drivers/gpu/drm/xe/xe_spi.c
index f8ad060f97f2..9019672bd464 100644
--- a/drivers/gpu/drm/xe/xe_spi.c
+++ b/drivers/gpu/drm/xe/xe_spi.c
@@ -5,7 +5,10 @@
 
 #include <linux/intel_dg_spi_aux.h>
 #include <linux/pci.h>
+#include "xe_device.h"
 #include "xe_device_types.h"
+#include "xe_mmio.h"
+#include "regs/xe_gsc_regs.h"
 #include "xe_spi.h"
 
 #define GEN12_GUNIT_SPI_BASE 0x00102040
@@ -23,6 +26,34 @@ static void xe_spi_release_dev(struct device *dev)
 {
 }
 
+static bool xe_spi_writeable_override(struct xe_device *xe)
+{
+	struct xe_gt *gt = xe_root_mmio_gt(xe);
+	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
+	resource_size_t base;
+	bool writeable_override;
+
+	if (xe->info.platform == XE_BATTLEMAGE) {
+		base = DG2_GSC_HECI2_BASE;
+	} else if (xe->info.platform == XE_PVC) {
+		base = PVC_GSC_HECI2_BASE;
+	} else if (xe->info.platform == XE_DG2) {
+		base = DG2_GSC_HECI2_BASE;
+	} else if (xe->info.platform == XE_DG1) {
+		base = DG1_GSC_HECI2_BASE;
+	} else {
+		dev_err(&pdev->dev, "Unknown platform\n");
+		return true;
+	}
+
+	writeable_override =
+		!(xe_mmio_read32(gt, HECI_H_GS1(base)) &
+		  HECI_FW_STATUS_2_SPI_ACCESS_MODE);
+	if (writeable_override)
+		dev_info(&pdev->dev, "SPI access overridden by jumper\n");
+	return writeable_override;
+}
+
 void xe_spi_init(struct xe_device *xe)
 {
 	struct intel_dg_spi_dev *spi = &xe->spi;
@@ -33,7 +64,7 @@ void xe_spi_init(struct xe_device *xe)
 	if (!HAS_GSC_SPI(xe))
 		return;
 
-	spi->writeable_override = false;
+	spi->writeable_override = xe_spi_writeable_override(xe);
 	spi->bar.parent = &pdev->resource[0];
 	spi->bar.start = GEN12_GUNIT_SPI_BASE + pdev->resource[0].start;
 	spi->bar.end = spi->bar.start + GEN12_GUNIT_SPI_SIZE - 1;
-- 
2.34.1


