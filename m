Return-Path: <linux-spi+bounces-8428-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C46AD3C86
	for <lists+linux-spi@lfdr.de>; Tue, 10 Jun 2025 17:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A86616B6C0
	for <lists+linux-spi@lfdr.de>; Tue, 10 Jun 2025 15:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A10238C05;
	Tue, 10 Jun 2025 15:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q3FGrDp6"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010016.outbound.protection.outlook.com [52.101.69.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B022239585;
	Tue, 10 Jun 2025 15:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568533; cv=fail; b=Mb2ZZyuCQYGVvzhqmdSCImmBcDq0YasgHh4mzR4Te56dl9aV4Uk20uUDsUv/59dylxbOl03gO4QwzL3Et6Xsn4rPSBym/ut0XCl5yjXifApmBvM1ij+E9PsreuoSsfXkEzM+SMY50+TbC+YNyB06k/BCZwQcNqNGwiJw0ov+QoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568533; c=relaxed/simple;
	bh=KaKtygIEoUrL3mKC1ARuuId+jb1txHcWgFwAkRHjF1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OtqqpyuXiZeqs1ZQ1isgK6R4dePNgbJ1UNYttSEa0PWOPX1+IVwRMbkS3DdyEeQ+r8YTiILkHObIq+F+rMBBl+4go8HLKx2EDwUrdMTOuNMiATV4FNyEYFBt/nEELPVRsFsjELr0fjJcQP7LvfaIymZTw0S9+KpAG1uQfnwUBJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Q3FGrDp6; arc=fail smtp.client-ip=52.101.69.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F8NWWub6QZBl3va153XlpBWAj4jBsywR0jMeE66b0823p9YfJuHqyPLKlJoOTm36q/gOOrNE9/6RacQeNNDxLbY+HjJoS6kWkvT0rrJTvcuCdXXrkHXXymr6uQPsrLw4oC8kRAiYv1Il6a1TrXfyEgfm30lR9jSrNb7lzmI+2p6GwZ4QZQp2NIKCxyyv/0uU9BtAd02D7Xhb65UHn/OlBkv45tAeiqZotA7qxXbo7PGs6V9N8yLFpNWMRQONl1ta7NL7/CtcOvQaP3Ai6PdU/VSfASanZqVyOP9aCWX/8vjbSYNt0YAEzZqgfnRku+KRSigXUUXem/5gh2C/EUUFEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFfTqRZYif3vuSbrvIgI4OpI9G2MYtI1Ab2vDbO4J4A=;
 b=ylWbduHI4w5W0evLaCCwY7bnbfL0ZB2x1MC7wi0k2wfMQuxwE8G0Q8anLe94+Zb1sBLkoHfdHjCw3WYN5sWal1oeEejG/GCwOmM2dRqYAKxpn4hZFec8+zqKebdMVEEwvJ89blsYi5sojAFKsvaR7o3y4QIx0aYbDPyaSDBMYH/nVtRLa4qM6nLaBRxF5V2B+cSOCmgGt5wz/shYMrQFnoUVBhNvak3kLXhbGh9Nd5R/KtMmiOi66IcxKliNAfkYvQm/YKIkvL/mytaS7UTmpfoe94g+GbwReTNdVfM0NEsKgVV4I9pxnbYyQwevgajaNNk7saxoxgayIcTjEker+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFfTqRZYif3vuSbrvIgI4OpI9G2MYtI1Ab2vDbO4J4A=;
 b=Q3FGrDp6YqXbLFQABljtCXgUtE1LXtFWbp/CBMCh03yNfIXjZk+mhZX8VM8nLR8+nY0wPS5Td4NKOEws6BPkjv0C4k9a4Vh/HHuwspdnrdZ5uMmW3LDmSOysK9L/I1lgTG7PIjsltpv44LygTd4+buzHpM+0DW1wWy+9oo1q86c7pz2nWnkdjDs9zLboS+3FY/MEGFGfVfVy8QDUxKs+gzvFyyCljBDto//gtpoYLvHm+bCz0HFCYlDuzURaEYZXFsCXVVP8mUEgT1c1SIBGMkYzEQRs44SltIhBmw34laUy84qciw65O3f6U/0fbRvZ2ZE7XNqeVRg2MQpWHWcXXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10153.eurprd04.prod.outlook.com (2603:10a6:150:1a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Tue, 10 Jun
 2025 15:15:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 15:15:27 +0000
Date: Tue, 10 Jun 2025 11:15:18 -0400
From: Frank Li <Frank.li@nxp.com>
To: James Clark <james.clark@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/4] spi: spi-fsl-dspi: Use non-coherent memory for DMA
Message-ID: <aEhMBsqlx9I4XqJS@lizhi-Precision-Tower-5810>
References: <20250609-james-nxp-spi-dma-v1-0-2b831e714be2@linaro.org>
 <20250609-james-nxp-spi-dma-v1-2-2b831e714be2@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609-james-nxp-spi-dma-v1-2-2b831e714be2@linaro.org>
X-ClientProxiedBy: BY3PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:254::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10153:EE_
X-MS-Office365-Filtering-Correlation-Id: 8797bee0-1ee6-4f0b-0f5e-08dda831a1b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AZe979WDaYwjlzwADbEOJKan3cJKpZ5KSLwsjMRKoOP6i/AKj/3FVlsryhpe?=
 =?us-ascii?Q?63WeHRsSxOIQmVfiP69vZCQMdmlgs2paYbYR+UBj7HuPiHSbbDmb9nNVQudP?=
 =?us-ascii?Q?hz7dWPhuDSmh9gOxQsUuTvtyXlxbnd4+ixlYVOFRxDT6aEH6Fea9KlkPgdzR?=
 =?us-ascii?Q?5q5pZaRqEOpa2zCvcyb3RtTh5gst1LxjTSAutCqYYTvIOhLxAJuMxkyVoQVe?=
 =?us-ascii?Q?Z+hnDET81WB5DAMxk/CGCvOUH1O2d5exdpxxuERGb19KX/AtRqcnz+IHo7Og?=
 =?us-ascii?Q?hjIOP2MPz/rv9Mo/Mggmf4u5FXrQf2qPPz/ndOnizRGSdBbhVDXEcxu5OmqD?=
 =?us-ascii?Q?bcDJoa/kjm9qnNdF47Q1AkoeFlMm6hqflgFjdRq67cesdQMo0prP+CXapdkd?=
 =?us-ascii?Q?nW9Qf/EHJL/bYa1YqNPrXQWaicXhNm/5KxL09qjH8tKk/Kp0X4UKoKpRWNTH?=
 =?us-ascii?Q?61atXcIwlnosGCQlr6/M4usEqnmMduHWKOtgk8DdDfU1eNCuLII0uO2FhZEM?=
 =?us-ascii?Q?WbZbhxiPwRLf+2+tXP6YaVZ+PXniwco1ExNv9ZGuODlR2zNl44o+I3HMg0kH?=
 =?us-ascii?Q?XQ0wxGamVUGOmVdrcI+YccpOm6NtvKm0Rlq+Yq/o98hA8vH/Ypl1zwrxz4bW?=
 =?us-ascii?Q?kGcGp19Ccp/OlkbRF+pkjDh8+6d/gUGMP3sg1PhOP9kNg13tYoEKMcnrHuwv?=
 =?us-ascii?Q?dODHa1F7qJLNlp+3XafqUpEFomcSmz3da51pHo3Y0Sy+YMVJeL7rQtvpKceB?=
 =?us-ascii?Q?N0V4TrvaPvIKfzFvsghGuU16P6Ix6ObzfGofp/kwVbmArrVGnCG/8mlzDk33?=
 =?us-ascii?Q?MuPA86+gY80CiPszPphAWDmv1cUD8wxuw/o8QitXGVX2lASKc251Py9jYAV7?=
 =?us-ascii?Q?+vZtrseaz6r8PK/s8qA3sE6q9nRnPRfSf0o6tKvmrQQLnnYItfzYaNJrHjQh?=
 =?us-ascii?Q?h/jioPzbV3W+paf+rhAaYOpXXqjArE6EzmZLSLKceXolbgVVsh3xAogdnGAh?=
 =?us-ascii?Q?LVTxpveTLpkXZcZembnIDFsqVbrmPWH88FP6+2FXUsFyPJRNf4UlPaJNlb/a?=
 =?us-ascii?Q?AhCIHPWZ7bWVVso3+YzMXcQ638+PuQmxh5rpAn/qJACJcU4mxPO0FP6oLOyI?=
 =?us-ascii?Q?0kFbPAGnL2KnG3BAlXuGVguX5vDU9/88+TMPBDVVxcrBhD1kkbEkPC3UngGP?=
 =?us-ascii?Q?7dbvXXDYhqD4VM9+OAKP/gTFakH+9cXqbgCj08p1GOyORokVzZYBPI2WOPGx?=
 =?us-ascii?Q?XBBXeoMb9RXjIxuWxZd0jLmDbPYr/XaXn+q36NfJQaRbUPFXo/aVCEdwU3tt?=
 =?us-ascii?Q?wBVmlLfmyR4fP5i/C4pnriLXLauza7Fv+bUB9319gHk5XIy+bJkF/ztmHqzQ?=
 =?us-ascii?Q?6X1TDg9ZXMYZZ9C8nI7aHMrLI+GRkRBqvv1fxwwHN0sswbWAKSt2fVOpEJki?=
 =?us-ascii?Q?49EE6gRQCC1CQZdF/ToP83pTLkOvdr9o+kV+087+56H6hYw2OGwH4A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iBNHPBcENEhZW50q36kSr2G29PyxenZ3r6qaydZC0/SM29fHDR1UqI03mE2T?=
 =?us-ascii?Q?N78K45RDfuV7bVEwVtXzhddMxasevy5LTzfmfhSiQsvSmCLwfo1v/FtkZuw5?=
 =?us-ascii?Q?pBkwfxRq6FFpiFAHakLzbQHx3bmU9SnDMi+36n37BsvjHo56zetW3ZcbQEUJ?=
 =?us-ascii?Q?TmNPPPwX3OzgKqoGS+TJC5xGKL5MeXLF68LmZTIF8jsSqQyxMfAv6bjcBw1l?=
 =?us-ascii?Q?mo+YdTFguFu4SF60qAitz3pLK5v9HaxN2MqDo2wi+a21xgAGQfM9BGXLWPYm?=
 =?us-ascii?Q?D+TmtcGdvfSFjSlShJazixGZbp2D4l8HQi3bSMsYbqfs7KzCQorT004TwdpQ?=
 =?us-ascii?Q?M0LbqZiHl9hGhYk0rr3nRlXiyMlLX4cZquq5r7vLS7Gidvy7SOXFnF/ISE83?=
 =?us-ascii?Q?4zMpITzOlY+xJndJ+aPwbxbYwIJE01tGsagiuHTMNp5s48t2o7s4hPyZ5qgm?=
 =?us-ascii?Q?Ztda+/JBhG1FcTh3eM/6c4tR2tUXI+oAtGjpJlwcdPggDgCPOvoz3zCSMn7d?=
 =?us-ascii?Q?NwoKjxQaIQsw7uNN52j0iY0jtlGo+PEJn9L+sqRFY5ENXJvBhQlhowE12kjc?=
 =?us-ascii?Q?FaF4sJzFt6uZ8AyL9V8ljKnEOJAjnxy1QyeJO9NNxl5hM9LoL7PjQuO456+S?=
 =?us-ascii?Q?bgtjzDmve39UZQR7bK7xRigy9EffSKqmlbOFRPA6ka93Oo0FRF8I02m2ZoFo?=
 =?us-ascii?Q?nTRnvXiAWtevz9JeCcUpzNm9+EzUJVakRY38QxiRhGQTk4xT18MkPmoLfHxk?=
 =?us-ascii?Q?KNCxt8yJFIbePsLHdulIJSM4BKA3Utoi0XCPwCAhP49jYCOAxFafkiVcipbS?=
 =?us-ascii?Q?cOePqQCHWU8kD5g5IkgUf2clB6BfYijLpuv0T6QeiNbj1C/utAq7o6r1JK53?=
 =?us-ascii?Q?xPOcHK+hrxGxfAuvjn9KIEfUgiupXqpJz0pQi0q4UwqOffWWlgHKVc6q3Y8s?=
 =?us-ascii?Q?BvY2vx6Rm0cJWFxmNfbVsJeeqCDXHfAf+31z1DUKAcUe/t7hp6iQqFZ5EHI2?=
 =?us-ascii?Q?XNV2R5fSHPuRHoGvfxX+4ttD1TlQkPv2RZWJe6lKSKzXdQBJtzdyTJQVxqhL?=
 =?us-ascii?Q?3A2Py3RNYdn+ozM4M7xXWhS3r5/jCq7Fi2Qelg6aaB9EMwWg8Hx+1CQ9mcCX?=
 =?us-ascii?Q?6HwuilE0FUHodQ2Vajv5uS7DqG1P9PGzgyQEY6Mgq5PF4tXWWqRY7qXRjmkY?=
 =?us-ascii?Q?peWlQchKPpablWA3IGwq4UMLqfouIyq8FysBp4r7z4wGyJ0RVkWo0z4tvUDf?=
 =?us-ascii?Q?duILt2yJnr5fni8xbYnEVDPUPPHmHZDeMTsEVMcYoZG+VIxTW+GFefQbPuUd?=
 =?us-ascii?Q?urPbUq1sGY83PLaym5rkHHW1VTNuIYN8vGL7ULLQfc7/XvUhVCDdIE7I7r9z?=
 =?us-ascii?Q?yFoPVzsWPGC/3uh2CA93Hbm/PO5gCfAkS64QjqQ7oAuTP/gxT9mqxIzQUhY1?=
 =?us-ascii?Q?F0w3hNn1jyfgK0NKF5cFssfXjmSD5+v10gyAXvUPB9SrrS/NXeafX9w11X5u?=
 =?us-ascii?Q?KrxeFkmNla3+FD0WL6mxjl4DsHL53Yl/mWeHcgID3KmigqzRUY65AkB8oa5Y?=
 =?us-ascii?Q?k1Kee+YZX3HVgz3nIJQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8797bee0-1ee6-4f0b-0f5e-08dda831a1b5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 15:15:27.8727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vHuHNw39XvV1iFztoLpFMai66XX6r1/I3zX14HVLoPWmu7PD8e6/sW/vQgxtemY2U/ZPC3GZBLeW2TD0qxKxyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10153

On Mon, Jun 09, 2025 at 04:32:39PM +0100, James Clark wrote:
> Using coherent memory here isn't functionally necessary.
> Because the
> change to use non-coherent memory isn't overly complex and only a few
> synchronization points are required, we might as well do it while fixing
> up some other DMA issues.

Any beanfit by use on-coherent memory here?

Frank

>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  drivers/spi/spi-fsl-dspi.c | 55 +++++++++++++++++++++++++++++-----------------
>  1 file changed, 35 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index 386a17871e79..567632042f8f 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -247,6 +247,11 @@ struct fsl_dspi {
>  	void (*dev_to_host)(struct fsl_dspi *dspi, u32 rxdata);
>  };
>
> +static int dspi_dma_transfer_size(struct fsl_dspi *dspi)
> +{
> +	return dspi->words_in_flight * DMA_SLAVE_BUSWIDTH_4_BYTES;
> +}
> +
>  static void dspi_native_host_to_dev(struct fsl_dspi *dspi, u32 *txdata)
>  {
>  	switch (dspi->oper_word_size) {
> @@ -361,7 +366,10 @@ static void dspi_tx_dma_callback(void *arg)
>  {
>  	struct fsl_dspi *dspi = arg;
>  	struct fsl_dspi_dma *dma = dspi->dma;
> +	struct device *dev = &dspi->pdev->dev;
>
> +	dma_sync_single_for_cpu(dev, dma->tx_dma_phys,
> +				dspi_dma_transfer_size(dspi), DMA_TO_DEVICE);
>  	complete(&dma->cmd_tx_complete);
>  }
>
> @@ -369,9 +377,13 @@ static void dspi_rx_dma_callback(void *arg)
>  {
>  	struct fsl_dspi *dspi = arg;
>  	struct fsl_dspi_dma *dma = dspi->dma;
> +	struct device *dev = &dspi->pdev->dev;
>  	int i;
>
>  	if (dspi->rx) {
> +		dma_sync_single_for_cpu(dev, dma->rx_dma_phys,
> +					dspi_dma_transfer_size(dspi),
> +					DMA_FROM_DEVICE);
>  		for (i = 0; i < dspi->words_in_flight; i++)
>  			dspi_push_rx(dspi, dspi->dma->rx_dma_buf[i]);
>  	}
> @@ -381,6 +393,7 @@ static void dspi_rx_dma_callback(void *arg)
>
>  static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
>  {
> +	size_t size = dspi_dma_transfer_size(dspi);
>  	struct device *dev = &dspi->pdev->dev;
>  	struct fsl_dspi_dma *dma = dspi->dma;
>  	int time_left;
> @@ -389,10 +402,9 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
>  	for (i = 0; i < dspi->words_in_flight; i++)
>  		dspi->dma->tx_dma_buf[i] = dspi_pop_tx_pushr(dspi);
>
> +	dma_sync_single_for_device(dev, dma->tx_dma_phys, size, DMA_TO_DEVICE);
>  	dma->tx_desc = dmaengine_prep_slave_single(dma->chan_tx,
> -					dma->tx_dma_phys,
> -					dspi->words_in_flight *
> -					DMA_SLAVE_BUSWIDTH_4_BYTES,
> +					dma->tx_dma_phys, size,
>  					DMA_MEM_TO_DEV,
>  					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>  	if (!dma->tx_desc) {
> @@ -407,10 +419,10 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
>  		return -EINVAL;
>  	}
>
> +	dma_sync_single_for_device(dev, dma->rx_dma_phys, size,
> +				   DMA_FROM_DEVICE);
>  	dma->rx_desc = dmaengine_prep_slave_single(dma->chan_rx,
> -					dma->rx_dma_phys,
> -					dspi->words_in_flight *
> -					DMA_SLAVE_BUSWIDTH_4_BYTES,
> +					dma->rx_dma_phys, size,
>  					DMA_DEV_TO_MEM,
>  					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>  	if (!dma->rx_desc) {
> @@ -512,17 +524,17 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
>  		goto err_tx_channel;
>  	}
>
> -	dma->tx_dma_buf = dma_alloc_coherent(dma->chan_tx->device->dev,
> -					     dma_bufsize, &dma->tx_dma_phys,
> -					     GFP_KERNEL);
> +	dma->tx_dma_buf = dma_alloc_noncoherent(dma->chan_tx->device->dev,
> +						dma_bufsize, &dma->tx_dma_phys,
> +						DMA_TO_DEVICE, GFP_KERNEL);
>  	if (!dma->tx_dma_buf) {
>  		ret = -ENOMEM;
>  		goto err_tx_dma_buf;
>  	}
>
> -	dma->rx_dma_buf = dma_alloc_coherent(dma->chan_rx->device->dev,
> -					     dma_bufsize, &dma->rx_dma_phys,
> -					     GFP_KERNEL);
> +	dma->rx_dma_buf = dma_alloc_noncoherent(dma->chan_rx->device->dev,
> +						dma_bufsize, &dma->rx_dma_phys,
> +						DMA_FROM_DEVICE, GFP_KERNEL);
>  	if (!dma->rx_dma_buf) {
>  		ret = -ENOMEM;
>  		goto err_rx_dma_buf;
> @@ -557,11 +569,12 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
>  	return 0;
>
>  err_slave_config:
> -	dma_free_coherent(dma->chan_rx->device->dev,
> -			  dma_bufsize, dma->rx_dma_buf, dma->rx_dma_phys);
> +	dma_free_noncoherent(dma->chan_rx->device->dev, dma_bufsize,
> +			     dma->rx_dma_buf, dma->rx_dma_phys,
> +			     DMA_FROM_DEVICE);
>  err_rx_dma_buf:
> -	dma_free_coherent(dma->chan_tx->device->dev,
> -			  dma_bufsize, dma->tx_dma_buf, dma->tx_dma_phys);
> +	dma_free_noncoherent(dma->chan_tx->device->dev, dma_bufsize,
> +			     dma->tx_dma_buf, dma->tx_dma_phys, DMA_TO_DEVICE);
>  err_tx_dma_buf:
>  	dma_release_channel(dma->chan_tx);
>  err_tx_channel:
> @@ -582,14 +595,16 @@ static void dspi_release_dma(struct fsl_dspi *dspi)
>  		return;
>
>  	if (dma->chan_tx) {
> -		dma_free_coherent(dma->chan_tx->device->dev, dma_bufsize,
> -				  dma->tx_dma_buf, dma->tx_dma_phys);
> +		dma_free_noncoherent(dma->chan_tx->device->dev, dma_bufsize,
> +				     dma->tx_dma_buf, dma->tx_dma_phys,
> +				     DMA_TO_DEVICE);
>  		dma_release_channel(dma->chan_tx);
>  	}
>
>  	if (dma->chan_rx) {
> -		dma_free_coherent(dma->chan_rx->device->dev, dma_bufsize,
> -				  dma->rx_dma_buf, dma->rx_dma_phys);
> +		dma_free_noncoherent(dma->chan_rx->device->dev, dma_bufsize,
> +				     dma->rx_dma_buf, dma->rx_dma_phys,
> +				     DMA_FROM_DEVICE);
>  		dma_release_channel(dma->chan_rx);
>  	}
>  }
>
> --
> 2.34.1
>

