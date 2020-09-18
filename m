Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6CA26FE5C
	for <lists+linux-spi@lfdr.de>; Fri, 18 Sep 2020 15:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgIRNZV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Sep 2020 09:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgIRNZV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Sep 2020 09:25:21 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714A2C06174A;
        Fri, 18 Sep 2020 06:25:21 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id j2so6759722ioj.7;
        Fri, 18 Sep 2020 06:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cOHObztW32beB+us9lxdOTM6hiIWQbF1hpxXZ5Zj2hE=;
        b=vB+N5uEw9TXWKlxdcgZ45kxhr5QDpNskBKpgI43QGYGpJ4lBPINfhGT8edIey6oHIz
         Fj7+uubMlqt5A9jihpA4C7OvgRMKnstUMB1FASBBS9go6SfEpmAXUOWukritaESc2xik
         wNKOx969fEV/XynUq5b+yeFP3pv5OZY5xBk/UkCaPA7rI7KuHE0AGzubRFk6XvFGuoSk
         56cq3dMNYL+lrRFpDO3Bi+FRCPewaBDk/9h0pJ7RQsvTn/Yj+TKQOpc1JcWPbltuQs+F
         56NejXQZ29e1K3odx+/T0WwMsU7+FhxVIVFH3OI+i882hmYtBEupxB7TCuSG1rZnuZ64
         8Kjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cOHObztW32beB+us9lxdOTM6hiIWQbF1hpxXZ5Zj2hE=;
        b=Na/Go2vEJuZF9yFT4v/s0U/S2zpc8jHaqhdMZDA4CnRqN+1bu6JvGewixPWog3k+00
         d5+JrO+QjCH6BKrzDb7UOXASycq7v0M9/JnZr/spJiv57vd09fpeWr+m8v8HupRO/8H4
         RsXV8k/J14VShXga7u9ZYQw0DbAwim8UN7dW5/fywvUg7KhqSbAgSy8XeigLO14MkNC/
         Gjw8B/geQqx2yetd744U8hGGrf5bPgyRRA8LVVfZ66G9i3p9Az8k7Wk/hF/NjQCFZRVy
         5wswwlMjj7sshaNcKH3jRryiNDCKCmG/HNUytTbT+M/9wc7gr03y+8DCOSoBc4rPq/un
         BOlg==
X-Gm-Message-State: AOAM531ESn8d6oSNHwB/CJIZ/F8ZZgAavquqs3IXwmC9a0jPwJRxwR6/
        2vHI7RUHgNJE8LUrmNC/CI+1IT/GoPyQ85dMolu2OAd3
X-Google-Smtp-Source: ABdhPJxOAkMyx/UNGHEnrj4wkcfpgwcUHKz1Nc1iVR44vk3TjMz5hthwOt3qELGJ1gx36VXLch8q3Gugf5tlqMT+cig=
X-Received: by 2002:a05:6638:dd3:: with SMTP id m19mr31904250jaj.115.1600435520732;
 Fri, 18 Sep 2020 06:25:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200918083124.3921207-1-ikjn@chromium.org> <20200918162834.v2.3.I06cb65401ab5ad63ea30c4788d26633928d80f38@changeid>
In-Reply-To: <20200918162834.v2.3.I06cb65401ab5ad63ea30c4788d26633928d80f38@changeid>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Fri, 18 Sep 2020 21:25:09 +0800
Message-ID: <CAJsYDVLy_ef25Jb+7QFTUZx0-dcif1RKBGJ8TzQx5t7e2dDLMQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] spi: spi-mtk-nor: use dma_alloc_coherent() for
 bounce buffer
To:     Ikjoon Jang <ikjn@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi!

On Fri, Sep 18, 2020 at 4:35 PM Ikjoon Jang <ikjn@chromium.org> wrote:
>
> Use dma_alloc_coherent() for bounce buffer instead of kmalloc.

The commit message should explain why such a change is
needed. (i.e. why using dma_alloc_coherent here is better
than kmalloc.) And if there's no benefit for this change I'd prefer
leaving it untouched.
I remembered reading somewhere that stream DMA api is
prefered over dma_alloc_coherent for this kind of single-direction
DMA operation.

>
> Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
>
> ---
>
> (no changes since v1)
>
>  drivers/spi/spi-mtk-nor.c | 60 +++++++++++++++++++++++----------------
>  1 file changed, 35 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
> index 54b2c0fde95b..e14798a6e7d0 100644
> --- a/drivers/spi/spi-mtk-nor.c
> +++ b/drivers/spi/spi-mtk-nor.c
> @@ -96,6 +96,7 @@ struct mtk_nor {
>         struct device *dev;
>         void __iomem *base;
>         u8 *buffer;
> +       dma_addr_t buffer_dma;
>         struct clk *spi_clk;
>         struct clk *ctlr_clk;
>         unsigned int spi_freq;
> @@ -275,19 +276,16 @@ static void mtk_nor_setup_bus(struct mtk_nor *sp, const struct spi_mem_op *op)
>         mtk_nor_rmw(sp, MTK_NOR_REG_BUSCFG, reg, MTK_NOR_BUS_MODE_MASK);
>  }
>
> -static int mtk_nor_read_dma(struct mtk_nor *sp, u32 from, unsigned int length,
> -                           u8 *buffer)
> +static int read_dma(struct mtk_nor *sp, u32 from, unsigned int length,

This name is a bit confusing considering there's a mtk_nor_read_dma
below.
As this function now only executes dma readings and wait it to finish,
what about mtk_nor_dma_exec instead?

> +                   dma_addr_t dma_addr)
>  {
>         int ret = 0;
>         ulong delay;
>         u32 reg;
> -       dma_addr_t dma_addr;
>
> -       dma_addr = dma_map_single(sp->dev, buffer, length, DMA_FROM_DEVICE);
> -       if (dma_mapping_error(sp->dev, dma_addr)) {
> -               dev_err(sp->dev, "failed to map dma buffer.\n");
> +       if (WARN_ON((length & MTK_NOR_DMA_ALIGN_MASK) ||
> +                   (dma_addr & MTK_NOR_DMA_ALIGN_MASK)))

These alignment is guaranteed by callers of this function if all
my comments below are addressed. This check isn't needed.

>                 return -EINVAL;
> -       }
>
>         writel(from, sp->base + MTK_NOR_REG_DMA_FADR);
>         writel(dma_addr, sp->base + MTK_NOR_REG_DMA_DADR);
> @@ -312,30 +310,39 @@ static int mtk_nor_read_dma(struct mtk_nor *sp, u32 from, unsigned int length,
>                                          (delay + 1) * 100);
>         }
>
> -       dma_unmap_single(sp->dev, dma_addr, length, DMA_FROM_DEVICE);
>         if (ret < 0)
>                 dev_err(sp->dev, "dma read timeout.\n");
>
>         return ret;
>  }
>
> -static int mtk_nor_read_bounce(struct mtk_nor *sp, u32 from,
> -                              unsigned int length, u8 *buffer)
> +static int mtk_nor_read_dma(struct mtk_nor *sp, u32 from,
> +                           unsigned int length, u8 *buffer)
>  {
> -       unsigned int rdlen;
>         int ret;
> +       dma_addr_t dma_addr;
> +       bool bounce = need_bounce(buffer, length);
>
> -       if (length & MTK_NOR_DMA_ALIGN_MASK)
> -               rdlen = (length + MTK_NOR_DMA_ALIGN) & ~MTK_NOR_DMA_ALIGN_MASK;

The intention of this rdlen alignment is explained in 2/5.
Please make sure this rdlen alignment logic is present
only for PIO reading.

> -       else
> -               rdlen = length;
> +       if (!bounce) {
> +               dma_addr = dma_map_single(sp->dev, buffer, length,
> +                                         DMA_FROM_DEVICE);
> +               if (dma_mapping_error(sp->dev, dma_addr)) {
> +                       dev_err(sp->dev, "failed to map dma buffer.\n");
> +                       return -EINVAL;
> +               }
> +       } else {
> +               dma_addr = sp->buffer_dma;
> +       }
>
> -       ret = mtk_nor_read_dma(sp, from, rdlen, sp->buffer);
> -       if (ret)
> -               return ret;
> +       ret = read_dma(sp, from, length, dma_addr);
>
> -       memcpy(buffer, sp->buffer, length);
> -       return 0;
> +       if (!bounce)
> +               dma_unmap_single(sp->dev, dma_addr, length,
> +                                DMA_FROM_DEVICE);
> +       else
> +               memcpy(buffer, sp->buffer, length);
> +
> +       return ret;
>  }

I think a separated read_dma and read_bounce function will be
cleaner than this if-else implementation:
read_dma:
1. call dma_map_single to get physical address
2. call read_dma to execute operation
3. call dma_unmap_single

read_bounce:
1. align reading length
2. call read_dma
3. call memcpy

>
>  static int mtk_nor_read_pio(struct mtk_nor *sp, const struct spi_mem_op *op)
> @@ -439,11 +446,6 @@ static int mtk_nor_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>                 if (op->data.nbytes == 1) {
>                         mtk_nor_set_addr(sp, op);
>                         return mtk_nor_read_pio(sp, op);
> -               } else if (((ulong)(op->data.buf.in) &
> -                           MTK_NOR_DMA_ALIGN_MASK)) {
> -                       return mtk_nor_read_bounce(sp, op->addr.val,
> -                                                  op->data.nbytes,
> -                                                  op->data.buf.in);
>                 } else {
>                         return mtk_nor_read_dma(sp, op->addr.val,
>                                                 op->data.nbytes,
> @@ -654,6 +656,10 @@ static int mtk_nor_probe(struct platform_device *pdev)
>         sp->dev = &pdev->dev;
>         sp->spi_clk = spi_clk;
>         sp->ctlr_clk = ctlr_clk;

There is extra memory allocation code for sp->buffer in mtk_nor_probe.
If you intend to replace this with dma_alloc_coherent you should
drop those devm_kmalloc code as well.

> +       sp->buffer = dma_alloc_coherent(&pdev->dev, MTK_NOR_BOUNCE_BUF_SIZE,
> +                                       &sp->buffer_dma, GFP_KERNEL);

There's a devm variant: dmam_alloc_coherent(dev, size, dma_handle, gfp)

> +       if (!sp->buffer)
> +               return -ENOMEM;

This spi-nor controller requires all addresses to be 16-byte aligned.
Although it should be guaranteed by a usually way larger page
alignment address from dma_alloc_coherent I'd prefer an explicit
check for address alignment here rather than letting it probe
successfully and fail for every dma_read with bounce buffer.


>
>         irq = platform_get_irq_optional(pdev, 0);
>         if (irq < 0) {
> @@ -674,6 +680,8 @@ static int mtk_nor_probe(struct platform_device *pdev)
>         ret = mtk_nor_init(sp);
>         if (ret < 0) {
>                 kfree(ctlr);
> +               dma_free_coherent(&pdev->dev, MTK_NOR_BOUNCE_BUF_SIZE,
> +                                 sp->buffer, sp->buffer_dma);
>                 return ret;
>         }
>
> @@ -692,6 +700,8 @@ static int mtk_nor_remove(struct platform_device *pdev)
>
>         mtk_nor_disable_clk(sp);
>
> +       dma_free_coherent(&pdev->dev, MTK_NOR_BOUNCE_BUF_SIZE,
> +                         sp->buffer, sp->buffer_dma);
>         return 0;
>  }
>
> --
> 2.28.0.681.g6f77f65b4e-goog
>


--
Regards,
Chuanhong Guo
