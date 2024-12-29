Return-Path: <linux-spi+bounces-6200-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6ED9FDD0B
	for <lists+linux-spi@lfdr.de>; Sun, 29 Dec 2024 02:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F25C116143F
	for <lists+linux-spi@lfdr.de>; Sun, 29 Dec 2024 01:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9675B2594B6;
	Sun, 29 Dec 2024 01:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H++PT66/"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EECCEC4;
	Sun, 29 Dec 2024 01:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735435719; cv=none; b=LNEzaozRiDpcqeS1s0EpGVIBP5NIxgmWYkRMWCwqzrJsY/TQwAIyZjRZdloXNxDBemvewwTNzpbju4BwJuRHBzgq9BXd+V0YvF6vdA55s+w+VjydJMdBGI7fIyRKgvHf1/xPjswYbAh9vhfX0LQhQQCEkCSjmYGp1ETW4KheOmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735435719; c=relaxed/simple;
	bh=I7rXsmUoa6ixHAofeE9KHj410C9nn2O2m/lr/aX7Ty4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9Bps7hSOsmo8cpGHTgXz7tYhOFQuuCp+K6LzFzdBGi6UgCC4vFhqV1EI389RQPPTCEGRFQ+S8XWXwosA1FeBmJbBORO050mmpxdkIAyrVg+wha9Ud7BgO4pRE79x6k0BaWTEMic1yjIZoiIXFadnFwPjQGm2ssCshL83R5+KZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H++PT66/; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735435716; x=1766971716;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I7rXsmUoa6ixHAofeE9KHj410C9nn2O2m/lr/aX7Ty4=;
  b=H++PT66/jVIT3zu1NmgITqQpPC/Kq2kIVn0KqYCVp+qu6o0VnsPZhyHk
   zOEiIxu2J5idEd9VN9ljT6L050uXQi4T2Sl6YkYRwaO4wSO024xth+4vF
   cwBdfsxi6SzZ/ota3QillfVqbcQf9Z12L6R+fRyONtZhzOQx32RoiCZ/m
   3e0I1WqxtQEp+lIiP+L0EYDLtFK+Y8HROj/oFearp6VSFGj0m5Hu6uRkZ
   kEZqdLXA6gye6pWh9FXNk9i2d4BTIEv/I5ELJm1qFgKyroOL1h/FjE46l
   KJf+GhNB5NI+EeCfTIRLVenGQWfmrbDhy2dOMMdXnXvdBmICp/16A8Qzv
   w==;
X-CSE-ConnectionGUID: GfHZ1GpjS7aF+TVlpIVRaQ==
X-CSE-MsgGUID: Vfj9KaC+QCKn/FMa8Yz//A==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="58237958"
X-IronPort-AV: E=Sophos;i="6.12,273,1728975600"; 
   d="scan'208";a="58237958"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 17:28:35 -0800
X-CSE-ConnectionGUID: UtSp2+6xTi6Ye3XqQpKEYQ==
X-CSE-MsgGUID: VJly6oYLR4iFsqiALXM9fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,273,1728975600"; 
   d="scan'208";a="100840450"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 28 Dec 2024 17:28:29 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tRi6V-0004Pw-0a;
	Sun, 29 Dec 2024 01:28:27 +0000
Date: Sun, 29 Dec 2024 09:28:17 +0800
From: kernel test robot <lkp@intel.com>
To: Raphael Gallais-Pou <rgallaispou@gmail.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-ide@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com, linux-spi@vger.kernel.org
Subject: Re: [PATCH 6/6] spi: st: Switch from CONFIG_PM_SLEEP guards to
 pm_sleep_ptr()
Message-ID: <202412290921.tY3nJMjm-lkp@intel.com>
References: <20241229-update_pm_macro-v1-6-c7d4c4856336@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241229-update_pm_macro-v1-6-c7d4c4856336@gmail.com>

Hi Raphael,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 8155b4ef3466f0e289e8fcc9e6e62f3f4dceeac2]

url:    https://github.com/intel-lab-lkp/linux/commits/Raphael-Gallais-Pou/usb-dwc3-st-Switch-from-CONFIG_PM_SLEEP-guards-to-pm_sleep_ptr/20241229-073700
base:   8155b4ef3466f0e289e8fcc9e6e62f3f4dceeac2
patch link:    https://lore.kernel.org/r/20241229-update_pm_macro-v1-6-c7d4c4856336%40gmail.com
patch subject: [PATCH 6/6] spi: st: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
config: arm-randconfig-002-20241229 (https://download.01.org/0day-ci/archive/20241229/202412290921.tY3nJMjm-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241229/202412290921.tY3nJMjm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412290921.tY3nJMjm-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/spi/spi-st-ssc4.c:418:12: warning: 'spi_st_resume' defined but not used [-Wunused-function]
     418 | static int spi_st_resume(struct device *dev)
         |            ^~~~~~~~~~~~~
>> drivers/spi/spi-st-ssc4.c:406:12: warning: 'spi_st_suspend' defined but not used [-Wunused-function]
     406 | static int spi_st_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~


vim +/spi_st_resume +418 drivers/spi/spi-st-ssc4.c

9e862375c5420a Lee Jones      2014-12-09  405  
9e862375c5420a Lee Jones      2014-12-09 @406  static int spi_st_suspend(struct device *dev)
9e862375c5420a Lee Jones      2014-12-09  407  {
e6b7e64cb11966 Yang Yingliang 2023-11-28  408  	struct spi_controller *host = dev_get_drvdata(dev);
9e862375c5420a Lee Jones      2014-12-09  409  	int ret;
9e862375c5420a Lee Jones      2014-12-09  410  
e6b7e64cb11966 Yang Yingliang 2023-11-28  411  	ret = spi_controller_suspend(host);
9e862375c5420a Lee Jones      2014-12-09  412  	if (ret)
9e862375c5420a Lee Jones      2014-12-09  413  		return ret;
9e862375c5420a Lee Jones      2014-12-09  414  
9e862375c5420a Lee Jones      2014-12-09  415  	return pm_runtime_force_suspend(dev);
9e862375c5420a Lee Jones      2014-12-09  416  }
9e862375c5420a Lee Jones      2014-12-09  417  
9e862375c5420a Lee Jones      2014-12-09 @418  static int spi_st_resume(struct device *dev)
9e862375c5420a Lee Jones      2014-12-09  419  {
e6b7e64cb11966 Yang Yingliang 2023-11-28  420  	struct spi_controller *host = dev_get_drvdata(dev);
9e862375c5420a Lee Jones      2014-12-09  421  	int ret;
9e862375c5420a Lee Jones      2014-12-09  422  
e6b7e64cb11966 Yang Yingliang 2023-11-28  423  	ret = spi_controller_resume(host);
9e862375c5420a Lee Jones      2014-12-09  424  	if (ret)
9e862375c5420a Lee Jones      2014-12-09  425  		return ret;
9e862375c5420a Lee Jones      2014-12-09  426  
9e862375c5420a Lee Jones      2014-12-09  427  	return pm_runtime_force_resume(dev);
9e862375c5420a Lee Jones      2014-12-09  428  }
9e862375c5420a Lee Jones      2014-12-09  429  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

