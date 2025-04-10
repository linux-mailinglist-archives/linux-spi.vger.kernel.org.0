Return-Path: <linux-spi+bounces-7511-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E55FA83A23
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 09:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A63594663C5
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 07:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7106F205512;
	Thu, 10 Apr 2025 07:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="Y/46yBa+"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010030.outbound.protection.outlook.com [52.101.228.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789A0204F61;
	Thu, 10 Apr 2025 07:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744268534; cv=fail; b=ZAFdAWD+NR3hOcLNR9Hcw9EOVnmI7fSo5wtJ0kiQfw0IgnvGWr231eg9U/3/4QXaCGchYe5UlFPVkOg3alS36Pp4xcM+MvDeEmL5b9N6w/yXW5p+/yys2CtSVEPj3PRLBP85UJngYze5Cn9/QVpGvCseqZiiMFeoJUjAOL93RPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744268534; c=relaxed/simple;
	bh=bK/iXxXdqsuKVsNwxS5MiUL1R07oXrw47Wuwwk3vs/A=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=jIBo9CLK1jBnGJWWm7gfO4vO62940m7/SAJxvQd4I/XYW5niCQuS08O9eOLKnxaU7FlsRzwpxZL/QQXjKPQjwBEHXFf6P9DfFYiClFxk66fKb9IZ14zMZpC8hH8dfbyup5MWhBll35dSVtadv3UTjHinNIL015zz8dIla8UXpk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=Y/46yBa+; arc=fail smtp.client-ip=52.101.228.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EAiF0x+6jXQTrt9VzSZWuyur2/Jr5mpFh+8hkZtwc5a1gWdjmV3MdU6N5g/HihDlx8CD91UYwFtuGcYpcDD3bO5ZGo7VYrPvHeBBbsr2xnV1qZiudcyoluSmRQeFnwRL8L+fDVl4kRIseECvUx+loL/mtvNAzAds3+Cs4fdmHDVys5uwzJaKgLE9+pDuw82FeT/QnJ73KdiJeckbM1aYFMnNhH8xEc+g5gO75QJnouYEGL+rdkgDUXqiPYyHMQ2wUaY6GcyePb/XTicda0C+xibEXuJViw45n3k+wiux2FUArG2mS2j0unMx/IsZmvOE6C3UkdQkx+Aon7vGlK61lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eaSWdQMvzuyJfwxXtnXd5dz3DS8RZqq1a5OsRE0wucA=;
 b=jR8ClHAmGc6JDQICkNyOa47qUBowsirqjCn7He0+quiEMdzS2Aruc14AyyG9HaECp9HDciYTjX12pVerWuvIQYIPohPEd6a3wVEKmMg8RkkGtneZR8DAmRp8ndEfrBGrUWJqpQ3VHUuXbdwUr4jgRDrSdhEGA84MgTHfw7CUT5+R7ZENrW+Xw82JVNqDlwHxFQ0q1+UnnDdMfeVzbck4ttzupTF0gDmdMgf/AQKUlvLaCM5fGUD5WWjaHtZtlH7LvVnXvwnh4lybpYLv/d45W67e2JHuXF+s1jTw7ZIEtAyoiYByJePIa6N7Vm7PA1uLIuSV6+2rHM/5u4i02J/Djw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eaSWdQMvzuyJfwxXtnXd5dz3DS8RZqq1a5OsRE0wucA=;
 b=Y/46yBa+fy7zShlo+A6dFk+dxMcEXn6F1F5rkYMuAt8oT7oq7KD/Enn1h23AU6Qi2GyvFg0klV20FZK5p9v1wt3Y4XJhd5xf88/MeeSge9jSk0u2BrFHnoWTROIzNbkjL5nOfgT0dDiuTm2dis5miO07RrXTtXcRe5876ic1vh4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYCPR01MB9523.jpnprd01.prod.outlook.com
 (2603:1096:400:193::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Thu, 10 Apr
 2025 07:02:03 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 07:02:03 +0000
Message-ID: <875xjclct1.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
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
Subject: Re: [PATCH 5/7] ASoC: renesas: add MSIOF sound Documentation
In-Reply-To: <6904e6b5-aa54-4874-a420-462f7225ff31@kernel.org>
References: <875xjeb0wu.wl-kuninori.morimoto.gx@renesas.com>
	<87y0wa9mb2.wl-kuninori.morimoto.gx@renesas.com>
	<bd15c145-c175-468d-a1ac-1ad157358aea@kernel.org>
	<20250409-mouse-of-eternal-warranty-5eafd2@shite>
	<87wmbslu18.wl-kuninori.morimoto.gx@renesas.com>
	<6904e6b5-aa54-4874-a420-462f7225ff31@kernel.org>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Thu, 10 Apr 2025 07:02:02 +0000
X-ClientProxiedBy: TYCP286CA0005.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::9) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYCPR01MB9523:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c732436-72f2-4105-c71a-08dd77fd98be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ptNM6fe5Gk6p59j0FU1ktal0GQbqB9EfANGPSoKpA8VERIC60zYJfQyJwJoG?=
 =?us-ascii?Q?ovVeiO+RjlRVCJuyNw/NuECeGJPC6nK+W1xz9iHjFYKhb9xXJ1vZaD01DJUp?=
 =?us-ascii?Q?pNloiNR/GFyLrxFMVIzgyhP7A1oLZXuEyinrMASpW6H05A4fP8MSZx/Su9Ca?=
 =?us-ascii?Q?zeyUKKF2/pXq6ob7bFuhCuu1Nn3/xs1dP5t53utD/bfmdZHmF+btrUYeON8i?=
 =?us-ascii?Q?cw1+k6zDktaEJdSF8w6uj4LpRiu6CJ/ak+gyJXXnK9f477wNEZMIkC3jbE+8?=
 =?us-ascii?Q?SMbX79Df8tweC+b9+Pyl50eHDwaNKBscjQuephBK7Mw9fcLM742dfCDEnGe1?=
 =?us-ascii?Q?Upjhklmc3z75dPa6vJBi4RxuBxhESD72+QEdRPAlj1v+tUei4CrQHK9i19ld?=
 =?us-ascii?Q?hrhLAjx6rnkzHGE7SiUuFCV7H3P8xFdO/S8zw0rJrKffPGKHdt7GKqEB7zIt?=
 =?us-ascii?Q?lSxlqW2qyq41O1BjRseS74hQmijLmuFWlsVK4vwl/I8OpHc98+3bOKBAWVjU?=
 =?us-ascii?Q?7C8iIbHqa0Ie7b1I92N/8cEWsOA+P02snjcgkJ5Po9fckfYyJkoXzIzSAtGY?=
 =?us-ascii?Q?cs3ii7MyRhAJ9KNtOkDjtpKrOzlRTrEfHulHisZJ0cs5egjqJvLApDjUTOpX?=
 =?us-ascii?Q?rSPC6tKCBUUGYdgF4a1+QPlIRnN4vnybPc9wXwbnYTOVCSSe8VmOlbWBdRJ0?=
 =?us-ascii?Q?tFi2ONcFshiVQl7Jhi06KD+DJ5r0yOGFrSvvORhl+krGKDZ5QeyGNCGp7pTY?=
 =?us-ascii?Q?WGDX431ottsr+dFc3GtFvIrSCaq+kG/LBT1fEhBV1VnFxgZQ6v2J5BxpOb/G?=
 =?us-ascii?Q?6LVTob4b0Qw1KSSdN+6EhYjD0yAVc8eN5A8cpDCCKsWZK++JGK4rnsgaFLT+?=
 =?us-ascii?Q?7HLhWxgMana+5CP1v6UrBsQh9uVoy7EoUIwPm4ao4ojTSAYFsRWnpOEBQDYH?=
 =?us-ascii?Q?IiArxDU0D+600nTJqeFQKvu5Xuoyle1zeH1w3vaonJOYfcV5fOHQFhWuoW5U?=
 =?us-ascii?Q?w7RB1drQTiYk3X9AgT5OGY2CBOeX5VCIzbiIx7Y8hjR5v8AJB3JBwkpnNL4+?=
 =?us-ascii?Q?n8kxSph7XsdgQrXrcI50t0hpUdBWLfX2QcpKf4XN4oCdLAriDfFJIQttb8CH?=
 =?us-ascii?Q?9x5VvOePPQjlChSGusPxlZCiPfNNMLsPJdT8DvmdLTPMPR+QIIgv7JmUtMKy?=
 =?us-ascii?Q?7a+ZNPxID5e3Y6XFTyGbmzKO93eXM5Yd4PogSSTHsGAEKsJ1gdoorN2WNswM?=
 =?us-ascii?Q?xLcm1oijchtVQ1Cjp46E4lXBJVXwc2TjayjgaNTXKY/ZPOn/XoL55rt26A0O?=
 =?us-ascii?Q?dnhv7wnyjiS/wsZbi1rbcTlWNsAGDkHr3v1tnxxhIep59HkSV19UUgq1UMKT?=
 =?us-ascii?Q?BCYrN4GaYZF27+8k8cxhebAjhvbs7X908PTUiQ2mpwnMWv9QY6JOuKhqsftG?=
 =?us-ascii?Q?M3tcsDMpxNpqbg10ApEgJDCbwRgOqOP7ntf+EvmE5bh98lfkmkycu/FG1RHU?=
 =?us-ascii?Q?Aw9cqnnyEcXAtkE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9uM1inBUddJEqW4VOME6F5RlgydvYhZqsBtFq+sXzQ100R8WWHLnXeE6SOB3?=
 =?us-ascii?Q?arldnNUSfH5Spw5VjsKunRdkPcy2edd1e/LVcSwDygedV7lPdoM8XU9jZ6El?=
 =?us-ascii?Q?O0zSMkco6418S/bOnKL9Jqj6y5K0QF04MEHzoOZ9SRL4q3kffSpJSB0X238f?=
 =?us-ascii?Q?9vxee8KhD2Z3PayQUjeLjXvjIw8ifAh3H0GiCniJ+yJj3M2NHMuOQmuq+N9R?=
 =?us-ascii?Q?dKEAXM61P6pq1tAnbWPSvBKdgzt1ZTxX+w/i8DkhbK5x+KNQD2otwLDXXfIo?=
 =?us-ascii?Q?lbYoWiVrNlNi/E7/Bo0zbxeUEWFEvLWLALIo/pg7qu/hNywLMeS4XoqNcbII?=
 =?us-ascii?Q?gc+Sv70x/p2NU+DhMzU3Rv++CcLndwi+xxZNnys5+qJE2eDh7oQLz8a3o4+c?=
 =?us-ascii?Q?jRHRvGzQrRJ1AIk5XG0iVaLScdYVkCdveZBEWUnIOCSPF7+N9JkY9+KPi5NW?=
 =?us-ascii?Q?WbHt++O9t2faKEpRURrhHgHagTRUwnWSTB9gN8NqkFmKgZxXf4NMI9QcYwYF?=
 =?us-ascii?Q?C+jxz9h8dBvOru/meZmEj9iMydth/JQ9LYSxH4V0F3fpsNaw9Fg3Vy8W3lC+?=
 =?us-ascii?Q?LXrrZPw6vt2mfuFodIXlfJ0QMu46q9xUyxiuClj3nLKp9O+qzNfJFdTtaEb4?=
 =?us-ascii?Q?z8mjYOj5+MvPed7Dz6/ADOs4sgtkdqXKaNbtwXUwrlwzk0grcrw9rQagSCmJ?=
 =?us-ascii?Q?0YcpR8tZcK+metFMS5SdPdAzxid4c7+A9Vqy57j/paarqJINDHzuWPy1d4zC?=
 =?us-ascii?Q?TgcBRNDdahDtfresDdNRsbfwC2+f7VlL450dpMeLyUlxyGdPhvAnmrMf+LuI?=
 =?us-ascii?Q?v/FUXIj5UQuMd1Fo+TlAfCnz9OfMLCvHyiXF9hO5gDcjUOMx17j7zxw9T++N?=
 =?us-ascii?Q?N/fxrOCYHHbGh+fejOoEDLf6pKBGmUWef5R1Pli1BQLu44AbgUrnloqzfInW?=
 =?us-ascii?Q?fTj75hEnxKQqqeLMiHKTE8I9ppuCTflGvBm9DxpbAknrrzvwxAlj7Bxc0yXl?=
 =?us-ascii?Q?c4gmIHdQxKttTw6nDWfAgJQmhGN994NbCc7EgMbxZe4/6yk6cRnbJUxiLrQj?=
 =?us-ascii?Q?EEiPe6bojpm8beCP71DbHy9X8bM2yytrXlF96gnDgHjx52jbShFyXHF96RPj?=
 =?us-ascii?Q?ZyFwlDsjUMVbOnPwiggC2QBIin4I10eQY41zomiCsOP0J2VpWUX+DRlUZQeu?=
 =?us-ascii?Q?SISRATdVYAzYsNZX4B1Tt7oBjYbBKAAM5SX+aT1xqgzHiCKRfIPHA8KDAYnN?=
 =?us-ascii?Q?+BU1TeKObs6wL2uRfSXRTuQ6v3iQSjTaWB3L1ARxWZKBjXMogQ5NhvJCLLzX?=
 =?us-ascii?Q?YGkLyzCtJcBBHNBM/7O8bnaqmyyYKghXRjPhbX3bskyfJhUsH9EYlU9uCIpC?=
 =?us-ascii?Q?kMcHln54UzHrMf2IILdnJbr9ps3Aghw6pgY90Zn1zx5C7qycK36OBP3ne6Ns?=
 =?us-ascii?Q?J0O+Sh7T8zzayoddfc698hqdsK7LMwCDaqDTTU3Fu2f1CxX2rwW4JSEeplYG?=
 =?us-ascii?Q?svbwlSbL8QxWI7EybSI1Ch3x1+34kDR7HL/aMBhzP9kBMLcoDIVCMGgWXqLB?=
 =?us-ascii?Q?tiK1QisddwBBfH5r0BI7JyaZlOezxWr8siV0S2PH+FF+tP9MQAWUHnfMZaFl?=
 =?us-ascii?Q?UtSPFT1d5J0XXDQp3JJt4ag=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c732436-72f2-4105-c71a-08dd77fd98be
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 07:02:03.1983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mC7TeKVHw+dSvC1rIykX02UnaHxjQg+tBXx12lIXbOJ30rLyg9b1HUDtxPuFlagM1v+tVDqlbIwHq9tvHYccr1H79Xl5Vfy4X1PawBTFsNMolv6wtBy5SB2ncheX9cFx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9523


Hi Krzysztof

> >>> where to fit it in the DT binding doc hierarchy?
> >>
> >> Does not matter, whatever fits better in overal picture/purpose of this
> >> device.
> > 
> > Can I put info like
> > linux/Documentation/devicetree/bindings/sound/renesas,msiof.txt
> 
> No. TXT bindings are not accepted. There is no benefit in this.

So, no MSIOF I2S info is allowed under
linux/Documentation/devicetree/bindings/sound/ ??

Thank you for your help !!

Best regards
---
Kuninori Morimoto

