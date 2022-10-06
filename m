Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0395F60D7
	for <lists+linux-spi@lfdr.de>; Thu,  6 Oct 2022 07:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiJFF4x (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 Oct 2022 01:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJFF4w (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 6 Oct 2022 01:56:52 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173F880489
        for <linux-spi@vger.kernel.org>; Wed,  5 Oct 2022 22:56:50 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MjgcZ1sdjzJmxT;
        Thu,  6 Oct 2022 13:54:22 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 6 Oct 2022 13:56:47 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 6 Oct 2022 13:56:47 +0800
Subject: Re: [PATCH -next] spi: introduce new helpers with using modern naming
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     <linux-spi@vger.kernel.org>, <broonie@kernel.org>,
        <lukas@wunner.de>, <yangyingliang@huawei.com>
References: <20220929132041.484110-1-yangyingliang@huawei.com>
 <CAMuHMdX1JMs3uAgJ6CS0sHxD69mp1Atx+YtsYuhy0ZUqsTHRQw@mail.gmail.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <db73bb30-bd64-41c3-1be9-001ae63c383d@huawei.com>
Date:   Thu, 6 Oct 2022 13:56:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdX1JMs3uAgJ6CS0sHxD69mp1Atx+YtsYuhy0ZUqsTHRQw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On 2022/9/30 17:32, Geert Uytterhoeven wrote:
> Hi Yang,
>
> On Thu, Sep 29, 2022 at 3:04 PM Yang Yingliang <yangyingliang@huawei.com> wrote:
>> For using modern names host/target to instead of all the legacy names,
>> I think it takes 3 steps:
>>    - step1: introduce new helpers with modern naming.
>>    - step2: switch to use these new helpers in all drivers.
>>    - step3: remove all legacy helpers and update all legacy names.
>>
>> This patch is for step1, it introduces new helpers with host/target
>> naming for drivers using.
>>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> Thanks for your patch!
>
>> --- a/include/linux/spi/spi.h
>> +++ b/include/linux/spi/spi.h
>> @@ -356,6 +356,7 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
>>    * @max_speed_hz: Highest supported transfer speed
>>    * @flags: other constraints relevant to this driver
>>    * @slave: indicates that this is an SPI slave controller
>> + * @target: indicates that this is an SPI target controller
>>    * @devm_allocated: whether the allocation of this struct is devres-managed
>>    * @max_transfer_size: function that returns the max transfer size for
>>    *     a &spi_device; may be %NULL, so the default %SIZE_MAX will be used.
>> @@ -438,6 +439,7 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
>>    * @mem_caps: controller capabilities for the handling of memory operations.
>>    * @unprepare_message: undo any work done by prepare_message().
>>    * @slave_abort: abort the ongoing transfer request on an SPI slave controller
>> + * @target_abort: abort the ongoing transfer request on an SPI target controller
>>    * @cs_gpiods: Array of GPIO descs to use as chip select lines; one per CS
>>    *     number. Any individual value may be NULL for CS lines that
>>    *     are not GPIOs (driven by the SPI controller itself).
>> @@ -535,6 +537,8 @@ struct spi_controller {
>>
>>          /* Flag indicating this is an SPI slave controller */
>>          bool                    slave;
>> +       /* Flag indicating this is an SPI target controller */
>> +       bool                    target;
> To avoid subtle breakage when accessing these fields directly,
> this should be a union:
>
>      union {
>              bool slave;
>              bool target;
>      };
Yes, we should initialize the 'target' member. I will change it in v2.

Thanks,
Yang
>>          /*
>>           * on some hardware transfer / message size may be constrained
> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
>
> .
