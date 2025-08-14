Return-Path: <linux-spi+bounces-9443-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 374EEB26F0D
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 20:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2193AA60E2
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 18:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C38D230270;
	Thu, 14 Aug 2025 18:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LSvasQPG"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011027.outbound.protection.outlook.com [52.101.70.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B9F319865;
	Thu, 14 Aug 2025 18:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755196720; cv=fail; b=Y+HTGfQlx2KC8Bfq9qZR5apcUhsechq/Gpj6DD6elY78eBh2WyF47U8JQ4d7CfPRtK48nXfWO3jz844UiTXm41kQLrg7qkrONpIWeb8ft8ZeF6wbml2w6qEvvVCKb4iHFBkNqiGtDOzaSYhmOOKhamBGWGBb10ikP/9DESnp4KM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755196720; c=relaxed/simple;
	bh=sCllrSPsIM79B2nPfHl047WsoTXeDi4HoOG2kxjzWtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EfbkNwEEIeLzgkcwSQWNk88WmIr3nU3a6jKEez6QV2EjqpK4+jePo2QbuLRFRprvSaLQXivRa4JBFm1bJDE26xKKWQzlCHsnREpgXEl1QQvnfsFpRbb6vhKc7f08QrfDonFxQu9rq0a7hgE24i+ZtOA1DXT5wlrV2cL1rqWzXKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LSvasQPG; arc=fail smtp.client-ip=52.101.70.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oi0IHpYGUmsfHFM/c9VlSlGTDRdR0Sp3vUp39AR26bPx+SCVSYNzR08qJMSJjZ5V8Ijv7tDXJmrYEp7R//m7AyXLPGRAgwKR2ubyTPJF6Da/ozD6VTIq02aSjBfltzJMN9CiHUe35kfRg/dRs2Tfj7ipWx/cKCDo0/fkRZ5ccbX1Pwl+RVoTAXdMwpv9klTmLytlzgo6K2W6M1CWQZniLImFeCX1En7vHgxrrRvvKtpbC7ooUIyqdDJehCnG9o5sfqeYusyTE9174uPqHBt6pWLiTelxPjgWHfjvxOnPVvdO4bBAnuwHy67GQKMfXax/es3n3pxp4ruOQiILjx6qWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3Sn3eVTGprQ91Xds6LehCpMkb7f+62l/MgtHIsHzEI=;
 b=aYezBALPLZQ/9Zf6V3x2hARNManlUJASV5p0V92bxkdUDs0B0/O7QFQB81FjAPCZ7rsTaPbzEOr1bXv5a4MWILKNlF26V9pKTsL30uyGUK1+eLYDYo+g27gtyxwO06xP/fAJWCPH/He6wVEkhnfSqVpLUhx+CkwOc6f8iuyjEpSQybOBSC26I+Gfj35Td+4jzFw1ftxzSfy2mjEMBP0MLASkOAyyBl6zR6FOPvu8sGd5emKUAIht5Y8pC5dW3Y5t8aZ/gbUsWFI1ck7RSngEPwcHxIyLtzfciNW4sgLprZmX7lcIr8DdxLYGVQIg2MtLi5+oWIJmH7VkpsM0REK1lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3Sn3eVTGprQ91Xds6LehCpMkb7f+62l/MgtHIsHzEI=;
 b=LSvasQPGFHJCa1UL4EEx14jOwrzXhmqO/GSac1CmrKpP4WO1X+mCPO24ot3Bid9MfYujqqabvLNiILH/ejevcaDnpepsnlFzxk5MnawDKi2bZoYlFjj6eCXBTJi7wL33VOJya9icFJDYpRKESuCJFsXqGij9uVcimHzDzCjZqSBJvDpZ/YqEBahUaBebsSeq6hH4pzJgH7b3i35z+kfHvcgNd8DK8Rkijd0b2B508A9oxeEFLfP7X+z1BUuBBo/yU+B10haWpKSF2HlyzrcbjP9a7g18oSSAooHR/zpWcbWNVqV+Wm6+9Y6Cn7z5FrU7YCGQkUX1GKUfcebvjX+vfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by FRWPR04MB11222.eurprd04.prod.outlook.com (2603:10a6:d10:171::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 18:38:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 18:38:35 +0000
Date: Thu, 14 Aug 2025 14:38:25 -0400
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
Subject: Re: [PATCH 07/13] spi: spi-fsl-lpspi: Constify devtype datas
Message-ID: <aJ4tITKLkfto1ltJ@lizhi-Precision-Tower-5810>
References: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
 <20250814-james-nxp-lpspi-v1-7-9586d7815d14@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814-james-nxp-lpspi-v1-7-9586d7815d14@linaro.org>
X-ClientProxiedBy: PH7PR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:510:33d::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|FRWPR04MB11222:EE_
X-MS-Office365-Filtering-Correlation-Id: 04534b3f-012e-4e2b-37f2-08dddb61c6f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5OxIghta41i+Ci7TQwE5VZCAK0NzmZsR6PyJsh6zdn0dNoQ452POZk5ONgMm?=
 =?us-ascii?Q?K30OWYpANU8OZf182h1ysjTcZuCaMvMGEjzEB1m/HBgUBwpKtXQPz/smCj6s?=
 =?us-ascii?Q?X/rX3HpByA6f3ceFEnSsNWzXgGA4DfmtLqBeVRjXzdWhxpGBCTl+KFd2UFBC?=
 =?us-ascii?Q?KuY0AZBH1jxwMtoVrBbfG3MIlROiOEZIpe1bDxZdVv9M4cETOQID27LzepwB?=
 =?us-ascii?Q?7KvaH8A1NViVOqQrFaNp5rASWowp8dutgOgmKXSb1vLlbyIdjkwxzY4WF4Qn?=
 =?us-ascii?Q?4TLpogEDGd078vba6/Dtx3SyGRZcLvxEhF5RCcbwJLkRRAUIoqDokSPZd10O?=
 =?us-ascii?Q?JlxCQ7tnYkvTKDF8NyCfoJHC114oOdOovoGDQ+j6zaj3UFIldZUI9UnYCbF/?=
 =?us-ascii?Q?9eMd57MsJt+/xjfmR4jvH/ePTlBaeHgPn6wbVtnw54iT/jkrq2S4tUBngAvI?=
 =?us-ascii?Q?n6nbzYka2F7Vq8l0lH/llvWCDx8qnyUcMmnluPbGWwhyjfEKwYdmNAmANHCC?=
 =?us-ascii?Q?ntmUAIPAJSt8eJdOyKafUNzXPI6l+U3cJjhXo0OtPqQCZsJ7hgkjGhu1M5aL?=
 =?us-ascii?Q?3Z/W8Vc33mzGN7Hm970PTYfEkz6pQDvpi4MYyh7o48FZj9Bud37XBKmGRHq+?=
 =?us-ascii?Q?gXnDAvI4XRwGmjdP1UaAhEpjmckoo0Gc+wctT6zjMk2NBDotyV5/0+vQLQdN?=
 =?us-ascii?Q?QwSEDB9VdRwnUO3JwR2TUS2tp2utfizQbJacbzDniHSoJa4vtaQEpcrTFXNk?=
 =?us-ascii?Q?4tjefbNnohtUn/816lHXRUSbG1tdYwL+U1L1Yvr+jyd9on1IPCVH/8kE3tij?=
 =?us-ascii?Q?vNdMjLWKtKUYz3vF99ZvnnZ7mPJTKouJj9qsrgrMZzP0x5jy7J1D6A+YAz7d?=
 =?us-ascii?Q?fgauoiKQ8U/Yoruvxr2e4XQ5wP9PoCODUJMxk6QBazNzqlzVnm6BidulHA9Q?=
 =?us-ascii?Q?holbp4l7soeHodfCY7g0AhStlJWAaC/WlxaByYUXkOVe9Tt1r2WW3YHqvfdi?=
 =?us-ascii?Q?riKRiLzhupnO6FGBOZCfMZutIWUuw6PzkmBWvVbQAk0x5GVEnTb+kzIVrMfz?=
 =?us-ascii?Q?5DaRY+p1MQbYy1Fky0khP2X8ZQWpipzELpeCQ0miK1nme5F1US7BsAcaaqQ4?=
 =?us-ascii?Q?LIo3qpZ88vjNqhlzy5vk7HjuUuEuEHSvolTq1Hd5q/LUo5xoMKC/2XPcnXGl?=
 =?us-ascii?Q?0XJ2m81ZihIlEB4tuJpEeSVeHR193hrRcgsWz8SCkOxvG5I+nvNwCxfmBwRh?=
 =?us-ascii?Q?SMRajOmz8BDp2RAoe8/jXllsigelfpjxGt+bP8PN0AnGssBJW+ajOEn0hSom?=
 =?us-ascii?Q?bymwibCo5jxPkIQsh4VPXTU1X9c6W0u2pKkAnyc9ocZ8qeGEw1f9DbuGc4zG?=
 =?us-ascii?Q?rAUnhD73Mu9BhtjqrJiSUykKok/s6XjBfdRkoJkZBysD/2B3w1ilu3cUACDQ?=
 =?us-ascii?Q?o5HvQxwL0DGr9ahT7Kzq6qpbt0/Q+dmbsvFQMJ6XkEh5lZ4x5Q0D3/zBjMAW?=
 =?us-ascii?Q?ztcTGhDwcawhAUw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Cq9NMD9fZDS/1tGDw+ZVarEovKxI+bdalMg8XAroyKygb62qDieqbKKw4Y7i?=
 =?us-ascii?Q?Pj0jeCn44OLK6kBKZ5BzZeDJaWvhPpmSN8uILh7sYtHgeNAqJmZkHpFyV4uq?=
 =?us-ascii?Q?RDENuBbROy9sCYI4+Bt2dU1qbwp+T+SnGu90+4pleG7uS+0de14CEAHbvrAO?=
 =?us-ascii?Q?/tlnPVlpOw2AGz9J0VJN1yU06rU7enLgp/SjggCLd9c/DwiBHiwP62Y3dxK9?=
 =?us-ascii?Q?CmAwOvFN3ys0GkGbdg6Gw/oOVIHAIuxugHvEcGDhxu0WM+HFI6e/900xoIFq?=
 =?us-ascii?Q?/7QSvHAgaYE8hviiRtrfifrXGb1Jkk38NePYHC+NlJWGGitVmJ0pffzPn3QX?=
 =?us-ascii?Q?HuGTFmY9nIyRUexqqIiqJEyatwzW2m5g/JDaUn5CpiIu0BFpeojs54GUZIZc?=
 =?us-ascii?Q?1btj0OSPWAduq6Kjbg3+1oxQ7TSmgCFPP79XLvucWSn15OykXW5LEn1zFrH8?=
 =?us-ascii?Q?paIwAzrpPTZuLs2U3jShjJfCcGR8V1wBcso/FF3mONECvy33SCyW8KpDjHml?=
 =?us-ascii?Q?CsiZDj9vQg90K+nKV5c6nx9wSoed2l7GFH99SXP4tX/ztYJ4zW4QMZR+gET6?=
 =?us-ascii?Q?k3RYcHL2Mg++WhrZYQ1nRZQEJXIPyhBdcJIIUwDVACRj9vHEzzKco8l0mFwv?=
 =?us-ascii?Q?7P6IikvQV185RDuJmK/2kVnL5nuzbcWmWh8msEe7sWb9UG+/8fZ3g+LEqL6y?=
 =?us-ascii?Q?IY4XX5N9DnXWwO8qH1Et3oAPQnNI6rLMLeh1wMmWvy1FSIVG63qJl/rUKuuX?=
 =?us-ascii?Q?XBieev9BQmEuCYqQhCKzLhPP5uL5VFF3uEhLhsnklzCSqbxfxe+1kgvarpD1?=
 =?us-ascii?Q?MSVtFCovEkyMLgKOBV5rhaAA46YiqVFf2GmgPt3vzg8rO3FMSkBs80d4ewaU?=
 =?us-ascii?Q?tV4DArBffS3EspJAWInecFN4AzcYD96XQ4UGNwJuwxnwLSJUywZJeBDvXZcI?=
 =?us-ascii?Q?BmyXi76XPTFXNxX6YmpUaCCzZM5NwOZUGZvCiRbcnD+cf9nwgw1bZ0O5sSk1?=
 =?us-ascii?Q?U2ifHaxR6sbKX4zluVURAeg7eJI+/BusNYRuYkkaDfuRV54QloIrIH4hVw8j?=
 =?us-ascii?Q?5BGK99UocNZ/MH798tW2Qm1uvR51aIS5SrVKDB9jlWBZgAnwt2QdkopnnRHN?=
 =?us-ascii?Q?sKGH7vDXQqCTQLnmPLD5GyS748z373CAWUlR6kbGOk+0AzQuS47kJr6t69Vy?=
 =?us-ascii?Q?54lyEKYRUcqUXGlwpwdTZZx2kX+6QwI8grwItNLe5bWhzX1VpwuuDV5WS+uj?=
 =?us-ascii?Q?c73S5Mf0CgXublvhltfmK5yHNJv3m5Awk7Sl/RY4/R0bIES9Eq5mx92vdiwg?=
 =?us-ascii?Q?xaNj4AXVZYXvejaTj4rVcYSC1KdMGZVrj+h1pQQ1R6Em68jBkfOxX3uu4GLJ?=
 =?us-ascii?Q?ztExOKeu4e3YFgdggvDzKXZEkGcBcwEDIbfCHnDvzx52WzSg0VLe0U5gVQTR?=
 =?us-ascii?Q?1fsxmOqYLkpdrdays+xWaInq/azMfDukz2JFxzlHq4tQr+LF7Fxrkx/pwDVF?=
 =?us-ascii?Q?5n/+ow445+U872tCV7b151gRkYjCiZMTtirsZL9kKnihsmn5YAjr4q06sw0R?=
 =?us-ascii?Q?GsoENfucy202BbQN3snJ4VEodPxL5urSIx10OCqM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04534b3f-012e-4e2b-37f2-08dddb61c6f7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 18:38:35.4845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZRxwX2t1mgw5opuhuWxjrTlXoOy45n4e+p+tlpjActj4mk/XkX/ND+woP1zkMocBR3idlZRKVNydtIdAkMMVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11222

On Thu, Aug 14, 2025 at 05:06:47PM +0100, James Clark wrote:
> struct fsl_lpspi_data->devtype_data and fsl_lpspi_dt_ids that point here
> are already const, so these can be too.

Add const for all devtype_data.

Frank
>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  drivers/spi/spi-fsl-lpspi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
> index 98da6a5d7013..332a852b746f 100644
> --- a/drivers/spi/spi-fsl-lpspi.c
> +++ b/drivers/spi/spi-fsl-lpspi.c
> @@ -145,11 +145,11 @@ struct fsl_lpspi_data {
>   * ERR051608 fixed or not:
>   * https://www.nxp.com/docs/en/errata/i.MX93_1P87f.pdf
>   */
> -static struct fsl_lpspi_devtype_data imx93_lpspi_devtype_data = {
> +static const struct fsl_lpspi_devtype_data imx93_lpspi_devtype_data = {
>  	.prescale_max = 1,
>  };
>
> -static struct fsl_lpspi_devtype_data imx7ulp_lpspi_devtype_data = {
> +static const struct fsl_lpspi_devtype_data imx7ulp_lpspi_devtype_data = {
>  	.prescale_max = 7,
>  };
>
>
> --
> 2.34.1
>

