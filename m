Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043315BF332
	for <lists+linux-spi@lfdr.de>; Wed, 21 Sep 2022 04:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiIUCCb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Sep 2022 22:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiIUCCa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Sep 2022 22:02:30 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD8478BE2
        for <linux-spi@vger.kernel.org>; Tue, 20 Sep 2022 19:02:28 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MXM575Vs6zlW3F;
        Wed, 21 Sep 2022 09:58:19 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 10:02:26 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 10:02:26 +0800
Subject: Re: [PATCH -next 0/6] spi: Switch to use devm_spi_alloc_master() in
 some drivers
To:     Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>
References: <20220920134819.2981033-1-yangyingliang@huawei.com>
 <YyoHjY14hSJj85oP@sirena.org.uk>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <19da3b7e-121b-90be-7631-cdfcf8327140@huawei.com>
Date:   Wed, 21 Sep 2022 10:02:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <YyoHjY14hSJj85oP@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Hi Mark,

On 2022/9/21 2:33, Mark Brown wrote:
> On Tue, Sep 20, 2022 at 09:48:13PM +0800, Yang Yingliang wrote:
>> This patchset is trying to replace spi_alloc_master() with
>> devm_spi_alloc_master() in some spi drivers. With this helper,
>> spi_master_put() is called in devres_release_all() whenever
>> the device is unbound, so the spi_master_put() in error path
>> can be removed.
> If we're switching please update to the modern naming and use
> "controller" rather than the old name.
Do you mean to use spi_controller instead of spi_master? Something like 
this:
'struct spi_controller * ctlr = devm_spi_alloc_master();'
Dose spi_master_get_devdata()  need be changed to 
spi_controller_get_devdata() ?

Thanks,
Yang
