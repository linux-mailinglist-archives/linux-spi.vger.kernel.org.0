Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22230445153
	for <lists+linux-spi@lfdr.de>; Thu,  4 Nov 2021 10:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhKDJx1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Nov 2021 05:53:27 -0400
Received: from mail-ua1-f44.google.com ([209.85.222.44]:35452 "EHLO
        mail-ua1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhKDJx1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 4 Nov 2021 05:53:27 -0400
Received: by mail-ua1-f44.google.com with SMTP id q13so9737447uaq.2
        for <linux-spi@vger.kernel.org>; Thu, 04 Nov 2021 02:50:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DvrgzexrAWiKEQ/sh1DQ7K1/uu8pN8mjg143IBw/9hM=;
        b=1oc5h8nWQGvaPMtMZAxlfOCM+7+W1WUuTPDBpS95xOpEEnpU8Gamvc09Pz/lwSxk1V
         tsj3X7yle2jrIF8b2IgkDPw3KYE1obyk6+3TYFbno6L7QNiGfrsaXxJsHOu2SUlabsDl
         z6B4pSr/K2P0j1h+1aX+QNeR94ZdA70V1wlt2TMVfnld8oS+lCVpZSjLw05cIsvQoIjb
         6llZwh8DrGbRYhDDknEg9DAxi0sdghWOyGNRFzNBKmpEjIGaHmk9Gj74Dk26Zr/cNxRZ
         iNA1Rj1MpZO2/O/dBe5LZmgHxZPsqyM8ec1E44otSMNjE16GGZpNAN/702FutIRBi7S+
         CGzg==
X-Gm-Message-State: AOAM532xdeTPcFBgO8mydJruUoQzuaYvyazUT3Ei0P1tFYMv7cQX/qGV
        hWBVoJs9lzak82bFuOxIYcg/t1oJ5nN71A==
X-Google-Smtp-Source: ABdhPJxrQIVdqSTJXS8iXScaKIvAJIvSDmiK2TyGd/8wOw/EgCShSYyQSow9VwY1dcmHe0gGlij40Q==
X-Received: by 2002:ab0:4324:: with SMTP id k33mr10432208uak.43.1636019448846;
        Thu, 04 Nov 2021 02:50:48 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id i27sm683327uab.8.2021.11.04.02.50.48
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 02:50:48 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id b17so9851262uas.0
        for <linux-spi@vger.kernel.org>; Thu, 04 Nov 2021 02:50:48 -0700 (PDT)
X-Received: by 2002:a67:cb0a:: with SMTP id b10mr59465968vsl.9.1636019448583;
 Thu, 04 Nov 2021 02:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAETHaKpiZEWHUrKtNw+W3XHAPUA4h=OC=RL4Jbcs94o1MgDj6w@mail.gmail.com>
In-Reply-To: <CAETHaKpiZEWHUrKtNw+W3XHAPUA4h=OC=RL4Jbcs94o1MgDj6w@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 4 Nov 2021 10:50:37 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXwYH2n+C5AEzhCjtH+eX5mBFH=cB1hYAy-XYtPYRn9jw@mail.gmail.com>
Message-ID: <CAMuHMdXwYH2n+C5AEzhCjtH+eX5mBFH=cB1hYAy-XYtPYRn9jw@mail.gmail.com>
Subject: Re: spi-ar934x: Using GPIO CS issue
To:     Dave Bender <codehero@gmail.com>
Cc:     linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Dave.

On Tue, Nov 2, 2021 at 11:31 PM Dave Bender <codehero@gmail.com> wrote:
> Under the mach-* era of configuring boards, I was able to use a second
> SPI NOR flash with a GPIO chip select, as in:
>
> static struct spi_board_info spi_info[] = {
>        { ... },
>        {
>                .bus_num        = 0,
>                .chip_select    = 1,
>                .max_speed_hz   = 25000000,
>                .modalias       = "m25p80",
>        },
> };
>
> static int cs_gpios[2] = {
>        -ENOENT,
>        11,
> };
>
> static struct ath79_spi_platform_data mtriq_spi_data __initdata = {
>        .bus_num = 0
>        ,.num_chipselect = 2
>        ,.cs_gpios = cs_gpios
> };
>
> static void __init board_setup(){
>  ath79_register_spi(&spi_data, spi_info, 2);
> }
>
>
> However, under the new dts regime, I try to use a CS gpio but cannot
> communicate successfully to the chip:
>
> &spi {
>     status = "okay";
>     cs-gpios = <0>,<&gpio 11 GPIO_ACTIVE_LOW>;
>
>     flash@1 {
>     compatible = "jedec,spi-nor";
>     spi-max-frequency = <25000000>;
>     reg = <1>;
>   };
> };
>
> Am I missing something here?

Does it work if you change GPIO_ACTIVE_LOW to GPIO_ACTIVE_HIGH?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
