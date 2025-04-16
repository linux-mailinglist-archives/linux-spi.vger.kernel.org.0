Return-Path: <linux-spi+bounces-7627-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FD8A9076F
	for <lists+linux-spi@lfdr.de>; Wed, 16 Apr 2025 17:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61E573B9A31
	for <lists+linux-spi@lfdr.de>; Wed, 16 Apr 2025 15:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916002040A7;
	Wed, 16 Apr 2025 15:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PzVtHVOL"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0792189BB5;
	Wed, 16 Apr 2025 15:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744816450; cv=none; b=tioUI+dVNwXcbuzbcMM1VGYKFvMg0XJOCgLx90AD8ktEqZxUVqWrC9OmSkz1R9vSJI9kq6W+iFIM+m8Jsen7uwjDmhPJ5YEizMXQpRXkzYU7uGEB8oQKleZyayyRUBb7sO9kYdw7FKchNceSDZrsbwlGuSMXWGIjj9RX5oOplEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744816450; c=relaxed/simple;
	bh=NYBX+03u4Px6LAM1RE7h6qnfefn2E2pZYsDb6oGo3r4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZwttYHuE27Bndu3GPcjhswK6SvlR+iXj1soqHvVniVO48VIU8hlEWSTH/h3sZ0rte/UiSpMGW4Sk9/pZtgMR2FwkV/Vniz1IGZkVz/DE0ZmuDCFkdUnolQvO8bHQkbitCv/y+ABB80HDyfNKj/rNZBrW0fYuf3HwfHC3v8ilEYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PzVtHVOL; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744816448; x=1776352448;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NYBX+03u4Px6LAM1RE7h6qnfefn2E2pZYsDb6oGo3r4=;
  b=PzVtHVOLs5h23tqUZMBVUp/KRpS4+nxCvXtykcxfU+8Aa5RC3/eexDYh
   FcuA6wAONphYZy+iJk5JLMl4cuhFff81QC4Ehbbv/jKa93rmPL9GVkwk7
   4xIQ/JiDOLJh0qE3fYbe/MCHdTlXj2aGMlQXSRQi7B26o0jXmZtFFcydg
   L2YZK+Q89ZRiC7wsEiyadbtKEZkERHSCyT7U45BRIMxPx7pNalL8gQAt4
   0bKskMAyiEtJ6fRXG4oaQ3roGTXhD/WkCzmZfb/KMXN2AlbJDAgbgqQ9I
   I2Kx+OyA01WnaYV69MstWKqFMqVRHKcTP0XDvJnyGVf/uLleKFino2biO
   Q==;
X-CSE-ConnectionGUID: dme1CS7MRX+SZTLSgbwYpQ==
X-CSE-MsgGUID: g9VYu6uiS7qpygOeJTJr4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="68860004"
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="68860004"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 08:14:08 -0700
X-CSE-ConnectionGUID: zIe+yycQTh+XrjdEhHfIKw==
X-CSE-MsgGUID: h0eIZ2zITcuJHZgAonVMIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="130829538"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 08:14:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u54Si-0000000CtXJ-1ilv;
	Wed, 16 Apr 2025 18:14:04 +0300
Date: Wed, 16 Apr 2025 18:14:04 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] spi: Add spi_bpw_to_bytes() helper and use it
Message-ID: <Z__JPFge9MHFXb9c@smile.fi.intel.com>
References: <20250416062013.1826421-1-andriy.shevchenko@linux.intel.com>
 <20250416062013.1826421-2-andriy.shevchenko@linux.intel.com>
 <bd28d718-ab7e-4470-a4de-22b995db8b94@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd28d718-ab7e-4470-a4de-22b995db8b94@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 16, 2025 at 09:56:12AM -0500, David Lechner wrote:
> On 4/16/25 1:16 AM, Andy Shevchenko wrote:

...

> > +/**
> > + * spi_bpw_to_bytes - Covert bits per word to bytes
> > + * @bpw: Bits per word
> > + *
> > + * This function converts the given @bpw to bytes. The result is always
> > + * power-of-two (e.g. for 37 bits it returns 8 bytes) or 0 for 0 input.
> 
> The SPI subsystem currently only supports bpw up to 32, so perhaps not
> the best choice of value for the example. I would go with 20 bits getting
> rounded up to 4 bytes to match the existing docs for @bits_per_word.

Okay, I think I come up with a few examples, so it will show that it's not
4-byte multiple or so.

> > + * Returns:
> > + * Bytes for the given @bpw.
> > + */
> > +static inline u32 spi_bpw_to_bytes(u32 bpw)
> > +{
> > +	return roundup_pow_of_two(BITS_TO_BYTES(bpw));

> Do we need to #include <linux/log2.h> for roundup_pow_of_two()?

Right now I prefer not to touch that (it is implicitly included); the headers
needs to have a bigger cleanup and my first attempt had miserably failed.

> > +}

-- 
With Best Regards,
Andy Shevchenko



