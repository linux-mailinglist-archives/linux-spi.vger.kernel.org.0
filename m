Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5203A677793
	for <lists+linux-spi@lfdr.de>; Mon, 23 Jan 2023 10:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjAWJnJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 23 Jan 2023 04:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjAWJnI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 23 Jan 2023 04:43:08 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C695F3587;
        Mon, 23 Jan 2023 01:43:06 -0800 (PST)
Received: by mail-qt1-f182.google.com with SMTP id s4so9215747qtx.6;
        Mon, 23 Jan 2023 01:43:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A0AQTxVMZVDlUVDlTDxcxRqGbyCc841dytCD9yprdLI=;
        b=cbITGBJ6yFA3c11kYMhfQ2xnhpZaalHbWYBwAGTBMKKX4kGardr8Igvjh8QztL5SxG
         doh9fNJ3hwMl0EiPcIAq0hFqXC+QAMuYhrYtLTPp06gNpMDmhSlq/wudo0ntfUE8+5qR
         X4mDsYhch7Ue8kjSZ0Py0UZgwwDa9hjVBi5iP684k620nY2iUFKogxBm/0sZ/68DYNjY
         WCAuVYcHmO4ymix9hnDpBiWogIJ6RxKSEO29+1HbZlUf21GrB/GFegVRMqPg3ZUYEHzE
         bZNszqOVEOQ8m1c7g4Qo1+wyPAYs4+7h5pXAB+tJNwHPB0oFcUHl1s25ijAj/tYnhX8Z
         SHKg==
X-Gm-Message-State: AFqh2krMvN8apXzPC8N4FmeCko34wlar+S/yMpLmQnBOiirXXQxEqEEv
        Dv0h45WmWqwfNJ+C7x6WlQMCuJftrPhCUA==
X-Google-Smtp-Source: AMrXdXv0VzDJD5KblAW8/D8G0fLasNeoiAmySGFS+nQmWJx4zD+5SxQdpUHK9vHsaBE7QeMY9lz0HQ==
X-Received: by 2002:ac8:7245:0:b0:3b6:36e1:ed42 with SMTP id l5-20020ac87245000000b003b636e1ed42mr34837064qtp.9.1674466985793;
        Mon, 23 Jan 2023 01:43:05 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id p16-20020a05620a057000b006fafaac72a6sm30606434qkp.84.2023.01.23.01.43.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 01:43:05 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id x4so12288428ybp.1;
        Mon, 23 Jan 2023 01:43:05 -0800 (PST)
X-Received: by 2002:a25:9ac1:0:b0:7b4:6a33:d89f with SMTP id
 t1-20020a259ac1000000b007b46a33d89fmr1860331ybo.543.1674466985145; Mon, 23
 Jan 2023 01:43:05 -0800 (PST)
MIME-Version: 1.0
References: <20230123075833.50925-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20230123075833.50925-1-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 23 Jan 2023 10:42:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX072wWj=h48oVe47bkaw144HmMeq2bNbiE+ZUMhz56eA@mail.gmail.com>
Message-ID: <CAMuHMdX072wWj=h48oVe47bkaw144HmMeq2bNbiE+ZUMhz56eA@mail.gmail.com>
Subject: Re: [PATCH] spi: sh-msiof: drop support for R-Car H3 ES1.[01]
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Wolfram,

On Mon, Jan 23, 2023 at 8:58 AM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> These revisions have HW issues and are only early engineering samples
> used internally. We simply drop the MSIOF support for them.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> We got confirmation from Renesas for dropping ES1.* support.

Thanks for your patch!

> --- a/drivers/spi/spi-sh-msiof.c
> +++ b/drivers/spi/spi-sh-msiof.c
> @@ -24,6 +24,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/sh_dma.h>
> +#include <linux/sys_soc.h>
>
>  #include <linux/spi/sh_msiof.h>
>  #include <linux/spi/spi.h>
> @@ -1257,8 +1258,15 @@ static void sh_msiof_release_dma(struct sh_msiof_spi_priv *p)
>         dma_release_channel(ctlr->dma_tx);
>  }
>
> +static const struct soc_device_attribute sh_msiof_blacklist[] = {
> +       /* Those have HW issues */
> +       { .soc_id = "r8a7795", .revision = "ES1.[01]" },
> +       { /* Sentinel */ }
> +};
> +
>  static int sh_msiof_spi_probe(struct platform_device *pdev)
>  {
> +       const struct soc_device_attribute *attr;
>         struct spi_controller *ctlr;
>         const struct sh_msiof_chipdata *chipdata;
>         struct sh_msiof_spi_info *info;
> @@ -1267,6 +1275,10 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
>         int i;
>         int ret;
>
> +       attr = soc_device_match(sh_msiof_blacklist);
> +       if (attr)
> +               return -ENOTSUPP;

I don't think adding more soc_device_match() calls is the proper way to
handle this...
What about adding a single check to drivers/soc/renesas/renesas-soc.c,
removing r8a77950*dts*, and removing all R-Car H3 ES1.x matches from
all drivers?

> +
>         chipdata = of_device_get_match_data(&pdev->dev);
>         if (chipdata) {
>                 info = sh_msiof_spi_parse_dt(&pdev->dev);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
