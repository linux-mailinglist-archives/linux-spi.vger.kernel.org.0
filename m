Return-Path: <linux-spi+bounces-8942-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B323AEFB8A
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 16:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE47F7B556F
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 14:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71612275AF5;
	Tue,  1 Jul 2025 13:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jvjf7ImR"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011069.outbound.protection.outlook.com [52.101.65.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1523627381F;
	Tue,  1 Jul 2025 13:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751378275; cv=fail; b=bSRITbHryFOPR3MMW+Q3ilGA7c8a1blzvzKoIWPna5Xhcy/WQc0xDZtI+WRM7MEq/ucakjBfUoJ5ZST225xe+IenMFkS72cKW58O1eDJZwNXDeauMXGL+o0QvEUZiLpVZV1/eUYmw+AZA3Bz2Fxo7HB192Ug87HRkJ6OII0VxYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751378275; c=relaxed/simple;
	bh=9c1JRydcfD5HLhdk0nGT6AIN17enATBQkLIiHev1UAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BQX/eMUeqXyzLNgeR/hMbRT2gGNDg3lHouxoO9WeBaN12mKPwGj+bSmwNFkOkwLigj3gAqb6kagsrHfYILotl5/N36cPFvLo3gjAyXk2Sxgfc7lNSym4HGG+BD7fYyWmiCJ5ff9o1ZCZQoyTpLca4z780kGUhREpwMB2i7TWIF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jvjf7ImR; arc=fail smtp.client-ip=52.101.65.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdelbqErapkrybGTDKs8IKeTSMCwpqyo/uvzr3jlwhC3kd8d97LbvRhN9wmZVvZ8e2Ft0qEEkkBQf1rYA+7RMI998k79AUaa3qz5VnjLdrxpFgKBSlUo/omTCC+i8ACQz1PVP6bAknqfL9y/oqD91RBUVhYa23HC3j7uevkqZNSWhtA5L6FCxXyGPjhH4rEz9oScbX9mXMcfkaXj1RW+RI6I89UQsSntbQhXIwAhtJElgnZGJuS5fP7cy/BI1R6Q/LQIYwgSjvd62rIuofwuqabPKRR0N2JDeS9c+1IEWoQPMap4wYMhGjiXz/1UZ1hfD61fd/yBYlGs10lLk4tP8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29nw/oxCxZVQVLz6JyBNHZgvyoU82+eCvCzFmR+9DDs=;
 b=XY0bG8Y/ZtHD05wECPdz6WxhIgasiZ57AoJKzNs35NVV9B+BIGQxhW6NDgtq0LQ93v6PRGBxjkguDRfNxK0/4DW7ppxsxmUy+3pUnlugQW1B6DOkkqVuHP8EunBQOEKa8AZPRWx8FxZAqd4A8+N/Z8tUVzHtEM9kEnZ79bsa6KWAvB9THgbeWRGczE1Znt1J/D1ugMXsLN7bFDld3Ii66iT7NPA0yxkclsV7JcQ4zYSPJ/Ohw1OXTB3Hb2XVf7mL9DDVyNxXE2KNGEj5CreHpcbQdGd6k7QTYcDyXFIT2fOGTNAO+vnjZEMxHB3VlfvrOCyMF2C3xKQo2kay6RJjSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29nw/oxCxZVQVLz6JyBNHZgvyoU82+eCvCzFmR+9DDs=;
 b=jvjf7ImRasn+Jism+AKx8BVwJHFIMW0KuI0R+UfngCAlwlmb1I5Fpx+8RGOt+gdMmMNmo4EcxKYqsFHIW41qJirSm9prKmqQWjBAUnUAyltAqbxwtYi8EHCxt/PGX5o7WVVrmlrz4gXDWvii0Vl46i1kMrlE7O2367YVl2pS4DP1PURmtC+9ojXcvtOaPpGbus/QeUcuekwcLhTUPK9XWaBB582TGTDDkDT/J7h8N/3844Uet6YwOtvsMnFopaFt0Od2gl6wKv6bw5QzLPzTWUTa+UzumAQqVdIiDudda/CAsTB6LRrFbyd0Boa7l+4MJ81Wq0fnSwQhB0Ogf8L0aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB7575.eurprd04.prod.outlook.com (2603:10a6:20b:29c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Tue, 1 Jul
 2025 13:57:50 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.8880.030; Tue, 1 Jul 2025
 13:57:50 +0000
Date: Tue, 1 Jul 2025 16:57:47 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: James Clark <james.clark@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Frank Li <Frank.li@nxp.com>, Christoph Hellwig <hch@lst.de>,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] spi: spi-fsl-dspi: Target mode improvements
Message-ID: <20250701135747.mns6emamtmxwgpyu@skbuf>
References: <20250627-james-nxp-spi-dma-v4-0-178dba20c120@linaro.org>
 <20250630152612.npdobwbcezl5nlym@skbuf>
 <c9bf945b-9fc6-4829-addf-2fb7a7d4eb36@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9bf945b-9fc6-4829-addf-2fb7a7d4eb36@linaro.org>
X-ClientProxiedBy: VE1PR03CA0034.eurprd03.prod.outlook.com
 (2603:10a6:803:118::23) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: fa77a9f9-7d4b-4807-28d2-08ddb8a74427
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z0lIXeDOstBhvdRZcug8b+2B7hifBNab4wM3P+nDlAQFZMFTgtXcIHa9LOIU?=
 =?us-ascii?Q?1bnUTIjJimNdk8WoZEr5T3Nd+7uU+HXmDrQVnBmLPPQfiFU9ZvD7hOdZASgt?=
 =?us-ascii?Q?dGBx+HQU+xg4mcwnNVw+GXKMtN2U1AaVqs3y73BEKw0Ai01HS7E6B+hzdm7r?=
 =?us-ascii?Q?M4o9P1j7oKHsQ6FNlZ585JGY/KLoKnVWlVMFIJ1jLfoD/eyaLWbMBLqFJCHa?=
 =?us-ascii?Q?3q7ZhgvhFWy19JXdsWHehMznWQ7MThbi8Lvw3uEQ4PgNAxNv5xP1CpaUXuAB?=
 =?us-ascii?Q?0Hz8GbEhrbVAmbMrcSxZjc5iZwJMBlCB8+u/2jUlLjZXdf1uGfWrrBPLsF/S?=
 =?us-ascii?Q?hiQHP7nGH4KS1oT9ICROrh+9+dp8qAv8wCwqkM1+YAc4YUMMv3Ya5owSt5C0?=
 =?us-ascii?Q?6fSTkYHcVMaZifK8LK1bKh1vGIHFvagh3ZVlsUvs1B8Q9HpRCLlFkd10/gbv?=
 =?us-ascii?Q?5+x/05by9GqrD9ljSxBi77ZK+K6rArd8fkeOHHMhUfGI1kN0n4eHemmTuTxp?=
 =?us-ascii?Q?muiZnriW+GCGYobZ8aMbFqm5R/dmy66v6u8XnErEFTbon9eLOukgS/aOmSI5?=
 =?us-ascii?Q?i6zcwCxi6gwUVCnnWwKY8oKT5Xw/LAPSnU+6rypoE+d0jGbkCrcZhBXWksQg?=
 =?us-ascii?Q?4WqBkWFFwAq/MmW3Ij8nyZfw9jTzVyXAwaVVFzk0S1jdb6VK4VO2c4vNYC2x?=
 =?us-ascii?Q?i+EJjjjbCpflCBEpG9NpQ6KDUAOPT5SkinyiGakvoKkCs8rkgQ/7ZZbfV1rB?=
 =?us-ascii?Q?bHAJY0AHYwMuLIPR1yP0C6S6Nt+f2h4vp5s9UYEIokDEBd7L1Gdb/THjCDbN?=
 =?us-ascii?Q?fQI6aTcLoLyfBypb/JBeJZ34Z0r4vdJtoqzv4rujdtI8OpJSm5rhr8NKM4Vj?=
 =?us-ascii?Q?c2lkeyWexxTTeblGFVGZnDXmUDgVvzmMUXSBzQj4JbydJVfsqiSJtzE6p0cY?=
 =?us-ascii?Q?sCAF9svn7gQMTZoGwLFYdLqt1Hn213PfEIDxjK+hTGWfrcWhrImIgTHwH3iS?=
 =?us-ascii?Q?xhJgBMs/mfo9fu6d1nHLKxn1ZSunYfTNnvZdM2dM8nvmFuqQVQFxW7XTPi5H?=
 =?us-ascii?Q?7el2CBZhyhOA8jDcColnpDMmC9f48qxSPcp5iIxFMYzvr9vYV4DitIqbpvZm?=
 =?us-ascii?Q?2y6U6lWrGXNi2jKQmB/v+IxzqO6ZZ3olHzRTtNZUUG8YPdcJ5wjK/zfPpMkl?=
 =?us-ascii?Q?UNFGzLRv8nSl11yQWyGJzpOiFf0ZnvfJxSVCQ/aECcz3P+nOwN3gcpXvVIyi?=
 =?us-ascii?Q?JvgEUuh7NJNZgMaqzdUPZVtYK0XWtsVMAdL/3IP4PkW1uIUlIPyVXA0Otej8?=
 =?us-ascii?Q?jcAzNHhWwafS7PoRoLCHh1FNU0s1gS7diT+kSmRzGCnVKCQRYnoLe4sP6H2A?=
 =?us-ascii?Q?BukrRP8YMLdQjSeAaQUa+pGKGLMNT5muhoIPeNzD96naMJp1sZt2NGEDClhQ?=
 =?us-ascii?Q?CVesFenx1TM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fr7sc1kw0eQwUIIgvQ0j5ThI1B5pmfZXyk2jsxUlU769SxR5eDEmuyAntXgS?=
 =?us-ascii?Q?JJOcslQ9r439AelY/6fHL1nOJZdCmEwJl6IPhGaeoGYLkC/ytIRCR977hoVg?=
 =?us-ascii?Q?kr/MBVPhlVH4zd0bTJG2EGMKCWBYkfRBd9oUviXeV/BTa2kIJYWldG8Yalgt?=
 =?us-ascii?Q?/Yk/QhmUFwrOPVxGHmvozWxjR40S2u/8Nal007ZSCVq1OSXAGQ/Oh1gwzeTp?=
 =?us-ascii?Q?irf2zzT3gfdYgnPK8EDGH41Nr9U2JAMUGufgO8V5jf+KwJj2OyQcM2Sz+iid?=
 =?us-ascii?Q?G7xxFb0Oo8qmMXeV7RJxYkadSCjnxsE8rvYSoFCScFIUwATVLOAS1V/LBvab?=
 =?us-ascii?Q?8NG/nVm7fisfCS+06VVwfM6X3r2Sj723S/mdJuhq0YrWYwmGu1D+ueMD+OIg?=
 =?us-ascii?Q?zN2JBEfjBgcaayYZweXHPX7wuGWtWnvuaQApwddnSq1ufkvH1B1QqZWzk4lT?=
 =?us-ascii?Q?LNDfJAkqO7n9fVqVxX4QKy4Jm28PXKLkdNqbCUynkWlNWYtyQykVcB5bySbl?=
 =?us-ascii?Q?VFMfX5zOg0D6f3Sl0nDncKCDV2M8fw3wQU4avZDcZtC4cOue0M+Zo5lgpy9z?=
 =?us-ascii?Q?9Tv844+BbArcYJ7vyyc/M/nCtfZ1mIS26a6sCAWBXA8tGvUlrZiZokTAxJUd?=
 =?us-ascii?Q?ZtmTgDtrwcP8X89+6DpiISxe0r/YXSp/ssXthocPQw1QtreIidVaDVK8IdTx?=
 =?us-ascii?Q?0WZdWxEbAVGnMxxsZB5PdlqFPDBvbi2hUlj95L1jT1YjHPRYxj9qS4hMz9MM?=
 =?us-ascii?Q?+5JLgOa5TlZcHNEGoy7O7jHzO49jMO2I16d6G5xwu9v/holJcxb2FOS/G8zL?=
 =?us-ascii?Q?5Nzg8CJbabt9gptP9Un/Gwze/xmYhlBvETDySM7x2DiO+WC4zsBGulJxxG8+?=
 =?us-ascii?Q?xwDhc+pcF5eds63E3Is/EE7d5QPkUKfeU1QGB88/S6fZ/8X0r8or9JxtR1Oe?=
 =?us-ascii?Q?yjzpSE+HlMSqLXTUSSl0kmuJXYJZItbJXDFgsrTToUg+wC+NkeLDtzSlaVY7?=
 =?us-ascii?Q?jpp0Q20PU4RHExL+ztNdrwLZmTJ6oe4T07uFLMGtqJnkxe+oZ2dPacExVrGk?=
 =?us-ascii?Q?FdxFPDgDkbGZu8xL8HnZFieOIRYOrUg6kWrWysS5Poj13SfDYfLCgNz6Rhhe?=
 =?us-ascii?Q?0C6fcNfTgiY/xfgVhEFh/abeQC+J97rGrdTpDJjCGCqo02W3BmpUZGRqMz69?=
 =?us-ascii?Q?ABC8K4tu4WaDflqoQylaxQwWpa2WWrFTWfZnfLMlvj1dZ8KEJrpIzbkPFYCe?=
 =?us-ascii?Q?adWoloZBgq5lzBVC5LaJ5e76BK1S8JAzvhaQPaok+8fX4sXjYpRRqFAlffAd?=
 =?us-ascii?Q?7HWiqZprgo75HFv/Q6grCxU0pLb2ek9j2+g1QRhArMUnPZ+zFHVFSGr5YbCs?=
 =?us-ascii?Q?hXreZEWsC9q0FEw4SZxX+lkNsfwTkbUDdyBeBxG7fSiC3K7euKF0OqSSEL5g?=
 =?us-ascii?Q?fmgem1aW4jWtbkPBtl3Cos63Ls7/cB+weaEpfSJLANCNy0WiMsBYmbK7QQqg?=
 =?us-ascii?Q?Kv3deVSHAWTzx9RGaQG1Y4mRH2YIl2s9TWUEYBg9XKf5G+OiQIRUjgsVIHdN?=
 =?us-ascii?Q?8JNn0syLsmjnnoxWl8ok0WaoXX5njHpaUwk7q6qX2lWzThG1brsXoCGihe9B?=
 =?us-ascii?Q?q1zZQbLmjweGEuZvJ5AFwNQa4sAwTjbohMv+AtAHqWtV3U/u06gAYrNAZkTM?=
 =?us-ascii?Q?CvZSoA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa77a9f9-7d4b-4807-28d2-08ddb8a74427
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 13:57:50.0982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eEQQ/8CJVDRYA4a+feLPN2r5F6tFHJ/6iWUVRmYoRp0pzRSuJBwLVO2t8WtQmmWAYZLHPDnZeJ0srs+5lH6wiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7575

On Tue, Jul 01, 2025 at 01:42:46PM +0100, James Clark wrote:
> I wonder if latency could be higher despite increased throughput? It
> probably wouldn't be a big enough increase that anyone would care. And based
> on the structure of the driver if throughput is higher the latency might
> even be lower.

Actually, I do have a metric for that, sort of. I have a SPI-controlled
Ethernet switch with support for IEEE 1588, and synchronizing its
hardware clock over SPI benefits greatly from having a high precision
software timestamping point for the SPI transfers themselves.

Essentially, with XSPI FIFO mode we are able to provide a timestamping
granularity of $(FIFO size) words, see the spi_take_timestamp_pre() and
spi_take_timestamp_post() calls. Whereas with DMA, we let the core take
a message-level software timestamp which is much coarser, because at
driver level we can't guarantee a much more precise transmission time
interval for a particular requested byte. See __spi_pump_transfer_message().

If you're not familiar with phc2sys, an interpretation of the logs below
is as follows.

phc2sys synchronizes the sw2p0 (target) clock to CLOCK_REALTIME (the
source clock). "delay" is the time it took for the kernel to read the
target clock once, and the system clock twice (before and after).
When software timestamps the SPI transfer that reads the hardware time,
this is called a "cross timestamp". The smaller and less jittery this
delay, the more stable the cross-timestamp and the better will software
be able to discipline the target clock (aka the smaller the offsets will
be).

Before:

$ phc2sys -s CLOCK_REALTIME -c sw2p0 -O 0 -m
phc2sys[38.432]: sw2p0 sys offset -1741272972548124929 s0 freq      +0 delay   6720
phc2sys[39.434]: sw2p0 sys offset -1741272972548179141 s1 freq  -54094 delay   5960
phc2sys[40.436]: sw2p0 sys offset       190 s2 freq  -53904 delay   6001
phc2sys[41.437]: sw2p0 sys offset       306 s2 freq  -53731 delay   6520
phc2sys[42.438]: sw2p0 sys offset       275 s2 freq  -53670 delay   6401
phc2sys[43.441]: sw2p0 sys offset       350 s2 freq  -53513 delay   6881
phc2sys[44.442]: sw2p0 sys offset      -302 s2 freq  -54060 delay   6321
phc2sys[45.444]: sw2p0 sys offset        35 s2 freq  -53814 delay   6761
phc2sys[46.446]: sw2p0 sys offset      -103 s2 freq  -53941 delay   6481
phc2sys[47.447]: sw2p0 sys offset       -43 s2 freq  -53912 delay   6361
phc2sys[48.450]: sw2p0 sys offset       314 s2 freq  -53568 delay   6960
phc2sys[49.451]: sw2p0 sys offset      -310 s2 freq  -54098 delay   6441
phc2sys[50.453]: sw2p0 sys offset       -86 s2 freq  -53967 delay   6321
phc2sys[51.455]: sw2p0 sys offset        -5 s2 freq  -53911 delay   6401
phc2sys[52.457]: sw2p0 sys offset        -2 s2 freq  -53910 delay   6320
phc2sys[53.458]: sw2p0 sys offset        77 s2 freq  -53832 delay   6400
phc2sys[54.459]: sw2p0 sys offset      -112 s2 freq  -53997 delay   6240
phc2sys[55.461]: sw2p0 sys offset        66 s2 freq  -53853 delay   6480
phc2sys[56.463]: sw2p0 sys offset       -33 s2 freq  -53932 delay   6441
phc2sys[57.465]: sw2p0 sys offset       -33 s2 freq  -53942 delay   6441
phc2sys[58.467]: sw2p0 sys offset        17 s2 freq  -53902 delay   6440
phc2sys[59.468]: sw2p0 sys offset       -14 s2 freq  -53928 delay   6520
phc2sys[60.470]: sw2p0 sys offset      -133 s2 freq  -54051 delay   6281
phc2sys[61.472]: sw2p0 sys offset         8 s2 freq  -53950 delay   6400
phc2sys[62.473]: sw2p0 sys offset        25 s2 freq  -53931 delay   6400
phc2sys[63.474]: sw2p0 sys offset      -113 s2 freq  -54061 delay   6040
phc2sys[64.476]: sw2p0 sys offset        44 s2 freq  -53938 delay   6281
phc2sys[65.477]: sw2p0 sys offset       -17 s2 freq  -53986 delay   6320
phc2sys[66.479]: sw2p0 sys offset       -86 s2 freq  -54060 delay   5841
phc2sys[67.480]: sw2p0 sys offset       141 s2 freq  -53859 delay   6361
phc2sys[68.481]: sw2p0 sys offset       -11 s2 freq  -53968 delay   6320
phc2sys[69.483]: sw2p0 sys offset       -15 s2 freq  -53976 delay   6321
phc2sys[70.484]: sw2p0 sys offset      -109 s2 freq  -54074 delay   5960
phc2sys[71.486]: sw2p0 sys offset       115 s2 freq  -53883 delay   6520
phc2sys[72.488]: sw2p0 sys offset       -86 s2 freq  -54049 delay   6280
phc2sys[73.489]: sw2p0 sys offset       234 s2 freq  -53755 delay   6801
phc2sys[74.491]: sw2p0 sys offset      -219 s2 freq  -54138 delay   6361
^Cphc2sys[74.923]: sw2p0 sys offset      -174 s2 freq  -54159 delay   6360

After:

$ phc2sys -s CLOCK_REALTIME -c sw2p0 -O 0 -m
phc2sys[753.479]: sw2p0 sys offset 1882248595 s0 freq +32000000 delay 150440
phc2sys[754.482]: sw2p0 sys offset 1850232103 s1 freq  +46787 delay 141960
phc2sys[755.483]: sw2p0 sys offset    -33278 s2 freq  +13509 delay 143160
phc2sys[756.485]: sw2p0 sys offset     -5074 s2 freq  +31729 delay 150040
phc2sys[757.486]: sw2p0 sys offset     11060 s2 freq  +46341 delay 140240
phc2sys[758.488]: sw2p0 sys offset      4804 s2 freq  +43403 delay 151320
phc2sys[759.489]: sw2p0 sys offset     10358 s2 freq  +50398 delay 141879
phc2sys[760.491]: sw2p0 sys offset       409 s2 freq  +43557 delay 148840
phc2sys[761.493]: sw2p0 sys offset      3863 s2 freq  +47133 delay 143360
phc2sys[762.494]: sw2p0 sys offset       259 s2 freq  +44688 delay 145840
phc2sys[763.496]: sw2p0 sys offset      1849 s2 freq  +46356 delay 141000
phc2sys[764.497]: sw2p0 sys offset     -1800 s2 freq  +43262 delay 144160
phc2sys[765.499]: sw2p0 sys offset      -184 s2 freq  +44338 delay 139880
phc2sys[766.501]: sw2p0 sys offset     -1677 s2 freq  +42790 delay 146120
phc2sys[767.502]: sw2p0 sys offset      2529 s2 freq  +46492 delay 141040
phc2sys[768.504]: sw2p0 sys offset     -4368 s2 freq  +40354 delay 151240
phc2sys[769.505]: sw2p0 sys offset      1112 s2 freq  +44524 delay 147680
phc2sys[770.507]: sw2p0 sys offset      3002 s2 freq  +46747 delay 142960
phc2sys[771.509]: sw2p0 sys offset      -899 s2 freq  +43747 delay 145440
phc2sys[772.510]: sw2p0 sys offset     -2003 s2 freq  +42373 delay 148360
phc2sys[773.512]: sw2p0 sys offset      3675 s2 freq  +47450 delay 141440
phc2sys[774.514]: sw2p0 sys offset     -1417 s2 freq  +43461 delay 144960
phc2sys[775.515]: sw2p0 sys offset       802 s2 freq  +45255 delay 142559
phc2sys[776.517]: sw2p0 sys offset      1368 s2 freq  +46061 delay 140040
phc2sys[777.518]: sw2p0 sys offset     -1897 s2 freq  +43207 delay 141840
phc2sys[778.520]: sw2p0 sys offset      -774 s2 freq  +43761 delay 141680
phc2sys[779.522]: sw2p0 sys offset     -1715 s2 freq  +42587 delay 145199
phc2sys[780.523]: sw2p0 sys offset      4045 s2 freq  +47833 delay 134839
phc2sys[781.525]: sw2p0 sys offset     -4809 s2 freq  +40192 delay 146840
phc2sys[782.526]: sw2p0 sys offset       363 s2 freq  +43922 delay 144759
phc2sys[783.528]: sw2p0 sys offset      3328 s2 freq  +46996 delay 140240
phc2sys[784.530]: sw2p0 sys offset      -293 s2 freq  +44373 delay 142480
phc2sys[785.531]: sw2p0 sys offset        46 s2 freq  +44624 delay 142000
phc2sys[786.533]: sw2p0 sys offset     -3422 s2 freq  +41170 delay 148080
phc2sys[787.534]: sw2p0 sys offset      2932 s2 freq  +46497 delay 140720
phc2sys[788.536]: sw2p0 sys offset     -1961 s2 freq  +42484 delay 147040
phc2sys[789.537]: sw2p0 sys offset      -945 s2 freq  +42912 delay 149160
phc2sys[790.539]: sw2p0 sys offset      3221 s2 freq  +46794 delay 143040
phc2sys[791.541]: sw2p0 sys offset        41 s2 freq  +44580 delay 144160
phc2sys[792.542]: sw2p0 sys offset      -748 s2 freq  +43804 delay 145120

Here, the synchronization offsets in DMA mode are an order of magnitude
worse, so yeah, initial enthusiasm definitely curbed now.

For me, what matters is not the latency itself, but the ability to
cross-timestamp one byte within the SPI transfer with high granularity,
and for the uncertainty of that timestamp to be as small and constant as
possible.

For that reason, I can post a third output log, taken in XSPI FIFO mode
but with "ctlr->ptp_sts_supported = true" removed. That causes the core
to take message-level software timestamps, which are a better indicator
of latency.

You can see that in FIFO mode, the minimum is much smaller (108 us) but
the spread is larger (the maximum is 209 us). In DMA mode, the latencies
are much more stable. But despite this, XSPI is still better for the
ability to zoom in on the particular byte of interest.

$ phc2sys -s CLOCK_REALTIME -c sw2p0 -O 0 -m
phc2sys[246.568]: sw2p0 sys offset   2872475 s0 freq  -88840 delay 131332
phc2sys[247.571]: sw2p0 sys offset   2874267 s1 freq  -87052 delay 194739
phc2sys[248.572]: sw2p0 sys offset     71966 s2 freq  -15086 delay 114971
phc2sys[249.573]: sw2p0 sys offset     34792 s2 freq  -30670 delay 108331
phc2sys[250.575]: sw2p0 sys offset    -39553 s2 freq  -94578 delay 208580
phc2sys[251.577]: sw2p0 sys offset     50369 s2 freq  -16521 delay 107410
phc2sys[252.578]: sw2p0 sys offset      1597 s2 freq  -50183 delay 128292
phc2sys[253.579]: sw2p0 sys offset      6685 s2 freq  -44616 delay 107810
phc2sys[254.581]: sw2p0 sys offset     -4102 s2 freq  -53397 delay 108530
phc2sys[255.582]: sw2p0 sys offset     -7256 s2 freq  -57782 delay 112051
phc2sys[256.584]: sw2p0 sys offset     -2910 s2 freq  -55613 delay 108610
phc2sys[257.586]: sw2p0 sys offset    -52981 s2 freq -106557 delay 209460
phc2sys[258.587]: sw2p0 sys offset     49914 s2 freq  -19556 delay 107130
phc2sys[259.589]: sw2p0 sys offset    -29913 s2 freq  -84409 delay 195699
phc2sys[260.591]: sw2p0 sys offset     42439 s2 freq  -21031 delay 110411
phc2sys[261.592]: sw2p0 sys offset      3048 s2 freq  -47690 delay 120571
phc2sys[262.594]: sw2p0 sys offset      -853 s2 freq  -50676 delay 113291
phc2sys[263.596]: sw2p0 sys offset    -35260 s2 freq  -85339 delay 173937
phc2sys[264.597]: sw2p0 sys offset     26479 s2 freq  -34178 delay 110570
phc2sys[265.599]: sw2p0 sys offset    -36802 s2 freq  -89516 delay 195699
phc2sys[266.601]: sw2p0 sys offset     39945 s2 freq  -23809 delay 110571
phc2sys[267.603]: sw2p0 sys offset    -32036 s2 freq  -83807 delay 194858
phc2sys[268.604]: sw2p0 sys offset     37721 s2 freq  -23661 delay 110570
phc2sys[269.606]: sw2p0 sys offset      5110 s2 freq  -44955 delay 112571
phc2sys[270.607]: sw2p0 sys offset     -3526 s2 freq  -52058 delay 109570
phc2sys[271.608]: sw2p0 sys offset     -7856 s2 freq  -57446 delay 112491
phc2sys[272.610]: sw2p0 sys offset     -5259 s2 freq  -57206 delay 112051
phc2sys[273.612]: sw2p0 sys offset    -43272 s2 freq  -96797 delay 194178
phc2sys[274.613]: sw2p0 sys offset     40708 s2 freq  -25798 delay 108291
phc2sys[275.615]: sw2p0 sys offset    -38753 s2 freq  -93047 delay 208900
phc2sys[276.616]: sw2p0 sys offset     47948 s2 freq  -17972 delay 111050
phc2sys[277.618]: sw2p0 sys offset     10692 s2 freq  -40843 delay 111131
phc2sys[278.619]: sw2p0 sys offset     -2179 s2 freq  -50507 delay 108530
phc2sys[279.620]: sw2p0 sys offset     -8143 s2 freq  -57124 delay 111571
phc2sys[280.623]: sw2p0 sys offset    -49486 s2 freq -100910 delay 199179
phc2sys[281.625]: sw2p0 sys offset     -3684 s2 freq  -69954 delay 199419
phc2sys[282.626]: sw2p0 sys offset     54475 s2 freq  -12900 delay 111651
phc2sys[283.628]: sw2p0 sys offset    -36562 s2 freq  -87595 delay 209420
^Cphc2sys[284.181]: sw2p0 sys offset    -11239 s2 freq  -73240 delay 194499

