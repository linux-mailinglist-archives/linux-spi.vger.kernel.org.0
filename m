Return-Path: <linux-spi+bounces-10801-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B71C03DE6
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 01:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9DFBB4E25DA
	for <lists+linux-spi@lfdr.de>; Thu, 23 Oct 2025 23:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D452797AC;
	Thu, 23 Oct 2025 23:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UGjOX9LY"
X-Original-To: linux-spi@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013040.outbound.protection.outlook.com [40.107.159.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B77F9463;
	Thu, 23 Oct 2025 23:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761262742; cv=fail; b=F7YYQHOoZUiTo7jkIycGobUs1/h2HLrEm7wok/SoKum8a7M3LsmDxgC3N7e69Eqdun1Q3n/FkXOa1Rd2AUO3kWxo8foChjEMGv6fVXS+knFKwjn5JETzc9vzoHsB3TUne78YNCafrD9PNEPugfFo5wvSf5fJuiavhPijuDVEv34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761262742; c=relaxed/simple;
	bh=Rll5Pz8dv6NmN7tZ8SvQg8AL4W54Fd5SqN7SPGLZNOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a5iUVLuowgxZBH6gx93oYtypLqqvPt6ZVr+7H6Op7/oBNrpz8ppYMxQ3jMP//GiVGbwlA6VnSpEbypnzJJkz5dFm4ktnlFxvxvITSvk2MtYMqKwKggGC1D3zaZWYA4B9leVdcBtVgWnSbkf0bV+QOpsjfopDC1YRP8/COJvr6B0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UGjOX9LY; arc=fail smtp.client-ip=40.107.159.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0Bgp7xg2B9hg7k6a+5pwdDruconlH7fy70xE9fixk5Dt1dQc1WOiV536JQ2fith44bZ/2nTRUcp8RtrmYpiK8OOHYYOfuuAUVSrLDVvmn7biK9NCc59+Z2DTCOLXH2jt6X9SyzIA/G2mtf3oYc7uG4qA/Ti++I8ezv2eyBh7YBFVM+hBIN7qTxW8j2So+PzVY/qe+DX++dfEgu7SP9wdJfleTsNJlQQmmjUVk3aMxMiRh+YMhDszVvJHyFD7Y6+JvrwMCXx/K8OUmKPpOKrejEpsv5muomZ3NiHvfpr/N3da5o3XxtYNmgWfBPAz0T1gCQx/QkcJSP/amne7AYc9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXlklouxbKGHPyc7yDSnqFEM3YXgm1WEIqloLSWIONI=;
 b=pjuwvXBbSwy2BKiJwOEM078ULpXRAAm3+KsqQzDhwuFS56lpqIyyVph8dz7uFVY+QCqT3G1j65Kof7ojuki8JEv+/KvrEIfEFoo7sMbjhyw5ipuTe5j1C2E4gffzmLXNAWR3HDtayVtVDmI9GNSywDwnUFnh45WlMBd+0h8Spk4QCXNmXKrmdCJlW8Hbp1c1j3mMXh4bIhZyBYF/hSP5sbaPS526bzsE7kXeBRDGrWbrPU1o+4pNGkyAuVjfxrWkWpLNRIkKWx0ge6FnlL8MAgy7hprSWP2m6oF7lVd0fwWzDj3Wj8AtuP/9Vglj40moS03fydwQr0j7stdL89UPjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXlklouxbKGHPyc7yDSnqFEM3YXgm1WEIqloLSWIONI=;
 b=UGjOX9LYBYAo8yQ7KYzsLxpQUQMVsGV7sFFy5z3LmIzpXxyiuMhhUORAlRKAtjxyy2JsAB+0GRJGdO8ghmXYBKSKvkJQRH0q4rQW7prWbJZCo3ARYCZ5EltbWH88vcQKmwBtz9oE8za5TUwJtb3M00j+QO8Iu4eGNjMG21zjLsOqo9osh42TOJYzBD8whyZX1EHAgQblOB2SFPH6m6hfJlXMZwUdvA5CadEIJczlL7d1X6Hwigz13AJg+41PmmT3tQvehbxVfrR0RcziI9hOBW5VbLZS+CwyaPKC88WSdgOAuerKcyxhjDbwOoTS+ecnZTpqYNPJE6jUclzuyDz8Eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM9PR04MB8413.eurprd04.prod.outlook.com (2603:10a6:20b:3ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 23:38:57 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 23:38:57 +0000
Date: Thu, 23 Oct 2025 19:38:49 -0400
From: Frank Li <Frank.li@nxp.com>
To: Alex Elder <elder@riscstar.com>
Cc: han.xu@nxp.com, broonie@kernel.org, dlan@gentoo.org,
	guodong@riscstar.com, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/9] spi: fsl-qspi: allot 1KB per chip
Message-ID: <aPq8ibj2KzQhtYQT@lizhi-Precision-Tower-5810>
References: <20251023175922.528868-1-elder@riscstar.com>
 <20251023175922.528868-7-elder@riscstar.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023175922.528868-7-elder@riscstar.com>
X-ClientProxiedBy: BYAPR07CA0075.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::16) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM9PR04MB8413:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e247ad1-e5d8-4107-34b2-08de128d55ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|52116014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q/XzM+FoUW/pF0L398R7FWmqLoTR4rdJ1flLdNE5gLrywCEwIHY+tIAcaKnm?=
 =?us-ascii?Q?55ixt4m4wRJxVGUVUEs7uhTk9QvMFRtkQlD7EtBYicrQuVtHRVBNgVyO4OiS?=
 =?us-ascii?Q?uo8hF+A/0d1BX8HhhABncyWHwt+Mmimyf9zP7Xnqs1Fcc40e2Ol5n3spnSHr?=
 =?us-ascii?Q?T10TM5PwkFyq2Av/yx988NNy1x8FUo2kZpfvP7DZFPj2xRztppPmwfaIMJo3?=
 =?us-ascii?Q?LlsCH/dYQ1fDX8td3G9PA1ruXN54hrkHlfdmRKdTXS1qH7RpLW3vJe6Z1cY/?=
 =?us-ascii?Q?sfGEGMuyCz03G5SUoGRiFjrr7HOD8wVR+3ed+cqAJrsLDddXCuOyh7jfQnyU?=
 =?us-ascii?Q?bzjo00FUXVs8lCQp8UgZDh3cYSoguV8BJbfCf/v5MO4BSo9c8v//OxCrasmx?=
 =?us-ascii?Q?1BwgUqQioFVeeSt3xCCzRN26gG5lIHXQUKAUdlXLd9cEysP+j/G/ZZCpFgi6?=
 =?us-ascii?Q?vhFPKR+PhKNX/VXY5/agAprJQprLSaYw0ow8lXf0ovzoQJmSiH3p+2uV2+AO?=
 =?us-ascii?Q?oxHLgBEJYkHM/rb0i22DojnliQmGr37tq9THD3hFT/YLQlsJCeUwIUi9zTDS?=
 =?us-ascii?Q?/UCzjH+XIzIJ2JMKYZMDXto0SKPAcYoeth1tMbX7B1vdSD+QtYGVu6OFxIV5?=
 =?us-ascii?Q?y89vJzHgTw3SdrHHbsvfCz6ZP+1jYnS9sSkzliS7UCC7jwBze9QPXRE2QkfW?=
 =?us-ascii?Q?kmy4zwK12RuOAlmiXm08qkbVpL54eCx4hmm7z1q3gmurYZLkjA6wtBuiukd9?=
 =?us-ascii?Q?oeUApNE8AnrT+CtGQYca9opAhiUbIihDuRh33IwlxrUUxHIS4OYhxrCMqNcj?=
 =?us-ascii?Q?DgrHqS/K8A2k5miF9yedvNDnUQYEPfzVvzy2tv95ooz5xe2fRGMKA12O7oua?=
 =?us-ascii?Q?ZqF/3SKARrzBjPhAXCwqVkc9rtuusUAN9iFuW5OCJ+U4s7IHEPKpDVTjUekP?=
 =?us-ascii?Q?FOkNfwKjUaMzyJ4sGvjXrl1CNXxgXxN4MhAu3TqTYGusq/WJ2YrnbElfsiEh?=
 =?us-ascii?Q?jMry4CuzVw3PijSDxdYGWADdxQ4vgmxzrTQikxp5sBDNgptl2yOS5ZGKkHq/?=
 =?us-ascii?Q?JlsLe0bfsq5L0BvwqEh4W7crs30t3HTpdzRadakHMSrzPHNv/4VvprAG1PH+?=
 =?us-ascii?Q?NZfj/NKAHKmKWzEo78QpIGzXgl+kM7rgm+UD1E5UI+PyKqRm/7Y5vJF07emY?=
 =?us-ascii?Q?k9/mZK1U/zprmSpl95IrkW6yErMmW8GFSVdnnv/znU77ezuQWd27DAaULlK4?=
 =?us-ascii?Q?/4UyfF2Ok8O9qdDqsdsHPzzzR7Q2unO/R5T6R4K38znFlxykeMrLqNMsW3zm?=
 =?us-ascii?Q?XcGQQszSeRFNB2ZqP32RFliCZTpUF7nBAEY/hVlrY7P3FFqwmznaojlav30O?=
 =?us-ascii?Q?ATkDsqjly/8DH5liyVMqbwZw4gdCGp4fsxOV+rFoEG24r+rqPUlGfknwfSeZ?=
 =?us-ascii?Q?Z0ScDt9idW0h4MzIwnqMVgmtFQ7nnL4Uh8dTT0gQtMIQ16+G5/03JXDg+WOt?=
 =?us-ascii?Q?2M3o8/WqZLEnktavmK+g+oK0pnbjsRN7R7FT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(52116014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2KTKUihBFXka/M58KPZVYAjEtVMf1u7p4//LKBtzp2UVjKq8yw6ksITAi7KS?=
 =?us-ascii?Q?toe71HQeUTO4EdUuDMT9KACxYiPpSAA4j4A4lUDA4oSvH9xb6aCkqPMoraqD?=
 =?us-ascii?Q?Zf1V/sC2HfOJ2e3NnfYnmVCHMGlBRWSdNoIlWyjgMhfrRMhUfA+yOrh5mRCA?=
 =?us-ascii?Q?mi7m2nclFR37ysxXLeflo5IyKjd38z/sQQc4BSAOfYmR3ZRe1e+g1mK6uJ1p?=
 =?us-ascii?Q?fjF8ls97bIMFR2YIp5gxAqDCfxNIX18+ntAPXfq4w5K7EzaaP8u2SyjButtR?=
 =?us-ascii?Q?Y1Tp8fZ+cR1QZN42vk5FmU1rs49Zqx00O29am4YHrIwxmATgPMHEDoLkJkS+?=
 =?us-ascii?Q?l6ZLr17yz9vluc90dq3XjwmmwwNUjbrD8gNggtGHQH7n2pVRb76pDq3B/d7B?=
 =?us-ascii?Q?70G9vULdt/y5ax91C3AZWK7kU8yIBs/EGwl9o4d6kCyvLqBqBE2P9XQiw+IG?=
 =?us-ascii?Q?DH8AlW7yGX2GgP+pqE3c59QYdqKS5cG7saEaTWdocUZW6ckeUK6cpd45Lk90?=
 =?us-ascii?Q?liXlkDEbLeHPSCUS9W2q71oY+l/R63goS3jNjttFpjxIylvUky1qdb5OGFc0?=
 =?us-ascii?Q?6ID9EoW09wYM4AEpEqbf9tODda9UEX7+MHuYxGspHxzorvXTgUi5w7Zcy4fK?=
 =?us-ascii?Q?4IiTyFR+F1cin37FDd5DvgVSqfP8CBKMUJm5UQRYROndheTPWcM8dkM7Gwxn?=
 =?us-ascii?Q?scaAjuuJWQoVL74T/Qgncl/xJJ/qykThKpGZOk/dAkLt268pTCaG5K7ZkTKG?=
 =?us-ascii?Q?NXbrBQc0RJOyuwysNr6H63amulo/4lPnWtRxCZ468pCcYx/SvGMeHNTkYTT6?=
 =?us-ascii?Q?KblsZqWNektw5nVSHdKDH7SEDLxtZ3hGRRJiWb2FyIVpxoq3Q+1FnqRQVeTY?=
 =?us-ascii?Q?5l/6HX/WxEw4aHlX0n7d+kKBVJTdwLAEKDuseNI1nlrF3pwbOGtDCOC3s9+z?=
 =?us-ascii?Q?Emd3mNLNVbA7EYZp08KSidGwrzzPA3oa3Gkq5D0ofhd260d3dL+vl1eXJA1K?=
 =?us-ascii?Q?7w1Tw4Q0UwjEV2BEFoZW0ghzQ6Yq7eOdn9+jwHyvXW46sCMTdQ3uwk/m4itr?=
 =?us-ascii?Q?UkLlau+QJdOnGW7V2V/IwqYktGnaQyWbd08wpznfoxxVnJe5afUyLzGQdYqN?=
 =?us-ascii?Q?JRInswxDkiyEuGr/U6tjAxrX0MroNjB4mQPdqNs0mlKayGsgreaHRaP3D6nc?=
 =?us-ascii?Q?IDSKPaP66UWoGyX18q8Z9sVwrN2qlCeM6i3o02m9KoNkek0GgVjtwUHtS9T+?=
 =?us-ascii?Q?zpi2uU3x8HTt1VBptyn8lyKiKi/SoEECxOsikdoL0MdzEElAxd7zrFINFBxR?=
 =?us-ascii?Q?hX8z5ZLasEPSic7Hr8lBjUCWioybHQpD24RFGF7YyE7Ni1tsLbopHjSWbkqf?=
 =?us-ascii?Q?ImdqQQqaOwPvnbwHFyXWX9g/lsTgFeAFGu91200V5R9BeUUt94gQp5ksBJdi?=
 =?us-ascii?Q?RnJtmHyC7GxBOs7CjeRDewr72RYPfcjmL2cxhLpkLQ6UfdHVdF8LSZ9zsXIv?=
 =?us-ascii?Q?qV88C+Tr3O4Xl1EGTH6iIW6HFsiCY6AeFITWZbVWkO9fyXIL1Ua9pad1Rwzn?=
 =?us-ascii?Q?W9K6kaA4TytjE3AhGyQTuQI8uADXniOSq6tuUsWR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e247ad1-e5d8-4107-34b2-08de128d55ce
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 23:38:57.3955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: acYkNmcqb+0UlZW9WXA8sIm0diDHm/dTXOLGwqkbYiodPXsTIa4PXV5ZllpB+Zl305ncvghY8pKDrQrnHYJx9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8413

On Thu, Oct 23, 2025 at 12:59:18PM -0500, Alex Elder wrote:
> In fsl_qspi_default_setup(), four registers define the size of blocks of
> data to written to each of four chips that comprise SPI NOR flash storage.
> They are currently defined to be the same as the AHB buffer size (which is
> always 1KB).
>
> The SpacemiT QSPI has an AHB buffer size of 512 bytes, but requires these
> four sizes to be multiples of 1024 bytes.
>
> Define a new field sfa_size in the fsl_qspi_devtype_data structure that, if
> non-zero, will be used instead of the AHB buffer size to define the size of
> these chip regions.
>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
> v2: - New field fsl_qspi_devtype_data->sfa_size now defines the size of
>        the serial flash regions if it's non-zero
>
>  drivers/spi/spi-fsl-qspi.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
> index c21e3804cb032..a474d1b341b6a 100644
> --- a/drivers/spi/spi-fsl-qspi.c
> +++ b/drivers/spi/spi-fsl-qspi.c
> @@ -207,6 +207,7 @@ struct fsl_qspi_devtype_data {
>  	unsigned int txfifo;
>  	int invalid_mstrid;
>  	unsigned int ahb_buf_size;
> +	unsigned int sfa_size;
>  	unsigned int quirks;
>  	bool little_endian;
>  };
> @@ -737,6 +738,7 @@ static int fsl_qspi_default_setup(struct fsl_qspi *q)
>  {
>  	void __iomem *base = q->iobase;
>  	u32 reg, addr_offset = 0;
> +	u32 size;

I think use 'sfa_size' is better to read code.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  	int ret;
>
>  	/* disable and unprepare clock to avoid glitch pass to controller */
> @@ -795,17 +797,17 @@ static int fsl_qspi_default_setup(struct fsl_qspi *q)
>  	 * In HW there can be a maximum of four chips on two buses with
>  	 * two chip selects on each bus. We use four chip selects in SW
>  	 * to differentiate between the four chips.
> -	 * We use ahb_buf_size for each chip and set SFA1AD, SFA2AD, SFB1AD,
> -	 * SFB2AD accordingly.
> +	 *
> +	 * By default we write the AHB buffer size to each chip, but
> +	 * a different size can be specified with devtype_data->sfa_size.
> +	 * The SFA1AD, SFA2AD, SFB1AD, and SFB2AD registers define the
> +	 * top (end) of these four regions.
>  	 */
> -	qspi_writel(q, q->devtype_data->ahb_buf_size + addr_offset,
> -		    base + QUADSPI_SFA1AD);
> -	qspi_writel(q, q->devtype_data->ahb_buf_size * 2 + addr_offset,
> -		    base + QUADSPI_SFA2AD);
> -	qspi_writel(q, q->devtype_data->ahb_buf_size * 3 + addr_offset,
> -		    base + QUADSPI_SFB1AD);
> -	qspi_writel(q, q->devtype_data->ahb_buf_size * 4 + addr_offset,
> -		    base + QUADSPI_SFB2AD);
> +	size = q->devtype_data->sfa_size ? : q->devtype_data->ahb_buf_size;
> +	qspi_writel(q, addr_offset + 1 * size, base + QUADSPI_SFA1AD);
> +	qspi_writel(q, addr_offset + 2 * size, base + QUADSPI_SFA2AD);
> +	qspi_writel(q, addr_offset + 3 * size, base + QUADSPI_SFB1AD);
> +	qspi_writel(q, addr_offset + 4 * size, base + QUADSPI_SFB2AD);
>
>  	q->selected = -1;
>
> --
> 2.43.0
>

