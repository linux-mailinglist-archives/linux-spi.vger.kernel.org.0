Return-Path: <linux-spi+bounces-11628-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BEBC8F8BE
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 17:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 36BB04E1034
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 16:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FA9336EC0;
	Thu, 27 Nov 2025 16:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HwuF4wgm"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206192D9EDA;
	Thu, 27 Nov 2025 16:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764262174; cv=none; b=OUMhPueu2jpAQCk5CKi0TjBU9KRKtT8K4HrmCTqP6lMjUhtl0dewcaiNONpFnzW6i5vGv8rtVgiGVHnQ29zyRUUtdrtslL9oZC/hIf8cDiTfLhr8IVT3lvPzgKPinm6Zs+65bL7sVoVrxL7kmYOezPvvask/tnhdb+OPTV2GK5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764262174; c=relaxed/simple;
	bh=df7XJwCppbnJGE9EnRuzTYmPP76APnFMQdfypzxe190=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFDomvapAbzWeSmYz6Z1N9fgFZfyHT0sSFVRcN1XSSQwpNx0AGx0de1AG+tzdRe0rDZGKnEAOdUsGMyHyCfLVqvQU0yHMtl47QHdUMzeLX59pKoY0tH5T5ifuwS90mHdUdxNP4MA01g8DADodpOgEih3c4Id5I05tN/splJI2/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HwuF4wgm; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764262172; x=1795798172;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=df7XJwCppbnJGE9EnRuzTYmPP76APnFMQdfypzxe190=;
  b=HwuF4wgmMOWycUG895dBEb5L1dXm1xQfwz/giTCq9tjXbqfc82IuqI0W
   cGw5go8qUumo/MBSoHRhboLiHn9VshAFeResvJpG5IcR235LOOCB7fbYR
   xEQ64QWP7FjMAX5D7Y7TP3c76oJY7Mov9px+x1dzq3JqhOw4bc6TpL3xL
   F7HfdZSshWtCcmkRGHwqqjp7w9XrcFtxXHcfOpnbfCoLSvJT5XPwEeTw4
   AGPl0X6LuV+fQw/f396CVlqV4/BPjWqSUchiTkYe4kQ4paRxYEwXZ/wuw
   ST0CTbb6gf7T6ItVOgike4jBvdsRRe7hkWl2zMrMpZrvXN47CDmL9tzAw
   w==;
X-CSE-ConnectionGUID: CkZ+Df0NQLabd65hMUAVTw==
X-CSE-MsgGUID: nOPKS+ELRY+30+qDosb9HA==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="66257081"
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="66257081"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 08:49:31 -0800
X-CSE-ConnectionGUID: GkjVgiZsSaOw1fZIsmYhZg==
X-CSE-MsgGUID: A9jPccKvT0uz0/1myKy9eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="197752243"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 08:49:30 -0800
Date: Thu, 27 Nov 2025 18:49:27 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
Cc: Mark Brown <broonie@kernel.org>, david laight <david.laight@runbox.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Conor Dooley - M52691 <Conor.Dooley@microchip.com>
Subject: Re: [PATCH v2 2/6] spi: microchip-core: Refactor FIFO read and write
 handlers
Message-ID: <aSiBF9nStZzUNGLA@smile.fi.intel.com>
References: <20251126075558.2035012-1-andriy.shevchenko@linux.intel.com>
 <20251126075558.2035012-3-andriy.shevchenko@linux.intel.com>
 <20251126092145.2f8e4c8d@pumpkin>
 <720a960d-797b-4404-90ab-e0c75c12a151@sirena.org.uk>
 <aSbu4BA8pohsYSQ8@smile.fi.intel.com>
 <48d3b29b-1010-4749-aef0-c66a72f1d8fa@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48d3b29b-1010-4749-aef0-c66a72f1d8fa@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 27, 2025 at 04:08:25PM +0000, Prajna Rajendra Kumar wrote:
> On 26/11/2025 12:13, Andy Shevchenko wrote:
> > On Wed, Nov 26, 2025 at 12:05:22PM +0000, Mark Brown wrote:
> > > On Wed, Nov 26, 2025 at 09:21:45AM +0000, david laight wrote:

...

> > > > I'm not sure I don't prefer the version with one writeb() call.
> > > > How about:
> > > >              writeb(spi->tx_buf ? *spi->tx_buf++ : 0xaa,
> > > >                      spi->regs + MCHP_CORESPI_REG_TXDATA);
> > > Please don't abuse the ternery operator like this, just write normal
> > > conditional statements.
> > FWIW, that's what my patch does already :-)
> 
> Thanks for the series. However, this particular patch appears to
> introduce a regression. The SPI controller reads an incorrect
> Device ID from the peripheral.

Hmm... This is interesting. The only thing I see is missed dummy byte read in
case of TX only transfers. Is this what you have?

> I’m investigating the root cause and will follow up.

Okay, I will be glad to know the cause and help to fix that.


Thank you for the review!

-- 
With Best Regards,
Andy Shevchenko



