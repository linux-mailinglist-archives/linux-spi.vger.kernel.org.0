Return-Path: <linux-spi+bounces-5163-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7B7995F81
	for <lists+linux-spi@lfdr.de>; Wed,  9 Oct 2024 08:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD3771F247F0
	for <lists+linux-spi@lfdr.de>; Wed,  9 Oct 2024 06:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AECE157A5C;
	Wed,  9 Oct 2024 06:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KP23DlD4"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286E836D
	for <linux-spi@vger.kernel.org>; Wed,  9 Oct 2024 06:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728454330; cv=none; b=kNxx/a1N8DN4/Ns0ORx5OP+WPoCqYaTJBxKDo9En6IFDl/HUSO/sX/8xigeDQ0FVMaTGfJwdI2RWhjEwUgGq0KLMyNj5lCiTHzgNq3/guIQ0+K2AYctJiWafWyqdImyPN6GM87zKofK7OX/nLBIcRhPBkhGpij7xhxJ4+Ebq5zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728454330; c=relaxed/simple;
	bh=OWlaCLIVezjngmhOTUxP9S8ztWBHidUoVKsMp79Q7UM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uZTTNtLyGY2HerBQYCNXd/4UaGI4fBhUol1Sxi4Qa5T/k36Qe4/CyK1wEUFLpxBVpjgHQjdVO1klWLjUWiVsmSEssHFx6GgL5Cd8o7NC7gQj//kYrZY8NAk2unkk8pf2NOlBknqFnab0zcDeI3VwMeQC9/+SswpuYZ13twRCgMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KP23DlD4; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728454329; x=1759990329;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OWlaCLIVezjngmhOTUxP9S8ztWBHidUoVKsMp79Q7UM=;
  b=KP23DlD4xjudSkBpwfYJOgVQJ5g5RV9hU+dQkhS6wgHkdPNRj6HmeHIq
   z7yfGMulhvtTGOsEXuMbyETni7GVX1tFi3M4qBrxO+rvTbVsHDFWveYWf
   aigXxqRJOmd2AMTz7N3f/P+Fd8a6xlhVUlS767gj8zNDzZPVvZx/CmzxI
   g0ekIoGYUnhLuit1tLpKwOBLGHvljk1RIo4Fh3UPcvki2KPsDi1qT/Lcc
   DgIP7ShfUqsbvvP2zaH1Lo/TYGDaa+OkNxYdqBKAwEs+O/SepXb1BeBLO
   J63YPqwyR8rlBj6KgZVv5zSZOz88swFgJcmUzgdBVzpqwJvw0q4/QNI8F
   g==;
X-CSE-ConnectionGUID: CbTE+WcXSrugrOV66nPsZg==
X-CSE-MsgGUID: ltyX6nH4TSWQKQwpKYvYyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="45198020"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="45198020"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 23:12:06 -0700
X-CSE-ConnectionGUID: ySJGerwRT+KjSR+1rFXaRQ==
X-CSE-MsgGUID: mNh4O9KKQZeDvdnwlaGr3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="81158684"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 08 Oct 2024 23:12:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id CBDE228E; Wed, 09 Oct 2024 09:12:02 +0300 (EEST)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-spi@vger.kernel.org
Subject: [PATCH] spi: intel: Add protected and locked attributes
Date: Wed,  9 Oct 2024 09:12:02 +0300
Message-ID: <20241009061202.2436300-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Usyskin <alexander.usyskin@intel.com>

The manufacturing access to the PCH/SoC SPI device is traditionally
performed via userspace driver accessing registers via /dev/mem but due
to security concerns /dev/mem access is being much restricted, hence the
reason for utilizing dedicated Intel PCH/SoC SPI controller driver,
which is already implemented in the Linux kernel.

Intel PCH/SoC SPI controller protects the flash storage via two
mechanisms one is the via region protection registers and second via
BIOS lock. The BIOS locks only the BIOS regions usually 0 and/or 6.

The device always boots with BIOS lock set, but during manufacturing the
BIOS lock has to be lifted in order to enable the write access. This can
be done by passing "writeable=1" in the command line when the driver is
loaded. This "locked" state is exposed through new sysfs attributes
(intel_spi_locked, intel_spi_bios_locked).

Second, also the region protection status is exposed via sysfs attribute
(intel_spi_protected) as the manufacturing will need the both files in
order to validate that the device is properly sealed.

Includes code written by Tamar Mashiah.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Co-developed-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 .../ABI/testing/sysfs-driver-spi-intel        | 20 ++++++
 drivers/spi/spi-intel-pci.c                   |  1 +
 drivers/spi/spi-intel-platform.c              |  1 +
 drivers/spi/spi-intel.c                       | 64 +++++++++++++++++--
 drivers/spi/spi-intel.h                       |  2 +
 5 files changed, 83 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-spi-intel

diff --git a/Documentation/ABI/testing/sysfs-driver-spi-intel b/Documentation/ABI/testing/sysfs-driver-spi-intel
new file mode 100644
index 000000000000..d7c9139ddbf3
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-spi-intel
@@ -0,0 +1,20 @@
+What:		/sys/devices/.../intel_spi_protected
+Date:		Feb 2025
+KernelVersion:	6.13
+Contact:	Alexander Usyskin <alexander.usyskin@intel.com>
+Description:	This attribute allows the userspace to check if the
+		Intel SPI flash controller is write protected from the host.
+
+What:		/sys/devices/.../intel_spi_locked
+Date:		Feb 2025
+KernelVersion:	6.13
+Contact:	Alexander Usyskin <alexander.usyskin@intel.com>
+Description:	This attribute allows the user space to check if the
+		Intel SPI flash controller locks supported opcodes.
+
+What:		/sys/devices/.../intel_spi_bios_locked
+Date:		Feb 2025
+KernelVersion:	6.13
+Contact:	Alexander Usyskin <alexander.usyskin@intel.com>
+Description:	This attribute allows the user space to check if the
+		Intel SPI flash controller BIOS region is locked for writes.
diff --git a/drivers/spi/spi-intel-pci.c b/drivers/spi/spi-intel-pci.c
index 4337ca51d7aa..c3b54928143d 100644
--- a/drivers/spi/spi-intel-pci.c
+++ b/drivers/spi/spi-intel-pci.c
@@ -94,6 +94,7 @@ static struct pci_driver intel_spi_pci_driver = {
 	.name = "intel-spi",
 	.id_table = intel_spi_pci_ids,
 	.probe = intel_spi_pci_probe,
+	.dev_groups = intel_spi_groups,
 };
 
 module_pci_driver(intel_spi_pci_driver);
diff --git a/drivers/spi/spi-intel-platform.c b/drivers/spi/spi-intel-platform.c
index 2ef09fa35661..0974cca83a5d 100644
--- a/drivers/spi/spi-intel-platform.c
+++ b/drivers/spi/spi-intel-platform.c
@@ -28,6 +28,7 @@ static struct platform_driver intel_spi_platform_driver = {
 	.probe = intel_spi_platform_probe,
 	.driver = {
 		.name = "intel-spi",
+		.dev_groups = intel_spi_groups,
 	},
 };
 
diff --git a/drivers/spi/spi-intel.c b/drivers/spi/spi-intel.c
index 795b7e72baea..b0dcdb6fb8fa 100644
--- a/drivers/spi/spi-intel.c
+++ b/drivers/spi/spi-intel.c
@@ -148,6 +148,8 @@
  * @pr_num: Maximum number of protected range registers
  * @chip0_size: Size of the first flash chip in bytes
  * @locked: Is SPI setting locked
+ * @protected: Whether the regions are write protected
+ * @bios_locked: Is BIOS region locked
  * @swseq_reg: Use SW sequencer in register reads/writes
  * @swseq_erase: Use SW sequencer in erase operation
  * @atomic_preopcode: Holds preopcode when atomic sequence is requested
@@ -166,6 +168,8 @@ struct intel_spi {
 	size_t pr_num;
 	size_t chip0_size;
 	bool locked;
+	bool protected;
+	bool bios_locked;
 	bool swseq_reg;
 	bool swseq_erase;
 	u8 atomic_preopcode;
@@ -1109,10 +1113,13 @@ static int intel_spi_init(struct intel_spi *ispi)
 		return -EINVAL;
 	}
 
-	/* Try to disable write protection if user asked to do so */
-	if (writeable && !intel_spi_set_writeable(ispi)) {
-		dev_warn(ispi->dev, "can't disable chip write protection\n");
-		writeable = false;
+	ispi->bios_locked = true;
+	/* Try to disable BIOS write protection if user asked to do so */
+	if (writeable) {
+		if (intel_spi_set_writeable(ispi))
+			ispi->bios_locked = false;
+		else
+			dev_warn(ispi->dev, "can't disable chip write protection\n");
 	}
 
 	/* Disable #SMI generation from HW sequencer */
@@ -1247,8 +1254,10 @@ static void intel_spi_fill_partition(struct intel_spi *ispi,
 		 * Also if the user did not ask the chip to be writeable
 		 * mask the bit too.
 		 */
-		if (!writeable || intel_spi_is_protected(ispi, base, limit))
+		if (!writeable || intel_spi_is_protected(ispi, base, limit)) {
 			part->mask_flags |= MTD_WRITEABLE;
+			ispi->protected = true;
+		}
 
 		end = (limit << 12) + 4096;
 		if (end > part->size)
@@ -1411,6 +1420,50 @@ static int intel_spi_populate_chip(struct intel_spi *ispi)
 	return 0;
 }
 
+static ssize_t intel_spi_protected_show(struct device *dev,
+					struct device_attribute *attr, char *buf)
+{
+	struct intel_spi *ispi = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", ispi->protected);
+}
+static DEVICE_ATTR_ADMIN_RO(intel_spi_protected);
+
+static ssize_t intel_spi_locked_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct intel_spi *ispi = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", ispi->locked);
+}
+static DEVICE_ATTR_ADMIN_RO(intel_spi_locked);
+
+static ssize_t intel_spi_bios_locked_show(struct device *dev,
+					  struct device_attribute *attr, char *buf)
+{
+	struct intel_spi *ispi = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", ispi->bios_locked);
+}
+static DEVICE_ATTR_ADMIN_RO(intel_spi_bios_locked);
+
+static struct attribute *intel_spi_attrs[] = {
+	&dev_attr_intel_spi_protected.attr,
+	&dev_attr_intel_spi_locked.attr,
+	&dev_attr_intel_spi_bios_locked.attr,
+	NULL
+};
+
+static const struct attribute_group intel_spi_attr_group = {
+	.attrs = intel_spi_attrs,
+};
+
+const struct attribute_group *intel_spi_groups[] = {
+	&intel_spi_attr_group,
+	NULL
+};
+EXPORT_SYMBOL_GPL(intel_spi_groups);
+
 /**
  * intel_spi_probe() - Probe the Intel SPI flash controller
  * @dev: Pointer to the parent device
@@ -1451,6 +1504,7 @@ int intel_spi_probe(struct device *dev, struct resource *mem,
 	if (ret)
 		return ret;
 
+	dev_set_drvdata(dev, ispi);
 	return intel_spi_populate_chip(ispi);
 }
 EXPORT_SYMBOL_GPL(intel_spi_probe);
diff --git a/drivers/spi/spi-intel.h b/drivers/spi/spi-intel.h
index a4f0327a46ff..c5f35060dd63 100644
--- a/drivers/spi/spi-intel.h
+++ b/drivers/spi/spi-intel.h
@@ -13,6 +13,8 @@
 
 struct resource;
 
+extern const struct attribute_group *intel_spi_groups[];
+
 int intel_spi_probe(struct device *dev, struct resource *mem,
 		    const struct intel_spi_boardinfo *info);
 
-- 
2.45.2


