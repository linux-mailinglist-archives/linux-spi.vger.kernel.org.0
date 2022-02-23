Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5274C1E76
	for <lists+linux-spi@lfdr.de>; Wed, 23 Feb 2022 23:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237576AbiBWWbF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Feb 2022 17:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiBWWbF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 23 Feb 2022 17:31:05 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FB147069;
        Wed, 23 Feb 2022 14:30:36 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id s24so362491edr.5;
        Wed, 23 Feb 2022 14:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=wkowMWok6XEoIKHqNibOAjVH0L4iPDJn35m1Kvj6PGA=;
        b=hIP8dw+codHbK47eoDosjIYyF1z1RUaqiZivtKde5D7YBr2iSy/VDehVLERsoUQ7OG
         n/JVAZqsQ7MrSLef+sG4pz1ixpHcuxPAGF1nE6hXnEAgJaQ06WYVvhz2cxOBnZETXXhM
         NTcCeTCP9sKX3AayfnD9nyAT5d8LD0/80xecORrNy74HlPbNQJGe7fXPNzFf5mDxBtdl
         Dkg1C+ha2s4QhKJKcaNwowBGL3d+EkFJ5xeqngM32ZSaIW4emZKCdMxEtoNuxaxTrJ6B
         NBA2n9SntFzN3ZpvQsjbPzf4BxiaxDX0icJaXmrTSAwIxCST1XihpcleO5KRgyjYGcbf
         3G5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=wkowMWok6XEoIKHqNibOAjVH0L4iPDJn35m1Kvj6PGA=;
        b=fAueLPGPVFh/JcH3RfilqvEUcI6DuMBWaTEfErK/EghWe1qmlbstDSikmx1g/2Ory0
         9iHXo9MAtGpHSwb/ricFTZ1xZjHLfYYP+wXkhvxxMHbBxd/E32RBYoIDUJB3Mk6gnPgx
         tU0YqZW6gySYQtb3P9qI7aXl2kLZ0ouwwSXUAUiLvfVTBYU7AloLu+2IpcvvL4G4OmYT
         mbK0PnuYT1ijp80TNMEON5Dl35jDIpEnc0NsspesskyjeU+qVhDbg6CmPcAfRPg9iKdP
         HgUra5GEAqb0eApcAFLAXl1wmsN43b6XWqCWLSt0LWIL4EDzkzL3qEH11Fo/anoXeL/X
         KR2Q==
X-Gm-Message-State: AOAM5301kLuudmXUB3RM4rw/RLCyxuiMySC+1J9vSDmc7PXADVH+jgtk
        lJXBrxaoP6yoeTUkpfP/asc=
X-Google-Smtp-Source: ABdhPJyiEcVd+tnECl8WhcHzlQsi8pEKClO0W1col8AmsEuH73thlYpjX5WwcOIXFyqcX3lsPb2KSA==
X-Received: by 2002:a50:fc05:0:b0:408:4d18:5070 with SMTP id i5-20020a50fc05000000b004084d185070mr1433614edr.365.1645655435077;
        Wed, 23 Feb 2022 14:30:35 -0800 (PST)
Received: from ?IPV6:2003:ea:8f4d:2b00:d12c:c0a:f603:b44d? (p200300ea8f4d2b00d12c0c0af603b44d.dip0.t-ipconnect.de. [2003:ea:8f4d:2b00:d12c:c0a:f603:b44d])
        by smtp.googlemail.com with ESMTPSA id hs25sm375759ejc.172.2022.02.23.14.30.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 14:30:34 -0800 (PST)
Message-ID: <9ae04fdb-7cc1-bea9-e7e1-ebc950bc592e@gmail.com>
Date:   Wed, 23 Feb 2022 23:30:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <4eb7b036-a9b9-3bd2-4e84-f56ba4b1a740@gmail.com>
 <944317db-b659-cb36-addf-c33623a4ff60@gmail.com>
 <CANiq72kdeuJhaEUOBAB3uYm9SA4Wm0U5=DNgxFMxiGDacUgaBA@mail.gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v3 4/5] auxdisplay: add support for Titanmec TM1628 7
 segment display controller
In-Reply-To: <CANiq72kdeuJhaEUOBAB3uYm9SA4Wm0U5=DNgxFMxiGDacUgaBA@mail.gmail.com>
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

On 23.02.2022 21:28, Miguel Ojeda wrote:
> On Wed, Feb 23, 2022 at 7:02 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> Co-Developed-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> If you (Heiner) are going to be the "From" author, then this line
> should not be here.
> 
>> +         Say Y to enable support for Titan Micro Electronics TM1628
>> +         LED controller.
>> +         It's a 3-wire SPI device controlling a two-dimensional grid of
>> +         LEDs. Dimming is applied to all outputs through an internal PWM.
> 
> Maybe a newline between paragraphs?
> 
OK

>> + * Copyright (c) 2019 Andreas Färber
> 
> ...here: should there be entries for you (Heiner) too? If not, should
> Andreas be the "From" author?
> 
> This also applies to the `MODULE_AUTHOR`.
> 
> Also it may be a good idea to add the emails:
> 
>     MODULE_AUTHOR("Andreas Färber <afaerber@suse.de>");
>     MODULE_AUTHOR("Heiner Kallweit <hkallweit1@gmail.com>");
> 
> (You may also want to consider adding an entry on `MAINTAINERS`).
> 

Maybe we should have both names in all places you mentioned.
I'd be fine with being listed as maintainer.

@Andreas: After you wrote the initial code and I rewrote bigger
parts of it: Do you want to be listed as maintainer too?
And any remark on the questions raised by Miguel?

>> +       u8 cmd = TM1628_CMD_DISPLAY_MODE | grid_mode;
> 
> Consider using `const` for some of the variables.
> 
OK

>> +       for (i = 0; i < s->grid_size; i++) {
>> +               int pos = s->grid[i] - 1;
>> +
>> +               if (i < msg_len) {
> 
> Consider inverting the condition, doing the set to `0` + `continue;`
> to avoid the indentation.
> 
OK

>> +       struct tm1628_led *led = container_of(led_cdev, struct tm1628_led, leddev);
>> +       struct tm1628 *s = led->ctrl;
>> +       int offset;
>> +       __le16 bit;
> 
> Style: sometimes the variables are initialized right away using a
> value from above, but other times they are done below.
> 
OK

>> +       if (count > s->grid_size + 1) /* consider trailing newline */
> 
> Style: sometimes comments are trailing the line, others are above.
> Also, sometimes they start with uppercase, but in other cases they do
> not.
> 
OK, will beautify this.

> Also, about the `+ 1`: is it possible that sysfs gives us a buffer
> full of `isprint()`? i.e. is it possible that `grid_size ==
> MAX_GRID_SIZE` and `count == MAX_GRID_SIZE + 1` and then we perform an
> out-of-bounds store to `MAX_GRID_SIZE + 2` in `text`?
> 
Typically there's no issue because command line input always ends
with the (non-printable) newline. But I checked and yes, it's possible
to pipe data w/o trailing newline to the attribute.
Hence I have to fix the code.

>> +       ret = tm1628_write_data(spi, 0, MAX_GRID_SIZE);
>> +       if (ret)
>> +               return ret;
>> +       /* Assume that subsequent SPI transfers will be ok if first was ok */
> 
> If not, is there a consequence? i.e. why wouldn't one check and fail
> similarly in the `tm1628_set_*` calls below?
> 
I'll change this check the return code also for the next calls.

>> +       if (!IS_REACHABLE(CONFIG_LEDS_CLASS))
>> +               goto no_leds;
> 
> What about putting the code in the `if` body (negating the condition)?
> 
I did it this way to avoid having to indent the following bigger block.

>> +       num_leds = 0;
> 
> This is reusing the variable for a different purpose, no? i.e. if we
> did not get here, we would have no leds, yet we would report the
> number above.
> 
The variable is re-used for a slightly different purpose. At first it's
used for the number of LED child nodes (what may include invalid configs),
then it's used for the number of the actually configured LED's.
And right, I have to move the assignment before the check.

>> +       device_for_each_child_node(&spi->dev, child) {
>> +               u32 reg[2];
>> +
>> +               ret = fwnode_property_read_u32_array(child, "reg", reg, 2);
>> +               if (ret) {
>> +                       dev_err(&spi->dev, "Reading %s reg property failed (%d)\n",
>> +                               fwnode_get_name(child), ret);
> 
> Is a failure expected? i.e. this `continue;`s, but should it fail or
> is it OK to proceed?
> 

Symbol LED's and display digits are independent. Therefore, if there's a problem
with a DT LED definition, I chose to just skip it instead if bailing out completely.

>> +       for (i = 0; i < 7; i++) {
> 
> Maybe a `#define` for several of the `7`s around?
> 
OK

>> +static void tm1628_spi_remove(struct spi_device *spi)
> 
> Doesn't `.remove` return `int`?
> 
This has changed recently with a0386bba7093 ("spi: make remove callback a void function").

> Thanks!
> 
> Cheers,
> Miguel

Thanks for the comprehensive feedback!

Heiner
