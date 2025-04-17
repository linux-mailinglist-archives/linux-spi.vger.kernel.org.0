Return-Path: <linux-spi+bounces-7661-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD330A92E44
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 01:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 451CB1B61E34
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 23:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4F72222CB;
	Thu, 17 Apr 2025 23:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="RwDGF8qU"
X-Original-To: linux-spi@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010056.outbound.protection.outlook.com [52.101.229.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9BC2222A7;
	Thu, 17 Apr 2025 23:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744932216; cv=fail; b=jzhv9mhbTX/oe7tn56LpTqhsw55HMpwNfB58+h1nVF9RtjwrhKR1zj7+D3kB4wgzKBFLmjJxxHBbKRwjujCth9ilSwa/29P6017YZFkrfLVx1sf+h1ka+KJjQ21VE9lt7FFjXUsN0pbdZ4ZtL4MNplWsWk2/riyjMSD14phDE74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744932216; c=relaxed/simple;
	bh=TJP9a2T1yyhiYBBldDCtoBfYkmG8ZMtMBRpsdvJrxsE=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=n4b2zsRI6RGVJErizQTfYxrWDY33YrehgOeu4Ho1wnccv7znTjGfUU+8evVLj3bw4iv4kdoXIpG9K26qzYfC6q15Wny0jwLcP8l20a7nn/5Rny2LELTzCmHlF4QYRYcJKrYfUKudBH1x3AjfeNAZgut+kde5jvMcdnbLJU2tJAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=RwDGF8qU; arc=fail smtp.client-ip=52.101.229.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VgiiqPi387t4BB4j5x51ZTL6xY6SmcNbU8WojVk+lM7xuHV4+51DytUrzXjkS15Y89eQZLL67VxF/enKrMfH4tVtwVKL4WZU9zk8JKpQ5cOc6/MOsJpk2GP9vEwpOgb5R9Xu0rfNdCaWL5OLu5lf45GHepsjThPYIxhyFq2rR+WvmU3cW0eXL/QsRdGWeW1naeyMOo1qINqpAQXVt4h9FQkw6z1kKjqo1996Ki4ygc9o/Zlc8nlHChHCiFudN2JeRSCdJ0fgoo9Jl7EmbOqO0zdP4Cf2CaLusDVqatuw2fh8R3g3cj1uAfmzPVRe0HmNGOF2divv4WZoyfs61A7JEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5T0tF0Z96xZVVwlwOZgZU/zZRsntMnmk8EubBIowzY=;
 b=o8INt01NJv5Pxdgp9xiHNrGJ4hITH5q4Ny/9RCjhu8kyuQoKzR/CU2hOFXFnBZtOL8x1NEQOLO7N5e/lYqZPvSZyP4+sub1s/SkmruBFLRFvNBkAkOw47YlAqrpXa0S+6HEqJyXG9VdEiJTvIxZBXXTktmsLuX58oQ/dXEXz/ipgs8QG8ET7ftgG9CtSX9VA6OVEdl2NA8Kop5evTXMU2xJfM9eCCrErSz3s8GAY+s/Ho1sVo+klP8wYGNIM6t5EJVZ5dHLf6TQJVJ6W0kFcU5NHDP05X/rQRw169d2dvhI2UKmkjSdn6Hz+Ug9XtOyagMPbGbSL4nlUYtd+h28hRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5T0tF0Z96xZVVwlwOZgZU/zZRsntMnmk8EubBIowzY=;
 b=RwDGF8qUgTooH20Xaj0Y2klWSeTasajvaCuadKKRavHuj8qcobdyTxUPg8lHMGVtjhkEyvCTOq8gH+cvlkXxoIe7TcnFWCYAmAX03djcmgN3cw5lDYnYC9177bDIRccZpn0Wp+j5JaYaretwi2x7Bx9JPF9iFMQgqlQiJI/mmWo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TY3PR01MB9998.jpnprd01.prod.outlook.com
 (2603:1096:400:1dd::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Thu, 17 Apr
 2025 23:23:28 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8632.036; Thu, 17 Apr 2025
 23:23:28 +0000
Message-ID: <87sem62x00.wl-kuninori.morimoto.gx@renesas.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Jaroslav Kysela <perex@perex.cz>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>, Will Deacon <will@kernel.org>, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v4 6/9] ASoC: renesas: rsnd: enable to use "adg" clock
In-Reply-To: <871ptq4blr.wl-kuninori.morimoto.gx@renesas.com>
References: <871ptq4blr.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Thu, 17 Apr 2025 23:23:28 +0000
X-ClientProxiedBy: TYBP286CA0005.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::17) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TY3PR01MB9998:EE_
X-MS-Office365-Filtering-Correlation-Id: 07e38f64-09d3-459e-1a48-08dd7e06dbf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aajCBXsbSsMh7E6+W7zMs6pWJy+FyzxxzPbI0Xq6oVbrCbdNRpmPgZYtkNa0?=
 =?us-ascii?Q?TGHdRhGGPFWGvug8WSbg+FoqmHKwMbb/bZHenfCJd7IFo/UjkUzR5LKQJkE8?=
 =?us-ascii?Q?Tpht+VdSAKdLeUwqyRm5gOWXqHSz83QVzNOCXOpv4fnrsO5p/tHVPC8O5NOy?=
 =?us-ascii?Q?yNf3U1K0pvewUdHyuYo4PEebgHDfhjrYgpjvReaaS0q41JCiMEtbWL3a7mfr?=
 =?us-ascii?Q?Wopn+zkgke3yZ4J0JjytPTa4uyaUCJdpDD/StqGL9hZ8AyxXYzzdB9X/sOZW?=
 =?us-ascii?Q?TZ1wFKJBbNrHhZMUlZE9TcNlzDa3iSuMN6+ZC0ZQyLYc1jqqOdt0gNxakSym?=
 =?us-ascii?Q?obEa9jCDHWlZgsoNMZVRg1qb3FZ/wBAXvAZRvgICCrmaCbiL61LvWV3e+qKW?=
 =?us-ascii?Q?u/ZpLHXn9G85ZmgSoKips9CSFvHRGlOpOLf4x82lYIBmJTmDSW4t2gfWobcm?=
 =?us-ascii?Q?q2AbnXValFczXoyaTMl3qEJTEqSuWnQfVVeASGQhWPP8aqxOXIO/KnSEpHGe?=
 =?us-ascii?Q?Po8102n/lOc6VAnAuBJqeuqwu6PzFrIGy7Yv+nspBAvg79WIWEH1hfgP29Jv?=
 =?us-ascii?Q?c6C/L+0ylkdw93/BXSulmHQ1fZHq591sUoQh0FMmGnr8EfSqmXCe5b38Caqy?=
 =?us-ascii?Q?gPNqe1Dfl95WzTLppcgZWAeu2TTcxNrLLKPP9vSubtnv0dFHFaLZpA6Rhz5k?=
 =?us-ascii?Q?q86nozIquTRjL1Vpoe8slfe6PouYXYQ8CPhSw+i7YDZCNh3FUApYsw0hgPVS?=
 =?us-ascii?Q?JyeHJhZjBUyS4teO+BSejcyFqmfbaVRGIEBo6U2fivqfZIBMhsuVe+DJDQFZ?=
 =?us-ascii?Q?E4ZG3vNIWzan1jneM9FDbrw8hkYUEV50HeSo3mIe0DCX3ta5sJL+lmGESG4H?=
 =?us-ascii?Q?SN2ct+fQVKgIhZx6LuEi9Pbgv9wFnkn2uDKIIniAsGm0cd36ETINOqOthpki?=
 =?us-ascii?Q?wMnyxuH2ujMWX3/IG1Vd1Q6xc6rY8Qs3MUU8CCHhW0C5wSce+p/92qmjcHaU?=
 =?us-ascii?Q?CwW/xwZpLFOvfF+agmS0CADgNDIOBzMzZluMuvjsB9FeAKKPpXIuZ+enZHgb?=
 =?us-ascii?Q?ogb/Ps33tJZoqOXE3UbRUIwQ81n4EJTcCqK6kee08gYTIOI5vopQLi3KOrxt?=
 =?us-ascii?Q?sB95irE54j04Wyd/SjN4BnvVeuW5qOLEHask5l06sdVfdFTPA4aerukowpaS?=
 =?us-ascii?Q?WY8bnTfRSu+cBRLn+iOjKpU0ctS7vKOHQt97arwTXIcx0jKP4IPQ9JlNHT8I?=
 =?us-ascii?Q?aogoEpstAP468eBvZz9UQiOG/D9e8Mw/FXCWtzz3uxwjST8uIMvBQcy5vaLz?=
 =?us-ascii?Q?B1A2f11gfT4AdiDdEkNFEW+4BXyaKuvJKlxoHH8Es+lYBn8IXQ2VaAJt6W06?=
 =?us-ascii?Q?ZF6o164uzogx7X1Tb1+jKQffi3yNxa8vPyNi7TF4zTUuhDUnGprYpRo1xDII?=
 =?us-ascii?Q?IL3ZbxwH+GMqe4MDtAuNqgYtlJzdiLpmARY8UcJD8RySeytKkJMEUaFW2VFI?=
 =?us-ascii?Q?8mTakupaV+9Emxg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IPry0itDc0KjsY5HWW+NNukJt6HC/5SLA4aoztiZsxP03kPHQm6kTXoan4IB?=
 =?us-ascii?Q?vWpS5JZjeN5BZhmPfFh2/NeAbwcp1fJWTnAY/N4YqCwcMJ/OJgwUgzRH8ydW?=
 =?us-ascii?Q?a45qMa81ggWL7vDsfHnyhs3DcfhFSK2FSegxd9U3kHhXLBB1nCbuxRES9hmq?=
 =?us-ascii?Q?JPJO28c0rZIS7VvMmhDAu+/+A/wYRzFEOq0CmL+PoJrbhC0/0mSOSqKJeKS0?=
 =?us-ascii?Q?r09QCja30GdjYO0Dr1D+tMHte3fpMm1nQKGxdmCMP570OJI+55e7mFqevAhu?=
 =?us-ascii?Q?YdyPyXLALVsPA2nd3rsvKLi+gUO38NF6aOrrZnxO6k3Ih6B+xjUcmF0b8wrs?=
 =?us-ascii?Q?wKIxUysKyu/a5pPef1RpegzAPkvSq6xZ1hrtY9fuS5h9lJH1/Ix2UrkLrhUB?=
 =?us-ascii?Q?3FNa3rIz7j1j6gQK0hKSboE4Nqg2C4QHReBwwOfKb8MXc2apEvEEu3tJx4VK?=
 =?us-ascii?Q?Jd1pGg/fUORW09CLbPkPxbCBwXLZ/QFYBcod2meY40NPQdOV2OQmVebTPKf2?=
 =?us-ascii?Q?4BQkLmOjo+8TyyRqUp1UinoU0KcC6hCw/7CktV0kAEYExxnkDwRzGnIaVLVB?=
 =?us-ascii?Q?myds5HAmQTVl8w1MKEfUsafPmbaWuGTFAIphP6FUZpWX74rLIyb6rqvE1QeK?=
 =?us-ascii?Q?br2zm+ZwrcWnLdE42zBcSp/JUuJ2DhvcgCW/caSrdjYs7PbFh9tF7hkCca5J?=
 =?us-ascii?Q?eh9fVaGiKcqyXRLsC6X8eU1FOtrTP6IbEA3ehQ6xZ+cD+/lRMH3LnafVymHD?=
 =?us-ascii?Q?+++D6BENhNE0GTBxjjpo/I6JNzJcNVs9T8BLGYNQwFNhTG+zpWMdx4EPjrhk?=
 =?us-ascii?Q?3yYrKa6M6JMBTv/Hamu6HuKziFTiKxPYtdZLbNe7iUTbUWAp7j0N0JwuiAMZ?=
 =?us-ascii?Q?37BG39QlQY2z1L3s5+YAujPKHlOIZCKkJkFLRGYPe3BI+n7c8RVBiJYmP56C?=
 =?us-ascii?Q?1s3fDY3uXb1IZX338ZSMJHTz+u+Hh9ePUFCMrhj8uCtFtFMtkC6nvTcASmDB?=
 =?us-ascii?Q?13NDi3Xfit8RAB5Qw8NUJonvU4G+gLJ2uc5bfJO+YBOggiSQt7O0XeeXEeU5?=
 =?us-ascii?Q?NOSyzMqYBQrUDWnP2gAQPDspTYQ4omoWyzDR/2EMVBofF+5HNbfx98q9jACL?=
 =?us-ascii?Q?PDWff26rVPOGqjzy0OafbRLyUY86L8s1xvdouzoJ55SR0mjP1rXnK1wlTTu+?=
 =?us-ascii?Q?fEGVkeKpgPjSeEULOSlEIucD3WC4FZscEkxAzL2UXyx0WoLE6ylL1TocXyZM?=
 =?us-ascii?Q?owuE8oZO5luXzK3sQI6xHPpahjqF/cs9goy3xNk1OJ/JXTvQJbgTm9WujQhd?=
 =?us-ascii?Q?OmAUh8IdHfze8tHNMvFG7C3kMKvx/j95PXollS/WOE4xBT4cH3iRdDJSof//?=
 =?us-ascii?Q?anLzJTQjR2r4nBma3zZ3ylYIG7v0hsDWKo4Z+0CEfqcEsho3vlyEKr6/tqbb?=
 =?us-ascii?Q?6NErdS5fThlyr8oXzzNohTIylyGWBoE7TrOSSaS6f13AvfFlVb6D0zAUg5Qz?=
 =?us-ascii?Q?h0QofCB+HAO5WL+k4t3QTrx0bvpMTNkGtviPwKddBb1FhfU0VvW5uKHlDOcT?=
 =?us-ascii?Q?jP1fiDOvphSlr3rKcVZGCjE0zBBENX/V837+dyC4pRNqYxS60NXf9avz/0eA?=
 =?us-ascii?Q?tFckeuftms52aAfAq+Rr4DQ=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e38f64-09d3-459e-1a48-08dd7e06dbf0
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 23:23:28.2857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LSRf40nmi8FU+I15mhBFXa8KJRKemooPLxQSaCbhYTFmsAOAtZbBvYfqrDEg8Y1lvtzNmLTlE55ovtwWCFou2lnigOn9fsBXWbamgQDijJCeEq2d6C6mW0/bOJ/NYw5A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9998

ADG needs its MSTP to use it, and it was handled as "clk_i" before.
R-Car Gen2/Gen3 are using it, but Gen4 doesn't have it.
"clk_i" is not intuitive for ADG MSTP.
Let's enable to use "adg" clock. It can keep compatible with R-Car
Gen2/Gen3 and Gen4.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/renesas/rcar/adg.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/sound/soc/renesas/rcar/adg.c b/sound/soc/renesas/rcar/adg.c
index e6b7273b27ad8..8641b73d1f777 100644
--- a/sound/soc/renesas/rcar/adg.c
+++ b/sound/soc/renesas/rcar/adg.c
@@ -31,6 +31,7 @@ static struct rsnd_mod_ops adg_ops = {
 #define ADG_HZ_SIZE	2
 
 struct rsnd_adg {
+	struct clk *adg;
 	struct clk *clkin[CLKINMAX];
 	struct clk *clkout[CLKOUTMAX];
 	struct clk *null_clk;
@@ -386,6 +387,10 @@ int rsnd_adg_clk_control(struct rsnd_priv *priv, int enable)
 	int ret = 0, i;
 
 	if (enable) {
+		ret = clk_prepare_enable(adg->adg);
+		if (ret < 0)
+			return ret;
+
 		rsnd_mod_bset(adg_mod, BRGCKR, 0x80770000, adg->ckr);
 		rsnd_mod_write(adg_mod, BRRA,  adg->brga);
 		rsnd_mod_write(adg_mod, BRRB,  adg->brgb);
@@ -419,6 +424,10 @@ int rsnd_adg_clk_control(struct rsnd_priv *priv, int enable)
 	if (ret < 0)
 		rsnd_adg_clk_disable(priv);
 
+	/* disable adg */
+	if (!enable)
+		clk_disable_unprepare(adg->adg);
+
 	return ret;
 }
 
@@ -475,6 +484,16 @@ static int rsnd_adg_get_clkin(struct rsnd_priv *priv)
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


