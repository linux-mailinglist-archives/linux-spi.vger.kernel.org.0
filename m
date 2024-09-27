Return-Path: <linux-spi+bounces-5013-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6287498895A
	for <lists+linux-spi@lfdr.de>; Fri, 27 Sep 2024 18:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A31CA1F21483
	for <lists+linux-spi@lfdr.de>; Fri, 27 Sep 2024 16:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43BA17ADF0;
	Fri, 27 Sep 2024 16:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PYUZGCDz"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012000.outbound.protection.outlook.com [52.101.66.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77911E49E;
	Fri, 27 Sep 2024 16:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727455995; cv=fail; b=s53miVF2E/8TMzeLH9XlkT0kcDE1Ov3nnmYSQ1uHp3r6oDlJIhvzRCtVwcTuJBITRsU+MDfcNHdiUCEPbwxcDTtRSG0GeYqB78iRH/rfwdxFGXXIaCZuW1vFIwg6WGj0brYsbnLp/vpI5xMgch5a8EwI3K8bpzZUZJdg5SlM21I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727455995; c=relaxed/simple;
	bh=UygKsDQ4QRDe9bktF5/7i79jZxBdIFyvhCO/1e9MCdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GhhQ8y8uRP1G0eGvrPh/ToViYPYvLG/Kg/N3a5ouuiULXzxF9leT0Ajzodq407Pc/6NVM3XUqJMof9HUe4qYI7WCCOit5mbgqCSmMQqtiYpBZcNNVh84D0VvVn6fuvs1AU+8ZR/fjxK+9S2VxGQUfdix7iWAA5kFUx+sfPmobW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PYUZGCDz; arc=fail smtp.client-ip=52.101.66.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HW69v+Zk3hvGdD9UuiHjF+DOWDeZ8SKt1fXuMMcm5VbEgkh1mAF8dLWpzAkguPjIUGq/rcIl54VF0mK2wewXkDpW5iafIKpMoWBPdFZMCq9+v2Yf8VHUEaqyx9uDfGgdoT5ylCx9zSpxRnc9rLNMYhS/ijBWpIr/xik96HVy2anF2TSC1ex72S+ztLvtMyeG5Z80c7F8MQpNRENXjrgxsTY+pjBZu5naNxAVrqmcSxl6MuYJXW3F66y6OiExmtIxIpbTmNrBv0db3AdaPfbY0PGuqokD5zFP56+ycmtQExubef2litii4UwlBefIuzlAcfiIJk0+g1znZRm10QBkCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0Ei2A7PIwgmC7O7aHAyAXnTViQ+oNbAIM+3MV2to1Y=;
 b=JyQbj8/qbQTzZ5ITrIV9Y6Pjauypqrk+gBduYLG7567qmwJUfHtdHZ0R1XRHGa7RsOb2GyLxjO1puIH+63Ni2B2HmzGYL67rdQN+MYks3V+VdGtGcRDaPRQDwvsp3cdreTSej+pIeEz33nt5w7fzOosFT7UgzAz6aWmFB9GGugWBNbbz6xPxDqETTB5X5p9J8bVmVQcq1RG92unlETzko8XEx6IiptfnSZtcemd6ve4MLo9xwvuP+F+xEAKBdSpEKYdUeBiYq/Kbzv0Ju8pT0pbAbPQ1j9NsgNeEG+t7WEXkc++camNSgRHUBwaA9+eFN9h03DkmDHrjgpRF7gUZEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0Ei2A7PIwgmC7O7aHAyAXnTViQ+oNbAIM+3MV2to1Y=;
 b=PYUZGCDzu7kroEcmePo0o6QSPdXN0h7JEofc11xHS9l3mQ3CeqJg8VaZl1nc/2EyMWgkkZdxWJEH8GFHznquVKUUjwNz1+8OFkQ9Qn5tbuBGEAIvzPEI5nKB0I5Jvw4sSQE7t48A0kpAAPX0nrH5K4zsrBcufJ0OjOId8ih3bIgIy4hN0bBxa8fyEs5LIjgzysLYpJJB0cK5oec/7KmkV5c0xGqYpZcpSrF02saeuhyAS1S3sxSBCEhs8oLTmpvgczCh7lpJfWOchtWtnt746/HOUcohuVa0TPFJSTANOfYCr5DXrKseRqYW9BJEJd+VyuTsKlxh+f+EadN//gwN1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8767.eurprd04.prod.outlook.com (2603:10a6:102:20e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Fri, 27 Sep
 2024 16:53:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 16:53:10 +0000
Date: Fri, 27 Sep 2024 12:53:02 -0400
From: Frank Li <Frank.li@nxp.com>
To: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
Cc: linux-spi@vger.kernel.org, olteanv@gmail.com, broonie@kernel.org,
	Han Xu <han.xu@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Haibo Chen <haibo.chen@nxp.com>,
	Yogesh Gaur <yogeshgaur.83@gmail.com>, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] spi: spi-imx: Fix casting warnings
Message-ID: <Zvbi7g+xpI8fGth6@lizhi-Precision-Tower-5810>
References: <20240927132944.19285-1-hardevsinh.palaniya@siliconsignals.io>
 <20240927132944.19285-3-hardevsinh.palaniya@siliconsignals.io>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927132944.19285-3-hardevsinh.palaniya@siliconsignals.io>
X-ClientProxiedBy: BY5PR20CA0025.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::38) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8767:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aafb5b4-30b5-4282-16d0-08dcdf14de1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zuFkLoW1IVK7VUl3V0su7mw49wu2pcjm7D+udw4eQ4aPGDPx1SxQscv8ITOo?=
 =?us-ascii?Q?xBi1DW+/XJpQti+pe7eYnheCux3upv7sIPnxo7f2LobGCirknJM7bhoPLxKk?=
 =?us-ascii?Q?7AaQXO+aKLy6prOVYSAE26LIRSa6JD84YQnCwiNY/w5ADK5/NcnkBPakhE5u?=
 =?us-ascii?Q?/T6O8xDKRqgtmKoaEzBu4JSX7njDa0Tyhiyr8yqL0CtY1tOmyRgnIkhSdCRP?=
 =?us-ascii?Q?xuiUGYNTixbTQ/Zs3rS9Ig0uYND4Jxy0u8T6HcMbt+gMPCqPVFOThrwwlDsa?=
 =?us-ascii?Q?vmqRuMvMAPLNO1+T0F8zbl2kp7ABD7oSjN2czLrlImT03/YVFydQBYToc2wH?=
 =?us-ascii?Q?PPdPs5RlPBCvLIpd8Eb2JZ0wUfkDtHIfdvTEKsx31Bei2n0gQTyUaImTUiPI?=
 =?us-ascii?Q?cB4GHwEjevxlG0bEWXBUpXl4az8SqMwEniwVfR2bNqVDTe+jFmhryWOXPa6o?=
 =?us-ascii?Q?Hpf51SB2IQdRFBGu0ay6zLhJ97pZH7dV57sSGj2gJ6J2qLyqpNJn96kPmDfS?=
 =?us-ascii?Q?ixQKXsyv5VtKurcKxImLLsHc2Kx/byhP7GzPM8ecFLLLWfnC+WI/qth9h4ws?=
 =?us-ascii?Q?iyAKKSCLX6m4oErutmKasPLs758Jxr72a0fA4wBnzFeUScX7MXqoIRjYxAda?=
 =?us-ascii?Q?hNKI/at74o1WnuvpjIOwmkp0KZC25jNldyRt13IUbq47Au3uZzablz9B3VsN?=
 =?us-ascii?Q?zYrRgmNAqli+2D3FDC63AqlY4svno3fc3YwjPbv3xoiM4qwY9p1g/tcoL472?=
 =?us-ascii?Q?l4lx7xPxel2RZaZ4CvB8HV1PiBtQS2Gpx1hNTXtiVQJOIy5NA/ekU6gfICbl?=
 =?us-ascii?Q?CyyV4dSjEyXOjwAwKyXC5JrnaWul0ZgohCY6VUlrxnzh6G/g5aHj4O6BjnFL?=
 =?us-ascii?Q?vUbpuVF42RO9xWlxRD/CDC9f/rNfwchbZzKsCQSZPB41u9bta+0xFjbRlCvC?=
 =?us-ascii?Q?foxe2KUVt2APB1qLVp/2xpPsRCiWH/AxiCUNXKqJfYHcSfuFUmzHWtbVD4s1?=
 =?us-ascii?Q?kozQa9DgA2/hM97ZfQvXNLDNAxV7a8BVKUE9SfgBLtWLhB4dnfXgTErWlB0N?=
 =?us-ascii?Q?uNHpiLlglXYjxT7yIEPW7BPPqa+2bXi/rZTrwrjkqbblrikp3MOGi4EeZKyf?=
 =?us-ascii?Q?dzPL1BsVyvWP75zEEC9HTUuIxw3WksIzAFRVqhhux2Ex1eLGH7s0Zwxk7I1l?=
 =?us-ascii?Q?m1IVaI0DOl40LNUHb5TVOd3I5FfZOx9BzwcJ69QoUHSw5+XWhMYiYaRwfoZC?=
 =?us-ascii?Q?8onVeKz9Mqdi81XqUGjJ55vZk02b44ywrGt2N+IbMxJqYOpSoAzWQH0XJj7a?=
 =?us-ascii?Q?lrwDqbDbLQzrlxEUmiptA/bbgfkH9WJVxO8W0wWYxyPeNq8kDdwiehTqo9ZC?=
 =?us-ascii?Q?c1LVbpu6KoLprb9Xat0cOxOimzT7fCTShf/5iCH7T1o0+246tg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lobdyBWHqVzRcqZyuA20RXC3WE7TCHcL6wurWMKY4SQHBKQsGwyFUQQ1kTQF?=
 =?us-ascii?Q?rEzo0vOlkf99O7fZ0+FTRYquZ44NHTQO+Fhl9lNgdF6LAdQmjz9Awv7t10VF?=
 =?us-ascii?Q?PEyic0sehBr0UmP5IVNgxeKddnEvviRL7SMIKoT03koUUCk3Bv0hzwJuTAta?=
 =?us-ascii?Q?AxAU+PwerBKjZVifU6hHJlmuIOZ6qDzcZtDJZRLoUXp3EPb+WY6SBBhik5cH?=
 =?us-ascii?Q?ltRaMwXMpoQ2ZK47U+Qnx4aGGODveaBrZw71jOOXkHXnvb9p2pyjqBdBl8yj?=
 =?us-ascii?Q?zcsI0Umpu9cCSvZRnTJY4zrocjpzJTnbvttUmlSCcn8QdeuZRm33FQag86IG?=
 =?us-ascii?Q?1CLaeQwwJv+r3Wdnjr3jDCifv9Wkl0Bsk4gtUAzK7BrOJOa/lkWwWSIZvJLH?=
 =?us-ascii?Q?cCKoeJdUywwuvwthp3CXSEb7v1w4OTxfxLworEzKdJrR/0aEEGeuSB9NWPp5?=
 =?us-ascii?Q?djHgzX3xIHwSKYRv2KZFPMRb5jGMla3s8HFs1ccxWmVa61fz+0mz7kg9fg27?=
 =?us-ascii?Q?8LmIfyOXt61/PPEnG8Vlf/wJu6lEX96DdaGW0NSw8xrUMPswUd56PTAU+IoD?=
 =?us-ascii?Q?4VBlCGjiqBx8nc2bXWSqNHfuWg9CAX8mb3+PU9FMwbbnrw4pz8t6UjudRfw8?=
 =?us-ascii?Q?ELOYlQO/SS9CF2MlXgHDw1gf2UpFb+CB2cSdsaYqKBepbhupN3Q0XHZcDJjA?=
 =?us-ascii?Q?0nQ23JTIsJhxb8ZNpDNnf4h475SPQ7SDetJ6IQ0WD17x7BVbq4p6yPBXKzXC?=
 =?us-ascii?Q?gVl1AjFqcLeGRwpCB8OKoxTGb3sdekw3eDLGa9aKMDT4iThQB/+PgvCZa03J?=
 =?us-ascii?Q?MwmZ7PZQUvxCSaLc06U0I26qlcNwUzXC5y5XdtHdfqqLygXt5PwlFMplb1/a?=
 =?us-ascii?Q?FXata/rjhBGngktb4C6h7jY//oHvkm57dteFEIwhM9mFNHVwL1JC5ARwhyed?=
 =?us-ascii?Q?w3+B7gD/7OSdM+XNqELobCXIEMrgnekXk3TdGYLJdym674RCDTB6rQ++b0n3?=
 =?us-ascii?Q?l679qkV574DMdhr6iAm06vAYTAStQrpkoBmQ3lXaefhlSn+ppdqNaCCc1XWZ?=
 =?us-ascii?Q?u1vSjSyBXw9pKPIvTJAmz8JnzSlwOViUi9uA7YCLQZBcisujlrHLdkVPfLdV?=
 =?us-ascii?Q?JlhFbx4Zbth05VHEw+iDtFRbXdmjG5foPTey2/Zze597iFfbQm1yOB+FRzDg?=
 =?us-ascii?Q?zNkQaCu8IQC0mAlKHTG7Wjr8T8UDqg+V5WVM0JI3kYfTuGLh2EaCyDXX6kzp?=
 =?us-ascii?Q?F6XfuOVoGQWMK7YbMNRrARKJjcK5Zt4XUAugNEl4nYn2aTKvx/f/Q8c9rO+8?=
 =?us-ascii?Q?IhsYexVCCjd3tNtLVQVMvKScAl5s5PNT9BPZBp3QF7pJeo+OaTKkaMAUNBTU?=
 =?us-ascii?Q?5l/Pvv7uZtdxlKRcKKz8fm8kEdo6ljcyieY9OJRSFpZ4UkKj0XAm6D7Y7uoR?=
 =?us-ascii?Q?GX+Yzcg2FhWycrEbVW//0jrAtGmpLMeD8ezt2GYOkqu1axNEWW0qDOz9+TUe?=
 =?us-ascii?Q?vWegSQzRoSX7Qciz7NVJCFFXcmKbv7EKYrorQ9jsKvBRR2RXb4X8tQaPRhSj?=
 =?us-ascii?Q?oIlVghUjCI4KdERvE4O0TzTgfP8Hf0xsYa3qzPa3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aafb5b4-30b5-4282-16d0-08dcdf14de1f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 16:53:10.0972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pU4EExUfcsJFpKpbyHfiwYW9754zhj7pqo5LkdnPexSKa1GwImydXFeNX9vkj/NsNe0dwmei/xIksURPrXVJ8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8767

On Fri, Sep 27, 2024 at 06:58:34PM +0530, Hardevsinh Palaniya wrote:
> Sparse warnings:
>
> drivers/spi/spi-imx.c:410:19: warning: cast to restricted __be32
> drivers/spi/spi-imx.c:410:19: warning: cast to restricted __be32
> drivers/spi/spi-imx.c:410:19: warning: cast to restricted __be32
> drivers/spi/spi-imx.c:410:19: warning: cast to restricted __be32
> drivers/spi/spi-imx.c:410:19: warning: cast to restricted __be32
> drivers/spi/spi-imx.c:410:19: warning: cast to restricted __be32
> drivers/spi/spi-imx.c:439:21: warning: incorrect type in assignment (different base types)
> drivers/spi/spi-imx.c:439:21:    expected unsigned int [addressable] [usertype] val
> drivers/spi/spi-imx.c:439:21:    got restricted __be32 [usertype]
>
> Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
> ---
>  drivers/spi/spi-imx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 85bd1a82a34e..8d09d9c1c556 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -407,7 +407,7 @@ static void spi_imx_buf_tx_swap(struct spi_imx_data *spi_imx)
>
>  static void mx53_ecspi_rx_target(struct spi_imx_data *spi_imx)
>  {
> -	u32 val = be32_to_cpu(readl(spi_imx->base + MXC_CSPIRXDATA));
> +	u32 val = readl(spi_imx->base + MXC_CSPIRXDATA);

be32_to_cpu() is necessary in little endian system. You can't simple remove
it. you can use ioread32be here.

>
>  	if (spi_imx->rx_buf) {
>  		int n_bytes = spi_imx->target_burst % sizeof(val);
> @@ -436,7 +436,7 @@ static void mx53_ecspi_tx_target(struct spi_imx_data *spi_imx)
>  	if (spi_imx->tx_buf) {
>  		memcpy(((u8 *)&val) + sizeof(val) - n_bytes,
>  		       spi_imx->tx_buf, n_bytes);
> -		val = cpu_to_be32(val);
> +		val = (__force u32)cpu_to_be32(val);
>  		spi_imx->tx_buf += n_bytes;
>  	}

Original code logic is strange, you'd better to remove cpu_to_be32 here.

below writel change to iowrite32be().

Frank

>
> --
> 2.43.0
>

