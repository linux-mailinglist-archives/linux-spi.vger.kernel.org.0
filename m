Return-Path: <linux-spi+bounces-8032-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8639AB1381
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 14:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79D60B229C5
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 12:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1746927700C;
	Fri,  9 May 2025 12:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oOAzZCa2"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9431482F5;
	Fri,  9 May 2025 12:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746794155; cv=fail; b=m8l0y2IiXDP/2PNLYYmQfbgZ9q8cLjcxrC7HQB3odL6tMVWV7nVaX8GYSJkicVROheMRTmcBKC9vuvRcIlZM0sQDQASe+/BKZ8OGS531wMSipRNf56McVsGpEUdfd8Fx264/wuF4nqGfDk0Tner4r1phLraIm8Xyqr0ItB0PV/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746794155; c=relaxed/simple;
	bh=rwiZrZpsdyTA9VcBafX2w+TYgeu+GOWAt+S5eBmsDa8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZIj+gqBQNpDeD8W5koBneYbYmAufcmeLM5s8JW1O6U1qQ3/tWqiGtZGIa3v1DtEuNx1TvTOa0UliLAyXPjS4KHIWxoIrtq/PDquMsc850/QRy76aim2BqnmYtolvsN2Ae54gEHoB0vZtP8J5pxkBm09gd41mp1qjwSC7VjDTvRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oOAzZCa2; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hmuEmKW55Hqru3XVQc64GWOVkyd8JvcXgwTNDAU+uMpMuiYnUgRn1F1DmDaLrmbYJmVzup/GOWBD16e0X8tce6GFUUSe0hPUdgr3UDx1ND7PNvvmyONs1ygAK4EsrpDLHTaYTRC25IN5q7PU3sMXAScUDsfK41oKJ5T1CrYlFSrDJUK9MF5NGbnxta0Uh7uLJq5gH0fW4Mo9oLaHUPxD5qG/h6j/hZjyopOU81ImYb3G6xw4J13wppMT4+epnOwVSE1qHIKiojP9uQIN4N7yMaExrgE9U2e2pdnkBBzgtKRICYfmGGrYYgf/b5Cr8bq3XZNgB9DNNneuLpdW4w8XxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZW4tCVnuhb1kX4elKayY4342q/anXKXqJPpnSwqn0s=;
 b=TCO3h9N/f1htuDJXtgRb9Chs7HkA/9EJKsq93r8n5MfwEfXh5Pz7qF6FL37GtJ0rf8ozUV7hP3SabFGr/ZEzY2dtW5Zx0Wh1JvkdajOhkhbTWRDTHhy12eTdDAgTfFfRusE8G3JlN3AN3qETDj+TCICjzo/OoiBafiYisffa6maBl0+5+WgOZTqinLibJp6xQDbdue6AFVPT10TN2rBdOnUVttKPDkAm3Rpmq4AhIgwMCS5DHFr8m3cdvBqc0cLmvLZkvnw9Bg4mX3EFLhWFujJ/Z227tnvUr3YYl95EIBTtu1ozOBoSf1pNMaumFn7F3kSpELyqSL9oZf8C8SijNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZW4tCVnuhb1kX4elKayY4342q/anXKXqJPpnSwqn0s=;
 b=oOAzZCa2W6oOFdsOtt7rMPe7jyRxijRZTifmbpvZg+QujYQR6Sb8NPWSg/W9GTYAEXLDAetNo0nAq3gSEqnftDmDeTceRxK8wGKMqzbKs7dy6Wm0SvvSdSp/MUQN3wTFb4hFYFPCjFSPNjbqFQvFqjnpApSTrUyHulYGnEHGfKSIyrV6Ib8GpXFMWkHibmWIPeLljgLBoBN7iVx/UAv+P/O0APsQ68rSmhORU+ugxAJNoHkyeNPg6u670P5pMm6HDDVyjcENGyrDNFuounkD13vDDQGRyPaWzVmwJJJVeNhU1F5HsANEMNgD1kcHNQtuzybRF8Wlxa4MQtQCUZ9zbA==
Received: from DS7P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:223::8) by
 CH1PPFD8936FA16.namprd12.prod.outlook.com (2603:10b6:61f:fc00::624) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 9 May
 2025 12:35:47 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:8:223:cafe::4e) by DS7P220CA0016.outlook.office365.com
 (2603:10b6:8:223::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Fri,
 9 May 2025 12:35:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 12:35:47 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 9 May 2025
 05:35:34 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 9 May 2025 05:35:34 -0700
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14
 via Frontend Transport; Fri, 9 May 2025 05:35:29 -0700
From: Vishwaroop A <va@nvidia.com>
To: <krzk@kernel.org>, <broonie@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
	<kyarlagadda@nvidia.com>, <smangipudi@nvidia.com>, <bgriffis@nvidia.com>,
	<linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Vishwaroop A <va@nvidia.com>
Subject: [PATCH v3] dt-bindings: spi: tegra: Document IOMMU property for Tegra234 QSPI
Date: Fri, 9 May 2025 12:35:20 +0000
Message-ID: <20250509123521.3471650-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|CH1PPFD8936FA16:EE_
X-MS-Office365-Filtering-Correlation-Id: da4581a4-5de1-40fb-ee77-08dd8ef60642
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZkYeii7ZhdRrgIS9JKnVQJx17fzD1lbvpxl0E3FvruqhPvrHtiXA4e94sosU?=
 =?us-ascii?Q?nOaAdK66GWEoNyMMhVEEamBIkXVIb/WHqrn9/IULEZd+JoeMKUztaDiJkF+1?=
 =?us-ascii?Q?7zqK1uh/eA2Da6DzvHB7ImjlntGpi7YQtMqMnAxI+DcwcrvJaDLD3a0HsyPH?=
 =?us-ascii?Q?FpFH7BzokZcNm/6AXniO875yKI9rsis6O1Lo+9b4phYl00KWY8G6zu/9Er+8?=
 =?us-ascii?Q?dplkIQUGsrx0LfTKNN2eWkdui9CCmP8S7KciOFxuoe5Nyq3A/Nhba0rkD+s/?=
 =?us-ascii?Q?Iylqcde/X/t8vYbJLuZ+BRPmdikHBjDjegj24SwD2OWAsvygRkibLlLIQHTU?=
 =?us-ascii?Q?oyJoVdt2CUDq/6uxQkkaJFYp1eo90ORNaVQgVpaKd4Dyvb2OeAih2/AfZgVN?=
 =?us-ascii?Q?GdNmFV3t0eDPmqAKyuLlBNqeGytG9W8KAy9v50L2stsjBHxL6k+jJzcS2p4V?=
 =?us-ascii?Q?nm319v/7GsjiP2WNgDLhrcBhugFvWcRbmtVaxI7KyXioLtTIkj79RjND7X+Z?=
 =?us-ascii?Q?R2T92gS4ghfJuQNLA4TF/ZSGxNnrwaFfmlyg9IOoNq8w6S/+8veUtX+wWUZi?=
 =?us-ascii?Q?mSTRynUelOLav48997nt6cNVzPmgo8abN42XIdZ38HvUAgCWaNvZem/3898s?=
 =?us-ascii?Q?VgqIyhrcUTQitpNnPVkyws1zziBR+FAPhCY0gVDwbUr6M7fdXR54BwwkT0qp?=
 =?us-ascii?Q?6QvyVr0fNNlJi7YjAXV6w5WOtj7Rj3zLeCYgkXwk1k8COqbN3gnWgEKpbMSb?=
 =?us-ascii?Q?MafvVPIhNC5BNzYkHSdNC8UJ45xH5R/qXtAbcZ3g6+3BqIjlhguBZbhZK6WI?=
 =?us-ascii?Q?b51qN+ADouEhiuf9Sc+KXFFv27lkVggwq14Sqq+GDxct82qd5mxg/T167i23?=
 =?us-ascii?Q?V36kFRGpzmZ1xS1BKwtVDzOoOzjCvOqEfChmZrL5zNFQFmVxmBPb4KfO4G4N?=
 =?us-ascii?Q?fwQn7Wi9PaS39+HiU0LIZhhOjwj4HYuPKnNB0sVvnUTzxf/i84RSZWvyBffz?=
 =?us-ascii?Q?3zwnmIF1GwPM94cJRI+c9ndag1vKCHPay/ncjPgU+K3zn44eksh+COVFMR7m?=
 =?us-ascii?Q?ZEgrhwSSawZMg2PNnSqZKclsJuHL2repTtpEAuSaAhAH1xhiCRx1Y2QAIBFC?=
 =?us-ascii?Q?xaXdZC5QQ/4oKSXCTNdq5KdG1bOK3M569zVdbN4P2KDyZGWaW1+34en3Lg8V?=
 =?us-ascii?Q?eb0m/Dy8TjWjLv5jXatTHGVcmqXmUGvI9vQNPBPKl5Z2bqjtbgRzacFsAjFQ?=
 =?us-ascii?Q?WzqQGh7mHngYHgslR+t3/OCGHxQfxul/yGeJI21avR+yFvW58h0zYCG8yb6h?=
 =?us-ascii?Q?SabZ6mQWBmXSwdMy9Dntt16qIq9CpXpKXRl8GyISgML4EdSt24Dn6Q2hwfHH?=
 =?us-ascii?Q?3nf68gyaQY933UNXAW1McrJ3y8RGxenDANslGbvv5oM+kAK8mSrN++DSps9m?=
 =?us-ascii?Q?kFzIaheuuk0HLEhEG/58XSnzhrjoH/IxmxcdImz466CEMLBOEX7L2GE5IPDv?=
 =?us-ascii?Q?vqHn/ACNuyNe7ZE3E91UzkB9c17Iwei3uW/buFSRt0XoVB0nX/etvBVWRg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 12:35:47.3655
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da4581a4-5de1-40fb-ee77-08dd8ef60642
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFD8936FA16

Add the 'iommus' property to the Tegra QSPI device tree binding.
The property is needed for Tegra234 when using the internal DMA
controller, and is not supported on other Tegra chips, as DMA is
handled by an external controller.

Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 .../bindings/spi/nvidia,tegra210-quad.yaml    | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

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


