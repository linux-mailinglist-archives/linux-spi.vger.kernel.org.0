Return-Path: <linux-spi+bounces-3266-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E40FE8FD820
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jun 2024 23:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96BF51F266DB
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jun 2024 21:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299CD13A897;
	Wed,  5 Jun 2024 21:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AwvY3toI"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDBD3C28;
	Wed,  5 Jun 2024 21:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717621770; cv=none; b=cvl6J/FxzOm7qZ4W+u4dLHC6thuQ0wl9AlWr8Kp+gb4mYtk+zM1thIpdOsDCy45da09R6BD/cerHWto4BgKPYzyAqN0s2wwKGVJLkaHHSTeOZEBle4Jr2/TtQdp/zMW7tTuJsQVBPzJjXS6lO0bt4Osbf1eQiO/bKkS6PG/sXY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717621770; c=relaxed/simple;
	bh=F0sdJqJQogsqfRgEL79ZN8i5DBQ9X4eunO6hJWO2kpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvLrka/FfLgezhLzrJIV8xP7+JO4mA2n0JX5CdZb1/uVKcFOAW5Bu4Q4cWY2piPqd8UIgKyMzv3aqR6tR/7ow+pTYGe/u+8qDgkVuuHct4zqM1cvZSdE4RYoL0wuZORImCvujE09C12XNvx44jDgKRlTw21B/ihZSG2cpzUk3yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AwvY3toI; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717621769; x=1749157769;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F0sdJqJQogsqfRgEL79ZN8i5DBQ9X4eunO6hJWO2kpE=;
  b=AwvY3toIxQeUz/snQN46elPBWshYfZNqBoixiuvJ5xwUJ+oligsIPFyw
   M8j50zvSdaYGf5RH78c+g6Tx3dxVrJZi+uRnVdmCmlkw4M4SkncOlB9jq
   KdegEIRzt8oTW47xywtM3+UDOpsQ/PjtBIT8r281YOAleWcwS5RUPujz0
   lW/pfaG28tU76XZuRL6txUg8tvxzIhiSnPsfdl1IFYmWzPAjT2ZhVKvfK
   IQVBwoCsYb4GENuPeiVTz0HWFzhniuyFsRDHiQ9GcyjNw/p9gNJz7klrx
   8cvb73XN9tLp2xEaMqYTf3Z3iWf46tKmOdYWwa+cbVk81w0vfduyNl5g9
   g==;
X-CSE-ConnectionGUID: 3/a5wOnmTk6XVPKx34N4aw==
X-CSE-MsgGUID: kdPvk7OQSbaysa5c+HxmGQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="25662479"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="25662479"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 14:09:28 -0700
X-CSE-ConnectionGUID: Ysl8GZPtTximfi7eSADCtw==
X-CSE-MsgGUID: ORMN+v53TuK0J7QHA6s/lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="68867316"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 14:09:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sExsq-0000000Dy6V-20z1;
	Thu, 06 Jun 2024 00:09:24 +0300
Date: Thu, 6 Jun 2024 00:09:24 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] spi: gpio: Make num_chipselect 8-bit in the
 struct spi_gpio_platform_data
Message-ID: <ZmDUBHUyy1uozcn2@smile.fi.intel.com>
References: <20240517194246.747427-1-andriy.shevchenko@linux.intel.com>
 <20240517194246.747427-4-andriy.shevchenko@linux.intel.com>
 <ce75b03e-e061-43ac-94fa-1539c8fe6203@sirena.org.uk>
 <ZksXrM-W_69e5q2m@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZksXrM-W_69e5q2m@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, May 20, 2024 at 12:28:12PM +0300, Andy Shevchenko wrote:
> On Fri, May 17, 2024 at 10:55:55PM +0100, Mark Brown wrote:
> > On Fri, May 17, 2024 at 10:42:03PM +0300, Andy Shevchenko wrote:
> > > There is no use for whole 16-bit for the number of chip select pins.
> > > Drop it to 8 bits.
> > 
> > because...?
> 
> To make the type stricter, but since there is no other benefits and
> this one likely won't help to catch the (incorrect) use of big numbers
> I think we don't need it.
> 
> > It's the only field in the struct so it's not like it makes
> > any meaningful different to struct layout.

Should I do something about the first two patches or is it fine to get them in?

-- 
With Best Regards,
Andy Shevchenko



