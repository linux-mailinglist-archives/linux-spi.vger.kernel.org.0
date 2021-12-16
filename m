Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5C2477B6E
	for <lists+linux-spi@lfdr.de>; Thu, 16 Dec 2021 19:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240646AbhLPSWW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Dec 2021 13:22:22 -0500
Received: from mga06.intel.com ([134.134.136.31]:59639 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240639AbhLPSWV (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 16 Dec 2021 13:22:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639678941; x=1671214941;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bWpZ4y9aJXzVUaCFf9SWhCRFb9c6jHouDwtiP8EaPgY=;
  b=djzRcWusaQh7KFw+UETrmenTRkru3z3oHx7T8qKEK0TT72s6TmGRXPbj
   +nrTYeOu5zi8nFVVkvmmSS+R/qyj4gYbWaV3NBVlEnbM1aZQJ2W+hrAK2
   ZuyLlGMJIlqmrhXgyvmBufJxSLKDcGPZOHiQ2tOS3i2zufdyphc7i/Hxy
   Bz+QJsvVCbfUwTeVTo7f+L6DUfGrpb//GrgaPo+6yO7dqtg+9yvCeY3SB
   MV1NwWheECM2pYxINjHiSWCv2OwXSh4qYUw441k61CH63fCygqQtqAXIq
   KC6ipw1ldAG+BzY44W6XwQ77uWOBVCYIzVypo0H4pomTT29pRLZQPDn9h
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="300340507"
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="300340507"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 10:22:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="754225259"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 16 Dec 2021 10:22:17 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxvOT-0003e5-5x; Thu, 16 Dec 2021 18:22:17 +0000
Date:   Fri, 17 Dec 2021 02:21:32 +0800
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
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org
Subject: Re: [PATCH v6 20/28] spi: spi-mem: Fill the spi-mem controller
 capabilities of all the drivers
Message-ID: <202112170259.JPoGT6na-lkp@intel.com>
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
config: hexagon-randconfig-r045-20211216 (https://download.01.org/0day-ci/archive/20211217/202112170259.JPoGT6na-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project dd245bab9fbb364faa1581e4f92ba3119a872fba)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/bf16b56f7a0cc5aa237129a6b8bd216dc2632c8b
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Miquel-Raynal/External-ECC-engines-Macronix-support/20211216-191821
        git checkout bf16b56f7a0cc5aa237129a6b8bd216dc2632c8b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: duplicate symbol: spi_mem_no_caps
   >>> defined at core.c
   >>> mtd/nand/spi/core.o:(spi_mem_no_caps) in archive drivers/built-in.a
   >>> defined at gigadevice.c
   >>> mtd/nand/spi/gigadevice.o:(.rodata+0x35C) in archive drivers/built-in.a
--
>> ld.lld: error: duplicate symbol: spi_mem_no_caps
   >>> defined at core.c
   >>> mtd/nand/spi/core.o:(spi_mem_no_caps) in archive drivers/built-in.a
   >>> defined at macronix.c
   >>> mtd/nand/spi/macronix.o:(.rodata+0x83C) in archive drivers/built-in.a
--
>> ld.lld: error: duplicate symbol: spi_mem_no_caps
   >>> defined at core.c
   >>> mtd/nand/spi/core.o:(spi_mem_no_caps) in archive drivers/built-in.a
   >>> defined at sysfs.c
   >>> mtd/spi-nor/sysfs.o:(.rodata+0x14) in archive drivers/built-in.a
--
>> ld.lld: error: duplicate symbol: spi_mem_no_caps
   >>> defined at core.c
   >>> mtd/nand/spi/core.o:(spi_mem_no_caps) in archive drivers/built-in.a
   >>> defined at atmel.c
   >>> mtd/spi-nor/atmel.o:(.rodata+0x370) in archive drivers/built-in.a
--
>> ld.lld: error: duplicate symbol: spi_mem_no_caps
   >>> defined at core.c
   >>> mtd/nand/spi/core.o:(spi_mem_no_caps) in archive drivers/built-in.a
   >>> defined at catalyst.c
   >>> mtd/spi-nor/catalyst.o:(.rodata+0x178) in archive drivers/built-in.a
--
>> ld.lld: error: duplicate symbol: spi_mem_no_caps
   >>> defined at core.c
   >>> mtd/nand/spi/core.o:(spi_mem_no_caps) in archive drivers/built-in.a
   >>> defined at eon.c
   >>> mtd/spi-nor/eon.o:(.rodata+0x370) in archive drivers/built-in.a
--
>> ld.lld: error: duplicate symbol: spi_mem_no_caps
   >>> defined at core.c
   >>> mtd/nand/spi/core.o:(spi_mem_no_caps) in archive drivers/built-in.a
   >>> defined at esmt.c
   >>> mtd/spi-nor/esmt.o:(.rodata+0xE8) in archive drivers/built-in.a
--
>> ld.lld: error: duplicate symbol: spi_mem_no_caps
   >>> defined at core.c
   >>> mtd/nand/spi/core.o:(spi_mem_no_caps) in archive drivers/built-in.a
   >>> defined at everspin.c
   >>> mtd/spi-nor/everspin.o:(.rodata+0x130) in archive drivers/built-in.a
--
>> ld.lld: error: duplicate symbol: spi_mem_no_caps
   >>> defined at core.c
   >>> mtd/nand/spi/core.o:(spi_mem_no_caps) in archive drivers/built-in.a
   >>> defined at fujitsu.c
   >>> mtd/spi-nor/fujitsu.o:(.rodata+0x58) in archive drivers/built-in.a
--
>> ld.lld: error: duplicate symbol: spi_mem_no_caps
   >>> defined at core.c
   >>> mtd/nand/spi/core.o:(spi_mem_no_caps) in archive drivers/built-in.a
   >>> defined at gigadevice.c
   >>> mtd/spi-nor/gigadevice.o:(.rodata+0x250) in archive drivers/built-in.a
--
>> ld.lld: error: duplicate symbol: spi_mem_no_caps
   >>> defined at core.c
   >>> mtd/nand/spi/core.o:(spi_mem_no_caps) in archive drivers/built-in.a
   >>> defined at intel.c
   >>> mtd/spi-nor/intel.o:(.rodata+0xE8) in archive drivers/built-in.a
..

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
