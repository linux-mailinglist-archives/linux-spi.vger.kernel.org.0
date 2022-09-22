Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7725E7047
	for <lists+linux-spi@lfdr.de>; Fri, 23 Sep 2022 01:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiIVXo4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Sep 2022 19:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiIVXoy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 22 Sep 2022 19:44:54 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C39491D7;
        Thu, 22 Sep 2022 16:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663890293; x=1695426293;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u8ne/mbX/v3tUv+AYlgg7RzxEdAzHjPnPS/YxttKFcY=;
  b=Z2SAqIXhh9V0UlOvxBVLrLWsBUafbv08DFi+guykBBngVORGr8zdwEZx
   IBpR3LaIxsSxPKFOxhX1Hdmd6whCBzYKd6ft9Kc1z1CrVheaI8VA9o1nM
   uCbYxM/vFy53l0Yee0gFs18fNN8rSAt3Fg4Rt0YobXVDgVNTzl3UY7SdN
   PDZVDP04UJLexlax0NfOnROV7w0q8NyJGwlJVff6qQGI03PZ5I9gVhpzm
   ScQYO13W0GHFfKkQtujZ7+yNS3LLmqMN+yslbMcGYdVIH3v13nm/Eibb8
   lpKKmkbedsnQyqEbA7I8ch3DUH5D1W4N5w2SqaL/2gIXWuADPDXKLnBWd
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="283557851"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="283557851"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 16:44:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="597653252"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 22 Sep 2022 16:44:47 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obVs6-00055W-3C;
        Thu, 22 Sep 2022 23:44:46 +0000
Date:   Fri, 23 Sep 2022 07:44:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bert Vermeulen <bert@biot.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Bert Vermeulen <bert@biot.com>,
        John Crispin <john@phrozen.org>,
        Benjamin Larsson <benjamin.larsson@iopsys.eu>
Subject: Re: [PATCH 2/3] spi: Add support for the Airoha EN7523 SoC SPI
 controller
Message-ID: <202209230724.y183GHHN-lkp@intel.com>
References: <20220922100410.1101874-3-bert@biot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922100410.1101874-3-bert@biot.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Bert,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on broonie-spi/for-next]
[also build test WARNING on robh/for-next linus/master v6.0-rc6 next-20220921]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bert-Vermeulen/Add-support-for-the-Airoha-EN7523-SPI-controller/20220922-183229
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220923/202209230724.y183GHHN-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/1b16c3608a2ca618f1cea10164a278e931610021
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Bert-Vermeulen/Add-support-for-the-Airoha-EN7523-SPI-controller/20220922-183229
        git checkout 1b16c3608a2ca618f1cea10164a278e931610021
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/spi/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/spi/spi-en7523.c:219:8: warning: no previous prototype for 'max_transfer_size' [-Wmissing-prototypes]
     219 | size_t max_transfer_size(struct spi_device *spi)
         |        ^~~~~~~~~~~~~~~~~
>> drivers/spi/spi-en7523.c:224:5: warning: no previous prototype for 'transfer_one_message' [-Wmissing-prototypes]
     224 | int transfer_one_message(struct spi_controller *ctrl, struct spi_message *msg)
         |     ^~~~~~~~~~~~~~~~~~~~


vim +/max_transfer_size +219 drivers/spi/spi-en7523.c

   218	
 > 219	size_t max_transfer_size(struct spi_device *spi)
   220	{
   221		return ENSPI_MAX_XFER;
   222	}
   223	
 > 224	int transfer_one_message(struct spi_controller *ctrl, struct spi_message *msg)
   225	{
   226		struct spi_transfer *xfer;
   227		int next_xfer_is_rx = 0;
   228	
   229		manual_begin_cmd();
   230		set_cs(0);
   231		list_for_each_entry(xfer, &msg->transfers, transfer_list) {
   232			if (xfer->tx_buf) {
   233				if (!list_is_last(&xfer->transfer_list, &msg->transfers)
   234				    && list_next_entry(xfer, transfer_list)->rx_buf != NULL)
   235					next_xfer_is_rx = 1;
   236				else
   237					next_xfer_is_rx = 0;
   238				msg->actual_length += xfer_write(xfer, next_xfer_is_rx);
   239			} else if (xfer->rx_buf) {
   240				msg->actual_length += xfer_read(xfer);
   241			}
   242		}
   243		set_cs(1);
   244		manual_end_cmd();
   245	
   246		msg->status = 0;
   247		spi_finalize_current_message(ctrl);
   248	
   249		return 0;
   250	}
   251	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
