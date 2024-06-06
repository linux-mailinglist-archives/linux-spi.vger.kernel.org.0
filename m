Return-Path: <linux-spi+bounces-3321-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2894E8FE48F
	for <lists+linux-spi@lfdr.de>; Thu,  6 Jun 2024 12:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7E95B26C3A
	for <lists+linux-spi@lfdr.de>; Thu,  6 Jun 2024 10:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049491850BC;
	Thu,  6 Jun 2024 10:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k1XI5hGM"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A7D153821;
	Thu,  6 Jun 2024 10:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717670862; cv=none; b=UVeXkEagWf2O9lMzQt3mQc8/BliM1z3xIzVZOIYi1kTzkRS3QR01WoPnovBPRTiYYoGv+5cImSgbdvGBoCcGhtNpRyFZ0nOzTy9nnl2cDZQRMHQbK1fDnou9D40GkcKCvtx3U6Qnaw9ugU+rsBmxlPMGenFoiPYv80tsr1Zyc1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717670862; c=relaxed/simple;
	bh=/z+EkFouMbCLn5e4wGbH+lQllFSHLQ2Ua+xuueBj3Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYGSx0zb7uKqYqpzLw4VyNHqWVZLp8nkIUybfH98DRgl6gBTNnWL0ZeoJVSQC7PueFQ3wtuWGLvIpmuZn1jgQJsThWVuiU6C+8HW5Xj7gsQCfe+20H6hiMZMfA4AlrHL80bi5sIfbzFcLbvhUEv67tF9c8Kv3kvhj1Jc16ETXHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k1XI5hGM; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717670862; x=1749206862;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/z+EkFouMbCLn5e4wGbH+lQllFSHLQ2Ua+xuueBj3Ko=;
  b=k1XI5hGMKCdSIeiIwV2uDIEKCP/5SpcBoFR+2avHwJ+nuKyBN4vy8Wnf
   9QkTljORhMtx1/Hq/97APHeLhww1JMPCVNnSyxttKefsrxFMJuWecNytc
   tZU61hYeUmmfeviQ/qZz2Qi69VScQnBQo8xVgXMpzmxt36W6mAQ9GzmDN
   lU3W7nsVcGV05HlLkX3wrb9Ow1HsZ4vwM5BQnNmp2rjtsP48AqJ5cnmji
   Je/i5xYEtTtmdA9xc2wUB/eUnKOMgf5Dhm/RxZQmGlDal4dcuMrPFzBZz
   p5Fstk06OeHFEEwm3suwRQ5rkSL4u8DYgCG4Dz+oHE4SC9ENfit2cYkpk
   w==;
X-CSE-ConnectionGUID: qB3A7qpbROW7D5mWWRmwLw==
X-CSE-MsgGUID: +jH3kkPkRi6ZX41aA6O8/A==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="14482219"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="14482219"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 03:47:41 -0700
X-CSE-ConnectionGUID: KHUTGfPWSzu3ln9nFtlsrA==
X-CSE-MsgGUID: yeDb+aOSSNq2slmwQ1cVVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="42357833"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 03:47:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sFAef-0000000E8dr-2tg6;
	Thu, 06 Jun 2024 13:47:37 +0300
Date: Thu, 6 Jun 2024 13:47:37 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] spi: bitbang: Clean up the driver
Message-ID: <ZmGTydYN8ZIVRf8N@smile.fi.intel.com>
References: <20240517194104.747328-1-andriy.shevchenko@linux.intel.com>
 <ZmDTgtONF49f8cBr@smile.fi.intel.com>
 <444b20d3-9096-4372-917e-1b997e59cef1@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <444b20d3-9096-4372-917e-1b997e59cef1@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Jun 05, 2024 at 10:21:35PM +0100, Mark Brown wrote:
> On Thu, Jun 06, 2024 at 12:07:14AM +0300, Andy Shevchenko wrote:
> > On Fri, May 17, 2024 at 10:40:19PM +0300, Andy Shevchenko wrote:
> > > A few cleanups to the driver. No functional change intended.
> > > 
> > > Andy Shevchenko (3):
> > >   spi: bitbang: Use typedef for txrx_*() callbacks
> > >   spi: bitbang: Convert unsigned to unsigned int
> > >   spi: bitbang: Replace hard coded number of SPI modes
> > 
> > Hmm... It's not the first time I noticed that the series
> > (despite even appearing in the CI, but then disappearing)
> > left abandoned without clear feedback,
> 
> > Should I do something here?

Okay, it's just an announce is missing.
I found them in the repository. Thanks!

-- 
With Best Regards,
Andy Shevchenko



