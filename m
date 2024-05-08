Return-Path: <linux-spi+bounces-2787-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 981288BFFAE
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2024 16:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C936F1C2361A
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2024 14:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CE984D3D;
	Wed,  8 May 2024 14:01:47 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587E585952;
	Wed,  8 May 2024 14:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715176906; cv=none; b=fssBDWKvGnjxvLr3zSjyuRDLtvGt81sukAh8cE7FcMu6DRlMcVuzul1YtvRlxCTLPovi3bvMmeU9Koas7Vh4m5wBenaul1YCRjP2HfEO7SIWH5xaJuu1ULPRRnvJhEi6WJwrvzs/xduiuhT8ZOlZsIjJLtRS1WCRg9q8G66pVcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715176906; c=relaxed/simple;
	bh=QTtrLqU3MtsdtuOBqcMMsypFeSb32mO7pCqLCKsGXjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PyTc0UVwUcPhYgylMeZCbaOdYi/peL043gqE5cWmO6DKufadTepZqFzbSFlKUotOOrjt2xujHy94SOlU+16Px2Fb9J/s+fMG1xQb1WJk/LoYFkGE74k/BPBJL3n5vNWFZFOlO07q5Vuv4Zp1sWubGC782urdgoN0ZOxNdDhQ5Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from martin by akranes.kaiser.cx with local (Exim 4.96)
	(envelope-from <martin@akranes.kaiser.cx>)
	id 1s4hbJ-001u7V-2P;
	Wed, 08 May 2024 15:44:53 +0200
Date: Wed, 8 May 2024 15:44:53 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] spi: imx: Don't expect DMA for i.MX{25,35,50,51,53} cspi
 devices
Message-ID: <ZjuB1Rjyu1ooYvDi@akranes.kaiser.cx>
References: <20240508095610.2146640-2-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240508095610.2146640-2-u.kleine-koenig@pengutronix.de>
Sender: "Martin Kaiser,,," <martin@akranes.kaiser.cx>

Hi Uwe,

Thus wrote Uwe Kleine-König (u.kleine-koenig@pengutronix.de):

> While in commit 2dd33f9cec90 ("spi: imx: support DMA for imx35") it was
> claimed that DMA works on i.MX25, i.MX31 and i.MX35 the respective
> device trees don't add DMA channels. The Reference manuals of i.MX31 and
> i.MX25 also don't mention the CSPI core being DMA capable. (I didn't
> check the others.)

If I'm not mistaken, the imx25 reference manual

https://www.nxp.com/docs/en/reference-manual/IMX25RM.pdf

does say that CSPI has DMA support. Section 18.1.1 (Features) lists DMA as one
of the features. There's also DMA events (section 3) for CSPI-1/2/3 RX, TX.

I'd have to dig up the hardware to test again if this is actually working...

   Martin

