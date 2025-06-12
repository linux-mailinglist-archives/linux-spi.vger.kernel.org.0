Return-Path: <linux-spi+bounces-8476-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0443DAD73AC
	for <lists+linux-spi@lfdr.de>; Thu, 12 Jun 2025 16:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD317176DB7
	for <lists+linux-spi@lfdr.de>; Thu, 12 Jun 2025 14:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E855C31A60;
	Thu, 12 Jun 2025 14:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SDLLC2FJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012065.outbound.protection.outlook.com [52.101.71.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F9A219FC;
	Thu, 12 Jun 2025 14:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749738193; cv=fail; b=mnBDbB/5/5WxQqe3F5n1xkW56FphIBAXEj833z1ukF2QAWrwedRvxiK7lPcAphO1Yuo2BqUTrx7ga/B+h6A/XIh6i6JxdSbWlE+QKTyOj084JgaVJNb0lIQ+4QnWQ8wV3qqRnCao8oHQ8CeNCndAFvGq0dImLUodWPfyJm+RSIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749738193; c=relaxed/simple;
	bh=EIexqerODwFutexwyUbAJ63l/FpK88HYVcirsfvr9VY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZI//pq+hAuh9C3GmenVb71gpZCBayk97eZs2A211rxHPqpWv73ksbdCGTpENFlwKzmzoKuYtPIxrCSXOwpYeMnW1W1PV83YDLcDAZEIuk4dhLQtdpgtCzrLDIs4SUB31M3L7Z+P77bQ5iBnSRJKLQUlyW7isWwePPyp6bOogbHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SDLLC2FJ; arc=fail smtp.client-ip=52.101.71.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m58Txpy0/Rqn6nW81o3JZRsfX2wmcTtf2DslJ6ipfSRl2d/3uqj+iBBgxlwIHTFRVxpHPviVADy5lwWeQG1lI1qnqGAF08p6sZxieGgObBbyWtpek+RqP1+36s8ZkMdMvq9KnpI1Nu9J9E3ILnoxjNind4y9bI7trcO2IzoRpdxaVTmPfHwvm3EkW6o9WL12l7K1jYd2grjc+UW/Vuh9eygUV8enlV45cLn8CQFboGQ1wwH1O+Po7YUb9QHIsTPjtNYRlC2y5IP+A0fkuqw9OK2PuZRuI7+2yX2SWaj5uyu2ry1m/KFUIBNuBYYHWeZor5mJGJUAVHlat8GxvrqV8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFToZSy0hkK88iCHuYRCnUDpD445h2a7zvWyHm2KbRk=;
 b=hIakz8wF01z7efi4zFN2i/+N4QtWHi036lBeK9c5EYjFCYpNUE4jeZSJe49dPWq64TZgzu3LKtqGNX+KcwmYNf8g6TpjLdgZjtKg4Fn87GeXf28xsplWL/mZZjCSKqnNyb4GtDOqJLhe40TyfXCmwPKQCMYMvYxeeNEOVESrYIk7yWSj2j6n7n3jLP3e5ygVrHGoUJ2/0hDE8Y8/nX5iT/Na8IoH5TV5YTJDSbf/QsYnixlaK2N5kWk6daNo/Lbd8TxrA0O9G04jfuHpTcmWg7y/TJY20uPhppMo/GRzxKjnuuK0GLwbHhl80NguxbX4K6wtdqgrnIb+NLniKAQnVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFToZSy0hkK88iCHuYRCnUDpD445h2a7zvWyHm2KbRk=;
 b=SDLLC2FJ00xbXRX9CtvY1ni/7BmDrpzzGzyrR4q4sq2aqhdHxcbA7V1n/jBFg7AxMsSJ2uyNgBgmrH1k4i0PvngVSFkljHMqJ+UuPybL9f5NHgHf3VQqsJ03Cj1l3ut9crKMmIHJHmkyclLy2D6C/nE6DCFnI4PBgJHrvMprO1kiv2PQlS/VoTlxcCkI2MciobJSaCrMb/sxmG4IPUvCfsOAptqahw9GdEtB9JEO83e3Ng1tAktXStrWLHsKHFFWN+HCQqsPwwJv6mFk+joiuhHf+d/zM23rO3p9BrxqpJHx0y9mW/6+ziSeh3NOhLM+t0M5FhIE+F00TiqHgOay8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Thu, 12 Jun
 2025 14:23:09 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 14:23:09 +0000
Date: Thu, 12 Jun 2025 17:23:06 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: James Clark <james.clark@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Frank Li <Frank.li@nxp.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] spi: spi-fsl-dspi: Use non-coherent memory for DMA
Message-ID: <20250612142306.3c3dl46z326xvcud@skbuf>
References: <20250609-james-nxp-spi-dma-v1-0-2b831e714be2@linaro.org>
 <20250609-james-nxp-spi-dma-v1-2-2b831e714be2@linaro.org>
 <aEhMBsqlx9I4XqJS@lizhi-Precision-Tower-5810>
 <de7142ac-f1a3-412f-9f00-502222b20165@app.fastmail.com>
 <aEhVsrEk0qv+38r3@lizhi-Precision-Tower-5810>
 <20250611090107.t35zatn47vetnvse@skbuf>
 <c65c752a-5b60-4f30-8d51-9a903ddd55a6@linaro.org>
 <20250612111514.rfb3gpmlilznrfxs@skbuf>
 <ad7e9aa7-74a3-449d-8ed9-cb270fd5c718@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad7e9aa7-74a3-449d-8ed9-cb270fd5c718@linaro.org>
X-ClientProxiedBy: VI1PR07CA0229.eurprd07.prod.outlook.com
 (2603:10a6:802:58::32) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PAXPR04MB8253:EE_
X-MS-Office365-Filtering-Correlation-Id: dcf3b83b-bae6-4eb4-8484-08dda9bca7a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7bP9B1xfh8pnRDjj5+nAYXv1EbDMEol7nWTQF1a9bt2iVVXsKqw+bJLROW77?=
 =?us-ascii?Q?Qs8qiH/ieapv3MzHDj1MS28KD0VrWkMJhTMpjmIF+XiXDRsq2hVTLG1ghD6e?=
 =?us-ascii?Q?4kWBWppNQ+/ShrAqsbVVy5nIH2ot3bU+11RqYPb9hCUki3z522WAcfHukqVa?=
 =?us-ascii?Q?KgZ3QrfGB4577BhD27pbNoquv0sJ8d6jPqT1ULSkPoMPagYzmAsHpOp6oyMK?=
 =?us-ascii?Q?hZyFpdQQCHLfs1SrFAL4g24tJlsw2gKsVL1N4TQr34m1HaMH/4T4DcXQMhAj?=
 =?us-ascii?Q?inukjYLhaCPzZMsP848bzrzUw2hHLXRkoQkO8YhNObN4am8Pp+oF/xrFYAyT?=
 =?us-ascii?Q?NL4G0JjeYan6I8+NTMwbXThW37KWZDq5JP7iJF4byS8IymI2S11bt6rkPZQ5?=
 =?us-ascii?Q?AjTWaeZqMvFBuv5YvZq5hwXj84WaAeCenVykmgVU4wREQTZlVLwnPfEwvce7?=
 =?us-ascii?Q?jzFBKleuRBWFuqZlgXlciQaltp37muPXLFRMtx4HF0A98+mgij1ojAJfK1fr?=
 =?us-ascii?Q?zmIT0llEXG8hexdIT1b8lkvA23uEYJA0U32Py3J9phgPOZJbk0uFBmIJJPPk?=
 =?us-ascii?Q?bHAUfEq29yjrGpPzvdLoRqvvN01sihn3NEp9NYc6ytP5CQt4qePcbrXCfr9s?=
 =?us-ascii?Q?/Gmz2mIBf9C+su6YlZRGKn7lsMPg2UCgseUpoudSkGqiJoTs0ymKMLwyWa/F?=
 =?us-ascii?Q?taQ4ztaQ1hbE93xJZZkGkxE5yCbEjjq6WU/RR/JuBEEnPzhqxLfdVS/7igp8?=
 =?us-ascii?Q?fIpIDOeUhDLNWQ87pUmGl/ZWc9ANBS4vY3fEeG3fEM+qhyxYpcgU4lZAdZ7i?=
 =?us-ascii?Q?4UTzu77p0Z0Kj0wNoUwx/fN/M7Mwr79ePtkYE4HHM2TtsWap0u9/gausak9Q?=
 =?us-ascii?Q?H8Vw8I4vplGASlZjbiQ7zQ/bIXhc4OFj7eHMet8nt6wCnfpUOQCz6RB5Ic8M?=
 =?us-ascii?Q?PPZKW9bw4KuL1EwD9bzQbFoZvTa+K6GhPB2kEHbZ0rp57Nk6lWnbpv6rs2lH?=
 =?us-ascii?Q?kdFy5nlMo4CmD7xXxWmwZwBxvgwUsicTEuhb6wvtWEjAqPZB3xypYhHPEHFW?=
 =?us-ascii?Q?WkS8svHAXnH+NqPCRZv9hIipGYRfSxvOoACkEMCqpmUp8+pGi84csHPAbqxi?=
 =?us-ascii?Q?UkTpdXyvbMKqolHvRVGS1WPqFgoDBH6572FAG4inqiPnpu7UiH5dc4Ru1k2l?=
 =?us-ascii?Q?JF84RM26Gn/DqgtYhDewIEbSLM5E3XN6clo3HOe/A01r2WzC9QNR3DLmDTXx?=
 =?us-ascii?Q?DsDsXP7mhaHbZbh6o7AfMblFfcVaOXjgp04Hlp9RfaIP1Ol5dNeQgbBfNkXL?=
 =?us-ascii?Q?X6116k0/yVIG/ruQ2G2uIDZGSciy/jPCzYtwDsc3KZK9AMgHne6aQicyFwvu?=
 =?us-ascii?Q?G4wyWhsCj2JQxbhu7OCBWihoRfe/Pa9kPtuDyOQ813PxHQOOvw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VVupAfBGtJs7DRotyiWLz9r1lqqz2M/KDvae2uJZj+cwLOqCPPZqbd/HeAWo?=
 =?us-ascii?Q?8K6JEuq/4mbBjt/a79rWma2I7A9CoptNTZl80qXbyrjBtX/L8uRip1z8j6my?=
 =?us-ascii?Q?exMn1QAmtxvklfXzLGHthDKY4J0I40JiAPGpOYb5nEm/Ort03cKfQV91ja/n?=
 =?us-ascii?Q?kF4NCiblpN4ayAGm/+J/kTFEqUnjDVHU7wSd3nFR8o3GLtfOV56nS5R0gzgJ?=
 =?us-ascii?Q?Ohhehu4RBaL+voWz8ZzBjkz19fC0Fmhqq0DZKFj9X2GwVv1djH8IjULPtZE5?=
 =?us-ascii?Q?iyUR+Qe/QwQvQJQluTRCpSWWJ5Y4fifzTbB65svkYJeY2/tfu1F3VyXCV2vV?=
 =?us-ascii?Q?MTJhTvjwVGVmngKT/Hi8dtqjcBTE91iZ1NpYUHRzZ+O9VJRqijOo6xCvtafd?=
 =?us-ascii?Q?zZz8g+qGU0UeKkZkn6ZCbzfTVDQNNxp6P4NuxGiy9F+VhSU1MD9cxy++t9h8?=
 =?us-ascii?Q?+9t/E6u1iD6nytWdHc3zAbitUsGqzvP4ZVG90M2J5qC2OFLngOXHxGZov0cf?=
 =?us-ascii?Q?qi5fSx/ay630PedoOS+t65mIdfxqz7VMp8HurloP9y/u/0KtzKoZvC3dIA4P?=
 =?us-ascii?Q?MimWAkAqdR2HAXIl95r7UCSKd6pFkvVgFk9cGxB1pyY5m6SXQFN9UC4MVe7Q?=
 =?us-ascii?Q?7rygmqXQFn2YkNvo1wOszigq9fhfHPuUxEkWXbAkK+doOWoO6NaCWJZfr9o3?=
 =?us-ascii?Q?aSrLwijPeg6kBXPT4QjgPg5eZvd+o7wmQQnkk+BHqTEnFqpOLaQgphXY8Kr5?=
 =?us-ascii?Q?njwejw/h3meoLOTRVCDK2+reARGBZfOypbmMDjX1a8QeIUouh2pCHMUDCR/q?=
 =?us-ascii?Q?wMs0tsl0g6D67+Zh603BvkBgVkmpjGUSNq5pHjDMi7quFT0b4ZvuHMQcz/cp?=
 =?us-ascii?Q?9/zFYcK1PoPjPZ5XaywEf9X9RJ7IXSI5AC369fwfXXHVpqcKua/PmZxPOIbN?=
 =?us-ascii?Q?wyZa0/tLVIrjivlsnlmDnqFS7v6vX8BY7QvFjaAxCUQWEWqBL9DfISi8p8Oz?=
 =?us-ascii?Q?YjqDo3Q+/eGkhGk5q6M6gyIMX7Ga3/L8lK7+KLwj3GoJJ8bHdmVcmQDU5SCt?=
 =?us-ascii?Q?nbRQIbVvoFMetBG7U0LFvygPkju/EfircvChA8EjFTEQjJA9RfPQznbcV+g7?=
 =?us-ascii?Q?FUXrYLFvxEeDQ4CKGmmRoPeGkuvjxBp13XA6mTzBfRD2JHPsGiNbndo+5QFB?=
 =?us-ascii?Q?hCpgzr1qiLNMJtidsy/k22zQvBbYUFW+jHPRDJaN7bwjie7HUkbOmfTHm383?=
 =?us-ascii?Q?Li7gvkZI6rWL843ULM73JVYC3nRxn7Gf1PIn2W3VVhK2Po5pkz5/nz/JowuA?=
 =?us-ascii?Q?0I72cmdnNGFjl8F1I7Fu5oajberBiB744O+Qk/HUS8k/BR1n3DnYyQqNxhZ/?=
 =?us-ascii?Q?S6JUKqq1RgbIGaywy5WVkock6/fYXXIZgUypIo2J5O8A0SgNCnjHVubkC7IX?=
 =?us-ascii?Q?2+ud7hunxV+6Ywm8+hIR42+66INRI5zj31l1wRm4oKGMr/ypFl6sgkViLgsF?=
 =?us-ascii?Q?JL1S1OFukyLAkxDtj4m7BZr+ky8aH6AvSKpOSgg5WXN+GS4pCZjEB3PhCzS7?=
 =?us-ascii?Q?DZ3W6KJgrxAKdCai9jGgyQQ/csWZH73jQOVrcYoe3vI/p2UZ6pdLqHpuW4F5?=
 =?us-ascii?Q?2g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf3b83b-bae6-4eb4-8484-08dda9bca7a1
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 14:23:08.9911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OoDBtS1B7RPI2/Ig8NYz2Srv7GycEid8ffmTz9U5ymjhK3tPFYgoXgtYgFd9Q2jr5+EmB2fVq4OJpFOpoy7QIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8253

On Thu, Jun 12, 2025 at 03:14:32PM +0100, James Clark wrote:
> > That's why I don't like the DMA mode in DSPI, it's still CPU-bound,
> > because the DMA buffers are very small (you can only provide one TX FIFO
> > worth of data per DMA transfer, rather than the whole buffer).
> 
> Is that right? The FIFO size isn't used in any of the DMA codepaths, it
> looks like the whole DMA buffer is filled before initiating the transfer.
> And we increase the buffer to 4k in this patchset to fully use the existing
> allocation.

Uhm, yeah, no?

dspi_dma_xfer():

	while (dspi->len) {
		dspi->words_in_flight = dspi->len / dspi->oper_word_size;
		if (dspi->words_in_flight > dspi->devtype_data->fifo_size)
			dspi->words_in_flight = dspi->devtype_data->fifo_size;
		dspi_next_xfer_dma_submit();
	}

