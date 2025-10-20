Return-Path: <linux-spi+bounces-10747-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CAABF32EF
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 21:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BDDC134F2D2
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 19:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CD028BAB1;
	Mon, 20 Oct 2025 19:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dFn2F8Bz"
X-Original-To: linux-spi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012017.outbound.protection.outlook.com [52.101.66.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A172D6E6E;
	Mon, 20 Oct 2025 19:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760988053; cv=fail; b=M80ly6Z5uoSi/1n9Owh+A/UIrw/oXWOaxKpyxDHZ2Gdk12Vm0ERvBCLasLwus8PVw9usMbKKliDh2F6RPb9anXPZBhisH27nfj7aZRWCTioKN19JB9YxA3WKcYQzF/dD5/IFvsBrhcPnZklV/Iku4Vg+CLZSsRartP4POvYcqtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760988053; c=relaxed/simple;
	bh=iDFAICLWrlDwANZUbCLOsijgsNeqQ81O5JUr0NrRhto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F96DjIXO6TKxhU16ESyLbvONaX0YU3pI8YFHNVbG4CxtqFOapkNofYSR2ew4wriHGyMPXwFDBhJHnVdYjJPXuK/XdTLt1Ele6MEFHb4AnT01g4+30aJCFkQRPtpUfP8JCfQbPn6R/NeI1XoASNt6fSiKQGYP9Ai4Od/CBPW+Klg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dFn2F8Bz; arc=fail smtp.client-ip=52.101.66.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMXSezghyKVhfxGoa8InX5blEbNNg8c6hqywHOkuhD36d2o+qSFOdCSjBiEHCw1VPwVDuklRyOtZEt1/RiXquchHsrJi8AVCL3Xuq3//ZGyhPPHCdrVf9SLZEXAevFK7WVxItZfkc0GSoYSX3cXBIrlXvYBWoHhRO5MuBOYlzT6uy7iIb+BjvdjzUx6hEf8LlXBfcDq35g8D382lul4tHaJtV+zhAmF5/ptgbIvSDH0gg2eBoNisCn1JDfRlPOx3JsjoExfjHrkARFE0mnlCQZA8ehzy6l/h1zXq/HuO90yD57MS+EOcZY3jjmu08aiid/kvI/z8b7KMwLAmto02FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYItoSi2/YXr9422suegPDfhaulKBOnbKeNZ9rwHQlg=;
 b=fTtIo10L4GJ2HvxupWF8GGoOlMTlE3KAwCOosdJhfykPyanTwvcAtEgAu13gJnWQDwqq8VIDtNPBpjdBTOGTB3+MU9dDgDI5dpCynuAVdGveOMQmstRqAzLQwaSr08Yw/cP1BfB3R1iaQaKlPBSv+uYbWAb+s5wAJeXR4BTQiDJfqNLLnvx4qf4X5lYA0/7bKJ3UUP5xdhKEdxQhrKJbbmSPlOmS16KuM94o6ECHFEzRnT+m6FUC4YccUF/rBJYIj7QZfa8SZeK8TnyPPcO8bFpX0ZkK23hz9ZPsNKtTQIN99c0mfbeQLbsbfORles2Enx8kFsKN9yf26nrG+9C+ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYItoSi2/YXr9422suegPDfhaulKBOnbKeNZ9rwHQlg=;
 b=dFn2F8BzOiWCvrlmHv54jnv52piBqunLELq2UelZa2c0NYN4BAJ+WF6bOfkreXVcclHUZVaKYwsd9OHmrRTbvIUUMjZUoXQvenbi+x5zgiOhHVoe5RG9TFk1qb+97tYeIbz0NCMUElo5LZYxNDEY/qugxmCO9HM8pHgRKUrOq88EtWG0fKCrshnAiaEC3gY1iWSIHrkq1umqqn2docg3HyfyXDheARxeOiLAJ61wqcxfkyGmnaTTVi7LvvUbVZi05PPsJYTnxMxFcAQjgakzkUIgSUeosg14Tz5aeBTmPV718aPk9S3zDZh6Dd+9wORwtsXytdknbAG3pWnLsvYPmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by DU4PR04MB11927.eurprd04.prod.outlook.com (2603:10a6:10:628::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 19:20:49 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9228.014; Mon, 20 Oct 2025
 19:20:49 +0000
Date: Mon, 20 Oct 2025 15:20:41 -0400
From: Frank Li <Frank.li@nxp.com>
To: Alex Elder <elder@riscstar.com>
Cc: han.xu@nxp.com, broonie@kernel.org, dlan@gentoo.org,
	guodong@riscstar.com, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] spi: fsl-qspi: allot 1KB per chip
Message-ID: <aPaLibm+oVKSDbL9@lizhi-Precision-Tower-5810>
References: <20251020165152.666221-1-elder@riscstar.com>
 <20251020165152.666221-6-elder@riscstar.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020165152.666221-6-elder@riscstar.com>
X-ClientProxiedBy: SJ0PR03CA0175.namprd03.prod.outlook.com
 (2603:10b6:a03:338::30) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|DU4PR04MB11927:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e9850d4-331d-4338-33fa-08de100dc6ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1rOESFcYzzUipDpRTEvwGq0Y9dZG4Pp2pYrhqbmGa9cCBRQv08otJ7jxiyU3?=
 =?us-ascii?Q?7zTy2Cz1y6BLcaOtWqGPDzLx0Q/z9KZR4g6IZ+bZ3YiYgDWUitJWgKjQq8R6?=
 =?us-ascii?Q?ztePdf3gisn8QUS2HyVhhHtNJfYTkY6b7qjr20Ls9bcSVZQ2DR80Gm80WxJk?=
 =?us-ascii?Q?5S7p7PKB0ATftBqD3JdV7XRTG1KLz8xh8NYU83Ig8gb9IxHPTU4lfLkakUFk?=
 =?us-ascii?Q?ui/0FP9tIvOFxJRR4BcESYrXDdEP775wmVrUcYxurdOzT7yckiaodQM48AyD?=
 =?us-ascii?Q?t8/dW3qQCPnuSHkWfB+RV0aMlM1qSiCk7YAa3mex5EuXUuY8BZhcqvdbvg23?=
 =?us-ascii?Q?tFtsziwyePOFWZUOzI0L7WHOKH8gEeQlj6SxhmnnFwvjR/enf/Cw+etORQ+D?=
 =?us-ascii?Q?rTwiTvG88XPr8BO54MyOe6islaJOyWqbW83Y0Zu+peAvR2mho/w8ppFflLs1?=
 =?us-ascii?Q?QS0RYpCTWKu6tV52WCLs07MD/uEsw/9jCgAIx4LwAaKinVSITcgm6a4cGrjY?=
 =?us-ascii?Q?3dk2hsv37FtCazRxNbQCXBBTQDDychJIcRRSLo4cNoOyb5Z/qwJOOdcYuZfN?=
 =?us-ascii?Q?eNpEcMSmRBVqz6qh+bZdlBc7jVxtTpPNPSLL66UAEBrZjxGsDy7JZRzG1TbA?=
 =?us-ascii?Q?FRStXYejF7iVolhcuFSqbFms4RmF/iiGin8WwL7NaKX38xc7Y4HsfHKP9uk+?=
 =?us-ascii?Q?Vjw1TEit2x5Svl3TDJugVazePrhMg6exTJwGK6vJs/UrSkUbX2R7lKQ/lnEa?=
 =?us-ascii?Q?6AmHxMoqR1bstaWi8lsk/RbCB4Cn2t7b08NaovnOLdAOfQhGlqQj85fgKkwp?=
 =?us-ascii?Q?OTpntSF47h61t5ekhXpG0ZuQrkVLmZt34WQhUoI0G0pWr/eUCTLRQrvcPoEy?=
 =?us-ascii?Q?fApR8/n756uwzkb+OuGcq71oo4WIyH0QL5TN/lSNKz5Tzseygjxk67XVnKOX?=
 =?us-ascii?Q?ybZKQ6Mk5DlkelS3Vb5nr4wZuw+/q+7bveZIMHwLe1UwHREeuTZJJnK27jRM?=
 =?us-ascii?Q?aOwS5g74zltB2udIUr2QyYdi5vaaFU7P75EWHb0AKv8cfygAezYDez9oheDR?=
 =?us-ascii?Q?17mrl50tOIHM7pKgyb4Bc2h59eI1Z+N6gHvTiYPhlRbFs2WEqCiT7+xb9riC?=
 =?us-ascii?Q?RCZKHxNSv41pp/neajYgM1Qp6ft1GAhJBQHHeDLj7DlK5X7tDsDok08L3Rti?=
 =?us-ascii?Q?gZFlfYsF51fb1abz26eenjWKa4WnvXuzULFyX2H+0Neos0XRonF7kp1qEhX3?=
 =?us-ascii?Q?ioAY+EmSbkLsOiQFKc3yvBysVnxCmYkiUcX6REkOgHINhsBZFBcAoD+uYZ+q?=
 =?us-ascii?Q?k1aZSZZgVxx1PZR2mSXmPYGwgDbV7CTNy3mI1ItMCksVJufJTkc27h8lV1fE?=
 =?us-ascii?Q?z2SDwpFCsYdSKeyy/3KdXrl/IQMY0JS5U2/MsMdyh63MdOCzXzFy/AoLfZzv?=
 =?us-ascii?Q?Lrs2uQTZGUMQCIVvcv+4vdIt2lY/+1cWjMB5us5grD/Tb91NImgpAbXpR7pP?=
 =?us-ascii?Q?d149TP7MpaWVQRE9zLqD7tDr7A6fEfVUz/jL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AjFXXBt3yPyZCSYBzQmjk2xu3kGMaD/FPzSObyBarwrP8hhIWk4Wh8CPu42P?=
 =?us-ascii?Q?SkEMY6VvSv1sBabVHNkpJgIjGiPnzYQzumJ/+lKHEELGpjwsv/WVFE/2ygeG?=
 =?us-ascii?Q?snjlG0NHXQxk0RmLtnt/VpqbZVsTHgVl6cFlJ2xyKkvYnU5k0MtLbgVcrmu5?=
 =?us-ascii?Q?f6qKNYNEjWD534PBl2hMlrhH4nTT6f2Px1De6jhAfpvNbcIDoTSpQa4A+4rW?=
 =?us-ascii?Q?er935ziV+8vAtwEgNZ4AFWutzxfDpZdPuU0RYmIcZOkHKU/Gt+2K6aLNkDWb?=
 =?us-ascii?Q?s8yRX0i1akDMeVBIBmibGW/u5qzH3cJFVNcjRX2Q5obckp/DHCuPlrwtF4e5?=
 =?us-ascii?Q?0KuGZTLPLUuLrg9uLvSJiZBk3U0GD6pbx82JigVL7KF9l+yH07vSDvnbPo96?=
 =?us-ascii?Q?X7ufcW574/0+G5eGptMctZbrZyAubB4+M+XwGC7S3v+htx0d8NISOgaAAYTb?=
 =?us-ascii?Q?GSSszYvLNEvIzucp84YrWhP11X2aZNnUBUUEhz1rHq2ZnQragE0LLSgtdAk3?=
 =?us-ascii?Q?Fq6yWe0PWoyiLbQr+dhzgZStG8YWjvyKoC1E0aAKuoh8oss6U6o4awlY+pDj?=
 =?us-ascii?Q?jAGYPSlsKslW/HVxGWTHsgWPeiNQTR4NMoZjGfYaSeadEPlgStLG+TrZrsyQ?=
 =?us-ascii?Q?A/hELBPdilndIqSW/TFvQNdrtrwSCm9BVGAT7C8nhCBqE6jBeqtzTPdjBYQ9?=
 =?us-ascii?Q?3TzailcvFwnG8YtfEY3Pio0z8TCHBCU8a5lehGfeKIZ9vlBMgtPv+2jA3p0o?=
 =?us-ascii?Q?w+8AjCwyFNGebEWzcXTHZxO4jCq+isGypUoWUOO5cmNAUSMHTziqQYUEiRrP?=
 =?us-ascii?Q?47wXFjxGZyhkQFKaEVYpz+51mZs24ks5Y3E+36BYzBqHyiGe01+TtxhvCp1d?=
 =?us-ascii?Q?6r+2sJUrN36oNyq2GIio/SbdveEsRLj8FeBPGkE0zq3+TAImNOqQLWRWg/AB?=
 =?us-ascii?Q?cT/e5gQPHu4ywAXQBE5dB3XOTajsyJ+SygU88d0r0MSUi/hjfVjp1I/QMiKd?=
 =?us-ascii?Q?3MOREAZCGWdQb9dk1vVSwkFKrvcDC5ftiRLEGcf9Gv5VHUoKgCTu+Ncbh7RM?=
 =?us-ascii?Q?EOTPt+ScPGgUXJM3TrUC9OoGnUOcn0QCDJrGQvvzx5O9AHFgh8Kb4MhknoiE?=
 =?us-ascii?Q?lvwGgil7OCWeDeNEQnEh0m4XiDpNKlykt8l9lhtKuZZBFWQR6+pU2anJzm3c?=
 =?us-ascii?Q?2NFiiccUz41+fX00pBMapd9soU/lGZ/pZcStHBMX8bIMuDBDQQ8KHBR2zV53?=
 =?us-ascii?Q?UJxyuzaAOyLsU23gr0b8ezbVnobaHizXn42lwF7agNb572oE+M6KEDuRCI++?=
 =?us-ascii?Q?SlcFtG6ZAapuiYMgJNKD5Bmj5rVlvy3ILx8m6nwTEjI+wQew8Ek1bQmS+BpG?=
 =?us-ascii?Q?aRjTFal6KRcSQzMgpZ6VE9DAA5m7HizXaGazxXdDu3bEPZMNJyQyvk3XSlkN?=
 =?us-ascii?Q?C3KaZIQeuok5slX1Kuh7+eFL1iV5nxIlG5a4lqkzmiGJWSNHo4op7WjyAxSO?=
 =?us-ascii?Q?hKLM4fFS3zlpteXcAJWZ3Ltij5jx4ccALTzwq8lgGKr2FH+3SKibFh+DgtxO?=
 =?us-ascii?Q?wGeUqOSVpUJ/emsYv7Q=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e9850d4-331d-4338-33fa-08de100dc6ac
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 19:20:49.1317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TfHyosBnDXkYSTfLdHDzSKesdDxsqQUbbWOUAAOlAnVapSDXbt6AVyUr9+Tsj9Med1WeWmjanBz9BsGzVrh2BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11927

On Mon, Oct 20, 2025 at 11:51:48AM -0500, Alex Elder wrote:
> In fsl_qspi_default_setup(), four registers define the size
> of blocks of data to written to each of four chips that
> comprise SPI NOR flash storage.  They are currently defined
> to be the same as the AHB buffer size (which is always 1KB).
>
> The SpacemiT QSPI has an AHB buffer size of 512 bytes, but
> requires these four sizes to be multiples of 1024 bytes.

I think it'd better to add field at fsl_qspi_devtype_data, like
sfa_size.

sz = q->devtype_data->sfa_size ? q->devtype_data->sfa_size : q->devtype_data->ahb_buf_size.

qspi_writel(q, addr_offset + 1 * sz, base + QUADSPI_SFA1AD);
...

Frank
>
> Rather than add a new quirk to support this scenario, just
> define the four sizes to be 1KB rather than being dependent
> on the AHB buffer size.
>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
>  drivers/spi/spi-fsl-qspi.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
> index 703a7df394c00..9ecb756b33dba 100644
> --- a/drivers/spi/spi-fsl-qspi.c
> +++ b/drivers/spi/spi-fsl-qspi.c
> @@ -795,17 +795,14 @@ static int fsl_qspi_default_setup(struct fsl_qspi *q)
>  	 * In HW there can be a maximum of four chips on two buses with
>  	 * two chip selects on each bus. We use four chip selects in SW
>  	 * to differentiate between the four chips.
> -	 * We use ahb_buf_size for each chip and set SFA1AD, SFA2AD, SFB1AD,
> -	 * SFB2AD accordingly.
> +	 *
> +	 * We use 1K for each chip and set SFA1AD, SFA2AD, SFB1AD, SFB2AD
> +	 * accordingly.
>  	 */
> -	qspi_writel(q, q->devtype_data->ahb_buf_size + addr_offset,
> -		    base + QUADSPI_SFA1AD);
> -	qspi_writel(q, q->devtype_data->ahb_buf_size * 2 + addr_offset,
> -		    base + QUADSPI_SFA2AD);
> -	qspi_writel(q, q->devtype_data->ahb_buf_size * 3 + addr_offset,
> -		    base + QUADSPI_SFB1AD);
> -	qspi_writel(q, q->devtype_data->ahb_buf_size * 4 + addr_offset,
> -		    base + QUADSPI_SFB2AD);
> +	qspi_writel(q, addr_offset + 1 * SZ_1K, base + QUADSPI_SFA1AD);
> +	qspi_writel(q, addr_offset + 2 * SZ_1K, base + QUADSPI_SFA2AD);
> +	qspi_writel(q, addr_offset + 3 * SZ_1K, base + QUADSPI_SFB1AD);
> +	qspi_writel(q, addr_offset + 4 * SZ_1K, base + QUADSPI_SFB2AD);
>
>  	q->selected = -1;
>
> --
> 2.48.1
>

