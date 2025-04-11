Return-Path: <linux-spi+bounces-7546-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B56B7A850ED
	for <lists+linux-spi@lfdr.de>; Fri, 11 Apr 2025 03:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66F158C3EC1
	for <lists+linux-spi@lfdr.de>; Fri, 11 Apr 2025 01:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB8D26FA4E;
	Fri, 11 Apr 2025 01:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="R86NZ/kK"
X-Original-To: linux-spi@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010009.outbound.protection.outlook.com [52.101.229.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3244B652;
	Fri, 11 Apr 2025 01:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744333452; cv=fail; b=o98BCk99yZWTy1pC9yGuKAsHGWeLXPQfAcsBEkj0Pl/2jLQsAwy5s5Rzo4m2WJUqnOuCh+dGA24c3ExJNH8nk5CCIOiA6HQQcmnw1MJV9yBqWBfCEDzglwiNDXqqXJSZWftTI5oYFGlctvO9PaFdpkxFi+eA+3zl6pf0IYMkgGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744333452; c=relaxed/simple;
	bh=y+N7lH7+G1jLLrzlhbGBlxZEc3YumXvd7Xcd0GQz9Lw=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=sn6NdgsY5dKmoiezScK3B0e9ztHYZvrI+yCCy4Mq8jy79ppNimJL564U6NfKm74x1sjzI5eE2fhMrr82sz7JVy4qQQdLTwjkGzIJMwUWXMbM2BZwIZ0DgJbLOJKcYANfDgbAYfQPZzTlNmEIT/1LtDgAPxbJk4HK0y3qQiuVyno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=R86NZ/kK; arc=fail smtp.client-ip=52.101.229.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m4mjDyY0WGwklU5i4+hZE45rad2wP63nLUbJOod27BGDFT2IBg/vzIwo4IDEsPDSbHp+sR7flNKUg3k6HdE0JV62GodXjTvnQknkdwWkeBQ3yVlVk8srtrZRzQwyhpFpeYIjsCEFaMCOnU0gCTddUfFWRXEP+nDTHwVwcEuNF2y5OejCu19OrQ1H+kUXW1CM6ubkSWnsJvUgaL2K7wcAjn84hpOkRrvwH7ISIKUdReyfQGoF/vykwx1fLBSLHqwI3bB0ZSo/wdaH6lAsJMP21WcFjENO/iwdHF3E9ynWe3CmuvasvsTjS66G5RNSpatB110k77wBPoJpReM4IOv/lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/u/JvugkOUZttkGE2186WKeTwPwDY+rSpw353/7s2to=;
 b=Y+Y/9QWpYDOmrnGraNnaEhQ5b2B8cXvP1VqqA1hy7Q2p2wkC0N05vyq567hbpFBkSSDjUaoYqxz3i4sbjsJad6S+DsyKwBuf9G5OLJg19mkcwx72h68BOTRlwxV/NJuc+WS7uK8mvB/5o5fztKXMGgAGNzPVnAP8xWUlxaAxunSiNpE64rPcxOOiZ/r7/HGNnicLI0lY3h2W8+AUVwwXZeM48zw/qpX6/pltGJl5kyhHQPD87/DyIZSKcyT7ANvHEVRufROYkT3DEItWfi7/MFYMJIIld7IIBpgY/HQZdFswRcwtin57cfV8vm75b4YC6c1AYtdiHdz4sQPLEuXBww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/u/JvugkOUZttkGE2186WKeTwPwDY+rSpw353/7s2to=;
 b=R86NZ/kKtaYsMqHHOhIulNCJsiZ58Yr9/qO35k9FgUj1ogQ2vflUcqyDSP2GgT3oRf2oPinsDgoOTR87+BEIH+ShEUblQjM0fOrQf7J982RktOJa6zDjT5c7mqiydBI+HnukF3uN+/W0Imvs5F8fL61Qe9PML6SsfcDTMPxC8kA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TY7PR01MB13579.jpnprd01.prod.outlook.com
 (2603:1096:405:1ec::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Fri, 11 Apr
 2025 01:04:04 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8606.033; Fri, 11 Apr 2025
 01:04:04 +0000
Message-ID: <875xjbh5kr.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v2 8/9] arm64: dts: renesas: sparrow hawk: Add MSIOF Sound support
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
To: Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jaroslav Kysela <perex@perex.cz>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Takashi Iwai <tiwai@suse.com>,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-spi@vger.kernel.org
In-Reply-To: <87h62vh5mj.wl-kuninori.morimoto.gx@renesas.com>
References: <87h62vh5mj.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Fri, 11 Apr 2025 01:04:04 +0000
X-ClientProxiedBy: TYCPR01CA0066.jpnprd01.prod.outlook.com
 (2603:1096:405:2::30) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TY7PR01MB13579:EE_
X-MS-Office365-Filtering-Correlation-Id: b82be94b-06cd-443f-b7ab-08dd7894c0fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cS+U66LOC5V0KlQ351PEzDQLrp3BB8b7Wq4U4JOAzSNhDT0zzMExROgdKuCK?=
 =?us-ascii?Q?lzgdxtQuuFgu0k+FfAh0j3NMqrKKn3pt0O3kcJJmtfAakOqZatxeB7DVWFWX?=
 =?us-ascii?Q?/4MurIJeN0U1/RiAw+z1YBhtoepNcyGxCDky745fh5tx1hhWKr63JJYuR2FU?=
 =?us-ascii?Q?PBF1vzdtQChzz6jVu4A3Vv4hg3XCKf/GvQZKPQIcwa+9he9/ine+D1psS8yj?=
 =?us-ascii?Q?hiRtZgR7oxsapoj5aENU8GROcGyVV3HqjTp859yAIapO9Th8OK0ePYqLIjSb?=
 =?us-ascii?Q?SHfA70YI4PbWje/5Zwk3t7fpuJokO5xMlJFFF9dbHRRkyNqMB7B2NpJODCCL?=
 =?us-ascii?Q?HnTagFSFNnHNjjn+Ijy7K1MZnQdVA40z8O+g54KQrKKII9QVu+ckWsrlyyvE?=
 =?us-ascii?Q?wo8eYD/8v2oH6MoyCzCWc8qhJcPCF5W7ZHnmcgLMylzqIGdNCpECOZ/nBbP/?=
 =?us-ascii?Q?mTv7vqf9pv7GkPvWrFoEl0iZ1/NovgjHd7Khc7t5WhO2rhe1Mc5oq2B+pvbr?=
 =?us-ascii?Q?tkSutF0nOn/xV+B4yvVDP/zV0ADCq1WMbHD6qykmiBzMhhpKEWlYnxxvSER3?=
 =?us-ascii?Q?TtN+sIe212vcIiG3p1yYbVzdKHdo5MYeEPb8t3cvZy/LT/Ts+1bizSD/yE35?=
 =?us-ascii?Q?zC7oIDAYkMNcmFL+9NBw10ZEVYi8dHeDB8Z9iOTYYiaZoqbWoJSqHXO1Q7mL?=
 =?us-ascii?Q?nmVGkNMHRe/joc/CekIzg1rH0L1JsLswhZH/xoDmIT5wfVcTnRCpuP7Xo65/?=
 =?us-ascii?Q?FkWHUqMWc2qU/JWwcs6nCSRDuVIGBRiT1VX6VJM897bosES/MhbXZEEpRKei?=
 =?us-ascii?Q?4yVvdlW2Q2ZGGiKGKcd/cF10M+/OA9f5O+KnmU5Bd8mOSw3KkFeRd0b4mfwo?=
 =?us-ascii?Q?6OjE1RG9os6gl/9QUqpDuRQNoNjtcVeceC8khd9izfIIUqOcKokQ1/BkM9ey?=
 =?us-ascii?Q?O4IxfYHZ6j0fi7WVsNuwbAR/I84okV+6st7a1FsRvOtr0Wd83dcG8EP4aD42?=
 =?us-ascii?Q?92YJVSFqW4OYhpjpFcxGmRRQACw32hW8dTyVl08f7Di01NSpBmos4YEkhQVq?=
 =?us-ascii?Q?fAm/9YLuePNiyy9IImSJnLjMpuxR9w+7wl0IzJApAK//JymTgmlFXihgKxuZ?=
 =?us-ascii?Q?AQiNweMECvjYjg40Jktrzu++oyZ8kV6qom8Rl91+D78Y+ImgePXbM6IV6zdk?=
 =?us-ascii?Q?fY8ZJyHoxFH+BG0CJHPP4LaU51as62HvqJ6qUoSg41mQM1XiGdGYabHY8xRx?=
 =?us-ascii?Q?EE7dhK+u52c4yWTZ+cAPV0wSmbQ0a1Ee/oS9pE0wXUXSvDdDtTcuPlSAHN0j?=
 =?us-ascii?Q?wwvA4Of0vfEXLv7KDGhRbfFOpIN3itu9rtV+vYn3gu1lGbsS5wTtJvtLyW7j?=
 =?us-ascii?Q?S09/7KB8GT5GZETcutUhsTc/loIvlUbecK9AE6Zt/EfvnEbiayNSFHV46bFF?=
 =?us-ascii?Q?rh1Qf/GxCi4oMvwnmIHj0nnkSqMxPMKZMgmFkpVAhVRxpYIuCulvX3iJG8rE?=
 =?us-ascii?Q?DXWVGPFKHBwtSJg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EtkSlCv9VHDoL5t/PX4PT/s6BCe/cmyI0dAYS+7utaSeLr7TB7ToU+fsjkG7?=
 =?us-ascii?Q?lOEmcU45uXu+jSFy7y+CkgJgD1DuFtPqVNAU+BdZ34moAwx9HTKeku4zihNl?=
 =?us-ascii?Q?EzFw/ZRUEogGWdIwZIkE1Aqp5uyJeNY/aNzdouCRzS4fckBRBIcNuIEuiSbX?=
 =?us-ascii?Q?H1CalNwzDwhLyhaU8kAyNGI31zdwphxhS2Sx3mXSTlL8dDdBaXhrDBDS0q98?=
 =?us-ascii?Q?Iz0t8duKiPh4j3CwFHPGFdMLa8I27UWtyinQgbhtwme6IeOiuaz9e0PqKYEu?=
 =?us-ascii?Q?wSBkoiBDlGWU+wWWW7ZQoU1BrbUo4ocHEym/RB1FRqnCKggic1Y301H6nnEN?=
 =?us-ascii?Q?AtFesP3QMSsqroDllwGcWo7v53+Tj4hZ67Z90dJQblUQ1qtuv4l/Sv20kkFR?=
 =?us-ascii?Q?LLGZ09IPllzLIxqIUaMEEdkDI2PJ4DeUkUiN+31LuUp5oGoaYXpSAPFwvQ8s?=
 =?us-ascii?Q?6nKvwI0//8qcEG1znXMQG1qf6TfoegUW8DO+jQKLxbrTzg4UhmIaafOWsJT4?=
 =?us-ascii?Q?vtFeeeJor2w5pdLU2tnhSG1sgr6u/D14uIzt9gsgpPDzNNQXZ3Na1SwxeKmg?=
 =?us-ascii?Q?8lzRgKCekk9T0POFZUOVww2infqsFRxj9je5fTtX+nj/o/LqedJp+EEol3jl?=
 =?us-ascii?Q?iy7hxcS5aNk4oWBGbQiOCp/2W2LeMOPL7zoCStJLeQFYyh7fk3jgB9f2+Dzz?=
 =?us-ascii?Q?ZYLxdqSuDu+7++NxTvmsHr+9+TbfD8PmwQo9yoWhS8quKEQ9+3fr9J34O5s1?=
 =?us-ascii?Q?MWxHvM+G0dq4NNYpAl1MgYeNv02RNHQ+GUqEBtVBkNpy0V8eY8e4FoXVIa2e?=
 =?us-ascii?Q?aNNGp6LgUA9IVvf41yk4VSkUNuIALEaYvaa3CuLlrIf2JpDoNXtWoViR7AHn?=
 =?us-ascii?Q?aTshQvYaN8GiXsG/k6hqruNox4MulQxVrgKevpvkcivRGWSSDjQ8j7EvRdQ1?=
 =?us-ascii?Q?3EQhgqXfhZ66cPlDGpa/n28rJ6b6opI/01vFfEt/Je17JclZ6+drQxHX+Ya1?=
 =?us-ascii?Q?MywjuTUSUBXR24lyFbGHA1ZVBdbZDeu86NeUjG63cgouVk975Zr/4PMEt9aY?=
 =?us-ascii?Q?q1GlunxCbKriIHPOj6dYuQHMjCL4WdMSYJgfiWrBuEtcfNb0SKwnhaTXKO+6?=
 =?us-ascii?Q?PcY4ZgBgZ3UBQ6tq+iW9ng6yuZFnIEcsxv9fqB2w54Tn/VZNPlcTjz5eoy2V?=
 =?us-ascii?Q?5aQrkmizWzaeEdxfEF1NrtywLmjIfVoXFpi6lcw5JGSXOGwmTGsHSH5h+9d4?=
 =?us-ascii?Q?I2PDrn2oL53C5506Qjrnes3eGkiCsaVcv79cvjKAOjJFQTrzXDu2VDgjUPxM?=
 =?us-ascii?Q?w4PaMDzYFGiFAxoNCn07BnfBN8VOh8Cy62AKpv5wAJSA7BBVoMnQ3B4xXRqv?=
 =?us-ascii?Q?OJzrm51y+nAVF6QabSAMkepEkPB0NP9Avf21uYKSHaOK3wCq38c1dYTelZQx?=
 =?us-ascii?Q?QgLVI6kXZ7Ktt7IN0awvvzPqcZJDtD8VynOhEcfmh2s/kzo1jRRnvFAOOBxR?=
 =?us-ascii?Q?nSNsgQZThyJAnHwnBaDAXiAqqMlJbkxh0LHqnlxEwtrGXO/VOMorv5q4W3sz?=
 =?us-ascii?Q?Li1Gop3k/Q0JQM2USxtp9hthiijkHucWSBV2KvAw93Bkl5msp8GHR6hzOhpu?=
 =?us-ascii?Q?zHqBZfxF47Zq4PdaT0TcGaM=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b82be94b-06cd-443f-b7ab-08dd7894c0fa
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 01:04:04.5719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7e4evEeWWuWH8nGnZGFdsWTpjGB5MuVtK5GztNxEpT9FnpYTmKTu2uWn7FaTdx+oCYdd4WxrAwduseAvCtgAueVRhA03qVFiHPRAYIkNxZvMJjY4NaAIvqE3Ag94wzqX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13579

Sparrow Hawk has Headset (CONN3) AUX_IN (CONN4) for Sound input/output
which is using MSIOF. Support it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 .../dts/renesas/r8a779g3-sparrow-hawk.dts     | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts b/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts
index b54d45115a85..0a4a9e1f85a5 100644
--- a/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts
+++ b/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts
@@ -4,6 +4,29 @@
  *
  * Copyright (C) 2025 Marek Vasut <marek.vasut+renesas@mailbox.org>
  */
+/*
+ * DA7212 Codec settings
+ *
+ * for Playback
+ *	> amixer set "Headphone" 40%
+ *	> amixer set "Headphone" on
+ *	> amixer set "Mixout Left DAC Left"  on
+ *	> amixer set "Mixout Right DAC Right" on
+ *
+ * for Capture (Aux/Mic)
+ *	> amixer set "Aux" on
+ *	> amixer set "Aux" 80%
+ *	> amixer set "Mixin PGA" on
+ *	> amixer set "Mixin PGA" 50%
+ *	> amixer set "ADC" on
+ *	> amixer set "ADC" 80%
+ *	> amixer set "Mixin Left Aux Left" on
+ *	> amixer set "Mixin Right Aux Right" on
+ *	> amixer set "Mic 1" on
+ *	> amixer set "Mic 1" 80%
+ *	> amixer set "Mixin Left Mic 1" on
+ *	> amixer set "Mixin Right Mic 1" on
+ */
 
 /dts-v1/;
 #include <dt-bindings/gpio/gpio.h>
@@ -150,6 +173,12 @@ vcc_sdhi: regulator-vcc-sdhi {
 		gpios-states = <1>;
 		states = <3300000 0>, <1800000 1>;
 	};
+
+	/* Page 30 / Audio_Codec */
+	sound_card: sound {
+		compatible = "audio-graph-card2";
+		links = <&msiof1_snd>;
+	};
 };
 
 /* Page 22 / Ether_AVB0 */
@@ -341,6 +370,29 @@ i2c0_mux1: i2c@1 {
 			reg = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+
+			/* Page 30 / Audio_Codec */
+			codec@1a {
+				compatible = "dlg,da7212";
+
+				#sound-dai-cells = <0>;
+				reg = <0x1a>;
+
+				clocks = <&rcar_sound>;
+				clock-names = "mclk";
+
+				VDDA-supply   = <&reg_1p8v>;
+				VDDMIC-supply = <&reg_3p3v>;
+				VDDIO-supply  = <&reg_3p3v>;
+
+				port {
+					da7212_endpoint: endpoint {
+						bitclock-master;
+						frame-master;
+						remote-endpoint = <&msiof1_snd_endpoint>;
+					};
+				};
+			};
 		};
 
 		i2c0_mux2: i2c@2 {
@@ -603,6 +655,52 @@ sd_uhs_pins: sd-uhs {
 		function = "mmc";
 		power-source = <1800>;
 	};
+
+	/* Page 30 / Audio_Codec */
+	msiof1_pins: sound {
+		groups = "msiof1_clk", "msiof1_sync", "msiof1_txd", "msiof1_rxd";
+		function = "msiof1";
+	};
+
+	/* Page 30 / Audio_Codec */
+	sound_clk_pins: sound-clk {
+		groups = "audio_clkin", "audio_clkout";
+		function = "audio_clk";
+	};
+};
+
+&audio_clkin {
+	clock-frequency = <24576000>;
+};
+
+/* Page 30 / Audio_Codec */
+&rcar_sound {
+	pinctrl-0 = <&sound_clk_pins>;
+	pinctrl-names = "default";
+
+	/* It is used for ADG output as DA7212_MCLK */
+
+	/* audio_clkout */
+	clock-frequency = <12288000>; /* 48 kHz groups */
+
+	status = "okay";
+};
+
+&msiof1 {
+	pinctrl-0 = <&msiof1_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	/* ignore DT warning */
+	/delete-property/#address-cells;
+	/delete-property/#size-cells;
+
+	msiof1_snd: port {
+		msiof1_snd_endpoint: endpoint {
+			remote-endpoint = <&da7212_endpoint>;
+		};
+	};
 };
 
 /* Page 31 / FAN */
-- 
2.43.0


