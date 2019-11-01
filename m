Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1688AEC7FE
	for <lists+linux-spi@lfdr.de>; Fri,  1 Nov 2019 18:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfKARg5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Nov 2019 13:36:57 -0400
Received: from mga03.intel.com ([134.134.136.65]:37526 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbfKARg4 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 1 Nov 2019 13:36:56 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2019 10:36:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,256,1569308400"; 
   d="scan'208";a="400919723"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 01 Nov 2019 10:36:50 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iQaqw-0009Me-8v; Sat, 02 Nov 2019 01:36:50 +0800
Date:   Sat, 2 Nov 2019 01:36:39 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, broonie@kernel.org, vigneshr@ti.com,
        robh+dt@kernel.org, cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: Re: [PATCH v2 2/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
Message-ID: <201911020136.R1wgSagX%lkp@intel.com>
References: <20191030081155.29947-3-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030081155.29947-3-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi "Ramuthevar,Vadivel,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on spi/for-next]
[also build test WARNING on v5.4-rc5 next-20191031]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Ramuthevar-Vadivel-MuruganX/spi-cadence-quadpsi-Add-support-for-the-Cadence-QSPI-controller/20191101-174846
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/spi/spi-cadence-quadspi.c:54:14: sparse: sparse: symbol 'cadence_qspi_init_timeout' was not declared. Should it be static?
>> drivers/spi/spi-cadence-quadspi.c:59:14: sparse: sparse: symbol 'cadence_qspi_check_timeout' was not declared. Should it be static?
>> drivers/spi/spi-cadence-quadspi.c:105:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
>> drivers/spi/spi-cadence-quadspi.c:105:30: sparse:    expected void const volatile [noderef] <asn:2> *addr
>> drivers/spi/spi-cadence-quadspi.c:105:30: sparse:    got void *
>> drivers/spi/spi-cadence-quadspi.c:111:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
>> drivers/spi/spi-cadence-quadspi.c:111:30: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:111:30: sparse:    got void *
>> drivers/spi/spi-cadence-quadspi.c:101:6: sparse: sparse: symbol 'enable_qspi_direct_access' was not declared. Should it be static?
   drivers/spi/spi-cadence-quadspi.c:118:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:118:30: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:118:30: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:124:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:124:30: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:124:30: sparse:    got void *
>> drivers/spi/spi-cadence-quadspi.c:114:6: sparse: sparse: symbol 'cadence_qspi_controller_enable' was not declared. Should it be static?
   drivers/spi/spi-cadence-quadspi.c:133:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:133:21: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:133:21: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:151:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:151:30: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:151:30: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:161:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:161:30: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:161:30: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:174:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:174:30: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:174:30: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:177:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:177:30: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:177:30: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:186:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:186:30: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:186:30: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:198:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:198:30: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:198:30: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:206:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:206:30: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:206:30: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:208:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:208:30: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:208:30: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:212:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:212:38: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:212:38: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:242:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:242:45: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:242:45: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:251:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:251:30: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:251:30: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:257:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:257:38: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:257:38: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:280:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:280:39: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:280:39: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:287:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:287:45: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:287:45: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:302:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:302:45: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:302:45: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:313:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:313:39: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:313:39: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:323:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:323:30: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:323:30: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:325:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:325:30: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:325:30: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:328:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:328:30: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:328:30: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:330:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:330:30: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:330:30: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:332:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:332:30: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:332:30: sparse:    got void *
>> drivers/spi/spi-cadence-quadspi.c:422:31: sparse: sparse: incorrect type in initializer (different address spaces) @@    expected void *reg_base @@    got void [noderef] <asvoid *reg_base @@
>> drivers/spi/spi-cadence-quadspi.c:422:31: sparse:    expected void *reg_base
>> drivers/spi/spi-cadence-quadspi.c:422:31: sparse:    got void [noderef] <asn:2> *iobase
>> drivers/spi/spi-cadence-quadspi.c:423:31: sparse: sparse: incorrect type in initializer (different address spaces) @@    expected void *ahb_base @@    got void [noderef] <asvoid *ahb_base @@
>> drivers/spi/spi-cadence-quadspi.c:423:31: sparse:    expected void *ahb_base
>> drivers/spi/spi-cadence-quadspi.c:423:31: sparse:    got void [noderef] <asn:2> *qspi_ahb_virt
   drivers/spi/spi-cadence-quadspi.c:431:28: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:431:28: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:431:28: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:432:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:432:30: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:432:30: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:433:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:433:36: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:433:36: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:438:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:438:25: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:438:25: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:440:48: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:440:48: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:440:48: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:441:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:441:44: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:441:44: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:445:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:445:25: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:445:25: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:448:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:448:33: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:448:33: sparse:    got void *
>> drivers/spi/spi-cadence-quadspi.c:458:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void [noderef] <asn:2> *port @@    got n:2> *port @@
>> drivers/spi/spi-cadence-quadspi.c:458:46: sparse:    expected void [noderef] <asn:2> *port
>> drivers/spi/spi-cadence-quadspi.c:458:46: sparse:    got void *ahb_base
>> drivers/spi/spi-cadence-quadspi.c:461:62: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void [noderef] <asn:2> * @@    got n:2> * @@
>> drivers/spi/spi-cadence-quadspi.c:461:62: sparse:    expected void [noderef] <asn:2> *
   drivers/spi/spi-cadence-quadspi.c:461:62: sparse:    got void *ahb_base
   drivers/spi/spi-cadence-quadspi.c:470:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:470:41: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:470:41: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:480:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:480:38: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:480:38: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:490:28: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:490:28: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:490:28: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:492:57: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:492:57: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:492:57: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:497:28: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:497:28: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:497:28: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:500:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:500:25: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:500:25: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:514:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:514:30: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:514:30: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:517:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:517:30: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:517:30: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:531:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:531:30: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:531:30: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:534:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:534:30: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:534:30: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:535:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:535:30: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:535:30: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:538:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:538:30: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:538:30: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:541:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:541:30: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:541:30: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:543:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:543:30: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:543:30: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:555:31: sparse: sparse: incorrect type in initializer (different address spaces) @@    expected void *reg_base @@    got void [noderef] <asvoid *reg_base @@
   drivers/spi/spi-cadence-quadspi.c:555:31: sparse:    expected void *reg_base
   drivers/spi/spi-cadence-quadspi.c:555:31: sparse:    got void [noderef] <asn:2> *iobase
   drivers/spi/spi-cadence-quadspi.c:556:31: sparse: sparse: incorrect type in initializer (different address spaces) @@    expected void *ahb_base @@    got void [noderef] <asvoid *ahb_base @@
   drivers/spi/spi-cadence-quadspi.c:556:31: sparse:    expected void *ahb_base
   drivers/spi/spi-cadence-quadspi.c:556:31: sparse:    got void [noderef] <asn:2> *qspi_ahb_virt
   drivers/spi/spi-cadence-quadspi.c:563:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:563:30: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:563:30: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:564:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:564:30: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:564:30: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:565:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:565:30: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:565:30: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:570:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:570:30: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:570:30: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:572:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:572:36: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:572:36: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:573:54: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:573:54: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:573:54: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:575:48: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:575:48: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:575:48: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:576:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:576:44: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:576:44: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:579:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:579:25: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:579:25: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:592:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void [noderef] <asn:2> *port @@    got n:2> *port @@
   drivers/spi/spi-cadence-quadspi.c:592:39: sparse:    expected void [noderef] <asn:2> *port
   drivers/spi/spi-cadence-quadspi.c:592:39: sparse:    got void *ahb_base
   drivers/spi/spi-cadence-quadspi.c:599:41: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void [noderef] <asn:2> * @@    got n:2> * @@
   drivers/spi/spi-cadence-quadspi.c:599:41: sparse:    expected void [noderef] <asn:2> *
   drivers/spi/spi-cadence-quadspi.c:599:41: sparse:    got void *ahb_base
>> drivers/spi/spi-cadence-quadspi.c:606:28: sparse: sparse: dubious: !x & y
   drivers/spi/spi-cadence-quadspi.c:621:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:621:38: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:621:38: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:635:28: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:635:28: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:635:28: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:637:57: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:637:57: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:637:57: sparse:    got void *
   drivers/spi/spi-cadence-quadspi.c:642:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/spi/spi-cadence-quadspi.c:642:33: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/spi/spi-cadence-quadspi.c:642:33: sparse:    got void *
>> drivers/spi/spi-cadence-quadspi.c:647:14: sparse: sparse: symbol 'cadence_qspi_is_controller_ready' was not declared. Should it be static?
>> drivers/spi/spi-cadence-quadspi.c:657:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void *reg_base @@    got void [noderef] <asvoid *reg_base @@
   drivers/spi/spi-cadence-quadspi.c:657:45: sparse:    expected void *reg_base
   drivers/spi/spi-cadence-quadspi.c:657:45: sparse:    got void [noderef] <asn:2> *iobase
   drivers/spi/spi-cadence-quadspi.c:666:48: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void *reg_base @@    got void [noderef] <asvoid *reg_base @@
   drivers/spi/spi-cadence-quadspi.c:666:48: sparse:    expected void *reg_base
   drivers/spi/spi-cadence-quadspi.c:666:48: sparse:    got void [noderef] <asn:2> *iobase
   drivers/spi/spi-cadence-quadspi.c:668:48: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void *reg_base @@    got void [noderef] <asvoid *reg_base @@
   drivers/spi/spi-cadence-quadspi.c:668:48: sparse:    expected void *reg_base
   drivers/spi/spi-cadence-quadspi.c:668:48: sparse:    got void [noderef] <asn:2> *iobase
   drivers/spi/spi-cadence-quadspi.c:677:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void *reg_base @@    got void [noderef] <asvoid *reg_base @@
   drivers/spi/spi-cadence-quadspi.c:677:45: sparse:    expected void *reg_base
   drivers/spi/spi-cadence-quadspi.c:677:45: sparse:    got void [noderef] <asn:2> *iobase
>> drivers/spi/spi-cadence-quadspi.c:652:6: sparse: sparse: symbol 'cadence_qspi_controller_init' was not declared. Should it be static?
   drivers/spi/spi-cadence-quadspi.c:701:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void *reg_base @@    got void [noderef] <asvoid *reg_base @@
   drivers/spi/spi-cadence-quadspi.c:701:45: sparse:    expected void *reg_base
   drivers/spi/spi-cadence-quadspi.c:701:45: sparse:    got void [noderef] <asn:2> *iobase
   drivers/spi/spi-cadence-quadspi.c:722:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void *reg_base @@    got void [noderef] <asvoid *reg_base @@
   drivers/spi/spi-cadence-quadspi.c:722:45: sparse:    expected void *reg_base
   drivers/spi/spi-cadence-quadspi.c:722:45: sparse:    got void [noderef] <asn:2> *iobase
>> drivers/spi/spi-cadence-quadspi.c:690:6: sparse: sparse: symbol 'cadence_qspi_delay' was not declared. Should it be static?
   drivers/spi/spi-cadence-quadspi.c:733:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void *reg_base @@    got void [noderef] <asvoid *reg_base @@
   drivers/spi/spi-cadence-quadspi.c:733:45: sparse:    expected void *reg_base
   drivers/spi/spi-cadence-quadspi.c:733:45: sparse:    got void [noderef] <asn:2> *iobase
   drivers/spi/spi-cadence-quadspi.c:743:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void *reg_base @@    got void [noderef] <asvoid *reg_base @@
   drivers/spi/spi-cadence-quadspi.c:743:25: sparse:    expected void *reg_base
   drivers/spi/spi-cadence-quadspi.c:743:25: sparse:    got void [noderef] <asn:2> *iobase
   drivers/spi/spi-cadence-quadspi.c:744:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void *reg_base @@    got void [noderef] <asvoid *reg_base @@
   drivers/spi/spi-cadence-quadspi.c:744:45: sparse:    expected void *reg_base
   drivers/spi/spi-cadence-quadspi.c:744:45: sparse:    got void [noderef] <asn:2> *iobase
>> drivers/spi/spi-cadence-quadspi.c:725:6: sparse: sparse: symbol 'cadence_qspi_switch_chipselect' was not declared. Should it be static?
   drivers/spi/spi-cadence-quadspi.c:870:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void *reg_base @@    got void [noderef] <asvoid *reg_base @@
   drivers/spi/spi-cadence-quadspi.c:870:40: sparse:    expected void *reg_base
   drivers/spi/spi-cadence-quadspi.c:870:40: sparse:    got void [noderef] <asn:2> *iobase
   drivers/spi/spi-cadence-quadspi.c:871:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void *reg_base @@    got void [noderef] <asvoid *reg_base @@
   drivers/spi/spi-cadence-quadspi.c:871:42: sparse:    expected void *reg_base
   drivers/spi/spi-cadence-quadspi.c:871:42: sparse:    got void [noderef] <asn:2> *iobase
   drivers/spi/spi-cadence-quadspi.c:874:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void *reg_base @@    got void [noderef] <asvoid *reg_base @@
   drivers/spi/spi-cadence-quadspi.c:874:39: sparse:    expected void *reg_base
   drivers/spi/spi-cadence-quadspi.c:874:39: sparse:    got void [noderef] <asn:2> *iobase
   drivers/spi/spi-cadence-quadspi.c:875:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void *reg_base @@    got void [noderef] <asvoid *reg_base @@
   drivers/spi/spi-cadence-quadspi.c:875:40: sparse:    expected void *reg_base
   drivers/spi/spi-cadence-quadspi.c:875:40: sparse:    got void [noderef] <asn:2> *iobase
   drivers/spi/spi-cadence-quadspi.c:880:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void *reg_base @@    got void [noderef] <asvoid *reg_base @@
   drivers/spi/spi-cadence-quadspi.c:880:43: sparse:    expected void *reg_base
   drivers/spi/spi-cadence-quadspi.c:880:43: sparse:    got void [noderef] <asn:2> *iobase
   drivers/spi/spi-cadence-quadspi.c:888:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void *reg_base @@    got void [noderef] <asvoid *reg_base @@
   drivers/spi/spi-cadence-quadspi.c:888:42: sparse:    expected void *reg_base
   drivers/spi/spi-cadence-quadspi.c:888:42: sparse:    got void [noderef] <asn:2> *iobase
   drivers/spi/spi-cadence-quadspi.c:896:50: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void *reg_base @@    got void [noderef] <asvoid *reg_base @@
   drivers/spi/spi-cadence-quadspi.c:896:50: sparse:    expected void *reg_base
   drivers/spi/spi-cadence-quadspi.c:896:50: sparse:    got void [noderef] <asn:2> *iobase
>> drivers/spi/spi-cadence-quadspi.c:899:80: sparse: sparse: Using plain integer as NULL pointer
   drivers/spi/spi-cadence-quadspi.c:907:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void *reg_base @@    got void [noderef] <asvoid *reg_base @@
   drivers/spi/spi-cadence-quadspi.c:907:49: sparse:    expected void *reg_base
   drivers/spi/spi-cadence-quadspi.c:907:49: sparse:    got void [noderef] <asn:2> *iobase
   drivers/spi/spi-cadence-quadspi.c:910:79: sparse: sparse: Using plain integer as NULL pointer
>> drivers/spi/spi-cadence-quadspi.c:927:5: sparse: sparse: symbol 'cadence_qspi_exec_mem_op' was not declared. Should it be static?
>> drivers/spi/spi-cadence-quadspi.c:1225:52: sparse: sparse: too many warnings

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
