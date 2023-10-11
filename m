Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A2C7C56AB
	for <lists+linux-spi@lfdr.de>; Wed, 11 Oct 2023 16:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbjJKOVy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Oct 2023 10:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbjJKOVx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Oct 2023 10:21:53 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAC594
        for <linux-spi@vger.kernel.org>; Wed, 11 Oct 2023 07:21:51 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-4a06fb5331bso1765698e0c.0
        for <linux-spi@vger.kernel.org>; Wed, 11 Oct 2023 07:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697034110; x=1697638910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XiBaX2TqUvTbj5wkDIil5VnOSe22zVgH7ek2DB7rIck=;
        b=BshUQzXuorFbyaypct1b3NVCZbJo35Z7sXP3v85fdlBgL303Xlz+nZOMmSaFf4KSP0
         dwZxn5c77qBpGA8AkSvV43ISUnIXa1p8INqc4nMjbgsN2Lk7RcDRsuwCWA5tH5qQX4f1
         CZaA8aYD8m8eEP3JnDo168tIXcoR5VIuwlIq6/s99WQJDwLdrtK9MR0FlMMT+DAhwCns
         KZEEUXy3IOEk1hfz2t6A4+qrzGO/HoWAkSlEnYR4BNIA/lM0mfTgfPVH2hbQq6b8SlZi
         sgD6AgaZifxmrzORJndui2RgLQUiwpRVJmCW+0iXx9S4hxyIaENO4y8zTkJreT4TKKbV
         6Vwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697034110; x=1697638910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XiBaX2TqUvTbj5wkDIil5VnOSe22zVgH7ek2DB7rIck=;
        b=pBEUNuNU3Y+/DNc8qR8p0ar0s98WRdeiE/EbiHQNhDUVsn81VCCY/hiYfd9IORdWGR
         uGfmgn3AnktrBQJ9isa0U02KIhtqvX7FszctSgHtgtfyg/Arv4ZQS+yDv3ON79PXprsp
         deXTaeLGg9mekOW2fk4Jcg1PsyNsaOPnNgEVfxfGKpAXDRds9Ihg9QnDB1746TJPXf0C
         2K5jWyywtpDJ5qopSWtDU0RZheRkF2r6OOESOYRHevBovssLrDfIbvjs4JNXhmPMLa1C
         M1LwOB0xjSvyh4Dt3bA9gUJOyp0fph1dprh1gjZUK1DWUCk+0ctZduunjxw0GRFBctbi
         rcaw==
X-Gm-Message-State: AOJu0YwJsdomtPt76P2bgHPgHE+FBCc/99UNLlkbk6pDHXj8m6aHnhll
        ApTNB4+TPf0IbveLUzZFpR/rF4vRbo1/CeiyMU8g+g==
X-Google-Smtp-Source: AGHT+IENa5Kj8B8iGxM1cvH1JGwfG8NPGYjZ61KooMljJWwbckAx6atfjzUxdWTdEOyTIL9RTCxfnz11RHelb5Y3its=
X-Received: by 2002:a1f:cbc5:0:b0:49b:adce:e2d1 with SMTP id
 b188-20020a1fcbc5000000b0049badcee2d1mr17554689vkg.10.1697034110430; Wed, 11
 Oct 2023 07:21:50 -0700 (PDT)
MIME-Version: 1.0
References: <20231011-pxa-gpio-v8-0-eed08a0fcac8@skole.hr> <20231011-pxa-gpio-v8-2-eed08a0fcac8@skole.hr>
In-Reply-To: <20231011-pxa-gpio-v8-2-eed08a0fcac8@skole.hr>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 11 Oct 2023 16:21:39 +0200
Message-ID: <CAMRc=McWj1RHw-um2OcCpkToxXg6R63vLGTGfMTFiMSr4WXkJg@mail.gmail.com>
Subject: Re: [PATCH RFT v8 2/6] ARM: pxa: Convert Spitz LEDs to GPIO descriptors
To:     =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Oct 11, 2023 at 3:24=E2=80=AFPM Duje Mihanovi=C4=87 <duje.mihanovic=
@skole.hr> wrote:
>
> Sharp's Spitz board still uses the legacy GPIO interface for configuring
> its two onboard LEDs.
>
> Convert them to use the GPIO descriptor interface.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>
> ---
>  arch/arm/mach-pxa/spitz.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
> index 535e2b2e997b..9efd603c715a 100644
> --- a/arch/arm/mach-pxa/spitz.c
> +++ b/arch/arm/mach-pxa/spitz.c
> @@ -452,16 +452,25 @@ static inline void spitz_keys_init(void) {}
>   * LEDs
>   ***********************************************************************=
*******/
>  #if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
> +static struct gpiod_lookup_table spitz_led_gpio_table =3D {
> +       .dev_id =3D "leds-gpio",
> +       .table =3D {
> +               GPIO_LOOKUP_IDX("pxa-gpio", SPITZ_GPIO_LED_ORANGE, NULL, =
0,
> +                               GPIO_ACTIVE_HIGH),
> +               GPIO_LOOKUP_IDX("pxa-gpio", SPITZ_GPIO_LED_GREEN, NULL, 1=
,
> +                               GPIO_ACTIVE_HIGH),
> +               { }
> +       }
> +};
> +
>  static struct gpio_led spitz_gpio_leds[] =3D {
>         {
>                 .name                   =3D "spitz:amber:charge",
>                 .default_trigger        =3D "sharpsl-charge",
> -               .gpio                   =3D SPITZ_GPIO_LED_ORANGE,
>         },
>         {
>                 .name                   =3D "spitz:green:hddactivity",
>                 .default_trigger        =3D "disk-activity",
> -               .gpio                   =3D SPITZ_GPIO_LED_GREEN,
>         },
>  };
>
> @@ -480,6 +489,7 @@ static struct platform_device spitz_led_device =3D {
>
>  static void __init spitz_leds_init(void)
>  {
> +       gpiod_add_lookup_table(&spitz_led_gpio_table);
>         platform_device_register(&spitz_led_device);
>  }
>  #else
>
> --
> 2.42.0
>
>

Which driver consumes these GPIOs? Doesn't it need any conversion?

Bart
