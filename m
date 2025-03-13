Return-Path: <linux-spi+bounces-7122-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CF6A5F8D5
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 15:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C63853A59DF
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 14:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87349266F03;
	Thu, 13 Mar 2025 14:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J59mzNUm"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC7586337;
	Thu, 13 Mar 2025 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741877183; cv=none; b=frX/astY/jWRhXpQ4yBrwby0cb9KAtmeUsz1oCMBwnsK+FOwY0vY/e462RBwgfj2oeIRe4eXu9BAsGPjnqld8tpno7i+OpDFNsEkMXZXLYCXtHaFB7Jutm2eWrpZO6lqhoqZ8KkR4SKbE0EBvvl2kXfnWZmX/Yal1qDjg+JDfg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741877183; c=relaxed/simple;
	bh=tshyggDOde6rCy5WxES5KRnyBHK98eY57xGucW/T14k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7u9XQHGZIgbu/VOmNJqCohdfEaLUHxIxnHII3qLwu5WieSlnrx+IYiozuUCHjQB7KFjiDewb01DyAs9JDA8s3qSXXWMaL9yQzBuRg+KWFRpT/ZVLr/IpmdfvCj+ICgg4/IYMqdUta3YIlwOUgeikGWNJKIZuMpG1x65hEmTF0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J59mzNUm; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741877182; x=1773413182;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tshyggDOde6rCy5WxES5KRnyBHK98eY57xGucW/T14k=;
  b=J59mzNUmu6aKO0B5e7jSChd9bf+dEKKGz27YyzeoJXM9zuoq/z/Mc9y8
   Hk7tIVcdr/veSrXBiXqgkbBsJEPK97Aox+W4OEdZfl/s5M6hbMcvwUeV4
   9Ta3Omi3NNqCoJwG7VKIKC9XOL9/ceapaW95JauAEizHjWChz3voJj+J3
   CvhgvXPWTaiweSu0+wlX1iPlIlXfvMYOfrc4Dn6QRU5k46FszfW8dGD+I
   QH9a4l6wuztv0ttNCKyHL8WU+afu6AX6aPYqsm1mbzNxvC0xIyCJ5agTt
   4w0YF5NXREYzkCrcbTteNf2a+l/Hc1Y2a1BGtnWIAB4WpN2zlfJ6tpi/s
   Q==;
X-CSE-ConnectionGUID: EuPbakHSSZ2dHqkDasi3bw==
X-CSE-MsgGUID: yoVLTT5eTX+SR8NIbF5aMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="43128154"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="43128154"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 07:46:21 -0700
X-CSE-ConnectionGUID: 6aH8UiBVQRWTl1zZCHlr5w==
X-CSE-MsgGUID: kkf6NXANQpCg4GIsyiprtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="120763387"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 07:46:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tsjpB-00000002Cuo-2dqq;
	Thu, 13 Mar 2025 16:46:17 +0200
Date: Thu, 13 Mar 2025 16:46:17 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH v1 1/1] spi: Use inclusive language
Message-ID: <Z9LvueoWc1o7ayUS@smile.fi.intel.com>
References: <20250313111442.322850-1-andriy.shevchenko@linux.intel.com>
 <1c49edb2-2ffc-419e-be5e-7e15669a7839@sirena.org.uk>
 <Z9LlTflb1HQMyEv2@smile.fi.intel.com>
 <e329812d-90a5-456e-9a00-abb5c2c8d25d@sirena.org.uk>
 <Z9LqyWr4GH4RX6Nj@smile.fi.intel.com>
 <Z9Ls-zhryd7mJv-b@smile.fi.intel.com>
 <dc17b87b-29c1-4b66-9353-c934a68b929a@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc17b87b-29c1-4b66-9353-c934a68b929a@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 13, 2025 at 02:39:27PM +0000, Mark Brown wrote:
> On Thu, Mar 13, 2025 at 04:34:35PM +0200, Andy Shevchenko wrote:
> > On Thu, Mar 13, 2025 at 04:25:13PM +0200, Andy Shevchenko wrote:
> 
> > > Yes, the base where it was merged to is eds-acpi branch of my public GH [1],
> > > which has no SPI stuff in there.
> 
> > $ git checkout -b test-spi-mrg spi/for-next
> > $ git cherry-pick -1 87a228960033
> > [test-spi-mrg 8a11d1063109] spi: Use inclusive language
> > Date: Fri Dec 8 19:02:54 2023 +0200
> > 2 files changed, 64 insertions(+), 66 deletions(-)
> 
> > In any case there is a v2, please try that one.
> 
> That one does apply.

Okay, It might be that I send the previous version by a mistake or it was based
on an old spi/for-next. Now I don't know as it's gone.

-- 
With Best Regards,
Andy Shevchenko



