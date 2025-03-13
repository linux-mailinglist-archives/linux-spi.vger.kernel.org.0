Return-Path: <linux-spi+bounces-7127-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02086A5FF5E
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 19:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 552E13BF174
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 18:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37461F03DA;
	Thu, 13 Mar 2025 18:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xZQrVl++"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6011DDC3B;
	Thu, 13 Mar 2025 18:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741890917; cv=fail; b=Y5Uzx44K7KyMysiwA7py3bJ1m+Xl8Nj+vCVEZ1OOeJFd3WP1XItnXBkRXDo9oszcmwNT4oA10jEut3eNCW0/3QECNBIbOancTNgKWcbUFDGKlHLKwvewY2Tsh8GvaUo0HcfreLP+ybd6EkE1JsXhPaiCYtuHWN6EBGfzfmoKY24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741890917; c=relaxed/simple;
	bh=3dBTFmvo7vgPk2w/Mt+BS8EOFbNr/NyzgMOZ9bhCTis=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KBQ2fG27rd2MkmiVXCweGKDaCV+Ca/WwWnXX8i1ykjkd4yPzEQN5UfDZM4WymfAVRyQYdsKc/hG7Aaiy5tbrqCM41vufzfJ6kjVcehAD3HTTg2achbQgXQop5HUrZI9y8A4e3McDn5/0f7IUrxgRYFz9ZDasNZ5bjZ0MARDQHOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xZQrVl++; arc=fail smtp.client-ip=40.107.243.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ry9ujEhiOCeY44/2DW39irZLSNZP+RJVZvLdWZNuZUkFsW8v9PC9tuIp2i6n2IHt/x+gEeVCm7WIFHwHdxR1aDsu9/1mXrQ7duycqC48vBUnMQtVBfk2e343WDauuzztraARG6L1WDm8wij1mxnhthHARMzmLsuUVB/2xyGGBwKpzWFFiwFdt0FVdKrR6zC2xuD8EOfj2p/CzfgYNR0VzVHecbwWt5Urdju2w5XU06z9E5Ul1i86GoiM024BGoMx2r1t6VD8c9FoYruW0BOCMPgR42mofDNUETmkSqM8WR6Vmi++1c1E5w4zHqLrRnO+kO8kHoGc5nZFX4wJMcx9hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2Q4rXVI2nsnBUhtfzCfZGh07W8hwLWzD0WtftEPjRA=;
 b=PL/q58IrS6Aohwme3seCJR7rmJprMMMtqia5Znq7VXd+s15filbMg+vU7YSL+76NUWxOJNXuxHxjflXlKnUfubn4CtXJEWn5w0L1bxKMitPBbZyHE429tQyB9ptn9P7O43ekAgXsXiSEkMGAl487aWS2TYAJDMF9I43QMF+lbwYmu+D6jzoSufes+SV7B8Fkjle6Sh6sbbs76n4B9Qy0XlC/VRUDuwJvoCPhWiHwzyebO3k0snA+N8n5f8mwk1+6BGyovJjOyCMwly/IknsCu7SBwYDNR6G2kixE0eeZogaWXmscmtM5hPeEjojGfjGe3QxoNx8zHMLU3mlGv6lW9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2Q4rXVI2nsnBUhtfzCfZGh07W8hwLWzD0WtftEPjRA=;
 b=xZQrVl++KYE3mbOWZ7Zg+xDBCWOc7BqUf4rXS7yT6Gf0U+4paXFvfGVgs3o82nNVgLwAjFmysKV+G3AB0QP2vQfdHrmd+FbSczT+BsqN//PMwPsiDcgfkbt+L80mt2D3FMUDPFYUJnQfOcvIftDN1lUbCdAsPWf45pqiXPnraIw=
Received: from MN2PR18CA0007.namprd18.prod.outlook.com (2603:10b6:208:23c::12)
 by SJ2PR12MB9006.namprd12.prod.outlook.com (2603:10b6:a03:540::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 18:35:12 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:23c:cafe::af) by MN2PR18CA0007.outlook.office365.com
 (2603:10b6:208:23c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.25 via Frontend Transport; Thu,
 13 Mar 2025 18:35:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 18:35:11 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 13:35:08 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <krishnamoorthi.m@amd.com>,
	<akshata.mukundshetty@amd.com>
Subject: [PATCH 01/10] spi: espi_amd: Add AMD eSPI controller driver support
Date: Fri, 14 Mar 2025 00:04:31 +0530
Message-ID: <20250313183440.261872-2-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250313183440.261872-1-Raju.Rangoju@amd.com>
References: <20250313183440.261872-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|SJ2PR12MB9006:EE_
X-MS-Office365-Filtering-Correlation-Id: 275d942d-cee6-41d3-b3b9-08dd625dc9c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IyPBnb35txqtwR0s7PIOcWPJANVdKMp4YiewzxUkauSM3qhXI66JPBwSkGOE?=
 =?us-ascii?Q?H2isWXW4TPqH/d3gLvqHjgKNpueyHFEKwdEOeWh9P88+3vIFO2kf1A/NQhef?=
 =?us-ascii?Q?QWw++p2NkXSP+y0vhLyirnjTUEwJsMVaYeCQcUS4+mgrG2I22wGKXInUYs5B?=
 =?us-ascii?Q?Vus48/m1PnuU2DFk+Q4kbN4V6kW/eFy2J3aLHi5RMfXCfa7Azcjunrz4a36L?=
 =?us-ascii?Q?OGbpGevXMb0SoQDDXIlmrsORQnSp6BeqQKOTqoWNj0E920mI+0cVsq05j1uJ?=
 =?us-ascii?Q?YIXJD9D+Ep5Z4nDSNfWObewBN8LtonU5C89RwwTzWb31jNUKzLIzDwpSmZiO?=
 =?us-ascii?Q?wBRIpgQRfCy0t3SDaqpKeM8rOqNX7MneRpp/YyJ6qNZDkvpmAC9aOII8g95m?=
 =?us-ascii?Q?FGdUfggN2AG5fLQS5yijJMbD+aC+E+VbwL1fmDk4bEJ0X55lxN6IUhGD+H3V?=
 =?us-ascii?Q?41Md811XS3CBRIGYXSnn9Bcteqg6oUn7fbNu+MMHTrpBkmjuUruPF65QkPd4?=
 =?us-ascii?Q?BY/cyrjg8reYYLV95b3fQSL0twJsTSBAJODOq+389yoGE8REjHzphTd75Wy8?=
 =?us-ascii?Q?cH4k99MFYcG8GCieL4o7/p/G1PCDXMcIShxP/MKKa46GiunM/lJWecruBu7y?=
 =?us-ascii?Q?rRrlagP/oSI1KOWBrnu0E0dywCcNQbTL+qI1yr3jEx+hv/WjQp81R683Gihy?=
 =?us-ascii?Q?KaXRxmzQA3BvmwBdO7Eri+EZR4B0CTYh9TAOxQBW0DgVlj4UHFwFQK2m8e9R?=
 =?us-ascii?Q?hrW1QpzYhDdQEagh1x8nGR0ddx7/9iFfQl0A5rotbpmYsvgvn45YFnCwPfaT?=
 =?us-ascii?Q?L89ryksSNDAZQbh4QWds75B92uGxhXc5E6auEYhHxDt/1x/PfVj+V2uiL0zM?=
 =?us-ascii?Q?e/k/HgkIbGrxFqrY8Tqe+SORL/CEpslZnY8H0XovT3cwZTsgvZ70+eZEcKnd?=
 =?us-ascii?Q?c1bnasKLtIqNkL5hZ06y4AcfkWWFk4OIGieEj6Qqw6cD1NX817NH4kqzfkRV?=
 =?us-ascii?Q?1z5lttjCfHI/EF7ClF3Fu5ea63pE5jFgLP/3qOGZxC+bB0pt1URk/8ZI1SR9?=
 =?us-ascii?Q?rpKT+eMuirM2k/WqC0Hjoa7t11+nU+vDkYf2XkJ31M8OgKxfoShSDZW2+Bmq?=
 =?us-ascii?Q?k3I3LmiAcj1jvy/YM/+zh3tSQaeSiRU9q3QUF8hiLOYAbz3AJnOgVgei97qu?=
 =?us-ascii?Q?NmGQPiMSMY5oMg9Cs5lrqooRAL20/3LZmYKzgweapL5coq4xgmFKP/MIbvsU?=
 =?us-ascii?Q?ZLLdR53IxR2LTL7bOlXn81C5k6/SyiEVdHTJCdaw6Qf+u5ehx0EfYwhf/MM9?=
 =?us-ascii?Q?5YPNYhbE85x3aC7PWrNjAnbKV56XpIQAS8AvP1miC9eXFa2bq/545EfpONr4?=
 =?us-ascii?Q?3BZavyBm7SDy0RcaLvzeRRcOTdEwlooue8e6lkwToOe6mIEi0N0X1vkM33us?=
 =?us-ascii?Q?SLsyBrw/uzGnQXI2S2RkZAhowu8AKMlx499HRT9nQDvLh9LLTsGhqA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 18:35:11.2148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 275d942d-cee6-41d3-b3b9-08dd625dc9c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9006

This patch enables core eSPI controller initialization in AMD embedded
platforms, supporting communication with eSPI slave devices through the
device file entry. Currently, the eSPI controller in AMD embedded platforms
has only one chip select line enabled, which is connected to the Embedded
Controller (EC).

Co-developed-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 MAINTAINERS                  |   6 +
 drivers/spi/Kconfig          |  10 +
 drivers/spi/Makefile         |   2 +
 drivers/spi/espi-amd-core.c  | 883 +++++++++++++++++++++++++++++++++++
 drivers/spi/espi-amd-dev.c   | 128 +++++
 drivers/spi/espi-amd-err.h   |  50 ++
 drivers/spi/espi-amd-slave.h | 109 +++++
 drivers/spi/espi-amd.h       | 291 ++++++++++++
 8 files changed, 1479 insertions(+)
 create mode 100644 drivers/spi/espi-amd-core.c
 create mode 100644 drivers/spi/espi-amd-dev.c
 create mode 100644 drivers/spi/espi-amd-err.h
 create mode 100644 drivers/spi/espi-amd-slave.h
 create mode 100644 drivers/spi/espi-amd.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 9f052994b7d4..c102dcce5892 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1059,6 +1059,12 @@ S:	Supported
 F:	drivers/gpu/drm/amd/display/dc/dml/
 F:	drivers/gpu/drm/amd/display/dc/dml2/
 
+AMD ESPI DRIVER
+M:	Raju Rangoju<raju.rangoju@amd.com>
+L:	linux-spi@vger.kernel.org
+S:	Supported
+F:	drivers/spi/espi-amd*
+
 AMD FAM15H PROCESSOR POWER MONITORING DRIVER
 M:	Huang Rui <ray.huang@amd.com>
 L:	linux-hwmon@vger.kernel.org
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index ea8a31032927..72b950f3eccb 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -1238,6 +1238,16 @@ config SPI_AMD
 	help
 	  Enables SPI controller driver for AMD SoC.
 
+config SPI_AMD_ESPI
+	tristate "AMD eSPI controller"
+	depends on X86_64 || SPI_MASTER || COMPILE_TEST
+	help
+	  AMD SOCs contains multiple SPI controllers, including a dedicated
+	  eSPI controller. This config enables eSPI controller driver for
+	  AMD SoC. AMD eSPI driver aims to comprehensive support for the
+	  eSPI protocol, including initialization of eSPI controller
+	  and slave devices and eSPI channel specific commands.
+
 #
 # Add new SPI master controllers in alphabetical order above this line
 #
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 9db7554c1864..0dec8ad30967 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -159,6 +159,8 @@ obj-$(CONFIG_SPI_XTENSA_XTFPGA)		+= spi-xtensa-xtfpga.o
 obj-$(CONFIG_SPI_ZYNQ_QSPI)		+= spi-zynq-qspi.o
 obj-$(CONFIG_SPI_ZYNQMP_GQSPI)		+= spi-zynqmp-gqspi.o
 obj-$(CONFIG_SPI_AMD)			+= spi-amd.o
+obj-$(CONFIG_SPI_AMD_ESPI)		+= espi-amd.o
+espi-amd-objs				:= espi-amd-core.o espi-amd-dev.o
 
 # SPI slave protocol handlers
 obj-$(CONFIG_SPI_SLAVE_TIME)		+= spi-slave-time.o
diff --git a/drivers/spi/espi-amd-core.c b/drivers/spi/espi-amd-core.c
new file mode 100644
index 000000000000..72a625b8b16d
--- /dev/null
+++ b/drivers/spi/espi-amd-core.c
@@ -0,0 +1,883 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * AMD eSPI controller driver
+ *
+ * Copyright (c) 2025, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Authors: Krishnamoorthi M <krishnamoorthi.m@amd.com>
+ *          Akshata MukundShetty<akshata.mukundshetty@amd.com>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/acpi.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/platform_device.h>
+
+#include "espi-amd.h"
+#include "espi-amd-slave.h"
+#include "espi-amd-err.h"
+
+#define ESPI_CH_READY_TIMEOUT_US	200
+
+/*
+ * In case of get configuration command, hdata0 contains bits[15:8] of the slave register address
+ * and hdata1 contains bits[7:0] of the slave register address.
+ */
+#define ESPI_CONFIGURATION_HDATA0(a)		(((a) >> 8) & GENMASK(7, 0))
+#define ESPI_CONFIGURATION_HDATA1(a)		((a) & GENMASK(7, 0))
+#define ESPI_INTR_MASK				GENMASK(31, 0)
+
+static int amd_espi_set_initial_config(struct amd_espi *amd_espi);
+
+static void amd_espi_clear_status(struct amd_espi *amd_espi)
+{
+	u32 status = readl(ESPI_BASE + AMD_ESPI_SLAVE0_INT_STS_REG);
+
+	if (status)
+		writel(status, (ESPI_BASE + AMD_ESPI_SLAVE0_INT_STS_REG));
+}
+
+void amd_espi_clr_all_intr(struct amd_espi *amd_espi)
+{
+	/* Set all bits to clear all the interrupt */
+	writel(ESPI_INTR_MASK, (ESPI_BASE + AMD_ESPI_SLAVE0_INT_STS_REG));
+}
+
+static int amd_espi_check_error_status(struct amd_espi *amd_espi, u32 status)
+{
+	int ret = CB_SUCCESS;
+
+	if (!(status & ESPI_DNCMD_INT)) {
+		ret =  ESPI_DNCMD_INT;
+		dev_err(amd_espi->dev, "eSPI downstream command completion failure\n");
+	} else if (status & ESPI_BUS_ERR_INT) {
+		ret = ESPI_BUS_ERR_INT;
+		dev_err(amd_espi->dev, "%s\n", espi_error_codes[POS_BUS_TIMING]);
+	} else if (status & ESPI_WAIT_TIMEOUT_INT) {
+		ret = ESPI_WAIT_TIMEOUT_INT;
+		dev_err(amd_espi->dev, "%s\n", espi_error_codes[POS_BUS_WAIT_STATE]);
+	} else if (status & ESPI_CRC_ERR_INT) {
+		ret = ESPI_CRC_ERR_INT;
+		dev_err(amd_espi->dev, "%s\n", espi_error_codes[POS_CRC]);
+	} else if (status & ESPI_NO_RESP_INT) {
+		ret = ESPI_NO_RESP_INT;
+		dev_err(amd_espi->dev, "%s\n", espi_error_codes[POS_NO_RESP]);
+	} else if (status & ESPI_FATAL_ERR_INT) {
+		ret = ESPI_FATAL_ERR_INT;
+		dev_err(amd_espi->dev, "%s\n", espi_error_codes[POS_FATAL_ERR]);
+	} else if (status & ESPI_NON_FATAL_ERR_INT) {
+		ret = ESPI_NON_FATAL_ERR_INT;
+		dev_err(amd_espi->dev, "%s\n", espi_error_codes[POS_NON_FATAL_ERR]);
+	} else if (status & ESPI_INVALID_RESP_CODE_INT) {
+		ret = ESPI_INVALID_RESP_CODE_INT;
+		dev_err(amd_espi->dev, "%s\n", espi_error_codes[POS_INVALID_RESP_CODE]);
+	} else if (status & ESPI_INVALID_CYCLE_TYPE_INT) {
+		ret = ESPI_INVALID_CYCLE_TYPE_INT;
+		dev_err(amd_espi->dev, "%s\n", espi_error_codes[POS_INVALID_CYCLE_TYPE]);
+	} else if (status & ESPI_UNSUCCESS_CPL_RECV_INT) {
+		ret = ESPI_UNSUCCESS_CPL_RECV_INT;
+		dev_err(amd_espi->dev, "%s\n", espi_error_codes[POS_UNSUCCESS_CPL_RECV]);
+	} else if (status & ESPI_ILLEGAL_RESP_TAG_INT) {
+		ret = ESPI_ILLEGAL_RESP_TAG_INT;
+		dev_err(amd_espi->dev, "%s\n", espi_error_codes[POS_ILLEGAL_RESP_TAG]);
+	} else if (status & ESPI_ILLEGAL_RESP_LEN_INT) {
+		ret = ESPI_ILLEGAL_RESP_LEN_INT;
+		dev_err(amd_espi->dev, "%s\n", espi_error_codes[POS_ILLEGAL_RESP_LEN]);
+	} else if (status & ESPI_RX_OOB_OVERFLOW_INT) {
+		ret = ESPI_RX_OOB_OVERFLOW_INT;
+		dev_err(amd_espi->dev, "%s\n", espi_error_codes[POS_OOB_DATA_LEN]);
+	} else if (status & ESPI_RX_PC_MSG_OVERFLOW_INT) {
+		ret = ESPI_RX_PC_MSG_OVERFLOW_INT;
+		dev_err(amd_espi->dev, "%s\n", espi_error_codes[POS_PC_MSG_DATA]);
+	} else if (status & ESPI_RX_FLASH_MSG_OVERFLOW_INT) {
+		ret = ESPI_RX_FLASH_MSG_OVERFLOW_INT;
+		dev_err(amd_espi->dev, "%s\n", espi_error_codes[POS_FLASH_DATA_LEN]);
+	} else if (status & ESPI_PROTOCOL_ERR_INT) {
+		ret = ESPI_PROTOCOL_ERR_INT;
+		dev_err(amd_espi->dev, "%s\n", espi_error_codes[POS_PROTOCOL_ERR]);
+	}
+
+	return ret;
+}
+
+static int amd_espi_alloc_cmd_data(struct espi_txcmd *cmd)
+{
+	u32 size = 0;
+
+	switch (cmd->hdr0.cmd_type) {
+	case SET_CONFIGURATION:
+	case GET_CONFIGURATION:
+	case IN_BAND_RESET:
+		size = 1;
+	default:
+		break;
+	}
+
+	if (!size)
+		return -EOPNOTSUPP;
+
+	size = DATA_SIZE_ROUNDOFF_4(size);
+	cmd->data = kzalloc(size, GFP_KERNEL);
+
+	if (!cmd->data)
+		return -ENOMEM;
+
+	return CB_SUCCESS;
+}
+
+static void amd_espi_send_downstream_data(struct amd_espi *amd_espi, struct espi_txcmd *cmd)
+{
+	union espi_txdata *data = cmd->data;
+
+	/* Write first 4 bytes of data - common for all eSPI commands */
+	writel(data->val, (ESPI_BASE + AMD_ESPI_DS_DATA_REG0));
+}
+
+static void amd_espi_cmd_reg_dump(struct device *dev, struct espi_txcmd *cmd)
+{
+	dev_err(dev, "eSPI command packet:\n"
+			"Header-0: %08x\nHeader-1: %08x\n"
+			"Header-2: %08x\nData: %08x\n",
+			cmd->hdr0.val, cmd->hdr1.val, cmd->hdr2.val, cmd->data->val);
+}
+
+static int amd_espi_send_cmd(struct amd_espi *amd_espi, struct espi_txcmd *cmd)
+{
+	u32 status;
+	int ret;
+
+	/* Wait until HW is ready to send the command */
+	ret = readx_poll_timeout(ioread32, ESPI_BASE + AMD_ESPI_DS_HEADER_REG0,
+				 status, (status & BIT(3)) == 0, ESPI_MSG_DELAY_MIN_US,
+				 ESPI_RESP_MAX_TIMEOUT_US);
+	if (ret) {
+		dev_err(amd_espi->dev, "eSPI controller is not ready to accept commands\n");
+		amd_espi_cmd_reg_dump(amd_espi->dev, cmd);
+		return ESPI_DNCMD_INT;
+	}
+	amd_espi_clear_status(amd_espi);
+
+	writel(cmd->hdr1.val, (ESPI_BASE + AMD_ESPI_DS_HEADER_REG1));
+	writel(cmd->hdr2.val, (ESPI_BASE + AMD_ESPI_DS_HEADER_REG2));
+
+	amd_espi_send_downstream_data(amd_espi, cmd);
+
+	writel(cmd->hdr0.val, (ESPI_BASE + AMD_ESPI_DS_HEADER_REG0));
+
+	/* Wait until HW successfully sent the packet */
+	ret = readx_poll_timeout(ioread32, ESPI_BASE + AMD_ESPI_DS_HEADER_REG0,
+				 status, (status & BIT(3)) == 0, ESPI_MSG_DELAY_MIN_US,
+				 ESPI_RESP_MAX_TIMEOUT_US);
+	if (ret) {
+		dev_err(amd_espi->dev, "eSPI timed out waiting for command to complete\n");
+		amd_espi_cmd_reg_dump(amd_espi->dev, cmd);
+		return ESPI_DNCMD_INT;
+	}
+
+	/* Wait for DS command completion interrupt */
+	ret = readx_poll_timeout(ioread32, ESPI_BASE + AMD_ESPI_SLAVE0_INT_STS_REG,
+				 status,  status != 0, ESPI_MSG_DELAY_MIN_US,
+				 ESPI_RESP_MAX_TIMEOUT_US);
+	if (ret) {
+		dev_err(amd_espi->dev, "eSPI command completion interrupt error (status = 0x%x)\n",
+			status);
+		amd_espi_cmd_reg_dump(amd_espi->dev, cmd);
+		return -ETIMEDOUT;
+	}
+
+	ret = amd_espi_check_error_status(amd_espi, status);
+	if (ret != CB_SUCCESS) {
+		amd_espi_cmd_reg_dump(amd_espi->dev, cmd);
+		dev_err(amd_espi->dev, "eSPI status register: 0x%x\n", status);
+	}
+
+	if (ret == ESPI_NO_RESP_INT || ret == ESPI_CRC_ERR_INT) {
+		dev_info(amd_espi->dev, "Triggering Inband-reset after CRC/NO_RESP Error\n");
+		if (amd_espi_inband_reset(amd_espi) != CB_SUCCESS)
+			dev_err(amd_espi->dev, "In-band reset failed!\n");
+	}
+
+	/* Clear downstream command completion interrupt after command completion */
+	writel(ESPI_DNCMD_INT, ESPI_BASE + AMD_ESPI_SLAVE0_INT_STS_REG);
+
+	return ret;
+}
+
+int amd_espi_inband_reset(struct amd_espi *amd_espi)
+{
+	int ret;
+	struct espi_txcmd cmd = {
+		.hdr0 = {
+			.cmd_type = IN_BAND_RESET,
+			.cmd_status = 1,
+		},
+	};
+
+	ret = amd_espi_alloc_cmd_data(&cmd);
+	if (ret)
+		return ret;
+
+	ret = amd_espi_send_cmd(amd_espi, &cmd);
+	if (ret != CB_SUCCESS) {
+		kfree(cmd.data);
+		return ret;
+	}
+
+	ret = amd_espi_set_initial_config(amd_espi);
+
+	kfree(cmd.data);
+	return ret;
+}
+
+int amd_espi_set_iomode(struct amd_espi *amd_espi, u32 *slave_config, u32 *ctrlr_config,
+			u8 io_mode)
+{
+	struct espi_master *master = amd_espi->master;
+
+	switch (io_mode) {
+	case IO_MODE_QUAD:
+		if (master->caps.io_mode_quad && espi_slave_supports_quad_io(*slave_config)) {
+			*ctrlr_config = ESPI_CNTRL_SET_IO_MODE(*ctrlr_config, IO_MODE_QUAD);
+			*slave_config = ESPI_SLAVE_SET_IO_MODE(*slave_config,
+							       ESPI_SLAVE_IO_MODE_SEL_QUAD);
+			break;
+		}
+		dev_info(amd_espi->dev, "eSPI Quad IO not supported. Dropping to Dual mode.\n");
+		fallthrough;
+	case IO_MODE_DUAL:
+		if (master->caps.io_mode_dual && espi_slave_supports_dual_io(*slave_config)) {
+			*ctrlr_config = ESPI_CNTRL_SET_IO_MODE(*ctrlr_config, IO_MODE_DUAL);
+			*slave_config = ESPI_SLAVE_SET_IO_MODE(*slave_config,
+							       ESPI_SLAVE_IO_MODE_SEL_DUAL);
+			break;
+		}
+		dev_info(amd_espi->dev, "eSPI Dual IO not supported. Dropping to Single mode.\n");
+		fallthrough;
+	case IO_MODE_SINGLE:
+	default:
+		if (master->caps.io_mode_single && espi_slave_supports_single_io(*slave_config)) {
+			*ctrlr_config = ESPI_CNTRL_SET_IO_MODE(*ctrlr_config, IO_MODE_SINGLE);
+			*slave_config = ESPI_SLAVE_SET_IO_MODE(*slave_config,
+							       ESPI_SLAVE_IO_MODE_SEL_SINGLE);
+		} else {
+			dev_err(amd_espi->dev, "%s, eSPI IO mode not supported\n", __func__);
+			return -EOPNOTSUPP;
+		}
+	}
+
+	return CB_SUCCESS;
+}
+
+int amd_espi_set_freqmode(struct amd_espi *amd_espi, u32 *slave_config, u32 *ctrlr_config,
+			  u8 op_freq)
+{
+	struct espi_master *master = amd_espi->master;
+
+	switch (op_freq) {
+	case SLAVE_OP_FREQ_66:
+		if (master->caps.op_freq_66 && espi_slave_supports_66_mhz(*slave_config)) {
+			*ctrlr_config = ESPI_CNTRL_SET_OP_FREQ(*ctrlr_config,
+							       CNTRL_SLAVE0_OP_FREQ_66);
+			*slave_config = ESPI_SLAVE_SET_OP_FREQ(*slave_config,
+							       ESPI_SLAVE_OP_FREQ_SEL_66_MHZ);
+			break;
+		}
+		dev_info(amd_espi->dev, "eSPI frequency 66 MHz not supported. Dropping to 33MHz.\n");
+		fallthrough;
+	case SLAVE_OP_FREQ_33:
+		if (master->caps.op_freq_33 && ((espi_slave_supports_66_mhz(*slave_config)) ||
+						(espi_slave_supports_33_mhz(*slave_config)))) {
+			*ctrlr_config = ESPI_CNTRL_SET_OP_FREQ(*ctrlr_config,
+							       CNTRL_SLAVE0_OP_FREQ_33);
+			*slave_config = ESPI_SLAVE_SET_OP_FREQ(*slave_config,
+							       ESPI_SLAVE_OP_FREQ_SEL_33_MHZ);
+			break;
+		}
+		dev_info(amd_espi->dev, "eSPI frequency 33 MHz not supported. Dropping to 16MHz.\n");
+		fallthrough;
+	case SLAVE_OP_FREQ_16:
+	default:
+		if (master->caps.op_freq_16 && ((espi_slave_supports_66_mhz(*slave_config)) ||
+						(espi_slave_supports_33_mhz(*slave_config)) ||
+						(espi_slave_supports_16_mhz(*slave_config)))) {
+			*ctrlr_config = ESPI_CNTRL_SET_OP_FREQ(*ctrlr_config,
+							       CNTRL_SLAVE0_OP_FREQ_16);
+			*slave_config = ESPI_SLAVE_SET_OP_FREQ(*slave_config,
+							       ESPI_SLAVE_OP_FREQ_SEL_16_MHZ);
+		} else {
+			dev_err(amd_espi->dev, "%s, eSPI frequency mode not supported\n", __func__);
+			return -EOPNOTSUPP;
+		}
+	}
+
+	return CB_SUCCESS;
+}
+
+static int amd_espi_get_config(struct amd_espi *amd_espi, u16 slave_reg_address, u32 *config)
+{
+	int ret;
+	struct espi_txcmd cmd = {
+		.hdr0 = {
+			.cmd_type = GET_CONFIGURATION,
+			.cmd_status = 1,
+			.hdata0 = ESPI_CONFIGURATION_HDATA0(slave_reg_address),
+			.hdata1 = ESPI_CONFIGURATION_HDATA1(slave_reg_address),
+		},
+	};
+
+	ret = amd_espi_alloc_cmd_data(&cmd);
+	if (ret)
+		return ret;
+
+	ret = amd_espi_send_cmd(amd_espi, &cmd);
+	if (ret != CB_SUCCESS) {
+		kfree(cmd.data);
+		return ret;
+	}
+
+	*config = readl(ESPI_BASE + AMD_ESPI_DS_HEADER_REG1);
+
+	kfree(cmd.data);
+	return CB_SUCCESS;
+}
+
+int amd_espi_get_channel_config(struct amd_espi *amd_espi)
+{
+	u32 chnl_config;
+	u32 ret = 0;
+
+	if (amd_espi_get_config(amd_espi, ESPI_SLAVE_PERIPH_CFG, &chnl_config) == CB_SUCCESS) {
+		if (chnl_config & ESPI_SLAVE_CHANNEL_ENABLE)
+			ret |= CHANNEL_MODE_PC;
+	}
+
+	if (amd_espi_get_config(amd_espi, ESPI_SLAVE_VW_CFG, &chnl_config) == CB_SUCCESS) {
+		if (chnl_config & ESPI_SLAVE_CHANNEL_ENABLE)
+			ret |= CHANNEL_MODE_VW;
+	}
+
+	return (ret == 0) ? -EOPNOTSUPP : ret;
+}
+
+int amd_espi_get_general_config(struct amd_espi *amd_espi, u32 *config)
+{
+	return amd_espi_get_config(amd_espi, ESPI_SLAVE_GENERAL_CAPS_CFG, config);
+}
+
+int amd_espi_set_config(struct amd_espi *amd_espi, u32 config, u16 slave_reg_address)
+{
+	int ret;
+	struct espi_txcmd cmd = {
+		.hdr0 = {
+			.cmd_type = SET_CONFIGURATION,
+			.cmd_status = 1,
+			.hdata0 = ESPI_CONFIGURATION_HDATA0(slave_reg_address),
+			.hdata1 = ESPI_CONFIGURATION_HDATA1(slave_reg_address),
+		},
+		.hdr1 = {
+			.val = config,
+		},
+	};
+
+	ret = amd_espi_alloc_cmd_data(&cmd);
+	if (ret)
+		return ret;
+
+	ret = amd_espi_send_cmd(amd_espi, &cmd);
+	kfree(cmd.data);
+
+	return ret;
+}
+
+int amd_espi_set_general_conf(struct amd_espi *amd_espi, struct config *dev)
+{
+	u32 ctrlr_config = readl(ESPI_BASE + AMD_ESPI_SLAVE0_CONFIG_REG);
+	u32 slave_config;
+	int status;
+
+	status = amd_espi_get_general_config(amd_espi, &slave_config);
+	if (status != CB_SUCCESS)
+		return status;
+
+	if (amd_espi->master->caps.alert_mode == 1) {
+		slave_config |= ESPI_SLAVE_ALERT_MODE_PIN;
+		ctrlr_config |= ESPI_CNTRL_SLAVE0_ALERT_MODE;
+	}
+
+	if (amd_espi->master->caps.crc_check_support == 1) {
+		slave_config |= ESPI_SLAVE_CRC_ENABLE;
+		ctrlr_config |= ESPI_CNTRL_SLAVE0_CRC_CHECK_EN;
+	}
+
+	status = amd_espi_set_iomode(amd_espi, &slave_config, &ctrlr_config, dev->io_mode);
+	if (status != CB_SUCCESS) {
+		dev_err(amd_espi->dev, "%s, IO mode not supported\n", __func__);
+		return -EOPNOTSUPP;
+	}
+
+	status = amd_espi_set_freqmode(amd_espi, &slave_config, &ctrlr_config, dev->op_freq);
+	if (status != CB_SUCCESS) {
+		dev_err(amd_espi->dev, "%s, Operating frequency not supported\n", __func__);
+		return -EOPNOTSUPP;
+	}
+
+	status = amd_espi_set_config(amd_espi, slave_config, ESPI_SLAVE_GENERAL_CAPS_CFG);
+	if (status != CB_SUCCESS)
+		return status;
+
+	writel(ctrlr_config, (ESPI_BASE + AMD_ESPI_SLAVE0_CONFIG_REG));
+
+	return CB_SUCCESS;
+}
+
+static int amd_espi_wait_channel_ready(struct amd_espi *amd_espi, u32 slave_reg_addr)
+{
+	u32 config;
+	int ret;
+
+	udelay(ESPI_CH_READY_TIMEOUT_US);
+	ret = amd_espi_get_config(amd_espi, slave_reg_addr, &config);
+	if (ret != CB_SUCCESS)
+		return ret;
+
+	if (!!(config & ESPI_SLAVE_CHANNEL_READY)) {
+		ret = CB_SUCCESS;
+	} else {
+		ret = -ETIMEDOUT;
+		dev_err(amd_espi->dev, "Channel is not ready after %d usec (slave addr: 0x%x)\n",
+			ESPI_CH_READY_TIMEOUT_US, slave_reg_addr);
+	}
+
+	return ret;
+}
+
+static void amd_espi_enable_ctrlr_channel(struct amd_espi *amd_espi, u32 channel_en)
+{
+	u32 reg = readl(ESPI_BASE + AMD_ESPI_SLAVE0_CONFIG_REG);
+
+	writel(reg | channel_en, (ESPI_BASE + AMD_ESPI_SLAVE0_CONFIG_REG));
+}
+
+static int amd_espi_set_channel_config(struct amd_espi *amd_espi, u32 slave_config,
+				       u32 slave_reg_addr, u32 ctrlr_enable)
+{
+	int ret = amd_espi_set_config(amd_espi, slave_config, slave_reg_addr);
+
+	if (ret != CB_SUCCESS) {
+		dev_err(amd_espi->dev, "Channel configuration failed\n");
+		return ret;
+	}
+
+	/* Channel already enabled */
+	if (!(slave_config & ESPI_SLAVE_CHANNEL_ENABLE))
+		return CB_SUCCESS;
+
+	ret = amd_espi_wait_channel_ready(amd_espi, slave_reg_addr);
+	if (ret != CB_SUCCESS) {
+		dev_err(amd_espi->dev, "Channel is not ready\n");
+		return ret;
+	}
+
+	amd_espi_enable_ctrlr_channel(amd_espi, ctrlr_enable);
+
+	return CB_SUCCESS;
+}
+
+int amd_espi_setup_periph_channel(struct amd_espi *amd_espi, u32 slave_caps)
+{
+	/* Peripheral channel requires BME bit to be set when enabling */
+	const u32 slave_en_mask = ESPI_SLAVE_CHANNEL_ENABLE | ESPI_SLAVE_PERIPH_BUS_MASTER_ENABLE;
+	struct espi_master *master = amd_espi->master;
+	u32 slave_config;
+	int ret;
+
+	ret = amd_espi_get_config(amd_espi, ESPI_SLAVE_PERIPH_CFG, &slave_config);
+	if (ret != CB_SUCCESS)
+		return ret;
+
+	/* Check if PC is already enabled */
+	if (slave_config & ESPI_SLAVE_CHANNEL_ENABLE)
+		return CB_SUCCESS;
+
+	/*
+	 * Peripheral channel is the only one which is enabled on reset. So, if the mainboard
+	 * wants to disable it, set configuration to disable peripheral channel. It also
+	 * requires that BME bit be cleared.
+	 */
+	if (master->caps.periph_ch_en) {
+		if (!(slave_caps & ESPI_SLAVE_PERIPH_CH_SUPP)) {
+			dev_err(amd_espi->dev, "eSPI slave doesn't support periph channel!\n");
+			return -EOPNOTSUPP;
+		}
+		slave_config |= slave_en_mask;
+	} else {
+		slave_config &= ~slave_en_mask; /* If master does not support make it to 0 */
+	}
+
+	return amd_espi_set_channel_config(amd_espi, slave_config, ESPI_SLAVE_PERIPH_CFG,
+			CHANNEL_MODE_PC);
+}
+
+int amd_espi_setup_vw_channel(struct amd_espi *amd_espi, u32 slave_caps)
+{
+	struct espi_master *master = amd_espi->master;
+	u32 slave_vw_caps, slave_config;
+	int ret;
+
+	if (!master->caps.vw_ch_en) {
+		dev_err(amd_espi->dev, "Master doesn't support VW channel\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (!(slave_caps & ESPI_SLAVE_VW_CH_SUPP)) {
+		dev_err(amd_espi->dev, "eSPI slave doesn't support VW channel\n");
+		return -EOPNOTSUPP;
+	}
+
+	ret = amd_espi_get_config(amd_espi, ESPI_SLAVE_VW_CFG, &slave_vw_caps);
+	if (ret != CB_SUCCESS)
+		return ret;
+
+	slave_config = slave_vw_caps | ESPI_SLAVE_CHANNEL_ENABLE;
+
+	/* Check if VW channel is already enabled */
+	if (slave_config & ESPI_SLAVE_CHANNEL_ENABLE)
+		return CB_SUCCESS;
+
+	return amd_espi_set_channel_config(amd_espi, slave_config, ESPI_SLAVE_VW_CFG,
+			CHANNEL_MODE_VW);
+}
+
+static int amd_espi_get_master_cap(struct amd_espi *amd_espi, struct espi_master *master)
+{
+	u32 master_cap_reg, info;
+
+	master_cap_reg = readl(ESPI_BASE + AMD_ESPI_MASTER_CAP_REG);
+
+	/* Supported channels by master */
+	if (master_cap_reg & BIT(0))
+		master->caps.flash_ch_en = 1;
+
+	if (master_cap_reg & BIT(1))
+		master->caps.oob_ch_en = 1;
+
+	if (master_cap_reg & BIT(2))
+		master->caps.vw_ch_en = 1;
+
+	if (master_cap_reg & BIT(3))
+		master->caps.periph_ch_en = 1;
+
+	/* eSPI version */
+	master->caps.espi_version = ESPI_GET_ESPI_VERSION(master_cap_reg);
+
+	/* Operating frequency supported by master */
+	info = ESPI_GET_FREQ(master_cap_reg);
+	switch (info) {
+	case CNTRL_OP_FREQ_66:
+		master->caps.op_freq_66 = 1;
+		fallthrough;
+	case CNTRL_OP_FREQ_33:
+		master->caps.op_freq_33 = 1;
+		fallthrough;
+	case CNTRL_OP_FREQ_16:
+		master->caps.op_freq_16 = 1;
+		break;
+	default:
+		dev_err(amd_espi->dev, "%s, operating frequency Error\n", __func__);
+		return -EOPNOTSUPP;
+	}
+
+	/* IO mode supported by master */
+	info = ESPI_GET_IO_MODE(master_cap_reg);
+	switch (info) {
+	case IO_MODE_QUAD:
+		master->caps.io_mode_quad = 1;
+		fallthrough;
+	case IO_MODE_DUAL:
+		master->caps.io_mode_dual = 1;
+		fallthrough;
+	case IO_MODE_SINGLE:
+		master->caps.io_mode_single = 1;
+		break;
+	default:
+		dev_err(amd_espi->dev, "%s, IO Mode Error\n", __func__);
+		return -EOPNOTSUPP;
+	}
+
+	/* Number of slaves */
+	master->caps.no_of_slaves = ESPI_GET_NO_OF_SLAVES(master_cap_reg);
+
+	/* PC channel max payload size */
+	master->caps.pc_ch_max_payload_size = ESPI_GET_MAX_PAYLOAD_PC(master_cap_reg);
+
+	/* Flash access channel max payload size */
+	master->caps.flash_ch_max_payload = ESPI_GET_MAX_PAYLOAD_FLASH(master_cap_reg);
+
+	/* OOB message channel maximum payload size */
+	master->caps.oob_ch_max_payload = ESPI_GET_MAX_PAYLOAD_OOB(master_cap_reg);
+
+	/* Maximum virtual wire count */
+	master->caps.vw_ch_max_count = ESPI_GET_MAX_PAYLOAD_VW(master_cap_reg);
+
+	/* Alert mode support by master */
+	master->caps.alert_mode = ESPI_GET_ALERT_MODE(master_cap_reg);
+
+	/* CRC support by master */
+	master->caps.crc_check_support = ESPI_GET_CRC_SUPPORT(master_cap_reg);
+
+	return CB_SUCCESS;
+}
+
+static void amd_espi_set_def_initial_config(struct espi_master *master, struct config *dev_conf)
+{
+	dev_conf->channel_mode = CHANNEL_MODE_PC;
+	dev_conf->io_mode = IO_MODE_SINGLE;
+	dev_conf->op_freq = SLAVE_OP_FREQ_16;
+}
+
+static void amd_espi_control_reg_init(struct amd_espi *amd_espi)
+{
+	u32 espi_version, reg_val;
+
+	/* Clear any existing active bits */
+	reg_val = readl(ESPI_BASE + AMD_ESPI_SLAVE0_RX_VW_REG);
+	writel((reg_val | ESPI_RXVW_CLR_MASK), (ESPI_BASE + AMD_ESPI_SLAVE0_RX_VW_REG));
+
+	/* Check eSPI version */
+	espi_version = readl(ESPI_BASE + AMD_ESPI_MASTER_CAP_REG);
+	espi_version = ESPI_GET_ESPI_VERSION(espi_version);
+
+	/*
+	 * Watchdog enable and wait state control enable.
+	 * Set wait state counter to 0x3F.
+	 */
+	reg_val = readl(ESPI_BASE + AMD_ESPI_GLOBAL_CNTRL_REG0);
+	reg_val = reg_val | BIT(0) | BIT(1) |
+			(ESPI_WAIT_STATE_COUNTER << ESPI_WAIT_STATE_COUNTER_SHIFT);
+	writel(reg_val, (ESPI_BASE + AMD_ESPI_GLOBAL_CNTRL_REG0));
+
+	/*
+	 * Set slave0 error interrupt enable[19:0]
+	 * Register command interrupt enable[31:24]
+	 */
+	reg_val = readl(ESPI_BASE + AMD_ESPI_SLAVE0_INT_EN_REG);
+	writel(reg_val | ESPI_ALL_ERR_INT | ESPI_ALL_REG_CMD_INT,
+	       (ESPI_BASE + AMD_ESPI_SLAVE0_INT_EN_REG));
+
+	/* Set eSPI controller error interrupt mapping, default is SMI (1Fh) */
+	reg_val = readl(ESPI_BASE + AMD_ESPI_GLOBAL_CNTRL_REG1);
+	reg_val = ESPI_RGCMD_INT(amd_espi->irq, reg_val) |
+		ESPI_ERR_INT(ESPI_INT_SMI, reg_val);
+	writel(reg_val, (ESPI_BASE + AMD_ESPI_GLOBAL_CNTRL_REG1));
+
+	/*
+	 * Set the IRQ mask bit and polarity. Unmask IRQ 0~23.
+	 * Enable to configure the VW index/data register
+	 */
+	reg_val = readl(ESPI_BASE + AMD_ESPI_SLAVE0_VW_MISC_CNTRL_REG);
+	reg_val &= ~(GENMASK(31, 8));
+	writel((reg_val | GENMASK(3, 0)), (ESPI_BASE + AMD_ESPI_SLAVE0_VW_MISC_CNTRL_REG));
+
+	/* eSPI bus master enable */
+	reg_val = readl(ESPI_BASE + AMD_ESPI_GLOBAL_CNTRL_REG1);
+	if (!(reg_val & ESPI_BUS_MASTER_EN)) {
+		reg_val |= ESPI_BUS_MASTER_EN | BIT(21);
+		writel(reg_val, (ESPI_BASE + AMD_ESPI_GLOBAL_CNTRL_REG1));
+	}
+}
+
+static int amd_espi_set_initial_config(struct amd_espi *amd_espi)
+{
+	struct espi_master *master = amd_espi->master;
+	u32 espi_initial_mode, reg_val;
+	struct config espi_dev_conf;
+	int ret;
+
+	/* Clearing all the interrupts */
+	amd_espi_clr_all_intr(amd_espi);
+
+	espi_initial_mode = readl(ESPI_BASE + AMD_ESPI_SLAVE0_CONFIG_REG);
+	espi_initial_mode |= ((CNTRL_SLAVE0_OP_FREQ_16 << ESPI_CNTRL_SLAVE0_FREQ_SHIFT) |
+			      (IO_MODE_SINGLE << ESPI_CNTRL_SLAVE0_IO_SHIFT));
+
+	if (amd_espi->master->caps.alert_mode == 1)
+		espi_initial_mode |= ESPI_CNTRL_SLAVE0_ALERT_MODE;
+
+	if (amd_espi->master->caps.crc_check_support == 1)
+		espi_initial_mode |= ESPI_CNTRL_SLAVE0_CRC_CHECK_EN;
+
+	writel(espi_initial_mode, (ESPI_BASE + AMD_ESPI_SLAVE0_CONFIG_REG));
+
+	/* Unmask IRQ 0~23 */
+	reg_val = readl(ESPI_BASE + AMD_ESPI_SLAVE0_VW_MISC_CNTRL_REG);
+	reg_val &= ~(GENMASK(31, 8));
+	writel((reg_val | GENMASK(3, 0)), (ESPI_BASE + AMD_ESPI_SLAVE0_VW_MISC_CNTRL_REG));
+
+	amd_espi_set_def_initial_config(master, &espi_dev_conf);
+
+	ret = amd_espi_set_general_conf(amd_espi, &espi_dev_conf);
+	if (ret != CB_SUCCESS)
+		return ret;
+
+	amd_espi_clr_all_intr(amd_espi);
+
+	return CB_SUCCESS;
+}
+
+static int amd_espi_init_slave(struct amd_espi *amd_espi)
+{
+	struct espi_master *master = amd_espi->master;
+	u32 slave_caps, reg_val;
+	int ret;
+
+	ret = amd_espi_get_master_cap(amd_espi, master);
+	if (ret != CB_SUCCESS) {
+		dev_err(amd_espi->dev, "Get master capability failed\n");
+		return -EOPNOTSUPP;
+	}
+
+	ret = amd_espi_set_initial_config(amd_espi);
+	if (ret != CB_SUCCESS) {
+		dev_err(amd_espi->dev, "eSPI set initial config failed\n");
+		return ret;
+	}
+
+	ret = amd_espi_inband_reset(amd_espi);
+	if (ret != CB_SUCCESS) {
+		dev_err(amd_espi->dev, "In-band reset failed!\n");
+		return ret;
+	}
+
+	ret = amd_espi_get_general_config(amd_espi, &slave_caps);
+	if (ret != CB_SUCCESS)
+		return ret;
+
+	reg_val = readl(ESPI_BASE + AMD_ESPI_GLOBAL_CNTRL_REG1);
+	writel(reg_val | BIT(20), (ESPI_BASE + AMD_ESPI_GLOBAL_CNTRL_REG1));
+
+	if (amd_espi_setup_periph_channel(amd_espi, slave_caps) != CB_SUCCESS) {
+		dev_err(amd_espi->dev, "Peripheral channel setup failed\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (amd_espi_setup_vw_channel(amd_espi, slave_caps) != CB_SUCCESS) {
+		dev_err(amd_espi->dev, "Virtual wire channel setup failed\n");
+		return -EOPNOTSUPP;
+	}
+
+	return CB_SUCCESS;
+}
+
+static int amd_espi_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int amd_espi_resume(struct device *dev)
+{
+	struct amd_espi *amd_espi = dev_get_drvdata(dev);
+	int ret;
+
+	ret = amd_espi_set_initial_config(amd_espi);
+	if (ret != CB_SUCCESS)
+		dev_err(amd_espi->dev, "espi_set_initial_config in %s failed!\n", __func__);
+
+	return ret;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(amd_espi_pm_ops, amd_espi_suspend, amd_espi_resume);
+
+static int amd_espi_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct config *espi_dev_conf;
+	struct amd_espi *amd_espi;
+	struct resource *res;
+	int ret;
+
+	amd_espi = devm_kzalloc(dev, sizeof(struct amd_espi), GFP_KERNEL);
+	if (!amd_espi)
+		return -ENOMEM;
+
+	amd_espi->master = devm_kzalloc(dev, sizeof(struct espi_master), GFP_KERNEL);
+	if (!amd_espi->master)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EOPNOTSUPP;
+
+	amd_espi->io_remap_addr = devm_ioremap_resource(dev, res);
+	if (IS_ERR(amd_espi->io_remap_addr)) {
+		ret = PTR_ERR(amd_espi->io_remap_addr);
+		return dev_err_probe(dev, ret, "ioremap of eSPI registers failed\n");
+	}
+
+	ret = amd_espi_device_create(amd_espi, dev);
+	if (ret != 0)
+		return dev_err_probe(amd_espi->dev, ret, "device creation failed\n");
+
+	platform_set_drvdata(pdev, amd_espi);
+
+	/* Allocate mem for espi_device */
+	espi_dev_conf = devm_kzalloc(dev, sizeof(struct config), GFP_KERNEL);
+	if (!espi_dev_conf) {
+		ret = -ENOMEM;
+		goto espidev_free;
+	}
+
+	amd_espi->irq = platform_get_irq(pdev, 0);
+	if (amd_espi->irq < 0) {
+		ret = amd_espi->irq;
+		goto espidev_free;
+	}
+
+	amd_espi_control_reg_init(amd_espi);
+	ret = amd_espi_init_slave(amd_espi);
+	if (ret != CB_SUCCESS)
+		goto espidev_free;
+
+	dev_info(dev, "AMD ESPI device initialization completed\n");
+
+	return 0;
+
+espidev_free:
+	amd_espi_device_remove(amd_espi);
+	return ret;
+}
+
+static void amd_espi_remove(struct platform_device *pdev)
+{
+	struct amd_espi *amd_espi = platform_get_drvdata(pdev);
+
+	amd_espi_device_remove(amd_espi);
+}
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id espi_acpi_match[] = {
+	{ "AMDI0070", AMD_ESPI_V1 },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, espi_acpi_match);
+#endif
+
+static struct platform_driver amd_espi_driver = {
+	.driver = {
+		.name = "amd_espi",
+		.owner = THIS_MODULE,
+		.acpi_match_table = ACPI_PTR(espi_acpi_match),
+		.pm = pm_sleep_ptr(&amd_espi_pm_ops),
+	},
+	.probe = amd_espi_probe,
+	.remove = amd_espi_remove,
+};
+
+module_platform_driver(amd_espi_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("AMD eSPI Controller Driver");
diff --git a/drivers/spi/espi-amd-dev.c b/drivers/spi/espi-amd-dev.c
new file mode 100644
index 000000000000..4e46c30d3405
--- /dev/null
+++ b/drivers/spi/espi-amd-dev.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * AMD eSPI controller driver - device file operations
+ *
+ * Copyright (c) 2025, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Authors: Krishnamoorthi M <krishnamoorthi.m@amd.com>
+ *          Akshata MukundShetty<akshata.mukundshetty@amd.com>
+ */
+#include <linux/cdev.h>
+#include <linux/fs.h>
+#include <linux/io.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#include "espi-amd.h"
+#include "espi-amd-slave.h"
+
+#define ESPI_DEV_MINORS		0
+#define N_ESPI_MINORS		1
+
+static LIST_HEAD(device_list);
+static DEFINE_MUTEX(device_list_lock);
+
+static struct class *amd_espi_dev_class;
+static struct cdev cdev;
+
+static int amd_espi_open(struct inode *inode, struct file *filp)
+{
+	struct amd_espi *espi;
+	int status = -ENXIO;
+
+	guard(mutex)(&device_list_lock);
+
+	list_for_each_entry(espi, &device_list, device_entry) {
+		if (espi->dev_minor == inode->i_rdev) {
+			status = 0;
+			break;
+		}
+	}
+	if (status)
+		goto err_dev_find;
+
+	espi->users++;
+	filp->private_data = espi;
+	nonseekable_open(inode, filp);
+
+err_dev_find:
+	return status;
+}
+
+static int amd_espi_release(struct inode *inode, struct file *filp)
+{
+	struct amd_espi *espi;
+
+	guard(mutex)(&device_list_lock);
+	espi = filp->private_data;
+	filp->private_data = NULL;
+	espi->users--;
+	if (!espi->users && !espi->dev)
+		kfree(espi);
+
+	return 0;
+}
+
+static const struct file_operations amd_espi_fops = {
+	.owner = THIS_MODULE,
+	.open = amd_espi_open,
+	.release = amd_espi_release,
+};
+
+int amd_espi_device_create(struct amd_espi *amd_espi, struct device *dev)
+{
+	int ret;
+
+	INIT_LIST_HEAD(&amd_espi->device_entry);
+	ret = alloc_chrdev_region(&amd_espi->dev_minor, 0, ESPI_DEV_MINORS, "amd_espi");
+	if (ret < 0) {
+		dev_err(amd_espi->dev, "Device numbers allocation failed: %d\n", ret);
+		return ret;
+	}
+
+	amd_espi_dev_class = class_create("amd_espi");
+	if (IS_ERR(amd_espi_dev_class)) {
+		dev_err(amd_espi->dev, "Class creation failed\n");
+		ret = PTR_ERR(amd_espi_dev_class);
+		goto espi_unregister_chrdev;
+	}
+
+	cdev_init(&cdev, &amd_espi_fops);
+	ret = cdev_add(&cdev, amd_espi->dev_minor, N_ESPI_MINORS);
+	if (ret)
+		goto espi_class_cleanup;
+
+	amd_espi->dev = dev;
+	dev = device_create(amd_espi_dev_class, NULL, amd_espi->dev_minor, &amd_espi, "amd_espi");
+	if (IS_ERR(dev)) {
+		dev_err(amd_espi->dev, "Device creation failed\n");
+		ret = PTR_ERR(dev);
+		goto espi_del_dev;
+	}
+
+	list_add(&amd_espi->device_entry, &device_list);
+
+	return 0;
+
+espi_del_dev:
+	cdev_del(&cdev);
+
+espi_class_cleanup:
+	class_destroy(amd_espi_dev_class);
+
+espi_unregister_chrdev:
+	unregister_chrdev_region(amd_espi->dev_minor, ESPI_DEV_MINORS);
+	return ret;
+}
+
+void amd_espi_device_remove(struct amd_espi *amd_espi)
+{
+	list_del(&amd_espi->device_entry);
+	device_destroy(amd_espi_dev_class, amd_espi->dev_minor);
+	cdev_del(&cdev);
+	class_destroy(amd_espi_dev_class);
+	unregister_chrdev_region(amd_espi->dev_minor, ESPI_DEV_MINORS);
+}
diff --git a/drivers/spi/espi-amd-err.h b/drivers/spi/espi-amd-err.h
new file mode 100644
index 000000000000..d2d3967a3c6d
--- /dev/null
+++ b/drivers/spi/espi-amd-err.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * AMD eSPI controller driver error codes
+ *
+ * Copyright (c) 2025, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Authors: Krishnamoorthi M <krishnamoorthi.m@amd.com>
+ *          Akshata MukundShetty<akshata.mukundshetty@amd.com>
+ */
+#ifndef AMD_ESPI_ERROR_H
+#define AMD_ESPI_ERROR_H
+
+/* Error code bit positions */
+#define POS_BUS_TIMING          0
+#define POS_BUS_WAIT_STATE      1
+#define POS_CRC                 2
+#define POS_NO_RESP             4
+#define POS_FATAL_ERR           5
+#define POS_NON_FATAL_ERR       6
+#define POS_INVALID_RESP_CODE   7
+#define POS_INVALID_CYCLE_TYPE  8
+#define POS_UNSUCCESS_CPL_RECV  9
+#define POS_ILLEGAL_RESP_TAG    10
+#define POS_ILLEGAL_RESP_LEN    11
+#define POS_OOB_DATA_LEN        12
+#define POS_PC_MSG_DATA         13
+#define POS_FLASH_DATA_LEN      14
+#define POS_PROTOCOL_ERR        15
+
+/* Human-readable error strings */
+static char *espi_error_codes[] = {
+	"ERR 00: eSPI BUS TIMING ERROR",
+	"ERR 01: eSPI WAIT STATE TIMER TIMEOUT",
+	"ERR 02: eSPI CRC ERROR",
+	"",
+	"ERR 04: NO RESPONSE FROM SLAVE",
+	"ERR 05: FATAL_ERROR RESPONSE FROM SLAVE",
+	"ERR 06: NON_FATAL_ERROR RESPONSE FROM SLAVE",
+	"ERR 07: INVALID RESPONSE CODE RECEIVED",
+	"ERR 08: INVALID CYCLE TYPE RECEIVED",
+	"ERR 09: UNSUCCESSFUL COMPLETION PACKET",
+	"ERR 10: ILLEGAL RESPONSE TAG",
+	"ERR 11: ILLEGAL RESPONSE LENGTH",
+	"ERR 12: OOB PACKET DATA LENGTH ERROR",
+	"ERR 13: PC MESSAGE DATA LENGTH ERROR",
+	"ERR 14: FLASH PACKET DATA LENGTH ERROR",
+	"ERR 15: PROTOCOL ERROR",
+};
+#endif
diff --git a/drivers/spi/espi-amd-slave.h b/drivers/spi/espi-amd-slave.h
new file mode 100644
index 000000000000..07aaad4f28aa
--- /dev/null
+++ b/drivers/spi/espi-amd-slave.h
@@ -0,0 +1,109 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * AMD eSPI slave device specific macros
+ *
+ * Copyright (c) 2025, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Authors: Krishnamoorthi M <krishnamoorthi.m@amd.com>
+ *          Akshata MukundShetty<akshata.mukundshetty@amd.com>
+ */
+#ifndef AMD_ESPI_SLAVE_H
+#define AMD_ESPI_SLAVE_H
+
+#define ESPI_SLAVE_GENERAL_CAPS_CFG		0x08
+
+/* eSPI slave channel support */
+#define  ESPI_SLAVE_PERIPH_CH_SUPP		BIT(0)
+#define  ESPI_SLAVE_VW_CH_SUPP			BIT(1)
+#define  ESPI_SLAVE_OOB_CH_SUPP			BIT(2)
+#define  ESPI_SLAVE_FLASH_CH_SUPP		BIT(3)
+
+/* eSPI slave frequency support */
+#define ESPI_SLAVE_OP_FREQ_SUPP_SHIFT		16
+#define ESPI_SLAVE_OP_FREQ_SUPP_MASK		GENMASK(18, 16)
+#define ESPI_SLAVE_OP_FREQ_SUPP_VAL(x)		((x) << ESPI_SLAVE_OP_FREQ_SUPP_SHIFT)
+#define ESPI_SLAVE_OP_FREQ_SUPP_16_MHZ		ESPI_SLAVE_OP_FREQ_SUPP_VAL(0)
+#define ESPI_SLAVE_OP_FREQ_SUPP_33_MHZ		ESPI_SLAVE_OP_FREQ_SUPP_VAL(2)
+#define ESPI_SLAVE_OP_FREQ_SUPP_66_MHZ		ESPI_SLAVE_OP_FREQ_SUPP_VAL(4)
+
+/* eSPI slave frequency selection */
+#define ESPI_SLAVE_OP_FREQ_SEL_SHIFT		20
+#define ESPI_SLAVE_OP_FREQ_SEL_MASK		~GENMASK(22, 20)
+#define ESPI_SLAVE_OP_FREQ_SEL_VAL(x)		((x) << ESPI_SLAVE_OP_FREQ_SEL_SHIFT)
+#define ESPI_SLAVE_OP_FREQ_SEL_16_MHZ		ESPI_SLAVE_OP_FREQ_SEL_VAL(0)
+#define ESPI_SLAVE_OP_FREQ_SEL_33_MHZ		ESPI_SLAVE_OP_FREQ_SEL_VAL(2)
+#define ESPI_SLAVE_OP_FREQ_SEL_66_MHZ		ESPI_SLAVE_OP_FREQ_SEL_VAL(4)
+#define ESPI_SLAVE_SET_OP_FREQ(conf, freq)	(((conf) & ESPI_SLAVE_OP_FREQ_SEL_MASK) | (freq))
+
+/* eSPI slave IO mode support */
+#define ESPI_SLAVE_IO_MODE_SUPP_SHIFT			24
+#define ESPI_SLAVE_IO_MODE_SUPP_MASK			GENMASK(25, 24)
+#define ESPI_SLAVE_IO_MODE_SUPP_VAL(x)			((x) << ESPI_SLAVE_IO_MODE_SUPP_SHIFT)
+#define ESPI_SLAVE_IO_MODE_SUPP_SINGLE_ONLY		ESPI_SLAVE_IO_MODE_SUPP_VAL(0)
+#define ESPI_SLAVE_IO_MODE_SUPP_SINGLE_DUAL		ESPI_SLAVE_IO_MODE_SUPP_VAL(1)
+#define ESPI_SLAVE_IO_MODE_SUPP_SINGLE_QUAD		ESPI_SLAVE_IO_MODE_SUPP_VAL(2)
+#define ESPI_SLAVE_IO_MODE_SUPP_SINGLE_DUAL_QUAD	ESPI_SLAVE_IO_MODE_SUPP_VAL(3)
+
+/* eSPI slave IO mode selection */
+#define ESPI_SLAVE_IO_MODE_SEL_SHIFT		26
+#define ESPI_SLAVE_IO_MODE_SEL_MASK		~GENMASK(27, 26)
+#define ESPI_SLAVE_IO_MODE_SEL_VAL(x)		((x) << ESPI_SLAVE_IO_MODE_SEL_SHIFT)
+#define ESPI_SLAVE_IO_MODE_SEL_SINGLE		ESPI_SLAVE_IO_MODE_SEL_VAL(0)
+#define ESPI_SLAVE_IO_MODE_SEL_DUAL		ESPI_SLAVE_IO_MODE_SEL_VAL(1)
+#define ESPI_SLAVE_IO_MODE_SEL_QUAD		ESPI_SLAVE_IO_MODE_SEL_VAL(2)
+#define ESPI_SLAVE_SET_IO_MODE(conf, mode)	(((conf) & ESPI_SLAVE_IO_MODE_SEL_MASK) | (mode))
+
+#define ESPI_SLAVE_ALERT_MODE_PIN		BIT(28)
+#define ESPI_SLAVE_CRC_ENABLE			BIT(31)
+
+/* eSPI slave channel capabilities and configuration registers */
+#define ESPI_SLAVE_PERIPH_CFG			0x10
+#define ESPI_SLAVE_VW_CFG			0x20
+#define ESPI_SLAVE_OOB_CFG			0x30
+#define ESPI_SLAVE_FLASH_CFG			0x40
+
+#define ESPI_SLAVE_CHANNEL_ENABLE		BIT(0)
+#define ESPI_SLAVE_CHANNEL_READY		BIT(1)
+#define ESPI_SLAVE_PERIPH_BUS_MASTER_ENABLE	BIT(2)
+
+static inline bool espi_slave_supports_quad_io(u32 caps)
+{
+	u32 mode = caps & ESPI_SLAVE_IO_MODE_SUPP_MASK;
+
+	return (mode == ESPI_SLAVE_IO_MODE_SUPP_SINGLE_QUAD) ||
+		(mode == ESPI_SLAVE_IO_MODE_SUPP_SINGLE_DUAL_QUAD);
+}
+
+static inline bool espi_slave_supports_dual_io(u32 caps)
+{
+	u32 mode = caps & ESPI_SLAVE_IO_MODE_SUPP_MASK;
+
+	return (mode == ESPI_SLAVE_IO_MODE_SUPP_SINGLE_DUAL) ||
+		(mode == ESPI_SLAVE_IO_MODE_SUPP_SINGLE_DUAL_QUAD);
+}
+
+static inline bool espi_slave_supports_single_io(u32 caps)
+{
+	/* Single IO mode is supported by default */
+	return true;
+}
+
+static inline bool espi_slave_supports_66_mhz(u32 caps)
+{
+	u32 freq = caps & ESPI_SLAVE_OP_FREQ_SUPP_MASK;
+	return freq == ESPI_SLAVE_OP_FREQ_SUPP_66_MHZ;
+}
+
+static inline bool espi_slave_supports_33_mhz(u32 caps)
+{
+	u32 freq = caps & ESPI_SLAVE_OP_FREQ_SUPP_MASK;
+	return freq == ESPI_SLAVE_OP_FREQ_SUPP_33_MHZ;
+}
+
+static inline bool espi_slave_supports_16_mhz(u32 caps)
+{
+	u32 freq = caps & ESPI_SLAVE_OP_FREQ_SUPP_MASK;
+	return freq == ESPI_SLAVE_OP_FREQ_SUPP_16_MHZ;
+}
+#endif
diff --git a/drivers/spi/espi-amd.h b/drivers/spi/espi-amd.h
new file mode 100644
index 000000000000..57b156fb0a05
--- /dev/null
+++ b/drivers/spi/espi-amd.h
@@ -0,0 +1,291 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * AMD eSPI general macros and structures
+ *
+ * Copyright (c) 2025, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Authors: Krishnamoorthi M <krishnamoorthi.m@amd.com>
+ *          Akshata MukundShetty<akshata.mukundshetty@amd.com>
+ */
+#ifndef AMD_ESPI_H
+#define AMD_ESPI_H
+
+#include <linux/ioctl.h>
+
+#define CB_SUCCESS	0
+#define DATA_SIZE_ROUNDOFF_4(NUM) (((NUM) + 3) & (~0x03u))
+
+/* Timeouts and delay */
+#define ESPI_MSG_DELAY_MIN_US		50
+#define ESPI_RESP_MAX_TIMEOUT_US	200000	/* 200 ms */
+
+/* Downstream transmit registers */
+#define AMD_ESPI_DS_HEADER_REG0		0x00
+#define AMD_ESPI_DS_HEADER_REG1		0x04
+#define AMD_ESPI_DS_HEADER_REG2		0x08
+#define AMD_ESPI_DS_DATA_REG0		0x0C
+
+/* Master capability and control registers */
+#define AMD_ESPI_MASTER_CAP_REG		0x2C
+#define AMD_ESPI_GLOBAL_CNTRL_REG0	0x30
+#define AMD_ESPI_GLOBAL_CNTRL_REG1	0x34
+#define AMD_ESPI_MISC_CNTRL_REG0	0x38
+#define AMD_ESPI_MISC_CNTRL_REG1	0x3c
+
+/* Slave-0 configuration and interrupt registers */
+#define AMD_ESPI_SLAVE0_CONFIG_REG		0x68
+#define AMD_ESPI_SLAVE0_INT_EN_REG		0x6C
+#define AMD_ESPI_SLAVE0_INT_STS_REG		0x70
+#define ESPI_CNTRL_SLAVE0_ALERT_MODE		BIT(30)
+#define ESPI_CNTRL_SLAVE0_CRC_CHECK_EN		BIT(31)
+
+/* Slave-0 Virtual wire registers */
+#define AMD_ESPI_SLAVE0_RX_VW_REG		0x9C
+#define AMD_ESPI_SLAVE0_VW_MISC_CNTRL_REG	0xA8
+
+/* Slave-0 interrupt enable and status bits */
+#define ESPI_BUS_ERR_INT		BIT(0)
+#define ESPI_WAIT_TIMEOUT_INT		BIT(1)
+#define ESPI_CRC_ERR_INT		BIT(2)
+#define ESPI_NO_RESP_INT		BIT(4)
+#define ESPI_FATAL_ERR_INT		BIT(5)
+#define ESPI_NON_FATAL_ERR_INT		BIT(6)
+#define ESPI_INVALID_RESP_CODE_INT	BIT(7)
+#define ESPI_INVALID_CYCLE_TYPE_INT	BIT(8)
+#define ESPI_UNSUCCESS_CPL_RECV_INT	BIT(9)
+#define ESPI_ILLEGAL_RESP_TAG_INT       BIT(10)
+#define ESPI_ILLEGAL_RESP_LEN_INT	BIT(11)
+#define ESPI_RX_OOB_OVERFLOW_INT	BIT(12)
+#define ESPI_RX_PC_MSG_OVERFLOW_INT	BIT(13)
+#define ESPI_RX_FLASH_MSG_OVERFLOW_INT	BIT(14)
+#define ESPI_PROTOCOL_ERR_INT		BIT(15)
+#define ESPI_DNCMD_INT			BIT(28)
+#define ESPI_RXMSG_INT			BIT(29)
+#define ESPI_ALL_ERR_INT		GENMASK(19, 0)
+#define ESPI_ALL_REG_CMD_INT		GENMASK(31, 24)
+
+/* eSPI global control register configurations */
+#define ESPI_BUS_MASTER_EN		BIT(1)
+#define ESPI_WAIT_STATE_COUNTER		0x3F
+#define ESPI_WAIT_STATE_COUNTER_SHIFT	23
+#define ESPI_ERR_INT_MAP_SHIFT		8
+#define ESPI_ERR_INT(irq, val)		((u32)(((val) & ~(GENMASK(12, 8))) | \
+					((irq) << ESPI_ERR_INT_MAP_SHIFT)))
+#define ESPI_INT_SMI			0x1f
+#define ESPI_RGCMD_INT_MAP_SHIFT	13
+#define ESPI_RGCMD_INT(irq, val)	((u32)(((val) & ~(GENMASK(17, 13))) | \
+					((irq) << ESPI_RGCMD_INT_MAP_SHIFT)))
+#define ESPI_RXVW_CLR_MASK		0xFFFF6F00
+
+/* eSPI master capability register values */
+#define ESPI_GET_ESPI_VERSION(val)	(((val) & GENMASK(6, 4)) >> 4)
+#define ESPI_GET_MAX_PAYLOAD_FLASH(val)	(((val) & GENMASK(9, 7)) >> 7)
+#define ESPI_GET_MAX_PAYLOAD_OOB(val)	(((val) & GENMASK(12, 10)) >> 10)
+#define ESPI_GET_MAX_PAYLOAD_VW(val)	(((val) & GENMASK(18, 13)) >> 13)
+#define ESPI_GET_MAX_PAYLOAD_PC(val)	(((val) & GENMASK(21, 19)) >> 19)
+#define ESPI_GET_NO_OF_SLAVES(val)	(((val) & GENMASK(24, 22)) >> 22)
+#define ESPI_GET_FREQ(val)		(((val) & GENMASK(27, 25)) >> 25)
+#define ESPI_GET_IO_MODE(val)		(((val) & GENMASK(29, 28)) >> 28)
+#define ESPI_GET_ALERT_MODE(val)	(((val) & BIT(30)) >> 30)
+#define ESPI_GET_CRC_SUPPORT(val)	(((val) & BIT(31)) >> 31)
+
+/* Channel modes */
+#define CHANNEL_MODE_FLASH		BIT(0)
+#define CHANNEL_MODE_OOB		BIT(1)
+#define CHANNEL_MODE_VW			BIT(2)
+#define CHANNEL_MODE_PC			BIT(3)
+#define CHAN_NOT_ENABLED		BIT(4)
+
+/*
+ * Controller IO MODE encoding values
+ * 00 - Single I/O
+ * 01 - Dual I/O, Single I/O
+ * 10 - Quad I/O, Dual I/O, Single I/O
+ */
+#define IO_MODE_SINGLE			0x0
+#define IO_MODE_DUAL			0x1
+#define IO_MODE_QUAD			0x2
+#define ESPI_CNTRL_SLAVE0_IO_SHIFT	28
+#define ESPI_CNTRL_IO_MODE_MASK		~GENMASK(29, 28)
+#define ESPI_CNTRL_SET_IO_MODE(conf, mode) (((conf) & ESPI_CNTRL_IO_MODE_MASK) |\
+					    ((mode) << ESPI_CNTRL_SLAVE0_IO_SHIFT))
+
+/*
+ * Controller operating support frequency values
+ * 000 - 16.7 MHz
+ * 001 - 16.7 MHz, 33 MHz
+ * 011 - 16.7 MHz, 33 MHz, 66 MHz
+ */
+#define CNTRL_OP_FREQ_16		0x0
+#define CNTRL_OP_FREQ_33		0x1
+#define CNTRL_OP_FREQ_66		0x3
+
+/* Slave0 operating frequency values */
+#define SLAVE_OP_FREQ_16		0x0
+#define SLAVE_OP_FREQ_33		0x2
+#define SLAVE_OP_FREQ_66		0x4
+
+/* Slave0 operating frequency values in controller side */
+#define CNTRL_SLAVE0_OP_FREQ_16		0x0
+#define CNTRL_SLAVE0_OP_FREQ_33		0x1
+#define CNTRL_SLAVE0_OP_FREQ_66		0x2
+
+#define ESPI_CNTRL_SLAVE0_FREQ_SHIFT	25
+#define ESPI_CNTRL_OP_MODE_MASK		~GENMASK(27, 25)
+#define ESPI_CNTRL_SET_OP_FREQ(conf, freq) (((conf) & ESPI_CNTRL_OP_MODE_MASK) |\
+					    ((freq) << ESPI_CNTRL_SLAVE0_FREQ_SHIFT))
+
+#define ESPI_BASE		((u8 __iomem *)amd_espi->io_remap_addr)
+
+/*
+ * enum amd_espi_versions - eSPI controller versions
+ * @AMD_ESPI_V1:		AMDI0070 hardware version
+ */
+enum amd_espi_versions {
+	AMD_ESPI_V1 = 1,
+};
+
+/* eSPI commands */
+enum espi_cmd_type {
+	SET_CONFIGURATION,
+	GET_CONFIGURATION,
+	IN_BAND_RESET,
+	PERIPHERAL_CHNL = 4,
+	VW_CHNL,
+	OOB_CHNL,
+	FLASH_CHNL,
+};
+
+struct amd_espi {
+	void __iomem            *io_remap_addr;
+	struct device           *dev;
+	struct espi_master      *master;
+	struct list_head        device_entry;
+	dev_t                   dev_minor;
+	enum amd_espi_versions  version;
+	unsigned int            users;
+	int			irq;
+	void (*suspend)(struct amd_espi *amd_espi);
+	void (*resume)(struct amd_espi *amd_espi);
+};
+
+struct master_caps {
+	/* Channel support by master, bits [3:0] */
+	u32 periph_ch_en:1;
+	u32 vw_ch_en:1;
+	u32 oob_ch_en:1;
+	u32 flash_ch_en:1;
+
+	/* eSPI version, bits [6:4] */
+	u32 espi_version:3;
+
+	/* Flash access channel max supported payload, bits[9:7] */
+	u32 flash_ch_max_payload:3;
+
+	/* OOB message channel max supported payload, bits[10:12] */
+	u32 oob_ch_max_payload:3;
+
+	/* Operating maximum virtual wire count, bits[18:13] */
+	u32 vw_ch_max_count:6;
+
+	/* Peripheral channel max supported payload, bits[21:19] */
+	u32 pc_ch_max_payload_size:3;
+
+	/* Number of slaves supported by master bits, [24:22] */
+	u32 no_of_slaves:3;
+
+	/* Operating frequencies, bits [27:25] */
+	u32 op_freq_66:1;
+	u32 op_freq_33:1;
+	u32 op_freq_16:1;
+
+	/* IO modes bits [29:28] */
+	u32 io_mode_single:1;
+	u32 io_mode_dual:1;
+	u32 io_mode_quad:1;
+
+	/* Alert mode support by master, bit[30] */
+	u32 alert_mode:1;
+
+	/* CRC checking support by master, bit[31] */
+	u32 crc_check_support:1;
+} __packed;
+
+struct espi_master {
+	struct device *dev;
+	struct master_caps caps;
+};
+
+struct config {
+	u8 io_mode;
+	u8 channel_mode;
+	u8 op_freq;
+};
+
+/* TX Header and data packet */
+union espi_txhdr0 {
+	u32 val;
+	struct {
+		u32 cmd_type:3;
+		u32 cmd_status:1;
+		u32 slave_sel:2;
+		u32 rsvd:2;
+		u32 hdata0:8;
+		u32 hdata1:8;
+		u32 hdata2:8;
+	};
+};
+
+union espi_txhdr1 {
+	u32 val;
+	struct {
+		u32 hdata3:8;
+		u32 hdata4:8;
+		u32 hdata5:8;
+		u32 hdata6:8;
+	};
+};
+
+union espi_txhdr2 {
+	u32 val;
+	struct {
+		u32 hdata7:8;
+		u32 rsvd:24;
+	};
+};
+
+union espi_txdata {
+	u32 val;
+	struct {
+		u32 dbyte0:8;
+		u32 dbyte1:8;
+		u32 dbyte2:8;
+		u32 dbyte3:8;
+	};
+};
+
+struct espi_txcmd {
+	union espi_txhdr0 hdr0;
+	union espi_txhdr1 hdr1;
+	union espi_txhdr2 hdr2;
+	union espi_txdata *data;
+	u32 expected_status_codes;
+};
+
+/* Function prototypes */
+int amd_espi_device_create(struct amd_espi *amd_espi, struct device *dev);
+void amd_espi_device_remove(struct amd_espi *amd_espi);
+int amd_espi_inband_reset(struct amd_espi *amd_espi);
+int amd_espi_get_general_config(struct amd_espi *amd_espi, u32 *config);
+int amd_espi_set_general_conf(struct amd_espi *amd_espi, struct config *dev);
+int amd_espi_set_config(struct amd_espi *amd_espi, u32 config, u16 slave_reg_address);
+int amd_espi_set_iomode(struct amd_espi *amd_espi, u32 *slave_config, u32 *ctrlr_config,
+			u8 io_mode);
+int amd_espi_set_freqmode(struct amd_espi *amd_espi, u32 *slave_config, u32 *ctrlr_config,
+			  u8 op_freq);
+int amd_espi_get_channel_config(struct amd_espi *amd_espi);
+int amd_espi_setup_periph_channel(struct amd_espi *amd_espi, u32 slave_caps);
+int amd_espi_setup_vw_channel(struct amd_espi *amd_espi, u32 slave_caps);
+void amd_espi_clr_all_intr(struct amd_espi *amd_espi);
+#endif
-- 
2.34.1


