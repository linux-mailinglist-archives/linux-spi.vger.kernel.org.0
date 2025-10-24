Return-Path: <linux-spi+bounces-10825-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF318C06FB1
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 17:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A44FE1882C18
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 15:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D633226CF6;
	Fri, 24 Oct 2025 15:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RjMb8aKJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013005.outbound.protection.outlook.com [52.101.83.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E12261393;
	Fri, 24 Oct 2025 15:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761319852; cv=fail; b=OVPnj618XgYtIKSk1+HE22q2CqrSfMBhO2PAcd1sPGRucaEGplkWHh11Z36KsjcdBIcjhG7iFNg+UlPfCmhPJ0r62kVDeYU/Y/WINnQ/L1jmo9vQZjLPIveAST8VOQZOVpU71rY+JH6YWFxedYT+t8/mwIC7VPD7/rbmWqvowVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761319852; c=relaxed/simple;
	bh=tsf3xnTzZ9jUkAJA5+t7PRvLYE+3ebj58WpQ+I7IKJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BmPITDnrB9LGeuee4Ha9mQnrwLeCEXN3f3KEVWhF2pFB/B+B6MFJf56ybV8cA7qBByWBsLgOL0G7yUrBdGzSdm4JFZElAoHMK8FRV0qt3JDCLcDV5zpjdZtLkwz9JW44jfA2j6hlXTk/KWgwbR+QnI/j8rQwc49pqFID4UUARdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RjMb8aKJ; arc=fail smtp.client-ip=52.101.83.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qO6Z61ivKyDhGUKEGZkTFIbi9341wJ04s69o9aE0OEpOV5fJ0U12cGqp8Xtof4HL/BG3tPjXThBGuCVYtAeT9auVQcSoDdQPZLVwlecSRJxE4oSwVOH4TQx1DjtPmdZBtRehKblplHX1mKbAll7v7V5PvGb/wB7tLwkslU9FXhl/M19fgSAcZpDi6iaCmNZ1BZpcOz64HopHNGHGddsDBpbVhb6jYUbgM7HEGRzmoRoeofsa6w93qjI4c/RRyqsawpIgcjcWwfUYcHU2NQij+E4JC3U0ucMRDq/BUTeSz5CY3ytNay69gHeWHOWyUPx/TJI3/owSz2MPqE1FKE4xoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AaJlXldRQdUZVrDPVz4R5Iffk/6ZTr097Ec3PdGEns=;
 b=dIh6Ol9Q6KSAHn8vaypcldNrietSfiioqCJ3A5nG31yc1tc8sPzQ8pKGfuSw11ToSnS+xnDtAQDKw0eSMbHMJWVkS+jNf0GWE7+Tf+WqkfTmPbgRo0e01y9yktvOsnmONL6EDHmhKpQttLFQSxRGyMEkdyHULwqdOaoayPbd8Kl6SMYdg2LFEjADY9Ta5wFKqAk8gcTJ/LDSewH0Vj3LQElT5Idhv0LNLR/SM1S1eqylfxEUEHygzMG2V0eHjBnuB3PxzO6nF2YrTbQVRreXdHGruPVwBHyoNOB6YRBmErzR+dr/rWecRGDgXqSIXVicCPYXCmC/c15+7f7SINjNUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AaJlXldRQdUZVrDPVz4R5Iffk/6ZTr097Ec3PdGEns=;
 b=RjMb8aKJESvPHLdqD5wEz8iBSX39KgkNWh6Qee2/+4mBmE7Jx6cznmEdU5DppJ9Fs/+MhiVOel3TfS2vdpJeXFO/FtvNBTuvEraohFAMTg2U9/94cnlhc4Ab4TalkoHzannRZN89I5kRkmqvO+ZxMoiAs6KVNGd7jI3GHQ1hg8HAh/zjn6y/sUOnJkXrVCsAy3D1c4rQE9vHc1W8I0LysCxVAyVRymr1mkSbaAkYeMH0iyeYtyYKA08wvf7w7YglwqkyFhnUMkOBXVPQX0QiCEjPJMntgvHCnqb84uGrV0xUj/4QVGK72hxrVx0Ofa9Qnq6rgXzTr/b7yuo9WNT+mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DU2PR04MB8856.eurprd04.prod.outlook.com (2603:10a6:10:2e3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 15:30:46 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 15:30:46 +0000
Date: Fri, 24 Oct 2025 11:30:39 -0400
From: Frank Li <Frank.li@nxp.com>
To: carlos.song@nxp.com
Cc: broonie@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: imx: support SPI target PIO mode for IMX51_ECSPI
Message-ID: <aPubn5XQCHDLvsHq@lizhi-Precision-Tower-5810>
References: <20251024055243.408461-1-carlos.song@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024055243.408461-1-carlos.song@nxp.com>
X-ClientProxiedBy: PH0PR07CA0031.namprd07.prod.outlook.com
 (2603:10b6:510:e::6) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DU2PR04MB8856:EE_
X-MS-Office365-Filtering-Correlation-Id: 59ce79c2-d6a7-47da-aafa-08de13124d6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DfMZvDmrapez4Ldu3KHF6F1nQKdJte4Kk77VzwTayIbwCFbPDisE4HjONNzo?=
 =?us-ascii?Q?jHNG8Vc8p/DDthqNIcQaWmLDnWqDxP8dPf94DRHyVk53IvOwB7l6TzWfCMXs?=
 =?us-ascii?Q?0Z0t1YB4dzTmDZBEGeBdTbR4vW5o8yYLjhwF9koRTg7qC/As7E7X2h1pimUp?=
 =?us-ascii?Q?j1keL8rp5eDE38/GzhzvQUGHhWaH/g3IEEDuR2WQ0tb6ha3w//87tmi+toAc?=
 =?us-ascii?Q?sewS//hYHGQsD6jjHwjLRz1LfQ/BAw5pmAVvmUfR0Og1CKun0/jVbVrUoUEd?=
 =?us-ascii?Q?/ZkGOm5iMA5+FMa0rJXZrVDe5JMnhzHj7jJ5r4VfS3mAaP2vsI24Wj/T4HX5?=
 =?us-ascii?Q?XpF+T3vxKUQN74pcC6Lk3rWGwVtHrkG2Bn3mgDrqjeFxECIC61vZbZlPH4vq?=
 =?us-ascii?Q?KuaAGpeWKKO+kfgUgfjb3MzSURd4X+JZ0eVLmU9PAQjnmn39U0M3OnIl14jG?=
 =?us-ascii?Q?DDQFy6Ltjd+5Hz59hMRt7z20qntwe5YqcvUOKFWfPOlHGt0DlmEvY55iataB?=
 =?us-ascii?Q?Ce3fW9fWffGqXP3ey5hsgfjGhuAdQkvv94DF2U+wfqCJA8jGgwVzmLbFPV9e?=
 =?us-ascii?Q?4c/P2qCujK0O20E/URQNtE6idnXQ3QN00a0W8szkscf/Ja7TJQS8a1Xjn6VN?=
 =?us-ascii?Q?jkc7zvtRJfFoBIxkdViFHm8oSqZIhSmzzP4rAP3ylwAuZ+VGDaLpeEO60f6d?=
 =?us-ascii?Q?GkDAHO/KtJiLgtduMC2ZWVoJwBwT5YdKvlv80SVnSVfGI6eOkAj0TlIOulVJ?=
 =?us-ascii?Q?u9HfE++oavc39nJSi9Xse/hgoB6a6vlSYXKR8gbwNalPvlVSUEbjJXo1mOM7?=
 =?us-ascii?Q?Y+2Bzd3hL17AiD0HovMWP3oF5OH+ACIyawLMFzn8TyL16cAosD8DX5cGXp4u?=
 =?us-ascii?Q?iGnjxWVO2h+JuROfJImyyXmBpRmfgKJHdk9UI4WpETHuvBRJry6gP6U99PKC?=
 =?us-ascii?Q?cUCsSSvw1oo9nukZhq41izdS3BeEcQnJDlEobfa5Uy9loCM0BzSbyGJxn97b?=
 =?us-ascii?Q?ktUaGPvVG2FbHvImuhOoFSaqaJmfKT/nP92DqyyzmaawLdFxmARFxz1Ri6Ix?=
 =?us-ascii?Q?klWrbNI+gx9+xFVOyl3zYxzaZq71w5/k0Om1Lq4LaMHjTIaK0UOdEtmy08fZ?=
 =?us-ascii?Q?kkaQXz9TQwKn5zWzoHMb9HqSrcKysfYG4d/tjlqJSb663BX945eexcMPxyoB?=
 =?us-ascii?Q?RI5Rdut0/lw9s52btIt+j/0WVhBwJU91gW/PezL2s65HU3MHZo1uKMwetZjL?=
 =?us-ascii?Q?bcpZ521XbpxrRrj3j2hrORG/ZAkPO2afR8NUsbcL3GSUltPVuo5UKotyFIZf?=
 =?us-ascii?Q?5BYK7Juu6rxBheQS3fll+z5UB87GSRtaqE+0Dpydn3EIhrQ82QV9l1wz5uf/?=
 =?us-ascii?Q?e3B1j+6dN9/cQxU3mac7ktiqgL1QGFT7VXlq9YQ7YcQNW02Y8yHVIgm+nf3I?=
 =?us-ascii?Q?oGvHEXXqu0n+MZgOx0/TMmAou9Lf8nGbCXQqMfvO08IXitPpVwN7nNm5lyRM?=
 =?us-ascii?Q?efYzyfCJOXCwKbmFw1Zwr2JgORxWkD7vOJ5E?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tVcFgkMzt2TsE2LBPmKHdrmiEwfMS6oMFCuWWJqMg197IismQSVZGXRw40gv?=
 =?us-ascii?Q?QNN78TVjFq480mfcCUJLLk9/YnvtgVRm4yxTAzQ2Qbzi+mlDRU5L0JhIoTxG?=
 =?us-ascii?Q?p3pTkUBXzzNUOEyC8rCVQyMYePqrTIBUq2NFUbkkpujJbfJTymJCCsccXFUP?=
 =?us-ascii?Q?Pa/o0rFspLSkQ1JnHw0Pdh6dsGMSye0tkkTWFTB/Xpd5uXKZiGayXRl+3s+Z?=
 =?us-ascii?Q?QKRt594JS3i6amgp1JlZpGPMLjTRJ2ilGN17Ukwsdu6QYsH2x/FAN0GX5p9t?=
 =?us-ascii?Q?R3qQ4nsJqw5AJF7qrSJDifUoiURXPWaEyquFq/TIbjAPE+4pXG91DlEgjOdB?=
 =?us-ascii?Q?BR+ogWzUqeImfaNoYQ3HCytgKRhkSz9XGjNJJbLChVCSD2zGpVy8Hok9HDkq?=
 =?us-ascii?Q?mHC10ZY06CpN4TPohF8THBZ7Xu5Wcskw9lUbIfRVtHlIITm2EnmU1SdeTtMl?=
 =?us-ascii?Q?cTei94k4ateKGSq3ThTdtTvuLpv7HMteoIo3Tdd8bJ6GBtm82QezXpcNYRro?=
 =?us-ascii?Q?KLQ+f2EcPqOA5gC7bV/RTrLP+qFi1sC9m5KUM8iil4oEMxC9i7r/PIPfvq7z?=
 =?us-ascii?Q?ipEXHbyzAZ/wURzQoEmnz+hKHwt4MF1CBjLVUuu0U/97njTqvn3scSRIiLxI?=
 =?us-ascii?Q?9Y3jGSCIp84BUlA7ykDxrVUzvhQ5eBKLI+tqJT+ZkeV1uxe6utNigBV9ON/o?=
 =?us-ascii?Q?c0mQQE4Jmez2On4M5oRmICwVcqnbHp1UVbCwi2KARs0w7ZViJB6ptr+gCbeE?=
 =?us-ascii?Q?VwMLt7hGOIvJewMNnOoOZm2pshpmrPIK26ZhcHK6AkQsS4xdmhAqVlb/Aa/A?=
 =?us-ascii?Q?WkS7YAdZGRIhpo9yE/oZBcLDa+WdnM5BO4W5BBkj3t902c9s8KBEMRpvkYtL?=
 =?us-ascii?Q?BroKQdR4W2pHYEqMra41rfTg9J3KmNDWZYmfkKIj6HSGgUSfsAaZPXoykoj8?=
 =?us-ascii?Q?Rvd0Rc8od74CDfTqDlLCEw0Ahbne8cwlpXHqp032yUU5Ggd6YlprPKG5kUr1?=
 =?us-ascii?Q?3ilgD04y2QKo8e1kXjwK5Is/sWBTZChxDQiXlkGk6/GtHinBYgWyvHob2DAx?=
 =?us-ascii?Q?xWM/psvKWYU9mryXRvLS6atFQelSbj5QXfN+Ue9f7vGYlvAw2JcdWFBgOHIr?=
 =?us-ascii?Q?l1RVkj5N5dWP9GiOCbAJu2UZwFEay62Y8CeVrfs6icWKYnNYjdjUTp4JZQob?=
 =?us-ascii?Q?ttFLEQGRZZAkN9vqxTgpSsKO7JALPxB+Z9H/CuFSR/P0WVCjaVwzd2eg+O8X?=
 =?us-ascii?Q?1dtLDvHIKFp5DymeK6aucEP90TPgRz269xq3CfXAibu+WVZMhxsR1VhAyc01?=
 =?us-ascii?Q?X7WDgVmpriBB7kjlMsktywpk+pq5ZC/F1oFrSgZq6oabh7FjtdAND/p1h4Nl?=
 =?us-ascii?Q?296v99fO1Hza6GUWj5kC/qqin74xAJp7KmKcJ7W+q55cCT9XgMRN/1CV2TNu?=
 =?us-ascii?Q?6TgikXuxsQ2sqngwUt5OmsaTGDLCD/m1JFkRCbXo3Vr/1FR/EiJVJFLm69aU?=
 =?us-ascii?Q?elCr93sIVm1/DXW7k7vvBrRZqveHDTKoe1TY3Nm2dk71GTGWOoYM04Irk3Zc?=
 =?us-ascii?Q?xjnN9Dp8Qs4LeAanhDetDoOWkWR2uIRG/4SUZlXm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ce79c2-d6a7-47da-aafa-08de13124d6f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 15:30:46.5011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bR7SI9iZ0mTnzOFZBZVhGSN9YAcuHnPTiURlw3dKsjsQ0w/PSbmpiElmDzeThSNF8juDUQYmUxnhCNHxIYKg2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8856

On Fri, Oct 24, 2025 at 01:52:43PM +0800, carlos.song@nxp.com wrote:
> From: Carlos Song <carlos.song@nxp.com>
>
> IMX51_ECSPI and IMX53_ECSPI both has target mode, but now PIO target mode
> is only supported for IMX53_ECSPI.
>
> Support target PIO mode for IMX51_ECSPI. It can share the same functions
> for data transmission and reception in target mode with IMX53_ECSPI. So
> remove target mode restriction only for IMX53_ECSPI and move target max
> transfer len to devtype_data of IMX53_ECSPI and IMX51_ECSPI to improve
> readability.

Look like whole patch have not touch PIO mode and DMA mode at all.

spi: imx: add i.MX51 ECSPI target mode support.

ECSPI in i.MX51 and i.MX53 support target mode. Current code only support
i.MX53. Remove is_imx53_ecspi() check for target mode to support i.MX51.


Add target_max_transfer_bytes should be new patch. Any difference between
SoCs? if all the same, needn't this movement.

Frank
>
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> ---
>  drivers/spi/spi-imx.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 6eb4bfb7be4a..cd40db61d8d1 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -85,6 +85,7 @@ struct spi_imx_devtype_data {
>  	void (*disable)(struct spi_imx_data *spi_imx);
>  	bool has_dmamode;
>  	bool has_targetmode;
> +	int target_max_transfer_bytes;
>  	unsigned int fifo_size;
>  	bool dynamic_burst;
>  	/*
> @@ -594,7 +595,7 @@ static int mx51_ecspi_prepare_message(struct spi_imx_data *spi_imx,
>  	 * is not functional for imx53 Soc, config SPI burst completed when
>  	 * BURST_LENGTH + 1 bits are received
>  	 */
> -	if (spi_imx->target_mode && is_imx53_ecspi(spi_imx))
> +	if (spi_imx->target_mode)
>  		cfg &= ~MX51_ECSPI_CONFIG_SBBCTRL(channel);
>  	else
>  		cfg |= MX51_ECSPI_CONFIG_SBBCTRL(channel);
> @@ -682,7 +683,7 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
>
>  	/* Clear BL field and set the right value */
>  	ctrl &= ~MX51_ECSPI_CTRL_BL_MASK;
> -	if (spi_imx->target_mode && is_imx53_ecspi(spi_imx))
> +	if (spi_imx->target_mode)
>  		ctrl |= (spi_imx->target_burst * 8 - 1)
>  			<< MX51_ECSPI_CTRL_BL_OFFSET;
>  	else {
> @@ -1140,6 +1141,7 @@ static struct spi_imx_devtype_data imx51_ecspi_devtype_data = {
>  	.has_dmamode = true,
>  	.dynamic_burst = true,
>  	.has_targetmode = true,
> +	.target_max_transfer_bytes = MX53_MAX_TRANSFER_BYTES,
>  	.disable = mx51_ecspi_disable,
>  	.devtype = IMX51_ECSPI,
>  };
> @@ -1154,6 +1156,7 @@ static struct spi_imx_devtype_data imx53_ecspi_devtype_data = {
>  	.fifo_size = 64,
>  	.has_dmamode = true,
>  	.has_targetmode = true,
> +	.target_max_transfer_bytes = MX53_MAX_TRANSFER_BYTES,
>  	.disable = mx51_ecspi_disable,
>  	.devtype = IMX53_ECSPI,
>  };
> @@ -1170,6 +1173,7 @@ static struct spi_imx_devtype_data imx6ul_ecspi_devtype_data = {
>  	.has_dmamode = true,
>  	.dynamic_burst = true,
>  	.has_targetmode = true,
> +	.target_max_transfer_bytes = MX53_MAX_TRANSFER_BYTES,
>  	.tx_glitch_fixed = true,
>  	.disable = mx51_ecspi_disable,
>  	.devtype = IMX51_ECSPI,
> @@ -1375,7 +1379,7 @@ static int spi_imx_setupxfer(struct spi_device *spi,
>  	spi_imx->rx_only = ((t->tx_buf == NULL)
>  			|| (t->tx_buf == spi->controller->dummy_tx));
>
> -	if (is_imx53_ecspi(spi_imx) && spi_imx->target_mode) {
> +	if (spi_imx->target_mode) {
>  		spi_imx->rx = mx53_ecspi_rx_target;
>  		spi_imx->tx = mx53_ecspi_tx_target;
>  		spi_imx->target_burst = t->len;
> @@ -1649,8 +1653,7 @@ static int spi_imx_pio_transfer_target(struct spi_device *spi,
>  	struct spi_imx_data *spi_imx = spi_controller_get_devdata(spi->controller);
>  	int ret = 0;
>
> -	if (is_imx53_ecspi(spi_imx) &&
> -	    transfer->len > MX53_MAX_TRANSFER_BYTES) {
> +	if (transfer->len > spi_imx->devtype_data->target_max_transfer_bytes) {
>  		dev_err(&spi->dev, "Transaction too big, max size is %d bytes\n",
>  			MX53_MAX_TRANSFER_BYTES);
>  		return -EMSGSIZE;
> --
> 2.34.1
>

