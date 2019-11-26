Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20451109F3F
	for <lists+linux-spi@lfdr.de>; Tue, 26 Nov 2019 14:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbfKZN1Q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 Nov 2019 08:27:16 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42063 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfKZN1Q (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 26 Nov 2019 08:27:16 -0500
Received: by mail-oi1-f196.google.com with SMTP id o12so16575161oic.9;
        Tue, 26 Nov 2019 05:27:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z0wglUzR7rCjWoVjqhTVtlghAjoEz41daYvOkRvG+14=;
        b=ugxcy6AwDXJZ2PG748H4XRkOVRvlRIaJzL2Sdg+YpjJ9MLKPJR/4fQRAywKB3HGKsK
         rieMRhNuXdQPsFZuEDLqi0itFrx/sGtXS6cqQw8uZNylglN7mZSZfAiZeRGTybxEXziL
         ULE4cj6ChN17JwfcGyrWn74VsKy0OQtnwKEheijRd615zSBowR5sNFaApH+KmEXlANib
         WiwC3OJ+3k8Gu3JWIW1IgO0BHjvOFxww3BKTy2XmhqTzdA4ANqiP5ojfvhJ7UaaN1cCs
         jk0P6wiPwEQdOpWiroCdwvgoI6QTrzmph+imxOEoF+ZEf8m9gcsc13MhjxktOhlIRbm0
         Cnpg==
X-Gm-Message-State: APjAAAXq4+SdKPzEZlXqzmF+KKoNH/69bvS6B/wtMTgR5/5RoNrOq7v0
        qNaKIvG7/iMsDQ9DwMeBmvLiiLBka05GuazxAD8=
X-Google-Smtp-Source: APXvYqxjatDNnmymhSXK77Ds1PjfTNfOgOgvUKfPtpvOxsKjJ+E5FwxZFjQf053CEJW6YmvIMrUiz49Xo/q3DVnCNrw=
X-Received: by 2002:a05:6808:5d9:: with SMTP id d25mr3645904oij.54.1574774835122;
 Tue, 26 Nov 2019 05:27:15 -0800 (PST)
MIME-Version: 1.0
References: <20191126122324.v3rj7oscvjobhjxo@kili.mountain>
In-Reply-To: <20191126122324.v3rj7oscvjobhjxo@kili.mountain>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 26 Nov 2019 14:27:04 +0100
Message-ID: <CAMuHMdX52phf_dSQh3vK8QGJtvmUwDiY_0f6d7xAJ_xF2vKNfg@mail.gmail.com>
Subject: Re: [PATCH] spi: pic32: Fix an error code in pic32_spi_dma_prep()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Dan,

On Tue, Nov 26, 2019 at 1:51 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> We accidentally return success on this error path.
>
> Fixes: eb7e6dc6d9ff ("spi: pic32: Retire dma_request_slave_channel_compat()")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/spi/spi-pic32.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
> index 156961b4ca86..93fb95073522 100644
> --- a/drivers/spi/spi-pic32.c
> +++ b/drivers/spi/spi-pic32.c
> @@ -633,7 +633,8 @@ static int pic32_spi_dma_prep(struct pic32_spi *pic32s, struct device *dev)
>                 goto out_err;
>         }
>
> -       if (pic32_spi_dma_config(pic32s, DMA_SLAVE_BUSWIDTH_1_BYTE))
> +       ret = pic32_spi_dma_config(pic32s, DMA_SLAVE_BUSWIDTH_1_BYTE);
> +       if (ret)
>                 goto out_err;

This used to be non-fatal, as DMA was optional, cfr. the comment:

        /* optional DMA support */
        ret = pic32_spi_dma_prep(pic32s, &pdev->dev);
        if (ret)
                goto err_bailout;

However, as of the aforementioned commit, DMA is no longer optional,
and probe will fail instead of falling back to PIO on DMA init failure...

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
