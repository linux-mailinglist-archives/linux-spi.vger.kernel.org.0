Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9CA45F639
	for <lists+linux-spi@lfdr.de>; Fri, 26 Nov 2021 22:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242162AbhKZVVe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Nov 2021 16:21:34 -0500
Received: from mga05.intel.com ([192.55.52.43]:47388 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241148AbhKZVTe (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 26 Nov 2021 16:19:34 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="321950626"
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; 
   d="scan'208";a="321950626"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 13:16:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; 
   d="scan'208";a="498561992"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 26 Nov 2021 13:16:17 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqiZs-0008cJ-82; Fri, 26 Nov 2021 21:16:16 +0000
Date:   Sat, 27 Nov 2021 05:15:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org
Cc:     kbuild-all@lists.01.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 20/20] spi: mxic: Add support for pipelined ECC
 operations
Message-ID: <202111270526.T8x5Nyq1-lkp@intel.com>
References: <20211126113924.310459-21-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126113924.310459-21-miquel.raynal@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Miquel,

I love your patch! Perhaps something to improve:

[auto build test WARNING on mtd/nand/next]
[also build test WARNING on broonie-spi/for-next mtd/mtd/next mtd/mtd/fixes v5.16-rc2 next-20211126]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Miquel-Raynal/External-ECC-engines-Macronix-support/20211126-195956
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next
config: xtensa-buildonly-randconfig-r006-20211125 (https://download.01.org/0day-ci/archive/20211127/202111270526.T8x5Nyq1-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/0804d6ccdf15e7a65743d048d01d876a54070b6b
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Miquel-Raynal/External-ECC-engines-Macronix-support/20211126-195956
        git checkout 0804d6ccdf15e7a65743d048d01d876a54070b6b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=xtensa SHELL=/bin/bash drivers/spi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/spi/spi-mxic.c:16:
>> include/linux/mtd/nand-ecc-mxic.h:34:1: warning: no previous prototype for 'mxic_ecc_get_pipelined_engine' [-Wmissing-prototypes]
      34 | mxic_ecc_get_pipelined_engine(struct platform_device *spi_pdev)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/mtd/nand-ecc-mxic.h:39:6: warning: no previous prototype for 'mxic_ecc_put_pipelined_engine' [-Wmissing-prototypes]
      39 | void mxic_ecc_put_pipelined_engine(struct nand_ecc_engine *eng) {}
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/mxic_ecc_get_pipelined_engine +34 include/linux/mtd/nand-ecc-mxic.h

a19f28121341b52 Miquel Raynal 2021-11-26  32  
a19f28121341b52 Miquel Raynal 2021-11-26  33  struct nand_ecc_engine *
a19f28121341b52 Miquel Raynal 2021-11-26 @34  mxic_ecc_get_pipelined_engine(struct platform_device *spi_pdev)
a19f28121341b52 Miquel Raynal 2021-11-26  35  {
a19f28121341b52 Miquel Raynal 2021-11-26  36  	return ERR_PTR(-EOPNOTSUPP);
a19f28121341b52 Miquel Raynal 2021-11-26  37  }
a19f28121341b52 Miquel Raynal 2021-11-26  38  
a19f28121341b52 Miquel Raynal 2021-11-26 @39  void mxic_ecc_put_pipelined_engine(struct nand_ecc_engine *eng) {}
a19f28121341b52 Miquel Raynal 2021-11-26  40  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
