Return-Path: <linux-spi+bounces-11733-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C155C9E02A
	for <lists+linux-spi@lfdr.de>; Wed, 03 Dec 2025 08:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79B713AC3BC
	for <lists+linux-spi@lfdr.de>; Wed,  3 Dec 2025 07:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE34429AAEA;
	Wed,  3 Dec 2025 07:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FiMwlDkU"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE7A2550D7;
	Wed,  3 Dec 2025 07:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764745225; cv=none; b=CMktSyqAuR7l63D3kqUHepCCvx9sXsfmKQsurqG8SiwD5zjPLAq/zeHBREJaQI9SL3BX9vYeTqP1TLhABUBbokoeCu+LA1SOQpLauhossqVhMITUqtN4WlClnMUfDxzM3Mkf/jvbF1XQKfOghtC7TUliKcvoUMZyzAnUCmLnUsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764745225; c=relaxed/simple;
	bh=BbpnT+nHAKfc3yROfFOj29+WeIOEVrl1j2gKJu3ZWdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMvf4mIb6+8BryWuwj0Os7IDHnPw17PBOAoI5PXqOqNID13/ivpWH55mOvIr843U2WQSS9cI9D01HL8Qk9QBIQfm2sLcE3rDwTUaw9yCi+atJhLK0+6tCl81ZTVATmwbHDyCqtapoZAcsBBSRVU60t6Au3P0kWyY4kHYznXXsbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FiMwlDkU; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764745224; x=1796281224;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BbpnT+nHAKfc3yROfFOj29+WeIOEVrl1j2gKJu3ZWdA=;
  b=FiMwlDkUwhkBoQt34Zabt4xvJYpI10lgZfipJ6xLAEqsVZtFD95f0Jae
   d4uH8fpdNlIgq0+0nN8dk920Il/rUspmCQfV6T3aHC79iln7lSg7pvTbS
   blEAlogItBdm894ZhQjNbYn+2MC5rfq/SdYs0imjSQK82y2tNJfMTDkEs
   VfH34gmT2yCMV1fociq9MSJcNsJzIiMrQ4GmvTGxaHAPhU6sOpwar1q+T
   CNZwdwkXnofnStHOO9fPo3EjuB1p+ad6n9huBLsSUOMJa1E6IXaFZZfir
   5Jm5aLkZZMATeAFpqk4PS72qc9nrKXbKIbfP+GcX/LbYnV4sFbKanJqD6
   Q==;
X-CSE-ConnectionGUID: NN0SNnsHRKuSnbuAAB44Ow==
X-CSE-MsgGUID: Q7UkRWLbRV+WIcBlglvU1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="54280047"
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="54280047"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 23:00:23 -0800
X-CSE-ConnectionGUID: vttOtOV4SHi8K8SNjtneyg==
X-CSE-MsgGUID: 8k+m/DnYQPiasvfEOKvb7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="225271918"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 02 Dec 2025 23:00:20 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vQgqX-00000000AgD-22Pq;
	Wed, 03 Dec 2025 07:00:17 +0000
Date: Wed, 3 Dec 2025 14:59:30 +0800
From: kernel test robot <lkp@intel.com>
To: Carlos Song <carlos.song@nxp.com>, frank.li@nxp.com, mkl@pengutronix.de,
	broonie@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, kees@kernel.org,
	gustavoars@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org, Carlos Song <carlos.song@nxp.com>
Subject: Re: [PATCH v2 5/6] spi: imx: support dynamic burst length for ECSPI
 DMA mode
Message-ID: <202512031425.cmBJXuXy-lkp@intel.com>
References: <20251202075503.2448339-6-carlos.song@nxp.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202075503.2448339-6-carlos.song@nxp.com>

Hi Carlos,

kernel test robot noticed the following build errors:

[auto build test ERROR on v6.18]
[also build test ERROR on linus/master next-20251202]
[cannot apply to shawnguo/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Carlos-Song/spi-imx-group-spi_imx_dma_configure-with-spi_imx_dma_transfer/20251202-160030
base:   v6.18
patch link:    https://lore.kernel.org/r/20251202075503.2448339-6-carlos.song%40nxp.com
patch subject: [PATCH v2 5/6] spi: imx: support dynamic burst length for ECSPI DMA mode
config: csky-allmodconfig (https://download.01.org/0day-ci/archive/20251203/202512031425.cmBJXuXy-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251203/202512031425.cmBJXuXy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512031425.cmBJXuXy-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/spi/spi-imx.c:144:34: error: 'counted_by' attribute is not allowed for a non-array field
     144 |         struct dma_data_package *dma_data __counted_by(dma_package_num);
         |                                  ^~~~~~~~


vim +/counted_by +144 drivers/spi/spi-imx.c

   107	
   108	struct spi_imx_data {
   109		struct spi_controller *controller;
   110		struct device *dev;
   111	
   112		struct completion xfer_done;
   113		void __iomem *base;
   114		unsigned long base_phys;
   115	
   116		struct clk *clk_per;
   117		struct clk *clk_ipg;
   118		unsigned long spi_clk;
   119		unsigned int spi_bus_clk;
   120	
   121		unsigned int bits_per_word;
   122		unsigned int spi_drctl;
   123	
   124		unsigned int count, remainder;
   125		void (*tx)(struct spi_imx_data *spi_imx);
   126		void (*rx)(struct spi_imx_data *spi_imx);
   127		void *rx_buf;
   128		const void *tx_buf;
   129		unsigned int txfifo; /* number of words pushed in tx FIFO */
   130		unsigned int dynamic_burst;
   131		bool rx_only;
   132	
   133		/* Target mode */
   134		bool target_mode;
   135		bool target_aborted;
   136		unsigned int target_burst;
   137	
   138		/* DMA */
   139		bool usedma;
   140		u32 wml;
   141		struct completion dma_rx_completion;
   142		struct completion dma_tx_completion;
   143		size_t dma_package_num;
 > 144		struct dma_data_package *dma_data __counted_by(dma_package_num);
   145		int rx_offset;
   146	
   147		const struct spi_imx_devtype_data *devtype_data;
   148	};
   149	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

