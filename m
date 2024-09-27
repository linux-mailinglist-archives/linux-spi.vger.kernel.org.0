Return-Path: <linux-spi+bounces-5012-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CB9988885
	for <lists+linux-spi@lfdr.de>; Fri, 27 Sep 2024 17:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2BAC1C203B6
	for <lists+linux-spi@lfdr.de>; Fri, 27 Sep 2024 15:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC7D13C914;
	Fri, 27 Sep 2024 15:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OVqlYj4R"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2065.outbound.protection.outlook.com [40.107.21.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556B618B1A;
	Fri, 27 Sep 2024 15:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727452074; cv=fail; b=AYk0EW1VB3BaDwdw2MsjtAIIfmw6fUVs9+MmwbHUI79iDqoTOLFuZhN7ewiw/7HZvAlbBFfTJsfL/dzEjZJ5IbliiFLOdSJxrjDUmo9SbL4KNB/eu9wqQSrug2ZbAv/BaC/nryq4tB06ZrV3Ru9Qd5jDddWr40SmHxjnN3LFcYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727452074; c=relaxed/simple;
	bh=muWypp49wo6YPhcPAUuy9iklXvR2yryLrsiyNjT82vA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BvwPbFCjYlTF2/hRNDfok3E6KOIK4XBz+BqMctIqmSgrBBOBKhXax8KXz95De58PeV/fk2x/I6lF5wYk5boAZ2S/8I+QLGczwechjHrgdPLiihHuSTXIcP3ATri66cnmEPonl4cRxU13B6iU588b9aGS+JrUIMIk+e1zUjXa1qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OVqlYj4R; arc=fail smtp.client-ip=40.107.21.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKoPN0x9e0uHlwE4XDfkNIeq9NpqOxBENvpkbC7f27+oah8pc8w/+J80xIFYz+EUbxPMY/el3st7cCCgK//3qG2nTl1PYS3dwm7FdBjiR5U8NLiKOCD6lM6MzJmu5WSJWmmKBQSZpaOCauHRKZvy2v6trfYPuaBnz94z7vuv5r5v12OMzOU1jdrfOC4arqP5xD830WuK1pi8iUMVmAUPl65wbxnY1Lj9IxRf88Udijuwuad6fYuxhsM8Y8cBJVes3EMNLB4lEd7yTMJzxU/3/Fco33XMxvku1gLVLxB01Ul8/zf2PuVzlIdp/b3o6Q38Wm5m/aamHZCkC6D18X+lcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Get3RruaaYbrHeyHSgQwTfOKXRymK/SXVQOQn63cMXw=;
 b=Lwr+Tc3nwjXicfopumZYOIFPZRK49u3UBsU98yEnyRxU6Y4OWwD9ugqk+hTO38gkQmL/OqOvRQ7k5jmXZJkAWwnpv7YLksz9pDPerveFow7jECytfSW/qEginBqech0yrmNpSBLvXacUIto/P9Ez7H/YTphJofI0UoOveLI0qUWwdJr6OuFv4dik2pDrVAYKmdTT40uiILdH1jcgLN8UmsBVmeWChNPNdbLyJTDfFEJIhEySrZeLh4ZZteMgnwmsI0eVXIACMlnH2BDpbeTqecPkpjY5Rw5ynF352hm90G5aYC0228sojd9kwBnp/jHgeJ2FeMRTalDtk6NFeCysdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Get3RruaaYbrHeyHSgQwTfOKXRymK/SXVQOQn63cMXw=;
 b=OVqlYj4RYCk3MwWI953nN5UKrUPMtOYcptg1krTGvmNgXxMZOC1XhJKl8l//Z5yjNcuhY+lHhdQHoZno2gEZ54MVzJUbM9tGV+dck9ZWmu4k5H4eVZPpm3A4guUyGH4Q7JpvMUJZbS2e+7BlBfcKMqk/pD9wvDjg68e075KgI9JQbq6mXTdElQbeE99PBzoMQDYDJeeX9gFGnNAO/wQ9sQgA4BC7/dtjXheibVUaSjA1u5cO8qYgUmaSoJfOPpYOPTqCwuA9tnFzAvOCLluyRf3/uYXxBgwj3bQHdKyrGfwvdLY8G1Bp434qlvBIjzUrsbI43hvzoygKYULDVO+rYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB9129.eurprd04.prod.outlook.com (2603:10a6:10:2f4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.20; Fri, 27 Sep
 2024 15:47:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 15:47:49 +0000
Date: Fri, 27 Sep 2024 11:47:39 -0400
From: Frank Li <Frank.li@nxp.com>
To: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
Cc: linux-spi@vger.kernel.org, olteanv@gmail.com, broonie@kernel.org,
	Han Xu <han.xu@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Haibo Chen <haibo.chen@nxp.com>,
	Yogesh Gaur <yogeshgaur.83@gmail.com>, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/4] spi: spi-nxp-fspi: Fix casting warnings
Message-ID: <ZvbTmwuW1maXdWY5@lizhi-Precision-Tower-5810>
References: <20240927132944.19285-1-hardevsinh.palaniya@siliconsignals.io>
 <20240927132944.19285-4-hardevsinh.palaniya@siliconsignals.io>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927132944.19285-4-hardevsinh.palaniya@siliconsignals.io>
X-ClientProxiedBy: BY3PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB9129:EE_
X-MS-Office365-Filtering-Correlation-Id: 035e20eb-666e-4f69-d004-08dcdf0bbd28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t0kvL4jJkDfI7fnceg9at5avLZX5xPigikISRXwntdDDu2KjpqK7qHEmkXoK?=
 =?us-ascii?Q?3/q6bsPIZgbDPNVlJG//S53xv6jA0ZKXZnmsnvWnRlrbvfmW7QKzNjV3ByBa?=
 =?us-ascii?Q?NMbiqAgBPeBAFAZM5hFmDwAvFXgNN5yHpU+OgE6RJBtDLi+OHvBQ0C+w8HKX?=
 =?us-ascii?Q?dcslLjJ7C+tg0yJW0Y5vGRKc03voKpIySUSYeQvD9bo9n3Z8Trxw8w7nLsyy?=
 =?us-ascii?Q?Hd47mAIxDeZJg0K20VKk2stbGftDDHGSjQueX66u3NSWV+OaF9Y/BGBJVygY?=
 =?us-ascii?Q?oQhiAZZIeO5U3f+w8MOK/I2J4rTk5aHFmHJcJwHu39DH8hlK3VyoEQ9LvJUQ?=
 =?us-ascii?Q?KSY4EysHKTZ9ndB5100o6/U/2WpCVyNflr/cLJ0zhKRfCYufeeHKl+/DMsx/?=
 =?us-ascii?Q?j5rlVp5EuDWH0M19ktpIAOo+mJQvAwgJSVLqK5fR2ADwGPeszIEjzlXA3Dms?=
 =?us-ascii?Q?EtayCpgxrbsf1iGoyGwmtuOs8fzFq+aQ3vPWbrBAoYOzsG0tP2CwYv7DI925?=
 =?us-ascii?Q?nMpnFyMQcVQ6pE2UKKEfMNxVnnN3kc2ZsdQ4P35dwQ+qQN716IUCVPjsoJW7?=
 =?us-ascii?Q?0gAxLVyJNkaWMGM+YJAnNQR563wYGepKrkrHUxxBKwF/zJ4uwHaNQORSZy/G?=
 =?us-ascii?Q?geYShFZVWbgm71CqMbtGTiAo1KuuD/CDe2YWIj8unJCJZ8InjDn+9PksFHXu?=
 =?us-ascii?Q?KDZP7mrzKeALw7vNNnYxgL8/U9H/35YHpF5WxlyJ2F0/wTLD/5XpJHGghOAS?=
 =?us-ascii?Q?elFpNEkb4VrWe/Jyk6xNAYKXXGzK7VpZcPLiq9Xdp1f2O52sIpBaETMMctmZ?=
 =?us-ascii?Q?P3eE4/a4WOvoK8vghg8fb49agnbYqf7w0T+7ZhLoUqEB4dZRT4dH33nF8nzA?=
 =?us-ascii?Q?PJYvxxN8Y5D+YzCAY3Bnt9z0tRQp4TUAHT7n22IsnRfJuVh+NojsYQSHHK7u?=
 =?us-ascii?Q?utnMoijPAvkImb0/HxiQTeRLHDCjEe5my9jS8AJXaZeUT2WZcV4Hkq98/Xkm?=
 =?us-ascii?Q?rn1pcU9JkOkYlCwVZ0+VvQUTk0U8UO28hsBkmZ2YN7t9cdm/9P5YM8tEYQOs?=
 =?us-ascii?Q?9OGoAKoxemAsv1noJYbrRFtrKjNXsRHtZIaYp4JMTlzqRQBEuAi2UWoq5Ts3?=
 =?us-ascii?Q?cz6acQJcwZnj6IKQO+QyolyHn8k/cBmNnR79Xqmah41/6T/cGEWfHNp3eMeT?=
 =?us-ascii?Q?EI0bN+S6NW3dfPp+BpypqmTZEHHJIGU5BkRIYxnOJpAph7S8FmbgTfIQIm0E?=
 =?us-ascii?Q?pm+L677iiATWO7NHa05SOLPjIjslCKsljEftXMFAhTurAEGWeQJPsq69VYbT?=
 =?us-ascii?Q?Oo0aiXyuCwOyyj/N5PEO9r5ZCOgvU2DMKmSP7l17vIkU2w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/k9cpMUrXDBnkGcLTYaNRyomI1IHyJvoZXrli/HBSmNzcihrhuMKAUUTb710?=
 =?us-ascii?Q?OuNKSTYCkvrm6UtHoHGp83i0OaJ8IKXPy+oVPWoGq0g5hyMSbiu7YXMNA3fv?=
 =?us-ascii?Q?neu1S8gwur+fzMMqihHfRLOCjz89l35p79jTmtuwRq2KrrddKYQ32HxiN5Eo?=
 =?us-ascii?Q?dCB5yMGD0HZdibRXPOHQzN6aqoxZjjNE53BO/XbGMdaRE01/qwBtKvK/liRZ?=
 =?us-ascii?Q?NoL/cwTwh1SUoiQu3ysKWg3jQ6RnSLXk8DfXPKnJ86lYaB9bLfazUaRLNLWN?=
 =?us-ascii?Q?lXfI5H0t5UMKibc7eFctA1cgfTaBkyrGy8xOunaUs7A1GXBXrx7E3vY0Gzth?=
 =?us-ascii?Q?6BsWE/2vxa/sa4rRA/TeeTT+dVeoCrmKh5st1bJrWIEco75tRbI4rGxEMRbX?=
 =?us-ascii?Q?9F01oboepiSURsinbmZjTrfbw72i4aAPR6zPA6U469c5rgxBXmNAqycjkmZi?=
 =?us-ascii?Q?89maqz1dytWHFKVYcp+VTpzgknQKJ3cQWpwoSZJ6US8xHkeLZ2Nd32+4C5sg?=
 =?us-ascii?Q?IY1zEExS6kqfCnZ+xkr9q8tzlXJ+iazLqWlz8WgSmS1AcK7xFNvhE5T8xR8L?=
 =?us-ascii?Q?LKIe1FjC1BR/WR40GpVnLJeZxTfsAZwQ88BGo7Wm5P8pSETLxcfiIiRiMolr?=
 =?us-ascii?Q?bSU6JRv/fQY2yIcwHb+4FA4fcoFpy1qO+SPiqT4yuAvElMaJQqHW144DKhmC?=
 =?us-ascii?Q?wBuX858osDEPjJdWLw43qfCXnwOG2BY6XRDfPzgyGdNRZ8lWVriE5xe40dyj?=
 =?us-ascii?Q?ztHTLy8IrglS7jGttbjOWnhdYOTSl9fBAubvpxk1jm8oZCYv3V/jz5EpJC50?=
 =?us-ascii?Q?H7EJR7HxhqVdNKWIfxgrFJao2AsWUZKkRisdum+8jTNTaaVDtTSsY8Cut4YF?=
 =?us-ascii?Q?N624xO/IVt/jm6glyFBCSBMDxiHsa11sEB5DfaLI1i5cxvRO+TtZaFFQL4t1?=
 =?us-ascii?Q?zjy0eWJuwfHf1xcmXjK9PyK7qZHHyMXFFEhXixIR8Egb69J47pL/Sj+JlC1u?=
 =?us-ascii?Q?ihV279cFgja3y0/QrutACZVUTNGIYpjLTcPLrCyMtXk5FixtW5KlB5jwyaBV?=
 =?us-ascii?Q?Qb1XdF7MiPY3LPzzS4mYcN3wm+XwDSXNgzav1gKEdf/gkiyPVx3/EnnQqllD?=
 =?us-ascii?Q?MMYx7YxenDjQAJ8XXWsi9R4L2T58mY+oEsy1enK8+d53iqbB4UOPn4Mx7i97?=
 =?us-ascii?Q?gFfb6A3Aojhi2WteL6+WgDssGDS7FVd4GHIV1QjhvteaQiXJlbnryMVs4S/2?=
 =?us-ascii?Q?BvdZF+e1VKJHSEh9ZS3BWM/OKG7rDhTj2ghYBoLBMc8KEAnkfCBj+t4GyHB1?=
 =?us-ascii?Q?fq0O6KlPOFhXO8afc+1bpqUBymfnzkBpTxSLF3FuGR3fKUkWNLF8djNb8hKT?=
 =?us-ascii?Q?alGvWv6qowSAuAYsVnUhUVtNq9nPA1KBskAZY/ZaDYodJb/izJlaNS53Kh5F?=
 =?us-ascii?Q?0qw8Z1bgPeeAGLCPdfaRdcKy1MnsINpXGGpEdx7kzGsCC8tUY5pRH88gQfGm?=
 =?us-ascii?Q?GcuDp3sN/Yxuk05+fweTd4IDDhCe9hqcU7bEIURv5OB5YfvsuxsgIVMoFRkt?=
 =?us-ascii?Q?XyrAB/s0nZ0jd317KxmGBJdWfzKgQETq4ExRuetp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 035e20eb-666e-4f69-d004-08dcdf0bbd28
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 15:47:49.2665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kkqEWRQtirNpV2ZPu+jwUcp4UIR++E/pDRraGi7B66gCmgolmbBKpBSee6dX/9qUQIvxrIJcSnBPDD+Q0iYWsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9129

On Fri, Sep 27, 2024 at 06:58:35PM +0530, Hardevsinh Palaniya wrote:
> Sparse warnings:
>
> drivers/spi/spi-nxp-fspi.c:512:25: warning: cast from restricted __be32
>
> Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
> ---
>  drivers/spi/spi-nxp-fspi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> index 6585b19a4866..f602bfd11426 100644
> --- a/drivers/spi/spi-nxp-fspi.c
> +++ b/drivers/spi/spi-nxp-fspi.c
> @@ -509,7 +509,7 @@ static int fspi_readl_poll_tout(struct nxp_fspi *f, void __iomem *base,
>  	u32 reg;
>
>  	if (!f->devtype_data->little_endian)
> -		mask = (u32)cpu_to_be32(mask);
> +		mask = (__force u32)cpu_to_be32(mask);

See patch 2's comments.

Frank

>
>  	if (c)
>  		return readl_poll_timeout(base, reg, (reg & mask),
> --
> 2.43.0
>

