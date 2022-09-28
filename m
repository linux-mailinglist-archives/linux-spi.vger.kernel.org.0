Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1215ED4EE
	for <lists+linux-spi@lfdr.de>; Wed, 28 Sep 2022 08:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbiI1GeY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 28 Sep 2022 02:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiI1GeX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 28 Sep 2022 02:34:23 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4351C00C5
        for <linux-spi@vger.kernel.org>; Tue, 27 Sep 2022 23:34:20 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4McmnQ1PFRz1P6sY;
        Wed, 28 Sep 2022 14:30:02 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 14:34:18 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 14:34:17 +0800
Subject: Re: [PATCH -next 1/2] spi: introduce devm_spi_alloc_controller()
To:     Mark Brown <broonie@kernel.org>, Lukas Wunner <lukas@wunner.de>
CC:     <linux-spi@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        <yangyingliang@huawei.com>
References: <20220926142933.2299460-1-yangyingliang@huawei.com>
 <20220927034525.GA32253@wunner.de> <YzLct0v1ZRJVW2Gm@sirena.org.uk>
 <703c43ca-ab47-bfd9-da26-d435aaf236e5@huawei.com>
 <20220927133129.GA29821@wunner.de> <YzMsc1IM/73CMEeg@sirena.org.uk>
 <20220927201901.GB24652@wunner.de> <YzNbhPjn27cWHwyi@sirena.org.uk>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <f544de9f-2a57-fe59-79b1-f39857bb8d14@huawei.com>
Date:   Wed, 28 Sep 2022 14:34:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <YzNbhPjn27cWHwyi@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
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


On 2022/9/28 4:22, Mark Brown wrote:
> On Tue, Sep 27, 2022 at 10:19:01PM +0200, Lukas Wunner wrote:
>> On Tue, Sep 27, 2022 at 06:01:39PM +0100, Mark Brown wrote:
>>> On Tue, Sep 27, 2022 at 03:31:29PM +0200, Lukas Wunner wrote:
>>>> On Tue, Sep 27, 2022 at 07:57:05PM +0800, Yang Yingliang wrote:
>>>>> Do you mean to introduce two more proper wrappers to instead of
>>>>> devm_spi_alloc_master/slave() ?
>>>> Honestly I don't think there's room for (or a need for) improvement here.
>>> The issue here is that we're trying to get rid of the master/slave
>>> terminology.
>> Converting drivers to use spi_controller everywhere in lieu of
>> spi_master is fine, but drivers need to specify whether the
>> spi_controller is a master or a slave and Geert's design is
>> to specify that on allocation.  Which makes sense because
>> that's the moment the spi_controller comes to life, there's
>> no earlier moment where one could specify the type.
> Sure, but since the current wrappers use the legacy names this means
> that we need new wrappers with more modern names hence there is
> something to improve here.

How about using primary/secondary, introduce two wrappers like this:

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h

index 6ea889df0813..c41654fb069b 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -778,6 +778,21 @@ static inline struct spi_controller 
*devm_spi_alloc_slave(struct device *dev,
      return __devm_spi_alloc_controller(dev, size, true);
  }

+static inline struct spi_controller *devm_spi_alloc_primary(struct 
device *dev,
+                                unsigned int size)
+{
+    return __devm_spi_alloc_controller(dev, size, false);
+}
+
+static inline struct spi_controller *devm_spi_alloc_secondary(struct 
device *dev,
+                                  unsigned int size)
+{
+    if (!IS_ENABLED(CONFIG_SPI_SLAVE))
+        return NULL;
+
+    return __devm_spi_alloc_controller(dev, size, true);
+}
+
  extern int spi_register_controller(struct spi_controller *ctlr);
  extern int devm_spi_register_controller(struct device *dev,
                      struct spi_controller *ctlr);

Thanks,
Yang
