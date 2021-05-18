Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E7638780E
	for <lists+linux-spi@lfdr.de>; Tue, 18 May 2021 13:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348882AbhERLwK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 May 2021 07:52:10 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:50936 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241753AbhERLwH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 May 2021 07:52:07 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14IBjkmw007033;
        Tue, 18 May 2021 13:50:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=TyI6mLWhg22te4HWrHX0+RMFUt6r0tF1tR3IUs42inU=;
 b=ROJxTTdqaF5Ca13LXbACyo4kYogxsUo/J1cVzoJCRmjmZwwmkOZiTgHeeXx6knEErxH0
 1iVoSU1vtWMmevncHkgFwD0RWWsLMVqkDDB+ciX9a25VL86Zb9UaR1DFeb2mwPOg3dYg
 p8ZVc/C85Kql0S0OTbhyZahrY/pZQVjtPrHns2TfPjw7LBy6fSJl+SbcvFkwVdQxIhno
 EijL03g3zFDbshpGYCS+yW1Z9yZS9DVrxAS/nwPGjkehmIvmEVxQzEO4CjqmlGqr87So
 TCClxyQXteXoA3IHDcFYx05O/noMnkcgDUnc5eBZTJ+ntJgB9nuG6X1CSSEgG4zr56JV Tg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38m4672xey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 May 2021 13:50:37 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A1F0E10002A;
        Tue, 18 May 2021 13:50:36 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 91BBF21F136;
        Tue, 18 May 2021 13:50:36 +0200 (CEST)
Received: from lmecxl0573.lme.st.com (10.75.127.48) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 18 May
 2021 13:50:35 +0200
Subject: Re: [PATCH v3 1/3] spi: spi-mem: add automatic poll status functions
To:     Boris Brezillon <boris.brezillon@collabora.com>
CC:     Mark Brown <broonie@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>
References: <20210518093951.23136-1-patrice.chotard@foss.st.com>
 <20210518093951.23136-2-patrice.chotard@foss.st.com>
 <20210518133054.3240b088@collabora.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
Message-ID: <45e03fff-2189-4f38-6e57-32117267656c@foss.st.com>
Date:   Tue, 18 May 2021 13:50:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210518133054.3240b088@collabora.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-18_04:2021-05-18,2021-05-18 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Boris

On 5/18/21 1:30 PM, Boris Brezillon wrote:
> On Tue, 18 May 2021 11:39:49 +0200
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
>> For example, previously, when erasing large area, in non-offload case,
>> CPU load can reach ~50%, now it decrease to ~35%.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
>> ---
>> Changes in v3:
>>   - Add spi_mem_read_status() which allows to read 8 or 16 bits status.
>>   - Add initial_delay_us and polling_delay_us parameters to spi_mem_poll_status()
>>     and also to poll_status() callback.
>>   - Move spi_mem_supports_op() in SW-based polling case.
>>   - Add delay before invoking read_poll_timeout().
>>   - Remove the reinit/wait_for_completion() added in v2.
>>
>> Changes in v2:
>>   - Indicates the spi_mem_poll_status() timeout unit
>>   - Use 2-byte wide status register
>>   - Add spi_mem_supports_op() call in spi_mem_poll_status()
>>   - Add completion management in spi_mem_poll_status()
>>   - Add offload/non-offload case management in spi_mem_poll_status()
>>   - Optimize the non-offload case by using read_poll_timeout()
>>
>>  drivers/spi/spi-mem.c       | 85 +++++++++++++++++++++++++++++++++++++
>>  include/linux/spi/spi-mem.h | 14 ++++++
>>  2 files changed, 99 insertions(+)
>>
>> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
>> index 1513553e4080..257dc501d5df 100644
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
>> @@ -743,6 +744,89 @@ static inline struct spi_mem_driver *to_spi_mem_drv(struct device_driver *drv)
>>  	return container_of(drv, struct spi_mem_driver, spidrv.driver);
>>  }
>>  
>> +int spi_mem_read_status(struct spi_mem *mem,
>> +			const struct spi_mem_op *op,
>> +			u16 *status)
>> +{
>> +	const u8 *bytes = (u8 *)op->data.buf.in;
>> +	int ret;
>> +
>> +	ret = spi_mem_exec_op(mem, op);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (op->data.nbytes > 1)
>> +		*status = ((u16)bytes[0] << 8) | bytes[1];
>> +	else
>> +		*status = bytes[0];
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * spi_mem_poll_status() - Poll memory device status
>> + * @mem: SPI memory device
>> + * @op: the memory operation to execute
>> + * @mask: status bitmask to ckeck
>> + * @match: (status & mask) expected value
>> + * @initial_delay_us: delay in us before starting to poll
>> + * @polling_delay_us: time to sleep between reads in us
>> + * @timeout_ms: timeout in milliseconds
>> + *
>> + * This function send a polling status request to the controller driver
>> + *
>> + * Return: 0 in case of success, -ETIMEDOUT in case of error,
>> + *         -EOPNOTSUPP if not supported.
>> + */
>> +int spi_mem_poll_status(struct spi_mem *mem,
>> +			const struct spi_mem_op *op,
>> +			u16 mask, u16 match,
>> +			unsigned long initial_delay_us,
>> +			unsigned long polling_delay_us,
>> +			u16 timeout_ms)
>> +{
>> +	struct spi_controller *ctlr = mem->spi->controller;
>> +	int ret = -EOPNOTSUPP;
>> +	int read_status_ret;
>> +	u16 status;
>> +
>> +	if (op->data.nbytes < 1 || op->data.nbytes > 2)
>> +		return -EINVAL;
>> +
>> +	if (ctlr->mem_ops && ctlr->mem_ops->poll_status) {
>> +		ret = spi_mem_access_start(mem);
>> +		if (ret)
>> +			return ret;
>> +
>> +		ret = ctlr->mem_ops->poll_status(mem, op, mask, match,
>> +						 initial_delay_us, polling_delay_us,
>> +						 timeout_ms);
>> +
>> +		spi_mem_access_end(mem);
>> +	}
>> +
>> +	if (ret == -EOPNOTSUPP) {
>> +		if (!spi_mem_supports_op(mem, op))
>> +			return ret;
>> +
>> +		if (initial_delay_us < 10)
>> +			udelay(initial_delay_us);
>> +		else
>> +			usleep_range((initial_delay_us >> 2) + 1,
>> +				     initial_delay_us);
>> +
>> +		ret = read_poll_timeout(spi_mem_read_status, read_status_ret,
>> +					(read_status_ret || ((status) & mask) == match),
>> +					polling_delay_us, timeout_ms * 1000, false, mem,
>> +					op, &status);
>> +		if (read_status_ret)
>> +			return read_status_ret;
>> +	}
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(spi_mem_poll_status);
>> +
>>  static int spi_mem_probe(struct spi_device *spi)
>>  {
>>  	struct spi_mem_driver *memdrv = to_spi_mem_drv(spi->dev.driver);
>> @@ -763,6 +847,7 @@ static int spi_mem_probe(struct spi_device *spi)
>>  	if (IS_ERR_OR_NULL(mem->name))
>>  		return PTR_ERR_OR_ZERO(mem->name);
>>  
>> +	init_completion(&ctlr->xfer_completion);
> 
> Is this still needed?

No, i forgot to remove it when reworking this v3

Thanks
Patrice

> 
>>  	spi_set_drvdata(spi, mem);
>>  
>>  	return memdrv->probe(mem);
>> diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
>> index 2b65c9edc34e..10375d9ad747 100644
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
>> @@ -274,6 +275,12 @@ struct spi_controller_mem_ops {
>>  			       u64 offs, size_t len, void *buf);
>>  	ssize_t (*dirmap_write)(struct spi_mem_dirmap_desc *desc,
>>  				u64 offs, size_t len, const void *buf);
>> +	int (*poll_status)(struct spi_mem *mem,
>> +			   const struct spi_mem_op *op,
>> +			   u16 mask, u16 match,
>> +			   unsigned long initial_delay_us,
>> +			   unsigned long polling_rate_us,
>> +			   unsigned long timeout_ms);
>>  };
>>  
>>  /**
>> @@ -369,6 +376,13 @@ devm_spi_mem_dirmap_create(struct device *dev, struct spi_mem *mem,
>>  void devm_spi_mem_dirmap_destroy(struct device *dev,
>>  				 struct spi_mem_dirmap_desc *desc);
>>  
>> +int spi_mem_poll_status(struct spi_mem *mem,
>> +			const struct spi_mem_op *op,
>> +			u16 mask, u16 match,
>> +			unsigned long initial_delay_us,
>> +			unsigned long polling_delay_us,
>> +			u16 timeout);
>> +
>>  int spi_mem_driver_register_with_owner(struct spi_mem_driver *drv,
>>  				       struct module *owner);
>>  
> 
