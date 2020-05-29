Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEB41E778A
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 09:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgE2Hzu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 03:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgE2Hzt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 29 May 2020 03:55:49 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F482C03E969;
        Fri, 29 May 2020 00:55:49 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d10so1041788pgn.4;
        Fri, 29 May 2020 00:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z6s9/IaXr38uOMZ+KBf1YjM+loSDtVV15aQ5SUi0HAc=;
        b=fMC2fYocOCX/Im4iA/3EX4G9gDKBG7O9eP4LUGsZgCVv66R7lTBjYYYhYhhKjmpj0g
         p0xCkjTLNdHk8YRT95VVHiPtTL5pXPkAdwJg7iXmOHX/K/DoKoX7lvpueEQILVddYCk7
         BIvsDQIG/GrfCahFkmedOQcoeWqB1D/yVMdECGdjNTABpxzIykzIl0J9DdrrUfYq7dPk
         Mt4eG4vKx0/0eads3hx6C2T8omGrgLIvqKP77b/wOGy3RIztME6uHkfeSP5Ph1597w5b
         xyJPhQkzAV5IIql3/FCEdspoE/odHk4CRiG2p+FLZwONEPBSKvjlgKzLJLViAytdJYmf
         1SiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z6s9/IaXr38uOMZ+KBf1YjM+loSDtVV15aQ5SUi0HAc=;
        b=pRjjXncrVUrPGqBhH4V6o811uB0ussUBujwg2RwX4rkotW++k35lR8xCeO3XQ+5lXY
         j67v+Xl+wBOlxwD1dMoi6WkHi3/VNen5pFaXUA8F20LrMqi/US6qEi+XxIm+YWkt/gj3
         u4IfEzYuw5fSxkzNQ9WtNw3OSK4US3tYgNaDPx2YI0nqWwnja8Ly9US5E/k3/CH52yUz
         wmDanbiSgF62u7PKWUdMRRAS2eXLAHGHfplyH42yDMQCtokx3AORE5/+9Im+gEo2f/FS
         5PJAQHimuxo1+bp6aEoHOBpW4OK7J3u0k3g5Udo13ocE59dJd1iNow92jGa4fPt82ue3
         dltg==
X-Gm-Message-State: AOAM531apg32BLoohv0HKq3QgYQJ40U2bmjzKPbdQmwvRQ+hQnzj1oXr
        V91l34T7mO1Nv55xwL7VFB7jLsD3RTde2IfNc74=
X-Google-Smtp-Source: ABdhPJztQPvnGR2j1lYeQ00/q9iGVvqSwY7oChWZphjYzN55gXTDuT+PJSQMkK+P5HpKDJN8mMSW9rH8kKjsRQY2Epw=
X-Received: by 2002:a63:c109:: with SMTP id w9mr683396pgf.203.1590738948699;
 Fri, 29 May 2020 00:55:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200529035915.20790-1-Sergey.Semin@baikalelectronics.ru> <20200529035915.20790-4-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200529035915.20790-4-Sergey.Semin@baikalelectronics.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 29 May 2020 10:55:32 +0300
Message-ID: <CAHp75VcT2zKnuRW3uxCQtbF0A65cbS20OFpz9sX0hftbjFp1hA@mail.gmail.com>
Subject: Re: [PATCH v5 03/16] spi: dw: Locally wait for the DMA transactions completion
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>, Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 29, 2020 at 7:02 AM Serge Semin
<Sergey.Semin@baikalelectronics.ru> wrote:
>
> Even if DMA transactions are finished it doesn't mean that the SPI
> transfers are also completed. It's specifically concerns the Tx-only
> SPI transfers, since there might be data left in the SPI Tx FIFO after
> the DMA engine notifies that the Tx DMA procedure is done. In order to
> completely fix the problem first the driver has to wait for the DMA
> transaction completion, then for the corresponding SPI operations to be
> finished. In this commit we implement the former part of the solution.
>
> Note we can't just move the SPI operations wait procedure to the DMA
> completion callbacks, since these callbacks might be executed in the
> tasklet context (and they will be in case of the DW DMA). In case of
> slow SPI bus it can cause significant system performance drop.

I read commit message, I read the code. What's going on here since you
repeated xfer_completion (and its wait routine) from SPI core and I'm
wondering what happened to it? Why we are not calling
spi_finalize_current_transfer()?

...

>         dws->master->cur_msg->status = -EIO;
> -       spi_finalize_current_transfer(dws->master);
> +       complete(&dws->dma_completion);
>         return IRQ_HANDLED;

...

> +static int dw_spi_dma_wait(struct dw_spi *dws, struct spi_transfer *xfer)
> +{
> +       unsigned long long ms;
> +
> +       ms = xfer->len * MSEC_PER_SEC * BITS_PER_BYTE;
> +       do_div(ms, xfer->effective_speed_hz);
> +       ms += ms + 200;
> +
> +       if (ms > UINT_MAX)
> +               ms = UINT_MAX;
> +
> +       ms = wait_for_completion_timeout(&dws->dma_completion,
> +                                        msecs_to_jiffies(ms));
> +
> +       if (ms == 0) {
> +               dev_err(&dws->master->cur_msg->spi->dev,
> +                       "DMA transaction timed out\n");
> +               return -ETIMEDOUT;
> +       }
> +
> +       return 0;
> +}
> +
>  /*
>   * dws->dma_chan_busy is set before the dma transfer starts, callback for tx
>   * channel will clear a corresponding bit.
> @@ -155,7 +184,7 @@ static void dw_spi_dma_tx_done(void *arg)
>                 return;
>
>         dw_writel(dws, DW_SPI_DMACR, 0);
> -       spi_finalize_current_transfer(dws->master);
> +       complete(&dws->dma_completion);
>  }
>
>  static struct dma_async_tx_descriptor *dw_spi_dma_prepare_tx(struct dw_spi *dws,
> @@ -204,7 +233,7 @@ static void dw_spi_dma_rx_done(void *arg)
>                 return;
>
>         dw_writel(dws, DW_SPI_DMACR, 0);
> -       spi_finalize_current_transfer(dws->master);
> +       complete(&dws->dma_completion);
>  }


-- 
With Best Regards,
Andy Shevchenko
