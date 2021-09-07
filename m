Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781BE4023D3
	for <lists+linux-spi@lfdr.de>; Tue,  7 Sep 2021 09:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236724AbhIGHIS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Sep 2021 03:08:18 -0400
Received: from mail-vk1-f169.google.com ([209.85.221.169]:33727 "EHLO
        mail-vk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbhIGHIR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Sep 2021 03:08:17 -0400
Received: by mail-vk1-f169.google.com with SMTP id j5so2955104vki.0;
        Tue, 07 Sep 2021 00:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=34toH65PPpjzHNECWtKzZN6+N1eTTvaJ+1f/TQkpm/4=;
        b=ItPS4/+bR4Qp+WzAlE3Nd1h3Ro9d5MSku8riD4NSB5fBctk9AcwLFjCUXxlOHORHoq
         L7B9ASjn/yJpfJgHOeF5UYs2I3vUNGVZ+I9dyT3TD01FZ6D0T4gI2yBOx4Tve/TUbTYq
         CQUmxWBngiCvG4WYU/s6oRQ9JSlnoUBaFtZDpOuKpXFymJ5aqFG1kcPZYvHEuYT0Wh1o
         d+N89YHCnslgEFxQZDywfZ6dUTyI1ELs/EQ3LGnnFwOL1NQuM6gGlG1wCKnI6UdWBmXf
         TRs5pzM6bsbGJHwiqciH3raPcu3gnMmpv9UBBrUHjS508a323Pz+MHMrNmsEonP7cC5v
         NY4g==
X-Gm-Message-State: AOAM531pWsYPEijCs6EvTMJGf992/kUrclhmm6pETsTiFKn6e1b7EugL
        LlLTo55/TmxS1K+4xDYkFhRw9VPpTQFLLW2pvIc=
X-Google-Smtp-Source: ABdhPJw68jIoiEfAAwDXFLZ9LWNlDd4IcmxBHL4WiVb7QKRzTBsvlTxsKtbCln7drnSR7n/TBfuv9ODhrDtY4VO0EYM=
X-Received: by 2002:a1f:fc8f:: with SMTP id a137mr6948106vki.19.1630998431244;
 Tue, 07 Sep 2021 00:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210907045358.2138282-1-linux@roeck-us.net>
In-Reply-To: <20210907045358.2138282-1-linux@roeck-us.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 7 Sep 2021 09:07:00 +0200
Message-ID: <CAMuHMdVEV4spviXmR1hs5YmydFKxWhuZqxtS06ko2v_q8v37PA@mail.gmail.com>
Subject: Re: [PATCH] spi: tegra20-slink: Declare runtime suspend and resume
 functions conditionally
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Sep 7, 2021 at 6:56 AM Guenter Roeck <linux@roeck-us.net> wrote:
> The following build error is seen with CONFIG_PM=n.
>
> drivers/spi/spi-tegra20-slink.c:1188:12: error:
>         'tegra_slink_runtime_suspend' defined but not used
> drivers/spi/spi-tegra20-slink.c:1200:12: error:
>         'tegra_slink_runtime_resume' defined but not used
>
> Declare the functions only if PM is enabled. While at it, remove the
> unnecessary forward declarations.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
