Return-Path: <linux-spi+bounces-11515-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E5CC85C8B
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 16:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA46E3B2683
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 15:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEF0328263;
	Tue, 25 Nov 2025 15:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mnO2H22m"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011071.outbound.protection.outlook.com [40.107.130.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7973017C220;
	Tue, 25 Nov 2025 15:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764084751; cv=fail; b=Z3CIqHMHqX7PR6X4BK4L+NL68WgWYnGpUsuw0VifoGS88cn9FgiRe1eYpegUkaqsaIkghi/mlKCOQmXfshP9HIxKwAlwAomE6PCULBoTvgqi5NJCWyhmEDvxJTKR7PqaojaWf1cAz9yx9IXdMsTt9PB53q9lNSTza+Uy9L78ggg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764084751; c=relaxed/simple;
	bh=eLPTrlX5xHV06QaYhRbRKMfOw8Ri56NCBuGkXf6OVEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OcI8xTpqrPVbJeo5NrEclOv0D7NeKMy4Wepn/32nkSXBLER8yhm3JQumxZDhYT2ohDjo8Sfiz5jOkhwruiTQMp5Tghw3rbDaTvuk2kKI+1J6dVsQuA+A14EZWJWIGgkPju+ja6hOrza+OhWkYNWsko9/UQ0fPCAoiXj4M05vNTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mnO2H22m; arc=fail smtp.client-ip=40.107.130.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pkEdAxiM1g84nldO3A2iYcgDgkOR+nVXAzS63rgjadCTUPzTRvSuX7CIUsqjeNsuuhsJXcD6P07HzGzuHPe/YDM60q9HoFXG45WTFI7vSMg+GZahvt7zmVRuNy/rapn3550KMqFsXo4kjLLkI7DZu7IgGb7guRTtLtAUn9GKijAt/LtzJXI1uPazGlCcWKxBuN7ELM91mOdQVEM8PLrZR/jriQ0rk09iqEYtCMd/gCMN35ykBcwn++GAtzPycOCEjYwPfC00ZRxrwV6/3/s9dU749iD4hZFAHh4VpiqiKr7BDKh7ItdXzUKY07HirLfflBOT9DqCtXPa/xfTieY+nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzGVxEsgKgVco2ykYSBlL8xbt1b3aPYQnx2kvpLQ50Q=;
 b=qw+gcMmDHFnsq+1sc0gYlGBDqeM84S7VfPRJTnKlqPfGlK7CBGhLnwewu+YyFU6w5uhZqesLd8/zBGXIbsWHnyOiwVt8WuuKV8SOrxbFNTXRIJKf5RbZLMJt1eZIox5UKOb8/vKHqWMukPYnCwCBBN4kf14UsgQXk6eV6d+GQr/phV2/wa7B+NqmOdMPM2zSR9A1DzSxLRBdlnLYcSv9KbOPCL3k5EAilpQeeyEQFLup0Ua1RmgSYChAkyf8uzL/L5wU5pE1Z1wmaR3FBtbUuqZQH1CjJDH2yHSoCSKVyH8acpnCs5oYcKFwOgdJjy8NqojjpdaEmQwb8QJRgnaneQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzGVxEsgKgVco2ykYSBlL8xbt1b3aPYQnx2kvpLQ50Q=;
 b=mnO2H22mQDYxIeo7oZhHZjUDlLCh+Ao+Br6ZrpJG7eQ/fRyUTGoY4h7MAOK33IcaqnUtWa+W4PDqliXS+2CnvkEn3LkvH+a/UH1db5pQPhHS3NFjI6eDWG+e5GdSm5T2JBH6+/X/8JC+7aFyDI9OHM3iqza2S0HYHVDqQO17U9pOUOm6Jk5ncP2cVckmnMW3cdpxbVeoKrIc0BpYnemBzFRVBTreZ/MVqzkYkyaL1DJA/joEFY13StjGDQiWKrUWXp2H2gcZQoptNXkoQ6uBYFzKMlrBEj/PBrwQD8yRP1rrJpik7IyKdn2xR7CvNOVuY/EzviBL8saaEoL5/jwF9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DU4PR04MB10433.eurprd04.prod.outlook.com (2603:10a6:10:55f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 15:32:25 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 15:32:25 +0000
Date: Tue, 25 Nov 2025 10:32:16 -0500
From: Frank Li <Frank.li@nxp.com>
To: Carlos Song <carlos.song@nxp.com>
Cc: broonie@kernel.org, hawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] spi: imx: group spi_imx_dma_configure() with
 spi_imx_dma_transfer()
Message-ID: <aSXMAElWzwpT3Fbk@lizhi-Precision-Tower-5810>
References: <20251125100618.2159770-1-carlos.song@nxp.com>
 <20251125100618.2159770-2-carlos.song@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125100618.2159770-2-carlos.song@nxp.com>
X-ClientProxiedBy: PH7PR17CA0049.namprd17.prod.outlook.com
 (2603:10b6:510:325::26) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DU4PR04MB10433:EE_
X-MS-Office365-Filtering-Correlation-Id: 302362b3-06a2-4e02-f10a-08de2c37d5a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Op+o7+oB4AtktZoWTnro+54BPJtc1VxCK28vcOLTU2Xkwz00fqPJTsTGo31q?=
 =?us-ascii?Q?22y3O6Ccim4qG0T0W87karCaUwfC70oeX/Dx08NN3oWK6AW5dhI3EzZ3jNgj?=
 =?us-ascii?Q?DQ8sha6NW9kqakbBrDKTQ8MpgNEJ7PazU34GRVpRbZhaYDcxHsZNDJuN/ZVH?=
 =?us-ascii?Q?x4118aljxBG43x5qo6Uagpz9xjli0HXgE4bXrYP07qce37PG4FZ3Bxv5LSmE?=
 =?us-ascii?Q?phWgllVHih3lFc3/SIv5VJQeLNN8QC5c+yCBOaC62DiAFML7feQKeFgIh6/9?=
 =?us-ascii?Q?/KRT7A2cASq/g0XVDzHDXQNZ40MOQDbcxCpOkd40uRrQuGpn/XEJIkJ3CtC4?=
 =?us-ascii?Q?khTPyqrY/cH4ZKPnn2osm1KrzoKOpmuenNinueYYP5D1RaktfWwRRhdcuwMm?=
 =?us-ascii?Q?nLu2FTY0WgHt24QVEV/4oFm9Afe2N6nFi+F3VXrUUpNOwOP5o8pcdYOkjaH1?=
 =?us-ascii?Q?BZM1cJLcKmXYCPRU8WNivDDeWBMh0rCzYNbldF0SBDIPU/0G7e4Eylp57Jwq?=
 =?us-ascii?Q?kQu8wT8JDy1wfTw6oMb4UyeWeBj1z7vxdsNxudAt5dxd0sVoheGQMw3AkaOv?=
 =?us-ascii?Q?0bsrSkQyrKqFLktzpECLnIbVGxb2YBRAJLRTimDcJMn3GvdPcmSCkFJAIn55?=
 =?us-ascii?Q?deQ1OWdJGmP3EaWcQc2sHjDyp0Qn15/53NvXL6nsDUHTIgy/zo3raBSdDX55?=
 =?us-ascii?Q?xD5205LMVdWSkTLRA4geqzs2luJTyYCROrKGKbZsvh+7Q8CelE1xZs6S6hT+?=
 =?us-ascii?Q?wXeeblXTkUufNjriX7uwiQMsH/eLXaUNnlckRAkVlVOd0QfmTOvVhFItcHQm?=
 =?us-ascii?Q?2xt1T27+U7e8L9kWE4UdIlx62QoZw6+oVkdxbuIRpyvJz2Yn8YsFq+qGGiIs?=
 =?us-ascii?Q?rPr0DzYqZGC2iVcSfEnMAjxx/7FUTM2uq/CRK7UPDNtd0bz8AXLiuGT2RoBT?=
 =?us-ascii?Q?6YTdgjtG58U/amZ1lB661bXkwUP/6tWP5lYwxkdqjENe68h+VWRYt3/dJ09T?=
 =?us-ascii?Q?nM8yoe67Utu8SNwGmyzdHb8e00y+NH+VquYs+38mwkHJ/lccZ7KsOzW0v+zf?=
 =?us-ascii?Q?IWVl5g134eFOrWcJXYiJYC7gXo44N2ZXj8to9KeGCtHpeCin91iU56ZfHQYz?=
 =?us-ascii?Q?5+3gkS8rqiuDCOgLM4paQzGSnhlA8NOtwS0s2ZgFlLT3mr93f17NbpZkMaZD?=
 =?us-ascii?Q?5xPyQkWnrgZ2Yjy8biTQa6b9c7MCNW0NgHXm81vq+kSwpRauk44ngJuqNfrj?=
 =?us-ascii?Q?Si3a2LIZPuciP5pA7/jPSXpna1S7k1T+5XaCSetp5yHt0dwCtDzbNzW9NBQj?=
 =?us-ascii?Q?b6Wgtx4FHDBJSXZ8ICzct7hnE/mGWnLBQsK3ge9AuNjwKfZEW+nNVs2DVn9l?=
 =?us-ascii?Q?UD+hHkmKRc2ErttquJdHd0ispfwA0FaTEOuihe8h788ex5JscrFVTJirFXx8?=
 =?us-ascii?Q?WTrDGCu/KrB/KE/pCmvnQWXAnP8TXzwb/gV4ChqC/F/T5Or42lw5uIDou3WW?=
 =?us-ascii?Q?KuROloA7YYPGmMqAA2euxfwYZh4vwsiKftgW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KdBM49Vh85nxbBSezsnxuylQ5kUfOYiDRAIUjoVxHAWrw02J0OSk9ZTKTKRw?=
 =?us-ascii?Q?RUeb/kc0iLaSaYimRa84Q9CCxNyA67vsmmw6f2q+4kT/2ky6pPkdqwBym/k/?=
 =?us-ascii?Q?ChNfeqN0x55Mxxe/q/mj4ASM5cK7mQGU7R8lP4ENLjLrcNCoj9em8r5euE6e?=
 =?us-ascii?Q?8LhX1arStniDh0LO/KJvr9DRlEnUo9xmsFDWFmfoPdr7Hsdz9nn42kKDREtp?=
 =?us-ascii?Q?c/DMHycBZ5K0Sb5nOfFyZeqZEG/720OhjmZcBOP0yEq7WOeuAVUAb/9C99Nh?=
 =?us-ascii?Q?BcNb+3MXnrP6PTpf5bsEL3rzRHOk0g/bvHR12ERtwxAYtiCiXe+i/umkmuyz?=
 =?us-ascii?Q?vK3wBbB6GFT00HAtXJjQ5F8gUqzJ2zQAynRJuRfd+YcRjj5PHIJZpkArMO3z?=
 =?us-ascii?Q?rg33Bzm3UzZMfGZz5jI08GfxjDmbinQ5EP/p4/64hbaodT6H89qwHI0KONG0?=
 =?us-ascii?Q?Fx+mSYCT2UJMOKTBjAjAqGyMojeJICQhjQTb+sm0sbwwT7orxDGVcXUuezZ6?=
 =?us-ascii?Q?7PEPHfJHb44NmociELFntYuAC8icsn3VAkVJQovO3PyBndlfGp31Q08PnTys?=
 =?us-ascii?Q?1pskGeok9x+KbgSW7hYnlr5ebC/pmx56gI+JpjBcXM6CFYmZrHu4vaE/mr9W?=
 =?us-ascii?Q?Vrfzp4sMW/dx+JB21LQ4zSWL14iHsGtMH3M0gCo3MyfKtUG8o+OSrxl2JLob?=
 =?us-ascii?Q?jYYgZdzVhN5UGb4x6ScPRw3kT/WemBzAxQUvUWDEmYwRjkB9AkBPZSe0lq/+?=
 =?us-ascii?Q?uVN2BXvHZqu+MzN3ZQFVQamLDLJ92GB6nd0yEU/ZSin0wyoOyQidBkr+yz3h?=
 =?us-ascii?Q?zH2Yqw1olra8x2h8t3QI/YdEU/dWfqMAvyJKeMPmJrvBvYhrrocZrS2gQqeS?=
 =?us-ascii?Q?vNgFaCc+n02Rk5YWI2MfgHKgYx6zgOHGBosIrMlJKJ/h3EUe/AQwLPvewBlx?=
 =?us-ascii?Q?zwwOrfkHfbKgZgh43gRCUorb07JQZQU0RtnlBnGZp38WW9UYeCB+/Td2fhmQ?=
 =?us-ascii?Q?37RdH7swI3pKtGhE2TYUgzIrF+jpeQ6OETcYK338oHuv+SGnI0tuaF2SUb0D?=
 =?us-ascii?Q?lsHf4wUdtz0NcYYMvz6hfEoeNSQ8gAYZXmQnFqbFIV+7OjT+1XxJZu9Bypw9?=
 =?us-ascii?Q?X6xvTVQPxuPR0C8KV0eDosr00vZV0Yd1zvhfirgAcwEswr2riqMg8mqWK4iK?=
 =?us-ascii?Q?fWl4RltBXQz6W+zm5eTNxDwdLhuydzD6+TVBKvLIBoElwnV+nCl/IZRTzgTZ?=
 =?us-ascii?Q?3/8fUhZc9Djl5qkZwWJrBQeDuRLvZmKdmCXXPNJbM4Dz1FqFRaVfgK9Vp0ZE?=
 =?us-ascii?Q?zC9XcxQfUt11VAaBIYu2bjXGXdw1xkdkEtHWsud0kIhS18ML16WekqchraxK?=
 =?us-ascii?Q?Si7rGGpL8WPs8M3zeD8wiACJqoydPo+1BtZ//On5DME992dtCecdiPyJhSmr?=
 =?us-ascii?Q?xdh9sIEwAHNESQGE0NlaZC7RNsLb/PYTYQ4AALpO2oWAHQcTmspKFS6sWBiy?=
 =?us-ascii?Q?Gt/aa7Zub4z3AyQH5uMF8ZqeOfLBsq+XGX+5abFFS3IOwf0LFvv+9lX6Biyk?=
 =?us-ascii?Q?sDxsrqBONv00HBCK1i6wCK6BsMn55vbP98QSh37t?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 302362b3-06a2-4e02-f10a-08de2c37d5a5
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 15:32:25.5417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CtCjHfuIoxUfB1Q1GNNiSHmMfI6NUp/pvkniVdtxHXbb+CHYYguV8eoCKxnbz3NbsfdyVNPHgLT3my7kg4b7Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10433

On Tue, Nov 25, 2025 at 06:06:13PM +0800, Carlos Song wrote:
> Relocate spi_imx_dma_configure() next to spi_imx_dma_transfer() so that
> all DMA-related functions are grouped together for better readability.
> No functional changes.
>
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/spi/spi-imx.c | 88 +++++++++++++++++++++----------------------
>  1 file changed, 44 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index b8b79bb7fec3..e78e02a84b50 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -1282,50 +1282,6 @@ static irqreturn_t spi_imx_isr(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>
> -static int spi_imx_dma_configure(struct spi_controller *controller)
> -{
> -	int ret;
> -	enum dma_slave_buswidth buswidth;
> -	struct dma_slave_config rx = {}, tx = {};
> -	struct spi_imx_data *spi_imx = spi_controller_get_devdata(controller);
> -
> -	switch (spi_imx_bytes_per_word(spi_imx->bits_per_word)) {
> -	case 4:
> -		buswidth = DMA_SLAVE_BUSWIDTH_4_BYTES;
> -		break;
> -	case 2:
> -		buswidth = DMA_SLAVE_BUSWIDTH_2_BYTES;
> -		break;
> -	case 1:
> -		buswidth = DMA_SLAVE_BUSWIDTH_1_BYTE;
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> -
> -	tx.direction = DMA_MEM_TO_DEV;
> -	tx.dst_addr = spi_imx->base_phys + MXC_CSPITXDATA;
> -	tx.dst_addr_width = buswidth;
> -	tx.dst_maxburst = spi_imx->wml;
> -	ret = dmaengine_slave_config(controller->dma_tx, &tx);
> -	if (ret) {
> -		dev_err(spi_imx->dev, "TX dma configuration failed with %d\n", ret);
> -		return ret;
> -	}
> -
> -	rx.direction = DMA_DEV_TO_MEM;
> -	rx.src_addr = spi_imx->base_phys + MXC_CSPIRXDATA;
> -	rx.src_addr_width = buswidth;
> -	rx.src_maxburst = spi_imx->wml;
> -	ret = dmaengine_slave_config(controller->dma_rx, &rx);
> -	if (ret) {
> -		dev_err(spi_imx->dev, "RX dma configuration failed with %d\n", ret);
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
>  static int spi_imx_setupxfer(struct spi_device *spi,
>  				 struct spi_transfer *t)
>  {
> @@ -1481,6 +1437,50 @@ static int spi_imx_calculate_timeout(struct spi_imx_data *spi_imx, int size)
>  	return secs_to_jiffies(2 * timeout);
>  }
>
> +static int spi_imx_dma_configure(struct spi_controller *controller)
> +{
> +	int ret;
> +	enum dma_slave_buswidth buswidth;
> +	struct dma_slave_config rx = {}, tx = {};
> +	struct spi_imx_data *spi_imx = spi_controller_get_devdata(controller);
> +
> +	switch (spi_imx_bytes_per_word(spi_imx->bits_per_word)) {
> +	case 4:
> +		buswidth = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +		break;
> +	case 2:
> +		buswidth = DMA_SLAVE_BUSWIDTH_2_BYTES;
> +		break;
> +	case 1:
> +		buswidth = DMA_SLAVE_BUSWIDTH_1_BYTE;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	tx.direction = DMA_MEM_TO_DEV;
> +	tx.dst_addr = spi_imx->base_phys + MXC_CSPITXDATA;
> +	tx.dst_addr_width = buswidth;
> +	tx.dst_maxburst = spi_imx->wml;
> +	ret = dmaengine_slave_config(controller->dma_tx, &tx);
> +	if (ret) {
> +		dev_err(spi_imx->dev, "TX dma configuration failed with %d\n", ret);
> +		return ret;
> +	}
> +
> +	rx.direction = DMA_DEV_TO_MEM;
> +	rx.src_addr = spi_imx->base_phys + MXC_CSPIRXDATA;
> +	rx.src_addr_width = buswidth;
> +	rx.src_maxburst = spi_imx->wml;
> +	ret = dmaengine_slave_config(controller->dma_rx, &rx);
> +	if (ret) {
> +		dev_err(spi_imx->dev, "RX dma configuration failed with %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
>  				struct spi_transfer *transfer)
>  {
> --
> 2.34.1
>

