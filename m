Return-Path: <linux-spi+bounces-9780-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55878B3BDC5
	for <lists+linux-spi@lfdr.de>; Fri, 29 Aug 2025 16:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C5F65A0BAF
	for <lists+linux-spi@lfdr.de>; Fri, 29 Aug 2025 14:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224CF2135C5;
	Fri, 29 Aug 2025 14:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DC3uR6FF"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010044.outbound.protection.outlook.com [52.101.69.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A78320CA3;
	Fri, 29 Aug 2025 14:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756477781; cv=fail; b=maknTlXl5NCmRvgrMJH4nuVcmPW07ToiRytL+h2neGRuk9ePg6gYd5b1WwJoxCLyH4XLIu5Jmbn/s6u00YBZetSIlzjtCnmcZQejytuexshYK2oOCg6MiwS5FSis64CQMvcVm3EFAnO/RSPv8bbvhCM0V2BzRXPi/tjABUpvuiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756477781; c=relaxed/simple;
	bh=6PhfvjhePtETDd/0ssKWOi/lXG2zebx8xKAtQq81M5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gUMFtmyAHJc02fgN00T5W+p7Yuac5tImoTXGpgm00ZA7MONCNheo2UdMjx3iES44SBd0ZNBvXCN+CFbxwH9bDfAAwmjamOWYE0CLt0x/tesuan1IGF3Gkfs2v8OQ+cQFkQZ1yvplM/8cynUw96gdKJyivWHdGMNdPAn0SZApQng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DC3uR6FF; arc=fail smtp.client-ip=52.101.69.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e5CKjeANL+N/hd2CypE6DIeZMpNLSFQ2ITe7r/MGvC1wv09rCmn43k/gOaAyb9pr+pTca7QLqzdK6nx5ssta9RXFQNEC8eILfpRfbSv3t8LeCc3pgSJclvUq9whIhKNK5Y2whfhtpZr8Ahz5nQE/fYW2uz2qBeA9pCfVU6Dlgki8Khe2lZsR2LfPWBdekZdzK8PFXYbfaA1UrS64TsSuYkVRFCTcf5cIH53BJSSby3qWUzpescmldrXA1J1TlLiZxew3JIxilrzVeLSYkYvCDkQKsm1YONzxgFUbMjYeqNKuLvuNHhonb6yziNHNOaLCZopHoZIewGOE1DqzQSSKng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VSHa9/xW9P5Ea+XJ38haOqieFCp3gzr7eO2bYlm6DE=;
 b=iEe7qkS0u+48ePdboy43cvLGD+PQWi+FGWxBuEIoS/AuoQryvFkgMWcGke06LwGL94cKYzt/I5nmpT7bBBMziX6M/l/QTSD+ZKSwPs+0nV3RJqQzZ+Tc+0Lx8/eFmnLhdwzJBLrhxkECqfY9QidEyIpRTpyOTb1Leoyph80S06IMGTs7X//5cN5fI8YaaIAWoGk0H4haNnoXxSPu8w+gfHw432epX4tO/EclI7zxO3eHZvpFmBubdBS1J2MtcGCvuXTJBQrZZgOpO6I26Hm390yX/YG4UHEBQVVmy+Uxp3grN+jErfkg9wvcQQNQNB1w9tDZzFGRFfuo44Go6B1Sow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VSHa9/xW9P5Ea+XJ38haOqieFCp3gzr7eO2bYlm6DE=;
 b=DC3uR6FFL1BO+GHFfMqLu3nFxnzV3D3hkp5fb2+WFXW4i1v5dt5DOnvZVcFH1NVaB5TCEUe0MEu7wEANdD0kNHs5kLYtA/X0rbzbun0y2WVHzc4xejq8CS6PE3WuahwL7bpO4xicCk7V1fiQBLzZ4gix1+JXVLXKtOolfMetU5FmbbIn8gsIPZkaddCfaQRcxWzkeltMTgn8CuGO6PMnNcMXSOBQgXNUXVw3GLbvN+0OCiZhz8bw5KIfFyv1glAroTQES8+xCIrNlXE2Hoz96W47WsVEPNaX0OLc4trWbQS7l+qFUEwORId84sH8s/OQesF5yNZJRF0bIa7TO2XnaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by OSMPR04MB11295.eurprd04.prod.outlook.com (2603:10a6:e10:93::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Fri, 29 Aug
 2025 14:29:36 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 14:29:35 +0000
Date: Fri, 29 Aug 2025 17:29:32 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: James Clark <james.clark@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Frank Li <Frank.li@nxp.com>, Christoph Hellwig <hch@lst.de>,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/7] spi: spi-fsl-dspi: Use non-coherent memory for DMA
Message-ID: <20250829142932.jhnrn3t2bi7ah3sb@skbuf>
References: <20250829-james-nxp-spi-dma-v5-0-3246957a6ea9@linaro.org>
 <20250829-james-nxp-spi-dma-v5-0-3246957a6ea9@linaro.org>
 <20250829-james-nxp-spi-dma-v5-4-3246957a6ea9@linaro.org>
 <20250829-james-nxp-spi-dma-v5-4-3246957a6ea9@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829-james-nxp-spi-dma-v5-4-3246957a6ea9@linaro.org>
 <20250829-james-nxp-spi-dma-v5-4-3246957a6ea9@linaro.org>
X-ClientProxiedBy: VI1PR10CA0096.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::25) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|OSMPR04MB11295:EE_
X-MS-Office365-Filtering-Correlation-Id: da3ef07d-517a-49d8-b187-08dde7087a29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L5sqZYZSGPtUBEMOlj0KVezTpKKhfaTlRdmzL8jiNa9NvAt2n3nQmskVSv7j?=
 =?us-ascii?Q?//iaR/4Sd0Y3/OCGnHGZJiM0bqUEIqmLbIJCX4bK34i4mdN/w8DWdt8c9FKx?=
 =?us-ascii?Q?3RK5da6Sv+uGkhLvGq0lJlUR2UNfQ8AcVKV6emNF075pixtuMYEW1v5gOQeh?=
 =?us-ascii?Q?91oT3iC34nupBW9ibjpIEXBotcQhdUBRosPI3YPVxL+BCslfTxHu+Rb4eE3b?=
 =?us-ascii?Q?LA+5eNLwxVzNfKmVk7Z2jN+r1Gh/vo9DIIPWhnuOKZZ+Fq6Dhh7o1tRzJH93?=
 =?us-ascii?Q?K1tlCmgLF1TXr5/J8x9N3b02sE0M+IIuv50PTlri9mm39TG4RYXEZSr6IDNo?=
 =?us-ascii?Q?0LCam6n1KJa2YFsfr6a2mOgD7VaMdgUqwpJtWAC06F9BPfUPCWbUtqK4ej+V?=
 =?us-ascii?Q?z19KD93h/DeGwIFNjlhuBdBL16CmV6xpAfHWFAdcB0/OR/5Vjtb/EgffCz9A?=
 =?us-ascii?Q?CUv6u9n0ImmvMRyicDfC2eIYRieObdTRAnyxXkNHA38baSoOvDuqTZ4LR/IH?=
 =?us-ascii?Q?OgLKblpZVt1rld5FTfIk60tB/hsj4waDFEQyuobyLqzhegfqQ/hDi4i5X6TW?=
 =?us-ascii?Q?okTcVMA4NTHTFRsR3AVzt5brZb3ViIPXMNrRkQDDHUCiUw5Hux7RY+VHovdw?=
 =?us-ascii?Q?W9n04f3+5g8P+tKA2VumnI1h2sWDE0ZTks5fpJ5ij6nveCQWrdu0pA7zcAE5?=
 =?us-ascii?Q?cOz50h3otpwOqnv56qwLZjL3kC3ygjbYWgClQ0KCoRX25TmlYW0N1ZO9aaNO?=
 =?us-ascii?Q?2I+ygcBWb5GwGRtzJZ61vuah/xHzvOqWTrsLcCvaOZE6ra5arYFZMHASp9iE?=
 =?us-ascii?Q?PzSTggL0RsWmYbbZ0m+sjwU0ZcqcfY5yULAZ2N41TKAiTeNtJNhuuvToeNHW?=
 =?us-ascii?Q?CuTCi/bdISLML5BMbxn8EiXL2F6IX5/UrdncF8CVMArlmq94Im9oFFXx+wlL?=
 =?us-ascii?Q?BlF7zkPG9EwiaeAd+/I9zDa1KXmCigv4VP1kPEBLb4pJF4GRT4v+abrbHLfg?=
 =?us-ascii?Q?5vV8nGDfwXrnE5seyoIZR8Ani685p2VkoPfgzz46qz0NMpTZ3rLacUbw4NLg?=
 =?us-ascii?Q?rlHhDMQ5Ii1MVjsGHpp0XNo4mz2txzq1rbXOUvWCRW6MfGgWXJsrO0LkbuM5?=
 =?us-ascii?Q?MPdky174NYNSQRyRGekR7n+/W6bfRryCLnqsP9bTdutvmah2C9R3HLz7Qi8k?=
 =?us-ascii?Q?EYBVk6DriyrY/TU/hpqPsEZ1GylfQigaQIPyHr4PCt39sOyxub63VVxefLrP?=
 =?us-ascii?Q?Z5GdRJlWXqawJEUthDfcaPnC2xwlQRxgM17jbgNjhBcwBGT8ys1S7doLrftI?=
 =?us-ascii?Q?rZURic0KAE4lwjKV1YX1E2qQx+2L00GG2bh9rCxML2rDdDoVswLDPK1SY42U?=
 =?us-ascii?Q?pTQnwOJOjYMO1IJnJQFdwk3bEqGTGB8eHrFMYA3TCi0j8G1LNcaCo3xyHKMq?=
 =?us-ascii?Q?eOUtRA+Lx2g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(10070799003)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ona3J0ipvbsgvJUzgn5l9bUs+3f2QQkWM/jo1gQW4TKddKNkEgRh/Ymndwfj?=
 =?us-ascii?Q?UQwN1kIhDCKqp/PtNCOJOb9iE4FGs8PynSiMNbNDk2EH5XMNzu+uBYJt6oFb?=
 =?us-ascii?Q?/jw7MVIzuWHLYtrbHiIU6LwgttJ4gh6Hzn7mXYDkoaOCdSMgrwYue6Xq4Mt6?=
 =?us-ascii?Q?+Bvrr5NC04ww/TCrHcUD1zXMC3skiZ6wCSsgnX/JPqP/TmiqgN1f/h4jMTQJ?=
 =?us-ascii?Q?QUkv9BJ7pw4+DSnoWtPFxCvAYMP/XshhDD6sTsyBsrbgKzQuJLz8ZWUkBeKq?=
 =?us-ascii?Q?I7JJ+M0Q35NwmUZIfwFIkeVTfNZHXAAX7pJbV5oJI91lpDo/RPC0djtkKzLA?=
 =?us-ascii?Q?HBVExhZ2h65mhweOYVl0TyisqJrQTH88A0ehWdaRZdI29rrwUfUQz5WKEGRc?=
 =?us-ascii?Q?NXO2zy4srmIce3u3IysRrIau2N4rxfIUFFL7vpHZBo8l2ALJbsVwygT3g3Lj?=
 =?us-ascii?Q?YFgWeB7ZyPXT+9zEGVrAWdZUGAqJynOU9CYOfSxig5FtaAUDRt3zP63/9ZyY?=
 =?us-ascii?Q?5RXZy2l87sRWHcskLonGjpyqecGQlcdpfaVQeY2jS8phItRmZGvVDEOiagE6?=
 =?us-ascii?Q?xGvyk/Kg2XnA0A2o0efdRHU9kTkh3QZN/cq2rsYecVLi+vcfPO8uAR4DRDR6?=
 =?us-ascii?Q?qf3A2WshFy39Bnn3ZiUO0bcNIbeim0+SZjRd6l5FmheTuJC+aXfleu9wdZLw?=
 =?us-ascii?Q?MO/4ZZnc93nCqfwOzS7BQD+Jy1IlA27gHMUpTNRzk+qsbXHw3DkPWps74wGo?=
 =?us-ascii?Q?g7xIJxDzbVvnEQ/x/Ef6lbzFwHjMmZfQQOsCnGUYNejm+925zsQfCL4coQau?=
 =?us-ascii?Q?PSCE+keXVyO3ItrA5adS9hK2NeQo+KB5piCtwvwjHaifRofi+bVeEbRjXCPW?=
 =?us-ascii?Q?oNbqT9HvmeYITK9yP4lB/qcgJwGjGTlWocxQ/KRZSl9bHeb1CZdrm6EIrVB5?=
 =?us-ascii?Q?m8rPfO5xivTgzstzTli7IrKLt2PzOjc1TadidCqNe9ZkujNcKUmO6MoJ4MuQ?=
 =?us-ascii?Q?mahMDddynDOs65LE4NEBByPY/MZ0/4cAjdxddmWU5VWabTMZzLL4xQ90AAWc?=
 =?us-ascii?Q?hozulRR8Sr2u2iWHuCP/pfqGrVLWkTSeNux+rvXRousquFXMEaDp458nOnnf?=
 =?us-ascii?Q?7IJQthSEeZL3mxvSYxEORrnsqjKNrKjLxM9sRNL0pHEH9zUT3RiF/1bc9PbP?=
 =?us-ascii?Q?unBBCYjuDBfk2++jLdCeHOCrjgPnk1svbTBK84HZG78+AFw8El+ywFvnMhuh?=
 =?us-ascii?Q?W2V/xyTFKa6BLyW9TgBM41beB3T4Z5rpLS2+4DWPS64j9OyolgoNdfr4VwFA?=
 =?us-ascii?Q?i8gmyDkKzSCa8VRgunDKMaKFVfcBkqVVM8ahGQ78hee0FMrjFS48WAYomJfN?=
 =?us-ascii?Q?qBdsLpqtSKYjxQ4u9NVVMPMFmDOlyZjnaMxk6EXWqofBvXiwHvl7lcuJcDNy?=
 =?us-ascii?Q?9RP63cebaygmgdY+zYKm12u7JH/rOkJ9RxsPy3QTjpn/I/xjNPflyw2EzvYZ?=
 =?us-ascii?Q?lSnfdTfPBvWk8Wuj2zOmK4+jRjaplFNE+tSNKYu0ggYxBbX8gQFvORXncyF6?=
 =?us-ascii?Q?85jwyPqFAC9UYjPmAn04E9pJNgvfS0+XDYXas33uya+263Qm8THCK46cmXHJ?=
 =?us-ascii?Q?z5+a0VudASu08/m04SI7cnxJ5gguz85bwR0g1Uoq062KIpbVmybljo3ubXYc?=
 =?us-ascii?Q?Ml9EHA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da3ef07d-517a-49d8-b187-08dde7087a29
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 14:29:35.9433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nBWlT5WX/Hk8nf3T7Bp2H7Owv/BaD/D/YSt59tSZ5TxAdfVjOxz3RmQRppzYyLPm/8/TeJvNlWLf8d/UlKCZnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSMPR04MB11295

On Fri, Aug 29, 2025 at 12:46:46PM +0100, James Clark wrote:
> @@ -517,6 +529,7 @@ static void dspi_rx_dma_callback(void *arg)
>  
>  static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
>  {
> +	size_t size = dspi_dma_transfer_size(dspi);
>  	struct device *dev = &dspi->pdev->dev;
>  	struct fsl_dspi_dma *dma = dspi->dma;
>  	int time_left;
> @@ -525,10 +538,9 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
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

Can you please realign the arguments here to the open parenthesis.

>  	if (!dma->tx_desc) {
> @@ -543,10 +555,10 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
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

And here.

>  	if (!dma->rx_desc) {

