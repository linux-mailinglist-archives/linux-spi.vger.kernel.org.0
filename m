Return-Path: <linux-spi+bounces-10748-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B22CDBF330D
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 21:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C7A418C2A38
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 19:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B0121ABD7;
	Mon, 20 Oct 2025 19:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cWlAtToz"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010023.outbound.protection.outlook.com [52.101.69.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170CD1EDA0B;
	Mon, 20 Oct 2025 19:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760988219; cv=fail; b=G8uS+AOAYbYgIvYFwegawAja6oyqnDB5NioqYVY5opT0dbJQ7Rzosxh7rBzfBR1oEymEssGobTe/jw3UMUW7dorHG84m8iD42MO3eoCWSez+RpVvECKEAe86T5Aox9zdEm8kYeE0E1hDFnRDi4Lv8QqWp5Ju+mXMfrO2O1SEt1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760988219; c=relaxed/simple;
	bh=nKCF9N3UDpReSwR3X2Yz9tDEMNRdx+qe6Zk2F8FgktA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qQaqEjy84+yA6YJr+bS1emDQHEGswJi0pzmVLWK0PZYpu1tfs5dUEgr3BH9e04kjQt9eR6ASoyiEbEyT0zHyTgRhTYbk4rXIDM3CAxRFVFEZ9mqj1qfNUeq79xPJszG/djiCk5bESK9QjH4SHGpZYrDvbK0sAenN2toxEL/VNP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cWlAtToz; arc=fail smtp.client-ip=52.101.69.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qTN1IcM0O5xJmt4099K2inxTnYIyESfw7wjWiyyCVTcVgU+9q4vxWrAQoIMHgOKtHuKTz5kStL18dfjgiPx1zgKf8uNt+/pUulxjadaK3kqZyYs9DcW/PZvrMQCrXESY1/k8gOZRpREvyXtdn7MmIcC0yCkzFCwAnk1n4VzMxXROSS+fcU72P+B/+caicwXDyu9lGb707yAbEbvxHQQbon+AWO82sATmDS64ZlG75ZJA/HC1H7MUbwMAw2hm1gq+61BysjKOf/Gxowk1yUKGlCkVFLfYeY/XFXq61aGs+dfVLCZU9mRKohJXk0ci88HWFyMPBV8bnINTRnIqu+7l6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3laiZMTpC6WljcK8EJKcNYXb0W+ok14tJUVj+ZsE8PY=;
 b=B+C25bywbmwr22HtDv5oj0pHRxIkd6q268EW6ZPjDvBbLsn4Uk7CuZF8V8NdEBDJaNTAEXhwQ0CJPBK4c6tO6l1JyHMSO3VL4y9aCrC3Tj6mjrSbb24DaOjnmEmRETs9aB0qb3fIYto9Gi91ZtM8YZL8jr/xRbRyq3Onmm9syeBsh7h60FgaDg5DEhAD16FP8TfgoOH6B/jJ3x7IixOjMl80Ro4kvgdIUm/iL/0r8/nbUkECcHJHNg3A7oqcUYo1bvlzMtXokKNDD5kDwtwq/u6caebTHiN6P4NJZvCl64r1cXmN2Trbfw1O4Mv+weMXBmJ5q8N53mR/TAs4xkCqtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3laiZMTpC6WljcK8EJKcNYXb0W+ok14tJUVj+ZsE8PY=;
 b=cWlAtToz0MMdz4lev0KqCxgni1VNHVeqJTITuhYuxaH2H6w+0gT+jkhPiLER6qOjZbjpBJpa6Dsh9bDLBC7gpe0EG64sMmWmO70kT4RZ0gajrOdJqRKMpIq5nJFbgx3nT/l1kU3OtbLzicx8Qb5ujGEVsoTHuGj7ocLqX8z/pfRjhfFHj13xIaACUqFQsIoxcbVPOtHovex/pWFYdWetHltLf7KWDJbr/o4BBlXcpITsD7YQuQ5QlCKUJS1NyVg6e1z1btSaZO0XpZ3PmBZMcT3COd+N609KmQ0GraT46Jye78m+ckkKI30bhjuE8YVEl96VY2JfvxGObgDZmqpI2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by PAXPR04MB8375.eurprd04.prod.outlook.com (2603:10a6:102:1be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 19:23:35 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9228.014; Mon, 20 Oct 2025
 19:23:35 +0000
Date: Mon, 20 Oct 2025 15:23:27 -0400
From: Frank Li <Frank.li@nxp.com>
To: Alex Elder <elder@riscstar.com>
Cc: han.xu@nxp.com, broonie@kernel.org, dlan@gentoo.org,
	guodong@riscstar.com, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] spi: fsl-qspi: support the SpacemiT K1 SoC
Message-ID: <aPaML32I0Ao1xhpX@lizhi-Precision-Tower-5810>
References: <20251020165152.666221-1-elder@riscstar.com>
 <20251020165152.666221-7-elder@riscstar.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020165152.666221-7-elder@riscstar.com>
X-ClientProxiedBy: BYAPR11CA0077.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::18) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|PAXPR04MB8375:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f7f348b-afa2-427e-96ca-08de100e298f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|376014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mnXm86O5yiEMDYhoGP9hSI42yJ7ddSjbOExDpzcLC2hTuJS3l6uDwCcghgLM?=
 =?us-ascii?Q?iqnhkFc8de+g5Mw9osZfRxk71dzKXP2PNiC2d9gpXaT4qxhW2y6oBYkQB6XW?=
 =?us-ascii?Q?IrovR2jImVytQJ/lHsOCC3UDHejaVzQsFmQklGYaqy4YPwKpCgjTG26zqWcy?=
 =?us-ascii?Q?TSKD4kG6WoZVmFeeuH5JMfozJ8k47qkdUzwznISPSWbEdgZTAe4YA4g8IMgJ?=
 =?us-ascii?Q?oyHrZqYBuI1X3//Qtz7CxLvjuW1Hy6olXRKH9lAX17CGrmjwdBtXE8M0dw3y?=
 =?us-ascii?Q?+SkErQcoJj5SJzTKpuEaiKMu2EUcQNQdxEpci7eL90RJWb3nhpOPLy+Mph03?=
 =?us-ascii?Q?F1bjErru1djKdPsYwxHcusWu408BqZVYjQjfrlaUZCgw0EKQtcNzV3LUz/cy?=
 =?us-ascii?Q?0ZL0DzOB6WPscvj+tIkdW+PprgJr0rAIbFsJZvYc3WAM7PIzVVBCFS9mtWTE?=
 =?us-ascii?Q?FQzyDPsykQNK6PZDeLYltZqeAfSpveRz3FjlYTukUh6XpNV0LZ7aRfwqFK4B?=
 =?us-ascii?Q?JvxZBPOwSAWcTbZGzJK0m9JFuSHXttKrMP2H7M0N2k4Pm+qRpgY6tVFLdN2s?=
 =?us-ascii?Q?yA0vijo1TkBA12twbbRb3VRPohAXNTKXbadbU9NZ1Q/CjIKR1DJ2mH4O0QYB?=
 =?us-ascii?Q?bgyFFjcI9iXA77SPrQfeCh2hQxj13kOTjZ54tbMa2UlS4QhzJQRK0ZYxouPp?=
 =?us-ascii?Q?yFS3/AF/nvYvIhi2G6zRvdo9hRpXavVcvVTIW294XoJyzOK6OPa8qNi2CC4s?=
 =?us-ascii?Q?Z0dC9ymBz+uVDS5KOrehwDZHTVHhLdpx7J6NXli4wAaz3FpwXqHHnI5GH3VB?=
 =?us-ascii?Q?WxcMfUFxB+uhqyCnk54L3JEbp0a0Mo4YZ6QdmGymAEzo8th3wK1wTJY6uQoP?=
 =?us-ascii?Q?547HueetFluXfGJq+rGyBRm8744khWW7bNHx8TYDRdxY1gbIqoxPSZQeHaIO?=
 =?us-ascii?Q?ev99Zrbp3oDI6GQsdz7J8TvFA9q/LGsQyCBSI00j7puxfC5Ek4EvAMAz0mna?=
 =?us-ascii?Q?vkW2ya1yc97yoVoAgkvpm7uMWaDHal/lsJ7cnklT3oipyRXeoR0P32t5ccF6?=
 =?us-ascii?Q?JWS13LGoOcjQOdaQ1Ry+DF2koSauP3RdikGjoqQtF4810D7YJBeBSeyxTRGz?=
 =?us-ascii?Q?u5wF4hjWQGOAlVUvDTbjBFN/8Uy00Bn8XCS3CNExEGeY0rUGHrCwdSNuB7Rw?=
 =?us-ascii?Q?owN1BgDGNhl77nCyxeLpBIDsbqYfBmAEN+i/LIyQJH3LTg4JmUP4HtosM3Bn?=
 =?us-ascii?Q?nsU5tbSzK74k/Dg7VBycQGZ2yN8FEwh/Ir6KkMVAMQVkc/4KJz6LedPCcaQs?=
 =?us-ascii?Q?8YDtr7Jg2ObYMB9ghx7bNrVhxoBHcWFRjsGQNCJAZvIn8VWfJhIwpjd2d+bu?=
 =?us-ascii?Q?67qVbLWSJOJPm42gADFbfezCfD5ePg3ubYBhyiNgtMEqyf1kQaBAX4SoS/ov?=
 =?us-ascii?Q?Bk3Dj3XW/Uqay14Nh7z+aKBoxK9I1U+TSpiS39poe3L5K2Gcnmi16/lGFNwB?=
 =?us-ascii?Q?SjkyVzv228ZFqk5SisAQmI4xovKGnYGL679Q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(376014)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AqQI/XaZlAFgvzeu6hoqmgc7Nh+WvKf4sdbHdgMa+AhThbJSo0p9CMk/T3Wc?=
 =?us-ascii?Q?XP8+hGhfh4GeOonQEa5JTFXAnY0QLsfX60ZawQ9joD+dJuM5WYMQYgwmkQP0?=
 =?us-ascii?Q?NpIjVth2wBUlCFVCNEdivuyEpK4Ci4IUTFdYbG9cwZTLfefEdrGhiO+PTDLZ?=
 =?us-ascii?Q?D+LaxmWmIqmy/72pCcktfEM/0WOMbkvGXL0J3NY1pu4NOi7op2edpnJWA1XF?=
 =?us-ascii?Q?qyBU9mpzXMCJFIE7VJAI7Sq582sLEFTUbjh8hyuVkuSXvqAFxj7kGVegMhke?=
 =?us-ascii?Q?Y23TZ4QoVz0dBbW9ppsx31w+PBchrEu/pVNHh5BkM/4g53eSj1rR09k/i3CI?=
 =?us-ascii?Q?dECXkXF9CxBEXi9y/os5BzCvIgh8JQ5LgNfvfUJ3lGdSZfkIZ39EYnBFjNSq?=
 =?us-ascii?Q?o0rKxeE6sdb56jAIinfyomRwWjojaJMT22PJhUdAtdY+dYwGJRiQBjNUDnsx?=
 =?us-ascii?Q?mczuPVcdNxM6mbJFFVD1kZvm1hAETnsOkY7zGVhwt03ICIwjXKa//18into6?=
 =?us-ascii?Q?TJBwKHk661r4DKQx2aIqCjRFv3Tb36nm1hTdjpns3NRJL9MzgvnQ7bXR5Sdv?=
 =?us-ascii?Q?TUT5DMQxSvzKnCeJD2A5XQeaEcIFeWtRERmZHaWyPvgOL6osaYrjlBCaoY6E?=
 =?us-ascii?Q?IYYO8gUvKaFikcwrLaCQYl9/HxW/MFxhNMzTmTkXBO9GSLtsTFB6WIbQAnY6?=
 =?us-ascii?Q?UphDvbFkTza3riQci4B+JdRNXBDKyb+AhX17dHhQfAIKVHvHLpVD5MjTtc+4?=
 =?us-ascii?Q?5jnM4NTE27kilLRLVywE6oP4bcrO/Q8PyXVuIIgJ7Y4YamgXGda+ohPvFr2G?=
 =?us-ascii?Q?fsslv+OgiQBZ29RlK+CM8Vhq07R40aqWhgLJZvbEvqeMgu3tDBw1EJpBaMwg?=
 =?us-ascii?Q?s+h5PKJvz0QBQYkcpf3WtpODI2gtzfICCtBnWwnSRudRJRPEHy+hIa/QcmaQ?=
 =?us-ascii?Q?SgPFVBNk2pTJEv6q/W9bqoiKghvLpmRvRleL33dTo7WhsOi1JsdKBqnbWV3h?=
 =?us-ascii?Q?6UnKYZkLZUzvMp03b035tfZQZwsb6g8SqXaiT87IPVGpUJTbKjaZUw5qYAz7?=
 =?us-ascii?Q?+YOa+33mnGuhaecu85p4jI21qC9dj/AqZ07OhxaprTtpfMIIyf/OHh2//R2i?=
 =?us-ascii?Q?akAsRPvdE7aOIzY+hkH+VbbJDfIUB1lbnRhs46Dk2weGizW5a+VbI+PODoCu?=
 =?us-ascii?Q?pZVmh1JI/D2JmkS0qjT9hjF8fhJcv+pHEKc62+qnqudfM57kJsTmm9XXxWAA?=
 =?us-ascii?Q?62EXIygOaV7Hb/BOkvyM5HJWn4YCzNxJZIsBQ0x3xWcepNlhzZskD5ussjvM?=
 =?us-ascii?Q?ldDwXwLlgx5TkcikiUq3T1qtCC4fhJnzzqjNUPWinOdOJ571QqSjfhrXdu8I?=
 =?us-ascii?Q?4Ey380U6haRvbStGVzcvfJ2+A5Qbw7yG9EqNsk3/zhYo2pgGJeuSpqmJP39d?=
 =?us-ascii?Q?+OKYWMhHwuVrA5r8z2BxEy8JXypkKDrconAq8gIj2xjlSjZDLYqscWAdK37/?=
 =?us-ascii?Q?5X9jcUBDXYpdc2vvzzDboOGOsY1ZWNJQy5vSRdDicsw3EgZFBkQUMuBwzxeE?=
 =?us-ascii?Q?WiGi3PMq5ELLwH7cHjejl098cDGJmHD20zYtV/5e?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7f348b-afa2-427e-96ca-08de100e298f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 19:23:34.9806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RYOZlUjxnr9/xsIoeLOLPoGeO0aB0ZojxkXirQosDtRdxacFXx8J5WX521t2/b2LndFe0SZ2lnrtIijZ1aOlvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8375

On Mon, Oct 20, 2025 at 11:51:49AM -0500, Alex Elder wrote:
> Allow the SPI_FSL_QUADSPI Kconfig option to be selected if
> ARCH_SPACEMIT enabled.
>
> Add support for the SpacemiT K1 SoC in the Freescale QSPI driver
> by defining the device type data for its QSPI implementation.
>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
>  drivers/spi/Kconfig        |  3 ++-
>  drivers/spi/spi-fsl-qspi.c | 10 ++++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 4d8f00c850c14..2e3d8bd06ceb2 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -435,7 +435,8 @@ config SPI_FSL_LPSPI
>
>  config SPI_FSL_QUADSPI
>  	tristate "Freescale QSPI controller"
> -	depends on ARCH_MXC || SOC_LS1021A || ARCH_LAYERSCAPE || COMPILE_TEST
> +	depends on ARCH_MXC || SOC_LS1021A || ARCH_LAYERSCAPE || \
> +			ARCH_SPACEMIT || COMPILE_TEST
		   ^
		   align to here

Frank

>  	depends on HAS_IOMEM
>  	help
>  	  This enables support for the Quad SPI controller in master mode.
> diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
> index 9ecb756b33dba..f4f9cf127d3fe 100644
> --- a/drivers/spi/spi-fsl-qspi.c
> +++ b/drivers/spi/spi-fsl-qspi.c
> @@ -267,6 +267,15 @@ static const struct fsl_qspi_devtype_data ls2080a_data = {
>  	.little_endian = true,
>  };
>
> +static const struct fsl_qspi_devtype_data spacemit_k1_data = {
> +	.rxfifo = SZ_128,
> +	.txfifo = SZ_256,
> +	.ahb_buf_size = SZ_512,
> +	.invalid_mstrid = QUADSPI_BUFXCR_INVALID_MSTRID,
> +	.quirks = QUADSPI_QUIRK_TKT253890 | QUADSPI_QUIRK_NO_CLK_DISABLE,
> +	.little_endian = true,
> +};
> +
>  struct fsl_qspi {
>  	void __iomem *iobase;
>  	void __iomem *ahb_addr;
> @@ -998,6 +1007,7 @@ static const struct of_device_id fsl_qspi_dt_ids[] = {
>  	{ .compatible = "fsl,imx6ul-qspi", .data = &imx6ul_data, },
>  	{ .compatible = "fsl,ls1021a-qspi", .data = &ls1021a_data, },
>  	{ .compatible = "fsl,ls2080a-qspi", .data = &ls2080a_data, },
> +	{ .compatible = "spacemit,k1-qspi", .data = &spacemit_k1_data, },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, fsl_qspi_dt_ids);
> --
> 2.48.1
>

