Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D217C4C72
	for <lists+linux-spi@lfdr.de>; Wed, 11 Oct 2023 09:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjJKH72 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Oct 2023 03:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjJKH71 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Oct 2023 03:59:27 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300EF9B
        for <linux-spi@vger.kernel.org>; Wed, 11 Oct 2023 00:59:26 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-45289a987ddso2375290137.0
        for <linux-spi@vger.kernel.org>; Wed, 11 Oct 2023 00:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697011165; x=1697615965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4T+G3IiEpAugHoIlaD3hRukPzEGsZANvnqJPVq5ffG8=;
        b=jtSdGqV2QaB1dOZo3W8RC2BtHpnoWBXPFoZBsrbiBrX+lRAozmlcb3QzUwCgAUIVk6
         ELN119v7dd4ks9xxLOu9cTvqgzOt9DWwTEzjsgCGtvHRKY6c2t3UQvmKBLb24ty4q0vh
         NTPbPVe8ciCe+LA2FlYgSTIW6BFZLA9wTUl+//dDA14PSdxc9S24vx9qrovAHpwZD5/y
         GLEwzIdjZqOdk7Ukz51ZHO41UVP7CcxfPQhbefK9ViUlO5eLaUNFkKIvcNMsOgECxKsh
         w8EeLSLrq+zytqqyPzsrqU4c99R4uku5BwHZLtiWcYCzuFHsOSFI6MqfsPicfUdROCSr
         GfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697011165; x=1697615965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4T+G3IiEpAugHoIlaD3hRukPzEGsZANvnqJPVq5ffG8=;
        b=udRUSalmiONKpOUSZt2pr047UWUlANsRkrTrWDq6AKJmw7iNLKQPkjd1c9vM2wUWBA
         dEKitnwScIP6CR1ck12+6LnK0rnlVewg8ZxG7OtV9gjtDObkDGgkCH0ro38jp7NJlGG9
         zW/VMP+cr9D0PCmgY85yLtVoYbIe1HxmLmVG6JtlxncZ266mZrKacLMyC870BtP5ERAN
         ri2WEW8Js0FNrrXQZ3GXadY2vx7X4EDz25JybyBBsSgtzQ7YguwJqhgMbeCM0PIAeqHw
         t48mzUcbOi6dmB0zydFKdHTyo4CF78f0ot7Zs110/8AuVea9866IUY5tpidO0r7CA/oe
         kVSA==
X-Gm-Message-State: AOJu0YwYboeWU4m7R00dONmYztSzYKyNO9wSHdwm82gxmGQhmgGi0dX0
        AXO5V3Tfd8OPyG2rUHDrVaVCvCCPOn+l/5cTOf5SBA==
X-Google-Smtp-Source: AGHT+IEUbJzy5iOn2Ns9Aln42pFrnXXQ7IdE1abA3Z4713vj8tR+ayKZo6qJyvwJCRhJxXfDbVJASyLhzCqOOBRnH/o=
X-Received: by 2002:a67:f950:0:b0:44e:8c20:a92d with SMTP id
 u16-20020a67f950000000b0044e8c20a92dmr14800228vsq.7.1697011165108; Wed, 11
 Oct 2023 00:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231009-pxa-gpio-v7-0-c8f5f403e856@skole.hr> <20231009-pxa-gpio-v7-2-c8f5f403e856@skole.hr>
 <CAMRc=Mc7=E9bMQgiUM8qqk7UD4+exhJZqw2DucTcsnqHcttR3Q@mail.gmail.com>
 <12313687.O9o76ZdvQC@radijator> <CAMRc=MdWYNmBkJ6Nw6V_FzJKQw--g02tjLSztMYW_atNhisVpw@mail.gmail.com>
 <CACRpkda4ZeQ8eYKqXBR7XmWj9jJF58C+PLeRWqx2m7aSf2FWQw@mail.gmail.com>
In-Reply-To: <CACRpkda4ZeQ8eYKqXBR7XmWj9jJF58C+PLeRWqx2m7aSf2FWQw@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 11 Oct 2023 09:59:14 +0200
Message-ID: <CAMRc=Mc6ww7Te+JvzW_=+X9Tj_jjKnQaVRJMKgU4zTuXViPxcg@mail.gmail.com>
Subject: Re: [PATCH RFT v7 2/6] ARM: pxa: Convert Spitz LEDs to GPIO descriptors
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Oct 10, 2023 at 10:04=E2=80=AFPM Linus Walleij <linus.walleij@linar=
o.org> wrote:
>
> On Tue, Oct 10, 2023 at 7:39=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
>
> > It doesn't seem like anyone is using these GPIOs once they're
> > requested? Wouldn't the above definitios be analogous to:
> >
> > GPIO_HOG("pxa-gpio", SPITZ_GPIO_LED_ORANGE, NULL, GPIO_ACTIVE_HIGH, GPI=
OD_ASIS)
> > GPIO_HOG("pxa-gpio", SPITZ_GPIO_LED_GREEN, NULL, GPIO_ACTIVE_HIGH, GPIO=
D_ASIS)
>
> They are used:
> +       spitz_gpio_leds[0].gpiod =3D leds->desc[0];
> +       spitz_gpio_leds[1].gpiod =3D leds->desc[1];
>
> The descriptors are passed to the leds-gpio driver.
>
> But wait: no.
>
> This whole thing:
>
> +static struct gpio_descs *leds;
> +
> (...)
> +       leds =3D gpiod_get_array_optional(&spitz_led_device.dev,
> +                       NULL, GPIOD_ASIS);
> +       spitz_gpio_leds[0].gpiod =3D leds->desc[0];
> +       spitz_gpio_leds[1].gpiod =3D leds->desc[1];
>
> Just delete all that.
>
> The leds-gpio driver will request and use the lines.
>
> It was just so unorthodox that I missed it. Adding the descriptor
> table is enough.

Ah, good catch. Your suggestion is of course the correct one.

Bart

>
> Yours,
> Linus Walleij
