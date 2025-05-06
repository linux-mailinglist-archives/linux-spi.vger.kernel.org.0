Return-Path: <linux-spi+bounces-7926-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8E0AAC3BC
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 14:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A44CB3B0A9A
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 12:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEA327F4F6;
	Tue,  6 May 2025 12:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E1wLC9hc"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D0A1DED51;
	Tue,  6 May 2025 12:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746534182; cv=fail; b=s3Q0u5PIkoDLK6QkjJonH596IIHm+6uxGl0aS8SsNUDtYveaBNQZIkiCZhB/qYTOT6fHZNsLCQsgZYiOVmZc9Dtv8eCj/uRRp0WwwNgmcMYlBG+JeDYHhkkgIVgvPAVo1UndxSn/Y0mRzbHrHDEaThIXl3ORxhzBL4UhdIRKbN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746534182; c=relaxed/simple;
	bh=q/Qm71NkoO2UMBPv4VfLfX+kvf/ffvJQxgxg9aEQ/hc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JkpnIborxQyJYPYXDfqVMcNr08GgSh7cV6ChRMHgFMwZrCS/+vAw1XXlK/S5NU90DP5N3imtYHxnIrw2jJ0Lzyug8l8m5fzziCQsrERmCuNPD7gPZ3qCgGroKKZu8I5+DY4dflXeEVqapSTjmxQOEO8p12Powge9C37YIMz18lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E1wLC9hc; arc=fail smtp.client-ip=40.107.94.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Go52EF0iw1iN8iJia5oMCiIu/EkllrJorIc3CfvlsMX2JHRCMOy0zqacLjB7vxxPSY5c5qJRRVuAO/ucrKHFnccC+WuPqU/g6IVIcdTN8SkOcJ7pogJeaWItNV2hB+E4/cbD22hrCEsCH1iRZE1RU71NC7ZznNoRrYeJ7QXnwrftAtAVeDBg020bmoBTkdx0NUBT2mf8VrYvsn+rbhEvmBPoRWg+1jL6Zo41hTbvqp+oHXmUzGch6YGHSGCqvdNg/JMPZ0ubsmxR6Zf8TWwBmN1WEoJ7w9tB91rxaY9xcMbvRcUazF/yhZBAnFsacsqdBShJSUHvQ/k2u5FlI1OTrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gua4wAEC7HJQgUM04lIDo+fu1GOv7IvGmCNfbxPzxs4=;
 b=R2EDskPTqSKOU01JwMQYE6+aXvePRcjXv2FUz5xwLaMXg7YSkGqyk2XD7+JOPqqkOHHhixT05cE/9+tnY6NTtOV2QGNaDU9lE7LcdHecNQycgbNlFsDACKdLQhdcWwB8TV+FP+uPZF2WlDwiG6DqHwtYOjIuB4GbHbJtJ2P6tXRK4m2WleTViCstHikwjG1w5pxxpJbNCO0/QjRF3Xkt2TfugvuWMfpT0zZ7Ku4OKC32lqiHLieOrp4hPVi0/rxVemcDnf0Yzt5bmD88HNiFO8zcIH0FOUiKgrFK2yVQPMbj8ZWWKRk2SwhoK6lfR5E8RVfHZvPDu1py6mhi/PUP4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gua4wAEC7HJQgUM04lIDo+fu1GOv7IvGmCNfbxPzxs4=;
 b=E1wLC9hcAg2VULleO1/Zo1LvP1KN0jZGDTiqvw5Ykh1UeKcQyV1b4A1YoChBwU0T5CkQBQZaoYW6XJesWhx9Y2EHqdGrVeQHYYPgLs2n2RPIhr0xYXyaH2kD6Lkk9kjUytj6ZoA0LLOhf8y9pqPZYs7TAuTvBRaPX+8mwY9V7AXfuHyOxT7Y4k97qGeVy5vrYSvi1EvEsZTjN3tNTEJEhbaf5HACRdjbarxFCMgCrwZksqFc9GR3/DdcrQhnJCpaEXmXvzfPUCzbr/eDhKxP5cppD6aMRAdJCl4UjzlQXlyjLiepu6UHpdId96CizPRV2sbpHxFEEB4wbzeh99OcPg==
Received: from BL0PR02CA0040.namprd02.prod.outlook.com (2603:10b6:207:3d::17)
 by MN2PR12MB4125.namprd12.prod.outlook.com (2603:10b6:208:1d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 6 May
 2025 12:22:53 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:207:3d:cafe::aa) by BL0PR02CA0040.outlook.office365.com
 (2603:10b6:207:3d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.29 via Frontend Transport; Tue,
 6 May 2025 12:22:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 12:22:53 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 May 2025
 05:22:45 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 6 May
 2025 05:22:36 -0700
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via
 Frontend Transport; Tue, 6 May 2025 05:22:33 -0700
From: Vishwaroop A <va@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<skomatineni@nvidia.com>, <ldewangan@nvidia.com>, <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kyarlagadda@nvidia.com>,
	<smangipudi@nvidia.com>
CC: <va@nvidia.com>
Subject: [PATCH 1/3] spi: tegra210-quad: Add iommus property to DT bindings
Date: Tue, 6 May 2025 12:22:20 +0000
Message-ID: <20250506122222.3345040-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|MN2PR12MB4125:EE_
X-MS-Office365-Filtering-Correlation-Id: 123a7dd7-f119-4069-7719-08dd8c98b9e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1dIsJ66MvgaA4fWm+7/4NYKeRlMcjcP8G61S7pzjDWYF4FYT717rMaL5o8IG?=
 =?us-ascii?Q?xT3we6Vxj/NN9rqU9TPNyBGKiU2kr9JoyfQ/oPb5yESSYQlD2ez9W1vVVTAt?=
 =?us-ascii?Q?dyPOJE8MjRpEWa7mCGKjzVGswQv8tu5U1E1Qr9O2+imOKPMJFSR3hz4BE1XS?=
 =?us-ascii?Q?Os3Y5QSzlP7OWifnhFsZZ1FNLEULcp5BVqUDfBEcx5GhhanWWp+Fj7unTSg1?=
 =?us-ascii?Q?r71yZDYKVRBhAct6ahzEVemHf65a4oNFk+T8x0mC6bnOEXZWmRwJIUAMOh/8?=
 =?us-ascii?Q?tek6YPXW878qYg/rPfP4GvrIl+tSHdtekVOnYEZTx3TPykjdxA9LScjSGBno?=
 =?us-ascii?Q?RIlPFGEbGVSc48Q0plQ/VPHjOoOLeEiGwg8v+e2RUW7UlBu+ZA+ir1AvCoRX?=
 =?us-ascii?Q?bUuCzPWqzWIa0Ct+tpvDTUcGI6AYiEIQEc9iMEVT5YUD5p4BjKMMOryRQ1mW?=
 =?us-ascii?Q?0BdkHJNDbgt/4+BQUB1bq9T74knmMmNgdEx+G6xi9PsRJ4rT/zIQp3xyyclW?=
 =?us-ascii?Q?0YucPnMK1yuMqr8sZWeumQvvVfqB0cd+YXG6ak2O7gnTCYPRUhFplOwmDliH?=
 =?us-ascii?Q?MvCTjN8uZCgj6Lr9cs/g65LIRdBM+n8ZwmX+2kiT+5Iame4Ro55F/pWj1cYz?=
 =?us-ascii?Q?uMonLKNt7oRpqWrDqhQjZtF2myUIHfqh34YF/160lHiw/eDgH62k5FigMilS?=
 =?us-ascii?Q?P1taa52WDjYChpGDgvd7N/z2Oj+HeEl9JAO0naeSu1pGtTdERc7kZSxpA/cO?=
 =?us-ascii?Q?YTzHi28uqMQki6QVHBIj4SFW0wWHLeWW0mlxRXrViA1NbdxyD9jjJZgWkb35?=
 =?us-ascii?Q?QM7OyvxcZCXUIRo2FIGpBa3Fg40bwjkY1SlBs8V6x4IC9phwWB2T77Ctth5I?=
 =?us-ascii?Q?92t3JxJPgMa0G3kwizS/XwKuGYi5PlCKyQi7cqRZ59vBFdhQH4CXlMYwOgqG?=
 =?us-ascii?Q?CGB0teFBC8mkzQd3UGc6zk4NJ+w/ZcttbTanYmcFWvnMh5nPDoDqRhCozrUQ?=
 =?us-ascii?Q?2V5EwiAOB2kNVwnsHsvd/+QZzmn5eEUEXtnUsWS3BKL+qwiSvFZir9wUG+KN?=
 =?us-ascii?Q?wTKN7Dijyj+niuGqrNrfrG15471UaSUhnMUUGe1rq+8REzLLgFuKCSt2WxiD?=
 =?us-ascii?Q?+6b/rM6M+dev6o6oqu7T2TfeP71MQZs00+q0E/uLayfDiUSJDptJfrcUa+IY?=
 =?us-ascii?Q?G1D0kOF3o5zOwB2mYPu8uWPLrSVJteZtswFA2P3pmow/7+An0oFPYkAFfME8?=
 =?us-ascii?Q?bg7zco1VnetD2l+YCB2fxSnRAELBaStBItAHABY8/MxkP5KFusQO9orkgo0J?=
 =?us-ascii?Q?Q7xxinn6UMSieLLE4wAvK+74nVijJmjM8ZkZXJ4Hwy7PpiGcpf9iX84FKtt1?=
 =?us-ascii?Q?n/KCQfglkEemP+0B7WdbnhOE8jxGaaXU2JoMCK1vFTs66xS9Fly8KPmFl5ZK?=
 =?us-ascii?Q?bExfXEsl99n5/hFzuXS8XXLlOAygXTcJxJo/We3yp8r+HeBYwi4BpGv0a9RF?=
 =?us-ascii?Q?ia9kz9U2KKe2j0/UL4WJi7df+0WdRRn75w+V/20YaRIvrMgltzauWV60vA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 12:22:53.6359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 123a7dd7-f119-4069-7719-08dd8c98b9e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4125

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


