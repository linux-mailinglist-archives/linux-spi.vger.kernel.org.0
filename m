Return-Path: <linux-spi+bounces-6202-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 911AB9FDD63
	for <lists+linux-spi@lfdr.de>; Sun, 29 Dec 2024 06:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B5AD1617EA
	for <lists+linux-spi@lfdr.de>; Sun, 29 Dec 2024 05:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8DC22331;
	Sun, 29 Dec 2024 05:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n9tqMR9z"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F4F18EAB;
	Sun, 29 Dec 2024 05:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735450739; cv=none; b=LtIyS0esmveNWF3bdsHR5D3Fm50nPxXGyzQL33ckk7zFlbmVcYoQRDpPITwJhsiL7o8hXoBTB51fn+n2l4xWcB7KkxN+Ja7lzk0ufLiGE0ZuGkFR5M6AjFHOL37Gu4UXuGo+wuqqxxBMmQUX0ap1TiBxEddiFWWMbgddMUskcm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735450739; c=relaxed/simple;
	bh=2ZAfvEapeqlQxdPGabGekF/vOEsQwkH6pIqCbZL1qVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmHCD8dRmLlgUG3cqbo1cgXYDV0rWEssWICKDuGadS9CQw1Jl+7FbQL2757Ip0wtJXaG1621qT4dHQMiMoy78TieRtDrH/36oToAHN62MKmec07ll+k11KU2rYqaCpRsYcqGuyLOCSzf9K3hw7STWeuWlVYie6QxZyDWJqhj5QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n9tqMR9z; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735450738; x=1766986738;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2ZAfvEapeqlQxdPGabGekF/vOEsQwkH6pIqCbZL1qVs=;
  b=n9tqMR9z65SDvgBk67Yml2rqA0jqtv34tMJ/pxiET9Q6wIbvv9CNHN2w
   sA3ens+hoH1gutDQ2Atq8V4L8ds/j8kRPF0HhpAbzlyW2+ltXYfQSebIA
   gIizEbTbJMdYyxE1xMmvb0Ozy9jWC+w8fYgQ5I2L4rFAN37nwMmDf9pXB
   RGEHD8xEU34X+UVQok/ikXAWlndZWLlQjxpnDQFrSVZGcdPSExo27xkdr
   LyvdzGfzCby5lDwq4x5EOCTySPAc+XMsxzoScGFU53qWto+WJ1fpkAMNs
   tJmPbJNuoiEMcdD9vJOZ9G4M65DzgzLwCStKlWF6elNC72Gk48BhSCO59
   w==;
X-CSE-ConnectionGUID: Z3eEAt7QR5+b8f2DHYTqIA==
X-CSE-MsgGUID: Lbl1mTXqQx23UUWKPr6I2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="39714084"
X-IronPort-AV: E=Sophos;i="6.12,273,1728975600"; 
   d="scan'208";a="39714084"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 21:38:57 -0800
X-CSE-ConnectionGUID: 3s/MFmMNTKGc/r/0Xdc6Eg==
X-CSE-MsgGUID: pWJT/xodQjqlIGcz6VIFSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,273,1728975600"; 
   d="scan'208";a="100868774"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 28 Dec 2024 21:38:51 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tRm0m-0004V6-2X;
	Sun, 29 Dec 2024 05:38:48 +0000
Date: Sun, 29 Dec 2024 13:38:40 +0800
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
Subject: Re: [PATCH 2/6] mmc: sdhci-st: Switch from CONFIG_PM_SLEEP guards to
 pm_sleep_ptr()
Message-ID: <202412291320.lZkWz3Yv-lkp@intel.com>
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
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20241229/202412291320.lZkWz3Yv-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241229/202412291320.lZkWz3Yv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412291320.lZkWz3Yv-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/mmc/host/sdhci-st.c: In function 'sdhci_st_suspend':
>> drivers/mmc/host/sdhci-st.c:460:15: error: implicit declaration of function 'sdhci_suspend_host'; did you mean 'sdhci_add_host'? [-Wimplicit-function-declaration]
     460 |         ret = sdhci_suspend_host(host);
         |               ^~~~~~~~~~~~~~~~~~
         |               sdhci_add_host
   drivers/mmc/host/sdhci-st.c: In function 'sdhci_st_resume':
>> drivers/mmc/host/sdhci-st.c:494:16: error: implicit declaration of function 'sdhci_resume_host'; did you mean 'sdhci_remove_host'? [-Wimplicit-function-declaration]
     494 |         return sdhci_resume_host(host);
         |                ^~~~~~~~~~~~~~~~~
         |                sdhci_remove_host


vim +460 drivers/mmc/host/sdhci-st.c

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

