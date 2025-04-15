Return-Path: <linux-spi+bounces-7582-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0CFA89159
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 03:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DFD37A5464
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 01:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8061519BC;
	Tue, 15 Apr 2025 01:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="TGQz1Ecw"
X-Original-To: linux-spi@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010048.outbound.protection.outlook.com [52.101.229.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15EB60DCF;
	Tue, 15 Apr 2025 01:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744680860; cv=fail; b=ZQsRZbuFZlEKKcOaK1ROjAWuSeJTh8Aja6hl2kiOk2UuDJ3fn6Ebtb90FuACBKJlc8nvO9DyArlSx6BwEQzQrZ8pwdAYHB2JW0nLMWAH3wwBnqaniwDfaemkQDpDiDPQcA25/Pfselt1mdSNK0LcQJMEHlEo6n0Ri3FFUD5GuJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744680860; c=relaxed/simple;
	bh=myyhSwa8S4wUZMB71IBEiDmBYmOfOtRPA23rYJ8Azlo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=Y+Fmqxaj06JWarQh496CXeFhkAWA3aHoLbqvTVw6s8LENuKFmuyZYBLWNyiH0cF2NG41o24njPXnMxSnN25hF9SEahYBNmSjm0MamS9y00sjPoouxNBg4VqvmxaP+t5ajxGcHzWnRKvQg7FKZiKS2tmIUGBSAQZ6lTeR3cgD4zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=TGQz1Ecw; arc=fail smtp.client-ip=52.101.229.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pSPYv/aOpdrfSg1CDsCrqCGnh0cNwdLsLzehSaVAOj7RjKy9+BMWRf9qpRMJj90ZdQPWJKgRSMCR3YA5lR7kEekS42UoAP0h916pNu+QA/VlFuVzd/uCluIgeVqkLaPVxdUetI3gSu5FIj8VUkCzw/DlsnLz2G+hWdysN/X8nDpSSlx2boTo8q/3CY2Ohs1QsIVbCXv1nLre8ImHgBn36oDy/Fx6wAAjpSf3/17+bvFZEeFh1rJOz+it5W7RG4d04uPsMQa+zBw9UmK04AyRHF0+Hy4yXZAhWeFUE4IGA6Yzl/dPI/ORvwHmNdqIdgz3/mnoMXoa9XnzXbnJpkY/sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEoQY1lP91QhtGQBr6rK8FvNRNOFL1cfkLPX3Co6aUU=;
 b=ZsvyKRuwN+CSzzZfWLM3aJ/I/A+GoSXJfWUuyH5clAh/LXJjTnFQwppjFyzKpzTAJVO9VbA1yf/I84lqKXceE37rdiC7m3QibgvRmKZoW+JrQh/nUZrddo9BYdPQImCTBXyZjhI6piEJv1nndx9CCmzAtz/PRejXx3n537q7v6Oub98SN5RJn06SGDS+qq1iTw7IuHlumMm+cjf3O7Xf4MFIGgtx/3iaELsXmYBuQkOlWxfg8eZJbHODpj++Ydtd8GnTkCkrzah+VqBW8HlPgAP1hrse8MIRJZ5hOEz0Xru1QeVlvTqRetxlBsmA4+VxOIhhOjC3ryrtFmR2dkBxmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEoQY1lP91QhtGQBr6rK8FvNRNOFL1cfkLPX3Co6aUU=;
 b=TGQz1EcwcjT/ND3Zw5BAVB8yqqaLrnAWgsmoiTxusHGQu6x46vozd3TqhNLX0LD8hCe6ZWokahhxkQ7YxH8oRqRv4Pt1vaieH6qVXjSxRst8bE/8ygnWKzp/XxORAj+OevrEykFsYgR+Q/mBnZ/fPRH9dsRUJODZIL3lv6HpN3A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TY3PR01MB10906.jpnprd01.prod.outlook.com
 (2603:1096:400:3af::14) by TYCPR01MB9536.jpnprd01.prod.outlook.com
 (2603:1096:400:193::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Tue, 15 Apr
 2025 01:34:10 +0000
Received: from TY3PR01MB10906.jpnprd01.prod.outlook.com
 ([fe80::592:9b7b:ef57:2dd8]) by TY3PR01MB10906.jpnprd01.prod.outlook.com
 ([fe80::592:9b7b:ef57:2dd8%6]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 01:34:10 +0000
Message-ID: <87tt6q1a3y.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v3 04/10] ASoC: renesas: rsnd: allow to use ADG as standalone
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
Date: Tue, 15 Apr 2025 01:34:09 +0000
X-ClientProxiedBy: TYAPR01CA0094.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::34) To TY3PR01MB10906.jpnprd01.prod.outlook.com
 (2603:1096:400:3af::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB10906:EE_|TYCPR01MB9536:EE_
X-MS-Office365-Filtering-Correlation-Id: 6200c5dd-d8d6-4291-fba6-08dd7bbd9eda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|1800799024|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u4TsQ9T683V6fQC6+RaaF4x+NW9TKvHKuaPGsciqwEdzCMZbm0bG/rl8KpNX?=
 =?us-ascii?Q?eME1dZoI1fY2Gd0aX94ONsOLPKzpRZYy16IprY54KULcFqfZqMFzYDkg0VAU?=
 =?us-ascii?Q?4R0WFe53h4XfhGrOxerceF3zbTfRcXs3jwe2Bt1IVGW644eDCMvUxIG2oJ3s?=
 =?us-ascii?Q?Z8YrY5tnl4pKU6P8ZV6ja3X+N9UfkOUhPqUZd1pjrZ2jQ5lvuMfVPkb9Ho0v?=
 =?us-ascii?Q?QVyuNVWCF5ukF3BDlO29R5XRSQiezLN+X3s0CKR1lsVhQRbM2ppZYTnI8ruM?=
 =?us-ascii?Q?3Ou9udkKdW8Krhaxr9G6tZ84kUT7qx88p91xcyIe6HIufFnO2nlI/Ek21vSv?=
 =?us-ascii?Q?NP11yIUkVqHXuWEBJneTA4bAfwu/QM2dge1J0ljnsXpC3/5scclT19SERWr8?=
 =?us-ascii?Q?pCyMZFgQcnqQlz9+XgCbQBzpVkwz1Ja9pvT3gVj8GFsOjfp4/gTJclqb5TAg?=
 =?us-ascii?Q?siQZMqmXuivWfnrjLRB6hNHCgzmXu6U7N0TzgYRAtLGMEfK517mW9DiF3j7u?=
 =?us-ascii?Q?6CWLoCnfLgT7MHLEfxiV2nGh0BetbxMvrAquLvXMOsVXv8LlkmefaRjE11Pt?=
 =?us-ascii?Q?S+5YqMbQjdLqJcQyi9+r/iltszu84PsoRfOaxY+owpBHFGHq4z+RaMByxXWe?=
 =?us-ascii?Q?CO80q7ScOvDb9tYlNz72Pe2xlYA5Zff1rgwnTwty9yedd7UcMTII5YLnSlYR?=
 =?us-ascii?Q?rndQ1BhO8S/ISDqGqcu+udtksvBVG7kLpAQnJBYhJxx/hhaNsKKcnM2niiMn?=
 =?us-ascii?Q?KWHHDWfDfnW54tHeejVYnYQrPbhB7SjwCsV2YUjvy5v9kj44GsE+Q3GSrz/Q?=
 =?us-ascii?Q?0oG2CjO3vvuettu/F+odlPln7jlHubmLQ0fxmU+SgvDlQFzTGRDL+OXvOx9y?=
 =?us-ascii?Q?Gc3uja0K+0MmHfs6V92C69WLvJM1XUTGHW+4Ro6GEDa7oWRYwq0DF2u/zify?=
 =?us-ascii?Q?+yBjit75j91zlYw0eeK9lTigp//JC4zypaNs24RL/GZQ1Qm4GRNpvz8ugjDk?=
 =?us-ascii?Q?aCU0dSzLXYQyIWAFVIxM6yIZH3bc1hlN/NwIl4q3vBOSQtxmfWfZjJ1lPEHD?=
 =?us-ascii?Q?wg7oUDO7GOubUnLZC1Frwzst1b/OGNBY16CGq+5ofUcOcdd4695HW4K7sERm?=
 =?us-ascii?Q?L5AcBMXVszq9x7jgkrvzfdky7fFHCdFC+JuaUFw3NiqmfJXxaXpa6thlWgPu?=
 =?us-ascii?Q?dbI4LigXw+/JoU445tKUJrf3xAYGrQ765wubbgbAxGgwWSvcPf/CGietlGnE?=
 =?us-ascii?Q?kXLbqqXWH8lZe5MdXrGousxQRoqQf9IEdZFxsPAAbUtL6NYrHGgQ4cQtDBH3?=
 =?us-ascii?Q?frnRplzSM/QLdBiPAbx8lda9vTkpMj7YOExTeViIFUWgcs2W+fX0uxmPJrB2?=
 =?us-ascii?Q?fjH/NGpY2YN8AuFDnyi5Su8HPbdpNO+rj5LpWt+laNPp74coJWaFIquf1jew?=
 =?us-ascii?Q?l4RS7XvkKebvvSEwsaElz4/iJx9FpNefkF+0bfxi31Ds16XjxDwTmDr9sIkF?=
 =?us-ascii?Q?UMrmtop09VhRkZ4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB10906.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(1800799024)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M3iTCkhTwMSPgmYHxODYqjlHsAQ3LX52Clc5tX2KgtHAQQNpukJeU9+1sYq5?=
 =?us-ascii?Q?PcOs2qcelaLS9fFwpxdtmRsTmhaBWAIOKP6IsZK1ZYpWGfsD6SGOgy4m3f+6?=
 =?us-ascii?Q?zo+rAF4MQR45plQG3tFABisBZSxf2iawEYz8tor7dEhsVpcqkGKBLbiSxEZh?=
 =?us-ascii?Q?tcJsw60t+Ty+wYMYtaplbsy3rC7cfnt9ohhQOXxw6Evg/oS1xdPjfPMb6gQl?=
 =?us-ascii?Q?wf00ZmjQ0yCaMqCk/1Yf0VEu8dCeHkk7coTFb/MJNu8Z3apBAJdMdvII7oHZ?=
 =?us-ascii?Q?GjWGjXcacbGA1kiA7gxe6HOSXcOrwr4IVpkSaXuRp5hp8zdloc4b3SIkeAc+?=
 =?us-ascii?Q?XI2WkLgXZfWiDXqbIX0//eLXbR8knBUrbPC2dOZguC+3/Wr+tImzuofQzD8m?=
 =?us-ascii?Q?7/yCVR6EDPd3Lk5mngHjozpvjz3WYDyxqMlYsx1tOT42BWLviZBa6y3529GC?=
 =?us-ascii?Q?Af6zrs0b0aezf7BnMLSSGRvrYKfmb80ow5lKVwR5aGeAPsP5HHAc9ixcmpWA?=
 =?us-ascii?Q?Qjm6Ou6LrE/2tHG24+14UjlE7JcQl6qm4AsWDUAa5SyMpSAZWdvbZf47cXkG?=
 =?us-ascii?Q?BZtTJPdPwXoGfLL5NnZ2wEoZBt+fygSu0Wz8UUVotGyhOwOA8COUDsEW3MG+?=
 =?us-ascii?Q?StU8Whn5Fxt7e+n+MRNZM6YY6Dw+JB2JJtGxNXcQlCUs9wVn5xcZ1D9w1hyT?=
 =?us-ascii?Q?OGRTkyGn5WOMJpUaG/JVug5ARZnBR76rCvGUx30mR9Tp9ZrybAW5ZLs981e3?=
 =?us-ascii?Q?GtHiMRvf3fUNJDROxktn7lOok0bwM7P/+z08yy8ymjx+5UBbugsNZjkQL+y0?=
 =?us-ascii?Q?zePSsTWk8/rjonTvyGB3VKbMOTf5t8g2PXl0OwJV50C0sQbyukZi8GF+4jUi?=
 =?us-ascii?Q?Ajr2DdeiftFRYqGq7bBwWc5XJee2JgMS3ja+BeQr/LylFe+jhRzxh9G4RNuk?=
 =?us-ascii?Q?Qg4MIk0/d7QP3kev3h2mCXG647nn9/ote6LaSMOGgbrZIT4YzbzDVHlA586y?=
 =?us-ascii?Q?3CPwfcs0FmF+RVezCbXuMaGX+a7XZhVR48M7AJeDD8keWe7KGC4y0Q71KI34?=
 =?us-ascii?Q?76y8tE09YahxRiUZCgpGKuc2t90DGIZwS9GlR2HzOgBs2cTI6dzSL/vueYPu?=
 =?us-ascii?Q?3z4bW+TimnOQnP8OHQ+hlOthUQdxdZF6NOC2Y+Uwii36U77ksHFSzPGk6MuL?=
 =?us-ascii?Q?PJdl837q5HsOeFd9XtpZFvYrii4tENgTuQDoAWEEg63U0VVmlIfpMuEQYeUO?=
 =?us-ascii?Q?jwmVs3Syl8bOMcr5WS0XyAe0Sx6DT7MeoKLXuSJ2HhHLwVvL0V+W1gqUlNSV?=
 =?us-ascii?Q?fpyfgj2RXsCSt6z7qcdJD9O412bgvVk8OyNiLpnt2VmNrTgLk5jNoYWdGelW?=
 =?us-ascii?Q?c1/IidqJS6+hQNzgV80od9wuWOUWWDomYsPxzI/GnrXhKPs66XIUqmy2s9uP?=
 =?us-ascii?Q?wI6UaBWrWZK5+9/hcSbmtcUR7EyY1kvQgPl8qfbk35Mv5lfVqWLcqr8RfylG?=
 =?us-ascii?Q?mpq3r4WRuQA5VMfpkmjubJ61KOVwzluwDkaz/LGPZuZodytI441RGby7pCi4?=
 =?us-ascii?Q?M/QeUdVEfDswX9hscl03mfdC2LVH7m30LHp3V2nJGYMN6vtXR5Kixz0Kyeve?=
 =?us-ascii?Q?Eg=3D=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6200c5dd-d8d6-4291-fba6-08dd7bbd9eda
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB10906.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 01:34:10.3085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pmGILiXV7AkQdrERySqzzzxCdEn/7Z0mGYkAryhfl3EbxQPjDXkttpqm1VxP3WgWYBF7Vb086ISLWlgKP69lb44jfg+WSyxVh0mID51XLEfbiLvz8hi4UjYP6snCByWm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9536

Audio clock generator (= ADG) can be used standalone (without DAI),
but current driver indicates error if it doesn't have DAI on DT.
It is not error, allow to use ADG as standalone.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/renesas/rcar/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

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


