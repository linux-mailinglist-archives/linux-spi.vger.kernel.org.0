Return-Path: <linux-spi+bounces-10823-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8FFC0679F
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 15:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 093AE1C025D8
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 13:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDBB3191DF;
	Fri, 24 Oct 2025 13:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TFHRyd4D"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011037.outbound.protection.outlook.com [52.101.65.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAFA2D3A75;
	Fri, 24 Oct 2025 13:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761312305; cv=fail; b=D3WbXliZm6XlMmjXYULlZ8mLtTBspFpZt9OctrL4TC8vA27HnokEdUSmbqOX26WJDA6iRtnx1dXUgMxwYgGFcJsk3FajFebWhVF429dcbatrNDBBA2V/4edRl+1gCBjJcrLgdVDy1j0a+Q5ZyWf0I6V+e6heG9ahX2RgsQ1z5Ds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761312305; c=relaxed/simple;
	bh=CERjEZ+vQ/NWRX3Cj1K2GGQ35yl2NghYcYMUXM9tnc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UHUs/PBTe7fUZ1gkdT5p1nV3PJG/I8ksUjEW03D2PgxoUcsCWfrOuOACFroqnIBLW6pBm1gOS4XK1LQ825SngYlCxbXt63dPAYFOtN8MM3DUIyPUR9DflNviQaV5gcIUI+UcuR+lVNQli3GFxhcanzC3+o6d/1I4vC5A+y1LxvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TFHRyd4D; arc=fail smtp.client-ip=52.101.65.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GBV+Nbirsy16JmmfVPdvK2wMRQwAma/G3843Tya4ljWGolwj3F72Zq6qAtp08j4aT3slahXi53pqeA9a/ETCPReMmyDBjZ2ng9sH0oKr9VSDecGpYLgUQydZSsGxtCrsYje1Sm05VEMdMyYoUn8oftpoYPalvkLKOgw9c4cOXL0JQAG/V3YHb83klEys6BN/To2x/XsJ8c/jcB8xNJ/yliRa5fK+vcJLkfrwtfcnC4GGccBypVHP1TIN7AgmffuWrHyYp3z1rybS6WPu9BtQsdxseP32Aw8zdXCeYuNkBBELPHM4d+v+yG14Myva9MuWpdEM53jv0WzGKSqZEAGz8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWVTkJrDJIBXqlj9+8HdIo+Br2bIYyQNh7GqZUyPsO4=;
 b=rRiW30dPlJvH9qu3vlWIK0nQ5LIxaHpdkVxvMBSEREp9Xq8zw3TigXWgSrA9E9A9WnHPk0hQGDHfQs+o5PTXbyqD1O5kjC45kCLxtaxSNLM3jYn+XqGa2njbRVnnVTuQO2vSa95LviTvSfos21TDtsBjfT+Dol6rtOF0HB2yu6oUWcHQRe5nLvMWMfvEhIXkajeKFrgpwawEZPARHzCIqMFZe/RBn1ClzVjVC4JUgLM3S8nsJoaODscDEgVEVkYshF5dFCLhQsCucP41esla4+V1H4yVtOXYeh2DWLFvw+94bmPvd95cBVQTR8n5Jz6N+2MASPcJjFhHYxS/QPF8yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWVTkJrDJIBXqlj9+8HdIo+Br2bIYyQNh7GqZUyPsO4=;
 b=TFHRyd4D7VEM1H/+Qh/S5KTvtIAzWekiM+FJD47j2h0Wnm/4JgP5XN3X592dxsFFL9YUBlXP8N8lksCEO+qs/oEhHBx/weJY5mOErC+88N215fMoa38cDOh2e2BGZy0bRYgy4suiAuyGhcrpI4z+GfQTpjoVjlNrXBgCdKyvdKthAkKLGtF8RdnvIdiBFlwQ8Vr74LqWve/+nhsvgGlLrXWwOs8B+xW68/F1FCOUA7q9pXu8oTe3rKJseasQ/KU12I1HZTKpIWy9yxQyHJgVqkEDeliWPab1DFv6Aa9fRP9DPMDsSHxVfz/aggtLsVXnoBvnOyQ/ZwXKJvOkPWRBlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PA1PR04MB10415.eurprd04.prod.outlook.com (2603:10a6:102:444::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 13:25:00 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 13:24:59 +0000
Date: Fri, 24 Oct 2025 09:24:52 -0400
From: Frank Li <Frank.li@nxp.com>
To: carlos.song@nxp.com
Cc: mkl@pengutronix.de, broonie@kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PACTH v2] spi: imx: add 16/32 bits per word support for target
 mode
Message-ID: <aPt+JJhaB9dUOwL8@lizhi-Precision-Tower-5810>
References: <20251024113107.513604-1-carlos.song@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024113107.513604-1-carlos.song@nxp.com>
X-ClientProxiedBy: PH7PR17CA0035.namprd17.prod.outlook.com
 (2603:10b6:510:323::16) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PA1PR04MB10415:EE_
X-MS-Office365-Filtering-Correlation-Id: 102d46bc-8df5-41ea-ff48-08de1300bb48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|52116014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3iiLFabNabSjN4KlfBT2Jy366RtTCYmfUbGWQb7auIuWU7YqpkAynkqWyVgk?=
 =?us-ascii?Q?dxjPczvZ52hG7MUtYjIHJLEXhs5ngN6LyICnhNntx9tIiOLhcgx6IiNH4mco?=
 =?us-ascii?Q?OT2cE3rC3u8VokTdBQLsV/liZ3A/904LAhp+tAPVXpLOVPUPP+RE6CcyVGgd?=
 =?us-ascii?Q?N1ujuYAkZ1Ie/wd32gHIUAz2DGQ0DgNaJkzoC4ehboUa+FdwAyAD6azEDSXk?=
 =?us-ascii?Q?wFHSRgoKj9KtQtY2VvCkIGsa3Fqn5vtWNIu+uqxKZXKXrhkCjF0gNRHJ2ZPI?=
 =?us-ascii?Q?tcnjOHaBZ/NjgrS5IjhOXRrn0n8dpAC9l4h+kyk/W0b/MpjW/xPppMNHwdjG?=
 =?us-ascii?Q?/v9EgWuX79HuxxYqaoYPcIZlU9lBKIfeWnLFbHedWXdrxc/n7QNRZjMWvWdh?=
 =?us-ascii?Q?fMraLBXNkes5iu21Da4s+sdTdpM/EXRjX8irJyO7/ac11Sn1jorxTxL6bJ29?=
 =?us-ascii?Q?aTT+jziqlLX+QF+/uc0vampqVO17mXaRBKGwdSkbazjCy6vdDe2+ACm6w4WE?=
 =?us-ascii?Q?qQOvUXkAHl2Xu2o7AT8eX9PMgjkPmK8hhL2u8YXqT1V0obE7Yx57KfPmOlOZ?=
 =?us-ascii?Q?9ZpB4T6OM+rNb/gB5KWe7DADeWKlBh8HxnXJfBh7/ImenO10dLbXLMqFHPiD?=
 =?us-ascii?Q?V1OSxy2Wsn95amOa2j25n9dhFyjVl5vxysPMNF0UkGXkwwn3CIVo9kgdFUwq?=
 =?us-ascii?Q?7jMmtjtIekZsiWTfpVWi5Qhh/EypD5eh3wFuCbGdaWFcOQtYFX7wfHjt2oEz?=
 =?us-ascii?Q?Y97ysNOByei8je+jUBZvqi10jqKG2CgS5u/trlvfBM0uDDBeYrKkjeG1i6Yw?=
 =?us-ascii?Q?JGVrTV9JUPBEN3+mPF1tK4kt8SlvTrOUbqJAiU6fG2QdyMjmZKXc/XSaIqWw?=
 =?us-ascii?Q?oDjpB2tXIfssVw12+O4cs8RDtgVFfPHDcrcS1CRsruv6tpcWdcWkZl8TpmIL?=
 =?us-ascii?Q?USPknUP/YYdeCXanon2KYSPnQTb8PTsS18gF6MRQiWd+BRoIShtO22Jojdc7?=
 =?us-ascii?Q?ZJ+eu1X8P5hwdkTdr19AVavDlsGJ+Zkzd83mj0fuXxzCiDCnBwc/eaQLfZTP?=
 =?us-ascii?Q?vTKX5uPgK16Cy+ZJ+5zEtrCE3eKoJFxVaO08ozPTqvRwOxrMnbtvTa6xK1mv?=
 =?us-ascii?Q?vnYQdQTUZH2PtYPC6eF06zafPFPBso64c/znKkzWeOwAuX6QLLZbEtgFTexm?=
 =?us-ascii?Q?pD85FVdtNphA4vwMZCyfTEOllfi2I2FZbevOSEwAiicRvdrR7SOrG0Vt9K9v?=
 =?us-ascii?Q?wKuyKs195MtY1Qc4ubbFSGPYR0tXINtYps8lEGe1Lsx3FA4C2gniWRHnxYNO?=
 =?us-ascii?Q?G5NLMwB07CPPwvuOOCc7dju6RWu3v0bSTFQQALW2xt5WUZT/VVmalKBBvxR7?=
 =?us-ascii?Q?xiBkNQedpxN0w2lX+MKgKeR0kN7Ng3SjXs+Aqz6lLjKQaYxGySL8Ed36ZnlP?=
 =?us-ascii?Q?NFoHWQsMlmljigpbVZ/NelfbXfgStUXrt8eMrueI6FBAc4iM6W6/jrS25fHC?=
 =?us-ascii?Q?Xz+9gdFysMGNlUMX+aW8kmdtJlhvd1m/DCDn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(52116014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EZaXrB248ejz7iECDaGqiuun62+2ucPygwUqC9nYHNqmxu7gSOTjzgCMbbiZ?=
 =?us-ascii?Q?HEQ6xSrFjcWy4g5CYob0+Wbw9wzwSu/cKLbT9XOSkXZ88SnBHV1jfjpQrawm?=
 =?us-ascii?Q?skGqxagAOCyDxUjKY71/lyT3HFKPRHPK+pjnfFk+UBC2gCPjkwx4ZV3FZ30g?=
 =?us-ascii?Q?s54Fe6TEIGGS6sG2haan1W+ZE4hv2FVSk7miyyi+atKJOFsQA3PvovfyGe/X?=
 =?us-ascii?Q?wJZqxSBKrF3mZPFmSLeuLG08R2QL1xE4+kKP3JPGnMzgvBLaMbimhKZg5CL8?=
 =?us-ascii?Q?EvMsSiDdi6+IPoWn0BSk8LGFIG+6twEfqkzDIEkOdJVvB2WNKIZp5UthP4VA?=
 =?us-ascii?Q?05aV5qPqM/zDsNI/sYHdE3jvYZrJ/OOdujsnzA2QLWE440uzHf7RmR6PAjZ8?=
 =?us-ascii?Q?0kAO8iro1fMML1y7mHPyA860P6gpWNaGp7JJSI2Ofg3HDR/IwWeQR/lBX78d?=
 =?us-ascii?Q?jTsUPIP0/KXarbF16A3iOtcIBpo466ldBEGixMB8FMOVE/KjNLshAcq1TQmU?=
 =?us-ascii?Q?bHE33WcBQHPkSK8Rm4MGx/0tZyKMhBTC+95Pi0WzACXeU0MCEnKheS4M6qrr?=
 =?us-ascii?Q?/g9M9fS7VFGQhXWb9ZHTmi9aYIocc6DY/6639+QiXxvehR7bBywlZo1WT4Je?=
 =?us-ascii?Q?QHOTc1AJThUivtETKLod9+oqTOinS1ezgJTFJyv8poap7N40/kmLhXZ/2QwG?=
 =?us-ascii?Q?2Bm0eBD6j11mlERSgwGpO6BaApFxt4MmzEHyiBDkyYcIPCWvDyPNy/rgtSo6?=
 =?us-ascii?Q?TRUdgH9uIzTh79BbyaVyANyKOHMx9k7dTGE32wuD1OfyNsUCJZnxHTVeBYzj?=
 =?us-ascii?Q?aS7L9zPPXWVaN8P9JhkZitTPjGML9dr+LXicB+iyxxtRsVTrux7p/kdvB7CV?=
 =?us-ascii?Q?X3sfrwIjUP69AKooEtNvuHbw0EZMuDfDhUW63sBCeGaHPZELKEIP3Y63RVoA?=
 =?us-ascii?Q?ECocg9+JCNzXzeycHz85+vykMmxE68Zf7Sn8CKiCESlHfo5x5cSMo4cIZ8VK?=
 =?us-ascii?Q?Q2Ya/RqAlZ3CqqMSp7eETSaPGKRgRCPDp21SLP2BHfXo+NrddvymIVKmGLaf?=
 =?us-ascii?Q?vaf2g0drMiMupOQfovHfioD1N7HDDgTl3ls3CbXOvMA/3MuRFUP7TGGmNuKx?=
 =?us-ascii?Q?OXu3c2vxF2zj1otwLSqaKV5KoMY4sx1QQuLRBH+9ZKvjawl6Uvgh1f6j7WtZ?=
 =?us-ascii?Q?qMU+I5/9Djo4iDG/He1pQDVBjGKmiv28ovup/59ejA2OfXDwSN+xcqhxYsIQ?=
 =?us-ascii?Q?hJJy6lnW0dX+gFoBTaudRSUIjBTBi8SNo5tMOr9LKzMN/tTPIKtOt+eQurGU?=
 =?us-ascii?Q?vWfnHpXad9wlRe3U9U3GkcSsCbvTmzCebLxSFuI6c3hAFsTYKc+UVboe5zeu?=
 =?us-ascii?Q?ILiciW3cLPSkMT793RPzDuXr90iJ99dkOpBYCbxF4dzmMpO85B0ZpBvt/1or?=
 =?us-ascii?Q?EkPO9kK9/1SYHrOmgrGcLWmA4d6byx6yaE4pK0JwBOQb9O59IiAuwMl615/y?=
 =?us-ascii?Q?82B5SB+Wz4KxQtWLMY3XpSJ3IFvz0JLieilABvla1gVBvSGcUg47UgrXgLj1?=
 =?us-ascii?Q?miEYJ483qUAGoDmOjx9HEvd64efCkcq6ht+Zwex6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 102d46bc-8df5-41ea-ff48-08de1300bb48
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 13:24:59.9345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MxgBP1EncL7IEw3xaZYca1lo/k/60i8qQaiku38KekuJgFDC4I2Ydu/7YPA4qSz0tKchpNjWjMOJHWFaZJdBdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10415

On Fri, Oct 24, 2025 at 07:31:07PM +0800, carlos.song@nxp.com wrote:
> From: Carlos Song <carlos.song@nxp.com>
>
> Now for ECSPI only support 8 bits per word in target mode.
> Enable 16/32 bits per word support for spi-imx target mode.
>
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> ---
>  drivers/spi/spi-imx.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 155ddeb8fcd4..017f83f5dfdf 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -424,8 +424,12 @@ static void spi_imx_buf_tx_swap(struct spi_imx_data *spi_imx)
>
>  static void mx53_ecspi_rx_target(struct spi_imx_data *spi_imx)
>  {
> -	u32 val = ioread32be(spi_imx->base + MXC_CSPIRXDATA);
> +	u32 val = readl(spi_imx->base + MXC_CSPIRXDATA);
>
> +	if (spi_imx->bits_per_word <= 8)
> +		swab32s(&val);
> +	else if (spi_imx->bits_per_word <= 16)
> +		swahw32s(&val);

Needn't swap when bits_per_word > 24, like 32? or our hardware max support
to 16?

Frank
>  	if (spi_imx->rx_buf) {
>  		int n_bytes = spi_imx->target_burst % sizeof(val);
>
> @@ -453,12 +457,16 @@ static void mx53_ecspi_tx_target(struct spi_imx_data *spi_imx)
>  	if (spi_imx->tx_buf) {
>  		memcpy(((u8 *)&val) + sizeof(val) - n_bytes,
>  		       spi_imx->tx_buf, n_bytes);
> +		if (spi_imx->bits_per_word <= 8)
> +			swab32s(&val);
> +		else if (spi_imx->bits_per_word <= 16)
> +			swahw32s(&val);
>  		spi_imx->tx_buf += n_bytes;
>  	}
>
>  	spi_imx->count -= n_bytes;
>
> -	iowrite32be(val, spi_imx->base + MXC_CSPITXDATA);
> +	writel(val, spi_imx->base + MXC_CSPITXDATA);
>  }
>
>  /* MX51 eCSPI */
> --
> 2.34.1
>

