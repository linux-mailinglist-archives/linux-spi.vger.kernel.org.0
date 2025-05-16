Return-Path: <linux-spi+bounces-8151-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B51A8AB99BE
	for <lists+linux-spi@lfdr.de>; Fri, 16 May 2025 12:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CA973BCB56
	for <lists+linux-spi@lfdr.de>; Fri, 16 May 2025 10:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDE1231821;
	Fri, 16 May 2025 10:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hY/sT02b"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C51B23183F;
	Fri, 16 May 2025 10:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747390074; cv=fail; b=QV6V+bIDgnBOmsQwUqYcz3bKh0HrqcO3FBuhEyu6P6O0EKgFiA+nMyxHAwt5sZsF1FEaXs1nVhp5RtuayPSlxQPW3mC5hpOJfC+RCY+7DSNg15064gBbzw/5zmv5hid1v6rd5rYnWZsz7ld+bhuYsu4hQ7MWtz3ZcxqspeJubkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747390074; c=relaxed/simple;
	bh=BlxxRWmMVbSrgSXhK2bjpMsrybJeJmzba0o1DZHEQ1g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eVhMXVNoLG5+NTirgRUbI3CSF7VRgRosPpPPQ+hWYYnRryt+uqL+313Og8lrenP4b3T9rnpZoz6qDJGuAWntnGe831Zp7cy6U42urrZC6vZNvfzG/P9fBvAK7ukzM1CmxfPzlHmVBxsk2Ti4cNXiFdXHMfeAD7MD5yTYrTOUeWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hY/sT02b; arc=fail smtp.client-ip=40.107.92.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pdJkkkrom3wcki0Tdi9IyTLRcfi/URRPI9ZUt8ltp5ETLzhyf/w2MAhLGAlG/i75QdQpuaG5AK+C1LvntQ+EU+LIB+4rjhJyWweXowCpDMUM6d6n2v81GDxfO57jxZyZzBk0o1AkcnwFExq4d+Cv1VkzE/ig4QiRN+upbGhcOOGnwkWETAFLGRGY9yEtqAU1B0C5yr1UFWFh1SDOBmH0Wv4gDF1Qzbvuc8JfejrZOT7GluOZE1fs/QtZDXW/gkXEpQQ7HPP2Kw98XdyRGisYSVw737bTWw3fhd/5TsWryZ5M5SUpGUtyNAMU0cvIn8jDUF2QflQF63uO+3W+P4n/Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DjbGsVtN9Ghsemb1k2ugh5+W9Q+OYWFaG6Uejmr/hMc=;
 b=obYLCud2Sbs2oTFkeOT8hm3YlNux0YPfmVRDijrAJNXpCRtMdRiMdAVgZQTVTcSVgTY5UW0ceEJoJK4T3LTYjof7y2FVPAtlZcOw9C7ZmhiBVoUPvHM4syQFfLhC7F95CEfY8S8E3Mtd3WLEAB/ou04MBNUe2TqNJPDAEpazMjhdCnDTnBDvtCYl/Lf6p4RY/UwAiwNWYE8yL8lhRIHfIFE2aSxls2qYDzPeJeQTuDx5PaPVnTkTkI0/aiXt3MRr8ZiCLAU03WxHhkybGCdomgs0HjhWtcxXret4vn9UmBVq/kGwbJt/ivA6obCauBLgIgXENt2aNcf1QPHXOrvekg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjbGsVtN9Ghsemb1k2ugh5+W9Q+OYWFaG6Uejmr/hMc=;
 b=hY/sT02bMJSvR1A6LNGRWa9qDFcvBVyppGvGVNDy8s++7rqUg6ABYyMX6Gl9v+mtP/VCZWfyl6nV/l2otuPM67wtj4QH9dJEW7u1Hsxgqp/Vdx/k2ZBS/PCB+I24ZHSwovxEv2x/sMd0P3QpWmbks/PqsoW2C6U64FUD3xA4M1c=
Received: from PH8P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::9)
 by IA1PR12MB6065.namprd12.prod.outlook.com (2603:10b6:208:3ef::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Fri, 16 May
 2025 10:07:47 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:510:2d8:cafe::13) by PH8P221CA0004.outlook.office365.com
 (2603:10b6:510:2d8::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.20 via Frontend Transport; Fri,
 16 May 2025 10:07:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Fri, 16 May 2025 10:07:45 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 May
 2025 05:07:42 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<krishnamoorthi.m@amd.com>, <akshata.mukundshetty@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH v2 3/3] spi: spi_amd: Update Kconfig dependencies
Date: Fri, 16 May 2025 15:36:58 +0530
Message-ID: <20250516100658.585654-4-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250516100658.585654-1-Raju.Rangoju@amd.com>
References: <20250516100658.585654-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|IA1PR12MB6065:EE_
X-MS-Office365-Filtering-Correlation-Id: 624a22e7-a346-4bab-7f47-08dd94618145
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U0JnZZyX/q7Iq1EIbzBwVnZPN4N0RedilT45nAzQ48B87h/0UfWVkbXnuUnK?=
 =?us-ascii?Q?hY8vzg1sMCrjVbian7r89bm53ryKO4bZQdQ1o8GzY6/3hmm5PrvKgIBYkUNF?=
 =?us-ascii?Q?KYhwQtfh3xU8wNKIASQH0RYP7WP8VdtVN1nu0XCwQBHswAb65TV7drpUeG+D?=
 =?us-ascii?Q?rZarNP5Ve7IKTui7sX5XTEqFATAUiFvVxoptf6rojI4yjQTNHLO5uBihOJaE?=
 =?us-ascii?Q?GMmRgX8yu7n4t6htJw7pv0pGY+T2S8B/AqeEnB65JL3IxgW4UE0MLSxDCZx6?=
 =?us-ascii?Q?LL5Smx6Z0lc8VBLt8iTOJ9C8vEz14bOSs8RGSxVHgvzbDShlAvRGPVLCEB1M?=
 =?us-ascii?Q?R4ky/fzGeLp303f0smFjJLpDxDPlRxxYApg+BR5d7Tz2be9kud8ZRZ44Nk6b?=
 =?us-ascii?Q?DKtOtIzXde0oejYCUHthqZw0M9vkrx1REulzp8k6uAxsS2kGhSeJmFRW5429?=
 =?us-ascii?Q?XJYKbB0TRxEDmJ6ECJYF7UegivS2iQoJnw1fZ7Y5sJ3oIBbpEF50LVUE5ea2?=
 =?us-ascii?Q?La2KG8+9d2zvM5RMtafX/oc1B779ydH/rmooeknI0WRwFXaZwkQNpFc6aDWW?=
 =?us-ascii?Q?w8Dd9evFSqI5QiyMCLyKN/9RyIjab6HagPEZL9Zv+yLant+K+Mc7MvbC2wi2?=
 =?us-ascii?Q?gBsSDHuWQ8o/+a39zUL1vDGySg5dF+S1vYpyW+jX596Wrln/9QIywIbO8zN2?=
 =?us-ascii?Q?5vP1LOyiN/QxJR5NO4w6fFE6a3nG11Z7tDN0tO7oZMm7ROGsfhULN0vPFnhh?=
 =?us-ascii?Q?XKeeRtufg5rbceGU2lzsjhfTbebwuijf6e6KWKG2wzIOcWVUgtGvz0+m2GnF?=
 =?us-ascii?Q?Hywwxld2kkLHdAFHDFL6VotN0h+0Ud062NDK28K3aiwwBXp0f+gKojPIpwkJ?=
 =?us-ascii?Q?zUy4YpPUBwrg9io+5wyVNvkJusMeJz2UUqSmznxPKR31g6V6GkmuFBuPVPLb?=
 =?us-ascii?Q?Z4qhWd/t1mSvknmndDzN+lnQNPdDqTylLeuAbLwEYBrU2bx2w3BR0O2u7sOI?=
 =?us-ascii?Q?a2xG+e6bFFFSHByoYkjIsYfFgVRLfD5YoBkM61TU7sn2ftb0O4aTwUnAufSf?=
 =?us-ascii?Q?l3Gy2v0H48vEujRNZ3dPo5jPpqr3EeDgd2E8J7tn5EAlQKskLzKvRH+I3W7h?=
 =?us-ascii?Q?FzVl4X2wugg0RPJl0FKVhpBUM5t4X9rXQObiyO81v/eF2rgVaOig6lQ9LMKG?=
 =?us-ascii?Q?opXMmqhqAt1fweyhI/B5OubwF6A8nS1S8zHan/r0WZMMCOWh6dJIGGD8raIM?=
 =?us-ascii?Q?Vgy2VfMC4fnk3ZZBJW53R8Rgcoi1fwEfi3I5aHU1djedazbrtPrdyElFrq7m?=
 =?us-ascii?Q?KSV84Xk022xEffvGHqtpSl7vwAUMvcnszicJnu63tyt7yZhoE5lIGbRwlTTN?=
 =?us-ascii?Q?Ti4NFboF1E71ttlHeTKTi3tL4zyUEYdbKSDUqdrK/s14KUgWh30eGgMepY5T?=
 =?us-ascii?Q?2Whl6OrthM4A2MnSYdiMb3ZJjwB10EEoglJpdUUQgPjlnPft8C7hhiwgpgQb?=
 =?us-ascii?Q?cT92gFvRDbsda1E7grUpoG2aVbPu6WLOjS9q?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 10:07:45.6770
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 624a22e7-a346-4bab-7f47-08dd94618145
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6065

Add X86 and SPI_MEM as dependencies for the spi_amd driver to ensure it is
built only on relevant platforms and with the required SPI memory
framework.

Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/spi/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index b03a7005f1bd..c51da3fc3604 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -1267,7 +1267,8 @@ config SPI_ZYNQMP_GQSPI
 config SPI_AMD
 	tristate "AMD SPI controller"
 	depends on PCI
-	depends on SPI_MASTER || COMPILE_TEST
+	depends on SPI_MASTER || X86 || COMPILE_TEST
+	depends on SPI_MEM
 	help
 	  Enables SPI controller driver for AMD SoC.
 
-- 
2.34.1


