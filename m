Return-Path: <linux-spi+bounces-4968-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C519860DE
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2024 16:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5616E28768A
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2024 14:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A9B18E03B;
	Wed, 25 Sep 2024 13:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B4Pn68yr"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A00318E03F;
	Wed, 25 Sep 2024 13:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727271605; cv=fail; b=CMWRYYSbVM1C0yLVcktu9leWoJ0htDBjuExotSgd7WSCVo0xC+Ca75GFwyAYFeRoUPkTaJcr3PgtSKM32idi47zRcTzsvApF54gHo82P/A+Z388WD8mRR1N7YraQpDA11HMqvifS9hBDoxhwcI6i1bmNDIGoDLRX/EGdNPGH9T8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727271605; c=relaxed/simple;
	bh=lct+Aq2VyibkPpmL6WvSI5CAbDLzQxXh04drQ9ZXz8w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oXbEIbxwJV7lQ9Vi4q8oaoD9R13OlGbRyD9UdoAUfrVvBmO1aZZQsEJa6KwzRMV/Ha0QFtGQ2YlUPLfEvPmil7deu2SNW9zq2BQoFP9hfuPZlNOR0REvOoRTp97hnIy9P+J3IhPJwhLTXKT3APkQzF+pglF6rTYQbn/lWUElOt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B4Pn68yr; arc=fail smtp.client-ip=40.107.244.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YXqSXsZP3t5y4qGa8n+4Wlf3Jy6vsbHlu1iDG6B9nZzAJYE/XF3Z4HdFRSe7rOk41MmZIRqycEtWr9Z6GIBlYG/Ep0Ff2EQogz0Ptg97MMgw6VovXxniVdW8vA4crkxnfNopla8K86YkPg11YbxB4Lvfi8N0H3Ncg/RO0bpbfJxDwx4zbzVDDuOTXqCVtgh6gEs2jXks5F0/jxifX2y//P9QMOt+L8M2koAhurTTAgyGVwNW+d0dzmX9lJtCl36pvhwfEt3272OVJzha7dJfbv2CUc+avidR8GRlNYxEsd6qEA4iUHv6V4x6JPfIawtrMzNRASTjQa8SLfwsrQwxvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mka/3NXTv+DkpmGny/3YCntHT1LUsx9/Cu05bmAiXc=;
 b=T+gMEUCAhboRFPbxAxEpHkYNp/nOW2JCNWVj0ctLN093TU2WtgNTBEaofEkdL+1r/Z8LtXDfgWjpP0TeKlCqjvoz4pBpJwsU0W8n1wW+YTNNOievvrrL3SrRLkwd5WKpgahF+L8bziohkHuQaS7e2ES8LlYqi3udXg3uUW4GGNf8/avWqZEqMPMYJ+OeS+EZuP38UE5qAjUwvaTgVuciZWnqrA0a+zGcukCnopg4jlb1OOLqhb5e3r0vHHkeM1hirRK43R4VIJxQAJVG+gz6wTvzpm/X211XA1J+Gh/QjbpDmjOPoxRdKrDHzJDkPaFva18g6sRScNy7xP///KhgOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mka/3NXTv+DkpmGny/3YCntHT1LUsx9/Cu05bmAiXc=;
 b=B4Pn68yr/JPpm89ZlAR2dB7ieBP6mCQizdO1QykTiyem+183kd/YgcCfHQJyJzDJU3QwPOAU533kfkm6Wm2fCVj4AjC+F5u63gAPzoKKrA3na+OPiSuSjA8IBUKqB/utcSJw4GaWec/EQjfwjgGJRzbAhZVi3GuoYiDMTC9qtUY=
Received: from SA1P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::20)
 by IA1PR12MB7734.namprd12.prod.outlook.com (2603:10b6:208:422::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Wed, 25 Sep
 2024 13:40:00 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:22c:cafe::21) by SA1P222CA0019.outlook.office365.com
 (2603:10b6:806:22c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27 via Frontend
 Transport; Wed, 25 Sep 2024 13:39:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Wed, 25 Sep 2024 13:39:59 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 08:39:56 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <sanju.mehta@amd.com>,
	<krishnamoorthi.m@amd.com>, <akshata.mukundshetty@amd.com>,
	<Raju.Rangoju@amd.com>
Subject: [PATCH V2 1/8] spi: spi_amd: Sort headers alphabetically
Date: Wed, 25 Sep 2024 19:06:37 +0530
Message-ID: <20240925133644.2922359-2-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|IA1PR12MB7734:EE_
X-MS-Office365-Filtering-Correlation-Id: 79a825d0-cc5b-4f57-57e3-08dcdd678cab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3OgiUBRp6CLYsP/S3rMNkR0HAXfA82uVTIFppe+lpv6jBDhH01jWKoU/Tpwi?=
 =?us-ascii?Q?/uwbJ3k+9R22G1KvTgdxMxRhkDt2+drM00OsSQgK7ej05SxJtkEmH00zvcMG?=
 =?us-ascii?Q?d+ZQksK/Hogz6IxCNXnTQPMh2Not3AqmBb4v/i0VpnbHt3nSfKYmHad02GdX?=
 =?us-ascii?Q?cSgbS7YqoBCfE/7e4hXrm6d7OPqAoygrDL6qlaphJomWjyOKe/CArIO2uYKe?=
 =?us-ascii?Q?5QJvW2qpCi0G3hERWXqaBwvSwVuvPUiIXgMdIZeuoeO/NZM32Nlnd8j6rBjf?=
 =?us-ascii?Q?mjZfikWt087QuhV8kQ4OPSRlrtof47mGZ5hQs41hoGLzmeuXhxZ+IhUj6tlU?=
 =?us-ascii?Q?Hc+fciH4k56qiSo61ovcwlUQuPYLrTFYjvZ1rGs7uB5bYzMNx6eTJeZrTUWn?=
 =?us-ascii?Q?a6U2t1gqfjbR0fMxiXVefL49otkDXxlsS/ppATitu8mDNmCyRGb6XWb+Xhl+?=
 =?us-ascii?Q?MnUgrELoKYIFmZdBL7brVh8baFKz02tuMabYgpDiNLZOU+BESJcaWIwemdZE?=
 =?us-ascii?Q?XaiolVO0X2jlQxDvnG4CvbyoUlH+woOVgCYlNc7xJiYPKHgp1adcI1cPHJZo?=
 =?us-ascii?Q?osJc997vGDGzQoWpe85K7ma4TyRnSjYz6YTo8ojhQhYpbY9jPkqY2HyY8fNx?=
 =?us-ascii?Q?Lhmu0aYcXaNI6E3U3kvn55QZU6kqp6m4Llnim/YFHfFtGvfpJ5L2Evh6I1mK?=
 =?us-ascii?Q?h4RSqQnGgeD4jSRI62oJi303eaEnJQ9DiJuZVqA0OuVgQNwoy9q94Pt8GR4P?=
 =?us-ascii?Q?IY7IHJcwOP958Kp9fvfPA8c9KwAiwzujoQFQYRZex4Q8nFFtbmcevPkf6Gqy?=
 =?us-ascii?Q?sVfCWwTa3BxVodjI5SxeN52XJjhjm01B6LIpJQ8J4Y6C4ZOoMc5eDFHwyV7t?=
 =?us-ascii?Q?w2jNjQ+69RV2Tj8JOUp+ic7/wBzNQqmUmcnOdS+3yLwPCIw4ELxq51NVzDXL?=
 =?us-ascii?Q?CCzEdK0uFEOvSkH/IuUTdz/yC75Goo9J0gkrKnHvrSKjdczjGS6zJNQWYMef?=
 =?us-ascii?Q?lKam/9UVtmu/A3Yf+I9mj/9oEosMinu9wyCdXdalwUrvK9vmTs+rCCKnnCIC?=
 =?us-ascii?Q?E9t+Ig+If0fKLEbnIuWdmsho23ZQ91u7+UstksbGRKy2USQJya0RIm67ZKbh?=
 =?us-ascii?Q?yJXeLUqLfJWqxSicW/nKd8FpJaheA7ibSqnu/yFNAsGx1bfWpp1OvjYXx9fj?=
 =?us-ascii?Q?dorgBgCQPmvXd96pXeOzuPIkqSVFt70kLe9O5b+0jYp+lUSSGFcYfk37EAen?=
 =?us-ascii?Q?1/v/Gugw4mLD5fYP4oLnvMmIrFwibYVoytGesX4GfC4DF3CvsJ2rp4LbOX8B?=
 =?us-ascii?Q?7dGVeJ6Ont40i3+ScvYKSX9ynFnqF2NSKtvH0u1S0JY9E2UyGzGr+RBB6soH?=
 =?us-ascii?Q?qI5LaTgezwdT3lGVImsmxh/XECit?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 13:39:59.0239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a825d0-cc5b-4f57-57e3-08dcdd678cab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7734

Sorting headers alphabetically helps locating duplicates, and makes it
easier to figure out where to insert new headers.

Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/spi/spi-amd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index 2245ad54b03a..c52066360dfe 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -7,12 +7,12 @@
 // Author: Sanjay R Mehta <sanju.mehta@amd.com>
 
 #include <linux/acpi.h>
+#include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/delay.h>
 #include <linux/spi/spi.h>
-#include <linux/iopoll.h>
 #include <linux/spi/spi-mem.h>
 
 #define AMD_SPI_CTRL0_REG	0x00
-- 
2.34.1


