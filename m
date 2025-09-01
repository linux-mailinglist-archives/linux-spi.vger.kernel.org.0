Return-Path: <linux-spi+bounces-9836-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF05B3E3DD
	for <lists+linux-spi@lfdr.de>; Mon,  1 Sep 2025 15:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11CB91A83150
	for <lists+linux-spi@lfdr.de>; Mon,  1 Sep 2025 13:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F6B78F2B;
	Mon,  1 Sep 2025 13:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QXdyDH9m"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013016.outbound.protection.outlook.com [40.107.162.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E454A23;
	Mon,  1 Sep 2025 13:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756731837; cv=fail; b=nFF+IXIntnpHKinIVHzX/oTYyQg9/ATf+xUldEvFP2y+PyWj2YqUfOcyh7gZnpMKjAQvPjITuKFw9YqEzUvgBYmqBYiivLZsBlqteIdy3e0nb7NGO+H8xrffqucvhwaXxmkj5eIo0De05u40s8sDpK21/OEJNzFlQhrhq6QgvO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756731837; c=relaxed/simple;
	bh=O0xENl+UWb5PB21qkXRWPqHM06R0feJ5PQIqk268E2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MI3IFGD5R2ZGVkCyr0/E/ssvyw6if2d+mP+xdfiCAp6lpZ/oNPZUAJD22xrv/R/GpN+WUV6KG4AQqv8kKdn9frQqj19yABdU3ydVQqEEHgSCgBAMoeLb6Lhxrn7K0wE/O6gF8JSd+hTB69wuA9tWYaOfvLKOrvs3a1+brwfTq2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QXdyDH9m; arc=fail smtp.client-ip=40.107.162.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lXvfiSO25L/KIJ7EqCnIpXwjG4pceCt20dOwbyRxNRXCsjA5zcfIPwdYq4tUansws1cfS15IJigXey/+IdE02sX+53ZwTfzlXKj0LRnAuoPW7Op6aDFv+s0v0HbcVllJlWJ1PUZf8tKTLu0fzrxUg6JwtbgzVgiGongyK4VVzvG1awdyB2BDmM4e10dmelgdrsGbAAXSsdGXMhZPdPjaVTx7+c5Q3d+7VFv/+ZukJ3E2HwPFVpikEtRmS6/eEGR+Vpq7qUET86SvY1s5reZ9gqXXsuEBKHn8Wu2Gd2trwn2Ck3qa8W4qN9nGEL5xJLtqLEg9KToJ+8JJKfD+mrE+/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4OqFRFnoqDeXt8uoows4k8nfZvOi16mj/VOoKXLl+Y=;
 b=YI2WWth+suE9r4wQRU/w0UAcqFcDpySSi/KJNHPbk+CriBzdZrtFXU2NEFfi3MzbKgt18MO2k+zjIGpe2IWoWvK3LBjC0UT7KRyGvfGkORHnWt9A0VvVZClhP4xhh9vQuXXMji8RBk1ziG38FQ1gSOMRljm6/kDvXReYWHRLgHzPGSUFo0AKiAhg2fq8dr7plZqsrbekcozaliOD67yeqxaa6/iOR9DDOQ6CEjWtktIV+oefzv7OpmTot3Vm+dBTaZ2svTvAwtC78iK73sii7dgLFu4wMv7oySwd5pDNBmRUdTGmRCEEvcdplIEyblYXf7aRL2f6YA46fkzmCfU9dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4OqFRFnoqDeXt8uoows4k8nfZvOi16mj/VOoKXLl+Y=;
 b=QXdyDH9mI7kyOQrBa0b65qUSlekafH6/QI/w3+44m7IIK6cM1N1E1P3ad8ZXtqQViG0LU+vATqu3NXyD+qxu59DkrXUs2iQ/HoUtxGGp82vzFLp2z2cdnEunMzFN4e0N/d0yqpYen3JGvTT7wbEarpwq2Na5RS/nN6FxUUwiqt39Gz2K0XRamhxVuTOa1Glcxi9cSuOKQg1WWRdeEoE3q7Q7Gxn8dVwPmHN3/UMyAjmm2nY0PZf03qjPm6/hudau2PzFBms3KMlTeeVT3oPe5dS0dsEfP285N2R8LhMOXd8RghKvu6o5gJ11saS78WwhcACm8O4qzvmxCZz247v2DQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS4PR04MB9552.eurprd04.prod.outlook.com (2603:10a6:20b:4fb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Mon, 1 Sep
 2025 13:03:52 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9094.011; Mon, 1 Sep 2025
 13:03:51 +0000
Date: Mon, 1 Sep 2025 16:03:48 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: James Clark <james.clark@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Frank Li <Frank.li@nxp.com>, Christoph Hellwig <hch@lst.de>,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/7] spi: spi-fsl-dspi: Stub out DMA functions
Message-ID: <20250901130348.wqwdmovih7fq7rz4@skbuf>
References: <20250829-james-nxp-spi-dma-v5-0-3246957a6ea9@linaro.org>
 <20250829-james-nxp-spi-dma-v5-3-3246957a6ea9@linaro.org>
 <20250829142636.7nv3ylyck5yda3fd@skbuf>
 <ce55ed06-7326-473b-a2f9-40b0bc61c396@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce55ed06-7326-473b-a2f9-40b0bc61c396@linaro.org>
X-ClientProxiedBy: BE1P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7c::15) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS4PR04MB9552:EE_
X-MS-Office365-Filtering-Correlation-Id: 25ec3e6f-c8ec-40a0-583b-08dde957ff6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|19092799006|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nefEKG5fSnezeK3kDoBhhJsluF7Ljwf1FKaXsgjuW3ymWhWpltb240Jnhf3W?=
 =?us-ascii?Q?YzqkMP3K93kIMLA+gFu0ZX0aqVlKxqyOGmFvFYYmoc0Gwesa+OJHUwRoKyXA?=
 =?us-ascii?Q?l43Sd5d3gHDPrg/TUwJi4zD7kGe9LjbjpSuw/B6JnwcSd5jVvvjLe4wHZiKk?=
 =?us-ascii?Q?IDxL5OY+Y3Mgx5+pnpqgdfTT5mDq8oz3Hi0glBULrSiTaeJ8+fvZhWcoJKIj?=
 =?us-ascii?Q?bz6UGNyN233I5tilLZIv2+SA1wLrHS6a9dxfOhwa7sbmtf5KAvT0jvA748lU?=
 =?us-ascii?Q?wGiHYJ5q+EUc39LXs+RI3dseCseloEBiL7m7wYhS1LTedSd2S5eYWTW2romF?=
 =?us-ascii?Q?xW2MShvJR+DbgsXWo594q07F0jWcydGF+bJQWzFU4u+6rtQWDNTYcv4ma9yZ?=
 =?us-ascii?Q?VIYPzZ5y9vnAdGM8lRjQSR1doIk0sRq0DhDjXmM7+c0B4kV/88cYOA72JwA3?=
 =?us-ascii?Q?97qG6TxcQkn9BfsmBmrwigSI+wQZfFEQ3kh/2NRqAtlTM9Bd/nVc02P3Gk/g?=
 =?us-ascii?Q?5LVT/ApGZpwgn0pNXMuxSfOFn7QMgrq0TamtGtBq3+wjFg8V0CPrV6qgwdS4?=
 =?us-ascii?Q?ueJH5Nrak+MWPWg/udHPc6OLZ305aOdCtRljgUJBSEDUoSOgok4nPjuJDb68?=
 =?us-ascii?Q?rdEHaomL1I/ZWYNH5a8ymaym49EW1zLKg0yINAPZxXgqB7nFORdGcPM0K8X7?=
 =?us-ascii?Q?RVK3XGpATHCDz6wS69145lwR9/fXaUQfyTrRRP1F1r91JetHf7zVj5GogCXg?=
 =?us-ascii?Q?aMFWGfIPsYmddgUPdJyQZZ/Dmhp8kfnO9Ehc8/VMYviC0AJasMfBOjaOnDq+?=
 =?us-ascii?Q?GfjUCWrPaA0zPORFdHlPrgMaq0wwff565ZeEVzSgvQVXghFRvjy5/LtSCDdk?=
 =?us-ascii?Q?rz8YevWrf4elR2VyqTFMOPcWYSabBetE3BpVhrIGjbNQWYiDqzakJxveDh+6?=
 =?us-ascii?Q?QMQL2HPaU9e7p6QSiA3N8DeAam+lohGTxHXhLZ/WWrMH+YcGtHckGrT1b5oq?=
 =?us-ascii?Q?OzPJkb3JyOn7PKPSSS917ef6H5joFWjMdZ8RgyNd2ES7Z9wwLn+eSd5nZndy?=
 =?us-ascii?Q?1fLHspa7KTluqEXDJO6s/fu5eEuSl7NHB3ooVmr2JaLGbwdaKlHXGoUsnbwi?=
 =?us-ascii?Q?qtrBOcmhpjRBlGp/3nJtdEaYjlcJAwNwlUKi1hravT6o2Ykj9wAywskqXuqp?=
 =?us-ascii?Q?nX6HqV4JR0u6X3ADRi9EyVUSjy5q029s7ym45PAy9UUFWXNvLZSAwtfco7XB?=
 =?us-ascii?Q?3M/6luhTZv9KosHk7m3GKap/apzxFmioqaApnhpuCro6qk8AdKUrIa82oePj?=
 =?us-ascii?Q?rwqf8EG5iEAEFSit9tEN3VYBu6auJaKAmUZso9UKyr4wmjQD5yjASxSZoh3l?=
 =?us-ascii?Q?aL0ksgmC9iy6+zXGmI+dQmISnfti33RDjd3tX8Af1oL48GvyYdeCtJrRWYdn?=
 =?us-ascii?Q?zxmSS8QoR9M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(19092799006)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K6YGY0eujtjehI9jplUfaOj7sqcHaqyegpPYeVdONQb4hU7FEi3arLB4J0S6?=
 =?us-ascii?Q?q5V0m1hFr3Rm1ooEJQ7umwlXbWxrPmR/su91Kopg1NoZq3uL7urmxBmvPwqY?=
 =?us-ascii?Q?wfsfwT6PXIIPQ07hChxIBSbUtoeEOzIYuFJ4zVacp4kkm5zbGSN7YWHuqlKV?=
 =?us-ascii?Q?RzQ6gkaOOH0Q4EdtK2E6TrRKL+xItcN9II73NIkLJRMTMvNfGefwmjLO2xv7?=
 =?us-ascii?Q?AAgina7KD31sX8Su6m2aBKuKrhQEWLyHWXT/aK+CoPz+gvzUNY05/d/gQ1K7?=
 =?us-ascii?Q?D9uaWLKJNRyyEhs9qTHmyJWpSOfpTtAm0hNzNofVWKKAUqhP9jg3P++n/cTx?=
 =?us-ascii?Q?1zsyc+IJlBqt1YJU9FiIv/ohKb2vVTo0ALG/R/OjVCj194dkJb2hGHjexCEr?=
 =?us-ascii?Q?vOAkmpnpmYSTdbWf6WOisH3VmxOwVs+ajhC0K5z5xcqD0s7Hiv6K25lOCVto?=
 =?us-ascii?Q?FaBGppOa8K2MTi+r/PDh09UGXywwNMP8ogxhxl32TXVEG++MF0o3m7H6PVME?=
 =?us-ascii?Q?PdijVEyxYXFodYfhdEW/hOII/jJoOzsNOVSJAz6ik+na6yHaUxWGog203XEy?=
 =?us-ascii?Q?e28DI9DKDhy26J0bfD0qZU6/GcrNZ93tlTWT8Z4885KfRKiMC/yCZe5HL10y?=
 =?us-ascii?Q?rTtOXSqCdcY8mXqLzv2wk16Xh81R8mnruGewfjsTaTcgsLv0ioJGz42Bai/F?=
 =?us-ascii?Q?ulJVWXH8c8tJoYL411PceFmpJMhaLVC2wizAcBYzg9TGJVvJ4OQeFFZjoOzq?=
 =?us-ascii?Q?GAGuLm/XHF1pX5gi5hQUiZsJQpBiWzaoEeB1VHO7FDwMTK8mPVumWe24jqKd?=
 =?us-ascii?Q?Sd7NS9hUAMJcaZ0wUELjQLBXyD6/Ch4u+7Rls1N3wHZQ0Z+MAzgpIh1r8Wd5?=
 =?us-ascii?Q?y9ie7gzPZJWvxx18Nq2w89sMydqYPtA7/r0FzTlj4bb7FX7h/uu9jAk9TzIX?=
 =?us-ascii?Q?lDbHlVEyMzxjux7q5pGA7kbThOiDNoCABhVUZqaocXjRFU8HrloxZps1dnII?=
 =?us-ascii?Q?T3X0fGW6FLsmaWHl9fZlSLTKm3Z/8k5kjG2ZHXUyfnEPVS9MWbvZTG0xMvP2?=
 =?us-ascii?Q?sqM1BcA/j7M4dDv2VsXdQJ34iLrEBKmKrigBCBDeNq1vI/Jqo8BFbTE4+yr5?=
 =?us-ascii?Q?/RCnwiGGEK1S/PoF5aHIL4VD3yDBKNqmvxSRP0oCt5dPJT986mIsAAatGB1s?=
 =?us-ascii?Q?7gOValBmKb0kzorhrhPL5Po6bzqEYGQzzfDTXGtzSXvu8t46nRA70F08k/cr?=
 =?us-ascii?Q?2OjdYy+O/z/Ki0Q1F9407D7wJCBi+yab4Lu1tAdCk/6r8dw5GuR9z485I5Bf?=
 =?us-ascii?Q?G6h58XSsAw0a8DaUG9xahM8KvIwkK+nNstWW97i6oBpI2VCsOg3b0jaDH9i5?=
 =?us-ascii?Q?PYaEwR/Qd3QD5YQcJl3rs25Afbsftd15rodajpLqi8wPP0ZRd8uWUPkn3YBz?=
 =?us-ascii?Q?XcgFEp+3Fq2OoaUGnE+DD+gLeHvJ6eNb0F3YN96decXVA/HdYj1IBSIGGdA/?=
 =?us-ascii?Q?2qYw5PbtRLF8GjjL8ANv9veRTOMxlBX3oLzpm8p1ewEcyz/hUVJL438+DDbV?=
 =?us-ascii?Q?j/kJzP9dnFk+diBhTJVFuIjq98NOIhdbK8l/fTiMRWF+KysimiEx3KRiUpkC?=
 =?us-ascii?Q?AYO0DOB7ZCubIZoKRnq8zH1xh9li35GbqBhKse6ADc3F/RvZtQZ2OKDjmzjF?=
 =?us-ascii?Q?OUyT9Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ec3e6f-c8ec-40a0-583b-08dde957ff6f
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 13:03:51.7255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3td96wgpfq1j7X4QcXgiY21/xaB8PYP2gXKcGXJ0MDAMFFaxkocszc65OzXIMufS9r27ddonFz97z3UlxXUZlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9552

On Mon, Sep 01, 2025 at 10:09:10AM +0100, James Clark wrote:
> On 29/08/2025 3:26 pm, Vladimir Oltean wrote:
> > Hi James,
> > 
> > On Fri, Aug 29, 2025 at 12:46:45PM +0100, James Clark wrote:
> > > This will allow the build to succeed with !CONFIG_DMA_ENGINE, either due
> > > to a randconfig build test or when the target only uses one of the
> > > non-DMA transfer modes which this driver supports.
> > > 
> > > Signed-off-by: James Clark <james.clark@linaro.org>
> > > ---
> > 
> > Sorry for not paying attention to this previously. I didn't pick up from
> > previous conversations what problem this is addressing. I built an arm64
> > kernel with CONFIG_DMA_ENGINE disabled (by unsetting CONFIG_DMADEVICES)
> > and it got built successfully. The .config is attached.
> 
> Did you test with or without these patches applied? It's only needed to make
> the commit "spi: spi-fsl-dspi: Use non-coherent memory for DMA" build
> because that's a newer function that isn't stubbed out like the old ones.

Without the patches applied. Nowhere in the commit message is it written
that this change is preparatory for upcoming work.

> I originally tried to fix it in the DMA code so it got spun out into a new
> thread, which is probably why you missed it. And the commit message is
> missing the reported-by and closes tags which I'll add.

I see now.

> > Please post the specific build error if you haven't done so already, and
> > give a reasonable hint at the technical motivation in the commit message.
> 
> The reason we saw the issue was a randconfig build. But it's possible that
> someone is building the driver without DMA as well, hence: "or when the
> target only uses one of the non-DMA transfer modes which this driver
> supports".
> 
> The new commit message can be:
> 
>   spi: spi-fsl-dspi: Stub out DMA functions
> 
>   In a later commit we'll use dma_alloc_noncoherent() which isn't
>   stubbed out for builds without CONFIG_DMA_ENGINE and results in the
>   following build error:
> 
>     spi-fsl-dspi.c:(.text+0x644): undefined reference to
>        `dma_free_pages'
>     m68k-linux-ld: spi-fsl-dspi.c:(.text+0x67a): undefined reference to
>        `dma_free_pages'
> 
>   To continue to support devices that only need XSPI mode and so that
>   randconfig builds work, stub out DMA functionality in the DSPI driver.
> 
>   Reported-by: kernel test robot <lkp@intel.com>
>   Closes: https://lore.kernel.org/oe-kbuild-all/202506160036.t9VDxF6p-lkp@intel.com/
>   Signed-off-by: James Clark <james.clark@linaro.org>

There's no reason to mention the kernel test robot when addressing a
report that wasn't on merged code. Also, Closes: is for bug fixes, which
further confuses things because you are preemptively avoiding the bug
before it exists in merged code (as one should). Just provide a
two-sentence summary of why API-level stubbing wasn't preferred, and
a Link: to relevant discussions on the topic.

