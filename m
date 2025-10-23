Return-Path: <linux-spi+bounces-10800-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DBDC03DC5
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 01:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D1363B6AF0
	for <lists+linux-spi@lfdr.de>; Thu, 23 Oct 2025 23:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679CC238C3B;
	Thu, 23 Oct 2025 23:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DLN6j8Xn"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011002.outbound.protection.outlook.com [52.101.65.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BB11990D9;
	Thu, 23 Oct 2025 23:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761262577; cv=fail; b=p6bSMM7HFV0B2czQi6GFEILNHTnwQS35puj4CjUmkjVwYkTbrcNarZp4g0OUA5sACberV9Lt7hWb4vWPWLYczLV5gBdr5xRs9ms/Kk48OPdQW2k3rJeMQ0y0VVhfIZkZW54Fj0BiyHCKMFCVA+aLKjq44VeCfoYa9LAKAY/1tnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761262577; c=relaxed/simple;
	bh=XBkweTYUadZ5d6EkdWAfftz8hFCG4oxCEQBn1V5zYGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AgnB2uoAxF+0lhzUdga5Nz/cvXwsz6kBpU9ztwroQTOmo4t3VWGtzwHKhG9MzPXGNJwzWMZAVDhLf1ijRYBytv3K7aBdVeGLjjExkbKJJiB6KUV4kQqzBGpnZiJr/mltQq6BEbj0yxyq0BopedGMjrOB7BRGKU6CHwQ/NVB04hQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DLN6j8Xn; arc=fail smtp.client-ip=52.101.65.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJd6x7zOQaUtEu8OFC3dFaq4XBsM8Ti/uPajgV0jp0ZYcOH9xY7yBCik06SNipXon6gghn7K6Zg17uc1cP81XjUUcmF6lJPVB3XGi7l9UIIChV3vLVvarKLbwiyQWoaytkfzwptK+GVkINGrkbD4FPC/bT5c7G29ey/Re/y5Tm06j69jpq4e3oM3u8FcOov6jKI+JErSshY8G3GG4+DLw4U6yI8zbwkeBx56Zls8FNCZCFugToV69tHVD1uMZ1JlJG02gTauaILQAr+/89AAlB2qs/VyZ/DU4gqkmZi3ecxieKCFdj2V7co7y9WlfeN7fP3QL8w2g8nZtoEWO/4STQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Qibga4nZXSZXFKdrskp2XOaN1bwbob75SHz09h6I9E=;
 b=B/TtU0cdx15G5C4t+L2ken3dxF2IRjyVhOkTXreL17U45RpmNA5rHSljOhXCNcxg1pTCLHtaIyWCePaBp1hk/C4ap8xXHyU5IlklEKa0XLZffr02PCrzwHzBd5aPqfNJQJQwrMlHY7SMAEIr9FwvD96w/Wqq2JCML66N7SdmNEUOugN62vhpQ/igBYMP/k+o2lRG7y6VZ6RZZtbH0vHYRObfNGoKmF+NLX7IsBOGusdUmg4fnJYaYLbYizbwr5doAI9y7QLlxpkWp2IfainyoipXdyxksyDif2erwmFFnaP6Eqw2zltHVq2UVWwhkajQVPgEHP6SEREicsw9eOff2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Qibga4nZXSZXFKdrskp2XOaN1bwbob75SHz09h6I9E=;
 b=DLN6j8XnXlStH/jBIC1IcHy0MkOSS2likRyLEQsu+J0gxYY4na2XfTM2wmXwcXpedLqoXiae62/tDlv792XPVXoPa/fAhSrT1pfqWSldw/hDRfxM/tUofPjPfcygp6n7nea47/c+Dt/XxxM+SAQRc5cbs1suC3qMJa9VthUlBX/nff0VGpwNIwqut1b0xLJr/Rrmo5jEzYVW3Cn082xKtYTqW0cqq8ClDuxccT3waC8UZowct70/5cNZzV909g2HbGOT5AgLYOU4iohsIurwyTRoh6a313M8tZYxaYmOvce+SgZxglXc1M880EavepaXIu06/aNlvOS0PoAjWN9LIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM7PR04MB6806.eurprd04.prod.outlook.com (2603:10a6:20b:103::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 23:36:12 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 23:36:12 +0000
Date: Thu, 23 Oct 2025 19:36:04 -0400
From: Frank Li <Frank.li@nxp.com>
To: Alex Elder <elder@riscstar.com>
Cc: han.xu@nxp.com, broonie@kernel.org, dlan@gentoo.org,
	guodong@riscstar.com, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/9] spi: fsl-qspi: add a clock disable quirk
Message-ID: <aPq75FBuYvFQrbQE@lizhi-Precision-Tower-5810>
References: <20251023175922.528868-1-elder@riscstar.com>
 <20251023175922.528868-6-elder@riscstar.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023175922.528868-6-elder@riscstar.com>
X-ClientProxiedBy: SJ0PR03CA0155.namprd03.prod.outlook.com
 (2603:10b6:a03:338::10) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM7PR04MB6806:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e8d8fd2-a259-4a64-dc45-08de128cf335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6/ulb/U8ZNR158wFY9PkoE4H2stXgB4xEBtiDoGYnwLwjJE2OZWYhwHuhMFE?=
 =?us-ascii?Q?Ak321RMpeWpX0yOiBCAqukLSM10V4G/WP3wTj9voT1MG3PRNG4vM73iQGeDX?=
 =?us-ascii?Q?pWA6hhlYnp3HK4ekHZsGhxuxq7n6C2R59lGGf0vne6Px0Ths2H6YvtMFj/IA?=
 =?us-ascii?Q?5LOvrfojbPWR6EH7wUHb+nwjFlMQaJ5fGuY3PoqgVAM/pIPZ36dM+n5rT+Mq?=
 =?us-ascii?Q?HUqilOg+4qbRrJ90YOLyKYjgGZkLQDKf/CAWnKPa7XGF79ugJKSqMbCRYiFv?=
 =?us-ascii?Q?I+J39jvoZ4jJzLQdCyA3iQU2fQHEJGgAxZDnAcLsaeHypjIINXxUrhqqqSf9?=
 =?us-ascii?Q?+UeVOkRLl52Jq4f5XDWmK0CXfixzjyIkIFC5e0VUUVLwKKBtypfSvvzEkyA6?=
 =?us-ascii?Q?Vy1UHDrGYJoICYU9upyBNA23VYedKFtFyqP472ZYBfLOdylf6Y2n/SWFxiQe?=
 =?us-ascii?Q?DlDnAtkEkJuhZfepgqzTeYqSraz1EqbvpitbDN6xRa9I96vDzGwMzVGztIjs?=
 =?us-ascii?Q?lLQFbhYxbSDBalQbsrHujljQNPqJjJc9zg1iavIU4IP4/DIKqHlidR1INhr8?=
 =?us-ascii?Q?Un8V+OewmJa0UIUTCadXiycLs9Qi36B5zF9P8L0Wr95mKLI1sCVMWxdxnGgF?=
 =?us-ascii?Q?MTWttorKsLYSKXwQ27U7Cq7Ahg8M6VUGNLebkngo97Xqr7riao3iCewKtle4?=
 =?us-ascii?Q?uN1AlUrvjMD+srun/V1dpEeOKizHuqd4Q1/OJynDuZMPC7pcHWZ+n1bST+A2?=
 =?us-ascii?Q?r2Ywm8LY7SnpBN7n2XvjHZV3ZzZ9ucrMfmlsd/XZEDiy26jS1dbgWLQVO72U?=
 =?us-ascii?Q?mG/NjQHMkA0d6crOU9L2SffBpTAPRoAdA+d8sC/zdzeFBU+lHR9Zqna6Lib1?=
 =?us-ascii?Q?lgE9aTsExXDK9BhnlxhI/FFXbHSkaGlyaYKGjyUnNdVTvR82iPDAtZ7NwtyK?=
 =?us-ascii?Q?u8GLrNBwEV6HtGubAnOXdr++alLgvJt8ZdcaKCFvxH5Vd92WvWweGGGhHTTo?=
 =?us-ascii?Q?OMlfmnbU5biu1eLBW5mTFjr9hxeuB1KfF+nZ9OeTic/0CWPQuQqNSARBXrNI?=
 =?us-ascii?Q?D42aGFMxqyxrUwUMvxZ/KwGYb9jAKxJFZgGeFC5ighkvXKqBvsRSfr/HFwUD?=
 =?us-ascii?Q?CnhjDtvwN5yqAN87M2pVna01+HhEtsGJK+CZHy8xm2GTffgqVUQVQBYR5YmQ?=
 =?us-ascii?Q?mdzdIAf7pJYzeKwHBsTGFckDDpffFLRktiUw0gGu+jbS+3piuG4nrWDiX0Tp?=
 =?us-ascii?Q?1k+7t21eeGuw4dSrlotdvTyMnhawWDDBI6HvphnyjFOrbKR+aLe+ypjSL+dU?=
 =?us-ascii?Q?RBc5X6f3X8O8jDjV3sqMG5YP7ieYAz2ni4vtcvFEMAa8V+YpZfst1wHT11NN?=
 =?us-ascii?Q?t9DlsaHH7SFlE7qrTOOTUazttcUCa9JnLeOEvFIiTmJM/m6Mq+Z/76nhinw3?=
 =?us-ascii?Q?3EH3GEtB+tvA08dQT45z7La4Fo7MlLsqxsdZ5BiZ+9KrgOtn+6Rqo+Kd35py?=
 =?us-ascii?Q?crRiGX9qGhoC5KOEp5cl0l6tbR5tmkNEEz/m?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1j5tOLwRjUYhIRWTm5vLlaVeF+LLhN9Eltr/JPlnPOvQFvm3OLxHAIhRjZjw?=
 =?us-ascii?Q?uGAABPLCjVzWLA/EDrbKxMLu7BKG5hABwGf3Qi6yOKH9xL/TmvOS/bAMqEbw?=
 =?us-ascii?Q?nC7AJgE4RtjKAqPRwg9ynsNp3NqfDBbZ801pgygM71pSOpKuHrvQzKtOe2tT?=
 =?us-ascii?Q?6OezhXRYKk+26afJL0ADDqC27evnn8DTmTtv8sp+g53btfsRWzqSjxxaqrtF?=
 =?us-ascii?Q?X/yhPy80Bs69v7/EKkjMcPrhRyXgoZ2vMN+sWJ3tZnupXJ0qhlDx3Ll8+QkI?=
 =?us-ascii?Q?cU6cQHs+ZO2QS7TrAPvJxHD8nP0Mpx+ZwE4owbQt48TVcibSlIb2qvovxaDH?=
 =?us-ascii?Q?0JMevDRN1lH89rCIKnuGvVFso/o1sOaRerfWUb7Uj5wYfpa7I04fro/JsU/w?=
 =?us-ascii?Q?i/j+au3FxP0ckmv3GvL8inXWczOteSobhqFJ/GJRLciB9kXvR1yP5qyLVDbz?=
 =?us-ascii?Q?EcimST5ZmeSKK7gYrzGtK/9M1MpuyoA85HBLOqRQOADF5+FB5U2VHl+3Iu1X?=
 =?us-ascii?Q?lmmfIX+4roZKWy2o/D5t8bOmwO59ZarTJeDoQJFs0gmykWK9brLFOMMciUFI?=
 =?us-ascii?Q?7dmLP5cv8DGXlXSJVpJPxaENE74xy0eeZ9KNsaXH3qG0QF9cX5cu29uZ4G/K?=
 =?us-ascii?Q?1DvviO6M9qE0UqV/pQncQLTAlI/Xw26gjoejk2AjlQPr8e0lJuVcC/qodDkB?=
 =?us-ascii?Q?dmNJi7B7XWPhJ/roYvxVsVv7DPLuXShctY4l4DtQekGFRAon71PQTgohh8gs?=
 =?us-ascii?Q?bhzFXSgxFg6TtPqqaPS0aKi3n7RHJUlRtsKTFDUVi6wJJPWUdCd+dvoDfG+b?=
 =?us-ascii?Q?kX25p/odAMT4wCFSLMLFYrMxLpeRqvpnc0xX2j9hPpE9yjB6/zjleXSPc30b?=
 =?us-ascii?Q?Cq5IWysZCxzLdu+QMEmVGVFQCZ4Oja3uk67CXAAttlW5UuZ4b+a6lwNKtFuh?=
 =?us-ascii?Q?w+B8B4ggrmgx27q0qVyP3/J0hOflwDfp4MoNW1msU3Sg1T9mSrY8ho2SzwXx?=
 =?us-ascii?Q?hlLba+4Yj8wdYZkycRI6vQAblHtp5ORONT0frhstoiYO+ygXcCNDQplnc8nq?=
 =?us-ascii?Q?3vXqEAyMN36lNvqWBa3CXbYzTZwyuPaFfDy8/lqlyhH2lLQB3JqIeoQZALaI?=
 =?us-ascii?Q?WVdEwKMOxb7inL7RZzXmnLRJryIMwUDtaPeVSqdQGDWkCCppKUkicz2M4L+D?=
 =?us-ascii?Q?63SO9HrpXGGBDYaQF4VqbHwAv/laZBNxzi1gGs7uELtS9GaD2AiVcVCLzrHH?=
 =?us-ascii?Q?uDjTZpflBYxxFFwm66mg/29UctAg2dE1vA/Mb/N8XpNC7BJq9ImBjSDrzqTT?=
 =?us-ascii?Q?w3WQZqYufkWolqy/qD8ljLse9lyVMpwIpu3hZRuaYgAiGrLuV5vJh4HU/WKk?=
 =?us-ascii?Q?nglaB81rEbNwdPatKaoFBaOfpAADmE/w5gZsP6v9/IUs2+4FjhBsnvefes2Y?=
 =?us-ascii?Q?C6Vjo4O2S1fMYP+1GTlYtZyLfYUuwrTR/ZrsDMnubiEyDODOowmuppEt22pL?=
 =?us-ascii?Q?Go/AEuiSoOavPRrM4enMGfjmOep4vlVrCO+sQzmXWUwxWzfeX6TV8ihSWPne?=
 =?us-ascii?Q?KbOdE5Wz0Cf/EjHZu81EkOIjpfmgjHhhgzYo0jQ/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8d8fd2-a259-4a64-dc45-08de128cf335
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 23:36:11.9870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9AJrfWs5isA3Jz5fejOm7+cTYDkr1VaTJzdAoO8JZXOEfRjuifUYGTzPDWO1l5qezyD2bipRotMzW+QXHPRPZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6806

On Thu, Oct 23, 2025 at 12:59:17PM -0500, Alex Elder wrote:
> The SpacemiT K1 SoC QSPI implementation needs to avoid shutting off the
> clock when changing its rate.  Add a new quirk to indicate that disabling
> and enabling the clock should be skipped when changing its rate for
> operations.

remove "for operations."

>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
> v2: - The quirk flag is now named QUADSPI_QUIRK_SKIP_CLK_DISABLE
>     - The predicate now returns bool and is not inline
>
>  drivers/spi/spi-fsl-qspi.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
> index 1944e63169d36..c21e3804cb032 100644
> --- a/drivers/spi/spi-fsl-qspi.c
> +++ b/drivers/spi/spi-fsl-qspi.c
> @@ -197,6 +197,11 @@
>   */
>  #define QUADSPI_QUIRK_USE_TDH_SETTING	BIT(5)
>
> +/*
> + * Do not disable the "qspi" clock when changing its rate.
> + */
> +#define QUADSPI_QUIRK_SKIP_CLK_DISABLE	BIT(6)
> +
>  struct fsl_qspi_devtype_data {
>  	unsigned int rxfifo;
>  	unsigned int txfifo;
> @@ -306,6 +311,11 @@ static bool needs_tdh_setting(struct fsl_qspi *q)
>  	return !!(q->devtype_data->quirks & QUADSPI_QUIRK_USE_TDH_SETTING);
>  }
>
> +static inline bool needs_clk_disable(struct fsl_qspi *q)

needs_skip_clk_disable()

Frank
> +{
> +	return !(q->devtype_data->quirks & QUADSPI_QUIRK_SKIP_CLK_DISABLE);
> +}
> +
>  /*
>   * An IC bug makes it necessary to rearrange the 32-bit data.
>   * Later chips, such as IMX6SLX, have fixed this bug.
> @@ -536,15 +546,18 @@ static void fsl_qspi_select_mem(struct fsl_qspi *q, struct spi_device *spi,
>  	if (needs_4x_clock(q))
>  		rate *= 4;
>
> -	fsl_qspi_clk_disable_unprep(q);
> +	if (needs_clk_disable(q))
> +		fsl_qspi_clk_disable_unprep(q);
>
>  	ret = clk_set_rate(q->clk, rate);
>  	if (ret)
>  		return;
>
> -	ret = fsl_qspi_clk_prep_enable(q);
> -	if (ret)
> -		return;
> +	if (needs_clk_disable(q)) {
> +		ret = fsl_qspi_clk_prep_enable(q);
> +		if (ret)
> +			return;
> +	}
>
>  	q->selected = spi_get_chipselect(spi, 0);
>
> --
> 2.43.0
>

