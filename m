Return-Path: <linux-spi+bounces-10799-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E12C03DBC
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 01:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 910654F0F28
	for <lists+linux-spi@lfdr.de>; Thu, 23 Oct 2025 23:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4492E36F4;
	Thu, 23 Oct 2025 23:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gfSQgDZE"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013059.outbound.protection.outlook.com [52.101.72.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7082E2F13;
	Thu, 23 Oct 2025 23:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761262450; cv=fail; b=gerKRhjchy696601iA2ZYzwkGMxV3Sfgm1wRfvYfcUcuaX6eCgSESHSIrfAEP3B+lAxrtA+rYqeCrlunerE2D94yJ5rCTkFlHwRar52pW1F1LCsY8VYK2Cro2Ladb5GRplg4EmeHH/zGq46IhdPf+b8chdnzd8O+lD9jbcAd8Lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761262450; c=relaxed/simple;
	bh=2ximbmmY0WOxzLlvklKVl0nYrzh0zZ5qzA0dbzae2aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eCCQv7mWr4vM2wXkZ2P7f1Rg4bb3xPCw9wgxYVPbgtb0x2D7Ug82xFEYEkq2GuFstCatmfkP3Gq6xEe3IDPeca4yNhGpHolprVtmGozRH/mNchWhkxDCi9s9Ck+YBEwHzzW9Ebo4xfyyytsl/gi7GrCN7SSZdCiV2vrmqzuw+Lc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gfSQgDZE; arc=fail smtp.client-ip=52.101.72.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iYDlppPVqZ7H5RpG5FiSXFnGNLeDHa+tQLEQnv4lvI3ceImoCDfUc+MGy3UNG6B9jqo0u+W6QTqfyese0m0IckrbEticTEWflXSTiMDhmDa5Bvm6fVkaEz0Sp/vNP6RAA+Q2+e/mbc5Apgi8326jitoP7CDp1Ea+eWCEJuejG+XfjgSq0ncqlz2/ovaCMDYcA/Rn+IgG9HGnjlfvY/5m5EFSxdiM2LXBp7X+sMj83ADDlfLLtuAIBHdRGfLHbbkn0BiAcxfXXzREx40b94Y43hDKmj+21KyCLdNK2qSLMxFx70NZX8XRURv8RJ5kHsTslA0JE7vvbjIKLNk6uW388Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zymQpUiHZZq74i5p0DNI35gtFPuFqRiHkNLWn9pgaJk=;
 b=NRqF68OMjy7p4nbS3xwm4x140fU6GSs8RKmqgQBP9Xk2l4vulD5SagtYUWLNpBCycu7Nw0Nasm/Wm8hTwGOzIu9+x4NWhfZx0ZtdwcfXFImYAmxYzYifk9rs3R+XQYtTW1QZZGfC328e/ZGIy5kon2LrbyonG9j+7fc2+/F5RykVCQ2yhDmepUh3RhyW8Lf0MgBsEN9qzDw7lhZkOhhTSkV5NLOpS3PWmPNDmqs/sWyYfoAZSd/AFttgkB8PJF9SXxcevLeNDrtWpmhIzJZkCVe06AmH5ReyYUbXn8kpNo0MZ8ah08KYY5j6xcJyRJwV20m/o1/yYULahCHfsqvXng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zymQpUiHZZq74i5p0DNI35gtFPuFqRiHkNLWn9pgaJk=;
 b=gfSQgDZEyWnb9D3wCGX1zxSRIudlfgDDJT8becErEvnZhrEb/2SfM9majMpwFtCduhPR87/yh1pcFgziXaepJiMrvzPemMPBczJIlibaXp3h9M5/vLh9Om3WcRKC3HjkXIZa2QKwP76EzETJ17PTl2bkbIkXtoaZ6TCkboezUZgQUtxmVltYFmWcs4SpXOGhjUg//J5Y6btn40NqmMp2BAGyqGk99SXAaOfOKdnwX+HJa1EkgdfRK3ajtmcOnrtCKK8zD2tZXgEAyYMx7ha9EXaO8jn6zAIZ+aCQNV94/rYXqJEG3INMaEiKmMahvmfG5yYpEmfc4AvxyG396Bb9Bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM7PR04MB6806.eurprd04.prod.outlook.com (2603:10a6:20b:103::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 23:34:05 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 23:34:05 +0000
Date: Thu, 23 Oct 2025 19:33:58 -0400
From: Frank Li <Frank.li@nxp.com>
To: Alex Elder <elder@riscstar.com>
Cc: han.xu@nxp.com, broonie@kernel.org, dlan@gentoo.org,
	guodong@riscstar.com, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/9] spi: fsl-qspi: switch predicates to bool
Message-ID: <aPq7ZnKrxbokwHxP@lizhi-Precision-Tower-5810>
References: <20251023175922.528868-1-elder@riscstar.com>
 <20251023175922.528868-5-elder@riscstar.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023175922.528868-5-elder@riscstar.com>
X-ClientProxiedBy: PH7P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::24) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM7PR04MB6806:EE_
X-MS-Office365-Filtering-Correlation-Id: f34e8804-1180-41e4-cf83-08de128ca79e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FP4TYPw6ZaQhuwsPNeLwABAAD8A6IhrBa5iLG7gQs4/QNIULDHPRkW3phboy?=
 =?us-ascii?Q?Xma6FmPN27gG5tzjzt9j+oSJd33h4Mf4nw+D4ZV1NYLuHrAl04XqBbVupWyw?=
 =?us-ascii?Q?Gr3FF4xPu6RkDEBQ+YfYGz4yXokpMKx5CiIrOPqbokDa4nU0k0ViHD2cxpLf?=
 =?us-ascii?Q?X0xx8vWoZaHVA+vNOC1veDZSJn3bsQhaxrfKkR1k/KscjF9U4/wEjsT++ziG?=
 =?us-ascii?Q?tR52Rq+9vmXMcDUMbQ2NvkkTJkn/xFN8Rp4QrXEKxWoSSK+iKxsSp7QDZKmi?=
 =?us-ascii?Q?IqQmBmlFx2Fui3/Ngy7jVTNGSn9qcWluiZWh54nTyfaRHo070shV5l/vGfFF?=
 =?us-ascii?Q?Yzdg2nOFRsjZ/OJbrC7WMVkH8uU6ON4nmwSW4le1ltw+6IG5QuX5DRTqm1Uu?=
 =?us-ascii?Q?Y5m1PuHlrE6TXED4qL8WHOC6t28WxBh7hDdqVqqgKegNXIO6t/3+hiReHBqN?=
 =?us-ascii?Q?vnmbPwBCGE0r6YykNUMWvguVdtchgLRqo7wiwxSONLy8r+qriAiPUwenEiXP?=
 =?us-ascii?Q?xka29mvK+zZgyvj3HypR327THNAVzE3As8BwJ2JKkeQ/1uMsLKXXIqyCpGwB?=
 =?us-ascii?Q?Jb7YderGyrCO3KIqdzreWzwexKYFpx1BhaB+md6RnVX0HdT+Z/jGuqpMVOZD?=
 =?us-ascii?Q?fWhW5U4rClNx/ZQmOTLE71X0f/ZFW3qND3aYvBWYvDNgtSi2dh7ajreT21r8?=
 =?us-ascii?Q?hfdEha0wzS0Sjq0EnHRXMBUci7dnU3Pf0AWW2q+GVmi5jxZ957kH8fgeGGM6?=
 =?us-ascii?Q?0O+Agkb5/+24AVKVn2EMI2pm+x0/WdTUe1HEHr2bm31hDCcP3zoRwx+Ele5w?=
 =?us-ascii?Q?rUEXdrTYiG0Fu/uIVP7uqYqbh/vYFOcHkBBYbGHN6xGXoRqtJgYLzfcM71GF?=
 =?us-ascii?Q?puZ5KJQ5rXO92XYj2jSfnduSTAImEHtwsjuD7xiJyO7N/Degl2o3hD8CWU0G?=
 =?us-ascii?Q?SN8Fs8Mylam/TQxz0j8Z2Q4TpZblypOepEZwofKScgiR+TalbU6mt/dXib5x?=
 =?us-ascii?Q?XRBhweFSTzmvV8eWI0TOC7stm9CbeeHTbqkBqSo2d9iBhHvfpLbI6l4uT1oc?=
 =?us-ascii?Q?8fCgjANZq8O28RsibeI8iVn/W/9MSfPh85jxN+HVgrNtgLgMFOBRux/U1zMQ?=
 =?us-ascii?Q?sX6b452y8NiF6cEWUUCdrOTajBPfVU6JT+ip8h6qXmaAWWlF4LQbhxY3E+6G?=
 =?us-ascii?Q?R+4ai0CeKfHQ+mWYo5CAJV/1QrYGi/HpEPmH3ekLp1Pl2brsu9ZezMh66jNY?=
 =?us-ascii?Q?5+Wqaecf1AyfozDUT5fkCV6a1Szcu8+x4FJ1EZfOamKJ1Wt1vp/OJcwbGKOk?=
 =?us-ascii?Q?bocKrWS1/2HoNsMzNxfFqz3xaYrEDfpDbjRJfmsFc7kdvJalcajtz8ODchg+?=
 =?us-ascii?Q?aive6iEW72PaPkj2Xlnh4SCMkKFAiEUuCntog6XMLM9Tjc3gW3ufTR8OMZ1b?=
 =?us-ascii?Q?iPvfZP6Bgyb5lC7FGq17MmFoDb2Nn0Rnf5LxT8qN2BbKtaXwwfp0URid8bOD?=
 =?us-ascii?Q?+mDutdfGNNMuWyEujIk7vDpb+olFECQ5hoNf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JOEEjxVi03m7AiKZNUSIn0DbUxk6yhgwxUZKO8T0pNmTdBL+ZB8RV4PO96Wq?=
 =?us-ascii?Q?GnnYs8hbIWv2Jt+hM/hrYddZ7/Ti0WBQNeN9CuxX6ykJRBX+uNbGwk61W1Nd?=
 =?us-ascii?Q?8ohAoPFeXO6/2FrBS+LhQ3JwSWzv8Q/7Oneidc2W/FW32XDIPOChd604o7NA?=
 =?us-ascii?Q?JONohDwGHAX411GHURFBBpiOv+D9Z63K1wbX0YAb+l3uaZDS2/sGZUUGg0Eo?=
 =?us-ascii?Q?J1h2FBH5srX/LTdCrQOnoY8myevAGQbgoFEwhjttKicChWJw29OsLuBMQJxm?=
 =?us-ascii?Q?JNFB1v7HOp/bgYEQniAtDV/90PKVKhqa9S/dDUuLGPRAdMM3rrxdopP5WUpI?=
 =?us-ascii?Q?hy/j5jIzQVUJmwc8vip+Orh40zaTT1YChlK1FvJ1hZKO9YKfPuEPcv2F7v/4?=
 =?us-ascii?Q?TXVSUaC/6ka5N1qRuIdK31QYuWxlOCEY34saQD9ZLECWFxa2ICP0e8lI+4LK?=
 =?us-ascii?Q?rD5w9778cKZCxIfibE+FnW4grI87BQvZTky7LaRYWAevp8qPcXPT68hdnvMY?=
 =?us-ascii?Q?nLQhAD4z8QgAzIMGpr+nI9B2uCLFVvqQtQ0da8MnLBI5fVhFxCf+KsVt43Vv?=
 =?us-ascii?Q?v+FmWMf1hVeUIeIlu55rNyZPvsZZQb08PB0WF1n4IRG6LN7ERs4JgNJZQVNe?=
 =?us-ascii?Q?QwbXSfp1rAGWPABYqvuhjVlHx07meaHFcXth6akW5DwgN4yaXLe0ipjv2mcL?=
 =?us-ascii?Q?gVN/kvcKcm7feNSsCzBWOAdH8W+fm8M0HRR2ZXkY21IVCi9fOTb4NlwQXDZY?=
 =?us-ascii?Q?5doLCzM7dlyqK7zpdFEn4gCr3ExigB/NCLX3egERI6P1yKyOtMc+yAZe1s7v?=
 =?us-ascii?Q?P8gofQ/+7n0pTj1ywtwDDn6jubEWvCahj7S9jrrSljvJ9rM8g8xq0BmCKQ1W?=
 =?us-ascii?Q?CvisMQTM5yHlTZK7GOcjrHvSV1w1B8xA1Y4vc90arSsBWxsECDaDLHVW0gQ3?=
 =?us-ascii?Q?LOqSPhB5j76MAGMV1BAQvcku+d7ukJhc1iT9+ONPrSt890z8XkrBSjsdFhTB?=
 =?us-ascii?Q?n0Xl6YiU3MHA8g1Gqc7r0pLJjiVj7MXQ3OG50PHcH89lRZtuUOMI6krZ6gC8?=
 =?us-ascii?Q?JfHg4LIjr+ELBGw1jeR7q/hmg6SAfpBlPmFNsRiwCWwAK7NIxozMjYqfJuwj?=
 =?us-ascii?Q?pqov4YL/7gl/Iqc5z+5nWyEzrj0Fxpy9Qe34Ad+8YOBmhZftqt9yHpI2H/aV?=
 =?us-ascii?Q?5c0AoOnlwcaeSbZpB0fGpPGQ++ITLJ+rdw5RC1Gn5LFhr/zSIkxvVdjT1g4f?=
 =?us-ascii?Q?Vnjg3XdpxjTKmpyg6KfSrtdHCQ9bPL/vb9fC5wzszhkGIfmd+S9ElLp1pUs9?=
 =?us-ascii?Q?o4Wr0k4ZvKc4oHS0tBlbpRvUftmh0+K3oJTec+I+TAlG9sB45z/zgQWNe6vP?=
 =?us-ascii?Q?G3aKOvpS41niiczcVGBbwjrgCAZvQSBN2yur5J5sSTqtGKFXi5PpfKuhf2eH?=
 =?us-ascii?Q?h3dLU3OdaPjPPl8/sTHxK/SMCsCSedCcxivjfQlrrxRA7vBYON7Caup6R1MT?=
 =?us-ascii?Q?SM2buA+uFAl/ecmsKV5I0g1cViRIIZKOwTWOdxvAdfOKTTvfzkci/lA3MYJ/?=
 =?us-ascii?Q?Mk7xXE65NpyO2lS8Bccrtjd2r22zHqq++ksSeJ6S?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f34e8804-1180-41e4-cf83-08de128ca79e
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 23:34:05.1591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ISf1Ycyl1HiS+r86LpmILKQdLS1G8GeIa9V9Ue1yMDo87F6DnwkyyhM+hRltx6Yzrc/bAG3/drvIWI9ZUgv0Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6806

On Thu, Oct 23, 2025 at 12:59:16PM -0500, Alex Elder wrote:
> Change all the needs_*() functions so they are no longer inline, and return
> bool rather than int.
>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
> v2: - New patch: predicates now return bool type and drop inline
>
>   patch (patch 4).
>  drivers/spi/spi-fsl-qspi.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
> index 1e27647dd2a09..1944e63169d36 100644
> --- a/drivers/spi/spi-fsl-qspi.c
> +++ b/drivers/spi/spi-fsl-qspi.c
> @@ -276,34 +276,34 @@ struct fsl_qspi {
>  	u32 memmap_phy;
>  };
>
> -static inline int needs_swap_endian(struct fsl_qspi *q)
> +static bool needs_swap_endian(struct fsl_qspi *q)

why drop inline, and next patch needs_disable_clk() have inline.

Frank
>  {
> -	return q->devtype_data->quirks & QUADSPI_QUIRK_SWAP_ENDIAN;
> +	return !!(q->devtype_data->quirks & QUADSPI_QUIRK_SWAP_ENDIAN);
>  }
>
> -static inline int needs_4x_clock(struct fsl_qspi *q)
> +static bool needs_4x_clock(struct fsl_qspi *q)
>  {
> -	return q->devtype_data->quirks & QUADSPI_QUIRK_4X_INT_CLK;
> +	return !!(q->devtype_data->quirks & QUADSPI_QUIRK_4X_INT_CLK);
>  }
>
> -static inline int needs_fill_txfifo(struct fsl_qspi *q)
> +static bool needs_fill_txfifo(struct fsl_qspi *q)
>  {
> -	return q->devtype_data->quirks & QUADSPI_QUIRK_TKT253890;
> +	return !!(q->devtype_data->quirks & QUADSPI_QUIRK_TKT253890);
>  }
>
> -static inline int needs_wakeup_wait_mode(struct fsl_qspi *q)
> +static bool needs_wakeup_wait_mode(struct fsl_qspi *q)
>  {
> -	return q->devtype_data->quirks & QUADSPI_QUIRK_TKT245618;
> +	return !!(q->devtype_data->quirks & QUADSPI_QUIRK_TKT245618);
>  }
>
> -static inline int needs_amba_base_offset(struct fsl_qspi *q)
> +static bool needs_amba_base_offset(struct fsl_qspi *q)
>  {
>  	return !(q->devtype_data->quirks & QUADSPI_QUIRK_BASE_INTERNAL);
>  }
>
> -static inline int needs_tdh_setting(struct fsl_qspi *q)
> +static bool needs_tdh_setting(struct fsl_qspi *q)
>  {
> -	return q->devtype_data->quirks & QUADSPI_QUIRK_USE_TDH_SETTING;
> +	return !!(q->devtype_data->quirks & QUADSPI_QUIRK_USE_TDH_SETTING);
>  }
>
>  /*
> --
> 2.43.0
>

