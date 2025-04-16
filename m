Return-Path: <linux-spi+bounces-7617-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0720A8B75F
	for <lists+linux-spi@lfdr.de>; Wed, 16 Apr 2025 13:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9B14189F347
	for <lists+linux-spi@lfdr.de>; Wed, 16 Apr 2025 11:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141C3248861;
	Wed, 16 Apr 2025 11:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d8GZTX6C"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C040247299;
	Wed, 16 Apr 2025 11:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744801614; cv=fail; b=HO6HI0c6viDf53rAZL3J+5irF+FF838JbXo0bAc1CZJZNEvcncSYW1qx4BHGX6QPtdQ+HVXB/WxLf39RP+q8LvtJSTcqbxzWEiOd0WR4eiXyKwIUoeWreVd+ngEO6WedZg6P7A+RmrK/0dy9Shmkt+1VeF5nJXSTqgq23ah3y0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744801614; c=relaxed/simple;
	bh=xMMw0+lHw3nq+d7GcY9QATkbTJoMWTg99IeOX7wBRt4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t3ATvqQWPaxtCChn5LcGcnh/Mtr34Ne+DUsuOY8Ddlq6Md4RkjwE48STnBjDB4wX1EfYWv9GaStRGOsAeTlC+YGhqVCT24ULNXhgyhf4X7iQkPi5xBaQu5Yjo2IYIHZTTgvFY3ZhTI0Dy/z61BfxndI9e1ZwqHctvRtSMHnMVx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d8GZTX6C; arc=fail smtp.client-ip=40.107.236.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u7fwmVEKsgnXZF/KMewg6wj7NhXtz7A+JT8ZkHqwNMB+X7wEfX96tQby0y8B/Fo4gFxmt5VjNnmpaObzGlzc3Mej0XnsinRLg9IpunByg0j7crpJOvJq7P9Er3V9wNiYtBMFOWTnOiAzDgn0qQe76A8z4lTvqjGjMPXfjamhVMIUnxnscgmwlNZPdjdnyL2dGzMlVDLR8prBvxaSOg8VgsiNG5gadAse1NvwGf4uRCVuC0FvKDQ2kY7OodVIqMbk+cBRBMOxoSrja7kGdN31MOr0nvV5GKIjtOqKdp3eJVqE0xql/kOGFSmhBsGZ8sLfG+76aSrIXIImS5fdEkfWUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLWZv6EeCRhZCYQz6kBGQrdAQxVxyRJ6sIwv0WeYZ8w=;
 b=XWjNKhMKcnwSCJMkwng16X5M65VXgHwnvdvJ+7zfsZmrYcPM4TuDtfGV6MnaJ5UeYjFWEpw/lJhtf/RUqw+/U6ak3JeduvSNf8pqpclIxt3vFW2hHT/PEILjl34ia5/YCfD8kQkjCHvS10I3pmIB4PSNN7PMjnd6BdqXuju6+Ki+kgob4ABrCX1Tv3b8v+s6i4a1truN+2owewcudofW7QVgEXk3wdH/rI0Icxq8JU2zlhMrS8JBqe0WHZUVXBHZplKCHh6ziWyfYQ7myZDP4hYWNCGR8OY7Eg0ug1Cw1kBK3nOZKKcU2oYBYR0P7mV6NTjTDfqCh5aXp7hp8iII7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLWZv6EeCRhZCYQz6kBGQrdAQxVxyRJ6sIwv0WeYZ8w=;
 b=d8GZTX6Cgi66Ys2jLqdEB/ziAFz7OWJmu1WDROfHjaU9LEVLRuZJfxO/KxZmDwz4yOWUojdDr3nB72YRnbI5fPGiSirVXIMhFDGjvDKsf6VFE4BRzfszkGmi3HFdJnqilk6O5wbW4cdaKwBKoNWJ1slpfNEc6IfkwyCiJfU5x9kiPCis0J5msP+unL1PiBOSUkHrqIeBotYD0WW5bXML5JzM4OMPqMIWLMsSnRy9Z/KoANdMbaZ1vIMZlscdp1d1KL9DrKyYjFYfEPU5CsEWJwiMWH+37SIOqoQtIkngNvZ04h6PWIbhRBps739JqaEAvus8JruUI+GsUxGcEPnt5A==
Received: from CH2PR15CA0024.namprd15.prod.outlook.com (2603:10b6:610:51::34)
 by PH8PR12MB6868.namprd12.prod.outlook.com (2603:10b6:510:1cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.28; Wed, 16 Apr
 2025 11:06:47 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::92) by CH2PR15CA0024.outlook.office365.com
 (2603:10b6:610:51::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Wed,
 16 Apr 2025 11:06:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Wed, 16 Apr 2025 11:06:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Apr
 2025 04:06:33 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 16 Apr
 2025 04:06:33 -0700
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via
 Frontend Transport; Wed, 16 Apr 2025 04:06:29 -0700
From: Vishwaroop A <va@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<skomatineni@nvidia.com>, <ldewangan@nvidia.com>, <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kyarlagadda@nvidia.com>,
	<smangipudi@nvidia.com>
CC: <va@nvidia.com>
Subject: [PATCH v3 4/6] arm64: tegra: Configure QSPI clocks and add DMA
Date: Wed, 16 Apr 2025 11:06:04 +0000
Message-ID: <20250416110606.2737315-5-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250416110606.2737315-1-va@nvidia.com>
References: <20250416110606.2737315-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|PH8PR12MB6868:EE_
X-MS-Office365-Filtering-Correlation-Id: 513343d6-5241-4628-a755-08dd7cd6c764
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9+TnWaDrMSHjC5GN4PpJ+tYO8V/okMdp1rBnS9l9qdOOxC3Fv6dWxIgMaVRS?=
 =?us-ascii?Q?Mkl8Y/n/rJ4ALjD3YGXxEoXaXo6l1QkbscAdo+DkoHlgV/3B0hN7QfsNEuXX?=
 =?us-ascii?Q?/URPIcdXuxjeVoGO2jN9d6Qoyii7R0YsWTHEEY5ZtN4zPkWx4oY58WQaTnxh?=
 =?us-ascii?Q?r1LTJ2DjAOKtd1b3UbzcDenL5t+7/3ASH0dxGJMccT5UeRhJYhBxuWem01Yf?=
 =?us-ascii?Q?JBdYsntO5omJ2psZIONl+Nwy7oqbdabxauzA8HQrQlIFR9Nqf4GtSzGjnI+R?=
 =?us-ascii?Q?kh3JCCGxyCRQQiSHgVIJXpP35BVaMa0d9knvplYTBq5/si8FVowxGHoGzpNx?=
 =?us-ascii?Q?Wn4u9DXkL8wyO7vqY56tcfpRofkLcDmI09aXDdNweZNl3JI8gdyZbZG2pVfk?=
 =?us-ascii?Q?jPQGvNGICkHIAzz1uzO/xQZQ4PeEiO6HFxM5fvHuc7y3jn6AWgPzi7oDtGEa?=
 =?us-ascii?Q?xXi1VCFIEc46s5wJPqS/tZU6Ovpf0xS4nFaHHo43WRdjmEPav6ozWN5uj20p?=
 =?us-ascii?Q?q5LMJ4JryOaKTQxc8dNLJZ8LS6vgdClp+6jRQLMhb4/kuNGvQw9qr7uClzH2?=
 =?us-ascii?Q?PRgmqUoKrmbid60Zc4FgVq8XSS5IkNi+v9vSLaYdv4IvxlQZfsqodiU1fwRk?=
 =?us-ascii?Q?dMlwe0XX+fkXsNcGTJf7leJlgCtw4+enYstOKTPGACO3ismO77PkJ9lfKDjm?=
 =?us-ascii?Q?lDUrT61qeOtEjUMyXAxwhdVmscFlSPPh28JnTda4X/NPdp+ktDQKMmhF1jdU?=
 =?us-ascii?Q?sWUPh4GYM5Qz6WkBmVXYJS5Tz1YF4Cp1qg/zEtQTY1+EK0dt9Lkv3mCWJ2Dn?=
 =?us-ascii?Q?7CVikB2lX4BQgekx189TfdwuVW/pCZPOy8d/riKCcW9Y20j6sf3LGFMylut2?=
 =?us-ascii?Q?8bQqpyqzxL5k+qzF0pphhXoi8/1a+BITyFzxpluUU0S8R2L5NMNOYaH3P7K7?=
 =?us-ascii?Q?XI3z4Bu0idEuzeMrmuWc4H2UPgS++VWxozJ7wdLQIZs6MMr7kv9vb4cggSau?=
 =?us-ascii?Q?hCGkJg+SHihF+ExjYmdoUCEb3EhPlZLwtXuQyDHYZnfYVrITO2ER7CvB6DSX?=
 =?us-ascii?Q?aO/gFEPkp6/6qrnuGdzJky57/W7wQFcdSXeXXSIwJ6XolXC4C6fqwxkutJxs?=
 =?us-ascii?Q?EqfglWB9xGKzM2oIFxxnYBSZ02wJt4i4P4M+Wri+YcXfjJJjbSQ9fV7vBm+k?=
 =?us-ascii?Q?Z881yZ0zHy3jXq58oBzdjE4OoXU0auQIidodKllrv25vLJRYaNvyXzOMEoCj?=
 =?us-ascii?Q?K9FhzlpOSQBekP2GGcVGPrmvy98GSeXRGja9xiyGbP2gNKk2ibSVdvUVAIkc?=
 =?us-ascii?Q?MAPfDF1IWmI0kR15mlYE0v4JLMG5T5WcFXuDVHaAyJdtbQZFuzgtPl3B37TT?=
 =?us-ascii?Q?IRti1hn/ow+95TGt1QGQHodl118209sMJ1G/rZoItpTNPZhAvVDG3lFaBkUx?=
 =?us-ascii?Q?h09gUZzh6EK+nCqEEZsO0P5+AVwgDEBMSDVHOdLIr+4Nn+1Y9MXhGCXOTApW?=
 =?us-ascii?Q?lLlzVhewGnl7g858fbliNALFT9cKN6cQ2fCVT/1xqpvZ3agSueYc3fJuQQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 11:06:46.5023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 513343d6-5241-4628-a755-08dd7cd6c764
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6868

For Tegra234 devices, set QSPI0_2X_PM to 199.99 MHz and QSPI0_PM to
99.99 MHz using PLLC as the parent clock. These frequencies enable
Quad IO reads at up to 99.99 MHz, the maximum achievable given PLL
and clock divider limitations.

Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 2601b43b2d8c..419dde2bfdf9 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -2948,6 +2948,11 @@
 				 <&bpmp TEGRA234_CLK_QSPI0_PM>;
 			clock-names = "qspi", "qspi_out";
 			resets = <&bpmp TEGRA234_RESET_QSPI0>;
+			iommus = <&smmu_niso1 TEGRA234_SID_QSPI0>;
+			assigned-clocks = <&bpmp TEGRA234_CLK_QSPI0_2X_PM>,
+					  <&bpmp TEGRA234_CLK_QSPI0_PM>;
+			assigned-clock-rates = <199999999 99999999>;
+			assigned-clock-parents = <&bpmp TEGRA234_CLK_PLLC>;
 			status = "disabled";
 		};
 
@@ -3031,6 +3036,11 @@
 				 <&bpmp TEGRA234_CLK_QSPI1_PM>;
 			clock-names = "qspi", "qspi_out";
 			resets = <&bpmp TEGRA234_RESET_QSPI1>;
+			assigned-clocks = <&bpmp TEGRA234_CLK_QSPI1_2X_PM>,
+					  <&bpmp TEGRA234_CLK_QSPI1_PM>;
+			assigned-clock-rates = <199999999 99999999>;
+			assigned-clock-parents = <&bpmp TEGRA234_CLK_PLLC>;
+			iommus = <&smmu_niso1 TEGRA234_SID_QSPI1>;
 			status = "disabled";
 		};
 
-- 
2.17.1


