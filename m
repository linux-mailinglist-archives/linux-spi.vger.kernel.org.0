Return-Path: <linux-spi+bounces-11640-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FEDC8FF89
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 20:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E7DFD4E55C8
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 19:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B207F2EC08C;
	Thu, 27 Nov 2025 19:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HugoYkyS"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BCF27380A;
	Thu, 27 Nov 2025 19:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764270114; cv=none; b=nOje82sbqn/ytjBbaj52l4fgDvYqIRsVYNfIDhGfhVxpdDLi9ZmF7XjCh84Nbz3sZFkeZPTEcK4uYhU4y5lmKfVsxEYW3gtGUOGN8Y0+Bbfthli1BNutQROsmDIHk8ikbosrTdro3U4P/xrGLGTIwShRzDoPf0037MP0zE/SEIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764270114; c=relaxed/simple;
	bh=sQd7et9UqRrQNP9xBihl31sNh2PGFV+NmjRTeHy7TcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUkvMGPChN9jFWOgQmHIOH54G3JIstuAtLSZ2NWE8sI6aOTp9Yxj1B21Vstxy7AySfVZuR0BUvLa9Nsu9wR0SFTpf435iF1iaved7c3UyRdtgXGD2YT8gMF3XiJHnVNW1dZupM9FxJYCe+6DcTnJYuz4YgKbO9CLGIzCwFLNUGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HugoYkyS; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764270113; x=1795806113;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=sQd7et9UqRrQNP9xBihl31sNh2PGFV+NmjRTeHy7TcA=;
  b=HugoYkySQnHfyq6QZdcy0NNZPM9EmdGJ4p7qAlSjdXlfVKvDio223ztm
   VKvyAQN1GrTHzbVUdOyec4VQBH83V0ExCVTENenKV58mUcRbyPYbziQbr
   EAiWTnwWTq1IV9O5eC+EN2iFY4tdBQoZXQpkrCyeJ/flNM/bknWz+0egW
   cqEsloYRNY3uds5qW31gYcL3S/5hCxQlrN6upGzWOu4r87oCw2/7EMCKi
   pftWuMHxOcIeAjZG1jKmdUMhZWfQw+6wAeaV7yUKPdXxeOpIKWZnAbCd7
   YYvA5lIsAgJYiWOS9CcJgA8PanaHij2RK2VS5ITqFzVVyQEzDaibbc3Zf
   w==;
X-CSE-ConnectionGUID: OIn9pUT1TS6iRp6ZdZcV7A==
X-CSE-MsgGUID: KXUSdC4aS1qFJd7LZo0w0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="66480489"
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="66480489"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 11:01:52 -0800
X-CSE-ConnectionGUID: qb7nlw5vSrOkbaoq6YcGiQ==
X-CSE-MsgGUID: +8EmmxnfTA+T3AarJah9lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="193312664"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 11:01:50 -0800
Date: Thu, 27 Nov 2025 21:01:48 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Conor Dooley <conor@kernel.org>
Cc: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	Mark Brown <broonie@kernel.org>,
	david laight <david.laight@runbox.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley - M52691 <Conor.Dooley@microchip.com>
Subject: Re: [PATCH v2 2/6] spi: microchip-core: Refactor FIFO read and write
 handlers
Message-ID: <aSigHJDTfqtnO1XY@smile.fi.intel.com>
References: <20251126075558.2035012-1-andriy.shevchenko@linux.intel.com>
 <20251126075558.2035012-3-andriy.shevchenko@linux.intel.com>
 <20251126092145.2f8e4c8d@pumpkin>
 <720a960d-797b-4404-90ab-e0c75c12a151@sirena.org.uk>
 <aSbu4BA8pohsYSQ8@smile.fi.intel.com>
 <48d3b29b-1010-4749-aef0-c66a72f1d8fa@microchip.com>
 <aSiBF9nStZzUNGLA@smile.fi.intel.com>
 <20251127-pliable-magnetism-c59c560e49ad@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251127-pliable-magnetism-c59c560e49ad@spud>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 27, 2025 at 06:05:04PM +0000, Conor Dooley wrote:
> On Thu, Nov 27, 2025 at 06:49:27PM +0200, Andy Shevchenko wrote:
> > On Thu, Nov 27, 2025 at 04:08:25PM +0000, Prajna Rajendra Kumar wrote:
> > > On 26/11/2025 12:13, Andy Shevchenko wrote:
> > > > On Wed, Nov 26, 2025 at 12:05:22PM +0000, Mark Brown wrote:
> > > > > On Wed, Nov 26, 2025 at 09:21:45AM +0000, david laight wrote:

...

> > > > > > I'm not sure I don't prefer the version with one writeb() call.
> > > > > > How about:
> > > > > >              writeb(spi->tx_buf ? *spi->tx_buf++ : 0xaa,
> > > > > >                      spi->regs + MCHP_CORESPI_REG_TXDATA);
> > > > > Please don't abuse the ternery operator like this, just write normal
> > > > > conditional statements.
> > > > FWIW, that's what my patch does already :-)
> > > 
> > > Thanks for the series. However, this particular patch appears to
> > > introduce a regression. The SPI controller reads an incorrect
> > > Device ID from the peripheral.
> > 
> > Hmm... This is interesting. The only thing I see is missed dummy byte read in
> > case of TX only transfers. Is this what you have?
> 
> Seems very likely, the hardware is pretty simple, so it has no concept
> of whether bytes it receives are useful or any ability to operate on
> transfers and discard data from the FIFOs when a new one starts. That's
> why the unconditional read is there to make sure the rx FIFO is kept in
> sync.

I have just sent a v3, please, give it a try.

-- 
With Best Regards,
Andy Shevchenko



