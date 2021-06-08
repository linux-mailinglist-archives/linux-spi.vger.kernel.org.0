Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56AED39FA29
	for <lists+linux-spi@lfdr.de>; Tue,  8 Jun 2021 17:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbhFHPS6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Jun 2021 11:18:58 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:37424 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbhFHPS6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 8 Jun 2021 11:18:58 -0400
Received: by mail-lf1-f45.google.com with SMTP id f11so32509943lfq.4;
        Tue, 08 Jun 2021 08:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zJjno0GCLiJ1Wpy5d6vNiYTsroNaBojnKVhJM2jeaPE=;
        b=f2SXJXdL2EoTZbnXJc5ZNNcyGU1be8IDSyTDuPTR5Hu2zccbhzOO2HDfGKOnQ6LSaW
         r4Ioet75GnHkTla9LQTSdn6oTZfyC2UrpozRq+YGEbO2ah9lQixFmFA+QCFo/lmh7PrM
         V9cJUdykDJBcHAT62RuZ6+I/FXZQ+LPeYmmHUQARZHPusrIr/W00VkgzxFRFelhkOvNa
         Lp1EoBfg/JxZ8gJQi+nrfejZuE7hjRn2RjP4Q1b60oRL3befu8clZXZUylrLtO6FImJP
         cpt+GHRGq9a//WgbD3rXZP7PPYI6EX8T/dt+XVN9UXog8YWKhLOTUnsnMDf1C3UtbMQl
         52Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zJjno0GCLiJ1Wpy5d6vNiYTsroNaBojnKVhJM2jeaPE=;
        b=S30MMO3opnGKPmgPYHrU3cC6gGrjik9kD7Boweey86Ejvd0wmLgdcG25HKN/46eCxE
         TgHe3H9B8YXVrEdiwnqRMeOIGnjkBuG/VAOinrNowzKH9xbXQYCcIcgXndrVGilPrvNN
         AjYF0WD7fBz5JJl48OTYXHkf3Ww15CNe72uLG1l+tuFu8ohwuOIXs8z5q8NxLPReQCyZ
         qRldPegncvFuL9lCJOauAl6w6QjuN4N+dW8bqUykxT+ukKvijavUhlLJdIc5437PQYod
         0efIsIM0VfGNbKkupyZxvo0NTcVadREkZ6XlOTZR9ACoBYH+XHq+n7aPL9N5zbkMYY9o
         Wk2A==
X-Gm-Message-State: AOAM5331KJmUSceYB26JN7VlFWSG2Co9+bagGVKJcFwcT9tlj8bjEZ6f
        n8z8zAKMvRDqAJuU1zeXC4pV6Mw/+d0=
X-Google-Smtp-Source: ABdhPJwGJnMtasHUBLZti+fIPjXvhlJzI3nhr4uPfW38zL1FW95RiZVvVWWqxYRPI+fCH8B+SJhzAA==
X-Received: by 2002:ac2:551d:: with SMTP id j29mr13402917lfk.319.1623165364140;
        Tue, 08 Jun 2021 08:16:04 -0700 (PDT)
Received: from [192.168.2.145] (94-29-21-60.dynamic.spd-mgts.ru. [94.29.21.60])
        by smtp.googlemail.com with ESMTPSA id g28sm1939509lfv.142.2021.06.08.08.16.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 08:16:03 -0700 (PDT)
Subject: Re: [PATCH] spi: tegra20-slink: Ensure SPI controller reset is
 deasserted
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20210608071518.93037-1-jonathanh@nvidia.com>
 <YL9eI8L32Tc8G7uF@orome.fritz.box>
 <7b4707f7-b895-9e98-c92e-d1e10b11c3f7@nvidia.com>
 <YL9tx7gMCccFBWob@orome.fritz.box>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <502a0259-447f-f7bf-a08d-34c18fd76c24@gmail.com>
Date:   Tue, 8 Jun 2021 18:16:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YL9tx7gMCccFBWob@orome.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

08.06.2021 16:16, Thierry Reding пишет:
>>> Unless perhaps if Mark applies this for v5.13, then we can merge the
>>> clock patch for v5.14-rc1 since SPI is the only IP that seems to be
>>> broken by that change.
>> Yes that works too.

Will be great if this SPI fix could be merged into 5.13. It took two
kernel releases to fix the audio resets, so I prefer not to postpone the
clk patch again.

>>>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>>>> ---
>>>>  drivers/spi/spi-tegra20-slink.c | 5 +++++
>>>>  1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
>>>> index f7c832fd4003..6a726c95ac7a 100644
>>>> --- a/drivers/spi/spi-tegra20-slink.c
>>>> +++ b/drivers/spi/spi-tegra20-slink.c
>>>> @@ -1118,6 +1118,11 @@ static int tegra_slink_probe(struct platform_device *pdev)
>>>>  		pm_runtime_put_noidle(&pdev->dev);
>>>>  		goto exit_pm_disable;
>>>>  	}
>>>> +
>>>> +	reset_control_assert(tspi->rst);
>>>> +	udelay(2);
>>>> +	reset_control_deassert(tspi->rst);
>>>> +
>>> I wonder if this doesn't break now again on suspend/resume. Should we
>>> perhaps move this into tegra_slink_runtime_resume()? Or better yet, move
>>> the reset_control_assert() into tegra_slink_runtime_suspend() and the
>>> reset_control_deassert() into tegra_slink_runtime_resume(). That should
>>> ensure the device's reset is always deasserted when runtime resumed.
>> So we do test suspend/resume on Cardhu and I have seen no issues with
>> this applied. At first I did put this in the runtime_suspend/resume
>> handlers, but then looking at what is done in spi-tegra114.c it appears
>> we just do this on probe. See ...
>>
>> commit 019194933339b3e9b486639c8cb3692020844d65
>> Author: Sowjanya Komatineni <skomatineni@nvidia.com>
>> Date:   Tue Mar 26 22:56:32 2019 -0700
>>
>>     spi: tegra114: reset controller on probe
>>
>> I guess moving it to the runtime_suspend/resume handlers would be more
>> consistent with the previous code. What do you think?
> Do we test that SPI is still functional after suspend/resume? If it is,
> I have no objection to this patch. I think making this part of runtime
> suspend/resume would be a bit more correct or robust, but it's also a
> bit more complicated and might introduce other problems. For example,
> I suspect that if we reset on runtime suspend/resume, we would likely
> need to reprogram the SLINK_COMMAND* registers as well.

We don't support LP0 suspend state for older Tegra SoCs where hardware
state is lost after suspending. Lot's of device drivers don't do
suspend/resume properly. Fixing suspend/resume should be a separate
patch, IMO.
