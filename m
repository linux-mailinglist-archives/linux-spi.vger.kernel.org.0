Return-Path: <linux-spi+bounces-3528-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9608912825
	for <lists+linux-spi@lfdr.de>; Fri, 21 Jun 2024 16:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A133E282175
	for <lists+linux-spi@lfdr.de>; Fri, 21 Jun 2024 14:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD97F286A8;
	Fri, 21 Jun 2024 14:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JKFJj+m9"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2047.outbound.protection.outlook.com [40.107.8.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE16F757F8;
	Fri, 21 Jun 2024 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718980788; cv=fail; b=TOBoMhf00s8W62CX1coDA+0xCg1PcFP9+zA0NimPzoiISiFCpsanlYCAkjqDpYfOJ5pGxq0IUupK0j+6iI0bMYpzMuARIC3EA97v3J8RhXDEQslWDSrMbj4QSWSs7qljSw6p/P6OClXoPG8IguTQlvP4RZFKpiRf14ka7l6uHhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718980788; c=relaxed/simple;
	bh=7+YnzJVNGirTcbsOnrydMQjUbDbkoYKPcMA5Y3mQ6oA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QBAmiiB9eUH9C19wouGu9ZBletH7JjITnQ6SnVpJPKxaz0fC98Ju2nMRVs7vCeHwuPdgmjyX56MLpGouQKfMAmvdc7VLoa5FWhlXtTXXoJ02bU4syqQlA6xNmU5DPERJess+NvDIxd19pnVYARocx8dWlrr0X6QaQ/G9i7EY+cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=JKFJj+m9; arc=fail smtp.client-ip=40.107.8.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXeS62pV9sfn8WNTasmr9glvKXq1If+il1ghnHzeInTINCtB3XyW48DBjjmuN2CcFhkG1DI3BetxzU5v05kBz7tST86rZ+RyyFtng+/BG40/qstNL4Lj6tsjnwUyT0K9+wHk1mLPMq2CfBnbJXxfr+jdhQ9ovHJppmXovT0F0MzH7ovFd/Vf0i/SbQH5cHkesja+/tBz2Lrw3jQuoIlxZLkipAFroX5IJ348A6ywGPBqKhD/TcIXa/f03RL31ZDAehtBYUfvDwi7k9if3tjXzYavP04bo2IDkibdQ4pjksiAhzpqSUkcbn8eR/ZBWOcBwrsFQ2oNKLyVXKWkIyIKrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGKrh/vRQgzTSy7NWSoeHuYkn/QE/WYtRc4gPisO4bo=;
 b=UjJALFopsosS002NjI5i4U8lOipZ56G8XqwjxfU8w6hx/+XETJv0AhQUUVtDREPOFdmL6vHrnud0e4qc5Z+w0bfRCeLL2hdAIoqDAVV22JLXJazWSU2ZrtlyPByLtwYamELt6zLfdHKrLyTiQ2nAOdJa3/lWcojJYN+VnoQOCQ1qaL/or/mDX6o68+fTxYu02VXNf2XW7f+eLmOqyRldHpxdPjscZ0QiehjB43dKqqjsXS+1p5vONC3A1+gM2b95P7ilCtroC279DgdberJWXsM/Yp0gXeYGOGk7kZVvZkzjGwLwdYmnRV3+IYKsU+PyYsw/V8XsqT7AhndS74ngyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGKrh/vRQgzTSy7NWSoeHuYkn/QE/WYtRc4gPisO4bo=;
 b=JKFJj+m9tc8/AGr0LyRjP0U9gjbEDLIArHmUEf2Um7Q3CzE+H7nlwLn1Anl9BGbpVPUZMmINkzVw3CS3GfEK0pf5FRbW9Q5UPfjHrd8HP7h7zVn31lU/Rj+asURYt2sKoaDEawzEuA77GZFZiIIepW+XR4l2Hmnz/9En2TdG8Q8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7095.eurprd04.prod.outlook.com (2603:10a6:20b:11c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Fri, 21 Jun
 2024 14:39:42 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 14:39:42 +0000
Date: Fri, 21 Jun 2024 10:39:33 -0400
From: Frank Li <Frank.li@nxp.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v3 2/3] spi: dt-bindings: fsl-dspi: Convert to yaml format
Message-ID: <ZnWQpa+rSXUhxCn7@lizhi-Precision-Tower-5810>
References: <20240620-ls_qspi-v3-0-1a2afcf417e4@nxp.com>
 <20240620-ls_qspi-v3-2-1a2afcf417e4@nxp.com>
 <20240621124211.pueymngpq5luokvj@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621124211.pueymngpq5luokvj@skbuf>
X-ClientProxiedBy: BYAPR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB7095:EE_
X-MS-Office365-Filtering-Correlation-Id: dbd2f085-ece0-4104-f184-08dc91fffcd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|376011|1800799021|52116011|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/SlRZsRjimXxiHNwf2KCxSS+n8Nu6Is7giTasQGIw19gOomxc9Xh+ci4MziO?=
 =?us-ascii?Q?2BwLg/mdgv+SB+BkrrSDZ6CKAAdkQVDDczQR0sBqp1IP2ts9xoQgB6kbo1US?=
 =?us-ascii?Q?2XvGmLj+3HGcymIH9QBYaur8pgXCUzCiyY2DMEt8+HWi3AfMFebmHQIp0Bws?=
 =?us-ascii?Q?JMm2lDyLNcR8kfyCJvwyOxSuhPSofci6D3llbIlOmkk8zX0iwTo+QBJDkXaB?=
 =?us-ascii?Q?KgO9yRUR2ybIa0D6l/lx1re8PFHDWRto9GELwHmV0QUcr470JydyF0GsVYD1?=
 =?us-ascii?Q?0UP/OVfTJ2cCkHcjjgaYe7PLzefHkw4YZax7LSxWlJoWPlx+5OrJHdLph6t2?=
 =?us-ascii?Q?mWa685c7P2t/09whL1kUtF9eiENdsgKG8KNk/Bhpatzn4lACrnF4Ifrlg6e5?=
 =?us-ascii?Q?xsyAaX9NnwsxJ5YTJBitbyv0aEIUCUTjJOQdafivTs4wMx79h4rJKiXipX9w?=
 =?us-ascii?Q?lQHW0Yfr2LSLfAp3PkPPyRNc3kUpTse61fxyHGR3DBgHrmJYwz9+0/qvP67U?=
 =?us-ascii?Q?Ciozrf4BqMNQZDq7p1Zr0MQ0LBJPbQdxhL2d5H7n72tYjhYNmsDVug19S6vy?=
 =?us-ascii?Q?xz1ElNwz0o4/YI1xecM0Rd+MrHm1XPYWRKJ61lTrbbXlnx26MA3R0N+1zzFn?=
 =?us-ascii?Q?Mve42bD/Zw+yCuqW7VgUKdKWW8UVdqdRx7gYm166PeaT64TqJLc1FM1JhaPb?=
 =?us-ascii?Q?kUpBqdFIkWNfW5nnS2MOUBGWvueaAUgw+6K5MQEQr8+MILKDB8CMsrzUdmid?=
 =?us-ascii?Q?vLwyRwBRaGD4bJ0hmGgRZjJC96NNdd9Fzfy3jpPbU2lIm+KIvZxlx7TYxJ0u?=
 =?us-ascii?Q?kSO0k1Lx4lGhN6A+0oew4IpXYkFVMiRShsFqPYLvROQ4w0v4/Uv9vJF0Xerk?=
 =?us-ascii?Q?FEQBLTOahXBU9nAeAta93rP2faj8dTc/0tC0pZxIChMEMZY+K6mLrFzZHcOK?=
 =?us-ascii?Q?9KBc5kana5E63UhU7fW3JdTEd7/juSjeFsVmia1gitGGXT7MyZMK0aAS5WQq?=
 =?us-ascii?Q?KdNAc3fKUPDYNs/vDCVkxN4n5/RtOcQ5FKAoX9jui46Rn1CVFNn/0V5/4WMn?=
 =?us-ascii?Q?9EoQaTZJNOIaNYswPAY1zqzq6DD4a7bAj/Pz1xionANPa8c14eMsbjAtlDHO?=
 =?us-ascii?Q?B0uzZ+nppQaABhg1kNmQALbpk4xy/qZfFtVbL5i8cnrf7ZG3Ti3QYdkLt6aW?=
 =?us-ascii?Q?VxE1roepJYQtJF6CRoEwPpXf7Oow1dBNM7vL0luz7QkqDjLdpN/dgTK/0c7h?=
 =?us-ascii?Q?tS0bui2nDOGdOpOXhsSJm29ne3DqB5mFR4ofAgOJW1dCzCG2F76Pxt2Yd5Oy?=
 =?us-ascii?Q?qPM7g/eYZ9Q3LBl/MvQT4F04?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(52116011)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DYdhvNql1nVtbcyeUTXBlIsyD003EScN/rcTPMXqsVapr4UY5LYiG36qBd15?=
 =?us-ascii?Q?pKQ2eMiU+SxCyfgrRqXjLlu7VaS8bXymLB1+siMizYk+tsxP3m1eVowrP2x8?=
 =?us-ascii?Q?eRrIkIc1jpZE078OZAxv7BU6lGWnDGYHC8xrV5bEN4zVjJYhCSTKT1luvFhp?=
 =?us-ascii?Q?lCE6smWKEUV36DCNAFfG9OKvrVHPSuX/jMF+uOTpirT3D5JYcFsAbSNpz5OC?=
 =?us-ascii?Q?kNorkqBCCJyrDVeCb6o/JHmzPCRSV951sijSP9V/qpEGi64iyJql43QYs7FP?=
 =?us-ascii?Q?o3NcspeYzfoHq2eyZBozWSLITzuxojMVLnI1z9dttLlmYnSSSQNjhnS/46jX?=
 =?us-ascii?Q?IzHNTk139/v0q6hsVVG87Hr1AmvdkUJMReJrH3X8iSi0ugq8yNz4DYOQghab?=
 =?us-ascii?Q?lqehIvu0AaDxwD3m1GceqqvHJCPgkabyy7dcurEj5sacvL/cxQflhWV4tcVv?=
 =?us-ascii?Q?U21Q+LU8UqO/JzEo4ndmSUqNQYfQTK6ZpHPGophqDVSxgPc+6uNeikZKZQbt?=
 =?us-ascii?Q?2sO6ydG7CVCTj/uheLY/ePoK5yA3zp8NM589cdsV6UVIxDzeanzZdmEekSsE?=
 =?us-ascii?Q?1QO/VLkyBIvHjxQDq/dfOwZEpl0PNuxi+Zl7dd+lPnNTzf1qAdSY50/l8ZTB?=
 =?us-ascii?Q?p0Ve2iPFHpbGBkcdqVYKOqFnNu4PD3wiw7hik6ZbN4gHvFptYHIkEKFIKgZT?=
 =?us-ascii?Q?kxIdpg/OXoeMVIgW6kDo7gfJyA9lDkacR4Wq8AlPoVOxPs2LIQpZW8TICY3K?=
 =?us-ascii?Q?NJxGN8TjZuOkciVrWSFFRfwsdWC3kR01tkyUL5ziqNtx9go6FBubt4tfxVqD?=
 =?us-ascii?Q?rfnFJiF6kOwItIrfH9EOEwP7BdYgQnt0Pmh0dLiJ4A7Tr9ixKaUf77UE7Tl2?=
 =?us-ascii?Q?3o8sDWnsxmrWUSghxvHgcpFo8DqmTXUg2IzofmdCSpTdblnVFYEyAtR24NwD?=
 =?us-ascii?Q?ftYOlW+2xK3zVj/wkz/uCki3XGv7a6SjmNA+xzoCedPVJGCKVCg2zjnLueTH?=
 =?us-ascii?Q?Q7dn4lkXyBSlQ7LGZLyZLWOHe0awoh/6fvOTsYMIiF5LcDLLRlbmkytCfw1G?=
 =?us-ascii?Q?BtzFvF8iLXu9WkTlIFK6OOMq1s99ljOU7TpRw6lvgR6lkBbCyjUr7pe5xvhK?=
 =?us-ascii?Q?LePBaoPalItmaWNVGsYiTr2ArjKItAaLX1CiEazCPRooYCj7hPA7rswy8BGQ?=
 =?us-ascii?Q?12+QesXXiXgf37yA2zerAvY2q2CYy1A9XXMUoe8ivS+DLBik1Umrm6/oiyBB?=
 =?us-ascii?Q?taFeOJVkXE0BiqtAJNy029RZlM4HI11rf5CC7NtIZjoNqzRRCkuHT3YZiDqv?=
 =?us-ascii?Q?9+toovYcLQEGyQUZ6cN7PNCNC951lzqepTgJUpqhlsMQq1tnWGsHZrFYoAub?=
 =?us-ascii?Q?ba3IVrkfE7auiTESBWtY3qvxQL0au7Uo5TvhTaDpD55B43XwU6KUGMLArnuF?=
 =?us-ascii?Q?pikhKIXPRwriau7yCEj8jkekZO3wB0S2RjnVXgBaOXvjepRX8lhAlvAfEa5R?=
 =?us-ascii?Q?JWrNFrvVDuYcgfbKhwC+HeEEaLPSgbqi0Gj6OZwTA1zxTOE7fYiKfXgQGve/?=
 =?us-ascii?Q?s569UbOZ7TWJErEMlMY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd2f085-ece0-4104-f184-08dc91fffcd8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 14:39:42.6108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28y0LRaC17swsDXLSpKxDRMcbO+ucZDjGYXN+x7lzeKDB4kWlPeUE2aotk2DfO0z1mG5NoFhqQFk+8dzLVzCJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7095

On Fri, Jun 21, 2024 at 03:42:11PM +0300, Vladimir Oltean wrote:
> On Thu, Jun 20, 2024 at 12:58:28PM -0400, Frank Li wrote:
> > Convert dt-binding spi-fsl-dspi.txt to yaml format.
> > 
> > Addtional changes during convert:
> > - compatible string "fsl,ls1028a-dspi" can be followed by
> > fsl,ls1021a-v1.0-dspi.
> > - Change "dspi0@4002c000" to "spi@4002c000" in example.
> > - Reorder properties in example.
> > - Use GIC include in example.
> > - Remove fsl,spi-cs-sck-delay and fsl,spi-sck-cs-delay by use common SPI
> > property.
> > - Use compatible string 'jedec,spi-nor' in example.
> > - Split peripheral part to fsl,spi-dspi-peripheral-props.yaml
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > 
> > ---
> > Use part of Vladimir Oltean's work at
> > https://lore.kernel.org/linux-spi/20221111224651.577729-1-vladimir.oltean@nxp.com/
> 
> Hm, you took part of that but gave no attribution? The portion below ---
> is also discarded when the patch is applied, so even the link is lost,
> FYI.

I am not sure what should be added in comments? 

Ref part of Vladimir Oltean's work at https:// ... (I am not sure if allow
http link).
 
Or coworked-with Vladimir Oltean ...
Or use seperated patch for your part.

What do you like?

Frank

> 
> > ---
> >  .../devicetree/bindings/spi/fsl,dspi.yaml          | 115 +++++++++++++++++++++
> >  .../spi/fsl,spi-dspi-peripheral-props.yaml         |  28 +++++
> 
> For consistency, could you name this fsl,dspi-peripheral-props.yaml?
> 
> >  .../devicetree/bindings/spi/spi-fsl-dspi.txt       |  65 ------------
> >  .../bindings/spi/spi-peripheral-props.yaml         |   1 +
> 
> No MAINTAINERS change for the schema path? There was a discussion with
> Krzysztof in the old thread.
> 
> >  4 files changed, 144 insertions(+), 65 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/spi/fsl,dspi.yaml b/Documentation/devicetree/bindings/spi/fsl,dspi.yaml
> > new file mode 100644
> > index 0000000000000..924ba19aea017
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/spi/fsl,dspi.yaml
> > @@ -0,0 +1,115 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/spi/fsl,dspi.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ARM Freescale DSPI controller
> > +
> > +maintainers:
> > +  - Frank Li <Frank.Li@nxp.com>
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - enum:
> > +          - fsl,vf610-dspi
> > +          - fsl,ls1021a-v1.0-dspi
> > +          - fsl,ls1012a-dspi
> > +          - fsl,ls1028a-dspi
> > +          - fsl,ls1043a-dspi
> > +          - fsl,ls1046a-dspi
> > +          - fsl,ls1088a-dspi
> > +          - fsl,ls2080a-dspi
> > +          - fsl,ls2085a-dspi
> > +          - fsl,lx2160a-dspi
> > +      - items:
> > +          - enum:
> > +              - fsl,ls1012a-dspi
> > +              - fsl,ls1028a-dspi
> > +              - fsl,ls1043a-dspi
> > +              - fsl,ls1046a-dspi
> > +              - fsl,ls1088a-dspi
> > +          - const: fsl,ls1021a-v1.0-dspi
> > +      - items:
> > +          - const: fsl,ls2080a-dspi
> > +          - const: fsl,ls2085a-dspi
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    items:
> > +      - const: dspi
> > +
> > +  pinctrl-0: true
> > +
> > +  pinctrl-names:
> > +    items:
> > +      - const: default
> 
> I don't think that pinctrl properties need to be specified in the
> schema. Somehow, I think dt-schema applies
> dtschema/schemas/pinctrl/pinctrl-consumer.yaml by default every time.
> 
> > +
> > +  spi-num-chipselects:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: the number of the chipselect signals.
> 
> Worth mentioning that this is about _native_ chip select signals.
> cs-gpios don't count against this number.
> 
> > +
> > +  big-endian:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description:
> > +      If present the dspi device's registers are implemented
> > +      in big endian mode.
> 
> I'm not sure that this needs an explanation, it is an absolutely generic
> property with a universal meaning.
> 
> > +
> > +  bus-num:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: the slave chip chipselect signal number.
> 
> In fact, no, this is not a chip select number, the old documentation is
> wrong. It just gets assigned to the struct spi_controller :: bus_num.
> In my last submitted version I wrote "SoC-specific identifier for the
> SPI controller", that seems perfectly adequate.
> 
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  - interrupts
> > +  - pinctrl-0
> > +  - pinctrl-names
> 
> interrupts and pinctrl are not required.
> 
> > +  - spi-num-chipselects
> > +
> > +allOf:
> > +  - $ref: spi-controller.yaml#
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/clock/vf610-clock.h>
> > +
> > +    spi@4002c000 {
> > +        compatible = "fsl,vf610-dspi";
> > +        reg = <0x4002c000 0x1000>;
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +        interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
> > +        clocks = <&clks VF610_CLK_DSPI0>;
> > +        clock-names = "dspi";
> > +        spi-num-chipselects = <5>;
> > +        bus-num = <0>;
> > +        pinctrl-names = "default";
> > +        pinctrl-0 = <&pinctrl_dspi0_1>;
> > +        big-endian;
> > +
> > +        flash@0 {
> > +                compatible = "jedec,spi-nor";
> > +                reg = <0>;
> > +                spi-max-frequency = <16000000>;
> > +                spi-cpol;
> > +                spi-cpha;
> > +                spi-cs-setup-delay-ns = <100>;
> > +                spi-cs-hold-delay-ns = <50>;
> > +        };
> > +    };
> > +
> 
> Please remove newline at end of file.

