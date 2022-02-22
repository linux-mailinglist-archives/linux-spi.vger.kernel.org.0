Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED25D4BF98F
	for <lists+linux-spi@lfdr.de>; Tue, 22 Feb 2022 14:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbiBVNkN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Feb 2022 08:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbiBVNkM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Feb 2022 08:40:12 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D393427155;
        Tue, 22 Feb 2022 05:39:46 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id vz16so43118186ejb.0;
        Tue, 22 Feb 2022 05:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=wO4v/QlFW87aCrMs0PJAWecNmHDcvu/RVCXmt5Yo57I=;
        b=dytZ97GIYv2yp8rb1vZzuHAiylPKRgBSsdfKO1mQpzNLNQLIPzZs+pu3Fx/BiEt3q7
         WZrLeOMxorYig9DlL9JNrTWwCVlHnQ5q7RMV4/ug8NGtFsUtYXCVmOGAZA7OkrMVEFS/
         tMlOhqGCQq3W9K5EVTpHEfUZ6j4SARvBzp8TTkYFk8jI0TFD082i00Xc8cILzS+va7Q4
         g4lb39KO5S912vMorOIp0NemsFk9qQUksOOo/bjuPKh32t27qwVbbuUidXt4FAInYnLh
         Pmxaqhc+1qlgo1NbyR59VpOxgXGo0jf5HdQEYhUZsiT/KqUHjzeBYU7H4Nuij4leTeUd
         J7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=wO4v/QlFW87aCrMs0PJAWecNmHDcvu/RVCXmt5Yo57I=;
        b=S1EVj5d36st8qMCse33ZlKlQEpKNadaxQjVC1/4B20RnUUQ5dPTRw8j77dYoPUQX9P
         e+1lvc2ej7MFQ1Ka19m6dPbR2eUmp53VArAwi3S6Nr0kFCarwindgyEA5dTUMfbLkgRh
         QuHSevstX0OprqBnAWny2DKMepMd8i/xCK/UCgAxnCnXqVl8Qlx1ekhlx70XJ5BMulZp
         f7kjiYSTxe0sx+QBt3ImxGeGkPwL9RaPDe6ysusMlIu9zZ7S9ZZTJbKPsgvmT69/HnA8
         C3d1LW4MUdwbduPWBAOZXW1d9osW6VC7PvlhRBMtls9tMomtSF6Tyu2EK92YCF2NKyQT
         WQmQ==
X-Gm-Message-State: AOAM530pKWQn0YA+4qkoSvH4llyXDIOHa8ZLwVBucyE5/Or8AuwYYmZA
        tyWdXgc4v4huUfqP4Lplhv8=
X-Google-Smtp-Source: ABdhPJyM+HUuiKXN0cERbN/FPM9bV7YF+kgaeOKN0F6Mmx4/HqsfAGxKpjGU972rrh3JHKqHwJS3Tw==
X-Received: by 2002:a17:907:205a:b0:6cf:ced7:4e73 with SMTP id pg26-20020a170907205a00b006cfced74e73mr19715332ejb.536.1645537185270;
        Tue, 22 Feb 2022 05:39:45 -0800 (PST)
Received: from ?IPV6:2003:ea:8f4d:2b00:6da4:30d2:336:b924? (p200300ea8f4d2b006da430d20336b924.dip0.t-ipconnect.de. [2003:ea:8f4d:2b00:6da4:30d2:336:b924])
        by smtp.googlemail.com with ESMTPSA id qo24sm2923624ejb.92.2022.02.22.05.39.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 05:39:44 -0800 (PST)
Message-ID: <9e89e32f-e854-217d-3263-47e87a8fe783@gmail.com>
Date:   Tue, 22 Feb 2022 14:39:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
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
 <288225b9-85e0-0c46-5d8b-c91f76c796e5@gmail.com>
 <f0eeb2f4-b47d-f0d8-2169-388899d1cfdf@suse.de>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v2 5/6] auxdisplay: add support for Titanmec TM1628 7
 segment display controller
In-Reply-To: <f0eeb2f4-b47d-f0d8-2169-388899d1cfdf@suse.de>
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

On 22.02.2022 13:16, Andreas Färber wrote:
> On 22.02.22 10:44, Heiner Kallweit wrote:
>> On 22.02.2022 09:19, Geert Uytterhoeven wrote:
>>> Hi Heiner,
>>>
>>> On Mon, Feb 21, 2022 at 9:26 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>>> This patch adds support for the Titanmec TM1628 7 segment display
>>>> controller. It's based on previous RFC work from Andreas Färber.
>>>> The RFC version placed the driver in the LED subsystem, but this was
>>>> NAK'ed by the LED maintainer. Therefore I moved the driver to
>>>> /drivers/auxdisplay what seems most reasonable to me.
>>>>
>>>> Further changes to the RFC version:
>>>> - Driver can be built also w/o LED class support, for displays that
>>>>   don't have any symbols to be exposed as LED's.
>>>> - Simplified the code and rewrote a lot of it.
>>>> - Driver is now kind of a MVP, but functionality should be sufficient
>>>>   for most use cases.
>>>> - Use the existing 7 segment support in uapi/linux/map_to_7segment.h
>>>>   as suggested by Geert Uytterhoeven.
>>>>
>>>> Note: There's a number of chips from other manufacturers that are
>>>>       almost identical, e.g. FD628, SM1628. Only difference I saw so
>>>>       far is that they partially support other display modes.
>>>>       TM1628: 6x12, 7x11
>>>>       SM1628C: 4x13, 5x12, 6x11, 7x10
>>>>       For typical displays on devices using these chips this
>>>>       difference shouldn't matter.
>>>>
>>>> Successfully tested on a TX3 Mini TV box that has an SM1628C and a
>>>> display with 4 digits and 7 symbols.
>>>>
>>>> Tested-by: Christian Hewitt <christianshewitt@gmail.com>
>>>> Signed-off-by: Andreas Färber <afaerber@suse.de>
>>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>>
>>> Thanks for your patch!
>>>
>>>> --- /dev/null
>>>> +++ b/drivers/auxdisplay/tm1628.c
>>>
>>>> +static int tm1628_show_text(struct tm1628 *s)
>>>> +{
>>>> +       static SEG7_CONVERSION_MAP(map_seg7, MAP_ASCII7SEG_ALPHANUM);
>>>
>>> This mapping can not be overridden by the user.  Is there any
>>> specific reason you didn't make the mapping configurable from sysfs,
>>> cfr. map_seg7_{show,store}() in include/uapi/linux/map_to_7segment.h?
>>>
>>
>> The more features an initial driver version includes, the more discussion
>> topics pop up and make it less likely that we end up with at least something.
>> I think there's a reason why the driver was resting since the initial
>> attempt 2 yrs ago. Therefore I'd like to keep it as a MVP. 
>> If somebody should have the need for add-on features, then they can be
>> added later.
> 
> As I pointed out in your v1, I did implement all that already, as was
> requested by Geert on my RFC:
> 
> https://github.com/afaerber/linux/commit/bbecf951348c7de8ba922c6c002a09369b717d82
> 
I don't want to prove how many API's I master, but give users what they need.
And that's simply:
- control symbols from kernel or user space -> LED class sysfs attributes / triggers
- write text (mainly numbers) to display -> sysfs attribute
And this with a minimum of code to facilitate maintenance.
As confirmed by Christian the proposed version gives him what he needs.

If there should be actually a demand for features like dimming control, then it
can be added later (e.g. you could add it based on the code you wrote already).

> Regards,
> Andreas
> 
Heiner
