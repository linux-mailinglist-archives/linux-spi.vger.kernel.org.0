Return-Path: <linux-spi+bounces-11493-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF6FC8312F
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 03:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A99A63AE7B2
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 02:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B331DD543;
	Tue, 25 Nov 2025 02:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="ZAkLnw5N"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020129.outbound.protection.outlook.com [52.101.69.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E84B1D5ACE;
	Tue, 25 Nov 2025 02:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764036678; cv=fail; b=XkWUzTea40MmEAiHQJFSzbSD5for4N0sn0Wn1UUSUvYms7JEZlPXrAehS3Fm4HlszjwFkUY2+UocBIyyHxbl1LXtMM6cjRR2EIdWjP8fjf/BivJvMDxaU9ZQCmGFW3p4F6/wDTA6FYhSCC/58iPmMNZZYiuEeGPClL/NullSnHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764036678; c=relaxed/simple;
	bh=nvzSbP9vzHqZ9BdvDElbSy9zjtNy+EQ+e//hLD4/DeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l2UNnfVkZ7SuhCUZpCm/x5Er2OieWRaTI7IdqzYqYxGsVe9zzZhhtYrhMbClFewXFs4SsmGgeYhP35HuZHo8baTozFNFWsJAL/mn719nbeVLEn/Jl2jgC62UqNb98qmzV/XcYNvLsbqtIQMkMllaHl9efODJw03bPT0jbxyqYDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=ZAkLnw5N; arc=fail smtp.client-ip=52.101.69.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZM498Vx3t6sVkjAloSoJon2hQ0CGJvJ3Ypw+YHW9GHBBbEkWJiVFULSDNnM0oWsDaynwB5mab9M252sTBZl88ElHrUYOwNuIeZgnaqFWeRJbQ2XcQYcLR270GZB86tNmk7sGdbASFTLJaYtzxw1P5ZoaPayNlDMdUBYjUlQibtDIVzUhr+PjgMIyu76TFfasF6u9JjnL7xQo3/uGyCyJXAJ7GZoYZdk2nsg+l0UR3gAs5srbe1gThKDR4mLEADVmCTb3mJRIFf0hk/ClmTl+AZSktHe2I79jAFMz3mGwz81QTNJB5MP/0+nKX/Ojqv5gkgN9eDPmVSiAy6dzqtM2DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aj3KXet9skYYmZuJ1RFhi80JF8Ngy4LwP2uvVKLNgRI=;
 b=ij0vEw2JgpCN3fVBkNk9hhWkukwf9wx8r+c1RgQj7U0ArFjnyyR0zDXGq/qOo60NFLUqXh9ZvyXNFFP8bc6WV4azpE+vqXJd3W8f3o8jWaxe+f1nFgGASkNk4fKPdxUwSu/8gdziQh8Aq8FGf1nzx+A/2+ScATP7fzd56mHVmRmrJ6lvRF0u93MmhNEK3EEE+V8rsSLu5mi8JhRipCdAp83uiVXJ4PGgudruYTLfCEfEDryMWwV5ceu7oehpxyROQ2lVJMRcwUg9DDzn49H/JyjfkCdISf1IUFwb/0cD3mAd8j0RavSIvGGHHu6UswCw8TpjpGApKPbwGUjMyV8h2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aj3KXet9skYYmZuJ1RFhi80JF8Ngy4LwP2uvVKLNgRI=;
 b=ZAkLnw5NUvIMfSXeUnijmAXinvI/cihaTyiMleGRcWwgC71DI3xpWwd69/C/qupalKDiwoHtmkEMVaa6JvCRbdaB7OCI5yLhJXMm99fQBGhgO9fVROt1nhaD5JJkCeFhBlFeY+yD8tenpFAi4QChvWLwwgSDyDlrNNt0QKpWlUwHR0RiZmf8c41P9o9/2qxhR+FjiUe1VJMnO2MSQR61PTp9Jt4oIcy0nyw9DtErUciE7Mgcm2yKhFCRvd84VxezGgrxTqXQgDPA1KihywzGW72URrgcrNrhoKq5GNCPeOptZV56Rkp1gLgZz5cACXu0LG2wNnOyxyAbkMAZxJIrxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GVXPR08MB10638.eurprd08.prod.outlook.com (2603:10a6:150:14b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 02:11:03 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 02:11:03 +0000
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
Subject: [PATCH v4 2/3] dt-bindings: spi: airoha: add compatible for EN7523
Date: Tue, 25 Nov 2025 05:10:50 +0300
Message-ID: <20251125021051.857159-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125021051.857159-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251125021051.857159-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0099.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::34) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GVXPR08MB10638:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d3cc8b5-a544-4af2-eec7-08de2bc7e294
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?syv3wnu685FOlcNbY/vXQL/jW31Lw5uWVfNVLjqhpnZoUNcYELdv9LlqNqs2?=
 =?us-ascii?Q?Qi/QoiJS1tD02dOZdXN8FHOM8BhvKsA6GkDt8u8BDNRfy91othNUytlfqos5?=
 =?us-ascii?Q?yZquy7P2A10qTuX8rb3cyi88Vbide+/3EXb0urQ9z8qhDfkFdiNH1z3RB6CH?=
 =?us-ascii?Q?XdJ6PQkuHXcRRhScTECy39r/L8MKVYsgSSt1uN5iJhyFnCgcgTmABF6S4BYm?=
 =?us-ascii?Q?nqwfzeE8uyy0Ndk0KDd4T8kN4Pmo2x/6jJxux4j9VcCyhas9ZFwLiKSGfS+X?=
 =?us-ascii?Q?2N8zXBalS9x8WA73/LigROICZqBxn4TBuH1fXUKKe7cHGyYRCRlXN96Ylb0n?=
 =?us-ascii?Q?O6dd44z4iw/jf01PNx5LCS0ZUo9oGLGrNIebMiZ7xGL5rumQ1p3dX5ZU2DDa?=
 =?us-ascii?Q?ROPbLhTGkMlYNtZCLPYntc6IZkAcCgN+W7xKhQ5JxmrMQc9KbratvhMw8uH6?=
 =?us-ascii?Q?5+YE/B5Ibh7drsyZsF3o3CCx/x3SWX2NOtz0PgV/1nfSVCc+tortjVKJUDSH?=
 =?us-ascii?Q?dLwRnqEasL/coPP0nsFGH5L/pN4vluVZhjP9H2D9RKcbnu53ALh/Z58DjFty?=
 =?us-ascii?Q?84HwtMxbyebP+U+Azod+7UEYgRR8E7nFjqB+piT4phPuEjOwyMhBv/mCtlg0?=
 =?us-ascii?Q?LeePlJt1/nBjvUplr00ki+y54maEgAmV5R7a/kXsrwUPzbMBMKjqZvbOF+pU?=
 =?us-ascii?Q?umZuuFwMEk/k3+rqF2KfqjJ7JCgM2GpwpwkKqdomq+ykb05bRMY0TxUWeE7O?=
 =?us-ascii?Q?d9oF0emgcvrvgFnHeOQSBibs/mgknFwB9k9QqN4zmCHc/UlH5DHs6svv8O/J?=
 =?us-ascii?Q?ZEU/eVKvkEf3nEz/lXqqUftV40tkWqCPr33ALB5ZFEr6Y46KF//KWb6/M7da?=
 =?us-ascii?Q?pY+LLOmN3fkuSBwg3TGnSx96syFP8/GNyRHO/+UE0fhsU0R4IXnwdgJEkG6+?=
 =?us-ascii?Q?Be2lEXtIvQUmhULHgo7PQT85lzQ1WWnw8RK3+nxwQb4foHT+IDQj7rPSv4bH?=
 =?us-ascii?Q?Xo6IoR1WitJC49Q6NQ4uV1MRLiq2aRzbNRYyhUCjQtRdwUAbKURyIQGddkud?=
 =?us-ascii?Q?6qOjWwzKazL3G47nR9QeKyLKi8glXviBY+SNGhVybbowwwgIkBkR8m35q0kN?=
 =?us-ascii?Q?41ytjLrB99wvxgV848lfSdxB9usL9VHBdVHi5nRXFIsyk5I2wAqcejMUj9r6?=
 =?us-ascii?Q?7NKsaUAsTEkd7rMA65LeWMfb4rSokbo3dwTsVgYe/88/1lBlCznIlBrQVQms?=
 =?us-ascii?Q?6Sip8+xTbPtq8L0wKRrmJ+hliJMd4qUlywBBeqMQeFAxpEI/sU57yIjQRdIt?=
 =?us-ascii?Q?AqwFoXlFE+W1MCxUx3qaUrBkVLP3ZKtWjgkpFPAKSM/F9P6Y4MGJeYOyTcz3?=
 =?us-ascii?Q?pNMjCASFAcnUG9YP+h2m92QYJWXGYZlg1hodFBKp0EcDSz255bwHaYbEM53y?=
 =?us-ascii?Q?QCeai9zefD/bPHkH868xK3j+azRl6xOlqeo10YHTI1tpDiUlc6Ttw938WoFI?=
 =?us-ascii?Q?g4A7kv8td10yRYnqKraHkH+vCWN6CV6yG+rZtvo9JonqDcfLWHPXCjDRcQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RDaTex0UebLaP9XdVx4HwzQnt1GIg0YyE1Kvhd8Mn1ad8kjO4wmxvudA3t/6?=
 =?us-ascii?Q?WVBx5ABf9Wuneyn7X33/QVybMiXU9ppiO5hiGr7RbNM/lGHhIhwmknEFw/aX?=
 =?us-ascii?Q?36ZFNiaC+tvbJDEnMHceg+rO48ypUauRCrJhRTsVvelSsQOzLriBXv1uGvml?=
 =?us-ascii?Q?Nq4U6RtGAI7B4xQlaCaK8iYCAW+HaLQDYP1GgjXMqF3GwkOjI4/716FMRuU/?=
 =?us-ascii?Q?dpV1GsvhIh+fnDgiz9C1EUeovzT/r0V6VvhSf5a0MaZzhnTLw1TSQrOGLjKg?=
 =?us-ascii?Q?Ihtv9L/L1b0P/4pEumJEvWR9Tx8Slg8iU6JinegsWC8i0iIyQsHz0Qlxbdgd?=
 =?us-ascii?Q?JvGXeFw5lC08mD5rxvs++Opxc6jpbb4LXmtnukEjGOHW1q2HeKFZxBYDsrCw?=
 =?us-ascii?Q?xJUxUE2cQLWLjYWd5V1AiHQPG4l/wK1ukyVGXMBVWK7XSqKZL9RSHH+gWh4C?=
 =?us-ascii?Q?e61vYe4CId/Y6qwqma0+W+iJABWM1/J+X79A/8WT4OSe89PFfqPLQgrQAAt2?=
 =?us-ascii?Q?hdzITFZRt1MBaD6s4iK7XXO+IKlVCuX1cqXX9tT7MyOnSLyagGLqBJhLGuuU?=
 =?us-ascii?Q?0+Azu48SeTC6+0CF7XTVbLswnrvZ2fHHbbfsmQpCUZ28cdp/KuvDSG0sIvS+?=
 =?us-ascii?Q?afODHbRNmJVlWLQBRqyx9xm98YOyR2uZcgMvdAZ4oay1ZvlMia8SYXrdF+QJ?=
 =?us-ascii?Q?mlEPn8GpeKV7q4v9h1vQ93o2s8A1u/AfprS4LiycgmG1PL0qXKwXf6GL0xX5?=
 =?us-ascii?Q?OqxjpSa67TDYlm4ugIkE4UUQgQlOruH1qO2up12qDkH92BJWT77ldKT7wGdU?=
 =?us-ascii?Q?P2fP1ovYyDLB/yud5/hf2Q6ZGG47fes+WUF82vfZ4F7JvnfQpCiawEympDmI?=
 =?us-ascii?Q?K1728OhoVNKvAtI0dzeOjl7vP0on48XF0CD8xYy5QT8q3wII3KKw7E43ZaP7?=
 =?us-ascii?Q?2LLzjJYM2RsIsxs7tkyWSpnpLsKKAI+x66pOYweZZ6V8+l+HEbeTg0z08KIp?=
 =?us-ascii?Q?cVtW0w4aKvj6ercI0MMqU8h8s8s+GKMTUS1tV2guKpF6tFmuZb1ZPiV4TFYB?=
 =?us-ascii?Q?8q420kdYYgoCgjuCNeUUbta+PKldbFDPi/o9r831xb3GUad+kdZWcUj9yvXP?=
 =?us-ascii?Q?k91NgNHZeOHedaScuOgNiTD0u5XpgI7udLhYy9lL5HyupiG5xc6nE6Kck0gr?=
 =?us-ascii?Q?YzXhbYvxebeQIuopvtkTZdOwlCinJfGX6aZonzooL64xz0GhMMR0UnS/w+cm?=
 =?us-ascii?Q?V9bA4dLZy7G1vYtHsdzesuZrOZLfTGtbY/lkKxy+BSjj91nBdGZ4vq1zIxg/?=
 =?us-ascii?Q?8gXS4KGFixTJLXKvCYLuSiEiJcD7sEeqwXpOUhOnkTpxcaMyJjT8HGYARlDe?=
 =?us-ascii?Q?aRe+DADSJ2wbL8hoobBGiU+ToV6Dz+EutQoec4k6L3bUcx/IKFodFMmrLTq4?=
 =?us-ascii?Q?xcjd6wu/64/XFq6GeLUbc4Ka8KLxs//frTWfGIRElOKfsQuy2WUcjaVipE6r?=
 =?us-ascii?Q?/6XMJvGRcb20BaRSs0cCZOd6ho98+NVcI0jZVqvyHoSKmW+Ii+3foX8P8Cop?=
 =?us-ascii?Q?oDu4zeCAyNta85EpOJLrUjdXJSLd0EviucAI2N5EX43yJHJM2PMuvAWg4n0P?=
 =?us-ascii?Q?+2+HBozpUoyDaYSuJ/Q/sV0=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3cc8b5-a544-4af2-eec7-08de2bc7e294
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 02:11:03.4703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jsmrL2r+Ro4/lqdXPxvVXHUMKr7ptQkBmAfhkz9c8hNteSrMAofHxt3/5lo5F3n7pg2MnjzlW0ob+EsryTx9uQPdVvmDHwcgj2ur8p27OKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10638

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


