Return-Path: <linux-spi+bounces-10896-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 892BDC156C9
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 16:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0E3F6350442
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 15:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83485257841;
	Tue, 28 Oct 2025 15:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GU5XoOVe"
X-Original-To: linux-spi@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010046.outbound.protection.outlook.com [52.101.193.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D3133A029;
	Tue, 28 Oct 2025 15:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665148; cv=fail; b=XC6RnqkMVXFL3RXHsTOl5xtEq+/V+oPU2FFWeokwykujX1S30nShXa+Rk0auJ0lOrGlWcPVDk8eDu4HZ374Fmfw2GVaEzIgXfUC9a0AQz6nmlKiDsyeUvJBdDesiRg/R+HDdLfEgOusc3X5gqT/uEICYkQ0LoECZ6qIByRlbxwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665148; c=relaxed/simple;
	bh=Ex1GLhvd6znbHI8+UZRiGXPy3EhBIebFrnGDqNlM+G8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nJtir3mH+lu49bzU5xRA+G+kdew7IZZsmnP0MDvUf0DijVNAFTrxQbNrMACEZ6FpnlsY/NIfiPHqKM+5Z1eW9TRM8CEnR+yF8oR/67uf8TGbqHycx5bMvPsGupHtvXGUegQbEPd8HmELyIWCNUJg8nCUb1VRxBt3KjiKZ0UH5Pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GU5XoOVe; arc=fail smtp.client-ip=52.101.193.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DuatKY8ZfnFqz0klUwoJeD5W/g8u1cEGXNOdUy0XCfdqz9QQA38eRigi0Pb2gA0+JNS+3dukykb/CR9hxKx3gzs+q8MmP5YS71GvR66bwxjAwYdcf7I38y+p/rvTv/tRUAEs6lfonarYrgsBUsvCZ1XkchE65FH2hPV5FKjNNwP6ueAQMkZkT5+4Hbxvl5aZ9E4FHJKtgIQR9BB49hFDj60fzZNPrBSEmcUTKxZ1fXlW65b9rLJZCmlodztJ0XzunZPQktKscMDO9JG9HQxvZtfHyh6GMrtAOdF0RWAT9LhMHw3h2lykpQaypl1ZIWnNn8qiVnCSwxSexxkk3Tx1kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0FFzRkeKAh2Wces5bT8aE7kJoTbTGURlx/RR8STc0g=;
 b=Q9BMgpeYzid1HDAOobobyTj0KN2yreiyVn0ZGi1y2oVTWTQasvVKTR3M8tM9M9GPJsH36f1UCWQSg3/9oN3CU4W77IO8EEhSWClZS9KD/k2WVfKrKbVeoOtumrA5Ok7uSSn1kWDb1lORfj81RmME/LJoGesHKZ48qN327G4aoqhjqRTABEE7Z78OmIr/Cf5k4ZEZZJQ8jT/LGa2fOq1fLfl4KzMvmbzvOOw5D18BE7HLAs10szZMl4dPF/UH/Rcv2aOC8dylsL9FjVOCt271fOw8neDJkxOIrGJMkVIGLdxjD7FrELZQoHkMQd4MvPyT0pJ6rzhqw1r5s/ruTr+tvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0FFzRkeKAh2Wces5bT8aE7kJoTbTGURlx/RR8STc0g=;
 b=GU5XoOVemftxv5LzVjvtMQ+IZp2FPjDJCiTFIcdnK4x+jhi1u/XdFtKS7ypgGhNtUJBs3gLt6H3nOYRR1jW0vkthcGBOmzfNfOz7GK8BJf6GD4Q+c8HeRNzpzgb+Yq4x5MHj9aULjVjMmlf4jQln8Q+xBTIGkGJ4ulfHP2SQi0sahgp6XLSBi22bUKNmlO0rWhpicBZw4tZ+8EdayQO3vsY0qL/IVv9Bs8HMArXs40k2pd8ICg0pI29DfzNYqL0qG/8i3NrZiYANSzVmawnlYNg3bjNr1culCji2oLXH8Xr9+0tW3jCUI+FvEtjTWM2LWtD7zEtXJ3gMDkcu4+wIow==
Received: from BL1P223CA0031.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::6)
 by DS7PR12MB8418.namprd12.prod.outlook.com (2603:10b6:8:e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 15:25:43 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:208:5b6:cafe::9b) by BL1P223CA0031.outlook.office365.com
 (2603:10b6:208:5b6::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Tue,
 28 Oct 2025 15:25:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 28 Oct 2025 15:25:40 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 28 Oct
 2025 08:25:25 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 28 Oct 2025 08:25:21 -0700
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Tue, 28 Oct 2025 08:25:18 -0700
From: Vishwaroop A <va@nvidia.com>
To: Mark Brown <broonie@kernel.org>, Thierry Reding
	<thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, "Sowjanya
 Komatineni" <skomatineni@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	<smangipudi@nvidia.com>, <kyarlagadda@nvidia.com>
CC: Vishwaroop A <va@nvidia.com>, <linux-spi@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/3] spi: tegra210-quad: Improve timeout handling under high system load
Date: Tue, 28 Oct 2025 15:25:14 +0000
Message-ID: <20251028152517.4144609-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|DS7PR12MB8418:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a237c6b-68d4-4bcf-0ba0-08de163640cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q+TAuPPYkB2iLmChnWpWEGXsqxwtN+dAEKNUzTNMiT3cafOK8qb6MYP8F+d6?=
 =?us-ascii?Q?M06sus6g12HWxfEkAotlfuiJ5GmVy2UMT+JzgQh6IM5SdggccGMtaB/B+o3p?=
 =?us-ascii?Q?JghoJFoeF22rcseg4tABVJuEz4NtPNTU2kuZbatO2BdjWtHci4oQBcIg4+qz?=
 =?us-ascii?Q?/10nek02w5y5v/aENYsSDekjYW1W6xp16dND3zjZD2opnedDWMkmDoLxpDvT?=
 =?us-ascii?Q?6sk+pCRvaqolmo2qBzkgH8aAQ2yQHtiMr1CbHIc1ES8ZGEJU02fiMgmdZxum?=
 =?us-ascii?Q?DKg8oYFyf2X/fs2ZoJ4pwSN4SygpwzWNPvJ7SZloVheO0VnDbjSos7wOrj1t?=
 =?us-ascii?Q?z0qkXCuVxcl/pcoU1LUL0rpnJA1sfancYlrO8Qw4WKmGOyWP6CUnDt7dH/6B?=
 =?us-ascii?Q?sQLVLSSBAzayZ9hnjOdUAYlgC233LEplS4dQwvv/P+hqfAsNjnDwqRU5w+wT?=
 =?us-ascii?Q?S7mCzaVZ1VoV5avhHNlPlzuxX+ZfZmYB/R/WTs0Crj+T7HfMh8k6BvQMjic/?=
 =?us-ascii?Q?vn7i4tES9sbf6Ij3g72NtDNBcVK8Nq8nMt1/xADOTgiRK2r2okZyYYNizGqC?=
 =?us-ascii?Q?he9UuGvSFYdLK6vmmTUyAvhDgxz3vvxNGw5Ca+35h3VsKggUWuzSy4EfJt8u?=
 =?us-ascii?Q?k21NwIReh/imw2er/PffIlQFD04YIiKLTs2BOZ4C3+XKRksU/IePum+9ulk3?=
 =?us-ascii?Q?A2tIh0USm0K66kMRbv15W2Cky+6yguB6fT6TJEAchzS6FCW6GGRyON83lAxx?=
 =?us-ascii?Q?eu+SsuoV8FkcPyz6OHikWtNA/1QlXeviVRUvXpzQbTTG4ncqqIeK4UzfUkBJ?=
 =?us-ascii?Q?87PoIW9VMHq5mYIPmIMbXSjYufvE4VTnCCh2Ck1PQ2Ze3BdIInDsYZW+d+15?=
 =?us-ascii?Q?+yAytKeCdd0O/6c5b+opMM9XF5wLXs5tLK9RIcLE9hvpwKePQTjQ7LblecOw?=
 =?us-ascii?Q?r3bO+QXPipendHYwDBNlIb3hsHd8ZoPqFmnUr+rEqhIEddIocxlFeT+iiU+v?=
 =?us-ascii?Q?vH88DtW0EgNhdAv50cgV7UtSswjL+G+qpr0ZawsNH46J3cPrlryi9Hn8Iozo?=
 =?us-ascii?Q?QH5Ec7SQi4tN0Y0gJA1TT2weL+Bd8p2URIwwsBXiOPcNsOu1c5c9dr/0n6eT?=
 =?us-ascii?Q?NocwpcAwlo2vPklm02M863nBqg7RvgUBGgcEAadn6hqko1GqNqrGBx1UDqBk?=
 =?us-ascii?Q?siskJF5U0CVxleB+WoTM5VFp0ZC00ut1o55txmHqkhx/o2lPPcY2LCGdbKHx?=
 =?us-ascii?Q?wScYIWkRmBxRvHf1MPvid/ldI8uUV6JvuAWLuz/Gn4nud8dyUuX1E4aJ1obk?=
 =?us-ascii?Q?uGjJdIsag/o1pCkkL6fTLW6FTjS6Ta5wOrL3xChst4JI4icN7M7vQ3Y1Ul/S?=
 =?us-ascii?Q?wzxlOXTJlrdfIze/1tM3hxYtKJtTW+nrz+8HDoOxAd7d8WXqqA95gKlLsH6m?=
 =?us-ascii?Q?fYQfhtUO/jXfelOLvxWHOQ2E0b2XQjCctx15tLzIHh25XOl27Zbm114SOq6Y?=
 =?us-ascii?Q?SaAbQfrPQkZuIGdru3ZR2FM7WWM0KYrFJppVaH+8yUfHKqmoVlkiVxPN5aRm?=
 =?us-ascii?Q?dRCX82O4TxNpPkP4uVk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 15:25:40.2629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a237c6b-68d4-4bcf-0ba0-08de163640cd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8418

Hi,

This patch series addresses timeout handling issues in the Tegra QSPI driver
that occur under high system load conditions. We've observed that when CPUs
are saturated (due to error injection, RAS firmware activity, or general CPU
contention), QSPI interrupt handlers can be delayed, causing spurious transfer
failures even though the hardware completed the operation successfully.

Patch 1 fixes a stale pointer issue by ensuring curr_xfer is cleared on timeout
and checked when the IRQ thread finally runs. It also ensures interrupts are
properly cleared on failure paths.

Patch 2 refactors the timeout cleanup code into dedicated helper functions
(tegra_qspi_reset, tegra_qspi_dma_stop, tegra_qspi_pio_stop) to improve code
readability and maintainability. This is purely a code reorganization with no
functional changes.

Patch 3 adds hardware status checking on timeout. Before failing a transfer,
the driver now reads QSPI_TRANS_STATUS to verify if the hardware actually
completed the operation. If so, it manually invokes the completion handler
instead of failing the transfer. This distinguishes genuine hardware timeouts
from delayed/lost interrupts.

These changes have been tested in production environments under various high
load scenarios including RAS testing and CPU saturation workloads.

Changes in v4:
- Removed Change-Id from commit messages

Changes in v3:
- Added missing tqspi->curr_xfer = NULL assignment in handle_cpu_based_xfer()
- Split the previous patch 2/2 into two separate patches (now 2/3 and 3/3)
- Patch 2/3: New patch - refactoring only, no functional changes
- Patch 3/3: Functional changes to add hardware timeout checking

Changes in v2:
- Fixed indentation in patch 1/2: The "Reset controller if timeout happens"
  block now has correct indentation (inside the WARN_ON_ONCE block)
- No functional changes

Thierry Reding (1):
  spi: tegra210-quad: Fix timeout handling

Vishwaroop A (2):
  spi: tegra210-quad: Refactor error handling into helper functions
  spi: tegra210-quad: Check hardware status on timeout

 drivers/spi/spi-tegra210-quad.c | 216 +++++++++++++++++++++++++-------
 1 file changed, 171 insertions(+), 45 deletions(-)

--
2.34.1



