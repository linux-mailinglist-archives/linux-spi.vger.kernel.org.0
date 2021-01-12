Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8D32F2DD5
	for <lists+linux-spi@lfdr.de>; Tue, 12 Jan 2021 12:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbhALLYZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Jan 2021 06:24:25 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11095 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbhALLYY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Jan 2021 06:24:24 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DFSpp2Ql6zMHGt;
        Tue, 12 Jan 2021 19:22:26 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.220) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.498.0; Tue, 12 Jan 2021
 19:23:39 +0800
Subject: Re: [PATCH 1/1] spi: cadence-quadspi: Fix a compilation warning for
 64-bit platform
To:     Pratyush Yadav <p.yadav@ti.com>
CC:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>
References: <20210112100637.747-1-thunder.leizhen@huawei.com>
 <20210112100637.747-2-thunder.leizhen@huawei.com>
 <20210112101634.ikmhj4au6eogkhoq@ti.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <6612b888-63aa-9d8f-c663-3b2857b79b70@huawei.com>
Date:   Tue, 12 Jan 2021 19:23:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210112101634.ikmhj4au6eogkhoq@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 2021/1/12 18:16, Pratyush Yadav wrote:
> Hi Zhen,
> 
> On 12/01/21 06:06PM, Zhen Lei wrote:
>> The __typecheck() requires that the two arguments of max() must be of the
>> same type. For the current max(), the type of the first parameter "len" is
>> size_t. But the type of size_t is not fixed, it's "unsigned int" on 32-bit
>> platforms and "unsigned long" on 64-bit platforms. So both the suffix "U"
>> and "UL" are not appropriate for the second constant parameter. Therefore,
>> forcible type conversion is used.
>>
>> Fixes: 8728a81b8f10 ("spi: Fix distinct pointer types warning for ARCH=mips")
>> Fixes: 0920a32cf6f2 ("spi: cadence-quadspi: Wait at least 500 ms for direct reads")
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  drivers/spi/spi-cadence-quadspi.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
>> index 576610ba11184c6..eb40b8d46b56b0c 100644
>> --- a/drivers/spi/spi-cadence-quadspi.c
>> +++ b/drivers/spi/spi-cadence-quadspi.c
>> @@ -1150,7 +1150,7 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
>>
>>  	dma_async_issue_pending(cqspi->rx_chan);
>>  	if (!wait_for_completion_timeout(&cqspi->rx_dma_complete,
>> -					 msecs_to_jiffies(max(len, 500U)))) {
>> +				 msecs_to_jiffies(max_t(size_t, len, 500)))) {
> 
> I sent a patch with this exact fix already [0]. It has made it in Mark's 
> for-next branch.

OK，I don't known it.

> 
> [0] https://lore.kernel.org/linux-spi/20210108181457.30291-1-p.yadav@ti.com/
> 
>>  		dmaengine_terminate_sync(cqspi->rx_chan);
>>  		dev_err(dev, "DMA wait_for_completion_timeout\n");
>>  		ret = -ETIMEDOUT;
>> --
>> 1.8.3
>>
>>
> 

