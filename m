Return-Path: <linux-spi+bounces-7588-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 834DDA89169
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 03:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD0EB189BFB9
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 01:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFF81547F2;
	Tue, 15 Apr 2025 01:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="dJBnvQu8"
X-Original-To: linux-spi@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011034.outbound.protection.outlook.com [52.101.125.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56221422AB;
	Tue, 15 Apr 2025 01:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744680894; cv=fail; b=Rgxdm0Jb+WlwuYi4TBdZC56icYAjE9KH7QGSSY4FHqSXkK1BpIfjIvFcy9eYpIb34J479MZnHzF29dwzNiYUiaah76/4+TxGv67orFTja8l5dgp7G+BEI92veYgeGGfQH+DgYwfO2TXCu2hH/j1BKNXCZ8hZf2UiqtPqq4JpBQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744680894; c=relaxed/simple;
	bh=Ca2YNWGju8OGU2xfGrIumQSce+2Kuiu1/fTOqp6rpJI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=FDHPK7nR5bOBghupvqVUjTH7SRY+/s/EYEDBYsWwss+ZwjXYjCXarBHqT1gvgRQV7vN9B/sbkTo8WBnBsBDw58swD13j0w36nM0W9b0eEYP0gQ9yhEc1WpBmac2nSK8/USq2AW549y0CPUBcF+08z727aR1lojPZX/jlm2iJc/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=dJBnvQu8; arc=fail smtp.client-ip=52.101.125.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q36O1xfa4APn5AH4muYbP3UycbNmfKbI3K5XP28ZCRHOvC56v4iDiOOaO/jToos47AUSvq1itNs8uZ48ryEWMU22FH3ZpOTtmbMBhil/893JlfuA9vBwkwF9RdyySzvuthDDkMTUi1MqAsEU1BshYdbnPsT8EuPpmwa+cgYsHf9zJG4epuOo7Yf+xrT2wB+nyzmN94KVRV4MJzvubIy3G7psQHyh3sy2s4wqhqN1Y3neC83WIK/5XLvfI6+/wUNBjmBGR6VEWN/9cdz3jA4TGwyd/PXuXT+20JYTtopGV257t079Mv5ifjuju1hE6cxloYWHKHn60QmYDo0aBHgGSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tk3PEbez9zQPxqLSXI9LRhLfntdXtPUebVhNFT8y/us=;
 b=p3rRmLt/r35YXWCs3ce7bY0FhtnNcPOYnf+05QCT4kDEV04D8cuqosmDBxyfl8OEJs3c7WB75DQ5u0dJdG/qREXp/EiFmO8tVq5+Jg3cmPZd7wkQ7pOYVxocfOVNYmYOh73y4h86IK10vw9q1MODF0ug7J/Q3JdgCtChZCUClzKc+Ramrs8EQnJzQ2VAwwfEZ3jRLy/IBUgQnVzpVi+B/KHQjQDh2sJWCLzBCTxoW4bO9Up0jQiN4KC+Q00GW0j5xLP6eKucT32rqeAdHQUFAbG0NF2okZ21E6lVTOuNUGJbROPf4YfiIZvWeUm0kE6xHcQjP/E5x2Bmtnq3BHRUMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tk3PEbez9zQPxqLSXI9LRhLfntdXtPUebVhNFT8y/us=;
 b=dJBnvQu8xc0lDwSstGncDhpI5h63z1YCqGwSAM0TTLNT68/4bq4Eyl0ApauoFueZmlo8Z1oab27W3UI0sg+u+f9O+b5bfezMvD9s+gzL7jfNjhgF2uiM4yfrymKAOK50DuE+DzE2z9LE6U8z5WD5TVrfrpu8+xCF9awFTLNcqUc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TY3PR01MB10906.jpnprd01.prod.outlook.com
 (2603:1096:400:3af::14) by OS3PR01MB7336.jpnprd01.prod.outlook.com
 (2603:1096:604:14a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.30; Tue, 15 Apr
 2025 01:34:46 +0000
Received: from TY3PR01MB10906.jpnprd01.prod.outlook.com
 ([fe80::592:9b7b:ef57:2dd8]) by TY3PR01MB10906.jpnprd01.prod.outlook.com
 ([fe80::592:9b7b:ef57:2dd8%6]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 01:34:46 +0000
Message-ID: <87lds21a2x.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v3 10/10] arm64: defconfig: add Renesas MSIOF sound support
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
Date: Tue, 15 Apr 2025 01:34:46 +0000
X-ClientProxiedBy: TY2PR0101CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::11) To TY3PR01MB10906.jpnprd01.prod.outlook.com
 (2603:1096:400:3af::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB10906:EE_|OS3PR01MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: c1f0a9ad-ccd6-431c-bdb1-08dd7bbdb495
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s1UQGsl8BBuw9xJH7sFbANt3AcndNKx+vhbbCK/GFRWADEiMzpSUegLnofWW?=
 =?us-ascii?Q?MWAU5dUxmgpwXvRkDLo6ROCWtH2D8t3goYaAleR2Nzh4zMNpkLliVph6glo5?=
 =?us-ascii?Q?2mZ7AWg8HKsu3eg6/Kg0sjgmKyvW5dWB//H+6P3OEqI4FUQnBtBbdBbApDtI?=
 =?us-ascii?Q?RMj6X5YHJPq3S95gTW14Gz2r7WWx/l3uJmmHw8fkmx1x+DMNVrsDsbE2IkXh?=
 =?us-ascii?Q?7Mj4+qR2qPfzV0nhjQCr6mvnjHCL2Fj/V+NL5UFGKNQP/F5PHWKE1uLuVx1S?=
 =?us-ascii?Q?G3AwQxFlh3hLDfx8U5ofqMPnYCVzrZRMwzeQWvbUuab/2HKcvFHSNBvs6O64?=
 =?us-ascii?Q?OAGhHCeYUs78VR6h4hvMTKSdbnv9RzWnh1J+GXhP5FLDTnaaWeJzsnIsS3km?=
 =?us-ascii?Q?GHpP7rJ5FoHeHO8JdWbrxVa3ABibWh2blwgagsOjLaR4pQSMXv0bKWygIYFx?=
 =?us-ascii?Q?lM47OnbXgtLd+oGpOXdBFH+G9U8CqYv8GIpeaxIOE4qaEj+KdHITjA/s+Ua7?=
 =?us-ascii?Q?wiRZcFJYJGynPCCyLzqLKhB+e6rcR7bAoFmjOR4eqF+YbWf1fMv+JHWAavxX?=
 =?us-ascii?Q?g5unwrmI7zNPFhpNGW8TMoGuRqfdajlBZEHElXEXVXh4SMdLCYjMWQFGR4Pf?=
 =?us-ascii?Q?Yg8bi82zmT6FDpq/4W7C+A1+vC5JMhwVMc90KVbuLlSFZej40Qt467OUnpBl?=
 =?us-ascii?Q?6bg2Z2Cv9gGi39z1Gi6VLz0ABh+xjQ0E3orYuhJCA23fyxBjS4wk1Bt3PHzO?=
 =?us-ascii?Q?Ptkx466r6tHl5Ms6OPPnTMG1SuRNsdEqeTxKhjH+OnFKt9tFbFOBBqTlek1z?=
 =?us-ascii?Q?9ADW2Zumg64WryrXpRvQaQBXb670E+IaNWbxHfO75vn5eJ5Wag3yC0U4UAq0?=
 =?us-ascii?Q?gJvqzMifTNeOmZ4KQ2c5BCb43KyfnKbqMNCBOSsg7glPl6OjmpGMgg+C6vNt?=
 =?us-ascii?Q?VRDkEKavj4IsVm9lfbNujpVPihTXY4qoxyLu1uF/au42Sj9poDxEWLe4Uv3o?=
 =?us-ascii?Q?26qTOAMMWmUZXTYCT5HB7F8wuKzjsVmaLh6g0xghQ+iHHLJXKtguJj97naJ1?=
 =?us-ascii?Q?g79OBqrDAyZ2WOPCILzk5fMO+rdyCQpVCbYZqK0wJHRUQd2vQhjJha0qKRPl?=
 =?us-ascii?Q?if/BZyxiHU1656aWrEOMXZ7u+Bw96YZtXuRcFiYRe3gpqjSpQgbWCKmoBvT0?=
 =?us-ascii?Q?A6QyvbIoAXCQhXPWqrcjOM1XaPMpN7PdqUJ8oVGAjtmKJIqwljsvvIhVvMjH?=
 =?us-ascii?Q?hfV6ywXfoUdivnMpyC2EpfRkiyc4ZLeJuz1KG7Xyh7eY7CPAPXOQ5GJBoDcJ?=
 =?us-ascii?Q?5a6OP6tBO9yWVQFUE9sCB7Tmc/kMpVf1sGTEfX/9X1rYcbKkGBwbXcgTX7X9?=
 =?us-ascii?Q?3ZQl4HwEKztaW0Feb8bBKre4AEH/xVbO6piq6xIuynJuf7yt3e9Hepioezf+?=
 =?us-ascii?Q?hCSNkgJRJ3/w0v3VFFR33LTUylUv3iqdCjJ8qKA+1CWhRNlYLyVQ8q+QaQnp?=
 =?us-ascii?Q?ms7YcUoFj/zbUkg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB10906.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QSl59IfanUpFSOBAPeLHYsaotAUmItaE+P77LZx5CLErUzDQFqYonjGAYmen?=
 =?us-ascii?Q?VFowIQcDwTqI6pvgFxzVUFM251LNyON0cMkpDhCvvgVU8DjsVPZMPS7NOADb?=
 =?us-ascii?Q?X9BcAFrV1FtY7FXY7xKUwPls/w1WQ5pYLW6QyyhypukIHNwdKQ+xJbe4ZXLz?=
 =?us-ascii?Q?E79ikWVilCw+WSFJgwMf10DHEytLKzW+WsmyQ1cHZ5nCvKDomQTaZznFQgQh?=
 =?us-ascii?Q?JrYCAqTp25AkfiK1wAraPzo+qsputmoeEV0z2aIGulZR7CacoeqRsXCHtj3u?=
 =?us-ascii?Q?GDgY0ZJYdUWyLbzyM4CXdQ82YATZez2TkjQGJgyf1XdPTIAAqNqc1CIpAMte?=
 =?us-ascii?Q?mEBC+pd6s89jA5hW6pnYqdjQt1QHt2D8p4zFCo8B48ix605Nn0nigrpqMqb0?=
 =?us-ascii?Q?eh62BnvZsenz1iFeT2jRu1yLxEVkILoVdVhT9NbcFCHynn1ZzUdYqGZjCMSt?=
 =?us-ascii?Q?B7Z7XWB2K5/A2/2NfYZyEL0tFthLWmnk482ytUUtt1A5yz/YqLDQDAEWs/Mx?=
 =?us-ascii?Q?Dt8u0tZy/CZDNQqhVxyeHkrWDB1V2PKTpJu3PGZF21Fp+ETKk69eRUjXEG/g?=
 =?us-ascii?Q?jDAmB2HV+jVXBWm1WCB0hd+SOgg6w2a0MSI1mWMi1foG6RXx15XVt9peg1Mv?=
 =?us-ascii?Q?bH7YfghklUl+ny7rHFTZUo0Sz6ceT3wkorBSIuMMLdxWL3iarS37RvbKQfO3?=
 =?us-ascii?Q?wCe8brpntaB8jYGRf3HW+KIGIfWfjnCfgOHsQOjLCB6KqV2wu0NJeFQJPIVS?=
 =?us-ascii?Q?pQCItjQhUV7OJgZl224TAhGU0DaGkXWsXEe9i/rWPX5WmyDsyIxGLLPY/N69?=
 =?us-ascii?Q?blOyM1XyiEfUYITICuQ/oTwSBvVa+ihI1fs3HQgyc9U32SRw36TAbN3peoqG?=
 =?us-ascii?Q?oeIWt/u1LvsVvl9K9O35ML1cm8aupIymEZFkDC4bRaF8YfC1ARLrr1Ao/coZ?=
 =?us-ascii?Q?6Zemvac/weOO963adFhxEvA2FVkCMLJPf3IpAc1nM5pYuZKPbanthZms8XJd?=
 =?us-ascii?Q?EM0laTa7hExDa6xFvV2pdQq3ceKTuKQt+Qyn4keIVka5C9SBEmRd9WXop6Sx?=
 =?us-ascii?Q?zcJuVB9gAC1pScYBSYoElTcHHYQ1cWHp4g5LCKIU2142FSpCn7xjWwfdrajL?=
 =?us-ascii?Q?Iwtc+BQYBCq5YO2/4HQbuBlffEcSKuxjc+Yj09vGWJ7TU0Qs4TEm70sDnGGa?=
 =?us-ascii?Q?IG95AAbh1iYeX3eV7NjQpRf41QzVJp5HCpXP/cek8fkg3ugioIn6TPYRD9vf?=
 =?us-ascii?Q?/e82ifmmS5d4omA6Yusv10NHBBAWm97hMlguYQ3vZwkwxpgUksyvpCv81Y6I?=
 =?us-ascii?Q?YXqPhZVKhh1OgLv6urR0xqtszUa2/LpOdFZJlCMx0hp8x4Gx5yAqTifVqZVh?=
 =?us-ascii?Q?5rq4xHmj5a9bhc2vgwTU20JiDAzhzM/b/T86rAyvbkRviSFs6wzVf1fgzMmz?=
 =?us-ascii?Q?Auv1puZUd8E+VCM/yufWT8EPjj8uWAuRwEgMGfHftflKOW+ziftHS5RuQJkx?=
 =?us-ascii?Q?RxCRZcousAYX0KvrGQuzb9EB1/hQVl4WcYDBodl0gBj1cljm+Pt+xJg9Qe/z?=
 =?us-ascii?Q?CSAK7poQtOy8tPmK6ISsftuH+y6SwzfWouaH0IffcSfta+avUTKgbv8rYDXw?=
 =?us-ascii?Q?kQ092cyF6cfzEmRON+PzdM8=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f0a9ad-ccd6-431c-bdb1-08dd7bbdb495
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB10906.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 01:34:46.7036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +NqATBufPtl173UruEPUMfNhoRZkasVUCkocb4Z4wgTr/lJDQpcAQvtJ04kCQ2QzDYr4Z6VRtzDXSaABaQS1V5CSw33nEuK+G2UldFYs3EOw3+qVh1lfPAwfiX8a2xGg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7336

Renesas V4H Sparrow Hawk board needs MSIOF Sound driver.
Support it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5bb8f09422a2..b74f5810e0e6 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1010,6 +1010,7 @@ CONFIG_SND_SOC_ROCKCHIP_RT5645=m
 CONFIG_SND_SOC_RK3399_GRU_SOUND=m
 CONFIG_SND_SOC_SAMSUNG=y
 CONFIG_SND_SOC_RCAR=m
+CONFIG_SND_SOC_MSIOF=m
 CONFIG_SND_SOC_RZ=m
 CONFIG_SND_SOC_SOF_TOPLEVEL=y
 CONFIG_SND_SOC_SOF_OF=y
-- 
2.43.0


