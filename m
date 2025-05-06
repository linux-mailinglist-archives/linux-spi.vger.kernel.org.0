Return-Path: <linux-spi+bounces-7934-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87936AACC9E
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 19:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E07D5508156
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 17:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F70F283C9C;
	Tue,  6 May 2025 17:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rax7Qpcd"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701371E47AD;
	Tue,  6 May 2025 17:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746554326; cv=fail; b=GywawXHhGSLzCZhl4M76rbQJ2EUFh7nzs/4Vlert3VVPRvso/8jKOBIbpM/hXEbiUduksYN75C9kWy1x9hMXhkxhVh5yEUeLszukrZckq4+44rrjqUZjxflgYkqchOJfWfit5nLnJs5VZQNmTScjdypUMyYzwBUlv+mPCzwGleI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746554326; c=relaxed/simple;
	bh=R95xrxTj9CRGKgG06XoOSS0+3kee1B2r4jO9genPWzU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OrJuQkVXRKhatjH/YS7YsncKq7rFNY+y3IiI8Tn2OkXAjRuSdqU6vB/guXIALAWy5sROYg/0j8oVziS9Ej29svqR7knNx0HJcIMUjwmp9fOAYMWjAhiKAe8wiN4iSD57rV/wh1rnkDDH6XfNztJga1FG1B3od+JpC8dKM61yb+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rax7Qpcd; arc=fail smtp.client-ip=40.107.220.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zRNk/guAepssF6hc5ymtidVU27zPcbhNJy02ctyIlNV2xTocrRUKevBorK2W/yiqWZUfAx0aP1pqwivTrp38viusIruJWVnlmuEJQekXK6+RghW2caLXKnjTDyonrpdqRt3wl/zREZcbjWFNUloDaFN7I7dnvHgSKAdGA+fyXzyk80P91P0+3L5e4xofU8dBPPMTOquGEKyet18XcHqnl/AOEaR+dTbZ04NlynIDRH3lRiGjTCgj0jcI63SMSnEfN9Q23T5Q9q4nkrGAfsda9Qjq6i0eL7bFjZ1mQhNraS8bU2jr/YDSBKGStB+bhCisf8XzsvtW8rPSdmSyUBMjYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kR7jynHvJWxUC8QWHKkslzfEfHZHpq5SfD/TYcqYqAc=;
 b=X5rvHlEMgqllr/2++dg9HzwYqiR9oQCGi5F7nUymIraas9amWczMVMSlh5RuUVvi9K53JIYMZ1dhdSJFh+XMarVedHhYEBCcV9BUNnuUyLW1d9Xo36UsoH8zLHnU6WclwqGOkOU1NDfiwN3kHDEdoonoxoajONfXXx/XX6jO+bOahG8hf3bltzkj3FOwWGftKmz4O151RSyTawy+gi4vZu00lEn+ncWeX5hsw6XlkR6ibzgx2s4LLFzPmK1Pe06rZ/M1wy01bbTNBRFK+kZlGfrMinb5A9yf1u/2EN5ZfibzDqdMyb6aMV8sn7lcQQ30I2Nc7cblZWeUCUUQ9y5YxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kR7jynHvJWxUC8QWHKkslzfEfHZHpq5SfD/TYcqYqAc=;
 b=rax7QpcdqSTaMijGB3JUIiqTDRXnCIpiMJK/gYM8C+c0ut6d0tS7iyE0Iwbeubdr4G/12hQIoK1ECLTVU3yliwIdmkNcRbVikHHQhJWyHUcgXsjxk6nT9Eon9BYA/AMClOuMnvDenDnKZjJLq+g/e3874mWxgJ/bDtbav5NT5CgKlQLwMElfWnpfuXUZxwjpVexbLm3GVHp6ffb4FDkXGVW3EcT8jo7FHhnTIGbzfEhfRPepg5tmw16LCxgl3OlJ3ars9tull9JuWfIyx47/Xu6j5qYxMkLNmetOBjSPOLDH4xa9J26lEHEh7LN2zKicV2bY9eaAeplxj6rZPHeMsA==
Received: from BN9PR03CA0385.namprd03.prod.outlook.com (2603:10b6:408:f7::30)
 by DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.21; Tue, 6 May 2025 17:58:36 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:f7:cafe::81) by BN9PR03CA0385.outlook.office365.com
 (2603:10b6:408:f7::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.29 via Frontend Transport; Tue,
 6 May 2025 17:58:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.3 via Frontend Transport; Tue, 6 May 2025 17:58:36 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 May 2025
 10:58:21 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 10:58:23 -0700
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14
 via Frontend Transport; Tue, 6 May 2025 10:58:18 -0700
From: Vishwaroop A <va@nvidia.com>
To: <va@nvidia.com>, <krzk@kernel.org>, <broonie@kernel.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <skomatineni@nvidia.com>,
	<ldewangan@nvidia.com>, <kyarlagadda@nvidia.com>, <smangipudi@nvidia.com>,
	<linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] dt-bindings: spi: nvidia,tegra210-quad: Add IOMMU property for Tegra234
Date: Tue, 6 May 2025 17:58:13 +0000
Message-ID: <20250506175813.3429319-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|DS0PR12MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: 94d133e7-2386-4ebd-3ee7-08dd8cc79fbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|1800799024|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3EfwCOHzc+phCsCRt32AguzpDZ4Gv1XQaDmRPx155qkK+qWezXfCfII7LhA7?=
 =?us-ascii?Q?z1co12viKZPDAjkK26gHb+F9uv0HPm1OJyo4dtItRa07eaHNuBB3jQQt4NU2?=
 =?us-ascii?Q?rv041Y08xl+oh94Ph+ZFH7Eupf9FpldJDhgf4WIElB8EVwjB0eSmdAA8fZ5M?=
 =?us-ascii?Q?lzV8/UHdp27mgFA5FxjwNUBbYJL7F+oDqczUbzXgj5U5IxAwhQgsTTaH0ywU?=
 =?us-ascii?Q?DN16KA+clVbj+KJQSk8BxYdjguKireeQ9s2AcakHBRloCg1C0/npmFlCCWcY?=
 =?us-ascii?Q?9ADI6Unse+xwIgHrya6Cyzfw1ICFlMiBr4wmQQ/pVkDoTIDEMSMFHQBJd94u?=
 =?us-ascii?Q?dFS5YVq5EFIStXYtGUhfeGExoHj3TU5fAW0B2qL++4KkfZa00KaNpgPc7uE5?=
 =?us-ascii?Q?MQIjZbRm3cEzFTyiwg7s98vh+a+Rm85Bi+aHP6t0QSKCIzUHfuB35NleTY83?=
 =?us-ascii?Q?XMffuR6Mk+dDAg+kZX/1I2Z1ywI69GSwS4ftOerbVjUJu8kykd13v7Re2v7U?=
 =?us-ascii?Q?yhh1rAl1Pw3vYhgTmzCaaiGxBFhug0H85L8qipwSKL783gv+s9VvS/8yCDNF?=
 =?us-ascii?Q?O0t65q9oL3qZXHNIf5uk8EQbwHVelAzt8/erw5RP/2p9CllBMZ70bWqksfyh?=
 =?us-ascii?Q?sNTV7FSzbEfV0zlShp7xVIzDtNfuq75DOjLaYQN8M2XnBOV4/XGHloTToxKs?=
 =?us-ascii?Q?YUtY0UCFG/aYQLHa7UzDbCOLA6GIgvwqlgd/3gv3LpnCCVI96HjVbHbU95Qb?=
 =?us-ascii?Q?kWMQnrQ4h6h6wmhdeiqd2uP48olF0hWYzR1Iw0VznBFId+Ilj8on30ZsImzK?=
 =?us-ascii?Q?t6p/xnObAd/d2qFPAli1eQx9JDC4tP0w6pYR2ZnbcR8S5V5/Ye3Ok7q+cDVn?=
 =?us-ascii?Q?Y4pcspL8UcdomG0d6oNOpGgkqkA6erS5oxqIpVtxZOS5Y3jR12Iur+r0qsji?=
 =?us-ascii?Q?9xlbHDZIW1dpccbKpOdeTe1CCfwgpiOeuJeqhLy8K6fraJz5HhyB1/JrT/3n?=
 =?us-ascii?Q?dX2uiWvhTvKTgaFgul7NL+jnoEza1ZnclGAEv/GBKNNCWK8Y6XWVjF20j4iA?=
 =?us-ascii?Q?YPwFCdNntVKBWL8YjS7cBD1Sb4MBix2bcuv0yWlJJ3Uk0I+ocoUssVf3hgb8?=
 =?us-ascii?Q?EP4YUqtUi90VHeDAfTojwqH/zRTFjBAxLsdLnLgjUN0MEVKMswHCJpA7SBlH?=
 =?us-ascii?Q?S/5sPiAXxeQfc9jDcgaaMXHk3VDGRQMMKOe+Qh5EFDimGu9BY85k11djpswl?=
 =?us-ascii?Q?B68lQ1qNfIlbgoGi1z8M1FtNJvHEU03vAPYKPgtXw/rE88Fl85KaxE78kaAZ?=
 =?us-ascii?Q?hFfmDkjTlAmS1glVwOhXDDzVOO0C8Hn7i4DAhOf0BAyhq7x9xkcJJBKHmvUm?=
 =?us-ascii?Q?+Y7HAmiX0QelNHl20XhhUfUwviqS2jsQ5ZBy3hQtqL21URVVv0XVsHF4Z5rw?=
 =?us-ascii?Q?DwlQjTbS1XBz1HXSv7QUnWvcFR7I73XugmXe5EXdtgSpE7lblc/NnlzZDYhM?=
 =?us-ascii?Q?uK5DEDF9ZstklPH9MM/O88T+9mttZjWgokgfRC8cPSkKGmaAa6X4pPkR6w?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(1800799024)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 17:58:36.1006
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d133e7-2386-4ebd-3ee7-08dd8cc79fbf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6390

The Tegra210 Quad SPI controller uses internal DMA engines to efficiently transfer data between system memory and the SPI bus. On Tegra234 platform, DMA transactions must be properly mapped and protected through IOMMU to ensure system security and functional correctness. Tegra241 uses external DMA and doesn't require IOMMU.

Add the iommus property to the device tree binding, making it required only for Tegra234 platform while explicitly disallowing it for other platforms including Tegra241.

Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 .../bindings/spi/nvidia,tegra210-quad.yaml    | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
index 48e97e240265..ac79cb19c81a 100644
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
@@ -12,6 +12,25 @@ maintainers:
 
 allOf:
   - $ref: spi-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          enum:
+            - nvidia,tegra234-qspi
+    then:
+      required:
+        - iommus
+  - if:
+      properties:
+        compatible:
+          enum:
+            - nvidia,tegra210-qspi
+            - nvidia,tegra186-qspi
+            - nvidia,tegra194-qspi
+            - nvidia,tegra241-qspi
+    then:
+      properties:
+        iommus: false
 
 properties:
   compatible:
@@ -47,6 +66,9 @@ properties:
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


