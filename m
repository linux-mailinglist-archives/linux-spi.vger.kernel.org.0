Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29AD94BEB7C
	for <lists+linux-spi@lfdr.de>; Mon, 21 Feb 2022 20:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbiBUT6b (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Feb 2022 14:58:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiBUT6a (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Feb 2022 14:58:30 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC25422531;
        Mon, 21 Feb 2022 11:58:05 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id x5so31500402edd.11;
        Mon, 21 Feb 2022 11:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HSpBNSxjUcjevRPRuq5jzLPR/q4LolR4J0lICROk6aA=;
        b=jzZm4VRSsa6RUfToQpF+JE8MNOdjqq3fTROt6yQK84Bb5vtaOpTt3hpORwrBn6WTe9
         dEq3ae8aC9tv/ldl9YlbY5Pio4XeirB2H6XCWvVVFY+XjJJpD4musZTwJh1utI/qUaKZ
         G24q64LqJd0depkZHJyP/ptue82oxNIfoWkpfR0Ws6xdgUFonPMZnerejr2bzmP8kdnU
         DLX050cE8JS8Cszp7v0+XC/5trSBsvDmJFs9aMSreJyMAUpLf0KFha+gsvyIbYlOo4Rp
         RNbkIJubgsMYOpiawrURh3iPSflJ6+L8fmcJU0S9Mzv3gXTGkllgMXM1BeV7FswnmNqY
         vEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HSpBNSxjUcjevRPRuq5jzLPR/q4LolR4J0lICROk6aA=;
        b=eJliLBHyVWT28dcRj9ozgDGRp7pMiwLaKdpIisvTl+WjvuEErZv2V53HOj973kTL2Z
         GK9au4gy4ugukeTHOnFbGKplj1KbWGp4B7Q3Qdfhg2J8J8QLZygDPTC0Rdhg6HEf8cd6
         AGCTVefg/9gDf8FEEcjvPD0J3kBUJNGsn9rYAFA4Ldk8riM3cFvB52qQncvNVaZuyDo3
         XkbIBTLrDGZGEH8Shcv9W75KpFPpC0PzMJJ6U7hhQXpd2X1uvvuI8sSdye/yUrRPHH1a
         icBGW8L/QGVYKZ20N4uczGKJRRjeQnx3g1fPlfvoGzUUE6nIHI/qtbxidWcRDz2U+xAN
         f3rg==
X-Gm-Message-State: AOAM531rajDrvmWetFbWLn2rW9wtJp/bgaIr6ORFKKgmtFoIYygryBPU
        Eoev4xYW8+fVgyqJFqu5Xl0=
X-Google-Smtp-Source: ABdhPJzUsFIRO4A9bMmAHao7eSN/v43SjbKA8y5+BzAuuiwxJ65BA3NqfLLsGUpT4Nwdxp/tYlZn8g==
X-Received: by 2002:a50:c30f:0:b0:410:ef84:f718 with SMTP id a15-20020a50c30f000000b00410ef84f718mr22817590edb.128.1645473484294;
        Mon, 21 Feb 2022 11:58:04 -0800 (PST)
Received: from ?IPV6:2003:ea:8f4d:2b00:b141:a0d:4aad:2a06? (p200300ea8f4d2b00b1410a0d4aad2a06.dip0.t-ipconnect.de. [2003:ea:8f4d:2b00:b141:a0d:4aad:2a06])
        by smtp.googlemail.com with ESMTPSA id j8sm9568670edw.40.2022.02.21.11.58.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 11:58:03 -0800 (PST)
Message-ID: <9b7b175c-148f-c7ff-0e77-ad1d9d0bdaf8@gmail.com>
Date:   Mon, 21 Feb 2022 20:57:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 0/6] auxdisplay: Add support for the Titanmec TM1628 7
 segment display controller
Content-Language: en-US
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
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
 <5B4B8165-5D64-4336-A149-DF55C47D5ACE@gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <5B4B8165-5D64-4336-A149-DF55C47D5ACE@gmail.com>
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

On 21.02.2022 07:32, Christian Hewitt wrote:
> resend from correct mail account:
> 
>> On 19 Feb 2022, at 5:13 pm, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> This series adds support for the Titanmec TM1628 7 segment display
>> controller. It's based on previous RFC work from Andreas Färber.
>> The RFC version placed the driver in the LED subsystem, but this was
>> NAK'ed by the LED maintainer. Therefore I moved the driver to
>> /drivers/auxdisplay what seems most reasonable to me.
>>
>> To be decided is through which tree this series should go.
>> I'd think SPI would be most suited, but that's a decision I
>> leave up to the respective maintainers.
>>
>> Further changes to the RFC version:
>> - Driver can be built also w/o LED class support, for displays that
>> don't have any symbols to be exposed as LED's.
>> - Simplified the code and rewrote a lot of it.
>> - Driver is now kind of a MVP, but functionality should be sufficient
>> for most use cases.
>> - Use the existing 7 segment support in uapi/linux/map_to_7segment.h
>> as suggested by Geert Uytterhoeven.
>>
>> Note: There's a number of chips from other manufacturers that are
>>     almost identical, e.g. FD628, SM1628. Only difference I saw so
>>     far is that they partially support other display modes.
>>     TM1628: 6x12, 7x11
>>     SM1628C: 4x13, 5x12, 6x11, 7x10
>>     For typical displays on devices using these chips this
>>     difference shouldn't matter.
>>
>> Successfully tested on a TX3 Mini TV box that has an SM1628C and a
>> display with 4 digits and 7 symbols.
> 
> Thanks for dusting off sources and working on this! - it’s another piece
> of the upstream puzzle for distros that install on Android boxes.
> 
> I needed the following patch to address compile issues (missing include,
> and the recent void/int change in linux-next (I’m using 5.17.y):
> 
> diff --git a/drivers/auxdisplay/tm1628.c b/drivers/auxdisplay/tm1628.c
> index a39b638282c1..ab3557f8b330 100644
> --- a/drivers/auxdisplay/tm1628.c
> +++ b/drivers/auxdisplay/tm1628.c
> @@ -5,6 +5,7 @@
> * Copyright (c) 2019 Andreas Färber
> */
> 
> +#include <linux/ctype.h>
> #include <linux/delay.h>
> #include <linux/leds.h>
> #include <linux/module.h>
> @@ -327,10 +328,11 @@ static int tm1628_spi_probe(struct spi_device *spi)
>       return device_create_file(&spi->dev, &dev_attr_display_text);
> }
> 
> -static void tm1628_spi_remove(struct spi_device *spi)
> +static int tm1628_spi_remove(struct spi_device *spi)
> {
>       device_remove_file(&spi->dev, &dev_attr_display_text);
>       tm1628_set_display_ctrl(spi, false);
> +       return 0;
> }
> 
> static void tm1628_spi_shutdown(struct spi_device *spi)
> 
> I also needed CONFIG_SPI_GPIO=y in kernel config. With this added the
> driver probes on my TX3 mini box and the display goes dark overwriting
> the default ‘boot’ text. The following systemd service and script sets
> the clock and flashes the colon separator on/off to count seconds:
> 
> https://github.com/chewitt/LibreELEC.tv/commit/c8f1ebe6f6c366188f18f9d2b401de6c2979fdd7
> 
> With the include fixup and maybe a Kconfig tweak, for the series:
> 
> Tested-by: Christian Hewitt <christianshewitt@gmail.com>

Thanks for testing! 
On some systems the display controller may be connected to a HW SPI
interface not using GPIO's. Therefore I'd prefer to not make
the driver dependent on CONFIG_SPI_GPIO.
