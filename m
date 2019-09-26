Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E44DBEC2F
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2019 08:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbfIZGxB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 26 Sep 2019 02:53:01 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45602 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfIZGxB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 26 Sep 2019 02:53:01 -0400
Received: by mail-ot1-f66.google.com with SMTP id 41so1029087oti.12;
        Wed, 25 Sep 2019 23:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jOxmQIZ9/nLS57z58IjKt3I6bKDLebiKnN6qX7jkqHc=;
        b=NHyTmteGd1pOma+rnrJpF4x23lgF7T0pp/aa2zj8i3xsvy5L1IPaaRLn8LJBKjB6sl
         IGTMyCeeWuSx+dMQIudqy+i+4QH/H1+C6/WvplP+LFs5r2ETOXr07dDtW3/l8iGjpcAJ
         H0YsIg7yBRTVdV1C8uS+xRCrIgyyB7ch9u14k0BDg54RUGwevs5RU2f7jReLX8/HkCx2
         slO/Ymk15jdW+sXTgm+nE1HZWgZEVip2mN8oFt9+ZUZjlCq7tmpXam8yEBAwqhgLP+Wd
         odkl0cHgWfkQAzOb3otwxWxzDw/om1XypJpTzdc6lJRMxtKAvOGDW0oe6xDr8JxJJe2K
         jyzw==
X-Gm-Message-State: APjAAAXndRJRP1Teyy6v10LNIMN9KrIqhze43H2DD2kMgqOscgqzbDW7
        736tSxe2ImWILTjB6rkh9Hj5TS9OxQSnH7jvdFg=
X-Google-Smtp-Source: APXvYqz4B9s0pUnTWBlenHYZ2HUvHIJ7WCCZdPwKOAQo8kuhjVGmumoyv3hTO1gsl54RLbdlDK2z87u4iSoM+iwf6Cs=
X-Received: by 2002:a9d:5a06:: with SMTP id v6mr1471154oth.250.1569480780295;
 Wed, 25 Sep 2019 23:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190924110547.14770-1-lukma@denx.de> <20190924110547.14770-2-lukma@denx.de>
In-Reply-To: <20190924110547.14770-2-lukma@denx.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 26 Sep 2019 08:52:48 +0200
Message-ID: <CAMuHMdXseZppE74D8XW=5ZWNNNLXZFLTSiqqe_qoZ8C1rAFQSg@mail.gmail.com>
Subject: Re: [PATCH 1/2] spi: Add call to spi_slave_abort() function when
 spidev driver is released
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Lukasz,

On Thu, Sep 26, 2019 at 3:33 AM Lukasz Majewski <lukma@denx.de> wrote:
> This change is necessary for spidev devices (e.g. /dev/spidev3.0) working
> in the slave mode (like NXP's dspi driver for Vybrid SoC).
>
> When SPI HW works in this mode - the master is responsible for providing
> CS and CLK signals. However, when some fault happens - like for example
> distortion on SPI lines - the SPI Linux driver needs a chance to recover
> from this abnormal situation and prepare itself for next (correct)
> transmission.
>
> This change doesn't pose any threat on drivers working in master mode as
> spi_slave_abort() function checks if SPI slave mode is supported.
>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

Thanks for your patch!

Yesterday I saw this appear on spi/for-next, but I couldn't find the
email in my mbox.  Today it has arrived. Looks like gmail had some troubles
("Delivered after 138401 seconds", ugh).

> --- a/drivers/spi/spidev.c
> +++ b/drivers/spi/spidev.c
> @@ -627,6 +627,7 @@ static int spidev_release(struct inode *inode, struct file *filp)
>                 if (dofree)
>                         kfree(spidev);
>         }
> +       spi_slave_abort(spidev->spi);

Looks good to me.  Just wondering if this should be done for the last user only,
i.e. in the "if" block above, like resetting speed_hz?

>         mutex_unlock(&device_list_lock);
>
>         return 0;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
