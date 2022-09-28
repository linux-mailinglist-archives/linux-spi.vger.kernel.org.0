Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673335EDF92
	for <lists+linux-spi@lfdr.de>; Wed, 28 Sep 2022 17:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbiI1PBY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 28 Sep 2022 11:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbiI1PBH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 28 Sep 2022 11:01:07 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158E136426
        for <linux-spi@vger.kernel.org>; Wed, 28 Sep 2022 08:01:04 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Md02H42YGzWgnY;
        Wed, 28 Sep 2022 22:56:55 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 23:01:01 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 23:01:01 +0800
Subject: Re: [PATCH -next 1/2] spi: introduce devm_spi_alloc_controller()
To:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Lukas Wunner <lukas@wunner.de>, <linux-spi@vger.kernel.org>,
        <yangyingliang@huawei.com>
References: <20220926142933.2299460-1-yangyingliang@huawei.com>
 <20220927034525.GA32253@wunner.de> <YzLct0v1ZRJVW2Gm@sirena.org.uk>
 <703c43ca-ab47-bfd9-da26-d435aaf236e5@huawei.com>
 <20220927133129.GA29821@wunner.de> <YzMsc1IM/73CMEeg@sirena.org.uk>
 <20220927201901.GB24652@wunner.de> <YzNbhPjn27cWHwyi@sirena.org.uk>
 <CAMuHMdWb8qeUGbr-zku4-zAM4Zj5MgCLJKR=Xg=Txe39kno8Og@mail.gmail.com>
 <YzQsw8hiMTxdqZuu@sirena.org.uk>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <bc97b9e1-fbd1-be29-beb4-e7a1e4037f3f@huawei.com>
Date:   Wed, 28 Sep 2022 23:01:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <YzQsw8hiMTxdqZuu@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 2022/9/28 19:15, Mark Brown wrote:
> On Tue, Sep 27, 2022 at 10:43:08PM +0200, Geert Uytterhoeven wrote:
>> On Tue, Sep 27, 2022 at 10:24 PM Mark Brown <broonie@kernel.org> wrote:
>>> Sure, but since the current wrappers use the legacy names this means
>>> that we need new wrappers with more modern names hence there is
>>> something to improve here.
>> So what are the more modern names?
> It's unfortunately not 100% clear, and our use of controller for the
> generic thing gets in the way a bit.  There was some stuff from one of
> the open source hardware groups recently that tried to propose new names
> but I'm not immediately finding it.  "host" and "target" would probably
> do the trick?
So shall we use host/target to do wrappers.

Thanks,
Yang
