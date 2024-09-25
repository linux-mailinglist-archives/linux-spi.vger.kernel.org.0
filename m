Return-Path: <linux-spi+bounces-4973-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3FC9860EB
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2024 16:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BA2E1C26A94
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2024 14:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6E91B2538;
	Wed, 25 Sep 2024 13:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Khz32QG0"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2047.outbound.protection.outlook.com [40.107.212.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BAC1AFB37;
	Wed, 25 Sep 2024 13:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727271624; cv=fail; b=RlZEOHGDPElEjLoEg87urupatDW3fjLYBhss6DyYJm1KaRrMxpI0tNyGYa+0VMqAtx/OmlcgHdaDClbGTmPgWJgvJ/r2iN4TM9uNsk5d8GUsGIceFru077TnsLDyBkWNxdnswSDe73FomozT9j2HzAsJCfnNRjQdRUrJGG4XV2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727271624; c=relaxed/simple;
	bh=olNVMU0iaGY8AxdufEiy1r1rFrmTzsLBsIscje4I6wI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U8XcswRDXcvQhJ0TZGkN3M+tB+DQ0YpBIhEfN9QYWFyiY+jOeSFoRvY5CjAmMOLC7rsLf0nP+sCe97/Qr9Y1kVs6A4tiNPExyPqPJMG77cYMpR3n365KoMGyPds9Lc/QlUw6bZqrKYx3E5nqt9KKm8ZjonXg9H9yzXO3GQKP758=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Khz32QG0; arc=fail smtp.client-ip=40.107.212.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aS7bjpCFyVrHGCsO0nW2DsQ4MdXiuq2cFGrQ5yGk6Fo6/wJ8CJHj+W763/7Wx0SH7Bmg9iWjA7mN9y4J+seaV896GvP7u3dBHCQN0MAuz3Cd69IvniVmg7EJ9gdE3ndhutmGtQpYTouWP2U+dPvH+WPVyFZa96utxTAF1A7b1MEdOczKkGJhRbCFDl8LH4icKSCtDEjD8UFX55crF8gfF5jRfSJHn76mEN6akkjOBX5ftKwN2FyKflEd+egYpvVChewaUMgwI34jaG0og43pYYf1XMPT5ZdP6gO+XroGWwLvSftL1JUmhytOCzr0kvfYNYSvPBpIwc7foopZN/EOiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4SoZhI4P0EShjvRwWHAfmRdZ3tDIyxjCFaIKZXcgAI=;
 b=tU8egLUYI/eSxRuH7Da1YVZJcOYDHpx6xrzOh8zdw5i9m4+Sk6MjUDaUJ3Ye0uVLhv3WYQHBnDtWCleCeJjCXHV2skzPd1rAsRUBxyv8EKUNjnFVFQkLdRQPR9HaTObZ9w0xwfRNgXIQg9gG34JeeLjakyEwRxXh/DCSoYo57d60ROlKxa0kJQthljXGZtyDTxy3SHhCRtPWG5lwxsqqiAQoCVklxpR15AChep9UkassbqsCxUeTl56Z+DUPxK0tZMMbK8Q/gqnzYsnFy2qQntSI8fas+ISa04PcJRkniE54lmyXhxU/V97vNPUSPukO4GGs5sRfFWQttkHXhZz+aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4SoZhI4P0EShjvRwWHAfmRdZ3tDIyxjCFaIKZXcgAI=;
 b=Khz32QG06lKerynehxrbgaDpa2b7zUSlBOu0lhAp/v+TzEPYHZPwsttaL7y0fBmtr94Ewh8H2i8Gs17WasP0mFysWjsMvoHZ8gZzCnY05F+nRgVewLkVhReIaONZLwLiMGt0zJXS9Iqj9YS4J0nODdUe99fS77+TIsSw1parXSk=
Received: from SA9P223CA0022.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::27)
 by SN7PR12MB8770.namprd12.prod.outlook.com (2603:10b6:806:34b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Wed, 25 Sep
 2024 13:40:18 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:26:cafe::8a) by SA9P223CA0022.outlook.office365.com
 (2603:10b6:806:26::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27 via Frontend
 Transport; Wed, 25 Sep 2024 13:40:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Wed, 25 Sep 2024 13:40:18 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 08:40:15 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <sanju.mehta@amd.com>,
	<krishnamoorthi.m@amd.com>, <akshata.mukundshetty@amd.com>,
	<Raju.Rangoju@amd.com>
Subject: [PATCH V2 6/8] spi: spi_amd: Add support for HID2 SPI controller
Date: Wed, 25 Sep 2024 19:06:42 +0530
Message-ID: <20240925133644.2922359-7-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|SN7PR12MB8770:EE_
X-MS-Office365-Filtering-Correlation-Id: 72b6025e-608b-49af-510c-08dcdd6797fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PSaa+FU7MLJpQsn4OvpGWatkc0v+fDc8dGz/TuCRth0nmMw3Y4sTP4imbu0S?=
 =?us-ascii?Q?20wrBvfOO/H+bY8CQX7mhNVADZgIh5tp+rWGJ3qxIbsJmPymgdS6mwWlCr76?=
 =?us-ascii?Q?Bs8Ws1lOcuxUiev83F5YynMvmT1gCWrmxjQ11TTlrMDbJI5CsFvAuAucND9V?=
 =?us-ascii?Q?+RfLf2uCqzWwcu4pd5eGb1D8hzYuqVzil6UcfU6uwWO27lmbS9AZrDQta4X4?=
 =?us-ascii?Q?OWE1R86YFcpc1gV/r0O0zexWL7EfwoUWpsjuqE/zi2XucJqycrUXytZOtwSu?=
 =?us-ascii?Q?aCGqgEp3O9plsEXVwbLNw+wddGe2NUkhn2upof5+yWKwHWi9YZ5/69TPv/o6?=
 =?us-ascii?Q?R/IEBrniOlmr6O+8uVjV8umZ+gEz3vB776bkyEGrIAdfoAwH7pcR+nowGEtw?=
 =?us-ascii?Q?NDVYJJYN5KAo73pdOfLOQW8NLZ3W6j1/ODa4FtqEpnkZrHkuu5xMEP5mQYaP?=
 =?us-ascii?Q?rYZxhmIcAdXDzpZgH8RxCHQLNMWm6CjnWOan8XWVeE4p4lm7paXgR6yrGtpH?=
 =?us-ascii?Q?pS2ApXryJ0UsAXzTXfvtFvWfE2hlR5N236LnUE3misAA6haZsPWHm0402SLi?=
 =?us-ascii?Q?jETRwYmPM4TdWLF2cb3sqQCY0/khY0kNTAOMS4J0GGsbor32iVC/KGjNv+0/?=
 =?us-ascii?Q?Z3ytg2L3Q+3Nt1aJZwtT1ZkZlrdsxceoK1k0mc1ntQVQDBXq8K1LaF8VbH0t?=
 =?us-ascii?Q?15GR9ZwIew8PuLLlYML9jG6Ktmb0PUKhgcqIUmfo2TcliVH3oBaAZOGXyv/5?=
 =?us-ascii?Q?DgnygFZdsuht2By25xAsiDjiEezFgdtam9/pGzknkTxuwqNpNLfaWYsy6Ta8?=
 =?us-ascii?Q?FpL71EDt9MtJ5WyxPQwrpa10cuxL3PBPzECIHCxcwD6voyZCu+SWUHxbkPAD?=
 =?us-ascii?Q?5njMTaOhEAFq/4+HcZjMRHC1NXKaZC2T3besZf/j8kv08PEt9+h3LAoTYLHE?=
 =?us-ascii?Q?+dJDqAQVBMM7D/54ugkaK2qXhnRQqVII9zF6hhCMZxraU766Wa2ld7hB5Fgb?=
 =?us-ascii?Q?h39UO0xXV9Qr9oKtkxhAiZEdiQXwD0HVzgv+1MVjh6RRhfDK5wGSzpLYG7QJ?=
 =?us-ascii?Q?eSF8yZXK7RSG0+BoDMLsDtWeO0+zZVGU4NK7w7VjUFjpUMvjW8v0Pa3ZwHYR?=
 =?us-ascii?Q?shTUekJ4sOb5Dmhbd0wKTSe/+ekyyoU+dzQCOG9mlGZpOFW5d5FFo46ERv5i?=
 =?us-ascii?Q?m8EjQ9Acc7SajyZHhAVJ2PCztIpUSZP5BNKwlfoZl5YnjtO+ORgfuctOqzj/?=
 =?us-ascii?Q?r4d/jPJZDdWd7rfbhZllXCBdk1LtJKX9Nna1t2zztPCFmCsBoMzvi7j3hN1N?=
 =?us-ascii?Q?VmlAx8TzmhubVeXZ5kmuSLAKXQ/AOL4XBO0Bi4q0sgpRmom37YL2T7IrrGsB?=
 =?us-ascii?Q?kigXm6Hbm6ZtQxHpYgmZfcQdnDiGlKMSyKAQL8ICfeGdXICf/tg7297xq/nQ?=
 =?us-ascii?Q?ng+x9Otr02shGCsHVzLB33SvILk2p5Sq?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 13:40:18.0226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b6025e-608b-49af-510c-08dcdd6797fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8770

AMD SoC has HID2 SPI controller in addition to the existing SPI0
controller(AMDI0062). Add HID2 SPI controller's ACPI ID AMDI0063 with its
version ID to the list of supported devices. Use the version ID to
differentiate the register offsets.

And, the AMD HID2 SPI controller supports DMA read, allowing for up to 4 KB
of data to be read in single transaction. Update the SPI-MEM support
function to reflect this capability.

Co-developed-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/spi/spi-amd.c | 42 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index 00fcec903d91..f146366a67e7 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -38,6 +38,7 @@
 #define AMD_SPI_FIFO_SIZE	70
 #define AMD_SPI_MEM_SIZE	200
 #define AMD_SPI_MAX_DATA	64
+#define AMD_SPI_HID2_DMA_SIZE   4096
 
 #define AMD_SPI_ENA_REG		0x20
 #define AMD_SPI_ALT_SPD_SHIFT	20
@@ -70,10 +71,12 @@
  * enum amd_spi_versions - SPI controller versions
  * @AMD_SPI_V1:		AMDI0061 hardware version
  * @AMD_SPI_V2:		AMDI0062 hardware version
+ * @AMD_HID2_SPI:	AMDI0063 hardware version
  */
 enum amd_spi_versions {
 	AMD_SPI_V1 = 1,
 	AMD_SPI_V2,
+	AMD_HID2_SPI,
 };
 
 enum amd_spi_speed {
@@ -182,6 +185,7 @@ static int amd_spi_set_opcode(struct amd_spi *amd_spi, u8 cmd_opcode)
 				       AMD_SPI_OPCODE_MASK);
 		return 0;
 	case AMD_SPI_V2:
+	case AMD_HID2_SPI:
 		amd_spi_writereg8(amd_spi, AMD_SPI_OPCODE_REG, cmd_opcode);
 		return 0;
 	default:
@@ -209,6 +213,7 @@ static int amd_spi_busy_wait(struct amd_spi *amd_spi)
 		reg = AMD_SPI_CTRL0_REG;
 		break;
 	case AMD_SPI_V2:
+	case AMD_HID2_SPI:
 		reg = AMD_SPI_STATUS_REG;
 		break;
 	default:
@@ -234,6 +239,7 @@ static int amd_spi_execute_opcode(struct amd_spi *amd_spi)
 				       AMD_SPI_EXEC_CMD);
 		return 0;
 	case AMD_SPI_V2:
+	case AMD_HID2_SPI:
 		/* Trigger the command execution */
 		amd_spi_setclear_reg8(amd_spi, AMD_SPI_CMD_TRIGGER_REG,
 				      AMD_SPI_TRIGGER_CMD, AMD_SPI_TRIGGER_CMD);
@@ -375,6 +381,7 @@ static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
 	case AMD_SPI_V1:
 		break;
 	case AMD_SPI_V2:
+	case AMD_HID2_SPI:
 		amd_spi_clear_chip(amd_spi, spi_get_chipselect(message->spi, 0));
 		break;
 	default:
@@ -418,15 +425,29 @@ static inline bool amd_is_spi_read_cmd(const u16 op)
 static bool amd_spi_supports_op(struct spi_mem *mem,
 				const struct spi_mem_op *op)
 {
+	struct amd_spi *amd_spi = spi_controller_get_devdata(mem->spi->controller);
+
 	/* bus width is number of IO lines used to transmit */
-	if (op->cmd.buswidth > 1 || op->addr.buswidth > 4 || op->data.nbytes > AMD_SPI_MAX_DATA)
+	if (op->cmd.buswidth > 1 || op->addr.buswidth > 4)
 		return false;
 
 	/* AMD SPI controllers support quad mode only for read operations */
 	if (amd_is_spi_read_cmd(op->cmd.opcode)) {
 		if (op->data.buswidth > 4)
 			return false;
-	} else if (op->data.buswidth > 1) {
+
+		/*
+		 * HID2 SPI controller supports DMA read up to 4K bytes and
+		 * doesn't support 4-byte address commands.
+		 */
+		if (amd_spi->version == AMD_HID2_SPI) {
+			if (amd_is_spi_read_cmd_4b(op->cmd.opcode) ||
+			    op->data.nbytes > AMD_SPI_HID2_DMA_SIZE)
+				return false;
+		} else if (op->data.nbytes > AMD_SPI_MAX_DATA) {
+			return false;
+		}
+	} else if (op->data.buswidth > 1 || op->data.nbytes > AMD_SPI_MAX_DATA) {
 		return false;
 	}
 
@@ -435,7 +456,19 @@ static bool amd_spi_supports_op(struct spi_mem *mem,
 
 static int amd_spi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 {
-	op->data.nbytes = clamp_val(op->data.nbytes, 0, AMD_SPI_MAX_DATA);
+	struct amd_spi *amd_spi = spi_controller_get_devdata(mem->spi->controller);
+
+	/*
+	 * HID2 SPI controller DMA read mode supports reading up to 4k
+	 * bytes in single transaction, where as SPI0 and HID2 SPI
+	 * controller index mode supports maximum of 64 bytes in a single
+	 * transaction.
+	 */
+	if (amd_spi->version == AMD_HID2_SPI && amd_is_spi_read_cmd(op->cmd.opcode))
+		op->data.nbytes = clamp_val(op->data.nbytes, 0, AMD_SPI_HID2_DMA_SIZE);
+	else
+		op->data.nbytes = clamp_val(op->data.nbytes, 0, AMD_SPI_MAX_DATA);
+
 	return 0;
 }
 
@@ -592,7 +625,7 @@ static int amd_spi_probe(struct platform_device *pdev)
 	amd_spi->version = (uintptr_t) device_get_match_data(dev);
 
 	/* Initialize the spi_controller fields */
-	host->bus_num = 0;
+	host->bus_num = (amd_spi->version == AMD_HID2_SPI) ? 2 : 0;
 	host->num_chipselect = 4;
 	host->mode_bits = SPI_TX_DUAL | SPI_TX_QUAD | SPI_RX_DUAL | SPI_RX_QUAD;
 	host->flags = SPI_CONTROLLER_HALF_DUPLEX;
@@ -616,6 +649,7 @@ static int amd_spi_probe(struct platform_device *pdev)
 static const struct acpi_device_id spi_acpi_match[] = {
 	{ "AMDI0061", AMD_SPI_V1 },
 	{ "AMDI0062", AMD_SPI_V2 },
+	{ "AMDI0063", AMD_HID2_SPI },
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, spi_acpi_match);
-- 
2.34.1


