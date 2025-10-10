Return-Path: <linux-spi+bounces-10525-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADA4BCDC55
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 17:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 261464E140E
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 15:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1072F83DB;
	Fri, 10 Oct 2025 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GL04tCLJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010041.outbound.protection.outlook.com [52.101.193.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A80126E16A;
	Fri, 10 Oct 2025 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760109630; cv=fail; b=VhQFDgaKbcpuabekptOOFnK4h5I7jCTQYaEUomCwsGwgUGl5YDaTXsPkgt9BP4rtOE7MFOlb+uawaeERvfUzWn3hKdBCiHB3BjGvUZGMQWvr0+tBiWQWsZLsMAs7C7YXhLBZGEowh0ZlJSArsdI4yOi1gbRZRfAF4p3zjFpL9Ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760109630; c=relaxed/simple;
	bh=ugSOBOyNO5tZ9S+vuYwm76iiXmzUSiq/IJF+l9gCMs0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U62wjNajL5RFQE2VE2syrgQWWy4EI0gYBWv3g0Dn8shf9npU802o6vOxdNLGHgvSUaZXOxq3//CyhYaxzR/2fXhZ705dyuLqJdVvPK95GRoyPd7bVExmFVx1HTWNHfP4lINLUz4lxjhOePSt0iw2ouKXy0yDhU82VtQEV5vqZJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GL04tCLJ; arc=fail smtp.client-ip=52.101.193.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P9W2WU+Jas9MML1cHcHWYT8yojVyhVDqbqLoT6LkqBVAkCUN82zbFKe7/B3UQ+xilpgZ9imRgcRuqnoSdib2sX+0P3EJxKg+kY2B07p5ayAIo8xmlwurQttlcr79yu+oK2+efkTb4X5Ex+0V+9zvumx88ukM8CeZ1kYmY1JpBgfdfwyUmGextoaHFIhJHbtqj0eTzfl2woGTeefFAP0e3ilp0oKrASQYSdYgrTgEPspzC8pJZV4GkdhxBtPWZbxV677/RjvisqnDe498q7ulxUfAfzLzqnILn7ThgTWP8Rit7En5wRKdgqOyDHalRgCxJrLE/EoDftWUhoXgMbWydQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Xurme1AlG5ZgnJp3Rv+fwtoAEIeYDZcnugjZfZ5c5Q=;
 b=Pd+atEKn+IwPy6NBv9z9nY+LR7vxfFBCiizl7SwSBtlAvGaZ/0IwjSlF466W3yHaSGPJzmaR3yXwOUls1m45S16lbhwJE6UB93aHvgb/hbfhrsX1eQQ5q0ogFwfmCbUMx9A5b87SrYngct/0XM6eJfvYUsp+zwcoNaWzQafeQ3XH4NdoSHfS3wmQllCVs7kv/m0vWsm9rqKmoBKe8eE4hC8glYD79W/wxbc3lr9jUidOB7hFC/g0AqLj4hpzHrQB987oWIiwRAiv/RnZqICODxJzjuYMCoayEH1mjLXvD4uI1BSb4P4IHxPFrZ4iEiz5/aa7a5djpWBHrclw4nC3kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Xurme1AlG5ZgnJp3Rv+fwtoAEIeYDZcnugjZfZ5c5Q=;
 b=GL04tCLJqNaYtdugdBLx5aXU68ksDyAFm8/hJSyetKV6le9VbSo0LeTexi9lBzHSYY/gch/LIU8JvJeGcSzzFXMyoG0dSuuVtnqIONfEPMeI4MwRE3OfBZ6cK0kxJw6Utvq97C1fYl+IQewYi6+kdnJQvespfyViznIvnDp6WjrvykSFvXSC+4J0KXW7a8UuZHM8AgoUUCJ7qgkQ3pL1/tUYsfDS+36Gg78/VjcJ3Osut8ZAo5Ep0ecawGQNorN00mKiQhCT4eZYUi1dDqbXj9FCY2anYaQ8uJSiuGkjDKbgx6x3k1zpIQDLxcsVi9EemZzpTgxJt39OOpFnpMbCQQ==
Received: from BY3PR04CA0021.namprd04.prod.outlook.com (2603:10b6:a03:217::26)
 by DS0PR12MB7969.namprd12.prod.outlook.com (2603:10b6:8:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 15:20:26 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:a03:217:cafe::90) by BY3PR04CA0021.outlook.office365.com
 (2603:10b6:a03:217::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Fri,
 10 Oct 2025 15:20:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Fri, 10 Oct 2025 15:20:25 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 10 Oct
 2025 08:20:07 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Oct
 2025 08:20:07 -0700
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Fri, 10 Oct 2025 08:20:03 -0700
From: Vishwaroop A <va@nvidia.com>
To: Mark Brown <broonie@kernel.org>, Thierry Reding
	<thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, "Sowjanya
 Komatineni" <skomatineni@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	<smangipudi@nvidia.com>, <kyarlagadda@nvidia.com>
CC: Vishwaroop A <va@nvidia.com>, <linux-spi@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/2] spi: tegra210-quad: Improve timeout handling under high system load
Date: Fri, 10 Oct 2025 15:19:59 +0000
Message-ID: <20251010152001.2399799-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|DS0PR12MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fd9c31f-785e-49a2-d2b4-08de081089e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KAHup9s+QdOz3BNyy8pEyBzAYoI63b/xQuhZ+gcYiTfuouOh0iL/nVkTIroh?=
 =?us-ascii?Q?dZPXokz8TqFKqb6mTxZj5tjNvY35fQVsibqQW9lcrTXBL1D4ZpRBjouXNp8I?=
 =?us-ascii?Q?NPlq90b9jJBG1zeClFXXcnDev2WiCbCAEaw94YxC9QAfUji/TNvNaKq0rQep?=
 =?us-ascii?Q?6PaWtPxdF9HkXNh+G02e2frGjljz60QQANYePAzWb+FuKtUSeujsw2Ps63XA?=
 =?us-ascii?Q?vUWSEN4WVRRKPqHtp+msUG9oZxkeQ3KcjJWi7CZNonzwiyIDIUfJxpdl4FR3?=
 =?us-ascii?Q?6DgNkNVrbNl2PcRlMrE2bncQsOUR4fEe365zjZpV6TtWC6ggX5KwM3V5j2ux?=
 =?us-ascii?Q?HnxOvi2YI4iAUYjP9f98ADeZBrRuKk9kfRHoYFUFkWh2m53T1vf3556Mo/LI?=
 =?us-ascii?Q?V3p1wxfV2me/cCWNJrQJH3Xj1Nr65q4zKfU2B7wL2tf4hfsLZ52PTNmzln47?=
 =?us-ascii?Q?zFSIMUf994kI4V4MMgvX1IO9WLbSIpkACQJHZf0NTE+xVRYrf7Qxk+TBIxUZ?=
 =?us-ascii?Q?GBqRYlBGpBBkh8qUCHR8dKYYPw6ZsGFKkoI0Z7UP2CstENmEkxgKm6U/TkDr?=
 =?us-ascii?Q?+CrHcF36BwAcM77blbX2A8AuVTn0fc//GJs9KLH+IBEr+aa/ohtcUHTipo48?=
 =?us-ascii?Q?nKXXo7LLzRi7FiboeVPysg2L8sfXIHScZJXzDSdgIcdn8IdGlKPOQT8+arQJ?=
 =?us-ascii?Q?Ye27FJ1IHDDYEuQVWzmItZwI7MlZf37+d/BeSgyckG4kZGTX8lgKgTj8A7IT?=
 =?us-ascii?Q?IPJUrOKq27eXmg3pg2w+3THJumUO0Ae9qkXd6f4052cmKk+BttfC3vZzhoOB?=
 =?us-ascii?Q?KnL6HK1RRqoscKdiJuTucGUBmAqAHnaEJHtXiWbMWs62855Gw4LyCHmjtxJN?=
 =?us-ascii?Q?zBnqWzcSh3JwoHLfTK4lBXxkiX2k7l8/ypO6EVyxXOzH+TXeACd2jeycX6CB?=
 =?us-ascii?Q?dHoWjxz7u2gdEpmc/XS6kESDrpX+gzLLRCdMttFCvE73aaEzYtSkmA718fHV?=
 =?us-ascii?Q?5AJVjvIb+tGHTcNjv/w7D5zUSVW3OncOXGzOFMX63i1VxgOm8ooeHdJCOP+y?=
 =?us-ascii?Q?2vRife9cQKmkBNDqOGVj83rlZHt+ky8+GJdtYKvmB1oD8DiW+rqeQ4YERaVc?=
 =?us-ascii?Q?oV2Lh0YaOcILqFNGyR0IB61N3SfQRcKAF84fHP0uL384lYeNd70OFGpztFmC?=
 =?us-ascii?Q?s52HBpzhQrdS5ZYgmg6xgCdpn2d8y5eBL5DhxK5GgLpbMpdAwlsldllBJctW?=
 =?us-ascii?Q?HJXUVAJNnFFaOzNYJAGj2qUlLnsMa3mRbucCmH0fZxBkI1DSqfj6Y9RFOCIE?=
 =?us-ascii?Q?VUHuSNw0vuV9QPcGmxMvBSjX6+gmRBXJ9DnlkfSU/5HsEFsbzeuC5QdbLGF+?=
 =?us-ascii?Q?RsmkSBlI+qyxuNoF7UeM2MmJ8P2ni1XDYitXBb/132xjo0LfHOsjhHKtktor?=
 =?us-ascii?Q?BBM4iHBLivOirZyMRXzCTNdnynzDbFF4Uy7cWfZ6oMBiPj/f9AkSpj6Aa1oH?=
 =?us-ascii?Q?8SZMq7sKEZkXMOzCLmFgZHCjFINLYaxvR6p4TR6VjxaqUyrX5ppcxtW5ZJkW?=
 =?us-ascii?Q?m7JlyJKxAmWyVUM+dJ4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 15:20:25.7716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd9c31f-785e-49a2-d2b4-08de081089e2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7969

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


