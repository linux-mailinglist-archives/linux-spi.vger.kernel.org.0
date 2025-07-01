Return-Path: <linux-spi+bounces-8944-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B7DAEFCF3
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 16:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 650FC4806D1
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 14:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F4C1C07C3;
	Tue,  1 Jul 2025 14:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oBlJpvKV"
X-Original-To: linux-spi@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013018.outbound.protection.outlook.com [40.107.159.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7621DE2BC;
	Tue,  1 Jul 2025 14:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751381239; cv=fail; b=DYErxFZWIO5vc4+ILA+5rb/ZG8C+0q1YU4wmNU6BmZq9CuuO3uDA6uPVVrUvn6rAUxhKAMze7381LVfmzCHbXgF3cgzYJJhvqaXvUXrmwFLWeJvl/RcRcOB4Kr1r6x/cnKiwI/7tHdM7JHESZzxD5X/KTfiJVqgeLMjRWS3QMvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751381239; c=relaxed/simple;
	bh=U2LtkG/adjGndviwEHehoCQ7tEMiZGheHnaKVtRmEQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WPMrruF7xOUl71YC7JtukjZjHcSK7+JI7boSB6+YXaHqyEw7wnRYADJuAu8d3Wwd68SrsRlKgPObAhN5xfjHtyB7fM50Ybh28Jljx5F0i9m9yelNSTswJO41+6LkRTZ+uXJH4gCIapYmNVtUVRh52oFY7oxN3M09dEir+FlFgI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oBlJpvKV; arc=fail smtp.client-ip=40.107.159.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kDCZYWdNV2lz3mD9uUKxvSKjXQWxIIiRnJOX/4Bbbc1tufPFVfMuo/DE+/OwxRI/dJBJIv+cdwDphCthCPpniBBPAdLV5LhCWLOfkJsJnrA/WLGFqlL4jAOcyNAw4i1sZwJpkyrA+OV2ChSJT2NLCB3r2nKGjhtLKoWh+v+BHVmhjL6SnDWEbyzMgUqJBCqlbTWnDNFx/gixp7ektDlXTsk/6vWgu11YJrX0u4t9UGgfxx19ysMYJEJwUKLTN+dz6xlyEIKXKAwtK43v+0Am4b000vJmyIg2dhpQZ2+OxsIQvt8bTC1VKXawRYwgtyEUF44AYvlx3oyjnahn19w91w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1K4LtZOgP65LqK/poWXbLSSb0qdDxouQOm0z1uYl8I=;
 b=bbeVe/dC/oWOeujMWv3NsWUeDJRmdAPyEQesPQHPgr9EysHPMJfuTOxl3g8o9rt15ncSqUYd8E9a4Tua14oP1BnnGTLqQOQJDk9fxm6ZjWLMGQKM9SZRG+KyL6hjNlA/8CO0YGizXffbvBb7TrU1wnRTRFvXQtKA4CK6oxuE+0oW3fnY8Eudh2Dwv2cn/YEdEC7Xf4xYswewIo5dXAH9hBTcO2nEpYEP+2z1umrOo8qHBI4C3UbGo9Qcvq9ujbu/7CiC+jTQCPCnE7oUWB4/gRMQLcVio2c9be95pmDEWrWgpbUKiVuRzdBqeayVqA30GbRWTvlBai8nLOIK8lc3yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1K4LtZOgP65LqK/poWXbLSSb0qdDxouQOm0z1uYl8I=;
 b=oBlJpvKV1hSX+rPu4mnLSX3iDU1YyTpP+OWVMJ+YTsEvMX9UWLQoCJ45B1BdGQmMcNCXBsEqS7p4TgNdvQ2AQI8BE1xhk6Ebs6jtwGc6Vku9KmMHopIXFuzcwt47i11yiNeu+u4AdCS/0fdDKhFwKIgr4UMVCC6Ro8Y2TE5TsJzNjutrFNasXGKC3Vd6hOADJmiX87kMszOPiAfAxGyQIrG1usirtgmvTLmahpJwsoYBGgnXquR1Bm1LzB499gbYahwu/jxo6E5qIOHl5QnWFcw98QryOW7nVxaK4U4lufrdUbxLyVFYcNDxCCPKdJPJygzmh9Rigt0Ii/fGrVUd3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA4PR04MB7613.eurprd04.prod.outlook.com (2603:10a6:102:eb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Tue, 1 Jul
 2025 14:47:14 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.8880.030; Tue, 1 Jul 2025
 14:47:14 +0000
Date: Tue, 1 Jul 2025 17:47:11 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: James Clark <james.clark@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Frank Li <Frank.li@nxp.com>, Christoph Hellwig <hch@lst.de>,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/6] spi: spi-fsl-dspi: Increase DMA buffer size
Message-ID: <20250701144711.hfcgk7hhk5w4jmvf@skbuf>
References: <20250627-james-nxp-spi-dma-v4-0-178dba20c120@linaro.org>
 <20250627-james-nxp-spi-dma-v4-5-178dba20c120@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627-james-nxp-spi-dma-v4-5-178dba20c120@linaro.org>
X-ClientProxiedBy: VI1P189CA0036.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::49) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA4PR04MB7613:EE_
X-MS-Office365-Filtering-Correlation-Id: cf8eb8b6-5fb9-45b3-cf66-08ddb8ae2b13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CPLDcpFN1U/qcCiFqdRW2zgm8PgBNi9POg//2mgfqm8789DqyGtTCTX5YFBj?=
 =?us-ascii?Q?iAsZPI+USPy4DbkB2Z2g5hmYAHuTN2yCFYDSl03OIJXP/7YPVWkuFXyPUULI?=
 =?us-ascii?Q?Xi0ot4BoAQBmZRl0HwkQUaf7+6mq6IP/BwRFuM6nUririgVzo3Eub4gXRx9x?=
 =?us-ascii?Q?da/gT6Nt9hsDOBwehS5kLD+q4TR6xIRdtLxsPe780rZCYRWPN0msn1alNNph?=
 =?us-ascii?Q?68tCueHXyx0WqOtldGjsQasP32xnFM9ee/ZXoPWUAOI+tLnw3QvOC/DYcjJ0?=
 =?us-ascii?Q?ZHJTlDSUWJcMcDgzD9EbofR8l8BtdMvPbAnS9+Ei7W445MPqbQ8acXGcmi7y?=
 =?us-ascii?Q?svun+uS/F0HR2XEt9hTztvBuvBybsZzBrFXzTfkH7D9LGWHxURAPXBhoNQ9G?=
 =?us-ascii?Q?ZCpISMTuGvkPJ7FEEXBqAK3NkKeMvASdoQmGEMqNkAQqUvdtKRnEGJ378WPo?=
 =?us-ascii?Q?FsnUP1uKaNzJMJPiE2v3F7+q5AcCXYRKBsI23l4srPVQqzTumSncgC+2dbkl?=
 =?us-ascii?Q?ImlJHFo/g77X9+UQnYDJss0CcYQ6PWgsEXpYk6jSOFu6byK8Ef0wttrfOxmQ?=
 =?us-ascii?Q?wsKsO2nc5h7UmWDtIPvRB5s/Ix5nzcHKl7Lf4ikV7p/YV/IkKXcx3Bokz7Js?=
 =?us-ascii?Q?O+aNhqZpfjlHGH6RcaMPMQJXuh8izsEeMXkFSxnmHZGFdN7WQC/EmjNOpgtf?=
 =?us-ascii?Q?Ro0nT2XH8Wsmkc/WL+FgBhQRBoYil6NH5O0JtZycsHVP0hga2uviAeezaM62?=
 =?us-ascii?Q?LjQGGXGcu9Zs3JP7M/5RN0Z+sBkWlubTE4lDECwve4XnV33uI0T7WbsF22qB?=
 =?us-ascii?Q?kLd1A00x3MmgcYoTxpsinqTpfJWUjvmim73apVPR0lTWYfCBw0k/wgTDnlhv?=
 =?us-ascii?Q?Mp4jASuqGY40srxh2Zhp3Zl1C3Tcn2P1trT7K0i3x+ArfAR3p2KtVdYMG810?=
 =?us-ascii?Q?8+YWyzeEGER506rq7jcJOEOg9DMevtZFP1MiLngCc1EnbJrgmoXbrxcnsWmQ?=
 =?us-ascii?Q?P35/Ad9+23yXvmhMi/tlfngK8so61nu7KWeCQsdyzAy3QKGUN316BJ/+5Lb4?=
 =?us-ascii?Q?S2YwvDQOLMO+UI/uIejrSP6RLchwDQyMm7yC+3s2JE8y6W3z7spKVaYjiENL?=
 =?us-ascii?Q?PxKA9oYIpNP8cjMoadWAEoaauC7dEYuL0LqXu5PPMmEyTEt2TfMUPOIZ8mV0?=
 =?us-ascii?Q?BevWsziONHABw5+vdvTGx50IAGIpAad75spSIzsa9JwZ5zVvFO28HI5biNR+?=
 =?us-ascii?Q?iwvtJoKdt2H8YrFFya3XI1hUpBmNrbQ8AwNc25rX/70RrMbqtV6VrwoZ2KiT?=
 =?us-ascii?Q?Bj2bzBuWRPBuMy6MXvvnPA1OkkK+1cWYkD3TT524fenoZLXxNmUyWmsPGTs2?=
 =?us-ascii?Q?KIf9pECoTQy+AjKLBWHXjPq5DGAnDhLHX6mrJSn1VeqHUiHZPA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aPOKwa8hQe/txQ2vHXC/SLCmbBxJNMV/afzDwZk/7ze98P0P11cYkfTivMSr?=
 =?us-ascii?Q?zEGXYU0rdFDH+id1FeN1Es6cSyV6Ai6r37csmzzyz+5lGDaElAeOmYhxsY8x?=
 =?us-ascii?Q?X6FlsgdGtISmyjkVUdKTL2zuVlYESxG214mQ5cMdBgqkYTRtXLmRhO4kcbtd?=
 =?us-ascii?Q?4N0OoR9CblNfwRurOtZbw0obaxMu26e01FFodJU4f8njncqkzL+IGamqHn2n?=
 =?us-ascii?Q?ScdvQeCXlGv4pj1QXPQ6rMI4IGc2fgxgMB7LLsS7FaSZLdtkbad2WMIcWcQ9?=
 =?us-ascii?Q?tb2STj8loOQRI8lRlGs3H4S7yoXq41ZeH2VgvNDUiJ/5vOBXcBZVlpAObhYU?=
 =?us-ascii?Q?jIvobVX2t0LZXx0ZaNRN4LzeVGZ/Vc6LFU39nkFajc4+bh7VdOkAv+HTAARS?=
 =?us-ascii?Q?F5mmLNZG1mss4pW34Iq6Hzuo4jlGFTlBhsPR98hkZETxeKkXY2t5QYoN5Z3p?=
 =?us-ascii?Q?F31vfC9LMX4gHI0+6ZJBuMu7dOilDfa7PfJWCkX8xl+qJRcC5dtA/t7Nfdnk?=
 =?us-ascii?Q?Vr4zZTGoZd0omvh6EEs9Joh7nMtSBGRX0IHzt5kFSTYQHvUqpo61zaSrv8qx?=
 =?us-ascii?Q?T5d5yoagMLSujjQ2fbN5dhAfem9JViL7BpGQ0gepZlM6IkH/8nJJyU8UwZqf?=
 =?us-ascii?Q?jlDsBPUYg0ASRRsywQwGW79n+Lb/AcgrSPLazoHK2YmqbhE2KNsa8nB0FCth?=
 =?us-ascii?Q?Nm3SuhSPO02fN+srlHfu9w5/q0/Ncubul90g6wXbiprpGB6UAnH8TRVI7J6y?=
 =?us-ascii?Q?yjO2o8UMK+cZaHyxty58jU3M8ZEhjjGjtXZMtsc7l4DSi8aVTpG9MV2bXILg?=
 =?us-ascii?Q?95OiN9jZCEFo7tGqc2gXJpfzEKXy+L/Y5Xy251iMQc08tpDYzZ69WPQ+20sN?=
 =?us-ascii?Q?MWVG2OoICtFeuRTzYi3kPMEjv65RK7MNdS/hzFUPlkLCwFVRxRgts8LuqWDS?=
 =?us-ascii?Q?e7o54UKdfi8ck/n/fRBZmjQIGZBWMnDvBsxRx+wbePsTc4FniLc+Kd0wt843?=
 =?us-ascii?Q?ToKk8xzGQzMWpIMvxSHynaha/0BXpZ9o4xozB+c3eIPlfI3z+FeelOTjkQFD?=
 =?us-ascii?Q?ixh6dsbaDa6FAw9nxBII+2u6oYG4PZlrljzSt8CL5l9neaHhG2Z0581tvHRu?=
 =?us-ascii?Q?ZoOtOBjyTrdtgjwqT53zIiCyO8PCNFWyz3q1T+S1sdFmaiqNQ/BvgiOO5wpQ?=
 =?us-ascii?Q?mItUs9VT/+UDPOHRHE+G97u5ZOifycm7ZS252L2vwVP6tRuCPeW1El4mZ6km?=
 =?us-ascii?Q?NO53Eh9hZSClbVQSNwugOpQMPglQ714M6Kg6mVEses2rNx0yqQ6yiuRCNHZA?=
 =?us-ascii?Q?+H9QaAOOzxtSMxVaut21gwibIzQDggLqhGfPFlyIXQ3GJDRZuJskdO3g/iFW?=
 =?us-ascii?Q?2Byzok0+E4MtH4H+T0pMcCc4MuW/fBfAKqFP46MBsQanwVSJI8Hu/YyzW3Hw?=
 =?us-ascii?Q?cFG9DuLufLmDRPYuE595KUo6t8dlzm272H/55fPfu2lZq9zSmehzSBBVKDEn?=
 =?us-ascii?Q?hoEWzGPdB21Ydwz/YuIXkyJVoQnT/Ys9P3gu5E3jCWWLXjk6lXk13qInK4MI?=
 =?us-ascii?Q?/WXXVdUHtAK2m4aeBNFBR82mpJXD2oqHUafvuHIukoklqL6oQrDWKu0D2cDu?=
 =?us-ascii?Q?ss56FCYLFkir2qI5KC5eNJzxrv5TZlDZ3+s/JDQhp54BM2rOrj07djJ5r6GL?=
 =?us-ascii?Q?RgcWeg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf8eb8b6-5fb9-45b3-cf66-08ddb8ae2b13
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 14:47:14.4658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lfhAOT83FFUny9P6sWYBLrzVl2MbO1Zt/QyQWGds46g7iMJbIE1ck9gi++5p5009Ln93POr1UBB44Aq3aBGzeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7613

On Fri, Jun 27, 2025 at 11:21:41AM +0100, James Clark wrote:
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index e7856f9c9440..46d3cae9efed 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -493,6 +493,39 @@ static u32 dspi_pop_tx_pushr(struct fsl_dspi *dspi)
>  	return cmd << 16 | data;
>  }
>  
> +static int dspi_dma_bufsize(struct fsl_dspi *dspi)
> +{
> +	if (spi_controller_is_target(dspi->ctlr)) {
> +		/*
> +		 * In target mode we have to be ready to receive the maximum
> +		 * that can possibly be transferred at once by EDMA without any
> +		 * FIFO underflows. This is CITER * SSIZE, where SSIZE is a max
> +		 * of 4 when transferring to a peripheral.
> +		 */
> +		return GENMASK(14, 0) * DMA_SLAVE_BUSWIDTH_4_BYTES;

Is this really a constant that can be hardcoded? Should this be queried
from the EDMA driver somehow?

I'm not well versed in the dmaengine/dma-mapping API at all, but I see
fsl_edma_probe() makes a call to dma_set_max_seg_size(), which consumer
drivers such as DSPI can query using dma_get_max_seg_size(). To the
untrained eye, and from a great distance, it looks like the value you're
interested in. Apologies if that isn't the case.

> +	}
> +
> +	return PAGE_SIZE;
> +}

The other question is: what's fundamentally different between the host
and target operating modes, such that we return different values? Why
not the same?

