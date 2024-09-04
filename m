Return-Path: <linux-spi+bounces-4626-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F35B996C1FF
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2024 17:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7165282E0A
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2024 15:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7E61DCB05;
	Wed,  4 Sep 2024 15:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gU5/VXx9"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2078.outbound.protection.outlook.com [40.107.103.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CE51D88D0;
	Wed,  4 Sep 2024 15:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725463070; cv=fail; b=iNoFYhp/d63sSH/scQJFjFe9Wh7QpaSHRWPdWi/6WUxQeZ2sjXynIZwvX4RqHYApt1IuVhEbvrl5G1MiCYjJyQZFhXh0dSj5jK+YMYtuoPfQ4YmTY76jxrEtA6a4GTU2U2+ACxpflG/lQnWXC0zijLpD2ATufIkeD8E+TP0mrxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725463070; c=relaxed/simple;
	bh=nj0Fk1ontxdctvhzmDHwm0HMSGHAYF4GHiuEqhHkfBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ttkt6L1RnvADeIxoQuaOSnQ8VIAG6ljPeEWkwPA7k48f+QU3vHd+/eEJY6GFVVQnX7CQz0BMeKgk9ZovYXXm6QL5eceezYlrNtS3RgHlyOKM6FlkcsPerudIrSBnjktKMNOQAQLIF/2TV6d47QseCOHOITGpcxW7qYzeRZUKSag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gU5/VXx9; arc=fail smtp.client-ip=40.107.103.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+HMK0HCz9AEyJ5ipl5RYmlsnR7XjLtocog9o3l0Mi6DL+i6zN5A+IokjGB8TZN430CeT7YIwFABXrZGf6LIuKAcV8qbofmpALho3+xuRXjqOBktukfiKgbslm0zuShwB3vyVr8NQeKCf8iyZkJWlmOBZK1htAJgxhcxEiQoaGEs2iwOxbCuRgEzlawvb1sMcAOkp6vxsWaIxGxHSoveKSFn3w9cBsRmyCD0FgMsr2ddhMSVvqr+OR88LErWyhtjYlSZE4tSjMMwtx7zdbyrQNTXgG5G8X1GHexOCbVwW8M2CnPg13ZgZRzIdww3IGpBQqzQxYkNFdI7aFoq27hqGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAygmSek710SKWuuaoXYrzwWD/b/Ec8WEFtzwOKfMEQ=;
 b=VW7tiPHSQ5LWWYAnqYnR+RGE+L/BkhfRvq11+2t4DrqZdUjkJR3b6g2K5d3MkuSlM9S6uRLA+qBJGBeZd19DBQL0hJrAcE+cHx9PIVAGIaUVvA3eIDiotrmIYoLF8O2bCM6tP3CFDenRNtFpQJMJd4qj66vG8O1rj9soQ2YgrPRvByXWcVtAiKAct7Smls0B8vl3IFtXLsuZEgr8B/m14G9Oyl4NARWIM5n1sw+bA2seJ+H6JBo/Ye/PVdWeBjZuM6kuGGSGM0a+Shq1VNFV8/SnB/Fk3N7MpSxeg7KGLbKNyZmrSyeQVyDEHHW0xzEMZ/KRT8gBXLym+DiQRUpyaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAygmSek710SKWuuaoXYrzwWD/b/Ec8WEFtzwOKfMEQ=;
 b=gU5/VXx9m/9VIclUnlyix1Itfh8UmSClDB6Dk2RsbBPw8MRUpxd5/8rtw8TD9fF7xhsiSw+rDvia6nbq59IcgXHkiiZTCNACL/BPoVx9joSqpzduQiC8eBfe+MgNt7bkeXMFLtsY+UTeGwwdEw1s7SHBfrLp/55oUBmUnssx83SVApiyTnfWFAUtCoRxvBCiEgEx5GuzB+ifqe6SCq4m8UkX+Lf8ORJ11oQa9FltyW/fK+GtEPVhs1Fpmfv4ysjBKbRGIouGMpk6ITjPGhl9Ew6iiDTIb1I5vhObMREuwzfqfiEijk7UpyVAsYfFFiqUpgk/HlkDuFlM8AdzmYDIRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8574.eurprd04.prod.outlook.com (2603:10a6:102:215::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 15:17:41 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 15:17:41 +0000
Date: Wed, 4 Sep 2024 11:17:32 -0400
From: Frank Li <Frank.li@nxp.com>
To: haibo.chen@nxp.com
Cc: han.xu@nxp.com, yogeshgaur.83@gmail.com, broonie@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, singh.kuldeep87k@gmail.com, hs@denx.de,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/6] few clean up for flexspi driver on imx8ulp and imx8mp
Message-ID: <Zth6DNhPt2EnFWAL@lizhi-Precision-Tower-5810>
References: <20240904111727.1834935-1-haibo.chen@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904111727.1834935-1-haibo.chen@nxp.com>
X-ClientProxiedBy: SJ0PR05CA0146.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8574:EE_
X-MS-Office365-Filtering-Correlation-Id: b377436d-c603-48ea-fc1e-08dcccf4b80a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ijYA4Fze3oKebpU8zoI55jsIWfGe3Altn1YN/Y8ZPAZrihkt0c4y6p4BqVIA?=
 =?us-ascii?Q?rw6SieZr4jOy7csD6pcN3XK4ZVg4GRC0ZElsrIUpwEPO2v1bqyj1F+xzcRP/?=
 =?us-ascii?Q?enjUiM1Dcarq+KWq9W5XdvXpgCX398xliDMPIOLVi758DLQohW3wWiWcoQAh?=
 =?us-ascii?Q?i8eiOG/p+ejoV/13zboJmWojNEHczIvnZgskLCkPdhsBFuIUZ2pm7oNq/7vB?=
 =?us-ascii?Q?vhhC7EbenqIBt96NoGnmQrmOVq6CF73GTRznfLy/aaNLXW+S39KWNcYplekN?=
 =?us-ascii?Q?sc7YuSZqD1UufhJF+9w8pVQRODQm7bTd3sTGAudhtOtX5YotGogTsOg95qM+?=
 =?us-ascii?Q?D4QYLmil8l7bTCfV97lksoi/qwqBySZvJ6Yw5nqdZEwoYTrECE/GXwP91AxY?=
 =?us-ascii?Q?XJQLt28RO0jNuPvfz7Ah4kTHNliTV8eODruI8ymvWn88YWFrmYbDu/lhQ7tz?=
 =?us-ascii?Q?PRkQucA/FSeMS11xtwbtoBopUdjiMUaj4H1YhsZrjDGGPLv0XjYWqXliUFzZ?=
 =?us-ascii?Q?GZKUqTXyuZXJLFnzOMkRzoJrQZP1Ql4sF+O5rRXOk/47uP2oDdvqCBYpgX/g?=
 =?us-ascii?Q?Kahnk28UwiVBEbAGSUfYOOqnpNoQ2B6nwc8ZoDMZEjuzf51HAY/QupAXmMP5?=
 =?us-ascii?Q?OpLP+JtmvWyCSfg3y7AqfeYnB5WM6WGMLabRevBVzbva0IPMRM8NGb3YQNtF?=
 =?us-ascii?Q?79Qr2Qitn6a7zKIMhckSOI9d8h6CxPocku8ouBy8cdDaKrgTAWiUaaz5311c?=
 =?us-ascii?Q?i7PQkXV9VOyQA/fa/LSF3ibJwzfZsdqJ8KDLjAvPhA/6qFav+gyc55sN7S/N?=
 =?us-ascii?Q?Lmta9794q9rpJOPjkYBU4LFw27Mh/gXVKBDvwE3fFeQoYDi2Sd95cIQ1/q/H?=
 =?us-ascii?Q?9sJSWCoESPUszsTCVKW6WpBaycQSQ2gcTzRotwKm04OPb5HLj7SXupSU9hep?=
 =?us-ascii?Q?f+/9pTRwaVXVK31tXcLAUQd37Kd/iy2mS1xuJjuz6l3/Jbp7oDWvrRxlkMmd?=
 =?us-ascii?Q?12EBYOwkzFOuTZNpEu1TRi2tjMpELPlG1HY0uyi+3JqKl4ojwcDUbb51yUtY?=
 =?us-ascii?Q?f3RTRV5JmLm9e7KrBujqt1Y5y6010Ex2n3A9cDLCerD8dDcSA6toUUsC12jw?=
 =?us-ascii?Q?k+rHzc1EyQf/mLolFodeX6ZKLWMbdI1YpdbkXxpiGNMl/u83dkPaYkavXEM+?=
 =?us-ascii?Q?2v+3rYoBbFYXwWKRmgVGVRyIXHGmDVBDctOz0xTwTOcrgYtSu0cywc+f1zoZ?=
 =?us-ascii?Q?CFul3LyS1JfAkCbMn8yxlQ3APw/ri2Imbgn6r/B4TmpST8tZNoaYXLa04ShG?=
 =?us-ascii?Q?eepmGW+IrK5PAjbgI1lAs4oyivcNEH/3B99dUOfwBAvBpDG+CGDS/rvACaOr?=
 =?us-ascii?Q?RRDcnlgUGHLrwahFYsSH2xThtLAz2mzsBpzuDWXhTTPZib7nuw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0FbAEibSqkyMeKsOla4qP0HYAIpKs5n2dTKBo1N/yObZRatjOQzEg6NEbsNw?=
 =?us-ascii?Q?zZG7HuRe4OxvJx6iBr2HtpSx+PFqFQgffD3z8mnfsaO6Wd7VdR8x0JweQcAF?=
 =?us-ascii?Q?sjvTg1Rpp8QH9IRJ+R1VsCqFBTciATOpwz7HJ0eGDvSKYr0WTQSJ744UbuPO?=
 =?us-ascii?Q?J0NiVDP+igrElkH8GhaXOLBlA7GRL4DaA0nm98AbksJ07pJ+kp+5EAL0Q6Xj?=
 =?us-ascii?Q?1lDQJ/JmTZgomJLy+FSHPUT81/HjZLImfgDH25PwyOVDqNHxTzF8NMx7zEzz?=
 =?us-ascii?Q?I2QDIr2r12U6zmwPjvYYnRnjuyBY1LfW5VVWeYcugRtYEjCSpj+Bw6kjXaXc?=
 =?us-ascii?Q?S7/rhdzxvoUfpBVSfh+5PlP63oxDO5Q3zM7GiGjwRudBxgKmBiwtHdxKfysI?=
 =?us-ascii?Q?FgWBGJXWkVXlTcp0rWXac0LsFtnanPdWSZoB3+Gl+8Hpbsqd70tK3OjALWEj?=
 =?us-ascii?Q?J2i4HVq7LNWnQPiIOHbrZ5FAACKTAZuQnf7liYqCb4kq8sFKIjxnJj2oD5Do?=
 =?us-ascii?Q?69G9YI/YXJvxvYXS/YsANaHGfQ6ks+ZCFadehKynVhdFhKceqzoaZh7l94YK?=
 =?us-ascii?Q?+ax60ckXZiSPANZ0RZpFVFy97ZEi4ddx3tx4ENTwsAywqZffsR56ItelBY7g?=
 =?us-ascii?Q?XkhudWqfJfskUzbVXyeUzJTo5NCf9/RVkP6G15tyxBdjbDVEdLyuE/5/LsYj?=
 =?us-ascii?Q?yt8cpptL6NsOtvOeQrB2hnLFcERXzK3dEA75QTsEdQEnq3fR4PSS5d2cgKM+?=
 =?us-ascii?Q?QnD6VndjpcyLx4ttrcQBVXQidD9ZbzYfMXY6wpEUq3XpG7qlFLjrtPPDRMs6?=
 =?us-ascii?Q?ua8SoTw0y6wyO2sHNVlhA8szTy/pbDQ/ELlBrO8hH8x2C0cFJEyUY6sD/ACe?=
 =?us-ascii?Q?l0Zt8A3Nxm++vFwpstKTvOFDi3DOJKyGFZNrkpaLGbtoN2zdcuDcgVHU7rKa?=
 =?us-ascii?Q?ijoWxi5qND2BLtINX1WETqBgqJpBTrWUzffaFvVNSS9AijtgzAybGkajLRWx?=
 =?us-ascii?Q?SD2guftfaiDEQ0gBPCjrqVV55lLKZm/WI/2g6kIDFNC1SUrdur0aEG3JbYUJ?=
 =?us-ascii?Q?jJQeBiIr+g3oYNMa3ICJ6zuYZKW+ugJDBgcuHePzyAxbhjsDZeEOscMxFZYV?=
 =?us-ascii?Q?jLOCKS2MuDt/1kVfKYda8rLkjZpuB/6BxKx8ounA7oEAWsNClwb3fcnXG2+5?=
 =?us-ascii?Q?J/5YnmDPhBpYfswUWLzo88Fv5ffdK7RqAEq8vR+zbhULa91ah5Uu0WS8mmaY?=
 =?us-ascii?Q?XsBThMc5XWH21GtH/mr0hsWQjq/mISuERuI7VsUCnVmmmIQjaqwLuauiYX57?=
 =?us-ascii?Q?/uo5+c9YirUqinSXtAqdDGR5eEddyM+uDQfauLGm5bODk3jSFtQ4TKhF05kU?=
 =?us-ascii?Q?k9Ud19DenVslZoFXq+ywXgUKk96gj3sG6LXjbH5qEsixkTU8ydKQZD80CuOB?=
 =?us-ascii?Q?oxZtNblmwfprDkNX1y2sWoEu3FVA3fIRhVcwPDqxpWOsDOvGhhQ4oiFiJcpt?=
 =?us-ascii?Q?j2YmhUl7CWpTbRDzfW1ZKbTj6oxcGhnlgFZRh3TR/c1AGlc+MxpJilfH78j3?=
 =?us-ascii?Q?24PMrXFkaJOgEhyD6F/e1Myj3T7xA4GXmyed1oN2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b377436d-c603-48ea-fc1e-08dcccf4b80a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 15:17:41.3134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S3v/Q1wJlTZ96bOboOfAb5s9vOu4flGMJbTS1nv9f/loBHygoGptskeLQLgudx6WGduPTtGxM/6ZFaXlsxW9Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8574

On Wed, Sep 04, 2024 at 07:17:21PM +0800, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
>
> PATCH1~3 clean up the redundant imx8mp compatible string

look through these 3 patches, look like we can't get much benefit and broke
compatibility, I think it is not worth. just leave as it and add 8ulp
support.

Frank

> PATCH4~5 add support on imx8ulp. The flexspi on imx8ulp has a difference
>          with others, it only has 16 LUTs, while others all has upper to
> 	 32 LUTs. so add this distinguish in the driver.
>
> Haibo Chen (6):
>   dt-bindings: spi: nxp-fspi: adjust imx8mp to compatible with imx8mm
>   spi: nxp-fspi: remove the imx8mp compatible string
>   arm64: dts: imx8mp: add the compatible string for flexspi
>   dt-bindings: spi: nxp-fspi: add imx8ulp support
>   spi: fspi: add support for imx8ulp
>   arm64: dts: imx8ulp: correct the flexspi compatible string
>
>  .../devicetree/bindings/spi/spi-nxp-fspi.yaml |  3 +-
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi     |  2 +-
>  arch/arm64/boot/dts/freescale/imx8ulp.dtsi    |  2 +-
>  drivers/spi/spi-nxp-fspi.c                    | 55 ++++++++++++-------
>  4 files changed, 39 insertions(+), 23 deletions(-)
>
> --
> 2.34.1
>

