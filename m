Return-Path: <linux-spi+bounces-6130-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B20BE9F9995
	for <lists+linux-spi@lfdr.de>; Fri, 20 Dec 2024 19:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D547189A1BB
	for <lists+linux-spi@lfdr.de>; Fri, 20 Dec 2024 18:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8589D21C17B;
	Fri, 20 Dec 2024 18:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TE2sNz4d"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D27921D011;
	Fri, 20 Dec 2024 18:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734719224; cv=none; b=Iy1YXosaY1BsyzzIvMDi7o3h/1AE+XZ6Ov9nWCoUN2BwGVrivj4upFnDrR9UuValHv3Jl/0RU4UdFZnoPHX7Gp3DSKgXsboiajYVnB8BV7LAiIRQX8aEUZgoZu29fy8EavbVJ2xVbPdbHj9+rAM6eydHD8H3XPqgfFfK7pz0Ubw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734719224; c=relaxed/simple;
	bh=lVeG2+LVxzEoZ+Rnc836huFlQp02+Oj9SvSRKpveDbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rca6LB7MoN9XMmCmY7jokHjpyTvVnarlzRL6JuREC5dOqkUHrOLd4/+TLJpF+DAC89grjBI9/i+LSVZ5AZc/FegdaRtsad12j22q+1ZDBkfPqxecBrtosAJa3v96pak9JyibGLLGNACwJc9M124P26l7oSOzj0IPLdzH61n5Wyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TE2sNz4d; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734719222; x=1766255222;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lVeG2+LVxzEoZ+Rnc836huFlQp02+Oj9SvSRKpveDbo=;
  b=TE2sNz4d8fsH7yf7xfr6MZ/YBbi8/DMQFbhYQx3YKhOFunLubhIYfd9q
   jUhuzZH4VIU8ZE6aMosYRk2oqlF2aXpnWNgV5hFaZzRqG9FEZ/ajM929P
   7OMEmI26tTwESOi17pzhYmt0wwy9hAzwNh9/M74vNGsHEhgxni4cHJzbb
   6eY3ypHgHpObWHJZsaDgN8S45s/EAdmEzQ4h5V686YNIBQ/cO+UAlhE0f
   /mdhzjOG4IIrboZHemXJTdOLwkTkkKxU1DaZFageLLDSBYNgiC4cuygsG
   4EfdYhz+swT2W+0fxMP5771L0dkOrRlp6wbMwnPmc2DJwj8kFVW5+aglV
   A==;
X-CSE-ConnectionGUID: aOG1QyxARVewGR6zYlIMKg==
X-CSE-MsgGUID: Xs0wiNz+QNKZBXmtK/c8pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="45882395"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="45882395"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 10:27:02 -0800
X-CSE-ConnectionGUID: K4pW+d6OTAmFjJn+m7+PFQ==
X-CSE-MsgGUID: lM36vNWZR1qKyNPD2rstbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="98354381"
Received: from lkp-server01.sh.intel.com (HELO a46f226878e0) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 20 Dec 2024 10:26:59 -0800
Received: from kbuild by a46f226878e0 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tOhiC-0001Wd-3B;
	Fri, 20 Dec 2024 18:26:56 +0000
Date: Sat, 21 Dec 2024 02:26:45 +0800
From: kernel test robot <lkp@intel.com>
To: mtk22730 <Cloud.Zhang@mediatek.com>, Mark Brown <broonie@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com,
	Cloud Zhang <cloud.zhang@mediatek.com>
Subject: Re: [PATCH] [v1] spi: spi-mtk-nor: Modify the clock architecture of
 nor controller
Message-ID: <202412210247.Brq06CHb-lkp@intel.com>
References: <20241212092206.14071-1-Cloud.Zhang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212092206.14071-1-Cloud.Zhang@mediatek.com>

Hi mtk22730,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-spi/for-next]
[also build test WARNING on linus/master v6.13-rc3 next-20241220]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/mtk22730/spi-spi-mtk-nor-Modify-the-clock-architecture-of-nor-controller/20241212-172704
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20241212092206.14071-1-Cloud.Zhang%40mediatek.com
patch subject: [PATCH] [v1] spi: spi-mtk-nor: Modify the clock architecture of nor controller
config: um-randconfig-002-20241220 (https://download.01.org/0day-ci/archive/20241221/202412210247.Brq06CHb-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 9daf10ff8f29ba3a88a105aaa9d2379c21b77d35)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241221/202412210247.Brq06CHb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412210247.Brq06CHb-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/spi/spi-mtk-nor.c:10:
   In file included from include/linux/dma-mapping.h:8:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/spi/spi-mtk-nor.c:10:
   In file included from include/linux/dma-mapping.h:8:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:549:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     549 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:567:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     567 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/spi/spi-mtk-nor.c:10:
   In file included from include/linux/dma-mapping.h:8:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:585:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/spi/spi-mtk-nor.c:10:
   In file included from include/linux/dma-mapping.h:8:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:601:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     601 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:616:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     616 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:631:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     631 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:724:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     724 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:737:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     737 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:750:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     750 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:764:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     764 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:778:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     778 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:792:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     792 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> drivers/spi/spi-mtk-nor.c:746:19: warning: result of comparison of constant -22 with expression of type 'u8' (aka 'unsigned char') is always false [-Wtautological-constant-out-of-range-compare]
     746 |         if (!cnt || (cnt == -EINVAL)) {
         |                      ~~~ ^  ~~~~~~~
   14 warnings generated.


vim +746 drivers/spi/spi-mtk-nor.c

   737	
   738	static int mtk_nor_parse_clk(struct device *dev, struct mtk_nor *sp)
   739	{
   740		struct device_node *np = dev->of_node;
   741		int ret;
   742		const char *name;
   743		u8 cnt, i;
   744	
   745		cnt = of_property_count_strings(np, "clock-names");
 > 746		if (!cnt || (cnt == -EINVAL)) {
   747			dev_err(dev, "Unable to find clocks\n");
   748			ret = -EINVAL;
   749			goto out;
   750		} else if (cnt < 0) {
   751			dev_err(dev, "Count clock strings failed, err %d\n", cnt);
   752			ret = cnt;
   753			goto out;
   754		} else if (cnt > MAX_CLOCK_CNT) {
   755			ret = -EINVAL;
   756			goto out;
   757		}
   758	
   759		sp->clock_cnt = cnt;
   760	
   761		for (i = 0; i < cnt; i++) {
   762			ret = of_property_read_string_index(np, "clock-names", i,
   763					       &name);
   764			if (ret) {
   765				dev_err(dev, "failed to get clock string\n");
   766				return ret;
   767			}
   768	
   769			sp->clocks[i].name = name;
   770			sp->clocks[i].clki = devm_clk_get(dev, sp->clocks[i].name);
   771			if (IS_ERR(sp->clocks[i].clki)) {
   772				dev_err(dev, "get clock %s fail\n", sp->clocks[i].name);
   773				return PTR_ERR(sp->clocks[i].clki);
   774			}
   775		}
   776	
   777	out:
   778		return ret;
   779	}
   780	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

