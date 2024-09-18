Return-Path: <linux-spi+bounces-4846-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AAD97BB1F
	for <lists+linux-spi@lfdr.de>; Wed, 18 Sep 2024 12:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03D891F21773
	for <lists+linux-spi@lfdr.de>; Wed, 18 Sep 2024 10:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1413617D8A2;
	Wed, 18 Sep 2024 10:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GPIMV4+g"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7839B178376;
	Wed, 18 Sep 2024 10:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726656862; cv=fail; b=XM88fC4xD8wyHZL8Nb7/Gk012exmpI40YhWk/+yVJDJU4/6rmKL0L+jGQVFXh8hG+B8Fu8d+rS82JRFGQhmP4/jX0nOLia5yPEu8M4B1DGdNnt48zKDoPmBNtBikxULgwoFcNFh6Dq1nHZjtHL+IcVfRnpn/bIUGNbfjYE44zc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726656862; c=relaxed/simple;
	bh=vYDKKnfB9w5qac+/ZQ7tvpqxzzxMukj4FqkNFxQAIXM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ex9eRYErNzfh5YqSkm9D4FRtdtowuXsY7EhxYk0LeWDSYF8Ocq//spF8dupJEP5HK6QOAl1DZ9qruQxbU6NgoQsts8bQ/GBaIBpJNJeB9/EVZIt2BkiO8UJPip4Qd/u1o5SR0mT+QLoFfkHbvpKmuqgfDbpg8XbeDqIHbu5fBAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GPIMV4+g; arc=fail smtp.client-ip=40.107.223.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jfW90NggLSN8NQ6zN0abDpSu8oIZTexbYM25vQW5P5ZqW3W6MXhQngNfypP/1iSIF+0L8XLd6M7GQ2HvuOnQ52jaVLnCWysywuftmju2oskztC+xLNnYKDtLHH3bYslY+ZCbAnGsMBMLsRXmRr4oCTz1R7gdmj0gaqdIUcebtbIYVc+we1/lVtWSMI3Tfye+b5dWjbzUx8MZA7ZO7gw6Q/jY2EvEIRLg8Fn8sYiLxb9vLSb74+t6BDbucs8bRJXPAm8b/SxSir98c4qNZnLSg/7O+i3s6FpO7U/RYrju9UXDOqfmPVvLO5ClX+H8P1tx42si+Bd9yA9gAwgWOIkaiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXz2HlODMKvPhBYThJd4gvh+MWtaaRtWEU2buR7PSlU=;
 b=k6wDRTtzKsJhkHNQIgHzGKP77f00uEI9ATLm9vimGgQyVz75TR1hHs3Fj0Ep6o2nP+vTTkPrEx3/9ubMOP9AI2DVM54cWD1wpjFCB1txNVcI8jUw9RJEJdvju70Y2bn+ikWSxJMxNz206HJ1AXmR5iXTTpr9o9TfXtYRWUxNaDE2otQQsaVnd1oWGIVhcRl2HsCmcriwlx4o/XkY1eQeeJeSxIkImU3+JcC3Oq0Rio6WDKiKVkD7sobjbxdtd6xfdSeFdZvmSq2i9hilxwjVme7DP4qcAeTnb9S3xPZBe0ImRydgirKVR/d6ZdlkfMr2K7TaNnKX4AObu20Z4C3VyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXz2HlODMKvPhBYThJd4gvh+MWtaaRtWEU2buR7PSlU=;
 b=GPIMV4+g0qqQ2SItin0UzzhXvZgUy0Br8L6yx1tqkU3qVVyZ/qL5bVsRol4EinfSXqicW3y/fq/YYbG4o7sPMnyN3ikyY45jx6WTtWyKP4z5oP1EOxqpE4CrHq8i7yvbUqJcvGUvull26qf4u7v4sO1by4ad1I9IfcSz5BtPlGw=
Received: from CH0PR03CA0024.namprd03.prod.outlook.com (2603:10b6:610:b0::29)
 by SJ1PR12MB6241.namprd12.prod.outlook.com (2603:10b6:a03:458::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Wed, 18 Sep
 2024 10:54:17 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::c5) by CH0PR03CA0024.outlook.office365.com
 (2603:10b6:610:b0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Wed, 18 Sep 2024 10:54:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 18 Sep 2024 10:54:17 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Sep
 2024 05:52:21 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <sanju.mehta@amd.com>,
	<krishnamoorthi.m@amd.com>, <akshata.mukundshetty@amd.com>,
	<Raju.Rangoju@amd.com>
Subject: [PATCH 2/9] spi: spi_amd: Enable dual and quad I/O modes
Date: Wed, 18 Sep 2024 16:20:30 +0530
Message-ID: <20240918105037.406003-3-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|SJ1PR12MB6241:EE_
X-MS-Office365-Filtering-Correlation-Id: 7db637da-2358-45a3-6d31-08dcd7d03df5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JcBSao6xfF0xfnNiJaaLOolcEek6FjHFRTZMqqe7GWgNrP1BKGfGCnKpBGqU?=
 =?us-ascii?Q?rBWctD2GzTMzc4/r7WgoFWFpBgnV7yAitF8MaZzjtjCycY1LUOrXyG9/Puyt?=
 =?us-ascii?Q?4WJRhFIdoiJxfDE6rE4K63iSk8Ol76sKWhfHIEGOFL6h8z4+YfwgXbm1KP6d?=
 =?us-ascii?Q?5rkXT0Yi8c8izrgzotfG3r3nOwmyimiJjbxlHkhCgR2673GfluCC/rDCen3l?=
 =?us-ascii?Q?th1cnGy6mo2BN4inhYtlqIqAb1OS9ZbD2Jp6T4RuO4Xa/pBfAIKqOPzPaM6m?=
 =?us-ascii?Q?7+x3nhC5wn0jCOcex60BagkPja/rMO4l2ReX4UlUoSnimMklGo/jXL+PxL0f?=
 =?us-ascii?Q?Ii02CgIc1il8Zal8of0rbvMWxd2U57kthRnnhiiM26lXAv89pcLbURldxp45?=
 =?us-ascii?Q?EyDYH2e7Wd8nS9azagQpELSTyVn0+oxxoDiMoiWjGTZ+xkJ2WKX5F0QXrNTT?=
 =?us-ascii?Q?/Aurbzzm6h4Ju34wmTbcALXlOwFqw/HYwKEAv9GX0zPNY6dF2wEqKYZouNm7?=
 =?us-ascii?Q?ZiuQUEcLBxbXIrXyKYulAPmI0Uwtf3Bkm4iAivZXoPCmfdT9XLbNFVVEnLHY?=
 =?us-ascii?Q?iDccRemP+wbxRBJZM/7gxcXHnoYRCRkMaRFmo2XL7UxuNSG6j27tesynG2CA?=
 =?us-ascii?Q?kccBlZ1USvpODVAvokfBgo1HeK9gMJyD8znYl7/0qhUGhFvFQWpXuDTjlCad?=
 =?us-ascii?Q?qcIZ8iWayX90WJdBj4Bf37hpm9Xiqc7aK/JNDKKQaWoI5dP7Zx0GoVNTKHI1?=
 =?us-ascii?Q?2UVGp7X0qAIbAXSaTITeo2QgKm2cALmDsUDP5+9MY8xKYnBSwR0uaVv/M+eo?=
 =?us-ascii?Q?2wjH/bbp/gR0crTNklEIYKKlxnMdlTxfu35Y58dM7dHxgi57ogk6r+U9cXjq?=
 =?us-ascii?Q?GSotGNdPSQK3dcjs9TFXCXK9Ype6nes3kO1Pe9MeZGyhSiG0af+PAX/0qtP0?=
 =?us-ascii?Q?/WluneZwEjm3WPhgiD7qG9a1DXGDDBvbfmwiZ/9ZqW9f5wOaURISG22u9pGy?=
 =?us-ascii?Q?ZwI70qpVRdE7Lwdu/mN6/Itz0RUvrcjaZPx84oVUwyhYF5g8TQvDlLWCUbTz?=
 =?us-ascii?Q?d4SQI+JKnyXAOmmVPptW/jAIBMsQp9w7jOCPzF/0NU7tBlDcar3gik9/DG6t?=
 =?us-ascii?Q?V/bgau4lto3yt+g2Rixzun0HQmPQ0lRIeu4tzjDD7qTSuSh/FKO6ubAxshAs?=
 =?us-ascii?Q?JFUWvFpjzG45wj8u5P5Ae8PsjMKiMPNGTTzx4ELHx3V8dOBD5EFeLloYoog5?=
 =?us-ascii?Q?l2p6CFnQrJGzAhDrLRWSQXnKcxXv04EKZOKTkCAwjPLjH210L6wDO94Zir8/?=
 =?us-ascii?Q?YOBWn77TGrOEUXqBrwnoavfNe3qmC1oIpjyPO77rjOuIyvvvhmxcbqPH8GLz?=
 =?us-ascii?Q?lYpgjNqmeprSGohq6rZ4bY+/FyeF?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 10:54:17.1494
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db637da-2358-45a3-6d31-08dcd7d03df5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6241

The current spi_amd driver only supports single I/O mode, despite the AMD
SPI controller's capability for dual and quad I/O modes.  So, add support
to enable dual and quad I/O modes.

Co-developed-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/spi/spi-amd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index c52066360dfe..54b5a4d18691 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -364,8 +364,8 @@ static bool amd_spi_supports_op(struct spi_mem *mem,
 				const struct spi_mem_op *op)
 {
 	/* bus width is number of IO lines used to transmit */
-	if (op->cmd.buswidth > 1 || op->addr.buswidth > 1 ||
-	    op->data.buswidth > 1 || op->data.nbytes > AMD_SPI_MAX_DATA)
+	if (op->cmd.buswidth > 1 || op->addr.buswidth > 4 ||
+	    op->data.buswidth > 4 || op->data.nbytes > AMD_SPI_MAX_DATA)
 		return false;
 
 	return spi_mem_default_supports_op(mem, op);
@@ -514,7 +514,7 @@ static int amd_spi_probe(struct platform_device *pdev)
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


