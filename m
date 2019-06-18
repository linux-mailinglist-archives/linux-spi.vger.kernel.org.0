Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D33EC4A2BA
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2019 15:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbfFRNse (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Jun 2019 09:48:34 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34814 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbfFRNse (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Jun 2019 09:48:34 -0400
Received: by mail-lf1-f68.google.com with SMTP id y198so9358280lfa.1;
        Tue, 18 Jun 2019 06:48:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7+kbZiOiDbTggEs3A0ulB7sqbr27Je5jHR0L0MU0TsE=;
        b=rCpIzM7ymmVf2VRmNyeFxRGTn4XPC9PmWCUojZ6U91rMP4va3LXpXL4bzq83AdMvw+
         9F/FFl4d/uAqZxl7qKs8F+QNrM4q2JqW9Yo9NQAwIzIJyqQ8mHpLgstpnaKE1sf5ei/8
         QRRzuDlU+OIIJ0hX0cbMg+HwaF1cqJCMfZTmA6lkI2s0P50zajMUNkKYTfpPd8I7itMq
         yuZ/k7q8YGtQM3FYgwsWH76D2RQ6Ne7BJbV9H6CJ303vW5OyXEKuXo61JM1yCLG37Cec
         Kv3L0+QKOY3auayjwsSCWs959KpLIzNTG+sHR7v6XVTDYWPIM8pWLDRN8rcCTA9t9ejV
         T0AA==
X-Gm-Message-State: APjAAAVVvhbAGgf9Q/T8wGxhfSoggZxePnI1Po9oZ3X+xWHudqTO4JQq
        /0DW7EcmDBCotOSkdP4r6Q+669+asitKBj9g0AI=
X-Google-Smtp-Source: APXvYqxqOA3vkIL5x1Kbge9cboaZKPpIerLuVqib804+WziaW6ixFgv8msm2r2GTrKBXTSdNmxibXmZ5wRzkaYfdgzQ=
X-Received: by 2002:ac2:5467:: with SMTP id e7mr35125442lfn.23.1560865711756;
 Tue, 18 Jun 2019 06:48:31 -0700 (PDT)
MIME-Version: 1.0
References: <1560796840-18207-1-git-send-email-info@metux.net> <1560796840-18207-2-git-send-email-info@metux.net>
In-Reply-To: <1560796840-18207-2-git-send-email-info@metux.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 18 Jun 2019 15:48:19 +0200
Message-ID: <CAMuHMdVhW+5YVJWW8q59XKgXGbre0wH6pYDJKCY_2LWV6UEX5w@mail.gmail.com>
Subject: Re: [PATCH 2/3] drivers: gpio: pcf857x: use subsys_spi_driver()
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Enrico,

On Mon, Jun 17, 2019 at 8:41 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
> From: Enrico Weigelt <info@metux.net>
>
> Reduce driver init boilerplate by using the new
> subsys_spi_driver() macro.
>
> Signed-off-by: Enrico Weigelt <info@metux.net>

Thanks for your patch!

>  drivers/gpio/gpio-max7301.c | 13 +------------

s/pcf857x/max7301/ in subject.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
