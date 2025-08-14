Return-Path: <linux-spi+bounces-9436-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4516B26EC2
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 20:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 764D41B66865
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 18:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A91220487E;
	Thu, 14 Aug 2025 18:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hcKpngq2"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013054.outbound.protection.outlook.com [52.101.72.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1A3319856;
	Thu, 14 Aug 2025 18:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755195605; cv=fail; b=Mg5LeedsEBLRglSZlVi5Rwr/phhtSAudNryMgrG9hB63Gdh7EcBN0m3PnHHOwyxcI2xC13iGBl1aL8LB5RT03FpruoGkDkfyiRR4TZyhLm6I5dmpX0b4U6Lcnf2vW2s82i4AQDBhO1Wsbq5sYh7Q6rxyXyhOlXu5BwCrXRSU9As=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755195605; c=relaxed/simple;
	bh=/k8+/Xj5Jw4JeQzy1xVtCjUSneslW06JuDM9vhjA6R8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OxL5oeazcvMgL1ejP9L3uRw5mHNQh/bRwIc12e5gjmj8cGEtst3GAPx2AXBkWOuFFxews2+D3NNFI/Qr+me+bkC2DqgJENdAXWABSsxPoT/s9PLIqnZ3EP4NWsMwX/cVAWfZfkVys5fJaz/Cd7cIJmMLo899yIGZCZ55dNHsrk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hcKpngq2; arc=fail smtp.client-ip=52.101.72.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXu5KG6exaJLQFtqY6l5mI+GbYQoP5HYG1ggW2tS4FTcYBLcJqAGngc8ah9KIQFHAIG3rjbI0KZOLUA0tT0tjWbpCUZPwzDl/6ZRxUOiGnTZ52XSW5f4Bmc7PauYc+i3+InSDNrOj9VjD6yctc+yd25q9MwWR1Etl8AwV+TFaF906Ab/Zbu3CovFtqflDlF+vbniVWXv7wQ9ViJqMTSszFgcI0Hjw7/HK2NqDSDtdGHLX9J8BaAqOgDgRZh3W09h75ctCe8A+T/E7HNjV+/kQyYqHHzyiVrincMVr3eC64hBiY+fGC6J4ogHpGI7RV1vWiB5dJ2iii7i/vT3gk2IyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHseWNmEmJe66vQMhQWRsXI+Sml5jCIj7pw9NbWn5wo=;
 b=DawuN1B73q/WL1zTFDhY6Fxp3G4KNI02vLleqhRpheBj6Ufd+MvJXHVfKrrQmSM/Jpf8jQXUFJjYNzNRLg1himLZqGM8PgTY7WhH6hQw2ZESVnofCS6Xm3QGqFKTkemVGYTdclGzWISca8Mi2v9rk0KeDaOgL+xccHl7KWfKvUJghlDXy9qiuKBaY7weBrcQEAVGza4X6V47bIRQSj4knkBGIQSnevRR9SBvYPd7u83sk4f+qYVFHhqlfg7SfcGuCg2a1lMyDTpkUlMVA4EdX3/bVw0997Az1hywMQ62nG+9wJzH2N2Ev+WqPqkAmVSwtNIty9X+9Jh6AS3YhR24Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHseWNmEmJe66vQMhQWRsXI+Sml5jCIj7pw9NbWn5wo=;
 b=hcKpngq2n1o32mk+KFd2MXsByIspSvtYIQuNNipYJxFT6SwHL0btkzpmKechnShPkupQYzgAV+aOBfQxHmTkwF8KIKV5eNgUZsLXHkXoVJqppj4atU8sB7SE6WK6S4XNHu89Gm4pf2ePjR+qQarKV41Gqsyq29+48nwPXcXEE8y+GTrAmaXUJ8Gzh338XIsfCN21myPl0zYyWrPXg9eYAC4AZxzkrfJOneE9NPlCEKscwoBxUHupX8XpDrwAeDwEt6L2EU8F3l+L4fTUGi/8d4BBPo4rzi4dlOJeAHFGWdn23ZXBF4bF1RnuYBqsDI+B2hPubKBcWFArC0Kk9JzA7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7423.eurprd04.prod.outlook.com (2603:10a6:800:1a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Thu, 14 Aug
 2025 18:19:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 18:19:59 +0000
Date: Thu, 14 Aug 2025 14:19:51 -0400
From: Frank Li <Frank.li@nxp.com>
To: James Clark <james.clark@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Clark Wang <xiaoning.wang@nxp.com>,
	Fugang Duan <B38611@freescale.com>, Gao Pan <pandy.gao@nxp.com>,
	Fugang Duan <fugang.duan@nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Larisa Grigore <larisa.grigore@oss.nxp.com>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
	Ciprianmarian Costea <ciprianmarian.costea@nxp.com>, s32@nxp.com,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 12/13] dt-bindings: lpspi: Document nxp,lpspi-pincfg
 property
Message-ID: <aJ4ox8+OLhIir2bU@lizhi-Precision-Tower-5810>
References: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
 <20250814-james-nxp-lpspi-v1-12-9586d7815d14@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814-james-nxp-lpspi-v1-12-9586d7815d14@linaro.org>
X-ClientProxiedBy: PH7P220CA0161.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:33b::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7423:EE_
X-MS-Office365-Filtering-Correlation-Id: 47f7b9a5-17b2-4cd0-d00f-08dddb5f2df5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|19092799006|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eE9/8F+Q+2DSGf6FZ5h+QbfeZh112mihC5LbqV16TPWymXowI8gmHQkU2+b6?=
 =?us-ascii?Q?ULjDshlB5BK8Hl4bftdWe3iLnnUJPNt0ZsuzQrXtoLpF3h/t24ciPk+mdPfx?=
 =?us-ascii?Q?qQBx2wyu+YZ5dtd9PcCFBKCsGTN8j4mI3+F9LkzZ0GhWljM59QNtnhseih+Z?=
 =?us-ascii?Q?ItrLT7qoFwW6+tn+dvceH0gIeXJAxfrgxFW61BSRXJqyUIcyToM4ZFHm7QhK?=
 =?us-ascii?Q?DeINjUA9pS6zpXRF0+rDc8odmBUf5m+990OVKgDa+Ez8y6xMC5Lr6rCavevD?=
 =?us-ascii?Q?SsWdmwMbZOyulymtSGL7uCwgk7r7zC3+u7i1TT2fNbHVBt5VO3xGV8FRYelm?=
 =?us-ascii?Q?AFyXBz018lmLDHNwFOj1X5srob4noEDB0GH0zMFxyDdFx0HmLUm+VlSzFDQy?=
 =?us-ascii?Q?iEnWmebB+aadblucT2dde48Cc4W9SVcBgwjMGJp2BHjZd/FnBi23E7Q593XJ?=
 =?us-ascii?Q?do4bhvGKoX3YxH+4xVYy+x6+jSZ47lX10YBYZH1rpumvaLs45Lk3aaDJ8vBl?=
 =?us-ascii?Q?XYiZKEV1Cz005NAz/3Z6RtCXYqegd0XLnKCFhIH581VZb68RlOWrZNnpXtVw?=
 =?us-ascii?Q?F61L5Lm/pNjLfTOfLmy27H6rWyKD67qbDmMegbegNnHYHaESxVGfFIo/hKMa?=
 =?us-ascii?Q?ytS4KTM+I+yEHPBLiOJk2VrfCQfbhqKY4rovlFY9sQHYg4xIAoi0IOsEFVmJ?=
 =?us-ascii?Q?KtF00ePCehwmBWsiOMS8VoifLIMDpnt91wvINmI1HxsOJiMosXk/GJbQA5e7?=
 =?us-ascii?Q?+RyCwvu5AuWgTVKugsYA8jzVXS3cdTc9g8RSdAdkTQgA8XW91SpjjS8x/Rw1?=
 =?us-ascii?Q?fnqhFYBEN6QHmDbRAdmf5XKQLYnhr7rgpQMU/EE1CpKMogx5HkuH79EPBRSf?=
 =?us-ascii?Q?fGDGNzc0K83emMyV1Gim8MSyJSDFW8DiY0Bs+C8U8mVjvKO8ETMPMQhbc0Lj?=
 =?us-ascii?Q?8P+fLMus9q03oy6tjlLSMZmtX450MuHDLpyi3HQpjj+Etnrh6O11af6wCX6/?=
 =?us-ascii?Q?teAIatq0ZTRjsnS3Hf/nyIsqGqTnUftTgWIBBlmOgUuUGhItzIbpf3NoLkyi?=
 =?us-ascii?Q?zWcyFfaKbndhG4prXv9+vEBxMVQNEHeijeC5r1u959c2mhdcVlskXooUOoN0?=
 =?us-ascii?Q?A/GxGt6B1gNPnvsmfMu9espmJKjiY78SpggmW/LYNcZLKFv9wEpzihxIXpTb?=
 =?us-ascii?Q?fHOdIe4+Scjz8PMeZcfa5uFD8AxyiOJ7f/4IhM76TMlDkviWVQ7X+AfLsCfj?=
 =?us-ascii?Q?OYkSZEcSf7S+r6jYxGUYEEYBlPw0/tcea2IJhIx8gnhsb23WWNkDmQaxjjLc?=
 =?us-ascii?Q?jfh5Q7VR2j4vz2HrESr3RMJPT8j0ZyTh5OIpGCC0fvUmR+x93vgOUULqlMxR?=
 =?us-ascii?Q?LqqFf2UNK5+lWXgfw3yAPdg/DxHshY4aAiq2qwirtyseBgAXaVLAgoLgZF2S?=
 =?us-ascii?Q?UUC8fHaY8cRnIP/zCMbtN3J5v9KgvlHT9RUijScB8Xq5mseqCr3kdw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(19092799006)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KLzwJigFyBMGBn1xIvxEu4JyEeBu2OmvD0QXuDim60QSVnYNz0NgU5YVYQhw?=
 =?us-ascii?Q?dTh0j7ktzvKqje18mUgD3PVaRE6RmdQXRpi4htDP74G+L5bMk7BTXbjXq+hF?=
 =?us-ascii?Q?bVbMrWgzhNnAgkl5eyYd1tleS/mkINCFYqyZveS2qIBevgLd3ay3YgmT5uuh?=
 =?us-ascii?Q?bquNHq9VSs2Wiuk4rxztqrMqjT/ifE9C7tU3dpiMqndrycKz8rs5B+gnM88u?=
 =?us-ascii?Q?CPRAB9gWcEiHCOpUaUVq/yn1bJtXLCV0GGLHFD0b1SPwasWnySfPFYFTotpg?=
 =?us-ascii?Q?v6MCMB2ArLz2Pm70vuaFojpSDN8d3GhGfmeAJC30D/ftkWl9RR/xtPWqC3Ww?=
 =?us-ascii?Q?yCDajRjCcTVwuWeKP0uvJookO7EzEL0zUckhX9BKhwoHnymFO8ynWV0HgaS3?=
 =?us-ascii?Q?1BawbgbfBMthSXv5zQjHkGTvxwa0JfbpFpYd1nO7bZO6kJoeKRZE9NEs0woC?=
 =?us-ascii?Q?FWMH1G3BxwaPiZgjHRmvtw/mB0dbZoc8wodz1GpHpSTGWK/CDPgqUJIQcBXT?=
 =?us-ascii?Q?EosxCxiRSe2jR7FB3hPuRedbX42D2JlHSal3u/SKa+cc7KOpXIOUx/LdL5o9?=
 =?us-ascii?Q?vMldO0eMvbOz/i1qRWn2Jsu5cKD91i8q59zRT83JhX12plIO7AZh5yYGTEhz?=
 =?us-ascii?Q?ZXzW3bI7ZNOU986AdaORsJOZuYY2dG13mWWJXPM9RQ7/y5u/rR/SDMIDatGM?=
 =?us-ascii?Q?S6Jikey65gOdVNV6swfHqGossXM7aNhIxPH2tmgOl4UsX2paLt5ZOJfyLVvj?=
 =?us-ascii?Q?sBNB8gL7w5ikSZNDljLwRx/lEXEfMgReL8SpERulx9W08ruvOPHMrBslqtTH?=
 =?us-ascii?Q?DT4LErIifrPw58p9km0BjSywnB113CGAsTZ1gUkdfhuk9nhK5GtwQwapjdSc?=
 =?us-ascii?Q?gMWhaK07NXxgDGiE8fe9UY991kaqBkkgfWsmbPy+dG/w4gcDLztB4aQBmowI?=
 =?us-ascii?Q?4T7sspJDdQXFEBFpw3QjrRGHn0qxjR6R3XvZhJ9ScCYJr973eoTVm9xpR57/?=
 =?us-ascii?Q?GoAQ4ruBTeED894C/lksdycpDXzgebowO4TixOMAchl4ERmQeoeSF4M2d9Qj?=
 =?us-ascii?Q?eFalmrt93wdRSVVO0jM2Wl+O9t6t+yMncggcPRNsEyM4sUgT/c6U7Z6ybo/5?=
 =?us-ascii?Q?GMesuMY1ziM68phsp134cCBLdNrE1i717rF7i78VUpRXRGbBn9U3vfIfGE1v?=
 =?us-ascii?Q?2bOWyTTKXqlB9jfYI5alI4dxM3u5LAyugDQH/jRgTVExTCB5gwL9Bb5/bFTA?=
 =?us-ascii?Q?7WHLEB6B4zS/3dQzRr91SX798/USRJzX9okPTJP9MLcyewCCt+WInE1uMQMu?=
 =?us-ascii?Q?RQCI7IEdk7iQ6ZhKVh41LyyT0pVt+YgzSOMvoWoKaq/zJWvJKdAMNnTNUrQ6?=
 =?us-ascii?Q?AIA3+T+YJKO0PAfEGz1CTgCz4Shk3dZhDcsvFcC+9w/lkSVvX5yKpkndKA5r?=
 =?us-ascii?Q?/9g8RAL3J8OpL2VtDfooht27/C/6mfxtoRnI5hCX7yYH1qIZna2Z8pvfK+qi?=
 =?us-ascii?Q?e11Oy553EUS1vD5lvVYRCwXV+UEEc5X+6Wvb/Mx9xDaocL9E4kidIq9PgBeR?=
 =?us-ascii?Q?6JFLyD4WUTIzR0GCUkA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47f7b9a5-17b2-4cd0-d00f-08dddb5f2df5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 18:19:59.7865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vQfLTgxyu/CQRWnIH6OwwZ4ot92sPqpZjRU2NfPa+VJyH+DE+8C9AXMy1QiZ6C7odqAOLrgd+JFsL1YA0ulDPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7423

On Thu, Aug 14, 2025 at 05:06:52PM +0100, James Clark wrote:
> Document the two valid pincfg values and the defaults.
>
> Although the hardware supports two more values for half-duplex modes,
> the driver doesn't support them so don't document them.

binding doc should be first patch before drivers.

binding descript hardware not driver, you should add all regardless if
driver support it.

>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
> index ce7bd44ee17e..3f8833911807 100644
> --- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
> @@ -70,6 +70,19 @@ properties:
>    power-domains:
>      maxItems: 1
>
> +  nxp,pincfg:
> +    description:
> +      'Pin configuration value for CFGR1.PINCFG.
> +        - "sin-in-sout-out": SIN is used for input data and SOUT is used for
> +                             output data
> +        - "sout-in-sin-out": SOUT is used for input data and SIN is used for
> +                             output data
> +      If no value is specified then the default is "sin-in-sout-out" for host
> +      mode and "sout-in-sin-out" for target mode.'

why need this? are there varible at difference boards? look like default
is more make sense.

SPI signal name is MOSI and MISO

Frank

> +    enum:
> +      - sin-in-sout-out
> +      - sout-in-sin-out
> +
>  required:
>    - compatible
>    - reg
> @@ -95,4 +108,5 @@ examples:
>          spi-slave;
>          fsl,spi-only-use-cs1-sel;
>          num-cs = <2>;
> +        nxp,pincfg = "sout-in-sin-out";
>      };
>
> --
> 2.34.1
>

