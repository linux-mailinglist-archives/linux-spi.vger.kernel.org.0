Return-Path: <linux-spi+bounces-3652-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A16DA91B1F8
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jun 2024 00:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C31CD1C20C72
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 22:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522A91A0AFE;
	Thu, 27 Jun 2024 22:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="obiJYqa5"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2046.outbound.protection.outlook.com [40.107.249.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858203FBA5;
	Thu, 27 Jun 2024 22:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719526041; cv=fail; b=IiYyA/UOhYpZ7tgtqmWjMF3opR7/FmqwPISuEppzRqLU0yP74jZCooaZpXH3zkgVKeapXfV6Ei/6ARUwidS12MvSaHSweYdwZh8hh1HYior9NrFmw6MpkuPXZLj0kciDnQQ1kU3jLwQd2uYJ13LWE1w9qDCqYCwQqRwGEpImaNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719526041; c=relaxed/simple;
	bh=Acd7Jj3kF0hgkKkisMR3tOd8/EwPQDJY0LYdilYFNYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kw848VnOJ/Y4KeVq2S14MewsluPsDBgwouMs/B6cy1qPrN5Pcwlxi5Sw3eZrLKCtG8vUhgSXg4ohJxtkdRS5IkHrbXkTrjJMhjlEfXRUy9UUzPaMbx6dfj3cILNc3DAKI2frZ4ekGWG2v+XOu2ZsL1QbXb4xNarC8FhXqFvrLuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=obiJYqa5; arc=fail smtp.client-ip=40.107.249.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONxBmhchor1jQYfxkcvTwwv0jY7t9zy3GnYnktGMJigGbvAXLFzzZQG7xVCz9ZM2x5sE2aXTy0CY11773itnBR9CcYIi6m/tUNTJc53dX14i6Gtrc+2o1sOoB3p8BSlS5TZbyzTNWSco6I8b7IvA2hh7oubN0ro/9R0VMDxg7sQRGa5hFPRcty+gOQzDZ2WziMCpKcMqUa8drNNozv7pWgXnGyQK/tflN9CMNV3mvwjfv9nnz+/MrV0CSW4aPzElf3R+7fqwp3j7PWnSnnoh+pfSP3j3aXCRp0JPHynDn6u1cKTt7kMnPd1M4cfZN4n5kwYvRv2McXPJC6i6Bcpeug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kw7RfMEnEqnRglnOJCx2np2y4T2u4KY+wYlvQu3xRo8=;
 b=BrSXSzj6RgalKUPYEv5fXEqA15VV+f20ID5vgxJExCymrrKipcsEJyOqVdIULKiqz2isXv5o5Ahux4i0YQUh+FoXz6SFofFxD/3wB/H+ScVM0MncHw5e72rK8NcePC7ooQQYEDoKkmztTwda2gBMl8PgTlLrFTG1eVp8vOiE2g9/nZjBV1eY50ZSnCnXattxcEWKlJJxqPOck6LDbNOXuCuHFQ2bHmi/UhuOZvixnJR0E3EXmovSGPPkRNBUT6vA7gyVMrCxl8WWq/fI6AKzZ47iqixBD/qcd3EnsLjnTtC9lml0QYRiKruvsZGtwJX4hNB3kAIqaU1aPJVyd0ppaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kw7RfMEnEqnRglnOJCx2np2y4T2u4KY+wYlvQu3xRo8=;
 b=obiJYqa5l5i8KliBUJ5GwCLPfkLLdLS0TgYpR5HOmXao3nGwWt5hHch0gs/RnSBu3cDqlwFqgnbOwdwdx/GQPUa/QzZEWohap7JxUHB95yvQGfBMlSnelIjjO4iHc9KtjMZ7ae3e0kvDGrImyOFXouRD3tRvmFv/V4nvK43RQxI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10779.eurprd04.prod.outlook.com (2603:10a6:150:21c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 22:07:16 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 22:07:16 +0000
Date: Thu, 27 Jun 2024 18:07:08 -0400
From: Frank Li <Frank.li@nxp.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:FREESCALE DSPI DRIVER" <linux-spi@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] spi: dt-bindings: fsl-dspi: add dmas and dma-names
 properties
Message-ID: <Zn3ijCEwiqgFfwTj@lizhi-Precision-Tower-5810>
References: <20240627203308.476437-1-Frank.Li@nxp.com>
 <20240627215338.qrry6zpkusw5nazw@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627215338.qrry6zpkusw5nazw@skbuf>
X-ClientProxiedBy: BYAPR07CA0052.namprd07.prod.outlook.com
 (2603:10b6:a03:60::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10779:EE_
X-MS-Office365-Filtering-Correlation-Id: bd1582e1-0842-4222-449b-08dc96f58155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fpaZjnaQ6RtCRDoYi+JsqwkNKrkgtWgnnPka9oDi5wpOVp7WYChqzCqDtXto?=
 =?us-ascii?Q?FZJlflS6ELAB3hCjK8xiV9a6RIeLu1OjJSKVUD09MNb/SxMGgj8BZNpHH7Mr?=
 =?us-ascii?Q?HXY4wcMK5/AL7bxbIm2GhZj/04kBpl6N74qwQWxHdqSFQ+dxFceFZxtTt8pE?=
 =?us-ascii?Q?rjYlBwcHdrff+q7CeW4AgRnoFLKKIMWUpRdhOhvnnjM5veXq83emQT9dj4Bn?=
 =?us-ascii?Q?yi5a0G/sF5Vf7uoSChYUOEcQ6z6jR1o3jAymVL1b6Xd1LC4LsfAvMl+ooeei?=
 =?us-ascii?Q?QHEGqLQjpAIa6ul5IpqyloZ4z+nHV/n8vcV0dp618/ImmE5ZepxymO8WFxhA?=
 =?us-ascii?Q?n+ucrlz7KhUlLm4Uw025vAbs2GmGwBcukIgl8DdYrhyGBnR5eirHs8HcS4hc?=
 =?us-ascii?Q?ktG1Phbz/1UjP2jSZXAz3+8yg/5+U2tZRyq7Cu0v0BgcHR7j28zqT1RREpYt?=
 =?us-ascii?Q?pNVGgyi3qPtLeTdrGOVxhxQtC0gwj4qhBCuh3B/RDJh56mbDbUTvPUq2WSDi?=
 =?us-ascii?Q?iEYUplOrjOEdmyCetLAL+r6LegcumKAfJPfibild3OoGZlPcjLXDDmMy5u1k?=
 =?us-ascii?Q?yxiHJu0f/R/xq7Ihyolqi8OjGdEsj7dho/pWfEEErfhIDVEQxmdqAGwssPoH?=
 =?us-ascii?Q?zA/k4ruEf4DxMPkEzEEg7pGFFYlLAFcXJ7hCHknfznytjsx0hYZCMO3clwqR?=
 =?us-ascii?Q?QYWYvObJv8GwrAYEYsHW32PyFvGSLRGPfRVRk9EZqlk8W+L7MhgcmvRbfMaz?=
 =?us-ascii?Q?bX+jbh0R+ynVLwnVmbpj9kEML6qhbibtd90+wJZwB0hm/mdLOzftCpEn1AIh?=
 =?us-ascii?Q?D7cGlX38fl07iOwnB8RlXEeslIqwn785CrL0RXShZ1QrP+z9Jdr1E9d73g7Q?=
 =?us-ascii?Q?PjRHiPFi1czdQgFapGyG0rZ10GIWdhsicz1YF8TTQX8OodxBGGfhDV3jx5vn?=
 =?us-ascii?Q?oR8EO+vi3wZuLo7l5/YQttkD0JUBqzkIxMH7NHFZqZKeMsoZvl/82nn+R6K4?=
 =?us-ascii?Q?sXP1OAWpWww5E1jrphBj1TFFi8MdLD6Pdq9MY3C4Oz2AKG8VTyNFpDEfHAHT?=
 =?us-ascii?Q?G2AECevi34TqcHN4ayRj3Jiv2ah4b0dwyKXuP36cVTf5QuAQBuBT8Hf+ZQEm?=
 =?us-ascii?Q?fZDM7aCLfIWhVlH5434FZ5tEeJa/u+LDhbC7rFqW7iNXbSpvtFsQTNze7HST?=
 =?us-ascii?Q?TTIkBKOdW187uOi/dT21lPwBJG0kQ+U+ab6n7Pf3esj/edbNhR723i3UvcqJ?=
 =?us-ascii?Q?uiueFenV6z2avm9yLa0TxW2M0purZBH6yW8D6cYr1RBQViRfvayjrKV9LhNM?=
 =?us-ascii?Q?SEZPRN1PgJCoY3+I0313cwl7JIEop6XblblYtgC+bUOlpG62QUE20ngHQ1og?=
 =?us-ascii?Q?jkIPCcs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gx4kXROrORb3SG0UgNL6TilO4jpmoVHRQZS1KzoyjUuOfIZLeMUaHVUHgUxh?=
 =?us-ascii?Q?fQgqdsVhrwIxwc/awO58K78qjhX9F5NM4EehdiO1LF5M9NK5WuvN3Y9Ua3vI?=
 =?us-ascii?Q?266/qKsC8U+RjQdEkZla8MGFd2XUoQcwAt67eoEe2D46wOC3Gh4VZPi8YmJb?=
 =?us-ascii?Q?0WLH2Q7bHV2Lna2n8fca+1HF8sc2GtLKFX8Oo0Ofoudn9KVUk3B1ToYKRjVA?=
 =?us-ascii?Q?J6P9tER3loDaLXz/zzsOnbHwpgDR92BPqhBWKhz75JiV1cWJEQKmwuXyaFFQ?=
 =?us-ascii?Q?jVElywmtPbz/qmMuvmNDB/lz7xdLCP3gVSowNSrmowKPdzk0M1Cxa62LghO8?=
 =?us-ascii?Q?NtFHZtp7PRX1N1ofJnzkw7JB1QNFKQ23KOOqtqYfPclUz71lTZbDK/DP2UFs?=
 =?us-ascii?Q?+FXfYB5U2tVV8RR7XECbcIKrrVihQfM9u85hcUkAEDjqpGvfIvf8kG21PFXz?=
 =?us-ascii?Q?Nj1h35js65qz9A70ut2dkcZk3YH9ZlCM9zMqLL+vCoxrgKWLgPt8XjxO2seD?=
 =?us-ascii?Q?cTy8B1eurVc7JL3w8XyrAfxVulhXWxrPoxnB9OjsGos50s+HiQGoCiD94sSP?=
 =?us-ascii?Q?Tp+jKLVyD8B6FSZR7N9SMLEkPQf1izYBE4IhkQqU2qy6TkaJkJW5S88jO5mB?=
 =?us-ascii?Q?KiLlLofOXl8I6I2ny1SHmXPwRGykFy2jksgNPr+31RkvIxtgHrNMsy3VHLn1?=
 =?us-ascii?Q?hJ2t6/8sEYxzjba/bdXQFzXT1jSL7optEjLoDZ6zMbqzulsqW9PYq64W1gYC?=
 =?us-ascii?Q?v6HrIi/R7UELNCREROV+wDj2znxu44D6gcF12fJAJ/pqLUPPi5PChX7kmd4c?=
 =?us-ascii?Q?/sPyvhJoLy551IHSWIfydDGtm6zsHZnfS9Dy6w7jxbmvEA4GlTL6axfLHVR4?=
 =?us-ascii?Q?NnvBtHQJj82K4AKGhSvTatNzaMb5gtKgc/GkMshpOP/+KboQkIdfv4sHr0cI?=
 =?us-ascii?Q?5oMrLQ4jWHX5GVxK2880DaOgWTrnY+LQkQ4wGakCE4vj5KZkyx2q+gszmU3I?=
 =?us-ascii?Q?QtG/FHdvRvjBSnNkD4cqE8VB/8+vwHkp6RaYjEh5AK82wjTNNsbNtGoPqRXo?=
 =?us-ascii?Q?Xy2aNC/kd76Wh1N8DZmDq1gTMa+nitx7/TrIIy2OHRr7NzBIKmoAzy8Bf+rW?=
 =?us-ascii?Q?g0w7/xvHcE7uVFIUBRL+S7rwfncQ1Y5SIC2BUMotTofI4MqK4uwtgllM5cRK?=
 =?us-ascii?Q?HUQc/OBwmLppbwjK75HsQOm49gtwdWlY1RNv9MDAuq5Zj7TF65j5O3O+gKaE?=
 =?us-ascii?Q?IYQ7ItIg8AMKOqmEuxBkoDzil5VN745zQ2f6Q2Xlo42poMzGVY63hV7z2frC?=
 =?us-ascii?Q?cNdvkhrN2lBHAf9camBs9jowIDjF1u2IjIuZZ2Nha9vyn2iF4a3/7sULm/+C?=
 =?us-ascii?Q?dxCh/NoBYWWcEEq4KE8RT49MKjYrOo7FTqAM+C0V3NLo5j8borb1qI0S62Az?=
 =?us-ascii?Q?FR3nsQkHl3HpdpLmECX27lw4k91/H69Y8FJ0WpZwvZgSr109uoW/QCN62N3X?=
 =?us-ascii?Q?dA8vKIq9MRDQNM8EmGZ8KqEjo1WmebfXmJH4rzY++HFrEgKSsMgbtpf96s8P?=
 =?us-ascii?Q?RWiI5ZipMXzGDvzOBpM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd1582e1-0842-4222-449b-08dc96f58155
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 22:07:16.3043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G2JK4jXkHFdwxWCkia508kx0g2DrTFfWH9kMGNdoBD8mxoQ1iUzuDfjZgg0XTh9pm86aIb/xAqD4KCZPpRGrRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10779

On Fri, Jun 28, 2024 at 12:53:38AM +0300, Vladimir Oltean wrote:
> On Thu, Jun 27, 2024 at 04:33:08PM -0400, Frank Li wrote:
> > Add dmas and dma-names properties because dspi support dma transfer.
> > Fix below warnings:
> > arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dtb: spi@2120000: Unevaluated properties are not allowed ('dma-names', 'dmas', 'little-endian' were unexpected)
> >         from schema $id: http://devicetree.org/schemas/spi/fsl,dspi.yaml#
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> 
> For the contents:
> 
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> 
> and FWIW, I noticed this as well, but didn't want to put yet another
> roadblock in the conversion of a binding which was way overdue.
> I was planning to send a patch as well, once the binding was merged.
> 
> But... to whose tree is this targeted? I only got a notification
> from Shawn for patch 3/3 (the device tree change), but none for the
> acceptance of the other 2 patches.

This patch base on the below patch:
https://lore.kernel.org/imx/20240624-ls_qspi-v4-0-3d1c6f5005bf@nxp.com/T/#t

Sorry, I miss understand 3 patches already picked. Actually only pick 3rd
one.

Frank


