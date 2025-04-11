Return-Path: <linux-spi+bounces-7538-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E669A850D2
	for <lists+linux-spi@lfdr.de>; Fri, 11 Apr 2025 03:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F5B83B5831
	for <lists+linux-spi@lfdr.de>; Fri, 11 Apr 2025 01:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0C833062;
	Fri, 11 Apr 2025 01:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="UMUUcdkt"
X-Original-To: linux-spi@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011067.outbound.protection.outlook.com [52.101.125.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DD7A94F;
	Fri, 11 Apr 2025 01:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744333391; cv=fail; b=u+whaWXUHxpT7Y24Rjo+gxGFTMgKTGg20yVHkghRUl16qQqNleKIZA/nyRm7qxLsiK/U2p01mzEVKF5EYwrY7DBDm0uH2hIJj8uDQcqYcTt7uRkHSw9sglMqJS+zlBqs1SOxy4s8zZa1B86Lb0KLm2ZXnk3rN2BYWg/+SbWOw8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744333391; c=relaxed/simple;
	bh=HNBxaHDWqJ+H8CjKUCKZtJySh/eP/rkzE4gF5FS+MNs=;
	h=Message-ID:To:From:Subject:Content-Type:Date:MIME-Version; b=AjuzNe0nFwOrGg+0cgsc+SB0haljviPrNOqMv1Dt++WeEZ79Am1lXzaxZpUof3m8mAC0RKrffDCGt398Kki0/gh2JS4xlGuhxRxmKvMP5ADrBD0zw3rK19w9tSO03vColr/LmSJrsicmfb/ARxwOYNf3WtDr+rnuD9wBcXPO8oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=UMUUcdkt; arc=fail smtp.client-ip=52.101.125.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XBetZbqt0OkWphie8+FCH4olWDwRdtrAUoNkI8vQ8eI5J5d0sT8QaWcc8wrENF9UEogcxwUfYphiQC/tvnYn7OZGFMqHaB0yZNYmXOj3eyRLeR+yPuZlG7n13bS62PkRXo0kevnZR19Y5J0dacBp6T6omKGRfauCuzi/eHc7+eOmJiGTo1WhjZPsZ5kNCxRpUYUmyXgV1vlvHrsPyUh6GJxrPxm9HCglAYMewtYw3b8d+XV5zPF97teeSo5pG/FA1Q4yntIR1UNzGzNK8cpHFbjgWuStuH2BfuIkr2v2/ZTEw8Z2IG49rTpzj2yHMB1NSv1LYJYH/Y2I4ypEki4kaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vjesXQBh8R/ThLKGfYiyHjjnm5FUwOAIsut+SbJ7DE=;
 b=eHd73mEtz1uTl6Aw1l+dXiRxAlvgidVrz3QbSXT3raAjNoOmw58QRDHxgFteuzq+ODPeWJhrem/4sBZVoNOxLcxjxHxiCVuxuRe7Gg3K2HltGRc5YXOt8C7GFt4UVI7qrGoyGKjKvRzwgbGSDhyR9DzytZaXtRnmEHceNXEHUqFMKow2iFHZ5VgKruuK18h1wVUzOT08GHGV8wdon+iPhr8xnwtW/zCaqlYSe9ASVTGlfun9r/yuvozOuMPfPHslOT+cpFziEFG+umK6ewUgFS3Ve26ArSf3IwTyjhHUpewZ2rARw9xAqxWAAXF/ZjxE86+2NuijRTWH6Ya7fgfOGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vjesXQBh8R/ThLKGfYiyHjjnm5FUwOAIsut+SbJ7DE=;
 b=UMUUcdktiXiUPLqeRcvWaMXvck/hqRbPM8jAT2liJzvWYW+fDPgb8u1W3BzwgaH8GBanjYlnMpbOsrrKwhcSJBsQmgTbOplmE8dC0raM/uEXVe8JSXw2UmuPElSh+YxVdlh6gt6WQoSAVruFhgfpWRDZ9vN7A9fxFKLZkXPNrEs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TY7PR01MB13579.jpnprd01.prod.outlook.com
 (2603:1096:405:1ec::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Fri, 11 Apr
 2025 01:03:01 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8606.033; Fri, 11 Apr 2025
 01:03:01 +0000
Message-ID: <87h62vh5mj.wl-kuninori.morimoto.gx@renesas.com>
To: Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Jaroslav Kysela <perex@perex.cz>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v2 0/9] ASoC: add Renesas MSIOF sound driver
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Fri, 11 Apr 2025 01:03:01 +0000
X-ClientProxiedBy: TYAPR01CA0053.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::17) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TY7PR01MB13579:EE_
X-MS-Office365-Filtering-Correlation-Id: b4b7c29e-206c-457f-7bef-08dd78949b3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U8ZjwfvluiK4aonYfjGxkQ31oHpAKBd0YlJbKNO/MiLuAzhtRNGnOMb4iztu?=
 =?us-ascii?Q?Qq13Hci+9axRfVIcR4Jtf4FWK3048lpO8EJsG9ccDRMhRGbmCYHoc3xoNaOD?=
 =?us-ascii?Q?8TqZLMsmtE95NJuXco8HVTuL9SahP94BrghMCzqNxZL5DxXs9SXWHjeYnzrJ?=
 =?us-ascii?Q?REvz/qNpNu1M4ZbRK94fr+5PUoPpTjVy7kXKHjUewsCD4pbjkUUjeT9CvTcl?=
 =?us-ascii?Q?JfceqeUB5+DXCDpRFIduO6WItEKrbDLCXE9DRwOngGdoxX5+ThjOtp8KjERn?=
 =?us-ascii?Q?rImOtFY8l5RDfl1u7bfRkK3msXb1Gxls9abgpyXvi7jkQfKRw3QdDu0tywKb?=
 =?us-ascii?Q?TsScdGCbPHpJ/K+ECaYP4pqBrP8D/iBwro9tByvto2nt1n4TX9LDK5jiYyqc?=
 =?us-ascii?Q?cHeUUO9s0HACexvJpXbDAsJItzu1KPc1suJbEkU0ra0HWAaer5gH9wMzcx7e?=
 =?us-ascii?Q?2fSyufqnduaD65UCEbX6Htu8NLUaB9SCXtk8/gI03fPB8I6xaqAnDcMXhCa2?=
 =?us-ascii?Q?UVMow5Tyo2+BimT5TsuwUnitYQgIO/jnXSC6fA+gNDv24qg/u8htchGZKnFF?=
 =?us-ascii?Q?fZBeH0VSvwvHNz7/2XM8MMIWo6VxWQc9RMyWGsbBgYizXYLkentf0lYNYWS1?=
 =?us-ascii?Q?sFng1bVbX4pbYlEgu9mqtL4iqvroA4mLjui5THqfSiY9b2HaKm4ME/Ta5tkC?=
 =?us-ascii?Q?+KL2SEqLcKjaUgM3Be20kpe89IAdA6zhdR3NVWHN7I3X446hh/zUAP88QfrA?=
 =?us-ascii?Q?yXk+xABr9AwaN5XhjDDx7rSpGsXF0Xvq47FdJA69KLbbGojlO5Cko2915UPI?=
 =?us-ascii?Q?O6bsyVPZLAja2kvLwnAYrZCt6CsAwubepMChl9Cl57ocea06BFozAUxsccot?=
 =?us-ascii?Q?IyI7vQqzNPoopdjarA2GY5w/vbUxiPhoOyhUVyTSANuBi0qEGRQO1k48o4Xk?=
 =?us-ascii?Q?ftH7K7JQRp+Jj0AgUHkwqh2YvuOJuL6s8N1LgnEdUladGj7NU5coV03NUT/j?=
 =?us-ascii?Q?WFYUfkP1Lc6dO/b0ZBYJ6Ryw2ZWG3Sy0gYG+z8ixX3ztBOOwTWt0yA2ioa1Q?=
 =?us-ascii?Q?WXiYw0dfKhVwZunnlezjMf+JaTrc+xexMOeZQRddlqllETv66IjBMbjoRGOT?=
 =?us-ascii?Q?T57HU95UBT+27PwMVrtRuZH5cY/Q99Dcd2Hfm10PvAcSGGawZZsMZexvbZKO?=
 =?us-ascii?Q?O2gxMleTWEpFeCMZZH1vDH1jpfCcwC6dg5J5qEO4GDATx8CCaO/dq5V0bTkS?=
 =?us-ascii?Q?AkkxSdVZwh6ZJuNMchzd3nIgEB0J97r4GdYIB/joQwD3ycxaWcAw/bUgttzd?=
 =?us-ascii?Q?rYHVGMsr//CZpoAvT6emRFz4Xqj1zsCX1J463KdbDwvHyBwLCBe/Eoxg6t7A?=
 =?us-ascii?Q?tE1LSOOcha0eOD9EU1h+FfFQQ0N9QTBk7W2R4dyWK7mwmDPvZqsugPzuVhCk?=
 =?us-ascii?Q?B5mpyMfQxQ/XOVC4wDx99eYR1o7pGxRQ4/D50mc8jJVJ5tZ84t3zjo+sH2hj?=
 =?us-ascii?Q?CtFqgPtRXCaNDoc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T5/TZGRrA+FDMPwlt/28bZU8ftcrDj8u6pwCb4KvCAUSHimWcSV8EQEm7Fn8?=
 =?us-ascii?Q?WnXAOCksxQx+frbnpHl0nPzMLPtX5axoqX06OZqhuowPsaplV663SCLCmBa8?=
 =?us-ascii?Q?IcpuBQYuIiUazBdPVUc7qhf6PPYN1RBd8/IWUGSEDGjoi1BJ3QJ76JTJdgjP?=
 =?us-ascii?Q?Fh6uJtp6M5JMbbfDdJDu0rXiK3AsC+3HVTdVbfo2slzpI3x4NMHFqJSUtgBg?=
 =?us-ascii?Q?ZTjcFUXZwK/kd8CsAaX4iDOuHynoxad7KNoYj+EN5wpYDEz8PlcE3sMTeJh8?=
 =?us-ascii?Q?+oC+vSZ3/Il/PPWgBlxqngGeulZCYsVMzUCkZ6hQ9I7ciHROr3OCSibjTUDE?=
 =?us-ascii?Q?pyV7LaRMpATP091kZR3ynG68lnOXd92MVvnlVyyCa8TgHFhVoGNh/GfrwcfM?=
 =?us-ascii?Q?3VRZZyEywGGMjTbzm2sd3IF5LDbKp/6xvOLK0NT5bJFOaOj9gA0b8c8M+P+n?=
 =?us-ascii?Q?aucKT7jEMiqhY9ztm0PYmGYHr0a0PK1jmGsb6vS9rO0MKL8wPWfyrEsqMBNU?=
 =?us-ascii?Q?h+g49K0QycPcw5lHx+ZndOPtMxVnY1f8ithbc/boUkE+ImfbcZE2eypjXJUz?=
 =?us-ascii?Q?y1/5JCIDu0FOy1/JlTFKvgwM09yFjsWJZrUcQLM/XA9W+NYfhC6hY47X62Th?=
 =?us-ascii?Q?+ndsyHwjLvVU4yhwjmQDf1qRKP5aGRUDUlTKtAL+g7kTF+ns/DptAWffz2sQ?=
 =?us-ascii?Q?Wd4QYO5dve3jErWTfw/VD/hbmyyqSnoP7g3yPagN5IcisEqe0FYmJNCAQQTR?=
 =?us-ascii?Q?+hHphSr7AkWxpoQ8gKgvmFort2LPlOsVmjJuYAkDeCrEt+7temZHWi+aGIxB?=
 =?us-ascii?Q?lV5kcXx5dhg2WgEvQHqq4inbD/XH29nX7pOzU4oMjZqWDYzelybmM98VJP5s?=
 =?us-ascii?Q?lUG36N9VHqN71i8snlM8WMKpahoLqF1zko1zWirXkPZTXmHGgkmpE8dvkd+b?=
 =?us-ascii?Q?Pnddr7wKA82oPIohHKnr32db/CRWSCyYajRfcMizP1e6wIGpDMU4WvAiq8T3?=
 =?us-ascii?Q?AONV7oSu5hTM+mjwFNcWVRd4cjzUqsSUIgTyftdR9xX0HtCsie07EYUlOHnW?=
 =?us-ascii?Q?d2RFNtgfjH+qMY6FFHX3I72zAuOLSDEl9IokjZ07NEyEDA71nXf/UQl5d79/?=
 =?us-ascii?Q?4URZH28kaJCk/feFeMt++DVscKuLdr3PB6PTnAwv16X0AkJCThj3PsnS8MWD?=
 =?us-ascii?Q?GpSRU1pE5623DdhFodrjE6U9++j9F87Fw5YQL5F5LiFcYuCi08PCMwLAwhzz?=
 =?us-ascii?Q?8FUiXehs6a6aR66seb/VNB8Cfz0MPLu26TuNl9wX6iHHJVz8u/FHzQLWsI/s?=
 =?us-ascii?Q?KWnMZhIbcKkyBKvtG+JxL3OdRuiGhy5JdMgoqV7gmQhM2czXaMD+oiST/Qmx?=
 =?us-ascii?Q?Lq0NB49IdC1tFGPKStZc8bmnlRcPKA7W/Mw/UIsUTx7sYLqG7W3kyS6k+xXv?=
 =?us-ascii?Q?qOmAWhDkfq8ecoDNQRGACH2y8JByP57EX9QstH6BrZ5k8rf3g8lrhDHPR7m9?=
 =?us-ascii?Q?g3Psz5CRClICeCaa8/FNiQ4yqNQo/Rji+9Mh5D79ygXB3fHAuN2oBip6c7w1?=
 =?us-ascii?Q?WW+Uci+P13H6eMm8/3+pGnuONY7xPTQ5kXqd0xudwQCZzMzjDNHI3dlLYb5N?=
 =?us-ascii?Q?0eBfuJld9h+OVQlqlEOdtGE=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b7c29e-206c-457f-7bef-08dd78949b3c
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 01:03:01.3499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UYzh0meMlgLYjND8t8PZpiNDnzsKDNWAh1ffu8siTJcUh3kQCHcwkCukA35jOBNruxW6qHOYlDFlmFH7t7G8FjxXHft1A45EN6xseu6qX97Kxjo0FGyFjix6cK+ZyMah
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13579


Hi Mark, Rob, Krzysztof
Cc Geert

Renesas MSIOF can work as both SPI and I2S.
Current Linux supports MSIOF-SPI. This patch-set adds new MSIOF-I2S.

Because it is using same HW-IP, we want to share same compatible for both
MSIOF-SPI/I2S case. MSIOF-I2S (Sound) will use Audio-Graph-Card/Card2 which
uses Of-Graph, but  MSIOF-SPI is not use Of-Graph.
So, this patch-set assumes it was used as MSIOF-I2S if DT is using Of-Graph,
otherwise, it is MSIOF-SPI (This assumption will works if SPI *never*
use Of-Graph in the future).

Link: https://lore.kernel.org/r/875xjeb0wu.wl-kuninori.morimoto.gx@renesas.com

v1 -> v2
	- Merge I2S DT bindings into SPI DT
	- add "dt-bindings: " in Subject ([1/9])
	- use dev instead of pdev->dev ([2/9])
	- use __free() ([3/9])
	- Add Geert's Reviewed-by ([3/9])
	- Tidyup top NOTE ([6/9])
	- Remove unused defines ([6/9])
	- remove "probed" ([6/9])
	- remove MODULE_ALIAS([6/9])
	- rename "spi" to "serial-engine" ([7/9])
	- add MSIOF on defconfig ([9/9])

Kuninori Morimoto (9):
  dt-bindings: renesas,sh-msiof: Add MSIOF I2S Sound support
  spi: sh-msiof: use dev in sh_msiof_spi_probe()
  spi: sh-msiof: ignore driver probing if it was MSIOF Sound
  ASoC: renesas: rsnd: allow to use ADG only
  ASoC: renesas: rsnd: enable to use "adg" clock
  ASoC: renesas: add MSIOF sound support
  arm64: dts: renesas: r8a779g0: tidyup MSIOF node name
  arm64: dts: renesas: sparrow hawk: Add MSIOF Sound support
  arm64: defconfig: add Renesas MSIOF sound support

 .../bindings/spi/renesas,sh-msiof.yaml        |  23 +-
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi     |  12 +-
 .../dts/renesas/r8a779g3-sparrow-hawk.dts     |  98 +++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/spi/spi-sh-msiof.c                    |  42 +-
 sound/soc/renesas/Kconfig                     |   7 +
 sound/soc/renesas/rcar/Makefile               |   3 +
 sound/soc/renesas/rcar/adg.c                  |  44 +-
 sound/soc/renesas/rcar/core.c                 |   7 +-
 sound/soc/renesas/rcar/msiof.c                | 566 ++++++++++++++++++
 10 files changed, 761 insertions(+), 42 deletions(-)
 create mode 100644 sound/soc/renesas/rcar/msiof.c

-- 
2.43.0


