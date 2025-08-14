Return-Path: <linux-spi+bounces-9434-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64355B26D2B
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 18:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1B7A1CC2EE2
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 16:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6AD205E3B;
	Thu, 14 Aug 2025 16:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jz9WG2uL"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013050.outbound.protection.outlook.com [40.107.162.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA716200BAE;
	Thu, 14 Aug 2025 16:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755190708; cv=fail; b=gSDBLyMUHgGZJlbGkQ/WE51mNmiB3sd74kRAJyjFq+ugW8YAMr8MrfZ/F8J5ojeUEA4G1TjUs6l2YOPWXCN13bEtElcGemMirIhOHY+ltmazuWS6bPwXiPILSW2rmbOHz7q6ipdKab4zpCsupmUg+toi35AqSo7Ax45X61GSf0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755190708; c=relaxed/simple;
	bh=WY1CnDi4JlsAghcCFYrlyCVRWOLbowHxM6gS+9Mn2Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bzR0MUE4PQMIJK6+gDrMXskhU4gjHLq+/W0wjP2zI6NcCPgNm82v/06kxhT8qodvLZjt48wREpCHdJ76X1FhWviGgUWd1oSlyo/8osar8/2Hb+44Qkhbw83jPcIDwaxnWL480WNg4J4pWOinBvIbxNjxmnlvHHguijkC90E/cXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jz9WG2uL; arc=fail smtp.client-ip=40.107.162.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XCXS7wIsUMkfufozA3LBKQNIIsVEm3oIhgGDKGFVc6BMYseHdTG7ZA9pJw4xPDiXG7KCI5POlrPxPery9SSFoLJQkzjJooH8TwkLy0v5IF/64VqJxJGtLq1o4Sq62+aMxuuhcyJvUbDvUihYt8YGTMpaxw40MiG8ve/xjgV1Zmhkw1oFMHmuaccvwiQZ3n58z01F7b3KgMwp21fZ5ehCPfs5AxUgOL3wJpxDVwWU9KaccV/nXAF0OMGnD9DBgdacppqPAYEB09KAM2FwF1v5FwTI9GGmperRd3VAhie05izxUh/A7meeNeUv2wHzVCz1pd/OPjXuulX/dt63nnVL1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBYGgfISZ7+gvzRy9Qqh57wv3OUpwnsFRSqobwDzO0o=;
 b=A8KhfXNrT4VqLA0Hg1WCAA4B1lak1RaQ8T0UtKdjQQ/GiZLGTqPb4lQgpzDY5TO7yW8HqHb7V8rJmVjgz1J9JP4ORx2XSbMYeQcjHKpibjyBkCYWko0uixFWaA4LwtU1U2PZUZjOhscVFNPFdGqb9FscXdVbNpDV8oQLZZyxU9bqQdzuDoJ9aLQ/T54mEt0LvFjn5oJedp9sTY7DeupQvMdvPbx41IWd5+mQPuTZZrqqT55tUUuCMSsRNOfOEl2xRH3br+c65Ey3V2MYiGnJ5fCSyafLBP5vu/aEBOac/k6H/6e++Ae638csmc4EwUmH57cPpxlTShLnPPtyq8BHnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBYGgfISZ7+gvzRy9Qqh57wv3OUpwnsFRSqobwDzO0o=;
 b=jz9WG2uL1F4u1P8V29r1mSBFFOGz85e1TqycKgiByVpwu+iMpxyOWCEhelK0SIQZO8k9Zk6XtOeQrFdjyrjtSbggjkc71q9d1v3kbybgqK7bI+pmAWGZwVuweqrR3mKjpWHUZGl6Na8v/IK4r3SQZQhmS8Oc1SdT3P+9brC/2papU9IbBKChJE9aZts4Rxw0iiYDppfiI7JK0rhnWSo6dcgDcHWEzcMB3k8+1wbRzCToSOXiCVfnJHlSwlPmcqJa21nRhx0JzVUBCXxd7ydmlLGaLA3+HYzn0ozCe2+FTMindr8B43F26J4h+UIKdh0VXVhW/S0BKoSfMdhZL8HdQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8950.eurprd04.prod.outlook.com (2603:10a6:10:2e1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Thu, 14 Aug
 2025 16:58:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 16:58:23 +0000
Date: Thu, 14 Aug 2025 12:58:12 -0400
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
Subject: Re: [PATCH 04/13] spi: spi-fsl-lpspi: Clear status register after
 disabling the module
Message-ID: <aJ4VpLhI+hZU+cpj@lizhi-Precision-Tower-5810>
References: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
 <20250814-james-nxp-lpspi-v1-4-9586d7815d14@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814-james-nxp-lpspi-v1-4-9586d7815d14@linaro.org>
X-ClientProxiedBy: PH8PR20CA0023.namprd20.prod.outlook.com
 (2603:10b6:510:23c::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8950:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b202cb1-cf16-426d-40dd-08dddb53c5f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|376014|7416014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9nXZQILon/21wNf6jKTmKpPt3nUfCjNufHOxvXn21ykdbmAq51TE7s9qANXG?=
 =?us-ascii?Q?5MlI2WFSTJm3CSIiflwy+WRZbJMq1oGUukOsAwWKT9qNeCbtlWWjRiWCulVA?=
 =?us-ascii?Q?BjbUDkNviHoqu6OdfBe03xoGLVy/7cHhoGtSZeYEywxVIly4GT7PW9ojEhqT?=
 =?us-ascii?Q?z8Fl4iBeheKts3EIDMsLGlk8nY4C/2i94FbFigKxBA0LrH4kvTgHCb943sU1?=
 =?us-ascii?Q?BylM7y2PpRV88TWmUbul8b1dKetYlir6YJflqKEX0kiu+eDGvlQErtrsHogo?=
 =?us-ascii?Q?aWDNyaPiFSmQgZ68m/wSPRCJaRzsUY5Mn7yoaedyWAm56IyF/B3Gry/xVbfg?=
 =?us-ascii?Q?0m05hsMz9vygle5c3wK3iSIQXJ10XkoRhJTaBH16r5nBFCYA46a9eEP+q+pG?=
 =?us-ascii?Q?GNOskh3mlRpwM6HTTYVq0RaTfHTbUbOcPmCEHuiI4pQxcKmsHJNQFdOp++wV?=
 =?us-ascii?Q?XJOtE0wpMyCG5QJDRwk0KqSOBNeivluLMhdpTrlbQKslKnZutBfE9B6NIzth?=
 =?us-ascii?Q?2IYaACFFtpU2xBopABFs8vfeoOM0glkqDizrOgVuT2aR5IJnWD2zcOfYaNx+?=
 =?us-ascii?Q?1MmQWTHYV0aLXVrzL5+vaEeU4YbSjPcB04iT9/8IJ8JyVZo6F2eiD/3SPzeA?=
 =?us-ascii?Q?EiKGTH+rGG+NHdoMFr3oTUYy24rTBYFE60ib+wB/SR2kj3kjSfoFQilvdIS7?=
 =?us-ascii?Q?z0NF5l1k9F0rkNr0Q8xaFwm9NNTDl1q2OSGu3ry2rwMrGSHch3Q6WS2OLVha?=
 =?us-ascii?Q?FUmnQ8Lq+SHjeXRsFvyuK0zFNzUDpUZ0sunvjrQF+bwdYrAoIB4W3hOEKM+e?=
 =?us-ascii?Q?a1IJA8CDDlVPlz45ALRMoBLZCuNE2ZtjqyK1Ftgh+qdW9LZXD7D30wWj4TbK?=
 =?us-ascii?Q?/6+aeTcgb4swRY+OyuQIBKiTm2SdXtgxQgCIVveAZqiPjqk0PAdrDnrK3XNa?=
 =?us-ascii?Q?Ytg6GjI8r9QJskjd6X2+xC8dbNRFcHYwyOE8XcEBmj2Wk2XihqP1HJrUG0Uh?=
 =?us-ascii?Q?E8NTFnp3fkcNlVZK51iu5JTz/ZzUXDPn9xmz5/uW/JQPDvtpKox2XKc5Goth?=
 =?us-ascii?Q?XHwN3p2ozUX0yBX5Mw7hzZMpYBenlB4hXUAejSSbrVwBh/RxlxaTT2sQJDEj?=
 =?us-ascii?Q?XtwotIU9NU9U5jxo4T6NdEJs8fVTYsAcH+SAUi/Oe3DnfQwO4LDLxIT5z/ly?=
 =?us-ascii?Q?SAIUdAKKaBUxxwaHzWoL1zSk1KOQkpgQmdFzjK1Y/Le6+IbyVFTiHp4ZeQkM?=
 =?us-ascii?Q?Znh05X9i1MTKu4LsD9oXQJVbhbgbOO8yQSvjPdidKCN6Ci9bfnxql8Qj2twC?=
 =?us-ascii?Q?nT/HV1sHugkRPZchuqMfOxkihSMuCRvclWQKbDiFIzK3tpM1oWMLH3NBgp41?=
 =?us-ascii?Q?j4mI2lvjUy7YFOYfIhs7S+YKGEKLnBlOmMJVHlH25b74MLhUiO0hMgxeItx4?=
 =?us-ascii?Q?RnNvbZGGU+5wvB5UQyxQRZQjfd7/bRTicvyHNrHR94tXpj+vqSA+bw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(376014)(7416014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vafqp2D68pPDKspgcnlO0/DLJ+GjFBHhsEW8dMZAoQC2wKaGDuhCPcDX9KNY?=
 =?us-ascii?Q?OalxnBjbHjRtMCdJdU371svLlx7GQMjnqcj55/K9t/fj1G+xP3BFlChP0mZu?=
 =?us-ascii?Q?spMqRvARqgVoo2wmX2Qn8nZujhtbAjp2SCQtgoYNU28todK5x0zEipmEYVVN?=
 =?us-ascii?Q?ybOVuSqs8DPzoI1xaUxjIBZh8bwm/kux8q4vEe4arCGSqpJiyaH6DvqZVJSV?=
 =?us-ascii?Q?HG0tgH+g3IbqekXG5+aSEv5glFEpRwd2pg1XMASK5AAUTPjicMjETM7rFgC2?=
 =?us-ascii?Q?p3jyu3lXbXs9uwVq9dIFPov+xycuqsdZsmWKBzdRYFHWthMbldlzK7L3aJ+l?=
 =?us-ascii?Q?dR99v+v99jLvn/CbPv/Fw1J2orn26ylZCQxFbGzJ5Hly4irSfDce7CqjaW3/?=
 =?us-ascii?Q?YmBPQunBF5TbTLJf8mrvSVR0mviiwLsLjxq46AA4M6TR3Cuco3UCKJl2w45K?=
 =?us-ascii?Q?FBy3MCk5mz00vf1+W6iz40QSf0hXPR0K+fj6Q43trWJvEhhI3JETStLHH8u4?=
 =?us-ascii?Q?tpEajik/UOJvFIqBKtiq4/gbwKMqGn35BHS+bsFlB4b/AdDHyuYA0zpCOCKd?=
 =?us-ascii?Q?fW1Cu2by9PvazDnK7bULLmP5KY6mw/Fx3Ycood2oPv6JcJsNB5Eh8BEZveIs?=
 =?us-ascii?Q?gpbvIsLq/RyvPS1VoALITZeWPAbG0NYdHhCwh+VKCXwuIPGqOsnIUi0yv7VB?=
 =?us-ascii?Q?5pCczHHEWpTYITOvBRKJ4nLJRsjx2jaFuVg95HTK7xY1R9nGiZF3/wOOUArF?=
 =?us-ascii?Q?FHRhLW7ltHpo92QzfsbXeHNvDWqVfkfObouVQUtmkv+qO45zOuFytVPIMZLE?=
 =?us-ascii?Q?ZjnbXWW0yJPJvD3janEm69RcquUbZL9hnuWF/m50aHW0M+yZBuwtWcY88vti?=
 =?us-ascii?Q?igBOc/WWFnFqOPsLFWWcIGYS+9QUZiZsghl8aLqreBlO3id3WTDmCZwUvMXe?=
 =?us-ascii?Q?/mVMNnKxkA0em+SD7yVQ+ypvg1x9KLkUpqemLoddEylJuiuFbN6zB2y5GMTj?=
 =?us-ascii?Q?P6A1ORV9l4ErvRjWYDdzCAcQxFvd7sv7ND0Wuo9Xpj64rWU6/ltmO92B9fYL?=
 =?us-ascii?Q?3hRKSZE8kD+HRgLAYVRUumxR0UNiFJEtudQICtW8ajVS3TwjOq+VDjpJ7t/s?=
 =?us-ascii?Q?msDsf8Orr1yrIol8f/ym21icqNr5C3hwiw1t6VJYeXaDHjd+Tfz5eyxoxOgg?=
 =?us-ascii?Q?q9VrbPR6LVj5gSzRh0tKjXMdVgu6GeYyflVifGARy1/XbO0Y4xuzD4XxO/cX?=
 =?us-ascii?Q?eAHsOjuRvZcy16nRGrCIWLk446vxZ+XSbtmVZO9HopFzmCOPimXPmnu4efYr?=
 =?us-ascii?Q?tEVzyvex9yXibyxbWr+Xn8obtRnNUwHBti5WPBawhoFJ/zVTAlr9FWOU9EJH?=
 =?us-ascii?Q?WXh+pD6toscS6ipR4kINlCQ+bvakOZg7Zf2nxCHvxfJJ69cCUq80gR9W3j84?=
 =?us-ascii?Q?hJmbIIBv00rkwafWIwmaM5UN+Q59BDT43H9LLA4mjPCqdEdLLlLP4f9iTYFH?=
 =?us-ascii?Q?6A2QwlcU8GaWMNMd2j7CHvnHDpBtPPb7Jp3I6hXpdOproAylT+CnpXI15MMD?=
 =?us-ascii?Q?eRZc/vy2Jp4LWS5m+74=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b202cb1-cf16-426d-40dd-08dddb53c5f9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 16:58:23.1275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4/x4+RFvozWvZfa+SJxb92CPVK1+CMv5Dhlw5VV4Fibnzo/G8Kc36yXj7wxnrMLzki4TyDbDemnGBLApwNmIdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8950

On Thu, Aug 14, 2025 at 05:06:44PM +0100, James Clark wrote:
> From: Larisa Grigore <larisa.grigore@nxp.com>
>
> Clear the error flags after disabling the module to avoid the case when
> a flag is set between when the flags were just cleared, and when the
> module is disabled.

between flags clear and module disable

And use SR_CLEAR_MASK to replace hardcoded value for improved readability


Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Although fsl_lpspi_reset() was only introduced in commit a15dc3d657fa
> ("spi: lpspi: Fix CLK pin becomes low before one transfer"), the
> original driver only reset SR in the interrupt handler, making it
> vulnerable to the same issue. Therefore the fixes commit is set at the
> introduction of the driver.
>
> Fixes: 5314987de5e5 ("spi: imx: add lpspi bus driver")
> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  drivers/spi/spi-fsl-lpspi.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
> index aab92ee7eb94..79b170426bee 100644
> --- a/drivers/spi/spi-fsl-lpspi.c
> +++ b/drivers/spi/spi-fsl-lpspi.c
> @@ -82,6 +82,8 @@
>  #define TCR_RXMSK	BIT(19)
>  #define TCR_TXMSK	BIT(18)
>
> +#define SR_CLEAR_MASK	GENMASK(13, 8)
> +
>  struct fsl_lpspi_devtype_data {
>  	u8 prescale_max;
>  };
> @@ -536,14 +538,13 @@ static int fsl_lpspi_reset(struct fsl_lpspi_data *fsl_lpspi)
>  		fsl_lpspi_intctrl(fsl_lpspi, 0);
>  	}
>
> -	/* W1C for all flags in SR */
> -	temp = 0x3F << 8;
> -	writel(temp, fsl_lpspi->base + IMX7ULP_SR);
> -
>  	/* Clear FIFO and disable module */
>  	temp = CR_RRF | CR_RTF;
>  	writel(temp, fsl_lpspi->base + IMX7ULP_CR);
>
> +	/* W1C for all flags in SR */
> +	writel(SR_CLEAR_MASK, fsl_lpspi->base + IMX7ULP_SR);
> +
>  	return 0;
>  }
>
>
> --
> 2.34.1
>

