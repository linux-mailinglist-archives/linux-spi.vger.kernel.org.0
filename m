Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8082B376E0F
	for <lists+linux-spi@lfdr.de>; Sat,  8 May 2021 03:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhEHBX7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 May 2021 21:23:59 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:37589 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229775AbhEHBX7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 7 May 2021 21:23:59 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UY66k6w_1620436976;
Received: from B-X3VXMD6M-2058.local(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0UY66k6w_1620436976)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 08 May 2021 09:22:57 +0800
From:   "xhao@linux.alibaba.com" <xhao@linux.alibaba.com>
Reply-To: xhao@linux.alibaba.com
Subject: Re: [PATCH v1] spi: fix client driver can't register success when use
 GPIO as CS
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>
Cc:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
References: <YJP6QIl+jnjKPlRo@smile.fi.intel.com>
 <83ab9b6c-8fb2-b053-ecb3-04230ca34e48@linux.alibaba.com>
 <CAHp75Vev1D5+QWyGCm+HgpdAyT4Uq_OAp7dCemVf9Cdvoay=Og@mail.gmail.com>
 <6bd8f178-51a2-3f45-8a16-80fdd4a3ed8e@linux.alibaba.com>
 <CAHp75Vfh+jqNLLbwWDe8pi1dQafnNFHak1Hk=5Cw3J+kJX9r3Q@mail.gmail.com>
 <CACRpkdZeKGP6Z8h3GaQ0=EA8mx+yRqzwZaQ5vDJrB4GiYLa26w@mail.gmail.com>
Message-ID: <489967db-128c-a52a-e36b-15d116173bb2@linux.alibaba.com>
Date:   Sat, 8 May 2021 09:22:56 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdZeKGP6Z8h3GaQ0=EA8mx+yRqzwZaQ5vDJrB4GiYLa26w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


在 2021/5/8 上午5:33, Linus Walleij 写道:
> On Fri, May 7, 2021 at 9:11 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>
>> It can’t be done due to differences of the expectations from them.
>> Your patch breaks OF as far as I understand. Linus?
> It looks to me like it would break OF.
>
> commit 766c6b63aa044e84b045803b40b14754d69a2a1d
> "spi: fix client driver breakages when using GPIO descriptors"
> passes enable1 to gpiod_set_value_cansleep() expecting
> gpiolib to handle polarity.
>
> If this should be changed, Sven van Asbroeck really needs
> to look at it first.
>
> But I think Andy's approach is the best.

Ok, agree, i check the relative patches, They do respond to different 
situations，

Andy，When do you send out your patch to fix this problem？

>
> Yours,
> Linus Walleij

-- 
Best Regards!
Xin Hao

