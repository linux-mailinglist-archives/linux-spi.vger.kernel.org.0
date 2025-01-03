Return-Path: <linux-spi+bounces-6209-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DEAA00401
	for <lists+linux-spi@lfdr.de>; Fri,  3 Jan 2025 07:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29B301883E31
	for <lists+linux-spi@lfdr.de>; Fri,  3 Jan 2025 06:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF471B21B9;
	Fri,  3 Jan 2025 06:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A4kwS86g"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C1A29CA;
	Fri,  3 Jan 2025 06:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735884286; cv=fail; b=mWYw1Rd+cKrt+5W4wFJ6P4q8KeLoAXr2FkcAiVbwIADjc0Kzmf9EDY7JcDNlTE49LZHYH6cKnOj7w9xf8zr98/TPsaskFRlMiqoWj+Jt3pbd9pba8a05t38qY+Wbyjn7D6pHVmL11FlRtJlUPyRU7Vj4dff119MKptBV3AxKFnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735884286; c=relaxed/simple;
	bh=l6byfwutzIZXUtv33qMBQXJxRIkqc/hHhkXuy8jo2gA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YT5OzFQCNxfSqqj4+jzuk2OxrFqq7KJv2oI71bH2mxu/Rod3jAJjjb5Zst73w8Lxl6JnAD+7c0wQhDL1ngI0rNAcV1EPV+I4vb0FnBKTMN9JGZADv1ayguIxg0b2q0BKvmN2utJYoMfvFmNXarqgE5qpzN7LNLk4m600itMtFgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A4kwS86g; arc=fail smtp.client-ip=40.107.102.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P7AshGpxtfsWcVsJyXfimNJknybi0rk4XoGgPkGsIZKh5eKql+kOGX0LdQ+w/dhQDYv3BcRKRKGY9Y4IWwiij+cI6CpQCHa0zuSNxloi7QLt+5hlnDu50/CrdmB0KAnC89CCLkJ+54SQn8UwtEnn2eaHd6Ykr+8JMUsux2GrMjGcihZzeaIMzWoZahRVAsYedcqrk6/YVJMoGEs0YQqVYQ1U05l84LTr9laEfafWXZYh+tYuzGVu4gQ4NSiHozVCtAk2Hxwf+b9lVMr3UiBiLDU+CqEnuC7GyXsyu6oqH8uw4PMXmi7SV7ls9hTHb0QFL8UYH75Ob7yoPCfwDbuXZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qWI/uoUZgNb+87E/+VEQkoS3R34YkqmicsFyyG6ynQ=;
 b=dxGAY0Qbqe8Tt5dH5UmIURMh8EkwpdutJKPuJdlbIDML5ZCXaJmUE3As+vjq7JUeselYvj4tiScAKXLKiATnt7+iaknNQ5vPbssCErCM0/IcNSKCphbZSrx/GHui93SOCPWSdK0nmMK8DsyH66xOhKrQZpNvJv56XfjeM2nI9CE+iPpOZoxcGvcIt05fBwoos75sl7rrDv7tnS4zlFQFWYqCCybnu7gEQAuODHbPapdF3BaTvm+X+3BXLGlBezQStFFoDty7hYRYBBpsieRvfCwBdcayjgNNMg7oVtfkITEAxIJY3vp8ZaOhtSoc90oS65Ekk3Eq1kPSztOkzaFcHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qWI/uoUZgNb+87E/+VEQkoS3R34YkqmicsFyyG6ynQ=;
 b=A4kwS86g44KH3QmeCcd+xhIVOyM9yF2t1gI2spKbfEPPLyI/PsTIS7/xbDux/MelHHAWx7y3yZ8RH1oUYpyiqpP+9eODzyi+n32dLIzw+GLzwWXQpAwAaAtVWiidVw7GECz2SuT0X6yj5jLgHFIrLKwcyIfxVRaH+AAEeFxw30q7EBhRzdH6bYLzjRYW84HfaCPVsLmSnZUwmCZyqUtElpoVncZxYBQ7VLqk+43R2U3YKnifeYJAGZJiR1XxgiYUCWt1HP2e8qkMhYyGeM3lzysugcKw+jCEGbosdLS3WwLjgPv+AdBOtzx3Io9z/ZF2A2f4q90pCPfuQPr0Cg56ng==
Received: from BN0PR04CA0189.namprd04.prod.outlook.com (2603:10b6:408:e9::14)
 by IA0PR12MB7750.namprd12.prod.outlook.com (2603:10b6:208:431::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Fri, 3 Jan
 2025 06:04:38 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:408:e9:cafe::a0) by BN0PR04CA0189.outlook.office365.com
 (2603:10b6:408:e9::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.14 via Frontend Transport; Fri,
 3 Jan 2025 06:04:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.11 via Frontend Transport; Fri, 3 Jan 2025 06:04:37 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 22:04:22 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 22:04:22 -0800
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via
 Frontend Transport; Thu, 2 Jan 2025 22:04:18 -0800
From: Vishwaroop A <va@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<skomatineni@nvidia.com>, <ldewangan@nvidia.com>, <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kyarlagadda@nvidia.com>,
	<smangipudi@nvidia.com>
CC: <va@nvidia.com>
Subject: [PATCH V1 1/6] arm64: tegra: Configure QSPI clocks and add DMA
Date: Fri, 3 Jan 2025 06:04:02 +0000
Message-ID: <20250103060407.1064107-2-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250103060407.1064107-1-va@nvidia.com>
References: <20250103060407.1064107-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|IA0PR12MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: 71c3ae69-9038-4249-a10b-08dd2bbc8146
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vgwVXboTw1jp8/XwoO63ithqPkoEWN5FaeEmOyZES8d11kUZ6a8As7wRWY6x?=
 =?us-ascii?Q?I+A2mKc1Amwhm6RV1CzOfu1eJYRR0HAMqQ84rtFVjNNQ1oH7pJX/sxltT7r7?=
 =?us-ascii?Q?1bOlJUsPqo4Ghu0rWRp5y2xVXSgww8yXjJTE0OOr5icGWaTX2BkCmAASzSZ+?=
 =?us-ascii?Q?5IIUHAXM7cBT/M0cYsKaaBUmXaoh5mluqBcM7gFTCnwwCu5NemgQ9EtyQdQr?=
 =?us-ascii?Q?NRalVOPk6lMDIaZjaEDUg+wuk+4RlUBRZLLpBlK5GqL/xfElcUWwh1Ll3JwY?=
 =?us-ascii?Q?ZcbXatDKmGLkJe9SmiicbJV5HqH8iCRN5QfYh2WnKqsemfPbd4Loo+OOel6y?=
 =?us-ascii?Q?zdnnfp9lq7ay1RRBgglzN/O/ax7SnuD265iLbVFIHnYTEzDgCntKkaktyY8v?=
 =?us-ascii?Q?FVn4Y5MEl/Nd+IYp9IZBex7vmr8TcFNgBtPAwi9kQdIeHKhMXeNlYzogkZa8?=
 =?us-ascii?Q?PuyrqEfQbwwiZu8DjiUuFG9kZlRDygxLeBs4vX5c91e/m4vVyiv+Ljd3Q0B1?=
 =?us-ascii?Q?1T1OtObOTchUkvCoCRMfEbRMYLbuFtMriwQe3AMfvuk3eiXoJb5AHEJ9BeM/?=
 =?us-ascii?Q?B6lI+pD9HCob9jVQ7GMTTB2aqC2zWdTSsleB4eRoG4HLK/nWXbHzf+5LMUNc?=
 =?us-ascii?Q?fXQ1b5Q1chSTX+x7J9OkYPwUrU0YbBDdeRN1ZKuNwiG/71ossgfLBQ+auvMI?=
 =?us-ascii?Q?RdQNCrNrGspsfCSfd9LzAVmrb8jEDFNFF602JNKQEaRYSjupKd0hqL9Djvuf?=
 =?us-ascii?Q?HObPNY2Ld/pLc7q5+AHyr/hjUxsWMkcAtyHs1GiM070zjHUL1Vw4nMmcWLZ1?=
 =?us-ascii?Q?8TvpbP5Pss8DqsLNdS2SzXP3liUBY2WKPDWDmifc92FOFIWzZ/N88zVak4aW?=
 =?us-ascii?Q?a7dTW+SU/4gXyo40aRaRHjePnABvGXFMF7ILtgBljTnsg06zO25Eksu4iSTV?=
 =?us-ascii?Q?w+ZWylMkOqz/W0v344og8gkyiNOCWAzTnKsYp9NM0lq2YOwvc3zZKcy/q6CK?=
 =?us-ascii?Q?v3NtWhHeSbf+od4IU5MDUGl6aZP+7NRqB3kcuLdINflWgXQU4DyayY3rPDnz?=
 =?us-ascii?Q?r5wWZDss68LvV8wdrS1AQy9k2Hb8Lwhtbx3t24cEenEFXUCVRlUjErx2/IFW?=
 =?us-ascii?Q?vC7cOpnvlY91NchwIMd6CleqYi4gUofTuWxH/VUdQrvR+nePEVuXOTIc/E9R?=
 =?us-ascii?Q?fXpLQEHnd6NidgmbbZnYTrHceqLpTR3uUUxVJkw2ZMgsGUFqw4WD3+1PQuwi?=
 =?us-ascii?Q?wLdG02qg1qIs6penppbCo5buL8JFHj8oGcn5KECDmWLZFOo5B1KUK68QRt2I?=
 =?us-ascii?Q?j+4OOA+N0gYxdUu0cbRoV7T8nMqZk44OKPKqcaWRxMglmYGYbZIPBCMICyPt?=
 =?us-ascii?Q?yDpfjZr7I89dKSuGS4w1Vq5ZpmMCEaTBfH1VmNlgPVi55k89j0oP3jzxzU0r?=
 =?us-ascii?Q?nEoSX847iCOrRIjAgKFGTQi9Ind02VIB7/PezEDUt1SW0yt4DQWH3st2QFqm?=
 =?us-ascii?Q?K4S9M310Alcy6qI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 06:04:37.7182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c3ae69-9038-4249-a10b-08dd2bbc8146
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7750

Set QSPI0_2X_PM to 199.99 MHz and QSPI0_PM to 99.99 MHz using
PLLC as the parent clock. These frequencies allow Quad IO DT
reads up to 99.99 MHz, which is the fastest that can be
achieved considering various PLL and clock divider constraints.

Populate the DMA and IOMMU properties for the Tegra234 QSPI devices to
enable DMA support.

Change-Id: I1dded904aa8e0f278c89998481e829f1ce474e8c
Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 984c85eab41a..96d0f13390ae 100644
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


