Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD79E3A506D
	for <lists+linux-spi@lfdr.de>; Sat, 12 Jun 2021 21:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhFLT7S (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 12 Jun 2021 15:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhFLT7R (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 12 Jun 2021 15:59:17 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C82C061574;
        Sat, 12 Jun 2021 12:57:15 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id ba2so39402483edb.2;
        Sat, 12 Jun 2021 12:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WSj8sdVPyKuxqNwS3c3vPrlyByndx0A90jNoxNm4rgo=;
        b=GC1hmd8ySwPKOkt4hn5tx3fLwsrr9R3+Qm4G6sv4gGygeg+0Dhg6af8fICb1ZmQP1k
         uTXPQK7dKx58Wp5ggJFZqrCvUUdCyqS4QyakTML8TPaEDTlGkraKktC6FGgllLJ3SR8I
         E/OUnJ9zyPYOZlUmzgFfOUq/5X5eVeFLWrKIc3CNDxjVXvF3MtqgfK3GDOaZXbfx6QJw
         Ar0RCIwrIEF0msoF5VxfqeK/kWdk6krcirVHox8gM77HkdMPxslAA6TyQZmk25a0gL/P
         HqOJLDuOvRAnBQQ6VvXE1zR1u3Z1OW3Lgl+KAI30fv2xwPinvJQHx19H4Nh5hBON9lUr
         Bs2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WSj8sdVPyKuxqNwS3c3vPrlyByndx0A90jNoxNm4rgo=;
        b=jvfjj0m1Vtgh/Dhmo0SzU6CCKBH5oNzBy8nTcY8EfkjN/vvwX7sYDtm6JEparhi8pC
         +b41JvuXRKpr8zZRknAkFp+SbLHankM7SpljsljXl2pWuEl38YLRyyUPAvlzSlFiDoaf
         f0HpkMrFFll892qw8vUsusZDzpmUtShmQWlIXK9r5Ci6DMXiDsx3WJmdh7LZEDufAZ7H
         PGL9Rq3X2lLRF8FjaekEVyBPToyTbZMqapYW6P4GxBwrdCugQpXEIvRExXCal/fYl7uj
         22ir0Y5VBIr8anUHQKt1YLTvQo5+q4uBUPw2pmSN84W+ruti2mqbx3QI+QzIooquc51c
         mJtg==
X-Gm-Message-State: AOAM533pw0UNrgsbSrbGCbbNZ8zn8OCyAd/36dVSEeu0xV8UJ3eTxA+c
        NF+AqEuctZOSsxU0UHQ4FJTBINA9dGQhjAq3JnU=
X-Google-Smtp-Source: ABdhPJyQ1rVkc5IS67yf2pkZ/ig/vjDgV0kX82JL4WLFRGOyGy3xYGgZburqRcQ4ka6TN5yZTv0fO+gybh2vO9+/3K4=
X-Received: by 2002:a05:6402:220d:: with SMTP id cq13mr1655691edb.52.1623527834127;
 Sat, 12 Jun 2021 12:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <1623248538-4352-1-git-send-email-zpershuai@gmail.com>
In-Reply-To: <1623248538-4352-1-git-send-email-zpershuai@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 12 Jun 2021 21:57:03 +0200
Message-ID: <CAFBinCD+9asM9-+kGEa3PhurxGqP9UwmP4aNCN9gNQPeMUyhiQ@mail.gmail.com>
Subject: Re: [PATCH] Fix some wrong goto jumps for avoiding memory leak.
To:     zpershuai <zpershuai@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello,

On Wed, Jun 9, 2021 at 4:22 PM zpershuai <zpershuai@gmail.com> wrote:
>
> In meson_spifc_probe function, when  enable the device pclk clock is
> error, it should use clk_disable_unprepare to release the core clock.
>
> And when meson_spicc_clk_init returns failed,  it should goto the
> out_clk label.
After reviewing your patch I agree with your findings!
So thank you very much for bringing this up and sending a fix

The subject of this patch does not match what we usually have
Can you please make it start with "spi: meson-spicc:" (see git log
drivers/spi/spi-meson-spicc.c)

[...]
>         device_reset_optional(&pdev->dev);
> @@ -752,7 +752,7 @@ static int meson_spicc_probe(struct platform_device *pdev)
>         ret = meson_spicc_clk_init(spicc);
>         if (ret) {
>                 dev_err(&pdev->dev, "clock registration failed\n");
> -               goto out_master;
> +               goto out_clk;
>         }
I'd prefer this part to go into a separate patch so that separate
patch can get the following Fixes tag (which should then be added
above your Signed-off-by):
Fixes: 3e0cf4d3fc29 ("spi: meson-spicc: add a linear clock divider support")

The remaining changes (to my understanding) should get:
Fixes: 454fa271bc4e ("spi: Add Meson SPICC driver")

The "Fixes" tag is relevant so bug-fixes can be backported to older
kernel versions automatically.

So it would be great if you could send a second version with the above
changes considered.


Thank you and best regards,
Martin
