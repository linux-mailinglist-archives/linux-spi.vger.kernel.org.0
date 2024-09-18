Return-Path: <linux-spi+bounces-4853-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 610F997BB41
	for <lists+linux-spi@lfdr.de>; Wed, 18 Sep 2024 13:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E12961F21599
	for <lists+linux-spi@lfdr.de>; Wed, 18 Sep 2024 11:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9881741EF;
	Wed, 18 Sep 2024 11:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3/2eglVA"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96CA291E;
	Wed, 18 Sep 2024 11:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726657338; cv=fail; b=T8Kt/5AKeF4obAjlM9/riJKXmpIzEAyRMUEV0kPV35w1y1Cq29Fy0ZXno6wsYwQ6tBMYqsVoWzm6marx2xusok7XIS2ELhQ0jAQvWoUo/e/MM6QG+JUzgOF1zlfQb4X1QWqYy9Wkn9I7u8LyyrQXil9kaLfyFzGWo36Tg3+yvwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726657338; c=relaxed/simple;
	bh=BPA9CHn0C6X7L6kxzcNKvfMD6fC1h3fRo0uRdKsv/+E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=egpJ0hMLlYGOUfIZbJdDJiBCvEDyJLcNz+SAhxY0xQLOMhsqhPDtLcEXPdnJyGlCOxOSrETa/MsLkMQn9c2AVnWZq8Uap24mSZ5ig3oghErawY7DtY8fMOag7Lqdy4dimJiwe9jZJo/LS2RCb0oz/8T3p9gLmab3Ta0tuaZitL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3/2eglVA; arc=fail smtp.client-ip=40.107.236.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nlW6Ch/dgHshkKnzQ4c/wwhi4HYjOwryz5SqsXBpHkXGF6R8OUVlwhnTw8U2Lt8eax6BsnvoqJWFpjH+dnHYqL7yUZY8UeP29m1Z7EX1VIJSmy06eppQKV5+NCsH1lqzk3XQZ608pvF7HWCbsb2wnfcjtgmtk8/2Umcsq5t15O5kPrf+E/Xvo7FcYQtEC6pZqsQoA/pXFOhNakBuimKVALG0Npz8FFBwMBX70kwm1W5n9VwKepEi41hpJof1yfqKcYUckKPxufQyoGwVhrvwVU39u6LHLeOPBsgAhLz3dID3hJ2i7gTgHCOU12+QYIzpH60hUC3jp7vYXuZTwTCBNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UoB8fonxVrKxi1J80qLnO36TPR/ZpDnse3iqg2zOCsw=;
 b=oDpZIhv9IhtqQh7JJ4ePneAenQd5r00jPxsPk8/maxJUPMV2xElQCQXBW9cJjGp1PkaCsCxphhtU72bYZ6m7OkZUip5YWgRq+QGGcLPegB2AZ+xFpIsjHyK23NpWEfsndCr6JOHOF1FVeWxxzKTnWTsSSFakEtlxKzGZt99Lr5d6qM8zOw7kvjHfG4EiUZIjIWfygFwRBcsay4pI4pdiHlnNonMmjnTDe0BLZgTVpj2d21d0YcIaNWO2+ppzebthaiAYyCadA/ovVuB0r7ecE55XAnt8T7I7C4HQTF3Ty+A1srRnnO1mrIu9YD0wbJLTrkYdNFvxzYYr+B6v9TUslA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UoB8fonxVrKxi1J80qLnO36TPR/ZpDnse3iqg2zOCsw=;
 b=3/2eglVAo8CxsvrEg2rdC+pDaH/tdGEZPsB+afO0+YvlZz06dh7P5VzkAkMUjpy1fys+eUt5nYjzmgk8zfx9XIdAS7HLyPvRmYHcPU4ffvIU59BUNBlyCHOr4MEhZ0TNknvyiEmVZn7dmK9bnsSxZfi7/hqs3u1RCzO4No6AYK4=
Received: from MN0PR02CA0027.namprd02.prod.outlook.com (2603:10b6:208:530::30)
 by MW4PR12MB5643.namprd12.prod.outlook.com (2603:10b6:303:188::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Wed, 18 Sep
 2024 11:02:11 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:530:cafe::bb) by MN0PR02CA0027.outlook.office365.com
 (2603:10b6:208:530::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Wed, 18 Sep 2024 11:02:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 18 Sep 2024 11:02:10 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Sep
 2024 06:00:19 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <sanju.mehta@amd.com>,
	<krishnamoorthi.m@amd.com>, <akshata.mukundshetty@amd.com>,
	<Raju.Rangoju@amd.com>
Subject: [PATCH 9/9] spi: spi_amd: Add HIDDMA basic read support
Date: Wed, 18 Sep 2024 16:20:37 +0530
Message-ID: <20240918105037.406003-10-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240918105037.406003-1-Raju.Rangoju@amd.com>
References: <20240918105037.406003-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|MW4PR12MB5643:EE_
X-MS-Office365-Filtering-Correlation-Id: 53e5cc4d-3fe1-4136-958f-08dcd7d15847
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8o2f/nhU6zcZa99h6KYWNIfsRXXuJmofSNycPzbJ8Nhe2/myTl02j1RPBoNq?=
 =?us-ascii?Q?7jZoPeloJZCRVJsOnhO7lxe4SIVk0/5pXAl/roZ8YUhVnmbNBMyTLZ6xf/Pw?=
 =?us-ascii?Q?7q8evQ3QMvkjwPnC47qOmJVqQB7xvC2GcDGLWCbQ19YQyenq2X3ps9Khvzjv?=
 =?us-ascii?Q?rI3BGlz3NtJnJPnMBmcCqQPh+pyEvCTiPEELVNMH5Q45icvw6JvUQY2q2QHV?=
 =?us-ascii?Q?8Le06TXo5PbjFGlKA5sN34L7tlImbkCPQaQAymgUpqg/DAGwAyJIsvfdI2dZ?=
 =?us-ascii?Q?x3pX7QxCy8UTAuzPOhdBwa1y3UkztoRyUIwrpBGkZzK7KpZp8Nqbe+EGX2wp?=
 =?us-ascii?Q?OfI5LoTcIRHn2LpA94DQylNK7XDAkceBBsOtPhCDJ/lc7twVCAnvo850q5xq?=
 =?us-ascii?Q?Bdg0OFdXfOLamL8kZINKWXDtP7uJonO9EwOFdRe/ykD1vlAyWUsStgms9lwK?=
 =?us-ascii?Q?yrdpEFujTuTq936X0diBir7Wnv8qJcel98pc5cbq/790GwdlZ/uv30VfriwJ?=
 =?us-ascii?Q?Ir4Y4Ccy+8il+x87rqd5ve49x91ukZNlVsaKTC9TAbcdFww+Gy2QJXiUQArM?=
 =?us-ascii?Q?1GI7rQRC868fzgYaFa5PAEnmuX5cnrCxtRdxAq4fbq/5ueh+3WnW1ye/fQOX?=
 =?us-ascii?Q?TSSf0RvkjoYbiCZtFeHXvhHBqO1xiAH7XGiaiX5wmutNtbYleKQAExKiIREi?=
 =?us-ascii?Q?4aBQ1lvNVFgzCx78LNXCCIdpN0iMF/mzPAx+ucRUdUA/D6wUP4B9tZ/rrCJn?=
 =?us-ascii?Q?n3bBXtzLIbbRv3gdedelO98FmyC0zQu5WbG6OWnCgRCAaB9DEgeIgBTHeTM+?=
 =?us-ascii?Q?j+pPrYrXeYzjn8YO1OPKKT/zfmjviZfmTXaXxOOj5e70Jdmdqk7rCmKJv+pU?=
 =?us-ascii?Q?vb9zKv4e/wLeP4yazy73DjBHNt5m23a+IQBmklKWAJbkx5nOUY4bQus6qYrd?=
 =?us-ascii?Q?NzUbTabD+4VKMrgqRdG+rkiCpgKs5N4lZCQwrxPhf48ycRzy8CdUReUyzxrf?=
 =?us-ascii?Q?b6yKjJDCotiFiC6MfhrGNf5vmTdyo1HTtzQ7Oc2wMyTE4NeFym6yGlHJdUfo?=
 =?us-ascii?Q?Ut3jDQqsgt5JNpCRzNf3GfKpda5FamwMbIfSJYzE73m3vkn6w3WKmZZuetZ1?=
 =?us-ascii?Q?DOX6ZfjVB4h3to4s/ooaZpeHRT/affyDCdA0yzkTdKGtQWXuQWThvrISa5WW?=
 =?us-ascii?Q?AKOIbO4aKsg24vLyEF2lpeBdNuPlpTaUMWcMvdLKQChr+KxJW6pj0H6tV/wx?=
 =?us-ascii?Q?+7DFUiCaDzO6Fs9KmsDm7/Cwwro3r/pDH0+iSEzkPTaZrL+Gspye7DRawCjD?=
 =?us-ascii?Q?rGdYWpYJ9ufnQqz/LXdy5Cr835m95kZZr4mjwyYchOlVqKg/fbKXi8p1tmF1?=
 =?us-ascii?Q?5w3If+kkyR58THTG9GL0RMbCvPu5s19kdwo0+ga9PQvFGiZIoH41mT+hL168?=
 =?us-ascii?Q?BS7FjIIw4XSxKvu47QyGDoj0yNyOVG/y?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 11:02:10.7896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e5cc4d-3fe1-4136-958f-08dcd7d15847
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5643

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


