Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D40731C3F7
	for <lists+linux-spi@lfdr.de>; Mon, 15 Feb 2021 23:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhBOWQn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Feb 2021 17:16:43 -0500
Received: from mga11.intel.com ([192.55.52.93]:28549 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229668AbhBOWQm (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Feb 2021 17:16:42 -0500
IronPort-SDR: u1U3bpy7+/SeJBEuY5VAVjgocszix85S02uE+f+mYDJyRmUvfuQkKPKmP66AGs1gZ1PaJzrxjG
 QcYOsNmLNfgQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9896"; a="179265530"
X-IronPort-AV: E=Sophos;i="5.81,181,1610438400"; 
   d="gz'50?scan'50,208,50";a="179265530"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2021 14:16:01 -0800
IronPort-SDR: E+rFHnkFe1EyheJoKDemevjrKCqcAl04YHSzZLGlFQFxQIHkO3rLJQYZxnpgR873DcabawOwTP
 oh0EHe+yhnNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,181,1610438400"; 
   d="gz'50?scan'50,208,50";a="377349851"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 15 Feb 2021 14:15:57 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lBm9t-0007aB-5B; Mon, 15 Feb 2021 22:15:57 +0000
Date:   Tue, 16 Feb 2021 06:15:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-media@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 2/3] spi: butterfly: Switch to use
 module_parport_driver()
Message-ID: <202102160625.vup9ebc1-lkp@intel.com>
References: <20210215202353.18515-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <20210215202353.18515-2-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Andy,

I love your patch! Yet something to improve:

[auto build test ERROR on spi/for-next]
[also build test ERROR on linus/master v5.11 next-20210215]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Andy-Shevchenko/parport-Introduce-module_parport_driver-helper-macro/20210216-042909
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
config: powerpc-randconfig-r034-20210215 (attached as .config)
compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project c9439ca36342fb6013187d0a69aef92736951476)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://github.com/0day-ci/linux/commit/59847957f9c092e0c9530501dcaf0d0b5e3f193a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Andy-Shevchenko/parport-Introduce-module_parport_driver-helper-macro/20210216-042909
        git checkout 59847957f9c092e0c9530501dcaf0d0b5e3f193a
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ^
   arch/powerpc/include/asm/io.h:537:62: note: expanded from macro '__do_outl'
   #define __do_outl(val, port)    writel(val,(PCI_IO_ADDR)_IO_BASE+port);
                                              ~~~~~~~~~~~~~~~~~~~~~^
   In file included from drivers/spi/spi-butterfly.c:15:
   In file included from include/linux/spi/spi.h:15:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/powerpc/include/asm/io.h:619:
   arch/powerpc/include/asm/io-defs.h:43:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(insb, (unsigned long p, void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:616:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:211:1: note: expanded from here
   __do_insb
   ^
   arch/powerpc/include/asm/io.h:556:56: note: expanded from macro '__do_insb'
   #define __do_insb(p, b, n)      readsb((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
                                          ~~~~~~~~~~~~~~~~~~~~~^
   In file included from drivers/spi/spi-butterfly.c:15:
   In file included from include/linux/spi/spi.h:15:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/powerpc/include/asm/io.h:619:
   arch/powerpc/include/asm/io-defs.h:45:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(insw, (unsigned long p, void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:616:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:213:1: note: expanded from here
   __do_insw
   ^
   arch/powerpc/include/asm/io.h:557:56: note: expanded from macro '__do_insw'
   #define __do_insw(p, b, n)      readsw((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
                                          ~~~~~~~~~~~~~~~~~~~~~^
   In file included from drivers/spi/spi-butterfly.c:15:
   In file included from include/linux/spi/spi.h:15:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/powerpc/include/asm/io.h:619:
   arch/powerpc/include/asm/io-defs.h:47:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(insl, (unsigned long p, void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:616:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:215:1: note: expanded from here
   __do_insl
   ^
   arch/powerpc/include/asm/io.h:558:56: note: expanded from macro '__do_insl'
   #define __do_insl(p, b, n)      readsl((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
                                          ~~~~~~~~~~~~~~~~~~~~~^
   In file included from drivers/spi/spi-butterfly.c:15:
   In file included from include/linux/spi/spi.h:15:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/powerpc/include/asm/io.h:619:
   arch/powerpc/include/asm/io-defs.h:49:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsb, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:616:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:217:1: note: expanded from here
   __do_outsb
   ^
   arch/powerpc/include/asm/io.h:559:58: note: expanded from macro '__do_outsb'
   #define __do_outsb(p, b, n)     writesb((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
   In file included from drivers/spi/spi-butterfly.c:15:
   In file included from include/linux/spi/spi.h:15:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/powerpc/include/asm/io.h:619:
   arch/powerpc/include/asm/io-defs.h:51:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsw, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:616:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:219:1: note: expanded from here
   __do_outsw
   ^
   arch/powerpc/include/asm/io.h:560:58: note: expanded from macro '__do_outsw'
   #define __do_outsw(p, b, n)     writesw((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
   In file included from drivers/spi/spi-butterfly.c:15:
   In file included from include/linux/spi/spi.h:15:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/powerpc/include/asm/io.h:619:
   arch/powerpc/include/asm/io-defs.h:53:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsl, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:616:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:221:1: note: expanded from here
   __do_outsl
   ^
   arch/powerpc/include/asm/io.h:561:58: note: expanded from macro '__do_outsl'
   #define __do_outsl(p, b, n)     writesl((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
>> drivers/spi/spi-butterfly.c:320:1: error: implicit declaration of function 'parport_add_driver' [-Werror,-Wimplicit-function-declaration]
   module_parport_driver(butterfly_driver);
   ^
   include/linux/parport.h:315:34: note: expanded from macro 'module_parport_driver'
           module_driver(__parport_driver, parport_add_driver, parport_del_driver)
                                           ^
>> drivers/spi/spi-butterfly.c:320:1: error: implicit declaration of function 'parport_del_driver' [-Werror,-Wimplicit-function-declaration]
   include/linux/parport.h:315:54: note: expanded from macro 'module_parport_driver'
           module_driver(__parport_driver, parport_add_driver, parport_del_driver)
                                                               ^
   drivers/spi/spi-butterfly.c:320:1: note: did you mean 'parport_del_port'?
   include/linux/parport.h:315:54: note: expanded from macro 'module_parport_driver'
           module_driver(__parport_driver, parport_add_driver, parport_del_driver)
                                                               ^
   include/linux/parport.h:328:6: note: 'parport_del_port' declared here
   void parport_del_port(struct parport *);
        ^
   12 warnings and 2 errors generated.


vim +/parport_add_driver +320 drivers/spi/spi-butterfly.c

   313	
   314	static struct parport_driver butterfly_driver = {
   315		.name =		"spi_butterfly",
   316		.match_port =	butterfly_attach,
   317		.detach =	butterfly_detach,
   318		.devmodel = true,
   319	};
 > 320	module_parport_driver(butterfly_driver);
   321	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--6c2NcOVqGQ03X4Wi
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--6c2NcOVqGQ03X4Wi--
