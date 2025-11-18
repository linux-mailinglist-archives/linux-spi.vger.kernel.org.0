Return-Path: <linux-spi+bounces-11278-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B05CC6A7E9
	for <lists+linux-spi@lfdr.de>; Tue, 18 Nov 2025 17:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 9E3182C85D
	for <lists+linux-spi@lfdr.de>; Tue, 18 Nov 2025 16:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235AE36A03B;
	Tue, 18 Nov 2025 16:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VIwI2hiI"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011004.outbound.protection.outlook.com [52.101.65.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B2536A030;
	Tue, 18 Nov 2025 16:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763481804; cv=fail; b=b1jnTrGAwzt2j3Kree3rpX8R4NGyHDpW/Qfwz4JDZuBaBiOYEayubsEGr3/DWHFMtcsc+kYEk14GNB48HaY8mrlq9SI1nwuHKGfCtaMplzSVVrEPBfvCYpG5DhMtlSzfJVNBL+nUpqAGLYVR7NnfzMPhy+8+74CgdkjRk7Sf/Bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763481804; c=relaxed/simple;
	bh=LYsViEPIlCb5b1n5XGSderdsE2W2uCP1FiKYENR7rbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GxSelo/I579K360sc+vtl7YPqfWXWt7uvBT06YsLw5SdO/NRlJu4Dzp0WOXOD2pQQgzkEGdTgBTAxC4KITlf3B1hBeY3O4KmZyulaEKwPdsacgvV8xLcCleB7TTfv3KcwfIDism8Mc4framlJWJTdMsGTdvnXCO9CsfRKnjHAao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VIwI2hiI; arc=fail smtp.client-ip=52.101.65.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ePDSGuAjy+WZRyTu2vtoDqjGDfuU987ufsngMqejuBN2yFYmsnBnby9UE9yrU9pCeMpblL8mWvFkyW0v8I1hyOw1TrBm6G8ZvLtvdYsFWr8giAF+y6WSTX6g8v5t+btILP8eAT0gL051sS1Mh36b1xLTsip8EDMkb0E1t2nR7NB4S2DL4ALvSHrp/zvjq5PKbgyN7iE3DiWRjJchhsmOJK/bKlZ8lYTSxpb9WmH1h+8gVUk6BKRawQcZ+CP+QQz/7dkmJQfp8bCpyVya6cWRcbPmjgCIPi01kGIP+WDPw32kBr8G0kEFVU/MOPd9gYEYN7Irda/54Co4fEgWdiU2/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5EHTEtVE+xR84UPs5uI9XUt+n6LYVna3joUU+w0XYU=;
 b=Br5fhSXrRHVuglTw6QeFBZ+KKXEBuGrPBVZvTBfWizkvtvmAgrhNlciBDbwx0OTlBlh0MkvubH4XbRFzqPMlgeFamb8weHA++KYnQj7ppNRYP/6XnP82n6YxjFr+yrLqO1/+BTkNNqUOvjWkchAixgubr9Ts8Vqq/NAOdHUAmZHLdEBlXh0MWudFYAzE1lhJU+jInMvjrueIzI6psmo+FkppdqyhBsTPjNmxIyhoyfW0aSdWJwr5AJJzyGdqZM3xYWgRqBz9qoGQRtGyoWkwc3QTtk3zJJuQixEoxyjeg9slWybZcG0vFS3fYY1+4AlMepJXggQgUnrIEIhk7yIFTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5EHTEtVE+xR84UPs5uI9XUt+n6LYVna3joUU+w0XYU=;
 b=VIwI2hiINVAs8bHuRfcQlwbeTJMm/NDVEFY+jMt2hxAhJWaJqioeu4Y6NdW8SOVHeZxTXA8piTqgO3uuWUxvwNPI3QoVNBsDFpnH3jUl7CEJxXdR4uuJbImq0o5EQnQPk5hvUn8KMa85QFjduCY7onoO4SbmY2jLkTz5Y/CuIQtxu0ll/Y078M70F5+XD+rUmcR8AeMGCmuu3I4ABUbBchi1+nOUYDq/NlLwIbQnZ0qGMkdpLm78E0doOYG8bQR/7M5/mTwD7LypVWMlDbUhjTmdkc9Ff324giFgLoCApw93pqmdOnarwBIA9YCUvKJqHfeWOFfamH8lwkauWBgRWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by GVXPR04MB9733.eurprd04.prod.outlook.com (2603:10a6:150:119::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 16:03:19 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 16:03:18 +0000
Date: Tue, 18 Nov 2025 11:03:11 -0500
From: Frank Li <Frank.li@nxp.com>
To: Carlos Song <carlos.song@nxp.com>
Cc: broonie@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Clark Wang <xiaoning.wang@nxp.com>
Subject: Re: [PATCH v3] spi: imx: add 16/32 bits per word support for target
 PIO mode
Message-ID: <aRyYv3yej6Pc/HrU@lizhi-Precision-Tower-5810>
References: <20251118065012.1418279-1-carlos.song@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118065012.1418279-1-carlos.song@nxp.com>
X-ClientProxiedBy: PH8PR22CA0021.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::7) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|GVXPR04MB9733:EE_
X-MS-Office365-Filtering-Correlation-Id: 024828c5-241c-461a-4b16-08de26bbfd73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ImFftc1rO0sBoYtxHlxrZPCAunIGRXARUcW2agbM0gx/1smhKIi1mB4cgHJh?=
 =?us-ascii?Q?jIUD/ZgtRzw2BMGvvxyz4xYOFtMylt7vcVkmg+hWdx3cMOxYcIDnAjGAPDxf?=
 =?us-ascii?Q?+AuIAQCNPAVaewkaOYUb7kXG2LzElfrtZwSWOWayKUz0Fiacd/zd4JhfZk9N?=
 =?us-ascii?Q?CrcxQkmG0/wyshxWKjmJxLu18opiJIbgJQ5D2VjTDDCI3c2eyIK9cXDhtpUg?=
 =?us-ascii?Q?iEX7k6X/vNOpgKMq8KpzAPenyBY9Euw+HeDhmTEN9/nPRXYK8Enuvc0XtwJS?=
 =?us-ascii?Q?33A4SSYJg2/Tc3tm1++c/fx+aWdIKaw3sLv2OQ8MARASOQAA5/RgjhjvHILf?=
 =?us-ascii?Q?oakwZgU4B7zjiUw+HnEx3czgd49XU3c+XF55njiOvlRpXvd6bfzCJEn6llb5?=
 =?us-ascii?Q?aZjKs1dYkV5Ch+vdfOBDrGLGT1bDlO3EP6hIxMLCI+teqzzmPpH8qVVUuzSx?=
 =?us-ascii?Q?+JV8PirnO8wkyhdX4lDI22Q8Sx9gX7U+wwQT7Lzunlr6kppMXBTZ0jJpQX4d?=
 =?us-ascii?Q?yOT9D6K59xiT13hxP0W17BIOJ8p9a7OhWMMjfohi8eWC6VUMAk3yv3johrhN?=
 =?us-ascii?Q?j97hP55t0tJs6SGvK0dd/MsqZH+m+HlvD0R903Ao5I6iOTmypaYS6givLARy?=
 =?us-ascii?Q?eK663mELCJosOAM/jyfkqCtp8QjKWDmXJ2NjY/39HotI2SgoEAe3OYpS2TGw?=
 =?us-ascii?Q?llyvC1D6VIDzKKXysLKVMuW3dj1unatMV6fO9/eS4lG2lIkffa/uS0nkuCBY?=
 =?us-ascii?Q?EZ4sWuOCv8HwdiGv/Lo1p85bEyWfgLdHJTb08N20S6Y7ckln3otmzv1rWh2d?=
 =?us-ascii?Q?cXElzdSBB6MthTnHe8QLkWV2NaQEWd7LeA80oYUHbIL6mJPidk/i3LSAt9yf?=
 =?us-ascii?Q?Esbjzh/HXZe6OOSTfGwCAkRSI4/cgOyikKYyHeRAn4/xLAMdLbqiqHHMK7mU?=
 =?us-ascii?Q?BAmZlIyoy8y4FZa7GxfBH/IW4Ywh3eyXU1iuQeedGZ8HF95pU6eYoyvYM9ls?=
 =?us-ascii?Q?qE9A+JwvyFSiD9ytmo3cwl1d2FMmNcRFcS1Zc6K2qQQaBEICImr6kW2xA47d?=
 =?us-ascii?Q?rqQ2wMKQ6aDysTa1JaDJZUE1bm22OwKjBonR71nO8pX2M732dVHDdCHnKHDe?=
 =?us-ascii?Q?3V8wHkKcEu26nbTHPnuIc2rXeSXeDObl6Kw9VW5+Ax3+cInuaCA4r2G8z8Fj?=
 =?us-ascii?Q?F452e9/hJukBRuqqiya66mzBp4eyE7lf4lt058TmOrKSuyvMPIjmCQwtpYaZ?=
 =?us-ascii?Q?kN5oF4FCPpXec+B3YAkYZyCGYzJ8xyW0pJTzlFR5uM57yXdXgjkdOYTXslqO?=
 =?us-ascii?Q?eis9ukUZ0RjOESvgbZfL3vkjNmDQpN6xO6jPZ0VUz7oBlUMEUDP6PEo9bgCN?=
 =?us-ascii?Q?WTfZOUi+N3x2M8H47XjMQNAEWkv2XOJAYHoEreIXNZsrAcuCN/z36CPVDJdE?=
 =?us-ascii?Q?6lfnJz4xYC4hidh7MEbhkmkIP0B/cavi2zZ1o9ow2kPE5s7AFjxb8skhHvbp?=
 =?us-ascii?Q?NxB1yAJM0rhigM9T8pKK+Dq/8NnzodB7GCCs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qe+IbeqHRHGNGEwFm69RD6PwfThkMAadzDjKKm6Opwk/+VrXgSYJdB3gKOFq?=
 =?us-ascii?Q?nH4HEn8wICoRccFcyQ/DTMNxfXrPVclb3yvw8j0UgyvQPeIfUNRt13mxukQB?=
 =?us-ascii?Q?MuXwojQCgJFgA+PnzwovyrInMvpTlVpMdzlc4vpAVU73Q+nqe/U5MWWoLFMw?=
 =?us-ascii?Q?2VUiunRwSWn79aaTsKJ83OCRgIIxjmrsLLJuATxlX2dJvJJV+XgzmXNA8kA2?=
 =?us-ascii?Q?6tnmYg/YBvsju4qPvDy/M0fwCFgAiv/40ZyUbtsAvFPR0aX/R2KPT/eXfp5O?=
 =?us-ascii?Q?0ltxRKaAZuHqWMuKcY7FsO68HFrrqtqiQLV+9q/YK6bzDTvkZ2rOdAaE9Bgj?=
 =?us-ascii?Q?Y/qvczzizhRmRimIXK/GWvzJCz2munsVq5oJa2/OCcisXQiRSR7LjCGN91/8?=
 =?us-ascii?Q?oaJUgzDtbM0aj1y8xwr2sWL9cESoR5YJA1frgDWoAj1uQUevowocFPyGAXaa?=
 =?us-ascii?Q?xwDH4pAWfO+4WgofwHf+SDVvSgNne95xd+crUmxGZjop4fym2P1N5iU945FA?=
 =?us-ascii?Q?i7aEcEoXxIM0mChr4HkWJGaS6udlnbTwQWZWPlzlIPXJkirVjNdFreNtRijd?=
 =?us-ascii?Q?O4jRp6P7hUkdBOOWESyQg4C2w6jBK5xmHwNZxVaybmPQA5xJ+8scrD6YaTGh?=
 =?us-ascii?Q?7rJ4EYwOWwNSP3AkkkiFEoBp20ZAkVvtTmm/slklq5KMm+MbomG551hPPgUb?=
 =?us-ascii?Q?nPpiJWz4zjh6H9rmVbGsqgae9FI56722YatpWvrPZsgH15X10U+CwnEdaqM1?=
 =?us-ascii?Q?1CpkI7IC5fr3HBsJKrhPHKNKdBEd6n6T8f1rGrmZ5iYKtQuzR5RNhT1gWfej?=
 =?us-ascii?Q?0yY+e6tId3DJXJjLhzkDOwqeMWfIPHV7hUqVONdiS9aJOLpKhpLdaEzBsAD9?=
 =?us-ascii?Q?XKADR40dCyzYB5qjiBtim6kO4zSmAOu7k5d2MzMa110kQhJ7/hUVz0Yjyt1t?=
 =?us-ascii?Q?Gtv9ChxBb/6d+j2op9GwTvC4sKwBzwrdcLggX/7jXV461NiNJKcGVEQtd0tH?=
 =?us-ascii?Q?cxStBicYsG0NvxfAttQ6auJv7L/kKIqIIBr18L/bVEdB9AO5/MLuwGC0e0Cn?=
 =?us-ascii?Q?by4CxcOE07SAiwTHwYjEm2so+JW/jYMnS2uuUSDgafhgQGcODbl8Da1M+3o7?=
 =?us-ascii?Q?/iK611Qw1FDcMPB/WFvJ/JEGpx9B/RpPUQwfWbaDTTur2c6doFm4ejy9pAjh?=
 =?us-ascii?Q?Xhv77O1h9BiOMc9ZE0fMZzARgFdoo5D25A6hu3C5xKlO1VUaW2KmbSb4b4Id?=
 =?us-ascii?Q?K0ei3X3sso65GHXwJcr1IT1x/gdEObdXNcP7JnQUzSW9PLYAGxumpfLExELh?=
 =?us-ascii?Q?mRCEg3wsho4FbyawUznmd8t/LysMVI9m16IgCN52Cl48klQjoAIXkCGGGb+d?=
 =?us-ascii?Q?oKDzzmvyufcF3ULi/V64w1lWoqcuQRUtepjWyGlWPWYQA5PiiXW0mC6C5uyC?=
 =?us-ascii?Q?kbFm17QdD+Jrr0HYD4e8NUTnvy1NWHI8h10cywkquesvI7PwXbu95OvKg5VZ?=
 =?us-ascii?Q?hvFqw5DcqtE+IDxd9FGcSrAKMOHi3+jTqVgTO/mIn/R3ckJHKwe+/+KLmjy3?=
 =?us-ascii?Q?LmLfJvIAyKWbxd0xAFiCfKw/b8gvWH5LFQRzoclc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 024828c5-241c-461a-4b16-08de26bbfd73
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 16:03:18.7926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C150U8mSActKjO2EuM4z5nyqGE+jIgF0IKN2hn+aX/ZlOL2321WAbZxdHsGkMz9KFlBiYRO6VcBwUasp8JQ2yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9733

On Tue, Nov 18, 2025 at 02:50:12PM +0800, Carlos Song wrote:
> Enable 16/32 bits per word support for spi-imx target PIO mode.
>
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
> In SPI target mode, we write/read 32 bits word in 32 bits width TXFIFO and
> RXFIFO. 32 bits point is used to get the logic value from memory. CPU only
> handle the logic value with FIFO, logic value is the same with value in
> FIFO. However, in different CPU endian, the logic value is different.
>
> For example from TX:
> SPI tx_buff bytes order in memory:
> addr0 addr1 addr2 addr3
> 0x11  0x22  0x33  0x44
>
> For little endian CPU:
> Get a logic value by u32 point: 0x44332211, CPU send logic value to bus
> following little endian, the bytes flow in AXI bus:
> 0x11 0x22 0x33 0x44
> but when write 32 bits word to FIFO, all bytes are grouped to one 32
> bits word following the little endian to 0x44332211.
>
> so 0x44332211 is writed to TXFIFO:
> bit31~24 bit23~16 bit15~bit8 bit7~bit0
> 0x44     0x33     0x22       0x11
>
> For big endian CPU:
> Get a logic value by u32 point: 0x11223344, CPU send logic value to bus
> following big endian, the bytes flow in AXI bus:
> 0x11 0x22 0x33 0x44
> but when write 32 bits word to FIFO, all bytes are grouped to one 32
> bits word following the big endian to 0x11223344.
>
> so 0x11223344 is writen to TXFIFO:
> bit31~24 bit23~16 bit15~bit8 bit7~bit0
> 0x11     0x22     0x33       0x44
>
> Because SPI spec is not ruled for bytes order, so SPI should keep bytes
> order following the CPU endian.
> The bytes order in memory is the same with logic value in big endian.
> So don't need to handle data for big endian CPU.
> But for little endian SOC, there is some diferences:
> 1. When bits per word = 8:
> every word is byte, so bytes order should always keep the same with memory,
> u32 word is 0x44332211, but CPU should send logic value 0x11223344.
> So we should swap every bytes for the u32 word 0x44332211.
> 2. When bits per word = 16:
> every word is two bytes, so every half word should be little endian:
> u32 word is 0x44332211, but CPU should send logic value 0x22114433
> so we should swap every half word for the u32 word 0x44332211.
> 3. When bits per word = 32:
> every word is 4 bytes, so every 4 bytes word should be little endian:
> u32 word is 0x44332211 CPU should send logic value 0x44332211,
> so don't need to do any bytes swap for this word.
> ---
>  drivers/spi/spi-imx.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 1dd20e9d9605..b8b79bb7fec3 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -425,8 +425,15 @@ static void spi_imx_buf_tx_swap(struct spi_imx_data *spi_imx)
>
>  static void mx53_ecspi_rx_target(struct spi_imx_data *spi_imx)
>  {
> -	u32 val = ioread32be(spi_imx->base + MXC_CSPIRXDATA);
> +	u32 val = readl(spi_imx->base + MXC_CSPIRXDATA);
> +#ifdef __LITTLE_ENDIAN
> +	unsigned int bytes_per_word = spi_imx_bytes_per_word(spi_imx->bits_per_word);
>
> +	if (bytes_per_word == 1)
> +		swab32s(&val);
> +	else if (bytes_per_word == 2)
> +		swahw32s(&val);
> +#endif
>  	if (spi_imx->rx_buf) {
>  		int n_bytes = spi_imx->target_burst % sizeof(val);
>
> @@ -447,6 +454,9 @@ static void mx53_ecspi_tx_target(struct spi_imx_data *spi_imx)
>  {
>  	u32 val = 0;
>  	int n_bytes = spi_imx->count % sizeof(val);
> +#ifdef __LITTLE_ENDIAN
> +	unsigned int bytes_per_word;
> +#endif
>
>  	if (!n_bytes)
>  		n_bytes = sizeof(val);
> @@ -459,7 +469,14 @@ static void mx53_ecspi_tx_target(struct spi_imx_data *spi_imx)
>
>  	spi_imx->count -= n_bytes;
>
> -	iowrite32be(val, spi_imx->base + MXC_CSPITXDATA);
> +#ifdef __LITTLE_ENDIAN
> +	bytes_per_word = spi_imx_bytes_per_word(spi_imx->bits_per_word);
> +	if (bytes_per_word == 1)
> +		swab32s(&val);
> +	else if (bytes_per_word == 2)
> +		swahw32s(&val);
> +#endif
> +	writel(val, spi_imx->base + MXC_CSPITXDATA);
>  }
>
>  /* MX51 eCSPI */
> --
> 2.34.1
>

