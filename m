Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA7B93D0A8A
	for <lists+linux-spi@lfdr.de>; Wed, 21 Jul 2021 10:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235090AbhGUHkr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 21 Jul 2021 03:40:47 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:4682 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236471AbhGUHgQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 21 Jul 2021 03:36:16 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16L88lQJ001006;
        Wed, 21 Jul 2021 01:15:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=Jj8wh/chfx6h1erceLi4Wq9sDUWJSknkKbDZnhdcjTQ=;
 b=s/5y0jbCqsLyYxuK+LPjpjK7E2SjKjXmC+mfTMKhSNGTX/CKELEF6yxMiJqy+4EnHHvv
 25av77LZP+sfb467zVZ/V40LoL/lQjAil3cul4kM73rGERRFUM8hRHYPhfeLHdUH70xj
 DBomAnFvD6KIOkhtX5OkkLq1u+lnI7MSi2wwCsrc/cpfJSmCVqux50FWrjH6bsI1hGmV
 m/kVwrXiOSycPn9xlLAnwYIH7Z6ESZEoLsOV6dFUoHKa3sXhaom7m82/XPo+PyDbx64s
 ucIGEScUkprKNnl3ItDfopjUBagKakgTLVeF7h9yTNnProCgJwcVFhi45/rgw+6NscMb 6A== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by mx0b-0014ca01.pphosted.com with ESMTP id 39wbkuxx0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jul 2021 01:15:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mba2jzyx+vph1K6S4yKTE5bq2v9gs5uaHn8rKGDEOHLyuQ7cRibjDZkyUd9RIWeTAZLqBHqNhR91leVMW0boimr2dRv7I1JSRfSfl+OjzGPQXii42Zk+PeyHATsIZjBcADmavIPFskoMVka8XzBklcOMksah0JK3PWKa0IVkNFUC7P6VrpWACyepT71MXiPi2Ft1Yd4D7JyRV/H7W/Dpvw5bLIbFqr20gIPUviwAHZ29hPSM0g7ZSdtDtBtsMYNildGpx80jm6RynvumUiX07uZjIr5ZOE4nRzDVkbFx22sEk16jn2ONVlOmfR8UnGgLsrijkOPVyi3MU4t0M0GPxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jj8wh/chfx6h1erceLi4Wq9sDUWJSknkKbDZnhdcjTQ=;
 b=Ak7JcYaraeF3LQiItjcdULC52hsWJyD7Npy8IagMF8oBP7yrZJNX79IJB62SHM5eQGL+su31qb9XISN17yNP7CLGRV0TQTfrtEONETTgnWCg/L/D7/pV6wxb7w///VE5GZsGQMSrPMqcPitEjnQQfps01YtNr8SsDits6Rfc+4kCaDN1rANI5ShbKeUwPdW0WjFr7f6JTMT7vKdwmjYzpPfmZTX/PAsIqxZiLCXf2T3QwH0sNPCr3fz4RL+ZjUr3tlIhc+NPyOsA1gTov1ccMf3906sc31jMIbKcjy5yH2yDsrSg5McooPSyiO0nKXguVDvJ6h/Xdl8hqRsgNeFu4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=bootlin.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jj8wh/chfx6h1erceLi4Wq9sDUWJSknkKbDZnhdcjTQ=;
 b=qFFA7OaeZmInVGxGSI14nMxFnpQHCzzNLyt3mZ29VCAwIBS6l3YhI8ph49/inu8tDSJyhWktvp/KKGylkhzLyzy5xRD+q3QtUmHQaDl+JA5kPp/j8hiBehA4FbhiJaioDH1Qksw+O4TnaXwkWXOkE2/AYY3KGyUZV+3YE39y9y4=
Received: from MWHPR1601CA0001.namprd16.prod.outlook.com
 (2603:10b6:300:da::11) by DM6PR07MB6634.namprd07.prod.outlook.com
 (2603:10b6:5:1c2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Wed, 21 Jul
 2021 08:15:53 +0000
Received: from MW2NAM12FT042.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:da:cafe::1e) by MWHPR1601CA0001.outlook.office365.com
 (2603:10b6:300:da::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend
 Transport; Wed, 21 Jul 2021 08:15:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 MW2NAM12FT042.mail.protection.outlook.com (10.13.180.237) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.9 via Frontend Transport; Wed, 21 Jul 2021 08:15:52 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 16L8FnNb029838
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 01:15:51 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 21 Jul 2021 10:15:36 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 21 Jul 2021 10:15:36 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 16L8FaAl025841;
        Wed, 21 Jul 2021 10:15:36 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 16L8Fab2025840;
        Wed, 21 Jul 2021 10:15:36 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <lukas@wunner.de>, <linux-spi@vger.kernel.org>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        <jpawar@cadence.com>, Parshuram Thombare <pthombar@cadence.com>,
        Konrad Kociolek <konrad@cadence.com>
Subject: [PATCH v2 2/2] spi: cadence: add support for Cadence XSPI controller
Date:   Wed, 21 Jul 2021 10:15:34 +0200
Message-ID: <1626855334-25805-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1626855118-25327-1-git-send-email-pthombar@cadence.com>
References: <1626855118-25327-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da75bf81-6004-4efa-2b04-08d94c1fc1ad
X-MS-TrafficTypeDiagnostic: DM6PR07MB6634:
X-Microsoft-Antispam-PRVS: <DM6PR07MB66341F8D6F588A483C142F44C1E39@DM6PR07MB6634.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VtcDA5JJPPVnPo3320BD42Qp4IVz8W9GV/n4FCXZCMTYI9MQbJtB+gfLvzuORr8xxKwCFDcW/CMZFc5BKnUvzzta3fcPwdDlhMve5imbzCR2mVrQcmNk6hl9ApwezCoFhIPyrE+U6kSnPrWEJlq/jv8WO403I0D/gvdWHVgm9utm59Mk3iyKZCqWtCEM2qOk8y78j7L4nSF6u0dkmrud0XaWiGcLMuTAGVTXhqnY6zIPsceoZ9HtLitdFBgZfLtN/y5KtaoIf06R+fa9DwmTpfEjsmkTnpdWuTxfvJ6iVkBm4JKdqNHLLTmRpDYqcvulv1BaTT1VGndrMvZEmx5OxY4YQ0KAXdWBHYyTApFHu7UbuJBK/ad3+4JOUPEDi1B8/3n8DNy98gn5fbFTyZaLWZQ/EevhtljPSbMKLe5i88WjKaBpULmiIj7W6E27hq3BtA7Feac9rk0mqcInlpb9Gi8pHk4SCHYuQLxAySG9dTak9xk1FZQ0w1M4AiJUA5Rn666eWsVNS7DH1xyP3vSeDLUMwtNhJrd1srrOj+mjCmF7zdZwgXePZTBzUGw70szRXl4g6RMqXcZ7nSaZ71ki6c/toMSK0Uf32G8tNn8rJABZQVwg6P3yVYTlPhDBo0SGIi+zr9qhVpg0bNchYLh9PW2NPQJSDFUrT3/mgpTwqHNMbhC4q9x1mX2HS1vqxoqbVI/hDHFiWsZX0j5Be04nePTGAECjiKd4NczXjIcLlk2Vamg+UE0CipEmRaYqBB6F
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(36092001)(46966006)(36840700001)(8936002)(5660300002)(30864003)(107886003)(8676002)(42186006)(508600001)(316002)(336012)(2616005)(110136005)(426003)(26005)(83380400001)(36860700001)(82310400003)(47076005)(36756003)(86362001)(7636003)(356005)(186003)(4326008)(54906003)(70206006)(2906002)(70586007)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 08:15:52.5834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da75bf81-6004-4efa-2b04-08d94c1fc1ad
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT042.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB6634
X-Proofpoint-GUID: kxfT2EidqIiyfTPLppkpCVGk3gNfU_wB
X-Proofpoint-ORIG-GUID: kxfT2EidqIiyfTPLppkpCVGk3gNfU_wB
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-21_04:2021-07-21,2021-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 spamscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2107210045
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch add driver for Cadence's XSPI controller.
Currently ACMD PIO mode is used for NOR flash read, program, erase
operations, all other operations are handled in STIG work mode.

Signed-off-by: Konrad Kociolek <konrad@cadence.com>
Signed-off-by: Jayshri Pawar <jpawar@cadence.com>
Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
---
 drivers/spi/Kconfig            |   11 +
 drivers/spi/Makefile           |    1 +
 drivers/spi/spi-cadence-xspi.c | 1102 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1114 insertions(+)
 create mode 100644 drivers/spi/spi-cadence-xspi.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index e71a4c5..874f7aa 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -228,6 +228,17 @@ config SPI_CADENCE_QUADSPI
 	  device with a Cadence QSPI controller and want to access the
 	  Flash as an MTD device.
 
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
 config SPI_CLPS711X
 	tristate "CLPS711X host SPI controller"
 	depends on ARCH_CLPS711X || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 13e54c4..93229a8 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_SPI_AR934X)		+= spi-ar934x.o
 obj-$(CONFIG_SPI_ARMADA_3700)		+= spi-armada-3700.o
 obj-$(CONFIG_SPI_ATMEL)			+= spi-atmel.o
 obj-$(CONFIG_SPI_ATMEL_QUADSPI)		+= atmel-quadspi.o
+obj-$(CONFIG_SPI_CADENCE_XSPI)		+= spi-cadence-xspi.o
 obj-$(CONFIG_SPI_AT91_USART)		+= spi-at91-usart.o
 obj-$(CONFIG_SPI_ATH79)			+= spi-ath79.o
 obj-$(CONFIG_SPI_AU1550)		+= spi-au1550.o
diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
new file mode 100644
index 0000000..3747831
--- /dev/null
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -0,0 +1,1102 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Cadence XSPI flash controller driver
+ *
+ * Copyright (C) 2020-21 Cadence
+ *
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
+#define CDNS_XSPI_CCP_DATA_SELECT_OE_START	GENMASK(6, 4)
+#define CDNS_XSPI_CCP_DATA_SELECT_OE_END	GENMASK(2, 0)
+#define CDNS_XSPI_CCP_PHY_DQ_TIMING_INIT_VAL	0x80000000
+
+/* PHY DQS timing register */
+#define CDNS_XSPI_CCP_PHY_DQS_TIMING		0x0004
+#define CDNS_XSPI_CCP_USE_EXT_LPBCK_DQS		BIT(22)
+#define CDNS_XSPI_CCP_USE_LPBCK_DQS		BIT(21)
+#define CDNS_XSPI_CCP_USE_PHONY			BIT(20)
+#define CDNS_XSPI_CCP_DQS_SELECT_OE_START	GENMASK(7, 4)
+#define CDNS_XSPI_CCP_DQS_SELECT_OE_END		GENMASK(3, 0)
+
+/* PHY gate loopback control register */
+#define CDNS_XSPI_CCP_PHY_GATE_LPBCK_CTRL	0x0008
+#define CDNS_XSPI_CCP_READ_DATA_DELAY_SEL	GENMASK(24, 19)
+#define CDNS_XSPI_CCP_GATE_CFG_CLOSE		GENMASK(5, 4)
+#define CDNS_XSPI_CCP_GATE_CFG			GENMASK(3, 0)
+
+/* PHY DLL slave control register */
+#define CDNS_XSPI_CCP_PHY_DLL_SLAVE_CTRL	0x0010
+#define CDNS_XSPI_CCP_CLK_WR_DELAY		GENMASK(15, 8)
+#define CDNS_XSPI_CCP_READ_DQS_DELAY		GENMASK(7, 0)
+
+#define CDNS_XSPI_AUX_PHY_ADDONS_REG		0x0040
+#define CDNS_XSPI_AUX_PHY_ADDONS_VALUE		0xE0012000
+#define CDNS_XSPI_AUX_DEV_DISC_CONFIG_REG	0x0048
+#define CDNS_XSPI_AUX_DEV_DISC_CONFIG_VALUE	0x00000000
+#define CDNS_XSPI_AUX_DRIVING_REG		0x0050
+#define CDNS_XSPI_AUX_CTRL_RESET		BIT(0)
+
+/* DLL PHY control register */
+#define CDNS_XSPI_DLL_PHY_CTRL			0x1034
+#define CDNS_XSPI_CCP_DQS_LAST_DATA_DROP_EN	BIT(20)
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
+#define CDNS_XSPI_CMD_COMPLETED			BIT(15)
+#define CDNS_XSPI_CMD_FAILED			BIT(14)
+
+#define CDNS_XSPI_CMD_STATUS_PTR_REG		0x0040
+
+#define CDNS_XSPI_DEV_ERR			BIT(4)
+#define CDNS_XSPI_DQS_ERR			BIT(3)
+#define CDNS_XSPI_CRC_ERR			BIT(2)
+#define CDNS_XSPI_BUS_ERR			BIT(1)
+#define CDNS_XSPI_CMD_ERR			BIT(0)
+
+#define CDNS_XSPI_ACMD_CMD_TYPE			GENMASK(15, 0)
+#define CDNS_XSPI_ACMD_READ_MB_XIP_EN		BIT(16)
+#define CDNS_XSPI_ACMD_READ_MB_XIP_DIS		BIT(17)
+#define CDNS_XSPI_ACMD_INT			BIT(18)
+#define CDNS_XSPI_ACMD_RW_DMA_SEL		BIT(19)
+#define CDNS_XSPI_ACMD_BANK			GENMASK(22, 20)
+#define CDNS_XSPI_ACMD_TRD_NUM			GENMASK(26, 24)
+#define CDNS_XSPI_ACMD_MODE			GENMASK(31, 30)
+
+#define CDNS_XSPI_ACMD_RW_DMA_MASTER		1
+#define CDNS_XSPI_ACMD_RW_DMA_SLAVE		0
+
+#define CDNS_XSPI_ACMD_MODE_PIO			1
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
+	FIELD_PREP(CDNS_XSPI_CMD_DSEQ_R4_DATA_IOS, ilog2((op)->data.buswidth)) | \
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
+enum cdns_xspi_acmd_cmd_type {
+	CDNS_XSPI_ACMD_CMD_RESET = 0x1100,
+	CDNS_XSPI_ACMD_CMD_SECT_ERASE = 0x1000,
+	CDNS_XSPI_ACMD_CMD_CHIP_ERASE = 0x1001,
+	CDNS_XSPI_ACMD_CMD_READ = 0x2200,
+	CDNS_XSPI_ACMD_CMD_PROGRAM = 0x2100,
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
+	int cur_cs;
+
+	struct mutex lock;
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
+				   CDNS_XSPI_CCP_PHY_DLL_SLAVE_CTRL);
+
+	dev_err(cdns_xspi->dev,
+		"Running PHY training for read_dqs_delay parameter\n");
+
+	for (rd_dqs_del = 0; rd_dqs_del < U8_MAX; rd_dqs_del++) {
+		phy_dll_slave_ctrl &= ~CDNS_XSPI_CCP_READ_DQS_DELAY;
+		phy_dll_slave_ctrl |= FIELD_PREP(CDNS_XSPI_CCP_READ_DQS_DELAY,
+						 rd_dqs_del);
+
+		writel(phy_dll_slave_ctrl,
+		       cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_DLL_SLAVE_CTRL);
+		cdns_xspi_controller_reset(cdns_xspi);
+
+		readl_relaxed_poll_timeout(cdns_xspi->iobase +
+					   CDNS_XSPI_CTRL_STATUS_REG,
+					   ctrl_status,
+					   (ctrl_status &
+					    CDNS_XSPI_INIT_COMPLETED),
+					   10, 10000);
+
+		if (!(ctrl_status & CDNS_XSPI_INIT_COMPLETED) ||
+		    (ctrl_status & CDNS_XSPI_INIT_FAIL)) {
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
+		 "Using optimal read_dqs_delay value: %d\n", rd_dqs_del);
+
+	phy_dll_slave_ctrl &= ~CDNS_XSPI_CCP_READ_DQS_DELAY;
+	phy_dll_slave_ctrl |= FIELD_PREP(CDNS_XSPI_CCP_READ_DQS_DELAY,
+					 rd_dqs_del);
+
+	writel(phy_dll_slave_ctrl,
+	       cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_DLL_SLAVE_CTRL);
+
+	return 0;
+}
+
+static int cdns_xspi_phy_init(struct cdns_xspi_dev *cdns_xspi)
+{
+	struct cdns_xspi_platform_data *plat_data = cdns_xspi->plat_data;
+	u32 phy_dq_timing = CDNS_XSPI_CCP_PHY_DQ_TIMING_INIT_VAL;
+	u32 phy_gate_lpbck_ctrl = 0;
+	u32 phy_dll_slave_ctrl = 0;
+	u32 xspi_dll_phy_ctrl = 0;
+	u32 phy_dqs_timing = 0;
+
+	if (plat_data->use_lpbk_dqs) {
+		phy_dqs_timing |= FIELD_PREP(CDNS_XSPI_CCP_USE_LPBCK_DQS, 1);
+
+		/*
+		 * For XSPI protocol, phony_dqs and lpbk_dqs must
+		 * have same value
+		 */
+		phy_dqs_timing |= FIELD_PREP(CDNS_XSPI_CCP_USE_PHONY, 1);
+
+		if (plat_data->use_ext_lpbk_dqs)
+			phy_dqs_timing |=
+				FIELD_PREP(CDNS_XSPI_CCP_USE_EXT_LPBCK_DQS, 1);
+	}
+
+	xspi_dll_phy_ctrl = readl(cdns_xspi->auxbase + CDNS_XSPI_DLL_PHY_CTRL);
+
+	/* While using memory DQS last_data_drop parameter should be enabled */
+	if (plat_data->dqs_last_data_drop)
+		xspi_dll_phy_ctrl |=
+			FIELD_PREP(CDNS_XSPI_CCP_DQS_LAST_DATA_DROP_EN, 1);
+
+	phy_dq_timing |= FIELD_PREP(CDNS_XSPI_CCP_DATA_SELECT_OE_START,
+				    plat_data->phy_data_sel_oe_start);
+	phy_dq_timing |= FIELD_PREP(CDNS_XSPI_CCP_DATA_SELECT_OE_END,
+				    plat_data->phy_data_sel_oe_end);
+
+	phy_dqs_timing |= FIELD_PREP(CDNS_XSPI_CCP_DQS_SELECT_OE_START,
+				     plat_data->phy_dqs_sel_oe_start);
+	phy_dqs_timing |= FIELD_PREP(CDNS_XSPI_CCP_DQS_SELECT_OE_END,
+				     plat_data->phy_dqs_sel_oe_end);
+
+	phy_gate_lpbck_ctrl |= FIELD_PREP(CDNS_XSPI_CCP_GATE_CFG_CLOSE,
+					  plat_data->phy_gate_cfg_close);
+	phy_gate_lpbck_ctrl |= FIELD_PREP(CDNS_XSPI_CCP_GATE_CFG,
+					  plat_data->phy_gate_cfg);
+	phy_gate_lpbck_ctrl |= FIELD_PREP(CDNS_XSPI_CCP_READ_DATA_DELAY_SEL,
+					  plat_data->phy_rd_del_sel);
+
+	phy_dll_slave_ctrl |= FIELD_PREP(CDNS_XSPI_CCP_CLK_WR_DELAY,
+					 plat_data->clk_wr_delay);
+
+	writel(xspi_dll_phy_ctrl,
+	       cdns_xspi->auxbase + CDNS_XSPI_DLL_PHY_CTRL);
+	writel(phy_dq_timing,
+	       cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_DQ_TIMING);
+	writel(phy_dqs_timing,
+	       cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_DQS_TIMING);
+	writel(phy_gate_lpbck_ctrl,
+	       cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_GATE_LPBCK_CTRL);
+	writel(phy_dll_slave_ctrl,
+	       cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_DLL_SLAVE_CTRL);
+
+	writel(CDNS_XSPI_AUX_PHY_ADDONS_VALUE,
+	       cdns_xspi->auxbase + CDNS_XSPI_AUX_PHY_ADDONS_REG);
+	writel(CDNS_XSPI_AUX_DEV_DISC_CONFIG_VALUE,
+	       cdns_xspi->auxbase + CDNS_XSPI_AUX_DEV_DISC_CONFIG_REG);
+
+	return cdns_xspi_read_dqs_delay_training(cdns_xspi);
+}
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
+static int cdns_xspi_wait_for_thread_idle(struct cdns_xspi_dev *cdns_xspi,
+					  int thread_num)
+{
+	u32 trd_stat;
+
+	return readl_relaxed_poll_timeout(cdns_xspi->iobase +
+					  CDNS_XSPI_TRD_STATUS,
+					  trd_stat,
+					  ((trd_stat & BIT(thread_num)) == 0),
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
+static ssize_t cdns_xspi_nor_read(struct cdns_xspi_dev *cdns_xspi, loff_t from,
+				  size_t len, u8 *read_buf)
+{
+	u32 cmd_status;
+	int ret;
+
+	ret = cdns_xspi_wait_for_controller_idle(cdns_xspi);
+	if (ret < 0)
+		return -EIO;
+
+	writel(FIELD_PREP(CDNS_XSPI_CTRL_WORK_MODE, CDNS_XSPI_WORK_MODE_ACMD),
+	       cdns_xspi->iobase + CDNS_XSPI_CTRL_CONFIG_REG);
+
+	ret = cdns_xspi_wait_for_thread_idle(cdns_xspi, 0);
+	if (ret < 0)
+		return -EIO;
+
+	cdns_xspi_set_interrupts(cdns_xspi, true);
+	cdns_xspi->sdma_error = false;
+	cdns_xspi->in_buffer = read_buf;
+
+	writel(from, cdns_xspi->iobase + CDNS_XSPI_CMD_REG_1);
+	writel(len - 1, cdns_xspi->iobase + CDNS_XSPI_CMD_REG_4);
+
+	writel(FIELD_PREP(CDNS_XSPI_ACMD_CMD_TYPE, CDNS_XSPI_ACMD_CMD_READ) |
+	       FIELD_PREP(CDNS_XSPI_ACMD_MODE, CDNS_XSPI_ACMD_MODE_PIO) |
+	       FIELD_PREP(CDNS_XSPI_ACMD_INT, 1) |
+	       FIELD_PREP(CDNS_XSPI_ACMD_BANK, cdns_xspi->cur_cs) |
+	       FIELD_PREP(CDNS_XSPI_ACMD_RW_DMA_SEL,
+			  CDNS_XSPI_ACMD_RW_DMA_SLAVE),
+	       cdns_xspi->iobase + CDNS_XSPI_CMD_REG_0);
+
+	wait_for_completion(&cdns_xspi->sdma_complete);
+	if (cdns_xspi->sdma_error) {
+		cdns_xspi_set_interrupts(cdns_xspi, false);
+		return -EIO;
+	}
+	cdns_xspi_sdma_handle(cdns_xspi);
+
+	wait_for_completion(&cdns_xspi->auto_cmd_complete);
+	cdns_xspi_set_interrupts(cdns_xspi, false);
+
+	cmd_status = cdns_xspi_check_command_status(cdns_xspi);
+	if (cmd_status)
+		return -EPROTO;
+
+	return 0;
+}
+
+static ssize_t cdns_xspi_nor_write(struct cdns_xspi_dev *cdns_xspi, loff_t to,
+				   size_t len, const u8 *write_buf)
+{
+	u32 cmd_status;
+	int ret;
+
+	ret = cdns_xspi_wait_for_controller_idle(cdns_xspi);
+	if (ret < 0)
+		return -EIO;
+
+	writel(FIELD_PREP(CDNS_XSPI_CTRL_WORK_MODE, CDNS_XSPI_WORK_MODE_ACMD),
+	       cdns_xspi->iobase + CDNS_XSPI_CTRL_CONFIG_REG);
+
+	ret = cdns_xspi_wait_for_thread_idle(cdns_xspi, 0);
+	if (ret < 0)
+		return -EIO;
+
+	cdns_xspi_set_interrupts(cdns_xspi, true);
+	cdns_xspi->sdma_error = false;
+	cdns_xspi->out_buffer = write_buf;
+
+	writel(to, cdns_xspi->iobase + CDNS_XSPI_CMD_REG_1);
+	writel(len - 1, cdns_xspi->iobase + CDNS_XSPI_CMD_REG_4);
+
+	writel(FIELD_PREP(CDNS_XSPI_ACMD_CMD_TYPE, CDNS_XSPI_ACMD_CMD_PROGRAM) |
+	       FIELD_PREP(CDNS_XSPI_ACMD_MODE, CDNS_XSPI_ACMD_MODE_PIO) |
+	       FIELD_PREP(CDNS_XSPI_ACMD_INT, 1) |
+	       FIELD_PREP(CDNS_XSPI_ACMD_BANK, cdns_xspi->cur_cs) |
+	       FIELD_PREP(CDNS_XSPI_ACMD_RW_DMA_SEL,
+			  CDNS_XSPI_ACMD_RW_DMA_SLAVE),
+	       cdns_xspi->iobase + CDNS_XSPI_CMD_REG_0);
+
+	wait_for_completion(&cdns_xspi->sdma_complete);
+	if (cdns_xspi->sdma_error) {
+		cdns_xspi_set_interrupts(cdns_xspi, false);
+		return -EIO;
+	}
+	cdns_xspi_sdma_handle(cdns_xspi);
+
+	wait_for_completion(&cdns_xspi->auto_cmd_complete);
+	cdns_xspi_set_interrupts(cdns_xspi, false);
+
+	cmd_status = cdns_xspi_check_command_status(cdns_xspi);
+	if (cmd_status)
+		return -EPROTO;
+
+	return 0;
+}
+
+static int cdns_xspi_nor_erase(struct cdns_xspi_dev *cdns_xspi, loff_t offs)
+{
+	u32 cmd_status;
+	int ret;
+
+	ret = cdns_xspi_wait_for_controller_idle(cdns_xspi);
+	if (ret < 0)
+		return -EIO;
+
+	writel(FIELD_PREP(CDNS_XSPI_CTRL_WORK_MODE, CDNS_XSPI_WORK_MODE_ACMD),
+	       cdns_xspi->iobase + CDNS_XSPI_CTRL_CONFIG_REG);
+
+	ret = cdns_xspi_wait_for_thread_idle(cdns_xspi, 0);
+	if (ret < 0)
+		return -EIO;
+
+	cdns_xspi_set_interrupts(cdns_xspi, true);
+
+	writel(offs, cdns_xspi->iobase + CDNS_XSPI_CMD_REG_1);
+	writel(1, cdns_xspi->iobase + CDNS_XSPI_CMD_REG_4);
+
+	writel(FIELD_PREP(CDNS_XSPI_ACMD_CMD_TYPE,
+			  CDNS_XSPI_ACMD_CMD_SECT_ERASE) |
+	       FIELD_PREP(CDNS_XSPI_ACMD_INT, 1) |
+	       FIELD_PREP(CDNS_XSPI_ACMD_BANK, cdns_xspi->cur_cs) |
+	       FIELD_PREP(CDNS_XSPI_ACMD_MODE, CDNS_XSPI_ACMD_MODE_PIO),
+	       cdns_xspi->iobase + CDNS_XSPI_CMD_REG_0);
+
+	wait_for_completion(&cdns_xspi->auto_cmd_complete);
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
+	struct spi_driver *spidrv = to_spi_driver(mem->spi->dev.driver);
+	enum spi_mem_data_dir dir = op->data.dir;
+
+	if (cdns_xspi->cur_cs != mem->spi->chip_select)
+		cdns_xspi->cur_cs = mem->spi->chip_select;
+
+	if (!strstr(spidrv->driver.name, "nor") ||
+	    (!op->addr.buswidth && !op->addr.nbytes && !op->addr.val)) {
+		return cdns_xspi_send_stig_command(cdns_xspi, op,
+						   (dir != SPI_MEM_NO_DATA));
+	} else {
+		if (dir == SPI_MEM_DATA_IN)
+			return cdns_xspi_nor_read(cdns_xspi, op->addr.val,
+						  op->data.nbytes,
+						  op->data.buf.in);
+		else if (dir == SPI_MEM_DATA_OUT)
+			return cdns_xspi_nor_write(cdns_xspi, op->addr.val,
+						   op->data.nbytes,
+						   op->data.buf.out);
+		else
+			return cdns_xspi_nor_erase(cdns_xspi, op->addr.val);
+	}
+}
+
+static int cdns_xspi_mem_op_execute(struct spi_mem *mem,
+				    const struct spi_mem_op *op)
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
+		       cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG);
+
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
+	struct cdns_xspi_platform_data *plat_data = pdev->dev.platform_data;
+	unsigned int property;
+	unsigned int cs;
+
+	if (of_property_read_u32(node_prop,
+				 "cdns,phy-data-select-oe-start", &property)) {
+		dev_err(&pdev->dev, "Couldn't get data select oe start\n");
+		return -ENXIO;
+	}
+	plat_data->phy_data_sel_oe_start = property;
+
+	if (of_property_read_u32(node_prop,
+				 "cdns,phy-data-select-oe-end", &property)) {
+		dev_err(&pdev->dev, "Couldn't get data select oe end\n");
+		return -ENXIO;
+	}
+	plat_data->phy_data_sel_oe_end = property;
+
+	if (of_property_read_u32(node_prop,
+				 "cdns,phy-dqs-select-oe-start", &property)) {
+		dev_err(&pdev->dev, "Couldn't get DQS select oe start\n");
+		return -ENXIO;
+	}
+	plat_data->phy_dqs_sel_oe_start = property;
+
+	if (of_property_read_u32(node_prop,
+				 "cdns,phy-dqs-select-oe-end", &property)) {
+		dev_err(&pdev->dev, "Couldn't get DQS select oe end\n");
+		return -ENXIO;
+	}
+	plat_data->phy_dqs_sel_oe_end = property;
+
+	if (of_property_read_u32(node_prop,
+				 "cdns,phy-gate-cfg-close", &property)) {
+		dev_err(&pdev->dev, "Couldn't get gate config close\n");
+		return -ENXIO;
+	}
+	plat_data->phy_gate_cfg_close = property;
+
+	if (of_property_read_u32(node_prop,
+				 "cdns,phy-gate-cfg", &property)) {
+		dev_err(&pdev->dev, "Couldn't get gate config\n");
+		return -ENXIO;
+	}
+	plat_data->phy_gate_cfg = property;
+
+	if (of_property_read_u32(node_prop,
+				 "cdns,phy-rd-del-select", &property)) {
+		dev_err(&pdev->dev, "Couldn't determine read delay select\n");
+		return -ENXIO;
+	}
+	plat_data->phy_rd_del_sel = property;
+
+	if (of_property_read_u32(node_prop,
+				 "cdns,phy-clk-wr-delay", &property)) {
+		dev_err(&pdev->dev, "Couldn't determine clock write delay\n");
+		return -ENXIO;
+	}
+	plat_data->clk_wr_delay = property;
+
+	plat_data->dqs_last_data_drop = of_property_read_bool(node_prop,
+						"cdns,dqs-last-data-drop");
+	plat_data->use_lpbk_dqs = of_property_read_bool(node_prop,
+					"cdns,phy-use-lpbk-dqs");
+	plat_data->use_ext_lpbk_dqs = of_property_read_bool(node_prop,
+					"cdns,phy-use-ext-lpbk-dqs");
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
+	struct cdns_xspi_platform_data *plat_data = NULL;
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
+	master->setup = cdns_xspi_setup;
+	master->dev.of_node = pdev->dev.of_node;
+	master->bus_num = -1;
+
+	platform_set_drvdata(pdev, master);
+
+	plat_data = devm_kmalloc(dev, sizeof(*plat_data), GFP_KERNEL);
+	if (!plat_data)
+		return -ENOMEM;
+
+	pdev->dev.platform_data = plat_data;
+
+	cdns_xspi = spi_master_get_devdata(master);
+	cdns_xspi->pdev = pdev;
+	cdns_xspi->dev = &pdev->dev;
+	cdns_xspi->cur_cs = 0;
+	cdns_xspi->plat_data = plat_data;
+
+	init_completion(&cdns_xspi->cmd_complete);
+	init_completion(&cdns_xspi->auto_cmd_complete);
+	init_completion(&cdns_xspi->sdma_complete);
+
+	ret = cdns_xspi_of_get_plat_data(pdev);
+	if (ret)
+		return -ENODEV;
+
+	cdns_xspi->iobase = devm_platform_ioremap_resource_byname(pdev,
+								  "xspi-iobase");
+	if (IS_ERR(cdns_xspi->iobase)) {
+		dev_err(dev, "Failed to remap controller base address\n");
+		return PTR_ERR(cdns_xspi->iobase);
+	}
+
+	cdns_xspi->sdmabase = devm_platform_ioremap_resource_byname(pdev,
+								    "xspi-sdmabase");
+	if (IS_ERR(cdns_xspi->sdmabase)) {
+		dev_err(dev, "Failed to remap SDMA address\n");
+		return PTR_ERR(cdns_xspi->sdmabase);
+	}
+
+	cdns_xspi->auxbase = devm_platform_ioremap_resource_byname(pdev,
+								   "xspi-auxbase");
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
+	ret = cdns_xspi_phy_init(cdns_xspi);
+	if (ret) {
+		dev_err(dev, "Failed to initialize PHY\n");
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
+MODULE_AUTHOR("Jayshri Pawar <jpawar@cadence.com>");
+MODULE_AUTHOR("Parshuram Thombare <pthombar@cadence.com>");
-- 
2.7.4

