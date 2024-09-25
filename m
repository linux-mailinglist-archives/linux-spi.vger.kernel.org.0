Return-Path: <linux-spi+bounces-4972-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9BB9860E9
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2024 16:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3DAE1F28E6C
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2024 14:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A761C1AFB2E;
	Wed, 25 Sep 2024 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jCbKn94M"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043431AFB1F;
	Wed, 25 Sep 2024 13:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727271621; cv=fail; b=jcXq8wGPsIHkEBPem8xpks0c5dYYynDjDQyDPXVVzlTVnRmt5/zcmRN8KyQE74pQ/hCgvL2fELJec2/5+uE9Ek54J2Gt2QLRxNm4M5I0B1loQWuhqzOh1Uc6Av4GGtMZSg/I4XtruTiLcXFrcNokiEUYeuJoKEVHfImBj+JvCTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727271621; c=relaxed/simple;
	bh=qyISoT5a196MS/deIEdkly1dpyxmoZ6TSBG3VGdT5mk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=argaVp7zCSRH/MSQfF2ryxmLIiVuIAetRW5NDCsJWlQDf4JgQY6y4kiAzAXoUOIjgR0PYreqhyISVXPYSKFvnpjwMB1u/PkePv0Bam8E0vmf2Y+/mvEJNUtqhBr5vsIAxVCg7f08mCpKVYC7dPzBVMjDSfZDUydS4GbgeqY4miI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jCbKn94M; arc=fail smtp.client-ip=40.107.223.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0QUfSKQyPRl5nvzNKW9Ckr4hZqb9s5YtDzI0gOZ6rgz6QRNq+0KxW9YuiAbqyTZe1KUnaizMoALON79qoJBf/8tuyGaRggEDmBSRD1//+vab3bbWdivDyyv7iWxFIrmp79u2DHl/Wohqnrs0rvoyAmz8h/5xmKUH5N4425osd7anpIraJxfWUiz1M5QXuy63MCQgIOuNGoqBFtGD/swVSGrBNbwSTUn0LSf6yQTeff5VRroAKbv/OHpWBZf37mmzHaTdE47qooM2ZnRYxnnDlHxzjNH8uHxkuH4Fk+S0DYfiV2u6Fruzgul204WREorVF4p6p7Rwp3d/PXqm/Bryw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMMAjwGlAB3F1ZS0YECTi+W2XuGPAK7ihaFRpIHwCdo=;
 b=OqUoABOEr106vuRbnKMRpX+WOzyjtjug46l3U6hMeJY3xo1G972ugJ4f8mlBWO3PWHL5O0LN8MwE8RWdD7IOrafx1hKyWGExxBxQHBZpy1cR51DaBF89EH0PmGA3Ptg+WdhMsiSM4AQAMbS9kwUdnp1wC6MRSNTF/R5L4G8xS2agIbVIWsrfNhkIjYk1zBt400xnLqgIMnDszLvq0XAqcBbppeEJBfDXrYRZDEgvw75WZadyDp91sd0hy3qOdnSS4s9gwzq5UUeCJbPBO02SZ0T/WR8EGSiUJ4YqG8nypNSIEFigqbrUu2dTIdAVJcE51/2qDcayadWtAlrxaxXqXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMMAjwGlAB3F1ZS0YECTi+W2XuGPAK7ihaFRpIHwCdo=;
 b=jCbKn94MHYct88DLIJRQY0JaE3TlRnD0aH0zKo99rBydsEVEpbV5KCzyDYsfoBsIbynuWS/GkJ6NUBFZAwNrmeVeqSJXwBKdXZPpXzKyAgiAwN1cXyZm1iE88YKtKmbJD6lHbiIG3XXxCf2buvYFTfMWV2WhGAYyJo8Vs7neycc=
Received: from SA9P223CA0010.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::15)
 by BY5PR12MB4290.namprd12.prod.outlook.com (2603:10b6:a03:20e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Wed, 25 Sep
 2024 13:40:14 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:26:cafe::c7) by SA9P223CA0010.outlook.office365.com
 (2603:10b6:806:26::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27 via Frontend
 Transport; Wed, 25 Sep 2024 13:40:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Wed, 25 Sep 2024 13:40:14 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 08:40:11 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <sanju.mehta@amd.com>,
	<krishnamoorthi.m@amd.com>, <akshata.mukundshetty@amd.com>,
	<Raju.Rangoju@amd.com>
Subject: [PATCH V2 5/8] spi: spi_amd: Optimize IO operations
Date: Wed, 25 Sep 2024 19:06:41 +0530
Message-ID: <20240925133644.2922359-6-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|BY5PR12MB4290:EE_
X-MS-Office365-Filtering-Correlation-Id: bede3a90-82aa-49a5-1a48-08dcdd6795e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k2HT7NLsLYKZHihmFAbgBH2itGVrDX6N0Va/P6JBLjVgmdKiBmJd8JDJDC2S?=
 =?us-ascii?Q?UtpzyjIFenBEVxg6ab0QL68bmyVJV9O4J1RHEy0qMXF2pVBsLgRbBhVXzWMQ?=
 =?us-ascii?Q?oY1y0s/6YV+Xk3d9M6jpP2aogWu9VKdzfJ+duKQlcSATsRAATUcFV9lirG1u?=
 =?us-ascii?Q?mV11lIMDCuWtvDhfy9eWbGr4PIJW1Yz5bo1Z/pJKjdhLCn4sNwtAlo1KuK6o?=
 =?us-ascii?Q?OszGt8IGMgS9G9ZHaCbriJuvgZPo/DdCQIeD8EF4xOLv1El/gMZiThR3VtKF?=
 =?us-ascii?Q?j4m/wTF/YYIlf+cj03XkD2+gU/WQy69WvB5zsjMJgezzQn5jQh/YuBDtf2nF?=
 =?us-ascii?Q?LrrphSRLhPcpb+gkni9bNCtLs7YRRsZ+T18qdA+ZkkFlKoz526D4bINks4GR?=
 =?us-ascii?Q?SiG/HBJVMMfrNvaqdhgy1IxJ0+/YsUMCGhryv7wRyskNP5toemJgfZTnQp2P?=
 =?us-ascii?Q?5DnEwmsi0iKQlCIRU9o9BQ+NPK1DUBCWQ1mqYHfVcZTxa23zFO/RhEw7aQ1y?=
 =?us-ascii?Q?a2IxhJ4hl58D4Z7k8FrjuIKnMSWdPmEC5jhBl97147xN2mZv99KtDz3ZM4nI?=
 =?us-ascii?Q?F7HPDg17YCFQ0HxVso4ro8jb1F0FSfyhAHev934ExXc5r9h1/LrCd8C/gCxQ?=
 =?us-ascii?Q?7Zr7Jb458AJYBvg37X7i907/9Va2v6h+EQpLguMt5RiCazccY0jzi6TZXjit?=
 =?us-ascii?Q?shg0fxS4j6sK1/ZCo5lxfFPr0FY8dOLWpb519ZYOqA4A7P1YIpLgpVUP0syT?=
 =?us-ascii?Q?AQpPN9qFbWF9w8M2ps+VzmBmRQHbsYyRSMbY1NRQLqWkKO5bSwgeJEdwDgNZ?=
 =?us-ascii?Q?PLcjS4NjGu3uf7imfC/Bhi9+Z316CCvhsm4yuSVoq3gI1JeVbyW1dHsnfHYq?=
 =?us-ascii?Q?D2yfZ4cIT9fVdd1KTXW0N84HPilOVFXQu0j150S9W6/UXWGWq3Jplps7vmfg?=
 =?us-ascii?Q?T8PYiyH76IBViB5Cz+5UZSPs9U4W/8+qRHZ5cVMc+EUfRoqQNnN8caDPpzNc?=
 =?us-ascii?Q?KuSEH3gb3dfTf7/GCguHqmFvTM5NWspH0hW7eTn5E7LCyPWfM0lLq1CdyPY+?=
 =?us-ascii?Q?6h1FCN6BaG0aLdnvMkTcRmwK5ZC9Ta3je5o+4TKWlSVQJma6kywJDDekxNx9?=
 =?us-ascii?Q?HWma1eEsHbYz3U9seVKyAJhJ7W9utgSd05k55vnToU9LnNXfeOt2gPeqrApM?=
 =?us-ascii?Q?lV4TNMmWmdE6dpMdApj+hQTgJVd+fNLnJ26I2hZjcBMAnSEosLBa9fESogFf?=
 =?us-ascii?Q?x5QV5dgnZKSMmQajRlq0/kY64BBbcUIGV38HKgVpGaH4GSsKbYVVAhlicUss?=
 =?us-ascii?Q?kS/r0XkEREeb9tvVFkAapKWat64refGzqtypmp3UFajDZBJatx2ZpYwyRiIO?=
 =?us-ascii?Q?7u0zTlZyeC73HCk0jeoaYWoMvs8ofoBf02cx/O2Tzh9g7+JeRiXMLY9BPGim?=
 =?us-ascii?Q?IzxLEXiqAKUcsYNbBdsMw9z+xM/DDzRk?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 13:40:14.4914
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bede3a90-82aa-49a5-1a48-08dcdd6795e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4290

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
index 7841f3292a62..00fcec903d91 100644
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
@@ -140,6 +141,16 @@ static inline void amd_spi_writereg32(struct amd_spi *amd_spi, int idx, u32 val)
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
@@ -448,15 +459,23 @@ static void amd_spi_mem_data_out(struct amd_spi *amd_spi,
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
@@ -467,23 +486,33 @@ static void amd_spi_mem_data_out(struct amd_spi *amd_spi,
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


