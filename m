Return-Path: <linux-spi+bounces-11822-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A14CAD04B
	for <lists+linux-spi@lfdr.de>; Mon, 08 Dec 2025 12:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7930830443D4
	for <lists+linux-spi@lfdr.de>; Mon,  8 Dec 2025 11:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA00522D4D3;
	Mon,  8 Dec 2025 11:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RdBI//4N"
X-Original-To: linux-spi@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013070.outbound.protection.outlook.com [52.101.83.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80C022FAFD;
	Mon,  8 Dec 2025 11:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765194338; cv=fail; b=XVc73ojPA2xogtFZqrSXpEBUiw+DKLwxgTUBg4EXcwW0lyGr/DO4tEbabalz5KB4A2g+/4QZETMeXAuTBMiPr+qB/RvJPhd3gdhz0/IADFIvzqb4EJo97PhhyBWwrdzVtru298cTc+3RCEA9n8puu95j7uUCSP17QOkEzrSyEkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765194338; c=relaxed/simple;
	bh=AvB6YNRM0ty/549Gan+MkkBNR4Llfy73HCosalZQIuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zxset6P0UqQXj6r+ijIkgUV1jIUNcQiYfANitWHg6DRXwuZK4lqq2MyytwXlburIfkdJP1fIgdnE8ua/g7StdzK9AUJYW8y0qJJzkLR4Y2yv/v3UBiBZYpBy6IKK+lqe4JY5FUsTUx8BOZUFQZAPEektwEyajIfyV9q+8cWf7h0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=RdBI//4N; arc=fail smtp.client-ip=52.101.83.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOElehuS4tyUIXKFKS/QkDuH3JjKcGeC+gahdzpe9UI1Y+bUbxHlTrHLwmLlWFf12+kEhjxRuHm7NPCnfjPqRtFyIjOlFZeXUG8a43UbGuLDGB5xe7QRqZ1O5+TZdDH1CWBIMK/ZpYDR497KCOYve9XgG+RvrgFmw+ahi6u06upOdsnus0Yuq+vEHIMZQqvO3xGksd1r8B/s5eQsvchM3+Zm9S8dP1YsISR2S6EC3mQ39uDE9vf67UIs3cj46Y2sLnDKwEH71LqpB8YXYMQqr8Cakco/ExyJ0DR+S3ThZy48t5nZOWdcwQdU4wo4jcCxeZKguqq90Txzgs45RucTzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvB6YNRM0ty/549Gan+MkkBNR4Llfy73HCosalZQIuw=;
 b=I6J+wGoJyDV/+WomaJNKWVXmkPUct/NXPMEs1+5q9c9C41mG5CHgwnkYBH3a7M+tTgUYxsNt95Bqp3xuHFU1sVaVvFRtgxIiH4N+OKzYhPbwmW8KIU08TBxr+XW/2Qa6OFcGHWzxuZVIja2KG/ERKHS7IQAX6T5107ll6U95P6OJqGWXQBjTLSqZ6iinfrlgo7bgZfXU6tdPy8WJom3HAXD4l1m6lUWb85RNeXtulRZZyUqqBH4ZfkzuekL8lzsiJth22cp2IlpvgCLdFS/pC/cMCDtwWhGRmFOHw707CWs4UPdaFDy6B5/xBd3wuNUozrVSJ90X3rl3ajCOW9aFzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvB6YNRM0ty/549Gan+MkkBNR4Llfy73HCosalZQIuw=;
 b=RdBI//4NaLvn+qDTP49B/pIyDzQYRNk5lQnK6RfxYqB1S20VKYTY5hkU8q27CldWXm18iO6ZcILdvx4vB9nddfsCUmEUdge8c4EqLHkSYxRrAYcumm9COquUhpTPGNiosEqv/nF4PH9Cxp2trqjKYopBS6HfjjnCEFSshd17IYi0xbg0eeuvm3G40s+csvtPYIPfeXTVqqblgtWFgfoESM2uCJz2uMYrc8lH/7ZQFw+bAb1KGVe1+l+LE375acPC5ElislgfhOOdntDqUDkbXN2IERZdeP+HvFMU8FfeNC8qofLhFIqgMkxMLcuwKFJ1NOiXAHRjXpuCN0Xd4YN/Kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB9514.eurprd04.prod.outlook.com (2603:10a6:150:20::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 11:45:29 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9388.003; Mon, 8 Dec 2025
 11:45:29 +0000
Date: Mon, 8 Dec 2025 19:46:34 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Haixu Cui <quic_haixcui@quicinc.com>, Mark Brown <broonie@kernel.org>
Cc: virtualization@lists.linux.dev, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RFC] spi: virtio: Add [new,delete]_device sysfs interface
Message-ID: <aTa6moPSbWk7+S6u@shlinux89>
References: <20251205-v-spi-v1-1-89713cc6c0b4@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205-v-spi-v1-1-89713cc6c0b4@nxp.com>
X-ClientProxiedBy: SG2PR02CA0061.apcprd02.prod.outlook.com
 (2603:1096:4:54::25) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB9514:EE_
X-MS-Office365-Filtering-Correlation-Id: b9ee7b12-b840-4b4b-9038-08de364f4931
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pn5mkend22ZNKZtJtfWYENRpD0hT0y/F83Mdv9XiOKxMyGtNyayPaRPEK7ne?=
 =?us-ascii?Q?QE4wBUN9eqfwyfX+Lr1h1qgp0nQMzPbH5TsTv6Io5rIF/KrnyqFaZEOjYotp?=
 =?us-ascii?Q?8ZcHRXDOn/5IgkBe63zBgUh2/tcTAveMFLRks43CXNC4U9OhP47QiKZzHrAv?=
 =?us-ascii?Q?2pnU11VQ60bbYM0RMrAWQKC9IzKvfBBPbI86zr39XoS9OwkGVKdeX4jm6+6H?=
 =?us-ascii?Q?crV7spZGPXAtDmQgJpO2rIMxCSCvcvSnrCofxBeDbhiTH9AfyZ7lw/ycGHiR?=
 =?us-ascii?Q?+9coIbreQpX5QAaRJEO5G0WLkarpA3E5ehrsSTP5rtDCF+3RBAl793zNjgXF?=
 =?us-ascii?Q?6KkjQ8S5xHXLhRxPZulsRTKfrPSgWtOJd1VLOxMYOc5L2F2k19ha0M/4i6O7?=
 =?us-ascii?Q?jXkVkkIzMCxMZFGbJdSWRH9Kg5fBYDNUpENqxW/Bf3TOTDqHtDJIq1jPqIwR?=
 =?us-ascii?Q?WXcLcQoSyWj11Iylt1SfC/Cl1jdTl1QtBPhC1aM8kQItkJ+v7fsGacb9hOyq?=
 =?us-ascii?Q?Y3bVv2+n78bCGt7b6l0Eb9prWzJYU83bXXbA8w1ASRohE+Yu1s2fE6ERRHDn?=
 =?us-ascii?Q?ilTrkDyu5BxdnkAklSaHg2QFfib7d6F/6HMaiBvo5WSN4vTnx/a13dkW8xaO?=
 =?us-ascii?Q?x62eA18D3c9u/FMQZA/FeEZLSU5rNykdh/Lx8rD/+uN1KV6Adh+txNO3ZJIJ?=
 =?us-ascii?Q?Ja4w9v0Zot43iFLkwRTyWg6m1HAUWTN/0lj8Nh1NGpyV2B2i84fQeX5bQ6we?=
 =?us-ascii?Q?kOcGsavlC8pFX/r+uY+AFXf/jsOQqt0KK0mefYmSP5pymFYC844czm94cPga?=
 =?us-ascii?Q?cdwU9JdtfP/633BFl7SvustKSxRjuwN+aQ+nMTVhzG7lVSxngIOIAe7IhLPl?=
 =?us-ascii?Q?wbwo/4+NX50EevFcvsEYwa24+fAjNtvQumMFpoYP96RR+ccIbZJY976htKnl?=
 =?us-ascii?Q?AT+r5JdlNA2fzU68B6GNcw5176bcIPAI2qMeZtGhFGh1RbZjZGLytmI5+EiD?=
 =?us-ascii?Q?a9CqtmjNo7H6X4ZFzkbt7UmoZvz6vOp0g411z2IRXvS9EJVZSNcKAFf7IJ+J?=
 =?us-ascii?Q?wFJrzWptuEW1KWm4we7/Pusj6pbgDoNzIz0m/G2YYuSy+dtLDvcVyshFrixi?=
 =?us-ascii?Q?u5BP3qUhXnIWLYXt2WC4behRTxxJGHdlBkehFBzN7OTZ1QZ0exzB2031g1ns?=
 =?us-ascii?Q?h7H0gStsDKTa2eU7+fELZQIOKqOyQgXf4zQAKnmIzPR4/XOEQaelUkYiZ9y4?=
 =?us-ascii?Q?MyGeCRK6gmJacvDxg0E/+7EBw4aSnhGrbAVWD4Zkyt82EiYHMLWm/dIYz9K9?=
 =?us-ascii?Q?nyuSKEG9rPr4RKrZoQFtKGzmbEC2QwMdsoIspujvFyXqJsEtjZiH9y9E8WRp?=
 =?us-ascii?Q?VKpP1gr677m0/eZzn/2+v0sHcZy0t+B8UQgRbq54/ErN1viN1alwuoqQplCP?=
 =?us-ascii?Q?EIP9oh4zQzfI1WfCAv41cpUG4FLUG3JBR6J7XLkgqarpJWGQ0dn0eBySYhfD?=
 =?us-ascii?Q?kR726qZwi53jAPm/3izWHYgvKyVaB5bhyhQN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mptk2VdwmlwrrN2nZk0LUJh14w53nWU37O/kAw6PvXnfqRu2sw7s2Z3VO4/G?=
 =?us-ascii?Q?kn2/MCF8brrTy0mnXfgrUUswzlBLcI7dhpVQbixvZRuNM59a8QpeWHZh00tJ?=
 =?us-ascii?Q?1Bz6C1XCj3JxpKbOcfE52eWWOenFluiiu44sz8Ech2bFcxSE+ljbN78Okg1Z?=
 =?us-ascii?Q?oG3qnUnQzdlDby4p9UtDVzNJ5+vZli4yA56aPozjNLXWjJEsW6U4o/DCsXhx?=
 =?us-ascii?Q?OT2jvIEFzt+uvsNyclKZPwkfeX5DFIxACc668EPFgHXWTzY1s+m4piEJRbjL?=
 =?us-ascii?Q?8mbjd38+DPQTBkgLypFH0TBDkUwAJur14xckc1SdCbbzqvgtkCFDihQd6rty?=
 =?us-ascii?Q?w/GDd/PKSI6UyxqV0TzCdD1CVPrKyPhjka5lzi3u+xNYykcFTvO+96hwOIXX?=
 =?us-ascii?Q?N02l1jW06j06CPP+nMGZ27jz4ZuKBkldgenNqwKhOBH4G8kTSuEeTvKsrDsw?=
 =?us-ascii?Q?hCFF9Cfmc/jSXgnwkGkzVLtmMj0dYUWAg6NR48an/XklvWnjv5Vy6vQEqmaj?=
 =?us-ascii?Q?TDrR5MjsUvmXUX1aZJw33FM84GQE2Ka1M4GLssxOmallg18QqhoCAN1wZfEb?=
 =?us-ascii?Q?9P6wbXFbel74Gk4DJdiGLJUn47ASQ2h0kZI5npDi/cGvbRhBi6vZT6XifhPe?=
 =?us-ascii?Q?s8uIaUbvpONsKhm3bFQ/Y8CNAA/imboyeK6LQnSNakHjeQGBsZxaruSxyPnQ?=
 =?us-ascii?Q?puv19uXeyaLwFv12XdDB+FnVAUjz7IoQ6ltIstkHG+cIefyPklFnkRluHRIc?=
 =?us-ascii?Q?S04N+ETTd+OlJVI7emtRlSzMePvZJdvC7OH/bcxDT8Ju+QP7Rv+jT46ekGM0?=
 =?us-ascii?Q?EfRtrhX4xAjiKcS6nBt1uMmZnn1xR7nrBPYR9iFhzXCwm+tRgelmbuRUdRTp?=
 =?us-ascii?Q?p2K03uWktS7dbqYDjOhseA0qHzmdj3jXkaNYvwc3axRImwZlU81dea7ha9Ql?=
 =?us-ascii?Q?D3F+/zBPvPBMbd+wEuNxv//ilOuyct5vHfw1N9Z0s2IyuaRPuKz4MjlrTTu9?=
 =?us-ascii?Q?6YBylklXio6B+FZvoSmknO/7id/fbD31tFHt177JntHoyuJRJdmJ7vCHWKSl?=
 =?us-ascii?Q?79SLKzMV8QZdscuh695x4SqK1S2rCpFfstER4O1AuPXyxLoIcUskj3xX9DTq?=
 =?us-ascii?Q?YXFKiFSlMZsUTBEp/zpAY1EnNE0/VTqos+YXAGwpYfyUdoSORY5KKRz5NbIV?=
 =?us-ascii?Q?FJonY4LM9OnMS8L91fB9GkWWipnRG99KbS9mjqBGixRddYAuRQg440VxyQdH?=
 =?us-ascii?Q?5ixNHtsuCNDbDKyOMlA8RVImQOTou4Y31X6sowU2KsgtMyTK9PgD2emhlYFl?=
 =?us-ascii?Q?FByZ1dJRAK+F9tOT0xuGiBkHa4TFodIQEwUvFnUFGJCtHeKlCZ76YCuL/xhn?=
 =?us-ascii?Q?UYLewisIM+5JWljSvGihBSktAtF27Sxai+faqJSjKtJZPbMt1RAmqZAsZDN0?=
 =?us-ascii?Q?zh4l2F7nSd5RRhHEyNF4pyKGlfMRqKK7mCl8mwaqwqZaq+0eh5V5Rw/DdIjK?=
 =?us-ascii?Q?suPPEwgDTayxW4drwbBrryMiJGlKGVYIZ7GEhWusUukfRfuHw+xLPNID3Qs7?=
 =?us-ascii?Q?sWRlCprOpuTWIjeJBUQVAcCT8AUJIwEBcVYPNAgk?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ee7b12-b840-4b4b-9038-08de364f4931
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 11:45:29.2625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7PTus7zh6YuhAIv77+n7o9XWn6lZ8N1BYqjR//u9rMnG0d5LATck7+F5uLFeclQK4M3OK1WLcsGUKFAplmQQzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9514

On Fri, Dec 05, 2025 at 09:40:26PM +0800, Peng Fan (OSS) wrote:
>From: Peng Fan <peng.fan@nxp.com>
>
>spi-virtio registers a SPI controller, but we still need to register a
>SPI device to initiate the SPI virtio transfer.
>
>To Xen hypervisor, there might be no 'passthrough' node for DomU,
>so add a sysfs interface to allow creating/deleting a SPI device.
>
>Usage:
> echo "spidev" > /sys/class/spi_master/spi0/new_device
> echo "spi0.0" > /sys/class/spi_master/spi0/delete_device
>

After rethinking about this, I think it might be better to add the sysfs
to all SPI controller just as what i2c core supports:
drivers/i2c/i2c-core-base.c: 1264

I will post out v2 to move the code to spi_controller_groups if no objections.

Thanks,
Peng

