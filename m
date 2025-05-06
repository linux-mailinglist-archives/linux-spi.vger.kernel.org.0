Return-Path: <linux-spi+bounces-7927-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FA7AAC3C0
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 14:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAECB501025
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 12:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AE227FB23;
	Tue,  6 May 2025 12:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mXW1mOSh"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB1C27FB1D;
	Tue,  6 May 2025 12:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746534196; cv=fail; b=NrEp4YCMqBDmzhRRiPyXaSfgid7WJDZg8GXBORj+513FuvYBIkUYeBFu75QP5gHqPgTE3jtYRo/4jW6TNFdAfVByMHKIG+H/pOp9RrdHe/4xdfbuUkFOTVSTGxr5Sltu6DATJ6Kuph62S+Q6KnAxOxd3Ty00d8aTvTlQRVGsJtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746534196; c=relaxed/simple;
	bh=joFoEJl2YHu9YQIY424cjNiuuk/pT4dRbjCsBLqAod8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=skUUvWhbz5Tqp/qBkS2BYxhOOKUH8DHFZEJBZaqEdduBtf1wtvsYi/QlzTbwHimPUGyIDJ1tbYhN10kq1tctKcniB+v9xbkRb467bIfDGkqv7EKQe0sQcjy1Pc9GGSzhy7YqPvEDT6HTx1fUFfgbFSsz4N7CXzPASiy4UDqgaoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mXW1mOSh; arc=fail smtp.client-ip=40.107.243.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VJ6xq+p4Fxv4hUOeNwg2dvPPEO2qm4ChHdhGfI03ANoJ33jPQH1WCJEzGD0pJjh77dN8ZMW2XU8+r0kHgQ4Em6G9VS2BiGW4H54MFXOi8T0KXzWH5vh0+mfceihPDmu91ZA7k9BXMV356h2fyB+YUAKjBsDTP1Wpd2hHqx3cjky6F3yn3NTIiO0bUHZ7bhrYgn25azMkbHFll2M+37Hx4ffWA0+o6FUKPcmxBCE4QDeFb+rxBDjt6YmdWWzgrsBEarMCRZ7/MthM3/C/Aql4KIH8HHOzGIxpksXPiyjlv05RT4i9XPs6snonHg0ziNt2UQ1sjVrmq8VJMYzabzXCug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nt7bonMltFUuUsr7VO4Ly2LaQJ7Outtsusbn2nkWFSI=;
 b=GB3/1p7q+38OXXTJryHKY0ubAsBn6COUrf3aOcw4EYK+yBF+1e2a+MpGWbdWh6uKuwwYA7I825yhvWj7Tg8M0ZrddYBJkxRahMILR7GUtk+3S5hN0gUkgg6kwgfd723z2baysaWOlgJgAd8VqoOZAWequl/tOdSC4/kh/cR3cQPXDcmbA3xdNkMLTr58eRbwxvkIK2W94+IbYr4aZKB0k6WdkXyp1x3gPh8I+8Max9DSVQor4oSeksktJdaXlEJSnhLGzRrDvRnr2nFYNwpWelL2wEf5hNfb4uotuV5aBbym86+udeLfEH1A/E9KxIChz3id3M5vvpGev6fbcQaw/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nt7bonMltFUuUsr7VO4Ly2LaQJ7Outtsusbn2nkWFSI=;
 b=mXW1mOShQuDqQjV+5/RuLXaRfAbT/0QLmhDDFz0gwrjHowNMYxgw2JeSqFsPTbgAuehUbwhNpa02Yf7vazV05p27yrqaRj+oURny2FVU5FT9/2RwXJp+rZDdKjeQ42buepqkEzLIjDUNhVx8lnZrGXTrzyrZ87D4bYBZwR11TBLXEPL8HtCaA8If3aUOOSfOAA//FR3dQIxrg+VbVcKp2EDJWYNMpaYoe2XF1I2vqiIjm/xwq7KHTTzB1V3v6O+dh8ux7q3s4zH6tB4TtLnBWGctG2BsBfNNLYhSp7PF/UrxCMB1WQSAysWzNAKqSFmR4bmUkuAXGU5DFr6kvhv5jQ==
Received: from BL1PR13CA0021.namprd13.prod.outlook.com (2603:10b6:208:256::26)
 by PH8PR12MB7448.namprd12.prod.outlook.com (2603:10b6:510:214::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Tue, 6 May
 2025 12:23:01 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:256::4) by BL1PR13CA0021.outlook.office365.com
 (2603:10b6:208:256::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.17 via Frontend Transport; Tue,
 6 May 2025 12:23:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 12:23:01 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 May 2025
 05:22:52 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 6 May
 2025 05:22:44 -0700
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via
 Frontend Transport; Tue, 6 May 2025 05:22:41 -0700
From: Vishwaroop A <va@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<skomatineni@nvidia.com>, <ldewangan@nvidia.com>, <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kyarlagadda@nvidia.com>,
	<smangipudi@nvidia.com>
CC: <va@nvidia.com>
Subject: [PATCH 2/3] arm64: tegra: Configure QSPI clocks and add DMA
Date: Tue, 6 May 2025 12:22:21 +0000
Message-ID: <20250506122222.3345040-2-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250506122222.3345040-1-va@nvidia.com>
References: <20250506122222.3345040-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|PH8PR12MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: 61ab8541-98cf-4f1e-6962-08dd8c98be98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ziK/Ble0pRiJeV2oyhaEFSSDSjNX35wIWHxetjNeYfRUQis0hrbFDtj+yyZH?=
 =?us-ascii?Q?0ecv3Eiz1X4uIVgtFOs8dMH0sDR/knwAy9GALagg8oU6qIzHXGQXXqs5oJBF?=
 =?us-ascii?Q?F7zpuxNR/IW1O8k/Ub5rxindLmY/MYxOjBYiRHqHIQU2oszWWgr2mMdvVCs+?=
 =?us-ascii?Q?yJ3GDuCQdLthLe1wMGvE73S/i/33P7jBH66DjeNjw9q5Cqgcang9BNG44T8M?=
 =?us-ascii?Q?8MK+YsvJew9FHN97NUwmf1CR4Wz6pY9wacBxKbVxBcwhl/1Uj8XpBoW8KjRi?=
 =?us-ascii?Q?NRr+i5A09qOzYvsZkkLc7uROpmTrASpOM9D3vE/C8Hohvg9TtcoIMc+Wt6yq?=
 =?us-ascii?Q?ORrBahss7i12qdN81AIMY3AvCQamYTr/jOL2Xzc0r9agjCWXy4ADPdONwWOn?=
 =?us-ascii?Q?fH1hGB16iEBeNWfwgHznZihQDlWUy0Ca927Y/Y5gzZN+G7WT7Med+7gdwzWs?=
 =?us-ascii?Q?mNdQkPlaBfP8nYRaoQrbzPOMLW4+mo8/d3rq87zsrpTNLrlBW9UMizNKfPkz?=
 =?us-ascii?Q?MDxewAcEcQWmijHnkyWaGwLzpmBLu3qGb86cGa4P+R69q0K/PgyJrybpjPfo?=
 =?us-ascii?Q?7QHtnpm1ZWuBy/G87Vqu4Ul5bpog2cmFIx83d43jL2HkxtQCB49IHfNzoW8g?=
 =?us-ascii?Q?ZLGsL7XBSv6ODbOTgLnmsmagBL+fG90b/pQexN3lDETVgu0DPEzRIx6+paye?=
 =?us-ascii?Q?AjQ7i8s0FyJkUkzhRqueMcII87vzReiSmqOQLvwoEWaj0pwtsAwS/tNjeVit?=
 =?us-ascii?Q?zPp8dxZAVDGh6nA+OX2AoG3Xq/nJmn0XZ/Q8mZB2iaimy3bohTumfzgjA6V6?=
 =?us-ascii?Q?5ps9p6pVvh7Vq+sz9ev0U2DtD7vf/p5dmtQEZDH3Oa1NanJsEpAhQsSVotx/?=
 =?us-ascii?Q?YixFOJM73dEt8YJSY2AAhiQOJ9ukIGymTF5UlyVyDUsvvrRBzHeTJ/bxpFMG?=
 =?us-ascii?Q?w7aXTe7XO8pOLdC2s40XXdRUWzL26tepi08oWYEjNYo1mBc+h6BjOYyRI9C3?=
 =?us-ascii?Q?s+7WX2T0XQiILieAcKQKWgYSZ/wGh5IEadNZdCE99AgDBf1vPkaGahxsiwOA?=
 =?us-ascii?Q?2jL4uP2kcv1Kk9ENXzsbCcyEXXjwhEZz+4T92hGFSjtvjM0kocY0lx/9I3o2?=
 =?us-ascii?Q?UacUMiLZgNUBpaExQ0m+/HMdVZuURRmiq2VKaX+AkbHqLKN0+qQw3BUBJFDS?=
 =?us-ascii?Q?bgOaWl14taec8mhac4Qt173xRSMHGOf9Pe1bMLYzsYCOws+24yqXTFqKjsKt?=
 =?us-ascii?Q?WAtNcVciNcKDxFCfUIHzdh5jiC5oIVu2vb1PerHJv+DnWikid2As7ZFYrmsU?=
 =?us-ascii?Q?uQ4TIMTpRTUmXVQQNo4j2gj7ISHSkSUUiQUN6m7QK+sroihB0k0GlnGpxk32?=
 =?us-ascii?Q?Gi+NsmdYsI5khDG5OdJvL3ku4+8HYnjjD3wxvlwNfNp8/c8fKiuQZQXdMRuS?=
 =?us-ascii?Q?DNLJNqr5dsA7gVzjhRRwBLvJkroMN98eN5Yjs2aFnndbwFMUQY6390yU9N2C?=
 =?us-ascii?Q?h9D6A74zfKNCcXyFwawHzi1xdDaCqEtmiUt7qOdIsfuBa198R3ddDdKnFQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 12:23:01.5028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ab8541-98cf-4f1e-6962-08dd8c98be98
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7448

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


