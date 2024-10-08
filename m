Return-Path: <linux-spi+bounces-5151-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C9C995367
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 17:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2865128454A
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 15:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBC91E04B9;
	Tue,  8 Oct 2024 15:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M2CloPYx"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011030.outbound.protection.outlook.com [52.101.70.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D145E1E0497;
	Tue,  8 Oct 2024 15:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728401404; cv=fail; b=KGpt1u9x40VP6gg0SGcTV236wMcLQm9BzlrCgQ01exfn81ogC49pBE32RU+jnaWVS87DrJJqd1iyWqklShl4/ZSEOXy+yWILXhXnZFoY6XIVezIVto/JsEKNdsNe1VVNYICbH+BalRsSIuLgddqrfEKJagw+rZqBpU9sYmjtKXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728401404; c=relaxed/simple;
	bh=GofWMJDy9VgJ3em0Gooc2kGV15Wb6lFxmrj771DxerE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P1JpNuDAIupy9dRyZfiT+EIu94BOnXuUnjhSFj5MJx5/CmMK6efy1Vtlm7KNr9D4KYRonrbhzm6UDWzkzqoHsFG9MiKXylohLrPiRTdPidM08c6XUn+/1K5k6NTJH1PSX40ZrXtNm5YCYDhCcaS98+WrdJLK9q/3eRcx+D+WT2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M2CloPYx; arc=fail smtp.client-ip=52.101.70.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHKcaEaXZVRs1PgyRELaZPTdd5rQAya4ixYf98hCTuz9ikx53Kmw1OdgQk1hxMZHiryGXQQ1V1GkdQVO97qVEDx9VqjoQ0qVY/F+j8hmbfuSnOr2HxIdgmuWH2MEBh4VaiEVDjXU90b19L9jJNMtWIa6lrNqAeVPJ2MR9ZKogKlV20pcmFmGnb7WiOFz/WEVv4uNTy9E3o9X7X+H6oO4WxAxDka1y2IYvOLrSzEhjzabItOZaGitjp1qR9YAr01h1YuEhC6CXMjaKdefUcW97B7sxWzGVU9aduOdS2pLT6ZztBHn+6AyY+1oRiPZe16sEuYomLQ2gUp6DH0NoPYlSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUXpJ8ZpxRs+kSkPWSYf++btP0u4Lia5a0GMuYyCOr8=;
 b=jLRrxui0xbMmPwq+Pc9YsmOO5RsyykxhfrS6rQWo2tjOvNeG6KgQWLmpyFjHsEFyxRZspsZp0Xvk7imSPfaCm7/1w///EzeKuimtk9pCvpVTgi0vUmrmuw70/rSA5mvWbynrDuHPy0IfU0Tuhd3nJ0hbyjF5PItCqhmC8QXrFI/nOFtDtQF35hYFmH2C01SC2RxFHjmS6I2YrINLw3rzXeuW3Z77od8uLTz9KI86wNqw0x3N/8yWWDXroAfoI+9LyJnLdicgIOpiDsZERFA30kVKTnhWo5KXU8nDyAZbtmdV1NVYIMiUEqbjeLpJDnwU6MX9AalGy5T+SXu7uVoOUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUXpJ8ZpxRs+kSkPWSYf++btP0u4Lia5a0GMuYyCOr8=;
 b=M2CloPYxhjxkhsCO2p1IHqdKDwzg4W0ouxc0Rjl/3iWOvc7A1xv6rnkTZi743uWYKu8lMmHAlDWrGozVojt31uDajcIPDpOcJMkkgs7gK9m18B3JY84ejMYLcemE4bttk+i2Y8hpJBxfrE754hFhkoEN8SzMPIJyw/ce/t8Zda24b1feknCzBzAaeVnFUUror4Gc10aboQGS3jv1br5AaRY9xBsSZjHIISIC/kIsTxAeOfuAq8lyIBrfNM8Knh+N0D3HTo0VlWjpL7LTV3t7iC4ejAs7AGs2fNWZARyYhliABIcvyxvAzLuxshRHPtHslQd0H3ZUh5begsezytrxFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AM0PR04MB6961.eurprd04.prod.outlook.com (2603:10a6:208:180::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 15:30:00 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%3]) with mapi id 15.20.8026.019; Tue, 8 Oct 2024
 15:30:00 +0000
Date: Tue, 8 Oct 2024 11:29:52 -0400
From: Frank Li <Frank.li@nxp.com>
To: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
Cc: olteanv@gmail.com, broonie@kernel.org, shawnguo@kernel.org,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] spi: spi-imx: Fix casting warnings
Message-ID: <ZwVP8P0/NFJqOi2t@lizhi-Precision-Tower-5810>
References: <20241008055644.4900-1-hardevsinh.palaniya@siliconsignals.io>
 <20241008055644.4900-3-hardevsinh.palaniya@siliconsignals.io>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008055644.4900-3-hardevsinh.palaniya@siliconsignals.io>
X-ClientProxiedBy: BYAPR21CA0005.namprd21.prod.outlook.com
 (2603:10b6:a03:114::15) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AM0PR04MB6961:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dbcb54a-440e-40f6-1395-08dce7ae128c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1lLSsXcDt79Spa7VXKaqH6duy+6KRGc+LuZoTdPMr/pnQVdnsE4kJgmtPISV?=
 =?us-ascii?Q?RXmU1dqjQB5cUIe0smBEermjewCRnWri0WKFvolxsKtPjoi5L0h4+90rG4OB?=
 =?us-ascii?Q?UcrmFtdVcy/vn+2bL2vKmcIicVrA7qrO1UvZGbT+um1IJIXTFavn0bSp2uOT?=
 =?us-ascii?Q?CqutmDwyMWUTwUt3haNmv1T5sbHTKNgp8oarvS6JNikJ//Vl8lFh6GXbNbwl?=
 =?us-ascii?Q?7Fay5CvGn5wMIIoMc8gzUx08rgGQ/fdaOrZocxY/EKYmqBCu0qPSSamy1V6h?=
 =?us-ascii?Q?bfAeyZXGt7fiqaK2jb3Yu8Uj09q2MkGZthYTxuc1RkGm7eqq9EzQbI0v73Js?=
 =?us-ascii?Q?ImCBH1QyxuDboHmmASKml80bcePUDYa6cLRCgo3+bbFN+pRbjxB6/3Zb+4V+?=
 =?us-ascii?Q?W+8FAbXQPEkf12940NI78rn9CWWW7mUkJXxylqtmNiXx7XaMyRpBUfl5BAOR?=
 =?us-ascii?Q?Q6EVOlXp1TWH10MVdmpnLCtE2QNJhTrf3wYUg1asXs1tFxamae1gWsFpVvv6?=
 =?us-ascii?Q?wmfdPk17WT1mltLRNSl6Cdv+SEWAbHZXslKDEotuXRhqn4kMJqYj8ST8AB+Q?=
 =?us-ascii?Q?xf76uJFdKOAAOpcL2MN5EZu27fri4+PP1M24NlJ11ClPo3rmVFxkGyoyurQ/?=
 =?us-ascii?Q?nGJ4NCyNCQ8QeuA+fy0iAA94SbBicLg4PhqYWc1UbU0pKQe7y9zaTggz+Pb8?=
 =?us-ascii?Q?jzjnt+T1CHptkfnqNofUUQkHf1qTIuoxTotj4ekzc9PjZa/5NzS7uL50/1y5?=
 =?us-ascii?Q?2zd610O2oANirBxKxsTDRVNY/zMrMhAZYIrLXSI9cD1vmZrJHVTiSvlISs5o?=
 =?us-ascii?Q?wPbzkXjoDNpANwZeXiNGk4yF8Yz0/0tVh3tyQbSHYNuV9YeADNp66HF2gqSx?=
 =?us-ascii?Q?m1FOtEO8KoVQOKrOY2I0JLOVhrH9LR3cErCZjWX7fQIxCoj6h4HeaOXmauDc?=
 =?us-ascii?Q?mi1NqiY+1gHBm9mFpfXiGdek/s4fGjj2mPnwp5BSxkEipB3WOv6E2Z+0jRAt?=
 =?us-ascii?Q?sGrUAtYv6wHljcD1dNhTewg/jHaDwRhX5WrS0YOr9tsOtRuHw+Yr96LWFkyo?=
 =?us-ascii?Q?bwA6yarnlAWjUUQl1HtEjbvIyVkfWPvh5vEmpSD3B3rNIRrbFk799POZd6YM?=
 =?us-ascii?Q?IMFBL1/9K9iliKfwL3uP65OrJXn0gaOBE7VxYt76zulmB+7Nu/tXeHQHTczk?=
 =?us-ascii?Q?dAoa6eQZTqxAsAe+ZgaYU3ZhBG/FqigJuibIqPo27p5dpFRYQYNZOHd646pN?=
 =?us-ascii?Q?QAUiQD3eloW7yH2IpnsVkPCOYOdHWjXqCamxylNzQhvATk4/ZQPrv0uFrfcT?=
 =?us-ascii?Q?pCrKOk1WukSCEz84Q/PdYwlMCEwArRnhf+r9zYINLWalJg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6qZ3KLhW+x5iJh8YPv8jUAQOjkKWUE67fbTFpZmFjUqshzwqwlI54uhoQzm3?=
 =?us-ascii?Q?4TbpUYR68uX92TenXBO6k2MjgLkG0B8y4efOr9PQNrdGD9L6fPiQnRs2reUg?=
 =?us-ascii?Q?BKDnuGRsWLlRdxvorF6KcN43qaUZ+SyUiMvMU5Y2CZA6XrM9KryR7NTDhcBy?=
 =?us-ascii?Q?TTS5FCNOYd6fuEtxsMShOt+fGXIpplCirc9yNn+i+Uj4XJgfbm1oqNRPriDU?=
 =?us-ascii?Q?N2MEgO9En5BFWjRyQpJzEQkQfm9D6r3VhN0QDS4nBJ+IzDUTrRLED0EtzxR0?=
 =?us-ascii?Q?K4p+e9bNVXXX4TaOsU94wlB2xu60f2N6Pk/Zgkmd7vFiWw2UswloXmWeyVIN?=
 =?us-ascii?Q?yUJoKdBGbzRQ39fBKescjpK5OMRTGrq/b3FsHX1p9dwBonUbCheR5NuF7YBp?=
 =?us-ascii?Q?c79n/jp67WD699gIu0xQNHVoPaoSZIMLtbJdKP/A97HYYzYr6nBog/dFCjaq?=
 =?us-ascii?Q?vARinaVqVcZY/ExeO640U9Ko7iuLnizt5aumWZ6Xpd6aAL8jCRHCdlzUjsu/?=
 =?us-ascii?Q?PPF0AcGZjh16oall9av9fbDiIhlF7Nz5txwo7LgbT+pKepmTUPoJiGaBopBw?=
 =?us-ascii?Q?lK5cWNm9g6U6lplQMzOF07v3qiO7RjRhqMcPGIIv7dzZk9vDSUekocYvClFI?=
 =?us-ascii?Q?sAxCJVRDlB8PcjDaRW1t2SoxlR0ZjHbmKvzxgsd7ZupX2ZC+o1qf3+NqjOhV?=
 =?us-ascii?Q?Ra3jmPGVSwXtFJ6Nsq0bHW3gFmZnN5m0xKEZBW6/wh9Iyh2BmGclxm4wNDJ/?=
 =?us-ascii?Q?HiKim2U58TijW5HGabQVPcYZ7dI62xM/5kiniFLybRtb++IcXhVxZYV/M9KN?=
 =?us-ascii?Q?vqTIrNOhRtJY9EDOoHR/MTo0kiS31fbAAbr89KTK/v2sFAn0BUiEqhgAhTVB?=
 =?us-ascii?Q?lcInacdW+ebI/Q0Qe5mdRkf70cxEbCFealuk8n2d6QStI68bhBEXwvQV4MGD?=
 =?us-ascii?Q?2zeGK80DBpDBmUJpEf34XHsrqxPKVWjv/A2LTe9s4fp1+UnvzQC4prA1iaJx?=
 =?us-ascii?Q?b+/SAAwr2TuxgJVqmsCOCnyEjn75vQIVE1krpHxNH8aDaEKXMiqDUGoAg1Ld?=
 =?us-ascii?Q?EmkncC7bld6vOyYUZyMtHyuoHxV4Xl6RHGWh1DTzeXuONdZINeV3pIintDBj?=
 =?us-ascii?Q?7pP3kqpJypj+TqW5WAYMmuW7EB9SuVBQyxI1j06dTdW1hYjC68AvXT7u16Xw?=
 =?us-ascii?Q?Lmj9dP43bnTs/MNSaHKSkxnYJBcs20CKGtUBqOKQ3pWA9mYdk4ZDdVWbcNeq?=
 =?us-ascii?Q?mMzoFEEPnbQ3woCzxaaW1k/YPkC1tpEN2KYORpF8t7KBgN+ZBkFUhvk19b9i?=
 =?us-ascii?Q?j+afS0NB/ROqBLOPngM1UPz5jqTQNTTqdvFkVm7ZrWPged5jz1j/oTnlu/71?=
 =?us-ascii?Q?k/OzQUUwTVoMI77BwIuZFLbBlyiMIiMFoJ771XhaBuXlCJYzZjsHQgPVIPbn?=
 =?us-ascii?Q?PIf9FwaYHqLX71WTP0Zdmh4d970N2iEHhQGsl4WSvP5rrlCxVy8YnSa0wf0M?=
 =?us-ascii?Q?ORQlMXkAzc4bSMLY/ZA7oJ1ggTEBUJamoZg9JMMaC6AsNJ46PKX0aav31t4A?=
 =?us-ascii?Q?9W8TBSNae+zqSumFDxEsSlqhupYeRFagpSxteDo/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dbcb54a-440e-40f6-1395-08dce7ae128c
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 15:30:00.2233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8TZ9iBNsFWs8XeikaOg3zXfUccKQCFuqCzO6LBf7JmreP3QkFLw65fBnMCK4Bl25/cc5V9v9VX1JNlg4gtiOGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6961

On Tue, Oct 08, 2024 at 11:25:46AM +0530, Hardevsinh Palaniya wrote:
> Sparse warnings:
>
> drivers/spi/spi-imx.c:410:19: warning: cast to restricted __be32
> drivers/spi/spi-imx.c:410:19: warning: cast to restricted __be32
> drivers/spi/spi-imx.c:410:19: warning: cast to restricted __be32
> drivers/spi/spi-imx.c:410:19: warning: cast to restricted __be32
> drivers/spi/spi-imx.c:410:19: warning: cast to restricted __be32
> drivers/spi/spi-imx.c:410:19: warning: cast to restricted __be32
> drivers/spi/spi-imx.c:439:21: warning: incorrect type in assignment (different base types)
> drivers/spi/spi-imx.c:439:21:    expected unsigned int [addressable] [usertype] val
> drivers/spi/spi-imx.c:439:21:    got restricted __be32 [usertype]
>
> Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/spi/spi-imx.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 4c31d36f3130..fefee771b042 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -407,7 +407,7 @@ static void spi_imx_buf_tx_swap(struct spi_imx_data *spi_imx)
>
>  static void mx53_ecspi_rx_target(struct spi_imx_data *spi_imx)
>  {
> -	u32 val = be32_to_cpu(readl(spi_imx->base + MXC_CSPIRXDATA));
> +	u32 val = ioread32be(spi_imx->base + MXC_CSPIRXDATA);
>
>  	if (spi_imx->rx_buf) {
>  		int n_bytes = spi_imx->target_burst % sizeof(val);
> @@ -436,13 +436,12 @@ static void mx53_ecspi_tx_target(struct spi_imx_data *spi_imx)
>  	if (spi_imx->tx_buf) {
>  		memcpy(((u8 *)&val) + sizeof(val) - n_bytes,
>  		       spi_imx->tx_buf, n_bytes);
> -		val = cpu_to_be32(val);
>  		spi_imx->tx_buf += n_bytes;
>  	}
>
>  	spi_imx->count -= n_bytes;
>
> -	writel(val, spi_imx->base + MXC_CSPITXDATA);
> +	iowrite32be(val, spi_imx->base + MXC_CSPITXDATA);
>  }
>
>  /* MX51 eCSPI */
> --
> 2.43.0
>

