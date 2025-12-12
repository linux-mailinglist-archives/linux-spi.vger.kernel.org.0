Return-Path: <linux-spi+bounces-11875-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C446ECB819E
	for <lists+linux-spi@lfdr.de>; Fri, 12 Dec 2025 08:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0792300DCA2
	for <lists+linux-spi@lfdr.de>; Fri, 12 Dec 2025 07:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536DD1F584C;
	Fri, 12 Dec 2025 07:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IaVrDBF5"
X-Original-To: linux-spi@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012020.outbound.protection.outlook.com [52.101.43.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDBD1AC44D;
	Fri, 12 Dec 2025 07:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765524213; cv=fail; b=cXx+6DgY7ipVV6wuGxeg7DAzvwFZ1Bsiz+OHxQmkyLKP4zRvqPOAyEpcRG0MBltg7lAim51jwTDlLGruZiqfMLLEj+5IN8k3BzgEz0v3pc4rsGEMAEFVSwHm7nUYOaMo7OfQsBj6kzD94CKHXYb1aAj4lgwI1C0iFftzYHXNJdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765524213; c=relaxed/simple;
	bh=GfP6umCuhc0FOkVhP4SMVD7MjDl06Y8WnuYQDRFEo/k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j84ICq9do2dtdyrYxaxiC0YZxIzCPvV75SfLn15/LSkNbfsqdZZQ9ZEYzUId1de+6eEaV6EElQZigwlvtxxmD8bKUfZEMC9lqo1r924nkB1wAC26NS+DkZUO2AOrm1/MNzdEIwFco7qFgTiExulmfFiUdBRAVmp/fpdS8wQHBDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IaVrDBF5; arc=fail smtp.client-ip=52.101.43.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YtwjVvNv7dt7XXgOmAS8bvP16obr4vzHcnDbIxoydTdXFobpNlSMLv5P0zIQpOlW5wMnT+tp6fjFYCvijhThohB0wwt7SM1ieyjd4pg2N8Ic454+5mhxAzEpHEEV4yMRb0FLC2yNuetkC6qh9Ac1lNir+tfxqxD5nfrXSOrpgs01SX5+g+KBQUbLqY4mFSz7Le5W8hPwUyJSGBO7MFTVj71IxR0arPXpvtOOGt9ojbLd7S3fPg1xrflZb0vpkn9t8PfkmemCJ+9TGwL+0VEgf3nWz8CYGvpg2CbzyQoPHBoyl77HE2CFLVtnCMxC+WP8NuYPPM/puq4PY/qcm4YwDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mr8zaqPa17fjS41imfn/v8VBV81+HtTLT6GHrS0sD/I=;
 b=ypDNpsHaNOkxMo+9DxrGX6Idjp41JqiRV+B2rA3ZpgJHMT/8raUR8I5lDwQsuybTQxiT5XsEM4hYw3f/CLaS20OCvhmgPOneqEkHa7Y/KltiwOXaXMBA0g6o5H8pbOB9iXBnjfh1f8mu/ERWSk1fL22Xfp/yJx0X6ThrckR8ccZp9qdaNnDSLeEspbfzqKpxKNANTFqr4Atb7cjOlk5i+kz1qCmTJYqpgGaGZ7GPuyk6gZcpVaPJcH4pds2lYCK3Q1bMdYxwSq6fkuXWAW1bPy3/frYuqVQMaWfbS6zgcnjjp8zc4FsHfpDQ80VMvav0DKuy8VVq2r696T4C4cnfEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mr8zaqPa17fjS41imfn/v8VBV81+HtTLT6GHrS0sD/I=;
 b=IaVrDBF5Ma2nLJWJAp1Wh2geEuwYx5d+ffWfaUOvDjkIFow/01VTIdBaDnNXT39duZUTUNu3KkdYnfTsAHhwYyON8qHRQFYxb/iN/6OMejTbd1oMCDY3TjKRW5+f0EMAhjLsnCHDmtIH+5favLaVKgNMTBgnSuZ2tsbMEEbu4/I=
Received: from MN2PR19CA0006.namprd19.prod.outlook.com (2603:10b6:208:178::19)
 by SJ0PR10MB4573.namprd10.prod.outlook.com (2603:10b6:a03:2ac::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Fri, 12 Dec
 2025 07:23:29 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:178:cafe::8b) by MN2PR19CA0006.outlook.office365.com
 (2603:10b6:208:178::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.10 via Frontend Transport; Fri,
 12 Dec 2025 07:23:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Fri, 12 Dec 2025 07:23:27 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Dec
 2025 01:23:23 -0600
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Dec
 2025 01:23:22 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 12 Dec 2025 01:23:22 -0600
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [172.24.235.228])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BC7NDoa1844826;
	Fri, 12 Dec 2025 01:23:20 -0600
From: Anurag Dutta <a-dutta@ti.com>
To: <broonie@kernel.org>
CC: <grmoore@opensource.altera.com>, <nm@ti.com>, <francesco@dolcini.it>,
	<s-vadapalli@ti.com>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <gehariprasath@ti.com>, <u-kumar1@ti.com>,
	<a-dutta@ti.com>
Subject: [PATCH 2/2] spi: cadence-quadspi: Fix clock disable on probe failure path
Date: Fri, 12 Dec 2025 12:53:12 +0530
Message-ID: <20251212072312.2711806-3-a-dutta@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251212072312.2711806-1-a-dutta@ti.com>
References: <20251212072312.2711806-1-a-dutta@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|SJ0PR10MB4573:EE_
X-MS-Office365-Filtering-Correlation-Id: 51918989-f93e-4862-d491-08de394f57ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d29qWEOANsDAEgpYoiLQN8dDqxdxQj22y4wEkCsFiXJPlLiIwO2ueoLWvCcy?=
 =?us-ascii?Q?8L37MEfnaa6tgzcpa9lEyPm8TS8mLc8NTkllz0/uIui8XsYrpq6wYMMCeDSC?=
 =?us-ascii?Q?QRevqOqshpC8pw/fwVw7nYUiui0JrAvfgT/U/drHdsBlBzShW+E8pFyU0VQN?=
 =?us-ascii?Q?wVQiAV7zZBnYWWZG7uWojM6pUNLm6shduIECDXB2ZpSXLCKa577oQuS5rsLc?=
 =?us-ascii?Q?eum98cp1eFTfS3T6LYAPPWt0V/0HVGm6LQ+e0kcCCbhhf61Hzlwi+/NKgkg7?=
 =?us-ascii?Q?UA+fq3dNPWnQtWL7WqV41hxuel73rNq6O4VYNejm8cnDiAWIMUaXFaBYG3z2?=
 =?us-ascii?Q?GfW2lUCmsiFmerbv6fWfIhvwFbBkwFQlN8z7FBg76z32BdP/Xfu25l3Xk4a2?=
 =?us-ascii?Q?JXcbUhoU+ZjdAdB0Jp7tYGh/s1xmKl5a/g9R7GW8D13gS+pDVa130WzVZwja?=
 =?us-ascii?Q?F3JZD90HqMloIiMsboRtCN6+FqPjfqVc7uxCcscZTFMZy+vD6v4BOknsuYjq?=
 =?us-ascii?Q?aVTiAJtsEAIyFwRkcJPNSB0SRMnHEh+3mHbP1SCOaofTBBgK1afzzWsW+pFj?=
 =?us-ascii?Q?Dz6SxMzyQDDmBDh6bMB0W8ov2lYEf/PlwpO4JI/tVpnA9NwnSlGPoTe5oMG+?=
 =?us-ascii?Q?b7p4l5fVjIU//dKk3atwvt5p3WYn23icYOBzcFqgoqhEM+X5pG1k9OVe+fIP?=
 =?us-ascii?Q?llCPSeF144thNqRR8DLPZIZU6bx1QH/6oQgCM3rqtom60/D4WApKYpbwQt12?=
 =?us-ascii?Q?tBerpoe1xZn7GFigbgcvhUhZSUSpWIR7lKEA9LaSiXa0KLoLHmQXNmHFI3tm?=
 =?us-ascii?Q?O8WO/tIs+GRqjQlN/NZfPfLl0znW1N/pza55HlvN5CRSE4wwPfyf53exhGiu?=
 =?us-ascii?Q?MNXZL9ZisI1G6Vl49ZKDKDXb6yKxG96hPR+0mrACihkqrgUF+zmn5XoNwhhN?=
 =?us-ascii?Q?kRcwRsHk6gMiYQgPTZjynLbeM6MoWdK/gLJzD4GQWnCZWHk0K/GYdbUnU+Ww?=
 =?us-ascii?Q?anSbKUUlm/6sz+8AQF3Lrl6SuhfAb+vcAoPObhH/hjz42Veofx3TCg4CDbWM?=
 =?us-ascii?Q?GCpbOO9JwqKRRaklx/Yed5gfdF4pM5omUriIcCVFhDZZoEneE9eP7O8PVtu0?=
 =?us-ascii?Q?56ryNmQIiNcCcpmdELk/BKT2qK+eGCqWk7zQ4A4izMuYnszIAFytxnh2I1HP?=
 =?us-ascii?Q?ROWWkaa4HqTXvfNw5AKBcXWaDpOJW35V93trGM64ZuBusgXe7BthEOV4BLGw?=
 =?us-ascii?Q?KIQSZ2zTAXcX83Aool+mJayZaM7smbihWd/zDkT/e4zTHSIWdxpCZzMzv25Z?=
 =?us-ascii?Q?UIqjD1/Kv+D0HLjAgZyQBkd6We1IO4ZG9ND+DS1YkL1HygJ2syZJeP6GnJ3B?=
 =?us-ascii?Q?vySJfrHIuFHVTPqAEEfYodWBTPr1MplSZx4tkVXfE9LBMEuNAUV9lOsMXd8L?=
 =?us-ascii?Q?LkKvR3IqXJ3+QHiV2goOYRcJ7n4JNGt602iuyYEF9wUemWvgsCQBo8ccytYR?=
 =?us-ascii?Q?arlijn7D7tF2SFWgZGMr4DmM+5I9TYwT+KDsoj0aNZFkbxzgJ2nvdjrQHVBx?=
 =?us-ascii?Q?9IiqWdaci4Z0UduLKww=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 07:23:27.0122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51918989-f93e-4862-d491-08de394f57ca
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4573

When cqspi_request_mmap_dma() returns -EPROBE_DEFER after runtime PM
is enabled, the error path calls clk_disable_unprepare() on an already
disabled clock, causing an imbalance.

Use pm_runtime_get_sync() to increment the usage counter and resume the
device. This prevents runtime_suspend() from being invoked and causing
a double clock disable.

Fixes: 140623410536 ("mtd: spi-nor: Add driver for Cadence Quad SPI Flash Controller")
Signed-off-by: Anurag Dutta <a-dutta@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 7c1f742d95a6..f8823e83a622 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -2026,7 +2026,9 @@ static int cqspi_probe(struct platform_device *pdev)
 probe_reset_failed:
 	if (cqspi->is_jh7110)
 		cqspi_jh7110_disable_clk(pdev, cqspi);
-	clk_disable_unprepare(cqspi->clk);
+
+	if (pm_runtime_get_sync(&pdev->dev) >= 0)
+		clk_disable_unprepare(cqspi->clk);
 probe_clk_failed:
 	return ret;
 }
-- 
2.34.1


