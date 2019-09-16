Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF8BB3CA7
	for <lists+linux-spi@lfdr.de>; Mon, 16 Sep 2019 16:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388653AbfIPOgP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Sep 2019 10:36:15 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41985 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388652AbfIPOgP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Sep 2019 10:36:15 -0400
Received: by mail-ot1-f65.google.com with SMTP id c10so11086otd.9;
        Mon, 16 Sep 2019 07:36:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=768Sh8OVCZjBOZt3k89v4UrywpjMcpm5T6xe1BNm4rE=;
        b=ldsQdbMZb/kcnIKlUq+ylPdDFNQ0xq0vBPbXdKB4hxljQ9qaF0vhEd5JHNIeXT4mBn
         nq5f7W5nd7xgEKoOjjxTZ6DghV/+++AkoPt6VjmYPVn/74b4ohN+J3lNm6uDJ7+OZEtJ
         jD6AzgXH0GD44fABGxOnDAriw2mXxqpj/d354Abd1deOO4I94JIvpjAjpGdjcviH6xo2
         NvhgFdEPzPryJe73vj7Y3sCT/Cb3f5mNRqwJL2i9+CuzhNxC5wMM4JHQpb2FU1ey62Nk
         ExRd7wJUaEZf9jbHTSGiJFp5FFGOebWV2fznfYLTFHS10YjvaYJqfXNxfxBpbeKq3yv3
         +v6w==
X-Gm-Message-State: APjAAAX0pYHS+D/LNQ1fO2mpEqA5bVWa2v9mf7x8Xp3CiBI4d3N1vqSP
        saGbx11z0wCcL1DoxqQsXVaZyavaaj4pJcz9cNU=
X-Google-Smtp-Source: APXvYqwj4WNEYgBH9YMKLlIZ+sXj65qK2vhBocCI23bzCMJPmctPWDWJLRZDsjfn5kw5xp+08KPwLhn6cnaFv8WLiMY=
X-Received: by 2002:a05:6830:1196:: with SMTP id u22mr11397406otq.39.1568644574252;
 Mon, 16 Sep 2019 07:36:14 -0700 (PDT)
MIME-Version: 1.0
References: <1568376720-7402-1-git-send-email-gareth.williams.jx@renesas.com> <1568376720-7402-3-git-send-email-gareth.williams.jx@renesas.com>
In-Reply-To: <1568376720-7402-3-git-send-email-gareth.williams.jx@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 16 Sep 2019 16:36:03 +0200
Message-ID: <CAMuHMdUnzmYEcp0B5MG7itB1JHtNL7Stj9S2EFB0U0y_naQVBQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] spi: dw: Add basic runtime PM support
To:     Gareth Williams <gareth.williams.jx@renesas.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Gareth,

On Fri, Sep 13, 2019 at 2:13 PM Gareth Williams
<gareth.williams.jx@renesas.com> wrote:
> From: Phil Edworthy <phil.edworthy@renesas.com>
>
> Enable runtime PM so that the clock used to access the registers in the
> peripheral is turned on using a clock domain.
>
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>

Thanks for your patch!

> --- a/drivers/spi/spi-dw.c
> +++ b/drivers/spi/spi-dw.c
> @@ -10,6 +10,7 @@
>  #include <linux/module.h>
>  #include <linux/highmem.h>
>  #include <linux/delay.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/slab.h>
>  #include <linux/spi/spi.h>
>
> @@ -497,6 +498,9 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
>         if (dws->set_cs)
>                 master->set_cs = dws->set_cs;
>
> +       pm_runtime_enable(dev);
> +       pm_runtime_get_sync(dev);

The second line keeps the device powered all the time.
What about setting spi_controller.auto_runtime_pm = true, so the SPI
code can manage its Runtime PM status?

> +
>         /* Basic HW init */
>         spi_hw_init(dev, dws);
>

What about the error path?
Don't you need to disable Runtime PM again in dw_spi_remove_host()?

I assume this will be called from drivers/spi/spi-dw-mmio.c, which already
enables the clock explicitly all the timer?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
