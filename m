Return-Path: <linux-spi+bounces-4971-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 002BF9860E6
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2024 16:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1F2A289240
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2024 14:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24501A257F;
	Wed, 25 Sep 2024 13:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="va0xh0B9"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C31818E377;
	Wed, 25 Sep 2024 13:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727271616; cv=fail; b=OOvxofnfG7B2maOe89aeSc1m22USZK4umPB7/cenfa19pUrPLathCCUt/MQMgNP0YpySV67RUVi254bU1IQxpEnhXw8hh8Dc3zLczzn5LYgE1snxj73OyOuOSrnWeSPkyYeerEpMOKZxH4DPmMb8FvK8wAVAKpXvY0dH7WlboQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727271616; c=relaxed/simple;
	bh=2K+/l3uBL4iqM9ogNB5t4HhhmyeoteuSSH7CbZMvEXo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rHBQY2DXGFcn0EKq/Yfuqm2QUgT3c41sEr2NTLcQpcW0zNt+5mMcWwQyNgyFdAa20+mihdQG4RlibNIf6uZj+R6c2G+6zNx7UBhsj10aSK2YVk332zZ4ZEKZMldAUdhqeKXpyy6LhhgVBL2OORNastsjewWErmB5KifqEYGTqvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=va0xh0B9; arc=fail smtp.client-ip=40.107.96.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eV27uIAqgeBWjLgI39l4eztWLhU27luCL3Rv81otrUi0HqTS06NUNjvM/lX9nCWr1kaUPmQYPpb7zEhhK7goSg9nACZoFbse2NMtYCUL2VBy7oRJRCYYn8gDxUc8MBZXAupEJ58x235/s5e/JhtA/xRzO+zMckt5Z3B4qJOwXhghvGRufjguDD6Z8N8I0rcVECqeRoqVHefX9NuxazYSsQuLPAk0YfJaonwXfFOF9yY8G34CJvGL4SEaQEsc2pFW+wlCAImIFv3+gv/O04hcm1yeXvfdr6x4v/0trfHy4zkf+0qdBHLb7NMnUG+Df6IH0JaRnyi4aXCuiPTdwP2xMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTjYNixUCu6DvvJzGZS5L6T54303fMB+vUU9SudeKBw=;
 b=brPH+x5q9x3VHD9QuclwMbkGq164nxNxdr2RU9IHyktDOW+ntL3UM2Ij5c6AdrwmpHE1OtxFE9W80anjW8zEDKFtozKyZMh+rTYCPijnfzvh5NTK1XWFGQeYPjhEcPEtD7jyBEtBOr3iQ0Sg05yZzEJArk2UteBaGrqkCGijzsQKkYADUTpdN1Ifhetz5/VnsqEQHa8wcYqyGjOcOnrXbrGG8HDaTOJt0a4Rt7gxj7ApiWzS7+7LWvKTshhSzkOrLsXd1ETE4JmDhCHR3zjcjjth/IKib1GT9MTvlXT40QDRsp19PIHunzGIibMQefdPAx0yBb/U+jZgkC8h3J0Zbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTjYNixUCu6DvvJzGZS5L6T54303fMB+vUU9SudeKBw=;
 b=va0xh0B9205qT4/09Otbiltzz18GfHCQEqlwHbzuLOQQ42IeopNQO5jyeO7IhaXgHBzNKGmGZrKJeG5lGtEn7BabYus+SZ+cgB68FDyMIGeh4bFkiiEIVsW3MGr1eL8Q9ZQ9buiR0H+it3bkZ+h6a2u7hSNbSkviFvSZ5RQyhGk=
Received: from SA9P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::16)
 by PH8PR12MB7352.namprd12.prod.outlook.com (2603:10b6:510:214::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Wed, 25 Sep
 2024 13:40:11 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:26:cafe::ba) by SA9P223CA0011.outlook.office365.com
 (2603:10b6:806:26::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.30 via Frontend
 Transport; Wed, 25 Sep 2024 13:40:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Wed, 25 Sep 2024 13:40:11 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 08:40:08 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <sanju.mehta@amd.com>,
	<krishnamoorthi.m@amd.com>, <akshata.mukundshetty@amd.com>,
	<Raju.Rangoju@amd.com>
Subject: [PATCH V2 4/8] spi: spi_amd: Updates to set tx/rx count functions
Date: Wed, 25 Sep 2024 19:06:40 +0530
Message-ID: <20240925133644.2922359-5-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|PH8PR12MB7352:EE_
X-MS-Office365-Filtering-Correlation-Id: 57e01273-b07f-4608-37a4-08dcdd6793ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mNCYHNHBwukqJHh6WfYNF98ncEQFp09sEuYyvS8xy9/Ut+WQWSKZMNk4DtBU?=
 =?us-ascii?Q?uFdOPm8BTRjyPTaXv/AyLPEYcwXCRIKrEO+Zc18zcu+v/pXz+KZHnCOL8mwd?=
 =?us-ascii?Q?V6hbAxEcTVO2F6+sdhEKDb3NjVaeNdw7fm5n1eqKEQObB0zIBKgQBDG4WQ2s?=
 =?us-ascii?Q?XYOSDKenuu4nCXnioJnKWoydFUT+NS531YeF4gBCTZDnbNcLTtT94o6QbhYR?=
 =?us-ascii?Q?/oZ32ly66L25DOhhV2eosn8ZuHpaXCpxkIQtVE9hK8VfWCSpVwI5f7ac35bi?=
 =?us-ascii?Q?jetlAOSCNU2iJ9MiY2R8JTpdf9BuH/MiDEZKRtMcjTxbDaRCtyVMWZMDAvF8?=
 =?us-ascii?Q?vi4xHpjwl2rFDQ1G8ot10SCI0Dfkx3lULQg2jUi2O3ePuElUmI5Qtxlzo3uH?=
 =?us-ascii?Q?cfxVz0jFkTdN0BPOVwfARwet6u+7En5M1jJoTWyFpFxbAwrzcRJpfYpyvW02?=
 =?us-ascii?Q?zklPHxKW//X3QptT1oEl3vyPjri+XRc8MESUmD9VsK5FaTmP7oXw353vcr0m?=
 =?us-ascii?Q?BLThoqGAElLE46sx6WajmWWupm4mIzgdHA7IU/jciIIiLFhS39pS8EJajnix?=
 =?us-ascii?Q?EDak7cyzchk2guOiTbZrL5pTXpU9nMUdIGKiVF4JfnOBd/UvwAZAaixYe8uK?=
 =?us-ascii?Q?ZLa6+FWH0trpkElrh9H8WQuWKSwOjm/OAOQxw2vC9+xh7DFmUMWeDsvaaJUY?=
 =?us-ascii?Q?3dnTfs6DrBogd3xlhNvKRAXELMP2Waij38wTW2N8zdC3PBTpz0Qb12KUbpPg?=
 =?us-ascii?Q?/6ntJO4Fsg5o8nBuN+0VAj2IjQ7xvtSw8q7/teK1KYNgdT5MEMkpM8imhB1J?=
 =?us-ascii?Q?5Zb9KSZKd3eNwwRqO5Stukgl9VsrCt/zF1ODGUBTMTPt+RLpHKCG0Tp2Gvvv?=
 =?us-ascii?Q?Re/OUq/bysOz8dv7SgHqoNXHmTzPesXI/IwJ1A3/PRqcj5XRK5yVH11YabDn?=
 =?us-ascii?Q?fGGC2vzc9vncvQ1n8dtIfQSszxlCwl8O0mFwx2urKdkATWFOoZQaW2EZKvMk?=
 =?us-ascii?Q?Awh5DekuR5Y+TACZ3Ytmh17TeaGjCt04SxMN0kM7B1H7mmpE1Q6b0sv2SZCE?=
 =?us-ascii?Q?LVnOoK4j/u+qswryeeVVKlSPq9TGrA1lSWJ4LfdTVLMcQjOKFxDMf0vVByT+?=
 =?us-ascii?Q?DH6HRMlJ53we5Hq1jyZ7mz5l52tWnnGMIvaXu+7kifJIMP7d5EERXNALh5M+?=
 =?us-ascii?Q?VU2TzadnEtBImXwDjFMyyBrisC4IzNDUyjFykMFyZqdNQakYmi06+cFa47uQ?=
 =?us-ascii?Q?xHdRlEsVBXDsMDqyvc8j69A+iGaNuWxoPQjR1KPTihOPIuyr6Pt3SE3751in?=
 =?us-ascii?Q?r81A96zruVGFoANPHc8ivpJHPoyxDg2Bhx35sIRm0vQyNYhZoCkGVA/My0yF?=
 =?us-ascii?Q?8dKr8WaaAIYAnqSGwSSoloUdsyaUJJjVV1h8su1xjGFKqIhbA3A08mN0xWAP?=
 =?us-ascii?Q?d21FHca6HKFZ+lSIdu6WjDhvpMTQciIL?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 13:40:11.1956
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e01273-b07f-4608-37a4-08dcdd6793ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7352

AMD SPI TX and RX counter registers are 1-byte length registers. The
existing value will be overwritten during register write, so masking is not
required.

Co-developed-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/spi/spi-amd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index 1d1a18ee0bb5..7841f3292a62 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -180,12 +180,12 @@ static int amd_spi_set_opcode(struct amd_spi *amd_spi, u8 cmd_opcode)
 
 static inline void amd_spi_set_rx_count(struct amd_spi *amd_spi, u8 rx_count)
 {
-	amd_spi_setclear_reg8(amd_spi, AMD_SPI_RX_COUNT_REG, rx_count, 0xff);
+	amd_spi_writereg8(amd_spi, AMD_SPI_RX_COUNT_REG, rx_count);
 }
 
 static inline void amd_spi_set_tx_count(struct amd_spi *amd_spi, u8 tx_count)
 {
-	amd_spi_setclear_reg8(amd_spi, AMD_SPI_TX_COUNT_REG, tx_count, 0xff);
+	amd_spi_writereg8(amd_spi, AMD_SPI_TX_COUNT_REG, tx_count);
 }
 
 static int amd_spi_busy_wait(struct amd_spi *amd_spi)
-- 
2.34.1


