Return-Path: <linux-spi+bounces-10839-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 65395C0BC3E
	for <lists+linux-spi@lfdr.de>; Mon, 27 Oct 2025 04:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DE5E934AA96
	for <lists+linux-spi@lfdr.de>; Mon, 27 Oct 2025 03:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEA3155326;
	Mon, 27 Oct 2025 03:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BjO5pUtr"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010011.outbound.protection.outlook.com [52.101.69.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937EB4D8CE;
	Mon, 27 Oct 2025 03:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761536382; cv=fail; b=GMPuw1rldBxjnJwh9jGb4EooLnn5rsfmx3WLUvwZu23XoBMAGsEZhx+Tpt16UUdLz+bsJsZ3l7lK24EHh80v75aHXhhOakNqMDkU682JQM6GbY6oVhVUeFAzUczdojOFgta5q3i5jl8lUxP8NV0qJOotN1a06kluma8HMRvNwD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761536382; c=relaxed/simple;
	bh=oWIT+fbMuFKqQukbxia5Bo5VUL50mLqILNaH92UF5rk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yge9QcMcbQcWtSPGgRB9GztZMn5uTZI3y+OmdAsTOGTz4XQF6Mbeg9/Kco+TJm1+oVKk25sv2f2rJzfkAFU/C7oXLmipWmdhb1fEljEEkkbQ5m+vzhxs49n4EZChFn7zDhMC1Ntgw1iecKWhRXuhprwAZuiIEBR7YYipC9hRXAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BjO5pUtr; arc=fail smtp.client-ip=52.101.69.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FPIeGQZ2Fk/PNk9nElyfmrXclXQn86bl75tpG7xLsPPnsa+yBH62Dq098NjyDj7PPAm4FANZbTYhRUDeg9WBxVQQmfj8vOKCMhgcroUZqOacr2sm8XWDMqoBvhVkm/cXLE2YshDb2LLW63uHJZy6r44vRfiiRQyD93a2oAGmBxurgvYjfe9GYHzHLwuXNkX4dY31OF2gHmfd9mIVKLIyBc3QaKdrEooGHJBoj+81lceLn3I1Yg/ayTnBEE6GfmZGowblHMdpzCn3+v9w1txP5X5BKn2Lcg4zsOSr3o3PNeyVKGSgwsYzDkyWhY1YIk1HFP9nA1sBLnrGyogz6KcCSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONJFlDC9ZvZONra1GTc8Tka2XBjTcomOJig0XwL4fZg=;
 b=lyjVBWBHQUTQGf+2855dwG/Oo0hm+KnOfAUn/OSvxanV87uwQLgwYxCI6a/5KNEd/jSzk3XqSm8pJx/7K5QQ2bb+DxC8CRVVkargM578pCfpmKvceiwZ7To3fZgtoUsiXk7YvtslisOaCK3k5bNd4aXUYSu5X/vDZmeI+ws7bjLYrd8QYzpmKqO3UNLJB5XFFcBEFpFl5pUQupx+4YWxw40zAZq6JQvftz11caK/ptC7vsYevLMDOOIntH2uD7uUXBttf7/WS+xmNeQAilOwPZefLwI4aIKhOyWtff3jLglb+499liWY+0q3MFsWardRUUlbsOUb7zgzMbyb32OV4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONJFlDC9ZvZONra1GTc8Tka2XBjTcomOJig0XwL4fZg=;
 b=BjO5pUtrkSK3ZwrkpO/K62gYmM4jRaZf8iT8qSImHLsvtbE0qi8Www182t6DRrIWzuugu6qMZXblpey6jAaUxcBau9hdGTKZG4K5ieWlmLnN1Z5Hw+hsCkAISjD3A1Q6tME3IZGimN1uxKxM4EA3AgMnJJGeg/M6QSu2sf9p8n9zJPnwgU9pIugiN0rGqzQxtEKNUb7MPNcMBInAVUSWxarVRDoA+CVwnC7lH6n7Pel/0fbq4zbSh+TcsOqrhq3sjUfcScd3nJGcx0ZwtH/xWnbqJ4pAhKroJEIHFxCn9KWIxe2ePuNFM31MexIg9L7nT7lz7iBj/tkF6H/70y6TLA==
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by DU4PR04MB10648.eurprd04.prod.outlook.com
 (2603:10a6:10:586::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 03:39:36 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 03:39:36 +0000
From: Carlos Song <carlos.song@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "mkl@pengutronix.de" <mkl@pengutronix.de>, "broonie@kernel.org"
	<broonie@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PACTH v2] spi: imx: add 16/32 bits per word support for target
 mode
Thread-Topic: [PACTH v2] spi: imx: add 16/32 bits per word support for target
 mode
Thread-Index: AQHcRNm/zRpEV+zYiU25ok3CqsF1ObTRSXUAgAP4xlA=
Date: Mon, 27 Oct 2025 03:39:36 +0000
Message-ID:
 <VI2PR04MB11147AB20690F99BB6CEE2300E8FCA@VI2PR04MB11147.eurprd04.prod.outlook.com>
References: <20251024113107.513604-1-carlos.song@nxp.com>
 <aPt+JJhaB9dUOwL8@lizhi-Precision-Tower-5810>
In-Reply-To: <aPt+JJhaB9dUOwL8@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2PR04MB11147:EE_|DU4PR04MB10648:EE_
x-ms-office365-filtering-correlation-id: 1e02baa1-8107-49b2-65e9-08de150a7379
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|7416014|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?kuO/F16QelgeKWctF24gNagvszMym3OOWRI2TFOWJ5/6Oe/PWACUuymt/0G8?=
 =?us-ascii?Q?903aoWWADbWwx/H/4Q0aCMCO7wp83uOOqfQglEgyMK/0POvYVcv7V1aw7sZi?=
 =?us-ascii?Q?2YAe8CMOaI8zOA0B9Vb1/IE3tCCLVwTiDbKevX3Qdn8pkLZEhWrPXpOIGtvQ?=
 =?us-ascii?Q?70KviYjmK/Ion8eDEYiL2iv6J2xMVgDL4s2Cgeg+EEWhf9rTQBGxnJMrDuAN?=
 =?us-ascii?Q?Mxpe37hNuKKYFOL9oZAEjZGBWyLpHoC+6f2P+6yxIUHgAsA7jaiKVvX0BTHM?=
 =?us-ascii?Q?rJszZIVUHOSyppsSZS8V0gehQwU0oNFuqtvTu/tkBywsP7X8W2mntTRaxMLG?=
 =?us-ascii?Q?hlnhjaSUNo62BKkrrRFbIEBajsOkPbaLi+tRZYFeQ4EHD8s6+ubDHaEFJVbv?=
 =?us-ascii?Q?YgKMGnbYZh6Joxh1lKmJRGevT/ZX0sBqXQc+3JM3s3LRJLPfnKmTjo8c8HZZ?=
 =?us-ascii?Q?GIvbmmhllPjE2Qfm4f39FOfDO/qMYSOwlQmtHqqshDl1VRrDLs95VWgOmWjC?=
 =?us-ascii?Q?MCPeW5dxiB8skyCUcTY5nXz0JW8GF+Qv328UVbLDnWgfbliz4FTcrARmEI2W?=
 =?us-ascii?Q?BF558sYvRgF4ZheRVVXrJf6ugwfMmWCyrmoOEvd4u2CBrhshVXCjapNePtU8?=
 =?us-ascii?Q?e0+/+YtA0yZ3snF02CQ0tvrc6bg/6ooTgH4SCUxlh5qqBZeBJ0nwk50tIBw8?=
 =?us-ascii?Q?Lok+2Il6Dc774hduGjp/4mqdR0eL35QywZtMWlvNMlTUoqsQ9oeq3zX53eGD?=
 =?us-ascii?Q?z92o97J+v5mSwHYGgrnfWnYCpO35IqBCUj2+P1U8zd3szbuAg/36MkyA81K0?=
 =?us-ascii?Q?zXQj6tbO5oSu9AcAIcFxbtW80VkxfevToly87LPEabX0yQCeTp9tCYbhnu0y?=
 =?us-ascii?Q?zFk5XFUF6eZ5OGoF80TbmHPNfh3+Qcq2/KnGqJzScHA0079ZhWnBfXdHgYOq?=
 =?us-ascii?Q?ptJ8Q9G6S0XX7/0omzYQWREmqUQcaa59d/d610Byee17NfefrPgVZAjwcR4+?=
 =?us-ascii?Q?F9zBWKvu3l3iDpwAIF8+Qr+0RQBleVaJ00Wbja45oDR6LgjXCUlemMLY35I6?=
 =?us-ascii?Q?3UnYOqVxayVhb7f5llFomUK3iDfF21ncSyPv+ljbQE3RNla2fyclhSS2fzc3?=
 =?us-ascii?Q?CJ6833w2XKfPQmwuWPY811nxIL+1QUk6Yps9kHkkCBay/h10dItwh2hwt5nu?=
 =?us-ascii?Q?x7jBvOQ85Vp+5zsmtnuyuRRAckAeVzrOqKITa08MRAIuuvhxKTu+AkEsl6rA?=
 =?us-ascii?Q?bdCxtvX6ej6h3C10SZnOQizvXnAiuz4EQStszLE+/zLR3ajVDyinO5V21oWZ?=
 =?us-ascii?Q?fRQHL+tXUtiUnUVa58guZpZRmNN9jQjhG6LUqZcj8Dqz2XJ2sYBsCs/Oukak?=
 =?us-ascii?Q?QnSIx4AH1Xrx8cYoJpHhGJSVXV75bm70jLk29PnDysBTrAab3P3dNCKcWw62?=
 =?us-ascii?Q?wv8xuzUhAzmUZXBJJFnc+jLYJw2UUHP5beoi7iw8keXYVWpKFyjN4ymmMzzx?=
 =?us-ascii?Q?Y6sa38BAGxD8w4pELL7YU1okUnPIo+4bf/r3?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GhiC6jZkGHxoQ/3lrUumY3bmENwAQRvNn4JzEaVrpi4dotEVX4EAsvZsB12d?=
 =?us-ascii?Q?IVM3Ptmh4ROgeOHp4Jja7dvtNCgiB5xEB814l0OWGsg6qIsLIKeWgitqGH0L?=
 =?us-ascii?Q?+BgTnTwGD8tB1SfcW9s+qTi/DakeT3IQd9NFCsDKZHgsHpuMZFTQUrnaeFgI?=
 =?us-ascii?Q?kNu8kSFv9B7n7dNZ7pjd7kAKG96g4JSGWfcndZeUgqC60YhvSVbn3m75SL5P?=
 =?us-ascii?Q?STgdsYZLhz2utWp/zZ17YlJHXkIoq5FbbtEkJVxUDFffBejKGfrK9ZSelZCG?=
 =?us-ascii?Q?I1IqI4oUN384RtsDJeXX8L6NGtON/8mrKp293feCCqL8wJQJT9cszKAQ4SVi?=
 =?us-ascii?Q?z18vFzR9+4X8pwMdSgQu8DYxZg6SB+Lh6Kt8lOnLsGZ6jl8wOC+2bMkCyw5C?=
 =?us-ascii?Q?tqWVL4MABqFHJH1Bx9gPH//2OgPMiaX9lXpY9N9gbeEzIRO+FNILrha0OOyI?=
 =?us-ascii?Q?HNb9kcCrGm7KSdyD0pRZW0n8cXdShBhtPf5IY4aE+1EGoVgsmevdc4a6NO4k?=
 =?us-ascii?Q?30POgkBeXzaOPumSx3NHzHDQtu1uzPGjruZfgqlKJyvPEg+gxJGguFK8Tsoh?=
 =?us-ascii?Q?gKQJ7SB8s4ULabfNT/iqUMM3yW0iGsXMIgzodCYXi7jstY8KZpAowFOs9mLn?=
 =?us-ascii?Q?FCKc5vpefC/YIAXxVm1iBkCQftbfh596eJXgfhbPHy50EYOSmRRTA1d0L8aV?=
 =?us-ascii?Q?9VKfq5WboX0h184r3TMdmavWDuzLeOXCYY9JCIN5UGaBWPNNCEpx0Fo8kapw?=
 =?us-ascii?Q?j6m6+S3TB22sLrd7JCxcYudU1eppZTgYrShE3jLoUOz2nw7Knhx7MWS5nJzv?=
 =?us-ascii?Q?yr0VaSYJdCNjEOntvde6Bg48O+qHGAc5JnOa0hN+AyBng6XXUUytkDkRFaUw?=
 =?us-ascii?Q?HVnXglfrFUIQsgEDfrpymcuz4UbvTyp5M26MO0DfAk/NvzugESfSEULw/U6r?=
 =?us-ascii?Q?qB84g3fDeUz//gzqaaxeZuqZq2COnnlna6o4GFHVxpSLLfCdRTWIxpN/92BX?=
 =?us-ascii?Q?of/mRRMDTOR1aqIY7ing6Dw/JQrdRy09qAPmIwVqWz3mYkflgZzfGJ6V+pRU?=
 =?us-ascii?Q?XF038fyQtGXL4LFWWZPR5eglnqHbQF4mkFQfKmotnLpNbXzkLvyRkKZoj2K7?=
 =?us-ascii?Q?F2QbN/2dkCqKSJf6e882bzpHW2ynE1lw/vgLyMJ9LR7pQljfmylUVm4thm8s?=
 =?us-ascii?Q?tRmPXhZTmCZGpe7Mr/PtjSHnpjczkiOh6fq37hXCI76op9NNnURG+knlhQKO?=
 =?us-ascii?Q?4Jo4WH2hTFoom+zgPQyA5NeW+mZjav7xZJDt0Do1HVBeB54VmdemWFvOQ9TL?=
 =?us-ascii?Q?/sl02myemweb2qyJHwla2jU9HdZj1MdC+ym2kbNRiLFuZzQYDf1lQzAJBrYC?=
 =?us-ascii?Q?eWtS920IHUZGDHJNEhritscyIjxBgXFCoPYB5jPvkuXc1trJyK0ZZqFojWrq?=
 =?us-ascii?Q?Pkravfw8RADYG78uYif+ESefYKTE5u4xXg9RMNBBCkIVZ7P595a6EU8rDhFX?=
 =?us-ascii?Q?G6uwqlxh4G5wuspv4ETAfvicyeIucLU9Gt4sSjnz+WTU7Tib+xqu2E0QIXrJ?=
 =?us-ascii?Q?osO0CARuViRDMCgfD+8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e02baa1-8107-49b2-65e9-08de150a7379
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 03:39:36.4135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mbFl1W5gJRIqk4Su5yjC7LJUtCRLI3fNAjC3hP6G/8sKu9k8KeZe2LrXDiXXPfqueOXVXD7XBF+9hXe6PUyuPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10648



> -----Original Message-----
> From: Frank Li <frank.li@nxp.com>
> Sent: Friday, October 24, 2025 9:25 PM
> To: Carlos Song <carlos.song@nxp.com>
> Cc: mkl@pengutronix.de; broonie@kernel.org; shawnguo@kernel.org;
> s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> linux-spi@vger.kernel.org; imx@lists.linux.dev;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PACTH v2] spi: imx: add 16/32 bits per word support for tar=
get
> mode
>=20
> On Fri, Oct 24, 2025 at 07:31:07PM +0800, carlos.song@nxp.com wrote:
> > From: Carlos Song <carlos.song@nxp.com>
> >
> > Now for ECSPI only support 8 bits per word in target mode.
> > Enable 16/32 bits per word support for spi-imx target mode.
> >
> > Signed-off-by: Carlos Song <carlos.song@nxp.com>
> > Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> > ---
> >  drivers/spi/spi-imx.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c index
> > 155ddeb8fcd4..017f83f5dfdf 100644
> > --- a/drivers/spi/spi-imx.c
> > +++ b/drivers/spi/spi-imx.c
> > @@ -424,8 +424,12 @@ static void spi_imx_buf_tx_swap(struct
> > spi_imx_data *spi_imx)
> >
> >  static void mx53_ecspi_rx_target(struct spi_imx_data *spi_imx)  {
> > -	u32 val =3D ioread32be(spi_imx->base + MXC_CSPIRXDATA);
> > +	u32 val =3D readl(spi_imx->base + MXC_CSPIRXDATA);
> >
> > +	if (spi_imx->bits_per_word <=3D 8)
> > +		swab32s(&val);
> > +	else if (spi_imx->bits_per_word <=3D 16)
> > +		swahw32s(&val);
>=20
> Needn't swap when bits_per_word > 24, like 32? or our hardware max suppor=
t
> to 16?
>=20
> Frank

I think we don't need. We are reading/writing FIFO by 32-bits word. In this=
 case, we just need keep
the default byte order.

Is it more reasonable only support bits per word=3D8/16/32 for target mode?
-b 8/16/32 can cover most use case.

Carlos
> >  	if (spi_imx->rx_buf) {
> >  		int n_bytes =3D spi_imx->target_burst % sizeof(val);
> >
> > @@ -453,12 +457,16 @@ static void mx53_ecspi_tx_target(struct
> spi_imx_data *spi_imx)
> >  	if (spi_imx->tx_buf) {
> >  		memcpy(((u8 *)&val) + sizeof(val) - n_bytes,
> >  		       spi_imx->tx_buf, n_bytes);
> > +		if (spi_imx->bits_per_word <=3D 8)
> > +			swab32s(&val);
> > +		else if (spi_imx->bits_per_word <=3D 16)
> > +			swahw32s(&val);
> >  		spi_imx->tx_buf +=3D n_bytes;
> >  	}
> >
> >  	spi_imx->count -=3D n_bytes;
> >
> > -	iowrite32be(val, spi_imx->base + MXC_CSPITXDATA);
> > +	writel(val, spi_imx->base + MXC_CSPITXDATA);
> >  }
> >
> >  /* MX51 eCSPI */
> > --
> > 2.34.1
> >

