Return-Path: <linux-spi+bounces-8921-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C03E6AEE25A
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 17:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC0253B78D1
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 15:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6847E28B4FD;
	Mon, 30 Jun 2025 15:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EI+S8MBv"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011034.outbound.protection.outlook.com [52.101.70.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3261742AA4;
	Mon, 30 Jun 2025 15:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751297180; cv=fail; b=tBOLO/uD5Ciz81XushegL967xxxRxmcZPQ4UWAxOzixgcBB8h9y5hoh5q1vS/U5oa+9z8cO8CX22yTQDX/TnNSFTBan9fJfpgR5INfTwV+7TIoDavQMtihbTNajpOc83NJGqRS+SONPNawYk640QYwK98WGBb6c16h7fU8iebks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751297180; c=relaxed/simple;
	bh=Ev2dL7O57vHW68s1clldogZ2FZYL5yeL1t0PT6MR+fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gB/fHeItrOOHCBeinoQMcV11nSm6ROuMi0smB7lu6nIZp1KN225YlAqtvjCT0m2TwXfj6Usi2ClMBLwEPolrzZgUI1VO2XWhw0iyFQIfHZbXp0hJl+PVzCjCK9qXsXCrKovc7yQ4UpgxiIVGpkMoXMNWoH/sEhRolFZK0nKtZIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EI+S8MBv; arc=fail smtp.client-ip=52.101.70.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nr4grq/k0/kWmM9Df8JJmQ7U40cpBE62E0qnnGh/IUe7VTI5WWSatiX/2YBMXM+M4duCsewN7EnRTxVRkcQ2o9Ljgu3E+ItZqXFrMrV3R4tzLz49HdSDAqy44+Vhi9wikbAvwb3VCRB34/ntFizl+PgoNI5KP1MoSdmG2oYOGiZWlOhI+OVZDQadoMlQgpZso8823Z1P1PRBoZZAvftqfF9E3L7RdZ7uAeHtJl8xD1IAhYG/JiXazq3zwni0/7jI7sBVsMnfqa7uZ/cCiprEtVOyYu7lOeupc1JkdlUB+QfZo5BP/ElE/29TEwikM3jSSlkjnqGr8etI9ABH40Lw/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiDMapE+dYb9I206j8lBP/otoFUZu26eSGv8SO48mT8=;
 b=bxursU+tlXK6HNU3UsS6tm12fTZv0czZqy3u20zjvaDCOwrY700EjJvgm2PSvORLAKUxsn3JeLq/jU1761kZrmxSB+gI/TNBJRJbKYEZhLR9xStsiy/MSeV/oEYKk2CYtMcX0MjdogLws319zz3mKoqT9mknbOujBrJUjr4+BN4NCjxfC7gcKU1SbqJ87m5Bv9H5+Qww038320fEPIYBfaPn0JgdII0ySYjlnZV4KTHNiHZ8GOVabn3u5kS7Gzes/4Y0pylcSIe7TahzJMlRNbLzIRZDgQtLzAFoWeVPyW3vyAtsvIX3Inz4ejVvA0ljffPVXxS1f9iS7yGZ1GRwUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiDMapE+dYb9I206j8lBP/otoFUZu26eSGv8SO48mT8=;
 b=EI+S8MBvkqKcq7FvaOxuL+MqIIbcvvjZie1XuHSA+an6n5w+JXN7iTHivwHBLRxNVczT2fuYExp5Km6oPLMKovo8WQtkOjZbl4uAvu36typWnbyln6ZnJgjsMftyyNLIfXIC6x4AQPgHjz0R8hshX/PbBReFQoTk8VS7tI/a21jxcJi7Xx7VIBmqVjWFhkKUQQdnSrv+tlBe2nT3zrkvySnuiF1A70VCY+mDZAuo1kElmtjRKAJkuKq43qEiNkoNw7jSpZtfCW4J3MdDMwHXceFm6o5OjsIbT1vo7V9UmAO59c+VIM8VFbjsgAubvfZWYUJyi3nCMV8aFTfw+0d2Cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB8628.eurprd04.prod.outlook.com (2603:10a6:20b:42b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Mon, 30 Jun
 2025 15:26:15 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.8880.030; Mon, 30 Jun 2025
 15:26:15 +0000
Date: Mon, 30 Jun 2025 18:26:12 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: James Clark <james.clark@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Frank Li <Frank.li@nxp.com>, Christoph Hellwig <hch@lst.de>,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] spi: spi-fsl-dspi: Target mode improvements
Message-ID: <20250630152612.npdobwbcezl5nlym@skbuf>
References: <20250627-james-nxp-spi-dma-v4-0-178dba20c120@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627-james-nxp-spi-dma-v4-0-178dba20c120@linaro.org>
X-ClientProxiedBy: VI1PR0102CA0079.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::20) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB8628:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f56ca7e-4775-48d2-a16a-08ddb7ea73b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vGDWYrMSawK2i4CIdO4QMdy/2BdRaAA2YEf/ME9zupdX20qWcIYbHsm9qtMf?=
 =?us-ascii?Q?+8hU+FUGscsAHfmytCMKgJFc+6W+XbVZ1EfYsSR0Horn5vDeeJK1+TBd1L3W?=
 =?us-ascii?Q?cRPmEXJBX2p5hpCGz29nW9fy4v3K2GEz2nyoZGrfW5hIeVxEFgnux0+rJdi4?=
 =?us-ascii?Q?ZpMFmisemIJCMqeQTC77dpsmfNNqyRl96B95Vk03bRT37vNrxEsPBUALt5Mw?=
 =?us-ascii?Q?dJIrVqy2eXzUnLCYNqUIkf7eiHe+iKjuGyNbxzsgiGm+ibxqz2L+TGyB774H?=
 =?us-ascii?Q?BL3ZDNT0/HnKPDEcDJxbcm6a4q2E3ShsR+is4Ldu9aUKrFNTnqVpQ2cBVFBo?=
 =?us-ascii?Q?Xu5w1Tr2hnurUKZr/FfZ7H0tVEFGHnIxOK7QU+aBk9iblySyzrqLcif8+nL9?=
 =?us-ascii?Q?KATImOsrAC9rEHoEDGmtSyOta0J3Lv7ZYlQ0ECUDvGvAeTfe4elYjfzOVA/3?=
 =?us-ascii?Q?eWDSvXEt9WUhBBex+ScsEpdqcvMDI7AzZctrljzJGIO8tz+O9rgIfraA524X?=
 =?us-ascii?Q?juqnqSS9Ny7JXlx7wbrxnVCD/qBLyVqV2UECQxtI9NAPpwrD3LHhdeDa6xtt?=
 =?us-ascii?Q?V/bqcTiOciAsjSnLQSUZzmc5ENZ9MYVlU64peTAxR5PZB2DJQMw1bsiZ1f/Z?=
 =?us-ascii?Q?Xx3Y4xns01pr1RxYGlu5dhWfk0lJDtrYAG5VIypTXzNZ+9XkJh21OTzqz5jj?=
 =?us-ascii?Q?ywK7fWzHo6zBFsidcAxvOPQoCQyaHA81rHYaKpCBkqZ05DpOV94l7o+baSat?=
 =?us-ascii?Q?o8SK9eipNAGx+Pa0A0c9d2rCRNTcBbPcedXDqBk5lFNpOwtxkT2eqJTyfeFR?=
 =?us-ascii?Q?HtZC03dm2ZbqQ4412LRI2CCAeiVPVOdwei9sdmMB7ooX0hqcORNWel6oM4Hv?=
 =?us-ascii?Q?Nr6oo68yx0K2o+ViR5gSstLqIinR1ruZLEAP6r3Fn+HutrUb9voWwtgOM8cq?=
 =?us-ascii?Q?hRQ7ohCg3YhF2BKPuZbJz4iOEojxV18hzxrTian2xWB1sYkXrIowcwDFeetg?=
 =?us-ascii?Q?QUB7W8lUQuQa+OYZzBQQGTj5zOh8NYsGSToLMPB73QPzEufmQxHo37l2SRlr?=
 =?us-ascii?Q?1VMzK4/twD/GSNjEnxSHH7HwlLMLv7XLkrOxRjzuiz6UuqQ7j+DH1fyxDI3g?=
 =?us-ascii?Q?UmS/+lomv5y2xzbn37CayPDJmE2eVrkhNZ9PQKwZe/8czhPAWnl86JkKPWdK?=
 =?us-ascii?Q?0d5mWhAyV0B2P9mUsxI4X+htrvulqIDWJMsaGYF7DwPYd2ahTvfGjowwNQgs?=
 =?us-ascii?Q?Goa+RnVpY0cyB8bxaiggW+0wLx4l8FYvnlH8dQ0Dzc8qZdQlt0Vts9he9gBd?=
 =?us-ascii?Q?6mdvh2LyJbRcSM6DvZbLcLf3uN1ttuPEmv1JdHEf3YQP4783+rwnjqOd0NPf?=
 =?us-ascii?Q?MaRmXsPOhChivbL3/Gb3T3mx+m9vCaTxK/K/duPFcInE42yUef7slypktuJj?=
 =?us-ascii?Q?WNjYO0k1Xxc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JM5BaLIXUt39X4aqiK1X/dYmYKJZYnjG6ZLZmW5iXIyZQDtJ6Eo4MTqlkkiM?=
 =?us-ascii?Q?sPTH1SR8njqokKmDHzt1CM2mjlIotni84Z3ezz1LYtBBC5TU5Ombcfhsj5YA?=
 =?us-ascii?Q?Ia7rhxdKk4tjQ5oZj9oabWvRnAc3DdvU5sTAOlHUF3rP1zZdxi2M6iF+U9T3?=
 =?us-ascii?Q?ggLrWeyaHHIb7TlArBqTPzWhQCirOJNJ8BbzXG6KOTz6ncgTP2HFqRRccJcy?=
 =?us-ascii?Q?Q2Smi45OIjn0iH7JA8Hag9aiMvK/H0vfBfo3TTxn0apZyAhO8fZAwb0DAY6D?=
 =?us-ascii?Q?NSIGDNysu6ROKujAlH2e0wOs98ekK4Bukfl6bEYYctsq5NH6oZ3deO5J+H+2?=
 =?us-ascii?Q?BlEm60uPj1408hAY/rfqFyeqXy3f40InR5rNrsSCjA7uAPrFl3zwauIW5uo1?=
 =?us-ascii?Q?jpQ1EFY/3mIo6JAO8RQHcKB1ydHnTz8S9nQKHHdv8Gw3kxMj0EBamVGb0hR7?=
 =?us-ascii?Q?LYc61iezQhw3okTT+3hAHYCvxkTo82FUhPjgeKRpK9JLhIG4J0JyNO3s6x7e?=
 =?us-ascii?Q?knLxd+hDwJVqE3+AAFFFCLSX5JwcIY4Jkgw7pChRNMmhOW7U2hp6AFUX3jlA?=
 =?us-ascii?Q?vtzDaCKC7e3d9f6Eck/Dx0KtL8Bk0NEZELmcJxLBVJKWPfPJkCoOu2hjlqZa?=
 =?us-ascii?Q?plipNNP71pZTBta/JsHLEXsiHiBpNce+vwgxvHRl+RIHsLuTmzPMqTKWZxWW?=
 =?us-ascii?Q?7SwOHa1VqiWybqAackErR7vscvEWHulWixT2iEcJcsi4ANq3eEG3iLliGZmP?=
 =?us-ascii?Q?G6zlVgIZQgPva2pCK95Irn+fOMIMP+RPFs4qTa8nwllROjkTwHpViyDKvMCf?=
 =?us-ascii?Q?Q+tz9o0ejFxmrrOt6wjVAK2GWpiEB6BUF6ZrcgJtIzuI0Y3AfVIVbA3lUQOp?=
 =?us-ascii?Q?FF6Jq514ymgWY80B9QLXwWkfKncEh6/nKwwAifAFNORyt75JpNkXIq7DVLv3?=
 =?us-ascii?Q?2ujXoJnO/3SYoeD1+VVLlcEc28kTZHsEVt9zn4TqQwh77tx1euNHwmLVgemC?=
 =?us-ascii?Q?zP2ggnO0ilBnkxBeQp7JSAb5ML2xJTpbgoufcYIoeDI/2gfVTzzY9Wghreqa?=
 =?us-ascii?Q?tHgruyK395zTmB/NuxY1WKNOKG0Ggq33nlmeo0PUhZA3hBMo188Qhfegl3LV?=
 =?us-ascii?Q?3+9WXBUNNznoMqAux9yXhCG1aMVKqZo9F0XkatcnWc2CP1oFZsGl+mScCDqy?=
 =?us-ascii?Q?CwDMbtlf3Kj15GawDwoRwueh62+UskC/3ht0Xpc/97zxCk5hq2N2UUhhxt8J?=
 =?us-ascii?Q?S1aErV/8FRZxKK+H+cCfvKzYWVmMKCa/YRCw5EFNvMlC59io6qqYd736CXlU?=
 =?us-ascii?Q?+Sv+qyTSS/J8/bUDfEljEcwmZTSWoE6zcwKZhDAR6QehHJtqb0tbUNGksMmp?=
 =?us-ascii?Q?dUcwgMaSkKz26cqy9um901c/bUR2OkzDypFHcBETdZfKaZOzcieaBX+GL3lI?=
 =?us-ascii?Q?1nbskgxMw5AA7Lvq5Si1mOTScRU33SDeF6I1lsDecqhUcRitA6AWIMjXAgxB?=
 =?us-ascii?Q?BAtKKlEDhvNgCEZa9VWGR3Q2PCGZ26g0D3Edjla88YPAy/uaeCazNCd2b9zo?=
 =?us-ascii?Q?351H6g5Dz7aJNC1Yl+Tw/qhrcCdcWKoABSBn9V4ofiJ5WLreu2d/tmR/24i0?=
 =?us-ascii?Q?1Y/6rm7Din7ffYgwcPnIwW/ftVnIgjV52zGz9BK+XJIL5OSK1suGHFzJNbDR?=
 =?us-ascii?Q?SqVcFA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f56ca7e-4775-48d2-a16a-08ddb7ea73b2
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 15:26:14.9744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tjr4kBqnzdABDs3BcgqpF8gSd1ubCmBSfom2tmOCrWRwcDP29haCgrWwxzMvjaPTs1u6xTvhtlkplCta7d5TkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8628

On Fri, Jun 27, 2025 at 11:21:36AM +0100, James Clark wrote:
> Improve usability of target mode by reporting FIFO errors and increasing
> the buffer size when DMA is used. While we're touching DMA stuff also
> switch to non-coherent memory, although this is unrelated to target
> mode.
> 
> The first commit is marked as a fix because it can fix intermittent
> issues with existing transfers, rather than the later fixes which
> improve larger than FIFO target mode transfers which would have never
> worked.
> 
> With the combination of the commit to increase the DMA buffer size and
> the commit to use non-coherent memory, the host mode performance figures
> are as follows on S32G3:
> 
>   # spidev_test --device /dev/spidev1.0 --bpw 8 --size <test_size> --cpha --iter 10000000 --speed 10000000
> 
>   Coherent (4096 byte transfers): 6534 kbps
>   Non-coherent:                   7347 kbps
> 
>   Coherent (16 byte transfers):    447 kbps
>   Non-coherent:                    448 kbps
> 
> Just for comparison running the same test in XSPI mode:
> 
>   4096 byte transfers:            2143 kbps
>   16 byte transfers:               637 kbps
> 
> These tests required hacking S32G3 to use DMA in host mode, although
> the figures should be representative of target mode too where DMA is
> used. And the other devices that use DMA in host mode should see similar
> improvements.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---

My test numbers on LS1028A:

Baseline XSPI (unmodified driver):
$ ./spidev_test --device /dev/spidev2.1 --bpw 8 --size 8 --cpha --iter 10000000 --speed 10000000
rate: tx 2710.6kbps, rx 2710.6kbps
$ ./spidev_test --device /dev/spidev2.1 --bpw 8 --size 16 --cpha --iter 10000000 --speed 10000000
rate: tx 3217.5kbps, rx 3217.5kbps
$ ./spidev_test --device /dev/spidev2.1 --bpw 8 --size 4096 --cpha --iter 10000000 --speed 10000000
rate: tx 5118.4kbps, rx 5118.4kbps

Baseline DMA (modified just DSPI_XSPI_MODE -> DSPI_DMA_MODE):
$ ./spidev_test --device /dev/spidev2.1 --bpw 8 --size 8 --cpha --iter 10000000 --speed 10000000
rate: tx 1359.5kbps, rx 1359.5kbps
$ ./spidev_test --device /dev/spidev2.1 --bpw 8 --size 16 --cpha --iter 10000000 --speed 10000000
rate: tx 1461.1kbps, rx 1461.1kbps
$ ./spidev_test --device /dev/spidev2.1 --bpw 8 --size 4096 --cpha --iter 10000000 --speed 10000000
rate: tx 1664.6kbps, rx 1664.6kbps

Intermediary LS1028A DMA mode (using non-coherent buffers but still
small DMA buffers, i.e. holding just 1 FIFO size worth of data):
$ ./spidev_test --device /dev/spidev2.1 --bpw 8 --size 8 --cpha --iter 10000000 --speed 10000000
rate: tx 1345.1kbps, rx 1345.1kbps
$ ./spidev_test --device /dev/spidev2.1 --bpw 8 --size 16 --cpha --iter 10000000 --speed 10000000
rate: tx 1522.5kbps, rx 1522.5kbps
$ ./spidev_test --device /dev/spidev2.1 --bpw 8 --size 4096 --cpha --iter 10000000 --speed 10000000
rate: tx 1690.8kbps, rx 1690.8kbps

Final LS1028A DMA mode (with the patch to send large messages as a
single DMA buffer applied):
$ ./spidev_test --device /dev/spidev2.1 --bpw 8 --size 8 --cpha --iter 10000000 --speed 10000000
rate: tx 2247.0kbps, rx 2247.0kbps
$ ./spidev_test --device /dev/spidev2.1 --bpw 8 --size 16 --cpha --iter 10000000 --speed 10000000
rate: tx 3477.4kbps, rx 3477.4kbps
$ ./spidev_test --device /dev/spidev2.1 --bpw 8 --size 4096 --cpha --iter 10000000 --speed 10000000
rate: tx 8978.4kbps, rx 8978.4kbps

So after your patch set, DMA mode on LS1028A becomes more performant and
should replace XSPI. This is an outstanding result. That can be done as
follow-up work.

