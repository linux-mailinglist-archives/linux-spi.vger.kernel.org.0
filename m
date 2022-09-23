Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE0B5E7D83
	for <lists+linux-spi@lfdr.de>; Fri, 23 Sep 2022 16:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiIWOsb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Sep 2022 10:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbiIWOsZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 23 Sep 2022 10:48:25 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CA414329C
        for <linux-spi@vger.kernel.org>; Fri, 23 Sep 2022 07:48:23 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MYw1Q1RzzzbngY;
        Fri, 23 Sep 2022 22:45:30 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 22:48:21 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 22:48:20 +0800
Subject: Re: [PATCH -next 0/6] spi: Switch to use devm_spi_alloc_master() in
 some drivers
To:     Mark Brown <broonie@kernel.org>, Lukas Wunner <lukas@wunner.de>
CC:     <linux-spi@vger.kernel.org>, <yangyingliang@huawei.com>
References: <20220920134819.2981033-1-yangyingliang@huawei.com>
 <YyoHjY14hSJj85oP@sirena.org.uk>
 <19da3b7e-121b-90be-7631-cdfcf8327140@huawei.com>
 <YysEH6MwNc8naD27@sirena.org.uk> <20220923044258.GA28079@wunner.de>
 <Yy2GhucvJyMwFAKV@sirena.org.uk>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <35027b97-a2a9-98b4-205f-9aaa472b1f41@huawei.com>
Date:   Fri, 23 Sep 2022 22:48:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <Yy2GhucvJyMwFAKV@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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


On 2022/9/23 18:12, Mark Brown wrote:
> On Fri, Sep 23, 2022 at 06:42:58AM +0200, Lukas Wunner wrote:
>> On Wed, Sep 21, 2022 at 01:37:49PM +0100, Mark Brown wrote:
>>> Or just use devm_spi_alloc_controller() directly.
>> There's no such thing.  The driver needs to explicitly allocate a
>> master or slave and that will result in the slave bit being set
>> correctly in struct spi_controller.
>> Yang's v2 series now calls __devm_spi_alloc_controller()
>> but drivers should never call that directly.
> Right, we should probably make the actual function to wrap that though -
> I'd misremembered that that hadn't been created.
How about introduce devm_spi_alloc_controller() like this:

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index f089ee1ead58..67e510c8d15e 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -763,6 +763,8 @@ struct spi_controller 
*__devm_spi_alloc_controller(struct device *dev,
                                                    unsigned int size,
                                                    bool slave);

+#define devm_spi_alloc_controller devm_spi_alloc_master
+
Thanks,
Yang
