Return-Path: <linux-spi+bounces-5052-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A8198A853
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 17:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F3D41F21236
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 15:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27DB18FDDA;
	Mon, 30 Sep 2024 15:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DvpO8/o7"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2043.outbound.protection.outlook.com [40.107.21.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A6C18E758
	for <linux-spi@vger.kernel.org>; Mon, 30 Sep 2024 15:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727709590; cv=fail; b=G/eEn9Rg41x7ub2FgYG+Hq86vNzfltPnQlBigQbTBfoWYu8xoUAfBPefoNuYajFtastBPtBnQzPGl+9UxmgV+LcNfzw/H0VxGx0LdDZGq7PzDsxx0YtFJLDhTahmKLkhzoUgOicdQ5VVxEfnrTmGCfiOjNDfhW0Am7JOd99dsy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727709590; c=relaxed/simple;
	bh=ZTQhsvuVKL8K4tfTii1HynfnPOiol8kKGuy8FdocZe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LVtns58KRnNFbInO5KIvhEG7NDOgCY02/4OIDrfk+NRHlxnM9eo6GX/1YhS9HXW1lDCBhyEp2ngJgNjz298d0H4UoI1uj/DDZB7DJXbUI7anGRxXUABC4uoDnBt7Ge0eTy3wtJ7kXUibB8fYruS6W1pQYXRa3DEm6RALAWRSru0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DvpO8/o7; arc=fail smtp.client-ip=40.107.21.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqDOpqwAazKTQwgKbDu/uvkfMO25/bHEuT0K5m3m0E5xiOWDofpxW64ALDTmgpHfcG6GYltV6u3IYgA4m5155N0cTLVoUe4K0KVDTpgtxHa9kaUKXucZwY52iqOdgDbhSO48OMYLtJI0QxghPW3CclKJe3AXeFRh9um+R1SIv+yUt+a+39n2ugZMSdiHeokLBqNlkyl6PbcdJSaByS/XfKNAe7+p6Tv2d73N0pYddb/UcH70XQtvZrvhcySEczXPae59c7ty9su9tD8xOoFynWfNVpvbhWU+wNnYwtVzZ3VDkm/2QhL/a80iXd6sMNXlpjqAZZg25/whBzTKJjJ3Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=raDAL97ImR6nU7MtX5MgHVqVNzQOIBVJZWR1tmx1CcE=;
 b=am7MybHBpxR2BH1+igxrh9QvEMijZryBuqvkj/c1WPj5B5NJlhN8UF7g7S52SrOEUTo+tUCF1vx7HmqaMl1xbE4XRd5Xv1j8EMnWvGOohFxzr57BbMU7ru/BMKM/CL1CRA8uKNeJQVEFGyvAzwLljqpGCxmHLo8rXXxQBM25qtyMoyHx6sOaadrgC9cJLq/tCbQUko8xzZkT2O85cnFewhBlJDA01fFA6QIOC0o01VacL8NIjy01N62BzTBx0JE/6K1/uZR8VjQ5qUofhOK+wkrT2p9yck0BctnJ0tLmTkjVYs0jd+tTsb2YF9Orl4nG2vrRCqSWT3I27Ud0ehYovw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=raDAL97ImR6nU7MtX5MgHVqVNzQOIBVJZWR1tmx1CcE=;
 b=DvpO8/o75ADXbrri3yB9Q3m+UnHtwbmiYQEUWQJah3I4NuLgdWJ6A940SQXiqbbEnrQA/pNrx8mITfuPxih0dFeRvBz01/JbBmUkFS6zibC/gj+aFkM46ElmaCbS8rWGQy5uAGl4QYXzviIjo1F+2AwKAekmRlx9IOEqaCNi+mcGfFVNOr7ThjcqAPqHRxjYBPyMHJ/M7gA3D4RdPxV/YsT57Y55OYDmBUnKqMfYOqJjG39qKEVGRXan2nTnI6LOZeFQry+7C5WwY0K7k0jFmXL+vuWgRe5LAmqIi4yq94WzIJ3epK7Q9iz22DcnLV1TkF3Tn1iZlT2j0nm6R9JIcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8844.eurprd04.prod.outlook.com (2603:10a6:20b:40b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Mon, 30 Sep
 2024 15:19:46 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 15:19:46 +0000
Date: Mon, 30 Sep 2024 11:19:38 -0400
From: Frank Li <Frank.li@nxp.com>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Mark Brown <broonie@kernel.org>, Carlos Song <carlos.song@nxp.com>,
	Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	"imx @ lists . linux . dev" <imx@lists.linux.dev>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH 2/3] spi: spi-fsl-lpspi: Fix specifiers in
 fsl_lpspi_set_bitrate
Message-ID: <ZvrBitznpSianndL@lizhi-Precision-Tower-5810>
References: <20240930093056.93418-1-wahrenst@gmx.net>
 <20240930093056.93418-3-wahrenst@gmx.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930093056.93418-3-wahrenst@gmx.net>
X-ClientProxiedBy: SJ0PR05CA0050.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8844:EE_
X-MS-Office365-Filtering-Correlation-Id: 353b7308-ab1d-46b6-506d-08dce1635152
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jmJy7e08+xz+5jxiMVdJBnGouvkxoykmiEBHMspDtWSbUVUs6NZZQl7+VHiy?=
 =?us-ascii?Q?MbDOTmWR34rYrI1QPWxX6Wvcn4j5avP3BNc/3Ha1p5//L4GA1UN6ASc6KwhE?=
 =?us-ascii?Q?av8uqqT7antt8s1a3zWPeNeoiHtEOR6ckQm+F8f78ywWnbzCcQDhFxnwLF8m?=
 =?us-ascii?Q?apnFPTPMAJH+avThs2Qysy6Asi+bBmSYuxJmayGhdCZ6JsVZH5KwgpOULEOt?=
 =?us-ascii?Q?Q3w6W64pJbcOfPWvY9XBolDzchcHsic2AtIeTT8CeV+W6mMn+7oYb+DOs+qD?=
 =?us-ascii?Q?tHdOKZM6YT7eSjBLEh/hkK7tObvdHjZBV4Fq6r1IlvdIGhLJGPiQcdwvQdo/?=
 =?us-ascii?Q?WSF4xa7bCDde4oQzDPyZ593psCOxrhBtq7mWbYLWbA4gJ3L5yS3rS3ikwkNt?=
 =?us-ascii?Q?2mzVtdkbVcQ9r+kq0oAIbtOPygG4r7N4M0vHBYN8AsVwpUbpLgrbnPG9VpJx?=
 =?us-ascii?Q?oSKWKI1SAyLCOXW1YLuS6xehHQDcd/8g5yIIiuwI0XWmJAISVhCNiG4la4Ca?=
 =?us-ascii?Q?LKJXMt7nYbDx8rU3bSSybhvpFUZHiCmmxllTq7KlCugrACrF46db9XVCRxcA?=
 =?us-ascii?Q?o1qgwjUIggQV8b0zCBBImXb2u06KNfsZMg6UlHJRigoq7ZylQBrTmAme8eL0?=
 =?us-ascii?Q?xSI8JNMzpvOx3OW68ZPeebD3piv3AWIXDacHuegFeJBW6t7zeMgmHQDzrm7e?=
 =?us-ascii?Q?eSMOYYm2pE/oD2Xx2P4obeIr5KnkBpq7JiBQxONM1bf9dpVgwLPvq0UFSlIS?=
 =?us-ascii?Q?M8IJpeL/4RhxxqAnMFQI9z7QhqPnpZ+UvROZxR99No0/h2rGkHqvFyAzPb/t?=
 =?us-ascii?Q?aZA7DNUNnmZ9f/7V6ogd5HcfMP/YogU2++nPOTXx+7einBy23YinOu7hIp9J?=
 =?us-ascii?Q?tIaTeUwu/hI5kuJTSAkdIt2PKuJAZVw7GPS1fI1IOEE/9rte9Y1c2gH9teoK?=
 =?us-ascii?Q?5AzeFzCEDghP2u5iKOprSZnBmXkBb2+bD7Suu7udf+fC4Pfglh2rVUD8uTRR?=
 =?us-ascii?Q?fFYTKNRCzrCCqV4kZUfDbVhbs2qRyUNP3Ca4VzFQxZD0yGfXI4yCNdTjHch+?=
 =?us-ascii?Q?ZItFKOa1swFp4d88gyK3dUhKpXzUJIdKwFrk8140/byegAIi7A860JP4TQ19?=
 =?us-ascii?Q?vyaNATLRJVVJ266nNgf4iAWPAeAhGsw/OAS9EDvOAQW551yvNF01ZPrWUGkX?=
 =?us-ascii?Q?BE5SFuvfOCruj5pFrg7RLeKFhqsEQIqc6y+mxMT7yTDDuT+mqP8PemXu2ft8?=
 =?us-ascii?Q?v/e5R1479JBnggzECuAqEdjjSlbp70NFdb0JjvTW6ZcXa/5WqvGwRBW823qg?=
 =?us-ascii?Q?NR4WbE31tAqdaZiWjZEeGUNi8BXbdUKmFFox3N2nWetGrafirpAzt73XSm9J?=
 =?us-ascii?Q?a+9fQSvZXb6uTuL90JMiWBH84GFurFvOO9wO77esBL+5d6AwYA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iixag1ZNs6KDXeR0iTBJ6/ofZ4hqbPmKbF5Dn8d2tvorFc4ov3Dp0H28IFVU?=
 =?us-ascii?Q?Db3Fv9fIpaVWovg1l8Pj3VAdUFeH1em6Rd+KlnnQhsZ31x4fnZ/m/NN8CcWr?=
 =?us-ascii?Q?ljwabH8b6DsIuPOBWk9AsnQbX0rv2EHjNkgM2vhslwHk/s2Lmo7BHK10i5jA?=
 =?us-ascii?Q?wtNOPJbfrNgdy4QRUJ7VVTMcKEZt0hQC9PJyooJKHvPfSwBYRPnUQtQgmWid?=
 =?us-ascii?Q?udsHCx2A8t4D5XHF+KqyBbQg4yLI9m2RP7lYpxIl9xbF5MCQKAhKDmGv2+1R?=
 =?us-ascii?Q?ZlnXnuZQwhQzC5Flm+GkqdrYE7lwQEf+tZ8OSR4hS1KlfEkPskfY/k3Q96eT?=
 =?us-ascii?Q?3hFscuaS8jXl6oSVPCr6sNSwUKwuYiBAQsk9K4JAVXkVEnAX7eFD3tb33Igg?=
 =?us-ascii?Q?QGcZTrF3EpVaFW4JIkmgARbKCQE29Ww3ngtOo1JRQxuy6kJgiJU4cugrCgON?=
 =?us-ascii?Q?pWzMIMcWQKGSLux+AW85opPuJTihk5M7WcMr15Sp8Dvk+NBHZGCkOAzZJKLk?=
 =?us-ascii?Q?RY2AWZXHPWLUoR9VegFjoUeB9ezuZgsFe2pZ8z5SBk29ZnHeKr/oE6DBRB+N?=
 =?us-ascii?Q?RFm0Tg5HJT8jtb3JuVLHTKrmzZi/NBPct1PmtcCuyCrZAHPeggnREPIumz4Q?=
 =?us-ascii?Q?Qg5dCrN0Xfyzz+szjPF8Vn81vfQkW8SUh9gzG+ffylvjk++CDX2ajbHHJLp8?=
 =?us-ascii?Q?Wa76wSZIGgMGj3k6XuEQXeH51UlP8G0EtKo+uRKleM1OhSoI+y9AF/FGjysY?=
 =?us-ascii?Q?hV+CtMNwiygfwV1Mh+Ulqw/p+Kw/u2UNvD839XWxvqCAIJUkgjRR5Yvzi6IM?=
 =?us-ascii?Q?Vjnet6c+srOP56TmBqPxRKYGprUaq7mlcB/ap0icWTe2GNfrd9Mm07rjq9b6?=
 =?us-ascii?Q?6u0rRlOmqb8GFdlV88MF6eZ/Jr5Vazj3j1c9LOqLMLdY7XTvCdPVNw+11RUY?=
 =?us-ascii?Q?C0KQXEy7It6Mb5aJ4KlncQJuwcZ3HZ8bR05hOv09MWjUBmjBGOCXDKcFGTbQ?=
 =?us-ascii?Q?rP7qe6meLP0BCJGxS+86k30stGjl1BKA7aMYkAgOPxMeSrV1wKy89f0CJwXi?=
 =?us-ascii?Q?JrCO4bQiwtE9FNcVmMF0tgpkt1x/SZVUi+9Fbt23oYBZ85b0KHHjvu28mJBE?=
 =?us-ascii?Q?FHDnY11GtEmmxwroBitrTSwq2A5bTRO+MKbwvxc27mYLIjl4dHBbv+hrwz1J?=
 =?us-ascii?Q?5rNWFAzyh4sc7wiHONboiQGagNx0VqS78LOI5KyxN5ayEjtLb4Y7YyG7jgBf?=
 =?us-ascii?Q?hOVivrd3Oefyq1gddX3D3rlXN/DzWmIYluh4x0ydv0XISg9Aty2PJsuta4Vq?=
 =?us-ascii?Q?Z9m8GMvz2O6Zi+HzDxr6WDKECNwz5RZe2k2TQKxi7pttY3LoFbwbhKSeJLBc?=
 =?us-ascii?Q?W6Yd1jufnYeHFQX+9KUmbhg+Lz9llYhNdLsODQoYRowpUfynG27UhjFzFd6X?=
 =?us-ascii?Q?D90kuFGBvcVO5pM4Hqb8lArGZOB06fr5qmlEyq/RG3XLVONPfvcJCgZ9J6eC?=
 =?us-ascii?Q?2emKSJktjkpeoX+mHJ8tBnU4CgMPvahzZjQQF4nIg56z7nFTd44Lhw1sl8MX?=
 =?us-ascii?Q?54BqwstCSn5JO0j34CPOKWqdCMbxiJTIIm8cMRme?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 353b7308-ab1d-46b6-506d-08dce1635152
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 15:19:46.3804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wSYNxxi0KS7UpiTeA8Uc9dsKsDc88PHCVDf7yo/1A0iY1lMZOtt+r1DohUZa1KNyUMFEopp5vftL0DKN+NF7fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8844

On Mon, Sep 30, 2024 at 11:30:55AM +0200, Stefan Wahren wrote:
> Most of the parameters are unsigned, so fix the used format
> specifiers in the debug message in fsl_lpspi_set_bitrate.
>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/spi/spi-fsl-lpspi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
> index 196cc68f2057..3b5aa91079ae 100644
> --- a/drivers/spi/spi-fsl-lpspi.c
> +++ b/drivers/spi/spi-fsl-lpspi.c
> @@ -351,7 +351,7 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data *fsl_lpspi)
>  	writel(scldiv | (scldiv << 8) | ((scldiv >> 1) << 16),
>  					fsl_lpspi->base + IMX7ULP_CCR);
>
> -	dev_dbg(fsl_lpspi->dev, "perclk=%d, speed=%d, prescale=%d, scldiv=%d\n",
> +	dev_dbg(fsl_lpspi->dev, "perclk=%u, speed=%u, prescale=%u, scldiv=%d\n",
>  		perclk_rate, config.speed_hz, prescale, scldiv);
>
>  	return 0;
> --
> 2.34.1
>

