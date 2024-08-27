Return-Path: <linux-spi+bounces-4331-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3598F96017D
	for <lists+linux-spi@lfdr.de>; Tue, 27 Aug 2024 08:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0DDD2818C9
	for <lists+linux-spi@lfdr.de>; Tue, 27 Aug 2024 06:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3841448E0;
	Tue, 27 Aug 2024 06:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CgRs9408"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3502113DB99;
	Tue, 27 Aug 2024 06:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724739782; cv=none; b=PFMHPH9PWMZyuT864IYL/OQyuabUS7RugOTcky9u4k8FY5nEjqOtNF72bUcHH1NKkYkxNvNJ4vbyWnUoZmvwjTLZ+HTtddDUETdvEWqlvB5yBTUr7clKSZdaS0QJYud+fZIS8O1CYWltp/rwZopnL+4Pddxn/GESAPd0NxdiYZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724739782; c=relaxed/simple;
	bh=sjyWgZeGfHgwkuBWTUfyr58uBeXYxYz+Nt1GMaQKmV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzJ+6UN+ZSidRCqerCK0Pqo/hNWl5+gPIoZyAZdSkWkVdznZ8WDQYdNj1bvNR22hgafI7QJtBnA3b4VNFuzGFvqzLDLd2eHPv77FTb8zXYkmV3HCv+lTki0+qXCaFztRKePmVE+nkWyLIn8TQ2X5vE2z8DHLYwjIGwLWzQF9VYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CgRs9408; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724739781; x=1756275781;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sjyWgZeGfHgwkuBWTUfyr58uBeXYxYz+Nt1GMaQKmV0=;
  b=CgRs9408iiGBeEoshx02sSRDabTOI9zTxpcgbTNkky/4sishumHEPbZe
   B767UXGuJ0HUZYIhDiqFsDwnvkAXZYkXk37qxOE/Wq+8rdcrh7YVR6d3o
   HzU4RxDB+NpQZTRFYWvzLqK73NTpk9LEI2skOCoLVn/p+Y7bhWlwmubZM
   +dWeCZrtKx5RMdNNHXY2SsLqmMtWu+m8mzAASCW6a0NKd3CcO+SCMsHwQ
   FDlU6FcRTzzRZWHoRW48k9HT3s2awPXeUGsTU2y7lqoLLaXuImt8SKOqR
   kzxXCHUuhMk7PXXJmORPkzQkCu9pYnXcmh05ru4vXmyO2UfabNDBOWw0E
   w==;
X-CSE-ConnectionGUID: q1SrjWXbSYSKAO7VpizWjA==
X-CSE-MsgGUID: tWH3pqcWRRCC16lIpJLUog==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="33821574"
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="33821574"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 23:23:01 -0700
X-CSE-ConnectionGUID: EgCJSd8CRbawrLjie8jyrw==
X-CSE-MsgGUID: TiixJNvQRGGOiH+t8POUPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="62589117"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 26 Aug 2024 23:22:58 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sipbT-000I86-1q;
	Tue, 27 Aug 2024 06:22:55 +0000
Date: Tue, 27 Aug 2024 14:22:33 +0800
From: kernel test robot <lkp@intel.com>
To: Brian Norris <briannorris@chromium.org>,
	Mark Brown <broonie@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	=?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
	Brian Norris <briannorris@chromium.org>, stable@vger.kernel.org,
	Heiko Stuebner <heiko@sntech.de>, Jon Lin <jon.lin@rock-chips.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-spi@vger.kernel.org,
	shengfei Xu <xsf@rock-chips.com>
Subject: Re: [PATCH] spi: rockchip: Resolve unbalanced runtime PM / system PM
 handling
Message-ID: <202408271225.Zh4Kc31M-lkp@intel.com>
References: <20240823214235.1718769-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823214235.1718769-1-briannorris@chromium.org>

Hi Brian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rockchip/for-next]
[also build test WARNING on broonie-sound/for-next broonie-spi/for-next linus/master v6.11-rc5 next-20240826]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Brian-Norris/spi-rockchip-Resolve-unbalanced-runtime-PM-system-PM-handling/20240826-135245
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
patch link:    https://lore.kernel.org/r/20240823214235.1718769-1-briannorris%40chromium.org
patch subject: [PATCH] spi: rockchip: Resolve unbalanced runtime PM / system PM handling
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20240827/202408271225.Zh4Kc31M-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240827/202408271225.Zh4Kc31M-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408271225.Zh4Kc31M-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/spi/spi-rockchip.c: In function 'rockchip_spi_suspend':
>> drivers/spi/spi-rockchip.c:948:30: warning: unused variable 'rs' [-Wunused-variable]
     948 |         struct rockchip_spi *rs = spi_controller_get_devdata(ctlr);
         |                              ^~
   drivers/spi/spi-rockchip.c: In function 'rockchip_spi_resume':
   drivers/spi/spi-rockchip.c:969:30: warning: unused variable 'rs' [-Wunused-variable]
     969 |         struct rockchip_spi *rs = spi_controller_get_devdata(ctlr);
         |                              ^~


vim +/rs +948 drivers/spi/spi-rockchip.c

64e36824b32b06 addy ke      2014-07-01  942  
64e36824b32b06 addy ke      2014-07-01  943  #ifdef CONFIG_PM_SLEEP
64e36824b32b06 addy ke      2014-07-01  944  static int rockchip_spi_suspend(struct device *dev)
64e36824b32b06 addy ke      2014-07-01  945  {
43de979ddc099c Jeffy Chen   2017-08-07  946  	int ret;
d66571a20f68f1 Chris Ruehl  2020-05-11  947  	struct spi_controller *ctlr = dev_get_drvdata(dev);
e882575efc771f shengfei Xu  2022-02-16 @948  	struct rockchip_spi *rs = spi_controller_get_devdata(ctlr);
64e36824b32b06 addy ke      2014-07-01  949  
d66571a20f68f1 Chris Ruehl  2020-05-11  950  	ret = spi_controller_suspend(ctlr);
43de979ddc099c Jeffy Chen   2017-08-07  951  	if (ret < 0)
64e36824b32b06 addy ke      2014-07-01  952  		return ret;
64e36824b32b06 addy ke      2014-07-01  953  
8d3fb5bc7d0206 Brian Norris 2024-08-23  954  	ret = pm_runtime_force_suspend(dev);
8d3fb5bc7d0206 Brian Norris 2024-08-23  955  	if (ret < 0) {
8d3fb5bc7d0206 Brian Norris 2024-08-23  956  		spi_controller_resume(ctlr);
8d3fb5bc7d0206 Brian Norris 2024-08-23  957  		return ret;
8d3fb5bc7d0206 Brian Norris 2024-08-23  958  	}
64e36824b32b06 addy ke      2014-07-01  959  
23e291c2e4c84a Brian Norris 2016-12-16  960  	pinctrl_pm_select_sleep_state(dev);
23e291c2e4c84a Brian Norris 2016-12-16  961  
43de979ddc099c Jeffy Chen   2017-08-07  962  	return 0;
64e36824b32b06 addy ke      2014-07-01  963  }
64e36824b32b06 addy ke      2014-07-01  964  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

