Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92575253E8B
	for <lists+linux-spi@lfdr.de>; Thu, 27 Aug 2020 09:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgH0HEv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Aug 2020 03:04:51 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34464 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgH0HEu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Aug 2020 03:04:50 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07R74WgK042393;
        Thu, 27 Aug 2020 02:04:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598511872;
        bh=260MNsf+sBTxKFsAR396C3Ut4B0Gn9sQVV96H1/dwCY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=NLCjbjog8okMnENPNR3UYZPVyOn5CS5JvV//y37cuZrWRaCVJKxi/ZCMebULpbl4i
         rqTnakoUmAbTcKUvYMHPvHN9ImhsxO+H6L9x9kldAsbAwS/IFfHm4Dy90ZOH+l5dFt
         uiOD57c9Q/wMO3k2qnd58psQYZ4NABqC8BuCRvSM=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07R74WQH004470;
        Thu, 27 Aug 2020 02:04:32 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 27
 Aug 2020 02:04:31 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 27 Aug 2020 02:04:31 -0500
Received: from [10.250.235.166] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07R74Riu008885;
        Thu, 27 Aug 2020 02:04:28 -0500
Subject: Re: [RESEND PATCH v3 5/8] mtd: spi-nor: cadence-quadspi: Handle probe
 deferral while requesting DMA channel
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        "Jin, Le (RC-CN DF FA R&D)" <le.jin@siemens.com>
CC:     Boris Brezillon <bbrezillon@kernel.org>,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <simon.k.r.goldschmidt@gmail.com>,
        <dinguyen@kernel.org>, <marex@denx.de>
References: <20200601070444.16923-1-vigneshr@ti.com>
 <20200601070444.16923-6-vigneshr@ti.com>
 <6c8d9bff-3a67-0e6c-d4d1-36b7ed5007b9@web.de>
 <8cebd31a-2366-4584-b1d1-faa30c18ed6a@ti.com>
 <dbba9f0c-4621-2d58-8fb8-4cbe788558f9@siemens.com>
 <eff1b49e-e392-8887-b3a0-3caedc5b81cc@siemens.com>
 <8995f5c5-bd6a-c0e5-1e4f-1744aedd2bcd@siemens.com>
 <5e215c3c-5603-a796-9dea-13b7c2840ed0@ti.com>
 <c090b23a-488f-6eb3-206b-a7678b70a4e2@siemens.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <ed61022e-4141-9ae3-d24b-e60e42ae58e3@ti.com>
Date:   Thu, 27 Aug 2020 12:34:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c090b23a-488f-6eb3-206b-a7678b70a4e2@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 8/26/20 7:01 PM, Jan Kiszka wrote:
> On 26.08.20 14:18, Vignesh Raghavendra wrote:
>> On 8/26/20 3:42 PM, Jan Kiszka wrote:
>>> On 24.08.20 19:20, Jan Kiszka wrote:
>>>> On 24.08.20 14:49, Jan Kiszka wrote:
>>>>> On 24.08.20 13:45, Vignesh Raghavendra wrote:
>>>>>>
[...]
>> Also, there seems to be DMA mapping related issue, that was always present in 
>> older driver as well. Could you see if diff [2] fixes the issue?
>>
>> [2] Use DMA device for mapping:
>>
>> ---><8---
>>
>>
>> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
>> index b9739ae919340..a546aa4598758 100644
>> --- a/drivers/spi/spi-cadence-quadspi.c
>> +++ b/drivers/spi/spi-cadence-quadspi.c
>> @@ -901,6 +901,7 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
>>  {
>>         struct cqspi_st *cqspi = f_pdata->cqspi;
>>         struct device *dev = &cqspi->pdev->dev;
>> +       struct device *ddev = cqspi->rx_chan->device->dev;
>>         enum dma_ctrl_flags flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
>>         dma_addr_t dma_src = (dma_addr_t)cqspi->mmap_phys_base + from;
>>         int ret = 0;
>> @@ -917,8 +918,8 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
>>                 return 0;
>>         }
>>  
>> -       dma_dst = dma_map_single(dev, buf, len, DMA_FROM_DEVICE);
>> -       if (dma_mapping_error(dev, dma_dst)) {
>> +       dma_dst = dma_map_single(ddev, buf, len, DMA_FROM_DEVICE);
>> +       if (dma_mapping_error(ddev, dma_dst)) {
>>                 dev_err(dev, "dma mapping failed\n");
>>                 return -ENOMEM;
>>         }
>> @@ -952,7 +953,7 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
>>         }
>>  
>>  err_unmap:
>> -       dma_unmap_single(dev, dma_dst, len, DMA_FROM_DEVICE);
>> +       dma_unmap_single(ddev, dma_dst, len, DMA_FROM_DEVICE);
>>  
>>         return ret;
>>  }
>>
> 
> That seems to help! Wasn't able to reproduce the issue with this applied
> so far.
> 

OK, great... I will post this patch soon once I finish a bit more
testing... Thanks!


Regards
Vignesh
