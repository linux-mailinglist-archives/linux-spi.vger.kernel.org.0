Return-Path: <linux-spi+bounces-5024-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE5F989281
	for <lists+linux-spi@lfdr.de>; Sun, 29 Sep 2024 03:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5BB61F230FC
	for <lists+linux-spi@lfdr.de>; Sun, 29 Sep 2024 01:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F54C147;
	Sun, 29 Sep 2024 01:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LGqrQhT1"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A8FC148;
	Sun, 29 Sep 2024 01:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727574013; cv=none; b=T2nBjhB5awuCC/Dr1EyCcR1SYhlOVqcP0Z3e4uF7esgM8ijPKJqxFSXGnyTUxkt2wR16E04GvLSgIE4eC1lmJH6Xma5B4dbPJLgKdfMBJM0j/j1RPrb1tp8Dz7UWbeJ5KBbADe6XDm9zVS+B1a5LVqZBa3+UnfeLj3R01YIAQBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727574013; c=relaxed/simple;
	bh=r8YEm82IiDRZTCkCh879m0xJ5xKM7guPvEFt/0AzZZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+Wp2qUnWFKwNijrhxJPM27hjLNQVkyVCjKbLcUhRZg633vu6hd25qSrddOQBSSEsTOud8mQIp6lHqUq/UqiGup63kNph/4uWmeKEbIISnBoP4mB7pxFml+Rj/6BxwJfKM2UWJOTrcREYM/NJURUXyFQtYIAZci1ZxdFL5BWsvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LGqrQhT1; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727574012; x=1759110012;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r8YEm82IiDRZTCkCh879m0xJ5xKM7guPvEFt/0AzZZk=;
  b=LGqrQhT1AII8BOfxScwYakNkpJXaQ3dAmUXWcgfgDj0g9zLhYoiVZp6X
   1B3RxOWRZbuSW5Gs6PVmo4munAz1Hf38ajVossjlboA/O5NVxQO9O+ken
   y8EJPNEfhaU8yURgNxAIYG1KTSGFkXBxQgdBa1J1Qg5w/4P2atRkLleK3
   UP7m/SdhlDw/zwagGyVFJ4d67/tbO2WTP5d7mR442M5PNFAG/Jz3rTMzD
   S6IGrfjkYBrvg+U8k1qaaJK0ze8qKfUF2ypR/sy0LDvkvuhHSldW3XnOU
   sqTHK6+B60SxR8uqh11lcVEqjtTBSC8o47D9EhlVaOZu0ToI0L+r603xf
   w==;
X-CSE-ConnectionGUID: 4mewzjOCRoK04q0jAhcKwQ==
X-CSE-MsgGUID: +FThr1RyQ2mSUaXzUIvYFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11209"; a="37267830"
X-IronPort-AV: E=Sophos;i="6.11,162,1725346800"; 
   d="scan'208";a="37267830"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2024 18:40:11 -0700
X-CSE-ConnectionGUID: lMzoxijmS/+sF1p2iiTmDA==
X-CSE-MsgGUID: CcN8ldiURtmkZQOohAIF0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,162,1725346800"; 
   d="scan'208";a="103702516"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 28 Sep 2024 18:40:08 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1suius-000Non-0T;
	Sun, 29 Sep 2024 01:40:06 +0000
Date: Sun, 29 Sep 2024 09:39:08 +0800
From: kernel test robot <lkp@intel.com>
To: Dragan Simic <dsimic@manjaro.org>, linux-spi@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, broonie@kernel.org, heiko@sntech.de,
	gregkh@linuxfoundation.org, rafael@kernel.org, oss@helene.moe,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] driver core: Add device probe log helper
 dev_warn_probe()
Message-ID: <202409290956.jwLrcN1S-lkp@intel.com>
References: <2fd9a60e0efe906dc7a203cd652c8d0b7f932470.1727496560.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fd9a60e0efe906dc7a203cd652c8d0b7f932470.1727496560.git.dsimic@manjaro.org>

Hi Dragan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rockchip/for-next]
[also build test WARNING on broonie-spi/for-next driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus linus/master v6.11 next-20240927]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dragan-Simic/spi-rockchip-Perform-trivial-code-cleanups/20240928-121548
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
patch link:    https://lore.kernel.org/r/2fd9a60e0efe906dc7a203cd652c8d0b7f932470.1727496560.git.dsimic%40manjaro.org
patch subject: [PATCH v2 4/5] driver core: Add device probe log helper dev_warn_probe()
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20240929/202409290956.jwLrcN1S-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240929/202409290956.jwLrcN1S-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409290956.jwLrcN1S-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/base/core.c: In function 'dev_err_probe':
>> drivers/base/core.c:5055:1: warning: control reaches end of non-void function [-Wreturn-type]
    5055 | }
         | ^
   drivers/base/core.c: In function 'dev_warn_probe':
   drivers/base/core.c:5101:1: warning: control reaches end of non-void function [-Wreturn-type]
    5101 | }
         | ^


vim +5055 drivers/base/core.c

  5011	
  5012	/**
  5013	 * dev_err_probe - probe error check and log helper
  5014	 * @dev: the pointer to the struct device
  5015	 * @err: error value to test
  5016	 * @fmt: printf-style format string
  5017	 * @...: arguments as specified in the format string
  5018	 *
  5019	 * This helper implements common pattern present in probe functions for error
  5020	 * checking: print debug or error message depending if the error value is
  5021	 * -EPROBE_DEFER and propagate error upwards.
  5022	 * In case of -EPROBE_DEFER it sets also defer probe reason, which can be
  5023	 * checked later by reading devices_deferred debugfs attribute.
  5024	 * It replaces the following code sequence::
  5025	 *
  5026	 * 	if (err != -EPROBE_DEFER)
  5027	 * 		dev_err(dev, ...);
  5028	 * 	else
  5029	 * 		dev_dbg(dev, ...);
  5030	 * 	return err;
  5031	 *
  5032	 * with::
  5033	 *
  5034	 * 	return dev_err_probe(dev, err, ...);
  5035	 *
  5036	 * Using this helper in your probe function is totally fine even if @err
  5037	 * is known to never be -EPROBE_DEFER.
  5038	 * The benefit compared to a normal dev_err() is the standardized format
  5039	 * of the error code, which is emitted symbolically (i.e. you get "EAGAIN"
  5040	 * instead of "-35"), and having the error code returned allows more
  5041	 * compact error paths.
  5042	 *
  5043	 * Returns @err.
  5044	 */
  5045	int dev_err_probe(const struct device *dev, int err, const char *fmt, ...)
  5046	{
  5047		va_list args;
  5048	
  5049		va_start(args, fmt);
  5050	
  5051		/* Use dev_err() for logging when err doesn't equal -EPROBE_DEFER */
  5052		dev_probe_failed(dev, err, true, fmt, args);
  5053	
  5054		va_end(args);
> 5055	}
  5056	EXPORT_SYMBOL_GPL(dev_err_probe);
  5057	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

