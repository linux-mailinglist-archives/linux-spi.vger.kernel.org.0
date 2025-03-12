Return-Path: <linux-spi+bounces-7104-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54372A5E879
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 00:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 800D917C3EC
	for <lists+linux-spi@lfdr.de>; Wed, 12 Mar 2025 23:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CB51F0E38;
	Wed, 12 Mar 2025 23:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SvDnWki8"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025661DE894;
	Wed, 12 Mar 2025 23:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741822518; cv=none; b=SZIaYhO9YKNt5uhjMWr0MdTW4XeWFplv3Gv8X+zX8frh684BrUXJ3N+uJ0kdzH+P2aw6L6nDEtu3b2XImlipJSWI5BVpD6Y3uGbMeqgfFLRmhDPGg3Di6U7H00hz7u8B6UtjtPZt/dzkTWixBtyY14wRzSmUUJ0VB/lK8lFAqm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741822518; c=relaxed/simple;
	bh=Ku5BAxzw7yeD0n1kP8klsjqCryKh3vE53wmmHsDd0fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtUiYodPNBROb47pf8cgjSRpD/8wIfb+c4HCEIEUrwXYdTSFRAOp3q+bOHMH7qu8s/FsK1SqqWwkj6s1KDmsPvNkNLSCd5GMLILo8oZJeURsZ6H1PvDcbKIbZEwiXMN9fLdi3f0XBpBB15y/ACvZZ8rbBtcjEKyzKtd2Ro04k1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SvDnWki8; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741822517; x=1773358517;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ku5BAxzw7yeD0n1kP8klsjqCryKh3vE53wmmHsDd0fo=;
  b=SvDnWki80AWrTwmD/ZgVWKyI1DBMusg17H5o3iJXL68tXrcVMIpdAR4i
   h1J2QLR4eTx0zhPOOy5ZA3wquoADqKTZJ0WanWuB2m41VYcy30mnzG63x
   /6F6aCjfOmjPEANy78UGdE3kKazh7EcA0Yc07anRUKyBb0iNA0Vs6M07y
   O/iv+tMKLAI0a5jug06GLiXL2xBp3QKCcvtNHL4y8wNqwPMkmFXD+OlF7
   FQzQq+Vs3eGfhpOTIU6n7muEiXTj/DaR15kS19hyz2l8veEHJFVSD+rcU
   MWzY+yBsIM3tcgPqQv1OqWjXXPa8eOY7Yl30MVrHlHsgPm/q7DJ9iGQVZ
   w==;
X-CSE-ConnectionGUID: p2pDMhgzSh6JyncD0rwLsg==
X-CSE-MsgGUID: XB/XqVUoS+KI/tU80xTPTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42092012"
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="42092012"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 16:35:16 -0700
X-CSE-ConnectionGUID: HMB0tQllT6i39iMvpaPh0w==
X-CSE-MsgGUID: QJezwdF3SJiICTyF7ycbLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="125404554"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 12 Mar 2025 16:35:14 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tsVbS-0008ya-0t;
	Wed, 12 Mar 2025 23:35:10 +0000
Date: Thu, 13 Mar 2025 07:34:50 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Longbin Li <looong.bin@gmail.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 1/2] spi: sg2044-nor: Fully convert to device managed
 resources
Message-ID: <202503130708.AmtUDVfq-lkp@intel.com>
References: <20250312172016.4070094-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312172016.4070094-2-andriy.shevchenko@linux.intel.com>

Hi Andy,

kernel test robot noticed the following build errors:

[auto build test ERROR on broonie-spi/for-next]
[cannot apply to linus/master v6.14-rc6 next-20250312]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/spi-sg2044-nor-Fully-convert-to-device-managed-resources/20250313-012347
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20250312172016.4070094-2-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v1 1/2] spi: sg2044-nor: Fully convert to device managed resources
config: sh-allyesconfig (https://download.01.org/0day-ci/archive/20250313/202503130708.AmtUDVfq-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250313/202503130708.AmtUDVfq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503130708.AmtUDVfq-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/spi/spi-sg2044-nor.c: In function 'sg2044_spifmc_probe':
>> drivers/spi/spi-sg2044-nor.c:459:44: error: macro "devm_mutex_init" requires 2 arguments, but only 1 given
     459 |         ret = devm_mutex_init(&spifmc->lock);
         |                                            ^
   In file included from include/linux/notifier.h:14,
                    from include/linux/clk.h:14,
                    from drivers/spi/spi-sg2044-nor.c:9:
   include/linux/mutex.h:144:9: note: macro "devm_mutex_init" defined here
     144 | #define devm_mutex_init(dev, mutex)                     \
         |         ^~~~~~~~~~~~~~~
>> drivers/spi/spi-sg2044-nor.c:459:15: error: 'devm_mutex_init' undeclared (first use in this function)
     459 |         ret = devm_mutex_init(&spifmc->lock);
         |               ^~~~~~~~~~~~~~~
   drivers/spi/spi-sg2044-nor.c:459:15: note: each undeclared identifier is reported only once for each function it appears in


vim +/devm_mutex_init +459 drivers/spi/spi-sg2044-nor.c

   425	
   426	static int sg2044_spifmc_probe(struct platform_device *pdev)
   427	{
   428		struct spi_controller *ctrl;
   429		struct sg2044_spifmc *spifmc;
   430		void __iomem *base;
   431		int ret;
   432	
   433		ctrl = devm_spi_alloc_host(&pdev->dev, sizeof(*spifmc));
   434		if (!ctrl)
   435			return -ENOMEM;
   436	
   437		spifmc = spi_controller_get_devdata(ctrl);
   438	
   439		spifmc->clk = devm_clk_get_enabled(&pdev->dev, NULL);
   440		if (IS_ERR(spifmc->clk))
   441			return dev_err_probe(&pdev->dev, PTR_ERR(spifmc->clk),
   442					     "%s: Cannot get and enable AHB clock\n",
   443					     __func__);
   444	
   445		spifmc->dev = &pdev->dev;
   446		spifmc->ctrl = ctrl;
   447	
   448		spifmc->io_base = devm_platform_ioremap_resource(pdev, 0);
   449		if (IS_ERR(base))
   450			return PTR_ERR(base);
   451	
   452		ctrl->num_chipselect = 1;
   453		ctrl->dev.of_node = pdev->dev.of_node;
   454		ctrl->bits_per_word_mask = SPI_BPW_MASK(8);
   455		ctrl->auto_runtime_pm = false;
   456		ctrl->mem_ops = &sg2044_spifmc_mem_ops;
   457		ctrl->mode_bits = SPI_RX_DUAL | SPI_TX_DUAL | SPI_RX_QUAD | SPI_TX_QUAD;
   458	
 > 459		ret = devm_mutex_init(&spifmc->lock);
   460		if (ret)
   461			return ret;
   462	
   463		sg2044_spifmc_init(spifmc);
   464		sg2044_spifmc_init_reg(spifmc);
   465	
   466		ret = devm_spi_register_controller(&pdev->dev, ctrl);
   467		if (ret) {
   468			dev_err(&pdev->dev, "spi_register_controller failed\n");
   469			return ret;
   470		}
   471	
   472		return 0;
   473	}
   474	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

