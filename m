Return-Path: <linux-spi+bounces-7393-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC21A78DFB
	for <lists+linux-spi@lfdr.de>; Wed,  2 Apr 2025 14:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FE6516C12C
	for <lists+linux-spi@lfdr.de>; Wed,  2 Apr 2025 12:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D327F1D7E57;
	Wed,  2 Apr 2025 12:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KVuOvmmB"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2056.outbound.protection.outlook.com [40.107.96.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B676C53BE;
	Wed,  2 Apr 2025 12:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743596143; cv=fail; b=h3RcE/LzuLftQQmzVqxZBJh+3XWcySkQv8wOsQwOSeLz6oA/oPjNWM38CcWEne2mWfwbBylBvDDqjWVy5GbQScCU4dNixdOxEmmjSPOL3O3/rlA4zs11VKCzwrumYahHk7M4tZanUNjrWHGWAOzQNbfznk5OJkO1M2KPU5lRq0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743596143; c=relaxed/simple;
	bh=Zm/h25qm+xiIS5uMvkO5mFOtOjXAfl2K/iQPWxMPHFs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GnfGbKnnEs+XgkMrwCCqZLTglvqZg6M7RnbLBNqpeewmh+GxBSWLOV6EudQyi5up6bmU/+/rZvkG32FihLxWGc4pn4yrReuM7RePhCqnmqooakHsiEp0QgHykT2xCGEtxNUWWOu2+eLIf6RMid5fx76CI8oBoSg+cOg9EHqEWHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KVuOvmmB; arc=fail smtp.client-ip=40.107.96.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/KEdOkOzqf8j8l8KxKzLA8mMTtXxYuQog1uNkdRHHgqTUr/zRxM7UWe2Hrnlx/+yxUczrrt8YrEjyhu7C96qStW/EJlXUtLOCa6QP+PMVfDf9dWU4Q2JjvvkHyrH7naP+OtqXOlOjXBnF6zmp51yt3Y7JQk7A3BvhD0cttKS979QgRcB9goz4w2QeFkSSLyaTEJ4ysUPNYamUED3m9laIfR2bzykWh/aWYdThnlTdAqWwwZTPhdNzKpftLEpJT15Me8wE3oTFQbNqVzH3+Y6dk9xmJiANHXQarJloyT2LvxWfGTn0fZCRX1+5v18hh6bOt3hBGHGk1DAex5lM+5Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aG08prPEixd6UtL9Rg9XLAzc1DnoxQ6fj9/W0mWogpw=;
 b=h50Wj+cJOHFODC2dSEn0iCpPhZRPboX4NBRbYGzRIgZHd4u8PF/bs9Ry32hdOhZ2+Me/PDWKI3ak77p2rwcWMmv6c6yhRAOVZMnhLZMkU+DAhV+pS1rrBJ4UloUMW/8+VLwfGgzenVcuy1H9hfKMgRSc8iwusq1BYRQGy5SKx6rw0GKSdtg99FcZWUcTVynKqgbghbocmiWId0JDUX3o+P8G0MIsy/qpeLZwWXnEf7A9xnbk4/cmU+89LP4LlCInoLUxZdsiXwOU4UA2isuSFR/FiUonN6W6+5/YnikIiNjFwZ9C9o/kWNI+IhizJ9DHU+hEX0TJlxbcv19lRHl0aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aG08prPEixd6UtL9Rg9XLAzc1DnoxQ6fj9/W0mWogpw=;
 b=KVuOvmmBEbcvlDXSIHz/oTzkublIrFxctb2C+aShTIsYEPiNzFLPUCoFQWcEkf5m7/iMYv0QOmOn8ImSULtILXNpjf2mDDnfiLAGedpkZ+5GNXuGUAR5eTd06QdMk9FZfMECy+3IU9BaZGAt6+igEsP0gIlkz+Yrz5nnmzWlgpI=
Received: from BL0PR05CA0020.namprd05.prod.outlook.com (2603:10b6:208:91::30)
 by MW3PR12MB4345.namprd12.prod.outlook.com (2603:10b6:303:59::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 12:15:39 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::44) by BL0PR05CA0020.outlook.office365.com
 (2603:10b6:208:91::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.22 via Frontend Transport; Wed,
 2 Apr 2025 12:15:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Wed, 2 Apr 2025 12:15:38 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Apr
 2025 07:15:35 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <broonie@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-spi@vger.kernel.org>
CC: Raju Rangoju <Raju.Rangoju@amd.com>, Krishnamoorthi M
	<krishnamoorthi.m@amd.com>, Akshata MukundShetty
	<akshata.mukundshetty@amd.com>
Subject: [PATCH] spi: spi_amd: Add PCI-based driver for AMD HID2 SPI controller
Date: Wed, 2 Apr 2025 17:45:14 +0530
Message-ID: <20250402121514.2941334-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|MW3PR12MB4345:EE_
X-MS-Office365-Filtering-Correlation-Id: d1a34444-45d9-48ef-a30e-08dd71e01495
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H84VQa/HkLRCW+jFF00gPV6IwTggzg/7PuShldVNBe3nTYJOoEbzw4E6T+od?=
 =?us-ascii?Q?dQ3iKzgkGUlAt8j2fL5Quc2diqy90xMFUBy0rSiKr2ehtqRIM45cw2QsUYIH?=
 =?us-ascii?Q?tpH6v+s3d98sA7OZs7K9idLdWUjDcDKvfhseNQNWdh/LVWszGdj2h3Q5b9sy?=
 =?us-ascii?Q?OPGe4wBLk64BAgJFw9L989Xicb6jRLhkxdhV46Ma7v2OXBb7/IG8DWb1ms3L?=
 =?us-ascii?Q?cgFlV4ajkVF8jq7dNHuq/Kcjq16YaR24kG7RYLiqGKVHibL5Uhfl8kxKdOiS?=
 =?us-ascii?Q?7jwWtsjsrPYHQ78dUthrlgaalpRk7EkzwdcuFxKtv5bgHM7ajv1FpipL7wi/?=
 =?us-ascii?Q?Be/0GgU24WYOgMA3HJ+i/LNSgTVrzqa/1X4YjPzZbCNSqdVUsk8H5HLFvlId?=
 =?us-ascii?Q?eWvTKRm7f9J6QqiDX4DA75tcFBK0VGvyy34tMVeNTAXHfCD5FnrskkvFK/jP?=
 =?us-ascii?Q?gkOx//7OY4LVXzTrYY2/3cdYYqWAXLJGT9fatVom0hWZE/ByJi34Dm9RXl9O?=
 =?us-ascii?Q?HLuDKve9XR9657IXxDj5dQNR+heSWRQ/UFRrqs+V7HG2SJw9teQD5c/ViD9f?=
 =?us-ascii?Q?Vo4KSQ+fs85X/GKb4wxA59BoxT6B0FRZjP7B+cb7WR4au/29C4eVH7wQP2Dj?=
 =?us-ascii?Q?KVwZaeoL/azv90SAMFOjk0HQsgZEaWEY2cCToHY5hkkTeswpN11ep4t22t1O?=
 =?us-ascii?Q?afETNlGoqR2dQr9he3Uf/9WEU6/SP5aJ5gTuUtgbO6RODCZoHtGTcjGM8GZg?=
 =?us-ascii?Q?MOV8/0SYg5WY3QxmeVXuMfgQJtjadk0i21VBjyfN2UC2DzWig64WKDIXy2kU?=
 =?us-ascii?Q?SD/MQ98aFSwh6mDbwhVUymkVZjBxOcvbX79KfjHMkLrZQL6fhMhX6/WrJJsX?=
 =?us-ascii?Q?44zGy6568bFg+VXTrtS2uatFaECgWORdK0qn3zOMH4xpvPT7NLC0MczUY7sz?=
 =?us-ascii?Q?3vEOWV8b6qxFDI3CPtFsGiYVJuwOfUeFU836MdKJYORA5c3xzZzkV4OHv65b?=
 =?us-ascii?Q?RECsPS3t07QL9cEDX7YW4mpWLGUP5/tt+ZvPfoOoa6QvwVjLBlRCf2hS8eRW?=
 =?us-ascii?Q?feRmfKmIN3HKDS12kEWNva3O6shQ9ct9PcyWA+eFuF+yTwtB+OEpkdtmK8uT?=
 =?us-ascii?Q?8ANWhWQA30T1rOkLOECyj8ocR3JXS6kv70oM/uwv0rgycxcaq3QV+3UVg3qn?=
 =?us-ascii?Q?P36V4CfYipzpTp+jkmaLXhXWSqpzjcug6fuYJ1oir1FmRVbiv/vx3ajAFpve?=
 =?us-ascii?Q?PU0WGBvwnsNYQNnIEzGIN/d0+MTwlDz1ZuGVOX+fMgFLSO4j7d3cUApv/yth?=
 =?us-ascii?Q?JBFxl4M1d0pCmNV6IvRT5oYzB5HoqZMhcIemUNaApB9ASqe5NaPQDr0ethF6?=
 =?us-ascii?Q?v8WxJ0UGQZExYx7sMHOWBnxvFhUgKu0SwMJiGTKyBHg8nhOqGg/upu8SspRc?=
 =?us-ascii?Q?c3eHkpKgvY0hN64VKvVxLuGmKvKPUE+G94gKau/xLefcMI3htYgBhqgr+xqi?=
 =?us-ascii?Q?VpSLWCM9Ufxignk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 12:15:38.7973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a34444-45d9-48ef-a30e-08dd71e01495
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4345

Register a new driver(spi_amd_pci) for the HID2 SPI controller using the
PCI ID of the LPC bridge device.

Add a new common probe function in spi_amd driver to encapsulate the
code required for registering the controller driver. This function will be
utilized by both the existing ACPI driver and the newly introduced
PCI-based driver for the HID2 SPI controller. The MMIO register base
address of the HID2 SPI controller can be obtained from the PCI LPC bridge
registers.

By implementing these changes, the DMA buffer will be correctly associated
with the LPC bridge device, preventing IO_PAGE_FAULT caused by IOMMU when
the LPC bridge attempts DMA operations on addresses owned by the HID2
SPI controller.

Co-developed-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 MAINTAINERS               |  2 +
 drivers/spi/Makefile      |  2 +-
 drivers/spi/spi-amd-pci.c | 70 +++++++++++++++++++++++++++++++++++
 drivers/spi/spi-amd.c     | 78 +++++++++++++++------------------------
 drivers/spi/spi-amd.h     | 44 ++++++++++++++++++++++
 5 files changed, 147 insertions(+), 49 deletions(-)
 create mode 100644 drivers/spi/spi-amd-pci.c
 create mode 100644 drivers/spi/spi-amd.h

diff --git a/MAINTAINERS b/MAINTAINERS
index d5dfb9186962..cd7b81c40ee4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1216,7 +1216,9 @@ AMD SPI DRIVER
 M:	Raju Rangoju <Raju.Rangoju@amd.com>
 L:	linux-spi@vger.kernel.org
 S:	Supported
+F:	drivers/spi/spi-amd-pci.c
 F:	drivers/spi/spi-amd.c
+F:	drivers/spi/spi-amd.h
 
 AMD XDNA DRIVER
 M:	Min Ma <min.ma@amd.com>
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index c3a1a47b3bf4..4ea89f6fc531 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -162,7 +162,7 @@ obj-$(CONFIG_SPI_XLP)			+= spi-xlp.o
 obj-$(CONFIG_SPI_XTENSA_XTFPGA)		+= spi-xtensa-xtfpga.o
 obj-$(CONFIG_SPI_ZYNQ_QSPI)		+= spi-zynq-qspi.o
 obj-$(CONFIG_SPI_ZYNQMP_GQSPI)		+= spi-zynqmp-gqspi.o
-obj-$(CONFIG_SPI_AMD)			+= spi-amd.o
+obj-$(CONFIG_SPI_AMD)			+= spi-amd.o spi-amd-pci.o
 
 # SPI slave protocol handlers
 obj-$(CONFIG_SPI_SLAVE_TIME)		+= spi-slave-time.o
diff --git a/drivers/spi/spi-amd-pci.c b/drivers/spi/spi-amd-pci.c
new file mode 100644
index 000000000000..e1ecab755fe9
--- /dev/null
+++ b/drivers/spi/spi-amd-pci.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * AMD SPI controller driver
+ *
+ * Copyright (c) 2025, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Authors: Krishnamoorthi M <krishnamoorthi.m@amd.com>
+ *          Akshata MukundShetty <akshata.mukundshetty@amd.com>
+ */
+
+#include <linux/init.h>
+#include <linux/spi/spi.h>
+#include <linux/pci.h>
+
+#include "spi-amd.h"
+
+#define AMD_PCI_DEVICE_ID_LPC_BRIDGE		0x1682
+#define AMD_PCI_LPC_SPI_BASE_ADDR_REG		0xA0
+#define AMD_SPI_BASE_ADDR_MASK			~0xFF
+#define AMD_HID2_PCI_BAR_OFFSET			0x00002000
+#define AMD_HID2_MEM_SIZE			0x200
+
+static struct pci_device_id pci_spi_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_PCI_DEVICE_ID_LPC_BRIDGE) },
+	{ 0, }
+};
+MODULE_DEVICE_TABLE(pci, pci_spi_ids);
+
+static int amd_spi_pci_probe(struct pci_dev *pdev,
+			     const struct pci_device_id *id)
+{
+	struct device *dev = &pdev->dev;
+	struct spi_controller *host;
+	struct amd_spi *amd_spi;
+	u32 io_base_addr;
+
+	/* Allocate storage for host and driver private data */
+	host = devm_spi_alloc_host(dev, sizeof(struct amd_spi));
+	if (!host)
+		return dev_err_probe(dev, -ENOMEM, "Error allocating SPI host\n");
+
+	amd_spi = spi_controller_get_devdata(host);
+
+	pci_read_config_dword(pdev, AMD_PCI_LPC_SPI_BASE_ADDR_REG, &io_base_addr);
+	io_base_addr = (io_base_addr & AMD_SPI_BASE_ADDR_MASK) + AMD_HID2_PCI_BAR_OFFSET;
+	amd_spi->io_remap_addr = devm_ioremap(dev, io_base_addr, AMD_HID2_MEM_SIZE);
+
+	if (IS_ERR(amd_spi->io_remap_addr))
+		return dev_err_probe(dev, PTR_ERR(amd_spi->io_remap_addr),
+				"ioremap of SPI registers failed\n");
+
+	dev_dbg(dev, "io_remap_address: %p\n", amd_spi->io_remap_addr);
+
+	amd_spi->version = AMD_HID2_SPI;
+	host->bus_num = 2;
+
+	return amd_spi_probe_common(dev, host);
+}
+
+static struct pci_driver amd_spi_pci_driver = {
+	.name = "amd_spi_pci",
+	.id_table = pci_spi_ids,
+	.probe = amd_spi_pci_probe,
+};
+
+module_pci_driver(amd_spi_pci_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("AMD HID2 SPI Controller Driver");
diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index c85997478b81..2aed81215443 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -17,6 +17,8 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
 
+#include "spi-amd.h"
+
 #define AMD_SPI_CTRL0_REG	0x00
 #define AMD_SPI_EXEC_CMD	BIT(16)
 #define AMD_SPI_FIFO_CLEAR	BIT(20)
@@ -81,18 +83,6 @@
 #define AMD_SPI_OP_READ_1_1_4_4B	0x6c    /* Read data bytes (Quad Output SPI) */
 #define AMD_SPI_OP_READ_1_4_4_4B	0xec    /* Read data bytes (Quad I/O SPI) */
 
-/**
- * enum amd_spi_versions - SPI controller versions
- * @AMD_SPI_V1:		AMDI0061 hardware version
- * @AMD_SPI_V2:		AMDI0062 hardware version
- * @AMD_HID2_SPI:	AMDI0063 hardware version
- */
-enum amd_spi_versions {
-	AMD_SPI_V1 = 1,
-	AMD_SPI_V2,
-	AMD_HID2_SPI,
-};
-
 enum amd_spi_speed {
 	F_66_66MHz,
 	F_33_33MHz,
@@ -118,22 +108,6 @@ struct amd_spi_freq {
 	u32 spd7_val;
 };
 
-/**
- * struct amd_spi - SPI driver instance
- * @io_remap_addr:	Start address of the SPI controller registers
- * @phy_dma_buf:	Physical address of DMA buffer
- * @dma_virt_addr:	Virtual address of DMA buffer
- * @version:		SPI controller hardware version
- * @speed_hz:		Device frequency
- */
-struct amd_spi {
-	void __iomem *io_remap_addr;
-	dma_addr_t phy_dma_buf;
-	void *dma_virt_addr;
-	enum amd_spi_versions version;
-	unsigned int speed_hz;
-};
-
 static inline u8 amd_spi_readreg8(struct amd_spi *amd_spi, int idx)
 {
 	return readb((u8 __iomem *)amd_spi->io_remap_addr + idx);
@@ -749,30 +723,12 @@ static int amd_spi_setup_hiddma(struct amd_spi *amd_spi, struct device *dev)
 	return 0;
 }
 
-static int amd_spi_probe(struct platform_device *pdev)
+int amd_spi_probe_common(struct device *dev, struct spi_controller *host)
 {
-	struct device *dev = &pdev->dev;
-	struct spi_controller *host;
-	struct amd_spi *amd_spi;
+	struct amd_spi *amd_spi = spi_controller_get_devdata(host);
 	int err;
 
-	/* Allocate storage for host and driver private data */
-	host = devm_spi_alloc_host(dev, sizeof(struct amd_spi));
-	if (!host)
-		return dev_err_probe(dev, -ENOMEM, "Error allocating SPI host\n");
-
-	amd_spi = spi_controller_get_devdata(host);
-	amd_spi->io_remap_addr = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(amd_spi->io_remap_addr))
-		return dev_err_probe(dev, PTR_ERR(amd_spi->io_remap_addr),
-				     "ioremap of SPI registers failed\n");
-
-	dev_dbg(dev, "io_remap_address: %p\n", amd_spi->io_remap_addr);
-
-	amd_spi->version = (uintptr_t) device_get_match_data(dev);
-
 	/* Initialize the spi_controller fields */
-	host->bus_num = (amd_spi->version == AMD_HID2_SPI) ? 2 : 0;
 	host->num_chipselect = 4;
 	host->mode_bits = SPI_TX_DUAL | SPI_TX_QUAD | SPI_RX_DUAL | SPI_RX_QUAD;
 	host->flags = SPI_CONTROLLER_HALF_DUPLEX;
@@ -795,6 +751,32 @@ static int amd_spi_probe(struct platform_device *pdev)
 
 	return err;
 }
+EXPORT_SYMBOL_GPL(amd_spi_probe_common);
+
+static int amd_spi_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct spi_controller *host;
+	struct amd_spi *amd_spi;
+
+	/* Allocate storage for host and driver private data */
+	host = devm_spi_alloc_host(dev, sizeof(struct amd_spi));
+	if (!host)
+		return dev_err_probe(dev, -ENOMEM, "Error allocating SPI host\n");
+
+	amd_spi = spi_controller_get_devdata(host);
+	amd_spi->io_remap_addr = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(amd_spi->io_remap_addr))
+		return dev_err_probe(dev, PTR_ERR(amd_spi->io_remap_addr),
+				     "ioremap of SPI registers failed\n");
+
+	dev_dbg(dev, "io_remap_address: %p\n", amd_spi->io_remap_addr);
+
+	amd_spi->version = (uintptr_t)device_get_match_data(dev);
+	host->bus_num = 0;
+
+	return amd_spi_probe_common(dev, host);
+}
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id spi_acpi_match[] = {
diff --git a/drivers/spi/spi-amd.h b/drivers/spi/spi-amd.h
new file mode 100644
index 000000000000..5f39ce7b5587
--- /dev/null
+++ b/drivers/spi/spi-amd.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * AMD SPI controller driver common stuff
+ *
+ * Copyright (c) 2025, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Author: Krishnamoorthi M <krishnamoorthi.m@amd.com>
+ */
+
+#ifndef SPI_AMD_H
+#define SPI_AMD_H
+
+/**
+ * enum amd_spi_versions - SPI controller versions
+ * @AMD_SPI_V1:         AMDI0061 hardware version
+ * @AMD_SPI_V2:         AMDI0062 hardware version
+ * @AMD_HID2_SPI:       AMDI0063 hardware version
+ */
+enum amd_spi_versions {
+	AMD_SPI_V1 = 1,
+	AMD_SPI_V2,
+	AMD_HID2_SPI,
+};
+
+/**
+ * struct amd_spi - SPI driver instance
+ * @io_remap_addr:      Start address of the SPI controller registers
+ * @phy_dma_buf:        Physical address of DMA buffer
+ * @dma_virt_addr:      Virtual address of DMA buffer
+ * @version:            SPI controller hardware version
+ * @speed_hz:           Device frequency
+ */
+struct amd_spi {
+	void __iomem *io_remap_addr;
+	dma_addr_t phy_dma_buf;
+	void *dma_virt_addr;
+	enum amd_spi_versions version;
+	unsigned int speed_hz;
+};
+
+int amd_spi_probe_common(struct device *dev, struct spi_controller *host);
+
+#endif /* SPI_AMD_H */
-- 
2.34.1


