Return-Path: <linux-spi+bounces-11531-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CDEC86C15
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 20:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E2264E900D
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 19:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E8E32D439;
	Tue, 25 Nov 2025 19:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="xnyVK4Nn"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023132.outbound.protection.outlook.com [52.101.72.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386892D23B8;
	Tue, 25 Nov 2025 19:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764098216; cv=fail; b=i0DoKBKy1mtNCdjPE2i3/sZ+LPRcNzGX5JUK9triiOgNXJHBqjd2QL8C5DvY+iaSKmalI08Fdyz+wE2BVrEJTj6lNOtP0jq1hTFKFZl6uXhW2+xmkhpQsttUYaPocyKNwA70b//LNRmBEkCpSAriXAVV883AGWsJ/Dzco3xo8IY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764098216; c=relaxed/simple;
	bh=nvzSbP9vzHqZ9BdvDElbSy9zjtNy+EQ+e//hLD4/DeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JQjWhwWBs6BahKfjeZiHt8y/PKYReSw43ZLf39iXJ49xUrEFqlLUSzhcrvk6MtwHpPXHK2oZkllCH0GrVwBKnt7qfRXQ13FBErQrzfhPBHajN0rn9qhj22hMdHHmPqd+q2C6C2DRv40pqVPZmBLLFQ43TALstDlq0GeiNmc7ZEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=xnyVK4Nn; arc=fail smtp.client-ip=52.101.72.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EIMf6+zIagl7Ajc8vrPUE0w6uRg5CoKyCsCj4NUJh3WdgEkIiXbDR+mqpNYDY40zece0eWLoGMdGjnjPeBdihvJ4wdlfG6TdaZw1zlXraDzwLFjIGuBuwLXYbiVr54uOwhoNFoJCgQYpSp1LVI/9NSWEbderMmcwPJ0EbXAKZIMNJnvwQWI9mI4eJoCTJ1Y2KcrtqjbS2OIpgt7oNs86IUsE8xzJ9fS3CdEj31Fbxts1tSQUrFBjut5SXRUsg7SDejJcRrhr7p+x9yI8kUxSiM5vwoYLsQgbdLWQFLnPErjwgW55NbTAieNE1SMNtQM6B6UMdSpayZvbBhwHbplyOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aj3KXet9skYYmZuJ1RFhi80JF8Ngy4LwP2uvVKLNgRI=;
 b=HhIxSriUTtSEJgJ4OdBxi5TLiqqHkZh2uoroGyWt0ya7Mf7i4/uq8v9cTg/gV0qv6Kuo2mPX0Rrt+O1K8VRR9Q9u3s3kOr+NKNMRKJ+/NEWhOZISGkeH179Ck7XeGl2bYqh6WzSb3xP9qTbVOzZs6ZK+JvFU5HKbxGpF7GheEe4FjOcfFY1HvYWDOMf9yQUIoqe/9shRCrzwht/gWFIuS1+jvu/M1MCYfbPhVSQ6/LZIeTFs7AS/6/GgXSmo1iymu0sniQ8F0s0TXVLJVknSywSZnOM1+zH0hEZTBx+XkzUVX+sSBOqKqU4e4zGgFjugp1wBuKbxyBGIfiChPlQslQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aj3KXet9skYYmZuJ1RFhi80JF8Ngy4LwP2uvVKLNgRI=;
 b=xnyVK4Nn8xW8QB2XSkBzMe80Ew4akorhiD1qY/1j3qAttSUXDgriktv6XacMX//4I+Z6EyW/2kOkxFuIm/c8JvrUqHcxWqnw9w1okrkamI370idxq0Ii/N4LOraIQRRpx4c9S0b6Sp+nfgBkKBPHL+eeMGtAsmPwA0Hnu6s+lyJfWVSkdITRTNgRIw8bYBPUDqlfbjV7EXuV8bqHizhRzolfCXqUaCEwMQxoidW6P+u8//BdMBn17FLLgkBaIRPkNTIxi50XFkk48sBs2Zjj/BthWIVrfe2PXv4qgkCO4bfn9UOcrjY9KyoQXVXFcl8vr7u9aZZLAgWZw75B6q/HDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU4PR08MB10958.eurprd08.prod.outlook.com (2603:10a6:10:56e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 19:16:46 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 19:16:46 +0000
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
	Andreas Gnau <andreas.gnau@iopsys.eu>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 2/3] dt-bindings: spi: airoha: add compatible for EN7523
Date: Tue, 25 Nov 2025 22:16:34 +0300
Message-ID: <20251125191635.1075027-3-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: b1e9f370-32ca-47f0-3251-08de2c572cda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9TvcPe10uOPP3IjMcSSr0KXCvgyLQW6gMQ+gBMswFKHWMrz3+ULsPKjLFJ+g?=
 =?us-ascii?Q?ytlt0Zx9P/dYAMpKd6qQAx0NWQGdI28t7qBhbi/l6mfNRrkps1BVRfwwYCRk?=
 =?us-ascii?Q?avm3nTWf8/6oYw73qFgrmtd7OG6rTbwrfpdOFQQQ/6PojtjPPjYAMmGz1BBX?=
 =?us-ascii?Q?Rj3+l2coa6quMuQw+aeWIM+t6jRZObzcheKJkWXYorSyDJKqNvHdBMjta/c4?=
 =?us-ascii?Q?pK6tjaSDbULTZBDizzzAeB1Fy03ne7gD8jcY90twRZcLocDyWWKm4w3EkMol?=
 =?us-ascii?Q?GlRPVhOvxIFP5C7jW0JDh2MVJTrZk+6MP3vaIY/T+n3jmUhsEg8B1qdkCnQW?=
 =?us-ascii?Q?xFrRefcS2EM3tRUy6dShMamtwqgcXfGrP7ReUmIcDkOsWJpiRanYWjdEa25D?=
 =?us-ascii?Q?hNuiUl7DmnS2H5pl0h5x/W+JkxeD0QcfcikybCFzh0iznmLL5xAWPKjMMRdN?=
 =?us-ascii?Q?S0ZUhkGCqJj+qIpkm1A+i37mGZWk/EeplMY30888QMfBm79VFcH07bhZt0KB?=
 =?us-ascii?Q?VRQgYjmikKb76vDjvSTBQIaJ+bVQNsnvED37HMWRkRQ2dnyXYpzTpBRbVXCM?=
 =?us-ascii?Q?1QMO/fuh7TL+Z0wxLzLyIXYodkrWPGtFEhJpLeNDvmh0bXZLxCHV7KmPv2NH?=
 =?us-ascii?Q?TqMtF3Gf3FBmfu/BRhS79d4VUuWm1/MiVwJIBq/APqypP2hbj2l8FhWpWL2N?=
 =?us-ascii?Q?rH1U364PkpaREJwt0YdKWaglwlj4A0keegWAoaUnRuokZ4Fb+dHDEyxc9Fvm?=
 =?us-ascii?Q?D4CasUl+4utVMYvrAUCc7IHhhqLk15bycGqDFepo/B8UerN1fKDUVAmFQYez?=
 =?us-ascii?Q?B30/+EbcglXPZcZlyyIWPbvL0340h9xwtSDvN9HseaCwV163M4IN0t9eSesh?=
 =?us-ascii?Q?n9A9a4zNE+0qoavR4BpvzJYexO2qQqbyx939nEq/3ZXIN3iII+9IlF7ezH26?=
 =?us-ascii?Q?gwIwa9WjRKw8q7prfiON1U+oH0C3etWvkKn9ZeG09KadP/vG59rUrMdu/kRk?=
 =?us-ascii?Q?Tuzt0UXvPaLXAehwqRAWiu0W7z7RQgmrZSwgMH7dWFd3qUNvNn6TkMjY4NpD?=
 =?us-ascii?Q?jvTnsjldBLRBdRMFiLG7KcknvX+4TJ5a46n92j0Sv/9mxN/zeFrdmE5I1biW?=
 =?us-ascii?Q?9rATWZ/tInqSmlh+FAAhqVRtHyDgwBnWSbwtnT1lgtP5SUQCT6uw2eah5ilu?=
 =?us-ascii?Q?NkFv+iG4197N4tm/o4PNhrecnV4avT/xNVMEnVsdWVURjvauLl8Uj4D8YG+9?=
 =?us-ascii?Q?oWUO8eoOoTBLM5g/zd3ZNSMeo8ioL3lj4ljMpNPHvpBhE6lVly5KcN4geKZz?=
 =?us-ascii?Q?AAID3A72mbVqkSJvNjmcxVdww6Qwzpeq/nVNUgUDEUUsqPqhobDot0FquqyP?=
 =?us-ascii?Q?cQqrNUC07GnMJi2d6P3+TrbwPewoLgeMWi7oTU7vL48kicHqm4U6ckkn4/2Y?=
 =?us-ascii?Q?Xw/xGiPaZzzVTjQ4iwB1cGjJ9IbQFPUn95v/sTEnaK4BHQRkthi8TtxWyfy7?=
 =?us-ascii?Q?kRU9v9hb/d7qLQq8TiF8YUgt4fLgXzK1Vq1eq4SXM2A/cG1u7Oc1xwilTA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5JR68u5VKuaQcCxaV/bKEJgwwGZCBaCPj6wEgkGF7YzjGLbeQOvMG/YnxL39?=
 =?us-ascii?Q?on1v5Aeel7JENMtI6qbMIEqmiQCr4SVcDT6irXNZhUvLQROeoYBA8gHZTo26?=
 =?us-ascii?Q?2dw357s0XUk9qP4R1l2hhCGH1knCim2OHYNY+HMWrZkpGw6u2rCDZU1Vy5F0?=
 =?us-ascii?Q?ZA/edNt5AlbpIyUkMydeR/hLrw1eX7ei+5YJF1HC72oSaQzuPfdPuj81K8dC?=
 =?us-ascii?Q?SnMm5EEmNB0T5kEY7c22IBP7GkuWlf6Tnuxcr7m1Iapvf2PNcuuEvrJU+sEU?=
 =?us-ascii?Q?Rxy9LiNQ1GGHALYd3qVHtHqooyzIUEKx6qApyT3oPl1T/4EKF8tz3j1gHHYw?=
 =?us-ascii?Q?vlf6CMxsiiWk1dfvGBTzK7xzj1HQeg/w+kwTisP09KkyE82y82EbHBUTBNp5?=
 =?us-ascii?Q?s5VGoW+NKq/6pu6+IzKNk8/Br3z/Ls6251geMJrboRYcgOlU04SiqE0z17CB?=
 =?us-ascii?Q?vIFTbP+sMYP4sqIfXa5babxbitw3cdruSqmRCVK+QXxrxHHH0FiUog1DDxPC?=
 =?us-ascii?Q?BRvx0FbbdY0Ibtd03HHRs3mohc6LHYIiULF2kkvtqWB2my3eAl5o7wsDeEtF?=
 =?us-ascii?Q?v2bCZhOYiMH98BOAiUjMMl5Bh0Y6qsxSxEEai9zXlTfDBJYSuNDH2SIyVIMS?=
 =?us-ascii?Q?mawuXtASapvpQ0KfGeSSMelMCVwozuio7DvaLBZbX8XTO7OVofr42d5lUfd0?=
 =?us-ascii?Q?6ItTdLtZfN9Wpe4nl7wYqkgFTyW/VrzO1mHRUTNmUqUu9y3XlbDG7588xyRM?=
 =?us-ascii?Q?7i2kKDAN0KBRJGvVq3Gzc8pE382Kueuw1Bf5+lint23LH64NUGdXi/1dSlZM?=
 =?us-ascii?Q?dVr+ZM/xsRUcLI2OhSHWXNIrvW5lde2g7N24vrjtMgVDziik3EpaeMYRxTcJ?=
 =?us-ascii?Q?culBP65bT7n61xu3xTKK73B/hhPjxu63IbyQVjT5ovyolVwG4BzXV/omjAzM?=
 =?us-ascii?Q?UFRkm/pY2Ad2s8el/f9cMhpRvPLOUqHzemJL703hBri80GpcW6VUIuN8WAWA?=
 =?us-ascii?Q?jKnK/i654xLOnXK7RdiqNN5OP/clQhWCt5uR7VhiudBCj+jv3Dy3FrxWL0yq?=
 =?us-ascii?Q?Y1ta37ScnJgRvDW//SzifMLsGbE5fzLGRa/4Bh8pAfCPPg5TxJSiBV6USfqv?=
 =?us-ascii?Q?YpNoJuhKRCp246XHjmk+vO/EhoYamwrP8uwC0qtbj/0AOQArZ2Cwwl/tK6eC?=
 =?us-ascii?Q?Z1Z1iPxoLePGAyXhKABg627u2mXxmnsKqcWwfuzIAjSm5Q64+EKtM5V1V0p9?=
 =?us-ascii?Q?UcGu0cCmmupukgqLQzHMfqyyS2zthkG9s2P5M6wapFlSD2Jd8ehmB5l1uXlQ?=
 =?us-ascii?Q?Teml7Ir2iO8hlFPZ+Qt5fLZPEqB+lBGRK9utLt/QcQ+eb633Sjf0PNPA07WK?=
 =?us-ascii?Q?q6jHP33UX0z/byyoywdeyg5/zcGM01xAnse2bQmLksdp6Twqp/DU35TovZJT?=
 =?us-ascii?Q?H7c1NxCqGQiIVbw/ImMupl6daBJgr5NJ+CF0K5EanVyEmNGguDFL49+Tf/by?=
 =?us-ascii?Q?ke1ltChQ+aH2JmX2kDT1lCRSzWJ1mHG036Y21e6cudjgzpFJRQEb56TnEXrK?=
 =?us-ascii?Q?RqmNBCzcen/fRShaC75Bx7fxuesMIWutb29zeK3h3Eudmp665L+BefHWW3FZ?=
 =?us-ascii?Q?qFsqrptmkmBBfb5T5DImUkQ=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b1e9f370-32ca-47f0-3251-08de2c572cda
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 19:16:46.1888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wVYhqUVzYCekCUs8vMVD7h/qKwDheOAEPSCwFvouFdmL26BgQ9mWn2aKMBCkFo6/oDMsTX0a+t//vuD8lit8yLGsDPsdIFL7enXFAymaPLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB10958

Add dt-bindings documentation of SPI NAND controller
for Airoha EN7523 SoC platform.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/spi/airoha,en7581-snand.yaml       | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml b/Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml
index b820c5613dcc..855aa08995b9 100644
--- a/Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml
+++ b/Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml
@@ -14,7 +14,12 @@ allOf:
 
 properties:
   compatible:
-    const: airoha,en7581-snand
+    oneOf:
+      - const: airoha,en7581-snand
+      - items:
+          - enum:
+              - airoha,en7523-snand
+          - const: airoha,en7581-snand
 
   reg:
     items:
-- 
2.51.0


