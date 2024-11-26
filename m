Return-Path: <linux-spi+bounces-5842-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F6C9D98C7
	for <lists+linux-spi@lfdr.de>; Tue, 26 Nov 2024 14:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC98CB230E0
	for <lists+linux-spi@lfdr.de>; Tue, 26 Nov 2024 13:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6F31CEAC7;
	Tue, 26 Nov 2024 13:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FrcMeZmB"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9A9DDCD;
	Tue, 26 Nov 2024 13:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732628769; cv=fail; b=U35zbZBTrv1j60RwB6q2g1OWCgNzvlVgXV246eFwaTgzWhku3f/veMP1RVmxde20Pp3I6k+oZFqiLqyCgcLk9tRiijTnaaIk0ck6hsEASQASoYMympZaRlUOnyy0S/qMwd6CvrnRWdqSQUi9U+EL3QTsZEcfEQN8Flb5jPq4Ryk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732628769; c=relaxed/simple;
	bh=SymsoerT6kSdRFpTXz03VPOOfl1WVCvIHhQwZbg4ODc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JJcAOHJNIg9yEWNk30lXV+dp3gJwIf4l5YdrN5ckzM6EnYHZ6ZDe3jpVpweG9tajFcjZt8H+KpAboGRll3tFMRvAPcXyc5zgigzQPqXfYWilg88laQGZ0DiavVu9CoFRwc0WWbIYi0Lkg939TXfmXq7ZhsgRFwP9lDsD4VuvRJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FrcMeZmB; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OptA8nnztIw/475PXeojIwfwXPHnLbiLGU11go0yzZxJvMZKD1zdLLuKlnjpFCEhgzqo15fwocdeQmuLMsZenS484V9IkDRveYet3ZxZD1Jak59rajRDKQ3qLVXCEjTmPE8rjt4pFrxkzkJPS4L0oi94ZK1ypK5SWR45S1+qn6tE0y/BZ5NIxheBNKBHCeBAdvAo/biYGn2ow/s7F4M7/h1xWCJhZnjcO8Aow4IYbWTb7vwsCE7O0TeamSpOIDcAiUgIHh1V/58+npjZq+h85ekB452RMdiYb1KM8fTT2avatve0cm3tIe2CVNiZvb41d2+0OyXnE8RVgwZcmrEXdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+U49Y15N7fngAn2RKBj7A2T7WBniWdIaB8mQH5UYrNg=;
 b=UyTZUdGDDXxtVLJTWW1oUJwabWrIjf8xHhYAEr6BR5Go10wQuuoBkaEnwbw3zyC0AxBKX1huLLUaVlIQUMIuOGxTAjDVfN0FrAStS+91kfYppfFeozaiXe+fbuVkxahflOFj6W3hl5mezFHWl5UbI0NwQSqRJigW49I5Iy+wWiNswo815tIoj7gj3XR63JRQIEZJtnZ3BB4phz97jecOD/YIVmpUVk3nc55of3z4o4qPVQjmlK6/O8oW4/4f1l/1Pp8/YrVJtK4MM7bk4vMsUqJZ1k4D3/S7KnWLd6JpCz90KFtGRZkZ8TatjZldxtFZpJh5pV32r/3oKrT4uSzPiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+U49Y15N7fngAn2RKBj7A2T7WBniWdIaB8mQH5UYrNg=;
 b=FrcMeZmBupJgirtLpNak5sgCryw9uP5wO1s+4m4XBNrjAfbwdibeVkwe2gs/vvdMSGC9GSgZLJDalMSBksvjrbS6apXZe3eaqr0lwOEd17Z30y1++dRi5/ppjLjXfwbYHfj7CuxoMJx75L1HmdPSBUe1Fr3+P7SN8zOr3zbC8dbpp3gU5rN2D/S9GVbg/efiAX0DYUJmAy0LR9yff5flxYKb883e0kMok4OaDm7TMUUjgLk2O4amaLmRljtkfA1uw4faNYBd3UMi8pN633N5ebjsO6bANgrcG1qm3GC0UlCXWf+ehHI8XDWTX0ZB5biAiWkhXL9LnEX0BYzI3f4SAw==
Received: from MW4PR04CA0138.namprd04.prod.outlook.com (2603:10b6:303:84::23)
 by SA1PR12MB9515.namprd12.prod.outlook.com (2603:10b6:806:45a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Tue, 26 Nov
 2024 13:46:02 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:303:84:cafe::97) by MW4PR04CA0138.outlook.office365.com
 (2603:10b6:303:84::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8158.25 via Frontend Transport; Tue,
 26 Nov 2024 13:46:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.12 via Frontend Transport; Tue, 26 Nov 2024 13:46:01 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 26 Nov
 2024 05:45:47 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 26 Nov
 2024 05:45:47 -0800
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via
 Frontend Transport; Tue, 26 Nov 2024 05:45:43 -0800
From: Vishwaroop A <va@nvidia.com>
To: <robh@kernel.org>, <jonathanh@nvidia.com>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <broonie@kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-spi@vger.kernel.org>
CC: Vishwaroop A <va@nvidia.com>
Subject: [PATCH 1/3] arm64: tegra: Add spidev nodes for SPI controllers
Date: Tue, 26 Nov 2024 13:45:27 +0000
Message-ID: <20241126134529.936451-2-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241126134529.936451-1-va@nvidia.com>
References: <20241126134529.936451-1-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|SA1PR12MB9515:EE_
X-MS-Office365-Filtering-Correlation-Id: 122d5784-99bc-47a6-bb31-08dd0e20aaa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GhQpLUEdNWhWLZaxpN80pCE86+ZTjDg3UP62gW6fihxMh/IQGUT9xA/xhaW3?=
 =?us-ascii?Q?eJ/94shPzmtKx9DGzx7qlpb0uQpGapFx+GIR48SPelmMv7v/dK0+9GRwGKwJ?=
 =?us-ascii?Q?zZNYZSrAVvhOeCSr4G7NsP77yeX36SpW72o2ddXDo0ESQTRroJkdpu/SdLtj?=
 =?us-ascii?Q?6O2tlMfdlZuCBySRexs7Znvi63Lb06kwGUeqgmKJhKVgHKP0P8gwl02n+a2v?=
 =?us-ascii?Q?AYYtTQwNy31PHsuXkoX/siWLr8qZOsdB/L3tBeIC2OT2ACWMbamT+H8aT41F?=
 =?us-ascii?Q?Z5/nPiUi+ikzftAAJ8xrzFCiOO1uSp0ygxPgL6ff7p9yVlKjZGqZoCPGCQ8q?=
 =?us-ascii?Q?xPeEYkjq5PGY+grpBzdiWK7YWQ5Fw61jgVypDSRSdC1vwNce2SFHHrKNViME?=
 =?us-ascii?Q?pHkDoRXr2zAynWUujdgqmsVHa2UyM7FJ6dEHubKJeb/yNKT9L3JybMUuVUJ+?=
 =?us-ascii?Q?l6D3CQDSyEymk8NuqoyI9GE0DctzQbQn4MfcI4Yozv9SvfBlLzdeipb1GhAH?=
 =?us-ascii?Q?ok5h1b8pQzEU9HpSDLzX4Ko3UDTOdsgUgf6F/d4hAdG5To099o/kSyuWUMTK?=
 =?us-ascii?Q?xbKd6BBQkg1IQzPxH6FZ9XS2t+NRI0WxZAD/aa6pqcyN1DbSRZwwN7pDMKdi?=
 =?us-ascii?Q?ssbt4h/t8Rhg2UBkrc05NOh2dRnKqbpRwng8WI7SkNQfOk9ZfGMDboUIMg4J?=
 =?us-ascii?Q?e2XeJhDq/pJJyLhqfAAEZnH9BDXLFqxHMxAb7J0Nb/Tln86V80bVTENYarMW?=
 =?us-ascii?Q?VZAkm1JEoFlPqWgrdpxVw6DgKLKDXfGSuA6lfMqZZ2JvgW0owW4jruyJhtUQ?=
 =?us-ascii?Q?BsS+cxQ5G7baQLC82xh9sEpXxfAvJUXZEqt/2fX3iYS50PXuPVuxztvH4VK2?=
 =?us-ascii?Q?NyOdDXi8IBkeImKtreX+mru5TcbWHhWNZaWDUlBK0/SQXr2QJcfS4tqeafHo?=
 =?us-ascii?Q?hvPMMSik61owWPQysUsHXz7VtTlFuCU4xQml5vFsjF1rUARSf9ljV9vPgynq?=
 =?us-ascii?Q?CJ/S8CTNFWiWl5ziZF0cpKQSxqMexka1iQfxGVOzCGcex9Nuc1Ev9Xe3qYvi?=
 =?us-ascii?Q?MsSw2W7jSxedT3Ic5+7o+eTvSBQmjL94lEK1Mv8cyvoNi0+kmUaCNumFw5T+?=
 =?us-ascii?Q?D3fLNSBjr28w+6A66/PEGQc2yBfYu7YfEg+n3zwKoFYgOdCQ3frJ33eOUY3k?=
 =?us-ascii?Q?A/gbF8jRNWIHXsyt/qygw29lQG1kCAEmGG0P6JFmTjdXSpxx1O4P51cByFVI?=
 =?us-ascii?Q?/tzOU+cZ8TvhperVEo4vjZCyG4JoLCmAzl8TIp32IAzQvFQuv49h/wfqpL3/?=
 =?us-ascii?Q?WGUNv+Rx/pv88aqekBqUvoUXaqhLzG/Fv84YfeXEd2s4LEXsR0K4a2FU1Q9g?=
 =?us-ascii?Q?Uv++tWC2DPlBntfNN1fVAYcDyPwA6lkaxL+cghB35KYoH00nwZ3imZ3A/ejJ?=
 =?us-ascii?Q?ygDPai2A6YMyaRHHF5z3rI2gOWdNP+u5ZCC/rWs6xI7jYrxzH9V4Tg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 13:46:01.9852
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 122d5784-99bc-47a6-bb31-08dd0e20aaa1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9515

Add spidev nodes to two existing SPI controllers on the
NVIDIA Tegra234 SoC. These additions enable user-space
SPI device support for testing and development purposes.
Specifies a maximum frequency of 81MHz for each spidev node.

The 81MHz maximum frequency is defined to ensure stable operation
while allowing for high-speed SPI communication. This frequency
can be adjusted based on specific hardware capabilities and
requirements.

Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 .../dts/nvidia/tegra234-p3737-0000+p3701.dtsi | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701.dtsi b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701.dtsi
index f6cad29355e6..17de3d0feb45 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701.dtsi
@@ -84,6 +84,34 @@
 			};
 		};
 
+		spi@3210000 {
+			status = "okay";
+			spi@0 {
+				compatible = "nvidia,tegra-spidev";
+				reg = <0x0>;
+				spi-max-frequency = <81000000>;
+			};
+			spi@1 {
+				compatible = "nvidia,tegra-spidev";
+				reg = <0x1>;
+				spi-max-frequency = <81000000>;
+			};
+		};
+
+		spi@3230000 {
+			status = "okay";
+			spi@0 {
+				compatible = "nvidia,tegra-spidev";
+				reg = <0x0>;
+				spi-max-frequency = <81000000>;
+			};
+			spi@1 {
+				compatible = "nvidia,tegra-spidev";
+				reg = <0x1>;
+				spi-max-frequency = <81000000>;
+			};
+		};
+
 		pwm@3280000 {
 			status = "okay";
 		};
-- 
2.17.1


