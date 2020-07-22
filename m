Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D8B2297ED
	for <lists+linux-spi@lfdr.de>; Wed, 22 Jul 2020 14:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgGVMLQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Jul 2020 08:11:16 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:33697 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgGVMLQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 Jul 2020 08:11:16 -0400
Received: by mail-yb1-f195.google.com with SMTP id c14so910528ybj.0;
        Wed, 22 Jul 2020 05:11:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QSzoFOHUVmdm4+hpeLW9BMuGWntrq3KBdAl5nKJE4ps=;
        b=p70+BdQS656XB/0BOEw8ZSckiChqzR6wdEVDwCR43rt4J8WrA9BtQQR/aDyZO4kpGB
         3lsddM4Y6/kwSdGBiIpPljbGpJN9KrxFFLiXfO+s4GRVeV03XmrEfdWpdwPg2cXcBkqO
         +1Q9LXLQulKEepQgJ1n9LHa4bkTjCMTMjQ/RyNXyPmH87mVgLQXgB+SDOSW93WluR8uj
         NnCCYPPtCm0jCNfq8DmVG4KzhZxt7wP47G06kjVti1DcWwNpsxy40UxF1Cw9GIveSpsU
         +t0tRPzM4bE6BunctVCKxz7rJZ0WPnuLRlD12velWaX89NcWKX11ujXwH6VzppAsblML
         KzbQ==
X-Gm-Message-State: AOAM533sfKniqJ4FR3PHSWRAFLW4XO59VlPOHGsjzJANUAUKcxLRScux
        SiRAp5xzTrqaV6azgWcYuzNX4EUVxXC619+z2IvRItLcJEA=
X-Google-Smtp-Source: ABdhPJzRMVQYlhD6DYgcKzuIAQLHgDTW8w/WF8ctS41NuxZJloe1qDI7RMbTqoJfUjaJlF1n3JQLTY6Ou377ANN0qaU=
X-Received: by 2002:a25:bc13:: with SMTP id i19mr46664332ybh.391.1595419874918;
 Wed, 22 Jul 2020 05:11:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200722083737.8820-1-jon.lin@rock-chips.com> <20200722083737.8820-3-jon.lin@rock-chips.com>
In-Reply-To: <20200722083737.8820-3-jon.lin@rock-chips.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Wed, 22 Jul 2020 14:11:03 +0200
Message-ID: <CANBLGczKsvrOb-AnB3MGi2RJOuFDoSY=S8enLtJZVAV2baGUgg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] spi: rockchip: Fix error in SPI slave pio read
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

On Wed, 22 Jul 2020 at 10:38, Jon Lin <jon.lin@rock-chips.com> wrote:
>
> The RXFLR is possible larger than rx_left in Rockchip SPI, fix it.
>
> Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>

In addition to my review and test you should probably also add
Fixes: 01b59ce5dac8 ("spi: rockchip: use irq rather than polling")
..so this will be picked up in the stable trees

/Emil

> ---
>  drivers/spi/spi-rockchip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
> index a451dacab5cf..75a8a9428ff8 100644
> --- a/drivers/spi/spi-rockchip.c
> +++ b/drivers/spi/spi-rockchip.c
> @@ -291,7 +291,7 @@ static void rockchip_spi_pio_writer(struct rockchip_spi *rs)
>  static void rockchip_spi_pio_reader(struct rockchip_spi *rs)
>  {
>         u32 words = readl_relaxed(rs->regs + ROCKCHIP_SPI_RXFLR);
> -       u32 rx_left = rs->rx_left - words;
> +       u32 rx_left = (rs->rx_left > words) ? rs->rx_left - words : 0;
>
>         /* the hardware doesn't allow us to change fifo threshold
>          * level while spi is enabled, so instead make sure to leave
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
