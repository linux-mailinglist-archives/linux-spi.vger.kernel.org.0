Return-Path: <linux-spi+bounces-8435-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC77AAD44CE
	for <lists+linux-spi@lfdr.de>; Tue, 10 Jun 2025 23:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 996021892BC6
	for <lists+linux-spi@lfdr.de>; Tue, 10 Jun 2025 21:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40CD268FDE;
	Tue, 10 Jun 2025 21:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ToeVe94o"
X-Original-To: linux-spi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012012.outbound.protection.outlook.com [52.101.66.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C89D2459C5;
	Tue, 10 Jun 2025 21:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749591088; cv=fail; b=EdY1u25DUZU7zopARMsKVGlvRvvRG4GRbBC5M+6lGcq4ToHPAIuD9QoC3aDoi2GU4yVuot5VWEHk9KSheYm3ormKmlqdiGfu8ew0JrGzsq4eltx/cuiCzOXGEgyGn0GDYr84MB6cNGhfOD2yp6Fc7RdmfClqNTb68Gj5HqgVf88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749591088; c=relaxed/simple;
	bh=kMsjAl8M+bbbChadJ9uK2URtmtPF8OjNiPTR32XgrBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=opSnTcpPDmNbEj8LICQtOvTG01b8EA/s5fiCPyEmOxmUSz89/ueVk3GRmAlC3p8AeGTVd8vVvIrIzxLLqFV337HW0p1NEUNah9OLU+D95CcYysvaAZGfJhIDAfGaaw0d4gtJCJsYlw6r9ahsxsx8uJnHB4Ypgis5cIsnTFj6Z9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ToeVe94o; arc=fail smtp.client-ip=52.101.66.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v9cJ9ip6z3raOgqCZyTH/XIoMd0xeXeyBNwI/p0RAxmYF7ijhZSaFRgjonOVtCB9Ax0LphqArarrHw7lqA0NxiCl4CvgUDbUjJN5ytechtezeceYfgJJBQFJaoQ5FKWTFFi70nbeqlhAP2nJ1nGefurxrWe4o1o50nJeJlPxRmD5fdlCYebeqH8JnDn/CqxPkN8E+MgtQzk8Q2PTSJG6edYVWdhrmFURQgv9w+wq7lxDencdI+AXRngUMXLbCw3Pts7d5Kc3qHAmAWKPbipf3S22c5AMT4WzA1F3UgcmEggG2YZP9HUdiUGFNzb74PA4AgzOu4wfnc/lvzb/zKMCkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVIXcpl2EXYmiyuUfIlSBwZYuKwWk69mLNU2hv+lPos=;
 b=DpT+HAL20jS5V1dqrpQWKBYWKrraeit+LmDDeGcVLvSXHtlwZmNBvKCkDiyPrq+9kWzUMVlZBSj9NAr6dhUxXUNPSRyC/1B552rRYottL7EN9FOmKdpfDmJJuZnAOOUIY3B2Ge+ZxXWnBsP3IF2oS0dsJToj2y1Ax5jkvNg+n6cyB2STL6BvduwMzq6nGI3XU2gIM7ld1Cg8HXGKXqyQRoCbifUmo3HpBZG6ANIftGZF1hmBvi5ZY9Yr2nA0F/qJ4U1iWv1lqYC8jTEP732KzMrMTGvEtGBJdzlN5AipjwiEXlcLziUXPFIs1dOctyoxCojLHOdPn2CbKReNBgaVTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVIXcpl2EXYmiyuUfIlSBwZYuKwWk69mLNU2hv+lPos=;
 b=ToeVe94o1nf0LyiWlCd21ekA/MrinNFxx5dfZ+rSqwtQGZN5ku/yPQNtbUHuSfWNmlfV7CqWn7UsHF/VRCzC98Lw+z+Nj4u+Nsfb/5csFCQJEXKI2vRu7uyPdj0iboTvGgWFep9T4Wve482EhmMFvvjSpDxx6mhMKcknRBWBLBG/Lk86RYnIwKJqGF2zP6o1Tkk0cva3jZjIkPHdc/Y1W3mGOtFMt+FQkoRHplOpm28v473lt01A2bYIE3X5JZiJPQR7JnuyQPe1eDAZIjiSm0hJzY6nG7InOJ3xuCZ51GCUlRyvOswCJnvrwVhipU6YBl/oEV7ruCpXlN1x5ILIqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS5PR04MB9997.eurprd04.prod.outlook.com (2603:10a6:20b:67c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Tue, 10 Jun
 2025 21:31:24 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 21:31:24 +0000
Date: Wed, 11 Jun 2025 00:31:20 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: James Clark <james.clark@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] spi: spi-fsl-dspi: Clear completion counter before
 initiating transfer
Message-ID: <20250610213120.ib5tkbh4xu7af4jr@skbuf>
References: <20250609-james-nxp-spi-dma-v1-0-2b831e714be2@linaro.org>
 <20250609-james-nxp-spi-dma-v1-1-2b831e714be2@linaro.org>
 <20250610113423.zztoyabv4qzsaawt@skbuf>
 <9852a22a-1a09-4559-9775-2ccbb44c43c0@linaro.org>
 <20250610210147.kwuwwjtcl36hrxjc@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610210147.kwuwwjtcl36hrxjc@skbuf>
X-ClientProxiedBy: VI1PR0102CA0027.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::40) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS5PR04MB9997:EE_
X-MS-Office365-Filtering-Correlation-Id: 4975946e-848d-404c-2927-08dda8662646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i1SMJIW+uKyqlQK3db78Uxgys2XcrKrhRrjHkot4Xa/akF5xLULY2DlSQNDQ?=
 =?us-ascii?Q?ymcPkT+NY5dkHWtSkbzrkYX+BPgeu7FIzxjB0f3hRNa9NcFXCxi5RgxH6+04?=
 =?us-ascii?Q?twXDtojQYQ5UVFoE8jqDOaY/MpYGheWS5DkZpZKdJUcpQVZYmyQ0XN6Kok3r?=
 =?us-ascii?Q?CysLGHETyh/q31C5DlaDRg9xCbwANMwKBOERcyhGX7Om0V4bAezh5FnRSFo8?=
 =?us-ascii?Q?U7YxSzoyCDVbeWdN8KcjP6B/01UeoIK3Ndr8qSrrLzY+PsnmfndzBSm0Ae90?=
 =?us-ascii?Q?gl7vJ2o0m9acM7CMz9NHFMwz86eQj3VpmQMVuahSv13JpYGiD+Daf4s+W7V/?=
 =?us-ascii?Q?hMX9qdojeDCV8YN723eXwtgchi9Lyd2iH9pC/oW36ZL+Gph/SFjLFBlqr/YC?=
 =?us-ascii?Q?cy3SWEO6U4fmZqCNjJNbW71RSEI4ZZbwrAGe2CqgzbEBF/tshvvPNngV8VfI?=
 =?us-ascii?Q?kRhvt1szBt6uY7rC1/H7Xr4CunstUVyqA/Sh8TmBJlAzaTu83NspT04n7SKf?=
 =?us-ascii?Q?pF2zizwk2gyY1M8M36gxOoKiS9xnDLapflLt5JnQGiFGV1BLnZuPXbR3Lxb2?=
 =?us-ascii?Q?4zKmx7H5a/tr7v4TfkmC02H7/ONQ/OE7GYjggUQn/XBgq8o8mJCnU99WyFcQ?=
 =?us-ascii?Q?CUXq+Kks/QrmSMSdmEQdEnI4M1T8hAlejByYBdItXrKlr4NdGi4YbmfHyuTY?=
 =?us-ascii?Q?io36vEBMvyaWAw6i/ciFd4DkkO3tz+tbRUUYa85FVOycwHSyyOOo68WLIOVB?=
 =?us-ascii?Q?MN0CgU6kBfcr4BNkIcKwSgdg92EN5S0mahKJbpgYmn1G2cigRSl/Vz1uIJDK?=
 =?us-ascii?Q?5vz0/Mryy3H8k0iJCZHh+AhQtZOuB9gPmIg2ETRxiUZvI16G/BF3B1AA7yev?=
 =?us-ascii?Q?mZ8TRq8CNndqs4qtLvAkN4q2Nhx4YNpDf42PfTKy54seZMcc0mIWLS0++y6I?=
 =?us-ascii?Q?3lo6Y6XZWJPS4LxgNqPJkClGwqSUevFXT6ZvKSbIW8adA/F136Ng1xImPeFD?=
 =?us-ascii?Q?/OXh9+QTXI1EDnBqHqoBelNoDnkkOPtmcTWf3xsKtamD3A4BnQl8yrYsFfAY?=
 =?us-ascii?Q?Mdmmmg6s4hsoJXn7ezGnjWE455JeKJ7UqHwiFxcifR/SdzvB1koo3keWIudP?=
 =?us-ascii?Q?Tbu/hBEYNrwZIajOZ8L/PWq9x6r0CjxIZBjHMn749kkcc27bbYAN2jOPf6Xg?=
 =?us-ascii?Q?l1DWy5jNLbfmQ6vArZ3078q0aWAQBBjCYbTMiH7QMV9j9yCkTOxbVIFgb0/k?=
 =?us-ascii?Q?BJEozvUF2Kxk+RGyI6pE2n2prpTy8qkIA0XEEdnCCUzKpF7RjpPYUNd48Eq3?=
 =?us-ascii?Q?NTSwRUQVV/szJstSKNGp1eRF2NgIjXbUazshOD2Ibh6FMErOisKWBkoaULx4?=
 =?us-ascii?Q?fO54oJh9fD4N6KmMgDIDvSDIB+rgJ9Qb56RBMLRKTC1RNQ9WwWjWeLDon+P+?=
 =?us-ascii?Q?wCAHlMzv1Og=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7YOXqIn2iOoYi7NjBnvZ7xGeEQtOIPotJLgu6P6U40N+uUU0+04HTMqpNcKs?=
 =?us-ascii?Q?YjQrL1zc8XTz5U5JRVWHIA9bjBuLgBXQ3enMrpF6zJ6/cupwxLEr18rW9U0A?=
 =?us-ascii?Q?0Gstc+l+hPjABdIPF3btVjdZkCnMKsYhP/uKqATBgGGHkyA3NYlR6xNo6tZD?=
 =?us-ascii?Q?gLUhMzoZat1atjVJPV5fF3kOe0ovT86Knxz2dpit0nOh0FA4sg4vXirzQDQT?=
 =?us-ascii?Q?25v/pjauYxrQqpuilEpuw6NQ9Gz9d/EeHl7IZenGiFd7fxSfQvynyet3N1uj?=
 =?us-ascii?Q?LeVyb5+vW80V4jSp45DsTXspqZa1FF7g6kRbxLEQHvXo+41jgp46oAgKswhj?=
 =?us-ascii?Q?E7klKiT0hdaK5dTa9I4OZG2iV+NNHqd5u2HlOIPEbWfDka4r0EU5XmsLhlW1?=
 =?us-ascii?Q?/c4jhKtyp9ZMmUoHkf27GzDJ0jgn1H44+JvQxzxp9+6fww8HENie7pPt+v/H?=
 =?us-ascii?Q?Wf2tRfo9tepQqVzGo1fS7kx2vJtRaNxPMBf2cQajB2XYYcIMPgn5voTIVt7I?=
 =?us-ascii?Q?eDdja23SRpcfNmFgGD+RMOPqWx3OmczYo9K+cDtOocDBixTxMXyqAhuCdR7e?=
 =?us-ascii?Q?8UqJn8tFnpTPpoJJ8Wti0O2llcZil6ifQJki90HapiusCKezTu2j6XFBeOmm?=
 =?us-ascii?Q?qN6mJuewQWxI2Kb21nSNHYeEUoWOFl3w28GxDN4UHdqQt+8RvmY/4I7UZl+U?=
 =?us-ascii?Q?jXfbqWeNnJK4X7UI6wJX+IdMUVAGEwYC31rtjlenqjSyQELmMkueK5owODKV?=
 =?us-ascii?Q?4/ykDY5vdrgmxrTwRGeHROgYbMa8lGL216uemdEUJFsD+V6FAxt8abf8mwHT?=
 =?us-ascii?Q?+1vIPyWD6OWoT1AbIdmTRj9fZCc3n2o4LzeB3sDPs/mZP1F5qgSw7DhS/GZc?=
 =?us-ascii?Q?iPokR2S2LVXr3qqMHKTpfuyD8bR3iCBOBZ4oc2cipekvUEzv7sfB25pX9NXf?=
 =?us-ascii?Q?ev5ETXnebm6VKXIQ7s/OLlksudNeYRvQSWo7hWziRmr9uNac2idi1RxzjE0t?=
 =?us-ascii?Q?1PB5YKS+IdhRrL7CVoNuuFKde4ytJmdPSuYqeJ+fEl7QUSb4FD5jiKEqsVns?=
 =?us-ascii?Q?HnjKvfDB06TmQOtb3a51i/Ei2+mNMHZSLk8NoXo0Jxhu2wkidY2ceXUQZpiD?=
 =?us-ascii?Q?1df5Q8VIMjpg3idWRYNFShimTx03/8U5Xn40JtljmKGoBMpZ8rcUxB25RlXO?=
 =?us-ascii?Q?WNlbq3tZaFUQW+uNGaOqEK8YYyd2ArJ5r5A8DDH7NyOzSmNpn+NMhqSKMRMp?=
 =?us-ascii?Q?22kXjVFCoLtWNswi3ouGX1IxCeFh29N1oQ4u0yJo3NIqaJqfX2aX/4Wm4eI6?=
 =?us-ascii?Q?/8WwtklALmk/AbvHMXwN5zqtV6N0ufrBa36SMcTD1K+8mJHfcbtjNJh7pt8N?=
 =?us-ascii?Q?Ch978iDhrqNuGSg8mQTb+lvjqey+ZU1iwda6SA9QeNsHVOgVDsHGlTEZmxys?=
 =?us-ascii?Q?X36aHv/nDF6FxJ+/2pszyraJ3vCljQW13rqd8X/LrYlHDt+TB6QwREOO/xSb?=
 =?us-ascii?Q?r1jGt5MMKXnIkZ/gmZxM0lMF6AK+My9DK62ItSPiTVuiTTeRf8FMSZAZCDC8?=
 =?us-ascii?Q?inMf4kXxq3IoGWjoSPQMjbUuYfm1zI30bDaiMR8e/VcBQ0GjBBfxYVsEs9c+?=
 =?us-ascii?Q?Bw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4975946e-848d-404c-2927-08dda8662646
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 21:31:24.1422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 94+e/lzybhYShM7tEko5h9WSbx2jHbW66Z00mpcDSn2uTTEm3940wlOOr05WA9O4DTaZNROR26ZTgmrnp/nqFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9997

On Wed, Jun 11, 2025 at 12:01:47AM +0300, Vladimir Oltean wrote:
> On Tue, Jun 10, 2025 at 04:41:04PM +0100, James Clark wrote:
> > On 10/06/2025 12:34 pm, Vladimir Oltean wrote:
> > > On Mon, Jun 09, 2025 at 04:32:38PM +0100, James Clark wrote:
> > > > In target mode, extra interrupts can be received between the end of a
> > > > transfer and halting the module if the host continues sending more data.
> > > 
> > > Presumably you mean not just any extra interrupts can be received, but
> > > specifically CMDTCF, since that triggers the complete(&dspi->xfer_done)
> > > call. Other interrupt sources are masked in XSPI mode and should be
> > > irrelevant.
> > 
> > Yes complete(&dspi->xfer_done) is called so CMDTCF is set. For example in
> > one case of underflow I get SPI_SR = 0xca8b0450, which is these flags:
> > 
> >   TCF, TXRXS, TFUF, TFFF, CMDTCF, RFOF, RFDF, CMDFFF
> > 
> > Compared to a successful transfer I get 0xc2830330:
> > 
> >   TCF, TXRXS,       TFFF, CMDTCF,       RFDF, CMDFFF
> 
> Ok, so my new question would be: if CMDTCF is set, presumably it means a
> command was transferred. What command was transferred, and who put data
> in the FIFO for it?
> 
> Because the answer to the above is AFAIU "no one", I guess the driver
> should ignore CMDTCF when TFUF (TX FIFO underflow) is set; I consider
> that to be the logic bug. You are also doing that in patch 4/4, except
> you still call complete() for some reason. If you don't call complete(),
> there is no reason to fend against spurious completions.
> 
> I think I would prefer seeing more deliberate decisions in the driver,
> it helps if things don't just work by coincidence.

After thinking some more, I think I agree with your decision.

If there's a TX FIFO underflow in target mode, presumably there are 2
cases to handle.

1. The underflow occurred in the middle of a large-ish SPI message
   prepared by the driver, where the driver couldn't refill the TX FIFO
   fast enough in dspi_interrupt().

2. The underflow occurred because the driver had absolutely no SPI
   message prepared, and yet the host wanted something.

What changed my mind is that if you don't call complete() on SPI_SR_TFUF
(like I suggested), then case #1 above will hang. Your proposal is to
call complete() anyway, but to discard any previous completions,
associated with case #2, when there's a new message to prepare.

But I would like you to introduce a comment above the earlier
reinit_completion() explaining why it is there.

