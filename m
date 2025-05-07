Return-Path: <linux-spi+bounces-7941-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2DAAAD363
	for <lists+linux-spi@lfdr.de>; Wed,  7 May 2025 04:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AC541C005DF
	for <lists+linux-spi@lfdr.de>; Wed,  7 May 2025 02:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A539519047A;
	Wed,  7 May 2025 02:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="W/gvjDWt"
X-Original-To: linux-spi@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010066.outbound.protection.outlook.com [52.101.229.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0921563A9;
	Wed,  7 May 2025 02:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746585556; cv=fail; b=GyXTZYOrW4m6+sQq2Af8mEIHfmryRX1xfd9gmxE+G/d03wOZ30mdQ9x7XgnYmmmMAYgam6sz7DUN+1OQSVAknCVOXFzSX5u7xD12ps40eNTOzM+ktAGIvJFUUnPKAPKlZTLrUZZ8kITyxHgZHevyckiHY1FtzUEXOQ1uKHriD0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746585556; c=relaxed/simple;
	bh=5Wc1sKYBVs2aSCpvZSWUHUfsLHWSU5NPv2RgQqrgj8E=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=hDB4lnKkINs8N1KtGm6u+cvkfeBEwVXREIUwZSKz7hhhL1aTT5YyysAOgqaMsNvh8kxZKaVEMucNNjc/vcxDnHhSXmG7UJH2ldg+bTCN9uynAXyYvMl6E4hrNA2m/94MaqBNovc+U6uo8BGEaCVcWS52h2JNDlNCFtmupOUfkiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=W/gvjDWt; arc=fail smtp.client-ip=52.101.229.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wVYAVNAbqILFmBsW7jiyfTnqmT/rXw2iR8Ag9k6IuA6Ufz6z7ElIx8ppkzNhukLEvmMhSsXnEoVNDUGDlcz85TO4Cxe8d+qnlqE3C6Z8vcSV2/TGOTD3h/sFp7M/hFYquaoZit36k6w52bG5OxhZtizYLigo46T7MFCCa2fHFErcmVXivTjnbx+QC9VbY1TIva4xkqmyg/yDLa83aVvw5Ym3hGMx7jNrmnGuqw/z7GbqBNhA8REIQtH4/QBIQeOZ+1Ffz+TfcvpBTtwfRwPGL7rlcbK6glcOvKwqmOzlMogOm3akyWckP/a+L3YhXHnfz0cu0ed9Y2vZlC2Fae/M2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iaycK/1Q0aC74axo/Z73ehfBb1RqeHKvw5FQWNhmuvA=;
 b=cvKQtSs1tLHKZV7rPsJsp6ZCLU6g8uPXeCkiuUxUIKMTw+Y+Tu9E+K4uLZiLPvpe1KyAWENX3cXRW7rOX6P/QJogPGmM6imY/KF8zAygZMlxQEC8msh5DBPdWuZDo7UJpI2CtVLzYpL2gTdEJeNjSk2luOP8heFaOm0WUAhX2FFO/OmdY/wfiraJ0GvkheRB6+uQUFTdzub9b6iy2CrV7Al4P3oOOGpScPdxJU/jqYBvlE4djJf/m7SkGd/KLYm3OZa1m3vnIbK52Umqa4QT/ZIJI9kODmUzjnhv5FTqdnD6WxC39tHGj+dnGejrnky793zIe5nvSl4k2t38bosBzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iaycK/1Q0aC74axo/Z73ehfBb1RqeHKvw5FQWNhmuvA=;
 b=W/gvjDWt53jzk4uLR4FElYxrj0CO76ATRkx7uNS5rRZsbQlZnWvpd4Gtz51sCx1DyO9yx9ogj9gv5ehPJfrU91mur42IhJf2h6eubeLwltnczXOnlz7iJZUo03wbylqw/lE89g3CWXtiQAKbRryYMzmCJ5POnwo9hkB+Nd40LoQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYVPR01MB10876.jpnprd01.prod.outlook.com
 (2603:1096:400:2aa::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 02:39:10 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%7]) with mapi id 15.20.8699.024; Wed, 7 May 2025
 02:39:10 +0000
Message-ID: <871pt1cfg1.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Takashi Iwai <tiwai@suse.com>,
	Will Deacon <will@kernel.org>,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH v4 9/9] arm64: defconfig: add Renesas MSIOF sound support
In-Reply-To: <CAMuHMdUvtvS-R7cZe-uuUJ+HT5SofTYfh-LwZirY_cMNw379hA@mail.gmail.com>
References: <871ptq4blr.wl-kuninori.morimoto.gx@renesas.com>
	<87o6wu2wzm.wl-kuninori.morimoto.gx@renesas.com>
	<CAMuHMdUvtvS-R7cZe-uuUJ+HT5SofTYfh-LwZirY_cMNw379hA@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 7 May 2025 02:39:10 +0000
X-ClientProxiedBy: TYCP301CA0052.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::15) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYVPR01MB10876:EE_
X-MS-Office365-Filtering-Correlation-Id: db4c1ecf-d763-4a20-1c37-08dd8d1058d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?al6Dwhu4sWftnvVNuR0xldUEecOKtut4QWi93j3VeHgyTr1OhnNl4QRGms4y?=
 =?us-ascii?Q?QiaC+5YxxGM4/PhZc0igxCEiHBW8kVrM3SU9KL4LzrGDzIXVfu+G/XlNdML6?=
 =?us-ascii?Q?etFRNEF1gMTbE0Cgk2DB0dEwLIl8uX/iyG+mh06FYxF+zjJswuY9wOKsTeCn?=
 =?us-ascii?Q?5v+6u1BcAAAsyyseJScQ1/diPHj6nyAo2Bes3Oz9hWTKkLrHiz0ctkufl9lP?=
 =?us-ascii?Q?wD5NSSbjAXSYinXuuASKWlWmcd6LroDIX6FyzlZoaQamp0YXc8xGveZ7vN+7?=
 =?us-ascii?Q?0c/5IuaIOZblsWkd0G6F4B2tfZh3UO+gxnPOTpON1y7ZdYI+0FPNJJiQqVnY?=
 =?us-ascii?Q?o5WfVtB2L7EIKvrqcfTr8csFNLm+Oc26Z4CQvLX8Ie3gXWYYGHE7vrfttWZF?=
 =?us-ascii?Q?m3STtVFawx/g5AxnMie9tv+EWbjZsPeY4Q4eGDKDZ8RY9FfaGt1JNGlRssA3?=
 =?us-ascii?Q?AzEL334Ttr3ITfk/LSldKKAbtt99Zsx+4nhPZ9sTIYSd5RgnY1GNsWMxlQAY?=
 =?us-ascii?Q?Z+auoMASActwQ+ITBB0ALwX9M4IDnsJJGKa222DnLYFAZG7tBpyiVaX81Eml?=
 =?us-ascii?Q?q9f1NJSVqdadryy9ytMnN726UL4OSbhfeeKafdami/EffdIXJhl+XhzFoyZk?=
 =?us-ascii?Q?rlwYcexyujBPu2ZKPgdY184D5tRRjRG7YFxBkSCqhr5bLIey/SwXRZzW9V0C?=
 =?us-ascii?Q?H4kkSQZNYqI6erf17yJ7PwQdxrykeih/pzzXo1FvTUMRCyT8jrJMcWhq3bV8?=
 =?us-ascii?Q?14ZAszgOLHNrhYRiGvHmRiaDgXGScKcAKIbhuv1/buUEoXvUrJ5UslsDgudX?=
 =?us-ascii?Q?oN8zLOHpdqcNRQ9+2yz6mWijyh8zEK5m/KVxYSBVVozI8iBauKvyekZGff/E?=
 =?us-ascii?Q?muGlA1SBEa/Te8O+2mh/10ZUzafm8T2jQIkKfzIxzKPqa8H5uA2AGpkS8hcx?=
 =?us-ascii?Q?HrJ8FYoQDYMNX/4n6DpgmNwVdFbmUl+n+d/mbps00db03OASvfR3imOmg3tr?=
 =?us-ascii?Q?NHjQfEmvD1JRed8k8VkAv/mu0SktwTnQDhWywaeDkmIJMeTpp7ZTQ4ORB59r?=
 =?us-ascii?Q?mL+impZNkF3mawxbVYYPe4dDosdo6v6qEyalhjsW9fg6owq2h7bryzdAfhy5?=
 =?us-ascii?Q?4J2neJ+pcXODtRI/fZ5eDGGV3wNdHb6Wxl8p7+/8B10abKEazusoufYdfdN4?=
 =?us-ascii?Q?KaVjwd1J7e8eGWcRhm1oC87hwylT0uXpfjN6GafUDvzE47TvMx3lGb2SYgiN?=
 =?us-ascii?Q?aVt9oNeEQWFwwjnYZaMWC+kahwd/wcOHr9UY+TFpeXoVYlQPSEQer9e0DGsG?=
 =?us-ascii?Q?/f5+9k6bBk3fFJ7z/4V5Td6Fso0Mlvu81MBed+8/l6iCr5hRxhS7C04X8dCo?=
 =?us-ascii?Q?y2dlG2ob47jhWmRltjlog6trHuOqqhkegKg79HTD9WZaHJb6Whm0CdwNDl+y?=
 =?us-ascii?Q?8cH6pZosz2KW1PchTrIq5zCfMny1XFrIxwfI8TBqmEyNRYTaWwTkig=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b3YdwMwTMf1l9ZJe0NrcmqKoFCWObU16naSZV0np+qpzdl6Q2V6dfezrnnJR?=
 =?us-ascii?Q?ENvW1evQB3vQZkShD3k9A3Nc5nQciq88+rUWBiIQmYFcj+yqFEfF3dP79Tco?=
 =?us-ascii?Q?LTIzc+f94Zh675wg9i5zYC9rcYfJ3G6ApCfKIsRAgF6WBSpPnulwwrXpj86n?=
 =?us-ascii?Q?jSN5FYfT4v9p0XDwG6LUaciwUzU2cc1q9xhZFptb8jY7J15x3FxUoOCexDQm?=
 =?us-ascii?Q?3yqsO36xYufKR3IRJVuZAlWi2OPRL5IAhFS8ZBsEMS1pMiIlG1tKVaS1KByi?=
 =?us-ascii?Q?AgrP86Y5soF1to8wce5/WpWCS1O59YF09MQ4LdNVPSbQ6lxuMxg5QuMOgkn4?=
 =?us-ascii?Q?lhJ2by2E3kGBgwO4WjeJA+1LOT5qOP72PYkpdQjwa/6EgqTjtBsxzNF6K9nd?=
 =?us-ascii?Q?6Zyxnst7xV7SCR0jLpBKJngkM392H4uFAHjR1PolKSOYHtusxajRXhzSJL7u?=
 =?us-ascii?Q?Ad3exsMPd5LT5XH4j9kumJ+8DB+YJ2687k6N+rLoUB0Gtn5VN+EkoyEwe/BE?=
 =?us-ascii?Q?2FGM7qJsW+efutMmD3c+M9Yb/AHuiQ+INfq9Hf8o0v+9tSRBLGiP3Y5XYG1c?=
 =?us-ascii?Q?lPzDpLORCaCBHFtGMMJ4NetjVa8sM58lyhfQz+3CygbvhTlQnKJS5wk7Nx/b?=
 =?us-ascii?Q?MbbtXXtvECS8yXR+bU1dh50lC/JWr4T7WAHVKttpWBNuXvAvj3aYm/y84Zlq?=
 =?us-ascii?Q?1kIy8dFVlvFFPR5OOskgY+g0nIw3jnitKuBkAj0hGX1bfsuWYOTmgj4MZrNU?=
 =?us-ascii?Q?9xpZgc8tUQWVYvmebMe5Pp4Nr+oNUMdLmY8DJgTDogB6wPVwSHtmS+uo8unN?=
 =?us-ascii?Q?v12kB2oST1SvUbXummbHpfj2RDe+RtACUXirLVdqLfRQpFcf/FaK0T/mnKRv?=
 =?us-ascii?Q?V9pxPAero+Dk69suCwKMn8ughj64R71jqCR7uKVcuu+9KTFx3sGr/1twHzeE?=
 =?us-ascii?Q?j3U2Ce/8ZG1PwZHQf/BabAmp3qAAAcnALyne3QyUJYOZ02/IYtg0hiTMx10p?=
 =?us-ascii?Q?mraCCbyH2dq5nINTDB3eC9tTSF8Xvjj7CKg5NjFyqwtS+Eukn7X7U7bO4eoe?=
 =?us-ascii?Q?AJnilaqWm0x0P8skjEJ5S8II3UD1cL3FSDWOFJsKwYG26iwgQgW9PlTWss9n?=
 =?us-ascii?Q?54SF4FXzkeoRK9xCqTXgvQ52My1xc01j52BWhB3iCh90cD7kBQXZgfiZCvlh?=
 =?us-ascii?Q?my1PWmbeJ97A+I6twnrarHY9da0NCYlRqPAHorjsqwAWuSebm5tNz5Fs5uk8?=
 =?us-ascii?Q?iyiOzBzrNLziYypisqH/zcDvCA+g0n8jD469yjPt/jrepUux/pR1xs/M33Yc?=
 =?us-ascii?Q?cVVE8P9iLoVd3Cgkl0HzP31ABY4a2K1/m7jSq+AjxJIixIC+wNtrG9qCmMdp?=
 =?us-ascii?Q?rnvgJlKeb8o0liwXDq3V5JC3+8F/8elDR4+LVv9yvTKRdcyVYF9osxAKcrJk?=
 =?us-ascii?Q?laq7Gj5Z3JrcO0I03l2SOzCOHIT+oKj8KCGkrhi9HcZyfe5V6j1i5mSM+Gt9?=
 =?us-ascii?Q?NzXsNaklGocgiq7LwpvtpoE9z16NnfsgI9t0VroGRjBZvMyvmpXWNwB89EU7?=
 =?us-ascii?Q?NpZWpAxnj8+AP49UdxJoBuuvAttL8shL+50qgd6R61nMUWrJ4U6NxBZecPhB?=
 =?us-ascii?Q?lZQmM27bcyPZuDYkNjfkVbk=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db4c1ecf-d763-4a20-1c37-08dd8d1058d4
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 02:39:10.7437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GGoHRKD4d3kP+81XEGgifSgT+pZGU7a2wT0hwx8yxwGLhbsplsYlOgA0avgZ+YydyNRVeQUAO9lJgGez+KEHdKc/AZmFHnQCoGbWprFZ4uOSQBwgqqwjKrzX8i6EXR4O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10876


Hi Geert

> > Renesas V4H Sparrow Hawk board needs MSIOF Sound driver.
> > Support it.
> >
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> i.e. will queue in renesas-devel for v6.16.

Please let me know if I need to post patch for renesas_defconfig.
I'm happy if you can handle that.

Thank you for your help !!

Best regards
---
Kuninori Morimoto

