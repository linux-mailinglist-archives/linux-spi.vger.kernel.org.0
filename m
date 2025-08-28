Return-Path: <linux-spi+bounces-9754-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1BCB3A9B2
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 20:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1E123A6FDA
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 18:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754EF26FD8E;
	Thu, 28 Aug 2025 18:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XOAKrfbN"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011011.outbound.protection.outlook.com [40.107.130.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9663C26F2A4;
	Thu, 28 Aug 2025 18:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756404908; cv=fail; b=UGxwZMmzRskmwXdJAPBYELKsjiwjgVUgo84RRtoSf/wtaH4yi3NcEPw4lkUdx/L7eKsdtPrGrxQVXcl4rgRKXIzeNBscFk3dVY6G1130pd8LVnapV0UwoQOsuOgcRx/gcFqpdnxekOSeMlBpZWmx/te160f31fNDMad9phMwQvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756404908; c=relaxed/simple;
	bh=1GVmYfWzErRMhHYYq5Aj7mEhe6sqa68g723VC8ikpQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i5FeEWtp0UWhn3hjPJvfjgSO3zbSqYoii0jjCr3GiRtqwfp1Nj/KlaWKrGXD4WQ/tSLYeWu8YZg5qlGotvlBiKZbET33I/cOzAZ1Q6LQUyDcaHABVNfAicmn+S+HbAKeVW9zvhw6loyyGchnVDdhed0Rf9lmfMEMEQXtLVLk6XI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XOAKrfbN; arc=fail smtp.client-ip=40.107.130.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jysk8wXtHqYZPK077adQoZyV83rmZTNicgo7iV7iHC3nLSPvHz7SG7sch0J18/3TLm105rVV0UUAggGNObyPUpbzafB1qqvwEu8gCC+sF76O9xUx2BTFfP0PrvRVAUhrmeKFnRXynoZwvCO+cEj69baYbpBtW+RWspJvw+9Yl3wSgR0FTXVxSBhQMG9zre7hFIA286HACQg1gNbeMCniTh/EYdJMKl/Bk1rCFN0zhlrNgs6WiPqE0/PVcQ3jnRHNaovsE9W38Wqyi2QnmDpBvtnIYl9ADGUSRw3Hqvu/xtop4DDD1jjxS++0VszfRjYDzuoL7ZSH1PFC/sJKFxqE5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQW9Twg6U4e6icl8PM0d5v3spnLc1/VSo+x6a0mKg/8=;
 b=FFOS3NFhdjZTnhi4EWngJQqfELTFVG/uSAZRcSYr2eqnLmzu+bfv95VyRai3tZzkWijIn6gdXpMNK4MXfcbx3sazHAyA80KHHZyyLba2bs1WFNa238ShphV/oj9HhBtlvMGVW63qCSHGqAmIIh0s/02vOYMUl8tZBhWG07FMf0J2+XWiUpI5VBov9Qx69VUqE7V7mFcMIE24/o0uYFfoAuBB9EwpttzmyT2YjZC86TxYby013MUYGmRCQ9tuCJpt3M7Cn1XeJX/vwXci12COQwKhMygDHYlP9G0Da5Ekl6rVBGocB4evjZl1yTUoqDpz5RgTfQaAzHh5Sfz6GBJsBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQW9Twg6U4e6icl8PM0d5v3spnLc1/VSo+x6a0mKg/8=;
 b=XOAKrfbNiOxu8h54TDnagbyRvDU14OheZ3yo4k4aG1YI+4dNRQUe7YJvjcJkbx44w6JATX4qRD4IZuCWdH7j8ht4d5pDaQyp2nbNOgxKBH9JV+cMmBE9s0gG8UObdtfY0VIxdPyNZQpeunZGIxGHH5VKWE2BINvhkz6iHogZmCdRs4nnTwIFZ9VpV5HAcZ2io7tXn6CtTK0x2DDWAVFddIoxhhsbNIM+32Vi2dnsbh0xsCxppDVyK2CI11As+JAtcXGZTCUu3DDmhuE7qeiagE4x+SZ/ydq/+049Zy+Of307UMCi5Ax8qTe2oMnUUjo/OunZylOOSlnTosO0oS5J5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PA2PR04MB10131.eurprd04.prod.outlook.com (2603:10a6:102:403::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Thu, 28 Aug
 2025 18:15:04 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9073.009; Thu, 28 Aug 2025
 18:15:04 +0000
Date: Thu, 28 Aug 2025 14:14:58 -0400
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
Subject: Re: [PATCH v2 8/9] spi: spi-fsl-lpspi: Parameterize reading num-cs
 from hardware
Message-ID: <aLCcoh6rp11sMsZh@lizhi-Precision-Tower-5810>
References: <20250828-james-nxp-lpspi-v2-0-6262b9aa9be4@linaro.org>
 <20250828-james-nxp-lpspi-v2-8-6262b9aa9be4@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828-james-nxp-lpspi-v2-8-6262b9aa9be4@linaro.org>
X-ClientProxiedBy: AM0P190CA0002.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::12) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PA2PR04MB10131:EE_
X-MS-Office365-Filtering-Correlation-Id: a1e152de-e69c-4cb9-adb3-08dde65ecf6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|7416014|376014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wJVk8bGau7ijy0G43xfXqLSCicn8/M7kl3ugECtQ+0U8AS3eDl5pBWYb3RmQ?=
 =?us-ascii?Q?i6xu9sesewQ9TWMlSGkIL40cq3Vkdnv5dVTH3HY49Vvnvmz+kXMKgCG9Cu33?=
 =?us-ascii?Q?DNcuQSz6HTDgL+1D5b00mvwMWDOeb6aHE5MZgN12bb/rB+oDmq/U5iwP5/z3?=
 =?us-ascii?Q?mKeVExGbr9q4E8RuebAKsx2rxl0VNxtjQwW4vQ0d5uMs2XJzifje/A/f3G1X?=
 =?us-ascii?Q?KYOKpDs97MIwpCkEDP5Mr3D+ZO9AKEMixN8Xr8/2KKxRpMPR+Ivqp5ErbBwI?=
 =?us-ascii?Q?ixBFiJxXw7JNNVzYKbMNlpjFBBr1k1r9YqEku3YDboxGVfLi6ihRg2lOYFTG?=
 =?us-ascii?Q?pNLE57nft+ZI43N12ZrFIp2e3t9fxcVjBrLTAaF92ZcNq+mpjgr2u+O5mQMb?=
 =?us-ascii?Q?WhlqGxeZGLhPsEEFDBvXI+2XHS6q4F1t5VmtNMzfRWPAz8Ci6EALN7sZuahA?=
 =?us-ascii?Q?DQgRbqemdP4a0xA/XDdBTVpO6RIWmbGZEUhx5UxVV90k5PuUoXBYsPg1Uebd?=
 =?us-ascii?Q?sVf1UzuJLxoMP/a67J/NSsRjbU9MT2BjuZvlWWJp5p0e2u792gGCGp90Ci9D?=
 =?us-ascii?Q?BQVuU8W6+Flgj9Cbcm8GY/90tq4thVakKrh3M2/l5frskfqw2Wo2Zx+WQTgB?=
 =?us-ascii?Q?TbiG+5FGzZlInopTUQ7J7/HKuAg8MDWc8P4KedWc7ZRqFSAubX89uGSfzfbi?=
 =?us-ascii?Q?dUlxYQKKe3YTZRB0fpnjnydU1mMd3TKpzeFeQPk7LkU1MpJWC0S21GrT4yKG?=
 =?us-ascii?Q?SXZk3+gD7hBDYbeWqtVQVKRE/kz/okNl50wIn20o2xP0p7wrc+OjQi6QvRvx?=
 =?us-ascii?Q?9szeuLTmmoZbxryVLbF7U06ZdxxAaxsLFCUcOfQlea69fSAYbo8wpgTzePk2?=
 =?us-ascii?Q?SPYy+UOaGNmWK3gnaHTN1CWOlHgQE3jbfXqKpUW2uMIsZFevnI57UMGLgqHI?=
 =?us-ascii?Q?h6WBmsoQNs2ZOhNNuSuxKMlpveGpfdl2OJS3DHfxni16hdCRW6io0vowhXWm?=
 =?us-ascii?Q?R3GbcdUwdAu6JTT/Ttx2I6CdkrWLrGrBWD5AzdWjLI0rAVIHCwAPe7zvnStX?=
 =?us-ascii?Q?CxZmiOdg9OtVYjkhjsCkDWs6IKGqQrgtj6ma1ReRhC6sITgFDkn0IOKQYrPQ?=
 =?us-ascii?Q?XbsEfvBqEc6iUald4N7VByTdHV60ixRmavPYcgZ7r654KugNg4xW6wfidmxL?=
 =?us-ascii?Q?QVvOXKGxC2ysv9Oog5CCoGcc4F2OrKpoD4xytc9OEvheg2Xnji35HudGa7Aq?=
 =?us-ascii?Q?5qkfGwGUz3UNrYIMR1vG0jxbudrHhA4m57mjU6o17mjT3HWg4B6pjrYjdcCz?=
 =?us-ascii?Q?WLKF+31TEYUkhRRYSGfoe32oAKue1NMbKGtV/r74T1tHPEuehqeWZwsyuMoT?=
 =?us-ascii?Q?xjPlG6y6XdnXbEnYN8q4FF1UsO15wUPzrdb18z36FPTkY6fgD2NBMftOMfEw?=
 =?us-ascii?Q?5khgPBtEuI7jT/n/+FfhY5VcZL1uJhfg4jRHUjpS4T1nbwk/Ehdezw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(7416014)(376014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yrS6S0eMpsRYuyJxpmkHaRAJCu+Ay9mr6yphXWGzdn8SjzWBKMKyn18MhOTA?=
 =?us-ascii?Q?X3CIZRizwdJ4c+j+EsjEZhInb6jP3v1ooTDoo0gyqJfGg5E247GZXVhIhF6k?=
 =?us-ascii?Q?SvsQBS2wDlIU1M/M8Wp9LClM6UpzGBkzSlcfqmh9O7zSivL9hmkWW7sEPiiW?=
 =?us-ascii?Q?KoLOir0dVJVJjQ9z8KSMeFri3/wdcml75JOi7tK/BMVUJnYoX+ydWCnk4//S?=
 =?us-ascii?Q?NLaXVlGfFPLYiBk/ME5jMN40TFJqpVDX/a09TkO6qCr6CgBnv5L62i9ZrxEe?=
 =?us-ascii?Q?eyXEMZHAFv9U34r5lUVcvTlbHFA7U5Oj0adq+0Wb1+ffdTxWVsqBWEN5rUmM?=
 =?us-ascii?Q?jqJDF9pTtrd9FQiNl2mXjkgQnB+aO0q9I5cgDnHaQdgy8YW68s6GiGjFychV?=
 =?us-ascii?Q?M5E/bQ8jQ881k+PZ5MG7nEdHr+Qc8VU9FnoAy8rVZSPeMVLneOpF1jR3ncKR?=
 =?us-ascii?Q?9xO2QXTTwIKGsbRq6E9yNOQvigxUAaYIQHRIMREnjDTncKxWGkuVKgNS3DUV?=
 =?us-ascii?Q?jHMpf5nV59igZf3+fJ6Hh9OG14qQkbCOKjWPT2rQzsi9BDW7XtTeyg/EXYjI?=
 =?us-ascii?Q?1o6RZrPnl22AxLwnuql1Dnd7u7CuTz7rGWzfgz4a3DV9STiRbVfQCrgqN0Gd?=
 =?us-ascii?Q?DpvTVWV0GzzfrXjKTK4n0smczl5Pdy2Nmf3mVCm30yeZ++oR4RV4pHi6tTaN?=
 =?us-ascii?Q?rUPttT2/wAivl64uWhj519fDr2bRmYM0/VdQwhySi8SD2bWgg8G/XKh0fTJS?=
 =?us-ascii?Q?UpMEIGlZw5QV3HYGP/uWY2W3FfIv53FRfYlzyQo28xO8Pb7du09h73k7gIW6?=
 =?us-ascii?Q?C9hHw3Xr2gM15udaCyF47EHxMcXxplpZDAfeVaKQBDVDH501GZleqBrg7Yln?=
 =?us-ascii?Q?QtGz5KafIKD99Vfk+NOeH1E46WDQRUAM+xe5ZmbrJ+e1SkkmE7xSvrFIcGUk?=
 =?us-ascii?Q?3IlbGVDCxR0VHA5sYb891AntFjLbmjCoPEuD9JmpdPUt58SMh25aUyhcRmFW?=
 =?us-ascii?Q?gxgJ8pKH/nqpW9faHazm0EoafFyVeW69eJZWUFFOT0bt6GSVfOX40Dsi9dFt?=
 =?us-ascii?Q?TO5VHonzUYR4RgNZyzccJOL0JT6hEREMMc9N/g0rP1I3DaVTrk9EpPeQFHdA?=
 =?us-ascii?Q?q9xPEb5QGpiGMEn8pLWLhkYhrKDbluj8fZTA8xmpgRFEYfK8+Vgg/1Cy0NcX?=
 =?us-ascii?Q?Jwkm0+nXfTQOu4kAQfLEOh7hfAcVdPGxGSCj+wB1rS3/7nAKt6vFUGN3sJkD?=
 =?us-ascii?Q?F9u7L+aZZo3G3qUSWweaFYzpWFJf6X1ppDQqJk3o3fSx4AN9r4hCSkxHU5w6?=
 =?us-ascii?Q?nlVFWofsISEnEzaBsV3vNF66PIiavsZKwTTnNWmyRXLoEIfc8sfStyMHxq0t?=
 =?us-ascii?Q?ydm1zXrJp4LRYQG9kxW6CHxJK0/yCbD96iTQxTKOV3Bx6nlx1o0GbHSA+3l5?=
 =?us-ascii?Q?zP/WZCJXMABee9yVwRjYGfMpkc3pLVy1O6I+DveBXk8sb37mqMSbRRVsSMFI?=
 =?us-ascii?Q?Uifu4A2EUmWeOnpgdTS6asFAYYZoD7n/OeOKgjon7ILGjUSjy2V9oH61fztt?=
 =?us-ascii?Q?atT1HMqPQVT4jNUveeRQnSZi5yBrZVVINWw0UUu1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e152de-e69c-4cb9-adb3-08dde65ecf6a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 18:15:03.9490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QumorZEzTfqEEWEMlQHxEAR6nsgqkstKAUUtaMpEorkDO75PcjBr129vC+fcvqgtsD7FE02bdhAR75pDX6tE2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10131

On Thu, Aug 28, 2025 at 11:14:47AM +0100, James Clark wrote:
> Add query_hw_for_num_cs in devtype to avoid directly checking compatible
> string "fsl,imx93-spi".
>
> No functionality change.
>
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/spi/spi-fsl-lpspi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
> index ea25e8dab0a4..ce347cdbb009 100644
> --- a/drivers/spi/spi-fsl-lpspi.c
> +++ b/drivers/spi/spi-fsl-lpspi.c
> @@ -87,6 +87,7 @@
>
>  struct fsl_lpspi_devtype_data {
>  	u8 prescale_max : 3; /* 0 == no limit */
> +	bool query_hw_for_num_cs : 1;
>  };
>
>  struct lpspi_config {
> @@ -137,6 +138,7 @@ struct fsl_lpspi_data {
>   */
>  static const struct fsl_lpspi_devtype_data imx93_lpspi_devtype_data = {
>  	.prescale_max = 1,
> +	.query_hw_for_num_cs = true,
>  };
>
>  static const struct fsl_lpspi_devtype_data imx7ulp_lpspi_devtype_data = {
> @@ -932,7 +934,7 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
>  	fsl_lpspi->rxfifosize = 1 << ((temp >> 8) & 0x0f);
>  	if (of_property_read_u32((&pdev->dev)->of_node, "num-cs",
>  				 &num_cs)) {
> -		if (of_device_is_compatible(pdev->dev.of_node, "fsl,imx93-spi"))
> +		if (devtype_data->query_hw_for_num_cs)
>  			num_cs = ((temp >> 16) & 0xf);
>  		else
>  			num_cs = 1;
>
> --
> 2.34.1
>

