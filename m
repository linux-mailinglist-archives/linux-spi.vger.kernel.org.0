Return-Path: <linux-spi+bounces-10903-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F03C15AAB
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 17:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 95E634FDEB7
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 15:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B333396FD;
	Tue, 28 Oct 2025 15:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QuwHvfm0"
X-Original-To: linux-spi@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012071.outbound.protection.outlook.com [52.101.53.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8143C1862A;
	Tue, 28 Oct 2025 15:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667058; cv=fail; b=NCq6LMicHRP5tHHBGE6rmCEfJeOpuig9ZZkOqBw2EuvCkiCddI5MXn0usQ0g2KAPsqfVB6On4R9qtXAnj8GA+Hqap1aZ96tHrpyKDK8UIQKtzbZvlN4slT7hcYNEWM+a+meRc1w9Oxg2KwMpuVtq/4Wa52ayVFgdroP3uNmHLjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667058; c=relaxed/simple;
	bh=4qsJmqgoxFbMI94wueeSEd07bsOMpqhF1OYW0XKYzko=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u3cir6/QemBlJ7gDe17QggFV2iczg1V61k4R9sqqYV131md+aOWS48sSwFPYoMzQ3ClvHOErQlPq7Q8OwkFh9SAEdjemp7/O1OIGFBkJG7bHCHxghwzH7C/FtRZhxcoAbavNuHUPPd6HWu6hCoiLOQjmZz+O6+xcY3qlS4R3r74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QuwHvfm0; arc=fail smtp.client-ip=52.101.53.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WC/mF1U9Lr2gpJF+s+9CN4LlhpC7aeOKZRB2JK9vNqYQ8bixovHn97HkEScAWCCBFWq/B511P3NsPa6DwVfrIGsir1eVXxBcQKFH+Fb69QbII1z9AaXSjvxBBm9Mqgt/MqlllDPhdlzn1rsJCbQXEloGfr3w3k/Me6mKGLAi5AGDRs4Os8ecUVxGJWORwdpwTceXl5qEMxWIXMAxBTur8dHP75MBYv7CCKsARc5RE5Rz73lN28JRq3VaoTIYPsZ0npKVj9sOhI5dT8wUFn5dgHbquNLNEhT2ew2WHkHYQqU1sO4uhZwVI58Bc1u0dA7OMDVfZaM637YHc0Nq5VUH8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHJ6Yf1ZPPByRuIo5huJMSdGTfJh2jclpRby2V+Axjo=;
 b=KkJJM3TbcyABrEhIrj+TFfvzt4U7Fg2T82GSSaOVwEYVxSWDU+TAew9ZvVojZbbx6+xvDjXzgWV7uV5Y+Jo/CoC0sPbpGHuKcEabRPnbIQmVhy1P0X4dQkDCwN9HYtSuk1sbxGGXIzgsSDvmOEz2JXAWj+FIWXpnsCYvT5OYUfPHWxXSgfX4ZbM4A33l+4OOMVLOqISj2Q1odZHXFUH2eU3nt8x36kmYxLvXJQqx3WIkr+E062OaKG2db8524g6zKB5yqKnVz6s/JwP//q+yyVMCrQPPBXxl1sEp57beeSgNmjj/fEQW5P+sySSmq3L2ZKMu0a5v9RO3ukpN7aaMiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHJ6Yf1ZPPByRuIo5huJMSdGTfJh2jclpRby2V+Axjo=;
 b=QuwHvfm0ospzRMDK5HCUgsdLjnzrF6afF7w7Z1kvn2/JV8OtzWthhYygZcg35NNvvPV00FJIhW7ETelWBEsH5R2vnky8E8fkQDLmxMIBhbpBByC6mWDxAnFqgufgdg/L8P/wmdOWMjtL3esQXFuzED1louh0cOYmc5ptn+qKfqLQ0Bmx1UuizA0ZUwiaCOQyiTz7bNTqJQpU7JIswIuT9wZBxHndmBJJO+0mPfFhGGoBvrL9nGW0OSWoCmakFX823dPigSzohhVCOLaGrQqyxXrujsHYqus/zhytpJsDlpf+5/9aYHiClL4gwAwAGKuHu6seai24IMzsNlthgC/JDA==
Received: from PH7PR02CA0025.namprd02.prod.outlook.com (2603:10b6:510:33d::14)
 by CY5PR12MB6527.namprd12.prod.outlook.com (2603:10b6:930:30::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 15:57:31 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:510:33d:cafe::3a) by PH7PR02CA0025.outlook.office365.com
 (2603:10b6:510:33d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Tue,
 28 Oct 2025 15:57:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Tue, 28 Oct 2025 15:57:30 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Tue, 28 Oct
 2025 08:57:10 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Oct
 2025 08:57:10 -0700
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Tue, 28 Oct 2025 08:57:06 -0700
From: Vishwaroop A <va@nvidia.com>
To: Mark Brown <broonie@kernel.org>, Thierry Reding
	<thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, "Sowjanya
 Komatineni" <skomatineni@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	<smangipudi@nvidia.com>, <kyarlagadda@nvidia.com>
CC: Vishwaroop A <va@nvidia.com>, <linux-spi@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 0/3] spi: tegra210-quad: Improve timeout handling under high system load
Date: Tue, 28 Oct 2025 15:57:00 +0000
Message-ID: <20251028155703.4151791-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|CY5PR12MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: f4b89837-21fa-4e33-bc56-08de163ab365
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eZhGLOI5UyFZFw4AVsT27sadaAnQCYuM89FSNV4gkbIdCAbrB7IkYLKKPC59?=
 =?us-ascii?Q?GOI+41ZqUFD7/9UVPfJyWIGZS/iu6tdkCDrjgfa6/KD6VwgFczP1O3mNA4FR?=
 =?us-ascii?Q?ZKElVBiT5J1DLv7qNA2rHwaly8Wfot3DFfE9xXovUl2ZeDerRRBChYY09GbC?=
 =?us-ascii?Q?XiSuYzWj++Rq68rcb5mtN5HPido3TkMgrGSfddhQbawi6Osyd26sBOVB47La?=
 =?us-ascii?Q?3Ay64971P482DYgFsmGg8iO3+OVJDMJks4yge9gunKAzrM9E/w+RqHpLdIs1?=
 =?us-ascii?Q?ZjT2s4XqQkHxcwZvz6kjH9XgD8gZh5EyVv/CaJ2tzMnmX6bZPZtlehMEd1o0?=
 =?us-ascii?Q?DHT6dUjSVwH/GCfvntfWTvujCHMvhkK70t3ubq6uqV1RJGZCME3o0mAdWjok?=
 =?us-ascii?Q?KYnGocDlOJ9nwPUIk7FO0PhIHXZFicrrO9h+OP6CIyzaY6jcPf44BwPPK+lD?=
 =?us-ascii?Q?L/y1v/5nv8/iKbTzsr9q6N+VTyVK/KwWA69gF1rsZMRM6O/8tKaSzy4gE+nx?=
 =?us-ascii?Q?/qBuO48m00aC0uq6yQ0/xfDS7J6tQ8f+rznfrFEmEvuT69rxuza2pJISIEva?=
 =?us-ascii?Q?jFTwT8fmapiok8kDUBjrT/f7ycP7JEVRlWw0h87EfOFCC8krDpYT0IFQlARN?=
 =?us-ascii?Q?9W605+bDLAzhe0XNJzsH4+D+HXxnsNp5Our7djGNZyfZB2vz3ye6/md+pU09?=
 =?us-ascii?Q?vw89Q1bRYttLSXZ9upmZ46fDQVfBU6t1MH0qTOZddGShpFp+xALX2ESDDn2e?=
 =?us-ascii?Q?2ab1gg3TBTn3wNsOs1TOM/Iq2cwwpGlArvqREtKZ6MACK5nkbn6Mg6kEVIbM?=
 =?us-ascii?Q?a3Q2oF6kipCoF4tlWmtJEUnN5ie4kvvRALkp01nVZxGmVC1PZgISoWRPPB20?=
 =?us-ascii?Q?UaPLRPoajamAUJDSeIYDng8AHDdxbSYoLZHHDth2st4ZXQLj4Eg0doG1qWRG?=
 =?us-ascii?Q?B90g3I0SCkpvGnZkJ347xFW2c746NWztqRgCoa4WuQXx45JDcXHO/yg8T8Ar?=
 =?us-ascii?Q?q+d5fqlLpkZiQ2Li1yYGBxC6/30759A4n3mPL5KWSt3EbKE1hjlONIoV4b/H?=
 =?us-ascii?Q?SGltVGc3g2J1STu6Fj5OwaJF6Rk4bgf4SZxh7/1SwIufjRiBc6sdlTachKEL?=
 =?us-ascii?Q?LLKIbNsrkH7fD9Cj0lFgrUrlmIBTPQZmMRgdc2Zy33WyKysVdo+hx6VzKdus?=
 =?us-ascii?Q?ng/GndEANpr7PXfrFYCoxYw6u9/n+vGrRddnGUQ0f32kdA0X6jS2k9r81hZ5?=
 =?us-ascii?Q?VPTfVJmAkyNCejKot/zlMwcW2or++US4qoKG4DLi3PX8fodSkyD7GLP98vBU?=
 =?us-ascii?Q?zSLgmMtV9FR7olRSYuoYrSRo5hoBi0KrMyyKuR/yoGjzJAE74Exe9N/4bvzy?=
 =?us-ascii?Q?XHcA0+4MoHwa63eauafi1fMYWoaTjVbonPNsIUFu3W185JNN9DwDkjiLqCv1?=
 =?us-ascii?Q?eSULlOB5fmGSX+aRNViTioiKapKuzQ4F13tx/gz4buVPK271UMdbfXXzieQB?=
 =?us-ascii?Q?B7LpIn22QFBaowl7WP9r1pqYU30vFgRnD91QKcwR5ZI2EgxhoK1snPNn5QTx?=
 =?us-ascii?Q?GCW9LDGeDobrgvx2yUQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 15:57:30.5896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b89837-21fa-4e33-bc56-08de163ab365
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6527

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

Changes in v5:
- No code changes, rebased to resolve conflicts

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

 drivers/spi/spi-tegra210-quad.c | 174 +++++++++++++++++++++++---------
 1 file changed, 128 insertions(+), 46 deletions(-)

-- 
2.17.1


