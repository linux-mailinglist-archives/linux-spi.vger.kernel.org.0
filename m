Return-Path: <linux-spi+bounces-7108-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 420FAA5EF6E
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 10:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BF211897AAE
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 09:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2B3263C8A;
	Thu, 13 Mar 2025 09:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OdfMcqrK"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1166D1FA14E;
	Thu, 13 Mar 2025 09:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741857647; cv=none; b=l2s5Objt+BssVkHb2cts0Gp+njUdiCFvg/aPAEocb3lMt9IfuaU4XozaCUcWXFMtGDXJgye0IEPuxE42a+HNBMtcBuJwB6tRcu9Ns8z6ntxNTwxZO5XGSlymPQghNA6OhnblcL+APJRJ2Pu+uPv+c5SWNBDZ6Uetz+dIwQfKp8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741857647; c=relaxed/simple;
	bh=aOaVRhsJoHJssf1SasDIjbcmYABF1qsyZ0Gh81rOTM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jy9La//5FYc9jSxFOxJHdArm4sifgI1yVaD9upITBRWAfvGafvrh+XRJWMQJeAG8mQ/d3cTLR+FXJVyusB1rpCPMzkr3j2cO6Po36UzNtVdu/S1PtXFWrwdRZ2nZIA0vdS05X45nXmLXVlQsCgxjAWhh7yevAlS9bzUsPd2QBbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OdfMcqrK; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741857646; x=1773393646;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aOaVRhsJoHJssf1SasDIjbcmYABF1qsyZ0Gh81rOTM4=;
  b=OdfMcqrK3GVuuDad2JYE8+S9pF/ln2ed+PzautsoxI6/9t2KvmBNGzLQ
   ERjNZJ8/zZENK8u8y/t92jP8YHuetRevpmKNHJ+QgeClbft93SkmhkW/h
   iEJ7mIGOW/cZVaQQnnYiK1SaMMImwX3RM8ORCU/YUJJpbAwaxhIRQQsbd
   5iojhf1hPYsy5/fhx9i0klNUYc4aEcG5GTHR/7oQkSCZaa3WXYVcjn6QL
   xqjeVPS1tg3B1tmT9ZCqOwKweS6hEbhmFOP6AxyZ8zn7xWt1tam0LPaUQ
   Sufc9VBNX/fOj/ABx4SC+0tcVIoePVQESFBUS3P1n9pZmRfE88nhXW87q
   A==;
X-CSE-ConnectionGUID: 4IPIoUTVSGmaACWvhiXC4Q==
X-CSE-MsgGUID: GfAq4QBbTk6OD56Fhhqa2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="53612739"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="53612739"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 02:20:45 -0700
X-CSE-ConnectionGUID: QfILyGOYSZ+hKJI87ayHLQ==
X-CSE-MsgGUID: phAPCN/TRruKPJZoOFa0+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="121598319"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 02:20:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tsek5-0000000283c-0vLW;
	Thu, 13 Mar 2025 11:20:41 +0200
Date: Thu, 13 Mar 2025 11:20:40 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: kernel test robot <lkp@intel.com>
Cc: Longbin Li <looong.bin@gmail.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 1/2] spi: sg2044-nor: Fully convert to device managed
 resources
Message-ID: <Z9KjaFIO1slBsi8R@smile.fi.intel.com>
References: <20250312172016.4070094-2-andriy.shevchenko@linux.intel.com>
 <202503130708.AmtUDVfq-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202503130708.AmtUDVfq-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 13, 2025 at 07:34:50AM +0800, kernel test robot wrote:
> Hi Andy,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on broonie-spi/for-next]
> [cannot apply to linus/master v6.14-rc6 next-20250312]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/spi-sg2044-nor-Fully-convert-to-device-managed-resources/20250313-012347
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
> patch link:    https://lore.kernel.org/r/20250312172016.4070094-2-andriy.shevchenko%40linux.intel.com
> patch subject: [PATCH v1 1/2] spi: sg2044-nor: Fully convert to device managed resources
> config: sh-allyesconfig (https://download.01.org/0day-ci/archive/20250313/202503130708.AmtUDVfq-lkp@intel.com/config)
> compiler: sh4-linux-gcc (GCC) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250313/202503130708.AmtUDVfq-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202503130708.AmtUDVfq-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):

Oh, indeed, missed the compilation of this module somehow.
Will be fixed in v2, thanks!

-- 
With Best Regards,
Andy Shevchenko



