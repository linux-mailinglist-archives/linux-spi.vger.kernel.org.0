Return-Path: <linux-spi+bounces-4849-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 594E197BB30
	for <lists+linux-spi@lfdr.de>; Wed, 18 Sep 2024 12:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15833287ABB
	for <lists+linux-spi@lfdr.de>; Wed, 18 Sep 2024 10:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340F1188583;
	Wed, 18 Sep 2024 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZYY9SaY+"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9947E176FA7;
	Wed, 18 Sep 2024 10:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726657124; cv=fail; b=QR4mpGFTrEpVHIopr+AQa/iGOEQy31/EenKBAXEgEfU4dfeWC+Ur3rptPLlHgcwa6ntbsVpN5ELZ6jwoenM7s2rVGj8czT9nsraKVyPelBgnSNKQG41O38YzUz+vhy5t29l3nS51obNa0ePWT8f8yOGrhJ3cwjfC2ZizhFYHkrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726657124; c=relaxed/simple;
	bh=GTEB0hSc6lokI4JthlGyfeBfkMPsn/4wuULDM4MTIys=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rvk6QanETOo3R5Bt2ARFUGfOG5K2TOIMbR2BCv+6zbNh+cfIyqMQmKszec/MznFIhOMx1fDhEFgNiI0FXgZ1+uqJxmDH5y14Ju9YT2Ibvm/b3vWtYarhHwopLsNKmj9RkX7vruhcgdb1ka2MwLj/dlAb3sXxuO1ucJQa6opSyIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZYY9SaY+; arc=fail smtp.client-ip=40.107.220.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TR/v1cWzisMHnhGBUZkHCbcJ28PVPeABmuS5/1R3NsOsSRH7KLOXt+DB6qo5QrlP4vCP6H8YKKfTz9CE0t6ow3F/pgNw9wWPp/Y16FhsNxpUMcNfbWkFsTFZO4aAgem7NEnNhTxc4DZWWx24fxGTuHhJ1YwSMeCn4HgfrL9pLLJ+8jnyWAlJAEybCyVmlYGV6BCQDyVkcyxObp3ijCOoMH9DvE8UOITAStp+mvITBEV4iPVnOkcrVXqUBBw5DkFtM8HW7W1aNWf5IeOuPsiSDiQYHEWOO63NHSvXAYeIp+SVVOUh1kH8xOydEgAR+iN83OoQ+gMJNWuMIlXLU//BVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Zk5bzjxXe38tkBgkq+G12wp+tE6uPbl9cv3Yj2wD3w=;
 b=vDgh+SVgfAwid3hw4EQTPKPmK3UsqtK6dcxos5J5wjBkvGy9wFxjGSEQDKN/JAyPLNFVyYAi3Ffn+CalOegFR9sg2tSP0JJ7qw1Rv1qPqLVk6JXNeAgEZ8exEheMJ7aeV+fbDQkVg2dUsTznLaTYUAyg6Oc1BRx9OeZYzbc13F5hmgNfaccsIOHAYwk2jiF7kreNoP7wjDNNWTtRyZApTv9oHsIYLKUWph5mVdANz1JofXix5q0aLM88kATqdUrPRtI6IaM+JPxgfO13bGZzN9IghkXOeiRnEknfNX9tcu9JlRU1A7gWQHvRx05kFIM9+dzpfPtc33hydzIJ20a8kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Zk5bzjxXe38tkBgkq+G12wp+tE6uPbl9cv3Yj2wD3w=;
 b=ZYY9SaY+O2E664PuvgI2Je5VDwGtwVIPlSypyAHmgr7qmNonbkQdo/YWwitUDAxSTpufcGKRHXvLnUV50kiDZvzSgYXwECcxpkZiFjoJhZ7fHgGix1dYfaIx5qU4soW/HTD2iB8XHOc2HrVeoBoRTtOhkIpi82XB6Cu0ypuOa/c=
Received: from BYAPR08CA0056.namprd08.prod.outlook.com (2603:10b6:a03:117::33)
 by DS0PR12MB6655.namprd12.prod.outlook.com (2603:10b6:8:d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Wed, 18 Sep
 2024 10:58:39 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::d0) by BYAPR08CA0056.outlook.office365.com
 (2603:10b6:a03:117::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Wed, 18 Sep 2024 10:58:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 18 Sep 2024 10:58:38 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Sep
 2024 05:58:33 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <sanju.mehta@amd.com>,
	<krishnamoorthi.m@amd.com>, <akshata.mukundshetty@amd.com>,
	<Raju.Rangoju@amd.com>
Subject: [PATCH 6/9] spi: spi_amd: Add support for HID2 SPI controller
Date: Wed, 18 Sep 2024 16:20:34 +0530
Message-ID: <20240918105037.406003-7-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|DS0PR12MB6655:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f82eb01-cfc7-4ead-7352-08dcd7d0d9f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x4YeR7PjZHy+begxv092hFChQM5e35d7CR11H2fWa4p+EkVvPTk0srcgIAKq?=
 =?us-ascii?Q?Qte42YyFSbzckSOgbq6B2CqJXUgdMOc0+WMQgaoX7qg5CDiOG7GDhYPa/9Zw?=
 =?us-ascii?Q?1cB6kgV0rCp3LSAbeEsF5vy0wtzG3z3cGxgBy5WLWwQdBWl18qxTaxE5ukmo?=
 =?us-ascii?Q?UVxtpeT/dKtEjm9rOWKVu6otVXjSYFmD4ABlOdm9ui4EHFGqtBeDzGRjmJJE?=
 =?us-ascii?Q?WZmBHStsMW8AZ4H10cWJrjc/50Bsk6/JebbeodqZtGxcDZ7Y6Uv/Qr0cwkiM?=
 =?us-ascii?Q?BO8Zg448142v+ouqPCq9NSuRwfK/ad9Jqd3vOHj3wRZeKxmYZ9BBqqKW+vzn?=
 =?us-ascii?Q?tUSPOgy+m2PmQi2k6AZAweqIAchZFXSZzhrWLEWQQDEhiHMPPZ7qLdQbt1uH?=
 =?us-ascii?Q?v0xsNDeNP6Mhz7ihNn5X2Td5ju6ATvTxsKL55JW/XYty24GLLQjxpQQ+NXsi?=
 =?us-ascii?Q?X3BkHtQO6rszGsnePph7OqDLoWSjJi0MjNfSlSllQFXgfb9X+Vm0i7bAbhdm?=
 =?us-ascii?Q?oMJbtSxxnP2EpWx/ewThPC4qp+mSxyiyDVdpRXfWtDhtIFvUWliCPPTB6hVG?=
 =?us-ascii?Q?O9nSe8njePx89AzRyURX6Unc8+s0yjcznbv0rHFl8IXX/mso/IDVE5s+ASeZ?=
 =?us-ascii?Q?AUMYQU3kP00lkdiZuXi6Gt61cpUUCdi7xDH1rAGsU1BRqEpokPiHrR6WltpG?=
 =?us-ascii?Q?w0iAc4lq9AgHw/E7Y+cHoUhYbh0/Pqp550X44tRoG+9sTkqSPmCwD2tQ+LTf?=
 =?us-ascii?Q?RjtRFnovP7YhSTC6lBijGTNiXqZVwbe6cdW+bw8+4Xg1EU3swJ653H2bH/Tx?=
 =?us-ascii?Q?iNlLR4arC/b1PVL8wHX5KXbWrgBuqyw5EkkOvQtD5H92Tf6uBm8LlhFzsBwR?=
 =?us-ascii?Q?e9WdrrxJW7SjxO1nXuZlRkqvaghtK3ToJwudEF1FVWk0y7MvuOR2qjQRdS+9?=
 =?us-ascii?Q?AYfspZ7Ya621a5JIYKYMaKHxGxaplYfqWf91S72JhwQROCIab1Ds4HWkNmF9?=
 =?us-ascii?Q?gee1fJJTN2XhKbwnk2qXAF7EgFgtsKNXOLie9+P/QusIbR8Y0uAHVyilFqjP?=
 =?us-ascii?Q?KSxVGrVD5EqEhqdac65PiFKFPf0D/Q+AUNL6XK1uK+p3yQaMUvrJMOCMu5lt?=
 =?us-ascii?Q?4tzvK/lRvqfLnVV8VZ6P18wEYePXbwPmXKi5l+/HmBm8QawPbIeoZsylrpG5?=
 =?us-ascii?Q?lQ1eoJ1olXX26/Todl/F80toymRqfqlKD2aSEzXtWRPedbYeTCvO7YxyOSgd?=
 =?us-ascii?Q?AqvIV/jlSCWv3T/V0e/oSUv42iYnH36iWQC7b9dDL0Pm4rzBsylsYInw9fcA?=
 =?us-ascii?Q?e3mykxWLxhNuWEfSD8B8iAZu1ZMogbznH6/g9MIK62NQaLSQkrFlUSosd+Ue?=
 =?us-ascii?Q?riBxUf4ov2OYo8KxYfl2dheXmkTEYV5pk94n7TcrjZ3OJXpY5A8DQvv987TU?=
 =?us-ascii?Q?7mxCVFYiNYjZBXDApNM9yQ/UgAhnFXfV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 10:58:38.8378
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f82eb01-cfc7-4ead-7352-08dcd7d0d9f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6655

AMD SoC has HID2 SPI controller in addition to the existing SPI0
controller(AMDI0062). Add HID2 SPI controller's ACPI ID AMDI0063 with its
version ID to the list of supported devices. And, use the version ID to
differentiate the register offsets.

Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/spi/spi-amd.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index c265e37cebc4..ccad969f501f 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -55,10 +55,12 @@
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
@@ -167,6 +169,7 @@ static int amd_spi_set_opcode(struct amd_spi *amd_spi, u8 cmd_opcode)
 				       AMD_SPI_OPCODE_MASK);
 		return 0;
 	case AMD_SPI_V2:
+	case AMD_HID2_SPI:
 		amd_spi_writereg8(amd_spi, AMD_SPI_OPCODE_REG, cmd_opcode);
 		return 0;
 	default:
@@ -194,6 +197,7 @@ static int amd_spi_busy_wait(struct amd_spi *amd_spi)
 		reg = AMD_SPI_CTRL0_REG;
 		break;
 	case AMD_SPI_V2:
+	case AMD_HID2_SPI:
 		reg = AMD_SPI_STATUS_REG;
 		break;
 	default:
@@ -219,6 +223,7 @@ static int amd_spi_execute_opcode(struct amd_spi *amd_spi)
 				       AMD_SPI_EXEC_CMD);
 		return 0;
 	case AMD_SPI_V2:
+	case AMD_HID2_SPI:
 		/* Trigger the command execution */
 		amd_spi_setclear_reg8(amd_spi, AMD_SPI_CMD_TRIGGER_REG,
 				      AMD_SPI_TRIGGER_CMD, AMD_SPI_TRIGGER_CMD);
@@ -360,6 +365,7 @@ static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
 	case AMD_SPI_V1:
 		break;
 	case AMD_SPI_V2:
+	case AMD_HID2_SPI:
 		amd_spi_clear_chip(amd_spi, spi_get_chipselect(message->spi, 0));
 		break;
 	default:
@@ -541,7 +547,7 @@ static int amd_spi_probe(struct platform_device *pdev)
 	amd_spi->version = (uintptr_t) device_get_match_data(dev);
 
 	/* Initialize the spi_controller fields */
-	host->bus_num = 0;
+	host->bus_num = (amd_spi->version == AMD_HID2_SPI) ? 2 : 0;
 	host->num_chipselect = 4;
 	host->mode_bits = SPI_TX_DUAL | SPI_TX_QUAD | SPI_RX_DUAL | SPI_RX_QUAD;
 	host->flags = SPI_CONTROLLER_HALF_DUPLEX;
@@ -565,6 +571,7 @@ static int amd_spi_probe(struct platform_device *pdev)
 static const struct acpi_device_id spi_acpi_match[] = {
 	{ "AMDI0061", AMD_SPI_V1 },
 	{ "AMDI0062", AMD_SPI_V2 },
+	{ "AMDI0063", AMD_HID2_SPI },
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, spi_acpi_match);
-- 
2.34.1


