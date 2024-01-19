Return-Path: <linux-spi+bounces-512-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED448324DC
	for <lists+linux-spi@lfdr.de>; Fri, 19 Jan 2024 08:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E90F32845A5
	for <lists+linux-spi@lfdr.de>; Fri, 19 Jan 2024 07:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94FE3C17;
	Fri, 19 Jan 2024 07:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GhLi6ZMO"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA71AC142
	for <linux-spi@vger.kernel.org>; Fri, 19 Jan 2024 07:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705648316; cv=none; b=Fep2hdvNWACJb8843K/TYU6iCAzEolan6c5f/OKCtMObbSH/rOaX7UZLnMyLTB8P9ofBj8pIqMPAL3NzWUpDPYCw9YcDgHkXGAuPdbdjft+YKn62O+AXdSH1Fyp/bhZy46T8jp6e0Z9oVbTJJ3u5iECdvnxYbQHvUWqnTie62ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705648316; c=relaxed/simple;
	bh=Pe8MQts4DxMBgh4hosuzuHjkTl98NBN4UFDSJ1FnMJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7AURhS94N4EE2IvGckPMmTUsSwRXfQzLkZPy5Tx82TAP1Kvimlb+FjQ8rCPtluy0848Lm+qH+ERSIhE1phgmITFNpxv2FYLK2fpYhMd8EwUADR+84UQtr/VtFqPGDSxA0WaSS8LjbOPUoSbUah6wmBE6pgut4A5mXAzYu8Jqyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GhLi6ZMO; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705648313; x=1737184313;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Pe8MQts4DxMBgh4hosuzuHjkTl98NBN4UFDSJ1FnMJ0=;
  b=GhLi6ZMO0MQ/q4Q5+gobspMhCvpPA3vutx4283clkbQb6TW9H1HIvTae
   bzZKENjvIaZGS0+V+N936R2I2Ee38nfqrzUjPgkN2YYJ1dqAtuAhW0CZO
   j0lK6ozLb10h+spOKGVEduk8KEMApD99jbiYwf4fAmvOVkP5Axsaet56B
   gLFm9JGrRi6wWU5v4QH/NyPfZcwtyCMOOkJ7YTdKxgmhOQj7bBI6iCdQ6
   gzLLkf2017uQR4Zszb/86oaTraVBxljuGlt7TbNHzyPJSbRoAB+irP8RU
   mA5BRWRSU1QiMKTGUtsc5YECWOFyZhs5t3vNqlF2iwqHi+p+fbfyLZ0gb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="400338073"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="400338073"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 23:11:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="622401"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 18 Jan 2024 23:11:50 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rQj2Z-0003kK-0n;
	Fri, 19 Jan 2024 07:11:47 +0000
Date: Fri, 19 Jan 2024 15:11:19 +0800
From: kernel test robot <lkp@intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: oe-kbuild-all@lists.linux.dev, linux-spi@vger.kernel.org,
	kernel@pengutronix.de, Michal Simek <monstr@monstr.eu>,
	Max Filippov <jcmvbkbc@gmail.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 17/33] spi: bitbang: Follow renaming of SPI "master" to
 "controller"
Message-ID: <202401191416.5ex4deYN-lkp@intel.com>
References: <95602f4f5b17eae6f3381a3153dedd0031b03aba.1705348269.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95602f4f5b17eae6f3381a3153dedd0031b03aba.1705348269.git.u.kleine-koenig@pengutronix.de>

Hi Uwe,

kernel test robot noticed the following build errors:

[auto build test ERROR on 8d04a7e2ee3fd6aabb8096b00c64db0d735bc874]

url:    https://github.com/intel-lab-lkp/linux/commits/Uwe-Kleine-K-nig/fpga-ice40-spi-Follow-renaming-of-SPI-master-to-controller/20240116-082610
base:   8d04a7e2ee3fd6aabb8096b00c64db0d735bc874
patch link:    https://lore.kernel.org/r/95602f4f5b17eae6f3381a3153dedd0031b03aba.1705348269.git.u.kleine-koenig%40pengutronix.de
patch subject: [PATCH 17/33] spi: bitbang: Follow renaming of SPI "master" to "controller"
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20240119/202401191416.5ex4deYN-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240119/202401191416.5ex4deYN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401191416.5ex4deYN-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/spi/spi-sh-sci.c: In function 'sh_sci_spi_probe':
>> drivers/spi/spi-sh-sci.c:139:20: error: 'struct spi_bitbang' has no member named 'master'
     139 |         sp->bitbang.master = host;
         |                    ^
   drivers/spi/spi-sh-sci.c:140:20: error: 'struct spi_bitbang' has no member named 'master'
     140 |         sp->bitbang.master->bus_num = sp->info->bus_num;
         |                    ^
   drivers/spi/spi-sh-sci.c:141:20: error: 'struct spi_bitbang' has no member named 'master'
     141 |         sp->bitbang.master->num_chipselect = sp->info->num_chipselect;
         |                    ^
   drivers/spi/spi-sh-sci.c:169:39: error: 'struct spi_bitbang' has no member named 'master'
     169 |         spi_controller_put(sp->bitbang.master);
         |                                       ^
   drivers/spi/spi-sh-sci.c: In function 'sh_sci_spi_remove':
   drivers/spi/spi-sh-sci.c:181:39: error: 'struct spi_bitbang' has no member named 'master'
     181 |         spi_controller_put(sp->bitbang.master);
         |                                       ^


vim +139 drivers/spi/spi-sh-sci.c

37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  113  
37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  114  static int sh_sci_spi_probe(struct platform_device *dev)
37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  115  {
37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  116  	struct resource	*r;
91a940bb1075337 drivers/spi/spi-sh-sci.c Yang Yingliang 2023-08-18  117  	struct spi_controller *host;
37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  118  	struct sh_sci_spi *sp;
37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  119  	int ret;
37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  120  
91a940bb1075337 drivers/spi/spi-sh-sci.c Yang Yingliang 2023-08-18  121  	host = spi_alloc_host(&dev->dev, sizeof(struct sh_sci_spi));
91a940bb1075337 drivers/spi/spi-sh-sci.c Yang Yingliang 2023-08-18  122  	if (host == NULL) {
91a940bb1075337 drivers/spi/spi-sh-sci.c Yang Yingliang 2023-08-18  123  		dev_err(&dev->dev, "failed to allocate spi host\n");
37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  124  		ret = -ENOMEM;
37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  125  		goto err0;
37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  126  	}
37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  127  
91a940bb1075337 drivers/spi/spi-sh-sci.c Yang Yingliang 2023-08-18  128  	sp = spi_controller_get_devdata(host);
37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  129  
37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  130  	platform_set_drvdata(dev, sp);
8074cf063e410a2 drivers/spi/spi-sh-sci.c Jingoo Han     2013-07-30  131  	sp->info = dev_get_platdata(&dev->dev);
ed8eb250d7b097d drivers/spi/spi-sh-sci.c Axel Lin       2014-03-13  132  	if (!sp->info) {
ed8eb250d7b097d drivers/spi/spi-sh-sci.c Axel Lin       2014-03-13  133  		dev_err(&dev->dev, "platform data is missing\n");
ed8eb250d7b097d drivers/spi/spi-sh-sci.c Axel Lin       2014-03-13  134  		ret = -ENOENT;
ed8eb250d7b097d drivers/spi/spi-sh-sci.c Axel Lin       2014-03-13  135  		goto err1;
ed8eb250d7b097d drivers/spi/spi-sh-sci.c Axel Lin       2014-03-13  136  	}
37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  137  
37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  138  	/* setup spi bitbang adaptor */
91a940bb1075337 drivers/spi/spi-sh-sci.c Yang Yingliang 2023-08-18 @139  	sp->bitbang.master = host;
37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  140  	sp->bitbang.master->bus_num = sp->info->bus_num;
37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  141  	sp->bitbang.master->num_chipselect = sp->info->num_chipselect;
37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  142  	sp->bitbang.chipselect = sh_sci_spi_chipselect;
37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  143  
37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  144  	sp->bitbang.txrx_word[SPI_MODE_0] = sh_sci_spi_txrx_mode0;
37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  145  	sp->bitbang.txrx_word[SPI_MODE_1] = sh_sci_spi_txrx_mode1;
37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  146  	sp->bitbang.txrx_word[SPI_MODE_2] = sh_sci_spi_txrx_mode2;
37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  147  	sp->bitbang.txrx_word[SPI_MODE_3] = sh_sci_spi_txrx_mode3;
37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  148  
37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  149  	r = platform_get_resource(dev, IORESOURCE_MEM, 0);
37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  150  	if (r == NULL) {
37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  151  		ret = -ENOENT;
37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  152  		goto err1;
37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  153  	}
76b6fdd35a2d796 drivers/spi/spi_sh_sci.c hartleys       2009-12-14  154  	sp->membase = ioremap(r->start, resource_size(r));
37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  155  	if (!sp->membase) {
37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  156  		ret = -ENXIO;
37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  157  		goto err1;
37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  158  	}
37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  159  	sp->val = ioread8(SCSPTR(sp));
37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  160  	setbits(sp, PIN_INIT, 1);
37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  161  
37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  162  	ret = spi_bitbang_start(&sp->bitbang);
37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  163  	if (!ret)
37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  164  		return 0;
37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  165  
37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  166  	setbits(sp, PIN_INIT, 0);
37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  167  	iounmap(sp->membase);
37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  168   err1:
91a940bb1075337 drivers/spi/spi-sh-sci.c Yang Yingliang 2023-08-18  169  	spi_controller_put(sp->bitbang.master);
37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  170   err0:
37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  171  	return ret;
37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  172  }
37e466408796300 drivers/spi/spi_sh_sci.c Magnus Damm    2008-02-06  173  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

