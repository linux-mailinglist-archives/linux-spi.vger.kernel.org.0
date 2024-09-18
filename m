Return-Path: <linux-spi+bounces-4847-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E47A97BB29
	for <lists+linux-spi@lfdr.de>; Wed, 18 Sep 2024 12:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EB9B1F23292
	for <lists+linux-spi@lfdr.de>; Wed, 18 Sep 2024 10:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F5A17E000;
	Wed, 18 Sep 2024 10:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TjdqB6XG"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2CF381D5;
	Wed, 18 Sep 2024 10:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726657045; cv=fail; b=XcVAywIUo++NSEXWhG3lwvA6LBhjoYKr2TA6G4eGuA00RjAy/9jGjiZYTkigX/4Ms8J/k1PQ9CH5U9slyGfSbtaJtzf1UfN7869g5q3QP2KtzB6Sq4bUKXI6p0JKkbJpTWpJYRUUQnNNf/kbQ/5gz4Blp/+ER3LfXL2Y8CvsDiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726657045; c=relaxed/simple;
	bh=h9b7Ya0QjPcc1DlF/mpNabfgehNs6LozGmLFc6wM9LE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XQ1jO49XreaNqCYCw63DvPW5Z3VHTKiC6j95llGi054oEwlCl89fMFsxmjP1tK3ujiLeWIUcOCZ8kR0PloNzOvSVnyDc9NPVED6T1+TlPgLqr/cAtycioRdbBaejWzUXnvwwYdw8hfYUIKyQKFglsT18Zm83akyR/5d/jGEtOWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TjdqB6XG; arc=fail smtp.client-ip=40.107.94.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y6ni2pIje31cs6n0bOpD9+0bBxFnY3+v4Lj4VpnrU9Ozh14Yb3B310I7tVEwkNaORxuEA1k6Jjm3EKaSnXQBIzMNcG8WcJvnWqcwVAnwFO1Lvx/qtMPz5S1fLnLogvYkGcXRFRB5Jp1Pfn29EENTnxpBI7574sUMCZba0CNXfazR8SsnB9hHaJyKnpORBdnZUVX4KJzaCpN/w3BFik/tKqKR5GuReBOFaTtlGbegCrS2AWJAQyW7jQm+wRsTfjCz2nAgy6cHiP7kn/gS4C3GNmykOfbBQsf2C1jk6zbfQZJY3KIAyrdtsdN3V4P9b8eOh98QVXU1lQYUtIg/LwsUAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUZzj8MKKK27jqyQlncoGZ9V2tgZjVxDEDsA+zNwwNU=;
 b=d9L62D9Gcu2PeFv7+soqLBNopoTOTm7/Ua1oFGCOu3jLj7NkZiYT/6VO7iFuT5IM7MDuQJEx0QBHRSdVGOsOKxLyPmJ3xoisfLkruNKZepdYqAiq0mkXY3DVqK1+0hLnJ5dyj+S7mVK1aECyb31FIDpy1YdwSFxTInfw0CxiDEI7KC68ObE5b4FdbGqRmajdzGVpUSNy/pJDaOSuTeR/zjtqhPYnAJpDZCkHnmfjR8gCK5CvhXZhKf6pc/XJmAlIUV1CcF5kOLuZqvAYy6NwlhbeMo2w6deca2p+396UDPYsTJnvAjXAuD7JV80Gd0xQyo8q1nb6TQbLuqcD6Gt8Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUZzj8MKKK27jqyQlncoGZ9V2tgZjVxDEDsA+zNwwNU=;
 b=TjdqB6XGLt7egSErt3kN+Deif4AIiL3/jqboO27Cg+HkSkurnAy0rMkNyVo6su9D9d8EzmZTc7EjJuX4UPrP2cGQfDIsWtYx1saYOoSlIWhp8s9vU4S/ETO2kdOUa2Jglv57Ar1App9xNiPHmdBi2DhB7IXekh9Kqubkk2HScVQ=
Received: from MW4P222CA0030.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::35)
 by MN2PR12MB4405.namprd12.prod.outlook.com (2603:10b6:208:26d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Wed, 18 Sep
 2024 10:57:19 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::a0) by MW4P222CA0030.outlook.office365.com
 (2603:10b6:303:114::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Wed, 18 Sep 2024 10:57:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 18 Sep 2024 10:57:17 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Sep
 2024 05:53:47 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <sanju.mehta@amd.com>,
	<krishnamoorthi.m@amd.com>, <akshata.mukundshetty@amd.com>,
	<Raju.Rangoju@amd.com>
Subject: [PATCH 3/9] spi: spi_amd: Replace ioread/iowrite calls
Date: Wed, 18 Sep 2024 16:20:31 +0530
Message-ID: <20240918105037.406003-4-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|MN2PR12MB4405:EE_
X-MS-Office365-Filtering-Correlation-Id: 71e5ce9c-7531-4255-9c2a-08dcd7d0a9b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DAvbVNru6bvKljLGeJlOTOtNcVYxHqaCH98p1eyG2HGXsrjtjfaikl7G8z6B?=
 =?us-ascii?Q?4KymLjz/BGicVPb31iQIP4myGFg7/HiKtosK5c/AlQJhMy/TMPoEinMjjyRF?=
 =?us-ascii?Q?e7kw+Hss0zEaPPM+PMONxgvFabBGD32/7SIqAFaVcr8Fsnyq3AzYBpTqGkIS?=
 =?us-ascii?Q?5yAErudAZPz41DlbWnNatmj/gHwMMmz7eSBzQ+z9hNwgHxvC2BBmQAXyB0+L?=
 =?us-ascii?Q?cO/BaiR++OigdblJ58oT935Aj7dxkYicsOTm6DLn6Ty0A+x8dKWyu1y+gJ0+?=
 =?us-ascii?Q?HDDEcrRzWeH50KR3ibZo6kA8HVoe1+2qIg2Ko1lsNn3/iNKeXOQqjlKvHyyP?=
 =?us-ascii?Q?i/9ec4UGsEQ+ftGDJWSS7cnqrGJD+YHqcrXUzlOOBt4ENZ5XPFbNeIsGJO/r?=
 =?us-ascii?Q?omb4ltldx6dAq93ykcZkLstJB4KFRSjHBJ19LoydcNSWZiWTqfIRhquDE3nO?=
 =?us-ascii?Q?Ik8X6wt7bIS5xXt5scpA7fDbAOtA5HZSR+Q7ZB/QQcfUX2bKWGlzvyQHvAEr?=
 =?us-ascii?Q?n4taIRnXlQnGuzHA5ozpkU6ghzO8+UqtB+qin/pDuC0Hjcs0WfsFbNaSbUYg?=
 =?us-ascii?Q?kcS4iR1qbZS8cUYhEcg4eLWarhrK++8E9Ny7Faf/EfIPsgBPYywKTHD+M3Hn?=
 =?us-ascii?Q?kcAO8wbExZmSoq3/Nl5h2mON07j9foRzOYhNnlXPC1WcDzgGQ1srZFvIWJ4F?=
 =?us-ascii?Q?QSGer9rIm1MVooz4h+p20W5Ztt9gvklVfjFv4SQlPUPKI6ystxuhUXJv92Yt?=
 =?us-ascii?Q?/whhKJXPx+rltJh/UqvlzEGyO91g8RbPY4lWusSgyG5iHWAzqs59tzv5byF8?=
 =?us-ascii?Q?Om5KyGpRqienBsuGaWOKERirgxeDUfiOn3YDgnx9woRtZbHgX79Qh0j/TJ7D?=
 =?us-ascii?Q?Xt10dmd2/aPuufC4zrnVtGX+27StU0ctHR4LVz+ELTe1jpG65gUUy22NlwLl?=
 =?us-ascii?Q?jZGk0NiWeU9zFFMmAGwUJE8beAfFY44+fvw+YnAJeE0ugjsATjrD58aCfo3G?=
 =?us-ascii?Q?xg7ACelsJKUZynG0U2kcqoQ5wq+tx1unw80aNUaJoEL+ld2xbulkRPTbZS3q?=
 =?us-ascii?Q?HBZTcUJ5eEzFnOSc20GU5Hp/TbhlGcems2wX2yf6ItnlzZYC+XR639bU6Uao?=
 =?us-ascii?Q?sVDReasrtcSQ8Zfqq2uVZimOD+Bad3wF1y+3+eMJagFWO6rpTTG336AmDmWi?=
 =?us-ascii?Q?QiL+67Xz47eAiDfhJE8R+nnLS7OPzZDO5sMasB6sHIbQCDyKu5wgzsM5q5tx?=
 =?us-ascii?Q?OLmlDFucrahjRm0RPbyYkhAriQ/c8MSuuUtCc1/PaMuscCfAh24ASIsGwzp1?=
 =?us-ascii?Q?1PV0EO+5kURDC1eK5tkrx7ae80GWM8WbUdSkrw+VeC/fKr9xnfjk3l2xsu9J?=
 =?us-ascii?Q?u09ycv7CCeCiF5wsLFh/e22HerQ2sTZWWNfPCbixirPJNCVq0mOv9bY2NsVn?=
 =?us-ascii?Q?1jGyn/EoUvgCIMAp+6C3BIPzVUeqozzz?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 10:57:17.8979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e5ce9c-7531-4255-9c2a-08dcd7d0a9b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4405

All `ioread*` and `iowrite*` functions are better suited for architecture
independent code to ensure portability across different architectures.
Since AMD SoCs support only the x86 architecture, replacing all `ioread*`
and `iowrite*` calls with `read*` and `write*` calls can reduce the
overhead of ensuring portability and increase the speed of I/O operations.

Co-developed-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/spi/spi-amd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index 54b5a4d18691..11ae910bb420 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -99,12 +99,12 @@ struct amd_spi {
 
 static inline u8 amd_spi_readreg8(struct amd_spi *amd_spi, int idx)
 {
-	return ioread8((u8 __iomem *)amd_spi->io_remap_addr + idx);
+	return readb((u8 __iomem *)amd_spi->io_remap_addr + idx);
 }
 
 static inline void amd_spi_writereg8(struct amd_spi *amd_spi, int idx, u8 val)
 {
-	iowrite8(val, ((u8 __iomem *)amd_spi->io_remap_addr + idx));
+	writeb(val, ((u8 __iomem *)amd_spi->io_remap_addr + idx));
 }
 
 static void amd_spi_setclear_reg8(struct amd_spi *amd_spi, int idx, u8 set, u8 clear)
@@ -117,12 +117,12 @@ static void amd_spi_setclear_reg8(struct amd_spi *amd_spi, int idx, u8 set, u8 c
 
 static inline u32 amd_spi_readreg32(struct amd_spi *amd_spi, int idx)
 {
-	return ioread32((u8 __iomem *)amd_spi->io_remap_addr + idx);
+	return readl((u8 __iomem *)amd_spi->io_remap_addr + idx);
 }
 
 static inline void amd_spi_writereg32(struct amd_spi *amd_spi, int idx, u32 val)
 {
-	iowrite32(val, ((u8 __iomem *)amd_spi->io_remap_addr + idx));
+	writel(val, ((u8 __iomem *)amd_spi->io_remap_addr + idx));
 }
 
 static inline void amd_spi_setclear_reg32(struct amd_spi *amd_spi, int idx, u32 set, u32 clear)
-- 
2.34.1


