Return-Path: <linux-spi+bounces-10796-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D70FC034B7
	for <lists+linux-spi@lfdr.de>; Thu, 23 Oct 2025 22:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA2AD1AA2769
	for <lists+linux-spi@lfdr.de>; Thu, 23 Oct 2025 19:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A75350299;
	Thu, 23 Oct 2025 19:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="U0B3WLe4"
X-Original-To: linux-spi@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013066.outbound.protection.outlook.com [52.101.83.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A0F34D909;
	Thu, 23 Oct 2025 19:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761249391; cv=fail; b=qVFEUQnDeusDEOmIUVhhGIqZDynE31JlJG8HWhEIlwpMR0x4sMRT3JaUQvMcGV3RjSNyfSH/RhMUN9lYQOGw7BJCpAwtLTAyY7V1Oo7W3xsFPqh4YzcuFR/ysW4ypmYvapQy0CUI1oQDg8s8jHTDlx19paOznu1H89fiGXUeE4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761249391; c=relaxed/simple;
	bh=BhsVaCdZ9JCxQIunoEBTPKrbEfSQzMYkQvyjxlQWx/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WGj8UhR5Ivf4YslbdhOTIhq2uQ+bQn8zA5IIcAOwAES7suN4ZeDUHGDyfY16/pCPyN7r5yi7xh7DN5LjuZ5fbLgAe4nUu2lm6hdZwzRMIbZEO7sC63vzcdL1CWEUfak4WRCSTGiiV6zNnXtiEohN8XxSCAC1H4wMeXN7avfU2j0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=U0B3WLe4; arc=fail smtp.client-ip=52.101.83.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQvKp7dgLoB/9U0xcgatwMq0dfU02+Yj3rtOHTDl2mp0HokUJ60DpI2lDMOB1+KAH0s58IqP1D38bcGNhAqftQZ/8NDTKXXT8TaA3SjrkBMwD5LAkc3eQHlFylgN27ijNT4PpqrhkU3MIc8500k1Eykf8n+E7J+PERGVh1r1QLLUgJPLSatDlOZCpKRXqD7mvFA4F6zL8CLOHkYdyfb1Ox8Yh3KbY05CmVU6H11CyDc3mJSA4OXsj0gvL0xcqo2YXD7TyQ+XJ0mUqhgKvljeyRLzlUyZXm/+Ve6wWH/oB2tJH6TApBbfUGku0CVgFVHTLSK2eEEAV0srtyL4GCTxfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPUnXWp6NCVD36KZlO2CHVZY7/0FISaP5HxIrKkqR9g=;
 b=jc8mAn+0XfB0qQsYZayjplKkBY1Lvr4mzRRWg1tfuuw8UdRoYfWFQx9ZpliiRiCFYvqi45sKoKgqe9MYQaQijOVSeGzAc/vEWqDI7hBW07/iwzh4dhUwe7zwTASO4yq43R9M62xgURfuHYRf3j/GTjgKUAYpoeeOvP3Q3i2bUtAgoYUvEvL6Goo2fLoBIInZg45Pt2thvzG2lBywv61YpdsKshYeHDJ+MgBr6IKr+SHfgl1tyFTiPQQJXRqTp2aQQ0I/vIRF15qWOdcl6Sc/mthYxloPE4X/B1g053xLmkEJRbcfjLbQk/yA+bd9habn3s8BAdlrfTVfeMPnLVi96g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPUnXWp6NCVD36KZlO2CHVZY7/0FISaP5HxIrKkqR9g=;
 b=U0B3WLe4vawE87Ja1SJ+MvYCb5FNzMAiFPMyxKgFxmiDm8hvXjN5UqQR4VjJIfeklKeTSH4wHlwUiIGIa327am8rD6YnP6NJptJDm2oJIl8lOnXInNLTqfyk1bE16o38x2MKo9nNcwDawrXSJKxBa2LLSzszPyKP/dZloxXPHKvNTg53fEnb+UI4gibq5+5GdwD8FIxNoZJWvFNRNgdu4NsxpCUim1P6Jhug2smSld5Xtrcf6Blhq9XO0z0LEqkz02b5sU0s/Y6xyZABCSS8YIRuP8AgNp56ZcQywIjj9jFIfOHhmHM+TXQ+3GrBnz5q8WKldkiDe/NbGPG+XOcJOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11)
 by GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 19:56:22 +0000
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::b7f2:1d0:6b6a:ba58]) by GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::b7f2:1d0:6b6a:ba58%6]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 19:56:22 +0000
Date: Thu, 23 Oct 2025 14:56:15 -0500
From: "han.xu" <han.xu@nxp.com>
To: Alex Elder <elder@riscstar.com>
Cc: broonie@kernel.org, dlan@gentoo.org, Frank.li@nxp.com,
	guodong@riscstar.com, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/9] spi: fsl-qspi: support the SpacemiT K1 SoC
Message-ID: <20251023195615.ke4rjhlgrxiavv6r@cozumel>
References: <20251023175922.528868-1-elder@riscstar.com>
 <20251023175922.528868-8-elder@riscstar.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023175922.528868-8-elder@riscstar.com>
X-ClientProxiedBy: PH7PR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:510:33d::29) To GV1PR04MB9071.eurprd04.prod.outlook.com
 (2603:10a6:150:22::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9071:EE_
X-MS-Office365-Filtering-Correlation-Id: d80b81b8-bea3-42dc-9862-08de126e3dba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|1800799024|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H0uDJChjtj2BwjiZkpeYYADx+4nYbKMRPlOuMX5B4UKkTAgVmEV20LGUJWHy?=
 =?us-ascii?Q?pDtyqfcBYNt4WNeRQSxRvEmSvHUWpccdtqeHc8d3gxcLFEXKnNTsEdplSArI?=
 =?us-ascii?Q?jKNMkLAuS6ot1o0Cfg1CUYnDWNZ+EeyjQ5b98QBPm+q5X2F3Krg44+niceV/?=
 =?us-ascii?Q?TdJi+bCPfifXrwCCjjPNEFMfIIP9fjWQUbgFxGl/AvfH6qGPhO+GXW3QB0IS?=
 =?us-ascii?Q?qC241F3V8y6wfYn/52LgZ+8fuNrR7aQfBKs9fYzCbo7iQLHXh3bY9755MDud?=
 =?us-ascii?Q?wGIxgMcR74+V0nxxlbq9Rg2NE6xulYiuvGgEKs6DLwjARMZBJ5qEFLVGIEdB?=
 =?us-ascii?Q?7/qLweDZn4fGwPJmRX0ijN/P+HjEEKWVUSNIN0oTEeVko+PXEVKlr6i4kC4O?=
 =?us-ascii?Q?icti5ZunkLbRIgy2iAlcHI2IAb6c3EmuW4CNmRkERNkkpQ8LRkJCELUvJZcy?=
 =?us-ascii?Q?Ak4ov0Bx6FU99/biTQhfwLzqepCpVozsII95hoNi21eYv9Y4uzYnPuKuRIZz?=
 =?us-ascii?Q?sGQUbpyhzECgNQ3X6cMYZgcEx3R5cqZt3/xdUkeb1BHiCdA0IPC4EmSEguuH?=
 =?us-ascii?Q?qKIkJMy3D6RDXxkrHa6LgsG1WDOEymO1Lfc3lE9SFZsp5O3PxGY9ee8eqQjq?=
 =?us-ascii?Q?wHY8tzNYEZUPCgN3gdNOG1/yNLv7mTthVxw1RWVdEHAQwTEyctNXJGRvGYyf?=
 =?us-ascii?Q?PAvOVglYtGLTPxJS6sGQhgmzybGZdOX6MQksHanZLSwYWziJgii6cOJE6GhS?=
 =?us-ascii?Q?GsFQvA5Ttm+n9aCNQZX8645ZAlMsvocKgD14RqkO910yreE9MXH6P/ZWAwTQ?=
 =?us-ascii?Q?0pD0jIrJnlvhfitmBF1E/6+YbmoA1f7TxrgwgvHcbqr20qdxPFI6Hz2obsPT?=
 =?us-ascii?Q?cEWnHPSl4a1+4DRg50ckGvMWfrHLs3MLje7Oz2l76AzAtu2FaQ80LWM0MKnk?=
 =?us-ascii?Q?NwLZaXmhbd8Ch5KHvfj05jxaPl8fOMNcuV5Rdyo2bdWS+XWhG2hjrlPKxMHi?=
 =?us-ascii?Q?aFUIszXggMJiYZbp42r+PADSKt267tYKiupn8/WfLNRCywKoxT3hG1mxOwaG?=
 =?us-ascii?Q?9mhB3cc0/vxuzdc1x/IewsEJD6hLMhj6wfwXvkzwRhyKezVT+8KSgFHdzw3J?=
 =?us-ascii?Q?R1njCa90HpOcfwtBNRSpKgzn9WOOd6cigH4VQVNjkRvCIVEoZJf+/HFFfLlz?=
 =?us-ascii?Q?22j04uiLg3qV+Fpce7I4wW+YdJFPblENM5fLzcEv1tHRaf6nVOaunagDNwhR?=
 =?us-ascii?Q?lznVIaUi83J79HHM6/QTR/Iqq4HwKQy81NuyYuDUdC8qjtzcWVQPg/diB+G8?=
 =?us-ascii?Q?gr7Tv42AGypzq8Okmf5h0Qghq/V3KyOMkG/xK5Gclmpl/k9gbceOfWL8GA2E?=
 =?us-ascii?Q?B2Gdy8CrMF3hcqk7W3QhhgvTim9A347WW4tQO4xWQuWn48dGlWtEdAOw1Bum?=
 =?us-ascii?Q?KHCjaq8BK3DxD8zoWhAGXeAJ/MV8D8W9Tt9iAORfnyTdHBl+OUIqdSAZEEJ1?=
 =?us-ascii?Q?k0pqLMxTV2wzmrnBW6RZmG0WgRHXTnsEqAmL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(1800799024)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HU5sFuk7I2/SfnQG2rVUj8WIx+T6dDN1vT56/qgIOSOxojLOC/Ee1piykZXA?=
 =?us-ascii?Q?mmxinPUKCtp1yTnIVPkkQhbXGKw1k4fko60Rkqe3XQ+fhq0jvN/XeduBXY6l?=
 =?us-ascii?Q?78QIXKu/a8PGeKledVe8NtPeJA+GilYBfxe9AUlJXUuQAQlehHziAyPpxQ/V?=
 =?us-ascii?Q?gL2ZnNoGSmfRID6MDuPhlqni73YpLYTFujJZfww/fPLkDoS2R1nOYGTSXrmu?=
 =?us-ascii?Q?53OOep/7Kyvvg0GniyC/wlOjBlGBNKunnFO2MHufsWSyAOlY+QpRg5gWNMPy?=
 =?us-ascii?Q?E5kqlxq3ND9R0m9y5hFRqAphnQDRlzcxZptLJ9IdOO29Tk+r3owcqPCx6y1Y?=
 =?us-ascii?Q?BPKjp5eRcweo/iOYq+u9fZy8bDBIVlIsx5Fa3zpaRCXsGReywaPfwp2FFjmJ?=
 =?us-ascii?Q?aOPVvE/JjmX5jBSoEuyBq00SjvGwBOyFyllvAZdqHL+vC4I5N4OC4ZiYhqCY?=
 =?us-ascii?Q?j+TZXgl7hSdZetonXbf6QmQfu1l4YFH+qvVFrIaQdcYdS3jJ0cLs2mXASieG?=
 =?us-ascii?Q?fLxS8likqt9iJslBb3db3nYQr19sPXwD/x8oMcdT58ul3G76PaqkuIsz9DAn?=
 =?us-ascii?Q?vXnF3vfLKMcup/y91kqFZdCC2yewWTw1Up+oEyItDqBnaIFx2K7qoCrXxerf?=
 =?us-ascii?Q?S6cXUjLWApauOKnePWhFWdVlRChm7TAG0bF1RFDKXb5T+zGIQCPGBw3LROSb?=
 =?us-ascii?Q?ghWQE2ThEie6/LHIJtmrr3TrWh52hhZ1Pe26t9XyvpjPHo13M/xoL1YCqoep?=
 =?us-ascii?Q?RYNbq4p6CnChrU01Cbl4/qPu6CWyzavHBT4tIPQ6xYdc5YGfoDEqCXA1jeyO?=
 =?us-ascii?Q?gFWFBfS8V8N7oVzTOyoWnVoNSEixMeSalThH0juhWULQ8irmmcU4F1+0awXi?=
 =?us-ascii?Q?4xw9FjZ8me+1s2isvonNVte8Xjc5zrUwEE8L7Bl0VwUKw/To7YGqU9QCP1FV?=
 =?us-ascii?Q?Mv4qX1kTK5tU3z/3l2y74+rnRGOsqCKYv+JYEwFiQJ/KmTvdu+vZaBF36p++?=
 =?us-ascii?Q?bFASJcqjYT8FL/HK4gjfLZjMCNTwFE84cU5N0KWR2+VyJZl6F0ffyFQbMai4?=
 =?us-ascii?Q?30pFKhbcRoySnAwHmKG+D55x80fNJyaiqzIkdYM5CyzCdAvdgQ053iqCEX0L?=
 =?us-ascii?Q?mx+DPLpcAU0OKu6tuEul6CKWsYotbsLzC+gmgdGo6p/sbVtHE4cjizMzc55A?=
 =?us-ascii?Q?hIhpDGSubYg0ZqjtPy6XcpkdA56jD0gS2vzqNKACkQLE6Bl57rapLuQqWpmD?=
 =?us-ascii?Q?9zRLXwLKIdIreWEScpYZjZLBqfmT1neFFwR7Hef81/Z3fwCMXg5ZFkaPHy7/?=
 =?us-ascii?Q?r5PPle4KIIEb8FBEUQs9r8mIpqKvZ0C82bUPfGz3RVmGbhnXRQt3upEMwyAT?=
 =?us-ascii?Q?1WcRafWn66jpB0vGg/pWpB8PORvYyTljosNOSTHobw2Qa7RMmqRoi4wmRZxN?=
 =?us-ascii?Q?nv1TviPXuQehG+EBXods3M58U6kOyf+hDXugYkGReuPSEd4GWq2ZNh2eyt62?=
 =?us-ascii?Q?XJBq/dfd6G3v2jBCio5Z9Nr2sdR4FykqGT0XS+tnUu8WwH9uJpWUfrZHamDA?=
 =?us-ascii?Q?Q1XGCfgDWbnXmsfo3rA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d80b81b8-bea3-42dc-9862-08de126e3dba
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 19:56:22.6755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 252Hmx/C6mXfYJrbH19NZPE/lOfnUUEpz8oCxGaqW20A6Ttk4CjGETiSJHg9ch3C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9071

On 25/10/23 12:59PM, Alex Elder wrote:
> Allow the SPI_FSL_QUADSPI Kconfig option to be selected if ARCH_SPACEMIT
> enabled.
> 
> Add support for the SpacemiT K1 SoC in the Freescale QSPI driver by
> defining the device type data for its QSPI implementation.
> 
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
> v2: - A continued line the Kconfig file is now aligned
> 
>  drivers/spi/Kconfig        |  3 ++-
>  drivers/spi/spi-fsl-qspi.c | 10 ++++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 4d8f00c850c14..592d46c9998bb 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -435,7 +435,8 @@ config SPI_FSL_LPSPI
>  
>  config SPI_FSL_QUADSPI
>  	tristate "Freescale QSPI controller"
> -	depends on ARCH_MXC || SOC_LS1021A || ARCH_LAYERSCAPE || COMPILE_TEST
> +	depends on ARCH_MXC || SOC_LS1021A || ARCH_LAYERSCAPE || \
> +		   ARCH_SPACEMIT || COMPILE_TEST
>  	depends on HAS_IOMEM
>  	help
>  	  This enables support for the Quad SPI controller in master mode.
> diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
> index a474d1b341b6a..d4b007e8172b2 100644
> --- a/drivers/spi/spi-fsl-qspi.c
> +++ b/drivers/spi/spi-fsl-qspi.c
> @@ -268,6 +268,15 @@ static const struct fsl_qspi_devtype_data ls2080a_data = {
>  	.little_endian = true,
>  };
>  
> +static const struct fsl_qspi_devtype_data spacemit_k1_data = {
> +	.rxfifo = SZ_128,
> +	.txfifo = SZ_256,
> +	.ahb_buf_size = SZ_512,

Do you need to set the new sfa_size here for multiples of 1KB requirement?

> +	.invalid_mstrid = QUADSPI_BUFXCR_INVALID_MSTRID,
> +	.quirks = QUADSPI_QUIRK_TKT253890 | QUADSPI_QUIRK_SKIP_CLK_DISABLE,
> +	.little_endian = true,
> +};
> +
>  struct fsl_qspi {
>  	void __iomem *iobase;
>  	void __iomem *ahb_addr;
> @@ -1003,6 +1012,7 @@ static const struct of_device_id fsl_qspi_dt_ids[] = {
>  	{ .compatible = "fsl,imx6ul-qspi", .data = &imx6ul_data, },
>  	{ .compatible = "fsl,ls1021a-qspi", .data = &ls1021a_data, },
>  	{ .compatible = "fsl,ls2080a-qspi", .data = &ls2080a_data, },
> +	{ .compatible = "spacemit,k1-qspi", .data = &spacemit_k1_data, },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, fsl_qspi_dt_ids);
> -- 
> 2.43.0
> 

