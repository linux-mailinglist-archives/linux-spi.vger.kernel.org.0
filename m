Return-Path: <linux-spi+bounces-5695-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4279C7758
	for <lists+linux-spi@lfdr.de>; Wed, 13 Nov 2024 16:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDD70280BD7
	for <lists+linux-spi@lfdr.de>; Wed, 13 Nov 2024 15:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128D93C00;
	Wed, 13 Nov 2024 15:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hbnau6x3"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2072.outbound.protection.outlook.com [40.107.20.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B07433FE;
	Wed, 13 Nov 2024 15:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511676; cv=fail; b=nohiH6nK+aoGwbOYoFjtXWVGAU1cEn34AUy3AXk1rjiLUVPS39vsuHwi2oMZHDbuko/RXYmF1+1aM967l4+HTHmsFAoVgjNgg8BrhWf5vxBw8SGarhiWGl74aPHmqdlQkfxNTGXHZz4Tvh/O0bJaMjjScpk3sglCEX5BUxjYF1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511676; c=relaxed/simple;
	bh=R4jnqJ/u8nTuDvOqIHgvMilWAmCRVxVOX5YFZh5OqPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JDLPzYLT1aCwq2y+5Yl8xYRFM0XbF49K126lLq1T/+tFxmktU5kxRh7pE/d7QzaFia017axIc7Zsqc12IsWwapTWY10Qxo+MKMeLO9FCNKicJCpEGPROKzF2e6hT20VlM7wHd+E5jFYHPIPj/kxIIDeRU4NNSrCBwjXON8ur0yA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hbnau6x3; arc=fail smtp.client-ip=40.107.20.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qOgK7yD3pl6Uh/aKgUerNFv8nKQfkXG/BcE8pwjwJVBhXWwO07pKuXpJ31FbXz5i3JYGmsVZTu4XXS36CSyBSjOMNQcL2MiYNRGJ60BHda0mps9mOGvSnFu1jkuK0kguCB9eH0kKT/mlOKv0WDa8cQ8FJFEeXgw0JMSBH2UmB39cu6G0mD0DYYaOd0zsTQ70EUYwRMiD7G2Na1CibwzN8FgixAryerjhzGgwRzCO0XW4t0xOxTFZqxvlUIYQQswHL3J8nMQk31DQhddypr6LFvalPbIlmwbufNY7SQni0O/MhDVvg1LoSzES+DaR/B+dbTddjz5f3NQS6WWB5McrEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZtcsuBI9HBGz8JFq0ruoMOWvydP1hpZdC7Jl4dDxxo=;
 b=Kw9mKOqVTXqNvbleK0HKd0M393iafGwHQ4T8y0Lh27G7vd9MtoOlnIXzM1z3WnSFOeki1OuTn6JwVfARHgorH87CD9jLaDicjm5KQZh7jFHGKEEZQ9VnKf8LbQuLztPz6G47pmRtttAlqx1HXhEuRF3+PtT1sppm2F6FHHufx4o7H/PvrH6Wlr9FzF/uGhe+mcZfwWLsIbIO7X0ojtlE3O1IZgYBj4EQPCa1MZxH5nAmhXBWShQrxIuMiFqQLX+lfYjl+w0Y/mwMLQMvnYesnBlxKqlOuQUyLcIXAlPrh5c1hg2AhyBBrgZmgD0P9juKN8KGfWJtY95p1IxrR4VsFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZtcsuBI9HBGz8JFq0ruoMOWvydP1hpZdC7Jl4dDxxo=;
 b=hbnau6x3ExqRfcPYXGTMi0M9fAYv4uzWDylGMYP28YN79gVU7gxlKYcJ6iMRKLgsOo7Wu4MdD+5Dm4XJSzuynSME0d5X3UAUbMX76eEwf1kM0Py3JgQbmtPRfCfu/KmRoZ1LBPzNqyhnbP9zmqp1ps4CkWtWg7o72YJB1kFrZkZ6Im88PeWEEqltMJNo+dGh2SDAA0RgtErl5xLrSH6dzLH3traQCmaBd3Q7ZPz12Bd8T1rUQFMTr0mf7KziVulkQY19UlBYRbpYoKScwCHQ/SZ/3DuExLuSdPzsd3kGs4UHw/lBoZEGLkfoU1ML8xXFhfUEXZ74nvqm4YkMMjsBvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DU4PR04MB10552.eurprd04.prod.outlook.com (2603:10a6:10:58f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 15:27:51 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%3]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 15:27:51 +0000
Date: Wed, 13 Nov 2024 10:27:44 -0500
From: Frank Li <Frank.li@nxp.com>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, kernel@pengutronix.de,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] spi: imx: pass struct spi_transfer to
 prepare_transfer()
Message-ID: <ZzTFcD+GQ9a443G0@lizhi-Precision-Tower-5810>
References: <20241113-imx-spi-word-delay-v2-0-2b65b737bf29@pengutronix.de>
 <20241113-imx-spi-word-delay-v2-1-2b65b737bf29@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113-imx-spi-word-delay-v2-1-2b65b737bf29@pengutronix.de>
X-ClientProxiedBy: SJ0PR05CA0115.namprd05.prod.outlook.com
 (2603:10b6:a03:334::30) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DU4PR04MB10552:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ec58723-1822-40cb-d206-08dd03f7bc8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vQSnunL4E6HUFY/ttPm/99bDt5+HgM8UPd3dQaXb+vZ30goQt2CXQh7ghn6y?=
 =?us-ascii?Q?P2PCe/i2RQeWlvgJMQuS6ISMwOui9QPabaMEmGaCCWfPSP27MoL/wfUgJJYC?=
 =?us-ascii?Q?+K6gp+Za/zG/hIc9yMB1bmiJpcEADO/K2fszFrEAhovdR7k6cpRw8Lz/zF6Y?=
 =?us-ascii?Q?UVuY5aZsj1zO78+cw4/ZqEig/BOxoeIRRGZcTIY6VyqefNRMu6APQ4W7dDxS?=
 =?us-ascii?Q?OWCVUrb6lgn70i0Bo7a8DAM4bMKeIksLB6CKCZWYiKLTi3veCcXhYBdWRdvj?=
 =?us-ascii?Q?y3jkPyuKYZzAuCfClniD4DmtQgJikicw/pHfDuQX4ZR4rx3SoLM8ed70MaX2?=
 =?us-ascii?Q?uVl0XDMGlf8tLuiqi7bE9mXJYyUBwRiTrLGPVZBT9vCr9Yoe5fn7II3ku81h?=
 =?us-ascii?Q?bglwvQiamm1o1sqVWdJGKivVIXXdF7svN53yIXd1E7T8Z4qA/xOC3F6D2EW+?=
 =?us-ascii?Q?/NcRVPEj4iWpCv4NwA9T7LP4AP2S1Tcc8rdpapUKBNlhsGT1YzrRd+maysci?=
 =?us-ascii?Q?PpTwL+ZPsVK+qkwxAdKDfY2eXm0igywVjU17S1ICsqeA9X05SE9cvCsFMc/M?=
 =?us-ascii?Q?nlkE7faSa6QxA7o8OR/RFqaUOg10KFGHAzs7oksh1c54lMTaQi98kPJQlwB5?=
 =?us-ascii?Q?fbBGC7y+0pgzRYIc4riiiCvWpJSouyfNOwVHrjwUeIdsDMHXEHmSQe8e+a7a?=
 =?us-ascii?Q?nqEOnoByTW7ArS4LFD0JIvWAP6i0KnEarpzz93A1UTNdPHP9e7Nt4jWQCl9Z?=
 =?us-ascii?Q?BT3GhvVp+R0R0aUZ54Yab2l4Q71FK+hmBy5PuOz7XNJO30cS0KYMBWtY1Ska?=
 =?us-ascii?Q?eT4veSFKSXu5RSCkvfioegFbIn+cgaS8zorMCgBHgRvRezDq0hUjGKBO7kMv?=
 =?us-ascii?Q?DUc6Lh+Ya8CZ/77iTM3rw1LFnb/2gBf20ZU/KeBsXQjFbdprGEWzehrO3ABa?=
 =?us-ascii?Q?tvMG1At7XcIR6VfpBzHbECZZd2dofgy/Xde81zT+xVPVJR0e2s5UyPsFn5Hi?=
 =?us-ascii?Q?AwMulwkXhFD1n19EycO+4drxrGEbY1KXM7UnKVsxX2kIkVrOycxKpB5a+aQk?=
 =?us-ascii?Q?Kt8bARedo5YHlmMs89JlImPzYy0RTqr8Fz6/diz4H2W/S007w0GD3O5DemXe?=
 =?us-ascii?Q?4i9jtBSprC+uvCoHJrM5bws77iTCzyk4oTVE6Y6MOih4cHN1au/ycKP7H5BB?=
 =?us-ascii?Q?gsHHUSyB0UrAkCic+yuGNLArA3fLBY305JJ0nWAgZ4xWWjHxdahpqu80pW8f?=
 =?us-ascii?Q?r/a4qck/AFExtZRuxpnQsdEBlTxHQXMKr4Q5wEqpMgAbjw+UoaJ/Ouyg6ed0?=
 =?us-ascii?Q?QvNWGegvXvRN2Lzx+7RiFyO5Zpa5Jb+ur0YtM+y6pmwK6SJnWpqUhlQKswOj?=
 =?us-ascii?Q?pWmGBRE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CbmrDOmLQ6PoDUIjJztqqyU7xDf9ljEr7DGEbTL/qpBUGM5csv5BPmTp79dQ?=
 =?us-ascii?Q?VFkbBdOi0t4fVDkr36Yl3opK6xMJ4eaO51TQ7DYtr31hM98tCUzvQkiIwdbn?=
 =?us-ascii?Q?9EOzfO+tkHRgB+AryA9fCGHYR6NrizQoCYIf+VuP8B6Gvj2xkhOke86+flAp?=
 =?us-ascii?Q?rb8FTzR3bPt1Wh2t1xlcQ4IdQklA7xUujlCFmmW+3231yUfWQQXx+f7S1Zm3?=
 =?us-ascii?Q?qYWqNqL/QnqE4mjiZiiRmQQ+IIjIt/wzWdU07x04k7OXEmspkh2VcA8FxgK7?=
 =?us-ascii?Q?gD0gO3wYtEK9+v031AceHmERYQ+lH11aqRMnhBEaFxq2Hx9mnCDQkcWKnjxS?=
 =?us-ascii?Q?2orr4ZMrg48Hz1vKfNtJu3LXQ7hmR6XQGhXF+oEbmr6a5oAxAC5aQNNfJHXV?=
 =?us-ascii?Q?CU93C8YJFSJjfWF5a1tlBn+IQvuQCxg2cTdVG7O83sbAijPwLFV4+OoSyCvg?=
 =?us-ascii?Q?M4V4xS39YYabe/6Amsg59IecfEyE6yBfcT3F4CfyngH4tny2384fMxPoes+s?=
 =?us-ascii?Q?c9+8+Yv01uor81SfLcXPuqG17gOP5H38q5rBr5eFyPzaN6O2+GwBeewONm5X?=
 =?us-ascii?Q?WqOnotLT9WC1Zz4xHz5kiUJLIgYJuXZ66ODmD9Cvh3mCdJpb1ZRzfhNGIIgF?=
 =?us-ascii?Q?1vExZCH3sebVcpZ0IadAs8AcUKbd0VUr5A7cFPlicXvXzIPj/IYVCeIm1Guw?=
 =?us-ascii?Q?Pga7hWAgJGoFT2lHzdRJOuT6PwnR7eXp5a5HBtvYCbjHpgDxW4PBu6Y6LFsC?=
 =?us-ascii?Q?AanpRfmvCMEZdLzvjLv9AGei/mx2QOMuT8avY+vtQDg2+PzvcJIAFbHb77sd?=
 =?us-ascii?Q?ADwB5Zbwy28YE9eyhHOLhB/oZM6mxotC7LSwvL+2UyJe1wzQBotgR8N8lCYW?=
 =?us-ascii?Q?XCjL7Tnuik5Ka8ZDFfNSN1Wv2ZUrnhktgsgQvopnR8ZqI+sW33MIRknEq1g5?=
 =?us-ascii?Q?bG0uxho7Af3xKrvaaAjXEyG7XQ7Ngr8s4VhQUo/fuuM5YW8/ld3Oq7p3BHHl?=
 =?us-ascii?Q?J/++Obvh9zi8r8XJHmOURR245qshXBzeSCYF7Fx26ruX1uSLX3qMq9Ck0vTt?=
 =?us-ascii?Q?/g0+Aa3MZ/TrJvhGTHYllCR8Qe3NgQo/clxFMeQLkn1vp1qU4WhC0Wnho643?=
 =?us-ascii?Q?HtckNlvUWwPXrWlpHAuByy2uibTlURdSVAygKLYjMVfplMHqj8vHFFezPPAK?=
 =?us-ascii?Q?WLyhjVwadRAUUb85oslZqgQuQ5HQdGcJnWHgb8ooV4JwjAlKqDBbIxYYDQvq?=
 =?us-ascii?Q?vc0MRYxpJKB/rJBcHPzXZ1cbOo3+E8TOPp8fnpXEzxsmT7FS4XKwkuRjjyMW?=
 =?us-ascii?Q?3rDYw6gh7NzwONrRQJkL7OKTuyqgx5keZkZPURZJu/TXIQ7FkgxqnZsAkeKe?=
 =?us-ascii?Q?Iqu4Y1f0Ng6P5DJEZQESKnWWBd0y/04kuYAMCDyx7fz/3rwZWvmo7riA58Xe?=
 =?us-ascii?Q?8/Rmbuldug4jp053bLpvO1HTzS/0hSDPM8Tkgy9dK2IatE+CvNkVt9zrZxW8?=
 =?us-ascii?Q?8hd52ml5og9QV/VuNnxejqlzN+iwM4SW2lil3Kk49NWk76XEAcuuXVNFT3YV?=
 =?us-ascii?Q?ND1/PMBnD4BA5vdwkO/oN2tS1fZR5R43cEEc2qt1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec58723-1822-40cb-d206-08dd03f7bc8d
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 15:27:51.4481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /cNo/+/1hUYZupSF3717HCbCEX4QhM4ZCO2SF+jtQvFQoVQ9jw2lQ8JlAEb3ZEsuWsdZCneNKUUkp8vXKDEjyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10552

On Wed, Nov 13, 2024 at 01:18:31PM +0100, Jonas Rebmann wrote:
> In an upcoming patch, mx51_ecspi_prepare_transfer() needs access to the
> word_delay parameter. To enable controller-specific handling of such
> per-transfer parameters, extend the prepare_transfer() function of the
> spi_imx_devtype_data interface to take a struct spi_transfer argument,
> update all controller-specific implementations accordingly.
>
> Signed-off-by: Jonas Rebmann <jre@pengutronix.dei

Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/spi/spi-imx.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 85bd1a82a34eb4bc76a4b4528e087fc2ebfa8b85..65a8303b80b1191cd2c19d61f88836e7fd3c7ae9 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -71,7 +71,8 @@ struct spi_imx_data;
>  struct spi_imx_devtype_data {
>  	void (*intctrl)(struct spi_imx_data *spi_imx, int enable);
>  	int (*prepare_message)(struct spi_imx_data *spi_imx, struct spi_message *msg);
> -	int (*prepare_transfer)(struct spi_imx_data *spi_imx, struct spi_device *spi);
> +	int (*prepare_transfer)(struct spi_imx_data *spi_imx, struct spi_device *spi,
> +				struct spi_transfer *t);
>  	void (*trigger)(struct spi_imx_data *spi_imx);
>  	int (*rx_available)(struct spi_imx_data *spi_imx);
>  	void (*reset)(struct spi_imx_data *spi_imx);
> @@ -649,7 +650,7 @@ static void mx51_configure_cpha(struct spi_imx_data *spi_imx,
>  }
>
>  static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
> -				       struct spi_device *spi)
> +				       struct spi_device *spi, struct spi_transfer *t)
>  {
>  	u32 ctrl = readl(spi_imx->base + MX51_ECSPI_CTRL);
>  	u32 clk;
> @@ -774,7 +775,7 @@ static int mx31_prepare_message(struct spi_imx_data *spi_imx,
>  }
>
>  static int mx31_prepare_transfer(struct spi_imx_data *spi_imx,
> -				 struct spi_device *spi)
> +				 struct spi_device *spi, struct spi_transfer *t)
>  {
>  	unsigned int reg = MX31_CSPICTRL_ENABLE | MX31_CSPICTRL_HOST;
>  	unsigned int clk;
> @@ -878,7 +879,7 @@ static int mx21_prepare_message(struct spi_imx_data *spi_imx,
>  }
>
>  static int mx21_prepare_transfer(struct spi_imx_data *spi_imx,
> -				 struct spi_device *spi)
> +				 struct spi_device *spi, struct spi_transfer *t)
>  {
>  	unsigned int reg = MX21_CSPICTRL_ENABLE | MX21_CSPICTRL_HOST;
>  	unsigned int max = is_imx27_cspi(spi_imx) ? 16 : 18;
> @@ -953,7 +954,7 @@ static int mx1_prepare_message(struct spi_imx_data *spi_imx,
>  }
>
>  static int mx1_prepare_transfer(struct spi_imx_data *spi_imx,
> -				struct spi_device *spi)
> +				struct spi_device *spi, struct spi_transfer *t)
>  {
>  	unsigned int reg = MX1_CSPICTRL_ENABLE | MX1_CSPICTRL_HOST;
>  	unsigned int clk;
> @@ -1304,7 +1305,7 @@ static int spi_imx_setupxfer(struct spi_device *spi,
>  		spi_imx->target_burst = t->len;
>  	}
>
> -	spi_imx->devtype_data->prepare_transfer(spi_imx, spi);
> +	spi_imx->devtype_data->prepare_transfer(spi_imx, spi, t);
>
>  	return 0;
>  }
>
> --
> 2.39.5
>

