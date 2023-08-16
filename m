Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85BF77DD48
	for <lists+linux-spi@lfdr.de>; Wed, 16 Aug 2023 11:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243326AbjHPJ3g (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Aug 2023 05:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243309AbjHPJ3K (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Aug 2023 05:29:10 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677BE26A1
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 02:29:08 -0700 (PDT)
Received: from dggpemm500019.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RQjRL1Kh4zNmhT;
        Wed, 16 Aug 2023 17:25:34 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500019.china.huawei.com (7.185.36.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 16 Aug 2023 17:29:05 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 16 Aug 2023 17:29:05 +0800
Subject: Re: [PATCH -next v2 19/21] spi: dw: switch to use modern name
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        <linux-spi@vger.kernel.org>, <broonie@kernel.org>,
        <lukas@wunner.de>, <yangyingliang@huawei.com>
References: <20230807140717.3484180-1-yangyingliang@huawei.com>
 <20230807140717.3484180-20-yangyingliang@huawei.com>
 <CAMuHMdU7Q1Nps0b2543wx5BT_X2dU7HBwFm6YKEs0g6bmyaYww@mail.gmail.com>
 <a604b778-5dab-abaf-4c81-e10f7c23374c@huawei.com>
 <rjwaprnnlkpkohzdq5iapcmvx4uayc4tvdr2nny3s5olhphqvs@iusqjo6na75w>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <770c965d-a08c-760a-f315-f546254053ec@huawei.com>
Date:   Wed, 16 Aug 2023 17:29:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <rjwaprnnlkpkohzdq5iapcmvx4uayc4tvdr2nny3s5olhphqvs@iusqjo6na75w>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 2023/8/16 17:24, Serge Semin wrote:
> Hi Yang
>
> On Wed, Aug 16, 2023 at 11:45:26AM +0800, Yang Yingliang wrote:
>> Hi Serge,
>>
>> On 2023/8/15 19:36, Geert Uytterhoeven wrote:
>>> Hi Yang,
>>>
>>> On Mon, Aug 7, 2023 at 4:10 PM Yang Yingliang <yangyingliang@huawei.com> wrote:
>>>> Change legacy name master to modern name host or controller.
>>>>
>>>> No functional changed.
>>>>
>>>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>>> Thanks for your patch, which is now commit eefc6c5c2451126c ("spi:
>>> dw: switch to use modern name") in spi/for-next.
>>>
>>>> --- a/drivers/spi/spi-dw-mmio.c
>>>> +++ b/drivers/spi/spi-dw-mmio.c
>>>> @@ -68,7 +68,7 @@ struct dw_spi_mscc {
>>>>                   ((((val) << 1) | BIT(0)) << ELBA_SPICS_OFFSET(cs))
>>>>
>>>>    /*
>>>> - * The Designware SPI controller (referred to as master in the documentation)
>>>> + * The Designware SPI controller (referred to as host in the documentation)
>>>>     * automatically deasserts chip select when the tx fifo is empty. The chip
>>>>     * selects then needs to be either driven as GPIOs or, for the first 4 using
>>>>     * the SPI boot controller registers. the final chip select is an OR gate
>>> Have you verified that Synopsys did update the documentation for the
>>> Designware SPI controller?  If not, I think it's prudent to keep the
>>> old name.
>> I'm trying to rename the legacy name(master/slave) to modern
>> name(host/target) used in SPI drivers,
>> is it ok to change this comment master to host ?
> The latest Synopsys DesignWare HW databook I posses is of DW APB SSI
> 4.03a IP-core dated by 12.2020. It still uses the master/slave
> wording. The same words can be found in the modern DW AMBA
> Interconnect datasheets:
> https://www.synopsys.com/dw/doc.php/ds/i/dw_amba_solutions.pdf
> (fill in the form with your corporate personal data and you'll be able
> to read the doc)
> I doubt Synopsys has been in anyway concerned about the renaming.  So
> the in-situ comment Geert correctly noted should be left as is: using
> the "master" word in this context.
OK. I will send a patch change it back.

Thanks,
Yang
>
> -Serge(y)
>
>> Thanks,
>> Yang
>>>> @@ -142,14 +142,14 @@ static int dw_spi_mscc_jaguar2_init(struct platform_device *pdev,
>>>>    }
>>>>
>>>>    /*
>>>> - * The Designware SPI controller (referred to as master in the
>>>> + * The Designware SPI controller (referred to as host in the
>>> Likewise.
>>>
>>>>     * documentation) automatically deasserts chip select when the tx fifo
>>>>     * is empty. The chip selects then needs to be driven by a CS override
>>>>     * register. enable is an active low signal.
>>>>     */
>>>>    static void dw_spi_sparx5_set_cs(struct spi_device *spi, bool enable)
>>>>    {
>>> Gr{oetje,eeting}s,
>>>
>>>                           Geert
>>>
>>> --
>>> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>>>
>>> In personal conversations with technical people, I call myself a hacker. But
>>> when I'm talking to journalists I just say "programmer" or something like that.
>>>                                   -- Linus Torvalds
>>>
>>> .
> .
