Return-Path: <linux-spi+bounces-11520-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4619EC85D27
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 16:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2C0A3A9A6A
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 15:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0F91DF246;
	Tue, 25 Nov 2025 15:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="avAoVcQ9"
X-Original-To: linux-spi@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013036.outbound.protection.outlook.com [40.107.159.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D805224B28;
	Tue, 25 Nov 2025 15:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764085559; cv=fail; b=UpfFVUDe9GSLQouqQjjQ1PhjdSSj9hFRNmeYH0q2WssyKO/dfqyizO7Vk45fF7a6x2j+zaOiVM9a0LpzfkLKZbqUYkhUOra7bFfswAqshaIh350BIvSPgeyhlr/d7qWyvXfS+XBBGxD00uz2GDRoeChe5xV3FcrpJg5aJbm8oW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764085559; c=relaxed/simple;
	bh=suCL7FwFBMwVPFKarF8eYB00amjY1MPegy0OdWFD0GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qa5Nd07pDVsI9YQ3KAaYzy3N92/82naTbxm0SRS0r6mN2C4kJ3vIWLDijCq+wRmUO8YojJQ0SVCxurCKAzXPP53p4sVJsnduKVqDE07i951KqgKHFk4pfSU+LoaReqF6yS810Gd8IjbNnlfrlPIk4BI9TjQkJ2AgauDwJ+UBeqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=avAoVcQ9; arc=fail smtp.client-ip=40.107.159.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l7Z6tUjBYXy+mUk2KkqxngNuTfZMWxT4wI2lIgWA6vW+NSiMUxlzNAc5eFOTlCC4LSCg5RAtYZil8yLk3LPwKJNj7zYK8+vCtnw+DF1oddYMk/YSkWCF5CxigBnDZ2Ywhw311UXR2ED1nc2gu7aFuxKFtWTSlkh8FCjNJFNb1wUD1is5ePYmC07vSfV67NX6KbuO1LtNNiBU/QQwP7NeJFQCSykBD1Dn/yVwVk/X0sXT23VBa0jgknhYz13hzgCn8X2vS5WznoMTSRcjzGUHg8CW5sElAeyI9lJ5cz9vrkaF1A0MRxIAGnn4jYChHOj563xqU/dvneCpvtMxZOwGzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=quIgj009FucQ80i8QDVz9kixdL2VKNSELCFNH9+KuEA=;
 b=PuQytI16xMjVi0ypiCK24W/wDnH3ZIgKXFu/ywwWncWtuVAfPFxLdUt8hLu0ODdSRYJPHaOJPOOhWK+hg0QdDX9sLlWJeyy7LP2zPV0WspTDhSlcmh2iC1n2h3P83WoQlMXJQYB+m9x+HRPEHp1LmA42r+UzHu1tr1SUofoaHwKDHK60rSk2ru0M+JdZUD8VKhW0V5viTDgr7nbsZNVQCLTGzn0JEz6zO81w1WTHo4q96soL4zJw0p7+PE8O30q2OrRGTmNfF1LSzvRYsfSlo33RDyzhGyVy0R/EbKF13fIlgEQcf9CWb2SxinKbxEMm6qewlZtocSQHfj2RUu3vCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=quIgj009FucQ80i8QDVz9kixdL2VKNSELCFNH9+KuEA=;
 b=avAoVcQ90SF6Ug/Yu67SoeQXl6aBZgnpzPK8PaV3uu5IEdnizECR/hxoWFYVZc7JcDwejP43S4KYAQfQTCnHtSk63Ao6NvLneK39T3mnwzlJNui9neiEM6cF7bjEhgbcgb2NubbwPSpoqG5UwsYqvRaqheHyei5ezhIclijqRQTdrDvVPmfRGrGhhCzC9q7YqPbYFSOSaXrYw1VVoS/0w4tYuR2HCu6U1NUch4BgfPJtRHMAT21C2a9YI7CG/SiuL1dOKyyxqXOEbYrJP3C6B9uMuZThMFTblC7EhH41GVBye6prMck5bPcZoUU9mPCDVI6o/jqP2qGs5tbJ9JqKYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DU2PR04MB8839.eurprd04.prod.outlook.com (2603:10a6:10:2e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 15:45:54 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 15:45:54 +0000
Date: Tue, 25 Nov 2025 10:45:46 -0500
From: Frank Li <Frank.li@nxp.com>
To: Carlos Song <carlos.song@nxp.com>
Cc: broonie@kernel.org, hawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] spi: imx: handle DMA submission errors with
 dma_submit_error()
Message-ID: <aSXPKjFROYPZ12jo@lizhi-Precision-Tower-5810>
References: <20251125100618.2159770-1-carlos.song@nxp.com>
 <20251125100618.2159770-5-carlos.song@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125100618.2159770-5-carlos.song@nxp.com>
X-ClientProxiedBy: SJ0PR05CA0081.namprd05.prod.outlook.com
 (2603:10b6:a03:332::26) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DU2PR04MB8839:EE_
X-MS-Office365-Filtering-Correlation-Id: d2378f0b-67bf-42a0-d9c0-08de2c39b79c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|19092799006|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9SH3L6xVI3SDuzXECToVN4SrhmZvqnGXI7eRxwIM8OmYzadqETEjn8LUDyyW?=
 =?us-ascii?Q?OVNasZBgCrYehCQFuqHU5/rxatqjYlWfcsaIxjulaUXIQc8VyCJZ0QB5iRTl?=
 =?us-ascii?Q?jnR4omi24sR6MbKgnUdK8Sn4rpB14nkOXvNuMlYrexLTWLDzMHuSkuevAVHH?=
 =?us-ascii?Q?/J9FfVsivOgiVt+190RT+fY50JK9R6N4dBcXrTIbcIq7Wn0EAJUJtLQYaOVD?=
 =?us-ascii?Q?zmFH4qRh6kHGyGA0BYjBXAjzslsaPNVm0i4fdvJmzDzkvLe7qLyfRcjfPuIl?=
 =?us-ascii?Q?4fNL8kIVX9z+AbG6Yo1TRpwQnqPLkJhLPM4q0bAT+i4r25otysiauoEhRUXY?=
 =?us-ascii?Q?mtnxNcqegIqNByMvUrq7KmebtFdSVPPPhuNNZRImrMvWghxrYq9ot2KVzbTf?=
 =?us-ascii?Q?vjJS1Y+eWEwuHgFgnMKv3aVwWCBLZQkAhlXz8ycujusEz3rfdzKlq8qPhux2?=
 =?us-ascii?Q?3l7UpTD7TidN3v/Cfag1b+qHJHqRm5aVY4oABDK/lTiPLD6cn+/vvsyxrBCB?=
 =?us-ascii?Q?pdt3GWT1+SXiF9PNhNH2XI/oyX/fxIbqucUsqbRKPth+e4gFgdKwXNRzV3yt?=
 =?us-ascii?Q?6woxH//o+b8lr8xpmFwsi9b3P3PyYg2383wnHSoC16NF7C4ROhrFcYtkTLLd?=
 =?us-ascii?Q?y1PyrOK22pLdtEXtsGnkUzVRM0T/5mCA1l5hEeTWmk7cALuV0OkIt94pDNrt?=
 =?us-ascii?Q?jr4AisZpNt84tDOPs2mKBHPP/YX3SdLJBNohMKDzStZPEYR4/hCvCnHoZBDH?=
 =?us-ascii?Q?0r0qVUOGeu8KqtDmMiK7t1b1zBHAyHd8u44ZRUtS4YIUnV6GJs4BQ3QpDzGG?=
 =?us-ascii?Q?B0vte8Yzz0sHtJ0U2Egu3NPjZYrHIsh2EIgzJbpTsqe4fD6/ALagArY/Z59S?=
 =?us-ascii?Q?qetXUUL6ljmYmuFBrluCZ5cdI9soUlXwjNkQHUeJYIcLfsLHxIbox+5zb5NV?=
 =?us-ascii?Q?kvp1L/b4bcu0inSN6kRsZWzi20KS563P6rEiNnj3KgWfRhAP3HY1C9s3Hygv?=
 =?us-ascii?Q?tEqypr8zTfudgwC5vWujas+5ZEO0PZwh47E8irLEHTFIbefB1YLNI5unju2s?=
 =?us-ascii?Q?uiv/rB6aBF7LZbGzFC/pPlzwy7itIiFXLGn0eflMB1HcLVOYaeSe8IRy4Gqn?=
 =?us-ascii?Q?e0nJdq6yaLmQXu10jVyoXiVATvQCxovrnK1Na+I6Yl8fOJd9MegLPrHHUD7C?=
 =?us-ascii?Q?xjTwXOmLWHubQNVjQffhdy6IeZASB7ErvkxjOg/0W2IPJ0+Q7y23mO6+zVe6?=
 =?us-ascii?Q?ChIc3YDgikoRDRm6vliAssRotEJ8fObRbeYxT1WhxyXc0gxyYRuzg1DJRT+R?=
 =?us-ascii?Q?4+LudsyU2VJLRBT6H80atvpPoOvjNJRWvQ4JXiNNqyLq/Iu8sfUpIUjVPiC9?=
 =?us-ascii?Q?NqzC6//LNIXvk2IQF95DnEQvSHK23WRUsV2N0ROz9xghG9tQq0aXGjTfnpkx?=
 =?us-ascii?Q?7DQuLFI1ChzHfu8Jhqgog2JwN/Bl6uL+CotJpcqCnpfrEQtwRschC6iZDWCz?=
 =?us-ascii?Q?bXG8cRAj3IPXa7iozsu490ms4a6pc8WnuOhp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19092799006)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UTXQ9KcCiEGQ6PDPWuWNIzarpXa3PtsZuG6fZW/XL/2ImVXmbvr/bERBvX5Z?=
 =?us-ascii?Q?PauwzPhyVQZbiSLJHm96O/YcpJSE1g8MQxn4bV41QIPcXexMpOngGRPkXkzQ?=
 =?us-ascii?Q?jPaV0/sDQFbdyLGr7x09Wsu+i/xz8gL0cVymjbHEg073ej95Lpk0Na5A0qxJ?=
 =?us-ascii?Q?wPMReuVCqnxFa+ldYBqiRoxEJLluw4Ei18iQtc56mbqwHxDKT478H+D6WmkC?=
 =?us-ascii?Q?bVrpr2ZQxcZEh2IDDsDsjhTnchWSuJMI5QAmsQL0EIwJKUTABoIp8NiX89Ac?=
 =?us-ascii?Q?zb/KI8KpwJGC8hHSUpmTpF8T/WHIAwo175O71jPxHQ8tofdC2pFVM6kZaMQt?=
 =?us-ascii?Q?zE3BS9Jkyz0Fu55nWlXqKdyEOetK/46zuk2cfv08rHcU2nY4BmFy52jj+BB6?=
 =?us-ascii?Q?64cARu7J2gOoAZWLUR949ICkWKJpkD7oiV/FqHK9ln48SeFI6qeiJwfbTn6/?=
 =?us-ascii?Q?V8dl7ByB6jyweVHx/LhMRj2MCWrZJ3mvL49H52RPjxvesdzFHh8FrstVUP8K?=
 =?us-ascii?Q?CMedth+78H8aoIJhIrUoso09aI0VSEh3UE6QfI6mBezREfV7iyb9je1FpVi1?=
 =?us-ascii?Q?QaC3iZ0a0JP22k63jcgj+LX20dt+/wKxARg+dxGGW0H3Zwmh63PiwiklT90w?=
 =?us-ascii?Q?L0iUgUSdfuTmWrZR/OMxjkL0BfZeUMY8XBKPTsWzls3Vn/zXJmL2VAZGcTqd?=
 =?us-ascii?Q?98DzNlb5afHiDHOKAFaVuH/CHzNda2Cn53VfYMQzDyIGPBWJQJvXrU214g54?=
 =?us-ascii?Q?Fa7na+M3qwLfvYP6icPDgMsD/8y1vp+HHW45peWmWGfTYSQtZPPocZeyJATW?=
 =?us-ascii?Q?/qw0ntqdJOVIrg9IdesDi3SmmzLDCUNqidDDct8djBK8qcp6O0TSHkc3lLW0?=
 =?us-ascii?Q?9Ehnf/lV2qNSrgkXK6+pV6k/2iUiPar2GmOovV6JsNAdfMk1KFfZDUjckxh4?=
 =?us-ascii?Q?yxsSLZocFneee2B4qInWHVm9HDhqXhek1HtiN9wmEDGLmeIVgh3VvkOr7W1T?=
 =?us-ascii?Q?L35Hwzexv9GcZJUZOCG/kWA9JEtKzJmcSly8+jT5HVApQwOqIWENpunpKSsd?=
 =?us-ascii?Q?cZBi/K0VU1EsKLyX6BV9P0i+/lOogM/beAidrsj243IoTBqHS06UbqfB3QaT?=
 =?us-ascii?Q?yjN8n5JkuihlI5LMxTavZELTIvL/HlPcg7AdPpjInEuOHacum4zdmO2PXlDG?=
 =?us-ascii?Q?/Gc5IHAeWXKBJG0XWhUiRvXV9NKnqBYwIfX5a72V5Z+OqafLQJsog51c8EkN?=
 =?us-ascii?Q?nTcaiihgix0Gb+znh5eYyrGQnw22OJRGxFVK+nWn71ntTh/V8Sk+Vw39ohlC?=
 =?us-ascii?Q?f2Ki0jpnaUvtxLGNWgUYERftv1G0P9yjI/ULka+sS5WgmbonQ9eG/mqE2TRl?=
 =?us-ascii?Q?XU4uU8ydJVnOHGKjAnCMPrpu7ZZxL/4qMaU4Qo591UTBL2GtGD/Mubad1zx3?=
 =?us-ascii?Q?wuSNzHxU6P85pZ8kkSzoahkvrhc/rFoc1EhwRsQkOCBn7nKmtwTITvRTT5Pd?=
 =?us-ascii?Q?Xx+6Q5lKghG6bIjqW8nrtwVL7pnfraSZN3C92bvH3TumE+hX5T/ecJwHQhk+?=
 =?us-ascii?Q?ZVlvJBLEO1awL4lIIzi7bXQDZNuSMOGFDjKxGlR4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2378f0b-67bf-42a0-d9c0-08de2c39b79c
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 15:45:54.0039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RX1+wnvgeq/B6Wxw7bafE4DeTTxDSaKYIE9GzOTbFKNU/0fqvOEKdiNt7MwUdhhRPvYMlH1EKc/8LfrteUF9eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8839

On Tue, Nov 25, 2025 at 06:06:16PM +0800, Carlos Song wrote:
> Add error handling for DMA request submission by checking the return
> cookie with dma_submit_error(). This prevents propagating submission
> failures through the DMA transfer process, which could otherwise lead
> to unexpected behavior.

nit:  remove "otherwise".

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> ---
>  drivers/spi/spi-imx.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 186963d3d2e0..42f64d9535c9 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -1445,6 +1445,7 @@ static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
>  	struct dma_async_tx_descriptor *desc_tx, *desc_rx;
>  	unsigned long transfer_timeout;
>  	unsigned long time_left;
> +	dma_cookie_t cookie;
>
>  	/*
>  	 * The TX DMA setup starts the transfer, so make sure RX is configured
> @@ -1460,21 +1461,29 @@ static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
>
>  	desc_rx->callback = spi_imx_dma_rx_callback;
>  	desc_rx->callback_param = (void *)spi_imx;
> -	dmaengine_submit(desc_rx);
> +	cookie = dmaengine_submit(desc_rx);
> +	if (dma_submit_error(cookie)) {
> +		dev_err(spi_imx->dev, "submitting DMA RX failed\n");
> +		transfer->error |= SPI_TRANS_FAIL_NO_START;
> +		goto dmaengine_terminate_rx;
> +	}
> +
>  	reinit_completion(&spi_imx->dma_rx_completion);
>  	dma_async_issue_pending(controller->dma_rx);
>
>  	desc_tx = dmaengine_prep_slave_sg(controller->dma_tx,
>  					  tx->sgl, tx->nents, DMA_MEM_TO_DEV,
>  					  DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> -	if (!desc_tx) {
> -		dmaengine_terminate_all(controller->dma_rx);
> -		return -EINVAL;
> -	}
> +	if (!desc_tx)
> +		goto dmaengine_terminate_rx;
>
>  	desc_tx->callback = spi_imx_dma_tx_callback;
>  	desc_tx->callback_param = (void *)spi_imx;
> -	dmaengine_submit(desc_tx);
> +	cookie = dmaengine_submit(desc_tx);
> +	if (dma_submit_error(cookie)) {
> +		dev_err(spi_imx->dev, "submitting DMA TX failed\n");
> +		goto dmaengine_terminate_tx;
> +	}
>  	reinit_completion(&spi_imx->dma_tx_completion);
>  	dma_async_issue_pending(controller->dma_tx);
>
> @@ -1502,6 +1511,13 @@ static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
>  	}
>
>  	return 0;
> +
> +dmaengine_terminate_tx:
> +	dmaengine_terminate_all(controller->dma_tx);
> +dmaengine_terminate_rx:
> +	dmaengine_terminate_all(controller->dma_rx);
> +
> +	return -EINVAL;
>  }
>
>  static void spi_imx_dma_max_wml_find(struct spi_imx_data *spi_imx,
> --
> 2.34.1
>

