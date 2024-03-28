Return-Path: <linux-spi+bounces-2075-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5643088FFE1
	for <lists+linux-spi@lfdr.de>; Thu, 28 Mar 2024 14:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C21E2920E3
	for <lists+linux-spi@lfdr.de>; Thu, 28 Mar 2024 13:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD817D3F1;
	Thu, 28 Mar 2024 13:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EA2H29ff"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34572B9D7;
	Thu, 28 Mar 2024 13:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711631715; cv=none; b=vAvrtwPAE6Avce4eDtrJd7eZf+gpJqwQvr76H46e7M2aRHoY5u+jSXP+ujEh227PNcpH1YIBRTgxf8ehNmHYM892HBfe/CcUyJdhQvN0nwoFBmCY6gCZl63Ij3kUasfTzKcUV+EF5Zy9+JtWjsz75k0TYgYd5p0GIFW/5U9gePg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711631715; c=relaxed/simple;
	bh=pjqaQ071/VMsOTmA8BpkoiGRbVmT/eomFxqIvEbUJhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eX4gXc0cAm7uOoZqtsxdv1RbfcgxlkDf3XjHT0gaGehFHXD8dXuAbI4ro3lL+8QcY0pIOCUk7zVEEXK2Ep+D50loO2n6g3tE6yTRe1NfOZFgoqgdii1fK6NI6taTMZqHeDVReIl6cjUTOVwvhEP20CksW/f61sKNpbO0n1EgM68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EA2H29ff; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711631714; x=1743167714;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pjqaQ071/VMsOTmA8BpkoiGRbVmT/eomFxqIvEbUJhM=;
  b=EA2H29ffUnZkq2XkvmJPVslsMeD4SEMO0EcIyCUNa4XK6pzrHs5CUgPo
   ijwJQ7/oqPqNgqpSQVuLq21OEVmsA+9M4dynjRE3LSotOcCgJfLuYvyFR
   e6DdQk9gvznih5nYdoly06pgCxZAuMJXcEb+DIAKhD5UzJ/wvi9K0CWPQ
   q5CshY7DJE6tDgANcdgXz2OO/iWGsRupf39z8aRfpAyvyUe0yZ5FaKCD1
   BR7Se5tlfDonDS8lGOCjc6O+80/5uThH2cWPU5DynnErNgSZhmV8JP1rX
   5XcTM9sxUVOoQhggm9GubEGbr/jvfgUT6oXGba9MvTcnHghmnPDWfDwLU
   w==;
X-CSE-ConnectionGUID: 8iSdQXwnTKaMNVhzmTGP8A==
X-CSE-MsgGUID: uFvKlNKfQlij22CTZc1XSg==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6638888"
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="6638888"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 06:15:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="47827968"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 28 Mar 2024 06:15:08 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rppb0-0002AD-0M;
	Thu, 28 Mar 2024 13:15:06 +0000
Date: Thu, 28 Mar 2024 21:15:02 +0800
From: kernel test robot <lkp@intel.com>
To: Charles Keepax <ckeepax@opensource.cirrus.com>, broonie@kernel.org,
	linus.walleij@linaro.org, brgl@bgdev.pl
Cc: oe-kbuild-all@lists.linux.dev, linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 3/3] spi: cs42l43: Add bridged cs35l56 amplifiers
Message-ID: <202403282033.oFvCtRT7-lkp@intel.com>
References: <20240326141108.1079993-4-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326141108.1079993-4-ckeepax@opensource.cirrus.com>

Hi Charles,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-spi/for-next]
[also build test WARNING on brgl/gpio/for-next linus/master v6.9-rc1 next-20240328]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Charles-Keepax/gpio-swnode-Add-ability-to-specify-native-chip-selects-for-SPI/20240326-221422
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20240326141108.1079993-4-ckeepax%40opensource.cirrus.com
patch subject: [PATCH 3/3] spi: cs42l43: Add bridged cs35l56 amplifiers
config: sh-randconfig-r121-20240327 (https://download.01.org/0day-ci/archive/20240328/202403282033.oFvCtRT7-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240328/202403282033.oFvCtRT7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403282033.oFvCtRT7-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/spi/spi-cs42l43.c:48:28: sparse: sparse: symbol 'ampr' was not declared. Should it be static?
>> drivers/spi/spi-cs42l43.c:52:23: sparse: sparse: symbol 'ampl_info' was not declared. Should it be static?
>> drivers/spi/spi-cs42l43.c:61:23: sparse: sparse: symbol 'ampr_info' was not declared. Should it be static?
   drivers/spi/spi-cs42l43.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/slab.h, ...):
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false

vim +/ampr +48 drivers/spi/spi-cs42l43.c

    47	
  > 48	const struct software_node ampr = {
    49		.name			= "cs35l56-right",
    50	};
    51	
  > 52	struct spi_board_info ampl_info = {
    53		.modalias		= "cs35l56",
    54		.max_speed_hz		= 2000000,
    55		.chip_select		= 0,
    56		.mode			= SPI_MODE_0,
    57		.swnode			= &ampl,
    58		.use_fwnode_name	= true,
    59	};
    60	
  > 61	struct spi_board_info ampr_info = {
    62		.modalias		= "cs35l56",
    63		.max_speed_hz		= 2000000,
    64		.chip_select		= 1,
    65		.mode			= SPI_MODE_0,
    66		.swnode			= &ampr,
    67		.use_fwnode_name	= true,
    68	};
    69	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

