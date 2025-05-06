Return-Path: <linux-spi+bounces-7930-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B46AAC96B
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 17:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3024F1C402E8
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 15:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D7328469E;
	Tue,  6 May 2025 15:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oBAsGcnn"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663A1283FE5;
	Tue,  6 May 2025 15:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746545070; cv=fail; b=MOIX85iROGqG4Dz7NxWQhTxk5XxuvFk590y8P96dBdBXdhTVCbEJ8oJI1UQAKhDKTLvoP7CUP3jDOtORUZi9oWaznUfc5cCurxVssq4rx8HqJw+oCf/fsx0Dxm69FDBnRv8RwEjvbrDJlF0PboR+wHWPcJ8T/fet0uyTMzs31bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746545070; c=relaxed/simple;
	bh=joFoEJl2YHu9YQIY424cjNiuuk/pT4dRbjCsBLqAod8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eKPGOuHWLQFPo+gQeaMj9StIiTVLJKSuae7711q4X7GW3KnHdS9trVpxRkiAnKTQ2/gI8WM5sYs4HB3bVJRtPIBiqdPhyy6FENiVyJCy+Khm1swNBOs5lOZJaYiaMMtFBSuGbcSwF5TS2nV77NJqbFLTAwdt7lb7peGHleABXTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oBAsGcnn; arc=fail smtp.client-ip=40.107.94.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nNSMIZcRcNv4Dp0Ck7fBGWiSChUr4eePSDmA7EwKgrGA39ollbZIF+FBcDkAO8neJXMpy1GV65BN4AMJVx2rwGsTvr31QWjIngMzaLhkbSGi6AQIR1LnaVJ5oQM4GEjiZpPqXWG4W6axbbUYLq1xT/YFvUixWhg9Uz9jfJ9ZHMxuj0ZPMfRWAkmp+KZzFIAfWy5UsWtcaY4Dyapa1+ihT7uZ4YdteYyA/rJO8QK63gmjmKmHuMZ9G1tQLi6MQ6E5tvybSU66scbB8yiAbsuNE60oUQhmpWsPz0b927KUJb4scg933A0uimF5pnOP51apDOef9zFSrkfFbHVsHOmzTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nt7bonMltFUuUsr7VO4Ly2LaQJ7Outtsusbn2nkWFSI=;
 b=DGJewVE5QQINJYhQbxl+x2Q5pcpWrljCFnuD7V73dCz7DoNdeaKIFbKZ+5xayE9zFq6lT85FDstwU/HzjviWIXMmFEWuRUL7ugCnSn2qGTL8h3P19+rhMdh5wZHlIyuA09lbI5hlyrzx6tRMUiy++scr6jhcrLzgLxqAxR30dtYx8YqG2fpniEDXR/MnuL7SvJSjR9JLlAaMFqjTujS6+V/EIVWpeVoSyxV3+OsrtqLYGFZkYN4gb9Wnof77VVC6zJG/Pu5FwYzqoYE9m7re1Nj7bZZvJCNaVlOutiI/MB17IR1myapP4Z2oqzGCL7k4KTdvQicBrGkWNpM9g2dRog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nt7bonMltFUuUsr7VO4Ly2LaQJ7Outtsusbn2nkWFSI=;
 b=oBAsGcnnMC7aRb+jzt54wMrI/fnmTjFszqSQG1rEDZ2zQir7aXUGyiFn0dguDo7oQWzPoqWIZpW+pWwV1vN0ynXEDW2jgoBUF8i2mirTwG1ynPrtUEG2QDdYDaOyedruPeUJUJ7NAuieeLkEgrflnqPAlJh8PUQ9Vs/BuJJ/4MPlO0kbIPCaNYoGgR2g5tUSSqClvlSFFyoPMqL2p2YOqhBRDiwXq4KM35weax+opJ/mOvR+VvC9UHDbHvSxgR7aRgy1gDXzWsdT+MrKg716XtiTCOexElNFaCyNOcDRUjFpqaibmVpYXqDTD68p2KpfErkRPRBWbBEi7Nx9V3p1uA==
Received: from SA0PR11CA0144.namprd11.prod.outlook.com (2603:10b6:806:131::29)
 by LV8PR12MB9112.namprd12.prod.outlook.com (2603:10b6:408:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Tue, 6 May
 2025 15:24:20 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:131:cafe::f9) by SA0PR11CA0144.outlook.office365.com
 (2603:10b6:806:131::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Tue,
 6 May 2025 15:24:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 15:24:20 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 May 2025
 08:24:11 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 6 May
 2025 08:24:03 -0700
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via
 Frontend Transport; Tue, 6 May 2025 08:23:59 -0700
From: Vishwaroop A <va@nvidia.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<skomatineni@nvidia.com>, <ldewangan@nvidia.com>, <kyarlagadda@nvidia.com>,
	<smangipudi@nvidia.com>, <linux-spi@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <va@nvidia.com>
Subject: [PATCH RESEND 2/3] arm64: tegra: Configure QSPI clocks and add DMA
Date: Tue, 6 May 2025 15:23:49 +0000
Message-ID: <20250506152350.3370291-2-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250506152350.3370291-1-va@nvidia.com>
References: <20250506152350.3370291-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|LV8PR12MB9112:EE_
X-MS-Office365-Filtering-Correlation-Id: 81c81168-61e4-4681-3b24-08dd8cb2130a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NskhgtKKhGcoy8BQN8uV2aP4oJCux4mk+f3UOGsZuJQ3PanjtyP6BHF5uGPG?=
 =?us-ascii?Q?pnF1CU23Li1k0LTz0TaDxMXExtR21BqOs3tB0G73bXhaHOHfTK8likh1p2gn?=
 =?us-ascii?Q?/Ow5uh27dZQAe2f3swvl0Yd7HDVqkFh7m/TEl31MdGIkn6v+IY1oHseBtKcM?=
 =?us-ascii?Q?vvH2zLeNzsjeg7+p3/35n9ljSQjFQPkKpFRuWNPuPDSbyToLhPFamCsJp2Af?=
 =?us-ascii?Q?NzdSAmegXLmgKjdk5ToqS/6BvGYW6mKZ06x1WrvAxZxondzSxaaJsx+FJMqI?=
 =?us-ascii?Q?+aBKQhnIPJ8I0Z8T61eKW0UaSbcnyYEZ/tE2dMkEG21IARuJYlbU9YCv2Jci?=
 =?us-ascii?Q?fpSAT5vl04fb44uMoQDSu0kWFx7yK9aCFHejNm5CPePRqg1d9LnB/FIBRrfK?=
 =?us-ascii?Q?5u0Qt4t/BZFNSn4aIuX375RKo80a3UMS+stEh0q8drRZDUIgStkmLFRE5ka1?=
 =?us-ascii?Q?7ZF+cj0ed86XK1O3mgZGRpDy8DhgA4gmoM3Okwc/8Ooy2KnIQm/xQDQToo/h?=
 =?us-ascii?Q?PjcouQjez1Nzz6EDyq/W4obVmkRsc5kYI/+wDfCD6AYAcDi9L4fq80SNB/oz?=
 =?us-ascii?Q?1+GcyIhC9X9GwZUL/7YwHYHR6aivNXwXoltDCkG9ykiqspz43jv8HB3MoBUC?=
 =?us-ascii?Q?iwZx8ceRZm3t9pM7p2lkFhC/rtUkeiX+yYLsajaPjeVITxTxD6t5KRkWiRwu?=
 =?us-ascii?Q?OAK4M01CUup5vwEyRm4pk9EI+WkoV1A5ITabaZaLpP3BH+RaWwdRAyCRg9qN?=
 =?us-ascii?Q?sbI5+d4ZgzDoYRq+uAJJxbNHCzgZohMcz8Jx9hq5AdydRPUkD1U3EVIVBclA?=
 =?us-ascii?Q?kgYeiNDdKHcm0DJKznoyoyG53Nk7lTUU/g3ipEtLr2qEOgl2kSnn8l/Re727?=
 =?us-ascii?Q?u7XOtfNQjLN6uFTQCFSKz5WxTtxreP6nmLeMerZ19vEErzepUMgpEFXLQXli?=
 =?us-ascii?Q?+94EhnXVxHIA5uhKMiMru1A/6Hy7B9MBvoFjkqHvfYwD2MPOdfeogtN0Kpn2?=
 =?us-ascii?Q?Saw688q5GJDm8YQSA3XiHIA3rARNigNY8953KpzmQ1LQhoykw+DmMk2a5bzW?=
 =?us-ascii?Q?t72vRRZD01SHyB8PgjccB/3XXtpcDhYCM+ha8tRRDSA81uqSRTD+c3ImQnkv?=
 =?us-ascii?Q?fwgSbTZLGc2bl81POHwSAkjNohwgg56Gry+Qx81vujCxZwzmK3AIGTGHzcRC?=
 =?us-ascii?Q?As9r5HAOnC3Apft0JJ7dIul/qwwMx1iYBHLIGCUCQA6WGbfBX1ftFCOxdZ4z?=
 =?us-ascii?Q?J8I43IzY0hvka3DfoesuQgIUkpWmmSvwKfX7k205dxJwQZBNs8TH1TO3VBcA?=
 =?us-ascii?Q?Pt1s+6TBEPg5bOHqwOW/l1DAiNiKu+OCOU2uexa5xoHDo5nV4Edudo7Mqt0n?=
 =?us-ascii?Q?lOfdgUHFzpz2uOHmXJvEUx8Rb87COauh5S2C2v+Ka4DDWyCF+d2HTdjVVWq0?=
 =?us-ascii?Q?H9W3Ci8c4P/2O6oQ28nk9ZrVog34RPL/BODVR3+C/ZVfjyhb0Wtz6xzAjrA2?=
 =?us-ascii?Q?m1uFkoGbb99vTIfzfthZ9EV7U29xms//wFGIYbtNlGXTbSZ3tYNQm73zgA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 15:24:20.6481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c81168-61e4-4681-3b24-08dd8cb2130a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9112

For Tegra234 devices, set QSPI0_2X_PM to 199.99 MHz and QSPI0_PM to
99.99 MHz using PLLC as the parent clock. These frequencies enable
Quad IO reads at up to 99.99 MHz, the maximum achievable given PLL
and clock divider limitations. Introduce IOMMU property which is
needed for internal dma transfers.

Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 2601b43b2d8c..12fc850f9f5c 100644
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
+			iommus = <&smmu_niso1 TEGRA234_SID_QSPI1>;
+			assigned-clocks = <&bpmp TEGRA234_CLK_QSPI1_2X_PM>,
+					  <&bpmp TEGRA234_CLK_QSPI1_PM>;
+			assigned-clock-rates = <199999999 99999999>;
+			assigned-clock-parents = <&bpmp TEGRA234_CLK_PLLC>;
 			status = "disabled";
 		};
 
-- 
2.17.1


