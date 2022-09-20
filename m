Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F67C5BE6AE
	for <lists+linux-spi@lfdr.de>; Tue, 20 Sep 2022 15:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiITNFr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Sep 2022 09:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbiITNFk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Sep 2022 09:05:40 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE7867C8D
        for <linux-spi@vger.kernel.org>; Tue, 20 Sep 2022 06:05:38 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MX1rp3PJlzlWGG;
        Tue, 20 Sep 2022 21:01:30 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 21:05:36 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 21:05:36 +0800
Subject: Re: [PATCH -next] spi: s3c24xx: Switch to use devm_spi_alloc_master()
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>
References: <20220920114901.2683267-1-yangyingliang@huawei.com>
 <c3aaa5f5-327f-569c-4032-fe72e5dc5fbd@linaro.org>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <c5802076-7fca-e470-c10d-21b3d5acdce4@huawei.com>
Date:   Tue, 20 Sep 2022 21:05:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <c3aaa5f5-327f-569c-4032-fe72e5dc5fbd@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

On 2022/9/20 20:57, Krzysztof Kozlowski wrote:
> On 20/09/2022 13:49, Yang Yingliang wrote:
>> Switch to use devm_spi_alloc_master() to simpify error path.
>>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> One more comment - the patch was not properly addressed.
>
> Use scripts/get_maintainers.pl to CC all maintainers and relevant
> mailing lists.
Do I need to resend it with CC all maintainers ?

Thanks,
Yang
>
>
> Best regards,
> Krzysztof
> .
