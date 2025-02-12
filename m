Return-Path: <linux-spi+bounces-6771-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1556A31CA1
	for <lists+linux-spi@lfdr.de>; Wed, 12 Feb 2025 04:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E13867A2D0A
	for <lists+linux-spi@lfdr.de>; Wed, 12 Feb 2025 03:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BCD1D8A10;
	Wed, 12 Feb 2025 03:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IDMe+M7I"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D861D6DDC;
	Wed, 12 Feb 2025 03:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739330451; cv=none; b=iB7QB3PKwzczRy6lBFXZLLbEx2UynPtJYTKlDhLBeGokg1aXxGlvu9x4tqCZNY+hJujyo5IW/HZDxw0PRgk//ixcDNDiBklIGjO/AvPx3uYPuwp/XIntooUXr/L4pUZxcQgd1JMKMf+ZrBlV0sDioZA7eU1pLHtURFd+3tYyTNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739330451; c=relaxed/simple;
	bh=tYCgJ3VVS2+wFIEAUg/38zMkc5w5kRNn/Jm1EEchQpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/dkW74kVsVxLNCYiLGatOH5P63osIvUWetBhqZnQzSLPEer8k2Jp0GMXfmh9OV2SR2Nc+3YVNJKft5kucppKa2j/CwzFk14v7qvLCLY4wcRo7pCaIQy3Qd8qPkl2CSqPOWUTQ0I5qHRcOUfpkiT14OJkBxK8/8TXXaYQ1KBSCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IDMe+M7I; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739330449; x=1770866449;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tYCgJ3VVS2+wFIEAUg/38zMkc5w5kRNn/Jm1EEchQpM=;
  b=IDMe+M7IcIZFliiDtcXYr8LulWHjoD7c4FIrDzWzjB26SIokJh8ELuAF
   rhp+Mtn3HK6vVdu80Ao0py0uvc2iD35/4sgzP1He6C/wshdD0ggvNkEFh
   4DLU501b6NL4puB2E4jFhdgu+NaxwnnlP1ybFgYdxShadAxQ61ga0a8GE
   Siy989lTOXeD5eK0M1EP2Vb1MSkcc8s+0c7oMIeh4HFy9M08YDtqG2D6x
   F+UtA1RwI9fKUyZX2n4EmfMBey/Ps/uORo+kTnHYr80fczMQPwVifN0vK
   7Z3uaUfqZfde96NtNR1GVsxliGZRSnPURceF/jqilnUnDHybEawEIhpZf
   g==;
X-CSE-ConnectionGUID: KVQktT1iR6+KgjTKgBVm+A==
X-CSE-MsgGUID: wTGGTpitScaWxfZ9+Y1ICA==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="42816607"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="42816607"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 19:20:48 -0800
X-CSE-ConnectionGUID: k9ilJmnzQIWlITvoNIr6Ww==
X-CSE-MsgGUID: NFJ8fN+rQhObvj8hXYyRBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="143540262"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 11 Feb 2025 19:20:43 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ti3In-00153X-1Y;
	Wed, 12 Feb 2025 03:20:41 +0000
Date: Wed, 12 Feb 2025 11:19:46 +0800
From: kernel test robot <lkp@intel.com>
To: patrice.chotard@foss.st.com, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	christophe.kerello@foss.st.com, patrice.chotard@foss.st.com
Subject: Re: [PATCH v3 4/8] memory: Add STM32 Octo Memory Manager driver
Message-ID: <202502121131.W1HsUg9j-lkp@intel.com>
References: <20250210131826.220318-5-patrice.chotard@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210131826.220318-5-patrice.chotard@foss.st.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on broonie-spi/for-next]
[also build test ERROR on atorgue-stm32/stm32-next krzk-mem-ctrl/for-next linus/master v6.14-rc2 next-20250210]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/patrice-chotard-foss-st-com/dt-bindings-spi-Add-STM32-OSPI-controller/20250210-212554
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20250210131826.220318-5-patrice.chotard%40foss.st.com
patch subject: [PATCH v3 4/8] memory: Add STM32 Octo Memory Manager driver
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20250212/202502121131.W1HsUg9j-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250212/202502121131.W1HsUg9j-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502121131.W1HsUg9j-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/memory/stm32_omm.c:82:25: note: in expansion of macro 'dev_err'
      82 |                         dev_err(dev, "[0x%llx-0x%llx] doesn't fit inside [0x%llx-0x%llx]\n",
         |                         ^~~~~~~
   drivers/memory/stm32_omm.c:82:80: note: format string is defined here
      82 |                         dev_err(dev, "[0x%llx-0x%llx] doesn't fit inside [0x%llx-0x%llx]\n",
         |                                                                             ~~~^
         |                                                                                |
         |                                                                                long long unsigned int
         |                                                                             %x
   drivers/memory/stm32_omm.c:82:38: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 6 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
      82 |                         dev_err(dev, "[0x%llx-0x%llx] doesn't fit inside [0x%llx-0x%llx]\n",
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:154:56: note: in expansion of macro 'dev_fmt'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/memory/stm32_omm.c:82:25: note: in expansion of macro 'dev_err'
      82 |                         dev_err(dev, "[0x%llx-0x%llx] doesn't fit inside [0x%llx-0x%llx]\n",
         |                         ^~~~~~~
   drivers/memory/stm32_omm.c:82:87: note: format string is defined here
      82 |                         dev_err(dev, "[0x%llx-0x%llx] doesn't fit inside [0x%llx-0x%llx]\n",
         |                                                                                    ~~~^
         |                                                                                       |
         |                                                                                       long long unsigned int
         |                                                                                    %x
   drivers/memory/stm32_omm.c:96:46: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 3 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
      96 |                                 dev_err(dev, "[0x%llx-0x%llx] overlaps [0x%llx-0x%llx]\n",
         |                                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:154:56: note: in expansion of macro 'dev_fmt'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/memory/stm32_omm.c:96:33: note: in expansion of macro 'dev_err'
      96 |                                 dev_err(dev, "[0x%llx-0x%llx] overlaps [0x%llx-0x%llx]\n",
         |                                 ^~~~~~~
   drivers/memory/stm32_omm.c:96:53: note: format string is defined here
      96 |                                 dev_err(dev, "[0x%llx-0x%llx] overlaps [0x%llx-0x%llx]\n",
         |                                                  ~~~^
         |                                                     |
         |                                                     long long unsigned int
         |                                                  %x
   drivers/memory/stm32_omm.c:96:46: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
      96 |                                 dev_err(dev, "[0x%llx-0x%llx] overlaps [0x%llx-0x%llx]\n",
         |                                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:154:56: note: in expansion of macro 'dev_fmt'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/memory/stm32_omm.c:96:33: note: in expansion of macro 'dev_err'
      96 |                                 dev_err(dev, "[0x%llx-0x%llx] overlaps [0x%llx-0x%llx]\n",
         |                                 ^~~~~~~
   drivers/memory/stm32_omm.c:96:60: note: format string is defined here
      96 |                                 dev_err(dev, "[0x%llx-0x%llx] overlaps [0x%llx-0x%llx]\n",
         |                                                         ~~~^
         |                                                            |
         |                                                            long long unsigned int
         |                                                         %x
   drivers/memory/stm32_omm.c:96:46: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 5 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
      96 |                                 dev_err(dev, "[0x%llx-0x%llx] overlaps [0x%llx-0x%llx]\n",
         |                                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:154:56: note: in expansion of macro 'dev_fmt'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/memory/stm32_omm.c:96:33: note: in expansion of macro 'dev_err'
      96 |                                 dev_err(dev, "[0x%llx-0x%llx] overlaps [0x%llx-0x%llx]\n",
         |                                 ^~~~~~~
   drivers/memory/stm32_omm.c:96:78: note: format string is defined here
      96 |                                 dev_err(dev, "[0x%llx-0x%llx] overlaps [0x%llx-0x%llx]\n",
         |                                                                           ~~~^
         |                                                                              |
         |                                                                              long long unsigned int
         |                                                                           %x
   drivers/memory/stm32_omm.c:96:46: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 6 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
      96 |                                 dev_err(dev, "[0x%llx-0x%llx] overlaps [0x%llx-0x%llx]\n",
         |                                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:154:56: note: in expansion of macro 'dev_fmt'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/memory/stm32_omm.c:96:33: note: in expansion of macro 'dev_err'
      96 |                                 dev_err(dev, "[0x%llx-0x%llx] overlaps [0x%llx-0x%llx]\n",
         |                                 ^~~~~~~
   drivers/memory/stm32_omm.c:96:85: note: format string is defined here
      96 |                                 dev_err(dev, "[0x%llx-0x%llx] overlaps [0x%llx-0x%llx]\n",
         |                                                                                  ~~~^
         |                                                                                     |
         |                                                                                     long long unsigned int
         |                                                                                  %x
   drivers/memory/stm32_omm.c: In function 'stm32_omm_configure':
>> drivers/memory/stm32_omm.c:224:35: error: implicit declaration of function 'FIELD_PREP' [-Wimplicit-function-declaration]
     224 |                         req2ack = FIELD_PREP(CR_REQ2ACK_MASK, req2ack);
         |                                   ^~~~~~~~~~


vim +/FIELD_PREP +224 drivers/memory/stm32_omm.c

   164	
   165	static int stm32_omm_configure(struct device *dev)
   166	{
   167		struct stm32_omm *omm = dev_get_drvdata(dev);
   168		struct reset_control *rstc;
   169		unsigned long clk_rate, clk_rate_max = 0;
   170		int ret;
   171		u8 i;
   172		u32 mux = 0;
   173		u32 cssel_ovr = 0;
   174		u32 req2ack = 0;
   175	
   176		omm->clk = devm_clk_get(dev, NULL);
   177		if (IS_ERR(omm->clk)) {
   178			dev_err(dev, "Failed to get OMM clock (%ld)\n",
   179				PTR_ERR(omm->clk));
   180	
   181			return PTR_ERR(omm->clk);
   182		}
   183	
   184		ret = pm_runtime_resume_and_get(dev);
   185		if (ret < 0)
   186			return ret;
   187	
   188		/* parse children's clock */
   189		for (i = 0; i < omm->nb_child; i++) {
   190			clk_rate = clk_get_rate(omm->child[i].clk);
   191			if (!clk_rate) {
   192				dev_err(dev, "Invalid clock rate\n");
   193				goto err_clk_disable;
   194			}
   195	
   196			if (clk_rate > clk_rate_max)
   197				clk_rate_max = clk_rate;
   198		}
   199	
   200		rstc = devm_reset_control_get_optional_exclusive(dev, NULL);
   201		if (IS_ERR(rstc)) {
   202			ret = dev_err_probe(dev, PTR_ERR(rstc), "reset get failed\n");
   203			goto err_clk_disable;
   204		}
   205	
   206		reset_control_assert(rstc);
   207		udelay(2);
   208		reset_control_deassert(rstc);
   209	
   210		omm->cr = readl_relaxed(omm->io_base + OMM_CR);
   211		/* optional */
   212		ret = of_property_read_u32(dev->of_node, "st,omm-mux", &mux);
   213		if (!ret) {
   214			if (mux & CR_MUXEN) {
   215				ret = of_property_read_u32(dev->of_node, "st,omm-req2ack-ns",
   216							   &req2ack);
   217				if (!ret && !req2ack) {
   218					req2ack = DIV_ROUND_UP(req2ack, NSEC_PER_SEC / clk_rate_max) - 1;
   219	
   220					if (req2ack > 256)
   221						req2ack = 256;
   222				}
   223	
 > 224				req2ack = FIELD_PREP(CR_REQ2ACK_MASK, req2ack);
   225	
   226				omm->cr &= ~CR_REQ2ACK_MASK;
   227				omm->cr |= FIELD_PREP(CR_REQ2ACK_MASK, req2ack);
   228	
   229				/*
   230				 * If the mux is enabled, the 2 OSPI clocks have to be
   231				 * always enabled
   232				 */
   233				ret = stm32_omm_enable_child_clock(dev, true);
   234				if (ret)
   235					goto err_clk_disable;
   236			}
   237	
   238			omm->cr &= ~CR_MUXENMODE_MASK;
   239			omm->cr |= FIELD_PREP(CR_MUXENMODE_MASK, mux);
   240		}
   241	
   242		/* optional */
   243		ret = of_property_read_u32(dev->of_node, "st,omm-cssel-ovr", &cssel_ovr);
   244		if (!ret) {
   245			omm->cr &= ~CR_CSSEL_OVR_MASK;
   246			omm->cr |= FIELD_PREP(CR_CSSEL_OVR_MASK, cssel_ovr);
   247			omm->cr |= CR_CSSEL_OVR_EN;
   248		}
   249	
   250		omm->restore_omm = true;
   251		writel_relaxed(omm->cr, omm->io_base + OMM_CR);
   252	
   253		ret = stm32_omm_set_amcr(dev, true);
   254	
   255	err_clk_disable:
   256		pm_runtime_put_sync_suspend(dev);
   257	
   258		return ret;
   259	}
   260	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

