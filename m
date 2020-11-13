Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCAA02B2598
	for <lists+linux-spi@lfdr.de>; Fri, 13 Nov 2020 21:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgKMUfC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 13 Nov 2020 15:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgKMUfB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 13 Nov 2020 15:35:01 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156F8C0613D1
        for <linux-spi@vger.kernel.org>; Fri, 13 Nov 2020 12:35:01 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id p12so12368326ljc.9
        for <linux-spi@vger.kernel.org>; Fri, 13 Nov 2020 12:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TkL0oRxLd+RpJcVYO3hleX+p2OpPCj93CNP9Re1iIG0=;
        b=LVIM3Q46Ts329GSElh0N1secO3c3eG0uXSenLDW/tb79+Yv/h7ojce5HElrGI35agT
         VATGg6KYgfiLIc8Wq2+HGTfC9J35Qz0/8eX9Dz0tKAgJD8o4hCvbup4cuDp/EqTkINJk
         3xIlI3A50W1Vrn2soT/j+HPEOcWD9Dl1O7V+uH6RrftaH8UhVv08KX+iZc+yFYxdPimG
         3wTlUHCmLo3e08A5n+1/6MCJzehEhoVs3cPC9LikHz9AJVtSRcz+bbBL+BFyOo3tmFoQ
         0Eou35k6ly4NbfNfaBVK7a2evWs97HJuD0uJiYX3JmF1trANd4nbqdoej9mHb9YkLqvL
         j0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TkL0oRxLd+RpJcVYO3hleX+p2OpPCj93CNP9Re1iIG0=;
        b=QxFNzz3QWe3O8TDG/U/xUaha+V+fycBDnXsP5lfiMDcXnRLNrOU27KiKCJt0Evy6Ps
         LM9NQ0ILkZmQAm9ektf2Ck29/fTfBXUCHfOrR1Qx3VF8mZoHWsfSEqb/CjTRBAKDwHKr
         eX8+MBmZznTnwHalRNZfpG/i8t/Z7dwPQ6XIP6oaW99io9iv0UCuBZqjpAzmtyNidexu
         j2zmHMs9iJjdkmD/TgvhGsdwSsj2xHwi8m8MYyp8616Lf50mxMp5WvzT1Q5kd4Yy7yeY
         +X6nfkljdk700o3UzAzXOaIJVV1xVv5F2EIuJZVvigkrsBKv7Fkchn3Lu9BbmtfB6cyT
         pusg==
X-Gm-Message-State: AOAM53210CKhWkZarfj7FagLdcsEayWe2oJ0N7/HvqB/0PCE2WbZY51O
        lqi9O3UDREu4vMPfZNDnr/mortJ2yXMyo4N9DOdjNGfdfrM1Fw==
X-Google-Smtp-Source: ABdhPJxj1xv6BLLEYL0+JlSn5XGLAUydDNsM7KU5slTU7h/rzxXgEXwu5niaql3W0dg/Hxr3uSGUbgg2gXsx4dJNXE4=
X-Received: by 2002:a2e:b0ec:: with SMTP id h12mr1822381ljl.379.1605299699466;
 Fri, 13 Nov 2020 12:34:59 -0800 (PST)
MIME-Version: 1.0
References: <CAMS2kBHyempbPTT5dnJ8Vb+FMop4-BjyKa4A=tB+U-cS4h7aDw@mail.gmail.com>
 <1ef36838-81f1-5b64-bcf5-69c1bb1ff082@ti.com> <CAMS2kBFmr3s8Y=ssyFGcZTNFRg3rAS_23X6UyxEYWSr8ere+wQ@mail.gmail.com>
 <8f2b3cd4-83ab-cf74-9109-501525d52d0f@ti.com>
In-Reply-To: <8f2b3cd4-83ab-cf74-9109-501525d52d0f@ti.com>
From:   Glenn Schmottlach <gschmottlach@gmail.com>
Date:   Fri, 13 Nov 2020 15:34:48 -0500
Message-ID: <CAMS2kBE2tKJVZ2A5z4CtNK=36vjwyvUjYSoC3GUVSvrAxhUi-w@mail.gmail.com>
Subject: Re: Linux SPI Slave fails to respond under high load on BeagleBone Black
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-spi@vger.kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Nov 13, 2020 at 10:08 AM Vignesh Raghavendra <vigneshr@ti.com> wrote:

>
> Does the transfer resume if you manually updated WCNT field to a
> value > 32 using devmem2 when slave appears to be "stuck"?
>

Unfortunately, no, the slave does not become unstuck. I can see that
the WCNT field typically drops back to zero but nothing appears to
happen.

>
>
> Could you see if below diff helps? This delays enabling of channel
> until TX DMA is queued so that WCNT does not decrement
>
>
> diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
> index d4c9510af393..bf8c6526bcd7 100644
> --- a/drivers/spi/spi-omap2-mcspi.c
> +++ b/drivers/spi/spi-omap2-mcspi.c
> @@ -426,6 +426,8 @@ static void omap2_mcspi_tx_dma(struct spi_device *spi,
>         }
>         dma_async_issue_pending(mcspi_dma->dma_tx);
>         omap2_mcspi_set_dma_req(spi, 0, 1);
> +       if (spi_controller_is_slave(master))
> +               omap2_mcspi_set_enable(spi, 1);
>  }
>
>  static unsigned
> @@ -1194,7 +1196,9 @@ static int omap2_mcspi_transfer_one(struct spi_master *master,
>                     master->can_dma(master, spi, t))
>                         omap2_mcspi_set_fifo(spi, t, 1);
>
> -               omap2_mcspi_set_enable(spi, 1);
> +               /* For slave TX, enable after DMA is queued */
> +               if (!spi_controller_is_slave(master) || !t->tx_buf)
> +                       omap2_mcspi_set_enable(spi, 1);
>
>                 /* RX_ONLY mode needs dummy data in TX reg */
>                 if (t->tx_buf == NULL)

I made this change and initially thought it improved things but as the
clock speed is increased (> 10000 Hz) it reverts to the prior
behavior. I can almost see the SPI slave stutter/stammer along until
it finally stops responding to the SPI master. At this point WCNT == 0
and poking in a value > 32 has no effect. From my testing I can
definitely see a dramatic decline in performance (or susceptibility
for the SPI slave to get "stuck") as the clock rate increases. For my
use case, the SPI slave generates telemetry and thus discards all
incoming data from the MOSI pin. Likewise my SPI master is only
interested in the MISO data. I hacked up the spi-pipe application to
provide no TX buffer for the SPI master (thus clocking out zeros to
the SPI slave). Likewise for the SPI slave the spi-pipe program does
not provide an RX buffer since the clock is merely being used to clock
"out" telemetry data to the SPI master. Making this change offers some
improvement but it usually doesn't last long.

It certainly seems there is one (or more) race conditions. Very
rarely, a test will run indefinitely but in general it's not
repeatable. It seems that the SPI slave must be able to atomically
submit a TX buffer in order for this to work. Given your patch, it
appears it must be difficult to thread in successive TX buffers since
the DMA must be scheduled and WCNT set appropriately in order to clock
out data from the slave. Of course this all has to happen while the
SPI master randomly clocks data to/from the slave. Perhaps if I had a
better understanding of the normal program flow I could see this more
clearly. Do you have any additional suggestions I could investigate?
Certainly, this problem is easy to recreate with two development
boards (or BeagleBone Blacks in my case). Have you ever encountered it
in your testing?

Thanks,

Glenn
