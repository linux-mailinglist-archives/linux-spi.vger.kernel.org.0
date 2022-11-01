Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2170361453D
	for <lists+linux-spi@lfdr.de>; Tue,  1 Nov 2022 08:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiKAHuu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Nov 2022 03:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKAHut (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Nov 2022 03:50:49 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12BF15A30
        for <linux-spi@vger.kernel.org>; Tue,  1 Nov 2022 00:50:48 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N1hsC0VsXzVj14;
        Tue,  1 Nov 2022 15:45:51 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 15:50:47 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 15:50:46 +0800
Subject: Re: [PATCH -next v2] spi: introduce new helpers with using modern
 naming
To:     <linux-spi@vger.kernel.org>, <broonie@kernel.org>
CC:     <lukas@wunner.de>, <geert@linux-m68k.org>,
        <yangyingliang@huawei.com>
References: <20221011092204.950288-1-yangyingliang@huawei.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <231dc6fa-cb03-463b-5045-96798e04d6f0@huawei.com>
Date:   Tue, 1 Nov 2022 15:50:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20221011092204.950288-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi, Mark

On 2022/10/11 17:22, Yang Yingliang wrote:
> For using modern names host/target to instead of all the legacy names,
> I think it takes 3 steps:
>    - step1: introduce new helpers with modern naming.
>    - step2: switch to use these new helpers in all drivers.
>    - step3: remove all legacy helpers and update all legacy names.
>
> This patch is for step1, it introduces new helpers with host/target
> naming for drivers using.
>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
> v1 -> v2:
>    make 'target' member into union to initialize it.
> ---
>   drivers/spi/spi.c       | 11 ++++++++++
>   include/linux/spi/spi.h | 47 +++++++++++++++++++++++++++++++++++++++--
>   2 files changed, 56 insertions(+), 2 deletions(-)
>
Does this patch look good to you or do you have any suggestion?

Thanks,
Yang
