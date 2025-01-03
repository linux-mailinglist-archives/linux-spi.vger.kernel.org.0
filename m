Return-Path: <linux-spi+bounces-6216-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D35A010DA
	for <lists+linux-spi@lfdr.de>; Sat,  4 Jan 2025 00:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36BE3160932
	for <lists+linux-spi@lfdr.de>; Fri,  3 Jan 2025 23:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414E11C5F0C;
	Fri,  3 Jan 2025 23:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EgaI2doN"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF331C303E;
	Fri,  3 Jan 2025 23:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735946195; cv=none; b=HsFJlRFWReKlSfTaFRlwu4SCA19Z+oHFLc7BvvKOFW4afjg0D6ST5Bg5Snom5nKm/uMglbv/4MVQwbbP6Oe3Qs2y2tG2mvfYx6DWWbWY77LbuASc1bnjI8k4R5xV+PTDIG5gRg8DDjMPzFIR5YnETQrxRYjgAz9Hpfj+tdrxR/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735946195; c=relaxed/simple;
	bh=owrUnM+nIWZ95VR7cDcnMg419HxPMKLa94ZI5r6SWjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbnG/BXTRpoE9yuCO3a/jhQo6dwuSCYNlZXXokd6jpglNRQXnOUFQJk8+Jg7cdIzTxfxM6WqPShajLyn1SxWVS+Yj2/x7WNxMlmvyjDeI4xsinOBeMwMyovxmReJBDOO5S5XW2RSGwglsfiuViKQ48WC4K4T7Hgppeek3n4lAEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EgaI2doN; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735946191; x=1767482191;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=owrUnM+nIWZ95VR7cDcnMg419HxPMKLa94ZI5r6SWjM=;
  b=EgaI2doNe2emw5jvAKZmAooo68jnf3Bd4OzsjNPy3DhUmnDDzU1WrAii
   vTnEkkD9A8Dd3uDgqZLUDnx4aWX0WhVkjT02k+SgfRHbIUaxI5sy9Cpr2
   mdq/xVKafE+Dj2Jbjw6fCDWuU0bw5+OZCC8QIliWwK9PoAr2A8BBa5oha
   UIzqP5vNcWRdHTtQbjhh0Q8wvAf6REhpt1JDmjwv6bD6C5tqnMnRbjYja
   whiS/UJQHlW/1GGRJr8gk9j14LrSWFZJLApV8lbQt4Bk8Nf6/slHoL9Z5
   Bu4RSfC4ZQAXItfEti0Ys5SqtL+fOh8imsmIURO06hb/LxjsCzYipAsKC
   g==;
X-CSE-ConnectionGUID: qXdqLWn7TCOEVP0EjNzMtQ==
X-CSE-MsgGUID: NCecEOEnT8m7b99jIosMiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11304"; a="39876206"
X-IronPort-AV: E=Sophos;i="6.12,287,1728975600"; 
   d="scan'208";a="39876206"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2025 15:16:31 -0800
X-CSE-ConnectionGUID: UF9PNUgwTMCxWUKJY2zcXQ==
X-CSE-MsgGUID: 6C1kIxuYRjGomNAizh72eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,287,1728975600"; 
   d="scan'208";a="132748428"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 03 Jan 2025 15:16:27 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tTqu1-000AQx-1y;
	Fri, 03 Jan 2025 23:16:25 +0000
Date: Sat, 4 Jan 2025 07:16:02 +0800
From: kernel test robot <lkp@intel.com>
To: Vishwaroop A <va@nvidia.com>, thierry.reding@gmail.com,
	jonathanh@nvidia.com, skomatineni@nvidia.com, ldewangan@nvidia.com,
	broonie@kernel.org, linux-spi@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	kyarlagadda@nvidia.com, smangipudi@nvidia.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, va@nvidia.com
Subject: Re: [PATCH V1 6/6] spi: tegra210-quad: Introduce native DMA support
Message-ID: <202501040605.Ndat3QJw-lkp@intel.com>
References: <20250103060407.1064107-7-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103060407.1064107-7-va@nvidia.com>

Hi Vishwaroop,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-spi/for-next]
[also build test WARNING on robh/for-next broonie-sound/for-next linus/master v6.13-rc5 next-20241220]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vishwaroop-A/arm64-tegra-Configure-QSPI-clocks-and-add-DMA/20250103-141217
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20250103060407.1064107-7-va%40nvidia.com
patch subject: [PATCH V1 6/6] spi: tegra210-quad: Introduce native DMA support
config: arm-randconfig-001-20250104 (https://download.01.org/0day-ci/archive/20250104/202501040605.Ndat3QJw-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 096551537b2a747a3387726ca618ceeb3950e9bc)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250104/202501040605.Ndat3QJw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501040605.Ndat3QJw-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/spi/spi-tegra210-quad.c:8:
   In file included from include/linux/dmaengine.h:12:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/spi/spi-tegra210-quad.c:721:43: warning: shift count >= width of type [-Wshift-count-overflow]
     721 |                         tegra_qspi_writel(tqspi, ((rx_dma_phys >> 32) & 0xff),
         |                                                                ^  ~~
   2 warnings generated.


vim +721 drivers/spi/spi-tegra210-quad.c

   616	
   617	static int tegra_qspi_start_dma_based_transfer(struct tegra_qspi *tqspi, struct spi_transfer *t)
   618	{
   619		struct dma_slave_config dma_sconfig = { 0 };
   620		dma_addr_t rx_dma_phys, tx_dma_phys;
   621		unsigned int len;
   622		u8 dma_burst;
   623		int ret = 0;
   624		u32 val;
   625		bool has_ext_dma = tqspi->soc_data->has_ext_dma;
   626	
   627		if (tqspi->is_packed) {
   628			ret = tegra_qspi_dma_map_xfer(tqspi, t);
   629			if (ret < 0)
   630				return ret;
   631		}
   632	
   633		val = QSPI_DMA_BLK_SET(tqspi->curr_dma_words - 1);
   634		tegra_qspi_writel(tqspi, val, QSPI_DMA_BLK);
   635	
   636		tegra_qspi_unmask_irq(tqspi);
   637	
   638		if (tqspi->is_packed)
   639			len = DIV_ROUND_UP(tqspi->curr_dma_words * tqspi->bytes_per_word, 4) * 4;
   640		else
   641			len = tqspi->curr_dma_words * 4;
   642	
   643		/* set attention level based on length of transfer */
   644		if (has_ext_dma) {
   645			val = 0;
   646			if (len & 0xf) {
   647				val |= QSPI_TX_TRIG_1 | QSPI_RX_TRIG_1;
   648				dma_burst = 1;
   649			} else if (((len) >> 4) & 0x1) {
   650				val |= QSPI_TX_TRIG_4 | QSPI_RX_TRIG_4;
   651				dma_burst = 4;
   652			} else {
   653				val |= QSPI_TX_TRIG_8 | QSPI_RX_TRIG_8;
   654				dma_burst = 8;
   655			}
   656	
   657			tegra_qspi_writel(tqspi, val, QSPI_DMA_CTL);
   658		}
   659	
   660		tqspi->dma_control_reg = val;
   661	
   662		dma_sconfig.device_fc = true;
   663	
   664		if ((tqspi->cur_direction & DATA_DIR_TX)) {
   665			if (has_ext_dma) {
   666				dma_sconfig.dst_addr = tqspi->phys + QSPI_TX_FIFO;
   667				dma_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
   668				dma_sconfig.dst_maxburst = dma_burst;
   669				ret = dmaengine_slave_config(tqspi->tx_dma_chan, &dma_sconfig);
   670				if (ret < 0) {
   671					dev_err(tqspi->dev, "failed DMA slave config: %d\n", ret);
   672					return ret;
   673				}
   674	
   675				tegra_qspi_copy_client_txbuf_to_qspi_txbuf(tqspi, t);
   676				ret = tegra_qspi_start_tx_dma(tqspi, t, len);
   677				if (ret < 0) {
   678					dev_err(tqspi->dev, "failed to starting TX DMA: %d\n", ret);
   679					return ret;
   680				}
   681			} else {
   682				if (tqspi->is_packed)
   683					tx_dma_phys = t->tx_dma;
   684				else
   685					tx_dma_phys = tqspi->tx_dma_phys;
   686				tegra_qspi_copy_client_txbuf_to_qspi_txbuf(tqspi, t);
   687				tegra_qspi_writel(tqspi, lower_32_bits(tx_dma_phys),
   688						  QSPI_DMA_MEM_ADDRESS_REG);
   689				tegra_qspi_writel(tqspi, (upper_32_bits(tx_dma_phys) & 0xff),
   690						  QSPI_DMA_HI_ADDRESS_REG);
   691			}
   692		}
   693	
   694		if (tqspi->cur_direction & DATA_DIR_RX) {
   695			if (has_ext_dma) {
   696				dma_sconfig.src_addr = tqspi->phys + QSPI_RX_FIFO;
   697				dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
   698				dma_sconfig.src_maxburst = dma_burst;
   699				ret = dmaengine_slave_config(tqspi->rx_dma_chan, &dma_sconfig);
   700				if (ret < 0) {
   701					dev_err(tqspi->dev, "failed DMA slave config: %d\n", ret);
   702					return ret;
   703				}
   704				dma_sync_single_for_device(tqspi->dev, tqspi->rx_dma_phys,
   705							   tqspi->dma_buf_size, DMA_FROM_DEVICE);
   706				ret = tegra_qspi_start_rx_dma(tqspi, t, len);
   707				if (ret < 0) {
   708					dev_err(tqspi->dev, "failed to start RX DMA: %d\n", ret);
   709					if (tqspi->cur_direction & DATA_DIR_TX)
   710						dmaengine_terminate_all(tqspi->tx_dma_chan);
   711					return ret;
   712				}
   713			} else {
   714				if (tqspi->is_packed)
   715					rx_dma_phys = t->rx_dma;
   716				else
   717					rx_dma_phys = tqspi->rx_dma_phys;
   718	
   719				tegra_qspi_writel(tqspi, (rx_dma_phys & 0xffffffff),
   720						  QSPI_DMA_MEM_ADDRESS_REG);
 > 721				tegra_qspi_writel(tqspi, ((rx_dma_phys >> 32) & 0xff),
   722						  QSPI_DMA_HI_ADDRESS_REG);
   723			}
   724		}
   725	
   726		tegra_qspi_writel(tqspi, tqspi->command1_reg, QSPI_COMMAND1);
   727	
   728		tqspi->is_curr_dma_xfer = true;
   729		tqspi->dma_control_reg = val;
   730		val |= QSPI_DMA_EN;
   731		tegra_qspi_writel(tqspi, val, QSPI_DMA_CTL);
   732	
   733		return ret;
   734	}
   735	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

