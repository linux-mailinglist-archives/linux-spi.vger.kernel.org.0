Return-Path: <linux-spi+bounces-8832-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEC1AEC04E
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 21:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8422B64155D
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 19:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F011D1E1E0B;
	Fri, 27 Jun 2025 19:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MC7EwTgA"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013060.outbound.protection.outlook.com [40.107.162.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC9920FA94;
	Fri, 27 Jun 2025 19:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751053500; cv=fail; b=SDKxTPMBOvFYOWIbrYWxK5WKoETckLtBWuriKBCrSnUR8X+zMthUyt+BrJEITsarXKX6aHvpRbJDCOqW9NDUjLOz8BzKjPg/+ajh5vA1P3zIjzxYDPt8E7gzkRePYye79bJnSDd8szt9tBr3B/hdWutQNqGLH3kx9mpOSiygk6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751053500; c=relaxed/simple;
	bh=wNHx/O2xyfO0bsHJnpDBIPnbNA3da2PJxqtlA06xeWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GKqEaxgGvgJidghEgTSsUhuadQD0i+hsJhtotKC6jYVc19R1Te5Z7EbC+VfsALlDvwdIk6y3Boakwbx1sdidlPbg8+7O692QmbpTE+UJKgIKq7ZPHlMr9gDHdzO0xeiTphk3e64KMLyHT9lS5DeB8y21iMfl/W52GNXINM9MvlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MC7EwTgA; arc=fail smtp.client-ip=40.107.162.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DvWVT80LUMsrAPk6xnP9lXAMXJ38y+GTIYZRDikhkcsB+tUffo7OpU6kvGAeTpQkpSEpg9mFSdcaTWHhQlshiRYUb9z2HC+oH3cua9V9cQqv3UruYRg3HIFgzBZ7OgvZvaleZun44yErOXkkbVHt7H30Jy/ns1QKbjDQ6lwKBMCh2j0ioNZn18fYUKBmRrqyO4pDM5jY6ao/fLtxPv8qR7OQW0a4qub7sIMnoaOnCAWXyEta52xD4SDakOVbwq5odzO+1sYbvDXjGkf4W4hIqX2jOLqwhlYp/JNwPq5u6dC4SIo8644eEiH9dR9psBtZ1sRB2KL3zG92Fy9FvKTD0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsR/d0zZomyiVYDuBK+aJ3x4Kmzf+nOPDucixeC24Zw=;
 b=ECNeTbaxIzkyHic8ROwgCfBSZXp78bmscqdRZ1+9hAayNV/Y8OEMdmh3rdZhx/dqXufM8D1njd3aQj8v8JWDHK3PsYx0g40bS3975IqJa0HPFEfAI7jJ9cj1/bSbdlyoUP82S0xIcCiUdv2JDns7McCTcK/VtcjkIqaEHY0jaqdSIWG4gfMwiPRqYVnFuRPxc44HttP1dhQqMFoHpYghaRax9ScDixEwuNzPFBK5FqBt1rd4Q4v68wlYFHWQc/itzvew8mUcoj95Td5HZmtQ/XZyic21HMGTxioQIzsCugOegppwbdC7W429dvuZpwdLsQxJzdSc5rxOs1AcYxa0+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsR/d0zZomyiVYDuBK+aJ3x4Kmzf+nOPDucixeC24Zw=;
 b=MC7EwTgAcCP6RhYngR5uHOrI9bZ1iW47ca8cn5ZvhrdNpUTHoyvJyN9GaLO/mmsSTOhM8hXzYMQgqvH52aQ+tBIP1WrDo6H8i1ZTmRQ6scvuvrKWx1YmkbN/NoA8H2aGhOG55dwMRjzcEmpMiCGAWCSLBUYeVtM2zPH/cLI228Fdlqz2UWSexu2U4dbmLPv2ZdUo9wBP/ZzKlFlx7ynNPHkoEQEH7kft+TUZVTJbTOCRJfnWwpOvIVrcseRwIf0neUpKpH+vwoDpkI0LxzGXAlSl7J1zl6kfUreaf8wDTpFDmbjrIY0Ra6IwFN+tfNExsoZPQV+hv5T719AQnHxx+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA2PR04MB10513.eurprd04.prod.outlook.com (2603:10a6:102:416::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Fri, 27 Jun
 2025 19:44:55 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8880.015; Fri, 27 Jun 2025
 19:44:55 +0000
Date: Fri, 27 Jun 2025 15:44:50 -0400
From: Frank Li <Frank.li@nxp.com>
To: James Clark <james.clark@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Christoph Hellwig <hch@lst.de>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/6] spi: spi-fsl-dspi: Increase DMA buffer size
Message-ID: <aF70skVHeSRU3BTu@lizhi-Precision-Tower-5810>
References: <20250627-james-nxp-spi-dma-v4-0-178dba20c120@linaro.org>
 <20250627-james-nxp-spi-dma-v4-5-178dba20c120@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627-james-nxp-spi-dma-v4-5-178dba20c120@linaro.org>
X-ClientProxiedBy: AM9P250CA0001.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA2PR04MB10513:EE_
X-MS-Office365-Filtering-Correlation-Id: cf9414c9-c26f-4583-9a79-08ddb5b31720
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xIZkUXvxOEEh8ytVHKFHPUg0umMOPjFdwrHODM31C3GkR+ZD73oDzyusln5W?=
 =?us-ascii?Q?tFYSCGWdg0HduVjOqzDyeioxwkqkBOsn8L8hQ+OvvemPY5qMiH/fUEtv2xHT?=
 =?us-ascii?Q?b2njDdG710BygyYBqnfkWdfAG/hLgSG6o/WLkwGy4zydyGwb3n32t87pYKSs?=
 =?us-ascii?Q?gb947YSTi/uf8psz8tk97ypkEiFqw8BwvigfZCqyytKT8f/o3a58rvV1QFSo?=
 =?us-ascii?Q?SZ0BOffvwqXLKjYv3vb8gZ0US1ouG0SoxRaEcfDyxGVumsa3wCLAqDx92V8D?=
 =?us-ascii?Q?OML4B02z1kKgEgQPNQT+5CNhRVN/Lb9ymqlNtA+1zrhMzHMBFAV1ciQ8FeKG?=
 =?us-ascii?Q?5SGGzv401arfbJxHhEUSkg5FW/d6HZ+7yiO0P1H9Er+kz99pfnioZG9XSQiJ?=
 =?us-ascii?Q?PRVEZn6/ooU4vTXOOnVxAHI273BibYaaiuW3QJmlG6keOe6rJxSjr/L2SPMi?=
 =?us-ascii?Q?FVKNcjUA8+UN58hWuRX7L47ihxEe2mU3VS/cC4alcO5n3JaBx5KH84uEqwkr?=
 =?us-ascii?Q?YD7VW1op/KgS+A8uStnIEdCeNWNEtO4D3/kAupnbuM6bKvibqMxp36inWdZU?=
 =?us-ascii?Q?HjrHwqS3qyGTZ0LiGDjIWpqrgSbj0bhEvz8FQCVRPThaOkmd1KsZt9GJQ0wf?=
 =?us-ascii?Q?2QgPRwnbpmFXSc9+lOFzYyGM7cny4ChKO47AhZl7T97zHO7ESFssXhWZkYVd?=
 =?us-ascii?Q?U5uCYcMAy+9pZOhP8slmN7J+Jp6+x6vDNaAvqPQHe3KSHjDb5y6u/cRTZalT?=
 =?us-ascii?Q?u1mVpmGZsMFPE1HK7uGHz3NwLXAqT9nGDtLr5MZyqhCpWfp4lTdNC0FSsWnG?=
 =?us-ascii?Q?Ymg99g6Vj8zZZq/yM/8WjFwiDLh8R18blD0SoxOU78XDVcRjPlLzV0OEn2SV?=
 =?us-ascii?Q?p/dsjQvwl84UVox5Bup9QVlEW8CVr3V+P9BaJvq+vFsZblSGup6uvHmuaG8q?=
 =?us-ascii?Q?Yg/QxzEEauj9feHozRBbZUIgFQb0SmaGzleetcfpvDhv2f3F++PRYI/AsYlC?=
 =?us-ascii?Q?Gh25KTB3vSdaYmd9WJiLGjUZ6VDm628IFjjLjsEQKmrCOUldL6B4pFACgzlB?=
 =?us-ascii?Q?E3i9emU0ZQ3qUFq5f7nLEOBfcgnjUoRg0N6EpXCk2v34rTFgid1A1tl+vUKX?=
 =?us-ascii?Q?a/CUVjHwrS95o1AQ8a++nTmNm7iypmacp44mwJ4N7kVfb3hQVKKl8HerLCcx?=
 =?us-ascii?Q?wEhFN1lyRHGwBqF2e+aGAizKec2iwvS7Sj1h25DqbpF+fnQfGjlyQrBjvYK/?=
 =?us-ascii?Q?/8AaYeJynS3r17oeZz2XpCsjj+TOcQEcH98OdPmDTYvP3MmGcxwM4hD+k2f8?=
 =?us-ascii?Q?LdtvIHkx/uHm35uR/Z2jMSU111KB9tvDX2DTRPs2kaLwXwvZva8e4Om2kBA9?=
 =?us-ascii?Q?oJc7cEROHVQ95F/z0Xf9IyCmnRBuq8ArTcnMrkCwfZx5TIElG/JUdM0H1RfP?=
 =?us-ascii?Q?BzS3EpWpoTKYnKhQrirACkL5Cxiyp6sH+ghMWIRpCemarZgfzIfJgA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t/Gmt4I7SD1rdKkRdyL0BRjLw6U6UB5I7BPTe5oHNaO6T+9td+3tZqFdL31m?=
 =?us-ascii?Q?zG4NDdhilQk4OsPeYXa/7+twx1n99HgrKZgilkfHZpHlqw7xTFa6duUevHWS?=
 =?us-ascii?Q?8cLndCtNlaWkt2rg8ZdBkYOC//eWyVZ0gmdf7kaVfEu/7mNonZwA4ymZ0UX3?=
 =?us-ascii?Q?CXEQAo3zTrlnzViFai7wITI2V1Hxri6PSkd7aXLk45C1xz37B8x0LtmdJVG9?=
 =?us-ascii?Q?/JwX+t0re851px85iR5OC+gQXuh3pJiWdCgg8AN/Gnd1wZUZIBR9GNW2VgPp?=
 =?us-ascii?Q?TOhRdXypf8bvAvr1rirsnObiabmnL7xw0kmChNyMt+Na48nu7RIC8344fGCt?=
 =?us-ascii?Q?epV7sK0Nbp/TQtw5p+ovzW6WlsB5Ke/Y8V97w58jvYTeDVXRC+wz32ccEzbw?=
 =?us-ascii?Q?mGFciqDu5WxqbFBG+Tn5n4NSY82iNEYgkAQ6JDemjjZMaCFei/ZV+cp4vN3l?=
 =?us-ascii?Q?izlMX0FHyuDlQRupmmrLZ9LLCfctMUAEo7OV5UBvP1qLiq9mxzanqUbgO1vg?=
 =?us-ascii?Q?EA7kcow+5dL8D4JOsqYdUXeBDHy2ABjl9vQ0eMW4cf6pu1sixcb+HnlMwJbE?=
 =?us-ascii?Q?YA6i9jsUYp3ZpV3QaMrQbRvzaRrjvB/SWD9zOWio6hyLd8Bqq53W+bUEY9Uf?=
 =?us-ascii?Q?+nkg/i9FhEGjqnNJ5uQaQseu0EzsT3CfHAaFV3eWIWrZq8KuMaO3m7zO0t8g?=
 =?us-ascii?Q?erwAy4AsmujsWHedEfxuh49BUSVxqYbr905Nl9rrX2ao4M4VrkhB4MbXAJQV?=
 =?us-ascii?Q?aHF2HCQyoM6aus+YZrZPxNdZJQ69thpeVaf8I8z29YSzXVZ6ZgPDeHh/OstQ?=
 =?us-ascii?Q?cKd7dHXSemMtcpWFu6ytul2eSWaebx1a49bkXl0di2zXF4zeB2ioxF6b4IrX?=
 =?us-ascii?Q?Dp4KuX3E3fJfQAJVNjXzcEcuiUrfznxnO8ScyzLZlN4ZI8LETyyMXYS8lQ44?=
 =?us-ascii?Q?rpamBAytP5IIuiUPTPBmJDWNih7funqnT2OYtgTKnEZ1hN3GP5BHibirQKPt?=
 =?us-ascii?Q?7/gaHkW8HquSUr4YaVDcu6oy0+moOxzsXYCwMZrKIjS6/tUlPfkhnWHV8/ja?=
 =?us-ascii?Q?s8Z+am29i1X/EvZVyQs+Ges554WHe7NYqHEKdgy+LSNQha9s8S80t/RfGM2w?=
 =?us-ascii?Q?HiESd5khKy6AInBw9RWKXLS0jq8H4xr9N6JHSm4qrGZnGPIcRe8FFK/JOdso?=
 =?us-ascii?Q?jhxy26oplBSVNVsQIJ26WTp9trPOHYoYxJPBY9J9L3ksjASBkLgxwv9j0k8J?=
 =?us-ascii?Q?CMHB3m96SOEfyH3P2pMYrAMFCvg3YpOSKopjL8n/XwjmF/EolkurfwlzCOVJ?=
 =?us-ascii?Q?0zADBC9Ph6VFlC+kZ/F2yBO5B848mVJ122evc79sd+M31BQvA62am6Zfc+TD?=
 =?us-ascii?Q?PFl9HO1mcaTVbXEpIKF6VyAEdJc4B96EVgktNtmphhd3JOgVaF+5kODNHmqN?=
 =?us-ascii?Q?NuQuQNt0ufzUG41muFS13kpx+cAeMmFVp2UJyr+FBrmFLMUztiXX4BnCuvMU?=
 =?us-ascii?Q?i11pMY4hEtPZLdXPT00588b5K0gixKtNKHJj2ftYbNzk/m/yuiiWqfiO5nz1?=
 =?us-ascii?Q?T63GbuQO3B3wWyHOZqkkSkNd6mWTz70gtz/ukd0/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9414c9-c26f-4583-9a79-08ddb5b31720
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 19:44:55.0058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pdAwVELzuxpHmASsqMsTLaRTrqDz8UuaQBA7YiOLJ3p6Xz5RA+OlmhUHos1+051pOP0v2bqmg0wawpn6ISXYgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10513

On Fri, Jun 27, 2025 at 11:21:41AM +0100, James Clark wrote:
> From: Larisa Grigore <larisa.grigore@nxp.com>
>
> When the device is configured as a target, the host won't stop sending
> data while we're draining the buffer which leads to FIFO underflows
> and corruption.
>
> Increase the DMA buffer size to the maximum words that edma can
> transfer once to reduce the chance of this happening.
>
> While we're here, also change the buffer size for host mode back to a
> page as it was before commit a957499bd437 ("spi: spi-fsl-dspi: Fix
> bits-per-word acceleration in DMA mode"). dma_alloc_noncoherent()
> allocations are backed by a full page anyway, so we might as well use it
> all.
>
> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  drivers/spi/spi-fsl-dspi.c | 42 ++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 38 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index e7856f9c9440..46d3cae9efed 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -493,6 +493,39 @@ static u32 dspi_pop_tx_pushr(struct fsl_dspi *dspi)
>  	return cmd << 16 | data;
>  }
>
> +static int dspi_dma_bufsize(struct fsl_dspi *dspi)
> +{
> +	if (spi_controller_is_target(dspi->ctlr)) {
> +		/*
> +		 * In target mode we have to be ready to receive the maximum
> +		 * that can possibly be transferred at once by EDMA without any
> +		 * FIFO underflows. This is CITER * SSIZE, where SSIZE is a max
> +		 * of 4 when transferring to a peripheral.
> +		 */
> +		return GENMASK(14, 0) * DMA_SLAVE_BUSWIDTH_4_BYTES;
> +	}
> +
> +	return PAGE_SIZE;
> +}
> +
> +static int dspi_dma_max_datawords(struct fsl_dspi *dspi)
> +{
> +	/*
> +	 * Transfers look like this so we always use a full DMA word regardless
> +	 * of SPI word size:
> +	 *
> +	 * 31              16 15                   0
> +	 * -----------------------------------------
> +	 * |   CONTROL WORD  |     16-bit DATA     |
> +	 * -----------------------------------------
> +	 * or
> +	 * -----------------------------------------
> +	 * |   CONTROL WORD  | UNUSED | 8-bit DATA |
> +	 * -----------------------------------------
> +	 */
> +	return dspi_dma_bufsize(dspi) / DMA_SLAVE_BUSWIDTH_4_BYTES;
> +}
> +
>  static int dspi_dma_transfer_size(struct fsl_dspi *dspi)
>  {
>  	return dspi->words_in_flight * DMA_SLAVE_BUSWIDTH_4_BYTES;
> @@ -608,6 +641,7 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
>  static void dspi_dma_xfer(struct fsl_dspi *dspi)
>  {
>  	struct spi_message *message = dspi->cur_msg;
> +	int max_words = dspi_dma_max_datawords(dspi);
>  	struct device *dev = &dspi->pdev->dev;
>
>  	/*
> @@ -619,8 +653,8 @@ static void dspi_dma_xfer(struct fsl_dspi *dspi)
>  		dspi_setup_accel(dspi);
>
>  		dspi->words_in_flight = dspi->len / dspi->oper_word_size;
> -		if (dspi->words_in_flight > dspi->devtype_data->fifo_size)
> -			dspi->words_in_flight = dspi->devtype_data->fifo_size;
> +		if (dspi->words_in_flight > max_words)
> +			dspi->words_in_flight = max_words;

you touch this line

		dspi->words_in_flight = min(dspi->words_in_flight, max_words);

Frank
>
>  		message->actual_length += dspi->words_in_flight *
>  					  dspi->oper_word_size;
> @@ -635,7 +669,7 @@ static void dspi_dma_xfer(struct fsl_dspi *dspi)
>
>  static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
>  {
> -	int dma_bufsize = dspi->devtype_data->fifo_size * 2;
> +	int dma_bufsize = dspi_dma_bufsize(dspi);
>  	struct device *dev = &dspi->pdev->dev;
>  	struct dma_slave_config cfg;
>  	struct fsl_dspi_dma *dma;
> @@ -719,7 +753,7 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
>
>  static void dspi_release_dma(struct fsl_dspi *dspi)
>  {
> -	int dma_bufsize = dspi->devtype_data->fifo_size * 2;
> +	int dma_bufsize = dspi_dma_bufsize(dspi);
>  	struct fsl_dspi_dma *dma = dspi->dma;
>
>  	if (!dma)
>
> --
> 2.34.1
>

