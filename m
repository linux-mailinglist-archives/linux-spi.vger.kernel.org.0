Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378AB5BFEDB
	for <lists+linux-spi@lfdr.de>; Wed, 21 Sep 2022 15:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiIUNTm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 21 Sep 2022 09:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiIUNTl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 21 Sep 2022 09:19:41 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F5E17A9F
        for <linux-spi@vger.kernel.org>; Wed, 21 Sep 2022 06:19:38 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MXf6j00cDzmWWB;
        Wed, 21 Sep 2022 21:15:40 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 21:19:36 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 21:19:36 +0800
Subject: Re: [PATCH -next 0/6] spi: Switch to use devm_spi_alloc_master() in
 some drivers
To:     Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>
References: <20220920134819.2981033-1-yangyingliang@huawei.com>
 <YyoHjY14hSJj85oP@sirena.org.uk>
 <19da3b7e-121b-90be-7631-cdfcf8327140@huawei.com>
 <YysEH6MwNc8naD27@sirena.org.uk>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <1288dcc5-0b48-eec5-5d2a-879d1cc14d02@huawei.com>
Date:   Wed, 21 Sep 2022 21:19:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <YysEH6MwNc8naD27@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 2022/9/21 20:37, Mark Brown wrote:
> On Wed, Sep 21, 2022 at 10:02:25AM +0800, Yang Yingliang wrote:
>> On 2022/9/21 2:33, Mark Brown wrote:
>>> If we're switching please update to the modern naming and use
>>> "controller" rather than the old name.
>> Do you mean to use spi_controller instead of spi_master? Something like
>> this:
>> 'struct spi_controller * ctlr = devm_spi_alloc_master();'
> Or just use devm_spi_alloc_controller() directly.
Does __devm_spi_alloc_controller() need be changed to 
devm_spi_alloc_controller(), then use
it, or just use __devm_spi_alloc_controller() directly.

Thanks,
Yang
>
>> Dose spi_master_get_devdata()  need be changed to
>> spi_controller_get_devdata() ?
> Ideally.
