Return-Path: <linux-spi+bounces-11460-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E218C7ACFA
	for <lists+linux-spi@lfdr.de>; Fri, 21 Nov 2025 17:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 923284E156A
	for <lists+linux-spi@lfdr.de>; Fri, 21 Nov 2025 16:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4747D2248B9;
	Fri, 21 Nov 2025 16:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LLMuNSWG"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011055.outbound.protection.outlook.com [52.101.70.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DCA7260B;
	Fri, 21 Nov 2025 16:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763741987; cv=fail; b=W0Vi9jk9BYYkpuwoKcB7du9Zh80KvSsbu+/nHUN9W1XycNvBuSCLhLdyIuR0ZWmpAIQNhJiPtW1+HkaksoVmJI1ZivpwXEIDJD5D5G1BwAU/J8rLV4Rcs5KDjrrqf/dZ3qt4Dy2hPzUJ7hhXvQWyQfu1ohonUE+fUhNH1yS7Lro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763741987; c=relaxed/simple;
	bh=goQFHnJqCjginm8UZ8SDXCNZb2JlvHy8uhI+hZayQ/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GZu63TR3Lu63n0BswtST9sEdxG7EG4Pa/iW+XD1QphYTRXmX9xbU0EZj/4ILvMfEXJ6JeTdtzay476SDSTexjfewUObXtzVCs+3wOoqbVL2iI3CLy+Yl+QxviAvcywQyjq4NoYl3tsZ3Eb8oQsCGtls+QGbBk1FpS/l7KhdqdYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LLMuNSWG; arc=fail smtp.client-ip=52.101.70.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J9LjaYBV29mM4z3Cwda8ySetv72ABXIREQSrEohtH4/DKLY8jsE5HpDS+2Gf8Ny45pEKjYN5JGGsWbbaTR+dLwfQ1bs2ZFwd7Y+bSrpIm2iTRwBqKz/8k4K7d82kjR/KF2/pm3pY0WbcH2589oONqmWwRLkmaLWvGsq9wYM6wS1n8bjwlUMgkACEg4l7KpmQ1Qx4t7rk2rz2ZOX8m+FJ648qgTXhqbMECFSebCYaj2vYmhXjeI6lxHoIZdbdGJJiW3kBloQ0Uiz50D0fw9qOxE/XjpeCXYpcQREYk2OTzWdoxAV1kRFTpfDCjqGUGZbVTOxnZ4HlHrY2BrI5irTirQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nf+Je1HRBJsZA+N6K0VjfbAEw4jaGyvUI27cQ48RLA8=;
 b=Z+JD6kkuG35G0hWPcHx7hnQOiqzoAw30cQzfcl9Lw62Newv9BJGNf1VAExR/fMv+eUdMV1VNPi0QM1mf+GH6n5g/i7EGkQ+LQsKOh582nJzoZHmHC0L+8HPdAAk/6eKSXlMKflwa/X0cloRbF9OgFG8lHAwPHVIDOhcL/F/q1AtP7cXd86JzmTO4HWEdzYq9sw8hhJDNwJaUpCk781MLTO9MkFLCWA9Ikm2sz0+9aL4lTDxjoiKzmw2Wi2dbXo768JhXGnfX28fTY69ToWG8gjdPcZw2esAHo8tUln6SPNNZTJBGS9RSIMB7ZjYodxGfldFL8PKtUymozeDdebL2IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nf+Je1HRBJsZA+N6K0VjfbAEw4jaGyvUI27cQ48RLA8=;
 b=LLMuNSWGvx9pRzzGEC8yBb/gOMfcpgbxbQQjg6C5ZIHcM7Rdu3UH8SAXp5vlO4A4VvA5coVqVpeidX2oNqE2391S5lf//bFmEyGOs4jMCKLg9CojLEDREsc+eMHxwZpeeNKQgpG8L09oCYqYyZflP8D5WiLYhwRV6IEyvG0Grle8LvUrJQBGCqodEdk1tbVbN9lU9oX5AMyNLZy5crYs3qW42vliAKQNS6HbWTs1e8rXNp7UEDf61OO7HzZry4dFmem8bZ3Bbpl3Xp6DbifgV/nyp9mmWYI1PGJWDGnkOyEdIXiRjjmASWqQ/AI1SFPBn8rU6Y4IZ+COwdHr1IznuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DU6PR04MB11133.eurprd04.prod.outlook.com (2603:10a6:10:5c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 16:19:40 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 16:19:40 +0000
Date: Fri, 21 Nov 2025 11:19:34 -0500
From: Frank Li <Frank.li@nxp.com>
To: carlos.song@nxp.com
Cc: broonie@kernel.org, rongqianfeng@vivo.com, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spi-fsl-lpspi: fix watermark truncation caused by
 type cast
Message-ID: <aSCRFu2koh/w7ELs@lizhi-Precision-Tower-5810>
References: <20251117030355.1359081-1-carlos.song@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117030355.1359081-1-carlos.song@nxp.com>
X-ClientProxiedBy: PH8P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:345::12) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DU6PR04MB11133:EE_
X-MS-Office365-Filtering-Correlation-Id: 38aff08a-365e-403b-8fb8-08de2919c59d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xy7G0aLDbmwybnSCfayDBBsWrdlKd4i6RwbiPuabzLCv2RuHpxliz/8Hsi2L?=
 =?us-ascii?Q?XeNHpIQlr1NENOWVCxSXyW5iFRvnyPcG+lQdsGA2GMazOQ+tgkWMfrJwPPXj?=
 =?us-ascii?Q?KszSfT4GZlROwtMC8yjoRQCGeG6Qd7XvyYVttDuvOQXDxBJHbnVBeCsSVRjA?=
 =?us-ascii?Q?ZsoFNvsqgu5r7ptLDmUZbA4CWUAqhDFBH8qOKt2YlzktdhrDW/JNnMtNZzi8?=
 =?us-ascii?Q?c8TEu2mvlBtjII3yXN/Qs4RB5YUqguZUcTOdujlc7DZdUEXYrL+f1o3CYC1s?=
 =?us-ascii?Q?yehjWdf7/7tnz4a5WexzsegKAPOiz8ZWVWJwX9Ht3gFNu2s2MOkXyieW6TBp?=
 =?us-ascii?Q?k7z14u5XQ+y26kVSmfa6CbPlw4DMo8gCR3eZkrAy58Ep9rfdNYRN3We0Kfaj?=
 =?us-ascii?Q?SEERmyVr8EUFxijbWiSJZwe5ySyd/UUABr2J2M0LxOaVp8MWXU4JiXd/9cVG?=
 =?us-ascii?Q?6DVH3ehhs1ZNwLMLhHnXq+bnf4aeoCLiQV9S3lXB47JFJF6R4ekM4jdkxo7c?=
 =?us-ascii?Q?Kf6/uuRsN9TypWgeULJFnFzdft1BMX1EZmaRYcVQFnbvPCGSu5r2iBZT0eLF?=
 =?us-ascii?Q?TKbmv7fP9MuCBCVfdnJgWgPMlPpTJGtj6j28D0xopCz+BqMw0fkDR82mpV45?=
 =?us-ascii?Q?I2e8c3kcHam1bIH63RQlzGwRXGjcsxQXl9xkQG+NNcRFQlLtDYON6AxPGUWO?=
 =?us-ascii?Q?8hUghCEH5pI0ggfAXc3pPWtzEcvb8uE699Yd5cpYorYsM1pMw9wiWqdLU35O?=
 =?us-ascii?Q?1yGFIhL2z19aFGJAC4tkAQhlpDLu5oQZODBe5x7COYVkv5urRdlwCDN4EYc3?=
 =?us-ascii?Q?o6Tp3Tnb6+Rha431xngyNaJhPJh+8+4ZDrFWU6DLfrvKPXAY7kbVVo3tLUtA?=
 =?us-ascii?Q?c24PctR6c5yEkJv8ilgSsu865CbIN/w93Hx9DAN6AsyyPdI95QfzX5tV4TiT?=
 =?us-ascii?Q?RGWAAufoM2a8fA9gcEXTlpLieP78/k3m+KleTS9AvkhHkiCuqTeQQLIRY5KS?=
 =?us-ascii?Q?10x8qn0VmMzZC3XH0IP/8p+CXZG/vIbIg8urflKpaDFi4pYhdK8x1PawOVuR?=
 =?us-ascii?Q?hugrTCTDp8CQZelcSe22s1RFPKYk8B0Yxs2qP2TG6rULJNdZevwkI3W3L4Kv?=
 =?us-ascii?Q?hykMDXOyMckNVhziw+LQJRXmbMsLN5zhRbUC8pxEhUDWgXXyFRdOQ9bWsbhL?=
 =?us-ascii?Q?GGE5dPJeHPiCskID5Tel2R8YVE86HIevJjDLrPwyHrhx/HWYu6W3EkLtp1n4?=
 =?us-ascii?Q?yJcuVhiG/WQ5OS21pWtIUpJv6ci0MnhDx3TlsLAvZyoKwhU6Cy5XNjkk+S1R?=
 =?us-ascii?Q?A2bq6ODiYJ67PIvoowdyJN0TgcFwKVgon/WTtBpbIy0c5g1ASqyQxrtrvEG6?=
 =?us-ascii?Q?g0l09qMGjXOGAv0wumxBT8MXkd+Q7lra+bh3UJ98ncBaj9pT+xBv7UvlH7uF?=
 =?us-ascii?Q?26Ly4eFgQUMhn5FnjWvNaHTcFAMLKx2dAQQX8h75OEw0ruYh1IIeqmgI4JIR?=
 =?us-ascii?Q?ssY7mpeUVpRtYu0NGAmagAo9wIlLF3xphpIX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C2eMHHcM2HxdR9/ASkkviwAyB3L3o54rTH/iQtdnNM4lWDJJXMtf0zjJtDuj?=
 =?us-ascii?Q?FkhxEIXssWoFQkjYjafZNDlAh2RbV5GFoiZzdB7LL2fypHMPEnspHtMbAHNd?=
 =?us-ascii?Q?BKbjapRegSK6AUnP5MIkIJUCmhgStkWH8si3DNnm90mCjnL6zm7BBsm740Kt?=
 =?us-ascii?Q?X4WrV5ttjzeK1DduPqsAkN846ng1ChmJ9PU/19/S+Yvf5scpymLl44fI751w?=
 =?us-ascii?Q?AiEpLcQCs0CAHIBPLhqyBEEc5tpko6YJgl6mz9aSpfvOPYkN9SB+3SgkX+5j?=
 =?us-ascii?Q?l2vfb8FfNiPnBZiYwd0oMMsdPRQYFfOZAyNX4TXlxiPuKvBJAjumf7dim9DO?=
 =?us-ascii?Q?H0r+Q1CDSXC1tW+uHkzOlE74igb+DoBftQI+GtYGNNHrzSjGr1zDB0Rccmep?=
 =?us-ascii?Q?4+cILX1ygN3Osk6Hj69N7FcvpVjYphCotbaahb7DkuF2Nf0InoGsZRr4DgMP?=
 =?us-ascii?Q?JaY4dkng7pXI5Sh0fTaS2HQWLKJ4YmRX5AUY2Y1HbckDQxVSplji7vSkW87g?=
 =?us-ascii?Q?dXLVmR0uTq2OigWBVd+Dp47NhHFxyoDspg/mcV09Cb6l9NZmDFBks/W2Xrii?=
 =?us-ascii?Q?MIQSlw8hHP2Syha8U/b8+LxuErPbf8XabtrIAqWtJeCbXw1kvxhwlIZdPie7?=
 =?us-ascii?Q?qeIWPTD9eGUXRha0MDCbcQtWNoFmlSrZv6YiWb4V2IuZbw1pxOfy0DCXzpci?=
 =?us-ascii?Q?+uOKgRu/q/RMj4PoqJ3i0KZMkmjiF6S1E1lptn1DF85snzsds1Uh/auHkTAd?=
 =?us-ascii?Q?46qxIik/uyh81JJ1Hs7lpglK18icVFUJZGRwo+5wz1NI1t9N42inlmtmAw20?=
 =?us-ascii?Q?RKbs870FCSFO0uBG2iSIW4ddUeD2IaptZVg1DlQRIAtUaqVrEdtvDO3uULFH?=
 =?us-ascii?Q?29ODbhjcREF5tTCPqzT5Ye1k1qaNaNwc8XJrbqD1Dvsac5vMpUu86UeZWlLz?=
 =?us-ascii?Q?QuAm2x3USYQIVlbWQK+NZKQWG8REFQCt7o/vwAKAE0hliSrf0oarfc7pO04l?=
 =?us-ascii?Q?6so+fx8Gp0JtPtJ5INJ4y7kveeE6UqBdJxJJAAh+z/6GZkYs/eo3oCSp3cJ0?=
 =?us-ascii?Q?MV0bYhcUkKwAeVHsz401LEbcx1MzwSzRj2rSblWbZJqxhPyH2ml6+5nmgrLc?=
 =?us-ascii?Q?+x7R7JhyBlsgRZZocppNcEKQbxbFROdOFnmrcy437gPG4CKJduejjqSkI3K+?=
 =?us-ascii?Q?tpLeUU1FFDn2IkBCCnFa9CAahM7Fr/qexV+Eiz2+l+YOoJJddDaxxlPvNCDN?=
 =?us-ascii?Q?Fr4SzNcJ09fPDHPpJvn0tKWuo8YSrOLhuDo70xBMiNG7hpCmocAxeIej1tbF?=
 =?us-ascii?Q?hG7mNBL2GrxieLTE0BjPZbYty/sohOeRSYBQHer2zsXNpSVLNUlk74O9K32E?=
 =?us-ascii?Q?mkVQxVSysTBYsh6pgIZqjTvH2hJmg3lZkzBmpFhETqpP2zYZhNqoL2yNArif?=
 =?us-ascii?Q?IP4Z09PvM+YcDyysqcHDtvN0xbOS6no5OBZ5jDVjk+sFAw5vf9Z5xh3Fqz42?=
 =?us-ascii?Q?t5pDM0x02sSrp4BR6xa+eMBpHtwi2sgGDBgHIpt0kkAPuxH1Mstv6s0UqmRv?=
 =?us-ascii?Q?qoypqGCw5PQpli+K0PQ8yNAP68MvkFPWDMXqQoYI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38aff08a-365e-403b-8fb8-08de2919c59d
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 16:19:40.2404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TUwYfjUoNMYmIVam/EVGSw+v5NWjjKzu9OSYWFFK8ne9ycNBixn4Qq6TbTAwkwwjYSPNoUyS4bwOOO7QXqgX+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11133

On Mon, Nov 17, 2025 at 11:03:55AM +0800, carlos.song@nxp.com wrote:
> From: Carlos Song <carlos.song@nxp.com>
>
> 't->len' is an unsigned integer, while 'watermark' and 'txfifosize' are
> u8. Using min_t with typeof(watermark) forces both values to be cast to
> u8, which truncates len when it exceeds 255. For example, len = 4096
> becomes 0 after casting, resulting in an incorrect watermark value.
>
> Use a wider type in min_t to avoid truncation and ensure the correct
> minimum value is applied.
>
> Fixes: a750050349ea ("spi: spi-fsl-lpspi: use min_t() to improve code")
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> ---
>  drivers/spi/spi-fsl-lpspi.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
> index 8da66e101386..065456aba2ae 100644
> --- a/drivers/spi/spi-fsl-lpspi.c
> +++ b/drivers/spi/spi-fsl-lpspi.c
> @@ -486,7 +486,13 @@ static int fsl_lpspi_setup_transfer(struct spi_controller *controller,
>  		fsl_lpspi->tx = fsl_lpspi_buf_tx_u32;
>  	}
>
> -	fsl_lpspi->watermark = min_t(typeof(fsl_lpspi->watermark),
> +	/*
> +	 * t->len is 'unsigned' and txfifosize and watermrk is 'u8', force
> +	 * type cast is inevitable. When len > 255, len will be truncated in min_t(),
> +	 * it caused wrong watermark set. 'unsigned int' is as the designated type
> +	 * for min_t() to avoid truncation.
> +	 */
> +	fsl_lpspi->watermark = min_t(unsigned int,
>  				     fsl_lpspi->txfifosize,
>  				     t->len);

There are thread discussion about min() and mit_t()

https://lore.kernel.org/all/20251119224140.8616-1-david.laight.linux@gmail.com/

Frank

>
> --
> 2.34.1
>

