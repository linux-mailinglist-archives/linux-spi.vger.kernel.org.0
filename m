Return-Path: <linux-spi+bounces-11876-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7ABCB81A4
	for <lists+linux-spi@lfdr.de>; Fri, 12 Dec 2025 08:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B57C30575BB
	for <lists+linux-spi@lfdr.de>; Fri, 12 Dec 2025 07:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332642797B5;
	Fri, 12 Dec 2025 07:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="b1mmrcMW"
X-Original-To: linux-spi@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010024.outbound.protection.outlook.com [52.101.201.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BC128C84D;
	Fri, 12 Dec 2025 07:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765524216; cv=fail; b=Sci6q4Th2fQTXZpDjqWjSqW9B0acPhrCaf1qmFTlvpPUt11xY+Ud5w6Vx3gbQKGG9G1qAXCU2rEq0gi/Bx64PSZIHPdfdFWlzIgDbCRX4qlp/cjdLvr2QYXrhWvy/Om3dpdEotQsA44H3aehQEvK6ThoL3tjPRxaVf48L+Fbots=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765524216; c=relaxed/simple;
	bh=PSwrDo4sBVmntRi+tfuCVmXZAhC4SPG66lv11sGwHLg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h5MMUQ/To8fjjAJQcUFPFg1kui54Kwp5POU0/gisU0pEkOOr2IZs1bNaeZPzFfDQg4N74+aKgtp9hx95mec8oT+HBqFf5wWsNO0lflnEOoB1xGCyARfeYEUz/L9j4R/w9fNbKaPzD5RMWN4qurxplv3LvUq+V7MsseY+Bc1D3tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=b1mmrcMW; arc=fail smtp.client-ip=52.101.201.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wYs8GJ1G1WnwYaJ2BIZYJDIvcDUgI4G9tIfLwQrCJK+ddo0XIXUN80fNn1O1oCynaAfxOOidzaliHFIGrmLEXnx1rbcoxqPIRtjuCgMnWMZvMOFfCemeZCa24YpgFbLKnXCHKjx66tb/O9K+V4i4iMbxR9qGPNGvRIdBnVvhKhThyq/a0pNooxIq+gOZdG54pBKO/Rwbm9+tlfzjIt/54PvbAn7XDQOnFjJlfRWD1lP/9IVcvOE3W6noVHkNT004+T2BfP0BlhjyTWUg0EVcV45UkCQKGwzW/rcfp4YxHqJeovW3P2bxYUjh2eVWDEuvw0sY08a1YlOyvZqHjeYj/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMhk0vFp7Gp+xhpT+YHHu7a/zxVrLPkPaYqA2vSc/Po=;
 b=a/W8IS3wrdyxVrfhi7T5YrIJEu+pC6sfJijwaXMBD1nOYHtGYq+QlAp4dH5FAwko1q+G2L8RHwHBlbHU1Kz7CnFV7tVSviIb1HvuBgipFf//BRTRfDoE89BRU9G177B6mIGusTzDA1Y8fx0qYJetiGvCOH6BU6+f28V2HRxd3oWHC7AFUnmNkciXTKaN5gF5oxaVmrM015xbQdXUjWuRCDD61uHK3WK5oggWVmDEwhhtj7MMIHImHPOoy4sBab3CLgxNfSbH1gcucDygDsgYhcMn5CYSnmV9Y1X/WGXXFg0R4RJQLR6av1crNXqK2TFQUjxocJA5eHrcpTgUuotVHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMhk0vFp7Gp+xhpT+YHHu7a/zxVrLPkPaYqA2vSc/Po=;
 b=b1mmrcMWcjM6AkWE7mbua9mE2Ubi2wbxTq1O/hFmFSK8yNcRAH6WQCEc/mdhA2sUlqf1qNlGOHExomFTognYGxqX3gPrvtHYBIIYs2XhdKyDsHYF1WFLrtPofhddgh9hTD0TZ4UiAj6XbhnlSkAYh39wolfg59mfQ2AlUpO9w7c=
Received: from BL1PR13CA0246.namprd13.prod.outlook.com (2603:10b6:208:2ba::11)
 by SA3PR10MB6952.namprd10.prod.outlook.com (2603:10b6:806:31b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Fri, 12 Dec
 2025 07:23:31 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:2ba:cafe::22) by BL1PR13CA0246.outlook.office365.com
 (2603:10b6:208:2ba::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.5 via Frontend Transport; Fri,
 12 Dec 2025 07:23:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Fri, 12 Dec 2025 07:23:29 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Dec
 2025 01:23:20 -0600
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Dec
 2025 01:23:19 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 12 Dec 2025 01:23:19 -0600
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [172.24.235.228])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BC7NDoZ1844826;
	Fri, 12 Dec 2025 01:23:17 -0600
From: Anurag Dutta <a-dutta@ti.com>
To: <broonie@kernel.org>
CC: <grmoore@opensource.altera.com>, <nm@ti.com>, <francesco@dolcini.it>,
	<s-vadapalli@ti.com>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <gehariprasath@ti.com>, <u-kumar1@ti.com>,
	<a-dutta@ti.com>
Subject: [PATCH 1/2] spi: cadence-quadspi: Add error logging for DMA request failure
Date: Fri, 12 Dec 2025 12:53:11 +0530
Message-ID: <20251212072312.2711806-2-a-dutta@ti.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|SA3PR10MB6952:EE_
X-MS-Office365-Filtering-Correlation-Id: 00376bf0-fe5e-4fff-3e01-08de394f597f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PZS6clnJ2VgSscjzQQfSEH16JR1s7x5iykF0Kz4q8zXMRWQGorBKkHOmFlSS?=
 =?us-ascii?Q?BpG8hiMItRb202FO7g2QJa9lCFdVTI3gszX4zbTvoIxTGHi9zyVxeJYV/zv+?=
 =?us-ascii?Q?0HSqJrkQ0pkAuulALrq52OR68r5b5/ejePzq67cyWzBvJeo9OoWEVp5AHlRJ?=
 =?us-ascii?Q?Lz13u1c8T8imsdugaZrux4eev/E0nctKrvi/jQktne3uUc1ycgG+sGiAddsj?=
 =?us-ascii?Q?LfMYN05g+c4PwbakJ9E93XhOOwVv2C3iWw09abZEkRQyUsfdYIMxNyXW34uL?=
 =?us-ascii?Q?URO4FH29vbYoZJfy7G1dFS9Qu4Aolb1QxqBOzChoVm2NyiSRy2WfDwSKtmyH?=
 =?us-ascii?Q?0NQZmXF5yGWFA6+h3X5EOjw3SRcRsa6fFx1tDnpmrRG5EdC6wkhRfiZ4H8lW?=
 =?us-ascii?Q?1PToG5lMi/MOiDXrybR2kDkiEifzTkE8scNY8f6nRgnrlj5ilmPScYHZM9u7?=
 =?us-ascii?Q?TW+F7JzsNyw6RU9Ejv4zg2+kOeyy4+6H2CHOcm6/qTcDm/aSuTW+CPYB7Ba2?=
 =?us-ascii?Q?9M/5C/2lG8tfrTnhTIIrlhQ0T8oOG/i9Ban+YMmmr3WOZq6DaXwpdXSVKTQw?=
 =?us-ascii?Q?awfLlKtGnf4ZzIeY+SgYvhdJlIizmL3fMcc1bbzYha/MJBzmTRY0AlnPH9P2?=
 =?us-ascii?Q?KJN5jXSimdpAU1zrFsCrP63djvQztZ6Bp2cGMmUT0kaBl/KWDLZ+c92bw9hP?=
 =?us-ascii?Q?B1STvz25iBj9FA5p2lkSQbiAQGie9FZeVOWQ8dRC46tYhr2SpZKFB4/NZlMd?=
 =?us-ascii?Q?XIUw4aO1VyCoC1SM0AVuobz2dpVNesSZCkxE0j7L/dn8vz30L/6j2xGfSR+5?=
 =?us-ascii?Q?4BMYcqJao/QRfsACzpBektaBtVO5A57Ejo+SHBNQXMP2AMcYE863E+A/Ai+q?=
 =?us-ascii?Q?IImGOEPhFV2BGdhY9yjFBE5YKSFflKexYz6jbu/iIL07COoG6Tqsg5Bm3T/I?=
 =?us-ascii?Q?+qgjiJMNJol7KQDwChjaT94Y8mGkoE528o6sVzrl9EOVFd5tlZW1esdZT7ef?=
 =?us-ascii?Q?xgBubnVFE2kX+mcQRVQOAorcCEoCFcp+xdfz28s/2Qn9r/4kS6mZptobjy70?=
 =?us-ascii?Q?jzx2I/rzVv4OhW0xtGHyECI+7EguVrMpkPcTYEqIMXsF0o5KMlByzmdWJEMj?=
 =?us-ascii?Q?20cjgSPIdZnDYJfklLuTUmb8GwEOqT+9HFwJGF7E6QNsmVdoiQH1GiTDbIyX?=
 =?us-ascii?Q?GmrN5/L2Xsr5+7eTBz7/+IO7dv4SaW1K4Nj+gl4irYN0eSWyd8JR7Cl7yvzl?=
 =?us-ascii?Q?a/4yXEa70HiWMGtq/z/fayRm8aGtteW2Xb2XYG/rt2FTF6nqYYfr00DaxB1e?=
 =?us-ascii?Q?drD5nHHTbTbKR7JO9Yhy0Fxqbm+G+17yn7oxE8nIRK86h4SDl7+ApvTS44OC?=
 =?us-ascii?Q?iXO3/l/c2ly8MqRfQTMvmXZ6yB1yBG6CmGjySflnR7HR6AK3OPCqZa3s7W3x?=
 =?us-ascii?Q?78USOjwD+10Wabq1BMsJJT0x1sie2NLAshvrAytW52IAw8mPcNlxsrJJLq+u?=
 =?us-ascii?Q?g4iDrPmtkVyg2YaISnAr6mhVEY2rBKelCKwjXU+pLOA0GcqYO92KOedTQepW?=
 =?us-ascii?Q?yEcudg+FiYFfq89NgSc=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 07:23:29.8725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00376bf0-fe5e-4fff-3e01-08de394f597f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6952

Add dev_err_probe() to log DMA request failures. This properly handles
-EPROBE_DEFER at debug level, reducing log spam during deferred probing.

Signed-off-by: Anurag Dutta <a-dutta@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index af6d050da1c8..7c1f742d95a6 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -2001,8 +2001,10 @@ static int cqspi_probe(struct platform_device *pdev)
 
 	if (cqspi->use_direct_mode) {
 		ret = cqspi_request_mmap_dma(cqspi);
-		if (ret == -EPROBE_DEFER)
+		if (ret == -EPROBE_DEFER) {
+			dev_err_probe(&pdev->dev, ret, "Failed to request mmap DMA\n");
 			goto probe_setup_failed;
+		}
 	}
 
 	ret = spi_register_controller(host);
-- 
2.34.1


