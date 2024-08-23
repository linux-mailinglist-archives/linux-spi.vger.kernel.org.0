Return-Path: <linux-spi+bounces-4284-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A62CC95D13E
	for <lists+linux-spi@lfdr.de>; Fri, 23 Aug 2024 17:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACF8EB2D446
	for <lists+linux-spi@lfdr.de>; Fri, 23 Aug 2024 15:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C9C188A07;
	Fri, 23 Aug 2024 15:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aT8MpJ6O"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EA8187861;
	Fri, 23 Aug 2024 15:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724425800; cv=none; b=b2vq64YLz5aXBNtkWLs095vkyI5AyeEaNzgpu19Q/lPWIRt1Ozgiql9QXd/z3Zf41igRC/jjDz8DWOvihXQJdCDPwbfr8HghtwxR+B0lRiQtTYbrdYDrX1dsmRoAjSn4+W6pI984TRjER0ZxWtSzkLlWatcY/hhbNKlEUml4rZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724425800; c=relaxed/simple;
	bh=tgAN/BXaa8QGivIdM2DmNF+5DcgBrWogWdPhumyrzvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eilxpHu/ao2GEO4R1vJWKNJg59KxngkdQdKPffqSeuzuXlnj3GMQTP5tk5qZEf2X4p6d1AZsgsWJCdBmWCx/Ok+WFMhFOPFJQ8IZ84pkuslLt7gPglc4rMIGDQPaNB0kBZpC/w8xdnYhrf1HXztWkhsGVQw0pOCwsGsGhjvDNf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aT8MpJ6O; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724425798; x=1755961798;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tgAN/BXaa8QGivIdM2DmNF+5DcgBrWogWdPhumyrzvs=;
  b=aT8MpJ6OHl0iiHMsOXtE28LFG5pFubPgujV4w/EC+L267F0V/NQDtNwJ
   COLjEMiex/GVVrgCAiIyqryyQI5bhY3C/Kcs3QSbxtfsIe+lA+Ckci7ZT
   bnDXU0YbLXNjvv1dq8NRq1I7C8977odYeD987uFPMv6BGVGdzz6AytiFm
   l6bunjFhRe0FpwaE39JbSCIfBsIiJ2IQRhEcoMhn19AZ/lDPm14wC7Rsv
   Mjp5td8Gn7GZL2w2t6iUWeOEgbKDSuPiSeQbrAkwjhlDZVaFIRo7MKzMi
   552a/DdIaz2bcxXNkaAhuJPx1qmOjRv0ZUdfK2CLNxgF0KlrjBtsuaWU4
   g==;
X-CSE-ConnectionGUID: w2r0RJpIQ+aqPHiCQas+TA==
X-CSE-MsgGUID: J5+UE/pfTiasxZvoI6tptA==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="26657212"
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="26657212"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 08:09:58 -0700
X-CSE-ConnectionGUID: B7Mx2W84Tr2XPDdpIYdfmA==
X-CSE-MsgGUID: +SKDYP2tR/a1UR7si6tOHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="61524354"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 08:09:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1shVvH-00000000pZx-0M4w;
	Fri, 23 Aug 2024 18:09:55 +0300
Date: Fri, 23 Aug 2024 18:09:54 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] Revert "spi: ppc4xx: handle
 irq_of_parse_and_map() errors"
Message-ID: <ZsimQuIJuNNIqn09@smile.fi.intel.com>
References: <20240819195029.2388397-1-andriy.shevchenko@linux.intel.com>
 <f71823fb-4b9a-430a-92cc-0b9df446ce3f@sirena.org.uk>
 <ZsTH2cTcWQG9ltub@smile.fi.intel.com>
 <f00bd6e2-19f1-45dd-8899-0f178196079e@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f00bd6e2-19f1-45dd-8899-0f178196079e@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Aug 20, 2024 at 06:11:26PM +0100, Mark Brown wrote:
> On Tue, Aug 20, 2024 at 07:44:09PM +0300, Andy Shevchenko wrote:
> > On Tue, Aug 20, 2024 at 12:20:30PM +0100, Mark Brown wrote:
> 
> > > Please submit patches using subject lines reflecting the style for the
> > > subsystem, this makes it easier for people to identify relevant patches.
> > > Look at what existing commits in the area you're changing are doing and
> > > make sure your subject lines visually resemble what they're doing.
> > > There's no need to resubmit to fix this alone.
> 
> > This is a pure and clean revert, not sure if we need to hide that fact.
> 
> This is not an issue with the word "revert", it is an issue with the
> formatting of the subject line.

So, should I send a v2?

-- 
With Best Regards,
Andy Shevchenko



