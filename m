Return-Path: <linux-spi+bounces-10693-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CDBBE3B44
	for <lists+linux-spi@lfdr.de>; Thu, 16 Oct 2025 15:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1EAE3BE7BF
	for <lists+linux-spi@lfdr.de>; Thu, 16 Oct 2025 13:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17246339B31;
	Thu, 16 Oct 2025 13:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZokuOfC0"
X-Original-To: linux-spi@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010062.outbound.protection.outlook.com [40.93.198.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761F9305E19;
	Thu, 16 Oct 2025 13:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760621392; cv=fail; b=UH6J1hyiLP8NKgcM7XfqNk8o6n8J+J8cG51FyRJ/oTTDLudTyLbRywwjMYkDzL/SZRnTT3vVrgLg5RbXHNXVOcbGVDH4CjqnhcLjeIOH4qt6e4DSvIkh8M4XvseobS2xCrNZfyCJJd1W3c7sIcb8n/nPvu6ixyGrrqZYhdsSaqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760621392; c=relaxed/simple;
	bh=fBjIz5dwFmFy6/GhiPKTvLiamZIORoUjdbV1/3RZbE0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IYlgJcrYVrSHYeqZ2TpPt7pNXWo4++N2/sfligaIkSYsYkBJwYo0X073/BILGuv9AETv8vfgb4pzz1Wo1wXQ5uZ9Eg38U+JouWUXrKRZ85JKnODGt84iBqYH5zC/EYE2rpEqlOl73U5Khw6nmE8LJyaVpZn6ieZ61xsLX9q2DNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZokuOfC0; arc=fail smtp.client-ip=40.93.198.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUvMeXQ7NjKOyAcvG1TWTqD987IqR/RJ45A867s46IiiTDYTBy1X+Ma6/jaOQiJU3Gvzq6FVlbPG6jGsphGw9Zj3rl0lPXoIwYFYRf31/CMg6HqDZ9fcC4rShzxZ6tEOn7ntl4JN1wlWjY28gm37nVGmWGgEFrMnYxkBcC5B0FnG20YwuDVDPjY1+sduK6RyRdnX6YMBoXuSbLVgaJm9XMjr50DpMLTZgzZYBXiWpsIemGn6EljK8avbShOwhQml5VUFvslzAqRwv/lzPlZsMJmy90dg33KrYaYhDXfSJC6psLkArvwghJLXYV3nPKEtrEYxRfJp5D3PXGnebbpZAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2g4O+VYYYx3W5XvMUOkCDSLn8MeWvopBuN2Nx+LB5fY=;
 b=wv/eyFHzinG5HZ1eXWxyJdiE3s1Z+fRR0oEyZNBv3Ll7hABeAQqM8y5G0u41/9kePGwgwxt86ZaYugfrqSmbL18jkO5AJ0k28WzToC+DrAyNU5yuow3vF5vcsW0cu8wlR2TFSHdf4weEjxnvzPGMc8XejscW0ZuGeNU5ypdSGsWLwe5PFE2qYlFBDTrXFuQQT9dlajqMNZU77hcFf/SylQWFjrwqrdwLDnQXJQ29ZENthkpG0jExDda2N7iys0O75yzUKUI0cTkLrhR59MDOtWiMHJDQDvuI/XTleOLeYm9RfLEunIIUHiHSfELOTlZlp/j/oJi+XEMiwiFvGvPrWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2g4O+VYYYx3W5XvMUOkCDSLn8MeWvopBuN2Nx+LB5fY=;
 b=ZokuOfC0ODcfEzj9oMeqBCsxRuhmndrDvVtYsdtyrK8q4fdYFOgVAGdr8tSVhppQryRNg+f4I5sJWu5UCohzQ8Z1f4I/X0RrNVmjAK3gSZABNUkOceSHltxzQKrlwbFa4IhO1L/lqI4/4N/VQwgr1JOhQUbNCtj0YB0/Avt7J7Xs0jw1CbSkY9SUOJjmqZq90SKm0hKDp+fz4ccgBEB5oaz2Ks5Z6W31+gIxlLNU+rXFJXyqEWlTa+0fyprDTmofcNijhfijxcK3GQOrQ1ycKr1Lm0rtsDX4E0zF3MK3apQfbWMLQiRXu9LgwTlSI5gOXR+qbggu1mC03/OPjgks4w==
Received: from MN2PR10CA0023.namprd10.prod.outlook.com (2603:10b6:208:120::36)
 by LV2PR12MB6014.namprd12.prod.outlook.com (2603:10b6:408:170::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Thu, 16 Oct
 2025 13:29:44 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:120:cafe::8) by MN2PR10CA0023.outlook.office365.com
 (2603:10b6:208:120::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Thu,
 16 Oct 2025 13:29:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 13:29:43 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 16 Oct
 2025 06:29:31 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 16 Oct 2025 06:29:30 -0700
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Thu, 16 Oct 2025 06:29:27 -0700
From: Vishwaroop A <va@nvidia.com>
To: Mark Brown <broonie@kernel.org>, Thierry Reding
	<thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, "Sowjanya
 Komatineni" <skomatineni@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	<smangipudi@nvidia.com>, <kyarlagadda@nvidia.com>
CC: Vishwaroop A <va@nvidia.com>, <linux-spi@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] spi: tegra210-quad: Improve timeout handling under high system load
Date: Thu, 16 Oct 2025 13:29:21 +0000
Message-ID: <20251016132923.3577429-1-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|LV2PR12MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: b6e85f02-d08f-40b9-1c4d-08de0cb8116f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FHoE5GA+XJvFbd7fu0KEf/o3WmZTos7/q1gpM+EHpG0vi2EHrchKFum/WgON?=
 =?us-ascii?Q?g/UhfCn5utiFPxSvXqTVpQjGQ49fiv9kTWU0PBrBoCT6TAOgiD8nRhBPePR8?=
 =?us-ascii?Q?Y+hWsKNhB5AgsOUSN51ob4olzJj2EAWbLz1aZr8HkkW8UYoH24xO2gvUx10l?=
 =?us-ascii?Q?pvSiMf0kFUZLb3IAyV71saiJXJNbnRnInAAUa01CgWtCFo9AZ4AyiGSCDudC?=
 =?us-ascii?Q?98S0GnyobxszngcXzBxz77FMPRhcHFXbkXS59W65eYAnN3M+3VIVr9fSKuvP?=
 =?us-ascii?Q?wKL0SkDuSMb0rqDWeY+DT8JILa3MAvXlP6+eylIw1ofoikFIssWxoXN9tid5?=
 =?us-ascii?Q?TIQ/tmzCtE8nDJCToRQocSJYppC1ddmf3wdSU73+VvVAFbrT+l6CtCZ/3eVl?=
 =?us-ascii?Q?VPK6WIxGSRyLO8de5dGgsebm3sV6K5AIntHF8416Th84wChnWcPsFU/s2WHg?=
 =?us-ascii?Q?lLdONkw+at3lF8jMtvOxLX4htodIK2Xsr422xT2wMuspJkicrRZoot8ylwY+?=
 =?us-ascii?Q?WKS2Bb8+Wx3uQIoMxVHQlaG1deeVW24KcWBpgAYdlssKUlSdbKvBk2lpMnY5?=
 =?us-ascii?Q?sZkgqGos79lTGJpCqE1OqGSAsqLL3d1SiKUrbkJy9H5VnJGwXObqH7Y7u8VT?=
 =?us-ascii?Q?Ebn+1h8RSJ+E/hOBhhBwCmall9OrtcIXTriPJdGvaYTihBfq/4Jvzfa5iwfz?=
 =?us-ascii?Q?MvsY/RzbmrmV9ecJQXwQzU4yJaTofpVaZ4hQo2wZYXCE5mJ14e2eCDmHeeYN?=
 =?us-ascii?Q?xZjBXVtI5itpdXX362ajwVfIdExFwAtsnkwRWWg87XZikVkavEJrGj1k/PNy?=
 =?us-ascii?Q?vdmZ69Zb6NN+MQN2o9foAL/W3/yUdEdlRQVhj++pWc4ck5+RXVYN65ew2EZH?=
 =?us-ascii?Q?ycnk8X9powHSG6KOGAHWbVs4KlZIR8cp/MaNL4BpPN/KyF5xkgjc/Io8XvJu?=
 =?us-ascii?Q?qMiOgPVCAfnoIlaZBKVaq3sxgtYHseHJ4ea9R1k7VzXGyrh7fLFwTKUY+b90?=
 =?us-ascii?Q?X4poVVuN+T6xDtQd2YTw+NdgkAsKT2SyGvnt5aT4T0fCN1/8EYZAiMAmJ+ws?=
 =?us-ascii?Q?yc/XnQX5ve2IpXos+4TP2s6hbVbES1hk6JBnFrPC0ndn9EeMJ3euZA4lOsmN?=
 =?us-ascii?Q?+ITeU/Q3Z+sMpsEVdrsMv/33PkEdsXsF6yuWYptTF6KUrzR3k0xhe64D1wwb?=
 =?us-ascii?Q?l6ewG6YwuI0D8x1PaTiOCSpkrjBrjKz/XCZVI8ed7dDLhZXjXt+Vjm7Ae594?=
 =?us-ascii?Q?1mnneiCL+SsgzBYfaizcmmeqHv+vtG4BYuTZwRHgLEa3LODEWuZ2YjBoLixk?=
 =?us-ascii?Q?nKd52fmPX01NPgcZHAawZRCskiC1Bv07LxKIjOUNGqV0wvAtGssroEpryWOb?=
 =?us-ascii?Q?Pg2MbidgvHsWStyWKk/kqMbIk+AymzXNzZXcOUz5ddaP2jLXzlJJLemYiu0i?=
 =?us-ascii?Q?ysTxVeq5Fo1LpzGvqziKnSu4uSO04zTIQD6flggqQ9ElNONb6EqjRm7nwo3a?=
 =?us-ascii?Q?e9hI9Mp/MSdDoIgBPnbyo6eYt4kmuRB78YSHXZGl1yKXzvSIss90w3EXSvds?=
 =?us-ascii?Q?RJKNj8CPNaNicLaih0M=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 13:29:43.7319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e85f02-d08f-40b9-1c4d-08de0cb8116f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6014

Hi,

This patch series addresses timeout handling issues in the Tegra QSPI driver
that occur under high system load conditions. We've observed that when CPUs
are saturated (due to error injection, RAS firmware activity, or general CPU
contention), QSPI interrupt handlers can be delayed, causing spurious transfer
failures even though the hardware completed the operation successfully.

Patch 1 fixes a stale pointer issue by ensuring curr_xfer is cleared on timeout
and checked when the IRQ thread finally runs. It also ensures interrupts are
properly cleared on failure paths.

Patch 2 adds hardware status checking on timeout. Before failing a transfer,
the driver now reads QSPI_TRANS_STATUS to verify if the hardware actually
completed the operation. If so, it manually invokes the completion handler
instead of failing the transfer. This distinguishes genuine hardware timeouts
from delayed/lost interrupts.

These changes have been tested in production environments under various high
load scenarios including RAS testing and CPU saturation workloads.

Changes in v2:
- Fixed indentation in patch 1/2: The "Reset controller if timeout happens"
  block now has correct indentation (inside the WARN_ON_ONCE block)
- No functional changes

Testing:
- Verified normal operation under light load
- Tested under heavy CPU load with concurrent workloads
- Validated with RAS firmware activity and error injection
- Confirmed no regressions in existing timeout behavior

Thierry Reding (1):
  spi: tegra210-quad: Fix timeout handling

Vishwaroop A (1):
  spi: tegra210-quad: Check hardware status on timeout

 drivers/spi/spi-tegra210-quad.c | 195 ++++++++++++++++++++++++++------
 1 file changed, 138 insertions(+), 57 deletions(-)

-- 
2.34.1


