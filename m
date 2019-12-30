Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3715112CBD0
	for <lists+linux-spi@lfdr.de>; Mon, 30 Dec 2019 03:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfL3CGZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 29 Dec 2019 21:06:25 -0500
Received: from mga05.intel.com ([192.55.52.43]:50803 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbfL3CGZ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 29 Dec 2019 21:06:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Dec 2019 18:06:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,373,1571727600"; 
   d="scan'208";a="213197253"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 29 Dec 2019 18:06:22 -0800
Received: from [10.226.38.14] (unknown [10.226.38.14])
        by linux.intel.com (Postfix) with ESMTP id 57AEB5803C5;
        Sun, 29 Dec 2019 18:06:20 -0800 (PST)
Subject: Re: [PATCH v5 2/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
To:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org
Cc:     kbuild-all@lists.01.org, broonie@kernel.org, vigneshr@ti.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, cheol.yong.kim@intel.com, qi-ming.wu@intel.com
References: <20191229174947.GB3889@kadam>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <f2531392-e0de-5f22-805e-5f46af30bef3@linux.intel.com>
Date:   Mon, 30 Dec 2019 10:06:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191229174947.GB3889@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On 30/12/2019 1:49 AM, Dan Carpenter wrote:
> Hi "Ramuthevar,Vadivel,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on spi/for-next]
> [cannot apply to v5.5-rc3 next-20191219]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/Ramuthevar-Vadivel-MuruganX/spi-cadence-quadpsi-Add-support-for-the-Cadence-QSPI-controller/20191226-152805
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Thanks for the review,  kernel base : 5.5-rc1 since the maintainer tree 
also the same.
> smatch warnings:
> drivers/spi/spi-cadence-quadspi.c:412 cqspi_read_execute() warn: if statement not indented
> drivers/spi/spi-cadence-quadspi.c:1015 cqspi_probe() error: we previously assumed 'pdata' could be null (see line 1004)
sure, will fix it.
---
With Best Regards
Vadivel Murugan
> # https://github.com/0day-ci/linux/commit/7d7e98888a40e593dcd442db83b53d92980c036f
> git remote add linux-review https://github.com/0day-ci/linux
> git remote update linux-review
> git checkout 7d7e98888a40e593dcd442db83b53d92980c036f
> vim +412 drivers/spi/spi-cadence-quadspi.c
>
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  381  static int cqspi_read_execute(struct struct_cqspi *cqspi,
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  382  			      const struct spi_mem_op *op, u8 *rxbuf)
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  383  {
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  384  	struct platform_device *pdev = cqspi->pdev;
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  385  	struct cqspi_platform_data *pdata = pdev->dev.platform_data;
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  386  	void *reg_base = cqspi->iobase;
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  387  	void *ahb_base = cqspi->qspi_ahb_virt;
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  388  	u32 rxlen = op->data.nbytes;
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  389  	u8 *rxbuf_end = rxbuf + rxlen;
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  390  	u32 mod_bytes = rxlen % 4;
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  391  	u32 bytes_to_read = 0;
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  392  	int remaining = op->data.nbytes;
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  393  	unsigned long timeout;
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  394  	int ret;
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  395
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  396  	writel(remaining, reg_base + CQSPI_REG_INDIRECTRDBYTES);
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  397
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  398  	mb();/* flush previous writes */
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  399
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  400  	writel(pdata->fifo_depth - CQSPI_REG_SRAM_RESV_WORDS,
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  401  	       reg_base + CQSPI_REG_SRAMPARTITION);
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  402  	/* Clear all interrupts. */
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  403  	writel(CQSPI_IRQ_STATUS_MASK, reg_base + CQSPI_REG_IRQSTATUS);
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  404  	writel(CQSPI_IRQ_MASK_RD, reg_base + CQSPI_REG_IRQMASK);
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  405
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  406  	reinit_completion(&cqspi->transfer_complete);
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  407  	writel(CQSPI_REG_INDIRECTRD_START_MASK,
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  408  	       reg_base + CQSPI_REG_INDIRECTRD);
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  409
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  410  	timeout = msecs_to_jiffies(CQSPI_READ_TIMEOUT_MS);
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  411  	while (remaining > 0) {
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26 @412  		if (!wait_for_completion_timeout(&cqspi->transfer_complete,
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  413  						 timeout))
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  414  		ret = -ETIMEDOUT;
>
> This should be indented and "return -ETIMEDOUT;" or a break or
> something?
>
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  415
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  416  		bytes_to_read = CQSPI_GET_RD_SRAM_LEVEL(reg_base);
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  417
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  418  		while (bytes_to_read != 0) {
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  419  			unsigned int word_remain = round_down(remaining, 4);
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  420
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  421  			bytes_to_read *= CQSPI_FIFO_WIDTH;
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  422  			bytes_to_read = bytes_to_read > remaining ?
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  423  						remaining : bytes_to_read;
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  424  			bytes_to_read = round_down(bytes_to_read, 4);
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  425  			if (bytes_to_read) {
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  426  				ioread32_rep(ahb_base, rxbuf,
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  427  					     (bytes_to_read / 4));
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  428  			} else if (!word_remain && mod_bytes) {
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  429  				unsigned int temp = ioread32(ahb_base);
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  430
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  431  				bytes_to_read = mod_bytes;
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  432  				memcpy(rxbuf, &temp, min((unsigned int)
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  433  				       (rxbuf_end - rxbuf), bytes_to_read));
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  434  			}
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  435
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  436  			rxbuf += bytes_to_read;
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  437  			remaining -= bytes_to_read;
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  438  			bytes_to_read = CQSPI_GET_RD_SRAM_LEVEL(reg_base);
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  439  		}
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  440
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  441  		if (remaining < 0)
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  442  			reinit_completion(&cqspi->transfer_complete);
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  443  	}
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  444
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  445  	/* Check indirect done status */
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  446  	ret = cqspi_wait_for_bit(reg_base + CQSPI_REG_INDIRECTRD,
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  447  				 CQSPI_REG_INDIRECTRD_DONE_MASK, 0);
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  448  	if (ret) {
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  449  		dev_err(&pdev->dev,
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  450  			"Indirect read completion error (%i)\n", ret);
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  451  		goto failrd;
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  452  	}
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  453
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  454  	/* Disable interrupt */
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  455  	writel(0, reg_base + CQSPI_REG_IRQMASK);
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  456  	/* Clear indirect completion status */
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  457  	writel(CQSPI_REG_INDIRECTRD_DONE_MASK, reg_base + CQSPI_REG_INDIRECTRD);
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  458
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  459  	return 0;
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  460  failrd:
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  461  	/* Disable interrupt */
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  462  	writel(0, reg_base + CQSPI_REG_IRQMASK);
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  463  	/* Cancel the indirect read */
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  464  	writel(CQSPI_REG_INDIRECTWR_CANCEL_MASK,
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  465  	       reg_base + CQSPI_REG_INDIRECTRD);
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  466  	return ret;
> 7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  467  }
>
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology Center
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
