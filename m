Return-Path: <linux-spi+bounces-7543-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC90A850E0
	for <lists+linux-spi@lfdr.de>; Fri, 11 Apr 2025 03:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95C6819E68DC
	for <lists+linux-spi@lfdr.de>; Fri, 11 Apr 2025 01:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30C326F466;
	Fri, 11 Apr 2025 01:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="plzhlnYh"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010032.outbound.protection.outlook.com [52.101.228.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D630BA94F;
	Fri, 11 Apr 2025 01:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744333436; cv=fail; b=npuYMwZpBIT3a6qCM0rbHUNdq2MjBe7qnuDSwdd3dIbSUB0L3ZUF/E6rP5jBmyUox3jBI+vvbtTTCaSQHu9QIw/JK+HsOHOI9SqTXJhTgQgyChIKsfP9W4u5YyAYmkirBLk5MEVgjJTk5el1SM9P2biTMAMCY6PD9OHwqV98ATc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744333436; c=relaxed/simple;
	bh=X/MCGX5ZcEMl5UC4fpZNVVfxDCD3uS3+nwaLDbtYJd4=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=an0cBhqHKmRHgrcRPER9iMp069iZJwKjrPSRcnuKqQy/XDNKiutPtuJFFh/jdBaNatVOMtNpkGA3osS5vwSqBrFbBqGH/+shHUdXiSPK5YKG1hSCqHsL9RX1jrgnSFonua82BpmFvzciLs72/j1rh9xrzZ99weMSS8NiDsGvYNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=plzhlnYh; arc=fail smtp.client-ip=52.101.228.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJ01bmQSGKOhA9edkTr6DAf/cW4DX4VLPa1ULPZzt3jeI1joMpakODQT+6euRM9pd6jV+AiifPNMpGxDiiEieVKOgwZ6ThdiZfby70IecwIjMVTL1HXpkaz+0R+9JPJAHT/7mxHa1uUhE8ICmZFrTNJdN6oGNx1D1Z1bLnZPvB/8gSJBCWAoAklX+u7F6zDMx+QjVB0RrTpB8+mCs0H10vqtc0KpL9V865AMzkxBYnx/cqje67/Kdvj5qaWrR9eBCysSFzBOuxdFCId5EgScPbosKFGjbBjALkAd7EqwVsAE7H/wsLakp8KN6BeWb/wPcdvnRFPqO33s5IsiHSbooA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFM3jCzjElgHmGdWxlofjxtDE98tuz72axM5ApAUgag=;
 b=iEbC3aKxIK2djrVNaxbvRY3fwNH2xeCGtgnA4dpJP33TxzmH8A36Kgpf4qOIEu4VOjJukkND4Gad4OMsk1XTiOQUeG2SKnLWr9Jg5N1vEip9COldA5W6QeXAR7N/arvMBdSIyPSo9V5MqyK2rgpElVRYa+3ubXu9O3S6acwkfFrhysP89pum6Tb722xYW/lCZU75NA2Vb8altrP0pXwU1gCu8vqSxp/vdC38CzfiMXeogBkFfTM4OKPbyZPBm2NiiF7L7l0ow6O7a0PubZ6fhwVCxbVl9m/p2vUzXWubTr5j2eHo5qQ1bvVvSrvO50VWlk95OIqnGXnmuxgmSYpNmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFM3jCzjElgHmGdWxlofjxtDE98tuz72axM5ApAUgag=;
 b=plzhlnYhF+Altjiw5hcXrmTx1/R9KMG/DF5kyLJp7c94j0wy4Ck03VZCLn1A2aB1AjU5bGXHEBdnd/9gmEdc7N3vPtca4+kCf4OCChTiTsP6yiJrvA5Uja/hnveWDLA/+Re9v0t2zfLj56bnQRQAqXVigSpH6Ma8udEhJJxG2rw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TY7PR01MB13579.jpnprd01.prod.outlook.com
 (2603:1096:405:1ec::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Fri, 11 Apr
 2025 01:03:48 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8606.033; Fri, 11 Apr 2025
 01:03:48 +0000
Message-ID: <87a58nh5l7.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v2 5/9] ASoC: renesas: rsnd: enable to use "adg" clock
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
Date: Fri, 11 Apr 2025 01:03:48 +0000
X-ClientProxiedBy: TY2PR0101CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::20) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TY7PR01MB13579:EE_
X-MS-Office365-Filtering-Correlation-Id: 76abb6e5-6fcc-4506-41fc-08dd7894b780
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wLYXFANWhwPBIdsouDcZaKTjp5JO3ujTLFftNzeZEP2WhoADfEEq4+7c8un8?=
 =?us-ascii?Q?SY75jSnb62Sm+/uf1HDnFHBAuTqnp178FTs9TBm+ODwZxeR0B0+86C3cbeZv?=
 =?us-ascii?Q?d60BBaZAEaM3bxC0VzUrrtlZiTHTu2OlKknd8H09ivIASUi4jubyZFMb6Mcr?=
 =?us-ascii?Q?B3FLtT6f64jSOOeHhMKyOLRaZndeWOzMtxPskynkNTkrpmjGqUv1MQXglzYS?=
 =?us-ascii?Q?IEUQJtQeBiV9oR03rsXaKH0hbAXJZj2Rdl50aOA6hZ4uQRydmAAlvDplaPOM?=
 =?us-ascii?Q?q5ZmuInR0StPketTKjEgPnTyOYX/xUbXjXAmyDZ/UVOnhSpDnot8LX/9jzOO?=
 =?us-ascii?Q?dNHOH4yOYjhJg5Clk8sVrdAXD5HgVKGJdYo+sn+tOYQJGqXEXebJlnkpJwa6?=
 =?us-ascii?Q?vy9JzPiNn72t/9ObdMumPHb6Nok+DLpLOQrs25deqyseQGQj+FiPuo1H2Hf6?=
 =?us-ascii?Q?e7l5EULWuOEel0s5q+vWtK0pNAGLDvZFKFLCgK1ZBA6pdgZKMpR418+wFgQq?=
 =?us-ascii?Q?keMxbgcNWQYs19EVCGaqQwW4Loh5EzV3rjaREaTDwbBq9H5TGu4tIU53oCxp?=
 =?us-ascii?Q?fRmWgrz7A4o5ZnTlBhwIbAG40Yhx2DStn5rRZu4wkUQhItoT2ejt9Z5gEniE?=
 =?us-ascii?Q?CsgKdfX0iX/3VYtdsU5bJij8vLJG5e7cYjLpvH9FKA/QbZ5Ju1kRnf15apyD?=
 =?us-ascii?Q?Fgz0RvISWCNjnJjZy95XPdVAuKmfQj6yU3DH8/2uSnkQmPIjiZzXqrlQ/73U?=
 =?us-ascii?Q?F3L4Hp7q1Wj8DtCI65tW4+HhoxNciZUXG5Gl0Ia1w10xKT1OanSvRrlIKC1q?=
 =?us-ascii?Q?ej4J9iEyQ2RncbMwLV938MWChuq5PYhxnWhzd34UqspxX1L/7N73wU3FhaQK?=
 =?us-ascii?Q?EpwLZJP7BupRhfZyGnionX4HvQUs7S2zqXqwRzF/vrUbiJ2SGblynZOdpku2?=
 =?us-ascii?Q?wWXh5ICSmg5w/fr6V9ftrdJxS6GvHG6qwkUi/mulR4UNKc+gH/pA+UEb535y?=
 =?us-ascii?Q?BTHvdZnzXrgKo12kTTgt/m95PPtLKeCpr0tjWexBA84p2w3WU3XmwLrOrl2Y?=
 =?us-ascii?Q?EGZRQfyddKkJmX0fibMtY9wvPLd7Jl50/JJYu+B2+DOQvMFYgQRlbN0RiFst?=
 =?us-ascii?Q?n5nLJ2cV/uM7RSlGqybmhreWeNScWs55iTgnNqwBz0UlCwkFUCaJNbfQBGLI?=
 =?us-ascii?Q?Z1rIekg1x9lhk8LaKXLKNNkYoMilI6qSvSwQsBAEzLWbn2uOTgEWefQrg9Wh?=
 =?us-ascii?Q?JCAKxA/mViq+A+XPF1lsSjXgAuciieUhIXGNNCuTIy4t/Tau+wOipsJdTTYH?=
 =?us-ascii?Q?k4umY4TI6mI2u7kmFV+hb4WaWwuxVD+rW/S1nHIvRLR/7znVuDqJiU0nGApJ?=
 =?us-ascii?Q?wF9ueRrbZUGtA3aBT/Qp0tpNHy1ZDj3c3tTbqS8Xj5oW26o68C2+YYt0DLc2?=
 =?us-ascii?Q?BzfpjjexaTwrSgFjVMgFyWHQaGHtPcbtQ90WmU0a2rNrvjjVFphRsMHj2APn?=
 =?us-ascii?Q?0+ICRG4EAg9T2p4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hLe3rxFar/fLIfnmXxflsct6I91v0AzZeeQ5xwLnguLJuulX3h+/Yykr6hTV?=
 =?us-ascii?Q?Lg1hTiPdFI+iiipRDnX+dzJbu8gJt2alDi9J2Jq/R3i/pQRsb48dHysFacEw?=
 =?us-ascii?Q?mKV3cQ7eqSYiUhUBqpvVa7BLufKLaf6PTpyZptotzeBkKJwbVUvI1PZGqU9p?=
 =?us-ascii?Q?nykNdPRsVNoL1uTsK/1lKTqxU6ECffKwD2Jc4Q8Yy5E2ckhaAtxQZzwynRY6?=
 =?us-ascii?Q?gRLEYH5heAmLa2YlT27FQ4RSkGjq/nRjyhKxZ4B1OP776Z8tQm0ZSJi67+fE?=
 =?us-ascii?Q?ZGu2hIvVjrkGZpQozrIIN9o8kpeTIOqJkmNOc1iObRBFRtrSO9agvDBmq0cY?=
 =?us-ascii?Q?tJfYS8t8iuyWdJs+NMjUjBFpsdKKFqkMo0IgRgapHgwoVztabCxTYoXlC9iu?=
 =?us-ascii?Q?M2vCMu7wXzkbdjxh/gSzr4jJerZoPRaHHsNjO2rrAWzPJDoROL4LX6PH1PKg?=
 =?us-ascii?Q?MxJlWV5sCuBTTLKdUFzL93sSCmp1gUPy+XrS6t5MeSdUB6/z0f3ngLA8qSGR?=
 =?us-ascii?Q?oqdEOz5TDcDb5LM9l+URqGlVVnuuKfgXO4N7Fnhe1Kq3pJBjcBiTJahKvtsj?=
 =?us-ascii?Q?FdQ79us1b6UcAW0c2njlPVJ8I4aXwxu6xH8kjtF8j+/NaKlbjQ2W+OLgjl/9?=
 =?us-ascii?Q?LTVxtxm1/YwEIWbsJn4lmwUydbUuf8FcKSumvxhNI2oMxn59CQE1yi6VdDk/?=
 =?us-ascii?Q?ej4mDLzsJfcjsMEK48xXwTvTZjEmxpbAXTXSoJ2o7+LJSo34s7aQRWaD3lNW?=
 =?us-ascii?Q?DKWaLqMsF3JmRflipK8cO8gwGR3hwoB8tZ8ih3fW/Pmk8VaSf8Uv7LdEuSYo?=
 =?us-ascii?Q?8IdxzGeuNU20pe7AOSRZ9WzC7GXl7P96v0wLnQR5XflutuZ2iU0QWerCMEpo?=
 =?us-ascii?Q?f69lgpWJ2WFXWzeM4juw251hPfIk3cEsoM3Ii7OjXgZ8YEMNQpoZM+Xhu5fi?=
 =?us-ascii?Q?OHhJyvfVD4PZwrhuSQYK5CT0R4v5rVunJeSDXwBGFz0CQ3TlzM0k4fTPIuHy?=
 =?us-ascii?Q?2VLDTDAYwRzipFvz3mju+CwpTE0o8EJzKo31R4cygw761Ddivm63zDcgXbhY?=
 =?us-ascii?Q?HIxR9lgQ6s+liBq6irkQNma9PsEfJT5TmcZumMSdMLxhyLJ1/avCUEqexKkb?=
 =?us-ascii?Q?ZSbobT224xF6YWiZ8qruAwUWwjiqlv1yxc5hskoVYAy+w0Ni01Ibm+K8VvzV?=
 =?us-ascii?Q?2rmZ9halfS9+rj1IjP8eC0A24aGXyczRTeJ6GdDMdRzv6WdcWz5eMWWyBSUu?=
 =?us-ascii?Q?lxyNOGFyvQbBpqzK6SxUjpGh7kFQj556z3pij709G++2AZNZiqJeyRpDJ9Cf?=
 =?us-ascii?Q?7jUHtA+XTlbSJlPWFgyLHCoFbUPg6tfve/xisd7u1iCBCmrwgSHgASIFK7Yc?=
 =?us-ascii?Q?BM2bwZS8Vb78eBmKfdmNYkTFzwh9CPWAagknIEMDIlSGqwzsOzr52e0XkqVn?=
 =?us-ascii?Q?RL3cq1a1f3cQHs+hsUv35Y/BmqYtJ0/rfucgvhpvDEfi/rEyHurNQid8YvXY?=
 =?us-ascii?Q?oXcbp27zdSTJgCzeaVFdQPS7iONDXZz6xEhff5YZiodiOAbkAkVvEKnBLS8l?=
 =?us-ascii?Q?VxWAD8JaCZsHaoQyw7FzyNoL1ibzoFY7wjtDYI4P1a+yCqmfUfM9050PnuQz?=
 =?us-ascii?Q?k7BJLDWAlHYWZfvLnYsRIyY=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76abb6e5-6fcc-4506-41fc-08dd7894b780
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 01:03:48.6851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jVb4OksBc3FNsOqKaC/MNIZSCMUXHkSGAT86TibiBw+9FPd3NbWQwUb82086+s7Al4+8xBzuM2gUwUGh+5wZWSWgm5AYDhstsF98P8oG4Igw3LxqUXavYRHNNriadlPX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13579

ADG needs its MSTP to use it, and it was handled as "clk_i" before.
R-Car Gen2/Gen3 are using it, but Gen4 doesn't have it.
"clk_i" is not intuitive for ADG MSTP.
Let's enable to use "adg" clock. It can keep compatible with R-Car
Gen2/Gen3 and Gen4.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/renesas/rcar/adg.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/sound/soc/renesas/rcar/adg.c b/sound/soc/renesas/rcar/adg.c
index db980e4642b8..5f132b95a85c 100644
--- a/sound/soc/renesas/rcar/adg.c
+++ b/sound/soc/renesas/rcar/adg.c
@@ -30,6 +30,7 @@ static struct rsnd_mod_ops adg_ops = {
 #define ADG_HZ_SIZE	2
 
 struct rsnd_adg {
+	struct clk *adg;
 	struct clk *clkin[CLKINMAX];
 	struct clk *clkout[CLKOUTMAX];
 	struct clk *null_clk;
@@ -380,6 +381,13 @@ int rsnd_adg_clk_control(struct rsnd_priv *priv, int enable)
 	struct clk *clk;
 	int ret = 0, i;
 
+	/* enable adg */
+	if (enable) {
+		ret = clk_prepare_enable(adg->adg);
+		if (ret < 0)
+			return ret;
+	}
+
 	for_each_rsnd_clkin(clk, adg, i) {
 		if (enable) {
 			ret = clk_prepare_enable(clk);
@@ -408,6 +416,10 @@ int rsnd_adg_clk_control(struct rsnd_priv *priv, int enable)
 	if (ret < 0)
 		rsnd_adg_clk_disable(priv);
 
+	/* disable adg */
+	if (!enable)
+		clk_disable_unprepare(adg->adg);
+
 	return ret;
 }
 
@@ -464,6 +476,16 @@ static int rsnd_adg_get_clkin(struct rsnd_priv *priv)
 		clkin_size = ARRAY_SIZE(clkin_name_gen4);
 	}
 
+	/*
+	 * get adg
+	 * No "adg" is not error
+	 */
+	clk = devm_clk_get(dev, "adg");
+	if (IS_ERR_OR_NULL(clk))
+		clk = rsnd_adg_null_clk_get(priv);
+	adg->adg = clk;
+
+	/* get clkin */
 	for (i = 0; i < clkin_size; i++) {
 		clk = devm_clk_get(dev, clkin_name[i]);
 
-- 
2.43.0


