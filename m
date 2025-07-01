Return-Path: <linux-spi+bounces-8951-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD0FAEFE0B
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 17:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E9C84A34B9
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 15:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703F32777FC;
	Tue,  1 Jul 2025 15:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QKDD0naE"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013033.outbound.protection.outlook.com [40.107.162.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52900278E71;
	Tue,  1 Jul 2025 15:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751383482; cv=fail; b=XPuHgIhf72K7Dj3AzHJ3Gp9y7v7G4dYVx0QM/09UqKmSU3pHOaqu3TxPmQ2OQNXf3yB297q1ausn2R13EiUAMCXVpyGhMcD6GbdBntq25ytLS2N7TtUQ+ZxCzX2zEcoCxi+Au3Y2pBvhu/C3b4zGz891kztn8QVAzCEdQ696DJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751383482; c=relaxed/simple;
	bh=vdz9RXa2Pj1zRN6UTgTcVurVcx49PmA8pfeMLnJh++8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YjugL/J9D2qRZ4ndh/ziqab2l4Z641GhtPnHZGKNsQirStCUNae6ERpjl4/H55ba4seS+08qPYa7pXDOiRdVKmvNBV9zRNao9hHSrIzCd/DMPHH68juVBBEHllXKEkNpep+S9bBXT/W3laqhVkGRqGK/mWpUYmYGhzPmUSfR898=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QKDD0naE; arc=fail smtp.client-ip=40.107.162.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KKhiLsZsEpSpzQ2SxbKs9F05FUyoSBKIU8+uHJNy1HTd+GRLCNOxHN57voJLr+FqgK0Y3gtXRYjYYFgWVIN6U/5vEUNsncg/9hwx9nLUrfe95UJu7RaZaj8NcfOpRWRtxeIo6+731FAx4oTtqgmopR7RYfSzw3gPQr1MddM9pFQZzAdIuUqWIJzDolUCr1D36/3o6UTkFpwHvTIQ2HEv7mRY7Ew88/MAQ8ur9mw38lFv+IiKoOIy0Vikbzo5K7FvHIm5XgnUTK0lo/iEpkYbfb/3NrwiP6EuKMyR+sPxuYIqC4IcZFzhB9Xio3GOUi5tRoSdid+XoVLTSdaY5ZYRog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ww/wNzqxWsrNmJzginW+NYMVUmvs6T5QibKBaOxtCq0=;
 b=jJW1BP+0G9Omori90QwKOqZJyRaVb0sQFFgxyMV4aieXIsNDepZwld6d7QflG/zQX5G5PLZr8U6823+I/rzijsfX3Bc/ftkJKMsPLh4FfKJD9BLi34Y+wLYYsu7hCqJezDZVZFqARRaWlvU5gCY4+4JkiejjYDcl7/l1oEy+P2vdniQjpRd3V7qHmPUUq8MUzcfaEPhmX2ucWeP/l6qW3Izy6XxnGezhQITEbA6Q2ERnYwQY9Mkmz1N2BTnyFiXS8fBiIsjELMX2ofxyft4FQJG6ZRRn4/ffoqnQpA4KkoOI2KoBiQqMTsmldc4img8NAVCQwwdDl6c3O9nJvh7J8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ww/wNzqxWsrNmJzginW+NYMVUmvs6T5QibKBaOxtCq0=;
 b=QKDD0naEdNKMo0tpr+PCUajISnun/umV+wUW3lYBcPPBwTeRxML+YBvgqzeW0btujFu5kWCAdXPIkHd+H3oDU/9EpcH7YWgxhEYJyENQgM6iL5tfgavCm0rQI4xo4wrC2kVko1YLBL7ylLOQ7MwnhvrXlSKEP2TZWWHmFFwpccU3za+55qXyJwANSIbXuR4ASTG+spKECnlztdND8ojmWWobFY2lGUCVQSgCMIG19/hcqnTwLeRCUW5Ld/1I+dDFbKJ7B8mbH70kaKNnV2cE3NyFdXzjKDWZJvGA5djEXOjfXZy5Ch3cbrMcD9CYHY3Nn6H/i56syM2yessnNHKK5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by FRWPR04MB11223.eurprd04.prod.outlook.com (2603:10a6:d10:170::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Tue, 1 Jul
 2025 15:24:37 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.8880.030; Tue, 1 Jul 2025
 15:24:36 +0000
Date: Tue, 1 Jul 2025 18:24:33 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Mark Brown <broonie@kernel.org>
Cc: James Clark <james.clark@linaro.org>,
	Vladimir Oltean <olteanv@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Frank Li <Frank.li@nxp.com>, Christoph Hellwig <hch@lst.de>,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] spi: spi-fsl-dspi: Target mode improvements
Message-ID: <20250701152433.4m54y2rkjzfe4kag@skbuf>
References: <20250627-james-nxp-spi-dma-v4-0-178dba20c120@linaro.org>
 <20250630152612.npdobwbcezl5nlym@skbuf>
 <c9bf945b-9fc6-4829-addf-2fb7a7d4eb36@linaro.org>
 <20250701135747.mns6emamtmxwgpyu@skbuf>
 <3c3c912c-1f33-4f63-9a37-fe4db5d23527@sirena.org.uk>
 <20250701145312.zx56ji4vvaoxwzkc@skbuf>
 <dd41f014-79e8-4567-9617-754b93e2c12d@sirena.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd41f014-79e8-4567-9617-754b93e2c12d@sirena.org.uk>
X-ClientProxiedBy: VI1P195CA0032.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::21) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|FRWPR04MB11223:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c41ccdf-b56f-4891-f485-08ddb8b3635b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YAZb4kOS5e/W7wz68/ojxpvcCl6FKR6Q676FLr/73DAtO7Zg+nbUkxt1uJrY?=
 =?us-ascii?Q?V0Hhof/JPi3jKYtedO/Dt98abyqITAFxWO/l14nZhTKIdzzqKwCGATHUincG?=
 =?us-ascii?Q?uzo/ZVFAuMWKAeU+ZNvpvxXeZ179W7rl5MnzjZrrPE0l3ItfRN9ypgDwcvhV?=
 =?us-ascii?Q?y+70Q6KK5MEvoCWnAKKC+LtSV6FxU4gBLhR5A034JGO5o+4LRE4BtoD36EM8?=
 =?us-ascii?Q?cVD0ahKInYJPChY8fXFpEfax0qFtmkKgWJ6xOiMNH+VOWsEcL2zBX+JQjHh2?=
 =?us-ascii?Q?15YDQS5+9KGQvUgU3ZQGkWfGHUs62oToqoCX9qTASSHD8tJ3b9deRDAyYJIr?=
 =?us-ascii?Q?NzgTojbLeQK1xoeaX2jMGDxpGgns/ofSwSCl3a1XUxRpQbC8NNTAnecHHZMo?=
 =?us-ascii?Q?y9SXrrdtYkyT5HC7dCyg1jNURf9uSiZV2dAxy56zm6JKZJVIR6/AZvUL/b8V?=
 =?us-ascii?Q?0EEfseTh+eHHAiJE8ODUc/bevabGayzVYc/s+h8BFB6B+a0uIa8j9Gi8RKZ5?=
 =?us-ascii?Q?/DNkB9KvS7ac3dCcG+G8udGb02D1WI6fDIALXCBPbWpZBknmaZhel8hYxf/8?=
 =?us-ascii?Q?5WNURl7KO3HCn9V2TFHhrDF7jk7HppLaVZRA5M/LDDmtobQChsnmXTdPY17y?=
 =?us-ascii?Q?5y7y7+WcSQtEH7owb8Pd0paO3mplcAcwhgcjmK1zupcdjP6TvfX1KTna4nc7?=
 =?us-ascii?Q?auGyfuHdQSKVzWXfqTSszy9w4CcIa/jyJEQtaMuMok40FGeV8IjpbDktFs3h?=
 =?us-ascii?Q?HHYABBAOf/JS37ZxbBrvNRaGBge5oYxw9raM0NGz1mmI5fxq580mbkomYJAa?=
 =?us-ascii?Q?xn3S9HHiPU5uvDPTUI7i38d/UyJZyaUAOOjAfvJE0uJr3l09jH93S5bq/tBn?=
 =?us-ascii?Q?qskAFouuFLsxPu3JkvYsdZgHeC9Idak9bp3qADDwTu3bT+PI1fGWlEuKIYG+?=
 =?us-ascii?Q?SKmx+bmliRMf8T9e8O6BRQjlRO2Pc8mnDAsl+RS11Lce8J7TruAL6smmnUWP?=
 =?us-ascii?Q?45bVfp1SZVBz/oBURf2GxEhJ4uGA/qNUozIuQgVdAUjaypXxjIgNvvuBgAAd?=
 =?us-ascii?Q?FRjgcytBNYg4PB42mq38dmKzNo8QuxqvzI1YxyqU8WQSfFBftFRuGI/MpQYW?=
 =?us-ascii?Q?tu25mT7Z5/uJKMhYTVh8ojK1x2Pqn58xPiC92VoTsnv2Hl3s5+/Axyv2Kyfn?=
 =?us-ascii?Q?yXOZJpH8sTovXH3jLq9hcmnzlfibXtWVcmrjxpf5N95Iex8S8VKDu2Afg1nx?=
 =?us-ascii?Q?CUs416Wjmomwlmn1YLphy4WIx7wmr4bzCDgp/LUeqp6XyFdY+jSSWisvKXNJ?=
 =?us-ascii?Q?WoD3FaRSPkmM0jCGWXZ/scmrmxU2JQaZ/HSRoc4Cns5TtqexWO+ebTS5WKkE?=
 =?us-ascii?Q?K/f3Gymo45mRm2gFXCsIjcLPPO1IWdgyH+Fv0GQ/6ffcZjj/CQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/P3vwy+sXQpSU09IjPAfC4Hmg+REVurrwsqbfZVe1X3slDFy/iP9FTP+9/Fw?=
 =?us-ascii?Q?8Jq1XWJy+PkIRZlnUPQyLj8IIUC/WClJoWsULPuYrf9OJCNH0bfZMafNE+ue?=
 =?us-ascii?Q?kG2rsGmJNfywBDGbbivTEkGqkRYERGtSTMDOsdjNzbEIAAEsnRT5ZOohINMH?=
 =?us-ascii?Q?zqIf4LIiKD1As35n5TUmaLTVsUZsCoy+VdCM9XYfdCitA5f8pDgay8LOHim2?=
 =?us-ascii?Q?GAJpU0kxwpheX5GNs8Vz6szieKxh7XT0IH52SrFp3QbVQVblHFIBaSvPH2BS?=
 =?us-ascii?Q?96HzCPdaXnFfa21gV9CcGPqB6a/16oxPCPUuRvlebgXqZ2NnaWpP7SYMq3hf?=
 =?us-ascii?Q?CsVZHSMFiJj4xyOoUiRocgJ/c8F5FUb2gBtUlaBskANdzAfmQ7BjJ61kGz6b?=
 =?us-ascii?Q?Q9acEHbiGfTzmnpxiqVsov9hdDgu2+1VT/8CYdNnNPVho9pJqQFow03qW9Pu?=
 =?us-ascii?Q?gqqYAuP6Re8u23LjIW2AZj7mCqARZ6/FupqoCGBOmn0FR6EnBxXkJNNVRqlT?=
 =?us-ascii?Q?fdM4n8QwUtapEHuBaxq5FnDcfcZ321IcE9/YjUsGxAnlCTL/4fL6dAG3XvVi?=
 =?us-ascii?Q?g9GgQd+mIIH1MIhQ2uCp0t9Ldjg4BXbzbKj69D52+DSI28l5rfgHJXVoektL?=
 =?us-ascii?Q?GFIET8/JHhh53NbFPKMmqy9+8/RELtQZ1I0h13hgPYJQ+0bwq19n4gYuPk3f?=
 =?us-ascii?Q?mkdWtYFRqWCxQNzQRPTwOfn0MstngpmOdWHRxGgmi0qorvb+jpxrg0tnxGMz?=
 =?us-ascii?Q?Lt2qN3OixwdM+q4Ue64ThxAQLx6J2m0As+ww1RUk4FQD16Y+QMjdFMwFH2Tw?=
 =?us-ascii?Q?h5l/jhitJdehI3x8hNSOEzujRYj/BTn2qBbom942ELaUsbFh5DT5zALeU2YC?=
 =?us-ascii?Q?wyy77D3CfXJxTPtcZJTS6N75AlLW1T+bgqRs+oMisjtRnZx2RrvWB8b4d91j?=
 =?us-ascii?Q?Ybr3amoGpZv5dBdrKRtwLX9OLN4KPtr0fPkiQWrI6zxB9pyeX13JmQXo0kF4?=
 =?us-ascii?Q?w7d8GSpbKjR1zwjjSd0SrRT0bI3nmQJwND7e/ada9NhYfsaRDJxQrmFy+Nyc?=
 =?us-ascii?Q?ab1XePKDfOX6xwx9qEpbfH5JRuz6lCBQCwe33QBpNBr+gY1ghWvA3wjRtkds?=
 =?us-ascii?Q?z1qUE6blnRIZNeH0bOErqy5/zKzVyIbUFm7GGTMM9NszC5r2o4Zz0tHZ6Frt?=
 =?us-ascii?Q?izPixKCbTbX9B5p7YA1GJTw5s4a/aJ1bSw8q3okWa85POHAZelE41+XDAs1Y?=
 =?us-ascii?Q?CCbITvmV6L7PceAfEUQ+N9SwbDzovROXGhKRNUZ7pDl54LMvz3S4UuGtWBc/?=
 =?us-ascii?Q?+uaBl+Q5M7IASyoLpluqgC61XHvv2+xwPPhg9G0CYrCT8C+ouOc99+4kx/nc?=
 =?us-ascii?Q?Tceo/OtDfA5KEae4NmfcIXullopqFGmri75liGt7a8SaR1vk9LvWsWTrDKod?=
 =?us-ascii?Q?Joal9tOw72HL2Pbwdd9ME7jRlkYa0xcsKgQqsu9emGAUOd6B2rwhcubhmbFg?=
 =?us-ascii?Q?hEjDDHvxf+ekigyE+4xlUdtXxhVNDjSXQ7J31LZlhg2jCfhKsnnHOq2zTteW?=
 =?us-ascii?Q?XV6kfhnghpd1yR/BxlgEuQDuU6Eslmv/eacaAg779PIURIhKMDcvrEBqum45?=
 =?us-ascii?Q?aTaI100bz9lPAYxp6qLiM2X9D9N6Do3Sh1v9fZxMLTWv3otpiDEBU12KSbc0?=
 =?us-ascii?Q?jzpGDQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c41ccdf-b56f-4891-f485-08ddb8b3635b
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 15:24:36.7388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cSahgvf3YDhE+mIbD3Q4ne6IgR/8u+5WcOHVWNAB8KVQfoVpGs76SRD23KBSyQQ9Tg+ftmxqimi5MQyQ0CMRDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11223

On Tue, Jul 01, 2025 at 04:16:50PM +0100, Mark Brown wrote:
> On Tue, Jul 01, 2025 at 05:53:12PM +0300, Vladimir Oltean wrote:
> 
> > I suppose one could try using FIFO mode for transfers which request
> > timestamping and DMA for transfers which don't. I don't have an insight
> > into what impact that will have on the driver, but I suspect at the very
> > least one will have to transform "DSPI_DMA_MODE" into "dspi->dma_available"
> > and "dspi->dma_in_use", and reconfigure the SPI_RSER register (interrupt
> > routing, to DMA engine or to CPUs) at every transfer rather than at dspi_init().
> 
> > The question is whether you would be willing to see and maintain such
> > complexity increase, when AFAIK, the LS1028A FIFO mode passes its
> > requirements.
> 
> Switching between modes is incredibly common, usually between PIO (for
> very short transfers) and DMA, that's no problem.  Factoring in
> timestamping seems like a reasonable signal I guess, might trip someone
> who was trying to benchmark things up but probably not normal users.

Ah, ok, I vaguely remember something being discussed about can_dma()
on previous iterations of this patch, but in a different context.
Then that's an avenue to explore, I guess. Looking at that method's
prototype, I suppose dspi could simply return can_dma = false "if (xfer->ptp_sts)"
(timestamp requested), i.e. no core involvement in the decision process at all?
Sounds interesting, but I can't promise I'll follow up with patches.

