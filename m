Return-Path: <linux-spi+bounces-7658-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7EDA92E3A
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 01:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FD9B8A81A8
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 23:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943CB221DA0;
	Thu, 17 Apr 2025 23:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="dMeuYzIV"
X-Original-To: linux-spi@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011028.outbound.protection.outlook.com [52.101.125.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FEA22171B;
	Thu, 17 Apr 2025 23:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744932206; cv=fail; b=usaypaH9khDYToAKS2oETlvSK2PJWG0+Z1Xw5l8nUOKtZvPS80lakd7rKZCYCd/7yuVx6QR0HBeiNv0J3FOcXYGfPYwBe6Wn0qltOGo84xnLf4L+vUnEZ/9x/xFdxsBAijwpUoTmxckcMuq/w3Ti8Rp7teutB16Z4ZPp8V1ulnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744932206; c=relaxed/simple;
	bh=hYH++XTcGu6mrsxPKWjo9f82DNfpAj7oNqxfc7ho52k=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=sKwNcaPjBZk3bFCnhnmQKvAUacwil5USkL7UxBBefKfq9XgV20yIpvRe8PBgs+aFPBSEZF8jJWq7o65voJlzDVfdKkV1oxvsTGUhsMupIFXy+MhSHe0by+324ZWOeGdcb3Lih9N4JECO+hNtYI20LrxP+2REdOgoHBeX2/u+p6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=dMeuYzIV; arc=fail smtp.client-ip=52.101.125.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lEhPBSHLjlpWlftpyyCcK02VAZQkSmJ/GKtd6TDz3p7c4cBIS/uqPMt9mMhcX7E7lktJaJooXp5zrjcDaDL/eWguzHzXcHCLjorBQPOTCXi5HonOMDyx8k8jfNwTw2lv24qYhrekZbfGqLAj5p2cq5MfbsinZAk3lgsdtYmkEcDOl7ixAEhduZtINFT6C/BmP+4AcK4kjOQUdolK5EAUFaXfYs7qCaHi1NRJVWeYw9qwwNVXLhKgyhzbqPrbwhbbVyW8kVqNIC4yf1y0ahsXmKKcxHBM8BDw8T6nGciTEZH7GX61e87HJ1HbgUNgC/IC2dE88LQC8QQFChTBEctZMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axXaomBlX6K1WlxS5eYXhpxMOrlFdKTJwLhltiVPQwk=;
 b=HeX5jmLVx3YkLEqBMttayXdJTwFl/+L6qa9M0PoIvy4UhOfFQGnPBDMHIDh1xzCM0pNcxR4X0IUOFu/sgMDQNa/OxxpTUUW7u8PMN9f3jxTyZdbUDCGzKklNXLbvM/12q8R7Sx0HkKksO3V3F5qeQmY4ckdr9T+JQhzKcDnkPnhzPxlNHdsXMk4xmMcYFiBpfZyU1cXrT5q1kcRcsLPRUekpMcEBJu7tClLymihwhzpNQnPn0H05F1luwluK/MMnSLvbVobVqofHcDBCayTTQK1p332022h1fe6/dFeJzfx/zYW5GWlA7xyb5i5CCr3robbdTx1giYFPDs5oNL6XNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axXaomBlX6K1WlxS5eYXhpxMOrlFdKTJwLhltiVPQwk=;
 b=dMeuYzIVDkyXQ/8KeV+nyN3y3zT0bklEKs9N0MHe4lgFShd1FchTxi16TblRRvT1JzgnDCZBXclGC/E11q+D30Dl3yzXb8S5nTTrP6OQP8S4HCnvNj4k30Dbv7PVVdBjmQbC0xrSgWPbo4JVWBivRcgCcL7y+F9muBkhqfEo4Xo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TY3PR01MB9998.jpnprd01.prod.outlook.com
 (2603:1096:400:1dd::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Thu, 17 Apr
 2025 23:23:18 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8632.036; Thu, 17 Apr 2025
 23:23:18 +0000
Message-ID: <87v7r22x0a.wl-kuninori.morimoto.gx@renesas.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Jaroslav Kysela <perex@perex.cz>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>, Will Deacon <will@kernel.org>, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v4 4/9] ASoC: renesas: rsnd: allow to use ADG as standalone
In-Reply-To: <871ptq4blr.wl-kuninori.morimoto.gx@renesas.com>
References: <871ptq4blr.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Thu, 17 Apr 2025 23:23:17 +0000
X-ClientProxiedBy: TYCP301CA0002.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::20) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TY3PR01MB9998:EE_
X-MS-Office365-Filtering-Correlation-Id: ef744469-2a5f-447c-4e5c-08dd7e06d5f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VVE24ijMU65tFNLSBile0BqmI0jcr6mFfSzANIrp6zlJmLmX4SrYBFKk5umT?=
 =?us-ascii?Q?NXUk6rgvzIEuLJFLyEPyn+cJCrnRi5eRR015IdNw/+Hwq+iVCI5s5BDLsBKt?=
 =?us-ascii?Q?aM0lyhSRJiGT7PYaYzKjahr0kWsmnufYFh77s6+5vAcDBydhtJJO5IEHxuee?=
 =?us-ascii?Q?R2zCI+PLo41QoSMmJf+wjIDAJoUYvsxGqgLRJDoG8txfZs/U0belQkNXrDAu?=
 =?us-ascii?Q?1BDd5cNAZNn26kN5sS7+hB/lYW+vquHxYBpO4ipKmBYSpNnupxnFxPVPizPI?=
 =?us-ascii?Q?K4edsaxauIqWhvgU0H0DtdVoreACWzs0Ysg7NvCGEfivBrEO0QKdj7MQmTGr?=
 =?us-ascii?Q?YU86p5PSJpWeC4E4g8CODAPu2BXr6JJB2OHX+gjKFGH9qdA1aPW0Ii8DXyp1?=
 =?us-ascii?Q?pg9jSfs5vL16boXDPcT6KvkCfhRKEL+VtW5ixdI7jVKpQs6JsX7e0ucVN53m?=
 =?us-ascii?Q?xxJmeXe8ZJz6gVG6F6oXXwgd+Ogfz+tgdUN/TWNgCUkSkg+mb8Ii2KAQilf3?=
 =?us-ascii?Q?QrKVJkh0EkeKTQSn5qVM2tqzRw9IdCuRoejQT4e/7nfGCmZozxz8ApwWwhjh?=
 =?us-ascii?Q?f0sIC6uLg2NzPg7BNGkqrcipx72dnfO1TiK6AJby708NUP06xx6JV5RhD/sq?=
 =?us-ascii?Q?xQeZxZCtRBpC841hBbylp7LMVBCtsz3rrqdBVyPFpSy96YwNJhRQjsloqw3n?=
 =?us-ascii?Q?yJ4V9qP7y0B0ST9Kikhe8IJ2SxPyo7GPyui6EoqqqQpGllPf2awVmIqsC76+?=
 =?us-ascii?Q?SUzlOSKEoGXer8ariFg830r7unLonK6GFluV+BeCCNwLCyOm3Knf+Erv0RTW?=
 =?us-ascii?Q?Jbwpp7HMIxTXMLv1+3BYkbfTvIHTXMU7+tByXji2Jth43B7Y3Iw9elO1ey7a?=
 =?us-ascii?Q?twvOZMi4zEx3DegiukkyZPs25E59JvtBIq4hrram+QycKin/iPLSBdqUU0Hz?=
 =?us-ascii?Q?h3+XACBHRUFYX4qeXNrLkplVORew0abPqeDwQW8Mi2K4vTVFAezUnAlbmooQ?=
 =?us-ascii?Q?hYDPc6/D75qa3x1cq69z27sSWo15bxcSDfCgwf4d4VyOaaHWNiUhZ55amgFO?=
 =?us-ascii?Q?CYQD9hm341HbbGgr86IpJPBeR23t/588NLw54Oy4PRzMnlNy+3oaYRzchpRo?=
 =?us-ascii?Q?5lPKm6iNsteXHcj6DZqcHnUdLFHAZtFW6Y9tJIPHZ4AaBMFX2tAxb29XxtTq?=
 =?us-ascii?Q?0cGlrHmCUt/gjStG4ZjNyg6AqPed0eMGmaQ17cIZKJPrm2Nzz9as/2B9BRdH?=
 =?us-ascii?Q?9LbJzZE2ZdHKbIJZ5U5iRcByWFxsQwUOMjPn1N7WSEDvdyMepPxjY9TwJt0a?=
 =?us-ascii?Q?d4oHtPor3Ytp9+JP9VTII0Gav6PQcu7RQN8sAAMyrv+YgMY6grAF6nqlHivS?=
 =?us-ascii?Q?EJa/kBqBLUi42HtJwWj7MO47q4VkflA5pNcRG83cUvGlMomzoJ+hepNXqDAK?=
 =?us-ascii?Q?PEYnoVMWUY+Qbrs51rF/gaIsBOu/5sizYvkl4BugsaJzwT3I6z5FOHGq52sE?=
 =?us-ascii?Q?H1M3Kl+BriCprBs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iLnbem6bIBrhHhY7LqfJ6aP2x9caguWhjFvmTfoL8AicgKenAiSjVjDyEF6J?=
 =?us-ascii?Q?FY6hAuOvDfoqGmyjNlzVqRNR2e0jFeEkboRswN7//LuZti0ydfRoCceJnt0U?=
 =?us-ascii?Q?YiHjoaPuJVJzI7MAGUdTxrPIWRKbK3igwFo0k/AOUE40QSX4p+RhuhEEDe8W?=
 =?us-ascii?Q?pqyewlMwg9bgoKLTCJGvQHW2iNT0TJQUOSTq58BImtj5wDWhQod7pK7orbvc?=
 =?us-ascii?Q?ojzHGvaOAIGYo3qJ0qyg1giN26O8NktYf+BDzhndwTGg7BCWE5NhLifk4Pwz?=
 =?us-ascii?Q?G0iNEGdnHB4iDpSvKPgx784ANYXza1BI6A1gMLRW1PkZYca9Iox4u+tph35q?=
 =?us-ascii?Q?jKhfa5HN1GKgPNfMqsBqc66CJd0+RgHM0dDxAPpeKF7rsCm7qUH3L0/vkzHb?=
 =?us-ascii?Q?6DXRctL85slyy0OX9zkrtqFXWpdxfbL6+XMiS/jELdnTKonc/A0E3hFDuctS?=
 =?us-ascii?Q?t4a0cZpeVpSNPObJyVMyaS/ydR7C0fmM0ek2ZzhdhCBtHGgWOTDtqSY2v/6x?=
 =?us-ascii?Q?Jmc8hIPoUQsf6MUfdxcQo84QMKEFKRCbGJvH2KFRWASKzuxWguwIXpK9EccE?=
 =?us-ascii?Q?bceTjjQL20Glz+rl2nshkzi8frqwAZA/sWWiFIKstby9ud4RLQT7RU78kGSq?=
 =?us-ascii?Q?SeAfzLDc87fKdpLur1Qc0ymA9YdpmVSxRuHZ/+8hwVbR/m9cxqVC4HF663yW?=
 =?us-ascii?Q?FqZ3z0juJ42cWgHX9bNNcytVStz9ZTKKe6HHWL+OYHsNpLH4TFdA21/tjBV6?=
 =?us-ascii?Q?OOTbJdQjR3RtoBugddlN+GX+4EygszgrYCRNM4ZIEMozH3xyrzcIUEgKDERy?=
 =?us-ascii?Q?Imxma+8n5BD53COWS1Am9c65R6kJu9Enfw/W4V+WycY4fu3pfkz32Tmleq2K?=
 =?us-ascii?Q?9goK8a9ElVUxpIgkpuIIwydra5mFgd0hqEcut1NEX3X8Wr65q9PG5ku2q71U?=
 =?us-ascii?Q?neLXbBHRgVXO62loC/OyuZ8uWe6KtH94Lol8rXOePfcttyqWzewBd8nvi1ny?=
 =?us-ascii?Q?kc0SqARWfbpjBVZMP7igkZ1flTMRb+wLm5tKtQ33lasBWlG8EFNFWEnkL/eC?=
 =?us-ascii?Q?5iTKGqLcgzvc26H/rTO1BMA6ENUR3rGNml9wlL3t1j5uxVrMzQ7OeLXORkqI?=
 =?us-ascii?Q?WwE24mslDkHBBXNPKFyjjOE64k0waottixOc6a9+zn7imH5h79eabpaTuTCF?=
 =?us-ascii?Q?/SyKKO28Yxo3+0zyIxy8xrip3DDTZdJylFFGCZw7/1jZYtxCoxgwP7HD24WJ?=
 =?us-ascii?Q?bOl8lGBpvXv+AzgAvkIHCixELCT7yx4dZUnrstzv2hJdRFPaj03XfPTy5mWu?=
 =?us-ascii?Q?DqLz0sq4fxLU7bEveCj5WUsRAezIlyIQ5PGZoOZXPUSvqSndb4MYF5czo0dx?=
 =?us-ascii?Q?e1shE1N2I3GJVqeygNYPFJyvpR7aprJbxAoI8/KWUwNQCtYYoIviFNjrX6O7?=
 =?us-ascii?Q?Ld2yOmfs21VtH+OLR6B2ri+VQCcx+PyUD1X+osUxeLejOWp22Zg/ttsS/1Hs?=
 =?us-ascii?Q?Pn090C+qNZNn/7zHfZJuZbt/gspo6/BDQnZ+UZSpgdKEOG/EXk9SoTUgyJ8H?=
 =?us-ascii?Q?gOdwVhq3aQMgWvpja5W3IVuDHLX8na5XIoHhtaX2YPtpXVeAcWrEEnbF8s3Y?=
 =?us-ascii?Q?4b9MWBxhMG7eEWE03ULVdOA=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef744469-2a5f-447c-4e5c-08dd7e06d5f3
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 23:23:18.2441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H8rnMDU3sdjb9VbsEinHw2h5+5Kk2PgoCIKe1SZ78iGriEvj7+oRh+36sG2tURuSDkxAhyBAXvHJ906w5W6XgOTa4wID827exFZFlvOZDGkRTPhrzZV2y67FfDvmEbTJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9998

Audio clock generator (= ADG) can be used standalone (without DAI),
but current driver indicates error if it doesn't have DAI on DT.
It is not error, allow to use ADG as standalone.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/renesas/rcar/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/renesas/rcar/core.c b/sound/soc/renesas/rcar/core.c
index 30afc942d3818..4f4ed24cb3616 100644
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


