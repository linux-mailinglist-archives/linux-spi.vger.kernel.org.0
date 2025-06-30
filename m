Return-Path: <linux-spi+bounces-8924-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF8BAEE86B
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 22:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91E731BC102F
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 20:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBDF21D3D2;
	Mon, 30 Jun 2025 20:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="d7/L65fe"
X-Original-To: linux-spi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012051.outbound.protection.outlook.com [52.101.66.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC5722DFBA;
	Mon, 30 Jun 2025 20:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751316107; cv=fail; b=NLnN30CbhXr/Mo2aqfRJ/SFudbTbltgytzm5MabLdj/iTOxSb+n45jMxWP5InVo8Skil4eKyJS0AMe0tH2SaPcZ47GuPfeEF+qe1QWS8/Bs/dGtvPBsBMqmu1SK0TRIYZSlTCJV+NzQo61ydTpegQWFwCVg68D3dHuHFHbe+S6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751316107; c=relaxed/simple;
	bh=iKWsPsRwD3TP7j25KqvTCbmZrn05/s/fSHeez+SktQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Wh4n2VloTFiQp5xxx2TFqxtUvVqvmlnQmsDxgjr5U8YWzo+Yiny/uziBAKVEFrbmlTwvwpfx4VKXPRZDPJFp7my/VkaCYPMpayL2TZvA2hGpvyIacsr9s3w1W6rOSqJt+9GQ/dsZ/Z45E2s5sYLQi6iv9nscPa1zcQWZNchQgg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=d7/L65fe; arc=fail smtp.client-ip=52.101.66.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YC4SMM/C7kBqiHiWiSXXNmHgP5X4iGR8iqA/y0i+CvHHd1yriKaC1u1wS9AMzuB/59nq2X/dlEz/2hvGY4ujy3tTn6Bdg6UamjaeAvkwlJ/MS21TYkBBB1+nnZpOrSU+5my4f801JxXFTl2unUWcbbZD6cLhq4BVALVA72mF84XwQRxu5wRb51n6MMkgM9HFt4zeZO8r90OHoZGEb69sB5ZOn2v87go1CvKNHjXeykQ2lNwVM1qmme7jHQMqrmqT3XEs6nTiIcsoKYvWuHuea0dZz7x3Urg+Sg34U9shWJQvpJh51cdjhGTccECX79uoxb6rqh5ySgf6KX6IMw0rlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLd33txTZrQ4WOjc+Th0lWZgTa/OqpirMMkHQiKzDkA=;
 b=V+NXzlO8vO6KwUNvvzzUhBuwogajhD6YSov0AHDUNceOGYf7S86kxMVOTPMnK8NRkVdGppHPVYIsCyfwuP8pHxNQ7ZyO8ewR6W3AAn+Ys1TgZid/y8qbRwSK3JactzeEngKc2s4NNasmTG3yrNga9o4iWABtiBbHHuPKoisLKXHFppgQCBcQDY7gTOzmc+cUEwIdO2A6EenCD9Z4Tb6CdH/k+oDG8cF2cWIA/uPQWHHUnhtZtS4VFX4hN05qZTWkAPcSLWX9RUyCcuGdALWzhYC4DNOZQdXjhjZQNrY1bCMvxPraFzeFWs98a5ZbcrtubmdBYA8kddr3mo/cPe64eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLd33txTZrQ4WOjc+Th0lWZgTa/OqpirMMkHQiKzDkA=;
 b=d7/L65feJObMMohq0VsLiB/3OCzaMThWjg0jc5OuUO71dfOct2kagqJu+O9oK7YISIqW1TPxBLKKbW41Vk9D8bqsNOQgtDyJogpDW9qE3OtTYe7rwkPGc1PZecVHkeOXpBK6LZnZsycYW1jT7fnJMtUP8hB8/76iZMkNDZBAM6qpmmu64TfKfNJNEetZ1DWW6CWIsaNGvdZ7b0b+oXaPMS1ekvJf60MFUP52lNrEXZivXebV7so5OoZMMgJEqagMsDTlQZhwyUFqW3+JeVulbrah15tUnBNlgg/YYi3xekij0OZEi6G7LRSY9sj1oOsL7VbKFO8gBujqHq8eBmrEjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GV1PR04MB10077.eurprd04.prod.outlook.com (2603:10a6:150:1a5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Mon, 30 Jun
 2025 20:41:39 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.8880.030; Mon, 30 Jun 2025
 20:41:38 +0000
Date: Mon, 30 Jun 2025 23:41:35 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: James Clark <james.clark@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Frank Li <Frank.li@nxp.com>, Christoph Hellwig <hch@lst.de>,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/6] spi: spi-fsl-dspi: Store status directly in
 cur_msg->status
Message-ID: <20250630204135.gzffv33j3pk3bgx6@skbuf>
References: <20250627-james-nxp-spi-dma-v4-0-178dba20c120@linaro.org>
 <20250627-james-nxp-spi-dma-v4-2-178dba20c120@linaro.org>
 <20250627213041.vp6yfcgf4xysdklf@skbuf>
 <423f101a-0826-4b7c-ace7-f5e7f4790c4c@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <423f101a-0826-4b7c-ace7-f5e7f4790c4c@linaro.org>
X-ClientProxiedBy: VI1PR06CA0193.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::14) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GV1PR04MB10077:EE_
X-MS-Office365-Filtering-Correlation-Id: b3463799-9a3f-40c3-ad42-08ddb81682f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|10070799003|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rBLtVG9D7sUgqWn+EEKwq6L5bXp9DQnrPaBharYwBE+F9/dzV1pmtMs42cqQ?=
 =?us-ascii?Q?ZLzhtDWzi5AvW8HLfgrnCJapur8Loct3fKpRZbL9zInSiiQqg9oPi8zdfHwB?=
 =?us-ascii?Q?jNFNJB6jBbZZ7+O0fqiMUZb+1p0GpJHydVtuDSHLu0bRsqwhhNeEwcUxjLkJ?=
 =?us-ascii?Q?fOYR9MCih+S9X90GmcOcGi5hfXA5fqk7pdrplTHRw02GFWv53oVUARj0HiKr?=
 =?us-ascii?Q?KDi0IWjlS2qsfmyzqoiwLElgzSBKDwArA3wtVfmTBdQ78XrDN2yjtaF0ejzc?=
 =?us-ascii?Q?YueTyF8MNDSxwsOJx0ZGLTS1BsSljm9Aj2R0THwQ1qHrfj87qtBaH4E8aSdm?=
 =?us-ascii?Q?ajLf/rteLD/SCrPGrlElFpBNfRJA0bL0OIAxATOLzxSjk7Q0V7zSCyPw/LcI?=
 =?us-ascii?Q?dyXF8NGo+4AiEfvm3+KRCBhReYT/2Mc+2/4JALeZ+89bKcfqncdEqvUfsuiJ?=
 =?us-ascii?Q?STrOnMRgYzDM6Z0ngKtutyERNUHLQEelu02VbDjGEA7DxmjsSH/c6uzaJXCG?=
 =?us-ascii?Q?rT4jOvW5W0g3Mls0OP1CCTmdQUlzl1cTdwpJo5Dufqc/byalPI2g2O+s0cPI?=
 =?us-ascii?Q?EdRoH2XKFeNmSd27yWHfKXvdrE5zf2gGp4IwdZXCNLjhjn8YAdca1WzieRjK?=
 =?us-ascii?Q?PUzRkLxTZyEX071gf8InAaodf6AM4QSvMfB2cVm5P1cZ6kVEqMFd58ymSK0k?=
 =?us-ascii?Q?lxrbHV9IVGGp39PYkCtcyPUhfObjeFTWhBwRUBZwuBrCiP9ZklFghtg23tF5?=
 =?us-ascii?Q?OJL+tbTAjxlzgBNoYmXq8iiXHV9Z+E/suhDvuwsKrqN9kb+AnVEpH2UTl1lj?=
 =?us-ascii?Q?sp7i8eUkZCxdzKAFZ/2hLBkVkT51tCD1WjYrIWyfDn7vkXiZgPW+ehdgKhv/?=
 =?us-ascii?Q?12WpdIfU1spH3K87BnN5pUR33sy5XdT00uSdf39X0CxBLWirYw1JTbSL6AMt?=
 =?us-ascii?Q?mCuQghbdH2vxWCDPk/hh0kZd/QNmyZu3JXs4mhPQLCKZYFN15b7CksiyE4DV?=
 =?us-ascii?Q?5FBzgkMTi9l+9mElNmujjl+uDeYKmHNDYGAAI1pP/Rs95kv0wzrcM1regAo6?=
 =?us-ascii?Q?rAjSj37N5nu42IRzvPinAQOZ4emnx6HV0HJk7xuhm5MWIS4etabBiRL0aHVD?=
 =?us-ascii?Q?/xTvXfz1X/cGD/IfgapijQgM4c1nl3iOKxslCCy1Vlk97zgCRmIPEEfJmTfz?=
 =?us-ascii?Q?xIyPTLw5a1rZOFwLgjPHNyOKiWmwG5So2N8keGQ5jiExxI/nODm6XiPulOE+?=
 =?us-ascii?Q?zg7wzpcYxqqR1QRhAzC8laSOGsWrtwTCWdt0KJ6PT9yqUWj2oBPpDQWbNZs9?=
 =?us-ascii?Q?T+McqAjo1KLkWOEg8uDtuqMzDFIesfrKc5l3pX/kW9TJMBKevg4rh+D024Jo?=
 =?us-ascii?Q?3cR4CvX9y64lAY3GqZUUmvcQL3Zr2PYo6Tm7YO2kpJEddzURfw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(10070799003)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OHcJKG1hqy7lmNtudyUZvD2Ao65ygzLXwdAOsjflhdlao8kiVIgRVl7CbVCM?=
 =?us-ascii?Q?sZA1LRlDITtvB3sD0x/NaygN7bTVVorDKc4lbUCzPwzDWP1bAtW5viVPDiCI?=
 =?us-ascii?Q?tqQC23QFOJwEf0EipmcPBsjYx2c6E5z0sqfIc2xFC8q2UyfDAY39xCFfZHZJ?=
 =?us-ascii?Q?T+Rhs2fGVmzaEEZ4yf6jK4Ar9X+iuPIL8Vg9OMEBvdzaDjsNzkxHopdXmDXD?=
 =?us-ascii?Q?nIjKJ8p+13O4aLdC4DQ0heYqsEfbzklLLJCVTec5rp4Vq+voi0IlUnx0PaQZ?=
 =?us-ascii?Q?hlRGKL18d5rdKtlGdEZxRzRESP9vQdtohXKwzCu9nsBK8QKXBvUzcG+ao8ak?=
 =?us-ascii?Q?tKSOdMweEJzwLaNN8Qb3BVWmdREJg1aGrJFnstGyFy/YtUJ2sIzUmag5wLJZ?=
 =?us-ascii?Q?qffkEx2ne2O5Cbh2fVL8feK0IFp1JiZqju8ppOjQHaStvG2VL5GAA0kmJUiX?=
 =?us-ascii?Q?CSwdgFfwUhOa4GkzXd7RMreEoElgUlrhAbBSMv8LFdL01+o3VkYHPabzCApO?=
 =?us-ascii?Q?8TSweFmhHWZEPifI/5D5DYqZ8uh3Cx6/woqXHHetFjv1slPZVcoOLlWrBz7E?=
 =?us-ascii?Q?wqv7K/26JGM0YwhRCCR4rRWrqx2KYH/2cr7MSSp+/k0+BcJtKDbLNKElzbmB?=
 =?us-ascii?Q?42ouVqgqnUedhfHcL6BmoULM3VqVm173wX47f1AfPk9rxjCdm6i211Ufhv77?=
 =?us-ascii?Q?bEj34qDxtsNxRHN+nkUPvHolRWMW54T2dx/a5yhRrXRqRsJ3AsTIn545SiEs?=
 =?us-ascii?Q?Qm+rZF5chnm0qgwVgjy8XEzf+tZshU9Nz8DN8DNXVHOdh58rgnPcfK0YFjRd?=
 =?us-ascii?Q?cY/qJNG0EBLqYhU5qAWiPTML4OZ8QPN1IA24spNTKqG3gi04YnKe4/gLI2NR?=
 =?us-ascii?Q?sEYsRUL9iRrMZ+y14kkFXOEOgz9uefAyMeVNhEirqeIEJI+OPXRkxTFE6Eee?=
 =?us-ascii?Q?7LT4oFZiJidPBnkPEuZdhxF+QSGoz+X3eDV4RByXMnAi80m/WczGFrqwrS4r?=
 =?us-ascii?Q?5zWKMWguJtQQeAfl9cdghUUf9rDkpDxTIRhh1g+tjJvFEGz+eCN8T6JycXzB?=
 =?us-ascii?Q?8shC816k97MuTQIHj0oAMdJnMamtFAd6P5/2A2plZaA/iYsXXmC+4oesnp1Z?=
 =?us-ascii?Q?7SU70VfrnxJ8kOWFCHJw+F6QUaRKPntS7g/kwLKsS2sgn2XvroClWYG5FPR/?=
 =?us-ascii?Q?1uGG0q/vn9Gsuz6iA2xjKDZOHgY1YFJub4AKxH6o+ajFZFNqEKMk5LrLKvrT?=
 =?us-ascii?Q?0AP6pM2Kh+A1hthSRUBScLPqOAlSC+WC/6SV0LZzM+xlOQFoMybw1OaQ4fbI?=
 =?us-ascii?Q?JYj5CitPH/uMX5QoSCw9pai1UMO3HGn4Z8pmy8/dBwhV7SEgMe7AOj4vp++W?=
 =?us-ascii?Q?RMFXa7yndDyC4SHfZ8aOIT31LZFqYPxSwuleNE8yeC3+TnF87x4DaXni+EgC?=
 =?us-ascii?Q?5BCXRE71Z2/OqE1B6mlxjkpeeW6XNdsUpP+lTc3cRHKQWdNJxsdKf19ooSU7?=
 =?us-ascii?Q?5BmJAVkz5/ZyfXk2gRi4vfphG5csxe2LYAfWfjf8QvXT94K6h6x/x1vm/okg?=
 =?us-ascii?Q?qVdQ3ero9F6Z9VI0kxvK6ENOcwKeYetnyWeDsjKgRoeC9e8IycgbGtLFPAR7?=
 =?us-ascii?Q?DQvYDNmRztNwhDXnV+GYPB6OIBg2TRRrt4DM59pvd7ZWhOVkz3nFhB3v+5u0?=
 =?us-ascii?Q?ALuleQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3463799-9a3f-40c3-ad42-08ddb81682f3
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 20:41:38.7446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kBQlDfbdmMX1yUiTqtGWxhKLtw83S0tYIsNnR4GVM8zlVMKDmfnO66iYSxD7QkGrpfXVVVm9cYkAjwl6YKhWuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10077

On Mon, Jun 30, 2025 at 01:54:11PM +0100, James Clark wrote:
> On 27/06/2025 10:30 pm, Vladimir Oltean wrote:
> > On Fri, Jun 27, 2025 at 11:21:38AM +0100, James Clark wrote:
> > > This will allow us to return a status from the interrupt handler in a
> > > later commit and avoids copying it at the end of
> > > dspi_transfer_one_message(). For consistency make polling and DMA modes
> > > use the same mechanism.
> > > 
> > > Refactor dspi_rxtx() and dspi_poll() to not return -EINPROGRESS because
> > > this isn't actually a status that was ever returned to the core layer
> > > but some internal state. Wherever that was used we can look at dspi->len
> > > instead.
> > > 
> > > No functional changes intended.
> > > 
> > > Signed-off-by: James Clark <james.clark@linaro.org>
> > > ---
> > 
> > This commit doesn't work, please do not merge this patch.
> > 
> > You are changing the logic in DMA mode, interrupt-based FIFO and PIO all
> > in one go, in a commit whose title and primary purpose is unrelated to
> > that. Just a mention of the type "while at it, also do that". And in
> > that process, that bundled refactoring introduces a subtle, but severe bug.
> > 
> > No, that is discouraged. Make one patch per logical change, where only
> > one thing is happening and which is obviously correct. It helps you and
> > it helps the reviewer.
> > 
> > Please find attached a set of 3 patches that represent a broken down and
> > corrected variant of this one. First 2 should be squashed together in
> > your next submission, they are just to illustrate the bug that you've
> > introduced (which can be reproduced on any SoC in XSPI mode).
> > 
> 
> Thanks for the debugging, yes it looks like the patches could be broken down
> a bit.
> 
> Just for clarity, is this bug affecting host+polling mode? I can see the
> logic bug in dspi_poll() which I must have tested less thoroughly, but I
> can't actually see any difference in dspi_interrupt().

It should affect both, I tested your patches unmodified, i.e. interrupt
based XSPI FIFO mode (in master mode).

Assume (not real numbers, just for explanation's sake) dspi->len is 2
(2 FIFO sizes worth of 32-bit words, but let's assume for simplicity
that each dspi_pop_tx() call simply decrements the len by 1).

The correct behavior would be this:

dspi_transfer_one_message()
-> dspi->len = 2
-> dspi_fifo_write()
   -> dspi_xspi_fifo_write()
      -> dspi_pop_tx()
         -> dspi->len = 1
-> wait_for_completion(&dspi->xfer_done)
                                           <IRQ>
                                           dspi_interrupt()
                                           -> dspi_rxtx()
                                              -> dspi_fifo_read()
                                              -> dspi_fifo_write()
                                                 -> dspi_xspi_fifo_write()
                                                    -> dspi_pop_tx()
                                                       -> dspi->len = 0
                                           <IRQ>
                                           dspi_interrupt()
                                           -> dspi_rxtx()
                                              -> dspi_fifo_read()
                                           -> complete(&dspi->xfer_done)
-> reinit_completion(&dspi->xfer_done)

but the behavior with your proposed logic is this:

dspi_transfer_one_message()
-> dspi->len = 2
-> dspi_fifo_write()
   -> dspi_xspi_fifo_write()
      -> dspi_pop_tx()
         -> dspi->len = 1
-> wait_for_completion(&dspi->xfer_done)
                                           <IRQ>
                                           dspi_interrupt()
                                           -> dspi_rxtx()
                                              -> dspi_fifo_read()
                                              -> dspi_fifo_write()
                                                 -> dspi_xspi_fifo_write()
                                                    -> dspi_pop_tx()
                                                       -> dspi->len = 0
                                           -> complete(&dspi->xfer_done)
-> reinit_completion(&dspi->xfer_done)
                                           <IRQ>
                                           dspi_interrupt()
                                           -> Second interrupt is spurious at
                                              this point, since the process
                                              context may have proceeded
                                              to change pointers in
                                              dspi->cur_transfer, etc.

Clearer now? Essentially the complete() call is premature, it needs to
be not after the dspi_fifo_write() call, but after its subsequent
dspi_fifo_read(), which comes after yet another IRQ, in the IRQ-triggered
path.

Not sure why you are not able to reproduce this, maybe luck had it that
the complete() call never woke up the process context earlier than the
second IRQ in the above case triggered?

I'm not doing anything special in particular, just booted a board with a
SPI device driver (sja1105). This transfers some sequences of relatively
large buffers (256 bytes) at probe time, maybe that exercises the
controller driver more than the average peripheral driver.

