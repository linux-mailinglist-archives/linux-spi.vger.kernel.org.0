Return-Path: <linux-spi+bounces-6201-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CC99FDD13
	for <lists+linux-spi@lfdr.de>; Sun, 29 Dec 2024 02:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C1683A15C7
	for <lists+linux-spi@lfdr.de>; Sun, 29 Dec 2024 01:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7DA5672;
	Sun, 29 Dec 2024 01:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YrHqigEN"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B419C17C2;
	Sun, 29 Dec 2024 01:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735436379; cv=none; b=T9nIdeubL7KnY9R4CUmvfTFcIEUNtWcMBtkjUCUaG2BT5QVi4OFvu/DvBqd7s+MnBbWRGNUqCj7V/XKDXlY7jcjvp6VLzy1d4lRXo+AVmIhUP5ouqyxbZP+S3ZmVMJByZxAKz59nvba6QOcPqMRwyLjgwL3Bjsz5IRN2Or7TDCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735436379; c=relaxed/simple;
	bh=rFQfnH8g9qnvAm/orX7H7+JRj5OpvCxqGxR6Qhq2ETY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igJ0osIVB9/iEbLsbv9GFkPfLYx62cgZHkZXCiaxWOr4kDrLPpxwLKLELKhyv2DsysyTstegy89WIvYrQCn3+XOY8u2uFFqw84QxDyxLGUopHTcoZS818KHunVwyelCjOw15M3dme9aLT706I2ILTTWb4z3+v3Xlnl2AeG50bwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YrHqigEN; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735436378; x=1766972378;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rFQfnH8g9qnvAm/orX7H7+JRj5OpvCxqGxR6Qhq2ETY=;
  b=YrHqigENiRZFKFNdf/eyVKM6sZLYSgeadY5sfAlQL2fs9T9/XmOpLaKd
   ywgM/fVAo8a3bGNGuGdDZLjG6OSJRe9wQ8bdnvskoIh7id9Gd2e+Pu/Jh
   mOdhNYOfiv3iaBnb9uVVCtP3DG9B78oLa0Gm/RGRSL5TjImxTnONG5JjB
   VVlsinm/4ed/XkRy7qm5Qnh23nI0Ovq+XI/L8yfzHb+2QAZY0eMrGXDX/
   x4J/WykliuqVrIbB8q6l6dsWCT7eLL9qAsuR3tobDcCEfxt84AT/xweKu
   9Bx/M2Y/7502cShz4K4QGYKqVMBVK+MNIQ2wFsK6wj9a9zScdBuyHY708
   Q==;
X-CSE-ConnectionGUID: yz7TVx8yQEKuOVt1PxUB4A==
X-CSE-MsgGUID: eoOjtTqZQImoffjpcVE2Wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="35802053"
X-IronPort-AV: E=Sophos;i="6.12,273,1728975600"; 
   d="scan'208";a="35802053"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 17:39:37 -0800
X-CSE-ConnectionGUID: Oy4svG45T4qIdA2Vlwx06g==
X-CSE-MsgGUID: xNOqO8z6T+WhcD2uqXjGIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="100302592"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 28 Dec 2024 17:39:31 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tRiHA-0004QO-0J;
	Sun, 29 Dec 2024 01:39:28 +0000
Date: Sun, 29 Dec 2024 09:39:05 +0800
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
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-ide@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/6] mmc: sdhci-st: Switch from CONFIG_PM_SLEEP guards to
 pm_sleep_ptr()
Message-ID: <202412290939.43oNt9t6-lkp@intel.com>
References: <20241229-update_pm_macro-v1-2-c7d4c4856336@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241229-update_pm_macro-v1-2-c7d4c4856336@gmail.com>

Hi Raphael,

kernel test robot noticed the following build errors:

[auto build test ERROR on 8155b4ef3466f0e289e8fcc9e6e62f3f4dceeac2]

url:    https://github.com/intel-lab-lkp/linux/commits/Raphael-Gallais-Pou/usb-dwc3-st-Switch-from-CONFIG_PM_SLEEP-guards-to-pm_sleep_ptr/20241229-073700
base:   8155b4ef3466f0e289e8fcc9e6e62f3f4dceeac2
patch link:    https://lore.kernel.org/r/20241229-update_pm_macro-v1-2-c7d4c4856336%40gmail.com
patch subject: [PATCH 2/6] mmc: sdhci-st: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
config: hexagon-randconfig-001-20241229 (https://download.01.org/0day-ci/archive/20241229/202412290939.43oNt9t6-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 319b89197348b7cad1215e235bdc7b5ec8f9b72c)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241229/202412290939.43oNt9t6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412290939.43oNt9t6-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/mmc/host/sdhci-st.c:460:8: error: call to undeclared function 'sdhci_suspend_host'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     460 |         ret = sdhci_suspend_host(host);
         |               ^
>> drivers/mmc/host/sdhci-st.c:494:9: error: call to undeclared function 'sdhci_resume_host'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     494 |         return sdhci_resume_host(host);
         |                ^
   drivers/mmc/host/sdhci-st.c:494:9: note: did you mean 'sdhci_remove_host'?
   drivers/mmc/host/sdhci.h:827:6: note: 'sdhci_remove_host' declared here
     827 | void sdhci_remove_host(struct sdhci_host *host, int dead);
         |      ^
   2 errors generated.


vim +/sdhci_suspend_host +460 drivers/mmc/host/sdhci-st.c

f52d9c4f459bda Peter Griffin 2014-07-09  449  
f52d9c4f459bda Peter Griffin 2014-07-09  450  static int sdhci_st_suspend(struct device *dev)
f52d9c4f459bda Peter Griffin 2014-07-09  451  {
f52d9c4f459bda Peter Griffin 2014-07-09  452  	struct sdhci_host *host = dev_get_drvdata(dev);
f52d9c4f459bda Peter Griffin 2014-07-09  453  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
1531675269c833 Jisheng Zhang 2016-02-16  454  	struct st_mmc_platform_data *pdata = sdhci_pltfm_priv(pltfm_host);
d38dcad4e7b48f Adrian Hunter 2017-03-20  455  	int ret;
d38dcad4e7b48f Adrian Hunter 2017-03-20  456  
d38dcad4e7b48f Adrian Hunter 2017-03-20  457  	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
d38dcad4e7b48f Adrian Hunter 2017-03-20  458  		mmc_retune_needed(host->mmc);
f52d9c4f459bda Peter Griffin 2014-07-09  459  
d38dcad4e7b48f Adrian Hunter 2017-03-20 @460  	ret = sdhci_suspend_host(host);
f52d9c4f459bda Peter Griffin 2014-07-09  461  	if (ret)
f52d9c4f459bda Peter Griffin 2014-07-09  462  		goto out;
f52d9c4f459bda Peter Griffin 2014-07-09  463  
406c24310a7bd7 Peter Griffin 2015-04-10  464  	reset_control_assert(pdata->rstc);
406c24310a7bd7 Peter Griffin 2015-04-10  465  
3ae50f4512ce83 Lee Jones     2016-09-08  466  	clk_disable_unprepare(pdata->icnclk);
f52d9c4f459bda Peter Griffin 2014-07-09  467  	clk_disable_unprepare(pltfm_host->clk);
f52d9c4f459bda Peter Griffin 2014-07-09  468  out:
f52d9c4f459bda Peter Griffin 2014-07-09  469  	return ret;
f52d9c4f459bda Peter Griffin 2014-07-09  470  }
f52d9c4f459bda Peter Griffin 2014-07-09  471  
f52d9c4f459bda Peter Griffin 2014-07-09  472  static int sdhci_st_resume(struct device *dev)
f52d9c4f459bda Peter Griffin 2014-07-09  473  {
f52d9c4f459bda Peter Griffin 2014-07-09  474  	struct sdhci_host *host = dev_get_drvdata(dev);
f52d9c4f459bda Peter Griffin 2014-07-09  475  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
1531675269c833 Jisheng Zhang 2016-02-16  476  	struct st_mmc_platform_data *pdata = sdhci_pltfm_priv(pltfm_host);
2053812f6e1af0 Peter Griffin 2015-04-10  477  	struct device_node *np = dev->of_node;
7f55eb101d4a75 Arvind Yadav  2017-06-20  478  	int ret;
f52d9c4f459bda Peter Griffin 2014-07-09  479  
7f55eb101d4a75 Arvind Yadav  2017-06-20  480  	ret = clk_prepare_enable(pltfm_host->clk);
7f55eb101d4a75 Arvind Yadav  2017-06-20  481  	if (ret)
7f55eb101d4a75 Arvind Yadav  2017-06-20  482  		return ret;
7f55eb101d4a75 Arvind Yadav  2017-06-20  483  
7f55eb101d4a75 Arvind Yadav  2017-06-20  484  	ret = clk_prepare_enable(pdata->icnclk);
7f55eb101d4a75 Arvind Yadav  2017-06-20  485  	if (ret) {
7f55eb101d4a75 Arvind Yadav  2017-06-20  486  		clk_disable_unprepare(pltfm_host->clk);
7f55eb101d4a75 Arvind Yadav  2017-06-20  487  		return ret;
7f55eb101d4a75 Arvind Yadav  2017-06-20  488  	}
f52d9c4f459bda Peter Griffin 2014-07-09  489  
406c24310a7bd7 Peter Griffin 2015-04-10  490  	reset_control_deassert(pdata->rstc);
406c24310a7bd7 Peter Griffin 2015-04-10  491  
2053812f6e1af0 Peter Griffin 2015-04-10  492  	st_mmcss_cconfig(np, host);
2053812f6e1af0 Peter Griffin 2015-04-10  493  
f52d9c4f459bda Peter Griffin 2014-07-09 @494  	return sdhci_resume_host(host);
f52d9c4f459bda Peter Griffin 2014-07-09  495  }
f52d9c4f459bda Peter Griffin 2014-07-09  496  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

