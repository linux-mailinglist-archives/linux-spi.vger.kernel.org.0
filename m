Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5C176658C
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jul 2023 09:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbjG1Hmz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Jul 2023 03:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbjG1Hmy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Jul 2023 03:42:54 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D8812D
        for <linux-spi@vger.kernel.org>; Fri, 28 Jul 2023 00:42:53 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RC02W3h6cz1GDFp;
        Fri, 28 Jul 2023 15:41:55 +0800 (CST)
Received: from [10.67.108.26] (10.67.108.26) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 15:42:50 +0800
Message-ID: <7ae37f46-2a4a-afe8-846c-df95a0d12be8@huawei.com>
Date:   Fri, 28 Jul 2023 15:42:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH -next] spi: microchip-core: Clean up redundant
 dev_err_probe()
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
CC:     <conor.dooley@microchip.com>, <daire.mcnamara@microchip.com>,
        <broonie@kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-spi@vger.kernel.org>
References: <20230727130049.2810959-1-chenjiahao16@huawei.com>
 <20230727-curvature-register-6eb0a2c60a8b@spud>
From:   "chenjiahao (C)" <chenjiahao16@huawei.com>
In-Reply-To: <20230727-curvature-register-6eb0a2c60a8b@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.26]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 2023/7/27 21:34, Conor Dooley wrote:
> On Thu, Jul 27, 2023 at 09:00:49PM +0800, Chen Jiahao wrote:
>> Refering to platform_get_irq()'s definition, the return value has
>> already been checked if ret < 0, and printed via dev_err_probe().
>> Calling dev_err_probe() one more time outside platform_get_irq()
>> is obviously redundant.
>>
>> Furthermore, platform_get_irq() will never return irq equals 0,
>> removing spi->irq == 0 checking to clean it up.
>>
>> Signed-off-by: Chen Jiahao <chenjiahao16@huawei.com>
>> ---
>>   drivers/spi/spi-microchip-core.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/spi/spi-microchip-core.c b/drivers/spi/spi-microchip-core.c
>> index b59e8a0c5b97..ac3b7b163db4 100644
>> --- a/drivers/spi/spi-microchip-core.c
>> +++ b/drivers/spi/spi-microchip-core.c
>> @@ -530,10 +530,8 @@ static int mchp_corespi_probe(struct platform_device *pdev)
>>   		return PTR_ERR(spi->regs);
>>   
>>   	spi->irq = platform_get_irq(pdev, 0);
>> -	if (spi->irq <= 0)
>> -		return dev_err_probe(&pdev->dev, -ENXIO,
>> -				     "invalid IRQ %d for SPI controller\n",
>> -				     spi->irq);
>> +	if (spi->irq < 0)
>> +		return -ENXIO;
> platform_get_irq() returns an ERRNO that can now be propagated since
> the special case for 0 no longer requires handling, no?

Sure, you are right. Here we should directly return the ERRNO passed
from platform_get_irq(), since platform_get_irq() has performed all
error checking inside.

Thanks for reminding.

Jiahao

>
>>   
>>   	ret = devm_request_irq(&pdev->dev, spi->irq, mchp_corespi_interrupt,
>>   			       IRQF_SHARED, dev_name(&pdev->dev), master);
>> -- 
>> 2.34.1
>>
