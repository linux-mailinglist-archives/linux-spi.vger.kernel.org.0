Return-Path: <linux-spi+bounces-8478-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0822EAD73E6
	for <lists+linux-spi@lfdr.de>; Thu, 12 Jun 2025 16:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A6003A5323
	for <lists+linux-spi@lfdr.de>; Thu, 12 Jun 2025 14:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06E62288C6;
	Thu, 12 Jun 2025 14:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Iv8rhnCA"
X-Original-To: linux-spi@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013010.outbound.protection.outlook.com [40.107.159.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A158C221F24;
	Thu, 12 Jun 2025 14:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749738724; cv=fail; b=I1W3Czc5pJCTtZQRR2nTkSVNt2dvkfSGElapZu1/Uh3vyHs1TCC8sHJBiEqsMGwEnMYfManQbLu9+yg1nXF9BXEFhoy1KmVTjMxW0e5Sp1ngTWQMZRlPxN/CB8ivYLCoSm7QrDXg56I4AuYRCGl3hYJN0Kksh9lAos73visF6u4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749738724; c=relaxed/simple;
	bh=eTh8EfWRkqdhYOwDqha0xxGqLEuRJ9cKiC76i+P6030=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e7YwTvS6um92fQdj+RPgbmvp6hTJswk1+kH1zlZEr/2ELlOYw9O9EUHM44ayvQUoCsSLlgsgmFEVxiIwzIaY3BypuXxlaNaPznOlpvLsmhqWiU/DU0g2RZwS9eOyuEaEv4OD6qcXLfkEjFyoZ1Zx4RVOCNLhiFyAdQYICRsdkf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Iv8rhnCA; arc=fail smtp.client-ip=40.107.159.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IpMRpTB5xW6cV7+G8jGcXUmuP5CJ5fqv3TVX+Yxn/QZ8t3sRr4BFWSOGS9VstMneDCUG/wozzeId0QuA72Oe8D46F6tI1QFa9soFMzH4nxSo9DjmOSIUpr4U/BTN8AkqzhuFSLkTOWf7FO8MxXblsLiAt6kziyVkLfKTVPt3wVEBlyAl3Wf1bY8A2M+tfpB9GpTd4M2WaMzV2H3n8uTKpLB+NveCsOc/vOj+Y8tQivl1OgkcUMGG/rENNWyDXtl2I2NiTSB4CMHXklOzBDL/7ys8ymaPunmxAsUvoFAYSuYypoQ3mm2R+8RDUEn+WIoagYgePC+PUdxNydjlUEisag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q46Vpfo73SbAv9kfxg4IvHHt24Z+Re4glW8r7b4mP9g=;
 b=T5hHVNH+qmXkcy25Z7v8+dCnV/l7N5mz2sgsdjCR+qfhTPz80Uxruz4quU5m69Rne9nR34ZklRW4zZkZZm2roPL6VjTmbrWpou3NWjeuF0KtSO3N59ejQL3pou/9M3mIN9kuPQteyPpixgsjjAyt9fwhb98wCl7kPu66GWwD0GsdWNpj4Uad4F9JZqAHy1XPAyG5q8UkuLCUPHI0OdAfELJLVxGIxWSCvr95HY9l6om4iko0dh5ioY5haRkmTRKhawfnPSRm30f8xhNHr7c2CJO/RrSRf/A3LjNDXZltkEOSpN1O8GHJYEQlUPX6DTzT1jUHPLNyiyMY6VMKmh9QCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q46Vpfo73SbAv9kfxg4IvHHt24Z+Re4glW8r7b4mP9g=;
 b=Iv8rhnCA9PDQNsNb+5119Z6G9xnpxS1tq35yrRVZ6ykz/BWbH9pG4gGoU+J+p3Gl4E6XeBmT2rUpGaNb+uUBolJ4C3pYqMveFHBTo6HcxVATWU9EtG5xZZiKRYKQNCx0S6Hw1sHD2OFVJg+0QUVR2s244nJ4xks49JriURNa+B6cHOtl/5K3t8Kc1mFuS8Vc3TujHWDf50WN84iZ1jyBC671uKqY8Jd28zwuIEU2QY4mizVoY1orwcsxuW3lXy4SOxe4F/6fvg0ayydbFxcXG8oFJgG0ry/QKo6bXeH+E9jS1BeL3RwuFCD4YdkFSs6LolfsLjqC0pMTT4k8/k5IUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB7943.eurprd04.prod.outlook.com (2603:10a6:20b:2a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 14:32:00 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 14:32:00 +0000
Date: Thu, 12 Jun 2025 17:31:57 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: James Clark <james.clark@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Frank Li <Frank.li@nxp.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] spi: spi-fsl-dspi: Use non-coherent memory for DMA
Message-ID: <20250612143157.bu4vayvhieohdtbu@skbuf>
References: <20250609-james-nxp-spi-dma-v1-2-2b831e714be2@linaro.org>
 <aEhMBsqlx9I4XqJS@lizhi-Precision-Tower-5810>
 <de7142ac-f1a3-412f-9f00-502222b20165@app.fastmail.com>
 <aEhVsrEk0qv+38r3@lizhi-Precision-Tower-5810>
 <20250611090107.t35zatn47vetnvse@skbuf>
 <c65c752a-5b60-4f30-8d51-9a903ddd55a6@linaro.org>
 <20250612111514.rfb3gpmlilznrfxs@skbuf>
 <ad7e9aa7-74a3-449d-8ed9-cb270fd5c718@linaro.org>
 <20250612142306.3c3dl46z326xvcud@skbuf>
 <5b21c4c9-0ef7-41e5-a3bb-5a48a0c73644@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b21c4c9-0ef7-41e5-a3bb-5a48a0c73644@linaro.org>
X-ClientProxiedBy: VE1PR08CA0013.eurprd08.prod.outlook.com
 (2603:10a6:803:104::26) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB7943:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c6c6311-a36e-4ab8-f78d-08dda9bde41c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2wIcrUo1XJ8CFBGMmqy4gnK2wZwJg3IfVCrBgPNS9yZzGLxJV2t2YRxPL0LL?=
 =?us-ascii?Q?6IHbjuTvK75ZXrN8svx67qrzFT4Jb49SVQG05hr8vHpRb3bUOzq3KPhG1kRf?=
 =?us-ascii?Q?C3eq/o5bUQ7BaBZELkoGD+wQhi6sUoik4xQ9l2RwzalvdKw7j4B4VBCWKmYO?=
 =?us-ascii?Q?4Qvud+X6g6El2IFIN4g15AhYsGh3yaJ0lydkWNmqFezIhezK1NPktrQr2g6W?=
 =?us-ascii?Q?PgC+wITXjPJVMaQY2DhfRY0EayiopwyEYiWE8T5aPT4WHc7ouzGtwqFrOVJo?=
 =?us-ascii?Q?GRmv9ddFJaIl31FLxAItyHjyZaNfSpJiL9j9mQAJV6IVPKX3nkDsWVAAxnSp?=
 =?us-ascii?Q?8jDXYVzG3WCf3leOzjQMGxKJWDwl/MSJjK/p4RF8OjNjdAqvsobMrKqq+RaE?=
 =?us-ascii?Q?9GXN/KsB+v+NOP2eqF4yzeZGlJtjFhy3RR+KWnCEwu8rjIJAYFk3tomF09uU?=
 =?us-ascii?Q?DJxIGEZE2Fryi6tzN1Uqv26+tXfsTo2hSmLo2NZLB4HSrVvD9qwdNK9wfq/Q?=
 =?us-ascii?Q?KxgHvHSSgYj8AZ7SItePs6Im6swmKJEZ/Ir3G+B5dkS6u/1KUxAwFPHe7dUc?=
 =?us-ascii?Q?eb+h9TA03SvevABsKA3kIgmv1MUOCcKTvojHUlQ/8HBYUd6nXY6fwtgxZ5J9?=
 =?us-ascii?Q?M0ilRxh9w3paXlq2zdUIRhOmBbjIPRhuNM0p+v6xJljVC9VDEqjRaauxm02v?=
 =?us-ascii?Q?PgTcdgUxvwYrxka5IVVz7RfY7U2TLRx8VgVAdJJXNZyLKE4loObwMeVRTfzM?=
 =?us-ascii?Q?jbMNamazpuw+qw9TiuVvqYuAESwaFG/+325c0rDbG47rNYM/g5SBoTm/0O8g?=
 =?us-ascii?Q?uPkTa9yIAMFnoMxMZmuKMkidGKspRG1omKNVeR9JgPpIU0lUmZKNFxLmRKty?=
 =?us-ascii?Q?zdQu1+UW9uYfYnG3Xd4zL4Nf6fI95g4q6uH79x2trSl6KGB7/ie5iQR5sYQe?=
 =?us-ascii?Q?/2cXjIonoo7gGbxL3ZHttk33q2Y5EZsdDTGgTMnCkvhbB9E4zuAmCPUq+M1i?=
 =?us-ascii?Q?tPxkfzTDX4muihXKdcfyuDorn49QhrCNu1EdaVMHex1MtdmleZaFWgbYEpIc?=
 =?us-ascii?Q?/8fnYDnM6e8z0QSrEwh5G3XT7RBoD2xCSfmbp3YdyhvefH4ajZQxZfPAmC1i?=
 =?us-ascii?Q?6sXT/RCvZJEbAKQrfRnR1e97jNznd4suIKGMUvTBpClA+/55voXqqldOvs/9?=
 =?us-ascii?Q?F2cW+Vv9tjuSCwshBNHNT05/Lhrs4fSL29ROdKa7dm3j093v3tfdpcjqL4Kz?=
 =?us-ascii?Q?KobQafwnFMGf+e7sJJerZBcH88Tcmn2pu42HJrRgeyJ9Co8zn3unTsTf6jmd?=
 =?us-ascii?Q?Sv4JODG832r3s6rLi48f7SQCFYeaqBzWQCIj91fr0PTWDLmUwI7uayFb8F0E?=
 =?us-ascii?Q?rElbe54rzXEuYumwGitxevOYyqlupP1/XdSgWqskVdC9+WxRgYLy8w8HeEVP?=
 =?us-ascii?Q?2OSXhfbLmTY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sJFUf751zVL0rPzYZY80GTi+JLwAd0kDh0d1fU74fptA75hOQMaKEOFIIG+s?=
 =?us-ascii?Q?ShXZWVU6XzcVqYvA84YdDbYY3PuQM95f5ivANqYzS2X8y8pBg8EHMnE6kT/A?=
 =?us-ascii?Q?Dz3RtH3SpvFfEI9QRR/sIiQj2nz6Sw8ljGA6IYgRBAuu5Gp+tcz+ZQEjHyPa?=
 =?us-ascii?Q?LbRvAPUcr3txOIykpVtp8hFT+0efCfjP2n8TF2SyB/KmLqOuzqTYkiLUvQml?=
 =?us-ascii?Q?QSm09mF/reX0gQL6RgslE2aodiJapmnr+lMijoLYvb980pmTC++hwrQjaEQI?=
 =?us-ascii?Q?5eKJANFnc3ltlWP2sw5xbo/t4UYWoRNGp9p/PvHgGzpIEa2dDOBMoLWiaSiW?=
 =?us-ascii?Q?iKeGw9/JFgS6Xv8V8RihAfZ04TThrBcpV4M5RMchmjGS0JKsfaEI8GrUnSu2?=
 =?us-ascii?Q?A3Yc/Q/FGd2B77aVavr3jghlqcb8GTSryjCpOHpyOevwp5cEG4E2PxUaX1zh?=
 =?us-ascii?Q?i0c6lGWvG54wobc05F6iWKda4KDhfX6eWbBKbhNSxkzq1HBMQVgjlSV1yZK2?=
 =?us-ascii?Q?Dg3wzgf7DhWnHxF2XD4uuhrCKXMkchWhOxGhINNck5w9lMEsQ2PrD5suiMfJ?=
 =?us-ascii?Q?LRPIvB5H20bCh5ih8W9Qdrf3i3C7H555uTwX19w8qSDuCgIst6HYbY/Uz/69?=
 =?us-ascii?Q?EOeygzlzKjjVENwbiJzTGV8Av0gtp2pMNyihHe0bF8BSjLntKsx6DYqxxhkp?=
 =?us-ascii?Q?UHNO7N3/ouSD9Vff2CZuj7HAM7uWJB3Q6FWIDu2FQYho3SI0STeMCso/6eTn?=
 =?us-ascii?Q?jz4b7nd6WFjB64EHXE3rXf6daVmcd5AlyTrWXCLGLeW2tHGZP6mmhkaVK7Nm?=
 =?us-ascii?Q?Ol5B4dQjHqROTMkMb+ceTgCAMBxJL4G6qoaWbnuwcIPfRAK5MAI+rtU9Hx7T?=
 =?us-ascii?Q?ufNkVbvdBniWGMiHz2GUVQddwQnPueLeMVDyahZv6xuiieHdDTuIKrIvXAR6?=
 =?us-ascii?Q?lgjxGc8ui2FENffaMV6ykxwPVFweLwT7NNd5Uwco4iyJG8dKF6JQZu2v7Psv?=
 =?us-ascii?Q?1sUdS+AzTapC2SEj9G3la/HXypgx/oiTQVPfGjKqmaV+rcct/4A9BF9yaXGj?=
 =?us-ascii?Q?QeN/c+hDvnmFohOyJtXF1tUQPIFlO6Sz2JZeAk5HAsUHe8hBSRSWWnjLL8bN?=
 =?us-ascii?Q?KDh+1jWYQcokptwrO3LdkOXwPUCkzjze4T3XqSJOlpg3nvtLSndREfAUXVOQ?=
 =?us-ascii?Q?du0U1UfHD14j466Iy5dJeOWBqDfeJPIsEpuSbuwhYX1+ihksAhf2WkesuHo3?=
 =?us-ascii?Q?AR1kYyIS5O9aGnDYftTyisZHvd+mrOPXLikFmN4Du4kle0oaiO87jbud5zTH?=
 =?us-ascii?Q?NxPf6CTc1dxYPawJEuxX+mz+tPF6xqenpZms4zq/F0YPQngDv+DLq0QA1SpH?=
 =?us-ascii?Q?2nNTkl22Wp5cRSbGW4/eocegQ57hOAyalJwXM+97Uw6U6tzl7a7px6cTjddT?=
 =?us-ascii?Q?BGAAT9GNvXLxTWanxbXq6p2nEpZhmDLpA6Ju3Puz/GZZe+XeKo/kPcNuALYD?=
 =?us-ascii?Q?gNh74j7B9RoD2AfAzJT3ZB/jHm6pkuzJQx98oEofOsr+/+8Nfmaair7FIcDE?=
 =?us-ascii?Q?T9KxEDQ0ddCTo2RxSAyg4GEjZm5Cl2pdSM50r0y/Po9v5zdb24V/OkXzquEn?=
 =?us-ascii?Q?UQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6c6311-a36e-4ab8-f78d-08dda9bde41c
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 14:31:59.9784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zyOkM12dSyJrWDo1I/3HMODbGbaQLb2kuDCWP/1ADfmNscPtOQI4QBQ2s0RGYmdGNJOMWG0BtRMYV9TVXGyKqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7943

On Thu, Jun 12, 2025 at 03:28:37PM +0100, James Clark wrote:
> 
> 
> On 12/06/2025 3:23 pm, Vladimir Oltean wrote:
> > On Thu, Jun 12, 2025 at 03:14:32PM +0100, James Clark wrote:
> > > > That's why I don't like the DMA mode in DSPI, it's still CPU-bound,
> > > > because the DMA buffers are very small (you can only provide one TX FIFO
> > > > worth of data per DMA transfer, rather than the whole buffer).
> > > 
> > > Is that right? The FIFO size isn't used in any of the DMA codepaths, it
> > > looks like the whole DMA buffer is filled before initiating the transfer.
> > > And we increase the buffer to 4k in this patchset to fully use the existing
> > > allocation.
> > 
> > Uhm, yeah, no?
> > 
> > dspi_dma_xfer():
> > 
> > 	while (dspi->len) {
> > 		dspi->words_in_flight = dspi->len / dspi->oper_word_size;
> > 		if (dspi->words_in_flight > dspi->devtype_data->fifo_size)
> > 			dspi->words_in_flight = dspi->devtype_data->fifo_size;
> > 		dspi_next_xfer_dma_submit();
> > 	}
> 
> Right but that's before the change in this patchset to use the whole page
> that was allocated, hence the next bit:
> 
> > And we increase the buffer to 4k in this patchset to fully use the
>   existing allocation.
> 
> We were allocating for the size of the FIFO (multiplied by two to hold the
> control words), but dma_alloc_coherent() will be backed by a whole page
> anyway, even if you only ask for a few bytes.
> 
> After changing that to make use of the full allocation the FIFO length is no
> longer involved.

Ok, I haven't walked through patch 3 yet, I didn't realize it would be
changing that. I will want to test it on LS1028A.

