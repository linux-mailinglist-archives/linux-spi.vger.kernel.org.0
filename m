Return-Path: <linux-spi+bounces-3324-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FB48FE4A0
	for <lists+linux-spi@lfdr.de>; Thu,  6 Jun 2024 12:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 896B21F27A82
	for <lists+linux-spi@lfdr.de>; Thu,  6 Jun 2024 10:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7553419538C;
	Thu,  6 Jun 2024 10:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KPCdmfdM"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0302E639;
	Thu,  6 Jun 2024 10:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717670995; cv=none; b=UQ23BB9gTEh3dVnk4dW8GqCcGP1zXfMItq7MitRDKm1/WD8T70Sgl6NQ8XsqJ7l+eHX8hhyNBVr10s25qZ/kDQtJKnQWxtM0hMkRaG1VciOV14VqSqqdvF6pfGIawWpiYkvhZJiJ7EJGpzUrziBox+Qorxm465bi2ZjOFl2TxYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717670995; c=relaxed/simple;
	bh=FBH+8MTzg7oyXYjGtBYYgXMTXAW67hFtoJJ7TYnRWKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERkcj4vuSDuR8hW1FCjk652Z/47L9o//R0QyEfOgq6JyQrb4ED8xC8Vla2ZC4BE/Gj4xNhv5AboFZtDcrruk7vDF3Q6rpLcLgQxiQsdUYhIcD1HeNAU2aXufrfa963dGQ0zIf07AB/OetdVMbPfp41NjlU+Mq0I2IpQOfy61G6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KPCdmfdM; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717670994; x=1749206994;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FBH+8MTzg7oyXYjGtBYYgXMTXAW67hFtoJJ7TYnRWKg=;
  b=KPCdmfdM1dTiCSVxT6i7yA8IiYyFjx/L8gECy1nXpokbdc5n/ebcKV6W
   NqgyGsPAb+FripjSrJPjdgM9afcqqWFcH8zAuSF6O2U4N+4j+IsWtQ4zI
   xEyaIu8sYYs6/mh0B1w9pFHywPY5KwKiUG2WS0AQbiwxzgDKun+ZmQciW
   InbkZH+s167GYWTW+BqI+dUcK98Jz14oYoqFinXFOJsgZVAQhzqvnPbmr
   H2RZii3umjlvAdEsFcUp9gdsc5IgvKlGg6+KC1UP9WwQiNZTiW0E89lZd
   KQR/O6nXdpTwWHKjnPs/DQFb+iT6dSqu9kVdIXNxkVd6wkU/xt6Ss+Xcz
   A==;
X-CSE-ConnectionGUID: bL2X+7h3Sl+zD3Cx/z+VpQ==
X-CSE-MsgGUID: oPci6LkZTw6cERkk0qjMGA==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="14482452"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="14482452"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 03:49:54 -0700
X-CSE-ConnectionGUID: XIt7P8qYRbWAyQ10m1YljQ==
X-CSE-MsgGUID: U3662kFZRKmLaCQ5f6p6jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="42358129"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 03:49:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sFAgo-0000000E8ge-1CCl;
	Thu, 06 Jun 2024 13:49:50 +0300
Date: Thu, 6 Jun 2024 13:49:50 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] spi: Replace custom code with
 device_match_acpi_handle()
Message-ID: <ZmGUTs1unLU67JH5@smile.fi.intel.com>
References: <20240510204952.2582093-1-andriy.shevchenko@linux.intel.com>
 <ZmDT03c_rcPfzMUh@smile.fi.intel.com>
 <251030bd-f0ef-4417-962a-b7d9abd768e5@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <251030bd-f0ef-4417-962a-b7d9abd768e5@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Jun 05, 2024 at 10:22:13PM +0100, Mark Brown wrote:
> On Thu, Jun 06, 2024 at 12:08:35AM +0300, Andy Shevchenko wrote:
> > On Fri, May 10, 2024 at 11:49:52PM +0300, Andy Shevchenko wrote:
> > > Since driver core provides a generic device_match_acpi_handle()
> > > we may replace the custom code with it.
> 
> > Hmm... Other more recent patches went through, is this lost in cracks?

Found it, it's an announce that is missing, thanks!

-- 
With Best Regards,
Andy Shevchenko



