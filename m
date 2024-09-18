Return-Path: <linux-spi+bounces-4850-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB9997BB33
	for <lists+linux-spi@lfdr.de>; Wed, 18 Sep 2024 12:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96C8AB22CD7
	for <lists+linux-spi@lfdr.de>; Wed, 18 Sep 2024 10:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BB4188A11;
	Wed, 18 Sep 2024 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DKyC1mLN"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2074.outbound.protection.outlook.com [40.107.96.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D5E1865E8;
	Wed, 18 Sep 2024 10:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726657124; cv=fail; b=Yo0BU4CnWrQSYGnYefvlDgedmGMp43suxjZ1TpuKLbYcIvgIHR4iMYA0SVIo6109d9Nf8RB/TQ1fR9Pnvedv/BlWLTljMrPMJbKFrN6CT4D2NjKWvf6+dpMYIbNunpfldMEyLfx2fMzt/b9kXxWyPfZdWoq8GhTeGeu40PzIymc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726657124; c=relaxed/simple;
	bh=fwT9eoj5Ge7g6zySKU/DBPJtURaGRscJUqqpG99Cmdw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LRq4so4BlObVodtBKGbCvozDPgJpFsv4w7kGTemXOv1vaffSIdXuhiF5NOUI39Epyb0Lh3QUG/9tPamGdiOqYxoiAdvUSoYlFHjzuiQS1tMS7m2OYrO1ftnam8HYoOCXClHLRVu1PNPmXQkBQaags4RkoBairdH17Oq4445u3Ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DKyC1mLN; arc=fail smtp.client-ip=40.107.96.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OHLLWFggT6rW0PvVzYGhtkuen4yeCiagYAJdU3UazYOATDsxVS2EZVcMMk5YHQY+BBYftdO1zn8ECIy/iX+CsQ9ZnNlvdVOsbwh6SN/0jP6CG6NAS0OAs8JF06IgNE3pIUSPkMcFS8rchn1lHj6yYsxCYc7jJcqnT/ycUZrittEuBkK6gvhlcPFPbMw/tVtCc6hmPUpRRZkasbLMnybCzLw4RLfFRxpqPgu5Ar8HDGTP4rRuk66aZ0f7WY328Kt9AfDQ1g7SIsMg3l2WN2S43kS3fkwpMlwjhx7BDgjU41inPHyHEyl68z0eyy03O49BnutSTMGvc9lT74aaDp0GaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PhltcmlkMn9VKOFKWAwXdsOk2KnOtgFX2ETVq8HaxUE=;
 b=I554Be57HSuy9G1NFFmczh2aSD8BMN4lzWjKA2c3w+1MIJqd7A/iVg/8JGFQ+1LpnLopep4G5YU/BrAlvHIPXwzcmK6PdiSYzXyqJsObpxCvhvVP1ZBP7Zx+D6KfxGpazPGwGCxkd4LxQudxS4RjNbPFSzxbmfy3XoUDvf5DoOBZuhdq3mSb934Xlz/V7d6gF8Knnap0+a+ojkVPRJ7MwLjBKzgaGoi6D6esMtpE9VaoIvxdVo4pfHmz7d6b9z0fagaywaGnPPl7Gt51Sf9R1lOEuogdoHU7Tz2JeeKvRYOiw9aqEvXUOKoTd2MisQT6sPc2f9uEyBIxScYErlFq6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhltcmlkMn9VKOFKWAwXdsOk2KnOtgFX2ETVq8HaxUE=;
 b=DKyC1mLNU/9+tPSOKy2r2xe20rq/XBKSKRuKau38fjTZwkWm8RyvlZ7DerMIb8l8A4+WOhmbho7D6Gp4NOIVauPMpzKo8GqsAU+F8dXOvjNgLwv+rGx0Tg9xzoB72EIbf4a6JsD310ozm1PQt9roPJ+AompUmuFm1v7gdyT8n7c=
Received: from BYAPR08CA0064.namprd08.prod.outlook.com (2603:10b6:a03:117::41)
 by CH3PR12MB8545.namprd12.prod.outlook.com (2603:10b6:610:163::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.25; Wed, 18 Sep
 2024 10:58:38 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::29) by BYAPR08CA0064.outlook.office365.com
 (2603:10b6:a03:117::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Wed, 18 Sep 2024 10:58:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 18 Sep 2024 10:58:37 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Sep
 2024 05:57:58 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <sanju.mehta@amd.com>,
	<krishnamoorthi.m@amd.com>, <akshata.mukundshetty@amd.com>,
	<Raju.Rangoju@amd.com>
Subject: [PATCH 5/9] spi: spi_amd: Optimize IO operations
Date: Wed, 18 Sep 2024 16:20:33 +0530
Message-ID: <20240918105037.406003-6-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|CH3PR12MB8545:EE_
X-MS-Office365-Filtering-Correlation-Id: b637ba53-d9c5-44df-b450-08dcd7d0d978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ITHh845hn3cScw+Fgf1Lfss6jLz1/wEdyf3uLqEoY8QKd7RWIvSXQ1CvGlLo?=
 =?us-ascii?Q?44N3r2xbZVN4fnjXpyIIjv0pbpvHoHmU2AATIw+oHQX8WoVJfVOM+oZYfYrf?=
 =?us-ascii?Q?WM+Jr8h5xyS4pT8/wfjBglKVOFfCfEvq0bAtgzVQE6DGoXpQpxUy/KSRO16N?=
 =?us-ascii?Q?QchLrfWB7c+qN7ARgJ1p58HgscX0CzwFssukA9/bjjnvUM3/W30l0i2WVWvu?=
 =?us-ascii?Q?iBsisEIJimFOVHsW+YXK9hXYx/ePI5KJpeIkCToBImmIMyMfBoH3Iu/SOEMa?=
 =?us-ascii?Q?IHcIUssRXwLhu4XMQrhNoYmXTHTWbgDksFnTpy4jUtr5nx+U8NAW2VgZTvV4?=
 =?us-ascii?Q?/wYxoWuGg/CNDpMK+yZy1cYskBiQSs9F/2Xer0VKgzuSBD0DyQ0veAR9qYc0?=
 =?us-ascii?Q?wBbuWFBu2vbNjikBAwI0F3mvJtWdNG5TCQq6KmBYKGh1//1yr1vp8+C/Wt07?=
 =?us-ascii?Q?H8EFn6J+5xB8/l2JZGoF/1l8r9uXafZlphK8tGXugARino73v3Q3Egnsyaab?=
 =?us-ascii?Q?bRymSbDM+j79aLp2rKwyUXLE8Nr3fV2seYEyTWCeGSAXndqsz5AsTi2FricZ?=
 =?us-ascii?Q?3UTAzFBQlQKP5bZlpiEi8evN9/EmViOtQyHtou6pcnEgr8tNehUmK0zPV5O1?=
 =?us-ascii?Q?A8+vKkKR1YJ6IWA/cXdVB6KpJPnflxfW8YHQ3mqM82rLgfnW2vqyMZ6Y9dp/?=
 =?us-ascii?Q?bbr4LNV/ja4xDKP9G/gg1ZLHfsnxnldbhugABUre+SMyxBfPsFsuE7wJIRYR?=
 =?us-ascii?Q?ktt4jOwy4uKjSQX3hgZd+RB6H8/9DbYSljgrkppwDMfCt2j+0Z2cK72GNKyw?=
 =?us-ascii?Q?kWULlO1WSHUhd/VWVKXrjbu/Ws73A9F0UiREy9PU1Xzrt4iIQyDvrUBl05hn?=
 =?us-ascii?Q?VytBzor9PrtgFtBnQYf5KZ485YLkHG6JWDITFK5E0GAmM787q3yBAVJq+QSK?=
 =?us-ascii?Q?6LVz9SRmP0KC2NOEb0CRbHjK72VIVwlx5ErzXBRQdJMUDClKTWY5GbKEw1B0?=
 =?us-ascii?Q?4f1I1T2EBLOz9wOPGCoh3t8TrthTRTQ7vhyG1frq6CCgpZO7HuRalL+Re8m6?=
 =?us-ascii?Q?0QFP9YPmCUrPczAhkn9A4VepkUKh8IK+H8oxF3g0f//AxBz2kjU9QCMvfIWr?=
 =?us-ascii?Q?ENHbp1mRSTdf2/OpZ0Z2FnDtcLJGLyVKQA4EEsqDEAduTcMx0Y3q8ZrOTXlr?=
 =?us-ascii?Q?Y8g0vv50d+zE9Qj+C+rrVUWO5plJVQYKKoIOMT/H9+q5x5zeJl8JDI15xgcx?=
 =?us-ascii?Q?77QwLI4DgQiFA3UJWIq9NzLtTdfVzHE3A8/J/JPmmD7lsJFWjcsT9QnRS/er?=
 =?us-ascii?Q?8IyXLosH0wmKFwUakqVfPqn3IdAizDsItwnu79gYOM2nF+ofR3rodvO52aLX?=
 =?us-ascii?Q?//apAs6w3nrKGIIHe+j5rwdj/4kOVaR4XWiySoKZskGfElDue5buT1VK+jVB?=
 =?us-ascii?Q?carCHTlSGlonRXdrspt0cdG9oa4PNPY7?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 10:58:37.9941
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b637ba53-d9c5-44df-b450-08dcd7d0d978
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8545

Read and write the maximum number of data bytes at once, rather than byte
by byte. This improves AMD SPI controller driver performance by reducing
the time required to access FIFO registers. For example, with the new
changes, 64 bytes of data from the FIFO queue can be read in 8 read calls
(8 bytes per call) instead of 64 read calls(1 byte per call).

Co-developed-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/spi/spi-amd.c | 53 +++++++++++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index eb16063ba121..c265e37cebc4 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -9,6 +9,7 @@
 #include <linux/acpi.h>
 #include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -125,6 +126,16 @@ static inline void amd_spi_writereg32(struct amd_spi *amd_spi, int idx, u32 val)
 	writel(val, ((u8 __iomem *)amd_spi->io_remap_addr + idx));
 }
 
+static inline u64 amd_spi_readreg64(struct amd_spi *amd_spi, int idx)
+{
+	return readq((u8 __iomem *)amd_spi->io_remap_addr + idx);
+}
+
+static inline void amd_spi_writereg64(struct amd_spi *amd_spi, int idx, u64 val)
+{
+	writeq(val, ((u8 __iomem *)amd_spi->io_remap_addr + idx));
+}
+
 static inline void amd_spi_setclear_reg32(struct amd_spi *amd_spi, int idx, u32 set, u32 clear)
 {
 	u32 tmp = amd_spi_readreg32(amd_spi, idx);
@@ -397,15 +408,23 @@ static void amd_spi_mem_data_out(struct amd_spi *amd_spi,
 				 const struct spi_mem_op *op)
 {
 	int base_addr = AMD_SPI_FIFO_BASE + op->addr.nbytes;
-	u8 *buf = (u8 *)op->data.buf.out;
+	u64 *buf_64 = (u64 *)op->data.buf.out;
 	u32 nbytes = op->data.nbytes;
+	u32 left_data = nbytes;
+	u8 *buf;
 	int i;
 
 	amd_spi_set_opcode(amd_spi, op->cmd.opcode);
 	amd_spi_set_addr(amd_spi, op);
 
-	for (i = 0; i < nbytes; i++)
-		amd_spi_writereg8(amd_spi, (base_addr + i), buf[i]);
+	for (i = 0; left_data >= 8; i++, left_data -= 8)
+		amd_spi_writereg64(amd_spi, base_addr + op->dummy.nbytes + (i * 8), *buf_64++);
+
+	buf = (u8 *)buf_64;
+	for (i = 0; i < left_data; i++) {
+		amd_spi_writereg8(amd_spi, base_addr + op->dummy.nbytes + nbytes + i - left_data,
+				  buf[i]);
+	}
 
 	amd_spi_set_tx_count(amd_spi, op->addr.nbytes + op->data.nbytes);
 	amd_spi_set_rx_count(amd_spi, 0);
@@ -416,23 +435,33 @@ static void amd_spi_mem_data_out(struct amd_spi *amd_spi,
 static void amd_spi_mem_data_in(struct amd_spi *amd_spi,
 				const struct spi_mem_op *op)
 {
-	int offset = (op->addr.nbytes == 0) ? 0 : 1;
-	u8 *buf = (u8 *)op->data.buf.in;
+	int base_addr = AMD_SPI_FIFO_BASE + op->addr.nbytes;
+	u64 *buf_64 = (u64 *)op->data.buf.in;
 	u32 nbytes = op->data.nbytes;
-	int base_addr, i;
-
-	base_addr = AMD_SPI_FIFO_BASE + op->addr.nbytes + offset;
+	u32 left_data = nbytes;
+	u8 *buf;
+	int i;
 
 	amd_spi_set_opcode(amd_spi, op->cmd.opcode);
 	amd_spi_set_addr(amd_spi, op);
-	amd_spi_set_tx_count(amd_spi, op->addr.nbytes);
-	amd_spi_set_rx_count(amd_spi, op->data.nbytes + 1);
+	amd_spi_set_tx_count(amd_spi, op->addr.nbytes + op->dummy.nbytes);
+
+	for (i = 0; i < op->dummy.nbytes; i++)
+		amd_spi_writereg8(amd_spi, (base_addr + i), 0xff);
+
+	amd_spi_set_rx_count(amd_spi, op->data.nbytes);
 	amd_spi_clear_fifo_ptr(amd_spi);
 	amd_spi_execute_opcode(amd_spi);
 	amd_spi_busy_wait(amd_spi);
 
-	for (i = 0; i < nbytes; i++)
-		buf[i] = amd_spi_readreg8(amd_spi, base_addr + i);
+	for (i = 0; left_data >= 8; i++, left_data -= 8)
+		*buf_64++ = amd_spi_readreg64(amd_spi, base_addr + op->dummy.nbytes +
+					      (i * 8));
+
+	buf = (u8 *)buf_64;
+	for (i = 0; i < left_data; i++)
+		buf[i] = amd_spi_readreg8(amd_spi, base_addr + op->dummy.nbytes +
+					  nbytes + i - left_data);
 }
 
 static int amd_spi_exec_mem_op(struct spi_mem *mem,
-- 
2.34.1


