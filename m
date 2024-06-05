Return-Path: <linux-spi+bounces-3265-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D11A8FD81E
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jun 2024 23:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BD601C238C7
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jun 2024 21:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBC715F30F;
	Wed,  5 Jun 2024 21:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lPkHNWQS"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F64C4965B;
	Wed,  5 Jun 2024 21:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717621722; cv=none; b=VNqDI7lQMCqoV05S76P4KQYfHW0iD6yODttMzDl9yEJwbWCYW0MKnjncQygdCy54PRkXz5EM+0Fwr80c2yhVp3Zw5/cmJnOqNR5UL8bNP/TT3e2NWLlXhnFVN+3v+Od341gdA6AGuy2Y6zRariWkf+/F7iFJUbnuyemRmDg57CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717621722; c=relaxed/simple;
	bh=zw2Nmi/ExLQYo4xVy01x2QChpp1MaISA8YlSfJocYac=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hyu62U9Lh/avQbKkmx10QBRVyDdH3goy9X8lNasWB3An0ciSjk7S71KK5NWrDb2B0BtRYqF8R2KiHShcRGLfIEUsm9aCNyl0fw1Bynwx5Vr+hxQjI1Zr94qw878TR+v2MwGYzwTxgqLhFraYXAzb8kycXHo3/iDEbDTlSnZd7hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lPkHNWQS; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717621721; x=1749157721;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=zw2Nmi/ExLQYo4xVy01x2QChpp1MaISA8YlSfJocYac=;
  b=lPkHNWQSFglmSKLdbn/4iWxh8B4NCWuCKqN+bmdr2uxyT38bDm5oG6Qw
   GR4YxRZQSDCYKICXRZqvUB/uLaZEDldKLF4tZDWEh8L9DhnYkkgI9xJzc
   dMpHDqNp/bkjFvGhce4Z6CM5MSf0vFC9JaQ8e0LI+Ufd2ml5rIwgHMIuI
   PILPkYV/mmqw8gC7DpVKH/qU7oD6Rq63WBx/KPXRE4g9Wdm3B1/yaa1wI
   Iy48OjprYT6xUS5duW/9nH2qkE+5njKtDXcV3Q8canzkffmToOuI9a7YC
   VdufBybeHo+6JHKCRcYf4Rpl/ekr/IBDtp5QTDDD5EuXc3/VgEauc65Tv
   w==;
X-CSE-ConnectionGUID: 7O9EdyKhQDmCrrPIqNJfmA==
X-CSE-MsgGUID: 9SfJj3GwQPGCS+gIujR9Dg==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="25370048"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="25370048"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 14:08:40 -0700
X-CSE-ConnectionGUID: lLPSWf+YSsuSplBi9uwiUw==
X-CSE-MsgGUID: BneNW52VTB+CozrjOyc/PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="42126386"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 14:08:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sExs4-0000000Dy5J-0w9e;
	Thu, 06 Jun 2024 00:08:36 +0300
Date: Thu, 6 Jun 2024 00:08:35 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] spi: Replace custom code with
 device_match_acpi_handle()
Message-ID: <ZmDT03c_rcPfzMUh@smile.fi.intel.com>
References: <20240510204952.2582093-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510204952.2582093-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 10, 2024 at 11:49:52PM +0300, Andy Shevchenko wrote:
> Since driver core provides a generic device_match_acpi_handle()
> we may replace the custom code with it.

Hmm... Other more recent patches went through, is this lost in cracks?

-- 
With Best Regards,
Andy Shevchenko



