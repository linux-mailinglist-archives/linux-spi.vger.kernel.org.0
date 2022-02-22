Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBA74BF36E
	for <lists+linux-spi@lfdr.de>; Tue, 22 Feb 2022 09:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiBVIVd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Feb 2022 03:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiBVIVb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Feb 2022 03:21:31 -0500
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F4F156951;
        Tue, 22 Feb 2022 00:21:07 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id t22so20268253vsa.4;
        Tue, 22 Feb 2022 00:21:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Iibz2Vns+LJDKpZPsrx7qvXHxNx3zZSDgqwS8dqEaL8=;
        b=TNlerSWNwj9hnikkV1VEqJbUXXAqrRa9VOEncUIIO+17m5JeEzJ/9fod/MS0YOK7dd
         p1A9Zg7Ft37KRIUj/C+N4K4KFRO0vlKio1Pis72GMZoWWHi6BTmyJsnfWNnZO/Z0Xs+T
         598XKhgUvzxoVgl8x/Q+KZpVWLw1jJwTHWRrJZboHC5pECKHn0U9m11RCg8oM2ejXxLY
         SYzHZG5E+ueuZSkH/lP8wmIBn6LTyvYjqhPD+aOpvGtgn5kACpOsw4w6jSZmGS4yV6Jm
         myX12OU+CVRzcZK+uy2x1b8yWhA4X9PEwMotPrvWTVGVcnAZcPfCmxRPLJmvFVIfe9LZ
         2f4A==
X-Gm-Message-State: AOAM532WJ3prsmqFeViD9nILwF58Q8DvysedPwS3AtgB/vd/H5yqT7sn
        Yd32Ojuqw1L7i7VcZXD67c/uCcubmpW/Kw==
X-Google-Smtp-Source: ABdhPJyLfobZYAo/QGx05u85ph8doiYsLxSAPG0W7MZ7NRtqS+rTzrHTvsmzACnWWoEzsi0FJltNnA==
X-Received: by 2002:a67:ca02:0:b0:31b:70d7:a97c with SMTP id z2-20020a67ca02000000b0031b70d7a97cmr8857190vsk.75.1645518066384;
        Tue, 22 Feb 2022 00:21:06 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id 4sm9093203vkx.4.2022.02.22.00.21.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 00:21:06 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id 102so7027122uag.6;
        Tue, 22 Feb 2022 00:21:05 -0800 (PST)
X-Received: by 2002:a9f:360f:0:b0:341:8a12:8218 with SMTP id
 r15-20020a9f360f000000b003418a128218mr7903751uad.14.1645518065535; Tue, 22
 Feb 2022 00:21:05 -0800 (PST)
MIME-Version: 1.0
References: <1f39432b-84e2-e6dc-a6b8-c48ad5cf2210@gmail.com> <94ceeca1-3123-fc4b-8cc9-a86e9ad08863@gmail.com>
In-Reply-To: <94ceeca1-3123-fc4b-8cc9-a86e9ad08863@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 22 Feb 2022 09:20:54 +0100
X-Gmail-Original-Message-ID: <CAMuHMdURgGu8jOHfCSvMHSzPTD26yKnG-=+Jp2yyCH5PyWW-Bw@mail.gmail.com>
Message-ID: <CAMuHMdURgGu8jOHfCSvMHSzPTD26yKnG-=+Jp2yyCH5PyWW-Bw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] docs: ABI: document tm1628 attribute display-text
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
> Document the attribute for reading / writing the text to be displayed on
> the 7 segment display.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-devices-auxdisplay-tm1628
> @@ -0,0 +1,7 @@
> +What:          /sys/devices/.../display-text
> +Date:          February 2022
> +Contact:       Heiner Kallweit <hkallweit1@gmail.com>
> +Description:
> +               The text to be displayed on the 7 segment display.
> +               Any printable character is allowed as input, but some
> +               can not be displayed in a readable way with 7 segments.

Hence you may want to make the mapping configurable, cfr.
MAP_TO_SEG7_SYSFS_FILE in include/uapi/linux/map_to_7segment.h?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
