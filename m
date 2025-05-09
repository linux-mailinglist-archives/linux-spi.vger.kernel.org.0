Return-Path: <linux-spi+bounces-8049-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D98AB1C2A
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 20:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0904516FFE8
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 18:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840222356BC;
	Fri,  9 May 2025 18:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gBA52uXS"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89438366;
	Fri,  9 May 2025 18:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746814688; cv=fail; b=sYufmPsZCJcQHlHZTrWEIdm+av84anCQlY6TleOz82KjmFBHpVe1l1zuliPQklDWVL90CK8ozixLwN4w4nSYAxCmkdXpBuITgCKCboDN0akXuwTOnhRMf3kfTzIefASrl0Rg6mhGEVv4dEmxxSJEgtpTlSbQhCMcUwUByrHOIDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746814688; c=relaxed/simple;
	bh=tl+oXGT3zoneme1nCd7Txu+o08J7tDdhrTPIhBUJ2YY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HkqC5pLMeGzIPn4sJaUHKEl7QZ54+HfYPjbcJCgJc3qrXC+buoAwHse4R17pUv0BwEXjyWcWeoyuwM88+ZpEmQbH+JNgIxDAwvqWkhlLEaKmkEI4zUp8pNFG0s1lz0LFeR4+H/pvgTymCJRjiNWfc7sWG0tO1CPXH0rAFAOcAGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gBA52uXS; arc=fail smtp.client-ip=40.107.243.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w5UTorzZbr2xil37Edyq+r0shlBo8pjh/S3CTiSOzGn1/BZeHaQhX74Fz27Ua7ZWv6br0Yx0ubCgNR5A71my3S9Ro8zscbF14Kmwp6dCeX9WHDzJPI3oQlGPNNqU5yey9wPdTmBDR314iaZHgMO9yQIIrslBmsZ9BV0LlClrPyuxAAhLWsacst99jKnyh69ayb/OcqMOzCuKVfTLi2bD3fQhnjmdP/nVmfEhe/DtRZ3YHoF7P0FmByLllM669QUjEIPSDILzrUe3uDagRQTHm2zvDvYMKd96R5yn8Twq/+se1oQEyg7qPWQR4zDSsAGyGJ3EmB2EwN7SIAq+DFgb8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/Vsu4C7SRuzaoEcXjMvwKxolLqGh/QmpfXHOfavqz8=;
 b=RdvKYIzCBdDhv3Ehh17qIGDmNl3SueD0Gae1Zh2buTmkBadecqWy8nviayLxywiAw1KCkfa9jrkWrY2cZ7V8vrvioyhXrFvvdVFVXz+r3otQJfsw0OcO4bfqq3bV4RxvDo1zbTHLNGlsdi6cV4v39A7zs9R6C5jG/wOe/vXX4/ms8+E3FIXLhpqbiXIRBrX2TQCbxVFzP5I2NkXPVsqVtckd3wDblI+Uq1APv/0mDX+vn8oromqmvhkRy83OjgoCJWRO5RfECed3lbIOJJoyV3DoOzR9XHZvvb/0mxeLOHs/uCxUm/ATR6DbXEFO+cujDawfSNakiXkQ7pE4yYntWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/Vsu4C7SRuzaoEcXjMvwKxolLqGh/QmpfXHOfavqz8=;
 b=gBA52uXScZu86WytQMW6BxUTXJQzbwwp7y1XxzR5Jg7rFXSZRySFtTLbx4LS8aEAACmMxiATbYAoJ9UTyQoZflh0qp0dsDEhPKY2TXo/zQIiOvPfL3VHdyqmvcnBspV/VcCe+qwfGAmyfuohxIqEhHgsPhnNIeLVNulKefTBsgc=
Received: from DS7PR03CA0177.namprd03.prod.outlook.com (2603:10b6:5:3b2::32)
 by DS0PR12MB7510.namprd12.prod.outlook.com (2603:10b6:8:132::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Fri, 9 May
 2025 18:17:58 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:5:3b2:cafe::f8) by DS7PR03CA0177.outlook.office365.com
 (2603:10b6:5:3b2::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.29 via Frontend Transport; Fri,
 9 May 2025 18:17:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 18:17:58 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 May
 2025 13:17:56 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Raju Rangoju
	<Raju.Rangoju@amd.com>, Krishnamoorthi M <krishnamoorthi.m@amd.com>, "Akshata
 MukundShetty" <akshata.mukundshetty@amd.com>
Subject: [PATCH] spi: spi_amd: Add HIDDMA basic write support
Date: Fri, 9 May 2025 23:47:37 +0530
Message-ID: <20250509181737.997167-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|DS0PR12MB7510:EE_
X-MS-Office365-Filtering-Correlation-Id: 788ab1b1-5e80-4135-ba72-08dd8f25d3ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X+aM1VXo5pfqzCBd0PQDD6FQ2UetEkE1abXj7brMavPsZEYylJszeZAHCCJ4?=
 =?us-ascii?Q?71qZFiFa42ZrPHzu4gDBI73pghOH79wj/w9mmsQVp5232wxjXri8+noB7EQM?=
 =?us-ascii?Q?TVEiwdluL5+/f7BECA0A3iVu7ZT+AkdoAulTtfQHAMdAW7284QYshdiE4V7y?=
 =?us-ascii?Q?ddG2Aa+xN4YQTfcxTwrRPDUBGFqmPhybz6TEUGy6j+5yBbeohnb8oA90J+pv?=
 =?us-ascii?Q?IFBSo1zMmNML6SwcECTiBDhrVR2YK+8ihM4oSbeoNBLPknKD7nATpvjKAqFS?=
 =?us-ascii?Q?aiv9OKNykmp3mvD53c+ciQ/Q2DbzLVD7UYD/S9Ie6t+zDHZHX6lfqFB43QKJ?=
 =?us-ascii?Q?3GYDSxG+CNYJEg4k64+HLcx7vRcTmotw/e9EyxX8UTA/mYfz0xw9HVUR+wWs?=
 =?us-ascii?Q?1kp094OCmb7C08BtYpgakckBsP4NsjUhYSToYEH9s6qqYQzDLKWn6S3mZ5sH?=
 =?us-ascii?Q?FxYUx3OVS9H+/j83WT7YRWw2fZf73tshK1YTNpBcCglVsWI5Q+y+RXZHwnmj?=
 =?us-ascii?Q?GBsblFsc4gy1nti4dvn17R9LxaJpyd2xwSqjDR0ifOewy/pAiCLJ9SnKk1Ke?=
 =?us-ascii?Q?Gm7eQjMD8as5RdKIughOFb9qCfTJdID1Td6huraFD8Nrn96yA2vSeZwPdxDb?=
 =?us-ascii?Q?tDQgjBXSlkSmxGnY4Rq2iq6WcXPzRkOpDqX/Iim+816l/t266RoYodiZ10Xu?=
 =?us-ascii?Q?c+xCg1XT/FV9qvhhsPYQCV7HQCenVQoI8VgUu9Tr7Zy40PuDsb50zOP31M1u?=
 =?us-ascii?Q?hEQhWEuuMXAth4Uizg/ZS0oTKwKd/6CUbmuXIImjBi/HIDM5kOUH1APYlkh8?=
 =?us-ascii?Q?svT0I7XUmCLJYa5sXctVNIiwv8OuO8d8svpWbuH+ekNJxfRhssn/kSg1npwd?=
 =?us-ascii?Q?O6gRBA1HDkS+nXLGRC5vAlnbMNVJV9QoN6eA/9opeugco69MlZi3ftZJbyev?=
 =?us-ascii?Q?Iholrr71pglo2mUbVoKqEO3HLnS0ZTOlrTxbH24wgNOXsL8NnW+9wEVgersz?=
 =?us-ascii?Q?f9UV1dpKyi764stoNlFm2f+IIJwDOvsOQQczWuPrJzY/V4uo+y9hO3W0cfyu?=
 =?us-ascii?Q?WlPNoCgmlHxnnIEGIIoiieNhvWDF0qHH3gqiaux51FMkF0rrE8olSjAtGpFR?=
 =?us-ascii?Q?O+PON3fFzr5Q2SAOO+MXu0Gt28YTy3++xtcd1EqwIT/RoRQovrwJOCllSEt2?=
 =?us-ascii?Q?J+PccHXtS7vNLX1b/v6/th/TubSwcpM082VbxmR6SUsdNGNo5XVnjVwJG/wd?=
 =?us-ascii?Q?fBA9ntJoc6QZRjXa7Ycoluozm6wAqcAf3JhNUJbrKBtpVJfnW6QwDMmFGAJF?=
 =?us-ascii?Q?Q/0ZmgkyAu2jEMxUSQlCQCfQdYNd3aicDDV/Jna/tzIBg7ZxLpGELDt0Spel?=
 =?us-ascii?Q?y72Ozf6VbGvwaIOuA5RnPhWmGyoNYVoMFwTdLOhU3iPlC7b1yTFcZCGK9xFU?=
 =?us-ascii?Q?nIUBC+UgZgfbSGXdzCeY2I2Jq0geSY/lTqJlhTUlrzBFwu711GFwCLJxwk7D?=
 =?us-ascii?Q?+dYxwpJATIKyb9KL1Ju7mjyrbpr6gEyRrUUM?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 18:17:58.5621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 788ab1b1-5e80-4135-ba72-08dd8f25d3ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7510

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
 drivers/spi/spi-amd.c | 130 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 107 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index 17fc0b17e756..8567465d2282 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -52,10 +52,13 @@
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
@@ -93,6 +96,10 @@ enum amd_spi_versions {
 	AMD_HID2_SPI,
 };
 
+/* SPINAND write command opcodes */
+#define AMD_SPI_OP_PP			0x02	/* Page program */
+#define AMD_SPI_OP_PP_RANDOM		0x84	/* Page program */
+
 enum amd_spi_speed {
 	F_66_66MHz,
 	F_33_33MHz,
@@ -445,6 +452,17 @@ static inline bool amd_is_spi_read_cmd(const u16 op)
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
@@ -455,7 +473,7 @@ static bool amd_spi_supports_op(struct spi_mem *mem,
 		return false;
 
 	/* AMD SPI controllers support quad mode only for read operations */
-	if (amd_is_spi_read_cmd(op->cmd.opcode)) {
+	if (amd_is_spi_read_cmd(op->cmd.opcode) || amd_is_spi_write_cmd(op->cmd.opcode)) {
 		if (op->data.buswidth > 4)
 			return false;
 
@@ -464,7 +482,8 @@ static bool amd_spi_supports_op(struct spi_mem *mem,
 		 * doesn't support 4-byte address commands.
 		 */
 		if (amd_spi->version == AMD_HID2_SPI) {
-			if (amd_is_spi_read_cmd_4b(op->cmd.opcode) ||
+			if ((amd_is_spi_read_cmd_4b(op->cmd.opcode) ||
+			     amd_is_spi_write_cmd(op->cmd.opcode)) &&
 			    op->data.nbytes > AMD_SPI_HID2_DMA_SIZE)
 				return false;
 		} else if (op->data.nbytes > AMD_SPI_MAX_DATA) {
@@ -490,7 +509,8 @@ static int amd_spi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 	 * controller index mode supports maximum of 64 bytes in a single
 	 * transaction.
 	 */
-	if (amd_spi->version == AMD_HID2_SPI && amd_is_spi_read_cmd(op->cmd.opcode))
+	if (amd_spi->version == AMD_HID2_SPI && (amd_is_spi_read_cmd(op->cmd.opcode) ||
+						 amd_is_spi_write_cmd(op->cmd.opcode)))
 		op->data.nbytes = clamp_val(op->data.nbytes, 0, AMD_SPI_HID2_DMA_SIZE);
 	else
 		op->data.nbytes = clamp_val(op->data.nbytes, 0, AMD_SPI_MAX_DATA);
@@ -514,32 +534,91 @@ static void amd_spi_set_addr(struct amd_spi *amd_spi,
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
+		void *hid_base_addr = amd_spi->dma_virt_addr + op->addr.nbytes + op->cmd.nbytes;
 
-	for (i = 0; left_data >= 8; i++, left_data -= 8)
-		amd_spi_writereg64(amd_spi, base_addr + op->dummy.nbytes + (i * 8), *buf_64++);
+		/* Write opcode and address in system memory */
+		writeb(op->cmd.opcode, amd_spi->dma_virt_addr);
 
-	buf = (u8 *)buf_64;
-	for (i = 0; i < left_data; i++) {
-		amd_spi_writereg8(amd_spi, base_addr + op->dummy.nbytes + nbytes + i - left_data,
-				  buf[i]);
-	}
+		for (i = 0; i < op->addr.nbytes; i++) {
+			writeb(addr_val & GENMASK(7, 0), hid_base_addr - i - op->cmd.nbytes);
+			addr_val >>= 8;
+		}
 
-	amd_spi_set_tx_count(amd_spi, op->addr.nbytes + op->data.nbytes);
-	amd_spi_set_rx_count(amd_spi, 0);
-	amd_spi_clear_fifo_ptr(amd_spi);
-	amd_spi_execute_opcode(amd_spi);
+		for (i = 0; left_data >= 8; i++, left_data -= 8)
+			writeq(*buf_64++, hid_base_addr + (i * 8));
+
+		buf = (u8 *)buf_64;
+
+		for (i = 0; i < left_data; i++)
+			writeb(buf[i], hid_base_addr + (nbytes - left_data + i));
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
@@ -728,23 +807,28 @@ static int amd_spi_setup_hiddma(struct amd_spi *amd_spi, struct device *dev)
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


