Return-Path: <linux-spi+bounces-2211-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C79D489C17B
	for <lists+linux-spi@lfdr.de>; Mon,  8 Apr 2024 15:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52DE1B273E9
	for <lists+linux-spi@lfdr.de>; Mon,  8 Apr 2024 13:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080477CF1B;
	Mon,  8 Apr 2024 13:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f10Na4j9"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CF57C0BE
	for <linux-spi@vger.kernel.org>; Mon,  8 Apr 2024 13:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581890; cv=none; b=dlwyFqppr3K4i2V2gJn6PZs4vJLU4vlYn1Wj1NrOLCmpFoQBuDEA+LpRrQ0GGglOZgPnNau9Yep5GvgWXyec90ru9EqM5D1uTfzMY3lGAEmg2inX784jpJTWXOdZ5aJ9yIdKafEobbFGbZe+yoqMPs2UIbukWM3aTHhWqLzjvv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581890; c=relaxed/simple;
	bh=zJgAEDHy5k4bmFwPD1XA/hrx/AZPo9NmR1Y4WcD3iec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lPDnztmdTqmaKEHPaS0i6Z2uqd2IigTDFbjxzEKIlHOQVZuZa2HP1tVouqfEVuzm1dkg/VtLmo0IQuAvZ5M8rph1tWRxgPNJGx5YDVgg/jIPF9QrKNPHH/8Uxxl6TKIcC4BLJkzOqDtXrg22VgNKDIQ2tqR2B9+GJYrVVaIeSAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f10Na4j9; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712581889; x=1744117889;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zJgAEDHy5k4bmFwPD1XA/hrx/AZPo9NmR1Y4WcD3iec=;
  b=f10Na4j9d9vZ8J5xvT8IWDC3OBjB/wdq5vpqdWyQvjbUAFMYrE5a/bwJ
   nJ5htW/imm3PsMPiokEnV/+sCUxsmImbicQFJaJzI2NiMwOZkLAiAO3xD
   Qc+WEoao9kjfh+E4OZI59aaxAp/XYT0Dt74rmSfruOHYv8B1Df7R/2GQD
   beD5oHLomrpAdfaWLo6iKkDwLU34lYV8b+J7BegewLqN2aEbvhf5V9HTp
   wChLk6L+fS3zYDSjQ5a5K/kOrMGny947/xm96rLS++sGzqwm3k6xhTIEn
   4Cia7nMouKUncez1XTHSt/QgX0+g+vDv43y7PdCL1p4GgafQJNE1ytIe/
   A==;
X-CSE-ConnectionGUID: ytEfC8tGQLetA7SVztUw+Q==
X-CSE-MsgGUID: giObkYaZRHOtMmKTg5Bb2g==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="11632340"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="11632340"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 06:11:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="937091507"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="937091507"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Apr 2024 06:11:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 3293E24D; Mon,  8 Apr 2024 16:11:24 +0300 (EEST)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: Tomas Winkler <tomas.winkler@intel.com>,
	Tamar Mashiah <tamar.mashiah@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-spi@vger.kernel.org
Subject: [PATCH] spi: intel: Add protected and locked attributes
Date: Mon,  8 Apr 2024 16:11:24 +0300
Message-ID: <20240408131124.62709-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tamar Mashiah <tamar.mashiah@intel.com>

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

Signed-off-by: Tamar Mashiah <tamar.mashiah@intel.com>
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
index 000000000000..5b3e425f0e14
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-spi-intel
@@ -0,0 +1,20 @@
+What:		/sys/devices/.../intel_spi_protected
+Date:		July 2024
+KernelVersion:	6.10
+Contact:	Tomas Winkler <tomas.winkler@intel.com>
+Description:	This attribute allows the userspace to check if the
+		Intel SPI flash controller is write protected from the host.
+
+What:		/sys/devices/.../intel_spi_locked
+Date:		July 2024
+KernelVersion:	6.10
+Contact:	Tomas Winkler <tomas.winkler@intel.com>
+Description:	This attribute allows the user space to check if the
+		Intel SPI flash controller locks supported opcodes.
+
+What:		/sys/devices/.../intel_spi_bios_locked
+Date:		July 2024
+KernelVersion:	6.10
+Contact:	Tomas Winkler <tomas.winkler@intel.com>
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
index 3e5dcf2b3c8a..f5109531a6c6 100644
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
@@ -1408,6 +1417,50 @@ static int intel_spi_populate_chip(struct intel_spi *ispi)
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
@@ -1448,6 +1501,7 @@ int intel_spi_probe(struct device *dev, struct resource *mem,
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
2.43.0


