Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C6E431F83
	for <lists+linux-spi@lfdr.de>; Mon, 18 Oct 2021 16:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhJROa1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 18 Oct 2021 10:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbhJROa1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 18 Oct 2021 10:30:27 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E5FC061745;
        Mon, 18 Oct 2021 07:28:16 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id o83so66072oif.4;
        Mon, 18 Oct 2021 07:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZGg9iP3770g2EGM+xsq5tq0SBh55t8OHrqyNWoeF1KQ=;
        b=DDc/pT68TnGI66oQeUqELRZOvhwwhtzr1x2skL2VX4yOtc4uzTosySLReAhhEnEJ1q
         xxgxdXyK2MSg/KiiLNe9Ey5H0YIB9oE7rGTAKDbTx8XJqlFIx9z9N8uKXBaRKaNylD6F
         YTsqqCyVXSq74xJgOgTG0etfSZ/AbG0MJ5Iz3h3/oMjJ9vEFaxlY2q8Vp8eDdeBM5LSR
         2Q6JmXQMFuT7FWY1birPg3HyzNguXYPn+ImMq0flOwj2Zzkwsq4VFaLQS5TJiXtyEhXY
         qlYFCvfEsGMIuZV4jJJGhU6RrJGmtiR6jkl991ZWhry4fT5SL26+eFpbSqVvHtbGKTVC
         vdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZGg9iP3770g2EGM+xsq5tq0SBh55t8OHrqyNWoeF1KQ=;
        b=P31AwcFoQW/4XYy1JLMky4kRtkEl+jBXhz0/mBwUp7vxjK+bbRsgDZsDJJcF5ml2/9
         4XYSEmvdu9hE7CENyt0x18iSbK+aPGf+wpvqKbg1NUas7nq8iO3cUA7H0Ss2NI9kB1hn
         hxWivSH/sZwtC8yLn0mm3DCaA3FFVEn10+M5IgmJogI5e52Kipg45nqHsrYWnit6J2Bk
         /vWNDJF1LfSX0nBvmanHVxFk57369Ck8maGryoYzgQWSqyDF6R3GYZ8j/6uSuKSNywGJ
         iT9Qt2JDcoOsuMoCjusPLW0zvL++Nr4ANZRE7eJHTdkrRWVKpQ8MNS4xxVJuYlTIJ0CM
         /oXg==
X-Gm-Message-State: AOAM533G+uDuYxPZ0NUtiYSFw81GLa5y6y1Mqr5L9/oOYT/ki683KBu2
        kFNBTGqjRN2Pbni1rs4BPB4VwJN8YpY=
X-Google-Smtp-Source: ABdhPJy6QZ2bMZfw8u+3hxNFxr+P3pasdzH+Flb/Ln2wIhbN5Ax9kr1tYOufKGG6BhyqWoHkNc7bhw==
X-Received: by 2002:aca:6142:: with SMTP id v63mr19374oib.58.1634567295508;
        Mon, 18 Oct 2021 07:28:15 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f8sm3004112otp.63.2021.10.18.07.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 07:28:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] spi: tegra20: fix build with CONFIG_PM_SLEEP=n
To:     Thierry Reding <thierry.reding@gmail.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Osipenko <digetx@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Zhang Qilong <zhangqilong3@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211013144538.2346533-1-arnd@kernel.org>
 <YW19Z4gF7UCECF1H@orome.fritz.box>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <65625987-9b8b-d0bc-5413-b8cd1f8ed14f@roeck-us.net>
Date:   Mon, 18 Oct 2021 07:28:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YW19Z4gF7UCECF1H@orome.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 10/18/21 6:57 AM, Thierry Reding wrote:
> On Wed, Oct 13, 2021 at 04:45:23PM +0200, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> There is another one of these warnings:
>>
>> drivers/spi/spi-tegra20-slink.c:1197:12: error: 'tegra_slink_runtime_resume' defined but not used [-Werror=unused-function]
>>   1197 | static int tegra_slink_runtime_resume(struct device *dev)
>>        |            ^~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> Give it the same treatment as the other functions in this file.
>>
>> Fixes: efafec27c565 ("spi: Fix tegra20 build with CONFIG_PM=n")
>> Fixes: 2bab94090b01 ("spi: tegra20-slink: Declare runtime suspend and resume functions conditionally")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>   drivers/spi/spi-tegra20-slink.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Acked-by: Thierry Reding <treding@nvidia.com>
> 

The problem has now been (re-)introduced into the mainline kernel
and causes various test build failures there.

Guenter
