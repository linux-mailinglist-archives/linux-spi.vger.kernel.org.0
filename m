Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F044C4D05FC
	for <lists+linux-spi@lfdr.de>; Mon,  7 Mar 2022 19:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244655AbiCGSIV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Mar 2022 13:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237926AbiCGSIV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Mar 2022 13:08:21 -0500
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA2B7DE3C;
        Mon,  7 Mar 2022 10:07:25 -0800 (PST)
Received: by mail-qv1-f51.google.com with SMTP id jo29so390828qvb.5;
        Mon, 07 Mar 2022 10:07:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q3yijxFHndVHAY/joGE3a6x6Dt4fkQNCK4Gyn5EJvy4=;
        b=uWPS98WCa5c32vT7WhhKurUep+c/c535SzFXlUrYumnZEAho9vkcHgmXsES0c0qb/D
         YBwXNeelwWamRCcu1owv8duQIqJU5DNhShu3gycrf6uq4ygPtiuH6YVoveP2YiY6drik
         An0ySWCypbARGL+Aa/XchziZ1q+fQJ+Ruo9enz1psALpvejx3hU6xZSvgcx7A5dq092u
         ZOc9LyxmOJal8hi92hNv7Gpfesx4F1rzn+fTKVaE2XnQYuhGHecC4wbSrKKk24Us7yOs
         NtYJgdpu4+aq6PVjOlFZ+0ebJ8UxfbAXnGcquDUM+CxjmdddA7AnboSrbQNym51WHB7z
         C+dQ==
X-Gm-Message-State: AOAM531ZOV63rTK/KzJe0yrY/Z42AzVwsvJ93E8Az9BOX1RfBF0HlLdr
        g2U5q4zGPCKaAVJO2xanSbN9LQZB/XAGCw==
X-Google-Smtp-Source: ABdhPJxS7buubgcqnWwnSceDRNjVxK6nH2FDit1yj0Eb6KsJP2nnE2izdyQ+rNyLLnxmin32xJJtgQ==
X-Received: by 2002:a05:6214:2607:b0:435:49c6:5c7c with SMTP id gu7-20020a056214260700b0043549c65c7cmr9058956qvb.23.1646676444478;
        Mon, 07 Mar 2022 10:07:24 -0800 (PST)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id o200-20020a37a5d1000000b0064904a35862sm6337981qke.96.2022.03.07.10.07.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 10:07:24 -0800 (PST)
Received: by mail-yb1-f180.google.com with SMTP id h126so32695961ybc.1;
        Mon, 07 Mar 2022 10:07:24 -0800 (PST)
X-Received: by 2002:a25:8486:0:b0:619:9fba:895e with SMTP id
 v6-20020a258486000000b006199fba895emr8968128ybk.342.1646676443785; Mon, 07
 Mar 2022 10:07:23 -0800 (PST)
MIME-Version: 1.0
References: <20220307180116.8388-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20220307180116.8388-1-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Mar 2022 19:07:12 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXPpM7nU=MZV=xJxZiOGyRGbgzuKxBR9EJsGJLWfD+Cbw@mail.gmail.com>
Message-ID: <CAMuHMdXPpM7nU=MZV=xJxZiOGyRGbgzuKxBR9EJsGJLWfD+Cbw@mail.gmail.com>
Subject: Re: [PATCH] spi: Fix invalid sgs value
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Biju,

On Mon, Mar 7, 2022 at 7:01 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> max_seg_size is unsigned int and it can have a value up to 2^32
> (for eg:-RZ_DMAC driver sets dma_set_max_seg_size as U32_MAX)
> When this value is used in min_t() as an integer type, it becomes
> -1 and the value of sgs becomes 0.
>
> Fix this issue by replacing the 'int' data type with 'unsigned int'
> in min_t().
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1019,10 +1019,10 @@ int spi_map_buf(struct spi_controller *ctlr, struct device *dev,
>         int i, ret;
>
>         if (vmalloced_buf || kmap_buf) {
> -               desc_len = min_t(int, max_seg_size, PAGE_SIZE);
> +               desc_len = min_t(unsigned int, max_seg_size, PAGE_SIZE);
>                 sgs = DIV_ROUND_UP(len + offset_in_page(buf), desc_len);
>         } else if (virt_addr_valid(buf)) {
> -               desc_len = min_t(int, max_seg_size, ctlr->max_dma_len);
> +               desc_len = min_t(unsigned int, max_seg_size, (unsigned int)ctlr->max_dma_len);

The cast of the last parameter is not needed.

>                 sgs = DIV_ROUND_UP(len, desc_len);
>         } else {
>                 return -EINVAL;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
