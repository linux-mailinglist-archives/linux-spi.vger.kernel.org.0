Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCA136897D
	for <lists+linux-spi@lfdr.de>; Fri, 23 Apr 2021 01:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhDVXuA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Apr 2021 19:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhDVXuA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 22 Apr 2021 19:50:00 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DBFC061574;
        Thu, 22 Apr 2021 16:49:24 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id g16so7492759plq.3;
        Thu, 22 Apr 2021 16:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=IWfYoO0lSsj6QrdF4M9TVhiBQuuRKejv17Qbr6FkpHs=;
        b=POwfl7cE4Qcz1RenSpkCZiWAxw6lhRiLzZNY9Gg54NjNfXJSWLvpSa/LBmuIldfPHw
         nrr6RCnjKmzmZ3bWbdQmk8A/jbDyAEyaGPmcb421VfXnnY1L8pgTrNbnDBC/yuoDfgKz
         T3PNwP9pzPHw3dpSRe/tWnC7ubTOEenoqe0yDlJPATp5NlDzhXzUUTTUoEFW0d2M+X2B
         wOc1fh5jojyuGAhnrN8WrkDnKATakqCjzhwvLsKKUaYiQH7/lzozfDvO/xJ934r8VOPW
         8Cf/PGPlNT8E4L8289BNJtNjJYwHp+RiNLLrSa2vXNz3lAY4Kxa0G40LmezScm5J2V/M
         gVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IWfYoO0lSsj6QrdF4M9TVhiBQuuRKejv17Qbr6FkpHs=;
        b=Pxw7pAmRdDSjEPdkpPuSF5XvxW4+RMspNRdB6NYUzbEXKI3bMdnHFarSU1zscNDgge
         bgMFU2GDnKNfrijMlc7QGvqiEIWQ1xVZVpA52RnjFSPMN5AcFLUy/G8tkAxHCz9g+CbM
         O2bjrVQ89AjITUnVKZ/AkyCNfcHteoaugF4lbWTAh8dOkk8iqaYVSBKF00c4ebdvJzQG
         FxRPgs0PA9szsM2/3SooiENtxAzksOFRCRrxZqvs6OLxRoaGK9NxKQNmHU7+L333VRW9
         WeL7eAcI95ckFWTibT899Z/6vNVRmv2CT4VJ0UQefuJNGDtxsOppNEWIh8ZvTMGUsW07
         M8Jw==
X-Gm-Message-State: AOAM530RcYXZBOGMeombdwrkxnj3KFvpjRSZg2uKDVrLniAidN0rlJSn
        etMqC4r6prDU5ZjevSg8iG4=
X-Google-Smtp-Source: ABdhPJyQ8CB6gfavGomE80wlX8RKriAm4NmmFeGRBR1BIbjZmGV4qhobzGGXuBVwCwVbP22GOXafIQ==
X-Received: by 2002:a17:90a:8410:: with SMTP id j16mr1301384pjn.120.1619135364274;
        Thu, 22 Apr 2021 16:49:24 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id m20sm5615378pjq.40.2021.04.22.16.49.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 16:49:23 -0700 (PDT)
Subject: Re: [PATCH] spi: bcm2835: Fix buffer overflow with CS able to go
 beyond limit.
To:     Joe Burmeister <joe.burmeister@devtank.co.uk>,
        Mark Brown <broonie@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nsaenz@kernel.org
References: <20210420083402.6950-1-joe.burmeister@devtank.co.uk>
 <c087ba2c-7839-02d1-a522-b104d8ffb8d2@gmail.com>
 <7c9f9376-1a80-b624-7b9e-0f6d04437c02@devtank.co.uk>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <271ad212-a606-620e-3f0c-d6bff272be3c@gmail.com>
Date:   Thu, 22 Apr 2021 16:49:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <7c9f9376-1a80-b624-7b9e-0f6d04437c02@devtank.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 4/22/2021 1:10 PM, Joe Burmeister wrote:
>> On 4/20/2021 1:34 AM, Joe Burmeister wrote:
>>> It was previoulsy possible to have a device tree with more chips than
>>> the driver supports and go off the end of CS arrays.
>> Do you mind walking me through the code how that could have happened? We
>> have spi_register_controller() call of_spi_get_gpio_numbers() which has
>> the following:
>>
>> ctlr->num_chipselect = max_t(int, nb, ctlr->num_chipselect);
>>
>> such that what the controller has is the maximum between the number of
>> 'cs-gpios' properties parsed and what was already populated in
>> ctrl->num_chipselect during bcm2835_spi_probe(), which for this driver
>> is BCM2835_SPI_NUM_CS (3).
> 
> If you make a initial device tree (or add overlay in the rpi's 
> config.txt) with more on the bus than BCM2835_SPI_NUM_CS (in my case 8
> devices), you get into this trampling memory state. As the devices are
> added, once the chip_select is equal to or greater than
> BCM2835_SPI_NUM_CS, it's writing off the end of the arrays.

OK.

> 
> There is no protection from this happening. By the looks of it, this
> isn't the only driver this could happen with, but it is the one I have
> hardware for to test. There are also drivers that look like they don't
> have a problem going well beyond the limit they gave.

Right, which means that we should probably seek a solution within the
SPI core itself, even if you can only test with spi-bcm2835.c chances
are that the fix would be applicable for other controllers if done in
the core.

> 
> There is protection in spi_add_device, which will catch extra added
> later, but not ones in the device tree when the spi controller was
> registered.

Not sure I follow you, if we have the overlay before
spi_register_controller() is called, how can the check there not
trigger? And if we load the overlay later when the SPI controller is
already registered, why does not spi_add_device()'s check work?

How would I go about reproducing this on a Pi4?

> 
>>> This patches inforces CS limit but sets that limit to the max of the
>>> default limit and what is in the device tree when driver is loaded.
>>>
>>> Signed-off-by: Joe Burmeister <joe.burmeister@devtank.co.uk>
>> You have changed many more things that just enforcing a limit on
>> BCM2835_SPI_NUM_CS you have now made all chip-select related data
>> structuresd dynamically allocated and you have changed a number of
>> prints to use the shorthand "dev" instead of &pdev->dev.
> The change to dynamic allocated arrays is just to support what is given
> in the device  tree rather than increase and enforce the CS limit just
> for my case.
> 
> The shorthand is of course not required. I'll drop it on resubmitting.
> 
> Regards,
> 
> Joe
> 
> 

-- 
Florian
