Return-Path: <linux-spi+bounces-11231-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E8CC5F9B5
	for <lists+linux-spi@lfdr.de>; Sat, 15 Nov 2025 00:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A89014E32C2
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 23:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332AD30FF08;
	Fri, 14 Nov 2025 23:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="eJF+E6hO"
X-Original-To: linux-spi@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023078.outbound.protection.outlook.com [52.101.83.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525DE30F92E;
	Fri, 14 Nov 2025 23:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763163294; cv=fail; b=nmRSLuh1JCW2FdP9733echAQeJ+dmGr7kMIsqA4/2g3e0fM/Zkp9vgd/Eipr5xUzS8nhJ3LWIJeZ4cI0AcKUUacRw4Q59jr2O08kttVDSPmsWET7vlnDRNZUU2XPlqYJsSkIDkorEExPP45dC4Ic6LyoDJAWafnjr3iLFBuKhG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763163294; c=relaxed/simple;
	bh=nvzSbP9vzHqZ9BdvDElbSy9zjtNy+EQ+e//hLD4/DeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MQIvPfUR6qJuhSl7wW8R+RRtqHi+MoannUJHpVRfbTJ4FLMeOtxURGewyu7QMerZSIWJcyaoWY4CBDBwEJB8tb+0VP3Xt7T++H9LeVM6fUOuLWEQ5rdDSp86U2hC1Vi5SylhAKycIs9LmJikYjVwEo1lKhTgv9FOy9I7y2aRcX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=eJF+E6hO; arc=fail smtp.client-ip=52.101.83.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SOWc+nCgMjh4prVYSsCgxDOCm55XyA3Fn7rhiXhpFuxK4ebNnHwFPqiDgGfTIXwS4OSCfailoP8wYogcAGE2YXj8tttrehvh4P+Cw/fxsZcetQAzTmXCqAp4C6LBmlKlBZK986LosOFgcYc7xJ9+0GiEmpCiCVa2GfMTyWKncnitORqhDhASc2Wb0AmXPO15ZCHCWbUkDX6KuHyraKSQJEdgR7JAn//6F9dY+byXvdGTwnwaNECQDC5RdCgK8QTJi2pc7LcpMwlPNzEKSs7CR254oFCyNfyUwNB/Pc3EszjT+NBvv+3K2T2a/bqztBrWdMYBUs0uuJVZ1x5rsK2VkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aj3KXet9skYYmZuJ1RFhi80JF8Ngy4LwP2uvVKLNgRI=;
 b=rsUHsRjeeo6fwWd5TwMe6jjX3vSLxYJH59RgN0wnKq+BMPgx/Illgu13S3TF5g7EWTOvGWL1UpyadrrEXDgnboqyK/MyoFOKYxQXeRGbrDAqN3ECF2y90R0pkpv5bZSEeI6QAJnvjEmD4F20TKcpVYsoD7Ji4acLkS/BTNQzYwy7Dw1HmLJEhaWQ+8KnNnD7uK3iypyINyO3iUypC9aMuq8hsuoAqRD7BptWLGgScijVr8CG31nboGUgsGhVc/EqMyiYyfAsHYAzFYsbnc9tm4BitmiQoNJj6UpbOkyo+DDi0zMPpmiQSxZmkwmTnJyCotwtnqiO+iy9PicQYp8Rog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aj3KXet9skYYmZuJ1RFhi80JF8Ngy4LwP2uvVKLNgRI=;
 b=eJF+E6hOs/KR/6d4Ll8jAjcZYJoZyHKiVJ6aMaulIPOkswT+OwUMo+sqCNfFShWbRrbq4Q44sae7MpXJ2BTd/gpqKqA27bkOmERneCEw7yzhwe9QHsr9TZz/qAYBX/pXroZviZSXwbrthKY9Xd/3W6Po1JTJeyV860b+yNqDPub3fMdlRV+YA49UApF2Xu06gPaOguBWqyKOTlncL7zsleaw7vgnT+CnoUPYJ475zTkdEGztsuilCkKLiXuNvawF5003IZer40PySM3Tl/UuZ1Vb46T52wQliVnsY3Q1mAX+SvKJ7IIoo/Od6y02nKjaEK4asVBnldR3fTmG0kVAgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA6PR08MB10739.eurprd08.prod.outlook.com (2603:10a6:102:3d8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 23:34:43 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 23:34:43 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] dt-bindings: spi: airoha: add compatible for EN7523
Date: Sat, 15 Nov 2025 02:34:30 +0300
Message-ID: <20251114233431.1920015-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251114233431.1920015-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251114233431.1920015-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0902CA0054.eurprd09.prod.outlook.com
 (2603:10a6:7:15::43) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA6PR08MB10739:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e5415e4-004c-49b9-8574-08de23d663ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jGfusOvAxWy+AHmZ/ouYL/auIylAaO5sVEp4yMmCZpw4vST+5eEAXK6B+SdO?=
 =?us-ascii?Q?O1wt9ka0f3VqRw2QHYouU0/QvbmjbyFfVf4JFRJ8ibylUJEXxks6VJJuvVwO?=
 =?us-ascii?Q?4YdeVLAPXKTWu/uv/EP1MVfYyFxIY6qhB9RO1dw1b3rYI2h6VIKUVQKkiMij?=
 =?us-ascii?Q?aEpV2RN15tbhUV5Fp8kX0go8zFJp9oZViItV9Bm03bwEgt/hZej+nDqzXoDD?=
 =?us-ascii?Q?8a4AFSCr+KUMEd3rLXlhN2cU4U/1FZJkwNuLwwZjnlT5NBhs3aab3PJ5Dm2d?=
 =?us-ascii?Q?8VGdxUgFQU/ny+5qjVRIuiYdnhkzutxXniC3dPWmc2Wexzu72m5Poc4VnIKa?=
 =?us-ascii?Q?k1p0mzcab0LhGN1grUjNSs0dZ13bq6+s2J5JAgptQMi93iZwMS2I4GXtf6Ry?=
 =?us-ascii?Q?E/yP6zEwHyxkAFLGTHbQxPnD2ZY65WhPoPOUTWiyBbPIYRssfsNWA7FYoL78?=
 =?us-ascii?Q?ZUBj/Q+6zpa12itVFGwghS4WrWJ6P68yoUKTBAhWmxKcnMfA3uuVK3Npcw6T?=
 =?us-ascii?Q?DeqHr3EUZ3uvj16EpXL9C1zwWL6cPPoiYQavxPCpswOJ1LMTLzodGrZgPLFe?=
 =?us-ascii?Q?+SARD9u3UfAbavJGruexJoHq9yUfzubu2b5EUHkBT5jPvM7kX2n507uZsxWD?=
 =?us-ascii?Q?e+QKGun0zh2mYsc+fPYCEbeUakBqceYl+IHy1utbw8/L2A0dfVMQ8dxZPL4X?=
 =?us-ascii?Q?ZSmo76CO+yZPVd0JRMWJpcnM/6vFx4OEdOq1M3IiBN7s8SwRa6OCLRBrlewD?=
 =?us-ascii?Q?l3R8AA+tsJB0Njvz5duQNdRF3RULbofKDOxJYnNqYxiJi4uJ4xTnenD+XlbY?=
 =?us-ascii?Q?XWQ/L0Iia4Cdmu6Avd2hXs2vBaBkWWHnd71ZcB4941JKKkudOzO+Y2krEe9z?=
 =?us-ascii?Q?CqdmGXYg63+oM7/WG2nHWkvEfej9tihaR3R2gCu47XS3rXGNjO4IPTjDnq8G?=
 =?us-ascii?Q?ev+IJaiXS+h2XkqI1S3OnWmmGr7mK+NP/01q4ADcbj2EVfSNcKlZL3y1OBCI?=
 =?us-ascii?Q?QXuWd6OCgAnP9dNNPOtJtMY7EMXXWdng+J+rEJQpdBTGN65yc3awS1msW1Ib?=
 =?us-ascii?Q?2enuFTLxnH5tvI4srf0I6CQQomK0f8/hczH8S9KvRK6Z47VWau4gvfNsQbjc?=
 =?us-ascii?Q?7EFEBRczneqdOkHS+XA3uzVw5aziIT90ty22iK+7dG0M7aSa5drw+7bjy7zA?=
 =?us-ascii?Q?5LXPLRl2P7Fk1yHrysEWWLnoLKAiTrLj44SNta/+rkuwhsnmEYrAjNtWeZ5E?=
 =?us-ascii?Q?dX3mwo81vcD5o0br7nZhAifQgumQmIg8avYWZREriSewYltiswEktlk+LVdh?=
 =?us-ascii?Q?yN1p1ZyV5u15q7iEbPeoKx0fSLxV1V45xfp2icDkBd3EPcWZbcyiJT7+ew8+?=
 =?us-ascii?Q?1bFRUvep7NBoCEZqxL+5LBML4sroLW8dL1YLsL3j0zdqUGyVzK5Vi3qyWBp+?=
 =?us-ascii?Q?nMqanJi6H+9SytjeMY96/mavgfi3xPQgZkPfq4x8/LNvQ9ujix5NKowKCMpb?=
 =?us-ascii?Q?X1/p3VGoiWvnoi949BeyA4TzOHzpufZkQ0rNIqYIZz1nCWYvBYpy4yoVFQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ulee1yriwbLEcD2yYgEJAjdvAXg+xZMLnKb/RFcXw6opFfh0TdYLpTofYlJf?=
 =?us-ascii?Q?GL+4THKRsAcsp7TXnl0sBhFQpkTbL0dh1a8ice53Ugot8E+5AFOB7Cru7PWT?=
 =?us-ascii?Q?JkXeAFrUffQlkWpnrbjrnkgTjUbX9aPzGjKeBXznl13Mz5048oQure1zQBRG?=
 =?us-ascii?Q?Rta6bvYorhdImAq5QAocIEcNy3pTOlYEyHEt3+0aa4+9y3UJNxI2NE64uT3R?=
 =?us-ascii?Q?QA3jgMAHukk8RUnc6mwfTBK74ZteY+XuLP3w5zffcHpiRQoFBQrLfZ01a3Rj?=
 =?us-ascii?Q?vlMKrMe27nLrUsIjXyXTdYWRtHyj+qI7CkFrsIRdF20qsbZxbZIu9t36iVFH?=
 =?us-ascii?Q?goTLRqLUi8TZKsgt6tVpI0qNPczkmtdqx7ISX5W5TO3gSvkwWELdf5qRSH9X?=
 =?us-ascii?Q?ayItiRnySH7zjzKnxAtt6NhyRStXE6t5MRmCTPNt3oYoPqacKNdmh3aJ2InG?=
 =?us-ascii?Q?pqj59pYRK8aRFNBVjes7Ey3KBVt8YJN+9MCREJND5ANLRKjWAWIGIyuAwGe2?=
 =?us-ascii?Q?xrVug39ZNH0cHq18mbpoBUMRuT/HxIJtDGcNrGtVdyKouLxK7OUX61IcJcwz?=
 =?us-ascii?Q?omiJ4SAG1ey+67YJ4PaybcA6wLneCEt1SeZe/0sw23fEqPJXPgCu6h2nDNFi?=
 =?us-ascii?Q?fOIXjaL694BhATQVXET5aO8jkgz0CFPuu9LnRqsS/8G4Xa0xKLSphd9J96+a?=
 =?us-ascii?Q?bJ61yVLxJqbVxbaqOGHJq9K55Y88K3RQgCWJedE8xNUE6hThnSkLnEUi766T?=
 =?us-ascii?Q?bbbVyjsjIBbZnk2kv3P2EcOqVvbQ26uAeRkn8lS25h3C/ytQgjQoBASCA2M7?=
 =?us-ascii?Q?ifGAehY6nMk8EWApq+gdfLQkxlEVTJ+G2K7BNojbZV9Lalhe9lblnhGjviGq?=
 =?us-ascii?Q?BU87nCJGzd2IcDo6lDApJEZ9dxryRuDKm4hTRTkMhGe2wehca4nAfk1TBdPQ?=
 =?us-ascii?Q?85aVLQIhyCrrHKmggblLZA3CWSwn1fmYCsUoKRWDkakkVQYIPRkyUKccWZ0G?=
 =?us-ascii?Q?evrf+6Bry512g4rA3fyfH5cfaAl1CjU1E/uGS1wNnTCXPQ+tZLu2wHgCz+zl?=
 =?us-ascii?Q?Solj1aZz9rxutlwddY9KP4iDfRJsvzLKZuy7tVMZsdZ/1/XWpuglgVJ0nTML?=
 =?us-ascii?Q?EeDC+VTP9bD46jDP/cAhGxXwDvQk3P3LjW7UpPMVF+Tb0SGZpTno0yUnIybd?=
 =?us-ascii?Q?w+aTxS3e9Nilb35DJuSrC0Y8C1BIlEuO2+CEkEmwtTKXR1rJY48Oj3Qno4Ia?=
 =?us-ascii?Q?RYuYXdHfRO8CP+k7eFmXukFDY2cnAkf8sPT8r/7bYGxDdX6VejvY/j3Um8+/?=
 =?us-ascii?Q?qUsduKKpyPSjtV3yuMPcwj4uNR+OFjdSpqa1xmuW7I6Nc58bOpSw2su8Kqfd?=
 =?us-ascii?Q?LgGJ6zHZd76QzWhdWkBEqRNGN6a/Ymw17dbsqr+Wg2OzmzuMZyTG4sAgOwpn?=
 =?us-ascii?Q?9HK0V13SR6OvJ32ELamtobP/jP4TdVvZ3yK4zpNH47zMYdkGJqUVjKa3SBok?=
 =?us-ascii?Q?RWfQqNN78icgh48Mgwg9XbSSzpqKYEAA363e06UM0V1tXl5D5DzkSm1VKJxX?=
 =?us-ascii?Q?7XpXXWaI8Lhlkfp4iBtyoi816UbZVuxCI+LZm/WMw8S7YmTkX3FXeBhHQ5L1?=
 =?us-ascii?Q?3VsTnS2F7aRufzJ4LFetKJU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e5415e4-004c-49b9-8574-08de23d663ad
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 23:34:43.6937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PNqiM0WJItvqblH/glwpl4dJ4tIi8fJSKjkO2CXciLX1oBdbwPRpawpwJGxJjlKNebjt3qvmiA04SK1sM8pMjrCK2hNTbSneHhd7CmPkVUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10739

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


