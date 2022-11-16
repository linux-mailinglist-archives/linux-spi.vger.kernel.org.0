Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E586362BE7C
	for <lists+linux-spi@lfdr.de>; Wed, 16 Nov 2022 13:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiKPMqM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Nov 2022 07:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbiKPMqL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Nov 2022 07:46:11 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A54514013
        for <linux-spi@vger.kernel.org>; Wed, 16 Nov 2022 04:46:10 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NC2l80FFwzJnkW;
        Wed, 16 Nov 2022 20:43:00 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 20:46:08 +0800
Received: from [10.174.179.5] (10.174.179.5) by dggpemm500002.china.huawei.com
 (7.185.36.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 16 Nov
 2022 20:46:08 +0800
Subject: Re: [PATCH] spi: dw-dma: decrease reference count in
 dw_spi_dma_init_mfld()
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     <broonie@kernel.org>, <feng.tang@intel.com>,
        <linus.walleij@stericsson.com>, <linux-spi@vger.kernel.org>,
        <yangyingliang@huawei.com>
References: <20221116093204.46700-1-wangxiongfeng2@huawei.com>
 <20221116111921.a3lnx7wgufukfass@mobilestation>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <dddf25a0-60f0-64d8-5002-2de15fe428e8@huawei.com>
Date:   Wed, 16 Nov 2022 20:46:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20221116111921.a3lnx7wgufukfass@mobilestation>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.5]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Serge,

On 2022/11/16 19:19, Serge Semin wrote:
> Hi Xiongfeng,
> 
> On Wed, Nov 16, 2022 at 05:32:04PM +0800, Xiongfeng Wang wrote:
>> pci_get_device() will increase the reference count for the returned
>> pci_dev. Since 'dma_dev' is only used to filter the channel in
>> dw_spi_dma_chan_filer(). After using it, we need to use pci_dev_put() to
>                          ^               ^            ^
>                          |               |            |
>                       drop the dot and comma          s/use/call
> 
> * Although this could be fixed by Mark on merging the patch in.

Thanks for your reply !  Sorry, I am not so sure about the modification.
Let me make sure it and send another version.
Do you mean change it like below:

  dw_spi_dma_chan_filer(), we need to use pci_dev_put() to

Thanks,
Xiongfeng

> 
>> decrease the reference count. Also add pci_dev_put() for the error case.
>>
>> Fixes: 7063c0d942a1 ("spi/dw_spi: add DMA support")
>> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> 
> Nice catch. Thanks for the patch.
> Acked-by: Serge Semin <fancer.lancer@gmail.com>
> 
> -Sergey
> 
>> ---
>>  drivers/spi/spi-dw-dma.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
>> index 1322b8cce5b7..ababb910b391 100644
>> --- a/drivers/spi/spi-dw-dma.c
>> +++ b/drivers/spi/spi-dw-dma.c
>> @@ -128,12 +128,15 @@ static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
>>  
>>  	dw_spi_dma_sg_burst_init(dws);
>>  
>> +	pci_dev_put(dma_dev);
>> +
>>  	return 0;
>>  
>>  free_rxchan:
>>  	dma_release_channel(dws->rxchan);
>>  	dws->rxchan = NULL;
>>  err_exit:
>> +	pci_dev_put(dma_dev);
>>  	return -EBUSY;
>>  }
>>  
>> -- 
>> 2.20.1
>>
> .
> 
