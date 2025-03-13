Return-Path: <linux-spi+bounces-7105-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD28A5E919
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 01:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA4577AB901
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 00:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2316EFC0B;
	Thu, 13 Mar 2025 00:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b+7YeKLa"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6327411CA9;
	Thu, 13 Mar 2025 00:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741827141; cv=none; b=TXaWgLV34nyFqoy5v07eSyLZTTZQo2aPWq4jvIC6y7P/aUqVoSVpZtZtUPpXJyzb+U4XpAKADw5QrT3V1tJ1lUDqL9B+K4F8WlssSsRuzDksIXlQLkNwQLD5tZGGYXX8o/xvKSY5b/1p313wOoJ2zmN49X/7GAJBioZIzwx6nyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741827141; c=relaxed/simple;
	bh=2HBnjGG9f2yzjZImRHG1ni8/0sMHCSwJPmWWfwr9lsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dr2Bs8AcqURokgQ7bNc8/Z0WDfjoj74V5RFKT1zsKgUXpaVVdPTs1Viuj3hZegQKELplqgKYUA+Wmn7JTWAqo+dMZWXXwShymTgNEcU4k672XyunJ8dSfNE3Lhl1rSDu9TGTgX/i3gutOLOluAy4pTeMEQFEia0ytFx0XWKXbY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b+7YeKLa; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741827139; x=1773363139;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2HBnjGG9f2yzjZImRHG1ni8/0sMHCSwJPmWWfwr9lsQ=;
  b=b+7YeKLa2BcZGU+w3UDX9GvCK89ZRKYkyMx2GZ2bwoB5XgjQuX9rJ0Ma
   CcJCvNepGWSSj8ZPxhcqa5aOi6I24njeio72aDzHwMQiwd5G+TvWg5XL2
   kLurkJ8yBzmbtiQSQjIb5zG318+COfscMLdi4j/2paXdHk1cyG4JFaiNo
   bJ6gIS/3c5ml6E+GOSHbueJijcm3jWC0rBku+DzipyMfDz0BIq8gfsWKU
   0gRs3lQtafmfUGV5kNpvGIzo/gWQV/nTpgOjAoe3QEa4g/E7Eod0lHaSr
   u6Xd10tDzWupN+ByIrM+a/e2wCkDHf7N2/y4zflPR82QVEWrZBVNe4CWS
   Q==;
X-CSE-ConnectionGUID: olEZPyKtQvupDtBduXO8Xg==
X-CSE-MsgGUID: wUvY+Fa/TmmGaYzrY/IAGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="30517892"
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="30517892"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 17:52:19 -0700
X-CSE-ConnectionGUID: +jomK16XRs+7Q54rMkHXHQ==
X-CSE-MsgGUID: mH65KXmARJCri59WIbO6Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="124963133"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 12 Mar 2025 17:52:16 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tsWo2-00091K-2f;
	Thu, 13 Mar 2025 00:52:14 +0000
Date: Thu, 13 Mar 2025 08:51:17 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Longbin Li <looong.bin@gmail.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 1/2] spi: sg2044-nor: Fully convert to device managed
 resources
Message-ID: <202503130819.4zfx3AKS-lkp@intel.com>
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
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20250313/202503130819.4zfx3AKS-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250313/202503130819.4zfx3AKS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503130819.4zfx3AKS-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/spi/spi-sg2044-nor.c:11:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:181:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2224:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/spi/spi-sg2044-nor.c:459:37: error: too few arguments provided to function-like macro invocation
     459 |         ret = devm_mutex_init(&spifmc->lock);
         |                                            ^
   include/linux/mutex.h:144:9: note: macro 'devm_mutex_init' defined here
     144 | #define devm_mutex_init(dev, mutex)                     \
         |         ^
>> drivers/spi/spi-sg2044-nor.c:459:8: error: use of undeclared identifier 'devm_mutex_init'; did you mean '__devm_mutex_init'?
     459 |         ret = devm_mutex_init(&spifmc->lock);
         |               ^~~~~~~~~~~~~~~
         |               __devm_mutex_init
   include/linux/mutex.h:129:5: note: '__devm_mutex_init' declared here
     129 | int __devm_mutex_init(struct device *dev, struct mutex *lock);
         |     ^
   3 warnings and 2 errors generated.


vim +459 drivers/spi/spi-sg2044-nor.c

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

