Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB962297E0
	for <lists+linux-spi@lfdr.de>; Wed, 22 Jul 2020 14:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgGVMIz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Jul 2020 08:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgGVMIz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 Jul 2020 08:08:55 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4397CC0619DC;
        Wed, 22 Jul 2020 05:08:55 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id f5so904014ybq.2;
        Wed, 22 Jul 2020 05:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HvC8ad5rjg2IunVWJE+2JRXHYjvknY0W00tjjNXhDJw=;
        b=JaGepEyO3/2Mwq94HzcA/vVuWypbWebAAaQXRw9lKQHh5De4jugvGiBWMrc+zSLUkd
         ckk88dfn6mxXeOdhZwfhUE6jh3DWtMWRBKLrghZL3UGeXNRs8WqSa1OKWwI4WGH6NOTb
         92zopyuLWTf473z1oLesR4sDrd1hM8tKWv3SMG9KB/rytQePVPw0V9fOkVZItcD695jX
         YEY7cZDmZdg13vlqEZMUL6cz0Tu3pkASqh2H5afkq3ywJTa3/r0Jf2n/n0mTQdcqSVrk
         nmQ8TZC/+ZVmHTrW5SkCMV2m/3AvCWJZLs5SjpxO24INcplGPa8w3YZgRK1SJMdiyeof
         Rssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HvC8ad5rjg2IunVWJE+2JRXHYjvknY0W00tjjNXhDJw=;
        b=DqNnbVLwt4sDji2Oq1v+1nzx6tWmRWBlXOLH4rL0XhJtg9VbjqXkkcNKWc8Q56V3v9
         Rrca1q7+zrCBUNTpoSk5cnYV0TaHsayHgZIeXAHn+Xy7pxYm6HhQPF4c8/brpk9ci69X
         LTrLTy7326RlPDLz2ebz/4yrGYd5BeDEgWuQ+0VKwlRAw4+CuR2+J8EwpLLm9okuJZEn
         wyi3ff17HawJpWCSE4oDqZd8hK5OAVYFiN3+CAh9c8XBDmsTSgCAKqTp5LLQt6Jhl1Y0
         Ywb5HcUl0co3wGYV5RedV5Nsc1VAu84t5yV7WFjrcQMo2XOtDVeWV7dRnYQ5o7xChWd1
         G/UQ==
X-Gm-Message-State: AOAM531gBx2x63nDplwatWBihFKmyrHis5llJBgIlr2MTSi4ujCdhKI5
        CEGmdKWL11KDvi+E247pg9aMYeZ6EpVP6/R8ggbktw==
X-Google-Smtp-Source: ABdhPJzo3VlRwf2J2i7juNCAZtOnMfYT9zz3p+Vj9hGzOA6DM0cDjbQXztJqjBGHakszFwdlxoHjU6TdGGLJQ/I0CK0=
X-Received: by 2002:a25:6806:: with SMTP id d6mr46157046ybc.124.1595419734592;
 Wed, 22 Jul 2020 05:08:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200722083737.8820-1-jon.lin@rock-chips.com>
In-Reply-To: <20200722083737.8820-1-jon.lin@rock-chips.com>
From:   Emil Renner Berthing <emil.renner.berthing@gmail.com>
Date:   Wed, 22 Jul 2020 14:08:43 +0200
Message-ID: <CANBLGcxZ+ps5TNzrHNHyjUZvSTrVQOHaqvB5H3tZVOow5z0aLQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] spi: rockchip: Config spi rx dma burst size depend
 on xfer length
To:     Jon Lin <jon.lin@rock-chips.com>
Cc:     Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 22 Jul 2020 at 10:41, Jon Lin <jon.lin@rock-chips.com> wrote:
>
> The burst length can be adjusted according to the transmission
> length to improve the transmission rate
>
> Signed-off-by: Jon Lin <jon.lin@rock-chips.com>

For the whole series you can add
Reviewed-by: Emil Renner Berthing <kernel@esmil.dk>
Tested-by: Emil Renner Berthing <kernel@esmil.dk>

> ---
>  drivers/spi/spi-rockchip.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
> index 9b8a5e1233c0..63593a5b87fa 100644
> --- a/drivers/spi/spi-rockchip.c
> +++ b/drivers/spi/spi-rockchip.c
> @@ -384,6 +384,19 @@ static void rockchip_spi_dma_txcb(void *data)
>         spi_finalize_current_transfer(ctlr);
>  }
>
> +static u32 rockchip_spi_calc_burst_size(u32 data_len)
> +{
> +       u32 i;
> +
> +       /* burst size: 1, 2, 4, 8 */
> +       for (i = 1; i < 8; i <<= 1) {
> +               if (data_len & i)
> +                       break;
> +       }
> +
> +       return i;
> +}
> +
>  static int rockchip_spi_prepare_dma(struct rockchip_spi *rs,
>                 struct spi_controller *ctlr, struct spi_transfer *xfer)
>  {
> @@ -397,7 +410,8 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs,
>                         .direction = DMA_DEV_TO_MEM,
>                         .src_addr = rs->dma_addr_rx,
>                         .src_addr_width = rs->n_bytes,
> -                       .src_maxburst = 1,
> +                       .src_maxburst = rockchip_spi_calc_burst_size(xfer->len /
> +                                                                    rs->n_bytes),
>                 };
>
>                 dmaengine_slave_config(ctlr->dma_rx, &rxconf);
> @@ -525,7 +539,8 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
>                 writel_relaxed(rs->fifo_len / 2 - 1, rs->regs + ROCKCHIP_SPI_RXFTLR);
>
>         writel_relaxed(rs->fifo_len / 2, rs->regs + ROCKCHIP_SPI_DMATDLR);
> -       writel_relaxed(0, rs->regs + ROCKCHIP_SPI_DMARDLR);
> +       writel_relaxed(rockchip_spi_calc_burst_size(xfer->len / rs->n_bytes) - 1,
> +                      rs->regs + ROCKCHIP_SPI_DMARDLR);
>         writel_relaxed(dmacr, rs->regs + ROCKCHIP_SPI_DMACR);
>
>         /* the hardware only supports an even clock divisor, so
> --
> 2.17.1
>
>
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
