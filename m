Return-Path: <linux-spi+bounces-4969-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA7A9860E2
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2024 16:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DD3E287600
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2024 14:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD7118E03F;
	Wed, 25 Sep 2024 13:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GWRGj6jC"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5174118E34D;
	Wed, 25 Sep 2024 13:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727271612; cv=fail; b=J7fB/lZW2jQmRrgmNB+QlRYqrrb7B3Wsij+UuAiPmMJ1OaMp1lJlwzlXSQEokhLrSJ6wCSwVlN4BytZkp4aRKvsJ42eu809NUM7lFIVxAE+hhhkz7a1srnMhTHmiIuab54kNScX6qFOr88RlotqQnP5IL7tOMB4WOWbf24yUo54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727271612; c=relaxed/simple;
	bh=+XNmH5Sv0vAuT2frgcBnWcLCfBAG+ArgYcGnhBCGVpI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oBTdbJhBbdwdSyISttWU2E3nP+j0Jlpszn8ZHtQYskYR2Tm/nokBG7ayA/HrWL6Rr0nlk4oe+dEKML/f+gTDXmneBSfhe/ZmtcgZnFdJRa9Ea07K5OCZEfrNGQgpaO0K/EOmqPqJpbdAbOkPRc9RyEYv9X5mloNeveE6LjqJgeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GWRGj6jC; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o2MyU0A7EZksvI6mRd1DfHd+Z3A5V9Y+hRUFr/3SierLw9Y6n7vmgs2T/Suna7A0QtYMUq7cUGJEM791rBtbj+FP/TnZ74ZpycWxt3C3+pOMoZa4KfdRPOjvgKepFozKkd0Ym5wjFpcu5LfF5tn5yI2ibtO6PeUy4du6avO6yozFSzO0lc1PI9FC2wU2AGCWBta/EWkuodfJEAdCfHjpX4NQCAB1DIgJFi0ac6nKFvyiWfuTLGlSQiG7H0CvW6Kvlrl8hILWckGMunV0XYwSFUAoaxgHguNMNV1J2blWMBolNgWEignJWvwGfMIjBmNfD652aogYlFt56deUSvXiZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZqSN3IPxrsnBmtMBkCl7O3zh1l0q9fEDMPDft+SvDs=;
 b=xQ5zZkEwJpLLfGqzZdR/p+iZiE1ckOORYRHy2MeJq3XkpjIK1eQGCPNC1oS4I3G2tvKAbKfSTeUp26OvYeCiTyw26phHbd2i8h9mFQHEYbzfbBBZlSnFZAD0I4S2nxaRYfOH0aSkGX3k2E6jTkFXaHv7dITcqudCrYYx1GbtVMoSfBEhgkKNarTUC8kTWnwPo7JCSTIVLTsG7pX+AJzMLpyYK+wnNa9d8PmU9d5Gy4l1vzJjn4mHW7Ve/yAlU4Am9OcYd/SDoIhQJXcuH02hnhTlNS0NwoZC+KZG4PsjwoW+128r4YhrivlmWN64mPjBPBnxpnVVm2v0YHVA00/WhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZqSN3IPxrsnBmtMBkCl7O3zh1l0q9fEDMPDft+SvDs=;
 b=GWRGj6jCmHhz2f5B7XijD+09vClsW+7p/vRsPd78ZTAm7s9jbMwUerqhYqpQEwRUwcldg9xhAYX3AwMuKZ8NVw/Wm5ymtuK72wuvYxGm9E4C280FdPCvF+fheiZTHeauai9lSC3yeWpzrSE8ZoKmV5YAIdoA+Ulu05sKse+7W2I=
Received: from SA1P222CA0128.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::10)
 by MN2PR12MB4064.namprd12.prod.outlook.com (2603:10b6:208:1d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Wed, 25 Sep
 2024 13:40:06 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:3c2:cafe::1e) by SA1P222CA0128.outlook.office365.com
 (2603:10b6:806:3c2::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.17 via Frontend
 Transport; Wed, 25 Sep 2024 13:40:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Wed, 25 Sep 2024 13:40:05 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 08:40:00 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <sanju.mehta@amd.com>,
	<krishnamoorthi.m@amd.com>, <akshata.mukundshetty@amd.com>,
	<Raju.Rangoju@amd.com>
Subject: [PATCH V2 2/8] spi: spi_amd: Enable dual and quad I/O modes
Date: Wed, 25 Sep 2024 19:06:38 +0530
Message-ID: <20240925133644.2922359-3-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|MN2PR12MB4064:EE_
X-MS-Office365-Filtering-Correlation-Id: 81dd4577-d288-40c7-a6ea-08dcdd6790d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zU1bM4MTIW//Bqx408kGwfWUaX76cIxtFewaR1tMXmuuA6teSj38YD/U/0wG?=
 =?us-ascii?Q?u2ix4l68SaaISEvp3LrX9SdHlN/Rqpn9l1SUaPsGTswtZPzBW0R6hhfqItpi?=
 =?us-ascii?Q?Fi4x2oZ709lKczvxvZs6ltO+2qq+le4qi+OQ30fLaYhChmL80XDesiP8AT6W?=
 =?us-ascii?Q?WhhOBe2XZEk6P0+XaNdsnwdWdZ5lz05PF3HPXxhkyCYugHcPp2mVncwF/NGg?=
 =?us-ascii?Q?0rQjDkJkl5iFNw7S1LnjX5pb4QBOpl7wIM2Re8/f92Nahum/AHRAZ4APcddV?=
 =?us-ascii?Q?FNssy6hqrqwunT/ZhwiWaCji0aRcsgPqMPkwMdmaz5UY92hHQ9vzyOP8gdMP?=
 =?us-ascii?Q?o6GRAv81++TVXReNqJzYyFmhuick0ULX+S68mDp7ZV41QIkr0OXPbIGpFVXU?=
 =?us-ascii?Q?0K9pGV5gQ5Fp15byTWbulZsVbx9CZx6ZxYHd8RMj3L7ZGGkLhUbu7e3LzWZq?=
 =?us-ascii?Q?HRRQborvBUTnZJG9VxQggBU/MhZEnSi3OawXEcpOC0BxcxtTTT1hxNELhar1?=
 =?us-ascii?Q?HYQNzsE5ik7wowuxf0c+o0TaqGUC5MeSN2hu6f3BMY82juqe+Ns2sQCrqAqn?=
 =?us-ascii?Q?70gvl/DgAbEG1VBpBR0bbh1xoKoeuggUVyI9tMugYanIg95jQaHr+AxIjToe?=
 =?us-ascii?Q?XQa45LVj7r0/NTy+JUl5LT0WWEq8/fwDqXhz2xl0jI9aSXoYolztImXbdlfE?=
 =?us-ascii?Q?hITIkFXg02+AnKo0/1cHCHCnsJiFffyEPLJzNCMZixTh6WUpzhPFVDEavD+5?=
 =?us-ascii?Q?/XxBJKifZnzxyA+1aVZ6ufJpYuppDN+0bhGAwsrnYcXG9N1y4o5IUSLPJivd?=
 =?us-ascii?Q?C+mQtAKsia4fjvdK/oXqCx5IvGjlLH6dZweOBRhrYxtfoH8Rzp7+oI0KTolC?=
 =?us-ascii?Q?07NVVrC6w1UjlpPxefEuC9mceqffLG45aWQNX/v0W20Cen2g+ddLs4k/OxMH?=
 =?us-ascii?Q?v0iq6AAGNK8rX6vUteQVl6VLW1PAC2fXFjQRns7EXnzva87T4n0Dbnjh0oSR?=
 =?us-ascii?Q?ttUfBg9HdidGhMj0+Xs/pFpNorNa/MVGit213VkM6WTdMm/t5UDUdFCfyUDt?=
 =?us-ascii?Q?mOwimhSEsfBmAP8roO0gkyZYlo+Tz2pY0gFbBz797f7P5XXGOuKwhNfm/CpC?=
 =?us-ascii?Q?yNBgX5WrbVD+5SwGOx6p/9OrIAMFbRIBR1zH0F51WFW0yB6rC1onU/aGRrea?=
 =?us-ascii?Q?9FdnAk+/mtSvCdP/Ts61T1kytS/s86xq9W1co28tRSi2vT97RLY4HqW698hZ?=
 =?us-ascii?Q?Fji46W4CdJgsa6YK0EcQ48mxnjhuu52QUWzvmbnMsxITALrVdddGkq6RmQsy?=
 =?us-ascii?Q?a8U0aASZXBVBTZv7hoAH+oBC0nMrXh0dQNBLEJ3FclpwwWWxVWFzM+6kVeFG?=
 =?us-ascii?Q?HlNoLwCKJR+kGHXtyDL+yv4piOlJEViz8RxcYGbOUTm+ogKe78yvngD5ue4y?=
 =?us-ascii?Q?zMMyIB4zjR0zt0H/tUSLnRASXBW5ynvG?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 13:40:05.9949
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81dd4577-d288-40c7-a6ea-08dcdd6790d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4064

The current spi_amd driver only supports single I/O mode, despite the AMD
SPI controller's capability for dual and quad I/O modes for read
operations. And AMD SPI0 controller has limited support for quad mode
write operations. Update the SPI-MEM support function to reflect these
hardware capabilities.

Co-developed-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/spi/spi-amd.c | 57 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index c52066360dfe..17a8401216e4 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -50,6 +50,21 @@
 #define AMD_SPI_MAX_HZ		100000000
 #define AMD_SPI_MIN_HZ		800000
 
+/* SPI read command opcodes */
+#define AMD_SPI_OP_READ          0x03	/* Read data bytes (low frequency) */
+#define AMD_SPI_OP_READ_FAST     0x0b	/* Read data bytes (high frequency) */
+#define AMD_SPI_OP_READ_1_1_2    0x3b	/* Read data bytes (Dual Output SPI) */
+#define AMD_SPI_OP_READ_1_2_2    0xbb	/* Read data bytes (Dual I/O SPI) */
+#define AMD_SPI_OP_READ_1_1_4    0x6b	/* Read data bytes (Quad Output SPI) */
+#define AMD_SPI_OP_READ_1_4_4    0xeb	/* Read data bytes (Quad I/O SPI) */
+
+/* SPI read command opcodes - 4B address */
+#define AMD_SPI_OP_READ_FAST_4B		0x0c    /* Read data bytes (high frequency) */
+#define AMD_SPI_OP_READ_1_1_2_4B	0x3c    /* Read data bytes (Dual Output SPI) */
+#define AMD_SPI_OP_READ_1_2_2_4B	0xbc    /* Read data bytes (Dual I/O SPI) */
+#define AMD_SPI_OP_READ_1_1_4_4B	0x6c    /* Read data bytes (Quad Output SPI) */
+#define AMD_SPI_OP_READ_1_4_4_4B	0xec    /* Read data bytes (Quad I/O SPI) */
+
 /**
  * enum amd_spi_versions - SPI controller versions
  * @AMD_SPI_V1:		AMDI0061 hardware version
@@ -360,14 +375,50 @@ static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
 	return message->status;
 }
 
+static inline bool amd_is_spi_read_cmd_4b(const u16 op)
+{
+	switch (op) {
+	case AMD_SPI_OP_READ_FAST_4B:
+	case AMD_SPI_OP_READ_1_1_2_4B:
+	case AMD_SPI_OP_READ_1_2_2_4B:
+	case AMD_SPI_OP_READ_1_1_4_4B:
+	case AMD_SPI_OP_READ_1_4_4_4B:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static inline bool amd_is_spi_read_cmd(const u16 op)
+{
+	switch (op) {
+	case AMD_SPI_OP_READ:
+	case AMD_SPI_OP_READ_FAST:
+	case AMD_SPI_OP_READ_1_1_2:
+	case AMD_SPI_OP_READ_1_2_2:
+	case AMD_SPI_OP_READ_1_1_4:
+	case AMD_SPI_OP_READ_1_4_4:
+		return true;
+	default:
+		return amd_is_spi_read_cmd_4b(op);
+	}
+}
+
 static bool amd_spi_supports_op(struct spi_mem *mem,
 				const struct spi_mem_op *op)
 {
 	/* bus width is number of IO lines used to transmit */
-	if (op->cmd.buswidth > 1 || op->addr.buswidth > 1 ||
-	    op->data.buswidth > 1 || op->data.nbytes > AMD_SPI_MAX_DATA)
+	if (op->cmd.buswidth > 1 || op->addr.buswidth > 4 || op->data.nbytes > AMD_SPI_MAX_DATA)
 		return false;
 
+	/* AMD SPI controllers support quad mode only for read operations */
+	if (amd_is_spi_read_cmd(op->cmd.opcode)) {
+		if (op->data.buswidth > 4)
+			return false;
+	} else if (op->data.buswidth > 1) {
+		return false;
+	}
+
 	return spi_mem_default_supports_op(mem, op);
 }
 
@@ -514,7 +565,7 @@ static int amd_spi_probe(struct platform_device *pdev)
 	/* Initialize the spi_controller fields */
 	host->bus_num = 0;
 	host->num_chipselect = 4;
-	host->mode_bits = 0;
+	host->mode_bits = SPI_TX_DUAL | SPI_TX_QUAD | SPI_RX_DUAL | SPI_RX_QUAD;
 	host->flags = SPI_CONTROLLER_HALF_DUPLEX;
 	host->max_speed_hz = AMD_SPI_MAX_HZ;
 	host->min_speed_hz = AMD_SPI_MIN_HZ;
-- 
2.34.1


