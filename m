Return-Path: <linux-spi+bounces-6778-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4006A328F8
	for <lists+linux-spi@lfdr.de>; Wed, 12 Feb 2025 15:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79693165622
	for <lists+linux-spi@lfdr.de>; Wed, 12 Feb 2025 14:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC76418D65E;
	Wed, 12 Feb 2025 14:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZVVQG1lZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3D41CBEAA;
	Wed, 12 Feb 2025 14:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739371647; cv=fail; b=IwDFSIcojMvUp3F1faj5XFb0MOynriuO+DdEl5nqWysH5C2xnH7bzLu4uV035E9XVlsitWl5x1i/mAxsOSyGi4yha2zg2YmSNxGnoJMoefzXHAH5QUI0X568MOMrr+xgU2xQuZ3zMJlWTMsx27WAfN3AKb9g2NrXagWXfld3thg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739371647; c=relaxed/simple;
	bh=OseVmVeb8rBRtGHdNcnloI51IMbivc/JFyGe1dlfDw4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XOeZRONE3GeXqfJcBXe1GxGnFCJwUlQSfrbXgKD+N8wxiGKXkj75HEVZZcvlIC1XoBB0OkJrqRqKfi3iev5OD/sICkwjVDwCFh+hPYubFUBUYTR6WZ5YSy50RH3NvRSsB5HHcDtAODLyBJfAyM9R94GfO/jt2Fg+FffhMQB89Vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZVVQG1lZ; arc=fail smtp.client-ip=40.107.243.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GS+zmXSUb7FpT8l897jJp1SjaQbMNLbMTvsO/Ga+lAj4iQFTKfYkZpuYHOpxVAeO3yW9+sPUFEngfZFEVno+VuUdHuDtEwXwmiRvBGVgbMy6N2JpEVF0AQNrsUOYbAV0+39woY42/aUxibChVC2P9n/FUdATIjdrlc3ACzIyk4+BgcgDJ6t1J9uwedLyQEwu8XgDN4qfEGmIl6jvRxhF/JYudMViOW6wvJa8fzL93+uy7DuUwb9HxfHpxc+TYg1oiWarWTkfZw2dsW226+WVwv88Hv7Ybhw0oCpCDH8Y1SB40bmHJ5sGhn6vYQDlpKaDKTc5tP2NJ9wJ/4NMyEZ27Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X14mWDZuzw2QGhu5+WccnJR00BKlTdRJVt8UvA/DdiI=;
 b=kNdl/qavqGkWZ+4mXwr+P/kAKwJuNKm0oUkIwVA7NiQWPsd+I4ELTYCvG0FOWqUkQZ3pYMn816nd/kXHcaucJFtx9vK4DDurd8/3PAGazVjFl3wc2FQ3/82u3BUwnWvx9BywPdyulV19BDHPF+5AERfkzVkkzlLLU4cJSc1ao5ehJYbKkhXtHr3nSVEGIXAsx9pfUHaaQHvTeqN9rRKWDan1QPTpgzppZWKWVbe/NKBRhHHNGul6TCSwp1Sz1/xwxHrSDUqTXB+85VsbBNW5BJHAKJvvm4nprmSQAiHGXl+9f+shjF0H6WssWoF6NLHLZPpZ9r++O5gUIhpa0ablBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X14mWDZuzw2QGhu5+WccnJR00BKlTdRJVt8UvA/DdiI=;
 b=ZVVQG1lZ5IOHagzhZmYLCPNcwH42q/gwVWKW4wrVeXbKhtW/AyISjSLLCei1u4eDYt7NaSpTwOlD3FRljVM9be0xxW7Sfzd5+Ze5yKl9baNddaygRiDb04edy1Sy4Ra6hpnQZine1aTRFc7QQbtfs7ls7YBIMyX0GgimYCZO1aK095JuEOmmCvWER5ByHQ175g9jsHUrSyHLl2MhyLeDoMXZd9hBEvV9NpH7jldbd3aYM4gLOL4PlCFBYYTVnHTGd1F8CVaJdmHR5hdBK3VxQuoEG9rmCfhVWIakYXS42QO3RK5bPwhMYWQ1ypgtiLSshw2J7xkfFwUB3TjLsuIwRg==
Received: from SN7PR04CA0173.namprd04.prod.outlook.com (2603:10b6:806:125::28)
 by MN0PR12MB6294.namprd12.prod.outlook.com (2603:10b6:208:3c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 14:47:21 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:125:cafe::13) by SN7PR04CA0173.outlook.office365.com
 (2603:10b6:806:125::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Wed,
 12 Feb 2025 14:47:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Wed, 12 Feb 2025 14:47:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Feb
 2025 06:47:05 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 12 Feb
 2025 06:47:04 -0800
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via
 Frontend Transport; Wed, 12 Feb 2025 06:47:01 -0800
From: Vishwaroop A <va@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<skomatineni@nvidia.com>, <ldewangan@nvidia.com>, <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kyarlagadda@nvidia.com>,
	<smangipudi@nvidia.com>
CC: <va@nvidia.com>
Subject: [PATCH v2 0/6] Configure Clocks, Add Native Dma support.
Date: Wed, 12 Feb 2025 14:46:45 +0000
Message-ID: <20250212144651.2433086-1-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <s355cib7g6e3gmsy2663pnzx46swhfudpofv2s5tcaytjq4yuj@xqtvoa5p477n>
References: <s355cib7g6e3gmsy2663pnzx46swhfudpofv2s5tcaytjq4yuj@xqtvoa5p477n>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|MN0PR12MB6294:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fc59c4e-94d7-4306-76ee-08dd4b74277c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/F0HAQhSxc8U922adSd1sfrciQr5RCmRk9YolYAzTPXhi8DWiOEQTViDn9kx?=
 =?us-ascii?Q?SuUVpGqfuRd0R/Xk10eWw7klIjpF/8vZX9PsibqwYeq2L8fZpKYpLwIGmlK0?=
 =?us-ascii?Q?owm5lKWJJL9ePlvsWvN2JCPH5REWQp99HKiJc4lZYgt8UWdn/FjzgPpFjpPW?=
 =?us-ascii?Q?euxhU8OqIjKYBNy9umfyyYVlN5qWJ+zvfa0d51NpjiDBl6KwEih56/sIfkCB?=
 =?us-ascii?Q?kEDphRqnJbWilBqqi4UUj/1h2GzvZiuY/JfxX6XNwMWssHAbrzeEZSsxue4c?=
 =?us-ascii?Q?/juyV/Wx7i0uuQxvJ292zEh93+bcgEYDRDia//5TXnH8mqpcRNe9mAMafpzX?=
 =?us-ascii?Q?6INlEPC91zb5hg1clq9fQTiHmjOwkquool2dtw2OUc+RJ0YbVRsAPi00vy0H?=
 =?us-ascii?Q?9A2qFSL1Nk2f2ymoiiy7kD+E/ttOR2857XNuJ359vV10Qxhd1cpLixXHtEPR?=
 =?us-ascii?Q?VDD1rux9Vbb6SycuU9AWWq+YEg70kAfRhGg6iC7kkXokiyqnAqFvyn3wIFRJ?=
 =?us-ascii?Q?VkwCv8iR4CsUesEj/E2aWYgJMN/nZUwwDj+6iJyTA8ksDX7tnx/d7zTQVdrS?=
 =?us-ascii?Q?BXTXPkigzyxDvl/Ky7NTPwcciKhfqlCDlKQ82zrPY6EBW00u0Gq8oQ0nlx4B?=
 =?us-ascii?Q?lPnbosvgrhS+6iQKzO8rEFXJ3eksiSrcJHdFAP1yhFZIJdq3EnUGKt45PthY?=
 =?us-ascii?Q?J62qGbSFX6XJk6fikdHmLbstvm3nhubJtphGMOHiKv85QQ/9QoISr3jNvOl1?=
 =?us-ascii?Q?FG6OICJYuW56rD0tYJZhLwp0yr5PQa2YY1jEa5J4dJQvQUBkTr9H5Wlno/DK?=
 =?us-ascii?Q?ZCBu6C+QL38kUQleu10iyxtMRGDcWs5fbNIFeCS7YllDx0hfDBx9EOaIfVEq?=
 =?us-ascii?Q?wYzxwPclTi88GaHbvF7sOhXQAfBbvMJwuH3FBsl/A/z/rXTuVmeofBT91aZr?=
 =?us-ascii?Q?j7HkyBl6GJBeNoXLZ+vK+psTuMgTfYGhsJEajLGkVLt6+O+ZFKxel0wra4M9?=
 =?us-ascii?Q?ERITEHEAbYJIc69v8UnNW8pnh92ElvbXfU8cc8a31pnfJvJQicgha3k1mZ3d?=
 =?us-ascii?Q?UO+rrd1GIXJVDxLjXsc4nSAU+NDI1B8STT6LQJt0YTPCPRFFixNBVPA0WFZf?=
 =?us-ascii?Q?Ehgop7ESw55WEukCXGkrC58j1L40RXwWz9LpZlno/L/mnOKUxQ0p+ASn6aBX?=
 =?us-ascii?Q?ZzfofOzZfuOw3qvx3DpMGmJOVL340Bj1BNHdFX5keztORRYG7V89UJxF7Msf?=
 =?us-ascii?Q?YzrdTGBvdM7AnUYo5h9DRYA3RmkvRpUPk5K+oHw6f03T12+yLSYhLBvAbcub?=
 =?us-ascii?Q?E+qyLc9PdKh1Df/UPPuVTIu2SRupHu5gWH+WCSSLxIZ6N7WeCiB+dgYsXVb7?=
 =?us-ascii?Q?6oXdOeSckkRmRbK9xa7k7chc7llrrUO+vZccZ/k2xZlfNWbSFxwuqxnwWGKZ?=
 =?us-ascii?Q?fnvy2rkBXylVPsk0P5mh8Q66RJqA6+GVOOcrhAUVQVqhv/PfL4v/W6jm1Fn8?=
 =?us-ascii?Q?Rfm0Ek0ZeV86KZ0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 14:47:20.5673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc59c4e-94d7-4306-76ee-08dd4b74277c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6294

This patch series configures qspi clocks, fixes combined sequence
programming and introduces native dma support.

Vishwaroop A (6):
  arm64: tegra: Configure QSPI clocks and add DMA
  spi: tegra210-quad: Update dummy sequence configuration
  spi: tegra210-quad: Fix X1_X2_X4 encoding and support x4 transfers
  spi: tegra210-quad: remove redundant error handling code
  spi: tegra210-quad: modify chip select (CS) deactivation
  spi: tegra210-quad: Introduce native DMA support

 arch/arm64/boot/dts/nvidia/tegra234.dtsi |  14 ++
 drivers/spi/spi-tegra210-quad.c          | 273 +++++++++++++----------
 2 files changed, 174 insertions(+), 113 deletions(-)

---
v1 -> v2:
	* Removed Change-IDs from the patches.
        * Addressed kernel test bot warnings.
---
-- 
2.17.1


