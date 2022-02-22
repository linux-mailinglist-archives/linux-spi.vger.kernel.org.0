Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA7E4BF362
	for <lists+linux-spi@lfdr.de>; Tue, 22 Feb 2022 09:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiBVIUP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Tue, 22 Feb 2022 03:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiBVIUO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Feb 2022 03:20:14 -0500
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B751B154D14;
        Tue, 22 Feb 2022 00:19:49 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id d11so16230493vsm.5;
        Tue, 22 Feb 2022 00:19:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jgaRhHslsUBWDtLPmfFYKNjHJ00HZye1jZhaD7+fwG0=;
        b=Pb4K4jKDm5RMd+yEKqlyEJ2b2VxSbbqMKQ8gxdd93u8aNa1eGIbJ7CiF9cw7jq0BuE
         YecMadkBrSkmq4b/v9qhOpEdpfSJsLYaa2FjsFWlFfMPKOyiEW/8IdaV9yn9ua4RDI0i
         +rlN2kooH0V/LQuhjjY3UAH4kAxIMjxyU9mRCH4CLgAoxlf6wORqv/WxR8tVuRRjB0ei
         C9a1eyxzeu+VYmNmgzIS2SnohBgY+KengSqHftcrPL0M8UTJb19fE9CLTpTot3aRm3Q3
         mRJUm5s6uA1jYLXzmu6ba3tuXA0xZ/y8+ls1SjIX5kW+b0t4q8cwcLjhs/KfJEvfeLFf
         TJRw==
X-Gm-Message-State: AOAM533ahUKED51vIuicf1kHFPag7f3t9Qvm5nUn3SkFaHTYtOQxbJTM
        s/jCQL8GGI6TnChjBObiISJTbk9z0VfODA==
X-Google-Smtp-Source: ABdhPJyA6Bkkee9tMmqVm04QTeNLd1VTkADbwXeyNCvzZUo+Yt4isdtG/dJ8gbzxcgGVCz2xYzgIQw==
X-Received: by 2002:a67:f852:0:b0:314:a25f:c5f with SMTP id b18-20020a67f852000000b00314a25f0c5fmr9013973vsp.73.1645517988712;
        Tue, 22 Feb 2022 00:19:48 -0800 (PST)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id u16sm6941621vsi.2.2022.02.22.00.19.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 00:19:48 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id e5so20218850vsg.12;
        Tue, 22 Feb 2022 00:19:48 -0800 (PST)
X-Received: by 2002:a67:b00e:0:b0:30d:dc98:6024 with SMTP id
 z14-20020a67b00e000000b0030ddc986024mr10305449vse.57.1645517987754; Tue, 22
 Feb 2022 00:19:47 -0800 (PST)
MIME-Version: 1.0
References: <1f39432b-84e2-e6dc-a6b8-c48ad5cf2210@gmail.com> <3facc242-0ce6-9170-1fee-a5ec0a66660a@gmail.com>
In-Reply-To: <3facc242-0ce6-9170-1fee-a5ec0a66660a@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 22 Feb 2022 09:19:36 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUnDQKtGuN+n-t3P8e4nf9VLB+9q8fGyCh643T4Y1Knag@mail.gmail.com>
Message-ID: <CAMuHMdUnDQKtGuN+n-t3P8e4nf9VLB+9q8fGyCh643T4Y1Knag@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] auxdisplay: add support for Titanmec TM1628 7
 segment display controller
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Heiner,

On Mon, Feb 21, 2022 at 9:26 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
> This patch adds support for the Titanmec TM1628 7 segment display
> controller. It's based on previous RFC work from Andreas Färber.
> The RFC version placed the driver in the LED subsystem, but this was
> NAK'ed by the LED maintainer. Therefore I moved the driver to
> /drivers/auxdisplay what seems most reasonable to me.
>
> Further changes to the RFC version:
> - Driver can be built also w/o LED class support, for displays that
>   don't have any symbols to be exposed as LED's.
> - Simplified the code and rewrote a lot of it.
> - Driver is now kind of a MVP, but functionality should be sufficient
>   for most use cases.
> - Use the existing 7 segment support in uapi/linux/map_to_7segment.h
>   as suggested by Geert Uytterhoeven.
>
> Note: There's a number of chips from other manufacturers that are
>       almost identical, e.g. FD628, SM1628. Only difference I saw so
>       far is that they partially support other display modes.
>       TM1628: 6x12, 7x11
>       SM1628C: 4x13, 5x12, 6x11, 7x10
>       For typical displays on devices using these chips this
>       difference shouldn't matter.
>
> Successfully tested on a TX3 Mini TV box that has an SM1628C and a
> display with 4 digits and 7 symbols.
>
> Tested-by: Christian Hewitt <christianshewitt@gmail.com>
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/auxdisplay/tm1628.c

> +static int tm1628_show_text(struct tm1628 *s)
> +{
> +       static SEG7_CONVERSION_MAP(map_seg7, MAP_ASCII7SEG_ALPHANUM);

This mapping can not be overridden by the user.  Is there any
specific reason you didn't make the mapping configurable from sysfs,
cfr. map_seg7_{show,store}() in include/uapi/linux/map_to_7segment.h?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
