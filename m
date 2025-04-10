Return-Path: <linux-spi+bounces-7534-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A07A84FF8
	for <lists+linux-spi@lfdr.de>; Fri, 11 Apr 2025 01:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9D779A50C4
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 23:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E342E202F7B;
	Thu, 10 Apr 2025 23:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="C5uBWrbQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011049.outbound.protection.outlook.com [40.107.74.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFE61C700D;
	Thu, 10 Apr 2025 23:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744326306; cv=fail; b=ur1YE1pOzV1pPgkkxFD1P1vU9WEONKQ+EK/JxR4IB6hTK+7+c1WuObr3675OFPJeww/Vm6ndmTaj1py3jz6C5oG+rbNSaQ5xHtU7q7eJwV+GZAHJN2o8O+qa4lJ9oB3LAHq5n8SYuxLBhk1/wjuZ7S2d1+CCVR0Ab4ZJh0mPf0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744326306; c=relaxed/simple;
	bh=Uv7mNcSVNrwrjCKHJjah/ki8HHk65RacRs+8UPckS20=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=fpXa6RlMOtJ4cWy8Xm7ShYy0AoP8P+imnzqj1ZKzcD5mmSoWWsJmcu6/3HzErPf8d3g4wIrLY8q//Nijyga5Mm/qteH3XhV3xwkeufm3gIRn6I5QObAxOFvMcMOdi3UVXvdGFOGaKoMWjV0bo6DkGL7GUoX/gsoXLj2oLPplQxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=C5uBWrbQ; arc=fail smtp.client-ip=40.107.74.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SuC88UhxHYSVpyU/WiukE1b3k0ldK3hSnqGdmqyhkUUxfrhwm6cfq56YKV2+HpXFfsvR+cbE7cWYjFWdnk822tUFU1nt0XRvYz9qFGOhB4aTX8OxSoPidc5vhibOHvOPMyOZOvyf/g66yeIl0olaaDyoOT4W4K8T61BfMvGvmFKXWmdvT/DJMw4wYI4KAQOtK8aJsp11pjUy0njzbTbpUQu5Pkxu0cyBc9T3SgT85jp1dObmLJU9dkyRAu5kq9nX3z/h8bRkYvG2FGUTVfnV6tiAzLos5SelqJiCxuxuS9xneZMfTzCRs0iH6dPGC/OzhEYuGnMxroa3cRYlrsFvDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EiVtfVxZ72ufST0pUmAotl2v+FCL/hxbkoGXdlfjQ3E=;
 b=wyfrU6E/eATqd24uziY7bv4/yfLn+vCmhU5y9+5iQzuGimvSQDJvMWdFIeVNy/uyuEMTkKH7uS7NACy4njj7w2hKWzyPDY6c0NtyyqTxBjI2JlM7HGFyaOQ4GVNrg6IjVCvEvSRuaOGZiLwO9CsGOoNYmmQ5mIJinhZlqypDtdzXf03Nc44p8B8Tnng7Q25PQM35iWE7XIb2McQog0Q1H6SCB961wTKfdYTTwInVNfZdywOq5yVJnAvhkhT8ta2ItN4j0UAs4nW0C8fCX1wDUU7TfyevzFj1YsoIP1io+biaw7gBbBrdSHDttOw8wOYSEyTf33wXGrvnYhHTbcOnhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EiVtfVxZ72ufST0pUmAotl2v+FCL/hxbkoGXdlfjQ3E=;
 b=C5uBWrbQmhbOMGaa7fAyxGHdqdDTAb3dfR7oVa+NHGAnIeQMRrbT9GhZfjAEgezf/E1yAI2hCSumZ80foUgz6kdXMvALdDZrYGikmpc9HiiksJf0o88h7BvZvXvbjdCnDVefcuzybvOLkn88kXAcBpiKhVVo5o6msM3gIbhC2lU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OSCPR01MB13678.jpnprd01.prod.outlook.com
 (2603:1096:604:37c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Thu, 10 Apr
 2025 23:04:57 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 23:04:57 +0000
Message-ID: <87o6x3hb3a.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
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
Subject: Re: [PATCH 6/7] ASoC: renesas: add MSIOF sound support
In-Reply-To: <CAMuHMdXYYYAabmsuVmM6mAqNM6XHyzKsScwAr0TruSe_LMo1kQ@mail.gmail.com>
References: <875xjeb0wu.wl-kuninori.morimoto.gx@renesas.com>
	<87wmbu9may.wl-kuninori.morimoto.gx@renesas.com>
	<CAMuHMdWL_C-Vg3d+fAK_nXvzeZNNPDkkzPjB1oHRKHh16rZUHw@mail.gmail.com>
	<8734egnbl0.wl-kuninori.morimoto.gx@renesas.com>
	<87iknclp1w.wl-kuninori.morimoto.gx@renesas.com>
	<CAMuHMdXYYYAabmsuVmM6mAqNM6XHyzKsScwAr0TruSe_LMo1kQ@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Thu, 10 Apr 2025 23:04:57 +0000
X-ClientProxiedBy: TYCP286CA0083.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::11) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OSCPR01MB13678:EE_
X-MS-Office365-Filtering-Correlation-Id: 61b0b3f3-0214-4a33-b809-08dd78841d00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wVzrzaMjqWQaz+If5zK16QGDiswDYAhBpxxKVOhhm/eSSN4DFw/m2Jo4ZDn3?=
 =?us-ascii?Q?NUO3CIh7AYLRXCSybkqOwn0Kfr3S9nx8JsRAIQesTTxzYxqH3Xqfa5vA37vZ?=
 =?us-ascii?Q?Ft2EL8iWZWyfYn08BCnlomnfcOen6WMQAP/Ju5jd1RlKlynE7HowEdmmOe3p?=
 =?us-ascii?Q?O9tV1O80jVDm2F77UaUWETR/xt3JQB++kUT6vwIOuTYOlBN6v6AVbSNv/dt7?=
 =?us-ascii?Q?ZCZhKUJbjto40m4C4r6PqdF4eDv6g74N/JJe7Vs06ENks2QT7m/bCQiPOT+Y?=
 =?us-ascii?Q?MH5hLqe91w0Rz5KA9VHujT/P7uHFaev4p7t0EJ3LUThNmeqL7MTV3xjJLIVW?=
 =?us-ascii?Q?vvfQg9OWJo7jXDdpb/ROOIm5KCjAbly7kS5IdFAeZ71+LPTgGfrvFm4V9qHT?=
 =?us-ascii?Q?JVPnQQRtK5BDDK6Rsc10UzAmm1imyxV1CSIbctaS2eUzThNvsLG9hjO7UZhe?=
 =?us-ascii?Q?GsZq9W2tA2wwuLvSTrLeiJRfOL1Uoh6UzoYy2HvXJ8btsFkpPHiA7VuHyIli?=
 =?us-ascii?Q?R3rYFj2kyZdyjnBI57YuR2HcfuqASV3JT/YUwFsx50RAeGYKs1MlDJrAyWj6?=
 =?us-ascii?Q?YLbZHZ8Bf4NAo8kDG4WGCoMfjyh+q19gIfesHU//4pLsHRjN4rl2EGT3OCSs?=
 =?us-ascii?Q?fDcCGboAPbySDsWT8u4e4/WTIoqwm0RN+2xqIK/Ce/m7LUubHfFv8T7Wra2U?=
 =?us-ascii?Q?lnv5T/UA8rsAkQgaZuKfM8qlcienW9bAfqECHv/Zh/qqQkPoOTFKiZpLIzAs?=
 =?us-ascii?Q?CG2zvq8INy3l/vxapP/zZPDxox3kZ289LGxRCMhq4cXsTO1fC9daM5lDlRyh?=
 =?us-ascii?Q?34gvo7mLZYP++0IiJpJL0h5yuRaU7mmcAMQGArFxTuqLl034nyiaYtPOxUVn?=
 =?us-ascii?Q?uocR5iqJpIqXbvzbs1uxkOvYJLloDr0/3f9eIgrgqDTkC6mGwji8+YH/3+WZ?=
 =?us-ascii?Q?IQZtVSUlbgbEBVh66fDN/Ulew/zl9cxmzdvRlaGTzK/qdF/YB85TTlPBdP41?=
 =?us-ascii?Q?P/3BiIOl/P9iOz5m9ZwkCJu7X6LnW9elB0kcO9jCmNEreZz+9MG99GjYzZhh?=
 =?us-ascii?Q?xE6/YIh7y1nVBqBMbq0ii0p+2McG9YBWb99hoPfJhVWzsjE0flhlZxt0pAGu?=
 =?us-ascii?Q?7Z6uNEzBX3Uo4hNkcU/nbtHTdkzp9tZloQJzDa33+Pp/Exz+HRf2Xn7DtX/e?=
 =?us-ascii?Q?za5iT3U2i5WoVXPd1465nrAwmZ+WUUh1bCLAafndb1EYD+ddjrv1jfVjPEAF?=
 =?us-ascii?Q?0HQn3g1lacCDWshWFXLoZJrQHOzHoH3SGVWNEFfK4kfb4IBKBwikB6ldnkoW?=
 =?us-ascii?Q?tZSLWSX1oUPaH9XOFU8wHBkyf8jHdJZPaHYqSkCyTvsBspm4hsaT537AiB94?=
 =?us-ascii?Q?PXlIVBAS+p22QFeKxNNBtdB4Jc/klJwKFIFZo6qouCNP8sa1/IJsARZcSI2P?=
 =?us-ascii?Q?nM2LN8QCNf+y2YhLIgKY7LCDOOvimJx8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zGvC3ehfqr8sAuaezKHXaEVTH/kQ2mA0BwDGCR20JLk6WdkB/xEhejD80l9E?=
 =?us-ascii?Q?XZXa55q+OsEl3r5G2WVIx+GRrePmPCmgdgL8qw7R2oi7ouTh1gtA35pcLpbW?=
 =?us-ascii?Q?eThTbs32VIHuybkXUWg9eMnlC+gGswwL37ErS3gF2HIQe/XMe6zNG2gewOJM?=
 =?us-ascii?Q?vKHne6KfXU3QX3yVXMpH9pBvyvpYFXqJfXqFA4k7RMUvMkpEpIN7s7aJiM/a?=
 =?us-ascii?Q?6TS0zcDg8quuwRNEar2J8uTod7f8cY/3II4BioccGPfprB0d8AeqUVWuS5SC?=
 =?us-ascii?Q?KIQJn+ObeHyJRkfkkU/b1edqzYXqBxy9WLqrNo2cVbwmPlxEwrFnkhGc9h3B?=
 =?us-ascii?Q?xKkEJ6AzFaOO8UjZ62gx8ZJnJVeZfmas9Y1R1cXwNPQhH7JEP8aGVvS064Hl?=
 =?us-ascii?Q?zsy5EW3yxRYb822hR8jyjODRLYRuGQab0bnWGXeemlxSixCvrlLruX0yJ+Vh?=
 =?us-ascii?Q?s/uJLV6vpH9ANtxtCVt/rRtpb9/qafDDthwhbW6uy/HRYmcFKy4Vt48U9DLV?=
 =?us-ascii?Q?6A1ZCY8p1/1XJHfbLj+D6zS/IMz7kbcZT/68Xz+PudcNLC1Ek8JM4Gr03dtD?=
 =?us-ascii?Q?WGF2itQzmEqUByDbXlVlLoeEFjQGU+8+JbA1UfzaZFc7yICtOGamkjx0BZvm?=
 =?us-ascii?Q?i82r4aXfq6Jhx7v3qXHRmhAXfB5QK7Lh8L7yeScZm+64dogHRQNX4HbLXU4x?=
 =?us-ascii?Q?glzWYsy4yJEqaeB7LUGQNuf0Ac7rRBvbkwUmErv7+zC4LuJfwRCvYq9inoKi?=
 =?us-ascii?Q?fAaOfxdOQ0BBJHqXyCKTtMUAP6eSu9aZ4PKcipTJxCCLeGpILH93oMZT+Ean?=
 =?us-ascii?Q?9RcQ3p1pDAfBe5lBGuPmTLPehRq/XHAZMNuKCbd4ecXmtTi+bwk6G7QcmHDr?=
 =?us-ascii?Q?JTjoiUYsou+aGXkCYKof+U7pLcpk815SPDw/J5FZV5Vh0yTPLLssg4dxguvs?=
 =?us-ascii?Q?RXEmWx8RhnGMBd1ff6p0kL5xTCzNVJsHfT0zjQW6LE3S2lNPEEVcVrS+OI4W?=
 =?us-ascii?Q?TX1O/HOS0FVGyBxwJAqCjOy4WeTOptiT245strMyDz2CnztbXqwBslmdt7Ah?=
 =?us-ascii?Q?lQ08ayTDtt/Y4VGTIcuBdl0zQnuagdmOHWYfyLIO4VkW28hW8jVZcVw8UHWJ?=
 =?us-ascii?Q?JmdoZo2qnFFc/ARpW41v5h/SZdn4cQw18oEB11KkklKGkI98t9VaHlQ+8KUu?=
 =?us-ascii?Q?Ym9Hm1iSBjlIcbXnZScOhm7riP4fYby5JnjbssDO8COsfNrYDXEUSQLAdLA5?=
 =?us-ascii?Q?y76wU8ylX3CtQrp5tZE72PamGrX9ah1ugUOpmXTaJ2/GgB42WEsdRdmE5/qD?=
 =?us-ascii?Q?IsnlEYSJtCQOQzVO51Y7N9K5uSLCtfR+iu9Dfmgk9H3rRGnkCCbTKHPZYTbZ?=
 =?us-ascii?Q?vCsHvuO7ty64kPkOu4Ln0V6hgryxTKj+l3OKAsyK8pn41gwnqR+f55Rn0tF5?=
 =?us-ascii?Q?2qbtu9Yr5Q5a9k8In/tMMT2Hg7MMuVarfu7S6atSA2mgHaOEvpxhUFINGGh6?=
 =?us-ascii?Q?bf81oprDVhpcp3j/oUfKz8j7TGRXVzRGavn8zkI+8DPeZOcsFkKAKg7QWSwR?=
 =?us-ascii?Q?JDJxB0xzm/Ytd9A4/YA3lu9JQxZnaa6uoKK+Z9ZW0oiGuMv1EuHtoWtbHMTS?=
 =?us-ascii?Q?1MGDLN4b82WRxL5EoK1at9M=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b0b3f3-0214-4a33-b809-08dd78841d00
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 23:04:57.4964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dYCbyYk5w+1cQaoggvPUMX5qFpDJvANkr3+i41uIqdP9IYQSqcO/oBAAW4mgF5Zr+j3zviI1XJuJyUN9qO/BIhnfHULRchap9T+vYidSp6WXw8CjUuaai90mVu197weo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13678


Hi Geert

> > > > > +config SND_SOC_MSIOF
> > > > > +       tristate "R-Car series MSIOF support"
> > > > > +       depends on OF
> > > >
> > > > depends on ARCH_RENESAS || COMPILE_TEST
> > >
> > > Ah, yes indeed. Will add in v2
> >
> > Renesas category Sound drivers are under below menu.
> > So, it is not needed on each drivers.
> >
> > menu "SoC Audio support for Renesas SoCs"
> >         depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
> 
> Thanks, I should have checked that...

No problem.
Thank you for your review anyway

Best regards
---
Kuninori Morimoto

