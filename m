Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F373477C01
	for <lists+linux-spi@lfdr.de>; Thu, 16 Dec 2021 19:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbhLPSxZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Dec 2021 13:53:25 -0500
Received: from mga12.intel.com ([192.55.52.136]:46607 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238879AbhLPSxW (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 16 Dec 2021 13:53:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639680802; x=1671216802;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8MSCgFidKirbyqnLCDSCpxGAW0z3HoFpW9DqxP4Tj8A=;
  b=ZPiricgFWeLip1AaCoBUMJ+4p4aLcvnGZK/yEsbKArhgay2d2QtiBmKk
   ypu56gf7IZAjsPN0fyEBaexJCnm5DJH9b87L1v410bqy+XNs+uk+AzFSU
   z300og63NMW3iPxrB+HBno1OjVnsLUOnYqA07wrD9Bf19R20l+4suHv8x
   diT2vXwW7G0uIEP5s/ngpmFGbTAgwVwFG8GAYZBHJNhEQ0+00p8zXUtqW
   q+HYHGu+2Cb+2L55hVBX06CNTB6oXtj1k/J5HYe/SKuAoRgRPgfEqc4Id
   GxUFQchznku1tF4npOYGn1kxc3uy3LtMHgMj2U+xOTZLmw7IyyQPwJYJa
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="219584373"
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="219584373"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 10:53:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="464797597"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 16 Dec 2021 10:53:18 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxvsT-0003ga-VS; Thu, 16 Dec 2021 18:53:17 +0000
Date:   Fri, 17 Dec 2021 02:52:25 +0800
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
Message-ID: <202112170204.FjtWNBvt-lkp@intel.com>
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
config: openrisc-randconfig-r036-20211216 (https://download.01.org/0day-ci/archive/20211217/202112170204.FjtWNBvt-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/bf16b56f7a0cc5aa237129a6b8bd216dc2632c8b
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Miquel-Raynal/External-ECC-engines-Macronix-support/20211216-191821
        git checkout bf16b56f7a0cc5aa237129a6b8bd216dc2632c8b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=openrisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> or1k-linux-ld: drivers/spi/spi-dw-core.o:(.rodata+0x0): multiple definition of `spi_mem_no_caps'; drivers/spi/spi.o:(.rodata+0x40): first defined here
   or1k-linux-ld: drivers/spi/spi-dw-dma.o:(.rodata+0x30): multiple definition of `spi_mem_no_caps'; drivers/spi/spi.o:(.rodata+0x40): first defined here
   or1k-linux-ld: drivers/spi/spi-nxp-fspi.o:(.rodata+0x51c): multiple definition of `spi_mem_no_caps'; drivers/spi/spi.o:(.rodata+0x40): first defined here
   or1k-linux-ld: drivers/spi/spi-zynqmp-gqspi.o:(.rodata+0x20c): multiple definition of `spi_mem_no_caps'; drivers/spi/spi.o:(.rodata+0x40): first defined here

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
