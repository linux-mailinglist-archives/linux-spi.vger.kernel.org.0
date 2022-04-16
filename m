Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF5650366D
	for <lists+linux-spi@lfdr.de>; Sat, 16 Apr 2022 14:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbiDPL5w (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 16 Apr 2022 07:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiDPL5w (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 16 Apr 2022 07:57:52 -0400
Received: from out28-169.mail.aliyun.com (out28-169.mail.aliyun.com [115.124.28.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D78433A26;
        Sat, 16 Apr 2022 04:55:19 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0743753|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0592862-0.00168624-0.939028;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047208;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.NRpv9hL_1650110114;
Received: from 192.168.30.128(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.NRpv9hL_1650110114)
          by smtp.aliyun-inc.com(33.40.31.76);
          Sat, 16 Apr 2022 19:55:16 +0800
Subject: Re: [PATCH 1/3] SPI: Ingenic: Add support for use GPIO as chip select
 line.
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     broonie@kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        contact@artur-rojek.eu, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com, reimu@sudomaker.com
References: <1650032528-118220-1-git-send-email-zhouyanjie@wanyeetech.com>
 <1650032528-118220-2-git-send-email-zhouyanjie@wanyeetech.com>
 <61ZDAR.SD20HFTWMIBH3@crapouillou.net>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <d7926a1d-c5e3-6519-6a52-1bd3ca3cf773@wanyeetech.com>
Date:   Sat, 16 Apr 2022 19:55:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <61ZDAR.SD20HFTWMIBH3@crapouillou.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Paul,

On 2022/4/15 下午11:00, Paul Cercueil wrote:
> Hi Zhou,
>
> Le ven., avril 15 2022 at 22:22:06 +0800, 周琰杰 (Zhou Yanjie) 
> <zhouyanjie@wanyeetech.com> a écrit :
>> Add support for using GPIOs as chip select lines on Ingenic SoCs.
>>
>> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
>> ---
>>  drivers/spi/spi-ingenic.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/spi/spi-ingenic.c b/drivers/spi/spi-ingenic.c
>> index 03077a7..672e4ed 100644
>> --- a/drivers/spi/spi-ingenic.c
>> +++ b/drivers/spi/spi-ingenic.c
>> @@ -380,7 +380,7 @@ static int spi_ingenic_probe(struct 
>> platform_device *pdev)
>>      struct spi_controller *ctlr;
>>      struct ingenic_spi *priv;
>>      void __iomem *base;
>> -    int ret;
>> +    int num_cs, ret;
>>
>>      pdata = of_device_get_match_data(dev);
>>      if (!pdata) {
>> @@ -416,6 +416,11 @@ static int spi_ingenic_probe(struct 
>> platform_device *pdev)
>>      if (IS_ERR(priv->flen_field))
>>          return PTR_ERR(priv->flen_field);
>>
>> +    if (of_property_read_u32(dev->of_node, "num-cs", &num_cs)) {
>> +        dev_warn(dev, "Number of chip select lines not specified.\n");
>> +        num_cs = 2;
>> +    }
>> +
>>      platform_set_drvdata(pdev, ctlr);
>>
>>      ctlr->prepare_transfer_hardware = spi_ingenic_prepare_hardware;
>> @@ -429,7 +434,9 @@ static int spi_ingenic_probe(struct 
>> platform_device *pdev)
>>      ctlr->bits_per_word_mask = pdata->bits_per_word_mask;
>>      ctlr->min_speed_hz = 7200;
>>      ctlr->max_speed_hz = 54000000;
>> -    ctlr->num_chipselect = 2;
>> +    ctlr->use_gpio_descriptors = true;
>
> I wonder if this should be set conditionally instead. Maybe set it to 
> "true" if the "num-cs" property exists?
>

I'm not too sure, but it seems some other drivers like "spi-sun6i.c", 
"spi-stm32.c", "spi-s3c64xx.c", "spi-pic32.c", etc. set it unconditionally.


> The rest looks good to me.
>
> Cheers,
> -Paul
>
>> +    ctlr->max_native_cs = 2;
>> +    ctlr->num_chipselect = num_cs;
>>      ctlr->dev.of_node = pdev->dev.of_node;
>>
>>      if (spi_ingenic_request_dma(ctlr, dev))
>> -- 
>> 2.7.4
>>
>
