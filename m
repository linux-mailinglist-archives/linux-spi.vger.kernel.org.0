Return-Path: <linux-spi+bounces-7544-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5F0A850E2
	for <lists+linux-spi@lfdr.de>; Fri, 11 Apr 2025 03:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6944719E6973
	for <lists+linux-spi@lfdr.de>; Fri, 11 Apr 2025 01:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930E2B652;
	Fri, 11 Apr 2025 01:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="dL0wME+S"
X-Original-To: linux-spi@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011026.outbound.protection.outlook.com [52.101.125.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF85A94F;
	Fri, 11 Apr 2025 01:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744333442; cv=fail; b=X2wDLPetsH8F7jw1fxPiks56o/8F37NrmESVXxWd6+F6LIcUelnUcF4sf5KC2LA141LVDNhcmWdur0S2yeaQWE6sX6mP0dvpsyCNqy7AtSqRFixwVyi8Py2cmvRPSqx6Kc8folGpfAIdPLHYBGYw8MUag2rgRhBzvGX/eECJ8wM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744333442; c=relaxed/simple;
	bh=goMkIFOp7aZYymkS62z8Y97bhDpLHOUNLtC2McP9itQ=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=JozSWH65+aAtoMh/tjboPcI53TVlh/z6yUR56ZH+Dv/r5x1jFNDOHrSPJFtlkDvkfbNGmeiGFD7BzBUjJQrxfa9svWISx9FDw3Jw3FVlLTY1i3d0p+GepBrXMlJJupoL27Odgn1ZVlvjvROq0VA5qiOXQi5xK/9aX1Vy8qOvuwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=dL0wME+S; arc=fail smtp.client-ip=52.101.125.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bPyphFvWQLW1Tj6ta0hmtkbIh52muo5xBSiTkSEnqxF7gTth6BMHFgaLZ17vfyUzTDSlAq558AWCxx6YOtxb/vuWXg5uyNbyNyNUCtg500lg86MQIRqSOILDlOm4gpRyt305SPl8infi3IqXQ207cV4icmrV8v+b1SxzJM39JP4G1pYYV9h8SO7shlQ1hvHxsHlxi0NXVRE+wY+pjs6w6aWFURev1yxwmFpea79Wy2n4WOwk3ECJ+OfCPQQ3ldOgziDuvW/bZ37gSf9w61G3SrCLFetZIy3P3pW/7L9sohOEYr4JDQd/d31Z6xhjxaxoGwIU1vFuBhVlfzZ9VcHedA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1Ws707O31ikjbNI5YDLaAW/g1rlSZihRbyXCLDbVNM=;
 b=CJbBToz1jhV7zZSw44aP89+4inBGsyeUKvDVAbJhVaSeNLH2AlJIC6l8XAa6COr4VPavaUXVVwCfOobwawSkl227zS9XyDNoJbgikio6d3vXA+IBFr7Gq9WJmr4LnLhhqOB8FhE8rOR+q4nXAf1lZfpQwe1VGOIanzxsqlgIpRNbdg9zyMeiu5YmT4zItUPEh6NtbdxXIWLPW7QA/OxWda0Ak2gV0Ej70FBSJTMl40PmBWiwrda3Uj0dk854Zs4Kdt3M3PBeaT4WqW6RsVYDe0wyMF3nM0NupKFBSGd+oumiC4jf6SI3qNU39hGQPukficc2aWwJ8DyaN6N8onNucQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1Ws707O31ikjbNI5YDLaAW/g1rlSZihRbyXCLDbVNM=;
 b=dL0wME+SCYgEQQENE1HgdnF8ul3Ck0uuyA6D8pT4dRGSM/kOQhTRrMNK+oUtC5knJCIJpv4aQpUSEtMf+Yep1z7JwinQ1AOvyrIhO1lpAPULIdX5wN1QxjO1JkaN6TgodShQdJbfM3VzjLQhpjI/W9i8qLex66jKEh1KQbw+tX0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TY7PR01MB13579.jpnprd01.prod.outlook.com
 (2603:1096:405:1ec::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Fri, 11 Apr
 2025 01:03:54 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8606.033; Fri, 11 Apr 2025
 01:03:54 +0000
Message-ID: <878qo7h5l2.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v2 6/9] ASoC: renesas: add MSIOF sound support
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
Date: Fri, 11 Apr 2025 01:03:53 +0000
X-ClientProxiedBy: TY2PR0101CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::22) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TY7PR01MB13579:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d161008-c1c7-4361-cc9f-08dd7894baa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O0AwsLms3YynqGfkh63NXKedvCrNH9L5JGCuC90J/dLXiPeWKTi59YEC4HsY?=
 =?us-ascii?Q?ekGiWVUQ7mKojYQr+8SjPqN41yWiP1kqUQW3fanHChuI5dunA6ZA4OnK94rd?=
 =?us-ascii?Q?D/dNeNRPPWSfqtAfAuYaGuGY07Al9sFmejadDMWyZbPjNgOmpkrb83NvWxu+?=
 =?us-ascii?Q?wYiyYTK4v74HUr+IKlTdoUVRJ+1AqreQGxp945vaOtjM+aN/HhKrw8e0Uesy?=
 =?us-ascii?Q?SwtSSK51AaWBULriTcLJF4ab5sQc68pu9ZRotiJifS9/3ZSHjPa9dj47b2hf?=
 =?us-ascii?Q?lLyu6kLHVmOKx3x9JMERhYYX0gFanMSGw5KO5JofqiahrwHlVLnPh2x8PXiX?=
 =?us-ascii?Q?B8wUh24Jl2UQOZ8d2Vp+khEjxp2Z9txIgkwbHrbmGIv5t3G2x8XW2DxExYZx?=
 =?us-ascii?Q?wQ76jxd9YE4SpC1ue8VaZr1Qzaj5gVU2iYkXfOpxAle2iaw17ZNztNRI0n94?=
 =?us-ascii?Q?6okaiyyrADPmpoBOiKgcb+7GcvWxhBZyTan1M83O61ioxK2/sk/OUeZGFfbW?=
 =?us-ascii?Q?GQdlFJ4tRCGTqMtrgy7t+d8OPbMO0fUNpTG0Y/4jmwfDdzU5c3YVxNZOErja?=
 =?us-ascii?Q?0fR5dnAsj+xn0bPgT9fHSw7cwJ/M4WfYV2n2PfG92NpIQKzBSP3s0W6neBHS?=
 =?us-ascii?Q?dlvVEWpBHKyPqFM2sVgmnWcOqSpfTL6wDtNxNy6tExgncU5J3L/d/ioOVPdD?=
 =?us-ascii?Q?pMY1na8kJQO+1Zv5+tBXrmLM27Bf8Z5RrCKXNFMkee+N9N7iegwSKi491J7g?=
 =?us-ascii?Q?Wp2SGE483p725HgOkQ8j0W2ZCgYylfY40LI9w7of8WvXzjncs0bldyvanMkL?=
 =?us-ascii?Q?YViz6Dqxn0DaZKMlp2KRshEP/rhoqXERY+8yDu3/pxyBinyndAxkG3iVa02N?=
 =?us-ascii?Q?LgRmr+6SwIPSN9jz15nM6bxua/vPwtuCjfsVhaeAC/iYWe8PfMbjP60xkFJp?=
 =?us-ascii?Q?7wb3XXH5E84+sZ+YrL3BlPSddQb+bzdvzX3WLPlIYmaHVNzXFdW7WpksvBlT?=
 =?us-ascii?Q?5adfwmg8oGm+gXu7OWHmZ1JwEO9O2kali9OMwMHfFa8CVgJG6Xspsdig43h9?=
 =?us-ascii?Q?7fRR578LHRGaEH48g509ErRGucSqQFDYd1RzC+eKU2mS/VjdGiwotqxrNoNk?=
 =?us-ascii?Q?LBwFYgx0VkMzxJiOo5kYv4kUZVSWgW9wF4jJmleQH5AQOJ9GkGITxLdQgqu/?=
 =?us-ascii?Q?Yz39p1f/w5yDt+mBPnQjizwX0vIy9cyQ/b7rOutAZ3gAWAeJT3m85a1JPNU5?=
 =?us-ascii?Q?x4PITZ+B6L8KIZtoJi8m50cnJv77hC7Sxlxy6eTZf1yPfqQGqPIuxp51YJhY?=
 =?us-ascii?Q?kcfa7Oyt0Q4bq7m85UEELGLGPWUaGWTSvMqjAorvmaE73SqqBZERYda45y24?=
 =?us-ascii?Q?TmNNODUbyfBxbEH4gmiL33bCpLqaocY52rFu4IXtVfomlO9/YHAibYPrNrv4?=
 =?us-ascii?Q?0cf6B8TvD0AKo7zroJUyU9LjHyOH85K/KwdjiY9aK16sljHOJmfFZYqvXiEH?=
 =?us-ascii?Q?Ps9eFpq7cA2b95Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iNZ2XH1+09L43ycmFqofi5qGNwU9XF2OowgM4YezMVkLQLeqcq57J+S7Qh6f?=
 =?us-ascii?Q?4b1Z+afBJtndLxIPzAxbP8H38P5HPSdjHyXtFRV1n13dHZ+vpsq800jGmAgi?=
 =?us-ascii?Q?jQuvssDXIPetmVfFYJEPD9Bbkafd6w1p067zIJeD9nPCGAwGDsYnQx+DUiY5?=
 =?us-ascii?Q?exKoDCMq2QhndHpNXDZjeRWBLvVy43uk7DDgf55DE4J5fBg+on0n1rdTl5J2?=
 =?us-ascii?Q?dbHtGkhWR+T31UdfkbVQJ5x0CnTVmodSad7oNfRGRx3L1zWXSRQUjET/O0Dl?=
 =?us-ascii?Q?FsN3XfY4aSvtva+YpqfAvQsAVI+q4obIReCjL3M/VBLya6Iqs+SycRiVp2ma?=
 =?us-ascii?Q?cSJQN126UKymR3gNGU/8BQCyqGpzbDeCw2SeU+z81kwN1Nj9luyy4r6G+0Rs?=
 =?us-ascii?Q?JN4Y8iPxnzOiArKNszKAEOf+mFos2tK8JqeDnwhNpqNJZ/jemvIDN4kSSGYS?=
 =?us-ascii?Q?yWukBSKVa4aB0n0/+ANfJqLshivWMdFJBXHSPAm3N75q62MJjq30yGJSo56T?=
 =?us-ascii?Q?XNdlLz1hQaw4REsbVZsJBOjASlzDVTtFIotR7gj7wI/i2T5HgJPFPkIlua1i?=
 =?us-ascii?Q?LqfeOAw+TbuNwRg9oS+iSmaEoNvrwzcUb2S3oUJlaGSdR8CkKt7k/KgA4peH?=
 =?us-ascii?Q?Pqnbu+KxGSIxZT1q0tcehcLUppFatW0zgMh6xmY/+QYxAnjPzkWJmcZ5w09e?=
 =?us-ascii?Q?ObP3W16NN8AcX8IU1d7gdLbI+fI08gKKsMpxADPvkwfRGi/V6zR02yKQXEQG?=
 =?us-ascii?Q?pVbM6+sdYSjWIYJKpr4gZCGohq0AiVdH9CoIDpPKv0VRekQVQqo/nmLbDr2X?=
 =?us-ascii?Q?0bZr36SF/WY1e1+EOBCN9bpiq3ajQ95ITzafpB/ejmoPkgrC8Ug/rCetxxf8?=
 =?us-ascii?Q?cGh4wHY/fwWuY+VXVrPLPVJ8SKbF9j2Hs1ZoLWjz2+0ek99wnhq6LzxhvFku?=
 =?us-ascii?Q?FbV+2eeaK2kTKjzkH63DB+ubD6XnwqgSKj+r2fDrGhdQRYyMhR2RWpxJB8+q?=
 =?us-ascii?Q?HEF14tGPt+e/OQomrdus8V/iv5IES2uY4Axm9IHt1ddVtq+wv/fhzIVi+h+/?=
 =?us-ascii?Q?p31DfPxM9xtH+20zlOOLUb9UXBNWFo5obe5o54aNefcP85jYXBsklL6x27iY?=
 =?us-ascii?Q?GJqJOUGS5TI1s8Hmc6X5Dwj+a/nrokMf+M+s5Ha2+SJpFnNeCXjSSdn2RW29?=
 =?us-ascii?Q?mEA1SyYEu4/4YwNoTE2sxws1yxQCaptmXh1C6+z31byKWwfxGHU/+6t9tQW1?=
 =?us-ascii?Q?OsWY35eStt/2l49D0XtmhBI3f0uAXjqAsnULtYkMDuJNPAxHJz+Ws1VNKbi2?=
 =?us-ascii?Q?2kKJJOCU4yquf5cU0QGP41J0giWYvN015taH7jEnbiL8AXP7+CylIiBGomcy?=
 =?us-ascii?Q?AIfWoyzMmMfCy6h2liY3F5vBm3G64PetknY1K3PPiz/4KYgVhcvEeTDVZVK0?=
 =?us-ascii?Q?OJul431TlO0TGmuNL4ZIsLUOYmT4ZztUNPaQVyIh3mo08SwkrPAA2gXPNOJw?=
 =?us-ascii?Q?BdzSQ1a9NR/sk+K2EOFos+a1s+JgO/LCjxYPsBLJd5MZTjYCZy2wtUdIWpIV?=
 =?us-ascii?Q?O8dfj7NP9pBEVFhSpIZfYCkFHn7exJPi4ho3agb6AR3GOpoaVWbCu2IhWqOU?=
 =?us-ascii?Q?WJA5mYOtd3FJCBvCwSaFxj0=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d161008-c1c7-4361-cc9f-08dd7894baa4
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 01:03:53.9792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8T8uo/wO+4WuBI/2vzYSjFGZQAiJZGg4FuGrqOJe0vRc2jqVqPPyjbGF1yrVX0M/14xrPFuK4oV/kLG8HTgvtwb3PsID9F6BPu5S09g4vXxZoY3rScSbVxq3KD6u44Ob
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13579

Renesas MSIOF (Clock-Synchronized Serial Interface with FIFO) can work as
both SPI and I2S. Adds MSIOF-I2S driver.

MSIOF-SPI/I2S are using same DT compatible properties.
MSIOF-I2S         uses Of-Graph for Audio-Graph-Card/Card2,
MSIOF-SPI doesn't use  Of-Graph.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/renesas/Kconfig       |   7 +
 sound/soc/renesas/rcar/Makefile |   3 +
 sound/soc/renesas/rcar/msiof.c  | 566 ++++++++++++++++++++++++++++++++
 3 files changed, 576 insertions(+)
 create mode 100644 sound/soc/renesas/rcar/msiof.c

diff --git a/sound/soc/renesas/Kconfig b/sound/soc/renesas/Kconfig
index cb01fb36355f..dabf02a955ca 100644
--- a/sound/soc/renesas/Kconfig
+++ b/sound/soc/renesas/Kconfig
@@ -46,6 +46,13 @@ config SND_SOC_RCAR
 	help
 	  This option enables R-Car SRU/SCU/SSIU/SSI sound support
 
+config SND_SOC_MSIOF
+	tristate "R-Car series MSIOF support"
+	depends on OF
+	select SND_DMAENGINE_PCM
+	help
+	  This option enables R-Car MSIOF sound support
+
 config SND_SOC_RZ
 	tristate "RZ/G2L series SSIF-2 support"
 	depends on ARCH_RZG2L || COMPILE_TEST
diff --git a/sound/soc/renesas/rcar/Makefile b/sound/soc/renesas/rcar/Makefile
index 45eb875a912a..3a2c875595bd 100644
--- a/sound/soc/renesas/rcar/Makefile
+++ b/sound/soc/renesas/rcar/Makefile
@@ -1,3 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 snd-soc-rcar-y		:= core.o gen.o dma.o adg.o ssi.o ssiu.o src.o ctu.o mix.o dvc.o cmd.o debugfs.o
 obj-$(CONFIG_SND_SOC_RCAR)	+= snd-soc-rcar.o
+
+snd-soc-msiof-y			:= msiof.o
+obj-$(CONFIG_SND_SOC_MSIOF)	+= snd-soc-msiof.o
diff --git a/sound/soc/renesas/rcar/msiof.c b/sound/soc/renesas/rcar/msiof.c
new file mode 100644
index 000000000000..3bdd10b6e103
--- /dev/null
+++ b/sound/soc/renesas/rcar/msiof.c
@@ -0,0 +1,566 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Renesas R-Car MSIOF (Clock-Synchronized Serial Interface with FIFO) I2S driver
+//
+// Copyright (C) 2025 Renesas Solutions Corp.
+// Author: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+//
+
+/*
+ * [NOTE]
+ *
+ * This driver doesn't support Clock/Frame Provider Mode
+ *
+ * Basically MSIOF is created for SPI, but we can use it as I2S (Sound), etc. Because of it, when
+ * we use it as I2S (Sound) with Provider Mode, we need to send dummy TX data even though it was
+ * used for RX. Because SPI HW needs TX Clock/Frame output for RX purpose.
+ * But it makes driver code complex in I2S (Sound).
+ *
+ * And when we use it as I2S (Sound) as Provider Mode, the clock source is [MSO clock] (= 133.33MHz)
+ * SoC internal clock. It is not for 48kHz/44.1kHz base clock. Thus the output/input will not be
+ * accurate sound.
+ *
+ * Because of these reasons, this driver doesn't support Clock/Frame Provider Mode. Use it as
+ * Clock/Frame Consumer Mode.
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_dma.h>
+#include <linux/of_graph.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <sound/dmaengine_pcm.h>
+#include <sound/soc.h>
+
+/* register */
+#define SITMDR1		0x00
+#define SITMDR2		0x04
+#define SITMDR3		0x08
+#define SIRMDR1		0x10
+#define SIRMDR2		0x14
+#define SIRMDR3		0x18
+#define SICTR		0x28
+#define SISTR		0x40
+#define SIIER		0x44
+#define SITFDR		0x50
+#define SIRFDR		0x60
+
+/* SITMDR1/ SIRMDR1 */
+#define PCON		(1 << 30)		/* Transfer Signal Connection */
+#define SYNCMD_LR	(3 << 28)		/* L/R mode */
+#define SYNCAC		(1 << 25)		/* Sync Polarity (Active-low) */
+#define DTDL_1		(1 << 20)		/* 1-clock-cycle delay */
+#define TXSTP		(1 <<  0)		/* Transmission/Reception Stop on FIFO */
+
+/* SITMDR2 and SIRMDR2 */
+#define BITLEN1(x)	(((x) - 1) << 24)	/* Data Size (8-32 bits) */
+#define GRP		(1 << 30)		/* Group count */
+
+/* SICTR */
+#define TEDG		(1 << 27)		/* Transmit Timing (1 = falling edge) */
+#define REDG		(1 << 26)		/* Receive  Timing (1 = rising  edge) */
+#define TXE		(1 <<  9)		/* Transmit Enable */
+#define RXE		(1 <<  8)		/* Receive Enable */
+
+/* SISTR */
+#define TFSERR		(1 << 21)		/* Transmit Frame Synchronization Error */
+#define TFOVF		(1 << 20)		/* Transmit FIFO Overflow */
+#define TFUDF		(1 << 19)		/* Transmit FIFO Underflow */
+#define RFSERR		(1 <<  5)		/* Receive Frame Synchronization Error */
+#define RFUDF		(1 <<  4)		/* Receive FIFO Underflow */
+#define RFOVF		(1 <<  3)		/* Receive FIFO Overflow */
+#define SISTR_ERR_TX	(TFSERR | TFOVF | TFUDF)
+#define SISTR_ERR_RX	(RFSERR | RFOVF | RFUDF)
+#define SISTR_ERR	(SISTR_ERR_TX | SISTR_ERR_RX)
+
+/* SIIER */
+#define TDMAE		(1 << 31)		/* Transmit Data DMA Transfer Req. Enable */
+#define TDREQE		(1 << 28)		/* Transmit Data Transfer Request Enable */
+#define RDMAE		(1 << 15)		/* Receive Data DMA Transfer Req. Enable */
+#define RDREQE		(1 << 12)		/* Receive Data Transfer Request Enable */
+
+/*
+ * The data on memory in 24bit case is located at <rigth> side
+ *	[  xxxxxx]
+ *	[  xxxxxx]
+ *	[  xxxxxx]
+ *
+ * HW assuming signal in 24bit case is located at <left> side
+ *	---+        +--------+
+ *	   +--------+        +--------+...
+ *	   [xxxxx  ][xxxxx  ][xxxxx  ]
+ *
+ * When we use 24bit data, it will be transferred via 32bit width via DMA,
+ * and MSIOF/DMA doesn't support data shift, we can't use 24bit data correctly.
+ * There is no such issue on 16/32bit data case.
+ */
+#define MSIOF_RATES	SNDRV_PCM_RATE_8000_192000
+#define MSIOF_FMTS	(SNDRV_PCM_FMTBIT_S16_LE |\
+			 SNDRV_PCM_FMTBIT_S32_LE)
+
+struct msiof_priv {
+	struct device *dev;
+	struct snd_pcm_substream *substream[SNDRV_PCM_STREAM_LAST + 1];
+	spinlock_t lock;
+	void __iomem *base;
+	resource_size_t phy_addr;
+
+	/* for error */
+	int err_syc[SNDRV_PCM_STREAM_LAST + 1];
+	int err_ovf[SNDRV_PCM_STREAM_LAST + 1];
+	int err_udf[SNDRV_PCM_STREAM_LAST + 1];
+
+	/* bit field */
+	u32 flags;
+#define MSIOF_FLAGS_NEED_DELAY		(1 << 0)
+};
+#define msiof_flag_has(priv, flag)	(priv->flags &  flag)
+#define msiof_flag_set(priv, flag)	(priv->flags |= flag)
+
+#define msiof_is_play(substream)	((substream)->stream == SNDRV_PCM_STREAM_PLAYBACK)
+#define msiof_read(priv, reg)		ioread32((priv)->base + reg)
+#define msiof_write(priv, reg, val)	iowrite32(val, (priv)->base + reg)
+#define msiof_status_clear(priv)	msiof_write(priv, SISTR, SISTR_ERR)
+
+static void msiof_update(struct msiof_priv *priv, u32 reg, u32 mask, u32 val)
+{
+	u32 old = msiof_read(priv, reg);
+	u32 new = (old & ~mask) | (val & mask);
+
+	if (old != new)
+		msiof_write(priv, reg, new);
+}
+
+static void msiof_update_and_wait(struct msiof_priv *priv, u32 reg, u32 mask, u32 val, u32 expect)
+{
+	u32 data;
+	int ret;
+
+	msiof_update(priv, reg, mask, val);
+
+	ret = readl_poll_timeout_atomic(priv->base + reg, data,
+					(data & mask) == expect, 1, 128);
+	if (ret)
+		dev_warn(priv->dev, "write timeout [0x%02x] 0x%08x / 0x%08x\n",
+			 reg, data, expect);
+}
+
+static int msiof_hw_start(struct snd_soc_component *component,
+			  struct snd_pcm_substream *substream, int cmd)
+{
+	struct msiof_priv *priv = snd_soc_component_get_drvdata(component);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int is_play = msiof_is_play(substream);
+	int width = snd_pcm_format_width(runtime->format);
+	u32 val;
+
+	/*
+	 * see
+	 *	[NOTE] on top of this driver
+	 */
+	/*
+	 * see
+	 *	Datasheet 109.3.6 [Transmit and Receive Procedures]
+	 *
+	 *	TX: Fig 109.14	- Fig 109.23
+	 *	RX: Fig 109.15
+	 */
+
+	/* reset errors */
+	priv->err_syc[substream->stream] =
+	priv->err_ovf[substream->stream] =
+	priv->err_udf[substream->stream] = 0;
+
+	/* SITMDRx */
+	if (is_play) {
+		val = PCON | SYNCMD_LR | SYNCAC | TXSTP;
+		if (msiof_flag_has(priv, MSIOF_FLAGS_NEED_DELAY))
+			val |= DTDL_1;
+
+		msiof_write(priv, SITMDR1, val);
+
+		val = BITLEN1(width);
+		msiof_write(priv, SITMDR2, val | GRP);
+		msiof_write(priv, SITMDR3, val);
+
+	}
+	/* SIRMDRx */
+	else {
+		val = SYNCMD_LR | SYNCAC;
+		if (msiof_flag_has(priv, MSIOF_FLAGS_NEED_DELAY))
+			val |= DTDL_1;
+
+		msiof_write(priv, SIRMDR1, val);
+
+		val = BITLEN1(width);
+		msiof_write(priv, SIRMDR2, val | GRP);
+		msiof_write(priv, SIRMDR3, val);
+	}
+
+	/* SIIER */
+	if (is_play)
+		val = TDREQE | TDMAE | SISTR_ERR_TX;
+	else
+		val = RDREQE | RDMAE | SISTR_ERR_RX;
+	msiof_update(priv, SIIER, val, val);
+
+	/* SICTR */
+	if (is_play)
+		val = TXE | TEDG;
+	else
+		val = RXE | REDG;
+	msiof_update_and_wait(priv, SICTR, val, val, val);
+
+	msiof_status_clear(priv);
+
+	/* Start DMAC */
+	snd_dmaengine_pcm_trigger(substream, cmd);
+
+	return 0;
+}
+
+static int msiof_hw_stop(struct snd_soc_component *component,
+			 struct snd_pcm_substream *substream, int cmd)
+{
+	struct msiof_priv *priv = snd_soc_component_get_drvdata(component);
+	struct device *dev = component->dev;
+	int is_play = msiof_is_play(substream);
+	u32 val;
+
+	/* SIIER */
+	if (is_play)
+		val = TDREQE | TDMAE | SISTR_ERR_TX;
+	else
+		val = RDREQE | RDMAE | SISTR_ERR_RX;
+	msiof_update(priv, SIIER, val, 0);
+
+	/* Stop DMAC */
+	snd_dmaengine_pcm_trigger(substream, cmd);
+
+	/* SICTR */
+	if (is_play)
+		val = TXE;
+	else
+		val = RXE;
+	msiof_update_and_wait(priv, SICTR, val, 0, 0);
+
+	/* indicate error status if exist */
+	if (priv->err_syc[substream->stream] ||
+	    priv->err_ovf[substream->stream] ||
+	    priv->err_udf[substream->stream])
+		dev_warn(dev, "FSERR(%s) = %d, FOVF = %d, FUDF = %d\n",
+			 snd_pcm_direction_name(substream->stream),
+			 priv->err_syc[substream->stream],
+			 priv->err_ovf[substream->stream],
+			 priv->err_udf[substream->stream]);
+
+	return 0;
+}
+
+static int msiof_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct msiof_priv *priv = snd_soc_dai_get_drvdata(dai);
+
+	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
+	/*
+	 * It supports Clock/Frame Consumer Mode only
+	 * see
+	 *	[NOTE] on top of this driver
+	 */
+	case SND_SOC_DAIFMT_BC_FC:
+		break;
+	/* others are error */
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	/* it supports NB_NF only */
+	case SND_SOC_DAIFMT_NB_NF:
+	default:
+		break;
+	/* others are error */
+	case SND_SOC_DAIFMT_NB_IF:
+	case SND_SOC_DAIFMT_IB_NF:
+	case SND_SOC_DAIFMT_IB_IF:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		msiof_flag_set(priv, MSIOF_FLAGS_NEED_DELAY);
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * Select below from Sound Card, not auto
+ *	SND_SOC_DAIFMT_CBC_CFC
+ *	SND_SOC_DAIFMT_CBP_CFP
+ */
+static const u64 msiof_dai_formats = SND_SOC_POSSIBLE_DAIFMT_I2S	|
+				     SND_SOC_POSSIBLE_DAIFMT_LEFT_J	|
+				     SND_SOC_POSSIBLE_DAIFMT_NB_NF;
+
+static const struct snd_soc_dai_ops msiof_dai_ops = {
+	.set_fmt			= msiof_dai_set_fmt,
+	.auto_selectable_formats	= &msiof_dai_formats,
+	.num_auto_selectable_formats	= 1,
+};
+
+static struct snd_soc_dai_driver msiof_dai_driver = {
+	.name = "msiof-dai",
+	.playback = {
+		.rates		= MSIOF_RATES,
+		.formats	= MSIOF_FMTS,
+		.channels_min	= 2,
+		.channels_max	= 2,
+	},
+	.capture = {
+		.rates		= MSIOF_RATES,
+		.formats	= MSIOF_FMTS,
+		.channels_min	= 2,
+		.channels_max	= 2,
+	},
+	.ops = &msiof_dai_ops,
+};
+
+static struct snd_pcm_hardware msiof_pcm_hardware = {
+	.info =	SNDRV_PCM_INFO_INTERLEAVED	|
+		SNDRV_PCM_INFO_MMAP		|
+		SNDRV_PCM_INFO_MMAP_VALID,
+	.buffer_bytes_max	= 64 * 1024,
+	.period_bytes_min	= 32,
+	.period_bytes_max	= 8192,
+	.periods_min		= 1,
+	.periods_max		= 32,
+	.fifo_size		= 64,
+};
+
+static int msiof_open(struct snd_soc_component *component,
+		      struct snd_pcm_substream *substream)
+{
+	struct device *dev = component->dev;
+	struct dma_chan *chan;
+	static const char * const dma_names[] = {"rx", "tx"};
+	int is_play = msiof_is_play(substream);
+	int ret;
+
+	chan = of_dma_request_slave_channel(dev->of_node, dma_names[is_play]);
+	if (IS_ERR(chan))
+		return PTR_ERR(chan);
+
+	ret = snd_dmaengine_pcm_open(substream, chan);
+	if (ret < 0)
+		goto open_err_dma;
+
+	snd_soc_set_runtime_hwparams(substream, &msiof_pcm_hardware);
+
+	ret = snd_pcm_hw_constraint_integer(substream->runtime, SNDRV_PCM_HW_PARAM_PERIODS);
+
+open_err_dma:
+	if (ret < 0)
+		dma_release_channel(chan);
+
+	return ret;
+}
+
+static int msiof_close(struct snd_soc_component *component,
+		       struct snd_pcm_substream *substream)
+{
+	return snd_dmaengine_pcm_close_release_chan(substream);
+}
+
+static snd_pcm_uframes_t msiof_pointer(struct snd_soc_component *component,
+				       struct snd_pcm_substream *substream)
+{
+	return snd_dmaengine_pcm_pointer(substream);
+}
+
+#define PREALLOC_BUFFER		(32 * 1024)
+#define PREALLOC_BUFFER_MAX	(32 * 1024)
+static int msiof_new(struct snd_soc_component *component,
+		     struct snd_soc_pcm_runtime *rtd)
+{
+	snd_pcm_set_managed_buffer_all(rtd->pcm, SNDRV_DMA_TYPE_DEV,
+				       rtd->card->snd_card->dev,
+				       PREALLOC_BUFFER, PREALLOC_BUFFER_MAX);
+	return 0;
+}
+
+static int msiof_trigger(struct snd_soc_component *component,
+			 struct snd_pcm_substream *substream, int cmd)
+{
+	struct device *dev = component->dev;
+	struct msiof_priv *priv = dev_get_drvdata(dev);
+	unsigned long flags;
+	int ret = -EINVAL;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		priv->substream[substream->stream] = substream;
+		fallthrough;
+	case SNDRV_PCM_TRIGGER_RESUME:
+		ret = msiof_hw_start(component, substream, cmd);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		priv->substream[substream->stream] = NULL;
+		fallthrough;
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		ret = msiof_hw_stop(component, substream, cmd);
+		break;
+	}
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return ret;
+}
+
+static int msiof_hw_params(struct snd_soc_component *component,
+			   struct snd_pcm_substream *substream,
+			   struct snd_pcm_hw_params *params)
+{
+	struct msiof_priv *priv = dev_get_drvdata(component->dev);
+	struct dma_chan *chan = snd_dmaengine_pcm_get_chan(substream);
+	struct dma_slave_config cfg = {};
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	ret = snd_hwparams_to_dma_slave_config(substream, params, &cfg);
+	if (ret < 0)
+		goto hw_params_out;
+
+	cfg.dst_addr = priv->phy_addr + SITFDR;
+	cfg.src_addr = priv->phy_addr + SIRFDR;
+
+	ret = dmaengine_slave_config(chan, &cfg);
+hw_params_out:
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return ret;
+}
+
+static const struct snd_soc_component_driver msiof_component_driver = {
+	.name		= "msiof",
+	.open		= msiof_open,
+	.close		= msiof_close,
+	.pointer	= msiof_pointer,
+	.pcm_construct	= msiof_new,
+	.trigger	= msiof_trigger,
+	.hw_params	= msiof_hw_params,
+};
+
+static irqreturn_t msiof_interrupt(int irq, void *data)
+{
+	struct msiof_priv *priv = data;
+	struct snd_pcm_substream *substream;
+	u32 sistr;
+
+	spin_lock(&priv->lock);
+
+	sistr = msiof_read(priv, SISTR);
+	msiof_status_clear(priv);
+
+	spin_unlock(&priv->lock);
+
+	/* overflow/underflow error */
+	substream = priv->substream[SNDRV_PCM_STREAM_PLAYBACK];
+	if (substream && (sistr & SISTR_ERR_TX)) {
+		// snd_pcm_stop_xrun(substream);
+		if (sistr & TFSERR)
+			priv->err_syc[SNDRV_PCM_STREAM_PLAYBACK]++;
+		if (sistr & TFOVF)
+			priv->err_ovf[SNDRV_PCM_STREAM_PLAYBACK]++;
+		if (sistr & TFUDF)
+			priv->err_udf[SNDRV_PCM_STREAM_PLAYBACK]++;
+	}
+
+	substream = priv->substream[SNDRV_PCM_STREAM_CAPTURE];
+	if (substream && (sistr & SISTR_ERR_RX)) {
+		// snd_pcm_stop_xrun(substream);
+		if (sistr & RFSERR)
+			priv->err_syc[SNDRV_PCM_STREAM_CAPTURE]++;
+		if (sistr & RFOVF)
+			priv->err_ovf[SNDRV_PCM_STREAM_CAPTURE]++;
+		if (sistr & RFUDF)
+			priv->err_udf[SNDRV_PCM_STREAM_CAPTURE]++;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int msiof_probe(struct platform_device *pdev)
+{
+	struct msiof_priv *priv;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	int irq, ret;
+
+	/* Check MSIOF as Sound mode or SPI mode */
+	struct device_node *port __free(device_node) = of_graph_get_next_port(dev->of_node, NULL);
+	if (!port)
+		return -ENODEV;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0)
+		return -ENODEV;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENODEV;
+
+	priv->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	ret = devm_request_irq(dev, irq, msiof_interrupt, 0, dev_name(dev), priv);
+	if (ret)
+		return ret;
+
+	priv->dev	= dev;
+	priv->phy_addr	= res->start;
+
+	spin_lock_init(&priv->lock);
+	platform_set_drvdata(pdev, priv);
+
+	devm_pm_runtime_enable(dev);
+
+	ret = devm_snd_soc_register_component(dev, &msiof_component_driver,
+					      &msiof_dai_driver, 1);
+
+	return ret;
+}
+
+static const struct of_device_id msiof_of_match[] = {
+	{ .compatible = "renesas,rcar-gen4-msiof", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, msiof_of_match);
+
+static struct platform_driver msiof_driver = {
+	.driver	= {
+		.name	= "msiof-pcm-audio",
+		.of_match_table = msiof_of_match,
+	},
+	.probe		= msiof_probe,
+};
+module_platform_driver(msiof_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Renesas R-Car MSIOF I2S audio driver");
+MODULE_AUTHOR("Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>");
-- 
2.43.0


