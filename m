Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D056936DA
	for <lists+linux-spi@lfdr.de>; Sun, 12 Feb 2023 11:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjBLKUq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 12 Feb 2023 05:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBLKUp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 12 Feb 2023 05:20:45 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0CA5BB1;
        Sun, 12 Feb 2023 02:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676197244; x=1707733244;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0dYjb/FZF1cTnvMYarDtzuImV+WjlJqATcEUQBlZZv8=;
  b=Qe9z2TOf5WuzKuuwzWBgbvfDtgnfg/7IMBj5cHWKMZDG169FIoGxwqxn
   WTXrHJGC8qOBr3ApYZdB5/b5HuYn+xvGuHhbzHhO7XADCxPzDuZ5X1Mw7
   ZJMP6yc+b+D/1/Q8T8veVRfIJO0OLU/oFPGALtS64pTA5Xn/D2NiBrgJt
   NcVrFCFrpDSV30b36LI5itnbqC5PTsvkwos28OhKZoEUKXrApKR0s7+os
   pidAaGjUU677H6ZovR/xGStzcbvMjUn8A/m+neYqgnUNDE+iL9jV3cWGX
   lunzGVOt3fW4EkBCGcIk3jdr3tnvYbTZ4E/hjxIueBiU9Qv0H2WlUb/YZ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10618"; a="332843934"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="332843934"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 02:20:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10618"; a="661853694"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="661853694"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 12 Feb 2023 02:20:42 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pR9TO-0007BJ-0K;
        Sun, 12 Feb 2023 10:20:42 +0000
Date:   Sun, 12 Feb 2023 18:19:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-doc@vger.kernel.org
Subject: [broonie-spi:for-next 43/43] htmldocs: Warning: MAINTAINERS
 references a file that doesn't exist:
 Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi-peripheral-props.yaml
Message-ID: <202302121840.GtduUT37-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
head:   80323599e33f9c19287a1a3707481fb157b27052
commit: 80323599e33f9c19287a1a3707481fb157b27052 [43/43] MAINTAINERS: Add entry for Broadcom Broadband SoC HS SPI drivers
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/commit/?id=80323599e33f9c19287a1a3707481fb157b27052
        git remote add broonie-spi https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
        git fetch --no-tags broonie-spi for-next
        git checkout 80323599e33f9c19287a1a3707481fb157b27052
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302121840.GtduUT37-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi-peripheral-props.yaml

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
