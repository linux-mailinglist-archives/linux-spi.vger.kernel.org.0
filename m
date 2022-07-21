Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9541B57C805
	for <lists+linux-spi@lfdr.de>; Thu, 21 Jul 2022 11:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbiGUJsY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 Jul 2022 05:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbiGUJsX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 Jul 2022 05:48:23 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EF4814BB;
        Thu, 21 Jul 2022 02:48:22 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id bz13so850090qtb.7;
        Thu, 21 Jul 2022 02:48:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wchHtA49Te9pgMLTq242fYyxarLoAUJKA1I+eK8RJzE=;
        b=pS3EknnTQImKqPeY+Zs9rw0nNbrKq+D1bpW/Q+KaxdPUZfFYP7xcPOx/UWfiJQbcSX
         Kqs5g8hJdkHtq9Qq088gg9iVvtZDuo0/caxkLdCpyt7yyi+vqUjCtzXKGfJtuKEc4Y+r
         AEaFVI5EyzhBE3qV1ka1zLcHtZwNV8hJUF4t4g+qPy6fupShwvr3jZM/iSS962tjXP8G
         uKCjoCfPjfkwX1at6OrY1haikcK6ISiIxQi4f3rkU9lM8OIjd3XUe+gztYpiWdiUDZiv
         zToqhcUcIDDMMG4LJzOSrG+3hKNY55jNJ7x+bjXvxhEymaiTcm6+TqnFNZiYDd0o4sOe
         EpBA==
X-Gm-Message-State: AJIora/CEe2bAOCqtDLGOYZ3jloBPunrmRCB0gIASDC25VLkvdMUjXJm
        Q+R2jtfboH5bgcyUtfLfHxC4+v6WNtXsEA==
X-Google-Smtp-Source: AGRyM1sB/VBJ1qfsYVdfAFXObw7CbM9HAl9UUSg3QI2u4bfQtR85b9EIt1K7sKF64ZGRNdTHNt/JfA==
X-Received: by 2002:a05:622a:1207:b0:318:e9f0:fc64 with SMTP id y7-20020a05622a120700b00318e9f0fc64mr32843510qtx.218.1658396901363;
        Thu, 21 Jul 2022 02:48:21 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id t28-20020a37ea1c000000b006b58d8f6181sm1152790qkj.72.2022.07.21.02.48.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 02:48:21 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-31e67c46ba2so11482127b3.2;
        Thu, 21 Jul 2022 02:48:20 -0700 (PDT)
X-Received: by 2002:a81:84c1:0:b0:31e:4e05:e4f4 with SMTP id
 u184-20020a8184c1000000b0031e4e05e4f4mr16096615ywf.384.1658396900544; Thu, 21
 Jul 2022 02:48:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220719150000.383722-1-biju.das.jz@bp.renesas.com> <20220719150000.383722-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20220719150000.383722-2-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Jul 2022 11:48:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWvyF3L=V+C9k_XqnyZyyUdCZ8nZD90d4uWPx8vh3MWHA@mail.gmail.com>
Message-ID: <CAMuHMdWvyF3L=V+C9k_XqnyZyyUdCZ8nZD90d4uWPx8vh3MWHA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] spi: spi-rspi: Add need_dmar_clr to spi_ops
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Biju,

On Tue, Jul 19, 2022 at 5:00 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> RSPI IP on RZ/{A, G2L} SoC's has the same signal for both interrupt and
> DMA transfer request. Setting DMARS register for DMA transfer
> makes the signal to work as a DMA transfer request signal and
> subsequent interrupt requests to the interrupt controller
> are masked.
>
> Currently, DMA to interrupt mode switching does not work because of this
> masking.
>
> This patch adds need_dmar_clr device configuration flag to spi_ops
> and it makes the signal to work as an interrupt request by clearing
> DMARS after DMA callback.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * Fixed the typo need_dmar_clr->rspi->ops->need_dmar_clr.

Thanks for your patch!

> --- a/drivers/spi/spi-rspi.c
> +++ b/drivers/spi/spi-rspi.c
> @@ -249,6 +249,7 @@ struct spi_ops {
>         u16 flags;
>         u16 fifo_size;
>         u8 num_hw_ss;
> +       bool need_dmar_clr;

Do you need this flag? See below.

>  };
>
>  static void rspi_set_rate(struct rspi_data *rspi)
> @@ -613,6 +614,12 @@ static int rspi_dma_transfer(struct rspi_data *rspi, struct sg_table *tx,
>                                                rspi->dma_callbacked, HZ);
>         if (ret > 0 && rspi->dma_callbacked) {
>                 ret = 0;
> +               if (rspi->ops->need_dmar_clr) {
> +                       if (tx)
> +                               dmaengine_synchronize(rspi->ctlr->dma_tx);
> +                       if (rx)
> +                               dmaengine_synchronize(rspi->ctlr->dma_rx);
> +               }

Why not call it unconditionally?
If the DMAC driver does not provide a .device_synchronize(), it is
a no-op anyway.

BTW, I don't think there is a hard dependency on patch 1/2, so
I think this patch can go in through the SPI tree.

>         } else {
>                 if (!ret) {
>                         dev_err(&rspi->ctlr->dev, "DMA timeout\n");

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
