Return-Path: <linux-spi+bounces-4003-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E4D93C3AE
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jul 2024 16:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B041280F04
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jul 2024 14:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEB81993A3;
	Thu, 25 Jul 2024 14:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bu/FyJ5H"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F24119ADBF
	for <linux-spi@vger.kernel.org>; Thu, 25 Jul 2024 14:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721916391; cv=none; b=IzrPT01hqexnR2CLfwXp2HZTczhnoeOEkFQBpT8LFi8q9fq/fhA6AWUhxYxgv1oE3NBp1YD+jjT3mFnGHXHc6jzhGHnCHBR+iB3IGCO1II5IvdyVYFBsO7vLhmWx3iLe5IzSBDBGh3bqAFvsT6aqtyIhlpsQ0nyBC2ZwqFe4Nbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721916391; c=relaxed/simple;
	bh=LR8NOyGYfjYFMYI7lLxD7ILGJpX9PhePm8zaR8atZYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rhdNyNkwflxevM68cWgt/5vUQ5thiJrxSZJ9SwQUWwf/nJ+gVR2Abk+/JnvOYE1tFDIBZl0lD/+BJCcfSeq0uVgO19jG3KhwZIoiGxlz3aXcJ1DLy9V2/opzStOJdLA8d+XXsKI4lAXgatl6CL8j/Sp7EYYqIUQsJiydZkdMdKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bu/FyJ5H; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721916391; x=1753452391;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LR8NOyGYfjYFMYI7lLxD7ILGJpX9PhePm8zaR8atZYM=;
  b=Bu/FyJ5HBJnt5HM/1wrVvWtg1YWYPYEU0dFtUDqqUv5qgp5RiaVGS6Yl
   9E16HjavSvKwSANUBzGsVySo4qQSCvM+JNBePbcAOdjORsrSiaE2Y9EzC
   Rv+N4iUxyNdwrj6YhJmakgUVZGU2G2IsiwiYqr9G5SZz8XSh90cJzGqy1
   xo/Ta9Jo7JLZ60+NQ+D2F+ru3nMqTfjcWMA8h8LSz7EguWoA2Ot3jkPNT
   Ugsr1FaVY4+OiU09GFQNcBY8o1YBzIIxwxl9djm3VlSxXBtANHqHodxBN
   m6I1AkV3oNVl0hl2jl6n851/qTyR8n1ejfGj1RseKsdNLmdYslZnSsSkk
   A==;
X-CSE-ConnectionGUID: gM5VMN3vRACmzdSoir+WUQ==
X-CSE-MsgGUID: Xc+1HeqgTqi/FZpTxDaKcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="19505018"
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="19505018"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 07:06:30 -0700
X-CSE-ConnectionGUID: RzMkEFj7R9GzcOmJt4JVqA==
X-CSE-MsgGUID: lUhpWc2WRhKpMM98YD1i5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="53007895"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 07:06:21 -0700
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
Subject: [PATCH v3 12/12] drm/xe/spi: add support for access mode
Date: Thu, 25 Jul 2024 16:56:57 +0300
Message-Id: <20240725135657.1061836-13-alexander.usyskin@intel.com>
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
index 65b2e147c4b9..27734085164e 100644
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


