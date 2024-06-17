Return-Path: <linux-spi+bounces-3421-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B91790B619
	for <lists+linux-spi@lfdr.de>; Mon, 17 Jun 2024 18:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF54AB3B8BE
	for <lists+linux-spi@lfdr.de>; Mon, 17 Jun 2024 15:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DEC139D11;
	Mon, 17 Jun 2024 15:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DkLvLixG"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900A92BB02;
	Mon, 17 Jun 2024 15:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718638734; cv=fail; b=sAGuP21XUpDgRj/O4y7YOGIvWbAZJeMIsUN66XpcMSw+B5+g0algbILBUAwZAl6F531UvvuokA4PLg3r6IN8/c6PW8Tr8m33Ab1JvpWXXYbrcjIGgSCCBTrrX2inQ2g7yXdIQ/PxtYn9keUD845pYAQRvQqevlMi6UAPzP84IJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718638734; c=relaxed/simple;
	bh=wgpKwBLjlKujYXurzKu8U7MxmbwyB26AsvpIPh31AeI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D0H3q6AJHZG4TcFI9caXt6qLGbjmrmhcJeQj74sKfCB7OG/ebP61okf040saq+kSgNM63eUP8H0NhFGdIq+1QCZ0o6aMemDrp/uMmgbPdI91qECfX8YSVpIZyhlBw3ZhyjjUjcuZR9Nz6ZUfnb2EgngLtBUSSSEfg5yHbOuaygM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DkLvLixG; arc=fail smtp.client-ip=40.107.236.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUOQt3qltLp14jjxe3GE6NaEiY1x3fcPxCjhW9UKolz8YGZw6jS4pJEDlhWxzLgXh3xKk2jLNx9v8/F5zyOMC0R0lGbvIXQ+7VJ0dFnblzFuuh6UL1jgaUVP66QAO1N+vZV60QLnIdYqFNGbXJ6p4JgHxjJr6zUHfDD8pAhF4AxsxaGDUswuYBVtrDUWx2g//9e0CTDbejkqp1PEoZxVnL/VBw7M9t7GQPMWyWHWZFRRRIUTbBycn/nCbqkjRV1tAI5TIpz/1yIfYkUVcD1PC3Q7ALh3Isz7n7grXHuiFcfKLg0CsgjOQ4tfWLyzrt6bvIeuxrx9t0tL5VF95pncgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9L85jKL+XfWI7WEh/WVFE2Z2CEqzc8U+hYt1DIj1sT8=;
 b=PvulLI6ZIz9fzXB0v1nFlOyJAMvqiC7Zg0Bt8KdFCNjfMIk3Ar+bogrZW6q0H5SRhbmS3yVf5HuY6WapzVnBZ6fzgKFBa7136BidWMTUNaKgMf/fbIm7CQL/vBKENB6oaPUJvt2n2nspe4eVY37GHLeHb9ygpCgMAsD94If/siji/jLULA1E5csbz5Xi+pkSAJ4rh9UMER/7yRcYkCZ7KYlKYKFGglo1bFHlcXfmu8uNQd5TLHI/OSkiP+/uCsRpBXiyU83G+VRrG1fgdxf/ma1uDj078YVeg61+WZ9Mz5QDMSN7hHoUBvAhxUboJ5zmpkZcHAqH+SVP9uWhXJ/QHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9L85jKL+XfWI7WEh/WVFE2Z2CEqzc8U+hYt1DIj1sT8=;
 b=DkLvLixGOJkPAcPb7zkOAiZTFTOCJz2diI422NTFxtlkQgpL2thgIWa/6okF7VlKzg0D0iq7GV8UCPkDCM6obv+Z2Euq/RSIer1O977C5yYMzANLYSukZWlmon/4nAN1TZoJVeIWTGUNO1kcH6p09jiqiSc0xKiAJVHmvHhjuSw=
Received: from SJ0PR03CA0231.namprd03.prod.outlook.com (2603:10b6:a03:39f::26)
 by CY5PR12MB6276.namprd12.prod.outlook.com (2603:10b6:930:f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 15:38:47 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::11) by SJ0PR03CA0231.outlook.office365.com
 (2603:10b6:a03:39f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Mon, 17 Jun 2024 15:38:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 15:38:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Jun
 2024 10:38:41 -0500
Received: from xhdakumarma40u.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 17 Jun 2024 10:38:39 -0500
From: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To: <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<git@amd.com>, <amitrkcian2002@gmail.com>, Amit Kumar Mahapatra
	<amit.kumar-mahapatra@amd.com>
Subject: [PATCH 1/1] spi: spi-cadence: Enable spi refclk in slave mode
Date: Mon, 17 Jun 2024 21:08:37 +0530
Message-ID: <20240617153837.29861-1-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: amit.kumar-mahapatra@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|CY5PR12MB6276:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fe289fd-fb07-4414-6ce6-08dc8ee39337
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?636fRBJYX7wetKxu4EjKPM/QHN1UJxlgtsvwY5CtcqER3MgHccBphrngcvK4?=
 =?us-ascii?Q?C9mvq/4qe/8ih2YskYwMhysTFkhmDSruTEKE9yWuhkOLuugX3JUQ+SAR8ZrC?=
 =?us-ascii?Q?mEQq3/BNAnKgDL+vlTFzd8S3QNVIuB8zxZFVeieR32DcpEr3r/ynJrE4nXVC?=
 =?us-ascii?Q?ECG5E57R5lGK0S0wJOSBtjF0beqyx0RVVOay1XSWG4t6GTWQjb7tC20jeJrD?=
 =?us-ascii?Q?BMqc9nQDq2Q5KW9fgkSKN1zLhMK9QsWOnk5AQ680dZo+xGiOnDsD4pHMSXk7?=
 =?us-ascii?Q?e/CwcEWKosD9oH9pijSyP5H5d/hc1AkGXNEJBJfY0lDR4/BYeccDW84TRWQp?=
 =?us-ascii?Q?Eoo45rLvvuqYJeT/El2mbB744OWK6u1MkgFoALO5qWZpNXAeEmvRy2QdBRz2?=
 =?us-ascii?Q?lSfr97nd4S4/iTT5vHKHCnMdaUM2z3wqb3uaHY0ov1y1mxT6nKJKSt438Cbi?=
 =?us-ascii?Q?oGAWaAK/osb+9WDMq2XaxAC0FT1LP71GY96hu5Gsd5/9iDG4+lwGmPUWzFT+?=
 =?us-ascii?Q?Yt1ZoyjimrKyF4mGdkbJX98HZKuqS4zJMi9qMn598go0PjOpWVEH9x/CusUg?=
 =?us-ascii?Q?5Mu2nP7KMHPDpS4vXZU06NxR4BYILOdKExYiG22vzvBoXJTJZB4WD2VBTUSw?=
 =?us-ascii?Q?Ow31pJFdimf+l+bfbls8708nRhCjAkxt2ZglmiYaOcJeZnlhkOT7jXtyAIfk?=
 =?us-ascii?Q?fpOXg9GK/9G9B/M0v231CWF8XOX5Rmf8qoEo1j9QD0Q085u9D/esSfvS6WGa?=
 =?us-ascii?Q?bnexncJlr3HIUHvUd9m+/DAxt6iTWXE5y7MZ+hFivMKFeN+cI+35RqS/Ds4H?=
 =?us-ascii?Q?IGgzJ5SfmTewAn8HXiBSl3FsN4i8oUUkcAuQqjkUr9G8m9B0mHkC9bZKNU2V?=
 =?us-ascii?Q?IBKh7rXvYFX6hhCSjbj800fckYTHTqP5SYKblIANH/RNvPCYC0X7zDlWa3n3?=
 =?us-ascii?Q?ZTTYfVrtadlog/DMPc/lPkdj1WwOrmGoh7EKhFmMjUC6ryzZxyMhI+aCA7iw?=
 =?us-ascii?Q?+APDEsPcjQ3IzoStjfo11HnMlNy6+ZPaMEUhmCDxqyjhQcr1NrPgLRspG2VY?=
 =?us-ascii?Q?vPVUqKOXPeV9mcX4UGXjTGumasIv0nQHDQjOL9V9VPTQrmqeKWhb90aJc2vM?=
 =?us-ascii?Q?BeGWTBpQyaZP6QHKMl1xrUUhaQL/0D6wBBfsLNmVBZQbmWfGe4JLf35m/Esg?=
 =?us-ascii?Q?hsOrSGbA4De5Qctn57w6/xAU2/Ktc9Kj+5XUJAcHfArNgEEeCtiBiP1nC3Ss?=
 =?us-ascii?Q?g2Pd0uh62ehW83mmCkPC1mS4+ffD047doeA8AhLn3pWdC0YPKmMLcc2G2OZD?=
 =?us-ascii?Q?h9FDktjPX7JZKW4eBFrdE6/3bCVT+jq4O4/+V+NMj4TOd9+SRv4un664n815?=
 =?us-ascii?Q?oLe0N5VRMHn63VhliZTSj2Kn0kD3WzrIHgi4bB2MzMzqpdagIw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 15:38:45.4777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe289fd-fb07-4414-6ce6-08dc8ee39337
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6276

When spi-cadence is configured as a slave, it requires the SPI refclk to
detect the synchronization start condition while communicating with the
master. However, the spi-cadence driver never enables the SPI refclk in
slave mode, causing the refclk to remain disabled if the
"clk_ignore_unused" kernel parameter is not passed through bootargs.
As a result, the slave cannot detect data sent by the master, leading to
communication failure. Update driver to enable the SPI refclk in both
master and slave configurations.

Fixes: b1b90514eaa3 ("spi: spi-cadence: Add support for Slave mode")
Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
---
BRANCH: for-next
---
 drivers/spi/spi-cadence.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 4eacf3f6e031..e07e081de5ea 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -601,14 +601,14 @@ static int cdns_spi_probe(struct platform_device *pdev)
 	reset_control_assert(xspi->rstc);
 	reset_control_deassert(xspi->rstc);
 
-	if (!spi_controller_is_target(ctlr)) {
-		xspi->ref_clk = devm_clk_get_enabled(&pdev->dev, "ref_clk");
-		if (IS_ERR(xspi->ref_clk)) {
-			dev_err(&pdev->dev, "ref_clk clock not found.\n");
-			ret = PTR_ERR(xspi->ref_clk);
-			goto remove_ctlr;
-		}
+	xspi->ref_clk = devm_clk_get_enabled(&pdev->dev, "ref_clk");
+	if (IS_ERR(xspi->ref_clk)) {
+		dev_err(&pdev->dev, "ref_clk clock not found.\n");
+		ret = PTR_ERR(xspi->ref_clk);
+		goto remove_ctlr;
+	}
 
+	if (!spi_controller_is_target(ctlr)) {
 		pm_runtime_use_autosuspend(&pdev->dev);
 		pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
 		pm_runtime_get_noresume(&pdev->dev);
-- 
2.17.1


