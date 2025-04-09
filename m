Return-Path: <linux-spi+bounces-7467-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D485A81A3E
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 03:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C014719E89A8
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 01:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB2F12B17C;
	Wed,  9 Apr 2025 01:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="Ntf69yEG"
X-Original-To: linux-spi@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011012.outbound.protection.outlook.com [52.101.125.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4516F41760;
	Wed,  9 Apr 2025 01:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744160722; cv=fail; b=gWbyJ1roxWoBbd1PtvFjL677sI6hZono71cDGQcF10rrBGcLLpBAC2yncIWHwHBzDq36QYiui7Cw5tTuc0UvULNBgthiHSdurfDmbIMcaAVxnPjbzh/HrZ0pJqwbQvMalSpWC5+qA+TFKMZbfD18m/Y15zneNX02XxH9/tTKpQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744160722; c=relaxed/simple;
	bh=5qHCs+kC1BP6WfYYckz1els1K38Ju97D8PqvI5k+rn4=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=htJt162JRsJKYixM16nrY0MnSqrJSpWp8d2BVoPSmhQPTl/qg0RGvWIa/AJHoyLAdNal5Gak8y4ZyiRPWixorNp+7i42ZoJE3geWDexldHQ98Ppi34ChY8b/mE0LPRpi+8s5e4CGy6fA9ml8u23qYBt2DGehFlCJDIiMrYLo59s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=Ntf69yEG; arc=fail smtp.client-ip=52.101.125.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WRwIEJ/K7ghc8ZxKEpSP1nKiW9niwnQF0lpdopqMYRJe3Tu8IEncxOTGKmbca6uORQOKN+1DCV2F0rTGBkSEAwljIFBNbGdY8EiV4SgOWUyeB3gdYh1y3zlb9V2tBlZ+RfJ4/4NUcc0PTmaAqvmP6hEj455/eSeEyjsc1xZ2MJYBjdz71ojOB/ed5SPTbRFJHC0EqzYJAh4vubM2M8lzkhgACl0/bN+BS5U8yJcgOjOtJnXo3xw4/S7LYNA0JlRyrAReJZOKG1x60ymxCfwjOQ7lkXmkaFULA7S/+FfvXg1eXu+pTpVjeQa/3d9B8A9UwAD6M7Stdrc/NU+Oqx3+SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkmnnvlSbeHRtnkmJw581bR7rWnD9X/S/sxUARVzG6A=;
 b=dA51T0b5Xke1GJ2IaAfoUEw+BSl5jTc35UMBSkBnyqidRZgYfKf1Y3RXu6emUbQRCQodGUOM1admAuuzbLVukXrfO4hPU7/aHfqkEwApeiveUdGQpRTyTIbpl4U1SxlS6YRtohKhtqp5rc5KSnuIGfpV8ZWxu/KGh/XtZNC4JbfGeUCnsdrjSPy1pocFU3TgEJmtpvSAA+F6HoI35/zi2s9EtXUmgx9ViaAQs7h28/wSDyY5YFZ1ARIRJFY/fYLy39BZLGbwes1sF5DEoB2bM8jyHYhnVqYjXmYcnl54mMffHQ13+Zhuf/IZxdrulvi5FD7mlEHUcbV0FVJbuyA9TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkmnnvlSbeHRtnkmJw581bR7rWnD9X/S/sxUARVzG6A=;
 b=Ntf69yEGzGtiz8leSHdRIBElUyre0ZPgcCDurouMsBMkobiUS2ZoSB+qqQKnXcR4CkvNlsaXoFurXhFomsNuwao8SWp0iffpqlRTwzYQcFEw2e+lH28c0aQHeFpcgidNEjCG00GzmRY5m4+69VXvNxWBmZMuaeEmUnG5XvaXO7o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYVPR01MB10623.jpnprd01.prod.outlook.com
 (2603:1096:400:2ac::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Wed, 9 Apr
 2025 01:05:12 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 01:05:12 +0000
Message-ID: <871pu2b0vs.wl-kuninori.morimoto.gx@renesas.com>
To: Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Jaroslav Kysela <perex@perex.cz>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 3/7] ASoC: rsnd: allow to use ADG only
In-Reply-To: <875xjeb0wu.wl-kuninori.morimoto.gx@renesas.com>
References: <875xjeb0wu.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 9 Apr 2025 01:05:12 +0000
X-ClientProxiedBy: TYAPR04CA0024.apcprd04.prod.outlook.com
 (2603:1096:404:15::36) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYVPR01MB10623:EE_
X-MS-Office365-Filtering-Correlation-Id: c9b22e6d-d288-41f7-c453-08dd770294a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wFyty4FIIECQ0ZKruD7fhxJTQoBhd2hZHn0ieiR1DsvvDgJOmXsnSEf/H31c?=
 =?us-ascii?Q?naxxRm5fuhURzCQQtrU7DHFHxLRbchCwB62ED41gSu/mPE9tZD2ELCremxxO?=
 =?us-ascii?Q?kQdEdsPvV3Em1wdwbioeXYevgBlT67AsI5ECUOb77T4RsZ/on0T4TzKJRjxu?=
 =?us-ascii?Q?rmZei/4IuKXHb2EIlOJECeHNjD8K+lfWszk0Esm99XXHDYLJC0rGdct5GQQl?=
 =?us-ascii?Q?CnfzNSRM1uAul2cwLJfk1Lpmq/zw39/d4MzXM8hgJioFe3iAADYjnp6Oufi5?=
 =?us-ascii?Q?ABUpGeYvVFCIVDw0T/jNEhRD7QYD4VxmrHEm1PaoqJLQrq8Ioye2PcgXiKfE?=
 =?us-ascii?Q?1Hj1JPrG+7HI3xTRA2Ra9ZBWeh5s7YUnhfKcnUWYWyi8cUAXxWP/eASycAC3?=
 =?us-ascii?Q?RqcUTSKZTaaTBmjW4a4CN8ZfAUQA2/Mo+0g06v2/K5/1To9+HwMJyUe1n6Gw?=
 =?us-ascii?Q?YI96hmuzHRNMdkMRmE/rng1uUuqOMojgUySHTQgrIM2paEMHPeFeIUfZdb2w?=
 =?us-ascii?Q?lGLsq9JQXsH49UDWnzZ5TPlqBa/HZZoC+ZxgzweEAgKkKLb3FgaMJH1tNbNQ?=
 =?us-ascii?Q?pTBtCgpA9oy1NRaRPrYfGUT19n5NXIO0CG1gGmeoYZLkw+YB+x5P9bxmwFmp?=
 =?us-ascii?Q?uFlGLoKLgruRNFBdxJ47ugLvSr1nmhiqTT9fxD0Y/GMG1Tk0nS+IseLg2A7Q?=
 =?us-ascii?Q?zQTY8EuZekXrwqbqR+Q8RQGf9ZniKUzk6ZJIHf8IgEnubqGb3ETXHqSIyUnI?=
 =?us-ascii?Q?vTHXflQGriN1/tPoZRSm9ygbRzn9BwC0M6UlN0cuDfOTNTXk05SafBkVndfj?=
 =?us-ascii?Q?AMItiIku4qQN1079Vt7RvnmqyAh5aJB49qwJEggziyMHehVrLjPrILozDA/O?=
 =?us-ascii?Q?IC+CoW6aJVRd8Jwvr2/ldjBeMRtbWoYUv/udAuXy7aUxUuEkyi2ucC0V4ON0?=
 =?us-ascii?Q?XwspxQ1dhjmWdQMAPCFhrsgH59i0jwzBdRx+4TjbwpvRkYXfstEGzjcSJEYO?=
 =?us-ascii?Q?SHwHJsiOoZVS7VoODfJKMn7JIkdm0Z7HKE20cbDcIf/0dJklSADh/hsFnKfz?=
 =?us-ascii?Q?y/VcAEFIizIvYDJZtgEkEhe5CZ8GzYmMBwih5PWExhHZTZIUxk0WTCxQ9Jne?=
 =?us-ascii?Q?0gL6a9WzQIzAs4vPoe/HoP0EBSnzHAI6RUCHvTSpTcLAogODXf3GdeY9WmNW?=
 =?us-ascii?Q?oFvaJVQOMyFQVRlj01ry4S7OFOFzE3HTEG7SVLMkpRTlj2bzAj8BOuKtk+i9?=
 =?us-ascii?Q?qlJ5ycK7wly7qI6D+/MCJ3tIRnMW8WJD0N0GeMZUD7Wy7QYidxox8npE4cXb?=
 =?us-ascii?Q?WUbpy69FRCLOsjEXxSXjCuz4MT7gVxIVaCr1/lAP/9HFBpuDVXeRmJORkUCo?=
 =?us-ascii?Q?1Zu/V2Ib/vHz2kREvcg0/vA7lMW+uk0uEH5YHhCjM8gphXArKS6VV70sJnPn?=
 =?us-ascii?Q?JSif7oDDlagwih+WVI+Wjhb5DnvQ7x9nbbCLHyE4gK85GJaM704p1rBqmhjy?=
 =?us-ascii?Q?J7Fbn5UFAB9K5ts=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x4SmcofAnd+AyZicomgxkhBF3lMjQK9WkTUCxX5lds1xlU5SPI3hXrsXb6zs?=
 =?us-ascii?Q?20oIMQiDP723qUVIACsz3rUp3PqgHb5hcPMzhlErTujwngHjDyLzbdBzlFLq?=
 =?us-ascii?Q?Q5HiLaraEtj6zfU9wGolMiG25bKbHjyZO2h7jxdKMuCzlzd/iMwqtCgRdxYe?=
 =?us-ascii?Q?UJMhh+X/tuyBqRlNsf/gDQIfGy+mfLmTc8tiHa0ZECi1xcosVSvMsU+osGpV?=
 =?us-ascii?Q?ZZwRtdsY4hmwBM3qWZsjV7CprvjTJtwokpGQlNNnMI79fNtHLQelsggpu0/B?=
 =?us-ascii?Q?QPjt+4TO7wgMP9hRzppWibdDDXktkwBglocPPSkeJtmMzu4BGPEh+2QLzW5x?=
 =?us-ascii?Q?ec+2kUHOM+yTD0/mryNIQcX9MFsWYaySLHAFNeEdPtHbgxBn4vcDWFASYlTr?=
 =?us-ascii?Q?u12slHHERxlvJKsc4p61xV7gaTZi1mwmmH2NVCED5oc25emf/qo3k3HifqMH?=
 =?us-ascii?Q?V/0QyWLsBa9iHAEkto5C6R+d6n/umfif79na8svxRXt/eFAMycjP1jFiy1C4?=
 =?us-ascii?Q?Vav0DmMBRSWe8SitVci4A6A2nfCG4XBrr0TZVOFd7FTKbIqceA1eCoPYv0wz?=
 =?us-ascii?Q?iXo/KeU55kP9ZeolKZwXR075bTh1Tsa87a6PLOZ9eDY6/eR/CCt6XpMGaJFz?=
 =?us-ascii?Q?eOKkI2hIvG2NgF8zBjerwMh2M5ODbWZqX6BP8S7Y0CFFblYq6Q1pfTd7byKB?=
 =?us-ascii?Q?omtXXpz/y+TNEjf1tPcMcgkgP4k6Dr35T4Tu7HfMZRuJETXrfXOXigJqDxou?=
 =?us-ascii?Q?ySgseZKzfkrknAMPvL7FQ6mwgN0QZLoYKGwyiZUqYwE4Y1QQT5xrUCrK/w81?=
 =?us-ascii?Q?QFPI/lj6UOd5qLeqJq8eHQNZvj+hfNp2K+0jkH6N558FnYlAi25LLIOgODBY?=
 =?us-ascii?Q?fP9Iocv9vnmn2QeASoQH/YhOA0JXaeWjm7C3afDllq5LLUvuPFVMRNfXe5ZW?=
 =?us-ascii?Q?61srsiN59zHBnNmIoItFfGI/GtFwb4WjmcDF36+c5DYvCvEYFZYtKuKtIDDy?=
 =?us-ascii?Q?Fb1II2SDi5qdW5q1eqwlq8FgZNdgHB9YUluQdvq5+hl/FnOFuj21RS/eKdtE?=
 =?us-ascii?Q?Nxi4X4wKQhyiu8QZvhaX+2J1r77mjIQVh4bzPqbXl68aYE6DGZJhiiMA0dsk?=
 =?us-ascii?Q?iOs+4YkyUJn2rK9bN838LaUOFbZ8184UcJqpKITshlsLuhdCceDt2qPw8GvE?=
 =?us-ascii?Q?IcwROw0FI0UBZBMaNHX6w77wwjfJg6bu/XwFCScS+X4aCf7Q04ZZkSh0Tn8A?=
 =?us-ascii?Q?0xY543W+HA5X2ZP0XDaTV8lhZQjH7FOu2n74AH/VyWoEQgndHHwQNXnQHxzF?=
 =?us-ascii?Q?xELFDQlOXNtKgn1g+4vWq+lSmRO2CnRl6AQNBE311oHFk7oYT1YC+qwoFz1h?=
 =?us-ascii?Q?vB9GDUE533bVX6NXfZUWNs+TAEmhvPznASHC2NME8P1wolC1VPPKzr4wRm2+?=
 =?us-ascii?Q?LrwthilWD6YHsT0y6rC9WK1ws17LwGUKrarJVQMFbzcoJEfflfL6zsc4u5pA?=
 =?us-ascii?Q?yqfCfVnGkAqMKhkkdg6tZNXm6tFHxXcublbyySXejzodpJKtqIZ/2KIc9N7m?=
 =?us-ascii?Q?bA7BYBs7eDUt5heavUUqs7kFpcSbN+U9hGT156kDu3j+t43kfmTC1a3R0Dp+?=
 =?us-ascii?Q?fQ=3D=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b22e6d-d288-41f7-c453-08dd770294a2
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 01:05:12.4877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rNfhY/usGzyvdCeXNUkYqJWYQ60+1YZQt74AZKYXeHuRJ0eEAsufwNclnvouAVx50+yOVlmlWiXhOYwwnTK2i5GFWcacbK6raocwAn4bd83GP2qaB1gRgrFXlEE7JQL9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10623

Audio clock generator (= ADG) can be used standalone, but current driver
will be error in such use case. Makes it as not error.
And, current driver registers it as fixed rate clock, but actual clkout
was handled when SSI start works. Setup clkout setting when it was probed.
Otherwise it can't be used ADG only.

Because of this fixup, current rsnd_adg_get_clkout() function name will be
strange. Rename get -> init.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/renesas/rcar/adg.c  | 28 ++++++++++++++++------------
 sound/soc/renesas/rcar/core.c |  7 ++++++-
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/sound/soc/renesas/rcar/adg.c b/sound/soc/renesas/rcar/adg.c
index 191f212d338c..db980e4642b8 100644
--- a/sound/soc/renesas/rcar/adg.c
+++ b/sound/soc/renesas/rcar/adg.c
@@ -377,16 +377,9 @@ int rsnd_adg_ssi_clk_try_start(struct rsnd_mod *ssi_mod, unsigned int rate)
 int rsnd_adg_clk_control(struct rsnd_priv *priv, int enable)
 {
 	struct rsnd_adg *adg = rsnd_priv_to_adg(priv);
-	struct rsnd_mod *adg_mod = rsnd_mod_get(adg);
 	struct clk *clk;
 	int ret = 0, i;
 
-	if (enable) {
-		rsnd_mod_bset(adg_mod, BRGCKR, 0x80770000, adg->ckr);
-		rsnd_mod_write(adg_mod, BRRA,  adg->brga);
-		rsnd_mod_write(adg_mod, BRRB,  adg->brgb);
-	}
-
 	for_each_rsnd_clkin(clk, adg, i) {
 		if (enable) {
 			ret = clk_prepare_enable(clk);
@@ -504,13 +497,14 @@ static void rsnd_adg_unregister_clkout(struct rsnd_priv *priv)
 		clk_unregister_fixed_rate(clk);
 }
 
-static int rsnd_adg_get_clkout(struct rsnd_priv *priv)
+static int rsnd_adg_init_clkout(struct rsnd_priv *priv)
 {
 	struct rsnd_adg *adg = priv->adg;
 	struct clk *clk;
 	struct device *dev = rsnd_priv_to_dev(priv);
 	struct device_node *np = dev->of_node;
 	struct property *prop;
+	struct rsnd_mod *adg_mod = rsnd_mod_get(adg);
 	u32 ckr, brgx, brga, brgb;
 	u32 req_rate[ADG_HZ_SIZE] = {};
 	uint32_t count = 0;
@@ -537,7 +531,7 @@ static int rsnd_adg_get_clkout(struct rsnd_priv *priv)
 	 */
 	prop = of_find_property(np, "clock-frequency", NULL);
 	if (!prop)
-		goto rsnd_adg_get_clkout_end;
+		goto rsnd_adg_init_clkout_end;
 
 	req_size = prop->length / sizeof(u32);
 	if (req_size > ADG_HZ_SIZE) {
@@ -633,7 +627,7 @@ static int rsnd_adg_get_clkout(struct rsnd_priv *priv)
 
 	if (!(adg->brg_rate[ADG_HZ_48]  && req_Hz[ADG_HZ_48]) &&
 	    !(adg->brg_rate[ADG_HZ_441] && req_Hz[ADG_HZ_441]))
-		goto rsnd_adg_get_clkout_end;
+		goto rsnd_adg_init_clkout_end;
 
 	if (approximate)
 		dev_info(dev, "It uses CLK_I as approximate rate");
@@ -682,11 +676,21 @@ static int rsnd_adg_get_clkout(struct rsnd_priv *priv)
 				    &adg->onecell);
 	}
 
-rsnd_adg_get_clkout_end:
+rsnd_adg_init_clkout_end:
 	adg->ckr = ckr;
 	adg->brga = brga;
 	adg->brgb = brgb;
 
+	/*
+	 * setup default clkout
+	 */
+	if (0 == (req_rate[0] % 8000))
+		ckr = 0x80000000; /* use BRGB output */
+
+	rsnd_mod_bset(adg_mod, BRGCKR, 0x80770000, adg->ckr | ckr);
+	rsnd_mod_write(adg_mod, BRRA,  adg->brga);
+	rsnd_mod_write(adg_mod, BRRB,  adg->brgb);
+
 	return 0;
 
 err:
@@ -764,7 +768,7 @@ int rsnd_adg_probe(struct rsnd_priv *priv)
 	if (ret)
 		return ret;
 
-	ret = rsnd_adg_get_clkout(priv);
+	ret = rsnd_adg_init_clkout(priv);
 	if (ret)
 		return ret;
 
diff --git a/sound/soc/renesas/rcar/core.c b/sound/soc/renesas/rcar/core.c
index 30afc942d381..4f4ed24cb361 100644
--- a/sound/soc/renesas/rcar/core.c
+++ b/sound/soc/renesas/rcar/core.c
@@ -1482,8 +1482,13 @@ static int rsnd_dai_probe(struct rsnd_priv *priv)
 	int dai_i;
 
 	nr = rsnd_dai_of_node(priv, &is_graph);
+
+	/*
+	 * There is a case that it is used only for ADG (Sound Clock).
+	 * No DAI is not error
+	 */
 	if (!nr)
-		return -EINVAL;
+		return 0;
 
 	rdrv = devm_kcalloc(dev, nr, sizeof(*rdrv), GFP_KERNEL);
 	rdai = devm_kcalloc(dev, nr, sizeof(*rdai), GFP_KERNEL);
-- 
2.43.0


