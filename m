Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA3ED477B38
	for <lists+linux-spi@lfdr.de>; Thu, 16 Dec 2021 19:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240455AbhLPSCb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Dec 2021 13:02:31 -0500
Received: from mga18.intel.com ([134.134.136.126]:32853 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230293AbhLPSCa (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 16 Dec 2021 13:02:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639677750; x=1671213750;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X4+NkeufLzZHDZfb2hlozCR15SgBlRSKuslkW4zon5E=;
  b=U+DOfBjQCM+20jQWJv3Gw1cDrvpuELf5+UloD834H8cLgB8cJzwAWpXh
   lqOwmpqhRuJoEC714OEbtvR5ISBJQlKS99f1QeqG3UE/WOi1MkIS3gTOj
   a6qyDHEEPWzlXsibwigdMlLb3Vm1Bha43DmWfZmSKhmLXNNuTI6+a4rDe
   qSJRVH/CINgFVM2BHAIwvXtZsGH5oWRh/XROGElXj9eYi2Q8qUQA8Tla9
   RYkPRQ1BsWJ3G820UV6lSNhA1mbGmEB4oRgGQwVNmOWhxtmwwvl1/isrs
   QPL48E0EuEVSpg/tvaM268Rl3bZhiq37J8+/hFhdJiUYHXGDbIzdquXM+
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="226418617"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="226418617"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 10:01:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="662534378"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 16 Dec 2021 10:01:20 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxv46-0003Zz-G3; Thu, 16 Dec 2021 18:01:14 +0000
Date:   Fri, 17 Dec 2021 02:00:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        linux-mtd@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH v6 20/28] spi: spi-mem: Fill the spi-mem controller
 capabilities of all the drivers
Message-ID: <202112170120.4tAlxDnn-lkp@intel.com>
References: <20211216111654.238086-21-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216111654.238086-21-miquel.raynal@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Miquel,

I love your patch! Yet something to improve:

[auto build test ERROR on broonie-spi/for-next]
[also build test ERROR on mtd/nand/next mtd/mtd/next mtd/mtd/fixes v5.16-rc5 next-20211215]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Miquel-Raynal/External-ECC-engines-Macronix-support/20211216-191821
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
config: arm-buildonly-randconfig-r006-20211216 (https://download.01.org/0day-ci/archive/20211217/202112170120.4tAlxDnn-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/bf16b56f7a0cc5aa237129a6b8bd216dc2632c8b
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Miquel-Raynal/External-ECC-engines-Macronix-support/20211216-191821
        git checkout bf16b56f7a0cc5aa237129a6b8bd216dc2632c8b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: drivers/mtd/nand/spi/gigadevice.o: in function `.LANCHOR0':
>> gigadevice.c:(.rodata+0x464): multiple definition of `spi_mem_no_caps'; drivers/mtd/nand/spi/core.o:core.c:(.rodata+0x2e8): first defined here
   arm-linux-gnueabi-ld: drivers/mtd/nand/spi/macronix.o: in function `.LANCHOR0':
   macronix.c:(.rodata+0x8d4): multiple definition of `spi_mem_no_caps'; drivers/mtd/nand/spi/core.o:core.c:(.rodata+0x2e8): first defined here
   arm-linux-gnueabi-ld: drivers/mtd/nand/spi/micron.o: in function `.LANCHOR0':
   micron.c:(.rodata+0x4cc): multiple definition of `spi_mem_no_caps'; drivers/mtd/nand/spi/core.o:core.c:(.rodata+0x2e8): first defined here
   arm-linux-gnueabi-ld: drivers/mtd/nand/spi/paragon.o: in function `.LANCHOR0':
   paragon.c:(.rodata+0x144): multiple definition of `spi_mem_no_caps'; drivers/mtd/nand/spi/core.o:core.c:(.rodata+0x2e8): first defined here
   arm-linux-gnueabi-ld: drivers/mtd/nand/spi/toshiba.o: in function `.LANCHOR0':
   toshiba.c:(.rodata+0x664): multiple definition of `spi_mem_no_caps'; drivers/mtd/nand/spi/core.o:core.c:(.rodata+0x2e8): first defined here
   arm-linux-gnueabi-ld: drivers/mtd/nand/spi/winbond.o:(.rodata+0x114): multiple definition of `spi_mem_no_caps'; drivers/mtd/nand/spi/core.o:core.c:(.rodata+0x2e8): first defined here
--
   arm-linux-gnueabi-ld: drivers/mtd/spi-nor/sfdp.o: in function `.LANCHOR0':
>> sfdp.c:(.rodata+0x278): multiple definition of `spi_mem_no_caps'; drivers/mtd/spi-nor/core.o:core.c:(.rodata+0xfbc): first defined here
   arm-linux-gnueabi-ld: drivers/mtd/spi-nor/swp.o: in function `.LANCHOR0':
   swp.c:(.rodata+0x24): multiple definition of `spi_mem_no_caps'; drivers/mtd/spi-nor/core.o:core.c:(.rodata+0xfbc): first defined here
   arm-linux-gnueabi-ld: drivers/mtd/spi-nor/otp.o: in function `.LANCHOR0':
   otp.c:(.rodata+0xc): multiple definition of `spi_mem_no_caps'; drivers/mtd/spi-nor/core.o:core.c:(.rodata+0xfbc): first defined here
   arm-linux-gnueabi-ld: drivers/mtd/spi-nor/sysfs.o:(.rodata+0x14): multiple definition of `spi_mem_no_caps'; drivers/mtd/spi-nor/core.o:core.c:(.rodata+0xfbc): first defined here
   arm-linux-gnueabi-ld: drivers/mtd/spi-nor/atmel.o: in function `.LANCHOR0':
   atmel.c:(.rodata+0x3d0): multiple definition of `spi_mem_no_caps'; drivers/mtd/spi-nor/core.o:core.c:(.rodata+0xfbc): first defined here
   arm-linux-gnueabi-ld: drivers/mtd/spi-nor/catalyst.o:(.rodata+0x178): multiple definition of `spi_mem_no_caps'; drivers/mtd/spi-nor/core.o:core.c:(.rodata+0xfbc): first defined here
   arm-linux-gnueabi-ld: drivers/mtd/spi-nor/eon.o:(.rodata+0x370): multiple definition of `spi_mem_no_caps'; drivers/mtd/spi-nor/core.o:core.c:(.rodata+0xfbc): first defined here
   arm-linux-gnueabi-ld: drivers/mtd/spi-nor/esmt.o:(.rodata+0xe8): multiple definition of `spi_mem_no_caps'; drivers/mtd/spi-nor/core.o:core.c:(.rodata+0xfbc): first defined here
   arm-linux-gnueabi-ld: drivers/mtd/spi-nor/everspin.o:(.rodata+0x130): multiple definition of `spi_mem_no_caps'; drivers/mtd/spi-nor/core.o:core.c:(.rodata+0xfbc): first defined here
   arm-linux-gnueabi-ld: drivers/mtd/spi-nor/fujitsu.o:(.rodata+0x58): multiple definition of `spi_mem_no_caps'; drivers/mtd/spi-nor/core.o:core.c:(.rodata+0xfbc): first defined here
   arm-linux-gnueabi-ld: drivers/mtd/spi-nor/gigadevice.o:(.rodata+0x250): multiple definition of `spi_mem_no_caps'; drivers/mtd/spi-nor/core.o:core.c:(.rodata+0xfbc): first defined here
   arm-linux-gnueabi-ld: drivers/mtd/spi-nor/intel.o:(.rodata+0xe8): multiple definition of `spi_mem_no_caps'; drivers/mtd/spi-nor/core.o:core.c:(.rodata+0xfbc): first defined here
   arm-linux-gnueabi-ld: drivers/mtd/spi-nor/issi.o:(.rodata+0x458): multiple definition of `spi_mem_no_caps'; drivers/mtd/spi-nor/core.o:core.c:(.rodata+0xfbc): first defined here
   arm-linux-gnueabi-ld: drivers/mtd/spi-nor/macronix.o:(.rodata+0x800): multiple definition of `spi_mem_no_caps'; drivers/mtd/spi-nor/core.o:core.c:(.rodata+0xfbc): first defined here
   arm-linux-gnueabi-ld: drivers/mtd/spi-nor/micron-st.o:(.rodata+0xe88): multiple definition of `spi_mem_no_caps'; drivers/mtd/spi-nor/core.o:core.c:(.rodata+0xfbc): first defined here
   arm-linux-gnueabi-ld: drivers/mtd/spi-nor/spansion.o:(.rodata+0x9b0): multiple definition of `spi_mem_no_caps'; drivers/mtd/spi-nor/core.o:core.c:(.rodata+0xfbc): first defined here
   arm-linux-gnueabi-ld: drivers/mtd/spi-nor/sst.o: in function `.LANCHOR0':
   sst.c:(.rodata+0x48c): multiple definition of `spi_mem_no_caps'; drivers/mtd/spi-nor/core.o:core.c:(.rodata+0xfbc): first defined here
   arm-linux-gnueabi-ld: drivers/mtd/spi-nor/winbond.o: in function `.LANCHOR0':
   winbond.c:(.rodata+0x978): multiple definition of `spi_mem_no_caps'; drivers/mtd/spi-nor/core.o:core.c:(.rodata+0xfbc): first defined here
   arm-linux-gnueabi-ld: drivers/mtd/spi-nor/xilinx.o:(.rodata+0x188): multiple definition of `spi_mem_no_caps'; drivers/mtd/spi-nor/core.o:core.c:(.rodata+0xfbc): first defined here
   arm-linux-gnueabi-ld: drivers/mtd/spi-nor/xmc.o:(.rodata+0xa0): multiple definition of `spi_mem_no_caps'; drivers/mtd/spi-nor/core.o:core.c:(.rodata+0xfbc): first defined here

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
