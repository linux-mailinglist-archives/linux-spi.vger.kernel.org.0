Return-Path: <linux-spi+bounces-8833-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 395A0AEC079
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 21:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8638F5614B6
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 19:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD5C2EA48D;
	Fri, 27 Jun 2025 19:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TN9+blQv"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011010.outbound.protection.outlook.com [52.101.70.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3D515E8B;
	Fri, 27 Jun 2025 19:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751054213; cv=fail; b=U8TKmgB2GhqKhm0fxQLfS1y/VFBRyuDjjcgWedsLgW7MIrKmm1WQ1mI1BCZ+78TyAyAMWrwbF7sscWLJ1W14YKKp82ZCowPqfMF9x8+q2vzHIesSMXRRdg5SuV9d6MM/fpiEE8tbhnsUB2zJsWfH1VeqY0qvmAhYlvOpg+ETy5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751054213; c=relaxed/simple;
	bh=A3SGXkBGZADt9YzvaGRVEtPWrEzGJbx8NTwfqsgoVVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TOaH9I2I5haF1jAZP3G34q4lNGIea38talklFrAwu/mKsS1q9q+/BjB6hXMwQkfhbq7reVH8O5jCPiMRpIvkaRCfaf3gfB5R9kGVclwPZrvSm0Arzwo6L3bIj8hbzQXwHgy9bDJsglCaCtrRuBm8fMpMWX1pXMpC8btDdvqMikw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TN9+blQv; arc=fail smtp.client-ip=52.101.70.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHizczNr+ll7UD1jFShAmgzc5ONjiOmneiYotW7X0dNLqxH8xz7XW9/NfsKoS5Qopf4nvS6i4ysQzcn66RvmvDyRn7SAIFReQFEI3564RjkB0/Y7Zgv4AxwPjMZu3o9ROsdo7L/VuAN4oekP7l1K38PgxuJRZi68W7SeqzHrwZuaS6eeXJxa7iBXaY1fdAWfXN11V0cZaDqfFBbZVYrqjBl3FXpequVkOfJK8VqpmWugPAoJ2fU8/vWqFVIYQ5jdMgINR4TnhlmWimHjehalQMCyvGKt+y5D57u9Pd7YvkLcuXi46+LfurWj20Lh9OCiuWpxXqm3fOBsQkpB0rNlGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+y+Lulm7pLRvs2vGDmM8oPWsg20IWYnlbk0yKRyS1VU=;
 b=ogUL++kfQWlT2MnEh+I3OoZuK9USfQURAc3o6AUHCwIs3SR+8lGeh6PPFB4fSKe/Ywljg54q655xWJQozHh3IncLNyft4f0J48FLQ54ig/AeGUE5jthexVgQ8Z0ZcjDECIJkhCwRwM9O5g/LsZ+SFyYi/jjgCgx5EMf6rBAcsSW0kgszP9DXfG8R9L0SBJHGhC1cMk2RNWC4BmDf688AqFgj/5pjdZKChBbwTABOYLGoPWIL2iS/OPHaup9ydlWwrTX5YVLA49u6xBih6WrWwTuaJomz26CRQu1lG8MilLPSpDuniU9DZHkurTo1wSkQxxOdOKwt3HCd+6jDDqOlmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+y+Lulm7pLRvs2vGDmM8oPWsg20IWYnlbk0yKRyS1VU=;
 b=TN9+blQv/NfZ95Cl+zMHxTfletdoTTSXlMClZPaquFgjDlM/Jn0Kx+7GuSLx5LznwbG2K9VBQY3DyLOEqAA9SEAZXfJFk7PKj1CJHmvtVFxoKq9tci6prXCG6LMOnPSCvxPIXgB+E/UjMMO3jHfVmX7jcdCSmAs+4zKkHKSeFqEkVL3WWm/JOdy+mesa86Ae9OLKWOW9yc5KvIp4xQ7rdsFKcBoXvqTKhr1+PRcPBJtSt5oHiYSUcgaIcESnaKzdZMC7e9YIIsAmWfCiyqsB8np2rszNyDOZnGnDK/qBNnfRWvEXi+5Jb3cwXDJ2d1R5HjXiiUlk3xzBhYZZSpl0gA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8075.eurprd04.prod.outlook.com (2603:10a6:10:25d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.22; Fri, 27 Jun
 2025 19:56:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8880.015; Fri, 27 Jun 2025
 19:56:47 +0000
Date: Fri, 27 Jun 2025 15:56:43 -0400
From: Frank Li <Frank.li@nxp.com>
To: James Clark <james.clark@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Christoph Hellwig <hch@lst.de>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/6] spi: spi-fsl-dspi: Report FIFO overflows as errors
Message-ID: <aF73e/ggeycsYiaD@lizhi-Precision-Tower-5810>
References: <20250627-james-nxp-spi-dma-v4-0-178dba20c120@linaro.org>
 <20250627-james-nxp-spi-dma-v4-6-178dba20c120@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627-james-nxp-spi-dma-v4-6-178dba20c120@linaro.org>
X-ClientProxiedBy: AS4P192CA0020.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8075:EE_
X-MS-Office365-Filtering-Correlation-Id: 96c16c3f-736f-4b17-2d1d-08ddb5b4c000
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qim8SmqpFMWICiE7a9Ieis6ojkdanTPizzGB+eHM3GjqcD57tW1/agnYOSd7?=
 =?us-ascii?Q?leQs3XirpweIyKFR95kioDdc1X28LmCC+/JccCSQ4rhaIL2v7Vl8NwLderJE?=
 =?us-ascii?Q?ePyAvHmYyiQxghin968KuvObWSIaOUZ+hAplsR/lyBGRhmtDxD4IfRu3mExp?=
 =?us-ascii?Q?wgi0AMXACzk3MQhWK53GGqVe8SVdpE9FLb9wg+ibfvSHE0V04NvRsAAgtylK?=
 =?us-ascii?Q?K5+G2bgC1zpJblDmXDIdxpR3zafYrX+Ov2X/MXBOTSuHKjoTcHAgzgbG7MJN?=
 =?us-ascii?Q?fU4r0Ympbq8Hpv+LYDUlwthLBGMos3DJTVZcPiFJ8VrFROpVVNzFRAR1v/Lo?=
 =?us-ascii?Q?qAr9R+FyHqRbo882yETzsLFYCa9biniwDbNJwdkz9J1HtPWNXM1FiolZ1zba?=
 =?us-ascii?Q?NCond3vFoKPmpFK8tDOJn0LtBaTJX6SzLf0v2Bl5lqrykqP88rsOZ3NOFBoI?=
 =?us-ascii?Q?qWCvpIUoV9s0FBwCkXQAOSVPg7AnkLted+vUpfJ+gjMQDFlfGOP0gFXDjEsd?=
 =?us-ascii?Q?RlS7tQgk+JOXV54q1nzNFqFR1v1ohgzXlBYM5fKQImsPDdUw19kz9FgekdTC?=
 =?us-ascii?Q?Z8zlhV4guptdOzfEXy0oGa0KOe02esjaviUFDDK1UF+iROEoBmMeRTve9Eyc?=
 =?us-ascii?Q?DW9Z6Wn31yusMdoKgwCKfb1fev6ggAeDT2jZMPNjiCtMfWl+SRhZcd5LXbRh?=
 =?us-ascii?Q?ozOjmneAclYLHL9ZtAX6/X3z6CFw4ywmCxy53MUvufj71jKCqy4iI6vjeH3d?=
 =?us-ascii?Q?skEhPAHKI48NBzxNwEervcsXUObbEuOOf9WBf3AIADEm1klf7G0CK6ysj/ra?=
 =?us-ascii?Q?hx2xA0iZ31wgyuUgDFqUC5AVsUWVniVj2OPk/d05k3bOlVLbhwSWYoLnaOp4?=
 =?us-ascii?Q?XDF5Vokogo9IkSQ+yOLruHJpxGLXWyiOnkUoQGTSBWt+TRlHswQft6/xBj41?=
 =?us-ascii?Q?Tv70gQuAMQLbTusBxJWhGOXwdVoJOSdl89FrySGj+HR/0IYGwCBY40s3xTie?=
 =?us-ascii?Q?CbKErvG6oyY0BroudnUj5eo9UmHEKRUMNjOel24qSjny0oSwUVOoe0Xu5f3b?=
 =?us-ascii?Q?c30+rrkevWiNJerQ8420PkfQAV8HtyVL/AnipvU0Cr5DPCWUv84ceZGc7Bkx?=
 =?us-ascii?Q?oGOq9c3DGw2f+yM3DLwY97QfyioQsZuJXrRIihLAQvAeBljP6WoZ/jiNEOOi?=
 =?us-ascii?Q?gkslPqxWu2XZwUZWsYAsnHX2Z2O/a0tWrvlpNz8vs14mIUsEK+LeSHbTIafZ?=
 =?us-ascii?Q?c84fR99NsGzmmnnD87N0QtquEDAdCji9LjBxlQ9+ZWGeD2DwchKJJwFChvyl?=
 =?us-ascii?Q?R2yUVg18DAYTl3Rco09Uz3Ibpzm4NHTksoBQxFEnXmno38CFQecrOQ7n0Un6?=
 =?us-ascii?Q?gok6T9BbYrGXvH6x/8/msS73eYuiWqBsEloO37Ls8/YlMlKGNaoYg8MDCgVg?=
 =?us-ascii?Q?hX9zh6G0nlnxjZfP36TBuahZgAhDWWXa+29qQPkzorDVWEnpSi5zjg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gzfNjDk0ZvNnx+ZDBdJFlX1i3xsGJCy65jhH3pPs8A1T7kLG+//YXUMK9Qdt?=
 =?us-ascii?Q?EUAlKb6EGB0JqbKUccFOqEJOjWV/BuqUmirIpUvlg77KPDk56xPtglagBJF2?=
 =?us-ascii?Q?XcE0aMJrqSYwNKePWp44Ka4LovQL8bLaUEKmy2o9fgbMY2iL6nggGto01JYd?=
 =?us-ascii?Q?FjHE4IBc5m5h1+fIDQ9yekFJ1RYrbmQVWWhPoRMPZLzCdx/lbBP9q7tC+2xh?=
 =?us-ascii?Q?SfGXhwlESos36TGIJH1mxIQcoWyzbjBOxdNDNr7LacPfMPpDkvRI1Pmb+Qcn?=
 =?us-ascii?Q?+waW55yXsVUfd9ZturWVrJYzYnmCMfTA+8hKjmlIc3Y6hbbNpV/JBg95PC25?=
 =?us-ascii?Q?C+OWL5gk/vKtvvFOlj5ZdPv+K3T5+KTGsyxbF+vvm+aibNpoEBqHiZTJjRKL?=
 =?us-ascii?Q?vLPXgkQujh9p01JE21PR3/f6y/4/3vQxlMx/RoVsohy4WPB0Uhog02hcZTpF?=
 =?us-ascii?Q?WpPW2Javz7w9lRIyKPMSjGSl5zEPW2MYUNBvtHVacqCfMlpVt4vB2LpSub9m?=
 =?us-ascii?Q?q3smTY3ytiYQrLQeVajto9nv9C3LTyqwnwW7oZIJTZxIGRYyqH5kBnrZ39+7?=
 =?us-ascii?Q?v2bowUo/qinG15Sra/P9wkr+XvHkmyZYM+xCDGF4P6TmhoQXCDtH9PtS2/Ab?=
 =?us-ascii?Q?/QPxkXYJ2Zm5Aq1bxr0VJ9DaysRoE9SozvlmCRNHdGUCSgdsXd1kHciVqBBm?=
 =?us-ascii?Q?DXeK8i+OdvKub2DhRYT1MVYeclPwmb6gMh1NnwdS/HxvQw8ES2u9MYNgUMOs?=
 =?us-ascii?Q?Ilg5xQku7Sk3STEK1EfZLBL22sowl8rWRxpzJGZA0DMA/w4pV5h+f0vf55RB?=
 =?us-ascii?Q?/0/NnZqweSPeRhUVgWDJIoRzDxyTkv+RWv0rKcPtqK+B7fCcLe8t/uA8S9CO?=
 =?us-ascii?Q?xyHX1DsDwWKqNz7VjIo4wahLqMo5vk4IIiyTWuqTgidbmlTqLrEJ5TSMiO3x?=
 =?us-ascii?Q?69IsniudEsvwnqotLZkH6AzE1pMemEn0AhWDlUjwltojE5TQqbdY+b4bubWj?=
 =?us-ascii?Q?P/M7eizRSEh2LLNqI0e00WkrDwWijAymmJrqHUOo3Cq6L+5o2aPgNEgBguqL?=
 =?us-ascii?Q?O3BpGRQ7B3rxrN52DK6yXAP1W7YrKTjnK17N74Y6S6Az92+7wSd7g6pFk8io?=
 =?us-ascii?Q?M6jvpFpvA9sKEBPWFqIEXHgxFTBaWSu6g4u42juEm3gt0UJM67afEwWp+HXh?=
 =?us-ascii?Q?Xbg7rjyfpghRl3ThQ5pIiIDhD8LE3nwI388HhP6NhacQn5c+Q4MBO1wTdZ04?=
 =?us-ascii?Q?+H1yK6zONvy28DrLnZFrpzl9190m7U5O4brMwbFy5+YdM6TCy7NaBKUiy2CF?=
 =?us-ascii?Q?c8Xj6ughKUN76uN1McSioIwNq5JGKU3DFJQQ3XTwPYQHjA3eA/zRYL7ipMe8?=
 =?us-ascii?Q?gn6VJGuUvAdB7NnzIjccZSBVmbLGOVaCkKZdNhmYzQJUdy+20yRf5k314u0W?=
 =?us-ascii?Q?tXimUD0dUsVuP3C5GDnhOUHQwcEdpM+91fX/tD/FgW1nHD511jx6N6V2XSkw?=
 =?us-ascii?Q?yNKTtITcIKp1ao3e5AQARAUmjrR35ZqE13IB6o25ZYe6ChcwDMtTZRsPLi4i?=
 =?us-ascii?Q?HKEewrza9ZVgS3rma+0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c16c3f-736f-4b17-2d1d-08ddb5b4c000
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 19:56:47.8714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f33H8THFic3ReeyypmlUwIUwAC+sbALnFF1VWaJHWb5tvp4e3IySQ+A5Vfj7PR2NeQ/exVx0MkJSFGUoVazAjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8075

On Fri, Jun 27, 2025 at 11:21:42AM +0100, James Clark wrote:
> In target mode, the host sending more data than can be consumed would be
> a common problem for any message exceeding the FIFO or DMA buffer size.
> Cancel the whole message as soon as this condition is hit as the message
> will be corrupted.
>
> Only do this for target mode in a DMA transfer, it's not likely these
> flags will be set in host mode

"not likely", I think SPI controller should stop CLK if FIFO empty and full.
It should be "never" happen.

Only check FIFO error flags at target mode because it never happen at host mode.

You can remove below whole paragram.

Frank
> so it's not worth adding extra checks. In
> IRQ and polling modes we use the same transfer functions for hosts and
> targets so the error flags always get checked. This is slightly
> inconsistent but it's not worth doing the check conditionally because it
> may catch some host programming errors in the future.
>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  drivers/spi/spi-fsl-dspi.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index 46d3cae9efed..2c2a263c5276 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -478,6 +478,17 @@ static void dspi_push_rx(struct fsl_dspi *dspi, u32 rxdata)
>  	dspi->dev_to_host(dspi, rxdata);
>  }
>
> +static int dspi_fifo_error(struct fsl_dspi *dspi, u32 spi_sr)
> +{
> +	if (spi_sr & (SPI_SR_TFUF | SPI_SR_RFOF)) {
> +		dev_err_ratelimited(&dspi->pdev->dev, "FIFO errors:%s%s\n",
> +				    spi_sr & SPI_SR_TFUF ? " TX underflow," : "",
> +				    spi_sr & SPI_SR_RFOF ? " RX overflow," : "");
> +		return -EIO;
> +	}
> +	return 0;
> +}
> +
>  #if IS_ENABLED(CONFIG_DMA_ENGINE)
>
>  /* Prepare one TX FIFO entry (txdata plus cmd) */
> @@ -566,6 +577,7 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
>  	struct device *dev = &dspi->pdev->dev;
>  	struct fsl_dspi_dma *dma = dspi->dma;
>  	int time_left;
> +	u32 spi_sr;
>  	int i;
>
>  	for (i = 0; i < dspi->words_in_flight; i++)
> @@ -614,7 +626,8 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
>
>  	if (spi_controller_is_target(dspi->ctlr)) {
>  		wait_for_completion_interruptible(&dspi->dma->cmd_rx_complete);
> -		return 0;
> +		regmap_read(dspi->regmap, SPI_SR, &spi_sr);
> +		return dspi_fifo_error(dspi, spi_sr);
>  	}
>
>  	time_left = wait_for_completion_timeout(&dspi->dma->cmd_tx_complete,
> @@ -1067,6 +1080,9 @@ static void dspi_poll(struct fsl_dspi *dspi)
>  			regmap_read(dspi->regmap, SPI_SR, &spi_sr);
>  			regmap_write(dspi->regmap, SPI_SR, spi_sr);
>
> +			dspi->cur_msg->status = dspi_fifo_error(dspi, spi_sr);
> +			if (dspi->cur_msg->status)
> +				return;
>  			if (spi_sr & SPI_SR_CMDTCF)
>  				break;
>  		}
> @@ -1085,6 +1101,7 @@ static void dspi_poll(struct fsl_dspi *dspi)
>  static irqreturn_t dspi_interrupt(int irq, void *dev_id)
>  {
>  	struct fsl_dspi *dspi = (struct fsl_dspi *)dev_id;
> +	int status;
>  	u32 spi_sr;
>
>  	regmap_read(dspi->regmap, SPI_SR, &spi_sr);
> @@ -1093,6 +1110,14 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
>  	if (!(spi_sr & SPI_SR_CMDTCF))
>  		return IRQ_NONE;
>
> +	status = dspi_fifo_error(dspi, spi_sr);
> +	if (status) {
> +		if (dspi->cur_msg)
> +			WRITE_ONCE(dspi->cur_msg->status, status);
> +		complete(&dspi->xfer_done);
> +		return IRQ_HANDLED;
> +	}
> +
>  	dspi_rxtx(dspi);
>
>  	if (!dspi->len) {
>
> --
> 2.34.1
>

