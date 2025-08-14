Return-Path: <linux-spi+bounces-9433-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 156CEB26CFD
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 18:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A78ABA26754
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 16:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B271F12E9;
	Thu, 14 Aug 2025 16:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hns35k1Z"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010042.outbound.protection.outlook.com [52.101.69.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFAB200BAE;
	Thu, 14 Aug 2025 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755190319; cv=fail; b=Ks5PX2W/xr6oohber5j+TIefFr51/sPl5wDk7vCdBmcoQrGO2bNYMles8XKOJDSA6XaTEv+whGGIUJ6ybvVhZyKOJIvIf388AUa1Ps2UJA9mXRvtJEXgY6GHSLNCVWC0YO7X5F3y6EscEyLzixaf2t5cMOfbEDYdyL7lp9eMoC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755190319; c=relaxed/simple;
	bh=/BTWX7U44gB0s3j+bOy22QOwr4YkW/RfIuVfKUZPnE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ng6Wb5HAkBHW+e5iO1W9luuYIdVAK7noc+MHh1qUfP5usIAvMDojMa3kB7sTbh7kj9HjAosvVZbrC7UViZwsorqp9uYz2DO74V/XN2Kg7mgWtv0uw5L8q/ulJ+z7CwsM55Tdhh1YzJTtT/wN7URFHiLucj9L2fAa3iMpbHQ064E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hns35k1Z; arc=fail smtp.client-ip=52.101.69.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZcqNJtZww2Cx8jKZTynorxm7ySBEaI4FrvhVRTeXBy/o2ZWX/Au/GHHldwD6yAne5muxn6lN0aMOms9My8yeZ51QPYI93R1ZQSO3h6F77iwbRKeLiDBrLeC8tQOYf12IszI2DCIrm0b9xm8IxEOCkiT1PxcewAVfbLo213D+ViIOMWqGVd/glbtDdPzKL8c+0XbbsXSfoROisily2DdwRiOI/QtSd4Bwv+ZHlogDAii009wDGpNjSiLxFJbePS/H8l+Fs7R0Aimm34u3ClyJ/kl2WT75VXutQqtd/3AGLvvW2dTmR4+vTnL8WefHw/Ot1bLK1xWCweLx9QFosVUGaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntzgU3CDjThG+CZhaVESWYWQsu7W1ZF5GRZ+p6aKktY=;
 b=lMU3fHivMgEizABIYGrzK9wIKy4MBV/MOUH1rlJ5EgQkzas0O8EGDD1ihPqWFuT34cdUi0Pg0Yojbhs3yAxS3xgddAWQINhdh7gDfPMAT31O64sB69R5FsH9XR/3CQZLqEcwXUPOZxcVmoc1cB/v/BfdLMGNyALTC40LjDB1Xc532k6IoYAoAHToTI55uTLZd82aNHwaHzPLMZZPdzdDaUCdtj/O2kWXcDtHxH0KC9ZIW65o6FsjM4AYJ29wj3r6k/AmMxacBohMm8KIl/HNdB+czykS8IFBxKwVYPc8SkphO+fWUZJbzhfwQWCfgWa2C82cRq3Vp/C9q2odkW05yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntzgU3CDjThG+CZhaVESWYWQsu7W1ZF5GRZ+p6aKktY=;
 b=hns35k1ZkngGDeg0DQGbDbYI1XrdXRqI6zU9KGZyfdpbFY8Vcn6lsaKbNcJBfB0jCpno8+zRmb07Y/gvQn08pApiOxHeaU8ZRuascVMqpIcjY9t4rK+vjUImcOHA7DC7T9ldTqzFnPXaX9DJozgSPTdB50LBFyQUsrgIvvCXEI2rZNOb7JTYaVTiVedhMd3flE2nTqhwufp7yu2lsqXq/m+/cxdNh80TIpD5S1c/+sxNs8HvIEUHroz9RNxxkmksbpzde+VPig7piLj+Z5GFG/o/5B+wLiWe5O4O3/dyLuhwVKIM/saOqbiaeCpofiGZlysHK1N7Wytq10AVoCEX2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU6PR04MB11208.eurprd04.prod.outlook.com (2603:10a6:10:5c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Thu, 14 Aug
 2025 16:51:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 16:51:53 +0000
Date: Thu, 14 Aug 2025 12:51:43 -0400
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
Subject: Re: [PATCH 03/13] spi: spi-fsl-lpspi: Reset FIFO and disable module
 on transfer abort
Message-ID: <aJ4UH8fSWGODwnmO@lizhi-Precision-Tower-5810>
References: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
 <20250814-james-nxp-lpspi-v1-3-9586d7815d14@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814-james-nxp-lpspi-v1-3-9586d7815d14@linaro.org>
X-ClientProxiedBy: PH7PR17CA0037.namprd17.prod.outlook.com
 (2603:10b6:510:323::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU6PR04MB11208:EE_
X-MS-Office365-Filtering-Correlation-Id: e1c38746-17bc-48bf-25f3-08dddb52df20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|7416014|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?md/bYivxSfNzedknnPUZNlB16f99KMNqQhPsBUunCL0lfXXrciMPmAXktIYx?=
 =?us-ascii?Q?fW+4LdEtPjiXAgfqYabvxhHEaNcBwQGXmseSXM5Ehp7DhMPOIYh3FJwPI7c5?=
 =?us-ascii?Q?gQZn8czp2DKIzE1gCuY+qehP+NfB2Cf19+W+4/0WJwmRCDqK7hc/CXzSUxZ5?=
 =?us-ascii?Q?ZF0U/2GTovFVJrxaLoaOOLQoPvHyc2rOUUZBeGW4LMfvByusQV3Z+snAf7v9?=
 =?us-ascii?Q?TZMiRxCQGin8RB6K363CAIN8a1mt+2URYoRozJjQq3iUSvvUuEmnw4c6YEbb?=
 =?us-ascii?Q?bXH8kxFoMs/iQNiFYYNSWQabiaOeFqkKkKkWAOhZ7r2wVkHiLiuEa9Iq7uWv?=
 =?us-ascii?Q?fLdAgUpakg+XDEtrrZCq8EDqV3Wq1VOJz0wF6TfibPDvp756+8i7Lls44kYW?=
 =?us-ascii?Q?ATdGnWYy2dBdm18dmZY/UVOYfNxSc/HDMCioL8g+wtGNd9oQ+/GOcQ4JA4ts?=
 =?us-ascii?Q?Tzy0HphpX/Ru0bh8E9+aploMuE1b+AxCpikiw9XQ0yD7HkI5jEMZM3PFH/Xi?=
 =?us-ascii?Q?u71ZzyCM03IlmFWnxbJDriuKst+xZxBuONffobvlJO0vdjojesuHoPkAXIGe?=
 =?us-ascii?Q?HWjxOtTCpCW/6HZ4NyICQNkTKpbw99xqwtcK/oX3C8V/oI0i2mjOCxj5ReoD?=
 =?us-ascii?Q?O5gwSzawcxoWoMyFucV2+yQkyBcltBFno85hJhiOM0olmu4Nv7WYsw2aKrA7?=
 =?us-ascii?Q?Rk8e+TrgPrpTWm+2txvRDpUB7xF6qpO3S1vQSJU1Hij7Hew2qWrDGyYfAxB6?=
 =?us-ascii?Q?NOVih3Ikgc7PfKv3sZkNT97VvSfVHTYat/RZEJeqW8hyVT5aeclz+xFLF2re?=
 =?us-ascii?Q?0kxOaJY362cN7owfmyUMpdxgq3rp0vXf8nucxCnDGemnurRm4QCsqowdpVvc?=
 =?us-ascii?Q?Al5Sj9y9PYhk+wRwbKnA1MCJ2cOw2NamdMOPRDh0tQpN38o3ZxXl1jhDy2fa?=
 =?us-ascii?Q?+rTRnB9GJs8eO+DfLh8lHGKhbC+gi1lh//ijAvlw89clyVuC79d0TSsnqOk5?=
 =?us-ascii?Q?Fzh9KnvUnIS2oYjqrFD52jrGfqoofeJ2yR2gZp+9Fwv+ZQ0OBrvLAzyvfOxr?=
 =?us-ascii?Q?0kLbfRDhZpZ4w1V/CXpunuJFcfnZBo8zmO8augCiYupOmOXygsDblgJgzn4j?=
 =?us-ascii?Q?HRPItVJ5TTyXTzCrlX7gT6vX3t//TTO3HX/pkta255AlWv52uXu34xXrWXUL?=
 =?us-ascii?Q?1fwZluRC/Pxaa4k/xyEb0flOAkxJuqLpPctx6hudQgAfAkuLtdoeaKa0/SLz?=
 =?us-ascii?Q?7SxVhu/BIWuP36HNDTUKPQSSKUXhN6cLuBI8ZXFnY0BflE0zWqPhHBqnQL+y?=
 =?us-ascii?Q?MYm5/cywG3OGV63d74DkhWCHfr/Kkm5gENNTpi7sZYJ1UI5LVeytn3bwukoN?=
 =?us-ascii?Q?K2XTPvKj0Dg1pUiNgOL10GDiRVdti12eEPdn5wLmkPRGVPKFMvasBfA5sLWP?=
 =?us-ascii?Q?OUoC84j0sz0dcwOXYRbLbGkOZEk3f+FH+7E8YDs7urn/2uTr33uXGA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(7416014)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CNiBW4CkoJFkUVDwsgJm6pBgP2lf3ghh8uZtt9Y0gXQRcVQjbCoz305SAHjI?=
 =?us-ascii?Q?p2nHAIVciCkDQfuM+TUyH1rTlPtfAbLzY4Ayd6iL1J0k/U8U6klUgy7CcHoE?=
 =?us-ascii?Q?Rh63FvdUWde/W8Og39WyisZ0zOWz75kce9vqS12o13QUwPXMjLDc2xKn3Rm0?=
 =?us-ascii?Q?T7FNFIr5//oLdlBeOXuNtDpTmVWkz6o3jvPh0UVkkZHCHB5pu4oDcJFkvVGe?=
 =?us-ascii?Q?R5hfCGV1ZjgAv6D4bRdjPrbhf4ACePnhioRezsTl52lxF1DecCQ9JOutJcmP?=
 =?us-ascii?Q?g2I3g0ovpo2XnkxaE84XoHpktf4qRlgyJp6S2N6Kk7vo6s4obczJ80p5nFGB?=
 =?us-ascii?Q?ho9RP+S6DE2RZTBm551VbB8XZhMc86B9qi5iAKA2Tf08XqnkRqgNJ1UlW2Az?=
 =?us-ascii?Q?hJiWYDhbE1oo1OF6CKTld7a8oZRptk8Cb0JOx/7X5W3QCvhqI90SUdFfJoj8?=
 =?us-ascii?Q?JQQVEzKRnUV3g2Zb2iPYOQifBoKcfYgZreQ3/yM9gPut5eue2dq5EW2/nyUG?=
 =?us-ascii?Q?l37BJj6Hid7PnmSLDmSAdHBDFRDC6Sa6B10swG3nhCOo6WOdjVRYkdPpwB+/?=
 =?us-ascii?Q?/pkx8I20SEmt5uwsnMV58a3vn5DA0ArtsiqDp8qd0TbCB5SDNqr0/Af/DbqD?=
 =?us-ascii?Q?FZRZIsnk5wRj+FHa9wYLf5w9SOnYMRm0SEgKtSW4m39uzBRaA6a7pCqWp5Vz?=
 =?us-ascii?Q?1uE+dEnGGJo55pRYfbYNdirtYb/DF2USwZAzTB9RtWbZnC8ZnjBHrty1uVKv?=
 =?us-ascii?Q?CN/laNKo1+pIYDvBVBwJ5NLAVw3Hz1pqSdqwg+S/yODwLOODEaYtu0vsu+6B?=
 =?us-ascii?Q?dYgWkeEwCwGYMxg38N/x9ScjQhOI2t5bGU0gFcVz79kP2rLM0MWjOvQ18ybd?=
 =?us-ascii?Q?2HQyEbHtG/n6VVCbEGrnmjusgZpEjsSnSAySs/xEOOzhVrrcaGFHpSu/e7s6?=
 =?us-ascii?Q?xqt05F7b84rLlSCKBlb5TOu1HWHiLqlTKdLy5efV1LInMTYOjjB7FnJsJ1iU?=
 =?us-ascii?Q?BQjPz+56hbMBhHriMw1OUFFlHimMGThXZZx3HX5fLtACySzAUVphJpzZNmC0?=
 =?us-ascii?Q?ZetHGjBx2STVyLMcVyxhDZZC40/Eb9G1PGEdJSS0yq5OABJyPRFzjC/8CXPW?=
 =?us-ascii?Q?SerWLYsgfVHvXXKzdpqk/kjCVqPRILpSw/DPlK7hy7QTAYO2XErB+Jp3SYdx?=
 =?us-ascii?Q?pLDIGFjkmamWUuu37oDthlCASJ+MQ93/+64W2NExuCNCIdE/ALiz7/CAMeN3?=
 =?us-ascii?Q?AUjywcQwNCRe3BxsyUrPjYMz1Apg5Znh7pYJkbbU3ouw0u8wuA/gSE/uAnvF?=
 =?us-ascii?Q?dQa5xxdwhK77tkZ48AUUtcpwWH2XckwiMIhVoZg0XOccSaUVQbMgg6L4Zkf+?=
 =?us-ascii?Q?Ry47/DXPolKq+CL/SoQaVbw/RzCDwBmB1AHgfBuNWWhXclWypq4upVnqMU4A?=
 =?us-ascii?Q?9sYy1zaCfySWxRRbB16kz+m2h1elb1tYkeZ5FThW9JiJcyo14BrMo+zcHUKW?=
 =?us-ascii?Q?Guv5W9fB+LpTcvP1GloX/gBoLfrmwtX6cn/OWh+oE6pW3/08ZU7XpkwsLh15?=
 =?us-ascii?Q?F0B+H/doN+mttnCZc/QlXxk0AG0yzgD46viQlzJy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c38746-17bc-48bf-25f3-08dddb52df20
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 16:51:53.5941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T0PLY5felmNAHt/sFXSpVhlSyFx0PdLpSOSctfrFx0c72U3VXCiU5wZXiF3rbxg6Dt+3qfJMiQ9MomFHfkWoIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11208

On Thu, Aug 14, 2025 at 05:06:43PM +0100, James Clark wrote:
> From: Larisa Grigore <larisa.grigore@nxp.com>
>
> In DMA mode fsl_lpspi_reset() is always called at the end, even when the
> transfer is aborted. When not using DMA, aborts skip the reset leaving

Nit: s/"When not using DMA"/In PIO mode

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> the FIFO filled and the module enabled.
>
> Fix it by always calling fsl_lpspi_reset().
>
> Fixes: a15dc3d657fa ("spi: lpspi: Fix CLK pin becomes low before one transfer")
> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  drivers/spi/spi-fsl-lpspi.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
> index c65eb6d31ee7..aab92ee7eb94 100644
> --- a/drivers/spi/spi-fsl-lpspi.c
> +++ b/drivers/spi/spi-fsl-lpspi.c
> @@ -734,12 +734,10 @@ static int fsl_lpspi_pio_transfer(struct spi_controller *controller,
>  	fsl_lpspi_write_tx_fifo(fsl_lpspi);
>
>  	ret = fsl_lpspi_wait_for_completion(controller);
> -	if (ret)
> -		return ret;
>
>  	fsl_lpspi_reset(fsl_lpspi);
>
> -	return 0;
> +	return ret;
>  }
>
>  static int fsl_lpspi_transfer_one(struct spi_controller *controller,
>
> --
> 2.34.1
>

