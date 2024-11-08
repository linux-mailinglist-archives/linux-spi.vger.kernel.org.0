Return-Path: <linux-spi+bounces-5654-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F72B9C1366
	for <lists+linux-spi@lfdr.de>; Fri,  8 Nov 2024 02:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 477E12844CB
	for <lists+linux-spi@lfdr.de>; Fri,  8 Nov 2024 01:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C06F8BEA;
	Fri,  8 Nov 2024 01:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L3RygPSR"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861871BD9FB;
	Fri,  8 Nov 2024 01:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731027765; cv=none; b=a2hr/a2XAaQUoaeNC2ptkMAkwAYcDwQNkP0E3THQxYs+3GcDCbQnAJW26e1rRIt6QbmVLkAPa6En3QSeDSus2wOx+XqtwgBvnlm+fO188RK5/A+lNvZiBWw3mED3vPOnOJu+v2VbgZwG09fjTcAU6KRsVXuYTpw2FHRrIs9lZ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731027765; c=relaxed/simple;
	bh=GZkEOK11nLTG5sCW1VUVnGYZevL9I7vu4xi4O7heksc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXtScsS3YgcS2Vi2253uXqD9lg2e0Nlhg3W9psapxnEVwfkeBfa4KT1woJdyIiGRIwyjC1wxx5h3uGXgUko4Kd917N3wkDoIKck4SwBJxIcp4C97wTFQOX1EeG8Ny9Gh9fwJERVKw+29/0y++Q+ht/RuAXZ5DCaHT8lgJCAsuLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L3RygPSR; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731027764; x=1762563764;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GZkEOK11nLTG5sCW1VUVnGYZevL9I7vu4xi4O7heksc=;
  b=L3RygPSRPe8tzMmi8v6duY3ybPR/dBhY4601bOFVMqv16u014oIctFst
   PnGY0O5xsD0X0NcTAMslSJfWNzJYHiL/9Rpr/DBaaxVUajzQPUqGURdkh
   dghcLtX6/oFCFM6J+7sAxjKe7PX34BJsVVMbWtxixmVGeweI0T2WQjuhs
   0TZ40kFouByhLI4EYAu0kBkFSP2cJZOwp28I/gt0cOtpt1+OOUj0Nm4LC
   HLpwTF3J4C8rowK8ACn/e1xuoaIX90bwKtGLFvfx782ssyGB6/a26cRGC
   ODWJzqHR8EXpBGzlVz4K1uu0Uzg82knZYy9cjvv4CKJ/Ro+ogi+RCyG/H
   w==;
X-CSE-ConnectionGUID: pNDDSLbbSm6fsscAb44GtQ==
X-CSE-MsgGUID: +IEgcUXFTwe4xrC2Ax/k3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="31125249"
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="31125249"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 17:02:43 -0800
X-CSE-ConnectionGUID: OFxicbAhQcKvTfEBfAzY9Q==
X-CSE-MsgGUID: jt30Y2yDSyaCXqUsfx4Q2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="84926883"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 07 Nov 2024 17:02:39 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t9DOX-000qq6-0O;
	Fri, 08 Nov 2024 01:02:37 +0000
Date: Fri, 8 Nov 2024 09:02:07 +0800
From: kernel test robot <lkp@intel.com>
To: Jonas Rebmann <jre@pengutronix.de>, Mark Brown <broonie@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Jonas Rebmann <jre@pengutronix.de>
Subject: Re: [PATCH 2/2] spi: imx: support word delay
Message-ID: <202411080814.OtrMOufy-lkp@intel.com>
References: <20241107-imx-spi-word-delay-v1-2-2a969214d796@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107-imx-spi-word-delay-v1-2-2a969214d796@pengutronix.de>

Hi Jonas,

kernel test robot noticed the following build errors:

[auto build test ERROR on 9852d85ec9d492ebef56dc5f229416c925758edc]

url:    https://github.com/intel-lab-lkp/linux/commits/Jonas-Rebmann/spi-imx-pass-struct-spi_transfer-to-prepare_transfer/20241107-233756
base:   9852d85ec9d492ebef56dc5f229416c925758edc
patch link:    https://lore.kernel.org/r/20241107-imx-spi-word-delay-v1-2-2a969214d796%40pengutronix.de
patch subject: [PATCH 2/2] spi: imx: support word delay
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20241108/202411080814.OtrMOufy-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241108/202411080814.OtrMOufy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411080814.OtrMOufy-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/spi/spi-imx.c:9:
   In file included from include/linux/dmaengine.h:12:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/spi/spi-imx.c:9:
   In file included from include/linux/dmaengine.h:12:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/spi/spi-imx.c:9:
   In file included from include/linux/dmaengine.h:12:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/spi/spi-imx.c:9:
   In file included from include/linux/dmaengine.h:12:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> drivers/spi/spi-imx.c:739:7: error: call to undeclared function 'FIELD_FIT'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     739 |         if (!FIELD_FIT(MX51_ECSPI_PERIOD_MASK, word_delay_sck))
         |              ^
>> drivers/spi/spi-imx.c:742:9: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     742 |         writel(FIELD_PREP(MX51_ECSPI_PERIOD_MASK, word_delay_sck),
         |                ^
   7 warnings and 2 errors generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MODVERSIONS
   Depends on [n]: MODULES [=y] && !COMPILE_TEST [=y]
   Selected by [y]:
   - RANDSTRUCT_FULL [=y] && (CC_HAS_RANDSTRUCT [=y] || GCC_PLUGINS [=n]) && MODULES [=y]
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +/FIELD_FIT +739 drivers/spi/spi-imx.c

   665	
   666	static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
   667					       struct spi_device *spi, struct spi_transfer *t)
   668	{
   669		u32 ctrl = readl(spi_imx->base + MX51_ECSPI_CTRL);
   670		u64 word_delay_sck;
   671		u32 clk;
   672	
   673		/* Clear BL field and set the right value */
   674		ctrl &= ~MX51_ECSPI_CTRL_BL_MASK;
   675		if (spi_imx->target_mode && is_imx53_ecspi(spi_imx))
   676			ctrl |= (spi_imx->target_burst * 8 - 1)
   677				<< MX51_ECSPI_CTRL_BL_OFFSET;
   678		else {
   679			ctrl |= (spi_imx->bits_per_word - 1)
   680				<< MX51_ECSPI_CTRL_BL_OFFSET;
   681		}
   682	
   683		/* set clock speed */
   684		ctrl &= ~(0xf << MX51_ECSPI_CTRL_POSTDIV_OFFSET |
   685			  0xf << MX51_ECSPI_CTRL_PREDIV_OFFSET);
   686		ctrl |= mx51_ecspi_clkdiv(spi_imx, spi_imx->spi_bus_clk, &clk);
   687		spi_imx->spi_bus_clk = clk;
   688	
   689		mx51_configure_cpha(spi_imx, spi);
   690	
   691		/*
   692		 * ERR009165: work in XHC mode instead of SMC as PIO on the chips
   693		 * before i.mx6ul.
   694		 */
   695		if (spi_imx->usedma && spi_imx->devtype_data->tx_glitch_fixed)
   696			ctrl |= MX51_ECSPI_CTRL_SMC;
   697		else
   698			ctrl &= ~MX51_ECSPI_CTRL_SMC;
   699	
   700		writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
   701	
   702		/* calculate word delay in SPI Clock (SCLK) cycles */
   703		if (t->word_delay.value == 0) {
   704			word_delay_sck = 0;
   705		} else if (t->word_delay.unit == SPI_DELAY_UNIT_SCK) {
   706			word_delay_sck = t->word_delay.value;
   707	
   708			if (word_delay_sck <= MX51_ECSPI_PERIOD_MIN_DELAY_SCK)
   709				word_delay_sck = 0;
   710			else if (word_delay_sck <= MX51_ECSPI_PERIOD_MIN_DELAY_SCK + 1)
   711				word_delay_sck = 1;
   712			else
   713				word_delay_sck -= MX51_ECSPI_PERIOD_MIN_DELAY_SCK + 1;
   714		} else {
   715			int word_delay_ns;
   716	
   717			word_delay_ns = spi_delay_to_ns(&t->word_delay, t);
   718			if (word_delay_ns < 0)
   719				return word_delay_ns;
   720	
   721			if (word_delay_ns <= mul_u64_u32_div(NSEC_PER_SEC,
   722							     MX51_ECSPI_PERIOD_MIN_DELAY_SCK,
   723							     spi_imx->spi_bus_clk)) {
   724				word_delay_sck = 0;
   725			} else if (word_delay_ns <= mul_u64_u32_div(NSEC_PER_SEC,
   726								    MX51_ECSPI_PERIOD_MIN_DELAY_SCK + 1,
   727								    spi_imx->spi_bus_clk)) {
   728				word_delay_sck = 1;
   729			} else {
   730				word_delay_ns -= mul_u64_u32_div(NSEC_PER_SEC,
   731								 MX51_ECSPI_PERIOD_MIN_DELAY_SCK + 1,
   732								 spi_imx->spi_bus_clk);
   733	
   734				word_delay_sck = DIV_U64_ROUND_UP((u64)word_delay_ns * spi_imx->spi_bus_clk,
   735								  NSEC_PER_SEC);
   736			}
   737		}
   738	
 > 739		if (!FIELD_FIT(MX51_ECSPI_PERIOD_MASK, word_delay_sck))
   740			return -EINVAL;
   741	
 > 742		writel(FIELD_PREP(MX51_ECSPI_PERIOD_MASK, word_delay_sck),
   743		       spi_imx->base + MX51_ECSPI_PERIOD);
   744	
   745		return 0;
   746	}
   747	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

