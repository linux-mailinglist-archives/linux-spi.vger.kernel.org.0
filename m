Return-Path: <linux-spi+bounces-10840-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 632BAC0C5B9
	for <lists+linux-spi@lfdr.de>; Mon, 27 Oct 2025 09:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7EA03BC073
	for <lists+linux-spi@lfdr.de>; Mon, 27 Oct 2025 08:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191922F066A;
	Mon, 27 Oct 2025 08:42:49 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022107.outbound.protection.outlook.com [40.107.75.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579C52EC563;
	Mon, 27 Oct 2025 08:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554569; cv=fail; b=TzbJ0VTaQlFK0fsYOEdjdDb+DWibOj/bPMbmWO1qH9EIFpqudcIlz44PAS08yIFg+vOMwAGK6i251GJQ/xMKhBZpsTHHAjtaY/++rSDKcI9QNqEQzO3WUsFNTDKPh0YQJeCeBmy5KpUQMVGwhw9WehH9ea/hEDzc6A0FpuImvz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554569; c=relaxed/simple;
	bh=tAxOiF8zIj9k8oeQX4z9lnWqV6iC0p59rGarBodFEKg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DOn2M9MK+WxDhou31/v1aoPweF5l8BBT8DB35ZY0oTgxATNASs8LiQhnK2pjBf4VlDtyv/ops98XHYAHpUupZQzzztO8ELFK3GRO2OQR4BDKq/IslmfN+8CTxz/781THwI5eo4VlSObs5qBAMXidsNZblI68VFQUwVDCPO6FIVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r+sma3SP8390M+hYDeksMXOlYUKAwgjfK1+KTpJMh9e8tu4ZR1K9bgkoyWfZhoTm65uYIYp2jYdmhmJzR+AKKpum7s53HbetkTrGwpmH/GW/H00+esyXK4bpD1E219PWwcwaqMvScyfJQc6lebWWgTZgDMUNe2dFd3oM3NpLCTmPiihYjDZGfd28mTqxyl1nK6Ni54UgmvvhfIXflbH3pMJ4/HMx5x1If4t5225PDKH/9+mJd5oEQA/AvPurNb71g760DNWvJGczbc81Q2FsJs4fEBjqfFMzYV4IJbVaNR6FTmqjJ2xlYvc1vFjm82CkHgiSyQCuiIzEo2HZq/sKyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGgWA70lT5FqnKk+8CQ+swW1c6q6S/SJLiE5Mcodpzw=;
 b=NMLrRKZVfvGYZpqZrdJ4qHc45tBCfqPIvWSoEhe/GeZlxdrW5nh7BJcXr2TjS7/Zkla9QgOSDXOkOk1PxvDxHIO5aNjKMynGVwy11H5vV06jyLVlq6qFSEwIU/vyD0heKuhSHIPPcpOmkzpRb9WDgq63vCyXVDLtCtw9AF3hiCOcndSoq5vJ2POZECc1K+STj6Mo7qDsT7gqp0qsSFoQpoPWdzpfeT1U6NutQL53qnuD5UO/TTXzY845y8OM83Ybs6SdhlO/i4lSraUHdZebb6X5uaOvWcvIkdeSlr5tZlleqSAlJ8+FcdHnNCu/zZFenGMPTXhPhnMT8wo9Xt9IBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=amd.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR02CA0134.apcprd02.prod.outlook.com (2603:1096:4:188::14)
 by TYZPR06MB6955.apcprd06.prod.outlook.com (2603:1096:405:40::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 08:42:42 +0000
Received: from SG2PEPF000B66CC.apcprd03.prod.outlook.com
 (2603:1096:4:188:cafe::47) by SG2PR02CA0134.outlook.office365.com
 (2603:1096:4:188::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Mon,
 27 Oct 2025 08:42:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CC.mail.protection.outlook.com (10.167.240.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 08:42:41 +0000
Received: from guoo-System-Product-Name.. (unknown [172.20.64.188])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 8964E41C0148;
	Mon, 27 Oct 2025 16:42:40 +0800 (CST)
From: Jun Guo <jun.guo@cixtech.com>
To: peter.chen@cixtech.com,
	fugang.duan@cixtech.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	michal.simek@amd.com,
	cix-kernel-upstream@cixtech.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jun Guo <jun.guo@cixtech.com>
Subject: [PATCH v2 1/3] arm64: dts: cix: add a compatible string for the cix sky1 SoC
Date: Mon, 27 Oct 2025 16:42:37 +0800
Message-Id: <20251027084239.2610141-2-jun.guo@cixtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251027084239.2610141-1-jun.guo@cixtech.com>
References: <20251027084239.2610141-1-jun.guo@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CC:EE_|TYZPR06MB6955:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fb13b836-fd8f-48cf-a3bd-08de1534cadb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TAmNoyVmyEffJ7idMrMPKbpC2fY1spIqa+qdj95zk5S+WzrIerIG8Q+gfdnj?=
 =?us-ascii?Q?VDTdD9tCn0ty56LzQpRIzOifHaTGo9ETqw8Z5ZUdtBze+QnX+5RCbLqx2gfv?=
 =?us-ascii?Q?yW8mwobmh9NDHcEX4VvWe+ne7ME8Ggna5NPrKuH+Euw32PmjAmibF3RagLqi?=
 =?us-ascii?Q?/vs602TpSIQukZVqZEr2bFQS/uK7xeeJVNDkPBi/oJsiR47o1gErVlK6RyGp?=
 =?us-ascii?Q?mO81XfNJvDD/dexthtOaWDjyWSZNNRANvn3aAliYTnvgDaJQmKCeXRBWJnbr?=
 =?us-ascii?Q?1plbtV7y6U/d1drZ5JK3o1/M2sRRqfsaB58rU/e5BatDZ+LAPg+oHbY7sO9D?=
 =?us-ascii?Q?5GBJooVDQ6e9YAJkNsr12F2myPW4Z7wRojXedpOp7JCQgOF4fGYZ+HghsYHb?=
 =?us-ascii?Q?SieH37FoWAm/E3uwoHTZACctU99DmabIBHxytbtoWKUFyscizt1j4/St2HAP?=
 =?us-ascii?Q?Ex1sKKZI1C7kS2ZYdfz1mo9Ae3+2HRsDrpnK8y91+0+i7aIqrgRsHa70hrXW?=
 =?us-ascii?Q?H2E0Nu6XvBYew4coSfG2bACqR9s5KDvELZESoNy2sPgAR99PeDufeEsBb1mS?=
 =?us-ascii?Q?FOpwxCD9D2XbIFs0Nm6u3eUQ4qJg3NV4bwCNf1sYv9PGznvbuJJtu3PVk7Ym?=
 =?us-ascii?Q?/SIn9H47cT7LZzV65RtvyVqvnT+CglbAeVyrAOMk4vkQxJRE3vnWO+ScXgd3?=
 =?us-ascii?Q?woDsDN3xPTtxdtUnbmpZF+fEHiV3hMm/AdlvQPv+ksPnt/hw0Epz+jbBGuFx?=
 =?us-ascii?Q?Qe1Ta5t5LXETP+F74Nd9Oz2U9zq6MMqf1b5s3LoFXDKJZIdubFPozuS7/dUA?=
 =?us-ascii?Q?MhptxiUk+JMgDcFRgYMKhZ0QMisCcOQJZpMyEvDMW7vF8BNn15JtO8LBNDys?=
 =?us-ascii?Q?EKY7VnjRZGvEMGK6GM7Polve9ysI47WirrRMCQpslEtrJBc27qNSc2n2i2WL?=
 =?us-ascii?Q?GYDVut4f5kG3DiOifWdjhVXCNQzNuB2lAVWmyOuX/bu8iFf7BDJQ6ns13lZU?=
 =?us-ascii?Q?vGOGXGyZhhAsu50CF4d4hlmPyk1mPeluabHP0BROZKw5f49suFIxDE2/FP/5?=
 =?us-ascii?Q?1VLSnvGKPFbjZj4DZhcPtyLW+JI5tJTMSXVuj2zFdHxcAIN1AyK4p6dhiJTJ?=
 =?us-ascii?Q?yFBbnE5fZ9guep/qkMWLOC0zDsBjXSFF8SiQnWddfIRU3q+bJecOb/RHq4iU?=
 =?us-ascii?Q?BuTPz2L1TuuEY98s1rumE2/7iTHBYtwOVqL8flSfF+UxlH0BWKb5FAswMkgR?=
 =?us-ascii?Q?InQ9R2udia448WODOOp58wY4R/7ihUcVY5Mrk75OxrXcI7QIyWnZSyh1iiU9?=
 =?us-ascii?Q?l21RrmHcbORRDN9/tjHrkY9attpIEy3sfCPAaQyQAqMpV97N1uZcB7PsHKJA?=
 =?us-ascii?Q?LVGnkNGHRn4Hlt/NQYlIdaJSNDx8rielXs9DBjkOgNtiE9G+weuLzGIMBoWT?=
 =?us-ascii?Q?Sv0BZrxFr0esdWkzSXPCcyPx3/E0vF5aEfswzjVwV+PyGb1MCXjyMNjV2kp/?=
 =?us-ascii?Q?vdijG08Zd/1xxgE4MFwAnIQY+lOtkIUsjphw6VuL0n3S42pUalClGJQmQ2G+?=
 =?us-ascii?Q?8p+25k44YRBz1BuClLw=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 08:42:41.7298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb13b836-fd8f-48cf-a3bd-08de1534cadb
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CC.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6955

The SPI IP design for the cix sky1 SoC uses a FIFO with a data width
of 32 bits, instead of the default 8 bits. Therefore, a compatible
string is added to specify the FIFO data width configuration for the
cix sky1 SoC.

Signed-off-by: Jun Guo <jun.guo@cixtech.com>
---
 arch/arm64/boot/dts/cix/sky1.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/cix/sky1.dtsi b/arch/arm64/boot/dts/cix/sky1.dtsi
index d21387224e79..189b9a3be55c 100644
--- a/arch/arm64/boot/dts/cix/sky1.dtsi
+++ b/arch/arm64/boot/dts/cix/sky1.dtsi
@@ -265,7 +265,7 @@ i2c7: i2c@4080000 {
 		};
 
 		spi0: spi@4090000 {
-			compatible = "cdns,spi-r1p6";
+			compatible = "cix,sky1-spi-r1p6", "cdns,spi-r1p6";
 			reg = <0x0 0x04090000 0x0 0x10000>;
 			clocks = <&scmi_clk CLK_TREE_FCH_SPI0_APB>,
 				 <&scmi_clk CLK_TREE_FCH_SPI0_APB>;
@@ -275,7 +275,7 @@ spi0: spi@4090000 {
 		};
 
 		spi1: spi@40a0000 {
-			compatible = "cdns,spi-r1p6";
+			compatible = "cix,sky1-spi-r1p6", "cdns,spi-r1p6";
 			reg = <0x0 0x040a0000 0x0 0x10000>;
 			clocks = <&scmi_clk CLK_TREE_FCH_SPI1_APB>,
 				 <&scmi_clk CLK_TREE_FCH_SPI1_APB>;
-- 
2.34.1


