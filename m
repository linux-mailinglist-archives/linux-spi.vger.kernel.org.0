Return-Path: <linux-spi+bounces-7497-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7825A83495
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 01:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9B391665D3
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 23:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917C321ABA0;
	Wed,  9 Apr 2025 23:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="jnKRYrB6"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011060.outbound.protection.outlook.com [40.107.74.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6C3211472;
	Wed,  9 Apr 2025 23:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744241530; cv=fail; b=Dxb8F+DPpZ/F0Lax9SrralTs0XAebIwvCxg8kmmE3SlFw9Hn95Kb2zmk+d5mdfWzrXmU1ayOUjJKAxTbp0wgWwzcsC+8e7jDdEoFGuO81fjI9mw8mUc2yqYf5BlUNl9XlktgUGTwq32CebHNb34gZHP6cume8Y0Wn/pHmZGCxlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744241530; c=relaxed/simple;
	bh=Ch6ah20DgBuhPftnDG2z32tCleEe6TnA3WvGkT9Zlfo=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=B2b5QjM8BeHR4818u3SxUCIjlshce+gq40Rbp+4C5Q3CN3Sj8EfW/QDs2Gx0srYmQGyqdJhYhc1HV/5Kq2FuhOK1qsSeGp2mmLSf0CiJnfBNWXawlirpbVnhNj6eHAygH8i/8Qq7c1QC7IykrMF5HUKHfBykWSLazZ2vDHOMFVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=jnKRYrB6; arc=fail smtp.client-ip=40.107.74.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=it3Q3lPovBMN7Gymv6DQzQPkmxbp0dr3EJOIsDc/hZdnAlrwUzkn62cDfzPqOnEqjnhYkHQHkDQAn2vnWrPzO/SM5HXlhC39mLLsLdipaF9RwD+1+GPkd4NL1opjNOMe36BPwj61angwlaI/hhdDx0etOdWv3UJMXdXcb5iKWecKqBd36Q2es/8x9MYN9NVq5/KpsCUnC4Xw0XlbBCIbFei8Q145XRBWc0PvX6Cny0uLg9ql4ArBcK8gf1IYZ5+aPYWwHkELlxnW82KLMg41rnn6OJce7KE8GMK5dRCTEuASnTkdjOyAN5yvrmjCpzmN6AMyaMavaewKlgOtdt3Ffw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/OcRi1mc683S+U74k6mZOGC7/Lr1aoJ0JIh2epTTlk=;
 b=tURUGDo/N/zcQEsNVN0FEackjTwe0++3Wd5MhIwkDgE3eSOdyE8TLpTDuYXRrRMydMi/0h9PAZOIyhLfl/xhBcsT4SBqJgsvyGLzmI9oLjkj3FTYIeEMGkkWb3JfhdnN0SIcLuRZ2HssnMnx9s8xGW/ecFh8lO8GgiuEWuKiyh8Lc6+jvt7pg8JRvhjhY7wDFIz5pBLpH9PaNDmmY54IBWdxaHdvMLEVt3Io64CGvkUGBTeA2Tj+qmzbe5RGM080m8HRE+IRxUz7aU+BC8pKNAkBNcvzpIw2H8/j+ieiAXSDCOxLY9ZZ62TIFsolYdAlo8SEq87LaAFDj93WriElGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/OcRi1mc683S+U74k6mZOGC7/Lr1aoJ0JIh2epTTlk=;
 b=jnKRYrB6Gzg7eVHEauMd3piSP1bpHGInR2V5tRG3V5lcVJlB9xBAcHr5QKiZFbNh5uiRUo8PaOMUUkfLF/9StGWfByVgsaPe7W10es2SzB9131IJHjtP92MvP898vXoRvpVBDsOGxgpxBH5ZbSgKwF29b4+4FcfoFHRED4sT8Hw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TY3PR01MB11797.jpnprd01.prod.outlook.com
 (2603:1096:400:373::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 23:31:59 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 23:31:59 +0000
Message-ID: <874iywnc7l.wl-kuninori.morimoto.gx@renesas.com>
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
Subject: Re: [PATCH 2/7] spi: sh-msiof: ignore driver probing if it was MSIOF Sound
In-Reply-To: <CAMuHMdVC997SufjabEtwx9ZLZrzYRmWpCEXxHh9r8Rtee=QYpg@mail.gmail.com>
References: <875xjeb0wu.wl-kuninori.morimoto.gx@renesas.com>
	<8734eib0vx.wl-kuninori.morimoto.gx@renesas.com>
	<CAMuHMdVC997SufjabEtwx9ZLZrzYRmWpCEXxHh9r8Rtee=QYpg@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 9 Apr 2025 23:31:59 +0000
X-ClientProxiedBy: TYAPR01CA0182.jpnprd01.prod.outlook.com
 (2603:1096:404:ba::26) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TY3PR01MB11797:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ff1c768-64f9-4a81-033d-08dd77beb93b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mBOQW8D6mNMRK+3y0DHXmtIK86vy+4HUkfXkHXFn/lLu+ZqOPWzIiHdgKAHB?=
 =?us-ascii?Q?/P6fYgq4tTA0gWly6+hVvZVXQ2TBNBX0231HEh7Pd3F8S54RiXyUMW2ABttG?=
 =?us-ascii?Q?N9gPgcvBTYUrFjcXBvRzF7jL+9EXEbCCgrhuzaZD4gChTBR5h4vqxw5YWVov?=
 =?us-ascii?Q?BPVJph1/9HeGaXvVRuQg5ZMskq3xp36FkmuDU8C078UBWuouLA1F9EuPwmN/?=
 =?us-ascii?Q?DEs1aRFH/sFDcZ3PAwo8aicZmS2kfEERrlZOX/uOyuzs+XMbYI2yGtgKkcuJ?=
 =?us-ascii?Q?dxKA5joDLRwZjOXf01dgxs3EcRJUa4vomXMhCOYalbWqiblP2wWr2aiGLxt8?=
 =?us-ascii?Q?fs6L5su+2SZG7ChIuBcHSPUlpSu7YZKslvKoErdm60foES/Rhj8E6TApTPpg?=
 =?us-ascii?Q?AcS4S/KfjbzmgsA1QFCWUeyA9F/gPSCibz6OuUvyWrtLHHAteOoeHg7Jt/L4?=
 =?us-ascii?Q?EP/BGYPIKcwRNf7Pa19kMsWkpqNHnM7/0Hd+eZlaMpPKpLW9y6DyHqyo8Hsy?=
 =?us-ascii?Q?osyghhhcGjR3mneRb9l+3pQ+2OkgLcYePlyzWorADPesLAoyzenJon/SAB48?=
 =?us-ascii?Q?RurKuF2DLRfc7i0I5A3Ro0OfqSbIf9XXz0lBy5Gi4BBRLmpDO1XcqDOkynsZ?=
 =?us-ascii?Q?eGKZRPVZCy0pBhZIrpjmfFxdmFzbtgFwmEdxaokaRG1Ec084ytBR6+Rk0t7c?=
 =?us-ascii?Q?p87TCPP3FhB5lpS98Cn5Z4oDaw0LUYPHritC6uZCFPnuW3glQBJSXXXReuiO?=
 =?us-ascii?Q?zgo/e8tHuySQCCJkfFxrhlb2SyuSERMeCoZ1wklt0MoJKXfPcVNic0cTWzVM?=
 =?us-ascii?Q?phfOaS6jRytwjk5VHDNz5eXlGduU5+WC0Y370F6iqj7vfmLAG0n9JAqmWbK3?=
 =?us-ascii?Q?DOwaJCJecRu/hXlGILuZuxyZOJuCDDJHaNVpUt+p+knRMA9Sm58om9EfIwiI?=
 =?us-ascii?Q?GWGjxuV8yq89+qbz1Br+C+pSa1/M0WlR4U/0stB1pdxDhKdy3xcUQmo2BC3k?=
 =?us-ascii?Q?f8vwqzTc0BCtnbBHwxhojvTvr3JnbHEKWhD/YE8rwkqC2++X+kcerhy4BdqY?=
 =?us-ascii?Q?Sv0x0QIwcDnH8CB78uQPkujYIGXp06qvPXuNsGN87UNMYIatuX1zezTDlg62?=
 =?us-ascii?Q?TuVNTo0qBAtGGva/tqmyrYTPSsd1SZDlzbxMi6v7Qg7M1hMpwvJxL8Wn69Kt?=
 =?us-ascii?Q?Lpzy+7vvg4BxE6UTTnAlVkvDzk//w8qfR/jNVft6Km8lBWnFf7u8pf+2IE4j?=
 =?us-ascii?Q?SdKcjOm/xoji7lqnqLW7Ic7tEIas1M4B4yyfoNVUDLBgYde8Wi/PQlPaoFdr?=
 =?us-ascii?Q?4C5AbdwxZN6d9CAv4PXwKlfk91cFmoAaixKFkqLrbPuYC1+HxDnHQkw1b7tp?=
 =?us-ascii?Q?cBzKF2R9WnlqSywEDp9gtyAWVKCx7igB2CHw7ecAvMro0tCT6eW6zZ4c5FV6?=
 =?us-ascii?Q?FUPmF5lwioy+dTTD2/syLBzrNFmtwS0v1zpei37bie/jTRXYtCk4fw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nE4Qc0/BjmJlISDTGs9OKG/a+F/PC9lAbPaXr4B7/S6ie6T7y4Xo3bHFUMXW?=
 =?us-ascii?Q?NZL7rwcwJ4WiZCnu0/PD/kYslMfk1t/YNvn+hOoG1wq5e1GpW7nKGPkgPdiV?=
 =?us-ascii?Q?uhd8ipaJzqrDkcT8Wz4Oatj2YPD5nWefweiieEl6e1A1p4TmiTc+87djG4Kw?=
 =?us-ascii?Q?rmx/+/duY8EsmpKxQfc5F5due/9LEueeOWkW5m7Qp+u29wEFKX1wzilZW0/P?=
 =?us-ascii?Q?CWt6MH9CZFtE3YwhDwHyYJyWboavxghzvoDT+tZYnNA6X6RodcKVRZikFsxV?=
 =?us-ascii?Q?x/0Kfkx0CjUhc3A81y5wH/8xT9bZ+iNBCyCDZGuwC52GMIVKo4KWvP6yl7Zq?=
 =?us-ascii?Q?rKKoc6TW//7QlJbEiOAWncXXs2/MmpcZV3rm71NzQ1Du7hMC8rAiXgYIUqFf?=
 =?us-ascii?Q?z1lqHGf+ogBmAVRprbs3S2U+tbqU656IVpLu68BfPDbnjwjnvFaikmLFpz9n?=
 =?us-ascii?Q?M5rGdNgl7ege4D+FiTUSNMv5vLrvP3mKqTXI89NKsOfCELeu+JKi0spaqtud?=
 =?us-ascii?Q?rF9p1EjLeuU0BG1I8fXbClXakP95fxzeAkAoqU7NvKH050GeUcU5ISsqNMiW?=
 =?us-ascii?Q?4dFofpVIY0NU8fsArUMtNaN6Ni1pHptOQgDuDzxcuWpXHsPhif0cW3HFEz8V?=
 =?us-ascii?Q?U7jMTbca2xNVaetuZf+ngr0ZlSIC3DiUdmo7wYfKpJMt2wVOD9I+I36U5rS+?=
 =?us-ascii?Q?zgLPJHZf/k89Mvd7YYiy98zytvcRe1MRiBvwL5wY9Dt9co1amD6oBJT2RndG?=
 =?us-ascii?Q?nzz5uHJGjOkctd+Xa2FPI0orHajPkqcNlik1K2SVhqPGzvAQVSwhf1N1o44w?=
 =?us-ascii?Q?+S8HJ5Vjx06n51lEoyScf7iPwIASi706JlKIOFKA++bUjDyp7XIuuI57RNEb?=
 =?us-ascii?Q?dnmmM4P9040/Y0UwmEzCLld8rKxFBDxueC1LJ5wWfRQN8ZswlaHSCLMMRjBz?=
 =?us-ascii?Q?5FG75A6+nQuHvhTcM1uGhb6HsXNTEWOhWpu0HlJQhxmx8FRy79DwmtzBg6A+?=
 =?us-ascii?Q?9Mvg1ZQovdOZ41kqDQ27qAjbxfC8bJB562Fwobc+JcS1WwNSunB0DKX9T3Hd?=
 =?us-ascii?Q?9E1bXTa1UIdG58UL1W6906KiP3PoUE+dHCpFpjgR3uDm4X9zjAGf2dFXKgqB?=
 =?us-ascii?Q?lQmJyCNZy+tPmo07P78/s1v8RjcJdDQl/Zd+DNYWCfAzEntdDxnUtS2TOoIi?=
 =?us-ascii?Q?XpEiCjVGu2MLNZUwvi9OMy1HzMf66NeH9t8fTJj5ylp08x8HL9E3soMeqZga?=
 =?us-ascii?Q?1OTyBuGqvulOn5Ja9atj4vjlPHOmkLcRzTggP3kTEGSMsqS+J2Zj9vrJ7YVW?=
 =?us-ascii?Q?bQfee+tBHzZEmLlne+bOQSHp1jUwQXCUw1yD5vtWdgXkWcIBP5RNkgqlOCfh?=
 =?us-ascii?Q?jn+9n/kVqSBEzhAKDHwXi4DVXzSdizwmejKSFHt+oYL/u2zrSumACUabNvIF?=
 =?us-ascii?Q?/UYMkeRB+gzDOn0PH9O9QSE7qmPNM78cfO7sgt+y8iAKLsUZoiinahoi321n?=
 =?us-ascii?Q?0KV2YnTXRffqiTLfrg0x7yFwomHfps4ynT3ntyBY8mo4QgOH+DMAHXbhRDUD?=
 =?us-ascii?Q?kL4/M6BCrwbnTFbHeElerAfbeN2k6/mREHUEX9JMTIs33K7w9OF0J+aDWiqI?=
 =?us-ascii?Q?491z6U1V5eq5M5fzlRZQ/50=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff1c768-64f9-4a81-033d-08dd77beb93b
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 23:31:59.2496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zXXnl6WwM2i3RY+itwSy2YGVEjw1vSI/7xugWImlGgMQvKcVvwAZdMU0Qf7nGlM7Yp44qYysALHSE0f/n4vnYYn4CcIP8kZVplMnItow6QNZYKeim6+uZvkdhDgiOnuH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11797


Hi Geert

Thank you for your review

> > Renesas MSIOF (Clock-Synchronized Serial Interface with FIFO) can work as
> > both SPI and I2S. MSIOF-I2S will use Audio Graph Card/Card2 driver which
> > Of-Graph in DT.
> >
> > MSIOF-SPI/I2S are using same DT compatible properties.
> > MSIOF-I2S         uses Of-Graph for Audio-Graph-Card/Card2,
> > MSIOF-SPI doesn't use  Of-Graph.
> >
> > Check "port" node when driver probing
> >
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks

> > @@ -1276,10 +1277,19 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
> >         const struct sh_msiof_chipdata *chipdata;
> >         struct sh_msiof_spi_info *info;
> >         struct sh_msiof_spi_priv *p;
> > +       struct device_node *port;
> 
> If you would add "__free(device_node)", you could drop the of_node_put()
> below.

Yes, indeed. will use it in v2

> > +       /* Check whether MSIOF is used as I2S mode or SPI mode by checking "port" node */
> > +       port = of_graph_get_next_port(pdev->dev.of_node, NULL);
> 
> This is actually checking for both "ports" and "port".  If you know the
> subnode is called "port", you could simplify to of_get_child_by_name().

Current dt-bindings Doc is caring only "port" for now (because it will be
more complicated if care both...), but sound might/can use "ports".

Thank you for your help !!

Best regards
---
Kuninori Morimoto

