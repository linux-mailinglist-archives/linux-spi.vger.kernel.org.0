Return-Path: <linux-spi+bounces-8742-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C22CAE6C6A
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jun 2025 18:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 708C94A237C
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jun 2025 16:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2512E175E;
	Tue, 24 Jun 2025 16:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EjfuGLSJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011032.outbound.protection.outlook.com [40.107.130.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBBF2E2EEE;
	Tue, 24 Jun 2025 16:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750782605; cv=fail; b=tckM7QjnI77I5UbHV1N8CTKdCWVGSC9aEgZrgbFNo2pODFV3wZSOG2Jpb6tirdRXGmScVRXLjS8fbNCWshk+Yt20F6QAVvnaEXHnu7BToo//ERQQeEUZhhVRmfGmBIqA8doo/Bm+sJ5XO6O5bg0JqXWjiGo2NZwaqJzec1FX+b8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750782605; c=relaxed/simple;
	bh=FsbOPS1W9x8964Zh0lcl+IIHXBLY6wj/uRSHyk9ht8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gj5sI+n0HpXJ0ViGU2TVtfRnTcfDeIibD8KOwgkzjrn71NZw7G5zQWM4SJJJDj53rTR7kJyCFJEirTc1aFE0sO/HungfCDGagP0YDyUbjFFfHf4c/+RSsZqUaeQN5YBaPnc6LUbG9APSrvH85iAL3PDdmHgAumYgH44B6rI9Ej8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EjfuGLSJ; arc=fail smtp.client-ip=40.107.130.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XK/yNLhtooA5W5Agtqq0TCYIq2NfZhfvxTzvYvxVL1IH5NrlWDgu5NvSeuto90roowgs3QdLqonUB84ybCtevfv0DLLp8aY5DywACDZZDuRIkc0ZcRPQbTgklsE9yreeLF2RSEzuqhITH5jhITW4Ttru+6O5tl1iF/xlqTGBIZoYCrOjmVJQNmvb7w42RpPoDzCgTEz825swVRQ03teh0bY1hzFyYioWBdEsYvbruat1ZlxN/AYaKwIwfbp/KQuDQ9OF/1Z0sxgphflu7MuuGkJeQaE0abpS0jqmVeKSFZFEiDKClv0QxjmAxGvqpUbrV1Iiqukc2iIm04Jm4r5WVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZf1DB8pwk75R78BOeHGrz6heW5G3F7G3+J8Mh0DKRQ=;
 b=PrxvaVSuP8m1vX7fOx9+Zg+VxW+gWLaKSDoU4w/QLuF2e4Ack07QHATdW8ZYmd5ylvAxFIKCeA6APqNEnZe+84EOiI4Sg7fDlwMyNbtymR1NdU2zKr6rLUiMV+aSRv5Ja799jfxsOnDH+G6OGg7QOclEMf7NmHDUUbVZGIwoWHMCB4gTG2rNOGrKr6hHgzyz2jYKj7+9VENQQP6lm6VnscCDojexfOm7eLozLSNq+nDCimapJYKlXmN51/RIlB1yWvmxzRv+g16pEk3wtaA+L8D/GoTVn8sfFeZzDlaWfL6W0vAGjpa6wC+Q4Oq5PGXpBtUoDKpUWvvL2NKcWlXfng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZf1DB8pwk75R78BOeHGrz6heW5G3F7G3+J8Mh0DKRQ=;
 b=EjfuGLSJW2cy5ahVFAeLi9k2RRluK+zOicXKQPyig/n+A7KPgDcIE+DwY+OJc7/O4H1NkU8/S1NwdhlgTn6Y+kbdCpHWKfH0piDmVxPGy/eik/3kAwSuxip2pZbsFET2wzm+ZzTd7+bmgItCXBu9jWbDE9o36GxKLOQGaCxCSzy/vDPPXd0rwRRf205RoXy6LP1TrgxV6JyCoSD0XadE13NMRYO2PyMwc/y1YjzLKOrqu3zcVcpUGbKWejbVtW+JF7YL7gMrBd2HuewMAL1OUsTkgoghkfQb+aax4YDY4qNfEMWmrVDl3GgO7q8l+kqPJhC7VnB1lP32y5hh5H6NOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9591.eurprd04.prod.outlook.com (2603:10a6:102:270::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 16:29:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8880.015; Tue, 24 Jun 2025
 16:29:59 +0000
Date: Tue, 24 Jun 2025 12:29:52 -0400
From: Frank Li <Frank.li@nxp.com>
To: James Clark <james.clark@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Christoph Hellwig <hch@lst.de>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] spi: spi-fsl-dspi: Stub out DMA functions
Message-ID: <aFrSgJ5xZfccEX9x@lizhi-Precision-Tower-5810>
References: <20250624-james-nxp-spi-dma-v3-0-e7d574f5f62c@linaro.org>
 <20250624-james-nxp-spi-dma-v3-3-e7d574f5f62c@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624-james-nxp-spi-dma-v3-3-e7d574f5f62c@linaro.org>
X-ClientProxiedBy: PH7PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:510:174::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB9591:EE_
X-MS-Office365-Filtering-Correlation-Id: 283fb7bc-d82d-4be0-be0d-08ddb33c5cc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1F0LrEwZFYg9ntwZcYPa/Cjf1+U+0AhC7oml8bU18tCuFgwS/tLiijbfWj+Y?=
 =?us-ascii?Q?QcmiRSt5fj50NYfREDq/0djPXWTRsPXmrXm54h3TE4NS/KZB3EGeLrtkt6Pj?=
 =?us-ascii?Q?a4dsupW9O4BZL6cSt5k0vrfDEUtSzxRkw5P1GL2qxaZyCE0y9AJi7t/q74q8?=
 =?us-ascii?Q?W4EjklKOtMc05a9eQST2Cx91cAlnoJn8YfnP1L1U9074rLOslMticiFXpeQR?=
 =?us-ascii?Q?KuEQlLbEoCk29xq4w4JMvUagKVoA+1tre55VpExca1IrTTnKUzh/7X3BSeZe?=
 =?us-ascii?Q?tR7IsB1ytwjdBeSoYru44X1QV2Zo25ScFlKoolZuGcX/eehy2MTt3Ys8vNLj?=
 =?us-ascii?Q?h+0YC1JnRV3QLGxCQYDojF53dTnrul/SX3DBHwobvc0gp5sddaCCRLcr/AB3?=
 =?us-ascii?Q?j40YMwVHSJHg+IURJ+/iB8MCQW/h3WC7UOh0ZlnnWcpCY6Ujjr8XxEw8aCDq?=
 =?us-ascii?Q?RvWxZqo4U8xJYddNbiS9UolbU8PJ3mhv2shPwngB/zOrlLkUHcf+J49Ff32x?=
 =?us-ascii?Q?m7lj2w4diEZ/XxPaHYMLDyLDCqe7qkx19wPYH3uEejJoPFn+nI60d7vlzbKs?=
 =?us-ascii?Q?UJ7m9eFaYWdjW1DD/nlTHIa9E2/4jGPhFsUp+2dh1HKN+DejKyn0BblrKZZI?=
 =?us-ascii?Q?CugN43LaKKNih5mbaQFGOAztjjBj/Khm4Hb9aKDVefdRgpMa6MsCiRvAqi8E?=
 =?us-ascii?Q?Ly+/cFkIekq3/67FBAfxJkzaeSwiwkmAKBMnUNmZ/HIX3WQR2r2nrePlAS7y?=
 =?us-ascii?Q?dckngpMmBeDO8aVe70XDCCW7FsbqbuPbt/SnUpG7VZ0EirSOeg8yKyK8QNPd?=
 =?us-ascii?Q?klB4WrRASGUWHsuTYxKuWTqN09IEIjAAHaofJDQOkrrHaXGE/Xkg4fW4JyZD?=
 =?us-ascii?Q?WjVUYqgcJcH9xGn3vp3Q3MBYUVJxWU7GV3wIx+g0vjCp2sW/fyj1SKsS+25n?=
 =?us-ascii?Q?AGLp5uDZiFBpuoDxMaCAZ9RMwJAUQq8EcnnLrFREFbz9jAF0+6UtgH5Exgct?=
 =?us-ascii?Q?G0OdUdsu1I+tpyFdpDPeFNAu9pzxMTylgjAZka+C2x3DCt3+uNuNRw+/9dqf?=
 =?us-ascii?Q?ZW5VMqEcKx71JAyj1Bnmh1Skq1b1AAMXk9vPxoW+YvlUTa1QnM/jZ/UJ6152?=
 =?us-ascii?Q?OgzZnuoZWOnIM8k7Yhjh76ZyqlBGf3zAM5N8pua+We3jXgHsWRH92KZ1sZot?=
 =?us-ascii?Q?tWeTg+dyHj7+JE+zwoIgVsgbWzNloV6cXfx3TvuCwvWA5qg3h/zAWC2EeRXd?=
 =?us-ascii?Q?Ow6zBCOhjkDcefnTFbd+rJ6JtV//6JpnfaB5YQOOUv7phr3+cDHFoJ854Ho+?=
 =?us-ascii?Q?Ub0QL2KOuUp/cJ0Ab+Z7DWguy/YgSVRchNAyxYeYpWq0nUU9jfLSW0c4xuBL?=
 =?us-ascii?Q?5+IAhxXc8UNepBRadXeuS8wmiC30y8kylP3zYbeTdnzoYelw7bBga+d9D1vT?=
 =?us-ascii?Q?lmHOlRI73Rxt2zAyqs719aalAnRGB207ZzBSsrK3fQgThgX9Da5kTg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i9hALz/OjoZgsT/kW2dGmhoZScFD2TIM7SDDRnw86MEXAzIsP7EoqA8AxDT/?=
 =?us-ascii?Q?ZEhh+ifuDunY9piYx7ij1vPPS4N0+CyKrCs1SrA+p8I4uFGY95hb4vaFCQUf?=
 =?us-ascii?Q?PIGiKQV8A9x7fgxwc6Ke4YJGevCFDYgZ8uBQZqAj9taLDN29GMfe+21csMwb?=
 =?us-ascii?Q?x0wgA+E2FdLeFFPX/6vIeSH7vsSdFO3wgL8N+ShalVqG7soYa20rxvNzGu7B?=
 =?us-ascii?Q?RdH77WitR1Bg6ZM1cG+laK7b8AYf1UsNXo64AnnJXzIscYS3wgIe8kpttAqQ?=
 =?us-ascii?Q?Cb2ZuH6x2qNcw23uB6Ojb7/tGj209UXSLevS/0BVgnX25OrhCIfSmXGXcaIf?=
 =?us-ascii?Q?q5tyhwIfYL+5BVKyXwI7fFAelUOp5otMykppjJ2Y16r8lfOL0za4jZdN7FrB?=
 =?us-ascii?Q?e9yG+VYov+VZWBL5nBdWkPauhiAbzxNZMeJFkD4be0LJJd1Wrvb0NpbdHCvJ?=
 =?us-ascii?Q?yoh3guUTQErnlwQt9N4ESMfY7doGEfZD2pDj4WBl5RcbYRA9nvsYkJK3aDGQ?=
 =?us-ascii?Q?9ZM8stZbe/dqtAtt275OObmXopMTB1T13lapgtji8kT+XmvLZtRy3GPEBW/G?=
 =?us-ascii?Q?nT8G3s2wW0fFSkz0bV0KiEIEtAydL0VaVnyVSLe7W5Hz4qNb+iZTjqBzSX3a?=
 =?us-ascii?Q?uUyOSpDjP/oEPC3oYJG6k71qo+T/vLgSYfCPYD3jU2tTf5kHv1wWESBcgmuo?=
 =?us-ascii?Q?LfOJEirzsDjVA28hM3D95ZuBfFz+68ne2N8b6RQ195p6jbYA/CruWzNIqPJy?=
 =?us-ascii?Q?P4GlOzOVkIb4iGFBEdRA0WMviG1QXKA4K6zl+KG9Bvb1MQuBuDhpI6/6Xmf7?=
 =?us-ascii?Q?1VQ+D6kVgilNXBGfv9N7dm3PusNdCTV5snMR6hzSsdcJWqEJhNx26JNd4Boy?=
 =?us-ascii?Q?Mkiapokx+juhB7l6vnXRD1fA+2EaYkY6EHvfEPtpDBVuW8I4TVBrOmPuGwVy?=
 =?us-ascii?Q?ReoHEvvL9HJDLD+ouw84HnIDQLSs03c9F7/F6YS0/geifqin+Wau33FDmigk?=
 =?us-ascii?Q?qImveQvEK8tn3D7GLD8qbR8TPvla7c+WI1rFyDKHZCeccbPXu4jaRRCcbvX0?=
 =?us-ascii?Q?X1PR9PSPlStuKqvGnckGLiZUpQCm5k12C7hhZ10HrLV5cNXMAzmwc4hZGDjW?=
 =?us-ascii?Q?K+v3BMKz7BUK6XgEeJ3u+U+MVnzQ5NnCMBoDCF+zp9gRjtZ71SVHq12OfCXn?=
 =?us-ascii?Q?llKJpJjjWrfU2U+hvoqWP7LxM2oROygzfEbjzSlSqYrtz0kxAVz1r3jydAIN?=
 =?us-ascii?Q?wnxJOUHiK2kpozzf44222FykY7GGtHMjvU4mEsofTaapUG4vIr6cChfoYj+i?=
 =?us-ascii?Q?OI4665ftVq7oQEu23rxrpIm6H5JpRVBit5Mq3vsZ2UDndw0gouSTxUFgfmyZ?=
 =?us-ascii?Q?Uii+ZiP4OkIRS8mFkmwFI/bQkjqhEXU7G6Ntp/60q9jCjWdYwqPx2Pv3fWYd?=
 =?us-ascii?Q?WPxYgKKVQ0Ma2ytK7BFovArMiudZznwkB9WpABv5XY0/WbyPG36EfuOaZX1W?=
 =?us-ascii?Q?lWhWe2tO//2xvJVfyavwZ5qVfwKrdUwMl6jHL6ZxxNWEUNwxne1Nb9LQCCji?=
 =?us-ascii?Q?HIIItz1QuaF0RcN7npED4vgYUIwH91ZAqqkXfpXc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 283fb7bc-d82d-4be0-be0d-08ddb33c5cc7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 16:29:59.4307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iH+1T5JG27ueOA+dvw+QktMlLnHlcCWJO6dCLjOZYu0c7XBI7u6QwF61Uz6nqm1zVOFosYrTnTd1YMZ1IbWrRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9591

On Tue, Jun 24, 2025 at 11:35:33AM +0100, James Clark wrote:
> This will allow the build to succeed with !CONFIG_HAS_DMA, either due to
> a randconfig build test or when the target only uses one of the non-DMA

I supposed you met kbuild error. If yes, can you add kbuild build report
tags.

Frank
> transfer modes which this driver supports.
>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  drivers/spi/spi-fsl-dspi.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index feb29bb92a77..8212c4193536 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -373,6 +373,8 @@ struct fsl_dspi {
>  	void (*dev_to_host)(struct fsl_dspi *dspi, u32 rxdata);
>  };
>
> +static void dspi_setup_accel(struct fsl_dspi *dspi);
> +
>  static bool is_s32g_dspi(struct fsl_dspi *data)
>  {
>  	return data->devtype_data == &devtype_data[S32G] ||
> @@ -489,6 +491,7 @@ static void dspi_push_rx(struct fsl_dspi *dspi, u32 rxdata)
>  	dspi->dev_to_host(dspi, rxdata);
>  }
>
> +#if IS_ENABLED(CONFIG_HAS_DMA)
>  static void dspi_tx_dma_callback(void *arg)
>  {
>  	struct fsl_dspi *dspi = arg;
> @@ -589,8 +592,6 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
>  	return 0;
>  }
>
> -static void dspi_setup_accel(struct fsl_dspi *dspi);
> -
>  static void dspi_dma_xfer(struct fsl_dspi *dspi)
>  {
>  	struct spi_message *message = dspi->cur_msg;
> @@ -722,6 +723,18 @@ static void dspi_release_dma(struct fsl_dspi *dspi)
>  		dma_release_channel(dma->chan_rx);
>  	}
>  }
> +#else
> +static void dspi_dma_xfer(struct fsl_dspi *dspi)
> +{
> +	sdpi->cur_msg->status = -EINVAL;
> +}
> +static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
> +{
> +	dev_err(&dspi->pdev->dev, "DMA support not enabled in kernel\n");
> +	return -EINVAL;
> +}
> +static void dspi_release_dma(struct fsl_dspi *dspi) {}
> +#endif
>
>  static void hz_to_spi_baud(char *pbr, char *br, int speed_hz,
>  			   unsigned long clkrate, bool mtf_enabled)
>
> --
> 2.34.1
>

