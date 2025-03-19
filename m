Return-Path: <linux-spi+bounces-7223-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B14ECA689DD
	for <lists+linux-spi@lfdr.de>; Wed, 19 Mar 2025 11:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A51BD19C2162
	for <lists+linux-spi@lfdr.de>; Wed, 19 Mar 2025 10:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A7725486A;
	Wed, 19 Mar 2025 10:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hmI8ElBr"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0361C253F3B;
	Wed, 19 Mar 2025 10:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381110; cv=none; b=tpr1IpnLzVAtywbmO2NtKruiIehtCWQqM17yQr9eiesX6G2cJt88QQUkt1r7+TnOU43QR4Odl2t7LKKFnUWjMwToYXa6zVcsH8HRpGt/oq0QfZY9BUL0EwF2/vud0/WNg7jQFq9eOd3dx415GSo2SKOHOV1BtYebSdlJEvDLSIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381110; c=relaxed/simple;
	bh=6Bs8ewEPsGypHaQkuPjai5OH+R1r7HyvjWQrKP3DwU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WhUsJRaVCg6/+eNJTg5Kym6vDVoK7QZ4EdLTMNw/OYH/iCMZ6NSe3tdXfsjROy0+Fl1eM5K4vnXaWVjqe6E9GjVrnlXiFC0myh4wcONVMjTSu8lv1DuHKPN26YIp6P8s/rmCxr+sgjHVN5nxlZFoIpOl4x0x3BunDeJ/8TheQBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hmI8ElBr; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742381109; x=1773917109;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6Bs8ewEPsGypHaQkuPjai5OH+R1r7HyvjWQrKP3DwU4=;
  b=hmI8ElBrDGbjH9/Sc1QPgr0RO90IWhBuGZvTFzfhrWvMLtKLRCHJ+4Yl
   PMdiaN+tiJVxNdpmd3lthaUcMrzJpRcybrsewU2c7bX5ngo2pMxPey/4o
   fhhSztT8L6noo3iqwTbGSpIfSDTBKIHejTF0Yd33wFpMsXQP8mR9X+sgd
   jRVLtrx98LeW1zpZrFs/f2T18FB7pHEnAeqxiZP1YBScT0DhK7MltvwiM
   dwlrp8w8/XQnJ+4lbET//byeKDaBTi7o+gGh02zlxcEEGPRfypn0oLZFt
   oh/NlFZWEcNlrjana5jgXDrwwmIbB2ugsyY79hMFeS45ZOByCtVk48Jvr
   w==;
X-CSE-ConnectionGUID: lrM3Fq5cTXK0AHrqwH+xnA==
X-CSE-MsgGUID: 8oD7A9VQQrudmDXq4MoZew==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="54233420"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="54233420"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 03:45:08 -0700
X-CSE-ConnectionGUID: U6ckEiauS4iUsmsFerYJ0A==
X-CSE-MsgGUID: kpZshVb4RLCQQGjBWlFyMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="145752645"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 03:45:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tuqv1-00000003tRO-3VqJ;
	Wed, 19 Mar 2025 12:45:03 +0200
Date: Wed, 19 Mar 2025 12:45:03 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: Fix reference count leak in slave_show()
Message-ID: <Z9qgL357o5bfzQfm@smile.fi.intel.com>
References: <20250319032305.70340-1-linmq006@gmail.com>
 <Z9qgENjcGFF-rDJe@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9qgENjcGFF-rDJe@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 19, 2025 at 12:44:33PM +0200, Andy Shevchenko wrote:
> On Wed, Mar 19, 2025 at 11:23:04AM +0800, Miaoqian Lin wrote:

...

> >  	struct device *child;
> > +	int ret;
> >  
> >  	child = device_find_any_child(&ctlr->dev);
> > -	return sysfs_emit(buf, "%s\n", child ? to_spi_device(child)->modalias : NULL);
> > +	ret = sysfs_emit(buf, "%s\n", child ? to_spi_device(child)->modalias : NULL);
> > +	put_device(child);
> > +
> > +	return ret;
> 
> Can be written better in case of NULL:
> 
> 	child = device_find_any_child(&ctlr->dev);
> 	if (child)
> 		return sysfs_emit(buf, "%s\n", child ? to_spi_device(child)->modalias);

Of course this has to be

		return sysfs_emit(buf, "%s\n", to_spi_device(child)->modalias);

> 
> 	put_device(child);
> 	return sysfs_emit(buf, "%s\n", NULL);
> 
> No variable needed.

-- 
With Best Regards,
Andy Shevchenko



