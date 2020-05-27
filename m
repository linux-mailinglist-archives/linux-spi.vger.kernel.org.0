Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD251E3CB9
	for <lists+linux-spi@lfdr.de>; Wed, 27 May 2020 10:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388183AbgE0Iyp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 May 2020 04:54:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5348 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388019AbgE0Iyo (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 27 May 2020 04:54:44 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9F230FA901AC881C860A;
        Wed, 27 May 2020 16:54:42 +0800 (CST)
Received: from [10.65.58.147] (10.65.58.147) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Wed, 27 May 2020
 16:54:35 +0800
Subject: Re: [RFC PATCH 3/3] spi: hisi-sfc-v3xx: Add prepare/unprepare methods
 to avoid race condition
To:     Boris Brezillon <boris.brezillon@collabora.com>
References: <1590060231-23242-1-git-send-email-yangyicong@hisilicon.com>
 <1590060231-23242-4-git-send-email-yangyicong@hisilicon.com>
 <20200526114348.6295df6b@collabora.com>
CC:     <broonie@kernel.org>, <tudor.ambarus@microchip.com>,
        <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <richard@nod.at>, <john.garry@huawei.com>, <vigneshr@ti.com>,
        <miquel.raynal@bootlin.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <5a3cd626-fb5c-d87c-9cfa-3992caad3ebe@hisilicon.com>
Date:   Wed, 27 May 2020 16:55:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200526114348.6295df6b@collabora.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.58.147]
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Boris,


On 2020/5/26 17:43, Boris Brezillon wrote:
> On Thu, 21 May 2020 19:23:51 +0800
> Yicong Yang <yangyicong@hisilicon.com> wrote:
>
>> The controller can be shared with the firmware, which may cause race
>> problems. As most read/write/erase/lock/unlock of spi-nor flash are
>> composed of a set of operations, while the firmware may use the controller
>> and start its own operation in the middle of the process started by the
>> kernel driver, which may lead to the kernel driver's function broken.
>>
>> Bit[20] in HISI_SFC_V3XX_CMD_CFG register plays a role of a lock, to
>> protect the controller from firmware access, which means the firmware
>> cannot reach the controller if the driver set the bit. Add prepare/
>> unprepare methods for the controller, we'll hold the lock in prepare
>> method and release it in unprepare method, which will solve the race
>> issue.
> Okay, so it looks like what we really need is a way to pass sequences
> (multiple operations) that are expected to be issued without
> interruptions. I'd prefer extending the spi_mem interface to allow that:
>
> int spi_mem_exec_sequence(struct spi_mem *spimem,
> 			  unsigned int num_ops,
> 		  	  const struct spi_mem_op *ops);
>
> struct spi_controller_mem_ops {
> 	...
> 	int (*exec_sequence)(struct spi_mem *mem,
> 			     unsigned int num_ops,
> 			     const struct spi_mem_op *op);
> 	...
> };

The prepare/unprepare hooks is just like what spi_nor_controller_ops provides.
Alternatively we can use the interface you suggested, and it'll require
upper layer(spi-nor framework, etc) to pack the operations before call
spi_mem_exec_sequence().


>
> The prepare/unprepare hooks are a bit too vague. Alternatively, we
> could add functions to grab/release the controller lock, but I'm not
> sure that's what we want since some controllers might be able to address
> several devices in parallel, and locking the whole controller at the
> spi-nor level would prevent that.

I suppose the method is optional and device may choose to use it or not
following their own design. And the implementation is rather controller
specific, they may choose to lock the whole controller or only the desired
device to operate. 


>
> BTW, I don't know all the details about this lock or what this FW is
> exactly (where it's running, what's his priority, what kind of
> synchronization exists between Linux and the FW, ...), but I'm worried
> about potential deadlocks here.

For SFC controller, both firmware and the kernel driver will require the
lock before a sequence of operations, and single operations like register
access for spi-nor flash is implemented atomically. Once the lock is held
by firmware/driver, then the controller cannot perform the operations sent
by the other one unless the lock is released.

Thanks,
Yicong


>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>  drivers/spi/spi-hisi-sfc-v3xx.c | 41 ++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 40 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/spi/spi-hisi-sfc-v3xx.c b/drivers/spi/spi-hisi-sfc-v3xx.c
>> index e3b5725..13c161c 100644
>> --- a/drivers/spi/spi-hisi-sfc-v3xx.c
>> +++ b/drivers/spi/spi-hisi-sfc-v3xx.c
>> @@ -18,6 +18,7 @@
>>  #define HISI_SFC_V3XX_VERSION (0x1f8)
>>  
>>  #define HISI_SFC_V3XX_CMD_CFG (0x300)
>> +#define HISI_SFC_V3XX_CMD_CFG_LOCK BIT(20)
>>  #define HISI_SFC_V3XX_CMD_CFG_DUAL_IN_DUAL_OUT (1 << 17)
>>  #define HISI_SFC_V3XX_CMD_CFG_DUAL_IO (2 << 17)
>>  #define HISI_SFC_V3XX_CMD_CFG_FULL_DIO (3 << 17)
>> @@ -41,6 +42,34 @@ struct hisi_sfc_v3xx_host {
>>  	int max_cmd_dword;
>>  };
>>  
>> +int hisi_sfc_v3xx_op_prepare(struct spi_mem *mem)
>> +{
>> +	struct spi_device *spi = mem->spi;
>> +	struct hisi_sfc_v3xx_host *host;
>> +	u32 reg = HISI_SFC_V3XX_CMD_CFG_LOCK;
>> +
>> +	host = spi_controller_get_devdata(spi->master);
>> +
>> +	writel(reg, host->regbase + HISI_SFC_V3XX_CMD_CFG);
>> +
>> +	reg = readl(host->regbase + HISI_SFC_V3XX_CMD_CFG);
>> +	if (!(reg & HISI_SFC_V3XX_CMD_CFG_LOCK))
>> +		return -EIO;
>> +
>> +	return 0;
>> +}
>> +
>> +void hisi_sfc_v3xx_op_unprepare(struct spi_mem *mem)
>> +{
>> +	struct spi_device *spi = mem->spi;
>> +	struct hisi_sfc_v3xx_host *host;
>> +
>> +	host = spi_controller_get_devdata(spi->master);
>> +
>> +	/* Release the lock and clear the command register. */
>> +	writel(0, host->regbase + HISI_SFC_V3XX_CMD_CFG);
>> +}
>> +
>>  #define HISI_SFC_V3XX_WAIT_TIMEOUT_US		1000000
>>  #define HISI_SFC_V3XX_WAIT_POLL_INTERVAL_US	10
>>  
>> @@ -163,7 +192,15 @@ static int hisi_sfc_v3xx_generic_exec_op(struct hisi_sfc_v3xx_host *host,
>>  					 u8 chip_select)
>>  {
>>  	int ret, len = op->data.nbytes;
>> -	u32 config = 0;
>> +	u32 config;
>> +
>> +	/*
>> +	 * The lock bit is in the command register. Clear the command
>> +	 * field with lock bit held if it has been set in
>> +	 * .prepare().
>> +	 */
>> +	config = readl(host->regbase + HISI_SFC_V3XX_CMD_CFG);
>> +	config &= HISI_SFC_V3XX_CMD_CFG_LOCK;
>>  
>>  	if (op->addr.nbytes)
>>  		config |= HISI_SFC_V3XX_CMD_CFG_ADDR_EN_MSK;
>> @@ -248,6 +285,8 @@ static int hisi_sfc_v3xx_exec_op(struct spi_mem *mem,
>>  
>>  static const struct spi_controller_mem_ops hisi_sfc_v3xx_mem_ops = {
>>  	.adjust_op_size = hisi_sfc_v3xx_adjust_op_size,
>> +	.prepare	= hisi_sfc_v3xx_op_prepare,
>> +	.unprepare	= hisi_sfc_v3xx_op_unprepare,
>>  	.exec_op = hisi_sfc_v3xx_exec_op,
>>  };
>>  
> .
>

