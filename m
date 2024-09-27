Return-Path: <linux-spi+bounces-5011-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 971E4988870
	for <lists+linux-spi@lfdr.de>; Fri, 27 Sep 2024 17:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 247FE1F21217
	for <lists+linux-spi@lfdr.de>; Fri, 27 Sep 2024 15:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7D21E4AE;
	Fri, 27 Sep 2024 15:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NR02XBPt"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD60018A959;
	Fri, 27 Sep 2024 15:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727451646; cv=fail; b=BWXxmM8JUuo+DCDeVJmXfYjf/hJbbUOwWVO1BtTxSh06P6GerPBwZziQHeZ8fyxFtcp4F9VHuWjuBKIvzy/TRggwbZ9GBYRDhTONR9g//TtK6MbcI4M/ddiA8nQvecpyU/lNa193HbLTawJCSjGhqo7AJBymu4+tEjdz2NA+mVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727451646; c=relaxed/simple;
	bh=46X1s1OxvBBtn3/ZTbw+w0ngrcVLZ4mlCejGC0cAUmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uFn4+Zs85yKfO7SNKScdGwSCjzHTCoprGI0RJo72ScAwPYuGD2HmlsFz+g1wG5u4i2+TXe4qjnmhpvxWGR1Xa75PPk9ah/TmdiLtcTPHqOPIKB99LVuqMujsdTU2zsc7XP8BNkGFdCDatkt7sgBqp13nTWMCM9gO1m6DMXCgVz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NR02XBPt; arc=fail smtp.client-ip=40.107.21.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2HHJx+wTtQPS/5AAmQkIP6cS/N7ARlfICu9XPuAXzL4oKENido3gRWX/crS7cg3C3tAz5Vb+Dj693xRJPGUNxAj7ab3PRN72OkNibaBhuX80/5tC0+qH3xHtlGXulGcExvWa/88DEwSqvGiEj6Eq+f9vdKPl7oRPcG4wTRCAFh8Q6xPp9cVP2dkT6Yp5TlLmJg8Kr3uAOpXmj6O7dtiKxuRMx5gZYFwmNhPEGNwI0r72rO+tUowi6NEMLJteVnJDP+8Goqb2y+NW/Noi175frkck6btGK5NkoEqqbZPGKb7O8U/xVIcxzBZw+wajcJnr/FLp2tGq4N0UWX2gSW99w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7yCjJr1kZa9+dHGeTeEtGX+hHVy02PBwfYvoCfDPws=;
 b=MPwHACaUuCDfvz7gMrqjcHzscjrfluWs4aCRJLp2J7quY2Pyi8vDlU3Srm5b5b2u+Aw3ykzPuPT6Mt48rwTQ+0hy+Wbu2XFCpWPTudHwQL0ysQQbZySlKlmDLFrQVqSrvKVocMdpXs6D5U09TYYBtOIqeE4M4fA7WB+BJoNr7RAvAQ+60Hd/ugOTIwU3Aq3z5fu6d0mY3i9TDSRXlui1Cs40Q5BXLdjX/LtbKczzwmd1e0zu6pkI3uUvTkQmEVKT6avhlDixj117buTFbd1dt+JZQLGTSBHYe7CSYNq9KF96nYkjI+DnJlGUaGlCHJGpq468TXyLLSJSQ913Qjx7oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7yCjJr1kZa9+dHGeTeEtGX+hHVy02PBwfYvoCfDPws=;
 b=NR02XBPtqhLJkkMUI5Z0a3DkgRgRo05h7qBSoSykIsAmBlioVotvv13nwPSSfGaMg1Bxq8khNFTQltW1xR+q1ihMNFd9ZxfUfyOfFLf0znOrkAS86//PsV1lsjy/lMEpwmIgk1N4ZLr87JGMuA9pjd+DHZPYGQiq6Sh4eH1jRMLuoP+J/wqEUtYIuE9qCjXJ0kunEL2auWP54TQt7391c0d2cIJMNZ7UgEdMs7TTy8CA0ZBF9lfSWBE1DeixEwkA5ts+okgajBNBNig3BFTc1IK+O/574B0nwQaMvR9ziN+TeM8D1s2kWmTvBmYNc1zrAJaojaxEcoDxLUDGNNZzyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7095.eurprd04.prod.outlook.com (2603:10a6:20b:11c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Fri, 27 Sep
 2024 15:40:41 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 15:40:41 +0000
Date: Fri, 27 Sep 2024 11:40:32 -0400
From: Frank Li <Frank.li@nxp.com>
To: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
Cc: linux-spi@vger.kernel.org, olteanv@gmail.com, broonie@kernel.org,
	Han Xu <han.xu@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Haibo Chen <haibo.chen@nxp.com>,
	Yogesh Gaur <yogeshgaur.83@gmail.com>, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/4] spi: spi-fsl-qspi: Fix casting warnings
Message-ID: <ZvbR8OaXeg4SQc1i@lizhi-Precision-Tower-5810>
References: <20240927132944.19285-1-hardevsinh.palaniya@siliconsignals.io>
 <20240927132944.19285-2-hardevsinh.palaniya@siliconsignals.io>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927132944.19285-2-hardevsinh.palaniya@siliconsignals.io>
X-ClientProxiedBy: BYAPR06CA0017.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB7095:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ed49ef6-9b1c-432f-9c1a-08dcdf0abdda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?doCtQPSYCvXRcnSjYirNrFg+7B6BICkSnOSO3Q8DBIyBwI2Jx8LQbe2M1Faz?=
 =?us-ascii?Q?VPLWGuXx1WF7f7Jqj2QY3m9mtNpaEuQBedBt637VnWMzwE6qewkuT4JCjRXn?=
 =?us-ascii?Q?45PoMlJ4+BegAApk9XMkScL1r5E4NDIO1wtfwqQ4cmgvabHT9QRhpK5ry8bR?=
 =?us-ascii?Q?6ymBCpIRyv4pDFAbK+2P3Q7uIN1Ouj8S5YS4uNLQp3KTIpfoOn0Tf8jPG4mN?=
 =?us-ascii?Q?SvJLcG/wFQO+oi6HKBIXAS1DmPoIThflULc9CArv7bvsQuCXq8hfg1R8czcP?=
 =?us-ascii?Q?LJ7EQxj2HL9lULIEmduE37+or6fGb5fZPgVbwX8yLcZYdDLfWLrDrdTFy+nx?=
 =?us-ascii?Q?xh9tqn1desmp8s215GtuXqteLU02P/p7S2oIjT33HiNubv8lhlZmEPMro/Ck?=
 =?us-ascii?Q?j/IhoByxiEokE2XkDS7nrev2cppqkLDIdo4yjknFGTluP2nJhsnybD3PrtjD?=
 =?us-ascii?Q?ptOMsR0C2idXPM5eDKUBGIGgD9BDZGOz/8zBbUe9Pl7LepgisybIPTpHlvoU?=
 =?us-ascii?Q?Tnr79sBuoGZbIDigQwlVvTs8QXWbCp82zl8Fmm48KhnRrXjnBP9p9fPik7/D?=
 =?us-ascii?Q?gedJ6DLNSvot7anYr/sIoHghbUjvUG3gqGlkmvoZllNSRI/STBh72GDXBFQg?=
 =?us-ascii?Q?YJGOIy+zFgTD/ROp6vfPxkQkkMgnOaqIlG6twd2uCWsJtlLJscXpmQTDMlmw?=
 =?us-ascii?Q?ax90XYxlGcxfwrmuElXd32Cc2gySuKMEK1q4zFFdC75gbhubWAh1mNKe/mAd?=
 =?us-ascii?Q?XVu3CNPjQ/jYAOFHC2Vr18va3dR+r9d5lg8vLxOmALjbjoo8GLPmutlk1QIC?=
 =?us-ascii?Q?xiudMZESH61qLOeus2ZT7yOTCA162hqyy9+Zs+WhNFEzq8HlcD5M8WbF6Kpi?=
 =?us-ascii?Q?8v1sAYohnlhmAatQ1GMkC3qDRzNjy4d5hN7ZRsT9POOaAgf678PtB6KLRLWm?=
 =?us-ascii?Q?twagsKuLM6J1yyn41dTFiUip9akF4JJ2jiDr3t+yhn7X5NHhVmBx/Iv7tKl2?=
 =?us-ascii?Q?sUpgboYYYk8GP7N1+A3An3BvbKDuyUV5/VYyDtDRTHmymviBjnbibKoLjat/?=
 =?us-ascii?Q?JXvhE7yKPAtgynxEqKaJ6YZ+5S09e914GrwfcB5i1scxd+wTt+cD0uNoj1TG?=
 =?us-ascii?Q?+vxExhXK0A27e35kq0t9/vTZbOn1sxcwOYY5ddBZEMX+poO/wVOhJRvnWBHJ?=
 =?us-ascii?Q?B0JykBoCH5bmLKiD/Ybi98vQt7z4rICpfSJDcMJNkhF3vpbPVH63oSA66c7d?=
 =?us-ascii?Q?9o9Fz+aGzkdnBV7+iq2icgnptV+Wdp6x9HvhhZdkMzoqIC7/jO0dNP3iJEi6?=
 =?us-ascii?Q?5TQUIOwl8hwZdy1y5UN7XoGvgt6HWL+IyORDUDDPNKP1kg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/KfI3traktIK4pmyKWk1kcIHtPDFeHjYU4dZxVy/YQ+zydYlaxJHkrm8XTSb?=
 =?us-ascii?Q?SyjLlMACvMHISddThWt8q0SVUkSF04PV7/5vnxuGXQ1RChN5OnfFYpVlVuV0?=
 =?us-ascii?Q?cFV+VTkSsv88ANeDp4OYijudsOknLhTqvbEmbuttW82aBgoK+Jd7yLtZPNNz?=
 =?us-ascii?Q?bOwb9p4gmWHTK8BnEwQRP3euHeBakEK4fJBPxSLMrkvU76UTnRv8oRg1z9rc?=
 =?us-ascii?Q?AoQFXitkOHKm0DaMhodIPHYYowa3RudEpTpV1vKkhedG1gd856arYqjTrEPk?=
 =?us-ascii?Q?6MLJ2XvcKskIuEAM1Nz3STcOW40VYMYfqRLEqpBOK7feFbeRyOaRFyFFYUj4?=
 =?us-ascii?Q?NN8SyGpnwtEIANRz3QsLTvCWO4Rw+1YnvC4aUM1AYnVXzdm8mGpHByCSyEj9?=
 =?us-ascii?Q?sKzEASzBPgzmPIP7qgE95UGpRfhuYfqrS7AtbWCe3/DB0W+mYOHLzhUMigdN?=
 =?us-ascii?Q?jaT8FLTCjSLMtSj/CHD/RVsplt5nHPLBBWSmISuyj38dXsJoC4qxDGlCtoKV?=
 =?us-ascii?Q?zBo1koFPsBwo+I53RYy+o1I92UcG+JJ2Yv8VS+zOsVvyg2LdbhkSAi6rDeL/?=
 =?us-ascii?Q?6vO54v9s25PWOsXPDqAelPShuwdpyP1Mt5W1C1UqwYMlKPeQsVxo+/8Is6K+?=
 =?us-ascii?Q?K6fcIiF/8C/hnLWE++pp5WLA8spY1wRrcor65k5Bv9QysQMgBOy5GvGmJU0B?=
 =?us-ascii?Q?iSgrlm8CoMWEi8m5BcQ8vHsgJCAFHUrcIJPiYTrCDX91A9bI2NGB+QOFNDbx?=
 =?us-ascii?Q?q5lGOuFkOQ15AblRWJq+2JBe61kut0l5E1CzX+43eXjc2DNcmdhhL6TlSYeb?=
 =?us-ascii?Q?uzsubJbiulojT9bwrUL1FyxfVs/QK9iXxlB2y4iaQ3TNRiPIf1nDQ87evBXN?=
 =?us-ascii?Q?j4wYCyvtwGwMXqlI7Rr8WM7oo2qcKKnVOBmVrf6obRel2tt8F5yR4n9yByGE?=
 =?us-ascii?Q?EpK6ZjoSKZrjO7gbMEle9JekCeVRvpLLk5okjBh67kONlz5NVtFb+TfKGsI6?=
 =?us-ascii?Q?Q04IHKWAQEAELHklqxwmRYOGRQkEbH4fl5FV9VrV5mjmaNy/vOcdXvmRFlFv?=
 =?us-ascii?Q?raIzKyIoseinET08V+oV/Yf2LLEvgu7Ly8baYtxpZtV2jc8H5FEiwTyKQ0+k?=
 =?us-ascii?Q?43DU7W6++KJ5gRFB/CrUoCZoXYaqkS+p7lGkG4GA+a1s/GOHEyBYY2NsXWYn?=
 =?us-ascii?Q?f1EPxZ9f2fWXDSAnt+D0ds6PXtDbSZbgugFtXOLXN8zGKcuZnn4EsyBuy5KG?=
 =?us-ascii?Q?btsrv4X2+XS/n4fQ6sKF+LMYS3Pbj1dUjOGjsT/VVHwn2vKHgeRYCST5LQpX?=
 =?us-ascii?Q?zhxWE5t48r8NpQvUUzkLWDeATppGp+srD9TGoP+3Yu+TBC+2hYQ/emUHrY1U?=
 =?us-ascii?Q?2tisyFukkVPscQDXI37l5pEXwvVv6aaybbnEPwY1xfB29EHD6RFKbUFvnWTc?=
 =?us-ascii?Q?c7sIf+BCVfCHdwqrMFnYjR+JjbX1iYSYRxEogXnfnSYRngs61IqrtLO5A0PE?=
 =?us-ascii?Q?TbHNuvpXBu1KPJuBqByzb4wxDDasQQQovzelSV56NUs6U9/4XOSWTny01mhj?=
 =?us-ascii?Q?/gqSqdDtFTTsFDoWfRQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed49ef6-9b1c-432f-9c1a-08dcdf0abdda
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 15:40:41.0842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +TYnK6S1dc+oQLbvkJLsybm4/ww6PW/8lCLsoPOQfuxg5KB675debQ0e3YaeP8jS4/0xIOXe53BwgYngGI7DcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7095

On Fri, Sep 27, 2024 at 06:58:33PM +0530, Hardevsinh Palaniya wrote:
> Sparse warnings:
>
> drivers/spi/spi-fsl-qspi.c:635:25: warning: cast from restricted __be32
>
> Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
> ---
>  drivers/spi/spi-fsl-qspi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
> index 79bac30e79af..e4a2a6049e33 100644
> --- a/drivers/spi/spi-fsl-qspi.c
> +++ b/drivers/spi/spi-fsl-qspi.c
> @@ -632,7 +632,7 @@ static int fsl_qspi_readl_poll_tout(struct fsl_qspi *q, void __iomem *base,
>  	u32 reg;
>
>  	if (!q->devtype_data->little_endian)
> -		mask = (u32)cpu_to_be32(mask);
> +		mask =(__force u32)cpu_to_be32(mask);

Most this kind warning report the real problem. I don't suggest fix as it

the 'if branch' should be removed.

and simple

return read_poll_timeout(qspi_readl, reg, !(reg & mask), delay_us, timeout_us,
		  	 q, base);

qspi_readl() already handle endian problem.

Frank

>
>  	return readl_poll_timeout(base, reg, !(reg & mask), delay_us,
>  				  timeout_us);
> --
> 2.43.0
>

