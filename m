Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C74477D7F
	for <lists+linux-spi@lfdr.de>; Thu, 16 Dec 2021 21:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241397AbhLPUZ1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Dec 2021 15:25:27 -0500
Received: from mga07.intel.com ([134.134.136.100]:18167 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240687AbhLPUZ0 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 16 Dec 2021 15:25:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639686326; x=1671222326;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LcEHuYuvDnCQt9p5l3nJdT+py7Kwd5vgmrOG5pVqPuc=;
  b=Y7Vx8twrvTlv3/q5aeKtkUiXLhPPLuPb7cvOeuiiPCeqSmhMloN7pudB
   zgIR6TUxNGfwUZ665wXmVc1OX5dYhvS9YXg+89Q7fxJhm0eCgKGwQ0Pbu
   kmr7SzzrFhonuFmY7Q0owkPwElEwO2yio+4usDYVGcJCs4WtHMsywH7jq
   nqQXOSDe0tglQ4TGY70FgwaEvUWHcTYvVCinxjg0X45HBf8FGqBFH61/K
   lobxKVynI0mT83dDifXzyHiwVNy+dYj5uqMzOsVAbtEIIi258ppEVoKuX
   V4Q37w4JZ63B+RT3UPBalxplfm9J9Ng8F1eRxdzLav91WyFuqOe5jTzI4
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="302966993"
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="302966993"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 12:25:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="546134426"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 16 Dec 2021 12:25:22 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxxJZ-0003mI-Bv; Thu, 16 Dec 2021 20:25:21 +0000
Date:   Fri, 17 Dec 2021 04:24:36 +0800
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
Message-ID: <202112170429.LyEKzvra-lkp@intel.com>
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

I love your patch! Perhaps something to improve:

[auto build test WARNING on broonie-spi/for-next]
[also build test WARNING on mtd/nand/next mtd/mtd/next mtd/mtd/fixes v5.16-rc5 next-20211215]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Miquel-Raynal/External-ECC-engines-Macronix-support/20211216-191821
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
config: i386-randconfig-s002-20211216 (https://download.01.org/0day-ci/archive/20211217/202112170429.LyEKzvra-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/bf16b56f7a0cc5aa237129a6b8bd216dc2632c8b
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Miquel-Raynal/External-ECC-engines-Macronix-support/20211216-191821
        git checkout bf16b56f7a0cc5aa237129a6b8bd216dc2632c8b
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/spi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/spi/spi-cadence-quadspi.c: note: in included file:
   include/linux/spi/spi-mem.h:369:38: sparse: sparse: symbol 'spi_mem_no_caps' was not declared. Should it be static?
>> drivers/spi/spi-cadence-quadspi.c:1592:38: sparse: sparse: symbol 'cqspi_mem_caps' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
