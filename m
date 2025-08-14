Return-Path: <linux-spi+bounces-9435-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 558B7B26EA1
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 20:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A47F67A9B14
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 18:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A561A319845;
	Thu, 14 Aug 2025 18:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WkslQjdJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011039.outbound.protection.outlook.com [52.101.65.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B1831984E;
	Thu, 14 Aug 2025 18:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755195017; cv=fail; b=A8L0aADym+Q7eB08OXf8evAXQrPWiNSUvWel5Yf9eQsEGX6jVU3AspUTIZO70iM5sLh0YbJrsHKJTIt2pJBftwY7OFpJ77LneSNN2XVI1GTref1X7Rn0YsxWQ5K1IBESP2cndJOTQz5/qgAD/Jo01OUlZttexbIG39Yqh3g1zaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755195017; c=relaxed/simple;
	bh=WAbo2NmfUY1EmQ4yBKOBsN06GwLEG+k9JSwZTxevuw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YYAInJhARRKzNEb7B9fs6k/vJX/v+Pji3cNhKnsR8VHVM7Ru/HDlvbqtuJ8PJyuOKhH73ejQ1v8JlQ5cpv2/iCsB0euBnhr9iRox7wViPctxXUJrZOtad9m6dUfmMVgtVWn6JZtpjl30hQkhiH0iYRt7yfTHuI3cYmlXUlbtx4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WkslQjdJ; arc=fail smtp.client-ip=52.101.65.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UBuPD4yW3fSLocXWXPRsgIxl6RsXypG/89PTKhiuy6cGmUmPtgl0pTnDlTWmV1+nwysfijnPLDJZb76WSQ85YpiO84K2+L16umPRg6DS0msmVd4mbMHRjAvpIhmEpMpdEMya/o+U5AM51ROVbR6q2utrh7m1yTxoWuzMaDEuSwDT51QLzHHCrWx2U3jqIeDYUEbWnKLcZ7P50BI1RkXb1mLiJ/AAUYAEd9shXmV/gitlVYYJxmrnpau+D9o2w+At8NpuZwHe3U4w9wiu9JWdA2PHavAPgmpkiAzHAotefM+djCntirs7OeNaAxYqbwz49Ld+uJx4wh4sIDDm5vpUng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ms5BBD4I4l9yz8LagfNcktZOKRs9t2Lgq8RhnaXOICQ=;
 b=YRy1N3gpkHEvbD2GB0AllUu7Hxbprps7S+DwpM2TZaeu7eAADPZXcWxIbZ1Yv7Rh9pVItWeh+XXpKSKOb+WDGsiX/aYId39W0Rn3KMjTDC1AFhrxnjPmOXXS9rJHgy9mBtZYu88iGwfVpM/EijNEwpTlfdU/R5dPfXENxUtZjXbzFOnipqG8NUIadRhgC5YEbX2RruF5iQUB6apzXCVP4Li2qktRQr0wZpEv6NKiwABIhPFeRChhDIiNwrbWKNLN5FEWF4MERuVjTs8YyO0GO0EKqg2f6Yiezs3+UjmUPTaDle30HJhbvCmEpNROLwgEeNVUc2bEsOVDjXhD7FFeuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ms5BBD4I4l9yz8LagfNcktZOKRs9t2Lgq8RhnaXOICQ=;
 b=WkslQjdJEsuZ036zMOEgb6z95xsdemDcGoSRYxMVpRuDkUIQuCXnQ/bWi0YJwWcby2sqzknSZ6OfDp0/G5i+Ttg4RvyD8ocfO0slfO00nnULgiff7h5bHp+GKI6EwQr0PVtIDpyroZlOryNthx3xb8mwm9mjs4pnCIowgjlGPIuHtA34gLhgK50YdWsdXHKwcvq2ZOPWy8x2kpZIeEDP/4U5BMTQqXrvQVTKRA72SxiyxofJCi+9CZRXLQFUX5+Pd5arL38oZYhHspzukGt9JNEVd3QobUx9Wizzm+bUhSRtd9mVRx6jeHS3nOLxY9CjQFOHyhDQ3xE6a7ouIvZs0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8511.eurprd04.prod.outlook.com (2603:10a6:102:212::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Thu, 14 Aug
 2025 18:10:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 18:10:10 +0000
Date: Thu, 14 Aug 2025 14:10:04 -0400
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
Subject: Re: [PATCH 05/13] spi: spi-fsl-lpspi: Enumerate all pin
 configuration definitions
Message-ID: <aJ4mfDUcbrP7OSOH@lizhi-Precision-Tower-5810>
References: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
 <20250814-james-nxp-lpspi-v1-5-9586d7815d14@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814-james-nxp-lpspi-v1-5-9586d7815d14@linaro.org>
X-ClientProxiedBy: AM9P193CA0007.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8511:EE_
X-MS-Office365-Filtering-Correlation-Id: a63f27e2-155c-4827-2dd5-08dddb5dceae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sEc21hEOybCPKY5L1rrRs+sgvOuJE9VjGIAGIzkCqwO6tYnEBFFbh3ClUfyn?=
 =?us-ascii?Q?vvFiUttz5OEKaI4Gvkac0edx+x8Nr3Bvkp6qrWzyGa9sB5Zz2A6CgGToy9vp?=
 =?us-ascii?Q?uAKML6wtryVkIcCiEO4xLVtlMoIA/4XIe7aJHG0pJyy66hnYRd8AZglVzfg+?=
 =?us-ascii?Q?n48rhiC3vxLazx6jsA4qGxTNeX5DcPO9p6za+AQFh63Tsspwm4R2i/hLwGc5?=
 =?us-ascii?Q?gpaImighyi5fU/F4ZLzLR3YWpm0bRiCQyv/XiNM/3onT/rRaP/zaaavFKOWD?=
 =?us-ascii?Q?GCo7hzMbAoiC6mLJCSqVTUEdALIWW8dX83hFRsqXRQknjqqdXXjyH975KME4?=
 =?us-ascii?Q?zCYYZeZoxE4KntxPeGmXQr8pw3SqiEQkZhJfVql8gYuvUWdJIK7v6Iakqlaw?=
 =?us-ascii?Q?u0gE8jRyho+Z0O9YQhExZGll9WpBLJwKwmcowO26Bt8o29iZRtPhJPCL36Zh?=
 =?us-ascii?Q?xoKz02AbpJYACZ5jPgEKFDt/V8QhGmB5l9yONINQIMV2edm79Tp3+d8YXTeA?=
 =?us-ascii?Q?B/wQztAQObuzJFw5zcabahm3VBfIszQ+DiTSZhHLUuEvITW3v/+nZrkiMk/o?=
 =?us-ascii?Q?9GqO4VUT2MttN11dVaqscByOk/p34LYq+SKGQgXc5NYNBzliZBVK+MU922s6?=
 =?us-ascii?Q?b59bZBnHS+qfYDDUJxuZ/rvC3hiFKMUeTNrIyDLS4iXbx9EaTFnxr/bjFhzF?=
 =?us-ascii?Q?mZE3Y+jlZWAi479Eluyn6AfR1d6MhQ086hefRl7xPWyCD3UqtlyADHfyuN0V?=
 =?us-ascii?Q?FcIMPdttM//SkFBttHliaQoSyu1bwSOOVwq4QV6W9xeDApZ0JI4ZAfCfGplA?=
 =?us-ascii?Q?E8sO6fJrDz3/IB8jRaFaUWDwGlRAn6R1RAhO8ZiCU+8s4zhXBawMEQuzfGpT?=
 =?us-ascii?Q?U3UryHm1odcf9aA28KBr97NAtLTB3/mlpRTHwqE5vuR46V3whrD/w/G2cc/e?=
 =?us-ascii?Q?FJ0ucWPji0OstFUT4LYWbk8vz/k62i5NGZeic2aun+SxF/VZybugsxdq8tfM?=
 =?us-ascii?Q?YCK3e435rTmZ610aVqFrk1LNHMb1EqECNHnzJznL4l0XUHNMX+2y8dW/MVex?=
 =?us-ascii?Q?QXEObz5+huTJljSzUGXvV1CZ66DHfA6JR4s+1RlIRTGeDiyw17qoV+zfRzR0?=
 =?us-ascii?Q?zeQ4vqxj4rXTWaYbTRCtw25VmdK4hm4YAzKnZdfTbIhyA5KqpLvYa3BA+tIY?=
 =?us-ascii?Q?y2hn3mbheVhuxY51OiCOZeaNQdw1Apd6M+bZgfDNs8UoKXiebekaTL8oxK8m?=
 =?us-ascii?Q?GCIz9o7Yn0ZAUF7TOF+S2VUeuLV5Zg7TSKP25NYf17saRiB7gzCwkq4qbz5L?=
 =?us-ascii?Q?Us/XvKbmKR1D67FlSbfHr5u0BH9tG56Q5J93NZcwEa6oYDqc+0iW2//xYCDU?=
 =?us-ascii?Q?U6g6nKpgZjMnj/WEytxqmxvpLwxWVw8lehIuK+UvwY31zoh8ntrb7I7qBw4w?=
 =?us-ascii?Q?+PjZ/sPLSj6LN3zckiVLxEo8E9JwPHeqjgZiBL+KXpKJHD1Q9/Zr/g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hgrsdtcBkaLMtVzNIk48DwLS1RZPdCKBhNqaVFHXU9tpiocz1LDoLIxK8PRV?=
 =?us-ascii?Q?P3dLeI8pmPyy4W5ROVv7+855DURnKIZJwS8AewOrDNOlOmfPw8zSbUbJ+uc7?=
 =?us-ascii?Q?cS4bn2dfH9QDh8D4aWR7w0BuvHRpV4BnzqHkNFQKQc4dRA7U//FFXdBWGy5d?=
 =?us-ascii?Q?EW9s4E+qR4JXwbk8cWTdTkD2DL7fBz9kNFIfG1lMODwaFbh8+QNE/dbp7i0g?=
 =?us-ascii?Q?BO0aHyRn9KufbIsfm02LBGOR1/hRwMksNRRqpvM6IvNP3yie4DmBwLUAzbxX?=
 =?us-ascii?Q?zmJamrxB2ea3Jx3CIuREIOvx0b1DKGlvpcgRa3WMr8wqBxyBEIXzHR8Hr7a0?=
 =?us-ascii?Q?FBwbTiYSWwrhtjTX8HbRLntCz8Mntij6hGSodKggD0+zVnFV6AGsUprZFCm7?=
 =?us-ascii?Q?AsLFBVWd3rzchzXGMlz5gGDa9LIsOCja88Z86msIlZo4JHblIYDNgNDRHeqD?=
 =?us-ascii?Q?H0YFoFOhyK4R1+Q01go2maYsvRrgap6xUNjRVPLZNBulYZRkaQrfbBrpiU2q?=
 =?us-ascii?Q?gckpoORZRUNQLnDHGaDUIiwqH7XN0JeSb1LjhKbSOjdJZ9LGXFDeFYMekY+g?=
 =?us-ascii?Q?r9uyXx4aS/IgAbxfv0Bwgn6f2jc3glG+34sonbEvSks1EbQNmV2bFAMiQDKE?=
 =?us-ascii?Q?ZjgLKhsgryKJj3johDwj2trEIjsPm5ZJgzvqF9Jbdt7swmEkbEflj4DUu24/?=
 =?us-ascii?Q?EmCvJ0KBW8wDhx/XEbrqppWyxcXHSQocniVs4jC+c2jDFkYGkQOILfwTuoWA?=
 =?us-ascii?Q?+bmfo5qm2rL4ZRhLUrDLd7PoLWWCiyt7yowG3VMCGjJ+1ICguy60MPQPMiSX?=
 =?us-ascii?Q?FHpHAgA5z7nmuB/qyRLbKa5iuC6AyekOUKgOLB1ywYqtHGrEXM+hPYMmQ0Xz?=
 =?us-ascii?Q?CO4v+GuEcrvXqEIyu0oNXSP+oJRouHZXFudrIeFrIHgAuAtuPgVT7a9+1ki+?=
 =?us-ascii?Q?f1Kx3E/1jqwlwQiBgV78XgBm+J0k5HVgYl/MQi39I2zdRyDPfdW005IWUEww?=
 =?us-ascii?Q?ZG/67vbAbBO1MXvH/yy9xhzWuBTNCxPSeU/6nuKe1DxrP1CucJJjzET5W+C3?=
 =?us-ascii?Q?O9LJxKNZjY4s0m/GbTmnmHKFYSfb8M1Rax1WNu37+1FFzD45DL15ACIrTcIq?=
 =?us-ascii?Q?cdHPfbv0jynFOo1U0ue/6Tf/wNsRyJFK2dMNBy5pgRip1gQPcNBVmLsmoqD0?=
 =?us-ascii?Q?hVnLRCrv/trDmqsoEi1iriQEH0XeFYSUAhHJaH5HC6UepO1l5VWehBNf+TAC?=
 =?us-ascii?Q?+XscK2pF/SXGBGljGt+oGS/25r7NPigTlH0YbF3pufHi5XtTMns+kSkp8H/K?=
 =?us-ascii?Q?zG4erz/Zsp6zOqei58LWp46cwCJkp1qbDEMHrtCgbvv69A2EuebtTG3oB0Zc?=
 =?us-ascii?Q?uiFk/4LaFpdtsqKYsL04m9JtnkovtFIF38RP+MP+z93IzoQ8K0U0UD6YkOL9?=
 =?us-ascii?Q?cKpbWpK4zLF+8mHwFocnRSd2a6IKEHLzCaqCOrbuAML2KXKSZ29xCuk8ihDJ?=
 =?us-ascii?Q?U9oshrGcIojnt9UphS/lBRac1YGJIthSxrO7mzDX15BPEFoNR9YpdBKD/Ls5?=
 =?us-ascii?Q?E3tb/E/O/5wtGvBIhcXMZMYlLan9FPuIRi90wdmC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a63f27e2-155c-4827-2dd5-08dddb5dceae
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 18:10:10.4951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: acO1CIRfi1bGkqdJzRsREmidyn0iKSjQaecHFDmiIjSO9+SgZG8Dk/GQJCkO9C6lRgDwkYkMNJ5c84iRmYgNsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8511

On Thu, Aug 14, 2025 at 05:06:45PM +0100, James Clark wrote:
> Add all the possible options, use names more similar to the reference

Add all the possible pincfg options,

> manual and convert _OFFSET to _MASK so we can use FIELD_PREP() and
> FIELD_FITS() macros etc.
>
> This will make it slightly easier to add a DT property for this in the
> next commit.

Make it slightly easier to add a DT property ...

No funtionality change.

>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  drivers/spi/spi-fsl-lpspi.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
> index 79b170426bee..816e48bbc810 100644
> --- a/drivers/spi/spi-fsl-lpspi.c
> +++ b/drivers/spi/spi-fsl-lpspi.c
> @@ -69,7 +69,11 @@
>  #define DER_RDDE	BIT(1)
>  #define DER_TDDE	BIT(0)
>  #define CFGR1_PCSCFG	BIT(27)
> -#define CFGR1_PINCFG	(BIT(24)|BIT(25))
> +#define CFGR1_PINCFG_MASK		GENMASK(25, 24)
> +#define CFGR1_PINCFG_SIN_IN_SOUT_OUT	0
> +#define CFGR1_PINCFG_SIN_ONLY		1
> +#define CFGR1_PINCFG_SOUT_ONLY		2
> +#define CFGR1_PINCFG_SOUT_IN_SIN_OUT	3
>  #define CFGR1_PCSPOL_MASK	GENMASK(11, 8)
>  #define CFGR1_NOSTALL	BIT(3)
>  #define CFGR1_HOST	BIT(0)
> @@ -411,8 +415,9 @@ static int fsl_lpspi_dma_configure(struct spi_controller *controller)
>
>  static int fsl_lpspi_config(struct fsl_lpspi_data *fsl_lpspi)
>  {
> -	u32 temp;
> +	u32 temp = 0;
>  	int ret;
> +	u8 pincfg;
>
>  	if (!fsl_lpspi->is_target) {
>  		ret = fsl_lpspi_set_bitrate(fsl_lpspi);
> @@ -422,10 +427,14 @@ static int fsl_lpspi_config(struct fsl_lpspi_data *fsl_lpspi)
>
>  	fsl_lpspi_set_watermark(fsl_lpspi);
>
> -	if (!fsl_lpspi->is_target)
> -		temp = CFGR1_HOST;
> -	else
> -		temp = CFGR1_PINCFG;
> +	if (!fsl_lpspi->is_target) {
> +		temp |= CFGR1_HOST;
> +		pincfg = CFGR1_PINCFG_SIN_IN_SOUT_OUT;
> +	} else {
> +		pincfg = CFGR1_PINCFG_SOUT_IN_SIN_OUT;
> +	}
> +	temp |= FIELD_PREP(CFGR1_PINCFG_MASK, pincfg);
> +
>  	if (fsl_lpspi->config.mode & SPI_CS_HIGH)
>  		temp |= FIELD_PREP(CFGR1_PCSPOL_MASK,
>  				   BIT(fsl_lpspi->config.chip_select));
>
> --
> 2.34.1
>

