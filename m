Return-Path: <linux-spi+bounces-7465-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A610A81A37
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 03:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24ACD19E8997
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 01:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1272AE8D;
	Wed,  9 Apr 2025 01:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="L7ZKMI+I"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010042.outbound.protection.outlook.com [52.101.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1E129A2;
	Wed,  9 Apr 2025 01:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744160710; cv=fail; b=f7L5MMr+lT7Ir7c/xy99qPWM9bHgyztWjc6+7rwxdFhy45tmlYAYzyBkJOOUYG40HWVsmDCkQntJ8Rdz2HYvuRGEh7DyTyEvYuddcM+72TxBLE7a5M14FuPAvtBAJsamLONb6rNsz3/cbbRb5TDEjK6vDiR+1VlSXGb37EODrJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744160710; c=relaxed/simple;
	bh=Bn4jwa7I/XaRIOQS5xWTCzj+N+yIlM9NSzFpkx8Xm5A=;
	h=Message-ID:To:From:Date:Subject:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A78e6Xgy9d+PlxB+drxxP/miI52EATJ6RaIwv/ah0LGfEb/7p7YAzioS8w2d9P7BjMyvV9C5G8tzUU3nfoO8abc+12DhyX+hm4CG1oKJOdKOneMHYcf1+ih1GqyCdZRvnkXoKhETIzuak2bAzIZx/pSBVaRbXxBPpvfyMl9wq+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=L7ZKMI+I; arc=fail smtp.client-ip=52.101.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9KaZgUOj+nCyUPiXBfHsvksOidCRgtdR9Aj2W4YyNezcLHaB6a6VUukKMNOU5/yE6uz5O7sJlJaz5aO1NP+Ksra0Kf+dssFhHfBukCHamLbMWfHJouH8+Rv1ZdD+4uh5t9g8wp8CvghH7zVonk+fCo7DQ00IJ88xQkc3aO+NjnL1Mi63sz56wO/Abduz7I4N6GMCwvqWDC1iHOecJ3YGZtSUzNAiRuYR2umzGGBLBVRbIMygMXk65pBcqoNFZ+GMZ0iEIZ6FnUzymm13nt4Ce45sfIFLN+Gg815KMaLda40lcVpSLRqL0WZQLhz8qhDubpFjpMaMVcfOkoeX54rjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXkUxxGiTuJZzg5CcoRAyGQzXYQmoV/DU2d/cJCg5eA=;
 b=I9QR5cuuRwC/9dweV8FoSHnBj3zmXuD6sLs7MjdGOiN8VsLeSpg5ZRAJUlwmtBY5RV3MbDJMyipSlhTdIsCP9ZM83T54S2xcAFhmqM3IrHAHBj3U1gX4GKuTqx/PgRfpPWlsIhbxt/1m+SQCVoX5i50dVOcidgicRYx8CgTlm+YsLzVdQR2uutdesXaIOpWzFEqgaKOAGgYMaa86T3uvkMZmxYufpDVhBushB3LrvalMifBoGzw8t/JqFtcOZ4IExnT0nBexqJ39CQiYomJltpjd/ryVDV0sITA+BJQ2EDWWN0ZyAJBDZ8fXe02oLlnRhfhUUJ7dij57dl7/deeXnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXkUxxGiTuJZzg5CcoRAyGQzXYQmoV/DU2d/cJCg5eA=;
 b=L7ZKMI+I6nmbLZSGQ8S0H810bWEUTh7YwtsWlp0EjvKCMoF5o/dptjY9Zyl0WjHvuRpjvqO+qDd64I2J+1qP53iykEi15TpT6PYEoEI7NPfnwqAUbR7YDZi4BxguaO6efap20gF56GxMgD3ZGG5SIzZm73zseeLqShPHEYSr8IY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OS3PR01MB6437.jpnprd01.prod.outlook.com
 (2603:1096:604:100::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 01:05:01 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 01:05:01 +0000
Message-ID: <874iyyb0w2.wl-kuninori.morimoto.gx@renesas.com>
To: Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Jaroslav Kysela <perex@perex.cz>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 18 Mar 2025 11:06:33 +0900
Subject: [PATCH 1/7] spi: renesas,sh-msiof: Living separately from MSIOF I2S Sound
In-Reply-To: <875xjeb0wu.wl-kuninori.morimoto.gx@renesas.com>
References: <875xjeb0wu.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: TYCP301CA0038.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::13) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OS3PR01MB6437:EE_
X-MS-Office365-Filtering-Correlation-Id: b2546a94-454c-44fe-fe39-08dd77028e47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X1zl1Eh4HCB56VFpBVrtx97DpKxMjJr7NMT5NfyYxXZjW4HSdHbq1KyrbxeV?=
 =?us-ascii?Q?jdQeghI2YN7sGnBQwYo8tPvvaB4kYnKjp/KfAu1YSAueWH1r+CXTEYgZbwyV?=
 =?us-ascii?Q?KMEMnYK/Ce3c5E2StHtgRBNxO6f9NsnPuoTv1kMq7hTiQToHSwdTH3tBZ0xu?=
 =?us-ascii?Q?NcLeb1CJPgpjxVRsstJm3hx8iK0OpMp9cHZIuOjm6TghQuepKR67Rfc6zR8P?=
 =?us-ascii?Q?EUHfk6New4HrtXSUU2k3EWkYUGjvgYx4gmL/cxYPi6tBA3mSjNlZ20HK+aHW?=
 =?us-ascii?Q?ie5HAjBJjeOsCgsh4bnnm7OQbHq+P+IT3w01TMfaoqy86ngTTHujBssPhntT?=
 =?us-ascii?Q?+wMMU9N69da4xOja02uS4S1o7tNoVxljA3+KpiipAHSqxPJW6bGr4/Igbh7H?=
 =?us-ascii?Q?uwGZ7Bz65qvGJKMbJtCg3rL0tpjatG7xyY4ttdi1ozOvshJ9RbYOF/Cc03jH?=
 =?us-ascii?Q?c0pCUMyyYcqgNrx9D2rQFsquMfeMwel0fsq6fxAk1yNT2UZJ02jICM4NKUI9?=
 =?us-ascii?Q?YnF6GF3yIwviMXmCdU6I1j3raVEfA3kaXvOj3Basyi+EEbepaj1PqYzZo63A?=
 =?us-ascii?Q?Qg3hapVD4o68zMAc02pF72oclduJo4yzAUpBBTEj+7oiqaLLesskCsoqkNXl?=
 =?us-ascii?Q?A/VRfqubs86YmjcWp4ctnUyRF4orEEFfenAkStvnr/uNFZSg5g0BvAeWlA8r?=
 =?us-ascii?Q?vdQuOlCqVK1LrKJggLAVyY1WL1j5Ml0+DAsEOUicA+FqQef4Wzqk/wE8OdR/?=
 =?us-ascii?Q?FSGhaNA5y9E+45aC7ZVqkLfsZuizTg56CEayHuzcGn94xHitBvezZMoRB/uo?=
 =?us-ascii?Q?U91FDNRlq6OO4fUxdJzYlu10T5RdeijKt04vFdvaPtkPzRP2h1nyBafwmLvj?=
 =?us-ascii?Q?COwnduy3zxVxcXUpmwSlhKFEE5fQIKtQrUepNryBlZPOwmD995rDENATa8oQ?=
 =?us-ascii?Q?7aP9z2ydFgIcgMMnQxwQl1OfsZ5IMqvXgyu1LCKFRFSQZ1ZNxr56HkWK5vRD?=
 =?us-ascii?Q?YBtSxoONI6BuYQ/HCRQmjYZn2yO9gwRXdezD3DLZmye7q+D3RgeVmced9APU?=
 =?us-ascii?Q?REtyaboIQzZFKBFHXM6kbe0vnS5oqm2Ww28DfjKaq2c4EOdNDneNEBd+dmaA?=
 =?us-ascii?Q?Q3zwU3zUg4h/0Q0Q0KAMyGrOFuhNPedIrDJs4a6DWsnR/qqOaMa1ztS7udQK?=
 =?us-ascii?Q?FI8zTsXWHiMq38NFANOMYPJHZRjKq25d6m2GgJsVSCDcdwx7MiGns+62BhUm?=
 =?us-ascii?Q?JKVRt25H5alJsaHowtdkXFNBrRJe/BR99Ds9MfmNcFegJgjnMsAOhw/7IbE4?=
 =?us-ascii?Q?Arxq/l6DNB4i/vu0fYsohj1nJa6w6qXfb0G7HX7ykI2/nWKTNGEWp4NKLWgq?=
 =?us-ascii?Q?pnZD9kzTXnPZAvqi70XOi+Kg8zDfEqZZV3nqlF+43eQi9LTGX8xiYaCzDODc?=
 =?us-ascii?Q?HSCOBWQTtNvXdgnv0TlRsWrjxqdQjxR7gKGCFXojDVv15+WxEN2Hmg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5rJsaIGk/k+MCtF69GV6HpgCZY58NSN+fp50bBhfnoVSvPf0mGWYdONcRXOg?=
 =?us-ascii?Q?RScZQmc2IH5TkToNctYLauLLlJI9NCdx09CR1vQsE97Q/X01jMJZKXb7rNUc?=
 =?us-ascii?Q?uAoh7Gl2OY4ofZFZ/cojSVfZUsc7O0RZpudP8XQn+bRk1XcUo39ROIyfgch+?=
 =?us-ascii?Q?TM884z1zWRTObgROcil/LSq1v2W1DtgRCSz2Z4aldnC00xnlfdhQAYGtthMz?=
 =?us-ascii?Q?egVEmaLaeNWImmaplwf076yb7HogsCDQnQ0Ijcbq6w/c3jurXhaM6KYMtLpK?=
 =?us-ascii?Q?OOOE03pvJ0I8/Mm7l0hq++ZX+K+Zs0FNh0r7XtAKcAtFRjeT2kQV1qEItfRX?=
 =?us-ascii?Q?f+2FsCAmKdB2UQeshSEifA9oNelV4Dr7x8PEz3L/q6fuBI8Ggoi7RhYXUnhk?=
 =?us-ascii?Q?iPdugjxXs8hxm8njVs7fVzxkH+GT57fMZM0RXrBAzKNa0jiNHkdCUeQqmbDo?=
 =?us-ascii?Q?YRaiM+k/pe8fLgQ8aQFNBWK8qOAiNjP1uxueiJtL83ofp4v0GoiYPf0A1JNM?=
 =?us-ascii?Q?CT98gcTKJjT0uQNF1vfJa7/LnC+mOg+KvK8KdTL3dIVuEKQMuOAwooGydchl?=
 =?us-ascii?Q?v2hMC6nd/0V6GQdWYtPgVXb/k9HhMNqV4Jl524Cwe/9wKrFXzHlV+kzZSfqb?=
 =?us-ascii?Q?FVgaC6T20GmrjiQxGeYRtleRrH2nWGmvDFaHSV44935CmRT2PyrOWSleucKp?=
 =?us-ascii?Q?m3jNxILONxJVZ+guUpgPw/srCpjakErj+wa5+Jw+ZhxdEq3M1TEg5l8vSdt/?=
 =?us-ascii?Q?SislFK5su8OX4itHbtXsL8S1fSqPu40B6kXssqSgDC2e6T99wOHSGRhbEJSA?=
 =?us-ascii?Q?CEwBLiM7TVR6D/giTp9fjPryHoerkHjzvXa+AWlW038pvU3kGu9MU1EtWyqh?=
 =?us-ascii?Q?JKxWixJ2fiSPRkm1DuiKhW7wH7EN1Wyjx6gU8uJQNIGqhzigZmLt33YzlUr+?=
 =?us-ascii?Q?aM5mahiz0yIj75ujW5bi2sWm/n4QLTCTDe577to7ySumUPyI1qVBoZzQU5X1?=
 =?us-ascii?Q?PdH7AMy3gWP/ujVaQQ2e+5EX0PWmev6UHo10A6H2wwJ34OCWmhjpeLyxEEOq?=
 =?us-ascii?Q?i/f/6/v2oTdy1Mahsn8wGfnCrqrZQp69J23MkhsEb5nwV1L/UaJ4udUxvGrm?=
 =?us-ascii?Q?h/bUp9VGoIcko+045rjAVM6xGepZTMOrXStIp5DtBPih5oDfUjqNHaA95aS6?=
 =?us-ascii?Q?xQcX2eFqeqS9nyfiAUx09Jfi1O3DBeuNxLzn42ZFkI9srOYNG+849mrfjUv4?=
 =?us-ascii?Q?p6UrTg64kC84Lc45QA/gfJwepvof3Uyk8UHM/X5pb+SmUKuexWOogxZxtDh6?=
 =?us-ascii?Q?vyrlz3mUd2vlbkZqCFDBky5o02yfvehjw3lyiQaS0FE2A9iBGuvRDS2+zJXQ?=
 =?us-ascii?Q?bucuq4n9QBDBPnWtQ9KYQ0xfkPH6/uYR+AiWZiZwp3dcJxy1fUy8rL7nHqSv?=
 =?us-ascii?Q?yc0zqSjX996C3Cx22dDj86VyFYdnAGpdfCQxItG3d9dWt0Blu3A65OYTTYLP?=
 =?us-ascii?Q?5672tyC0HJltgjLP8RIurGlK4Ep7Ze9C+IYS0aSzjbOXjNpYOZdvK82BzWfB?=
 =?us-ascii?Q?n+bxZEI0i77t7PWAear7cYi3JoX3x12TRIV5Kkig8M3rfgPrhnKn9csajIDQ?=
 =?us-ascii?Q?EMztTnVa4mnzBw2tb0UVp6Q=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2546a94-454c-44fe-fe39-08dd77028e47
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 01:05:01.8451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ApzvNeKe+9hw0Y0+Inv2SrP9VBcJw8jFkYOCNFCTODLrpixI2jsULFLQ95ybZKchChYFihacxmS4GUbFNZ3SytfUH5hE0t+AJM8jqW/5EWQ7bg0qEFel7nyrzIW15mfR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6437

Renesas MSIOF (Clock-Synchronized Serial Interface with FIFO) can work as
both SPI and I2S. MSIOF-I2S will use Audio Graph Card/Card2 driver which
uses Of-Graph in DT.

MSIOF-SPI/I2S are using same DT compatible properties.
MSIOF-I2S         uses Of-Graph for Audio-Graph-Card/Card2,
MSIOF-SPI doesn't use  Of-Graph.

Ignore MSIOF-I2S case (= Of-Graph) in MSIOF-SPI Doc.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 .../devicetree/bindings/spi/renesas,sh-msiof.yaml    | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml b/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
index 49649fc3f95a..c491ef5bc78c 100644
--- a/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
+++ b/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
@@ -9,6 +9,18 @@ title: Renesas MSIOF SPI controller
 maintainers:
   - Geert Uytterhoeven <geert+renesas@glider.be>
 
+# sharing with MSIOF I2S
+# see
+# ${LINUX}/Documentation/devicetree/bindings/sound/renesas,msiof.yaml
+select:
+  properties:
+    compatible:
+      contains:
+        pattern: "^renesas,.*-msiof$"
+    port: false
+  required:
+    - compatible
+
 allOf:
   - $ref: spi-controller.yaml#
 
-- 
2.43.0


