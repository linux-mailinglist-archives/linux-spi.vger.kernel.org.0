Return-Path: <linux-spi+bounces-11719-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F91CC9BDC7
	for <lists+linux-spi@lfdr.de>; Tue, 02 Dec 2025 15:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA8584E408A
	for <lists+linux-spi@lfdr.de>; Tue,  2 Dec 2025 14:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB6E2222D0;
	Tue,  2 Dec 2025 14:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LkKQk8AI"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013058.outbound.protection.outlook.com [52.101.72.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D802AE70;
	Tue,  2 Dec 2025 14:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764687167; cv=fail; b=Zo8j554OPTeYMHqq2fq70TlndAmREiY0jNDrx0guYblmDHizh8WV/Tt5zSLnSWy4PUdCAZA/D6n4vuIu0ezknFn00gMVRaqHaJCBWznUxJPE8CcqSx3pDFtM9JSh0r90oO8YXwD/kPTXwR11e+tD86jdVHi1PLBnoBXm+379ztM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764687167; c=relaxed/simple;
	bh=GC0pMDbNWOgbv2/UbCPraz4RsQY9RTkwdQwBYBQYhXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VVhGN/aWq3GgXU1y2Uke4v95sGPZugC+Liwdux3P6NzSo0YQk33aVOdKSbtJLuA3bTpRwPNO1tvq54KwKJAEyXOZlo7sL8PXPsbK/4N+WnZ7tK6xf2ZTwUQ9sl85bjS6tOshk41Me9C180PEwalxNqT4nusnn/ZLy6F01Mrheck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LkKQk8AI; arc=fail smtp.client-ip=52.101.72.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OMUTgJd/TtU8LSpMhJkaE+B7Q5Zfju0YY5Zz/eLXuwP9os/bPm+vwC1L/DRx9weMgr/LzEq5vGTkPm5dCW2f6AvcxEl1BM3YrToNwq4Y/nFvoU26eHOpKHtFqJeIr7+OHxkvjwZy8KOa9TciNR/n0femxcvlrGpppF32Gl+AHVIh/IKH6IsgpDRpsqcSSFdgmfbw/HcoVqHWYj28swWFF+isn4ATJDC9+B5y+dgg8GKm3mKWhCnodAln60eh0vRU3IoLAFQNauMEyNPvox3036vurJN3lFaoiy9yGz3qKAHpp8+q03tfzA3Hf/OD/myebGD25qh5UOi5tQY+ZZ2zAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFYWHiCAx9sIQNAxP8wydejdRy8YcDJ7JHF7wz3UpLI=;
 b=SpIzINptf9KtJAtu/udk5AFCXjnld2HZSLl8oCl/RtIv3TDcIriE3WYzOHbtoHkrr/I7GbbujPIgwhwDduh56TXDZdrNnbr8jSbi17Ou4m8MwcuS7H8t/y82/k1In6wQEOSlbgY7OsdcsEc7uy53isW0DzJDmMr5mcPCl8SoNgxtMa/nAePBta7upkq5ZVAcL3ki7itHv5MjYHSwSXaU8TbAHvYcxqMNQHw+3pkeYVE2qGL0v9bc9z4ZJkzMY+skPvnKV3eqTOCdPZ2qJJuWnW6rQh2VMp4NjNsOSdgalJomkF6Kf9Pw+gYlK1ECjYt26SY0fm42dO9Ff0AxsYn8xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFYWHiCAx9sIQNAxP8wydejdRy8YcDJ7JHF7wz3UpLI=;
 b=LkKQk8AInl67MDK5ALnVVq08I5zcve/oX+qJuid0H0E/nCUcUN60HeGh74UbZtSsuYPaql/wDtjG1tY4QgnC+VWtHrWnL3SqvhooUzXnVqyVSHlIXJj514vCOYUA4MLMct/JGxcbmipp6OciI8c1zP2YZ+5++8KsPyS2iJb9Zd1Tpwc5IecJYwNJPWFQCdnqScxFMAqmCWw/jTq1qjfYMjsCBrWawPU8DAO4Ph2RJKkALbaEyW2sLVs9XmDCpJOfMOjcHBmSha6qJHF3fzvjDW2EYl+4c1rmLwy37UklN85EoHucP6rNqEFL5wSH+qd1hXm3tKUumuZWcbmrbe9zLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by PA1PR04MB10172.eurprd04.prod.outlook.com (2603:10a6:102:461::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 14:52:40 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 14:52:40 +0000
Date: Tue, 2 Dec 2025 09:52:32 -0500
From: Frank Li <Frank.li@nxp.com>
To: Carlos Song <carlos.song@nxp.com>
Cc: mkl@pengutronix.de, broonie@kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	kees@kernel.org, gustavoars@kernel.org, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 6/6] spi: imx: enable DMA mode for target operation
Message-ID: <aS79MEp9LMohngIc@lizhi-Precision-Tower-5810>
References: <20251202075503.2448339-1-carlos.song@nxp.com>
 <20251202075503.2448339-7-carlos.song@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202075503.2448339-7-carlos.song@nxp.com>
X-ClientProxiedBy: BY3PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:a03:254::14) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|PA1PR04MB10172:EE_
X-MS-Office365-Filtering-Correlation-Id: 0325caa1-0910-43ea-6e8e-08de31b27129
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yoAlAeNMRYdi3s368OJ578RlYbQ4CLqV06mizCj1oDZ3HxjTFqDHm0gK2lUf?=
 =?us-ascii?Q?zLt8EY0B1pQ4bIwIkMUjia51qbuYQzDJ8Tm/q1/7RJiCUsdRmgZrqIjTq+kn?=
 =?us-ascii?Q?3awHcBhgXAZ3/36mcyh6FH8ZJw23Q5Ek+F4Qp3/GIuTOVsUpsJrmPo8COmWj?=
 =?us-ascii?Q?+5ZE4GJ80YHBw+J0mkcD8RUNtd4yzTZvv4P2WfQDbrXheH4wOol2px3oxyLM?=
 =?us-ascii?Q?D9+KNOYw6C8NUPKkBRehF5u1Cc7XVnNKCBn6U7fxrr4nxNp0K9Kn9QJllysc?=
 =?us-ascii?Q?r6nI3H4+BpRDw5b2xFftCFA3v66G3Vfh4DGR4hw6k6hIuujUYnZ1tg4FiWRR?=
 =?us-ascii?Q?wYOuw2/oIMjQ5tsecQ0eqrjzG2/aqoIptQFNFUK+CCO0DkbAfQHw0RsTCb+z?=
 =?us-ascii?Q?T6/ZkVROj/uEMnfuKU8mr+5oiUB9KGutONsfj42Zbd1sfKk4rWiZrg8MEXf8?=
 =?us-ascii?Q?2ozrIS6UscSPcr/biKprEiLg5nN7vC/MBQ+Ps6J0Lwtg/ZGowZtyxaoCckem?=
 =?us-ascii?Q?UgvR6q+4bnnl16aed78xuIU7QrdC4oFJduU8FRyObzJrC5neYVO1FyIZCCTU?=
 =?us-ascii?Q?R4vOlHFe7NV30RSakQvOadqR3KFMIJL8tw82aaQ6V7qaOzQWOhLcBgi1eE7U?=
 =?us-ascii?Q?pNxDblCITBtSbeIaGKUgs38LU1xlLI441YapPWR/VPf3eaewbbwkvZ+SL4dp?=
 =?us-ascii?Q?KdU8ibkGsxent/tGAML4rHNDNz6Y3kdWkZXkzuUiXOC5UT1otbNzlwEq8k1N?=
 =?us-ascii?Q?KoUbP4bl9P0YbUIN5x9tofLsp7S3u8lAP7vtU97QH34J9VFcu6XAEWcU9wjq?=
 =?us-ascii?Q?d3/tIyBKzSfDRdiKIKI6Yhc1hlEK2Dx6lZsKaGLJzGBkoJdfGXAuJ0VBSJ0t?=
 =?us-ascii?Q?J04ThTffb/6NLGCbccuHAfYdIpgWSMWz26s3I7H4lM24lkbzh3UeE6pIiRkq?=
 =?us-ascii?Q?VKsI8GBzAayAVKIHPL1UdSe6beBzXKAg1Ta26DQ0oNoAqwhf2ELvYapGvvUR?=
 =?us-ascii?Q?ZeXFq+3mYZqLK8P3pkKQUEWUK6AOk3ZTyOV2I3zeB4RfhJkWk+jtE61ywnuN?=
 =?us-ascii?Q?4RfGbbcNtDCfB4vSRQA8jpwYpSq9HsAp5PrYh9LKovJqhQehExMub73cQkEk?=
 =?us-ascii?Q?ovQ4NkogbSfdy2QR8rE8Sujmkxq3sdfA+WX5Yj1NUURz7OTpNUzHBofZ1WJA?=
 =?us-ascii?Q?CLlhggA0Rqc5sHWJi9mHXbWT0q9k9IOAlrDHkZabM+NHEVwdGzTvNwgokL/V?=
 =?us-ascii?Q?bs9iO5GIwE3Vm7VlMMaj7t4rjD5YW0KpeW+iDb/t98f56Ilv236nSGiQters?=
 =?us-ascii?Q?1nqBLfXobAkk64mj/tmutk6G7F/cZONDtaKCBksyMkOesFLbV72c+I+WgLue?=
 =?us-ascii?Q?eFKGbKhvfsAn82rrrO4pHibOAWWYIhuMxr03e93Uj6k2lsrEbfX+HT5arDcG?=
 =?us-ascii?Q?XjXUOiuanJCkefl3Ojou4Veq+6HeCPwdgtwKVtmvQ9acQRnvXyycU3ksKuh/?=
 =?us-ascii?Q?QBdop25kNoxEH3Uqxq1DQJ+2o/iYBmFsO9eR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wexdONW1fq9mqmIDbtktnQQTCdBq4teODF1XW4valCgQnW/M8UtsDY/qQww2?=
 =?us-ascii?Q?RFTQ4buDiE8ELG4+cvK7JJN95ig7drNuTckXJSDtlIW1GWuEDHkLLotiVJbJ?=
 =?us-ascii?Q?fUcqrxN08T+4+KTkhhny3xfvgw2AUBqRfA6vbf6PlzxV0+7oliyLCwYwYy4m?=
 =?us-ascii?Q?AVLZamkLGiT424uJgKaygmDiaMBYqTt9Xd+l4h7NFD2pS3qINnAVKVEmNDcZ?=
 =?us-ascii?Q?NyDnUntAjd7tYLQ1y2/a86hZ78mWTG+0uwjUwtTwr+kWkvXydxmmpK9R+JtF?=
 =?us-ascii?Q?+HgMvqwSwlMCMdd/Gvvn20TVbiS7j+0m/F7mAxZUsg/N86ro3ZmeJPossDuI?=
 =?us-ascii?Q?hwy0VuBReHF/Wb1hEw05ACkk0yMtf3ilFYkq+MCh/UCx3b7LfAnTtPkLm2A2?=
 =?us-ascii?Q?hHLYByUM0nruemDjsYXceM/PIvuz4jxamXbtnc0G4sMVpicQpGXTE/G1xEof?=
 =?us-ascii?Q?Y0NY8Nm1pce5x26+76nx/QlLESHGauJtExGk6L5moyAqOVBglGudekhnDIxl?=
 =?us-ascii?Q?NQsrbuBkVETO3rGt0X/l9FIxAFFmO16ec0aXm+/zaDZgTkcKsZwBaHL+NcWO?=
 =?us-ascii?Q?ei+6h/3CjUji2WRQ45sAPdW7EDrgxRVj1aD1Gon0Gph3GjucKvF/oY+nfA/7?=
 =?us-ascii?Q?ZIwD/SOa95E/FwYNnrvNITv9Wt2fwU67FasYt2IURMvSyiEvWG7STwtradbJ?=
 =?us-ascii?Q?lGXlFnOgKg7XmJA7dKsLUzJIKZcoEGnvGMPGSkIZoXDIbKeuYregvLB0/5CQ?=
 =?us-ascii?Q?coN0WGo6g1dkUiqxEtHyQIVm7dw4mrce2aUC4Hia3+qN09Ib6nCUBvKvZVlP?=
 =?us-ascii?Q?QkrwJiHlE6zddL89gQ4ihMZUCXvjSGoGxH3Kt50kkb9JNAJBl2gJ79Zl/Wy/?=
 =?us-ascii?Q?gNqdUBD4SpbdbdnnbRabQx+VAkxhEATrys+nssrZUhcXij/kIImq6zfvdhEO?=
 =?us-ascii?Q?zRMGjGJ71PYPL4g2RRWKrpgI1trWxuDRXK8Ij6zz/qCQmiNWDqHeNprStdBQ?=
 =?us-ascii?Q?orIDFeLFhriPluvjOS9CqX4U7HQ/E/eeery+5od6PkFfCLGL9RPdmu/OzN+M?=
 =?us-ascii?Q?k/04xY08aMgvTw1664G9I0up7D8Id4UJAL3MIb+GbSb5j5oE56B4TznAoZr0?=
 =?us-ascii?Q?myNU3LeaaTO9+a29GMoe0L0YavxaMRpbF9hZxkzmh7P6TrPOL7vpTbBd6E2d?=
 =?us-ascii?Q?p9H3mzGk9D6Z7S2rtCCZSbRq5MpgGIQBH9lpuaU1p7pw3C1pVsgmI5I0oDfn?=
 =?us-ascii?Q?P2HFNHKahk66jfS+AODiyQhnz7VLLWu9OGBRK+eZIHjnwDlYtXOPFHPubY4G?=
 =?us-ascii?Q?gUUNW4xRe/FY63P+/SD4PN62m/Co2y3CNZUR2mufkChel8m/huS3vvQ7xFza?=
 =?us-ascii?Q?Th32ksJoNcqgR6ybaHuBKNGdHFQRVYOJhQdyabnhanZpgs0fRVOLIl9rc4BV?=
 =?us-ascii?Q?DrxBftztQiCd7tzpgf+MLE6Niu9kP2ZpjiZRvSjGfuKRmk7Q6+sueO/pmvrk?=
 =?us-ascii?Q?wH2c5P21W8Bq+Cmn5uDKoymJSJ2Acnm5Q1VgpdOC6z7ix+WvlUTLs9Pl0IOY?=
 =?us-ascii?Q?LL7PpLh6GEAnlhSAEIaatkrZqpuYiSTnXReOS4BQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0325caa1-0910-43ea-6e8e-08de31b27129
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 14:52:40.6874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vChMyMVHM0SKLSc6mW8aEU/PzBGPrBpvfF0SYZNUOgz6mp7tg5bdRrUUWZjxEIJ+iSrvP2dJhNBp4T2WAMDVuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10172

On Tue, Dec 02, 2025 at 03:55:03PM +0800, Carlos Song wrote:
> Enable DMA mode for SPI IMX in target mode. Disable the word delay feature
> for target mode, because target mode should always keep high performance
> to make sure it can follow the master. Target mode continues to operate in
> dynamic burst mode.
>
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/spi/spi-imx.c | 77 ++++++++++++++++++++++++++++++++-----------
>  1 file changed, 57 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 045f4ffd680a..e37d786a5276 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -264,7 +264,13 @@ static bool spi_imx_can_dma(struct spi_controller *controller, struct spi_device
>  	if (!controller->dma_rx)
>  		return false;
>
> -	if (spi_imx->target_mode)
> +	/*
> +	 * Due to Freescale errata ERR003775 "eCSPI: Burst completion by Chip
> +	 * Select (SS) signal in Slave mode is not functional" burst size must
> +	 * be set exactly to the size of the transfer. This limit SPI transaction
> +	 * with maximum 2^12 bits.
> +	 */
> +	if (transfer->len > MX53_MAX_TRANSFER_BYTES && spi_imx->target_mode)
>  		return false;
>
>  	if (transfer->len < spi_imx->devtype_data->fifo_size)
> @@ -1763,23 +1769,51 @@ static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
>
>  	transfer_timeout = spi_imx_calculate_timeout(spi_imx, transfer->len);
>
> -	/* Wait SDMA to finish the data transfer.*/
> -	time_left = wait_for_completion_timeout(&spi_imx->dma_tx_completion,
> -						transfer_timeout);
> -	if (!time_left) {
> -		dev_err(spi_imx->dev, "I/O Error in DMA TX\n");
> -		dmaengine_terminate_all(controller->dma_tx);
> -		dmaengine_terminate_all(controller->dma_rx);
> -		return -ETIMEDOUT;
> -	}
> +	if (!spi_imx->target_mode) {
> +		/* Wait SDMA to finish the data transfer.*/
> +		time_left = wait_for_completion_timeout(&spi_imx->dma_tx_completion,
> +							transfer_timeout);
> +		if (!time_left) {
> +			dev_err(spi_imx->dev, "I/O Error in DMA TX\n");
> +			dmaengine_terminate_all(controller->dma_tx);
> +			dmaengine_terminate_all(controller->dma_rx);
> +			return -ETIMEDOUT;
> +		}
>
> -	time_left = wait_for_completion_timeout(&spi_imx->dma_rx_completion,
> -						transfer_timeout);
> -	if (!time_left) {
> -		dev_err(&controller->dev, "I/O Error in DMA RX\n");
> -		spi_imx->devtype_data->reset(spi_imx);
> -		dmaengine_terminate_all(controller->dma_rx);
> -		return -ETIMEDOUT;
> +		time_left = wait_for_completion_timeout(&spi_imx->dma_rx_completion,
> +							transfer_timeout);
> +		if (!time_left) {
> +			dev_err(&controller->dev, "I/O Error in DMA RX\n");
> +			spi_imx->devtype_data->reset(spi_imx);
> +			dmaengine_terminate_all(controller->dma_rx);
> +			return -ETIMEDOUT;
> +		}
> +	} else {
> +		spi_imx->target_aborted = false;
> +
> +		if (wait_for_completion_interruptible(&spi_imx->dma_tx_completion) ||
> +		    READ_ONCE(spi_imx->target_aborted)) {
> +			dev_dbg(spi_imx->dev, "I/O Error in DMA TX interrupted\n");
> +			dmaengine_terminate_all(controller->dma_tx);
> +			dmaengine_terminate_all(controller->dma_rx);
> +			return -EINTR;
> +		}
> +
> +		if (wait_for_completion_interruptible(&spi_imx->dma_rx_completion) ||
> +		    READ_ONCE(spi_imx->target_aborted)) {
> +			dev_dbg(spi_imx->dev, "I/O Error in DMA RX interrupted\n");
> +			dmaengine_terminate_all(controller->dma_rx);
> +			return -EINTR;
> +		}
> +
> +		/*
> +		 * ECSPI has a HW issue when works in Target mode, after 64 words
> +		 * writtern to TXFIFO, even TXFIFO becomes empty, ECSPI_TXDATA keeps
> +		 * shift out the last word data, so we have to disable ECSPI when in
> +		 * target mode after the transfer completes.
> +		 */
> +		if (spi_imx->devtype_data->disable)
> +			spi_imx->devtype_data->disable(spi_imx);
>  	}
>
>  	return 0;
> @@ -1902,7 +1936,7 @@ static int spi_imx_dma_package_transfer(struct spi_imx_data *spi_imx,
>  static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
>  				struct spi_transfer *transfer)
>  {
> -	bool word_delay = transfer->word_delay.value != 0;
> +	bool word_delay = transfer->word_delay.value != 0 && !spi_imx->target_mode;
>  	int ret;
>  	int i;
>
> @@ -2108,7 +2142,7 @@ static int spi_imx_transfer_one(struct spi_controller *controller,
>  	while (spi_imx->devtype_data->rx_available(spi_imx))
>  		readl(spi_imx->base + MXC_CSPIRXDATA);
>
> -	if (spi_imx->target_mode)
> +	if (spi_imx->target_mode && !spi_imx->usedma)
>  		return spi_imx_pio_transfer_target(spi, transfer);
>
>  	/*
> @@ -2120,7 +2154,10 @@ static int spi_imx_transfer_one(struct spi_controller *controller,
>  		ret = spi_imx_dma_transfer(spi_imx, transfer);
>  		if (transfer->error & SPI_TRANS_FAIL_NO_START) {
>  			spi_imx->usedma = false;
> -			return spi_imx_pio_transfer(spi, transfer);
> +			if (spi_imx->target_mode)
> +				return spi_imx_pio_transfer_target(spi, transfer);
> +			else
> +				return spi_imx_pio_transfer(spi, transfer);
>  		}
>  		return ret;
>  	}
> --
> 2.34.1
>

