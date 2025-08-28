Return-Path: <linux-spi+bounces-9755-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B5BB3A9B6
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 20:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23778201C2B
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 18:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26086217654;
	Thu, 28 Aug 2025 18:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EZQv7/OE"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013007.outbound.protection.outlook.com [52.101.72.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4158742AA4;
	Thu, 28 Aug 2025 18:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756404955; cv=fail; b=uasCQVIvfJV7IuJ2gEBB/APOsbspVVUXDatHBJCeNSRt3OcIsRyCJQwhHLYi6BB+gJjJqTfAOY8myi3w0a3u7gdZyddL0+PpaK3GWkUp8lqw4Y8lU9yYU3koyZyKC1aGW1cVqU4XOZMij4+Fagt1nTO8hcKtnZlV4i0msHeBjDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756404955; c=relaxed/simple;
	bh=OGi6eDhAV37LBLhwU1U3zpx9+zU1cZSDjv1ipHEGa9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HqSr7YjuEPcJ/VFlWOw2puGGXF2Q/1dANegPUcj3QJFVdlfz7ZBBdOEZHP8NF0JnKfPTLywcQ4INLMvE0l6x1GeUOceXLFK0b+QtyHrB8YCPsa3Ixtb67nnrjTvKZDoGfVLV5y21JNabcgIgvvll/+AiqMC4CpBeOhOsKQQ0o4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EZQv7/OE; arc=fail smtp.client-ip=52.101.72.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xSbK9kzqxqNevEvbRfFftYjLOxEzl5nxIDxHVklQA8SWQo1jTH1u0oTArBPpUgeDNyLgaGWRAwMIK01Mww6iXCJGeM6UyirrceczuFo8TSHrfRDfA3VA67PJx6CQvYfL9F+VOEKNk6+lsd79ryUdB5qADvwYLUgvuLwId+uD1ZO+2VuTUSiTfEpU1vlsFtTCSLwuUdwv3+mdpH93MV7hTcRemyPpSsWOODbyWy42xIYbWSP+rbacm8xCIeQKrhiLdcXD/8MvDeY2h37vDceeJYXUeTqWgu1EfwpjmmDkTr6DcQWB6HHyaMXjBktnkS5eBdHQ06bSDwppKbV6k3Vd2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FU25NjQtGV6A8t9sLNj98DJgB0pwA+2WHo1mgICq/L4=;
 b=ZdEEThn31NhXSH6KcFRM8ZbOouHiFn8q9y0D99gUIZagz85/Qg3USiizJ97Bwo9PPuWtGJXkY6mSi5EZc8miDk7xOfbYFCZ+n0p3Ni/v6hKsowbehwB9WRwWoTv+nsgvbWvJBVis8MX7Qoyatq6wmDaZ94+y3nevO1VMHen3Ml7Ad3x5OkRQYEiWi3xJo3SjGZrlo6E77m7WY81naCeda5eEq6MYuNjDQF9HWmvp3SDqqM5EQcAuKJDnGXW66nzyCScm2CMdF8KNe68QPHYtph+drlk0TC3/fCT6lnxGIFEXtYL5W/81JJTLmt7/JBT99YcXQ9mi1iEDXReSneghyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FU25NjQtGV6A8t9sLNj98DJgB0pwA+2WHo1mgICq/L4=;
 b=EZQv7/OETQA3TEPs+W+bdvnFe/JcIgL1nFYpZQoBvRqnklmYK1wuBitSKDRIzsFkPoj/9zpq31OfHX4Xe2I+GzMXuN5d4iE8ibBzDjKpkKNNutRIkI+BngNJ3NrSvDlP1Wq0KUza9YKQ7WNXgCe8XiaYoTCB8AidtgDklc3TvtReEsWhkUymWTVejDg8KyvW0PyQZCfvebBPWIXOPCGHUCnaz3SyD+UE6nxkZfzQLzy2EOFbupzwc9FMamvxMrR82rKACdW1fXnAzMdBSeWIC298SCDrUISZXhhduk61GTtJB78lU0gupDu1syZ71Ng4sH//HTMYueimhxPolKkQCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PA2PR04MB10131.eurprd04.prod.outlook.com (2603:10a6:102:403::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Thu, 28 Aug
 2025 18:15:50 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9073.009; Thu, 28 Aug 2025
 18:15:50 +0000
Date: Thu, 28 Aug 2025 14:15:42 -0400
From: Frank Li <Frank.li@nxp.com>
To: James Clark <james.clark@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Clark Wang <xiaoning.wang@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Larisa Grigore <larisa.grigore@oss.nxp.com>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
	Ciprianmarian Costea <ciprianmarian.costea@nxp.com>, s32@nxp.com,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 9/9] spi: spi-fsl-lpspi: Add compatible for S32G
Message-ID: <aLCczhqFzQmxaxPl@lizhi-Precision-Tower-5810>
References: <20250828-james-nxp-lpspi-v2-0-6262b9aa9be4@linaro.org>
 <20250828-james-nxp-lpspi-v2-9-6262b9aa9be4@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828-james-nxp-lpspi-v2-9-6262b9aa9be4@linaro.org>
X-ClientProxiedBy: BYAPR07CA0026.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::39) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PA2PR04MB10131:EE_
X-MS-Office365-Filtering-Correlation-Id: 1de78659-1f21-4471-6def-08dde65eeaff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|7416014|376014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lsZabew6O9WrBUdjEmmy2YoutxVlt9Nwej9+lvGAmLdW8Lsjk1eqzVWoFBMa?=
 =?us-ascii?Q?S5EJXCKynbXN4yBjhXHKodH9JUqVjlBMyYd3/lw4RPOwNrtQw+YiF1XomXju?=
 =?us-ascii?Q?dL48g80DPkaupbCH3crOgwIGXT2OiRvLR6OfOrD0iKUc01TqwUH/Nnqqzmii?=
 =?us-ascii?Q?VJcw+po/cRXgBg3Q/7quekQHEA5bvCEAGCP8ZAENJKeZzYUTlH+QrbZCMucM?=
 =?us-ascii?Q?Ro0M/uql28zlq79ilB1DmfedSUnibDenaC311eDTzBlDU7puNGAnnvI78cV0?=
 =?us-ascii?Q?MVIjJhcvExewz5IZlLfXyJ8bdEZge+dQUH02emiJt2LVNFUamCLkUDOgy66R?=
 =?us-ascii?Q?DOhDTTBPqFfyNeDSjnxi4nHRzAWdhOwzaswpk0n3PmDkrq4f4g5OlTaXmYqf?=
 =?us-ascii?Q?Z1yuOHRwwHpY339XRXNMBr2mAfpIWndnT9beaBIO4Mr8gxPmtSWes0GkxwWt?=
 =?us-ascii?Q?7Y7t9RzFEUZyzHTYS9MoxHBjTtbNrW7e7OaHsm+zqk2SHm1RID1sxRI78/qE?=
 =?us-ascii?Q?cQouPuMyhHzcS9E8PJyqdthAscAq4kwtbR5BjO4ZitnDI7O6d5bqe7Yzqk28?=
 =?us-ascii?Q?A7dELOxpTf1dclMjPJJc7zFOgJ2jNuBZcWTza8Nv89DFnAdMQWIbCsz8sMbd?=
 =?us-ascii?Q?AyCGJQ3XwrDNlS6P/rQmSP4NoWuvAptcZuTArANwpxWMtcgVdcJptSF6Kv2r?=
 =?us-ascii?Q?mqgXLbaSj6zx7Lsdq5xJh8MJAhJ3Ihj9o54pVwQdIat62nN5DQ1YsFbNKbOJ?=
 =?us-ascii?Q?LPcqbx2FrZfJX02DDEfQyl36oWrum+reJI3Xw2ocM97vDj2Vrci7S52zshUo?=
 =?us-ascii?Q?njeX8PBBjHrJobr58r/n5Ke4Gq4fO62NJ+VMP6GsgyiTNhGA6IG6SoNWWEBx?=
 =?us-ascii?Q?FDBA8gFo0Jh5GgePIzm/c7Ytj703QR6VvT5SSYHyqMzv7J+TIgfv6TzdPFQ0?=
 =?us-ascii?Q?9VRo0QrHFZbLl3utwK6BtblxKgYysY/c+tlhXuyHgmxGeT4Va/zC8AiRCyTK?=
 =?us-ascii?Q?50Cd3by6F/e2xxjzJYTK1lqE3cq7UhIHG9lF0cTP2o9z6qb4GhEyqrEERa0i?=
 =?us-ascii?Q?IXn3Xg463b7z3+TUGZ12IVme3MsmMdHvQD18zbufazJLKPvwcDwTcdFM+Vjm?=
 =?us-ascii?Q?sFFOkvYOcTX+k+V3dA8fhkjEPzABtXGhYFvBm6/AaiJSr2OV4tFhzW5meLpo?=
 =?us-ascii?Q?LDcMavPN9XRUCQk0aZLbnVwj/kFv8LEVnkNoURWS0gX3HXOyB9gTWb+GnBhR?=
 =?us-ascii?Q?4djsYx6aW1wSI4fmwe7w2bFEXGCeUgYe8KdgRnBwTxhyxBUzTwEbOuWqvv+q?=
 =?us-ascii?Q?AoO77EnAvMAXbswQCYjj6BiHZdjthpbNHNUC/UCdeRdOn9sa7Jue/0KqJFRk?=
 =?us-ascii?Q?iUWHMdwOFw4vqqcepeSP/lUTVo4D7k23MeKyI4lmHsJEnZm9ZgQ1K/6Zv8ok?=
 =?us-ascii?Q?aYPlGn1EGjO8dPPB/sJvQXtAu6ZvcBO2Qaf9kcsevrq8s/5ZNIs3tQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(7416014)(376014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?APwLVIMLnzdRlXZb69G4efUg/wVpcMEzEitI8V5zw8C2c0OhzvaGWjOUtkOQ?=
 =?us-ascii?Q?njGYg9yvCAegNH75G5s9Eg7vJ4yqi0S47GlxWFyxWfaZBAEPd9Br2UVCPzcY?=
 =?us-ascii?Q?SBZNfHivqKMIC3wKY99PybuHSHkpVaubZ6OMGPKPQgtSK39cU3CdYEoFVCAk?=
 =?us-ascii?Q?GMIpUzVGS6AqBFcYkJVJDKMPj3jXNLx5+eVMgbZJMAtnkOlHoOxc7qbIPvG8?=
 =?us-ascii?Q?+seGVbJvilVWLYSBh9CAEtC03aRn2vxloyRuWWTGt4pjBeSjRDGMJgK7ejtt?=
 =?us-ascii?Q?7wgQdCH3zGhGyNwjnN1k2rS9cNqod2gSYZlj9ujIKjMyMaT7WZpAI4lY93/G?=
 =?us-ascii?Q?Sjmfbdp2haylZTZoOUJri4hVUUfmYJZAN6Y4fW5jxCV18GjREd2HoWk95ZhK?=
 =?us-ascii?Q?Zo/097ilBKHUrcp0FcbCzS1t9XJ5T4Ze/o7qoEwBs1jRo8cFtwP0wj3dmDjf?=
 =?us-ascii?Q?PYwaT/QqQWd10aGb0J3a3CwK4C7aUK5pwXfKBnGPEWeOeQ/FAzeU7v3TCsqQ?=
 =?us-ascii?Q?jfbhvUdAblEuNqvl9c4SWVYgSq7DM3LBnv3caLxyw/C6N9ugvWbGylAlC65I?=
 =?us-ascii?Q?vIflSnWAP8MtaaBWC0HL5yVwTFOYLodj+tmaTnCIZv4xSkRgzowVM4Mlf5F2?=
 =?us-ascii?Q?qjm9PIAap6mwYPZChgLe0oR5hnyGhUQchN56+/VGw5llvWQ7TY30XR8ZC6FQ?=
 =?us-ascii?Q?7FEhugi9uKZMGY51bPZUMUItp4jwTWgDaEYvdaeY4cK9PQ2GzbU4N86EPze9?=
 =?us-ascii?Q?YpQTMr7h7IMfHRosDSEx/T6g2lMGfVeVTl1GUtWEyN2gVcGgEvF8dm/XonTo?=
 =?us-ascii?Q?MrarOQ02Xc/QgNaPUJX8kboWsi9QYv4X+7DhRR56qIX69TTFmIBS1FkrG+Co?=
 =?us-ascii?Q?7ZpxX+SL11c1HJ067wVzPKjZ4T38dpMZoqYlThSkjUfePwarxJ08rPLTeNbm?=
 =?us-ascii?Q?cwNEL/TleRZfWqtdGMHAiyGtHXF1vsFdImqtindjVMQUoGGAAUa3Oh0WaMwy?=
 =?us-ascii?Q?yvOddJN7a5klMrQBExJmjDM11xZJ5S8sAl30W4ATPwIxCYORqFriCXXWpPZy?=
 =?us-ascii?Q?beyphlngSZJCqqhwkrg7wNu8gaHFqyqWF/Sn3hESalS0XxK38WYAkuSGXmOj?=
 =?us-ascii?Q?IpTesfUqaWdgcwAzhSYDepDURUoPhNxler1DB9DV8BN8A5qf198kCKTmc6U4?=
 =?us-ascii?Q?OFuX8ADvXB83ePvZsbEvg2JCfXvchjSLx5qriaQEW0WZbAYBvzQoD5dbzHSU?=
 =?us-ascii?Q?aImMYPfATSbB3yDqnu+M2wPdsPGaM7U0il2B/GuclJcTJjGFAuoIDAZVEoQT?=
 =?us-ascii?Q?0aZgz2Iehb09evwe8qxNbX5nLW04wOW9+EwcTgPRjb7wOKSpEOUvK9MNLmjl?=
 =?us-ascii?Q?5xBQB63EXaJNTRbE0ABRe1039FU/s18nUStGfr3rd6VQmzzeltfzfFDwPlEP?=
 =?us-ascii?Q?HlHPpUOKaQx7+eJShyhwMczX37PR/1NJGjD0QuLYoDZVsqoPOhxBF7M/oSU/?=
 =?us-ascii?Q?kBsXgeEP8ml2g0wbgk+aMTfESDPZOLFsMjduB3zDX93YxL25Hy8vTxMTTeOu?=
 =?us-ascii?Q?/LSp3fgmP5BPgZ8dJINQ7jr0BlTJGGxEJE0yFwkL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de78659-1f21-4471-6def-08dde65eeaff
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 18:15:50.3653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: htERww+Nn9FRKFJR94ZbB29hGd5E/iUTYV7jmE6EDAAANVGfdg6PHyDcQjjD5hcbtxq/k7cmB8VSqXBBIzOa3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10131

On Thu, Aug 28, 2025 at 11:14:48AM +0100, James Clark wrote:
> From: Larisa Grigore <larisa.grigore@nxp.com>
>
> S32G doesn't have the max prescale erratum (default) and it can query
> the max number of CS from hardware, so add those settings.
>
> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/spi/spi-fsl-lpspi.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
> index ce347cdbb009..431439d4cdda 100644
> --- a/drivers/spi/spi-fsl-lpspi.c
> +++ b/drivers/spi/spi-fsl-lpspi.c
> @@ -145,9 +145,14 @@ static const struct fsl_lpspi_devtype_data imx7ulp_lpspi_devtype_data = {
>  	/* All defaults */
>  };
>
> +static const struct fsl_lpspi_devtype_data s32g_lpspi_devtype_data = {
> +	.query_hw_for_num_cs = true,
> +};
> +
>  static const struct of_device_id fsl_lpspi_dt_ids[] = {
>  	{ .compatible = "fsl,imx7ulp-spi", .data = &imx7ulp_lpspi_devtype_data,},
>  	{ .compatible = "fsl,imx93-spi", .data = &imx93_lpspi_devtype_data,},
> +	{ .compatible = "nxp,s32g2-lpspi", .data = &s32g_lpspi_devtype_data,},
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, fsl_lpspi_dt_ids);
>
> --
> 2.34.1
>

