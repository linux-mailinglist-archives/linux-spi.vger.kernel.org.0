Return-Path: <linux-spi+bounces-3323-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 052568FE493
	for <lists+linux-spi@lfdr.de>; Thu,  6 Jun 2024 12:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 055C41C258A4
	for <lists+linux-spi@lfdr.de>; Thu,  6 Jun 2024 10:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B7E18C33C;
	Thu,  6 Jun 2024 10:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F3XVhUhl"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACC32E639;
	Thu,  6 Jun 2024 10:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717670958; cv=none; b=LwRqn0JdZ9WhBbPMHHT6lWUoXoUb6R7FAPaPDq4zjlcNSiNMxHIq6+AK82I0u/lIxzvH7EInk7dG1Zf+vkmJPHPwX8Uzg62rYTKbb6jPAABqP8GIOFHDksq8kh1TciPMYV13BrcoHjPgizLWxliQCSxnqcRhHPA8vept4vQusGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717670958; c=relaxed/simple;
	bh=f6ONOoGAzNW7X3mpKS/vgYlpM/e3LHFdg+HdVppRMsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxwyfLsR1kGm09gy7MpTCcGUehhUhmQnq4lBCQBk4F27FhpEjHPSKHB/8tgqQTVMUTlCpn7KdZEZlQ4Jz6cXP04drrScAAK9BUk8v9WCIyIaH8hj3gqsU2Z3d8+YIXIQzpdl0I3pqIG+QjmP+I1zHgWuQKXL9m0yAGQL7tyP5XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F3XVhUhl; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717670957; x=1749206957;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f6ONOoGAzNW7X3mpKS/vgYlpM/e3LHFdg+HdVppRMsw=;
  b=F3XVhUhlF1NuDWeC4QpY71F5Jsk5t6294xu3w9w8Jn3b0WU2FmtRJytK
   S4sH+W6v+gasx1rVZ0hubXDG6d7VLpuWbB19smVRawakqtlVn0zYCB08c
   LhmwZTx1epMyhj7cfprpR22fYWmh0L/qqt6ImdR1J0o6hvAbZB4WSjzpC
   v5pRfbd9D8UzUf7YsPcn20qORNomJIORCHXxP6TA+jQMy5FD9Xqacd3MU
   UaH5f3Yt3ck3FHx16RVzGHF7MjmSZeIrBStvtdxbZyEQSh6e51phUF/tY
   duGUUPiX58GRP6gkXL1Rab1KbVkvWWX8KnPo/6xyeoTBezcIRuQSpQzBu
   A==;
X-CSE-ConnectionGUID: YPodp+t8T4OeJ0ci+jtLCw==
X-CSE-MsgGUID: YdKkXUIRRoauPxC5fSoPTA==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="14464344"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="14464344"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 03:49:17 -0700
X-CSE-ConnectionGUID: VslGK0pOQ42jRL8nyos0vQ==
X-CSE-MsgGUID: CqVghhPhTE61so9RPEid+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="69088405"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 03:49:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sFAgD-0000000E8gB-2Uqx;
	Thu, 06 Jun 2024 13:49:13 +0300
Date: Thu, 6 Jun 2024 13:49:13 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] spi: Refactor spi_stop_queue()
Message-ID: <ZmGUKQZuNdXfvRcz@smile.fi.intel.com>
References: <20240510204945.2581944-1-andriy.shevchenko@linux.intel.com>
 <ZmDTuqMTR-KiUyVO@smile.fi.intel.com>
 <58c2f209-1553-46ec-a471-2f33afb20139@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58c2f209-1553-46ec-a471-2f33afb20139@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Jun 05, 2024 at 10:21:55PM +0100, Mark Brown wrote:
> On Thu, Jun 06, 2024 at 12:08:10AM +0300, Andy Shevchenko wrote:
> > On Fri, May 10, 2024 at 11:49:45PM +0300, Andy Shevchenko wrote:
> > > The refactoring makes code less verbose and easier to read.
> > > Besides that the binary size is also reduced, which sounds
> > > like a win-win case:
> > > 
> > >   add/remove: 0/1 grow/shrink: 2/2 up/down: 210/-226 (-16)
> > >   Function                            old     new   delta
> > >   spi_destroy_queue                    42     156    +114
> > >   spi_controller_suspend              101     197     +96
> > >   spi_unregister_controller           346     319     -27
> > >   spi_register_controller            1834    1794     -40
> > >   spi_stop_queue                      159       -    -159
> > >   Total: Before=49230, After=49214, chg -0.03%
> > 
> > Hmm... Other more recent patches went through, is this lost in cracks?

Found this, it is an announce that is missing.
Thanks!

-- 
With Best Regards,
Andy Shevchenko



