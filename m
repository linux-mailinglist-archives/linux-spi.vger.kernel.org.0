Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446FF3DF498
	for <lists+linux-spi@lfdr.de>; Tue,  3 Aug 2021 20:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239099AbhHCSVQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Aug 2021 14:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239097AbhHCSVL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 Aug 2021 14:21:11 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E49C06175F;
        Tue,  3 Aug 2021 11:20:59 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id dw2-20020a17090b0942b0290177cb475142so5104969pjb.2;
        Tue, 03 Aug 2021 11:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7wjJjxr5NY0mlwpeyO/0mlW4pSwnhPT8csogJcd6W20=;
        b=oTWlF+ytCtIPrUcUvp8jE0sc3VSofJeRtWtO50ijRo8f4zlLr1u+0xzEwZr5wKCb3S
         kafEZY+V7A1q1MGb7sfDAAg9/QhwYKV2pK0upfGL3mTUpGB/TEo+ymwfJd9bsRt18yoY
         57JKveqpiuCBW7pDdTBcPeGR3cioqGdDn7F/I9DvN283Sm6U8H5ar9nLcYP3JNeopFVx
         /Amsh+qQ6e5PC2cDVkSDGuak4hOLwgmk2n0d9L/gzCKK7l2MTSNLFcXskIvxqTCHY/bJ
         r2VLi3663hCYx2AtShEcDY3J0kbhIiiuNiiLUJj6Z/POYZNte3GmzrOWeDdWywb6rhRG
         4kwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7wjJjxr5NY0mlwpeyO/0mlW4pSwnhPT8csogJcd6W20=;
        b=lVZEkzAYJiphTWazviuC4+ByFfw98E6KB4n/XteRTX4JPDMhhf4hp/XG+6Q0xTXSXd
         OcyIiXdXat08kzTHQqbJeJmgBAxI/5Au66ad6WQn6rT3Eod2QS8aHH+4O+cXb++8sYqz
         uaxFGagtY9sAVVDPtYFjiTm8BWoutsv488GCL8AvEC7+/ROtAmDrNV1BIBJfarrS7JPo
         H0EbXh7voA76aTIpAasw4QmG4ujsGk2a46sb+aovpad0RXgbS2nw83jNyLPZw27i5JbL
         2uDhRdNyhuLr81NQMfSrtEYpueWj+KkFXpXtOEaZqLdeMapfdk2zh3iGu0V2N7s1X36m
         rf/g==
X-Gm-Message-State: AOAM531GpjCD0Qsq11LIjBYaVi90xeGazVg0QzEH+glN0D9vNCogwxSx
        ytPST3m5JXbmIZ32cG/GL6NNGVW14Oy+WzmZRoI=
X-Google-Smtp-Source: ABdhPJzZT0+vtNBMGVaB8Nb80jJILp9VjVeN4ZHUp/Ifl25xewd/m4FajCdsFVO6zIQQgTLr+fZlDuaC9zZgdT9ply8=
X-Received: by 2002:a17:90a:b10b:: with SMTP id z11mr5690793pjq.181.1628014858846;
 Tue, 03 Aug 2021 11:20:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210803102428.6476-1-Mason.Zhang@mediatek.com>
In-Reply-To: <20210803102428.6476-1-Mason.Zhang@mediatek.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 3 Aug 2021 21:20:19 +0300
Message-ID: <CAHp75VcPhBB+21wVErWRq+mSDaCkpQBovn+xvMbXyfENnuu40Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] spi: mediatek: modify set_cs_timing callback
To:     Mason Zhang <Mason.Zhang@mediatek.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Aug 3, 2021 at 1:42 PM Mason Zhang <Mason.Zhang@mediatek.com> wrote:
>
> This patch modified set_cs_timing callback:
>   1 support spi_device set cs_timing in their driver;
>   2 support set absolute time but no clk count, because;
>     clk src will change in different platform;
>   3 call this function in prepare_message but not in other API.

Perhaps it should be 3 patches?

...

> +static int mtk_spi_set_hw_cs_timing(struct spi_device *spi)
> +{
> +       struct mtk_spi *mdata = spi_master_get_devdata(spi->master);
> +       struct spi_delay *cs_setup = &spi->cs_setup;
> +       struct spi_delay *cs_hold = &spi->cs_hold;
> +       struct spi_delay *cs_inactive = &spi->cs_inactive;
> +       u16 setup, hold, inactive;
> +       u32 reg_val;
> +       int delay;
> +
> +       delay = spi_delay_to_ns(cs_setup, NULL);
> +       if (delay < 0)
> +               return delay;
> +       setup = (delay / 1000) * DIV_ROUND_UP(mdata->spi_clk_hz, 1000000);

1000 is NSEC_PER_USEC (here and below)?

> +       delay = spi_delay_to_ns(cs_hold, NULL);
> +       if (delay < 0)
> +               return delay;
> +       hold = (delay / 1000) * DIV_ROUND_UP(mdata->spi_clk_hz, 1000000);
> +
> +       delay = spi_delay_to_ns(cs_inactive, NULL);
> +       if (delay < 0)
> +               return delay;
> +       inactive = (delay / 1000) * DIV_ROUND_UP(mdata->spi_clk_hz, 1000000);

> +       setup    = setup ? setup : 1;
> +       hold     = hold ? hold : 1;
> +       inactive = inactive ? inactive : 1;

All of these can be simplified by using ?: (short ternary) form.

> +       reg_val = readl(mdata->base + SPI_CFG0_REG);
> +       if (mdata->dev_comp->enhance_timing) {
> +               reg_val &= ~(0xffff << SPI_ADJUST_CFG0_CS_HOLD_OFFSET);
> +               reg_val |= (((hold - 1) & 0xffff)
> +                          << SPI_ADJUST_CFG0_CS_HOLD_OFFSET);
> +               reg_val &= ~(0xffff << SPI_ADJUST_CFG0_CS_SETUP_OFFSET);
> +               reg_val |= (((setup - 1) & 0xffff)
> +                          << SPI_ADJUST_CFG0_CS_SETUP_OFFSET);
> +       } else {
> +               reg_val &= ~(0xff << SPI_CFG0_CS_HOLD_OFFSET);
> +               reg_val |= (((hold - 1) & 0xff) << SPI_CFG0_CS_HOLD_OFFSET);
> +               reg_val &= ~(0xff << SPI_CFG0_CS_SETUP_OFFSET);
> +               reg_val |= (((setup - 1) & 0xff)
> +                           << SPI_CFG0_CS_SETUP_OFFSET);
> +       }
> +       writel(reg_val, mdata->base + SPI_CFG0_REG);
> +
> +       reg_val = readl(mdata->base + SPI_CFG1_REG);
> +       reg_val &= ~SPI_CFG1_CS_IDLE_MASK;
> +       reg_val |= (((inactive - 1) & 0xff) << SPI_CFG1_CS_IDLE_OFFSET);
> +       writel(reg_val, mdata->base + SPI_CFG1_REG);
> +
> +       return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko
