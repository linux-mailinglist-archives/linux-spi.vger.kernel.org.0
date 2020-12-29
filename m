Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE072E6F4A
	for <lists+linux-spi@lfdr.de>; Tue, 29 Dec 2020 10:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgL2JS7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Dec 2020 04:18:59 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54838 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgL2JS6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 29 Dec 2020 04:18:58 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BT9IB40012996;
        Tue, 29 Dec 2020 03:18:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1609233491;
        bh=/6xBBWpT3WRCMMUgBxrheESjHoePUuf+lz9L67kzo7Q=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=WAbJ7HkorHi7TWdJAVbIeEQKvxlmdq30WdoyHAS4TGqixjawrd2qnRDak5N7icMK0
         ucykSJMlilHws8EFnHgcnH8JVbkioF+i7keg14NHa2K8iY/9ah4DrFdgau9321daYY
         rAf0tJr9ionRP+9XFAdbdgtrjPhxMk84jij10cUs=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BT9IA7K103415
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Dec 2020 03:18:10 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 29
 Dec 2020 03:18:10 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 29 Dec 2020 03:18:10 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BT9I9MH069150;
        Tue, 29 Dec 2020 03:18:10 -0600
Date:   Tue, 29 Dec 2020 14:48:08 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     kernel test robot <lkp@intel.com>
CC:     Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <kbuild-all@lists.01.org>, <clang-built-linux@googlegroups.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/7] spi: cadence-quadspi: Wait at least 500 ms for
 direct reads
Message-ID: <20201229091806.eyrakehdxo6762sg@ti.com>
References: <20201222184425.7028-7-p.yadav@ti.com>
 <202012291151.fApnPO6i-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202012291151.fApnPO6i-lkp@intel.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 29/12/20 11:29AM, kernel test robot wrote:
> Hi Pratyush,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on spi/for-next]
> [also build test WARNING on v5.11-rc1 next-20201223]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Pratyush-Yadav/spi-cadence-quadspi-Add-Octal-DTR-support/20201223-025328
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
> config: arm-randconfig-r006-20201221 (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project cee1e7d14f4628d6174b33640d502bff3b54ae45)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         # https://github.com/0day-ci/linux/commit/04a7bcbc449363e5d6f498376c69116567b49d7d
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Pratyush-Yadav/spi-cadence-quadspi-Add-Octal-DTR-support/20201223-025328
>         git checkout 04a7bcbc449363e5d6f498376c69116567b49d7d
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/spi/spi-cadence-quadspi.c:966:24: warning: comparison of distinct pointer types ('typeof (len) *' (aka 'unsigned int *') and 'typeof (500UL) *' (aka 'unsigned long *')) [-Wcompare-distinct-pointer-types]
>                                             msecs_to_jiffies(max(len, 500UL)))) {
>                                                              ^~~~~~~~~~~~~~~
>    include/linux/minmax.h:58:19: note: expanded from macro 'max'
>    #define max(x, y)       __careful_cmp(x, y, >)
>                            ^~~~~~~~~~~~~~~~~~~~~~
>    include/linux/minmax.h:42:24: note: expanded from macro '__careful_cmp'
>            __builtin_choose_expr(__safe_cmp(x, y), \
>                                  ^~~~~~~~~~~~~~~~
>    include/linux/minmax.h:32:4: note: expanded from macro '__safe_cmp'
>                    (__typecheck(x, y) && __no_side_effects(x, y))
>                     ^~~~~~~~~~~~~~~~~
>    include/linux/minmax.h:18:28: note: expanded from macro '__typecheck'
>            (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
>                       ~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
>    1 warning generated.

On arm64 size_t is defined as unsigned long and on arm is it defined as 
unsigned int. So using 500U would generate the same warning on 64-bit 
platforms. Maybe the fix is to do something like: max(len, (size_t)500). 
Any better ideas?

> 
> 
> vim +966 drivers/spi/spi-cadence-quadspi.c
> 
>    919	
>    920	static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
>    921					     u_char *buf, loff_t from, size_t len)
>    922	{
>    923		struct cqspi_st *cqspi = f_pdata->cqspi;
>    924		struct device *dev = &cqspi->pdev->dev;
>    925		enum dma_ctrl_flags flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
>    926		dma_addr_t dma_src = (dma_addr_t)cqspi->mmap_phys_base + from;
>    927		int ret = 0;
>    928		struct dma_async_tx_descriptor *tx;
>    929		dma_cookie_t cookie;
>    930		dma_addr_t dma_dst;
>    931		struct device *ddev;
>    932	
>    933		if (!cqspi->rx_chan || !virt_addr_valid(buf)) {
>    934			memcpy_fromio(buf, cqspi->ahb_base + from, len);
>    935			return 0;
>    936		}
>    937	
>    938		ddev = cqspi->rx_chan->device->dev;
>    939		dma_dst = dma_map_single(ddev, buf, len, DMA_FROM_DEVICE);
>    940		if (dma_mapping_error(ddev, dma_dst)) {
>    941			dev_err(dev, "dma mapping failed\n");
>    942			return -ENOMEM;
>    943		}
>    944		tx = dmaengine_prep_dma_memcpy(cqspi->rx_chan, dma_dst, dma_src,
>    945					       len, flags);
>    946		if (!tx) {
>    947			dev_err(dev, "device_prep_dma_memcpy error\n");
>    948			ret = -EIO;
>    949			goto err_unmap;
>    950		}
>    951	
>    952		tx->callback = cqspi_rx_dma_callback;
>    953		tx->callback_param = cqspi;
>    954		cookie = tx->tx_submit(tx);
>    955		reinit_completion(&cqspi->rx_dma_complete);
>    956	
>    957		ret = dma_submit_error(cookie);
>    958		if (ret) {
>    959			dev_err(dev, "dma_submit_error %d\n", cookie);
>    960			ret = -EIO;
>    961			goto err_unmap;
>    962		}
>    963	
>    964		dma_async_issue_pending(cqspi->rx_chan);
>    965		if (!wait_for_completion_timeout(&cqspi->rx_dma_complete,
>  > 966						 msecs_to_jiffies(max(len, 500UL)))) {
>    967			dmaengine_terminate_sync(cqspi->rx_chan);
>    968			dev_err(dev, "DMA wait_for_completion_timeout\n");
>    969			ret = -ETIMEDOUT;
>    970			goto err_unmap;
>    971		}
>    972	
>    973	err_unmap:
>    974		dma_unmap_single(ddev, dma_dst, len, DMA_FROM_DEVICE);
>    975	
>    976		return ret;
>    977	}
>    978	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



-- 
Regards,
Pratyush Yadav
Texas Instruments India
