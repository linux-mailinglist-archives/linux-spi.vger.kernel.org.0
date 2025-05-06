Return-Path: <linux-spi+bounces-7935-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0396AACCD6
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 20:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFDA51C08450
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 18:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AE92853F6;
	Tue,  6 May 2025 18:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lwplb6Bl"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B1925B69F;
	Tue,  6 May 2025 18:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746554962; cv=fail; b=iPOReTls4VU+45K/JZg8tVgfxAPcwMJhnzqTNS2fLmkXVA0us4y4aPEDGV1xm0SmKGq18eFORsD3jX+7Fq+PG0ouzSCemXoQd6da7pTTulJMgt+IdCNvGBG3LqMkkrOdyARJ0XVHkE5K6W7aGm1N7SMYAcZT+dBl6w8JEiVaZbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746554962; c=relaxed/simple;
	bh=iItjvNquXtgRer3P2NKU8cF5p42nYMfSAVo3b5V8slQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K7CBbgKDLPdYHB9BBmiWTc/h6UQIE/ufZBDaUgsvJFl2PMBTFLIkV/ldGPDi+RvE7URlO6Zwa38OmvA/1/3/FpvUx1tjYZtWDgq+Tjb7M/1mPQlKKqabz+FxvBRIVSWP2RfmDQSat0U0DVdt7lK8lUy4P2ZeJqComx+/nH//AU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lwplb6Bl; arc=fail smtp.client-ip=40.107.94.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqpytC6vbwGp0ysZz/NIN7M6KI2Trtd/nHdiD5yK4qLG5dahAvetbXcBciGIa0h4kW95JyBpXw9PWzH1suwrSG5NrvXGQurXNnJyKlu4y5G3jakQq9oS/SuXl+TtMl4SDqxFFdv3aSveuEcIVWPBAI4M92VtSKE2k+v/L0/jQNB6JTNfpMcmpSEuf2KWjRis02oe0CusqYmEJwjJZ/jUj2xqppKna1p1O715aogWomUSBmK0Xu8fclUETq1vL7/vZr3/325XUKiTusbIIgmpA25X07vqeUf+OfDGW4w5sSJKcC2+sMJLdggqhuqid7W+CLDnoW0vj09M2MqdHbtZ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9c1FtcDX2jnUH1kun/NKMVvpBjV+0+0YIWmvzFxfew=;
 b=nC+2dEV2JpuWM+NxqxjW2nE9LyD+adouMwURe9167VCooThjV9lce3MSZSfPXG3t2M5QsjESKvHB76KuXer57SAEmtPw5FMuN5Tt605wntOqxR484C8iD3Utfg862XhBe8BugWGbaqNL2qfgpgX4r8rk8SPTVpxqi0pf+C0B7ulWnao4GD8SmiGBqsJlXH5HpAxEscJxKjJlohDOu63Dec6hBQaIFf0+1Ni/k88YRbMc0oSOCMhDJHXKaVLbat8CnVJbP4JucijN144KY8KxZ92Qzq7r1lddcjpr9qmAKmwSlPBJevSrj/egR5Fz14/xuxY5vYKCn0I4NvdVYxwXzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9c1FtcDX2jnUH1kun/NKMVvpBjV+0+0YIWmvzFxfew=;
 b=lwplb6BlkUq6f/S+/AJ360EVr2OzPQ33HarlN4jSjm6Zwkk/DJ5kuiAqPZTWASxdFw+q73GCvix5XTjdPz0EHwuJ++PELRkqnJ5YpmDFPEArlwhPg+024+dEhHiFiK6+ptsBYnVJmIa+9M0e6TEGg/hlh+uZWJOSXxU5oA9/XAbigaA1ZHkk/lt0uXkH+bgyYnekVzChtBh+6Vco12lYryH2i/FIi0x8QffY6R7yA662o3AVFcsHEuT4riY5rRjduaFW8z3ZVYL1rCvWMIGIBymr8pfs1q58BLQFU2cRY09bcbPtJHK8QQY2tElOxg0Tv/NJpxrM+DDtv/yR4CHJIw==
Received: from CH0PR04CA0107.namprd04.prod.outlook.com (2603:10b6:610:75::22)
 by CY5PR12MB6300.namprd12.prod.outlook.com (2603:10b6:930:f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Tue, 6 May
 2025 18:09:11 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::e1) by CH0PR04CA0107.outlook.office365.com
 (2603:10b6:610:75::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Tue,
 6 May 2025 18:09:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 18:09:11 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 May 2025
 11:09:02 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 6 May
 2025 11:08:53 -0700
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.14 via
 Frontend Transport; Tue, 6 May 2025 11:08:49 -0700
From: Vishwaroop A <va@nvidia.com>
To: <va@nvidia.com>, <krzk@kernel.org>, <broonie@kernel.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <skomatineni@nvidia.com>,
	<ldewangan@nvidia.com>, <kyarlagadda@nvidia.com>, <smangipudi@nvidia.com>,
	<linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] dt-bindings: spi: nvidia,tegra210-quad: Add IOMMU property for Tegra234
Date: Tue, 6 May 2025 18:08:48 +0000
Message-ID: <20250506180848.3430191-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|CY5PR12MB6300:EE_
X-MS-Office365-Filtering-Correlation-Id: 09707a4c-5d33-4077-e8eb-08dd8cc91a3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I2KgJw8WhrFyWo/08DxLsXXscmEjEXRVPzJ5rDSfcVHc+uG66R9BpBM8h4A9?=
 =?us-ascii?Q?CLzHnAknGuWi6mfoId+6+qHLTTQ2vpezi9gQXIeLQxOXaQwQ/0q82KywbckT?=
 =?us-ascii?Q?aflnDmpU7tCMFrTYuww1jIgAJDHqr8H83VtbqsvhAArjOCScSc6+TJkqMe1o?=
 =?us-ascii?Q?1SHT9oSiQtVNZAf8yMvjCYAwQOa4AO+Hyqq1OE0TKuyr+P79Xggyclm4bDED?=
 =?us-ascii?Q?Bs1TK/CpGGa6lGCCI4yxInDvw83bZBJpYVG3Y/FQnCHpnbgS1KBPe+y6Rzqw?=
 =?us-ascii?Q?95fW3HtnJ/3+xyLbLyZfvKhxSeVaUX7UzUn5S6IVSNdq9V9V4GolTgqPmmal?=
 =?us-ascii?Q?qwPXBF3SW0cImxpfqVi1grSNWBjt75tcTwALX6S30ZyXRw+nj4heg3CYFhZK?=
 =?us-ascii?Q?ih7/voUOGmqmElWcgslNkrWnhWlqSJCLewzoUd5mpukBDI+E1iIv4v8vvchs?=
 =?us-ascii?Q?nxRTDtvopMiFjMOShyl1SeLcnDPIOZka4M3zksWYrvCZ4JmTJ/FnJR1wZ+/Q?=
 =?us-ascii?Q?vnUjUzNtcjE4Jy3MvX2a9dvcue/txm17jB1tFgdhuc4sYbfvLm9ykfBRjzxh?=
 =?us-ascii?Q?ic9MZqwjjdSQfRwAynPeNiXSAUgXdjG6dV21jzaXqJ2Kbf1PBn1/3WFsIbfI?=
 =?us-ascii?Q?kJkBczb2Htey36ew290ehlWKDNu4X89zwIDlzYDF1MPzC1LboZ+CmzoT/Grs?=
 =?us-ascii?Q?S11D1Si2xwtoq3/R6WQg46zK89tQehckrePNoX/xs0Z3XADJMz+eJkW6lNpi?=
 =?us-ascii?Q?0qOeeZJ9jaAlsr7UgSv4oKEGeuMyKyeGMvIxY2F7ubYq1RaiKXQ1fDlk1Ksh?=
 =?us-ascii?Q?D1IHMqNYeyGU33CydKCvttYwpi1hDNJWAWxHHeWclJUEaeTTE9IOnaFe+yIR?=
 =?us-ascii?Q?U5CxMtWrbNrl/d7Fuq069sPA4NO9wVzCxE0wkZbqsr9vhIDCgM26Bw1ewhIt?=
 =?us-ascii?Q?NSc1DDg3EiPtw85GnpU+rZuZCyFVtZpL5VrYb2kZrEggALfafW2lQtDIwGma?=
 =?us-ascii?Q?1oOCUN4HRjkw63Mh2JWLzXlJ+tf02US9BWsXt2O+oxfFYprEkTOeztrnFPLG?=
 =?us-ascii?Q?Z5azYaw0L6lripFm3k8mifa+Oh25bd87+FVeCKHfWSCVo6ehXPsgfsYUaFgf?=
 =?us-ascii?Q?t+MFCECkDwPIBYn8Rddb7dPtC6tAy4Pn5ykSduPBNEWZcmdCEJGBz/OKN9rw?=
 =?us-ascii?Q?702c8PAEIgOwPRySSbjqrHOCBTMOGapLGHE/I9h3MMTvGmX1zDA2LRXTgAQV?=
 =?us-ascii?Q?nQmt9LaalPmtR0qqtx1SlbLF+Nt7E+RPTLYQPMfO7yZxBsbi0gqwcEBB3GSt?=
 =?us-ascii?Q?afR84gh3ERcZUj18+Ffcg+XLvwBOUZr6Wl8jp8oVLje/AbjSVniRah6h4Gbj?=
 =?us-ascii?Q?v6PRG1KgFFWdWcNkHheYukmfOHcfiOJfjzDq4yUEF32NXHWdx37amzdUGAS+?=
 =?us-ascii?Q?h6FsUyPKJUrkDzmb2a9UENtjHBBwuMZ1IKP2gj7Hv2wniOyxuivW7okzjWuj?=
 =?us-ascii?Q?3FmTuDitJ0QnWKcsybiokuUKUzgdP7zgRQ9PBxRmticuLJ/OG63hc0SfUA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 18:09:11.1351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09707a4c-5d33-4077-e8eb-08dd8cc91a3b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6300

The Tegra210 Quad SPI controller uses internal DMA engines to efficiently
transfer data between system memory and the SPI bus. On Tegra234 platform,
DMA transactions must be properly mapped and protected through IOMMU to
ensure system security and functional correctness. Tegra241 uses external
DMA and doesn't require IOMMU.

Add the iommus property to the device tree binding, making it required
only for Tegra234 platform while explicitly disallowing it for other
platforms including Tegra241.

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


