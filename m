Return-Path: <linux-spi+bounces-7468-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B624A81A41
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 03:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8828646446D
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 01:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30654142E77;
	Wed,  9 Apr 2025 01:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="BCVv+i1j"
X-Original-To: linux-spi@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011012.outbound.protection.outlook.com [52.101.125.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A02813AA3E;
	Wed,  9 Apr 2025 01:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744160724; cv=fail; b=CWCCfCpg88x9hbnRA5NyrYMnE4eVDxzZkZCgnMLhvFpLwDhVHAKRuH10BV2T1NiNv9IhwjeIASwixuv3X96jfQaAC7Qqcip0H3IadcaOjXeHUqQu18Z2Ilr6+jrXrBkR63fkEjFnvra0/yJq+0dgXbln0pWhGjFlOJQ2sH/Tuek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744160724; c=relaxed/simple;
	bh=X/MCGX5ZcEMl5UC4fpZNVVfxDCD3uS3+nwaLDbtYJd4=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=p4SM1pNiBRlrRAqe4CdX/4doRG6w90DR5VRMucngcpTUeyH2/luWFz+p5ER3DkmaTE56Pn1dvv7ZEBXtglHwpzOs+Ajgz9ZgfbU9M4gnvTsMsP/S4Yqr8NfD8jOCFf4ySzH6BY+B8LG5b6xLY9VVE7IFN1kwAgEqggw4ISuancA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=BCVv+i1j; arc=fail smtp.client-ip=52.101.125.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nuOXfImFdT5pJOtiEPVXCPNYsukkJPIWrFVWOwVWFMisNrWZJSnDRXCD+0TJxBEUgt/lU656Y8Ch+KqWy/ffdLTP3lD4jhkdCQtif1ssdszlIRqOOvI4lqu+YLVtDfizdrW+cIy5on+seRXe3AGHt3PhZKuF4OMufGp9K3ycYr4xyVnv3BaDHATqNyIbcarbtjyvtnZnjUGxCggcwcPByNmdAOMICwSuvYCH8nbYEAVrnrDRtsKxiPzGcW/348F/SUgF/KSdfadb/N58X/evPUXn83MLF726Usvd+jOXeraXsmyT5drLTW05KHu4hOQzcGax1XtYscDnerb+BXSEog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFM3jCzjElgHmGdWxlofjxtDE98tuz72axM5ApAUgag=;
 b=S4riTD17H623bJtuKtqPiUFWD+LR6proZbARlO6THZKDNu0tiETEJ92R+BIDWxoNioiZl9+/MLus/LBZqNIZDvnHYkRZfdDlxYFaOIA+C7ulOdT2gkYGwZPQxuZOlVqAeLH4JgCT19lnQVeEmObnEs0Eha0alqdzbHPfU+MH8lFnzlKG8EXF3Vt4j3WKRP6m3W+6AekfUbW0vekK7CTWLGDGI5drguTfrlBx6M83b3sEl4UGpD3ZWkY8fW7TlqB4xGnjqCUmlGhOc7eIfcb/oNrAK6gUfGcaY/27KKwWkd/kt42F46trkugqdDpxQcYB7uAnOAfbeErY2lehkG+fSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFM3jCzjElgHmGdWxlofjxtDE98tuz72axM5ApAUgag=;
 b=BCVv+i1jONxQ0wRLv86CTstkTtkzJIxG/ERy55iFOLfJ5rnW3UqnDTH6x1jk7XtkU0QuvGg9DAXNMhFRU/VSU4nlNB0EWTuG00gdbvVjn7uVjZAmM3aAqsPWEofh6C5CCkvY1MACddp9mc4nSq5ApfBVS7//f/s7+gJFDeC4wH0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYVPR01MB10623.jpnprd01.prod.outlook.com
 (2603:1096:400:2ac::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Wed, 9 Apr
 2025 01:05:17 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 01:05:17 +0000
Message-ID: <87zfgq9mb7.wl-kuninori.morimoto.gx@renesas.com>
To: Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Jaroslav Kysela <perex@perex.cz>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 4/7] ASoC: rsnd: enable to use "adg" clock
In-Reply-To: <875xjeb0wu.wl-kuninori.morimoto.gx@renesas.com>
References: <875xjeb0wu.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 9 Apr 2025 01:05:16 +0000
X-ClientProxiedBy: TYAPR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:404:15::16) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYVPR01MB10623:EE_
X-MS-Office365-Filtering-Correlation-Id: b322345f-3f7f-4b33-122a-08dd7702974e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?70aP5ZN2G1+KUh0wAJrs2gYezeKv/0ZRAixme771L7Zo++yziM5I2DJFBbYk?=
 =?us-ascii?Q?ZPi20u9QlhpMJM9HHBsiTlzw4UUHEYh5u2+I8sShFZvkg11erM6rQYzNGccm?=
 =?us-ascii?Q?XyocDzphRl4fkkMNSE9aAVBg7uGXmzRxj6opMc2ZJEjuTeiUUAZmt4hFBsMf?=
 =?us-ascii?Q?n/NnvoJRq6mCY3/qQQn4SxRtOVN/qxXKyTreHec1zWnLuOsbDX7DkKJ6A0ty?=
 =?us-ascii?Q?PlSkzoAI8JeSKqRh4Tj5rq+mj49ylAeh47+FYl9Etvhm+2gEMm9pWzRvd83P?=
 =?us-ascii?Q?TStE5UM+eEctYqnT/97BPmWc42D3Um0V+oRjDIFlkR9HYVsI4HFVsOSN1dnC?=
 =?us-ascii?Q?cM+DpWq4/nmy0SmdFeQ9RU0eVrfuD++llWY0fXuoLV94eEULdY1PLvdUTpGk?=
 =?us-ascii?Q?r1ibc7+YZiOMr/1fnNfQ9zJRbWdZ0EJgVhZ18eTnseM5Q0lgmlUzhepfKFvw?=
 =?us-ascii?Q?Sfn7GF158gMUSTPdOqXbnq8UnQMQDpl+o8VCPA0u6uD7/y79dkduwPqSxj+q?=
 =?us-ascii?Q?FRDs/ZQ/vgEwgMLzGS3EyVfcAYciM2ZkCcJA5DJ3sesYcwohesmyK8hjcScI?=
 =?us-ascii?Q?qgHjGHjybcJ3vBTZ5QP819xRfFZJO+cJNdqCCrJdKmoBjV57B0p9qxRhNS25?=
 =?us-ascii?Q?nByvD74lcT1uIp8jiIN469irqvJFdX2WrhHfSjoQVSiT0/TuXPEUb5dDwaYa?=
 =?us-ascii?Q?Ji2eLnDEhthC/Amvt+PnslpIpSCn/EwP1fsUDKQxOV93ietH+pfSTX10PMWQ?=
 =?us-ascii?Q?gnlY3cRAaoNwztPebkWweMtumQaqr64qta42sq6lmzoX3BP8a7Pw6Ufl8bQQ?=
 =?us-ascii?Q?mcsjVvP07tJIXgJPZXh1SC0pt4TrIMmbcrYFfXxz9oWyJkiHWsI6zKJesKKg?=
 =?us-ascii?Q?DRNGOvmFPcgtSCdsTQmFPMoKVuyDDxWwwwedVGh/Vch3fLWnKblnS78AfT95?=
 =?us-ascii?Q?69Ti242rTHldEeKIlU65TmS6dzTLjQ2lKbGNJMR2djsL1w9vbmmQJiljdz02?=
 =?us-ascii?Q?34sXgjE2eaxrekpEHj2DJJQLcPPVIu2qAf9SL6oIqSrXHm7aqpclOpu5xGnP?=
 =?us-ascii?Q?mLX6vPsoO3RkiB+a7pu/ZUQYyiEYhJ42HduHl+6yHY/BlPSa0uXellAZJVZ3?=
 =?us-ascii?Q?vnf/LAipElHxrsgjfnQyCYIobn8a+ezTfAW5ItBO7Bo8/tNi7Lknub+ofCuV?=
 =?us-ascii?Q?CelVVs0s7nS692WdP2LSiAteIAqMHN09pIJ3b6nwf/IvCdimORYKbQhfASNv?=
 =?us-ascii?Q?sWAVVP9C8Q8eD926Or5ETIOMImnNXbuHVwPzdRvO5AX1gH/ucQRBmQlbcEEj?=
 =?us-ascii?Q?EAKSSPaHHrhIJsqzWE/7Ns660TLU8jW24DAu/C4BFvpjxy6/a+JuF3Gt29ng?=
 =?us-ascii?Q?p03MENBiqV/ZDFVvyW24auXz+PZbqakDmT0B/90Br3/8v/isAsp+4Qr3THGZ?=
 =?us-ascii?Q?xplx077KtXk3eSzZwk9aSuKTjbDMUnlyxd/aBIDoACRHi5Nmc7o9/WV4a/rZ?=
 =?us-ascii?Q?V/r4+ZlV80XGqxo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?29yKNF1RzBG+xKDVjkkY1agvGa2kjlsLvsq73oRyE/8aJa2Tua8KJ3GtLuB0?=
 =?us-ascii?Q?htDupuN8lM1dDJeRpTTy80AFRXKeOYJBfX8ezg18n0C7/OXlHX9hCMVPXNVy?=
 =?us-ascii?Q?qOptthlK4D23oU2g8nj+HFJTbehIyA1eDMPZ/J4H9api6fYAnuOr08u7VUs0?=
 =?us-ascii?Q?DZOPZXVs+ru1Y1z5jyertTRbA76N6JGjTRbs6no49g57OleaHi+Uz3c6+QR+?=
 =?us-ascii?Q?7oesrZy1Dvab4FA2F7WPgzWEr1F0P/9vc5At7EciPRfOqQPDXJULpxdi1YxU?=
 =?us-ascii?Q?r45TRkE83wvXR/BKufSxgISy5B6PQs742N0zlwbzU5FCp8MzIiN8GuVfs2De?=
 =?us-ascii?Q?JwnztTdk4iDjGKaYp8N9So078JfYk2xB9eiJUoUYjvxwjit5YYopDnXJqU4Y?=
 =?us-ascii?Q?vqCTGwvBRoBWeYScvEXCKOaTvNeZVTW/phrl9oRe6MAd9D759DRp8Z7HCAOu?=
 =?us-ascii?Q?SN1K2zhg/OirRjsEnutDR8yAYhHS56d6bqwjgfSYKpuVqbx6zvkl5iEXtLN3?=
 =?us-ascii?Q?CUnfSDGJZCzurX70mvROq91KRvi3aJgqh7kqiIagHoq1V03aXf3YyKzx6Kss?=
 =?us-ascii?Q?kMXQivSwIxVpFq4twGiD4BLMf4AgLW3uIr349phdmPHsO8U6IxXGxSvvJfQP?=
 =?us-ascii?Q?UgBYa0bdLK4fwIQEZzHK42LDKLWMPlNi4ws6XGmOIis7eUds25jzwjXta40s?=
 =?us-ascii?Q?83Cfpw5EL4IZeo4Iy3vv0d/PjRJQSRajvOXvLxBmCr9Z/h9n8h2INu4dwGB9?=
 =?us-ascii?Q?LcOSAH37DG2kWxyVrZJchuN5M4nAJHee9x61OvVbkobzIAhfR6iFCzdAO81d?=
 =?us-ascii?Q?YvAF74xiyxg7RPlunpG/WyQyQDIQx2r8dbAoFl1c8qmTy9cdiBUxsWJlVOh6?=
 =?us-ascii?Q?sMZk2okhEQkbO2IfV0yDo83FGjlMEyqMPk77JUqkXHfYKR0boOEv6QOpyOqJ?=
 =?us-ascii?Q?1H0xjKV9YzCYhmtv/+HwmbOB/KhXeWzH2D154ydWwl9ieUeT2crZ2XaebHL1?=
 =?us-ascii?Q?nidCKHQST3cda65wRvbb1PLXiC9aiCLotOQS/iuku/zvCEWd9A4taEiecRnz?=
 =?us-ascii?Q?vYs5l7dRRoXOMwIuwHgW3IDHc8R3Ail2YuLfS7GsSG7cZzT3tZBfWqRdW3hO?=
 =?us-ascii?Q?+a/Z0aMwMJECorAmRuTBkaDcxlHlDT+9nq7eRnFIai6nDtwp0CpRM5bcM+/6?=
 =?us-ascii?Q?8NHy4nsNC57R//acRiJcCz8i6c+5q4TPu+jXEgjTXeYLJupQNWSwJosigwxj?=
 =?us-ascii?Q?Nk3NTTNI7QG7tZpBrFOQvwGU+IyaZrM87+Vs84/NEEfuM1PS5aR5ArQ+xtfL?=
 =?us-ascii?Q?uTYnnoP2IN5BVm2jSC7qwJIoU3NGPusytUmdJNMFQlnZ7C7CBPj6OrnShEdO?=
 =?us-ascii?Q?OdYRyf79gbE110Dnx0EC06w66myS/3KSOSFBPvEkCb13O0qSep4LQE8hoksv?=
 =?us-ascii?Q?0coJ6vfPJCf3rCh8MX+Bhd5VHm/sE35bq6i5I813xJtkeslHxGhkHhNhaj63?=
 =?us-ascii?Q?+EcQhTjsTpbaPLkfjwCjmYsx2dHJydz2hk5R+EF1t21ZzcO4VWA02w+mm/Ry?=
 =?us-ascii?Q?KztgTpHI9UWhD/h2aVZPQzAHmXIZf0d9AB0jCa3GO2cNv2gSaCBWRCA8NBVK?=
 =?us-ascii?Q?4d/36AeSuujUQYlkAqHuKos=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b322345f-3f7f-4b33-122a-08dd7702974e
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 01:05:17.0003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: umNw0NdMn9qvFFEo9DVvPmcRPasEr8RyLBTdQpY5/L8PiT1c/EFOOfTdZBpyyTJJaVDlF+02Km1CnSqwH+H2CTMrul3KefyiJCWQ8SVI/UbkLW0Y+Aws6w6n6jumGaQi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10623

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


