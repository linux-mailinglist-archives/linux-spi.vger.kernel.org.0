Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358702DAEE7
	for <lists+linux-spi@lfdr.de>; Tue, 15 Dec 2020 15:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbgLOOZM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 15 Dec 2020 09:25:12 -0500
Received: from mail-oo1-f65.google.com ([209.85.161.65]:37806 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728541AbgLOOZC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 15 Dec 2020 09:25:02 -0500
Received: by mail-oo1-f65.google.com with SMTP id t23so4850187oov.4;
        Tue, 15 Dec 2020 06:24:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xplhcJRnAFV/vFSVrr3RUhdg47pJr9DfaTlDdw77pbg=;
        b=uSELKtd5LiYfjl++n6DAQgRn1S5gQMi2YLf9PyyyEN55nE682S2zLHtbbQT10kqWEc
         LcOMkMPGQxUZ9tLZaNS/eokjEO9ZQqUjXz3RouILwuuJc2UWANUJJVH4OpozkVqbDtuH
         vtcGghBykIsuDjvZtTswL0fYzqluqka25etP7fXKfK3TJ5G/Lj9C8inOr28/P3oJ3Unk
         37EpKHxhU3ZPeXeE0/4hSggJty2nlXTLh3dAxdEbZAKDsT2+rWPVgBaheuZnns7D5tz1
         jWvl6eqQ+KcD/eT1aygDBZ9H0fNvzyl/d0k05pH/SJ8c5x0SC+1tsuTfdYVJsiXMSUV+
         8GVg==
X-Gm-Message-State: AOAM530UqOXx/lSdyieP5FjnAL8QAIe3Hxo7rP/gYNqOrvgqv+jUqfJc
        d2j7QSs0bdbi7qHhz7vFPqAoO36NHs9WkHO2ffQ=
X-Google-Smtp-Source: ABdhPJx99G0pO5eRD+TaWgFfACFxu36ZlLFdPXPVDL2FP9V14NON6TFl0YuJ6SJSExB/w5w21W+sIPZAzNBK9odLtu8=
X-Received: by 2002:a4a:ca14:: with SMTP id w20mr22668283ooq.11.1608042256623;
 Tue, 15 Dec 2020 06:24:16 -0800 (PST)
MIME-Version: 1.0
References: <20201209173514.93328-1-tudor.ambarus@microchip.com> <160770909978.26609.5466191880976694172.b4-ty@kernel.org>
In-Reply-To: <160770909978.26609.5466191880976694172.b4-ty@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 15 Dec 2020 15:24:04 +0100
Message-ID: <CAMuHMdU+heMQKLZR15g5s5Ad-H8cDeFeM+7Wh=45PFqQhyfjOA@mail.gmail.com>
Subject: Re: [PATCH] spi: Limit the spi device max speed to controller's max speed
To:     Mark Brown <broonie@kernel.org>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark, Tudor,

On Fri, Dec 11, 2020 at 8:02 PM Mark Brown <broonie@kernel.org> wrote:
> On Wed, 9 Dec 2020 19:35:14 +0200, Tudor Ambarus wrote:
> > Make sure the max_speed_hz of spi_device does not override
> > the max_speed_hz of controller.
>
> Applied to
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
>
> Thanks!
>
> [1/1] spi: Limit the spi device max speed to controller's max speed
>       commit: 9326e4f1e5dd1a4410c429638d3c412b6fc17040

> -       if (!spi->max_speed_hz)
> +       if (!spi->max_speed_hz ||
> +           spi->max_speed_hz > spi->controller->max_speed_hz)
>                 spi->max_speed_hz = spi->controller->max_speed_hz;

If spi->controller->max_speed_hz is zero, a non-zero spi->max_speed_hz
will be overwritten by zero.

Hence this broke spi-sh-msiof, which has the following check in
sh_msiof_spi_set_clk_regs():

        if (!spi_hz || !parent_rate) {
                WARN(1, "Invalid clock rate parameters %lu and %u\n",
                     parent_rate, spi_hz);
                return;
        }

Without this, the driver would trigger a division-by-zero later...

Arguably all SPI controller drivers should fill in
spi_controller.{min,max}_speed_hz, but as long as that is not the case,
I think this patch should be reverted, or the check should be enhanced
to make sure spi->controller->max_speed_hz is non-zero.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
