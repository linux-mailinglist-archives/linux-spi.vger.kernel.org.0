Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BABD7104DF2
	for <lists+linux-spi@lfdr.de>; Thu, 21 Nov 2019 09:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfKUIar (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 Nov 2019 03:30:47 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40954 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfKUIaq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 Nov 2019 03:30:46 -0500
Received: by mail-oi1-f196.google.com with SMTP id d22so2440684oic.7;
        Thu, 21 Nov 2019 00:30:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5+g9mn+AxAnxlklqw4XxoiWzE23UWdDQPBVvzz3xiQM=;
        b=TGhylNBCc9abQIyDXjCjh2uu+Q5IWIXMpA9HFLxBbd0GATUqEnEunZNOePubC/dLFn
         gRl00cHzNMphnflP/pNE+n3zHoICAuI4pR2WcEybXslon3bmWUD+9o+CN+FT3gp9XwPx
         gQAAh37M2EIKT2ywqXkdWwW5G5lAlbXCEnCENV1fqfMF6qzZbNt5OVed3D2T8j8k1dHT
         NhOdekI0Wh9/N5upsgz3yCOSuCNVtFV2XFKqGaayGdH7oldfQ2TCdSVWCkUZ0zRhGdRl
         0W9qE4vf0zxPiwSOKsKfvjNdUPBrG2WcbkROzQ97dqGPRmcXmsOdMGj4BtyhYCymYA67
         R1mQ==
X-Gm-Message-State: APjAAAWxD3UNS0JCZ7+vDyrsNr4gX7NKx/qHX+eXMOdsev2sntuZzQLk
        Sv9SIW82VkUkzVjuglf80kV5TsH8G0R05ZRTN+HujrbS
X-Google-Smtp-Source: APXvYqzwAEwQE8y3WagjTaTpbSvwgwfMUmNZLcr2Mjs4tqEXzf4mm17YJlel19amaVosOqgQ+d0NWn+SQpISFnk/VlA=
X-Received: by 2002:aca:3a86:: with SMTP id h128mr6308515oia.131.1574325045753;
 Thu, 21 Nov 2019 00:30:45 -0800 (PST)
MIME-Version: 1.0
References: <20191121080954.14915-1-peter.ujfalusi@ti.com>
In-Reply-To: <20191121080954.14915-1-peter.ujfalusi@ti.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Nov 2019 09:30:34 +0100
Message-ID: <CAMuHMdVWCM_LQ5Fx+3NMhyd21LSpYQWCX2pmtkU2tHvtzDzUzw@mail.gmail.com>
Subject: Re: [PATCH] spi: pic32: Retire dma_request_slave_channel_compat()
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Mark Brown <broonie@kernel.org>, Vinod <vkoul@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Peter,

On Thu, Nov 21, 2019 at 9:11 AM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> There is no reason to use the dma_request_slave_channel_compat() as no
> filter function and parameter is provided.
>
> Switch the driver to use dma_request_chan() instead.
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> --- a/drivers/spi/spi-pic32.c
> +++ b/drivers/spi/spi-pic32.c
> @@ -609,22 +609,18 @@ static void pic32_spi_cleanup(struct spi_device *spi)
>  static void pic32_spi_dma_prep(struct pic32_spi *pic32s, struct device *dev)
>  {
>         struct spi_master *master = pic32s->master;
> -       dma_cap_mask_t mask;
>
> -       dma_cap_zero(mask);
> -       dma_cap_set(DMA_SLAVE, mask);
> -
> -       master->dma_rx = dma_request_slave_channel_compat(mask, NULL, NULL,
> -                                                         dev, "spi-rx");
> -       if (!master->dma_rx) {
> +       master->dma_rx = dma_request_chan(dev, "spi-rx");

Why not dma_request_slave_channel()?
That way you...

> +       if (IS_ERR(master->dma_rx)) {

... don't have to change the NULL check here, and...

>                 dev_warn(dev, "RX channel not found.\n");
> +               master->dma_rx = NULL;

...  don't have to override by NULL here.

(same for TX below).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
