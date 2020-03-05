Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7CC17AA66
	for <lists+linux-spi@lfdr.de>; Thu,  5 Mar 2020 17:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgCEQVk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Mar 2020 11:21:40 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42644 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgCEQVk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 5 Mar 2020 11:21:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=L2uspJRoRT7neik2N4DuFrl2a9BrSt+K4IAqB69JQoQ=; b=YyEqUw71nfTPEi/pxrkuKiaAMn
        HCj9nByw3Wl4yBSwdL2Z4N+wGVcYed4qI4k+xImn/3Ry2m7oUmCUJKY9WqeJHL3Y9E08v4jPJwEms
        YuVNy1kkZlUlufPDkn5aLL+W9Nyt4O236p/vZWfYSJ5WVioxVPNsFR44c9Uik5stQld0sgnKevaYh
        qbv+przaabbXasIGFlPyLPiL3wrTUdbxMPwHJDAmssLyyhQbylS7wXwU4ncfIa4i8cFsn1qobf6sM
        e3XtHn6KJ4tln2qX6IVU1yHZr9gWTn5S3ZfOFYXFwfvrZeQvfVEIeFpUBqCrvsrkrej6ukuXDBexX
        Lom2Q1fg==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9tFj-0008OD-EO; Thu, 05 Mar 2020 16:21:39 +0000
Subject: Re: [PATCH] spi: Remove CONFIG_ prefix from Kconfig select
To:     John Garry <john.garry@huawei.com>, Joe Perches <joe@perches.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
References: <f8ac6b32a29b9a05b58a7e58ffe8b780642abbf1.camel@perches.com>
 <e265e7df-fd8c-691f-389a-c0e0e377ed9e@huawei.com>
 <84f8504924380fc6380216d03d28a2285e3d106e.camel@perches.com>
 <55edba5c-78d6-12e2-eff6-f16c204badee@huawei.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <15ad3c68-4e67-0c92-a0e1-c62861673561@infradead.org>
Date:   Thu, 5 Mar 2020 08:21:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <55edba5c-78d6-12e2-eff6-f16c204badee@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 3/5/20 8:20 AM, John Garry wrote:
> On 05/03/2020 16:01, Joe Perches wrote:
>> On Thu, 2020-03-05 at 15:53 +0000, John Garry wrote:
>>> On 05/03/2020 15:15, Joe Perches wrote:
>>>> commit a2ca53b52e00 ("spi: Add HiSilicon v3xx SPI NOR flash
>>>> controller driver") likely inadvertently used a select statement
>>>> with a CONFIG_ prefix, remove the prefix.
>>>>
>>>> Signed-off-by: Joe Perches <joe@perches.com>
>>>
>>> It's a pity checkpatch can't pick this stuff up...
>>
>> You are free to write a rule and submit a patch.
>>
> 
> I'm not opposed to the idea...
> 
>> The grammar is pretty hard to verify from a patch
>> fragment though.
>>
>> There are 2 existing nominal false positives.
>>
>> $ git grep 'select\b.*\bCONFIG_' -- '*/Kconfig*'
>> drivers/edac/Kconfig:     select CONFIG_ACPI_NFIT.
>> drivers/edac/Kconfig:     select CONFIG_ACPI_NFIT.
> 
> Ah, that's in the help text. I guess that those can be ignored simply based on the indentation.
> 
> I also see these:
> 
> drivers/i2c/busses/Kconfig:       to also select CONFIG_TYPEC_FUSB302=m.
> drivers/platform/chrome/Kconfig:        select CONFIG_MFD_CROS_EC_DEV
> 
> The 2nd looks like it's incorrect.

Yes, we just got a patch for that one today.

> 
> And then also:
> $ git grep 'depends on\b.*\bCONFIG_' -- '*/Kconfig*'
> samples/Kconfig:        depends on CONFIG_ANDROID_BINDERFS
> 
> Thanks,
> John


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
