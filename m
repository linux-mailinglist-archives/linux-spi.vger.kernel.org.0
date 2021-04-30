Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE79436FBFB
	for <lists+linux-spi@lfdr.de>; Fri, 30 Apr 2021 16:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhD3OR6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 30 Apr 2021 10:17:58 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:49987 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229707AbhD3OR5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 30 Apr 2021 10:17:57 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13UECb57024111;
        Fri, 30 Apr 2021 16:16:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=QAuQWsXL4argYFY9yUQByCWSho5tktvwT0Nzfzz7Aps=;
 b=xrcUWPXUPAdkSR/TDFoG08aiFRGU0V3z/lzu3qOwMUWfnFNYC/x0lxM8Q25cG4wcU+yA
 7z5e3O/yDzjnVuFrfPG4bUFZPfERzqqefWwzRrCE3iYwpvacktC8X8kt9egnG8O0zYYv
 2zaW3I6oJRb+U27twnmQipGQFNSKCn+Eb/yD/IP3978LLG2HMlX+3g5s6s8aWdSVNBGc
 ja8YgGDLV64xVrAKeUfuDiJJoWO1lTUEi9UREWeHOcRXoNJoZoNitfpWBDTKE8/iXdKx
 K+dl0J9zCV9pGB6q6aPpNxdosj8vLceWuWg6i6RzbXlZmN8Pd6XV1wnQs3vCLel2iOcn 3A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 387wnpy0ne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Apr 2021 16:16:54 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D515D10002A;
        Fri, 30 Apr 2021 16:16:52 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B1FFD241842;
        Fri, 30 Apr 2021 16:16:52 +0200 (CEST)
Received: from lmecxl0573.lme.st.com (10.75.127.48) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 30 Apr
 2021 16:16:51 +0200
Subject: Re: [PATCH 1/3] spi: spi-mem: add automatic poll status functions
To:     Pratyush Yadav <p.yadav@ti.com>
CC:     Mark Brown <broonie@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        <linux-mtd@lists.infradead.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>
References: <20210426143934.25275-1-patrice.chotard@foss.st.com>
 <20210426143934.25275-2-patrice.chotard@foss.st.com>
 <20210426162610.erpt5ubeddx7paeq@ti.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
Message-ID: <0ccafbbf-194d-d523-34b0-a5c7c9bc95c1@foss.st.com>
Date:   Fri, 30 Apr 2021 16:16:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210426162610.erpt5ubeddx7paeq@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-30_08:2021-04-30,2021-04-30 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Pratyush

On 4/26/21 6:26 PM, Pratyush Yadav wrote:
> Hi,
> 
> On 26/04/21 04:39PM, patrice.chotard@foss.st.com wrote:
>> From: Christophe Kerello <christophe.kerello@foss.st.com>
>>
>> With STM32 QSPI, it is possible to poll the status register of the device.
>> This could be done to offload the CPU during an operation (erase or
>> program a SPI NAND for example).
>>
>> spi_mem_poll_status API has been added to handle this feature.
>>
>> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>  drivers/spi/spi-mem.c       | 34 ++++++++++++++++++++++++++++++++++
>>  include/linux/spi/spi-mem.h |  8 ++++++++
>>  2 files changed, 42 insertions(+)
>>
>> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
>> index 1513553e4080..43dce4b0efa4 100644
>> --- a/drivers/spi/spi-mem.c
>> +++ b/drivers/spi/spi-mem.c
>> @@ -743,6 +743,40 @@ static inline struct spi_mem_driver *to_spi_mem_drv(struct device_driver *drv)
>>  	return container_of(drv, struct spi_mem_driver, spidrv.driver);
>>  }
>>  
>> +/**
>> + * spi_mem_poll_status() - Poll memory device status
>> + * @mem: SPI memory device
>> + * @op: the memory operation to execute
>> + * @mask: status bitmask to ckeck
>> + * @match: status expected value
> 
> Technically, (status & mask) expected value. Dunno if that is obvious 
> enough to not spell out explicitly.

Yes, match = (status & mask)
I will update the comment accordingly.

> 
>> + * @timeout: timeout
>> + *
>> + * This function send a polling status request to the controller driver
>> + *
>> + * Return: 0 in case of success, -ETIMEDOUT in case of error,
>> + *         -EOPNOTSUPP if not supported.
>> + */
>> +int spi_mem_poll_status(struct spi_mem *mem,
>> +			const struct spi_mem_op *op,
>> +			u8 mask, u8 match, u16 timeout)
>> +{
>> +	struct spi_controller *ctlr = mem->spi->controller;
>> +	int ret = -EOPNOTSUPP;
>> +
>> +	if (ctlr->mem_ops && ctlr->mem_ops->poll_status) {
> 
> You should call spi_mem_supports_op() before sending any ops to the 
> controller. Invalid/unsupported ops can cause unexpected behavior.

Ok i will add it.

Thanks
Patrice

> 
>> +		ret = spi_mem_access_start(mem);
>> +		if (ret)
>> +			return ret;
>> +
>> +		ret = ctlr->mem_ops->poll_status(mem, op, mask, match, timeout);
> 
> I wonder if it is better to let spi-mem core take care of the timeout 
> part. On one hand it reduces code duplication on the driver side a 
> little bit. Plus it makes sure drivers don't mess anything up with bad 
> (or no) handling of the timeout. But on the other hand the interface 
> becomes a bit awkward since you'd have to pass a struct completion 
> around, and it isn't something particularly hard to get right either. 
> What do you think?
> 
>> +
>> +		spi_mem_access_end(mem);
>> +	}
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(spi_mem_poll_status);
>> +
>>  static int spi_mem_probe(struct spi_device *spi)
>>  {
>>  	struct spi_mem_driver *memdrv = to_spi_mem_drv(spi->dev.driver);
>> diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
>> index 2b65c9edc34e..5f78917c0f68 100644
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
>> +			   u8 mask, u8 match, u16 timeout);
>>  };
>>  
>>  /**
>> @@ -369,6 +373,10 @@ devm_spi_mem_dirmap_create(struct device *dev, struct spi_mem *mem,
>>  void devm_spi_mem_dirmap_destroy(struct device *dev,
>>  				 struct spi_mem_dirmap_desc *desc);
>>  
>> +int spi_mem_poll_status(struct spi_mem *mem,
>> +			const struct spi_mem_op *op,
>> +			u8 mask, u8 match, u16 timeout);
>> +
>>  int spi_mem_driver_register_with_owner(struct spi_mem_driver *drv,
>>  				       struct module *owner);
> 
