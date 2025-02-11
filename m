Return-Path: <linux-spi+bounces-6761-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0779CA31263
	for <lists+linux-spi@lfdr.de>; Tue, 11 Feb 2025 18:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9B153A7160
	for <lists+linux-spi@lfdr.de>; Tue, 11 Feb 2025 17:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B15260A32;
	Tue, 11 Feb 2025 17:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JHEhO+JG"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6648524E4C2;
	Tue, 11 Feb 2025 17:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739293543; cv=none; b=hGnUvFGWyxV3QPdfY7gG3n/zZI6tHDdp+mhDYbmIyT1PBbSgRsIdvf+v6lNWpxBZXx/LP/rSX/EW7zcFMpWJ6swZIB/MwdiB6tr87YX8hW0NyJ1TaP1pvWNPmZbaSU+rKEJpBRLtD3a6M6au+7APGCfXZ07TyG2Zj6J8Uk52rQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739293543; c=relaxed/simple;
	bh=DE0r5jDm6YNSZPF5FU1DrOY1OpFwcpY96sjKQMUlUkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMVoHUcoNSyMExriFBVKO1xrPQkDcVjqaC9weOAkXnzVoGAaGkoHU7RPHBFuQpaTUQjA78zSOM6sPExfjqU9xBw+wARX+cVK6U+BoUdUXdC4LoD70SHDrA5unpekYfmuIjg3qGBQxIf7vUxAdnR2WeSr612oGKjkqC9KsguJbZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JHEhO+JG; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739293542; x=1770829542;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DE0r5jDm6YNSZPF5FU1DrOY1OpFwcpY96sjKQMUlUkM=;
  b=JHEhO+JGPa+/HZFGmYFGpl5iP8HJ6BDkKvHrGBu0KBQPJcYnMB+Gs/SG
   n/QJk3roWwl6UfiBOjt9rxQmXxRUQA5XoJDJbhxKEFjFyLEumd3/u0wfm
   wU9cn3435iI0FxlBgHx3hEOZvbLaxXoFVNPzCmLeNKmPl/2+xY+runU9f
   7LgQzyNt0t7/XApHS1Cv3pwrJWQTZiwA8IkdrK5g0jKi1YNTV7oab4piF
   3lEx7AbY8Gn3qn9bzrpS0qGjcsulf4MijDxSzcXJk8SSHbOaF9V8YPWZb
   T2HBHeyN7pnTAbaJj0oQ5HdFZ5nRoXbHk9fNUyRLBt8RVqDw+oEiNJkRr
   Q==;
X-CSE-ConnectionGUID: ZG/jALMZRGOLQZM0wjyPGQ==
X-CSE-MsgGUID: ZVLlTnZOR+mqt0TaCTqDQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="40048242"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="40048242"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 09:05:41 -0800
X-CSE-ConnectionGUID: PyB6JRaRTtimkzGv6rTkog==
X-CSE-MsgGUID: Jb+IUSR8RQW98MPBjjwg1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="112546840"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 11 Feb 2025 09:05:36 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ththW-0014TX-0H;
	Tue, 11 Feb 2025 17:05:34 +0000
Date: Wed, 12 Feb 2025 01:04:59 +0800
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
Message-ID: <202502120005.pznVoB0E-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-spi/for-next]
[also build test WARNING on atorgue-stm32/stm32-next krzk-mem-ctrl/for-next linus/master v6.14-rc2 next-20250210]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/patrice-chotard-foss-st-com/dt-bindings-spi-Add-STM32-OSPI-controller/20250210-212554
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20250210131826.220318-5-patrice.chotard%40foss.st.com
patch subject: [PATCH v3 4/8] memory: Add STM32 Octo Memory Manager driver
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20250212/202502120005.pznVoB0E-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250212/202502120005.pznVoB0E-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502120005.pznVoB0E-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/platform_device.h:13,
                    from include/linux/bus/stm32_firewall_device.h:10,
                    from drivers/memory/stm32_omm.c:7:
   drivers/memory/stm32_omm.c: In function 'stm32_omm_set_amcr':
>> drivers/memory/stm32_omm.c:82:38: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 3 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
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
   drivers/memory/stm32_omm.c:82:45: note: format string is defined here
      82 |                         dev_err(dev, "[0x%llx-0x%llx] doesn't fit inside [0x%llx-0x%llx]\n",
         |                                          ~~~^
         |                                             |
         |                                             long long unsigned int
         |                                          %x
   drivers/memory/stm32_omm.c:82:38: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
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
   drivers/memory/stm32_omm.c:82:52: note: format string is defined here
      82 |                         dev_err(dev, "[0x%llx-0x%llx] doesn't fit inside [0x%llx-0x%llx]\n",
         |                                                 ~~~^
         |                                                    |
         |                                                    long long unsigned int
         |                                                 %x
   drivers/memory/stm32_omm.c:82:38: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 5 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
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


vim +82 drivers/memory/stm32_omm.c

    44	
    45	static int stm32_omm_set_amcr(struct device *dev, bool set)
    46	{
    47		struct stm32_omm *omm = dev_get_drvdata(dev);
    48		struct regmap *syscfg_regmap;
    49		struct device_node *node;
    50		struct resource res, res1;
    51		resource_size_t mm_ospi2_size = 0;
    52		static const char * const mm_name[] = { "ospi1", "ospi2" };
    53		u32 amcr_base, amcr_mask;
    54		int ret, i, idx;
    55		unsigned int amcr, read_amcr;
    56	
    57		for (i = 0; i < omm->nb_child; i++) {
    58			idx = of_property_match_string(dev->of_node,
    59						       "memory-region-names",
    60						       mm_name[i]);
    61			if (idx < 0)
    62				continue;
    63	
    64			/* res1 only used on second loop iteration */
    65			res1.start = res.start;
    66			res1.end = res.end;
    67	
    68			node = of_parse_phandle(dev->of_node, "memory-region", idx);
    69			if (!node)
    70				continue;
    71	
    72			ret = of_address_to_resource(node, 0, &res);
    73			if (ret) {
    74				dev_err(dev, "unable to resolve memory region\n");
    75				return ret;
    76			}
    77	
    78			/* check that memory region fits inside OMM memory map area */
    79			if (!resource_contains(omm->mm_res, &res)) {
    80				dev_err(dev, "%s doesn't fit inside OMM memory map area\n",
    81					mm_name[i]);
  > 82				dev_err(dev, "[0x%llx-0x%llx] doesn't fit inside [0x%llx-0x%llx]\n",
    83					res.start, res.end,
    84					omm->mm_res->start, omm->mm_res->end);
    85	
    86				return -EFAULT;
    87			}
    88	
    89			if (i == 1) {
    90				mm_ospi2_size = resource_size(&res);
    91	
    92				/* check that OMM memory region 1 doesn't overlap memory region 2 */
    93				if (resource_overlaps(&res, &res1)) {
    94					dev_err(dev, "OMM memory-region %s overlaps memory region %s\n",
    95						mm_name[0], mm_name[1]);
    96					dev_err(dev, "[0x%llx-0x%llx] overlaps [0x%llx-0x%llx]\n",
    97						res1.start, res1.end, res.start, res.end);
    98	
    99					return -EFAULT;
   100				}
   101			}
   102		}
   103	
   104		syscfg_regmap = syscon_regmap_lookup_by_phandle(dev->of_node, "st,syscfg-amcr");
   105		if (IS_ERR(syscfg_regmap)) {
   106			dev_err(dev, "Failed to get st,syscfg-amcr property\n");
   107			return PTR_ERR(syscfg_regmap);
   108		}
   109	
   110		ret = of_property_read_u32_index(dev->of_node, "st,syscfg-amcr", 1,
   111						 &amcr_base);
   112		if (ret)
   113			return ret;
   114	
   115		ret = of_property_read_u32_index(dev->of_node, "st,syscfg-amcr", 2,
   116						 &amcr_mask);
   117		if (ret)
   118			return ret;
   119	
   120		amcr = mm_ospi2_size / SZ_64M;
   121	
   122		if (set)
   123			regmap_update_bits(syscfg_regmap, amcr_base, amcr_mask, amcr);
   124	
   125		/* read AMCR and check coherency with memory-map areas defined in DT */
   126		regmap_read(syscfg_regmap, amcr_base, &read_amcr);
   127		read_amcr = read_amcr >> (ffs(amcr_mask) - 1);
   128	
   129		if (amcr != read_amcr) {
   130			dev_err(dev, "AMCR value not coherent with DT memory-map areas\n");
   131			ret = -EINVAL;
   132		}
   133	
   134		return ret;
   135	}
   136	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

