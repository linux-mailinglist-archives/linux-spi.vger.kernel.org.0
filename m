Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D53D3FDB4E
	for <lists+linux-spi@lfdr.de>; Wed,  1 Sep 2021 15:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245674AbhIAMkp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 Sep 2021 08:40:45 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:44326 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343985AbhIAMiu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 1 Sep 2021 08:38:50 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18175OsW028426;
        Wed, 1 Sep 2021 05:37:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=TqMGn40yHmBP7K2X0BE43fIyqVaf0L3RwQlkhVF66nY=;
 b=i4U59SWTbuyTf5qCL7ga1cS4Bt9jvpL5umm/FeHohfVOg3buNDO0ghcXP/bx80TxBIQQ
 Q8CixpjOdBeR+u/V3dmAlivU/32yJQThK7rIJsOWwK3AiV1fJBTd5TfEK+DSpxv5QDCu
 7SF5M6XQFxuQVVmuhPk3TPWVKvgn55Dr3A53wI820FsQsQ/TbJwO2+SPCau4bcjsIWog
 7CB1NyRH2UbYaiJVQjLOZ/8AQRH9a3ddePYOE0uMRtOqmC5zpA3PN09btUIzk3sKludV
 hiY3JP/yxDPEbG2GIilqsV8g6H7XAxwokbzt0poyjYdjECHAkB7BKQiZua0/47xfzOOF AQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3asscrk0e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Sep 2021 05:37:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L54sLi/+txxpUHDVG/Nb0+G+LwxSEoxQLQoKpd/linnARxiHi4+uw0Y6gjAMnN7xSqS5Xl8qb0c7NB4bvk+tYueC+loifidUygF2HjWnDmKZrhbUlxsB4041o2hPXu2GNbi1alO47Z6iTGI6X/ZcTotOs3iVPGOSzpw7etRgKLp/odAikYC2eItUv2ZpI/w2K0W1gIMIk9RAdzBBit/DigD72z0o3j/g5+LFrKMOVi8t6mbMstgbKIax/9jLr5bRM7D1ZHY7Hh1bOIrhy1y8bNgYRQYVP2181f5D0xZ3VrprBhOolu99l/cRb9HICmWciSKsnMZqtb99CsQu8brIPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqMGn40yHmBP7K2X0BE43fIyqVaf0L3RwQlkhVF66nY=;
 b=hhjg2EbIVrx4S6vXZ2C4GDKY2UikaAh5j3GljNU+1RaGkufEZZAoyYRI3iSaU59Mk1GhqPLDtT2XZIF8g33ZcSF7g4eUI/FAJ5p67u3xGZOZIKcY+RebDub5WiWz4ZMIBz+hSbWYkHpEyAsaTUmBxc+1gxHQ5so4nVL85BhjzXW2VfvD0GW3U56X7LionGEMlFoDEvoML4KGMnqEvfiQRLIEweM5KPtpPftwb+Hw+rIz94HKiZWKz/KFEfITCFmM17EQrqlYBxqx1fzz/sNT1wTjHqxG3UlltibT4CuxXYu7HfwLxX4u0XgOFTNJ2SUhqtIdZhRmN2hsRaVz1zEgDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqMGn40yHmBP7K2X0BE43fIyqVaf0L3RwQlkhVF66nY=;
 b=nMecuUFf7AD9wI2bmKDuT4+0e70uFnsPHxraXhZH1xM+1GY9UWZyzp0JkOEVd1900ZJHTBqPYn4aDiAP4fYqx40kv599aTdn+QEGU5DYF69fEmuUnklqQFaEE1jaR549MMy/qScir1a3gbLgRJQ2VGkUbnNgQT4XzNR/pNlgz2Y=
Received: from DM6PR02CA0113.namprd02.prod.outlook.com (2603:10b6:5:1b4::15)
 by BYAPR07MB4438.namprd07.prod.outlook.com (2603:10b6:a02:bf::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Wed, 1 Sep
 2021 12:37:44 +0000
Received: from DM6NAM12FT016.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::bf) by DM6PR02CA0113.outlook.office365.com
 (2603:10b6:5:1b4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend
 Transport; Wed, 1 Sep 2021 12:37:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 DM6NAM12FT016.mail.protection.outlook.com (10.13.178.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.8 via Frontend Transport; Wed, 1 Sep 2021 12:37:43 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 181Cbfv1125365
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Wed, 1 Sep 2021 05:37:42 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 1 Sep 2021 14:37:40 +0200
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 1 Sep 2021 05:37:40 -0700
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 1 Sep 2021 14:37:40 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 181CbeRQ020493;
        Wed, 1 Sep 2021 14:37:40 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 181CbehB020492;
        Wed, 1 Sep 2021 14:37:40 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <broonie@kernel.org>, <lukas@wunner.de>, <p.yadav@ti.com>,
        <robh+dt@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jpawar@cadence.com>,
        <mparab@cadence.com>, Parshuram Thombare <pthombar@cadence.com>,
        Konrad Kociolek <konrad@cadence.com>
Subject: [PATCH v3 2/2] spi: cadence: add support for Cadence XSPI controller
Date:   Wed, 1 Sep 2021 14:37:38 +0200
Message-ID: <1630499858-20456-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1630499755-18751-1-git-send-email-pthombar@cadence.com>
References: <1630499755-18751-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88606e34-ff3b-446d-761e-08d96d454b5d
X-MS-TrafficTypeDiagnostic: BYAPR07MB4438:
X-Microsoft-Antispam-PRVS: <BYAPR07MB443848B89FE3B85F1499D2D9C1CD9@BYAPR07MB4438.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q+UW6NwG3lWsC8ciOn2oRdNfZtmOJ7LfK5mqEb5UK6W5947+6Nnqt5lTf6gQJk+18LBFzbWuoq/jnPtP5/G9wZzQuYJMXHlYdzHEWCJM0XmnpBJe6C9lhEfC8oJvCBaKAOQWexEVgCW5z2gpXdGLtmjdgeuCnRtFcRGtIP0dUn6dwq4/MLe7fmBd6/xztU/pG0Chv7aDYPGf1HnQ1RdxJ5zac3jUKtYfbs30pF5VWQHiYqJIQtbwEWhvF7nrdTv4Z8q2WQDLu/Zzx+rdoXmbDktfn1WLabpuKEcjgbnDgeotTbHZjFEhTmxfowHBchRjAhZyJFDGBx2txWX1gre+40eeXENJiAnsCFHyA5zNPylJynktLBZxd881aWQK/Jnj9dnXvm5p2qwEfJogpmZconObhaTSfmusG0f6c6Ifk6PP/i4+zMnsF+hEjjEZ14URfN2MlXv9bpxKNnsIFGhKEWeo16L/Xppt6dbBzrMP3v6Zl5TLixLdU4Zsw8HCCjjVIffPJuZKuGJDOA0a7p/U5N9gTrABZr3fCImApBUYzF/IvPDXpWcbC8ySnHkf5gEmm/uBGzkUrG3sdUrgdrMXVAhrvbS9Ym6cYlfJkOzbsaLITEB17FAOZqFTzf3n1pUguTNYFJkMteKf1k2ULxdROPlRxUfRgCy3BFvCYXVAtpKBFAAUlglk6+5OFQ4i1BoRVJRdpPYhuI3gBt1D49a58wSwwvhjk3sSwjLai7Geo6fN0N++EM2mGhsWuDVnSqQW4Xr7E7c2KodmuqjkLSZZwA==
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(36092001)(36840700001)(46966006)(186003)(8936002)(316002)(426003)(336012)(478600001)(42186006)(54906003)(82310400003)(83380400001)(356005)(81166007)(26005)(82740400003)(70586007)(107886003)(2616005)(30864003)(36756003)(4326008)(70206006)(8676002)(47076005)(110136005)(2906002)(86362001)(36860700001)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 12:37:43.3153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88606e34-ff3b-446d-761e-08d96d454b5d
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT016.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4438
X-Proofpoint-GUID: luHjujmCTe3UFzHrsZbi3yXZzMjmZvM4
X-Proofpoint-ORIG-GUID: luHjujmCTe3UFzHrsZbi3yXZzMjmZvM4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-01_04,2021-09-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2109010075
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
Currently ACMD PIO mode is used for NOR flash read, program, erase
operations, all other operations are handled in STIG work mode.

Signed-off-by: Konrad Kociolek <konrad@cadence.com>
Signed-off-by: Jayshri Pawar <jpawar@cadence.com>
Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
---
 drivers/spi/Kconfig            |  11 +
 drivers/spi/Makefile           |   1 +
 drivers/spi/spi-cadence-xspi.c | 837 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 849 insertions(+)
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
index 0000000..c2b33e2
--- /dev/null
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -0,0 +1,837 @@
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
+	ret = cdns_xspi_mem_op(cdns_xspi, mem, op);
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
+	master->setup = cdns_xspi_setup;
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

