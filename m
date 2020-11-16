Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3072B5100
	for <lists+linux-spi@lfdr.de>; Mon, 16 Nov 2020 20:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgKPTX5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Nov 2020 14:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729060AbgKPTX5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Nov 2020 14:23:57 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820E3C0613CF
        for <linux-spi@vger.kernel.org>; Mon, 16 Nov 2020 11:23:55 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id c17so19994230wrc.11
        for <linux-spi@vger.kernel.org>; Mon, 16 Nov 2020 11:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kJVNgcnJ0Pau7sBe5FOENQOZoDCii1XpWWQQL/od8GM=;
        b=dfY5e1mczd7zQndZHlxrO48ynspsDL0tejgffhk0p7vMH3r3fymGB7Yjr9z5gqGFLc
         pZeozd6avTu8LdvIBOODmJ5NM6jotB2EKkdfweoSSmSm+tEhajdHRSjDFqH13tIWvX7f
         4oy3cQ3xFUxmUcZlppc89Mq1ljxtPBV4DeKbrqFOkIXmxmdS1vBKrA2O51YvYrbaMybV
         lbXEbPVqufxaGDlAiYg+F4efmz2WGFx4ZagaTMUrLgfx113HKINpWt5qP2y+ZLLRHSe8
         FlROHxwsN9gwKRg7+UNscTYWToYuRppAOIvQtqB4C0kLM2s7tE8kP6bvCLsJpzA6hMc2
         HpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kJVNgcnJ0Pau7sBe5FOENQOZoDCii1XpWWQQL/od8GM=;
        b=ML9Bmmk3uv+erKWsq/PSvdbSlpE7Z/0bMp91KQApaSwW5180HtmQ1GB2AOvur5g6nJ
         bQDPWaegFr+fC+vjYwEp/9OxdtJ/TySBIVM8uxmyzZl2b54+H9jngV2ehkFbEu5BdTuW
         sM4xNmjJKXXZh7KIbtS1TAMMpqFtTrNI4s2B7+TzM6dZGhVe6V1/qjr7CgyYTU8JzQFL
         wBHY3RmbfXK6qRtBgp+4viOOAMeFT7uIcxTZ/8pi5ULBVWL6srMZjt4dgfg6wdabkOv5
         qvRdd6V0tBBK526D4UM/ymMwqHk5xhx2/hYy37KVl3z7FFh/nRK8T0mP6O4GJ5KpozCn
         cgAg==
X-Gm-Message-State: AOAM5314a/E7ugeF/ZznbK1lmzYdwtL9IbwwgXAbs/wOt3xfp/IrZmFk
        jRF3Em40f7j8Xi60pMC4d+vEvUfvV2OIuRIJgPQ=
X-Google-Smtp-Source: ABdhPJx1a9fTmWWrS1pCz7vLNvrBZNJnNVV35XMnurqr/1f04ZXbRC1H1KMsac8/XHJt4slIlyRM/XFh6kxz7nKPB9s=
X-Received: by 2002:adf:f005:: with SMTP id j5mr20893530wro.417.1605554634192;
 Mon, 16 Nov 2020 11:23:54 -0800 (PST)
MIME-Version: 1.0
References: <73adc6ba84a4f968f2e1499a776e5c928fbdde56.1605512876.git.lukas@wunner.de>
 <49102f5bbb3f1592d9cfd7b39ac5e131a031f950.1605512876.git.lukas@wunner.de>
In-Reply-To: <49102f5bbb3f1592d9cfd7b39ac5e131a031f950.1605512876.git.lukas@wunner.de>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Mon, 16 Nov 2020 11:23:43 -0800
Message-ID: <CAHQ1cqHs+jTzp2dYx0cAosLaoBWXpmBivW5bPKbckS=un9k9SA@mail.gmail.com>
Subject: Re: [PATCH for-5.10] spi: gpio: Don't leak SPI master in probe error path
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Nov 16, 2020 at 12:44 AM Lukas Wunner <lukas@wunner.de> wrote:
>
> If the call to devm_spi_register_master() fails on probe of the GPIO SPI
> driver, the spi_master struct is erroneously not freed:
>
> After allocating the spi_master, its reference count is 1.  The driver
> unconditionally decrements the reference count on unbind using a devm
> action.  Before calling devm_spi_register_master(), the driver
> unconditionally increments the reference count because on success,
> that function will decrement the reference count on unbind.  However on
> failure, devm_spi_register_master() does *not* decrement the reference
> count, so the spi_master is leaked.

Not sure I fully understand this. On failure
devm_spi_register_master() will return a negative error code which
should result in probe failure and release of devres resource, right?

>
> The issue was introduced by commits 8b797490b4db ("spi: gpio: Make sure
> spi_master_put() is called in every error path") and 79567c1a321e ("spi:
> gpio: Use devm_spi_register_master()"), which sought to plug leaks
> introduced by 9b00bc7b901f ("spi: spi-gpio: Rewrite to use GPIO
> descriptors") but missed this remaining leak.
>

That extra spi_master_get() that might be problematic was present in
the code before 8b797490b4db ("spi: gpio: Make sure spi_master_put()
is called in every error path") and I think was first introduced in

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers?h=v5.9-rc4&id=702a4879ec337463f858c8ab467482cce260bf18

Or am I missing something?

Not really questioning the validity of this fix, just trying to
understand what I missed in 8b797490b4db ("spi: gpio: Make sure
spi_master_put() is called in every error path")

> The situation was later aggravated by commit d3b0ffa1d75d ("spi: gpio:
> prevent memory leak in spi_gpio_probe"), which introduced a
> use-after-free because it releases a reference on the spi_master if
> devm_add_action_or_reset() fails even though the function already
> does that.
>
> Fix by switching over to the new devm_spi_alloc_master() helper.
>
> Fixes: 9b00bc7b901f ("spi: spi-gpio: Rewrite to use GPIO descriptors")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: <stable@vger.kernel.org> # v4.17+: 5e844cc37a5c: spi: Introduce device-managed SPI controller allocation
> Cc: <stable@vger.kernel.org> # v5.1-: 8b797490b4db: spi: gpio: Make sure spi_master_put() is called in every error path
> Cc: <stable@vger.kernel.org> # v5.1-: 45beec351998: spi: bitbang: Introduce spi_bitbang_init()
> Cc: <stable@vger.kernel.org> # v5.1-: 79567c1a321e: spi: gpio: Use devm_spi_register_master()
> Cc: <stable@vger.kernel.org> # v5.4-: d3b0ffa1d75d: spi: gpio: prevent memory leak in spi_gpio_probe
> Cc: <stable@vger.kernel.org> # v4.17+
> Cc: Navid Emamdoost <navid.emamdoost@gmail.com>
> Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/spi/spi-gpio.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
> index 7ceb0ba27b75..0584f4d2fde2 100644
> --- a/drivers/spi/spi-gpio.c
> +++ b/drivers/spi/spi-gpio.c
> @@ -350,11 +350,6 @@ static int spi_gpio_probe_pdata(struct platform_device *pdev,
>         return 0;
>  }
>
> -static void spi_gpio_put(void *data)
> -{
> -       spi_master_put(data);
> -}
> -
>  static int spi_gpio_probe(struct platform_device *pdev)
>  {
>         int                             status;
> @@ -363,16 +358,10 @@ static int spi_gpio_probe(struct platform_device *pdev)
>         struct device                   *dev = &pdev->dev;
>         struct spi_bitbang              *bb;
>
> -       master = spi_alloc_master(dev, sizeof(*spi_gpio));
> +       master = devm_spi_alloc_master(dev, sizeof(*spi_gpio));
>         if (!master)
>                 return -ENOMEM;
>
> -       status = devm_add_action_or_reset(&pdev->dev, spi_gpio_put, master);
> -       if (status) {
> -               spi_master_put(master);
> -               return status;
> -       }
> -
>         if (pdev->dev.of_node)
>                 status = spi_gpio_probe_dt(pdev, master);
>         else
> @@ -432,7 +421,7 @@ static int spi_gpio_probe(struct platform_device *pdev)
>         if (status)
>                 return status;
>
> -       return devm_spi_register_master(&pdev->dev, spi_master_get(master));
> +       return devm_spi_register_master(&pdev->dev, master);
>  }
>
>  MODULE_ALIAS("platform:" DRIVER_NAME);
> --
> 2.28.0
>
