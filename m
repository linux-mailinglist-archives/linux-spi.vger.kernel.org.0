Return-Path: <linux-spi+bounces-8044-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07616AB1B18
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 18:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB8309E412B
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 16:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A51F23AE66;
	Fri,  9 May 2025 16:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UwiDFIiq"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A5C23817A;
	Fri,  9 May 2025 16:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746809681; cv=fail; b=dTNIdNDoAjpRdZroSeg+HCwMawlg/OsxUh2GG5FNFpEft81GCpBla6ajgV6MXRq5hSQbwpsMewKeSfXPO/kZv7o6rfIFb+8RdgMhF6m9N5vt2eZGvJBx6Ew2PZ4fKA/QNzVPTyThXru3hMibptdk2HL/IaD60+qxwfQQdqBPsnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746809681; c=relaxed/simple;
	bh=oOckK7R2MObM7ynoymnREXirIY78NB975E7U4tPYq5Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uaIlg70klgMUeZxxpuyjekiVfFCx1hz7PLdrIXWcu5LR7zsh2iDILugC4IRXDZMgO1mOSpNHia4sfxgVn2tJ2klJomVW1A/tMzBWkih3qil++s2hKbjT28+/0gE5XuImOjS6XDmCqrg/owU2qGfuHL01lRVC6u0VGZLID7Dql6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UwiDFIiq; arc=fail smtp.client-ip=40.107.92.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFSE9eLPTrgyWsqPEhLavTd8Ec8NGnkrjkBb6aTDL8TenCScqhnK+jYxdfaEdc8T6OICarTCIx2g0qWkmHXkG78h6ef2joNJbtfAWGl9d4FWlmL/sSuvYQRE20tM3mo6a4AIIlzX0iIkC1/JOwtbrwPKnJow/0Wg9HQd9EjL5FzaXvw1gSDY/8N1CLubVjqFmeUNDh9F1D7AX4PhLJof9xX6c1XtrbsWxU8kmOXkChy9ioCA8iAll7mg2MsQcEtbjAGbZ3UC2nGnqpM2eXAoPa8sF4h76arzEUkvpCrekZxhPrzaAJl2SGkJ3ktqpbAu+Fs8gj9YR4tuL4bK0/L1kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4Bil/tAiGPy4IY9Ypm23QwsBRI27CSIDXV7whr+Wgw=;
 b=hEAulLtCooPBtLjeX2CzhY728d7t6GFZJnGCvnoFShWstQQYrasGGxXcz1N1WVEcRTiTYKwn7i73vJvt/x0fKTSkwG8Vt7UIgNNV+9u7E2lo+Zj8Sx+ov3sgrbwArEGn5LvLcSrZv4gDRK7mrMyYmuEXkzjrSia7kTQNU1F97uI5h1czoEKgjXRQIOw88/ZCuUsz36PNHnfyI+tNzRYzv9o+5r+rSKAxsLHVMFUNc6iPtjoeIqy/P18hwEazhrf2XUTkrDwHaSw3Q8VVO7Ux+cQNZIqj9DGPcq8sT1kYQmoc6PQHvpwHfy5Elsx3L2ZopE5WOPoy3FRMKFoMTi/H5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4Bil/tAiGPy4IY9Ypm23QwsBRI27CSIDXV7whr+Wgw=;
 b=UwiDFIiqdFpT7CKpeWxP5UcRUeStlt7bovpM9ymgxkT4Tfp1YhSJ0rWu3f23mtfUO7sEqm4cpQ9FIZmDZLyAbIl1kdlg8wQ2jtLBmthJZII4qJAas798nHG0kR6NS1lvqaHOuZC9RhMhooVj+jQhCVdf+LglbxiRYBWQ8UWZQNyyOtFkrFqXhC8MsGUJEGrXegslboIgAOwFH6dhFwyPQh75ll2e/Z63XkwSLyZhmWmgxVGELUyMBRTqa7WiH8dG1uXNgvUGtGf2+WjTCLSavQMC+gieB4sK4pPQUnmCpEYMkt/5mAErQcfA5PtMFz10telrr75heXOx1y1FxD9YbA==
Received: from CH2PR10CA0001.namprd10.prod.outlook.com (2603:10b6:610:4c::11)
 by PH0PR12MB8031.namprd12.prod.outlook.com (2603:10b6:510:28e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.35; Fri, 9 May
 2025 16:54:36 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:610:4c:cafe::71) by CH2PR10CA0001.outlook.office365.com
 (2603:10b6:610:4c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Fri,
 9 May 2025 16:54:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.1 via Frontend Transport; Fri, 9 May 2025 16:54:35 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 9 May 2025
 09:54:26 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 9 May 2025 09:54:25 -0700
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14
 via Frontend Transport; Fri, 9 May 2025 09:54:21 -0700
From: Vishwaroop A <va@nvidia.com>
To: <krzk@kernel.org>, <broonie@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
	<kyarlagadda@nvidia.com>, <smangipudi@nvidia.com>, <bgriffis@nvidia.com>,
	<linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Vishwaroop A <va@nvidia.com>
Subject: [PATCH V3 RESEND 1/2] dt-bindings: spi: tegra: Document IOMMU property for Tegra234 QSPI
Date: Fri, 9 May 2025 16:54:08 +0000
Message-ID: <20250509165409.311912-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|PH0PR12MB8031:EE_
X-MS-Office365-Filtering-Correlation-Id: b9fbe294-7867-46fb-7c36-08dd8f1a2e08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?usE6uzTvPGygKmod2Vv1iWA/feaii+0yUydFzQYUuTs3VQXWwCro48tMoqdL?=
 =?us-ascii?Q?rpTZjl4So+XqtiJQKp0GU4h1Xn0h4vVJ1DdecwFxJNjxiOg5daMG3ZGWvkFv?=
 =?us-ascii?Q?Meee45C9p4rleuqHDCwzfzp+uLPUMBLC1p4liGB6UWTRojU++s6B6jU3t1Vi?=
 =?us-ascii?Q?Los9KFGKS2cxhSH73z2SIb7LyNTYvhOkcqDLUnz/FPJUmoX3RlS8hmUy0zzy?=
 =?us-ascii?Q?n/6n226JsSb9kNc0eVuoQZsGFosHUnF6RJIPulxFqRPV5OjBGo6DdUAarOZb?=
 =?us-ascii?Q?Jkiosy27idiLazyjAZwGrudFFtSDkV/MYytvpo608cZfrYIcXlM7zyyq9ZTS?=
 =?us-ascii?Q?A7HR3srOkOn2uJseHD9HLIRfwrR9+x2DzSgxnKpu5fSy2LcU9s4dIHJh0eR8?=
 =?us-ascii?Q?B8CBOnDE5lYY5o8QZvGlbq8nEksJ4PEPAuVYl5LJuml7+ob5KbmFk9hEdD4k?=
 =?us-ascii?Q?SmkwvSuvIESNnNqoj/qGTPQ9MUOhzqKWU92IAam064yfjma90Nt8v5HrbThe?=
 =?us-ascii?Q?d6YBg0zRG1x9g8sYXPtb/XxGOFGd0xQD1GJtyiwiqNcBkfXB2hRXTfC7qQiM?=
 =?us-ascii?Q?T3rHTK4xW+5dbFNTVr5hvjk3CIXeYrKSu+L+PJ4wBoMzXM22pFotSS+b4kTz?=
 =?us-ascii?Q?i33GWK2GUHxbwZov2zCd+6ROz21yiDVtZg6b86iepVrm2YyMhW1ykoWj5V8s?=
 =?us-ascii?Q?bxvmeDx8QlYulzcr2HSoKKFh2OIhav3U2bR/qc5CnCn5N3E7ufKmd+o77G5G?=
 =?us-ascii?Q?dqijKEVVx8sNyFGCw6hC8Fa5NOBpd6nmGS7ZEhzdB4sS0//nJjBNnFuO/cLC?=
 =?us-ascii?Q?eD2Qq0hkUKE7dqwhJezOPT+uUyEkYF7i+4j0eMsoDGd0cA4tWwzXAglgwes+?=
 =?us-ascii?Q?Jyv6TSE98a/Sv/TD2CTFbdZ+ZzhQJh/OPAw0g8PjZO6oQlC0NxPoBFDfVarM?=
 =?us-ascii?Q?HS1DVIeAhKFFJpuFzBQa2gMYHUliIuIGjtTwA88ARcOfNeVX5CLsvHD/tYwZ?=
 =?us-ascii?Q?H8Gb2TjtFEJrAd97MJifljqB7uInazFJl3SQRFzfk7lF9ZZhH/HD/Omzqj8K?=
 =?us-ascii?Q?RpXGpDQvh23z0+oDi7dP4ibg/i5eGyuykFirmV1IvDtkMg21YC5vTIEZnc7y?=
 =?us-ascii?Q?RoxKZDz4m+QQ7DRxj9RBnoFuVOO/jCCotJWZ/ckvjRcd8Q1sDmrIkL7zMjuy?=
 =?us-ascii?Q?Xhj/2wdwuqqSVdCkEIXmzCiJds9klAQPopMKqMz8ee9sddbRWzK8edUkNin9?=
 =?us-ascii?Q?4TM5fixkN3DrZfcaUUYZ0jTPnoX00Vnj/Wkzw2Io5Qmwlur0+gk4jxnMm4bq?=
 =?us-ascii?Q?HSX7pm7F0sDg+wCjZ669q4TQCS4BreXoTpeEE5EI/5Iq6rX88kapZ66CW7I0?=
 =?us-ascii?Q?ks+D3qQvYqYTOfDpi0HQcAWhuuci++rGBEjXdgvI6PEf6+Mp+RUIbyDKvISM?=
 =?us-ascii?Q?9T5z9+Xi5wQJReahVvMsuX/1eDTNZcrTY9AlCdX2coDI0GLDZPhZ3X2xv0xB?=
 =?us-ascii?Q?dQ0YkbxcHkMf8E6RIkdNWZK/xKEeKF0P/5KjbKPoIgKoXpODmCZapDT4aw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 16:54:35.9466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9fbe294-7867-46fb-7c36-08dd8f1a2e08
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8031

Add the 'iommus' property to the Tegra QSPI device tree binding.
The property is needed for Tegra234 when using the internal DMA
controller, and is not supported on other Tegra chips, as DMA is
handled by an external controller.

Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 .../bindings/spi/nvidia,tegra210-quad.yaml    | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

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
index 48e97e240265..04d3b1a47392 100644
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
@@ -69,6 +69,19 @@ required:
 
 unevaluatedProperties: false
 
+allOf:
+  - $ref: spi-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          const: nvidia,tegra234-qspi
+    then:
+      properties:
+        iommus: true
+    else:
+      properties:
+        iommus: false
+
 examples:
   - |
     #include <dt-bindings/clock/tegra210-car.h>
-- 
2.17.1


