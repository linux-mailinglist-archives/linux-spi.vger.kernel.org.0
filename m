Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068C77BBDB0
	for <lists+linux-spi@lfdr.de>; Fri,  6 Oct 2023 19:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjJFRZr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Oct 2023 13:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbjJFRZq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 6 Oct 2023 13:25:46 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A1FC6
        for <linux-spi@vger.kernel.org>; Fri,  6 Oct 2023 10:25:44 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-7ab9488f2f0so986020241.3
        for <linux-spi@vger.kernel.org>; Fri, 06 Oct 2023 10:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696613143; x=1697217943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dfqdpiaz02xN8PLTPu9pWuaYxQEaAnQY6icekWcwU9s=;
        b=kdO3qI33aPBkfgeK5AxV6UIAGYQ1iYuJR54B9k5s+ZHkyFeEDCgfxeh7hdbtm6iygD
         Y/t23b7Fypy9mm8aZmDVgP17hKL0pqqgOLPsPc+GMJ2NFfZhY+e4YwvmuimYUA/pXG0f
         LXlTZJaE31a6+z2D0yI/DKpdF++j1fY9+QJv5U5zD7/uaA9ym24Zc11/fk/mhyQlWrpb
         Y6CXx+HrmdIDYfrTxdGvo8mX+g7sLV1nOaXru2XUDMFrV338/278UqQq4reprYiyVtHv
         WV/AKa12opu6HcQYsVH7w976I2dzt9YSwcJWklKJpI0BOkxFsZMVpQNm8iOOiVDUNFbL
         eziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696613143; x=1697217943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dfqdpiaz02xN8PLTPu9pWuaYxQEaAnQY6icekWcwU9s=;
        b=in23+GGP4dw5pax+kS79zZQnwsXxpFjYS24KpuHrPtyvHw9Sgeamg1Gj/eaYmIYUGN
         kYK4hwzzAWArpldTBzO81B7u+2mejFRjCGZWe1MetHeNCIovsH2wCLKqPRig8aQ9lx+P
         4sYb7R6V1TOby0mFqIkJpFTa00UbghjHIwW5LE1gZ27WaI43ycLmVdEetkRJW6elFfPT
         o/HVHdCsmUUhbIQvJ4V5ootR4TpRV9hcOxjFKaWH0VhkwTHFXwLU1+3FRDMINVZBMrl5
         YuAuQjg/ieIgXl5L96iQrc0oqZndd8Xk1Rzrzp3qcIo8XEVzQhhvQslNivseOUg2KfZh
         aSuw==
X-Gm-Message-State: AOJu0YwJ0UK1Piy2ecQWZMqTcGnaM83uEcLDvJnpBBDWP52lTbqZPWg2
        QdBoXSELlqNzMCOcBQ8T7thS2rFvCLx5kmM5FgL7QQ==
X-Google-Smtp-Source: AGHT+IFAfquioQvCUi1yrJicx4juipJtkOOWOyEzXNLtXeXDDfkDZKDvRvHpEr2iQgkuqnzhVnkDvAAn+uh8ePAxBsg=
X-Received: by 2002:a1f:4cc7:0:b0:493:7c76:bbac with SMTP id
 z190-20020a1f4cc7000000b004937c76bbacmr7557435vka.2.1696613143171; Fri, 06
 Oct 2023 10:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <20231006-pxa-gpio-v6-0-981b4910d599@skole.hr> <20231006-pxa-gpio-v6-2-981b4910d599@skole.hr>
In-Reply-To: <20231006-pxa-gpio-v6-2-981b4910d599@skole.hr>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 6 Oct 2023 19:25:32 +0200
Message-ID: <CAMRc=McaMx-pNb__8BhU7zj9D=3FERm0BzSbQebS+BQew=ZTbA@mail.gmail.com>
Subject: Re: [PATCH RFT v6 2/6] ARM: pxa: Convert Spitz LEDs to GPIO descriptors
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
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Oct 6, 2023 at 3:45=E2=80=AFPM Duje Mihanovi=C4=87 <duje.mihanovic@=
skole.hr> wrote:
>
> Sharp's Spitz board still uses the legacy GPIO interface for configuring
> its two onboard LEDs.
>
> Convert them to use the GPIO descriptor interface.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>
> ---
>  arch/arm/mach-pxa/spitz.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
> index 535e2b2e997b..1fb4102ea39e 100644
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
> @@ -480,7 +489,14 @@ static struct platform_device spitz_led_device =3D {
>
>  static void __init spitz_leds_init(void)
>  {
> +       struct gpio_descs *leds;

This should be global, otherwise KASAN will complain.

Bart

> +
> +       gpiod_add_lookup_table(&spitz_led_gpio_table);
>         platform_device_register(&spitz_led_device);
> +       leds =3D gpiod_get_array_optional(&spitz_led_device.dev,
> +                       NULL, GPIOD_ASIS);
> +       spitz_gpio_leds[0].gpiod =3D leds->desc[0];
> +       spitz_gpio_leds[1].gpiod =3D leds->desc[1];
>  }
>  #else
>  static inline void spitz_leds_init(void) {}
>
> --
> 2.42.0
>
>
