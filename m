Return-Path: <linux-spi+bounces-7504-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1454DA8393E
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 08:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A8D3B84AD
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 06:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72C9202F8C;
	Thu, 10 Apr 2025 06:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="dMCY+eWa"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011056.outbound.protection.outlook.com [40.107.74.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BCE374D1;
	Thu, 10 Apr 2025 06:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744266549; cv=fail; b=l8v5GGFOe5479SmOfve0uaue7InOgXEXxMa6ydCw6MC7HIH1nyVfTHTT05CUCWRHmDeQ9FcQa6r5aSwHrD9M1DAddo1dd98Gbek4bgOLcuzvD/wSm8jaDwxEqwrT/DE9Rp4y001lFJ/LEYeiSd3X4Z5+n3AEu61DH+uK0B1oscM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744266549; c=relaxed/simple;
	bh=dnHJPOedziwl65+lHRceHWy3hIM6YzssgCFcyHSDw9k=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=apmT79JvKbbgtgHwadraYzCmZZZVA/zaZklDSfVlplzyqMO41HoRAv89IBjfoEPL3GSR6EuPiDp5kHCktGZ6KPlZ0OLPqSm3IBRxUQYpcvsPTOtkLwfbncAkm9DsOEMIMEV817j2QSfUnDjUEMG3BdxRAd4W0SdleJiFT4+Ck50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=dMCY+eWa; arc=fail smtp.client-ip=40.107.74.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vMLm7YiKx3hEJWMOitkWfPTS9dxL3vijPVxGpLhilO6LilgTCGpaNf90E2pGy9ppQ7FiJvLqcIaTqbOiTXJG8MMToW2xnXl9ugiTaOpLbSgkXxksZSJfOkJFX5olvjM3jw9PmICAXOw7vcL8bPLXk1NQNO8rwmM6YVnuNdGvOaT3U9Q8G7sR/fYKN/3m+oDFa0TNhxEryHGXyH8Wn5y1mjhsFafdrg5CpAPLE/CQS3t613O/xO5aHv8vx29TmsxZlnOSMjpHl4yhBQhnltE3K2ouj+kE9+mn9ioc1yKqXQ+H2bbd9migZFP+1XU+wvQagMD7Z26w1Ph4WEBOOjfUTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uToo3k8cGSeTaB1Of+1tpIRAXfhMaM4O55ei0/avy30=;
 b=As2u0WKm5mGQukpQTI9atwKVR9Iy/S0BgXHyR1UgZixOURP1KXRXzxihokOCixldKPhqO87D6DLyJbGz9esdiJI01dXL5xEDBColxUdSd42WXvZsp9lt31kdVQOid4yz4XC99gmcSiIqZLLp9TLGh3fg6lI5FCb8XP72q5YfC4RfgUdjDmiqdlVJ7cBktw+0SaHucEx68mCqWtz9Y1FjRZMebFC9MVlHiVMVNMjLafVNizQLYqVrNnXftECycRiCEs/wgkjH1zN/4zePYDnOaULA6ZuYAm2+awG7T4xxH6cGLW17MCChS2oPuELk4nFpT++toD427xarts0aYaQazg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uToo3k8cGSeTaB1Of+1tpIRAXfhMaM4O55ei0/avy30=;
 b=dMCY+eWaD34zoVUE9QZh/mFk5lHd+46/wsJ/bUGEuIiYcSYfpMDGYPCgbE/SDYH0+ou5OSlh9qwx6cp5QGkX71u8qvWGN5umzt6g9MxSyTX4Lj1odXD+do40ryPTGau4I2VrxPKiwPTuhyxW1WfyP1uh/8I4kDVsCY3gO+jP5lY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYYPR01MB12941.jpnprd01.prod.outlook.com
 (2603:1096:405:159::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Thu, 10 Apr
 2025 06:29:00 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 06:29:00 +0000
Message-ID: <877c3slec5.wl-kuninori.morimoto.gx@renesas.com>
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
Subject: Re: [PATCH 6/7] ASoC: renesas: add MSIOF sound support
In-Reply-To: <81e496d4-7643-445e-a274-e28add84da3e@kernel.org>
References: <875xjeb0wu.wl-kuninori.morimoto.gx@renesas.com>
	<87wmbu9may.wl-kuninori.morimoto.gx@renesas.com>
	<24d1c5d9-0eeb-4f59-86bd-cd3690145981@kernel.org>
	<875xjcnci6.wl-kuninori.morimoto.gx@renesas.com>
	<81e496d4-7643-445e-a274-e28add84da3e@kernel.org>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Thu, 10 Apr 2025 06:29:00 +0000
X-ClientProxiedBy: TYCP286CA0164.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::16) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYYPR01MB12941:EE_
X-MS-Office365-Filtering-Correlation-Id: c740f7a8-e3ad-4b47-f3cf-08dd77f8faf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p6hXbJvREkvkjLwOKnJQSqA7QHEd1s4vjkzis7gLshJ/WhGXSZfn9JmSZwWl?=
 =?us-ascii?Q?spq1BxM4dEjjPP2TX8j3Jhnwj5+2+3WCsBNPxPspGDHLONpLDzr1srwDk0D/?=
 =?us-ascii?Q?JaovyH6tUZNkFZYtgAxKKTEJRO8MYuyFxK3kMLPj5JxEP9YWuCsA9Pn2+cUR?=
 =?us-ascii?Q?Y5mnRpme1IYoCcT5xR627Bclf48X5+6vvgHRm8ZHmKJwSPEBLzOGsY0hv3s8?=
 =?us-ascii?Q?ETFe1h7r/f1gro6meMb0YO2fO6X1WnJF+3LyjsRstYy++QQI7D9RQ/Oeqblo?=
 =?us-ascii?Q?pViisWn2eOoACUYQeE7ibA+s9pmg7Rl25JZhjM0GN8qCAWrtwMZ4BHRwfygf?=
 =?us-ascii?Q?20EV7U2gMn3IerHMYeMYvakLlloe9iMtkUvfSkOiKzYxCuvi5JMfi2yq5vAv?=
 =?us-ascii?Q?FcDTaG2K144T8QGF1usUvhFvxyRd69mebf1HWBD/FIGlzkKYNavLa5V4K0LB?=
 =?us-ascii?Q?VZsiVK5ESEoCkigOsyCHe3uiVLhS0emW1tDlOs6cinDHmrprGqU5csPEjUj8?=
 =?us-ascii?Q?xzWIqmvkDkUi7UAaDXoVtyVmAF7NqZOrgK/zmSFow0Gi9aLc2Cc41fnmqCen?=
 =?us-ascii?Q?+APR5F1zwSN8xH/E7cvg2wxLYHzTGiuV5tU2i+vXQFJdUayjBzSd/54uZd+8?=
 =?us-ascii?Q?otwQUFutTmLECMWYnIUuj/jE/aZjwwvYrFWNFry+s1CX/SUrtfPsGsFbmwIU?=
 =?us-ascii?Q?+DoDymPh9F+lxfHDSB5SKdfoVswzP1Oo+HvQWwHDi50+mFL3URZDgw8n/Okm?=
 =?us-ascii?Q?hFS9m6f3322/p+9n03bjxVDDeJw6uWLt+4Mlkh5vsz+yL8da5ZOqAJOn2OPR?=
 =?us-ascii?Q?DOAWtcraOO6A/bXQlqil6L2GVcwY16fSJuIqpRmTpvfJSfMpjJpbz/bXYyFk?=
 =?us-ascii?Q?G5lj5DGp+1tBJYuaExgkMHQxoChNX2Y8WRMISKkORWX1Oqeo0eJQfi1uTr8D?=
 =?us-ascii?Q?AlgVkNlMCeGLeej1iY7kl+GQjQvBNMjdclNs7WOjhwmt4lS/CtK9TXaViehN?=
 =?us-ascii?Q?Uv0Njv4BAredUVBeAyto6c5G45fHmK85/TAjCAtf5Zl383TM5U0+PEdPKIwa?=
 =?us-ascii?Q?Kpp/uF5JE03MZD0n6cF73djURhmSAKf4WqhXtiIZ96mHeozu6xtD5lrrNlHF?=
 =?us-ascii?Q?6N+gMDuPZ29S9zOZKZoJKi7INSfJSOJYGK7wZCUAaoi+5l5fR40NolstcxoH?=
 =?us-ascii?Q?1CegWHLXb0XKIETzTTIH0tnmlsNBEO2EqEG6ci+aWJ51FwhRnrCuRgJF33EP?=
 =?us-ascii?Q?c1XvL6frz73G9BUpcDW5qI1fgZlnB6scFeAtAd0fchVAPsHzqgRVbYfPNLB6?=
 =?us-ascii?Q?z7YFHbGLdepF5vyBQD3yflM1b/niFyzW9njouf+LAkCwyywm6yO0tt0Rm+Ob?=
 =?us-ascii?Q?v4Rm0FkV4+Gqlzxl7wXctPt4e7x+Wn0vUNR5JXefjOVlAVFwagxzWL/jG3AE?=
 =?us-ascii?Q?KOqAruN72ksl/Jc1obLRuTZBZKUehMK/9p3RrTK0h2HnN+yS1U3my9/fMMgT?=
 =?us-ascii?Q?gt56cd4xosPO+xM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xvUijOSGF4FkTPKPx0OLWs3ep5rDbNA19OW9Fr+Dets1tIGwKIsGAHrSIa4c?=
 =?us-ascii?Q?i8hpV7evp/UzOuyMCTE0m1anXDfQ3FMkQ+08veSHam04PKjN7lInloXXY3DF?=
 =?us-ascii?Q?qhzbJFry3QCFwHEe+QZeX0ls9F9dXxyVmdgdecRa0E8wtVLIHdj0AG/hJi3b?=
 =?us-ascii?Q?ybeUbJ7XZhucP740vCkcuv/p70+HNkPiK+hX38UZlfth8Amvjjs9RG/8YMo9?=
 =?us-ascii?Q?6CeWNBoXMVzysbWqfYfPwXppJ4bqPJnGz9k80o1wk8ComsPHmuNjP8wITqlJ?=
 =?us-ascii?Q?A86hLw/QiovScMo87T16bvmJXnq9wVHChm+okzK0mvNMZ/JrQ7iUj0ki2CTy?=
 =?us-ascii?Q?eqIzeSupVhTjLbHtzaM+LxdeeWxn9NcvPJ9/NiAaw4UADl+L6nPRhm2uvzXP?=
 =?us-ascii?Q?vOz9M/4WeSyrjsTr2du5mWMs6ZOBwPtabKvz2crAh+AO9JHECRYdVTYoVKx4?=
 =?us-ascii?Q?AhVurLdQv6d0AzA+tpiS9b6e5ZUw6U5hPy6PrmtQ7csku27DyUGnwRPNkfsi?=
 =?us-ascii?Q?UEVdf9tYMyl0ad7sc+kgGmt5uilm3HqFUeTlaD1/XF2HwSZ0oLvIPel98SlV?=
 =?us-ascii?Q?qCTx7LGgS2bazVo1o6OmOt83UFWIxa2OfaPKgpUUYWiJa1l4uBBN04p6ZStP?=
 =?us-ascii?Q?VDn29o3/rIJNRDk21gC2DmR1InyphNdDau/FL6mKq+BEt9F9lUSRgTn4/VmI?=
 =?us-ascii?Q?vD1ZMNk20b8UlX+hzaHskLtYZF411Vjj5rOpbXHprSpmk7ZFHCgD5vmCn1BQ?=
 =?us-ascii?Q?tU55blHyYNzf9kJGxkm7T4D4nR/rLxTJ/ZUcBYpKgxqRyAEplIB1Hl4oBKpl?=
 =?us-ascii?Q?+vP5iZtZwMRw9oYYRRADWwlw8LA6vtjst7Nt1MZnL0z9djmR0OrNIdnK6OXB?=
 =?us-ascii?Q?0ehztankgC3JAeEBW4Q2wUBc3S5liZLSF4++aB4CXJqCa47EF42RAdUuc5Pd?=
 =?us-ascii?Q?2kw7QMoBC+RcEhz9TcvP8cf9vBS7fLlbXSsAXuoxjkw16lCco9WKboElEJpo?=
 =?us-ascii?Q?dZZEqtssspx5x82XLDXcceV4D7SRUyDs9VHv7osbPWwK96BLy0N4Tni40dAA?=
 =?us-ascii?Q?poM3HawCE608NrbbOY2DwnqDxlam3VmHBe2b9I731X3cDm++CR7UAGDD6iFL?=
 =?us-ascii?Q?9JpTFoEmTbxVIRt+S6nNd2MBU0cToQYXYpPYP33YinvMEvEtHyiCsEIX/bGT?=
 =?us-ascii?Q?zBkkACYUOOvLHAomaqa0vjzLgfdXSf0mYWtmXsGWEJ20aUyQknLNNiEUPCZp?=
 =?us-ascii?Q?7Rjgsl8uASdhl2IoZDDOj3TR8rz02PBLNkipJqs81cwnK43K6j0EAhjwtL95?=
 =?us-ascii?Q?lgLe9eXY+fiPmVIeupzDc6MZQ8AkAgvhMYBm1qnbTlL67+Wu12fYyUJZrF5f?=
 =?us-ascii?Q?WqlUJ1LhxeN0cMHpvJKRmCVfG8twRSqmYBLG86WqF7sm/nac6MtOXqSJiWYX?=
 =?us-ascii?Q?KwwRrjHAb8G8t7Qvt65tRM6st9VWgEnO+pSnI/0TpisKSHR6mbH1DhpCw6Is?=
 =?us-ascii?Q?Uj9XbfKAP9QZTdzbQ8RJiC/SIqC8ZOil0r9FLaAmmvbAUS7j0DofQzxhoJTN?=
 =?us-ascii?Q?dXH5xHzbIp2GqPfOd/GSiyKopJhPqerPlDRrI7TTB34358BHgYk5ZJGgDBaR?=
 =?us-ascii?Q?CTr4TGAUrdZU7TxG3p3lLt8=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c740f7a8-e3ad-4b47-f3cf-08dd77f8faf3
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 06:29:00.4108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VsRawK5ZyY5ILFSZaOvtADqQVx+I0FRG1l/+20EdCnK/BGK/os2ORa6NDg9KDd5Ns8nP+2pDoc3gJtHUVapsi8xR1C+bVORSzsfsL+N2JMbJGbttu5lVpyrq6BdvWI6c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12941


Hi Krzysztof, Mark, Takashi-san

> >>> +MODULE_ALIAS("platform:msiof-pcm-audio");
> >>
> >> You should not need MODULE_ALIAS() in normal cases. If you need it,
> >> usually it means your device ID table is wrong (e.g. misses either
> >> entries or MODULE_DEVICE_TABLE()). MODULE_ALIAS() is not a substitute
> >> for incomplete ID table.
> > 
> > Iwai-san, Mark, do you have any comment about this ?
> > Almost all ALSA drivers are using it
> > 
> > 	> git grep MODULE_ALIAS sound | wc -l
> > 	249
> 
> 
> What do you need it for? You already have ID table.
> 
> Just because drivers need it, is not a justification that you need. If
> other drivers have poor code, it's okay to do the same?

In my understanding, it is needed for userspace (and the macro is for it ?)
but I'm not familiar with userspace.
Mark, Takashi-san ?

Thank you for your help !!

Best regards
---
Kuninori Morimoto

