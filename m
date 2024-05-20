Return-Path: <linux-spi+bounces-2952-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F188C9A4F
	for <lists+linux-spi@lfdr.de>; Mon, 20 May 2024 11:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A2FD1C20D63
	for <lists+linux-spi@lfdr.de>; Mon, 20 May 2024 09:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9373A1BC58;
	Mon, 20 May 2024 09:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CDl0IY6/"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEAB1C6A0;
	Mon, 20 May 2024 09:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716197297; cv=none; b=dtp1ftIw+nRe9C4+aQu59j52wxp/ff5e07A9lONnYoynzDvy/6B71+/vl0ItMwrH8CIamOkty+2phaQAQDdtKp94fOSNV/nHfBt7NR1+LMbAPc8OADAJZk/CyAsBFftLqGJiEQE22N7vM/kf9FHjxIuuUgJtRqsKOOQmtXxCfu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716197297; c=relaxed/simple;
	bh=Bd9Ol7WDLyoUFzO18lNW2BQjTjzDoyfGTWntjvtcMeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9ifCuyzfsO8II3GvxgcIcvxiGdDt4StVQsz/COJHs6YEZDVS9NxZA9G9KTScHXOjEf7nB3TC+csF1n3ieJwMkxNh0fYUkD2udx3LVa1Drn4PJ+RvPtyVMYqUZITbY605omIL5Ntqwywqkb0LsrqkZ1OyVxtoHstVyApiu5AbPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CDl0IY6/; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716197296; x=1747733296;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Bd9Ol7WDLyoUFzO18lNW2BQjTjzDoyfGTWntjvtcMeI=;
  b=CDl0IY6/wepRUiBSXUC4nhXiGEqiKiLRSWHromQF9OZxRlvqmnLw6ekd
   L/ZR2Sz7VMBmWMD+EUJz9Xsrg+9lrezZhWMO/d5C0Ux5AsE6oiVye/yC9
   WNSnHNMC+8eGhOVXnUOkrQl7Dos7liDm0TrUHQuuRNgcA2vLxzF7ZeCNf
   zzn22u9lYZNUpNGQZfPGrBcq1NDxl9jr65FqsP7YATaV5X4Ac9ngzZC+4
   gQ6Kwp4DAUwkxngsIDYjt0Exit+0pxEMXokD4lDjggkuWx5szYuL1d6P+
   dcEQNhvTiNzLuT4yUnAkgHWNgii+IoPlQHatr4HkpCkOpdZIFKTXQwJJK
   g==;
X-CSE-ConnectionGUID: 1065IZf3RQWsg/MzLYRU6A==
X-CSE-MsgGUID: jP39yEVwTR61kJ6V3XjRng==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="12486100"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="12486100"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 02:28:16 -0700
X-CSE-ConnectionGUID: CFuHf44XSjqzuWfRSwz2xQ==
X-CSE-MsgGUID: Le+yFCqcSlaLzh05vJmv1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="55710236"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 02:28:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s8zJU-00000009GJ0-3MQl;
	Mon, 20 May 2024 12:28:12 +0300
Date: Mon, 20 May 2024 12:28:12 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] spi: gpio: Make num_chipselect 8-bit in the
 struct spi_gpio_platform_data
Message-ID: <ZksXrM-W_69e5q2m@smile.fi.intel.com>
References: <20240517194246.747427-1-andriy.shevchenko@linux.intel.com>
 <20240517194246.747427-4-andriy.shevchenko@linux.intel.com>
 <ce75b03e-e061-43ac-94fa-1539c8fe6203@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce75b03e-e061-43ac-94fa-1539c8fe6203@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 17, 2024 at 10:55:55PM +0100, Mark Brown wrote:
> On Fri, May 17, 2024 at 10:42:03PM +0300, Andy Shevchenko wrote:
> > There is no use for whole 16-bit for the number of chip select pins.
> > Drop it to 8 bits.
> 
> because...?

To make the type stricter, but since there is no other benefits and
this one likely won't help to catch the (incorrect) use of big numbers
I think we don't need it.

> It's the only field in the struct so it's not like it makes
> any meaningful different to struct layout.

-- 
With Best Regards,
Andy Shevchenko



