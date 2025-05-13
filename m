Return-Path: <linux-spi+bounces-8111-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2513AB5D7B
	for <lists+linux-spi@lfdr.de>; Tue, 13 May 2025 22:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CA854A7D1F
	for <lists+linux-spi@lfdr.de>; Tue, 13 May 2025 20:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A581CAA96;
	Tue, 13 May 2025 20:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W429LI5o"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70130B672;
	Tue, 13 May 2025 20:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747166486; cv=fail; b=q/SoBKgNE7YSPNX0mNlk02sXw+NO05lullkHzsKk/vW/oDVCgqqwMSytJ+CwwGmqRD6YwZ5vAesIIk7e35GIt2kVMHR1DiT20xnIhxxjHlp8eWNPP8n7L3nUSyDcSsilagZkstNGEqycAPHx2GBFEQ1qATW6ND0TuK3RGUDWQ84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747166486; c=relaxed/simple;
	bh=wjYau2UpbNCSltTtxKk3ZxAN0EEVlzhnc9DGJplp4OY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZcRm1ssWJG1FZPg/2t+9QATb2bCESm4gXxY8dDDTLlET7VQ9mG7v/rnJVHbMGYx2QDWMVDiNzcr75ViVFTLJIG9SjoQCFGvO1zx5v4TFC14mw64hLROYjun62YgS+AORaSFYSMqOfmLq7VibxgTjKuU27ohLTqLhw2C5N6tptkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W429LI5o; arc=fail smtp.client-ip=40.107.94.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dApyn2/CLKeylNjBBBldJSvQ64yYymwRuQymzNLXFQIqc5K2mIlnvWjXICW3BzGvWfqhywaOGngni1dDVUidETk6BFx7PrX45O9JS2ORpSteI2W+0ImlC9c/FO+pP7ZFA48cOJjkzwkJ4XL5h+EcD3/Ey+LnkVGPc9AkvMRHdbgYNksXkty3gRdXLDMkyoNMino+AotUTfyEyu8VeMMo+XNeUfLV897P0JDb9aUkRgMEgbRs8ZT+AU/HuGNcJE0O4DxFWvp6KzhIXNSLQy1fxqUNbE77B2611jqIYWXI4dYyzbKwgPxEi/xoZH50kfXg907yP1+gyFtL7fZFRUpHlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjTXHzpZNqyekZF9Gvi6pQSs6bGGkIY0Y8SvmTVzH2s=;
 b=asLDZ117FqKEGWQqXYPlb1f/zwCvKDqJyAjV/3LZhzkSY73VHYVbh81LBKW41TVySP4s/onrUf+bLtl90k40LLzMJPWOdrROFKDzRTQnrT/sRxyRMytFw7a/F+WTW6uHpN88yc7gr07YPOQ7cjVp72l6NnD2PNkoR847pWOQOh/nMvrMKlKuHwPdRQClb8E4q7amXM5Gr0aerjsc0my7023sN9too7L1Bei5e/91wqZI371kXE+fZQlN1vKNrq8YFhKG6b0o6q4I9XDRWxVN/ys+exORBtvval2ATwtxekaNzBP2Y7IwMy0jHu75MMSB3Znn7mf3H6vXp2t0uUq38A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjTXHzpZNqyekZF9Gvi6pQSs6bGGkIY0Y8SvmTVzH2s=;
 b=W429LI5oUg26QZdbB7m1sk7ugW3aeH4YhKpKrs+pXyPsqt0oatqTe/lvwa0CbdkRRlmEDPK+ASDDPJqzBlH5blSbkVSNk7rgVmSgph2aln44EyL708/W6WejYyuiRlfq/a91Er0i2Sx5/CaOI0soBjmHCVXJTeOBvKDduWtcF1eIVayKyY3NUgqNSmDLorxoZDyRJXAPMLLYzHyFnNScqpuiGlpJID5O6faepMecvx1Vr6rLoPVFjpcGxeExLscQUCelCbIaFbaV9VdFYmk7MAry0jBLSBBpwhJ6sGm9hZZd4hC+5Uy9xnWR8oe+V69yy6i9BycPUTCzdUGFM6UwGw==
Received: from SA0PR11CA0077.namprd11.prod.outlook.com (2603:10b6:806:d2::22)
 by PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Tue, 13 May
 2025 20:01:19 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:d2:cafe::49) by SA0PR11CA0077.outlook.office365.com
 (2603:10b6:806:d2::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Tue,
 13 May 2025 20:01:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Tue, 13 May 2025 20:01:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 13 May
 2025 13:00:59 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 13 May
 2025 13:00:59 -0700
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via
 Frontend Transport; Tue, 13 May 2025 13:00:53 -0700
From: Vishwaroop A <va@nvidia.com>
To: <krzk@kernel.org>, <broonie@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
	<kyarlagadda@nvidia.com>, <smangipudi@nvidia.com>, <bgriffis@nvidia.com>,
	<linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Vishwaroop A <va@nvidia.com>
Subject: [PATCH V4 1/2] dt-bindings: spi: tegra: Document IOMMU property for Tegra234 QSPI
Date: Tue, 13 May 2025 20:00:42 +0000
Message-ID: <20250513200043.608292-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|PH0PR12MB8800:EE_
X-MS-Office365-Filtering-Correlation-Id: e1a32bdc-4a5b-461b-9125-08dd9258ed6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rUbXTg5v+vvNzpHMn56v++xPuegaqfGNOMgqGBJY/Pz5oFB/6ut5RWICSgxR?=
 =?us-ascii?Q?+9t3juFGAQpatKNvrs6FYvno822u6dUTw1qcx8j9u9wCieGz1X7RZb7mxuMK?=
 =?us-ascii?Q?Qdpm0ViEMx4sIf7ep/pP3FmK2ERk6VhAMgCesUpxmi1axPls/QcTfXYAw5Ml?=
 =?us-ascii?Q?kKre+T2egUKGEPXPFxYgAYtlsmgEkBJRXUisHViExi3KUKZ5heoYhE2u4UHO?=
 =?us-ascii?Q?pWPMk91Mi/CW4V9/GgU3QKUuEgYb3qECwcRk55o0Y6KlMCDX+vkM9UkkqW5x?=
 =?us-ascii?Q?KzqRHNPircjvAKX+itRAJ+Jvt54709/WJvy+OrVBkGKDaVZ4Ua6t2UPW2vfr?=
 =?us-ascii?Q?Mc7FI2uPHudWjmFumZe4fsdcxQPrbnE/9iiukghpa2nRGqqSzrPGQqRW/4XP?=
 =?us-ascii?Q?9MYUOr2SeaskWvZSsOnbIS+rLYUDT9suqB4UW5YOVP3I0Fspd/cMEUHo5m/8?=
 =?us-ascii?Q?k6+ox0m6SEWrHVDoV5NpgFeShs6iivksVTkWzx23T3l97U45d3tOSnW757oF?=
 =?us-ascii?Q?ARcvfwMC6nmRzAhkMLdiuUhGFz2RYuXH/2CTYPH3LesoHgttI/CbCbw6n9sy?=
 =?us-ascii?Q?cmonsEqgey6WenpGlM6ktLTZ/bjBYGJm0QUxsIPmP0q+wRCpT+mA6BpI5NLX?=
 =?us-ascii?Q?bvPd3Q7RRzwvoWIsAWnl4OTznHkVL2kU94xocuZR5tbJRRQToU4dbIZ2GDi8?=
 =?us-ascii?Q?27mzjVw/sdByLAWby/tIMEwricHnKetf1wloNR1TEb+CFQEafJ8YQne9gfHN?=
 =?us-ascii?Q?sk/BgxMOtySfh1PaDlkdqoccra37FNxhrjOn1YZPZyJTIXMus6a6jgUcuHVW?=
 =?us-ascii?Q?gGzRynJG6+AQqBkRrE1TjlKwpfLaPGxYlnsw+n1/4xftm2RLokwUKSlFVS2P?=
 =?us-ascii?Q?zz8V5japRAhlFs+KByn+m9JXQ2ioB27BX3zndWGOEzsOQP3OJ2OBhTWpFoup?=
 =?us-ascii?Q?g5qg7TdDvhB7/cmlw8qPp5cWEOBC5hVqOhlIwr5NTSXOU4F24VtxAifsTzTM?=
 =?us-ascii?Q?qfp9FzXHYzehl20yMYp+Po7YUC9FwUi53aR8DYbCjlyydBJPsi/TT4krujWM?=
 =?us-ascii?Q?j3Gg2jUGR83sGtJ6t12MDHvd1Kv8b2EvSMkUsmZJngmr/eQH+LXaxfy/ZnPC?=
 =?us-ascii?Q?hM99MwSW6F/xtQTzuqaVxfmJmM/fRae50/gsN8d/Od/4LQeuomPI15akADDR?=
 =?us-ascii?Q?roiEqi3/FIkVlu2fRstdEb4HJj0tITVnQAej1Tk5WRfojgvWLlzlz0MrfA1O?=
 =?us-ascii?Q?Ngi0wI6NN3U7aGesCkU6QK3C3xgNZsno/M7nzEz1B+NmG8o0LRkPoW/CNGrW?=
 =?us-ascii?Q?jeUkU8IkUoYh1NuBbk/NCi9quULkGhQqcnFUj1w12QgiboQ6o73ZyjW2P/ut?=
 =?us-ascii?Q?qB1x32ZHt6TtpUbcO2+v+c6XTFRIihhSYt7s8/7P9QhAxXBNqxOf2wWR4Yzo?=
 =?us-ascii?Q?wjzo0jFaXxZdlrVGb/gjPkxaopMD4J+VJDAznhvTPqI8jTlEG0IAfHWa5NnT?=
 =?us-ascii?Q?UGSCnlflsooXX/f+aI0AgeYZcJNWA3RR0+2jCLhJfFqfK6U8ic36YsffDQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 20:01:19.2822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a32bdc-4a5b-461b-9125-08dd9258ed6a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8800

Add the 'iommus' property to the Tegra QSPI device tree binding.
The property is needed for Tegra234 when using the internal DMA
controller, and is not supported on other Tegra chips, as DMA is
handled by an external controller.

Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 .../bindings/spi/nvidia,tegra210-quad.yaml     | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

Changes since v3:
- Inverted the logic of the conditional statement for the IOMMU property

Changes since v2:
- Fixed version number to match the actual version
- Added proper changelog section
- No functional changes from v2

Changes since v1:
- Fixed subject prefix to match subsystem (dt-bindings: spi: tegra)
- Improved commit message formatting to follow Linux coding style
- Clarified that IOMMU is only required for Tegra234 platform
- Added explicit disallow for IOMMU on other platforms
- Removed redundant explanations of what the patch does
- Fixed commit message to use imperative mood

Initial Version:
- Initial implementation of IOMMU property documentation
- Added iommus property to device tree binding
- Added support for Tegra234 platform
- Added explanation of DMA and IOMMU requirements

diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
index 48e97e240265..8b3640280559 100644
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
@@ -10,9 +10,6 @@ maintainers:
   - Thierry Reding <thierry.reding@gmail.com>
   - Jonathan Hunter <jonathanh@nvidia.com>
 
-allOf:
-  - $ref: spi-controller.yaml#
-
 properties:
   compatible:
     enum:
@@ -47,6 +44,9 @@ properties:
       - const: rx
       - const: tx
 
+  iommus:
+    maxItems: 1
+
 patternProperties:
   "@[0-9a-f]+$":
     type: object
@@ -69,6 +69,18 @@ required:
 
 unevaluatedProperties: false
 
+allOf:
+  - $ref: spi-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              const: nvidia,tegra234-qspi
+    then:
+      properties:
+        iommus: false
+
 examples:
   - |
     #include <dt-bindings/clock/tegra210-car.h>
-- 
2.17.1


