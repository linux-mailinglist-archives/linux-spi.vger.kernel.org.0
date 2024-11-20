Return-Path: <linux-spi+bounces-5785-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 004CF9D3A56
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 13:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 814C91F22DB5
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 12:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0B71A9B20;
	Wed, 20 Nov 2024 12:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DOQt7Bm4"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACC919F43A;
	Wed, 20 Nov 2024 12:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732104645; cv=fail; b=LRvbgPespTc/cQj7lS5h4W5UGOfhuKdekMlT93YDX7JTGwFFGf/Fkihgxivqvbv4UMbqaMM7EaCpM+f7FJaei8d1PpGC4Poyf5Bllk9+GOyCzobbqHJ66APqp3bPqwxpqsLSRXnR0gtotERUkO6XHml685wuiRbOcFgWXjm+XKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732104645; c=relaxed/simple;
	bh=/MIMeOpuTXvUmYbn1EGDUDuHs2M16kZFqCDoI/dudZw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zqgp4AeXqRxP+HZ/bqmHE34rGgBtOvEYGXXEFD91KNqQl0xjFLA652fssg/mHk12Wmj2vww7EZCd1pa0iVEzUgLuZYUOVskdrctWvY8FulGdtFmsrSlAY8HhIqM6QXTCpy2v65GNnrb8KaU79AttLWLmspJAMYnOTMqphV13tiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DOQt7Bm4; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jBslHTf1AW/mctYwTr0P29Fo2sKcjXl9yPX9//lVa5ROkMhQVatEN90EWDmfXu5GP8YdtGVOMnjTiDffQGyppnHbL3rjgMy0UrfM4P1NKlptEDnRGDPxElowdbDdX4LqoZK8+9cnPMIyrh8kCzieekq1K80qqeLxWlhNTbbK9D8Ax3gfGj7LfiJBmZwFj4IdP72X73iD8q0QB+2cZGY2r5+SQaJej9m3QspmYvVzpEZiH/2lS3xfoPBjI+24N3VyBCt0kZt7BuYnXT3uaW1e6GFp+HGbvbveOaJGLh7vcNq5dTw77mv786dET6lYyYxmto5zwoohWJoYafzxa8SgMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7VgfESRWb4sp96rlGBbkrY5aqY6rkYqzWmGYpBEwuw=;
 b=npZGR0R6hEqvwwBRtpuHJJliXLNHROC9Ns8CTBNcrw92O2VEVInRIBCgfWzAhO4QFYsFpJjal6JVa2jG5QVxnigUjEWZMRyNYQ9/EHZJpttSa9vt1vA3RexF9eOiRFPKHr6SFGojf6miR3nxAHlthrxh6e/6CHkQ6SC6XS2r9ehis00gFjKvf/I00nfyDIGiLQrvgDICeTd5sALQVNaCEGh0yQ5FFyELSJbgLWP9R0ZBuQ/C2ut3oCATlD5Ho3UeXRJtisHDbuJCHvSKjGTskHDEcUKG8Rkxwx+KPbbnpn9pFQEnx0S9qk7R7I5z4WAkHb/nd/HswwoMAUXFiOBBrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7VgfESRWb4sp96rlGBbkrY5aqY6rkYqzWmGYpBEwuw=;
 b=DOQt7Bm4tIwOG9U0iWu3K/Py4ZQdQTmaNP06i/r1PwBvXlHMAKnLb5sMa6D+oifMOAZEKFR7JbX8djlkq/S/5JArafU5FT1OtK1EvSNzDc9K67G84Rvmwb3gSouWt4elkwJJvR2eidMpn89qeoe+Q5jv4UkAlEQL8/x5A2WSMSg=
Received: from SN7PR04CA0110.namprd04.prod.outlook.com (2603:10b6:806:122::25)
 by CYYPR12MB8892.namprd12.prod.outlook.com (2603:10b6:930:be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 12:10:40 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:122:cafe::70) by SN7PR04CA0110.outlook.office365.com
 (2603:10b6:806:122::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15 via Frontend
 Transport; Wed, 20 Nov 2024 12:10:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Wed, 20 Nov 2024 12:10:39 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Nov
 2024 06:10:32 -0600
Received: from xhdakumarma40u.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Nov 2024 06:10:28 -0600
From: Srikanth Boyapally <srikanth.boyapally@amd.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <vaishnav.a@ti.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, <srinivas.goud@amd.com>,
	<radhey.shyam.pandey@amd.com>, <srikanthboyapally2016@gmail.com>,
	<srikanth.boyapally@amd.com>, <sai.krishna.potthuri@amd.com>
Subject: [PATCH 2/3] spi: cadence-quadspi: Use quirks to set dma_set_mask instead of compatible string for 64-bit DMA support
Date: Wed, 20 Nov 2024 17:39:50 +0530
Message-ID: <20241120120951.56327-3-srikanth.boyapally@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241120120951.56327-1-srikanth.boyapally@amd.com>
References: <20241120120951.56327-1-srikanth.boyapally@amd.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: srikanth.boyapally@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|CYYPR12MB8892:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bbc9806-1dfd-47a8-5d85-08dd095c5976
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uFfUmMm/XS0yk7kk74Wg+QGTrE/INg4xUDJgl+si69VmjzCbGDzpyBpIvl4l?=
 =?us-ascii?Q?IxMtMf8Aq/swBejELMbcvk98nE/5vaBt0vY0SDcYb8b1k9bfBFfk2GJNdjzw?=
 =?us-ascii?Q?L0Rf/Bycn+6m5dGfwUAZCdfaZhEwwCt4wT5QoG+ycYpbtA7BUrnwuMixBfMU?=
 =?us-ascii?Q?h7K9f0MUnC/abz16c/ZaHNpZEcng6/sOTawpaghoI6FIFCet9c2SqhhNtxO2?=
 =?us-ascii?Q?9wTh+AcNv2W2E1anh1shHkOTY4qP1DQ4CA+NMluAFWgMe64ZQfofx1UgrKVP?=
 =?us-ascii?Q?aYAKfDZm8svduOQEei2ESfvdvoEWlyCbKweUvQYCvXxoeoGriCmr472ug6I2?=
 =?us-ascii?Q?mAvjOvJh+bbJhJxUshGIJQrvLadaIM/HAr8FlshmovIZ3Znv7E9htjEWGGYv?=
 =?us-ascii?Q?+MJddkoMfq1vnyZRR2SaIZ7QLbvLJn7u48vepLqu4X73S3OF5W1dCZtC7AND?=
 =?us-ascii?Q?8gmUKYkckghqYmpK03DSJYvhI1NgtohGCrArvhQhs/Dzjupqv9eje/Owsqf0?=
 =?us-ascii?Q?hReztxJgzDJd/MRklnf32RhW1Er4Or8aZvqSBsrrwhblrCYTVAJp3KmM4Lik?=
 =?us-ascii?Q?UhTahk2JVUutln+OMshwfNn8Tta8jfT6+hEW7BwEt8ny11kz0rIbf+QxQN/Q?=
 =?us-ascii?Q?Z5j0EgUJpXT79lp+Uzb15OCOnItv/9eJQ3/GAh0jrVY17OC5iyJg9atQnVez?=
 =?us-ascii?Q?3Wx4niti7prVfwkIvK4YS6p+llUvbTLg1w+sYmuucveri/xtA8jqEYZo4te8?=
 =?us-ascii?Q?4//a316fMdVIM8kwpCF/Z/bINK4cBK7YypNFprmZ/a7DrGolE02MjpEZVd80?=
 =?us-ascii?Q?GmzCZxqnziUkT6Dk7RkR701Zyvi5UxS5VhSE/KG+ptPMi6bbJ0NBPUpFmri7?=
 =?us-ascii?Q?HcX0xpz+Jqton/83AQG4Ir51uLxf/5Ctj5aJHcCQ7EjPiOk+HwT7FRqKUZfa?=
 =?us-ascii?Q?uNoWav5vRMTe7K/NwFkUCK1pRPu6waxTdZ/lDEH6Rw7tTt96n0bIjctc20bO?=
 =?us-ascii?Q?A8XU6Op/gQDptfaNLAgvMR0dQEkGiQmwt3a8hi20yXvW1Ik5vKHIVJg5IDsw?=
 =?us-ascii?Q?IM2LQuuijngHRvRGHU/LOYZ+MAWgwga4C3POeHeR040WTZ60z+baEyLn0l92?=
 =?us-ascii?Q?De0qCNYqK4CLHuTFXj2gQeNBepX7lJZo53jtkM4Tw/rqNGK4l9uq36eFgiUr?=
 =?us-ascii?Q?FRrUg2qfryk6Ap19dvVftgSEAFmKYZ4udT4hxcqkZn9ij2ne3XnoaWmfEbOA?=
 =?us-ascii?Q?KNH5pxVIxUCZsnqVpDLXAx6BxFVKdBpAXxvS3FwQ3N54fif5RP17vucigWE6?=
 =?us-ascii?Q?G+YlAO589jHh3+wsYCvF38E2mAp0KcC4nuWlc3395dznOCEL5bUx5sDVUGHm?=
 =?us-ascii?Q?4o1g/S5JkaXisEbs6YgkDE+3WXIgSlniDTzfQzTxhkx7ATac/g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 12:10:39.7799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bbc9806-1dfd-47a8-5d85-08dd095c5976
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8892

Remove device compatible property check and instead use
quirks to program DMA addressing.

Signed-off-by: Srikanth Boyapally <srikanth.boyapally@amd.com>
---
 drivers/spi/spi-cadence-quadspi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 1755ca026f08..fb75400518e0 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -43,6 +43,7 @@ static_assert(CQSPI_MAX_CHIPSELECT <= SPI_CS_CNT_MAX);
 #define CQSPI_SLOW_SRAM		BIT(4)
 #define CQSPI_NEEDS_APB_AHB_HAZARD_WAR	BIT(5)
 #define CQSPI_RD_NO_IRQ			BIT(6)
+#define CQSPI_DMA_SET_MASK		BIT(7)
 
 /* Capabilities */
 #define CQSPI_SUPPORTS_OCTAL		BIT(0)
@@ -1881,8 +1882,7 @@ static int cqspi_probe(struct platform_device *pdev)
 				goto probe_reset_failed;
 		}
 
-		if (of_device_is_compatible(pdev->dev.of_node,
-					    "xlnx,versal-ospi-1.0")) {
+		if (ddata->quirks & CQSPI_DMA_SET_MASK) {
 			ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
 			if (ret)
 				goto probe_reset_failed;
@@ -2048,7 +2048,8 @@ static const struct cqspi_driver_platdata socfpga_qspi = {
 
 static const struct cqspi_driver_platdata versal_ospi = {
 	.hwcaps_mask = CQSPI_SUPPORTS_OCTAL,
-	.quirks = CQSPI_DISABLE_DAC_MODE | CQSPI_SUPPORT_EXTERNAL_DMA,
+	.quirks = CQSPI_DISABLE_DAC_MODE | CQSPI_SUPPORT_EXTERNAL_DMA
+			| CQSPI_DMA_SET_MASK,
 	.indirect_read_dma = cqspi_versal_indirect_read_dma,
 	.get_dma_status = cqspi_get_versal_dma_status,
 };
-- 
2.34.1


