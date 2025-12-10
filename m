Return-Path: <linux-spi+bounces-11855-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B01CB34C8
	for <lists+linux-spi@lfdr.de>; Wed, 10 Dec 2025 16:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82CAA3020C6E
	for <lists+linux-spi@lfdr.de>; Wed, 10 Dec 2025 15:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264C72BAF4;
	Wed, 10 Dec 2025 15:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M1Pr1a2e"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013050.outbound.protection.outlook.com [40.107.162.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720C02459D1;
	Wed, 10 Dec 2025 15:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765380131; cv=fail; b=LqM6nNtUHKahDxA6+BFnXNxb6IcI9TOAD3STPtAHAu0hAvqL7z4B6RVpkDkQLoNVB/jumKisgFKhARYn6cthffIZgqdwGwKjm0SxleYUv7wiHOMZRyDQbfB7+SQ0XQw9oTzD0GFQ0iZeJ+cC0GGK0oTf/Dt34bBVyZGMqyc8i7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765380131; c=relaxed/simple;
	bh=Z43NLm03H5kjYz/FHYv1QgJqr7xw1hJohfP8gIXGlFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Tt4XLLtFElCkcpVm9s29to7btS80sRWZMvA8EoOQ9nx0rIPQ5Ep+OkBMha0jjiVYd2pRevUmERmft66jPObWSJEe8NLR+UL/aAtktKqU8QTf03A4kuG01SSn6INb50fmEpbvZCwRoZfK7IpHT7cddCpwBxk0O5f7oGn0RF6Nlg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M1Pr1a2e; arc=fail smtp.client-ip=40.107.162.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G5AO92PJ9V3uyfC4Oxh01IVQEBqI4RIyZSk/DtXyYDX6Cr/GyZjjtI4F2+zXyscLONPJRi+qJSd3ClEJ1VI+qH2nVCFls5Cu/Nn1OPD4llHZeDgeCRN0QYMYiXDQuihE9LznPrjIGnwFnK4hz87by0LpjrLtwugDfPYx6aKYHuN8AFD+RWdhvKH61vgN6u7e/wWF7C3Flct4fc8CeuJItnf4jxI++tejoE3XHTUgULMvx34ejtaF248Fd60jYUCbtazyvAFJzKVit11Ja3Z9stvf9Bvac9cmLmqfLo3kStvGB+XbCrL/batdZrgK4UV/xuQTNXgRUOSgGB+/3XT+UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSdwtnkvpZp7Wa0L+KkYJXEMhS/3AYxnIjS8QKAgZ5Y=;
 b=F76kXUypeO2hy3QTDbk4iBo3AyT+Uvvu9LYZ1O95knf6h1jvmJuweNlo0LaAgFUA06enywQFwLi9msfjj+VPEtIIfPbf0XrP5sIZAtzvRJgKZtbzSfGNVcYtZuuI6cLviDli8J1fQvJKhiA7Fvw7C0YeF7sFjVz5LpNc5RQ4HIEwoV615g9vmB/xHsTFzZznnuyhGgoR/9S+4IqmpB4FFLFKUuB1csAnJmhMS0xj7ztQZpH+SxiRzNgi2jBKDK7JTL1410zQWRsbCH1Rhr8V+RcpjLfb9J7evYJRgQDW5XTEcCCWi+INiCLQb9PaRbE9u4LzPfK42nOA7x27UtmNEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSdwtnkvpZp7Wa0L+KkYJXEMhS/3AYxnIjS8QKAgZ5Y=;
 b=M1Pr1a2ewgQsy66fm9GcVhW3DK5AfcdjCgIJQM350sz+xNQMbmIJUnot6VoDcah5J3pHYQA2EYmHOhVOEC4P1ISeJtbQjBakw37h8JrTi3A4oJWNwtc78GB5e5Blv1jhwoMeqOt1ghn6zqwORJ6gOqgdt3WPJlSrvThPCPhR7LY6R/2MeUBazd4qYBqUII2gmIBa4R4QNh8ul9lyr8eJvVOKJ+5phZ+5wqyOD11+XF7ad1RKGA5P0JYdVMBnVM+Lxt/hKvXEg7twcx97ZfB8OapQpjqVGu/qbmtIp5p+VF/Z1AISmOBgdaQMwB4rN9tq7qO9NmPPoXZBea1qodRN+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by AS8PR04MB7814.eurprd04.prod.outlook.com (2603:10a6:20b:2a1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 15:22:05 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 15:22:05 +0000
Date: Wed, 10 Dec 2025 10:21:58 -0500
From: Frank Li <Frank.li@nxp.com>
To: Carlos Song <carlos.song@nxp.com>
Cc: broonie@kernel.org, daniel.baluta@nxp.com, david.laight@runbox.com,
	andriy.shevchenko@intel.com, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH v3] spi: spi-fsl-lpspi: convert min_t() to simple min()
Message-ID: <aTmQFgGhghkh588E@lizhi-Precision-Tower-5810>
References: <20251210105001.3891776-1-carlos.song@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210105001.3891776-1-carlos.song@nxp.com>
X-ClientProxiedBy: PH0PR07CA0075.namprd07.prod.outlook.com
 (2603:10b6:510:f::20) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|AS8PR04MB7814:EE_
X-MS-Office365-Filtering-Correlation-Id: df21f062-a639-4b28-a81f-08de37ffe052
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SITfjWPK0E6vOPMCHUy/iuLx0R7N3Pl3CIiKsUmXhtmoI/EDf223y1UctOe0?=
 =?us-ascii?Q?TRasgQp8f+6zhWHWVkhe3Jqf6la80gVepuo1bVwTBYbjgwcL0y2yFIUJAXzB?=
 =?us-ascii?Q?E4VgwyOvTMXb/45w5R2LnRvm99JlBZ/1GfeGOLrNK0It/YF0DyxlGXqEA1Yk?=
 =?us-ascii?Q?is7LSHM1P8qqFkO3wIWSSIxptWEYe2BUZ5VkJi9XpRfPY7G7MqtwJoDwBjiz?=
 =?us-ascii?Q?8uVCk+OlXpJ+C1hq2x760A0Gk1QkqG45L4J3Mw9haZ5EmR6FDQ6oxN2KHYdi?=
 =?us-ascii?Q?8CiB+NnXWYALW2hFDRUKha3JxAm/lwTYY9S1mgsGPK7orQ/iBqGZNPAQuoD0?=
 =?us-ascii?Q?Q1hNBNl1scCWmFbOESZFCmdptLXZn/AVR4D3KOUpUzUM8jG49zNJVYXaCUdn?=
 =?us-ascii?Q?gsUXH7ZRNPH1g7cCA49BgggiWaODNVsyTkbskfRKhvRfH2jGIlng7Ar/PmC9?=
 =?us-ascii?Q?ek4wkP00rDCks/T3iOATqPy4/UiQOP0OqCPnvvhpMZoL65OuTgRUKYPWnsbG?=
 =?us-ascii?Q?pjcTwKdCV011CYSluzA2Gh72ZftuD+vAypRvn2jXxc04a9MFm+6sdQWbsW+I?=
 =?us-ascii?Q?ehQ7NRHG0k6aJJSkICyP5Hl8ddagsjPJ1eeAZLZdMUr9x/5z+4u2Y8WsvDrM?=
 =?us-ascii?Q?IFgZ/XNsOMMC+9rbQWZPjzD20s6Y1cvJSxOfyECpkaQYXl94aIdIyFj3efJl?=
 =?us-ascii?Q?N+UI4qXXtf9g1dQgafmJJWkS5ukZ/uv31P/a8Zej55ixxYnqZPosyOUGD0fU?=
 =?us-ascii?Q?d2eMKSyktqW9y7E1NBd0dnbcI5lqWunL9AfF/uTK9nFPzOYJ6pUe2+4QFkWs?=
 =?us-ascii?Q?n8bjq7E3rs5s+EMRJUJWv83/40Dy5s69NWhxh3uVSE8MAAIy5NzbnafyBQur?=
 =?us-ascii?Q?Ok1pLSRAoOu0Y89GNFFWecwNXU3jA4fQoXCQEwIxK0H5e6gYoOCBvIWdlY2I?=
 =?us-ascii?Q?sxZe+A85IE6K544tV04YkjHI0HpItEJIJvXAovDVYdgsRDuMdrFN8H1p2/EO?=
 =?us-ascii?Q?J+5qycw1VCoOtVMLu7WPq5Fahq1qhc31q7G+iFJSlYKDQqzpgNkrmWkDSPat?=
 =?us-ascii?Q?OBl7RTbxiHnQdAgQJDdb2hs9jMcrgRTm+94MmQsgaLUsGNtmQwtu8OmEiz1y?=
 =?us-ascii?Q?b8XhXL+wgQ96PBHMKfea9NaoOknXCSRdm4pb80GoEjo7TxG9U0EGJoDElUpE?=
 =?us-ascii?Q?T3GJMtFQZZy/eFcUQjDTlw/1xsdnEx/MVqrCd6358t8k4bE5izHhKlw0WxKQ?=
 =?us-ascii?Q?ccwt4bM4Q1JmvQRHuXzg8rgy3CW5dvyejWUR7iY6nTdJkb0SpJyHlSAkoXyc?=
 =?us-ascii?Q?nQh9Gin5vdp4ui0qGHBjEVZuXma/CTUiErMBgkv+pmYhi05/Qjr4HdtkgeAt?=
 =?us-ascii?Q?JeoqIfl/YU4fK0ex4n5zVy0Y3Mbb/0MLKNr794pTP6LZJFuknYCb1mRshjDv?=
 =?us-ascii?Q?2V+F9pRBqiU6go75dbLiEwWpx4gillu3q4FL1TYbtextX7K6wUn+RCV+mx3a?=
 =?us-ascii?Q?PoWz4unSwLPn0prRwjDMZXIpv392rmDaYYom?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jq7c2zGdepue9q1FxP4d4leHxx3+5TZEP4gUArKj6KHbVX+RD0lm/Hsc7GBu?=
 =?us-ascii?Q?752fYIdn/9bCcvpsBfp/2+UwfU6W/JzVWnadLL7KKKmOY9hr2PH7csZ99vu1?=
 =?us-ascii?Q?Ka+ZvSdmd7exJIh13mfRAd8YlCUi1JjddTKp6sS3Hru/Zaz7kOe/S7GV1c1Y?=
 =?us-ascii?Q?DRA+/o4jkXHYUhoqVpCFy3HX8foSYAfa6Jz3TNkX0ckssjUixqW+RjyYX916?=
 =?us-ascii?Q?1Fh2DgL7yBDYFNwUl5p5KeJuTNlC3R+kqK7M7XYpuz8Wsa81j0eXmvbJ5fNs?=
 =?us-ascii?Q?/PQlgVH15n7T0oaQSQhVTzinM16fqYplO2fsKgF40hVTvjrdJoTxudjA3cLa?=
 =?us-ascii?Q?fd1bUKFkTlUqvH6KggWn2ACXbM4nBm3Hl89JHzyReYhYpAELTzfFNxZvzmu+?=
 =?us-ascii?Q?38x5BrBEhtD2LprJo8wpF5fDTDuJ+0HAb/z2lADV2wXRQxYz087N9zMeDT5u?=
 =?us-ascii?Q?y/gr+3X33sIkXPHVlJudLNipR+lEJ79/ltqMrRt70YMBvpQWLAeTsifnU9w7?=
 =?us-ascii?Q?SJa4DVHt7TMZ7lrpnDuSgdK2DtZvAfFOa6yAGSt8hxz0jXFENO8Vl1Mc8kMo?=
 =?us-ascii?Q?Fww7JX7CFAmSFmtg2zHd0YhLW6S3/xxWq1vZ4Tmlk+ZLNP8AMjczahfyowQ7?=
 =?us-ascii?Q?CMUk5J9cjApsLbFn6b3F0C3DbETqBuwrUc8Ov4A9g0HVGNZo//ZcgtZYrl4q?=
 =?us-ascii?Q?UrTjEqWfxIJUdCjLdINomw4zw3K9Vr6AUAJT+3s1boEOZX5Dn3Wk1z3E1ZSW?=
 =?us-ascii?Q?FcyxMzy5EKs+XyBuStYnNKGE/GbBp6XfeJzm6Xz8gPt0WCcNM569k+Ldn1Ax?=
 =?us-ascii?Q?6VpWz9oNTtZC06Q6dB/lYesxrnv0tgtlvTsghWb2UyUkal6/UVEPbQ9XJEjD?=
 =?us-ascii?Q?O0+JovDNPeP6OwUmadtV9a00fg53XqDdCil/Ye7Fv+UAMyD+K4bnbFsSZvDV?=
 =?us-ascii?Q?GxmtmoJrNrOI8GKGexJnEKGxVCe65p0Dm9LzsWBEqapPA62JmF3ehvEXvzN+?=
 =?us-ascii?Q?k1C7gNO1QYFs6WvRW8nxsO85ykuKkYMgXNufUVVh05dW0nVQFKlMgyinkzK/?=
 =?us-ascii?Q?BBC0rolvBERFRINCVLiTL7+eL7fRUanPjPvsKyIN3q76Kk0GlvF4bhdfVYs0?=
 =?us-ascii?Q?wY0vlRKESEVoijTemutSfJFnhfTYsUoGtchN345No1MAN66R/XybcrXSXk4j?=
 =?us-ascii?Q?5c1P8NXW8feFE1shuRlrh00yCMWi9J4k70OClXh179Euk7c0EWpBqfKXh3ND?=
 =?us-ascii?Q?lZRTe0JbsXtvUk7/RSi+sKbR5nOvKacFSXYgkw8M3U9pqgkGcFV3eKETNRWy?=
 =?us-ascii?Q?JCvzQXImfb+EsJeGN8j+AKxSl0JtctDcsT2D4zVuQlB3yWMPNXCjBhoRnvkF?=
 =?us-ascii?Q?CYy9egAIT3grP3ih5ExakqQS2TQqHNO4089mm6E3QfDVCG3B25FYyCUeZBjL?=
 =?us-ascii?Q?tI7TkK4O31Hf2/3X2N0wSDXC+VlBzKxBeH+A1FJQiaGIN6nPbenY/7TfwSTt?=
 =?us-ascii?Q?5XVf9C/k8/UOXo6iT0xMWrKSwc6CO3i8AE55JG8OHRXC1wCdkSdmWz0BVryU?=
 =?us-ascii?Q?YU4JKEwW8pdpj8zrgImu/6MqBzMLhriV1yT0ZJdt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df21f062-a639-4b28-a81f-08de37ffe052
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 15:22:05.3954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M1nwcG0naAcvOjxcwUSYGCDW65A87X6sYtzs/N0LQeHUceR6X5asQhnqygXSFn6WBpVc2r7KnA2CqlDYxrSaJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7814

On Wed, Dec 10, 2025 at 06:50:01PM +0800, Carlos Song wrote:
> Current min() has supported comparison by normal integer promotion rules,
> so explicit type casts or min_t() are not needed.
>
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> Reviewed-by: David Laight <david.laight.linux@gmail.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
> Change since v2:
> * remove 'Fixes' tag according to David's comment
> * add review-by tag.
> Change since v1:
> * remove unused comment according to David's comment
> * improve commit log according to Frank's comment
> ---
>  drivers/spi/spi-fsl-lpspi.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
> index 065456aba2ae..8f45ead23836 100644
> --- a/drivers/spi/spi-fsl-lpspi.c
> +++ b/drivers/spi/spi-fsl-lpspi.c
> @@ -486,15 +486,7 @@ static int fsl_lpspi_setup_transfer(struct spi_controller *controller,
>  		fsl_lpspi->tx = fsl_lpspi_buf_tx_u32;
>  	}
>
> -	/*
> -	 * t->len is 'unsigned' and txfifosize and watermrk is 'u8', force
> -	 * type cast is inevitable. When len > 255, len will be truncated in min_t(),
> -	 * it caused wrong watermark set. 'unsigned int' is as the designated type
> -	 * for min_t() to avoid truncation.
> -	 */
> -	fsl_lpspi->watermark = min_t(unsigned int,
> -				     fsl_lpspi->txfifosize,
> -				     t->len);
> +	fsl_lpspi->watermark = min(fsl_lpspi->txfifosize, t->len);
>
>  	if (fsl_lpspi_can_dma(controller, spi, t))
>  		fsl_lpspi->usedma = true;
> --
> 2.34.1
>

