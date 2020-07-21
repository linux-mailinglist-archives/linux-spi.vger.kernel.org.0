Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B5B228B84
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jul 2020 23:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbgGUVlY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Jul 2020 17:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbgGUVlY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Jul 2020 17:41:24 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C3AC061794;
        Tue, 21 Jul 2020 14:41:24 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id l6so10815318plt.7;
        Tue, 21 Jul 2020 14:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WM01wnLhf7dJUXo6TRfFaK2BruNuZ8X0QkexXwSL96Q=;
        b=E18YyFBSkzKaV4jgaMLsVkJNcKYKBJI6lnUK6fjEdTwBE9YIO2fkD21QsoZvbmqn+Z
         Z/nEyG/c3A2xG1kQKOiEn9MgOY99xRZMd9cCBfLocUcELDOsGXOFomdUdvydkNl2rmqv
         EdiEsv02qQ7/6jKGN+xXcFbs2JrwfGcsTh+OUUojx2hjdkMl5VDkK63wtwgYd1KUgOHN
         HpdeQmFN0BBribjsKIpr2daWvlQel9mp5UxzcdKqEApDBmSN04oAuFhZQpAzF+6bvcY/
         flSLMyO7UaNPu4BWrTZ1R2KzJQROZVJgc5BwVojQYI+Swc0alwIthDBLgXpv5JWPt4C+
         WAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WM01wnLhf7dJUXo6TRfFaK2BruNuZ8X0QkexXwSL96Q=;
        b=Ylb6lJp5B6rqOgGyF2WOs1MvmF1MSmwTazDkwow3/+5xWk/Hjr4IYbchYGu3dXPTDn
         EEyZx860fWjjK9e9jnX+Xg2jPCpyWmXuof8pb34uQsV4sGQm5SUGW061B8D/z8Tm/L/q
         KBaVgczMzzy8MAhMpIH2HMoYHa9AttubknZCXmDywCN3jb+hjv/+m4zm75g98e2SgH/T
         B9IevLjHe/z3TyDAwJd9XraVTc7yxbuVXgTWC0LFUcmqHtjR00lou6Oou6taPwyXCMPx
         +TX8ZUE0Bagj1O/YUJcZmImzxaPwuWZ6i5xLiwVk6QPAAZ3H2Vrq3tK+mcDiwrHzLrmj
         cpKA==
X-Gm-Message-State: AOAM530v1GuFnh6zZz9k2WUXansbTTZN64JiChusRcjOYo3wlvu/BxVr
        PhYxpEGvwjdUU9GNLi8t5zkaGu7jeIavD2dYU50=
X-Google-Smtp-Source: ABdhPJw8BeaR89GDAcCrABVZVM0ZLYfTCc2lCN6v71KacsCzeOwbZ4ObTbUTiKADMuvO8jyeKKij64QQvizEIkev+SI=
X-Received: by 2002:a17:90b:3547:: with SMTP id lt7mr6728411pjb.181.1595367683740;
 Tue, 21 Jul 2020 14:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200721203951.2159-1-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200721203951.2159-1-Sergey.Semin@baikalelectronics.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 22 Jul 2020 00:41:07 +0300
Message-ID: <CAHp75VccnfuevjDG1xX8Lz46yJDac7GnWPcxf0NiSo8dxe2MDg@mail.gmail.com>
Subject: Re: [PATCH] spi: dw-dma: Fix Tx DMA channel working too fast
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Feng Tang <feng.tang@intel.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Jul 21, 2020 at 11:39 PM Serge Semin
<Sergey.Semin@baikalelectronics.ru> wrote:
>
> It turns out having a Rx DMA channel serviced with higher priority than
> a Tx DMA channel is not enough to provide a well balanced DMA-based SPI
> transfer interface. There might still be moments when the Tx DMA channel
> is occasionally handled faster than the Rx DMA channel. That in its turn
> will eventually cause the SPI Rx FIFO overflow if SPI bus speed is high
> enough to fill the SPI Rx FIFO in before it's cleared by the Rx DMA
> channel. That's why having the DMA-based SPI Tx interface too optimized
> is the errors prone, so the commit 0b2b66514fc9 ("spi: dw: Use DMA max
> burst to set the request thresholds") though being perfectly normal from
> the standard functionality point of view implicitly introduced the problem
> described above. In order to fix that the Tx DMA activity is intentionally
> slowed down by limiting the SPI Tx FIFO depth with a value twice bigger
> than the Tx burst length calculated earlier by the
> dw_spi_dma_maxburst_init() method.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Thanks!

> Fixes: 0b2b66514fc9 ("spi: dw: Use DMA max burst to set the request thresholds")
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Feng Tang <feng.tang@intel.com>
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  drivers/spi/spi-dw-dma.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
> index 5986c520b196..bb390ff67d1d 100644
> --- a/drivers/spi/spi-dw-dma.c
> +++ b/drivers/spi/spi-dw-dma.c
> @@ -372,8 +372,20 @@ static int dw_spi_dma_setup(struct dw_spi *dws, struct spi_transfer *xfer)
>  {
>         u16 imr = 0, dma_ctrl = 0;
>
> +       /*
> +        * Having a Rx DMA channel serviced with higher priority than a Tx DMA
> +        * channel might not be enough to provide a well balanced DMA-based
> +        * SPI transfer interface. There might still be moments when the Tx DMA
> +        * channel is occasionally handled faster than the Rx DMA channel.
> +        * That in its turn will eventually cause the SPI Rx FIFO overflow if
> +        * SPI bus speed is high enough to fill the SPI Rx FIFO in before it's
> +        * cleared by the Rx DMA channel. In order to fix the problem the Tx
> +        * DMA activity is intentionally slowed down by limiting the SPI Tx
> +        * FIFO depth with a value twice bigger than the Tx burst length
> +        * calculated earlier by the dw_spi_dma_maxburst_init() method.
> +        */
>         dw_writel(dws, DW_SPI_DMARDLR, dws->rxburst - 1);
> -       dw_writel(dws, DW_SPI_DMATDLR, dws->fifo_len - dws->txburst);
> +       dw_writel(dws, DW_SPI_DMATDLR, dws->txburst);
>
>         if (xfer->tx_buf)
>                 dma_ctrl |= SPI_DMA_TDMAE;
> --
> 2.26.2
>


-- 
With Best Regards,
Andy Shevchenko
