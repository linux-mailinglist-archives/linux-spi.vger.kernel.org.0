Return-Path: <linux-spi+bounces-1382-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC8585755A
	for <lists+linux-spi@lfdr.de>; Fri, 16 Feb 2024 05:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A6A31C218CC
	for <lists+linux-spi@lfdr.de>; Fri, 16 Feb 2024 04:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9248BF8;
	Fri, 16 Feb 2024 04:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c+Gw34X8"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5149EDDC1
	for <linux-spi@vger.kernel.org>; Fri, 16 Feb 2024 04:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708057939; cv=none; b=WcmhNUDy18FMl3bTmSS2wbd99NAuEVgPJyILOQULVVGrNVIpOFef37bNvwq4JwArbTAiUwXocnLpVMA7i4ma5uqUJ/VGP7H8LDiqlOy+nYef4n61B9u8mZaDQ4cszUqiW1k2kl1OUKIgxVWAb7NzR53jphOcb1TtuLEwHo9ohdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708057939; c=relaxed/simple;
	bh=jlPJAmJeItv7KDAYvLOXntvJEG7HDkogIX0eLhBjEWM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=X7KsqePh5yM8l2iwYQHLaWJrWb0IB6URiF+DMj+RmN2tAH7pCzuhpLf9/vOXeLjwUI6MW4+f5156u1z+K3+yOq5jR3iEsd79JpN7XOQ9tfeO97PHchUQrszeplEYZqPGP4ur6QzQKTnVeDdOY1BOaA4X8CBPoMcS41hi/WkHynU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c+Gw34X8; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708057937; x=1739593937;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jlPJAmJeItv7KDAYvLOXntvJEG7HDkogIX0eLhBjEWM=;
  b=c+Gw34X8ww+CBVpLny55WZqBxBXNDGk/pMM1JJ5UJbdAQOYJyjIQM1P9
   gybRMTHs3Z8mK1M/hNFc7HeTJ2aVHQcgiFdm7Xm7D8WNEl1vV70UrmX7G
   wuKf/7HALoXPrAM5EH93jWbuYklkGxFPqvEm4zKORZ3f7hgXu7KaKgaKq
   1VoqdJE2n9eqqehoz7pQ44LQI2ME0tiZmEPJTUuH7fKljx44wrSrvROgU
   UaAbOtRGyTqvUK3CECoKJG9TBpwsCXOeLtIlh8o2vnXQKaJl2OURSBQyd
   Wn5REdEkJXyBLaXDlwwqnY3sg11vF1DotY9H9IAGLZfy8pcyNHfPR4WUQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="5988793"
X-IronPort-AV: E=Sophos;i="6.06,163,1705392000"; 
   d="scan'208";a="5988793"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 20:32:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,163,1705392000"; 
   d="scan'208";a="8392637"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 15 Feb 2024 20:32:15 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1raptU-0000zs-2u;
	Fri, 16 Feb 2024 04:32:12 +0000
Date: Fri, 16 Feb 2024 12:32:10 +0800
From: kernel test robot <lkp@intel.com>
To: Thangaraj Samynathan <thangaraj.s@microchip.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-spi@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: [broonie-spi:for-next 55/73] drivers/spi/spi-pci1xxxx.c:373:34:
 sparse: sparse: incorrect type in argument 2 (different address spaces)
Message-ID: <202402161259.jvRF1aZx-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
head:   0f99484fc9d2a777818fc43a32d26cded4f8e556
commit: 9538edeb72c989a4b90964ae4bba107eaf21a791 [55/73] spi: mchp-pci1xxxx: DMA support for copying data to and from SPI Buf
config: mips-randconfig-r113-20240215 (https://download.01.org/0day-ci/archive/20240216/202402161259.jvRF1aZx-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 1c10821022f1799452065fb57474e894e2562b7f)
reproduce: (https://download.01.org/0day-ci/archive/20240216/202402161259.jvRF1aZx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402161259.jvRF1aZx-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/spi/spi-pci1xxxx.c:369:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *base @@     got void [noderef] __iomem * @@
   drivers/spi/spi-pci1xxxx.c:369:22: sparse:     expected void *base
   drivers/spi/spi-pci1xxxx.c:369:22: sparse:     got void [noderef] __iomem *
   drivers/spi/spi-pci1xxxx.c:371:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *base @@     got void [noderef] __iomem * @@
   drivers/spi/spi-pci1xxxx.c:371:22: sparse:     expected void *base
   drivers/spi/spi-pci1xxxx.c:371:22: sparse:     got void [noderef] __iomem *
>> drivers/spi/spi-pci1xxxx.c:373:34: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   drivers/spi/spi-pci1xxxx.c:373:34: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/spi/spi-pci1xxxx.c:373:34: sparse:     got void *
   drivers/spi/spi-pci1xxxx.c:374:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   drivers/spi/spi-pci1xxxx.c:374:26: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/spi/spi-pci1xxxx.c:374:26: sparse:     got void *
   drivers/spi/spi-pci1xxxx.c:375:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   drivers/spi/spi-pci1xxxx.c:375:46: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/spi/spi-pci1xxxx.c:375:46: sparse:     got void *
   drivers/spi/spi-pci1xxxx.c:376:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   drivers/spi/spi-pci1xxxx.c:376:46: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/spi/spi-pci1xxxx.c:376:46: sparse:     got void *
   drivers/spi/spi-pci1xxxx.c:378:21: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   drivers/spi/spi-pci1xxxx.c:378:21: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/spi/spi-pci1xxxx.c:378:21: sparse:     got void *
   drivers/spi/spi-pci1xxxx.c:380:21: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   drivers/spi/spi-pci1xxxx.c:380:21: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/spi/spi-pci1xxxx.c:380:21: sparse:     got void *

vim +373 drivers/spi/spi-pci1xxxx.c

   362	
   363	static void pci1xxxx_spi_setup_dma_from_io(struct pci1xxxx_spi_internal *p,
   364						   dma_addr_t dma_addr, u32 len)
   365	{
   366		void *base;
   367	
   368		if (!p->hw_inst)
 > 369			base = p->parent->dma_offset_bar + SPI_DMA_CH0_WR_BASE;
   370		else
   371			base = p->parent->dma_offset_bar + SPI_DMA_CH1_WR_BASE;
   372	
 > 373		writel(DMA_INTR_EN, base + SPI_DMA_CH_CTL1_OFFSET);
   374		writel(len, base + SPI_DMA_CH_XFER_LEN_OFFSET);
   375		writel(lower_32_bits(dma_addr), base + SPI_DMA_CH_DAR_LO_OFFSET);
   376		writel(upper_32_bits(dma_addr), base + SPI_DMA_CH_DAR_HI_OFFSET);
   377		writel(lower_32_bits(SPI_PERI_ADDR_BASE + SPI_MST_RSP_BUF_OFFSET(p->hw_inst)),
   378		       base + SPI_DMA_CH_SAR_LO_OFFSET);
   379		writel(upper_32_bits(SPI_PERI_ADDR_BASE + SPI_MST_RSP_BUF_OFFSET(p->hw_inst)),
   380		       base + SPI_DMA_CH_SAR_HI_OFFSET);
   381	}
   382	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

