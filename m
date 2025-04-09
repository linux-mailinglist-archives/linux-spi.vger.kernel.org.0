Return-Path: <linux-spi+bounces-7470-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0723AA81A47
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 03:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6139C884A23
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 01:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CCC13C9D4;
	Wed,  9 Apr 2025 01:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="W27l3WsP"
X-Original-To: linux-spi@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010025.outbound.protection.outlook.com [52.101.229.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B611329A2;
	Wed,  9 Apr 2025 01:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744160736; cv=fail; b=k8uQKI9rJxaGO87u16f+y64jp6zGAPQtLyKkqW1etep6ONjX7Gnxk9rZrPMFRX2Eh3Rh5oaF+K7v4hb4jXBslDJwNDzb8MmPVaiq7V/XAdpDoqX+D2IpG1eMTZ/nXNL8oxMztqYkUFbWXy2/TNGbe/ObzDxns8m+gI5SX7AeuEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744160736; c=relaxed/simple;
	bh=i3k5erMsPALrfq6yCbzUwdeKW38YrwAGjLB/bDDs4iw=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=FBiQEhKZLyYJK4G5OWGXMrse5GkH6brTYU2NK2BHyYfomEx3wKKNJCVO8bniDO1jDRZnB+3H65jKZgxTiMJJjBmcGyMUMhuUx5mFdSfK/dFxMdNugsTM/WXcrPd8p2RgY2S52n7oDB7VcnanmOWHgoxaNGSO8Q28k4vkRFQ7+RI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=W27l3WsP; arc=fail smtp.client-ip=52.101.229.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eGJ6T29G828tZvojR6gT7C+g6Q82VMUsiENSjv/wNiV96qleB9Kl4wEH8VM5y2l1eBbEzZuCrMQHuCsD3IH122TXDZoXwvJ/y1zsIsKFS82qElshuiEbvvdjzMe3TO/s0xYoeiLZi0jgAZX05SgTB6+pxmWltMpdoUDeZ6SIfIhFDexiKT4gnc+aWiY2fmp1Nb2KGnaZ/vUCJwT/8IVlbJwlcygEVfdWw+ruTgtgXte7JkyAsDFkgFsjap8JcHG4BFdgpgh2UTRWB61W4qMHRxVLYJMWVEv9hBD+ypv5HfMoy/dkETm2eKdHGe+CJC9FY58mQj/EyAA13yt2vLAegw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LYPYYEz3FIN8rNA2YThaZKmULZY2jJqVl92kTBl9c0=;
 b=u4E4t61yJE1xhigE24Lgw7wQqh3d9coOsj0hkysJVLHMLGStEeWMajWqk4QytcbHrAv/TeK+AazN+01OZgvIJvPcnTJ0l7+O9PcVwPdMG6B6w2S7YdNgbpnI834i2EXhXISnuEdlg4zO4y5FsbM9JVgEJoviqGy7vRcFVTQ9WqvunwXp+guE7U28iRf0HVr53EaJ0TVGCoM2/YC3SlbxvxjPXVMYUD18oaxMApVqt+fvWTPtfJWfSWQFKBojfxQdtoEh+g/UsqVNVhEPPSpdtjGSzuguxIkW76mwLJdx/QfavF2OjGvKS6rUuZUlZSWXcSeFK5fnNs2wBBz7/ZkVWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LYPYYEz3FIN8rNA2YThaZKmULZY2jJqVl92kTBl9c0=;
 b=W27l3WsPoEyahvT/HvxP4W1SVJDEnblr0yv6HdencOGeA+CyzY+hM2ZgYRN8Ez3NG7hGQafbcUioU3BOdltI57QH4J7/ofBsC/hzZO65X6jQNyR6UKTJO6VUQgA8HWjKbHMMCteVoZk9lLfHk55kUv2u86aO5OXIuHDiH1yJJ3I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OS7PR01MB14942.jpnprd01.prod.outlook.com
 (2603:1096:604:395::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Wed, 9 Apr
 2025 01:05:26 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 01:05:26 +0000
Message-ID: <87wmbu9may.wl-kuninori.morimoto.gx@renesas.com>
To: Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Jaroslav Kysela <perex@perex.cz>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 6/7] ASoC: renesas: add MSIOF sound support
In-Reply-To: <875xjeb0wu.wl-kuninori.morimoto.gx@renesas.com>
References: <875xjeb0wu.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 9 Apr 2025 01:05:25 +0000
X-ClientProxiedBy: TY2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:404:a6::13) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OS7PR01MB14942:EE_
X-MS-Office365-Filtering-Correlation-Id: c020e015-8512-4f60-45f6-08dd77029cca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mmu2iuMKCFFQgi9GRh4TQkSLeYn6EVWcQrEab1mPLfAbIJDR0Lle/4C5l4gw?=
 =?us-ascii?Q?K8SGMMk3T5kyqlObHoj8xhIm1Bgw+8/f7DjSF4My/zKTwXo2swKtyOWmvmb1?=
 =?us-ascii?Q?mDiYfVu0j4AUyGb+f5wKDVVK0LROgEJpJEW08rkrkoLNsAPuCaBGCr1EuvZC?=
 =?us-ascii?Q?EPJdY0xS2ui71iRnIQA2QNUD4u9M/i0jya94Oqar4DcjIOft4hQfl5DBen/C?=
 =?us-ascii?Q?qr1aq6Uwb3pJtUbsV7AACWjwzalVnUPC7MDm5wrz241/fnyAfkOdeBX2NsEn?=
 =?us-ascii?Q?R4YGyaT6anu/1xKC60l4u9vhSZV6xvC/521/BV1WFGaZq6w6OKmlNWq/auv7?=
 =?us-ascii?Q?XPFTP9LYaQE2st5YZEV5ZcFABpEjrEOPwxKMJo4KIy1oklM9hM35WEGwRxRc?=
 =?us-ascii?Q?XqsrmnxWjHhOcNqOFeEa/VcHAhF/yI1y3x0LTPvYLPiGGkUQgc0czbRdsNB1?=
 =?us-ascii?Q?SODQXyn2qBctD2mdDiD0XExSHvCMNFkjQfUjl8k1+KKrTK76h2xCxFATwEet?=
 =?us-ascii?Q?piY326Cja1BVE3+VeT/PT3Ro8eksOtrv0J413rpfikNFB3O9E/lGexxMOfyW?=
 =?us-ascii?Q?zYUnypu9TvVxAnMINQ9Y6Oh29ng4mB/+Lp517O2YW9NZq2xpgr5xqP4eDcsA?=
 =?us-ascii?Q?UKq7yi6qEuXHrGW4JtB6GNKD+vWIYanyxjB1ahxSAQogjNJpBfTlM2W424yH?=
 =?us-ascii?Q?RygckEOWheOFyaluAW8hVL7EJ1zyTn5K6Sr7hvjozw9WPkj2CHpCtMO6wONU?=
 =?us-ascii?Q?zHmSqC3TK1slPzDArBk1/YvDs59BLIXbG+UeeBwzMOxPbd0orRmhT4s3BLJe?=
 =?us-ascii?Q?U9QihqKAm4prETQOYd5wNIH+C0zL8lC2es+++tRdHZJH188ihDvXuZml9Xim?=
 =?us-ascii?Q?y3l+ibup7fm0rbbaaVqZDExDzUiNEk7jb/7QiGynU4CaBceYYMVCOu+7jqwe?=
 =?us-ascii?Q?dySlSOv2laQ9m2MDvFqREJHhWvNpxf7DjI1eKoQhJksgrAuNVNnJRkqLp95Q?=
 =?us-ascii?Q?lFVBouK2o8OR5NOaB1bIipVj5ahbrvzdX+AvmnnzdRcYZ5z4eJvKTv+bs6sw?=
 =?us-ascii?Q?5ixnDK6+eS+DN/HJvJ+xvtY4q5xbGxyQRezBdybkzVUoiyHUJl4ssWOBZRzR?=
 =?us-ascii?Q?tKFvrwKykyYmuIc39BAvSr6n4jCmykQ3wTs/GVdC/gnf+V7FUNsRdPVoQVe+?=
 =?us-ascii?Q?rQRcR15i2n3D4dBNilj1ldrJICK6zmucLrJnthXLsSv/cuSS0R43Xv1l3paA?=
 =?us-ascii?Q?PXYTQlru79NJM2gaKQwvJx5qmukOwNAHJtTyVN1rlpT8TmtFNKh8gTlM/S9X?=
 =?us-ascii?Q?KRJ2BS12zmwB3uCPNXA2P3F/59rPYysXU5uLINtaDnruiUakAX1ttfgUxjS3?=
 =?us-ascii?Q?rF+TiKnRvOdLX7j0kQK6g/8NILR2Xl+zTEiPRpILYiFgeZ8FJ5QvYa7oWK11?=
 =?us-ascii?Q?u/dhqSYmGnHa63An+l93lMaUJILQ87+4UWWCx2LWdy9gmVPyijPN8z1QJ0r2?=
 =?us-ascii?Q?Jj3FpnoIUwCY+/s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XUHdIkqfZCt4HZCvOGrM2A/f83UK6Dei2T9ufJubjhVt4rclNIAn8jFzurcU?=
 =?us-ascii?Q?LGFOk6agaR7oE5FHCnyODlLCoWm4yyMLAvpg1Mcrm0TlqOzoLlwJE+Xs0tbn?=
 =?us-ascii?Q?uFlLKRQeif+p1raIdVkb3SgsFpTfWnuEL2T1D3bSTI0lIrLBLbr+IxtVWv8f?=
 =?us-ascii?Q?we+4kkBzHkqaXxxjxRRv5cKgkUfoVUZcuvLUsXpD0cwhyGYQi8kS5PJEHzD/?=
 =?us-ascii?Q?3RwRhledKgTGw8JAJaaQnG+UKyWBB3Cfwja6EvVxbjm1qdVtmiHIRrGEkBTa?=
 =?us-ascii?Q?br1HwIAj1EHg6LNRgO5Daqi59Sy8gdOCzgyrp7Zg3NC+wDDjDfrj6JtZolgD?=
 =?us-ascii?Q?YMg2BhlqZrJvvnbOlGTFg7WXSZSk03DpWr1ntOsnStesBhMdV2su0p/AiEzJ?=
 =?us-ascii?Q?kluEOsY28Xtd5Ur//XE1wA2cx0SEhUA+bBQpZv/2OqXnurOU9s8Zi0409Zp4?=
 =?us-ascii?Q?S1BJo/eiXLZn2q4swJO3RKO50kyy9vCDsCDiG2rzqnKMb6nlImUF5HcNGQp5?=
 =?us-ascii?Q?xiIah68ogKtpWJjdImn3UPb1hl1BhjLsSysJcxQIv88unj09AA7bU2Gl8CSb?=
 =?us-ascii?Q?iPV1zv/PVQ/rzwdC+csqzTVx0HOw0RsKwcm61Yx+wiws8GeELuKmQumwEbIq?=
 =?us-ascii?Q?JQ6erv+Sc4d/RIu5AKQVyA0IiWiLhpP6oSLXAO26lGVYax7NvPN4qUxW+QdU?=
 =?us-ascii?Q?/ORYXjrKQJ4wFyxxwrKlMSOz1R9o6moWJIQXzon1Ow6RvLpFrkV5SmOQmsEn?=
 =?us-ascii?Q?lss0wThlbII/YzVitHvU84tsVhfFDu0m2LMo3p0ShlyCmOcvS6r2bNlbVL6W?=
 =?us-ascii?Q?BQ98G9ZLLMaxwsdAetejwKkxzxNecoaMfMWIKmngsDJtkY/Sjvl9jlkg5Zml?=
 =?us-ascii?Q?rzZPyM0xK7SNUmYdEJhL5gXEf1c1qae01vJqi5XDkryw5GtEvVe1+WUWvE5j?=
 =?us-ascii?Q?Za5c4wusK7LwQCBhMcPHepH8tY3q8uMAMjpT9w+vkj2Bfj8Nr5RPC9yuahda?=
 =?us-ascii?Q?hlz79iDFldpH3EIKJ+KAvv+acceezzDJ+7CtqaALosbhVLm4OTIuiq3O+JHA?=
 =?us-ascii?Q?OTxEx/8sFoq5UjaEmASTysqNq9QT/ikILBz1nUWjxxdVRe2HoEY+zAW0x2jz?=
 =?us-ascii?Q?aCjKHXOYou9rSaCdeOnxGkVLplZbk5croQ8NrLs+ARZWZiWOo+jjvUOCvNVH?=
 =?us-ascii?Q?f32JC0DB/KHS3V62k8JYIzNsfZgnxEp61zPPbQRziRvTKrpp+MrWGQUx64f7?=
 =?us-ascii?Q?9fDcXsGtOrdf+CKkmvOydlRJdSdTod81r1OOZWi5LNjvDLqw8BCh+eaNpSIN?=
 =?us-ascii?Q?DH1HAtdBqDtEfWhrWAW9ca69JRstfMWTNqnNAK05k2dmkUWbZ0WbO63z4Xvo?=
 =?us-ascii?Q?kf4guGy+ltTGBHM1LsftvbOVRMwKvQ+JMP1WqcsgvzQ3QLRFFmQvlUXG2iPK?=
 =?us-ascii?Q?Y2kBScYaqrJ4aHmQmrbp3CtG186d5QkeDMlaLbPi+RaRbl27SyqPOpvfWkME?=
 =?us-ascii?Q?0HBcHEJUHqRLroWiy0rrte1O/w0GZiJ7Cf6NGBS+oyjpzKJxyTaK6l33bL1i?=
 =?us-ascii?Q?ovTgP5soet9VSAFn9bopuCsua6k8AgrplhCgxlbkbqeCXJZw5mYIg5f3R0b8?=
 =?us-ascii?Q?6Sz10t/mM8JNF37mv2hF7+I=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c020e015-8512-4f60-45f6-08dd77029cca
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 01:05:26.2107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O0b1/Ie2Mgky6XsYsK9a4VO6EXxjjcpf9LQRSRtrtrfG3NTuXYDus2chVcjVRgKayUn49Vz6Qy09WcDUMwxMuFI2+fZJq28zVNAwL9DR7q0NiLPCUwb/MjIkzIkQxUE8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14942

Renesas MSIOF (Clock-Synchronized Serial Interface with FIFO) can work as
both SPI and I2S. Adds MSIOF-I2S driver.

MSIOF-SPI/I2S are using same DT compatible properties.
MSIOF-I2S         uses Of-Graph for Audio-Graph-Card/Card2,
MSIOF-SPI doesn't use  Of-Graph.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/renesas/Kconfig       |   7 +
 sound/soc/renesas/rcar/Makefile |   3 +
 sound/soc/renesas/rcar/msiof.c  | 579 ++++++++++++++++++++++++++++++++
 3 files changed, 589 insertions(+)
 create mode 100644 sound/soc/renesas/rcar/msiof.c

diff --git a/sound/soc/renesas/Kconfig b/sound/soc/renesas/Kconfig
index cb01fb36355f..dabf02a955ca 100644
--- a/sound/soc/renesas/Kconfig
+++ b/sound/soc/renesas/Kconfig
@@ -46,6 +46,13 @@ config SND_SOC_RCAR
 	help
 	  This option enables R-Car SRU/SCU/SSIU/SSI sound support
 
+config SND_SOC_MSIOF
+	tristate "R-Car series MSIOF support"
+	depends on OF
+	select SND_DMAENGINE_PCM
+	help
+	  This option enables R-Car MSIOF sound support
+
 config SND_SOC_RZ
 	tristate "RZ/G2L series SSIF-2 support"
 	depends on ARCH_RZG2L || COMPILE_TEST
diff --git a/sound/soc/renesas/rcar/Makefile b/sound/soc/renesas/rcar/Makefile
index 45eb875a912a..3a2c875595bd 100644
--- a/sound/soc/renesas/rcar/Makefile
+++ b/sound/soc/renesas/rcar/Makefile
@@ -1,3 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 snd-soc-rcar-y		:= core.o gen.o dma.o adg.o ssi.o ssiu.o src.o ctu.o mix.o dvc.o cmd.o debugfs.o
 obj-$(CONFIG_SND_SOC_RCAR)	+= snd-soc-rcar.o
+
+snd-soc-msiof-y			:= msiof.o
+obj-$(CONFIG_SND_SOC_MSIOF)	+= snd-soc-msiof.o
diff --git a/sound/soc/renesas/rcar/msiof.c b/sound/soc/renesas/rcar/msiof.c
new file mode 100644
index 000000000000..de8de3468402
--- /dev/null
+++ b/sound/soc/renesas/rcar/msiof.c
@@ -0,0 +1,579 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Renesas R-Car MSIOF (Clock-Synchronized Serial Interface with FIFO) I2S driver
+//
+// Copyright (C) 2025 Renesas Solutions Corp.
+// Author: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+//
+
+/*
+ * [NOTE]
+ *
+ * This driver doesn't support Clock/Frame Provider Mode
+ *
+ * Basically MSIOF is created for SPI, but we can use it as I2S (Sound). Because of it, when we use
+ * it as I2S (Sound) with Provider Mode, we need to send dummy TX data even though it is used for
+ * RX. Because SPI HW needs TX Clock/Frame output for RX purpose also. It makes driver code complex.
+ *
+ * And when we use MSIOF (Sound) as Provider Mode, the clock source is [MSO clock] (= 133.33MHz)
+ * SoC internal clock. It is not for 48kHz/44.1kHz base clock. Thus the output/input will not be
+ * accurate sound.
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_dma.h>
+#include <linux/of_graph.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <sound/dmaengine_pcm.h>
+#include <sound/soc.h>
+
+/* register */
+#define SITMDR1		0x00
+#define SITMDR2		0x04
+#define SITMDR3		0x08
+#define SIRMDR1		0x10
+#define SIRMDR2		0x14
+#define SIRMDR3		0x18
+#define SITSCR		0x20
+#define SICTR		0x28
+#define SIFCTR		0x30
+#define SISTR		0x40
+#define SIIER		0x44
+#define SITFDR		0x50
+#define SIRFDR		0x60
+
+/* SITMDR1/ SIRMDR1 */
+#define TRMD		(1 << 31)		/* Transfer Mode (1 = Master mode) */
+#define PCON		(1 << 30)		/* Transfer Signal Connection */
+#define SYNCMD_SPI	(2 << 28)		/* Level mode/SPI */
+#define SYNCMD_LR	(3 << 28)		/* L/R mode */
+#define SYNCAC		(1 << 25)		/* Sync Polarity (Active-low) */
+#define DTDL_1		(1 << 20)		/* 1-clock-cycle delay */
+#define TXSTP		(1 <<  0)		/* Transmission/Reception Stop on FIFO */
+
+/* SITMDR2 and SIRMDR2 */
+#define BITLEN1(x)	(((x) - 1) << 24)	/* Data Size (8-32 bits) */
+#define WDLEN1(x)	(((x) - 1) << 16)	/* Word Count (1-64/256 (SH, A1))) */
+#define GRP		(1 << 30)		/* Group count */
+
+/* SITSCR */
+#define SITSCR_V(p, d)	((p << 8) + d)
+
+/* SICTR */
+#define TEDG		(1 << 27)		/* Transmit Timing (1 = falling edge) */
+#define REDG		(1 << 26)		/* Receive  Timing (1 = rising  edge) */
+#define TSCKE		(1 << 15)		/* Transmit Serial Clock Output Enable */
+#define TFSE		(1 << 14)		/* Transmit Frame Sync Signal Output Enable */
+#define TXE		(1 <<  9)		/* Transmit Enable */
+#define RXE		(1 <<  8)		/* Receive Enable */
+#define TXRST		(1 <<  1)		/* Transmit Reset */
+#define RXRST		(1 <<  0)		/* Receive Reset */
+
+/* SISTR */
+#define TFEMP		(1 << 29)		/* Transmit FIFO Empty */
+#define TDREQ		(1 << 28)		/* Transmit Data Transfer Request */
+#define TEOF		(1 << 23)		/* Frame Transmission End */
+#define TFSERR		(1 << 21)		/* Transmit Frame Synchronization Error */
+#define TFOVF		(1 << 20)		/* Transmit FIFO Overflow */
+#define TFUDF		(1 << 19)		/* Transmit FIFO Underflow */
+#define RFFUL		(1 << 13)		/* Receive FIFO Full */
+#define RDREQ		(1 << 12)		/* Receive Data Transfer Request */
+#define REOF		(1 <<  7)		/* Frame Reception End */
+#define RFSERR		(1 <<  5)		/* Receive Frame Synchronization Error */
+#define RFUDF		(1 <<  4)		/* Receive FIFO Underflow */
+#define RFOVF		(1 <<  3)		/* Receive FIFO Overflow */
+#define SISTR_ERR_TX	(TFSERR | TFOVF | TFUDF)
+#define SISTR_ERR_RX	(RFSERR | RFOVF | RFUDF)
+#define SISTR_ERR	(SISTR_ERR_TX | SISTR_ERR_RX)
+
+/* SIIER */
+#define TDMAE		(1 << 31)		/* Transmit Data DMA Transfer Req. Enable */
+#define TDREQE		(1 << 28)		/* Transmit Data Transfer Request Enable */
+#define RDMAE		(1 << 15)		/* Receive Data DMA Transfer Req. Enable */
+#define RDREQE		(1 << 12)		/* Receive Data Transfer Request Enable */
+
+/*
+ * The data on memory in 24bit case is located at <rigth> side
+ *	[  xxxxxx]
+ *	[  xxxxxx]
+ *	[  xxxxxx]
+ *
+ * HW assuming signal in 24bit case is located at <left> side
+ *	---+        +--------+
+ *	   +--------+        +--------+...
+ *	   [xxxxx  ][xxxxx  ][xxxxx  ]
+ *
+ * When we use 24bit data, it will be transfered via 32bit width via DMA,
+ * and MSIOF/DMA doesn't support data shift, we can't use 24bit data correctly.
+ * There is no such issue on 16/32bit data case.
+ */
+#define MSIOF_RATES	SNDRV_PCM_RATE_8000_192000
+#define MSIOF_FMTS	(SNDRV_PCM_FMTBIT_S16_LE |\
+			 SNDRV_PCM_FMTBIT_S32_LE)
+
+struct msiof_priv {
+	struct device *dev;
+	struct snd_pcm_substream *substream[SNDRV_PCM_STREAM_LAST + 1];
+	spinlock_t lock;
+	void __iomem *base;
+	resource_size_t phy_addr;
+
+	/* for error */
+	int err_syc[SNDRV_PCM_STREAM_LAST + 1];
+	int err_ovf[SNDRV_PCM_STREAM_LAST + 1];
+	int err_udf[SNDRV_PCM_STREAM_LAST + 1];
+
+	/* bit field */
+	u32 flags;
+#define MSIOF_FLAGS_NEED_DELAY		(1 << 0)
+};
+#define msiof_flag_has(priv, flag)	(priv->flags &  flag)
+#define msiof_flag_set(priv, flag)	(priv->flags |= flag)
+
+#define msiof_is_play(substream)	(substream)->stream == SNDRV_PCM_STREAM_PLAYBACK
+#define msiof_read(priv, reg)		ioread32((priv)->base + reg)
+#define msiof_write(priv, reg, val)	iowrite32(val, (priv)->base + reg)
+#define msiof_status_clear(priv)	msiof_write(priv, SISTR, SISTR_ERR)
+
+static void msiof_update(struct msiof_priv *priv, u32 reg, u32 mask, u32 val)
+{
+	u32 old = msiof_read(priv, reg);
+	u32 new = (old & ~mask) | (val & mask);
+
+	if (old != new)
+		msiof_write(priv, reg, new);
+}
+
+static void msiof_update_and_wait(struct msiof_priv *priv, u32 reg, u32 mask, u32 val, u32 expect)
+{
+	u32 data;
+	int ret;
+
+	msiof_update(priv, reg, mask, val);
+
+	ret = readl_poll_timeout_atomic(priv->base + reg, data,
+					(data & mask) == expect, 1, 128);
+	if (ret)
+		dev_warn(priv->dev, "write timeout [0x%02x] 0x%08x / 0x%08x\n",
+			 reg, data, expect);
+}
+
+static int msiof_hw_start(struct snd_soc_component *component,
+			  struct snd_pcm_substream *substream, int cmd)
+{
+	struct msiof_priv *priv = snd_soc_component_get_drvdata(component);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int is_play = msiof_is_play(substream);
+	int width = snd_pcm_format_width(runtime->format);
+	u32 val;
+
+	/*
+	 * see
+	 *	Datasheet 109.3.6 [Transmit and Receive Procedures]
+	 *
+	 *	TX: Fig 109.14	- Fig 109.23
+	 *	RX: Fig 109.15
+	 */
+
+	/* reset errors */
+	priv->err_syc[substream->stream] =
+	priv->err_ovf[substream->stream] =
+	priv->err_udf[substream->stream] = 0;
+
+	/* SITMDRx */
+	if (is_play) {
+		val = PCON | SYNCMD_LR | SYNCAC | TXSTP;
+		if (msiof_flag_has(priv, MSIOF_FLAGS_NEED_DELAY))
+			val |= DTDL_1;
+
+		msiof_write(priv, SITMDR1, val);
+
+		val = BITLEN1(width);
+		msiof_write(priv, SITMDR2, val | GRP);
+		msiof_write(priv, SITMDR3, val);
+
+	}
+	/* SIRMDRx */
+	else {
+		val = SYNCMD_LR | SYNCAC;
+		if (msiof_flag_has(priv, MSIOF_FLAGS_NEED_DELAY))
+			val |= DTDL_1;
+
+		msiof_write(priv, SIRMDR1, val);
+
+		val = BITLEN1(width);
+		msiof_write(priv, SIRMDR2, val | GRP);
+		msiof_write(priv, SIRMDR3, val);
+	}
+
+	/* SIIER */
+	if (is_play)
+		val = TDREQE | TDMAE | SISTR_ERR_TX;
+	else
+		val = RDREQE | RDMAE | SISTR_ERR_RX;
+	msiof_update(priv, SIIER, val, val);
+
+	/* SICTR */
+	if (is_play)
+		val = TXE | TEDG;
+	else
+		val = RXE | REDG;
+	msiof_update_and_wait(priv, SICTR, val, val, val);
+
+	msiof_status_clear(priv);
+
+	/* Start DMAC */
+	snd_dmaengine_pcm_trigger(substream, cmd);
+
+	return 0;
+}
+
+static int msiof_hw_stop(struct snd_soc_component *component,
+			 struct snd_pcm_substream *substream, int cmd)
+{
+	struct msiof_priv *priv = snd_soc_component_get_drvdata(component);
+	struct device *dev = component->dev;
+	int is_play = msiof_is_play(substream);
+	u32 val;
+
+	/* SIIER */
+	if (is_play)
+		val = TDREQE | TDMAE | SISTR_ERR_TX;
+	else
+		val = RDREQE | RDMAE | SISTR_ERR_RX;
+	msiof_update(priv, SIIER, val, 0);
+
+	/* Stop DMAC */
+	snd_dmaengine_pcm_trigger(substream, cmd);
+
+	/* SICTR */
+	if (is_play)
+		val = TXE;
+	else
+		val = RXE;
+	msiof_update_and_wait(priv, SICTR, val, 0, 0);
+
+	/* indicate error status if exist */
+	if (priv->err_syc[substream->stream] ||
+	    priv->err_ovf[substream->stream] ||
+	    priv->err_udf[substream->stream])
+		dev_warn(dev, "FSERR(%s) = %d, FOVF = %d, FUDF = %d\n",
+			 snd_pcm_direction_name(substream->stream),
+			 priv->err_syc[substream->stream],
+			 priv->err_ovf[substream->stream],
+			 priv->err_udf[substream->stream]);
+
+	return 0;
+}
+
+static int msiof_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct msiof_priv *priv = snd_soc_dai_get_drvdata(dai);
+
+	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
+	/* it supports Clock/Frame consumer mode only */
+	case SND_SOC_DAIFMT_BC_FC:
+		break;
+	/* others are error */
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	/* it supports NB_NF only */
+	case SND_SOC_DAIFMT_NB_NF:
+	default:
+		break;
+	/* others are error */
+	case SND_SOC_DAIFMT_NB_IF:
+	case SND_SOC_DAIFMT_IB_NF:
+	case SND_SOC_DAIFMT_IB_IF:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		msiof_flag_set(priv, MSIOF_FLAGS_NEED_DELAY);
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * Select below from Sound Card, not auto
+ *	SND_SOC_DAIFMT_CBC_CFC
+ *	SND_SOC_DAIFMT_CBP_CFP
+ */
+static const u64 msiof_dai_formats = SND_SOC_POSSIBLE_DAIFMT_I2S	|
+				     SND_SOC_POSSIBLE_DAIFMT_LEFT_J	|
+				     SND_SOC_POSSIBLE_DAIFMT_NB_NF;
+
+static const struct snd_soc_dai_ops msiof_dai_ops = {
+	.set_fmt			= msiof_dai_set_fmt,
+	.auto_selectable_formats	= &msiof_dai_formats,
+	.num_auto_selectable_formats	= 1,
+};
+
+static struct snd_soc_dai_driver msiof_dai_driver = {
+	.name = "msiof-dai",
+	.playback = {
+		.rates		= MSIOF_RATES,
+		.formats	= MSIOF_FMTS,
+		.channels_min	= 2,
+		.channels_max	= 2,
+	},
+	.capture = {
+		.rates		= MSIOF_RATES,
+		.formats	= MSIOF_FMTS,
+		.channels_min	= 2,
+		.channels_max	= 2,
+	},
+	.ops = &msiof_dai_ops,
+};
+
+static struct snd_pcm_hardware msiof_pcm_hardware = {
+	.info =	SNDRV_PCM_INFO_INTERLEAVED	|
+		SNDRV_PCM_INFO_MMAP		|
+		SNDRV_PCM_INFO_MMAP_VALID,
+	.buffer_bytes_max	= 64 * 1024,
+	.period_bytes_min	= 32,
+	.period_bytes_max	= 8192,
+	.periods_min		= 1,
+	.periods_max		= 32,
+	.fifo_size		= 64,
+};
+
+static int msiof_open(struct snd_soc_component *component,
+		      struct snd_pcm_substream *substream)
+{
+	struct device *dev = component->dev;
+	struct dma_chan *chan;
+	static const char *dma_names[] = {"rx", "tx"};
+	int is_play = msiof_is_play(substream);
+	int ret;
+
+	chan = of_dma_request_slave_channel(dev->of_node, dma_names[is_play]);
+	if (IS_ERR_OR_NULL(chan))
+		return PTR_ERR(chan);
+
+	ret = snd_dmaengine_pcm_open(substream, chan);
+	if (ret < 0)
+		goto open_err_dma;
+
+	snd_soc_set_runtime_hwparams(substream, &msiof_pcm_hardware);
+
+	ret = snd_pcm_hw_constraint_integer(substream->runtime, SNDRV_PCM_HW_PARAM_PERIODS);
+
+open_err_dma:
+	if (ret < 0)
+		dma_release_channel(chan);
+
+	return ret;
+}
+
+static int msiof_close(struct snd_soc_component *component,
+		       struct snd_pcm_substream *substream)
+{
+	return snd_dmaengine_pcm_close_release_chan(substream);
+}
+
+static snd_pcm_uframes_t msiof_pointer(struct snd_soc_component *component,
+				       struct snd_pcm_substream *substream)
+{
+	return snd_dmaengine_pcm_pointer(substream);
+}
+
+#define PREALLOC_BUFFER		(32 * 1024)
+#define PREALLOC_BUFFER_MAX	(32 * 1024)
+static int msiof_new(struct snd_soc_component *component,
+		     struct snd_soc_pcm_runtime *rtd)
+{
+	snd_pcm_set_managed_buffer_all(rtd->pcm, SNDRV_DMA_TYPE_DEV,
+				       rtd->card->snd_card->dev,
+				       PREALLOC_BUFFER, PREALLOC_BUFFER_MAX);
+	return 0;
+}
+
+static int msiof_trigger(struct snd_soc_component *component,
+			 struct snd_pcm_substream *substream, int cmd)
+{
+	struct device *dev = component->dev;
+	struct msiof_priv *priv = dev_get_drvdata(dev);
+	unsigned long flags;
+	int ret = -EINVAL;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		priv->substream[substream->stream] = substream;
+		fallthrough;
+	case SNDRV_PCM_TRIGGER_RESUME:
+		ret = msiof_hw_start(component, substream, cmd);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		priv->substream[substream->stream] = NULL;
+		fallthrough;
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		ret = msiof_hw_stop(component, substream, cmd);
+		break;
+	}
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return ret;
+}
+
+static int msiof_hw_params(struct snd_soc_component *component,
+			   struct snd_pcm_substream *substream,
+			   struct snd_pcm_hw_params *params)
+{
+	struct msiof_priv *priv = dev_get_drvdata(component->dev);
+	struct dma_chan *chan = snd_dmaengine_pcm_get_chan(substream);
+	struct dma_slave_config cfg = {};
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	ret = snd_hwparams_to_dma_slave_config(substream, params, &cfg);
+	if (ret < 0)
+		goto hw_params_out;
+
+	cfg.dst_addr = priv->phy_addr + SITFDR;
+	cfg.src_addr = priv->phy_addr + SIRFDR;
+
+	ret = dmaengine_slave_config(chan, &cfg);
+hw_params_out:
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return ret;
+}
+
+static const struct snd_soc_component_driver msiof_component_driver = {
+	.name		= "msiof",
+	.open		= msiof_open,
+	.close		= msiof_close,
+	.pointer	= msiof_pointer,
+	.pcm_construct	= msiof_new,
+	.trigger	= msiof_trigger,
+	.hw_params	= msiof_hw_params,
+};
+
+static irqreturn_t msiof_interrupt(int irq, void *data)
+{
+	struct msiof_priv *priv = data;
+	struct snd_pcm_substream *substream;
+	u32 sistr;
+
+	spin_lock(&priv->lock);
+
+	sistr = msiof_read(priv, SISTR);
+	msiof_status_clear(priv);
+
+	spin_unlock(&priv->lock);
+
+	/* overflow/underflow error */
+	substream = priv->substream[SNDRV_PCM_STREAM_PLAYBACK];
+	if (substream && (sistr & SISTR_ERR_TX)) {
+		// snd_pcm_stop_xrun(substream);
+		if (sistr & TFSERR)
+			priv->err_syc[SNDRV_PCM_STREAM_PLAYBACK]++;
+		if (sistr & TFOVF)
+			priv->err_ovf[SNDRV_PCM_STREAM_PLAYBACK]++;
+		if (sistr & TFUDF)
+			priv->err_udf[SNDRV_PCM_STREAM_PLAYBACK]++;
+	}
+
+	substream = priv->substream[SNDRV_PCM_STREAM_CAPTURE];
+	if (substream && (sistr & SISTR_ERR_RX)) {
+		// snd_pcm_stop_xrun(substream);
+		if (sistr & RFSERR)
+			priv->err_syc[SNDRV_PCM_STREAM_CAPTURE]++;
+		if (sistr & RFOVF)
+			priv->err_ovf[SNDRV_PCM_STREAM_CAPTURE]++;
+		if (sistr & RFUDF)
+			priv->err_udf[SNDRV_PCM_STREAM_CAPTURE]++;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int msiof_probe(struct platform_device *pdev)
+{
+	struct msiof_priv *priv;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	struct device_node *port;
+	int irq, ret;
+
+	/* Check MSIOF as Sound mode or SPI mode */
+	port = of_graph_get_next_port(dev->of_node, NULL);
+	if (!port)
+		return -ENODEV;
+	of_node_put(port);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0)
+		return -ENODEV;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENODEV;
+
+	priv->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	ret = devm_request_irq(dev, irq, msiof_interrupt, 0, dev_name(dev), priv);
+	if (ret)
+		return ret;
+
+	priv->dev	= dev;
+	priv->phy_addr	= res->start;
+
+	spin_lock_init(&priv->lock);
+	platform_set_drvdata(pdev, priv);
+
+	devm_pm_runtime_enable(dev);
+
+	ret = devm_snd_soc_register_component(dev, &msiof_component_driver,
+					      &msiof_dai_driver, 1);
+	if (ret)
+		return ret;
+
+	dev_info(dev, "probed\n");
+
+	return ret;
+}
+
+static const struct of_device_id msiof_of_match[] = {
+	{ .compatible = "renesas,rcar-gen4-msiof", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, msiof_of_match);
+
+static struct platform_driver msiof_driver = {
+	.driver 	= {
+		.name	= "msiof-pcm-audio",
+		.of_match_table = msiof_of_match,
+	},
+	.probe		= msiof_probe,
+};
+module_platform_driver(msiof_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Renesas R-Car MSIOF I2S audio driver");
+MODULE_AUTHOR("Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>");
+MODULE_ALIAS("platform:msiof-pcm-audio");
-- 
2.43.0


