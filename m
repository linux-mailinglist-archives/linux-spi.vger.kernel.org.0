Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4A6117AA5C
	for <lists+linux-spi@lfdr.de>; Thu,  5 Mar 2020 17:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbgCEQUX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Mar 2020 11:20:23 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2512 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725946AbgCEQUX (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 5 Mar 2020 11:20:23 -0500
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 59154E912AACB6AD3896;
        Thu,  5 Mar 2020 16:20:21 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML711-CAH.china.huawei.com (10.201.108.34) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 5 Mar 2020 16:20:21 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 5 Mar 2020
 16:20:20 +0000
Subject: Re: [PATCH] spi: Remove CONFIG_ prefix from Kconfig select
To:     Joe Perches <joe@perches.com>
CC:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
References: <f8ac6b32a29b9a05b58a7e58ffe8b780642abbf1.camel@perches.com>
 <e265e7df-fd8c-691f-389a-c0e0e377ed9e@huawei.com>
 <84f8504924380fc6380216d03d28a2285e3d106e.camel@perches.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <55edba5c-78d6-12e2-eff6-f16c204badee@huawei.com>
Date:   Thu, 5 Mar 2020 16:20:20 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <84f8504924380fc6380216d03d28a2285e3d106e.camel@perches.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 05/03/2020 16:01, Joe Perches wrote:
> On Thu, 2020-03-05 at 15:53 +0000, John Garry wrote:
>> On 05/03/2020 15:15, Joe Perches wrote:
>>> commit a2ca53b52e00 ("spi: Add HiSilicon v3xx SPI NOR flash
>>> controller driver") likely inadvertently used a select statement
>>> with a CONFIG_ prefix, remove the prefix.
>>>
>>> Signed-off-by: Joe Perches <joe@perches.com>
>>
>> It's a pity checkpatch can't pick this stuff up...
> 
> You are free to write a rule and submit a patch.
> 

I'm not opposed to the idea...

> The grammar is pretty hard to verify from a patch
> fragment though.
> 
> There are 2 existing nominal false positives.
> 
> $ git grep 'select\b.*\bCONFIG_' -- '*/Kconfig*'
> drivers/edac/Kconfig:     select CONFIG_ACPI_NFIT.
> drivers/edac/Kconfig:     select CONFIG_ACPI_NFIT.

Ah, that's in the help text. I guess that those can be ignored simply 
based on the indentation.

I also see these:

drivers/i2c/busses/Kconfig:       to also select CONFIG_TYPEC_FUSB302=m.
drivers/platform/chrome/Kconfig:        select CONFIG_MFD_CROS_EC_DEV

The 2nd looks like it's incorrect.

And then also:
$ git grep 'depends on\b.*\bCONFIG_' -- '*/Kconfig*'
samples/Kconfig:        depends on CONFIG_ANDROID_BINDERFS

Thanks,
John
