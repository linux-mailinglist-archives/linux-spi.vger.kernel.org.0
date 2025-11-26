Return-Path: <linux-spi+bounces-11583-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 86571C89790
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 12:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E2AD4E48EF
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 11:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABB72D9EF4;
	Wed, 26 Nov 2025 11:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QS3balAc"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B815026B760;
	Wed, 26 Nov 2025 11:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764155860; cv=none; b=O3uqvsoPKAAthjBFRjl7RW74QetLbU11SHwtxlvxRH9vl4GBppaT2eMW5kT3uFPrukGT3/+TyN3XyCB0Jb4rykrorWBXfBDMjHnnuOBUTPtvtAS3bc7lNJAjHklJu538uteNHzvdtVZKoqBb5wQP3anFt3vTXUFMKWgIyTth1hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764155860; c=relaxed/simple;
	bh=1eu6oq8fNQo2RLl9nnLYQX3PPBiV7VnqWuQllAt5FwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmJLpQKkhplqQ5Sb3/SJG/7dAEkNBqZfmt7pWv88JTFtnjXtAX/tkGkbZ/PiNUJEdPg0reCAV6Y+FReHBP7Fwm5ezmvxsQcXG1RXWFZix7AXpTIUPHQp6cyTZEpH1kTHz8xmKXTVVJfEUVZ0QDv/DiDfsk6FuhTSkdD9JHt9Mus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QS3balAc; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764155859; x=1795691859;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1eu6oq8fNQo2RLl9nnLYQX3PPBiV7VnqWuQllAt5FwU=;
  b=QS3balAcq+ZcyBj7XwFFwtF6DEKv3+XNRd2oAOQ1O/zrDi/ocfeLsWli
   parz45blDRYRs2YPS5Zm/1+DFq6KGKMslZ6mBuCMpXWRNrRS0/Jodf1Ja
   GhPYETOzZbeGhuLFjXpjgmHK7VATjRAJp989tQ04hSsJJHR5vEaVZ2U5D
   5x5mZ/tXNoglMdLK4rdr8Kbbea/asMWjccMyQvpv9gW0E42pChR4NOpou
   noBo6MXxuLMwhdG8K/WWSJqbqb8h/kHOG90aCHcUTB1FDdhd59/4HG6qK
   U25+1C0nKihqIrhcEl8KJQ2ZY7RDwCWLxBC/b7l/Zf1rOF9yCI9p1WUEV
   Q==;
X-CSE-ConnectionGUID: nBlZ5g0kTIWjrHY0HlSGxw==
X-CSE-MsgGUID: xdA10h2FQby1g3h3S5/g7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="76813637"
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="76813637"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 03:17:38 -0800
X-CSE-ConnectionGUID: GsY9ubZISgyY94vd/o8ntw==
X-CSE-MsgGUID: lzit9wqES/GmY8nAODpuUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="197237221"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.89])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 03:17:37 -0800
Date: Wed, 26 Nov 2025 13:17:34 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: david laight <david.laight@runbox.com>
Cc: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/6] spi: microchip-core: Refactor FIFO read and write
 handlers
Message-ID: <aSbhzoSKjVAIuY-m@smile.fi.intel.com>
References: <20251126075558.2035012-1-andriy.shevchenko@linux.intel.com>
 <20251126075558.2035012-3-andriy.shevchenko@linux.intel.com>
 <20251126092145.2f8e4c8d@pumpkin>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126092145.2f8e4c8d@pumpkin>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 26, 2025 at 09:21:45AM +0000, david laight wrote:
> On Wed, 26 Nov 2025 08:54:40 +0100
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Make both handlers to be shorter and easier to understand.
> > While at it, unify their style.

...

> >  	for (int i = 0; i < fifo_max; i++) {

^^^	(1)

...

> >  		while (readb(spi->regs + MCHP_CORESPI_REG_STAT) &
> >  		       MCHP_CORESPI_STATUS_RXFIFO_EMPTY)
> >  			;
> 
> This is a hard spin until data is available.
> I think 'spi' is a bit like 'i2c' (etc) so is quite slow.
> Even if the code thinks there are 'fifo_max' bytes in the fifo it seems
> wrong to spin indefinitely.
> If the code is trying to read a response that is still arriving from the
> physical hardware is is positively wrong.
> If some hardware has a glitch that FIFO_EMPTY is temporarily incorrectly set
> after a read - then maybe you need some recovery code.
> Otherwise I suspect FIFO_EMPTY should generate a short read.
> 
> The write code (below) does an 'early terminate'' on fifo full.
> Presumably it is woken by an interrupt to continue the write?
> 
> I actually doubt that transferring messages that are larger than the
> device fifo is ever going to be completely reliable.
> You'd need to guarantee the interrupt latency to update the fifo be short
> enough to guarantee the fifo won't underflow/overflow.
> (Unless the spi hardware 'clock stops' the physical interface when the fifo
> if full/empty - which is effectively what happens when software 'bit-bangs'
> these serial interfaces.)

I also saw that code and it needs to be amended, but it's out of the scope of
this mini-series.

...

> > +	for (int i = 0; i < fifo_max; i++) {
> 
> unsigned int or u32 ??

int works as well and I won't to touch (1) above, less churn.

...

> > +			writeb(*spi->tx_buf++, spi->regs + MCHP_CORESPI_REG_TXDATA);
> > +		elsespi->regs + MCHP_CORESPI_REG_TXDATA);
> > +			writeb(0xaa, spi->regs + MCHP_CORESPI_REG_TXDATA);
> 
> I'm not sure I don't prefer the version with one writeb() call.
> How about:
> 		writeb(spi->tx_buf ? *spi->tx_buf++ : 0xaa,
> 			spi->regs + MCHP_CORESPI_REG_TXDATA);

I find ternary here is unreadable as regular if. With regular if we also see
the exact difference at a glance. I definitely prefer my variant.

...

Thanks for the review.

-- 
With Best Regards,
Andy Shevchenko



