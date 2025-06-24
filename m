Return-Path: <linux-spi+bounces-8744-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 496E8AE6CF8
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jun 2025 18:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E4E85A79EF
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jun 2025 16:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A8A26CE00;
	Tue, 24 Jun 2025 16:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="glbOVqva"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012021.outbound.protection.outlook.com [52.101.71.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD612E2F0D;
	Tue, 24 Jun 2025 16:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750783825; cv=fail; b=H9dN6u/JOYpuJm9x9fVMBkd8DqW2rXO5nwzgd/2NDqLBXqncbsXiFatvqHIB5WlJ89UEf8Ws4XDsK0GM/YQpQgbWFengmlSZd9yCHQTlmcp8Vb8/qmxHcY4o7Z9Aq9LrBDlLJf9fhM5e9lPg5UKhVSk6DU9u6jbAfb5lyyzLVww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750783825; c=relaxed/simple;
	bh=2TaOSnPhFfkx/L6u6r8GgvVJhs5lxIK9dF1ikR0ahY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tkhlwYJK1MLkg+c/RW67KD1SrjmQ4p4Ejxbog1ziRiBlXUMXe0+x8Qou3R1lX3+6pFfp+EyH0myhcOIKolZ8bmrQPsv4ncLtY01mxBo7zMFZaijvRW4b2kQ4IWtwbFuGmvGwEWrv4h6PtR72P19Tlsvmnf4LNHMXFN5kYTOolRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=glbOVqva; arc=fail smtp.client-ip=52.101.71.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gVfuJJDr7n2aU48JwfRi/TRnTOu9LqMwOxVm0B4ErUwiJsDruLh75bbVOdre0f9EVNevgegMwkRTPkpF7wAhZqgxxGtM6fvaAbIGJcxxYeqTYokIwXhWVRqJGRcn9rY1RVg0IqL5OFbM4nbcHQxv6S79NYp2IeQb9VLS+lPmfDudjh92oiMn25x2zz/KOFKb/xTcJg/nF1jOMALTAOF2Ls74KYMbshNhSrm3QP7KgJS3ZkVNZ1L+/e5FBKkcFNv+KSV+uacIY2fl83RekTaJvQwtTnQkEX3/Ph1DF6Bi1Cpk2hYe0NBsU0rxayNO02sFZZSkADEeK59YJ/hTNaH+Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CR9ZvrD8fusPGqAfNkPhgWFge0B9pG+mzsAxRiJhOF8=;
 b=BLMxVAGmpuHDhoZkGIRjVp5RAz63Qkf9R1uxY3CvM0JgakPZGBIA/KedItaWXhQxBoVaFbweN9GoxGDCqNo/R2twJ8/jhYTeBFEve936BSxnkevjIhvor+frenlEIO2f4ktXV8Fg1plBr1h3no+zfrgR7JoU+NWBr3881SUFqdTDkPBzMdETcERflxkCEj4GFdU2ZASKL/K+9/uf2knfNqTePZ9LFuQtKDt5fc7KAbNAZJsVovGiIFKbqrq3F0Bu2KrU35Bs3wpyGo+ddn//SUct6/8JOhBchir6glubiIUHCVjs91i3bJkapcou25QNHbmw4eeC0GEFttFZKTLPWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CR9ZvrD8fusPGqAfNkPhgWFge0B9pG+mzsAxRiJhOF8=;
 b=glbOVqvaIOG1vhmZf2zXsClRqGKYgnxKCAChCXJBr7ojreGIV92IZBIAyQlh84CtTQNyS0YWK/yIvAdZgzyDas0XzQCwxcvohrr7SZRAH7InOumCpc3uhY3FJygyO/+CzcrVFdakPbI/CIjljUYYSWwlkk8bgAS3TEUmpG9/65mhGLNFCIyMnquKxVe0jjOIK0LXorpr6Qc56Le3o4fzebNgPDV+eVUyHMH+2G1h+TPVtOrN1SiEP/lwfFozQswSsI4ltFK2inMFafs0zPDuPkheiPemqbc+5DYOjSUCOt+xYDwiSddR9pz6+8uEmhUcchs0I10sghusMlgOYidH7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7143.eurprd04.prod.outlook.com (2603:10a6:20b:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 16:50:20 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8880.015; Tue, 24 Jun 2025
 16:50:20 +0000
Date: Tue, 24 Jun 2025 12:50:12 -0400
From: Frank Li <Frank.li@nxp.com>
To: James Clark <james.clark@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Christoph Hellwig <hch@lst.de>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] spi: spi-fsl-dspi: Report FIFO overflows as errors
Message-ID: <aFrXRDJmMgt0qTlL@lizhi-Precision-Tower-5810>
References: <20250624-james-nxp-spi-dma-v3-0-e7d574f5f62c@linaro.org>
 <20250624-james-nxp-spi-dma-v3-6-e7d574f5f62c@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624-james-nxp-spi-dma-v3-6-e7d574f5f62c@linaro.org>
X-ClientProxiedBy: BY3PR10CA0014.namprd10.prod.outlook.com
 (2603:10b6:a03:255::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB7143:EE_
X-MS-Office365-Filtering-Correlation-Id: 05bf3ae0-cdf4-4041-88d7-08ddb33f3453
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5ISnDQazjjC1EvGvIevYsoccqTylWT6iUDt9YBlR3j5xshj2Eqmu72TDwflA?=
 =?us-ascii?Q?6GRGKC0YL3XfUmMhyvb++MkTzve+i0+yU510Lhvbxe3m+X7muvkQEXn667rW?=
 =?us-ascii?Q?UgL0sRcOADRdp0diN/w58RZfHWsjvKJVvHTisg+De9jymLjo+9ZzlL3OhE2T?=
 =?us-ascii?Q?FYD4pgcnUEnoqLYkN/4ckB5ZVaJom3trtYxjZh0ItDktls0UE4BGUkgV97SA?=
 =?us-ascii?Q?EVt7wz7yrilljUSZgXwEJ6w9FADp1viPmhF8A5t4kJQKlGYmQXYkJQwftn8j?=
 =?us-ascii?Q?Q1U+To6scd6sfHuvwyuOkXiDgK7BxgfsqRAZo0fGeOWx+6roe5NauDs7RBxK?=
 =?us-ascii?Q?iHCvA+q3QZFP+6GjTAHTwyD2gJqawb8OyxWOjhmc7I1Ymzn/Vkqfn1SsyD/9?=
 =?us-ascii?Q?Hzz1IKhoS062oqomh5FSnNO9gVxVeYig42AbCf4DT0ISRDRzd0l/CN1fBP4Z?=
 =?us-ascii?Q?8uD5dfJJvVH1Hbdkje06wrg+XTHUDKI3j3FJ5fWcp9JAgtWb6B5d6Hk5NFql?=
 =?us-ascii?Q?0Z/R13LRpG1QeUaHU/snSdBq2gyzvy3thUih91u4kfhL5ibVAooAuNUmdCLy?=
 =?us-ascii?Q?hlaeGqDHjDLqqsOYcy5vtBmWSm3PbeHnJDkP3sOWmpvcYwehHwilWfofTJjP?=
 =?us-ascii?Q?ZX5fJIK8Tr0cj3Es76CHcjRXX6pFd25Mde+bzozpRjOpGp5WVHJ4crP8b9UA?=
 =?us-ascii?Q?60t+/MkiqJNAvBef+gR8duPM0wrzuCaj4RK0G2UAgYDVf0FdiarkFUohKHAn?=
 =?us-ascii?Q?dHFMUoW1jY8L8j+wLUMcWrZFWRsVJWVKdegK9MxAYk/Y1VIS5Cka4EQFHGaz?=
 =?us-ascii?Q?n/esyKvOprBFzhSWLGejaWqE5+3/xxL1TTrrlY/lGJR2X4AdmivjO5NHyqkv?=
 =?us-ascii?Q?NugfGPB57JBkKWgSdB5HlN6Y+f+J+AvB7Gt9Kc/SUTISkWgbc1oMn2LMRzrE?=
 =?us-ascii?Q?5QBuqytqhcC+cUxV/dG/5Sfrzb19S7/CGLyV1Wbrwjx8FNCqc7/0h6Gh7yYU?=
 =?us-ascii?Q?Y6/v4JYZi7oXDAG2r06Sjm1ADuHxIwxiY384hfBcWxeZEZ3X1Dd5BrLNqEwl?=
 =?us-ascii?Q?ZJm2sdQcdflxAjtRf7jHvh2iiV/3a6GKUy5h/qgferQNywDY2tpXhZXxn/2K?=
 =?us-ascii?Q?LR3cwXH+h1wGQuN9SOp7zkecJEHWSTgavT1ZMobP2vreyPQ9ADuyLiNalzPD?=
 =?us-ascii?Q?Yc6YvpyNU21chzthUblu4hzWniU3ORBNkrRj7Ki8Xdf5xD8y50+W1kRSZO/C?=
 =?us-ascii?Q?9/1RhAfQimfgN2HsqdAXRvyBCMzrGSW0f5rtt8KXtVAV59NUge5YYaNu+Tyj?=
 =?us-ascii?Q?mfUikH7QsxtGV0FdiVfV0u0Fb57DD/s4u8Fc/wcYZmsk+onOk+mzaeaSCbVo?=
 =?us-ascii?Q?e+4/2Q+wIDjhfVfB4A1Ns21ALjupeChUoEZobioLtdKPemy4us5zY2ZOBwyY?=
 =?us-ascii?Q?S8rV+LT7msfcOFzzXZvvow0KXCeAbIpp7ibRk2hJmp1jYdxbddl4RQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iJPfK5E85mNN2l0z9MmP9bGCfCKXOtdvobpmEE0P2rqXCzxRrcswhIIHsyQm?=
 =?us-ascii?Q?YyJZhA5q/Jfr13uLjSDknf4ovsuxkRvaMqKwF/t/1atwvMLUp8DAqfzg+uQo?=
 =?us-ascii?Q?E/YCdMr51y9+KDmCCUGf4Mc1kR+Nt6ktVj7/tYbqJh+hnBqfSOz4bwjF/E5Z?=
 =?us-ascii?Q?ku2pLqXViGqRNtqtvVkoppaSax5dgZFGQ7D/MsrjMarFeRwZZ3/NDx+yAhPw?=
 =?us-ascii?Q?FJZ7kMY8QJFkMIyWBq4cRM+phF/pPZCcUFbhWMVZEjkReJTKXSSBFskyLxhI?=
 =?us-ascii?Q?X6fuJKguKTCMXUjT8hKRBeMJTtg1A6/QQkoI8R41aF6nesv7M0VjaTqNQOdw?=
 =?us-ascii?Q?EFKxhxTkvNF9u9SMYCKcb060m7p0TKsRkpOan39cQnc3i0M4oLiuWp0nFdkv?=
 =?us-ascii?Q?6qtR9tJH1Wqa+3s/WqHKbwxCNARRD+HGEeUzhfqlHKDsC6RRpDBhBQnjL4f5?=
 =?us-ascii?Q?pKsoPeP7b5cPlkbUXqr4dZ5GP7VLzNz/cBbMBpiSfzdtkfPaMZE54pnHh8YB?=
 =?us-ascii?Q?a3Mq3WTqqWjBQGRWsL7g+Un1XwdR/wxSltvpjhBggBF8zCVtKHfKV0eB7hay?=
 =?us-ascii?Q?Ra0hi+jYiuKMWIZPw8ZT955T34xD635oU7wSb0dzRNmk43tiPU+PwKQVHiCW?=
 =?us-ascii?Q?cq7vzALkE3nJ26DOUuXbigpSb2YvYylto9srbQcxAV0zpsuFaLMrlmxdVYq9?=
 =?us-ascii?Q?lWZajb7vNhaGg7Be34zpUXbqeTBRzIRH7d0/qVg7ME7K9573PcEq0DkUmNid?=
 =?us-ascii?Q?bmQUSzOfxSAM1Rud8EpiHY1mIkfqo5AiDcN6o9zwo12dp7+rG+64C1p7ts53?=
 =?us-ascii?Q?d2gOt6CB7zyqGa0LqHcYN3ogAQf7Np6HUmpWW+E/03pP9ROJizE1zg0b2NtD?=
 =?us-ascii?Q?d4fh0qm1SEe7sLI4jkTIAG1+G/8I9TAMaio3ueX9Qk1WU1qJaz6Lj5HcjP7W?=
 =?us-ascii?Q?AbdDezOGY6Wnbx2y/eYiBOgatuBu+ImoVvEYAaG7zsBghxPfPY1wrTR2O3I3?=
 =?us-ascii?Q?rWDApi/KwLPrhNpRehrwPMl3hmUUm+l8qM/FH166UKfWklLbmkNyajqDwiFs?=
 =?us-ascii?Q?q9vV/qR5Cn+pudt+S22tPCxj3OgmxtUn1nnvrrgOlecPceWRAD/FN5+FqAhZ?=
 =?us-ascii?Q?CsL/8IqHHOpiC4vGZnTfHt9XKvMWRSLEi8GdqaZVblwX+loP8THXE3bu7lEo?=
 =?us-ascii?Q?2Fr31O3cki8Cao0/ECj2E+UgSdF4tWV0VjQM8yg/97keAfIV1srZmzGGVKoO?=
 =?us-ascii?Q?DcsF5dxzTW/KXZY4zCAN+AcZGsvTUjtD//TOK+2VpmIc1IXdxuEXO379kDo7?=
 =?us-ascii?Q?AMvF+SpMFzXirQ9pxpku9wlCXiienj8cbTzxH3GLX/0KGSiicrdrCEGDnPZc?=
 =?us-ascii?Q?hSbIi2b13PL39MYhSWmcb9LKDATdjix+heMcgPTEk1FdEBNBmsjgsCQXOiOq?=
 =?us-ascii?Q?WEZHf8BsvcJIuyVhiaZA27yMe5omuaaVGMhFUIU9AMh11ad7EogQEqEkom0I?=
 =?us-ascii?Q?NSfpTJeGhFoEbC3eMUNqUmEQD0FhIBnmj03LZd9SHU2N7NcAd8thgbAAJNhg?=
 =?us-ascii?Q?mUJeXcnakQmkebmozfNU7SG3hs7T3OZAEkgRFdUp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05bf3ae0-cdf4-4041-88d7-08ddb33f3453
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 16:50:20.0741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BRWU5LgCs1eNf5PU3s1Bc24cXiajbVkhdqRO6b6BXaj/JJhxULa54q8PdDUFlsB3EqrgQqOk6dG+jKL8ABKO7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7143

On Tue, Jun 24, 2025 at 11:35:36AM +0100, James Clark wrote:
> In target mode, the host sending more data than can be consumed would be
> a common problem for any message exceeding the FIFO or DMA buffer size.
> Cancel the whole message as soon as this condition is hit as the message
> will be corrupted.
>
> Only do this for target mode in a DMA transfer because we need to add a
> register read.

"We need to add a register read" is not reason.

Add checking FIFO error status at target mode in a DMA transfer since PIO
mode already do it. It help catch some host mode ...

> In IRQ and polling modes always do it because SPI_SR was
> already read and it might catch some host mode programming/buffer
> management errors too.
>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  drivers/spi/spi-fsl-dspi.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index 58881911e74a..16a9769f518d 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -560,12 +560,24 @@ static void dspi_rx_dma_callback(void *arg)
>  	complete(&dma->cmd_rx_complete);
>  }
>
> +static int dspi_fifo_error(struct fsl_dspi *dspi, u32 spi_sr)
> +{
> +	if (spi_sr & (SPI_SR_TFUF | SPI_SR_RFOF)) {
> +		dev_err_ratelimited(&dspi->pdev->dev, "FIFO errors:%s%s\n",
> +				    spi_sr & SPI_SR_TFUF ? " TX underflow," : "",
> +				    spi_sr & SPI_SR_RFOF ? " RX overflow," : "");
> +		return -EIO;
> +	}
> +	return 0;
> +}
> +
>  static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
>  {
>  	size_t size = dspi_dma_transfer_size(dspi);
>  	struct device *dev = &dspi->pdev->dev;
>  	struct fsl_dspi_dma *dma = dspi->dma;
>  	int time_left;
> +	u32 spi_sr;
>  	int i;
>
>  	for (i = 0; i < dspi->words_in_flight; i++)
> @@ -614,7 +626,8 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
>
>  	if (spi_controller_is_target(dspi->ctlr)) {
>  		wait_for_completion_interruptible(&dspi->dma->cmd_rx_complete);
> -		return 0;
> +		regmap_read(dspi->regmap, SPI_SR, &spi_sr);
> +		return dspi_fifo_error(dspi, spi_sr);
>  	}
>
>  	time_left = wait_for_completion_timeout(&dspi->dma->cmd_tx_complete,
> @@ -1069,6 +1082,10 @@ static void dspi_poll(struct fsl_dspi *dspi)
>
>  			if (spi_sr & SPI_SR_CMDTCF)
>  				break;
> +
> +			dspi->cur_msg->status = dspi_fifo_error(dspi, spi_sr);
> +			if (dspi->cur_msg->status)
> +				return;


Although fifo error may happen after you check, it may reduce some possilbity
and catch some problems.

Frak

>  		} while (--tries);
>
>  		if (!tries) {
> @@ -1085,6 +1102,7 @@ static void dspi_poll(struct fsl_dspi *dspi)
>  static irqreturn_t dspi_interrupt(int irq, void *dev_id)
>  {
>  	struct fsl_dspi *dspi = (struct fsl_dspi *)dev_id;
> +	int status;
>  	u32 spi_sr;
>
>  	regmap_read(dspi->regmap, SPI_SR, &spi_sr);
> @@ -1093,6 +1111,14 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
>  	if (!(spi_sr & SPI_SR_CMDTCF))
>  		return IRQ_NONE;
>
> +	status = dspi_fifo_error(dspi, spi_sr);
> +	if (status) {
> +		if (dspi->cur_msg)
> +			WRITE_ONCE(dspi->cur_msg->status, status);
> +		complete(&dspi->xfer_done);
> +		return IRQ_HANDLED;
> +	}
> +
>  	dspi_rxtx(dspi);
>
>  	if (!dspi->len) {
>
> --
> 2.34.1
>

