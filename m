Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4ACD377E7B
	for <lists+linux-spi@lfdr.de>; Mon, 10 May 2021 10:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhEJIsL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 May 2021 04:48:11 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:35868 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229566AbhEJIsL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 10 May 2021 04:48:11 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14A8edQx012608;
        Mon, 10 May 2021 10:46:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=gLZ7mE45GX+/Rue6eF9SDZtTt1uYV8yCxcdR3gjYKwY=;
 b=0xJnnIjwplGjY7owfr01KNyeoEVs5/VMkC4q5UO9gmD9C4uyWHm+9Miyc8vs+yliOabv
 8Z55kiXcNEW2qhuLtuO+6SHA2joXda7x3ZmBjlDO3q+eWyZO+0RKWnwAZFIpRsvas20K
 6IYxeaId0IG/46Zkvqg+SLHHTMzM7lX5Lw1JHc4exquStqh70VD5Rcu/QUVb4qLEWEzh
 unxEYQpY5Wyuwa+iD63960+NUgvObr4+lc4eEIqi6KYRQMd5Ie8rkmDAJzbcPu+m/URs
 B9A5IE7lit8EL6mzJeVGjTu7rrkSLzytjKxFjEjN8eo9/g6Oc05ByUryA08H+s3XLFeH Ag== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38ekxj3709-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 May 2021 10:46:50 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 10A2E10002A;
        Mon, 10 May 2021 10:46:50 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E44A421E673;
        Mon, 10 May 2021 10:46:49 +0200 (CEST)
Received: from lmecxl0573.lme.st.com (10.75.127.44) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 10 May
 2021 10:46:48 +0200
Subject: Re: [PATCH v2 1/3] spi: spi-mem: add automatic poll status functions
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        Mark Brown <broonie@kernel.org>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>
References: <20210507131756.17028-1-patrice.chotard@foss.st.com>
 <20210507131756.17028-2-patrice.chotard@foss.st.com>
 <20210508095506.4d0d628a@collabora.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
Message-ID: <542000b4-1a65-5090-72f9-441c75ee1098@foss.st.com>
Date:   Mon, 10 May 2021 10:46:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210508095506.4d0d628a@collabora.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-10_04:2021-05-10,2021-05-10 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Boris

On 5/8/21 9:55 AM, Boris Brezillon wrote:
> On Fri, 7 May 2021 15:17:54 +0200
> <patrice.chotard@foss.st.com> wrote:
> 
>> From: Patrice Chotard <patrice.chotard@foss.st.com>
>>
>> With STM32 QSPI, it is possible to poll the status register of the device.
>> This could be done to offload the CPU during an operation (erase or
>> program a SPI NAND for example).
>>
>> spi_mem_poll_status API has been added to handle this feature.
>> This new function take care of the offload/non-offload cases.
>>
>> For the non-offload case, use read_poll_timeout() to poll the status in
>> order to release CPU during this phase.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
>> ---
>> Changes in v2:
>>   - Indicates the spi_mem_poll_status() timeout unit
>>   - Use 2-byte wide status register
>>   - Add spi_mem_supports_op() call in spi_mem_poll_status()
>>   - Add completion management in spi_mem_poll_status()
>>   - Add offload/non-offload case mangement in spi_mem_poll_status()
>>   - Optimize the non-offload case by using read_poll_timeout()
>>
>>  drivers/spi/spi-mem.c       | 71 +++++++++++++++++++++++++++++++++++++
>>  include/linux/spi/spi-mem.h | 10 ++++++
>>  2 files changed, 81 insertions(+)
>>
>> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
>> index 1513553e4080..3f29c604df7d 100644
>> --- a/drivers/spi/spi-mem.c
>> +++ b/drivers/spi/spi-mem.c
>> @@ -6,6 +6,7 @@
>>   * Author: Boris Brezillon <boris.brezillon@bootlin.com>
>>   */
>>  #include <linux/dmaengine.h>
>> +#include <linux/iopoll.h>
>>  #include <linux/pm_runtime.h>
>>  #include <linux/spi/spi.h>
>>  #include <linux/spi/spi-mem.h>
>> @@ -743,6 +744,75 @@ static inline struct spi_mem_driver *to_spi_mem_drv(struct device_driver *drv)
>>  	return container_of(drv, struct spi_mem_driver, spidrv.driver);
>>  }
>>  
>> +/**
>> + * spi_mem_finalize_op - report completion of spi_mem_op
>> + * @ctlr: the controller reporting completion
>> + *
>> + * Called by SPI drivers using the spi-mem spi_mem_poll_status()
>> + * implementation to notify it that the current spi_mem_op has
>> + * finished.
>> + */
>> +void spi_mem_finalize_op(struct spi_controller *ctlr)
>> +{
>> +	complete(&ctlr->xfer_completion);
>> +}
>> +EXPORT_SYMBOL_GPL(spi_mem_finalize_op);
>> +
>> +/**
>> + * spi_mem_poll_status() - Poll memory device status
>> + * @mem: SPI memory device
>> + * @op: the memory operation to execute
>> + * @mask: status bitmask to ckeck
>> + * @match: (status & mask) expected value
>> + * @timeout_ms: timeout in milliseconds
>> + *
>> + * This function send a polling status request to the controller driver
>> + *
>> + * Return: 0 in case of success, -ETIMEDOUT in case of error,
>> + *         -EOPNOTSUPP if not supported.
>> + */
>> +int spi_mem_poll_status(struct spi_mem *mem,
>> +			const struct spi_mem_op *op,
>> +			u16 mask, u16 match, u16 timeout_ms)
>> +{
>> +	struct spi_controller *ctlr = mem->spi->controller;
>> +	unsigned long ms;
>> +	int ret = -EOPNOTSUPP;
>> +	int exec_op_ret;
>> +	u16 *status;
>> +
>> +	if (!spi_mem_supports_op(mem, op))
>> +		return ret;
> 
> You should only test that in the SW-based polling path. The driver
> ->poll_status() method is expected to check the operation and
> return -EOPNOTSUPP if HW-based polling doesn't work for this op,
> no need to check things twice.

Ok, i will fix this.

> 
>> +
>> +	if (ctlr->mem_ops && ctlr->mem_ops->poll_status) {
>> +		ret = spi_mem_access_start(mem);
>> +		if (ret)
>> +			return ret;
>> +
>> +		reinit_completion(&ctlr->xfer_completion);
>> +
>> +		ret = ctlr->mem_ops->poll_status(mem, op, mask, match,
>> +						 timeout_ms);
>> +
>> +		ms = wait_for_completion_timeout(&ctlr->xfer_completion,
>> +						 msecs_to_jiffies(timeout_ms));
> 
> Why do you need to wait here? I'd expect the poll_status to take care
> of this wait.

It was a request from Mark Brown [1]. The idea is to implement
similar mechanism already used in SPI framework.

[1] https://patchwork.kernel.org/project/linux-arm-kernel/patch/20210426143934.25275-2-patrice.chotard@foss.st.com/#24140527

> 
>> +
>> +		spi_mem_access_end(mem);
>> +		if (!ms)
>> +			return -ETIMEDOUT;
>> +	} else {
>> +		status = (u16 *)op->data.buf.in;
> 
> Hm, I don't think it's safe, for 2 reasons:
> 
> 1/ op->data.buf.in might be a 1byte buffer, but you're doing a 2byte check
> 2/ data is in big endian in the SPI buffer, which means your check
>    won't work on LE architectures.
> 
> You really need a dedicated spi_mem_read_status() function that's passed
> an u16 pointer:

Yes, agree

> 
> int spi_mem_read_status(struct spi_mem *mem,
> 			const struct spi_mem_op *op,
> 			u16 *status)
> {
> 	const u8 *bytes = (u8 *)op->data.buf.in;
> 	int ret;
> 
> 	ret = spi_mem_exec_op(mem, op);
> 	if (ret)
> 		return ret;
> 
> 	if (op->data.nbytes > 1)
> 		*status = ((u16)bytes[0] << 8) | bytes[1];
> 	else
> 		*status = bytes[0];
> 
> 	return 0;
> }
> 
>> +		ret = read_poll_timeout(spi_mem_exec_op, exec_op_ret,
>> +					((*status) & mask) == match, 20,
>> +					timeout_ms * 1000, false, mem, op);
>> +		if (exec_op_ret)
>> +			return exec_op_ret;
>> +	}
>> +
> 
> I would do something like this instead:
> 
> int spi_mem_poll_status(struct spi_mem *mem,
> 			const struct spi_mem_op *op,
> 			u16 mask, u16 match, u16 timeout_ms)
> {
> 	struct spi_controller *ctlr = mem->spi->controller;
> 	int ret = -EOPNOTSUPP;
> 
> 	if (op->data.nbytes < 1 || op->data.nbytes > 2)
> 		return -EINVAL;
> 
> 	if (ctlr->mem_ops && ctlr->mem_ops->poll_status) {
> 		ret = spi_mem_access_start(mem);
> 		if (ret)
> 			return ret;
> 
> 		ret = ctlr->mem_ops->poll_status(mem, op, mask, match,
> 						 timeout_ms);
> 
> 		spi_mem_access_end(mem);
> 	}
> 
> 
> 	if (ret == -EOPNOTSUPP) {
>                 u16 status;
> 		int read_status_ret;
> 
> 		if (!spi_mem_supports_op(mem, op))
> 			return -EOPNOTSUPP;
> 
> 		ret = read_poll_timeout(spi_mem_read_status, exec_op_ret,
> 					(read_status_ret || ((status & mask) == match), 20,
> 					timeout_ms * 1000, false, mem, op, &status);
> 
> 		if (read_status_ret)
> 			return read_status_ret;
> 	}
> 
> 	return ret;
> }
> 
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(spi_mem_poll_status);
>> +
>>  static int spi_mem_probe(struct spi_device *spi)
>>  {
>>  	struct spi_mem_driver *memdrv = to_spi_mem_drv(spi->dev.driver);
>> @@ -763,6 +833,7 @@ static int spi_mem_probe(struct spi_device *spi)
>>  	if (IS_ERR_OR_NULL(mem->name))
>>  		return PTR_ERR_OR_ZERO(mem->name);
>>  
>> +	init_completion(&ctlr->xfer_completion);
>>  	spi_set_drvdata(spi, mem);
>>  
>>  	return memdrv->probe(mem);
>> diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
>> index 2b65c9edc34e..0fbf5d0a3d31 100644
>> --- a/include/linux/spi/spi-mem.h
>> +++ b/include/linux/spi/spi-mem.h
>> @@ -250,6 +250,7 @@ static inline void *spi_mem_get_drvdata(struct spi_mem *mem)
>>   *		  the currently mapped area), and the caller of
>>   *		  spi_mem_dirmap_write() is responsible for calling it again in
>>   *		  this case.
>> + * @poll_status: poll memory device status
>>   *
>>   * This interface should be implemented by SPI controllers providing an
>>   * high-level interface to execute SPI memory operation, which is usually the
>> @@ -274,6 +275,9 @@ struct spi_controller_mem_ops {
>>  			       u64 offs, size_t len, void *buf);
>>  	ssize_t (*dirmap_write)(struct spi_mem_dirmap_desc *desc,
>>  				u64 offs, size_t len, const void *buf);
>> +	int (*poll_status)(struct spi_mem *mem,
>> +			   const struct spi_mem_op *op,
>> +			   u16 mask, u16 match, unsigned long timeout);
>>  };
>>  
>>  /**
>> @@ -369,6 +373,12 @@ devm_spi_mem_dirmap_create(struct device *dev, struct spi_mem *mem,
>>  void devm_spi_mem_dirmap_destroy(struct device *dev,
>>  				 struct spi_mem_dirmap_desc *desc);
>>  
>> +void spi_mem_finalize_op(struct spi_controller *ctlr);
>> +
>> +int spi_mem_poll_status(struct spi_mem *mem,
>> +			const struct spi_mem_op *op,
>> +			u16 mask, u16 match, u16 timeout);
>> +
>>  int spi_mem_driver_register_with_owner(struct spi_mem_driver *drv,
>>  				       struct module *owner);
>>  
> 
Thanks

Patrice
