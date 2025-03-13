Return-Path: <linux-spi+bounces-7120-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B45DA5F889
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 15:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C895B17718C
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 14:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5816D268FF6;
	Thu, 13 Mar 2025 14:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hL4uX9eB"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48F6267B1D;
	Thu, 13 Mar 2025 14:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876499; cv=none; b=M9T4aEfRrhRjLUEHDi+v3gAYcYyvQTDQ3j+mVLkVxPw4L9xmbUJCXH7m6hnE5WlW1CQWmsck3797NcrQgolhoyqg4svJWoExfZDujvwlg0gotuwcw0mc2B+cihT0eGDXZkk/MhHZjc6v8j1oy3vGtECO0MNB7NkwI1q6tm9gyRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876499; c=relaxed/simple;
	bh=VnBsh24BaoeppzNWMgOUOfdRq51sCTPpk8XCqt9eJjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzeMTkHwAFYnHu4FUbQB86E9yiGzG4cES8cvXJjoEaPv4j6i8C6weXiurww9RAlFpeOqRv6ce2TqJjLk5mONQvddCvjsICKR6mp7v4XMhiXZHDmxJ7u/StEwIWovbaWAZZfhhBf/Qp5WKjE8+IIhylUC+6B5Y1AqN5FSnt2UowQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hL4uX9eB; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741876498; x=1773412498;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VnBsh24BaoeppzNWMgOUOfdRq51sCTPpk8XCqt9eJjw=;
  b=hL4uX9eBapwa2a4ZDJ/3peQNpKj+FWa44eDAHVyKf/o8H39Ufeju/E32
   sPdc2TqjkNh+fmP0YezuSUbBM+ul4zzqhcnh/hyQj6tie/kUGuGY3lXHR
   dluNB4dbOhIo6FNXy2jUOgPGNZ/E1FuZA462/O2Q27x1YW6CKKlfzbq+g
   cInEWsOzZ8kRGMC3bdBMqUV4C6iicHa3oy2AmusxWRdVxmkxKp2R+SR5J
   KQbEyar+dHpGfh9tHotjBfJ6XIH3yDzy7Dd60A7UTIFao61fsjBO0Z7Ol
   etekC6DpEVz4sSi9GfggMK0lVC/uct1McKUvsm1139zZZCprCh+LLXCXY
   A==;
X-CSE-ConnectionGUID: CuAmh4soTDC+88NrYwpi4w==
X-CSE-MsgGUID: ioWQBl7yQNWaecdcM/hDVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42245889"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="42245889"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 07:34:57 -0700
X-CSE-ConnectionGUID: LtS4bOCgTp6/xbBa6O03Yw==
X-CSE-MsgGUID: i5Rt2qekTFGP13lu5AdJJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="158123773"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 07:34:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tsjdr-00000002Cia-1Ihl;
	Thu, 13 Mar 2025 16:34:35 +0200
Date: Thu, 13 Mar 2025 16:34:35 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH v1 1/1] spi: Use inclusive language
Message-ID: <Z9Ls-zhryd7mJv-b@smile.fi.intel.com>
References: <20250313111442.322850-1-andriy.shevchenko@linux.intel.com>
 <1c49edb2-2ffc-419e-be5e-7e15669a7839@sirena.org.uk>
 <Z9LlTflb1HQMyEv2@smile.fi.intel.com>
 <e329812d-90a5-456e-9a00-abb5c2c8d25d@sirena.org.uk>
 <Z9LqyWr4GH4RX6Nj@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9LqyWr4GH4RX6Nj@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 13, 2025 at 04:25:13PM +0200, Andy Shevchenko wrote:
> On Thu, Mar 13, 2025 at 02:12:29PM +0000, Mark Brown wrote:
> > On Thu, Mar 13, 2025 at 04:01:49PM +0200, Andy Shevchenko wrote:
> > > On Thu, Mar 13, 2025 at 12:47:32PM +0000, Mark Brown wrote:
> > 
> > > > This doesn't apply against current code, please check and resend.
> > 
> > > Hmm... It's based on the spi/for-next. Should I use another branch?
> > 
> > I did try to apply it against that in case there were fixes that needed
> > merging up, it didn't apply.  Are you sure you're using an up to date
> > copy?  I have ebd50ac3cd97ecae231f92b2d64b68d3c66b3474.
> 
> 87a228960033 spi: Use inclusive language
> 0d9a21198453 defconfig: enable SERIAL_MULTI_INSTANTIATE
> 90485ebfb4b3 defconfig: enable SPI_TOPCLIFF_PCH
> 6d91e1fce386 defconfig: enable EEPROM_AT24 and EEPROM_AT25
> 331ffc354c53 defconfig: enable GPIO_PCH
> d519315d6bed Merge remote-tracking branch 'spi/for-next' into HEAD
> ebd50ac3cd97 (spi/for-next) Merge remote-tracking branch 'spi/for-6.15' into spi-next
> 
> Yes, the base where it was merged to is eds-acpi branch of my public GH [1],
> which has no SPI stuff in there.

> [1]: https://github.com/andy-shev/linux/commits/eds-acpi/

$ git checkout -b test-spi-mrg spi/for-next
$ git cherry-pick -1 87a228960033
[test-spi-mrg 8a11d1063109] spi: Use inclusive language
Date: Fri Dec 8 19:02:54 2023 +0200
2 files changed, 64 insertions(+), 66 deletions(-)

In any case there is a v2, please try that one.

-- 
With Best Regards,
Andy Shevchenko



