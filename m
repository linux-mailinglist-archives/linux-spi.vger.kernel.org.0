Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41EBB14B458
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jan 2020 13:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgA1Mmh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Jan 2020 07:42:37 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:8386 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726096AbgA1Mmh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 28 Jan 2020 07:42:37 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00SCbilb030934;
        Tue, 28 Jan 2020 04:42:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=656wu/H/F1GPHIczf8HYeTFMNuCqdvjdGaGCuWIKn4I=;
 b=C1mwyWSyGh4wfaO1abE6lrJPJZiK+Y7Xmrc+qox5F9Zv5T0VBst78dzJaNKN7m2M9F43
 Lue3HZBrgCbbcm0xMfrKszRNY0NVSw+cFPZz4MdOC2lR68Y6+G9kMluPXAFMcjVMPwbS
 5/qBYEMrYzhmhm6fU40dCN3km7rU7pxVT2onn57XyIJ6HLuVPQcNbbR+uWL0lm6gsp7K
 XAHYJ0RPKM9Jn7KKIWOfkuOikgS1Nv11VwKzi+tq+OFztxSkAK0bfHCTeMY/qgwL3LDK
 k4k+arixVgVmdENXeJhgPTJjMDvKEMB9mjR+Ov42DVdY2hd5TyKorRGHgCXpP9FC7YwI Vg== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2xrk442y4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jan 2020 04:42:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oF9oFhrhjKLT912Lje+ijPlNQ4xSzWFLbFz7R0ZRL2Ty7q5xlVUtfWlTtJnQfeZ3lZyJd1pRmm/XjPYMINa6XqtGsTTC+3YXAxv06vlRWggEyW/MogB6PlImUWPWGTrvqxK54yHh51ZvOnWw4VgWdCkOvWY2ndEWtUQfHAHV8aYatZZsfSVDNencYuQoJcqPVvjQfLe152d40D0bHUE+OCTFt4gbKn87Bw7BZvK2DDbWcdxX8lczLNKTpXxSidYdR17SLXcHQsVJCA3LmptLyH0LDJq7RsxnLgFs+e5FSRreLhIJzTTh/Uen8gjIEi7y6JkVIebeCDbAekLsjK9OWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=656wu/H/F1GPHIczf8HYeTFMNuCqdvjdGaGCuWIKn4I=;
 b=m5dXOKdXecXAJ6JEemiJSVfP3YFIkwFD3sr2s23/K8YoW9NKV6k5o5WEEsbyLLlb4XqhnEACNk1drmHf+8UFxwNmdsvDyF3muR/AYR0e5WQmigBu00syc8Hjsm0OA1YRcxPAqbuLkI76BVOKsC3ezmlTs88tg7MZXZTKxErqfqKeV3bE4GsL1WibAWXBeVovvC1m54VKEbV0JmwiYenh23isjehXCXmGYjiADAPjXzp0V/9TukkBC/ktQ3TU6UZDQZ3q97BjrAoGjJiwFPe+ASivql9O4HAIghHnrr48owp6eP20XdHbZ7sDxu/5qcxLUlVscuBYjq6UfJKw0vKMLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.28) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=656wu/H/F1GPHIczf8HYeTFMNuCqdvjdGaGCuWIKn4I=;
 b=VQiV02dJ/g/Xe7NADkFYxPrLQ6MYMKcOoquViP15V8opvC7qY8RJPvALw3vqLBOUAjQYl14YM/NZcWR30nd+uEoN1YeSYZWXlFaORD++zlH7EtLsazBe3lIqEMrZMJmIP2ltc94oGEhK6Yca0Cx3xSVJP4UW1p/D1UyW6Kvvme0=
Received: from CY1PR07CA0026.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::36) by MN2PR07MB6256.namprd07.prod.outlook.com
 (2603:10b6:208:11c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.22; Tue, 28 Jan
 2020 12:42:26 +0000
Received: from DM6NAM12FT024.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe59::203) by CY1PR07CA0026.outlook.office365.com
 (2a01:111:e400:c60a::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20 via Frontend
 Transport; Tue, 28 Jan 2020 12:42:26 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.28 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.28; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 DM6NAM12FT024.mail.protection.outlook.com (10.13.179.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.12 via Frontend Transport; Tue, 28 Jan 2020 12:42:25 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 00SCgL3v007798
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 28 Jan 2020 07:42:22 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 28 Jan 2020 13:42:20 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 28 Jan 2020 13:42:20 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 00SCgKmm012623;
        Tue, 28 Jan 2020 13:42:20 +0100
Received: (from konrad@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 00SCgKeX012622;
        Tue, 28 Jan 2020 13:42:20 +0100
From:   Konrad Kociolek <konrad@cadence.com>
CC:     Konrad Kociolek <konrad@cadence.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
Subject: [PATCH v2 1/2] Add Cadence XSPI driver
Date:   Tue, 28 Jan 2020 13:41:57 +0100
Message-ID: <20200128124212.12298-1-konrad@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(136003)(346002)(396003)(189003)(199004)(36092001)(54906003)(316002)(336012)(42186006)(186003)(26005)(1076003)(81156014)(109986005)(4326008)(478600001)(81166006)(8936002)(8676002)(26826003)(5660300002)(2906002)(30864003)(6666004)(70586007)(2616005)(426003)(70206006)(86362001)(36756003)(356004)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR07MB6256;H:rmmaillnx1.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ab52d9c-be8a-40a2-041f-08d7a3ef8759
X-MS-TrafficTypeDiagnostic: MN2PR07MB6256:
X-Microsoft-Antispam-PRVS: <MN2PR07MB625680934205C6F0A78D346CC30A0@MN2PR07MB6256.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 029651C7A1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: acOLBpkPkNQdK26ABFc+AhNwF8/6Y/64kkIxvxSil8nz/76qpCZg1V2jq9/WcJDMKiUbN/NbKvAVcOitH7IwYY2SWt5DatWUpcELP52lpOEqjUyCZa25lcZtE9BrPzllCthjHB7I/jYEHTl1l6JwOeXv0mHkjCRngb0u6NbQxEYuSZN0kkoDOXAR1kpM4nhtO1dDZBhAqxqv+czwylLHf7NOzjhTj2J5vaYNncvLSHuBhuZU9sshqtBxIg22fXtX2I8Fu8fNhDXE8ZXRbRKJnKSdVxOxTS+eovfX3do9yz62MD3L4ga55YR5DMPIIlzeOnooxS2r7saJYgk6Gm2dNVMWPR6O80zvNhvsyZF1+1jf65RPzdMzBS3zDdDKGfZ5G1iGHjYKFJH8QHh7JmTON0T+6fjD9p0qduTdANBFRmPWyynhsTEeH5lXy0erQDR5zSa6WQK+6zlVGQybjbwFjZLm/lVJGGDNLnv+tqWawL42Xo87eQrE7BgaouTqTR5/EzOFfc5AGC7B3FzRk1Bz7g==
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2020 12:42:25.8624
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab52d9c-be8a-40a2-041f-08d7a3ef8759
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB6256
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-28_03:2020-01-24,2020-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 bulkscore=0 clxscore=1015 suspectscore=9 adultscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1911200001 definitions=main-2001280102
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add support for Cadence XSPI controller. This driver uses SPI-MEM
framework and is capable to operate with single, dual, quad and octal
SPI-NOR memories. Low-level controller work mode (STIG) is utilized
to communicate with flash memories.

Signed-off-by: Konrad Kociolek <konrad@cadence.com>
---
Changes between initial version and v2:
 - none

 drivers/spi/Kconfig            |  11 +
 drivers/spi/Makefile           |   1 +
 drivers/spi/spi-cadence-xspi.c | 895 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 907 insertions(+)
 create mode 100644 drivers/spi/spi-cadence-xspi.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index f761655e2a36..11b058b61638 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -848,6 +848,17 @@ config SPI_ZYNQMP_GQSPI
 	help
 	  Enables Xilinx GQSPI controller driver for Zynq UltraScale+ MPSoC.
 
+config SPI_CADENCE_XSPI
+	tristate "Cadence XSPI controller"
+	depends on (OF || COMPILE_TEST) && HAS_IOMEM
+	help
+	  Enable support for the Cadence XSPI Flash controller.
+
+	  Cadence XSPI is a specialized controller for connecting an SPI
+	  Flash over upto 8bit wide bus. Enable this option if you have a
+	  device with a Cadence XSPI controller and want to access the
+	  Flash as an MTD device.
+
 #
 # Add new SPI master controllers in alphabetical order above this line
 #
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index d8fc03c9faa2..fed59a46e507 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -119,6 +119,7 @@ obj-$(CONFIG_SPI_XILINX)		+= spi-xilinx.o
 obj-$(CONFIG_SPI_XLP)			+= spi-xlp.o
 obj-$(CONFIG_SPI_XTENSA_XTFPGA)		+= spi-xtensa-xtfpga.o
 obj-$(CONFIG_SPI_ZYNQMP_GQSPI)		+= spi-zynqmp-gqspi.o
+obj-$(CONFIG_SPI_CADENCE_XSPI)      += spi-cadence-xspi.o
 
 # SPI slave protocol handlers
 obj-$(CONFIG_SPI_SLAVE_TIME)		+= spi-slave-time.o
diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
new file mode 100644
index 000000000000..d5958469ec99
--- /dev/null
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -0,0 +1,895 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Cadence XSPI flash controller driver
+ *
+ * Copyright (C) 2020 Cadence
+ *
+ * Author: Konrad Kociolek <konrad@cadence.com>
+ */
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
+#include <linux/mtd/spi-nor.h>
+#include <linux/bitfield.h>
+#include <linux/limits.h>
+#include <linux/log2.h>
+
+#define CDNS_XSPI_MAGIC_NUM_VALUE               0x6522
+#define CDNS_XSPI_MAX_BANKS                     8
+#define CDNS_XSPI_NAME                          "cadence-xspi"
+
+/*
+ * Note: below are additional auxiliary registers to
+ * configure XSPI controller pin-strap settings
+ */
+
+/* PHY DQ timing register */
+#define CDNS_XSPI_CCP_PHY_DQ_TIMING           0x0000
+#define CDNS_XSPI_CCP_DATA_SELECT_OE_START    GENMASK(6, 4)
+#define CDNS_XSPI_CCP_DATA_SELECT_OE_END      GENMASK(2, 0)
+#define CDNS_XSPI_CCP_PHY_DQ_TIMING_INIT_VAL  0x80000000
+
+/* PHY DQS timing register */
+#define CDNS_XSPI_CCP_PHY_DQS_TIMING          0x0004
+#define CDNS_XSPI_CCP_USE_EXT_LPBCK_DQS       BIT(22)
+#define CDNS_XSPI_CCP_USE_LPBCK_DQS           BIT(21)
+#define CDNS_XSPI_CCP_USE_PHONY               BIT(20)
+#define CDNS_XSPI_CCP_DQS_SELECT_OE_START     GENMASK(7, 4)
+#define CDNS_XSPI_CCP_DQS_SELECT_OE_END       GENMASK(3, 0)
+
+/* PHY gate loopback control register */
+#define CDNS_XSPI_CCP_PHY_GATE_LPBCK_CTRL     0x0008
+#define CDNS_XSPI_CCP_READ_DATA_DELAY_SEL     GENMASK(24, 19)
+#define CDNS_XSPI_CCP_GATE_CFG_CLOSE          GENMASK(5, 4)
+#define CDNS_XSPI_CCP_GATE_CFG                GENMASK(3, 0)
+
+/* PHY DLL slave control register */
+#define CDNS_XSPI_CCP_PHY_DLL_SLAVE_CTRL      0x0010
+#define CDNS_XSPI_CCP_CLK_WR_DELAY            GENMASK(15, 8)
+#define CDNS_XSPI_CCP_READ_DQS_DELAY          GENMASK(7, 0)
+
+#define CDNS_XSPI_AUX_PHY_ADDONS_REG          0x0040
+#define CDNS_XSPI_AUX_PHY_ADDONS_VALUE        0xE0012000
+#define CDNS_XSPI_AUX_DEV_DISC_CONFIG_REG     0x0048
+#define CDNS_XSPI_AUX_DEV_DISC_CONFIG_VALUE   0x00000000
+#define CDNS_XSPI_AUX_DRIVING_REG             0x0050
+#define CDNS_XSPI_AUX_CTRL_RESET              BIT(0)
+
+/* DLL PHY control register */
+#define CDNS_XSPI_DLL_PHY_CTRL                0x1034
+#define CDNS_XSPI_CCP_DQS_LAST_DATA_DROP_EN   BIT(20)
+
+/* Command registers */
+#define CDNS_XSPI_CMD_REG_0                   0x0000
+#define CDNS_XSPI_CMD_REG_1                   0x0004
+#define CDNS_XSPI_CMD_REG_2                   0x0008
+#define CDNS_XSPI_CMD_REG_3                   0x000C
+#define CDNS_XSPI_CMD_REG_4                   0x0010
+#define CDNS_XSPI_CMD_REG_5                   0x0014
+
+/* Command status registers */
+#define CDNS_XSPI_CMD_STATUS_REG              0x0044
+#define CDNS_XSPI_CMD_COMPLETED               BIT(15)
+#define CDNS_XSPI_CMD_FAILED                  BIT(14)
+
+/* Controller status register */
+#define CDNS_XSPI_CTRL_STATUS_REG             0x0100
+#define CDNS_XSPI_INIT_COMPLETED              BIT(16)
+#define CDNS_XSPI_INIT_LEGACY                 BIT(9)
+#define CDNS_XSPI_INIT_FAIL                   BIT(8)
+#define CDNS_XSPI_CTRL_BUSY                   BIT(7)
+
+/* Controller interrupt status register */
+#define CDNS_XSPI_INTR_STATUS_REG             0x0110
+#define CDNS_XSPI_STIG_DONE                   BIT(23)
+#define CDNS_XSPI_SDMA_ERROR                  BIT(22)
+#define CDNS_XSPI_SDMA_TRIGGER                BIT(21)
+
+/* Controller interrupt enable register */
+#define CDNS_XSPI_INTR_ENABLE_REG             0x0114
+#define CDNS_XSPI_INTR_EN                     BIT(31)
+#define CDNS_XSPI_STIG_DONE_EN                BIT(23)
+#define CDNS_XSPI_SDMA_ERROR_EN               BIT(22)
+#define CDNS_XSPI_SDMA_TRIGGER_EN             BIT(21)
+
+#define CDNS_XSPI_INTR_MASK (CDNS_XSPI_INTR_EN | \
+	CDNS_XSPI_STIG_DONE_EN  | \
+	CDNS_XSPI_SDMA_ERROR_EN | \
+	CDNS_XSPI_SDMA_TRIGGER_EN)
+
+/* Controller config register */
+#define CDNS_XSPI_CTRL_CONFIG_REG             0x0230
+#define CDNS_XSPI_CTRL_WORK_MODE              GENMASK(6, 5)
+
+/* SDMA trigger transaction registers */
+#define CDNS_XSPI_SDMA_SIZE_REG               0x0240
+#define CDNS_XSPI_SDMA_TRD_INFO_REG           0x0244
+#define CDNS_XSPI_SDMA_DIR                    BIT(8)
+
+/* Controller features register */
+#define CDNS_XSPI_CTRL_FEATURES_REG           0x0F04
+#define CDNS_XSPI_NUM_BANKS                   GENMASK(25, 24)
+#define CDNS_XSPI_DMA_DATA_WIDTH              BIT(21)
+#define CDNS_XSPI_NUM_THREADS                 GENMASK(3, 0)
+
+/* Controller version register */
+#define CDNS_XSPI_CTRL_VERSION_REG            0x0F00
+#define CDNS_XSPI_MAGIC_NUM                   GENMASK(31, 16)
+#define CDNS_XSPI_CTRL_REV                    GENMASK(7, 0)
+
+/* STIG Profile 1.0 instruction fields (split into registers) */
+#define CDNS_XSPI_CMD_INSTR_TYPE              GENMASK(6, 0)
+#define CDNS_XSPI_CMD_P1_R1_ADDR0             GENMASK(31, 24)
+#define CDNS_XSPI_CMD_P1_R2_ADDR1             GENMASK(7, 0)
+#define CDNS_XSPI_CMD_P1_R2_ADDR2             GENMASK(15, 8)
+#define CDNS_XSPI_CMD_P1_R2_ADDR3             GENMASK(23, 16)
+#define CDNS_XSPI_CMD_P1_R2_ADDR4             GENMASK(31, 24)
+#define CDNS_XSPI_CMD_P1_R3_ADDR5             GENMASK(7, 0)
+#define CDNS_XSPI_CMD_P1_R3_CMD               GENMASK(23, 16)
+#define CDNS_XSPI_CMD_P1_R3_NUM_ADDR_BYTES    GENMASK(30, 28)
+#define CDNS_XSPI_CMD_P1_R4_ADDR_IOS          GENMASK(1, 0)
+#define CDNS_XSPI_CMD_P1_R4_CMD_IOS           GENMASK(9, 8)
+#define CDNS_XSPI_CMD_P1_R4_BANK              GENMASK(14, 12)
+
+/* STIG data sequence instruction fields (split into registers) */
+#define CDNS_XSPI_CMD_DSEQ_R2_DCNT_L          GENMASK(31, 16)
+#define CDNS_XSPI_CMD_DSEQ_R3_DCNT_H          GENMASK(15, 0)
+#define CDNS_XSPI_CMD_DSEQ_R3_NUM_OF_DUMMY    GENMASK(25, 20)
+#define CDNS_XSPI_CMD_DSEQ_R4_BANK            GENMASK(14, 12)
+#define CDNS_XSPI_CMD_DSEQ_R4_DATA_IOS        GENMASK(9, 8)
+#define CDNS_XSPI_CMD_DSEQ_R4_DIR             BIT(4)
+
+/* STIG command status fields */
+#define CDNS_XSPI_CMD_STATUS_COMPLETED        BIT(15)
+#define CDNS_XSPI_CMD_STATUS_FAILED           BIT(14)
+#define CDNS_XSPI_CMD_STATUS_DQS_ERROR        BIT(3)
+#define CDNS_XSPI_CMD_STATUS_CRC_ERROR        BIT(2)
+#define CDNS_XSPI_CMD_STATUS_BUS_ERROR        BIT(1)
+#define CDNS_XSPI_CMD_STATUS_INV_SEQ_ERROR    BIT(0)
+
+#define CDNS_XSPI_CTRL_WORK_MODE_STIG         0x01
+
+#define CDNS_XSPI_STIG_DONE_FLAG              BIT(0)
+
+/* Helper macros for filling command registers */
+#define CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_1(op, data_phase) ( \
+	FIELD_PREP(CDNS_XSPI_CMD_INSTR_TYPE, (data_phase) ? \
+		CDNS_XSPI_STIG_INSTR_TYPE_1 : CDNS_XSPI_STIG_INSTR_TYPE_0) | \
+	FIELD_PREP(CDNS_XSPI_CMD_P1_R1_ADDR0, op->addr.val & 0xff))
+
+#define CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_2(op) ( \
+	FIELD_PREP(CDNS_XSPI_CMD_P1_R2_ADDR1, (op->addr.val >> 8)  & 0xFF) | \
+	FIELD_PREP(CDNS_XSPI_CMD_P1_R2_ADDR2, (op->addr.val >> 16) & 0xFF) | \
+	FIELD_PREP(CDNS_XSPI_CMD_P1_R2_ADDR3, (op->addr.val >> 24) & 0xFF) | \
+	FIELD_PREP(CDNS_XSPI_CMD_P1_R2_ADDR4, (op->addr.val >> 32) & 0xFF))
+
+#define CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_3(op) ( \
+	FIELD_PREP(CDNS_XSPI_CMD_P1_R3_ADDR5, (op->addr.val >> 40) & 0xFF) | \
+	FIELD_PREP(CDNS_XSPI_CMD_P1_R3_CMD, op->cmd.opcode) | \
+	FIELD_PREP(CDNS_XSPI_CMD_P1_R3_NUM_ADDR_BYTES, op->addr.nbytes))
+
+#define CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_4(op, chipsel) ( \
+	FIELD_PREP(CDNS_XSPI_CMD_P1_R4_ADDR_IOS, ilog2(op->addr.buswidth)) | \
+	FIELD_PREP(CDNS_XSPI_CMD_P1_R4_CMD_IOS, ilog2(op->cmd.buswidth)) | \
+	FIELD_PREP(CDNS_XSPI_CMD_P1_R4_BANK, chipsel))
+
+#define CDNS_XSPI_CMD_FLD_DSEQ_CMD_1(op) \
+	FIELD_PREP(CDNS_XSPI_CMD_INSTR_TYPE, CDNS_XSPI_STIG_INSTR_TYPE_DATA_SEQ)
+
+#define CDNS_XSPI_CMD_FLD_DSEQ_CMD_2(op) \
+	FIELD_PREP(CDNS_XSPI_CMD_DSEQ_R2_DCNT_L, op->data.nbytes & 0xFFFF)
+
+#define CDNS_XSPI_CMD_FLD_DSEQ_CMD_3(op) ( \
+	FIELD_PREP(CDNS_XSPI_CMD_DSEQ_R3_DCNT_H, \
+		(op->data.nbytes >> 16) & 0xffff) | \
+	FIELD_PREP(CDNS_XSPI_CMD_DSEQ_R3_NUM_OF_DUMMY, op->dummy.nbytes * 8))
+
+#define CDNS_XSPI_CMD_FLD_DSEQ_CMD_4(op, chipsel) ( \
+	FIELD_PREP(CDNS_XSPI_CMD_DSEQ_R4_BANK, chipsel) | \
+	FIELD_PREP(CDNS_XSPI_CMD_DSEQ_R4_DATA_IOS, ilog2(op->data.buswidth)) | \
+	FIELD_PREP(CDNS_XSPI_CMD_DSEQ_R4_DIR, \
+		(op->data.dir == SPI_MEM_DATA_IN) ? \
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
+struct cdns_xspi_platform_data {
+	u32 phy_data_sel_oe_start;
+	u32 phy_data_sel_oe_end;
+	u32 phy_dqs_sel_oe_start;
+	u32 phy_dqs_sel_oe_end;
+	u32 phy_gate_cfg_close;
+	u32 phy_gate_cfg;
+	u32 phy_rd_del_sel;
+	u32 clk_wr_delay;
+	bool dqs_last_data_drop;
+	bool use_lpbk_dqs;
+	bool use_ext_lpbk_dqs;
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
+	int current_cs;
+
+	struct mutex lock;
+
+	struct completion cmd_complete;
+	struct completion sdma_complete;
+	bool sdma_error;
+
+	void *in_buffer;
+	const void *out_buffer;
+
+	u8 hw_num_banks;
+
+	struct cdns_xspi_platform_data *plat_data;
+};
+
+static void cdns_xspi_controller_reset(struct cdns_xspi_dev *cdns_xspi)
+{
+	u32 driving_reg = 0;
+
+	driving_reg = readl(cdns_xspi->auxbase + CDNS_XSPI_AUX_DRIVING_REG);
+	driving_reg |= CDNS_XSPI_AUX_CTRL_RESET;
+	writel(driving_reg, cdns_xspi->auxbase + CDNS_XSPI_AUX_DRIVING_REG);
+
+	udelay(10);
+
+	driving_reg &= ~CDNS_XSPI_AUX_CTRL_RESET;
+	writel(driving_reg, cdns_xspi->auxbase + CDNS_XSPI_AUX_DRIVING_REG);
+}
+
+static int cdns_xspi_read_dqs_delay_training(struct cdns_xspi_dev *cdns_xspi)
+{
+	int rd_dqs_del;
+	int rd_dqs_del_min = -1;
+	int rd_dqs_del_max = -1;
+
+	u32 phy_dll_slave_ctrl = 0;
+	u32 ctrl_status = 0;
+
+	phy_dll_slave_ctrl = readl(cdns_xspi->auxbase +
+		CDNS_XSPI_CCP_PHY_DLL_SLAVE_CTRL);
+
+	dev_info(cdns_xspi->dev,
+		"Running PHY training for read_dqs_delay parameter\n");
+
+	for (rd_dqs_del = 0; rd_dqs_del < U8_MAX; rd_dqs_del++) {
+		phy_dll_slave_ctrl &= ~CDNS_XSPI_CCP_READ_DQS_DELAY;
+		phy_dll_slave_ctrl |= FIELD_PREP(CDNS_XSPI_CCP_READ_DQS_DELAY,
+			rd_dqs_del);
+
+		writel(phy_dll_slave_ctrl,
+			cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_DLL_SLAVE_CTRL);
+
+		cdns_xspi_controller_reset(cdns_xspi);
+
+		readl_relaxed_poll_timeout(cdns_xspi->iobase +
+			CDNS_XSPI_CTRL_STATUS_REG, ctrl_status,
+			(ctrl_status & CDNS_XSPI_INIT_COMPLETED), 10, 10000);
+
+		if (!(ctrl_status & CDNS_XSPI_INIT_COMPLETED) ||
+			(ctrl_status & CDNS_XSPI_INIT_FAIL)) {
+			if (rd_dqs_del_min != -1)
+				rd_dqs_del_max = rd_dqs_del - 1;
+		} else {
+			if (rd_dqs_del_min == -1)
+				rd_dqs_del_min = rd_dqs_del;
+		}
+	}
+
+	if (rd_dqs_del_min == -1) {
+		dev_err(cdns_xspi->dev, "PHY training failed\n");
+		return -EBUSY;
+	} else if (rd_dqs_del_max == -1) {
+		rd_dqs_del_max = U8_MAX;
+	}
+
+	rd_dqs_del = rd_dqs_del_min + rd_dqs_del_max / 2;
+	dev_info(cdns_xspi->dev,
+		"Using optimal read_dqs_delay value: %d\n", rd_dqs_del);
+
+	phy_dll_slave_ctrl &= ~CDNS_XSPI_CCP_READ_DQS_DELAY;
+	phy_dll_slave_ctrl |= FIELD_PREP(CDNS_XSPI_CCP_READ_DQS_DELAY,
+		rd_dqs_del);
+
+	writel(phy_dll_slave_ctrl,
+		cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_DLL_SLAVE_CTRL);
+
+	return 0;
+}
+
+static int cdns_xspi_phy_init(struct cdns_xspi_dev *cdns_xspi)
+{
+	u32 xspi_dll_phy_ctrl = 0;
+	u32 phy_dq_timing = CDNS_XSPI_CCP_PHY_DQ_TIMING_INIT_VAL;
+	u32 phy_dqs_timing = 0;
+	u32 phy_gate_lpbck_ctrl = 0;
+	u32 phy_dll_slave_ctrl = 0;
+
+	if (cdns_xspi->plat_data->use_lpbk_dqs) {
+		phy_dqs_timing |= FIELD_PREP(CDNS_XSPI_CCP_USE_LPBCK_DQS, 1);
+
+		/*
+		 * For XSPI protocol, phony_dqs and lpbk_dqs must
+		 * have same value
+		 */
+		phy_dqs_timing |= FIELD_PREP(CDNS_XSPI_CCP_USE_PHONY, 1);
+
+		if (cdns_xspi->plat_data->use_ext_lpbk_dqs)
+			phy_dqs_timing |=
+				FIELD_PREP(CDNS_XSPI_CCP_USE_EXT_LPBCK_DQS, 1);
+	}
+
+	xspi_dll_phy_ctrl = readl(cdns_xspi->auxbase + CDNS_XSPI_DLL_PHY_CTRL);
+
+	/* While using memory DQS last_data_drop parameter should be enabled */
+	if (cdns_xspi->plat_data->dqs_last_data_drop)
+		xspi_dll_phy_ctrl |=
+			FIELD_PREP(CDNS_XSPI_CCP_DQS_LAST_DATA_DROP_EN, 1);
+
+	phy_dq_timing |= FIELD_PREP(CDNS_XSPI_CCP_DATA_SELECT_OE_START,
+		cdns_xspi->plat_data->phy_data_sel_oe_start);
+	phy_dq_timing |= FIELD_PREP(CDNS_XSPI_CCP_DATA_SELECT_OE_END,
+		cdns_xspi->plat_data->phy_data_sel_oe_end);
+
+	phy_dqs_timing |= FIELD_PREP(CDNS_XSPI_CCP_DQS_SELECT_OE_START,
+		cdns_xspi->plat_data->phy_dqs_sel_oe_start);
+	phy_dqs_timing |= FIELD_PREP(CDNS_XSPI_CCP_DQS_SELECT_OE_END,
+		cdns_xspi->plat_data->phy_dqs_sel_oe_end);
+
+	phy_gate_lpbck_ctrl |= FIELD_PREP(CDNS_XSPI_CCP_GATE_CFG_CLOSE,
+		cdns_xspi->plat_data->phy_gate_cfg_close);
+	phy_gate_lpbck_ctrl |= FIELD_PREP(CDNS_XSPI_CCP_GATE_CFG,
+		cdns_xspi->plat_data->phy_gate_cfg);
+	phy_gate_lpbck_ctrl |= FIELD_PREP(CDNS_XSPI_CCP_READ_DATA_DELAY_SEL,
+		cdns_xspi->plat_data->phy_rd_del_sel);
+
+	phy_dll_slave_ctrl |= FIELD_PREP(CDNS_XSPI_CCP_CLK_WR_DELAY,
+		cdns_xspi->plat_data->clk_wr_delay);
+
+	writel(xspi_dll_phy_ctrl,
+		cdns_xspi->auxbase + CDNS_XSPI_DLL_PHY_CTRL);
+	writel(phy_dq_timing,
+		cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_DQ_TIMING);
+	writel(phy_dqs_timing,
+		cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_DQS_TIMING);
+	writel(phy_gate_lpbck_ctrl,
+		cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_GATE_LPBCK_CTRL);
+	writel(phy_dll_slave_ctrl,
+		cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_DLL_SLAVE_CTRL);
+
+	writel(CDNS_XSPI_AUX_PHY_ADDONS_VALUE,
+		cdns_xspi->auxbase + CDNS_XSPI_AUX_PHY_ADDONS_REG);
+	writel(CDNS_XSPI_AUX_DEV_DISC_CONFIG_VALUE,
+		cdns_xspi->auxbase + CDNS_XSPI_AUX_DEV_DISC_CONFIG_REG);
+
+	return cdns_xspi_read_dqs_delay_training(cdns_xspi);
+}
+
+static int cdns_xspi_wait_for_controller_idle(struct cdns_xspi_dev *cdns_xspi)
+{
+	u32 ctrl_stat;
+
+	return readl_relaxed_poll_timeout(cdns_xspi->iobase +
+		CDNS_XSPI_CTRL_STATUS_REG,
+		ctrl_stat, ((ctrl_stat & CDNS_XSPI_CTRL_BUSY) == 0), 100, 1000);
+}
+
+static void cdns_xspi_trigger_command(struct cdns_xspi_dev *cdns_xspi,
+	u32 cmd_regs[5])
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
+					"Incorrect DQS pulses were detected during data read operation\n");
+				ret = -EPROTO;
+			}
+			if (cmd_status & CDNS_XSPI_CMD_STATUS_CRC_ERROR) {
+				dev_err(cdns_xspi->dev,
+					"CRC error received from minicontroller\n");
+				ret = -EPROTO;
+			}
+			if (cmd_status & CDNS_XSPI_CMD_STATUS_BUS_ERROR) {
+				dev_err(cdns_xspi->dev,
+					"Controller got an error response on the system DMA interface\n");
+				ret = -EPROTO;
+			}
+			if (cmd_status & CDNS_XSPI_CMD_STATUS_INV_SEQ_ERROR) {
+				dev_err(cdns_xspi->dev,
+					"Invalid command sequence has been detected\n");
+				ret = -EPROTO;
+			}
+		}
+	} else {
+		dev_err(cdns_xspi->dev, "Fatal error - command not completed\n");
+		ret = -EPROTO;
+	}
+
+	return ret;
+}
+
+static void cdns_xspi_set_interrupts(struct cdns_xspi_dev *cdns_xspi,
+	bool enabled)
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
+
+	writel(FIELD_PREP(CDNS_XSPI_CTRL_WORK_MODE,
+		CDNS_XSPI_CTRL_WORK_MODE_STIG),
+		cdns_xspi->iobase + CDNS_XSPI_CTRL_CONFIG_REG);
+
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
+			cdns_xspi->in_buffer, sdma_size);
+		break;
+
+	case CDNS_XSPI_SDMA_DIR_WRITE:
+		iowrite8_rep(cdns_xspi->sdmabase,
+			cdns_xspi->out_buffer, sdma_size);
+		break;
+	}
+}
+
+static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
+	const struct spi_mem_op *op, bool data_phase)
+{
+	u32 cmd_regs[5] = {0};
+	u32 cmd_status;
+
+	cdns_xspi_wait_for_controller_idle(cdns_xspi);
+	cdns_xspi_set_interrupts(cdns_xspi, true);
+	cdns_xspi->sdma_error = false;
+
+	cmd_regs[1] = CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_1(op, data_phase);
+	cmd_regs[2] = CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_2(op);
+	cmd_regs[3] = CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_3(op);
+	cmd_regs[4] = CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_4(op,
+		cdns_xspi->current_cs);
+
+	cdns_xspi_trigger_command(cdns_xspi, cmd_regs);
+
+	if (data_phase) {
+
+		cmd_regs[0] = CDNS_XSPI_STIG_DONE_FLAG;
+
+		cmd_regs[1] = CDNS_XSPI_CMD_FLD_DSEQ_CMD_1(op);
+		cmd_regs[2] = CDNS_XSPI_CMD_FLD_DSEQ_CMD_2(op);
+		cmd_regs[3] = CDNS_XSPI_CMD_FLD_DSEQ_CMD_3(op);
+		cmd_regs[4] = CDNS_XSPI_CMD_FLD_DSEQ_CMD_4(op,
+			cdns_xspi->current_cs);
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
+
+	cmd_status = cdns_xspi_check_command_status(cdns_xspi);
+	cdns_xspi_set_interrupts(cdns_xspi, false);
+
+	if (cmd_status & CDNS_XSPI_CMD_STATUS_FAILED)
+		return -EPROTO;
+
+	return 0;
+}
+
+static int cdns_xspi_mem_op(struct cdns_xspi_dev *cdns_xspi,
+	struct spi_mem *mem, const struct spi_mem_op *op)
+{
+	if (cdns_xspi->current_cs != mem->spi->chip_select)
+		cdns_xspi->current_cs = mem->spi->chip_select;
+
+	return cdns_xspi_send_stig_command(cdns_xspi, op,
+		(op->data.dir != SPI_MEM_NO_DATA));
+}
+
+static int cdns_xspi_mem_op_execute(struct spi_mem *mem,
+	const struct spi_mem_op *op)
+{
+	struct cdns_xspi_dev *cdns_xspi =
+		spi_master_get_devdata(mem->spi->master);
+	int ret = 0;
+
+	mutex_lock(&cdns_xspi->lock);
+	ret = cdns_xspi_mem_op(cdns_xspi, mem, op);
+	mutex_unlock(&cdns_xspi->lock);
+
+	return ret;
+}
+
+static const struct spi_controller_mem_ops cadence_xspi_mem_ops = {
+	.exec_op = cdns_xspi_mem_op_execute,
+};
+
+static int cdns_xspi_setup(struct spi_device *spi_dev)
+{
+	if (spi_dev->chip_select > spi_dev->master->num_chipselect) {
+		dev_err(&spi_dev->dev,
+			"%d chip-select is out of range\n",
+			spi_dev->chip_select);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static irqreturn_t cdns_xspi_irq_handler(int this_irq, void *dev)
+{
+	struct cdns_xspi_dev *cdns_xspi = dev;
+	u32 irq_status;
+	irqreturn_t result = IRQ_NONE;
+
+	irq_status = readl(cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG);
+	if (irq_status) {
+		writel(irq_status,
+			cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG);
+
+		if (irq_status & CDNS_XSPI_SDMA_ERROR) {
+			dev_err(cdns_xspi->dev, "Slave DMA transaction error\n");
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
+	return result;
+}
+
+static int cdns_xspi_of_get_plat_data(struct platform_device *pdev)
+{
+	struct device_node *node_prop = pdev->dev.of_node;
+	struct device_node *node_child;
+	struct cdns_xspi_platform_data *plat_data = pdev->dev.platform_data;
+	unsigned int property;
+	unsigned int cs;
+
+	if (of_property_read_u32(node_prop,
+		"cdns,phy-data-select-oe-start", &property)) {
+		dev_err(&pdev->dev, "Couldn't determine data select oe start\n");
+		return -ENXIO;
+	}
+	plat_data->phy_data_sel_oe_start = property;
+
+	if (of_property_read_u32(node_prop,
+		"cdns,phy-data-select-oe-end", &property)) {
+		dev_err(&pdev->dev, "Couldn't determine data select oe end\n");
+		return -ENXIO;
+	}
+	plat_data->phy_data_sel_oe_end = property;
+
+	if (of_property_read_u32(node_prop,
+		"cdns,phy-dqs-select-oe-start", &property)) {
+		dev_err(&pdev->dev, "Couldn't determine DQS select oe start\n");
+		return -ENXIO;
+	}
+	plat_data->phy_dqs_sel_oe_start = property;
+
+	if (of_property_read_u32(node_prop,
+		"cdns,phy-dqs-select-oe-end", &property)) {
+		dev_err(&pdev->dev, "Couldn't determine DQS select oe end\n");
+		return -ENXIO;
+	}
+	plat_data->phy_dqs_sel_oe_end = property;
+
+	if (of_property_read_u32(node_prop,
+		"cdns,phy-gate-cfg-close", &property)) {
+		dev_err(&pdev->dev, "Couldn't determine gate config close\n");
+		return -ENXIO;
+	}
+	plat_data->phy_gate_cfg_close = property;
+
+	if (of_property_read_u32(node_prop,
+		"cdns,phy-gate-cfg", &property)) {
+		dev_err(&pdev->dev, "Couldn't determine gate config\n");
+		return -ENXIO;
+	}
+	plat_data->phy_gate_cfg = property;
+
+	if (of_property_read_u32(node_prop,
+		"cdns,phy-rd-del-select", &property)) {
+		dev_err(&pdev->dev, "Couldn't determine read delay select\n");
+		return -ENXIO;
+	}
+	plat_data->phy_rd_del_sel = property;
+
+	if (of_property_read_u32(node_prop,
+		"cdns,phy-clk-wr-delay", &property)) {
+		dev_err(&pdev->dev, "Couldn't determine clock write delay\n");
+		return -ENXIO;
+	}
+	plat_data->clk_wr_delay = property;
+
+	plat_data->dqs_last_data_drop = of_property_read_bool(node_prop,
+		"cdns,dqs-last-data-drop");
+	plat_data->use_lpbk_dqs = of_property_read_bool(node_prop,
+		"cdns,phy-use-lpbk-dqs");
+	plat_data->use_ext_lpbk_dqs = of_property_read_bool(node_prop,
+		"cdns,phy-use-ext-lpbk-dqs");
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
+		readl(cdns_xspi->iobase + CDNS_XSPI_DLL_PHY_CTRL));
+	dev_info(dev, "   * phy_dq_timing: %08x\n",
+		readl(cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_DQ_TIMING));
+	dev_info(dev, "   * phy_dqs_timing: %08x\n",
+		readl(cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_DQS_TIMING));
+	dev_info(dev, "   * phy_gate_loopback_ctrl: %08x\n",
+		readl(cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_GATE_LPBCK_CTRL));
+	dev_info(dev, "   * phy_dll_slave_ctrl: %08x\n",
+		readl(cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_DLL_SLAVE_CTRL));
+}
+
+static int cdns_xspi_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct spi_master *master = NULL;
+	struct resource *res = NULL;
+	struct cdns_xspi_dev *cdns_xspi = NULL;
+	struct cdns_xspi_platform_data *plat_data = NULL;
+	int ret;
+
+	master = spi_alloc_master(dev, sizeof(*cdns_xspi));
+	if (!master) {
+		ret = -ENOMEM;
+		dev_err(dev, "Failed to allocate memory for spi_master\n");
+		goto err_no_mem;
+	}
+
+	master->mode_bits = SPI_3WIRE | SPI_TX_DUAL  | SPI_TX_QUAD  |
+		SPI_RX_DUAL | SPI_RX_QUAD | SPI_TX_OCTAL | SPI_RX_OCTAL |
+		SPI_MODE_0  | SPI_MODE_3;
+
+	master->mem_ops = &cadence_xspi_mem_ops;
+	master->setup = cdns_xspi_setup;
+	master->dev.of_node = pdev->dev.of_node;
+	master->bus_num = -1;
+
+	platform_set_drvdata(pdev, master);
+
+	plat_data = devm_kmalloc(dev, sizeof(*plat_data), GFP_KERNEL);
+	if (!plat_data) {
+		ret = -ENOMEM;
+		dev_err(dev, "Failed to allocate memory for platform_data\n");
+		goto err_spi_master;
+	}
+	pdev->dev.platform_data = plat_data;
+
+	cdns_xspi = spi_master_get_devdata(master);
+	cdns_xspi->pdev = pdev;
+	cdns_xspi->dev = &pdev->dev;
+	cdns_xspi->current_cs = 0;
+	cdns_xspi->plat_data = plat_data;
+
+	init_completion(&cdns_xspi->cmd_complete);
+	init_completion(&cdns_xspi->sdma_complete);
+
+	ret = cdns_xspi_of_get_plat_data(pdev);
+	if (ret) {
+		ret = -ENODEV;
+		dev_err(dev, "Failed to get platform data\n");
+		goto err_spi_master;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	cdns_xspi->iobase = devm_ioremap_resource(cdns_xspi->dev, res);
+	if (IS_ERR(cdns_xspi->iobase)) {
+		ret = PTR_ERR(cdns_xspi->iobase);
+		dev_err(dev, "Failed to remap controller base address\n");
+		goto err_spi_master;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	cdns_xspi->sdmabase = devm_ioremap_resource(cdns_xspi->dev, res);
+	if (IS_ERR(cdns_xspi->sdmabase)) {
+		ret = PTR_ERR(cdns_xspi->sdmabase);
+		dev_err(dev, "Failed to remap SDMA address\n");
+		goto err_spi_master;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+	cdns_xspi->auxbase = devm_ioremap_resource(cdns_xspi->dev, res);
+	if (IS_ERR(cdns_xspi->auxbase)) {
+		ret = PTR_ERR(cdns_xspi->auxbase);
+		dev_err(dev, "Failed to remap AUX address\n");
+		goto err_spi_master;
+	}
+
+	cdns_xspi->irq = platform_get_irq(pdev, 0);
+	if (cdns_xspi->irq < 0) {
+		ret = -ENXIO;
+		dev_err(dev, "Failed to get IRQ\n");
+		goto err_spi_master;
+	}
+
+	ret = devm_request_irq(dev, cdns_xspi->irq, cdns_xspi_irq_handler,
+		IRQF_SHARED, pdev->name, cdns_xspi);
+	if (ret) {
+		dev_err(dev, "Failed to request IRQ: %d\n", cdns_xspi->irq);
+		goto err_spi_master;
+	}
+
+	ret = cdns_xspi_phy_init(cdns_xspi);
+	if (ret) {
+		dev_err(dev, "Failed to initialize PHY\n");
+		goto err_spi_master;
+	}
+
+	cdns_xspi_print_phy_config(cdns_xspi);
+
+	ret = cdns_xspi_controller_init(cdns_xspi);
+	if (ret) {
+		dev_err(dev, "Failed to initialize controller\n");
+		goto err_spi_master;
+	}
+
+	master->num_chipselect = 1 << cdns_xspi->hw_num_banks;
+
+	ret = devm_spi_register_master(dev, master);
+	if (ret) {
+		dev_err(dev, "Failed to register SPI master\n");
+		goto err_spi_master;
+	}
+
+	dev_info(dev, "Successfully registered SPI master\n");
+
+	return 0;
+
+err_spi_master:
+	spi_master_put(master);
+
+err_no_mem:
+	dev_err(dev, "Failed to probe Cadence XSPI controller driver\n");
+
+	return ret;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id cdns_xspi_of_match[] = {
+	{
+		.compatible = "cdns,xspi-nor-fpga",
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
-- 
2.15.0

