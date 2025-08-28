Return-Path: <linux-spi+bounces-9750-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CE6B3A997
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 20:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CDB93ABDE3
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 18:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151DD257423;
	Thu, 28 Aug 2025 18:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ueb3JH8h"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010031.outbound.protection.outlook.com [52.101.69.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC519625;
	Thu, 28 Aug 2025 18:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756404583; cv=fail; b=Uvx3znt+9WALFqOvxPWLKAgeM+d6IO5r09+uv/NXMtZPRZRbbS/tjmR+rzY5sqoLoRkE0ma/eiTIxY7qLyY8nG6xSjnV0H0tULDPr1Q3V7d6EzpG14jsFa/MOaYFQimhaXyloGie3Yaw6IIwvjEOLn4EAqeHylSoSulCcV7p5TM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756404583; c=relaxed/simple;
	bh=dY+0goXIX5evRuCpF/QFw4PHOLQy6hsP3nYZbuJ1FBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WwWJ5uTtsNryhudlFWrmXUIFfbV6UhHQeq7nYZAgykbrFUELEZTcsBUzYkuMPx7v6AI+FfzjNQdNw53XQYuqcxdXINGMHba0OJIpPihkXNLcFz0oHldXyQurYulwUG99sL6cDhqA1/CKyJEb00wOObFdMNWsAJDq621+eEjaY/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ueb3JH8h; arc=fail smtp.client-ip=52.101.69.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L6nIbjAPfkNlbYhkVKGQpU186S4OmyJTHp+sU5n9S2kQQlvfcBIYD/xJJii0MIxs3tPIiqwci4/Io+hmX18M2UYnXgNMUtxqZaa7doLfr+2ZFNzno3cbNT6lAYGCohqhFUVj8OgAKmcuTkZM897lDrtq2IRM1hIGkMbCzgps60+9fe0kPv2Az0jO+62b3Q1jY3fxCsPZ/X9iIFfvclxrGS1E7jqpbUbWWjrH43dv6OuYi67ai9YHY+Bb2OXN75RfNJPvalzjF/po97hhs+iorg7T2dEyke0dCzc54hXkZ//rbD+OlklLHNOEc2UERsXKgovxgtO2hTPG6WLYlhrskg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQ54fp2OAvO6Dt6rM6dAekArk9e1z4BvXVJ5JVmtsV0=;
 b=k5LA/vGzIuBijv9ey3QNHak6cMed8gVqvD6/0FE6VdXtyezXsRXLuX6gfEEHyvFjzQhFENQddOkbcBvQW53j3d5pwPgcr5mErCD7dvC2QAl0CwPRZt9j0fusb6JolH/+W27ug/RDQkMegrOHPR5ljj3J1U0n95k496SsEMbJi2jTPJfY0nkYQVpa6CAfwfa5oEmxAIWkJ0zQzSpi7ZBX21XUttkbhsG0zkokfbOzoEaHvL6vnjlfSfAi+fkZ1YPJ2qx0SF59Q2VtgF2CD3mP3CqVxaitgrV0D/Fcb8xCjoC0HABjeuklD7o2syw5JwqqQLflQ4pMJKw7RpN2JM8qWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQ54fp2OAvO6Dt6rM6dAekArk9e1z4BvXVJ5JVmtsV0=;
 b=Ueb3JH8hfkSnNNYOx66Cs2kHo2BCcF+4k45oLEC+aD+3joH9VX+vdy6SPT97wD/4LrsBYSVpDr5NyE8QkegorHPjAQeNGvtd4QfcTJTifGlplxhCfOxmm/JtdE9zkr5G0LZy6SfbJv03G9SE3ZekdQD7nP1wQC3GPvIlapM1zhY+CJk3pzU8x1h3Wv+XT7drA1ReURKGR4+6Shyv2l2Wp+jaYim18O7bmdatEZFiy36AsKk4MEgdmBOBpdpvb2TPke4cnI6/knlbbja2W8IV2djYX7NvIdR4QgyI8CEMQkg2nc4QaO86JcovrO0019PBV/JOou+WwlzRalV4Jh3coA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PA2PR04MB10131.eurprd04.prod.outlook.com (2603:10a6:102:403::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Thu, 28 Aug
 2025 18:09:36 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9073.009; Thu, 28 Aug 2025
 18:09:36 +0000
Date: Thu, 28 Aug 2025 14:09:25 -0400
From: Frank Li <Frank.li@nxp.com>
To: James Clark <james.clark@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Clark Wang <xiaoning.wang@nxp.com>,
	Rob Herring <robh@kernel.org>,
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
Subject: Re: [PATCH v2 2/9] spi: spi-fsl-lpspi: Set correct chip-select
 polarity bit
Message-ID: <aLCbVdi2Z23lvkgG@lizhi-Precision-Tower-5810>
References: <20250828-james-nxp-lpspi-v2-0-6262b9aa9be4@linaro.org>
 <20250828-james-nxp-lpspi-v2-2-6262b9aa9be4@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828-james-nxp-lpspi-v2-2-6262b9aa9be4@linaro.org>
X-ClientProxiedBy: PH5P222CA0004.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::7) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PA2PR04MB10131:EE_
X-MS-Office365-Filtering-Correlation-Id: d02811a9-2a45-4dbd-9b42-08dde65e0bfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|7416014|376014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k1S2K7+lj02R+KA+AQ4rGXhnM1gD9Rx+tacOEOjYjMUJslMpwGKOHGOWIiW8?=
 =?us-ascii?Q?qqWifH8xmCHXo1k7/i+vUOnWqCwqT82ipIrOdjCWs1eUB/5DDZ/Relt4j8p6?=
 =?us-ascii?Q?lnyRw2HXqqlegvYymYrSmsVkRRsD3ilBty3HLabyps+f1EYfEla3G7L8hMLX?=
 =?us-ascii?Q?VmJ6oIOFwIcvMTNeMHdG5QZutS1LA427U4qMzJadJkrib1CTXc2JeR+bTEZv?=
 =?us-ascii?Q?geYF8rIHciYlH2YJlOZjeGQSETDJr74/0voXAqZkiSKGvAZRBaY4CMOFn0AY?=
 =?us-ascii?Q?I6J5qmZwSl4NJ6fKzSd6WBaD+EpkDEESOHH+5VNsurHIW4w4lCO3y5JF4xL6?=
 =?us-ascii?Q?ZQFLVNoV83JrDemKDOLORdf4VdzbqFt2PzSYOlRGBZvET6OBd6qoztlnHvDl?=
 =?us-ascii?Q?AaUG3NvLeqc7gLqPORntmNf77B3OmxSczC+FtsIeSdSK6xjb8WW4TppAemw5?=
 =?us-ascii?Q?NL4dUZHUEGR7kwr5zmQBL8rjQFxJKl/pAleSa+DFODSAm9JDQ23IKSGjT4bV?=
 =?us-ascii?Q?3fDckFAQKfQnz6qflrLxezdjzJC8EQ6h/3Pczfhf0CgykHrOD/LH9ZZttHxd?=
 =?us-ascii?Q?USdIlXgg7kX0QIxbgthKeRKql4xKTp+r1NpvdCvTjXnmmSZLzhYy1OcwVRU3?=
 =?us-ascii?Q?8baQoNqkjkpon7i2nOZ+rBZNF28cVpbFZ8orOrd1XPd7+HqxfxhcUrbsekAZ?=
 =?us-ascii?Q?IOiDOKALtm1US9ggaaPZXUpNvnAZbNPTmmPoVdE9uCOU9YTlsA8ju83j0cTE?=
 =?us-ascii?Q?7cthtVg1KE1gi2PgmNnQHb1s5Np/DnpvVWL0mGcOSvhSSOeJ02X2fdnU4VxD?=
 =?us-ascii?Q?hpdEN4ZApv9krlLTmooFzEGl+k3Yc5vtfI9QVBbKuc5I61J92MrJ6zZ1Kl5a?=
 =?us-ascii?Q?5h/gK/P+DlWGtXlLhNYnRxoH+0uxdjgKptmH0Lwz4dABR+wTjG/Q3mkkbSCS?=
 =?us-ascii?Q?h1+xq877tO888nlQispgLfsixvGe/TOjLWbE15/+MsD4eBrGPJO89ghTtt52?=
 =?us-ascii?Q?mhr30z8gt6/y1c+GWK47b470MM1kOd2nmUE4qI1bUwd4qLUmBvpE4zuUyob0?=
 =?us-ascii?Q?0zIkFooISrhYu980jyOhsWkedtVCP2njxnC4OLttvT/XyhySNQgKOrzDYCWq?=
 =?us-ascii?Q?8AM/eYiuqnLLOaaoxUu7JpFFdbI5+7y06nO04D0e7zqfKMTr6RuJAkxsNyod?=
 =?us-ascii?Q?L3qJ8e6B2dt+ccsPO3TG6tLxYsc1PorxybIMwMTHLReuy8hzFAcC0p7RVY/A?=
 =?us-ascii?Q?bfC0Q+cOXR6cZw37kYo6t2YuqOvqo/WjVxVlIVN6PK4EnptXgkXmKWAeBpeo?=
 =?us-ascii?Q?X7AbZYbwGuUDPVufHqaVScKKPXKcFkLCcOsQ2RBUvv6n11g5oUVHvrlLJ0Ib?=
 =?us-ascii?Q?uYoWFFDDPxYQ3JrZhb1eFyPsOi6gdpmm5MtTjuG3kyiu+CJk6OY/fiwQeDku?=
 =?us-ascii?Q?hV9NrW8jpc/fp+5pY75tXjAnhnbhqSVtog2K6vMszTAEJDmQ747EXA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(7416014)(376014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z2wGpIGV860TFLc1jzdF7jAnTrrwh5gtLgMONXXrQJs6huP0V+p0saL+t5sD?=
 =?us-ascii?Q?yuTqSrFTd9eq9pzOYfZov16OvWUmvcPITc45Mdq1j2Hhj505HXMAXj10EfVr?=
 =?us-ascii?Q?n8yqlvpvZtdacdQiCFIhacOoNCitS7S5Gxciv+29D2xG+U6BVhCsnG3kug+B?=
 =?us-ascii?Q?9PJebqg3UDiGnA0NLGr7hLYtesJEyJEAFW5IEfCOlcRsjdaAuO9givSv3Mhg?=
 =?us-ascii?Q?Q/qSdNU90Gj4fM+unWAdYtD2VqCm22tiJOjy6/jiheAWToTpkSP+MK/poNKo?=
 =?us-ascii?Q?Ynm0iNKqMHFbU6MWCfJjAMiSp0mjZZo6jdo3VRtTkCeEIXPHKW4zYzC+nenw?=
 =?us-ascii?Q?9fFc71h0Y921236ad+ItFQU1mSPJHxZEAS/rMOGnQNIulse++jEPN+wEhlzW?=
 =?us-ascii?Q?cy3b0G2pny1DYgTRu51M/Fp8ZmqiQpaJCooL/aqgEqPQnQpZc7tbmJbsYQ6j?=
 =?us-ascii?Q?fQdubcsyeh+8kB4mlU7TuIAKzNVtfmSIPDr0tSVVpMCJfy5OApFLTdOYek59?=
 =?us-ascii?Q?q46+lm8bfijj8G+DYdtKmxm+h+avccdhDikt8Q9kvWK25va0n8juURbXiUBa?=
 =?us-ascii?Q?Trnml0m+n/Sbwod3eD8G3EHN8K+WMUWpa/HYbi5Va/RfIazfQsljsOGgXtDH?=
 =?us-ascii?Q?k/YKuvEoJCXm9IjeVpGqSo5a5gf3+YQCwUEbpaZWf7KH51aGNqmZ08fX0cUC?=
 =?us-ascii?Q?Oypa9ECn80YVNKC3/Ssb5GsI4BJjEJlUbD++znk5YyWyk/wTIzZz6S5hgvuC?=
 =?us-ascii?Q?MrX40rJ0N0Yppfwcx+dn/53di2PUcQnZTYl5gKUXIDZsCvoq/tQ43ewvCco5?=
 =?us-ascii?Q?j+qVC/L0z0ZzPU79Tyr+eOMS+JPY9b5HJ5CFybcZ5bEiYdB2jlU0Czd8cP6B?=
 =?us-ascii?Q?YONWpoMVM5HAjMH99wa8ijaCVYHJjIBjIs07SnirUkB8tmzYfnmmfXl0F/7V?=
 =?us-ascii?Q?9Mz34n7D1MDExhFXBGU+0StRc+tIhjb7CXb6ALnoV57LJ5a0hYckiAaaRNcK?=
 =?us-ascii?Q?sZSuS1R7MlI0gm00Bj21SOwPxbM939rrLp6G+SCLHv4qqoPzBxz+07qvTNk4?=
 =?us-ascii?Q?Vdhl4y2QLkRneQTYhu/0zaRoBj5yZiuhMUw8jrbViedNgRjXJ6D5Jf0n8zYF?=
 =?us-ascii?Q?JC6qbWqVF3hvEBob0DficpXA6wJrVE9HMOT2NqW03Tw/piJWJa52de/cS2MP?=
 =?us-ascii?Q?c8vHqSKRo/IzNFiTVudTOb7xZkbKQJJRQ+hD2ajaY7pQaTx4OHrDCBnx0YT6?=
 =?us-ascii?Q?Ps01wr2AZeIYGNLTdFO907Zxc8yH86cF85uoEzCZiAw5duHGU3sXM3708SZC?=
 =?us-ascii?Q?TMTXJ6bt+Nkg+p5Z3XcttK6wtZALG+HP5qJue467Buj8ZclEZEv/x1QcL9Ex?=
 =?us-ascii?Q?+bikgSSA3EpXsKQHKEdq3XZYLTT+koW3CYi7f7s2coJSqy1D5Nu9wRfIiD9V?=
 =?us-ascii?Q?ONEwtQnZleenfnGrVd27xsLp9r4B8akMET6rYlAWa6LU2mvRT3us+TLfqvF1?=
 =?us-ascii?Q?ToJfe54d4pgxMNpKizNDmiDG6ms0CP2gS4C9lGqpnBIjFMnd+MB3fEHDztVw?=
 =?us-ascii?Q?fn07JBWgvpiXOHW8Ewft8RCTiuI1xLiYDm9cEYKU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d02811a9-2a45-4dbd-9b42-08dde65e0bfb
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 18:09:36.3224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TkykmpQc8smV8lQzr8G3I7lENDZ9LRDC5LkAHF0x59FGcspCdbMywJqA1qnKOsgEOIV36HLV5fsvF8DwzBh4uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10131

On Thu, Aug 28, 2025 at 11:14:41AM +0100, James Clark wrote:
> From: Larisa Grigore <larisa.grigore@nxp.com>
>
> The driver currently supports multiple chip-selects, but only sets the
> polarity for the first one (CS 0). Fix it by setting the PCSPOL bit for
> the desired chip-select.
>
> Fixes: 5314987de5e5 ("spi: imx: add lpspi bus driver")
> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/spi/spi-fsl-lpspi.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
> index eaa6bade61a6..5ea4a306ffa6 100644
> --- a/drivers/spi/spi-fsl-lpspi.c
> +++ b/drivers/spi/spi-fsl-lpspi.c
> @@ -5,6 +5,7 @@
>  // Copyright 2016 Freescale Semiconductor, Inc.
>  // Copyright 2018, 2023, 2025 NXP
>
> +#include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/completion.h>
>  #include <linux/delay.h>
> @@ -70,7 +71,7 @@
>  #define DER_TDDE	BIT(0)
>  #define CFGR1_PCSCFG	BIT(27)
>  #define CFGR1_PINCFG	(BIT(24)|BIT(25))
> -#define CFGR1_PCSPOL	BIT(8)
> +#define CFGR1_PCSPOL_MASK	GENMASK(11, 8)
>  #define CFGR1_NOSTALL	BIT(3)
>  #define CFGR1_HOST	BIT(0)
>  #define FSR_TXCOUNT	(0xFF)
> @@ -423,7 +424,9 @@ static int fsl_lpspi_config(struct fsl_lpspi_data *fsl_lpspi)
>  	else
>  		temp = CFGR1_PINCFG;
>  	if (fsl_lpspi->config.mode & SPI_CS_HIGH)
> -		temp |= CFGR1_PCSPOL;
> +		temp |= FIELD_PREP(CFGR1_PCSPOL_MASK,
> +				   BIT(fsl_lpspi->config.chip_select));
> +
>  	writel(temp, fsl_lpspi->base + IMX7ULP_CFGR1);
>
>  	temp = readl(fsl_lpspi->base + IMX7ULP_CR);
>
> --
> 2.34.1
>

