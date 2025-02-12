Return-Path: <linux-spi+bounces-6780-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A925A328FF
	for <lists+linux-spi@lfdr.de>; Wed, 12 Feb 2025 15:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7F091885DF5
	for <lists+linux-spi@lfdr.de>; Wed, 12 Feb 2025 14:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570B42101AB;
	Wed, 12 Feb 2025 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FcXGdV3+"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2328210184;
	Wed, 12 Feb 2025 14:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739371659; cv=fail; b=VFVTFSYqbCqNf2pvsEDEx+IxOYZbkOyvKgjTCVRwybVB5adJpXLr9Y9/P7qRB3WIXcNCaQUzrTEtDb7BcG8zAzIk0dzrjXVdgYUtpCCBJf1X+o2rItsb3zavHGMQF/J/ojLhEbV0YPLmZBchwjivt1vcD7j5pIe3WXtTiiaPmBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739371659; c=relaxed/simple;
	bh=oX0MGxZssgiShNkDmFMrMwLiMZiRvLktUhjMyWtvicQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uaoWaAvLhr5eCz+DCH9rjR8KZ5BiiVs//TMglqz5P4yVByvKmPqzWsSuF3JbpvaO4oGSvYaxt8R1D1mkyMM3Duy/lAr4Rsm03jPDWhPTyRKaAnABRIpx5uAuv9D+fBQiSRq3iiGozQHVkJ5mPAXbjZ4cjM9GAXDvtsStGQkYjNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FcXGdV3+; arc=fail smtp.client-ip=40.107.93.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JM5F+t4ZxO8+eWFbJxOuBEMXmJSYhLACMy0Bsu6L0TFCD/gEOcWL2vBWrTBW/KubhUe60NDbrWNR7gKkg7HzqNTL80XOlFimHhmwS5t4dzNzd0N2InpVDlRTKm8cCdylSQZS0USr49ZOTMuaW5MohY1PK37JTn3CceREuReFwju5PEM3fgqi7R2V/B+odkRUTMOwuYTYcdi2C+PKluvOE2phpa89Ig9ytY1FMPg+GllLOG7oTuJo9VpENuJ7+pwchO3SfomscVE4V2/+c4nlTns7i8HapvUu/ZqG4liroAmTRJy5n3FRzWYBYn9MNIu/9rlxykwR/Y8wA/r0NkIHvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRVl2Z0fWHRw440P898Kj6MLofA5b5yX6GZsn5rG2aU=;
 b=FbEM7tIVYhadKIPuiRwEXSlO0P+zIaxVrPp0REDguAzbLPq6gk38AoyeucJvfUsLno+p5/GsyaOXBwEeqHKNh/U1I80jcfBEaWokSe75a8RQ2sMMGsolWjWXexBFeIezVJdn6SPCeJkWAhO67kH4xEvXO48LYCUpaGMrsuIvRazzdJf1lKgbN+6BUUzL7/ihVj2OoygPJuhlS+HLvfd1nw2bm88h/e7Sc0a+zFWK/yqoL4NAKJK2GS/9SKhQx/JfXrPWqnOkbxrik8VCOas24WYhCxqukxkBCQwGaqsErppPvPZb2HCWPTA0bwkG+shSgRLkVMeTywxjky1ifGZygA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRVl2Z0fWHRw440P898Kj6MLofA5b5yX6GZsn5rG2aU=;
 b=FcXGdV3+AP1662dQsB3X6+ko3Gh7E8LbT8TCC5RxzX1zAPdIVIBqvmBEQ72dkQY2tj3uFbP4L/2bDNO8AGMJGz8uDsi4boVDGuihIpDzs1XrsG3kwFFlJdNNpJi9UdjU22B6meAxpYeS7UVKlXKIL7j5f3LaX7BLSGX1ZP7y/qozARh1OclRXeRIRtDTIKzD1g4BXZbUbsrym1ggfCDehj/cIDeEueQaRK/QXH7h+Fklq45K/ofgqlHo+E7pJErPiduIPZejl9CtVPfHHz5KoxalWXrfjckjs3EKQ+5qZpb9f9YKLEhW6U2ypZ7q7MU2GTiU7ssdhaILvDtvhkBeJA==
Received: from BYAPR11CA0038.namprd11.prod.outlook.com (2603:10b6:a03:80::15)
 by IA0PR12MB7604.namprd12.prod.outlook.com (2603:10b6:208:438::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Wed, 12 Feb
 2025 14:47:32 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:a03:80:cafe::f0) by BYAPR11CA0038.outlook.office365.com
 (2603:10b6:a03:80::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Wed,
 12 Feb 2025 14:47:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Wed, 12 Feb 2025 14:47:31 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Feb
 2025 06:47:12 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 12 Feb
 2025 06:47:11 -0800
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via
 Frontend Transport; Wed, 12 Feb 2025 06:47:08 -0800
From: Vishwaroop A <va@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<skomatineni@nvidia.com>, <ldewangan@nvidia.com>, <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kyarlagadda@nvidia.com>,
	<smangipudi@nvidia.com>
CC: <va@nvidia.com>
Subject: [PATCH v2 2/6] spi: tegra210-quad: Update dummy sequence configuration
Date: Wed, 12 Feb 2025 14:46:47 +0000
Message-ID: <20250212144651.2433086-3-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250212144651.2433086-1-va@nvidia.com>
References: <s355cib7g6e3gmsy2663pnzx46swhfudpofv2s5tcaytjq4yuj@xqtvoa5p477n>
 <20250212144651.2433086-1-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|IA0PR12MB7604:EE_
X-MS-Office365-Filtering-Correlation-Id: 731fa12a-e2c9-4935-c6cc-08dd4b742e41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3Q1PF0VFLltjJ5h5Q4xy3zGzSXRz7yISNwbz9Dsddk32p9gSZFJTOxlCo3MH?=
 =?us-ascii?Q?mOS2qQt5sl2b3KG1MRM2KhSGanDeqO5jO/6RxhF0jUULORHRbZXM3eVqKRb/?=
 =?us-ascii?Q?6HycovCJTYHKSyQpzI0/eHfqubpUH5cQ6N6TpMvG12B3xvyMl3WaqLJhwwtV?=
 =?us-ascii?Q?aZllQolDPFvRFwu4pYikY+ZssDNuAamk/To16nDQJtJAu8UMG6o+5/8Ebqly?=
 =?us-ascii?Q?BwiqcfXb7eXIXD0xBZJ5+YiKjhwkNmIGgw4NEXO3kZesCqyio7fTLvzgESUT?=
 =?us-ascii?Q?2/X4P9vxOt72VcRbuMqt26NC5qTHGzUzYNU6tJFPO/90nt/ojeT0jVhDHew4?=
 =?us-ascii?Q?IQ9dJmEgJgk6Y7JFe6huG/W6VtrfuzfVbLnEvqVVwe1Ms0XftC1R73UgIWmp?=
 =?us-ascii?Q?qJOcX4As4hcjl7QkaRVXzfVbbp9WD/QeYgS4YG8XdHp6F6LotdcE0bZoqoGb?=
 =?us-ascii?Q?wInuejWRRgGMdSFXYR6VxZAKV5B8iV/1+IWL6Xq/whco0/r8cbJ/BofhrLhd?=
 =?us-ascii?Q?NXOecfvD7jtrLxIQP354Gj1/jKdzRI1TFun4BGa0Oh9mSbNG8t979vvoz4/X?=
 =?us-ascii?Q?ar11STnmKhOYMlPywkfRuKQY84L2H8aMyCc3aMLLdgek0j8XT0QFwYWdvhSE?=
 =?us-ascii?Q?ySYHZIxi0wwu6NFg8IzUOHlZCi+KnkSifCenvoIe4H6WC48UdvEI6mS8uQUw?=
 =?us-ascii?Q?ZmUCYKttM2jCIG0UVQVURlY52LeTtIcwXqFs9hX7Ox/MV/jBNefnndwdYcNr?=
 =?us-ascii?Q?iInXZ3OcdfOLqe3zpaFJOHFHM5Nf4o8JE2HXV5mVfflQU9qeVWdDThA4HNO1?=
 =?us-ascii?Q?DKZSbyPoLjCmjTyoYYiXCaORwkZvLk99D62tCUeNDvbncQwUVnpwqm3nZBFf?=
 =?us-ascii?Q?GdcfF2lp3c1mwzmNA03CXG3IpPiNANZF1spN5XliMEprvdy3ru9q1SlfbLE+?=
 =?us-ascii?Q?hinBX8iH3g/PvFyHaVsw9PoF20+4V3GkkBpCg0MN5BLzJJj0y1hmmjgeDJvY?=
 =?us-ascii?Q?NkRkTZJOVvE43okev5lWefP1diDl3s9aYpfEzIvBQGbXUIwe3Upc3GLoNch+?=
 =?us-ascii?Q?/AXZz+r7kUJQ/4KAvhxR8CD/+d4cquxvVpFdBOCjTBnYhzqSSkWCkjHpyMl0?=
 =?us-ascii?Q?fddmgCRlRN08qEh1+j6W6d9WAl14LvXR+fg6MfUniWd+qgoRh5Ju8jrqCbD+?=
 =?us-ascii?Q?EUHCVMuHv8Y8qs8sJJrVKE+QYPyXYNYKM1NUxwCBuH5YFRlouVenagqqUfrf?=
 =?us-ascii?Q?0KNEDEfDvR8zVQmRjMCdP3tu4Z3Y1ROAqE0W71ZmPcS17zXOnna+DFBMjvko?=
 =?us-ascii?Q?VwTNTiWkG6JUPvtVTIiDcq3UB9yRAuZyuNTf58pDdTTdRhloZ97yFAK+y742?=
 =?us-ascii?Q?fdLkMnZsomol6S31q0l8FWpbMY5uHefWImffeDxpXEGtvFpvH4EcYuyQ+tmv?=
 =?us-ascii?Q?rD+eRZiB93XvwVAruu7BVGvcS9zX7JV6b9vIARpO/c8y8G1Eg97bbIGrt1Ob?=
 =?us-ascii?Q?fIo50GnFCXiINa9A4ZUFOK1lRiqBePFiSLd9?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 14:47:31.9736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 731fa12a-e2c9-4935-c6cc-08dd4b742e41
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7604

Adding support for the dummy sequence configuration. The dummy sequence
introduces a delay between the command and the data phases of a
transfer. This delay, measured in clock cycles, allows the slave
device to prepare for data transmission, ensuring data integrity and
proper synchronization.

Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 08e49a876894..02478e8efc8f 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -22,6 +22,7 @@
 #include <linux/spi/spi.h>
 #include <linux/acpi.h>
 #include <linux/property.h>
+#include <linux/sizes.h>
 
 #define QSPI_COMMAND1				0x000
 #define QSPI_BIT_LENGTH(x)			(((x) & 0x1f) << 0)
@@ -156,10 +157,14 @@
 #define DATA_DIR_RX				BIT(1)
 
 #define QSPI_DMA_TIMEOUT			(msecs_to_jiffies(1000))
-#define DEFAULT_QSPI_DMA_BUF_LEN		(64 * 1024)
-#define CMD_TRANSFER				0
-#define ADDR_TRANSFER				1
-#define DATA_TRANSFER				2
+#define DEFAULT_QSPI_DMA_BUF_LEN		SZ_64K
+
+enum tegra_qspi_transfer_type {
+	CMD_TRANSFER   = 0,
+	ADDR_TRANSFER  = 1,
+	DUMMY_TRANSFER = 2,
+	DATA_TRANSFER  = 3
+};
 
 struct tegra_qspi_soc_data {
 	bool has_dma;
@@ -1089,6 +1094,13 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 							     xfer->len);
 			address_value = *((const u32 *)(xfer->tx_buf));
 			break;
+		case DUMMY_TRANSFER:
+			if (xfer->dummy_data) {
+				tqspi->dummy_cycles = xfer->len * 8 / xfer->tx_nbits;
+				break;
+			}
+			transfer_phase++;
+			fallthrough;
 		case DATA_TRANSFER:
 			/* Program Command, Address value in register */
 			tegra_qspi_writel(tqspi, cmd_value, QSPI_CMB_SEQ_CMD);
@@ -1300,7 +1312,9 @@ static bool tegra_qspi_validate_cmb_seq(struct tegra_qspi *tqspi,
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 		transfer_count++;
 	}
-	if (!tqspi->soc_data->cmb_xfer_capable || transfer_count != 3)
+	if (!tqspi->soc_data->cmb_xfer_capable)
+		return false;
+	if (transfer_count > 4 || transfer_count < 3)
 		return false;
 	xfer = list_first_entry(&msg->transfers, typeof(*xfer),
 				transfer_list);
@@ -1310,6 +1324,13 @@ static bool tegra_qspi_validate_cmb_seq(struct tegra_qspi *tqspi,
 	if (xfer->len > 4 || xfer->len < 3)
 		return false;
 	xfer = list_next_entry(xfer, transfer_list);
+	if (transfer_count == 4) {
+		if (xfer->dummy_data != 1)
+			return false;
+		if ((xfer->len * 8 / xfer->tx_nbits) > QSPI_DUMMY_CYCLES_MAX)
+			return false;
+		xfer = list_next_entry(xfer, transfer_list);
+	}
 	if (!tqspi->soc_data->has_dma && xfer->len > (QSPI_FIFO_DEPTH << 2))
 		return false;
 
-- 
2.17.1


