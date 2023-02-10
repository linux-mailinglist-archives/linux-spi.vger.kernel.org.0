Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6316928E8
	for <lists+linux-spi@lfdr.de>; Fri, 10 Feb 2023 22:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbjBJVFw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Feb 2023 16:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbjBJVFv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 Feb 2023 16:05:51 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AE76CC42
        for <linux-spi@vger.kernel.org>; Fri, 10 Feb 2023 13:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676063150; x=1707599150;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+S/K8eMD3x9PIF1tFFiF+7qJDB4BvX1h427QlI/NJZE=;
  b=KEXg1Yj94bDFkrXcRZXpFPa2Al2cVtrcDCHt+rDRP1T0RrMNMltmIAEl
   TWoQpcud77HjBp4ZjLCLoqTrAr4okdWjV/9bPHYAHiz9RFj+SG5MQWCKq
   w0OYUGCbbQC2WfA2H6oHqbvBmT0FTOe/hfVe2t9YJR1JfTYd2UUGH1EP/
   TZcK0cJPp0JH8N7bwvVq9Yr897cQk+S3XBovSZ/by3x6keehSH3cb6txI
   iQlLHWUqi3rG73mRxhuArinjhn3oNK5XtcaNGtnB6uk/rIkf1s/hL4Fyg
   1WEJr0gPIXi2bgwPkhQy53EMS6JzxCKsi2wpgM2/Vjo/3LAuQVtmXWxF7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="328217551"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="328217551"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 13:05:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="913674545"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="913674545"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 10 Feb 2023 13:05:48 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pQaaY-00063h-2g;
        Fri, 10 Feb 2023 21:05:46 +0000
Date:   Sat, 11 Feb 2023 05:05:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Kursad Oney <kursad.oney@broadcom.com>
Subject: [broonie-spi:for-next 32/35] drivers/spi/spi-bcm63xx-hsspi.c:197:31:
 sparse: sparse: cast from restricted __be16
Message-ID: <202302110438.sQwQnU54-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
head:   2ea9b08a661274b9b7b182327bf6ffe29605d671
commit: 85a84a61699990db6a025b5073f337f49933a875 [32/35] spi: bcm63xx-hsspi: Endianness fix for ARM based SoC
config: arm-randconfig-s032-20230210 (https://download.01.org/0day-ci/archive/20230211/202302110438.sQwQnU54-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/commit/?id=85a84a61699990db6a025b5073f337f49933a875
        git remote add broonie-spi https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
        git fetch --no-tags broonie-spi for-next
        git checkout 85a84a61699990db6a025b5073f337f49933a875
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash drivers/spi/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302110438.sQwQnU54-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/spi/spi-bcm63xx-hsspi.c:197:31: sparse: sparse: cast from restricted __be16

vim +197 drivers/spi/spi-bcm63xx-hsspi.c

   156	
   157	static int bcm63xx_hsspi_do_txrx(struct spi_device *spi, struct spi_transfer *t)
   158	{
   159		struct bcm63xx_hsspi *bs = spi_master_get_devdata(spi->master);
   160		unsigned int chip_select = spi->chip_select;
   161		u16 opcode = 0;
   162		int pending = t->len;
   163		int step_size = HSSPI_BUFFER_LEN;
   164		const u8 *tx = t->tx_buf;
   165		u8 *rx = t->rx_buf;
   166	
   167		bcm63xx_hsspi_set_clk(bs, spi, t->speed_hz);
   168		bcm63xx_hsspi_set_cs(bs, spi->chip_select, true);
   169	
   170		if (tx && rx)
   171			opcode = HSSPI_OP_READ_WRITE;
   172		else if (tx)
   173			opcode = HSSPI_OP_WRITE;
   174		else if (rx)
   175			opcode = HSSPI_OP_READ;
   176	
   177		if (opcode != HSSPI_OP_READ)
   178			step_size -= HSSPI_OPCODE_LEN;
   179	
   180		if ((opcode == HSSPI_OP_READ && t->rx_nbits == SPI_NBITS_DUAL) ||
   181		    (opcode == HSSPI_OP_WRITE && t->tx_nbits == SPI_NBITS_DUAL))
   182			opcode |= HSSPI_OP_MULTIBIT;
   183	
   184		__raw_writel(1 << MODE_CTRL_MULTIDATA_WR_SIZE_SHIFT |
   185			     1 << MODE_CTRL_MULTIDATA_RD_SIZE_SHIFT | 0xff,
   186			     bs->regs + HSSPI_PROFILE_MODE_CTRL_REG(chip_select));
   187	
   188		while (pending > 0) {
   189			int curr_step = min_t(int, step_size, pending);
   190	
   191			reinit_completion(&bs->done);
   192			if (tx) {
   193				memcpy_toio(bs->fifo + HSSPI_OPCODE_LEN, tx, curr_step);
   194				tx += curr_step;
   195			}
   196	
 > 197			__raw_writew((u16)cpu_to_be16(opcode | curr_step), bs->fifo);
   198	
   199			/* enable interrupt */
   200			__raw_writel(HSSPI_PINGx_CMD_DONE(0),
   201				     bs->regs + HSSPI_INT_MASK_REG);
   202	
   203			/* start the transfer */
   204			__raw_writel(!chip_select << PINGPONG_CMD_SS_SHIFT |
   205				     chip_select << PINGPONG_CMD_PROFILE_SHIFT |
   206				     PINGPONG_COMMAND_START_NOW,
   207				     bs->regs + HSSPI_PINGPONG_COMMAND_REG(0));
   208	
   209			if (wait_for_completion_timeout(&bs->done, HZ) == 0) {
   210				dev_err(&bs->pdev->dev, "transfer timed out!\n");
   211				return -ETIMEDOUT;
   212			}
   213	
   214			if (rx) {
   215				memcpy_fromio(rx, bs->fifo, curr_step);
   216				rx += curr_step;
   217			}
   218	
   219			pending -= curr_step;
   220		}
   221	
   222		return 0;
   223	}
   224	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
