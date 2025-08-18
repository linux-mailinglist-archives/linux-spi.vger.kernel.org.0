Return-Path: <linux-spi+bounces-9515-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0E5B2ACF4
	for <lists+linux-spi@lfdr.de>; Mon, 18 Aug 2025 17:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D231C6225BD
	for <lists+linux-spi@lfdr.de>; Mon, 18 Aug 2025 15:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883DA25B30E;
	Mon, 18 Aug 2025 15:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Rj0AJrcM"
X-Original-To: linux-spi@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013054.outbound.protection.outlook.com [52.101.83.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B002258ECC;
	Mon, 18 Aug 2025 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755531555; cv=fail; b=YIFLfxP9/IwKt95xP6a/h/URQpR9XwQrUygE1uQ/Ah4jVeDxU+AI4XDnBFqiCWogfCLtwYOz3oJxAOc5A4ScfllcNqbTq6KLehIFNy841EQh7W/dLC0bwqjRa3t0jtvwqUYNXfDoxzA+NqCIuvoAcYQP3TW60Rn2+qqL7sgFtu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755531555; c=relaxed/simple;
	bh=hIr0XBNsb5gQoYiWDu7io7KL1jj6tM5/9LblAwUz0Jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DNd26GiQ6gB8ujcXTbNrkyul6aonp5nGt/0SiAGNl4tJ0g+Xn/dxNGJGF2hsU1NCA87QqaLiYUQ1zOjOE56ZJ0h6sFvHHVta4f2lAgZpPgXkNT6HHz3dy+gxiSDjvnG64kGDH+afXjwD6gUOiXWMOxA/IESL9xcXwLg7d36TqZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Rj0AJrcM; arc=fail smtp.client-ip=52.101.83.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BwuSGjoVDFGdx+BjaADst1F2nODUw02ImtllN6yTXNlnJunYjbVf6vF3tKXvp7W2VT+xTPivXcuf5J/b0a9ukAbvNGRa1slSbla5cysOB9zFhtTLRsRwiPP8jbRSV89AV1ba0zyFPi72cTNbumLntja6ZfP1UM4XYj7QrUmCV7VJSBu5/pjFqQCFZhqGrj8sBozoAsv5SIcYa71ajCXsROErAO3PA3EGcPhN5Pj0AWR/0y/OnsybU6eEPMwA0mCm3soBWI7ddoOQx2rxq7JrLadtzMlk9ftwSt+r/vCH2Jl3v4zYjsf4S/83FHMzD15bAVXPE5aYDEVpOmy9qna3Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3z/0/nTtBTQivbimKtrUkCwPGATMG6kvTi3K3RbRWjA=;
 b=Lvjth5O3IS8vBTCvuONhfKCyl5LNCtv7hPqduyBNrME6MeazXOyuFR2IeEiQG7P7eb9B/JTHf2FOl7CFRVHy5q8gcUKLjNVM+165fNZNThvSAm4dycodXbyCKq8bLZh2uQxYniqPMf0aHepWp85XjA4KWJphpgN2B5b5n96IU1P6pCFMeJ7vcXLXzBS+tHm+mBJ29ZrfCfMAj9QyUdR2WqDQcA1ma8bD03sw0P6tC2jzJxhmkftq79j+bF76/EdUGQf0+0iWCYvw2jyZR4FyynyG2UZjpHF9M8nKDZNpv+Xdyfda1E7ze7AplwzII3zhV6Gcy9uJA7lQRNLYhUH6cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3z/0/nTtBTQivbimKtrUkCwPGATMG6kvTi3K3RbRWjA=;
 b=Rj0AJrcMbnOq6FDFtyxU2A9O97fKIljYfcuxxMcCc21nhZe/FVsPSquLM7UYBLfAEnczuLgltvlfWtGisxD1xyO0xQehDYM9unbRIItn3XuTTHsyXWjFEmfnbSMK7iNUqN5BCiE8/5VuVneN3GNXDqEuthkA4fO4ledxwDLHFISRzm6Xx/CUpNO1vw9TUU7S+D2IGrumS9heQsXDsbvAeJfwD2cQMpKbfyni0g7QNSV4Gr0YhBS2zdO7lDMotHAbyP4/7ygIZTovmKYNwp7sEAaNvoSudFoLGJyHuFWMz3fjJLggWRxUrjlUaXt+RLHSgWk90VNrzEec4p99TVYR+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10205.eurprd04.prod.outlook.com (2603:10a6:102:465::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 15:39:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 15:39:09 +0000
Date: Mon, 18 Aug 2025 11:39:00 -0400
From: Frank Li <Frank.li@nxp.com>
To: James Clark <james.clark@linaro.org>
Cc: Larisa Grigore <larisa.grigore@nxp.com>,
	Mark Brown <broonie@kernel.org>, Clark Wang <xiaoning.wang@nxp.com>,
	Fugang Duan <B38611@freescale.com>, Gao Pan <pandy.gao@nxp.com>,
	Fugang Duan <fugang.duan@nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Larisa Grigore <larisa.grigore@oss.nxp.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
	Ciprianmarian Costea <ciprianmarian.costea@nxp.com>, s32@nxp.com,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 12/13] dt-bindings: lpspi: Document nxp,lpspi-pincfg
 property
Message-ID: <aKNJFJDf1Clnkbex@lizhi-Precision-Tower-5810>
References: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
 <20250814-james-nxp-lpspi-v1-12-9586d7815d14@linaro.org>
 <aJ4ox8+OLhIir2bU@lizhi-Precision-Tower-5810>
 <bd59344b-9dc0-42bd-98c8-80ab9ca97123@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd59344b-9dc0-42bd-98c8-80ab9ca97123@linaro.org>
X-ClientProxiedBy: BYAPR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10205:EE_
X-MS-Office365-Filtering-Correlation-Id: bc04e32d-c119-4563-8699-08ddde6d5fc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|19092799006|376014|7416014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bPy6U/T1zumXRUG7j8tc3HWa2RQNpz1Xgefaaien4pQQrdb4Da+HiycBd9v/?=
 =?us-ascii?Q?hTdiusBFFgz9AHfyVnQuh0JHXU7Sxt2V8E66goZrrKpnmREhYM/TDuVHi8Vc?=
 =?us-ascii?Q?g0UqbI7eBUgYVEqxlbj9035cCUHeet8Ggt6H2samsMAibg+7h1CspPT5N+Cu?=
 =?us-ascii?Q?+q/InYON6I8V2JqptVdUgHFoG7KzK0krSL4iIiJtRbvI6QI+0ROgwHHqUTG6?=
 =?us-ascii?Q?0Yyyx2jQ2Y2wciRqNxgKpMayYTEQPndLEkaWfTHzSuw7aA/52k9lf5nfnRKA?=
 =?us-ascii?Q?Xc/AIRl43aZ2pb0wGMxoUPdtinu6uHJwlz+E2yM6G/xLKiubWbyVkeoQNHuo?=
 =?us-ascii?Q?Uc6k+zzoo5T75R/2yfWGjIdsIjUPDe7YxsSc8PeJZf+a3ir3pWOTrTFotPfU?=
 =?us-ascii?Q?Y5nAEViYv3oeCWwHWCwL9rm5/DMBX3Tdt3clLNa+wjg6FEl/JVI6HmKvSD9X?=
 =?us-ascii?Q?jsnfoSA4aGm4iF6g6SkvM0bu9+/scShT8Jvl6v4v3MPl2FVxJOG7nXqkrloh?=
 =?us-ascii?Q?wsf2bPqTmJEbgvCGHCpp6zkwUzOiCzmzH/dJKrIEMGDAszM3AgIFsRtxDyqy?=
 =?us-ascii?Q?sifX2gds8G7qAVniXQIHpXf06TgOLI24mrmvuLyA6ZM4wNhHMOZ2VT8cwaHy?=
 =?us-ascii?Q?n5Kn5HzZmW+dUOkGUiQZUx7M5xy1gWx7XBGfoQaKpaB+AhQMVmCtYZ3VhaiL?=
 =?us-ascii?Q?ke9Non2KvfMgkRNb7/f475BQpDS+sX9HrApp4mxYqrqdQUZ4jm42hzkIiaTQ?=
 =?us-ascii?Q?VAi6uVQ55QqTMsMpKpweHTdLYpsuuyzwuBk8URyj25RtFQ8MUwEgzFrCcDOH?=
 =?us-ascii?Q?smRs3SVp8Y0ShI/arm9ARuKrcJ+skYGQ7QfZk+QX0sST6Ergi6XpqsoEkg/Q?=
 =?us-ascii?Q?usSQxilyoGQjVoOU1cugstFA9Mgo+5nwz4QsQaGFtMUjO82YknErWFZFtmiV?=
 =?us-ascii?Q?BYYi1CZD7Oq4S7H0AjHZUacIPM0lbKQjzg3zoEKOb/ojkev8k3zr6ImYDU/2?=
 =?us-ascii?Q?sKQoDUQyHu2oToHFFzsRm4Njrxw4gf9C9FZof6LDRdjzKoDJFbs6kv9e2BPw?=
 =?us-ascii?Q?wBSiZ5t2TZ+ttDHgD4VlVQy/0RaOmyDJGlkYVnVUADSNTzrYojCnS2NdkkA3?=
 =?us-ascii?Q?i4q8R1OXI9KkBdz0r9PxqCYNQIKKsxekeLKV9GMp9HDOz07K1vLTZEhmc+cN?=
 =?us-ascii?Q?s8Wpwlm7Er84hcygTRoOs8MLasKJ+Z1/I4ucC31grR0uMWdDfMgYKIkPBKA4?=
 =?us-ascii?Q?wibO8+6VKNbJABaXxGmIdtfFRyYSL7NDDC3LJD/NhnFHES91u+guzUrNzBCF?=
 =?us-ascii?Q?6P9SgxtKxzYZt2BnObD+5wamSBS8dPaCM1DS2DbmBm//7zotQbkETul+Ee4i?=
 =?us-ascii?Q?rzxB9Cp3102fF+a90MeBgzITDSTEn9DE04nd6g6RSU5HIwrYOfqgdWCMTBjh?=
 =?us-ascii?Q?iDyr8AuFaloR99DnNm7JRUcas+RtzYHqurElghKa7dykGzyd1JnJwA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(19092799006)(376014)(7416014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rwNRtPc/+YzIECsLNV4lGR6O+QEAJCHKwMvl+1LtL4tZyQjDLHw2e31U9bgZ?=
 =?us-ascii?Q?qqSm2e/wd2Ni+QDsWp6wZ4sFoaqv2bIbS4rsNa5Igg+DjtXaTCAI/unG6ILf?=
 =?us-ascii?Q?SQ069Ef6apMjkf/w6iLmJyjp+R74bU0ibpqLtJ+JIkQeVNbkA0FIG/SBzH0X?=
 =?us-ascii?Q?llGLwid2I6xAHIgHUANGDk92Mh5Qg8mh/tLJZDKaYN1/yWSGcf70NdTnVK2Z?=
 =?us-ascii?Q?ioIjkG5B5qhJzxdl4XxaZdzHDC8q4ENH0pzXjwxel2QyotBjlC9uunrOla1A?=
 =?us-ascii?Q?pDT0VxsBjawfmBoPTOqkPyTPBF/Bh4GZ4ahFPpNLHBZC4JAcltoARTawtHmJ?=
 =?us-ascii?Q?iP7CwZfqED8UApoQlPntbOHbtXgwR9HmJ16ztinJwQ0ZMUXnfmVjLMQWL2E8?=
 =?us-ascii?Q?dQQT6apRJZ0gVbBe609XOuFxI9epmiMa7Rl9zVw2yTOep/3TKRBzNVFsSJ4u?=
 =?us-ascii?Q?MXmu30ANLdDEsqe1kTodvuonTGwSTZRv/Yunbf+r2kO7pcT1kMAXSmjzkIcq?=
 =?us-ascii?Q?gXsvXb7tG6KGC0a+nFg1XgWOLrOgjiQmZXEzNCzxJP40KbQiEW65s+DXPCwv?=
 =?us-ascii?Q?ERUU9m0HzKLBUNHGZU/SqxT7OPqswdupx8o//gJRfH/W9TWQ8PAT1izuSDpU?=
 =?us-ascii?Q?yupQDiPR6xGzK8ZgK8qyZaW28sx43ufuM+VGu+RURTtQ2xs6z23VpgfYMlKV?=
 =?us-ascii?Q?xNuSwkjY6RcJ43YBXLrCGcH0tCb6LFVMY/HNeZuYWerk+Wi9fncRmk+yxoYG?=
 =?us-ascii?Q?RncbW9v793JM/m+KN5laC8tfYptuc5GatjrEbhb/mp8AkHIfzfbg9SEFiA2l?=
 =?us-ascii?Q?qDXMVneLYnYXJ1a9rL37CeUgLPlAEvU+nY+mWsREWJqkxs0KXOzx66rp68cA?=
 =?us-ascii?Q?VooiQdmmuxXyImeZTygXccWl1/DevkjgxHPEB9Yv2xhFzx+q/oocSfQwmTzL?=
 =?us-ascii?Q?f+9+JsuBqmDP7k4F8Icx1rRuxn3FKHfBrdfg9MWE/4R+5ajPTUiJ2GIvcHwu?=
 =?us-ascii?Q?QC0c5OLwNtAerrY5F0bG112WpVxCBVi/O56j3TokyqSJi4xr5LJ8UQXB0LrU?=
 =?us-ascii?Q?YZhIUqfMnn6pP5/uDU+chmUKs4RORn3N9Nf/00L7Jnon7r+IZIf+rKQkFF3T?=
 =?us-ascii?Q?YwqtMXVyt6toqxYvk5dFVU20PeurT5KfIQPwcLLJFzfZMWC2JFxwf8KrJnEz?=
 =?us-ascii?Q?Ge/FbXhmy+KiTFBlcNBRm/64BD59RJGChnfdhVcPQdysODOiN9qWrxPzr+np?=
 =?us-ascii?Q?MZ0pIC2bSNTB6CumCq0eTe8ciTrLZI3mYV40S8cQNZOcIyQRXr75YULZUSKQ?=
 =?us-ascii?Q?kxoa7qAL/CSJpOLvBlBDFlPiQwD1lakmfBZeyyUhCbAFy5NQQ3QkLTU8NTVu?=
 =?us-ascii?Q?UUFfhj5lLQJHUhUVATtQZ2r1JYVqiaGzwCUsDJKgoYTP23V6ZZ36OEQBgamT?=
 =?us-ascii?Q?Mf2rlbbnkfhWaF60IXgaGEygjnP/B01WM7ubAQ7g6yDbNtIkdHZMjpM6hNtk?=
 =?us-ascii?Q?YAkXVRa3sFxKa8NBns4qq0UKBGgCFT4gwfUtqwmb5nbC68yla6YJT2cQjYUR?=
 =?us-ascii?Q?570vFWG8vCctWGhBZVQG9TvztlfibGY3NfqpBIXx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc04e32d-c119-4563-8699-08ddde6d5fc6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 15:39:09.8301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jor80o1YX//V6tdX19McGpwyfuh2fGe9iWZY/umDIuuisEmjcSibNMR7YvUuS9RbbyqPwwYLMIoKyEnNNyWmTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10205

On Mon, Aug 18, 2025 at 03:47:45PM +0100, James Clark wrote:
>
>
> On 14/08/2025 7:19 pm, Frank Li wrote:
> > On Thu, Aug 14, 2025 at 05:06:52PM +0100, James Clark wrote:
> > > Document the two valid pincfg values and the defaults.
> > >
> > > Although the hardware supports two more values for half-duplex modes,
> > > the driver doesn't support them so don't document them.
> >
> > binding doc should be first patch before drivers.
> >
> > binding descript hardware not driver, you should add all regardless if
> > driver support it.
> >
>
> Replied to same on "[PATCH 10/13] spi: spi-fsl-lpspi: Add compatible for
> S32G"
>
> > >
> > > Signed-off-by: James Clark <james.clark@linaro.org>
> > > ---
> > >   Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml | 14 ++++++++++++++
> > >   1 file changed, 14 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
> > > index ce7bd44ee17e..3f8833911807 100644
> > > --- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
> > > +++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
> > > @@ -70,6 +70,19 @@ properties:
> > >     power-domains:
> > >       maxItems: 1
> > >
> > > +  nxp,pincfg:
> > > +    description:
> > > +      'Pin configuration value for CFGR1.PINCFG.
> > > +        - "sin-in-sout-out": SIN is used for input data and SOUT is used for
> > > +                             output data
> > > +        - "sout-in-sin-out": SOUT is used for input data and SIN is used for
> > > +                             output data
> > > +      If no value is specified then the default is "sin-in-sout-out" for host
> > > +      mode and "sout-in-sin-out" for target mode.'
> >
> > why need this? are there varible at difference boards? look like default
> > is more make sense.
> >
>
> + Larissa. I think this might also be a question for the hardware designers
> about why the feature to swap the pins was deemed worth including.
>
> I'm assuming the flexibility is given for routing reasons. If you have
> another device with the pins in one order then you can route it without a
> via if they happen to be in the same order.

DT team need reason to judge if a new property is reasonable/neccesary. You
need  mention the reason why need this property. Here, some board design
swap sin/sout.

>
> > SPI signal name is MOSI and MISO
> >
> > Frank
> >
>
> As mentioned in the commit message of "[PATCH 05/13] spi: spi-fsl-lpspi:
> Enumerate all pin configuration definitions" the names were taken directly
> from the reference manual and this doc text was too. I think diverging from
> CFGR1_PINCFG could be potentially quite confusing. And MOSI isn't mentioned
> once in S32G3RM rev 4:
>
>   Configures which pins are used for input and output data during serial
>   transfers. When performing parallel transfers, the Pin Configuration
>   field is ignored.
>
>     00b - SIN is used for input data and SOUT is used for output data
>     01b - SIN is used for both input and output data, only half-duplex
>           serial transfers are supported
>     10b - SOUT is used for both input and output data, only half-duplex
>           serial transfers are supported
>     11b - SOUT is used for input data and SIN is used for output data

dt binding is ABI, design user easy understand property string.  like

enum:
  - normal
  - swap
  - half-duplex-on-sin
  - half-duplex-on-sout

Frank

>
> James
>
> > > +    enum:
> > > +      - sin-in-sout-out
> > > +      - sout-in-sin-out
> > > +
> > >   required:
> > >     - compatible
> > >     - reg
> > > @@ -95,4 +108,5 @@ examples:
> > >           spi-slave;
> > >           fsl,spi-only-use-cs1-sel;
> > >           num-cs = <2>;
> > > +        nxp,pincfg = "sout-in-sin-out";
> > >       };
> > >
> > > --
> > > 2.34.1
> > >
>

