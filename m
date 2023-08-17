Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8C677EF75
	for <lists+linux-spi@lfdr.de>; Thu, 17 Aug 2023 05:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347810AbjHQDSz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Aug 2023 23:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347799AbjHQDS2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Aug 2023 23:18:28 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43481724;
        Wed, 16 Aug 2023 20:18:25 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RR9974m7zzNmyx;
        Thu, 17 Aug 2023 11:14:51 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 17 Aug 2023 11:18:23 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 17 Aug 2023 11:18:23 +0800
Subject: Re: [PATCH -next 20/24] spi: sh-msiof: switch to use modern name
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     <linux-spi@vger.kernel.org>, <broonie@kernel.org>,
        <lukas@wunner.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        <yangyingliang@huawei.com>
References: <20230816094013.1275068-1-yangyingliang@huawei.com>
 <20230816094013.1275068-21-yangyingliang@huawei.com>
 <CAMuHMdX9R5SQ_GSRhcfBH+UN0rxYP7NOeyrQSgZ3G6zY=zJnHA@mail.gmail.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <07483186-d503-2423-e881-2c6db6043ad5@huawei.com>
Date:   Thu, 17 Aug 2023 11:18:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdX9R5SQ_GSRhcfBH+UN0rxYP7NOeyrQSgZ3G6zY=zJnHA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi

On 2023/8/16 18:37, Geert Uytterhoeven wrote:
> Hi Yang,
>
> On Wed, Aug 16, 2023 at 11:43 AM Yang Yingliang
> <yangyingliang@huawei.com> wrote:
>> Change legacy name master/slave to modern name host/target.
>>
>> No functional changed.
>>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> Thanks for your patch!
>
>> --- a/drivers/spi/spi-sh-msiof.c
>> +++ b/drivers/spi/spi-sh-msiof.c
>> @@ -79,7 +79,7 @@ struct sh_msiof_spi_priv {
>>   #define SIRFDR 0x60    /* Receive FIFO Data Register */
>>
>>   /* SITMDR1 and SIRMDR1 */
>> -#define SIMDR1_TRMD            BIT(31)         /* Transfer Mode (1 = Master mode) */
>> +#define SIMDR1_TRMD            BIT(31)         /* Transfer Mode (1 = Host mode) */
> Please do not change this register bit definition nor the comment, as
> they match Rev 0.81 of the R-Car V4H Series Hardware User's Manual.

Thanks for your review, I will change them, and send a v2.

>
> Gr{oetje,eeting}s,
>
>                          Geert
>
