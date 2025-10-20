Return-Path: <linux-spi+bounces-10745-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B994DBF31D1
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 21:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BFD93B046C
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 19:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD3C220F3E;
	Mon, 20 Oct 2025 19:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kxFxbXVn"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011007.outbound.protection.outlook.com [52.101.65.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25941E511;
	Mon, 20 Oct 2025 19:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760987274; cv=fail; b=cffVxvy0TeHQ/gh4PihXr03FPdTCYQG4rbiC23C9zFiwhzEhNuuf4O9TDNEyaDCkJI8Kg70CC+A3XTz/I401XT1P5hDqhifxuhfGITJfBU/zpNcZ7wHuQLeIc9/QbpWQetfguYmmvAQEbWx6fl7xVa6wAOOaTxctizrAP/bP/Lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760987274; c=relaxed/simple;
	bh=AVByVaEA4TCWRX15d6fCzvF/4rzEvsPx4xL6BJfqbjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=stnm7l3dBtuxMrZFeVTyfQqAXymNrMbBgR2wHpihrlsncTNSjButCEPfz2LN+UnDy1nl3NPPtEohjjgsZZl0t3iieW/oq3xg0r5xSAAdg8kJZGy7uFYPfeDha/yeReq8nJtTfD00DNtUpPmtoYA9MZo+YAcgD/AXxN3W+3bTXYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kxFxbXVn; arc=fail smtp.client-ip=52.101.65.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8WnnN9X9UAdYDJXr2kXQRTytyl0ijHnM4Jspn8m4fiIWePWr/VW1kpUQJsbT8sGVxzlQmLBSX88JE+2xcqqZDrU9mO6ELm3+livYgU1ChwG6c3hV6N33fI8e6SMO5fMwmCiGBTpCCGsn6+SZlbJGipXQVd9B2sp/8sRUt8FHevVoWWa7DWBEGoeoYSfez3OQJ9CrSVNtkK1Ngv6W+RKUxW63DjnFPj5E4/X4/+mR1n4QMXPcDQ+wc77I7xgU7bK8jWAjWl+p97tVae7i5VZWUMVQTvGiJPezl0dqPRSUmU/QSjW3qx07083k2wCZfkcqWttvEhmLNKvkXOZLTkleg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTaTxMw9TN+Hu8hm1j7zlPH8Cqjfa9z3WleDhBkI/mw=;
 b=YKlpp+Yc3+AyYQZKSnKizH67tlpv/tRd0ihJF6+F02mOPDQsOuc697n8ZEuS8zO0IEINbLPqfsvgKVGDwmonQvOHBGtoQNbXB23GU4vAvsV7fiFx1cq9mXjSZqismlZek9Iyhpgu5i4dy2fGiT2V4luc0pYv03KntgUXz2JjutVAjGxQDG4NsTZxnIDcUHgt5DkNbPnSQTPKLxmVRElB5C0ccvxqEQc6pjvx0RESvHxqEU3k8kyT2ApHOC3UlHEU+KQI7b13KucRbCqAFWuoZWF2YEYah/ZUCEOFA+qLcpxnXBPbqjCjfwtz3y6zqNxfONHSspFJL90miRYGd7pxKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTaTxMw9TN+Hu8hm1j7zlPH8Cqjfa9z3WleDhBkI/mw=;
 b=kxFxbXVnmT55kRJk9ohTjY5AARWtoxGto6NcsOgg9AE5P1H4RMzjpbWCXKZWxaAdf5RZzslxSEGdq9jNazqravucw8JAukprGGkMpPcNb5HEMekDL6VcE/kkSvLUGhXCqVpzdy7k66uSbC1MQmbznWnEAgv6PljXCl9xFUVeZVpL3TcJhekvGhvpZuurzHAVvjBZwwnxl/64xyvcI9wObNUO3XFl4ZHpJlQ9MfgqyxXskboXCxQaTyFdEya9yJ13FF8YPWGaSayeA8pZHWqiTKmaFHPMVtvSbxFIjZOuWxVlNZrEFiYzFFPr7TLuq7FDU7V+6WqzDBw0v6u3M5fSbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by MRWPR04MB11288.eurprd04.prod.outlook.com (2603:10a6:501:79::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 19:07:48 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9228.014; Mon, 20 Oct 2025
 19:07:48 +0000
Date: Mon, 20 Oct 2025 15:07:39 -0400
From: Frank Li <Frank.li@nxp.com>
To: Alex Elder <elder@riscstar.com>
Cc: han.xu@nxp.com, broonie@kernel.org, p.zabel@pengutronix.de,
	dlan@gentoo.org, guodong@riscstar.com, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] spi: fsl-qspi: add optional reset support
Message-ID: <aPaIezCu/gXxJC01@lizhi-Precision-Tower-5810>
References: <20251020165152.666221-1-elder@riscstar.com>
 <20251020165152.666221-4-elder@riscstar.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020165152.666221-4-elder@riscstar.com>
X-ClientProxiedBy: SJ0PR05CA0137.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::22) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|MRWPR04MB11288:EE_
X-MS-Office365-Filtering-Correlation-Id: 46e40ace-d0b7-45af-cb9c-08de100bf534
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|19092799006|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7sK8en3Gu2XVUL7EZaF1LEZaXxAKq8DY0mY6X04HsnlRt6HSCyN7dO+BkC9x?=
 =?us-ascii?Q?9Q+Usq1MVYH0328jTG0B7C/G9Guhmccj3q1O65IodbFT+VmSbEEw9SyLFKuS?=
 =?us-ascii?Q?G/9xpcl38GunJi5Z6x1w/KE+YRqGC5udrI0NG24kbofVkNhoPOO/Z2X+ICJz?=
 =?us-ascii?Q?lOBd9J04kGG+ytHTvU7rP2QUtN1oQlHfl6h9CsjEHmffggfjSjsMZgxdzKRm?=
 =?us-ascii?Q?zb3BHCc77yGdCWC4HkbJvK0f5xin68b0lwx486dV8DufypzrQbaVbW8uaPOI?=
 =?us-ascii?Q?JvtuKoTvihW9ZqS/v/+9P/Rf7XfsOpCdVLrJ1V0jrnA89t0hdm5X3C3RRo5z?=
 =?us-ascii?Q?JxyAWcXF/JYI7lQ0gMFph6RNWJLST1ecbItUvHFgo9hPTBpWgEKFLdA5cmQ/?=
 =?us-ascii?Q?P30xJba60qwX9vaR13uzomFo48tWvr3NCtzSuDdd/CDxr9immBsjBzFuMjVK?=
 =?us-ascii?Q?qAZcO1JyBzFiazh8jzcDlXarj/Fx4zWAlg2cTReFCiZicSEVZyL1p6RD2vJc?=
 =?us-ascii?Q?3K0TmQRTS1UYfp3327y8n5QoAhhYYb2BEpOtYLsN/Kb7mCUNDH75J0AlNYsA?=
 =?us-ascii?Q?k+OlCH7I/lGSlA5KQG2Z99lF6bIFF4LsZYotN1tK4DWzkXhCrx6edi1uP7nl?=
 =?us-ascii?Q?cs0vdry3uyqs+hXsfEJKjCO0za1BYh/CXsxk6asvcPd5b8CGP1roZMxBYlw4?=
 =?us-ascii?Q?jaYpufI9lX0oMQPN2EeQ5EMRm+DG01BgjCP8gYTIIAlPP7rruQOOKvZBQm2d?=
 =?us-ascii?Q?0vl5xd/Q49Kw+/KnX7P9rKCX5q1tXtZ0lHcAqOu74bPbeMHIyy3nabXW2M0U?=
 =?us-ascii?Q?JCtf0yUwS8oMHab3i0Ep+E3Yaqp8JvuX8ttTVENU6zwmzR4rVytXuQBfMzWH?=
 =?us-ascii?Q?bS6B080b7DRrtPvDkcSxJr0d+WZiIT1YfICVbsK5ADVuKH67zU3po3BR8mJS?=
 =?us-ascii?Q?3F9LRX7Jg3Lz78z8+fgU97ZYYELToQ9UHZdLmFI4slOY51hIQqZQ7a/Oa573?=
 =?us-ascii?Q?MJg46yIQN2ipRYk4gGS+SIQKlcqPCjirBhCXkq+CUOamFKAjMrPaCIr+r4Dc?=
 =?us-ascii?Q?yjUuT3DVJX32RW4hqNR7N9XjfZ/iuJIJo4a7jyVBELREqPptuv2FBAQDiQKR?=
 =?us-ascii?Q?AfS8NyK3Ttkk2dzybsedkDq59bhU1d2SwF/fzbgkNS6bs+2wbkFjc6obIsGk?=
 =?us-ascii?Q?D4e314j5kUnEy2XkLWKEglOtwwgkfKObzw4CIA1hvNiwLQglXbQLkL3ksvdT?=
 =?us-ascii?Q?VRqL0UBDkZqngAQM3U4fpykCKGpMsxtW4WIodd/cTJap5P+nzm91XYFm7Egw?=
 =?us-ascii?Q?/TnqH6LnTMFtZ8CCVd3vQat/45m8K6RzhIz+5B2DHMwQJLnhlY+luzwuPuy0?=
 =?us-ascii?Q?u9gLVBWg8CH3UXivlvR4+KtduSIKRZIjDpl7OYpO8/GQU6LNIRime5rFjkNO?=
 =?us-ascii?Q?pBk1LgRom0Eyyoqn/PxbnTy6Qb0U2dkHxiSyEvfI1gZadVAdj8bqixjWFS77?=
 =?us-ascii?Q?27MSXPoGRbjq3gQYzUzu5iedFc5DmmiwibbQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(19092799006)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5wyfT6AyNDIwi5bfOB8v5mqNGTWOD0nhhruWi61bDYQ/8K4QssvqRFK8rk4G?=
 =?us-ascii?Q?QmRsNznc0+Okvo8RpWlAHFmNFQuPLSHZbuv7ThZP+4PtX7wOUIETdGO+SmYg?=
 =?us-ascii?Q?FfUaXuDZ+FSgWvPoS3qIJ8PCg6BaGm6n7hb/0V+KFZlAit67oRtsGhdrQpqU?=
 =?us-ascii?Q?sV5IeRIAnNe4EmgtDVwj/bNcWSBvZufIWPFGiaqDeqoOW2ZuDRK3a7ukL2YM?=
 =?us-ascii?Q?eML0QeWrjbpWuB33s1+dYGJGjhg75WidA9aSo51k3rTYXtfPtafuw6/bcJsc?=
 =?us-ascii?Q?KCupPSQU0ug97MZxDJ/TN8M9KgVkHJwI+/bJMKbkpW6htSozATUFQKKEMV7e?=
 =?us-ascii?Q?VDF9QeSp3Ndm3a5RFzXRSYf2+3kmhcRCN10N/IhzCvvsIdBQUZe/D/4MAsvH?=
 =?us-ascii?Q?hBfyP1PAt3mY6OGNHuB+YFliam3rz87zzxbN7ZFvkZo3e5PxRAFDnpR0Kblr?=
 =?us-ascii?Q?FJVeXZRkrPteesmwaRu+FFF8LGHvWQnR95qAzIYzaykkPjsiLqHNTPsvrfOT?=
 =?us-ascii?Q?efDOtKN43aC3+zSIDTFUEyJpWCBrMgGgkPUMW7oPqOnk3oMsFH911IQ7jr8t?=
 =?us-ascii?Q?StgKE5xRfhT7qnByZDTtT1BhIWrRRE18XLNLZBLZw0gwc1YpYsrSfM3fjaf4?=
 =?us-ascii?Q?oOwwrjuV5pAn2KZL7/Tkjc7X1wu+FvgG3ImVC+ydJUI9yyQcG4t1mljJxvQ0?=
 =?us-ascii?Q?fPPjmpHkHHEG2CzH2GjDdhZexUXc85+ac19J9Inbpp/Txhngjv+Vv8Qz0req?=
 =?us-ascii?Q?ufpR6sM2drB0ao2cwNp7a0cqhG7IBabtvL02Lg/+bkprJAZqvRzLie/y7zzr?=
 =?us-ascii?Q?32WYTxBKgwP8+B36CCJKbA6El0i+344AsTKZAdYgCqCZoIoZgSipKqJj5JDz?=
 =?us-ascii?Q?1nRGo2pbHD/ECBWwfb49r5KHgjpnkpC0WbhbOP9OFq5XsfIZNGZzZhimQYop?=
 =?us-ascii?Q?2BbnKCzdW2pnxQDmDQE8UUQqT4n+x+shNGFNYGmLk3uzgqsVyOg4LXxyxMAm?=
 =?us-ascii?Q?Y+d+sKwUVT55O4f40ZhWcpEyBl8/dqZKiPz7Yp+CWkwjGkJwjMfGuCj56ZXx?=
 =?us-ascii?Q?fcpZAm8MD0cTC1T/nI3IT/cktfrZlZuATqPL6/QcA8U272wP9fchfi/5a30x?=
 =?us-ascii?Q?gBgUzFt9KolgDhnawCkW42lmNKRzXW5JaLEFqTg37VMcDqH7M8b2P+HRo1rQ?=
 =?us-ascii?Q?zARwNSVaDKs1GQbNmqvMS9adTDV8acILpZRVJuTcA1+wKj01t/uWvYWYvhyq?=
 =?us-ascii?Q?x1ygPCTe7PRcHfPwPMMbJ9tA7sTK4/I89UY/6O0bniicT4a+Y7jmSfbHw+S1?=
 =?us-ascii?Q?G+wOG9+RkkTVs0lohlZ7TXOjRwFzzrCN6R37mZ8wFkW87uCz21WeXgNrDYLH?=
 =?us-ascii?Q?+Rml+bJzsn6X9WzKmRGlUlAG3NrKNk00tRm8iQVi4Dx9U8SwmpDQehr+2W7z?=
 =?us-ascii?Q?33iyz2jXUsiMdXRdQ2Ft+a82gkMNnI9g9GUwmYJiD/obWylJVjvCPUYP7RbS?=
 =?us-ascii?Q?4Cnk9Fv+rXeXB6E5F4PAf3vivxnXzjdJxw12cYR5jK66k6/gA3Flpq5DOmqD?=
 =?us-ascii?Q?TCSFJsvAnbATcLvwNo8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e40ace-d0b7-45af-cb9c-08de100bf534
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 19:07:48.0550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7zDX380iVaGZDfa3/bFGyKFNZqQhdGzpt0nj7hJTkIjrW1Ch9U0qUG8FhUtAH4fY5XgwUc77NQnKMH0/WD5/ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11288

On Mon, Oct 20, 2025 at 11:51:46AM -0500, Alex Elder wrote:
> Add support for one or more optional exclusive resets.  These
> simply need to be deasserted at probe time, and can remain that
> way for the life of the device.

Nit: please wrap at 75 chars

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
>  drivers/spi/spi-fsl-qspi.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
> index c887abb028d77..1e27647dd2a09 100644
> --- a/drivers/spi/spi-fsl-qspi.c
> +++ b/drivers/spi/spi-fsl-qspi.c
> @@ -36,6 +36,7 @@
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_qos.h>
> +#include <linux/reset.h>
>  #include <linux/sizes.h>
>
>  #include <linux/spi/spi.h>
> @@ -267,6 +268,7 @@ struct fsl_qspi {
>  	const struct fsl_qspi_devtype_data *devtype_data;
>  	struct mutex lock;
>  	struct completion c;
> +	struct reset_control *resets;
>  	struct clk *clk, *clk_en;
>  	struct pm_qos_request pm_qos_req;
>  	struct device *dev;
> @@ -857,6 +859,8 @@ static void fsl_qspi_cleanup(void *data)
>  {
>  	struct fsl_qspi *q = data;
>
> +	reset_control_assert(q->resets);
> +
>  	fsl_qspi_clk_disable_unprep(q);
>
>  	mutex_destroy(&q->lock);
> @@ -902,6 +906,10 @@ static int fsl_qspi_probe(struct platform_device *pdev)
>  	if (!q->ahb_addr)
>  		return -ENOMEM;
>
> +	q->resets = devm_reset_control_array_get_optional_exclusive(dev);
> +	if (IS_ERR(q->resets))
> +		return PTR_ERR(q->resets);
> +
>  	/* find the clocks */
>  	q->clk_en = devm_clk_get(dev, "qspi_en");
>  	if (IS_ERR(q->clk_en))
> @@ -923,6 +931,10 @@ static int fsl_qspi_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>
> +	ret = reset_control_deassert(q->resets);
> +	if (ret)
> +		return ret;
> +
>  	/* find the irq */
>  	ret = platform_get_irq(pdev, 0);
>  	if (ret < 0)
> --
> 2.48.1
>

