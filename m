Return-Path: <linux-spi+bounces-8740-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9273CAE6BEA
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jun 2025 17:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A56A27A53B8
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jun 2025 15:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781252D1F4A;
	Tue, 24 Jun 2025 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="P+1RE6O5"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010009.outbound.protection.outlook.com [52.101.69.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB01274B4E;
	Tue, 24 Jun 2025 15:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750780733; cv=fail; b=LIL/EM+atQUORj3ia9gRNqFeAT202iKWBcEk2zImM/IZsGgNYNCspULiPL7KH5ny/JzNh8Mxx2T0QeGv+zKyfchJHaEed9uKSdqWD8ydfGYy+qM85cr4q+pv4rEF8usxIrhi1tYgiRvtyhT49cskMHRxC8Pzy5He/ozFlH1mW3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750780733; c=relaxed/simple;
	bh=rCwHCVOHBKT2vSNGo0brTeZdq1QpzOeQgDXOfzY5wd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AK8PPDDRaSnZh6zq86RSeS8CZW+nvldfSZdJTacuVXtZuwWrU/yRcVymUY2hqN8m+BwKllL0DN3D9tIx3IV+qCxRtLODE1LDKlo3h/WUbxRkm5oxTdM4i63RKoqqUvjlm7A128AlXd13oCiMgaJ1zvNvC9fSINbey8pK6TyzcB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=P+1RE6O5; arc=fail smtp.client-ip=52.101.69.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MhoG7R/7GLE48rrlCGo6s3hhU9YzIRuBEXNWkShiF/I8A1gSoYQxNVjv52nXmbhtuNXP8Txst4y60QK9O6yTxpba34HfK+I5Usu5lfcMIf5z0Upwj9sZ8iwssl8XMztMlqKfqlEjpEOV+kkKk0zBhnrqe3pkXmdi45a4cN5KrSd1zNaLUHtCMzqzgK6L8BAF+rYvi+dbx2XZFEqU3jE7vtRCjI9IhTqkuPPldj9/GkpfJVGMGUpKGE6lzkL4wlvZgJK+DsMWgawI+Du1L0DtmAuQALUO3kdW0THpp5wlmkTGyEX7ymcpOC6ZrdoObiNYOkHu31O+Ejnb0Q5PJo+eTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hOc8724IsQJrp80p15sennOc5+6yp7VAZ/TJy/3mi8=;
 b=MvRjCIvkj0/qyaS3pMjTwETQkATizI0WwkWqcqnX6afgvIigtSpgPxHxD5sqsYmFd1vm38vtme9RTgrDJgczWTNoeEnT5veW2BXLfmIdvipBWjtOTE5NvuSpAe4txrBzVJaMg0xwke1LbnBtLx2gmwFbG2RELTPjMR31oiB6UzkJnqbwC0RyPkh4w7I+5NfO9iydrYaqa/18lapFKm0zy71Rqrd8sLU8BUZ4PmCrw6dS5zXKsI1hTzNDo0po6y3F1InEF7r6b4o9UVvVq2IdXja1Jwjhx6EK0XbYD87YJ292zZYC3z5zu6qwpKHSEND3egoKOc0mfTt5EsayZMqMiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hOc8724IsQJrp80p15sennOc5+6yp7VAZ/TJy/3mi8=;
 b=P+1RE6O5zQefhewX8q+J6y+2WeNthqwWTYvdUVK97kjTBDkJJ9UixTsXyM3kqyS9vSh/vCmA0a4eaXb4oJoMhA0yG+VYGXmzXCUl3Wc+rO1jGB5QuYuSqpDO3b5HoQMwbN/9ye42PKRu+AyIXTJFmU0OSjFvlXyZohGvGfNYxkdUuR4TRlUZpnWpXDhann17sUi9/XJVMbNsX169HSY1NrTszBxvkEtf1uZtHbevjcLZB9ULlmrBusuO9HHRDuvPrjcw8l+VZS3mLu2UPTfyC5RMuvjujwiKhSsVvTPxuxFxKuJBJ3Y8f25+EQok4qh70sL/wdCO+sZ5Za5UhBCuWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9232.eurprd04.prod.outlook.com (2603:10a6:102:2ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Tue, 24 Jun
 2025 15:58:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8880.015; Tue, 24 Jun 2025
 15:58:47 +0000
Date: Tue, 24 Jun 2025 11:58:40 -0400
From: Frank Li <Frank.li@nxp.com>
To: James Clark <james.clark@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Christoph Hellwig <hch@lst.de>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] spi: spi-fsl-dspi: Clear completion counter
 before initiating transfer
Message-ID: <aFrLMCq6hRJj5FjI@lizhi-Precision-Tower-5810>
References: <20250624-james-nxp-spi-dma-v3-0-e7d574f5f62c@linaro.org>
 <20250624-james-nxp-spi-dma-v3-1-e7d574f5f62c@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624-james-nxp-spi-dma-v3-1-e7d574f5f62c@linaro.org>
X-ClientProxiedBy: SJ0PR03CA0226.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9232:EE_
X-MS-Office365-Filtering-Correlation-Id: cd50b99d-83a1-4466-7e0a-08ddb3380138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BUrNb3VWW//XVqnnoycOsSeB5zh34a9Oh6j8na4sNASSatCQHHjwQN35rCAW?=
 =?us-ascii?Q?bRkeTZ87HBaco/qJpCJGjkAda7RfyXx+2CxYuo/1CAzJiMW/HxjlnTXkHl35?=
 =?us-ascii?Q?Zix9SawVylZsu3811RQUTJw9gpPTyblJkxkaDoLSwa6g3bFOsnUeOhDcy+ij?=
 =?us-ascii?Q?1lHOAsbzG8NQ0+XGTuRhmGgYcNOo7Xza6ceJ9fdphBnT1HBo8CfB/az+1i0o?=
 =?us-ascii?Q?L3qPtvGCH6JMwWS1Opj3AIJ7ENOPTSCuG4Mo65JSnkNE2FCGeCuHZAAS6GXl?=
 =?us-ascii?Q?N32pHifJ5TahdDZW6SEjYpLVTkhKqX5948MbuHxdTg/pzeOAkA5iexnyfTMs?=
 =?us-ascii?Q?uam9tXyYRZmqWuRnigeVCAyPI2ot0AGQGtUt0m5HBmGQkJqxgST6y2kuNV9m?=
 =?us-ascii?Q?JONGMBWs8UwAzN0CPnxowOAJZFtvU2YweA8B1VDhOOHRwxRyFGIb9XLmW4Qe?=
 =?us-ascii?Q?54Ky/s/gDq/tL8To/xOfG2ldnUJKPuc7wEwZmKkxzJl82TLnwRKXJG5Ccjtf?=
 =?us-ascii?Q?0Dru7vCk5Mdso02NLt0ebU4fijIoocBAOAS85yyoY5m1fMRBxgXro2j7hCST?=
 =?us-ascii?Q?HCzzIHpElVlcD9CJNc2qwBLhBBUS1BTmY67FZlpF9qPq89hY+uknFxVQ77+C?=
 =?us-ascii?Q?vLVdtbLwr82UZPUcH+52pGlA2pKNtmbb9ZnZoGXzqTvvPDJRSi5aX8oz1QDq?=
 =?us-ascii?Q?+Gkj+xeE1Hf16zMz+XFzLA2E5+43S0dpYHqfq1LhhqlLYYglbkznMxqEWL9j?=
 =?us-ascii?Q?Q2FQLJpriovY5hTqANeF7j65+EjrqDtwbFJ/gbIcJtR6N28c0gSd98hdHnUJ?=
 =?us-ascii?Q?ZbN5tQ2rWspbU5ipzKKGvQ1eekVlivQ/f7y4df3dNg8bYQFXX6cCdQpkZQOm?=
 =?us-ascii?Q?QEr91uks2HKJIDwkbTdWEJvWpGDQ9fWXe907BHNpo0OyqFhrpD3A0Yp6uOms?=
 =?us-ascii?Q?z5ij6iu9yG08X+2tTdYKXqEW8aH6KIWycLEcrA/adGeHGUd67koyZcAYmcnR?=
 =?us-ascii?Q?1P+y4TFD/S0W8sEJnh+3VvY5NiIWn790HTbFb2HJ3NgWAe/reem/4iRdencK?=
 =?us-ascii?Q?RaV0lVKlHDA+9W9dqRKVA+ZwVBEjLwSxl+ZqpHJHsdnMw/dvMJ2osfVrRokf?=
 =?us-ascii?Q?A2T1WJfwq9Uv/UnYX9hosJDOWg/gz1PerthXRP37bvVwHKX0HMCguzLsvipb?=
 =?us-ascii?Q?urPPd3yIs4QRPHE4Ebm8StoV13EDgs1qVitDMmS88Yd074Lu08w571rmZPG8?=
 =?us-ascii?Q?92VK+hjDgnpP9OiOk/tbp2Sp8eJjCofuMatwCLMykZU5PdnMns4qpqKA2Hsv?=
 =?us-ascii?Q?k1z3sdM0TV0Nireygi82/RHrcQtkumphI645HtXV2O7pY1CjSwkFndbT2y+E?=
 =?us-ascii?Q?OUW+uxT4u3YzDzybUz8iPn105iF+r9mJAMZrJx6VJMAwxZB3MO4kVdXHIs3s?=
 =?us-ascii?Q?7KY5MrEQRid0eIW4zfpgYJIdPRgL0RD6LS4qcz0QIZAsUvrn2JZiBA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vu0gms5GYlxKN0tLTf1x5eVeDzmGwa04plYELbEidKPGFLbXD6eSga2ibmif?=
 =?us-ascii?Q?BF2ciHBQx2iRHi+xc6tY/nFxN0wob/8M2GSOaXc/Y+3J42gqIqUKs9pwRciU?=
 =?us-ascii?Q?rjB1oXIXmXWvLU7tnA+rtr8Yc48w+IbNnb8IPHi2uSnzS+sxtNsMaALygtMs?=
 =?us-ascii?Q?uPuQpAtKQtuXBbTrfLBeg6hQ4tP/71PF0zqRBTtQ/HBU0f0BG8/eUOeXcI68?=
 =?us-ascii?Q?euP6IKGu+A/IUiSM0Vo9vSncxLopJz0zY8GkSOkDVwTP9vy8lPdfN/Gnosy8?=
 =?us-ascii?Q?vG2kQqIaMq8XcUlqmcVNuuSJD6yfGa0lLZMIy3o6kTmpVvbAVExNXbXmXl+x?=
 =?us-ascii?Q?pHPHwNJEM4E1/zW38/0lJlOcG+pJaQvdiVSW2QX4YBSTNv12DhqXtH096Nwo?=
 =?us-ascii?Q?kFY6pIJczKbj+Y5hCK9ZV4xVY7jGTh/8rXkYPpb2jgMgwQ3t1O8PAcimCR4g?=
 =?us-ascii?Q?zzRfuvagXkUVQxPbuYhV/pbYFwbh9zNIAM8EdUTZA1wcE37nvYy2KKt+E+2V?=
 =?us-ascii?Q?JCbYZkSqdDfMZasjS/B5tK9WML3bhwLP6u8tGela0ru7kD45Dbs9ebClSxKl?=
 =?us-ascii?Q?nsweqNtNXrPSLhCHhdVGTbHceOJOutQZ0R+sCmbwrswcZkCXiYbWPqO/b9hj?=
 =?us-ascii?Q?NVwgAvMgZTRLLx+YJXvpaRLTSJ/ch9143jB0LaHX22W4ZLzTYbmB8axYwZxW?=
 =?us-ascii?Q?XiwzqK/8jfCm3Mt9rux0ecXawwpPuDVZT0X2Uy4bfzxbZSNbGChMB/CtDot4?=
 =?us-ascii?Q?K7OiC4IjLE39Rn6fBc3EKDFy40D8NMAGLAn6x+OY3Nd7pERQ3MtwVvdnh0EE?=
 =?us-ascii?Q?Dkb1P/eqQEMLupt8kl3OKVJy8vnAuTU0xtrmp9q7f30FwgQK0d3E+fV2sJM1?=
 =?us-ascii?Q?uN/5YSW56fyu18eKxeHQsN9m5yR5/E5TGmf+GtbMuR3nHgWXEeU7s3WWeaCh?=
 =?us-ascii?Q?GDmG9bg84Evjwns07vYvGGiAQoKOmE47oc0soS6OX8lMs6kuAlsFpqvCrhe1?=
 =?us-ascii?Q?l7HOaizFDhLMYZBGNMjeFge1mt3I2j0TaSRQUnEtCQzynoLS0wTc7v0EHYi2?=
 =?us-ascii?Q?FMfA+sZ0vFeV7Rsk+AM8H/OWlPoGOXMbMSpSqk6qo/pSPiiKsHN01lCNmyrd?=
 =?us-ascii?Q?PQUw/AJRbQG/p3ugio2JdQTzbuQjqastxV4xJ/ld588jdIL3FSSNKA2f2f4Z?=
 =?us-ascii?Q?ptSAQjkNXCo6IyhOm8PJUw8DbbBUeV2xX8AXt8o7lwB/wNjO9mbkyyq7NDXz?=
 =?us-ascii?Q?b009F+yZ52dDZTXAqG9Jmi+j2Q5YSy84Ce78szf4C/iGhZnPRYAnIrVblya3?=
 =?us-ascii?Q?9dd8npnVXAnbrPuS4hVYH6+4vHr6uBHUFIyifUhJpsRGNNZLH+u1Qo9N7Xqc?=
 =?us-ascii?Q?quBWny/yVUxqKBLfx2dYxbcmWgg6IcNdPEnD6e+4Sxljmz1bNboKnyUwmMIG?=
 =?us-ascii?Q?jPgPXsNa2rQ3Xx99a5kGftrmw2UUTsj6VXHuX29PhrOpfUeUYKH4tIycCrvP?=
 =?us-ascii?Q?+RT51e9DrqIorBtcvfFVtv6wmpqoPfmaCcRNWGXO9FpT/MbW3PPo/L0IaiFo?=
 =?us-ascii?Q?kF5rwd3m7EV+ut6tfo8jMCXIg56ZeGWqlZ/jVAmC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd50b99d-83a1-4466-7e0a-08ddb3380138
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 15:58:47.7950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AzkAXrWOdBq9SfPza1N27O9SxdW2dOPqrK0n0pa55KvRn9GTSsMHmZ6ZCj2rqnAwoAYt+waBdme56PqDxWJWGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9232

On Tue, Jun 24, 2025 at 11:35:31AM +0100, James Clark wrote:
> In target mode, extra interrupts can be received between the end of a
> transfer and halting the module if the host continues sending more data.
> If the interrupt from this occurs after the reinit_completion() then the
> completion counter is left at a non-zero value. The next unrelated
> transfer initiated by userspace will then complete immediately without
> waiting for the interrupt or writing to the RX buffer.
>
> Fix it by resetting the counter before the transfer so that lingering
> values are cleared. This is done after clearing the FIFOs and the
> status register but before the transfer is initiated, so no interrupts
> should be received at this point resulting in other race conditions.
>
> Fixes: 4f5ee75ea171 ("spi: spi-fsl-dspi: Replace interruptible wait queue with a simple completion")
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  drivers/spi/spi-fsl-dspi.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index 04c88d090c4d..744dfc561db2 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -1122,11 +1122,19 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
>  		if (dspi->devtype_data->trans_mode == DSPI_DMA_MODE) {
>  			status = dspi_dma_xfer(dspi);
>  		} else {
> +			/*
> +			 * Reset completion counter to clear any extra
> +			 * complete()s from spurious interrupts that may have
> +			 * happened after the last message's completion but
> +			 * before the module was fully in stop mode.
> +			 */

I think you change is correct. reinit_completion() should be called before
dspi_fifo_write().

comments is quite confused. how about below comments?

/*
 * Reinitialize the completion before transferring data to avoid the case where
 * it might remain in the done state due to a spurious interrupt from a previous
 * transfer. This could falsely signal that the current transfer has completed.
 */

Frank
> +			if (dspi->irq)
> +				reinit_completion(&dspi->xfer_done);
> +
>  			dspi_fifo_write(dspi);
>
>  			if (dspi->irq) {
>  				wait_for_completion(&dspi->xfer_done);
> -				reinit_completion(&dspi->xfer_done);
>  			} else {
>  				do {
>  					status = dspi_poll(dspi);
>
> --
> 2.34.1
>

