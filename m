Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088D06C7C4E
	for <lists+linux-spi@lfdr.de>; Fri, 24 Mar 2023 11:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjCXKPQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Mar 2023 06:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjCXKPQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 24 Mar 2023 06:15:16 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2A5C673;
        Fri, 24 Mar 2023 03:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679652915; x=1711188915;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lhhFN5Vd1W/aAgP72ZDMZOV8VUt3XUbMuQBIwOPdm1s=;
  b=QZyvH+XkK0eFlj3F42EMPORE6anTUosYeD7fuO6AWfmIvgiwpYm7h8Nk
   cJSUXaMC/rkc36LfxTl/48E9B/ziG7gCurvwOSH7Vg1Lv/JQp1qi918Ui
   0oo5tWYX6LdRI50/AoS3MRpFtKRDDMnuTfbhZhRLOmES2EKbD+zlFDMcD
   4p1T6px6mBMj0z5Pp+4kd6VYsNgsqlPR3O5O8RXsHfuW8DOc9+CQcYQYN
   mg/Jlf57LNtwdjCyAo3wjBU4j3hcFbnzdlUvOHsnWITXf49wAr3PWiRNg
   axaaHoCE0GLSTWAB2eYuse2f0v3tGnhZbZYrT0YkJRZmhJTdReDZgr+tr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="338467217"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="338467217"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 03:15:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="715179880"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="715179880"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 24 Mar 2023 03:15:11 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfeRy-000FCm-2w;
        Fri, 24 Mar 2023 10:15:10 +0000
Date:   Fri, 24 Mar 2023 18:15:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, Yinbo Zhu <zhuyinbo@loongson.cn>
Subject: Re: [PATCH v3 2/2] spi: loongson: add bus driver for the loongson
 spi controller
Message-ID: <202303241811.OXj9KxAr-lkp@intel.com>
References: <20230324063317.14664-3-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324063317.14664-3-zhuyinbo@loongson.cn>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Yinbo,

I love your patch! Yet something to improve:

[auto build test ERROR on broonie-spi/for-next]
[also build test ERROR on robh/for-next krzk-dt/for-next linus/master v6.3-rc3 next-20230324]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yinbo-Zhu/dt-bindings-spi-add-loongson-spi/20230324-143432
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20230324063317.14664-3-zhuyinbo%40loongson.cn
patch subject: [PATCH v3 2/2] spi: loongson: add bus driver for the loongson spi controller
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230324/202303241811.OXj9KxAr-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/3742622c455d25c4a110d2caf2f5b2ceefe88f91
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yinbo-Zhu/dt-bindings-spi-add-loongson-spi/20230324-143432
        git checkout 3742622c455d25c4a110d2caf2f5b2ceefe88f91
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303241811.OXj9KxAr-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/spi/spi-loongson-core.c: In function 'loongson_spi_init_master':
>> drivers/spi/spi-loongson-core.c:229:21: error: implicit declaration of function 'devm_ioremap'; did you mean 'of_ioremap'? [-Werror=implicit-function-declaration]
     229 |         spi->base = devm_ioremap(dev, res->start, resource_size(res));
         |                     ^~~~~~~~~~~~
         |                     of_ioremap
>> drivers/spi/spi-loongson-core.c:229:19: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     229 |         spi->base = devm_ioremap(dev, res->start, resource_size(res));
         |                   ^
   cc1: some warnings being treated as errors


vim +229 drivers/spi/spi-loongson-core.c

   201	
   202	int loongson_spi_init_master(struct device *dev, struct resource *res)
   203	{
   204		struct spi_master *master;
   205		struct loongson_spi *spi;
   206		struct clk *clk;
   207		int ret;
   208	
   209		master = spi_alloc_master(dev, sizeof(struct loongson_spi));
   210		if (master == NULL) {
   211			dev_dbg(dev, "master allocation failed\n");
   212			return -ENOMEM;
   213		}
   214	
   215		master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
   216		master->setup = loongson_spi_setup;
   217		master->prepare_message = loongson_spi_prepare_message;
   218		master->transfer_one = loongson_spi_transfer_one;
   219		master->unprepare_message = loongson_spi_unprepare_message;
   220		master->set_cs = loongson_spi_set_cs;
   221		master->num_chipselect = 4;
   222		master->dev.of_node = of_node_get(dev->of_node);
   223		dev_set_drvdata(dev, master);
   224	
   225		spi = spi_master_get_devdata(master);
   226	
   227		spi->master = master;
   228	
 > 229		spi->base = devm_ioremap(dev, res->start, resource_size(res));
   230		if (spi->base == NULL) {
   231			dev_err(dev, "cannot map io\n");
   232			ret = -ENXIO;
   233			goto free_master;
   234		}
   235	
   236		clk = devm_clk_get(dev, NULL);
   237		if (!IS_ERR(clk))
   238			spi->clk_rate = clk_get_rate(clk);
   239	
   240		loongson_spi_reginit(spi);
   241	
   242		spi->mode = 0;
   243		if (of_get_property(dev->of_node, "spi-nocs", NULL))
   244			spi->mode |= SPI_NO_CS;
   245	
   246		ret = spi_register_master(master);
   247		if (ret < 0)
   248			goto free_master;
   249	
   250		return ret;
   251	
   252	free_master:
   253		kfree(master);
   254		spi_master_put(master);
   255	
   256		return ret;
   257	}
   258	EXPORT_SYMBOL_GPL(loongson_spi_init_master);
   259	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
