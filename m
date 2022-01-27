Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB8D49D716
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jan 2022 02:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbiA0BBa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Jan 2022 20:01:30 -0500
Received: from mga12.intel.com ([192.55.52.136]:30543 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231296AbiA0BB3 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 26 Jan 2022 20:01:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643245289; x=1674781289;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZqzKQi/M+zMRq7Jo/9eu3NijJDkLZzCMZbcsqAyWW4o=;
  b=TAjkAds6A0RX168Mouu3F186lQ/1crA6iNeFrS+C8uo6tjXU0ozCdEPl
   bm6tD4sWMlxyjnqDnpofrOhHBTUdmi6A/11hVK2g+xzeqmQ5rJSdS9deQ
   cf0rP6OgNEOte69BbkXF3O5fISkZrDlnq0zXcNGNm7XO3LaJTxIf0c9r/
   aHPgpH4oczYF4eXdnS8UI/JD8NLEIh/WYIt0OiRHC6kjAJ9RyIjHzhGKD
   aZushs4HZWS1cbkb9byKGCFDjcOxQhW9DV2DX3MFT78N9uvIffFhUBS1D
   GY2fToVQnhgYntoc2s0MKEWuqtYbUB6Nb48yJt5JsOFyyIIz0bOjZ0/tw
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="226684518"
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="226684518"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 17:01:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="495548168"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 26 Jan 2022 17:01:27 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCtAF-000Lt4-Ad; Thu, 27 Jan 2022 01:01:27 +0000
Date:   Thu, 27 Jan 2022 09:00:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Li-hao Kuo <lhjeff911@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [broonie-spi:for-next 8/10] drivers/spi/spi-sunplus-sp7021.c:127:5:
 warning: no previous prototype for function 'sp7021_spi_slave_tx'
Message-ID: <202201270842.3zOvXRxn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
head:   474fc2e6395d62758e80b9ea65f61339296355fc
commit: f62ca4e2a863033d9b3b5a00a0d897557c9da6c5 [8/10] spi: Add spi driver for Sunplus SP7021
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20220127/202201270842.3zOvXRxn-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 2a1b7aa016c0f4b5598806205bdfbab1ea2d92c4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/commit/?id=f62ca4e2a863033d9b3b5a00a0d897557c9da6c5
        git remote add broonie-spi https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
        git fetch --no-tags broonie-spi for-next
        git checkout f62ca4e2a863033d9b3b5a00a0d897557c9da6c5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/spi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/spi/spi-sunplus-sp7021.c:127:5: warning: no previous prototype for function 'sp7021_spi_slave_tx' [-Wmissing-prototypes]
   int sp7021_spi_slave_tx(struct spi_device *spi, struct spi_transfer *xfer)
       ^
   drivers/spi/spi-sunplus-sp7021.c:127:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int sp7021_spi_slave_tx(struct spi_device *spi, struct spi_transfer *xfer)
   ^
   static 
>> drivers/spi/spi-sunplus-sp7021.c:145:5: warning: no previous prototype for function 'sp7021_spi_slave_rx' [-Wmissing-prototypes]
   int sp7021_spi_slave_rx(struct spi_device *spi, struct spi_transfer *xfer)
       ^
   drivers/spi/spi-sunplus-sp7021.c:145:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int sp7021_spi_slave_rx(struct spi_device *spi, struct spi_transfer *xfer)
   ^
   static 
>> drivers/spi/spi-sunplus-sp7021.c:163:6: warning: no previous prototype for function 'sp7021_spi_master_rb' [-Wmissing-prototypes]
   void sp7021_spi_master_rb(struct sp7021_spi_ctlr *pspim, unsigned int len)
        ^
   drivers/spi/spi-sunplus-sp7021.c:163:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void sp7021_spi_master_rb(struct sp7021_spi_ctlr *pspim, unsigned int len)
   ^
   static 
>> drivers/spi/spi-sunplus-sp7021.c:174:6: warning: no previous prototype for function 'sp7021_spi_master_wb' [-Wmissing-prototypes]
   void sp7021_spi_master_wb(struct sp7021_spi_ctlr *pspim, unsigned int len)
        ^
   drivers/spi/spi-sunplus-sp7021.c:174:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void sp7021_spi_master_wb(struct sp7021_spi_ctlr *pspim, unsigned int len)
   ^
   static 
   drivers/spi/spi-sunplus-sp7021.c:560:12: warning: unused function 'sp7021_spi_runtime_suspend' [-Wunused-function]
   static int sp7021_spi_runtime_suspend(struct device *dev)
              ^
   drivers/spi/spi-sunplus-sp7021.c:568:12: warning: unused function 'sp7021_spi_runtime_resume' [-Wunused-function]
   static int sp7021_spi_runtime_resume(struct device *dev)
              ^
   6 warnings generated.


vim +/sp7021_spi_slave_tx +127 drivers/spi/spi-sunplus-sp7021.c

   126	
 > 127	int sp7021_spi_slave_tx(struct spi_device *spi, struct spi_transfer *xfer)
   128	{
   129		struct sp7021_spi_ctlr *pspim = spi_controller_get_devdata(spi->controller);
   130	
   131		reinit_completion(&pspim->slave_isr);
   132		writel(SP7021_SLAVE_DMA_EN | SP7021_SLAVE_DMA_RW | FIELD_PREP(SP7021_SLAVE_DMA_CMD, 3),
   133		       pspim->s_base + SP7021_SLAVE_DMA_CTRL_REG);
   134		writel(xfer->len, pspim->s_base + SP7021_SLAVE_DMA_LENGTH_REG);
   135		writel(xfer->tx_dma, pspim->s_base + SP7021_SLAVE_DMA_ADDR_REG);
   136		writel(readl(pspim->s_base + SP7021_DATA_RDY_REG) | SP7021_SLAVE_DATA_RDY,
   137		       pspim->s_base + SP7021_DATA_RDY_REG);
   138		if (wait_for_completion_interruptible(&pspim->isr_done)) {
   139			dev_err(&spi->dev, "%s() wait_for_completion err\n", __func__);
   140			return -EINTR;
   141		}
   142		return 0;
   143	}
   144	
 > 145	int sp7021_spi_slave_rx(struct spi_device *spi, struct spi_transfer *xfer)
   146	{
   147		struct sp7021_spi_ctlr *pspim = spi_controller_get_devdata(spi->controller);
   148		int ret = 0;
   149	
   150		reinit_completion(&pspim->isr_done);
   151		writel(SP7021_SLAVE_DMA_EN | FIELD_PREP(SP7021_SLAVE_DMA_CMD, 3),
   152		       pspim->s_base + SP7021_SLAVE_DMA_CTRL_REG);
   153		writel(xfer->len, pspim->s_base + SP7021_SLAVE_DMA_LENGTH_REG);
   154		writel(xfer->rx_dma, pspim->s_base + SP7021_SLAVE_DMA_ADDR_REG);
   155		if (wait_for_completion_interruptible(&pspim->isr_done)) {
   156			dev_err(&spi->dev, "%s() wait_for_completion err\n", __func__);
   157			return -EINTR;
   158		}
   159		writel(SP7021_SLAVE_SW_RST, pspim->s_base + SP7021_SLAVE_DMA_CTRL_REG);
   160		return ret;
   161	}
   162	
 > 163	void sp7021_spi_master_rb(struct sp7021_spi_ctlr *pspim, unsigned int len)
   164	{
   165		int i;
   166	
   167		for (i = 0; i < len; i++) {
   168			pspim->rx_buf[pspim->rx_cur_len] =
   169				readl(pspim->m_base + SP7021_FIFO_REG);
   170			pspim->rx_cur_len++;
   171		}
   172	}
   173	
 > 174	void sp7021_spi_master_wb(struct sp7021_spi_ctlr *pspim, unsigned int len)
   175	{
   176		int i;
   177	
   178		for (i = 0; i < len; i++) {
   179			writel(pspim->tx_buf[pspim->tx_cur_len],
   180			       pspim->m_base + SP7021_FIFO_REG);
   181			pspim->tx_cur_len++;
   182		}
   183	}
   184	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
