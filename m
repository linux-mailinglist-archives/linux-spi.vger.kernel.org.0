Return-Path: <linux-spi+bounces-11532-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A68C86C1E
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 20:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 496DE3535EC
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 19:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B80333732;
	Tue, 25 Nov 2025 19:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="QSQ1YYfW"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023132.outbound.protection.outlook.com [52.101.72.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEDE333453;
	Tue, 25 Nov 2025 19:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764098218; cv=fail; b=iVCD/g67jcRPH+5wbjZenACYPfOUAFF0rxEH0XXMiS9JGtqFwrIKvcHrMsaxbORGWhHtO0RPOw1/gDcUo+2xpHoEF2J/+KhNl6a/MATzK6Lp3DysyAsohshq4Jm1qyvbPjJp60lpG/+PC+3HF8uFqvKba472cAzrdi+7bEEx9qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764098218; c=relaxed/simple;
	bh=PzAEtVC1OAN+ZsbmD15x5iHLCTZxgoR9+x01WEeARqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=omo4Ia7SO6flFUOES7BYNk/1HMm/Xk39SrZ6MJh4Cf4AsQhL6TuL82kVPxXcTG6tClGj2MPij0aCwDr1QufbqCGlEgTJmCw5DHJeP7OJj1Sswg6F3+AP5e1IQM47eXE5dr7dU9fd4Hlbwx5TShicZkCWdjA/jUlWbgsNGLbpeps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=QSQ1YYfW; arc=fail smtp.client-ip=52.101.72.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZjOzdw3c4G3N9AFm+llGzqdEZRKaezC7831K8bF0k6zBwZMOtV3MGR6hDNCE5qyZ6n1lohfkC4665ApVnMqCmj+BolAoJ2KSNT6tIPLrUkfKJnMp1dCxy7MHHgTWTzS6Jy9tqUTEB3GWs6o/U7ItJwq72wy/F/Ru9WsNXLHwVvO5Or0v1qpDlhcLW/Jlk1qxQsi8q6jQYuWa/w4o5nJZxEJxzLVc19Z73prOvYtNiiaJOxKK6MTIHv9tv67hQZCwjQ0HjWAmhWDyUXy4wRWWuluKK2LYdl71mpna/gLMv+JrNlK8j07rqNIBV8zN6uVhCugge4jY7fGzK6wyyJfosw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcjwgzJuu4GKdW6MOzMtH4k6Gjp8Fj9ec0RGvqyijPg=;
 b=DsPK5fYjBoR9H0yKF7IYKQ+nBLidPcUKXlRxxFJRclEZcq2FEOY2FIZQkMciHhdd75qKF4eAgegiFs9brgfHgK6NKPgCS++lyrCJhjnyxhak6fzXdazNi+02+hbSTaXDSPfpHG5upf+z3kWUtc8SXJVPcevTxu2Ltk/1LnB2kYC+1KQQE+GJ6g2EiUyAmO84lGEotA/knl/azlUYuOwPhm75vs50OzVIS+Q/DhEGDnFrX6moCVwusyTt/q219HBJHtihlM212z3KLC5RzNVaFNuV/Z5KSB1ZuxlbdnwfmVtibBqtuYmofoxWzWgc2lYA8kLQIvH0Pu5ISPe/ZUEMbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcjwgzJuu4GKdW6MOzMtH4k6Gjp8Fj9ec0RGvqyijPg=;
 b=QSQ1YYfWY9vHeZddenYD0p7y6TKj7+zTTTQOGFkeJsxM5DFhcSB7gv6EFt74hO0mAhbxIbKSseqqNchjKcug5e0pBhJchhkTFLT7qnMg3m8mGLF0qnSVyKJftjGPcnGzCKh3WVeFLCP1qAJ92b+SkME12uebVmN+0fvu+ku5ZnJiHhs4+3+0j9HvqxtclkWptGrVoB/VprLiDbFqLvwILb85Uwf7bFR/hzXCRnV0aZXtQBHwjR9hFfT139hPZD17GhXYTyPS/leC1NzagPwWRuJEf1TqqN/cDC1nSfmPmS9iARfxy6iEEYFAWG0iabaDDa2j5KP5YfaRqANNHpXvGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU4PR08MB10958.eurprd08.prod.outlook.com (2603:10a6:10:56e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 19:16:47 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 19:16:47 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v5 3/3] arm: dts: airoha: en7523: add SNAND node
Date: Tue, 25 Nov 2025 22:16:35 +0300
Message-ID: <20251125191635.1075027-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125191635.1075027-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251125191635.1075027-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00007A84.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::616) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU4PR08MB10958:EE_
X-MS-Office365-Filtering-Correlation-Id: 62526406-fce4-415f-cf1d-08de2c572db4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CesWbNR2mBf52LswiegPYx+8wdptbQps2Z/lCDWaReWDPOTECclHajb48i01?=
 =?us-ascii?Q?Zf8G7wsK7ILA41T6whm/jykrR6GFzzrg1dzR8FmSu374Haff6XN9xtMpDupY?=
 =?us-ascii?Q?Nsp0gvgfrmQhEVTxyu2OMxc5hw/ZKhibtNB/jNKCIaPzJIKekvOEIUCXz8R2?=
 =?us-ascii?Q?6KqFN0mLCF62xQhuqXdtgsVjg31pFWDG50Fdm7eEo7TMLYBVPjb0fETk5cyS?=
 =?us-ascii?Q?Iwpqk0mWZXO9qCKm7YYvP5DsbmCU0uDSCEqjv3CwvdrOMSRC6ehqY3uciQ5P?=
 =?us-ascii?Q?gkIRf5qkfr1Oc9uccTiCuTKHK8kUFeFpisMFm6GosW8jH2ZGDJv48DjKfnEQ?=
 =?us-ascii?Q?wkQnMsdvr8FxV+GrR+xnlNwmBDhJwcN8DonF98flzru4ReZ9DR5JXvKg2cEd?=
 =?us-ascii?Q?ICdLbIj65d0ZJsm8ldc/+6N8IFeP+4DJjyUi7bW96mSATO1DRLkH2SYbx/hk?=
 =?us-ascii?Q?0IuHyHJm8rsAdxRwxs8USTDuQ+iB0S9zz1AZvhDgK8ekrbg0XFCN32vW/lbE?=
 =?us-ascii?Q?rG+ln5gd4nSDDt+pT0FRsS2VYc8U/7E9q1x/WtAKeoJnJnlCwUXWHsUUWRko?=
 =?us-ascii?Q?uV9UD1JZ7RSY2wUIOnYAphGfy0IySL3PVI99dteKh7gjS9qL8cf21qsJYqYk?=
 =?us-ascii?Q?xLVwdf/ii9dJUPsB/rQmjjio7h3dmGIArZj7Lxlf/8+yxz/dmawbDQWsSXZT?=
 =?us-ascii?Q?MCwQLl4SuSzvpCt6un90AkniflaIRympNK8+wuc2Lce1bdq6A3Mz7i/BP0Ni?=
 =?us-ascii?Q?LATkbje5bEaSjFqJsxv/WMPC9AWeNuj8V5aQQ2AANi9xAp4xOEDs2aYshIeT?=
 =?us-ascii?Q?8tDVOcJsxmbaaY9wraeVBm0nDr7yw+VVrAv/Tl+uSbjfKj6ITVQF9JftCBXI?=
 =?us-ascii?Q?K63hxHZxeK0Eeykou7siJEPjQDtKqKhhnhowtWozOPSACoj5JD7A01DJXI9p?=
 =?us-ascii?Q?vPgRpLNN+YVGWB4c1iqNOvbiGhjl7fLhP8ocPjIk3qwKaMqLNBqCBi9vz6p1?=
 =?us-ascii?Q?R9ItUncPPzwIUmrOtKoK0Um1a7oEiFGk3DjXIX/0F1hn1VQx1Q1tnmLc7512?=
 =?us-ascii?Q?Nsu3V8yrCPkPu4anf3mNxM/sBWDQJmsThAmj59Q3uEqWk9gO4d2XBM3/tC1X?=
 =?us-ascii?Q?yOz+teebe78pquFVP36HKJayaZ8f+q6ttDPCu45Dw9e1d2POISfixX1DW9Tn?=
 =?us-ascii?Q?oJlGpsauUrEjHzHlI1Kp5HB7b27+xAQ3kDx7+aYwFlndjQvHnbTtDGZqrt7/?=
 =?us-ascii?Q?WY5Gn6gSe5pViYvryt8WWCCJwxqR4JdKj5+r8wCgIS1voh/NdzCDNnNIN2r0?=
 =?us-ascii?Q?xY2/8YulW0nbzbWmCwUvt26MdPCao34GvdaL6MiV/Ygm55sd1HXIXH3LI3oG?=
 =?us-ascii?Q?QeSL52OEveYFnZGzUN9skHI9zFqCkhkx15y37caYpx3XmvP+i8Cy7uxKMN0v?=
 =?us-ascii?Q?7izg5cJtsJOjB6HUlCkt95n5a/8EV6+oarPRGc+JGik/R4TNviO5NfCxPi4U?=
 =?us-ascii?Q?n+oaTc1gIecdG/RDQZ2fQJeEbDF49iVGDB1Czz/9U7VM7napQ7f/imm/GA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PoptXDh1ZmwEKNBF+28Lrh2n9mXUW3Nv3d/ZP/2epebCCFLbRSY1p3oT5Kke?=
 =?us-ascii?Q?sI29r0piVvSXaQoyd555hmBDd9Hg5fpD9uA020NzWfScYfqEDHfxSvaxXFGW?=
 =?us-ascii?Q?FgfsOa9nw4hgCb09ETn5Um8oksu6LCUWC2HjB6BuQkFyi3RwBgZmuPsFZzoZ?=
 =?us-ascii?Q?KtXzJHpDBgO6TcxkDid40mkyAFRJ1FPtaW8o/uNGEmllcxMqaj9L5THiMWyh?=
 =?us-ascii?Q?QChVAxEK0R0SZGjKQtO2Y7PVEzyUIa04AIEidxva1EHzgK1E2mS2kgWP1j4r?=
 =?us-ascii?Q?Y1PJNjfhrzJ+x8nqANGPXpyu/GBWSoYM4CXZPIO50HXvOWkw9wJZ4MpCBDME?=
 =?us-ascii?Q?27OKc0bMky9SmdfXsJqESrRLSm+GaZa3RdvRBkJIOIoqjkT296gfZttwGdCi?=
 =?us-ascii?Q?fCdDnSG6z95IM2XLzOJATo6wo+msB+vSHkmVX8/FN/wgI/6thQp2R82LcvsW?=
 =?us-ascii?Q?mSnrCYG2fpFtHmwrQ0OYrNx8Pj9hGj9jJCm1+S6AcmMNwOws6RcmCl2WvujW?=
 =?us-ascii?Q?PB9A5WP9ZDokzLAzuRm1TfziQd7uTtujTjj1dGrGpINAp7c42iZzAqJRGHYe?=
 =?us-ascii?Q?PO3cc8ZiDwRUQzUjKXBkLIYq12qdtLNiGTKCY8ZUofiW1cwSsWv2xOq4k8/x?=
 =?us-ascii?Q?N+F/EhtYPOEK7kWMvVtxa6bqn06vwAArI/SOM/j5IidyHvrpjx52LPVOjwDS?=
 =?us-ascii?Q?BQDLyECP1/j4X27kkcjM2+PyJemmde3C+lHjCWTlt8hA3oS2DAEn/eudCNFp?=
 =?us-ascii?Q?C0Jl7+3cY8hu4O15wG60QmQbgBx2sq6t6YuQzSqEIhnbP/MqSxDQV4GYZ35E?=
 =?us-ascii?Q?Uyv0vS2lYQRQFEbnVBHphrXE9FeP4l6Tbod+Uwok2+Xht9uyl/vH+gf8mNYn?=
 =?us-ascii?Q?ikG1+refojg5kajVzljpxK6AVdE+l8ri3UCY7XnBjKVm/XN/fti+dSfgOSFx?=
 =?us-ascii?Q?nUndtegawmZCR2M2r/Tsh92vK2WPggTUfD/gRfNUBNITg5a10ASustvWQX98?=
 =?us-ascii?Q?r1Rf+U4uMuwtlmLfjb32t7xEyLdmE3SKaogTYcNHNlzIAaKx1K4W98iWwBOH?=
 =?us-ascii?Q?u6D+FnzT9z/3sBsno3nMHE95dHHRbH/Gidpo2g+ivbUxEsLVB3luYa74VPsc?=
 =?us-ascii?Q?QBfNWwEYyGLeqswyP+8zUJFiXKcjm3xz3ksSCe1tznY3+r1njcLruR3hdSeO?=
 =?us-ascii?Q?JnqVTce5/1I9mY6s0RMVW17JCc3Z7VKK3aNfMpnRQp0iv4Wy7B5y8oloz/vP?=
 =?us-ascii?Q?tqxX0W68XijY3t3WX9BcFeJ0pvIfXkcszQL4RGB9WC3xkQ8bIxJ4LSu5uKCu?=
 =?us-ascii?Q?tD8c0CymThBKrZgSTxCVKIFpLXaFDEilWyDoY4Cdh3CX9OFXWJe4PZM1Z/p0?=
 =?us-ascii?Q?B6vvXE98Txm4wrZkh00yZJ3QDkDblgA1hhGaOvhdNAU3hLE8+2RWUfsY6gJz?=
 =?us-ascii?Q?UJYTAxyAGiABtvXDxsU+ZoIy2l4Y7hsuE7GXmpuK1v1ugn9gsFswwm/c1XQg?=
 =?us-ascii?Q?6qeEwsoWkS6UDPxHJgL/Uq2BjLgZOFidDEjVMpeEAq5Mh6RdWFeyjILggVlq?=
 =?us-ascii?Q?05garBZGq1AwEH6GYtJ1bmptx8x/ahvf51S5kCAcVJ72SIr+V6ArulqXpN2M?=
 =?us-ascii?Q?W7uRoG7L83cw+I+1ZTdrELE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 62526406-fce4-415f-cf1d-08de2c572db4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 19:16:47.5831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1RnN2xkXR2P4bNffJkHcOBP53SSnI3ur0pm91jOFso+c2pYSqXR4al+++HgiA+bdLOHkxGP3Q2gMxKGfQKb611lqE2YDrLbGhal+KSdKKSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB10958

Add SNAND node to enable support of attached SPI-NAND on the EN7523 SoC.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm/boot/dts/airoha/en7523.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/airoha/en7523.dtsi b/arch/arm/boot/dts/airoha/en7523.dtsi
index b523a868c4ad..31191b8d1430 100644
--- a/arch/arm/boot/dts/airoha/en7523.dtsi
+++ b/arch/arm/boot/dts/airoha/en7523.dtsi
@@ -203,4 +203,24 @@ pcie_intc1: interrupt-controller {
 			#interrupt-cells = <1>;
 		};
 	};
+
+	spi_ctrl: spi@1fa10000 {
+		compatible = "airoha,en7523-snand", "airoha,en7581-snand";
+		reg = <0x1fa10000 0x140>,
+		      <0x1fa11000 0x160>;
+
+		clocks = <&scu EN7523_CLK_SPI>;
+		clock-names = "spi";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		nand: nand@0 {
+			compatible = "spi-nand";
+			reg = <0>;
+			spi-max-frequency = <50000000>;
+			spi-tx-bus-width = <1>;
+			spi-rx-bus-width = <2>;
+		};
+	};
 };
-- 
2.51.0


