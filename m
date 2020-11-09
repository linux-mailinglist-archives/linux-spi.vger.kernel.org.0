Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10EDA2AC422
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 19:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbgKIStC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 13:49:02 -0500
Received: from mga05.intel.com ([192.55.52.43]:53758 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729302AbgKIStB (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Nov 2020 13:49:01 -0500
IronPort-SDR: /5Z22WdovmisQHgebyNIY3D4zodyzRLnhqg/vR8A/u5PaoAdavaIjKNNYx3Du2ESN/a+8p4j6P
 x9b/xcrkv/8g==
X-IronPort-AV: E=McAfee;i="6000,8403,9800"; a="254558581"
X-IronPort-AV: E=Sophos;i="5.77,464,1596524400"; 
   d="gz'50?scan'50,208,50";a="254558581"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 10:49:00 -0800
IronPort-SDR: C9J1S52jpeWEFPQCxFzG1U7UQiTQ/J7O+iLlMFkMI4C/bSkR4CerjZ+wKGYwsrHJgzXEUhMcLC
 Hi540Lgsymaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,464,1596524400"; 
   d="gz'50?scan'50,208,50";a="359797972"
Received: from lkp-server01.sh.intel.com (HELO d0be80f1a028) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 09 Nov 2020 10:48:56 -0800
Received: from kbuild by d0be80f1a028 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kcCDo-0000MK-5q; Mon, 09 Nov 2020 18:48:56 +0000
Date:   Tue, 10 Nov 2020 02:48:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH 20/32] riscv: Add Kendryte K210 FPIOA pinctrl driver
Message-ID: <202011100255.mohMwlkQ-lkp@intel.com>
References: <20201107081420.60325-21-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <20201107081420.60325-21-damien.lemoal@wdc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Damien,

I love your patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on spi/for-next pza/reset/next linus/master v5.10-rc3 next-20201109]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Damien-Le-Moal/RISC-V-Kendryte-K210-support-improvments/20201109-095540
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: riscv-nommu_k210_defconfig (attached as .config)
compiler: riscv64-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/b53c7c4d3b5b4658b4951955fd69c0ceb4bfac4d
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Damien-Le-Moal/RISC-V-Kendryte-K210-support-improvments/20201109-095540
        git checkout b53c7c4d3b5b4658b4951955fd69c0ceb4bfac4d
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/pinctrl/pinctrl-k210.c:848:5: warning: no previous prototype for 'k210_pinctrl_dt_node_to_map' [-Wmissing-prototypes]
     848 | int k210_pinctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~

vim +/k210_pinctrl_dt_node_to_map +848 drivers/pinctrl/pinctrl-k210.c

   847	
 > 848	int k210_pinctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
   849				struct device_node *np_config,
   850				struct pinctrl_map **map, unsigned int *num_maps)
   851	{
   852		unsigned int reserved_maps;
   853		struct device_node *np;
   854		int ret;
   855	
   856		reserved_maps = 0;
   857		*map = NULL;
   858		*num_maps = 0;
   859	
   860		ret = k210_pinctrl_dt_subnode_to_map(pctldev, np_config, map,
   861						     &reserved_maps, num_maps);
   862		if (ret < 0)
   863			goto err;
   864	
   865		for_each_available_child_of_node(np_config, np) {
   866			ret = k210_pinctrl_dt_subnode_to_map(pctldev, np, map,
   867							     &reserved_maps, num_maps);
   868			if (ret < 0)
   869				goto err;
   870		}
   871		return 0;
   872	
   873	err:
   874		pinctrl_utils_free_map(pctldev, *map, *num_maps);
   875		return ret;
   876	}
   877	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--lrZ03NoBR/3+SXJZ
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--lrZ03NoBR/3+SXJZ--
