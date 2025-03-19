Return-Path: <linux-spi+bounces-7224-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 103F2A689E3
	for <lists+linux-spi@lfdr.de>; Wed, 19 Mar 2025 11:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44DD119C2543
	for <lists+linux-spi@lfdr.de>; Wed, 19 Mar 2025 10:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17321DEFCC;
	Wed, 19 Mar 2025 10:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TDfuAXyr"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4231322F19;
	Wed, 19 Mar 2025 10:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381153; cv=none; b=giza2GbMt1i8WusMtR5nFr9i4wwZ6W51DUaKNpfY7kM3BY/mP9EWgQJGd63F37kEDT3hgjB2fuyqs/DIw1TowDTG53p2DhhOxgH3AUVlA8zuy25LyW8jSxf6fNwMXXke3SHkwwsKDsP0pnhdizzH07ikdMOfTM4inp6af9QZGCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381153; c=relaxed/simple;
	bh=1gt/xqmyaIkl7LN33b1UYpNINIUvm3CjeOkXGnv8Fj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efI61U+R8+Qrv86MFSMDE72IAfYIxpF+icSpvMCdWrPBsxs2ArZ7yshzHY4+z2jEqf68K6k07pv7gIOXLcYp0ofb1s+jsbFdmcYPu+MWI2izQuAM7RloAN+vAISrZneY7PL9ct7J2GmA28r0RtL6znRn3viOurbJSrNEsFg+iQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TDfuAXyr; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742381152; x=1773917152;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1gt/xqmyaIkl7LN33b1UYpNINIUvm3CjeOkXGnv8Fj0=;
  b=TDfuAXyr6YE7seN/RflDY3bJdoiFGp+NlLiU8279givWLiseXKWms5/0
   scSbizke7VenW4nhrktxxTAV/4CBEgcOI17DC2gBZI52Tn9abfUwOvMOj
   KKT3PVte97z17aHpdth5jnSaimDb451H0l4WFwqnElJW6m4xDsFN6U5GH
   TsyOd7ij6cOeR1EL718JnQ9wavUdgVTOdcqTbShFT+NAomMAXVC/3PE+p
   BquKT7VMhG7UglcTR4ZGPQfuToGmN9CL1E0P1NdL3+XNNUqHVwBbhyAH3
   SLV77CAMBw183MqpL/3X8qcT6RwkU7+ZfFZybk+c6bewHTFIx3M9Oda4n
   A==;
X-CSE-ConnectionGUID: eu4W5ExgSlOfyd4CzpP9WQ==
X-CSE-MsgGUID: nL8e4gcoS62ZEiBIUg1+2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="54557789"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="54557789"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 03:45:52 -0700
X-CSE-ConnectionGUID: 5+25TVs3R1emAJwNNbmbNg==
X-CSE-MsgGUID: Mqr7iF+EQnaoJrmeDd3KXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="122585731"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 03:45:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tuqvj-00000003tRu-05Z4;
	Wed, 19 Mar 2025 12:45:47 +0200
Date: Wed, 19 Mar 2025 12:45:46 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: Fix reference count leak in slave_show()
Message-ID: <Z9qgWqjVRgthJ8qX@smile.fi.intel.com>
References: <20250319032305.70340-1-linmq006@gmail.com>
 <Z9qgENjcGFF-rDJe@smile.fi.intel.com>
 <Z9qgL357o5bfzQfm@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9qgL357o5bfzQfm@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 19, 2025 at 12:45:03PM +0200, Andy Shevchenko wrote:
> On Wed, Mar 19, 2025 at 12:44:33PM +0200, Andy Shevchenko wrote:
> > On Wed, Mar 19, 2025 at 11:23:04AM +0800, Miaoqian Lin wrote:

...

> > >  	struct device *child;
> > > +	int ret;
> > >  
> > >  	child = device_find_any_child(&ctlr->dev);
> > > -	return sysfs_emit(buf, "%s\n", child ? to_spi_device(child)->modalias : NULL);
> > > +	ret = sysfs_emit(buf, "%s\n", child ? to_spi_device(child)->modalias : NULL);
> > > +	put_device(child);
> > > +
> > > +	return ret;
> > 
> > Can be written better in case of NULL:
> > 
> > 	child = device_find_any_child(&ctlr->dev);
> > 	if (child)
> > 		return sysfs_emit(buf, "%s\n", child ? to_spi_device(child)->modalias);
> 
> Of course this has to be
> 
> 		return sysfs_emit(buf, "%s\n", to_spi_device(child)->modalias);

And I mixed the conditional, but I hope you got the idea...

> > 
> > 	put_device(child);
> > 	return sysfs_emit(buf, "%s\n", NULL);
> > 
> > No variable needed.

-- 
With Best Regards,
Andy Shevchenko



