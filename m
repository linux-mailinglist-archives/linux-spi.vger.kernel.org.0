Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 411EC12C806
	for <lists+linux-spi@lfdr.de>; Sun, 29 Dec 2019 19:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731814AbfL2RuM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 29 Dec 2019 12:50:12 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:60310 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731800AbfL2RuM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 29 Dec 2019 12:50:12 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBTHirnl115848;
        Sun, 29 Dec 2019 17:49:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2019-08-05; bh=+xKNiFV7vrb3mgm8D0eOEGk+mvkAClmSIZ+AutFFSMc=;
 b=DUb9bgO7x6Kf8++8h6LOeFDHI9bMxcixKtqqlR3ye1psZyo3S3+ZMGm4Z59gDxh38Con
 7MEC/JOJcJ88c62g8GFZOep/X65uScyjylb+Bz4rK5V5Ytym4JGlrU9xo4gdgO6fxc0w
 KZGXpCIm67Cgt/jt4AZ00XL+yWsojlAp0zO+/6AMONX/Tr3EkLWMplYf1YbhG0xB2JWt
 SEwxsgSKU5/UGaqCvRMI3sVRoUZbWEctCCKt+IbidgSqnlXQY97Ome1aMrYICyvobFTP
 ntig8am1cC43Fr5qZUzgWzUU5b3S9vjVXwUZ7M/vtSJDQiv4kilfgPt4FubGLju96qYh Ig== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2x5y0pbb0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 29 Dec 2019 17:49:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBTHnC3n147216;
        Sun, 29 Dec 2019 17:49:59 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2x6gjwvbpd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 29 Dec 2019 17:49:59 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBTHnvld008075;
        Sun, 29 Dec 2019 17:49:57 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 29 Dec 2019 09:49:56 -0800
Date:   Sun, 29 Dec 2019 20:49:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     kbuild-all@lists.01.org, broonie@kernel.org, vigneshr@ti.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: Re: [PATCH v5 2/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
Message-ID: <20191229174947.GB3889@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191226071058.20041-3-vadivel.muruganx.ramuthevar@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9485 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912290168
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9485 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912290168
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi "Ramuthevar,Vadivel,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on spi/for-next]
[cannot apply to v5.5-rc3 next-20191219]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Ramuthevar-Vadivel-MuruganX/spi-cadence-quadpsi-Add-support-for-the-Cadence-QSPI-controller/20191226-152805
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/spi/spi-cadence-quadspi.c:412 cqspi_read_execute() warn: if statement not indented
drivers/spi/spi-cadence-quadspi.c:1015 cqspi_probe() error: we previously assumed 'pdata' could be null (see line 1004)

# https://github.com/0day-ci/linux/commit/7d7e98888a40e593dcd442db83b53d92980c036f
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 7d7e98888a40e593dcd442db83b53d92980c036f
vim +412 drivers/spi/spi-cadence-quadspi.c

7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  381  static int cqspi_read_execute(struct struct_cqspi *cqspi,
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  382  			      const struct spi_mem_op *op, u8 *rxbuf)
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  383  {
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  384  	struct platform_device *pdev = cqspi->pdev;
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  385  	struct cqspi_platform_data *pdata = pdev->dev.platform_data;
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  386  	void *reg_base = cqspi->iobase;
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  387  	void *ahb_base = cqspi->qspi_ahb_virt;
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  388  	u32 rxlen = op->data.nbytes;
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  389  	u8 *rxbuf_end = rxbuf + rxlen;
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  390  	u32 mod_bytes = rxlen % 4;
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  391  	u32 bytes_to_read = 0;
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  392  	int remaining = op->data.nbytes;
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  393  	unsigned long timeout;
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  394  	int ret;
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  395  
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  396  	writel(remaining, reg_base + CQSPI_REG_INDIRECTRDBYTES);
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  397  
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  398  	mb();/* flush previous writes */
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  399  
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  400  	writel(pdata->fifo_depth - CQSPI_REG_SRAM_RESV_WORDS,
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  401  	       reg_base + CQSPI_REG_SRAMPARTITION);
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  402  	/* Clear all interrupts. */
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  403  	writel(CQSPI_IRQ_STATUS_MASK, reg_base + CQSPI_REG_IRQSTATUS);
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  404  	writel(CQSPI_IRQ_MASK_RD, reg_base + CQSPI_REG_IRQMASK);
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  405  
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  406  	reinit_completion(&cqspi->transfer_complete);
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  407  	writel(CQSPI_REG_INDIRECTRD_START_MASK,
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  408  	       reg_base + CQSPI_REG_INDIRECTRD);
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  409  
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  410  	timeout = msecs_to_jiffies(CQSPI_READ_TIMEOUT_MS);
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  411  	while (remaining > 0) {
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26 @412  		if (!wait_for_completion_timeout(&cqspi->transfer_complete,
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  413  						 timeout))
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  414  		ret = -ETIMEDOUT;

This should be indented and "return -ETIMEDOUT;" or a break or
something?

7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  415  
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  416  		bytes_to_read = CQSPI_GET_RD_SRAM_LEVEL(reg_base);
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  417  
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  418  		while (bytes_to_read != 0) {
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  419  			unsigned int word_remain = round_down(remaining, 4);
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  420  
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  421  			bytes_to_read *= CQSPI_FIFO_WIDTH;
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  422  			bytes_to_read = bytes_to_read > remaining ?
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  423  						remaining : bytes_to_read;
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  424  			bytes_to_read = round_down(bytes_to_read, 4);
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  425  			if (bytes_to_read) {
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  426  				ioread32_rep(ahb_base, rxbuf,
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  427  					     (bytes_to_read / 4));
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  428  			} else if (!word_remain && mod_bytes) {
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  429  				unsigned int temp = ioread32(ahb_base);
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  430  
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  431  				bytes_to_read = mod_bytes;
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  432  				memcpy(rxbuf, &temp, min((unsigned int)
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  433  				       (rxbuf_end - rxbuf), bytes_to_read));
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  434  			}
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  435  
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  436  			rxbuf += bytes_to_read;
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  437  			remaining -= bytes_to_read;
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  438  			bytes_to_read = CQSPI_GET_RD_SRAM_LEVEL(reg_base);
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  439  		}
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  440  
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  441  		if (remaining < 0)
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  442  			reinit_completion(&cqspi->transfer_complete);
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  443  	}
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  444  
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  445  	/* Check indirect done status */
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  446  	ret = cqspi_wait_for_bit(reg_base + CQSPI_REG_INDIRECTRD,
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  447  				 CQSPI_REG_INDIRECTRD_DONE_MASK, 0);
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  448  	if (ret) {
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  449  		dev_err(&pdev->dev,
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  450  			"Indirect read completion error (%i)\n", ret);
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  451  		goto failrd;
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  452  	}
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  453  
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  454  	/* Disable interrupt */
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  455  	writel(0, reg_base + CQSPI_REG_IRQMASK);
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  456  	/* Clear indirect completion status */
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  457  	writel(CQSPI_REG_INDIRECTRD_DONE_MASK, reg_base + CQSPI_REG_INDIRECTRD);
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  458  
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  459  	return 0;
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  460  failrd:
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  461  	/* Disable interrupt */
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  462  	writel(0, reg_base + CQSPI_REG_IRQMASK);
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  463  	/* Cancel the indirect read */
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  464  	writel(CQSPI_REG_INDIRECTWR_CANCEL_MASK,
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  465  	       reg_base + CQSPI_REG_INDIRECTRD);
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  466  	return ret;
7d7e98888a40e5 Ramuthevar Vadivel Murugan 2019-12-26  467  }

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
