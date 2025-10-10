Return-Path: <linux-spi+bounces-10547-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 276BCBCE5FC
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 21:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CCB35440BD
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 19:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569B0303A38;
	Fri, 10 Oct 2025 19:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="eWoq5QFe"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021121.outbound.protection.outlook.com [52.101.70.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8B5EEC0;
	Fri, 10 Oct 2025 19:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760124081; cv=fail; b=PEykShyKhLRElegzniiDAQuC6Bedy28x7XmgY6bRQY/3SVMcRZ1k8VkykuwqEwUK/85Yzr1JucpaC8kpNvLNdbIYHs8kOkrYnLWfsbhj2InreCxutzXBLTQzuuVQtcnfCT8fpqkZ+g9I1/zfc6qikoaR+zkLjlOscz4uHypUhfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760124081; c=relaxed/simple;
	bh=MgsWMJj842pbuGxF3W8ZWBqjapcyfUsoPeCt4Y9SsQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UVg5Hz23kugXndAabcUJTKp1GCyv/sUTL/YgrnHoaQC3FVQOtZD48K8fv4vMkHEQNZJhuvBIN5DzTFeRZ9Ys0o69+OY9pVGzywoYZ4ejW0MLbEb3NY2pNgYwm4mkRfSDwveuonXGp8kvpZq+23Cg6LWuJfOlah/by34w8ah/5Ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=eWoq5QFe; arc=fail smtp.client-ip=52.101.70.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWIIrVKjfeZ7OGAX5iswRpIhHGf6Fg+0lzxCrs3GuuRbN6aRqyHlntuv2a1tVDVXUw6Ofe5Ysjh/I7gu8rI8E9QSojOYFzx+NpAg9T1YREUKFoTZnK6n0teIV7LHHqb0yc+4O9hpWijMc4JXfyhuyaje5NZiSRAQPJ0+DPinG/+7/zGWv7Z35ozDYjRUS4u8WM7KDbVFWl8KolzuWawCyXu6TdgRmigRY5DQ42/tNsWCFJJWNMl+cF0d15kv7yuvWX0PEwtngQFMPHMZIKYOjW99t7+nm+vA1VeoG76VKq+wrsRANr2vXquM0NH2IyU8miHlXZ07/tq0bLpStB7xxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pclgjJzBglq3k+jypS5WX1FJzUfIAk/XvZFXUcm8vfw=;
 b=QvMTRG4ixjcici0laj0T337isxsN0rdppS1VkYj0OmUlTPNnT0bABTk2eF62/gznH8XWN29ZnICQVdhQOshcJdXzJuGWLh7kVJGOsMTAamCAxKPYedgKpEYu5c6vq9GE7wObodAiyhl1Y7+UAVbmeWPB/3YQKlba2VmsMVD0ru5NIfuvwx0d1UqCQUnCMxZuTvjepgJ8WZE9V2B3dzPHk91lwDh2paOA5IxRgYrpDLAOq/6eSXzszr1mamaRswH/huPH/E7sB1YDTCys/UjPwl8ACk+pgkNBYgO+QCTjoQF3Q0YbAx2fjM4RIMkSd0mULyFrW8ZQdUsUqMb86+e2sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pclgjJzBglq3k+jypS5WX1FJzUfIAk/XvZFXUcm8vfw=;
 b=eWoq5QFe29loHqovbQJvZavYSmzOz5+iF5uHFapT73IVPNVMzD3Xmn0p/RiWXglfouzHA74zlgD3WNDyjKBmFm/bqBuBVlsarp7gXbF+9BVWJobOzR2KtcE/dpGA0+ijY/YX9/358M/GO5Y9WNpYVG5POukgmo8EOCVzEDPOuCWX/4oyZvV7KkxAhy5agITowrAV6ej/JJ5O8bYyvcg4bh4igPGXBoKoiuFBetWfkRoIbPGsclRUb+D0Cz50k4yP7/RBfGxH7z438dfCP38ogvQHwZOdlAd9OJKM/YRlLVUCoEtaNc98lOZh4qDlWdvBI74b7uQRZrOaZyzV3MxAJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBAPR08MB5784.eurprd08.prod.outlook.com (2603:10a6:10:1a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 19:21:08 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 19:21:08 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v8 15/15] arm: dts: airoha: en7523: add SNAND node
Date: Fri, 10 Oct 2025 22:20:38 +0300
Message-ID: <20251010192038.1592889-16-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010192038.1592889-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010185940.GA715991-robh@kernel.org>
 <20251010192038.1592889-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0020.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::32) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DBAPR08MB5784:EE_
X-MS-Office365-Filtering-Correlation-Id: f4fddc97-b3fc-4383-a13a-08de083229ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|366016|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ddAmn0sfOPEb6mW0uBgDWl7DD9AKR4burkDWdMSujOXZRHG6gSkty3lNziq6?=
 =?us-ascii?Q?my7UPnOBmQBPhF4iRZANEu7ArXMBo/CL8K7jiDKNCGNvMNitMlLm8OMMZUDz?=
 =?us-ascii?Q?1wmR8J7p42gIHgdIzZs+dY4RF1WUqdlrGqps41BVDJw8cvN8w1SqLuuaFwxb?=
 =?us-ascii?Q?+8yPzl9U0nwSrwSd4FvT6vT/72jr9WL4Qn0isGxVl1pgoqCyUMuFKxg4EX4f?=
 =?us-ascii?Q?PmYFbwLiKHLsG6L0tTE0fJyIFVKX+gMH+6+cMCBBAw1FC3erGADQ9Jcalons?=
 =?us-ascii?Q?dp5E05+3uadU5m5DtTi4yt1pSsAOyVPCNUfnsVKxWgBj8ZOi/2A17kMVDIN1?=
 =?us-ascii?Q?swWA6fChePwclVvKPH1lB2927sm/gHSM/ylyVfiHN54cN2gJaHWaw5jM6Gqn?=
 =?us-ascii?Q?6WUfgwiTuVuwLm0s9Lo87pmhMZL3eA3gNsZtNooDxPspdB7gpCSYfwNeD+kM?=
 =?us-ascii?Q?WkXSqXeEEbtt2shyPP49pwsYB7aBCtfQr1u4MQG4ob0oyTvC+ms15lCcrl4W?=
 =?us-ascii?Q?BHrrdfkbBLlbbvK5aKQGuWqEVeOk7/NpqIIjMya47igPFt6uRmPtZdqB6nCH?=
 =?us-ascii?Q?GB4eI5gMcf/oes6kpAhSXxW2QCRukDr8A9hjhJn4o+2zOjC2uSjXuu9ePFk/?=
 =?us-ascii?Q?Q+aIuqOkmoXstrldE6dZAGNTl0DZZiOaIBjDrrJ/mrgnLH5RW97jah9nt5O3?=
 =?us-ascii?Q?JwtmH1VwfYoFgmZ9mLY04k5PKDeOL+gP0cH5N5j5peEu0DdbNNh1fdfwrzLT?=
 =?us-ascii?Q?iYgCrM5qjhrAhF1C8zTCGhD3fbZxG3QRMGnjpgKK7AGqRoqmqla9sPfVpAXI?=
 =?us-ascii?Q?D2B377MZgcZHnklLkCzboM04dVKxpOkSTxvaCYdyfiqxsHHiHPxgzTtzYnBj?=
 =?us-ascii?Q?iIwWI4eW1KdCTJY39v2G8j6K0I/5svKeoNIUg4JxEn+u0O1Axdc4ZsnCNhxp?=
 =?us-ascii?Q?FWPyWSTE3evDGrphNKC5hHrb/FCQd/jiOhE0KX103D+jJgInPfDyiCJ7Etzv?=
 =?us-ascii?Q?i+mUunD1pqareWby+vM3aAojl8r1BW09AKjEap4xxOjh7+u/xjRZmLVAWCJY?=
 =?us-ascii?Q?lSNUkn7uYMjJOTm5s+Tq8Jz+p5DTabVAIdm+EldFiHvKfhyPnyCOk0rMqZhp?=
 =?us-ascii?Q?pd7ldff1fjeSvojPoCXxUHcxK0Ey8G26EyQrpviYSlfBAwQ1MYDjngSaDB9U?=
 =?us-ascii?Q?xT+X5+2OGjV8m2+1ojTR0Syv3vfOh2xyqcZMduqfCH2/IMLdE+kYZgRZ4c0i?=
 =?us-ascii?Q?hfFvTZ10fW/7hjScGMx5slfjtW1FrB9VwXi4f3WKClXFtUcpc7fxtfe4NHpD?=
 =?us-ascii?Q?ZQBI2n31HJ1jDpTwvXHoH6G0FmQGH4gzRFg580i7bHfp9HCfLQ8XCKPpqQfk?=
 =?us-ascii?Q?dHvA3Wv5d8ectCcfZcI/Vp1ri/KzquCXrolYA2Rmj+HucGtX2hpF+pj3ZS6Y?=
 =?us-ascii?Q?nP92uK/eW0lV141+2KTk1450QN92JcNbm8AUIm+mzOvGD8zi0qj4Lqf0Nblq?=
 =?us-ascii?Q?PBRGmfaKPhCKCFWuDNrkH8x8jE/mIjqJpq4JvvA7+lVdXw/F4Mw4JVDK8A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(366016)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3D50giYrxdn3B57U4okjoQVyEH80jPgLy+pZW1EUINqFDVkRn2mfGRai7FaK?=
 =?us-ascii?Q?QjNQ7Vtk2iBtcIyY2e5boGJaUO4twaQBEDqv3FjsiB10VHKIAWuouguyiYTi?=
 =?us-ascii?Q?PlTGAmCYgdZZ1c25CFAUwZ+cdvnLsvV7zS5Pm6Aiz5r49Xc0RD3eOi+EABu9?=
 =?us-ascii?Q?BP6oSXYcYs3c7gA03OYE+60oJjVQf/sOPiibg3B0CKgzZFFD661hl0V2N6A0?=
 =?us-ascii?Q?EwEr1Yna02at9oUQH+CO1M8yQ4Kn//B4y8uEqzEiDMu+dRSqSqMF9A74D+bX?=
 =?us-ascii?Q?1eQ5drVEPy0GLcDCZ1jDazCxXq5Y8Lwi+/evZXEKkKgBgPT0fVF6xHQYWHIt?=
 =?us-ascii?Q?lLMyMr6SyUKMyjapy1RKql9jkv8+vFQX6ON4EBVwTQS5MSnCEmcUROR0Cywd?=
 =?us-ascii?Q?gaowTXVbld4876zNNl/NXoIDfHe10pmDTf+xhV16IQaC77FOWHWIM8zPg/BH?=
 =?us-ascii?Q?xQ9UULSGwptN4Cm54ZDxPW+IuchcPaqsbTwRIpr1A27/3R9AEkn/fc2LNH7K?=
 =?us-ascii?Q?lq36bH7irBHcxEVhrOGkkk8Bf0uUEXul4RfrIPdmlNlHuPcZwgfTno49ye7u?=
 =?us-ascii?Q?f773wmp2foPRJgh9M3LS5NIlFm0aeeTsxdKi4xsM9lwQarK7LYHGeR+33iwB?=
 =?us-ascii?Q?KDnzymQzpfw/t2z8UGqBbNn9T8nhuJf5WVp1ORYfEG37Gnu7fEi8QxPEw9Ep?=
 =?us-ascii?Q?y3YKItI0hFF8vO5p6FDJysidnNOqDHWoHEgmohJLNUTfnqL1xzsQCRNVj3Q7?=
 =?us-ascii?Q?5rluYaJdI7BZSfXM+GnRJb0X6SOJ1CiJKFNMo3EBk7pwVbnEhzTOxL0atQII?=
 =?us-ascii?Q?1aM9UiTi44OA0UZhGH0tkLPQosAYsP2/Azikay4bIYoG1kImvjTuhZkvvyIH?=
 =?us-ascii?Q?v4eRWf6BS6avUd0SXl8A69Cx13lXosBYR17LtnzKkL195++v6YtG0p0ET3q2?=
 =?us-ascii?Q?DBTnB+C+XQswfGeu/IdhUWjPTkBFDMp2UcRgbP3VRpfjPvOg6etbj0W83/sl?=
 =?us-ascii?Q?UYVIfaN7KW8mUTbewtwIKtwKjM5SvoYLf7vMrbw8hmpggdrU0vg5QsHMe8sP?=
 =?us-ascii?Q?AddEysimP/DJrpFd7dMgK+BG4JeqYNjVrU7WAtx/scxNZ2biU/a9D6mrsM5c?=
 =?us-ascii?Q?eZijob5hko8zaa1Nf8ULmjnLEq1utniTxXDGgvIUbmQdwFZVNxxD0vQNbBOC?=
 =?us-ascii?Q?GSWqCPz8h7bZGU0dNNwrpLyiNmQAYRTdbhoRWHD13gjuBdNoqB0LKzjAPUS/?=
 =?us-ascii?Q?LJwhAYGjMd5J1pFD9dGQdP2Er1yI6n8XIqno4YPgUdUDALA6Id9rNYTRCOhr?=
 =?us-ascii?Q?IY90gS1lPDCod97CsYmx07H+vn6I3wZVkoFkmaywsJyU//tuHzJRyzAmUYCm?=
 =?us-ascii?Q?fKZQ56Z9dIQc13q67pOqMrTrOkho5wRcJaKSto2l1W+K2cYoLfRQcJGdC541?=
 =?us-ascii?Q?xHNKHF3aUV0cSpQHkb5/EX19yxhnkVZy0Whxk01MoDJZ4uFC1HKPmT7oqXeW?=
 =?us-ascii?Q?pmEXrfk123SKsSVUgknuY4WLyMVfy4jFWenpw9ZOlbQn0cDJu7pT8w7pRUNJ?=
 =?us-ascii?Q?QZa0jQDZ/hHBV2R3qCfXX8oDfcmj49nTy/27D6dwMbWi3dItAgeUtfFsbD9u?=
 =?us-ascii?Q?vNpgevYJMNVxnThA6LOMpO4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f4fddc97-b3fc-4383-a13a-08de083229ea
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 19:21:07.9522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9hopDEX3cKHPNpp/5n6GeS7sQcow7lH9woVFRvQ9AW1qDYoQcG7iEjxV8UjvMuNsAbXurT5nNUpCYrPpLGxC/w/LdIjx19+NHkpNOleIbyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5784

Add SNAND node to enable support of attached SPI-NAND on the EN7523 SoC.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 arch/arm/boot/dts/airoha/en7523.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/airoha/en7523.dtsi b/arch/arm/boot/dts/airoha/en7523.dtsi
index b523a868c4ad..a13dc6e77d08 100644
--- a/arch/arm/boot/dts/airoha/en7523.dtsi
+++ b/arch/arm/boot/dts/airoha/en7523.dtsi
@@ -203,4 +203,25 @@ pcie_intc1: interrupt-controller {
 			#interrupt-cells = <1>;
 		};
 	};
+
+	spi_ctrl: spi_controller@1fa10000 {
+		compatible = "airoha,en7581-snand";
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
+
 };
-- 
2.51.0


