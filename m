Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C4737514E
	for <lists+linux-spi@lfdr.de>; Thu,  6 May 2021 11:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbhEFJMd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 May 2021 05:12:33 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3968 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbhEFJMc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 6 May 2021 05:12:32 -0400
Received: from dggeme758-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FbSS94hdYz5yvp;
        Thu,  6 May 2021 17:08:57 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.234) by dggeme758-chm.china.huawei.com
 (10.3.19.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 6 May
 2021 17:11:32 +0800
Subject: Re: [PATCH 0/2] spi: Correct CS GPIOs polarity when using GPIO
 descriptors
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "huangdaode@huawei.com" <huangdaode@huawei.com>,
        "tangzihao1@hisilicon.com" <tangzihao1@hisilicon.com>
References: <1620270017-52643-1-git-send-email-f.fangjian@huawei.com>
 <CAHp75Vfr8t9UVqVn6hLSN6Mi3=iNAn612eE-qKq9HfrwNhpg3Q@mail.gmail.com>
 <CAHp75Vei0QGaKiq5Nai7Gsa=jcMSipaXV_6qZbBy=f0OrN=DHQ@mail.gmail.com>
From:   Jay Fang <f.fangjian@huawei.com>
Message-ID: <e919da77-a664-d78b-2c47-cc9ba8745a72@huawei.com>
Date:   Thu, 6 May 2021 17:11:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAHp75Vei0QGaKiq5Nai7Gsa=jcMSipaXV_6qZbBy=f0OrN=DHQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.188.234]
X-ClientProxiedBy: dggeme711-chm.china.huawei.com (10.1.199.107) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2021/5/6 16:14, Andy Shevchenko wrote:
> 
> 
> On Thursday, May 6, 2021, Andy Shevchenko <andy.shevchenko@gmail.com <mailto:andy.shevchenko@gmail.com>> wrote:
> 
> 
> 
>     On Thursday, May 6, 2021, Jay Fang <f.fangjian@huawei.com <mailto:f.fangjian@huawei.com>> wrote:
> 
>         This series introduces a generic implementation to solve the conflict
>         between the 'cs-gpios' flags and the optional SPI slaves flags. So we
>         don't need to add two similar quirks separately for DT and ACPI.
> 
> 
>     NAK. There is a patch against documentation that clarifies polarity of GPIO for ACPI. I have a fix for that to use generic implementation of  CS GPIOs .

Thanks. Has the Fix patch been merged ? Commit Id ?

> 
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=ec3576eac11d66a388b6cba6a7cfb3b45039a712 <https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=ec3576eac11d66a388b6cba6a7cfb3b45039a712>
> 
> 
> If your ACPI table uses GPIO CS with polarity low (assumes _DSD() is involved), this is a bug. Fix firmware or do a quirk specific for your platform.
> 
>  
> 
>      
> 
>         Jay Fang (2):
>           spi: Correct CS GPIOs polarity when using GPIO descriptors
>           Revert "gpio: of: Handle SPI chipselect legacy bindings"
> 
>          drivers/gpio/gpiolib-of.c | 51 ++---------------------------------------------
>          drivers/spi/spi.c         | 22 ++++++++++++++++++--
>          2 files changed, 22 insertions(+), 51 deletions(-)
> 
>         -- 
>         2.7.4
> 
> 
> 
>     -- 
>     With Best Regards,
>     Andy Shevchenko
> 
> 
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 


