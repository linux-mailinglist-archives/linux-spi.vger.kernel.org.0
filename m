Return-Path: <linux-spi+bounces-11459-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6A2C7AAF8
	for <lists+linux-spi@lfdr.de>; Fri, 21 Nov 2025 16:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D40A3A39EC
	for <lists+linux-spi@lfdr.de>; Fri, 21 Nov 2025 15:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9879E1F09AD;
	Fri, 21 Nov 2025 15:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="E+tegDxp"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011070.outbound.protection.outlook.com [52.101.70.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BA6346FBA;
	Fri, 21 Nov 2025 15:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763740472; cv=fail; b=t4e6bsoTOVZQW0lHmlpOhbsJ20yXn/R0HTNTvQ13PefhGgAdJYS18ICEz/M+kTMbbb3H5dIRI0srAyB8gxKnhFZg9LpIjpe/+L/3RvfAY4pibTnH5vfxYm323haNHn0E/Ujh1+4xxqaOEjCiSHQiQJ1Cwh3ev3A1pZ2EG/Gjsjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763740472; c=relaxed/simple;
	bh=jOh1bLjP9oqYbQzeXO4e8a0FayHcsN0hH8fxzJSmWBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vxsd3XNlFo8BHYxzMwdFat0zQ/5F9UECT2IqfdPHDkckllieDigfyKfpf6mqC7Wh4nt/ZkqoJV7fc1b1bQZ4vehYL5hRaygcSuTlwdR+v8eOyF27PJBP+JSstlnD9bvJVYbScpmX+QGP5l+twjE5Di1b5SvcMtiPbh3qZLJFezA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=E+tegDxp; arc=fail smtp.client-ip=52.101.70.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bcte20m53btgc8ch4cpGNeA04+8Fd06oqCT3xwmjpwBJIdq6G+lap30+2RXcs0+9vF80Tphh09Tk+N8bfbf96nosQSsbHnqu/EI7QO6SjXiAa0QPUWvhnhHJgqo1LL+rYjAyqCfvHtW5JNDqNVlwCbxOm28m1n48om2H2RxPuZDxMzJiwUN9SS/58QAvt9b3GBT88rml2EJYtZvYujjfwS9fsBOi4o+UwhdZnEqVdbRr+ZZfG5d38sGWGWfBqqxGG1UWMEeDYRVLG0WdxILeZSxHEsVQs5Q2QdBHAjGl2su4x0mJJcSNeCwESYUCqxgqB3AslPaR/+50sH7tCUyFHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+sNro+nYIUBb/6yVrlXxhvH9VAIxBUjEwXCUpLJShN4=;
 b=QIYQorvoXyGgzGTSLrJIy/H7qhkhII19KtCOHEspc0kVtCXNobtPMiQd+MniXqn+Hz2sbnnrD/z4xKv/8XT0eXqHr4X1BCgYxHF4PMv3gXHjwtXyRn0h/P2Y0tKa1n4yqkG1Tw7gLq5U8JpDEkCqzlKndIAvynp2D6ulWxokbllLUZygcK2jaUd0r1qQVsQOIB6UySm1EWruW9+pR/lWtglqXRuywUGoDhiiwEX1YV/SpeNZBk9vwJduzkfV986Fw4vroDd3w1YESROXWXeKHFZZjYiBLAamMHzpHDlZPXa14mVkWXG9cKLnwFXDrxq2A83F6T2lr/Cpm/bcl23dUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+sNro+nYIUBb/6yVrlXxhvH9VAIxBUjEwXCUpLJShN4=;
 b=E+tegDxpUKtj3zQsSHJBND51KEJyHGL/3hrYyCRSpG4Q2DhrF1yGA/v6XXcTmDzXHkqrjs4g4BUsaOHUFVllYH6X4rYRaxEMg/nKqwZAUx9wMUPWaq1xjALQylNHN6uf4G5ZPBenPVfOVoggfhAKHtQBciA7m+q+cuoFEcl4SAa1wWLcZ6JEyoSScLbdpkPbsdTkIXc2CEPeKH16sP/hQC1hmdpvBcuLIWQ2HcckzR+SAqQEQAPhC+6K5kMnN0mt1vQiEgFE6hSTaJhaz1/L/D8TyrDITnM5LBMGiQPslo85F813Ez794SbYX10QD/i1510K1jYIW/dO/+wLaIE8pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DU4PR04MB11845.eurprd04.prod.outlook.com (2603:10a6:10:621::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Fri, 21 Nov
 2025 15:54:26 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 15:54:26 +0000
Date: Fri, 21 Nov 2025 10:54:19 -0500
From: Frank Li <Frank.li@nxp.com>
To: carlos.song@nxp.com
Cc: broonie@kernel.org, rongqianfeng@vivo.com, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spi-fsl-lpspi: fix watermark truncation caused by
 type cast
Message-ID: <aSCLK6wEaIbeJp3h@lizhi-Precision-Tower-5810>
References: <20251117030355.1359081-1-carlos.song@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117030355.1359081-1-carlos.song@nxp.com>
X-ClientProxiedBy: SJ0PR05CA0172.namprd05.prod.outlook.com
 (2603:10b6:a03:339::27) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DU4PR04MB11845:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b3ed3aa-41ea-4780-a23b-08de29163fa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J5uo2IbDQb+sxH639E3qn6PUqS+rJlmMb9vmO8cht83DjzkvqbU0GP/gEno6?=
 =?us-ascii?Q?wH6H70eHS1F9dQjIy2sT0WuZdCV8pN95TGu/1FQfkrU3FHrrrBmzvnkGIG8R?=
 =?us-ascii?Q?EPwtSRRdtmg+LlH8kvPUfAjxPZ93dxCzrrJlfpk0fMfVsltxdZoeR06WQAwA?=
 =?us-ascii?Q?l193566ripLY+lNYk7nI6lkhtbLrzPMrALL9FBqhlZZXZbmZ8dMdhg+4oaBI?=
 =?us-ascii?Q?5D8lSgbLvBIG9brrq4UYC0NWWaIVDgNBthwEFa96W6U26GcjM6eosCHc/unb?=
 =?us-ascii?Q?YTRkbbG9TS9nBMaQQEHTM3ahApyuUFwyIab0wk04cBmrnlXqmf0WeQocVnI7?=
 =?us-ascii?Q?ePERGMIMw16xsH+ZXknvBgNnHQxnrX1KZx7/WGh4kR118y2OF+ABFTFl+m+G?=
 =?us-ascii?Q?ZEO13ZSYAK1mispfaFzBVMunfHP7ZJ8rk3MhTawq01uve3EDqOqSf+kniVU+?=
 =?us-ascii?Q?pMTIaQUQjJSdYY07hQngC1+d+IVgxXz0b6BVv9/Ct4p2umdwydeMluVHkwm2?=
 =?us-ascii?Q?rNq5dveRo0D5P6a15S3OnWYBc2BNyIsgZNXwQHjkVtGLRi5+0P/PwYE0hC9J?=
 =?us-ascii?Q?+VVJ7qrvvASyV3nEv5pKi0a74jYhdLOsblKVcR1zckRDv1XpghzMuKyy+0TH?=
 =?us-ascii?Q?Cn6EAtAQsRhBK/3NucUNKXLOnTOxxy7SuDPNIpVfswBO1jTXmk+9nhN0sQay?=
 =?us-ascii?Q?iIX205Ug0EVR+eNzEDJwcZU/wUi9NC5CFMunEuASVqOicTU4RScODZ//4HY8?=
 =?us-ascii?Q?NE9BV1AAVReb0UVh+MndSAJCJsPXZAulA9MGMExe5kktpJ05Vl7PYwLBxVcj?=
 =?us-ascii?Q?YcM7uFDERAJ0prWBMTG9WjBeRtJvRWmfEMYqMWF4P+wfvhAFavzQEdlyrbYP?=
 =?us-ascii?Q?Vu3g9UbsJQPhv47+hlnDAuFpLVp06BjXSD6gK5ONnohuLKzYVEWiv1ChVFtl?=
 =?us-ascii?Q?aCKsrd8vugyn7eUPtGb9PConT9TNAe7eLATDHmIYSTo3+WjID09yCwk1lhew?=
 =?us-ascii?Q?R8xPMHhxKeBIuqjEL/9PHnsD/KbFYRaMkZ1p5CSyjQ0h16ZPHBloLWul1Z5A?=
 =?us-ascii?Q?CXFBZAI0DuXS0ZMl4OX92MAL730QnpGPE0l31zHyWoRzzcZtG7NrJ4dyG4qx?=
 =?us-ascii?Q?vIjOi7y9FLBGpkG+xsgRxewIrQGajzrU7k3b1gEfB/+ieTAD7YPQTrA738vL?=
 =?us-ascii?Q?hJlIq8EMHp1/3YEYrc78EaXCeJLgIUJUaail9WwAvpk8/pB6x3YheT48yglq?=
 =?us-ascii?Q?5enuySbOqGxEBXROzR4Now03FyeeL8lL8jRFceFt0sEk2Rg/4ympLh1NpFMl?=
 =?us-ascii?Q?zeohTlXTq9lj/koUOy9/6aEbbUeu77ygrZ5HRUui1W30Ce8EPOuLJU3l7Yxu?=
 =?us-ascii?Q?BKag8I/U+ENO6rDfS4asOFgAFmDHFobkGn8QXAXO11Xn1kn6lTH70ZiqBi+0?=
 =?us-ascii?Q?TIIQBgIKvXloUrvoWagMdjsECKjjfv2poMOmvAvsI4TQMAL1CYBFTRgwXa7+?=
 =?us-ascii?Q?6lqItBxEpCgVgAYPPf4mzH8qi7GbkMJkGPYW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GrvRc3SsEExCMEjv/w3QwmwG9QvmMZ+GdbL0h8yALsWcDdDg4Y5My2zKnm3l?=
 =?us-ascii?Q?Lb12APhc3tot7HojLOR068OhxaeMKg17lTYLYEeDMT+DIkOAVnaT4Nd3Hn3M?=
 =?us-ascii?Q?k9Hsv5f9n4LK9l9eZpZ9x00+EfpLDY1Gs/adO70CpDU5XNFbSQ23JS18Wo8Q?=
 =?us-ascii?Q?CZROcUro4W/dE8PDvEbIeeN7hbOF2Q9EnzBbqLrDUE1+oOniL3Btsd5f8iw9?=
 =?us-ascii?Q?REHmEsn/ATTHPrtRsv9CuNYlXqjEax1ExxnUc679S1y5gsY1wHIbluUCo5rI?=
 =?us-ascii?Q?tjsXMQ76HyRQzLWOI+X33p+JWWjZDGWGBBpM/QwXr7UnSHLORUDFpo3+9SLP?=
 =?us-ascii?Q?XBjMDa522lfvusav+RbKVvt3v+5VVwWvoQm5oLGNO6h0qQBTBU4znwBI6DJw?=
 =?us-ascii?Q?ksdu3h9oF9UbbEXvdrJwFD3EbRgbsgU9r0A4KfcU2NMPo6ttzB5nA36Hy2TN?=
 =?us-ascii?Q?tL50vbY4wYhEvW8s784GJghyo6v01V5fQ5GywTQmheAoH1hQSyBo9NEDY+dJ?=
 =?us-ascii?Q?rKnZ3rn0Kh1F4NrBBq16C0c2dck8fT13yEL18sJee9qoOGfJwlE4bsQHFe1R?=
 =?us-ascii?Q?SaXshzY74aMxMIoWtywxdP2OYFu+SgTFy3MR6MsAgV/9OJLsFpVTZathYbdA?=
 =?us-ascii?Q?AtLGHv6WvOY0PKwNRO5O2kNtmMGeDgSfTzKgl9lKXbpwmJl0NDimz8Q4VEnB?=
 =?us-ascii?Q?B4EFX/GrA/UGvsl2YonbA54kCdzoNPwupQT6P8dUtZIjsy0emSAcklXmHMvd?=
 =?us-ascii?Q?+Us+zMXoGd2ZUsx5Tz9ja/w6n6skL2ClV0+7wqhh5FNsZHNDMfbaUQPbrPXG?=
 =?us-ascii?Q?fBNVAplsK7w/IBSznE5eq0mtd8stee08t8aw0fyDukaPgbQxyHD0+czwTbqe?=
 =?us-ascii?Q?ltReBUqtc8c3afkLqKkvQatAseVgxSE9N1enCcFKB2csfgXHoW7fcHJC3vuI?=
 =?us-ascii?Q?xGFTXlDzYWseXyg6BdsykbN4hElm+dhWKk7bcLRpeL7IBMJwfK/TV3Zeb2WY?=
 =?us-ascii?Q?zJ+Kqb5HN1GJRxAzxl5mVF291FOrcsUSP7DvwxFGJ1aSWTWZIZPtVE+XH4Dt?=
 =?us-ascii?Q?fPJTpe3mQrwZx3YmGHuIYLk2pJZzYOZcv13DoA6Y2gqsEFEfCAAI9qHKRUqB?=
 =?us-ascii?Q?oODU+ySszdQrDISNweh4ooyRocRWCDe+rmGA1cBS8lvrNWaePpbf/cJ+AvZY?=
 =?us-ascii?Q?p7oW2q5z8v/01IDrzr240+Ie4qZlefmcIa4yX+ed2NqCWbCi+J+R3ArUWuOC?=
 =?us-ascii?Q?hlkwvpuVZzT4xi8MVwytUA8J/Zv5Tc7Y8QTY8JCdkoPNvXKSXDfa6fi7b5yd?=
 =?us-ascii?Q?VNDWJm87VeHLPuszMPLv9i1/yW3osytYGBBK4GL4uXFEIHNGyLZcxBwBndAz?=
 =?us-ascii?Q?6oOTGbHB1ogedS0Z+NDGgG34PEW9Ea2GKnOgXFVO/R+o9gdtWN7jVkif1wpU?=
 =?us-ascii?Q?MXVvye8YQe2iLXvOHx6co9foeVCXrxwnKoUZg2AeC0E1sEuWRO5L1rM3DWhx?=
 =?us-ascii?Q?m7MEPzuy76MB7sa2/Hr3RaPJQ8YfRAA8cDspRdLyChAp3MThmKmX89OtYW7Q?=
 =?us-ascii?Q?qVkP9PJi3ypXxiuR0SM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3ed3aa-41ea-4780-a23b-08de29163fa2
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 15:54:26.8232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: shwZeuYrFjqkK3Kvy6ai1kKQuSIbbiGp/SpinFs1dxptXVdwKWz9oDZZX8sAL5egSA8BvJ41nuFPYwP0viYs7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11845

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

Reviewed-by: Frank Li <Frank.Li@nxp.com>

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
>
> --
> 2.34.1
>

