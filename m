Return-Path: <linux-spi+bounces-6762-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BBAA31399
	for <lists+linux-spi@lfdr.de>; Tue, 11 Feb 2025 18:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F28B83A278A
	for <lists+linux-spi@lfdr.de>; Tue, 11 Feb 2025 17:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410A21E231F;
	Tue, 11 Feb 2025 17:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KGxGsk6N"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953961E25FA;
	Tue, 11 Feb 2025 17:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739296611; cv=none; b=b714eidQTqgoUdd40YC5nyCIP/Luiu0hn4z5UeG90AEpx0O1HYkAsLSHCR2Di5MGctAn62E1EpjREeUu8G0HNOgp3O8JySgA+HZXRShedl/eMeu5DVuuv5897gFjM2is4tc+rU9AcNR65qIOFpVu7tWepgI3PIongzh8MFf9MYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739296611; c=relaxed/simple;
	bh=tUfnbQLqPmzNMMTnPDZCp5d6eeH/3wvctepWEQ6MdPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzEXFgzu3ND/biw9G06P5kwyZfW/Awlvgzs6KMv1qLXFL2xEXv06L8p1K8NCiybPXSHKt7JCx30W0DVN4shvPqDd1Vve4KNX+CNTdcCFViEDfNOnCY0HLfbNTrgB66ZyEwAF3cKAB7tUB44aHnBdTiYyc2WV5q6hSHTaVs4SU80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KGxGsk6N; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739296609; x=1770832609;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tUfnbQLqPmzNMMTnPDZCp5d6eeH/3wvctepWEQ6MdPE=;
  b=KGxGsk6NrKtdcN3c5X76v9+8g29aU/129TQd3SVFqKSaimD6wr7EMyho
   z5ITlKgfMSARsJuDsnjIHohg2Gy9WJ2w80HceJgiZZl0Q8hIQnvV02dUP
   i+Zaicv8wDRPKwfBtRvST/AdwnIb8H/jK5P3xo+OMQSJsTsFjk9ZEt85d
   Adbo41X1QQwread+k8g/qZXa0IkzQk7VlbmkKA8HaC1G5kQdtKyHincEq
   sabt4SUeJZcK0R3Z6zQ+TRf1pcLHD7aiUF//f+01mzYXMHDw1ziqtzutN
   2sSTht1aVc4QCu0Xse5gC33VunbsLA1kyHORSPoSVLX6p5nGmTIKvwG4j
   Q==;
X-CSE-ConnectionGUID: wSn974jbQK+oVpWMwMXOQw==
X-CSE-MsgGUID: 5MZWVdXvRZWrWDWG9xyRsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39812844"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="39812844"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 09:56:48 -0800
X-CSE-ConnectionGUID: UsqZjJAaRQq3xmGjVQ4LIw==
X-CSE-MsgGUID: Xams3y/UT4yCGUgFrWF3dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="143430133"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 11 Feb 2025 09:56:43 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1thuUx-0014Wl-1g;
	Tue, 11 Feb 2025 17:56:39 +0000
Date: Wed, 12 Feb 2025 01:56:27 +0800
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
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	christophe.kerello@foss.st.com, patrice.chotard@foss.st.com
Subject: Re: [PATCH v3 4/8] memory: Add STM32 Octo Memory Manager driver
Message-ID: <202502120118.27fjrRqt-lkp@intel.com>
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
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20250212/202502120118.27fjrRqt-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 6807164500e9920638e2ab0cdb4bf8321d24f8eb)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250212/202502120118.27fjrRqt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502120118.27fjrRqt-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/memory/stm32_omm.c:83:5: warning: format specifies type 'unsigned long long' but the argument has type 'resource_size_t' (aka 'unsigned int') [-Wformat]
      82 |                         dev_err(dev, "[0x%llx-0x%llx] doesn't fit inside [0x%llx-0x%llx]\n",
         |                                          ~~~~
         |                                          %x
      83 |                                 res.start, res.end,
         |                                 ^~~~~~~~~
   include/linux/dev_printk.h:154:65: note: expanded from macro 'dev_err'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                                ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ~~~    ^~~~~~~~~~~
   drivers/memory/stm32_omm.c:83:16: warning: format specifies type 'unsigned long long' but the argument has type 'resource_size_t' (aka 'unsigned int') [-Wformat]
      82 |                         dev_err(dev, "[0x%llx-0x%llx] doesn't fit inside [0x%llx-0x%llx]\n",
         |                                                 ~~~~
         |                                                 %x
      83 |                                 res.start, res.end,
         |                                            ^~~~~~~
   include/linux/dev_printk.h:154:65: note: expanded from macro 'dev_err'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                                ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ~~~    ^~~~~~~~~~~
   drivers/memory/stm32_omm.c:84:5: warning: format specifies type 'unsigned long long' but the argument has type 'resource_size_t' (aka 'unsigned int') [-Wformat]
      82 |                         dev_err(dev, "[0x%llx-0x%llx] doesn't fit inside [0x%llx-0x%llx]\n",
         |                                                                             ~~~~
         |                                                                             %x
      83 |                                 res.start, res.end,
      84 |                                 omm->mm_res->start, omm->mm_res->end);
         |                                 ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:154:65: note: expanded from macro 'dev_err'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                                ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ~~~    ^~~~~~~~~~~
   drivers/memory/stm32_omm.c:84:25: warning: format specifies type 'unsigned long long' but the argument has type 'resource_size_t' (aka 'unsigned int') [-Wformat]
      82 |                         dev_err(dev, "[0x%llx-0x%llx] doesn't fit inside [0x%llx-0x%llx]\n",
         |                                                                                    ~~~~
         |                                                                                    %x
      83 |                                 res.start, res.end,
      84 |                                 omm->mm_res->start, omm->mm_res->end);
         |                                                     ^~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:154:65: note: expanded from macro 'dev_err'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                                ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ~~~    ^~~~~~~~~~~
   drivers/memory/stm32_omm.c:97:6: warning: format specifies type 'unsigned long long' but the argument has type 'resource_size_t' (aka 'unsigned int') [-Wformat]
      96 |                                 dev_err(dev, "[0x%llx-0x%llx] overlaps [0x%llx-0x%llx]\n",
         |                                                  ~~~~
         |                                                  %x
      97 |                                         res1.start, res1.end, res.start, res.end);
         |                                         ^~~~~~~~~~
   include/linux/dev_printk.h:154:65: note: expanded from macro 'dev_err'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                                ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ~~~    ^~~~~~~~~~~
   drivers/memory/stm32_omm.c:97:18: warning: format specifies type 'unsigned long long' but the argument has type 'resource_size_t' (aka 'unsigned int') [-Wformat]
      96 |                                 dev_err(dev, "[0x%llx-0x%llx] overlaps [0x%llx-0x%llx]\n",
         |                                                         ~~~~
         |                                                         %x
      97 |                                         res1.start, res1.end, res.start, res.end);
         |                                                     ^~~~~~~~
   include/linux/dev_printk.h:154:65: note: expanded from macro 'dev_err'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                                ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ~~~    ^~~~~~~~~~~
   drivers/memory/stm32_omm.c:97:28: warning: format specifies type 'unsigned long long' but the argument has type 'resource_size_t' (aka 'unsigned int') [-Wformat]
      96 |                                 dev_err(dev, "[0x%llx-0x%llx] overlaps [0x%llx-0x%llx]\n",
         |                                                                           ~~~~
         |                                                                           %x
      97 |                                         res1.start, res1.end, res.start, res.end);
         |                                                               ^~~~~~~~~
   include/linux/dev_printk.h:154:65: note: expanded from macro 'dev_err'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                                ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ~~~    ^~~~~~~~~~~
   drivers/memory/stm32_omm.c:97:39: warning: format specifies type 'unsigned long long' but the argument has type 'resource_size_t' (aka 'unsigned int') [-Wformat]
      96 |                                 dev_err(dev, "[0x%llx-0x%llx] overlaps [0x%llx-0x%llx]\n",
         |                                                                                  ~~~~
         |                                                                                  %x
      97 |                                         res1.start, res1.end, res.start, res.end);
         |                                                                          ^~~~~~~
   include/linux/dev_printk.h:154:65: note: expanded from macro 'dev_err'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                                ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ~~~    ^~~~~~~~~~~
>> drivers/memory/stm32_omm.c:224:14: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     224 |                         req2ack = FIELD_PREP(CR_REQ2ACK_MASK, req2ack);
         |                                   ^
   drivers/memory/stm32_omm.c:239:14: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     239 |                 omm->cr |= FIELD_PREP(CR_MUXENMODE_MASK, mux);
         |                            ^
   drivers/memory/stm32_omm.c:246:14: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     246 |                 omm->cr |= FIELD_PREP(CR_CSSEL_OVR_MASK, cssel_ovr);
         |                            ^
   8 warnings and 3 errors generated.


vim +/FIELD_PREP +224 drivers/memory/stm32_omm.c

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
    82				dev_err(dev, "[0x%llx-0x%llx] doesn't fit inside [0x%llx-0x%llx]\n",
  > 83					res.start, res.end,
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
   137	static int stm32_omm_enable_child_clock(struct device *dev, bool enable)
   138	{
   139		/* As there is only 2 children, remember first child in case of error */
   140		struct clk *first_child_clk = NULL;
   141		struct stm32_omm *omm = dev_get_drvdata(dev);
   142		u8 i;
   143		int ret;
   144	
   145		for (i = 0; i < omm->nb_child; i++) {
   146			if (enable) {
   147				ret = clk_prepare_enable(omm->child[i].clk);
   148				if (ret) {
   149					if (first_child_clk)
   150						clk_disable_unprepare(first_child_clk);
   151	
   152					dev_err(dev, "Can not enable clock\n");
   153					return ret;
   154				}
   155			} else {
   156				clk_disable_unprepare(omm->child[i].clk);
   157			}
   158	
   159			first_child_clk = omm->child[i].clk;
   160		}
   161	
   162		return 0;
   163	}
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

