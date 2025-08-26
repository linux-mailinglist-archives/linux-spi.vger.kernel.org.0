Return-Path: <linux-spi+bounces-9669-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A55B373EB
	for <lists+linux-spi@lfdr.de>; Tue, 26 Aug 2025 22:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF02C36385E
	for <lists+linux-spi@lfdr.de>; Tue, 26 Aug 2025 20:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F260D2E228D;
	Tue, 26 Aug 2025 20:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DAb7Vhfc"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4473A28980F;
	Tue, 26 Aug 2025 20:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756240543; cv=none; b=sgDafa1kP4oScE/BVI4aXp2NsqGL8iLHgCVTztSPnixgw+7HPEpORFgeoNS2VyXMhDNv8u+NaNsTDxfsJRe8zVHmUfrUVAOBu7VwqSLQfytKh20aeq10W955o0jZwxmhjYqgpwTfiSLTSlAXYFTIEfz46GWmYpxMs0gAJIwKxos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756240543; c=relaxed/simple;
	bh=sFouoUIvWVQ2yig/ZG45FSzeJ7zb8/WV+WvoFHH3+sY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyS2LG3Tqm+wCPhR9H7BSOd71RyHJAjhzfRNcxZgAhadcJqM/Iozz9RUUv/p4zjmtUfI9QW1seC6OgtwJO8YUDqwCMEvgFKXLDMbkxMSAJGvzOP17HD7PUt3ePDfjWM7ASV0ledMm5TaJdoYfknFmbkVxulMhbkJX2VgNFAUQ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DAb7Vhfc; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756240542; x=1787776542;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sFouoUIvWVQ2yig/ZG45FSzeJ7zb8/WV+WvoFHH3+sY=;
  b=DAb7VhfcsfDYIOCiWUT8V053wyqtJXkb3pIgyCxfGjn8j859ZutqZeMp
   GY5MgWVXtcuD0RAnDdbx2iEjwIKYZBNpl5i+qcpeTOtkV+0UEd+TLlg4a
   RvDCo8UpO8yi3z6qhNFoH2TFdjODReKP6H1Vpsveh273mh8xRztiK8vy2
   bDzqePI13xKQcHI/INT77XSccpW3D/cBKFaIMZPl2oHG+qypbXOjWEFcq
   pkONnmz5VQqnlIeoTD6NVxE/O67rwkFh7k9fFLimte3ZlTSA+nJkO1RsQ
   Qq5Ex5NuTm+iCpzrMkVmJW25QMQmZOCULvpzM4mrAUUkwqk4qWkc9cYXg
   g==;
X-CSE-ConnectionGUID: NStm4CCJQwmXQ2LLsL3Z7g==
X-CSE-MsgGUID: 3FDRNsdASd6xCOyOrbF7Pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="58423404"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="58423404"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 13:35:42 -0700
X-CSE-ConnectionGUID: 21+nFIwlQHCy6Q0yqbjhHA==
X-CSE-MsgGUID: 6j7kS6d4RMGWnYhc6xSXCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169844692"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 26 Aug 2025 13:35:40 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ur0OH-000SND-2R;
	Tue, 26 Aug 2025 20:35:37 +0000
Date: Wed, 27 Aug 2025 04:35:27 +0800
From: kernel test robot <lkp@intel.com>
To: Rosen Penev <rosenp@gmail.com>, linux-spi@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: rb4xx: add COMPILE_TEST support
Message-ID: <202508270444.t2WdWo8x-lkp@intel.com>
References: <20250821033534.638157-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821033534.638157-1-rosenp@gmail.com>

Hi Rosen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-spi/for-next]
[also build test WARNING on linus/master v6.17-rc3 next-20250826]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rosen-Penev/spi-rb4xx-add-COMPILE_TEST-support/20250821-113701
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20250821033534.638157-1-rosenp%40gmail.com
patch subject: [PATCH] spi: rb4xx: add COMPILE_TEST support
config: m68k-randconfig-r073-20250827 (https://download.01.org/0day-ci/archive/20250827/202508270444.t2WdWo8x-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250827/202508270444.t2WdWo8x-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508270444.t2WdWo8x-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/spi/spi-rb4xx.c:200:34: warning: 'rb4xx_spi_dt_match' defined but not used [-Wunused-const-variable=]
     200 | static const struct of_device_id rb4xx_spi_dt_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~~


vim +/rb4xx_spi_dt_match +200 drivers/spi/spi-rb4xx.c

05aec357871f89 Bert Vermeulen   2015-04-15  199  
9a436c62fbb4c5 Christopher Hill 2020-05-21 @200  static const struct of_device_id rb4xx_spi_dt_match[] = {
9a436c62fbb4c5 Christopher Hill 2020-05-21  201  	{ .compatible = "mikrotik,rb4xx-spi" },
9a436c62fbb4c5 Christopher Hill 2020-05-21  202  	{ },
9a436c62fbb4c5 Christopher Hill 2020-05-21  203  };
9a436c62fbb4c5 Christopher Hill 2020-05-21  204  MODULE_DEVICE_TABLE(of, rb4xx_spi_dt_match);
9a436c62fbb4c5 Christopher Hill 2020-05-21  205  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

