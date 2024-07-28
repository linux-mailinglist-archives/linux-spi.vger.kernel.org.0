Return-Path: <linux-spi+bounces-4032-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA03A93E576
	for <lists+linux-spi@lfdr.de>; Sun, 28 Jul 2024 15:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28574B21071
	for <lists+linux-spi@lfdr.de>; Sun, 28 Jul 2024 13:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBE41B86C2;
	Sun, 28 Jul 2024 13:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A/htPOR7"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B09A2F30
	for <linux-spi@vger.kernel.org>; Sun, 28 Jul 2024 13:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722172549; cv=none; b=UwN55ybowxwFUIGbywR6+bkHd3gTz4uXkRphhPxnDuF8Kc53Rp5ntMfq6RX+s9bZZyMorgmGrFg2vjGMndHOD+PyOo+4ChmN5DaWu3HgDFuPNcDyfpzlWaBpD2qcwq8DV9HeP+Xg9ZiKbRDh1XoItUkVc1kzRTixD5RhgW/tx1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722172549; c=relaxed/simple;
	bh=C80lflxrNHtqvajVDZlHbHbK1vtaBE682PltPOrdB0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ky0mtEYQIuLPT2mnDNvIBvOH7468I+30qoB4+0h+N6RQLHEQDRGnEfMS2Sd1NQqsCtwDujZT+75pRJktn5vMRAzZO6OZGzd+i9gqshqDGtnPTQtwnz/4HNRiIZoIFRs4Dun5c4TjVYTt1zXa8n85XGjpFNaaXE/W6vHA+U/cTKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A/htPOR7; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722172547; x=1753708547;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C80lflxrNHtqvajVDZlHbHbK1vtaBE682PltPOrdB0A=;
  b=A/htPOR7iufJZko5x4Cg6TUifJN3EyI7LqgERP/Vtbkf2bzClvy8K8di
   Ss0NpRP/RzrdZhg4VQoGWAP/rBWL6puBiKgeHmCaZ7wZ+HNYtb9l2hpB/
   8kRgl4VjcijtQ7wPkWoCWuTNdtfZN7+ZlDHCaRxpY7hmysRoT1O1BN+9w
   WEZ4S8rXFfymtoX8pgCDWzBnbdu9ifJEJ9S9kwKuTVjQH+V4rhwTmw637
   X+NebzYyTDi0yFnJ8105qI5m2L0lGs83N0jhfOIRbpk7iyq/+ajdqg092
   3x7pRqELf6hd0MP8YKoYKoXmUND67Scov4koMqbpJrkADWRu2Ez4NShfj
   Q==;
X-CSE-ConnectionGUID: uTyJ44VSRqiAkdqcCK0lWQ==
X-CSE-MsgGUID: +MfB5sXdRmS2G88pJZaqBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="23713467"
X-IronPort-AV: E=Sophos;i="6.09,243,1716274800"; 
   d="scan'208";a="23713467"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 06:15:47 -0700
X-CSE-ConnectionGUID: SFeoLZzTTr67LgNlFtPFDQ==
X-CSE-MsgGUID: ywCZeGP6T6WkJ1/zzg9l+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,243,1716274800"; 
   d="scan'208";a="53389313"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 06:15:42 -0700
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
Subject: [PATCH v4 08/12] drm/i915/spi: add spi device for discrete graphics
Date: Sun, 28 Jul 2024 16:06:34 +0300
Message-Id: <20240728130638.1930463-9-alexander.usyskin@intel.com>
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
 drivers/gpu/drm/i915/spi/intel_spi.c | 68 ++++++++++++++++++++++++++++
 drivers/gpu/drm/i915/spi/intel_spi.h | 15 ++++++
 6 files changed, 98 insertions(+)
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
index 000000000000..4b90e42b0f86
--- /dev/null
+++ b/drivers/gpu/drm/i915/spi/intel_spi.c
@@ -0,0 +1,68 @@
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
+	/* Only the DGFX devices have internal SPI */
+	if (!IS_DGFX(dev_priv))
+		return;
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


