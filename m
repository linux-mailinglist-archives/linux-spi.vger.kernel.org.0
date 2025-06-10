Return-Path: <linux-spi+bounces-8434-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E25AAD4452
	for <lists+linux-spi@lfdr.de>; Tue, 10 Jun 2025 23:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 806011635F4
	for <lists+linux-spi@lfdr.de>; Tue, 10 Jun 2025 21:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A955718FC92;
	Tue, 10 Jun 2025 21:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="R6W7IW2T"
X-Original-To: linux-spi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012061.outbound.protection.outlook.com [52.101.66.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568001401C;
	Tue, 10 Jun 2025 21:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749589315; cv=fail; b=HQZXmB1I+7XhgVxa6qfbZseJioy8EX+nscWtuk/eYVK43ysGx3OlzwW5b4jEZICYIYVS33idGHJ5NXDT1vLlgh3WUFneRYlFZTvnapZoqzdnoxywzMPQI+ZbWsWp5o2AXEbvqdmBM0w84jN9NPk47oYI2oGodkRDVxD4FfnxBlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749589315; c=relaxed/simple;
	bh=1w9BzeT5tg8fwiRjsojENG26RrJJE69HsLtQBzAE9QU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PLU1QU0W2TSj+fZHyJRiRfxSgs2BcxiBJkRgEF6UzLKbKYuBsytpsaqrGoxegTKyP9K2rWSlQcLClcCiz6SbMKpl+ky1yGdsiQZzbliev2x/XVF+8DUsMMU1BjkGD1s/4XGdas5Jav4I8tPiTw9cMQTSUMjFmOIjjzKjgNCmeHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=R6W7IW2T; arc=fail smtp.client-ip=52.101.66.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n82rRAItndC/tFjCAgSXY+fy5BoVP88elEt91eQthMFcZjQgX4U8jlxs7XJY6ZuurBeEMVFCDdMG02CIJMoFu/tfypnjQwKRMdMRoOHTzTBmotROdMP7AtFf5txRGOfmoLT7/T2cgzI5+BGUQXo3BSy/as+tZMVW206d71uX0swdkocheJMUHDxZGFPPF4cQUzzcioE6t6KXDihI0GlLn75x6XHgrVDeOxrE2lAsO33xEDhbpcQEg2uicv20hhIGYZ8A3A/4C0BOP8UyV3xeSNJAQ4Wu6HBzB8GmMnlrRgBSowkRcl1H0xp1Tg3a3HCGhY4Y15uOWu2NhXEfy4qjZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFmnlCuF3lzqgKUUZdDweFCR8/2bG3TiUs2GtpEO95M=;
 b=q4OP+xRPkhSywAXzisQazzOe7TUAvdJ5K0cP9YyRoc133b2mu+NNTe+UpEVkLmFEqZTnhX7NA/X5rSURc8QUF89xY/MrqUc80hKwLPyB0lk8Y6n7CfmVR44UQWmEXZG+NvH4gzscwa9v4lMp63UkL/OM70M2IZLAxnCdiaCUR/IVqKIkjb2ccfWUTtZGjIC/FndKE15TOA3+KuMQa0X3MiRKwRErgjyxp3kX3WjA5YksiHrPvo3DVbCm8al0FPgMgJ+82Jij1ZOtEQLG4jL169y3XTqtWqfNLbrAG9KQyG6TB98cpO8G8F5rfo7Oo1MshQGrSsHh4uSiprkIfAPx1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFmnlCuF3lzqgKUUZdDweFCR8/2bG3TiUs2GtpEO95M=;
 b=R6W7IW2Ttfjx1/+gw8BQq7IdRstIZSgf/xIzUd3geUYPxzK/kYtwKqJkO5jo9G2GozdLGhGM9pHj4unVKAZtGUXE/U+CEjSIHzyO2nRoKQofelM/mG65zGyh7Jwm2zn3aCS8vDgR3koDn7AFQpkQKTzg0f5vSJdsp9SZrVl7WHhswatd7SC54hFFZTBtolaLOSw8lQ75uXImSqVvSHZqTmoYvbjp0ZUl+hOrGoZfcZgnUryfHePlJ1ywNZoL44L3WlXCUHkkV5TTVQS1PUyJd6U4DPCtrqV53K1scYaQANx0N/CknXuoTw5GtXK5T9UL0tWetzTtMiwu9Re+Vlmgcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU4PR04MB11054.eurprd04.prod.outlook.com (2603:10a6:10:581::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Tue, 10 Jun
 2025 21:01:51 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 21:01:50 +0000
Date: Wed, 11 Jun 2025 00:01:47 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: James Clark <james.clark@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] spi: spi-fsl-dspi: Clear completion counter before
 initiating transfer
Message-ID: <20250610210147.kwuwwjtcl36hrxjc@skbuf>
References: <20250609-james-nxp-spi-dma-v1-0-2b831e714be2@linaro.org>
 <20250609-james-nxp-spi-dma-v1-1-2b831e714be2@linaro.org>
 <20250610113423.zztoyabv4qzsaawt@skbuf>
 <9852a22a-1a09-4559-9775-2ccbb44c43c0@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9852a22a-1a09-4559-9775-2ccbb44c43c0@linaro.org>
X-ClientProxiedBy: VE1PR08CA0033.eurprd08.prod.outlook.com
 (2603:10a6:803:104::46) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU4PR04MB11054:EE_
X-MS-Office365-Filtering-Correlation-Id: e4b13c6e-e7cf-4c9d-fd39-08dda8620522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SNOJNAJ1rsaenqRTeQapvQnfnoQ0k+Fc2F0znxNRZPWWp3+qwmiF49/cugYB?=
 =?us-ascii?Q?FVTH/WLMySljczYM2a66MGg9gPJBFmdoz9Ayty0HqEEaTRmB6lgeBUzlSjfT?=
 =?us-ascii?Q?2IWE2+gP7+Qb5HaNlFDVyG2bBR/vGwC0V7FjrikUSlhyd62YK7kirREnvGUt?=
 =?us-ascii?Q?3tlRsbudBK5KQOHEOgVWUE7bP7o4BMQxK6vYGh6jfZbXJknIIDuNW/F2Hb1X?=
 =?us-ascii?Q?uWeeh63agUr0pvPA/Wz2srAINRFgd1qVEGuYsHwe/fq3iXh+cjd9iUfTCtgX?=
 =?us-ascii?Q?FMF+Nj8Hrl0e7/rwTK2SSsTv7P48/9M9D1+JVXO5yDHVXvg0zzWKZalvaBpu?=
 =?us-ascii?Q?W6UK9IsrZ5rpKT9VJT254l7Vjo9Sl1mNzWLj0ZDFn1pQ86ejNgxQNf/DyEEX?=
 =?us-ascii?Q?s99lNPgR2cR/6GufN2O66Vu+3yyXmwzPAfrSWjrldB2KZeiVlxuSnNZqnAGX?=
 =?us-ascii?Q?1NjDoC9s2UoeIQCRVCc7KkC1iEmUNnJh55dURZIVCUa7cPVLt2iFg9aaX1I5?=
 =?us-ascii?Q?i3TLUU16BjHu7qFRhxVtGx8dM8AlHyZHCBVwh0zomiT0gYvFr+1lzNVDG6My?=
 =?us-ascii?Q?89iUEofwOcGeRDItms2GTX7qO11K8AfrLd6s1xPFusqVz1XUK7sGbEKOSp0c?=
 =?us-ascii?Q?T7OeGIuOOf06KHsNowhupay6KYHtQKFiE08VaI/+5mDsH1YWFkWoRxQuPO1m?=
 =?us-ascii?Q?8E66GdW/dhMoWRPM4iUg2q+6Tkuhtykq+nmTVDCX1PMKF5CAv0H0gH8p2CtM?=
 =?us-ascii?Q?AOSyveY2KEshsfGfQM4PgVJSxFJ3dfCYyBbqdoVFqqAjhOty9nBK3mGlafPu?=
 =?us-ascii?Q?/DcW2itBLnPnQeFOgT1Fl6g5nkpDNYhcTWcQA+yS87fWNBhGfBOMtxmMCu1M?=
 =?us-ascii?Q?utR/R1ECu0iBewywt//0YBaq92pC7RJeMPIA66GiZB6q/ha/iKj0CyMMG3vh?=
 =?us-ascii?Q?F4IpzH7/QDne6O76QpHyKvudEnJGRLuJ5uSCBl9qKKVtRvVqDB9b723uDvuw?=
 =?us-ascii?Q?RdihSbTmFGPA9CFc1DAXFXmFjb8tQxYpuG4SYeH9hrKpXQsaEaJe+kjMrf52?=
 =?us-ascii?Q?oprUTZ171bwuaRIiGP6Daj6+jQKEPIbVd+wFDJW2kdBRTVC8MmRps0eiWBQ3?=
 =?us-ascii?Q?T7iwmBwd6qZQkwSS3OzUtSNayeZ/iFGRUyLXbofTuQ2oGAzAIUYTBMCiRGRu?=
 =?us-ascii?Q?pWHMzAGGy+FUASLGBCg2AI+6RwNWH/GevJeeGCo8Riuw4n2iK94fCailvqcl?=
 =?us-ascii?Q?TY7JGvTAooGPWqjYnNV6kmOiy20z1BgC/Y5ZBvsnxuUDwAEwyuGx5YOHKnqT?=
 =?us-ascii?Q?Z3CVeD7tii+ji5WpPAjetXlkWpxymd4fR0Z2GV/XAU9SDHYr1MfAgEKz8h2K?=
 =?us-ascii?Q?9jUE2sHN4gfBi6I52MrKe3aOQbKU8hlsROEHVCQ51RicrQqq3pdZaUhQVaQa?=
 =?us-ascii?Q?A/TaLJ6uTBM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TTXTfmzcuCAKmUIEV6AUz4+ofWVsmupRHAl33D09fnX48d1nOiE1Z793ClVO?=
 =?us-ascii?Q?IO0sK0HLOkGZ1NcgEIXdLLlWI8SJfOkKAWkNOE5pqH4xdK352dl66OlcN4in?=
 =?us-ascii?Q?7xjz+HsXKSmdm9XgkY1B+Wfsukjfw4ycehJOpBspiYSVuTowKBrsNz8m0bKS?=
 =?us-ascii?Q?WiiaW+BO/O3Q+/kH4Su5CzDNO02CtbPCmJmOdVXcpvj2xHrfNhHTk3X/S7yb?=
 =?us-ascii?Q?xBBgjqHvyN/Nh5VvE0lTytu/Ptm4sjjGKVbDF6LuqyDuEFMT3YDxjW3wg4EQ?=
 =?us-ascii?Q?WHU19BU44OP06lwG3UvO/ioiTc8GpPpuvBmU5EXYDVR3FKLpihx42x1bp7Cz?=
 =?us-ascii?Q?Z0ogSCP+gr4a6y9kb2sBYlqirlwUkKnk53gjwLMWXqMBX8NGmGhd1VL7tiBx?=
 =?us-ascii?Q?9n5kb5IJyX/wMGf6G30ygr1squduuL2MeaXktWDvWIir/o8scz0LG+8B+BIP?=
 =?us-ascii?Q?OZnkIFXT78IA1WknQzC6K7Kqxy2AjcaUZzj/AcPUu/vzbsjhb5s2d0h9/PNg?=
 =?us-ascii?Q?whpkbdb0VXVVp82E2D/QrO6hnG4Dscic3gCri0PskCa/UKCiejvFTSD6D6HY?=
 =?us-ascii?Q?AWTbxxOF/oE6tFTtzacOIGLxoGcbRuVC3tifuKBKUmP7zdIagbUvV/9pzVlu?=
 =?us-ascii?Q?VG8ir6ChIFkew2Tqtj1nX/1nYRK8QKqFkz2aTv/172iSI6pMrvFTZNTCc566?=
 =?us-ascii?Q?7OVCKqqJRAEZo4MyV2FffGq/b70BifPwiWZruXIN8QXz/NS9blwys7h4a8nK?=
 =?us-ascii?Q?iuIX3n3wFdmyEHTge2wrK7ndXPnMVCmK/N5Rt9bZjBLGu0P2E74E94NywcIz?=
 =?us-ascii?Q?fhnGRecPt0XraAqTMZnC0wldQ6rtLrcN98enSXS03aaBy1UwMdgkVQbFnfLh?=
 =?us-ascii?Q?ayhi6gBPxuZ86exkluQlGrrWGrOlTFBmkFTo69vCQsmuInmSZxY5u2bRc29w?=
 =?us-ascii?Q?tc6Ey+fFpuup9xpdFcpVV17xc56/80YO5kF3Q4bdokAehr4prlKCWh4w0i5u?=
 =?us-ascii?Q?8YBAK09Zh8KMyDb8LH8fOiAbvuDwS/uWFL95GLE4Sh3L8yKAgQlVZU8+rSHj?=
 =?us-ascii?Q?4K01R9NA3OTjqP52v3wFV03gFsQ2Kowtj2SBF5JgLNzCR7IKuSRXBjGRPgpC?=
 =?us-ascii?Q?OJPJx/CUW5T1VREJneTM9mlIgcAyjDE8o0GkY2DuixDQIl+AlVABAbJ8paLI?=
 =?us-ascii?Q?470yC5kuSPcqflD5O3N+/ZdsDoowk4FgISzXAnoS5QbKhmm3oP4LLNqLjVhR?=
 =?us-ascii?Q?4wbXjIHPTRiYmH/LdPCfyhTMjckkYIM4mNpUJKtZVLGFkrJrRiHC8md9e6/E?=
 =?us-ascii?Q?gl+FLyDiajuU0ABi9KhmqInsl4wWcuWCVp7rq/U14pAF36n9+UBXsFqE1UPJ?=
 =?us-ascii?Q?zWyfTyyYe1pkllO3SKuQUa5OqkcuNGI8LopkQLkpOWBTD8qPJ7YYkNsTsnGv?=
 =?us-ascii?Q?yDPvzuWY/ShhmSCHM0WdDgrW/sX7YRDfrcaGla8S4caz+zfgLfWfy8sI+Sch?=
 =?us-ascii?Q?V8cPHFA/PSLdOE/2Zqf3fmGftr+yDvEVyeBImu/aUPSxxCYmcXCuDN3ZFDxS?=
 =?us-ascii?Q?nbOPFclKphqxshh9nkuj3ZORQ2GhONmT17hJz8t/hKSeeFNFr+O+2INUmJTj?=
 =?us-ascii?Q?AQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b13c6e-e7cf-4c9d-fd39-08dda8620522
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 21:01:50.6536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U5VSxT9v2DSRUFeigGV/BJ0fDNUjpvnMYbRtGocaed15A0T1gmHK/dxJ/VREBu/kDDCJfY+sstRJWsD3bdKQIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11054

On Tue, Jun 10, 2025 at 04:41:04PM +0100, James Clark wrote:
> On 10/06/2025 12:34 pm, Vladimir Oltean wrote:
> > On Mon, Jun 09, 2025 at 04:32:38PM +0100, James Clark wrote:
> > > In target mode, extra interrupts can be received between the end of a
> > > transfer and halting the module if the host continues sending more data.
> > 
> > Presumably you mean not just any extra interrupts can be received, but
> > specifically CMDTCF, since that triggers the complete(&dspi->xfer_done)
> > call. Other interrupt sources are masked in XSPI mode and should be
> > irrelevant.
> 
> Yes complete(&dspi->xfer_done) is called so CMDTCF is set. For example in
> one case of underflow I get SPI_SR = 0xca8b0450, which is these flags:
> 
>   TCF, TXRXS, TFUF, TFFF, CMDTCF, RFOF, RFDF, CMDFFF
> 
> Compared to a successful transfer I get 0xc2830330:
> 
>   TCF, TXRXS,       TFFF, CMDTCF,       RFDF, CMDFFF

Ok, so my new question would be: if CMDTCF is set, presumably it means a
command was transferred. What command was transferred, and who put data
in the FIFO for it?

Because the answer to the above is AFAIU "no one", I guess the driver
should ignore CMDTCF when TFUF (TX FIFO underflow) is set; I consider
that to be the logic bug. You are also doing that in patch 4/4, except
you still call complete() for some reason. If you don't call complete(),
there is no reason to fend against spurious completions.

I think I would prefer seeing more deliberate decisions in the driver,
it helps if things don't just work by coincidence.

> > > If the interrupt from this occurs after the reinit_completion() then the
> > > completion counter is left at a non-zero value. The next unrelated
> > > transfer initiated by userspace will then complete immediately without
> > > waiting for the interrupt or writing to the RX buffer.
> > > 
> > > Fix it by resetting the counter before the transfer so that lingering
> > > values are cleared. This is done after clearing the FIFOs and the
> > > status register but before the transfer is initiated, so no interrupts
> > > should be received at this point resulting in other race conditions.
> > 
> > Sorry, I don't have a lot of experience with the target mode, and when I
> > introduced the XSPI FIFO mode, I didn't take target mode into consideration.
> > 
> > The question is, does the module support XSPI FIFO writes in target
> > mode? In the LS1028A reference manual, I see PUSHR_SLAVE has the upper
> > 16 bits (for the command) hidden, specifically there is no CTAS field
> > there that would point to one of the CTARE0/CTARE1 registers.
> > Cross-checking with the S32G3 RM, I see nothing fundamentally different.
> > 
> > I am surprised, given this fact, that the CMDTCF interrupt would fire at
> > all in target mode.
> 
> It's working in my testing where I've forced it to XSPI mode instead of DMA
> mode on S32G3. I assume the command is blank because in target mode CTAR0
> (aka CTAR0_SLAVE) is always used regardless of the frame.
> 
> CTARE0 isn't explicitly relabeled like CTAR0, but this paragraph states that
> CTARE0 is used:
> 
>   50.4.3.2 Slave mode
> 
>   ... The SPI Slave mode transfer attributes are configured in the CTAR0
>   and CTARE0 registers ...

That's an interesting piece of data which I wasn't aware of, thanks.

> Any transfers smaller than the FIFO are working in interrupt mode, although
> larger ones are problematic because there isn't enough time to reload the
> FIFOs while the host is still sending (hence the error I added in patch 4).
> 
> Polling mode isn't working at all because it has a timeout which gets hit
> and returns -ETIMEDOUT before the host sends anything. Although I added the
> check there for consistency and for catching host mode errors.
> 
> > > 
> > > Fixes: 4f5ee75ea171 ("spi: spi-fsl-dspi: Replace interruptible wait queue with a simple completion")
> > 
> > To be clear, if you ran 'git bisect' to track down this issue, it
> > wouldn't have pointed you to this commit, would it?
> 
> I didn't test it no, but I did assume that the wake_up_interruptible() that
> got replaced wasn't vulnerable to this same issue. Because the spurious
> wake_up_interruptible() would be "lost", and a fresh one from the next
> transfer would have been required to proceed past the
> wait_event_interruptible().
> 
> Whereas wait_for_completion() is just a counter so it has the memory problem
> explained in the commit message.

Why would a spurious wake_up_interruptible() be lost? Is it because of
the dspi->waitflags condition not becoming 1? It would also become 1...

