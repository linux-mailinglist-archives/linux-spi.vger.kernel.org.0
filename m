Return-Path: <linux-spi+bounces-3999-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C3493C3A0
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jul 2024 16:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 192901C212A5
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jul 2024 14:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11FA19B59C;
	Thu, 25 Jul 2024 14:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PcxCMu98"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2347819B3EA
	for <linux-spi@vger.kernel.org>; Thu, 25 Jul 2024 14:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721916366; cv=none; b=WC4ZNnBSGhcWcPsf2d5/tYmjco+tgd9MseTHIFcKEuhfVxqLeY98+z28Vccax26qsiFlCT4GIv+YUNZfzmstRGmjNWK/Fp9RTaMd0QiAWSmwP7zyvc9XdGzV70yfdOQ30rFJOfNmv2fm614w8o+mvqNolO3546SjzI4CT0ncLHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721916366; c=relaxed/simple;
	bh=IR3Dd+0RE1/afqZpcqOS+jOp4k532qccfa7dLDbX2/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C1ZAvkEv6VZTL9Yda+08G7px6M9PAI1eQ+TpvMrEqIRF9CWuuV6ztGneoOYgwjSc7AH84MyHBx8xf3WedVsViKBMTz8aieas9BQYqQwxHtpi++h1H7qV4RYhKHP7eUTUXVjuIZVsQmJIlMBlYAIUZBiTVHng9D2+nA8FPZhKH6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PcxCMu98; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721916365; x=1753452365;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IR3Dd+0RE1/afqZpcqOS+jOp4k532qccfa7dLDbX2/8=;
  b=PcxCMu98jO4WXFpitB6LcaDcKCG1AxO96fFXSkTz8+Vr3c29KMYgiKrG
   OWInWn/vmpsndJ04N2F5/fTmNDfSNB0IrYSLWefgCFKx5w2mb95aFT0lQ
   Z5gZxP4wxGCuX4ETu00zxVydMkBQg4ilTg4Ays615lvuEYV3mvNnKWSQU
   rgz62H2gJz/QduHuLNk2QAOabYmERULSZqYyCoKqueaSsUFYTuFGPJMeq
   ZnyxVwhP0Od3dxltYv+GLCEEMDWEkgyaNraP+PLRsEPwAQ6Olrd1bm1pZ
   RCrsYds0+0ce2WM+IXB+/+db9lvlNGQeGJ5HCEscvmYE5QfF0A1tCbYn+
   A==;
X-CSE-ConnectionGUID: zWYerx9EQDuq9WVdYBNvAA==
X-CSE-MsgGUID: uXRoHXrrSS+uIIChTRCnOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="19504904"
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="19504904"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 07:06:05 -0700
X-CSE-ConnectionGUID: pGfMw98xSP+8f1w5e5TlHw==
X-CSE-MsgGUID: YmTCbHPwREqIPWgsOflS4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="53007793"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 07:05:58 -0700
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
Subject: [PATCH v3 08/12] drm/i915/spi: add spi device for discrete graphics
Date: Thu, 25 Jul 2024 16:56:53 +0300
Message-Id: <20240725135657.1061836-9-alexander.usyskin@intel.com>
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

From: Tomas Winkler <tomas.winkler@intel.com>

Enable access to internal spi on DGFX devices via a child device.
The spi child device is exposed via auxiliary bus.

CC: Rodrigo Vivi <rodrigo.vivi@intel.com>
CC: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/gpu/drm/i915/Makefile        |  4 ++
 drivers/gpu/drm/i915/i915_driver.c   |  6 +++
 drivers/gpu/drm/i915/i915_drv.h      |  4 ++
 drivers/gpu/drm/i915/i915_reg.h      |  1 +
 drivers/gpu/drm/i915/spi/intel_spi.c | 64 ++++++++++++++++++++++++++++
 drivers/gpu/drm/i915/spi/intel_spi.h | 15 +++++++
 6 files changed, 94 insertions(+)
 create mode 100644 drivers/gpu/drm/i915/spi/intel_spi.c
 create mode 100644 drivers/gpu/drm/i915/spi/intel_spi.h

diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
index c63fa2133ccb..02a9faf049a7 100644
--- a/drivers/gpu/drm/i915/Makefile
+++ b/drivers/gpu/drm/i915/Makefile
@@ -211,6 +211,10 @@ i915-y += \
 i915-y += \
 	gt/intel_gsc.o
 
+# graphics spi device (DGFX) support
+i915-y += \
+	spi/intel_spi.o
+
 # graphics hardware monitoring (HWMON) support
 i915-$(CONFIG_HWMON) += \
 	i915_hwmon.o
diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
index 161b21eff694..49916a586dac 100644
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -81,6 +81,8 @@
 #include "soc/intel_dram.h"
 #include "soc/intel_gmch.h"
 
+#include "spi/intel_spi.h"
+
 #include "i915_debugfs.h"
 #include "i915_driver.h"
 #include "i915_drm_client.h"
@@ -619,6 +621,8 @@ static void i915_driver_register(struct drm_i915_private *dev_priv)
 	/* Depends on sysfs having been initialized */
 	i915_perf_register(dev_priv);
 
+	intel_spi_init(dev_priv);
+
 	for_each_gt(gt, dev_priv, i)
 		intel_gt_driver_register(gt);
 
@@ -662,6 +666,8 @@ static void i915_driver_unregister(struct drm_i915_private *dev_priv)
 
 	i915_hwmon_unregister(dev_priv);
 
+	intel_spi_fini(dev_priv);
+
 	i915_perf_unregister(dev_priv);
 	i915_pmu_unregister(dev_priv);
 
diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index d1d21d433766..dd48fae4efe0 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -34,6 +34,8 @@
 
 #include <linux/pm_qos.h>
 
+#include <linux/intel_dg_spi_aux.h>
+
 #include <drm/ttm/ttm_device.h>
 
 #include "display/intel_display_limits.h"
@@ -315,6 +317,8 @@ struct drm_i915_private {
 
 	struct i915_perf perf;
 
+	struct intel_dg_spi_dev spi;
+
 	struct i915_hwmon *hwmon;
 
 	struct intel_gt *gt[I915_MAX_GT];
diff --git a/drivers/gpu/drm/i915/i915_reg.h b/drivers/gpu/drm/i915/i915_reg.h
index 8e4478194d11..50dc19c58666 100644
--- a/drivers/gpu/drm/i915/i915_reg.h
+++ b/drivers/gpu/drm/i915/i915_reg.h
@@ -323,6 +323,7 @@
 #define DG2_GSC_HECI2_BASE	0x00374000
 #define MTL_GSC_HECI1_BASE	0x00116000
 #define MTL_GSC_HECI2_BASE	0x00117000
+#define GEN12_GUNIT_SPI_BASE	0x00102040
 
 #define HECI_H_CSR(base)	_MMIO((base) + 0x4)
 #define   HECI_H_CSR_IE		REG_BIT(0)
diff --git a/drivers/gpu/drm/i915/spi/intel_spi.c b/drivers/gpu/drm/i915/spi/intel_spi.c
new file mode 100644
index 000000000000..17e4c7861ef5
--- /dev/null
+++ b/drivers/gpu/drm/i915/spi/intel_spi.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright(c) 2019-2024, Intel Corporation. All rights reserved.
+ */
+
+#include <linux/intel_dg_spi_aux.h>
+#include <linux/irq.h>
+#include "i915_reg.h"
+#include "i915_drv.h"
+#include "spi/intel_spi.h"
+
+#define GEN12_GUNIT_SPI_SIZE 0x80
+
+static void i915_spi_release_dev(struct device *dev)
+{
+}
+
+void intel_spi_init(struct drm_i915_private *dev_priv)
+{
+	struct intel_dg_spi_dev *spi = &dev_priv->spi;
+	struct pci_dev *pdev = to_pci_dev(dev_priv->drm.dev);
+	struct auxiliary_device *aux_dev = &spi->aux_dev;
+	int ret;
+
+	/* Only the DGFX devices have internal SPI */
+	if (!IS_DGFX(dev_priv))
+		return;
+
+	spi->bar.parent = &pdev->resource[0];
+	spi->bar.start = GEN12_GUNIT_SPI_BASE + pdev->resource[0].start;
+	spi->bar.end = spi->bar.start + GEN12_GUNIT_SPI_SIZE - 1;
+	spi->bar.flags = IORESOURCE_MEM;
+	spi->bar.desc = IORES_DESC_NONE;
+
+	aux_dev->name = "spi";
+	aux_dev->id = (pci_domain_nr(pdev->bus) << 16) |
+		       PCI_DEVID(pdev->bus->number, pdev->devfn);
+	aux_dev->dev.parent = &pdev->dev;
+	aux_dev->dev.release = i915_spi_release_dev;
+
+	ret = auxiliary_device_init(aux_dev);
+	if (ret) {
+		dev_err(&pdev->dev, "i915-spi aux init failed %d\n", ret);
+		return;
+	}
+
+	ret = auxiliary_device_add(aux_dev);
+	if (ret) {
+		dev_err(&pdev->dev, "i915-spi aux add failed %d\n", ret);
+		auxiliary_device_uninit(aux_dev);
+		return;
+	}
+}
+
+void intel_spi_fini(struct drm_i915_private *dev_priv)
+{
+	struct intel_dg_spi_dev *spi = &dev_priv->spi;
+	struct pci_dev *pdev = to_pci_dev(dev_priv->drm.dev);
+
+	dev_dbg(&pdev->dev, "removing i915-spi cell\n");
+
+	auxiliary_device_delete(&spi->aux_dev);
+	auxiliary_device_uninit(&spi->aux_dev);
+}
diff --git a/drivers/gpu/drm/i915/spi/intel_spi.h b/drivers/gpu/drm/i915/spi/intel_spi.h
new file mode 100644
index 000000000000..ed4153401f5d
--- /dev/null
+++ b/drivers/gpu/drm/i915/spi/intel_spi.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright(c) 2019-2024 Intel Corporation. All rights reserved.
+ */
+
+#ifndef __INTEL_SPI_H__
+#define __INTEL_SPI_H__
+
+struct drm_i915_private;
+
+void intel_spi_init(struct drm_i915_private *i915);
+
+void intel_spi_fini(struct drm_i915_private *i915);
+
+#endif /* __INTEL_SPI_H__ */
-- 
2.34.1


