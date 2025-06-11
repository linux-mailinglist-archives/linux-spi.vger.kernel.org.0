Return-Path: <linux-spi+bounces-8443-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA2CAD4F3B
	for <lists+linux-spi@lfdr.de>; Wed, 11 Jun 2025 11:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3149F1891C0C
	for <lists+linux-spi@lfdr.de>; Wed, 11 Jun 2025 09:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA2625EF93;
	Wed, 11 Jun 2025 09:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WkRdIBf1"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010064.outbound.protection.outlook.com [52.101.84.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F32625F79C;
	Wed, 11 Jun 2025 09:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749632475; cv=fail; b=ftrVRPWOuUWN3cw42X6186hDavuA7BlIeqNBbjNqTmUcyJqWXYrwd67ICbFpQHLV/CNPibRf7lK/bcQ4sGtPr1moAOFrsbN8lqe6Cp7bzT6g4FLlBwxinw8nnN1IGsSEfd4Ao8eMecnweX+HULMqqZxBT331fxLFIdYW4BW+X+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749632475; c=relaxed/simple;
	bh=fLgLYD2XKW8Ssn+DL+eyBEm8I57K7EUNd4H5HxoaiLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LC0WonblECqzji0Da8tkGoN3PzAOh8/yULv+wt/Mc0wkP6WcsZzy0BXwvf6F44GzXuDQ8CBlywjpKFlEW6xxn4aKUiNd/f8iPIxhDYsOu9fQtRCtlKbbjT1fIC8JZPnK/2RRB1by4DxCa8ONQqBGs1iEhECL25p2hrmG0jOO06U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WkRdIBf1; arc=fail smtp.client-ip=52.101.84.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3yKstLlUh2P7ciGvk7SzRNGpodTSZUZ1muyFHuPoCTl+6I5mHkhpBWGCHjKNKKH/EdoNddib1IXayMOHAUYSqbghIEak5kFFbrEI/ObDQBLPgZ1zGXZY8ZJxS3E8yM/+BZ9dOFbU685wnEfRpMRCOOLji0xTFSIXZD+tURtrH3pfzuXL07bi1Ic1YpvnonNC/u+giQa9FCdW4rCcO4Sg92d/ve80JHNugli6AEB4zzQ5JfjSZs6Wz2ZGUsvt51dNOWuUDx96p4tx3tzMK5X2rZPYjGk50j+vxUYW0xqrGsZ5+zYvQddIe1aQgwpY95HZpeiZB/A3slUxmap7e9cKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLgLYD2XKW8Ssn+DL+eyBEm8I57K7EUNd4H5HxoaiLM=;
 b=I7LY9Qb08USaSjsfGFB7D3PXWqkZWd5kVRqmApWgXTxmEBiXGg8kCHvT4Ev0j+gwUSGZhX8+hVQ1oZAXyNe4HuqkW4+PFK7aFPpFhRM0DErrbtEkVQXpkH7AgElPZLtI1MMDxXB2x+o5jkyXObwJDAnCYlXdqq2T+bSNJrXv8KRIrz/+mjDXhL9aiPtfJQsnHJMUF/P3jK3L3qD/e1KShzB8IH5TievfpjEZJ20HU4WOzwCykngSDwJqX3etQ1YAHTnhpIh7/dI05CeQbkIWnEg9wxVH2cq6/MiZq7iAfViEIHSWS4Ylg/d8iU8gq3tbdwTQe84pD8dMRskzZjnGDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLgLYD2XKW8Ssn+DL+eyBEm8I57K7EUNd4H5HxoaiLM=;
 b=WkRdIBf12jcCxUZCbM9jg+wgGTAjy1BA/zV6CZN8+fi8MnJCIYu3orqB5IZzk4GuJsVRY66+9o/YK+lFiIjJOB9GQDlKarLjC2501/lyeUIWzpJzIiGRPQ91EfoEUyFhuGsjmM50OQGv0Z8OEt4DWbIU1WfpDFsvT7KsdMVMT9A/f3zlEmvnxDwBvxoOeCtz0TpUpqBtYy6sO9m+DpLcArGbPiMeAVATok+b6qkT5rmL0GRctJIusZ/7OaSlOlRkyJL2NVlQfv/MVYkM4aB4YngBWFYbtGChyRh/l25PFW9eJ6xy9SlLWXGLVuX+2i1U+tMydTCQSGDS9FPafXJWRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB7575.eurprd04.prod.outlook.com (2603:10a6:20b:29c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Wed, 11 Jun
 2025 09:01:10 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8835.018; Wed, 11 Jun 2025
 09:01:10 +0000
Date: Wed, 11 Jun 2025 12:01:07 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: James Clark <james.clark@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Frank Li <Frank.li@nxp.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] spi: spi-fsl-dspi: Use non-coherent memory for DMA
Message-ID: <20250611090107.t35zatn47vetnvse@skbuf>
References: <20250609-james-nxp-spi-dma-v1-0-2b831e714be2@linaro.org>
 <20250609-james-nxp-spi-dma-v1-2-2b831e714be2@linaro.org>
 <aEhMBsqlx9I4XqJS@lizhi-Precision-Tower-5810>
 <de7142ac-f1a3-412f-9f00-502222b20165@app.fastmail.com>
 <aEhVsrEk0qv+38r3@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEhVsrEk0qv+38r3@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: VI1PR04CA0085.eurprd04.prod.outlook.com
 (2603:10a6:803:64::20) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: 454326f7-91b6-4750-9237-08dda8c6826a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+Oy5/qJOOLtEDWDGtA0nbapjxYrtGWhC4ZKY7H1JUW4pb+IpGhJuAIF9mYS4?=
 =?us-ascii?Q?tGFA4ldoeTVfc1igc6qqssjzyHYNtZ00IvKZUnomiFarfeJiL9WszSu0aOcq?=
 =?us-ascii?Q?RztHwtxbGjP3riqyNuwNphaf4J1sf8LywGmLvFlJyJzaoYk/OSIPTGIjkiAO?=
 =?us-ascii?Q?ubQi2Di0jFCxwpfPTJveBGzjFktSJiDPVQWO8bOp/EluqBjO8Uk1ZtteSX4E?=
 =?us-ascii?Q?o4jH2k0uqqTs57Vfb1Zn3CnSjruf3Yqop5AurddXibXTwYm/SMVyT7vQy3dV?=
 =?us-ascii?Q?cy1+rngjtNzKzqUILZ08y1EzvbWrcWkF8DyM2hGeZqTbhaKiKrfp9fUgFWYX?=
 =?us-ascii?Q?LW3KfiQU5i7M7FcFYKSKeJpdhPbLSrtkw1zLnsV7aveC2GjGQ0XL1E39ab+e?=
 =?us-ascii?Q?uTVO/UqURXCgbT+yfqFs+L9RAL0VPMeLvYc0SKVoyDqYxtCM//XTv0xvFrCA?=
 =?us-ascii?Q?rcHlixD7f64zggmfBFHI6eXB+HzVSSHsrxPKK9m3LzGrRBUdc5NrMSN67Ia1?=
 =?us-ascii?Q?qY6UlVOx3l0NJVncyjOLcmhkiGt9OJ+JfDVabwuJTmmjrlYSz7x6YLkWwphP?=
 =?us-ascii?Q?gP93tsy1dRXyaQSIG0yBP8WZ87DO7YXenKpF2E0p/8Lp3oZVw6ZPqVf78dxH?=
 =?us-ascii?Q?+VvVQPkYoo8OKwv0BdjZ9wMqbyjHW1lgnhl0ES8QADn4QA/UepYdL2h9XyvP?=
 =?us-ascii?Q?49s3t9n0Lg0plT3A+zQUyglTdqC4nn8rna0Zc2gaaJu5KAHYnrkvgePikJB4?=
 =?us-ascii?Q?55pVJx9HT/VR8l7IGIoZKNZNQmaIApN0IxTQCYZZTbUPtNBMvkRWa94uuSNu?=
 =?us-ascii?Q?fR0Zm3xqt2aqe0lXBdVnCzAB/KvojzvSD5OgjqzXRU/3/6dqq07XfSQlBHDU?=
 =?us-ascii?Q?Wxr5rLX3jHk/hNA+GH248W+MBXbtKBmWsYAuA05bI7uKNmbOh8pyZH0CPjMx?=
 =?us-ascii?Q?yNL/hGrb7j8RG7Nc40IH75VSz4+6Xf+7ALgCcU5cqojSn061KkMQYoNUKrd4?=
 =?us-ascii?Q?BXTV967IBmbdMK/THIsajhRzouOjK1AgYUz+WHnuqEWIDZBSnlfryU+6xS+K?=
 =?us-ascii?Q?G2Fkipmndjx6A8PO47825hGMN4UPvj1qqQX1p+bb2W2D3oewvUkPyOJikMdZ?=
 =?us-ascii?Q?hrUTFhjrJboG8kNgMj4gYm5bBzpUvdgcZ+/F8n23I4u+ECXY04yz9Jm5sgxd?=
 =?us-ascii?Q?/2459XJK3NlUP3/MnRr6fi59tfrWo1X2Wf6v8zpVzRuY4mXwPZaPlGOKCWsS?=
 =?us-ascii?Q?okVXFJtPimmd4KgCz1VEZ6jTmSSvC/E7rpU7mGIwcJIZXR6QyAUD/CS99wpn?=
 =?us-ascii?Q?Ho+GreggL56H+2b992VVnNwREaCQlBKvxCYmG4OkHDm/A73jWTiSPL9pEMBx?=
 =?us-ascii?Q?Z7P9jkDDE7+j1GHZUOMAgqPY/oSfyIxSpCUi3KN3FSnnor0H7xUNXXx0jnih?=
 =?us-ascii?Q?KNVCOZ+vFCw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IWCmOJHS6jY5vUAZ2IS+DioUwVgf0bHbcb5dcaRH0noCU71s78CNOUdLv7++?=
 =?us-ascii?Q?ylDJSYXQUlSZockyfGCTB66mW8coI2/osGUDi6cjGExAw1noqyWMpJe1iLIR?=
 =?us-ascii?Q?C7bE2KbxEm1L2ZmOv5Fbqug4UHD7Jd0HUYfeh4NxsWX6eiNtlgOfCWId2oDv?=
 =?us-ascii?Q?wVy67/yEoP7haTulmU7ORUY3Pk0+7WW6C6w8VhOGJBjNd/n5zwk/wtbDIrR5?=
 =?us-ascii?Q?iboztknGpeR8Z5ZzdV0YaDv94GTY47W2FdT+a82AyNaWhJsEeS98JOgxUumK?=
 =?us-ascii?Q?MGptPU9dj4HNeghVbRk1G6hiiYQVK92rnEWK+6IetVynzpJLf4S8QrEgXYJ1?=
 =?us-ascii?Q?O6GxUekhDhExjeBiLgwuBC3w7NyeRv4bi4vgQu4z37U0z6Ad58Z3fCHDtyl7?=
 =?us-ascii?Q?UCnWD6E4u17rLHNRRAQu/bJzKcPpqNMFfIsYNW53X/GRBx07F3rqmWQNnAoR?=
 =?us-ascii?Q?+83AyHlR4dOBfCxtQvrdEsNt8rOQ7+0/EfRA6/zHWaHqyyhUmRp36FLjWtXZ?=
 =?us-ascii?Q?sMPJPS+JOaMqGrCLJMK00FUVre/oC8OR9VrNG7Kk/CsK1Es2a7hjo5WbDOAM?=
 =?us-ascii?Q?RtnMVUmHJZqc4Z1BYoBDbJTwInLfvOEy78NQ3/ESevLNPH5QLW32+ioOGhyy?=
 =?us-ascii?Q?wfdpdf+2PsMsQx7hWv0Q8KygaFPRpPaECdThsokkSVkX6UXD3GB7LG9I1cer?=
 =?us-ascii?Q?iPhZ7iCawGUwQYuBgKTuEKeMleXcQ8B6+v0gKHufkJhi7omQH4CWxaaSM+3G?=
 =?us-ascii?Q?oyN8sPFZxOleWdwHV3E1Z0NXuUDMCx++8aRHcw58uF5uF3Sf94dIMgQAGqee?=
 =?us-ascii?Q?pkkExTO6wHfHRnQWgD6e5wApTKfVF3IUZCwc4gmmi5VlwLyxAa+RRGeHwUwE?=
 =?us-ascii?Q?jbwngjGCDpkd8mvL3lsS74cQ8u/5EHbfNclqx+sDWrWTP6q7up+LOfWQReTH?=
 =?us-ascii?Q?e7+BNY1lh61TyXwiou2N7pN4X0cgK/TaBYP77mAraxT8/TfWZUnVVD7e30xZ?=
 =?us-ascii?Q?nmVHfSreqaneOlBN076dBvoznGmSZVK7u5p6Ux8yY57qCb4CMSV6WnhByAyd?=
 =?us-ascii?Q?7vHhmbPhFHXlDxkEaAvP9fLwVlFFitA87KC1ndOxpr2nsiZ7b4D4u0kMjpNr?=
 =?us-ascii?Q?DTOqiLSNAdbexywAmFDTNMTYmTv0Fqex4nwjg3+00n4VSaqQNqTcerg7m6Mv?=
 =?us-ascii?Q?yJU99mXf6u8BZgsJVNMfcvyFrXb6E2kiv4ZXJMk7InQhL7J08zGYR7rPoLt7?=
 =?us-ascii?Q?XhcbadiguEbjf6jfGZtZ1vor676qM+iMMvduhp0usce1WDoXhWZ3DcirU4IZ?=
 =?us-ascii?Q?EXigRj4bwyYI9TVlD0+NCKRrGpVN4MfVhr4FmIJ60YdsveXxfH0NbW2rhSmV?=
 =?us-ascii?Q?dRjowHErTsJRXnKOajNqJFHX9xKbaGGdtg+FOBT4ERmVcG+fdbDFf36r6ZUz?=
 =?us-ascii?Q?7aRZA+qrPAe7/hvOo1+JJVKpEpkha270JkRBv3QgFA8xu4pTSIV08DBs3FAD?=
 =?us-ascii?Q?6v+D1AWorFYedpHyTr8DumRi9wEPSrjM+Yj2z7FDTQFcZwVF1mYlkbfxmsWf?=
 =?us-ascii?Q?C7xaUb9gyQYI71g/nmJwOfRO3M4Kbl87MIBezOzv5JOishVgDFRE+Otm7oZ4?=
 =?us-ascii?Q?/Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 454326f7-91b6-4750-9237-08dda8c6826a
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 09:01:10.3715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4PUvn/dbQjAusf0mEvUQhis+y0KFlmTUaPQXQFySVYxWk74acvDysQNk6A1BWs4+C8gAojZPB1llVOYEni/Phg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7575

On Tue, Jun 10, 2025 at 11:56:34AM -0400, Frank Li wrote:
> Can you add performance beneafit information after use non-coherent memory
> in commit message to let reviewer easily know your intention.

To expand on that, you can post the output of something like this
(before and after):
$ spidev_test --device /dev/spidev1.0 --bpw 8 --size 256 --cpha --iter 10000000 --speed 10000000
where /dev/spidev1.0 is an unconnected chip select with a dummy entry in
the device tree.

