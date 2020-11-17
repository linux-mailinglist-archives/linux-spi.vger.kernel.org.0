Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4922B5D84
	for <lists+linux-spi@lfdr.de>; Tue, 17 Nov 2020 11:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgKQK5I (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Nov 2020 05:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728218AbgKQK5B (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Nov 2020 05:57:01 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B234C0613CF;
        Tue, 17 Nov 2020 02:57:01 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id f12so245558pjp.4;
        Tue, 17 Nov 2020 02:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jWAIgdIvHaXiYWt44F/YcvmxzATL8RKULXdM8eI7Kys=;
        b=KWAq88gywoHamXRbvLiq+2xP8BOPp+V7Xi5X5kylRBCOsRLgswKrAfzqdQ72w7s1jU
         pJ77gSSUIjGLsPZn03YMWnKfBxKL6PxoWuKS4X0fvzGDfV+sF6MKJC8XqOKuJoQQtjuw
         U5r3UXjNxCQKAsbVk618BQsAS+rbjcupCufaBjQhxukskNh2wbJOII5KZ39yshZZ1zCF
         vvkEw+KYf8IU+/Tt1KOJvLWIGnw1Z+loM9bdNccdx1uS/jLlh7Yi7Jw/3iqIqdQgqeX6
         NMzLPVZpapfXXd+gDieRnLDR/eVrNUNwELTHfie24mWu1MlfW5NnpzCJEi+QRj/48+Dq
         Hn9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jWAIgdIvHaXiYWt44F/YcvmxzATL8RKULXdM8eI7Kys=;
        b=iQU440ILzr2MsVKkAArSChRzeDFYDI+5Lk7pN0F0B0pSEmcrhleWqukRI5NERRxAvR
         MT9cBit3+kSlIBLNYXTiiYqEWMAoL7gLRB/cb4rR4HTD4OCA9Eu+mckJiYBbN/uCkur6
         w2wSEH/ssTgZcIhVOCQXcq8NYCpKmFMaDLvpKrA3erF5b8G/Pf6Y4iMzaOYl/vNxcYzx
         7OvFsJqjJM0cjnpGQIDVucqnCSwuTKUVGOrDkTS3rHev+1YwXjMYq2u1Olb3TbCGtcuY
         8lsl8e/QjFlXtL3zx3bgTqa53W5Q7+YiqTyc7z0dzJANcD5AHj3M42laXTw8Ewu/X7ct
         1B1w==
X-Gm-Message-State: AOAM531trZtei6xAeDeyIKu1kq1ASHWgMh2hR+jf/oBAiXN0YPEsyUwa
        uiMveU5aQUDOlqqkL80NteBuyCPfGkaSWPFWIQw=
X-Google-Smtp-Source: ABdhPJz/jOl8RVhKJEKGn8sfS6L2w5W3mdmtEjOGOUSMLqqQPJJ80jPxcSgUx/uEUh9W+AWIqOYJ2lxy8gP8x1LX7y0=
X-Received: by 2002:a17:90a:4816:: with SMTP id a22mr4176920pjh.228.1605610620920;
 Tue, 17 Nov 2020 02:57:00 -0800 (PST)
MIME-Version: 1.0
References: <20201117094517.5654-1-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20201117094517.5654-1-Sergey.Semin@baikalelectronics.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 17 Nov 2020 12:56:44 +0200
Message-ID: <CAHp75VfgdtLxh3uWd-79vEL9bDA0CH2Jiug2g2cJ0R0mQRhW2A@mail.gmail.com>
Subject: Re: [RFC PATCH] spi: Take the SPI IO-mutex in the spi_setup() method
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Nov 17, 2020 at 11:45 AM Serge Semin
<Sergey.Semin@baikalelectronics.ru> wrote:
>
> I've discovered that due to the recent commit 49d7d695ca4b ("spi: dw:
> Explicitly de-assert CS on SPI transfer completion") a concurrent usage of
> the spidev devices with different chip-selects causes the "SPI transfer
> timed out" error.

I'll read this later...

> +       mutex_lock(&spi->controller->io_mutex);
> +
>         if (spi->controller->setup)
>                 status = spi->controller->setup(spi);
>
>         if (spi->controller->auto_runtime_pm && spi->controller->set_cs) {
>                 status = pm_runtime_get_sync(spi->controller->dev.parent);

I didn't check what this lock is protecting, but have you checked all
PM runtime callbacks if they are not taking the lock. When you call PM
runtime functions with 'sync' it may include a lot of work, some of
which may sleep (not a problem for mutex) and may take arbitrary locks
(might be a deadlock in case of trying the same lock).

>                 if (status < 0) {
> +                       mutex_unlock(&spi->controller->io_mutex);
>                         pm_runtime_put_noidle(spi->controller->dev.parent);
>                         dev_err(&spi->controller->dev, "Failed to power device: %d\n",
>                                 status);
> @@ -3354,6 +3357,8 @@ int spi_setup(struct spi_device *spi)
>                 spi_set_cs(spi, false);
>         }
>
> +       mutex_unlock(&spi->controller->io_mutex);
> +


-- 
With Best Regards,
Andy Shevchenko
