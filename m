Return-Path: <linux-spi+bounces-11236-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A9BC60865
	for <lists+linux-spi@lfdr.de>; Sat, 15 Nov 2025 17:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C4D174E3B35
	for <lists+linux-spi@lfdr.de>; Sat, 15 Nov 2025 16:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB352F3C3D;
	Sat, 15 Nov 2025 16:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aJU0oRzi"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42FA2D739B;
	Sat, 15 Nov 2025 16:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763223745; cv=none; b=H4QDTVagu9wI8pe+XA8wdMrn+kraLSmLZWJLU9BnplD5MWcDECjfUnbNYWQIkXYy5j+3J2285nvqDo3j5LiSc1qpiYzE14b794Uk5yVMxe9JPYWQQQQ4+HpL4Zq1QOvR+oclRx4PKkOkH11ES2fOkDXcIYwWoVlDaM8VWwdKBA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763223745; c=relaxed/simple;
	bh=rEnRLh6oU1O41QhkfgLHqF8VQ3Gg39DKHgTTg3E8C20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWAZlybARO6UCYR0Jce+WZHdC7tT5y8S3AK4rFKv1UHVMOqG9lrDqJUP05WcjfdAK/Zq/u+9S2OtVh3KobkKnPpi/dNo1HE6J0F+v4B3vGXVpyYimdpULzq+dvLnLy7T71+tN0HKovArUxyoLq2rTUUwYVwjm7K5P1VcT3UL83Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aJU0oRzi; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763223744; x=1794759744;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rEnRLh6oU1O41QhkfgLHqF8VQ3Gg39DKHgTTg3E8C20=;
  b=aJU0oRziwnWae59UTkeqIW6sks+JpBY8h0f4ZYM+V9z8EByAR/VEBDDi
   nM6adjyEtjfO4IgxzkHHcLvObsvdZfdXXErztPnMdgM5JBXO9rMV52oSt
   MXKZ8O0ajINiIBpj80WDmDV9oGFsmF7HOyJY1aajXPjkHQFpynaINFal5
   orKOlR216KcLcPbTWWH0EsEvjo4CnG2z8YHMWORcuYy7p6y/YsZe11vF3
   aXEQzxmaSkAs6FzO3MB5Z2kTJWtNN+jT9PdVe71UoMX+pX+ftCfWFNfgf
   kaXDH7U3Ir2V1dJJ3xAHw20xGlqIjGY5c4KJO47usLD3ew40sl9aPDud2
   A==;
X-CSE-ConnectionGUID: NbN+B2VBSZGr8IIDFH6I8w==
X-CSE-MsgGUID: 9LADZMOrSLKbyHTGnNVF8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11614"; a="65444062"
X-IronPort-AV: E=Sophos;i="6.19,307,1754982000"; 
   d="scan'208";a="65444062"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2025 08:22:24 -0800
X-CSE-ConnectionGUID: Sp7RVpXFSCyzkpevabgcKA==
X-CSE-MsgGUID: WwGDCu9eSdyOBEZf1Tb+XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,307,1754982000"; 
   d="scan'208";a="189717367"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 15 Nov 2025 08:22:22 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vKJ2Z-00085P-2E;
	Sat, 15 Nov 2025 16:22:19 +0000
Date: Sun, 16 Nov 2025 00:21:43 +0800
From: kernel test robot <lkp@intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>, Mark Brown <broonie@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] spi: davinci: remove platform data header
Message-ID: <202511160056.vvfSNpF8-lkp@intel.com>
References: <20251114-davinci-spi-v1-1-b19f842f3c38@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114-davinci-spi-v1-1-b19f842f3c38@linaro.org>

Hi Bartosz,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 0f2995693867bfb26197b117cd55624ddc57582f]

url:    https://github.com/intel-lab-lkp/linux/commits/Bartosz-Golaszewski/spi-davinci-remove-platform-data-header/20251115-025558
base:   0f2995693867bfb26197b117cd55624ddc57582f
patch link:    https://lore.kernel.org/r/20251114-davinci-spi-v1-1-b19f842f3c38%40linaro.org
patch subject: [PATCH] spi: davinci: remove platform data header
config: parisc-randconfig-002-20251115 (https://download.01.org/0day-ci/archive/20251116/202511160056.vvfSNpF8-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251116/202511160056.vvfSNpF8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511160056.vvfSNpF8-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/spi/spi-davinci.c:122 cannot understand function prototype: 'struct davinci_spi_platform_data'
>> Warning: drivers/spi/spi-davinci.c:149 cannot understand function prototype: 'struct davinci_spi_config'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

