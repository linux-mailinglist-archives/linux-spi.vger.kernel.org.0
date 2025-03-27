Return-Path: <linux-spi+bounces-7348-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D47EA735E2
	for <lists+linux-spi@lfdr.de>; Thu, 27 Mar 2025 16:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE761178C2E
	for <lists+linux-spi@lfdr.de>; Thu, 27 Mar 2025 15:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80A6155C83;
	Thu, 27 Mar 2025 15:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DO6BQhfp"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2064.outbound.protection.outlook.com [40.107.247.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A414F1758B;
	Thu, 27 Mar 2025 15:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743090338; cv=fail; b=JqGv6g0j1vv3ziIrMKFtKfohGWd8hjWMiUak+29/DKb2EV56f12SEgOqXEDSyqvgR9HHoGQ6rfrBcg4hdnyVPlr0UugeEaBNE1HYKfcolBLLG3hTzwJQNsazirlx2hitdXZJGJyjE9kX1KSsYx/im4vHntJ5k/GA/mgDYlcL7JU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743090338; c=relaxed/simple;
	bh=7fvpQ4S/rlrzdsIRTKssX4g1AyVqA6cTT+2afBHdzRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Si5/XdJbk+FNL0PUMzYM1IR0ZyWf4ocxn279SC3bOQUdAUpzBKr7w8bPyGyczs50+OSo5kD4SOZzTHPQI0JAQmoz8Pl8IN0lkq0KAgkfKxIgK99kgRqoeSJ0X7m2lStXiJpImp6Jqh1ewCScMc00WR9OpiztPkXBFbKVNfNxj8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DO6BQhfp; arc=fail smtp.client-ip=40.107.247.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ja9D9a3ySD0+VJGrkvjSV3pHYhEzue9NnRWJqtjtZUKnmjGg2n65TcEYdZBUNXMABZG1CIZz3Kugw238h7pdVSB7Cvl27nT2MlC/5B6+qNmHeiCTH2wbrzsd3OLH6A7P1Ib4tw8xDn8Y2SiPosv9kHepF2Z/VL9GYRh4N9aWk3+qap4goEPU8/CqJSUUi8CjE6w3DszVX/E7+BqtCpMCagJQpmnbD5Tm42n7HbiKkvpmStptZ8ChINZrLgvHM8VJHm6w1MYBl2Zbd5YKlbqC5YI21NKzfFmadnSAVKY0xz1T2jA65m9q9XBF+RZNGmxbcbPRlCarCF+oLEBWsqCa7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXyBuJfZt7Ei9ruiWO2txGvOn2m2SKicNBErIVB7eG8=;
 b=qTILVntGz5a/oByvKLmf4hPECLMTLk8ygr3/+S78EUbhwYcEr4deTOEQBAcLnRQcXQpBfxhAtgIjvLwYYn8OmXWzprB8fcF/XuDDXwCD+BsJCXfGlqxG4Gy4t+KOXTWsqLLCq5VZccLRphj+/fvyLQllDNLLziQLL7lR/CcTi4XPzzxsRuR1E96AWOf+Ay7jGH2mJtg2xnz+jatR/xJtabcB+MX/OhqofG19deo64/M9ymga8U5Ib7Nr21YlzkDIZRtFAquoDxiqATtyUWsI+36qzFXfPBefcLRY21pNseZwPZgmef1ngYX8qizVjQCwv8X1hLcED8xfEXb1Vb+qgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXyBuJfZt7Ei9ruiWO2txGvOn2m2SKicNBErIVB7eG8=;
 b=DO6BQhfpGnadMiit075tpODo4iFtzQrtxhazmOeRXG8vpckc+gYO/lA0wYiO4zggYBC1ACvzqqeA5crguxW4qD+DME81ySeq9nAu9LTbranNFHohYF1MWLgmfDcoAIP7BYxZJPLQmasDYdYCw82d7ldOWWx9/+cDxtSmIkD67XD1QUJVzsfA3xr17FpkLZd7AVDLzTaKQ7QglqPFXFp6s0PAc/IbmplPpPUyqT7SduqlardyK6uxrrITY5Woiup3GnTa5fjEF/HUYGfAfYPlHx1p35ZKNsRbQiLf2yt2qvIojgaFDpedM4q8P/bZzuvBI1n43UbaxKj9RrSskHvwaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9684.eurprd04.prod.outlook.com (2603:10a6:20b:474::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 15:45:32 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8534.040; Thu, 27 Mar 2025
 15:45:32 +0000
Date: Thu, 27 Mar 2025 11:45:24 -0400
From: Frank Li <Frank.li@nxp.com>
To: Han Xu <han.xu@nxp.com>
Cc: Mark Brown <broonie@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Volker Haspel <volker.haspel@linutronix.de>, stable@vger.kernel.org,
	Kevin Hao <haokexin@gmail.com>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: fsl-qspi: use devm function instead of driver remove
Message-ID: <Z+VylBMSnQVHFSV5@lizhi-Precision-Tower-5810>
References: <20250326224152.2147099-1-han.xu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326224152.2147099-1-han.xu@nxp.com>
X-ClientProxiedBy: BYAPR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9684:EE_
X-MS-Office365-Filtering-Correlation-Id: 41ed4a99-2f00-4d42-1e39-08dd6d4667d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jmVKFaprLMLsYeHcp3uXpUpp7e1F/KkwJf0Ce091GgQ+cWt4XaHxvzSVPM2T?=
 =?us-ascii?Q?nDIyJAKlZvS1h1ya6+0+mZCnlL8Ix4kOhlI63ciqv35Iw+beblsXvE5kP5tv?=
 =?us-ascii?Q?Gokmv3m07cxy35vHkU5sKWRBxO8OTbK9KCmCS0/wgmUr7vaNcLqVK+B4sh85?=
 =?us-ascii?Q?2hzhY0FBsU65MkkrJ3cmANzY0snh0tL4SWdNnhCwx7fsruyoLypkSFBYQ83B?=
 =?us-ascii?Q?KIgmGxOLc/C9msuCBa3LznCtEpD1D2vhczcDZrRUd7qJtUhP+/sVJoITrulO?=
 =?us-ascii?Q?TuGtagiU481+DVmZ8WXLmmn6cYBqJtKef4ENXf6IbYP1m8PjnByKHYab9tJB?=
 =?us-ascii?Q?mW+uNUfSuVnQsjoqnKb6gc893LovqfEPHlONTwAgol8dDWH2ArNix15kJnJt?=
 =?us-ascii?Q?fshs9/ipLXlwp28ZU3ibqsp12OykQ3+HSd8TL8W9h9Jzaat1kQ8MdyZF+gO6?=
 =?us-ascii?Q?mUZkV0CV4a6DHwCf4BedQ/L5N1EivBX7nGSbwF6ye51I42y+O9OVxiJUwDh9?=
 =?us-ascii?Q?S8EXFBlUGfcKGLSq+lsVP6UJExFAC6qkfYd4hGw/VKjqJ23lcb2EJ8oDlXv+?=
 =?us-ascii?Q?rvhNdsoxSt3v91GVGcGpi8nm9enWybYb1pIU9JSLqjxW1ZECaeDB6CrqHupH?=
 =?us-ascii?Q?QoBGyPnsDwOCtLTa4QZahSjnHoEU/7OMXDRlP6XyWdrqAs0QzQMfe6MFTPZ/?=
 =?us-ascii?Q?Wc66xkFh9MhFUh6YaRjz2enb1olHu2ulQe2Z3svEPFpamGj3Btsy29X2ytex?=
 =?us-ascii?Q?lODUJG9yXskUeMZ+VL71eh1DKrS8A23EBcOKEykRfftKIvoy61rab9IkWrA1?=
 =?us-ascii?Q?S4+jtqJQqRS/6nvZ+KzShB4+jmyHk6IRyNCht0/IpNuHw/3J18lqUt+xBPA8?=
 =?us-ascii?Q?UwhZZKRnWkqVkML+Udjs0fFiPM1QdHwpV0BX/VF/hAUwh251QZ6esZka37VW?=
 =?us-ascii?Q?dAV9w05w4XEWdxZVEyQZzboWaW4A1jp01Xldwz37OoEXqyVyBdWpdfQEuIC/?=
 =?us-ascii?Q?iDQzNZ7AnlZIxekJORjGuDWgkA/yib9BQL+njeAhcxm0CSfcjqyu3iIs3fo1?=
 =?us-ascii?Q?Dy9Z+emARyuzDc4rgoLi75HjHxdZ5QDg/F4X6GoJ/4qZxSiUxwioUotnfIZJ?=
 =?us-ascii?Q?Bd6WG7MreUb6BJhCY3Cjs0Ncw94LbWObZlZATWtbIz1sX4h+xiW8oCjuQDuM?=
 =?us-ascii?Q?IJePvyb5B5/5mT6peKKeifEDb6nmw/vqEzQ8E44dG2QjHiItykwkjJXqozw2?=
 =?us-ascii?Q?gb68AIyOvlQbvkwC4BKR6OAAgQCRycIaHAe0DkLc2P2f7j523WGhPHerZtgK?=
 =?us-ascii?Q?ZHwAh06McssuolEORK2A2DJLQKv5KxIt8kUD1GsxjCPHD4XTU5O6MYPyENZG?=
 =?us-ascii?Q?0aIbKns+HPHiMKVyPBhsr9kIwTmkzizMIJxboKpXSDlwiZHGlBLqAjt/qVuL?=
 =?us-ascii?Q?M1NIn/lnjYBKNCPT3JZQlJhsie8f2BXk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6luWMk9qcdiJbXenjkyuZOLPD++0TDLmcIvjKalvrou9kSxFVz4sD/QzfpWq?=
 =?us-ascii?Q?zBCtZKZADJPWdCLM4GY+iPBwgQutfR1Pvpz5q05QfQzY5Qpnn8Wf6EiZXx6R?=
 =?us-ascii?Q?0Tdj5OA0hMOgA/nQDIeKN/VDTU3TA53eLCZ9Dg6Zs6wplbdUEi1wTg6waz4l?=
 =?us-ascii?Q?ropG+b4R7gdohCwD9Cu5JFJ1ZALkYbUYgL+oC4k+wFY15rhx/AxCK2bD1FiS?=
 =?us-ascii?Q?glMZNBuWqvNBXvrOTJESsVZ1bkwfM6H9uCK6+D2SmPoaV0i7UIlL7WjL72Yq?=
 =?us-ascii?Q?ncdQAE1BTNtAqPkjPIKVoe1OxDumHk6Oit8+7AVr56b0CUyoX0NGzM1t8jj0?=
 =?us-ascii?Q?qAc8nqB4mFo92wEOg+JBUpVwl8z09gkZNuY8caiU65+AjmUFnAFrjJ2paPI+?=
 =?us-ascii?Q?Fm7fUEYomoG1LUj006PFbkv3stjyz/8706Ym2TuSdFTl5KKawWhAQRLx0KtK?=
 =?us-ascii?Q?4Quiq5mg93d36DboY2CBryNmeITk4WpL6JNMd/zBm/e8bATSSmy9miwGvBcB?=
 =?us-ascii?Q?ZwavgrkycxpJ7QIZedTIUFLC49zEePkzg0MrO4eeGuYeobx585+klUT/n8UK?=
 =?us-ascii?Q?glQQET1OEJfnwOU2L0mDSMMDRDQFgKylMYwTZNEyeXyZqWj3urilqQLC2eFn?=
 =?us-ascii?Q?1sHZTeUAW9E12lZbwTdww3SyhDX3TBFESjxa3dSOC2uCOXbY4JZ4e7sJW1Yg?=
 =?us-ascii?Q?orDvq4b71ep6FYibV/3PMXF6VCIboe+xENzDd6Cxc/wzIOpp+ahjeEE+iCBo?=
 =?us-ascii?Q?n1IfD8Qp7eXR2YcTn3LXKOUUloXUXWsMbA754QYfYODLE7gJj0N4W/Ni2nYq?=
 =?us-ascii?Q?aIudvoddXTVXUiQs5J8jorkVsVK1sf9v+L9CrFhmw2FKa97hebwMsMue1985?=
 =?us-ascii?Q?WKiwR2XT96A69+Mil4u1R/IgEipMCF2uahqB4LVZm/n/8LEgeZc5yI7tD7Xl?=
 =?us-ascii?Q?yWCw/dRyaY9xvZfwIJIAnQ4DfA+O3k/WD1ftuaDXK3pH3o0nqC6qlDYKyGwS?=
 =?us-ascii?Q?tWZGtsfpjKO1J7W1vS4HBOTaRPdp9g5/JWvNKQtOO9QOpSReuhCE9P9lquFB?=
 =?us-ascii?Q?dwsx/2x2pDQEKtSXfTsO8+/g5dbnLdMy3W+bP2c4Yb/V0Xl0kKdlKxoosFfl?=
 =?us-ascii?Q?wcg7JAzTproCoO+jGDgCtheqKd2OhxLjAdgjPcLcUWozGiNcHLpcMNEnjrmV?=
 =?us-ascii?Q?mGXH9ZTJhZ3gYjxXt8onuWb8pu7w8JF8D4+cyu3yncCf6QVpWJyig5vEGXrj?=
 =?us-ascii?Q?7tqCecGFTPihOhoCjKicTF09I4IZd08ppiDzPV0R1cLJe8ot0e8JIzOwqEE3?=
 =?us-ascii?Q?FHRYVzbHambMvyS2+J6iIUs9NkxNl6JRqGNfhqVR8shJsWKuMhEDe88J4699?=
 =?us-ascii?Q?b2zIvfbgvtd/tNMBhUIf55/A0XjAYZwZhVP/SZHsP5fzPs4coz70ft9+7EEK?=
 =?us-ascii?Q?g9JwngwM4qhgkCS+yajx51Vuj4pGVrNwRrb6K/D/FzeEwBjk6uKvMTi4yxbq?=
 =?us-ascii?Q?VuKi1s7QVB53+UrjpN8abBokdAXZ7ENf27J8v2ucSkG8z0ned+CH2LAkNHoO?=
 =?us-ascii?Q?cizPRReullBV1qNA/2Olt2dHZ+X7/OUcQt4O+VNi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ed4a99-2f00-4d42-1e39-08dd6d4667d4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 15:45:32.2529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tjcbeCdpBFSV2OkOjaSvv3u/i/7RkSIo/38UUEoOEwBN6TkU7RMZCRBfZMibAypbG4WYMZ/2crktFcmuOgDa7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9684

On Wed, Mar 26, 2025 at 05:41:51PM -0500, Han Xu wrote:
> Driver use devm APIs to manage clk/irq/resources and register the spi
> controller, but the legacy remove function will be called first during
> device detach and trigger kernel panic. Drop the remove function and use
> devm_add_action_or_reset() for driver cleanup to ensure the release
> sequence.
>
> Trigger kernel panic on i.MX8MQ by
> echo 30bb0000.spi >/sys/bus/platform/drivers/fsl-quadspi/unbind
>
> Cc: stable@vger.kernel.org
> Fixes: 8fcb830a00f0 ("spi: spi-fsl-qspi: use devm_spi_register_controller")
> Reported-by: Kevin Hao <haokexin@gmail.com>
> Signed-off-by: Han Xu <han.xu@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/spi/spi-fsl-qspi.c | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
> index 355e6a39fb418..5c59fddb32c1b 100644
> --- a/drivers/spi/spi-fsl-qspi.c
> +++ b/drivers/spi/spi-fsl-qspi.c
> @@ -844,6 +844,19 @@ static const struct spi_controller_mem_caps fsl_qspi_mem_caps = {
>  	.per_op_freq = true,
>  };
>
> +static void fsl_qspi_cleanup(void *data)
> +{
> +	struct fsl_qspi *q = data;
> +
> +	/* disable the hardware */
> +	qspi_writel(q, QUADSPI_MCR_MDIS_MASK, q->iobase + QUADSPI_MCR);
> +	qspi_writel(q, 0x0, q->iobase + QUADSPI_RSER);
> +
> +	fsl_qspi_clk_disable_unprep(q);
> +
> +	mutex_destroy(&q->lock);
> +}
> +
>  static int fsl_qspi_probe(struct platform_device *pdev)
>  {
>  	struct spi_controller *ctlr;
> @@ -934,6 +947,10 @@ static int fsl_qspi_probe(struct platform_device *pdev)
>
>  	ctlr->dev.of_node = np;
>
> +	ret = devm_add_action_or_reset(dev, fsl_qspi_cleanup, q);
> +	if (ret)
> +		goto err_destroy_mutex;
> +

Look like needn't goto err_destroy_mutex. it should be enough

	if (ret)
		return ret;

Orginal error path:

err_destroy_mutex:
        mutex_destroy(&q->lock);    // already in fsl_qspi_cleanup()

err_disable_clk:
        fsl_qspi_clk_disable_unprep(q); // already in fsl_qspi_cleanup()

err_put_ctrl:
        spi_controller_put(ctlr); // suppose it is wrong, devm_spi_register_controller()
should consider it.


Frank

>  	ret = devm_spi_register_controller(dev, ctlr);
>  	if (ret)
>  		goto err_destroy_mutex;
> @@ -953,19 +970,6 @@ static int fsl_qspi_probe(struct platform_device *pdev)
>  	return ret;
>  }
>
> -static void fsl_qspi_remove(struct platform_device *pdev)
> -{
> -	struct fsl_qspi *q = platform_get_drvdata(pdev);
> -
> -	/* disable the hardware */
> -	qspi_writel(q, QUADSPI_MCR_MDIS_MASK, q->iobase + QUADSPI_MCR);
> -	qspi_writel(q, 0x0, q->iobase + QUADSPI_RSER);
> -
> -	fsl_qspi_clk_disable_unprep(q);
> -
> -	mutex_destroy(&q->lock);
> -}
> -
>  static int fsl_qspi_suspend(struct device *dev)
>  {
>  	return 0;
> @@ -1003,7 +1007,6 @@ static struct platform_driver fsl_qspi_driver = {
>  		.pm =   &fsl_qspi_pm_ops,
>  	},
>  	.probe          = fsl_qspi_probe,
> -	.remove		= fsl_qspi_remove,
>  };
>  module_platform_driver(fsl_qspi_driver);
>
> --
> 2.34.1
>

