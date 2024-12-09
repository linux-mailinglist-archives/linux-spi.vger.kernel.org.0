Return-Path: <linux-spi+bounces-5975-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DD19E9BF9
	for <lists+linux-spi@lfdr.de>; Mon,  9 Dec 2024 17:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD7E518851F3
	for <lists+linux-spi@lfdr.de>; Mon,  9 Dec 2024 16:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B4D144D1A;
	Mon,  9 Dec 2024 16:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hxfnqbva"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011033.outbound.protection.outlook.com [52.101.65.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F152713D518
	for <linux-spi@vger.kernel.org>; Mon,  9 Dec 2024 16:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733762544; cv=fail; b=fW4kwOz3Z+PajpMkGWo5XLNsAPfnOmaWw2nOAMCbG0F/9DF1qK+56HAXNmFpDBDhn95+OOUCkeygyIUzb0NLPWT870nBi6PgqwBGotW5uofXcH1maSVrIRZDfhFU1VC9H4p1kCYqBcCJdrsIDoxEToI059KLnkiLSaeOLMOBV0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733762544; c=relaxed/simple;
	bh=+UKg8civvkzs7K/k3JgAHxPQRbgWlOgbvnx2tCU7to4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rDh6NqlCof2GnzaPKOH/Fxpf04S2VxPzWC1p0+nza+LWe0lt77bWnaLQSD4VrJhtN/0txMERrnj06yTdsy0c4OX+TJ4W5rYZGT8FNtvGM1ymC1a77hFWpn0U6ZYF5aFkFN8mvM4byBbRB1ZCEG1E9aTltptPDqw5hUCqQhK7zyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hxfnqbva; arc=fail smtp.client-ip=52.101.65.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SfQBUfQYY5E2nfwhklLzZaVZQy2idxUrXHbRBY/ACMHWJ8ii2Xe5S4UdSM83pGnL3mpQ+b6ykOhifUA4jVIbIfPv47OKYGXAcO/r7wwjrRZWvK5QVYQpmkFaxWXIeO2k7WrjFPhiz3hxlfI+ufQG8b1w8IVVDTtmdeEvFk480s8SRMtYvB2S9+bzcvFPGgDyYVCK1Q6kXHDy21I4guUaDvP4LI2C4lMj1nCn+13C760yMLeijyA9DqfawzX3SHF/CPYWaTa1prg4nNcMj41CvRsyoZiiAXuK2WO3PRH1GtHf46hviyXB7TCK7nXXPf9kFrJSjt2MDZIwk78y2bazyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07mJ7tTaoJtKY/DBt6BZurX4AsA4JwDOBKmes7FGOqA=;
 b=rdhi2OEJq8DfgOQ/7K37IA4NKcDhasDwFpngjgSNnFTm+oijGQsAZK+9mCnRAKTktOv/D2Q3cwRNm1ix4iW/X7+39hf43o06IkfREcUNthILV75idwNJN4gVk8tueg4D/z2LQXtiRr8Ef4eXzAiWi1mUrwjNUaF4TaquLtv5uTKScIfQ1SOjVRkHlzqY0A4M9+Y5DuxucYZh8CEnmRKSPJtoBzZNFkMkCfGrlQl0dDs8fE/QBVAEb+pRlSRD0K0sUngsVviBukF3/xFz1RKhhjESrnWoNtWxQc0fcr7h2jyAJ0P3bjqCzQMPNh/ARsomI4t1F4Bo1wW7SEtK8tFVLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07mJ7tTaoJtKY/DBt6BZurX4AsA4JwDOBKmes7FGOqA=;
 b=hxfnqbvaNMEM9AfZvBfaPpGEfB9xxTDlAZteWun7evb/fJdCNTH4JhjFJzQhZlBLPDA8gRxRJfoQ64mhpZN7fj8suiTw/mgvzldSLTKB7qC03qay8dON6xkdV1g1qhv0IqPwzQCXN/k3ylyEGLorXj75kubOSgi+iGIXY+QMSBn6GFT2Je3kWfb+mf9MhN6Ymue6AZ6n60i8RilsTQ4noDhVFVB4FiqftzEAqNfrjnnaNBVnnjrkIIDq8Vk1FADmx46NEQq24VFz/3QZ2iI1CxSmlsqP1B9wWBWjmDxdwlWZmPziggdKz5hkJct0zFdCMtPb/Z2iOagr3PwB/CW1kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7850.eurprd04.prod.outlook.com (2603:10a6:10:1e8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.17; Mon, 9 Dec
 2024 16:42:20 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 16:42:20 +0000
Date: Mon, 9 Dec 2024 11:42:13 -0500
From: Frank Li <Frank.li@nxp.com>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] spi: mxs: support effective_speed_hz
Message-ID: <Z1cd5ZcU2xTeemZH@lizhi-Precision-Tower-5810>
References: <20241209111316.4767-1-wahrenst@gmx.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209111316.4767-1-wahrenst@gmx.net>
X-ClientProxiedBy: BYAPR01CA0060.prod.exchangelabs.com (2603:10b6:a03:94::37)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7850:EE_
X-MS-Office365-Filtering-Correlation-Id: 370b5a03-d599-435a-2876-08dd187072fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oC7JgYyzemtvKJIzLA4awWqLcCiRLESM1oPUlh5O/xQ+N8VnoFBzKtHn2tyW?=
 =?us-ascii?Q?Fac2/PtN812VZHwQdU+xHDN4s9WiRF+4/j4kbdsAh9zgmzxN4lOyunvlFdsU?=
 =?us-ascii?Q?OPYA8NLYY8Ox8cb75MP6w+NWIAzSGc8TxySZTnUdAgRIN5SBf5tGS2wioe7B?=
 =?us-ascii?Q?PXSwzU3+E/RJkSOHs2B5wEN3s1JPmPEeztHLNY+kc3yG33bBkQCMrBxR/Xcv?=
 =?us-ascii?Q?N1ciIF+1YgaEBS8r75goYMlG7UpPHFUL11JVJz4CJF/G5UckryMU4IOr85DN?=
 =?us-ascii?Q?VM/LUDux/TJytW7krCEM0Po5IGCqZcrjySiLE1itKOW8WGRble3CDs9LR1C4?=
 =?us-ascii?Q?AcgewdBPcyN6sDpjXjHO0d9jkTMcUBq0/eY+IARexaMOYMOxwWH3YhUoJfE/?=
 =?us-ascii?Q?rJhTRbF8cEjT0P2Tb9ytoTeMwH7c21eEAsU0cM0/eMzJ3mMmj48REGKwcDEd?=
 =?us-ascii?Q?3cf29SKy8nQlyE+Wpnec6kWNxXnMJzTIH293GuNvqtSNy3ApFIYbKThwPokF?=
 =?us-ascii?Q?qvkN++ssyKiPGOJXbrE5z+o8KGTB1bvBv1+6Bgfnxe6iRb42Ur8VrT2xIQqP?=
 =?us-ascii?Q?C4oMNDyQP9ELMpZUwwuYNY3Y/2HheWd5aNQhO9jKx3+RDXiJ8jMTHjbws9WO?=
 =?us-ascii?Q?hhhfyAY97Iuzpkm6cjQyiIo24XhghHwGobG5Sq+mL0r+TDYmKKiKy9pafhVx?=
 =?us-ascii?Q?5LVhvbFp5MrM59qtRIDPF6MjpikoLQjyKqQJWfwR1iiXlMLyL5tyl6adqXyZ?=
 =?us-ascii?Q?gvwOkfXZCTST9swLVijo8yEPAtNH93I+KC+/uYRPht40OQo54i/PfOq6h65z?=
 =?us-ascii?Q?7C+KxivMzaGAFqNZJXPOfmyU+70nCmMn4VdsOH+YCZdA8ODdhVw68oZ/q2m4?=
 =?us-ascii?Q?8hp4PmCnTlgTRErAFt2zc2dZaq1bva8d6VCutF0dPkfstk4dvifNfDHa4t/j?=
 =?us-ascii?Q?Yu9vCDJYE4O6GJ4CmYF98P9ue9yl5W/zkc7zoSSqr8nTzL8hpHGbIZGG4bgS?=
 =?us-ascii?Q?SKuvUVE+mLgXv7DKunXgz/Si48+PSaALef9oQJlrB4GItNHMVIDnolIUtzfE?=
 =?us-ascii?Q?vHwt+IirvSmGCIawtZ6wKprnnlZrHE3IKlqNA14Pj8WZDigwwtGPguqkAMl1?=
 =?us-ascii?Q?Y4NYlMHJp00nuuAJ9YYbsFItbVZeeveKQg+7mbFok89bjIu2u1Bungbdtvl8?=
 =?us-ascii?Q?7LQBPlExxCMVJz7qETdWy+hBnjmvwpy1jLKZjTsRgwnneGYenHT1GGQdhJa2?=
 =?us-ascii?Q?huEpNOQPWt3kgtxXFaXe3rJqR9bkjhIDCVK+vHrrDtwa6RGwV2Q9AMjcdT+/?=
 =?us-ascii?Q?hdS+FLHl2twF3Dw+N2Gcc3VmLimbMCHxwHGU9YjQY424W+3p5WyOMty4IwJN?=
 =?us-ascii?Q?stSoXd+Ic8MG0H8h/T1RRUOKXjkTajnPb2JYI3VfrpTUYuOYzA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WJ7GM9aBdoUSMmfKNIvK+mmGNPgaM5VVSvpe6hbnw41WjHBooBpKes4CRuCw?=
 =?us-ascii?Q?VSYUIVmnA6ED0e4qcp8jozuRawJ+De/d3R7177BiipM+VtBls1cn9CtHDB/j?=
 =?us-ascii?Q?Ua0Wrei2P07+TWS3e5gaCINzK5HVF9Eff8aRwYs70D4SC0ycMCj17U5cXgus?=
 =?us-ascii?Q?iUneWLLaslRZwJqAFBOtkeCEdckVSz6JNfhwHLP8asfM24350A20x9gYMrWW?=
 =?us-ascii?Q?ElLnu+XGFmthWyouK9YjOyScFzyO6tGRYgGvZebGAFAfKuz8DBndIFpvNrvG?=
 =?us-ascii?Q?nVVuDbGjJs5xMBqpOHg6g+SaCdZ8xlPLzbRxC5iAWo3hwwA/T8/gEXowL0FK?=
 =?us-ascii?Q?yqVmAB9UkF5kr2hd7p6R9Dbsnst5EgXca9ySMGwAaVjLUFvNl6roEMbPmJKY?=
 =?us-ascii?Q?JXD+0+4t4BJ/+bAPc3VhVozwu1j2Q3MJuNHz9Vm6Cxt0pyxcYxUKq493b+tJ?=
 =?us-ascii?Q?dCQHK0Cr6qDv8SXN9YznhHNJcjwhh4pKl6wY4W5ssMq4i/amc9sqV40e8kDA?=
 =?us-ascii?Q?wZeof6KKiJwlHgY9zo0iAWjzTL2HNpqtDymINVUiqp2OE1bL+ax+bLez7lD/?=
 =?us-ascii?Q?m5yiwRZPs6OBj4NITd51VFn/yAll5Yv1gajM6KqkrA6xU7vgjpTH8mvrQ1ay?=
 =?us-ascii?Q?7C9TbpYKhZWq1Ftad3DZBIoiZm5SMqeHH673y2ZB6GeTaoQlv4me1cuq6nKY?=
 =?us-ascii?Q?d2DjnuHjZWtpvchsbpupzgFgI7yIvH/Aw6lcCrs/cCi/5y50W5b4knKLNDwE?=
 =?us-ascii?Q?VNQjKH6Gj2qf3SoO7pcegs8/RInZnb9MsiMk3IgJNLT7CEkfvuDK6kuQIt2+?=
 =?us-ascii?Q?BHpO7AD287+3wJU81WCBBfxbwKJIvF/Ds2EjSB4QhSwsBznzgZIpDSSg0uA2?=
 =?us-ascii?Q?iILoJwo0/O3pnGNTRsdVxjuw/zGSK+SsOP1S8S7pZU4GkNAEH/kEC+iCSJ/I?=
 =?us-ascii?Q?QlyFEL5RM8t3xpi+NaV9kNGdpz5XT5jhnOujbZ29Tko/7u4XPX77289ioO2p?=
 =?us-ascii?Q?+uR5CmxWBU8LYOum91GKcKdRllmBFH1gvif8b7DDyi/bSipUohFxE50oczoD?=
 =?us-ascii?Q?ds/tRa+Hojgt+JipLkcp6U6fINo2PNVYOIPgF5ADsZfem58I9GYpjEsbZoon?=
 =?us-ascii?Q?FuY6iIp9LcidpO+hJLBiTc1Cg5nzUjR6EX8Qg7GIt1zGpHG6x5R/6J8xQc9T?=
 =?us-ascii?Q?HrkHqAWgmkrmxs86eeSbuZVKoAtNoNppZE5VBjCOfsa+zjc7GMdkV0xUAw0h?=
 =?us-ascii?Q?Ypz4kqd2d22k3mTf7yLIxkCK6j6gtp5X+quKn7bpG5JEGOxrt8L/L9t3wcAR?=
 =?us-ascii?Q?QCk4Urhjcffh/v31EOj90YApaRLQ6JXCtTaLvwdC8t+imCa/G6c2UKiyT/ot?=
 =?us-ascii?Q?w/VjfMW+AZ+taCKt+071rFWOI/z8xabqs6ql86971cIx0hwHYgn8hn2qGON1?=
 =?us-ascii?Q?K+uDLNZBmMb8ec3oUil0K/gUc+yk+gsBlcTuVX77b6sDQy53/44i35NXYOi6?=
 =?us-ascii?Q?xdBPJbWyZyTmHKcCJNprEBlgUXOX9zyn3cW5uMCItiOGzifZc0tAY8jimI+7?=
 =?us-ascii?Q?nXWkaUj0fX80PEyjPfH7Yv94EVK1VE8jDlpqV1AC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 370b5a03-d599-435a-2876-08dd187072fb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 16:42:20.2711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HG7p3pWgzqcbyvNtcZR4hH2lMGBcWwKGhCHdSLXsXAVG7zW7uOhy5HTOApJ4UOa2OHwsIp1fWjRvHJ9t2zaoHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7850

On Mon, Dec 09, 2024 at 12:13:16PM +0100, Stefan Wahren wrote:
> Setting spi_transfer->effective_speed_hz in transfer_one_message so that
> SPI client driver can use it.

Nit:
s/Setting/Set/

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>  drivers/spi/spi-mxs.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
> index e6d955d964f4..43455305fdf4 100644
> --- a/drivers/spi/spi-mxs.c
> +++ b/drivers/spi/spi-mxs.c
> @@ -381,6 +381,8 @@ static int mxs_spi_transfer_one(struct spi_controller *host,
>  		if (status)
>  			break;
>
> +		t->effective_speed_hz = ssp->clk_rate;
> +
>  		/* De-assert on last transfer, inverted by cs_change flag */
>  		flag = (&t->transfer_list == m->transfers.prev) ^ t->cs_change ?
>  		       TXRX_DEASSERT_CS : 0;
> --
> 2.34.1
>

