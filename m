Return-Path: <linux-spi+bounces-10797-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3C7C03D59
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 01:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0170E4E6A0A
	for <lists+linux-spi@lfdr.de>; Thu, 23 Oct 2025 23:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF552D94A8;
	Thu, 23 Oct 2025 23:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="e3OA5gnY"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013012.outbound.protection.outlook.com [40.107.162.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925742D8DCF;
	Thu, 23 Oct 2025 23:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761262189; cv=fail; b=ntpMOdR3vuMrazIvL4QhKVsC0WdX3zRrVM/Zq3dRkGdrarSMwH5hgWQYx6nYjb48RYq1Nis/Gblu8B29l5AwMPqS48PVNx6iIw3n2XFnXP2s8WOYUBeNgbh+pJ7dTRZwH22yDped0nN3pAShCkVcZ7yD83sPi3mqHHZ8vV+bnYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761262189; c=relaxed/simple;
	bh=nKTgxEsaSLHzC7lJcQ7zT0v/t94vMAl5ZzcEcXNtAlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=isg42SKf+QcLJ3riBqcESmopNZjr+tx77u03h5hS9CLSvkB2u6utl7Cq9fEwDganEqklfyGWIMQWcfckz+3ReMBvLCu8aFDi7g4OLEUz93HJAKDT5+JObxmnQgxogeTkFlQWlIT/S5H3kIN3F+aS6VDoM9K9K1scnHI5zfx+how=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=e3OA5gnY; arc=fail smtp.client-ip=40.107.162.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=laH52d8oNg5rPNfw0pOPbie6h/xk7JQDImvdEDpl7F/vHYcSCGZbAQzni3ngCQkz+Q0bKyXPI+NTxa6d/4OlOtu01FoFL0x/ceeDGT4Cys8R8S/u+NSlvQgSWey6fCz8YxuJ2nkIR1qsoeW97V8pV79tr96cCGglxgno+VGCknB5jRJeGFk79iqSTeFE/D3JH1Os31OlZEVfK4FjHskmkSOdUkXuccabpMQDV8XVPk5kNxuNHytZsdBF5Dm7vqoPvtKzbkylfL62um+8EaC1cfvqZZNs1ax4uD0zy1UAYltzwco+c2eUrWporvTg4d1WMSc9lysMR1m5JXMtls40YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OURBtft6fp83qEQhC3vmhnIO4jgdT5SyF5mEMNJrloY=;
 b=MHiiJEIb9vfOSEzlNfj+n8Xz1xTVTkIVrpcjFmOrSrmjwbc8zmrNrQnQDP8y9JBopIaiVaBGYImFK0Z2l/2CWskzCi6zisqsQlDc/LYs/y1oztk5l9ebpKbdRX5YZAeltMXh/6/Jv1LKcfScR0PTjIwM5BKHixgKCkneXZuRfKYBiwXE9jixn9Lfx6goPd3N90nwAGhKlfugMlf16APgg0Rew+LWRFN4PIKRGC7ump2KKQWmZ2qSCAi0fHgUYqRQy23rahbzG+3i0gvR+miEbBtC/Xyh8hlFaGpRGwDECQPsvahlrRWR6roXOa27K/zNakCri98Br23TOosqVN1pOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OURBtft6fp83qEQhC3vmhnIO4jgdT5SyF5mEMNJrloY=;
 b=e3OA5gnYuvCypsNflaeANTTTYe2UhRfvhymXyHbgsvyh2Pld2c3pDfewptS58pI84RILjp7v5wQt2zIbqm8B6JjMccUR6k9xVnfb4Js/H+FKoS+GoSL9aDf4StVrG/1ESXzp0XV8ZDc620re6F2ho/qASkM5t7eZAbjwjxFA1LwY77l2VY3NSW6tJlJKEb0S5soZ8HgMo/bCImMSN07h+DKcOs3Y0NrzUOWxbtMsSxan6g26m53x1ZOZdr8if7lHWTPiJJCeSYxUsbjAwRSu4eJ+ENCOFcdbDZdOvHd1RAW12Rjqgok/E7xre8yrojTZ6W31wWvzL8qfY+wvAUc9Eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM7PR04MB6806.eurprd04.prod.outlook.com (2603:10a6:20b:103::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 23:29:43 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 23:29:43 +0000
Date: Thu, 23 Oct 2025 19:29:34 -0400
From: Frank Li <Frank.li@nxp.com>
To: Alex Elder <elder@riscstar.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	han.xu@nxp.com, broonie@kernel.org, dlan@gentoo.org,
	guodong@riscstar.com, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/9] dt-bindings: spi: fsl-qspi: support SpacemiT K1
Message-ID: <aPq6XkKqWg+KqfEB@lizhi-Precision-Tower-5810>
References: <20251023175922.528868-1-elder@riscstar.com>
 <20251023175922.528868-2-elder@riscstar.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023175922.528868-2-elder@riscstar.com>
X-ClientProxiedBy: SJ0PR13CA0237.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::32) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM7PR04MB6806:EE_
X-MS-Office365-Filtering-Correlation-Id: 080556f4-3f7b-4d10-0d73-08de128c0bc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MKNEosMmyNX3yYDcko9e2B2z2wGKE5Dz1CaCrdJBtm4jBP+gtvN64KD+H/UV?=
 =?us-ascii?Q?vrJeeex7dBWDqeXHph5XITQR/CB8MJ327due++CTy4DPDy+5IdaNm9uIaFj7?=
 =?us-ascii?Q?cwMgz2pOq1EwgieihhZ8KPrS6EJT99YgEEm7P5xUpW7q+E7+7fupiiBWeNob?=
 =?us-ascii?Q?PyUhi6VN/vzcmU7r3V8iBstSnFELGSkS9f0iIgykXSz4Br2F5t9V7ivqMG8G?=
 =?us-ascii?Q?wQOgHLeXyfhjyzlUWW1+Ef1H38M0Cx5MCJRYn6SbRjPh886rZGBvxci2Z2df?=
 =?us-ascii?Q?VZhOywWxakZgQFGAYigwlh1CnmA0MhQwzorzkfXXCPLqSlJ8DMSIvCY5QBKI?=
 =?us-ascii?Q?s8qW6LoDhqimYzbRwNfTx5f0glY2PbEFyNJT0Q4/Ed+vBYmYFIIZfwJBA8pk?=
 =?us-ascii?Q?GspwvfzX2DJFGAs7ZfNo2HbssgfLgbi+EmAJC85epEYGXdmnh43udhbSMu0+?=
 =?us-ascii?Q?toRzF68DM0+3453K5p0f3Po4P2e29JNX98DQxvrI3WnQW26xZJiO25p8FCRb?=
 =?us-ascii?Q?CwVp8ZDRLU2n9nQxtHcuTSSnMDAYZ07d4mz7R3nhWnD4OKUcEfxkUUmeKFYU?=
 =?us-ascii?Q?Q1mI0rJlJxR/0hvNDTxkF14gATNFCTZoe1wHRWiAscAbCpmqw2n+2cvHWhaQ?=
 =?us-ascii?Q?HMANFZXbFhywPL6RdPkBrPmfB/06sbsIyX0tVyi5mCcRyScA47mg8FO7PWvE?=
 =?us-ascii?Q?tmGA+an2JGu9wo+mT11ScU+fsWYURx8o+uumy0ERFFWnzx3HSVoSETUtvmPk?=
 =?us-ascii?Q?mjAcqOodtPBVFpEfp9fa+3s1HCKgJHOcRZe0A1fj3+aNSJbmRNgLj4a80xnP?=
 =?us-ascii?Q?syK/q2lwUF2ay/Sc4yV9ponpsOzSBvCJnnzCzV9/f9r2Cw+Iz4Yjs1Eqs1si?=
 =?us-ascii?Q?OyId0mm/vuXgNcduMSw9r+wqpbcSY9vnxKiYQA9HXSa8MrqrZC9rS4R6ne2R?=
 =?us-ascii?Q?pLM7hEOl458SwaVEqmz3LXakJndajJh0Z62QnPtGjXF5DvJ/MSEtCr2PxOXM?=
 =?us-ascii?Q?0MEcRkS+lFxmyWgSeXfsehixUFwuG5k+/HD1aNdJkrrTQrTJc8RQfDYBu5XP?=
 =?us-ascii?Q?ciNEJCZHaxB+Vwl6ZjJHdncZwRDlZRQBmV/1u2TKH4vfXJkL8TdWZLLU973U?=
 =?us-ascii?Q?bAIA0ZTwrcGz4TPdAbiRK+FWU+ASQZP9GvzUeHi+Q8UP1DVsvYSxL62ojypN?=
 =?us-ascii?Q?qEL8Pkg40j5No+9ZkBEyrDEioKDkrvDaRWfA52w8T8NHqUZzMWZIpHKDmuaY?=
 =?us-ascii?Q?S+lEHoYJEgTdLM/L5Lc9gSv7JlOxaVQUQ+P0OlqpxdmMuXzYvtCacwgXjs48?=
 =?us-ascii?Q?uNllMSZ3I/kEm854hiNEfpZiAs4gNsafJTa1gTM+kgpb16NCQMkYbkBfwWiH?=
 =?us-ascii?Q?m5ByDUHhVKyIm72qDSDLdaii3WdwyDW7eES+FezZO8ee4z4pxaG0hGRBghK5?=
 =?us-ascii?Q?MsigDBm4fFKANN51+ibQnWdkjfI87367iovRKcK7R7GHzbc3lidnxrh2XSp9?=
 =?us-ascii?Q?9vmNDi67nP9fOIAkI7fdj5vbMSHdXAbud5Nd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j47c4PPdO03SSfSpOiikCvahYxrRwLFMhrEOu/bx+g8hr5ZejCWiHUpqY3y4?=
 =?us-ascii?Q?mx2p2n3SLG1Yw2YSed4m6LyV08utzAqOgDwpZyfpzov0QuT0nsX6yOZUh28e?=
 =?us-ascii?Q?DTP/CEhAAwLHlcbjycBS71iBul+kJ9DsAk6Rg0I9gCTNsaL2OKJWcfjraRsM?=
 =?us-ascii?Q?XE6j3PflFKGH3BPfJRuX274cGw4gP2NjvIEzNIn2Umv6gOfm8bIEJFDebeXL?=
 =?us-ascii?Q?V9NnbduqsLVb174KlzIK0bssOgOdzwVjz35Djzo50c9dRWaRGhONm/nmebhc?=
 =?us-ascii?Q?6Wz25btAhnL32OgY4gbibXIsb71pnzDE6wU0nC2JbLN9NSdvVYrya+jLLYRx?=
 =?us-ascii?Q?BpFL0ppMObV8m5LzwcAyiqiH3B83aYqK3MHv2cgbU8BnvIg3f2dyRMyR7vpD?=
 =?us-ascii?Q?H9RKtb7QAmt3e6CW23gHp6Row7tty2RswFycojN42HG2DqrmY2FtOGsJQT6o?=
 =?us-ascii?Q?OWLie6vpkfIyR1I5+XfqV9XIgo1YGOG4HNt5qH6pKUwc9aFvGnxJ5RP+V5BP?=
 =?us-ascii?Q?C58nSlbhoCqofA2ZZmlZ/OaUmnSA2u/De8HkVxWyvZY13R19Lt/xMQKXlunL?=
 =?us-ascii?Q?5Fcek/3MdOCNJdcTyy79Ao7tuVhWIa0WTQFtS4hFETFXk56BpKHoIHqORUOI?=
 =?us-ascii?Q?aFv9eSoP1SjwRmWQWRuEglBtebMIrdCrzitfQyDHYH4Vq4yaTkv9zxOYyWhq?=
 =?us-ascii?Q?qfkVvxqnlZFQ0vgayk0Clq+3CTGEpbi4wYQI/wlZi4kXrXWY0SX+oZrX73il?=
 =?us-ascii?Q?Hka8Ak1QjdIqoJ1WjeHz2v8vRHfRALMGycc3MoJZFmlhXcVizHyL2DJU/pMc?=
 =?us-ascii?Q?TwJFFY8tRvOXol1c8pZTwuNso07ctybQcx8e36ruPTJyT97AUahIMc23h21r?=
 =?us-ascii?Q?kzB1b7M/Yt+v9u1gm4VgXNxUSzEyYsZpHeQpE07dXnw8/sC7oIsQJUDK6COf?=
 =?us-ascii?Q?HH5+Apr9cnsp4uXdn9+YT4rJcXd+Wtdo1DGfcNiyu6baIdk+6xgu4cZWx2ed?=
 =?us-ascii?Q?dpV6Tomi/OlZOuaATzgcU1YrToMwyvt06y0EgB2HqEfsItaEZmTF9zg+nsjj?=
 =?us-ascii?Q?1/Lv+h8HSsH97ysusjFPZvBRHNthzTnZOW2mo5JzfwrcmvJ7voSAaU1UCGvw?=
 =?us-ascii?Q?/D1mSDNgE9hHtBlPpzXY5TmaAzMPMxptNjEy1p4dBXZc70zZ1NLwBupJF/I1?=
 =?us-ascii?Q?KB9mjCAAwxMnJ92S5Zi8eSmBfDUG6vZeiiIKUb9HjAJvn+I0Pme5GuwEJc/1?=
 =?us-ascii?Q?J3W26ruE36fLAsWgBfA3OrJS3NRRm9T+Vc0v3pzf1zM+so0jZnyG8YYlNyDe?=
 =?us-ascii?Q?hqJ8/pbfMaNxRcCvE7oZMIhIxMwsJg5QK3eTYBrtsdZbT1Stty2jGHe8Nz7D?=
 =?us-ascii?Q?3sxubp6accNeUvDHwDnfPlI1/7DIIIKAADOrOC6UyBrSBcVwPhy7yoXR/WFP?=
 =?us-ascii?Q?B+fkeKUsIlsj/j9oBf3f57cWA8vHaj6bS5fxLGh7zxgYsAib57XdjG9NqVR7?=
 =?us-ascii?Q?jjfcPSyltndhZ1almxs0uUf+4g9Dixv5l2Vfne7X2tTpr8LAAc7sTS9JYR55?=
 =?us-ascii?Q?OCvgVz/s+0EiMqlz+b6u0ra9JERIGdmlpM/oEfhG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 080556f4-3f7b-4d10-0d73-08de128c0bc0
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 23:29:43.6844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EnYogCb0ZdoA77AaIx87h4MPlFkKusoZcXEd7q7cn3bkrCS9+C+QEdPbRPD3EQzxE4XCIz0j8+5TUNP6MbrvaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6806

On Thu, Oct 23, 2025 at 12:59:13PM -0500, Alex Elder wrote:
> Add the SpacemiT K1 SoC QSPI IP to the list of supported hardware.  This
> is the first non-Freescale device represented here.  It has a nearly
> identidal register set, and this binding correctly describes the hardware.
>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> v2: - Point out that this is the first non-Freescale device used here
>
>  Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
> index f2dd20370dbb3..5e6aff1bc2ed3 100644
> --- a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
> @@ -22,6 +22,7 @@ properties:
>            - fsl,imx6ul-qspi
>            - fsl,ls1021a-qspi
>            - fsl,ls2080a-qspi
> +          - spacemit,k1-qspi
>        - items:
>            - enum:
>                - fsl,ls1043a-qspi
> --
> 2.43.0
>

