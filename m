Return-Path: <linux-spi+bounces-4974-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD239860F0
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2024 16:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A29F71C26755
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2024 14:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C5C1B29CC;
	Wed, 25 Sep 2024 13:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iSYEss4E"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748971B29BC;
	Wed, 25 Sep 2024 13:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727271632; cv=fail; b=PadbTn8mOhjC26ErD1jeMTtvNvIE9oMxPa4xKPZo85VzAj4KqGaULXxfxJ0Yvuhrbmkaf6Xa/InKAyOsITkcLHARmmaic8qRcaG4tnEhMcqDNk7KbVrO/93JuMNrcilPg2u4CZPsbMxBC4baJYd1p7gHy5N8sJbBAaD6YoyJhGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727271632; c=relaxed/simple;
	bh=BPA9CHn0C6X7L6kxzcNKvfMD6fC1h3fRo0uRdKsv/+E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JCmp16ZRZzknTEQ98zl5aoqVpIzwoyq4uH5iwNw6FbHdhYvL+Kz0Lxe2oT0xllO23M/3tXQetVLm2kiahsVq+VZ8aba4w5YYn6t+A6WB3CorIr4ZJMdF26ThoDM/f+4eymf2DH9jflXZ0QEiSH89w4zmjZghcO/tdhBVGvQZU20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iSYEss4E; arc=fail smtp.client-ip=40.107.223.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lW7ai2MhAafzMD8Evz5YECS81pXt/bS9j/hx1qY6LjK+3VynKpJOZGzqLLqjBGxqJulq0e0+2UQWQqIh2tE3lQnh7UzwKop9KB2oJP4Dyy5D4vklOTN6FBD4V1WunsKVSkx7QrDkQknbK8JX+t3QCRvA38/vfhv3fjWdDwYpLVN3GVVhG0qQUbnsCLRt7n0Yziyty/69DrlcFhq4v+HhnZohbqSQCESePxFyIXJaVwrW4NnLEXRwMzX0Ut4mDw8i7GJ4zvtf3ypv1dAfKiiAtZePdb6ijE69yuEbV+GHVMKrhxPQw3RH4S4BVEE/irVZ5gXQ5MSKU80ow5pRbSZaZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UoB8fonxVrKxi1J80qLnO36TPR/ZpDnse3iqg2zOCsw=;
 b=AQFOk/SN/PKA493wuuTb3jsnkhIRHdIvduc23rRbuOVZTdyflCf0mOGD2d4J+tVTPV+07GKIpw4HnK78UUIia4VBd59tgroXHpdyX/1ZZK404nKyqMRKuWcRlh3LN46Bi49oKZBWEs0AzuNGppVj9FU7Bc0f7WSaL7+XLAgnCE0Q2jiGpypGGZii9IEtW32iUkg/MZpcC+rbygja4Tbto99KDHgy2YQ8tq7h2DMq3FzFjuv87RkPKqQ5lQ9Dcl2c8wkXWCeG58dM32BySFi6Kp6hEE9fc1296BCdiua8mdt3PlZ2fz6moaB6UlregO1o8ci4W18xAE15mt9UZ7ETuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UoB8fonxVrKxi1J80qLnO36TPR/ZpDnse3iqg2zOCsw=;
 b=iSYEss4EfYLaECVEd6jdSpVbMquXMgk1q+kTuYVCFtF5IR3d6JQ7XF7PSXe0OqmlbZQBS5h/IspntEr1VYJIfObh3WwEP2Fuapmz7fWZrM2Z3gy58adCYSUX7GinuLZpGgd3R64qk48u6awRWkttC3siHlIb1VsrgWxRKwCAR+I=
Received: from SA9P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::13)
 by SA3PR12MB9090.namprd12.prod.outlook.com (2603:10b6:806:397::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Wed, 25 Sep
 2024 13:40:25 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:26:cafe::ac) by SA9P223CA0008.outlook.office365.com
 (2603:10b6:806:26::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.30 via Frontend
 Transport; Wed, 25 Sep 2024 13:40:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Wed, 25 Sep 2024 13:40:25 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 08:40:22 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <sanju.mehta@amd.com>,
	<krishnamoorthi.m@amd.com>, <akshata.mukundshetty@amd.com>,
	<Raju.Rangoju@amd.com>
Subject: [PATCH V2 8/8] spi: spi_amd: Add HIDDMA basic read support
Date: Wed, 25 Sep 2024 19:06:44 +0530
Message-ID: <20240925133644.2922359-9-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240925133644.2922359-1-Raju.Rangoju@amd.com>
References: <20240925133644.2922359-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|SA3PR12MB9090:EE_
X-MS-Office365-Filtering-Correlation-Id: bd6e5ee7-ce00-4806-fe26-08dcdd679c38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ti/gFs9ykKY6+zxI6z6mQS6xFdPgUW6b2YSE4LLrBDsaYqFqoUO0AGc11H2d?=
 =?us-ascii?Q?hhjMKz2oq4ymgORqMpBpnHFu/0XDs0s/qmVIzae4B4Tmw0B6qyvRZwCUXG19?=
 =?us-ascii?Q?w4hWdq26EXhbZlpW/ej04nMDkqdNnvgvmJZhAGJV3lhRxMTrA/tjqiVA3s4r?=
 =?us-ascii?Q?FqwFg/fxtg1qBFU57oZbSmVW+2GsOHVrzjjrrNhO1g7tokr3S+y3VJAwwO0Z?=
 =?us-ascii?Q?fuFizGF3heHqB9SkV766fHQq6X00kQayvw7hcK1BLuIk6LMpQgcBNTJX+SGv?=
 =?us-ascii?Q?jZ4Sh/fvwJwv/hGxC2m8MsPKK9MdRNF12xkFay7Gm35Kq/ACXo1H6zXUWF85?=
 =?us-ascii?Q?R3u51x/fOhT6QxVNu3dvqL07A+xiqn/hOQYlZ92fgF07Fzoyzf2qH2/bRWYc?=
 =?us-ascii?Q?/feNa5/78vHLfiEiKeorliaEJAg7rVC7nIF2oBJeGqsQQvyQA2rm6BHlLZFW?=
 =?us-ascii?Q?zYoiFey+NFw8XXMQiihiM+Lxi4Rz7LiP2hDjTH/dbnHev/0mlphUKFgLUS3F?=
 =?us-ascii?Q?YftkG7kE4gSQ7ZSo5HKIVAe170Yyym045hIdoUItY7VXdlsMkWThs5HtIpQC?=
 =?us-ascii?Q?YIpqLJcY6j8LvMdxl87e7OjL4nlXixGw6HcZkpfmV9K1CIBTHNGWl84mRO0q?=
 =?us-ascii?Q?QtH3PIZL/SI2zfSYvY7g0/HoT13xf1ZefVM/Aqtk2lHicRAr955e/G84lpz/?=
 =?us-ascii?Q?Z2ciR5CO6yhPNsP7lu8di0Koq4qt/59UC35BQNyaEELU9MJdOGabVfNvFhtA?=
 =?us-ascii?Q?26nRq1mYgtkfoFAUz7RG+EsK8/d7/2YunJIO5ytp1cDsnjpwZJpLTu5bLCPe?=
 =?us-ascii?Q?8+RfCUyMmQsSPK2uWjbwvTJa1lszMUqoFowSNUcO2cVF+P6zVYFkq6VwzRw3?=
 =?us-ascii?Q?loUneRCHCDSzxde9CHKhmmaWVeKrXpD6HAFsbzJ6eiB5f6+O0XcakiaY8m3i?=
 =?us-ascii?Q?nDRQXCdda8kD+OqzoFPk7VrCepYiUz3lyznz++ukjb6IdL4fguGoe4NXJtb4?=
 =?us-ascii?Q?HNGxhC1IBWKeu6FLekfROXB3TQzp16mf/sbhlfwebC9utibGFPfpkGEcmMTX?=
 =?us-ascii?Q?FZ0vtbYeoClyjqlqpJv8c2bhBemxVS1CED9q+zWKBfdI4L/1+ZSykRCzAvd0?=
 =?us-ascii?Q?eGFBE+7CS5j9dcnOoTaRcFcOkLpHqr6SdVHYrYhDbY55TGitr/rDPxWlwg44?=
 =?us-ascii?Q?V4HEKbhIGocXohdGLLzyezdnTNdj0Go5QqWYtJKaVGW1APoG8XxafArxrcfK?=
 =?us-ascii?Q?5bi5a0KHB7+sw/gTIiFygAGgA3DsiH7yXTh8srUS+54Q3N1yukbTc+OHKMkq?=
 =?us-ascii?Q?d5VFow3beaaGlAwyA1AlqsL05Kebg7vyWC6ZVzpFgVLbf/Cw7nK5NS3lsMap?=
 =?us-ascii?Q?N8RyDBmL9g8QBlw2rxTc4j7n6+dfq3StFkpR6cfoaT/yTLXYHINIKylacsog?=
 =?us-ascii?Q?5ub/qWoiwO7Y8cDJ3BR+0ErVUwxtI5rt?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 13:40:25.1337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6e5ee7-ce00-4806-fe26-08dcdd679c38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9090

SPI index mode has hardware limitation of reading only 64 bytes per
transaction due to fixed number of FIFO registers. This constraint leads
to performance issues when reading data from NAND/NOR flash devices, as the
controller must issue multiple requests to read 64-byte chunks, even if the
slave can send up to 2 or 4 KB in single transaction. The AMD HID2 SPI
controller supports DMA mode, which allows reading up to 4 KB of data in
single transaction. This patch introduces changes to implement HID2 DMA
read support for the HID2 SPI controller.

Co-developed-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/spi/spi-amd.c | 176 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 156 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index 50dfdf2ab6ee..d30a21b0b05f 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -8,6 +8,7 @@
 
 #include <linux/acpi.h>
 #include <linux/delay.h>
+#include <linux/dma-mapping.h>
 #include <linux/init.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/iopoll.h>
@@ -50,9 +51,21 @@
 #define AMD_SPI_SPD7_SHIFT	8
 #define AMD_SPI_SPD7_MASK	GENMASK(13, AMD_SPI_SPD7_SHIFT)
 
+#define AMD_SPI_HID2_INPUT_RING_BUF0	0X100
+#define AMD_SPI_HID2_CNTRL		0x150
+#define AMD_SPI_HID2_INT_STATUS		0x154
+#define AMD_SPI_HID2_CMD_START		0x156
+#define AMD_SPI_HID2_INT_MASK		0x158
+#define AMD_SPI_HID2_READ_CNTRL0	0x170
+#define AMD_SPI_HID2_READ_CNTRL1	0x174
+#define AMD_SPI_HID2_READ_CNTRL2	0x180
+
 #define AMD_SPI_MAX_HZ		100000000
 #define AMD_SPI_MIN_HZ		800000
 
+#define AMD_SPI_IO_SLEEP_US	20
+#define AMD_SPI_IO_TIMEOUT_US	2000000
+
 /* SPI read command opcodes */
 #define AMD_SPI_OP_READ          0x03	/* Read data bytes (low frequency) */
 #define AMD_SPI_OP_READ_FAST     0x0b	/* Read data bytes (high frequency) */
@@ -108,11 +121,15 @@ struct amd_spi_freq {
 /**
  * struct amd_spi - SPI driver instance
  * @io_remap_addr:	Start address of the SPI controller registers
+ * @phy_dma_buf:	Physical address of DMA buffer
+ * @dma_virt_addr:	Virtual address of DMA buffer
  * @version:		SPI controller hardware version
  * @speed_hz:		Device frequency
  */
 struct amd_spi {
 	void __iomem *io_remap_addr;
+	dma_addr_t phy_dma_buf;
+	void *dma_virt_addr;
 	enum amd_spi_versions version;
 	unsigned int speed_hz;
 };
@@ -135,6 +152,16 @@ static void amd_spi_setclear_reg8(struct amd_spi *amd_spi, int idx, u8 set, u8 c
 	amd_spi_writereg8(amd_spi, idx, tmp);
 }
 
+static inline u16 amd_spi_readreg16(struct amd_spi *amd_spi, int idx)
+{
+	return readw((u8 __iomem *)amd_spi->io_remap_addr + idx);
+}
+
+static inline void amd_spi_writereg16(struct amd_spi *amd_spi, int idx, u16 val)
+{
+	writew(val, ((u8 __iomem *)amd_spi->io_remap_addr + idx));
+}
+
 static inline u32 amd_spi_readreg32(struct amd_spi *amd_spi, int idx)
 {
 	return readl((u8 __iomem *)amd_spi->io_remap_addr + idx);
@@ -517,6 +544,64 @@ static void amd_spi_mem_data_out(struct amd_spi *amd_spi,
 	amd_spi_execute_opcode(amd_spi);
 }
 
+static void amd_spi_hiddma_read(struct amd_spi *amd_spi, const struct spi_mem_op *op)
+{
+	u16 hid_cmd_start, val;
+	u32 hid_regval;
+
+	/* Set the opcode in hid2_read_control0 register */
+	hid_regval = amd_spi_readreg32(amd_spi, AMD_SPI_HID2_READ_CNTRL0);
+	hid_regval = (hid_regval & ~GENMASK(7, 0)) | op->cmd.opcode;
+
+	/*
+	 * Program the address in the hid2_read_control0 register [8:31]. The address should
+	 * be written starting from the 8th bit of the register, requiring an 8-bit shift.
+	 * Additionally, to convert a 2-byte spinand address to a 3-byte address, another
+	 * 8-bit shift is needed. Therefore, a total shift of 16 bits is required.
+	 */
+	hid_regval = (hid_regval & ~GENMASK(31, 8)) | (op->addr.val << 16);
+	amd_spi_writereg32(amd_spi, AMD_SPI_HID2_READ_CNTRL0, hid_regval);
+
+	/* Configure dummy clock cycles for fast read, dual, quad I/O commands */
+	hid_regval = amd_spi_readreg32(amd_spi, AMD_SPI_HID2_READ_CNTRL2);
+	/* Fast read dummy cycle */
+	hid_regval &= ~GENMASK(4, 0);
+
+	/* Fast read Dual I/O dummy cycle */
+	hid_regval &= ~GENMASK(12, 8);
+
+	/* Fast read Quad I/O dummy cycle */
+	hid_regval = (hid_regval & ~GENMASK(20, 16)) | BIT(17);
+
+	/* Set no of preamble bytecount */
+	hid_regval &= ~GENMASK(27, 24);
+	amd_spi_writereg32(amd_spi, AMD_SPI_HID2_READ_CNTRL2, hid_regval);
+
+	/*
+	 * Program the HID2 Input Ring Buffer0. 4k aligned buf_memory_addr[31:12],
+	 * buf_size[4:0], end_input_ring[5].
+	 */
+	hid_regval = amd_spi->phy_dma_buf | BIT(5) | BIT(0);
+	amd_spi_writereg32(amd_spi, AMD_SPI_HID2_INPUT_RING_BUF0, hid_regval);
+
+	/* Program max read length(no of DWs) in hid2_read_control1 register */
+	hid_regval = amd_spi_readreg32(amd_spi, AMD_SPI_HID2_READ_CNTRL1);
+	hid_regval = (hid_regval & ~GENMASK(15, 0)) | ((op->data.nbytes / 4) - 1);
+	amd_spi_writereg32(amd_spi, AMD_SPI_HID2_READ_CNTRL1, hid_regval);
+
+	/* Set cmd start bit in hid2_cmd_start register to trigger HID basic read operation */
+	hid_cmd_start = amd_spi_readreg16(amd_spi, AMD_SPI_HID2_CMD_START);
+	amd_spi_writereg16(amd_spi, AMD_SPI_HID2_CMD_START, (hid_cmd_start | BIT(3)));
+
+	/* Check interrupt status of HIDDMA basic read operation in hid2_int_status register */
+	readw_poll_timeout(amd_spi->io_remap_addr + AMD_SPI_HID2_INT_STATUS, val,
+			   (val & BIT(3)), AMD_SPI_IO_SLEEP_US, AMD_SPI_IO_TIMEOUT_US);
+
+	/* Clear the interrupts by writing to hid2_int_status register */
+	val = amd_spi_readreg16(amd_spi, AMD_SPI_HID2_INT_STATUS);
+	amd_spi_writereg16(amd_spi, AMD_SPI_HID2_INT_STATUS, val);
+}
+
 static void amd_spi_mem_data_in(struct amd_spi *amd_spi,
 				const struct spi_mem_op *op)
 {
@@ -524,29 +609,52 @@ static void amd_spi_mem_data_in(struct amd_spi *amd_spi,
 	u64 *buf_64 = (u64 *)op->data.buf.in;
 	u32 nbytes = op->data.nbytes;
 	u32 left_data = nbytes;
+	u32 data;
 	u8 *buf;
 	int i;
 
-	amd_spi_set_opcode(amd_spi, op->cmd.opcode);
-	amd_spi_set_addr(amd_spi, op);
-	amd_spi_set_tx_count(amd_spi, op->addr.nbytes + op->dummy.nbytes);
-
-	for (i = 0; i < op->dummy.nbytes; i++)
-		amd_spi_writereg8(amd_spi, (base_addr + i), 0xff);
-
-	amd_spi_set_rx_count(amd_spi, op->data.nbytes);
-	amd_spi_clear_fifo_ptr(amd_spi);
-	amd_spi_execute_opcode(amd_spi);
-	amd_spi_busy_wait(amd_spi);
-
-	for (i = 0; left_data >= 8; i++, left_data -= 8)
-		*buf_64++ = amd_spi_readreg64(amd_spi, base_addr + op->dummy.nbytes +
-					      (i * 8));
+	/*
+	 * Condition for using HID read mode. Only for reading complete page data, use HID read.
+	 * Use index mode otherwise.
+	 */
+	if (amd_spi->version == AMD_HID2_SPI && amd_is_spi_read_cmd(op->cmd.opcode)) {
+		amd_spi_hiddma_read(amd_spi, op);
+
+		for (i = 0; left_data >= 8; i++, left_data -= 8)
+			*buf_64++ = readq((u8 __iomem *)amd_spi->dma_virt_addr + (i * 8));
+
+		buf = (u8 *)buf_64;
+		for (i = 0; i < left_data; i++)
+			buf[i] = readb((u8 __iomem *)amd_spi->dma_virt_addr +
+				       (nbytes - left_data + i));
+
+		/* Reset HID RX memory logic */
+		data = amd_spi_readreg32(amd_spi, AMD_SPI_HID2_CNTRL);
+		amd_spi_writereg32(amd_spi, AMD_SPI_HID2_CNTRL, data | BIT(5));
+	} else {
+		/* Index mode */
+		amd_spi_set_opcode(amd_spi, op->cmd.opcode);
+		amd_spi_set_addr(amd_spi, op);
+		amd_spi_set_tx_count(amd_spi, op->addr.nbytes + op->dummy.nbytes);
+
+		for (i = 0; i < op->dummy.nbytes; i++)
+			amd_spi_writereg8(amd_spi, (base_addr + i), 0xff);
+
+		amd_spi_set_rx_count(amd_spi, op->data.nbytes);
+		amd_spi_clear_fifo_ptr(amd_spi);
+		amd_spi_execute_opcode(amd_spi);
+		amd_spi_busy_wait(amd_spi);
+
+		for (i = 0; left_data >= 8; i++, left_data -= 8)
+			*buf_64++ = amd_spi_readreg64(amd_spi, base_addr + op->dummy.nbytes +
+						      (i * 8));
+
+		buf = (u8 *)buf_64;
+		for (i = 0; i < left_data; i++)
+			buf[i] = amd_spi_readreg8(amd_spi, base_addr + op->dummy.nbytes +
+						  nbytes + i - left_data);
+	}
 
-	buf = (u8 *)buf_64;
-	for (i = 0; i < left_data; i++)
-		buf[i] = amd_spi_readreg8(amd_spi, base_addr + op->dummy.nbytes +
-					  nbytes + i - left_data);
 }
 
 static void amd_set_spi_addr_mode(struct amd_spi *amd_spi,
@@ -617,6 +725,31 @@ static size_t amd_spi_max_transfer_size(struct spi_device *spi)
 	return AMD_SPI_FIFO_SIZE;
 }
 
+static int amd_spi_setup_hiddma(struct amd_spi *amd_spi, struct device *dev)
+{
+	u32 hid_regval;
+
+	/* Allocate DMA buffer to use for HID basic read operation */
+	amd_spi->dma_virt_addr = dma_alloc_coherent(dev, AMD_SPI_HID2_DMA_SIZE,
+						    &amd_spi->phy_dma_buf, GFP_KERNEL);
+	if (!amd_spi->dma_virt_addr)
+		return -ENOMEM;
+
+	/*
+	 * Enable interrupts and set mask bits in hid2_int_mask register to generate interrupt
+	 * properly for HIDDMA basic read operations.
+	 */
+	hid_regval = amd_spi_readreg32(amd_spi, AMD_SPI_HID2_INT_MASK);
+	hid_regval = (hid_regval & GENMASK(31, 8)) | BIT(19);
+	amd_spi_writereg32(amd_spi, AMD_SPI_HID2_INT_MASK, hid_regval);
+
+	/* Configure buffer unit(4k) in hid2_control register */
+	hid_regval = amd_spi_readreg32(amd_spi, AMD_SPI_HID2_CNTRL);
+	amd_spi_writereg32(amd_spi, AMD_SPI_HID2_CNTRL, hid_regval & ~BIT(3));
+
+	return 0;
+}
+
 static int amd_spi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -657,7 +790,10 @@ static int amd_spi_probe(struct platform_device *pdev)
 	if (err)
 		return dev_err_probe(dev, err, "error registering SPI controller\n");
 
-	return 0;
+	if (amd_spi->version == AMD_HID2_SPI)
+		err = amd_spi_setup_hiddma(amd_spi, dev);
+
+	return err;
 }
 
 #ifdef CONFIG_ACPI
-- 
2.34.1


