Return-Path: <linux-spi+bounces-7583-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E350DA8915A
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 03:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24B74189BF96
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 01:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5961714C0;
	Tue, 15 Apr 2025 01:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="S6dNeJ9X"
X-Original-To: linux-spi@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010044.outbound.protection.outlook.com [52.101.229.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D91960DCF;
	Tue, 15 Apr 2025 01:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744680866; cv=fail; b=moBEgBWXwHIY9qvuJJKCmRb325exx/RvwiaC6UOHAjOOG4Nce8pd9eKDmTVUnP8+VceVqJq/kbK7MaB4RHbZVXeW6Jxqvb7h6WUJVS5pMNW7XlcuLi5dADy1o/DFwrlA8Rp/GDDQXWeFjHg9oczTPCZ8hSB3NRHcSn38MpDjy48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744680866; c=relaxed/simple;
	bh=4B5JgVPtGfSlAxTTd2GXnSWxlU3ELbIJ5uz56NDG5vA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=gGAHzTdrV0TX/JEOcDQrrUBR6Sq/6kc0dK3EB4+BojFIxuOfIuv3IPI3GPpxbg+F0z+YU6lUEl093P4ZB9EaclK003RuI4fV1PQS8JpuUd8DKXozTQMTNcbTn3lBAWcyEXUnONiO5umzYYgySxVeOgGzs0PelpbXslIWCoS3sJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=S6dNeJ9X; arc=fail smtp.client-ip=52.101.229.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNhH+R1cQNpadziHjva28mei4N3WqVveFSwyj7qtG1xLjyY4GsVHv27c+2R2Wt9kU6UOuPfsf3mycSGQuGBD3wUn75cPKaAjyLDxPZHv4kAEZ47MAbp5c3122BTlvJfhRQzEROIhzE1Y3qCLYtRsFAAocCToLPvGfgD7S3EFX1raf95f3ROfDfnFftUiFuhgU8Mqfvwnnkyifa1o7TKMEv7i9eUrT+XBTi7xscq3Csi2Bn8m+32j0bSWKculjnademeikJ63PLS2PyBCUd6+ZauljXiK2oBxsD6PHh2wn5Jd8XJiHrjVz3iIL+Rm7unL809ZyoqCDa7YwocFnazKVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAIIYEHvlIdvOUhRBEaw32G8fowcWoBP463Phqc9Jck=;
 b=erwQk7BfILRyyd6WNIgTMp1ekWj7F32QePq5cnKVZQAthKbDgJdUAltfE6hJ/zsFcfKCyZVoSaHufw46w3aaJVXHB9oj1ViU8LQobfINalqhHJObZemxgfUYULY7DFfpUsDZ251MNToi22A9YlztN9cvjN3Xw2hCmWBpkGtmm4U/bmZ3JvVjPuNsgAk6EcKLnugTMCFcHQ2w+R8LSedVAnclDbh6LJXnbKen+qu8y+PGFrwCuO2QyNAqCcC+KKoRFnWrygN8aKEeLsN2Qe9ia0dTeP1KMfSXBknoNyZRCDycJTI/jn5vfq1GdW/cBSwV+UxX1qd729vrn61XsUDN5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAIIYEHvlIdvOUhRBEaw32G8fowcWoBP463Phqc9Jck=;
 b=S6dNeJ9X8n3f7PAjtKMIlzoM9lSh/o45oYb6mj/BaluD787YghNAF+dZPUl3OMwLV4c/q1VuFG6EuZR/WjyXhyXJEZg4hGNDjpwwv8uEFki7yzPfDpqEfDg4D545YnvQIvJY3SUkrKWVtsHtfudUXLuBV3pN0hSNQTbkWACVSg0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TY3PR01MB10906.jpnprd01.prod.outlook.com
 (2603:1096:400:3af::14) by TYCPR01MB9536.jpnprd01.prod.outlook.com
 (2603:1096:400:193::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Tue, 15 Apr
 2025 01:34:16 +0000
Received: from TY3PR01MB10906.jpnprd01.prod.outlook.com
 ([fe80::592:9b7b:ef57:2dd8]) by TY3PR01MB10906.jpnprd01.prod.outlook.com
 ([fe80::592:9b7b:ef57:2dd8%6]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 01:34:16 +0000
Message-ID: <87sema1a3r.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v3 05/10] ASoC: renesas: rsnd: care BRGA/BRGB select in rsnd_adg_clk_enable()
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
To: Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jaroslav Kysela <perex@perex.cz>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Takashi Iwai <tiwai@suse.com>,
	Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
	ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-spi@vger.kernel.org
In-Reply-To: <87zfgi1a5a.wl-kuninori.morimoto.gx@renesas.com>
References: <87zfgi1a5a.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 15 Apr 2025 01:34:16 +0000
X-ClientProxiedBy: TYAPR01CA0078.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::18) To TY3PR01MB10906.jpnprd01.prod.outlook.com
 (2603:1096:400:3af::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB10906:EE_|TYCPR01MB9536:EE_
X-MS-Office365-Filtering-Correlation-Id: f8006f4d-4ba8-4e2b-5c55-08dd7bbda2d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|1800799024|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kTiI11yH2DkHQQioDdJyQ7C2Rfya6mwCpcWxeYuJ9uKxSHXFKfiDJiYEf7wV?=
 =?us-ascii?Q?1VBp1hyWH4TPTkpby/II7/2tpXuATa8gosj12Bi5Yp7rX7LcYBT3iIDiCgCL?=
 =?us-ascii?Q?ps3qplOC4o7W1Zvet7ul/5E/zTzLOONtd/PNlH7MRLtHP5XJguGFVPG4CQHz?=
 =?us-ascii?Q?b+4cRp7JWbnb+F//PJkTGtxIHKrYJpNUY0y1HZeEb6p37UqPCiA8PvMg1USY?=
 =?us-ascii?Q?iGZK6F8DRdBZghzHBneBnJMPuK8K/d1/o0NLL5dC9ZpArqoyzVMqS5ZKnnxw?=
 =?us-ascii?Q?RByvM1+tG07R6Uf8/vZxrh/9e4/PAONi6RhBhUTIiXRsRPp5I+PggrnhB5Gp?=
 =?us-ascii?Q?AlNDmJWMkjuby+1mApH1ocQPzI+gXtatjzfuoHjcR/2C+6t8/+HY57Lq4n8t?=
 =?us-ascii?Q?DrNDIK7kcDhrJX/4WvHcsGq78aVn9GQEr4q9bS441CAc5VhiMED23GLKBopb?=
 =?us-ascii?Q?Nov1ymArV5JiqncUxioBgWFpXwlEb2m8F2KUqEilC/xUn9OQGIzYox4cPWKJ?=
 =?us-ascii?Q?qlC8EilMqARqOkuHDjsqEdPc+18mKOZNf7/x1exfEiOCxEqUTkJOYeQBbaxE?=
 =?us-ascii?Q?c+bYJ3Ueh8l7qqNwDEqSKUSwn0z5lgMr2ThdgTWxPW4WXB8zhFYyD5qnjPXF?=
 =?us-ascii?Q?u0viwFXEHeD3zRetX5rhaB5ZZNOjlNM+GNYR+GkxYPc1NCbe9SyY1UQflsvH?=
 =?us-ascii?Q?qSw8JM8zirMNiPCIvWkOb7Upp1DC2s/vPX8g4Bygu4SunmHJydnitMWiDvnJ?=
 =?us-ascii?Q?ecDBaiSElpMRKgiqLBmJgFxpgYmydSdrLdWBMO0AMC6IA1MPXb1bVLdnQEiP?=
 =?us-ascii?Q?Gls9RvaRQDG88Ri2S4AGVkPyEsUoIrnRbQnhBlIWfZ9bo60HLnBJu/WO17PG?=
 =?us-ascii?Q?P9gx8Q6VFn5VuQ3XsiF8aNVw6aesCv/th1fjKN6Nw5WaJxGLroHciOt8kp3+?=
 =?us-ascii?Q?QnpS/NOkYLXOlvBXrX+qpOgm05prL4p2W7qiKsxDveUa9HqHbZK+bGgCMzbv?=
 =?us-ascii?Q?meut51t7fdihQHGjXRx/T8ebGHdkCaqRX7RoO1M7lfUo1zkUOOcC5AburkDr?=
 =?us-ascii?Q?9xDHb8tMSsnnAloiwmm/JyHpitA0bA/m7qNuFSaVa0t1Q34nDCw4/PNsU5r8?=
 =?us-ascii?Q?L49hq/D2W6XKAOASlSfnLsNNN4A1M/AxdqVnqKAOozfxGvXkYY7nokmJejKe?=
 =?us-ascii?Q?EsIfVoPxR+5fobiHGwueO0yqkEkemF2OHxo2LiuvdSyaXzapbNNmwfOZd5DP?=
 =?us-ascii?Q?9fh5OhQkSetp/86dDi+7jyM2XE3z9MZAUakITF0pl/OERF8Ydl22ZQ+4dKKa?=
 =?us-ascii?Q?ryBehVQMXWKzNMKTSMzcoAq0FfSNAVBp9PPfaxtfYuZGPBEjCxf7h9XX6i1S?=
 =?us-ascii?Q?+bjbP+ar/6Ent4dAXnp1pQPWke58TLucjpel1joaiANpjE7dOIOxEJI4xjOu?=
 =?us-ascii?Q?kKyrPYi0OtOMJBA+hZy12XIhXBxi94ou+0DsAvk2ZjsHYarhxaW/5i5tj9Cj?=
 =?us-ascii?Q?R9jRxJQOAF/VHQU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB10906.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(1800799024)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XFXkSPOqIiu1dcaVk0NWSnhspG4Tl7M8DSl9PUqq7n5gTQqmqQVaBusbCHap?=
 =?us-ascii?Q?6Ao7h3GjX61n1+OnMwyhWlmnnKNGbSRBIVw7YppYZhNLBMSUneKlr3C0+O7G?=
 =?us-ascii?Q?MX9CT9Hlx9krPzVn9F1deI0vHg4k36JzY3oxkDPqh2ZCxOB/cM6Bo3p0cpPq?=
 =?us-ascii?Q?o3nLbe9XX9Q7wl6LXetnU9hXzv/WafFgwHlUJ+NRqhbNXkpb9lGBzKhfjE4C?=
 =?us-ascii?Q?eb8xGOqeL5iZP53A22ijHn0TEewUCzUbhyGWTzrQaf/B4G5VdQc3tOVrXPJE?=
 =?us-ascii?Q?FH+pnOoQaki6y3uLfyImsM/EMUbQKcoBi7FY/XaInDM8ZSQ/F9kH/0aFNqRT?=
 =?us-ascii?Q?fKP0l2ZWE7LxbTcZgCwFesTGgdBe91X3Q+AYy2X3CR/KNhQMI2B/wHMTqvNx?=
 =?us-ascii?Q?IiO4Ghms/8F53daTlrcrMhTTatnbZR3fMMprkJwbmex6TXlXj9j+79m9216Y?=
 =?us-ascii?Q?kvze1c+Nx9f5hmSaUhbK8KkNgbhxTLefAuQdasFgerzLLm/A4F0Eikp47u0j?=
 =?us-ascii?Q?D6eiIewrUGBZOBBBITAjGXmPFcjv+hnCXQm+HWfysBYaamSWzBJcs8CLB7Z8?=
 =?us-ascii?Q?eN1UhV3eD9UOoMn049diRkbeOlQNvOq8YVuJTSIC4oybPKKd2LFMWmBP5wqj?=
 =?us-ascii?Q?VFe884d5b7xKeQbYHXjW3s/QnhK0NJRydBHJpOHKsekSSolBqD7i9IVs9KRa?=
 =?us-ascii?Q?UjKdpGV2dDJpvaFwTGwX2Ob5/oVd6y8sEIKAJtD9KYSvT6nLiNtqyCZ4xRlT?=
 =?us-ascii?Q?V8oas+nhhZ19DW7R9DjHC7UDqQZmpz4rMkACFnJ6nx4H94IzYM2j5HEoHEgu?=
 =?us-ascii?Q?KUQqSc4s7AttTgPpFcpJVD6jAvDnjCofSQnNqNazuUQblmSM0QcCJVV1GhW+?=
 =?us-ascii?Q?tlBPQuajdDuJaOR3++pEVFutjw5xfg2pB1XgiBC51owhE/H0Ek4fZZsy7aML?=
 =?us-ascii?Q?2PW/MkH59a5g4+WhuJzag7dagVgNt4itMct7peM2SA9deobhlJ4S+f98R3yT?=
 =?us-ascii?Q?ePhHKiECeEkjLUTMjjmVDddwJrgL6UM8QRy/K0z6LYxAbeGwX1wuZUYHuW2K?=
 =?us-ascii?Q?8Zgf56DQ8JJBMW5s8RWa4vsbmMYqfcpgd5gAGx5QycrMQwlciTChDI8qe4sd?=
 =?us-ascii?Q?mNGE8+3GH2geJo8RWtbQE96zXkttQjK+3nVzYftzkUZqXUV8lPOmEjhOu9lS?=
 =?us-ascii?Q?UrGBn/whHyo/34XDz4n8VH1/7G2vFUlP/Dk8WyGyt/qVn9C9McnWQ02F2t8m?=
 =?us-ascii?Q?RPUJlqZQtSgFbpTsSQKvy/SDTgNHjOAvI9VYx6GXljU7oP9/x4KXZqPNrCf9?=
 =?us-ascii?Q?XAMkfm8+4wYmevy7/NzIHLJ5mRjTSglhqAG+EuT6ebX0B5lsXa44mPzTe0X1?=
 =?us-ascii?Q?wGpMb0Il4QQ7kei8+doMgAUDWLfP+c4AmrnHbeSEE+SpTQfzE6RblJyPfhtg?=
 =?us-ascii?Q?Ic3MAkZJz3A7QolDRUd/iY6kbVfBAulC8N0SxdtrXFgEZz5YClVYLNLcWvF9?=
 =?us-ascii?Q?aE8agJE/pl3B8CCQYJ3wXkuSNHBpiQPA9snKwLluXwbSju9laU1qUSZVUh6A?=
 =?us-ascii?Q?ynSKE6CdoY6cs+L8jITVs1v8h9mFj9RrbBpBz159erz8HLJxRI1ephge3Sv5?=
 =?us-ascii?Q?dN4YNzlJs/40+2Aq+vy0RL8=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8006f4d-4ba8-4e2b-5c55-08dd7bbda2d5
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB10906.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 01:34:16.8588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0tPH84+RIog1m8Iz0n7P0wRQb2AqUEQs8/0eCAHQ8vCmgpcuWFaGA2vgclyuEwqBTM0d5c+oP2Y9l2xq+z35QjYVlf4APJd79LuJDuInkoyvTAiX2NeyAlOsVdq5Xftu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9536

Renesas rsnd related clocks are enabled by rsnd_adg_clk_enable(),
but it doesn't care about BRGA/BRGB selection (It is handled when
SSI was started) (BRGA is used for 44.1kHz lineage, BRGB is used for
48kHz lineage in this driver).

But it should be handled since probe time.
Includes BRGCKR_31 in adg->ckr to handle it since boot time.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/renesas/rcar/adg.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/sound/soc/renesas/rcar/adg.c b/sound/soc/renesas/rcar/adg.c
index 191f212d338c..e6b7273b27ad 100644
--- a/sound/soc/renesas/rcar/adg.c
+++ b/sound/soc/renesas/rcar/adg.c
@@ -19,6 +19,7 @@
 #define CLKOUT3	3
 #define CLKOUTMAX 4
 
+#define BRGCKR_31	(1 << 31)
 #define BRRx_MASK(x) (0x3FF & x)
 
 static struct rsnd_mod_ops adg_ops = {
@@ -361,10 +362,13 @@ int rsnd_adg_ssi_clk_try_start(struct rsnd_mod *ssi_mod, unsigned int rate)
 
 	rsnd_adg_set_ssi_clk(ssi_mod, data);
 
+	ckr = adg->ckr & ~BRGCKR_31;
 	if (0 == (rate % 8000))
-		ckr = 0x80000000; /* BRGB output = 48kHz */
-
-	rsnd_mod_bset(adg_mod, BRGCKR, 0x80770000, adg->ckr | ckr);
+		ckr |= BRGCKR_31; /* use BRGB output = 48kHz */
+	if (ckr != adg->ckr) {
+		rsnd_mod_bset(adg_mod, BRGCKR, 0x80770000, adg->ckr);
+		adg->ckr = ckr;
+	}
 
 	dev_dbg(dev, "CLKOUT is based on BRG%c (= %dHz)\n",
 		(ckr) ? 'B' : 'A',
@@ -683,6 +687,9 @@ static int rsnd_adg_get_clkout(struct rsnd_priv *priv)
 	}
 
 rsnd_adg_get_clkout_end:
+	if (0 == (req_rate[0] % 8000))
+		ckr |= BRGCKR_31; /* use BRGB output = 48kHz */
+
 	adg->ckr = ckr;
 	adg->brga = brga;
 	adg->brgb = brgb;
-- 
2.43.0


