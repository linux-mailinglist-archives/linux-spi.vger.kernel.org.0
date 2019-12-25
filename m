Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1854C12A85B
	for <lists+linux-spi@lfdr.de>; Wed, 25 Dec 2019 15:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfLYOtz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Dec 2019 09:49:55 -0500
Received: from mga02.intel.com ([134.134.136.20]:63639 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbfLYOtz (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 25 Dec 2019 09:49:55 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Dec 2019 06:49:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,355,1571727600"; 
   d="scan'208";a="392133335"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 25 Dec 2019 06:49:51 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ik7yw-000Gty-MV; Wed, 25 Dec 2019 22:49:50 +0800
Date:   Wed, 25 Dec 2019 22:49:04 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     kbuild-all@lists.01.org, broonie@kernel.org, vigneshr@ti.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: Re: [PATCH v4 2/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
Message-ID: <201912252223.wQ8jMSLg%lkp@intel.com>
References: <20191223063003.26579-3-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191223063003.26579-3-vadivel.muruganx.ramuthevar@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi "Ramuthevar,Vadivel,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on spi/for-next]
[also build test WARNING on v5.5-rc3 next-20191220]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Ramuthevar-Vadivel-MuruganX/spi-cadence-quadpsi-Add-support-for-the-Cadence-QSPI-controller/20191225-040310
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-129-g341daf20-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/spi/spi-cadence-quadspi.c:133:30: sparse: sparse: incorrect type in argument 1 (different address spaces)
   drivers/spi/spi-cadence-quadspi.c:133:30: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:133:30: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:139:30: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/spi/spi-cadence-quadspi.c:139:30: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:139:30: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:146:30: sparse: sparse: incorrect type in argument 1 (different address spaces)
   drivers/spi/spi-cadence-quadspi.c:146:30: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:146:30: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:152:30: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/spi/spi-cadence-quadspi.c:152:30: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:152:30: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:161:30: sparse: sparse: incorrect type in argument 1 (different address spaces)
   drivers/spi/spi-cadence-quadspi.c:161:30: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:161:30: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:171:30: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/spi/spi-cadence-quadspi.c:171:30: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:171:30: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:183:30: sparse: sparse: incorrect type in argument 1 (different address spaces)
   drivers/spi/spi-cadence-quadspi.c:183:30: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:183:30: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:186:30: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/spi/spi-cadence-quadspi.c:186:30: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:186:30: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:195:30: sparse: sparse: incorrect type in argument 1 (different address spaces)
   drivers/spi/spi-cadence-quadspi.c:195:30: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:195:30: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:214:30: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/spi/spi-cadence-quadspi.c:214:30: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:214:30: sparse:    got void *
>> drivers/spi/spi-cadence-quadspi.c:383:31: sparse: sparse: incorrect type in initializer (different address spaces)
   drivers/spi/spi-cadence-quadspi.c:383:31: sparse:    expected void *reg_base
   drivers/spi/spi-cadence-quadspi.c:383:31: sparse:    got void [noderef] <asn:2> *iobase
   drivers/spi/spi-cadence-quadspi.c:384:31: sparse: sparse: incorrect type in initializer (different address spaces)
   drivers/spi/spi-cadence-quadspi.c:384:31: sparse:    expected void *ahb_base
   drivers/spi/spi-cadence-quadspi.c:384:31: sparse:    got void [noderef] <asn:2> *qspi_ahb_virt
   drivers/spi/spi-cadence-quadspi.c:393:36: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/spi/spi-cadence-quadspi.c:393:36: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:393:36: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:398:25: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/spi/spi-cadence-quadspi.c:398:25: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:398:25: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:400:48: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/spi/spi-cadence-quadspi.c:400:48: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:400:48: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:401:44: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/spi/spi-cadence-quadspi.c:401:44: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:401:44: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:405:25: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/spi/spi-cadence-quadspi.c:405:25: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:405:25: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:413:33: sparse: sparse: incorrect type in argument 1 (different address spaces)
   drivers/spi/spi-cadence-quadspi.c:413:33: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:413:33: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:423:46: sparse: sparse: incorrect type in argument 1 (different address spaces)
   drivers/spi/spi-cadence-quadspi.c:423:46: sparse:    expected void [noderef] <asn:2> *port
   drivers/spi/spi-cadence-quadspi.c:423:46: sparse:    got void *ahb_base
   drivers/spi/spi-cadence-quadspi.c:426:62: sparse: sparse: incorrect type in argument 1 (different address spaces)
   drivers/spi/spi-cadence-quadspi.c:426:62: sparse:    expected void [noderef] <asn:2> *
   drivers/spi/spi-cadence-quadspi.c:426:62: sparse:    got void *ahb_base
   drivers/spi/spi-cadence-quadspi.c:435:41: sparse: sparse: incorrect type in argument 1 (different address spaces)
   drivers/spi/spi-cadence-quadspi.c:435:41: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:435:41: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:443:43: sparse: sparse: incorrect type in argument 1 (different address spaces)
   drivers/spi/spi-cadence-quadspi.c:443:43: sparse:    expected void [noderef] <asn:2> *reg
   drivers/spi/spi-cadence-quadspi.c:443:43: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:452:28: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/spi/spi-cadence-quadspi.c:452:28: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:452:28: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:454:57: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/spi/spi-cadence-quadspi.c:454:57: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:454:57: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:459:28: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/spi/spi-cadence-quadspi.c:459:28: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:459:28: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:462:25: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/spi/spi-cadence-quadspi.c:462:25: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:462:25: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:519:31: sparse: sparse: incorrect type in initializer (different address spaces)
   drivers/spi/spi-cadence-quadspi.c:519:31: sparse:    expected void *reg_base
   drivers/spi/spi-cadence-quadspi.c:519:31: sparse:    got void [noderef] <asn:2> *iobase
   drivers/spi/spi-cadence-quadspi.c:520:31: sparse: sparse: incorrect type in initializer (different address spaces)
   drivers/spi/spi-cadence-quadspi.c:520:31: sparse:    expected void *ahb_base
   drivers/spi/spi-cadence-quadspi.c:520:31: sparse:    got void [noderef] <asn:2> *qspi_ahb_virt
   drivers/spi/spi-cadence-quadspi.c:527:30: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/spi/spi-cadence-quadspi.c:527:30: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:527:30: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:528:30: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/spi/spi-cadence-quadspi.c:528:30: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:528:30: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:529:30: sparse: sparse: incorrect type in argument 1 (different address spaces)
   drivers/spi/spi-cadence-quadspi.c:529:30: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:529:30: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:534:30: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/spi/spi-cadence-quadspi.c:534:30: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:534:30: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:536:36: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/spi/spi-cadence-quadspi.c:536:36: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:536:36: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:537:54: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/spi/spi-cadence-quadspi.c:537:54: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:537:54: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:539:48: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/spi/spi-cadence-quadspi.c:539:48: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:539:48: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:540:44: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/spi/spi-cadence-quadspi.c:540:44: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:540:44: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:543:25: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/spi/spi-cadence-quadspi.c:543:25: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:543:25: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:557:39: sparse: sparse: incorrect type in argument 1 (different address spaces)
   drivers/spi/spi-cadence-quadspi.c:557:39: sparse:    expected void [noderef] <asn:2> *port
   drivers/spi/spi-cadence-quadspi.c:557:39: sparse:    got void *ahb_base
   drivers/spi/spi-cadence-quadspi.c:564:41: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/spi/spi-cadence-quadspi.c:564:41: sparse:    expected void [noderef] <asn:2> *
   drivers/spi/spi-cadence-quadspi.c:564:41: sparse:    got void *ahb_base
   drivers/spi/spi-cadence-quadspi.c:579:43: sparse: sparse: incorrect type in argument 1 (different address spaces)
   drivers/spi/spi-cadence-quadspi.c:579:43: sparse:    expected void [noderef] <asn:2> *reg
   drivers/spi/spi-cadence-quadspi.c:579:43: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:590:28: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/spi/spi-cadence-quadspi.c:590:28: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:590:28: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:592:57: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/spi/spi-cadence-quadspi.c:592:57: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:592:57: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:597:33: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/spi/spi-cadence-quadspi.c:597:33: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:597:33: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:607:38: sparse: sparse: incorrect type in argument 1 (different address spaces)
   drivers/spi/spi-cadence-quadspi.c:607:38: sparse:    expected void *reg_base

vim +133 drivers/spi/spi-cadence-quadspi.c

   128	
   129	static void cqspi_direct_access_enable(void *reg_base, bool enable)
   130	{
   131		u32 reg;
   132	
 > 133		reg = readl(reg_base + CQSPI_REG_CONFIG);
   134		if (enable)
   135			reg |= CQSPI_REG_CONFIG_DIRECT_MASK;
   136		else
   137			reg &= ~CQSPI_REG_CONFIG_DIRECT_MASK;
   138	
   139		writel(reg, reg_base + CQSPI_REG_CONFIG);
   140	}
   141	
   142	static void cqspi_controller_enable(void *reg_base, bool enable)
   143	{
   144		unsigned int reg;
   145	
   146		reg = readl(reg_base + CQSPI_REG_CONFIG);
   147		if (enable)
   148			reg |= CQSPI_REG_CONFIG_ENABLE_MASK;
   149		else
   150			reg &= ~CQSPI_REG_CONFIG_ENABLE_MASK;
   151	
   152		writel(reg, reg_base + CQSPI_REG_CONFIG);
   153	}
   154	
   155	static void cqspi_readdata_capture(void *reg_base, u32 bypass, u32 delay)
   156	{
   157		unsigned int reg;
   158	
   159		cqspi_controller_enable(reg_base, 0);
   160	
   161		reg = readl(reg_base + CQSPI_REG_READCAPTURE);
   162		if (bypass)
   163			reg |= (1 << CQSPI_REG_READCAPTURE_BYPASS_LSB);
   164		else
   165			reg &= ~(1 << CQSPI_REG_READCAPTURE_BYPASS_LSB);
   166	
   167		reg &= ~(CQSPI_REG_READCAPTURE_DELAY_MASK
   168			<< CQSPI_REG_READCAPTURE_DELAY_LSB);
   169		reg |= ((delay & CQSPI_REG_READCAPTURE_DELAY_MASK)
   170			<< CQSPI_REG_READCAPTURE_DELAY_LSB);
   171		writel(reg, reg_base + CQSPI_REG_READCAPTURE);
   172	
   173		cqspi_controller_enable(reg_base, 1);
   174	}
   175	
   176	static void cqspi_config_baudrate_div(void *reg_base, u32 ref_clk_hz, u32 sclk)
   177	{
   178		unsigned int reg, div;
   179	
   180		/* Recalculate the baudrate divisor based on QSPI specification. */
   181		div = DIV_ROUND_UP(ref_clk_hz, 2 * sclk) - 1;
   182	
   183		reg = readl(reg_base + CQSPI_REG_CONFIG);
   184		reg &= ~(CQSPI_REG_CONFIG_BAUD_MASK << CQSPI_REG_CONFIG_BAUD_LSB);
   185		div = (div & CQSPI_REG_CONFIG_BAUD_MASK) << CQSPI_REG_CONFIG_BAUD_LSB;
 > 186		writel(reg, reg_base + CQSPI_REG_CONFIG);
   187	}
   188	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
