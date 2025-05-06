Return-Path: <linux-spi+bounces-7929-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C90F4AAC966
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 17:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D61041C40A61
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 15:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F9C283CB5;
	Tue,  6 May 2025 15:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jBc1RD6s"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B09280006;
	Tue,  6 May 2025 15:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746545064; cv=fail; b=jOfL+tjVWCwK5G+nL+EhU2jLpy4xAoWoWNghHoPNWJs7nIhdinliepaUwRSyxkxjo1jkCq13Wt3JQRUqA7tpDu9jfNBRvwFFNIorDKunrWXoMZkRvNPuqAJQSAT9pux30o94UpOT0NGvCvdTxOZyvyb/LAa7H94xZF1IMomBL38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746545064; c=relaxed/simple;
	bh=q/Qm71NkoO2UMBPv4VfLfX+kvf/ffvJQxgxg9aEQ/hc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=llUh2xH9O+7h5sIZwTKph1CysD1CEc2Le9TxxjO9Qfvg6BypFxiPqtspP9ektXVTZkfipUPf3gwF0aVCzbZYOeSVpqJpd7/mCptTKlUenOn8hH4DttT2taQu5QLcMDTlnZ6MzRDSCwFtlYVe1DUzJ8fYFgdYkcUQ6OfnbnHYzKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jBc1RD6s; arc=fail smtp.client-ip=40.107.94.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBVtlOa0+0T5r8xpIl3HPjkNDPbMpBbJyUs4rs40RYFLYay+CDIrhC+W4ad6C3fSqMYf/avtUhnKJqB3U031tlmWsxSsoA1C06n1ROJY8XQOhs5Uk4jy590AoyoNvw2p12sGLn7fz/nR9otCPm9rjFHb9OZQR/ERFq25msf66XVXQU2UVjUmCcIhewTjKgFXZMA7MIlrycW9iAxFv5Hf9HQYkN1Htamp18fB9mR+DMzB88tMsoWYh7HtctFuGlVKwEveKemXp6SGpiQzT4Yht3IzZadWudu3pS1+ZrWIHFLe5IiBOL1YACwEW8GA3/9T6IyDvBbvH9MQtQ5ACBW0Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gua4wAEC7HJQgUM04lIDo+fu1GOv7IvGmCNfbxPzxs4=;
 b=p73qum2ojVhX71J/KB72JA9YQjfFDkwtmdvo3mVyjcpo6s+gUFmATYCG6bw2ZGp0AH6GSxF+H3qRGAeKEvcn22sPg7wxuHciOfV/qA4ggtGk3NVnTYtGtpiWJcPply92BzqQPtaH8dd6GqVuiqQmWv/M470Bvy/MF7uD+/RiXK4v6bbPHPM/X3ERcg7gdEGzNZEp1dej3UOKis88grGIsVPejN9cGvjLYe4Gqy2vDLDDXQfZ9kzFB1zzjSRepgDvMOWyFBQ6YaiTQnrqXkMJY5wvdw/LeWTotqg5QSNYeVdDki4vvnUGW5icBcWKQivk1iQex/sm6a2rFqat3glosQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gua4wAEC7HJQgUM04lIDo+fu1GOv7IvGmCNfbxPzxs4=;
 b=jBc1RD6suBRsW3BpqNDRmDlPVefxTzm4azoWju1J9m1fZS3u0L3jM20PysC7VBA8ubHkKIuis88V6nj2ggSB1EVSPyjsmQhVPdvk58/eIUGTql1Y9zeFtTPT52TOjoIKk6gG1ANkcsmg0QwkQh1/oqPy2Qwk9gGsPwce/xSSGKwPi8MQfBfQ2EiiyKQhNtcnlyoBQRe2JDMtW0cIDJP199pfecnmuL0jhLL68ju/vEVvai580Xpa8MVtCaVhmWgTHK+NtC6Kv0uXqGeLOy0Pg8hLtPVQQU95mFWAlrwDvCDeM3DEjXc1t4tBOKqu81Wvo02CI2am5mYCqJIzh5iT6w==
Received: from SA1PR02CA0024.namprd02.prod.outlook.com (2603:10b6:806:2cf::24)
 by PH7PR12MB7987.namprd12.prod.outlook.com (2603:10b6:510:27c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Tue, 6 May
 2025 15:24:15 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:2cf:cafe::9c) by SA1PR02CA0024.outlook.office365.com
 (2603:10b6:806:2cf::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Tue,
 6 May 2025 15:24:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 15:24:14 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 May 2025
 08:24:05 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 6 May
 2025 08:23:57 -0700
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via
 Frontend Transport; Tue, 6 May 2025 08:23:53 -0700
From: Vishwaroop A <va@nvidia.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<skomatineni@nvidia.com>, <ldewangan@nvidia.com>, <kyarlagadda@nvidia.com>,
	<smangipudi@nvidia.com>, <linux-spi@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <va@nvidia.com>
Subject: [PATCH RESEND 1/3] spi: tegra210-quad: Add iommus property to DT bindings
Date: Tue, 6 May 2025 15:23:48 +0000
Message-ID: <20250506152350.3370291-1-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|PH7PR12MB7987:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ab4553b-efe7-47bc-2768-08dd8cb20f92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dlaeZTgNaVyb7V9dwRzbvT6dZswhYbCR/GG16rS2KHlv6zLkIKhQgIO3UgMe?=
 =?us-ascii?Q?o8sdg2RzUlbW0NqUKOdovyWeZQqmmp7EzmwusJs1L9wCOCQJ2lEsWaYJSzWJ?=
 =?us-ascii?Q?Gfc49ok8myu8KuMpC8LWyRNHkZz4zRxjKueXYU6pRMMoupdS1VeiJcmxIGSR?=
 =?us-ascii?Q?LLh0t590P9Dm7GGT8crZWicYUSlcVnbP6vynMKY95PlbeZGcLXYEurgLhH5E?=
 =?us-ascii?Q?RZZrrVX0MEeBIop+n7yTHYxJfpKBdNrS+F5XFYyp5mYxstf2T0IuNd4J0hOF?=
 =?us-ascii?Q?/E1CJE8nxm78mDq9k6kNd/VY06Gh7+NjmccthxRbuPyjLfdJb00Rn7pAvgC+?=
 =?us-ascii?Q?ElMbqnPmH7XTayi2ZRzCIOkyC/fV32pxYrtLzN2CpWAI5Jdk6v9DGIsw6pVO?=
 =?us-ascii?Q?vbiQsaS4iVCG6JWtC/bvF5cPNnk574Cchd08ljLTJDkbA1jy7ymvu4r6vs6z?=
 =?us-ascii?Q?onPHdmbKc9oHNIkkBMZBV5sYHBRvaXj1S6OnFNiZYlzZ3nDbOlt0WP9VjuN5?=
 =?us-ascii?Q?llfxCL9T9Nq7JmczgLFETDCoqIQgPTBroLzRG5OOyh4EgWblWQKhOIvphF40?=
 =?us-ascii?Q?n8qc+xMlx15Z14GydRqC7PA08FPJSUYIfSBqanr1Lz/hCES2w7bVFezKFptj?=
 =?us-ascii?Q?a+Nia47oleboXSaShR9NPawLlgnC2UpWicVDkcl97N+ENW22mHBfjkN0CM9e?=
 =?us-ascii?Q?DIGLytmyDbX/GSYL9d5azoGI2Qe7H8Gbv4bdchOq6ezoIQ0X2fYhmHgur6k9?=
 =?us-ascii?Q?rsFS/1TfJytgiRlUtS7C6GxTxGmCMaAX5k9oVWo778qpnHioStsqGee7wQF2?=
 =?us-ascii?Q?ewEd/Hv524tPej8SGHF9gSb/ms14i4J2f05kSwTHl1UHdYGd73JmUSIMIqTU?=
 =?us-ascii?Q?7F54uhT0aAS6b6/Q0x90s6Sh7waHC05hCwU19q1yHqkYgh2W9DcgA55qpxn3?=
 =?us-ascii?Q?xcJTRI/HPord5edwpKKbiwCR4iH+9FM6HAGIMWLcvCDVUL3iEbZ90e27PcOa?=
 =?us-ascii?Q?WNOZPGpDaxGkyzPE/wjaSJo5Hh7iPe72lAkpf+tMLNnioeKepM3+1M28RX6c?=
 =?us-ascii?Q?FsDUMN/1DaiP3IgFciAmSd86vUOub04zRzaqHTOiy+aZ8nX+QQLmZIj/ns1F?=
 =?us-ascii?Q?17JGQbKLit7nUkbFySQIv0onnIBm4lHEaroCNxJJH3H72YNRk5n4JFJWJc7n?=
 =?us-ascii?Q?KVhEviDMJ9O9KAVOrao9gfVqHeyUQSB/kG51AAxX10MHSrLwE+qlF3UrK3AH?=
 =?us-ascii?Q?EFckiWUIW+ZCLpPc/1KHc9+6fSnESJDoxLFrPTO2A5LWDfKYL1SzFEV5gqFh?=
 =?us-ascii?Q?adfSggkCS1fxL9bmPS7lzz+yFXobDm1FYQg05wI8PSpg0Lmp6KR8OPJLRl4V?=
 =?us-ascii?Q?vM9xoCtkdHzeOWHbey/6GjHD0SH1Uth4T17kQXrmmUbBw5AtncFpisPWMB+p?=
 =?us-ascii?Q?ScASshniDuz5VbgHsW5ZO9+rGebmR7IfWH445BN/do/qqw2YBugsYbqGGS/t?=
 =?us-ascii?Q?GfUF9QFjFqfk38nWEHkiH0ZYh5NDdS0XX+q+TDLiJan8G2XrO2ErYaAupw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 15:24:14.8319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ab4553b-efe7-47bc-2768-08dd8cb20f92
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7987

The Tegra210 Quad SPI controller uses internal DMA engines to
efficiently transfer data between system memory and the SPI bus.
On platforms with an IOMMU, such as Tegra234, DMA transactions
must be properly mapped and protected to ensure system security
and functional correctness.

This patch adds the iommus property to the device tree binding.
This property is required to associate the SPI controller with
the system IOMMU, specifying the correct stream ID for address
translation and access protection.

Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 .../devicetree/bindings/spi/nvidia,tegra210-quad.yaml          | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
index 48e97e240265..522efbe62010 100644
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
@@ -47,6 +47,9 @@ properties:
       - const: rx
       - const: tx
 
+  iommus:
+    maxItems: 1
+
 patternProperties:
   "@[0-9a-f]+$":
     type: object
-- 
2.17.1


