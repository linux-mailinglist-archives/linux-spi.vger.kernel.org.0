Return-Path: <linux-spi+bounces-11485-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7DDC81AA4
	for <lists+linux-spi@lfdr.de>; Mon, 24 Nov 2025 17:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C6A85347D07
	for <lists+linux-spi@lfdr.de>; Mon, 24 Nov 2025 16:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4AD313E24;
	Mon, 24 Nov 2025 16:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PayBg7rD"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010016.outbound.protection.outlook.com [52.101.84.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453083101C7;
	Mon, 24 Nov 2025 16:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764003028; cv=fail; b=GqYhu0+eDbVxX/o81DtkzQ+xb90p4Vu3a53h2HSJwpucJ8SeJFjW3ZVFoS6AszfIZDQ0Qs/PqUcgDM4u5jcYhheWycO7ir39XcYr+qN45bqiIWN4w7fSjwYHhO50+9AcG1bTRW2WKGJb1vBufIZ+v/Rh1B7dQIcFW5YMsxJBVbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764003028; c=relaxed/simple;
	bh=n3XBjhXgDd0+fUx9XdGZO+vrbOZJimMaZUXFtv+D/hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qEOm+2Znf6mJtIJ5Z55HQl1Gn/x/xr40dZFlFwwJinRg+Ot8fAzpz1o9ZqCbOWG+c+kFlB82wJmukdRWhDS9ByC4eVojGkprujh2UZ4jw10PHI0SDMiqyt27d12uuYv0onVFJV2oj1I+VP11bH9MncJeQRjEiy96CqAwx8849dE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PayBg7rD; arc=fail smtp.client-ip=52.101.84.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RLvVVIIB24ELjYr4DFMmPcuV47Np9J0HDSOssaDQk8qHkmoHygzIz8ZlfeaHdphIm1MkTHYJr60y+HGIm4yztI+baEuZCpt9KYqhNNmc1pQtChDRVocNiSDvbGd35BVdr/hUvas3Hd0QC7Ld9jOL154hT99NcbP8QLS3amjvPAbq5urSQNkCA6kYJEFeLX+69ZMB/yj0oZ0Cld1HHovBNcBC4TmrEEn9UfGVCP4Rgc6oDRrPpZwfSQW+WF3PARqiNXxTxwqYnOB1H7wWpiW5ZdIpG6jwiSRpAkUPoirBEsG7EArL5hlqh7yEEt1xme4TL3/TO66qIX5grSh0iXCiTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTZj2mkt3EpcGADxQYHn4iEz5DQ+swx3Q+GFl9cUwhk=;
 b=BfODfDBKH4LqHkgyDrVqGGPK6LnP8zUjDWjoJF9JB4R5pUJ6jnWBB5z8VhQMTBNwo09OMBqxoiUJqwPuHB5F7TiMJP0WNw85gf0T5HCzaLcjNyQR+36M7aQL/7j1hfsnc+R3jV9+tPBApD0T1BYu1pEa2qlO/Gu4vSsoTVL3bJUU5694rRkq2A9bXxuenA7xEfkBuprK1M8db9kF95DI7bD2vDFdF9U8T/R9Qnf1w81l3Bc+8wjUHJi6/qAdqZz9hWbMSVgfq29X1exX9opK2KbncCoAESgkRmkr356aDBAon5NW0/RHd8H9QUlkQYQ9Tr0DuQtiQd6y6nut1S/VLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTZj2mkt3EpcGADxQYHn4iEz5DQ+swx3Q+GFl9cUwhk=;
 b=PayBg7rDw/LLjYeWbbDOD27X3sk3UCGJSdRZPyTBtW2XV5Jh961S+VDsXYUOxk/Xh5GBqlTCorSl3yGRK/3TT8TfnC3N4dr79NO3LJ01rNnCjBjMNKetkIONwwHo0q23q+p5gggGP/tlZ5THwsmUY1pqsbcwFrzUj7hLItwVKJ/2nAfv9Q2WV0UwClaVjJHFJmJmlCj4p9qFpjg5/+5zaehgkNq0289RTAFbjOizGCb8L8XqumXwy0Xhd87ygby5XGogeLv6APhwMbJJs+52wckO9ikGAl4qyfxlnIaP9gGF6Tv4JbvuBOa/piVUVUDLeYe78qMNNFYcAR8jS3ur5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by PA4PR04MB9320.eurprd04.prod.outlook.com (2603:10a6:102:2a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 16:50:22 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 16:50:21 +0000
Date: Mon, 24 Nov 2025 11:50:13 -0500
From: Frank Li <Frank.li@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>
Cc: Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/2] spi: add driver for NXP XSPI controller
Message-ID: <aSSMxU6iNdAGheSc@lizhi-Precision-Tower-5810>
References: <20251124-xspi-v5-0-6fd03a6cb766@nxp.com>
 <20251124-xspi-v5-2-6fd03a6cb766@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124-xspi-v5-2-6fd03a6cb766@nxp.com>
X-ClientProxiedBy: PH7P222CA0026.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:33a::29) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|PA4PR04MB9320:EE_
X-MS-Office365-Filtering-Correlation-Id: 153e43e9-a518-4b07-d838-08de2b798e9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jdlns88Q8HYlTFCcrZ2H83/74qHTUM1ZixRelexljD2Oait8wlR6k9DrRIe1?=
 =?us-ascii?Q?iLrHjLUvKh03odz3UVmyXKu7Jsk3Xq0kxZnWV/uH0IuVV4p+i7SqvaSRuGGN?=
 =?us-ascii?Q?qyQMTe+eOdZ3rrkZiAS8PZO5K7yxd13Q1UmFuexI+Y5E1JLohGZAt0ayuWc8?=
 =?us-ascii?Q?/SQwjpSViGSD4CtGxLFXXLzAOItdnX1vvYaFC1TH/ZpJbBZOg/Omc+dt+Dhq?=
 =?us-ascii?Q?jAkcuniSJRnXnL0JqHDfQMWN6p3MaWuJk5vcVYta9l6E5Gcm253F/U8gz4ea?=
 =?us-ascii?Q?Wt9JFqyqXD+fWoCXdIbvxdDg95cPHitpOzJ464J+ILvqvE0q5zHE1YZY8is0?=
 =?us-ascii?Q?4RfcN5ZjnauU7bOzZlUy/NDUwiT8D9i40ZkO1aVCPtWuBte0uM77LEtX5zp3?=
 =?us-ascii?Q?Avz+iT0sjt+vgbLRFBND7pR8pcMnHa/c21Px5CQ7wcyj5dGUqBkBKkIZIr6W?=
 =?us-ascii?Q?BSkxJVraXFR7egn2u8OQiA6d9pVtLMyE4LMNQHhr1qpfLgONeZGm6C+/N+YO?=
 =?us-ascii?Q?vQ+Ulk0BZ/aaJ+PEOETeN2uyOgOCszy6AChhEOT6j2ZzkMPgvqRXgr0f/sEF?=
 =?us-ascii?Q?B/yvr+SA7hmVE/2zXcyVw5NNWQ6GHIDwcEWx1uOw1/Ar1RP+GNx26VC1fvR8?=
 =?us-ascii?Q?sDrj3ivJTdKq75RIfD2nwiKEfjU7+4l2WN1JF/eBi7YAP3OFXFQS9o8UWyLw?=
 =?us-ascii?Q?xm+nrgc7r7XEX6PSU6sqxe95f2/wR4BO34IRE+fafDMAhQhIHnBXquAwnQ3R?=
 =?us-ascii?Q?iqmdZtCQft8KbzYKT/g8utsXjbS9VRs9M9iVgKtN0494ZkpAZXOQQYZwABZQ?=
 =?us-ascii?Q?b4mPpFFbRNEFZkacD1k262croOO0pocwBJgmClSrRvTIu4g20tum33QsDLBL?=
 =?us-ascii?Q?ysShmMV43EqNxsZXcZ0qJZEO8T8o5HmGybgkC0Ublli8aeSo+Xa+Sm6BaVmp?=
 =?us-ascii?Q?iFR9QpfNqiulwOsB9u6xtqCo3xSHn/xnR2W7wD0928xDagV+tprzUYeY2zNx?=
 =?us-ascii?Q?5whS1aEodhpVYycu+CX88FxhFwsFBiSrlqKnTvy994c10kGaDCXF/pa/g4Qe?=
 =?us-ascii?Q?N+yfJhO+o/GZ+FhJ3StPDBflux3C5BpT21q674J7ru1qqbF+FPDu6HXIoMR9?=
 =?us-ascii?Q?nbNe0XX6VM7lYXmv3Zgqzu8XFt4WD89w1eKbdMP0pXYvsZo/MCbVrGbwGx5B?=
 =?us-ascii?Q?C30HUE7bmduTP65quZFFw/Tb0O4H0Eem83iQX7C8rXuZdxJtX2Sf06yAwrCB?=
 =?us-ascii?Q?9m3uH4zDSpM4VDDWTZ8tJQxRKKiLtkQugvnkrKLbLdvSy5l75Mz4tgOrNES1?=
 =?us-ascii?Q?xmBfPlNBSnvBAu+arD3O1eoluhHYYz8fzS/StpgqgbM8DnNGbT91WKWjXrZS?=
 =?us-ascii?Q?i7Iku5Ep04d54yHu5aNRShrjVOpq6EUDm8UZ1Z/DW9APi4rN2sLqK+ZLboai?=
 =?us-ascii?Q?+6Zl945cf/p7B1/6O3XcUIKGB916I18WT9qfxaOeGvlQcTWwRh7xCqFsGB7k?=
 =?us-ascii?Q?Wj1hLvnP8jnvP6c+eTlE1aTx8HRSL7uJXXlh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0Xt2Cc3VqF1yYCGs0eLsLqs9R6t4+kXRCuOE6lN6He6L567z52cAbAshg0nD?=
 =?us-ascii?Q?uMk23/oUpsqvaA5uHQKVJuyXbOy7axApvgzzENylw9FGetq56Vg7VeyV6C6S?=
 =?us-ascii?Q?ZWn9qKhFA5OhPQbvvLXF4aQJzRKYsu9pg5nMoxFuJsvJ9I5mXWbI+tjUXBLz?=
 =?us-ascii?Q?8Ds5bmCi6ZgO9bmZgkIJ6VzsENJpabTw+jMYFeeMLdajexolkSHaGEV+7QPV?=
 =?us-ascii?Q?X21FkrpAlLheJhTWxNFFUhCrKkjI9X1pSIv/2HNqyhy8MFbNF1oIyf416SLF?=
 =?us-ascii?Q?8ybQiUeMivr3/xFOrYb9TaHt5yr9M9zCNJlh4dmWJKdT315hQsPIZ3OBGIT8?=
 =?us-ascii?Q?iDPRsiaQ9a/PH6wmoYshHJa048KY5oQtT5Pr4wECQ60qb6/uX7pVEEA74yIc?=
 =?us-ascii?Q?+ibthWGhdK+MUJsE9AE4ayHmA1fzt3QU7oduvQwGcUEix2E1DCvHOvdRevaY?=
 =?us-ascii?Q?i50ElqoyyiYtKFV5XZsmiWWZw/vlrTTc91BKD4nFpGpebB7ZdoLvutCPFMxm?=
 =?us-ascii?Q?yhnZ5SXn7Pz5WAbTtQNqa1nueL6ddjDRWNtGomCwWkJ528NouDTZXqxpb3e5?=
 =?us-ascii?Q?nRSvLlEr6f1+MYEIiNfXeT2lfJpZ9G56CuoI9NLDFaWrMvkb3c6SGYnvkfax?=
 =?us-ascii?Q?mUkqmYeYo8FEP5IhU1r0KNl4qnX0iT1nJXSWH4f0jRu1FcJKR0yqAZLz/oKw?=
 =?us-ascii?Q?5NBrRQpocIkOo3BZDbpc1RmADwVKS3nf21wtbUFP9vAuS3g/U6LTcR8cuZCE?=
 =?us-ascii?Q?VSA1L7RFPFQwyTDtHBUvhGc5U7h66iJwasY4pXsOERe3J9sw7MQtsFZVp3ka?=
 =?us-ascii?Q?eJkPU5ONSpbfYuyY/oH3a4XvKT7rF8f7Nau/qYr61zn5047XwKuizsOlA/lK?=
 =?us-ascii?Q?moBnk1nPnRvE4plgKAwXDtRZfi5LJZpUjQDvQWvTDBCX9IJ7TZfuxbQvkPuj?=
 =?us-ascii?Q?uCNc9rtR9d4TTq16sQUDonqjM6RylgHXD9nUAGN0mS3QP+eJ8O2fReDIP7eT?=
 =?us-ascii?Q?OmFQVVacspb0okQfWAKK12OkeZZDmq7SH/v41lV5UlOjnRIvSYCdarXSm5gB?=
 =?us-ascii?Q?EWD+iAtA6LZ5U8ookxZcIjiaNGsno/DvHfKcqKXgKiCKfLkxEuA1Vz0TKZbI?=
 =?us-ascii?Q?THLjNlsLnobjEV7DV7glypsSs7YmANTXgICz+ik33x4xedazt5c8w9Qbf62u?=
 =?us-ascii?Q?nCGZJO/c3PhKZg9Rn+49xYJtOQF0v3Iy7p+zBWbONu60ZQojFyG0CP6YB4li?=
 =?us-ascii?Q?Gipf+S7l3N320Mt/XkKP/t+OnDFc9OSG0EXk70PanrIEtp9sJ4L0eUSBdFKT?=
 =?us-ascii?Q?W6rUq0SKnb/c1xHUUcfb55JU9TkxGSY9pP2mdRzrAwmCcH3vI0VnC/CDhmkt?=
 =?us-ascii?Q?6RIfUhjqHKPs0uU+Ts16Dw6eujPzMOhzbO6fXDUv6Y5+YAVvLGWbqLCL3e6q?=
 =?us-ascii?Q?gjrodDTHoaIXYT4fGKsfgGJc+2DAowXSqvaKIt6S0xs29gGBEyT1uTM8ETJX?=
 =?us-ascii?Q?7XNtd+9WKe0ayY7R+pzgMCwrlB+RPt+GRi8y8M5aj1OcMb7a6tQn50lVlfUs?=
 =?us-ascii?Q?s5qxAubSKkqQ4l0W5B3RoL776314Ticjw0m7rG1Y?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 153e43e9-a518-4b07-d838-08de2b798e9b
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 16:50:21.8600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sYRZHXpPzAhZncJf+y/Rykb5ZODQfFjMPzCWQ8alNC4QMywvIZb2S0925t4zCE+/9VyYCjM8Xr6xpDYiz1O58w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9320

On Mon, Nov 24, 2025 at 05:25:22PM +0800, Haibo Chen wrote:
> Add driver support for NXP XSPI controller.
>
> XSPI is a flexible SPI host controller which supports up to
> 2 external devices (2 CS). It support Single/Dual/Quad/Octal
> mode data transfer.
>
> The difference between XSPI and Flexspi:
> 1.the register layout is total different.
> 2.XSPI support multiple independent execution environments
> (EENVs) for HW virtualization with some limitations. Each EENV
> has its own interrupt and its own set of programming registers
> that exists in a specific offset range in the XSPI memory map.
> The main environment (EENV0) address space contains all of the
> registers for controlling EENV0 plus all of the general XSPI
> control and programming registers. The register mnemonics for
> the user environments (EENV1 to EENV4) have "_SUB_n" appended
> to the mnemonic for the corresponding main-environment register.

Nit: please wrap at 75 char if need respin patch.

>
> Current driver based on EENV0, which means system already give
> EENV0 right to linux.
>
...
> +	/* Wait for the CLR_RXF clear */
> +	ret = readl_poll_timeout(base + XSPI_MCR, reg,
> +			      !(reg & XSPI_MCR_CLR_RXF), 1, POLL_TOUT_US);
> +	WARN_ON(ret);
> +}
> +
> +static int nxp_xspi_do_op(struct nxp_xspi *xspi, const struct spi_mem_op *op)
> +{
> +	void __iomem *base = xspi->iobase;
> +	int watermark, err = 0;
> +	u32 reg, len;
> +
> +	len = op->data.nbytes;
> +	if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_OUT) {
> +		/* Clear the TX FIFO. */
> +		reg = readl(base + XSPI_MCR);
> +		reg |= XSPI_MCR_CLR_TXF;
> +		writel(reg, base + XSPI_MCR);
> +		/* Wait for the CLR_TXF clear */
> +		err = readl_poll_timeout(base + XSPI_MCR, reg,
> +				      !(reg & XSPI_MCR_CLR_TXF), 1, POLL_TOUT_US);
> +		WARN_ON(err);

Is it enough by just print a warning? If timeout happen, is it to continue
below operation? and other void helper function (such as above WARN_ON(ret);)

If clean FIFO fail, suppose garbage data still is in FIFO. It think it
should return err to user space to indicate op failure.

Or are you sure our hardware can tolerant this error.

> +		/* Cover the no 4bytes alignment data length */
> +		watermark = (xspi->devtype_data->txfifo - ALIGN(op->data.nbytes, 4)) / 4 + 1;
> +		reg = FIELD_PREP(XSPI_TBCT_WMRK_MASK, watermark);
> +		writel(reg, base + XSPI_TBCT);
> +		/*
> +		 * According to the RM, for TBDR register, a write transaction on the
> +		 * flash memory with data size of less than 32 bits leads to the removal
> +		 * of one data entry from the TX buffer. The valid bits are used and the
> +		 * rest of the bits are discarded.
> +		 * But for data size large than 32 bits, according to test, for no 4bytes
> +		 * alignment data, the last 1~3 bytes will lost, because TX buffer use
> +		 * 4 bytes entries.
> +		 * So here adjust the transfer data length to make it 4bytes alignment.
> +		 * then will meet the upper watermark setting, trigger the 4bytes entries
> +		 * pop out.
> +		 * Will use extra 0xff to append, refer to nxp_xspi_fill_txfifo().
> +		 */
> +		if (len > 4)
> +			len = ALIGN(op->data.nbytes, 4);
> +
> +	} else if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_IN) {
> +		/* Invalid RXFIFO first */
> +		reg = readl(base + XSPI_MCR);
> +		reg |= XSPI_MCR_CLR_RXF;
> +		writel(reg, base + XSPI_MCR);
> +		/* Wait for the CLR_RXF clear */
> +		err = readl_poll_timeout(base + XSPI_MCR, reg,
> +				      !(reg & XSPI_MCR_CLR_RXF), 1, POLL_TOUT_US);
> +		WARN_ON(err);
> +		reg = FIELD_PREP(XSPI_RBCT_WMRK_MASK, 31);
> +		writel(reg, base + XSPI_RBCT);
> +	}
> +
> +	init_completion(&xspi->c);
> +
> +	/* Config the data address */
> +	writel(op->addr.val + xspi->memmap_phy, base + XSPI_SFP_TG_SFAR);
> +
> +	/* Config the data size and lut id, trigger the transfer */
> +	reg = FIELD_PREP(XSPI_SFP_TG_IPCR_SEQID_MASK, XSPI_SEQID_LUT) |
> +	      FIELD_PREP(XSPI_SFP_TG_IPCR_IDATSZ_MASK, len);
> +	writel(reg, base + XSPI_SFP_TG_IPCR);
> +
> +	if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_OUT)
> +		nxp_xspi_fill_txfifo(xspi, op);
> +
> +	/* Wait for the interrupt. */
> +	if (!wait_for_completion_timeout(&xspi->c, msecs_to_jiffies(1000)))
> +		err = -ETIMEDOUT;
> +
> +	/* Invoke IP data read, if request is of data read. */
> +	if (!err && op->data.nbytes && op->data.dir == SPI_MEM_DATA_IN)
> +		nxp_xspi_read_rxfifo(xspi, op);
> +
> +	return err;
> +}
...
> +static int nxp_xspi_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct spi_controller *ctlr;
> +	struct nxp_xspi *xspi;
> +	struct resource *res;
> +	int ret, irq;
> +
> +	ctlr = devm_spi_alloc_host(dev, sizeof(*xspi));
> +	if (!ctlr)
> +		return -ENOMEM;
> +
> +	ctlr->mode_bits = SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL |
> +			  SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL;
> +
> +	xspi = spi_controller_get_devdata(ctlr);
> +	xspi->dev = dev;
> +	xspi->devtype_data = device_get_match_data(dev);
> +	if (!xspi->devtype_data)
> +		return -ENODEV;
> +
> +	platform_set_drvdata(pdev, xspi);
> +
> +	/* Find the resources - configuration register address space */
> +	xspi->iobase = devm_platform_ioremap_resource_byname(pdev, "base");
> +	if (IS_ERR(xspi->iobase))
> +		return PTR_ERR(xspi->iobase);
> +
> +	/* Find the resources - controller memory mapped space */
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mmap");
> +	if (!res)
> +		return -ENODEV;
> +
> +	/* Assign memory mapped starting address and mapped size. */
> +	xspi->memmap_phy = res->start;
> +	xspi->memmap_phy_size = resource_size(res);
> +
> +	/* Find the clocks */
> +	xspi->clk = devm_clk_get(dev, "per");
> +	if (IS_ERR(xspi->clk))
> +		return PTR_ERR(xspi->clk);
> +
> +	/* Find the irq */
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return dev_err_probe(dev, irq,  "Failed to get irq source");
> +
> +	pm_runtime_set_autosuspend_delay(dev, XSPI_RPM_TIMEOUT_MS);
> +	pm_runtime_use_autosuspend(dev);
> +	devm_pm_runtime_enable(dev);

need check return value here.

Frank
> +
> +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
> +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable clock");
> +
> +	/* Clear potential interrupt by write xspi errstat */
> +	writel(0xFFFFFFFF, xspi->iobase + XSPI_ERRSTAT);
> +	writel(0xFFFFFFFF, xspi->iobase + XSPI_FR);
> +
> +	nxp_xspi_default_setup(xspi);
> +
> +	ret = devm_request_irq(dev, irq,
> +			nxp_xspi_irq_handler, 0, pdev->name, xspi);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to request irq");
> +
> +	ret = devm_mutex_init(dev, &xspi->lock);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(dev, nxp_xspi_cleanup, xspi);
> +	if (ret)
> +		return ret;
> +
> +	ctlr->bus_num = -1;
> +	ctlr->num_chipselect = NXP_XSPI_MAX_CHIPSELECT;
> +	ctlr->mem_ops = &nxp_xspi_mem_ops;
> +	ctlr->mem_caps = &nxp_xspi_mem_caps;
> +	ctlr->dev.of_node = dev->of_node;
> +
> +	return devm_spi_register_controller(dev, ctlr);
> +}
> +
...
> +MODULE_DESCRIPTION("NXP xSPI Controller Driver");
> +MODULE_AUTHOR("NXP Semiconductor");
> +MODULE_AUTHOR("Haibo Chen <haibo.chen@nxp.com>");
> +MODULE_LICENSE("GPL");
>
> --
> 2.34.1
>

