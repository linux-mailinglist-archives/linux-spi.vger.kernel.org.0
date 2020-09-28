Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5567527A561
	for <lists+linux-spi@lfdr.de>; Mon, 28 Sep 2020 04:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgI1CTL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 27 Sep 2020 22:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgI1CTL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 27 Sep 2020 22:19:11 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1F4C0613CE
        for <linux-spi@vger.kernel.org>; Sun, 27 Sep 2020 19:19:11 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id k78so1185269vka.10
        for <linux-spi@vger.kernel.org>; Sun, 27 Sep 2020 19:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8r8ZQ9WFem+xMGOEuRI4QXJqsFWB3RpcceUKwYsgmIE=;
        b=UwBVC3kcZ8as2vQq5raFEecalgZi24VjAbQWkvAkqPqSIKs9/Rypej2ZHeDhZue48N
         uwHaCBKHLs+1KCY4qI3wedU96I6Mux+6hJM0PRuASqzFWoIP/oTDzMJcpvPIwW0lTStL
         nLAT/BYP8bBXu3sDR6cZGcmyVQKAKhxyLomq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8r8ZQ9WFem+xMGOEuRI4QXJqsFWB3RpcceUKwYsgmIE=;
        b=ce7uu6CQ1kLce3LiDnHNhBOHt5Sx/8Fix/saKTSXCN5Dx8lB8SMzRHuD8KoxGxs7FD
         a9pIpSN3cQpS647LsBpEXFy01+qfTPFHnD7FQrLyyXsa9b5y+pyB+9CbmuskrwRJZj4O
         ewaG+29A3pnqiwNJlwSAJJDxgRW9tEx8ab/gamtpfEkZa5NQbHgR2fTE+ikEWZQDA3xg
         VuLCvh+SE07KZO3aSw0ou9FUPM0ezQg0m+wfyb70f3sG2MfLpn0EJYKsYJb7A4U5V/DM
         VXUFSw6i3lYS3cze8vipqkAl6GSwar5HOipjCr4xH5MErFbaAvWt0b2+AqeVo/tytbyU
         Pamg==
X-Gm-Message-State: AOAM533ZFKBhPWnC0hc4GljA/YkU46dYhaT8HCk6NJ791JfJnKfDf4PG
        RlJzByWPuM9MXYChGUvanEBXdEqpxrW3Cv8Sk7LGYA==
X-Google-Smtp-Source: ABdhPJzMzVYBekXtY/fDL9QkaeRJXXppiNLoJcZ5OmOeX7nmgFpzlOFVzI+FQV2QY4jYTtNiAJiVdaRJ5Eo/3cOsnr4=
X-Received: by 2002:a1f:fcc2:: with SMTP id a185mr3771112vki.8.1601259549093;
 Sun, 27 Sep 2020 19:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200925065418.1077472-1-ikjn@chromium.org> <20200925145255.v3.5.Id1cb208392928afc7ceed4de06924243c7858cd0@changeid>
 <1601195424.7766.4.camel@mtksdaap41>
In-Reply-To: <1601195424.7766.4.camel@mtksdaap41>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Mon, 28 Sep 2020 10:18:58 +0800
Message-ID: <CAATdQgDP6kd=us35FJ=MWv4KtyATjd_RbEU5ENmBK+Z-m2GnSw@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] spi: spi-mtk-nor: support 36bit dma addressing
To:     Yingjoe Chen <yingjoe.chen@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, Sep 27, 2020 at 4:30 PM Yingjoe Chen <yingjoe.chen@mediatek.com> wrote:
>
> On Fri, 2020-09-25 at 14:54 +0800, Ikjoon Jang wrote:
> > This patch enables 36bit dma address support to spi-mtk-nor.
> > Currently this is enabled only for mt8192-nor.
> >
> > Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  drivers/spi/spi-mtk-nor.c | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
> > index 8dbafee7f431..35205635ed42 100644
> > --- a/drivers/spi/spi-mtk-nor.c
> > +++ b/drivers/spi/spi-mtk-nor.c
> > @@ -78,6 +78,8 @@
> >  #define MTK_NOR_REG_DMA_FADR         0x71c
> >  #define MTK_NOR_REG_DMA_DADR         0x720
> >  #define MTK_NOR_REG_DMA_END_DADR     0x724
> > +#define MTK_NOR_REG_DMA_DADR_HB              0x738
> > +#define MTK_NOR_REG_DMA_END_DADR_HB  0x73c
> >
> >  /* maximum bytes of TX in PRG mode */
> >  #define MTK_NOR_PRG_MAX_SIZE         6
> > @@ -106,6 +108,7 @@ struct mtk_nor {
> >       unsigned int spi_freq;
> >       bool wbuf_en;
> >       bool has_irq;
> > +     bool high_dma;
> >       struct completion op_done;
> >  };
> >
> > @@ -305,6 +308,11 @@ static int mtk_nor_dma_exec(struct mtk_nor *sp, u32 from, unsigned int length,
> >       writel(dma_addr, sp->base + MTK_NOR_REG_DMA_DADR);
> >       writel(dma_addr + length, sp->base + MTK_NOR_REG_DMA_END_DADR);
> >
> > +     if (sp->high_dma) {
> > +             writel(dma_addr >> 32, sp->base + MTK_NOR_REG_DMA_DADR_HB);
> > +             writel((dma_addr + length) >> 32, sp->base + MTK_NOR_REG_DMA_END_DADR_HB);
> > +     }
> > +
>
> Maybe use upper_32_bits() ?

Thanks, good to know that!

>
>
> >       if (sp->has_irq) {
> >               reinit_completion(&sp->op_done);
> >               mtk_nor_rmw(sp, MTK_NOR_REG_IRQ_EN, MTK_NOR_IRQ_DMA, 0);
> > @@ -635,7 +643,8 @@ static const struct spi_controller_mem_ops mtk_nor_mem_ops = {
> >  };
> >
> >  static const struct of_device_id mtk_nor_match[] = {
> > -     { .compatible = "mediatek,mt8173-nor" },
> > +     { .compatible = "mediatek,mt8192-nor", .data = (void *)36 },
> > +     { .compatible = "mediatek,mt8173-nor", .data = (void *)32 },
> >       { /* sentinel */ }
> >  };
> >  MODULE_DEVICE_TABLE(of, mtk_nor_match);
> > @@ -647,6 +656,7 @@ static int mtk_nor_probe(struct platform_device *pdev)
> >       void __iomem *base;
> >       struct clk *spi_clk, *ctlr_clk;
> >       int ret, irq;
> > +     unsigned long dma_bits;
> >
> >       base = devm_platform_ioremap_resource(pdev, 0);
> >       if (IS_ERR(base))
> > @@ -660,6 +670,12 @@ static int mtk_nor_probe(struct platform_device *pdev)
> >       if (IS_ERR(ctlr_clk))
> >               return PTR_ERR(ctlr_clk);
> >
> > +     dma_bits = (unsigned long)of_device_get_match_data(&pdev->dev);
> > +     if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(dma_bits))) {
> > +             dev_err(&pdev->dev, "failed to set dma mask(%lu)\n", dma_bits);
> > +             return -EINVAL;
> > +     }
> > +
>
> As said in previous version. I don't see any place enable high_dma, so I
> think this patch won't set >32bits for anychip. We need something like:
>
>         sp->hidh_dma = dma_bits > 32;
>
> Am I missing anything?

Yeah, you're right, that line disappeared between v2 ~ v3 (by mistake).

>
> Joe.C
>
