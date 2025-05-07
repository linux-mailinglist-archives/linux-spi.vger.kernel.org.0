Return-Path: <linux-spi+bounces-7940-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2229AAD354
	for <lists+linux-spi@lfdr.de>; Wed,  7 May 2025 04:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 149595049FF
	for <lists+linux-spi@lfdr.de>; Wed,  7 May 2025 02:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5583A172BB9;
	Wed,  7 May 2025 02:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="ZZ1bTpmT"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010046.outbound.protection.outlook.com [52.101.228.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D843B63A9;
	Wed,  7 May 2025 02:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746585248; cv=fail; b=cuerIVKkJl6b43ta/ix1YFZWgKP3g7OpzvgcDYlo8W3diW7LlNul3DhQMlfiXvt1yss34ZnbtCeAmOQ0axJK1FYmxevQ/9IJIGlS1eOicx7dVLiP53MGmpdVWfmgGEc6LJnYQRjZayGC1aLYZhpE7HVFMib6Ecwfz5ZN+s3Zljw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746585248; c=relaxed/simple;
	bh=9avvlB5oyJFUTrjZTCQ56wo1pJ49OybUr+chUyomOxw=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=e+8rsGhwHljrJlTazvI6xnKOwzi8NO/+cu4nb/eBpSy3btnHpTXePXIO6Czzr3x2aG3Hl2eF7myKXm9vlULuL47EY2GyDNLVuCRenS4tl1OhixgQ7UGwDbc4jUTLred2gK28FMr2A/ttbVse3BWf1s8X+ZwoK8b/yCRk7Ie2Wy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=ZZ1bTpmT; arc=fail smtp.client-ip=52.101.228.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ewxrRM79x/bww38LahNjIMWntiJcx7Hf+qcGKX4dx3+J9h3MBKQoPwOAfn/nebu5OKzHU1jZCB7iWO9F+vuPvwiXmBYLUUi4zOlpVtKe+Rppsap6cAc7cDpGL1Dbc6bbXTGNgMp9AEkbfm+kVPk9eV/yvTV6og+T3YaHbkF8UsXKYfR9/jV50LLr3dH6Pb2pbqmeTdeIRn2NFPy7+/KL/9HX7mbdjvR7yMKsPAQv5fznnq7nBUU7CYBMa2mo29MkHo0xyPaAE5t8btqsONwV7N1s6pnYRh6fRWlWJ1jlnHwe1RWRILORR4TcB2ontq1erg5jV4H1L8+YrqjhSJBERg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/uiAnbOFheM7ox/BnKTPpszgi10XJNrQUkqcQf5gWZM=;
 b=hu3N6ZS/5fhib+sJwAeknCKtqJEOsETJj0a9a/LWTQAtd8iU7/0T0PeoCSqCoWCNrCz8WKmMkamPbbt0oqZZq4DMtCWLWbQFsbXzY7cT8PfxKD9xowpq6O6hhUtEfiT2W6vtx5Hui+SDVoXrhqR08nTI8pibRfLq9BP5OPSz7rbPoiiHOYOiIbZaVZ8kgAu4TW5H8f0kLkDJNxgi5qJEwo9EQ8kTtVRXMqSwTaEZSPf3/N9CW3oNwkW1JZ3ytpB6LI/xkbToG/HVXZxgPnkF8hlgEoGiawNzDvTERyIDGG7N7RThC2Fy1s1z1EJKXZYOHCvyrdrnF6ahILL22v+ZaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uiAnbOFheM7ox/BnKTPpszgi10XJNrQUkqcQf5gWZM=;
 b=ZZ1bTpmTguDkU4VKJLuupeB8+B2KAj4ujhq0wxd0Kd/7kRfD91Y4YySwHVZvx6zKD9gUUSiCfCQHFok11l4iiyr4F1hcL7s1Y1bEmdMI1p19rodQoWmDrCPdd8qvT3x3v5Ligz9jV50KHyoiZcxiqgr5pdyyFbNC8AVv0HEacrE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OS9PR01MB12135.jpnprd01.prod.outlook.com
 (2603:1096:604:2e9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Wed, 7 May
 2025 02:34:01 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%7]) with mapi id 15.20.8699.024; Wed, 7 May 2025
 02:34:01 +0000
Message-ID: <8734dhcfom.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Koji Matsuoka <koji.matsuoka.xm@renesas.com>,
	linux-spi@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 22/22] ASoC: renesas: msiof: Convert to <linux/spi/sh_msiof.h>
In-Reply-To: <d8dfe7cdd8980e08b9fae51ff9fcddac20eca22b.1746180072.git.geert+renesas@glider.be>
References: <cover.1746180072.git.geert+renesas@glider.be>
	<d8dfe7cdd8980e08b9fae51ff9fcddac20eca22b.1746180072.git.geert+renesas@glider.be>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 7 May 2025 02:34:01 +0000
X-ClientProxiedBy: TYCP286CA0231.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::9) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OS9PR01MB12135:EE_
X-MS-Office365-Filtering-Correlation-Id: cfcb2d94-44e6-4cda-e0a6-08dd8d0fa099
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A9UDzdL59zgJSUBJbttNLvqxBEz+xxJRyCYtFTfoALt71DhulHVOItvmHr87?=
 =?us-ascii?Q?fPJSoUEW12yMl5xI3j/Z/5s5QwO65NbMjt55E3KPdrBdOMzcYgBd2V3tlUuR?=
 =?us-ascii?Q?YUevWdGXbAohuHKVrAKrzrXF7m3lcKF/DaQvAIVJ6f0k+iGM7TzFGzaFuYAp?=
 =?us-ascii?Q?+1hjjEgt2hgEMudQroDDuP79MvkHvLsqjvQeuC3//EOOmdaDiIXYeNAI4sf8?=
 =?us-ascii?Q?Om5dnAdjgrM08BXC2aSKxbVqfHfuL7L94HLb8z5YjByjquC/hbT42ezKyEan?=
 =?us-ascii?Q?svgs1IeeaUHPxAAStrSXndT/T5ClwJXnby6njfg54c/ao37qPo5BGmDvcpU9?=
 =?us-ascii?Q?1KyEWs8K7rJduaASvMwuET7ehuVN63+aEpI0WCdYZ0a8W+I30J8wbtXVp7+M?=
 =?us-ascii?Q?M9bQG3PrX/ki2eS//vjCnmgGjrLOFo7rHEmOblUAvXHlYoBxBg8WsQTmgHK4?=
 =?us-ascii?Q?Gm1yW6lfxoS1E1wH3RX0/3TJCSZX1QzEKJRruA78cj22r7GgW+YC0hcrHrO4?=
 =?us-ascii?Q?ipqrpNrHIJSesHsEJxFf7fw43B31+KcSwTXzbOvemodDq1mn7n6cCRohLRNl?=
 =?us-ascii?Q?M+8bJ/RLf0FF7hOh9hRrem/5meR3wcc4+egwxCvWRPWAhQ+nRHoCHtplJ29g?=
 =?us-ascii?Q?EeVe503rkIXWvCm/kbDjaAfqlueJo9crVBJw8NdywmH6ExqKvo89/oEQX4iT?=
 =?us-ascii?Q?IhwDZo63RqT/5S5kzs/yXqylc+rxiyAi4Y2Fl3YD2cBHtFeq1tpIjU1nlVFK?=
 =?us-ascii?Q?A6J7QSf1zddeecHXwDFqoeR0p3aeY5HrkEHcL/me9PAMDvxzAsy4sdiXIA1S?=
 =?us-ascii?Q?aTrwZscADlr2HboxbRz42d6nNX6YMsqcLYZpf2rJLl2MtP9gnsSjK1j7Xmz4?=
 =?us-ascii?Q?V99CdVphuV3KqEgRnq35wl86oapuk4C1KqwPq348ZRzWFthhVZsdVRXTBAij?=
 =?us-ascii?Q?nOFMCdRCaqNDTsjMsnR0TauCgdV/pZP+AR+C+Z2CrmwNE66shOFjO7OVG96x?=
 =?us-ascii?Q?78NH+QpoisTS/Mv9/3UqF0Yq4NHQOSat1BIJJkTThx2stfBaybOe72YlyByv?=
 =?us-ascii?Q?zH0yvh3Ou7QrNWVb1FQOCbRXyhZ4Sxs5QbZCwHYVnEgWeRqzzYipYcRZw+cM?=
 =?us-ascii?Q?r986eEemj2/09BOY/ZPk5muk7ne1O/fp0BDmcXGpmZeXG/kg9+DmxL6gJa/e?=
 =?us-ascii?Q?JRanUWxnNvM5viQSmIxqN5N/WHZRPr2bKHEgbsQmZi8UWl6g9FbPw4ZEqCG0?=
 =?us-ascii?Q?+VFiWLh2j48PROjFvg5ZgBQJcDp47LHYallNkGsUIcLeCn7qjfTBmCuVfXTw?=
 =?us-ascii?Q?6YDCrDbIByHKb+1EEtpA1jTez9yz3Ay09Q1FeYWd1jF+Ze0Re2eBZxJ34CRQ?=
 =?us-ascii?Q?G6YaVdLOi89fuZ0qN87Dw+vMBlb40cwgGTBXOJbtGquMmylIGPbfF3+TU6BX?=
 =?us-ascii?Q?6EO/uv5c+CMR/MhwLY3xgFzhrn8WJQlmxgzFMof1BvpcLw3bKvV2rQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rLRQqqkaUTlZGqgP0gvdZwd3BkFQ5rxjTuzOJiBdNYoJeGMQTIx0xzpcbA5r?=
 =?us-ascii?Q?s4yes7r+4YyKf6+xMlMi5ezFAVrMXh5vJHd2ZHKxSe3RgciSmqBHnE0yupd5?=
 =?us-ascii?Q?9IwUNfaFY41kOZxLt7W4+X2YBL7vVmf8NFuVvrsqnt7t9nDHBHRb3OXqbNaM?=
 =?us-ascii?Q?PIR6vzpand4y6zHeeWDejiYIHmLH/LAov4GxgnhbIWmtQ/4ihh2xhHvKhrwf?=
 =?us-ascii?Q?NHsZBXC+ISbQ2P3RIjT/wtCUFDdl1IhOUm2YOC6AN995tGEcIRpWgxQ37G0x?=
 =?us-ascii?Q?iUGA6FUcL6vmvHAHNh8sRwYUUexq6oLrayxx0NxXtdqdcHioNfCttba6fzx4?=
 =?us-ascii?Q?3Edibb4oOdFjsmEPScIjEMi6LbNVxZklE2mwLDFDAh1PsbCKcimmdwhtLSxj?=
 =?us-ascii?Q?bJjBvLD5RNdUB9AVQw47j5lR76mAGqiHVpWEuqz2g42276cePsJVRs4qckhn?=
 =?us-ascii?Q?R66dgO7ZKejrxvQ90GVQq+z3nggjGciYt/eWOub3aoMZiJxSAY4s4Q3ofgh1?=
 =?us-ascii?Q?iTCLq2tCC+JVedppIBh370SpkNdF49XZqf8cXe9IQdfV7UgPUpnN5SXh9BX6?=
 =?us-ascii?Q?VBwJDE+lU0CQI4OYFilLwyTuddF2LZyGi7XDCWd7Jhy4RGWQv1dCAguHX1qP?=
 =?us-ascii?Q?xEny32PKlxYNajdTSsJILVo384CUKKzrN5x92iXorLjhgSNyQDmLoEhzd8In?=
 =?us-ascii?Q?uv/bubeG8cofqu3pXKeE9iJMNEe/yjl32idziE1ak+zMJ025MsMA7LybcjYs?=
 =?us-ascii?Q?lR02S+rZBZqUPmvYrFNndS33nXbos7JTHllJketbyAgMNnLVAnOesqkGkjQR?=
 =?us-ascii?Q?cFtvnpyCGrf1bj5zf2VPYyIelwf0mWL//ecRN/hHbsJYGbIp/W09CeUOiB3J?=
 =?us-ascii?Q?L5GETkK8YQpq0vfU6pK63If0RUCXxNnad+0FD8Fpos16fdVZzAkCSbkV5Sd+?=
 =?us-ascii?Q?+oCojMpVPlV2BcLxOpjqgCEP/wehB1f1CWC9BrMHum8JAc9XRnfaAa0SaMkT?=
 =?us-ascii?Q?MWiBx7ROLWflZzqtcihPynMC/GjU7nkEFpBkaegRo7tuNsGUdOyLUxq8gYyZ?=
 =?us-ascii?Q?BwUdeyQogjMpEhKV1F+E1D7jGxjkWdoGbEXIyLbWN3JRijpox8zj3/U1QDCX?=
 =?us-ascii?Q?U9w0RN8emTmnnTetYk3bPQIPNfQtzmkUER/JdXZPS7I6D9uozpau4GAl+tBp?=
 =?us-ascii?Q?gA+FEQP9+vfpUwTxj97AR983jFPwd1bQFrudew/qzJKyM7CP8NF2XxfHkEH3?=
 =?us-ascii?Q?YzTs7VVMPPmFL9a9WJriu3NSDyhO0JV8zmjTTteRbNUq5Pwok13t4jH4ZF0v?=
 =?us-ascii?Q?f/RTYFRzh2+g72rDVWG2ctgd08cDgMt0g9YCum9wPMvJpMgYjtHDKIPb1YfJ?=
 =?us-ascii?Q?w2NFI3kfImnB8XfE2JC5yqeKBlFUXHI72mz0N4ZUjKPZtvEzvvkYejg7peRe?=
 =?us-ascii?Q?wGNuQv7jhD7/sJhzdFjtIvRGrweMKTRYK2JqmK1lomHpZ9afOvo237DJ++nT?=
 =?us-ascii?Q?n2DTURXR6rSoaOK7js6O2keiOXibRPJt8Jcfx4D3hXZjogGQ5NyukDAYZ5Di?=
 =?us-ascii?Q?ST+59+CE7u/B+CuCqYlD/c0HNlRsMcp2QKK3UATHRI5/5rTeIM2ABpqYXYZc?=
 =?us-ascii?Q?/e4bAAtAnhlGbKpXJokji24=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfcb2d94-44e6-4cda-e0a6-08dd8d0fa099
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 02:34:01.7112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pG6Q8zOGuSAYIPFFPsTTQcCT6Y8pw6d7geI8AOowE7TEBr7difl1qWf1U2gb1IzvUmd6HbMwV8rczJkIebZkSImDbYzCmhu5HyrN3d/Iv9mIE5QoOSVHF1wAzanJTmk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB12135


Hi

> Convert the MSIOF I2S driver to reuse the MSIOF register and register
> bit definitions in the header file shared by the MSIOF SPI driver.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

For MSIOF Sound part

Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

> Compile-tested and asm-inspected only due to lack of local sound
> hardware.
> ---
>  sound/soc/renesas/rcar/msiof.c | 94 ++++++++++------------------------
>  1 file changed, 28 insertions(+), 66 deletions(-)
> 
> diff --git a/sound/soc/renesas/rcar/msiof.c b/sound/soc/renesas/rcar/msiof.c
> index 75c9e91bada10289..36d31ab8ac6a5f18 100644
> --- a/sound/soc/renesas/rcar/msiof.c
> +++ b/sound/soc/renesas/rcar/msiof.c
> @@ -30,56 +30,15 @@
>  #include <linux/of_graph.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/spi/sh_msiof.h>
>  #include <sound/dmaengine_pcm.h>
>  #include <sound/soc.h>
>  
> -/* register */
> -#define SITMDR1		0x00
> -#define SITMDR2		0x04
> -#define SITMDR3		0x08
> -#define SIRMDR1		0x10
> -#define SIRMDR2		0x14
> -#define SIRMDR3		0x18
> -#define SICTR		0x28
> -#define SISTR		0x40
> -#define SIIER		0x44
> -#define SITFDR		0x50
> -#define SIRFDR		0x60
> -
> -/* SITMDR1/ SIRMDR1 */
> -#define PCON		(1 << 30)		/* Transfer Signal Connection */
> -#define SYNCMD_LR	(3 << 28)		/* L/R mode */
> -#define SYNCAC		(1 << 25)		/* Sync Polarity (Active-low) */
> -#define DTDL_1		(1 << 20)		/* 1-clock-cycle delay */
> -#define TXSTP		(1 <<  0)		/* Transmission/Reception Stop on FIFO */
> -
> -/* SITMDR2 and SIRMDR2 */
> -#define BITLEN1(x)	(((x) - 1) << 24)	/* Data Size (8-32 bits) */
> -#define GRP		(1 << 30)		/* Group count */
> -
> -/* SICTR */
> -#define TEDG		(1 << 27)		/* Transmit Timing (1 = falling edge) */
> -#define REDG		(1 << 26)		/* Receive  Timing (1 = rising  edge) */
> -#define TXE		(1 <<  9)		/* Transmit Enable */
> -#define RXE		(1 <<  8)		/* Receive Enable */
> -
>  /* SISTR */
> -#define TFSERR		(1 << 21)		/* Transmit Frame Synchronization Error */
> -#define TFOVF		(1 << 20)		/* Transmit FIFO Overflow */
> -#define TFUDF		(1 << 19)		/* Transmit FIFO Underflow */
> -#define RFSERR		(1 <<  5)		/* Receive Frame Synchronization Error */
> -#define RFUDF		(1 <<  4)		/* Receive FIFO Underflow */
> -#define RFOVF		(1 <<  3)		/* Receive FIFO Overflow */
> -#define SISTR_ERR_TX	(TFSERR | TFOVF | TFUDF)
> -#define SISTR_ERR_RX	(RFSERR | RFOVF | RFUDF)
> +#define SISTR_ERR_TX	(SISTR_TFSERR | SISTR_TFOVF | SISTR_TFUDF)
> +#define SISTR_ERR_RX	(SISTR_RFSERR | SISTR_RFOVF | SISTR_RFUDF)
>  #define SISTR_ERR	(SISTR_ERR_TX | SISTR_ERR_RX)
>  
> -/* SIIER */
> -#define TDMAE		(1 << 31)		/* Transmit Data DMA Transfer Req. Enable */
> -#define TDREQE		(1 << 28)		/* Transmit Data Transfer Request Enable */
> -#define RDMAE		(1 << 15)		/* Receive Data DMA Transfer Req. Enable */
> -#define RDREQE		(1 << 12)		/* Receive Data Transfer Request Enable */
> -
>  /*
>   * The data on memory in 24bit case is located at <right> side
>   *	[  xxxxxx]
> @@ -174,42 +133,45 @@ static int msiof_hw_start(struct snd_soc_component *component,
>  
>  	/* SITMDRx */
>  	if (is_play) {
> -		val = PCON | SYNCMD_LR | SYNCAC | TXSTP;
> +		val = SITMDR1_PCON |
> +		      FIELD_PREP(SIMDR1_SYNCMD, SIMDR1_SYNCMD_LR) |
> +		      SIMDR1_SYNCAC | SIMDR1_XXSTP;
>  		if (msiof_flag_has(priv, MSIOF_FLAGS_NEED_DELAY))
> -			val |= DTDL_1;
> +			val |= FIELD_PREP(SIMDR1_DTDL, 1);
>  
>  		msiof_write(priv, SITMDR1, val);
>  
> -		val = BITLEN1(width);
> -		msiof_write(priv, SITMDR2, val | GRP);
> +		val = FIELD_PREP(SIMDR2_BITLEN1, width - 1);
> +		msiof_write(priv, SITMDR2, val | FIELD_PREP(SIMDR2_GRP, 1));
>  		msiof_write(priv, SITMDR3, val);
>  
>  	}
>  	/* SIRMDRx */
>  	else {
> -		val = SYNCMD_LR | SYNCAC;
> +		val = FIELD_PREP(SIMDR1_SYNCMD, SIMDR1_SYNCMD_LR) |
> +		      SIMDR1_SYNCAC;
>  		if (msiof_flag_has(priv, MSIOF_FLAGS_NEED_DELAY))
> -			val |= DTDL_1;
> +			val |= FIELD_PREP(SIMDR1_DTDL, 1);
>  
>  		msiof_write(priv, SIRMDR1, val);
>  
> -		val = BITLEN1(width);
> -		msiof_write(priv, SIRMDR2, val | GRP);
> +		val = FIELD_PREP(SIMDR2_BITLEN1, width - 1);
> +		msiof_write(priv, SIRMDR2, val | FIELD_PREP(SIMDR2_GRP, 1));
>  		msiof_write(priv, SIRMDR3, val);
>  	}
>  
>  	/* SIIER */
>  	if (is_play)
> -		val = TDREQE | TDMAE | SISTR_ERR_TX;
> +		val = SIIER_TDREQE | SIIER_TDMAE | SISTR_ERR_TX;
>  	else
> -		val = RDREQE | RDMAE | SISTR_ERR_RX;
> +		val = SIIER_RDREQE | SIIER_RDMAE | SISTR_ERR_RX;
>  	msiof_update(priv, SIIER, val, val);
>  
>  	/* SICTR */
>  	if (is_play)
> -		val = TXE | TEDG;
> +		val = SICTR_TXE | SICTR_TEDG;
>  	else
> -		val = RXE | REDG;
> +		val = SICTR_RXE | SICTR_REDG;
>  	msiof_update_and_wait(priv, SICTR, val, val, val);
>  
>  	msiof_status_clear(priv);
> @@ -230,9 +192,9 @@ static int msiof_hw_stop(struct snd_soc_component *component,
>  
>  	/* SIIER */
>  	if (is_play)
> -		val = TDREQE | TDMAE | SISTR_ERR_TX;
> +		val = SIIER_TDREQE | SIIER_TDMAE | SISTR_ERR_TX;
>  	else
> -		val = RDREQE | RDMAE | SISTR_ERR_RX;
> +		val = SIIER_RDREQE | SIIER_RDMAE | SISTR_ERR_RX;
>  	msiof_update(priv, SIIER, val, 0);
>  
>  	/* Stop DMAC */
> @@ -240,9 +202,9 @@ static int msiof_hw_stop(struct snd_soc_component *component,
>  
>  	/* SICTR */
>  	if (is_play)
> -		val = TXE;
> +		val = SICTR_TXE;
>  	else
> -		val = RXE;
> +		val = SICTR_RXE;
>  	msiof_update_and_wait(priv, SICTR, val, 0, 0);
>  
>  	/* indicate error status if exist */
> @@ -478,22 +440,22 @@ static irqreturn_t msiof_interrupt(int irq, void *data)
>  	substream = priv->substream[SNDRV_PCM_STREAM_PLAYBACK];
>  	if (substream && (sistr & SISTR_ERR_TX)) {
>  		// snd_pcm_stop_xrun(substream);
> -		if (sistr & TFSERR)
> +		if (sistr & SISTR_TFSERR)
>  			priv->err_syc[SNDRV_PCM_STREAM_PLAYBACK]++;
> -		if (sistr & TFOVF)
> +		if (sistr & SISTR_TFOVF)
>  			priv->err_ovf[SNDRV_PCM_STREAM_PLAYBACK]++;
> -		if (sistr & TFUDF)
> +		if (sistr & SISTR_TFUDF)
>  			priv->err_udf[SNDRV_PCM_STREAM_PLAYBACK]++;
>  	}
>  
>  	substream = priv->substream[SNDRV_PCM_STREAM_CAPTURE];
>  	if (substream && (sistr & SISTR_ERR_RX)) {
>  		// snd_pcm_stop_xrun(substream);
> -		if (sistr & RFSERR)
> +		if (sistr & SISTR_RFSERR)
>  			priv->err_syc[SNDRV_PCM_STREAM_CAPTURE]++;
> -		if (sistr & RFOVF)
> +		if (sistr & SISTR_RFOVF)
>  			priv->err_ovf[SNDRV_PCM_STREAM_CAPTURE]++;
> -		if (sistr & RFUDF)
> +		if (sistr & SISTR_RFUDF)
>  			priv->err_udf[SNDRV_PCM_STREAM_CAPTURE]++;
>  	}
>  
> -- 
> 2.43.0
> 
> 




Thank you for your help !!

Best regards
---
Kuninori Morimoto

