Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654DD2E6ED4
	for <lists+linux-spi@lfdr.de>; Tue, 29 Dec 2020 09:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgL2IGi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Dec 2020 03:06:38 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:38765 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgL2IGh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 29 Dec 2020 03:06:37 -0500
Received: by mail-ot1-f44.google.com with SMTP id j20so11255588otq.5
        for <linux-spi@vger.kernel.org>; Tue, 29 Dec 2020 00:06:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NdauQaTrMPZORy5cUdB45Ds24ggsLkHX7pFKwokfFCE=;
        b=n/XpE9pzjhEpLbZMrgERekTeF+DBN/ph3UyPm7tBj2lJsRAYUjg21MqYgWqe5VHkzH
         9fWnPHcDCfJjg1HznqUoXGUzIMmcec7QftAVSMqOSzCes6go2M/oMf27JaZndR3H1dbZ
         gMNvtxS3gM6UvkuTxqYtYbi38YNCdssxdJqGRBHTowT8JGlHZtb9nzas0mlHKwiGHdcz
         jUoliD6gBPPEo+6GcSoeeuAigYouRF6h3/NQ/D1AprImAUIFuz/kuFb1rPsI6Z11sEX1
         fWPFhDuc7NPqu/GSH2yInDdU89vSlY8bH/msWPzB6KE3OLnfgZ8EtcDAl7Z+wfe9zX04
         HoTg==
X-Gm-Message-State: AOAM532QVkxp1Pgo78W9/CcVPOvLu3fb1DP5zyY+TdoN3AXAPb8dr5aP
        JYHlOJIebzPJHQlXbnNQT7nP9mw0soO9KvH6tMqCuzceTlM=
X-Google-Smtp-Source: ABdhPJysIU0TjUKes3bUQEvlL44PkwifYNlOOm1Xl/F6gMIg9GnviYt/F15DklEen2FMawwAN+PmXystgLDjXBuvwT0=
X-Received: by 2002:a9d:c01:: with SMTP id 1mr20606464otr.107.1609229156860;
 Tue, 29 Dec 2020 00:05:56 -0800 (PST)
MIME-Version: 1.0
References: <20201229040450.10052-1-festevam@gmail.com>
In-Reply-To: <20201229040450.10052-1-festevam@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 29 Dec 2020 09:05:45 +0100
Message-ID: <CAMuHMdW4fbp092xbspwn-S-DHUQNJqATp=3Rr02vKsMj14CB7g@mail.gmail.com>
Subject: Re: [PATCH v2] spi: Fix regression when the SPI controller does not
 pass max_speed_hz
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Fabio,

On Tue, Dec 29, 2020 at 5:06 AM Fabio Estevam <festevam@gmail.com> wrote:
> Since commit 9326e4f1e5dd ("spi: Limit the spi device max speed to
> controller's max speed") the following regression is observed on an
> imx6q-sabresd:
>
> [    3.918284] spi_imx 2008000.spi: cannot set clock freq: 0 (base freq: 60000000)
> [    3.925953] Division by zero in kernel.
> [    3.929831] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W         5.10.0-next-20201223 #276
> [    3.938565] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [    3.945124] [<c0111a68>] (unwind_backtrace) from [<c010c068>] (show_stack+0x10/0x14)
> [    3.952925] [<c010c068>] (show_stack) from [<c0e11540>] (dump_stack+0xe0/0x10c)
> [    3.960279] [<c0e11540>] (dump_stack) from [<c05d471c>] (Ldiv0+0x8/0x10)
> [    3.967026] [<c05d471c>] (Ldiv0) from [<c089b044>] (mx51_ecspi_prepare_transfer+0xfc/0x17c)
>
> The spi-imx driver does not fill the max_speed_hz field, so we get:
>
> spi->max_speed_hz = 20MHz
> spi->controller->max_speed_hz = 0MHz
>
> which will result in spi->max_speed_hz being 0, causing the division by
> zero in the spi-imx driver.
>
> Fix this problem, by checking if spi->controller->max_speed_hz is not
> zero prior to assign it to spi->max_speed_hz.
>
> Fixes: 9326e4f1e5dd ("spi: Limit the spi device max speed to controller's max speed")
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

See also
https://lore.kernel.org/linux-spi/20201216092321.413262-1-tudor.ambarus@microchip.com/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
