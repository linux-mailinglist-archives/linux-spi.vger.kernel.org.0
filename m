Return-Path: <linux-spi+bounces-8436-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 401F9AD450E
	for <lists+linux-spi@lfdr.de>; Tue, 10 Jun 2025 23:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5F3B1893787
	for <lists+linux-spi@lfdr.de>; Tue, 10 Jun 2025 21:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6876B242D94;
	Tue, 10 Jun 2025 21:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gRNE50i6"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011033.outbound.protection.outlook.com [52.101.65.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D81E27FD73;
	Tue, 10 Jun 2025 21:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749592364; cv=fail; b=SksfCjWOYV0yK+NhTg0zpwt9aJbO+jM+I/jHtnJ67hHMtRhfgL9oyINoh3AnlblZc77CNGi+gCyDIc0rkGyde5jViGZTpZqx8v76ONX1i6ga7xZ2VcRvA7da6lihiPgJscOiuUafE2xLhZkaBWQeTgeQTlgD/52gqHot7xg97YI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749592364; c=relaxed/simple;
	bh=vvPUt6tL9rim4VdMyFm0r7YPAsUGT/Ui2EO5bLeUAEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zc5OQpBhWyP3CbY/R5U+uomFIyz3gUDif6HiNtsbjaMwLpOajq1GXwdnEaTWoUfoHJhd3/Y3PMA+42zm39T0Q96KSHvi1aubgFKYUV09r9rEGHamCwyKc6l8jJIT+yVNPaSBPlbSZ+6wDswyDM/1qmZakxEMAdJ8AEyKoLU4R+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gRNE50i6; arc=fail smtp.client-ip=52.101.65.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wL1DDQo+2lymt//X1AJ8piDi9UZjRnZB0Feyoh26wi+jU+GWIclENC0CwDzudDL766382MQ2VMdI/KZ+rW5YXo/3QRZ2kywnc2yedUbzQOEOCOpj9TW/tjhVNkiJoBHLikleJwHbxk514drOHwy5bLGtn3F5I6sQuTMPsi9CXnUcHO/pSl6nZyZG/FkpGd5h5BLCK0i+63SLhtlCtMNpJ6hUK+rgM3DzB3kV6gpF5HwZvC+YzfoHnHyRa1KRQvOUTb4qqC7hK0MxGXCNAp65QTQCsGJ2jzGumr+3d3pv7SzeM8FVdj/Wtoc242ZwQs7ufp2UffWMz1PlvgIY/0LJag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9Opefa4BANhPC7X1y25r8ijlP9dUutnz0Lt0k39cIA=;
 b=TcDhITVOO/ds6BMSvlpwq8YP36iQoLvg16icGQRRglAJeXtbJGOV86goMk3dLLzkYI2AS05p1K/hToYmQe1zzks4pPXnTMbZoUygF7MHmcHdyCX1s1JQC66BrEwb7/wGn04C6tCQAcv/7CyoeLGS33Z7Q/m+FPlNbb+dZH+/0/UmVRmbl4xvrsEvuF21uTNSdD8OwdRX0K+pI4E6OuKgPHNvKAvODCTCp7pyfIG3+RQMz4gW/KurA5sA4nL0+yGg5xcWkfhAsy5qe1YM//a1PsGEj4fbbkfdx2yAstU0T5eRndOD4F1WyB1UwyqKZY2hI4r3dCighHy9nY826EQUYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9Opefa4BANhPC7X1y25r8ijlP9dUutnz0Lt0k39cIA=;
 b=gRNE50i6Plk1W27YDDUX4BiGH3yz/xDTxsS4YRDRxBtEw6pqWwnXQ71v3URMzQ41FxD7qg/6ujvs4mhY0p0cTC1+zMu7OinsO/CBiXORTMreYnohG5/ZOPxPHAWv1CxKtGwvSiGarAZjJ9HoqTRwJXss8yJEOJT0TUNdP4ue9sUWi5HipPJqFa5Cn62WZVfwTfiH686Hdd/4tPttmMgn9+ZKmbyD6vNscv5poamuwy1DvYk7sE+lDmRt1LWruwywOQsEvFmyWKToXwGBL/KZVvwMz3IuQ8Ej7QVkVBr2TIGa4VOpxK4Dw9WJYA9zddUQB4RNpYPsD0EEcpIkI4YQFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GVXPR04MB10071.eurprd04.prod.outlook.com (2603:10a6:150:11a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Tue, 10 Jun
 2025 21:52:36 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 21:52:36 +0000
Date: Wed, 11 Jun 2025 00:52:33 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: James Clark <james.clark@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] spi: spi-fsl-dspi: Report FIFO overflows as errors
Message-ID: <20250610215233.35ikv4sslkyukgwr@skbuf>
References: <20250609-james-nxp-spi-dma-v1-0-2b831e714be2@linaro.org>
 <20250609-james-nxp-spi-dma-v1-4-2b831e714be2@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609-james-nxp-spi-dma-v1-4-2b831e714be2@linaro.org>
X-ClientProxiedBy: VI1P194CA0044.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::33) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GVXPR04MB10071:EE_
X-MS-Office365-Filtering-Correlation-Id: 37f98620-4ff1-4d41-7ace-08dda8691c7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5TTY/D3RCq6Htnt7UT9Un1CBZj3njA3NxlQ3Lx6gsFXbwqBj7UQtW+91zfuP?=
 =?us-ascii?Q?AANrUuATO2sCT56jPidwIg4qehjTr0BhvihWAPk85IkLsyky4dexH0HECkNJ?=
 =?us-ascii?Q?mOG1ft9UXV2jz6EpabgakV+vS9Ad+NBnMorP7pfFe5XU5Eimu6LQcTzXKw9A?=
 =?us-ascii?Q?GkYny+aAeFHOusKPzxvOheSbT3a28zpfGB2pcuVC3Zw9Qf191aMJeoJEowE7?=
 =?us-ascii?Q?98UVOL7ZCDj0FvkmjDu1ZuwXqD/TCkVU3ZWQhcN9mArgoMibQkqxoPG221oT?=
 =?us-ascii?Q?FLj9rlzc6i52VVbBK/q7t8p5wYeGcr8Q5iwDwlI7bLwFzSowDdpQVOh6acqy?=
 =?us-ascii?Q?WTDaiSzsfOeSFGUVl+1D7UZkOE+G5leRj2byX0K0yvhjFCaS4YfTWG+Lhkyh?=
 =?us-ascii?Q?XVARwGFMM4T25Lj3bodea2Dg6gLd9Ows2KOa7/8t4X6aD1e16lMcq7EuLlxX?=
 =?us-ascii?Q?mQbxE/BVE07nyaRE0FU+gIpFS3qLWehf4BtCI8EnlwXqcQaR7Ob3vSvOd5BT?=
 =?us-ascii?Q?AUBkR2vy2IXr7x9Eqm6u+vLhRD71nx7HJe9CmGmgQoUear5C6tol0EMFLoN8?=
 =?us-ascii?Q?Dmc8yLwLceqdXei257BfcylhtzM3pViGHV3Mk1H1HkkhGHyBXvooISsph7YC?=
 =?us-ascii?Q?HfIp8z7ZOp3Dqnq72io7MZXp1AXNtkgW5iyTmPxqOMRAP6KGhuyYxvODiyPX?=
 =?us-ascii?Q?cbbD1QRBdk+n6MEMAd1yQjsAV9Y1A2TwP34+A2ebCAGTjzSBfFDAguDaga0D?=
 =?us-ascii?Q?gHAGnZjnRB5Thk8j10aIeztO7GsLIvd6HRSvi5vEhm9kOY2aW+zixQR/ydVn?=
 =?us-ascii?Q?e1LHuhj0wmanHNvsMmLEqCQtbYtTA9TYFgIznd9M3TJ3o7eUJI7JDBv14FBe?=
 =?us-ascii?Q?qMEbFnWe1a1fc2PXgl6ctS4rUXbh1Q3fm4UWoXM6W4tNeGVCRtoHPUzuCuPd?=
 =?us-ascii?Q?5ml6zJ9mhyI45Xd6UfzdTqVxToZzs+k8d58twgDTjdjNZDrwDfYrkn6mX3oc?=
 =?us-ascii?Q?GFF+HqvNRbAgl+15WqlZkQtsSJtO0sZebOmVy/k4pVdwDDC8bBvJq3IC1IR7?=
 =?us-ascii?Q?72u64pIGuq96sH79mT7L9/b5ph35p3DIPqnsx3bP51wQVqJm9SiwxLm5fGaU?=
 =?us-ascii?Q?u/o5mJPYySkr+XQ1HwVCvy4G953Q2P7iMG04c7+XflWfFibBQpq5Pj9pW/ST?=
 =?us-ascii?Q?+Svnh2FgRbEcswYNcNIjEujaXiS+UGdamNvJxhryAUyOYWdZ9ggJwHtxO9wP?=
 =?us-ascii?Q?Jw1QXlPM4ZKSGuvFcPKnszoDkrm2J1pm8kF/ynZEbVbUueIRD3iK853HuPZd?=
 =?us-ascii?Q?WHfo5lF4woEQMlCBCaeHQfmPA6dYOYMc3Yq7w6d6wwnKkghWMEnVXPI9OqzC?=
 =?us-ascii?Q?ouk9Imc6Y06N5s0sc5veUxJRnFb0dP/hOwm6/YBHsf9tEd6HuSHJ4I+F8O6q?=
 =?us-ascii?Q?SMacdU/z3cQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/UErteI6dphjeRwom/aephvh7GZo1hNAV99YVwTkkzXLXAb0BGArQJFFTGjI?=
 =?us-ascii?Q?jvm07SDhJZbj3PpTghNeNUCfVmO/4qrIkXuqf2quQrQfQFCCHYYXr4EgspkI?=
 =?us-ascii?Q?jHj0MCjp72Q6sGeOZARqTKfWUz2B5/GzPt4iL90jzl9bbW9HnHV9QE5L/j8i?=
 =?us-ascii?Q?0HvuvAPE75kjnhl/8J6as5DmGiDWT9pCThmIKKF1NJYekwrLbpmJoUZe2Vna?=
 =?us-ascii?Q?0g1+HLUVDK1vgrahjwtkkG9szEs2icEwHxgRrZRM9z8QhGze4MFe8HtFTYmL?=
 =?us-ascii?Q?AqcWATcH4V+CLx5goDHIuyhW4JwQ8tjQhYhbOV7bM4i07ShQaDaEDXlnAQv9?=
 =?us-ascii?Q?4klXwcDeZMzZXvGc35SR0k0lEiQGRbFJlXHJukE+ocK0zbdm8+DrIvOwC+fp?=
 =?us-ascii?Q?xq1Y2GsOezzp9ZwoZLVaLabdIbcYiw8/H8Vys5uS1z+kve7AIqYc8jpVApxV?=
 =?us-ascii?Q?rEpEiZbGsxy9A7Pp98/a4Ce95ivz30wgD7tp5WQP//5Y76nM+AnJesZnXiP8?=
 =?us-ascii?Q?VMklcqejUlfq5gJs8ehVmUaZ2rX3pmkk+Fq7znx8R5UhS01T2jHfZ55xYZh7?=
 =?us-ascii?Q?PVKYb6fEL/Iz60rpp3BQjayG2doArF0m1T9hbSLN89nU0KeymLh7uLHp3YSb?=
 =?us-ascii?Q?wJl3BXF2FVJLzCsrpGCGE6eBhM7JO16eoM55aFM/FnXHIwTKXR78xYwN6K06?=
 =?us-ascii?Q?qZVC9PqfYm7H1gJt3Q3fx+HfAMuNQlYbMOsTFkfJAEGMhPZM25/rCyLwEZw1?=
 =?us-ascii?Q?bjJJ4m+300thC+LQNcZiWTKjYCUmvZOJrIG7TdtyhcZ86KLKud4DptA4yGmL?=
 =?us-ascii?Q?v80R+JsIN4ErFj9ODCS45Ok30MzF+ru4Hjli7nvlnBF8/eblRJoUVdLfoI35?=
 =?us-ascii?Q?OYV9ihBK4CaJB67Ei5XbBhb2pzb0TxXzrgrXRQ2mX69ddJDNe1NZQ2TtP2PR?=
 =?us-ascii?Q?Lm2kwjuRDsUkMqJuE1ZaCe1asbTcrbigacIjQ4uJk+l/Y9EfH8Z4ernCbjxR?=
 =?us-ascii?Q?DD61kmwL7sl/nGZwaAfD+VPoiwvFfAUB/Bh/UDssAZimWHpuTYgO93ok88mv?=
 =?us-ascii?Q?kXLB+CmKtA3TO1oDkMLK9vGFHwYXrVJCG209FDhhRsX9wGLtNXOxxEbi5Cti?=
 =?us-ascii?Q?/vLMt25yl1vaiKf0cLxtIaEQdX3Znx+lJwbvqiYdmX4E3I601k/8OCA3UDTl?=
 =?us-ascii?Q?V0JB83Ab6hrTJyLNC/oRz9jpB2LbJEGMpCSr52OetLiZa3ybA1IpOwSNYyAA?=
 =?us-ascii?Q?GFjJXPMW3e0v1vDRI5tbj/534pkQ1iPLbCWTJNv2YirHhS7jfJS2z0ZTy3Vf?=
 =?us-ascii?Q?iipRFC5Xbgr2Xbl7V4SgbuRgFrtwkwoxgqWnqL5AZbfgEcMzolBb+h35GvWb?=
 =?us-ascii?Q?R9OP+v5WffZFjXJvXwAIs7rIC4iDO1XpsMeoRAKNSf2wYs1RPM/EZychgitv?=
 =?us-ascii?Q?YyQjnFvwqgTLO8+zFz8VD2QW7UQpxp+yRS1jKqJ2S1QURqM2j2wo7Qc5C32+?=
 =?us-ascii?Q?fwwt7sfV9WPfVheg+Ahgp+zDapFayfJibAtQhh/mX/S+dZMlfayhEU00EbZZ?=
 =?us-ascii?Q?zGoMeqI87VNzibCtkFM69S36WmlUe/WPx9xWcdacVcZQsmdUzrgYS6CKDtON?=
 =?us-ascii?Q?4A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f98620-4ff1-4d41-7ace-08dda8691c7a
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 21:52:36.0579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GpoOxLg1Xnda28jtq8jyvL6iLNXSx/VjvdSKxj/WV19aMnVkd8G9hXkaMrLTptAxE0Hlp79fbDk2eOBtNocjIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10071

On Mon, Jun 09, 2025 at 04:32:41PM +0100, James Clark wrote:
> In target mode, the host sending more data than can be consumed would be
> a common problem for any message exceeding the FIFO or DMA buffer size.
> Cancel the whole message as soon as this condition is hit as the message
> will be corrupted.
> 
> Only do this for target mode in a DMA transfer because we need to add a
> register read. In IRQ and polling modes always do it because SPI_SR was
> already read and it might catch some host mode programming/buffer
> management errors too.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  drivers/spi/spi-fsl-dspi.c | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index e211e44e977f..75767d756496 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -228,6 +228,7 @@ struct fsl_dspi {
>  	const struct fsl_dspi_devtype_data	*devtype_data;
>  
>  	struct completion			xfer_done;
> +	int                                     xfer_status;

This is certainly simple, and simple is not bad.

But based on the fact that you care about the xfer_status only when
there's an associated dspi->cur_msg, have you considered to update
dspi->cur_msg->status directly?

You'd need to reset dspi->cur_msg to NULL at the end of
dspi_transfer_one_message(), and then check for NULL when you update
the transfer status.

>  
>  	struct fsl_dspi_dma			*dma;
>  
> @@ -504,12 +505,22 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
>  
>  static void dspi_setup_accel(struct fsl_dspi *dspi);
>  
> +static bool dspi_is_fifo_overflow(struct fsl_dspi *dspi, u32 spi_sr)

Can you name this some way else, like dspi_fifo_error()? It's strange
for a reader for this to return true on an underflow.

> +{
> +	if (spi_sr & (SPI_SR_TFUF | SPI_SR_RFOF)) {
> +		dev_err(&dspi->pdev->dev, "FIFO under/overflow");

Missing \n.

And you should use dev_err_ratelimited(), as you don't want an external
entity, when in target mode, to DoS you.

Also, could there be individual error messages for TFUF and for RFOF?
If you are concerned about the penalty for the error-free case, make the
check two-level. First for all errors, then for individual errors.

> +		return true;
> +	}
> +	return false;
> +}
> +
>  static int dspi_dma_xfer(struct fsl_dspi *dspi)
>  {
>  	struct spi_message *message = dspi->cur_msg;
>  	int max_words = dspi_dma_max_datawords(dspi);
>  	struct device *dev = &dspi->pdev->dev;
>  	int ret = 0;
> +	u32 spi_sr;
>  
>  	/*
>  	 * dspi->len gets decremented by dspi_pop_tx_pushr in
> @@ -531,6 +542,12 @@ static int dspi_dma_xfer(struct fsl_dspi *dspi)
>  			dev_err(dev, "DMA transfer failed\n");
>  			break;
>  		}
> +
> +		if (spi_controller_is_target(dspi->ctlr)) {
> +			regmap_read(dspi->regmap, SPI_SR, &spi_sr);
> +			if (dspi_is_fifo_overflow(dspi, spi_sr))
> +				return -EIO;
> +		}
>  	}

Can this go within this block from dspi_next_xfer_dma_submit() instead?

	if (spi_controller_is_target(dspi->ctlr)) {
		wait_for_completion_interruptible(&dspi->dma->cmd_rx_complete);
		// here
		return 0;
	}

>  
>  	return ret;
> @@ -918,6 +935,8 @@ static int dspi_poll(struct fsl_dspi *dspi)
>  		regmap_read(dspi->regmap, SPI_SR, &spi_sr);
>  		regmap_write(dspi->regmap, SPI_SR, spi_sr);
>  
> +		if (dspi_is_fifo_overflow(dspi, spi_sr))
> +			return -EIO;
>  		if (spi_sr & SPI_SR_CMDTCF)
>  			break;
>  	} while (--tries);
> @@ -939,8 +958,12 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
>  	if (!(spi_sr & SPI_SR_CMDTCF))
>  		return IRQ_NONE;
>  
> -	if (dspi_rxtx(dspi) == 0)
> +	if (dspi_is_fifo_overflow(dspi, spi_sr)) {
> +		WRITE_ONCE(dspi->xfer_status, -EIO);
> +		complete(&dspi->xfer_done);
> +	} else if (dspi_rxtx(dspi) == 0) {
>  		complete(&dspi->xfer_done);
> +	}
>  
>  	return IRQ_HANDLED;
>  }
> @@ -1032,13 +1055,15 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
>  		if (dspi->devtype_data->trans_mode == DSPI_DMA_MODE) {
>  			status = dspi_dma_xfer(dspi);
>  		} else {
> -			if (dspi->irq)
> +			if (dspi->irq) {
> +				WRITE_ONCE(dspi->xfer_status, 0);
>  				reinit_completion(&dspi->xfer_done);
> -

Nitpick: The blank line was doing fine here.

> +			}
>  			dspi_fifo_write(dspi);
>  
>  			if (dspi->irq) {
>  				wait_for_completion(&dspi->xfer_done);
> +				status = READ_ONCE(dspi->xfer_status);
>  			} else {
>  				do {
>  					status = dspi_poll(dspi);
> 
> -- 
> 2.34.1
>

