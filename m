Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC2A5BF62F
	for <lists+linux-spi@lfdr.de>; Wed, 21 Sep 2022 08:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiIUGSS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 21 Sep 2022 02:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiIUGSR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 21 Sep 2022 02:18:17 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2A47FE7E
        for <linux-spi@vger.kernel.org>; Tue, 20 Sep 2022 23:18:15 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MXSlb5GvrzMns7;
        Wed, 21 Sep 2022 14:13:31 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 14:18:13 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 14:18:12 +0800
Subject: Re: [PATCH -next] spi: xtensa-xtfpga: Switch to use
 devm_spi_alloc_master()
To:     Max Filippov <jcmvbkbc@gmail.com>
CC:     <linux-xtensa@linux-xtensa.org>, <linux-spi@vger.kernel.org>,
        <broonie@kernel.org>
References: <20220920114448.2681053-1-yangyingliang@huawei.com>
 <CAMo8BfJ-LE55ELT7SGK6HJU=EyVZ1pYz7bR-66+EH=+6L4sEMw@mail.gmail.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <8d8fb017-3bc4-7503-56da-16876d2bd7dc@huawei.com>
Date:   Wed, 21 Sep 2022 14:18:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAMo8BfJ-LE55ELT7SGK6HJU=EyVZ1pYz7bR-66+EH=+6L4sEMw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On 2022/9/21 11:53, Max Filippov wrote:
> On Tue, Sep 20, 2022 at 4:37 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
>> Switch to use devm_spi_alloc_master() to simpify error path.
> Typo: simplify.
OK, will fix it in v2.
>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   drivers/spi/spi-xtensa-xtfpga.c | 16 +++++-----------
>>   1 file changed, 5 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/spi/spi-xtensa-xtfpga.c b/drivers/spi/spi-xtensa-xtfpga.c
>> index fc2b5eb7d614..2fa7608f94cd 100644
>> --- a/drivers/spi/spi-xtensa-xtfpga.c
>> +++ b/drivers/spi/spi-xtensa-xtfpga.c
>> @@ -83,7 +83,7 @@ static int xtfpga_spi_probe(struct platform_device *pdev)
>>          int ret;
>>          struct spi_master *master;
>>
>> -       master = spi_alloc_master(&pdev->dev, sizeof(struct xtfpga_spi));
>> +       master = devm_spi_alloc_master(&pdev->dev, sizeof(struct xtfpga_spi));
>>          if (!master)
>>                  return -ENOMEM;
>>
>> @@ -97,30 +97,24 @@ static int xtfpga_spi_probe(struct platform_device *pdev)
>>          xspi->bitbang.chipselect = xtfpga_spi_chipselect;
>>          xspi->bitbang.txrx_word[SPI_MODE_0] = xtfpga_spi_txrx_word;
>>          xspi->regs = devm_platform_ioremap_resource(pdev, 0);
>> -       if (IS_ERR(xspi->regs)) {
>> -               ret = PTR_ERR(xspi->regs);
>> -               goto err;
>> -       }
>> +       if (IS_ERR(xspi->regs))
>> +               return PTR_ERR(xspi->regs);
>>
>>          xtfpga_spi_write32(xspi, XTFPGA_SPI_START, 0);
>>          usleep_range(1000, 2000);
>>          if (xtfpga_spi_read32(xspi, XTFPGA_SPI_BUSY)) {
>>                  dev_err(&pdev->dev, "Device stuck in busy state\n");
>> -               ret = -EBUSY;
>> -               goto err;
>> +               return -EBUSY;
>>          }
>>
>>          ret = spi_bitbang_start(&xspi->bitbang);
>>          if (ret < 0) {
>>                  dev_err(&pdev->dev, "spi_bitbang_start failed\n");
>> -               goto err;
>> +               return ret;
>>          }
>>
>>          platform_set_drvdata(pdev, master);
>>          return 0;
>> -err:
>> -       spi_master_put(master);
>> -       return ret;
>>   }
>>
>>   static int xtfpga_spi_remove(struct platform_device *pdev)
> There's a call to spi_master_put in the xtfpga_spi_remove,
> IIUC this call must be dropped too.
It can not be dropped, the controller is get in spi_bitbang_start(), it 
need be put in remove().

Thanks,
Yang
>
