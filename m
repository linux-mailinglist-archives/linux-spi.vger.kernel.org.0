Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87B2116491C
	for <lists+linux-spi@lfdr.de>; Wed, 19 Feb 2020 16:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgBSPsD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Feb 2020 10:48:03 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38334 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgBSPsD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Feb 2020 10:48:03 -0500
Received: by mail-lj1-f195.google.com with SMTP id w1so873600ljh.5
        for <linux-spi@vger.kernel.org>; Wed, 19 Feb 2020 07:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W3yuhBwBhCc9hCUhqdt5niSoYLTGtNRD8nOw8aCAMcg=;
        b=C5w5jfM37duj6h3MarZLMvydqmOEdwP3mguPoYitURrIjM+jkFQaJqNpLZpMEevUCI
         nbPJJNOhYl4ujjTGWb865cBi+Mx8xuwTCPNVEI9FuYXwvfHv5diu7z6MVUtixx50gLEz
         9SEN4epH1j1FjTAdspJpO7a40J8sMdloUUgZl6/9SPReB88BstUSS8hY3fDVT0L1zx1H
         +7+7iH7olOFc47PyPYVGOsnBMOcmTBYsLfD8MvjTJ+y5N7DL+/1/uw09qrvSu7AB3aT5
         TURe0eLbeJy4yWcKrO5D91hr4toNj8ZW1q2rdPtCLLLOHbhVZdHrn50I5uoUvGeveuYy
         Cx6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W3yuhBwBhCc9hCUhqdt5niSoYLTGtNRD8nOw8aCAMcg=;
        b=T3j+sDhM4VVak4rssK25Thgd11//v855EvdcnHDa0NRYULBgOzbkJJZKR2JVOZqVA0
         VBS3poVbz4QA3sqp8TE+JY18Qdsfs59tfUrhMXTHaaciDvg1HxgGIn4dQEjUPicvTvYi
         j4sc2LEBssbOFFJjlomAFsQ9K4V0QbFhsMJvlSoCjNeNXEGjVYXhaA2lLYKjRcMyJAUt
         srO8GooRj++pi2F9RxfcnnVgrxKuXs23REO/Oxa4EYkTeFOYk3hIVU1crzyncAhQHZTD
         NpeuKKa9NLs5K6cCoDWtKkKEy72ocQBxOPono49i03pHiNsWZB7389aipRfN67MbEg8k
         oXOQ==
X-Gm-Message-State: APjAAAU1cpz2g969Yn+28AlIql4fgPbS0C/LlRB3mCoONDS5+YfOhp2b
        2S+Xpd18PfsSvityHvet3mQirpA8SEIho5YzXjvCRQ==
X-Google-Smtp-Source: APXvYqzKennu9chASiLD3tKb71xmHQKMdOOMof8TH7xg/nh0DZzv5XsUJVqhYHIkqIXBmuyXfRHq7LqcNWN0fAo1N+E=
X-Received: by 2002:a2e:7d0c:: with SMTP id y12mr16959673ljc.39.1582127281257;
 Wed, 19 Feb 2020 07:48:01 -0800 (PST)
MIME-Version: 1.0
References: <fca3ba7cdc930cd36854666ceac4fbcf01b89028.1582027457.git.lukas@wunner.de>
In-Reply-To: <fca3ba7cdc930cd36854666ceac4fbcf01b89028.1582027457.git.lukas@wunner.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 19 Feb 2020 16:47:50 +0100
Message-ID: <CACRpkdZmzL_bDRuiBehmd-QC93K_xJ5VHM0HaypCFXLU6sZvkQ@mail.gmail.com>
Subject: Re: [PATCH] spi: spidev: Fix CS polarity if GPIO descriptors are used
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Simon Han <z.han@kunbus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Feb 18, 2020 at 1:08 PM Lukas Wunner <lukas@wunner.de> wrote:

> Commit f3186dd87669 ("spi: Optionally use GPIO descriptors for CS GPIOs")
> amended of_spi_parse_dt() to always set SPI_CS_HIGH for SPI slaves whose
> Chip Select is defined by a "cs-gpios" devicetree property.
>
> This change broke userspace applications which issue an SPI_IOC_WR_MODE
> ioctl() to an spidev:  Chip Select polarity will be incorrect unless the
> application is changed to set SPI_CS_HIGH.  And once changed, it will be
> incompatible with kernels not containing the commit.
>
> Fix by setting SPI_CS_HIGH in spidev_ioctl() (under the same conditions
> as in of_spi_parse_dt()).
>
> Fixes: f3186dd87669 ("spi: Optionally use GPIO descriptors for CS GPIOs")
> Reported-by: Simon Han <z.han@kunbus.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v5.1+
> Cc: Linus Walleij <linus.walleij@linaro.org>
(...)

Nit: I would also insert a comment in the code to tell what is going on.

> +                       if (ctlr->use_gpio_descriptors && ctlr->cs_gpiods &&
> +                           ctlr->cs_gpiods[spi->chip_select])
> +                               tmp |= SPI_CS_HIGH;

Should this be tmp ^= SPI_CS_HIGH?

If the device tree node for cs-gpios is actually active high, which
happens, then you probably want the opposite of what was
requested, right?

Yours,
Linus Walleij
