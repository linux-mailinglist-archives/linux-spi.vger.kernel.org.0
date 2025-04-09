Return-Path: <linux-spi+bounces-7466-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C87F5A81A3C
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 03:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A68F19E897D
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 01:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B068613AA3E;
	Wed,  9 Apr 2025 01:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="mNUDTVeQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010031.outbound.protection.outlook.com [52.101.229.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FF129A2;
	Wed,  9 Apr 2025 01:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744160715; cv=fail; b=V7XzBA0SUt3oGgB34tyWjkcqRlBFM+pCOdL4BRlOJ5loy5zKeJQRxR7pzngHaFLFkIejw6MGHhC4pHVDPiH53xeKqdE6ft/2ePEJS9z2UozJMcL3Er1iLVrvWSoZ84hnEsXNrUowjOi+DKYmrtl55tGWnWLWvOZNSdprHHpLjYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744160715; c=relaxed/simple;
	bh=iQr3B+YG5XkquIXqLvgOAwNIpyZel3TnIpEAu1HbbKw=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=UOPgMFk4qlFv7FVrQsIG7CGbFN0Cb1qAQ0Dh+Lj/1kbLzM6N7xObnNpxqA2ztFM7CFA/jmPANuC+9eoKT3UdUZIBJlBMQSDS9OUutt4SvWQVJUnJk3rA+oBxgI3sr0IcQ99pEjmQS92F2uOtPbw8FYUskxqmKo4mDVc/zDVQqMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=mNUDTVeQ; arc=fail smtp.client-ip=52.101.229.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQD1MCIZIfQD9wpN/DguE4ZYN7zmJ+qVz0/eI/td3y5/i4g5kMmKUkPOM00D9Ee8BtfT7bDlMbEBJvmc4DPxagv6E1QLUiafCxylfvWK10qYpDLzoEYAiLaHM2luYbVnM8TLJYLkqU/K5ewwnRkm2L3zytqu/7yqawmCwlQeRClGlVQhlYYqkepjnBclH8Cm2Ffk4moP/lTSo8ZlLC7KHWe03ipp0vngkqnIvFmhxyCC7gWX4A39TsyBtPbxxbaZIHrup0QDj2RaPt7xM5IqZtRYbmZB6DOitvAGRaXF9Flgwky3AM15OMNzWpY/k37NMR7ILYiaqw+5Cl/6ZyirVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80Qncy6mxBlq5SSHaIeVuUaOfEdSRZwWwqhHvXP9Ivc=;
 b=cxjObT0dtLJE/2n+WlM2qq7tfH3bgdlipPVsjlxSR35VWASdtn0wr40SKlmGBXlLUnEwZEpV93d0p/o3ieC39vYoFhWi7ld9qlg9tS7/yTXExlmTSdMQAKGIAb5FA0DsmiDJG6PQOZIo/O+EUr8a6lPX3iogpOt1jUI4QEeBGNe9pZ6Fx89pt28dvWY2QiQJbB/SxQE3gn7zjg4YPTlYERBM7adcYbKCa42YmyL8OL4c1c/64aGxDCtDdjBoZQBrPdNezZ9vRM5L7JQDVriD+fZVyW9yR/dk6jpVuXBoKzoaUPj4ww5lHtO/1Bsb8pnG4tjwpN+1KwhuLfi0FT2Zmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80Qncy6mxBlq5SSHaIeVuUaOfEdSRZwWwqhHvXP9Ivc=;
 b=mNUDTVeQ2vFNZLSgo6+Elx93US7bWaZSEoAazOwQ9XOao6WvnmlWIJ6jM85RNGOTfjN6ProxMU5cQBIGoqN6aKL7eRG2OBTU74cYgVcsjg0dLXtgn9PgpEEGMOdaxJb96dXEAeBlMktPyfFIlszBu7ZOuJ3sLCqT+PvQV4aWFgI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OS3PR01MB6437.jpnprd01.prod.outlook.com
 (2603:1096:604:100::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 01:05:07 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 01:05:07 +0000
Message-ID: <8734eib0vx.wl-kuninori.morimoto.gx@renesas.com>
To: Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Jaroslav Kysela <perex@perex.cz>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 2/7] spi: sh-msiof: ignore driver probing if it was MSIOF Sound
In-Reply-To: <875xjeb0wu.wl-kuninori.morimoto.gx@renesas.com>
References: <875xjeb0wu.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 9 Apr 2025 01:05:07 +0000
X-ClientProxiedBy: TYAPR01CA0031.jpnprd01.prod.outlook.com
 (2603:1096:404:28::19) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OS3PR01MB6437:EE_
X-MS-Office365-Filtering-Correlation-Id: fe8cfa58-e030-41bd-2e3e-08dd7702918d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ww0RsiNHWJW0TVGN+J43b6R0n2PpUvg63fpQTjNmTy1L3XCQNVEdifWa7uuu?=
 =?us-ascii?Q?z9N6I1iLtLc3Hm7LHhJ4klUt96gUjJtwQpTLlU0X1m8BJF5N+i+cMtJDdpfN?=
 =?us-ascii?Q?t/821+jHmvwDzYl9tdfgo/5A6cMu9dGCspbNubpBXV30tgXB8Juctyisn5oY?=
 =?us-ascii?Q?DPriDmhSHbgTrlzCgDcuFRlw3UKOVtr8hWyV6sL6H7JkN9+PILFmmHNcLBSD?=
 =?us-ascii?Q?Eb+cCzbYU3UM4wEnPSdIueFbqfkZpY7qmuU5xRRCP2SC/t1q45LMSUVLGcBD?=
 =?us-ascii?Q?x57TZ7+k8D7r5Tq/wT2BUgdx5vmIXgmw0o25eEebSk8b7V7wI3fiJua0/EnV?=
 =?us-ascii?Q?ACtK0oXw8gfCDRskRY9WbGM/AC5Somjr51f926pQWWaCWr9Z2kWeOnR0/ujb?=
 =?us-ascii?Q?WdQ9ZmRhit68V6FD57gqnauJrI2QynAsrSknxbiWyoTo5qY/swBfozHgqo91?=
 =?us-ascii?Q?Me253QMX4cKA56ENy23yTiGb01DlenqJcn1mGEb46OqsS24YtuhFjLi0UDJ8?=
 =?us-ascii?Q?fWTp92rkmCoLkZz/fBldEJgBPShJ7ETWurimd4XqyMYb4R/Epfy4KFqy5QEv?=
 =?us-ascii?Q?Fqi9C+78FSgyUTgZDJSzQOYG1bgOub0saOl5X8XVY5wN6gWQeppKnSggd1p2?=
 =?us-ascii?Q?S9eOlt10SbD71ugBadrw1gfDMcGE0QBPHaqpquz/zrVLJnhEfoAO89NTXhne?=
 =?us-ascii?Q?roayz00ajQoqLFdhdrxst3LHMliMw6rwFQxHWM9UY0D6ve3ZlMLAj6RXIL8y?=
 =?us-ascii?Q?U2R3wyARjSGruedswbKYnW6fhcoVspPRhDpaVdWr43BzVa1MW7UPlkKyNp1J?=
 =?us-ascii?Q?/7k6UhVClIIioSWe3ec6n1eU0rssif1sZGj7A/ha3KMPwED1qDeelphA2y5l?=
 =?us-ascii?Q?x0q83gNeG2wNAPOuwuQlnxOQzCjcqXheTrzit459QUmCQhWkmPtwNJxGb57q?=
 =?us-ascii?Q?KxRRNUutK9R++ymCUMk+yyl/7hBEm+8Jb4KKj36PYMY2hh0hd+huIAaIOoaR?=
 =?us-ascii?Q?kHqBkfLoB/3HZMat+je2JSnYkUVn3chUXW0roN7p69sli8Mo+HkC12ByXvrv?=
 =?us-ascii?Q?oj98XzM8Rk7SPAj0ZCGj525QrZu1puoBw/AF2VnLAJ8elk/ZdBUxN3n420+f?=
 =?us-ascii?Q?ATPR/28JnARxRsFqwiIysAoGfcYAC18buuKq9yyYVOSEs0DBCoqpqOcgjyyL?=
 =?us-ascii?Q?Xt5P5T0ZawRBwzFTKm7kQpNJz8P/6AfWkzVhMxIuBr4l5s92+vFaPZVlRfpO?=
 =?us-ascii?Q?cJsppeO20bLzo/TFPGaze8PPBoygZdw7x/Ss3VyJFX1Hfuko1vDNHBPwmEOC?=
 =?us-ascii?Q?CZ7FrJYddA8RX5DphwcykCurkQeTX2ue7VPwOZr2pvt8Rr0eJiTF6Q59Ny/k?=
 =?us-ascii?Q?yccv5KMcV79+j0sZZjikKOSoH6y8OH6liHmbDSXGIN51TEFJ6z5klOA8Pht2?=
 =?us-ascii?Q?G2PrxwaIVTGrw27ba9TDHZyrGKBCt1JNHFcsSWmq+5P9cR94oqwLOg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HcW+3uz8dE74gDC526/zGRWrA1jl9MSsKP5PCHbuHjtTfJmisLoBJcRliPfL?=
 =?us-ascii?Q?A88YqNLkyDFbG99VagNa8nj2CZn+/zz80gOToZlZnh1vsZg/qOaRq51A0haO?=
 =?us-ascii?Q?unNZv6qpp3OdYMjlbOsnSWRprReGGtNPoqvf2qurXUs/3w4Zyit8ElbEOWFb?=
 =?us-ascii?Q?XkS8N3OtYx9Jwefm8uF/vpf0i8DtAYvI6We4lE85cEHOPJtzOunGVhDk6ko0?=
 =?us-ascii?Q?3xDK3lZIvQtrJRtsnrd0WWZ8UoCGMP+BngM2EEA/M9Y7Drus9HpyJdZZdnJ1?=
 =?us-ascii?Q?eS51BJPTxbZvYp8QIwQaoP1LEPWs+4pAu2Ck+iYQPsr3fsqb20iiEsKHwYK0?=
 =?us-ascii?Q?r523f6uGBg+sSeEGAQMo8k+WceXFgR4iBuDPf8BOFSKJV1kCJvP8+n2wg8x1?=
 =?us-ascii?Q?/NeXT7RjNXkkxo0u5NI2hPEpwSF3hjuiOiDqpMFOKy50Mu51exUVwmZFIAF5?=
 =?us-ascii?Q?BjmO9cufYeevMHVKrlF81hYUbOYrrOAgpMqU7c1zX6hM1qd1Fdw1uxq1hVE2?=
 =?us-ascii?Q?T3aL7D+dySBkl0hncBOt8FwO7PFdiu5121xVeYQz9CUb1rnDp3l9bEYX1Pgi?=
 =?us-ascii?Q?cFbqpqWEIDdnzoPPlZJKvY2LZA/RSlh/2PGcol7BCJHtF04HzHZZjchYKln9?=
 =?us-ascii?Q?Pt5CAEzF0dEuoPySwCHzkNJhKQIfnmNqn7z4HPETXyIlNuRJP1/cTjRCTUTf?=
 =?us-ascii?Q?IfNIW76PGrdZMR/mWHBiK1+WNg0T1OhbhWfpwF7SWQIi2zBkY1DroGYLTCY4?=
 =?us-ascii?Q?qTyG1Z9lJ/6MM748cKZUZHdLrYU39rby+8enRcA65OOZI5UQfF6uY/fkfM3Z?=
 =?us-ascii?Q?7Q8jgFLLhnqi2Ggjeye8kWuzy+kv+C3iJly0kbZ3b793TwH42fxM/3auyaGF?=
 =?us-ascii?Q?AHO1Yzn4mf4EqbdzJTgtCiCHP7UQKmndhLGyLoWe1MM5L81GhRF9Kkrfi0iZ?=
 =?us-ascii?Q?h3dK3pcV7ErMieeMEklzZinMlOJi4s8PymP5UFoZt0kFozVCKTl6U2Su7Qd/?=
 =?us-ascii?Q?8uQ+Li/5ygDTERmH9ps0fue0b9W4gsQlYgJbacwNUQRPE+rFH+gib6QO0PGm?=
 =?us-ascii?Q?l6PawWldxXlqLskzd211HdrSZm3jRY4eswS+VFJnNDOZzNT5PP6Ws8EsyS2P?=
 =?us-ascii?Q?5HKyR5niQR5me0egWoX/ubkOcO7fxMicGxPE5C79v1CrGpHHaf33CoODyxKc?=
 =?us-ascii?Q?4TY4ZTVHVX67z/ZPlfveECmCgBwuNyQVhjr3w0/SpEYMFnCtRwl25IaO7Wjw?=
 =?us-ascii?Q?BVJ3CW2Lbs71T9Q9mjEKPqjHcIAdg4LzKtkYnibosfKyR+XwqPwF/VC3d3O8?=
 =?us-ascii?Q?jsM2eLroYe2loBCH5DIZZ+6dHYj2X+VhWyXFiIW1E8bT1sH//KtZuuckQqyv?=
 =?us-ascii?Q?gTNOb4Sef2IXGjx/Avkxn6gL0nfcG5R+zcPykeKLGQhRql8pjRD7LzidjjG8?=
 =?us-ascii?Q?I8nUEp50BG2jgHVDmQ/8jmsRzCtgZ3eZlR7UAiteVPTRKHpobaBE/6T2UiDe?=
 =?us-ascii?Q?qNJ1bwbcx4hu+Zb10qT7JcdRAqHDyVI6MiOcJeGsGUhVb8uj4OBscTFn3t8T?=
 =?us-ascii?Q?ge6+st32vNkvKJdJUObLv0WnMRPRNht9reLnrmSqBjknLABgaB//dgwDtXw5?=
 =?us-ascii?Q?WAEeLT89ilFboTiPnY7FeoI=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe8cfa58-e030-41bd-2e3e-08dd7702918d
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 01:05:07.3237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kObv+eoRCKGCJvcjz9tcQQoSbAQaZkOiX+bshh6Yxl4zFYqlTHsN/1vgnser0SiAnbl3nO/w0YLq6tnxBjbl36OCVrSA7lO0us00cTzlrVPMOtj1nRhId/ZnYUpi1RK4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6437

Renesas MSIOF (Clock-Synchronized Serial Interface with FIFO) can work as
both SPI and I2S. MSIOF-I2S will use Audio Graph Card/Card2 driver which
Of-Graph in DT.

MSIOF-SPI/I2S are using same DT compatible properties.
MSIOF-I2S         uses Of-Graph for Audio-Graph-Card/Card2,
MSIOF-SPI doesn't use  Of-Graph.

Check "port" node when driver probing

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/spi/spi-sh-msiof.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 8a98c313548e..51415131eff1 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -20,6 +20,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_graph.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/sh_dma.h>
@@ -1276,10 +1277,19 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	const struct sh_msiof_chipdata *chipdata;
 	struct sh_msiof_spi_info *info;
 	struct sh_msiof_spi_priv *p;
+	struct device_node *port;
 	unsigned long clksrc;
 	int i;
 	int ret;
 
+	/* Check whether MSIOF is used as I2S mode or SPI mode by checking "port" node */
+	port = of_graph_get_next_port(pdev->dev.of_node, NULL);
+	if (port) {
+		/* It was MSIOF-I2S */
+		of_node_put(port);
+		return -ENODEV;
+	}
+
 	chipdata = of_device_get_match_data(&pdev->dev);
 	if (chipdata) {
 		info = sh_msiof_spi_parse_dt(&pdev->dev);
-- 
2.43.0


