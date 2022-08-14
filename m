Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79311591EA5
	for <lists+linux-spi@lfdr.de>; Sun, 14 Aug 2022 08:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240117AbiHNGOt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 14 Aug 2022 02:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiHNGOs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 14 Aug 2022 02:14:48 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE30D1F2D5
        for <linux-spi@vger.kernel.org>; Sat, 13 Aug 2022 23:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660457687; x=1691993687;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=InpyNnzSPhvMJn0LPE8bTo8ZzfZy2r0EGYrhlbZyvOI=;
  b=CC+p0V9CE6DTsUbh4Mm0zniZhnEDpi9AQI+CcRQAyj5UJy16MDOAHP1H
   DPzc4PP/LYljhMy8W7C0IL55tmqqlI9ANNBrR62MM+NUCdUXTloSRa0XH
   yeUTixxpMLD0GROXVXh090/cke6RJY3FOU+3rJGvyxwCXO3ZFyGwEbLY6
   fgc5BCF5Db+MgJoACoH5CVDW8FDucZyEDRbsPfU6DvtmOsVW4bpeHVetb
   Su8GT5kfuU/1xUntsdepg5K2c2J1U74Sj6SeSVIHtKZR1m3J22iAkHes2
   s6B6o+AZ+iRXfMWqC7L1v+iokv/mCa/NzHiybS6M62nRMfGVD29WHVS1d
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="278756924"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="278756924"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 23:14:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="602880670"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 13 Aug 2022 23:14:44 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oN6tY-0002Z3-0r;
        Sun, 14 Aug 2022 06:14:44 +0000
Date:   Sun, 14 Aug 2022 14:14:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kbuild-all@lists.01.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [broonie-spi:for-next 66/68] drivers/spi/spi-meson-spicc.c:570:22:
 sparse: sparse: symbol 'meson_spicc_pow2_clk_ops' was not declared. Should
 it be static?
Message-ID: <202208141420.JZ0s0Vj6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
head:   c03094cbad20478afc6c6bc557de76b534448f99
commit: 09992025dacd258c823f50e82db09d7ef06cdac4 [66/68] spi: meson-spicc: add local pow2 clock ops to preserve rate between messages
config: arm64-randconfig-s053-20220812 (https://download.01.org/0day-ci/archive/20220814/202208141420.JZ0s0Vj6-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/commit/?id=09992025dacd258c823f50e82db09d7ef06cdac4
        git remote add broonie-spi https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
        git fetch --no-tags broonie-spi for-next
        git checkout 09992025dacd258c823f50e82db09d7ef06cdac4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/spi/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/spi/spi-meson-spicc.c:570:22: sparse: sparse: symbol 'meson_spicc_pow2_clk_ops' was not declared. Should it be static?

vim +/meson_spicc_pow2_clk_ops +570 drivers/spi/spi-meson-spicc.c

   569	
 > 570	const struct clk_ops meson_spicc_pow2_clk_ops = {
   571		.recalc_rate = meson_spicc_pow2_recalc_rate,
   572		.determine_rate = meson_spicc_pow2_determine_rate,
   573		.set_rate = meson_spicc_pow2_set_rate,
   574	};
   575	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
