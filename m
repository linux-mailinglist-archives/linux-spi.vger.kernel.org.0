Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4EF94C1D27
	for <lists+linux-spi@lfdr.de>; Wed, 23 Feb 2022 21:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241216AbiBWU2p (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Feb 2022 15:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240361AbiBWU2o (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 23 Feb 2022 15:28:44 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713214D63E;
        Wed, 23 Feb 2022 12:28:16 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id d62so194014iog.13;
        Wed, 23 Feb 2022 12:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=j3u+xo/IEURdRuin0oiVWN0xAJWJDqfhSkcI9D3SfbI=;
        b=HbEIXELccuOf0hWVOgXBf/snUQeXov/yYyjP2y/iHQ1N8apQnriYHgb1QiDBCRjucB
         GFA1t85Aer1wIUGOFXAPvtAmhlxBWB0xgpkk21J9b2dz+QAFk2e2BgDDyz8va5phPiuX
         wVAgGAEIrYi9HkLGRNr/Ttsc4nCSrxZWRZY9Dijt94m59kJFy1xrgFriprUcxnAQG3Cb
         DrMoIRMeriV+iic5UYI/Z2rf248LdxDKF+kZ2S4oBD80JEOMH4bP7vZZjJ4jLtvzyCFP
         f2OBsAsTCoSwAZNuJsxC0cpSLu1A0hCqprC2++26DQ1GD+LHcUx5Z/KvePQwLIdVMnB8
         PlTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j3u+xo/IEURdRuin0oiVWN0xAJWJDqfhSkcI9D3SfbI=;
        b=ObNZYI/EwiHubX37TC5I0i78AjaJrk+sZEM6dgh87bA2GPT0ewCmIQY7xdCRZ83J8V
         zT5Qy3y/tbD/nnOzmHfDMaJ4f8G+eI2ZFn4tYUMJwhXD7qgo/jk6atmcMoYkt/+EVIUN
         K/YMMRGSmek6eszer0gpsbjGefXnF3ywbdIXh0OUzO0fDllNkHfvCMIKz6Bbg0gmZgMH
         8k2/EVjISp66E1HpYT+BUExqxWqbqGR689CiWZNr0bezzbJCjerFqvP4NrojkkV8P4tv
         40Hj6L/7+kEYbuip8J+tXQEMYnm08dpoDxFaVMS6sjpF0z7Lx9Sjfz6mysCGbpWEwmUZ
         9L0g==
X-Gm-Message-State: AOAM533cKy2p4V6kuTh74dSTitCeFXNwVGGpT3VO+anTgde9KspgnFUd
        3VRK614WX58fhGvdvUp+Bybb2Fg7kTz7DedHfGM=
X-Google-Smtp-Source: ABdhPJxDbCKBFfm9B/Fyen9WfJDQ4/pWumus5ny8gK7Ns5ZEcNWZuqum9MH+JjV6MrvcXvPBGWuuoR+i6zvcIt8dD0c=
X-Received: by 2002:a05:6638:204d:b0:314:a290:48c with SMTP id
 t13-20020a056638204d00b00314a290048cmr1124167jaj.264.1645648095765; Wed, 23
 Feb 2022 12:28:15 -0800 (PST)
MIME-Version: 1.0
References: <4eb7b036-a9b9-3bd2-4e84-f56ba4b1a740@gmail.com> <944317db-b659-cb36-addf-c33623a4ff60@gmail.com>
In-Reply-To: <944317db-b659-cb36-addf-c33623a4ff60@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 23 Feb 2022 21:28:04 +0100
Message-ID: <CANiq72kdeuJhaEUOBAB3uYm9SA4Wm0U5=DNgxFMxiGDacUgaBA@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] auxdisplay: add support for Titanmec TM1628 7
 segment display controller
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Feb 23, 2022 at 7:02 PM Heiner Kallweit <hkallweit1@gmail.com> wrot=
e:
>
> Co-Developed-by: Heiner Kallweit <hkallweit1@gmail.com>

If you (Heiner) are going to be the "From" author, then this line
should not be here.

> +         Say Y to enable support for Titan Micro Electronics TM1628
> +         LED controller.
> +         It's a 3-wire SPI device controlling a two-dimensional grid of
> +         LEDs. Dimming is applied to all outputs through an internal PWM=
.

Maybe a newline between paragraphs?

> + * Copyright (c) 2019 Andreas F=C3=A4rber

...here: should there be entries for you (Heiner) too? If not, should
Andreas be the "From" author?

This also applies to the `MODULE_AUTHOR`.

Also it may be a good idea to add the emails:

    MODULE_AUTHOR("Andreas F=C3=A4rber <afaerber@suse.de>");
    MODULE_AUTHOR("Heiner Kallweit <hkallweit1@gmail.com>");

(You may also want to consider adding an entry on `MAINTAINERS`).

> +       u8 cmd =3D TM1628_CMD_DISPLAY_MODE | grid_mode;

Consider using `const` for some of the variables.

> +       for (i =3D 0; i < s->grid_size; i++) {
> +               int pos =3D s->grid[i] - 1;
> +
> +               if (i < msg_len) {

Consider inverting the condition, doing the set to `0` + `continue;`
to avoid the indentation.

> +       struct tm1628_led *led =3D container_of(led_cdev, struct tm1628_l=
ed, leddev);
> +       struct tm1628 *s =3D led->ctrl;
> +       int offset;
> +       __le16 bit;

Style: sometimes the variables are initialized right away using a
value from above, but other times they are done below.

> +       if (count > s->grid_size + 1) /* consider trailing newline */

Style: sometimes comments are trailing the line, others are above.
Also, sometimes they start with uppercase, but in other cases they do
not.

Also, about the `+ 1`: is it possible that sysfs gives us a buffer
full of `isprint()`? i.e. is it possible that `grid_size =3D=3D
MAX_GRID_SIZE` and `count =3D=3D MAX_GRID_SIZE + 1` and then we perform an
out-of-bounds store to `MAX_GRID_SIZE + 2` in `text`?

> +       ret =3D tm1628_write_data(spi, 0, MAX_GRID_SIZE);
> +       if (ret)
> +               return ret;
> +       /* Assume that subsequent SPI transfers will be ok if first was o=
k */

If not, is there a consequence? i.e. why wouldn't one check and fail
similarly in the `tm1628_set_*` calls below?

> +       if (!IS_REACHABLE(CONFIG_LEDS_CLASS))
> +               goto no_leds;

What about putting the code in the `if` body (negating the condition)?

> +       num_leds =3D 0;

This is reusing the variable for a different purpose, no? i.e. if we
did not get here, we would have no leds, yet we would report the
number above.

> +       device_for_each_child_node(&spi->dev, child) {
> +               u32 reg[2];
> +
> +               ret =3D fwnode_property_read_u32_array(child, "reg", reg,=
 2);
> +               if (ret) {
> +                       dev_err(&spi->dev, "Reading %s reg property faile=
d (%d)\n",
> +                               fwnode_get_name(child), ret);

Is a failure expected? i.e. this `continue;`s, but should it fail or
is it OK to proceed?

> +       for (i =3D 0; i < 7; i++) {

Maybe a `#define` for several of the `7`s around?

> +static void tm1628_spi_remove(struct spi_device *spi)

Doesn't `.remove` return `int`?

Thanks!

Cheers,
Miguel
