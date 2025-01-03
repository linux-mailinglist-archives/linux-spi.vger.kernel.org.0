Return-Path: <linux-spi+bounces-6212-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E233CA0040B
	for <lists+linux-spi@lfdr.de>; Fri,  3 Jan 2025 07:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACCCC16306D
	for <lists+linux-spi@lfdr.de>; Fri,  3 Jan 2025 06:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BEA1B21BE;
	Fri,  3 Jan 2025 06:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tkk/VZlb"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B571B140D;
	Fri,  3 Jan 2025 06:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735884305; cv=fail; b=bAt6JMl3pp5bAvCB0O9NkxxV18Ewr6x72VT5KxRGKV9JvNUTLLhCDeHng+7e4sYzZSYUICMPDJMRLqN6Rk6uTUPC2jFioZVD0/OB3IyTd3xY3VyHat16iAJnGvZMRjPPgUazPWWBf8EAFOhJ9wZL7Wzu9P58VeUQK2IzbuDSM+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735884305; c=relaxed/simple;
	bh=fjFZXacRjlO46ED7wsWdDLW3BUe4m8VXI4rQx6OOkOE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pGzxY89SpYPJ7WKn4xGwqZkuGe5kQTwZIrM82MRr3+k4hoLcFttfo6iizQuqemt2TSlJ8IRKibWTkVByH73Uf2Y1W0+byYGltxXHNlHR0zmmCPoFlVifliigPN0F4KBLcJBgm2WTxUlHc+V+wNMseXKr7QQnn9dpgtkw8rcl+SI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tkk/VZlb; arc=fail smtp.client-ip=40.107.92.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LefkAeqckosZBNYhkAfA7iHroiftvpaMkx+NPNZE1HMo3agFR3KeWQ5o/+lQZwODIbiDrs4ZHCMNvhkF1zoq+XWGZvcxVB8iEWFpgXeCc/niUC6mkt2xIiEdG1rOdbjknhjfhXYEmyUTnzXczxAEty2fF97xLsHqR2XnO5XuG5JXS6vHNpBVAfVloSuqrs8PCYtClo/ewp6mEIG300jWdyinQDHuPWYVz6ZxHVuc2fhD99XnNSmaHuvuZfA9PFoLAHc8jyx2x2GHpxpSGHZeGtVRkjoJatfb6lV5hCGewC1Y038Qsdo95mmBVsx5bZusUQEuV28B/cH5L01owQ44uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TKqPKRKHFV1ybDnw3fWZCMmtWrBHiBlzsYqDrfmAws=;
 b=RV5ZuiUaRLLeiv/GbW8lpIsI+9vhwiSLLoNK4usWoE8Z0FIZN8OHu9xH+G41e/vxhAvFrc9BY9v1RtNLirHFk/S/fyytOt32vTALrX0OYcQGyeu2ZRDYkkogkOyBLfLX0Se0IhXQZOIRv6twzMpUiDjYLR617Xq8VIbqyYuADqjnKK7pmyyZaFwWiS8Mg0YYD2LtsebU/zeqi8euEOFYRyYYHN//0X8KJUoqMW0YDNSS6me+a27EftH6E5o0ZVvgZ9ql7BgJrTFscdgZJ8/Btb33PZOsWnnH6nuXdGNDImPjodEjfKK2zAk52VzMY7HnNIv55jCs86IRJqqghCM6tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TKqPKRKHFV1ybDnw3fWZCMmtWrBHiBlzsYqDrfmAws=;
 b=Tkk/VZlbHX7vReUtubeELHRZTqm3SvWWUtEQS+Qt5UZIn8mkeXtDJbKPubT7d/dFTus9QtHJike7KQCffWIzbMa26XD3u6KZwRZDK2trdgE3/M9Ow7g1b0ZDtzstr7Bl02Rjhn9JCgTOtTZPfPfmDBpF+q89qp3bZ/Xyhgwrn03+xymHjm+LAhf53iTHrL7EfjD6qROYfcworJzbQzEiTl54tyOgiLSHNudshjj+f+LUGAvjAHTpZnhB0XIqPvYS73/noHVyDZhT93MI/PXMRq1mwQiLf/0scQWmkxnLiXJOvm3sFsThlyHfKYmdM02ATPc7QS6NtNy356Lxy31dmQ==
Received: from LV3P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::18)
 by BL3PR12MB6545.namprd12.prod.outlook.com (2603:10b6:208:38c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.20; Fri, 3 Jan
 2025 06:04:55 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:408:234:cafe::fe) by LV3P220CA0009.outlook.office365.com
 (2603:10b6:408:234::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.16 via Frontend Transport; Fri,
 3 Jan 2025 06:04:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.11 via Frontend Transport; Fri, 3 Jan 2025 06:04:55 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 22:04:40 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 22:04:39 -0800
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via
 Frontend Transport; Thu, 2 Jan 2025 22:04:36 -0800
From: Vishwaroop A <va@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<skomatineni@nvidia.com>, <ldewangan@nvidia.com>, <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kyarlagadda@nvidia.com>,
	<smangipudi@nvidia.com>
CC: <va@nvidia.com>
Subject: [PATCH V1 4/6] spi: tegra210-quad: remove redundant error handling code
Date: Fri, 3 Jan 2025 06:04:05 +0000
Message-ID: <20250103060407.1064107-5-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|BL3PR12MB6545:EE_
X-MS-Office365-Filtering-Correlation-Id: 9957d9db-8809-4229-40af-08dd2bbc8b94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SC2s1dzawXLpZRnS+TjsBMh0JzPJqNd/qPjj0xOiRwyhzyx9ib0QPYDCXY0+?=
 =?us-ascii?Q?zh/5JzmbsLT4nHhUZ0rivI4eTMIsIA5taZhH1mkiZccnMR2Wy1Z3rNnld6qU?=
 =?us-ascii?Q?KFELdLJAj5XCT6djX5tttXJzdiWk6zbjiuH3RQBlg/++FEdVj0K32CnaEN49?=
 =?us-ascii?Q?mRiiSCGcqQnC8N6DJq4fs6xI2jAMONm0Z7NSMkdUlo2koTbMXH/W/yqJ1iEj?=
 =?us-ascii?Q?oZqApfSyOMlUnT/XOKHFrueQlCaEGlPFkhfDPVoyimPBxMTT+3lAaNwO0UVH?=
 =?us-ascii?Q?2MbTrHKDeV+kG/qMaXTgrcFqJfoocGK5FOu+i0PvoWaKlCMUibOG7LPZGAZ5?=
 =?us-ascii?Q?2YTUcYxo7syqvBmEpsokpKx+QrTsS+OLO9gQmSGHowREtPUFOcaUT9ar8s+G?=
 =?us-ascii?Q?PU+Ft3Sc2F/N+xZIWekeqUCRAXYppSVmE3wksDTvntZlGGHUfN8GkZDelWAD?=
 =?us-ascii?Q?zJ2pIfDCi/VFQyV/q0cUTdFFDiIaAGfSbKzkcGDqgpUEJOobAKrGUvkmuCBQ?=
 =?us-ascii?Q?xLsObuDRlFvLyx1+nJurw1E3caxxsh7cvEzRi74Cem0j0manHnE1SPh9bimu?=
 =?us-ascii?Q?g8ZmmFHpev99cj32FwkOLqB/A4OdrKKF0odUIBxJ7cJzKrQalYDLz6cpoTJj?=
 =?us-ascii?Q?B1uqTOA+svEg4xiWMWyCoPEU7WPUuPUUHgZwmHj44AFrKvftJ7blS9dsiFVE?=
 =?us-ascii?Q?zrek2nnQb0eDY6Fty9hQJV33cdlCLXFwuFud12SNeoaThEEdeQwaRNFPpH+p?=
 =?us-ascii?Q?u1XuLzOqRMB0pygA82Y+8BIJ1RDzkERCF++a9VOEMww2yoYfectfzkTGLSA1?=
 =?us-ascii?Q?PDY4ibsXA671dlIdmOqmHCbfsfoJrO2/V6CnZd0DbRrstRmcShmmDzkbWUvZ?=
 =?us-ascii?Q?02iIUaQ1WVRA5+AHjzBq6EI4se3SFpNWoK1SxaKIlZ1OREEUfrx/MJ5GwbJM?=
 =?us-ascii?Q?wLtZrZ7k0DIPbQrW1SMRFrcpqR4lCYdU/9N1i4mTZwrPWEvCXuHRoQzqk56M?=
 =?us-ascii?Q?ZdhE27Gi3SrqQnyIGG9MmdSA5qSkRhjBF9XMcGJwtuq/8281za14rrv6la8l?=
 =?us-ascii?Q?WLPPRl2tnJaAMxYLuAHP5kYyKkuNd20VHoMxaai87hXEJW9oObTuOlLvsB7B?=
 =?us-ascii?Q?sW4omD/dUe8b7Oye4Eem+zKhJTRWSrM9jrnV8gS0u9sASOtQnPhkvVdkKz4Q?=
 =?us-ascii?Q?PT8ObWD/+g09L86RFm/dEPmgKJhhx4UWbrg1I1j8DXA983LFB+K6xOLxwph2?=
 =?us-ascii?Q?Lf8vSUFoEcEDLXy5O1tKzHHnD3BHDP5yRBEyVVwWR9d7kh0rS6sZaCXurJTr?=
 =?us-ascii?Q?23E/EgioZOQaLVVXLskgOSBkEbBugOE6I6bJwVpwIG0OlVxP7BdnRdvjrahM?=
 =?us-ascii?Q?8JcWdhR215DEjrgHFDo2b0SRDNp7tyEZ1fQeWHfuzj3wXzF2/hTgPvYqzbo1?=
 =?us-ascii?Q?UfJ4N/6wVKvUxtm2nIfffhIrg2KyEfGH8ULSlOBT3xD1xaIlRfJc7mx72j1I?=
 =?us-ascii?Q?bIqfLjhjF0XAVRk5wcOx8AAZxIYg+r7Th+0F?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 06:04:55.0042
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9957d9db-8809-4229-40af-08dd2bbc8b94
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6545

Remove unnecessary error handling code that terminated transfers and
executed delay on errors. This code was redundant as error handling is
already done at a higher level in the SPI core.

Fixes: 1b8342cc4a38 ("spi: tegra210-quad: combined sequence mode")

Change-Id: I9e77732db64d7a1674b7e87048c7b59d8dbab645
Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 43d6587fad09..2d7a2e3da337 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1187,10 +1187,6 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 
 exit:
 	msg->status = ret;
-	if (ret < 0) {
-		tegra_qspi_transfer_end(spi);
-		spi_transfer_delay_exec(xfer);
-	}
 
 	return ret;
 }
-- 
2.17.1


