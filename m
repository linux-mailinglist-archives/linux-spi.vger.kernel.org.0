Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CE14BC97D
	for <lists+linux-spi@lfdr.de>; Sat, 19 Feb 2022 18:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242693AbiBSRQ7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 19 Feb 2022 12:16:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242610AbiBSRQ6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 19 Feb 2022 12:16:58 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17E2C07;
        Sat, 19 Feb 2022 09:16:38 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id cm8so11307791edb.3;
        Sat, 19 Feb 2022 09:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=T9EQL5ZXNiD+KSv8P5NAsXTQao5/V3noUXFDN8MuNzk=;
        b=I4x2sSs28bNnRdwIYHiDEpgJ0QStGbZFXjcOyVyb+rfJrG8t9CDV7vIiDpJM/UroJD
         GbvJzZkAlulVPXeWjl0u7yr569mLS3iv1sJMUm5+96eKHdK3yLy7xrA8l4vr60XbaQMr
         vwwK+i7ymWcIgSZQzflUhiqz9SlTstmVP3n9Kvnk0hgU8m9PSXKbmRc4ESbzK6al/Lai
         LTCFRXKcU4rPFWOaRfc8RVKszeqj+HA/P8n89Nf3jYYksC2yP4NVhB1eiyMTvnEDsSk9
         Z/97v0BE9JfNSCbgX6752MWjmjJJ8mp62RIZFzb2cB4rNKalA1VEN5SaVgmO7LXV1rki
         T/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=T9EQL5ZXNiD+KSv8P5NAsXTQao5/V3noUXFDN8MuNzk=;
        b=ODCqxccnjJPB0eqVUHuL8EmFK/h0JG/KagVV7bicY31MylBIAMaL1+hEv4GajJJbMJ
         yIKQg2TyzKIDWNIG67Gn+Gr2tsnf86taKRDMEizVRLTyaXcQ0P+NEeZfq9u/EdXb21i/
         cy5tnjw7aoIhr7cViIkSAJNtxiXw/hNMgUAjC66IVqjx6bcDg5SL6gweL9dalymMXEWo
         +zo8NTDMFbxtkPwWTT1Sni7m3RHYajx30GJbdGHtLiZU6F/KCSiSx23wt7GWAw17ITUM
         FalISDkhxLi03tX82rL0v/8ja9d3lkCbpLYz63OxqeGZQcwZ6ak4j+1lAs2/mj9vYw2a
         aHqQ==
X-Gm-Message-State: AOAM533+FTkPL1e13E++x3TmNKUYDvIzsuH31iG+R4ywaqWN3eZeoutm
        CvSpAzTh5LJhel+qFR6qS0GFsV2sQGU=
X-Google-Smtp-Source: ABdhPJykHTjW+gWjmanRPCbVfqty60bJcp6S25QsAeOqUloeISYFvnm09pvUhltBBk0suYWV78hO3Q==
X-Received: by 2002:a05:6402:3549:b0:412:b31c:5509 with SMTP id f9-20020a056402354900b00412b31c5509mr11051717edd.224.1645290997226;
        Sat, 19 Feb 2022 09:16:37 -0800 (PST)
Received: from ?IPV6:2003:ea:8f4d:2b00:5cf9:df09:c1b3:d44d? (p200300ea8f4d2b005cf9df09c1b3d44d.dip0.t-ipconnect.de. [2003:ea:8f4d:2b00:5cf9:df09:c1b3:d44d])
        by smtp.googlemail.com with ESMTPSA id z22sm6522838edd.45.2022.02.19.09.16.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Feb 2022 09:16:36 -0800 (PST)
Message-ID: <09bf3d8a-2902-723b-80d2-0c4d1c24f53d@gmail.com>
Date:   Sat, 19 Feb 2022 18:16:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org
References: <4172e59f-b9d5-d87d-9dbd-a6f683a2173c@gmail.com>
 <CANiq72mi5fj07cfo6T4jPmp=EiRtE_uDeHHCqjG9h+duPrUMKg@mail.gmail.com>
 <ecdbfb3a-e214-a059-95b9-1ebf2f625295@gmail.com>
 <862fc0e3-6c76-8dea-6725-a6c45ade1ecd@suse.de>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 0/6] auxdisplay: Add support for the Titanmec TM1628 7
 segment display controller
In-Reply-To: <862fc0e3-6c76-8dea-6725-a6c45ade1ecd@suse.de>
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

On 19.02.2022 17:07, Andreas Färber wrote:
> Hi,
> 
> On 19.02.22 14:37, Heiner Kallweit wrote:
>> On 19.02.2022 14:27, Miguel Ojeda wrote:
>>> On Sat, Feb 19, 2022 at 2:13 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>>>
>>>> This series adds support for the Titanmec TM1628 7 segment display
>>>> controller. It's based on previous RFC work from Andreas Färber.
>>>> The RFC version placed the driver in the LED subsystem, but this was
>>>> NAK'ed by the LED maintainer. Therefore I moved the driver to
>>>> /drivers/auxdisplay what seems most reasonable to me.
>>>
>>> Could you please link to the discussion and/or summarize the rationale
>>> behind the NAK?
>>>
>>
>> +Pavel
>>
>> I didn't find an explicit reason, but I suppose Pavel sees this driver as
>> one that makes use of the LED subsystem, but doesn't belong to it.
>> In the following mail he's expressing his opinion that the driver should
>> be best placed under auxdisplay.
>>
>> https://lore.kernel.org/linux-arm-kernel/20200226130300.GB2800@duo.ucw.cz/
> 
> And I disagreed. It does not fit with the other drivers in auxdisplay
> that were operating on a much higher level.
> 

We need to find a place. And if Pavel has good reasons that it doesn't
fit into the LED subsystem, and Miguel should be fine with having
it in auxdisplay, then I'd see no reason to not go this way.

> I'd also like to point out that I did implement the map_to_7segment API,

Looking at the history of include/uapi/linux/map_to_7segment.h I see no
commit from you. Seems I'm missing something here.

> as was suggested, as you will find in my tree - which you may have
> missed, referencing only the RFC patchset and putting your authorship on
> it exclusively? A move from one directory to another should not warrant
> my author and SoB getting removed from the actual driver.
> 
The driver includes major changes and I mentioned your work in the commit
message. Also your still listed as MODULE_AUTHOR. My intention is to
get a driver upstream, not to earn credits for something.
So sure, your SoB can be (re-)added.

> Given that we need to manage a buffer with bits per segment or LED
> symbol, one idea that I haven't found time for yet was to implement it
> as framebuffer or drm device instead. (And most Realtek platforms got
> broken by removing the adjustable text base defines.)
> 
I'm not aware of the Realtek platform issue, do you have a link to a
related discussion? And wouldn't you think it's overengineering to
write a DRM driver for a 7 segment display with 4 digits?
Framebuffer seems to be deprecated based on my experience with
pygame / SDL2.

> Regards,
> Andreas
> 

Heiner
