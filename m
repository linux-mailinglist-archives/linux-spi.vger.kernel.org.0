Return-Path: <linux-spi+bounces-5696-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 335929C776F
	for <lists+linux-spi@lfdr.de>; Wed, 13 Nov 2024 16:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7CC7283FD9
	for <lists+linux-spi@lfdr.de>; Wed, 13 Nov 2024 15:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1088D1DF73C;
	Wed, 13 Nov 2024 15:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WYs9gJcp"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2066.outbound.protection.outlook.com [40.107.104.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED1286AE3;
	Wed, 13 Nov 2024 15:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731512123; cv=fail; b=QNpl4BBA8JZlRJSIDUHjKiEss8kKFzdEC/KoI15zacqWJrlBtWDctIUdfBvQIu8uFx/BZKtP5nI0yM0uqR9TvIqS6iex5+2L3gdlowudHnqyUFwj5+h8IUOBku7/lWDLHijDHeFntVPgPijUwA7QKbYe+88RoQhXcdKYkdjQdvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731512123; c=relaxed/simple;
	bh=g9a9N05MAuUXKrbYzqalqWT4KzJB3nRR1mTcVlqGz2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RflnDNQBSI4K5DIjIfXXSROanA42ZZvqDFZnUxMGp3P2HPJWL2Rib6JpOo5zf0qISGmgsp+62BmbLGkX5pbv24/agK8vhVyBkHT++1kOPSQreLv/qCZN6v6JZS5Mab76Z7tupSHP7s2diraMWmGYGbhB/RGRxsC/6Rb+bsTDWkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WYs9gJcp; arc=fail smtp.client-ip=40.107.104.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HOJCHTRQh8IWH/7HnSP1IaJXL5cJRkenscAAap6aSczAFQsZsBkyMR5iomTOmvrJ64t9ybsi5zyirdtGgMIAi41vrh+EmjeeQ8w2ljHuiSaggryv8IF7DJ1gj6ix0WvR8kUrwhU/Da6Fo7ZVGtRK9s0CWfJhHO7b0gXToivilG24FM0fOYl7NpCFZSBi/AiLtDzww5hu8Eakub1g/FYApg6ADjNp//l/XxrCcrArUUh7+CO76yTk8dMPmV0WSF+5daNkklRKG/0f9TPyHNcsDRzAvthEOmOt1OG03T97gfs+H4VKaNRpPQw20gTS9xAtjw6E9WQwM/lg1Dpn7pzUyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfqS5qIACFOeF5fo3/eLzevJDcg8oi726jFGfWAARbs=;
 b=AbqX5iHRbYB+pIF/forBw1S3482t53bRAZEfrIkAnMLaUP5jiDmJiIs49II6jmMQj6egmmyU2Ck6DkkNCc7mzRm9pnx2u37QZl+2+eHN4ianELwTaZal8vx861VffeuomLK1fCx2HKfmR/7/bYpMKta+29t+BhjZl4dhcASea8V3A+D//mkRyskf/0k4EbJxidbHOrEk7Nq0zUG5di8DGRwJPZnwRpswwy/7R+4dnEKUDMWs/ZvYa2M0Y4VDs62uSUPvCKkaOqJu1rPBvzvANJ6sbCgmYYYnhb4cwTzIWGaxy/6UySgKvpIuoK8YzGgbhC9m+xzzxXhTlauQCMm3KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfqS5qIACFOeF5fo3/eLzevJDcg8oi726jFGfWAARbs=;
 b=WYs9gJcpTiTGPrwUvuYDB8cJwqd4JM1C14iQ18EwGevjyJk2cLHogUZJoMOEnAhfoWnIoBPvcYC4V/OTto/i4Q1Nt+UEaw5pMYUs0JKwJTA9OzTue3RmU6BAks0/tEA6UZwSTQRSsoZJVNFkCT5D7TreUwfUcqegfk+grqm9wESjXRbINXXCi8oGpRaOoqQUaKeH7phzPlcjiGNBC1FVQMsNcclb86crFzgwWFbzhMMHlCz4V0l+CHi9tptclzipZM8lufCBjDHxGiwqPs/RSOgMdfDf6PTWDgVfxhMIL6owuETYJBdaWfbKNw9ig+X93VIjX3mCFt6AhcZuJdadyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by VE1PR04MB7294.eurprd04.prod.outlook.com (2603:10a6:800:1a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 15:35:18 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%3]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 15:35:18 +0000
Date: Wed, 13 Nov 2024 10:35:09 -0500
From: Frank Li <Frank.li@nxp.com>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, kernel@pengutronix.de,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] spi: imx: support word delay
Message-ID: <ZzTHLec7Ua0a+VxG@lizhi-Precision-Tower-5810>
References: <20241113-imx-spi-word-delay-v2-0-2b65b737bf29@pengutronix.de>
 <20241113-imx-spi-word-delay-v2-2-2b65b737bf29@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113-imx-spi-word-delay-v2-2-2b65b737bf29@pengutronix.de>
X-ClientProxiedBy: BY5PR16CA0030.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::43) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|VE1PR04MB7294:EE_
X-MS-Office365-Filtering-Correlation-Id: 48f4d0b3-5d53-4a69-55cd-08dd03f8c6f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bNWCgTWtWVapAmfb0q6ne8JBMcVsfO+KpPKxJnVlHYjCZPnNpFK90r+C82Ja?=
 =?us-ascii?Q?VQ+0kT1fM8ix2JCIg8mINx+AVcDy+RQgMwdRFl+QozKrSQy6psgQft3gTVSu?=
 =?us-ascii?Q?ewSA3OAFO7ivuXoiOJx32fxIE/fyok3Q303SovxaZDaZ0bDuHgGdXPbwa1kq?=
 =?us-ascii?Q?qsT0430DX/E+U48BzO3wMZA8ikHIq9pfHJbld0gMUGu8AV5LhRX5GXBhnuw9?=
 =?us-ascii?Q?JVYwcOk3RdCDaKfuxM1V3J60uEoj2wCL0/116WY6scAb1cYyzTT8PWheO33N?=
 =?us-ascii?Q?gi6uBDWnVN0V2uozcYXw64FgPa3oQwAFKk6aC2nUMYohogJX9DZL7tNdzbZi?=
 =?us-ascii?Q?6yyJ0btUMl6KwXEupdM+oHov6GrWEzFDzcDdonCtaYRBVeUwJa+4Rb2KriKd?=
 =?us-ascii?Q?m0aYqdUagPlERxKkX+y9BA9f4ocyN0DFCeQd8a7Bx8dyYuwLEfwLCXCedE8/?=
 =?us-ascii?Q?xkPmqsQb1ko4try7SxEh6PdTEJfJvL+NTpAJBJ6SyDJYX0j2T185fL2m9CIJ?=
 =?us-ascii?Q?KgbIPq9dFBONqRnFnifg2w4aGfcrR7fQsM36A8F+GPLjWDZGtYeZwM2H7Ocs?=
 =?us-ascii?Q?KgDO3bq32vJVxBy8trUK6z4BehCVKlmV+jFYQE3XRsTkOnV9BtwQauioiRxr?=
 =?us-ascii?Q?1L5xwEyrgEupUlXkH4rIIjgk2AQSVBtl9lwnkesRg3jG1ghGuQV5mYHBaogH?=
 =?us-ascii?Q?Dbo95dmIeaO1kjtkaqlCpyVluCNIilfNmMdkbksWzi34RnAzwrl+JesJw0lg?=
 =?us-ascii?Q?7QSGqjEozh7tKmWidTkJx6duHwvrpuBW1NxxISF3sEW4AlyGRE3X5+Ne2vA8?=
 =?us-ascii?Q?t8766L/WIzEyZlv4zKzz5PjRfowVRwZ8amFm9FFovyouJ9C/BgudYOveYgir?=
 =?us-ascii?Q?GRtZOjD1KGMt/vk4eL3QYPowDyLGhxcqLb/3hmknatr9V1kpUNnH/UPvWNJV?=
 =?us-ascii?Q?/QfG8An8E/K5EVI09tvrbK24zsNPXKQ+cP7V3Y+NOdQHQzD/J8CG/hEkvgjN?=
 =?us-ascii?Q?24bWlhtnzCU9HAvYN6xDZEwdyfuTe49FO+mjAB2cywpAjEfpdxbwQVQn4L/k?=
 =?us-ascii?Q?ioN/BD39bjSLWIxwm1o5E12qHhkDOkS/jT+gt7iZWje2EPWjx+uURO9PvTRt?=
 =?us-ascii?Q?in9mVefwR5ukxlqUxhkToaz+PzBjjlkCD1y6SyOOemdrKpKUSkJ0c8FdPWEF?=
 =?us-ascii?Q?l/yfRSR3is8xHXqdyVXxKacw8MPkFWVwRMGLN10ECe70Q2BBylMlpUAROE3Z?=
 =?us-ascii?Q?V35rUH0wG3hYDCciZhzmjq3jV+uAwvGMiANyi+vMwAHvOsJPPPPix8iAJpna?=
 =?us-ascii?Q?gkkbJs0YrzlGjz4pKzHnSjW9HP5UNpCfjspswjMyp52yerJVVBShxeLtDC3A?=
 =?us-ascii?Q?52Sjp+w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cxL12WmkFQ/S0SSZybW2RiRUEn0fon+03y7VgA3jdXsLXyv4hjyFSGFsKKiF?=
 =?us-ascii?Q?8bNZU7ghAgtURmH0xh/+Cwy9wBVJdIVje8e17C/ouO3+x3F3hs14YgS9l4/E?=
 =?us-ascii?Q?IJn89Bg+n1PofGfbAFf7F5PZ7cdYVVqso6PaKQ3VzqmtfqqUvrJgRgIwoyZb?=
 =?us-ascii?Q?PkTlsyaxdeVujxOIoKbWl+RbByIrCCh4YV0mk1LB2+4ZDicPsTWFzk8JLdHR?=
 =?us-ascii?Q?e/mVaB/r2XNmEXvkDyuTw2Agj9B+R8OkeSdVDgRqPz3RQCqypqgztf+ik+Jb?=
 =?us-ascii?Q?XwG08eWw/DgnGXF9Cq1tQ9yDjkjageJ7c4D2/aQ1fAff3zeaT+PUIGvbtaHP?=
 =?us-ascii?Q?5FneoX7VZCqAmUVm8Pd+g/8Kudnz/pNg+g4vpDE3z7+sjUcLTQ5CnKM3WkwR?=
 =?us-ascii?Q?DY08HuVn3TXiM862O2mZHMBVBoEFyIEsk38E1DNOT/ns9ZnnNgT1O/DlAaVR?=
 =?us-ascii?Q?Zu3PkSMMVSrEX69Z2Flh4OGyaDHbzoBkmLqXY38/+mbe7PoGuyq90u9YCgLW?=
 =?us-ascii?Q?QrIv66EmVuid6yfXat+FaT8BVMsoXL64wb2l/I+biIc6a2j+xSDvEjoOeOtw?=
 =?us-ascii?Q?/fQZGzp57C9YtcZxRFgFM6hVkWa0K+V/PRbA9TjtfmP7D8mwKm/Q9qiRgO5/?=
 =?us-ascii?Q?AjjHf6JqxKYjvmZJ+b7R6KgT/S1Np0bTCPPB8mefEC5GdGw9aqBiyjh9lrCM?=
 =?us-ascii?Q?If2/LKEHSX6SIW5xFEFGkBcsWBeSgdLvmVPZ6vj7c9H3bbrm1Ek5+V2wf34i?=
 =?us-ascii?Q?Z2a4wMwPSE/e+AvsYGmclb+2uSSrPDQj2mnXG20rLz8r3F96boYRhOIImygU?=
 =?us-ascii?Q?2aDGxKfS6R+yyw/UDONcUbl1OqLbMoVn+/Mgfb4eZOt264ow1ciLASqrjrRu?=
 =?us-ascii?Q?FvM3at8pH13uE0jV4QPTPGqlRq70I9pcZOwWG3VysYRIYbYtdZnfmL5Ugvfh?=
 =?us-ascii?Q?fqUCfEkiDfLxlBqRgGRPAlYHQ6URf1tGTrvp8uRWSdByD2V/FQUFpFciq8Rm?=
 =?us-ascii?Q?H2vVVdYzlov+apBVJZYWRButwveX/SJmCo9mKmzntBIQZDWBiKucKt1rW820?=
 =?us-ascii?Q?3VhR0TEP/b7NevnfusXFKJbzBBb7vxw96nM6fRNwFS7jK0+Zp/SHODC18yeO?=
 =?us-ascii?Q?To0cSL9hKH0Ca6tUiCvbzE045+eh+eMCW8gG/SpPvynqBCCI4JSvbvJnSdGX?=
 =?us-ascii?Q?2W+LwqjszoAL4zicdwbOnsA+nsi1x+G5LKTiE3vREDnaoyN7c1FMZmtV68yI?=
 =?us-ascii?Q?vV5Lc+OZEWdAOE4mQrhNwFZGrZnQqvXhaeDpo1OmqpsKVrkdmKcWHNX3O0q3?=
 =?us-ascii?Q?cArQxw/mC3ttDZnQJBNovZsNcyWBEpQTlTV6zLLWgP4n1AfKsKqT6JZ33Kwn?=
 =?us-ascii?Q?MncqVgeqjfLGguJTGjUj6ne83l9VZ47i9Da3Pr+JYJ+XNacAituwzW3sz3mT?=
 =?us-ascii?Q?mXVARCbLPaSf9XoIToRks/R8tmWFN899SrKQdbsRa36lFXknrhd6LgpgSLWo?=
 =?us-ascii?Q?x0MAr3MJCghKKbUGhkjVoSPZ8lmNlUrbljJGzLi6ox8xaX6XNo+Up5U+iKgS?=
 =?us-ascii?Q?hGPp9a0UT26Nnh3kAkz19VaNsJPQq0uIvOUc+huR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f4d0b3-5d53-4a69-55cd-08dd03f8c6f4
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 15:35:18.2993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LllK6ogQvAvw5O1J36n8Bs1t2S7WMXhF6IeqnxnuPj5iXdbRoFzqbPjqveS091FI7xqJkTKBr5A9xfH3F2HLYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7294

On Wed, Nov 13, 2024 at 01:18:32PM +0100, Jonas Rebmann wrote:
> Implement support for the word delay feature of i.MX51 (and onwards) via
> the ECSPI interface.
>
> Convert the requested delay to SPI cycles and account for an extra
> inter-word delay inserted by the controller in addition to the requested
> number of cycles, which was observed when testing this patch.
>
> Disable dynamic burst when word delay is set. As the configurable delay
> period in the controller is inserted after bursts, the burst length must
> equal the word length.
>
> Account for word delay in the transfer time estimation for
> polling_limit_us.
>
> Signed-off-by: Jonas Rebmann <jre@pengutronix.de>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/spi/spi-imx.c | 95 +++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 85 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 65a8303b80b1191cd2c19d61f88836e7fd3c7ae9..29b83659b8036d1cffe076012ad5cb229509abd8 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -3,6 +3,7 @@
>  // Copyright (C) 2008 Juergen Beisert
>
>  #include <linux/bits.h>
> +#include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/completion.h>
>  #include <linux/delay.h>
> @@ -13,7 +14,10 @@
>  #include <linux/io.h>
>  #include <linux/irq.h>
>  #include <linux/kernel.h>
> +#include <linux/math.h>
> +#include <linux/math64.h>
>  #include <linux/module.h>
> +#include <linux/overflow.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> @@ -302,6 +306,18 @@ static bool spi_imx_can_dma(struct spi_controller *controller, struct spi_device
>  #define MX51_ECSPI_STAT		0x18
>  #define MX51_ECSPI_STAT_RR		(1 <<  3)
>
> +#define MX51_ECSPI_PERIOD	0x1c
> +#define MX51_ECSPI_PERIOD_MASK		0x7fff
> +/*
> + * As measured on the i.MX6, the SPI host controller inserts a 4 SPI-Clock
> + * (SCLK) delay after each burst if the PERIOD reg is 0x0. This value will be
> + * called MX51_ECSPI_PERIOD_MIN_DELAY_SCK.
> + *
> + * If the PERIOD register is != 0, the controller inserts a delay of
> + * MX51_ECSPI_PERIOD_MIN_DELAY_SCK + register value + 1 SCLK after each burst.
> + */
> +#define MX51_ECSPI_PERIOD_MIN_DELAY_SCK 4
> +
>  #define MX51_ECSPI_TESTREG	0x20
>  #define MX51_ECSPI_TESTREG_LBC	BIT(31)
>
> @@ -653,6 +669,7 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
>  				       struct spi_device *spi, struct spi_transfer *t)
>  {
>  	u32 ctrl = readl(spi_imx->base + MX51_ECSPI_CTRL);
> +	u64 word_delay_sck;
>  	u32 clk;
>
>  	/* Clear BL field and set the right value */
> @@ -684,6 +701,49 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
>
>  	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
>
> +	/* calculate word delay in SPI Clock (SCLK) cycles */
> +	if (t->word_delay.value == 0) {
> +		word_delay_sck = 0;
> +	} else if (t->word_delay.unit == SPI_DELAY_UNIT_SCK) {
> +		word_delay_sck = t->word_delay.value;
> +
> +		if (word_delay_sck <= MX51_ECSPI_PERIOD_MIN_DELAY_SCK)
> +			word_delay_sck = 0;
> +		else if (word_delay_sck <= MX51_ECSPI_PERIOD_MIN_DELAY_SCK + 1)
> +			word_delay_sck = 1;
> +		else
> +			word_delay_sck -= MX51_ECSPI_PERIOD_MIN_DELAY_SCK + 1;
> +	} else {
> +		int word_delay_ns;
> +
> +		word_delay_ns = spi_delay_to_ns(&t->word_delay, t);
> +		if (word_delay_ns < 0)
> +			return word_delay_ns;
> +
> +		if (word_delay_ns <= mul_u64_u32_div(NSEC_PER_SEC,
> +						     MX51_ECSPI_PERIOD_MIN_DELAY_SCK,
> +						     spi_imx->spi_bus_clk)) {
> +			word_delay_sck = 0;
> +		} else if (word_delay_ns <= mul_u64_u32_div(NSEC_PER_SEC,
> +							    MX51_ECSPI_PERIOD_MIN_DELAY_SCK + 1,
> +							    spi_imx->spi_bus_clk)) {
> +			word_delay_sck = 1;
> +		} else {
> +			word_delay_ns -= mul_u64_u32_div(NSEC_PER_SEC,
> +							 MX51_ECSPI_PERIOD_MIN_DELAY_SCK + 1,
> +							 spi_imx->spi_bus_clk);
> +
> +			word_delay_sck = DIV_U64_ROUND_UP((u64)word_delay_ns * spi_imx->spi_bus_clk,
> +							  NSEC_PER_SEC);
> +		}
> +	}
> +
> +	if (!FIELD_FIT(MX51_ECSPI_PERIOD_MASK, word_delay_sck))
> +		return -EINVAL;
> +
> +	writel(FIELD_PREP(MX51_ECSPI_PERIOD_MASK, word_delay_sck),
> +	       spi_imx->base + MX51_ECSPI_PERIOD);
> +
>  	return 0;
>  }
>
> @@ -1264,11 +1324,13 @@ static int spi_imx_setupxfer(struct spi_device *spi,
>
>  	/*
>  	 * Initialize the functions for transfer. To transfer non byte-aligned
> -	 * words, we have to use multiple word-size bursts, we can't use
> -	 * dynamic_burst in that case.
> +	 * words, we have to use multiple word-size bursts. To insert word
> +	 * delay, the burst size has to equal the word size. We can't use
> +	 * dynamic_burst in these cases.
>  	 */
>  	if (spi_imx->devtype_data->dynamic_burst && !spi_imx->target_mode &&
>  	    !(spi->mode & SPI_CS_WORD) &&
> +	    !(t->word_delay.value) &&
>  	    (spi_imx->bits_per_word == 8 ||
>  	    spi_imx->bits_per_word == 16 ||
>  	    spi_imx->bits_per_word == 32)) {
> @@ -1611,12 +1673,30 @@ static int spi_imx_pio_transfer_target(struct spi_device *spi,
>  	return ret;
>  }
>
> +static unsigned int spi_imx_transfer_estimate_time_us(struct spi_transfer *transfer)
> +{
> +	u64 result;
> +
> +	result = DIV_U64_ROUND_CLOSEST((u64)USEC_PER_SEC * transfer->len * BITS_PER_BYTE,
> +				       transfer->effective_speed_hz);
> +	if (transfer->word_delay.value) {
> +		unsigned int word_delay_us;
> +		unsigned int words;
> +
> +		words = DIV_ROUND_UP(transfer->len * BITS_PER_BYTE, transfer->bits_per_word);
> +		word_delay_us = DIV_ROUND_CLOSEST(spi_delay_to_ns(&transfer->word_delay, transfer),
> +						  NSEC_PER_USEC);
> +		result += words * word_delay_us;
> +	}
> +
> +	return min(result, U32_MAX);
> +}
> +
>  static int spi_imx_transfer_one(struct spi_controller *controller,
>  				struct spi_device *spi,
>  				struct spi_transfer *transfer)
>  {
>  	struct spi_imx_data *spi_imx = spi_controller_get_devdata(spi->controller);
> -	unsigned long hz_per_byte, byte_limit;
>
>  	spi_imx_setupxfer(spi, transfer);
>  	transfer->effective_speed_hz = spi_imx->spi_bus_clk;
> @@ -1635,15 +1715,10 @@ static int spi_imx_transfer_one(struct spi_controller *controller,
>  	 */
>  	if (spi_imx->usedma)
>  		return spi_imx_dma_transfer(spi_imx, transfer);
> -	/*
> -	 * Calculate the estimated time in us the transfer runs. Find
> -	 * the number of Hz per byte per polling limit.
> -	 */
> -	hz_per_byte = polling_limit_us ? ((8 + 4) * USEC_PER_SEC) / polling_limit_us : 0;
> -	byte_limit = hz_per_byte ? transfer->effective_speed_hz / hz_per_byte : 1;
>
>  	/* run in polling mode for short transfers */
> -	if (transfer->len < byte_limit)
> +	if (transfer->len == 1 || (polling_limit_us &&
> +				   spi_imx_transfer_estimate_time_us(transfer) < polling_limit_us))
>  		return spi_imx_poll_transfer(spi, transfer);
>
>  	return spi_imx_pio_transfer(spi, transfer);
>
> --
> 2.39.5
>

