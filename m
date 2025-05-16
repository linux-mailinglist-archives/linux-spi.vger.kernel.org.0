Return-Path: <linux-spi+bounces-8150-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B68AB99BA
	for <lists+linux-spi@lfdr.de>; Fri, 16 May 2025 12:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E2AD1BA09D2
	for <lists+linux-spi@lfdr.de>; Fri, 16 May 2025 10:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BC32222D1;
	Fri, 16 May 2025 10:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LdbwNIar"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01913233127;
	Fri, 16 May 2025 10:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747390063; cv=fail; b=W8gSBpjEdVXYx+GwG16cMUrMPvkeBULZqeTl/WWVnIIEZur4CL7WpioeeETDV0sANTnku6GR+hryrEoUNbNQz1sWSVdmgZm7GJzg/8JVg9tlugayUmCQbiRSMi6M7N39TYrO7GXNNH51P67l3nMQGi9fHcNYYk4sTljHGQbUbwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747390063; c=relaxed/simple;
	bh=sO3hedB1Vmzwi6MpD8xmNxcGsyRcsYgQB9+CZHAOq84=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DS9L0TUKC4NL0NGO0GUr3u3Ndi7OEBKGJ9N90KIuAb7AynBcaAQz2/HFx8/dNaNfVZp7ykGZZpqjzXQ1+Y4CTVcNgrhRo6ktnuIWrNMZ/O747FadDJP2OYPcb3z1RXLq+Ypg0O4XJzE24yshPUf5zmf2SI33gLaCZaqIWyZBX/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LdbwNIar; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OGffjSB3Mewtop+PxbkrYK7WYP1/7huww1w9mxra4XxMBcZoJRZKhh++9BFY5S5ocHvU7tOonMaS5frbfx+eVwtf4j72gn+tDqRJgfbc2c3LDxpEtQStmTaKwrSY7zfhPv6am9+MVf8Nu9si0xe8Dh2mIw3G9vVACfd1m/kn9gJDPusXKrMhWC6mIEpHLXD1Z0VcPLDNEmBSBAx3xVhZ7EB1+vpz4P9G4oHkJfhVIXAKyAl3elQldgHP9Mk/hSHvVVzcldmvrpG6vNgSNrm6eSPUfNoUr3vd4SLKwTuiC4UiWOPcqogkwVqBM9yAZ5JiermnMBfrxXc0nfKr9UjQGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QdJYZQ019uNI2HUnOEskattvJ3SLr8KdfhuRojqcy+4=;
 b=gD6WVtFCMexeONIdRjbIZ9y4np0jbqHQXMBrddkWEyP7bd6o3sfHeEYwvM/smjoh9Csz9FsLs0XD6yHGfEac+qa2ua7hXUXOIRSS0l/UcpSBi7culrio3pDxRWz4I5E9xH+nsAh+jR0M1Lwg4bRUB/fxPetNyWb8iS9k8gwdjZKwERFQI3MWrxWH9BPykufb5Weftd928evS9hLOzgp2lpLbwisod9oP1QibjFAv92WdBb9h0k4kwcrCw3bIyad6RPQPFZSpf7HLOxagVvE00sLBAw/gTSFk1Id/SJWRm5gOgLWVg6Z5QptT7Wy1o4mI5jmSJr75k1P0kQHEg1+2mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QdJYZQ019uNI2HUnOEskattvJ3SLr8KdfhuRojqcy+4=;
 b=LdbwNIargzVF65se6t1d8Sgf44pSbupaIdgKqE8LWA7MJ1hu5kKWCL2JhWMov+9lcPxaeQkjZ9W9uTCCd2k8r2CDQqtw6uXnuVKl9j3APNBkQ3SbQWYUBT401h41wdnN/TkSxbhy4oBa6sqLEMfoZwPGQuA+mHTBGUDiVjLfzGo=
Received: from PH8P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::30)
 by CH1PR12MB9574.namprd12.prod.outlook.com (2603:10b6:610:2ae::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 10:07:38 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:510:2d8:cafe::ba) by PH8P221CA0024.outlook.office365.com
 (2603:10b6:510:2d8::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.20 via Frontend Transport; Fri,
 16 May 2025 10:07:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Fri, 16 May 2025 10:07:37 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 May
 2025 05:07:35 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<krishnamoorthi.m@amd.com>, <akshata.mukundshetty@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH v2 2/3] spi: spi_amd: Add HIDDMA basic write support
Date: Fri, 16 May 2025 15:36:57 +0530
Message-ID: <20250516100658.585654-3-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250516100658.585654-1-Raju.Rangoju@amd.com>
References: <20250516100658.585654-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|CH1PR12MB9574:EE_
X-MS-Office365-Filtering-Correlation-Id: d9f66ab2-9bbe-4768-1c3e-08dd94617c79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hovxbHVCwnaVVh7OfzKu6HIr0SkAtYcC/PZdRHU67WQLIIaojlhjKpfbr/hJ?=
 =?us-ascii?Q?dh4a+1ZlTNywW8PM/Z1kCSOrT7YXOXfR1fo8kfKYViLcd7JG1aT2ApT54NFc?=
 =?us-ascii?Q?uy/YutQ320LodbAkRA5T4UQPN+ufZgi86/xT7L4RA3qyS1mIZIO1gKnWLiss?=
 =?us-ascii?Q?K2Akgn5lvkTbHTa4DCPF2E3WzZVf/lIZByrq+O9K0WjyfoJVjou4BeQ0I5N0?=
 =?us-ascii?Q?Rl4VPEB/y2u8qWflLf0YKiPDA+JpoFfFGZxzetNfptMoESSaD61Jt6J3EG7W?=
 =?us-ascii?Q?Gu3JjDTQn6D5nyHYqTQbIKKmxcrtPfI6qIqmKeB5e+qDFq/OZUcPLss9T3Ep?=
 =?us-ascii?Q?wLxNOUy5Y9xAtqxLeNLSxqmrSyJ3k/Kwovc8VDvLUZq6BknjL74uh37CstfE?=
 =?us-ascii?Q?SbBDXoJF5IcGiv8dEI2k+mLSHJ0PKlHtZ66zHxSodIHVfUIy3reaxGYExmGh?=
 =?us-ascii?Q?G2mKeduqZJSvI/B7BLQg3b/kOuD8Rdq2XuNMiz+VyiMWt7QjjpPeyGEKWJCA?=
 =?us-ascii?Q?1HhiXBr114/tWE3Cmyo2OkeLNdHvzsektKyOldpHECtLoOb10cQ7km3wSBJe?=
 =?us-ascii?Q?0ZPuehBsrZ+SiojbLO8Xh4NkXw8D+Hnz/cEb8eYEGqCVs8e4TbW96ex4szoy?=
 =?us-ascii?Q?6HD/Q4wr3j1lXzC4RfuTYQVPgxswhEwaqwv9kASlcnjsVXJgWZHMvq4ZmRE/?=
 =?us-ascii?Q?7RcLgG1ygmzDts1mmdQ+oW4J6B/04Sd7C2oModiyROgH9glhUSp3LRdsm/ve?=
 =?us-ascii?Q?1tMJh//VeUNVMdrjkTXiohkDQihwoGhWymyOXkfi7P4ubhOhZJVrvzSa1VcO?=
 =?us-ascii?Q?EbSqmToUR9HHwyySPo/EjWdB8f6fDccb/bgj5MOym4DW8DqnsUpOc5YESPhU?=
 =?us-ascii?Q?HI3BFTQXlWwwE3A0EGlplWFroBgjOcIQWPz7F/LF8E/j78WzZAka6L477b+I?=
 =?us-ascii?Q?klHdGpO/NvBm3pGUT+5NSD9jdElFKKGi68csY4kwwbdMl80AUBhle5EU2at0?=
 =?us-ascii?Q?GC5kT0O+Db+gdQd4BNlHTwCmpC9T9hkApTVaOzQg99g8cpd5N57n0WjopBeV?=
 =?us-ascii?Q?bXePIdTrkMrVOcPp+GJgeVWW7bTIHkZlL8eIFTFU8PY7zHNTpcgnebn3J5Fh?=
 =?us-ascii?Q?YRoN2iQ7ggDSN+KiSE03KRRQ1g46kwjqCs+zilKc+Sm1CxxDlUGIV8uDK8ww?=
 =?us-ascii?Q?UM/5SMYyDnJqK4jUSUkB3WCtqJhqHjDdtaVmTKsmF8XKQ7crSttiGYWS/ev3?=
 =?us-ascii?Q?gj6k/RxKpoMxPZ4ulGK6yw+V7BGK2wHGKTqfkHezTlPUc4PMOEGcN2lmLZvz?=
 =?us-ascii?Q?iGdW8qjD+VuBtUkx+irjwFJUy4U9PX1wq4NubMvahkNW/T/AuH+bpYM94u8P?=
 =?us-ascii?Q?0GgW3po2LQIoPcco50L0tpyPmc1fXbK0jlITBiwcKJCBVTIcfrC1gESRhGI3?=
 =?us-ascii?Q?Ys+PGiCQOp5KeeJWseXLanwTg7MDo98zar3ZhoBa8rT7rI4h4/JKs6VKqX9S?=
 =?us-ascii?Q?tPfhIXrIA6TX4nC1RWHbEbSiIUXJQ71pRqjK?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 10:07:37.6268
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f66ab2-9bbe-4768-1c3e-08dd94617c79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9574

SPI index mode has hardware limitation of transferring only 64 bytes per
transaction due to fixed number of FIFO registers. This constraint leads to
performance issues when reading/writing data to/from NAND/NOR flash
devices, as the controller must issue multiple requests to read/write
64-byte chunks, even if the slave can transfer up to 2 or 4 KB in a single
transaction.

The AMD HID2 SPI controller supports DMA mode, allowing for reading/writing
up to 4 KB of data in a single transaction. The existing spi_amd driver
already supports HID2 DMA read operations.

This patch introduces changes to implement HID2 DMA single mode basic write
support for the HID2 SPI controller.

Co-developed-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/spi/spi-amd.c | 135 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 112 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index 52d893d41b12..02e7fe095a0b 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -54,10 +54,13 @@
 #define AMD_SPI_SPD7_MASK	GENMASK(13, AMD_SPI_SPD7_SHIFT)
 
 #define AMD_SPI_HID2_INPUT_RING_BUF0	0X100
+#define AMD_SPI_HID2_OUTPUT_BUF0	0x140
 #define AMD_SPI_HID2_CNTRL		0x150
 #define AMD_SPI_HID2_INT_STATUS		0x154
 #define AMD_SPI_HID2_CMD_START		0x156
 #define AMD_SPI_HID2_INT_MASK		0x158
+#define AMD_SPI_HID2_WRITE_CNTRL0	0x160
+#define AMD_SPI_HID2_WRITE_CNTRL1	0x164
 #define AMD_SPI_HID2_READ_CNTRL0	0x170
 #define AMD_SPI_HID2_READ_CNTRL1	0x174
 #define AMD_SPI_HID2_READ_CNTRL2	0x180
@@ -83,6 +86,10 @@
 #define AMD_SPI_OP_READ_1_1_4_4B	0x6c    /* Read data bytes (Quad Output SPI) */
 #define AMD_SPI_OP_READ_1_4_4_4B	0xec    /* Read data bytes (Quad I/O SPI) */
 
+/* SPINAND write command opcodes */
+#define AMD_SPI_OP_PP			0x02	/* Page program */
+#define AMD_SPI_OP_PP_RANDOM		0x84	/* Page program */
+
 enum amd_spi_speed {
 	F_66_66MHz,
 	F_33_33MHz,
@@ -419,6 +426,17 @@ static inline bool amd_is_spi_read_cmd(const u16 op)
 	}
 }
 
+static inline bool amd_is_spi_write_cmd(const u16 op)
+{
+	switch (op) {
+	case AMD_SPI_OP_PP:
+	case AMD_SPI_OP_PP_RANDOM:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static bool amd_spi_supports_op(struct spi_mem *mem,
 				const struct spi_mem_op *op)
 {
@@ -429,7 +447,7 @@ static bool amd_spi_supports_op(struct spi_mem *mem,
 		return false;
 
 	/* AMD SPI controllers support quad mode only for read operations */
-	if (amd_is_spi_read_cmd(op->cmd.opcode)) {
+	if (amd_is_spi_read_cmd(op->cmd.opcode) || amd_is_spi_write_cmd(op->cmd.opcode)) {
 		if (op->data.buswidth > 4)
 			return false;
 
@@ -438,7 +456,8 @@ static bool amd_spi_supports_op(struct spi_mem *mem,
 		 * doesn't support 4-byte address commands.
 		 */
 		if (amd_spi->version == AMD_HID2_SPI) {
-			if (amd_is_spi_read_cmd_4b(op->cmd.opcode) ||
+			if ((amd_is_spi_read_cmd_4b(op->cmd.opcode) ||
+			     amd_is_spi_write_cmd(op->cmd.opcode)) &&
 			    op->data.nbytes > AMD_SPI_HID2_DMA_SIZE)
 				return false;
 		} else if (op->data.nbytes > AMD_SPI_MAX_DATA) {
@@ -464,7 +483,8 @@ static int amd_spi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 	 * controller index mode supports maximum of 64 bytes in a single
 	 * transaction.
 	 */
-	if (amd_spi->version == AMD_HID2_SPI && amd_is_spi_read_cmd(op->cmd.opcode))
+	if (amd_spi->version == AMD_HID2_SPI && (amd_is_spi_read_cmd(op->cmd.opcode) ||
+						 amd_is_spi_write_cmd(op->cmd.opcode)))
 		op->data.nbytes = clamp_val(op->data.nbytes, 0, AMD_SPI_HID2_DMA_SIZE);
 	else
 		op->data.nbytes = clamp_val(op->data.nbytes, 0, AMD_SPI_MAX_DATA);
@@ -488,32 +508,96 @@ static void amd_spi_set_addr(struct amd_spi *amd_spi,
 	}
 }
 
+static void amd_spi_hiddma_write(struct amd_spi *amd_spi, const struct spi_mem_op *op)
+{
+	u16 hid_cmd_start, val;
+	u32 hid_regval;
+
+	/*
+	 * Program the HID2 output Buffer0. 4k aligned buf_memory_addr[31:12],
+	 * buf_size[2:0].
+	 */
+	hid_regval = amd_spi->phy_dma_buf | BIT(0);
+	amd_spi_writereg32(amd_spi, AMD_SPI_HID2_OUTPUT_BUF0, hid_regval);
+
+	/* Program max write length in hid2_write_control1 register */
+	hid_regval = amd_spi_readreg32(amd_spi, AMD_SPI_HID2_WRITE_CNTRL1);
+	hid_regval = (hid_regval & ~GENMASK(15, 0)) | ((op->data.nbytes) + 3);
+	amd_spi_writereg32(amd_spi, AMD_SPI_HID2_WRITE_CNTRL1, hid_regval);
+
+	/* Set cmd start bit in hid2_cmd_start register to trigger HID basic write operation */
+	hid_cmd_start = amd_spi_readreg16(amd_spi, AMD_SPI_HID2_CMD_START);
+	amd_spi_writereg16(amd_spi, AMD_SPI_HID2_CMD_START, (hid_cmd_start | BIT(2)));
+
+	/* Check interrupt status of HIDDMA basic write operation in hid2_int_status register */
+	readw_poll_timeout(amd_spi->io_remap_addr + AMD_SPI_HID2_INT_STATUS, val,
+			   (val & BIT(2)), AMD_SPI_IO_SLEEP_US, AMD_SPI_IO_TIMEOUT_US);
+
+	/* Clear the interrupts by writing to hid2_int_status register */
+	val = amd_spi_readreg16(amd_spi, AMD_SPI_HID2_INT_STATUS);
+	amd_spi_writereg16(amd_spi, AMD_SPI_HID2_INT_STATUS, val);
+}
+
 static void amd_spi_mem_data_out(struct amd_spi *amd_spi,
 				 const struct spi_mem_op *op)
 {
 	int base_addr = AMD_SPI_FIFO_BASE + op->addr.nbytes;
 	u64 *buf_64 = (u64 *)op->data.buf.out;
+	u64 addr_val = op->addr.val;
 	u32 nbytes = op->data.nbytes;
 	u32 left_data = nbytes;
 	u8 *buf;
 	int i;
 
-	amd_spi_set_opcode(amd_spi, op->cmd.opcode);
-	amd_spi_set_addr(amd_spi, op);
+	/*
+	 * Condition for using HID write mode. Only for writing complete page data, use HID write.
+	 * Use index mode otherwise.
+	 */
+	if (amd_spi->version == AMD_HID2_SPI && amd_is_spi_write_cmd(op->cmd.opcode)) {
+		u64 *dma_buf64 = (u64 *)(amd_spi->dma_virt_addr + op->addr.nbytes + op->cmd.nbytes);
+		u8 *dma_buf = (u8 *)amd_spi->dma_virt_addr;
 
-	for (i = 0; left_data >= 8; i++, left_data -= 8)
-		amd_spi_writereg64(amd_spi, base_addr + op->dummy.nbytes + (i * 8), *buf_64++);
+		/* Copy opcode and address to DMA buffer */
+		*dma_buf = op->cmd.opcode;
 
-	buf = (u8 *)buf_64;
-	for (i = 0; i < left_data; i++) {
-		amd_spi_writereg8(amd_spi, base_addr + op->dummy.nbytes + nbytes + i - left_data,
-				  buf[i]);
-	}
+		dma_buf = (u8 *)dma_buf64;
+		for (i = 0; i < op->addr.nbytes; i++) {
+			*--dma_buf = addr_val & GENMASK(7, 0);
+			addr_val >>= 8;
+		}
 
-	amd_spi_set_tx_count(amd_spi, op->addr.nbytes + op->data.nbytes);
-	amd_spi_set_rx_count(amd_spi, 0);
-	amd_spi_clear_fifo_ptr(amd_spi);
-	amd_spi_execute_opcode(amd_spi);
+		/* Copy data to DMA buffer */
+		while (left_data >= 8) {
+			*dma_buf64++ = *buf_64++;
+			left_data -= 8;
+		}
+
+		buf = (u8 *)buf_64;
+		dma_buf = (u8 *)dma_buf64;
+		while (left_data--)
+			*dma_buf++ = *buf++;
+
+		amd_spi_hiddma_write(amd_spi, op);
+	} else {
+		amd_spi_set_opcode(amd_spi, op->cmd.opcode);
+		amd_spi_set_addr(amd_spi, op);
+
+		for (i = 0; left_data >= 8; i++, left_data -= 8)
+			amd_spi_writereg64(amd_spi, base_addr + op->dummy.nbytes + (i * 8),
+					   *buf_64++);
+
+		buf = (u8 *)buf_64;
+		for (i = 0; i < left_data; i++) {
+			amd_spi_writereg8(amd_spi,
+					  base_addr + op->dummy.nbytes + nbytes + i - left_data,
+					  buf[i]);
+		}
+
+		amd_spi_set_tx_count(amd_spi, op->addr.nbytes + op->data.nbytes);
+		amd_spi_set_rx_count(amd_spi, 0);
+		amd_spi_clear_fifo_ptr(amd_spi);
+		amd_spi_execute_opcode(amd_spi);
+	}
 }
 
 static void amd_spi_hiddma_read(struct amd_spi *amd_spi, const struct spi_mem_op *op)
@@ -708,23 +792,28 @@ static int amd_spi_setup_hiddma(struct amd_spi *amd_spi, struct device *dev)
 {
 	u32 hid_regval;
 
-	/* Allocate DMA buffer to use for HID basic read operation */
-	amd_spi->dma_virt_addr = dma_alloc_coherent(dev, AMD_SPI_HID2_DMA_SIZE,
-						    &amd_spi->phy_dma_buf, GFP_KERNEL);
+	/* Allocate DMA buffer to use for HID basic read and write operations. For write
+	 * operations, the DMA buffer should include the opcode, address bytes and dummy
+	 * bytes(if any) in addition to the data bytes. Additionally, the hardware requires
+	 * that the buffer address be 4K aligned. So, allocate DMA buffer of size
+	 * 2 * AMD_SPI_HID2_DMA_SIZE.
+	 */
+	amd_spi->dma_virt_addr = dmam_alloc_coherent(dev, AMD_SPI_HID2_DMA_SIZE * 2,
+						     &amd_spi->phy_dma_buf, GFP_KERNEL);
 	if (!amd_spi->dma_virt_addr)
 		return -ENOMEM;
 
 	/*
 	 * Enable interrupts and set mask bits in hid2_int_mask register to generate interrupt
-	 * properly for HIDDMA basic read operations.
+	 * properly for HIDDMA basic read and write operations.
 	 */
 	hid_regval = amd_spi_readreg32(amd_spi, AMD_SPI_HID2_INT_MASK);
-	hid_regval = (hid_regval & GENMASK(31, 8)) | BIT(19);
+	hid_regval = (hid_regval & GENMASK(31, 8)) | BIT(18) | BIT(19);
 	amd_spi_writereg32(amd_spi, AMD_SPI_HID2_INT_MASK, hid_regval);
 
-	/* Configure buffer unit(4k) in hid2_control register */
+	/* Configure buffer unit(4k) and write threshold in hid2_control register */
 	hid_regval = amd_spi_readreg32(amd_spi, AMD_SPI_HID2_CNTRL);
-	amd_spi_writereg32(amd_spi, AMD_SPI_HID2_CNTRL, hid_regval & ~BIT(3));
+	amd_spi_writereg32(amd_spi, AMD_SPI_HID2_CNTRL, (hid_regval | GENMASK(13, 12)) & ~BIT(3));
 
 	return 0;
 }
-- 
2.34.1


