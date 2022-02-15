Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C7B4B76EE
	for <lists+linux-spi@lfdr.de>; Tue, 15 Feb 2022 21:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243477AbiBOTOa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 15 Feb 2022 14:14:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243275AbiBOTOS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 15 Feb 2022 14:14:18 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99EA109A7E
        for <linux-spi@vger.kernel.org>; Tue, 15 Feb 2022 11:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644952445; x=1676488445;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=S3nwh1DCk/7yVwVXELV3S4r9vMlV9xxl4V3q4If14Vo=;
  b=Xda/HWASac4kXH/PXPOtP7pYLR0FIOTleZ3oapUXjwm14ynk0FLRPxtb
   bN1imJLbnKhOTaTJ13BKFc7YsRvSqHqgbWihVCkHUD/ZeiZqNlkTOLwVS
   B+ntu/1WUVXBUODpsp3Qqs8HzBT1S811nJFeFQPYRDFJdh3Ovd5PsibhS
   oSERbxZxxg8DgRYNPp3lO6g1Wy8SQ6n5sn8sXSxIQ+bZzUyqqbQgQz7jd
   ANyLlOCFGJeknzOLKrLbyWZBimkqESxFDNlROPCsDo69pVAi3y+E7xS8X
   EdDQDKLlViq3gsBNzzKdjWO2FLfwYTKRm98vw0geIOHmdGDhVOHPdv2UR
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="230395721"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="230395721"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 11:14:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="497399839"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 15 Feb 2022 11:14:03 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nK3H0-0009xK-Rq; Tue, 15 Feb 2022 19:14:02 +0000
Date:   Wed, 16 Feb 2022 03:13:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [broonie-spi:for-next 59/66] drivers/spi/spi-amd.c:296:21: warning:
 cast to smaller integer type 'enum amd_spi_versions' from 'const void *'
Message-ID: <202202160331.TbQABF6V-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
head:   db91535d770445e1b61f6f7e4bdbd8cce45440c0
commit: 209043554915d7c51ac112a668ad1a255e1bea61 [59/66] spi: amd: Add support for version AMDI0062
config: x86_64-randconfig-a005-20220214 (https://download.01.org/0day-ci/archive/20220216/202202160331.TbQABF6V-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 37f422f4ac31c8b8041c6b62065263314282dab6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/commit/?id=209043554915d7c51ac112a668ad1a255e1bea61
        git remote add broonie-spi https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
        git fetch --no-tags broonie-spi for-next
        git checkout 209043554915d7c51ac112a668ad1a255e1bea61
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/spi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/spi/spi-amd.c:296:21: warning: cast to smaller integer type 'enum amd_spi_versions' from 'const void *' [-Wvoid-pointer-to-enum-cast]
           amd_spi->version = (enum amd_spi_versions) device_get_match_data(dev);
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +296 drivers/spi/spi-amd.c

   272	
   273	static int amd_spi_probe(struct platform_device *pdev)
   274	{
   275		struct device *dev = &pdev->dev;
   276		struct spi_master *master;
   277		struct amd_spi *amd_spi;
   278		int err = 0;
   279	
   280		/* Allocate storage for spi_master and driver private data */
   281		master = spi_alloc_master(dev, sizeof(struct amd_spi));
   282		if (!master) {
   283			dev_err(dev, "Error allocating SPI master\n");
   284			return -ENOMEM;
   285		}
   286	
   287		amd_spi = spi_master_get_devdata(master);
   288		amd_spi->io_remap_addr = devm_platform_ioremap_resource(pdev, 0);
   289		if (IS_ERR(amd_spi->io_remap_addr)) {
   290			err = PTR_ERR(amd_spi->io_remap_addr);
   291			dev_err(dev, "error %d ioremap of SPI registers failed\n", err);
   292			goto err_free_master;
   293		}
   294		dev_dbg(dev, "io_remap_address: %p\n", amd_spi->io_remap_addr);
   295	
 > 296		amd_spi->version = (enum amd_spi_versions) device_get_match_data(dev);
   297	
   298		/* Initialize the spi_master fields */
   299		master->bus_num = 0;
   300		master->num_chipselect = 4;
   301		master->mode_bits = 0;
   302		master->flags = SPI_MASTER_HALF_DUPLEX;
   303		master->setup = amd_spi_master_setup;
   304		master->transfer_one_message = amd_spi_master_transfer;
   305	
   306		/* Register the controller with SPI framework */
   307		err = devm_spi_register_master(dev, master);
   308		if (err) {
   309			dev_err(dev, "error %d registering SPI controller\n", err);
   310			goto err_free_master;
   311		}
   312	
   313		return 0;
   314	
   315	err_free_master:
   316		spi_master_put(master);
   317	
   318		return err;
   319	}
   320	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
