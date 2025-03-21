Return-Path: <linux-spi+bounces-7277-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB914A6BE4E
	for <lists+linux-spi@lfdr.de>; Fri, 21 Mar 2025 16:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAB554628C8
	for <lists+linux-spi@lfdr.de>; Fri, 21 Mar 2025 15:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF531CEACB;
	Fri, 21 Mar 2025 15:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="e0zpyrUG"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2049.outbound.protection.outlook.com [40.107.22.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9A229405
	for <linux-spi@vger.kernel.org>; Fri, 21 Mar 2025 15:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742570791; cv=fail; b=DEEkleUqTgBG8f7FETl8HIeoa3UDyzT3FHREZfooQOpA8CZp+p4gXJC2byBglAUaf6UijbuDYzfEeR9VguSpxOjzTcdgLS8is68wa4bFywZq39IKMzRQXJh1F5lGJoVNQ9EXUpU4hUM5X67rHkW2vmUOcnsq/83Q/QWsqMFqk24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742570791; c=relaxed/simple;
	bh=XSamueV+NE2/IwtfTqNadhp0ZWOybF7B3mIz8eO8/Jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=INN3BW+XVXLKjUxJKvL+6qmX9P70Dk0GgkXE0sOnb7++rU0LiAcfHTrZ7NjQmtI+Tfc1Eg98itfXBzCMQ+oalXVQ/iAdssXIR+KfV1IaQk8JsJWDfBrDJg/qQXLEVbg3EClpxCR1eMFY9/HqLMoLbKkWpPIRJhIk5frnF8MBvmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=e0zpyrUG; arc=fail smtp.client-ip=40.107.22.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UxZTZUehaJMNqgem6Enxtu/r/1xntBbwl1NwPHgNToW+t6Fim6nQnB8kXGAEHt5fHQAnkgm5Bhp5oGXX5Cj60EeQdLJecKcBcorAlDobMHrwsh139uGUASoi5mhEsCNZdHbRcnYDZcPVViHZmy846pIEvNwAzt0rzmZesv0k7EFnmq3hIqzxyNx2TyBUKuilgWQAcWgP8hKde7z8GDJBumDsvlICe/7YI8ZRIgqsgW885Tt4+yQRSFnFvP7O9vsWkm+oMO7buDn3yEqVca4AtJwlw+HUOVH+TfrGG78trLHPN/pVSD/winhS1iK6MlMe26tOfoeLZeqCF6zUNiw1qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZXgX/HFsxR8fBpk1Ki0YapH5vhhq8WtiT8WdIt8UNs=;
 b=c3ckw9ge20oJr4FOS5UyGEdDtW0q9VZdsiiHhDi+jhDbHbhStmAuvKiKUFtAtG0UaUfNzFaOCwu45f9iMjrjIigTIaXcb5IhDmhyk+tn8Q3+rJT6RLnaHxfBCmdP/i6KzBmZYyhhTe3nTg3m3Neuc7rdvOIJYZiffMDGVGbI9qp1v9+vvdk4PAuw0t/TMhTkfLQ25Hv/iYIoBQstiY+MEKwO654Kt1jvvz+BUnxD8FjeT1dPlyHMYtx1bFg0lboBlhvoMFk8R03f0K7gHhKavSkvcGF3gSjh8dQcVyzDvC8yasFj1lb4UPNEbhh3B8SDXklVYKz8RuJiDxHmdLzhJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZXgX/HFsxR8fBpk1Ki0YapH5vhhq8WtiT8WdIt8UNs=;
 b=e0zpyrUGU8SXIZJegEYgBC1N80wOKswxRRW3sAkQ8heAyKQ+HmYhpQvcGlyrXN4cxru6wE9ITkvmMRewjKFrj19EWhEqyO7/bewfQsqaJ18IuAJa7wjN2ONLWIG+21xVTgbL2bEzFevQg/jvuE7UvXTG7amGILrdxJJYQWjD6pH6NPz5OgCrcKHp8DOitXoEHLt7hl3obZr8teAiucJ1SKZ8CN0yIFmmVhlCsK6yCYhghO7USla1pA+LCTdZPMj6Gm+b9EIDg7rKxNCg9XFsi87hMN78/xXBuyp8NYFs3qwCl3/qo2NzOKnVv5MzhbLtjOtNw3j/tgxKdJ/glqLYxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11)
 by GV1PR04MB10607.eurprd04.prod.outlook.com (2603:10a6:150:203::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 15:26:27 +0000
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::b7f2:1d0:6b6a:ba58]) by GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::b7f2:1d0:6b6a:ba58%4]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 15:26:26 +0000
Date: Fri, 21 Mar 2025 10:26:21 -0500
From: Han Xu <han.xu@nxp.com>
To: Kevin Hao <haokexin@gmail.com>
Cc: linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Volker Haspel <volker.haspel@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>, imx@lists.linux.dev
Subject: Re: [PATCH 1/2] spi: fsl-qsi: Optimize fsl_qspi struct
Message-ID: <20250321152621.uwus6ldvfyztcikn@cozumel>
References: <20250321-spi-v1-0-b9939baa64b6@gmail.com>
 <20250321-spi-v1-1-b9939baa64b6@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321-spi-v1-1-b9939baa64b6@gmail.com>
X-ClientProxiedBy: PH7PR17CA0037.namprd17.prod.outlook.com
 (2603:10b6:510:323::28) To GV1PR04MB9071.eurprd04.prod.outlook.com
 (2603:10a6:150:22::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9071:EE_|GV1PR04MB10607:EE_
X-MS-Office365-Filtering-Correlation-Id: 71b978ff-acd3-41e0-16bb-08dd688cbe88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?403ynm7cZmVew/EIVmk+GE9O4Crp9Wq2G5my2DHWgoJAH3Hs3xgePbmuEPSx?=
 =?us-ascii?Q?+KrMGgqtXDVLBYyobMVv4umozioLo2S+q0DZanA3fH8egkdZU8LMSWvQvGdo?=
 =?us-ascii?Q?8AV0A+4b59FcbCTR/bY8fV+sYxecvvMB09GJ8AcWISSNKuy7ainJ2idP+QuT?=
 =?us-ascii?Q?OMItwecM62HXuMccPHl+YIx4ZaFVmJh1IylnLBy4BKD2YJd/cLMOh827SYyx?=
 =?us-ascii?Q?SY1qE3/jbfnrYvUVIeEEw/hTufWqqkMljLkA/i0NKz58zHjU8PneH1fd9lwN?=
 =?us-ascii?Q?OstNEjQEfqzyc3zZolxOkUDjl6tM1TLDzOsnMXw0n1pe0g3gkttmq7Fgx18t?=
 =?us-ascii?Q?tYsQPbWvyNBOMVfNlUmQHz9dSNQIScWZ8bZ1C05WleTlupGAlp/Su+Lydj2F?=
 =?us-ascii?Q?7bb93mmxodszIIqocogadE1TSEV52UgR1jaw658fYK6xzo1Cce4jhNa5bDM4?=
 =?us-ascii?Q?sc9dKgWTnkrQ3v4fnakeh2ObVF7BYLX055Fvn7pK2FqpFkLbPAupBt7A096S?=
 =?us-ascii?Q?7LBGPYyr6HcrRFqVg9fqV8VvQx4Peqi2nsomcgKkrZx0cas7hj5wwkd89ceI?=
 =?us-ascii?Q?sd2dsoFpXjyiqbIzqapHWqQECZIiWOiknZDjvDObKO7xRn0WnDvPgfAkvzs9?=
 =?us-ascii?Q?3oA1fbQOUkt+SaU399UgyC/uYoRANplAgBdQAIxKR/bhO0gkDMf/q19AwqRP?=
 =?us-ascii?Q?YMkYC1/YyJtLB8iH2+yC0WuvdnE2XyfYyI2BG8jw1KEN3vFS6x5xTELskL2z?=
 =?us-ascii?Q?4IBPu3tUux+nILmOtp0bpdxG3nfQW7gDip1a7QMnIoCwGxEzMiqGcfwP7Hph?=
 =?us-ascii?Q?8+jd0a1G1UiWNg6TtcIH4suSiNn0ohr+lfaQIaYXlq0JY2lBmOUfS6qGXRMH?=
 =?us-ascii?Q?ze36UZnwI/oq/Z/ZMvEAIE42nq8+8WVEJGXt+DzAhpuKYsVpSk3Frq3R6bVa?=
 =?us-ascii?Q?khizUVZcWmRLlbJN/rFz3N4CrUnXr7uK8rrotOeE7viiGxziEZgl0hmpI6Sz?=
 =?us-ascii?Q?a8Hdv0ECU3WP/Q2s43zhlt2yVchP8kN78hm3qjY8GG/Rapia5qs+//JKKvM+?=
 =?us-ascii?Q?YLB25F7dOB8pW7WVMKHctFO/hSHg0rKCfwIMMS/G+5QjlUBfW+w3BMByQJiU?=
 =?us-ascii?Q?YvgGQVTrnFzr+Sf7H5AdBXRkd6h0mV57P8APmqsUXv4u7G44xJaUxZzVSSrW?=
 =?us-ascii?Q?+wRNkanEZgF+OUgfra19exprqnji8N959NgJG/KdoKrOvDxeGSgCZITyTway?=
 =?us-ascii?Q?Cu+4KYhYlsLVw7OSk1xdUBxWzyJ1IHnxMQC8RiF3EHFqeRuCw3uNkiyzyj07?=
 =?us-ascii?Q?+Ku6QB6WFTIB2pLmEZkQ/xql7nPSI2+rkd3EAfBT5e4tXrEbEb8nkeJhno/8?=
 =?us-ascii?Q?dKIMxSnxZPbX/7eAcrnfwlYCXxGdVjUvKbb+3jokb3EqVpBKeQH3RpXfGTEL?=
 =?us-ascii?Q?s2E1vsWMZPQs8oKyD2xgzkuLRwJROtHe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jR0NC2gZCnG/Hgx1SXHO15tj8sDKCUiRaa8y7++CTwhqvI1imzsEycRMZK0D?=
 =?us-ascii?Q?E5+SoCpeFa+QdGvgMwGCmUKRWkd4NwZL7hZ77h2lyQ+7o12hw+UrK18zLQW9?=
 =?us-ascii?Q?KVNahMIC5Sqr6mc3xQ9dUsaF4ovzihK7XdqhzldVVDyrzIlcnlSua6gJKL7P?=
 =?us-ascii?Q?lmMm2SNG9oPuGFg/74+jpAyh/bNjKiBpY4DU2XEVsRGN+X9rm1//OrUQNMuT?=
 =?us-ascii?Q?GwhXRE8wcByTNBjOOTm1Xr4rUU5xV9fyaVdCur03law6nRDZYJ4/7l1v1JVM?=
 =?us-ascii?Q?0RI19CBGJRczDt2tUwqt0g9BFBFB9Ur5A46NO+HM+SD9R3oEIwk2dHQCbNZq?=
 =?us-ascii?Q?ygjPHmQcB0qWsx+TCDDNhAjUtfBkaq7dCLk+FljcTzACxLXL8kjyTWw8/QUP?=
 =?us-ascii?Q?W1x70ATs+bmkbJV17hLhYjWRUB0qlyry5Met1bJb9fy8SYgvkisqzY6Qkymx?=
 =?us-ascii?Q?7UQg3n3PBxoAJPS+Djdc0xJtY/ggM2+My1lIIAmTPP+H5rGMCEWo0MJb4QB1?=
 =?us-ascii?Q?1JOjyronH+0tI80aVCdL5oIxbT13YGZ/iT0EpZlXfi2ssuGbFRKNBjAu/t9h?=
 =?us-ascii?Q?ZnUMPxPdaBbvfdp6Pt7FpV7KAA/p2lghDB2RsK5VdTLj/+KuQu3WBGS0ctOh?=
 =?us-ascii?Q?DNDm7Cawf4PEO2wm0aSeT61sI4Vh7CnXl/Arbolgit9apP4sjiz4OoKCrilU?=
 =?us-ascii?Q?ul61l9kIvUFk7AHFmmBFNFYgAPncaHIqDgLaAlj4CFFhMn7WE6UckXf98w8r?=
 =?us-ascii?Q?hpdmItR61CqkW6s05+PxpWHaalC078KL8+1WhfZV+eRN+DfHOZV6pP0Iy4Pp?=
 =?us-ascii?Q?UIgc+dvMREP9NfRMFIUZxQaL5zG9+x8+z//Lez42Lojs660afXrzBkok3Il7?=
 =?us-ascii?Q?BV5uoeqkogwAT3O/X/Rg4/CAXKht10ERy6iCUrJo2c9856knGufUKDUP3YhW?=
 =?us-ascii?Q?fwpuFF3B9DYCaIlGIZjmznQdaxEt8wzv+qpl0wruR/TkoMQx/mArmPqUWUki?=
 =?us-ascii?Q?o8bt/HjG6d1BWlvUkl7ULLNVHB879TIiZNa/FBGyi7OCAaPw2VXxFkF6hFL/?=
 =?us-ascii?Q?qR6PPAPCucU7ooc2U1/h83hHF7y9x09eLFjUZI6Em6t2YYhETWWpnrq0RlAg?=
 =?us-ascii?Q?GJi5gp/3FKBqft8JvSepAYB/hz6M02rl0eZDnLQQL6+skBN/TjGSHjSzlhw4?=
 =?us-ascii?Q?FMvZ0DpqvdQFekVig3KuVg5fjxMF6BcbTgqEV52/WSpu+5VaxwE9rJRllxPa?=
 =?us-ascii?Q?uXPiOOw8v7NwMerLSBRsrSbvA8kL2qDsfNCMlDoFq21vQgcCVl1CeafySbl0?=
 =?us-ascii?Q?CB6GIO/YqtHpNUXs2WTp6mOb4HPNe5uUkFKe0CiQvAQi659JbtGUxIOyNyXu?=
 =?us-ascii?Q?R5/alOC8o1wB1Z4hSFJa5n/kYSTleu0M6qitSiMOJ5VCbihkxJh96KIuLtxJ?=
 =?us-ascii?Q?7AOBlHNVAC8kjPTaEQYQCESniI3ivLM+gNSHVWbNHRlrdofVUmD3IfPQq/Vb?=
 =?us-ascii?Q?94nbPrMoOvfpOzClFlzaUn5C6QcJYLF9vKEM/OIfLMg7un6dLZM14n76U0ky?=
 =?us-ascii?Q?bxaEEjR2UAsRrF1In/Q=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b978ff-acd3-41e0-16bb-08dd688cbe88
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 15:26:26.6614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jYW6r4WcHp14zt5UbUUh03WDu3eQdXGwgMApZT/cQJLlco3dSzNbhvbZdpDQAOKo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10607

On 25/03/21 08:40PM, Kevin Hao wrote:
> 
> Reorgize the members of the fsl_qspi struct to:
>   - Reduce a hole in the struct.
>   - Group members required by each op (e.g., iobase, ahb_addr,
>     devtype_data and lock) into the same cacheline.
> 
> Before:
> struct fsl_qspi {
>         [...]
> 
>         /* size: 176, cachelines: 3, members: 11 */
>         /* sum members: 168, holes: 1, sum holes: 4 */
>         /* padding: 4 */
>         /* member types with holes: 1, total: 1 */
>         /* last cacheline: 48 bytes */
> };
> 
> after:
> struct fsl_qspi {
>         void *                     iobase;               /*     0     8 */
>         void *                     ahb_addr;             /*     8     8 */
>         const struct fsl_qspi_devtype_data  * devtype_data; /*    16     8 */
>         struct mutex               lock;                 /*    24    32 */
>         struct completion          c;                    /*    56    32 */
> 
>         /* XXX last struct has 1 hole */
> 
>         /* --- cacheline 1 boundary (64 bytes) was 24 bytes ago --- */
>         struct clk *               clk;                  /*    88     8 */
>         struct clk *               clk_en;               /*    96     8 */
>         struct pm_qos_request      pm_qos_req;           /*   104    48 */
>         /* --- cacheline 2 boundary (128 bytes) was 24 bytes ago --- */
>         struct device *            dev;                  /*   152     8 */
>         int                        selected;             /*   160     4 */
>         u32                        memmap_phy;           /*   164     4 */
> 
>         /* size: 168, cachelines: 3, members: 11 */
>         /* member types with holes: 1, total: 1 */
>         /* last cacheline: 40 bytes */
> };
> 
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
>  drivers/spi/spi-fsl-qspi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
> index 355e6a39fb41896f460e2474a90b8f0b42068ff3..efd87f44c63a5b12b76538aa459ca8eb203b9dcd 100644
> --- a/drivers/spi/spi-fsl-qspi.c
> +++ b/drivers/spi/spi-fsl-qspi.c
> @@ -264,14 +264,14 @@ static const struct fsl_qspi_devtype_data ls2080a_data = {
>  struct fsl_qspi {
>         void __iomem *iobase;
>         void __iomem *ahb_addr;
> -       u32 memmap_phy;
> -       struct clk *clk, *clk_en;
> -       struct device *dev;
> -       struct completion c;
>         const struct fsl_qspi_devtype_data *devtype_data;
>         struct mutex lock;
> +       struct completion c;
> +       struct clk *clk, *clk_en;
>         struct pm_qos_request pm_qos_req;
> +       struct device *dev;
>         int selected;
> +       u32 memmap_phy;
>  };

Reviewed-by: Han Xu <han.xu@nxp.com>

> 
>  static inline int needs_swap_endian(struct fsl_qspi *q)
> 
> --
> 2.48.1
> 

