Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23CDC40FA31
	for <lists+linux-spi@lfdr.de>; Fri, 17 Sep 2021 16:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241902AbhIQOc0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Sep 2021 10:32:26 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:62288 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241700AbhIQOc0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Sep 2021 10:32:26 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18H9S5jQ028903;
        Fri, 17 Sep 2021 07:31:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=4vb7yoJ/ciWc1IsFnt2nPXRp6WQMdFsLOSU45eK49no=;
 b=iTJm9OQGeglJUorY9Mz9NDBc8ORBcot/xy3JvwFewcAEEEPh6db9/4l7JqtcgqmoxM+n
 z6+SNhuXe0p7/VhUTOgqmrLvxdKb5KGh9QxAkCXfiSNtf+1Y5DYUpZ3DmfOHNnuRbFoQ
 Qcungw46y2cJ8cEVXimGsyavKk9HTWAH1Hx+6p9q1Mi3oA1w0Y4gbjhEWQ5PcYUAf02i
 L59gMT8GNU8pqpA3aQ5NiNlIvyC75KeN73xLjsrpAS+R2BvYi442v1ZMHd8MgiQX9cqk
 nUXiXQfCkF+A511Z5a/4BE1x7nOIgSMGnU7WEDX+PJEjn6a8Uy1Ly971Dc324knpK13M sQ== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3b4jm3suke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Sep 2021 07:31:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHed5KFAjJFi22Qxemyj7y1hfWXEmy3YM3KJormSrUveLB2cm4jpc5W7nJrRoC08EtAuPZu8n6Binp/BDeLE5NXXlXhRAUVh7h2pgk2naY0/sg8MR1eBsPstvdWxtuYPhhfF17Tqk8SfINyF9eFsrGOcSxkigufMfcxBnu6FDLtHFrV+6QshhOUV1822bHY4EpglGl3dAJ77h7Tz+kfyXpKtercQllL6CqnyREkus3ae1xl50YICO3SNRq7hFHj84tqpeYchFatJcKmZtpixy1Bt8xhAPFZWolg8pgv6bDyKHBeTPHvntPz9zyUAb8E0JGnTpKg2aRTHe1ABKMJh2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=4vb7yoJ/ciWc1IsFnt2nPXRp6WQMdFsLOSU45eK49no=;
 b=TdFFFU2blOdcdRMKrBibO9Mo6mrkUz21lBxBFsFHQ8OydWUBcZ/RVz+OwBpl0O6ARBfcUX/Wabnudi5Q0u108NZEVI7uvgdoHm9qlINXh/179jydOGruS5y2vYh1gUuj9+GUER2bF/SFcAtUVk7LxrY+Qix1Sup7w888ifGVznTLr+Jg9zeoduR3fiAro7RnpTsDHlwxHHKsXjdy4ePiR3Ytjocnfcq9SbA6ETsaGeNEEWcYbl50UafiXyxYBc2J+wv13MK4y4tFzwcWeLdCKOc4bcfIBdC+yjo5lnKGZQvKIkzxotRFt+4/2pXrxhocYXiDvQ8pao5iD4wZ71/9hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vb7yoJ/ciWc1IsFnt2nPXRp6WQMdFsLOSU45eK49no=;
 b=QNNcQAELZyG9mHCrDUGoPVvdwa1KkvVfI/n9WRk8fmnS8A2Y6SZK8buRFxiOP2EV9LKn4E6RChWPj0U9OixqEVMjNFNeXHJlr5XhFji1J0vDuFVy+36m+KkSCUltibY2Bmd5RncucuDUWkjRqc4xMVpVDQXD2qf4umoSMu58Dxw=
Received: from MW4PR04CA0143.namprd04.prod.outlook.com (2603:10b6:303:84::28)
 by BYAPR07MB5608.namprd07.prod.outlook.com (2603:10b6:a03:9b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 14:30:57 +0000
Received: from MW2NAM12FT042.eop-nam12.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::3e) by MW4PR04CA0143.outlook.office365.com
 (2603:10b6:303:84::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Fri, 17 Sep 2021 14:30:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 MW2NAM12FT042.mail.protection.outlook.com (10.13.180.237) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.6 via Frontend Transport; Fri, 17 Sep 2021 14:30:57 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 18HEUslR009564
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Sep 2021 10:30:55 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 17 Sep 2021 16:30:53 +0200
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 17 Sep 2021 16:30:41 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 17 Sep 2021 16:30:41 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 18HEUfxm017316;
        Fri, 17 Sep 2021 16:30:41 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 18HEUf75017315;
        Fri, 17 Sep 2021 16:30:41 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <broonie@kernel.org>, <lukas@wunner.de>, <p.yadav@ti.com>,
        <robh+dt@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jpawar@cadence.com>,
        <mparab@cadence.com>, Parshuram Thombare <pthombar@cadence.com>,
        Konrad Kociolek <konrad@cadence.com>
Subject: [PATCH v5 2/2] spi: cadence: add support for Cadence XSPI controller
Date:   Fri, 17 Sep 2021 16:30:39 +0200
Message-ID: <1631889039-17280-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1631888947-17058-1-git-send-email-pthombar@cadence.com>
References: <1631888947-17058-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 913fe1d5-785a-4b7d-e4c0-08d979e7c362
X-MS-TrafficTypeDiagnostic: BYAPR07MB5608:
X-Microsoft-Antispam-PRVS: <BYAPR07MB5608592EF1940F42C2229730C1DD9@BYAPR07MB5608.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BGfLTSCg7eAEUsi7XXYR8qxwgHFqYPVNmtusKW5gRw3in782s+UIm4X8j1ne4wS8i+xfPscjLoIXPn2CV/6KP4Awq62loJa6alorK2sknEy7Rq8Ibw9oy2qMKuI4BxfOah546GyP6hpMKbZ4QpzkzOIwqyPcNUhur+pNJm4TBuRs5j7A2UVbr2b+DWl2mxA8hpOEK/WH5Px5LL59VBsiTpmEwzfKMGY/CcDbq/lHN0ZxjgnbGFRgZF4RygVxE64fdxujirUtWUbY6qWftyFnI8V1vWrUrzZA6v86D1uIEiFFroNri1JfMI8iM3onLg/7cJhypBBeT3CNRqLNGyoagExzIBvia4v+HXBaDgc4xdAApws4OiSOO2ZB2+jAclhYz2fOAo8C6GjbXUv+vTRTI5kuO4w9Q1QSb5uW3RZxKL964AaCC9mnvRk11jMxEL/xyxxOSDeUNJbUfspLnz3MOf2e5sfvT/+aFl1aPiRAVMeeL/vwEUrlsvfELzlkS6MxdtUbDUNOCwAwNkHZYygVE1/IUvhnQLY4m+MdhMz6Gav4n9bnhiGS/xo0FfAdNR/zXziWZM/xixvPAm3hQ9TN54qR2AzqBkIxVx5LH/XWkvLiV5oxFyLoZyaGZOlfi+pZF+/fdRa7/q8Or21E9osUeD+yys4eTZW44x2+DGiGn0m93/VdqV/9+slVgdlueVmQMjH1FtlMnS1deg88AT5+b0RI7v8P5gFPanaectbQ5y7QDPz3BwdAsaLl47SbuUAIG3WJNZ+grLpVTKrQ4YNIDw==
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(36092001)(36840700001)(46966006)(110136005)(83380400001)(107886003)(30864003)(478600001)(356005)(36860700001)(5660300002)(316002)(8676002)(42186006)(54906003)(26005)(36756003)(2906002)(4326008)(81166007)(70586007)(8936002)(70206006)(426003)(47076005)(82740400003)(336012)(82310400003)(2616005)(36906005)(86362001)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 14:30:57.0481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 913fe1d5-785a-4b7d-e4c0-08d979e7c362
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT042.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5608
X-Proofpoint-GUID: 0ZI_xyKnZj4jyy4kJKL3_9OIhVuQ8Kwr
X-Proofpoint-ORIG-GUID: 0ZI_xyKnZj4jyy4kJKL3_9OIhVuQ8Kwr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-17_06,2021-09-17_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 clxscore=1015
 spamscore=0 adultscore=0 mlxlogscore=950 suspectscore=0 lowpriorityscore=0
 mlxscore=0 bulkscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109170093
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch adds driver for Cadence's XSPI controller.
It supports 3 work modes.
1. ACMD (auto command) work mode
    ACMD name is because it uses auto command engine in the controller.
    It further has 2 modes PIO and CDMA (command DMA).
    The CDMA work mode is dedicated for high-performance application
    where very low software overhead is required. In this mode the
    Command Engine is programmed by the series of linked descriptors
    stored in system memory. These descriptors provide commands to execute
    and store status information for finished commands.
    The PIO mode work mode is dedicated for single operation where
    constructing a linked list of descriptors would require too
    much effort.
2. STIG (Software Triggered Instruction Generator) work mode
    In STIG mode, controller sends low-level instructions to memory.
    Each instruction is 128-bit width. There is special instruction
    DataSequence which carries information about data phase.
    Driver uses Slave DMA interface to transfer data as only this
    interface can be used in STIG work mode.
3. Direct work mode
    This work mode allows sending data without invoking any command through
    the slave interface.
Currently only STIG work mode is enabled, remaining work modes will
be added later.

Signed-off-by: Konrad Kociolek <konrad@cadence.com>
Signed-off-by: Jayshri Pawar <jpawar@cadence.com>
Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
Acked-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/spi/Kconfig            |  12 +
 drivers/spi/Makefile           |   1 +
 drivers/spi/spi-cadence-xspi.c | 626 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 639 insertions(+)
 create mode 100644 drivers/spi/spi-cadence-xspi.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index ea824b0..ac9f1fe 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -228,6 +228,18 @@ config SPI_CADENCE_QUADSPI
 	  device with a Cadence QSPI controller and want to access the
 	  Flash as an MTD device.
 
+config SPI_CADENCE_XSPI
+	tristate "Cadence XSPI controller"
+	depends on (OF || COMPILE_TEST) && HAS_IOMEM
+	depends on SPI_MEM
+	help
+	  Enable support for the Cadence XSPI Flash controller.
+
+	  Cadence XSPI is a specialized controller for connecting an SPI
+	  Flash over upto 8bit wide bus. Enable this option if you have a
+	  device with a Cadence XSPI controller and want to access the
+	  Flash as an MTD device.
+
 config SPI_CLPS711X
 	tristate "CLPS711X host SPI controller"
 	depends on ARCH_CLPS711X || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 322952d..dd7393a 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_SPI_BITBANG)		+= spi-bitbang.o
 obj-$(CONFIG_SPI_BUTTERFLY)		+= spi-butterfly.o
 obj-$(CONFIG_SPI_CADENCE)		+= spi-cadence.o
 obj-$(CONFIG_SPI_CADENCE_QUADSPI)	+= spi-cadence-quadspi.o
+obj-$(CONFIG_SPI_CADENCE_XSPI)		+= spi-cadence-xspi.o
 obj-$(CONFIG_SPI_CLPS711X)		+= spi-clps711x.o
 obj-$(CONFIG_SPI_COLDFIRE_QSPI)		+= spi-coldfire-qspi.o
 obj-$(CONFIG_SPI_DAVINCI)		+= spi-davinci.o
diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
new file mode 100644
index 0000000..80e9c63
--- /dev/null
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -0,0 +1,626 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Cadence XSPI flash controller driver
+// Copyright (C) 2020-21 Cadence
+
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi-mem.h>
+#include <linux/bitfield.h>
+#include <linux/limits.h>
+#include <linux/log2.h>
+
+#define CDNS_XSPI_MAGIC_NUM_VALUE	0x6522
+#define CDNS_XSPI_MAX_BANKS		8
+#define CDNS_XSPI_NAME			"cadence-xspi"
+
+/*
+ * Note: below are additional auxiliary registers to
+ * configure XSPI controller pin-strap settings
+ */
+
+/* PHY DQ timing register */
+#define CDNS_XSPI_CCP_PHY_DQ_TIMING		0x0000
+
+/* PHY DQS timing register */
+#define CDNS_XSPI_CCP_PHY_DQS_TIMING		0x0004
+
+/* PHY gate loopback control register */
+#define CDNS_XSPI_CCP_PHY_GATE_LPBCK_CTRL	0x0008
+
+/* PHY DLL slave control register */
+#define CDNS_XSPI_CCP_PHY_DLL_SLAVE_CTRL	0x0010
+
+/* DLL PHY control register */
+#define CDNS_XSPI_DLL_PHY_CTRL			0x1034
+
+/* Command registers */
+#define CDNS_XSPI_CMD_REG_0			0x0000
+#define CDNS_XSPI_CMD_REG_1			0x0004
+#define CDNS_XSPI_CMD_REG_2			0x0008
+#define CDNS_XSPI_CMD_REG_3			0x000C
+#define CDNS_XSPI_CMD_REG_4			0x0010
+#define CDNS_XSPI_CMD_REG_5			0x0014
+
+/* Command status registers */
+#define CDNS_XSPI_CMD_STATUS_REG		0x0044
+
+/* Controller status register */
+#define CDNS_XSPI_CTRL_STATUS_REG		0x0100
+#define CDNS_XSPI_INIT_COMPLETED		BIT(16)
+#define CDNS_XSPI_INIT_LEGACY			BIT(9)
+#define CDNS_XSPI_INIT_FAIL			BIT(8)
+#define CDNS_XSPI_CTRL_BUSY			BIT(7)
+
+/* Controller interrupt status register */
+#define CDNS_XSPI_INTR_STATUS_REG		0x0110
+#define CDNS_XSPI_STIG_DONE			BIT(23)
+#define CDNS_XSPI_SDMA_ERROR			BIT(22)
+#define CDNS_XSPI_SDMA_TRIGGER			BIT(21)
+#define CDNS_XSPI_CMD_IGNRD_EN			BIT(20)
+#define CDNS_XSPI_DDMA_TERR_EN			BIT(18)
+#define CDNS_XSPI_CDMA_TREE_EN			BIT(17)
+#define CDNS_XSPI_CTRL_IDLE_EN			BIT(16)
+
+#define CDNS_XSPI_TRD_COMP_INTR_STATUS		0x0120
+#define CDNS_XSPI_TRD_ERR_INTR_STATUS		0x0130
+#define CDNS_XSPI_TRD_ERR_INTR_EN		0x0134
+
+/* Controller interrupt enable register */
+#define CDNS_XSPI_INTR_ENABLE_REG		0x0114
+#define CDNS_XSPI_INTR_EN			BIT(31)
+#define CDNS_XSPI_STIG_DONE_EN			BIT(23)
+#define CDNS_XSPI_SDMA_ERROR_EN			BIT(22)
+#define CDNS_XSPI_SDMA_TRIGGER_EN		BIT(21)
+
+#define CDNS_XSPI_INTR_MASK (CDNS_XSPI_INTR_EN | \
+	CDNS_XSPI_STIG_DONE_EN  | \
+	CDNS_XSPI_SDMA_ERROR_EN | \
+	CDNS_XSPI_SDMA_TRIGGER_EN)
+
+/* Controller config register */
+#define CDNS_XSPI_CTRL_CONFIG_REG		0x0230
+#define CDNS_XSPI_CTRL_WORK_MODE		GENMASK(6, 5)
+
+#define CDNS_XSPI_WORK_MODE_DIRECT		0
+#define CDNS_XSPI_WORK_MODE_STIG		1
+#define CDNS_XSPI_WORK_MODE_ACMD		3
+
+/* SDMA trigger transaction registers */
+#define CDNS_XSPI_SDMA_SIZE_REG			0x0240
+#define CDNS_XSPI_SDMA_TRD_INFO_REG		0x0244
+#define CDNS_XSPI_SDMA_DIR			BIT(8)
+
+/* Controller features register */
+#define CDNS_XSPI_CTRL_FEATURES_REG		0x0F04
+#define CDNS_XSPI_NUM_BANKS			GENMASK(25, 24)
+#define CDNS_XSPI_DMA_DATA_WIDTH		BIT(21)
+#define CDNS_XSPI_NUM_THREADS			GENMASK(3, 0)
+
+/* Controller version register */
+#define CDNS_XSPI_CTRL_VERSION_REG		0x0F00
+#define CDNS_XSPI_MAGIC_NUM			GENMASK(31, 16)
+#define CDNS_XSPI_CTRL_REV			GENMASK(7, 0)
+
+/* STIG Profile 1.0 instruction fields (split into registers) */
+#define CDNS_XSPI_CMD_INSTR_TYPE		GENMASK(6, 0)
+#define CDNS_XSPI_CMD_P1_R1_ADDR0		GENMASK(31, 24)
+#define CDNS_XSPI_CMD_P1_R2_ADDR1		GENMASK(7, 0)
+#define CDNS_XSPI_CMD_P1_R2_ADDR2		GENMASK(15, 8)
+#define CDNS_XSPI_CMD_P1_R2_ADDR3		GENMASK(23, 16)
+#define CDNS_XSPI_CMD_P1_R2_ADDR4		GENMASK(31, 24)
+#define CDNS_XSPI_CMD_P1_R3_ADDR5		GENMASK(7, 0)
+#define CDNS_XSPI_CMD_P1_R3_CMD			GENMASK(23, 16)
+#define CDNS_XSPI_CMD_P1_R3_NUM_ADDR_BYTES	GENMASK(30, 28)
+#define CDNS_XSPI_CMD_P1_R4_ADDR_IOS		GENMASK(1, 0)
+#define CDNS_XSPI_CMD_P1_R4_CMD_IOS		GENMASK(9, 8)
+#define CDNS_XSPI_CMD_P1_R4_BANK		GENMASK(14, 12)
+
+/* STIG data sequence instruction fields (split into registers) */
+#define CDNS_XSPI_CMD_DSEQ_R2_DCNT_L		GENMASK(31, 16)
+#define CDNS_XSPI_CMD_DSEQ_R3_DCNT_H		GENMASK(15, 0)
+#define CDNS_XSPI_CMD_DSEQ_R3_NUM_OF_DUMMY	GENMASK(25, 20)
+#define CDNS_XSPI_CMD_DSEQ_R4_BANK		GENMASK(14, 12)
+#define CDNS_XSPI_CMD_DSEQ_R4_DATA_IOS		GENMASK(9, 8)
+#define CDNS_XSPI_CMD_DSEQ_R4_DIR		BIT(4)
+
+/* STIG command status fields */
+#define CDNS_XSPI_CMD_STATUS_COMPLETED		BIT(15)
+#define CDNS_XSPI_CMD_STATUS_FAILED		BIT(14)
+#define CDNS_XSPI_CMD_STATUS_DQS_ERROR		BIT(3)
+#define CDNS_XSPI_CMD_STATUS_CRC_ERROR		BIT(2)
+#define CDNS_XSPI_CMD_STATUS_BUS_ERROR		BIT(1)
+#define CDNS_XSPI_CMD_STATUS_INV_SEQ_ERROR	BIT(0)
+
+#define CDNS_XSPI_STIG_DONE_FLAG		BIT(0)
+#define CDNS_XSPI_TRD_STATUS			0x0104
+
+/* Helper macros for filling command registers */
+#define CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_1(op, data_phase) ( \
+	FIELD_PREP(CDNS_XSPI_CMD_INSTR_TYPE, (data_phase) ? \
+		CDNS_XSPI_STIG_INSTR_TYPE_1 : CDNS_XSPI_STIG_INSTR_TYPE_0) | \
+	FIELD_PREP(CDNS_XSPI_CMD_P1_R1_ADDR0, (op)->addr.val & 0xff))
+
+#define CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_2(op) ( \
+	FIELD_PREP(CDNS_XSPI_CMD_P1_R2_ADDR1, ((op)->addr.val >> 8)  & 0xFF) | \
+	FIELD_PREP(CDNS_XSPI_CMD_P1_R2_ADDR2, ((op)->addr.val >> 16) & 0xFF) | \
+	FIELD_PREP(CDNS_XSPI_CMD_P1_R2_ADDR3, ((op)->addr.val >> 24) & 0xFF) | \
+	FIELD_PREP(CDNS_XSPI_CMD_P1_R2_ADDR4, ((op)->addr.val >> 32) & 0xFF))
+
+#define CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_3(op) ( \
+	FIELD_PREP(CDNS_XSPI_CMD_P1_R3_ADDR5, ((op)->addr.val >> 40) & 0xFF) | \
+	FIELD_PREP(CDNS_XSPI_CMD_P1_R3_CMD, (op)->cmd.opcode) | \
+	FIELD_PREP(CDNS_XSPI_CMD_P1_R3_NUM_ADDR_BYTES, (op)->addr.nbytes))
+
+#define CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_4(op, chipsel) ( \
+	FIELD_PREP(CDNS_XSPI_CMD_P1_R4_ADDR_IOS, ilog2((op)->addr.buswidth)) | \
+	FIELD_PREP(CDNS_XSPI_CMD_P1_R4_CMD_IOS, ilog2((op)->cmd.buswidth)) | \
+	FIELD_PREP(CDNS_XSPI_CMD_P1_R4_BANK, chipsel))
+
+#define CDNS_XSPI_CMD_FLD_DSEQ_CMD_1(op) \
+	FIELD_PREP(CDNS_XSPI_CMD_INSTR_TYPE, CDNS_XSPI_STIG_INSTR_TYPE_DATA_SEQ)
+
+#define CDNS_XSPI_CMD_FLD_DSEQ_CMD_2(op) \
+	FIELD_PREP(CDNS_XSPI_CMD_DSEQ_R2_DCNT_L, (op)->data.nbytes & 0xFFFF)
+
+#define CDNS_XSPI_CMD_FLD_DSEQ_CMD_3(op) ( \
+	FIELD_PREP(CDNS_XSPI_CMD_DSEQ_R3_DCNT_H, \
+		((op)->data.nbytes >> 16) & 0xffff) | \
+	FIELD_PREP(CDNS_XSPI_CMD_DSEQ_R3_NUM_OF_DUMMY, (op)->dummy.nbytes * 8))
+
+#define CDNS_XSPI_CMD_FLD_DSEQ_CMD_4(op, chipsel) ( \
+	FIELD_PREP(CDNS_XSPI_CMD_DSEQ_R4_BANK, chipsel) | \
+	FIELD_PREP(CDNS_XSPI_CMD_DSEQ_R4_DATA_IOS, \
+		ilog2((op)->data.buswidth)) | \
+	FIELD_PREP(CDNS_XSPI_CMD_DSEQ_R4_DIR, \
+		((op)->data.dir == SPI_MEM_DATA_IN) ? \
+		CDNS_XSPI_STIG_CMD_DIR_READ : CDNS_XSPI_STIG_CMD_DIR_WRITE))
+
+enum cdns_xspi_stig_instr_type {
+	CDNS_XSPI_STIG_INSTR_TYPE_0,
+	CDNS_XSPI_STIG_INSTR_TYPE_1,
+	CDNS_XSPI_STIG_INSTR_TYPE_DATA_SEQ = 127,
+};
+
+enum cdns_xspi_sdma_dir {
+	CDNS_XSPI_SDMA_DIR_READ,
+	CDNS_XSPI_SDMA_DIR_WRITE,
+};
+
+enum cdns_xspi_stig_cmd_dir {
+	CDNS_XSPI_STIG_CMD_DIR_READ,
+	CDNS_XSPI_STIG_CMD_DIR_WRITE,
+};
+
+struct cdns_xspi_dev {
+	struct platform_device *pdev;
+	struct device *dev;
+
+	void __iomem *iobase;
+	void __iomem *auxbase;
+	void __iomem *sdmabase;
+
+	int irq;
+	int cur_cs;
+
+	struct completion cmd_complete;
+	struct completion auto_cmd_complete;
+	struct completion sdma_complete;
+	bool sdma_error;
+
+	void *in_buffer;
+	const void *out_buffer;
+
+	u8 hw_num_banks;
+};
+
+static int cdns_xspi_wait_for_controller_idle(struct cdns_xspi_dev *cdns_xspi)
+{
+	u32 ctrl_stat;
+
+	return readl_relaxed_poll_timeout(cdns_xspi->iobase +
+					  CDNS_XSPI_CTRL_STATUS_REG,
+					  ctrl_stat,
+					  ((ctrl_stat &
+					    CDNS_XSPI_CTRL_BUSY) == 0),
+					  100, 1000);
+}
+
+static void cdns_xspi_trigger_command(struct cdns_xspi_dev *cdns_xspi,
+				      u32 cmd_regs[5])
+{
+	writel(cmd_regs[5], cdns_xspi->iobase + CDNS_XSPI_CMD_REG_5);
+	writel(cmd_regs[4], cdns_xspi->iobase + CDNS_XSPI_CMD_REG_4);
+	writel(cmd_regs[3], cdns_xspi->iobase + CDNS_XSPI_CMD_REG_3);
+	writel(cmd_regs[2], cdns_xspi->iobase + CDNS_XSPI_CMD_REG_2);
+	writel(cmd_regs[1], cdns_xspi->iobase + CDNS_XSPI_CMD_REG_1);
+	writel(cmd_regs[0], cdns_xspi->iobase + CDNS_XSPI_CMD_REG_0);
+}
+
+static int cdns_xspi_check_command_status(struct cdns_xspi_dev *cdns_xspi)
+{
+	int ret = 0;
+	u32 cmd_status = readl(cdns_xspi->iobase + CDNS_XSPI_CMD_STATUS_REG);
+
+	if (cmd_status & CDNS_XSPI_CMD_STATUS_COMPLETED) {
+		if ((cmd_status & CDNS_XSPI_CMD_STATUS_FAILED) != 0) {
+			if (cmd_status & CDNS_XSPI_CMD_STATUS_DQS_ERROR) {
+				dev_err(cdns_xspi->dev,
+					"Incorrect DQS pulses detected\n");
+				ret = -EPROTO;
+			}
+			if (cmd_status & CDNS_XSPI_CMD_STATUS_CRC_ERROR) {
+				dev_err(cdns_xspi->dev,
+					"CRC error received\n");
+				ret = -EPROTO;
+			}
+			if (cmd_status & CDNS_XSPI_CMD_STATUS_BUS_ERROR) {
+				dev_err(cdns_xspi->dev,
+					"Error resp on system DMA interface\n");
+				ret = -EPROTO;
+			}
+			if (cmd_status & CDNS_XSPI_CMD_STATUS_INV_SEQ_ERROR) {
+				dev_err(cdns_xspi->dev,
+					"Invalid command sequence detected\n");
+				ret = -EPROTO;
+			}
+		}
+	} else {
+		dev_err(cdns_xspi->dev, "Fatal err - command not completed\n");
+		ret = -EPROTO;
+	}
+
+	return ret;
+}
+
+static void cdns_xspi_set_interrupts(struct cdns_xspi_dev *cdns_xspi,
+				     bool enabled)
+{
+	u32 intr_enable;
+
+	intr_enable = readl(cdns_xspi->iobase + CDNS_XSPI_INTR_ENABLE_REG);
+	if (enabled)
+		intr_enable |= CDNS_XSPI_INTR_MASK;
+	else
+		intr_enable &= ~CDNS_XSPI_INTR_MASK;
+	writel(intr_enable, cdns_xspi->iobase + CDNS_XSPI_INTR_ENABLE_REG);
+}
+
+static int cdns_xspi_controller_init(struct cdns_xspi_dev *cdns_xspi)
+{
+	u32 ctrl_ver;
+	u32 ctrl_features;
+	u16 hw_magic_num;
+
+	ctrl_ver = readl(cdns_xspi->iobase + CDNS_XSPI_CTRL_VERSION_REG);
+	hw_magic_num = FIELD_GET(CDNS_XSPI_MAGIC_NUM, ctrl_ver);
+	if (hw_magic_num != CDNS_XSPI_MAGIC_NUM_VALUE) {
+		dev_err(cdns_xspi->dev,
+			"Incorrect XSPI magic nunber: %x, expected: %x\n",
+			hw_magic_num, CDNS_XSPI_MAGIC_NUM_VALUE);
+		return -EIO;
+	}
+
+	ctrl_features = readl(cdns_xspi->iobase + CDNS_XSPI_CTRL_FEATURES_REG);
+	cdns_xspi->hw_num_banks = FIELD_GET(CDNS_XSPI_NUM_BANKS, ctrl_features);
+	cdns_xspi_set_interrupts(cdns_xspi, false);
+
+	return 0;
+}
+
+static void cdns_xspi_sdma_handle(struct cdns_xspi_dev *cdns_xspi)
+{
+	u32 sdma_size, sdma_trd_info;
+	u8 sdma_dir;
+
+	sdma_size = readl(cdns_xspi->iobase + CDNS_XSPI_SDMA_SIZE_REG);
+	sdma_trd_info = readl(cdns_xspi->iobase + CDNS_XSPI_SDMA_TRD_INFO_REG);
+	sdma_dir = FIELD_GET(CDNS_XSPI_SDMA_DIR, sdma_trd_info);
+
+	switch (sdma_dir) {
+	case CDNS_XSPI_SDMA_DIR_READ:
+		ioread8_rep(cdns_xspi->sdmabase,
+			    cdns_xspi->in_buffer, sdma_size);
+		break;
+
+	case CDNS_XSPI_SDMA_DIR_WRITE:
+		iowrite8_rep(cdns_xspi->sdmabase,
+			     cdns_xspi->out_buffer, sdma_size);
+		break;
+	}
+}
+
+static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
+				       const struct spi_mem_op *op,
+				       bool data_phase)
+{
+	u32 cmd_regs[5];
+	u32 cmd_status;
+	int ret;
+
+	ret = cdns_xspi_wait_for_controller_idle(cdns_xspi);
+	if (ret < 0)
+		return -EIO;
+
+	writel(FIELD_PREP(CDNS_XSPI_CTRL_WORK_MODE, CDNS_XSPI_WORK_MODE_STIG),
+	       cdns_xspi->iobase + CDNS_XSPI_CTRL_CONFIG_REG);
+
+	cdns_xspi_set_interrupts(cdns_xspi, true);
+	cdns_xspi->sdma_error = false;
+
+	memset(cmd_regs, 0, sizeof(cmd_regs));
+	cmd_regs[1] = CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_1(op, data_phase);
+	cmd_regs[2] = CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_2(op);
+	cmd_regs[3] = CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_3(op);
+	cmd_regs[4] = CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_4(op,
+						       cdns_xspi->cur_cs);
+
+	cdns_xspi_trigger_command(cdns_xspi, cmd_regs);
+
+	if (data_phase) {
+		cmd_regs[0] = CDNS_XSPI_STIG_DONE_FLAG;
+		cmd_regs[1] = CDNS_XSPI_CMD_FLD_DSEQ_CMD_1(op);
+		cmd_regs[2] = CDNS_XSPI_CMD_FLD_DSEQ_CMD_2(op);
+		cmd_regs[3] = CDNS_XSPI_CMD_FLD_DSEQ_CMD_3(op);
+		cmd_regs[4] = CDNS_XSPI_CMD_FLD_DSEQ_CMD_4(op,
+							   cdns_xspi->cur_cs);
+
+		cdns_xspi->in_buffer = op->data.buf.in;
+		cdns_xspi->out_buffer = op->data.buf.out;
+
+		cdns_xspi_trigger_command(cdns_xspi, cmd_regs);
+
+		wait_for_completion(&cdns_xspi->sdma_complete);
+		if (cdns_xspi->sdma_error) {
+			cdns_xspi_set_interrupts(cdns_xspi, false);
+			return -EIO;
+		}
+		cdns_xspi_sdma_handle(cdns_xspi);
+	}
+
+	wait_for_completion(&cdns_xspi->cmd_complete);
+	cdns_xspi_set_interrupts(cdns_xspi, false);
+
+	cmd_status = cdns_xspi_check_command_status(cdns_xspi);
+	if (cmd_status)
+		return -EPROTO;
+
+	return 0;
+}
+
+static int cdns_xspi_mem_op(struct cdns_xspi_dev *cdns_xspi,
+			    struct spi_mem *mem,
+			    const struct spi_mem_op *op)
+{
+	enum spi_mem_data_dir dir = op->data.dir;
+
+	if (cdns_xspi->cur_cs != mem->spi->chip_select)
+		cdns_xspi->cur_cs = mem->spi->chip_select;
+
+	return cdns_xspi_send_stig_command(cdns_xspi, op,
+					   (dir != SPI_MEM_NO_DATA));
+}
+
+static int cdns_xspi_mem_op_execute(struct spi_mem *mem,
+				    const struct spi_mem_op *op)
+{
+	struct cdns_xspi_dev *cdns_xspi =
+		spi_master_get_devdata(mem->spi->master);
+	int ret = 0;
+
+	ret = cdns_xspi_mem_op(cdns_xspi, mem, op);
+
+	return ret;
+}
+
+static const struct spi_controller_mem_ops cadence_xspi_mem_ops = {
+	.exec_op = cdns_xspi_mem_op_execute,
+};
+
+static irqreturn_t cdns_xspi_irq_handler(int this_irq, void *dev)
+{
+	struct cdns_xspi_dev *cdns_xspi = dev;
+	u32 irq_status;
+	irqreturn_t result = IRQ_NONE;
+
+	irq_status = readl(cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG);
+	writel(irq_status, cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG);
+
+	if (irq_status &
+	    (CDNS_XSPI_SDMA_ERROR | CDNS_XSPI_SDMA_TRIGGER |
+	     CDNS_XSPI_STIG_DONE)) {
+		if (irq_status & CDNS_XSPI_SDMA_ERROR) {
+			dev_err(cdns_xspi->dev,
+				"Slave DMA transaction error\n");
+			cdns_xspi->sdma_error = true;
+			complete(&cdns_xspi->sdma_complete);
+		}
+
+		if (irq_status & CDNS_XSPI_SDMA_TRIGGER)
+			complete(&cdns_xspi->sdma_complete);
+
+		if (irq_status & CDNS_XSPI_STIG_DONE)
+			complete(&cdns_xspi->cmd_complete);
+
+		result = IRQ_HANDLED;
+	}
+
+	irq_status = readl(cdns_xspi->iobase + CDNS_XSPI_TRD_COMP_INTR_STATUS);
+	if (irq_status) {
+		writel(irq_status,
+		       cdns_xspi->iobase + CDNS_XSPI_TRD_COMP_INTR_STATUS);
+
+		complete(&cdns_xspi->auto_cmd_complete);
+
+		result = IRQ_HANDLED;
+	}
+
+	return result;
+}
+
+static int cdns_xspi_of_get_plat_data(struct platform_device *pdev)
+{
+	struct device_node *node_prop = pdev->dev.of_node;
+	struct device_node *node_child;
+	unsigned int cs;
+
+	for_each_child_of_node(node_prop, node_child) {
+		if (!of_device_is_available(node_child))
+			continue;
+
+		if (of_property_read_u32(node_child, "reg", &cs)) {
+			dev_err(&pdev->dev, "Couldn't get memory chip select\n");
+			return -ENXIO;
+		} else if (cs >= CDNS_XSPI_MAX_BANKS) {
+			dev_err(&pdev->dev, "reg (cs) parameter value too large\n");
+			return -ENXIO;
+		}
+	}
+
+	return 0;
+}
+
+static void cdns_xspi_print_phy_config(struct cdns_xspi_dev *cdns_xspi)
+{
+	struct device *dev = cdns_xspi->dev;
+
+	dev_info(dev, "PHY configuration\n");
+	dev_info(dev, "   * xspi_dll_phy_ctrl: %08x\n",
+		 readl(cdns_xspi->iobase + CDNS_XSPI_DLL_PHY_CTRL));
+	dev_info(dev, "   * phy_dq_timing: %08x\n",
+		 readl(cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_DQ_TIMING));
+	dev_info(dev, "   * phy_dqs_timing: %08x\n",
+		 readl(cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_DQS_TIMING));
+	dev_info(dev, "   * phy_gate_loopback_ctrl: %08x\n",
+		 readl(cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_GATE_LPBCK_CTRL));
+	dev_info(dev, "   * phy_dll_slave_ctrl: %08x\n",
+		 readl(cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_DLL_SLAVE_CTRL));
+}
+
+static int cdns_xspi_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct spi_master *master = NULL;
+	struct cdns_xspi_dev *cdns_xspi = NULL;
+	int ret;
+
+	master = devm_spi_alloc_master(dev, sizeof(*cdns_xspi));
+	if (!master)
+		return -ENOMEM;
+
+	master->mode_bits = SPI_3WIRE | SPI_TX_DUAL  | SPI_TX_QUAD  |
+		SPI_RX_DUAL | SPI_RX_QUAD | SPI_TX_OCTAL | SPI_RX_OCTAL |
+		SPI_MODE_0  | SPI_MODE_3;
+
+	master->mem_ops = &cadence_xspi_mem_ops;
+	master->dev.of_node = pdev->dev.of_node;
+	master->bus_num = -1;
+
+	platform_set_drvdata(pdev, master);
+
+	cdns_xspi = spi_master_get_devdata(master);
+	cdns_xspi->pdev = pdev;
+	cdns_xspi->dev = &pdev->dev;
+	cdns_xspi->cur_cs = 0;
+
+	init_completion(&cdns_xspi->cmd_complete);
+	init_completion(&cdns_xspi->auto_cmd_complete);
+	init_completion(&cdns_xspi->sdma_complete);
+
+	ret = cdns_xspi_of_get_plat_data(pdev);
+	if (ret)
+		return -ENODEV;
+
+	cdns_xspi->iobase = devm_platform_ioremap_resource_byname(pdev, "io");
+	if (IS_ERR(cdns_xspi->iobase)) {
+		dev_err(dev, "Failed to remap controller base address\n");
+		return PTR_ERR(cdns_xspi->iobase);
+	}
+
+	cdns_xspi->sdmabase = devm_platform_ioremap_resource_byname(pdev,
+								    "sdma");
+	if (IS_ERR(cdns_xspi->sdmabase)) {
+		dev_err(dev, "Failed to remap SDMA address\n");
+		return PTR_ERR(cdns_xspi->sdmabase);
+	}
+
+	cdns_xspi->auxbase = devm_platform_ioremap_resource_byname(pdev, "aux");
+	if (IS_ERR(cdns_xspi->auxbase)) {
+		dev_err(dev, "Failed to remap AUX address\n");
+		return PTR_ERR(cdns_xspi->auxbase);
+	}
+
+	cdns_xspi->irq = platform_get_irq(pdev, 0);
+	if (cdns_xspi->irq < 0) {
+		dev_err(dev, "Failed to get IRQ\n");
+		return -ENXIO;
+	}
+
+	ret = devm_request_irq(dev, cdns_xspi->irq, cdns_xspi_irq_handler,
+			       IRQF_SHARED, pdev->name, cdns_xspi);
+	if (ret) {
+		dev_err(dev, "Failed to request IRQ: %d\n", cdns_xspi->irq);
+		return ret;
+	}
+
+	cdns_xspi_print_phy_config(cdns_xspi);
+
+	ret = cdns_xspi_controller_init(cdns_xspi);
+	if (ret) {
+		dev_err(dev, "Failed to initialize controller\n");
+		return ret;
+	}
+
+	master->num_chipselect = 1 << cdns_xspi->hw_num_banks;
+
+	ret = devm_spi_register_master(dev, master);
+	if (ret) {
+		dev_err(dev, "Failed to register SPI master\n");
+		return ret;
+	}
+
+	dev_info(dev, "Successfully registered SPI master\n");
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id cdns_xspi_of_match[] = {
+	{
+		.compatible = "cdns,xspi-nor",
+	},
+	{ /* end of table */}
+};
+MODULE_DEVICE_TABLE(of, cdns_xspi_of_match);
+#else
+#define cdns_xspi_of_match NULL
+#endif /* CONFIG_OF */
+
+static struct platform_driver cdns_xspi_platform_driver = {
+	.probe          = cdns_xspi_probe,
+	.remove         = NULL,
+	.driver = {
+		.name = CDNS_XSPI_NAME,
+		.of_match_table = cdns_xspi_of_match,
+	},
+};
+
+module_platform_driver(cdns_xspi_platform_driver);
+
+MODULE_DESCRIPTION("Cadence XSPI Controller Driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" CDNS_XSPI_NAME);
+MODULE_AUTHOR("Konrad Kociolek <konrad@cadence.com>");
+MODULE_AUTHOR("Jayshri Pawar <jpawar@cadence.com>");
+MODULE_AUTHOR("Parshuram Thombare <pthombar@cadence.com>");
-- 
2.7.4

