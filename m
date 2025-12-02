Return-Path: <linux-spi+bounces-11721-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1C8C9BE4C
	for <lists+linux-spi@lfdr.de>; Tue, 02 Dec 2025 16:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 573D14E2027
	for <lists+linux-spi@lfdr.de>; Tue,  2 Dec 2025 15:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D87F245005;
	Tue,  2 Dec 2025 15:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ru/bp3mT"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011035.outbound.protection.outlook.com [40.107.130.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7434E1FA272;
	Tue,  2 Dec 2025 15:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764688012; cv=fail; b=avP3c3Gv6pTi2TkgCe7TM1Ra/n7Ow+ezaejkDJvJghInKz3CVIB7rXZMCpqssRs75mfng6RUnKJukgab7yI+NkvWStOZ1Mx2LS/+lPry3G3+OC+19UXLvyPaV93LUCKAYUMIS4DEsAj8bjfgne8sG7kd+GZjYGQy0rcFLzxPwjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764688012; c=relaxed/simple;
	bh=MLYqTDAJ86kxs++RiYuVdLTf2Cu4dHP6eZtjoXe7ah4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HhmySdrISIP3WPtl6w0DBfQmaVNLjEoj0BY1UWPSDg75kMj/gVKjGXEPBJdSuonycNRBIQdZIO7jZgkMPGvH24PAm6lw/OVy/HWGIQ2/kR22fMiqwFf/pjODhfAWwVEyluGn/CJ/CK7RpR49mmP+9HrIQeINWS8hwcb8bJKlX7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ru/bp3mT; arc=fail smtp.client-ip=40.107.130.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mmnq9TTHwMxX7yVkr8E/kn7qC4wqXV4wiHRP0l+M67nMcBViRQB9z1X6Toku6a2PphlnxGEl5zfMqSdiZ7sXCn3GjQgLf86sSlSEGp1RLbB/gniTmrgfno1xHex+9C+NA9IfmbTJ2jiNxTmoYk0RaeLRzOSxbKpmzXsaIQey2xGiOf8gW6ZLAq9tmvESg3vS5EKIPgeiFQkojTdwt0TaMzCSIdIE7TCXxVFiezvdX252qNIAJcDQRqnuy9OEWLttCNsEZG9ebUs8KCzRW8wxy5fsQoHSR5Zb5nTF+iubHQ+oBtWnFDFE/e4NiWRPMSTZ3YuCe7vwFxCjDvIzqgc6dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RG6h3sHeyx2SfS+QyMfMa+TjRgSgMxmEGnBwRBwzeS4=;
 b=dHRuZ3ESfG0YAvdlRppm7YgxzX2nnLsff5afJOIWVaBUggLz8kFT1gk2Fxu5U2LYaRTqZwL6Nu3y19AJ9IMcb/wmxqfe3CI34aikwFGkZ1Zm5lt9AgHozIBNeLe8wflTrtOdZPTdLQDFvz+BV8XGF2ZARwVsFQgx9sGZTkUk5iVZJQ8vD2o//ZeX4sW72kEGroD3Il8AoroW2JsO+gC+uzhlDsuC0nvA4x4yGo1Yzb9hPPOJpG1iDWAo1cjqlAjS+ic7or+TtMy0TDGTrXvAULR6FPtiSk7uL07/hZ0RF/f28TIc+kdLGx3GcLx9qKMhbm5MMqmopHVoeQMMkXtllQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RG6h3sHeyx2SfS+QyMfMa+TjRgSgMxmEGnBwRBwzeS4=;
 b=Ru/bp3mTSJlHGufW4ofBTvn30vaAnb+WiqUdbCzaEj3cbpJmPW57jqheEVJH7lB/Ip+xfoepPovLmXpZpmhAGFKSJHuwkcCz8I7yXkz+l92y3TyLkJkg5Kry9m1sU/N4X6Cq8RHudMUqVEA3x7DVNlucQ52PMQjL37JuxrZ7jx7KISKPI4zqLY/jWuSbySqeDDkKJw20NHsc82EA2e3ic0KPCMMpl9Gg/0nDcYc9kItx07E95H3oqXXXz4jrw/XfmweCpXFfQm19U1dL2bVjD55/0h+cLIasjfT9FyKEQMV6+nf1kzukA399Hh756kCy7A4PREvKl+GfwGYnPVnVrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DB9PR04MB9791.eurprd04.prod.outlook.com (2603:10a6:10:4ce::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 15:06:42 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 15:06:42 +0000
Date: Tue, 2 Dec 2025 10:06:34 -0500
From: Frank Li <Frank.li@nxp.com>
To: Carlos Song <carlos.song@nxp.com>
Cc: mkl@pengutronix.de, broonie@kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	kees@kernel.org, gustavoars@kernel.org, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 5/6] spi: imx: support dynamic burst length for ECSPI
 DMA mode
Message-ID: <aS8AeiGqs6yv5V0u@lizhi-Precision-Tower-5810>
References: <20251202075503.2448339-1-carlos.song@nxp.com>
 <20251202075503.2448339-6-carlos.song@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202075503.2448339-6-carlos.song@nxp.com>
X-ClientProxiedBy: PH7PR17CA0041.namprd17.prod.outlook.com
 (2603:10b6:510:323::24) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DB9PR04MB9791:EE_
X-MS-Office365-Filtering-Correlation-Id: 36a7aa9d-f3e9-4806-36e1-08de31b466f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dJ4Elou5oxcXiMRWWFKCpai2z98KoHFU2qzDmee4pTW4m/KuNLvfriAvZXab?=
 =?us-ascii?Q?4yiUZ5ZEy7E6wi5Thwes8YNMcdWOTGoy/m7sE+2sbWXiwcDCKiYouOcKMuXT?=
 =?us-ascii?Q?aPByplLe4OYOT59OfwMZKIndzCVjm6fozqU/sdFJbZa6KlAmat+FBpZ5qvXu?=
 =?us-ascii?Q?oGTZeNqbsWLFuRiXGDMtfwYwp3Iv9HWBfxUHgSVDt/UNghpI1gfw8FveJl2T?=
 =?us-ascii?Q?kDTZvnASItiLYNcJVV/vih1R2QECgmdlYohT+pcQ++sfK2XA2XnJlm+H3zgd?=
 =?us-ascii?Q?JJEQDKyHMpUPsYfXG05/3lWDryJ2t+FDXAgWSQtyvqY8fRaMHdQptptcG1j9?=
 =?us-ascii?Q?ZvDJJLFQ7d4iZfnVnjUcFtPNoVZxBo3vv6gvoSUmoIRlxmu5VerAYbcuIf2N?=
 =?us-ascii?Q?StuNucjkOAGEY5IBT38JAiVigPkpbTkTzJ1ftpNC5gKDeUuFOcu91ngrBoiy?=
 =?us-ascii?Q?WA2mkxiSF8jAYOi4uPUKvdVcEJ5hsQVTpn2EuqKIwzAXdW+AmFeg04gBQ/yi?=
 =?us-ascii?Q?FWfi9sX4i/Kq9KQokGVm5zkr2hpUStdiNF+JBwFk29FGJkKxAclburA+qOqQ?=
 =?us-ascii?Q?yGUv98shtalcQkpnU4mQEzIqUd1DrOXtBmaCdkSFEkCG0kEs6R5Q+FWl4Kw2?=
 =?us-ascii?Q?itc+HxkpCWoXzOUv55yk6SnfZrT7cCk/uaebHiQlFhnlg8NtfXrZTeFogX9h?=
 =?us-ascii?Q?mR7BOV08iMMa0AOoe3GTdG7SVh3zzJvANOoISQzZk9Q+uym66yWc2Flx6Q+q?=
 =?us-ascii?Q?q1aCBb4LewhMSUIu9jJgi9g/FdosUENhU053qTMoxNMgGdLiYceqesm7I4az?=
 =?us-ascii?Q?HFGjZEukkQflUuB4Z9usIVZt3Hwd1NvapLPYVlA1xPqZnj/FkHbovMdON32x?=
 =?us-ascii?Q?KnoM34y79VRQpxGgL4qJO6qtoT302/duFMV4yUs5lhcxNnQqDiyAm/a7toUM?=
 =?us-ascii?Q?++0p3ySdcJSv+nA91Nq0Y05BKDFFLPh215mLVHBqfKJ85GBpxk20wXp47zoC?=
 =?us-ascii?Q?5wgistQYbXHgQCdWuEF22DyxYKmf8YytS022xWm1DyDjG7IVA5KClVWIe5B7?=
 =?us-ascii?Q?agtoIQXHXvt60m9YaeQJu9N7Av/JHmV10BNhS6Pn4V351FnITJvIz1mGMtLH?=
 =?us-ascii?Q?8X8OC7q7mc39pfPE5T9MEEC6qNQYib5PGZaNAshWm5WeRoJa0u0qbwzC/Zgg?=
 =?us-ascii?Q?o4Tl1XmirqHCc9vuW6oH9cZkLHlD32J15H2U1RchyX0UgQukVrOLw0kJcGST?=
 =?us-ascii?Q?MfBmXkccHxIHThQgdjP2ISFIGBCbupoKdu1WwVOKNAloDGEwwqreHuTIVG1b?=
 =?us-ascii?Q?8PNOXZttVuPJR6UKwrTeMfW4095LCGPjAyOEhD1pBBlbkPajlTdVCUxfTdz2?=
 =?us-ascii?Q?onsU80voNRy5wwC61jBlP4jTUR7YZ1U3u/BwEr/jQ5y62YiP7xhI7LVs4wtO?=
 =?us-ascii?Q?CVI1Tb/WZldTsJTc69R5mlT+sV54ATUbUtgG2VfSmym3HXRvCIibDFIR59yH?=
 =?us-ascii?Q?1xQVruuHmysoNGrxP8p8pW1ZKugmeGKBm6hT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?azYa06PdsXkE4Bsx26xDQbH1qEebNm2exfdG30GpdtmqnEQCpZ3BzPWYRxHD?=
 =?us-ascii?Q?P7q4LcoRxLQluDCemltMl2IOuYI9i387M2VXSp0PWuIPUaeqpjekYLe87DXF?=
 =?us-ascii?Q?t19fdEpbtQXhjMQ0peuy+eBvjTvEzKZ+m3atm4OG1vP3xTtQK+mpdfWsv/Mr?=
 =?us-ascii?Q?6SsVaigy457m2kXKDcn1Rtzu2LLFeCuaOuv2WU5AHiHvGU/8vSIAzU/zUAMy?=
 =?us-ascii?Q?8JBxaHukEBLTg82QMDsFcpjnZk07DvP7kqCKEhDsFpJ+E17InF5Xf5ezX7Xg?=
 =?us-ascii?Q?X0BnfY00WHWi4iE5pgEAa3A+AiQziHIBM79F2ydxNyXqxIuMRCsZTxcFL2C5?=
 =?us-ascii?Q?60L8p3cPfVfDINQ5BPOphtXZ9a0S6i3l32bD/aq1sbKmWX2H/8EpDd9J7qcA?=
 =?us-ascii?Q?6YbumtIC2x3ZLeIP2ktR/yWDjWQ1SrQGH0x3oJR3kQg6PHPoua1nT6ed4q8P?=
 =?us-ascii?Q?7oj+b+tiQ3LK6fUMxE+tjfqljejlP4Ab2qKURA+zFfP7K1PAyjj7g2YkOPtX?=
 =?us-ascii?Q?7LWEJf3cnDDebgIob8YJenXX8jpzCrcqnrY0YUGJMC8oZB5UJzdQVLcNZDLQ?=
 =?us-ascii?Q?/1X0sBiFwXYR0EeIWrOfT/lIAl5VhOVS8NeARWVlnNCH7dnwUKm4uM8pbtnu?=
 =?us-ascii?Q?JJhD0NLYDG2xQJ1YMYzVlbDYf/zfn3cXHDFWcJqdta5siiDp1W8HDsSt5T35?=
 =?us-ascii?Q?gqi+pFryM2nmHkHF1VAbjcrPR9TjTv7v23r4ZcWBpTFlT4jEtE9Ug0x78JjY?=
 =?us-ascii?Q?z8EqjFRkoNewsQLbfNV02IdG1oOA+QbQhXOga1FcJ8NahZU2x7mFlXWkSpYX?=
 =?us-ascii?Q?+l3Pkkty6wqE50KPv5g+9j4YafdqstsXZdx+T4taB2I+Kue9vovU4cSV3JzL?=
 =?us-ascii?Q?ls5oP7n+HtjMvdBozZ3PY8n5vkoVL1xD9bIuG3L7H32ddOZNlR3e87ciS4S/?=
 =?us-ascii?Q?3UFYe2weMBbKIooaYnZD2pHAxgwREHtzpdBkF376BIWP37ag51lYaIWV70XK?=
 =?us-ascii?Q?bs6MpQ/7oR3EP27X9xw6lhgV/YYRiaS8GkPI+ZTVlcV3R5q3CdO313KYKzPi?=
 =?us-ascii?Q?sZzt6q4KHIKn6i3qG9QiRKmeo6QVe0n2t1pS/Ru51yJuhZbNAgUcIfL/y6A6?=
 =?us-ascii?Q?0ygsOv1waacZd30eNgZwKLRTvDcvfX42OK/l1aQl4LJsabe+P/ce/euH2yuM?=
 =?us-ascii?Q?P0/wHKvkJ8Jh0hEZpCXdj1oEAIdNV6+pNldWzngQxAmoE3AK/uN9s7JQNyp/?=
 =?us-ascii?Q?ty1gIJyQ3KY/Sy7J7o3PB/NiAVpt/9EhwQm2w0HKJTVwloJgiqw7jEeOhUkK?=
 =?us-ascii?Q?fqMtPwUYLlxBScWJqqSLNSIBBCngqtHoSHmaUaNgiqo2duZJIOzoZYJATBqJ?=
 =?us-ascii?Q?MbxgGI+XF2esUf0uunWp4nsBFXR7gl5yx32xXapa1Wf4RP/vxND/SEO/4iZh?=
 =?us-ascii?Q?qFln9Mda5/6BKccpqhnwylWHzWO37t5Fbz1PPBmpRS6ACJO2uy/+zXB1+64v?=
 =?us-ascii?Q?Z/fZAyrFaYVSYcAJ/6NFC8/aeycX+VlACohdnFXyg0asX3P5ApRrW6efuQGu?=
 =?us-ascii?Q?aJB4kCCUUx5HWB0l2jv/6EXiE25hk+IzoeV5BQIX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a7aa9d-f3e9-4806-36e1-08de31b466f3
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 15:06:42.7036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QNEhrz5YVeSuy5GQONF+ReMPD/fjbuwUbfxxYG4ay6y5JCVbooNq7emOLzONixW0fDgxAjgDnbHblH3MJbVjYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9791

On Tue, Dec 02, 2025 at 03:55:02PM +0800, Carlos Song wrote:
> ECSPI transfers only one word per frame in DMA mode, causing SCLK stalls
> between words due to BURST_LENGTH updates, which significantly impacts
> performance.
>
> To improve throughput, configure BURST_LENGTH as large as possible (up to
> 512 bytes per frame) instead of word length. This avoids delays between
> words. When transfer length is not 4-byte aligned, use bounce buffers to
> align data for DMA. TX uses aligned words for TXFIFO, while RX trims DMA
> buffer data after transfer completion.
>
> Introduce a new dma_package structure to store:
>   1. BURST_LENGTH values for each DMA request
>   2. Variables for DMA submission
>   3. DMA transmission length and actual data length
>
> Handle three cases:
>   - len <= 512 bytes: one package, BURST_LENGTH = len * 8 - 1
>   - len > 512 and aligned: one package, BURST_LENGTH = max (512 bytes)
>   - len > 512 and unaligned: two packages, second for tail data
>
> Performance test (spidev_test @10MHz, 4KB):
>   Before: tx/rx ~6651.9 kbps
>   After:  tx/rx ~9922.2 kbps (~50% improvement)
>
> For compatibility with slow SPI devices, add configurable word delay in
> DMA mode. When word delay is set, dynamic burst is disabled and
> BURST_LENGTH equals word length.
>
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  drivers/spi/spi-imx.c | 413 ++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 377 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 42f64d9535c9..045f4ffd680a 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -60,6 +60,7 @@ MODULE_PARM_DESC(polling_limit_us,
>  #define MX51_ECSPI_CTRL_MAX_BURST	512
>  /* The maximum bytes that IMX53_ECSPI can transfer in target mode.*/
>  #define MX53_MAX_TRANSFER_BYTES		512
> +#define BYTES_PER_32BITS_WORD		4
>
>  enum spi_imx_devtype {
>  	IMX1_CSPI,
> @@ -95,6 +96,16 @@ struct spi_imx_devtype_data {
>  	enum spi_imx_devtype devtype;
>  };
>
> +struct dma_data_package {
> +	u32 cmd_word;
> +	void *dma_rx_buf;
> +	void *dma_tx_buf;
> +	dma_addr_t dma_tx_addr;
> +	dma_addr_t dma_rx_addr;
> +	int dma_len;
> +	int data_len;
> +};
> +
>  struct spi_imx_data {
>  	struct spi_controller *controller;
>  	struct device *dev;
> @@ -130,6 +141,9 @@ struct spi_imx_data {
>  	u32 wml;
>  	struct completion dma_rx_completion;
>  	struct completion dma_tx_completion;
> +	size_t dma_package_num;
> +	struct dma_data_package *dma_data __counted_by(dma_package_num);
> +	int rx_offset;
>
>  	const struct spi_imx_devtype_data *devtype_data;
>  };
> @@ -189,6 +203,9 @@ MXC_SPI_BUF_TX(u16)
>  MXC_SPI_BUF_RX(u32)
>  MXC_SPI_BUF_TX(u32)
>
> +/* Align to cache line to avoid swiotlo bounce */
> +#define DMA_CACHE_ALIGNED_LEN(x) ALIGN((x), dma_get_cache_alignment())
> +
>  /* First entry is reserved, second entry is valid only if SDHC_SPIEN is set
>   * (which is currently not the case in this driver)
>   */
> @@ -253,6 +270,14 @@ static bool spi_imx_can_dma(struct spi_controller *controller, struct spi_device
>  	if (transfer->len < spi_imx->devtype_data->fifo_size)
>  		return false;
>
> +	/* DMA only can transmit data in bytes */
> +	if (spi_imx->bits_per_word != 8 && spi_imx->bits_per_word != 16 &&
> +	    spi_imx->bits_per_word != 32)
> +		return false;
> +
> +	if (transfer->len >= MAX_SDMA_BD_BYTES)
> +		return false;
> +
>  	spi_imx->dynamic_burst = 0;
>
>  	return true;
> @@ -1398,8 +1423,6 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
>
>  	init_completion(&spi_imx->dma_rx_completion);
>  	init_completion(&spi_imx->dma_tx_completion);
> -	controller->can_dma = spi_imx_can_dma;
> -	controller->max_dma_len = MAX_SDMA_BD_BYTES;
>  	spi_imx->controller->flags = SPI_CONTROLLER_MUST_RX |
>  					 SPI_CONTROLLER_MUST_TX;
>
> @@ -1437,10 +1460,259 @@ static int spi_imx_calculate_timeout(struct spi_imx_data *spi_imx, int size)
>  	return secs_to_jiffies(2 * timeout);
>  }
>
> +static void spi_imx_dma_unmap(struct spi_imx_data *spi_imx,
> +			      struct dma_data_package *dma_data)
> +{
> +	struct device *tx_dev = spi_imx->controller->dma_tx->device->dev;
> +	struct device *rx_dev = spi_imx->controller->dma_rx->device->dev;
> +
> +	dma_unmap_single(tx_dev, dma_data->dma_tx_addr,
> +			 DMA_CACHE_ALIGNED_LEN(dma_data->dma_len),
> +			 DMA_TO_DEVICE);
> +	dma_unmap_single(rx_dev, dma_data->dma_rx_addr,
> +			 DMA_CACHE_ALIGNED_LEN(dma_data->dma_len),
> +			 DMA_FROM_DEVICE);
> +}
> +
> +static void spi_imx_dma_rx_data_handle(struct spi_imx_data *spi_imx,
> +				       struct dma_data_package *dma_data, void *rx_buf,
> +				       bool word_delay)
> +{
> +	void *copy_ptr;
> +	int unaligned;
> +
> +	/*
> +	 * On little-endian CPUs, adjust byte order:
> +	 * - Swap bytes when bpw = 8
> +	 * - Swap half-words when bpw = 16
> +	 * This ensures correct data ordering for DMA transfers.
> +	 */
> +#ifdef __LITTLE_ENDIAN
> +	if (!word_delay) {
> +		unsigned int bytes_per_word = spi_imx_bytes_per_word(spi_imx->bits_per_word);
> +		u32 *temp = dma_data->dma_rx_buf;
> +
> +		for (int i = 0; i < DIV_ROUND_UP(dma_data->dma_len, sizeof(*temp)); i++) {
> +			if (bytes_per_word == 1)
> +				swab32s(temp + i);
> +			else if (bytes_per_word == 2)
> +				swahw32s(temp + i);
> +		}
> +	}
> +#endif
> +
> +	/*
> +	 * When dynamic burst enabled, DMA RX always receives 32-bit words from RXFIFO with
> +	 * buswidth = 4, but when data_len is not 4-bytes alignment, the RM shows when
> +	 * burst length = 32*n + m bits, a SPI burst contains the m LSB in first word and all
> +	 * 32 bits in other n words. So if garbage bytes in the first word, trim first word then
> +	 * copy the actual data to rx_buf.
> +	 */
> +	if (dma_data->data_len % BYTES_PER_32BITS_WORD && !word_delay) {
> +		unaligned = dma_data->data_len % BYTES_PER_32BITS_WORD;
> +		copy_ptr = (u8 *)dma_data->dma_rx_buf + BYTES_PER_32BITS_WORD - unaligned;
> +	} else {
> +		copy_ptr = dma_data->dma_rx_buf;
> +	}
> +
> +	memcpy(rx_buf, copy_ptr, dma_data->data_len);
> +}
> +
> +static int spi_imx_dma_map(struct spi_imx_data *spi_imx,
> +			   struct dma_data_package *dma_data)
> +{
> +	struct spi_controller *controller = spi_imx->controller;
> +	struct device *tx_dev = controller->dma_tx->device->dev;
> +	struct device *rx_dev = controller->dma_rx->device->dev;
> +	int ret;
> +
> +	dma_data->dma_tx_addr = dma_map_single(tx_dev, dma_data->dma_tx_buf,
> +					       DMA_CACHE_ALIGNED_LEN(dma_data->dma_len),
> +					       DMA_TO_DEVICE);
> +	ret = dma_mapping_error(tx_dev, dma_data->dma_tx_addr);
> +	if (ret < 0) {
> +		dev_err(spi_imx->dev, "DMA TX map failed %d\n", ret);
> +		return ret;
> +	}
> +
> +	dma_data->dma_rx_addr = dma_map_single(rx_dev, dma_data->dma_rx_buf,
> +					       DMA_CACHE_ALIGNED_LEN(dma_data->dma_len),
> +					       DMA_FROM_DEVICE);
> +	ret = dma_mapping_error(rx_dev, dma_data->dma_rx_addr);
> +	if (ret < 0) {
> +		dev_err(spi_imx->dev, "DMA RX map failed %d\n", ret);
> +		dma_unmap_single(tx_dev, dma_data->dma_tx_addr,
> +				 DMA_CACHE_ALIGNED_LEN(dma_data->dma_len),
> +				 DMA_TO_DEVICE);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int spi_imx_dma_tx_data_handle(struct spi_imx_data *spi_imx,
> +				      struct dma_data_package *dma_data,
> +				      const void *tx_buf,
> +				      bool word_delay)
> +{
> +	void *copy_ptr;
> +	int unaligned;
> +
> +	if (word_delay) {
> +		dma_data->dma_len = dma_data->data_len;
> +	} else {
> +		/*
> +		 * As per the reference manual, when burst length = 32*n + m bits, ECSPI
> +		 * sends m LSB bits in the first word, followed by n full 32-bit words.
> +		 * Since actual data may not be 4-byte aligned, allocate DMA TX/RX buffers
> +		 * to ensure alignment. For TX, DMA pushes 4-byte aligned words to TXFIFO,
> +		 * while ECSPI uses BURST_LENGTH settings to maintain correct bit count.
> +		 * For RX, DMA always receives 32-bit words from RXFIFO, when data len is
> +		 * not 4-byte aligned, trim the first word to drop garbage bytes, then group
> +		 * all transfer DMA bounse buffer and copy all valid data to rx_buf.
> +		 */
> +		dma_data->dma_len = ALIGN(dma_data->data_len, BYTES_PER_32BITS_WORD);
> +	}
> +
> +	dma_data->dma_tx_buf = kzalloc(dma_data->dma_len, GFP_KERNEL);
> +	if (!dma_data->dma_tx_buf)
> +		return -ENOMEM;
> +
> +	dma_data->dma_rx_buf = kzalloc(dma_data->dma_len, GFP_KERNEL);
> +	if (!dma_data->dma_rx_buf) {
> +		kfree(dma_data->dma_tx_buf);
> +		return -ENOMEM;
> +	}
> +
> +	if (dma_data->data_len % BYTES_PER_32BITS_WORD && !word_delay) {
> +		unaligned = dma_data->data_len % BYTES_PER_32BITS_WORD;
> +		copy_ptr = (u8 *)dma_data->dma_tx_buf + BYTES_PER_32BITS_WORD - unaligned;
> +	} else {
> +		copy_ptr = dma_data->dma_tx_buf;
> +	}
> +
> +	memcpy(copy_ptr, tx_buf, dma_data->data_len);
> +
> +	/*
> +	 * When word_delay is enabled, DMA transfers an entire word in one minor loop.
> +	 * In this case, no data requires additional handling.
> +	 */
> +	if (word_delay)
> +		return 0;
> +
> +#ifdef __LITTLE_ENDIAN
> +	/*
> +	 * On little-endian CPUs, adjust byte order:
> +	 * - Swap bytes when bpw = 8
> +	 * - Swap half-words when bpw = 16
> +	 * This ensures correct data ordering for DMA transfers.
> +	 */
> +	unsigned int bytes_per_word = spi_imx_bytes_per_word(spi_imx->bits_per_word);
> +	u32 *temp = dma_data->dma_tx_buf;
> +
> +	for (int i = 0; i < DIV_ROUND_UP(dma_data->dma_len, sizeof(*temp)); i++) {
> +		if (bytes_per_word == 1)
> +			swab32s(temp + i);
> +		else if (bytes_per_word == 2)
> +			swahw32s(temp + i);
> +	}
> +#endif
> +
> +	return 0;
> +}
> +
> +static int spi_imx_dma_data_prepare(struct spi_imx_data *spi_imx,
> +				    struct spi_transfer *transfer,
> +				    bool word_delay)
> +{
> +	u32 pre_bl, tail_bl;
> +	u32 ctrl;
> +	int ret;
> +
> +	/*
> +	 * ECSPI supports a maximum burst of 512 bytes. When xfer->len exceeds 512
> +	 * and is not a multiple of 512, a tail transfer is required. BURST_LEGTH
> +	 * is used for SPI HW to maintain correct bit count. BURST_LENGTH should
> +	 * update with data length. After DMA request submit, SPI can not update the
> +	 * BURST_LENGTH, in this case, we must split two package, update the register
> +	 * then setup second DMA transfer.
> +	 */
> +	ctrl = readl(spi_imx->base + MX51_ECSPI_CTRL);
> +	if (word_delay) {
> +		/*
> +		 * When SPI IMX need to support word delay, according to "Sample Period Control
> +		 * Register" shows, The Sample Period Control Register (ECSPI_PERIODREG)
> +		 * provides software a way to insert delays (wait states) between consecutive
> +		 * SPI transfers. As a result, ECSPI can only transfer one word per frame, and
> +		 * the delay occurs between frames.
> +		 */
> +		spi_imx->dma_package_num = 1;
> +		pre_bl = spi_imx->bits_per_word - 1;
> +	} else if (transfer->len <= MX51_ECSPI_CTRL_MAX_BURST) {
> +		spi_imx->dma_package_num = 1;
> +		pre_bl = transfer->len * BITS_PER_BYTE - 1;
> +	} else if (!(transfer->len % MX51_ECSPI_CTRL_MAX_BURST)) {
> +		spi_imx->dma_package_num = 1;
> +		pre_bl = MX51_ECSPI_CTRL_MAX_BURST * BITS_PER_BYTE - 1;
> +	} else {
> +		spi_imx->dma_package_num = 2;
> +		pre_bl = MX51_ECSPI_CTRL_MAX_BURST * BITS_PER_BYTE - 1;
> +		tail_bl = (transfer->len % MX51_ECSPI_CTRL_MAX_BURST) * BITS_PER_BYTE - 1;
> +	}
> +
> +	spi_imx->dma_data = kmalloc_array(spi_imx->dma_package_num,
> +					  sizeof(struct dma_data_package),
> +					  GFP_KERNEL | __GFP_ZERO);
> +	if (!spi_imx->dma_data) {
> +		dev_err(spi_imx->dev, "Failed to allocate DMA package buffer!\n");
> +		return -ENOMEM;
> +	}
> +
> +	if (spi_imx->dma_package_num == 1) {
> +		ctrl &= ~MX51_ECSPI_CTRL_BL_MASK;
> +		ctrl |= pre_bl << MX51_ECSPI_CTRL_BL_OFFSET;
> +		spi_imx->dma_data[0].cmd_word = ctrl;
> +		spi_imx->dma_data[0].data_len = transfer->len;
> +		ret = spi_imx_dma_tx_data_handle(spi_imx, &spi_imx->dma_data[0], transfer->tx_buf,
> +						 word_delay);
> +		if (ret) {
> +			kfree(spi_imx->dma_data);
> +			return ret;
> +		}
> +	} else {
> +		ctrl &= ~MX51_ECSPI_CTRL_BL_MASK;
> +		ctrl |= pre_bl << MX51_ECSPI_CTRL_BL_OFFSET;
> +		spi_imx->dma_data[0].cmd_word = ctrl;
> +		spi_imx->dma_data[0].data_len = round_down(transfer->len,
> +							   MX51_ECSPI_CTRL_MAX_BURST);
> +		ret = spi_imx_dma_tx_data_handle(spi_imx, &spi_imx->dma_data[0], transfer->tx_buf,
> +						 false);
> +		if (ret) {
> +			kfree(spi_imx->dma_data);
> +			return ret;
> +		}
> +
> +		ctrl &= ~MX51_ECSPI_CTRL_BL_MASK;
> +		ctrl |= tail_bl << MX51_ECSPI_CTRL_BL_OFFSET;
> +		spi_imx->dma_data[1].cmd_word = ctrl;
> +		spi_imx->dma_data[1].data_len = transfer->len % MX51_ECSPI_CTRL_MAX_BURST;
> +		ret = spi_imx_dma_tx_data_handle(spi_imx, &spi_imx->dma_data[1],
> +						 transfer->tx_buf + spi_imx->dma_data[0].data_len,
> +						 false);
> +		if (ret) {
> +			kfree(spi_imx->dma_data[0].dma_tx_buf);
> +			kfree(spi_imx->dma_data[0].dma_rx_buf);
> +			kfree(spi_imx->dma_data);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
> +			      struct dma_data_package *dma_data,
>  			      struct spi_transfer *transfer)
>  {
> -	struct sg_table *tx = &transfer->tx_sg, *rx = &transfer->rx_sg;
>  	struct spi_controller *controller = spi_imx->controller;
>  	struct dma_async_tx_descriptor *desc_tx, *desc_rx;
>  	unsigned long transfer_timeout;
> @@ -1451,9 +1723,9 @@ static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
>  	 * The TX DMA setup starts the transfer, so make sure RX is configured
>  	 * before TX.
>  	 */
> -	desc_rx = dmaengine_prep_slave_sg(controller->dma_rx,
> -					  rx->sgl, rx->nents, DMA_DEV_TO_MEM,
> -					  DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> +	desc_rx = dmaengine_prep_slave_single(controller->dma_rx, dma_data->dma_rx_addr,
> +					      dma_data->dma_len, DMA_DEV_TO_MEM,
> +					      DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>  	if (!desc_rx) {
>  		transfer->error |= SPI_TRANS_FAIL_NO_START;
>  		return -EINVAL;
> @@ -1471,9 +1743,9 @@ static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
>  	reinit_completion(&spi_imx->dma_rx_completion);
>  	dma_async_issue_pending(controller->dma_rx);
>
> -	desc_tx = dmaengine_prep_slave_sg(controller->dma_tx,
> -					  tx->sgl, tx->nents, DMA_MEM_TO_DEV,
> -					  DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> +	desc_tx = dmaengine_prep_slave_single(controller->dma_tx, dma_data->dma_tx_addr,
> +					      dma_data->dma_len, DMA_MEM_TO_DEV,
> +					      DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>  	if (!desc_tx)
>  		goto dmaengine_terminate_rx;
>
> @@ -1521,16 +1793,16 @@ static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
>  }
>
>  static void spi_imx_dma_max_wml_find(struct spi_imx_data *spi_imx,
> -				     struct spi_transfer *transfer)
> +				     struct dma_data_package *dma_data,
> +				     bool word_delay)
>  {
> -	struct sg_table *rx = &transfer->rx_sg;
> -	struct scatterlist *last_sg = sg_last(rx->sgl, rx->nents);
> -	unsigned int bytes_per_word, i;
> +	unsigned int bytes_per_word = word_delay ?
> +				      spi_imx_bytes_per_word(spi_imx->bits_per_word) :
> +				      BYTES_PER_32BITS_WORD;
> +	unsigned int i;
>
> -	/* Get the right burst length from the last sg to ensure no tail data */
> -	bytes_per_word = spi_imx_bytes_per_word(transfer->bits_per_word);
>  	for (i = spi_imx->devtype_data->fifo_size / 2; i > 0; i--) {
> -		if (!(sg_dma_len(last_sg) % (i * bytes_per_word)))
> +		if (!dma_data->dma_len % (i * bytes_per_word))
>  			break;
>  	}
>  	/* Use 1 as wml in case no available burst length got */
> @@ -1540,25 +1812,29 @@ static void spi_imx_dma_max_wml_find(struct spi_imx_data *spi_imx,
>  	spi_imx->wml = i;
>  }
>
> -static int spi_imx_dma_configure(struct spi_controller *controller)
> +static int spi_imx_dma_configure(struct spi_controller *controller, bool word_delay)
>  {
>  	int ret;
>  	enum dma_slave_buswidth buswidth;
>  	struct dma_slave_config rx = {}, tx = {};
>  	struct spi_imx_data *spi_imx = spi_controller_get_devdata(controller);
>
> -	switch (spi_imx_bytes_per_word(spi_imx->bits_per_word)) {
> -	case 4:
> +	if (word_delay) {
> +		switch (spi_imx_bytes_per_word(spi_imx->bits_per_word)) {
> +		case 4:
> +			buswidth = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +			break;
> +		case 2:
> +			buswidth = DMA_SLAVE_BUSWIDTH_2_BYTES;
> +			break;
> +		case 1:
> +			buswidth = DMA_SLAVE_BUSWIDTH_1_BYTE;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +	} else {
>  		buswidth = DMA_SLAVE_BUSWIDTH_4_BYTES;
> -		break;
> -	case 2:
> -		buswidth = DMA_SLAVE_BUSWIDTH_2_BYTES;
> -		break;
> -	case 1:
> -		buswidth = DMA_SLAVE_BUSWIDTH_1_BYTE;
> -		break;
> -	default:
> -		return -EINVAL;
>  	}
>
>  	tx.direction = DMA_MEM_TO_DEV;
> @@ -1584,15 +1860,17 @@ static int spi_imx_dma_configure(struct spi_controller *controller)
>  	return 0;
>  }
>
> -static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
> -				struct spi_transfer *transfer)
> +static int spi_imx_dma_package_transfer(struct spi_imx_data *spi_imx,
> +					struct dma_data_package *dma_data,
> +					struct spi_transfer *transfer,
> +					bool word_delay)
>  {
>  	struct spi_controller *controller = spi_imx->controller;
>  	int ret;
>
> -	spi_imx_dma_max_wml_find(spi_imx, transfer);
> +	spi_imx_dma_max_wml_find(spi_imx, dma_data, word_delay);
>
> -	ret = spi_imx_dma_configure(controller);
> +	ret = spi_imx_dma_configure(controller, word_delay);
>  	if (ret)
>  		goto dma_failure_no_start;
>
> @@ -1603,10 +1881,17 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
>  	}
>  	spi_imx->devtype_data->setup_wml(spi_imx);
>
> -	ret = spi_imx_dma_submit(spi_imx, transfer);
> +	ret = spi_imx_dma_submit(spi_imx, dma_data, transfer);
>  	if (ret)
>  		return ret;
>
> +	/* Trim the DMA RX buffer and copy the actual data to rx_buf */
> +	dma_sync_single_for_cpu(controller->dma_rx->device->dev, dma_data->dma_rx_addr,
> +				dma_data->dma_len, DMA_FROM_DEVICE);
> +	spi_imx_dma_rx_data_handle(spi_imx, dma_data, transfer->rx_buf + spi_imx->rx_offset,
> +				   word_delay);
> +	spi_imx->rx_offset += dma_data->data_len;
> +
>  	return 0;
>  /* fallback to pio */
>  dma_failure_no_start:
> @@ -1614,6 +1899,57 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
>  	return ret;
>  }
>
> +static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
> +				struct spi_transfer *transfer)
> +{
> +	bool word_delay = transfer->word_delay.value != 0;
> +	int ret;
> +	int i;
> +
> +	ret = spi_imx_dma_data_prepare(spi_imx, transfer, word_delay);
> +	if (ret < 0) {
> +		transfer->error |= SPI_TRANS_FAIL_NO_START;
> +		dev_err(spi_imx->dev, "DMA data prepare fail\n");
> +		goto fallback_pio;
> +	}
> +
> +	spi_imx->rx_offset = 0;
> +
> +	/* Each dma_package performs a separate DMA transfer once */
> +	for (i = 0; i < spi_imx->dma_package_num; i++) {
> +		ret = spi_imx_dma_map(spi_imx, &spi_imx->dma_data[i]);
> +		if (ret < 0) {
> +			if (i == 0)
> +				transfer->error |= SPI_TRANS_FAIL_NO_START;
> +			dev_err(spi_imx->dev, "DMA map fail\n");
> +			break;
> +		}
> +
> +		/* Update the CTRL register BL field */
> +		writel(spi_imx->dma_data[i].cmd_word, spi_imx->base + MX51_ECSPI_CTRL);
> +
> +		ret = spi_imx_dma_package_transfer(spi_imx, &spi_imx->dma_data[i],
> +						   transfer, word_delay);
> +
> +		/* Whether the dma transmission is successful or not, dma unmap is necessary */
> +		spi_imx_dma_unmap(spi_imx, &spi_imx->dma_data[i]);
> +
> +		if (ret < 0) {
> +			dev_dbg(spi_imx->dev, "DMA %d transfer not really finish\n", i);
> +			break;
> +		}
> +	}
> +
> +	for (int j = 0; j < spi_imx->dma_package_num; j++) {
> +		kfree(spi_imx->dma_data[j].dma_tx_buf);
> +		kfree(spi_imx->dma_data[j].dma_rx_buf);
> +	}
> +	kfree(spi_imx->dma_data);
> +
> +fallback_pio:
> +	return ret;
> +}
> +
>  static int spi_imx_pio_transfer(struct spi_device *spi,
>  				struct spi_transfer *transfer)
>  {
> @@ -1780,9 +2116,14 @@ static int spi_imx_transfer_one(struct spi_controller *controller,
>  	 * transfer, the SPI transfer has already been mapped, so we
>  	 * have to do the DMA transfer here.
>  	 */
> -	if (spi_imx->usedma)
> -		return spi_imx_dma_transfer(spi_imx, transfer);
> -
> +	if (spi_imx->usedma) {
> +		ret = spi_imx_dma_transfer(spi_imx, transfer);
> +		if (transfer->error & SPI_TRANS_FAIL_NO_START) {
> +			spi_imx->usedma = false;
> +			return spi_imx_pio_transfer(spi, transfer);
> +		}
> +		return ret;
> +	}
>  	/* run in polling mode for short transfers */
>  	if (transfer->len == 1 || (polling_limit_us &&
>  				   spi_imx_transfer_estimate_time_us(transfer) < polling_limit_us))
> --
> 2.34.1
>

