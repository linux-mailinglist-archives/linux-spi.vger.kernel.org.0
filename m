Return-Path: <linux-spi+bounces-4035-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1935293E57C
	for <lists+linux-spi@lfdr.de>; Sun, 28 Jul 2024 15:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C1EA1C20BC3
	for <lists+linux-spi@lfdr.de>; Sun, 28 Jul 2024 13:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DFB46BF;
	Sun, 28 Jul 2024 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HgFwifMn"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DA61B86C2
	for <linux-spi@vger.kernel.org>; Sun, 28 Jul 2024 13:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722172564; cv=none; b=bQUMmJjXiRfZJxqZg4AocaraH42VzGskgU4LH2VPjjYFHgWMFvtgVC3/t5Up49O7BqDtgzTiOF2ZC3odeTho4k6GnttrGPb2Fr9X9vRkqCOA8JsAwCVDOVDWHBpsrDiGS+uOMsqgGGvL4ZNVqROMxohCxoLyc970hOU88Pk6wLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722172564; c=relaxed/simple;
	bh=ReyvWNOMwWG/6Q2JW7XUugNgLWTUrutM5w+RMCPwsOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bmo8UVaSw/9rTfCWdrXPD5DOtOfM0D5qpA91Mj+bWSe4TiqVBmXuz5p9NhDKcFkLitIIdVbNlxwZDoz/irKUDczR26ahOVrP4M3zKZ/zI5mid8gyG7sFbcaKdG3K4OlBCTsGQs/hhsXcYdrqEtBd4jEKuLzxCpMWvXyBmlsqCy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HgFwifMn; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722172563; x=1753708563;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ReyvWNOMwWG/6Q2JW7XUugNgLWTUrutM5w+RMCPwsOs=;
  b=HgFwifMnSsb2ZFFqZBgjVNIwsBZGBUNzIirAKTryaiIFaEII0z6p+mXb
   EO376xRAa0W2Iz8uGw6Tl5X66HYeQm2qH9EQpgAQe9QP2wvBtZOuIxEiD
   1xLECVPi9mAZY9Tc9/ctJis0sz7N49MLfUP0aVKkMFA3zv+jkjaMdcSWa
   /ZINxkJWFBUV1jDN5gDOsDJ2xM1T2zljY/3fxPrt1Nl0L4ToSQ4ntBgVF
   Bjt7T+JasLgxHmV7Dt0muXd6lK47AatlG3Cxgouxi6S9Fs2F6ZCo//Ixw
   AqquS9l++kxYMHa8Ek36UANSJuENRZm+0ZfhHwrSqFx77a5qVCaC1UocA
   w==;
X-CSE-ConnectionGUID: kD+G7KNySkOvfSa3AOYnRA==
X-CSE-MsgGUID: LDHZ0cVoTHu6iHaWptBo/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="23713496"
X-IronPort-AV: E=Sophos;i="6.09,243,1716274800"; 
   d="scan'208";a="23713496"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 06:16:03 -0700
X-CSE-ConnectionGUID: lfX0vcKpRIe+QIJJ7Fygng==
X-CSE-MsgGUID: 974jvvH8S3qmD9GCl2cEVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,243,1716274800"; 
   d="scan'208";a="53389348"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 06:15:57 -0700
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
Subject: [PATCH v4 11/12] drm/xe/spi: add on-die spi device
Date: Sun, 28 Jul 2024 16:06:37 +0300
Message-Id: <20240728130638.1930463-12-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240728130638.1930463-1-alexander.usyskin@intel.com>
References: <20240728130638.1930463-1-alexander.usyskin@intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable access to internal spi on DGFX with GSC/CSC devices
via a child device.
The spi child device is exposed via auxiliary bus.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/gpu/drm/xe/Makefile          |  1 +
 drivers/gpu/drm/xe/xe_device.c       |  3 ++
 drivers/gpu/drm/xe/xe_device_types.h |  8 +++
 drivers/gpu/drm/xe/xe_pci.c          |  5 ++
 drivers/gpu/drm/xe/xe_spi.c          | 73 ++++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_spi.h          | 15 ++++++
 6 files changed, 105 insertions(+)
 create mode 100644 drivers/gpu/drm/xe/xe_spi.c
 create mode 100644 drivers/gpu/drm/xe/xe_spi.h

diff --git a/drivers/gpu/drm/xe/Makefile b/drivers/gpu/drm/xe/Makefile
index 1ff9602a52f6..f98e26b81035 100644
--- a/drivers/gpu/drm/xe/Makefile
+++ b/drivers/gpu/drm/xe/Makefile
@@ -95,6 +95,7 @@ xe-y += xe_bb.o \
 	xe_ring_ops.o \
 	xe_sa.o \
 	xe_sched_job.o \
+	xe_spi.o \
 	xe_step.o \
 	xe_sync.o \
 	xe_tile.o \
diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 1aba6f9eaa19..7b7aee91497e 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -47,6 +47,7 @@
 #include "xe_pcode.h"
 #include "xe_pm.h"
 #include "xe_query.h"
+#include "xe_spi.h"
 #include "xe_sriov.h"
 #include "xe_tile.h"
 #include "xe_ttm_stolen_mgr.h"
@@ -720,6 +721,7 @@ int xe_device_probe(struct xe_device *xe)
 			goto err_fini_gt;
 	}
 
+	xe_spi_init(xe);
 	xe_heci_gsc_init(xe);
 
 	err = xe_oa_init(xe);
@@ -788,6 +790,7 @@ void xe_device_remove(struct xe_device *xe)
 	xe_oa_fini(xe);
 
 	xe_heci_gsc_fini(xe);
+	xe_spi_fini(xe);
 
 	for_each_gt(gt, xe, id)
 		xe_gt_remove(gt);
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 5b7292a9a66d..c41f6004eb5b 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -12,6 +12,8 @@
 #include <drm/drm_file.h>
 #include <drm/ttm/ttm_device.h>
 
+#include <linux/intel_dg_spi_aux.h>
+
 #include "xe_devcoredump_types.h"
 #include "xe_heci_gsc.h"
 #include "xe_gt_types.h"
@@ -45,6 +47,7 @@ struct xe_pat_ops;
 #define IS_DGFX(xe) ((xe)->info.is_dgfx)
 #define HAS_HECI_GSCFI(xe) ((xe)->info.has_heci_gscfi)
 #define HAS_HECI_CSCFI(xe) ((xe)->info.has_heci_cscfi)
+#define HAS_GSC_SPI(xe) ((xe)->info.has_gsc_spi)
 
 #define XE_VRAM_FLAGS_NEED64K		BIT(0)
 
@@ -292,6 +295,8 @@ struct xe_device {
 		u8 has_heci_gscfi:1;
 		/** @info.has_heci_cscfi: device has heci cscfi */
 		u8 has_heci_cscfi:1;
+		/** @info.has_gsc_spi: device has gsc spi */
+		u8 has_gsc_spi:1;
 		/** @info.skip_guc_pc: Skip GuC based PM feature init */
 		u8 skip_guc_pc:1;
 		/** @info.has_atomic_enable_pte_bit: Device has atomic enable PTE bit */
@@ -470,6 +475,9 @@ struct xe_device {
 	/** @heci_gsc: graphics security controller */
 	struct xe_heci_gsc heci_gsc;
 
+	/** @spi: discrete graphics spi */
+	struct intel_dg_spi_dev spi;
+
 	/** @oa: oa observation subsystem */
 	struct xe_oa oa;
 
diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
index 3c4a3c91377a..c74c36ee7fa6 100644
--- a/drivers/gpu/drm/xe/xe_pci.c
+++ b/drivers/gpu/drm/xe/xe_pci.c
@@ -60,6 +60,7 @@ struct xe_device_desc {
 	u8 has_display:1;
 	u8 has_heci_gscfi:1;
 	u8 has_heci_cscfi:1;
+	u8 has_gsc_spi:1;
 	u8 has_llc:1;
 	u8 has_mmio_ext:1;
 	u8 has_sriov:1;
@@ -283,6 +284,7 @@ static const struct xe_device_desc dg1_desc = {
 	PLATFORM(DG1),
 	.has_display = true,
 	.has_heci_gscfi = 1,
+	.has_gsc_spi = 1,
 	.require_force_probe = true,
 };
 
@@ -294,6 +296,7 @@ static const u16 dg2_g12_ids[] = { XE_DG2_G12_IDS(NOP), 0 };
 	DGFX_FEATURES, \
 	PLATFORM(DG2), \
 	.has_heci_gscfi = 1, \
+	.has_gsc_spi = 1, \
 	.subplatforms = (const struct xe_subplatform_desc[]) { \
 		{ XE_SUBPLATFORM_DG2_G10, "G10", dg2_g10_ids }, \
 		{ XE_SUBPLATFORM_DG2_G11, "G11", dg2_g11_ids }, \
@@ -325,6 +328,7 @@ static const __maybe_unused struct xe_device_desc pvc_desc = {
 	PLATFORM(PVC),
 	.has_display = false,
 	.has_heci_gscfi = 1,
+	.has_gsc_spi = 1,
 	.require_force_probe = true,
 };
 
@@ -609,6 +613,7 @@ static int xe_info_init_early(struct xe_device *xe,
 	xe->info.is_dgfx = desc->is_dgfx;
 	xe->info.has_heci_gscfi = desc->has_heci_gscfi;
 	xe->info.has_heci_cscfi = desc->has_heci_cscfi;
+	xe->info.has_gsc_spi = desc->has_gsc_spi;
 	xe->info.has_llc = desc->has_llc;
 	xe->info.has_mmio_ext = desc->has_mmio_ext;
 	xe->info.has_sriov = desc->has_sriov;
diff --git a/drivers/gpu/drm/xe/xe_spi.c b/drivers/gpu/drm/xe/xe_spi.c
new file mode 100644
index 000000000000..f8ad060f97f2
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_spi.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright(c) 2019-2024, Intel Corporation. All rights reserved.
+ */
+
+#include <linux/intel_dg_spi_aux.h>
+#include <linux/pci.h>
+#include "xe_device_types.h"
+#include "xe_spi.h"
+
+#define GEN12_GUNIT_SPI_BASE 0x00102040
+#define GEN12_GUNIT_SPI_SIZE 0x80
+#define HECI_FW_STATUS_2_SPI_ACCESS_MODE BIT(3)
+
+static const struct intel_dg_spi_region regions[INTEL_DG_SPI_REGIONS] = {
+	[0] = { .name = "DESCRIPTOR", },
+	[2] = { .name = "GSC", },
+	[11] = { .name = "OptionROM", },
+	[12] = { .name = "DAM", },
+};
+
+static void xe_spi_release_dev(struct device *dev)
+{
+}
+
+void xe_spi_init(struct xe_device *xe)
+{
+	struct intel_dg_spi_dev *spi = &xe->spi;
+	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
+	struct auxiliary_device *aux_dev = &spi->aux_dev;
+	int ret;
+
+	if (!HAS_GSC_SPI(xe))
+		return;
+
+	spi->writeable_override = false;
+	spi->bar.parent = &pdev->resource[0];
+	spi->bar.start = GEN12_GUNIT_SPI_BASE + pdev->resource[0].start;
+	spi->bar.end = spi->bar.start + GEN12_GUNIT_SPI_SIZE - 1;
+	spi->bar.flags = IORESOURCE_MEM;
+	spi->bar.desc = IORES_DESC_NONE;
+	spi->regions = regions;
+
+	aux_dev->name = "spi";
+	aux_dev->id = (pci_domain_nr(pdev->bus) << 16) |
+		       PCI_DEVID(pdev->bus->number, pdev->devfn);
+	aux_dev->dev.parent = &pdev->dev;
+	aux_dev->dev.release = xe_spi_release_dev;
+
+	ret = auxiliary_device_init(aux_dev);
+	if (ret) {
+		dev_err(&pdev->dev, "xe-spi aux init failed %d\n", ret);
+		return;
+	}
+
+	ret = auxiliary_device_add(aux_dev);
+	if (ret) {
+		dev_err(&pdev->dev, "xe-spi aux add failed %d\n", ret);
+		auxiliary_device_uninit(aux_dev);
+		return;
+	}
+}
+
+void xe_spi_fini(struct xe_device *xe)
+{
+	struct intel_dg_spi_dev *spi = &xe->spi;
+
+	if (!HAS_GSC_SPI(xe))
+		return;
+
+	auxiliary_device_delete(&spi->aux_dev);
+	auxiliary_device_uninit(&spi->aux_dev);
+}
diff --git a/drivers/gpu/drm/xe/xe_spi.h b/drivers/gpu/drm/xe/xe_spi.h
new file mode 100644
index 000000000000..aef79893a864
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_spi.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright(c) 2019-2024 Intel Corporation. All rights reserved.
+ */
+
+#ifndef __XE_SPI_H__
+#define __XE_SPI_H__
+
+struct xe_device;
+
+void xe_spi_init(struct xe_device *xe);
+
+void xe_spi_fini(struct xe_device *xe);
+
+#endif /* __XE_SPI_H__ */
-- 
2.34.1


