Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDA9CF575
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2019 11:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbfJHJAS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Oct 2019 05:00:18 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43299 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729767AbfJHJAS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 8 Oct 2019 05:00:18 -0400
Received: by mail-ot1-f66.google.com with SMTP id o44so13393693ota.10
        for <linux-spi@vger.kernel.org>; Tue, 08 Oct 2019 02:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qRJPrctTw8yEuHkwIx3SGDl0hYvztgI6Q303pnWdjmI=;
        b=mcAWr87bHMfCbQ7dZpJ8nPbsMmOtLHoA88IM/nc2bCkFny4HE0jPyyCwvCaJsbsRa/
         C7HuhvufwQDSUt0V0K3myrwGe/9JFyaqayubVruPXovdz0ohTFFDJfbWy+j6E+kMertP
         y4dH5R+jzYxeKVis3Py+f6jF6IfHVMSGVcojp9i9T7vrNWZQcbkqR5pLs2ZuHDOijHUw
         wpzuQaKGyz0Z6lYAaCLRqocP46DGethhpT5w8Hej/y8cxzbeg/OqoFuU2uxzVUipaqvg
         GsfrKg9fhMJYqEyS9SbVjBTH5/p2WaCupPIEUARSpKzdWB3Hf89JdrXeNECV/xBqA8PJ
         ReEw==
X-Gm-Message-State: APjAAAU/2doUPE63nzWZgF717oh09QE6bnBY7kTjDsH2U9OJzFExDYAR
        /Y/SI4exTDD2T0Yk0i29L/WGZSw2dIFhQgRyAxdaOg==
X-Google-Smtp-Source: APXvYqx/47tw2AyCyKdyGlSZfHzdAewtF99IB3myCDN8iF+6tJStwYQ3fRDjOdIwpZdr342msooM/sL/PBkd7BgQ8RM=
X-Received: by 2002:a9d:6642:: with SMTP id q2mr24330701otm.250.1570525217388;
 Tue, 08 Oct 2019 02:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <1570523497-112804-1-git-send-email-zhengbin13@huawei.com> <1570523497-112804-2-git-send-email-zhengbin13@huawei.com>
In-Reply-To: <1570523497-112804-2-git-send-email-zhengbin13@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Oct 2019 11:00:06 +0200
Message-ID: <CAMuHMdVxGBU2uHk_ySErWYHEOcF4nAL2wn_jcy_H-T4NjHB8wg@mail.gmail.com>
Subject: Re: [PATCH 1/2] spi: omap-100k: Remove set but not used variable 'dataH'
To:     zhengbin <zhengbin13@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Zhengbin,

On Tue, Oct 8, 2019 at 10:25 AM zhengbin <zhengbin13@huawei.com> wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/spi/spi-omap-100k.c: In function spi100k_read_data:
> drivers/spi/spi-omap-100k.c:140:6: warning: variable dataH set but not used [-Wunused-but-set-variable]
>
> It is not used since commit 35c9049b2704 ("Add OMAP spi100k driver")
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: zhengbin <zhengbin13@huawei.com>

Have you tested this on actual hardware?
Are you sure the hardware does not require reading this register to work
properly?

> --- a/drivers/spi/spi-omap-100k.c
> +++ b/drivers/spi/spi-omap-100k.c
> @@ -128,7 +128,7 @@ static void spi100k_write_data(struct spi_master *master, int len, int data)
>
>  static int spi100k_read_data(struct spi_master *master, int len)
>  {
> -       int dataH, dataL;
> +       int dataL;
>         struct omap1_spi100k *spi100k = spi_master_get_devdata(master);
>
>         /* Always do at least 16 bits */
> @@ -146,7 +146,6 @@ static int spi100k_read_data(struct spi_master *master, int len)
>         udelay(1000);
>
>         dataL = readw(spi100k->base + SPI_RX_LSB);
> -       dataH = readw(spi100k->base + SPI_RX_MSB);
>         spi100k_disable_clock(master);
>
>         return dataL;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
