Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2C14BF4ED
	for <lists+linux-spi@lfdr.de>; Tue, 22 Feb 2022 10:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiBVJpS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Feb 2022 04:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiBVJpS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Feb 2022 04:45:18 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5437158E86;
        Tue, 22 Feb 2022 01:44:52 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id u18so35496372edt.6;
        Tue, 22 Feb 2022 01:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=y/k/AioN9+eoLWmfmqCmaYerC3/rpiBltJOkbhRfuKo=;
        b=ggukSYH3F1aj0DqRb/pyNJ3aD9IDXokfr/6mfS3z+2TTpHy3OQu+yuBjkmHC1TJnst
         LCioxYDGsibKubf7qUMiKZ8DnJGtUGbLLHcbg+phUpEaAiUMk4Y7b0dP43e+bRYN0nfY
         OWNhAWD5Dwd9W9hG3bt11wgv7zmnaN9sv/djnqw7x4ISDsnp7R04OTpPMhwoF/icARk6
         KRNAqNa3CjERa6Wzej+W9PfoVFfSjPvOqHMfJxMpbXZxODOfDbGT5rm9BeqlEs3UtRhz
         /mRK+uhcbpC4zbHQifYsI/Vps6BJb36bBvxG9/qS5Jj40JO6LrvGchFCD1p/KVyleFRl
         Pvjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=y/k/AioN9+eoLWmfmqCmaYerC3/rpiBltJOkbhRfuKo=;
        b=fn/OZaPijgGaBn6qcoV8MaE62VYI2+RYJJqHsyJMtugwUkoWcI7zH4qJr0D4Ba1cRy
         nutOyhqcmCCVV29rccfrKOu6Ihi81et5xFBvsA9l8i84mSiAWXiUCHN2Sj3rHxjIHe3l
         ROPY17Cta0MLzxeq8BVcUUDQuEfmbGnZPpy1ZoKjZzeMJivhwGTY4HGtAqczxFZ5rW0h
         PAThVPhK+TUpD1hHSdICp5t+NaGdlVJLdQeCYpY3BFTOx+1ONjRaOoCqkvj55/NBzJB4
         4q3OmaRQ2+KYQSZC8AW0KfCTU7PjbEL5w82u0+5wJ18bxZH2v2NX6qYD1NkNwZVi+5oD
         FvYQ==
X-Gm-Message-State: AOAM531PPu8Pqj8ELaDXwadjByXICaP75j3iL25yLr9gYgCOVWSHAmDc
        lHMnwz8z/3IrHhnj3aKJGzzKZ8iXtRw=
X-Google-Smtp-Source: ABdhPJxtKCo6VkE4slXbqR04gcY71XE2ln0AckmC+kbLRg/IAv4KvvOvkQyRYuK4fC37+ROEf9lMNg==
X-Received: by 2002:a05:6402:268c:b0:411:e086:b7d1 with SMTP id w12-20020a056402268c00b00411e086b7d1mr25128967edd.111.1645523091170;
        Tue, 22 Feb 2022 01:44:51 -0800 (PST)
Received: from ?IPV6:2003:ea:8f4d:2b00:5cc0:13e2:26a9:58d0? (p200300ea8f4d2b005cc013e226a958d0.dip0.t-ipconnect.de. [2003:ea:8f4d:2b00:5cc0:13e2:26a9:58d0])
        by smtp.googlemail.com with ESMTPSA id h8sm9759966edk.14.2022.02.22.01.44.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 01:44:50 -0800 (PST)
Message-ID: <288225b9-85e0-0c46-5d8b-c91f76c796e5@gmail.com>
Date:   Tue, 22 Feb 2022 10:44:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Miguel Ojeda <ojeda@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
References: <1f39432b-84e2-e6dc-a6b8-c48ad5cf2210@gmail.com>
 <3facc242-0ce6-9170-1fee-a5ec0a66660a@gmail.com>
 <CAMuHMdUnDQKtGuN+n-t3P8e4nf9VLB+9q8fGyCh643T4Y1Knag@mail.gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v2 5/6] auxdisplay: add support for Titanmec TM1628 7
 segment display controller
In-Reply-To: <CAMuHMdUnDQKtGuN+n-t3P8e4nf9VLB+9q8fGyCh643T4Y1Knag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 22.02.2022 09:19, Geert Uytterhoeven wrote:
> Hi Heiner,
> 
> On Mon, Feb 21, 2022 at 9:26 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>> This patch adds support for the Titanmec TM1628 7 segment display
>> controller. It's based on previous RFC work from Andreas Färber.
>> The RFC version placed the driver in the LED subsystem, but this was
>> NAK'ed by the LED maintainer. Therefore I moved the driver to
>> /drivers/auxdisplay what seems most reasonable to me.
>>
>> Further changes to the RFC version:
>> - Driver can be built also w/o LED class support, for displays that
>>   don't have any symbols to be exposed as LED's.
>> - Simplified the code and rewrote a lot of it.
>> - Driver is now kind of a MVP, but functionality should be sufficient
>>   for most use cases.
>> - Use the existing 7 segment support in uapi/linux/map_to_7segment.h
>>   as suggested by Geert Uytterhoeven.
>>
>> Note: There's a number of chips from other manufacturers that are
>>       almost identical, e.g. FD628, SM1628. Only difference I saw so
>>       far is that they partially support other display modes.
>>       TM1628: 6x12, 7x11
>>       SM1628C: 4x13, 5x12, 6x11, 7x10
>>       For typical displays on devices using these chips this
>>       difference shouldn't matter.
>>
>> Successfully tested on a TX3 Mini TV box that has an SM1628C and a
>> display with 4 digits and 7 symbols.
>>
>> Tested-by: Christian Hewitt <christianshewitt@gmail.com>
>> Signed-off-by: Andreas Färber <afaerber@suse.de>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> Thanks for your patch!
> 
>> --- /dev/null
>> +++ b/drivers/auxdisplay/tm1628.c
> 
>> +static int tm1628_show_text(struct tm1628 *s)
>> +{
>> +       static SEG7_CONVERSION_MAP(map_seg7, MAP_ASCII7SEG_ALPHANUM);
> 
> This mapping can not be overridden by the user.  Is there any
> specific reason you didn't make the mapping configurable from sysfs,
> cfr. map_seg7_{show,store}() in include/uapi/linux/map_to_7segment.h?
> 

The more features an initial driver version includes, the more discussion
topics pop up and make it less likely that we end up with at least something.
I think there's a reason why the driver was resting since the initial
attempt 2 yrs ago. Therefore I'd like to keep it as a MVP. 
If somebody should have the need for add-on features, then they can be
added later.

> Gr{oetje,eeting}s,
> 
>                         Geert
> 

Heiner

> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

