Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE832C24D4
	for <lists+linux-spi@lfdr.de>; Tue, 24 Nov 2020 12:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732879AbgKXLlt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Nov 2020 06:41:49 -0500
Received: from mga18.intel.com ([134.134.136.126]:33882 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732548AbgKXLls (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 24 Nov 2020 06:41:48 -0500
IronPort-SDR: +ud2RnQD6BF7NVeDcwe3T3D9Abc1Qmoqv9vKeo13vKbas9WujJsNvKwD5jhRhAw3XYcQ+yqyRh
 pdV08TE+4/4g==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="159697047"
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="gz'50?scan'50,208,50";a="159697047"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 03:41:45 -0800
IronPort-SDR: /S27TWzxz8FotQd1CHbGxe/eOKUCmLZSK9Ne2VmhwrjTWV79TgFWG3DJGDPiPoIdT+0ZoRXQgJ
 NGT+9Wv2oQbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="gz'50?scan'50,208,50";a="343140367"
Received: from lkp-server01.sh.intel.com (HELO 2820ec516a85) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 24 Nov 2020 03:41:42 -0800
Received: from kbuild by 2820ec516a85 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1khWhZ-00005I-QJ; Tue, 24 Nov 2020 11:41:41 +0000
Date:   Tue, 24 Nov 2020 19:41:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, broonie@kernel.org, robh+dt@kernel.org,
        andy.shevchenko@gmail.com, dragos.bogdan@analog.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH v2 1/3] spi: convert to BIT() all spi_device flags
Message-ID: <202011241920.ygGHVBJg-lkp@intel.com>
References: <20201124102152.16548-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <20201124102152.16548-1-alexandru.ardelean@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Alexandru,

I love your patch! Perhaps something to improve:

[auto build test WARNING on spi/for-next]
[also build test WARNING on next-20201123]
[cannot apply to v5.10-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Alexandru-Ardelean/spi-convert-to-BIT-all-spi_device-flags/20201124-181801
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
config: i386-randconfig-a016-20201124 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/1d45734a72568cc2118c14f912affda571a5f9dc
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Alexandru-Ardelean/spi-convert-to-BIT-all-spi_device-flags/20201124-181801
        git checkout 1d45734a72568cc2118c14f912affda571a5f9dc
        # save the attached .config to linux build tree
        make W=1 ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/dmaengine.h:8,
                    from drivers/spi/spi-stm32.c:11:
   drivers/spi/spi-stm32.c: In function 'stm32_spi_prepare_msg':
>> drivers/spi/spi-stm32.c:1030:20: warning: format '%d' expects argument of type 'int', but argument 4 has type 'long unsigned int' [-Wformat=]
    1030 |  dev_dbg(spi->dev, "cpol=%d cpha=%d lsb_first=%d cs_high=%d\n",
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:19:22: note: in definition of macro 'dev_fmt'
      19 | #define dev_fmt(fmt) fmt
         |                      ^~~
   drivers/spi/spi-stm32.c:1030:2: note: in expansion of macro 'dev_dbg'
    1030 |  dev_dbg(spi->dev, "cpol=%d cpha=%d lsb_first=%d cs_high=%d\n",
         |  ^~~~~~~
   drivers/spi/spi-stm32.c:1030:27: note: format string is defined here
    1030 |  dev_dbg(spi->dev, "cpol=%d cpha=%d lsb_first=%d cs_high=%d\n",
         |                          ~^
         |                           |
         |                           int
         |                          %ld
   In file included from include/linux/device.h:15,
                    from include/linux/dmaengine.h:8,
                    from drivers/spi/spi-stm32.c:11:
   drivers/spi/spi-stm32.c:1030:20: warning: format '%d' expects argument of type 'int', but argument 5 has type 'long unsigned int' [-Wformat=]
    1030 |  dev_dbg(spi->dev, "cpol=%d cpha=%d lsb_first=%d cs_high=%d\n",
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:19:22: note: in definition of macro 'dev_fmt'
      19 | #define dev_fmt(fmt) fmt
         |                      ^~~
   drivers/spi/spi-stm32.c:1030:2: note: in expansion of macro 'dev_dbg'
    1030 |  dev_dbg(spi->dev, "cpol=%d cpha=%d lsb_first=%d cs_high=%d\n",
         |  ^~~~~~~
   drivers/spi/spi-stm32.c:1030:35: note: format string is defined here
    1030 |  dev_dbg(spi->dev, "cpol=%d cpha=%d lsb_first=%d cs_high=%d\n",
         |                                  ~^
         |                                   |
         |                                   int
         |                                  %ld
   In file included from include/linux/device.h:15,
                    from include/linux/dmaengine.h:8,
                    from drivers/spi/spi-stm32.c:11:
   drivers/spi/spi-stm32.c:1030:20: warning: format '%d' expects argument of type 'int', but argument 6 has type 'long unsigned int' [-Wformat=]
    1030 |  dev_dbg(spi->dev, "cpol=%d cpha=%d lsb_first=%d cs_high=%d\n",
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:19:22: note: in definition of macro 'dev_fmt'
      19 | #define dev_fmt(fmt) fmt
         |                      ^~~
   drivers/spi/spi-stm32.c:1030:2: note: in expansion of macro 'dev_dbg'
    1030 |  dev_dbg(spi->dev, "cpol=%d cpha=%d lsb_first=%d cs_high=%d\n",
         |  ^~~~~~~
   drivers/spi/spi-stm32.c:1030:48: note: format string is defined here
    1030 |  dev_dbg(spi->dev, "cpol=%d cpha=%d lsb_first=%d cs_high=%d\n",
         |                                               ~^
         |                                                |
         |                                                int
         |                                               %ld
   In file included from include/linux/device.h:15,
                    from include/linux/dmaengine.h:8,
                    from drivers/spi/spi-stm32.c:11:
   drivers/spi/spi-stm32.c:1030:20: warning: format '%d' expects argument of type 'int', but argument 7 has type 'long unsigned int' [-Wformat=]
    1030 |  dev_dbg(spi->dev, "cpol=%d cpha=%d lsb_first=%d cs_high=%d\n",
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:19:22: note: in definition of macro 'dev_fmt'
      19 | #define dev_fmt(fmt) fmt
         |                      ^~~
   drivers/spi/spi-stm32.c:1030:2: note: in expansion of macro 'dev_dbg'
    1030 |  dev_dbg(spi->dev, "cpol=%d cpha=%d lsb_first=%d cs_high=%d\n",
         |  ^~~~~~~
   drivers/spi/spi-stm32.c:1030:59: note: format string is defined here
    1030 |  dev_dbg(spi->dev, "cpol=%d cpha=%d lsb_first=%d cs_high=%d\n",
         |                                                          ~^
         |                                                           |
         |                                                           int
         |                                                          %ld

vim +1030 drivers/spi/spi-stm32.c

dcbe0d84dfa5a3e Amelie Delaunay 2017-06-21   995  
dcbe0d84dfa5a3e Amelie Delaunay 2017-06-21   996  /**
dcbe0d84dfa5a3e Amelie Delaunay 2017-06-21   997   * stm32_spi_prepare_msg - set up the controller to transfer a single message
1c52be8bed83e1a Alain Volmat    2020-03-20   998   * @master: controller master interface
1c52be8bed83e1a Alain Volmat    2020-03-20   999   * @msg: pointer to spi message
dcbe0d84dfa5a3e Amelie Delaunay 2017-06-21  1000   */
dcbe0d84dfa5a3e Amelie Delaunay 2017-06-21  1001  static int stm32_spi_prepare_msg(struct spi_master *master,
dcbe0d84dfa5a3e Amelie Delaunay 2017-06-21  1002  				 struct spi_message *msg)
dcbe0d84dfa5a3e Amelie Delaunay 2017-06-21  1003  {
dcbe0d84dfa5a3e Amelie Delaunay 2017-06-21  1004  	struct stm32_spi *spi = spi_master_get_devdata(master);
dcbe0d84dfa5a3e Amelie Delaunay 2017-06-21  1005  	struct spi_device *spi_dev = msg->spi;
dcbe0d84dfa5a3e Amelie Delaunay 2017-06-21  1006  	struct device_node *np = spi_dev->dev.of_node;
dcbe0d84dfa5a3e Amelie Delaunay 2017-06-21  1007  	unsigned long flags;
55166853b2f56ce Cezary Gapinski 2018-12-24  1008  	u32 clrb = 0, setb = 0;
dcbe0d84dfa5a3e Amelie Delaunay 2017-06-21  1009  
dcbe0d84dfa5a3e Amelie Delaunay 2017-06-21  1010  	/* SPI slave device may need time between data frames */
dcbe0d84dfa5a3e Amelie Delaunay 2017-06-21  1011  	spi->cur_midi = 0;
042c1c60df7b854 Amelie Delaunay 2017-06-27  1012  	if (np && !of_property_read_u32(np, "st,spi-midi-ns", &spi->cur_midi))
dcbe0d84dfa5a3e Amelie Delaunay 2017-06-21  1013  		dev_dbg(spi->dev, "%dns inter-data idleness\n", spi->cur_midi);
dcbe0d84dfa5a3e Amelie Delaunay 2017-06-21  1014  
dcbe0d84dfa5a3e Amelie Delaunay 2017-06-21  1015  	if (spi_dev->mode & SPI_CPOL)
55166853b2f56ce Cezary Gapinski 2018-12-24  1016  		setb |= spi->cfg->regs->cpol.mask;
dcbe0d84dfa5a3e Amelie Delaunay 2017-06-21  1017  	else
55166853b2f56ce Cezary Gapinski 2018-12-24  1018  		clrb |= spi->cfg->regs->cpol.mask;
dcbe0d84dfa5a3e Amelie Delaunay 2017-06-21  1019  
dcbe0d84dfa5a3e Amelie Delaunay 2017-06-21  1020  	if (spi_dev->mode & SPI_CPHA)
55166853b2f56ce Cezary Gapinski 2018-12-24  1021  		setb |= spi->cfg->regs->cpha.mask;
dcbe0d84dfa5a3e Amelie Delaunay 2017-06-21  1022  	else
55166853b2f56ce Cezary Gapinski 2018-12-24  1023  		clrb |= spi->cfg->regs->cpha.mask;
dcbe0d84dfa5a3e Amelie Delaunay 2017-06-21  1024  
dcbe0d84dfa5a3e Amelie Delaunay 2017-06-21  1025  	if (spi_dev->mode & SPI_LSB_FIRST)
55166853b2f56ce Cezary Gapinski 2018-12-24  1026  		setb |= spi->cfg->regs->lsb_first.mask;
dcbe0d84dfa5a3e Amelie Delaunay 2017-06-21  1027  	else
55166853b2f56ce Cezary Gapinski 2018-12-24  1028  		clrb |= spi->cfg->regs->lsb_first.mask;
dcbe0d84dfa5a3e Amelie Delaunay 2017-06-21  1029  
dcbe0d84dfa5a3e Amelie Delaunay 2017-06-21 @1030  	dev_dbg(spi->dev, "cpol=%d cpha=%d lsb_first=%d cs_high=%d\n",
dcbe0d84dfa5a3e Amelie Delaunay 2017-06-21  1031  		spi_dev->mode & SPI_CPOL,
dcbe0d84dfa5a3e Amelie Delaunay 2017-06-21  1032  		spi_dev->mode & SPI_CPHA,
dcbe0d84dfa5a3e Amelie Delaunay 2017-06-21  1033  		spi_dev->mode & SPI_LSB_FIRST,
dcbe0d84dfa5a3e Amelie Delaunay 2017-06-21  1034  		spi_dev->mode & SPI_CS_HIGH);
dcbe0d84dfa5a3e Amelie Delaunay 2017-06-21  1035  
dcbe0d84dfa5a3e Amelie Delaunay 2017-06-21  1036  	spin_lock_irqsave(&spi->lock, flags);
dcbe0d84dfa5a3e Amelie Delaunay 2017-06-21  1037  
55166853b2f56ce Cezary Gapinski 2018-12-24  1038  	/* CPOL, CPHA and LSB FIRST bits have common register */
55166853b2f56ce Cezary Gapinski 2018-12-24  1039  	if (clrb || setb)
dcbe0d84dfa5a3e Amelie Delaunay 2017-06-21  1040  		writel_relaxed(
55166853b2f56ce Cezary Gapinski 2018-12-24  1041  			(readl_relaxed(spi->base + spi->cfg->regs->cpol.reg) &
55166853b2f56ce Cezary Gapinski 2018-12-24  1042  			 ~clrb) | setb,
55166853b2f56ce Cezary Gapinski 2018-12-24  1043  			spi->base + spi->cfg->regs->cpol.reg);
dcbe0d84dfa5a3e Amelie Delaunay 2017-06-21  1044  
dcbe0d84dfa5a3e Amelie Delaunay 2017-06-21  1045  	spin_unlock_irqrestore(&spi->lock, flags);
dcbe0d84dfa5a3e Amelie Delaunay 2017-06-21  1046  
dcbe0d84dfa5a3e Amelie Delaunay 2017-06-21  1047  	return 0;
dcbe0d84dfa5a3e Amelie Delaunay 2017-06-21  1048  }
dcbe0d84dfa5a3e Amelie Delaunay 2017-06-21  1049  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--qMm9M+Fa2AknHoGS
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--qMm9M+Fa2AknHoGS--
