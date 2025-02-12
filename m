Return-Path: <linux-spi+bounces-6779-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6008FA328FB
	for <lists+linux-spi@lfdr.de>; Wed, 12 Feb 2025 15:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C0BA1659E5
	for <lists+linux-spi@lfdr.de>; Wed, 12 Feb 2025 14:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F402B211276;
	Wed, 12 Feb 2025 14:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uN7h/Dz9"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC0D210184;
	Wed, 12 Feb 2025 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739371649; cv=fail; b=bH7VBbD/2MCyxwEDyJBZ/IQG//ZhMWsvZtg3uNnVo5YLBKR8dNrKtGUQC1pvro9IKZ8YGzyvRjS/7zVODU+u27jZn3z03okJULSb+sO0FPFTYqnSCG190/swK1PWRPxjT22wcurWpAIYZUjgedNXTSbuS1UrDqRnok5kYUyb4B8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739371649; c=relaxed/simple;
	bh=HHulMADTBOGr2UvfXjrv7Yi1aGwx+Hj4cSFhf5kNcSA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=maVK3GP5HuYKVuOTpqFcTMUO3RzaFEhuPhmBcOAg9MSnghNFQJJYUYena+Go8NoCWp3adzmAzc+qXg25dreO5AZ5aqtRdkZEBY7D1lyfhudh5ypanXrTod0v/kFdgiMum8eStoZcDLHQ7qGVWvCxEMYHXBLFzv9SetCZG/qP/m0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uN7h/Dz9; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yV4ejM/kbO+o750s1V1lumJ/WgkDUEJrSDSAsHcO3Gtq+8gD+ccuYxVhBnxD0QaW6+rkuwoMhumIlxcb2HnFwU2o8qrVDdaz+JDu1q+woaPNc2tr/RTuO7VV3qzAy4DPqxq0GYVCHCAxLI0mf3iZtQpjWrT9Sx7JpeKQtEQ7krzrYmdix9X7DuCq6UfmqjLkAsD3/oT0/DSiem4zLq5/CK4w57dX5X7rk5Rby3l2X2BOkz4TGgjHR2qEn2M9hS+/MCRBvWA3TV8ARKn8J9s5YQZ+0+jI0ti7fKrPV6KXIV6vzoAa5dQeixsY5ZzoCVeqlqfcmXV2txfMzwdqqqHEhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19inPXl45K1DHLfo9+dP81kIWDF/VQDMqUHB/Z7hcMY=;
 b=P6utmCwJ7uPlz+ioYqWqUKg7c1EFfPYCe3oc3qCHNaoja3TWyYsY+trwxGO3pBAn+FhWrgL5K528uyVXEFotey6sUuZEYjURMMoYhKqVJGDxecaqRgB82U5aztJG8SNsOhWy03EiBSYLR7Y9fmzB9IuqeOzsAfuQP9XSZ+MC4SwtxD2h/BPWGqSDXRglvc+cpkBcBjVDKKCZkMQIKT/K2HHiCCvLy44m+o9oD3ZFNkHmFeP9dUp18ZaFET42ndIMyRuOhjAAAHei4y8TfIAr+1s2wllE8Q6v6jATb/4HEP4mAaooX7PBRagn2R+GpQYYGMtMs/2GJR048IsCIg5oHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19inPXl45K1DHLfo9+dP81kIWDF/VQDMqUHB/Z7hcMY=;
 b=uN7h/Dz9LNgth3jwdjDj/H0JJixaLVdG7kypw98X8ZZnISQtVxU3brXV4p4fwDa8Ig+7Um24LdY6Uj5h70yP70L2hIg4v2l1Tq1BK9nihKpATKMM9jpL+d39gRVV+BSHiy7i3rMV6d3fz0NRV2GQhafgo7O6AbvG5ZYqMTLhKscTnR0Xx4mlibCnfYV0VWZlKeQ6cSTOX5jjFADR45XIPrIBAvEZEiMmiQfUfAXPilcEkrFNcuXPw7D3AV8zZGJk7LjIJVcbmyw57XArjP6pTc+CjXt1buIy040z5zi5G3Z8ohzS+GusCFU/8L6YlwbI15JuJsI+TlZJNZ2Y5d8Qug==
Received: from SA0PR11CA0007.namprd11.prod.outlook.com (2603:10b6:806:d3::12)
 by SJ1PR12MB6292.namprd12.prod.outlook.com (2603:10b6:a03:455::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Wed, 12 Feb
 2025 14:47:22 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:d3:cafe::97) by SA0PR11CA0007.outlook.office365.com
 (2603:10b6:806:d3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Wed,
 12 Feb 2025 14:47:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Wed, 12 Feb 2025 14:47:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Feb
 2025 06:47:08 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 12 Feb
 2025 06:47:08 -0800
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via
 Frontend Transport; Wed, 12 Feb 2025 06:47:04 -0800
From: Vishwaroop A <va@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<skomatineni@nvidia.com>, <ldewangan@nvidia.com>, <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kyarlagadda@nvidia.com>,
	<smangipudi@nvidia.com>
CC: <va@nvidia.com>
Subject: [PATCH v2 1/6] arm64: tegra: Configure QSPI clocks and add DMA
Date: Wed, 12 Feb 2025 14:46:46 +0000
Message-ID: <20250212144651.2433086-2-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250212144651.2433086-1-va@nvidia.com>
References: <s355cib7g6e3gmsy2663pnzx46swhfudpofv2s5tcaytjq4yuj@xqtvoa5p477n>
 <20250212144651.2433086-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|SJ1PR12MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d15aeb1-984d-4527-c25c-08dd4b74289e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZmpQ7r7WHqEpwXqZ1qswa/gd3+jFUMpLcD3VJ0w6nR+kBWSlzwVoEWf+Fs9P?=
 =?us-ascii?Q?yg6sCyiEwrHoTu0Vq/PjbGJWpO6turnWBq+GreWWQnGW8k1krYZuePYQ1ws+?=
 =?us-ascii?Q?0hzZHW5i/UE1I5b89YpYyPOmlompCMxVJshf8qeqsO7I1LNJOD4IrOsYWwns?=
 =?us-ascii?Q?b0Ji50H0y6falbEtb9QMxV4lI6c/NNHqOJ2dkoy2+0J2q12A/u5M7C7wEALN?=
 =?us-ascii?Q?l42LIx5ztcPibGNzDUAemyJsyPtWhAk3arzHl/yFP5ijDMqBiTalfbT6cg6W?=
 =?us-ascii?Q?0zUNMLcxA2NSK0Bsh4GKIaZk4uegAq3JMl7xRuv9TJvUdPH4FW0pKfbjJ6H0?=
 =?us-ascii?Q?WEPsA8e6a9+aL/0uzYl9PVw3G40azZR68g8Xorg56trx7n2eqdTBa6rMDhwC?=
 =?us-ascii?Q?015Nu5zS8V/l0isMT6CivjrHrH1YTpZVRo2rfphXFWU55W56Lj1ROMkAP4fZ?=
 =?us-ascii?Q?zIaC4RcvjzBfHyE3abnIbckWLKHJoVzG9IscDcvFwaB42WAvPSAjeesY+FR9?=
 =?us-ascii?Q?h842gymhI9cNM+9vXjr+wzF2XKe0XuPz/pI0I2bOJrNmDPCO2zp8O85US1VZ?=
 =?us-ascii?Q?5fZIMz8nH2DTcQh+WGy95v6+r87UgvDXzZIgveOxCabIEpoKRd8tV9JimjF1?=
 =?us-ascii?Q?E0NDMbePWbTPTmTQMEDPetXzGEvgkn7/3KEkGK9Y8yiXhKFztwq4es/0rswV?=
 =?us-ascii?Q?/P8Mti6QtvorFcw/ko+9Qv6DvDJIQKsgdUQJKtnGjr6gwEb3HwpHpeoAu5f+?=
 =?us-ascii?Q?LhNcIPdd3t0Y+YtCj4pGljKF0TizdcggN6uBsAjZpZ0s5JFhRvziiEWQxfKz?=
 =?us-ascii?Q?wuGkubBVeg5gsyGBokNDSi+ohwP4d9nZmJhi03A+rr0lyzHP3WrPOfwy0duM?=
 =?us-ascii?Q?XUJYVBLgDQ4huk/xciHX5oJVc/LBIAFpunkWrWmGlxiPbBiKrff1cXCJTkvs?=
 =?us-ascii?Q?TcppEypEpYjWnwWzGoe57rBvBlSlKNLzxKUvs0hWDcMJImmX4xpghLpoNyWz?=
 =?us-ascii?Q?W+Y9XXpAiuIahVnMbS+W9BZBqnSuopP0cdWVpez6oRyMnGyOGVVdn7kNb1sU?=
 =?us-ascii?Q?DwfvKGSzAcWlaQptI7C/SfYIa17/1+jzaNcM9zKnYd85uKifx/FF0w3YHxo+?=
 =?us-ascii?Q?YSEvDlc/K5eTv40Mdm+B6TqxkNeu+KYNfL4B982I1kFYPKOl5Y//FiVWDQbX?=
 =?us-ascii?Q?rMeF69uhIxiYhfv/SaMEHVUjSoq9hLZRu+3mAgZ4yE7xwjI4w57DUlYU9AW+?=
 =?us-ascii?Q?3a3sVj1zXAEao01bY1lPQ2JlLIOVG8zWa+JtC+RAHKUtFDpgGOCoz3HpK089?=
 =?us-ascii?Q?CkStAP7nP4wH560JwStsQQVlXJtqVNq/QE/b+9dVv2cE4ykyBEvYNsMeOwsR?=
 =?us-ascii?Q?Ul+Uk0Xkv/HgzxXvsNwKn2KJ6pWM5yzIiO8PHGnGEGPxIX0CwY/AWAbIFrzH?=
 =?us-ascii?Q?OcpZj9TneqNY//AK8oMP2wQUL+ctEkttCquwWsIhZjYMfARQrvmVh3n2PRa3?=
 =?us-ascii?Q?inWJ9ayG7Wu2fqM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 14:47:22.5323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d15aeb1-984d-4527-c25c-08dd4b74289e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6292

Set QSPI0_2X_PM to 199.99 MHz and QSPI0_PM to 99.99 MHz using
PLLC as the parent clock. These frequencies allow Quad IO DT
reads up to 99.99 MHz, which is the fastest that can be
achieved considering various PLL and clock divider constraints.

Populate the DMA and IOMMU properties for the Tegra234 QSPI devices to
enable DMA support.

Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 2601b43b2d8c..0ac2d3aba930 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -2948,6 +2948,13 @@
 				 <&bpmp TEGRA234_CLK_QSPI0_PM>;
 			clock-names = "qspi", "qspi_out";
 			resets = <&bpmp TEGRA234_RESET_QSPI0>;
+			assigned-clocks = <&bpmp TEGRA234_CLK_QSPI0_2X_PM>,
+					  <&bpmp TEGRA234_CLK_QSPI0_PM>;
+			assigned-clock-rates = <199999999 99999999>;
+			assigned-clock-parents = <&bpmp TEGRA234_CLK_PLLC>;
+			dma-names = "rx", "tx";
+			dma-coherent;
+			iommus = <&smmu_niso1 TEGRA234_SID_QSPI0>;
 			status = "disabled";
 		};
 
@@ -3031,6 +3038,13 @@
 				 <&bpmp TEGRA234_CLK_QSPI1_PM>;
 			clock-names = "qspi", "qspi_out";
 			resets = <&bpmp TEGRA234_RESET_QSPI1>;
+			assigned-clocks = <&bpmp TEGRA234_CLK_QSPI1_2X_PM>,
+					  <&bpmp TEGRA234_CLK_QSPI1_PM>;
+			assigned-clock-rates = <199999999 99999999>;
+			assigned-clock-parents = <&bpmp TEGRA234_CLK_PLLC>;
+			dma-names = "rx", "tx";
+			dma-coherent;
+			iommus = <&smmu_niso1 TEGRA234_SID_QSPI1>;
 			status = "disabled";
 		};
 
-- 
2.17.1


