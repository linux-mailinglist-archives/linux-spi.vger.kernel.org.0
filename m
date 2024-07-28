Return-Path: <linux-spi+bounces-4025-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3261693E560
	for <lists+linux-spi@lfdr.de>; Sun, 28 Jul 2024 15:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B29F21F215FB
	for <lists+linux-spi@lfdr.de>; Sun, 28 Jul 2024 13:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCA88472;
	Sun, 28 Jul 2024 13:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l1S/CLQJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8062F30
	for <linux-spi@vger.kernel.org>; Sun, 28 Jul 2024 13:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722172512; cv=none; b=WWhdfXjYrUF5otFyY+NLL7CNhnzOV5s/Txb8Uz1Xix64EChrIhAmt1ypqRbHjHPppZiw6XQbPAgziNxM2RK3veqdg1UzQ0Ku4LuZi8teQhT+QAbj5IFwAACxCtnwZbqK79LD/a7Ab9iinjy1mzF5wHvOj5BiW0JznzU2Lu6Jffc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722172512; c=relaxed/simple;
	bh=X17GcoYWEfNGXcy8IUUld8+CgCQk12hOaWgsxRhJzUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TdhIoqcBOhQ5CDKyh5jc/IYh64ytujel5ALSeIVtty4XgfGLYrtiROpzO88t5RM2olTFw5sVxblihrctWCAScDup785vHeZB6VrffKX8blFh1pbXyzm/RapFoeBxVv64IdX7OCGZmYHEb7JHiBOMy0LGn9eDHqFXI5ls/YLbC/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l1S/CLQJ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722172510; x=1753708510;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X17GcoYWEfNGXcy8IUUld8+CgCQk12hOaWgsxRhJzUw=;
  b=l1S/CLQJVVAzZz3ARo4Iu1dbVV2XhigByGFsrW3aDU6gYTrh0T35rY4J
   P1QfpZetxYeUnpfAks9nNNKwtYB5dS1AYoQ4FNfOErESYL4g+QSBmkwHy
   8yD0JOhg4U+wwWDtIij3e0RL7UDW69uqS1+5DQdYppZgLEgryyShoC8xy
   bMGpRuXR7fyQjAF4DV6kd0Dtbv8DIqlX/FHrFvekxMQKwo0k3w44DNo2S
   p2Sak6QQRgkWLIIcwz9Z4R43GJqSLKlfPLdb+PoE4dc/OyoZCRPrB5ydV
   o0/Fv82qA1YyDwtxRVwXtQwREzWjpk2FIoPYNJBMFHJWp68/eGcWo0REP
   A==;
X-CSE-ConnectionGUID: VlX50pJxS16lBBmckVfuRg==
X-CSE-MsgGUID: agkfR205RXaQoXpPQeeZxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="23713390"
X-IronPort-AV: E=Sophos;i="6.09,243,1716274800"; 
   d="scan'208";a="23713390"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 06:15:10 -0700
X-CSE-ConnectionGUID: cuLlV0rXSJKSnu8hM6AlEA==
X-CSE-MsgGUID: ptYs6PwTS1uEoLHLjpsLCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,243,1716274800"; 
   d="scan'208";a="53389158"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 06:15:05 -0700
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
Subject: [PATCH v4 01/12] spi: add driver for intel graphics on-die spi device
Date: Sun, 28 Jul 2024 16:06:27 +0300
Message-Id: <20240728130638.1930463-2-alexander.usyskin@intel.com>
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

Add auxiliary driver for intel discrete graphics
on-die spi device.

CC: Rodrigo Vivi <rodrigo.vivi@intel.com>
CC: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 MAINTAINERS                      |   7 ++
 drivers/spi/Kconfig              |  11 +++
 drivers/spi/Makefile             |   1 +
 drivers/spi/spi-intel-dg.c       | 142 +++++++++++++++++++++++++++++++
 include/linux/intel_dg_spi_aux.h |  27 ++++++
 5 files changed, 188 insertions(+)
 create mode 100644 drivers/spi/spi-intel-dg.c
 create mode 100644 include/linux/intel_dg_spi_aux.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 082483b40fac..90e06701f988 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11003,6 +11003,13 @@ L:	linux-kernel@vger.kernel.org
 S:	Supported
 F:	arch/x86/include/asm/intel-family.h
 
+INTEL DISCRETE GRAPHIC SPI FLASH DRIVER
+M:	Alexander Usyskin <alexander.usyskin@intel.com>
+L:	linux-spi@vger.kernel.org
+S:	Supported
+F:	drivers/spi/spi-intel-dg.c
+F:	include/linux/intel_dg_spi_aux.h
+
 INTEL DRM DISPLAY FOR XE AND I915 DRIVERS
 M:	Jani Nikula <jani.nikula@linux.intel.com>
 M:	Rodrigo Vivi <rodrigo.vivi@intel.com>
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index a2c99ff33e0a..ad6e74ff3223 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -518,6 +518,17 @@ config SPI_INTEL_PLATFORM
 	  To compile this driver as a module, choose M here: the module
 	  will be called spi-intel-platform.
 
+config SPI_INTEL_DG
+	tristate "Intel Discrete Graphic SPI flash driver"
+	depends on AUXILIARY_BUS || COMPILE_TEST
+	depends on MTD
+	help
+	  This enables support for Intel Discrete Graphic SPI
+	  auxiliary device.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called spi-intel-dg.
+
 config SPI_JCORE
 	tristate "J-Core SPI Master"
 	depends on OF && (SUPERH || COMPILE_TEST)
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index e694254dec04..3c48a086c0e0 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -70,6 +70,7 @@ obj-$(CONFIG_SPI_INGENIC)		+= spi-ingenic.o
 obj-$(CONFIG_SPI_INTEL)			+= spi-intel.o
 obj-$(CONFIG_SPI_INTEL_PCI)		+= spi-intel-pci.o
 obj-$(CONFIG_SPI_INTEL_PLATFORM)	+= spi-intel-platform.o
+obj-$(CONFIG_SPI_INTEL_DG)		+= spi-intel-dg.o
 obj-$(CONFIG_SPI_LANTIQ_SSC)		+= spi-lantiq-ssc.o
 obj-$(CONFIG_SPI_JCORE)			+= spi-jcore.o
 obj-$(CONFIG_SPI_LJCA)			+= spi-ljca.o
diff --git a/drivers/spi/spi-intel-dg.c b/drivers/spi/spi-intel-dg.c
new file mode 100644
index 000000000000..4e302957f077
--- /dev/null
+++ b/drivers/spi/spi-intel-dg.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright(c) 2019-2024, Intel Corporation. All rights reserved.
+ */
+
+#include <linux/device.h>
+#include <linux/intel_dg_spi_aux.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+struct intel_dg_spi {
+	struct kref refcnt;
+	void __iomem *base;
+	size_t size;
+	unsigned int nregions;
+	struct {
+		const char *name;
+		u8 id;
+		u64 offset;
+		u64 size;
+	} regions[];
+};
+
+static void intel_dg_spi_release(struct kref *kref)
+{
+	struct intel_dg_spi *spi = container_of(kref, struct intel_dg_spi, refcnt);
+	int i;
+
+	pr_debug("freeing spi memory\n");
+	for (i = 0; i < spi->nregions; i++)
+		kfree(spi->regions[i].name);
+	kfree(spi);
+}
+
+static int intel_dg_spi_probe(struct auxiliary_device *aux_dev,
+			      const struct auxiliary_device_id *aux_dev_id)
+{
+	struct intel_dg_spi_dev *ispi = auxiliary_dev_to_intel_dg_spi_dev(aux_dev);
+	struct device *device;
+	struct intel_dg_spi *spi;
+	unsigned int nregions;
+	unsigned int i, n;
+	size_t size;
+	char *name;
+	size_t name_size;
+	int ret;
+
+	device = &aux_dev->dev;
+
+	/* count available regions */
+	for (nregions = 0, i = 0; i < INTEL_DG_SPI_REGIONS; i++) {
+		if (ispi->regions[i].name)
+			nregions++;
+	}
+
+	if (!nregions) {
+		dev_err(device, "no regions defined\n");
+		return -ENODEV;
+	}
+
+	size = sizeof(*spi) + sizeof(spi->regions[0]) * nregions;
+	spi = kzalloc(size, GFP_KERNEL);
+	if (!spi)
+		return -ENOMEM;
+
+	kref_init(&spi->refcnt);
+
+	spi->nregions = nregions;
+	for (n = 0, i = 0; i < INTEL_DG_SPI_REGIONS; i++) {
+		if (ispi->regions[i].name) {
+			name_size = strlen(dev_name(&aux_dev->dev)) +
+				    strlen(ispi->regions[i].name) + 2; /* for point */
+			name = kzalloc(name_size, GFP_KERNEL);
+			if (!name)
+				continue;
+			snprintf(name, name_size, "%s.%s",
+				 dev_name(&aux_dev->dev), ispi->regions[i].name);
+			spi->regions[n].name = name;
+			spi->regions[n].id = i;
+			n++;
+		}
+	}
+
+	spi->base = devm_ioremap_resource(device, &ispi->bar);
+	if (IS_ERR(spi->base)) {
+		dev_err(device, "mmio not mapped\n");
+		ret = PTR_ERR(spi->base);
+		goto err;
+	}
+
+	dev_set_drvdata(&aux_dev->dev, spi);
+
+	return 0;
+
+err:
+	kref_put(&spi->refcnt, intel_dg_spi_release);
+	return ret;
+}
+
+static void intel_dg_spi_remove(struct auxiliary_device *aux_dev)
+{
+	struct intel_dg_spi *spi = dev_get_drvdata(&aux_dev->dev);
+
+	if (!spi)
+		return;
+
+	dev_set_drvdata(&aux_dev->dev, NULL);
+
+	kref_put(&spi->refcnt, intel_dg_spi_release);
+}
+
+static const struct auxiliary_device_id intel_dg_spi_id_table[] = {
+	{
+		.name = "i915.spi",
+	},
+	{
+		.name = "xe.spi",
+	},
+	{
+		/* sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(auxiliary, intel_dg_spi_id_table);
+
+static struct auxiliary_driver intel_dg_spi_driver = {
+	.probe  = intel_dg_spi_probe,
+	.remove = intel_dg_spi_remove,
+	.driver = {
+		/* auxiliary_driver_register() sets .name to be the modname */
+	},
+	.id_table = intel_dg_spi_id_table
+};
+
+module_auxiliary_driver(intel_dg_spi_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Intel Corporation");
+MODULE_DESCRIPTION("Intel DGFX SPI driver");
diff --git a/include/linux/intel_dg_spi_aux.h b/include/linux/intel_dg_spi_aux.h
new file mode 100644
index 000000000000..d4c3830d56d6
--- /dev/null
+++ b/include/linux/intel_dg_spi_aux.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright(c) 2019-2024, Intel Corporation. All rights reserved.
+ */
+
+#ifndef __INTEL_DG_SPI_AUX_H__
+#define __INTEL_DG_SPI_AUX_H__
+
+#include <linux/auxiliary_bus.h>
+
+#define INTEL_DG_SPI_REGIONS 13
+
+struct intel_dg_spi_region {
+	const char *name;
+};
+
+struct intel_dg_spi_dev {
+	struct auxiliary_device aux_dev;
+	bool writeable_override;
+	struct resource bar;
+	const struct intel_dg_spi_region *regions;
+};
+
+#define auxiliary_dev_to_intel_dg_spi_dev(auxiliary_dev) \
+	container_of(auxiliary_dev, struct intel_dg_spi_dev, aux_dev)
+
+#endif /* __INTEL_DG_SPI_AUX_H__ */
-- 
2.34.1


