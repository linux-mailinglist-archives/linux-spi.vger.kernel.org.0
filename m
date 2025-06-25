Return-Path: <linux-spi+bounces-8755-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CE8AE7664
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 07:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CDDF7AF09A
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 05:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109401DA60F;
	Wed, 25 Jun 2025 05:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V49jy8Wg"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE4A199FBA;
	Wed, 25 Jun 2025 05:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750829162; cv=none; b=HYRzMOOZ5AqhgkzZjRkhsny+MqNVBzEw1NMF9ncUmupCFNhA1hwn05bClXV9Q3+48aTyA3jSA5H00eP0tkHs7RncmVzsel+FT/YVrvV2M5ZMYwUaDF1AAsypDaeUO2Eh22hIoMWuHACbOiurHiQRHbHvpfD0g9YohTO4X9UcHOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750829162; c=relaxed/simple;
	bh=0hRDN1u+td/ykRY2vm1L2kpHhMG55EsaPbIq6V+qxC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUaWwW5pUoUqU+FFGy3lbf5mHMpq5lA90zlSFTz1fU4j1yAyxattttsZzkcnYNQoKULcYBr1zOJsg+U6JmOHkOfJfiv+2NDwYTo0hGEsZhL9h47L4UAF8SDf/F6ZEru14B3TUtM2clQ8McmCINy3WjNb8Z8dPos/O/PWpZPfqxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V49jy8Wg; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750829160; x=1782365160;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0hRDN1u+td/ykRY2vm1L2kpHhMG55EsaPbIq6V+qxC0=;
  b=V49jy8WgEE097EUng++RcmCiKAwGXnvmCh4UGrYlba8ZS8TMm32k9SX3
   8sps8j3zBjymv/KBsWs6u4JTzxFfFClRhlE5JBx7Bt2+SMEuO3+8sKMBU
   AWmN0Y7EYpMlDDzZ9k6jswAojsL3vNPuokpRhRs7zg3HPDGC1IYQ2qb4W
   55d3T6Y1T5qEV/VuHxRIEC5BtTj3DHQRgmNoEvU4efYGHssquMMsxV5sv
   oPKiiyRnBGA8Vqt5bJ5qBV3XG2z5N1H+VpCgdkDmXT0eJJlp3dMEogr8e
   cQxPHb6L4YMcsBTvsIhYEP2+lFysx7U878RvwmrgzzPoc1YfCfV7I/9dO
   A==;
X-CSE-ConnectionGUID: chTQIwsrSWihjlNqMibTTw==
X-CSE-MsgGUID: RUz+fDVpQxqeIaSrauA2Yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="56761505"
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="56761505"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 22:26:00 -0700
X-CSE-ConnectionGUID: ixov8sJuSMyuGT/+aXJspQ==
X-CSE-MsgGUID: rAcO2f4sTmWHpLFigXyuZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="156145722"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 24 Jun 2025 22:25:56 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uUIdu-000Smg-1O;
	Wed, 25 Jun 2025 05:25:54 +0000
Date: Wed, 25 Jun 2025 13:25:08 +0800
From: kernel test robot <lkp@intel.com>
To: James Clark <james.clark@linaro.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Frank Li <Frank.li@nxp.com>, Christoph Hellwig <hch@lst.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	James Clark <james.clark@linaro.org>
Subject: Re: [PATCH v3 3/6] spi: spi-fsl-dspi: Stub out DMA functions
Message-ID: <202506251332.thYB4ced-lkp@intel.com>
References: <20250624-james-nxp-spi-dma-v3-3-e7d574f5f62c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624-james-nxp-spi-dma-v3-3-e7d574f5f62c@linaro.org>

Hi James,

kernel test robot noticed the following build errors:

[auto build test ERROR on 4f326fa6236787ca516ea6eab8e5e9dc5c236f03]

url:    https://github.com/intel-lab-lkp/linux/commits/James-Clark/spi-spi-fsl-dspi-Clear-completion-counter-before-initiating-transfer/20250624-183952
base:   4f326fa6236787ca516ea6eab8e5e9dc5c236f03
patch link:    https://lore.kernel.org/r/20250624-james-nxp-spi-dma-v3-3-e7d574f5f62c%40linaro.org
patch subject: [PATCH v3 3/6] spi: spi-fsl-dspi: Stub out DMA functions
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20250625/202506251332.thYB4ced-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250625/202506251332.thYB4ced-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506251332.thYB4ced-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/spi/spi-fsl-dspi.c: In function 'dspi_dma_xfer':
>> drivers/spi/spi-fsl-dspi.c:729:9: error: 'sdpi' undeclared (first use in this function); did you mean 'dspi'?
     729 |         sdpi->cur_msg->status = -EINVAL;
         |         ^~~~
         |         dspi
   drivers/spi/spi-fsl-dspi.c:729:9: note: each undeclared identifier is reported only once for each function it appears in
   drivers/spi/spi-fsl-dspi.c: At top level:
>> drivers/spi/spi-fsl-dspi.c:474:12: warning: 'dspi_pop_tx_pushr' defined but not used [-Wunused-function]
     474 | static u32 dspi_pop_tx_pushr(struct fsl_dspi *dspi)
         |            ^~~~~~~~~~~~~~~~~


vim +729 drivers/spi/spi-fsl-dspi.c

   705	
   706	static void dspi_release_dma(struct fsl_dspi *dspi)
   707	{
   708		int dma_bufsize = dspi->devtype_data->fifo_size * 2;
   709		struct fsl_dspi_dma *dma = dspi->dma;
   710	
   711		if (!dma)
   712			return;
   713	
   714		if (dma->chan_tx) {
   715			dma_free_coherent(dma->chan_tx->device->dev, dma_bufsize,
   716					  dma->tx_dma_buf, dma->tx_dma_phys);
   717			dma_release_channel(dma->chan_tx);
   718		}
   719	
   720		if (dma->chan_rx) {
   721			dma_free_coherent(dma->chan_rx->device->dev, dma_bufsize,
   722					  dma->rx_dma_buf, dma->rx_dma_phys);
   723			dma_release_channel(dma->chan_rx);
   724		}
   725	}
   726	#else
   727	static void dspi_dma_xfer(struct fsl_dspi *dspi)
   728	{
 > 729		sdpi->cur_msg->status = -EINVAL;
   730	}
   731	static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
   732	{
   733		dev_err(&dspi->pdev->dev, "DMA support not enabled in kernel\n");
   734		return -EINVAL;
   735	}
   736	static void dspi_release_dma(struct fsl_dspi *dspi) {}
   737	#endif
   738	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

