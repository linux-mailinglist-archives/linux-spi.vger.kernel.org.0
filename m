Return-Path: <linux-spi+bounces-3322-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5F18FE491
	for <lists+linux-spi@lfdr.de>; Thu,  6 Jun 2024 12:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D63F02877A8
	for <lists+linux-spi@lfdr.de>; Thu,  6 Jun 2024 10:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBC62E639;
	Thu,  6 Jun 2024 10:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NSPt4rt6"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1F6153821;
	Thu,  6 Jun 2024 10:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717670913; cv=none; b=HdpRjXsrL+6wJux1e918hDiI5YTJYZ7B+1h0LOeFQ+Ry5YeMNK9eZF2t7cJapKEn6Sc0+B4xpI6qULDI1S9ODEgHJDWyRrpZSg1/F2l9qtHs/P1xBHrP1+Lvqzvb1LKhrjm1+iilXuX1CPSC/wuivYJW7IwpwjpNJMHU6IliDrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717670913; c=relaxed/simple;
	bh=U057boMQPxwkgWK5fGHqeQf7D1HQxRQvNMEp4zZXb08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o24EPhm882pfQFEP+GCn8DQw9aF0KA01BM2gkmz/aPjL5lFMBK9O0hI4GUIMfLifaKn5sgtBrTcE/Y1A+UvGqSKmlu6yhRbt0f+ag/2FLHQv0k3wxh5bJDK+GdAxWITBfSg3PRJBCyGJ5i4vb+9IOxqE8awRE5usmUvXomHGyo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NSPt4rt6; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717670913; x=1749206913;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U057boMQPxwkgWK5fGHqeQf7D1HQxRQvNMEp4zZXb08=;
  b=NSPt4rt64WCnTpq44GA+4Bw1fywStbXBpBAYOJzIDLAE9rfFmBNPHLsM
   edgxvRf5jCJBJCdvK5MHUKrHOTihfVKLCFHElo5efNgU0hgqUFOZ8kLpz
   l3I5OWWZSRoHHHvWQqxXzoWvC8PhqR/oo6tfPVnukv8djtKcYhHPsvafH
   s6ahP8V1lxOmCAvTuDoj7phNJOY30lnl4DK3p2tXJgb4uthA9bcI82cu0
   2bVMPnxgp+0ZuZBVI7jUSCbAm+TcejUxFcJ95LXzyLnAlD6ZPa1R+v7X6
   ZMiMCpHdaTg5Zt2pFh1qpFgHWzutrcpeAxAaYR3Da1FYTf0WRv8zIZINz
   Q==;
X-CSE-ConnectionGUID: vdBFN634SBKeAPT3oT8cxg==
X-CSE-MsgGUID: 14yMy9jJSI+JxVJciSN28Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="14285917"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="14285917"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 03:48:31 -0700
X-CSE-ConnectionGUID: Fj53rVtsTpi2+p54PfEuLQ==
X-CSE-MsgGUID: hKB9VFaTQw2XudfV+qGojg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="42855333"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 03:48:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sFAfT-0000000E8em-1rmW;
	Thu, 06 Jun 2024 13:48:27 +0300
Date: Thu, 6 Jun 2024 13:48:27 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] spi: gpio: Make num_chipselect 8-bit in the
 struct spi_gpio_platform_data
Message-ID: <ZmGT-7eM1gYhd-0e@smile.fi.intel.com>
References: <20240517194246.747427-1-andriy.shevchenko@linux.intel.com>
 <20240517194246.747427-4-andriy.shevchenko@linux.intel.com>
 <ce75b03e-e061-43ac-94fa-1539c8fe6203@sirena.org.uk>
 <ZksXrM-W_69e5q2m@smile.fi.intel.com>
 <ZmDUBHUyy1uozcn2@smile.fi.intel.com>
 <c7ba4e75-0577-487c-9e79-e8693bd66de9@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7ba4e75-0577-487c-9e79-e8693bd66de9@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Jun 05, 2024 at 10:22:44PM +0100, Mark Brown wrote:
> On Thu, Jun 06, 2024 at 12:09:24AM +0300, Andy Shevchenko wrote:
> 
> > Should I do something about the first two patches or is it fine to get them in?

Found them, it's just an announce is missing.
Thanks!

-- 
With Best Regards,
Andy Shevchenko



