Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4DD536946D
	for <lists+linux-spi@lfdr.de>; Fri, 23 Apr 2021 16:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbhDWOMv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Apr 2021 10:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbhDWOMu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 23 Apr 2021 10:12:50 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18725C06174A
        for <linux-spi@vger.kernel.org>; Fri, 23 Apr 2021 07:12:14 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id o9-20020a1c41090000b029012c8dac9d47so1329508wma.1
        for <linux-spi@vger.kernel.org>; Fri, 23 Apr 2021 07:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=devtank-co-uk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=CU0yuJS9gxaSOduT5DnrFoz0/Pq9Ku7rhLu8n8w6dEQ=;
        b=FjcMFAiC2Nzpzw2fgx4R7R4Ayv9f1f1mFWIV68T6kRA9aCFsYDjKJe3lYN+Wtnb+Bi
         tv70qgnADNyPnBXTx9QgyNgWVvsEXful5jnEg8aAiE0DnnFpDaDtfRK0WMiUvS1OBuVZ
         YUxW5ugHFa8VqJ5zkT1tLg7sOgQuIyZ9HabaL5RxFaSH6HxJWAdEu0oT4abXnbw2BrJY
         gce99n3TnU2B2XFjohjlk6B/TXsgkTvUywf3mYjp7uKYRw+a4yyTFczj5I38zVUP+eqc
         /4YSiRDed7pPOe104yond7mK/E4a5Rvctl/sVovxZSMCHq9UTY2HBS2zEVNcw+hlaOf+
         f3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=CU0yuJS9gxaSOduT5DnrFoz0/Pq9Ku7rhLu8n8w6dEQ=;
        b=HuhbwnB8ZmLSP6UB+aFPcM4iaAMyJeaEdwa5gRu6EHOIJgkznP93uwDHd1WKGTZzhm
         U13ryRj5hOK6ht6w2gx8ebHo+6QTKw0e75oi++IFq7Tv+/JOf4uGKMf5asgtPB6EmXsw
         tEVecRwMGgp8+hyWJjPd+hAohJlnYSUDBSZVSToPyhy12EHwLsSqgItnfJ52n4eJnKyh
         DFf1qY+MYOOlWR73jwTEJJgaBw2kANarYNwh/h1tUkkaWO9ApxG0RNTeyiiGT+MxiqJg
         F8cRvefIglrEaFwFrWRuoPI/RWWyGo9rczuYU2pLK9LN0PixTIOoItKUEl+bX4x4phAF
         9TWQ==
X-Gm-Message-State: AOAM530xLDy7ssNuyg9P5NoC7xWsHBoUpFm8Gw/zQXiE1ankxoMejoyF
        cg6U5/NpaUYxcjmrgi9Q6waALg==
X-Google-Smtp-Source: ABdhPJzCHgg/2eIkE3KAMeST4LBIh9mq2YzSwL9e0W0UUVBt9YDteBaDv0wB6DjYQ8P9i84/lb7j6w==
X-Received: by 2002:a7b:c5c8:: with SMTP id n8mr5858732wmk.63.1619187132828;
        Fri, 23 Apr 2021 07:12:12 -0700 (PDT)
Received: from [192.168.200.229] (static-84-9-134-242.vodafonexdsl.co.uk. [84.9.134.242])
        by smtp.gmail.com with ESMTPSA id s16sm10871212wmh.11.2021.04.23.07.12.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 07:12:12 -0700 (PDT)
To:     Mark Brown <broonie@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nsaenz@kernel.org
References: <20210420083402.6950-1-joe.burmeister@devtank.co.uk>
 <c087ba2c-7839-02d1-a522-b104d8ffb8d2@gmail.com>
 <7c9f9376-1a80-b624-7b9e-0f6d04437c02@devtank.co.uk>
 <271ad212-a606-620e-3f0c-d6bff272be3c@gmail.com>
 <380624c4-82f3-0e6e-8cdb-8a9732636db8@devtank.co.uk>
 <20210423115724.GB5507@sirena.org.uk>
From:   Joe Burmeister <joe.burmeister@devtank.co.uk>
Subject: Re: [PATCH] spi: bcm2835: Fix buffer overflow with CS able to go
 beyond limit.
Message-ID: <672e8d77-ee5c-f10f-0bd3-f8708dfc24c8@devtank.co.uk>
Date:   Fri, 23 Apr 2021 15:12:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210423115724.GB5507@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 23/04/2021 12:57, Mark Brown wrote:
> On Fri, Apr 23, 2021 at 11:03:22AM +0100, Joe Burmeister wrote:
>> On 23/04/2021 00:49, Florian Fainelli wrote:
>>> Right, which means that we should probably seek a solution within the=

>>> SPI core itself, even if you can only test with spi-bcm2835.c chances=

>>> are that the fix would be applicable for other controllers if done in=

>>> the core.
>> I'm not sure it's possible to do in the core alone. The numb of the
>> issue is the core changes ctlr->num_chipselect to what is in the devic=
e
>> tree and some drivers are cool with that overs quietly stomp memory.
> I wouldn't expect any controller to be OK with that?  Drivers can store=

> per-client data in spi_device->controller_data which doesn't need
> scaling (but is also not so helpful if you need to look at clients othe=
r
> than the one you're currently controlling).
I can see a number which certainly wouldn't. Though I don't want to
assume that all don't.

If we are happy just not letting the core expand num_chipselect that
does stop the condition on everything.

Any controller that can go higher without issue could them have their
num_chipselect set to what their real limit is if this enforcement
causes an issue.


>> I've got a simple little patch to warn when the core expands
>> ctlr->num_chipselect. This warning won't go off in bcm2835 with my pat=
ch
>> because I am also extending ctlr->num_chipselect to the amount in the
>> device tree before the core does that expansion. Hopefully that new
>> warning would make people investigate and fix problem drivers.
>>>> There is protection in spi_add_device, which will catch extra added
>>>> later, but not ones in the device tree when the spi controller was
>>>> registered.
>>> Not sure I follow you, if we have the overlay before
>>> spi_register_controller() is called, how can the check there not
>>> trigger? And if we load the overlay later when the SPI controller is
>>> already registered, why does not spi_add_device()'s check work?
>> I think it might be a RPI thing. I think it is merging in the overlay
>> and giving Linux one already merged.
> If the overlay is handled by the bootloader then from the point of view=

> of Linux there is no overlay - sounds like there's an issue in the
> overlay, it should be overriding something that it doesn't?
Does it matter if the final device tree was compiled like that in the
first place or merge into that by the bootloader?

The limit isn't an hardware issue because the bcm2835 just uses any
gpios for CS. So hardware like ours with 8 spi chips on the bus is fine.
The driver's limit at 4 is arbitrary.

My patch for the bcm2835 just compares of what is in the device
tree and the harcoded limit and uses the largest. Other drivers do this.

Of course we could just raise BCM2835_SPI_NUM_CS to 8 or more if that is
preferred. Does seams like the dynamic solution is less favoured.

Regards,

Joe


