Return-Path: <linux-spi+bounces-8382-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EDAAD1633
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 02:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6460188AD3A
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 00:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DF720EB;
	Mon,  9 Jun 2025 00:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="PoDhGYk2"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011027.outbound.protection.outlook.com [40.107.74.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A2817D2;
	Mon,  9 Jun 2025 00:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749427346; cv=fail; b=qAG8XWzfX2uqehoK5Nh4BBytGDJESTDhI39imEe8pW4YQr8Fy6zMcBh7T2RIQjCeB+iUt0FbR91juTZq7fzpvr9dwpQji3EhB89Uwt6l4oQ5TIwR+vl7Ft3tg4zEEDhRMA+iOwYsek8rWZfTJvvtwVij0ZU6TzNzr+5Tuk5BgpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749427346; c=relaxed/simple;
	bh=Lsjw0Dfctxvri+i2+mXXQKtQv34wfiT3triXIzwCQ7s=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=SB0zwc0O7TR8s1Ijtu1M2exa54bFbbIAFbq3ME6nvXi8/73t1pc71s3YfrPBdRAKj72Pfgj8r3dtW0WrKUZOvYtblzApPEwpdujraP/e0DIvssemJ2MGIXvuJZsEpCfwOUKhOjQ8ktnarEfgVSAzIlu9oDGy3RboMNUV0GqYcWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=PoDhGYk2; arc=fail smtp.client-ip=40.107.74.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YTTYV5rD3ZGVB4Ycalsv1GYnIatq40EvGF/okve8lQa4N89cc/UydpLHMQGruO9QUMN2XYWY3K7MdWEuvoZr6YBxqm8LkFP2T74xJsHs6GYYvS/GDcd8biaNidHpcoV61DQlhpc8XMns5kNZMj0Aq+mbCvuiHtxXQYfSx6qMowY5IzcF4XuoFQ9gQeeOcSLvIjbZ3jAPgTvwEklplJd+YsQGytqj3oy95xAfvpGak9BozuzWIhCPNEh6NPlW79zhBTF/39/KsVGArvh4+gZq01Mcac73QbvvXN8Drjw0t+JFfW/lOYTz6/KtJpQI8zmOUjSOYRJtdA2dH/7vcwDx3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FMs/lJIMzXjxjRbN5FIBlxlpqMi7bghFfk6kBKRX18=;
 b=TqJ5kck2qhTsOcXV4ygOs2yGxQyzuAZKxOUrbbq5ioSXU1R6Qq6VC07HEJNgDx7cJ8yMXZZTLugP4FAlT7TPLG8orbULKqfzfLa49jMyfaq/w6A2jFTtRPltvwLMJf/f6dOItcgmA6sCH9WiNBcbKBifr7IMovgdNWjQWDaz+52IPnnQFOz7PrU1gZ0/ayW2q8oCyyOrhbQgpVWXXlm/LHTVTlj44PeF0cgfI002BrVq8rSG2VgGqCSGCqJWfN4IHu4l0NATrWWmuDQx+oyPetN35kzvhKRYtoETN0f5zCBy6agq8Hykm/o4linQfi1rk265Zqjjn8GSQVGarVu9CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FMs/lJIMzXjxjRbN5FIBlxlpqMi7bghFfk6kBKRX18=;
 b=PoDhGYk2mHnRJJk6vONmO2U82xL/0zCwFI/htivCgPbUyJPWUUhZjJeba2r/F1PzvzVlqgFLF2LVs8rFL05hJ+7tBXdlXFuAYCSj1601H4NiesIYdfh30eB+kLVyPMuzIRU0WI+fMLkr0fIk4XYaeDpPO+41Hl8K9+BedOZGKPY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYWPR01MB8840.jpnprd01.prod.outlook.com
 (2603:1096:400:16b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Mon, 9 Jun
 2025 00:02:18 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%6]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 00:02:18 +0000
Message-ID: <871prt4wae.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Mark Brown <broonie@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Koji Matsuoka <koji.matsuoka.xm@renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-spi@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 22/22] ASoC: renesas: msiof: Convert to <linux/spi/sh_msiof.h>
In-Reply-To: <63d43d81-afce-4dfd-9be2-ec2ca2bda8ab@sirena.org.uk>
References: <cover.1747401908.git.geert+renesas@glider.be>
	<754ed54057e54effd06143e71d6cd305c3334eca.1747401908.git.geert+renesas@glider.be>
	<63d43d81-afce-4dfd-9be2-ec2ca2bda8ab@sirena.org.uk>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Mon, 9 Jun 2025 00:02:18 +0000
X-ClientProxiedBy: TYCP301CA0053.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::20) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYWPR01MB8840:EE_
X-MS-Office365-Filtering-Correlation-Id: a9d7f7d4-e49f-4e57-b2e3-08dda6e8e637
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DH3qSKapsPOVxt+NGzbj8nPhGhtOscRxC7/hSrelxtQhCTFvMA1FydxC8t+y?=
 =?us-ascii?Q?9J6fGkDSIIEncfwxZu62GAdVUqKiLmZgt0hRDBe1oPkL7MlMvrFVJL80umnC?=
 =?us-ascii?Q?Cyf+6SPHzNefY7iFdH5Ymw4UvTi1IGl72VHNVrkpZY8EEkPIeVgAFAd9Txxh?=
 =?us-ascii?Q?zDT/WFSa5vUoHI3BSQJAuXRbiCj6uAuawtccMo3vLIipeQflXRhIANlWU4oj?=
 =?us-ascii?Q?AwXMXsqPfJz1m4cryIIcFsBbimRdUUIkawicGovOZ0PJaMK8+QHMW858wRhr?=
 =?us-ascii?Q?Wj/hmPKsFyW5+nGHoxXlf/dnLqcZUq3HEv7woqmMMBlJyqag46KkOTUBtM5t?=
 =?us-ascii?Q?gd+2HiFgl5Gn0+sAwVQ0BOV5GqEIXwZhi7BFo+9XQUyBmsa3NM7THn9xjRe+?=
 =?us-ascii?Q?OnJYCuIg2FNoBYow0awmT1VB6gxA4i4+Cf/BFkbto+Vfl75xbHX/VieUFReG?=
 =?us-ascii?Q?Rc/rKlTfodCeruM7+pUdFW4TrvIBDs1UjHI/ydGlP4oHlMvLFtQWvLecEfDP?=
 =?us-ascii?Q?7T9gBxGrp1EWmMOxqz6kQI+PtVgfaOX6IPaM6h7wsE+vFTA+sLOzA8BMwQBO?=
 =?us-ascii?Q?TEA1Rl/Dh8nqCsq3aS7yGHE7Fv/tTO7uhdv4L22dnHszY9Zr32NEwtnVLn2d?=
 =?us-ascii?Q?gp/wqdqIe32fP58+P7u8flgQEdJ/mhI7VzErK9KER9USVts8RImO0b4eoSik?=
 =?us-ascii?Q?nlo/kLq7mvp681PCND4vgg9onZVbx2rWI8dPqXz8BAIWSxUU0gUYJuVMcyix?=
 =?us-ascii?Q?lxSoqSvID2/FWKm3vn7Lm3XIW7wOQxUUaRpRSWea7yTUa3SZQ6eyBZITA27a?=
 =?us-ascii?Q?6MVk46kjyyiE1gzS0x7Ec1FN0H4Z8r3xFUduuza2/I9fR1kTBhUAPX79g/zM?=
 =?us-ascii?Q?BpYiFv5dxFztabj+TjJhWNq279diqRlp/U3441WiMiqJSDbkgighrpjS/85d?=
 =?us-ascii?Q?TGGkL8nR2yFlXyoAw0spqzr0YYhhSHsrp3tOylzcJUxNkN4wGrK37li9Y1cH?=
 =?us-ascii?Q?cpfift9mK7u7eNZRJljTeIh01DooDwTkB40tm0zYKEUoLZgASc4De85rIoJ2?=
 =?us-ascii?Q?Nx9kNb1q3JJd+EWS2MpF30Kunfud6aaWo0RDP03LkJb2r3biK5EjDUfIBpA3?=
 =?us-ascii?Q?ItEOG6L+VLJ7SIsdrpW1HN/R/5e1lLiEOuKlA1ccjrm0QEefSEMPeNrimL51?=
 =?us-ascii?Q?4aLC29/3BhOG6LWdQYq1aP4/oW4O08bxVCuUVst7ECmfMlJMPjJ3mPZTWQJH?=
 =?us-ascii?Q?qqA77Kjie4KHLiOD707vkyNZx+OdjNx42HW4fotDqKazvLF95ZPEpMwcYpfW?=
 =?us-ascii?Q?reiqewvCmmPfF4O1P4qpascOQ1cjNlz9MPjuNyqskBo3BIa/hCODRG0OqjW7?=
 =?us-ascii?Q?ai3P4qVW058h7bXBnGWB4vgwAkjAb2XQHpdLxeH8BYC6YnoAY3C75SDhILpT?=
 =?us-ascii?Q?zDHG+kHysDYhEkyFPNVyZXk9TKowqF5xAtTcd6OpLbpFSp7cIVpUnA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wjxtY1HBCApuL9pE4juahCHVyNQPIke0RHvNmtw2bC8lCEyr9ohbGD1ht2u7?=
 =?us-ascii?Q?P+uiDXknvAVVGwKWd23JDVMku0r2uLBsG1czX07K0QNTWzFrUZTehJAhJ3Rs?=
 =?us-ascii?Q?Pd8ARi5yrFd/At5uoGoujcypkCumnqApyhm56G7eTTk5PsRWWIdjx62QbNbK?=
 =?us-ascii?Q?Lp/4RYatKtiiwpDuaUJq9mbePlEsQqAMCS0g8sKPuiLari2aKx6UoeO9z+/p?=
 =?us-ascii?Q?+ZCkZYGzUV5EXOoS/LjbdvxANdLw1buCyNtHz8tm+a4f1ByO3e3Lh9bKgYYv?=
 =?us-ascii?Q?VgwYOXWkRgC1dG1LfoSU4SF+1U/Mt3/HtKSbDDO+IUfp33w+OpqhiwCn8NuH?=
 =?us-ascii?Q?XgTqlqhJQmLfK2rx8chpQP15H9R9A2JxB4l6jegx50Bsas7kQU3RZUYAJ08j?=
 =?us-ascii?Q?E4dHbp7M4rRMX9deYn6ZQFK4CQ9f8zOGfzyRTbwWbBaL7mTPELYRZ5WwHyCv?=
 =?us-ascii?Q?VavD7DUX0QFNBkUiCa4pY/UEcHx5fG1SfB0M+YuhoSozSFcYSYp6KiQMBoR/?=
 =?us-ascii?Q?hUfj8ZBYFJWt9knf105aORiG7atpzAsvUC+ukLzHppMI14F6+YlypIiaGiaM?=
 =?us-ascii?Q?7eBb1ZQ4HbD27f6J5TV0bV9sgR/0j+f+I0pK9gbLU2IfHa6rBnbxIc7t9J+D?=
 =?us-ascii?Q?o2WcHvfnfALVqMrWU3Gx7VIHnV0NQ6joTiOhOXHIAuaJ+qvN1BFbXZsOxCNN?=
 =?us-ascii?Q?s3P1UCI7+gYFKnK/dJjJqp5UgZ67cC1gV0GptmKSXW/GfozPF5/jdHxttF07?=
 =?us-ascii?Q?F8To9faL8hT8NW4i1+a+9CqTjDuk/zopEoKeXpKe0dqg7FuGG7Ea0gShdwE8?=
 =?us-ascii?Q?Sx4FKK8QTilphidTZpO0d2sRXOyX3dnwE0fFn/YYFHyT5/SqLWEQ+u3QtDMG?=
 =?us-ascii?Q?2s1CN86MWSc69WaUKoiu59wSxz2Cpcep53S+u6YK83WyLRTHopdJ7nMSjD2B?=
 =?us-ascii?Q?7TccejAokJqxzS1MJ3mIbULp4jEIGMffRMGSKozZS5cZqOqURjjo+Woif3MY?=
 =?us-ascii?Q?2NkpcJcFy3LpTpwMVYGZ+ZZ0HL+MHxSpvv842AwoQ1el00RlWMc1GGe8kNzH?=
 =?us-ascii?Q?ZYo6c6inFb2n1sGO+d3gl5+CVFejuYFOcDJ/ETK9gaP5eKkzvk75Y+OpkNuc?=
 =?us-ascii?Q?O4lEGyTJrpH41k1IjmO4WC+9G0da/0bezdO3IQ7Sw0wcAhddZtpTN3DB4Ocu?=
 =?us-ascii?Q?KJua/Wox9OWIPPOt4eByJxKkD3WToWCUMbPA4NaOcDHWvR3fbzzjqxa57dTc?=
 =?us-ascii?Q?MGfLfiscGxff28pfQth3911zrTW/uMEWa7oMy1PnVpoYARmbFCcYOLxsiEqY?=
 =?us-ascii?Q?wPLanmZZhfeq5SOqBQuf6TtI+xLegRYy+7V9mTgKCPuu4q3HgD8itJkvsJML?=
 =?us-ascii?Q?4PNM2lQ1+nNwrLNqTM/f0JXWj5K/Hor6oJ+6PLAZu7bNKcx/5rJfDr/7IJny?=
 =?us-ascii?Q?t7p5MWmAI7ALx26f5kHi0AOl966ZpWDuSV+w2BjCjVgDw/9RIQ8dv+WMiMag?=
 =?us-ascii?Q?xLDZwQQZP6RDabM8WorVCLo34+5wwoe+v+AvQuqy/nRMPpIMEWyiCCOX6nWn?=
 =?us-ascii?Q?AuNYbiAbj4XDxj3r/fvxJyMlRWhTtcO2kqTrKnxxn6Sh3CCFPOU+BPQLts++?=
 =?us-ascii?Q?fg=3D=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d7f7d4-e49f-4e57-b2e3-08dda6e8e637
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 00:02:18.5586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vW6LgT4YVYWeGBS+LMOL0wjSnzye5waIWteeZBeV9Ychqob4memsWMQQYwwQBRJeBigaWLRLI5BbcDSkKDqVQVTa+srwnNKdWaSq+TZFV9i6ZY1aV1QkhVjydvyU4Spp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8840


Hi Mark, Geert

> > Convert the MSIOF I2S driver to reuse the MSIOF register and register
> > bit definitions in the header file shared by the MSIOF SPI driver.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> The dependencies and size of merge were looking nasty for a cross tree
> merge, I'll try to remember to apply this at -rc1 but it's probably
> worth checking that I manage to do that.

-rc1 was released

Best regards
---
Kuninori Morimoto

