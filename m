Return-Path: <linux-spi+bounces-4652-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E6596CD05
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 05:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA63E1F297BE
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 03:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1925C144D01;
	Thu,  5 Sep 2024 03:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JmPpDAj/"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2086.outbound.protection.outlook.com [40.107.21.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AFB143C7E;
	Thu,  5 Sep 2024 03:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725505727; cv=fail; b=LeGlwMqjhRRQhVT40wYsg5kr/YQwv7fC963YL7ioWYYD8d6kXnaSNCJ5gaQ8ics5LK71keJSVe5HFy8P5/82+G2cRYgJjZbPhP8rLx1ToBnGr4+J0DkhgxcMedu+0P+3STW5uT+Jm7xy3rR8bRksob0JjzE3ErqzI2PT7XhK+/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725505727; c=relaxed/simple;
	bh=MkHdv8AwC6MTgvy3nOqUYCa6n4OC6n/VFbqFSHLZ4O0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AAK5dQCkmVeY3fhtnf6n9XxlwknSCc3F8U7nFRt5lB63F4+1irEZBbLGNrptRSTW2gsjS8acSa+/y3X3y/7zekDss3JMRuTortaoRJQlxda1Q1IpJOlaJoLO+JN0mMUwczWqb0H7rv0glRx8QDhPmerDP3DOXpczFGoBFY50ulY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JmPpDAj/; arc=fail smtp.client-ip=40.107.21.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ME1uK7s4/L9RCx7lOtT3anHMgBzDS2zF1Zz9iuAHGzi4r9FurtpneAJkxD65sul0eR4xZ/6bYoNu8KdTnN6VhxI9VvOuSQ0h0Tv2MbO691ZFVy84HuJyRe0Cl6TDHkK/tQ9NV9OuMhBRMBV4uBmVTaqobO5Dp0LP6rTpO0s8HivgBwrNpW+gOk7u3joz6UJpMOUffu7GSXh7V04sGl39462l4/IMW5perLIeQn3o2yX/BkCCpZhvm8re6UhH0vWd9JWAoue4N/nGB/H4fvRZFxKy4eBrD8DF4Cpv+w3OY+qslR2pFJZgThiGlNVlSZ+OK2LNb6K+Gl578+L8NaGu4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LF8weECMI9k+p1j3fla4bual+m+6jTpQvEeyzsGfpVg=;
 b=B3cgOV1Iu2kBQR5IMimPzcYiBXSHoTHWpuQoFMaHZqrt3yah5i0WRpHiMqSeMdzxolFeTk/hrIJ13PipZegpJlQe3juHZLrNwfcgLvKHKLOFNdsXwEe62ezyzLfHEUK4qjHy7kDwL75x1Lm9CDJ67crBhv/de2RniHfzJ3XgXSp7T5UjvQ7qFWdEowRG1g2NqsYfVXCaqLng3OE8pkwtJzTIk2bUHseEvXpJntRXOZmJIQES79PDdUdVB/C4+NTT/CFgcx5Nyu3q8+Sb+Lv3h/JhEqLq8anWSBXYlbSeTE0IBNzxkBm/KbZT+c5rqFpUfljS6g4/JxIpcoFe8BmjHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LF8weECMI9k+p1j3fla4bual+m+6jTpQvEeyzsGfpVg=;
 b=JmPpDAj/RsCPQ0uFjwxm3j9VuiDkp4LIUNwrsfyOJsfst+axh9FfplmU+WpmRabZlNetPKGnGHUD7apovUf4ELWWPNIHae/tw/3UXRwP+8uq6WQQw4FjYOnYoTFWUndcQppqigzibyD7XEwHxeBVi8NruInq6rE/9Hb0Ph9J6WM/CPKvf5m0NzyfgHfFAmtAZ3ClY+AXOIstVdSHfxXv2CwEjDZdzbFY6oGKeqoA7UsPU48EG2ZjeDZI3UzTOcauB3M6J2UVCu8/13yoU59UkmsBjBiPLtqur45dJsFD5epPhDAyN4nmT4Ap5DxAnfYVHIX2G/zgtRIFvuRcQTCAmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7878.eurprd04.prod.outlook.com (2603:10a6:20b:2af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 03:08:42 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 03:08:41 +0000
Date: Wed, 4 Sep 2024 23:08:32 -0400
From: Frank Li <Frank.li@nxp.com>
To: haibo.chen@nxp.com
Cc: han.xu@nxp.com, yogeshgaur.83@gmail.com, broonie@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, singh.kuldeep87k@gmail.com, hs@denx.de,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/3] arm64: dts: imx8ulp: correct the flexspi
 compatible string
Message-ID: <ZtkgsO3tUkiNDWYH@lizhi-Precision-Tower-5810>
References: <20240905012617.1864997-1-haibo.chen@nxp.com>
 <20240905012617.1864997-4-haibo.chen@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905012617.1864997-4-haibo.chen@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0232.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 2761f87b-5ae8-4727-16fd-08dccd580bc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nFADNrEWNDqvQ/Ql0dr/+EvIdZZO4M90HJAu8W3jmEmab8RElyfkYC6GGPC5?=
 =?us-ascii?Q?1XwytnkpQD7a89rNB9zu+g4I8y1BPEU+DIBF8aPS/uvBu/7HsYHiwoq2/53e?=
 =?us-ascii?Q?vg+VA/TQ/uE/pntaE57lsC79q2qCVBFrZ3ouBfTl/kHrm3FzYN+6feu0+dvN?=
 =?us-ascii?Q?Zbn4C/cRle3Ijl3gagHPSvejb+gwZHwlxhJ+0I6KJZgQIeqIVZ+S1RWIjhwB?=
 =?us-ascii?Q?kC0oUAqEXkzoxYMqtIDmSlbg/nKJIBRxifJeCYzD9zu334WfNRwRyR80Artj?=
 =?us-ascii?Q?z8Wryj+pbqm6G1BSls0btJQe0AXvyuznTbkUSHZgYi63mI4thMMsvLCIbWHY?=
 =?us-ascii?Q?VIp6iPtf0yFIzqF5pStHHb27PXQ6YC7983JBHWx7g6f5ZiLDaaQXBqQGBH6U?=
 =?us-ascii?Q?bDaMAaCtTFwt/cn5cNI0Qg8YOzgonz7otSk1blwRsqAg1D1dLfBXRLMii9bs?=
 =?us-ascii?Q?Ew4nj4gjUXNk8En0MH5/0LrjytoEo44osSIObm3ruuVdNhsabAl5oXJKM2ZX?=
 =?us-ascii?Q?agvpZVb84Pozm7LD+wAZOUI/MAZX3eUeKOvh3AcunBZLBLdfungSOiyfEGWi?=
 =?us-ascii?Q?xzUIzVc0Wf5tYZkt1iSHei/KFEI5g9G5fUqenLBsHJQGlruiL2K78oIMKSO+?=
 =?us-ascii?Q?B2Np0Ntwcvnt+evnCyjsLW7wA4eYEXpBwceudAbkupJrfDsU6jmUoIDDqE55?=
 =?us-ascii?Q?R8YN2iR6kwcREWVEVNBDSOOxr33T8ZO3wOf569IzGmVGT3e52xgiJGoQUIXD?=
 =?us-ascii?Q?BaDTuye5BtIHW7Wb5obwNOmXfDP0PH0X3nPHAfaE6cB/1UPI5lzZaf1swoff?=
 =?us-ascii?Q?Wedxb8348wG/ubW51KLLeEeDLv5ivmmG7//m0hpQjGRVS1xlfwC6g97W7f8I?=
 =?us-ascii?Q?VyaRSMM93AFYPD1UWHL3foRkzqbiNzQGYykznqzeF4M0da6H8MWpmboCR378?=
 =?us-ascii?Q?/NGBbhv3kl4GElBTOO9HDNoUbFgcp9LYF54tf6yDJRBdxUIXVArqWkPkzyAu?=
 =?us-ascii?Q?RNWvIVp66TdjeGZ2bnAEtEgmH3aPQu1K+E5SiXi0UR3KZcOJxULt2TU0q/gk?=
 =?us-ascii?Q?dQg/4Jb0A63tOWXLcSko2QHGnE05bcFatpKjMVbAxA06AWFwdx2KLorhWX5W?=
 =?us-ascii?Q?1LA1WrVccWQRoiOUUbLervarFEIesOQclEGBEQvGrt6hzbm/EszpuSkIwl2v?=
 =?us-ascii?Q?ItZqP/d02TfXHhj649AW/oWsvx8NcZXZq30alqEOmACe+PkjifUXXj0kUYz2?=
 =?us-ascii?Q?9T+SYxU2+9sXgm28OHAqrab33FN2BaZNv0IVk1s7nmovEvwmBQlo26OQHU0O?=
 =?us-ascii?Q?3lqr95uMszpozCD+pYACoc/HWelEPI88QgYKMIDNwzg6yd/4l5Y/5UcSFUah?=
 =?us-ascii?Q?PfS28tgv2h7OaEBU2t0D0LEGVxUlPwL/1FFSLu5J5MtPTbg/7A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k6DISrxJBmEdpdgtBhCaZiYv4vYEL4UMdIQSUCuuNKTNLDnIu8TIXuTIRszI?=
 =?us-ascii?Q?pYVVXgwbnFDQWWvbvVZJEFYMe8v31/eFjivT57mCUb3vo6xDrijzt0Z1b6H4?=
 =?us-ascii?Q?rrftwddjZUmL0eiOQWB7lS9A2Hn9jEdJrD2U3vptkKFg21H5fqzfbFxOgsAH?=
 =?us-ascii?Q?QmT4QqYb6Jp+P9/93ZRTH1ku3YZffBvmhgPhbPgmKkOBRZK6JjOFi3U1m0Rq?=
 =?us-ascii?Q?x40eVQR1tLHX3ABybDscIvWJmiaqtZuTF3sPZATKjzaN8RahYHdPo5JoXrBD?=
 =?us-ascii?Q?qeWTzBazpooyRPR9HYkqJ8iL/0I8ov6+SXFpJEVrhzvkegYpEVyOsEYdWgQL?=
 =?us-ascii?Q?KAdfB4uMWNSrjrxPQ2PBkjsCSz5EKm8r1jKGvCtYlQ6XMhxaeUtvlaJsuwJu?=
 =?us-ascii?Q?RW1nmosdnpPV/YGNgJhgsGiXQFkAsV0v/TFXZnkN2tByjWXLOTZkvE9AxTzA?=
 =?us-ascii?Q?BALaxL/eTPK0+VyKSH+IvttxWCUBjdDq0wOjHnTUd5aDj9tYdCwnY7B2pQtn?=
 =?us-ascii?Q?0w2jUD9OsduAdo31pE7ZbDLLBotBE7BpnsblrY3MXyN333/GSqGuLnENbD+d?=
 =?us-ascii?Q?Tp8rjiE9Rhjb5Jla7RLwXR10FbM5kVoPhhNcFPbuHdpAN/OFz5Twbm+Qt5CT?=
 =?us-ascii?Q?JHCwPq59hYm3dZSKmQRcjzlHW/zLppO3WDJh793bnMGFJdQdChlK/9qKSR60?=
 =?us-ascii?Q?8MFX4lLPvWVJVYUVBUdhWnjXByXILO+CAnVkjPlvNGM/Io2exapANTIszYDs?=
 =?us-ascii?Q?UkWhwgvn8DnawgZSwfbJpYzJbfJZQeXTjr6z7vhAbUxxy4ym18QNjgc/WH1m?=
 =?us-ascii?Q?ulbB9O0sWmu1OXwU9JIaIfWFXAPs7dIULtV7IqwzubvgGHblYmsh+TiLXKpu?=
 =?us-ascii?Q?6RxD5DlF7YzePVeQsrtU21u+lcJptO7OPSlWkeudhTpjtR+8N1rwYdl7Uzln?=
 =?us-ascii?Q?3u17EMqgutizHSpiXxgcVzw3ouM/7Brj5M4OBlRb8d0+vnh2GBlAW+gpnVI7?=
 =?us-ascii?Q?Z7tYeHDvJ02UHYFCAjXbw31214L+Mn3FMCp5y2zPA6jbjzYEdjYbtjyPLldx?=
 =?us-ascii?Q?pULihrBmv9L5s6tWp2NFF3xq48IP0D3+O/04o2NUtLVtwRGCrwPSxTJ/VYPX?=
 =?us-ascii?Q?80lk7Cg6R/16T5aaTS4OhwN/wg1C4hbMkGdeQoSN4nFLJsdr0mxu9m9ftA1f?=
 =?us-ascii?Q?XqqNvW+xpYFUnICtFDrnpd8zbHTugO+YAzspHOPicOfMAEX9WivXNeQkqGOB?=
 =?us-ascii?Q?dj3hltDSnwET0a4NthXHCR7PwPitTxKTFFXqetWxMS0kPR8NRhfn1xYOTu+N?=
 =?us-ascii?Q?IfhOQ8VRzR+0xk/kmNukQvuDUKsTcU9l6ffn8Aro2clhcLJ4XXRgeVJIiLmb?=
 =?us-ascii?Q?AbBXcBEXkJkVYsHWiFBrid+r6fhryTYnJ/EiZC1G57ePeJkau9Z+2vcT5YL2?=
 =?us-ascii?Q?vX9RoqekDI4ndeaAh7sTEozAJwZOZSIkK9lNG9dxyOdtLkXphxYTf+wDmgy+?=
 =?us-ascii?Q?fvP/DQRV+lho8kOD3hWwcInrR29GP3KksEXeXPT9gsS1UDDBeKBVeuS0MUZM?=
 =?us-ascii?Q?EahJqd779VIsYY7pYND6POAx+NNVLRO4HRaSbiom?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2761f87b-5ae8-4727-16fd-08dccd580bc8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 03:08:41.9408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s3+PN2QAPIdTdiV1Gyci3zUjJ33/Ej9seg4Ss1ErqaonL2WlYEfJaP2JtXkJVhrmS2c91DIo22ZaEt8xEw1H4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7878

On Thu, Sep 05, 2024 at 09:26:17AM +0800, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
>
> The flexspi on imx8ulp only has 16 LUTs, and imx8mm flexspi has
> 32 LUTs, so correct the compatible string here, otherwise will
> meet below error:

Not sure if need fix tag.

Frank
>
> [    1.119072] ------------[ cut here ]------------
> [    1.123926] WARNING: CPU: 0 PID: 1 at drivers/spi/spi-nxp-fspi.c:855 nxp_fspi_exec_op+0xb04/0xb64
> [    1.133239] Modules linked in:
> [    1.136448] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0-rc6-next-20240902-00001-g131bf9439dd9 #69
> [    1.146821] Hardware name: NXP i.MX8ULP EVK (DT)
> [    1.151647] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    1.158931] pc : nxp_fspi_exec_op+0xb04/0xb64
> [    1.163496] lr : nxp_fspi_exec_op+0xa34/0xb64
> [    1.168060] sp : ffff80008002b2a0
> [    1.171526] x29: ffff80008002b2d0 x28: 0000000000000000 x27: 0000000000000000
> [    1.179002] x26: ffff2eb645542580 x25: ffff800080610014 x24: ffff800080610000
> [    1.186480] x23: ffff2eb645548080 x22: 0000000000000006 x21: ffff2eb6455425e0
> [    1.193956] x20: 0000000000000000 x19: ffff80008002b5e0 x18: ffffffffffffffff
> [    1.201432] x17: ffff2eb644467508 x16: 0000000000000138 x15: 0000000000000002
> [    1.208907] x14: 0000000000000000 x13: ffff2eb6400d8080 x12: 00000000ffffff00
> [    1.216378] x11: 0000000000000000 x10: ffff2eb6400d8080 x9 : ffff2eb697adca80
> [    1.223850] x8 : ffff2eb697ad3cc0 x7 : 0000000100000000 x6 : 0000000000000001
> [    1.231324] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 00000000000007a6
> [    1.238795] x2 : 0000000000000000 x1 : 00000000000001ce x0 : 00000000ffffff92
> [    1.246267] Call trace:
> [    1.248824]  nxp_fspi_exec_op+0xb04/0xb64
> [    1.253031]  spi_mem_exec_op+0x3a0/0x430
> [    1.257139]  spi_nor_read_id+0x80/0xcc
> [    1.261065]  spi_nor_scan+0x1ec/0xf10
> [    1.264901]  spi_nor_probe+0x108/0x2fc
> [    1.268828]  spi_mem_probe+0x6c/0xbc
> [    1.272574]  spi_probe+0x84/0xe4
> [    1.275958]  really_probe+0xbc/0x29c
> [    1.279713]  __driver_probe_device+0x78/0x12c
> [    1.284277]  driver_probe_device+0xd8/0x15c
> [    1.288660]  __device_attach_driver+0xb8/0x134
> [    1.293316]  bus_for_each_drv+0x88/0xe8
> [    1.297337]  __device_attach+0xa0/0x190
> [    1.301353]  device_initial_probe+0x14/0x20
> [    1.305734]  bus_probe_device+0xac/0xb0
> [    1.309752]  device_add+0x5d0/0x790
> [    1.313408]  __spi_add_device+0x134/0x204
> [    1.317606]  of_register_spi_device+0x3b4/0x590
> [    1.322348]  spi_register_controller+0x47c/0x754
> [    1.327181]  devm_spi_register_controller+0x4c/0xa4
> [    1.332289]  nxp_fspi_probe+0x1cc/0x2b0
> [    1.336307]  platform_probe+0x68/0xc4
> [    1.340145]  really_probe+0xbc/0x29c
> [    1.343893]  __driver_probe_device+0x78/0x12c
> [    1.348457]  driver_probe_device+0xd8/0x15c
> [    1.352838]  __driver_attach+0x90/0x19c
> [    1.356857]  bus_for_each_dev+0x7c/0xdc
> [    1.360877]  driver_attach+0x24/0x30
> [    1.364624]  bus_add_driver+0xe4/0x208
> [    1.368552]  driver_register+0x5c/0x124
> [    1.372573]  __platform_driver_register+0x28/0x34
> [    1.377497]  nxp_fspi_driver_init+0x1c/0x28
> [    1.381888]  do_one_initcall+0x80/0x1c8
> [    1.385908]  kernel_init_freeable+0x1c4/0x28c
> [    1.390472]  kernel_init+0x20/0x1d8
> [    1.394138]  ret_from_fork+0x10/0x20
> [    1.397885] ---[ end trace 0000000000000000 ]---
> [    1.407908] ------------[ cut here ]------------
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> index e32d5afcf4a9..43f543768444 100644
> --- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> @@ -384,7 +384,7 @@ pcc4: clock-controller@29800000 {
>  			};
>
>  			flexspi2: spi@29810000 {
> -				compatible = "nxp,imx8mm-fspi";
> +				compatible = "nxp,imx8ulp-fspi";
>  				reg = <0x29810000 0x10000>, <0x60000000 0x10000000>;
>  				reg-names = "fspi_base", "fspi_mmap";
>  				#address-cells = <1>;
> --
> 2.34.1
>

